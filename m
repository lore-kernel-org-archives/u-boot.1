Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A81ACA1017
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 21:43:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B647B83931;
	Fri,  5 Sep 2025 23:43:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IUXNp0fj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6479383935; Fri,  5 Sep 2025 23:43:50 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 334CB803F5
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 23:43:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-61e45eb42ccso906324eaf.3
 for <u-boot@lists.denx.de>; Fri, 05 Sep 2025 14:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757108627; x=1757713427; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GdLh+qfua5P4sqJG2Dk6NvcxF1mlaXGhXe5DWOE0mLw=;
 b=IUXNp0fjU1/Gdqi7FEZhixY54qvrrv5ijGDlGkHGx+QKkyyIaVmAwdh2fJ54ZFDV+v
 qc3UAe4ItZLfCyACLZuVD0xXdkBpsVZQBTsV940eeIAxHX9omzBICIn9SWhwCeiudiQ7
 sgeWp0zYDPBbgQlTMsyKSJRw6LdJWACPYkvqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757108627; x=1757713427;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GdLh+qfua5P4sqJG2Dk6NvcxF1mlaXGhXe5DWOE0mLw=;
 b=noczuXlbUEQgjrzH0O64vYVxzU63qFZBG3Wvhku9TCYor1HX5ByDfc6rnO/2mKeCr8
 1OXscf2/PXlahDh1FWrjM/3h5bcHfZrS3WSMv1CDY0tkiD932DXVOLU0QlJze6W3oHYa
 lIBS2AuVDmzANUTzjufGzEhWow8YB3yOjM7qu8xhZctJpAgw457IXcI6mDG/hL3x1wXg
 W3LXlInXfl+04bSfEPyP4XGACchM70i0zA5LKG+3NItqX+y1Y+7maUwBQqp4EjLle8b2
 Xj62sSIBMYMCwEr5JclewV+xkBsGp4BSYxrAf0xorqLk8W4uwD7SDO6uqRIAXER7N8mk
 jjrQ==
X-Gm-Message-State: AOJu0YyvoJP0i6A3VCwBGEDRC2FNcu+847nd0UaJaD3680OypjvG0RSh
 dwO3AYwi8ixHxhsDawU52+glFvI+sWVL8Ed/sxV2e6d/zuK1jc7zwc/oDHTxvIRMHOl5+VolVZY
 4agegCVY=
X-Gm-Gg: ASbGncsHWQoacznROGc4uVu3x2XakQB8bKAOo0GFU/dkv7ngQruiUHhrbaDFR5bO3+r
 sXDaESST/QzoufOb8vqWRPeOE0b11PIba3QmJr2E96v4B2OcqsIqEUgrQsksEGdFPe7X3oS8oVj
 kCb990XvxEWxWn0qpHHKknejDgUhKwtwCyaFkqszWaef2WY4d5P3/MmtNdDf3tNuyZZvt/Z6KeM
 J3kkYjRg11e2hhL+eo42QcHBAT1GIzd2Ci84b03pk9EGBNCnYro29SDZRhXaIbRuaThKdoNA3On
 +OzjKp759d5afsIm6mKwQfka7v7jxEKSesVjOO4yILDZlfPxVQUxS/RpvaUWjbRQzpwsrEd2wDp
 BndiYi5ybLlVXa5gUQ1pPM+3kkw04B94HfD9jKV9NkwMAPI4VaeLg6kNG
X-Google-Smtp-Source: AGHT+IEAPReS7+x1Mv039nM+PKxLxqoYdEBktU9dutI+7vFS5c6tfjwBa9qDpJQ2En0SMZP+TRW2tw==
X-Received: by 2002:a05:6808:22a1:b0:439:b491:4018 with SMTP id
 5614622812f47-43b29a2203fmr130318b6e.9.1757108626725; 
 Fri, 05 Sep 2025 14:43:46 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-62171226bd2sm394334eaf.4.2025.09.05.14.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 14:43:45 -0700 (PDT)
Date: Fri, 5 Sep 2025 15:43:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Maarten Brock <Maarten.Brock@sttls.nl>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 2/2] ti: Do not remove ft_board_setup for CONFIG_NO_NET
Message-ID: <20250905214343.GM124814@bill-the-cat>
References: <DB6PR05MB45517FBC403C54F9589F03878307A@DB6PR05MB4551.eurprd05.prod.outlook.com>
 <20250901182549.GD124814@bill-the-cat>
 <DB6PR05MB4551C8F51246AD5EEA64F4498300A@DB6PR05MB4551.eurprd05.prod.outlook.com>
 <20250905013256.GI124814@bill-the-cat>
 <DB6PR05MB4551C55FB367824AB9AF8FFB8303A@DB6PR05MB4551.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uTdvBoBpaXM27D5N"
Content-Disposition: inline
In-Reply-To: <DB6PR05MB4551C55FB367824AB9AF8FFB8303A@DB6PR05MB4551.eurprd05.prod.outlook.com>
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


--uTdvBoBpaXM27D5N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 05, 2025 at 10:06:10AM +0000, Maarten Brock wrote:
> From: Tom Rini
> > On Thu, Sep 04, 2025 at 01:19:26PM +0000, Maarten Brock wrote:
> > > From: Tom Rini
> > >
> > > > On Mon, Sep 01, 2025 at 04:06:10PM +0000, Maarten Brock wrote:
> > > >
> > > > > Even when CONFIG_NO_NET is selected there is still need for a
> > > > > definition of ft_board_setup(). Thus move the checks for
> > > > > CONFIG_DM_ETH and CONFIG_DRIVER_TI_CPSW inside the function.
> > > > >
> > > > > Signed-off-by: Maarten Brock <maarten.brock@sttls.nl>
> > > >
> > > > Shouldn't OF_BOARD_SETUP be disabled in that case?
> > > >
> > > > --
> > > > Tom
> > >
> > > Had there also been non-NET-related fixups in this ft_board_setup(),
> > > would that also have been your answer?
> > > I don't see why disabling NET drivers would have to impact anything e=
lse.
> >=20
> > Yes it would have been my answer. And because not all dependencies are
> > easily expressible in Kconfig.
>=20
> If this is your opinion then I propose to remove the checks for DM_ETH and
> DRIVER_TI_CPSW alltogether. They obviously serve no purpose as one is
> required to deselect OF_BOARD_SETUP when NO_NET is selected.
>=20
> -#if defined(CONFIG_OF_BOARD_SETUP) && defined(CONFIG_OF_CONTROL) && \
> -	defined(CONFIG_DM_ETH) && defined(CONFIG_DRIVER_TI_CPSW)
> +#if defined(CONFIG_OF_BOARD_SETUP) && defined(CONFIG_OF_CONTROL)
>=20
> I must hope that there will never be the need for other fixups for e.g.
> the RTC or the user is left with either choosing both RTC and NET or neit=
her.

Well, those checks (or similar ones) were first put in 13-14 years ago
maybe? So yes, some restructuring might well make sense at this point,
given what the codebase looks like now. We can deal with what the future
brings, in the future. Your logs in the other patch show that the kernel
has again changed its mind about where the MAC must come from as I would
have sworn that there was a window of time where no, the kernel wouldn't
read the fuses.

--=20
Tom

--uTdvBoBpaXM27D5N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaLtZjAAKCRAr4qD1Cr/k
CpluAQCmVr4LNuf/9Fn6hrO8at5prasrcIv29rlZnvlkJux3EQD/bhMXNvrZGQK+
c5AVY+TdVchuDnAUAPxuCTkt2XYwwQk=
=7Ebw
-----END PGP SIGNATURE-----

--uTdvBoBpaXM27D5N--
