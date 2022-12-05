import 'package:flutter/material.dart';
import 'package:x_o_game/ui/color.dart';
import 'package:x_o_game/x_o_logic.dart';

class xogame extends StatefulWidget {


  @override
  _xogameState createState() => _xogameState();
}

class _xogameState extends State<xogame> {
  String lastplayer="x";
  bool gameover=false;
  List<int>scoreboard=[0,0,0,0,0,0,0,0];
  Game g =Game();
  int turn=0;
  String res="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    g.board=Game.initGameBoard();
    print(g.board);
  }
  @override
  Widget build(BuildContext context) {
    double boardwidth =MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Maincolor.primarycolor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "It's ${lastplayer} turn".toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 60,

            ),
          ),
          SizedBox(height: 15,),
          Container(
            width: boardwidth,
            height: boardwidth,
            child: GridView.count(
              crossAxisCount: Game.boardlen~/3,
              padding: EdgeInsets.all(17.0),
              mainAxisSpacing: 11.0,
              crossAxisSpacing: 7.0,
              children:List.generate(
                  Game.boardlen, (index)
                  {
                    return InkWell(
                      onTap: gameover
                          ?null
                          :(){
                        if(g.board![index]=="")
                          {
                            setState(() {
                              g.board![index]=lastplayer;
                              turn++;
                              gameover=g.winnercheck(lastplayer, index, scoreboard, 3);
                              if(gameover)
                                {
                                  res="$lastplayer is The Winner!";
                                }
                              else if(!gameover&&turn==9)
                                {
                                  res="Ta3adol.. ";
                                  gameover=true;
                                }
                              if(lastplayer=="X")
                                lastplayer="O";
                              else
                                lastplayer="X";
                            });
                          }

                      },
                      child: Container(
                        width: Game.blocsize,
                        height: Game.blocsize,
                        decoration: BoxDecoration(
                          color: Maincolor.secondrycolor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            g.board![index],
                            style: TextStyle(
                              color: g.board![index]=="X"?
                                  Colors.lightBlueAccent
                                  :Colors.pinkAccent,
                              fontSize: 64.0,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          SizedBox(height: 25.0,),
          Text(
            res,
            style: TextStyle(
              color: Colors.white,
              fontSize: 54,
            ),
          ),
          ElevatedButton.icon(

              label: Text("Repeat The Game"),
              icon: Icon(Icons.replay_rounded),
              onPressed: (){
                setState(() {
                g.board=Game.initGameBoard();
                lastplayer="X";
                gameover=false;
                turn=0;
                res="";
                scoreboard=[0,0,0,0,0,0,0,0];

              });
              },

          ),
        ],

      ),
    );
  }
}

