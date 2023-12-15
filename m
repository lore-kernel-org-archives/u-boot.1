Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F5FC35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 13:17:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A25E8798E;
	Fri, 15 Dec 2023 14:17:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jT2624Xl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C43F87B85; Fri, 15 Dec 2023 14:17:41 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 268528755D
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 14:17:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-4258b8632f4so5022521cf.2
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 05:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702646258; x=1703251058; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=m4szXc+dNtL7r8a/YPLp13Cikf3nzFInvkFUk1At718=;
 b=jT2624XlnxaQKxkiJLekT6Af355q/8uPSmmTHUr9iHjizRlOnRxO8ZMXg8n/TgR5B1
 78E5uGMbiE5s2rqpPx68f0Q5uxxWz39J6ZPczjD7BnqO+w0yWVEZcSI5olQZqlOsPxWX
 9FknkvKyh9JTFJq4Bt5ydsWvH6SXsqm3rWTR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702646258; x=1703251058;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m4szXc+dNtL7r8a/YPLp13Cikf3nzFInvkFUk1At718=;
 b=pkCv7mArc/v9oyy+1zG8rWgG0Fyp7hB0dPHNjCrhzn6tSFK3EmFBJDVdR74u903Ce3
 bteqfvoEj2DS8hDhxLwu7BWl1UGrkxyeS4XsAGc4HqvQI6ivIZ0AmAT+ksZbZH5Uxh7x
 8gR8mlSEC6S4j0qwuTlLMzGjNoRSX00SH2zADHF2b2HVj0FBO37gTAieE8nHrLUBEIEM
 RnAePdR0ABkDhbxokS6EIpTGjDoUbdt7daoHCFxxw6pPs3X94rczSryh64vceoaWLy2m
 jL7ZCAd9JRH5BC4tUffo0uy5ufFz+qeOelE2CoovxhJDDv74CXbiq2QAWI7Sa6AdNS50
 qNeQ==
X-Gm-Message-State: AOJu0YyD5MI+tbp+qOUJUhp3MsSJi/bMrN0dLy5xWvkTFtkEqEH5eWqj
 +wFWAkRXQ3duq7qYkE4meQkwD7ng/Su6sztyhBM=
X-Google-Smtp-Source: AGHT+IGZ38WdGPMS5+QUdsfPMGWv3Ufy9atzDFJm7xAE0Yki/jdvfJ7+M9BAW+/Hv7saAnp1RX2Uow==
X-Received: by 2002:ac8:7dc6:0:b0:425:9f0f:d7fe with SMTP id
 c6-20020ac87dc6000000b004259f0fd7femr16078137qte.65.1702646257810; 
 Fri, 15 Dec 2023 05:17:37 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-faf3-908c-f76f-32dd.res6.spectrum.com.
 [2603:6081:7b00:6400:faf3:908c:f76f:32dd])
 by smtp.gmail.com with ESMTPSA id
 e7-20020ac845c7000000b00418122186ccsm6628929qto.12.2023.12.15.05.17.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 05:17:37 -0800 (PST)
Date: Fri, 15 Dec 2023 08:17:35 -0500
From: Tom Rini <trini@konsulko.com>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] arm: spl: Use separate fault handlers instead of a
 single common one
Message-ID: <20231215131735.GT2513409@bill-the-cat>
References: <20231214162931.34236-1-csokas.bence@prolan.hu>
 <20231214175348.GM2513409@bill-the-cat>
 <723ec7d9-218d-4ad2-ae02-ead55a10dafd@prolan.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1389jPki66Rj8fWN"
Content-Disposition: inline
In-Reply-To: <723ec7d9-218d-4ad2-ae02-ead55a10dafd@prolan.hu>
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


--1389jPki66Rj8fWN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 01:10:45PM +0100, Cs=F3k=E1s Bence wrote:
>=20
>=20
> 2023. 12. 14. 18:53 keltez=E9ssel, Tom Rini =EDrta:
> > On Thu, Dec 14, 2023 at 05:29:31PM +0100, Cs=F3k=E1s Bence wrote:
> >=20
> > > It may be necessary to set breakpoints etc. on a specific fault handl=
er in SPL.
> > > Add a Kconfig option to separate the different handlers into their ow=
n individual infinite loops.
> > >=20
> > > Signed-off-by: Cs=F3k=E1s Bence <csokas.bence@prolan.hu>
> > > ---
> > >   arch/arm/Kconfig       | 10 ++++++++++
> > >   arch/arm/lib/vectors.S | 18 ++++++++++++++++++
> > >   2 files changed, 28 insertions(+)
> > >=20
> > > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > > index 328e2ddc33..47494cb72b 100644
> > > --- a/arch/arm/Kconfig
> > > +++ b/arch/arm/Kconfig
> > > @@ -79,6 +79,16 @@ config SPL_SYS_NO_VECTOR_TABLE
> > >   	depends on SPL
> > >   	bool
> > > +config SPL_USE_SEPARATE_FAULT_HANDLERS
> > > +	bool "Use separate fault handlers instead of a single common one"
> > > +	depends on !SPL_SYS_NO_VECTOR_TABLE
> >=20
> > Will this dep catch that this is only valid for !ARM64 && !CPU_V7M ?
>=20
> Is it? How so?
> So should I put `depends on !SPL_SYS_NO_VECTOR_TABLE && !ARM64 && !CPU_V7=
M`
> instead?

Well, looking at arch/arm/lib/Makefile, vector.S is only used in the
case I said, so you would need to modify the other files as well.

--=20
Tom

--1389jPki66Rj8fWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV8UecACgkQFHw5/5Y0
tyyM+QwAjiyFOndcmqxHLn77Sk8vR79/hVY0Md4cHQWPijSXkGWqNcLdOlLVU8UI
4FCTA7XdGeHzQC+DqShmPOFUtSlRKzdykEn3TuC9P0rrBAuAMM8mpuQQr3EllJoh
xpVpiZ4KpYKXlVT7UyEkYrNb2RllA6QnkGrgrBYrMet7VcDid2zeTqgn7acM5JZz
h5GCZAGDbqzxmyh8mVK/jwvMTg7P+XiQr9vfV5V7TZse1ham0BWaDvrd+jYE8UOt
pquEHvo1UuK4MS9EGUVGBEUm+/TKf4+oJhNvtNbDy1Z3/bWycpeely3H2y/Nzs3g
Z3SP2nHVtyQ0e1aAUxXbT8i2oXQlKOVhFCQi4vRiOUh+gXkY4eP7USBGgx+GGv4V
KA6QWrEOysNV460vmTWF+Lg4ae6ryepBptwN0dM1J82qYla3AwdMJAMsC0TtHHCN
sybiXGwFTKr+1i41dgiRhIoXcUcuUSCrSTDGxmBO1tbjkwLoRHtQhG/7idm2y2Xr
uDYWlK9i
=CK5V
-----END PGP SIGNATURE-----

--1389jPki66Rj8fWN--
