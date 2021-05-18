import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_chatter/repository/authentication_repository.dart';
import 'package:flutter_firebase_chatter/ui/screen/app/app.dart';
import 'package:flutter_firebase_chatter/theme.dart';
import 'package:flutter_firebase_chatter/ui/screen/home/home.dart';
import 'package:flutter_firebase_chatter/ui/screen/login/login.dart';
import 'package:flutter_firebase_chatter/ui/screen/signUp/sign_up.dart';
import 'package:flutter_firebase_chatter/ui/screen/splash/splash_page.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required AuthenticationRepository authenticationRepository,
  })   : _authenticationRepository = authenticationRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (_) => AppBloc(
          authenticationRepository: _authenticationRepository,
        ),
        child: AppView(),
      ),
    );
  }
}


class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {

  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      navigatorKey: _navigatorKey,
      theme: theme,
      builder: (ctx,child){
        return BlocListener<AppBloc,AppState>(
          listener: (ctx, state) {
            switch(state.status){
              case AppStatus.authenticated:
                log('authenticated');
                _navigator.pushAndRemoveUntil<void>(
                  HomePage.route(),
                      (route) => false,
                );
                break;
              case AppStatus.unauthenticated:
                log('unauthenticated');
                _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                      (route) => false,
                );
                break;
              default:
                break;
            }
          },
            child: child
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
