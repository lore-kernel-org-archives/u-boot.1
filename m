Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 670E2C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 20:07:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF60D88540;
	Fri, 21 Jun 2024 22:07:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eviR0j2c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16A7B8852D; Fri, 21 Jun 2024 22:07:43 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20CED88540
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 22:07:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6f9603730d5so1274998a34.1
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 13:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719000459; x=1719605259; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=m+a8/u5rZCMHnfopPS9dZ5X+mVZ9BBJRaiXzVi+rWgc=;
 b=eviR0j2c0osdDKQLIv+AgGwbC9DZAL3lPuKFkaFDAsdJ4/01UZsZTqe+xTESOJnnj5
 2hUjjjvoj0lsHsfuBjpAwj6zUz1jiV3B9nWgc7TmfQPb1/mbj6dbL1Bmdr/oCeR1tEoA
 0yAgtm/Vt61sk9v3eeLa0dtp7Nlma2lXRGN70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719000459; x=1719605259;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m+a8/u5rZCMHnfopPS9dZ5X+mVZ9BBJRaiXzVi+rWgc=;
 b=JmMGJtebsxhBn2x+QEr5pHSDnp+Dsjxy+fRIoDKEyu3h//iYyq0DsWeKaGlZyijpmr
 01iQdo5hh/kpG4KHIQOiA3gr2zbsUGPXSe9qIweBUDdBl7grSpcpKyz8mGF2hysj9iy+
 NacowTa9ATouXyM00QKsEY40EcXZ8IR7c0lap0CkuYikIk4T6MoIluWPHdeGSv8Q1OxO
 IgprqI0qw/JmZKKepRRH9KLW4iU8CJCuC7baMj2IDUCRnFeeG9JBNSe+hiQikBU2Xe7h
 QL6lvAk3FquLvajqKbf+jFFlBE2ohtmQDDkcptT0j+lJ50Uo+7MTZl7gi/w3dEcaKKWv
 32Ig==
X-Gm-Message-State: AOJu0YyaV3CAo9rHFsaDdBE55kRpqoUn7V6iB2M0DE9u8PNuCLGsK9Ii
 EVYwQlnUe1xTQWErKG8GHMmWf3zlVFsemgUBcbtysN8lRbs5pyaHuOwudCHR9f0=
X-Google-Smtp-Source: AGHT+IG2/WWca2pp6jpjQj97SunOoh8wF247NCjnzW803jY863DPNgiEH85B2/OUoShUKyFrUMkjsQ==
X-Received: by 2002:a9d:6851:0:b0:700:8da9:1dc9 with SMTP id
 46e09a7af769-7008da9246fmr7803732a34.29.1719000458657; 
 Fri, 21 Jun 2024 13:07:38 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7009c65be9csm360997a34.50.2024.06.21.13.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 13:07:38 -0700 (PDT)
Date: Fri, 21 Jun 2024 14:07:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jerome Brunet <jbrunet@baylibre.com>, Marek Vasut <marex@denx.de>,
 Neha Malcom Francis <n-francis@ti.com>,
 Pavel Herrmann <morpheus.ibis@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v2 00/43] labgrid: Provide an integration with Labgrid
Message-ID: <20240621200735.GB68077@bill-the-cat>
References: <20240621195204.2675252-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tp1b+8QGAKhNmCJn"
Content-Disposition: inline
In-Reply-To: <20240621195204.2675252-1-sjg@chromium.org>
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


--tp1b+8QGAKhNmCJn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 01:51:21PM -0600, Simon Glass wrote:

> Labgrid provides access to a hardware lab in an automated way. It is
> possible to boot U-Boot on boards in the lab without physically touching
> them. It relies on relays, USB UARTs and SD muxes, among other things.
>=20
> By way of background, about 4 years ago I wrong a thing called Labman[1]
> which allowed my lab of about 30 devices to be operated remotely, using
> tbot for the console and build integration. While it worked OK and I
> used it for many bisects, I didn't take it any further.
>=20
> It turns out that there was already an existing program, called Labgrid,
> which I did not know about at time (thank you Tom for telling me). It is
> more rounded than Labman and has a number of advantages:
>=20
> - does not need udev rules, mostly
> - has several existing users who rely on it
> - supports multiple machines exporting their devices
>=20
> It lacks a 'lab check' feature and a few other things, but these can be
> remedied.
>=20
> On and off over the past several weeks I have been experimenting with
> Labgrid. I have managed to create an initial U-Boot integration (this
> series) by adding various features to Labgrid[2] and the U-Boot test
> hooks.
>=20
> I hope that this might inspire others to set up boards and run tests
> automatically, rather than relying on infrequent, manual test. Perhaps
> it may even be possible to have a number of labs available.
>=20
> Included in the integration are a number of simple scripts which make it
> easy to connect to boards and run tests:
>=20
> ub-int <target>
>     Build and boot on a target, starting an interactive session
>=20
> ub-cli <target>
>     Build and boot on a target, ensure U-Boot starts and provide an inter=
active
>     session from there
>=20
> ub-smoke <target>
>     Smoke test U-Boot to check that it boots to a prompt on a target
>=20
> ub-bisect
>     Bisect a git tree to locate a failure on a particular target
>=20
> ub-pyt <target> <testspec>
>     Run U-Boot pytests on a target
>=20
> Some of these help to provide the same tbot[4] workflow which I have
> relied on for several years, albeit much simpler versions.
>=20
> The goal here is to create some sort of script which can collect
> patches from the mailing list, apply them and test them on a selection
> of boards. I suspect that script already exists, so please let me know
> what you suggest.
>=20
> I hope you find this interesting and take a look!

Can you please split this up in to 3-4 series so that they can be
reviewed and merged? Thanks.

--=20
Tom

--tp1b+8QGAKhNmCJn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ13YAACgkQFHw5/5Y0
tyw0Kgv+PuFzr13bjuYFvfPijZHVQ2OP+RrsB1avqXIBC2nfEfGKD7wv8N0sYa98
LALoFyTZ3LRZPDqpXSmtYhljZFCGkSDvV9yheufiAx+4DwkSe/JTO1wFgLpOeGjQ
BMD3JBrKE/ZQxeYkBYX0yrXUZawGucF0qhuQPZJPg2CFhVHEJsiYV+ovP829YD+Y
FeLig16zyiEL+Krv6aEPHeFF7fV2raoMNhWDQR3waRNbavP0RQGZkXLmy2WoYgM2
6l8VRt3h+AjYV6IqYj1uczWu/k+JYpMI0DpQOBvhAGYXKpfoTDm4WkiND5Zu2f8j
URkes+qLFNSs6NeC9TFIFEdYjMjN0se7vQtQK3sX14r4bjPqdrLQBmfqFFX0Ja78
Kf+9vpbOqHKWMUD6ppeOiKpgQl5+CYPtiYNP2JAnDWTLK1MHWMV0onRoIS8E2RNf
Q5GOK1GDRkuI/aQAcKM7bFCm2U75g7Li6A7EGuxxjO4SgwTN5DljFAVv9C5M7XtM
k+01HoaV
=OgLN
-----END PGP SIGNATURE-----

--tp1b+8QGAKhNmCJn--
