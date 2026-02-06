Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5D6ECD98B
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 10:07:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5484E83A64;
	Fri,  6 Feb 2026 11:07:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zn8AsR99";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CB8B83AA7; Fri,  6 Feb 2026 11:07:30 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BBA48382A
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 11:07:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-658381b28e8so673551a12.0
 for <u-boot@lists.denx.de>; Fri, 06 Feb 2026 02:07:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770372447; cv=none;
 d=google.com; s=arc-20240605;
 b=Z5VKuKea37+CyIGIgEn+vMBkw3ViuGO1yrYLeBLeMZ1IQSQNfmSDsZiHhuA5GS8Qd9
 4IN9U8a808aucIlQ52kypkavaNt5h7pzqHStw2VhRnYYid12Y5OKqGHCwe2H6UN8EZUT
 +Cb5nAFlZVD0oyLSFnVWkjneeQt6jGOwx15uZys5ZiEc/vAg98/SRw+3KRmMRIN4aiOE
 +rQeaVHL82Vt7GD3laceL3dqXwxaz7ybnuUdEVGM2X2ztozvM+y7hpJ/f0w1dPBIG/AU
 KjiuVMS8Q+PyjK4u3jmiTyuDcnGMyxJlL5PEPiqo/bWxdII1jFsTkv8XTW+gw90oHxaZ
 vZBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RWcjeJtZ+Zrr2p6HxmDxKwRRhyWYc/ma/Gr7BYrn/kI=;
 fh=GvVXeAGJN7RO4kML8i4oPyGX6iR53ek55vb0k+sVQds=;
 b=YibNkWjgM4c1Eg2lnCKeU1z2AWgO5MKTy6DXRpE7ZQNzsTN3jsOCszojJ6DZBqdt18
 +qg1VJoIOOHlKj9FA216uL4ClvIKvVySRWAt9tEc8YCFPV9MM/Di/RTjKQgs1NHPPJTn
 z3zqnS5XoYAG7LPWm0QwgFcnKzCoKuGy6a/hWOaX8GGAto9Iuey9SgDQx7t5NYqCoAl+
 cmZNf4o8R2LMtcBSILpdSDiy5KY66sWOnTYFqXxgX/seNdytEQlykbrTHfhqmnLa+Gf2
 USvylOb2dxBXRrhsbyLm4MHlfTXW8fBtCyndSh2lwi1eEehg+X/4vO90pBVVlnB9CGBQ
 gS6A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770372447; x=1770977247;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RWcjeJtZ+Zrr2p6HxmDxKwRRhyWYc/ma/Gr7BYrn/kI=;
 b=zn8AsR99J+945ImXOEOYQBdwJWSEhbbQhg7TnKgTs6JCLUihBkQ/Ifp2UcG3uO0F+j
 NGcZ16AhuuLqoGc0LiuGqrR3g/Z6XTeht8xgThEBkT3rH29urAUXEpWLwENOFZ5Rjgcy
 27JtWdcQXSvFiGQAa67h8W49YJ5KrvZwvVPAOwpSCZq1lJQjjg/HmpZnN6ccyuSONkat
 N1xyoWwuZgB7WR+RtIErZtlGf2JQalVzWmnpBea1mlRpHRTIgfRZobiJSDT+qofi8RFX
 2BIrYa8j5In+H0P8e/SZfJqMI9bltJ5psdvbVyEpHWnDnGSzyS6lVdAHHbV3vSvaxlfJ
 Xxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770372447; x=1770977247;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RWcjeJtZ+Zrr2p6HxmDxKwRRhyWYc/ma/Gr7BYrn/kI=;
 b=rTd/ZwS61/bXsegGtuiNTcwbw6k1SF/xDvBudFi1PjbmhpB7h64GspuXsAGN/TOv8v
 yHxiLbiAQDdF4TPwPEHhXwXSE7fghEsKTZBWHnxYshHy49v2EfhZVznoGFnJPbbFTy4O
 1ZnrfZB2Hv/IbpSUezEyIf/NFQ0fJlrpOxe5lX7y84YR9oGJJBqNu7W+ex5ZuMHOg5lF
 A8Up67Z4oDe6T45n52kovYWDii7PcrsYMN1IHcwlnkhdF/ZZf8x943R/TPYj2EAj96dK
 xKSF6ZrEdpaKnByQg8lbZpD41zL0PXXGQizVMFKzXJ+zKlbl03Xf4Ua0BlsPAQdGHnBQ
 XRqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWJryj64qWLJzt0EuIEglUTr+S4r7othwfwmr2lCnPz1/28fe87kUyj+OlVstlmrUMV/fobUM=@lists.denx.de
