Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A110C87FCA
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 13:55:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AF878398D;
	Fri, 25 Jul 2025 15:55:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IfRUvhyL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C3B18398D; Fri, 25 Jul 2025 15:55:28 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E158483987
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 15:55:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-73e8cc38e80so1549206a34.1
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 06:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753451724; x=1754056524; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rg7WhUBYn7IEWU853351K1vdTRbEBsuqFBD7Akuk9Ew=;
 b=IfRUvhyLZzJ4+K0WApy8H9J4KULpBNeVVj3dQgNThe578e1vqqq3BQbL1HULRi69ZK
 CednMrgjFBHXZdyWedJMsvDA2fMGJwB+gQn+b3a4g1zCHK9kg3AYcGzbkJzesmOx6ii8
 enz55b1pC2BhakUF7Qbe4LW9VL+q0Uql0+zqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753451724; x=1754056524;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rg7WhUBYn7IEWU853351K1vdTRbEBsuqFBD7Akuk9Ew=;
 b=aUKQbXlVFmgUiLEImK1SRewdGR7Xx9f1dLs9NDU4ckA2Q9aK5oaDT8A7rXBvAR1t9v
 k6NP7BUXFby9C13Id9+DyIhPKiGrW+tgMe7cM/9Q5vsKrgeBzdFtNzGMgCgMEs2AmDfP
 fRR7wnJr5XtREpHQs7IsZdMVcfQnthLtnY+5FI9IoaFVh64zNQrVi72VO1ZjvPoAuslG
 vab6rfzv5E2b0yoCFjqvKKiBBJddmkgcolwzHzl1Pfck2h+tdzHgwHv8yAZ+zzfAs01C
 R1g+Z0E8iLsLPdAek3deBuEuVmhmmRsIgm9IcuOuF7bZgI+oSlQ6sEZAvOKQednuhXVo
 N3Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeirnR/J+QKenipbWJ0vMoTjEhwUkDxzLoBmsh6BYT/nutDppYt7/REYuKXW1qi5uUtHdPBqY=@lists.denx.de
X-Gm-Message-State: AOJu0YxESbc1lM4zN4pKuj8/9/GIwqOiIboCsKwLsuHgOxlxQamFtBnp
 sV96IIEWyQPyyKMKgQlvozCZISIAVklqkynEaXgDoSRwj1vYxU8OnWlvGv1iB8ZfvG4=
X-Gm-Gg: ASbGncvxgXEFCSd/HLBzGgMgdRxbwlyMhv+mrhFsccT42sNJF8Lq+nge9b1ImCct5FP
 +9kfy3s4p5fiaAas1l0vEr1HLz7Bv73kNQSemOTmCUo1DMdJvh0bdGIpGFS2QR8JJE6c9Tuf2SE
 3in5ymOiMFemFHJv3wKxRSVnJL73d8KeshgtKMxYZfeoTNqS1eV+4MnWgQqGwLGsHB59Od5xzVV
 p1dTIkb4QoyORE3MFC5WdBqkMYl5KvPxPxf9yfNVqKE2N8ZJOhnECBuamdhM2C+r0tVPokvABQ0
 jTpHAhI4dbaRLmebAsa20BrFMHjkyCNmbMcNstvFW+wh5wqLCW0f7qR6US0dh1XlOZNtOC3ypj/
 cQJICOdmJa1ODFqTbFi93xUxEECXICURVaPiQJ5SEIE1SbrUKWKIh5f1b
X-Google-Smtp-Source: AGHT+IH7s6H+oF2TIS0FjniqFyAjNTNqAoHfqLL+ohuYKT01lQtwmf0pgRMQYhnyHfs34oBqKxnuFg==
X-Received: by 2002:a05:6808:1a18:b0:40b:31ef:8784 with SMTP id
 5614622812f47-42b9d82e88bmr1066007b6e.7.1753451724515; 
 Fri, 25 Jul 2025 06:55:24 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-42a334709ccsm614401b6e.34.2025.07.25.06.55.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 06:55:23 -0700 (PDT)
Date: Fri, 25 Jul 2025 07:55:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Benjamin Hahn <B.Hahn@phytec.de>
Cc: Sumit Garg <sumit.garg@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Teresa Remmet <t.remmet@phytec.de>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 3/3] Add imx8mp-libra-fpsc board
Message-ID: <20250725135521.GB1807455@bill-the-cat>
References: <20250725-imx8mp-libra-initial-support-v1-0-d9982df21a4b@phytec.de>
 <20250725-imx8mp-libra-initial-support-v1-3-d9982df21a4b@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="D9oIiN4k0Hh+JTnk"
Content-Disposition: inline
In-Reply-To: <20250725-imx8mp-libra-initial-support-v1-3-d9982df21a4b@phytec.de>
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


