Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 773C0D11183
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 14:15:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A33A843EA;
	Thu, 27 Nov 2025 15:15:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rKYTfedG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3FB9843F2; Thu, 27 Nov 2025 15:14:58 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74C2B8439C
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 15:14:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-3f0c93ecf42so779892fac.0
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 06:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764252895; x=1764857695; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=T7zylve2k7+5Ww61cipbzhgKoF/NnVraNC/tNTkxOE0=;
 b=rKYTfedGGGZKHlgOx3svsVtgqv5wZaI2y95aFf+koVmSmRj2jzsPZVMkz/GhUY9iYH
 r6evfcmxCFGnSSuTpP7ydGcpNO8cG8wn1Req0RUSA/Q2HnpvCf8QbAbxoWJn2i5IJ1O5
 eeymOa34YyTtBQLC3oHgycHjLPeWn6VEJp0BI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764252895; x=1764857695;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T7zylve2k7+5Ww61cipbzhgKoF/NnVraNC/tNTkxOE0=;
 b=bklZT+LMFqbxt0q3oLWGmpAZRh8ErpoAB/gRBnk6OhzcN22Z+1hfiXpmqi7MWKGUJr
 58nuXRpFc/XnV/DSjS3PwSZ3ebtQ2wRvqPy76K+u/Nc58Dsa15Mzm+tMBxSBSoQFPlP3
 OruwFvw5w9zHs3fIio25pEwDtYUM8f4l2ZHK6M9F9YANZv9UEDuah5Dwcj2rXmdsvTzV
 SgL05G+nSCqy8sOel0cJzQ0uWq06QarO4d3PIZsmEnpCoiMa2bYDFRnxYx3oApv/Zcdg
 HP2XWpYxI9SQlfm/wci4sccsAtPRliKXx/0yz7iBRc+DKrrkIntM0lCFEmwamM60MJ8S
 n/MQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAHYnBMhTPZBQUrbc6Nnr3ECrC6+Xy5mrU1No5Mxyx8x15oryswx1HvJ6ndfv+TjiluxhPnVc=@lists.denx.de
X-Gm-Message-State: AOJu0YyR4znILQSbQC3+1pRVWaX2Zx8huYS+v0NKZZEmMnBz8fpr99++
 2v9WKLipfKXaAivGHgXvbM596A4B4EY1XIAhhwnz8oshwM4HHFXWtHjBrDxR1giK+bg=
X-Gm-Gg: ASbGncs7njTN+tns+yB1DRpNoWFPtYMY+8d8AQfd89vVyBqskB0W3mTTS4E01Pw2nRf
 GqR8bF6NIr36591l1MPyu+jNaKS72Xjd3iQj40Et+k6sTFY2+QjL1qDaokEoiVMV5ggKjfj4aGE
 svj6Q2lKpZGG8y9wHBcfGlJCJe+KbdjG09T29Z0DARWyZmE+o8lr0nZQloNHYjoyh/VSeDmrd+I
 vGbxTaN65edea+U+KJi5e3HU2rgHdZ4qGFlaNoRxqGSbDqdFzNXalJ58kGEK2MdqP9QpWls1xTr
 vBMcDr5A6YESksMzTWugB9O8votxL9qS8CYXBqa4KcVBGyCJQDg2VfWyiesbzMq3vA2naOlIe3N
 9YoaoYZr4XVwvcCuxISBPCBFHFmPMa3UIXkpduFkUD7rzdijSlWt2xJxH+p43TFC3JjBNVISZn+
 bpL/lNNbCwjw9W8gf4bsCp9iuym1/OuEJgeiEGpoJuSoIFdLHUXg==
X-Google-Smtp-Source: AGHT+IFpMjQtwag1lDn1cy3hcXMVD5V3AHh2zZokiL7+gQWfh51VGzauvheapex4fS+hk0U6JMgwKA==
X-Received: by 2002:a05:6808:1982:b0:450:b249:71bb with SMTP id
 5614622812f47-45101e311b1mr10872389b6e.19.1764252895021; 
 Thu, 27 Nov 2025 06:14:55 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-659332e0031sm302457eaf.5.2025.11.27.06.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 06:14:54 -0800 (PST)
Date: Thu, 27 Nov 2025 08:14:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Joseph Guo <qijian.guo@nxp.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Adam Ford <aford173@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>,
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: Re: [PATCH 2/2] imx: Support i.MX91 11x11 FRDM board
Message-ID: <20251127141451.GV2125796@bill-the-cat>
References: <20251127-imx91_frdm-v1-0-8f42646d89ad@nxp.com>
 <20251127-imx91_frdm-v1-2-8f42646d89ad@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DE4gI6JbxA+ovgwn"
Content-Disposition: inline
In-Reply-To: <20251127-imx91_frdm-v1-2-8f42646d89ad@nxp.com>
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


