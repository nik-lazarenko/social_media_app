

import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String userName;
  final String userID;
  final String message;
  final Timestamp timestamp;

  ChatModel({
    required this.userName,
    required this.timestamp,
    required this.message,
    required this.userID,
});
}