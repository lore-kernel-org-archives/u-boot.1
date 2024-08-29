Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B25C83F2D
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 15:17:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B430188C4D;
	Thu, 29 Aug 2024 17:17:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RnJyBHua";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F87588C4C; Thu, 29 Aug 2024 17:17:43 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BC5288C40
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 17:17:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7a1df0a93eeso46573285a.1
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 08:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724944659; x=1725549459; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=amP9lu9Z9tNcqkqPEaM5ICUHrjXm3OGaRsV8WX2dIjo=;
 b=RnJyBHua1MSJL6MBLW9eU6nTVjADM+nVuTGZ9304u8tSdOMAAdy0dlxBPTcqaSLOEh
 RdpesM5bUtVF5BOiEszdA1vvUi6bsIP81kPL/aDcgDANKTEasG6vqLibbRBmKOTox8/v
 Lz9QjL96gMP1zzGPFhTuOr9GG6yVI+8WP769w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724944659; x=1725549459;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=amP9lu9Z9tNcqkqPEaM5ICUHrjXm3OGaRsV8WX2dIjo=;
 b=Eaaeh9gVALHR0r2c0g9LsbpEr21pOcY3jRqEvu+hIYSjVXwHLjtzH60TiFtg9TEaGR
 YIxv0aYKvIaTvTwAAp+ubRpaOlmg/8+Ouc8xdxBjMkybcVVKVklF0nt1NS72hAAN8eGz
 wIUQGndiaYBW+l9icyqWtey8BA3pAKiaGTaVD+8cRFQsCgHyTu7t5nL739dS+gRvO5ZY
 A8QbDuEaYQFIUPNCDJPaSRmRJRyEQdUsMIFu6VTg/sS6uZbssL9R6wkLYzIFl+4d4IDO
 ZfjeGK6YyZi3r/m0dLSQcBm5oolvmJcupCKDkcnylhzJDqxc0HUwQCB6vrPmJIy/01ZO
 oegA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZm+59fKRAPzGSR0Q2MxTZI4RGrYh3xWQWVjseRLQEZOQyJeEmoI+X8C8maiQiS7ppVxM8DSY=@lists.denx.de
X-Gm-Message-State: AOJu0YyhD0GFq0V+wQSIHDMszp1FwUzR7reDrmlycIAIDd6+BDM+Jao+
 06eefgtZ/EpbmI7DsnMlOXELOmSrNgOw0NeIdD5ATRInXEVlZie+jESDIiDc6pw=
X-Google-Smtp-Source: AGHT+IFWW27FY7FoVSf4RWaTj0/aPpYp/yLZfyYxoS2XPTIXV4eOTXAP6aiIorV9xX4p9xlQGPe7KA==
X-Received: by 2002:a05:620a:404a:b0:7a2:c96:8638 with SMTP id
 af79cd13be357-7a80426696bmr385806985a.58.1724944658139; 
 Thu, 29 Aug 2024 08:17:38 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a806d390c4sm59262685a.95.2024.08.29.08.17.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 08:17:37 -0700 (PDT)
Date: Thu, 29 Aug 2024 09:17:34 -0600
From: Tom Rini <trini@konsulko.com>
To: "Gaskell, Oliver" <Oliver.Gaskell@analog.com>
Cc: Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 "Bimpikas, Vasileios" <Vasileios.Bimpikas@analog.com>,
 "Agarwal, Utsav" <Utsav.Agarwal@analog.com>,
 "Artamonovs, Arturs" <Arturs.Artamonovs@analog.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Linux Factory <adsp-linux@analog.com>, Trevor Woerner <twoerner@gmail.com>
Subject: Re: [PATCH 00/20] arm: Initial support for Analog Devices SC5xx boards
Message-ID: <20240829151649.GD2479150@bill-the-cat>
References: <20240828-sc5xx-upstreaming-patches-v1-0-44d9adfdf327@analog.com>
 <20240829145143.GA2479150@bill-the-cat>
 <SN7PR03MB72754C566D3532701567AC38E1962@SN7PR03MB7275.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8XokGJzzoCgnqCT3"
Content-Disposition: inline
In-Reply-To: <SN7PR03MB72754C566D3532701567AC38E1962@SN7PR03MB7275.namprd03.prod.outlook.com>
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


