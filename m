Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C1AC5ACC1
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 16:33:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55E4F83A5E;
	Fri, 20 Feb 2026 17:33:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uCX63nAR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AC6B83AC5; Fri, 20 Feb 2026 17:33:30 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6861383A41
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 17:33:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-45f10d7eb81so807753b6e.3
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 08:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771605206; x=1772210006; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=skOes36aeSr/pGxUKdJiLsYagd6364iloxoC6zuRcWg=;
 b=uCX63nARM7XwkySjIG88VCA59mwpy/bGVJVHqgeyUvOdn1QbaqNbBin5MABvJhIRku
 8inb2IL9RWm2OAWHQP24SY8MSrUzaRMn16kVgdIlnoD0MZZIp47NrgSysdAUMbbrpGOb
 sjDMpTEWcAvjVMBdGysI+ZGKlu4RohehPxBmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771605206; x=1772210006;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=skOes36aeSr/pGxUKdJiLsYagd6364iloxoC6zuRcWg=;
 b=J/6CDDWIB1Vnr6iKxlRDm7/gJu89s3VnDf5hVwyKFq5C7P6lvV0tQn40XK092h22yB
 UuQQsLV3KC4F4m70GsrFaafcy2IK4cD2ieDIkzJmBN234/f2A3mN52BVL6Hv/9blznyC
 /tDKJghIeEfczQ0aP9YL74DM2SMTk7Ku9KpI829BkCRDH1vw7JpjwEp4qp3R5xguveBd
 3HnO+ClCm0VXr9sc881rMDiZBwIFw0beeDYh0x41bpqUnJLxYBh9TfCyczr2T2JoWGUQ
 fzIn7jerCUF2oJwk7e/xYFMcBzEUVasGlUVejlQ5/VU4aOj4mvYQXRaxds2VE25pxIq+
 Uivw==
X-Gm-Message-State: AOJu0YxcMAZKuTHVyF6WNy9yhpXQefxMD22IDy6vwZPEJnGRf23sPP3V
 P5fPdQ2LVEju6roY4zNth1Aktpc9HmwYxrXKef9GEo5UGhR/PCDesSH/WOXfcsH1XfM=
X-Gm-Gg: AZuq6aK+M/r1nCsU4cmtyXvJqeS1/15IjAsqiCI/oYH2hEtAxfGXTTmnmcFb77Op1ae
 5g3y0mTKUrZhl+WzzgZPuZ9VB4t3poafCYRZlmoZS+psycZI3DQqbiZNc/X0gwMveG08zeAN0we
 Z9NRqIMWZ3coC4dhLZWzXb58eDD0ZowCYzBIqYFoOswvLP08D9nGRJgi5pnFISj5kWFmgFjdxb7
 s78SjAzV32pRp+sxQo+QZB+GrsU+W2Pa7ozbiSQWA9ZdJov+GQn3udiC3t9kWIKkBTCKiarYNgz
 /mJdc6kxZTpKJJdbxtVTMElKRgIq8hava3aOxM7pAXODvvHkEoFtgE1DQkU4BnGHaBwHnXE/RSj
 mf7YaWSJEg1qBJuf7lwcL6+ajEV632oj5lu0xFwyu9/+mZdJ8QmhNG48M9kfUSL4Gp4OrFslmEP
 XF1QhHyl5aQkHWrdYdJuMLE18/DG4GNqqvnsO3oo2wXF+6u/pRP/TngTHBt0BuLH+BE45bUY5jH
 Ee8KAlR+NYwT1KD46qiG1DMnZ23RtIe0ywzhT/MEp/v0MsX9kQ=
X-Received: by 2002:a05:6808:1a03:b0:44f:e954:ba44 with SMTP id
 5614622812f47-4644627d82emr272570b6e.28.1771605206067; 
 Fri, 20 Feb 2026 08:33:26 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4636b0cf66dsm18683310b6e.19.2026.02.20.08.33.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 08:33:25 -0800 (PST)
Date: Fri, 20 Feb 2026 10:33:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Jeffrey Yu <jeyu@issi.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "Mutya, Havish" <havish.mutya@amd.com>, "Kumar, Love" <love.kumar@amd.com>,
 Ron Kalakuntla <rkalakun@issi.com>, Ji-Ho Kim <jhkim@issi.com>,
 Johnny Chien <jchien@issi.com>, Anand Bagchi <abagchi@issi.com>
