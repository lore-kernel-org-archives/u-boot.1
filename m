Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E471DCE7A95
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 15:05:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 432CF86D44;
	Mon, 25 Sep 2023 17:05:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="S/3dCHwA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6842C86D45; Mon, 25 Sep 2023 17:05:40 +0200 (CEST)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AD6B86C28
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 17:05:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-d7f0a60a159so7666258276.0
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 08:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695654337; x=1696259137; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7YR0Suh8wVa+xvkGUacfTAcvBFbfD8wgRtt+PYqDSjU=;
 b=S/3dCHwAtAnaJWeMMMFqfsC+tsx5t8gSUHMRAj/Z7zqIzr1MZSNCgLW5J6aM3QL0de
 Gb2zCcFdYV7L59gxwRPL4AoAvqIqxrL02ydDr1J20dx2LcwKSUuCPxcQfPd7BgKGW4ST
 1z3SoJUKyvK+WOIM0qIfWe0wWbo0Ky5BgINto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695654337; x=1696259137;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7YR0Suh8wVa+xvkGUacfTAcvBFbfD8wgRtt+PYqDSjU=;
 b=R8fv47u/lofiLkz0vbQxYwYylurU9mvbqJjtF3H4XLwM+r7PZVyo/yDWnPjtWHXr+w
 TbkEUeT6nZw1ZqX5ihAqEsXm3wuA742GRt51uEqJg6Y9gyoFlc4yppFAHsIRtoUkJwcM
 voahNNA+iXMgx0LrVcpV7z/1/0+MQo3VIDtSeXYnNPpzfO/tBlvbIbeAAiN2YIXY7efn
 prZgs5rdOz8MzImn6YB4bgdLeVXZQvE1Mq9xSCEizOn5cdzBUjhFvctpbjSjZi28iVRm
 J8R7Ym5bdvXb1xMBQYIVtMFN888fjDOxMfKOGiN16yEcSf10F1agRf03OY7C4Eu/Vr17
 nT1A==
X-Gm-Message-State: AOJu0Yxx4pQKEdefVt7usWDKr7IFgwFCosyPLQ16Zm5nnaYR1i29Rh5U
 shkIv72WgTDuoYTsu4JKzmq8Ow==
X-Google-Smtp-Source: AGHT+IHC68GW3uoLMwwWXRgmCzJM81cSFQSOU2NNyukiyhUFgiX4ipFPND4TxPxTpu56LN8tpFaThg==
X-Received: by 2002:a25:903:0:b0:bc9:92c9:7fd1 with SMTP id
 3-20020a250903000000b00bc992c97fd1mr6131724ybj.3.1695654336681; 
 Mon, 25 Sep 2023 08:05:36 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d32b-b307-decd-cdc4.res6.spectrum.com.
 [2603:6081:7b00:6400:d32b:b307:decd:cdc4])
 by smtp.gmail.com with ESMTPSA id
 v16-20020a056902029000b00d746487d6f7sm2135333ybh.35.2023.09.25.08.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 08:05:36 -0700 (PDT)
Date: Mon, 25 Sep 2023 11:05:34 -0400
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Neha Francis <n-francis@ti.com>, Bryan <bb@ti.com>,
 Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Re: Config fragments
Message-ID: <20230925150534.GA305624@bill-the-cat>
References: <CAPnjgZ14CUVt=rM943hh9PQUhK9LJDgZYPxUsATYQe3wwOUYqQ@mail.gmail.com>
 <20230823155558.GM3953269@bill-the-cat>
 <C098A4DC-CE20-4516-8971-B52041120BCD@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zyH6NyMDncZ2YU3c"
Content-Disposition: inline
In-Reply-To: <C098A4DC-CE20-4516-8971-B52041120BCD@gmail.com>
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


