import 'package:flutter/material.dart';
import 'dart:async';

import 'package:notifications/notifications.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // TODO: Asyncronous update
  // List<NotificationEvent> _data = new List();

  // @override
  // void initState() {
  //   super.initState();
  //   initPlatformState();
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  // // Platform messages are asynchronous, so we initialize in an async method.
  // Future<void> initPlatformState() async {
  //   Notifications notifications = new Notifications();
  //   StreamSubscription<NotificationEvent> events;
  //   events = notifications.noiseStream.listen(onData);
  // }

  // void onData(NotificationEvent event) {
  //   print(event.toString());
  //   _data.add(event);
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NotifyMe',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: new NotificationList(),
    );
  }
}

class NotificationList extends StatefulWidget {
  @override
  NotificationListState createState() => new NotificationListState();
}

class NotificationListState extends State<NotificationList> {
  final List<NotificationEvent> _notification = <NotificationEvent>[];

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('NotifyMe'),
      ),
      body: Center(
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemBuilder: (BuildContext context, int i) {
            // Add a one-pixel-high divider widget before each row
            // in the ListView.
            if (i.isOdd) return Divider();

            // This calculates the actual number of items
            // in the ListView, minus the divider widgets.
            final int index = i ~/ 2;
            
            return _buildRow(_notification[index]);
          },
          itemCount: _notification.length,
        ),
      ),
    );
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    Notifications notifications = new Notifications();
    StreamSubscription<NotificationEvent> events;
    events = notifications.noiseStream.listen(onData);
  }

  void onData(NotificationEvent event) {
    print(event.toString());
    _notification.add(event);
  }

  Widget _buildRow(NotificationEvent notificationItem) {
    return ListTile(
      title: Text(notificationItem.packageName),
      subtitle: Text(notificationItem.timeStamp.toString()),
    );
  }
}