--D9oIiN4k0Hh+JTnk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 12:35:40PM +0200, Benjamin Hahn wrote:

> Add new imx8mp-libra-fpsc board.
> USB is not working yet, as the entry in the upstream devicetree is
> missing.
>=20
> Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
> ---
>  arch/arm/dts/imx8mp-libra-rdk-fpsc-u-boot.dtsi     |   78 +
>  arch/arm/mach-imx/imx8m/Kconfig                    |    9 +
>  board/phytec/imx8mp-libra-fpsc/Kconfig             |   16 +
>  board/phytec/imx8mp-libra-fpsc/MAINTAINERS         |    8 +
>  board/phytec/imx8mp-libra-fpsc/Makefile            |   10 +
>  board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.c |  114 ++
>  .../phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env |   30 +
>  board/phytec/imx8mp-libra-fpsc/lpddr4_timing.c     | 1846 ++++++++++++++=
++++++
>  board/phytec/imx8mp-libra-fpsc/spl.c               |  131 ++
>  configs/imx8mp-libra-fpsc_defconfig                |  170 ++
>  include/configs/imx8mp-libra-fpsc.h                |   27 +
>  11 files changed, 2439 insertions(+)
>=20
> diff --git a/arch/arm/dts/imx8mp-libra-rdk-fpsc-u-boot.dtsi b/arch/arm/dt=
s/imx8mp-libra-rdk-fpsc-u-boot.dtsi
> new file mode 100644
> index 000000000000..8f0f86d9f09e
> --- /dev/null
> +++ b/arch/arm/dts/imx8mp-libra-rdk-fpsc-u-boot.dtsi
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2025 PHYTEC Messtechnik GmbH
> + */
> +
> +#include "imx8mp-u-boot.dtsi"
> +
> +/ {
> +	wdt-reboot {
> +		compatible =3D "wdt-reboot";
> +		wdt =3D <&wdog1>;
> +		bootph-pre-ram;
> +	};
> +};
> +
> +&reg_usdhc2_vmmc {
> +	bootph-pre-ram;
> +};

Please note the bootph tags should be upstreamed.

[snip]
> diff --git a/board/phytec/imx8mp-libra-fpsc/MAINTAINERS b/board/phytec/im=
x8mp-libra-fpsc/MAINTAINERS
> new file mode 100644
> index 000000000000..16b18b605e0d
> --- /dev/null
> +++ b/board/phytec/imx8mp-libra-fpsc/MAINTAINERS
> @@ -0,0 +1,8 @@
> +Libra-i.MX 8M Plus
> +M:      Teresa Remmet <t.remmet@phytec.de>
> +W: 	https://www.phytec.eu/en/produkte/system-on-modules/phycore-imx-8m-p=
lus-fpsc/
> +S:      Maintained
> +F:      arch/arm/dts/imx8mp-libra-rdk-fpsc-u-boot.dtsi
> +F:      board/phytec/imx8mp-libra-fpsc/
> +F:      configs/imx8mp-libra-fpsc_defconfig
> +F:      include/configs/imx8mp-libra-fpsc.h

These should all be tabs.

[snip]
> diff --git a/board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.c b/board/p=
hytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.c
> new file mode 100644
> index 000000000000..89b3b6f90ecb
> --- /dev/null
> +++ b/board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.c
> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2025 PHYTEC Messtechnik GmbH
> + */
> +
> +#include <asm/arch/clock.h>
> +#include <asm/arch/sys_proto.h>
> +#include <asm/global_data.h>
> +#include <linux/io.h>
> +#include <asm/mach-imx/boot_mode.h>
> +#include <dwc3-uboot.h>
> +#include <env.h>
> +#include <init.h>
> +#include <fdt_support.h>
> +#include <jffs2/load_kernel.h>
> +#include <miiphy.h>
> +#include <mtd_node.h>
> +#include <usb.h>
> +#include <i2c.h>
> +
> +#if IS_ENABLED(CONFIG_PHYTEC_SOM_DETECTION)
> +#include "../common/imx8m_som_detection.h"
> +#endif
> +
> +DECLARE_GLOBAL_DATA_PTR;

Please audit this, gd isn't referenced for example. Thanks.

--=20
Tom

--D9oIiN4k0Hh+JTnk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaIOMxgAKCRAr4qD1Cr/k
CnGVAP9fHuLSduIwirzQLeEgXAwZS7kmONxtmhipuDah8MpRKQEAlLZfgC3PeHWH
57rBAvozcQhPwUTEL6tCCfxCLPwy9g0=
=jq4x
-----END PGP SIGNATURE-----

--D9oIiN4k0Hh+JTnk--
