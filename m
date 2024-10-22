Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DBF5D2C543
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 12:16:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C148E88EBA;
	Tue, 22 Oct 2024 14:15:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UVrL8rIa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57D7188969; Tue, 22 Oct 2024 14:15:57 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA68888E89
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 14:15:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-539f72c913aso6438494e87.1
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 05:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729599354; x=1730204154; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kbo05JERcBXLx6Yf1UzlP25vQlNMauub5T+QsBL1v2w=;
 b=UVrL8rIauMWtQ298NAB6otaBoyMnC/hdbF5IuUMWAFsz+pTJCfBSRlNXjZllCldYyS
 NgyHWwg13IwoeFR7fyKWJiDpHI2OJDCk6+9wBmJZCCpOyxRln9T/OJXbXgbK/hwu+ZS0
 hRt3Bmw/fw7wNXc9neP0KlI252nQh5YQrbHQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729599354; x=1730204154;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kbo05JERcBXLx6Yf1UzlP25vQlNMauub5T+QsBL1v2w=;
 b=IsewCvv+3bZypAV7J+ep9SOO/rvdMThYVCQUzL0v+/jp1ut3VOH6B9tm6oDJCJwmbc
 FNdfK3qbuPITbg7QCJplbNFGNlJlqb9t7zNUEVsDyLA4DYxM7sNkLEgifAi0xONBQRYw
 suYrdt3Z3b+XTNADiQI2At7OIT6dnqjEAvfHHn3KJ8kgJ6gzCJzf/42AC5L75SKUSIFA
 aqccIosPypzbJpkB1sGNEI7w4tT3lA6kK2F0NBYA9W3m6qlZhpgERyQMiTWch7frfngT
 19a144SJh1yKvGhdaIoSF4qHRsLhs4lk+YyWyd3IXJOiUdsB8Jg+ikMd+f8R3eGhRlPp
 fQYw==
X-Gm-Message-State: AOJu0Yyv7/2moidbFEZSm9FCXyv18FNTHgbsUD2K7GA+a+eo0ciNctmz
 lYwNPg8iPoK3tk+B0xxp/3Z90Ap7vN//co+GKy0s0VxFBdlI8Rqzaw0ctt903Jb/GVoDII3hVgu
 LMME9Mt+6k5KT4TJRnh1PQP0Bjckij66O3I2G
X-Google-Smtp-Source: AGHT+IEuUvPSG5nYQzZzksyD+u02pxYRO2S7D53/olXUWdo94bqrLUnbn+Z14syi3ckPkWpMp4zBdxlpJ0dZHRjn6q0=
X-Received: by 2002:a05:6512:4013:b0:539:ed36:eb8f with SMTP id
 2adb3069b0e04-53a15225253mr7974507e87.24.1729599354174; Tue, 22 Oct 2024
 05:15:54 -0700 (PDT)
MIME-Version: 1.0
References: <20241010015145.1977999-1-sjg@chromium.org>
 <CAFLszTjT+yh70hRQ-7chXbQdE4Q_wzU1+Rom39+UtUOPc6HfGg@mail.gmail.com>
 <20241021180738.GP4959@bill-the-cat>
In-Reply-To: <20241021180738.GP4959@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 22 Oct 2024 14:15:40 +0200
Message-ID: <CAFLszThe2LswCwG3ewEj=A9ZD-MPzmX4MovF5TKY-BK4LW09tg@mail.gmail.com>
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

