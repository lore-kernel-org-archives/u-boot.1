Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29FFC71155
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 14:11:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0224280E9A;
	Fri, 20 Jun 2025 16:11:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BC0uKgvf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 498B982CBC; Fri, 20 Jun 2025 16:11:40 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06D9680C83
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 16:11:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-404e580bf09so435795b6e.1
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 07:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750428697; x=1751033497; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nutu2iZLIbPNyIbuB27PFSejGBFLH2G8BbtMkO+akGQ=;
 b=BC0uKgvfL/0dA0eOLuTlUscpURnY4alUBDH9QKxXO5C3wQ7+VDLJGAuXDjLFfRXS1D
 E/ag8qwhjEkq17iNHVMnwxzNoORFRUHdXShXZ3JMKr+O/k9eOsOGFmKH+S9uoQpeYu6J
 RLefdupIT6R5FVzEPk+Q43xHbDrX3v9oRM/Zo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750428697; x=1751033497;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nutu2iZLIbPNyIbuB27PFSejGBFLH2G8BbtMkO+akGQ=;
 b=DMCaljO6RrPsVV2DRUOCTWq01f9Azn8dyCTf2Fc6jIah8KtNVZlC6ozS4aX22ibvcd
 0Tovy3W0vBD8uVTzdFZwg31IVNpgkbXm4dAWAZBawTuZowBpID7NVq51f1/bTFmKajgO
 C4/63o3mmquCp/e/GoZb9waraZs905Oj6YkFwGtIARIbHzgmgnHcmG2iafZrmCVqIhSt
 2qCK9OvOs5IhNt/vPwQAjkigQ1RlL/4Kcp/wEsEoVEhMA9UkpWYXkmE39/OpcxR1UZD9
 pEnPIiyCeV5nqnHPs1qyKYgNXkr3yJBcrkYxl3RxXf6O4qr6uPNTofwo4W9Z4pWVPiyy
 bNSg==
X-Gm-Message-State: AOJu0Yy6/lOSSUEcZiITsTCz4j/45/LzmjkXi6ZOiS19kz331/3U6svg
 4WhFs0SCB8Laj/9YdzVCpDzz3mYXkjRlDSwKU2CRI89p6uIgKVv7nnvG4ZnbGpv4opM=
X-Gm-Gg: ASbGnctC7p85zyPoKwTUJ2IadODIyHUyElqxGBynYcBpx0N5WwDCs9lfIF3LP6JpYBT
 6mrU6/b0tKRk0PDcCIwFiORNH09oUxWda1dIWOpxcmRg/91qwRiO8xgBtoI6/85rr8AelZWitTp
 vsYy9Z4A8h2akwU1V+uEYsc/NcrAhZW48U4miANw7JjA/PezKqy9VUgIv0yrodt442eAC8xQP00
 4Te0xmsA6F6WK4ViH3Bqdd/E0erW2HwGPJCHBTmFZmlhqM2Svtxf3HWSEIWS1LfN6rYsZ9DNCsg
 OK9OclzlSybzxpdwsJfeF5kCAKAW5RLEnb4gldKHqdJukHtOxf7IwMYWXNpG+v0fszA1pJBnpMv
 tvQHKT9pi3sT9tJTHM0kbFMPHQuYS0pcTdQ==
X-Google-Smtp-Source: AGHT+IFdq1bt7G3FJBKy/J7Hn3ld4xjvqdaegvPVGDEeJgxKx8+tN1KjYJrSHHjl/0w7QZfgkolIXA==
X-Received: by 2002:a05:6808:4f50:b0:408:fbb6:f4cb with SMTP id
 5614622812f47-40ac7033bb6mr2101287b6e.6.1750428696615; 
 Fri, 20 Jun 2025 07:11:36 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40ac6cf0b1esm307120b6e.23.2025.06.20.07.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 07:11:35 -0700 (PDT)
Date: Fri, 20 Jun 2025 08:11:33 -0600
From: Tom Rini <trini@konsulko.com>
To: alif.zakuan.yuslaimi@altera.com
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>
Subject: Re: [PATCH v1 1/2] mtd: nand: Allow full NAND framework in SPL
Message-ID: <20250620141133.GH216500@bill-the-cat>
References: <20250620102953.29633-1-alif.zakuan.yuslaimi@altera.com>
 <20250620102953.29633-2-alif.zakuan.yuslaimi@altera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="s5Rx0O1AR+UtUL6M"
Content-Disposition: inline
In-Reply-To: <20250620102953.29633-2-alif.zakuan.yuslaimi@altera.com>
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


--s5Rx0O1AR+UtUL6M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 03:29:52AM -0700, alif.zakuan.yuslaimi@altera.com w=
rote:

> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>=20
> Add configuration option to compile the entire NAND framework into
> U-Boot SPL. This is required by some drivers, like the Denali NAND,
> which use a lot of functionality from the NAND core.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>  drivers/mtd/nand/raw/Kconfig  |  8 ++++++++
>  drivers/mtd/nand/raw/Makefile | 28 ++++++++++++----------------
>  2 files changed, 20 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index adb271dfb8f..28b48d53def 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -208,6 +208,7 @@ config NAND_CADENCE
>  config NAND_DENALI
>  	bool
>  	select SYS_NAND_SELF_INIT
> +	select SYS_NAND_ONFI_DETECTION if TARGET_SOCFPGA_SOC64

If there's not a more generic SOCFPGA symbol to use here, this part is
fine. But also unrelated as this isn't the SPL driver and this series is
about SPL.

