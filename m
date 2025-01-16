Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CDC8C02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 15:50:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B456C8033D;
	Thu, 16 Jan 2025 16:50:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O2sRJ5CD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F684806DD; Thu, 16 Jan 2025 16:50:09 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 180E580214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 16:50:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aa67ac42819so168014166b.0
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 07:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737042606; x=1737647406; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1CPf4RPLvTEHbKtkXMWADK8dplvexbms21MPwwIE1EQ=;
 b=O2sRJ5CDzHe7lfioS2+F372TY1k7kdvRTbyjJ+Ke9D+nR1uSZ7vHNLgTdOnvhhS7AG
 OFSvTZ7g5E/Wj2Mg3Q+0m0cuJDfVS6MX6dcrslGH+9l7BAcifL3uWaBtRcThDQ895scN
 pMS6X+0PWwnPJTAVM3bkauW59iBh8PKNgNyHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737042606; x=1737647406;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1CPf4RPLvTEHbKtkXMWADK8dplvexbms21MPwwIE1EQ=;
 b=b4sCSXchNUpt45NuqI8uz15z567dED3mYWgOAdOWZ6nIccisiRn2/YTSWAPNFxSTym
 zanB60k2STGdwiscY+2XvaHrfAlB1ZuvqeOXRBkPItHv2MvYDyGcF2CGBizXzg68I0k9
 esw/l72fJbP+cHrzwVzlut8y60J5V5eeIzCex25OBOXhN5vexIvcIsZ6exLiMc8Xr0TK
 iAB0gsBjAsFR0jdnueFJuKSFdZKqRX0DAVJ8kwZmwhSE5uRvMU/7MgUSShL60/Uwcr4w
 nbgShSAKjY/5boNS+IvoTrYut/Wq8hFlSUDVJAqQjPqCSppSqZayhTLKCKLt6kHpJcg0
 UhvA==
X-Gm-Message-State: AOJu0Yx7jD8STcWSSMP0ml7I011sCWIM/y+6kJVACHfbiSu6caxEgojw
 l9Vq7otpZn2lhJensVWHiIFX4Wrfe/mNy0BbQC68Ed4innP5q9iefoNztxkFLIWJeXtl46gYIVY
 3lxCOalpiCd1Ec6/S9yjnxVdcv6GXdUnYPlKx
X-Gm-Gg: ASbGncv0U0fzn3WzWfPfFEGTAXUawSLRxhkBbNwWB5tSmSzyAJkcb5w1KHDYHnMJi6t
 BD/KhWmCYAxkcoDGtxZWSMoL2PEz7nBt4K+wAzLk=
X-Google-Smtp-Source: AGHT+IGFCc1hjNya/EHCuVV5mM34jCFrWFrkexK9fAvSI2aqB8XUQ20IRRRrjWqRPWOzhE4i6M3dgug9rIYHzoZ0q68=
X-Received: by 2002:a17:906:f5a2:b0:aa6:8676:3b33 with SMTP id
 a640c23a62f3a-ab2abc6e768mr3020955566b.47.1737042606468; Thu, 16 Jan 2025
 07:50:06 -0800 (PST)
MIME-Version: 1.0
References: <20250115133114.590375-1-sjg@chromium.org>
 <87a5br850s.fsf@baylibre.com>
In-Reply-To: <87a5br850s.fsf@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 16 Jan 2025 08:49:55 -0700
X-Gm-Features: AbW1kvYWW4ZOObhHvqRqLwFlzsZddXwsY7Xw_AgDzi7cCBi-ptnidGdSTWUFqbI
Message-ID: <CAFLszTjJp0oTLf=Fzt4MKMbjiz7yv4iz-8LNHZkYXwBD77p2Lg@mail.gmail.com>
Subject: Re: [PATCH 00/43] test: Improvements to ut command and test-suite
 running
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Gendin <agendin@matrox.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ion Agorria <ion@agorria.com>, Jens Wiklander <jens.wiklander@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Julien Masson <jmasson@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Massimiliano Minella <massimiliano.minella@se.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Ravi Minnikanti <rminnikanti@marvell.com>, Raymond Mao <raymond.mao@linaro.org>,
 Richard Weinberger <richard@nod.at>,
 Stephen Carlson <stcarlso@linux.microsoft.com>, 
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
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

Hi Mattijs,

On Thu, 16 Jan 2025 at 02:47, Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> Hi Simon,
>
> Thank you for the series.
>
> On mer., janv. 15, 2025 at 06:30, Simon Glass <sjg@chromium.org> wrote:
>
> > The current method of running unit tests relies on subcommands of the
> > ut command. Only the code in each subcommand knows how to find the tests
> > related to that subcomand.
> >
> > This is not ideal and we now have quite a few subcommands which do
> > nothing but locate the relevant tests in a linker list, then call a
> > common function to run them.
> >
> > This series adds a list of test suites, so that these subcommands can be
> > removed.
> >
> > An issue with 'ut all' is that it doesn't record how many tests failed
> > overall, so it is necessary to examine copious amounts of output to look
> > for failures. This series adds a new 'total' feature allow recording the
> > total number of failed tests.
> >
> > To help with 'ut all' a new pytest is created which runs it (as well as
> > 'ut info') and makes sure that all is well. Due to the 'ut all' failures
> > this does not pass, so the test is disabled for now. It is here because
> > it provides security against misnaming a test suite and causing it not
> > to run.
>
> I wanted to test this, but it seems it does not apply on both master or
> next:
>
> With master: 178f6ecb21fe ("Merge patch series "bootstd: Support recording images"")
> With next: d6da3dbaef57 ("Merge patch series "cmd: Add support for optee commands."")
>
> When running:
> $ b4 shazam -s -l --check 20250115133114.590375-1-sjg@chromium.org
>
> I see:
>
> """
> [...] snip
>
> Total patches: 43
> ---
> Applying: test: Drop unused suite prototypes
> Applying: test: Rename test_get_state() to ut_get_state()
> Applying: test: Add functions to init and uninit the test state
> Applying: test: Pass the test-state into ut_run_list()
> Applying: Improve support for linker lists in data structures
> Applying: test: Add newlines to hush-test messages
> Applying: test: Rename test suites to match their linker-list name
> Applying: test: Update ut info to show suites
> Applying: test/py: Add a test which runs all unit tests
> Applying: test: Drop the _test suffix on linker lists
> Applying: test: Introduce a better array of test suites
> Patch failed at 0011 test: Introduce a better array of test suites
> error: sha1 information is lacking or useless (test/cmd_ut.c).
> error: could not build fake ancestor
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am --abort".
> """
>
> On what base should this be applied if we want to test this?
> Sorry if this is a sily question, usually I get dependencies from the
> cover letter but I could not find any here.

Yes, it is supposed to be based on -next but there are two patches in
-next but not in the tree I used:

90856d695f2 test: sandbox: fix link error with do_ut_bootm if BLOBLIST=n
6970eeb7885 test: sandbox: fix link error with do_ut_bloblist if BLOBLIST=n

The series is available at
sjg.u-boot.org/u-boot/u-boot/-/tree/tes?ref_type=heads

I'll sort this out when I send v2, but will wait for some more feedback.

[..]

Regards,
SImon