--zyH6NyMDncZ2YU3c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2023 at 04:18:45PM +0300, Svyatoslav Ryhel wrote:
>=20
>=20
> 23 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80. 18:55:58 GMT+03:00, =
Tom Rini <trini@konsulko.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=B2(-=
=D0=BB=D0=B0):
> >On Wed, Aug 23, 2023 at 09:30:31AM -0600, Simon Glass wrote:
> >
> >> Hi,
> >>=20
> >> Up until 2023.04 it has been possible to build all the defconfigs but
> >> with 2023.07 that changed. Tom mentioned this to me recently.
> >
> >I'm adding Svyatoslav who is the person that brought in all of the
> >config fragments that are going to be in v2023.07.
> >
> >> Up until 2023.04 we can enumerate all the board configs that can be
> >> built. We can build any of them using a single name and a single
> >> defconfig. The boards.cfg file which buildman creates contains a full
> >> list of things that can be built.
> >>=20
> >> From 2023.07 this changes and we now have random .config files
> >> sprinkled about the place. I say random because they are not connected
> >> to anything. For example, here is
> >
> >They aren't random.  They're, just for v2023.07, in configs/ and then
> >moving forward, they're in the board directory.  I would like to see
> >them in more places possibly, but that's not something I'm sure enough
> >on right now.
> >
> >> board/ti/am62x/MAINTAINERS:
> >>
> >> AM62x BOARD
> >> M: Dave Gerlach <d-gerlach@ti.com>
> >> M: Tom Rini <trini@konsulko.com>
> >> S: Maintained
> >> F: board/ti/am62x/
> >> F: include/configs/am62x_evm.h
> >> F: configs/am62x_evm_r5_defconfig
> >> F: configs/am62x_evm_a53_defconfig
> >>=20
> >> BEAGLEPLAY BOARD
> >> M:     Nishanth Menon <nm@ti.com>
> >> M:     Robert Nelson <robertcnelson@gmail.com>
> >> M:     Tom Rini <trini@konsulko.com>
> >> S:     Maintained
> >> N:     beagleplay
> >>=20
> >> In most cases the MAINTAINERS file tells us about each board and until
> >> [1] I had assumed that was the case. With that patch reverted, these
> >> are the only 'orphaned' MAINTAINERS entries (buildman
> >> --maintainer-check):
> >>=20
> >> WARNING: orphaned defconfig in board/armltd/vexpress64/MAINTAINERS
> >> ending at line 8
> >> WARNING: orphaned defconfig in board/google/veyron/MAINTAINERS ending =
at line 44
> >> WARNING: orphaned defconfig in
> >> board/mikrotik/crs3xx-98dx3236/MAINTAINERS ending at line 7
> >> WARNING: orphaned defconfig in board/st/common/MAINTAINERS ending at l=
ine 6
> >> WARNING: orphaned defconfig in board/ti/am62x/MAINTAINERS ending at li=
ne 15
> >>=20
> >> But Tom advised me that MAINTAINERS is not intended for this purpose,
> >> so the check has been dropped. I am not suggesting we bring it back,
> >> necessarily, but if we did, we could use it to specify the .config and
> >> defconfig files which are used by each board.
> >
> >Note that the "N" syntax has been in use, for defconfigs for a lot
> >longer, and is why the CI check for unmaintained / orphaned boards
> >stopped working.
> >
> >> *Failing that*, I suggest a new 'name.brd' file in the board directory
> >> to contain this information, e.g.
> >>=20
> >> # Contents of board/ti/am62x/beagleplay.brd:
> >> beagleplay-r5: am62x_evm_r5_defconfig beagleplay_r5.config
> >> beagleplay-a53: am62x_evm_a53_defconfig beagleplay_a53.config
> >>=20
> >> This could be parsed by buildman and other tools, to produce a list of
> >> available boards and to build each using a single name (e.g. make
> >> beagleplay-r5_defconfig)
> >>=20
> >> What do people think?
> >
> >I'm not sure I like this direction honestly.  Do we want CI to cover
> >these configurations?  Maybe.  But it's just for CI.  Using the TI
> >examples, I don't know that you can use buildman today to generate a
> >functional binary (and if you can, if --keep will retain the right
> >files).
> >
> >Maybe we just need to make it clear that if you use config fragments
> >then you're opting out of CI for that specific platform.  That should be
> >fine for example for the TI ones that will be built in OE a bunch
> >anyhow so accidental failure to builds will be caught.  I don't know
> >about the Tegra platforms.
> >
>=20
> Greetings! Are there any progress regards fragments move or this will
> hang in mailing list indefinitely?

I don't follow, sorry.  Yes, please send a patch on top of next to move
the fragments for Tegra platforms to match how they're done for TI
platforms now.

--=20
Tom

--zyH6NyMDncZ2YU3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmURobcACgkQFHw5/5Y0
tyyUdAwAnoOvmbLEGqQyqIQzegcjlDB6aW31N5cfuL+X6upLVBF3vkjxgUHUyXXz
4bSc3bCA5vG+AkgfWNGFHviisx2785SgNak9aFqT6mWpyqgTwN8pGIsFfzue/9vp
yuLZtGiC1rNfRH0aZyGOcMVwRyNrBRz4+c0DOFALyvmHvadJ/9uaTwrpyjNQgHg0
y6BIu9AIIfF2dNs7aPmOpu/wEcI+ChA9g6TzyDlwfl5JIiU82VrOGJizyRUfIB9V
SmLkZeEOrN3IwKAFgtTdj4c25q5xhWa53RRVowswukYLaTlqTYwlBodvHsBe6PFo
wv8bIUdZWjiT4fO6BGshwHFsEKb8uYw7Nn3J8O67WpiJj3oR2dPC3JN9ZGyzyI3g
PVNGAF6l4DUqqNEcy8IckQPOeB4I+YtppaZeM9UAUtSl7JUszkpF9dCCWx6nXncK
DpnjQ1KfpApVDUOlqVWCG/ba3HfM8peO6qu2zbd0PmoAWgEL6HwGTr5QtUvs7zLE
cfAMLrPh
=C5ai
-----END PGP SIGNATURE-----

--zyH6NyMDncZ2YU3c--
