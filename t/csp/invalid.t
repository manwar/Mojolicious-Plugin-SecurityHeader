use Mojo::Base -strict;

use Test::More;
use Mojolicious::Lite;
use Test::Mojo;

plugin 'SecurityHeader' => [
    'Content-Security-Policy' => 'hallo',
];

get '/' => sub {
  my $c = shift;
  $c->render(text => 'Hello Mojo!');
};

my $t = Test::Mojo->new;
$t->get_ok('/')->status_is(200)
  ->header_isnt( 'Content-Security-Policy', 'hallo' )
;

done_testing();
