#property copyright ""
#property link      ""
#property version   "1.00"
#property strict
string ʹ������=""; //����д�����ƣ���ʽ��2018.04.08 00:00
string �˺�����="";  //����д�����ƣ���д��Ȩ�����˺ţ�|������磺8888|9999|666

enum MYPERIOD{��ǰ=PERIOD_CURRENT,M1=PERIOD_M1,M5=PERIOD_M5,M15=PERIOD_M15,M30=PERIOD_M30,H1=PERIOD_H1,H4=PERIOD_H4,D1=PERIOD_D1,W1=PERIOD_W1,MN1=PERIOD_MN1};
input MYPERIOD ʱ������=��ǰ;

enum MY_OP2{BUY=OP_BUY,SELL=OP_SELL}; 

input double __����=0.01;
input int __ֹ�����=0;
input int __ֹӯ����=100;
input int __ƫ�����=10;
input int __ӯ������ֲ���=12;
input int __����ӯ��=10;
input int __��������ֲ���=15;
input int __���������=0;
input bool __����ƽ������=1;
input int __ͬ�����ӯ�����㿪ʼִ��=20;
input int __��������ӯ��=10;
input int __ͬ�򵥴���ڼ�����ִ��=2;
input int _����1_ʱ������=8;
input int _����1_ƽ��=0;
input ENUM_MA_METHOD _����1_�ƶ�ƽ��=MODE_SMA;
input ENUM_APPLIED_PRICE _����1_Ӧ����=PRICE_CLOSE;

input int _����2_ʱ������=14;
input int _����2_ƽ��=0;
input ENUM_MA_METHOD _����2_�ƶ�ƽ��=MODE_SMA;
input ENUM_APPLIED_PRICE _����2_Ӧ����=PRICE_CLOSE;

input int ���������=900;

#define _tn_int int
#define _m_int int
#define _p_int int

input _m_int _����ʶ����=0;
_m_int _����=0;
input string ����ע��="";
_m_int ��ʶ����=0;
string _��ע��="";
bool _b��ע��=false;

_m_int ����ʶ����=0;
_m_int ����_������=0;
_m_int ����_ָ����=0;
int ǿ���ж�ʶ����=0;

int ����ѭ����=0;

int ָ��ִ���˲���=0;

_m_int ����_R_ʶ����=0;
int ǿ���ж�_R_ʶ����=0;
int ����ѭ��_R_��=0;

_m_int ����_R_������=0;
_m_int ����_R_ָ����=0;

bool mOrderOk��ͣ=false;

int _��ϵ��=1;

_tn_int _mPubTsIns[1000]={};
int _mPubTsInc=0;
_tn_int _mPubTsExs[1000]={};
int _mPubTsExc=0;
_tn_int _mPubTs2Ins[1000]={};
int _mPubTs2Inc=0;
_tn_int _mPubTs2Exs[1000]={};
int _mPubTs2Exc=0;
_tn_int _mPubTn0=0;

_tn_int _mPubHisTsIns[1000]={};
int _mPubHisTsInc=0;
_tn_int _mPubHisTsExs[1000]={};
int _mPubHisTsExc=0;
_tn_int _mPubHisTs2Ins[1000]={};

_tn_int _mPubHisTs2Exs[1000]={};

#define MYARC 20
#define MYPC 300
_p_int _mPubi[MYPC];
double _mPubv[MYPC];
string _mPubs[MYPC];
datetime _mPubTime[MYPC];
color _mPubr[MYPC];
double _mPubFs[MYARC][MYPC]={};
_p_int _mPubIs[MYARC][MYPC]={};
int _mPubIsc[MYARC]={};
int _mPubFsc[MYARC]={};

#define MYARR_DC 1
#define MYARR_IC 1
#define MYARR_SC 1

int mArrDc[MYARR_DC];
_p_int mArrIs[MYARR_IC][300];
int mArrIc[MYARR_IC];

int mArrSc[MYARR_SC];
int mMks[20]={};

#define MYTC 300
class _TArA { public:   double a[];   double b[];   int c; };

int ��=0;

_m_int gGa=0;
_m_int gGb=0;
_m_int gGa_bak=0;
_m_int gGb_bak=0;

string sym="";

int period=0;

string mPreCap="";
string mPreCapM="";
string mPreCapP=""; //������������޸Ĳ�����Ҳɾ������
string mPreCapNoDel="";//�����������ǹ�ea����������������ǻز⣬�����
string _mInitCap_LoadTime="";
string _mCap_TimePos1=""; //ʱ���ע��

int mReInit=0;
int mReIniPr=0;
int OnInit() {
   string hd=MQLInfoString(MQL_PROGRAM_NAME);

   mPreCapM=hd+"_"+string(_����ʶ����)+"_"; if (IsTesting()) mPreCapM+="test_";
   if (StringLen(mPreCapM)>26) mPreCapM=StringSubstr(mPreCapM,StringLen(mPreCapM)-26);

   mPreCap=hd+"_"+string(_����ʶ����)+"_"+Symbol()+"_"; if (IsTesting()) mPreCap+="test_";
   if (StringLen(mPreCap)>26) mPreCap=StringSubstr(mPreCap,StringLen(mPreCap)-26);

   mPreCapNoDel=hd+"_"+string(_����ʶ����)+"*_"+Symbol()+"_"; if (IsTesting()) mPreCapNoDel+="test_";
   if (StringLen(mPreCapNoDel)>26) mPreCapNoDel=StringSubstr(mPreCapNoDel,StringLen(mPreCapNoDel)-26);
   
   string sycap="eano1_cur_sym";
   if (ObjectGetString(0,sycap,OBJPROP_TEXT)!=Symbol()) { //�������ַ���������¼���жϣ�mt5������
      ObjectsDeleteAll(); //ͼ��Ʒ�ֱ��ı�
      myCreateLabel(Symbol(),sycap,0,-2000,-2000,10,255,CORNER_LEFT_UPPER);
   }
   
   if (IsTesting()) {
      myObjectDeleteByPreCap(mPreCapM);
      myDeleteGlobalVariableByPre(mPreCapM);
      myObjectDeleteByPreCap(mPreCap);
      myDeleteGlobalVariableByPre(mPreCap);
      myObjectDeleteByPreCap(mPreCapNoDel);
      myDeleteGlobalVariableByPre(mPreCapNoDel);
   }   
   mPreCapP=mPreCap+"#_";
      
   _mInitCap_LoadTime=mPreCap+"_pub_loadtime";
   if (myGlobalVDateTimeCheck(_mInitCap_LoadTime)==false) myGlobalVDateTimeSet(_mInitCap_LoadTime,TimeCurrent());
   _mCap_TimePos1=mPreCap+"_pub_tmpos1";
   if (myGlobalVDateTimeCheck(_mCap_TimePos1)==false) myGlobalVDateTimeSet(_mCap_TimePos1,TimeCurrent());

   string cap=mPreCap+"_pub_loadea";
   if (mReInit==0 || GlobalVariableCheck(cap)==false) { //mt4�������˳���mPreCap���޷��жϵģ�ֻ��ͨ��mReInit���ж�
      //���Ը�λ

      for (int i=0;i<MYPC;++i) {
         _mPubi[i]=0;
         _mPubv[i]=0;
         _mPubs[i]="";
         _mPubTime[i]=0;
         _mPubr[i]=0;
      }
      for (int i=0;i<MYARC;++i) {
         for (int j=0;j<MYPC;++j) {
            _mPubFs[i][j]=0;
            _mPubIs[i][j]=0;
         }
         _mPubIsc[i]=0;
         _mPubFsc[i]=0;
      }
      
      ArrayInitialize(mArrDc,-1);
      ArrayInitialize(mArrIc,-1);
      ArrayInitialize(mArrSc,-1);
      mReIniPr=1;      mReInit=1; GlobalVariableSet(cap,1);
   }
   if (mReIniPr==0) {
      ArrayInitialize(mArrDc,-1);
      ArrayInitialize(mArrIc,-1);
      ArrayInitialize(mArrSc,-1);
      mReIniPr=1;
   }
   
   _����=_����ʶ����; if (_����==0) _����=444;
   ����ʶ����=_����;
   ����_R_ʶ����=_����;
   
//mt5custominit

   return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason) {

   //if (IsTesting()==false) myObjectDeleteByPreCap(mPreCap);  //�л����ڲ���ɾ��������ť״̬��ı�
   if (reason==REASON_REMOVE || reason==REASON_CHARTCLOSE || reason==REASON_PROGRAM) {
      if (IsTesting()==false) {
         myObjectDeleteByPreCap(mPreCapM);
         myObjectDeleteByPreCap(mPreCap);
         GlobalVariableDel(mPreCap+"_pub_loadea");
         bool ok=true;

         if (ok) {
            myDeleteGlobalVariableByPre(mPreCap);
            myDeleteGlobalVariableByPre(mPreCapM);
         }
      }
   }
   if (reason==REASON_PARAMETERS) {
      myObjectDeleteByPreCap(mPreCapP);
      myDeleteGlobalVariableByPre(mPreCapP);
      mReIniPr=0;
   }
}