X-Gm-Message-State: AOJu0YxvXQ74v3WttHEsSqKUsaxhPBgk4WHX0BdbvaPHpu7zMPNHHxeW
 o1RC0JuD9xu4jGvBSeH0uLSyB8CAxRylgoL+RafYk98b4BRVuwo7xj0cFCcOA+YSSo8tKXEfoz7
 TwNERFdZLeqGPIY820y0xCwq5GG3U57Sw+P2Dlq+BOQ==
X-Gm-Gg: AZuq6aJrV0sdh64ypuOeqebcc1AefEx+LJ0w/dayy0hpefK2/uFdiuGxqrYj4AKvnly
 zd0HKPk17bANtpKVOmwyrxQw+/zP48N6xq+cBlK4VmYKvbjw2wQOltexGaPmK0shiWM+iMSG37v
 nR06wPVf7WHNnmZTr8ibTJzFuTCJfanNGqL0SFLuI9HWOt13VjbEqLG9HQ9ZVr59Wvn5taV4j4i
 AmeWpJFAN5vMF698kkoFh5UzzrRK3/jrBU+oaA/DP3Vs6Sl9mIqEVx7eFOS5oW4R8etqmjDm2Gy
 zcRYgunFRRu8p4QLt2jIYdd2iOVA
X-Received: by 2002:a17:907:2da4:b0:b87:2c88:ce40 with SMTP id
 a640c23a62f3a-b8edf1ea38dmr132473266b.27.1770372447348; Fri, 06 Feb 2026
 02:07:27 -0800 (PST)
MIME-Version: 1.0
References: <20260205-mtk-mach-clean-up-duplicates-v1-0-b7d4a43c18eb@baylibre.com>
 <20260205-mtk-mach-clean-up-duplicates-v1-5-b7d4a43c18eb@baylibre.com>
