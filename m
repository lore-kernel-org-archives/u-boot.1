Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70753C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 18:03:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7CF887B07;
	Thu, 14 Dec 2023 19:03:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HbvAYtBW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E6E387B07; Thu, 14 Dec 2023 19:03:44 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77F6787B06
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 19:03:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5c85e8fdd2dso81816397b3.2
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 10:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702577020; x=1703181820; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=f2pYXl0r+NMTHC2LGEWaNPHfqU7JYDAwBDsxiFA7OFk=;
 b=HbvAYtBWci3LR8MZzH1xWIxvCVyJVONR1Ii/TvyHLFZLS0FHk6Lkeu1kB1w+1I2/1q
 eie1t+PtHIInfR3QX/Ns+RozjiUUNkbAy6l4LXXOb94clhWmiOOnpblsU+op2b+dvDF6
 hMWrHH1ZATP0/3oy+fbKKAOh6QBJ9qFutmAHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702577020; x=1703181820;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f2pYXl0r+NMTHC2LGEWaNPHfqU7JYDAwBDsxiFA7OFk=;
 b=AwVTPgCtMdR4pE9apxbdLWl10JAFZ8RExmj8vyCDb/gJNZb3rSan8VO4L7aKZYwFK7
 asBFjwUXRULOAFeEE90ckM8Mpcj6ynkaokz5VzPsvO3IfHwN/xBuubG08AljGlzw3QB3
 ek3l4dpD9oBxb/1JVOmihB3t2TKvIhrqADOXDwqKMqhGqHNUKz2F3DMrbSLV51Bkbx5B
 15lyNOUg59HZKZavebOVbYRRgsbU5EKfPUktouh1wSt0ZQrZFPe+VSdBZ5jKf0I0V+Sd
 Ga1BVyBGBo7fMcAMczj8lenMgX8MMsNlFmy12R/VXNXGBX99ny/HGlGZgf86EqU/gBs/
 l2Zg==
X-Gm-Message-State: AOJu0Yy2UbaDnXPrhFuUw2RIgKb250wWpLOaXIlFoSsiSds3SRPhs6q1
 v4OUqKDunFjv1Ke+WZoYSXgYpw==
X-Google-Smtp-Source: AGHT+IGFXLr3IhdbZtoTJJ4q3BM1UaB9AzM5x7Zvk3ELiPDOOZ/9GY5TUTztNKiTj8NgO2LfgdzU8A==
X-Received: by 2002:a81:4ac6:0:b0:5d7:1940:dd87 with SMTP id
 x189-20020a814ac6000000b005d71940dd87mr7852943ywa.93.1702577020158; 
 Thu, 14 Dec 2023 10:03:40 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a81d24e000000b005d8bb479c51sm5608691ywl.11.2023.12.14.10.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 10:03:39 -0800 (PST)
Date: Thu, 14 Dec 2023 13:03:37 -0500
From: Tom Rini <trini@konsulko.com>
To: TracyMg_Li@outlook.com
Cc: jagan@amarulasolutions.com, andre.przywara@arm.com, festevam@gmail.com,
 patrick.delaunay@foss.st.com, tharvey@gateworks.com,
 pbrobinson@gmail.com, hs@denx.de, d-gerlach@ti.com,
 u-boot@lists.denx.de, robh+dt@kernel.org
Subject: Re: [patch v1] arm add initial =?utf-8?Q?s?=
 =?utf-8?Q?upport_for_the_Phytium_Pe2201_Board_board=EF=BC=9Aphytium?=
 =?utf-8?Q?=EF=BC=9Aadd_pe2201_folder=EF=BC=8CIt_initializes_pcie=2C_ddr_a?=
 =?utf-8?Q?nd_other_aspects_of_phytium_pe2201_board_dts=EF=BC=9Aadd_phytiu?=
 =?utf-8?Q?m=5Fpe2201=2Edts=EF=BC=8Cit_is_devic?= =?utf-8?Q?e?= tree of
 phytium pe2201 board, include pcie and uart node
Message-ID: <20231214180337.GP2513409@bill-the-cat>
References: <SEYPR01MB5884E73747590F8307ACEBE7F18CA@SEYPR01MB5884.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OdzkSaSdKSsiVrYS"
Content-Disposition: inline
In-Reply-To: <SEYPR01MB5884E73747590F8307ACEBE7F18CA@SEYPR01MB5884.apcprd01.prod.exchangelabs.com>
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


