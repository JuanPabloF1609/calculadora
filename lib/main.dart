import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String displaytxt = '0';
  double numOne = 0;
  double numTwo = 0;
  String result = '';
  String finalResult = '0';
  String opr = '';
  String preOpr = '';
  bool oprPressed = false; // Para rastrear si un operador ha sido presionado

  // Botón de la calculadora
  Widget calcbutton(String btntxt, Color btncolor, Color txtcolor) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: ElevatedButton(
          onPressed: () {
            calculation(btntxt);
          },
          child: Text(
            '$btntxt',
            style: TextStyle(
              fontSize: 35,
              color: txtcolor,
            ),
          ),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            backgroundColor: btncolor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'CALCULADORA',
          style: TextStyle(color: Colors.white),
          ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '$text',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 100,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('AC', Colors.grey, Colors.black),
                calcbutton('+/-', Colors.grey[850]!, const Color.fromARGB(255, 255, 255, 0)),
                calcbutton('%', Colors.grey[850]!, const Color.fromARGB(255, 255, 255, 0)),
                calcbutton('/', Colors.grey[850]!, const Color.fromARGB(255, 255, 255, 0)),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('7', Colors.grey[850]!, Colors.white),
                calcbutton('8', Colors.grey[850]!, Colors.white),
                calcbutton('9', Colors.grey[850]!, Colors.white),
                calcbutton('x', Colors.grey[850]!, const Color.fromARGB(255, 255, 255, 0)),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('4', Colors.grey[850]!, Colors.white),
                calcbutton('5', Colors.grey[850]!, Colors.white),
                calcbutton('6', Colors.grey[850]!, Colors.white),
                calcbutton('-', Colors.grey[850]!, const Color.fromARGB(255, 255, 255, 0)),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('1', Colors.grey[850]!, Colors.white),
                calcbutton('2', Colors.grey[850]!, Colors.white),
                calcbutton('3', Colors.grey[850]!, Colors.white),
                calcbutton('+', Colors.grey[850]!, const Color.fromARGB(255, 255, 255, 0)),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: AspectRatio(
                    aspectRatio: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        calculation('0');
                      },
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        backgroundColor: Colors.grey[850],
                      ),
                      child: Text(
                        '0',
                        style: TextStyle(fontSize: 35, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                calcbutton('.', Colors.grey[850]!, Colors.white),
                calcbutton('=', Colors.amber.shade700, Colors.white),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  String text = '0';

  void calculation(String btnText) {
    if (btnText == 'AC') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
      oprPressed = false;
    } else if (btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {
      if (result.isNotEmpty) {
        if (numOne == 0 || oprPressed) {
          numOne = double.tryParse(result) ?? 0.0;
        } else {
          numTwo = double.tryParse(result) ?? 0.0;
          if (opr == '+') {
            finalResult = add();
          } else if (opr == '-') {
            finalResult = sub();
          } else if (opr == 'x') {
            finalResult = mul();
          } else if (opr == '/') {
            finalResult = div();
          }
          numOne = double.parse(finalResult);
          numTwo = 0;
        }
      }
      preOpr = opr;
      opr = btnText;
      result = '';
      oprPressed = btnText != '=';
    } else if (btnText == '%') {
      if (numOne != 0) {
        result = (numOne / 100).toString();
        finalResult = doesContainDecimal(result);
      }
    } else if (btnText == '.') {
      if (!result.contains('.')) {
        result = result + '.';
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      result.startsWith('-') ? result = result.substring(1) : result = '-' + result;
      finalResult = result;
    } else {
      if (result == '0' || oprPressed) {
        result = btnText;
        oprPressed = false;
      } else {
        result = result + btnText;
      }
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    return doesContainDecimal(result);
  }

  String doesContainDecimal(String result) {
    if (result.contains('.')) {
      List<String> splitDecimal = result.split('.');
      if (!(int.parse(splitDecimal[1]) > 0)) {
        return splitDecimal[0];
      }
    }
    return result;
  }
}

