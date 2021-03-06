//+------------------------------------------------------------------+
//|                                                       Minmax.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

input int gap_delante = 4;
input int gap_atras = 6;

double maximos[3];
int counter_max = 0;
double minimos[3];
int counter_min = 0;

int OnInit()
  {
//---
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   identifyMax();
   identifyMin();
  }
//+------------------------------------------------------------------+

void identifyMax (){
   double temp_max = 0;
   int pos = 0;
   datetime time = 0;
   for (int i = 1;i<=(gap_delante+gap_atras);i++){
      if (High[i]>temp_max){
         temp_max = High[i];
         pos = i;
         time = Time[i];
      }
   }
   
   if (pos>gap_delante && pos<gap_atras && ObjectFind(temp_max)){
      if (counter_max>=ArraySize(maximos)) {
         counter_max = 0;
      }
      maximos[counter_max] = temp_max;
      ObjectCreate(temp_max,OBJ_HLINE,0,time,temp_max,0,0,0,0);
      ObjectSet(temp_max,OBJPROP_COLOR,Red);
      
   }
}

void identifyMin (){
   double temp_min = 99999999;
   int pos = 0;
   datetime time = 0;
   for (int i = 1;i<=(gap_delante+gap_atras);i++){
      if (Low[i]<temp_min){
         temp_min = Low[i];
         pos = i;
         time = Time[i];
      }
   }

   if (pos>gap_delante && pos<gap_atras && ObjectFind(temp_min)){
      if (counter_min>=ArraySize(minimos)) {
         counter_min = 0;
      }
      minimos[counter_min] = temp_min;
      ObjectCreate(temp_min,OBJ_HLINE,0,time,temp_min,0,0,0,0);
      ObjectSet(temp_min,OBJPROP_COLOR,Blue);
      
   }
}
