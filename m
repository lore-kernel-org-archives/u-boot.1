Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19FE6C7EE30
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 15:15:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4764080E9A;
	Thu, 26 Jun 2025 17:15:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rQQH7N8r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20B5C82063; Thu, 26 Jun 2025 17:15:01 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61C96809A5
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 17:14:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-407aaace4daso598032b6e.2
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 08:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750950892; x=1751555692; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lLefVLTcezq3Bnz4slqp/zBCj8+z3xjdthBuaXokLZY=;
 b=rQQH7N8rZKF1eUDy8jQSV2le5BNdmje/3AQfZO8mnATqnUVp0RdxzK/t/598kSvYWb
 tfhJELav1QYHFC210T5H7mrXnyXMx2PtwMFmK9AgbuiDRq1csI/j2xMV6IS0lGt5+9NI
 QKhg5iLJYJC2ZNZ6VWp/bQoUzNg7bFHgH3csI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750950892; x=1751555692;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lLefVLTcezq3Bnz4slqp/zBCj8+z3xjdthBuaXokLZY=;
 b=cEbKRtk+Toq9RV1iPYBrLF4XHe1amAQ7pkFnrkvkXKT1hPNIA/m3iXUcW41jTBgm4z
 yj3H3ecd+LjTAQOpFI3LMva4MCJsAbRVN1WvgfpuEawMnPJivhrjErwvwFwHtD4ua4vH
 r59gBviI4qhll/t45iOI6ogy8UAUIk/ugm9ff2mOVljPO8c6plrmc9rKRxBqOC9qRqA/
 6y5XzP4hnPMP7PmkDgC9t2W8eO5dsqBFzIUMNzzGaL/D4y+vEjnVcDYGNOGMH5sxpEPG
 MIIeXZPfJAh+tQmIfh/xhglHsMrEVi/jZn7Gp6IVxgp3cgNSqHbFCcJHDSC7w4GJDUFq
 p6QQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3pQRmHCQxlXuJ26b5i2LyhZmCzPvfGzgGDjWc4gN2fD1/BoytF0V3Uevpcpp86xhlcUlwJLs=@lists.denx.de
X-Gm-Message-State: AOJu0Yy3JpLdDJDb4dlmlN+qjmIy7ZvgvWqRLZ7onhty6Yyi24cC/zp7
 cjNT24QpPcYkukpbfDvbttkIarbrZTS5x+UHRfRF+TnJUZeFgFv6SDE1XEWGF9QJuI4=
X-Gm-Gg: ASbGncs98NiIMz82DYn1/Bj2Zky2eGVxpkYwntW32KQDb88oTgLAZS7PlozgTT0IGPE
 jrauOnw1xsrFF8jXwxxk21ChsfZGyOvB9AuxDd5r7qJ5ZF66rn48R50aOIpLpya40SgSUGtzkMR
 AuQaFaDzVPREZieCl7Dv1dT2XdNTimnaB8bpudopE6W4ij4PGxKEUxLif2qXrNFrRhnf2teZg+N
 n3V9mPTD9tdXKeeu9kPMjBGGd/ovLvS/e4fH5aTEXGzqhEjBf2wzsNjGDxohhR0ZswFHTKca0hC
 em1/aawc+CAqjKmN7s2dFtH0VVbSTqeZKEisn3CmiU7mjkyDp6orrxYTsldpfwfi2jYvroX/5Em
 MgYkTBYUfRbMOEt+VgMMm9UU=
X-Google-Smtp-Source: AGHT+IGT8jIuJGagh2fZgoyiPUQk3Rm0NBCSoc+WlR2tKWUvaQxUsfsxSVFl4Hwpu7Iq6b+xZsHmNA==
X-Received: by 2002:a05:6808:1645:b0:40a:526e:5e7a with SMTP id
 5614622812f47-40b05c1589fmr5808097b6e.23.1750950891952; 
 Thu, 26 Jun 2025 08:14:51 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b322ae4b1sm152b6e.15.2025.06.26.08.14.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 08:14:50 -0700 (PDT)
Date: Thu, 26 Jun 2025 09:14:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, jh80.chung@samsung.com,
 ilias.apalodimas@linaro.org, rui.silva@linaro.org, me@samcday.com,
 quic_varada@quicinc.com, sughosh.ganu@linaro.org,
 miquel.raynal@bootlin.com, balaji.selvanathan@oss.qualcomm.com,
 sjg@chromium.org, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/4] power-domain: Add QCOM RPMH Power Domain Driver
 Support
Message-ID: <20250626151448.GV4003484@bill-the-cat>
References: <20250626112441.143064-1-aswin.murugan@oss.qualcomm.com>
 <20250626112441.143064-2-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9P4wW/3DvwOCwKp8"
Content-Disposition: inline
In-Reply-To: <20250626112441.143064-2-aswin.murugan@oss.qualcomm.com>
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


--9P4wW/3DvwOCwKp8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 04:54:38PM +0530, Aswin Murugan wrote:

