float angle = 0;
int w = 80;
int cols;
int rows;
Curve[][] curves;

void setup() {
  size(800,800);
  //fullScreen();
  cols = width/w - 1;
  rows = height/w-1;
  curves = new Curve[rows][cols];

  for (int j = 0; j < rows; j++) {
    for (int i = 0; i < cols; i++) {
      curves[j][i] = new Curve();
    }
  }
}

void draw() {
  background(255);
  float d = w - 10;
  float r = d/2;

  stroke(0);
  noFill();
  for (int i = 0; i < cols; i++) {
    float cx = w + i * w + w / 2;
    float cy = w / 2;
    strokeWeight(1);
    stroke(0);
    ellipse(cx,cy,d,d);
    float x = r * cos(angle * (i + 1) - HALF_PI);
    float y = r * sin(angle * (i + 1) - HALF_PI);
    strokeWeight(8);
    stroke(0);
    point(cx + x, cy + y);

    stroke(0, 50);
    strokeWeight(1);
    line(cx + x, 0, cx + x, height);

    for (int j = 0; j < rows; j++) {
      curves[j][i].setX(cx + x);
    }
  }

  stroke(0);
  noFill();
  for (int j = 0; j < rows; j++) {
    float cy = w + j * w + w / 2;
    float cx = w / 2;
    strokeWeight(1);
    stroke(0);
    ellipse(cx,cy,d,d);
    float x = r * cos(angle * (j + 1) - HALF_PI);
    float y = r * sin(angle * (j + 1) - HALF_PI);
    strokeWeight(8);
    stroke(0);
    point(cx + x, cy + y);

    stroke(0, 50);
    strokeWeight(1);
    line(0, cy + y, width, cy + y);

    for (int i = 0; i < cols; i++) {
      curves[j][i].setY(cy + y);
    }
  }

  for (int j = 0; j < rows; j++) {
    for (int i = 0; i < cols; i++) {
      curves[j][i].addPoint();
      curves[j][i].show();
    }
  }

  angle -= 0.01;

  if (angle < -TWO_PI) {
    for (int j = 0; j < rows; j++) {
      for (int i = 0; i < cols; i++) {
        curves[j][i].reset();
      }
    }
    angle = 0;
  }
}

class Curve {

  ArrayList<PVector> path;
  PVector current;

  Curve() {
    path = new ArrayList<PVector>();
    current = new PVector();
  }

  void setX(float x) {
    current.x = x;
  }

  void setY(float y) {
    current.y = y;
  }

  void addPoint() {
    path.add(current);
  }

  void reset() {
    path.clear();
  }

  void show() {
    stroke(0);
    strokeWeight(1);
    noFill();
    beginShape();
    for (PVector v : path) {
      vertex(v.x, v.y);
    }
    endShape();

    strokeWeight(8);
    point(current.x, current.y);
    current = new PVector();
  }
}
