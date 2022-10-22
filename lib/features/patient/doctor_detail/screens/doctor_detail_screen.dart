import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

import '../../../../constants/app_color.dart';
import '../../../../routes/route_name.dart';
import '../widgets/comment_card.dart';

List<Map<String, dynamic>> listInfo = [
  {'image': 'assets/icons/people.svg', 'title': 'patients', 'data': '5.000+'},
  {
    'image': 'assets/icons/experiences.svg',
    'title': 'year experiences',
    'data': '10+'
  },
  {'image': 'assets/icons/star.svg', 'title': 'rating', 'data': '4.8'},
  {'image': 'assets/icons/chat.svg', 'title': 'reviews', 'data': '4.942'},
];

class DoctorDetailSceen extends StatelessWidget {
  const DoctorDetailSceen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroudColor,
      bottomNavigationBar: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
        height: 100,
        decoration: BoxDecoration(
          color: AppColors.backgroudColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.textColor.withOpacity(0.1),
              blurRadius: 10.0,
              offset: const Offset(-5.0, -5.0),
            ),
          ],
        ),
        child: InkWell(
          onTap: () => Get.toNamed(RouteNames.bookAppointmentScreen,
              arguments: "Book Appointment"),
          child: Container(
            width: double.infinity,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.primaryColor1,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: AppColors.textColor.withOpacity(0.1),
                  blurRadius: 10.0,
                  offset: const Offset(5.0, 5.0),
                ),
              ],
            ),
            child: const Text(
              'Book Appointment',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back, color: AppColors.textColor),
        ),
        title: const Text(
          'Dr.Minh Hung',
          style: TextStyle(
              color: AppColors.textColor,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        actions: [
          InkWell(
            onTap: () {},
            child:
                const Icon(Icons.favorite_outline, color: AppColors.textColor),
          ),
          const SizedBox(width: 5),
          InkWell(
            onTap: () {},
            child: const Icon(Icons.more_horiz, color: AppColors.textColor),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: [
          // const SizedBox(height: 10),
          const DoctorCard1(
            image: 'assets/images/doctor2.png',
            name: "Minh Hung",
            title1: "Imonologists",
            title2: "Christ Hospital in London, UK",
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                // Expanded(child: child)
                for (var item in listInfo)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryColor.withOpacity(0.2),
                          ),
                          child: SvgPicture.asset(item['image'],
                              color: AppColors.primaryColor1, height: 30),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item['data'],
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          style: const TextStyle(
                            color: AppColors.primaryColor1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item['title'],
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          style: const TextStyle(
                            color: AppColors.textColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'About me',
                style: TextStyle(
                    color: AppColors.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: ReadMoreText(
              'Doctors, also known as physicians, are licensed health professionals who maintain and restore human health through the practice of medicine. They examine patients, review their medical history, diagnose illnesses or injuries, administer treatment, and counsel patients on their health and well-being.',
              trimLines: 4,
              colorClickableText: Colors.pink,
              trimMode: TrimMode.Line,
              trimCollapsedText: ' Show more',
              trimExpandedText: ' Show less',
              moreStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor1,
              ),
              lessStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor1,
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Working Time',
                style: TextStyle(
                    color: AppColors.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'Monday - Friday, 08:00 AM - 20:00 PM',
              style: TextStyle(color: AppColors.textColor, fontSize: 15),
            ),
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Reviews',
                  style: TextStyle(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                InkWell(
                  onTap: () => Get.toNamed(RouteNames.viewReiviewScreen),
                  child: const Text(
                    'See More',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Column(
            children: const [
              CommentCard(
                name: 'Charolette Hanlin',
                image: 'assets/images/doctor3.png',
                favCount: 629,
                title:
                    'Dr.Jenny is very professional in her work and responsive. I have consulted and my problem is solved.',
                day: 6,
                star: 4,
                checkLike: true,
              ),
              CommentCard(
                name: 'Nguyen Minh Hung',
                image: 'assets/images/doctor2.png',
                favCount: 300,
                title: 'Doctors who are very skilled and fast in service',
                day: 8,
                star: 3,
                checkLike: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DoctorCard1 extends StatelessWidget {
  final String image;
  final String name;
  final String title1;
  final String title2;
  const DoctorCard1({
    Key? key,
    required this.image,
    required this.name,
    required this.title1,
    required this.title2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(10.0),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.backgroudColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.textColor.withOpacity(0.3),
            blurRadius: 10.0,
            offset: const Offset(5.0, 5.0),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(image),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: const TextStyle(
                          color: AppColors.textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                const Divider(color: AppColors.textColor1),
                const SizedBox(height: 2),
                Text(
                  title1,
                  style:
                      const TextStyle(color: AppColors.textColor, fontSize: 12),
                ),
                const SizedBox(height: 10),
                Text(
                  title2,
                  style:
                      const TextStyle(color: AppColors.textColor, fontSize: 12),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
