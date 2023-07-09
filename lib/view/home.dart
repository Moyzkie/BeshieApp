import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var inputController = TextEditingController();
  var outputController = TextEditingController();
  var isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: buildTitleApp()
      ),
      body: buildAppContent(),
    );
  }

  Widget buildTitleApp() => const Center(
    child: Text('BESHIE🤸APP',
      style: TextStyle(
          color: Colors.white
      ),
    ),
  );

  Widget buildAppContent() => Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 45.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildInputTextField(),
              SizedBox(height: 42.h,),
              buildResultTextField(),
              SizedBox(height: 10.h,),
              _buildCopyAndShareButton(),
              SizedBox(height: 10.w,),
              _buildGenerateButton(),
            ],
          ),
        ),
      );

  Widget buildInputTextField() => TextField(
     controller: inputController,
     onChanged: (inputText) {
       _clearGeneratedResult(inputText);
       _hideCopyAndShareButton(inputText);
     },
     decoration: InputDecoration(
       labelText: 'Enter Text Here',
       hintText: 'Bakit Malungkot Ang Beshie Ko? ',
       border: OutlineInputBorder(
         borderRadius: BorderRadius.circular(20.r)
       )
     ),
  );

  Widget buildResultTextField() =>  TextField(
    controller: outputController,
    readOnly: true,
     decoration: const InputDecoration(
       labelText: 'Generated Result',
       border: OutlineInputBorder(),
     ),
    maxLines: 1,
  );

  Widget _buildCopyAndShareButton() => Visibility(
        visible: isVisible,
        child: SizedBox(
          width: 260.w,
          child: ElevatedButton(
            onPressed: () async {
              await Share.share(outputController.text);
            },
            child: Text('Share'),
          ),
        ),
      );

  Widget _buildGenerateButton() =>  SizedBox(
    width: 260.w,
    child: ElevatedButton(
      onPressed: (){
        _generateResult();
      },
      child: Text('Generate'),
    ),
  );

  void _generateResult() {
    String replacedString = inputController.text.replaceAll(' ', '🤸');
    outputController.text = replacedString;
    _showCopyAndShareButton();
  }

  void _showCopyAndShareButton() {
    if (inputController.text.isNotEmpty) {
      setState(() {
        isVisible = true;
      });
    }
  }

  void _clearGeneratedResult(String inputText) {
    if (inputText.isEmpty) {
      outputController.clear();
    }
  }

  void _hideCopyAndShareButton(String inputText) {
    if (inputText.isEmpty) {
      setState(() {
        isVisible = false;
      });
    }
  }

}
