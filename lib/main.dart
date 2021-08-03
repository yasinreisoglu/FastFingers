import 'package:fast_fingers/gameScreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home',
      routes: {
        '/home': (context) => MainPage(),
        '/game': (context) => GameScreen(),
      },
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key key}) : super(key: key);

  createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: <Widget>[
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                elevation: 5.0,
                child: Text("peki"),
              ),
            ],
            title: Text("Nasıl oynanır ?"),
            content: Text("Oyun sayfasındaki yazıyı yazmaya başladığınızda 60 saniyeniz başlar, süre bitiminde sonuçlarınız ekranın alt kısmına yazılır."),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Fast Fingers",
              style: TextStyle(
                color: Colors.yellow,
                fontSize: 30.0,
                wordSpacing: 5.0,
                letterSpacing: 1.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          RaisedButton(
            elevation: 0,
            onPressed: () {
              Navigator.pushNamed(context, '/game');
            },
            child: Icon(
              Icons.play_arrow,
              size: 150,
              color: Colors.yellowAccent,
            ),
            color: Colors.transparent,
          ),
          RaisedButton(
            elevation: 0,
            onPressed: () {
              createAlertDialog(context);
            },
            child: Icon(
              Icons.info_outline,
              size: 25,
              color: Colors.yellowAccent,
            ),
            color: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
