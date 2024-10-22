Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D3CD2CE05
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 17:01:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABA61892BA;
	Tue, 22 Oct 2024 19:01:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k7Zv2JGd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DE1B88ECB; Tue, 22 Oct 2024 19:01:34 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD42788F62
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 19:01:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a93c1cc74fdso856141066b.3
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 10:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729616491; x=1730221291; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U83FUkhBtUq5IdqA9nTVEcxaegpV2YglSD4BEl8vc0Q=;
 b=k7Zv2JGdKshXYTs1G3yOHSjM0JqmUP2ApYsIGwj7g0+Nwf++VCU5mFi6U3EvZr5Wpm
 tP28nEXndh+++REp8C+9C8p1bWW5MFN10MPZR6ssUiSfc5G3UxoT2yMnum6YymjGOyMz
 W4g/rn2DYb6nANSxmco38O0GauYvO6UBM0o+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729616491; x=1730221291;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U83FUkhBtUq5IdqA9nTVEcxaegpV2YglSD4BEl8vc0Q=;
 b=UYtPq42/P0Gi1Pz5aMMq6IlNWJoGIEMdlJ/Gpq0cXvmywcKH7dhzr/7J+P2SIemBfh
 Dskt2Sbplbm8i38+oubBhuZNpRkzvO9BcYmukK9WvXJqjpfbXNlSXgVJfs7sGfw4sH+k
 33QYp+CST0vyx4VKNKE2Riee6xO1q/B+fkA6QThjSQY3+bRlkQLfpQ2yOER+OMgJSrwC
 71clba2aDV2rFuUUwM4u6j7x9cp+0nO2pZgOl9mD8EqVUaCVsN08e2bQlGufiX/diEE3
 Jna/J7Z202gIpXp3dwY7WdiYCtVRZAXphJ1ZBr8GzRhgcwzLTfsEpPvABeTq5ayGG1O3
 C8bA==
X-Gm-Message-State: AOJu0YxNjQ7S8Xia4404N2prTRzQACu+uUVbPCyp3niCX+JmMB/HrZ93
 bhPP95FmvDDiRZxAXayLtZdPfFnrstjT5P7WPPvEKNsjw1Nd9MGFQos37cIPU4lCMYvPdfOQLL3
 +9LInTHZ79PSkl25geNK8x3qM4X9KQpHvNkdb
X-Google-Smtp-Source: AGHT+IGKSw3eb9z57J7jMYW9mh76NXtW5ZPdrYJGuSoeyAh91Q35Mioqd67LqaHZDJ4S3b4QmI4ELk4HVvjdQO24KtE=
X-Received: by 2002:a17:907:60ca:b0:a9a:82e2:e8ce with SMTP id
 a640c23a62f3a-a9abe099ac1mr2531366b.40.1729616490986; Tue, 22 Oct 2024
 10:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <20241010015145.1977999-1-sjg@chromium.org>
 <CAFLszTjT+yh70hRQ-7chXbQdE4Q_wzU1+Rom39+UtUOPc6HfGg@mail.gmail.com>
 <20241021180738.GP4959@bill-the-cat>
 <CAFLszThe2LswCwG3ewEj=A9ZD-MPzmX4MovF5TKY-BK4LW09tg@mail.gmail.com>
 <20241022144345.GE4959@bill-the-cat>
In-Reply-To: <20241022144345.GE4959@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 22 Oct 2024 19:00:50 +0200
Message-ID: <CAFLszTi0h3h00g7uX=kPUAxXkPKWpCc+=mYyBuB6FCG69ZtPwQ@mail.gmail.com>
Subject: Re: [PATCH v7 00/11] labgrid: Provide an integration with Labgrid
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Tom,

