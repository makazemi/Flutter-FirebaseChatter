
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_chatter/ui/screen/app/app.dart';

import 'package:flutter_firebase_chatter/ui/screen/home/home.dart';
import 'package:flutter_firebase_chatter/ui/screen/login/login.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  log("state=$state");
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
    default:
      return [LoginPage.page()];
  }
}
