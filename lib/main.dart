import 'package:calculator/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _HomePage(),
    );
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage({super.key});

  @override
  State<_HomePage> createState() => __HomePageState();
}

class __HomePageState extends State<_HomePage> {
  var userQuestion = '';
  var userAnswere = '';

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      userQuestion,
                      style: const TextStyle(fontSize: 20),
                    )),
                Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userAnswere,
                      style: const TextStyle(fontSize: 20),
                    ))
              ],
            ),
          ),
          Expanded(
              flex: 2,
              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (context, index) {
                    //clear option
                    if (index == 0) {
                      return MyButtons(
                        Colors.grey,
                        Colors.black,
                        buttons[index],
                        () {
                          setState(() {
                            userQuestion = '';
                            userAnswere = '';
                          });
                        },
                      );
                    }

                    //delete option
                    else if (index == 1) {
                      return MyButtons(Colors.grey, Colors.black, buttons[index],
                          () {
                        setState(() {
                          userQuestion = userQuestion.substring(
                              0, userQuestion.length - 1);
                        });
                      });
                    }

                    // Equal option
                    else if (index == buttons.length - 1) {
                      return MyButtons(
                          Colors.yellow[800], Colors.white, buttons[index], () {
                        setState(() {
                          equalPressed();
                        });
                      });
                    }

                    // rest all options
                    else {
                      return MyButtons(
                          isOperator(buttons[index])
                              ? Colors.yellow[800]
                              : const Color.fromARGB(255, 56, 56, 56),
                          isOperator(buttons[index])
                              ? Colors.white
                              : Colors.white,
                          buttons[index], () {
                        setState(() {
                          userQuestion += buttons[index];
                        });
                      });
                    }
                  }))
        ],
      ),
    );
  }

  bool isOperator(String s) {
    if (s == '%' || s == '/' || s == 'x' || s == '-' || s == '+' || s == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswere = eval.toString();
  }
}
