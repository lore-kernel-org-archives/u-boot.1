Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B05CC5B549
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 14:09:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94CF780584;
	Wed,  4 Jun 2025 16:09:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DeWpsCtD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B3788070C; Wed,  4 Jun 2025 16:09:55 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FB068006D
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 16:09:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-72bc3987a05so649225a34.1
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 07:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749046192; x=1749650992; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=c9nZonbRnnxCw3wRFLbYuoqaI40metgX+wBZ5r0sAds=;
 b=DeWpsCtDbWWldMaBobBmTylpDKAhfuqV2N+Yu8G32rMuQ5Cxc/AZ138VUsOYcYWbLs
 RBJY7F2rXJO8lWVAwlYBgPZkkA31f3nTqo/3NGrBnAT60MWS0iZT8G5FTPJeC6Q8gHH4
 UAXqT54MeBZwUI9s7IzVx4mmOUr8/AIHMk5VU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749046192; x=1749650992;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c9nZonbRnnxCw3wRFLbYuoqaI40metgX+wBZ5r0sAds=;
 b=kahx7Qq5VCnp0myeKsVdnENs2EfIoPF9FgGv2U2N2N63f8NcCjAYbqKnawIlTOy32g
 qhkXugLpdoDhDWIqFzRQuZJ+phiIIJOook+sZlkv3OFxT8vUbes+vz4ZwXfYUaw47aAo
 UCtAEWaozn4obUL9FUE6Q+ahElr9vrAJYqDo6xNW6hBPEGj5IcY0U50KyXSVIz6HLt4H
 f0JGO/JMaICCFTdqj7BunxdA0+d/mcmwiOsnYzQOwrEUycBVXK2SLebVvAATJIdUd7Sf
 UQ9hkJT8YKjqJPL85Byq+UY9DCfbuXRwtz5UPKAkbcoDHPfm/gP78GNQKzq0As99dA2l
 EeyQ==
X-Gm-Message-State: AOJu0Yw2eTX9aMeZiX1NLCjtHvfSIBlxpdV/kMfKE0vAo+0lzDrWBW4O
 /7W5aPNmxrFng0HRc5xbW9req2Vc+zSDQ6wYXrTj12GOdwc0TLsI06T70zpxqFaiYVKd0tI9Nue
 Wq7MFiZ0=
X-Gm-Gg: ASbGncsh2u3RU4ahOIQnfOgxFgG9ulonyniiULdCsS1iPE4K5cfNbt2DEWl4wk1wEKt
 AMJ2HRI+MhrnfSShIQdj7dlFbIP7n6cQ3217+6ewl7wM/0IEF+awA0/N0aAUcbtAVhWxNfeLO89
 faSEYIO/xeuM8HoeTgxyZ2URaHDFqAbG61aTWpbyKuker9wQ6yORIpVv6SNWI8YarkIZM0iYaSg
 ZU86/Kpgev3pN75lBpI/N3X5KnHJBbgK13MjjgoLpJ7N34keWPfxeo4y4Oj/dkYDd32P4ldk+Xv
 2bDKlDCCdZcXbcosNXKR/seVJUZSQthQvHhO3P7qGIm/R5wgYSMXwmxtxCct32pKAaskzSrKO79
 C0fHMm/YeeCouQINZwPmtSZg=
X-Google-Smtp-Source: AGHT+IHQ4JOzOHo6N0DjImBXputIueciNEW1pQvnc3+uq2qcTEHUqR8Ryq/ZyU4ADAboL8ZOrvVeug==
X-Received: by 2002:a05:6830:4981:b0:72b:9140:f6d9 with SMTP id
 46e09a7af769-7386a07a780mr2781026a34.4.1749046192003; 
 Wed, 04 Jun 2025 07:09:52 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-735af8780b1sm2205858a34.35.2025.06.04.07.09.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 07:09:51 -0700 (PDT)
Date: Wed, 4 Jun 2025 08:09:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>,
 Manuel Traut <manuel.traut@mt.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v7] arm: imx: Add support for Mettler-Toledo snowflake
 board
Message-ID: <20250604140949.GO1382132@bill-the-cat>
References: <20250604112507.11358-2-Wojciech.Dubowik@mt.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qX7QXnX/I6d6oDR6"
Content-Disposition: inline
In-Reply-To: <20250604112507.11358-2-Wojciech.Dubowik@mt.com>
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


--qX7QXnX/I6d6oDR6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 04, 2025 at 01:25:05PM +0200, Wojciech Dubowik wrote:

