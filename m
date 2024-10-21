Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6566DD17122
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 18:07:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4F4788D56;
	Mon, 21 Oct 2024 20:07:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BqicO+OL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC4F488DB5; Mon, 21 Oct 2024 20:07:45 +0200 (CEST)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 205E188C60
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 20:07:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-460963d6233so29957021cf.2
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 11:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729534062; x=1730138862; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0n9oxtpnAPlr4fmqwh2f3Q4Liy5HHIPA9lpeaIxz/H4=;
 b=BqicO+OLXV5JQ6Am9Uf9MK7wBz8yiwpR03INnawZqTrmaY4G8q6DbisYnDRHuF/858
 urvySM/w1xp+D+ci35et53yfNorq5QWXxjpHoFgBF9rMefgahj4y2ig7aOQeiIgcwvRK
 XY7apMICXAsY7E2+B0OtTHUpDBAj2cYlVWti4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729534062; x=1730138862;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0n9oxtpnAPlr4fmqwh2f3Q4Liy5HHIPA9lpeaIxz/H4=;
 b=B99of0SJBoynTKn70sOZk+f/tX8MyN61WqjFEEXsqcWUiVULJVdu6A5ahdvrRR+Oj2
 S3Yife6LR/J+WnkfY3kfxY52DP9fBlzsMEU7sXvx99fGILmNy5H0Ykn8tKpDCSgWlqi7
 Kk8AY82HKoQ6mHM3M+vs9/ucvvJTuMKNDmIU0AWcInK3URiylYEOV1s8KnspmHrTt3Uo
 WFQU7NRxwYXi37hwWpdHBn02PeAa88XUgjZOZEmhR9WWA5kwweAGyQey3bNkceU5xH78
 k/x8YrjGtQRl7GCLthpnl7elMLzECGfub36OHtPUoPUm/A9TF5p4WPzcYtpcYbGl38eB
 pI4w==
X-Gm-Message-State: AOJu0Yz0iAfFLLHNpSPpmb4MHwL3fk/yRj3G5haIssBq9yd1jehCLo3W
 9TF4WJb9Kofkpj8WZP16tDbgDO6FP/92IYAsGBoziHkV8q915afx5ZHxVnBBFh8=
X-Google-Smtp-Source: AGHT+IHzbGPFbK5EwZfr7l3xw4rD6AqmhoV5tOoKbPndRV1VPfa9fkLsQ7zWdTwzp062VIzV93+bxw==
X-Received: by 2002:a05:622a:1b1f:b0:45f:8bc:5be0 with SMTP id
 d75a77b69052e-46100ffe9bcmr654471cf.36.1729534061909; 
 Mon, 21 Oct 2024 11:07:41 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce008b2be4sm19958896d6.2.2024.10.21.11.07.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 11:07:41 -0700 (PDT)
Date: Mon, 21 Oct 2024 12:07:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v7 00/11] labgrid: Provide an integration with Labgrid
Message-ID: <20241021180738.GP4959@bill-the-cat>
References: <20241010015145.1977999-1-sjg@chromium.org>
 <CAFLszTjT+yh70hRQ-7chXbQdE4Q_wzU1+Rom39+UtUOPc6HfGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ugzAwLAkHfw/C8VP"
