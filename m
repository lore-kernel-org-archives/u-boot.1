Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FADEEC1127
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 19:32:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 226BE83935;
	Mon, 23 Feb 2026 20:32:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SSxRVQ7N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E6B583D3D; Mon, 23 Feb 2026 20:32:27 +0100 (CET)
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64CE080077
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 20:32:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x242.google.com with SMTP id
 5614622812f47-46391f4c1f9so2625700b6e.0
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 11:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771875143; x=1772479943; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yTmC8DRjy8kWT/MfhYCy4eHxjQHVZ/biwtTkftCZ3Oo=;
 b=SSxRVQ7NW4Ph8zdymESsJb/YrM1IIkc7cDx1VBGZaP4Uh1CVSnOXYNCR7gM7BOhqKq
 pvTy1yAkUzA8qF+/OTpa/F/Du2ymqoELZPKY3qhG5QjSkGFph4WBCNJFYF6j28vJkE/W
 lQWJsgswuZmIiPFJq1j4YT5ojRSJHPpSyLOMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771875143; x=1772479943;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yTmC8DRjy8kWT/MfhYCy4eHxjQHVZ/biwtTkftCZ3Oo=;
 b=KTx45Ezryq3Iryh2hNp4mMucN/gtaTiky/eGDIXp0LFYDdrvEi6g0PvYIWhw256WQa
 QZlB4mGgXhr6IA0tPVDYQ18qFP/lwJhyWOjviCUlAlZPLiHEu2U7BkonGuSexcqtk7py
 aDHHbinA4+BZg/itmWp3cwfytQr5ospmoTU9u2IgaMNgpcUQD/ecmlsUZXXrJraZP6Ay
 1Qer72Y44JwKsmly3KAuezNdkpUBRteWehnRoWz7lvhg3SNewO900HfBdqbT7kZ9wS8s
 jF1jHTxq8NjenewmfEHAjlRQSsRHMuqTcBckNiHr5sXksfqT0GCpGwkZlVZvb4PHzZee
 x5XA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0FCtGzKG97sVKxGBtZ2x0suNQR+ppk55W0K2gBq2GwiW8wDoTQwF2nIw6DJpaj2iIw5RVhbA=@lists.denx.de
X-Gm-Message-State: AOJu0YyCOr7bNGq8fS3qOkuJi+rMOkdgX1ets4hJ71tgkaS149kFAYF2
 d9jhg1EKv0RWAuUQmi7mrtd1r7A6cIp2zzkomDECa3cwnOo0d032qqpWSCGChFLEbh0=
X-Gm-Gg: AZuq6aJNw6s9aPuTol7HQcmXGZP2qokbzlCDraAdVVNxGxFLvy0ppo4W46xJUlt6xBU
 5U6nqVXtmm9Pn2PohOUXfyxixrfkUam987Cj6joXh5gdsY6qr4Ib0+anyi8rYsAHMo3pM1xbRv6
 id0UHk/eDx/wXm0Wlb5myfF2r+2A4aZDLjAGG/h1m6nbCx0v3aqZj5tr0FfbJQdZe/QCHIu9flO
 FSMCcollYFVkpXCsHINDiGJHZNGG4S9K4jWWzR4WO7wN8OgDp6nuYSeFq6F0klwMUh9ED3ACmAG
 MJ5OZM4RkOm92gPCFGnHJeFMpItxcv3qdwGtpI3WGdg6ZQkfoLe8t4pjLsRKrGMJ3FQ03jjMPol
 vq94ae2acyE8KfasWaaP9hl8Db37l2OeIB5+IFv/afrFMBkxj73YqYGq8POUrAukPKfXJEuMERV
 dVX/sovFUh/X1jgRjXQt+zs2y7qE2VTyKj6hsYLizx8qm3CvY08Mc7+uNC1owGzDvi0F1mtIpil
 3qoI+sT+eOCSx3oOaV8c8aSPBdkKniXUbr7NSa+arotv8CGYdg=
X-Received: by 2002:a05:6808:67c9:b0:450:7df:e90b with SMTP id
 5614622812f47-4644638e7e2mr4833045b6e.52.1771875143103; 
 Mon, 23 Feb 2026 11:32:23 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4644a1afa44sm5528040b6e.16.2026.02.23.11.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 11:32:22 -0800 (PST)
Date: Mon, 23 Feb 2026 13:32:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 =?utf-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 David Lechner <dlechner@baylibre.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>, Paul Spooren <mail@aparcar.org>
Subject: Re: [RFC PATCH 00/20] boot: add OpenWrt boot method and on-demand
 FIT loading
Message-ID: <20260223193219.GF3233182@bill-the-cat>
References: <cover.1771275704.git.daniel@makrotopia.org>
 <20260217174617.GD2747538@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dBRZvQxYpIdwDhvq"
Content-Disposition: inline
In-Reply-To: <20260217174617.GD2747538@bill-the-cat>
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


--dBRZvQxYpIdwDhvq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 11:46:17AM -0600, Tom Rini wrote:
> On Mon, Feb 16, 2026 at 09:21:14PM +0000, Daniel Golle wrote:
>=20
> > Hi all,
> >=20
> > This RFC series adds a new boot method for OpenWrt's "uImage.FIT with
> > embedded rootfs" firmware model, along with the underlying infrastructu=
re
> > to load FIT images on-demand directly from storage devices without copy=
ing
> > them entirely to RAM first.
> [snip]
> > AI tool disclosure
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > Major parts of this series were developed with assistance from GitHub
> > Copilot (Claude Opus 4.6, Anthropic). The AI was used as a coding
> > partner for scaffolding boilerplate, drafting documentation and commit
> > messages, running checkpatch sweeps, and iterating on review feedback.
> > All architectural decisions, U-Boot subsystem integration, hardware
> > testing, and final review were done by the human author. Every line of
> > code was reviewed and tested on real hardware before inclusion.
>=20
> First, I appreciate your honesty and explanation in the disclosure here.
>=20
> This topic comes up, and will keep coming up, and as a project we have
> not yet decided on a position. I know that the Linux Kernel has come up
> with:
> https://docs.kernel.org/next/process/generated-content.html
> so far. But I think that:
> https://docs.postmarketos.org/policies-and-processes/development/contribu=
ting-and-ai.html
> brings up points that are quite relevant too. Absolutely no one has been
> happy with when gitlab or patchwork were unusable / unreachable (and for
> some people are still unusable) but it's because of all the AI scrapers
> that things were unusable or now have anubis in front of them (blocking
> other humans now).
>=20
> With that said, I want to stress the "human is responsible" portion of
> what both links say, and that given where exactly these changes are
> aimed for, extra scrutiny is required. Things like:
> https://cyberplace.social/@GossiTheDog/116080909947754833
> show just how bad they are about introducing security bugs these days.

Following up on this part I suppose, I see in CI you're working on v2
but please make sure to follow up with the other outstanding questions
I've asked before posting that. Thanks!

--=20
Tom

--dBRZvQxYpIdwDhvq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZyrPwAKCRAr4qD1Cr/k
CnNXAP0WqXA34LSrrJjtN4kjG5xfu5h5riJSXOPd1VIlgh0MgwEAqo9+r+ViLfos
dtV9nGqHRRasToy61/OPpfEwgcULuQk=
=XkuE
-----END PGP SIGNATURE-----

--dBRZvQxYpIdwDhvq--
