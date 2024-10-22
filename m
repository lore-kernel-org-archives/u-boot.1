Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1856D2C560
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 14:43:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F39BE885B3;
	Tue, 22 Oct 2024 16:43:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UqkBUrTG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AF7788969; Tue, 22 Oct 2024 16:43:52 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91C51883D4
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 16:43:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6cbd1ae26a6so34551476d6.1
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 07:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729608228; x=1730213028; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AXgDUpNXiq57dlEnls+47dM1OGDYWAN/2xpAi6eZuDw=;
 b=UqkBUrTG7Egyfaj9gl5Pk4qNYEcyZ2Qrj2fjZhVW+GlwYg4jG2tklLnEjvG28xCSgf
 3b1NGxABO9eOeMP9vGSTYZGk9lI4NXdt8i4LGxZ3AA0yOpiq1+PKggk3+Sy7ajhVCwtQ
 cEOSeTkSq1LHw7IcuBC2yRiEjyE0vkgem+JMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729608228; x=1730213028;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AXgDUpNXiq57dlEnls+47dM1OGDYWAN/2xpAi6eZuDw=;
 b=MLXHdhnhI2GFqBfom1745eRATlLhmwoAY9auQugnKW/ME66QjxwlgWt8iMwcoESI0j
 avd/60XM+S5llqKvxaUJ50+VyweRHXUlJrmFKdLaperHGRA8OlJ9mnRsdm/4V6OzascO
 wm7U60sdJXWsj8JmjIeC7N9ANjQ3cvo/I+6lLnG2duY31LhEiht5Y5v29oPif5LVPIW/
 diZ8YqB87IC9oO11Cew3bcj0tg9BIRqV7yESm8HSKnALqqjJ6DEDDcxXlFUv8gGn/NmG
 66GxT9+IVjsLfzy8exHOiJM5bVtHNQNcxxMw8WyC0TGIgN5UxQCMQnz6yS62CA+WRjE3
 SfwA==
X-Gm-Message-State: AOJu0YxiwiH713cpivbWBoYt99E4BH4ftYD3+AariGVE4p2j32p9AJ3O
 v4T8DFIE07yuKI3EGvAAGXiuRK9kfQZwCyOlRq0wvZKn8rOPtAOFX/Q9q3cR43b8CekW5c9r5fl
 f1c7OYw==
X-Google-Smtp-Source: AGHT+IENy6BE1fG0NKyJRkLKO9gGv7pPOF3NtfRLOQGl5TVfvzQ87Z48eKbgeiWLbIEjNudMKkZfAQ==
X-Received: by 2002:a05:6214:3d99:b0:6cb:4a84:e02a with SMTP id
 6a1803df08f44-6cde1506220mr243663796d6.16.1729608228389; 
 Tue, 22 Oct 2024 07:43:48 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce00999c47sm29263806d6.96.2024.10.22.07.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 07:43:47 -0700 (PDT)
Date: Tue, 22 Oct 2024 08:43:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v7 00/11] labgrid: Provide an integration with Labgrid
Message-ID: <20241022144345.GE4959@bill-the-cat>
References: <20241010015145.1977999-1-sjg@chromium.org>
 <CAFLszTjT+yh70hRQ-7chXbQdE4Q_wzU1+Rom39+UtUOPc6HfGg@mail.gmail.com>
 <20241021180738.GP4959@bill-the-cat>
 <CAFLszThe2LswCwG3ewEj=A9ZD-MPzmX4MovF5TKY-BK4LW09tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lkXxxk829OHWPXee"
Content-Disposition: inline
In-Reply-To: <CAFLszThe2LswCwG3ewEj=A9ZD-MPzmX4MovF5TKY-BK4LW09tg@mail.gmail.com>
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


--lkXxxk829OHWPXee
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 02:15:40PM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 21 Oct 2024 at 20:07, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Oct 21, 2024 at 01:12:49PM +0200, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 10 Oct 2024 at 03:51, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Labgrid provides access to a hardware lab in an automated way. It is
> > > > possible to boot U-Boot on boards in the lab without physically tou=
ching
> > > > them. It relies on relays, USB UARTs and SD muxes, among other thin=
gs.
> > > >
> > > > By way of background, about 4 years ago I wrong a thing called Labm=
an[1]
> > > > which allowed my lab of about 30 devices to be operated remotely, u=
sing
> > > > tbot for the console and build integration. While it worked OK and I
> > > > used it for many bisects, I didn't take it any further.
> > > >
> > > > It turns out that there was already an existing program, called Lab=
grid,
> > > > which I did not know about at time (thank you Tom for telling me). =
It is
> > > > more rounded than Labman and has a number of advantages:
> > > >
> > > > - does not need udev rules, mostly
> > > > - has several existing users who rely on it
> > > > - supports multiple machines exporting their devices
> > > >
> > > > It lacks a 'lab check' feature and a few other things, but these ca=
n be
> > > > remedied.
> > > >
> > > > On and off over the past several weeks I have been experimenting wi=
th
> > > > Labgrid. I have managed to create an initial U-Boot integration (th=
is
> > > > series) by adding various features to Labgrid[2] and the U-Boot test
> > > > hooks.
> > > >
> > > > I hope that this might inspire others to set up boards and run tests
> > > > automatically, rather than relying on infrequent, manual test. Perh=
aps
> > > > it may even be possible to have a number of labs available.
> > > >
> > > > Included in the integration are a number of simple scripts which ma=
ke it
> > > > easy to connect to boards and run tests:
> > > >
> > > > ub-int <target>
> > > >     Build and boot on a target, starting an interactive session
> > > >
> > > > ub-cli <target>
> > > >     Build and boot on a target, ensure U-Boot starts and provide an=
 interactive
