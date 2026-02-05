Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E3FECD981
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 15:46:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF3CA83C02;
	Thu,  5 Feb 2026 16:46:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PrY8byhg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 753DC83C65; Thu,  5 Feb 2026 16:46:03 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2032F83B95
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 16:46:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-4042905015cso758767fac.0
 for <u-boot@lists.denx.de>; Thu, 05 Feb 2026 07:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770306360; x=1770911160; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0ltfi1iQ8ymnB4ZNhRGIeuK6sYYHNt8Y60RjEKQ7WzE=;
 b=PrY8byhgFYmbv+ZFpFRimL8en+xkjSnJo0FBZIWZ/j0X4ECa1uJEAVq02bCXvwecjT
 7+Gk0/RAmFvUNRk54yZCtZiYdevOimOKyVawaHHVYKMJ6QBUwbpSgKVkeMN97tPL/S8k
 U/uBJSSWt/YLUJ8JnMEbMjs4SxkD3laDxlBP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770306360; x=1770911160;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0ltfi1iQ8ymnB4ZNhRGIeuK6sYYHNt8Y60RjEKQ7WzE=;
 b=H1+ZGqrJ61LNKdgGPWrZhCv3qsjIPSHTDNKYwroO1tSzyFMFLfrAGxFUxVIuAzpUsf
 0cXEI/HzbH2FXQwkf9DyvHcDrt2HvXO4bfNhdFx7jFJl22LrFO4ptBv+UYK+9uQ+Y3+u
 4Z9HZjSm1raSXcIAAsOlGBUey4VYJ7b9V0zJwvQLf4MtaHGuDR9pMWVvenKRnxk0tBQv
 /roHCTlUNhGLLHz4lyKohxmlh1pbS+mlVeIaiEnG3os01L7pwTfPRHJcKkiFdnE74Z43
 w1R9mCj/Ug+IZXAyDjg+SXEknsVhFEsfa58UH+G9PNY/gGLZ3FDXgXWlrLmtCZTSMM0l
 S2oA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFdxv/E+Ex3hCIglr2K8i+Ixi2RiRA1byhUbxftOunxXF0vTKrYQ9/4MzzHp4KN5AB9Fh/O5U=@lists.denx.de
X-Gm-Message-State: AOJu0Yw55y+XZb8g6ogwJEHwmeZHj17teokMeySdA1eN+lUzAklkW4TS
 mQHSTIVOuD8krGiJDvqKT7JMLUHwSp4zuWXLNSPt3K+hocih+rNoROzQlFaYi4eTt8w=
X-Gm-Gg: AZuq6aK25HbDdm1JGhlAOlSHpb+y0tsw8omRUQo/LTBgZTM7HeNM1UTdvbBUcg8TB7S
 lOQD0BrH57FsSeVFiHUp56ufOC2BIpc1dEIaAwyoZb43AwHilQL6IQATca8/jB5thtTXIZ7Z3+K
 2HVM4GuCq60TIaYvuh8UaD32ARB8P13bOISgev0XmGtZwUXTYI6bQScVsTv+5vCOmCrh8byqyqm
 lUrc/fnpQAy1qr77SOrpPyTbmwOtOAwk+xmq/Pc47grccafzdonhy4rYvWXDldpqknOSxSsSWxR
 uPQp0KU2iSdlA5bylVUMPyOBuXu/wAK0jHyeHDghNvbnKYUwUyL5QE6uCUHD/8Q9EvTsufae79U
 tCZU04arfSN1NijVFPgusQXO3cfP/jdnaQ31maQ8R6tV36G9vtT3+VrhaU11T5R7vf70v4u1lJI
 YsazBS5TuFUAKOjaWDyBxsXR7gbQbd13tUA0ESFv3x7yhkL0C4ddRH3HKOxgWzdQiYAs3MxWbFh
 ns++TqSuXvA+qaAG3P1TCsWSR+I2a+TRV+BKwc=
X-Received: by 2002:a05:6870:2185:b0:409:81eb:cf56 with SMTP id
 586e51a60fabf-40a53edf04amr3298813fac.27.1770306359607; 
 Thu, 05 Feb 2026 07:45:59 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a62b4700esm3084162fac.7.2026.02.05.07.45.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 07:45:58 -0800 (PST)
Date: Thu, 5 Feb 2026 09:45:55 -0600
From: Tom Rini <trini@konsulko.com>
To: alice.guo@oss.nxp.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>, Jindong Yue <jindong.yue@nxp.com>,
 Jacky Bai <ping.bai@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Fedor Ross <fedor.ross@ifm.com>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>,
 Ji Luo <ji.luo@nxp.com>, Frank Li <Frank.Li@nxp.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Adam Ford <aford173@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 David Zang <davidzangcs@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marex@nabladev.com>, Joseph Guo <qijian.guo@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v1 12/12] board: nxp: imx952_evk: Add i.MX952 15x15
 lpddr4x board support
