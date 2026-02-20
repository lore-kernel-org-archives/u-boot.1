Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9DEC56204
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 14:35:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62C8083AC5;
	Fri, 20 Feb 2026 15:35:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="V4pT5Z/r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C11183D0F; Fri, 20 Feb 2026 15:35:24 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2FBA802C1
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 15:35:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-40423dbe98bso895413fac.2
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 06:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771598121; x=1772202921; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AxQJS5KVEEn+HQ72nqpn19v6E/3wuFJQ+LP9LknesLE=;
 b=V4pT5Z/r5s0EB1tHkEkhmffzMEgmS0tuqvcUrOLo1cPcqb0LRmVUSqjtmB5wyXqEgh
 hf0sO/IVWeYRKQPn4fmRxhRXFUNize184R5eTYY2vIAfqx6SHzD9Kxj5blYjCfPN8cTb
 LVBUWi1jqMLn4bmihbBfOnMy0yjnz8Mjiy4S4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771598121; x=1772202921;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AxQJS5KVEEn+HQ72nqpn19v6E/3wuFJQ+LP9LknesLE=;
 b=iMf6jAWhkg7/9z7nH0jVs1HPPn2QaABCVP2Z7E3UrVyR+1OxZ/OmC/LxL+legmwJYf
 rmsdXySfw64PsmV05Az8gijzpXA9YkmBrT00SYOdxkqmxz79pQV6SoXXefub+0l5zLWh
 vDg+EVsd79J8rReGfnIQ84Aef75Wrur5ty0n1Uj4U6XaYiV95aPZbRueOgr+Z04s1bb2
 xIPGhe4VXAvvgQ0O+M+CIO6iTe/6pm2AGPmN+kjaD8pgSAMcN5b9ZwzjZDEAT7F0i6YT
 Xk1w+ZHzzcAdgURJBmDf+YPNW2dA8ZLdgSlG83xaruyZ+E7iqMW6bhFq5fPUvWkEtAL6
 133g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVVe+94LpTA+b+vCc9B8QGSkk5HCqcrK7s0cGffsiuG1DfguDYf15yT7AaWQ/s7vcPj0ot7EU=@lists.denx.de
X-Gm-Message-State: AOJu0Ywrf7bFWz9/p11J2YjDeXvR1BPNx6TDw9bDxUTRde+NY/Pv0OB8
 Q8/dEQtGaWH7SaSwALPYUrQlQ/VWmOGH9l9kD7FdnYyrOepIRkSmQv/kVhFhm1pLt1U=
X-Gm-Gg: AZuq6aKRhhw8RD+FUcyXGBkMXIQar3mzwCercVe2muW9eRP0JuGMaFYtzLCbB0yagUQ
 rK7nmIaDGp69ttHTN4uF27dbHVPEptE2mqHOukVflDJcEsjmNr5F9vOSu9sHlR89pNzmzMvAzbC
 yBmHYwd53r2WoXXi8xZxgVyBVL9TvFEN+wj1PwhqhtNdIBnMbYafvBmNkRh8KSL2d8uUEL2NREf
 LuZVSR/uchMiILCo566oYU8Zm3UTZTzLjQK6lv/nye4Fx0gwirDYRIdcL2qX63TPTGRpp+hv5Es
 9Ml7HdCL09x15ymLuJYxXqD7cTV4TOVpdz7fg2OUlgsB4a91ndShh3Z9s/djbwSQXRAFT+WYk2Z
 oyLrMDHEC6F5MxKDWh05E6LLAFuFT4SyDp2fb4S6Za5mftSz4/A1tb9k2LtGz8tO5H/5IyYB5F1
 cMljs/Z/eNs0F/cEkWs0XUtt5+1lRXOWf8nFwDGZqnfQJEdw7fWbsYprE/YAtgqKRuR5LDN3CT7
 +hm65P+dhgy+S4aHWto+JOfH5OI0DvFOmPTEiv1uBeY2lqyMuiiI9Jj/stbSw==
