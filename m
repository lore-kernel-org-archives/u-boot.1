Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA51C71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 13:57:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DD5E80E9A;
	Wed, 18 Jun 2025 15:57:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nIH4o5IV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A26C82D06; Wed, 18 Jun 2025 15:57:35 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CAE68006D
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 15:57:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-400fa6eafa9so4801718b6e.1
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 06:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750255052; x=1750859852; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tNmfGFAxAaTkLaZoG/6pJZj7ZvNEdX3wUBzbj+49oX8=;
 b=nIH4o5IVIsk/PazORxabzR9E9xi2oRum4TahQQEKWJ06BdFoA9y/Re3Oxy3pM3hgoW
 EUIt+CI/mqX3wKgjXxBKlAoxBSlpUh76TEQEpagV9MHwhhHbf8K/jnJCgSAGo+vy0VBQ
 VAe+saDWnZEhLYLk9VMGg/PRwKbHjgxn7KiH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750255052; x=1750859852;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tNmfGFAxAaTkLaZoG/6pJZj7ZvNEdX3wUBzbj+49oX8=;
 b=l3cC6sTVRwKGs7AanmSbZyYyM3uRObbYcFStnd02q0dQ/NZfyZ/h9zP94HwC5BLBfG
 2Y3ofvh2vEPBBwgcdHhILyKderRI2rhrgcvJsyhzaDxGgL+3ZOJTAq4n68lhlJnfSZPE
 V8Wrg+1M0mjsYXcH5wO9gSBm5y+7Wlir5v9Pc+kCPJ5b1TrYkGtNyrbuI9FjBG4mIMMU
 5hWER5lV3wKDllDvNtI+9GMLNa1GmfYM/Byl37qhFP+acYlhgK5CVRBpEXYVdr9JFQ2V
 0rtkeS9drAGukmp98nNen2LOJ1swpKhs/80V4j5o/iWXiLPZOnVyWnuvDuHlNjiDe9fu
 qjYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxMvoP1IX7aO/6Qm9QRo+zwqkqUSIBUWtqzRd0XfFq40YuezIaaY3Ee586enddkTIt+OLpU6E=@lists.denx.de
X-Gm-Message-State: AOJu0YwH3GZJGzG4QAXpmtQR7T2CHwOCvhSo71LjXVMjaYPvudSmwf+M
 VcK8qYLd0UnaZwAI+b0ZmAAn45CP9a0EC7p0Oo7LlwPNgEpDfehQ3IEyQ2MjtQJ4K+0=
X-Gm-Gg: ASbGncunL4zdNSgVkDMhbHcOzWgREoSaz59/pE7ByWYqrwpxpE30NQraQWZTrk0rC70
 IRkpovAgyXksOBmjunW1ibwvn+IiNXcc+sHMCwrJIaewjf8hLEFrVbBJK+5OxeozJjBAb7mAums
 +FyxgbV0NcOCWvbNCi16/8ufe43CQmTY/9joTDxSmGbD2G54a3VRUiOx7redqjW7FAUTdewLMoC
 G972EW+CHmlHS8nWtj5HNGdJMbli/vpIc50bdaODmh0KePe8cHljteBB30XzmRixsXrF80Upawf
 QcSVo3mAoNeoBkWwQVUDqPa4dFnT5PvE+xEa4Jx7RVMuiHuHfL/fdfUVnYGrCQN58kj3iDMBWo1
 MgSmHHYGRgOsyAU8MY0gT1+8=
X-Google-Smtp-Source: AGHT+IEYc8TWOMXcPj20y82AXp4AwFD5uYD0nMzJMRtpleN1mxYOk9UUAp5J5xqCgPthGw0gKFzMXg==
X-Received: by 2002:a05:6808:1383:b0:404:12e9:c0e4 with SMTP id
 5614622812f47-40a7c1d0011mr10555779b6e.14.1750255051677; 
 Wed, 18 Jun 2025 06:57:31 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40a7418a2d5sm2377687b6e.37.2025.06.18.06.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 06:57:31 -0700 (PDT)
Date: Wed, 18 Jun 2025 07:57:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: vtpieter@gmail.com, Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] Improve user feedback in case of FPGA bitstream load
 failure
Message-ID: <20250618135728.GA6521@bill-the-cat>
References: <20250617092333.335908-1-vtpieter@gmail.com>
 <eb9be150-5298-4929-94e2-ace2f095eb84@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RSXT5pUxSrWbrOVK"
Content-Disposition: inline
In-Reply-To: <eb9be150-5298-4929-94e2-ace2f095eb84@amd.com>
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


--RSXT5pUxSrWbrOVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 09:15:54AM +0200, Michal Simek wrote:
>=20
>=20
> On 6/17/25 11:23, vtpieter@gmail.com wrote:
> > From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> >=20
> > In fpga.c, change debug() calls to puts() for important user
> > feedback. In zynqpl.c, change 'up to' to 'above' which corrects this
> > confusing or wrong statement.
> >=20
> > Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> > ---
> >   cmd/fpga.c            | 20 ++++++++++----------
> >   drivers/fpga/zynqpl.c |  2 +-
> >   2 files changed, 11 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/cmd/fpga.c b/cmd/fpga.c
> > index 9dc7b63db5d..2c2a63524de 100644
> > --- a/cmd/fpga.c
> > +++ b/cmd/fpga.c
> > @@ -43,7 +43,7 @@ static int do_fpga_check_params(long *dev, long *fpga=
_data, size_t *data_size,
> >   	debug("%s %d, %d\n", __func__, argc, cmdtp->maxargs);
> >   	if (argc !=3D cmdtp->maxargs) {
> > -		debug("fpga: incorrect parameters passed\n");
> > +		puts("fpga: incorrect parameters passed\n");
>=20
> I think all of these should be moved to log_err that you should be able to
> control verbosity.
>=20
> Tom: I think this is where you want to go right?

Sounds right, thanks.

--=20
Tom

--RSXT5pUxSrWbrOVK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhSxcUACgkQFHw5/5Y0
tyznYgv/dXuLGsl4GefKe/WvukBN3mbVNmHseeYt0cCZinzP7rMteDJ+Fw6xV1AJ
GN14mjp+56h1Q5NCUy7f442xIH8fcoG6d7jEs1DvILhMwtRMdMb7zlqgV/zIbWU8
3CY8aVMc+tL2GXCsAxw4NghQzL+4xnqr1nKK5W73FgFFv5azpJWm58uRRzgLMzbR
tpO/4wzvqt+9KPctXovkMqbCsJcWQ/BaaDhcWjgShwQb9jYedSKiXX2mu8hoFz2L
gKsuKFSCu/AFb/1SeZ9B2p/zJc0uJYKIdKSIioFCzipf37ii4layTDXkhLOiAl9G
f5vYmt75kq0ckpJnoMWBk46WdGD0yxeUJL0PwtnJTdmBT2PqJOHgjdrTG7VnLxxD
zKmhN2Z72OO+2AmTYH0DSQ4QgmI97kvt/J7IeM789p+33P6fBYFWV4RbgtsDVi+Z
e/P88w1x0kCAICt+vFICXtf+7I+cO42BEKt2hWc95XvGekaL6IS7nmayVEtiwRIU
XlTHHZVs
=a7S/
-----END PGP SIGNATURE-----

--RSXT5pUxSrWbrOVK--
