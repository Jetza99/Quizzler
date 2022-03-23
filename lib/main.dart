import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';


QuizBrain quizBrain = QuizBrain();

void main() => runApp(
  MaterialApp(
    home: QuizzlerApp(),
  )
);

class QuizzlerApp extends StatefulWidget {

  QuizzlerApp({Key? key}) : super(key: key);


  @override
  State<QuizzlerApp> createState() => _QuizzlerAppState();
}

class _QuizzlerAppState extends State<QuizzlerApp> {

  List<Icon> scoreBoard = [];

  void checkAnswer(bool chosenAnswer){
    bool correctAnswer = quizBrain.getQuestionAnswer();
    setState(() {

      if(quizBrain.quizIsFinished() == true){
        Alert(context: context,
            title: "Finished",
            desc: "You have finished the quiz. ").show();

        quizBrain.resetQuiz();
        scoreBoard = [];

      }else{
        if(correctAnswer == chosenAnswer){
          scoreBoard.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        }else{
          scoreBoard.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
        quizBrain.nextQuestion();
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Center(
                  child: Text(
                    quizBrain.getQuestionText(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: (){

                    checkAnswer(true);

                  },
                  child: Container(
                    color: Colors.green,
                    child: Center(
                      child: Text(
                        'True',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35.0,
                        ),

                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: TextButton(
                  onPressed: (){
                    checkAnswer(false);
                  },
                  child: Container(
                    color: Colors.red,
                    child: Center(
                      child: Text(
                        'False',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35.0,
                        ),

                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: scoreBoard,
              )

            ],
          ),
        ),
    );
  }
}
/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,

setState(() {
                      scoreBoard.add(Icon(
                        Icons.check,
                        color: Colors.green,
                      ));
                      quizBrain.nextQuestion();
                    });
*/