Content-Disposition: inline
In-Reply-To: <CAFLszTjT+yh70hRQ-7chXbQdE4Q_wzU1+Rom39+UtUOPc6HfGg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--ugzAwLAkHfw/C8VP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 01:12:49PM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 10 Oct 2024 at 03:51, Simon Glass <sjg@chromium.org> wrote:
> >
> > Labgrid provides access to a hardware lab in an automated way. It is
> > possible to boot U-Boot on boards in the lab without physically touching
> > them. It relies on relays, USB UARTs and SD muxes, among other things.
> >
> > By way of background, about 4 years ago I wrong a thing called Labman[1]
> > which allowed my lab of about 30 devices to be operated remotely, using
> > tbot for the console and build integration. While it worked OK and I
> > used it for many bisects, I didn't take it any further.
> >
> > It turns out that there was already an existing program, called Labgrid,
> > which I did not know about at time (thank you Tom for telling me). It is
> > more rounded than Labman and has a number of advantages:
> >
> > - does not need udev rules, mostly
> > - has several existing users who rely on it
> > - supports multiple machines exporting their devices
> >
> > It lacks a 'lab check' feature and a few other things, but these can be
> > remedied.
> >
> > On and off over the past several weeks I have been experimenting with
> > Labgrid. I have managed to create an initial U-Boot integration (this
> > series) by adding various features to Labgrid[2] and the U-Boot test
> > hooks.
> >
> > I hope that this might inspire others to set up boards and run tests
> > automatically, rather than relying on infrequent, manual test. Perhaps
> > it may even be possible to have a number of labs available.
> >
> > Included in the integration are a number of simple scripts which make it
> > easy to connect to boards and run tests:
> >
> > ub-int <target>
> >     Build and boot on a target, starting an interactive session
> >
> > ub-cli <target>
> >     Build and boot on a target, ensure U-Boot starts and provide an int=
eractive
> >     session from there
> >
> > ub-smoke <target>
> >     Smoke test U-Boot to check that it boots to a prompt on a target
> >
> > ub-bisect <target>
> >     Bisect a git tree to locate a failure on a particular target
> >
> > ub-pyt <target> <testspec>
> >     Run U-Boot pytests on a target
> >
> > Some of these help to provide the same tbot[4] workflow which I have
> > relied on for several years, albeit much simpler versions.
> >
> > The goal here is to create some sort of script which can collect
> > patches from the mailing list, apply them and test them on a selection
> > of boards. I suspect that script already exists, so please let me know
> > what you suggest.
> >
> > I hope you find this interesting and take a look!
> >
> > [1] https://github.com/sjg20/u-boot/tree/lab6a
> > [2] https://github.com/labgrid-project/labgrid/pull/1411
> > [3] https://github.com/sjg20/uboot-test-hooks/tree/labgrid
> > [4] https://tbot.tools/index.html
> >
> > Changes in v7:
> > - Rebase on testb series
> > - Expand commit message
> > - Rename option to --use-running-system
> > - Rebase on broken-out testb series
> >
> > Changes in v6:
> > - Rebase without an earlier patch
> > - Avoid doing the special shutdown unless USE_LABGRID is enabled
> > - Drop patch 'test: Pass stderr to stdout'
> >
> > Changes in v5:
> > - Add a few more comments
> > - Comment out the debugging, which might be useful later
> > - Add a patch to support testing with two board-builds
> >
> > Changes in v3:
> > - Split out most patches into two new series and update cover letter
> >
> > Changes in v2:
> > - Only disable echo if a terminal is detected
> > - Avoid running a docker image for skipped lab tests
> >
> > Simon Glass (11):
> >   test: Allow signaling that U-Boot is ready
> >   test: Release board after tests complete
> >   test: Allow connecting to a running board
> >   test: Introduce the concept of a role
> >   test: Introduce lab mode
> >   test: Improve handling of sending commands
> >   test: Avoid double echo when starting up
> >   test: Try to shut down the lab console gracefully
> >   test: Add a section for closing the connection
> >   test: Support testing with two board-builds
> >   CI: Allow running tests on sjg lab
> >
> >  .gitlab-ci.yml                        | 153 ++++++++++++++++++++++++++
> >  test/py/conftest.py                   |  73 ++++++++++--
> >  test/py/u_boot_console_base.py        | 123 +++++++++++++++------
> >  test/py/u_boot_console_exec_attach.py |  31 ++++--
> >  test/py/u_boot_spawn.py               |  36 +++++-
> >  5 files changed, 363 insertions(+), 53 deletions(-)
> >
> > --
> > 2.34.1
> >
>=20
> Is there any news on these patches? I would dearly love to enable my
> lab and this is what is needed...

As our approaches are radically different I continue to be looking for
feedback from a third person to set things up and say what does /
doesn't work for them and their lab. I assume you're just pulling this
in locally for use at least.

--=20
Tom

--ugzAwLAkHfw/C8VP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcWmGMACgkQFHw5/5Y0
tyy0Hwv/ZIrEvx9w1eR7JJkxEWSINO2Vnu+rQD2QJgmsiv8dgDBAHhN/OPT1vtH0
s1ZzljTIyxNUQSCv3cnZVhDODfFDNxR9N0w3oJ39tjqfRl3Fmi5rJQsEuD300/WZ
MDvpOkzFDH6PId42mGTROG0fZDJdJ3Dzi69VHodssuA1cg+HGnt6yJmaNXEsD3PU
xkNLG8QDrBbssDubVUd4HbsxqQZjRpGXvnkyM1AwNKZF3+8398h90V8yIGln1IL+
43SPR57cRVvVxpHDtkalLpyBPYUnkjRbRnp8aZ8rrBqi1e41LApcRC89ReQu4Jk4
pN9hZY/38pS5myXKAyWPDt1UuTFZ0KNL4l3xciq9zCm7S0OhXuyQw5EGu7WVw0OD
kzUkdWXAV4Ehc88BPlcM6FF/nfiUDw3gLQLZ76p8/mpKDNtmM2ibiq3umZoU+pyh
085Kszkz4yOKkB9JsSqbEsWczdr266eBAUwv8bFZu/DPHsCA0+VHMJBwBtW3GU2Q
Wc7GOqqO
=dbmv
-----END PGP SIGNATURE-----

--ugzAwLAkHfw/C8VP--
