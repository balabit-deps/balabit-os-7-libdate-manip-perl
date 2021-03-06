#!/usr/bin/perl -w

use Test::Inter;
$t = new Test::Inter 'date :: calc (date,delta,business,french)';
$testdir = '';
$testdir = $t->testdir();

use Date::Manip;
if (DateManipVersion() >= 6.00) {
   $t->feature("DM6",1);
}

$t->skip_all('Date::Manip 6.xx required','DM6');


sub test {
  (@test)=@_;

  $err = $obj1->parse(shift(@test));
  return $$obj1{"err"}  if ($err);
  $err = $obj2->parse(shift(@test));
  return $$obj2{"err"}  if ($err);

  my $obj3 = $obj1->calc($obj2,@test);
  return   if (! defined $obj3);
  $err = $obj3->err();
  return $err  if ($err);
  $ret = $obj3->value();
  return $ret;
}

$obj1 = new Date::Manip::Date;
$obj1->config("forcedate","now,America/New_York",
              "language","french");
$obj2 = $obj1->new_delta();

$tests="

'Mer Nov 20 1996 12h00' 'il y a 3 jour 2 heures professionel' => 1996111510:00:00

'Mer Nov 20 1996 12:00' '5 heure professionel' => 1996112108:00:00

'Mer Nov 20 1996 12:00' '+0:2:0:0 professionel' => 1996112014:00:00

'Mer Nov 20 1996 12:00' '3 jour 2 h professionel' => 1996112514:00:00

";

$t->tests(func  => \&test,
          tests => $tests);
$t->done_testing();

1;

#Local Variables:
#mode: cperl
#indent-tabs-mode: nil
#cperl-indent-level: 3
#cperl-continued-statement-offset: 2
#cperl-continued-brace-offset: 0
#cperl-brace-offset: 0
#cperl-brace-imaginary-offset: 0
#cperl-label-offset: 0
#End:
