import 'package:flutter/material.dart';

void main() {
  runApp(TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TicTacToePage(),
    );
  }
}

class TicTacToePage extends StatefulWidget {
  @override
  _TicTacToePageState createState() => _TicTacToePageState();
}

class _TicTacToePageState extends State<TicTacToePage> {
  late List<String> _board;
  late String _currentPlayer;
  late String _winner;
  late bool _gameOver;

  @override
  void initState() {
    super.initState();
    _resetGame();
  }

  void _resetGame() {
    setState(() {
      _board = List.generate(9, (index) => '');
      _currentPlayer = 'X';
      _winner = '';
      _gameOver = false;
    });
  }

  void _handleTap(int index) {
    if (_board[index] == '' && !_gameOver) {
      setState(() {
        _board[index] = _currentPlayer;
        _checkWinner();
        if (!_gameOver) {
          _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
        }
      });
    }
  }

  void _checkWinner() {
    List<List<int>> winningCombinations = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];

    for (var combination in winningCombinations) {
      String a = _board[combination[0]];
      String b = _board[combination[1]];
      String c = _board[combination[2]];

      if (a != '' && a == b && a == c) {
        _winner = a;
        _gameOver = true;
        return;
      }
    }

    if (!_board.contains('')) {
      _gameOver = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Tic Tac Toe'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildBoard(screenWidth),
          if (_gameOver)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                _winner.isNotEmpty ? 'Player $_winner won🥳!' : 'It\'s a draw!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ElevatedButton(
            onPressed: _resetGame,
            child: Text('Reset Game'),
          ),
        ],
      ),
    );
  }

  Widget _buildBoard(double screenWidth) {
    // Aspect ratio to make the grid square
    return AspectRatio(
      aspectRatio: 1, // A square board
      child: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: 9,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _handleTap(index),
            child: Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Center(
                child: Text(
                  _board[index],
                  style: TextStyle(
                    fontSize: screenWidth * 0.12, 
                    fontWeight: FontWeight.bold,
                    color: _board[index] == 'X'
                        ? Colors.blue
                        : Colors.red, // Different colors for 'X' and 'O'
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
