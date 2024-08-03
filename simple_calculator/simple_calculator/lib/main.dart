import 'package:flutter/material.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String displayText = '';
  String result = '';
  String operator = '';
  double num1 = 0;
  double num2 = 0;
  bool operatorPressed = false;

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        displayText = '';
        result = '';
        num1 = 0;
        num2 = 0;
        operator = '';
        operatorPressed = false;
      } else if (buttonText == '+' ||
          buttonText == '-' ||
          buttonText == '*' ||
          buttonText == '/') {
        if (!operatorPressed) {
          num1 = double.parse(displayText);
          operator = buttonText;
          operatorPressed = true;
          displayText += buttonText;
        } else {
          num2 = double.parse(displayText.split(operator).last);
          result = calculateResult();
          num1 = double.parse(result);
          operator = buttonText;
          displayText = result + operator;
        }
      } else if (buttonText == '=') {
        if (operatorPressed) {
          num2 = double.parse(displayText.split(operator).last);
          result = calculateResult();
          displayText = result;
          num1 = 0;
          num2 = 0;
          operator = '';
          operatorPressed = false;
        }
      } else {
        displayText += buttonText;
      }
    });
  }

  String calculateResult() {
    double res = 0;
    if (operator == '+') {
      res = num1 + num2;
    } else if (operator == '-') {
      res = num1 - num2;
    } else if (operator == '*') {
      res = num1 * num2;
    } else if (operator == '/') {
      res = num1 / num2;
    }
    return res.toString();
  }

  Widget buildButton(String buttonText, Color color) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(6.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(20.0),
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          onPressed: () => buttonPressed(buttonText),
          child: Text(buttonText, style: TextStyle(fontSize: 24)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculator')),
      body: Container(
        padding: EdgeInsets.all(12.0),
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
              child: Text(displayText,
                  style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
            Row(
              children: <Widget>[
                buildButton('7', Colors.blueGrey),
                buildButton('8', Colors.blueGrey),
                buildButton('9', Colors.blueGrey),
                buildButton('/', Colors.orange),
              ],
            ),
            Row(
              children: <Widget>[
                buildButton('4', Colors.blueGrey),
                buildButton('5', Colors.blueGrey),
                buildButton('6', Colors.blueGrey),
                buildButton('*', Colors.orange),
              ],
            ),
            Row(
              children: <Widget>[
                buildButton('1', Colors.blueGrey),
                buildButton('2', Colors.blueGrey),
                buildButton('3', Colors.blueGrey),
                buildButton('-', Colors.orange),
              ],
            ),
            Row(
              children: <Widget>[
                buildButton('C', Colors.red),
                buildButton('0', Colors.blueGrey),
                buildButton('=', Colors.green),
                buildButton('+', Colors.orange),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
