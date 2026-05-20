Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A9CCD4F3D
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 20:41:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E0CD8467A;
	Wed, 20 May 2026 22:41:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jK2HvQfT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1981847C6; Wed, 20 May 2026 22:41:38 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC285841D7
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 22:41:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-bcc9fdc959cso1030874366b.2
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 13:41:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779309696; cv=none;
 d=google.com; s=arc-20240605;
 b=de+V5QtA3CCYOyHGGoZc16pqQzCrHormKgliSaHVd/QRIhZGzd+KcjIt5l1RQ68+Jv
 J5vhkEOKaM3wk1HCyublpHqRaoIL/Rd7nz9oO6skygPwaXP2AOfX9SEzTPBH61nDbPd3
 WYON3ZTrNZ8W6GyFG2ge8AczkhcAwDut0ItUzskaDFHN+7GTnn4Ih2707x3Q7xkEgBXt
 YOaFbYk6vSQwuV6L1vCdAgJEyXwgTyMgqFVMULW3f2pESh/A9RqCPlLuADI68NAYbN+/
 BEWne6ScHucC5JrimVlQeSwQwLbMd3mGV+G2sbo36OHNo7b8sFJ96fQDGJkP1yy6NC0H
 UQPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6tDfkLyXlUUpymM1gqfY55/qhFJCnB56Q4LLUaNR0Ew=;
 fh=IqCfcHbD+ulv1zGgr5/QGw96aLsXJwcMfRzzJUCLEnM=;
 b=M93weKg0gRp6IYR6jzkEMck+BZIHNHNCnBxL93e2DvjiUtWBbKSEpG+cTNlZhmNkbz
 0AIGqUlNT9ajF3IB6Sq2+hLuom79TJxEa6kWsWgviVOAA7nFDUmGaRj3C/zdFAqBRavA
 KRfZlc4Md1LOzMYAo6fUFunquoEktPuGS9v3y30Ms46s2Oqvbu0IJruAZRDn8jB1HmNc
 6eq1Yvx/0LppdrMfIPwRjWiXulqyZNNf73ewX+J4IpVrlTuQBvwwPLIcii79ZVxQXPfi
 6Id3OFeUCbgNi9YeNLMmzYq1SEUI7inZ2TeX0+ho2QhM3Ta/5pQY1m5QGRxhAJvoMeTc
 d8kQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779309696; x=1779914496; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6tDfkLyXlUUpymM1gqfY55/qhFJCnB56Q4LLUaNR0Ew=;
 b=jK2HvQfTMoW7RUZ2xw4X0uULS1LIiWu5zMWlfBZGFjjaf9GTIFiwkfvqvtFKOz+PQv
 6e5bQ17kXfTm7kxw6Xn6X1G7FhqNNAcuceRMobOxYYzDC/UJnyK6TYu7zrVJKiJrTaQ4
 5Hrsg05YQv2mf1bKUBk1g3/JLemed/q5GyUfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779309696; x=1779914496;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6tDfkLyXlUUpymM1gqfY55/qhFJCnB56Q4LLUaNR0Ew=;
 b=tGc7uBSp+uo+h+WmUGYiPxwGBKyRQskOj+c+NhbCGHa6l2JTJfcrsVmAQyv/uUI0A8
 s/21khksLtOErB4f73OLdWqszdkNEx56s0U2ULKjN54MHy1lzG0S1QVtU99or4Ib1X4T
 9xIXZSFGm+z0De1qSeWphC/bqeGJxy1ovt6x89kx6uLrse2vhBK7fXJA7V6zos4/iD2R
 kHhqifQMph/FcM+RuRRtvlxxPAwEirxL0Rwra8EP/45zOWCuKq8pAhM0frjAbqPz47E7
 eQgfSH0nO3YUiPGSJ1JfxbQ0cE1gRc05dc73t5gNFdIGQcQizCA+8hkRCGHvpb/0mwGL
 rCUw==
X-Gm-Message-State: AOJu0YyZVk+b6vWpJVoyrrZC5dG3GWRxgBpXpJUOyloWqeEk3ox7riPT
 QKLhoqjG7L4EIG3hdp1y0MzF87SrByMuagIDnx9OQbH/5padYOwZRKiLr4Zorx2cNGuLAGzyh5E
 C2YKoS4wPAqpNirpJPSM8S3HadtW4OSEppFabvc2s
