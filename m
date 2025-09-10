Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01476CA0FED
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 16:03:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FF54830B4;
	Wed, 10 Sep 2025 18:03:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tgN5xi0C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C3C88318E; Wed, 10 Sep 2025 18:03:26 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FA63830A0
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 18:03:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-43838d8064bso526324b6e.1
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 09:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757520203; x=1758125003; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0aR/QyJ+3PMs1Uo3v1wTsYxwTROD6+GCCBdMuXfusgI=;
 b=tgN5xi0CsEXiJ5LsCQQf9lVg6jrlXcmfb47CoB4MH+Fr0pXS/cLKS7aABI2XkzfKoE
 gyNvZETllmERxUTdwtrDaesvITpDjR9AsBJdC7PY9KtC7FrC5yrSPWq/vfBBu2L/EH0h
 iCirwnGeJFnAMX8ZPapq1nq/NnPT/slJE5FWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757520203; x=1758125003;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0aR/QyJ+3PMs1Uo3v1wTsYxwTROD6+GCCBdMuXfusgI=;
 b=O85IShivfhbaw5aHfJ+7tuNdS9o/Ls1RzilE3bo1jWVkzkzbjZ6xarafCJJ2S3RsSR
 5zBehV/wrQtdIB4p1gC2i6FGA5jgUoHtUImbNkOPB1QP9bARPt5BkO/XdyX8YNH7Kn41
 +GgaJzib7E7dkC31MmrpZnsM8KRJ7RG3xGfJD/57WP+B12FH6Pa4V8nSigKKelAS51WN
 V5A15JcsU/R4tkx7xp1l2yrO9OmVGXOrT43ZhnlSFvZ6piLIhIPocMM5FZ2bNq/0/zSX
 HuSxbYi9AvAe1GOcWvXZ+AGohvW6u1/hPyWqf1X9iDAsV0cpTfDs6qcd6H9UbRyzwyPi
 nR/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcSxeZDUOsfE6+1Y5Ag8O2e5qOXqTEOFZuPMDBhZOfSC1X8bRH21aTpGd5YXadlS6Y6yoahRo=@lists.denx.de
X-Gm-Message-State: AOJu0YxdFxncohGiW6ut3eSVbfCuUNs0LhYZTOp5Uvm0K8c4WvcTNeQJ
 q1ScuFwYxLVD2AWY4VWS2MOq41LtUmtZMHrAqV6c82pFNU1d6JKvJLXHPV/244WHo9c=
X-Gm-Gg: ASbGncs5BtdBH6iRpttqcVGipv2u6DsxZRKDoFivjBQ9pxrkSj9yXXJRnDf1Ap2EXqb
 6XSM8G3IwbdH3YfARyO/1puD7jYOX5ts+eS3u03Ehr2DiaVMvyKKgZSakMXExXkbQNksR1k5uTG
 yAh7EN488CC0khDtwoXbG7UAthAPLMJsWZ0r95gKYxoqAdhun+AtP4ZUxm7SOmYsFJQ0BlrhXiL
 tjWBi2k0vY/8yy4N4OsdSPpF3Ip95DW/jtkDDyPpu0iIhsDjE0fNNipmVHY2bExga5EnEMtguWr
 dY4iWFbMd7jUsajs3PUlC87sCBSZ2/VGinZJkVpbvB2gf+4Yx/O+yIuB4J7mYiXlr+Dgnci//HF
 cA6cMd+go56OkxZiUDUWl7ryrs8bNCtBQieaONsHyUCAcLpSBOQ0l8WWTeD8wtWQqp1Q=
X-Google-Smtp-Source: AGHT+IEyKaiLv1oC0T16PcExY4YTrknWOTHRYQZfAon9Sbf+DJ1HjWPhCBVYqYZaGD0bBHWSoww2Hg==
X-Received: by 2002:a05:6808:14cf:b0:437:f998:22 with SMTP id
 5614622812f47-43b7bc09546mr47822b6e.21.1757520202809; 
 Wed, 10 Sep 2025 09:03:22 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-43836abed32sm4945276b6e.29.2025.09.10.09.03.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 09:03:21 -0700 (PDT)
