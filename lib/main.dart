import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(
    MaterialApp(
      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  XFile? image;
  File? file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Convert to Base64"),
              onPressed: toBase64Image,
            ),
            ElevatedButton(
              child: Text("Capture & Show Image"),
              onPressed: captureImage,
            ),
            ElevatedButton(
              child: Text("Pick & Show Image"),
              onPressed: pickImage,
            ),
            image == null
                ? Container()
                : Container(
                    height: 200,
                    width: double.infinity,
                    child: Image.file(file!),
                  ),
          ],
        ),
      ),
    );
  }

  void pickImage() async {
    // add to Global Variable
    // XFile? image;
    // File? file;
    ImagePicker imagePicker = ImagePicker();
    image = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      file = File(image!.path);
    });
  }

  void captureImage() async {
    // add to Global Variable
    // XFile? image;
    // File? file;
    ImagePicker imagePicker = ImagePicker();
    image = await imagePicker.pickImage(
      source: ImageSource.camera,
    );
    setState(() {
      file = File(image!.path);
    });
  }

  void toBase64Image() async {
    ImagePicker imagePicker = ImagePicker();
    image = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    Uint8List imageByte = await image!.readAsBytes();
    String base64Image = base64Encode(imageByte);
    print(base64Image);
  }
}
