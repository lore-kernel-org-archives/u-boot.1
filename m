Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 428D5C3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 20:43:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39DAC87A47;
	Mon,  8 Jan 2024 21:42:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Xb3hFMuk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F2D687942; Mon,  8 Jan 2024 21:42:57 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2779987848
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 21:42:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-67f85fe5632so26091036d6.0
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 12:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704746574; x=1705351374; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QDbPnGXrBS7xwoi3m/W6VJEKOPMl5jxbGjqbR30tX24=;
 b=Xb3hFMukQXDKG33Sl3m0+fzrdPUdxZQALNactNcMzQ96bFg/OVx3aHnFxIyASVKH/o
 v8pUbQty1sfZcVoHKQF9OW0n7VAzVzBbpE2qTw0hKU1STnj8rMbmf8ULNE8WXwm6Nexx
 9qPnPJNnARPF07nB7khL6FzVyHhWVFED5P8GU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704746574; x=1705351374;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QDbPnGXrBS7xwoi3m/W6VJEKOPMl5jxbGjqbR30tX24=;
 b=GE8pzBrAimBG5Pwrb9qM+yDqymq9aOgnI7/sl98Ib+IRBfHG+5ziOhiGQ4r7uhk1Zd
 Ooc7+ErHXM6LYkPfbFJb+FdUDpfCK/ct0m31jK+xGwtHPFSxLo8qu/2NKqtK7Qv2EC9t
 5aU6QEH71HtOCL1QTzsLpBqHIIyTjLLTcDDoGOv75D+J1kEjaH6UR0oukmAT0hq+joWI
 addAIF4oZaS4bQdD0XXavKJeH4el0xriWOGZWggmJOWhgclqW71WqEZV9xWCwVfoVug5
 2otJJwtPFsHM/hMh/R2w0xlMAuCzHCBktL2S4fAqYW2dPSlDXYTi9xsOMdB5VT26fHK1
 bjsw==
X-Gm-Message-State: AOJu0Yznb8766c7NA/6nNKTpGL+MxuzhTG+/ldXm+Udqffa66hkkioJN
 ZOBCkSv5uQ7ctXsp6vMKGDYeTGFL3SgNvQ==
X-Google-Smtp-Source: AGHT+IEqhMrzm1a2GQBxJ5h0BRSC9N2MUlYA8+ijNh79ZYC7ccRKPGK1NpgxxY1HQJTVGKD/kzBfzg==
X-Received: by 2002:ad4:5943:0:b0:681:144a:5548 with SMTP id
 eo3-20020ad45943000000b00681144a5548mr90022qvb.31.1704746573889; 
 Mon, 08 Jan 2024 12:42:53 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 z7-20020ad44147000000b0067f07683decsm280555qvp.99.2024.01.08.12.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 12:42:53 -0800 (PST)
Date: Mon, 8 Jan 2024 15:42:51 -0500
From: Tom Rini <trini@konsulko.com>
To: Kongyang Liu <seashell11234455@gmail.com>
Cc: u-boot@lists.denx.de, Bin Meng <bmeng@tinylab.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo <ycliang@andestech.com>, Michal Simek <michal.simek@amd.com>,
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>,
 Samuel Holland <samuel@sholland.org>, Shengyu Qu <wiagn233@outlook.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>
Subject: Re: [PATCH 1/4] riscv: sophgo: milkv_duo: initial support added
Message-ID: <20240108204251.GP1610741@bill-the-cat>
References: <20240107112713.61966-1-seashell11234455@gmail.com>
 <20240107112713.61966-2-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wXz7zjVXe/ZSeG1D"
Content-Disposition: inline
In-Reply-To: <20240107112713.61966-2-seashell11234455@gmail.com>
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


--wXz7zjVXe/ZSeG1D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 07, 2024 at 07:27:07PM +0800, Kongyang Liu wrote:

> Add support for Sophgo's Milk-V Duo board, only minimal device tree and
> serial console are enabled, and it can boot via vendor first stage
> bootloader.
>=20
> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
>=20
> ---
>=20
>  arch/riscv/Kconfig                 |  4 ++++
>  board/sophgo/milkv_duo/Kconfig     | 28 ++++++++++++++++++++++++++++
>  board/sophgo/milkv_duo/MAINTAINERS |  6 ++++++
>  board/sophgo/milkv_duo/Makefile    |  5 +++++
>  board/sophgo/milkv_duo/board.c     |  9 +++++++++
>  include/configs/milkv_duo.h        | 16 ++++++++++++++++

The defconfig patch should be folded in to this one.

[snip]
> diff --git a/board/sophgo/milkv_duo/board.c b/board/sophgo/milkv_duo/boar=
d.c
> new file mode 100644
> index 0000000000..eaa47be173
> --- /dev/null
> +++ b/board/sophgo/milkv_duo/board.c
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
> + */
> +
> +int board_init(void)
> +{
> +	return 0;
> +}

Shouldn't you enable caches here?

> diff --git a/include/configs/milkv_duo.h b/include/configs/milkv_duo.h
> new file mode 100644
> index 0000000000..dd1d146c50
> --- /dev/null
> +++ b/include/configs/milkv_duo.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
> + *
> + */
> +
> +#ifndef __CONFIG_H
> +#define __CONFIG_H
> +
> +#define CFG_SYS_SDRAM_BASE         0x80000000
> +
> +#define CFG_EXTRA_ENV_SETTINGS                 \
> +	"consoledev=3DttyS0"                         \
> +	"baudrate=3D115200\0"                        \

We shouldn't need to set baudrate, it will be handled for us. Is
consoledev something that must be set? Can it all be done in a plain
text environment anyhow? Thanks.

--=20
Tom

--wXz7zjVXe/ZSeG1D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWcXkgACgkQFHw5/5Y0
tyyDowv/d9HFAN0s8B9o7hnFtUB/6nPUuE3RoBE7TrVOfTyMUJ+pG5oz68k3mHzc
HnYtPBa6xdpWH5puYejbwmnlZ3V+KogOzSakKbPRTnO/C7SvTWXYR23YegkSJqQ9
tIl9VyA2w/9MSYmc/dTs1YTZ3sEDL3se6eTrdGZGcLKtIyrd2FY2uYSgA1nAd0u/
PWLMIRBx5GnK5xO1zi523+eewhKu4ez4ig/J8y4Rg0zLU8uN6aRJnHIA87Q4IjFH
j18uM27jsPzE6hRAKSp8dh5OQMsf5RDT5YrgkT9A+BKKFxQ7w2BJND7U+nqrHZEx
sE1f1e8/tckzF1MGZXKVoUKByFzp3zB01GfNvkGYm9O1IHV+W4XwnQsQ1dSj/+Ve
yLEYdFx5z2Fyzbyc8uGs5vQNdWVDCvYVbmEgB6O1vEZtZxUK/VtPFL67HYoYFof4
YRyt/N1I8U5lkMBCJM6/vzkQRo6bGVQLK0nF4Lxt79K4bSf5GTm6ge4lp20Fs3KB
gKxoYuUq
=MkHM
-----END PGP SIGNATURE-----

--wXz7zjVXe/ZSeG1D--
