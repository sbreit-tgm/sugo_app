import 'package:sugo_app/blocs/home_page_bloc.dart';
import 'package:sugo_app/blocs/date_utils.dart';
import 'package:sugo_app/radial_progress.dart';
import 'package:sugo_app/themes/colors.dart';
import 'package:sugo_app/top_bar.dart';
import 'package:sugo_app/footer.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());
int futter=0;
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness App',
      theme: appTheme,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  HomePageBloc _homePageBloc;
  AnimationController _iconAnimationController;

  @override
  void initState() {
    _homePageBloc = HomePageBloc();
    _iconAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    super.initState();
  }

  @override
  void dispose() {
    _homePageBloc.dispose();
    _iconAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:

      Stack(

        children: <Widget>[

          Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  TopBar(),


                  Positioned(
                    top: 60.0,
                    left: 0.0,
                    right: 0.0,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 35.0,
                          ),
                          onPressed: () {
                            _homePageBloc.subtractDate();
                          },
                        ),
                        StreamBuilder(
                          stream: _homePageBloc.dateStream,
                          initialData: _homePageBloc.selectedDate,
                          builder: (context, snapshot) {
                            return Expanded(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    formatterDayOfWeek.format(snapshot.data),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24.0,
                                        color: Colors.white,
                                        letterSpacing: 1.2),
                                  ),
                                  Text(
                                    formatterDate.format(snapshot.data),
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      letterSpacing: 1.3,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        Transform.rotate(
                          angle: 135.0,
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 35.0,
                            ),
                            onPressed: () {
                              _homePageBloc.addDate();
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Container(
                // Placholder
              height: 200.0,
               width: 200.0,),
              RadialProgress(),

            ],

          ),
          //Footer(),


        ],
      ),

        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Container(
            height: 100.0,
          ),
        ),
        floatingActionButton: Container(
          height: 100.0,
          width: 100.0,


          child: FittedBox(

            child: FloatingActionButton(onPressed: () {},tooltip: 'Increment Counter',
              child: Icon(Icons.add),),
          ),
        )
          ,floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void onIconPressed() {
    animationStatus
        ? _iconAnimationController.reverse()
        : _iconAnimationController.forward();
  }

  bool get animationStatus {
    final AnimationStatus status = _iconAnimationController.status;
    return status == AnimationStatus.completed;
  }
}