> From: Manuel Traut <manuel.traut@mt.com>
>=20
> The board is similar to "Kontron SL i.MX 8M Mini" SoM.
> There are two variants. Snowflake_v2 has an external SDCard Interface.
> LEIG is the same but without display and with emmc card only.
> Both variants support 1GiB of main memory.
>=20
> [ bigeasy: porting and a bit of cleanup ]
>=20
> Signed-off-by: Manuel Traut <manuel.traut@mt.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
[snip]
>  arch/arm/dts/imx8mm-mt-snowflake-v2.dts       |  127 ++

What's the upstream status of this dts?

[snip]
> +&i2c1 {
> +	status =3D "okay";
> +	bootph-all;
> +	bootph-pre-ram;
> +};

The bootph properties have been upstreamed and can go in the main dts
file. Also, you don't need both.

[snip]
> diff --git a/include/configs/snowflake_v2.h b/include/configs/snowflake_v=
2.h
> new file mode 100644
> index 000000000000..eccd01fc8ecd
> --- /dev/null
> +++ b/include/configs/snowflake_v2.h
> @@ -0,0 +1,117 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2019 Kontron Electronics GmbH
> + * Copyright (C) 2020 Mettler-Toledo GmbH
> + *
> + * Configuration settings for the MT Snowflake v2 Terminal, based on Kon=
tron
> + * "Kontron SL i.MX 8M Mini" SoM.
> + */
> +#ifndef __SNOWFLAKE_V2_IMX8M_MINI_H
> +#define __SNOWFLAKE_V2_IMX8M_MINI_H
> +
> +#include <asm/arch/imx-regs.h>
> +#include <linux/sizes.h>
> +
> +#ifdef CONFIG_XPL_BUILD
> +#include <config.h>
> +#endif

That's not allowed / valid. This file here is config.h.

> +
> +/*
> + * #######################################
> + * ### RAM                             ###
> + * #######################################
> + */
> +#define CFG_SYS_INIT_RAM_ADDR		0x40000000
> +#define CFG_SYS_INIT_RAM_SIZE		SZ_2M
> +
> +#if defined(CONFIG_ENV_IS_IN_MMC)
> +/* Environment in eMMC, before config block at the end of 1st "boot sect=
or" */
> +#endif

Please clean that up.

> +
> +#define CFG_SYS_SDRAM_BASE		0x40000000
> +
> +/* SDRAM configuration */
> +#define PHYS_SDRAM			0x40000000
> +#define PHYS_SDRAM_SIZE			SZ_1G /* 1GB DDR */
> +
> +/* GUID for capsule updatable firmware image */
> +#define MT_SNOWFLAKE_V2_FIT_IMAGE_GUID \
> +	EFI_GUID(0x3EEAE649, 0x202d, 0x5feb, 0xb6, 0x94, \
> +		 0x2d, 0x75, 0x06, 0x52, 0xc6, 0x40)
> +
> +#ifndef CONFIG_XPL_BUILD

That's not allowed and..

> +
> +#define MEM_LAYOUT_ENV_SETTINGS \

Please move to using a plain text environment (board/foo/bar/bar.env).

Thanks.

--=20
Tom

--qX7QXnX/I6d6oDR6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhAU6YACgkQFHw5/5Y0
tyzhkQv9EutqLx7gJOKAQ0EpDBEbub0k8+vlz5vlR6cK0WRwBe5F109nFxxFWSa+
9pKazKTGinFs+q/Y8J6D1CkuNdsLu+Ycuv0Yb0dWuF2LMuY3kGx0912h9ptiMbJe
P/dbLdIscK9F+CmJwcNCrNKw9sI7aM90k3b1z0z+msAtpYdIzp22CZYSqG00CP2g
DNOyi3pbQacBegrrrxjTGZAmYekFM4/T3VpubS8ktnA0u4L/uvt1dtTHJBrbCpRF
3EEA/zjHHEQsG7OveN9uawyATUsEjF3EFmbSHZObAPjf6j8a65Q0aNO5OUv2VCad
hiEWZAr/+zqyCuvKDd+T/UQ/l9Edfn7cqERzkhz4efKpuXiFp+ie94GzkHCPlDtu
aVmPu7vEK1QHNDkYrmC3NP4ystT8hclWLFAGyJcHbHJOO5wW+Vt9z+Rh2Vr0kn82
PMRH1pm/6YyY9q2d2a2+AVI1FZmpJi4d8Je1ykk1AvhL0ELBz78vR2tJG6TdgR4V
O2446+HV
=17Cl
-----END PGP SIGNATURE-----

--qX7QXnX/I6d6oDR6--
