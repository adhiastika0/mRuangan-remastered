import 'package:booking_class_tp_mobile/classroom.dart';
import 'package:booking_class_tp_mobile/profile.dart';
import 'package:booking_class_tp_mobile/schedulepage.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import 'homepage.dart';
import 'main.dart';
import 'requestpage.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(50);

  const MyAppBar({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 5,
      automaticallyImplyLeading: false,
      backgroundColor: customWhite,
      title: Text(
        name,
        style: TextStyle(color: indigoDye, fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Symbols.notifications,
              color: dimGrey,
            )),
        PopupMenuButton(
            icon: Icon(
              Symbols.person,
              color: dimGrey,
            ),
            onSelected: (choice) {
              if (choice == 1) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ProfilePage();
                }));
              } else {
                Navigator.pop(context);
              }
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry>[
                PopupMenuItem(
                    value: 1,
                    child: ListTile(
                      leading: Icon(Symbols.person),
                      title: Text('Profile'),
                    )),
                PopupMenuItem(
                    value: 2,
                    child: ListTile(
                      leading: Icon(Symbols.logout),
                      title: Text('Logout'),
                    )),
              ];
            })
      ],
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPage = 0;
  PageController _pageController = PageController();

  List<String> appbarTitle = ['Home', 'Schedule', 'Request', 'Classroom'];

  void iniState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void changePage(currentIndex) {
    setState(() {
      currentPage = currentIndex;
      _pageController.animateToPage(currentIndex,
          duration: Duration(milliseconds: 600), curve: Curves.easeInOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(name: appbarTitle[currentPage]),
      body: Center(
        child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            children: [
              HomePage(),
              SchedulePage(),
              RequestPage(),
              ClassroomPage()
            ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: indigoDye,
          currentIndex: currentPage,
          onTap: changePage,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                activeIcon: Icon(
                  Symbols.home_filled_rounded,
                  size: 32,
                  fill: 1,
                ),
                icon: Icon(
                  Symbols.home_rounded,
                  size: 32,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                activeIcon: Icon(
                  Symbols.calendar_month_rounded,
                  fill: 1,
                  size: 32,
                ),
                icon: Icon(
                  Symbols.calendar_month_rounded,
                  size: 32,
                ),
                label: 'Schedule'),
            BottomNavigationBarItem(
                activeIcon: Icon(
                  Symbols.mail_rounded,
                  size: 32,
                  fill: 1,
                ),
                icon: Icon(
                  Symbols.mail_outline_rounded,
                  size: 32,
                ),
                label: 'Request'),
            BottomNavigationBarItem(
                activeIcon: Icon(
                  Symbols.domain_rounded,
                  size: 32,
                  weight: 700,
                ),
                icon: Icon(
                  Symbols.domain_rounded,
                  size: 32,
                  weight: 300,
                ),
                label: 'Classroom')
          ]),
    );
  }
}
