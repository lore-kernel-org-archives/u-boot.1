Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98D0F531CA
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 21:14:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C916841D7;
	Mon, 13 Apr 2026 23:13:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MdnDgtBx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA4E9839DF; Mon, 13 Apr 2026 19:17:25 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7F6F8352B
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 19:17:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d9bba96f7dso2476993a34.1
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 10:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776100642; x=1776705442; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XmW0TU1hY4RlFRbmTRkD0EwADR7TRUrkLMwRUhiioLw=;
 b=MdnDgtBxOkMH2k9rpC5YyGEdJlFQgZ2wMVRxiLGBcx85dqpdizJ3UsITa9r2dnTisP
 3DCPgaoNqUwDdNEqjHYijTyjT8Iqwc/l8ODjC5HP7HWY/OEUspZEbot8M/nkTvvn8AKo
 aQKgRPePI4OwKjGMLG4QH941MQ0ogSroXKK3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776100642; x=1776705442;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XmW0TU1hY4RlFRbmTRkD0EwADR7TRUrkLMwRUhiioLw=;
 b=N0Bphfw9TBqJsp3z8QdQgWqQC6iqcGzrTPnQGs1eREQ8AwO+PMvpmaVyETu3thRusF
 cNuIRl5iD2zooIuKcoqoawxwA0qTlLhebUwO4llili2IgWjoLNQjutvRCGzaUdQGwj2r
 DbTanCMxTaVpu1yDtr2w0FqhI+xi6mkXb+Ctsk3xt6NKeIDeRWTwZ4aiyR4yuzpXnN0u
 gD/vzS/+QkTHdj2n5mc4WT9j5y9MCXZDfy5T22WbF9RX/PU8JIoGVJvL8qMawNL5Pf5z
 9W7rTZ1EwrDJwx5/H6GQ3M5NI6Qc+V712S7gAZhnsdWC1klIQVThIkMsLiig1+brKO5T
 yL4w==
X-Gm-Message-State: AOJu0YzUYZEATyaIBd7Mp0W9yCkrcnmFAjSiiAl0ju4jnry1FUDP2RJy
 Xvc31P4OP0gLuaGLuycvHZ5Sx+wZqtf/T7V7pkUg+on8fqH6qUbA/k9bQ7xmc17swgk=
X-Gm-Gg: AeBDiesGWp+7lvqyoi89QQuVpJvGKaoZH4oQvW7JmZtkBGlmGFridWHCY19hz3i0HYz
 8QtgHkMsoHYgsAuJ6DSupSC+HXzrCrEuF5yDPTwoyQ51ASWO8GqZIiLcbr9KdA5R3/yUKuJOWcH
 stl/hwZcsOFTlPZ63vCfnaXbC3wDSX65wkEc2ApRg/iQMFZAcpDU6sZonmjlUNk5Kimz0C8dMyu
 BRQjmozu4s6zl7uB73DGJUn+GYs9PGXAbTRK3D5hSOALCyNFntDxAWSSgiyyqZRuZ0cWy6uIwt0
 Qu7blVtxZxab6Dn0ysGxhLKq5b8RGpfVf6VtTIN+zUhGB9GKYhm+Lb0F4Wfe/gb6buWs6fJA/rq
 DvOqip6htPMEXN1U4ze2nWzLe8/OABCkulCu1aloYzcryGBJaVX49mjDC19MVp5T1SNADdvILGz
 +EgXMHzUBaS7B8OUr1waYwK7vWVrk/7Q5/V+ZopHj8C0GJsRs1OvHtlWAj4X/UD7SpyyQeFKg7z
 4og5y+vHB2FkGRr3ZUcCG8oxhSAX9DPaMehUKNqdT6dH3HJeto=
X-Received: by 2002:a05:6820:2d0b:b0:68e:2616:f61c with SMTP id
 006d021491bc7-68e2616f82bmr3623528eaf.25.1776100642344; 
 Mon, 13 Apr 2026 10:17:22 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-68bcacc9babsm6385330eaf.10.2026.04.13.10.17.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 10:17:21 -0700 (PDT)
Date: Mon, 13 Apr 2026 11:17:17 -0600
From: Tom Rini <trini@konsulko.com>
To: michael.srba@seznam.cz
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ye Li <ye.li@nxp.com>, Andre Przywara <andre.przywara@arm.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Heiko Schocher <hs@nabladev.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <me@ziyao.cc>,
 Peter Korsgaard <peter@korsgaard.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alice Guo <alice.guo@nxp.com>, George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>
Subject: Re: [PATCH v2 06/10] mach-snapdragon: Kconfig: changes / additions
 to support SPL
Message-ID: <20260413171717.GA41863@bill-the-cat>
References: <20260411-qcom_spl-v2-0-9609557cf562@seznam.cz>
 <20260411-qcom_spl-v2-6-9609557cf562@seznam.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VAvJhPINpYfgA6k8"
