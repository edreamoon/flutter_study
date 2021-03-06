import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/rendering.dart';
void main() => runApp(LoginAlertDemoApp());

class LoginAlertDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Alert',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Login Ale'),
        ),
        body: new LoginHomePage(),
      ),
    );
  }
}

class LoginHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginHomePageState();
  }
}

class _LoginHomePageState extends State<LoginHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _userNameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  bool _showLoading = false;

  Future _loginRequest() async {
    return Future.delayed(Duration(seconds: 3), () {
      print('login success');
    });
  }

  void _toggleSubmit() {
    if (_formKey.currentState.validate()) {
      setState(() {
        _showLoading = true;
      });

      _loginRequest().then((onValue) {
        setState(() {
          _showLoading = false;
        });

        showDialog(
            context: context,
            builder: (context) {
              String alertText = 'login success!' +
                  ' \nuserName:' +
                  _userNameTextController.text +
                  '\npassWord:' +
                  _passwordTextController.text;

              return AlertDialog(content: Text(alertText));
            });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> childrens = [];

    final _mainConatiner = Container(
      padding: EdgeInsets.all(10.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'images/lake.jpg',
              height: 180.0,
              fit: BoxFit.fitHeight,
            ),
            Padding(padding: EdgeInsets.only(top: 50.0)),
            TextFormField(
              decoration: InputDecoration(hintText: 'user name'),
              validator: (value) {
                if (value.isEmpty) return 'pls enter user name';
              },
              controller: _userNameTextController,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'passowrd'),
              validator: (value) {
                if (value.isEmpty) return 'pls enter pwd';
              },
              controller: _passwordTextController,
              obscureText: true,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: RaisedButton(
                onPressed: _toggleSubmit,
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                color: Colors.blue,
              ),
            )
          ],
        ),
      ),
    );

    childrens.add(_mainConatiner);

    final _loadingContainer = Container(
        constraints: BoxConstraints.expand(),
        color: Colors.black12,
        child: Center(
          child: Opacity(
            opacity: 0.9,
            child: SpinKitWave(
              color: Colors.red,
              size: 50.0,
            ),
          ),
        ));
    if (_showLoading) {
      childrens.add(_loadingContainer);
    }
    return Stack(
      children: childrens,
    );
  }
}
