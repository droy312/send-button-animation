import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Send Button Animation',
      debugShowCheckedModeBanner: false,
      home: SendButtonAnimation(),
    );
  }
}

class SendButtonAnimation extends StatefulWidget {
  SendButtonAnimation({Key key}) : super(key: key);

  @override
  _SendButtonAnimationState createState() => _SendButtonAnimationState();
}

class _SendButtonAnimationState extends State<SendButtonAnimation>
    with TickerProviderStateMixin {
  Color black = Color.fromRGBO(40, 40, 40, 1);

  double ratio = 1.0;

  AnimationController animationController;
  AnimationController animationController2;

  Alignment rightArrowAlignment = Alignment.centerLeft;

  double start = 1.0, end = 0.0;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    animationController2 = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: GestureDetector(
          onTapDown: (d) {
            setState(() {
              ratio = 0.9;
            });
          },
          onTapUp: (d) {
            setState(() {
              ratio = 1.0;
              rightArrowAlignment = Alignment.centerRight;
            });
            animationController.forward();
            Timer(Duration(milliseconds: 1000), () => animationController2.forward());
            animationController2.reverse();
          },
          child: Container(
            width: 200 * ratio,
            height: 80 * ratio,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: black,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black38,
                      offset: Offset(0, 10),
                      blurRadius: 20),
                ]),
            child: Stack(
              children: <Widget>[
                FadeTransition(
                  opacity: Tween<double>(begin: start, end: end)
                      .animate(CurvedAnimation(
                    curve: Curves.fastOutSlowIn,
                    parent: animationController,
                  )),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      'Send',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Varela_Round',
                        fontSize: 24 * ratio,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                FadeTransition(
                  opacity: Tween<double>(begin: start, end: end)
                      .animate(CurvedAnimation(
                    curve: Curves.fastOutSlowIn,
                    parent: animationController,
                  )),
                  child: AnimatedContainer(
                    curve: Curves.fastOutSlowIn,
                    duration: Duration(milliseconds: 1000),
                    width: double.infinity,
                    alignment: rightArrowAlignment,
                    child: Icon(Icons.keyboard_arrow_right,
                        color: Colors.white, size: 50),
                  ),
                ),
                FadeTransition(
                  opacity: Tween<double>(begin: end, end: start).animate(
                    CurvedAnimation(
                        curve: Curves.fastOutSlowIn,
                        parent: animationController2),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    alignment: Alignment.center,
                    child:
                        Icon(Icons.check_circle, color: Colors.green, size: 50),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