--8XokGJzzoCgnqCT3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 03:06:31PM +0000, Gaskell, Oliver wrote:
>=20
>=20
> > -----Original Message-----
> > From: Tom Rini <trini@konsulko.com>
> > Sent: Thursday, August 29, 2024 3:52 PM
> > To: Gaskell, Oliver <Oliver.Gaskell@analog.com>
> > Cc: Nathan Barrett-Morrison <nathan.morrison@timesys.com>; Greg Malysa
> > <greg.malysa@timesys.com>; Ian Roberts <ian.roberts@timesys.com>;
> > Bimpikas, Vasileios <Vasileios.Bimpikas@analog.com>; Agarwal, Utsav
> > <Utsav.Agarwal@analog.com>; Artamonovs, Arturs
> > <Arturs.Artamonovs@analog.com>; Rayagonda Kokatanur
> > <rayagonda.kokatanur@broadcom.com>; u-boot@lists.denx.de; Linux Factory
> > <adsp-linux@analog.com>; Trevor Woerner <twoerner@gmail.com>
> > Subject: Re: [PATCH 00/20] arm: Initial support for Analog Devices SC5xx
> > boards
> >=20
> > [External]
> >=20
> > On Wed, Aug 28, 2024 at 11:02:08AM +0100, Oliver Gaskell via B4 Relay
> > wrote:
> > > ADSP-SC5xx is a series of ARM-based DSPs.
> > > This comprises the armv7 based SC57x, SC58x and SC594 series, and the
> > > armv8 based SC598.
> > >
> > > This patch series includes configurations, init code, and minimal DTs
> > > to enable Analog Devices' evaluation boards for these SoCs to boot
> > > through SPL and into U-Boot Proper, as well as devicetree schemas for
> > > the added DTs.
> > >
> > > This patch series depends on ("arm: Add Analog Devices SC5xx Machine
> > > Type") (https://lists.denx.de/pipermail/u-boot/2024-April/552043.html)
> >=20
> > Since that series has been merged since early May, what is this series
> > based on top of? It should be based on top of current (or close enough
> > to not matter) -next. Also, has everything been passed through
> > checkpatch.pl and the results looked at? Thanks.
>=20
> I made it on top of -rc1, just tested and I think it applies cleanly
> to -rc3 and next. Wasn't sure on the policy re. patch series dependencies
> so just wanted to be 100% sure that was clear.=20
>=20
> It has been run through checkpatch, there's a few warnings that I think
> are OK. Only warning I missed is about the Co-developed-by tags not
> having matching Signed-off-by tags - if this is an issue I can make a v2
> that fixes this.

OK, thanks for elaborating. I forget, what is the plan to upstream these
dts files?

--=20
Tom

--8XokGJzzoCgnqCT3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbQkQ4ACgkQFHw5/5Y0
tyzj1wv+PeTbuOuGykTnf4gysO2sGoWZJk8DJM63VyCTJH/fesiXUtfKrZobqR+0
aOS43MlIynOaOsztCuPVvRNpetn4WpCARhaMYMIgyiPmDx2072WLwW8PExKvF9qB
YOE01UsgIeftTcRz2QGy84eAaNMUQlZxHr67KKOK8EYWiTpEz28i2YvQwBTF+stl
yapiaCe+0urxiTNpG61cPrzz1BhwPin0+bXdUMjRc6y+jbrFiZbJmFCg4UIpTKpr
l4e8WcrksaPdHt1z3NhgeNo11ApUQlL5wuB0sExFU4RmMu0m86/OUOCAO63srH0+
pAOoFqvly0jbU0U9shDU+8qfpSOvWUHWjLPKVgjY8OJDqn4YyhxFOyMWAxJil5jV
VR/MuaDOeqx73H5WXbyDUSbWdRHMkK3s/z3e+XvHdoOD7x1jjwEEP2+5T5Ec0Hf6
79ESGODO5RS5u3vV778rdt7DkFLPAerfNBeKgf408q9X2HVQqzJLJvLi6Jmi20rX
jvzFEvv5
=jvLo
-----END PGP SIGNATURE-----

--8XokGJzzoCgnqCT3--