Content-Disposition: inline
In-Reply-To: <20260411-qcom_spl-v2-6-9609557cf562@seznam.cz>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Mon, 13 Apr 2026 23:13:56 +0200
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


--VAvJhPINpYfgA6k8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 11, 2026 at 02:00:11AM +0200, michael.srba@seznam.cz wrote:

> From: Michael Srba <Michael.Srba@seznam.cz>
>=20
> An SoC to target has to be selected, e.g. SPL_TARGET_SDM845.
> This will select reasonable defaults and enable per-SoC linker
> script (if required).
>=20
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
> ---
>  arch/arm/Kconfig                 | 31 +++++++++++++++++++++++++++-
>  arch/arm/mach-snapdragon/Kconfig | 44 ++++++++++++++++++++++++++++++++++=
------
>  2 files changed, 68 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 03416c55265..8490e336516 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1138,9 +1138,38 @@ config ARCH_SNAPDRAGON
>  	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK
>  	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
>  	select SYSRESET
> -	select SYSRESET_PSCI
> +	select SYSRESET_PSCI if !SPL
>  	select ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
>  	select MMU_PGPROT
> +	select SUPPORT_SPL
> +	select ARMV8_SPL_EXCEPTION_VECTORS if SPL
> +	select ENABLE_ARM_SOC_BOOT0_HOOK if SPL
> +	select SPL_DM if SPL
> +	select SPL_DM_GPIO if SPL
> +	select SPL_DM_PMIC if SPL
> +	select SPL_DM_USB_GADGET if SPL
> +	select SPL_ENV_SUPPORT if SPL
> +	select SPL_GPIO if SPL
> +	select SPL_HAS_BSS_LINKER_SECTION if SPL
> +	select SPL_LIBCOMMON_SUPPORT if SPL
> +	select SPL_LIBDISK_SUPPORT if SPL
> +	select SPL_LIBGENERIC_SUPPORT if SPL
> +	select SPL_MMC if SPL
> +	select SPL_OF_REAL if SPL
> +	select SPL_OF_CONTROL if SPL
> +	select SPL_PINCONF if SPL
> +	select SPL_PINCTRL if SPL
> +	select SPL_PINCTRL_FULL if SPL
> +	select SPL_PINCTRL_GENERIC if SPL
> +	select SPL_PINCONF_RECURSIVE if SPL
> +	select SPL_PINMUX if SPL
> +	select SPL_SPRINTF if SPL
> +	select SPL_STRTO if SPL
> +	select SPL_USB_GADGET if SPL
> +	imply DM_EVENT if USB_DWC3_GENERIC || SPL_USB_DWC3_GENERIC
> +	imply SPL_EVENT if SPL_USB_DWC3_GENERIC
> +	imply OF_LIVE if USB_DWC3_GENERIC
> +	imply SPL_OF_LIVE if SPL_USB_DWC3_GENERIC
>  	imply OF_UPSTREAM
>  	imply CMD_DM
>  	imply DM_USB_GADGET

This part looks good.

> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/=
Kconfig
> index 976c0e35fce..74d687ceee2 100644
> --- a/arch/arm/mach-snapdragon/Kconfig
> +++ b/arch/arm/mach-snapdragon/Kconfig
> @@ -11,18 +11,12 @@ config SYS_VENDOR
>  	  Based on this option board/<CONFIG_SYS_VENDOR>/<CONFIG_SYS_BOARD>
>  	  will be used as the custom board directory.
> =20
> -config SYS_MALLOC_LEN
> -	default 0x10000000
> -
>  config SYS_MALLOC_F_LEN
>  	default 0x2000
> =20
>  config SPL_SYS_MALLOC_F
>  	default y
> =20
> -config SPL_SYS_MALLOC_F_LEN
> -	default 0x2000
> -
>  config SYS_MALLOC_LEN
>  	default 0x800000
> =20
> @@ -45,4 +39,42 @@ config SYS_CONFIG_NAME
>  	  Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
>  	  will be used for board configuration.
> =20
> +config SPL_SHARES_INIT_SP_ADDR
> +	default n
> +
> +config SPL_HAVE_INIT_STACK
> +	default y
> +
> +# SPL targets
> +
> +config SPL_TARGET_SDM845
> +	bool "Set reasonable default values for running SPL in SRAM on sdm845 d=
evices"

This namespace is confusing and so shouldn't be used. Does SDM845 get
used without SPL? We should probably follow the convention of adding a
new defconfig of <whatever board>_spl_defconfig, that enables the
options as needed.

--=20
Tom

--VAvJhPINpYfgA6k8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCad0lHQAKCRAr4qD1Cr/k
CsBfAP9Z5DVNqY549rvOWQtLLfbrtkFB4D4VlveTTUvkJ0604gEAiZd8rVHOFYXE
OdGlN3xG87JmGhgl+PiySkCcWj0uzQ4=
=S8Rz
-----END PGP SIGNATURE-----

--VAvJhPINpYfgA6k8--
