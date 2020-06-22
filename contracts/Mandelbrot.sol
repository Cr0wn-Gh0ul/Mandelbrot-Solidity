/**
 *Submitted for verification at Etherscan.io on 2020-06-03
*/

pragma solidity ^0.6.0;

contract Mandelbrot {
  int xMin = -8601;
  int xMax = 2867;
  int yMin = -4915;
  int yMax = 4915;
  int maxI = 30;
  int dx = (xMax - xMin) / 24;
  int dy = (yMax - yMin) / 10;
  string ascii = '$ ,-~@*?&()%#+=';

  function generateMandelbrot() public view returns (string memory) {
    uint lines = 0;
    string memory mandel;
    for (int cy = yMax; lines<=10; cy-=dy) {
      int byteChar = 0;
      string memory sL = new string(25);
      bytes memory scanLine = bytes(sL);
      int cx = xMin;
      for (cx; cx<=xMax; cx+=dx) {
        int x = 0; int y = 0; int x2 = 0; int y2 = 0;
        int i = 0;
        for (i; i < maxI && x2 + y2 <= 16384; i++) {
            y = ((x * y) / 2**11) + cy;
            x = x2 - y2 + cx;
            x2 = (x * x) / 2**12;
            y2= (y * y) / 2**12;
        }

        bytes memory char = bytes(ascii);
        scanLine[uint(byteChar)] = char[uint(i%15)];
        byteChar++;
      }
      mandel = string(abi.encodePacked(mandel, string(abi.encodePacked(string(scanLine), '\n'))));
      lines++;
    }
    return mandel;
  }
}
