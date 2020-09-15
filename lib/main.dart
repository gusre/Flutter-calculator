import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Calculator', home: MyCal());
  }
}

class MyCal extends StatefulWidget {
  @override
  Catr createState() => Catr();
}

class Catr extends State<MyCal> {
  var x = [];
  String result = "";
  String expression = "";
  void exp(String expr) {
    String up;
    if (expr == "AC") {
      up = "";
      x = [];
    } else {
      up = expression;
      up += expr;
      if (expr == '+' || expr == '-' || expr == 'x' || expr == '÷')
        x.add(expr.toString());
      else {
        if (x.length == 0)
          x.add(expr.toString());
        else {
          String p =x[x.length-1];
          if (p.length== 1 &&(p == '+' || p == '-' || p == 'x' || p == '÷'))
            x.add(expr.toString());
          else {
            p += expr.toString();
            x[x.length - 1] = p;
          }
        }
      }
    }
    print(up);
    setState(() {
      expression = up;
      result = up;
    });
  }

  void eval() {
    bool xp = true;
    double r = 0;
    String answer = "Invalid expression";
    if (x.length == 1) {
      if (double.tryParse(x[0]) != null)
        r = double.parse(x[0]);
      else
        xp = false;
    } else {
      if (x.length % 2 == 0)
        xp = false;
      else {
        var oprand = [];
        var op = [];
        for (int i = 0; i < x.length; i++) {
          if (i % 2 == 0) {
            if (double.tryParse(x[i]) == null)
              xp = false;
            else {
              oprand.add(double.parse(x[i]));
            }
          } else {
            if (x[i] == "+" || x[i] == "-" || x[i] == "x" || x[i] == "÷")
              op.add(x[i]);
            else
              xp = false;
          }
        }
        if (xp == true) {
          r = oprand[0];
          for (int i = 1; i < oprand.length; i++) {
            switch (op[i - 1]) {
              case "+":
                r = r + oprand[i];
                break;
              case "-":
                r = r - oprand[i];
                break;
              case "x":
                r = r * oprand[i];
                break;
              case "÷":
                r = r / oprand[i];
                break;
            }
          }
        }
      }
    }
    String down;
    if (xp) {
      if(r.truncateToDouble()!=r)
      down = r.toString();
     else 
      down=(r.toInt()).toString();
    } else {
      down = answer;
    }
    setState(() {
      result = down;
    });
  }

  Widget customButton(String txt) {
    return new Container(
      child: new OutlineButton(
          borderSide: BorderSide(
            width: 5.0,
            color: Colors.blue,
            style: BorderStyle.solid,
          ),
          padding: new EdgeInsets.all(24.0),
          color: Colors.purple,
          highlightedBorderColor: Colors.orange,
          child: new Text(
            txt,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          onPressed: () => {exp(txt)}),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Container(
                  width: 400.0,
                  height: 120.0,
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    border: Border.all(width: 5.0, color: Colors.black),
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(
                        expression,
                        style: TextStyle(fontSize: 40.0),
                      ),
                      Text(
                        result,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  )),
              RaisedButton(
                child: Text('Enter'),
                onPressed: () {
                  eval();
                },
              ),
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      customButton("AC"),
                      customButton("."),
                      customButton("0"),
                      customButton("÷"),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      customButton("7"),
                      customButton("8"),
                      customButton("9"),
                      customButton("x"),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      customButton("4"),
                      customButton("5"),
                      customButton("6"),
                      customButton("-"),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      customButton("1"),
                      customButton("2"),
                      customButton("3"),
                      customButton("+"),
                    ],
                  )
                ],
              ),
            ],
          )),
    );
  }
}
