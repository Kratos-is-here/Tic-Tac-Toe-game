import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool P1chance = true;

  List<String> displayElement = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];

  // var myNewFontW = TextStyle(color: Colors.white, fontSize: 34);
  int Xscore = 0, Oscore = 0, totalturns = 0;

  static var myNewFont = GoogleFonts.electrolize(
      textStyle: TextStyle(color: Colors.black, letterSpacing: 3));

  static var myNewFontW = GoogleFonts.electrolize(
      textStyle: TextStyle(color: Colors.white, letterSpacing: 3, fontSize: 25, fontWeight: FontWeight.bold,));
  static var myNewFontWB = GoogleFonts.electrolize(
      textStyle: TextStyle(color: Colors.white, letterSpacing: 3, fontSize: 28, fontWeight: FontWeight.bold,));


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[900],
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text('Scoreboard', style: TextStyle(color: Colors.white, fontSize: 34),)
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Player X  ',
                          style: myNewFontW,
                        ),
                        Text(
                          Xscore.toString(),
                          style: myNewFontW,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Player O',
                          style: myNewFontW,
                        ),
                        Text(
                          Oscore.toString(),
                          style: myNewFontW,
                        ),
                      ],
                    ),
                  ),
                ],
              ), // color: Colors.red,
            ),
          ),
          Expanded(
            flex: 3,

            // )
            // Expanded(
            //   child: Container(
            //     color: Colors.red,
            //   ),
            // ),
            // Expanded(child: flex: 3)
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.brown.shade500)),
                      child: Center(
                        child: Text(
                          displayElement[index],
                          style: TextStyle(color: Colors.white, fontSize: 42),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
            child: Center(
              child: Text(
                'You are playing as O', style: myNewFontWB
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _tapped(int i) {
    totalturns += 1;
    setState(() {
      if (displayElement[i] == '') {
        if (P1chance) {
          displayElement[i] = 'o';
        } else {
          displayElement[i] = 'X';
        }
        P1chance = !P1chance;
      }
      _gameover();
    });
  }

  void _gameover() {
    // checks 1st row
    if (displayElement[0] == displayElement[1] &&
        displayElement[0] == displayElement[2] &&
        displayElement[0] != '') {
      _showWinDialog(displayElement[0]);
    }

    // checks 2nd row
    else if (displayElement[3] == displayElement[4] &&
        displayElement[3] == displayElement[5] &&
        displayElement[3] != '') {
      _showWinDialog(displayElement[3]);
    }

    // checks 3rd row
    else if (displayElement[6] == displayElement[7] &&
        displayElement[6] == displayElement[8] &&
        displayElement[6] != '') {
      _showWinDialog(displayElement[6]);
    }

    // checks 1st column
    else if (displayElement[0] == displayElement[3] &&
        displayElement[0] == displayElement[6] &&
        displayElement[0] != '') {
      _showWinDialog(displayElement[0]);
    }

    // checks 2nd column
    else if (displayElement[1] == displayElement[4] &&
        displayElement[1] == displayElement[7] &&
        displayElement[1] != '') {
      _showWinDialog(displayElement[1]);
    }

    // checks 3rd column
    else if (displayElement[2] == displayElement[5] &&
        displayElement[2] == displayElement[8] &&
        displayElement[2] != '') {
      _showWinDialog(displayElement[2]);
    }

    // checks diagonal
    else if (displayElement[6] == displayElement[4] &&
        displayElement[6] == displayElement[2] &&
        displayElement[6] != '') {
      _showWinDialog(displayElement[6]);
    }

    // checks diagonal
    else if (displayElement[0] == displayElement[4] &&
        displayElement[0] == displayElement[8] &&
        displayElement[0] != '') {
      _showWinDialog(displayElement[0]);
    } 
    else if (totalturns == 9) {
      _showDrawDialog();
    }
  }

  void _showDrawDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('It\'s a Draw'),
            actions: [
              RaisedButton(
                child: Text('Play Again?'),
                onPressed: () {
                  _clearboard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _showWinDialog(String p) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(p + ' Wins!!'),
            actions: [
              RaisedButton(
                child: Text('Play Again?'),
                onPressed: () {
                  _clearboard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
    if (p == 'o') {
      Oscore += 1;
    } else {
      Xscore += 1;
    }
    // clear_board();
  }

  // void _showDrawDialog(){
  //   showDialog(context: context, builder: (BuildContext context){
  //     return AlertDialog(
  //       title: Text('It\'s a Draw'),
  //       );
  //     }
  //   );
  // }
  void _clearboard() {
    setState(() {
      for (var i = 0; i < 9; i++) {
        displayElement[i] = '';
      }
    });
    totalturns = 0;
  }
}
