import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

List<String> words = [
  "anne",
  "siz",
  "hiç",
  "her",
  "kapı",
  "yok",
  "süre",
  "bulunmak",
  "söylemek",
  "beklemek",
  "sevmek",
  "durmak",
  "ülke",
  "büyük",
  "süre",
  "ancak",
  "önemli",
  "hep",
  "aynı",
  "konuşmak",
  "saat",
  "ses",
  "alt",
  "bakmak",
  "şekil",
  "iyi",
  "bulunmak",
  "sarımsak",
  "domates",
  "elma",
  "armut",
  "soğan",
  "greyfurt",
  "baykuş",
  "fil",
  "yarasa",
  "yılan",
  "ne",
  "güzel",
  "küçük",
  "olay",
  "sen",
  "üzerinde",
  "görmek",
  "daha",
  "iyi",
  "onlar",
  "düşmek",
  "çocuk",
  "her",
  "ve",
  "sahip",
  "gerekmek",
  "yüz",
  "su"
];
var trueCounter = 0, falseCounter = 0;
final myController = TextEditingController();
var color = Colors.yellowAccent;
var random = new Random();
var word = words[random.nextInt(words.length)];
var secs = 0;
var resultOpacity = 0.0;
var buttonCount = 0;
double calc = 0;
bool isEnabled = true;
String calculated = "";
String textLabel = "Başlamak için dokun";

void reader(String value) {
  String myVal = value.trim().toLowerCase();
  if (value.contains(" ")) {
    debugPrint(value);
    if (myVal == word) {
      word = words[random.nextInt(words.length)];
      trueCounter++;
      myController.clear();
    } else {
      myController.clear();
      if (value != " ") {
        word = words[random.nextInt(words.length)];
        falseCounter++;
      }
    }
  }
}

void get(String value) {
  for (var i = 0; i < value.length; i++) {
    if (word[i] == value[i]) {
      color = Colors.yellowAccent;
    } else {
      color = Colors.redAccent;
      break;
    }
  }
}

class OnGame extends StatefulWidget {
  OnGame({Key key}) : super(key: key);

  @override
  _OnGameState createState() => _OnGameState();
}

Random randomColor = new Random();
Color colorCode = Colors.lightBlue;

class _OnGameState extends State<OnGame> {
  void colorChanger() {
    Color tmpColor = Color.fromARGB(random.nextInt(256), random.nextInt(256),
        random.nextInt(256), random.nextInt(256));
    setState(() {
      colorCode = tmpColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                word,
                style: TextStyle(
                  color: color,
                  fontSize: 45,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Container(
              width: 100.0,
              child: TextField(
                autocorrect: false,
                cursorColor: color,
                style: new TextStyle(
                  height: 2.0,
                  color: Colors.yellowAccent,
                ),
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.yellowAccent,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    fillColor: color,
                    enabled: isEnabled,
                    labelText: textLabel,
                    labelStyle: TextStyle(
                      color: Colors.yellowAccent,
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0.0,
                        ),
                        borderRadius: new BorderRadius.circular(25.0))),
                controller: myController,
                keyboardType: TextInputType.text,
                onTap: () {
                  textLabel = "Yaz Bakalım!";
                  setState(() {
                    Timer timer =
                        new Timer.periodic(new Duration(seconds: 1), (time) {
                      secs++;
                      if (secs > 60) {
                        isEnabled = false;
                        time.cancel();
                        resultOpacity = 1.0;
                        calc = ((trueCounter /
                                ((trueCounter + falseCounter) * 100)) *
                            10000);
                        calc = calc.truncateToDouble();
                      }
                    });
                  });
                },
                onChanged: (value) {
                  buttonCount += value.length;
                  setState(() {
                    reader(value);
                    get(value);
                  });
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Opacity(
              opacity: resultOpacity,
              child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1),
                  height: MediaQuery.of(context).size.height * 0.5,
                  color: Colors.transparent,
                  child: Column(
                    children: <Widget>[
                      Text(calculated = "Doğruluk Oranı : %" + calc.toString(),
                          style: TextStyle(
                              color: Colors.yellowAccent, fontSize: 16)),
                      Text("Basılan tuş sayısı : " + buttonCount.toString(),
                          style: TextStyle(
                              color: Colors.yellowAccent, fontSize: 16)),
                      Text("Doğru sayısı : " + trueCounter.toString(),
                          style: TextStyle(
                              color: Colors.yellowAccent, fontSize: 16)),
                      Text("Yanlış sayısı : " + falseCounter.toString(),
                          style: TextStyle(
                              color: Colors.yellowAccent, fontSize: 16)),
                      IconButton(
                          icon: Icon(
                            Icons.replay,
                            color: Colors.yellowAccent,
                            size: 35,
                          ),
                          onPressed: () {
                            setState(() {
                              newGame();
                            });
                          })
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class MyBody extends StatefulWidget {
  MyBody({Key key}) : super(key: key);

  @override
  _MyBodyState createState() => _MyBodyState();
}

class _MyBodyState extends State<MyBody> {
  @override
  Widget build(BuildContext context) {
    return Center(child: OnGame());
  }
}

void newGame() {
  myController.clear();
  resultOpacity = 0.0;
  calc = 0;
  textLabel = "Başlamak için dokun";
  calculated = "";
  buttonCount = 0;
  trueCounter = 0;
  falseCounter = 0;
  isEnabled = true;
  secs = 0;
}
