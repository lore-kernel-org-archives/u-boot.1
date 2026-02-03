Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7082E8783D
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 14:57:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C36D842ED;
	Tue,  3 Feb 2026 15:57:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k1MfiJy/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1119844C0; Tue,  3 Feb 2026 15:57:48 +0100 (CET)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78C8A842E1
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 15:57:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-66103641d76so1514037eaf.1
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 06:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770130665; x=1770735465; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9qdMfBX46RNUAhBx+dyx7zyHpY+axqQC7ZvVeuBDoqc=;
 b=k1MfiJy/vKytGXFAThV5Y/xMJhW06pxV14+vH+72aFV71Ia5AFKwLTc4Q4JHatPGWg
 6i2MTG11orR0bNhB+vJ9s9uA1ZKtQZjtwnkOR2BH//xkHZ4qLPr84pMA0n836BTfFn9w
 CI9QkGQy2eAA7mnTAK6ReTIxmq/pr65nZVAPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770130665; x=1770735465;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9qdMfBX46RNUAhBx+dyx7zyHpY+axqQC7ZvVeuBDoqc=;
 b=YmfdDsAwQm2gMTEUaDKj/yLaAr3NbqCdrk/KaGAdHhRnBJPIIIDk9c8mNHCQWcdlBi
 I/16iaUjlyba8e0QCQcW6SzgCAY8eCjqLsHplok34anAp41kOMuf0D7jyrlQBfXIROIv
 FuniVqdLzD3buamiztyP2qHSLkwPFQeeOY1wGxRVfibrOouROZmMdSc3b5sWWkVHXGRl
 vJg/SIcsYT20BHa36gSX34cSsj/Jl4jYJMGOrZlNl0lxcs35uuc8wVIi5hEf0MMP3lHB
 XAORrXKuSZviD8KIK8xs5zBZW/nqSXbiLAIPfmK7PbjpEqX+h+IISqNIWAAcr97O4pCj
 Wq8Q==
X-Gm-Message-State: AOJu0Yxny3lagF7zul6wYWkvs8q+yTQVe4ZTvdsCT9gYzhmo+XBQTc1y
 E5IV5uRVDHQK4eB3jKSVvLXAnCbnZRwPrMc5gh4bhvExwQjXhVfTHfRB7ZoOM6bDWHI=
X-Gm-Gg: AZuq6aIreqCatgWs2AxjWFvYJyKBH8JzI4LKdc4kpXBz7CTimYJjmmvDcErAA/tLryP
 MjvrO4S4IOhb7GkXP5tetkv0Gt7hV6swNjiRQxYH0bvFm3BGD/fsrd+tx54v2s6HHn1+hQcyMES
 D7yYyv/SYRkv5HVAdIkZdOSNL+XEsglSj3K59tp2fgwFYo4IBJdYdT1IzEzPRcxfw62po9PoTpc
 1kfdI9vgFL3rNe6Pd76UM3ukGavKvULrnafxLecYjk0mG+yKESqP7slaBSTN3Q/LzVbMGCuVhtK
 n2ZdRkFgHh9ZvprmVTFrYkyvBbLt2Q/7WCl1spp74F9FRbzuYrY19GoP6BR+Nbs6sPwnx9RVjEY
 OtDU5FP4lFHRVG4DdTAfuZXfsO7KX2A7sYBfd+mlIgpu+oqBSNxqCHEuyKNGDS3s0CZ2q1+Z5gn
 1i9uE+vjkElLvM1nYiH8b3Y+eG06b8RcmVnQ8YbfWojeGhPp55Z/x3iplwZYY+wqAAQEW5rr1cQ
 PYAIwWY7r6wqIdyTsu9Y6S+MtK0l/86WopXIwI=
X-Received: by 2002:a05:6820:1997:b0:662:fbf3:f4a7 with SMTP id
 006d021491bc7-6630f38ad7bmr9483434eaf.66.1770130665153; 
 Tue, 03 Feb 2026 06:57:45 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-662f9a4e491sm11425489eaf.16.2026.02.03.06.57.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 06:57:44 -0800 (PST)
