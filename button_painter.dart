import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;

import 'package:vendor_app/core/utils/app_colors.dart';

class ClickyButton extends StatefulWidget {
  final Duration _duration = const Duration(milliseconds: 100);
  final Widget child;
  final Color color;
  final GestureTapCallback? onPressed;

  const ClickyButton({
    required Key key,
    required this.child,
    this.color = AppColors.primaryColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  _ClickyButtonState createState() => _ClickyButtonState();
}

class _ClickyButtonState extends State<ClickyButton> {
  double _faceLeft = 14.0.w;
  double _faceTop = 0.0;
  double _sideWidth = 14.0.w;
  double _bottomHeight = 14.0.h;
  Curve _curve = Curves.ease;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 126.0.w,
      height: 69.0.h,
      child: GestureDetector(
        onTapDown: widget.onPressed != null ? _pressed : null,
        onTapUp: widget.onPressed != null ? _unPressedOnTapUp : null,
        onTapCancel: widget.onPressed != null ? _unPressed : null,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0.2.h,
              child: Transform(
                origin: Offset(14.w, 0),
                transform: Matrix4.skewY(-0.79),
                child: AnimatedContainer(
                  duration: widget._duration,
                  curve: _curve,
                  width: _sideWidth,
                  height: 55.0.h,
                  color: widget.onPressed != null ? AppColors.primaryColor : Colors.grey,
                ),
              ),
            ),
            Positioned(
              top: 49.0.h,
              left: 5.1.w,
              child: Transform(
                transform: Matrix4.skewX(-0.8),
                child: Transform(
                  origin: Offset(63.w, 10.h),
                  transform: Matrix4.rotationZ(math.pi),
                  child: AnimatedContainer(
                    duration: widget._duration,
                    curve: _curve,
                    width: 130.0,
                    height: _bottomHeight,
                    color: widget.onPressed != null ? AppColors.primaryColor : Colors.grey,
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: widget._duration,
              curve: _curve,
              left: _faceLeft,
              top: _faceTop,
              child: Container(
                alignment: Alignment.center,
                width: 112.0.w,
                height: 55.0.h,
                decoration: BoxDecoration(
                  color: widget.color,
                  border: Border.all(color: widget.onPressed != null ? AppColors.primaryColor : Colors.grey, width: 1),
                ),
                child: widget.child,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _pressed(TapDownDetails details) {
    setState(() {
      _faceLeft = 0.0;
      _faceTop = 14.0.h;
      _sideWidth = 0.0;
      _bottomHeight = 0.0;
    });
    if (widget.onPressed != null) {
      widget.onPressed!();
    }
  }

  void _unPressedOnTapUp(TapUpDetails details) => _unPressed();

  void _unPressed() {
    setState(() {
      _faceLeft = 14.0.w;
      _faceTop = 0.0;
      _sideWidth = 14.0.w;
      _bottomHeight = 14.0.h;
    });
  }
}
