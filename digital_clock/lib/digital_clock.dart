import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_clock_helper/model.dart';
import 'package:intl/intl.dart';

// <--   Light and Dark mode colors -->
enum _Elements {
  bg,
  cdColor,
  textColor,
}
final _lightTheme = {
  _Elements.bg: Color(0xFF3498db),
  _Elements.cdColor: Color(0xFF74b9ff),
  _Elements.textColor: Color(0xFF2C3A47)
};
final _darkTheme = {
  _Elements.bg: Color(0xFF485460),
  _Elements.cdColor: Color(0xFF1e272e),
  _Elements.textColor: Colors.white
};
//<--            End                  >
// Clock UI code for Flutter Clock Contest
class Clock extends StatefulWidget {
  const Clock(this.model);
  final ClockModel model;
  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  // <---   Date and time fn  --->
  DateTime now = DateTime.now();
  Timer _timer;
  var _pValue;
  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();
  }

  void _updateModel() {
    setState(() {
      // Cause the clock to rebuild when the model changes.
    });
  }
////////////////// FOR time update /////////////////////
  void _updateTime() {
    now = DateTime.now();
    setState(() {
      _timer = Timer(
        Duration(seconds: 1) -
            Duration(seconds: now.second) -
            Duration(milliseconds: now.millisecond),
        _updateTime,
      );
    });
  }
  ////////////// FOR hour % /////////////////////////
  void _perForClokc(n) {
    double a = double.parse(n);
    
    a += 0.30;
   
    setState(() {
      _pValue = ((a / 24) * 100).round();
     
    });
  }
// <--                End                      -->
  @override
  Widget build(BuildContext context) {
    // <--colors seletector and font size  -->
    final colors = Theme.of(context).brightness == Brightness.light
        ? _lightTheme
        : _darkTheme;
    final fontSize = MediaQuery.of(context).size.width / 5.5;
    final textfontSize = MediaQuery.of(context).size.width / 19.5;

    //<---             End                   --->
    // <---Final hour , minutes and seconds  ---->
    final hourForIndicator = DateFormat('HH').format(now);
    final hour =
        DateFormat(widget.model.is24HourFormat ? 'HH' : 'hh').format(now);
    final minute = DateFormat('mm').format(now);
    final date = DateFormat('dd.MM.yyyy').format(now);
    //////////////// _perForClokc to some maths homework haha ////////////
    _perForClokc(hourForIndicator+'.'+minute);
    // <---             End                   --->
    return new MaterialApp(
      home: Scaffold(
        backgroundColor: colors[_Elements.bg],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          color: colors[_Elements.cdColor],
                          elevation: 10,
                          child: Text.rich(TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: hour,
                                style: TextStyle(
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.w700,
                                    color: colors[_Elements.textColor]))
                          ])),
                        ),
                        Text.rich(TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: ' : ',
                              style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.w700,
                                  color: colors[_Elements.cdColor])),
                        ])),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          color: colors[_Elements.cdColor],
                          elevation: 10,
                          child: Text.rich(TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: minute,
                                style: TextStyle(
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.w700,
                                    color: colors[_Elements.textColor]))
                          ])),
                        ),
                      ]),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text.rich(TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: date + ' IS  ',
                          style: TextStyle(
                              fontSize: textfontSize,
                              fontWeight: FontWeight.w900,
                              color: colors[_Elements.textColor]))
                    ])),
                    Column(children: <Widget>[
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colors[_Elements.cdColor],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text.rich(TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: _pValue.toString() + '%',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: colors[_Elements.textColor]))
                            ]))
                          ],
                        ),
                      )
                    ]),
                    Text.rich(TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: ' COMPLETE',
                          style: TextStyle(
                              fontSize: textfontSize,
                              fontWeight: FontWeight.w900,
                              color: colors[_Elements.textColor]))
                    ]))
                  ],
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
