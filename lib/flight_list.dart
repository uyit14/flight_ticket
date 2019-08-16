import 'package:flutter/material.dart';

import 'CustomShapeClipper.dart';
import 'main.dart';

final Color discountBackgroundColor = Color(0xFFFFE08D);
final Color flightBorderColor = Color(0xFFE6E6E6);
final Color chipBackgroundColor = Color(0xFFF6F6F6);

class InheritedFlightListing extends InheritedWidget{
  final fromLocation, toLocation;


  InheritedFlightListing({this.fromLocation, this.toLocation, Widget child}) : super(child : child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static InheritedFlightListing of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(InheritedFlightListing);
}

class FlightListingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search result"),
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            FlightListTopPart(),
            SizedBox(
              height: 20,
            ),
            FlightListBottomPart()
          ],
        ),
      ),
    );
  }
}

class FlightListTopPart extends StatelessWidget {
  final fromLocation, toLocation;
  FlightListTopPart({this.fromLocation, this.toLocation});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            height: 160,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [firstColors, secondColor])),
          ),
        ),
        Card(
          margin: EdgeInsets.fromLTRB(16, 20, 16, 0),
          elevation: 10,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${InheritedFlightListing.of(context).fromLocation}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Divider(
                        color: Colors.grey,
                        height: 20,
                      ),
                      Text(
                        '${InheritedFlightListing.of(context).toLocation}',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Spacer(),
                Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.import_export,
                      color: Colors.black,
                      size: 32,
                    ))
              ],
            ),
          ),
        )
      ],
    );
  }
}

class FlightListBottomPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Best deal for next 6 months",
            style: dropDownPopUpMenuStyle,
          ),
          SizedBox(
            height: 10,
          ),
          ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              FlightCard(),
              FlightCard(),
              FlightCard(),
              FlightCard(),
              FlightCard(),
              FlightCard(),
            ],
          )
        ],
      ),
    );
  }
}

class FlightCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.grey[400])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      '${formatCurrency.format(4159)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      "(${formatCurrency.format(9999)})",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey),
                    ),
                  ],
                ),
                Wrap(
                  children: <Widget>[
                    FlightDetailChip(Icons.calendar_today, "June 2019"),
                    SizedBox(
                      width: 4,
                    ),
                    FlightDetailChip(Icons.flight_takeoff, "Jet Ariways"),
                    SizedBox(
                      width: 4,
                    ),
                    FlightDetailChip(Icons.star, "4.4")
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: 2,
            right: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                "55%",
                style: TextStyle(
                    color: appTheme.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              decoration: BoxDecoration(
                  color: discountBackgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
            ),
          )
        ],
      ),
    );
  }
}

class FlightDetailChip extends StatelessWidget {
  final IconData iconData;
  final String label;

  FlightDetailChip(this.iconData, this.label);

  @override
  Widget build(BuildContext context) {
    return RawChip(
      label: Text(label),
      labelStyle: TextStyle(color: Colors.black, fontSize: 14),
      backgroundColor: Colors.grey[200],
      avatar: Icon(
        iconData,
        size: 14,
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
    );
  }
}