X-Gm-Gg: Acq92OF9BgiMn7QOnUIFQLUHAX9x24ZrxFpBEF9tFFtFSkesFwCO/5uEUyhahg1lCC4
 A6aFL+Ip66hwGwQnd66tGuAph4c2Trn98rpZrqQbUpqksIs2y59IrmxZ4SJIWsYY/FPJ7aW3X2D
 +mwoLEH13gjo805USRVXVftpK+WJNP7C2MV6QU/FV9Db5BHUdqlySulwvCMaDo7sgufm1bFRJdh
 1Y1q4PYt7Omk9gKi9JLIdQFrPPE7t5ZNtuNhzp1l1M97YYA75p1dW+RupX/eGj+TGpWz6gySAW3
 KwZK/w==
X-Received: by 2002:a17:907:1608:b0:bd4:9a55:18e2 with SMTP id
 a640c23a62f3a-bd51797a54dmr1418986466b.45.1779309696228; Wed, 20 May 2026
 13:41:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260515203311.2555651-1-sjg@chromium.org>
 <20260515203311.2555651-8-sjg@chromium.org>
 <23a059c1-e3ea-4351-bdfb-fba4462539ad@gmail.com>
In-Reply-To: <23a059c1-e3ea-4351-bdfb-fba4462539ad@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 May 2026 15:41:24 -0500
X-Gm-Features: AVHnY4IMCoeasHa4KcHsBX-jlmANGAHukleQ-7nJQa8EIAMSbzvZfsYjlcimX2I
Message-ID: <CAFLszThVccssD_5=V3D=M9orwsQbzEgs5BcVHAPzPH0NCLsrzw@mail.gmail.com>
Subject: Re: [RFC PATCH 07/11] cmd: echo: Use getopt() with '+' prefix for
 option parsing
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Yao Zi <me@ziyao.cc>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Sean,

On Fri, 15 May 2026 at 15:58, Sean Anderson <seanga2@gmail.com> wrote:
>
> On 5/15/26 16:32, Simon Glass wrote:
> > The 'echo' command's option parser is a single strcmp against argv[1]
> > that decides whether to suppress the trailing newline. Convert it to
> > getopt() so echo follows the same shape as the other commands in this
> > series and exercises the '+' prefix that POSIX-style 'stop at first
> > non-option' callers need.
> >
> > The optstring uses the '+' prefix to preserve bash echo behaviour: -n is
> > honoured only as the very first argument, so 'echo hello -n' still
> > prints 'hello -n\n' verbatim.
> >
> > Two minor differences from the bash builtin remain, both of which
> > the user can work around with quoting or --:
> >
> > * -x (an unknown short option) returns CMD_RET_USAGE rather than
> >    printing literally; use 'echo -- -x' to print it.
> > * -nfoo (joined form) parses -n and then errors on the trailing
> >    characters.
>
> Why? This introduces incompatibility with echo as it exists today as
> well as unix-style echo. We can have an (almost) completely-compatible
> echo with
>
>         getopt_init_state(&gs, argc, argv);
>         while (getopt_silent(&gs, "+n") == 'n')
>                 newline = false;
>
>         for (i = gs.index; i < argc; ++i) {
>                 <snip>
>
> The only difference is that something like "echo -na" will result in
> "-na" and not "-na\n". IMO echo is not a good candidate for getopt
> due to its unusual argument handling. Even coreutils echo does not
> use getopt. So I think we should really leave echo as-is.

Yes, I am including this just so people can see a case where there is
only a single arg and we need ordering. It is the worst case I can
think of for getopt(). I have not yet really found a best case.

There are at least two reasons not to apply this patch: echo is
special in how it handles its args (as you say) and it would impact
nearly every board.

>
> > Add three test cases that pin down the new behaviour: trailing -n stays
> > literal, -- ends option parsing, and -- is consumed even after a
> > recognised flag. The positional loop uses getopt_pop() as an iterator.
> > CMD_ECHO selects GETOPT so the parser is linked in on boards that don't
> > already enable it.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >   cmd/Kconfig          |  1 +
> >   cmd/echo.c           | 23 ++++++++++++++---------
> >   test/cmd/test_echo.c | 10 ++++++++++
> >   3 files changed, 25 insertions(+), 9 deletions(-)
> >

Regards,
Simon