Message-ID: <20260205154555.GL2603314@bill-the-cat>
References: <20260205-imx952-v1-0-2103d0222a0b@nxp.com>
 <20260205-imx952-v1-12-2103d0222a0b@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OrhcTBi989//5Ses"
Content-Disposition: inline
In-Reply-To: <20260205-imx952-v1-12-2103d0222a0b@nxp.com>
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


--OrhcTBi989//5Ses
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 05, 2026 at 09:55:18PM +0800, alice.guo@oss.nxp.com wrote:

> From: Peng Fan <peng.fan@nxp.com>
>=20
> Add support for i.MX952 15x15 lpddr4x board support.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
[snip]
> +void board_quiesce_devices(void)
> +{
> +	int ret;
> +	struct uclass *uc_dev;
> +
> +	ret =3D imx9_scmi_power_domain_enable(PD_HSIO_TOP, false);
> +	if (ret) {
> +		printf("%s: Failed for HSIO MIX: %d\n", __func__, ret);
> +		return;
> +	}
> +
> +	ret =3D imx9_scmi_power_domain_enable(PD_NETC, false);
> +	if (ret) {
> +		printf("%s: Failed for NETC MIX: %d\n", __func__, ret);
> +		return;
> +	}
> +
> +	ret =3D uclass_get(UCLASS_SPI_FLASH, &uc_dev);
> +	if (uc_dev)
> +		ret =3D uclass_destroy(uc_dev);
> +	if (ret)
> +		printf("couldn't remove SPI FLASH devices\n");
> +}

Can we instead handle all of this via setting DM_FLAG_OS_PREPARE in
drivers as needed, so they're properly cleaned / released before OS
boot?

[snip]
> diff --git a/doc/board/nxp/imx952_evk.rst b/doc/board/nxp/imx952_evk.rst
> new file mode 100644
> index 00000000000..9f20db2403f
> --- /dev/null
> +++ b/doc/board/nxp/imx952_evk.rst
> @@ -0,0 +1,112 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +imx952_evk
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

This will be a doc warning and fail CI, please either push through CI or
build the docs locally (see doc/build/documentation.rst) with KDOC_WERROR=
=3D1

[snip]
> diff --git a/include/configs/imx952_evk.h b/include/configs/imx952_evk.h
> new file mode 100644
> index 00000000000..dadc883027f
> --- /dev/null
> +++ b/include/configs/imx952_evk.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2025-2026 NXP
> + */
> +
> +#ifndef __IMX952_EVK_H
> +#define __IMX952_EVK_H
> +
> +#include <linux/sizes.h>
> +#include <linux/stringify.h>
> +#include <asm/arch/imx-regs.h>
> +
> +#define CFG_SYS_INIT_RAM_ADDR		0x90000000
> +#define CFG_SYS_INIT_RAM_SIZE		0x200000
> +
> +#define CFG_SYS_SDRAM_BASE		0x90000000
> +#define PHYS_SDRAM			0x90000000
> +
> +#define PHYS_SDRAM_SIZE			0x70000000 /* 2GB - 256MB DDR */
> +#define PHYS_SDRAM_2_SIZE		0x380000000 /* 14GB */
> +
> +#define CFG_SYS_SECURE_SDRAM_BASE	0x8A000000 /* Secure DDR region for A5=
5, SPL could use first 2MB */
> +#define CFG_SYS_SECURE_SDRAM_SIZE	0x06000000
> +
> +#define WDOG_BASE_ADDR			WDG3_BASE_ADDR
> +
> +#ifdef CONFIG_ANDROID_SUPPORT
> +#include "imx952_evk_android.h"
> +#endif

It's a really bad idea having the board.h file bring in other includes.
We aren't using SZ macros, and a patch to clean up WDOG_BASE_ADDR so it
doesn't need to be in the board.h would be a good cleanup to do, but
maybe for now just make sure the watchdog driver has the regs header
included?

--=20
Tom

--OrhcTBi989//5Ses
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYS7MwAKCRAr4qD1Cr/k
CrjgAQDStT/CdUZDD6Tp1L9lQEWkxhRKEZG9KOYPxzXFENd5LQEAw/FJH/YZ2M/t
lDopbRNoZNa9w3ux/HhkChainhmP8QU=
=dUCO
-----END PGP SIGNATURE-----

--OrhcTBi989//5Ses--
