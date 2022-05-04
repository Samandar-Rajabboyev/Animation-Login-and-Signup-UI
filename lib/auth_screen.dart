import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_register_ui_animation/constants.dart';
import 'package:login_register_ui_animation/widgets/login_form.dart';
import 'package:login_register_ui_animation/widgets/sign_up_form.dart';
import 'package:login_register_ui_animation/widgets/socal_buttons.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  bool isShoxSignUp = false;

  late AnimationController _animatedController;
  late Animation<double> _animationTextRotate;

  void setUpAnimation() {
    _animatedController =
        AnimationController(vsync: this, duration: defaultDuration);

    _animationTextRotate =
        Tween<double>(begin: 0, end: 90).animate(_animatedController);
  }

  void updateView() {
    setState(() {
      isShoxSignUp = !isShoxSignUp;
    });

    isShoxSignUp
        ? _animatedController.forward()
        : _animatedController.reverse();
  }

  @override
  void initState() {
    setUpAnimation();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _animatedController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedBuilder(
          animation: _animatedController,
          builder: (context, constraints) {
            return Stack(
              children: [
                // Login
                AnimatedPositioned(
                  duration: defaultDuration,
                  width: _size.width * 0.88,
                  height: _size.height,
                  left: isShoxSignUp ? -_size.width * 0.76 : 0,
                  child: Container(
                    color: login_bg,
                    child: LoginForm(),
                  ),
                ),

                //Sign up
                AnimatedPositioned(
                  duration: defaultDuration,
                  left: isShoxSignUp ? _size.width * 0.12 : _size.width * 0.88,
                  width: _size.width * 0.88,
                  height: _size.height,
                  child: Container(
                    color: signup_bg,
                    child: SignUpForm(),
                  ),
                ),
                AnimatedPositioned(
                  duration: defaultDuration,
                  top: _size.height * 0.1,
                  left: 0,
                  right:
                      isShoxSignUp ? -_size.height * 0.06 : _size.height * 0.06,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white60,
                    child: AnimatedSwitcher(
                      duration: defaultDuration,
                      child: isShoxSignUp
                          ? SvgPicture.asset(
                              'assets/animation_logo.svg',
                              color: signup_bg,
                            )
                          : SvgPicture.asset(
                              'assets/animation_logo.svg',
                              color: login_bg,
                            ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: defaultDuration,
                  width: _size.width,
                  right: isShoxSignUp
                      ? -_size.height * 0.025
                      : _size.height * 0.025,
                  bottom: _size.height * 0.1,
                  child: SocalButtns(),
                ),

                AnimatedPositioned(
                    duration: defaultDuration,
                    bottom: isShoxSignUp
                        ? _size.height / 2 - 80
                        : _size.height * 0.3,
                    left: isShoxSignUp ? 0 : _size.width * 0.44 - 80,
                    child: AnimatedDefaultTextStyle(
                      duration: defaultDuration,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: isShoxSignUp ? 20 : 32,
                          fontWeight: FontWeight.bold,
                          color: isShoxSignUp ? Colors.white : Colors.white70),
                      child: Transform.rotate(
                        alignment: Alignment.topLeft,
                        angle: -_animationTextRotate.value * pi / 180,
                        child: InkWell(
                          onTap: () {
                            if (isShoxSignUp) {
                              updateView();
                            } else {
                              // Log in
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: defpaultPadding * 0.75),
                            width: 160,
                            child: Text(
                              'Log in'.toUpperCase(),
                            ),
                          ),
                        ),
                      ),
                    )),
                AnimatedPositioned(
                    duration: defaultDuration,
                    bottom: !isShoxSignUp
                        ? _size.height / 2 - 80
                        : _size.height * 0.3,
                    right: isShoxSignUp ? _size.width * 0.44 - 80 : 0,
                    child: AnimatedDefaultTextStyle(
                      duration: defaultDuration,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: !isShoxSignUp ? 20 : 32,
                          fontWeight: FontWeight.bold,
                          color: !isShoxSignUp ? Colors.white : Colors.white70),
                      child: Transform.rotate(
                        alignment: Alignment.topRight,
                        angle: (90 - _animationTextRotate.value) * pi / 180,
                        child: InkWell(
                          onTap: () {
                            if (isShoxSignUp) {
                              // Sign up
                            } else {
                              updateView();
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: defpaultPadding * 0.75),
                            width: 160,
                            child: Text(
                              'Sign Up'.toUpperCase(),
                            ),
                          ),
                        ),
                      ),
                    )),
              ],
            );
          }),
    );
  }
}
