import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/bloc/auth_cubit.dart';
import 'package:social_media_app/screens/chat_screen.dart';
import 'package:social_media_app/screens/create_post_screen.dart';
import 'package:social_media_app/screens/posts_screen.dart';
import 'package:social_media_app/screens/sign_in_screen.dart';
import 'package:social_media_app/screens/sign_up_screen.dart';

Future<void> main() async {

  await SentryFlutter.init(
          (options) {
        options.dsn = 'https://d82175c06eec4c26bfa7b45b378816de@o4504629702164480.ingest.sentry.io/4504629705048064';
      },
    // Init your App.
    appRunner: () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      runApp(const MyApp());
    }
  );


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget _buildHomeScreen() {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
      if (snapshot.hasData) {
        return PostsScreen();
    } else {
        return SignInScreen();
      }
  });
}

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        theme: ThemeData.dark(),
        home: _buildHomeScreen(),
        routes: {
          SignInScreen.id: (context) => SignInScreen(),
          SignUpScreen.id: (context) => SignUpScreen(),
          PostsScreen.id: (context) => PostsScreen(),
          CreatePostScreen.id : (context) => CreatePostScreen(),
          ChatScreen.id : (context) => ChatScreen(),
        },
      ),
    );
  }
}