X-Received: by 2002:a05:6870:912c:b0:409:7d3a:bfdd with SMTP id
 586e51a60fabf-40f0d577329mr13669245fac.4.1771598120578; 
 Fri, 20 Feb 2026 06:35:20 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40ee06756easm24409635fac.13.2026.02.20.06.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 06:35:19 -0800 (PST)
Date: Fri, 20 Feb 2026 08:35:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Sean Anderson <seanga2@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>, michael@amarulasolutions.com,
 u-boot@lists.denx.de, dinesh.maniyam@altera.com, a-dutta@ti.com,
 a-nandan@ti.com, jonas@kwiboo.se, Fabio Estevam <festevam@nabladev.com>
Subject: Re: [PATCH v2] spl: Add generic SPL MTD loader support
Message-ID: <20260220143516.GQ3233182@bill-the-cat>
References: <20260220031232.1254728-1-festevam@gmail.com>
 <fecf9c20-f5a5-d9f6-ddc0-dc8db483922d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2ClOAJQkzRZ+BLcV"
Content-Disposition: inline
In-Reply-To: <fecf9c20-f5a5-d9f6-ddc0-dc8db483922d@gmail.com>
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


--2ClOAJQkzRZ+BLcV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 10:52:20PM -0500, Sean Anderson wrote:
> On 2/19/26 22:12, Fabio Estevam wrote:
> > From: Fabio Estevam <festevam@nabladev.com>
> >=20
> > Add support for loading the next stage from an MTD device in SPL.
> >=20
> > Introduce CONFIG_SPL_MTD_LOAD and a generic SPL MTD loader
> > implementation that uses the MTD subsystem to read the U-Boot payload.
> >=20
> > The loader works with any MTD-backed storage, including raw NAND and
> > SPI NAND, without being tied to a specific NAND type.
> >=20
> > The payload offset defaults to CONFIG_SYS_MTD_U_BOOT_OFFS and can be
> > overridden via the device tree property:
> >=20
> >      u-boot,spl-payload-offset
> >=20
> > To support both raw NAND and SPI NAND boot flows, the loader is
> > registered for BOOT_DEVICE_NAND and BOOT_DEVICE_SPI. This allows it
> > to operate correctly on platforms where the ROM reports either NAND
> > or SPI as the boot source while using the same MTD-based loading
> > infrastructure.
> >=20
> > The required NAND core and SPI NAND drivers are built for SPL when
> > CONFIG_SPL_MTD_LOAD is enabled.
> >=20
> > This provides reusable infrastructure for boards that boot from MTD
> > devices without relying on SPI-specific or NAND-specific SPL loaders.
> >=20
> > Signed-off-by: Fabio Estevam <festevam@nabladev.com>
[snip]
> > diff --git a/common/spl/Makefile b/common/spl/Makefile
> > index 4c9482bd3096..67fc1cd1b396 100644
> > --- a/common/spl/Makefile
> > +++ b/common/spl/Makefile
> > @@ -35,6 +35,7 @@ obj-$(CONFIG_$(PHASE_)NVME) +=3D spl_nvme.o
> >   obj-$(CONFIG_$(PHASE_)SEMIHOSTING) +=3D spl_semihosting.o
> >   obj-$(CONFIG_$(PHASE_)DFU) +=3D spl_dfu.o
> >   obj-$(CONFIG_$(PHASE_)SPI_LOAD) +=3D spl_spi.o
> > +obj-$(CONFIG_SPL_MTD_LOAD) +=3D spl_mtd.o
>=20
> Does this need a $(PHASE_)? (I don't know, but the others have it)

For consistency yes, even if we're unlikely to need this in TPL too.

--=20
Tom

--2ClOAJQkzRZ+BLcV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZhxIQAKCRAr4qD1Cr/k
Cl1wAQDGjgrTj9jA5m69BJu4PA2yOu2qBQlMyuPIOpRAaeBxCAEAsuV5qPH4FoG5
SywTD3Ri/Zb0gy3l4kAHwiSgcR2Axw0=
=cfu9
-----END PGP SIGNATURE-----

--2ClOAJQkzRZ+BLcV--
