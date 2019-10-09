import 'package:day_5_starter/question_brain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'question.dart';
import 'question_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
int correctResponse=0,finishedQuestions;
void main() {

  runApp(Quizlr());
}

class Quizlr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.grey.shade900,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: QuizPage(),
            ),
          ),
        ));
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];




 QuizBrain brain=QuizBrain();
 void restartQuiz(){
   setState(() {
     brain.questionNumber=0;
     scoreKeeper.clear();
   });
 }
 void checkAnswer(bool userAnswer){
   setState(() {
     if(brain.checkAnswer(userAnswer)){
       scoreKeeper.add(Icon(Icons.check,color: Colors.green,));
       correctResponse++;
     }
     else {
       scoreKeeper.add(Icon(Icons.close,color: Colors.red,));
     }
     brain.nextQuestion();
     finishedQuestions=brain.questionNumber;
     if(brain.questionNumber==brain.questions.length-1 )
            {
              Alert(
                context: context,
                type: AlertType.error,
                title: "QUIZ COMPLETED",
                desc: "You have Reached the end of the quiz and scored $correctResponse/$finishedQuestions",
                buttons: [
                  DialogButton(
                    child: Text(
                      "RESTART QUIZ",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    onPressed: () {
                      restartQuiz();
                      Navigator.pop(context);
                    },
                    width: 120,
                  )
                ],
              ).show();
             // Alert(context: context, title: "QUIZ COMPLETED", desc: "You have Reached the end of the quiz and scored $correctResponse/$brain.questionNumber").show();
            }
   });
 }



  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                brain.getCurrentQuestion().questionText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: FlatButton(
                textColor: Colors.white,
                color: Colors.green,
                child: Text(
                  'True',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  checkAnswer(true);
                }),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}

// Sample Questions and Answers
// Q.1 Amartya Sen was awarded the Nobel prize for his contribution to Welfare Economics., true
// Q.2 The Headquarters of the Southern Naval Command of the India Navy is located at Thiruvananthapuram., false
// Q.3 There are 4 sessions of the Parliament each year: Spring, Summer, Autumn and Winter., false