void OnTick() {
   if (myTimeLimit(ʹ������)==false) return;
   if (myAccountNumCheck()==false) return;
   if (_����ʶ����==444 || _����ʶ����==-444) { Alert("~~~~~~�Զ�ʶ���벻������Ϊ444��-444����������"); ExpertRemove(); return; } 
   int _tmp_w_break=0;


   int _or=0;
   ��=0; gGa=0; _mPubTsInc=_mPubTsExc=_mPubHisTsInc=_mPubHisTsExc=-1;
   period=ʱ������; if (period==0) period=Period();
   sym=Symbol();

   ArrayInitialize(mMks,0);      
   if (ʱ������!=Period() && iOpen(sym,ʱ������,0)==0.00004751) Print("~~~a");
   if (0!=Period() && iOpen(sym,0,0)==0.00004751) Print("~~~a");
   int _ok0=-1;
   if (_ok0==-1) {
      int _ok1=-1;
      if (_ok1==-1) {
         int _ok2=myFun17_1();
         //r/ _ok1=_ok2;
         if (_ok2==1) { myFun44_1(); }
      }
      if (_ok1==-1) {
         int _ok3=-1;
         if (_ok3==-1) {
            int _ok4=myFun8_1();
            //r/ _ok3=_ok4;
            if (_ok4==1) { myFun32_1(); }
         }
         if (_ok3==-1) {
            int _ok5=myFun17_2();
            //r/ _ok3=_ok5;
            if (_ok5==0) { if (myFun6_1()==-3) _ok3=0; }
         }
         if (_ok3==-1) {
            int _ok6=-1;
            if (_ok6==-1) {
               int _ok7=myFun18_1();
               //r/ _ok6=_ok7;
               if (_ok7==0) { if (myFun6_2()==-3) _ok6=0; }
            }
            if (_ok6==-1) {
               int _ok8=myFun17_3();
               //r/ _ok6=_ok8;
               if (_ok8==0) { if (myFun6_3()==-3) _ok6=0; }
            }
            if (_ok6==-1) {
               int _ok9=myFun17_4();
               //r/ _ok6=_ok9;
               if (_ok9==1) { myFun210_1(); }
            }
            if (_ok6==-1) {
               int _ok10=myFun17_5();
               _ok6=_ok10;
               if (_ok10==1) { myFun210_2(); }
            }
            //r/ _ok3=_ok6;
         }
         if (_ok3==-1) {
            int _ok11=-1;
            if (_ok11==-1) {
               int _ok12=myFun18_2();
               //r/ _ok11=_ok12;
               if (_ok12==0) { if (myFun6_4()==-3) _ok11=0; }
            }
            if (_ok11==-1) {
               int _ok13=myFun17_6();
               //r/ _ok11=_ok13;
               if (_ok13==0) { if (myFun6_5()==-3) _ok11=0; }
            }
            if (_ok11==-1) {
               int _ok14=myFun17_7();
               //r/ _ok11=_ok14;
               if (_ok14==1) { myFun210_3(); }
            }
            if (_ok11==-1) {
               int _ok15=myFun17_8();
               _ok11=_ok15;
               if (_ok15==1) { myFun210_4(); }
            }
            _ok3=_ok11;
         }
         //r/ _ok1=_ok3;
      }
      if (_ok1==-1) {
         int _ok16=-1;
         if (_ok16==-1) {
            int _ok17=myFun17_9();
            //r/ _ok16=_ok17;
            if (_ok17==0) { if (myFun6_6()==-3) _ok16=0; }
         }
         if (_ok16==-1) {
            int _ok18=myFun17_10();
            _ok16=_ok18;
            if (_ok18==0) { if (myFun6_7()==-3) _ok16=0; }
         }
         //r/ _ok1=_ok16;
         if (_ok16==1) { myFun44_2(); }
      }
      if (_ok1==-1) {
         int _ok19=-1;
         if (_ok19==-1) {
            int _ok20=myFun17_11();
            //r/ _ok19=_ok20;
            if (_ok20==0) { if (myFun6_8()==-3) _ok19=0; }
         }
         if (_ok19==-1) {
            int _ok21=myFun17_12();
            //r/ _ok19=_ok21;
            if (_ok21==0) { if (myFun6_9()==-3) _ok19=0; }
         }
         if (_ok19==-1) {
            int _ok22=myFun17_13();
            //r/ _ok19=_ok22;
            if (_ok22==0) { if (myFun6_10()==-3) _ok19=0; }
         }
         if (_ok19==-1) {
            int _ok23=myFun17_14();
            //r/ _ok19=_ok23;
            if (_ok23==0) { if (myFun6_11()==-3) _ok19=0; }
         }
         if (_ok19==-1) {
            int _ok24=myFun8_2();
            _ok19=_ok24;
            if (_ok24==1) { myFun32_2(); }
         }
         //r/ _ok1=_ok19;
         if (_ok19==1) { myFun139_1(); }
      }
      if (_ok1==-1) {
         int _ok25=-1;
         if (_ok25==-1) {
            int _ok26=myFun17_15();
            //r/ _ok25=_ok26;
            if (_ok26==0) { if (myFun6_12()==-3) _ok25=0; }
         }
         if (_ok25==-1) {
            int _ok27=myFun17_16();
            //r/ _ok25=_ok27;
            if (_ok27==0) { if (myFun6_13()==-3) _ok25=0; }
         }
         if (_ok25==-1) {
            int _ok28=myFun17_17();
            //r/ _ok25=_ok28;
            if (_ok28==0) { if (myFun6_14()==-3) _ok25=0; }
         }
         if (_ok25==-1) {
            int _ok29=myFun17_18();
            //r/ _ok25=_ok29;
            if (_ok29==0) { if (myFun6_15()==-3) _ok25=0; }
         }
         if (_ok25==-1) {
            int _ok30=myFun8_3();
            _ok25=_ok30;
            if (_ok30==1) { myFun32_3(); }
         }
         //r/ _ok1=_ok25;
         if (_ok25==1) { myFun139_2(); }
      }
      if (_ok1==-1) {
         int _ok31=-1;
         if (_ok31==-1) {
            int _ok32=myFun81_1();
            //r/ _ok31=_ok32;
            if (_ok32==0) { if (myFun6_16()==-3) _ok31=0; }
         }
         if (_ok31==-1) {
            int _ok33=myFun17_19();
            _ok31=_ok33;
            if (_ok33==1) { myFun72_1(); }
         }
         //r/ _ok1=_ok31;
      }
      if (_ok1==-1) {
         int _ok34=-1;
         if (_ok34==-1) {
            int _ok35=myFun17_20();
            //r/ _ok34=_ok35;
            if (_ok35==0) { if (myFun6_17()==-3) _ok34=0; }
         }
         if (_ok34==-1) {
            int _ok36=myFun17_21();
            //r/ _ok34=_ok36;
            if (_ok36==0) { if (myFun6_18()==-3) _ok34=0; }
         }
         if (_ok34==-1) {
            int _ok37=myFun17_22();
            _ok34=_ok37;
            if (_ok37==0) { if (myFun6_19()==-3) _ok34=0; }
         }
         //r/ _ok1=_ok34;
         if (_ok34==1) { myFun44_3(); }
      }
      if (_ok1==-1) {
         int _ok38=-1;
         if (_ok38==-1) {
            int _ok39=myFun17_23();
            //r/ _ok38=_ok39;
            if (_ok39==0) { if (myFun6_20()==-3) _ok38=0; }
         }
         if (_ok38==-1) {
            int _ok40=myFun17_24();
            //r/ _ok38=_ok40;
            if (_ok40==0) { if (myFun6_21()==-3) _ok38=0; }
         }
         if (_ok38==-1) {
            int _ok41=myFun17_25();
            _ok38=_ok41;
            if (_ok41==0) { if (myFun6_22()==-3) _ok38=0; }
         }
         _ok1=_ok38;
         if (_ok38==1) { myFun44_4(); }
      }
      _ok0=_ok1;
   }

}

int mErrXY=-9876543;

int mMaxX=0;
int mMaxY=0;

datetime myTimeVar(int tid) {
   datetime tm=0;
   if (tid<100) tm=_mPubTime[tid];
   else if (tid==101) tm=myGlobalVDateTimeGet(_mInitCap_LoadTime); //ea����ʱ��
   else if (tid==102) tm=StrToTime(TimeToStr(TimeCurrent(),TIME_DATE)+" 00:00");
   else if (tid==103) tm=0;
   else if (tid==104) tm=9999999999;
   else if (tid==105) {
      string cap=mPreCap+"f170903_t";
      if (GlobalVariableCheck(cap)) tm=(datetime)(GlobalVariableGet(cap)*1000.0);   
      else tm=myGlobalVDateTimeGet(_mInitCap_LoadTime); //ea����ʱ��
   }
   else if (tid==106) tm=iTime(sym,period,0);
   else if (tid==107) tm=iTime(sym,period,1);
   else if (tid==108) tm=myGlobalVDateTimeGet(_mCap_TimePos1);
   else if (tid>=201 && tid<=210) tm=iTime(sym,period,int(_mPubIs[0][tid-201]));
   else if (tid>=211 && tid<=220) tm=iTime(sym,period,int(_mPubIs[1][tid-211]));
   return tm;
}

datetime myGlobalVDateTimeGet(string vcap) {
   string hcap=vcap+"__h";
   string lcap=vcap+"__l";
   double h=GlobalVariableGet(hcap);
   double l=GlobalVariableGet(lcap);
   double r=h*1000000+l;
   return (datetime)r;
}

void myGlobalVDateTimeSet(string vcap,datetime t) {
   string hcap=vcap+"__h";
   string lcap=vcap+"__l";
   double f=(double)t;
   double h=int(f/1000000);
   double l=int(f)%1000000;
   GlobalVariableSet(hcap,h);
   GlobalVariableSet(lcap,l);
}

bool myGlobalVDateTimeCheck(string vcap) {
   return GlobalVariableCheck(vcap+"__h");
}

bool myIsOpenByThisEA(_m_int om) {
  if (����ʶ����==0 && ǿ���ж�ʶ����==0)  return true;
  if (_����ʶ����==0 && ǿ���ж�ʶ����==0)  return true; //�û��ӿڲ���ֱ������Ϊ0��ʾ����ʶ���루�жϵ��ǡ�_����ʶ���롱�����ǡ�����ʶ���롱����˲�Ӱ�������ֹ�����
  if (����ѭ����==1) return om==����ʶ����;

   return om==����ʶ����;
}

bool myIsOpenByThisEA2(_m_int om,int incSub) {
  if (����ʶ����==0 && ǿ���ж�ʶ����==0)  return true; 
  if (_����ʶ����==0 && ǿ���ж�ʶ����==0)  return true; //�û��ӿڲ���ֱ������Ϊ0��ʾ����ʶ���루�жϵ��ǡ�_����ʶ���롱�����ǡ�����ʶ���롱����˲�Ӱ�������ֹ�����
  if (����ѭ����==1) return om==����ʶ����;

   if (����ʶ����==0) return om==����ʶ���� || (incSub && int(om/100000)==444); //���⽫����ea��С��100000��ʶ��������Ϊ���ֹ���
   return om==����ʶ���� || (incSub && int(om/100000)==����ʶ����);
}

bool myIsOpenByThis_R_E2(_m_int om,int incSub) {
  if (����_R_ʶ����==0 && ǿ���ж�_R_ʶ����==0)  return true;  
  if (_����ʶ����==0 && ǿ���ж�_R_ʶ����==0)  return true; //�û��ӿڲ���ֱ������Ϊ0��ʾ����ʶ���루�жϵ��ǡ�_����ʶ���롱�����ǡ�����_R_ʶ���롱����˲�Ӱ�������ֹ�����
  if (����ѭ��_R_��==1) return om==����_R_ʶ����;

   if (����_R_ʶ����==0) return om==����_R_ʶ���� || (incSub && int(om/100000)==444); //���⽫����ea��С��100000��ʶ��������Ϊ���ֹ���
   return om==����_R_ʶ���� || (incSub && int(om/100000)==����_R_ʶ����);
}

void myCreateLabel(string str="mylabel",string ID="def_la1",long chartid=0,int xdis=20,int ydis=20,int fontsize=12,color clr=clrRed,int corner=CORNER_LEFT_UPPER) {
    ObjectCreate(chartid,ID,OBJ_LABEL,0,0,0);
    ObjectSetInteger(chartid,ID,OBJPROP_XDISTANCE,xdis);
    ObjectSetInteger(chartid,ID,OBJPROP_YDISTANCE,ydis);
    ObjectSetString(chartid,ID,OBJPROP_FONT,"Trebuchet MS");
    ObjectSetInteger(chartid,ID,OBJPROP_FONTSIZE,fontsize);
    ObjectSetInteger(chartid,ID,OBJPROP_CORNER,corner);
    ObjectSetInteger(chartid,ID,OBJPROP_SELECTABLE,true);
    ObjectSetString(chartid,ID,OBJPROP_TOOLTIP,"\n");
    ObjectSetString(chartid,ID,OBJPROP_TEXT,str);
   ObjectSetInteger(chartid,ID,OBJPROP_COLOR,clr);
}

double myLotsValid(string sym0,double lots,bool returnMin=false) {
   double step=MarketInfo(sym0,MODE_LOTSTEP);
   if (step<0.000001) { Alert("Ʒ�֡�",sym0,"�����ݶ�ȡʧ�ܣ������Ʒ���Ƿ���ڡ����к�׺���������׺��");  return lots; }
   double ls0=lots;
   int v=(int)MathRound(lots/step); lots=v*step;
   double min=MarketInfo(sym0,MODE_MINLOT);
   double max=MarketInfo(sym0,MODE_MAXLOT);
   if (v<-99999 || ls0>99999999) return max; //lots����������ӷ�������̫����ǳ������v�ڴ����
   if (lots<min) {
      if (returnMin) return min;
      Alert("����̫С��������ƽ̨Ҫ��"); lots=-1;
   }
   if (lots>max) lots=max;
   return lots;
}

string ʱ������_ʱ��ǰ׺="ʹ�����ޣ�";
string ʱ������_ʱ���׺="";
string ʱ�����_ʱ��ǰ׺="~~~~~~~�ѹ�ʹ�����ޣ�";
string ʱ�����_ʱ���׺="";
bool myTimeLimit(string timestr) {
   if (timestr=="") return true;
   datetime t=StringToTime(timestr);
   if (TimeCurrent()<t) {
      myCreateLabel(ʱ������_ʱ��ǰ׺+timestr+ʱ������_ʱ���׺,mPreCap+"myTimeLimit",0,20,20,10,255,CORNER_LEFT_LOWER);
      return true;
   }
   else {
      myCreateLabel(ʱ�����_ʱ��ǰ׺+timestr+ʱ�����_ʱ���׺,mPreCap+"myTimeLimit",0,20,20,10,255,CORNER_LEFT_LOWER);
      return false;
   }
}

bool myAccountNumCheck() {
   if (�˺�����=="") return true;
   
   ushort u_sep=StringGetCharacter("|",0);
   string ss[1000]; int c=StringSplit(�˺�����,u_sep,ss);
   if (c>=1000) Alert("��Ȩ�б�����̫��");
   
   string s=string(AccountNumber());
   for (int i=0;i<c;++i) if (s==ss[i]) return true;
     
   myCreateLabel("����Ȩ�˻��˺�:"+s,mPreCap+"onlyuser2"); 
   return false; 
}