In-Reply-To: <20260205-mtk-mach-clean-up-duplicates-v1-5-b7d4a43c18eb@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 6 Feb 2026 11:07:14 +0100
X-Gm-Features: AZwV_QiRb4Iq_coVmojuydESP2IMZxxh1CfwdT4PJTaNVYIulaC86EuEh4WpvOo
Message-ID: <CAEHHSvasBSDP8S+v5qbiAgJdNH9bvLcogi3oh8FJMgpfQ9VAOg@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm: mediatek: consolidate ARMv8 memory maps
To: David Lechner <dlechner@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Le ven. 6 f=C3=A9vr. 2026 =C3=A0 00:52, David Lechner <dlechner@baylibre.co=
m> a =C3=A9crit :
>
> Consolidate all mem_map definitions for MediaTek ARMv8 platforms into a
> single file. The size of the DDR and MMIO regions can vary, so Kconfig
> options are added to configure them by target.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  arch/arm/mach-mediatek/Kconfig                     | 21 ++++++++++++++++
>  arch/arm/mach-mediatek/Makefile                    |  1 +
>  .../arm/mach-mediatek/armv8-mem-map.c              | 14 ++++-------
>  arch/arm/mach-mediatek/mt7622/init.c               | 20 ---------------
>  arch/arm/mach-mediatek/mt7981/init.c               | 21 ----------------
>  arch/arm/mach-mediatek/mt7986/init.c               | 21 ----------------
>  arch/arm/mach-mediatek/mt7987/init.c               | 21 ----------------
>  arch/arm/mach-mediatek/mt7988/init.c               | 21 ----------------
>  arch/arm/mach-mediatek/mt8183/init.c               | 20 ---------------
>  arch/arm/mach-mediatek/mt8512/init.c               | 21 ----------------
>  arch/arm/mach-mediatek/mt8516/init.c               | 20 ---------------
>  arch/arm/mach-mediatek/mt8518/init.c               | 21 ----------------
>  board/mediatek/mt8365_evk/MAINTAINERS              |  5 ----
>  board/mediatek/mt8365_evk/Makefile                 |  3 ---
>  board/mediatek/mt8390_evk/MAINTAINERS              |  6 -----
>  board/mediatek/mt8390_evk/Makefile                 |  3 ---
>  board/mediatek/mt8390_evk/mt8390_evk.c             | 29 ----------------=
------
>  17 files changed, 27 insertions(+), 241 deletions(-)
>
> diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kcon=
fig
> index d1d2605b2cc..33717a1864f 100644
> --- a/arch/arm/mach-mediatek/Kconfig
> +++ b/arch/arm/mach-mediatek/Kconfig
> @@ -130,6 +130,27 @@ config TARGET_MT8518
>
>  endchoice
>
> +if ARM64
> +
> +config MTK_MEM_MAP_DDR_SIZE
> +       hex "DDR .size in mem_map"
> +       default 0x200000000 if TARGET_MT7987 || TARGET_MT7988 || TARGET_M=
T8188
> +       default 0xc0000000 if TARGET_MT8365
> +       default 0x80000000 if TARGET_MT7981 || TARGET_MT7986 || TARGET_MT=
8183
> +       default 0x40000000 if TARGET_MT7622 || TARGET_MT8512
> +       default 0x20000000
> +       help
> +               Target-specific DDR region size in mem_map.
> +
> +config MTK_MEM_MAP_MMIO_SIZE
> +       hex "MMIO .size in mem_map"
> +       default 0x40000000 if TARGET_MT7622 || TARGET_MT7981 || TARGET_MT=
7986 || TARGET_MT7987 || TARGET_MT7988 || TARGET_MT8512
> +       default 0x20000000
> +       help
> +               Target-specific MMIO region size in mem_map.
> +
> +endif
> +
>  config SYS_BOARD
>         string "Board name"
>         default "mt7622" if TARGET_MT7622
> diff --git a/arch/arm/mach-mediatek/Makefile b/arch/arm/mach-mediatek/Mak=
efile
> index 44591bed6fa..17e645989e5 100644
> --- a/arch/arm/mach-mediatek/Makefile
> +++ b/arch/arm/mach-mediatek/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier:     GPL-2.0
>
> +obj-$(CONFIG_ARM64) +=3D armv8-mem-map.o
>  obj-y  +=3D cpu.o
>  obj-$(CONFIG_MTK_TZ_MOVABLE)   +=3D tzcfg.o
>  obj-$(CONFIG_XPL_BUILD)        +=3D spl.o
> diff --git a/board/mediatek/mt8365_evk/mt8365_evk.c b/arch/arm/mach-media=
tek/armv8-mem-map.c
> similarity index 55%
> rename from board/mediatek/mt8365_evk/mt8365_evk.c
> rename to arch/arm/mach-mediatek/armv8-mem-map.c
> index 41a6febf03d..0abddb99f25 100644
> --- a/board/mediatek/mt8365_evk/mt8365_evk.c
> +++ b/arch/arm/mach-mediatek/armv8-mem-map.c
> @@ -1,22 +1,18 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (C) 2023 BayLibre SAS
> - * Author: Julien Masson <jmasson@baylibre.com>
> - */
> +// SPDX-License-Identifier: GPL-2.0-only
>
>  #include <asm/armv8/mmu.h>
>
> -static struct mm_region mt8365_evk_mem_map[] =3D {
> +static struct mm_region mediatek_mem_map[] =3D {
>         {
>                 /* DDR */
>                 .virt =3D 0x40000000UL,
>                 .phys =3D 0x40000000UL,
> -               .size =3D 0xc0000000UL,
> +               .size =3D CONFIG_MTK_MEM_MAP_DDR_SIZE,
>                 .attrs =3D PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER=
_SHARE,
>         }, {
>                 .virt =3D 0x00000000UL,
>                 .phys =3D 0x00000000UL,
> -               .size =3D 0x20000000UL,
> +               .size =3D CONFIG_MTK_MEM_MAP_MMIO_SIZE,
>                 .attrs =3D PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>                          PTE_BLOCK_NON_SHARE |
>                          PTE_BLOCK_PXN | PTE_BLOCK_UXN
> @@ -25,4 +21,4 @@ static struct mm_region mt8365_evk_mem_map[] =3D {
>         }
>  };
>
> -struct mm_region *mem_map =3D mt8365_evk_mem_map;
> +struct mm_region *mem_map =3D mediatek_mem_map;
> diff --git a/arch/arm/mach-mediatek/mt7622/init.c b/arch/arm/mach-mediate=
k/mt7622/init.c
> index 368f2916224..a043ca87398 100644
> --- a/arch/arm/mach-mediatek/mt7622/init.c
> +++ b/arch/arm/mach-mediatek/mt7622/init.c
> @@ -36,23 +36,3 @@ void reset_cpu(void)
>  {
>         psci_system_reset();
>  }
> -
> -static struct mm_region mt7622_mem_map[] =3D {
> -       {
> -               /* DDR */
> -               .virt =3D 0x40000000UL,
> -               .phys =3D 0x40000000UL,
> -               .size =3D 0x40000000UL,
> -               .attrs =3D PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER=
_SHARE,
> -       }, {
> -               .virt =3D 0x00000000UL,
> -               .phys =3D 0x00000000UL,
> -               .size =3D 0x40000000UL,
> -               .attrs =3D PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> -                        PTE_BLOCK_NON_SHARE |
> -                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> -       }, {
> -               0,
> -       }
> -};
> -struct mm_region *mem_map =3D mt7622_mem_map;
> diff --git a/arch/arm/mach-mediatek/mt7981/init.c b/arch/arm/mach-mediate=
k/mt7981/init.c
> index 07da5897190..79afd6ce6be 100644
> --- a/arch/arm/mach-mediatek/mt7981/init.c
> +++ b/arch/arm/mach-mediatek/mt7981/init.c
> @@ -30,24 +30,3 @@ void reset_cpu(void)
>  {
>         psci_system_reset();
>  }
> -
> -static struct mm_region mt7981_mem_map[] =3D {
> -       {
> -               /* DDR */
> -               .virt =3D 0x40000000UL,
> -               .phys =3D 0x40000000UL,
> -               .size =3D 0x80000000UL,
> -               .attrs =3D PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER=
_SHARE,
> -       }, {
> -               .virt =3D 0x00000000UL,
> -               .phys =3D 0x00000000UL,
> -               .size =3D 0x40000000UL,
> -               .attrs =3D PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> -                        PTE_BLOCK_NON_SHARE |
> -                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> -       }, {
> -               0,
> -       }
> -};
> -
> -struct mm_region *mem_map =3D mt7981_mem_map;
> diff --git a/arch/arm/mach-mediatek/mt7986/init.c b/arch/arm/mach-mediate=
k/mt7986/init.c
> index a521c95bd9d..1fe56b3f145 100644
> --- a/arch/arm/mach-mediatek/mt7986/init.c
> +++ b/arch/arm/mach-mediatek/mt7986/init.c
> @@ -30,24 +30,3 @@ void reset_cpu(void)
>  {
>         psci_system_reset();
>  }
> -
> -static struct mm_region mt7986_mem_map[] =3D {
> -       {
> -               /* DDR */
> -               .virt =3D 0x40000000UL,
> -               .phys =3D 0x40000000UL,
> -               .size =3D 0x80000000UL,
> -               .attrs =3D PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER=
_SHARE,
> -       }, {
> -               .virt =3D 0x00000000UL,
> -               .phys =3D 0x00000000UL,
> -               .size =3D 0x40000000UL,
> -               .attrs =3D PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> -                        PTE_BLOCK_NON_SHARE |
> -                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> -       }, {
> -               0,
> -       }
> -};
> -
> -struct mm_region *mem_map =3D mt7986_mem_map;
> diff --git a/arch/arm/mach-mediatek/mt7987/init.c b/arch/arm/mach-mediate=
k/mt7987/init.c
> index 8b268297809..6364ab497f7 100644
> --- a/arch/arm/mach-mediatek/mt7987/init.c
> +++ b/arch/arm/mach-mediatek/mt7987/init.c
> @@ -39,24 +39,3 @@ void reset_cpu(ulong addr)
>  {
>         psci_system_reset();
>  }
> -
> -static struct mm_region mt7987_mem_map[] =3D {
> -       {
> -               /* DDR */
> -               .virt =3D 0x40000000UL,
> -               .phys =3D 0x40000000UL,
> -               .size =3D 0x200000000ULL,
> -               .attrs =3D PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER=
_SHARE,
> -       }, {
> -               .virt =3D 0x00000000UL,
> -               .phys =3D 0x00000000UL,
> -               .size =3D 0x40000000UL,
> -               .attrs =3D PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> -                        PTE_BLOCK_NON_SHARE |
> -                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> -       }, {
> -               0,
> -       }
> -};
> -
> -struct mm_region *mem_map =3D mt7987_mem_map;
> diff --git a/arch/arm/mach-mediatek/mt7988/init.c b/arch/arm/mach-mediate=
k/mt7988/init.c
> index 8bdd3848d26..7ff843585ec 100644
> --- a/arch/arm/mach-mediatek/mt7988/init.c
> +++ b/arch/arm/mach-mediatek/mt7988/init.c
> @@ -38,24 +38,3 @@ void reset_cpu(ulong addr)
>  {
>         psci_system_reset();
>  }
> -
> -static struct mm_region mt7988_mem_map[] =3D {
> -       {
> -               /* DDR */
> -               .virt =3D 0x40000000UL,
> -               .phys =3D 0x40000000UL,
> -               .size =3D 0x200000000ULL,
> -               .attrs =3D PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER=
_SHARE,
> -       }, {
> -               .virt =3D 0x00000000UL,
> -               .phys =3D 0x00000000UL,
> -               .size =3D 0x40000000UL,
> -               .attrs =3D PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> -                        PTE_BLOCK_NON_SHARE |
> -                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> -       }, {
> -               0,
> -       }
> -};
> -
> -struct mm_region *mem_map =3D mt7988_mem_map;
> diff --git a/arch/arm/mach-mediatek/mt8183/init.c b/arch/arm/mach-mediate=
k/mt8183/init.c
> index b445f3ea1e3..8dbf9c3df7e 100644
> --- a/arch/arm/mach-mediatek/mt8183/init.c
> +++ b/arch/arm/mach-mediatek/mt8183/init.c
> @@ -47,23 +47,3 @@ int print_cpuinfo(void)
>         printf("CPU:   MediaTek MT8183\n");
>         return 0;
>  }
> -
> -static struct mm_region mt8183_mem_map[] =3D {
> -       {
> -               /* DDR */
> -               .virt =3D 0x40000000UL,
> -               .phys =3D 0x40000000UL,
> -               .size =3D 0x80000000UL,
> -               .attrs =3D PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER=
_SHARE,
> -       }, {
> -               .virt =3D 0x00000000UL,
> -               .phys =3D 0x00000000UL,
> -               .size =3D 0x20000000UL,
> -               .attrs =3D PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> -                        PTE_BLOCK_NON_SHARE |
> -                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> -       }, {
> -               0,
> -       }
> -};
> -struct mm_region *mem_map =3D mt8183_mem_map;
> diff --git a/arch/arm/mach-mediatek/mt8512/init.c b/arch/arm/mach-mediate=
k/mt8512/init.c
> index 3b48caf5196..361c589cbc2 100644
> --- a/arch/arm/mach-mediatek/mt8512/init.c
> +++ b/arch/arm/mach-mediatek/mt8512/init.c
> @@ -59,24 +59,3 @@ int print_cpuinfo(void)
>         debug("CPU:   MediaTek MT8512\n");
>         return 0;
>  }
> -
> -static struct mm_region mt8512_mem_map[] =3D {
> -       {
> -               /* DDR */
> -               .virt =3D 0x40000000UL,
> -               .phys =3D 0x40000000UL,
> -               .size =3D 0x40000000UL,
> -               .attrs =3D PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER=
_SHARE,
> -       }, {
> -               .virt =3D 0x00000000UL,
> -               .phys =3D 0x00000000UL,
> -               .size =3D 0x40000000UL,
> -               .attrs =3D PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> -                        PTE_BLOCK_NON_SHARE |
> -                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> -       }, {
> -               0,
> -       }
> -};
> -
> -struct mm_region *mem_map =3D mt8512_mem_map;
> diff --git a/arch/arm/mach-mediatek/mt8516/init.c b/arch/arm/mach-mediate=
k/mt8516/init.c
> index 82f8c509745..1d925dd478a 100644
> --- a/arch/arm/mach-mediatek/mt8516/init.c
> +++ b/arch/arm/mach-mediatek/mt8516/init.c
> @@ -94,23 +94,3 @@ int print_cpuinfo(void)
>         printf("CPU:   MediaTek MT8516\n");
>         return 0;
>  }
> -
> -static struct mm_region mt8516_mem_map[] =3D {
> -       {
> -               /* DDR */
> -               .virt =3D 0x40000000UL,
> -               .phys =3D 0x40000000UL,
> -               .size =3D 0x20000000UL,
> -               .attrs =3D PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER=
_SHARE,
> -       }, {
> -               .virt =3D 0x00000000UL,
> -               .phys =3D 0x00000000UL,
> -               .size =3D 0x20000000UL,
> -               .attrs =3D PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> -                        PTE_BLOCK_NON_SHARE |
> -                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> -       }, {
> -               0,
> -       }
> -};
> -struct mm_region *mem_map =3D mt8516_mem_map;
> diff --git a/arch/arm/mach-mediatek/mt8518/init.c b/arch/arm/mach-mediate=
k/mt8518/init.c
> index c04bcb63517..8fa1346021a 100644
> --- a/arch/arm/mach-mediatek/mt8518/init.c
> +++ b/arch/arm/mach-mediatek/mt8518/init.c
> @@ -51,24 +51,3 @@ int print_cpuinfo(void)
>         printf("CPU:   MediaTek MT8518\n");
>         return 0;
>  }
> -
> -static struct mm_region mt8518_mem_map[] =3D {
> -       {
> -               /* DDR */
> -               .virt =3D 0x40000000UL,
> -               .phys =3D 0x40000000UL,
> -               .size =3D 0x20000000UL,
> -               .attrs =3D PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER=
_SHARE,
> -       }, {
> -               .virt =3D 0x00000000UL,
> -               .phys =3D 0x00000000UL,
> -               .size =3D 0x20000000UL,
> -               .attrs =3D PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> -                        PTE_BLOCK_NON_SHARE |
> -                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> -       }, {
> -               0,
> -       }
> -};
> -
> -struct mm_region *mem_map =3D mt8518_mem_map;
> diff --git a/board/mediatek/mt8365_evk/MAINTAINERS b/board/mediatek/mt836=
5_evk/MAINTAINERS
> deleted file mode 100644
> index e0d65efe812..00000000000
> --- a/board/mediatek/mt8365_evk/MAINTAINERS
> +++ /dev/null