> Added support for Qualcomm RPMH power domain driver, responsible
> for managing power domains on Qualcomm SoCs. This is a port of
> the Linux RPMHPD driver [1] and sa8775p related changes. The
> power domain driver currently has support to power on and off
> MMCX power domain; support for other power domains can be added
> in this driver.
>=20
> [1]:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/pmdomain/qcom/rpmhpd.c?id=3D3d25d46a255a83f94d7d4d4216f38aafc8e1=
16b
>=20
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>  drivers/power/domain/Kconfig       |   8 +
>  drivers/power/domain/Makefile      |   1 +
>  drivers/power/domain/qcom-rpmhpd.c | 271 +++++++++++++++++++++++++++++
>  3 files changed, 280 insertions(+)
>  create mode 100644 drivers/power/domain/qcom-rpmhpd.c
>=20
> diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
> index 5f5218bd8b5..2e246c5bb73 100644
> --- a/drivers/power/domain/Kconfig
> +++ b/drivers/power/domain/Kconfig
> @@ -82,6 +82,14 @@ config MESON_SECURE_POWER_DOMAIN
>  	  Enable support for manipulating Amlogic Meson Secure power domains.
>  	  Support for Amlogic A1 series.
> =20
> +config QCOM_POWER_DOMAIN
> +	bool "Enable the QCOM RPMH Power domain driver"
> +	depends on POWER_DOMAIN
> +	help
> +	  Generic RPMH power domain implementation for QCOM devices.
> +	  The RPMH power domain driver is responsible for managing power
> +	  domains on Qualcomm SoCs.
> +
>  config SANDBOX_POWER_DOMAIN
>  	bool "Enable the sandbox power domain test driver"
>  	depends on POWER_DOMAIN && SANDBOX
> diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/Makefile
> index 4d20c97d26c..ad355f88479 100644
> --- a/drivers/power/domain/Makefile
> +++ b/drivers/power/domain/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_MTK_POWER_DOMAIN) +=3D mtk-power-domain.o
>  obj-$(CONFIG_MESON_GX_VPU_POWER_DOMAIN) +=3D meson-gx-pwrc-vpu.o
>  obj-$(CONFIG_MESON_EE_POWER_DOMAIN) +=3D meson-ee-pwrc.o
>  obj-$(CONFIG_MESON_SECURE_POWER_DOMAIN) +=3D meson-secure-pwrc.o
> +obj-$(CONFIG_QCOM_POWER_DOMAIN) +=3D qcom-rpmhpd.o
>  obj-$(CONFIG_SANDBOX_POWER_DOMAIN) +=3D sandbox-power-domain.o
>  obj-$(CONFIG_SANDBOX_POWER_DOMAIN) +=3D sandbox-power-domain-test.o
>  obj-$(CONFIG_SCMI_POWER_DOMAIN) +=3D scmi-power-domain.o
> diff --git a/drivers/power/domain/qcom-rpmhpd.c b/drivers/power/domain/qc=
om-rpmhpd.c
> new file mode 100644
> index 00000000000..6653995f5ed
> --- /dev/null
> +++ b/drivers/power/domain/qcom-rpmhpd.c
> @@ -0,0 +1,271 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018, The Linux Foundation. All rights reserved.
> +// Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserv=
ed.
> +
> +#include <dm.h>
> +#include <dm/lists.h>
> +#include <power-domain.h>
> +#include <asm/io.h>
> +#include <linux/errno.h>
> +
> +#include <power-domain-uclass.h>
> +#include <soc/qcom/cmd-db.h>
> +#include <soc/qcom/rpmh.h>

This needs to depends on ARCH_SNAPDRAGON in Kconfig as it won't compile
on any other platform due to the includes.

--=20
Tom

--9P4wW/3DvwOCwKp8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhdY+QACgkQFHw5/5Y0
tyxYxAv+KHGyUYzGmOZc/IwuejP/k+j/gtv/1So/JgXHhMSSusFAumxRjPSeCLJr
YBwYXyZh1LbPhkGwm8X6kHwJxWm2CHhwJTy0uRf4tpEb75j/hf+qgte7I3Rfv5sm
yBe3uU4i/A+sfd+k+xfOoyhVvWJ4S/Jp1uR4wnqmgMmyjZ+cssnbONBTxPkFZriw
sF/ISy/a3wuplCTbhQ923UYva11ycV60dK3t5xahnneBZ6WB+kQDaSL6dqEME0ff
/50XDeoO6qQ/wIjOcJaVQOlNx88E1KftVDucTAB/XUiBdYNzahe8NmwkJXssL8SO
+NFADYxLPZitf91aIqsg6dzC0Q8WMdRfp6IUrQ8pPucKeSTOVEhQa28lun8XHI78
hZCMed1EIeCtcToS5FW6IOfQ/0vpkl0rhCUhAYM8FV4XTXxg0v3hj44FBUlS8CB+
JV8TVR1Q51ia2JUVq5VohlAVTGtO+uBfcU+VRu7kgZIwrBoEbX0zD7dqsFZBN7QR
sg94dqrx
=yT5n
-----END PGP SIGNATURE-----

--9P4wW/3DvwOCwKp8--