Subject: Re: [PATCH] spi: add support for ISSI flash uboot 2025
Message-ID: <20260220163322.GA86794@bill-the-cat>
References: <PH7PR19MB73617F02C51FF5AFFA7AC0C3B6A7A@PH7PR19MB7361.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="//SEQxtm6aiZ8VUH"
Content-Disposition: inline
In-Reply-To: <PH7PR19MB73617F02C51FF5AFFA7AC0C3B6A7A@PH7PR19MB7361.namprd19.prod.outlook.com>
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


--//SEQxtm6aiZ8VUH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 05, 2025 at 03:21:05AM +0000, Jeffrey Yu wrote:

> Signed-off-by: jeffrey yu <jeyu@issi.com>
> ---
>  drivers/mtd/spi/spi-nor-ids.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
> index b4221a82e01..c6d65196ebc 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -222,6 +222,8 @@ const struct flash_info spi_nor_ids[] =3D {
>  			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_HAS_TB) },
>  	{ INFO("is25lp512",  0x9d601a, 0, 64 * 1024, 1024,
>  			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_TB) },
> +	{ INFO("is25lp512mj", 0x9d6020, 0, 64 * 1024, 1024,
> +			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>  	{ INFO("is25lp01g",  0x9d601b, 0, 64 * 1024, 2048,
>  			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_TB) },
>  	{ INFO("is25lp02g",  0x9d6022, 0, 64 * 1024, 4096,
> @@ -239,6 +241,8 @@ const struct flash_info spi_nor_ids[] =3D {
>  			SPI_NOR_4B_OPCODES) },
>  	{ INFO("is25wp512",  0x9d701a, 0, 64 * 1024, 1024,
>  			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> +	{ INFO("is25wp512mj", 0x9d7020, 0, 64 * 1024, 1024,
> +			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>  	{ INFO("is25wp01g",  0x9d701b, 0, 64 * 1024, 2048,
>  			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>  	{ INFO("is25wx256",  0x9d5b19, 0, 128 * 1024, 256,
> @@ -249,6 +253,22 @@ const struct flash_info spi_nor_ids[] =3D {
>  			SPI_NOR_OCTAL_DTR_READ | SPI_NOR_OCTAL_DTR_PP) },
>  	{ INFO("is25lp01gg",  0x9d6021, 0, 64 * 1024, 2048,
>  			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_TB) },
> +	{ INFO("is25lp010e",  0x9d4011, 0, 64 * 1024, 2,
> +           SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> +	{ INFO("is25lp020e",  0x9d4012, 0, 64 * 1024, 4,
> +           SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> +	{ INFO("is25lp040e",  0x9d4013, 0, 64 * 1024, 8,
> +           SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> +	{ INFO("is25lp01gj",  0x9d6021, 0, 64 * 1024, 2048,
> +			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_TB) },
> +	{ INFO("is25lp02gg",  0x9d6022, 0, 64 * 1024, 4096,
> +			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_TB) },
> +	{ INFO("is25lp02gj",  0x9d6022, 0, 64 * 1024, 4096,
> +			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_TB) },
> +	{ INFO("is25wp01gg",  0x9d7021, 0, 64 * 1024, 2048,
> +			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_TB) },
> +	{ INFO("is25wp01gj",  0x9d7021, 0, 64 * 1024, 2048,
> +			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_TB) },
> +	{ INFO("is25wj128f",  0x9d7118, 0, 64 * 1024, 256,
> +			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_TB) },
> +	{ INFO("is25wp02gg",  0x9d7022, 0, 64 * 1024, 4096,
> +			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_TB) },
> +	{ INFO("is25wp02gj",  0x9d7022, 0, 64 * 1024, 4096,
> +			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_TB) },
>  #endif
>  #ifdef CONFIG_SPI_FLASH_MACRONIX	/* MACRONIX */
>  	/* Macronix */

In that this introduces no new problems with how we handle these types
of flash today, this is OK. However, the commit subject needs to be
clarified and then an actual commit message needs to be provided,
perhaps with some links to datasheets or similar. Thanks.

--=20
Tom

--//SEQxtm6aiZ8VUH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZiMzwAKCRAr4qD1Cr/k
CmacAQD8nO2ejKZQHE1YpjKDuzXrYlCry3t71W8Gf7e3I1xE2AD8CnLqZsMh5SdJ
HBBWd+dsDiNGQrh8Or6hpnW8zacXWAc=
=4REf
-----END PGP SIGNATURE-----

--//SEQxtm6aiZ8VUH--
