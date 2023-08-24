import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../utils/utils.dart';

/// A widget that displays a button for switching to the previous or next month.
class EasyMonthSwitcher extends StatefulWidget {
  const EasyMonthSwitcher({
    super.key,
    required this.locale,
    required this.value,
    this.onMonthChange,
    this.style,
  });

  /// A `String` that represents the locale code to use for formatting the month name in the switcher.
  final String locale;

  /// The currently selected month.
  final EasyMonth? value;

  /// A callback function that is called when the selected month changes.
  final OnMonthChangeCallBack? onMonthChange;

  /// The text style applied to the month string.
  final TextStyle? style;

  @override
  State<EasyMonthSwitcher> createState() => _EasyMonthSwitcherState();
}

class _EasyMonthSwitcherState extends State<EasyMonthSwitcher> {
  List<EasyMonth> _yearMonths = [];
  int _currentMonth = 0;
  @override
  void initState() {
    super.initState();
    _yearMonths = EasyDateUtils.getYearMonths(DateTime.now(), widget.locale);
    _currentMonth = widget.value != null ? ((widget.value!.vale - 1)) : 0;
  }

  bool get _isLastMonth => _currentMonth == _yearMonths.length - 1;
  bool get _isFirstMonth => _currentMonth == 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Expanded(
      child: Container(
        // width: screenWidth,
        height: screenWidth * 0.15,
        // padding: const EdgeInsets.symmetric(horizontal: 10),

        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: const Color(0xffEFEEF3),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: IconButton(
                onPressed: () {
                  if (_isFirstMonth) {
                    return;
                  }
                  _currentMonth--;
                  widget.onMonthChange?.call(_yearMonths[_currentMonth]);
                },
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: _isFirstMonth ? Colors.grey : null,
                ),
              ),
            ),
            // const Spacer(),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  _yearMonths[_currentMonth].name,
                  textAlign: TextAlign.center,
                  style: widget.style,
                ),
              ),
            ),
            // const Spacer(),
            Flexible(
              child: IconButton(
                onPressed: () {
                  if (_isLastMonth) {
                    return;
                  }
                  _currentMonth++;
                  widget.onMonthChange?.call(_yearMonths[_currentMonth]);
                },
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: _isLastMonth ? Colors.grey : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    // SizedBox(
    //   width: screenWidth,

    // );
  }
}