void myDeleteGlobalVariableByPre(string pre) {
   int len=StringLen(pre);
   for (int i=GlobalVariablesTotal()-1;i>=0;--i) {
      string cap=GlobalVariableName(i);
      if (StringSubstr(cap,0,len)==pre)
   GlobalVariableDel(cap);
   }
}

void myObjectDeleteByPreCap(string PreCap) {
//ɾ��ָ������ǰ׺�Ķ���
   int len=StringLen(PreCap);
   for (int i=ObjectsTotal()-1;i>=0;--i) {
      string cap=ObjectName(i);
      if (StringSubstr(cap,0,len)==PreCap)
         ObjectDelete(cap);
   }
}

string myPeriodStr(int p0) {
   int pid=0; if (p0==0) p0=Period();
   string pstr;
   switch (p0) {
      case 1: pid=0; pstr="M1"; break;
      case 5: pid=1; pstr="M5"; break;
      case 15: pid=2; pstr="M15"; break;
      case 30: pid=3; pstr="M30"; break;
      case 60: pid=4; pstr="H1"; break;
      case 240: pid=5; pstr="H4"; break;
      case 1440: pid=6; pstr="D1"; break;
      case 10080: pid=7; pstr="W1"; break;
      case 43200: pid=8; pstr="MN"; break;
      default: pstr=string(p0);
   }
   return pstr;
}

bool myOrderOks(_tn_int tn) {
   if (mOrderOk��ͣ) return true;
   if (_mPubTsExc>0) { for (int i=0;i<_mPubTsExc;++i) { if (_mPubTsExs[i]==tn) return false; }  }
   if (_mPubTsInc>=0){ 
      int i=0; for (;i<_mPubTsInc;++i) { if (_mPubTsIns[i]==tn) break; } 
      if (i>=_mPubTsInc) return false;  
   }
   return true;
}

bool myOrderOk2(_tn_int tn) {
   if (mOrderOk��ͣ) return true;
   if (_mPubTs2Exc>0) { for (int i=0;i<_mPubTs2Exc;++i) { if (_mPubTs2Exs[i]==tn) return false; }  }
   if (_mPubTs2Inc>=0){ 
      int i=0; for (;i<_mPubTs2Inc;++i) { if (_mPubTs2Ins[i]==tn) break; } 
      if (i>=_mPubTs2Inc) return false;  
   }
   return true;
}

bool myOrderHisOks(_tn_int tn) {
   if (mOrderOk��ͣ) return true;
   if (_mPubHisTsExc>0) { for (int i=0;i<_mPubHisTsExc;++i) { if (_mPubHisTsExs[i]==tn) return false; }  }
   if (_mPubHisTsInc>=0){ 
      int i=0; for (;i<_mPubHisTsInc;++i) { if (_mPubHisTsIns[i]==tn) break; } 
      if (i>=_mPubHisTsInc) return false;  
   }
   return true;
}

bool myMarketOpened(string sy) {
   datetime StartTime;
   datetime EndTime;
   MqlDateTime TimeCur={0};
   TimeCurrent(TimeCur);   
   ENUM_DAY_OF_WEEK DayofWeak=ENUM_DAY_OF_WEEK(TimeCur.day_of_week);  
   bool  GetSession=SymbolInfoSessionTrade(sy,DayofWeak,0,StartTime,EndTime);
   if(GetSession==true) {
      MqlDateTime StartTimeStruct={0};
      MqlDateTime EndTimeStruct={0};
      if(TimeToStruct(StartTime,StartTimeStruct) && TimeToStruct(EndTime,EndTimeStruct)) {
         int Start=StartTimeStruct.hour*3600+StartTimeStruct.min*60;
         int End=EndTimeStruct.hour*3600+EndTimeStruct.min*60; 
         int Now=TimeCur.hour*3600+TimeCur.min*60;
         bool ok=false;
         if(Start==End) ok=true;          
         else if(Start<End) { if(Now>=Start && Now<=End) ok=true; }
         else if(Start>End) { if(Now>=Start || Now<=End) ok=true; }  
         return ok;
      }
   }
   return(false);
}

bool myOpenOk(_tn_int tn,int type) {

//OrderSend����ֵ����0���������־ͳɹ��ˣ���Ҫ�ȴ�ȷ��
//������������mt5���룬�������������д���
   int i=0,wc=500; for (i=0;i<wc;++i) {
      RefreshRates();
      for (int cnt=OrdersTotal()-1;cnt>=0;cnt--) {
      	if (OrderSelect(cnt,SELECT_BY_POS)==false) continue;
      	if (OrderTicket()==tn) {
      	   int t=OrderType();
      	   if (t==type) return true;
      	   if ((type==OP_BUYSTOP || type==OP_BUYLIMIT) && t==OP_BUY) return true;
      	   if ((type==OP_SELLSTOP || type==OP_SELLLIMIT) && t==OP_SELL) return true;
      	}
      }
      uint ta=GetTickCount();
      while (true) {
         uint tb=GetTickCount();
         if (tb<ta || tb-ta>30) break;
         if (OrderSelect(tn,SELECT_BY_TICKET) && OrderCloseTime()>0) {
            Alert("�쳣���ѣ�~~~~~~#",tn,"~~~�����ս���������ƽ��");
            return true;
         } 
      }
   }   
   if (i>=wc) { Alert("�쳣���ѣ�~~~~������̫������������δ�ɹ� #",tn); return false; }

   return true;
}

double myFun25_1() {
   if (OrdersTotal()<=0) return 0;
   int magic=1; if (0==1) magic=0;   
   int ts[10]={}; ArrayInitialize(ts,0);
   ts[OP_BUY]=0;
   ts[OP_BUYLIMIT]=1;
   ts[OP_BUYSTOP]=1;
   ts[OP_SELL]=0;
   ts[OP_SELLLIMIT]=1;
   ts[OP_SELLSTOP]=1;
   if (ts[OP_BUY]+ts[OP_BUYLIMIT]+ts[OP_BUYSTOP]+ts[OP_SELL]+ts[OP_SELLLIMIT]+ts[OP_SELLSTOP]==0) ArrayInitialize(ts,1);
   int c=0;
   for (int cnt=OrdersTotal()-1;cnt>=0;cnt--) {
     if (OrderSelect(cnt,SELECT_BY_POS)==false) continue;
     if (magic!=0 && myIsOpenByThisEA2(OrderMagicNumber(),1)==false) continue;

     if (sym!="" && OrderSymbol()!=sym) continue;

     if (ts[OrderType()]==0) continue;
     if (myOrderOks(OrderTicket())==false) continue;
     c+=1;
   }
   return c;

}

bool myFun17_1() {
   double a=double(myFun25_1());
   double b=double(1);

   return MathAbs(a-b)<0.00000001;

}

_p_int myFun44_1() {
   ָ��ִ���˲���=0;
   string sym0=string("#");
   int slip=���������;
   static datetime err132=0;
   datetime tmlocal=TimeLocal();

   int magic=1; 
   if (0==0) magic=-2;
   else magic=0;
   if (sym0=="*") sym0=""; 
   else if (sym0=="#") sym0=sym; 
   
   int ts[10]={}; ArrayInitialize(ts,0);
   int t=7;
   if (t<=5) ts[t]=1;
   else if (t==6) ts[OP_BUY]=ts[OP_SELL]=1;
   else if (t==7) ts[OP_BUYLIMIT]=ts[OP_SELLLIMIT]=ts[OP_BUYSTOP]=ts[OP_SELLSTOP]=1;
   else ArrayInitialize(ts,1);

for (int z=0;z<5;++z) { if (z>0) { Sleep(2000); RefreshRates(); } int errc=0;
   for (int h=OrdersTotal()-1;h>=0;--h) {
      if (OrderSelect(h,SELECT_BY_POS)==false) continue;
      if (sym0!="" && OrderSymbol()!=sym0) continue;
      if (magic!=0 && myIsOpenByThisEA2(OrderMagicNumber(),1)==false) continue;
      if (ts[OrderType()]==0) continue;
      if (myOrderOks(OrderTicket())==false) continue;
      if (tmlocal-err132<60*60*6) { //��Ʒ��ea�У�err132�Ƕ�Ʒ�ֹ��õģ�Ϊ�˼���GlobalVariableGet�ĵ���
         double f=GlobalVariableGet("eano1_132_"+OrderSymbol())*1000; if (f<0) f=0;
         if (tmlocal-datetime(f)<60*60*6) {
            if (tmlocal-datetime(f)<10) continue;
            if (myMarketOpened(OrderSymbol())==false) continue;
         }
      }
      if (OrderType()==OP_BUY || OrderType()==OP_SELL) {
         if (OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),slip)==false) { errc++; int err=GetLastError(); Print("~#",OrderTicket(),"~~~~~~~ƽ�ִ���,",err); 
            if (err==132) { err132=tmlocal; GlobalVariableSet("eano1_132_"+OrderSymbol(),tmlocal/1000.0);  break; }
         }
         else ָ��ִ���˲���=1;
      }
      else {
         if (OrderDelete(OrderTicket())==false) { errc++; int err=GetLastError(); Print("~~~~~~ɾ���ҵ�����",err); 
            if (err==132) { err132=tmlocal; GlobalVariableSet("eano1_132_"+OrderSymbol(),tmlocal/1000.0);  break; }
         }
         else ָ��ִ���˲���=1;
      }
   }
if (errc==0) break; }
   
   return 0;
}

bool myFun8_1() {
   return true;

}

double myFun291_1() {
   return MarketInfo(sym,MODE_STOPLEVEL);

}
_p_int myFun32_1() {
   _m_int magic=����ʶ����;

   double a=0;
   a=double(myFun291_1());
   _mPubv[0]=double(a);

   return 0;

}

double myFun25_2() {
   if (OrdersTotal()<=0) return 0;
   int magic=1; if (0==1) magic=0;   
   int ts[10]={}; ArrayInitialize(ts,0);
   ts[OP_BUY]=0;
   ts[OP_BUYLIMIT]=0;
   ts[OP_BUYSTOP]=0;
   ts[OP_SELL]=0;
   ts[OP_SELLLIMIT]=0;
   ts[OP_SELLSTOP]=0;
   if (ts[OP_BUY]+ts[OP_BUYLIMIT]+ts[OP_BUYSTOP]+ts[OP_SELL]+ts[OP_SELLLIMIT]+ts[OP_SELLSTOP]==0) ArrayInitialize(ts,1);
   int c=0;
   for (int cnt=OrdersTotal()-1;cnt>=0;cnt--) {
     if (OrderSelect(cnt,SELECT_BY_POS)==false) continue;
     if (magic!=0 && myIsOpenByThisEA2(OrderMagicNumber(),1)==false) continue;

     if (sym!="" && OrderSymbol()!=sym) continue;

     if (ts[OrderType()]==0) continue;
     if (myOrderOks(OrderTicket())==false) continue;
     c+=1;
   }
   return c;

}

bool myFun17_2() {
   double a=double(myFun25_2());
   double b=double(15);

   return a<=b+0.00000001;

}
_p_int myFun6_1() {
   return -3;

}

double myFun25_3() {
   if (OrdersTotal()<=0) return 0;
   int magic=1; if (0==1) magic=0;   
   int ts[10]={}; ArrayInitialize(ts,0);
   ts[OP_BUY]=1;
   ts[OP_BUYLIMIT]=0;
   ts[OP_BUYSTOP]=0;
   ts[OP_SELL]=0;
   ts[OP_SELLLIMIT]=0;
   ts[OP_SELLSTOP]=0;
   if (ts[OP_BUY]+ts[OP_BUYLIMIT]+ts[OP_BUYSTOP]+ts[OP_SELL]+ts[OP_SELLLIMIT]+ts[OP_SELLSTOP]==0) ArrayInitialize(ts,1);
   int c=0;
   for (int cnt=OrdersTotal()-1;cnt>=0;cnt--) {
     if (OrderSelect(cnt,SELECT_BY_POS)==false) continue;
     if (magic!=0 && myIsOpenByThisEA2(OrderMagicNumber(),1)==false) continue;

     if (sym!="" && OrderSymbol()!=sym) continue;

     if (ts[OrderType()]==0) continue;
     if (myOrderOks(OrderTicket())==false) continue;
     c+=1;
   }
   return c;

}

