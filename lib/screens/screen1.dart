import 'package:flutter/material.dart';
import 'package:loginpage/screens/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

const KEY_NAME = 'userLoggedIn';

class Screen1 extends StatefulWidget {
  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  var emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isLoginFormValid = false;

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: AppBar(
        title:const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter the email';
                    } else if (!emailValid.hasMatch(value)) {
                      return 'enter email correctly';
                    } else {
                      return null;
                    }
                  },
                  controller: _emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      labelText: 'Email',
                      prefixIcon:const Icon(Icons.email)),
                ),
                const SizedBox(
                   height: 25.0,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter the password';
                    } else if (value !=null  && value.length < 4) {
                      return 'Too short';
                    } else {
                      return null;
                    }
                  },
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    labelText: 'Password',
                    prefixIcon:const Icon(Icons.lock),
                  ),
                ),
                Visibility(
                  visible: _isLoginFormValid,
                  child:const Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Text(
                      'User not Found',
                      style: TextStyle(color: Colors.red, fontSize: 12.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        loginValidate(context);
                      }
                    },
                    child:const Text('Login'),
                    style: ElevatedButton.styleFrom(
                        padding:const EdgeInsets.symmetric(
                            horizontal: 40.0, vertical: 14.0),
                        shape:const StadiumBorder()),
                  ),
                )
              ]),
        ),
      ),
    );
  }

  //login validatin method
  void loginValidate(BuildContext context) async {
    final _emailId = _emailController.text;
    final _password = _passwordController.text;

    if (_emailId == 'flutter@gmail.com' && _password == '12345') {
      print('login validated successfully');

      final _sharedPrefs = await SharedPreferences.getInstance();
      _sharedPrefs.setBool(KEY_NAME, true);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => HomePage()),
      );
    } else {
      print('Invalid User');
      setState(() {
        _isLoginFormValid = true;
      });
    }
  }
}
