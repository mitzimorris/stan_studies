data {
  int<lower=0> N; // items
  array[N] int<lower=0> K; // initial trials
  array[N] int<lower=0> y; // initial successes
}
parameters {
  real mu; // population mean of success log-odds
  real<lower=0> sigma; // population sd of success log-odds
  vector[N] alpha_std; // success log-odds (standardized)
}
transformed parameters {
  vector[N] alpha = mu + sigma * alpha_std;
}
model {
  mu ~ normal(-1, 1); // hyperprior
  sigma ~ normal(0, 1); // hyperprior
  alpha_std ~ normal(0, 1); // prior (hierarchical)
  y ~ binomial_logit(K, alpha); // likelihood
}
generated quantities {
  vector[N] theta = inv_logit(alpha);
}
