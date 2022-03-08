import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loginpage/screens/screen1.dart';
import './homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    userLoginCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('coming to this page');
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: const Center(
          child: SpinKitFadingCircle(
            color: Color.fromARGB(255, 4, 248, 4),
            size: 50.0,
          ),
        ),
      ),
    );
  }

  Future<void> gotoLogin() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => Screen1()));
  }

  void userLoginCheck() async {
    print('user login');
    final _sharedPrefs = await SharedPreferences.getInstance();
    final _userLogedIn = _sharedPrefs.getBool(KEY_NAME);
    if (_userLogedIn == null || _userLogedIn == false) {
      gotoLogin();
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => HomePage()),
      );
    }
  }
}
