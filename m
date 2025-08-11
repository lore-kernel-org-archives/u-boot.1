Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72914CA0ECD
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 15:25:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D98D482E37;
	Mon, 11 Aug 2025 17:25:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NDUrHtmb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 723DD82E37; Mon, 11 Aug 2025 17:25:22 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2228E83280
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 17:25:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-459d62184c9so26359275e9.1
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 08:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754925919; x=1755530719; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pWqasxKHxlPA09Szn0r5vmdtzPqapyvktVmaOeG4oRI=;
 b=NDUrHtmbIDKcHql6qB/WQZOgfoKA50zYxlG3I4WEILK/0ySQX6cJdpka/djo/t/Iqm
 A01uQj5bd8ySZWTzko7SkJLlrfxxsQ39a/617v737Nw3BB26GtSzCzdeARXZG7Auq7X2
 BS0ERh2BVM44daF+sJGc8+l+CHp0s9+EypKmaPuLBKog7hk9bp3jYn2yrD5MlCUVBSUe
 qVbxGA5z/ja7Q18jwDsokgsB4ui0v70D4Xbmzp4X7yT9Uc1h8/TRIfCx+/BFLc9K36yo
 J8aChe3RD9UbsaGHMwlglnc/GSSvIh8021k/qlVcfg4g2MFzkFr5zqEDLrYV9dAL6wxb
 hvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754925919; x=1755530719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pWqasxKHxlPA09Szn0r5vmdtzPqapyvktVmaOeG4oRI=;
 b=OchfOcNVdKp5xaxHiReWHFi2hZleoq6CFMPddNh/pP4+q4iznHkQqWpdHeHH53YTAY
 MXVgX5bk4MCNJ2YOQLtFXOVVZxGLub5UkrS4N01+sTaQ0P/kHLRx2wz6Cibi+jizU3Ql
 8i7XWkwzYuD5Dh+DPAB7NpBwUQpclAhONpn9U3UILBqFp+CGRNUaCAnBU7qSTe5eCX47
 szRCYaTKZpUFK0AIUEzaH1ingw4eLXdPE25uZxhPH0ijQuQ48Zp1T6PwjkUzR52oVgu+
 6GdBwzBX+oUpJIedEMufgLI0JaAn6FhMuAdv4AyEs3SQ8sZ6kHqH4QpC7DmkUKNaP8JN
 jhQQ==
X-Gm-Message-State: AOJu0YwqtBGa68oYpHdtUjlelpieGotYzWQXLuvO9IEKYWu5TG+LUzoE
 2N4pMnxqru7nkrqCF58pvZG2adm+x3h4iCMXuO5ZHsNQxgwyJ8je7iYkuw2Syw==
X-Gm-Gg: ASbGncuaETQGc/At/epAWRCuNWQPNcAb/8yOSPzqAqgT3HfrMp6MnzKvXgnJavQxYBt
 u45XyAZoyMnHw4hZb3Sx4BHpVpA8dr0ZhO5cuZLbXiXTPc0CVndSoxhf5SlBPe5l1rzf5g296at
 BU90X5mY/GegamGljwiO+++3pK16wqxH45xvHyUmEij8E3iQhJCqpqZxTYRxcyBMuu6BANWf2hv
 XPReYRxrFNuGQE27pOZaTQzkMAH8KAZkgpVqmhxwtrsDrCJqfTYvCVbF7vIIwS9hWn8bzPETuBM
 93P2sc9U//FOW+TR3JnD37EZWNNEu1TTFD01NB/KXKYk+LPizQokSutPZ7d31PH5I21lKENJdH5
 eA1IqoijLq6pu3YKdfuF6WA8WpxB9rO1cbDWICy7Ha5HbULMAm90ZV1H8XgYKm8mGC97A1k8qLg
 ==
X-Google-Smtp-Source: AGHT+IEcUX3iCjh2QpYFQipY2wnUYWpLpi3xJnhB/8ZjADct2G8pOqxPy4ZSCSS4G6iuXm+cRKZbMA==
X-Received: by 2002:a05:600c:4f4f:b0:442:c993:6f94 with SMTP id
 5b1f17b1804b1-45a10baf652mr1440215e9.12.1754925919190; 
 Mon, 11 Aug 2025 08:25:19 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net.
 [86.58.6.171]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e58400f5sm254803195e9.2.2025.08.11.08.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 08:25:17 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Rudi Horn <dyn-git@rudi-horn.de>
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 linux-sunxi <linux-sunxi@lists.linux.dev>
Subject: Re: [PATCH] Fix detection of odd memory configurations on sunxi
Date: Mon, 11 Aug 2025 17:25:15 +0200
Message-ID: <1927944.tdWV9SEqCh@jernej-laptop>
In-Reply-To: <56f44755-fca8-4364-905e-685e79fd1aea@rudi-horn.de>
References: <56f44755-fca8-4364-905e-685e79fd1aea@rudi-horn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Hi,

CC: Andre, Jagan, linux-sunxi (maintainers and customary linux-sunxi ML)

