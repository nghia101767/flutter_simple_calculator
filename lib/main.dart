import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(Calculator());

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Simple Calculator",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  State<SimpleCalculator> createState() => _SimpleCalculator();
}

class _SimpleCalculator extends State<SimpleCalculator> {
  String result = "0";
  String equation = "0";
  String expression = "";
  double equationFontSize = 38;
  double resultFontSize = 48;
  _buttonPress(String value) {
    setState(() {
      switch (value) {
        case "C":
          equation = "0";
          result = "0";
          equationFontSize = 38;
          resultFontSize = 48;
          break;
        case "⨞":
          equationFontSize = 48;
          resultFontSize = 38;
          equation = equation.substring(0, equation.length - 1);
          if (equation.length == 0) {
            equation = "0";
          }
          break;
        case "=":
          equationFontSize = 38;
          resultFontSize = 48;
          expression = equation;
          expression = expression.replaceAll("×", "*");
          expression = expression.replaceAll("÷", "/");
          try {
            Parser parser = Parser();
            Expression exp = parser.parse(expression);
            ContextModel cm = ContextModel();
            result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          } catch (e) {}
          break;
        default:
          equationFontSize = 48;
          resultFontSize = 38;
          switch (equation) {
            case "0":
              equation = value;
              break;
            default:
              equation = equation + value;
          }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Calculator"),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(equation,
                maxLines: 3, style: TextStyle(fontSize: equationFontSize)),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(result,
                maxLines: 3, style: TextStyle(fontSize: resultFontSize)),
          ),
          Expanded(child: Divider()),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              child: Table(children: [
                TableRow(children: [
                  CalculatorButton(
                    text: "C",
                    height: 1,
                    onPressed: _buttonPress,
                    color: Colors.redAccent,
                  ),
                  CalculatorButton(
                    text: "⨞",
                    height: 1,
                    onPressed: _buttonPress,
                    color: Colors.blue,
                  ),
                  CalculatorButton(
                    text: "÷",
                    height: 1,
                    onPressed: _buttonPress,
                    color: Colors.blue,
                  ),
                ]),
                TableRow(children: [
                  CalculatorButton(
                    text: "1",
                    height: 1,
                    onPressed: _buttonPress,
                    color: Colors.black54,
                  ),
                  CalculatorButton(
                    text: "2",
                    height: 1,
                    onPressed: _buttonPress,
                    color: Colors.black54,
                  ),
                  CalculatorButton(
                    text: "3",
                    height: 1,
                    onPressed: _buttonPress,
                    color: Colors.black54,
                  ),
                ]),
                TableRow(children: [
                  CalculatorButton(
                    text: "4",
                    height: 1,
                    onPressed: _buttonPress,
                    color: Colors.black54,
                  ),
                  CalculatorButton(
                    text: "5",
                    height: 1,
                    onPressed: _buttonPress,
                    color: Colors.black54,
                  ),
                  CalculatorButton(
                    text: "6",
                    height: 1,
                    onPressed: _buttonPress,
                    color: Colors.black54,
                  ),
                ]),
                TableRow(children: [
                  CalculatorButton(
                    text: "7",
                    height: 1,
                    onPressed: _buttonPress,
                    color: Colors.black54,
                  ),
                  CalculatorButton(
                    text: "8",
                    height: 1,
                    onPressed: _buttonPress,
                    color: Colors.black54,
                  ),
                  CalculatorButton(
                    text: "9",
                    height: 1,
                    onPressed: _buttonPress,
                    color: Colors.black54,
                  ),
                ]),
                TableRow(children: [
                  CalculatorButton(
                    text: ".",
                    height: 1,
                    onPressed: _buttonPress,
                    color: Colors.black54,
                  ),
                  CalculatorButton(
                    text: "0",
                    height: 1,
                    onPressed: _buttonPress,
                    color: Colors.black54,
                  ),
                  CalculatorButton(
                    text: "00",
                    height: 1,
                    onPressed: _buttonPress,
                    color: Colors.black54,
                  ),
                ]),
              ]),
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(children: [
                  TableRow(children: [
                    CalculatorButton(
                        text: "×",
                        onPressed: _buttonPress,
                        color: Colors.blue,
                        height: 1),
                  ]),
                  TableRow(children: [
                    CalculatorButton(
                        text: "-",
                        onPressed: _buttonPress,
                        color: Colors.blue,
                        height: 1),
                  ]),
                  TableRow(children: [
                    CalculatorButton(
                        text: "+",
                        onPressed: _buttonPress,
                        color: Colors.blue,
                        height: 1),
                  ]),
                  TableRow(children: [
                    CalculatorButton(
                        text: "=",
                        onPressed: _buttonPress,
                        color: Colors.redAccent,
                        height: 2),
                  ]),
                ])),
          ])
        ],
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  const CalculatorButton({
    Key key,
    this.text,
    this.onPressed,
    this.color,
    this.height,
  }) : super(key: key);
  final String text;
  final Function onPressed;
  final Color color;
  final int height;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      height: MediaQuery.of(context).size.height * 0.1 * height,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: BorderSide(
              color: Colors.white, width: 1, style: BorderStyle.solid),
        ),
        padding: EdgeInsets.all(16),
        onPressed: () {
          onPressed(text);
        },
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.normal, fontSize: 30),
        ),
      ),
    );
  }
}