On Tue, 22 Oct 2024 at 16:43, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Oct 22, 2024 at 02:15:40PM +0200, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 21 Oct 2024 at 20:07, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Oct 21, 2024 at 01:12:49PM +0200, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Thu, 10 Oct 2024 at 03:51, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Labgrid provides access to a hardware lab in an automated way. It is
> > > > > possible to boot U-Boot on boards in the lab without physically touching
> > > > > them. It relies on relays, USB UARTs and SD muxes, among other things.
> > > > >
> > > > > By way of background, about 4 years ago I wrong a thing called Labman[1]
> > > > > which allowed my lab of about 30 devices to be operated remotely, using
> > > > > tbot for the console and build integration. While it worked OK and I
> > > > > used it for many bisects, I didn't take it any further.
> > > > >
> > > > > It turns out that there was already an existing program, called Labgrid,
> > > > > which I did not know about at time (thank you Tom for telling me). It is
> > > > > more rounded than Labman and has a number of advantages:
> > > > >
> > > > > - does not need udev rules, mostly
> > > > > - has several existing users who rely on it
> > > > > - supports multiple machines exporting their devices
> > > > >
> > > > > It lacks a 'lab check' feature and a few other things, but these can be
> > > > > remedied.
> > > > >
> > > > > On and off over the past several weeks I have been experimenting with
> > > > > Labgrid. I have managed to create an initial U-Boot integration (this
> > > > > series) by adding various features to Labgrid[2] and the U-Boot test
> > > > > hooks.
> > > > >
> > > > > I hope that this might inspire others to set up boards and run tests
> > > > > automatically, rather than relying on infrequent, manual test. Perhaps
> > > > > it may even be possible to have a number of labs available.
> > > > >
> > > > > Included in the integration are a number of simple scripts which make it
> > > > > easy to connect to boards and run tests:
> > > > >
> > > > > ub-int <target>
> > > > >     Build and boot on a target, starting an interactive session
> > > > >
> > > > > ub-cli <target>
> > > > >     Build and boot on a target, ensure U-Boot starts and provide an interactive
> > > > >     session from there
> > > > >
> > > > > ub-smoke <target>
> > > > >     Smoke test U-Boot to check that it boots to a prompt on a target
> > > > >
> > > > > ub-bisect <target>
> > > > >     Bisect a git tree to locate a failure on a particular target
> > > > >
> > > > > ub-pyt <target> <testspec>
> > > > >     Run U-Boot pytests on a target
> > > > >
> > > > > Some of these help to provide the same tbot[4] workflow which I have
> > > > > relied on for several years, albeit much simpler versions.
> > > > >
> > > > > The goal here is to create some sort of script which can collect
> > > > > patches from the mailing list, apply them and test them on a selection
> > > > > of boards. I suspect that script already exists, so please let me know
> > > > > what you suggest.
> > > > >
> > > > > I hope you find this interesting and take a look!
> > > > >
> > > > > [1] https://github.com/sjg20/u-boot/tree/lab6a
> > > > > [2] https://github.com/labgrid-project/labgrid/pull/1411
> > > > > [3] https://github.com/sjg20/uboot-test-hooks/tree/labgrid
> > > > > [4] https://tbot.tools/index.html
> > > > >
> > > > > Changes in v7:
> > > > > - Rebase on testb series
> > > > > - Expand commit message
> > > > > - Rename option to --use-running-system
> > > > > - Rebase on broken-out testb series
> > > > >
> > > > > Changes in v6:
> > > > > - Rebase without an earlier patch
> > > > > - Avoid doing the special shutdown unless USE_LABGRID is enabled
> > > > > - Drop patch 'test: Pass stderr to stdout'
> > > > >
> > > > > Changes in v5:
> > > > > - Add a few more comments
> > > > > - Comment out the debugging, which might be useful later
> > > > > - Add a patch to support testing with two board-builds
> > > > >
> > > > > Changes in v3:
> > > > > - Split out most patches into two new series and update cover letter
> > > > >
> > > > > Changes in v2:
> > > > > - Only disable echo if a terminal is detected
> > > > > - Avoid running a docker image for skipped lab tests
> > > > >
> > > > > Simon Glass (11):
> > > > >   test: Allow signaling that U-Boot is ready
> > > > >   test: Release board after tests complete
> > > > >   test: Allow connecting to a running board
> > > > >   test: Introduce the concept of a role
> > > > >   test: Introduce lab mode
> > > > >   test: Improve handling of sending commands
> > > > >   test: Avoid double echo when starting up
> > > > >   test: Try to shut down the lab console gracefully
> > > > >   test: Add a section for closing the connection
> > > > >   test: Support testing with two board-builds
> > > > >   CI: Allow running tests on sjg lab
> > > > >
> > > > >  .gitlab-ci.yml                        | 153 ++++++++++++++++++++++++++
> > > > >  test/py/conftest.py                   |  73 ++++++++++--
> > > > >  test/py/u_boot_console_base.py        | 123 +++++++++++++++------
> > > > >  test/py/u_boot_console_exec_attach.py |  31 ++++--
> > > > >  test/py/u_boot_spawn.py               |  36 +++++-
> > > > >  5 files changed, 363 insertions(+), 53 deletions(-)
> > > > >
> > > > > --
> > > > > 2.34.1
> > > > >
> > > >
> > > > Is there any news on these patches? I would dearly love to enable my
> > > > lab and this is what is needed...
> > >
> > > As our approaches are radically different I continue to be looking for
> > > feedback from a third person to set things up and say what does /
> > > doesn't work for them and their lab. I assume you're just pulling this
> > > in locally for use at least.
> >
> > No, I cannot pull this in locally. I would like to set up gitlab so I
> > (and others) can push things to it for running on the lab. Without my
> > patches the lab only works on a few boards.
> >
> > Could you perhaps try them out on your lab, to check they don't break anything?
>
> Your setup requires changes to labgrid itself, yes?

Yes, but I have that installed on the Gitlab runner.

As to getting them upstream, it is very slow. I would gain new
motivation to push harder if I could actually use it!

Regards,
Simon