bool myFun18_1() {
   double a=double(myFun25_3());
   int c=0;
   double b=double(0);

   c+=a+0.00000001>=b;

   b=double(15);

   c+=a<=b+0.00000001;

   if (c==2) return true;
   return false;
}
_p_int myFun6_2() {
   return -3;

}

bool myFun17_3() {
   double a=double(iMA(sym,0,_����1_ʱ������,_����1_ƽ��,_����1_�ƶ�ƽ��,_����1_Ӧ����,int(0+��)));
   double b=double(iMA(sym,0,_����2_ʱ������,_����2_ƽ��,_����2_�ƶ�ƽ��,_����2_Ӧ����,int(0+��)));

   return a>b;

}
_p_int myFun6_3() {
   return -3;

}

bool myFun17_4() {
   double a=double(_mPubv[0]);
   double b=double(10);

   return a>b;

}

double myFun69_1() {
   return MarketInfo(sym,MODE_ASK);

}

_p_int myFun210_1() {
   ָ��ִ���˲���=0;
   if (IsTradeAllowed()==false && IsTesting()==false) return 0;

   _m_int magic=����ʶ����;
   string comm=����ע��; if (_b��ע��) comm=_��ע��;
   int stoplevel=(int)MarketInfo(sym,MODE_STOPLEVEL);
   double pnt=MarketInfo(sym,MODE_POINT);
   double bid=MarketInfo(sym,MODE_BID);
   double ask=MarketInfo(sym,MODE_ASK);
   int type=0; 

   double op=double(myFun69_1()); if (op<0.0000001) return 0;
   int t0=int(0);
   int jg=int(_mPubv[0]);
   double lots=myLotsValid(sym,double(__����),true);
   int slt=0; double sl=double(int(__ֹ�����));
   int tpt=0; double tp=double(int(__ֹӯ����));

   if (t0==0) op+=jg*pnt;
   else op-=jg*pnt;
   
   int digit=(int)(MarketInfo(sym,MODE_DIGITS)+0.000001);
   op=NormalizeDouble(op,digit);
   double poff=stoplevel*pnt;
   
   int tt=type;
   if (tt==OP_BUY) {
      if (op>=ask+poff) type=OP_BUYSTOP;
      else if (op<=ask-poff) type=OP_BUYLIMIT;
   }
   else {
      if (op>=bid+poff) type=OP_SELLLIMIT;
      else if (op<=bid-poff) type=OP_SELLSTOP;
   }
   
   bool xj=0;

      if (tt==OP_BUY && type!=OP_BUYSTOP) { static datetime tm0=0; if (TimeCurrent()-tm0>60*60*4) { tm0=TimeCurrent(); 
         Print(sym,"~~~~~�۸񲻷��Ϲ�buystop����Ԥ�ҵ���",op,", ask=",ask,",bid=",bid," ƽ̨Ҫ��������",stoplevel,", *",pnt); } return 0; }
      if (tt==OP_SELL && type!=OP_SELLSTOP) { static datetime tm0=0; if (TimeCurrent()-tm0>60*60*4) { tm0=TimeCurrent(); 
         Print(sym,"~~~~~�۸񲻷��Ϲ�sellstop����Ԥ�ҵ���",op,", ask=",ask,",bid=",bid," ƽ̨Ҫ��������",stoplevel,", *",pnt); } return 0; }

   if (xj==1) {
      if (tt==OP_BUY) op=ask;
      else op=bid;
   }
   
   if (tt==OP_BUY) {
      if (slt==0 && sl>0.001) sl=op-sl*pnt;
      if (tpt==0 && tp>0.001) tp=op+tp*pnt;
   }
   else {
      if (slt==0 && sl>0.001) sl=op+sl*pnt;
      if (tpt==0 && tp>0.001) tp=op-tp*pnt;
   }
   
   _tn_int tn=0;
   if (xj==1) {
      tn=OrderSend(sym,tt,lots,op,���������,sl,tp,comm,magic);
      if (tn<=0) Print(sym,"~~~~~~~~~~���ִ���",GetLastError());
      else ָ��ִ���˲���=1;
   }
   else {
      tn=OrderSend(sym,type,lots,op,0,sl,tp,comm,magic);
      if (tn<=0) Print(sym,"~~~~~~~~~~�ҵ�����",GetLastError());
      else ָ��ִ���˲���=1;
   }
   return tn;
}

bool myFun17_5() {
   double a=double(_mPubv[0]);
   double b=double(10);

   return a<b;

}

double myFun69_2() {
   return MarketInfo(sym,MODE_ASK);

}

_p_int myFun210_2() {
   ָ��ִ���˲���=0;
   if (IsTradeAllowed()==false && IsTesting()==false) return 0;

   _m_int magic=����ʶ����;
   string comm=����ע��; if (_b��ע��) comm=_��ע��;
   int stoplevel=(int)MarketInfo(sym,MODE_STOPLEVEL);
   double pnt=MarketInfo(sym,MODE_POINT);
   double bid=MarketInfo(sym,MODE_BID);
   double ask=MarketInfo(sym,MODE_ASK);
   int type=0; 

   double op=double(myFun69_2()); if (op<0.0000001) return 0;
   int t0=int(0);
   int jg=int(int(__ƫ�����));
   double lots=myLotsValid(sym,double(__����),true);
   int slt=0; double sl=double(int(__ֹ�����));
   int tpt=0; double tp=double(int(__ֹӯ����));

   if (t0==0) op+=jg*pnt;
   else op-=jg*pnt;
   
   int digit=(int)(MarketInfo(sym,MODE_DIGITS)+0.000001);
   op=NormalizeDouble(op,digit);
   double poff=stoplevel*pnt;
   
   int tt=type;
   if (tt==OP_BUY) {
      if (op>=ask+poff) type=OP_BUYSTOP;
      else if (op<=ask-poff) type=OP_BUYLIMIT;
   }
   else {
      if (op>=bid+poff) type=OP_SELLLIMIT;
      else if (op<=bid-poff) type=OP_SELLSTOP;
   }
   
   bool xj=0;

      if (tt==OP_BUY && type!=OP_BUYSTOP) { static datetime tm0=0; if (TimeCurrent()-tm0>60*60*4) { tm0=TimeCurrent(); 
         Print(sym,"~~~~~�۸񲻷��Ϲ�buystop����Ԥ�ҵ���",op,", ask=",ask,",bid=",bid," ƽ̨Ҫ��������",stoplevel,", *",pnt); } return 0; }
      if (tt==OP_SELL && type!=OP_SELLSTOP) { static datetime tm0=0; if (TimeCurrent()-tm0>60*60*4) { tm0=TimeCurrent(); 
         Print(sym,"~~~~~�۸񲻷��Ϲ�sellstop����Ԥ�ҵ���",op,", ask=",ask,",bid=",bid," ƽ̨Ҫ��������",stoplevel,", *",pnt); } return 0; }

   if (xj==1) {
      if (tt==OP_BUY) op=ask;
      else op=bid;
   }
   
   if (tt==OP_BUY) {
      if (slt==0 && sl>0.001) sl=op-sl*pnt;
      if (tpt==0 && tp>0.001) tp=op+tp*pnt;
   }
   else {
      if (slt==0 && sl>0.001) sl=op+sl*pnt;
      if (tpt==0 && tp>0.001) tp=op-tp*pnt;
   }
   
   _tn_int tn=0;
   if (xj==1) {
      tn=OrderSend(sym,tt,lots,op,���������,sl,tp,comm,magic);
      if (tn<=0) Print(sym,"~~~~~~~~~~���ִ���",GetLastError());
      else ָ��ִ���˲���=1;
   }
   else {
      tn=OrderSend(sym,type,lots,op,0,sl,tp,comm,magic);
      if (tn<=0) Print(sym,"~~~~~~~~~~�ҵ�����",GetLastError());
      else ָ��ִ���˲���=1;
   }
   return tn;
}

double myFun25_4() {
   if (OrdersTotal()<=0) return 0;
   int magic=1; if (0==1) magic=0;   
   int ts[10]={}; ArrayInitialize(ts,0);
   ts[OP_BUY]=0;
   ts[OP_BUYLIMIT]=0;
   ts[OP_BUYSTOP]=0;
   ts[OP_SELL]=1;
   ts[OP_SELLLIMIT]=0;
   ts[OP_SELLSTOP]=0;
   if (ts[OP_BUY]+ts[OP_BUYLIMIT]+ts[OP_BUYSTOP]+ts[OP_SELL]+ts[OP_SELLLIMIT]+ts[OP_SELLSTOP]==0) ArrayInitialize(ts,1);
   int c=0;
   for (int cnt=OrdersTotal()-1;cnt>=0;cnt--) {
     if (OrderSelect(cnt,SELECT_BY_POS)==false) continue;
     if (magic!=0 && myIsOpenByThisEA2(OrderMagicNumber(),1)==false) continue;

     if (sym!="" && OrderSymbol()!=sym) continue;

     if (ts[OrderType()]==0) continue;
     if (myOrderOks(OrderTicket())==false) continue;
     c+=1;
   }
   return c;

}

bool myFun18_2() {
   double a=double(myFun25_4());
   int c=0;
   double b=double(0);

   c+=a+0.00000001>=b;

   b=double(15);

   c+=a<=b+0.00000001;

   if (c==2) return true;
   return false;
}
_p_int myFun6_4() {
   return -3;

}

bool myFun17_6() {
   double a=double(iMA(sym,0,_����1_ʱ������,_����1_ƽ��,_����1_�ƶ�ƽ��,_����1_Ӧ����,int(0+��)));
   double b=double(iMA(sym,0,_����2_ʱ������,_����2_ƽ��,_����2_�ƶ�ƽ��,_����2_Ӧ����,int(0+��)));

   return a<b;

}
_p_int myFun6_5() {
   return -3;

}

bool myFun17_7() {
   double a=double(_mPubv[0]);
   double b=double(10);

   return a>b;

}

double myFun70_1() {
   return MarketInfo(sym,MODE_BID);

}

_p_int myFun210_3() {
   ָ��ִ���˲���=0;
   if (IsTradeAllowed()==false && IsTesting()==false) return 0;

   _m_int magic=����ʶ����;
   string comm=����ע��; if (_b��ע��) comm=_��ע��;
   int stoplevel=(int)MarketInfo(sym,MODE_STOPLEVEL);
   double pnt=MarketInfo(sym,MODE_POINT);
   double bid=MarketInfo(sym,MODE_BID);
   double ask=MarketInfo(sym,MODE_ASK);
   int type=1; 

   double op=double(myFun70_1()); if (op<0.0000001) return 0;
   int t0=int(1);
   int jg=int(_mPubv[0]);
   double lots=myLotsValid(sym,double(__����),true);
   int slt=0; double sl=double(int(__ֹ�����));
   int tpt=0; double tp=double(int(__ֹӯ����));

   if (t0==0) op+=jg*pnt;
   else op-=jg*pnt;
   
   int digit=(int)(MarketInfo(sym,MODE_DIGITS)+0.000001);
   op=NormalizeDouble(op,digit);
   double poff=stoplevel*pnt;
   
   int tt=type;
   if (tt==OP_BUY) {
      if (op>=ask+poff) type=OP_BUYSTOP;
      else if (op<=ask-poff) type=OP_BUYLIMIT;
   }
   else {
      if (op>=bid+poff) type=OP_SELLLIMIT;
      else if (op<=bid-poff) type=OP_SELLSTOP;
   }
   
   bool xj=0;

      if (tt==OP_BUY && type!=OP_BUYSTOP) { static datetime tm0=0; if (TimeCurrent()-tm0>60*60*4) { tm0=TimeCurrent(); 
         Print(sym,"~~~~~�۸񲻷��Ϲ�buystop����Ԥ�ҵ���",op,", ask=",ask,",bid=",bid," ƽ̨Ҫ��������",stoplevel,", *",pnt); } return 0; }
      if (tt==OP_SELL && type!=OP_SELLSTOP) { static datetime tm0=0; if (TimeCurrent()-tm0>60*60*4) { tm0=TimeCurrent(); 
         Print(sym,"~~~~~�۸񲻷��Ϲ�sellstop����Ԥ�ҵ���",op,", ask=",ask,",bid=",bid," ƽ̨Ҫ��������",stoplevel,", *",pnt); } return 0; }

   if (xj==1) {
      if (tt==OP_BUY) op=ask;
      else op=bid;
   }
   
   if (tt==OP_BUY) {
      if (slt==0 && sl>0.001) sl=op-sl*pnt;
      if (tpt==0 && tp>0.001) tp=op+tp*pnt;
   }
   else {
      if (slt==0 && sl>0.001) sl=op+sl*pnt;
      if (tpt==0 && tp>0.001) tp=op-tp*pnt;
   }
   
   _tn_int tn=0;
   if (xj==1) {
      tn=OrderSend(sym,tt,lots,op,���������,sl,tp,comm,magic);
      if (tn<=0) Print(sym,"~~~~~~~~~~���ִ���",GetLastError());
      else ָ��ִ���˲���=1;
   }
   else {
      tn=OrderSend(sym,type,lots,op,0,sl,tp,comm,magic);
      if (tn<=0) Print(sym,"~~~~~~~~~~�ҵ�����",GetLastError());
      else ָ��ִ���˲���=1;
   }
   return tn;
}