On Mon, 21 Oct 2024 at 20:07, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 21, 2024 at 01:12:49PM +0200, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 10 Oct 2024 at 03:51, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Labgrid provides access to a hardware lab in an automated way. It is
> > > possible to boot U-Boot on boards in the lab without physically touching
> > > them. It relies on relays, USB UARTs and SD muxes, among other things.
> > >
> > > By way of background, about 4 years ago I wrong a thing called Labman[1]
> > > which allowed my lab of about 30 devices to be operated remotely, using
> > > tbot for the console and build integration. While it worked OK and I
> > > used it for many bisects, I didn't take it any further.
> > >
> > > It turns out that there was already an existing program, called Labgrid,
> > > which I did not know about at time (thank you Tom for telling me). It is
> > > more rounded than Labman and has a number of advantages:
> > >
> > > - does not need udev rules, mostly
> > > - has several existing users who rely on it
> > > - supports multiple machines exporting their devices
> > >
> > > It lacks a 'lab check' feature and a few other things, but these can be
> > > remedied.
> > >
> > > On and off over the past several weeks I have been experimenting with
> > > Labgrid. I have managed to create an initial U-Boot integration (this
> > > series) by adding various features to Labgrid[2] and the U-Boot test
> > > hooks.
> > >
> > > I hope that this might inspire others to set up boards and run tests
> > > automatically, rather than relying on infrequent, manual test. Perhaps
> > > it may even be possible to have a number of labs available.
> > >
> > > Included in the integration are a number of simple scripts which make it
> > > easy to connect to boards and run tests:
> > >
> > > ub-int <target>
> > >     Build and boot on a target, starting an interactive session
> > >
> > > ub-cli <target>
> > >     Build and boot on a target, ensure U-Boot starts and provide an interactive
> > >     session from there
> > >
> > > ub-smoke <target>
> > >     Smoke test U-Boot to check that it boots to a prompt on a target
> > >
> > > ub-bisect <target>
> > >     Bisect a git tree to locate a failure on a particular target
> > >
> > > ub-pyt <target> <testspec>
> > >     Run U-Boot pytests on a target
> > >
> > > Some of these help to provide the same tbot[4] workflow which I have
> > > relied on for several years, albeit much simpler versions.
> > >
> > > The goal here is to create some sort of script which can collect
> > > patches from the mailing list, apply them and test them on a selection
> > > of boards. I suspect that script already exists, so please let me know
> > > what you suggest.
> > >
> > > I hope you find this interesting and take a look!
> > >
> > > [1] https://github.com/sjg20/u-boot/tree/lab6a
> > > [2] https://github.com/labgrid-project/labgrid/pull/1411
> > > [3] https://github.com/sjg20/uboot-test-hooks/tree/labgrid
> > > [4] https://tbot.tools/index.html
> > >
> > > Changes in v7:
> > > - Rebase on testb series
> > > - Expand commit message
> > > - Rename option to --use-running-system
> > > - Rebase on broken-out testb series
> > >
> > > Changes in v6:
> > > - Rebase without an earlier patch
> > > - Avoid doing the special shutdown unless USE_LABGRID is enabled
> > > - Drop patch 'test: Pass stderr to stdout'
> > >
> > > Changes in v5:
> > > - Add a few more comments
> > > - Comment out the debugging, which might be useful later
> > > - Add a patch to support testing with two board-builds
> > >
> > > Changes in v3:
> > > - Split out most patches into two new series and update cover letter
> > >
> > > Changes in v2:
> > > - Only disable echo if a terminal is detected
> > > - Avoid running a docker image for skipped lab tests
> > >
> > > Simon Glass (11):
> > >   test: Allow signaling that U-Boot is ready
> > >   test: Release board after tests complete
> > >   test: Allow connecting to a running board
> > >   test: Introduce the concept of a role
> > >   test: Introduce lab mode
> > >   test: Improve handling of sending commands
> > >   test: Avoid double echo when starting up
> > >   test: Try to shut down the lab console gracefully
> > >   test: Add a section for closing the connection
> > >   test: Support testing with two board-builds
> > >   CI: Allow running tests on sjg lab
> > >
> > >  .gitlab-ci.yml                        | 153 ++++++++++++++++++++++++++
> > >  test/py/conftest.py                   |  73 ++++++++++--
> > >  test/py/u_boot_console_base.py        | 123 +++++++++++++++------
> > >  test/py/u_boot_console_exec_attach.py |  31 ++++--
> > >  test/py/u_boot_spawn.py               |  36 +++++-
> > >  5 files changed, 363 insertions(+), 53 deletions(-)
> > >
> > > --
> > > 2.34.1
> > >
> >
> > Is there any news on these patches? I would dearly love to enable my
> > lab and this is what is needed...
>
> As our approaches are radically different I continue to be looking for
> feedback from a third person to set things up and say what does /
> doesn't work for them and their lab. I assume you're just pulling this
> in locally for use at least.

No, I cannot pull this in locally. I would like to set up gitlab so I
(and others) can push things to it for running on the lab. Without my
patches the lab only works on a few boards.

Could you perhaps try them out on your lab, to check they don't break anything?

Regards,
Simon
