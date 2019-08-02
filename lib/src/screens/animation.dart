import 'package:flutter/material.dart';
import '../widgets/cat.dart';
import 'dart:math';

class animation extends StatefulWidget {
  @override
  _animationState createState() => _animationState();
}

class _animationState extends State<animation> with TickerProviderStateMixin {

  Animation<double> catAnimation;
  AnimationController catController;
  Animation<double> boxAnimation;
  AnimationController boxController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    boxController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    boxAnimation = Tween(begin: pi * 0.6, end: pi * 0.65).animate(
      CurvedAnimation(parent: boxController, curve: Curves.easeInOut),
    );

    boxController.addStatusListener((status){
      if(status==AnimationStatus.completed){
        boxController.reverse();
      }
      else if(status==AnimationStatus.dismissed){
        boxController.forward();
      }
    }
    );
    boxController.forward();

    catController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 200)
    );

    catAnimation = Tween(begin: -35.0, end: -80.0).animate(
      CurvedAnimation(parent: catController, curve: Curves.easeIn),
    );
  }

  onTap() {
    if (catController.status == AnimationStatus.completed) {
      boxController.forward();
      catController.reverse();
    }
    else if (catController.status == AnimationStatus.dismissed) {
      boxController.stop();
      catController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation'),
      ),
      body: GestureDetector(
        child: Center(
          child: Stack(
            overflow: Overflow.visible,
            children: [
              buildCatAnimation(),
              buildBox(),
              buildLeftFlap(),
              buildRightFlap(),
            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {
        return Positioned(
          child: child,
          top: catAnimation.value,
          left: 0,
          right: 0,
        );
      },
      child: Cat(),
    );
  }

  Widget buildBox() {
    return Container(
      width: 200.0,
      height: 200.0,
      color: Colors.blueAccent,
    );
  }

  Widget buildLeftFlap() {
    return Positioned(
      left: 3.0,
      child: AnimatedBuilder(
          animation: boxAnimation,
          builder: (context, child) {
            return Transform.rotate(
              child: child,
              angle: boxAnimation.value,
              alignment: Alignment.topLeft,
            );
          },
          child: Container(
            width: 125,
            height: 10,
            color: Colors.lightGreenAccent,
          ),
      ),
    );
  }

  Widget buildRightFlap() {
    return Positioned(
      right: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        builder: (context, child) {
          return Transform.rotate(
            child: child,
            angle: -boxAnimation.value,
            alignment: Alignment.topRight,
          );
        },
        child: Container(
          width: 125,
          height: 10,
          color: Colors.lightGreenAccent,
        ),
      ),
    );
  }
}