bool myFun17_8() {
   double a=double(_mPubv[0]);
   double b=double(10);

   return a<b;

}

double myFun70_2() {
   return MarketInfo(sym,MODE_BID);

}

_p_int myFun210_4() {
   ָ��ִ���˲���=0;
   if (IsTradeAllowed()==false && IsTesting()==false) return 0;

   _m_int magic=����ʶ����;
   string comm=����ע��; if (_b��ע��) comm=_��ע��;
   int stoplevel=(int)MarketInfo(sym,MODE_STOPLEVEL);
   double pnt=MarketInfo(sym,MODE_POINT);
   double bid=MarketInfo(sym,MODE_BID);
   double ask=MarketInfo(sym,MODE_ASK);
   int type=1; 

   double op=double(myFun70_2()); if (op<0.0000001) return 0;
   int t0=int(1);
   int jg=int(int(__ƫ�����));
   double lots=myLotsValid(sym,double(__����),true);
   int slt=0; double sl=double(int(__ֹ�����));
   int tpt=0; double tp=double(int(__ֹӯ����));

   if (t0==0) op+=jg*pnt;
   else op-=jg*pnt;
   
   int digit=(int)(MarketInfo(sym,MODE_DIGITS)+0.000001);
   op=NormalizeDouble(op,digit);
   double poff=stoplevel*pnt;
   
   int tt=type;
   if (tt==OP_BUY) {
      if (op>=ask+poff) type=OP_BUYSTOP;
      else if (op<=ask-poff) type=OP_BUYLIMIT;
   }
   else {
      if (op>=bid+poff) type=OP_SELLLIMIT;
      else if (op<=bid-poff) type=OP_SELLSTOP;
   }
   
   bool xj=0;

      if (tt==OP_BUY && type!=OP_BUYSTOP) { static datetime tm0=0; if (TimeCurrent()-tm0>60*60*4) { tm0=TimeCurrent(); 
         Print(sym,"~~~~~�۸񲻷��Ϲ�buystop����Ԥ�ҵ���",op,", ask=",ask,",bid=",bid," ƽ̨Ҫ��������",stoplevel,", *",pnt); } return 0; }
      if (tt==OP_SELL && type!=OP_SELLSTOP) { static datetime tm0=0; if (TimeCurrent()-tm0>60*60*4) { tm0=TimeCurrent(); 
         Print(sym,"~~~~~�۸񲻷��Ϲ�sellstop����Ԥ�ҵ���",op,", ask=",ask,",bid=",bid," ƽ̨Ҫ��������",stoplevel,", *",pnt); } return 0; }

   if (xj==1) {
      if (tt==OP_BUY) op=ask;
      else op=bid;
   }
   
   if (tt==OP_BUY) {
      if (slt==0 && sl>0.001) sl=op-sl*pnt;
      if (tpt==0 && tp>0.001) tp=op+tp*pnt;
   }
   else {
      if (slt==0 && sl>0.001) sl=op+sl*pnt;
      if (tpt==0 && tp>0.001) tp=op-tp*pnt;
   }
   
   _tn_int tn=0;
   if (xj==1) {
      tn=OrderSend(sym,tt,lots,op,���������,sl,tp,comm,magic);
      if (tn<=0) Print(sym,"~~~~~~~~~~���ִ���",GetLastError());
      else ָ��ִ���˲���=1;
   }
   else {
      tn=OrderSend(sym,type,lots,op,0,sl,tp,comm,magic);
      if (tn<=0) Print(sym,"~~~~~~~~~~�ҵ�����",GetLastError());
      else ָ��ִ���˲���=1;
   }
   return tn;
}

double myFun25_5() {
   if (OrdersTotal()<=0) return 0;
   int magic=1; if (0==1) magic=0;   
   int ts[10]={}; ArrayInitialize(ts,0);
   ts[OP_BUY]=1;
   ts[OP_BUYLIMIT]=0;
   ts[OP_BUYSTOP]=0;
   ts[OP_SELL]=1;
   ts[OP_SELLLIMIT]=0;
   ts[OP_SELLSTOP]=0;
   if (ts[OP_BUY]+ts[OP_BUYLIMIT]+ts[OP_BUYSTOP]+ts[OP_SELL]+ts[OP_SELLLIMIT]+ts[OP_SELLSTOP]==0) ArrayInitialize(ts,1);
   int c=0;
   for (int cnt=OrdersTotal()-1;cnt>=0;cnt--) {
     if (OrderSelect(cnt,SELECT_BY_POS)==false) continue;
     if (magic!=0 && myIsOpenByThisEA2(OrderMagicNumber(),1)==false) continue;

     if (sym!="" && OrderSymbol()!=sym) continue;

     if (ts[OrderType()]==0) continue;
     if (myOrderOks(OrderTicket())==false) continue;
     c+=1;
   }
   return c;

}

bool myFun17_9() {
   double a=double(myFun25_5());
   double b=double(int(__ӯ������ֲ���));

   return a+0.00000001>=b;

}
_p_int myFun6_6() {
   return -3;

}

double myFun104_1() {
   if (OrdersTotal()<=0) return 0;
   _m_int magic=����ʶ����; 
   int ts[10]={}; ArrayInitialize(ts,0);
   ts[OP_BUY]=1;
   ts[OP_SELL]=1;
   if (ts[OP_BUY]+ts[OP_SELL]==0) ArrayInitialize(ts,1);
   double v=0;
   int t=0;
   for (int cnt=OrdersTotal()-1;cnt>=0;cnt--) {
     if (OrderSelect(cnt,SELECT_BY_POS)==false) continue;

     if (magic!=444 && myIsOpenByThisEA2(OrderMagicNumber(),1)==false) continue;

     if (sym!="" && OrderSymbol()!=sym) continue;

     if (ts[OrderType()]==0) continue;
     if (myOrderOks(OrderTicket())==false) continue;
     
     double v1=OrderProfit();

     v1+=OrderSwap();

     v1+=OrderCommission();

     if (t==1 && v1<0) continue;
     else if (t==2 && v1>0) continue;
     
     v+=v1;
   }
   return v;

}

bool myFun17_10() {
   double a=double(myFun104_1());
   double b=double(int(__����ӯ��));

   return a+0.00000001>=b;

}
_p_int myFun6_7() {
   return -3;

}

_p_int myFun44_2() {
   ָ��ִ���˲���=0;
   string sym0=string("#");
   int slip=���������;
   static datetime err132=0;
   datetime tmlocal=TimeLocal();

   int magic=1; 
   if (0==0) magic=-2;
   else magic=0;
   if (sym0=="*") sym0=""; 
   else if (sym0=="#") sym0=sym; 
   
   int ts[10]={}; ArrayInitialize(ts,0);
   int t=8;
   if (t<=5) ts[t]=1;
   else if (t==6) ts[OP_BUY]=ts[OP_SELL]=1;
   else if (t==7) ts[OP_BUYLIMIT]=ts[OP_SELLLIMIT]=ts[OP_BUYSTOP]=ts[OP_SELLSTOP]=1;
   else ArrayInitialize(ts,1);

for (int z=0;z<5;++z) { if (z>0) { Sleep(2000); RefreshRates(); } int errc=0;
   for (int h=OrdersTotal()-1;h>=0;--h) {
      if (OrderSelect(h,SELECT_BY_POS)==false) continue;
      if (sym0!="" && OrderSymbol()!=sym0) continue;
      if (magic!=0 && myIsOpenByThisEA2(OrderMagicNumber(),1)==false) continue;
      if (ts[OrderType()]==0) continue;
      if (myOrderOks(OrderTicket())==false) continue;
      if (tmlocal-err132<60*60*6) { //��Ʒ��ea�У�err132�Ƕ�Ʒ�ֹ��õģ�Ϊ�˼���GlobalVariableGet�ĵ���
         double f=GlobalVariableGet("eano1_132_"+OrderSymbol())*1000; if (f<0) f=0;
         if (tmlocal-datetime(f)<60*60*6) {
            if (tmlocal-datetime(f)<10) continue;
            if (myMarketOpened(OrderSymbol())==false) continue;
         }
      }
      if (OrderType()==OP_BUY || OrderType()==OP_SELL) {
         if (OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),slip)==false) { errc++; int err=GetLastError(); Print("~#",OrderTicket(),"~~~~~~~ƽ�ִ���,",err); 
            if (err==132) { err132=tmlocal; GlobalVariableSet("eano1_132_"+OrderSymbol(),tmlocal/1000.0);  break; }
         }
         else ָ��ִ���˲���=1;
      }
      else {
         if (OrderDelete(OrderTicket())==false) { errc++; int err=GetLastError(); Print("~~~~~~ɾ���ҵ�����",err); 
            if (err==132) { err132=tmlocal; GlobalVariableSet("eano1_132_"+OrderSymbol(),tmlocal/1000.0);  break; }
         }
         else ָ��ִ���˲���=1;
      }
   }
if (errc==0) break; }
   
   return 0;
}

double myFun25_6() {
   if (OrdersTotal()<=0) return 0;
   int magic=1; if (0==1) magic=0;   
   int ts[10]={}; ArrayInitialize(ts,0);
   ts[OP_BUY]=0;
   ts[OP_BUYLIMIT]=0;
   ts[OP_BUYSTOP]=0;
   ts[OP_SELL]=1;
   ts[OP_SELLLIMIT]=0;
   ts[OP_SELLSTOP]=0;
   if (ts[OP_BUY]+ts[OP_BUYLIMIT]+ts[OP_BUYSTOP]+ts[OP_SELL]+ts[OP_SELLLIMIT]+ts[OP_SELLSTOP]==0) ArrayInitialize(ts,1);
   int c=0;
   for (int cnt=OrdersTotal()-1;cnt>=0;cnt--) {
     if (OrderSelect(cnt,SELECT_BY_POS)==false) continue;
     if (magic!=0 && myIsOpenByThisEA2(OrderMagicNumber(),1)==false) continue;

     if (sym!="" && OrderSymbol()!=sym) continue;

     if (ts[OrderType()]==0) continue;
     if (myOrderOks(OrderTicket())==false) continue;
     c+=1;
   }
   return c;

}

bool myFun17_11() {
   double a=double(myFun25_6());
   double b=double(0);

   return MathAbs(a-b)<0.00000001;

}
_p_int myFun6_8() {
   return -3;

}

