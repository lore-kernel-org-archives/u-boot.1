Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DB5FD3764
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 15:12:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D272840B1;
	Wed, 25 Feb 2026 16:07:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AbfmzWF8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3C54840B1; Wed, 25 Feb 2026 16:07:53 +0100 (CET)
Received: from mail-oo1-xc30.google.com (unknown [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C1F483FF8
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 16:06:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-679ed01869fso200586eaf.0
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 07:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772031977; x=1772636777; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2AX9b2Ec75x347QG/LbqCRPnOzLb2uZyhsD/bqDhSP4=;
 b=AbfmzWF8jBU4b6wMoA2a77+o7tNUSXDrcRBhae5U4tclWM7mheAriRh6bAuIonC47O
 NPPtXJiYV85qjHJVjPeCHIy9po5MSByRe/GiT/8dN4fPjp1eXOTDIsaDyB0qYZkR4y3G
 UaZzMruKV1TFYlN0eVogA3Rpw8znUInTSRWto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772031977; x=1772636777;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2AX9b2Ec75x347QG/LbqCRPnOzLb2uZyhsD/bqDhSP4=;
 b=eNZIzzYu7vXRfEkfwp2h0joi5rTt5WXQ3/ggeO7vgfydMSqLVO/EEEATsn6+1oz8zQ
 uHoifl2nX/+/8Xx9Az2A07B5OeNG2Tl99mR6P1htrcOp5Q6SppfAzzpqIu5yZDaRxo+F
 qoSFCg633arOOgoh9lmYyVwiQ19P+jRIqy22nE200MbS5qRao6mWjCTOYEIQVWPS6F5n
 LFIdHRnOEp8JcYmZTjHnA4wKroP/2XPCgbzjeewqesTdf4rBJdT/HRMoC+YTvOSPslEa
 5Cb0H7NmhZOi5lpKGwDMEUdVq0noRA1CaA7Feuc7OyNZiONkEx1BP/3BC1Dz8kMyxW3F
 /3qQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7iPBFven4GO65XykWzOdjaYm57+cFyZRe9NfTUKHZknJew8gAW4MlJGasUwdWIBoreJaIyIc=@lists.denx.de
X-Gm-Message-State: AOJu0YwHf+kXFppPCl59sijGhzexsGlVpvukvlxGpuluAoF06Yw6LDJQ
 UCzAz4N8bCIFvnykaP/25m55i38RLR4yG5goaZijJm4tIANegElE1X9/9M7Qx0iswth7lyvbDb8
 NyNHA6Uo=
X-Gm-Gg: ATEYQzxpI94FUqPGV/cw7QMqYUMo33G/2y1jE4qQPDoCv84/7e9vVhW5WFANoaqH1sd
 JGcZ0oVCdS/rDdMX1hD3conZcprmzipEVkap55M56iFAXSbBjXNr9YtcARwk43MFu52eDaRsfi4
 H12ZrC7/3BRwlOsRf2OR6HL7iLvTYjzgsM63CyjajYqbo5JGglWIG8lSiWTXXUg7R+9LQvsc/pK
 b/J1WGRWeX4bYqBvKYMagUyfZRs97G81mamtIQolIV6spAvYavUNhKjLmwjXLiS7JRLZKonTWNX
 2+1wuezZdP1jZGitYaMwJeMeH/BcetjQTSUR5Y1vZq3BGYyfZcaR9X1AoGfO1IkIXSTFcrqgfqr
 npDV3y+k7ttkh8rzXFULzPJ1YEJh4gwk4TlXE+cYa8HLH4DVmHbxYSrx/+fF3BWsOgFwaO6nrSB
 eB6S0sfmwuROK5K66kiptoO35fpmGPwgi6kXfPhiJHFUY/ldd1mBCFNIKmba+lXhvOZle7v/Bry
 U1DGgTSxFuo9xvd9hsluAAmUf23kEKeffRbtfI5RlDO+uAjGQU=
X-Received: by 2002:a05:6820:3089:b0:662:e066:73a1 with SMTP id
 006d021491bc7-679ef99f2b5mr296456eaf.57.1772031977083; 
 Wed, 25 Feb 2026 07:06:17 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-679c56ec619sm10757396eaf.13.2026.02.25.07.06.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 07:06:16 -0800 (PST)
Date: Wed, 25 Feb 2026 09:06:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Casey Connolly <casey.connolly@linaro.org>, Anshul Dalal <anshuld@ti.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Justin Klaassen <justin@tidylabs.net>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Samuel Holland <samuel@sholland.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] drivers/power/regulator: add SPL_DM_REGULATOR_FAN53555
Message-ID: <20260225150614.GG1593142@bill-the-cat>
References: <20260225065714.48562-1-heinrich.schuchardt@canonical.com>
 <a278f2ec-4ed9-4574-8d9e-ad5b90fb6e09@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="S+FaGuZ7vjo3zTjM"
Content-Disposition: inline
In-Reply-To: <a278f2ec-4ed9-4574-8d9e-ad5b90fb6e09@cherry.de>
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


--S+FaGuZ7vjo3zTjM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 03:26:11PM +0100, Quentin Schulz wrote:
> Hi Heinrich,
>=20
> On 2/25/26 7:57 AM, Heinrich Schuchardt wrote:
> > Symbol CONFIG_SPL_DM_REGULATOR_FAN53555 is selected by
> > SPL_DM_PMIC_FAN53555 and used in a Makefile. But the
> > symbol definition is missing.
> >=20
>=20
> Well it is "used" in Makefile simply because I wanted to be able to NOT
> build it for xPL stages. I'm thinking we should use $(PHASE_) for most
> symbols in Makefile, even if we don't have an xPL symbol in any Kconfig f=
ile
> such that one would explicitly need to add an xPL symbol and enable it for
> the feature to be enabled in the xPL stage.

We should, generally, use $(PHASE_) in Makefiles. But it's not a simple
conversion because there are cases where SPL depends on CONFIG_DRIVER=3Dy
to build a needed driver. This was part of one of the long threads Simon
and I had last year (or the year before?) where at one point I lamented
that Yamada-san was right and configuring the build the way I was
intended would lead to these kind of problems down the line.

> Maybe we even need a PROPER_ prefix for PHASE_ when not in xPL for example
> for things that make sense to be stage-specific. There are some symbols t=
hat
> should represent something enabled across stages (e.g. the CPU architectu=
re)
> where the PROPER_ prefix wouldn't make sense. I'm often confused as to wh=
at
> is a symbol that must apply to all stages by design or simply because
> someone didn't bother to implement separate xPL switches for that (yet).

Yes, this can be confusing. It would likely be less confusing if we at
least converted things to be consistent about it in stages.

--=20
Tom

--S+FaGuZ7vjo3zTjM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZ8P5QAKCRAr4qD1Cr/k
CnqVAP9mQHQPfZj+Fw0QS6SCaBO2rh9Yj7hUzI6sQIl0SdqTqAD/fXMDZZslQ69x
M7oHtZTMDzttsVb97+PhsXnGfCP1xA0=
=X7z5
-----END PGP SIGNATURE-----

--S+FaGuZ7vjo3zTjM--