Date: Wed, 10 Sep 2025 10:03:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Maarten Brock <Maarten.Brock@sttls.nl>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "jerome.forissier@linaro.org" <jerome.forissier@linaro.org>,
 "sjg@chromium.org" <sjg@chromium.org>
Subject: Re: [PATCH 1/1] board: ti: am335x: Do not call disabled PMIC functions
Message-ID: <20250910160319.GG124814@bill-the-cat>
References: <DB6PR05MB4551D31271569EC04E8EC60F830CA@DB6PR05MB4551.eurprd05.prod.outlook.com>
 <20250908184342.7ec9500b@kmaincent-XPS-13-7390>
 <DB6PR05MB45516C241486780C8D198FCD830FA@DB6PR05MB4551.eurprd05.prod.outlook.com>
 <20250909162356.6ff75133@kmaincent-XPS-13-7390>
 <20250909143711.GV124814@bill-the-cat>
 <DB6PR05MB45511513B880348BFDA2CB77830EA@DB6PR05MB4551.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Zt4DzL9VL65zTZPP"
Content-Disposition: inline
In-Reply-To: <DB6PR05MB45511513B880348BFDA2CB77830EA@DB6PR05MB4551.eurprd05.prod.outlook.com>
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


--Zt4DzL9VL65zTZPP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 03:37:35PM +0000, Maarten Brock wrote:
> > From: Tom Rini
> >=20
> > On Tue, Sep 09, 2025 at 04:23:56PM +0200, Kory Maincent wrote:
> > > On Tue, 9 Sep 2025 12:45:10 +0000
> > > Maarten Brock <Maarten.Brock@sttls.nl> wrote:
> > >
> > > > > From: Kory Maincent <kory.maincent@bootlin.com>
> > > > >
> > > > > On Mon, 8 Sep 2025 16:05:04 +0000
> > > > > Maarten Brock <Maarten.Brock@sttls.nl> wrote:
> > > > >
> > > > > > When PMIC drivers are disabled their functions should not be ca=
lled.
> > > > > >
> > > > > > Signed-off-by: Maarten Brock <maarten.brock@sttls.nl>
> > > > >
> > > > When a board is using a certain PMIC it should be possible to desel=
ect
> > > > all other PMICs that are not present. There is no point in keeping =
unused
> > > > code in the binary. Isn't that the whole idea of the configuration?
> > > > The current situation gives a build failure when the unused PMIC is
> > > > deselected.
> > > >
> > > > This file board/ti/am335x/board.c gives the impression to be useabl=
e for
> > > > all AM335X based boards, including those yet unknown. What if a boa=
rd
> > > > does not need any PMIC configuration, because the default strapped =
config
> > > > is enough, does one still need to drag those drivers along?
> > >
> > > Indeed, I hadn't understood that you would face a build error as the =
PMIC
> > > functions are not defined if we disable PMIC configs.
> > >
> > > I think the first issue is the design of this board.c file, but, well=
 it is
> > > U-boot typical design.
> > > And scale_vcores_generic() is not a generic function at all ...
> > >
> > > Ok, your change are legit after all.
> >=20
> > A thing to keep in mind is that am335x_evm is intended for the TI EVM
> > family of boards and look-alikes (so all of the beagles which are
> > kinda-sorta TI EVMs depending on when you asked someone).
>=20
> TI and U-boot give the impression that this file could be used as a templ=
ate
> for any AM335x based board. That it produces build failures as soon as you
> modify some configuration contradicts that IMHO.
>=20
> The same goes for my recent patch about NO_NET and not providing
> ft_board_setup(). That also results in an unexpected build failure.

Yes, there is more "delete this code too" required here than on modern
TI chips where the goal of having easier to customize evm support was
(closer?) to being realized.

--=20
Tom

--Zt4DzL9VL65zTZPP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMGhQwAKCRAr4qD1Cr/k
CsBCAQCBCo9mTWLGDThkelng0r+34ofnvX6RrTMTRN1QxZxamAEA8r6HGDNafEnh
lTO2BNFh53+Jcf2bG76uNWSVfbnxgwg=
=i7Gc
-----END PGP SIGNATURE-----

--Zt4DzL9VL65zTZPP--