double myFun25_7() {
   if (OrdersTotal()<=0) return 0;
   int magic=1; if (0==1) magic=0;   
   int ts[10]={}; ArrayInitialize(ts,0);
   ts[OP_BUY]=1;
   ts[OP_BUYLIMIT]=0;
   ts[OP_BUYSTOP]=0;
   ts[OP_SELL]=0;
   ts[OP_SELLLIMIT]=0;
   ts[OP_SELLSTOP]=0;
   if (ts[OP_BUY]+ts[OP_BUYLIMIT]+ts[OP_BUYSTOP]+ts[OP_SELL]+ts[OP_SELLLIMIT]+ts[OP_SELLSTOP]==0) ArrayInitialize(ts,1);
   int c=0;
   for (int cnt=OrdersTotal()-1;cnt>=0;cnt--) {
     if (OrderSelect(cnt,SELECT_BY_POS)==false) continue;
     if (magic!=0 && myIsOpenByThisEA2(OrderMagicNumber(),1)==false) continue;

     if (sym!="" && OrderSymbol()!=sym) continue;

     if (ts[OrderType()]==0) continue;
     if (myOrderOks(OrderTicket())==false) continue;
     c+=1;
   }
   return c;

}

bool myFun17_12() {
   double a=double(myFun25_7());
   double b=double(int(__��������ֲ���));

   return a+0.00000001>=b;

}
_p_int myFun6_9() {
   return -3;

}

double myFun104_2() {
   if (OrdersTotal()<=0) return 0;
   _m_int magic=����ʶ����; 
   int ts[10]={}; ArrayInitialize(ts,0);
   ts[OP_BUY]=1;
   ts[OP_SELL]=0;
   if (ts[OP_BUY]+ts[OP_SELL]==0) ArrayInitialize(ts,1);
   double v=0;
   int t=0;
   for (int cnt=OrdersTotal()-1;cnt>=0;cnt--) {
     if (OrderSelect(cnt,SELECT_BY_POS)==false) continue;

     if (magic!=444 && myIsOpenByThisEA2(OrderMagicNumber(),1)==false) continue;

     if (sym!="" && OrderSymbol()!=sym) continue;

     if (ts[OrderType()]==0) continue;
     if (myOrderOks(OrderTicket())==false) continue;
     
     double v1=OrderProfit();

     v1+=OrderSwap();

     v1+=OrderCommission();

     if (t==1 && v1<0) continue;
     else if (t==2 && v1>0) continue;
     
     v+=v1;
   }
   return v;

}

bool myFun17_13() {
   double a=double(myFun104_2());
   double b=double(int(__���������));

   return a<b;

}
_p_int myFun6_10() {
   return -3;

}

double myFun376_1() {
   int magic=0; 
   if (magic==0) magic=-2;
   else magic=0;
   int ts[10]={}; ArrayInitialize(ts,0);
   ts[OP_BUY]=1;
   ts[OP_BUYLIMIT]=0;
   ts[OP_BUYSTOP]=0;
   ts[OP_SELL]=0;
   ts[OP_SELLLIMIT]=0;
   ts[OP_SELLSTOP]=0;
   if (ts[OP_BUY]+ts[OP_BUYLIMIT]+ts[OP_BUYSTOP]+ts[OP_SELL]+ts[OP_SELLLIMIT]+ts[OP_SELLSTOP]==0) ArrayInitialize(ts,1);
   datetime begtime=myTimeVar(101);
   int excHis=1;
   double c=0;
   if (excHis==0) {
      int hc=OrdersHistoryTotal();
      for (int h=hc-1;h>=0;--h) {
         if (OrderSelect(h,SELECT_BY_POS,MODE_HISTORY)==false) continue;

         if (sym!="" && OrderSymbol()!=sym) continue;

         if (magic!=0 && myIsOpenByThisEA2(OrderMagicNumber(),1)==false) continue;
         if (OrderCloseTime()<begtime) break;
         if (ts[OrderType()]==0) continue;
         if (myOrderHisOks(OrderTicket())==false) continue;
         if (OrderOpenTime()>=begtime)
            c+=OrderLots();
      }
   }
   for (int h=OrdersTotal()-1;h>=0;--h) {
      if (OrderSelect(h,SELECT_BY_POS)==false) continue;

      if (sym!="" && OrderSymbol()!=sym) continue;

      if (magic!=0 && myIsOpenByThisEA2(OrderMagicNumber(),1)==false) continue;
      if (ts[OrderType()]==0) continue;
      if (myOrderOks(OrderTicket())==false) continue;
      if (OrderOpenTime()>=begtime)
         c+=OrderLots();
   }
   return c;

}

bool myFun17_14() {
   double a=double(myFun376_1());
   double b=double(0.15);

   return a<=b+0.00000001;

}
_p_int myFun6_11() {
   return -3;

}

bool myFun8_2() {
   return true;

}

double myFun574_1() {
   double pp=0,ls[2]={0,0}; int oc=0;
   for(int pos=OrdersTotal()-1;pos>=0;pos--)           {
      if (OrderSelect(pos,SELECT_BY_POS)==false) continue;

      if (myIsOpenByThisEA2(OrderMagicNumber(),1)==false) continue;

      if (OrderSymbol()!=sym) continue;
      int t=OrderType(); if (t!=OP_BUY && t!=OP_SELL) continue;

      if (t!=0) continue;

      if (myOrderOks(OrderTicket())==false) continue;
      oc+=1;
      pp+=OrderProfit();

      pp+=OrderSwap();

      pp+=OrderCommission();

      ls[t]+=OrderLots();
   }
   if (oc==0) return 0;
   double lsx=MathAbs(ls[0]-ls[1]); if (lsx<0.0001) return 0;
   //���ת��ֵ
   double pnt=MarketInfo(sym,MODE_POINT);
   double tk=MarketInfo(sym,MODE_TICKSIZE); if (tk<pnt) tk=pnt;
   double pv=MarketInfo(sym,MODE_TICKVALUE)/(tk/pnt);
   if (tk==0 || pnt==0 || pv==0) return 0;
   pp/=pv*lsx;
   int p2=(int)MathFloor(pp); //����Ǹ��������ȡ����ĸ������������������Ӧ�û�ȡ��С������������۳�̫����޷�����
   double cp=0;
   if (ls[0]>ls[1]) cp=MarketInfo(sym,MODE_BID)-p2*pnt;
   else cp=MarketInfo(sym,MODE_ASK)+p2*pnt;
   return cp;
}

_p_int myFun32_2() {
   _m_int magic=����ʶ����;

   double a=0;
   a=double(myFun574_1());
   _mPubv[0]=double(a);

   return 0;

}

_p_int myFun139_1() {
   ָ��ִ���˲���=0;
   if (TerminalInfoInteger(TERMINAL_TRADE_ALLOWED)==false && IsTesting()==false) return 0;

   _m_int magic=����ʶ����;
   int slip=���������;
   string comm=����ע��; if (_b��ע��) comm=_��ע��;

   double pnt=MarketInfo(sym,MODE_POINT);

   int type=1; 

   double lots=myLotsValid(sym,0.3,true);
   double sl=double(_mPubv[0]*_��ϵ��);
   double tp=double(0*_��ϵ��);

   for(int pos=OrdersTotal()-1;pos>=0;pos--)           {
      if (OrderSelect(pos,SELECT_BY_POS)==false) continue;
      if (magic!=444 && myIsOpenByThisEA2(OrderMagicNumber(),1)==false) continue;
      if (sym!="" && OrderSymbol()!=sym) continue;
      if (myOrderOks(OrderTicket())==false) continue;

   }

_tn_int tn=0;
for (int w=0;w<1+0;++w) { if (w>0) { Sleep(3000); Alert("~~~m=",magic,"~~~slip=",slip,"~~~~~��������",w); RefreshRates(); } 
   double op=0;
   if (type==OP_BUY) {
      op=MarketInfo(sym,MODE_ASK);
      if (sl>0.001) sl=op-sl*MarketInfo(sym,MODE_POINT);
      if (tp>0.001) tp=op+tp*MarketInfo(sym,MODE_POINT);
   }
   else if (type==OP_SELL) {
      op=MarketInfo(sym,MODE_BID);
      if (sl>0.001) sl=op+sl*MarketInfo(sym,MODE_POINT);
      if (tp>0.001) tp=op-tp*MarketInfo(sym,MODE_POINT);
   }
   else return 0;
   tn=OrderSend(sym,type,lots,op,slip,sl,tp,comm,magic);
   if (tn>0 && myOpenOk(tn,type)==false) return 0;
   if (tn>0 && w>0) Alert("~~~~���Խ��ֳɹ�");
   if (tn<=0) {
      int err=GetLastError();
      if (err==134) { Alert("~~~~~~~~~~��֤���㣬����������Ч��",lots); Sleep(3000); return 0; }
      else if (err>=135 && err<=138) { Alert("~~m=",magic,"~~~��������ƽ̨��������~~~~~����ʧ�ܣ�",err); continue; }
      else Alert("~~m=",magic,"~~~~~~~~����ʧ�ܣ�",err);
      Sleep(3000); break; 
   }

   if (tn>0) { ָ��ִ���˲���=1; break; }
}   
   return tn;

}

double myFun25_8() {
   if (OrdersTotal()<=0) return 0;
   int magic=1; if (0==1) magic=0;   
   int ts[10]={}; ArrayInitialize(ts,0);
   ts[OP_BUY]=1;
   ts[OP_BUYLIMIT]=0;
   ts[OP_BUYSTOP]=0;
   ts[OP_SELL]=0;
   ts[OP_SELLLIMIT]=0;
   ts[OP_SELLSTOP]=0;
   if (ts[OP_BUY]+ts[OP_BUYLIMIT]+ts[OP_BUYSTOP]+ts[OP_SELL]+ts[OP_SELLLIMIT]+ts[OP_SELLSTOP]==0) ArrayInitialize(ts,1);
   int c=0;
   for (int cnt=OrdersTotal()-1;cnt>=0;cnt--) {
     if (OrderSelect(cnt,SELECT_BY_POS)==false) continue;
     if (magic!=0 && myIsOpenByThisEA2(OrderMagicNumber(),1)==false) continue;

     if (sym!="" && OrderSymbol()!=sym) continue;

     if (ts[OrderType()]==0) continue;
     if (myOrderOks(OrderTicket())==false) continue;
     c+=1;
   }
   return c;

}

bool myFun17_15() {
   double a=double(myFun25_8());
   double b=double(0);

   return MathAbs(a-b)<0.00000001;

}
_p_int myFun6_12() {
   return -3;

}

double myFun25_9() {
   if (OrdersTotal()<=0) return 0;
   int magic=1; if (0==1) magic=0;   
   int ts[10]={}; ArrayInitialize(ts,0);
   ts[OP_BUY]=0;
   ts[OP_BUYLIMIT]=0;
   ts[OP_BUYSTOP]=0;
   ts[OP_SELL]=1;
   ts[OP_SELLLIMIT]=0;
   ts[OP_SELLSTOP]=0;
   if (ts[OP_BUY]+ts[OP_BUYLIMIT]+ts[OP_BUYSTOP]+ts[OP_SELL]+ts[OP_SELLLIMIT]+ts[OP_SELLSTOP]==0) ArrayInitialize(ts,1);
   int c=0;
   for (int cnt=OrdersTotal()-1;cnt>=0;cnt--) {
     if (OrderSelect(cnt,SELECT_BY_POS)==false) continue;
     if (magic!=0 && myIsOpenByThisEA2(OrderMagicNumber(),1)==false) continue;

     if (sym!="" && OrderSymbol()!=sym) continue;

     if (ts[OrderType()]==0) continue;
     if (myOrderOks(OrderTicket())==false) continue;
     c+=1;
   }
   return c;

}

bool myFun17_16() {
   double a=double(myFun25_9());
   double b=double(int(__��������ֲ���));

   return a+0.00000001>=b;

}
_p_int myFun6_13() {
   return -3;

}

double myFun104_3() {
   if (OrdersTotal()<=0) return 0;
   _m_int magic=����ʶ����; 
   int ts[10]={}; ArrayInitialize(ts,0);
   ts[OP_BUY]=0;
   ts[OP_SELL]=1;
   if (ts[OP_BUY]+ts[OP_SELL]==0) ArrayInitialize(ts,1);
   double v=0;
   int t=0;
   for (int cnt=OrdersTotal()-1;cnt>=0;cnt--) {
     if (OrderSelect(cnt,SELECT_BY_POS)==false) continue;

     if (magic!=444 && myIsOpenByThisEA2(OrderMagicNumber(),1)==false) continue;

     if (sym!="" && OrderSymbol()!=sym) continue;

     if (ts[OrderType()]==0) continue;
     if (myOrderOks(OrderTicket())==false) continue;
     
     double v1=OrderProfit();

     v1+=OrderSwap();

     v1+=OrderCommission();

     if (t==1 && v1<0) continue;
     else if (t==2 && v1>0) continue;
     
     v+=v1;
   }
   return v;

}

