Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1224DC27C77
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 16:46:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44C00883F5;
	Wed, 12 Jun 2024 18:46:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jsDgbaYn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7FF78880E; Wed, 12 Jun 2024 18:46:36 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4142088363
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 18:46:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-254d001d03dso6062fac.3
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 09:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718210793; x=1718815593; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9RpLCBIipm6cMhjmdWAnNAQFuxLlknJ6dVHI94Ozbn0=;
 b=jsDgbaYn2RYCQw6EglBkyWAGOEE+cw6TeqOH+zGngh6eMEHEcuHBKpvaW1mFQVSJHZ
 GT5RN7x68bAet2GRD5haiB5mUEZOI8ArWnfMluCBXuVdWhYo6un73/dmOtyHLHCMXcJb
 qaWI3z07wQg+TZ9oc9PYt6oFPvXax6yknROR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718210793; x=1718815593;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9RpLCBIipm6cMhjmdWAnNAQFuxLlknJ6dVHI94Ozbn0=;
 b=N/GDjhjuwuCuktTLW1vBXUrg0rbYeaZk+lRAhATMSHb2KCAkBkI/aY7ZFQKHAxlNHN
 3Y0hB8K0HPMEHmJ5z05uMiMlVG5hZojCdoU1wQZpQVhGv+zGXgGLNE3pvQfviz7rYhT+
 qyEf8qW9tj7Gqt3fhaKDI8EVmK4nwDP5hBHvxclH0YI/zzOW2ZaKYGiIqlQfC4TGIVZZ
 tisw7ffM2P5njxt81rl17kjLT0Jx69LauMY+Qxe9qXPVeE33qAqyS8HnDjxs4nXvdz+7
 ONflCUMNxV7sMCYv2xoaiPxWc4QPdMd2uqJI4QQKLfztY64TzEDveJk2zq7Pj0I2cDNa
 XiHA==
X-Gm-Message-State: AOJu0YyNCL+/SjqjYRJVPZJZ1oEHiNgSSS6zWZ3p8hCLNry37KFM9N4C
 ly6KxpI9cNuLCZm0X5tHBKF8Xz4YYl/p9DD98sjX9tf4T5sW1wIvvxdmN7Zw34E=
X-Google-Smtp-Source: AGHT+IEfB8DIrocSBgFGwqOiSWya/3zgOJQXm9V8qvPTDmi8KU7qs20PLDFfXD8gTxjQFJUE4SlJ6g==
X-Received: by 2002:a05:6870:ac11:b0:254:7dbe:1b81 with SMTP id
 586e51a60fabf-25514d23e46mr2587504fac.20.1718210792854; 
 Wed, 12 Jun 2024 09:46:32 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-254b562dac6sm1904934fac.50.2024.06.12.09.46.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 09:46:32 -0700 (PDT)
Date: Wed, 12 Jun 2024 10:46:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Jayesh Choudhary <j-choudhary@ti.com>
Cc: u-boot@lists.denx.de, jh80.chung@samsung.com, lukma@denx.de,
 seanga2@gmail.com, vaishnav.a@ti.com, n-francis@ti.com,
 u-kumar1@ti.com, sumit.garg@linaro.org, afd@ti.com, vigneshr@ti.com,
 nm@ti.com, bb@ti.com, rogerq@kernel.org
Subject: Re: [PATCH v2 13/14] configs: introduce configs needed for the J722S
Message-ID: <20240612164629.GC68077@bill-the-cat>
References: <20240612091123.253835-1-j-choudhary@ti.com>
 <20240612091123.253835-14-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Qmad+NgTC2jreAeS"
Content-Disposition: inline
In-Reply-To: <20240612091123.253835-14-j-choudhary@ti.com>
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


--Qmad+NgTC2jreAeS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 02:41:22PM +0530, Jayesh Choudhary wrote:

> Introduce the initial configs needed to support the J722S SoC family.
>=20
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>  configs/j722s_evm_a53_defconfig | 172 ++++++++++++++++++++++++++++++++
>  configs/j722s_evm_r5_defconfig  | 131 ++++++++++++++++++++++++
>  include/configs/j722s_evm.h     |  14 +++
>  3 files changed, 317 insertions(+)
>  create mode 100644 configs/j722s_evm_a53_defconfig
>  create mode 100644 configs/j722s_evm_r5_defconfig
>  create mode 100644 include/configs/j722s_evm.h
[snip]
> diff --git a/include/configs/j722s_evm.h b/include/configs/j722s_evm.h
> new file mode 100644
> index 0000000000..10f2e2d3ed
> --- /dev/null
> +++ b/include/configs/j722s_evm.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Configuration header file for K3 J722S SoC family
> + *
> + * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.co=
m/
> + */
> +
> +#ifndef __CONFIG_J722S_EVM_H
> +#define __CONFIG_J722S_EVM_H
> +
> +/* Now for the remaining common defines */
> +#include <configs/ti_armv7_common.h>
> +
> +#endif /* __CONFIG_J722S_EVM_H */

If there's any other feedback and you need to do a v3, instead of
#include <configs/ti_armv7_common.h> here just define CFG_SYS_SDRAM_BASE
as that's the only thing in the common header that new platforms should
need.

--=20
Tom

--Qmad+NgTC2jreAeS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZp0N8ACgkQFHw5/5Y0
tywyTQwAnSZOSZ5O4JUyyKw+XWYO9B07WOcruR3bBf6GD2HM4Kqseil5nCtKSQ+D
+EsoxtGSwb4Rtyze7XhNribR66GQXwSF/2Nh6EoXGpEqtyVzRaGAN/9o3f9TFzMc
695R+U4rqGFzqYUo+BcQamQix8MhzHXghXCHukn8XQrfhFTkfRguxQM0Im6VeVCD
o0Xnnz+I7JAAhCnsspHwSPE57NoZwXDGUZXmEl2opp3t2YjFXEx/myNOkjTxi2Ln
cJqmf+JYU85ni3cPZrzmqew6WYPZmOsiJJW7OJ18ToFJ3VDy1DTIdAcq1+JgI4FD
JDvKNHcCRUYYGgbUgCVLp119g0WDRYSLSoliMSndtbQIxUm+L4byiM1g0L6AXdze
1Ff+6rQkGSA74WwqL0uC5tf3WJOAuBqjMo/Nykn84WLzZtDQ4sCupwOw9z3Gbkdh
wP2S48a8HXVfNi0Li6m/OFy34pexj+LYr6qm355vNcj1pv9NaXZJcg/+oBMLym8j
/plBzkOO
=1aPj
-----END PGP SIGNATURE-----

--Qmad+NgTC2jreAeS--
