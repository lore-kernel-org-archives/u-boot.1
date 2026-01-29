Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 442EFD6B061
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 15:24:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9861F83A64;
	Thu, 29 Jan 2026 16:24:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NxUAzDOh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41D3B8341A; Thu, 29 Jan 2026 16:24:33 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F29983D9C
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 16:24:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-4042f55de3aso765964fac.1
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 07:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769700270; x=1770305070; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mOkoi3K7+yD89z1FdCcgS/DLaN8/nL/VBDUuOC1kzdM=;
 b=NxUAzDOhwFfnyNCx3m5wWwwvnX80vlrl/DHOcqgvoat6WGCd11E0+CALdAPMfuRzWI
 1hwju4enR/nvVE/IaB1xs8V1jnZtgMFAR//4PiypRtX2Y5lOln6P8CxQbS4deBpPvrkC
 5QlBqUJotsgDbHc70NgKRHZU9MmTohMw2GD5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769700270; x=1770305070;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mOkoi3K7+yD89z1FdCcgS/DLaN8/nL/VBDUuOC1kzdM=;
 b=lo0NNNn8RyeNXmxL7o8Uset1+o3o+Q1oY2zxt2GekovxYWtXNeiCbBh467EfaOKSsi
 UYqkDG3fv4geolhb1rt/Ce281wOaoPZSf0p5icmL0ab2f3G1RoFx/RgBdC9DRri/+6r+
 b3mb9iMLO1LQoZQQKviNDL5iLrZm8E4Vk+k/reIl4cI0KdJlOkYvMV9fZKWHr4oFPXLH
 8K49cLCoJmXW3KB2dIImgi4gbYlxbLYYS4WwCvq6wxYu30jLsbdNkcVkaIpReZrMHTVT
 QRJSzJxmi6Opy4Z/DQuY443VkQaT2HFN6vr2UX+JQ+NO6tDTo8NAGtbsstaOXQzgTBpa
 xGrw==
X-Gm-Message-State: AOJu0YwNTrJEyXrVfianOjLfVtnDejx3Py5wBz9/glJr/Q7nYxDWe1Lo
 SOtC5fxyGqJR9DercKOrKVaw7lIXaBJ9MxTzMnIf6Q6Vu5N4eZII25t9coZmGSjSNTQ=
X-Gm-Gg: AZuq6aJKQZ9iPDQhO+/8Zb3bGBBDZQwgMkeNzLTVMji0NcdLoGHPnilDl0RoGNPetH8
 fln4pEk1hnhd+Kmo0Q7/dEpvIFj2nFVS6lU277tNzKCpL616Y5zOwh3tJ6DYkReSiJBEQur6VD/
 YahDAqTJCqeaPoKiYTSQ8i4g6cTZfTck1SSOT1feDEaUfuXrw22YAmtEFsSysUDRfmU3+8J4m+H
 Y5k7i7b9ixppXigbno6Dy7qZSE8jtgOJF45A3gFYTQFLCLxuGqGIy9tMFHW5ra4z6KcsYLbtDii
 qu73SIbgQ4tG+6P82S1s1FvyGoz3Uaj/4dY0leNSuNz5AVDTJ6Gx4C4S64Ln8uZDC2TcyAxFHH3
 IvJqYOipuG6Vbxvp4kR7PoY6WrGcVznenpxWVlKsgYCc1m4Eda17/Xtqj9QWS6i95xyXy5Qkkjg
 4HZK1eiXULlkEn5X9PGDTUP/Up0ttEFLqjBXcjhSIHL3fkQviEp50w4j/az20S3aVffPmVNh53U
 tMYglsEq1/gXxxwz7RS612xYrFpAXloAAacgac=
X-Received: by 2002:a05:6871:2215:b0:404:10f9:8f44 with SMTP id
 586e51a60fabf-4097fc382d0mr1766597fac.14.1769700269452; 
 Thu, 29 Jan 2026 07:24:29 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-409575f6551sm4038007fac.22.2026.01.29.07.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 07:24:28 -0800 (PST)
Date: Thu, 29 Jan 2026 09:24:26 -0600
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
Subject: Re: [PATCH 1/5] mtd: nand: introduce SPL_NAND_FRAMEWORK_CAPABLE
 Kconfig option
Message-ID: <20260129152426.GV3416603@bill-the-cat>
References: <20260129050446.8858-1-dinesh.maniyam@altera.com>
 <20260129050446.8858-2-dinesh.maniyam@altera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oj/l92Qity0VdGSS"
Content-Disposition: inline
In-Reply-To: <20260129050446.8858-2-dinesh.maniyam@altera.com>
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


--oj/l92Qity0VdGSS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 01:04:42PM +0800, dinesh.maniyam@altera.com wrote:

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
>  drivers/mtd/nand/raw/Kconfig | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>=20
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index e0ff28cb21b..e41e5ef2e94 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -809,6 +809,31 @@ config SYS_NAND_HW_ECC_OOBFIRST
>  	bool "In SPL, read the OOB first and then the data from NAND"
>  	depends on SPL_NAND_SIMPLE
> =20
> +config SPL_NAND_FRAMEWORK_CAPABLE
> +	bool
> +	depends on SPL_DM
> +	depends on SPL_HAS_BSS_LINKER_SECTION
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

It sounds like dependencies are missing on existing symbols, and should
be added there, from the description. It also sounds like these
platforms have hard limits on SPL size, but aren't setting the
appropriate options to enforce that at link time. Or am I totally
misunderstanding?

--=20
Tom

--oj/l92Qity0VdGSS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXt7qgAKCRAr4qD1Cr/k
Cvp1AP4175rV5BvL66NElk8gfwyp4gHTRX5KTDTqs+DRGpKMowD9F86Pqi4L5QTY
nsA0RmC14ZjRxeYXWDaq/DSS1IZg1Aw=
=jg9q
-----END PGP SIGNATURE-----

--oj/l92Qity0VdGSS--