--DE4gI6JbxA+ovgwn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 06:54:58PM +0900, Joseph Guo wrote:
> Add i.MX91 11x11 EVK Board support.
>  - Four ddr scripts included w/o inline ecc feature. Support
>    both 1gb and 2gb DDR
>  - SDHC/EQOS/I2C/UART supported
>  - PCA9451 supported, default nominal drive mode
>  - Documentation added.
>=20
> Signed-off-by: Joseph Guo <qijian.guo@nxp.com>
> ---
>  arch/arm/dts/imx91-11x11-frdm-u-boot.dtsi          |  195 ++
>  arch/arm/mach-imx/imx9/Kconfig                     |    8 +
>  board/freescale/imx91_frdm/Kconfig                 |   19 +
>  board/freescale/imx91_frdm/MAINTAINERS             |    7 +
>  board/freescale/imx91_frdm/Makefile                |   16 +
>  board/freescale/imx91_frdm/imx91_frdm.c            |   28 +
>  board/freescale/imx91_frdm/imx91_frdm.env          |   88 +
>  .../imx91_frdm/lpddr4_2400mts_1gb_timing.c         | 1996 ++++++++++++++=
++++++
>  .../imx91_frdm/lpddr4_2400mts_2gb_timing.c         | 1996 ++++++++++++++=
++++++
>  .../imx91_frdm/lpddr4_2400mts_ecc_1gb_timing.c     | 1996 ++++++++++++++=
++++++
>  .../imx91_frdm/lpddr4_2400mts_ecc_2gb_timing.c     | 1996 ++++++++++++++=
++++++
>  board/freescale/imx91_frdm/lpddr4_timing.h         |   12 +
>  board/freescale/imx91_frdm/spl.c                   |  204 ++
>  configs/imx91_11x11_frdm_defconfig                 |  143 ++
>  configs/imx91_11x11_frdm_inline_ecc_defconfig      |  143 ++
>  doc/board/nxp/imx91_frdm.rst                       |   99 +
>  doc/board/nxp/index.rst                            |    1 +
>  include/configs/imx91_frdm.h                       |   25 +
>  18 files changed, 8972 insertions(+)
>=20
> diff --git a/arch/arm/dts/imx91-11x11-frdm-u-boot.dtsi b/arch/arm/dts/imx=
91-11x11-frdm-u-boot.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..7934ec89cfa58c1c033ba08ae=
7be826f5823bc1b
> --- /dev/null
> +++ b/arch/arm/dts/imx91-11x11-frdm-u-boot.dtsi
> @@ -0,0 +1,195 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2025 NXP
> + */
> +
> +#include "imx91-u-boot.dtsi"
> +
> +/ {
> +	wdt-reboot {
> +		compatible =3D "wdt-reboot";
> +		wdt =3D <&wdog3>;
> +		bootph-pre-ram;
> +		bootph-some-ram;
> +	};
> +
> +	firmware {
> +		optee {
> +			compatible =3D "linaro,optee-tz";
> +			method =3D "smc";
> +		};
> +	};
> +};
> +
> +&{/soc@0} {
> +	bootph-all;
> +	bootph-pre-ram;
> +};

These should be upstreamed and are not u-boot specific.

[snip]
> diff --git a/board/freescale/imx91_frdm/imx91_frdm.c b/board/freescale/im=
x91_frdm/imx91_frdm.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..28201a8d62207672c837a34e8=
619ca9ef4638ed0
> --- /dev/null
> +++ b/board/freescale/imx91_frdm/imx91_frdm.c
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2025 NXP
> + */
> +
> +#include <env.h>
> +#include <init.h>
> +#include <miiphy.h>
> +#include <netdev.h>
> +#include <asm/arch/sys_proto.h>
> +
> +int board_late_init(void)
> +{
> +#ifdef CONFIG_ENV_IS_IN_MMC
> +	board_late_mmc_env_init();
> +#endif
> +
> +	env_set("sec_boot", "no");
> +#ifdef CONFIG_AHAB_BOOT
> +	env_set("sec_boot", "yes");
> +#endif
> +
> +#ifdef CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG
> +	env_set("board_name", "11X11_FRDM");
> +	env_set("board_rev", "iMX91");
> +#endif
> +	return 0;
> +}

There are extraneous includes here, please fix and recheck the rest of
the files too.

[snip]
> diff --git a/configs/imx91_11x11_frdm_inline_ecc_defconfig b/configs/imx9=
1_11x11_frdm_inline_ecc_defconfig
> new file mode 100644
> index 0000000000000000000000000000000000000000..b1daad00c24aff1628c76aa06=
cbdf7d8c498ab9c
> --- /dev/null
> +++ b/configs/imx91_11x11_frdm_inline_ecc_defconfig
> @@ -0,0 +1,143 @@
> +CONFIG_ARM=3Dy
> +CONFIG_ARCH_IMX9=3Dy

This should make use of #include to avoid having to keep them in sync,
and make sure that buildman can still build them both when done (or CI
will fail).

> diff --git a/doc/board/nxp/imx91_frdm.rst b/doc/board/nxp/imx91_frdm.rst
> new file mode 100644
> index 0000000000000000000000000000000000000000..04780f1d8db693f8a32c0bf29=
3d59454862166da
> --- /dev/null
> +++ b/doc/board/nxp/imx91_frdm.rst
> @@ -0,0 +1,99 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +imx91_frdm
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Please see the docs on building the documentation, this and likely other
style errors will fail in CI.

Thanks!

--=20
Tom

--DE4gI6JbxA+ovgwn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaShc2AAKCRAr4qD1Cr/k
CkQSAPjLwHCk/SYJk4eJ0ioi/RJ3XXkUs6On+fGOU/GrDMUgAP99HCy/aeolLU/y
mGJiUI/7VKQ2Zj4EPI+YQ+90CeGvAw==
=e5q0
-----END PGP SIGNATURE-----

--DE4gI6JbxA+ovgwn--