bool myFun17_17() {
   double a=double(myFun104_3());
   double b=double(int(__���������));

   return a<b;

}
_p_int myFun6_14() {
   return -3;

}

double myFun376_2() {
   int magic=0; 
   if (magic==0) magic=-2;
   else magic=0;
   int ts[10]={}; ArrayInitialize(ts,0);
   ts[OP_BUY]=0;
   ts[OP_BUYLIMIT]=0;
   ts[OP_BUYSTOP]=0;
   ts[OP_SELL]=1;
   ts[OP_SELLLIMIT]=0;
   ts[OP_SELLSTOP]=0;
   if (ts[OP_BUY]+ts[OP_BUYLIMIT]+ts[OP_BUYSTOP]+ts[OP_SELL]+ts[OP_SELLLIMIT]+ts[OP_SELLSTOP]==0) ArrayInitialize(ts,1);
   datetime begtime=myTimeVar(101);
   int excHis=1;
   double c=0;
   if (excHis==0) {
      int hc=OrdersHistoryTotal();
      for (int h=hc-1;h>=0;--h) {
         if (OrderSelect(h,SELECT_BY_POS,MODE_HISTORY)==false) continue;

         if (sym!="" && OrderSymbol()!=sym) continue;

         if (magic!=0 && myIsOpenByThisEA2(OrderMagicNumber(),1)==false) continue;
         if (OrderCloseTime()<begtime) break;
         if (ts[OrderType()]==0) continue;
         if (myOrderHisOks(OrderTicket())==false) continue;
         if (OrderOpenTime()>=begtime)
            c+=OrderLots();
      }
   }
   for (int h=OrdersTotal()-1;h>=0;--h) {
      if (OrderSelect(h,SELECT_BY_POS)==false) continue;

      if (sym!="" && OrderSymbol()!=sym) continue;

      if (magic!=0 && myIsOpenByThisEA2(OrderMagicNumber(),1)==false) continue;
      if (ts[OrderType()]==0) continue;
      if (myOrderOks(OrderTicket())==false) continue;
      if (OrderOpenTime()>=begtime)
         c+=OrderLots();
   }
   return c;

}

bool myFun17_18() {
   double a=double(myFun376_2());
   double b=double(0.15);

   return a<=b+0.00000001;

}
_p_int myFun6_15() {
   return -3;

}

bool myFun8_3() {
   return true;

}

double myFun574_2() {
   double pp=0,ls[2]={0,0}; int oc=0;
   for(int pos=OrdersTotal()-1;pos>=0;pos--)           {
      if (OrderSelect(pos,SELECT_BY_POS)==false) continue;

      if (myIsOpenByThisEA2(OrderMagicNumber(),1)==false) continue;

      if (OrderSymbol()!=sym) continue;
      int t=OrderType(); if (t!=OP_BUY && t!=OP_SELL) continue;

      if (t!=0) continue;

      if (myOrderOks(OrderTicket())==false) continue;
      oc+=1;
      pp+=OrderProfit();

      pp+=OrderSwap();

      pp+=OrderCommission();

      ls[t]+=OrderLots();
   }
   if (oc==0) return 0;
   double lsx=MathAbs(ls[0]-ls[1]); if (lsx<0.0001) return 0;
   //���ת��ֵ
   double pnt=MarketInfo(sym,MODE_POINT);
   double tk=MarketInfo(sym,MODE_TICKSIZE); if (tk<pnt) tk=pnt;
   double pv=MarketInfo(sym,MODE_TICKVALUE)/(tk/pnt);
   if (tk==0 || pnt==0 || pv==0) return 0;
   pp/=pv*lsx;
   int p2=(int)MathFloor(pp); //����Ǹ��������ȡ����ĸ������������������Ӧ�û�ȡ��С������������۳�̫����޷�����
   double cp=0;
   if (ls[0]>ls[1]) cp=MarketInfo(sym,MODE_BID)-p2*pnt;
   else cp=MarketInfo(sym,MODE_ASK)+p2*pnt;
   return cp;
}

_p_int myFun32_3() {
   _m_int magic=����ʶ����;

   double a=0;
   a=double(myFun574_2());
   _mPubv[0]=double(a);

   return 0;

}

_p_int myFun139_2() {
   ָ��ִ���˲���=0;
   if (TerminalInfoInteger(TERMINAL_TRADE_ALLOWED)==false && IsTesting()==false) return 0;

   _m_int magic=����ʶ����;
   int slip=���������;
   string comm=����ע��; if (_b��ע��) comm=_��ע��;

   double pnt=MarketInfo(sym,MODE_POINT);

   int type=0; 

   double lots=myLotsValid(sym,0.3,true);
   double sl=double(_mPubv[0]*_��ϵ��);
   double tp=double(0*_��ϵ��);

   for(int pos=OrdersTotal()-1;pos>=0;pos--)           {
      if (OrderSelect(pos,SELECT_BY_POS)==false) continue;
      if (magic!=444 && myIsOpenByThisEA2(OrderMagicNumber(),1)==false) continue;
      if (sym!="" && OrderSymbol()!=sym) continue;
      if (myOrderOks(OrderTicket())==false) continue;

   }

_tn_int tn=0;
for (int w=0;w<1+0;++w) { if (w>0) { Sleep(3000); Alert("~~~m=",magic,"~~~slip=",slip,"~~~~~��������",w); RefreshRates(); } 
   double op=0;
   if (type==OP_BUY) {
      op=MarketInfo(sym,MODE_ASK);
      if (sl>0.001) sl=op-sl*MarketInfo(sym,MODE_POINT);
      if (tp>0.001) tp=op+tp*MarketInfo(sym,MODE_POINT);
   }
   else if (type==OP_SELL) {
      op=MarketInfo(sym,MODE_BID);
      if (sl>0.001) sl=op+sl*MarketInfo(sym,MODE_POINT);
      if (tp>0.001) tp=op-tp*MarketInfo(sym,MODE_POINT);
   }
   else return 0;
   tn=OrderSend(sym,type,lots,op,slip,sl,tp,comm,magic);
   if (tn>0 && myOpenOk(tn,type)==false) return 0;
   if (tn>0 && w>0) Alert("~~~~���Խ��ֳɹ�");
   if (tn<=0) {
      int err=GetLastError();
      if (err==134) { Alert("~~~~~~~~~~��֤���㣬����������Ч��",lots); Sleep(3000); return 0; }
      else if (err>=135 && err<=138) { Alert("~~m=",magic,"~~~��������ƽ̨��������~~~~~����ʧ�ܣ�",err); continue; }
      else Alert("~~m=",magic,"~~~~~~~~����ʧ�ܣ�",err);
      Sleep(3000); break; 
   }

   if (tn>0) { ָ��ִ���˲���=1; break; }
}   
   return tn;

}

bool myFun81_1() {
   bool a=(bool)int(__����ƽ������); //��������û����ܰ��ַ��������Ϳ��ز���ͬ�����Ӷ������ַ�������
                          //������ɵ��߼������û������������ھ��ܷ�������һ�п��ز���
   bool b=1;
   return a==b;

}
_p_int myFun6_16() {
   return -3;

}

double myFun25_10() {
   if (OrdersTotal()<=0) return 0;
   int magic=1; if (0==1) magic=0;   
   int ts[10]={}; ArrayInitialize(ts,0);
   ts[OP_BUY]=1;
   ts[OP_BUYLIMIT]=0;
   ts[OP_BUYSTOP]=0;
   ts[OP_SELL]=1;
   ts[OP_SELLLIMIT]=0;
   ts[OP_SELLSTOP]=0;
   if (ts[OP_BUY]+ts[OP_BUYLIMIT]+ts[OP_BUYSTOP]+ts[OP_SELL]+ts[OP_SELLLIMIT]+ts[OP_SELLSTOP]==0) ArrayInitialize(ts,1);
   int c=0;
   for (int cnt=OrdersTotal()-1;cnt>=0;cnt--) {
     if (OrderSelect(cnt,SELECT_BY_POS)==false) continue;
     if (magic!=0 && myIsOpenByThisEA2(OrderMagicNumber(),1)==false) continue;

     if (sym!="" && OrderSymbol()!=sym) continue;

     if (ts[OrderType()]==0) continue;
     if (myOrderOks(OrderTicket())==false) continue;
     c+=1;
   }
   return c;

}

bool myFun17_19() {
   double a=double(myFun25_10());
   double b=double(15);

   return a<b;

}

_p_int myFun72_1() {
   ָ��ִ���˲���=0;
   int magic=1; if (0==1) magic=0;   
   int digit=(int)MarketInfo(sym,MODE_DIGITS);
   double pnt=MarketInfo(sym,MODE_POINT);
   double beg=double(int(__ͬ�����ӯ�����㿪ʼִ��)); 
   double lock=double(int(__��������ӯ��)); 
   //if (beg<pnt) return 0;
   int minc=int(int(__ͬ�򵥴���ڼ�����ִ��)); 
   double ask=MarketInfo(sym,MODE_ASK);
   double bid=MarketInfo(sym,MODE_BID);
   int stoplevel=(int)MarketInfo(sym,MODE_STOPLEVEL);
   
   double op[2]={0,0},ls[2]={0,0}; int oc[2]={0,0};
   for(int pos=OrdersTotal()-1;pos>=0;pos--)           {
      if (OrderSelect(pos,SELECT_BY_POS)==false) continue;
      if (magic!=0 && myIsOpenByThisEA2(OrderMagicNumber(),1)==false) continue;
      if (sym!="" && OrderSymbol()!=sym) continue;
      int t=OrderType(); if (t!=OP_BUY && t!=OP_SELL) continue;
      if (myOrderOks(OrderTicket())==false) continue;
      op[t]+=OrderOpenPrice()*OrderLots(); ls[t]+=OrderLots(); oc[t]+=1;
   }
   for (int i=0;i<2;++i) {
      if (oc[i]==0) continue;
      op[i]/=ls[i]; op[i]=NormalizeDouble(op[i],digit);
   }

   //�޸�ֹ���
   int z=0;

   if (oc[z]>0 && oc[z]>=minc && bid-op[z]>=beg*pnt) { int type=OP_BUY; double slaver=op[z]+lock*pnt;
      for(int pos=OrdersTotal()-1;pos>=0;pos--) {
         if (OrderSelect(pos,SELECT_BY_POS)==false) continue;
         if (magic!=0 && myIsOpenByThisEA2(OrderMagicNumber(),1)==false) continue;
         if (sym!="" && OrderSymbol()!=sym) continue;
         if (OrderType()!=type) continue;
         if (myOrderOks(OrderTicket())==false) continue;
         if (MathAbs(OrderStopLoss()-slaver)<pnt) continue;
         if (OrderStopLoss()>pnt && slaver<OrderStopLoss()) continue;
         if (OrderModify(OrderTicket(),OrderOpenPrice(),slaver,OrderTakeProfit(),OrderExpiration())==false) 
            Print("����ƽ�� buyֹ���޸�ʧ��#",OrderTicket(),",",OrderSymbol(),",",GetLastError(),",#",OrderTicket(),", newsl=",slaver);
         else ָ��ִ���˲���=1;
      }
   }

   z=1;
   if (oc[z]>0 && oc[z]>=minc && op[z]-ask>=beg*pnt) { int type=OP_SELL; double slaver=op[z]-lock*pnt;
      for(int pos=OrdersTotal()-1;pos>=0;pos--) {
         if (OrderSelect(pos,SELECT_BY_POS)==false) continue;
         if (magic!=0 && myIsOpenByThisEA2(OrderMagicNumber(),1)==false) continue;
         if (sym!="" && OrderSymbol()!=sym) continue;
         if (OrderType()!=type) continue;
         if (myOrderOks(OrderTicket())==false) continue;
         if (MathAbs(OrderStopLoss()-slaver)<pnt) continue;
         if (OrderStopLoss()>pnt && slaver>OrderStopLoss()) continue;
         if (OrderModify(OrderTicket(),OrderOpenPrice(),slaver,OrderTakeProfit(),OrderExpiration())==false) 
            Print("����ƽ�� sellֹ���޸�ʧ��#",OrderTicket(),",",OrderSymbol(),",",GetLastError(),",#",OrderTicket(),", newsl=",slaver);
         else ָ��ִ���˲���=1;
      }
   }

   return 0;

}

