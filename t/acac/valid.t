use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

use Mojolicious::Lite;

get '/' => sub {
    my $c = shift;
    $c->render(text => 'Hello Mojo!');
};

my @tests = (
    {
        param  => 'true',
        result => 'true',
    },
);

for my $test ( @tests ) {
    plugin SecurityHeader => [
        'Access-Control-Allow-Credentials' => $test->{param},
    ];
    
    my $t = Test::Mojo->new;
    $t->get_ok('/')->status_is(200)->header_is('Access-Control-Allow-Credentials', $test->{result} );
}

done_testing();
