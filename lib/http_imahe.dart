import 'dart:typed_data';

import 'package:http/http.dart';

class HttRequestImage {
  Future<Uint8List> getImage(int width, int height) async {
    try {
      var responce =
          await get(Uri.parse('https://picsum.photos/$width/$height'));
      if (responce.statusCode == 200) {
        return responce.bodyBytes;
      } else {
        return Future.error('Error');
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