Date: Tue, 3 Feb 2026 08:57:42 -0600
From: Tom Rini <trini@konsulko.com>
To: dinesh.maniyam@altera.com
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Jan Kiszka <jan.kiszka@siemens.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>
Subject: Re: [PATCH v2 1/5] mtd: nand: introduce SPL_NAND_FRAMEWORK_CAPABLE
 Kconfig option
Message-ID: <20260203145742.GH2603314@bill-the-cat>
References: <20260203074721.25520-1-dinesh.maniyam@altera.com>
 <20260203074721.25520-2-dinesh.maniyam@altera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EB/xO9vP25N9R9Gm"
Content-Disposition: inline
In-Reply-To: <20260203074721.25520-2-dinesh.maniyam@altera.com>
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


--EB/xO9vP25N9R9Gm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 03, 2026 at 03:47:17PM +0800, dinesh.maniyam@altera.com wrote:

> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>=20
> The SPL NAND MTD framework requires working driver model support
> and sufficient memory resources, which are not available on all
> platforms.
>=20
> Introduce a SPL_NAND_FRAMEWORK_CAPABLE Kconfig option to allow
> platforms to explicitly advertise support for compiling the full
> NAND/MTD framework into SPL.
>=20
> This avoids accidental enablement of the SPL NAND framework on
> platforms that cannot support it and provides a clear capability
> boundary for platform maintainers.
>=20
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>  drivers/mtd/nand/raw/Kconfig | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>=20
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index e0ff28cb21b..d73d8ed4404 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -809,6 +809,36 @@ config SYS_NAND_HW_ECC_OOBFIRST
>  	bool "In SPL, read the OOB first and then the data from NAND"
>  	depends on SPL_NAND_SIMPLE
> =20
> +config SPL_NAND_FRAMEWORK_CAPABLE
> +	bool
> +	depends on SPL_DM
> +	depends on SPL_HAS_BSS_LINKER_SECTION
> +	depends on SPL_MAX_SIZE >=3D 0x40000
> +	help
> +	  Indicates that the platform has sufficient SPL capabilities
> +	  (driver model, BSS support, and SRAM size) to support the
> +	  full NAND/MTD framework in SPL.
> +
> +config SPL_NAND_USE_NAND_FRAMEWORK
> +	bool "Use NAND/MTD framework in SPL"
> +	depends on SPL_NAND_SUPPORT && MTD
> +	depends on SPL_NAND_FRAMEWORK_CAPABLE
> +	depends on SPL_ENV_SUPPORT
> +	depends on ENV_IS_IN_NAND
> +	select SPL_SYS_NAND_SELF_INIT
> +	select SPL_NAND_BASE
> +	select SPL_NAND_DRIVERS
> +	select SPL_NAND_IDENT
> +	select SPL_NAND_INIT
> +	select SPL_NAND_ECC
> +	help
> +		Enable loading U-Boot from NAND in SPL using the full
> +		NAND/MTD framework instead of the minimal SPL NAND loaders.
> +		This provides bad-block aware reads and flexible offset
> +		handling via the common NAND/MTD infrastructure.
> +		Platforms enabling this option must also provide working
> +		driver model support and sufficient SPL memory resources.
> +
>  endif	# if SPL
> =20
>  endif	# if MTD_RAW_NAND

This still gets it backwards. Whatever depends on SPL_DM needs to add
it. The max size is something that needs to be set for your platforms.
The BSS requirement is not correct (there are platforms today without
that set).

--=20
Tom

--EB/xO9vP25N9R9Gm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYIM4wAKCRAr4qD1Cr/k
CiVOAQCy/SzxNmcCp2abjInV8Sql9mGwIICXRi0tLa1FqMoabwEAkWY4UpxIVVV3
AS56+J7D7aoH86IHo0SOXz/SKvxMiwU=
=zwEv
-----END PGP SIGNATURE-----

--EB/xO9vP25N9R9Gm--
