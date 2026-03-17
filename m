Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F08AFED9E7
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 15:41:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 158B184383;
	Tue, 17 Mar 2026 16:41:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="d6HRC/rU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8DE784390; Tue, 17 Mar 2026 16:41:42 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A832D84366
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 16:41:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7d756f2a06dso787879a34.1
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 08:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773762099; x=1774366899; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BIm8zES9uYPcuNxddOWLFR6bbCXoVrBm241zQYhq9EM=;
 b=d6HRC/rU8iZygULEnwlzzmUq8xPyENtgcZwjkbcVnTmAXwltUN7ZnKrLiLrbARLSZ/
 lsx3iLDspF5yjCuT9O3xqu+33kqTf4szsTVnai2XnJFoHurAJX2HbEHO1r0yW0SdIHj1
 R9ZV+9LyF/+fJvhz6PxwHIadLBnY+YvFy4zso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773762099; x=1774366899;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BIm8zES9uYPcuNxddOWLFR6bbCXoVrBm241zQYhq9EM=;
 b=plmqMq5zzjjGAxfJN6XfeMU5slp2yEMmcDiEUOQbIspeQNUnnF/9/e5S5adv9ZUuH+
 p6jjlS2kLq1cJy94gtqcXE9EDFwMnxMO4rXu42wnu9OtPItjJ8Rtnk+IsnH1DHKdVNeZ
 zbN8byGT1p9iRhmEcef0sJFEZtpFilT+rpig2XpmLCBCdZEBQX7PCqrACeLot1+HTXuD
 NACfLkzuROz8mDyN5bo/gIzQ/B14cF7OHyWwOpNB3GKbs4cvzmBaCceI5/9M3N5r9C4O
 G8JOIOQ5nemZYnC0oREzp/gx8CBKR+hr7JtkxErHnPy2IUVE+if657vH7s97X+Y7WQ2d
 5o9w==
X-Gm-Message-State: AOJu0YyLJn2267IimlhqqgYFCMCWjHIJHz9Pvo06FnscyQV+vn6wpyJQ
 XIiEv3xtgt+syMyaLeThYieDyv8eriUJXvc8Hn/SgZG4L2JifR/Jqp5yHckRh7sDKEw4SF4+PES
 id49vE5Q=
X-Gm-Gg: ATEYQzxcBweArjEraRMhqk1CoAtyncjq3SFCabflQdYbj5Ef4XTO3jaGj0Zwe6IIomR
 tpBEL4R/P6MxDDZx5XOadXDTDvkEsmlg3s2C0GlkNXY3Zlp68CQ0czLYhXB4saUjfQd2oZJf4O/
 oefMv+v3l7YdPwfDRu//2VS9sMgxpnfwudZoq17r7O4LeMYyfcDPayD4/asFhqZNCX5rESS+GK/
 kAi8ALK48mbdU5giyzk8DLyn3WWd4bLhsU1aMhwrsE54vIiT0inphfys+sTYqFzZoJpigT4QhLo
 VxemGqVchdunluQgeEuBhDPJic8TB9rM71RZYMru7vJjxmwp5/gutm2H+VqzHFAXG/CqbN1hA1z
 emmVGme7ukK7bG1jMjn50qIfOPbaEIoTrlBeuYV9pHQIQnzfymB1Y3NLIpl82FIqU74MS4KCnQw
 M/AOjFQB3ZQRrJULmGj8tg6Jeb7Z6L4z2iRcocx0v6M1PyUYoeOkzuJxc12vQjAeitMa+7Ckj9B
 PbcDv//EQIZMCUO8HDqFtpDC07BaaQazwHFJXbbz035sfJ3M4lVUhEp1DI=
X-Received: by 2002:a05:6830:6acc:b0:7d7:43a3:bb58 with SMTP id
 46e09a7af769-7d7bb7e32b4mr2019493a34.13.1773762099297; 
 Tue, 17 Mar 2026 08:41:39 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae6a361sm14673916a34.20.2026.03.17.08.41.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 08:41:38 -0700 (PDT)
