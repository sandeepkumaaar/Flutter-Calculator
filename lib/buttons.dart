import 'package:flutter/material.dart';

class MyButtons extends StatelessWidget {
  final color;
  final textColor;
  final String btnText;
  final btnTapped;

  MyButtons(this.color, this.textColor, this.btnText, this.btnTapped);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: btnTapped,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                btnText,
                style: TextStyle(color: textColor, fontSize: 25),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
