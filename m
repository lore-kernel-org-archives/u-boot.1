Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 692EAC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 23:06:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C818C8791A;
	Thu, 14 Dec 2023 00:06:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oGS4YRiK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74CDC87916; Thu, 14 Dec 2023 00:06:15 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CBF187900
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 00:06:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3b9e6262fccso4650291b6e.3
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 15:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702508771; x=1703113571; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4VJukG8BwLirUSKMl+l5z1UAVGHeHN3r+qjzQlKvr+I=;
 b=oGS4YRiKykgGspwqWYiJd0NDPxY4ftPEBrzByZMpsdhkBCg8qIuk5wjM12tlWtgPKb
 jCBERNoLc0qErGHnqNsSI3jRI3vPC68Nq9Gkg8iLdWHkX/voBRFOH6FD4+GHVvhtf50y
 CLHwNN20cOysnTPW+NbyP+pc49hUWnynM5eLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702508771; x=1703113571;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4VJukG8BwLirUSKMl+l5z1UAVGHeHN3r+qjzQlKvr+I=;
 b=PhKHRznMcAKHGn+i+0ZiVdT75LQPtArYH2pKl30Rbb6Ea3OmJmPaqBTqq0q+AcoGb5
 qBaHUAxPTTVFPTGTfTUbSxjK7A0sSqyp19s65YZIMlZL2GsMiBGwHd21s5k5ySZbidBM
 2Xn2UTdnE588eLo6/lJJjhckMZI8zL9V7KW7rArlF2a9WVOmSVNI5tYd7saX3VVNHHsu
 Bhrmn+IWwE+3dWq6sOkifLZkbRrlY19+vVQjbELMhnBQc+UA57AhEDjCc0NPN5ikSqme
 NlycNxvk3lcDYNt1EVn5/r+KrNox7hZoiRtGGiTl8dkeotbuMsXmIoGnWh7KnNCBO0ZN
 PiSQ==
X-Gm-Message-State: AOJu0YyWKX71NYNV2E6WDdzjv/iBwo22GT0uqHRkRsDjLrraXyJJ/ISY
 ugOwZKjU559bzetkUVMTgA0J2eACKHL8G0tncp8=
X-Google-Smtp-Source: AGHT+IGjWJMsYvLDyQOsVH97PgR3jfaNsKpb/xXMOTfoTq66JfMXDrY2PHiyeaYns4AYCfyBcXxHHQ==
X-Received: by 2002:a05:6870:b623:b0:203:2b02:7251 with SMTP id
 cm35-20020a056870b62300b002032b027251mr1431730oab.2.1702508770940; 
 Wed, 13 Dec 2023 15:06:10 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 p13-20020a259e8d000000b00da082362238sm4311575ybq.0.2023.12.13.15.06.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Dec 2023 15:06:10 -0800 (PST)
Date: Wed, 13 Dec 2023 18:06:08 -0500
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: Re: [PATCH] maintainers: bcmns3: remove maintainer
Message-ID: <20231213230608.GR2513409@bill-the-cat>
References: <20231205091229.183512-1-pbrobinson@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rpAKjgagsyWCCxjJ"
Content-Disposition: inline
In-Reply-To: <20231205091229.183512-1-pbrobinson@gmail.com>
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


--rpAKjgagsyWCCxjJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2023 at 09:12:22AM +0000, Peter Robinson wrote:

> Remove Bharat Gooty as a maintainer as his mail is
> bouncing.
>=20
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

Applied to u-boot/master, thanks!

--=20
Tom

--rpAKjgagsyWCCxjJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV6OOAACgkQFHw5/5Y0
tyzdLgwAs/oVF27zTrvN42E9BNk+R7ZK0FhK3Vp5u2uNunDATpSw522DL5AcHDCy
7YC4HnjtwlfF58a2VZlESBtQg2SHyTSyvf/B455OTmsRr1Dh34q3UHYrgxRKSBAo
i/vHfOTcSWPSSvKdkid/fdQUOrykcw8jHS2ZOPXMLod9vTdpT6n5vHbMPu2gPYsS
hARRLPNr/Pf0hvTtjStVb74DS5envionGOX+SfZeeYZU4RfaXyRMiQAIj0Grd/0d
R0N65rWGb9FiVSHawLmfLHgI70pBDpD6FlDXpk88dy6v6qvqte+i+cHNd8AlcOK5
xpTimuqYXOQl4Gcd5sKcLd+OnWWjS0hv17GS7dNuNuTxhA4NKBVNwiRgqdcFJcox
w5vKBoVCNxp3dVn49AgFY5TLolnp/izb7vK8wdUhadTT5681/E0LavuxyCuM/eJt
rDWbsUNOw02S5ZKug93BcvJndGq1zNH5vh6tFQ2tepoSnoTm1xB42Kz7b2hdSv0S
WtQYqdQD
=tBUQ
-----END PGP SIGNATURE-----

--rpAKjgagsyWCCxjJ--