> > > >     session from there
> > > >
> > > > ub-smoke <target>
> > > >     Smoke test U-Boot to check that it boots to a prompt on a target
> > > >
> > > > ub-bisect <target>
> > > >     Bisect a git tree to locate a failure on a particular target
> > > >
> > > > ub-pyt <target> <testspec>
> > > >     Run U-Boot pytests on a target
> > > >
> > > > Some of these help to provide the same tbot[4] workflow which I have
> > > > relied on for several years, albeit much simpler versions.
> > > >
> > > > The goal here is to create some sort of script which can collect
> > > > patches from the mailing list, apply them and test them on a select=
ion
> > > > of boards. I suspect that script already exists, so please let me k=
now
> > > > what you suggest.
> > > >
> > > > I hope you find this interesting and take a look!
> > > >
> > > > [1] https://github.com/sjg20/u-boot/tree/lab6a
> > > > [2] https://github.com/labgrid-project/labgrid/pull/1411
> > > > [3] https://github.com/sjg20/uboot-test-hooks/tree/labgrid
> > > > [4] https://tbot.tools/index.html
> > > >
> > > > Changes in v7:
> > > > - Rebase on testb series
> > > > - Expand commit message
> > > > - Rename option to --use-running-system
> > > > - Rebase on broken-out testb series
> > > >
> > > > Changes in v6:
> > > > - Rebase without an earlier patch
> > > > - Avoid doing the special shutdown unless USE_LABGRID is enabled
> > > > - Drop patch 'test: Pass stderr to stdout'
> > > >
> > > > Changes in v5:
> > > > - Add a few more comments
> > > > - Comment out the debugging, which might be useful later
> > > > - Add a patch to support testing with two board-builds
> > > >
> > > > Changes in v3:
> > > > - Split out most patches into two new series and update cover letter
> > > >
> > > > Changes in v2:
> > > > - Only disable echo if a terminal is detected
> > > > - Avoid running a docker image for skipped lab tests
> > > >
> > > > Simon Glass (11):
> > > >   test: Allow signaling that U-Boot is ready
> > > >   test: Release board after tests complete
> > > >   test: Allow connecting to a running board
> > > >   test: Introduce the concept of a role
> > > >   test: Introduce lab mode
> > > >   test: Improve handling of sending commands
> > > >   test: Avoid double echo when starting up
> > > >   test: Try to shut down the lab console gracefully
> > > >   test: Add a section for closing the connection
> > > >   test: Support testing with two board-builds
> > > >   CI: Allow running tests on sjg lab
> > > >
> > > >  .gitlab-ci.yml                        | 153 ++++++++++++++++++++++=
++++
> > > >  test/py/conftest.py                   |  73 ++++++++++--
> > > >  test/py/u_boot_console_base.py        | 123 +++++++++++++++------
> > > >  test/py/u_boot_console_exec_attach.py |  31 ++++--
> > > >  test/py/u_boot_spawn.py               |  36 +++++-
> > > >  5 files changed, 363 insertions(+), 53 deletions(-)
> > > >
> > > > --
> > > > 2.34.1
> > > >
> > >
> > > Is there any news on these patches? I would dearly love to enable my
> > > lab and this is what is needed...
> >
> > As our approaches are radically different I continue to be looking for
> > feedback from a third person to set things up and say what does /
> > doesn't work for them and their lab. I assume you're just pulling this
> > in locally for use at least.
>=20
> No, I cannot pull this in locally. I would like to set up gitlab so I
> (and others) can push things to it for running on the lab. Without my
> patches the lab only works on a few boards.
>=20
> Could you perhaps try them out on your lab, to check they don't break any=
thing?

Your setup requires changes to labgrid itself, yes?

--=20
Tom

--lkXxxk829OHWPXee
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcXuiEACgkQFHw5/5Y0
tywPHgv/YcXM43L/6oY22oGGZu3M1w6MDW+IQi2cThADan8nRVe/9dxxDms2P3mI
JuwE+jMGuZwooG2C+5erlE4PMj9YNOcRQ7TwB8A3QkGwqotF3ZpS3Z8FfiEJ9gYA
Ikpi6sQ26EdbEtWCpBOjLm2htTEk4OCl/dzR+XllmXQhHAK08iLiXyRCYiQhzlmm
HW9ijGh8Mr4qdflDz3Jm9WYvFPl6KOhWYHis/oeMUYkg8y+4yY/8FCMHZROim2AH
p3AgfB//00S46mVZfQQNdABhzkECs/B+erjmyxmCbDfap1L2K25q2z/fodrKWrVu
cpH2QVHN1SAPxnnmpYjGLojXOzwFDz5xNR7dAwxdAikpXHLggDYnO1IZzg0YPslj
xlphuxqMWtozxiOoay0d5XTCCpK1ac6K/MFVSa7hlqopiJm25L1ghwvqiXQ2gL0Z
9kVX8L84LyGu8YIGxfDPqulmVHg3wlCXbgVum3ozHtlATwxY6EmTOw7sVj8bFe6e
9R8VFCGM
=b6uL
-----END PGP SIGNATURE-----

--lkXxxk829OHWPXee--
