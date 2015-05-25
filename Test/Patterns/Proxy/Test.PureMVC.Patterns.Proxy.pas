unit Test.PureMVC.Patterns.Proxy;
{
  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit
  being tested.

}

interface

uses
  TestFramework,
  PureMVC.Interfaces.IObserver;

type
  TestTProxy = class(TTestCase)
  private
  published
    procedure TestConstructor;
    procedure TestDataAccessors;
    procedure TestNameAccessor;
  end;

implementation

uses
  RTTI,
  PureMVC.Patterns.Proxy,
  PureMVC.Interfaces.IProxy;

{ **
  * Tests getting the name using Proxy class accessor method. Setting can only be done in constructor.
  *
}

procedure TestTProxy.TestNameAccessor;
var
  Proxy: IProxy;
begin
  Proxy := TProxy.Create('TestProxy');

  CheckEquals('TestProxy', Proxy.ProxyName);
end;

procedure TestTProxy.TestDataAccessors;
var
  Proxy: IProxy;
  Data: TArray<string>;
begin
  Proxy := TProxy.Create('Colors');
  Proxy.Data := TValue.FromArray(TypeInfo(TArray<string>),
    ['red', 'green', 'blue']);
  Data := Proxy.Data.AsType<TArray<string>>;

  CheckEquals(3, Length(Data));
  CheckEquals('red', Data[0]);
  CheckEquals('green', Data[1]);
  CheckEquals('blue', Data[2]);
end;

{ **
  * Tests setting the name and body using the Notification class Constructor.
  *
}
procedure TestTProxy.TestConstructor;
var
  Proxy: IProxy;
  Data: TArray<string>;
begin
  Proxy := TProxy.Create('colors', TValue.FromArray(TypeInfo(TArray<string>),
    ['red', 'green', 'blue']));
  CheckNotNull(Proxy);
  CheckEquals('colors', Proxy.ProxyName);

  Data := Proxy.Data.AsType<TArray<string>>;
  CheckEquals(3, Length(Data));
  CheckEquals('red', Data[0]);
  CheckEquals('green', Data[1]);
  CheckEquals('blue', Data[2]);
end;

initialization

// Register any test cases with the test runner
RegisterTest(TestTProxy.Suite);

end.