--OdzkSaSdKSsiVrYS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 11:06:58AM +0800, TracyMg_Li@outlook.com wrote:

> From: TracyMg_Li <TracyMg_Li@outlook.com>
>=20
> Signed-off-by: TracyMg_Li <TracyMg_Li@outlook.com>

Please rework your commit message.

> ---
>  arch/arm/Kconfig                 |   8 ++
>  arch/arm/dts/Makefile            |   1 +
>  arch/arm/dts/phytium-pe2201.dts  |  43 +++++++

Please make sure this dts is being submitted upstream and passes
validation there before submitting it upstream too.

[snip]
> @@ -2060,6 +2060,13 @@ config TARGET_POMELO
>  	   Support for pomelo platform.
>  	   It has 8GB Sdram, uart and pcie.
> =20
> +config TARGET_PE2201
> +    bool "Support Phytium PE2201 Platform"
> +    select ARM64
> +    help
> +      Support for pe2201 platform.
> +      It has 2GB Sdram, uart and pcie.
> +

Was your patch spacing corrupted? If not, please fix this here.

[snip]
> diff --git a/include/configs/pe2201.h b/include/configs/pe2201.h
> new file mode 100644
> index 0000000000..ff24dc5ac6
> --- /dev/null
> +++ b/include/configs/pe2201.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2023, Phytium Technology Co., Ltd.
> + * lixinde          <lixinde@phytium.com.cn>
> + * weichangzheng    <weichangzheng@phytium.com.cn>
> + */
> +
> +#ifndef __PE2201_CONFIG_H
> +#define __PE2201_CONFIG_H
> +
> +/* SDRAM Bank #1 start address */
> +#define PHYS_SDRAM_1            0x80000000
> +#define PHYS_SDRAM_1_SIZE       0x74000000
> +#define CFG_SYS_SDRAM_BASE	PHYS_SDRAM_1
> +
> +/* BOOT */
> +#define BOOT_TARGET_DEVICES(func)	\
> +	func(SCSI, scsi, 0)	\
> +
> +#include <config_distro_bootcmd.h>
> +
> +/* Initial environment variables */
> +#define CFG_EXTRA_ENV_SETTINGS	\
> +	"image=3DImage\0"	\
> +	BOOTENV	\
> +	"scriptaddr=3D0x90100000\0"	\
> +	"kernel_addr_r=3D0x90200000\0"	\
> +	"fdt_addr_r=3D0x95000000\0"	\
> +	"boot_fit=3Dno\0"	\
> +	"fdtfile=3Dphytium-pe2201.dtb\0"	\

Please switch to both bootstd and plain text environment, thanks.

--=20
Tom

--OdzkSaSdKSsiVrYS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV7Q3kACgkQFHw5/5Y0
tyzHZQv/UsZdmp8HcNIicmSyyWc4i8/hW//VT5mdgnYKSbchpEXFnRs7cAt5iQKa
qvSKb4GhHyDcIv+CB+Ov1MbnJy6nvteZ0/F6oPBSN0RKLtr9kgr2t9Io8g3uMmOh
4DU0U1F9n/iL39SsIALXdKSfT5vejqevXuwHHOMp+dRvrNWhvIrMOhZJkaN/GPvs
1EkC+hCh6CoXe/it51LJvccvutTLfdU55bcIiugOUbqwDrydBeHMufsQUCxc7Vh5
VOZJCtSydhjCqs8KS4M4TbdaKaPOFwz9BaQ2nrIho8Kpjmz+/WmTzAWk3j8y1Es2
bk3uMZxRRpkrQjC3P9ahXBaruy+zX1v7USkcfjy/DipkSbnWUIMTYePVaI6YqcX1
k9JzmMBqBrBztLjwiANEZ+tbxgvm9qLQKYbShgHsdj4VEwrOslAmy2SwYNvtDtlY
D3/FGk5M88jm24No0VJBzsIdPCF7znAp/iBGdrHN19Jl3Zbg/h3hLi0ZH6/aOoM7
f39xJK4e
=K7nL
-----END PGP SIGNATURE-----

--OdzkSaSdKSsiVrYS--