Dne ponedeljek, 11. avgust 2025 ob 09:35:19 Srednjeevropski poletni =C4=8Da=
s je Rudi Horn napisal(a):
> Hello,
>=20
> I encountered a bug where u-boot detects that my OrangePI zero 3 (with=20
> 1.5GB)
> has 2GB and crashes.=20

This is known missing feature, but you can also call it a bug. Anyway...

> The orangepi u-boot source code contains an additional
> modification in the `mctl_calc_size` which removes a quarter of the=20
> memory the
> calculated last address cannot be written to:
>=20
> https://github.com/orangepi-xunlong/u-boot-orangepi/blob/v2024.01/arch/ar=
m/mach-sunxi/dram_sun50i_h616.c#L1365-L1368
>=20
> I'm not entirely sure if there is some specific logic that applies to this
> modifier, but it does fix the issue on my system.
>=20
> I propose the following patch, but am open to any further suggestions.

This is pretty neat solution. Please send proper submission according to ru=
les
with fixes below.

>=20
> Thanks,
> Rudi Horn
>=20
> Note: Submitted in my personal capacity and is not affiliated with my=20
> employer.
>=20
>=20
>  From 2199f3b28e5fc853ed1921586358c33f3f1502d3 Mon Sep 17 00:00:00 2001
> From: Rudi Horn <dyn-git@rudi-horn.de>
> Date: Mon, 11 Aug 2025 08:58:34 +0200
> Subject: [PATCH] arch: arm: mach-sonxi: Fix detection of odd memory
>   configurations

sonxi -> sunxi

However, better prefix would be "sunxi: H616: dram:" (based on git log.)

>=20
> Fix detection of odd memory configurations. Previously 1.5GB devices were
> incorrectly detected as 2GB devices, causing u-boot to crash.
>=20
> Signed-off-by: Rudi Horn <dyn-git@rudi-horn.de>
> ---
>   arch/arm/include/asm/arch-sunxi/dram.h |  1 +
>   arch/arm/mach-sunxi/dram_dw_helpers.c  | 10 +++++++++-
>   arch/arm/mach-sunxi/dram_helpers.c     |  8 ++++++++
>   3 files changed, 18 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/include/asm/arch-sunxi/dram.h=20
> b/arch/arm/include/asm/arch-sunxi/dram.h
> index 0eccb1e6c28..7580421ca77 100644
> --- a/arch/arm/include/asm/arch-sunxi/dram.h
> +++ b/arch/arm/include/asm/arch-sunxi/dram.h
> @@ -44,6 +44,7 @@
>   unsigned long sunxi_dram_init(void);
>   void mctl_await_completion(u32 *reg, u32 mask, u32 val);
>   bool mctl_mem_matches(u32 offset);
> +bool mctl_mem_matches_upto(u32 offset);

I don't see a benefit for public function here, since it's unlikely to be
used anywhere else. Just mark it static. Compiler can optimize it better.

>   bool mctl_mem_matches_base(u32 offset, ulong base);
>=20
>   #endif /* _SUNXI_DRAM_H */
> diff --git a/arch/arm/mach-sunxi/dram_dw_helpers.c=20
> b/arch/arm/mach-sunxi/dram_dw_helpers.c
> index 24767354935..5bcd2672465 100644
> --- a/arch/arm/mach-sunxi/dram_dw_helpers.c
> +++ b/arch/arm/mach-sunxi/dram_dw_helpers.c
> @@ -146,5 +146,13 @@ unsigned long mctl_calc_size(const struct=20
> dram_config *config)
>          u8 width =3D config->bus_full_width ? 4 : 2;
>=20
>          /* 8 banks */
> -       return (1ULL << (config->cols + config->rows + 3)) * width *=20
> config->ranks;
> +       unsigned long size =3D (1ULL << (config->cols + config->rows + 3)=
)=20
> * width * config->ranks;
> +
> +       /* some memory configurations such as 1.5GB rely on this to=20
> compute the correct size */
> +       if (!mctl_mem_matches_upto(size)) {
> +               size =3D (size * 3) / 4;
> +               debug("capping memory at 0x%lx\n", size);

Maybe test again? It seems to me a bit dangerous to just assume that it
will work. If it fails, panic() should be called.

Best regards,
Jernej

> +       }
> +
> +  return size;
>   }
> diff --git a/arch/arm/mach-sunxi/dram_helpers.c=20
> b/arch/arm/mach-sunxi/dram_helpers.c
> index 83dbe4ca98f..68c75fa07a6 100644
> --- a/arch/arm/mach-sunxi/dram_helpers.c
> +++ b/arch/arm/mach-sunxi/dram_helpers.c
> @@ -61,4 +61,12 @@ bool mctl_mem_matches(u32 offset)
>   {
>          return mctl_mem_matches_base(offset, CFG_SYS_SDRAM_BASE);
>   }
> +
> +/*
> + * Test if memory at offset matches memory at end of DRAM
> + */
> +bool mctl_mem_matches_upto(u32 offset)
> +{
> +       return mctl_mem_matches_base(offset - sizeof(u32),=20
> CFG_SYS_SDRAM_BASE);
> +}
>   #endif
> --
> 2.43.0
>=20
>=20