>  	imply CMD_NAND
> =20
>  config NAND_DENALI_DT
> @@ -826,4 +827,11 @@ config SYS_NAND_HW_ECC_OOBFIRST
> =20
>  endif	# if SPL
> =20
> +config SPL_NAND_FRAMEWORK
> +	bool "Compile the entire NAND framework into the SPL"
> +	help
> +	  Some drivers require a lot of functionality from the NAND framework
> +	  core when used in SPL. This option allows compiling the full NAND
> +	  framework into the SPL instead of it's reduced version.

There's some problems here. First, this needs to be inside of the "if
SPL, not outside of it". Second, we already have SPL_NAND_DENALI as an
option, so some explanation of what's being done here now is needed.
Third, if we really really need SPL_NAND_SIMPLE and SPL_NAND_SUPPORT and
SPL_NAND_FRAMEWORK it needs to be moved around so that first we have it
as a choice, then we add more. But given all of the other options we
have in common/spl/Kconfig right now for NAND, I'm unclear about what is
missing today.

>  endif	# if MTD_RAW_NAND
> diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
> index 34cba77046a..08829406902 100644
> --- a/drivers/mtd/nand/raw/Makefile
> +++ b/drivers/mtd/nand/raw/Makefile
> @@ -3,8 +3,18 @@
>  # (C) Copyright 2006
>  # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
> =20
> +nand-framework-objs :=3D nand.o nand_bbt.o nand_ids.o nand_util.o \
> +		       nand_ecc.o nand_base.o nand_timings.o nand_amd.o \
> +		       nand_hynix.o nand_macronix.o nand_micron.o \
> +		       nand_samsung.o nand_toshiba.o
> +
>  ifdef CONFIG_XPL_BUILD
> =20
> +ifdef CONFIG_SPL_NAND_FRAMEWORK
> +obj-y +=3D $(nand-framework-objs)
> +NORMAL_DRIVERS=3Dy
> +endif
> +
>  ifdef CONFIG_SPL_NAND_DRIVERS
>  NORMAL_DRIVERS=3Dy
>  endif
> @@ -15,9 +25,7 @@ obj-$(CONFIG_SPL_NAND_DENALI) +=3D denali_spl.o
>  obj-$(CONFIG_SPL_NAND_SIMPLE) +=3D nand_spl_simple.o
>  obj-$(CONFIG_SPL_NAND_LOAD) +=3D nand_spl_load.o
>  obj-$(CONFIG_SPL_NAND_ECC) +=3D nand_ecc.o
> -obj-$(CONFIG_SPL_NAND_BASE) +=3D nand_base.o nand_amd.o nand_hynix.o \
> -				nand_macronix.o nand_micron.o \
> -				nand_samsung.o nand_toshiba.o
> +obj-$(CONFIG_SPL_NAND_BASE) +=3D nand_base.o
>  obj-$(CONFIG_SPL_NAND_IDENT) +=3D nand_ids.o nand_timings.o
>  obj-$(CONFIG_$(PHASE_)NAND_INIT) +=3D nand.o
>  ifeq ($(CONFIG_SPL_ENV_SUPPORT),y)
> @@ -28,19 +36,7 @@ else # not spl
> =20
>  NORMAL_DRIVERS=3Dy
> =20
> -obj-y +=3D nand.o
> -obj-y +=3D nand_bbt.o
> -obj-y +=3D nand_ids.o
> -obj-y +=3D nand_util.o
> -obj-y +=3D nand_ecc.o
> -obj-y +=3D nand_base.o
> -obj-y +=3D nand_amd.o
> -obj-y +=3D nand_hynix.o
> -obj-y +=3D nand_macronix.o
> -obj-y +=3D nand_micron.o
> -obj-y +=3D nand_samsung.o
> -obj-y +=3D nand_toshiba.o
> -obj-y +=3D nand_timings.o
> +obj-y +=3D $(nand-framework-objs)
> =20
>  endif # not spl

Did you world build this change? At first it looks like we're dropping a
lot of objects from other configs.

--=20
Tom

--s5Rx0O1AR+UtUL6M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhVbBUACgkQFHw5/5Y0
tyx86Qv+IFOryqAJUX3DHIxRl3/UOFTg9Ojg9dXldk+Cucx3OUxU+R6Fm5PclALI
9caaZdYcgJVvdFgQ+eXFX9kvaY5TUYk509kHqGDuJdmjUvMlKJ6A0P5/7X0TapwV
wrnjaNAMQfLmKAeo418D1REgxmf2CS28Z6f+8kCq4oghklYtm0I8UWtCulc164k6
57wlmyGaksn/znmQKOtzWF900rnbPbRYG+3J3eA8ylvEwO3KTNTxf5YLP7oolgIN
cpY2V0+Xz1MoGF2G1z5QQ6MMwbe614v5Mtb+nn5RXkHuqbCfUd9gB3YjF45Mtx4Y
QT5H5P14P2oGpW+3KLbDu3M/chEZCqtmT17I9tXQJK7L93Wq4Wu/OGKHwt+Es6/o
+9H0oMBNM8IZlZOscRXvr8FOhLthMKDnaDwX9Kh8kN0VIZVuy0kC2W972eXSryvT
M0YLuxHc43faR9AjK0j8n2EEQX9L/Dys1cPKYneVg0IBJBdJJkCb7ZZZuQoIdFYo
zvaEX8Gb
=q1un
-----END PGP SIGNATURE-----

--s5Rx0O1AR+UtUL6M--