bool myFun17_20() {
   double a=double(iMA(sym,period,_����1_ʱ������,_����1_ƽ��,_����1_�ƶ�ƽ��,_����1_Ӧ����,int(0+��)));
   double b=double(iMA(sym,period,_����2_ʱ������,_����2_ƽ��,_����2_�ƶ�ƽ��,_����2_Ӧ����,int(0+��)));

   return a>b;

}
_p_int myFun6_17() {
   return -3;

}

double myFun25_11() {
   if (OrdersTotal()<=0) return 0;
   int magic=1; if (0==1) magic=0;   
   int ts[10]={}; ArrayInitialize(ts,0);
   ts[OP_BUY]=0;
   ts[OP_BUYLIMIT]=0;
   ts[OP_BUYSTOP]=0;
   ts[OP_SELL]=1;
   ts[OP_SELLLIMIT]=0;
   ts[OP_SELLSTOP]=0;
   if (ts[OP_BUY]+ts[OP_BUYLIMIT]+ts[OP_BUYSTOP]+ts[OP_SELL]+ts[OP_SELLLIMIT]+ts[OP_SELLSTOP]==0) ArrayInitialize(ts,1);
   int c=0;
   for (int cnt=OrdersTotal()-1;cnt>=0;cnt--) {
     if (OrderSelect(cnt,SELECT_BY_POS)==false) continue;
     if (magic!=0 && myIsOpenByThisEA2(OrderMagicNumber(),1)==false) continue;

     if (sym!="" && OrderSymbol()!=sym) continue;

     if (ts[OrderType()]==0) continue;
     if (myOrderOks(OrderTicket())==false) continue;
     c+=1;
   }
   return c;

}

bool myFun17_21() {
   double a=double(myFun25_11());
   double b=double(int(__��������ֲ���));

   return a+0.00000001>=b;

}
_p_int myFun6_18() {
   return -3;

}

double myFun104_4() {
   if (OrdersTotal()<=0) return 0;
   _m_int magic=����ʶ����; 
   int ts[10]={}; ArrayInitialize(ts,0);
   ts[OP_BUY]=0;
   ts[OP_SELL]=1;
   if (ts[OP_BUY]+ts[OP_SELL]==0) ArrayInitialize(ts,1);
   double v=0;
   int t=0;
   for (int cnt=OrdersTotal()-1;cnt>=0;cnt--) {
     if (OrderSelect(cnt,SELECT_BY_POS)==false) continue;

     if (magic!=444 && myIsOpenByThisEA2(OrderMagicNumber(),1)==false) continue;

     if (sym!="" && OrderSymbol()!=sym) continue;

     if (ts[OrderType()]==0) continue;
     if (myOrderOks(OrderTicket())==false) continue;
     
     double v1=OrderProfit();

     v1+=OrderSwap();

     v1+=OrderCommission();

     if (t==1 && v1<0) continue;
     else if (t==2 && v1>0) continue;
     
     v+=v1;
   }
   return v;

}

bool myFun17_22() {
   double a=double(myFun104_4());
   double b=double(int(__���������));

   return a<b;

}
_p_int myFun6_19() {
   return -3;

}

_p_int myFun44_3() {
   ָ��ִ���˲���=0;
   string sym0=string("#");
   int slip=���������;
   static datetime err132=0;
   datetime tmlocal=TimeLocal();

   int magic=1; 
   if (0==0) magic=-2;
   else magic=0;
   if (sym0=="*") sym0=""; 
   else if (sym0=="#") sym0=sym; 
   
   int ts[10]={}; ArrayInitialize(ts,0);
   int t=1;
   if (t<=5) ts[t]=1;
   else if (t==6) ts[OP_BUY]=ts[OP_SELL]=1;
   else if (t==7) ts[OP_BUYLIMIT]=ts[OP_SELLLIMIT]=ts[OP_BUYSTOP]=ts[OP_SELLSTOP]=1;
   else ArrayInitialize(ts,1);

for (int z=0;z<5;++z) { if (z>0) { Sleep(2000); RefreshRates(); } int errc=0;
   for (int h=OrdersTotal()-1;h>=0;--h) {
      if (OrderSelect(h,SELECT_BY_POS)==false) continue;
      if (sym0!="" && OrderSymbol()!=sym0) continue;
      if (magic!=0 && myIsOpenByThisEA2(OrderMagicNumber(),1)==false) continue;
      if (ts[OrderType()]==0) continue;
      if (myOrderOks(OrderTicket())==false) continue;
      if (tmlocal-err132<60*60*6) { //��Ʒ��ea�У�err132�Ƕ�Ʒ�ֹ��õģ�Ϊ�˼���GlobalVariableGet�ĵ���
         double f=GlobalVariableGet("eano1_132_"+OrderSymbol())*1000; if (f<0) f=0;
         if (tmlocal-datetime(f)<60*60*6) {
            if (tmlocal-datetime(f)<10) continue;
            if (myMarketOpened(OrderSymbol())==false) continue;
         }
      }
      if (OrderType()==OP_BUY || OrderType()==OP_SELL) {
         if (OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),slip)==false) { errc++; int err=GetLastError(); Print("~#",OrderTicket(),"~~~~~~~ƽ�ִ���,",err); 
            if (err==132) { err132=tmlocal; GlobalVariableSet("eano1_132_"+OrderSymbol(),tmlocal/1000.0);  break; }
         }
         else ָ��ִ���˲���=1;
      }
      else {
         if (OrderDelete(OrderTicket())==false) { errc++; int err=GetLastError(); Print("~~~~~~ɾ���ҵ�����",err); 
            if (err==132) { err132=tmlocal; GlobalVariableSet("eano1_132_"+OrderSymbol(),tmlocal/1000.0);  break; }
         }
         else ָ��ִ���˲���=1;
      }
   }
if (errc==0) break; }
   
   return 0;
}

bool myFun17_23() {
   double a=double(iMA(sym,period,_����1_ʱ������,_����1_ƽ��,_����1_�ƶ�ƽ��,_����1_Ӧ����,int(0+��)));
   double b=double(iMA(sym,period,_����2_ʱ������,_����2_ƽ��,_����2_�ƶ�ƽ��,_����2_Ӧ����,int(0+��)));

   return a<b;

}
_p_int myFun6_20() {
   return -3;

}

double myFun25_12() {
   if (OrdersTotal()<=0) return 0;
   int magic=1; if (0==1) magic=0;   
   int ts[10]={}; ArrayInitialize(ts,0);
   ts[OP_BUY]=1;
   ts[OP_BUYLIMIT]=0;
   ts[OP_BUYSTOP]=0;
   ts[OP_SELL]=0;
   ts[OP_SELLLIMIT]=0;
   ts[OP_SELLSTOP]=0;
   if (ts[OP_BUY]+ts[OP_BUYLIMIT]+ts[OP_BUYSTOP]+ts[OP_SELL]+ts[OP_SELLLIMIT]+ts[OP_SELLSTOP]==0) ArrayInitialize(ts,1);
   int c=0;
   for (int cnt=OrdersTotal()-1;cnt>=0;cnt--) {
     if (OrderSelect(cnt,SELECT_BY_POS)==false) continue;
     if (magic!=0 && myIsOpenByThisEA2(OrderMagicNumber(),1)==false) continue;

     if (sym!="" && OrderSymbol()!=sym) continue;

     if (ts[OrderType()]==0) continue;
     if (myOrderOks(OrderTicket())==false) continue;
     c+=1;
   }
   return c;

}

bool myFun17_24() {
   double a=double(myFun25_12());
   double b=double(int(__��������ֲ���));

   return a+0.00000001>=b;

}
_p_int myFun6_21() {
   return -3;

}

double myFun104_5() {
   if (OrdersTotal()<=0) return 0;
   _m_int magic=����ʶ����; 
   int ts[10]={}; ArrayInitialize(ts,0);
   ts[OP_BUY]=1;
   ts[OP_SELL]=0;
   if (ts[OP_BUY]+ts[OP_SELL]==0) ArrayInitialize(ts,1);
   double v=0;
   int t=0;
   for (int cnt=OrdersTotal()-1;cnt>=0;cnt--) {
     if (OrderSelect(cnt,SELECT_BY_POS)==false) continue;

     if (magic!=444 && myIsOpenByThisEA2(OrderMagicNumber(),1)==false) continue;

     if (sym!="" && OrderSymbol()!=sym) continue;

     if (ts[OrderType()]==0) continue;
     if (myOrderOks(OrderTicket())==false) continue;
     
     double v1=OrderProfit();

     v1+=OrderSwap();

     v1+=OrderCommission();

     if (t==1 && v1<0) continue;
     else if (t==2 && v1>0) continue;
     
     v+=v1;
   }
   return v;

}

bool myFun17_25() {
   double a=double(myFun104_5());
   double b=double(int(__���������));

   return a<b;

}
_p_int myFun6_22() {
   return -3;

}

_p_int myFun44_4() {
   ָ��ִ���˲���=0;
   string sym0=string("#");
   int slip=���������;
   static datetime err132=0;
   datetime tmlocal=TimeLocal();

   int magic=1; 
   if (0==0) magic=-2;
   else magic=0;
   if (sym0=="*") sym0=""; 
   else if (sym0=="#") sym0=sym; 
   
   int ts[10]={}; ArrayInitialize(ts,0);
   int t=0;
   if (t<=5) ts[t]=1;
   else if (t==6) ts[OP_BUY]=ts[OP_SELL]=1;
   else if (t==7) ts[OP_BUYLIMIT]=ts[OP_SELLLIMIT]=ts[OP_BUYSTOP]=ts[OP_SELLSTOP]=1;
   else ArrayInitialize(ts,1);

for (int z=0;z<5;++z) { if (z>0) { Sleep(2000); RefreshRates(); } int errc=0;
   for (int h=OrdersTotal()-1;h>=0;--h) {
      if (OrderSelect(h,SELECT_BY_POS)==false) continue;
      if (sym0!="" && OrderSymbol()!=sym0) continue;
      if (magic!=0 && myIsOpenByThisEA2(OrderMagicNumber(),1)==false) continue;
      if (ts[OrderType()]==0) continue;
      if (myOrderOks(OrderTicket())==false) continue;
      if (tmlocal-err132<60*60*6) { //��Ʒ��ea�У�err132�Ƕ�Ʒ�ֹ��õģ�Ϊ�˼���GlobalVariableGet�ĵ���
         double f=GlobalVariableGet("eano1_132_"+OrderSymbol())*1000; if (f<0) f=0;
         if (tmlocal-datetime(f)<60*60*6) {
            if (tmlocal-datetime(f)<10) continue;
            if (myMarketOpened(OrderSymbol())==false) continue;
         }
      }
      if (OrderType()==OP_BUY || OrderType()==OP_SELL) {
         if (OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),slip)==false) { errc++; int err=GetLastError(); Print("~#",OrderTicket(),"~~~~~~~ƽ�ִ���,",err); 
            if (err==132) { err132=tmlocal; GlobalVariableSet("eano1_132_"+OrderSymbol(),tmlocal/1000.0);  break; }
         }
         else ָ��ִ���˲���=1;
      }
      else {
         if (OrderDelete(OrderTicket())==false) { errc++; int err=GetLastError(); Print("~~~~~~ɾ���ҵ�����",err); 
            if (err==132) { err132=tmlocal; GlobalVariableSet("eano1_132_"+OrderSymbol(),tmlocal/1000.0);  break; }
         }
         else ָ��ִ���˲���=1;
      }
   }
if (errc==0) break; }
   
   return 0;
}