Date: Tue, 17 Mar 2026 09:41:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] microblaze: Rework TARGET_MICROBLAZE_GENERIC
 implementation
Message-ID: <20260317154136.GD502704@bill-the-cat>
References: <20260317012412.4162279-1-trini@konsulko.com>
 <92a3aa0d-4d2f-4845-9ac2-6bcb976bced8@amd.com>
 <20260317144955.GC502704@bill-the-cat>
 <0f352388-4e79-483a-a4ca-2f14f4bea6c8@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GHCFdaWFoiVxainm"
Content-Disposition: inline
In-Reply-To: <0f352388-4e79-483a-a4ca-2f14f4bea6c8@amd.com>
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


--GHCFdaWFoiVxainm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 04:35:30PM +0100, Michal Simek wrote:
>=20
>=20
> On 3/17/26 15:49, Tom Rini wrote:
> > On Tue, Mar 17, 2026 at 01:06:15PM +0100, Michal Simek wrote:
> > >=20
> > >=20
> > > On 3/17/26 02:24, Tom Rini wrote:
> > > > As exposed by "make randconfig", some symbols such as
> > > > XILINX_MICROBLAZE0_PVR can be set without TARGET_MICROBLAZE_GENERIC=
 but
> > > > have a transitive dependency on it. The easiest path of resolution =
here
> > > > is that since there is only one valid microblaze "board", rework th=
at
> > > > symbol to be non-optional.
> > > >=20
> > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > ---
> > > > Cc: Michal Simek <michal.simek@amd.com>
> > > > ---
> > > >    arch/microblaze/Kconfig | 10 +++-------
> > > >    1 file changed, 3 insertions(+), 7 deletions(-)
> > > >=20
> > > > diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
> > > > index 4261e5009fdc..16c55ddfd95c 100644
> > > > --- a/arch/microblaze/Kconfig
> > > > +++ b/arch/microblaze/Kconfig
> > > > @@ -7,12 +7,8 @@ config SYS_ARCH
> > > >    config STATIC_RELA
> > > >    	def_bool y
> > > > -choice
> > > > -	prompt "Target select"
> > > > -	optional
> > > > -
> > > >    config TARGET_MICROBLAZE_GENERIC
> > > > -	bool "Support microblaze-generic"
> > > > +	def_bool y
> > > >    	select BOARD_LATE_INIT
> > > >    	select DM
> > > >    	select DM_SERIAL
> > > > @@ -26,8 +22,8 @@ config TARGET_MICROBLAZE_GENERIC
> > > >    	select MTD
> > > >    	select SPI
> > > >    	imply CMD_DM
> > > > -
> > > > -endchoice
> > > > +	help
> > > > +	  Support microblaze-generic
> > > >    source "board/xilinx/Kconfig"
> > > >    source "board/xilinx/microblaze-generic/Kconfig"
> > >=20
> > > Applied.
> >=20
> > Please drop this for now, I need to do a v2 and I've found another
> > randconfig that gives me:
> > WARNING: unmet direct dependencies detected for XILINX_MICROBLAZE0_PVR
> >    Depends on [n]: MICROBLAZE [=3Dy] && TARGET_MICROBLAZE_GENERIC [=3Dn]
> >    Selected by [y]:
> >    - CPU_MICROBLAZE [=3Dy] && CPU [=3Dy] && MICROBLAZE [=3Dy]
> >=20
>=20
> I expect this is from cpuinfo driver.

Yes, it is. But it's one of the problems randconfig exposes since it
does funny things when generating a valid .config, and seeing what blows
up. What I have in progress now is removing TARGET_MICROBLAZE_GENERIC
entirely and using MICROBLAZE in the few tests.

--=20
Tom

--GHCFdaWFoiVxainm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCabl2LQAKCRAr4qD1Cr/k
CvadAP9xU74oe49GQAZ2SvwTEcLCH2Qtja/nuwcZoNlR/kC6gAD/ZWVVf3H7MtQD
pLoBVPpbkAoglxyh+BrW/hucbGjkZgg=
=Ir1A
-----END PGP SIGNATURE-----

--GHCFdaWFoiVxainm--