Hi David,

You are removing board/mediatek/mt8365_evk directory (and mt8390_evk
below), so you left mt8365_evk_defconfig (and mt8365_evk_defconfig)
without any entries in MAINTAINERS files.
So maybe we should add them to the MAINTAINERS file at the root directory?

Also, if there is no more board directory for these boards, I think we
should remove CONFIG_SYS_BOARD=3D"mt8365_evk" and
CONFIG_SYS_BOARD=3D"mt8390_evk"  from their respective defconfig file,
as it should be empty if no board directory exist.

I also notice that board/mediatek/{mt7620/mt621/mt7628} only contain
the MAINTAINERS file, without any board specific code. Maybe we can
take the opportunity to clean them as part of this series?

Cheers
Julien

> @@ -1,5 +0,0 @@
> -MT8365 EVK
> -M:     Julien Masson <jmasson@baylibre.com>
> -S:     Maintained
> -F:     board/mediatek/mt8365_evk/
> -F:     configs/mt8365_evk_defconfig
> diff --git a/board/mediatek/mt8365_evk/Makefile b/board/mediatek/mt8365_e=
vk/Makefile
> deleted file mode 100644
> index 90fc92b28c5..00000000000
> --- a/board/mediatek/mt8365_evk/Makefile
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -# SPDX-License-Identifier:     GPL-2.0
> -
> -obj-y +=3D mt8365_evk.o
> diff --git a/board/mediatek/mt8390_evk/MAINTAINERS b/board/mediatek/mt839=
0_evk/MAINTAINERS
> deleted file mode 100644
> index d46b8b2e156..00000000000
> --- a/board/mediatek/mt8390_evk/MAINTAINERS
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -MT8390 EVK
> -M:     Julien Masson <jmasson@baylibre.com>
> -M:     Macpaul Lin <Macpaul.Lin@mediatek.com>
> -S:     Maintained
> -F:     board/mediatek/mt8390_evk/
> -F:     configs/mt8390_evk_defconfig
> diff --git a/board/mediatek/mt8390_evk/Makefile b/board/mediatek/mt8390_e=
vk/Makefile
> deleted file mode 100644
> index a26d46838c4..00000000000
> --- a/board/mediatek/mt8390_evk/Makefile
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -# SPDX-License-Identifier:     GPL-2.0
> -
> -obj-y +=3D mt8390_evk.o
> diff --git a/board/mediatek/mt8390_evk/mt8390_evk.c b/board/mediatek/mt83=
90_evk/mt8390_evk.c
> deleted file mode 100644
> index 5731199bf83..00000000000
> --- a/board/mediatek/mt8390_evk/mt8390_evk.c
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (C) 2026 BayLibre SAS
> - * Author: Julien Masson <jmasson@baylibre.com>
> - */
> -
> -#include <linux/types.h>
> -#include <asm/armv8/mmu.h>
> -
> -static struct mm_region mt8390_evk_mem_map[] =3D {
> -       {
> -               /* DDR */
> -               .virt =3D 0x40000000UL,
> -               .phys =3D 0x40000000UL,
> -               .size =3D 0x200000000UL,
> -               .attrs =3D PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER=
_SHARE,
> -       }, {
> -               .virt =3D 0x00000000UL,
> -               .phys =3D 0x00000000UL,
> -               .size =3D 0x20000000UL,
> -               .attrs =3D PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> -                        PTE_BLOCK_NON_SHARE |
> -                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> -       }, {
> -               0,
> -       }
> -};
> -
> -struct mm_region *mem_map =3D mt8390_evk_mem_map;
>
> --
> 2.43.0
>
