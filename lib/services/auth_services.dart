import 'dart:convert';

import 'package:clinic_manager/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../constants/api_link.dart';
import '../constants/error_handing.dart';
import '../models/user.dart';
import '../routes/route_name.dart';

class AuthService extends ChangeNotifier {
  AuthService._privateConstructor();
  static final AuthService instance = AuthService._privateConstructor();
  // ignore: prefer_final_fields
  User _user = User(
    name: '',
    email: '',
    password: '',
    address: '',
    type: '',
    id: '',
    token: '',
    gender: '',
    phoneNumber: '',
    dateBorn: DateTime.now(),
  );
  User get user => _user;
  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  bool get isLogin => user.id == '' ? false : true;

  Future<bool> getUserData() async {
    print('Get user data function');
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      var tokenRes = await http.post(
        Uri.parse('${ApiLink.uri}/api/validToken'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!,
        },
      );
      var response = jsonDecode(tokenRes.body);
      if (response["check"]) {
        setUser(tokenRes.body);
        return true;
      }
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      Get.offAllNamed(RouteNames.introScreen);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signIn(
      {required BuildContext context,
      required String email,
      required String password,
      required VoidCallback updataLoading}) async {
    try {
      http.Response res = await http.post(
        Uri.parse(
          '${ApiLink.uri}/api/signin',
        ),
        body: jsonEncode(
          {
            'email': email,
            'password': password,
          },
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(res.body);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          // ignore: use_build_context_synchronously
          AuthService.instance.setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          Get.offAllNamed(RouteNames.dashboardScreen);
        },
      );
    } catch (e) {
      updataLoading();
    }
    updataLoading();
  }

  void editProfile({
    required String name,
    required String email,
    required String gender,
    required String phoneNumber,
    required String address,
    required var dateBorn,
    required VoidCallback callBack,
    required BuildContext context,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse(
          '${ApiLink.uri}/api/editProfile',
        ),
        body: jsonEncode({
          'email': email,
          'name': name,
          'gender': gender,
          'phoneNumber': phoneNumber,
          'dateBorn': dateBorn,
          'address': address,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(res.body);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          AuthService.instance.setUser(res.body);
          callBack();
        },
      );
    } catch (e) {
      callBack();
    }
  }

  void changePassWord(
      {required String password,
      required String newPassword,
      required BuildContext context,
      required VoidCallback callBack}) async {
    try {
      http.Response res = await http.post(
        Uri.parse(
          '${ApiLink.uri}/api/changePassword',
        ),
        body: jsonEncode({
          'email': AuthService.instance.user.email,
          'password': password,
          'newPassword': newPassword,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(res.body);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          AuthService.instance.setUser(res.body);
          callBack();
        },
      );
    } catch (e) {
      callBack();
    }
    callBack();
  }
}

  // var response = jsonDecode(tokenRes.body);
      // if (response == true) {
      //   http.Response userRes = await http.get(
      //     Uri.parse("https://clinical-management-nmcnpm.herokuapp.com/getUser"),
      //     headers: <String, String>{
      //       'Content-Type': 'application/json; charset=UTF-8',
      //       'x-auth-token': token,
      //     },
      //   );
      //   print(userRes.body);
      //   // ignore: use_build_context_synchronously
      //   setUser(userRes.body);
      //   return false;
      // }