import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:jitak_getex/pages/stamp_card.dart';
import 'package:jitak_getex/widgets/custom_snackbar.dart';
import 'package:svg_flutter/svg.dart';

import '../controllers/search_controller.dart';
import '../home.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final HomeController searchScreenController = Get.put(HomeController());
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    initializeDateFormatting('ja_JP');
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    String fetchDate =
        "${currentDate.year}年 ${currentDate.month}月 ${currentDate.day}日（${_getWeekday(currentDate.weekday)}）";
    var gap = SizedBox(
      height: h * 0.028,
    );
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Container(
            height: h * 0.045,
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(w * 0.5)),
            width: w * 0.6,
            child:
                // TextFormField(
                //   decoration: InputDecoration(
                //       contentPadding: EdgeInsets.only(),
                //       border: InputBorder.none,
                //       focusColor: Colors.transparent,
                //       disabledBorder:
                //           OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
                //       enabledBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(20))),
                // ),
                Row(
              children: [
                Text(
                  '  北海道, 札幌市',
                  style: TextStyle(fontSize: w * 0.05),
                ),
              ],
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () {
                  Get.snackbar("近日公開...", "近日公開...",
                      backgroundColor: Color(0xffFFC8AB));
                },
                child: SvgPicture.asset('assets/Filter_icon.svg')),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () {
                  Get.snackbar("近日公開...", "近日公開...",
                      backgroundColor: Color(0xffFFC8AB));
                },
                child: SvgPicture.asset('assets/Vector.svg')),
          ),
          SizedBox(
            width: w * 0.05,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: w,
              height: h * 0.05,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xffFAAA14), Color(0xffFFD78D)])),
              child: Center(
                  child: Text(
                fetchDate,
                style: const TextStyle(fontWeight: FontWeight.w500),
              )),
            ),
            gap,
            SizedBox(
                width: w * 0.9,
                height: h * 0.1,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    // Calculate the date for the current index
                    DateTime currentDate =
                        DateTime.now().add(Duration(days: index));

                    // Format the weekday and date in Japanese
                    String formattedWeekday =
                        DateFormat.E('ja_JP').format(currentDate);
                    String formattedDate = DateFormat.d('ja_JP')
                        .format(currentDate)
                        .substring(0, 2);

                    return Obx(() => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              searchScreenController.selectIndex(index);
                              // setState(() {
                              //   currentIndex = index;
                              // });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: searchScreenController.dateIndex.value ==
                                        index
                                    ? const Color(0xffFAAA14)
                                    : const Color(0xffFAFAFA),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: w * 0.11,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    formattedWeekday,
                                    style: TextStyle(
                                      color: searchScreenController
                                                  .dateIndex.value ==
                                              index
                                          ? const Color(0xffffffff)
                                          : const Color(0xff303030),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Noto Sans JP',
                                    ),
                                  ),
                                  Text(
                                    formattedDate,
                                    style: TextStyle(
                                      color: searchScreenController
                                                  .dateIndex.value ==
                                              index
                                          ? const Color(0xffffffff)
                                          : const Color(0xff303030),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ));
                  },
                )),
            gap,
            Expanded(
              flex: 0,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(const StampCard());
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: double.infinity,
                              child: Container(
                                width: w * 0.8,
                                decoration: BoxDecoration(
                                  color: const Color(0xffFFFFFF),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      height: h * 0.24,
                                      width: w,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10)),
                                          color: Colors.amber,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/happy.png'),
                                              fit: BoxFit.cover)),
                                    ),
                                    gap,
                                    SizedBox(
                                      width: w * 0.8,
                                      child: Text(
                                        '介護有料老人ホームひまわり倶楽部の介護職／ヘ\nルパー求人（パート／バイト）',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: w * 0.035),
                                      ),
                                    ),
                                    gap,
                                    Center(
                                      child: SizedBox(
                                        width: w * 0.8,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.amber.shade100,
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              width: w * 0.38,
                                              height: h * 0.045,
                                              child: Center(
                                                  child: Text(
                                                '介護付き有料老人ホーム',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: w * 0.03,
                                                    color: const Color(
                                                        0xffFAAA14)),
                                              )),
                                            ),
                                            SizedBox(
                                              width: w * 0.2,
                                              child: Text(
                                                '¥ 6,000',
                                                style: TextStyle(
                                                    fontSize: w * 0.055,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    gap,
                                    Center(
                                      child: SizedBox(
                                        width: w * 0.8,
                                        child: Row(
                                          children: [
                                            Text(
                                              '5月 31日（水）08 : 00 ~ 17 : 00',
                                              style: TextStyle(
                                                fontSize: w * 0.037,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: SizedBox(
                                        width: w * 0.8,
                                        child: Row(
                                          children: [
                                            Text(
                                              '北海道札幌市東雲町3丁目916番地17号',
                                              style: TextStyle(
                                                fontSize: w * 0.037,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: SizedBox(
                                        width: w * 0.8,
                                        child: Row(
                                          children: [
                                            Text(
                                              '交通費 300円',
                                              style: TextStyle(
                                                fontSize: w * 0.037,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: SizedBox(
                                        width: w * 0.8,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '住宅型有料老人ホームひまわり倶楽部',
                                              style: TextStyle(
                                                  fontSize: w * 0.037,
                                                  color: Color(0xff30303059)),
                                            ),
                                            SvgPicture.asset(
                                              'assets/Vector.svg',
                                              width: w * 0.07,
                                              color: const Color(0xff30303059),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: h * 0.05,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: h * 0.2,
                          left: 0,
                          child: Container(
                            height: h * 0.034,
                            width: w * 0.28,
                            decoration: BoxDecoration(
                                color: const Color(0xffFF6262),
                                borderRadius: BorderRadius.circular(5)),
                            child: const Center(
                                child: Text(
                              '本日まで',
                              style: TextStyle(color: Color(0xffFFFFFF)),
                            )),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  String _getWeekday(int weekday) {
    switch (weekday) {
      case 1:
        return '月';
      case 2:
        return '火';
      case 3:
        return '水';
      case 4:
        return '木';
      case 5:
        return '金';
      case 6:
        return '土';
      case 7:
        return '日';
      default:
        return '';
    }
  }
}
