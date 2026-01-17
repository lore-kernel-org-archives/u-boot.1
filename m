Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B31FC98318
	for <u-boot@archiver.kernel.org>; Sat, 17 Jan 2026 10:43:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 416D9833C6;
	Sat, 17 Jan 2026 11:43:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IrlfheQx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3DD38367F; Sat, 17 Jan 2026 11:43:39 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A83B483015
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 11:43:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-64b7318f1b0so4407147a12.2
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 02:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768646616; x=1769251416; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VLQed1GABNNlIWbaP8NKRdJncArUqq5BVyJTgG2QnVs=;
 b=IrlfheQxQuYAuEogp/SxwIPKoWgMfwjfQ4IhhgEXjLTQmXBDUonjDPSVP9HqqFMPyQ
 Cm4VbuK2dt+SbcOt+asLR++Vav5eQGYx79IgE0Od72DMCsEK9ZoQ+O7hTMP2LV/YcaGN
 CelvRbpViz1p/sRm37AwyBCHz1Q9g6OM5T2UIoG48iwnvzzNhJ7PjVe1tO6dGuPHA97Z
 /NIMC9A5kLihuw6QTNYE0jYfTZH3VJcERKft55UrzmlWAq9gNAY9i98QiE/L9kJK9us+
 Di8AliTU6S8AdRRs9G5IRqyJ3m9Ip1vTF7e4s66T+hzd+WrpJCkXtac6ahD8K5kEYzQZ
 rpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768646616; x=1769251416;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VLQed1GABNNlIWbaP8NKRdJncArUqq5BVyJTgG2QnVs=;
 b=FE+twTLb+bXIwcsEO8Dem1soPbzSHiMuK45AnTtoeFuKv18y7hwgUz738UX4r5ElF1
 8eyTxJNgpsKHls+qiyAIR8QiaHAqcOcDZQ3XwZQ18YIOrEdB/Nn9veRQeSmqbbTwdxV5
 Oa+xWGOjvv2VZycZWve0CsAxqrKBA/nje7Gv06CKe7lVeyvAe0wFo5qp3RhQZ3UTy8bw
 vVuB3I12rQZtZTS2oz9y62cIYcTl2iag9m/2c/WjQa6mZMcj/C5ZPn6+elXO3U1g4096
 NHCyKUpa6SIadSqazni1EjY++QFKRVJQmydepuiO8sTt01EMIXYGwL0zQaVIGbt2IuaZ
 hj1Q==
X-Gm-Message-State: AOJu0YyH6Rhx5GbkvvjdbchudQ9rEGQ4HoaVeu4pfntuRLxbPIJ0JR9C
 MDiFDWpv+r7Sp6daFT6GcLb2dt0PJCVRY+gGpzx7uNpwEPRusUEvaxrKCIv3lAaN+OU4WZmVWTH
 yQJKgUh4bNkzcQnTkb/23gk5HcpBYrFM=
X-Gm-Gg: AY/fxX4cdxmm+tIW0wT+FgLrkFic8w9ah+6yv4xwCrDOBxVXCILCJahQyVpz1Y5l5Xb
 yDjHPQ7pe7wxsi4ZhJLB6zTB9zRILGgXcde9T6PBeDLXoof6m5TORrsP2qN5Cx7ZfvDi0BWDzKC
 mVLXE6PWmIFb924KeaZb2X6CoG4hepYCgeL9W+HZkzQ3m9SV1d63o87JbGQQ958fyiu3DJxd/Tf
 cubnb+1NpaX7IeoEB9ATjW85XREVsx73F2MIa5fM2dZwJkduj6pGUGWuwNEUKtR1PPiffLNNj2A
 r/IjlE4=
X-Received: by 2002:a05:6402:1e8c:b0:653:eb48:7e4d with SMTP id
 4fb4d7f45d1cf-654ba3bc76bmr4419685a12.15.1768646615369; Sat, 17 Jan 2026
 02:43:35 -0800 (PST)
MIME-Version: 1.0
References: <20260115212723.3926453-1-trini@konsulko.com>
In-Reply-To: <20260115212723.3926453-1-trini@konsulko.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Sat, 17 Jan 2026 17:43:23 +0700
X-Gm-Features: AZwV_QhTKsFBHzjiz0rJX4GgoMuji3PszHWgdskMI_Bch0Tqq-4g7rJ-t3B1TIk
Message-ID: <CAJaLiFzGoY=Kyz94LMYA_b0OcOXemiqf_QbN4fyqNBFBbkjsxw@mail.gmail.com>
Subject: Re: [PATCH] arm: Remove remainder of ARCH_ORION5X
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Fri, Jan 16, 2026 at 4:35=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> With commit 5663b137e682 ("arm: Remove edminiv2 board") the last
> ARCH_ORION5X platform was removed. Remove the rest of the architecture
> code which is now unused.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Tony Dinh <mibodhi@gmail.com>

All the best,
Tony

> ---
>  arch/arm/Kconfig                              |   9 -
>  arch/arm/Makefile                             |   1 -
>  arch/arm/mach-orion5x/Kconfig                 |  13 -
>  arch/arm/mach-orion5x/Makefile                |  26 --
>  arch/arm/mach-orion5x/cpu.c                   | 297 ------------------
>  arch/arm/mach-orion5x/dram.c                  |  57 ----
>  arch/arm/mach-orion5x/include/mach/cpu.h      | 242 --------------
>  .../arm/mach-orion5x/include/mach/mv88f5182.h |  23 --
>  arch/arm/mach-orion5x/include/mach/orion5x.h  |  66 ----
>  arch/arm/mach-orion5x/lowlevel_init.S         | 286 -----------------
>  arch/arm/mach-orion5x/timer.c                 | 174 ----------
>  arch/arm/mach-orion5x/u-boot-spl.lds          |  60 ----
>  drivers/i2c/mvtwsi.c                          |   4 +-
>  drivers/net/Kconfig                           |   2 +-
>  drivers/net/mvgbe.c                           |   5 -
>  drivers/usb/host/Kconfig                      |   2 +-
>  drivers/usb/host/ehci-marvell.c               |   2 -
>  include/configs/mv-common.h                   |   1 -
>  18 files changed, 3 insertions(+), 1267 deletions(-)
>  delete mode 100644 arch/arm/mach-orion5x/Kconfig
>  delete mode 100644 arch/arm/mach-orion5x/Makefile
>  delete mode 100644 arch/arm/mach-orion5x/cpu.c
>  delete mode 100644 arch/arm/mach-orion5x/dram.c
>  delete mode 100644 arch/arm/mach-orion5x/include/mach/cpu.h
>  delete mode 100644 arch/arm/mach-orion5x/include/mach/mv88f5182.h
>  delete mode 100644 arch/arm/mach-orion5x/include/mach/orion5x.h
>  delete mode 100644 arch/arm/mach-orion5x/lowlevel_init.S
>  delete mode 100644 arch/arm/mach-orion5x/timer.c
>  delete mode 100644 arch/arm/mach-orion5x/u-boot-spl.lds
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 0485fe78e10b..aba950ad05da 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -670,13 +670,6 @@ config ARCH_MVEBU
>         select SPI
>         imply CMD_DM
>
> -config ARCH_ORION5X
> -       bool "Marvell Orion"
> -       select CPU_ARM926EJS
> -       select GPIO_EXTRA_HEADER
> -       select SPL_SEPARATE_BSS if SPL
> -       select TIMER
> -
>  config ARCH_BCM283X
>         bool "Broadcom BCM283X family"
>         select CPU
> @@ -2346,8 +2339,6 @@ source "arch/arm/mach-omap2/Kconfig"
>
>  source "arch/arm/cpu/armv8/fsl-layerscape/Kconfig"
>
> -source "arch/arm/mach-orion5x/Kconfig"
> -
>  source "arch/arm/mach-owl/Kconfig"
>
>  source "arch/arm/mach-renesas/Kconfig"
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 5ecadb2ef1bc..b36b07425809 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -75,7 +75,6 @@ machine-$(CONFIG_ARCH_MVEBU)          +=3D mvebu
>  machine-$(CONFIG_ARCH_NEXELL)          +=3D nexell
>  machine-$(CONFIG_ARCH_NPCM)             +=3D npcm
>  machine-$(CONFIG_ARCH_OMAP2PLUS)       +=3D omap2
> -machine-$(CONFIG_ARCH_ORION5X)         +=3D orion5x
>  machine-$(CONFIG_ARCH_OWL)             +=3D owl
>  machine-$(CONFIG_ARCH_RENESAS)         +=3D renesas
>  machine-$(CONFIG_ARCH_ROCKCHIP)                +=3D rockchip
> diff --git a/arch/arm/mach-orion5x/Kconfig b/arch/arm/mach-orion5x/Kconfi=
g
> deleted file mode 100644
> index e677211b2e91..000000000000
> --- a/arch/arm/mach-orion5x/Kconfig
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -if ARCH_ORION5X
> -
> -config 88F5182
> -       bool
> -
> -config FEROCEON
> -       bool
> -
> -config SYS_SOC
> -       default "orion5x"
> -
> -
> -endif
> diff --git a/arch/arm/mach-orion5x/Makefile b/arch/arm/mach-orion5x/Makef=
ile
> deleted file mode 100644
> index d0769b55efa4..000000000000
> --- a/arch/arm/mach-orion5x/Makefile
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0+
> -#
> -# Copyright (C) 2010 Albert ARIBAUD <albert.u.boot@aribaud.net>
> -#
> -# Based on original Kirkwood support which is
> -# (C) Copyright 2009
> -# Marvell Semiconductor <www.marvell.com>
> -# Written-by: Prafulla Wadaskar <prafulla@marvell.com>
> -
> -obj-y  =3D cpu.o
> -obj-y  +=3D dram.o
> -obj-y  +=3D timer.o
> -
> -ifndef CONFIG_$(PHASE_)SKIP_LOWLEVEL_INIT
> -obj-y  +=3D lowlevel_init.o
> -endif
> -
> -# some files can only build in ARM or THUMB2, not THUMB1
> -
> -ifdef CONFIG_$(PHASE_)SYS_THUMB_BUILD
> -ifndef CONFIG_HAS_THUMB2
> -
> -CFLAGS_cpu.o :=3D -marm
> -
> -endif
> -endif
> diff --git a/arch/arm/mach-orion5x/cpu.c b/arch/arm/mach-orion5x/cpu.c
> deleted file mode 100644
> index 4eba69a69090..000000000000
> --- a/arch/arm/mach-orion5x/cpu.c
> +++ /dev/null
> @@ -1,297 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * Copyright (C) 2010 Albert ARIBAUD <albert.u.boot@aribaud.net>
> - *
> - * Based on original Kirkwood support which is
> - * (C) Copyright 2009
> - * Marvell Semiconductor <www.marvell.com>
> - * Written-by: Prafulla Wadaskar <prafulla@marvell.com>
> - */
> -
> -#include <cpu_func.h>
> -#include <init.h>
> -#include <net.h>
> -#include <netdev.h>
> -#include <asm/cache.h>
> -#include <asm/io.h>
> -#include <u-boot/md5.h>
> -#include <asm/arch/cpu.h>
> -
> -#define BUFLEN 16
> -
> -void reset_cpu(void)
> -{
> -       struct orion5x_cpu_registers *cpureg =3D
> -           (struct orion5x_cpu_registers *)ORION5X_CPU_REG_BASE;
> -
> -       writel(readl(&cpureg->rstoutn_mask) | (1 << 2),
> -               &cpureg->rstoutn_mask);
> -       writel(readl(&cpureg->sys_soft_rst) | 1,
> -               &cpureg->sys_soft_rst);
> -       while (1)
> -               ;
> -}
> -
> -/*
> - * Compute Window Size field value from size expressed in bytes
> - * Used with the Base register to set the address window size and locati=
on.
> - * Must be programmed from LSB to MSB as sequence of ones followed by
> - * sequence of zeros. The number of ones specifies the size of the windo=
w in
> - * 64 KiB granularity (e.g., a value of 0x00FF specifies 256 =3D 16 MiB)=
.
> - * NOTES:
> - * 1) A sizeval equal to 0x0 specifies 4 GiB.
> - * 2) A return value of 0x0 specifies 64 KiB.
> - */
> -unsigned int orion5x_winctrl_calcsize(unsigned int sizeval)
> -{
> -       /*
> -        * Calculate the number of 64 KiB blocks needed minus one (roundi=
ng up).
> -        * For sizeval > 0 this is equivalent to:
> -        * sizeval =3D (u32) ceil((double) sizeval / 65536.0) - 1
> -        */
> -       sizeval =3D (sizeval - 1) >> 16;
> -
> -       /*
> -        * Propagate 'one' bits to the right by 'oring' them.
> -        * We need only treat bits 15-0.
> -        */
> -       sizeval |=3D sizeval >> 1;  /* 'Or' bit 15 onto bit 14 */
> -       sizeval |=3D sizeval >> 2;  /* 'Or' bits 15-14 onto bits 13-12 */
> -       sizeval |=3D sizeval >> 4;  /* 'Or' bits 15-12 onto bits 11-8 */
> -       sizeval |=3D sizeval >> 8;  /* 'Or' bits 15-8 onto bits 7-0*/
> -
> -       return sizeval;
> -}
> -
> -/*
> - * orion5x_config_adr_windows - Configure address Windows
> - *
> - * There are 8 address windows supported by Orion5x Soc to addess differ=
ent
> - * devices. Each window can be configured for size, BAR and remap addr
> - * Below configuration is standard for most of the cases
> - *
> - * If remap function not used, remap_lo must be set as base
> - *
> - * NOTES:
> - *
> - * 1) in order to avoid windows with inconsistent control and base value=
s
> - *    (which could prevent access to BOOTCS and hence execution from FLA=
SH)
> - *    always disable window before writing the base value then reenable =
it
> - *    by writing the control value.
> - *
> - * 2) in order to avoid losing access to BOOTCS when disabling window 7,
> - *    first configure window 6 for BOOTCS, then configure window 7 for B=
OOTCS,
> - *    then configure windows 6 for its own target.
> - *
> - * Reference Documentation:
> - * Mbus-L to Mbus Bridge Registers Configuration.
> - * (Sec 25.1 and 25.3 of Datasheet)
> - */
> -int orion5x_config_adr_windows(void)
> -{
> -       struct orion5x_win_registers *winregs =3D
> -               (struct orion5x_win_registers *)ORION5X_CPU_WIN_BASE;
> -
> -/* Disable window 0, configure it for its intended target, enable it. */
> -       writel(0, &winregs[0].ctrl);
> -       writel(ORION5X_ADR_PCIE_MEM, &winregs[0].base);
> -       writel(ORION5X_ADR_PCIE_MEM_REMAP_LO, &winregs[0].remap_lo);
> -       writel(ORION5X_ADR_PCIE_MEM_REMAP_HI, &winregs[0].remap_hi);
> -       writel(ORION5X_CPU_WIN_CTRL_DATA(ORION5X_SZ_PCIE_MEM,
> -               ORION5X_TARGET_PCIE, ORION5X_ATTR_PCIE_MEM,
> -               ORION5X_WIN_ENABLE), &winregs[0].ctrl);
> -/* Disable window 1, configure it for its intended target, enable it. */
> -       writel(0, &winregs[1].ctrl);
> -       writel(ORION5X_ADR_PCIE_IO, &winregs[1].base);
> -       writel(ORION5X_ADR_PCIE_IO_REMAP_LO, &winregs[1].remap_lo);
> -       writel(ORION5X_ADR_PCIE_IO_REMAP_HI, &winregs[1].remap_hi);
> -       writel(ORION5X_CPU_WIN_CTRL_DATA(ORION5X_SZ_PCIE_IO,
> -               ORION5X_TARGET_PCIE, ORION5X_ATTR_PCIE_IO,
> -               ORION5X_WIN_ENABLE), &winregs[1].ctrl);
> -/* Disable window 2, configure it for its intended target, enable it. */
> -       writel(0, &winregs[2].ctrl);
> -       writel(ORION5X_ADR_PCI_MEM, &winregs[2].base);
> -       writel(ORION5X_CPU_WIN_CTRL_DATA(ORION5X_SZ_PCI_MEM,
> -               ORION5X_TARGET_PCI, ORION5X_ATTR_PCI_MEM,
> -               ORION5X_WIN_ENABLE), &winregs[2].ctrl);
> -/* Disable window 3, configure it for its intended target, enable it. */
> -       writel(0, &winregs[3].ctrl);
> -       writel(ORION5X_ADR_PCI_IO, &winregs[3].base);
> -       writel(ORION5X_CPU_WIN_CTRL_DATA(ORION5X_SZ_PCI_IO,
> -               ORION5X_TARGET_PCI, ORION5X_ATTR_PCI_IO,
> -               ORION5X_WIN_ENABLE), &winregs[3].ctrl);
> -/* Disable window 4, configure it for its intended target, enable it. */
> -       writel(0, &winregs[4].ctrl);
> -       writel(ORION5X_ADR_DEV_CS0, &winregs[4].base);
> -       writel(ORION5X_CPU_WIN_CTRL_DATA(ORION5X_SZ_DEV_CS0,
> -               ORION5X_TARGET_DEVICE, ORION5X_ATTR_DEV_CS0,
> -               ORION5X_WIN_ENABLE), &winregs[4].ctrl);
> -/* Disable window 5, configure it for its intended target, enable it. */
> -       writel(0, &winregs[5].ctrl);
> -       writel(ORION5X_ADR_DEV_CS1, &winregs[5].base);
> -       writel(ORION5X_CPU_WIN_CTRL_DATA(ORION5X_SZ_DEV_CS1,
> -               ORION5X_TARGET_DEVICE, ORION5X_ATTR_DEV_CS1,
> -               ORION5X_WIN_ENABLE), &winregs[5].ctrl);
> -/* Disable window 6, configure it for FLASH, enable it. */
> -       writel(0, &winregs[6].ctrl);
> -       writel(ORION5X_ADR_BOOTROM, &winregs[6].base);
> -       writel(ORION5X_CPU_WIN_CTRL_DATA(ORION5X_SZ_BOOTROM,
> -               ORION5X_TARGET_DEVICE, ORION5X_ATTR_BOOTROM,
> -               ORION5X_WIN_ENABLE), &winregs[6].ctrl);
> -/* Disable window 7, configure it for FLASH, enable it. */
> -       writel(0, &winregs[7].ctrl);
> -       writel(ORION5X_ADR_BOOTROM, &winregs[7].base);
> -       writel(ORION5X_CPU_WIN_CTRL_DATA(ORION5X_SZ_BOOTROM,
> -               ORION5X_TARGET_DEVICE, ORION5X_ATTR_BOOTROM,
> -               ORION5X_WIN_ENABLE), &winregs[7].ctrl);
> -/* Disable window 6, configure it for its intended target, enable it. */
> -       writel(0, &winregs[6].ctrl);
> -       writel(ORION5X_ADR_DEV_CS2, &winregs[6].base);
> -       writel(ORION5X_CPU_WIN_CTRL_DATA(ORION5X_SZ_DEV_CS2,
> -               ORION5X_TARGET_DEVICE, ORION5X_ATTR_DEV_CS2,
> -               ORION5X_WIN_ENABLE), &winregs[6].ctrl);
> -
> -       return 0;
> -}
> -
> -/*
> - * Orion5x identification is done through PCIE space.
> - */
> -
> -u32 orion5x_device_id(void)
> -{
> -       return readl(PCIE_DEV_ID_OFF) >> 16;
> -}
> -
> -u32 orion5x_device_rev(void)
> -{
> -       return readl(PCIE_DEV_REV_OFF) & 0xff;
> -}
> -
> -#if defined(CONFIG_DISPLAY_CPUINFO)
> -
> -/* Display device and revision IDs.
> - * This function must cover all known device/revision
> - * combinations, not only the one for which u-boot is
> - * compiled; this way, one can identify actual HW in
> - * case of a mismatch.
> - */
> -int print_cpuinfo(void)
> -{
> -       char dev_str[7]; /* room enough for 0x0000 plus null byte */
> -       char rev_str[5]; /* room enough for 0x00 plus null byte */
> -       char *dev_name =3D NULL;
> -       char *rev_name =3D NULL;
> -
> -       u32 dev =3D orion5x_device_id();
> -       u32 rev =3D orion5x_device_rev();
> -
> -       if (dev =3D=3D MV88F5181_DEV_ID) {
> -               dev_name =3D "MV88F5181";
> -               if (rev =3D=3D MV88F5181_REV_B1)
> -                       rev_name =3D "B1";
> -               else if (rev =3D=3D MV88F5181L_REV_A1) {
> -                       dev_name =3D "MV88F5181L";
> -                       rev_name =3D "A1";
> -               } else if (rev =3D=3D MV88F5181L_REV_A0) {
> -                       dev_name =3D "MV88F5181L";
> -                       rev_name =3D "A0";
> -               }
> -       } else if (dev =3D=3D MV88F5182_DEV_ID) {
> -               dev_name =3D "MV88F5182";
> -               if (rev =3D=3D MV88F5182_REV_A2)
> -                       rev_name =3D "A2";
> -       } else if (dev =3D=3D MV88F5281_DEV_ID) {
> -               dev_name =3D "MV88F5281";
> -               if (rev =3D=3D MV88F5281_REV_D2)
> -                       rev_name =3D "D2";
> -               else if (rev =3D=3D MV88F5281_REV_D1)
> -                       rev_name =3D "D1";
> -               else if (rev =3D=3D MV88F5281_REV_D0)
> -                       rev_name =3D "D0";
> -       } else if (dev =3D=3D MV88F6183_DEV_ID) {
> -               dev_name =3D "MV88F6183";
> -               if (rev =3D=3D MV88F6183_REV_B0)
> -                       rev_name =3D "B0";
> -       }
> -       if (dev_name =3D=3D NULL) {
> -               sprintf(dev_str, "0x%04x", dev);
> -               dev_name =3D dev_str;
> -       }
> -       if (rev_name =3D=3D NULL) {
> -               sprintf(rev_str, "0x%02x", rev);
> -               rev_name =3D rev_str;
> -       }
> -
> -       printf("SoC:   Orion5x %s-%s\n", dev_name, rev_name);
> -
> -       return 0;
> -}
> -#endif /* CONFIG_DISPLAY_CPUINFO */
> -
> -#ifdef CONFIG_ARCH_CPU_INIT
> -int arch_cpu_init(void)
> -{
> -       /* Enable and invalidate L2 cache in write through mode */
> -       invalidate_l2_cache();
> -
> -#ifdef CONFIG_XPL_BUILD
> -       orion5x_config_adr_windows();
> -#endif
> -
> -       return 0;
> -}
> -#endif /* CONFIG_ARCH_CPU_INIT */
> -
> -/*
> - * SOC specific misc init
> - */
> -#if defined(CONFIG_ARCH_MISC_INIT)
> -int arch_misc_init(void)
> -{
> -       u32 temp;
> -
> -       /*CPU streaming & write allocate */
> -       temp =3D readfr_extra_feature_reg();
> -       temp &=3D ~(1 << 28);     /* disable wr alloc */
> -       writefr_extra_feature_reg(temp);
> -
> -       temp =3D readfr_extra_feature_reg();
> -       temp &=3D ~(1 << 29);     /* streaming disabled */
> -       writefr_extra_feature_reg(temp);
> -
> -       /* L2Cache settings */
> -       temp =3D readfr_extra_feature_reg();
> -       /* Disable L2C pre fetch - Set bit 24 */
> -       temp |=3D (1 << 24);
> -       /* enable L2C - Set bit 22 */
> -       temp |=3D (1 << 22);
> -       writefr_extra_feature_reg(temp);
> -
> -       icache_enable();
> -       /* Change reset vector to address 0x0 */
> -       temp =3D get_cr();
> -       set_cr(temp & ~CR_V);
> -
> -       /* Set CPIOs and MPPs - values provided by board
> -          include file */
> -       writel(ORION5X_MPP0_7, ORION5X_MPP_BASE+0x00);
> -       writel(ORION5X_MPP8_15, ORION5X_MPP_BASE+0x04);
> -       writel(ORION5X_MPP16_23, ORION5X_MPP_BASE+0x50);
> -       writel(ORION5X_GPIO_OUT_VALUE, ORION5X_GPIO_BASE+0x00);
> -       writel(ORION5X_GPIO_OUT_ENABLE, ORION5X_GPIO_BASE+0x04);
> -       writel(ORION5X_GPIO_IN_POLARITY, ORION5X_GPIO_BASE+0x0c);
> -
> -       /* initialize timer */
> -       timer_init_r();
> -       return 0;
> -}
> -#endif /* CONFIG_ARCH_MISC_INIT */
> -
> -#ifdef CONFIG_MVGBE
> -int cpu_eth_init(struct bd_info *bis)
> -{
> -       mvgbe_initialize(bis);
> -       return 0;
> -}
> -#endif
> diff --git a/arch/arm/mach-orion5x/dram.c b/arch/arm/mach-orion5x/dram.c
> deleted file mode 100644
> index 228a3f7ad075..000000000000
> --- a/arch/arm/mach-orion5x/dram.c
> +++ /dev/null
> @@ -1,57 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * Copyright (C) 2010 Albert ARIBAUD <albert.u.boot@aribaud.net>
> - *
> - * Based on original Kirkwood support which is
> - * (C) Copyright 2009
> - * Marvell Semiconductor <www.marvell.com>
> - * Written-by: Prafulla Wadaskar <prafulla@marvell.com>
> - */
> -
> -#include <config.h>
> -#include <init.h>
> -#include <asm/arch/cpu.h>
> -#include <asm/global_data.h>
> -
> -DECLARE_GLOBAL_DATA_PTR;
> -
> -/*
> - * orion5x_sdram_bar - reads SDRAM Base Address Register
> - */
> -u32 orion5x_sdram_bar(enum memory_bank bank)
> -{
> -       struct orion5x_ddr_addr_decode_registers *winregs =3D
> -               (struct orion5x_ddr_addr_decode_registers *)
> -               ORION5X_DRAM_BASE;
> -
> -       u32 result =3D 0;
> -       u32 enable =3D 0x01 & winregs[bank].size;
> -
> -       if ((!enable) || (bank > BANK3))
> -               return 0;
> -
> -       result =3D winregs[bank].base;
> -       return result;
> -}
> -int dram_init (void)
> -{
> -       /* dram_init must store complete ramsize in gd->ram_size */
> -       gd->ram_size =3D get_ram_size(
> -                       (long *) orion5x_sdram_bar(0),
> -                       CFG_MAX_RAM_BANK_SIZE);
> -       return 0;
> -}
> -
> -int dram_init_banksize(void)
> -{
> -       int i;
> -
> -       for (i =3D 0; i < CONFIG_NR_DRAM_BANKS; i++) {
> -               gd->bd->bi_dram[i].start =3D orion5x_sdram_bar(i);
> -               gd->bd->bi_dram[i].size =3D get_ram_size(
> -                       (long *) (gd->bd->bi_dram[i].start),
> -                       CFG_MAX_RAM_BANK_SIZE);
> -       }
> -
> -       return 0;
> -}
> diff --git a/arch/arm/mach-orion5x/include/mach/cpu.h b/arch/arm/mach-ori=
on5x/include/mach/cpu.h
> deleted file mode 100644
> index c3ff89669e45..000000000000
> --- a/arch/arm/mach-orion5x/include/mach/cpu.h
> +++ /dev/null
> @@ -1,242 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * Copyright (C) 2010 Albert ARIBAUD <albert.u.boot@aribaud.net>
> - *
> - * Based on original Kirorion5x_ood support which is
> - * (C) Copyright 2009
> - * Marvell Semiconductor <www.marvell.com>
> - * Written-by: Prafulla Wadaskar <prafulla@marvell.com>
> - */
> -
> -#ifndef _ORION5X_CPU_H
> -#define _ORION5X_CPU_H
> -
> -#include <asm/system.h>
> -
> -#ifndef __ASSEMBLY__
> -
> -#define ORION5X_CPU_WIN_CTRL_DATA(size, target, attr, en) (en | (target =
<< 4) \
> -                       | (attr << 8) | (orion5x_winctrl_calcsize(size) <=
< 16))
> -
> -#define ORION5XGBE_PORT_SERIAL_CONTROL1_REG(_x)        \
> -               ((_x ? ORION5X_EGIGA0_BASE : ORION5X_EGIGA1_BASE) + 0x44c=
)
> -
> -enum memory_bank {
> -       BANK0,
> -       BANK1,
> -       BANK2,
> -       BANK3
> -};
> -
> -enum orion5x_cpu_winen {
> -       ORION5X_WIN_DISABLE,
> -       ORION5X_WIN_ENABLE
> -};
> -
> -enum orion5x_cpu_target {
> -       ORION5X_TARGET_DRAM =3D 0,
> -       ORION5X_TARGET_DEVICE =3D 1,
> -       ORION5X_TARGET_PCI =3D 3,
> -       ORION5X_TARGET_PCIE =3D 4,
> -       ORION5X_TARGET_SASRAM =3D 9
> -};
> -
> -enum orion5x_cpu_attrib {
> -       ORION5X_ATTR_DRAM_CS0 =3D 0x0e,
> -       ORION5X_ATTR_DRAM_CS1 =3D 0x0d,
> -       ORION5X_ATTR_DRAM_CS2 =3D 0x0b,
> -       ORION5X_ATTR_DRAM_CS3 =3D 0x07,
> -       ORION5X_ATTR_PCI_MEM =3D 0x59,
> -       ORION5X_ATTR_PCI_IO =3D 0x51,
> -       ORION5X_ATTR_PCIE_MEM =3D 0x59,
> -       ORION5X_ATTR_PCIE_IO =3D 0x51,
> -       ORION5X_ATTR_SASRAM =3D 0x00,
> -       ORION5X_ATTR_DEV_CS0 =3D 0x1e,
> -       ORION5X_ATTR_DEV_CS1 =3D 0x1d,
> -       ORION5X_ATTR_DEV_CS2 =3D 0x1b,
> -       ORION5X_ATTR_BOOTROM =3D 0x0f
> -};
> -
> -/*
> - * Device Address MAP BAR values
> - *
> - * All addresses and sizes not defined by board code
> - * will be given default values here.
> - */
> -
> -#if !defined (ORION5X_ADR_PCIE_MEM)
> -#define ORION5X_ADR_PCIE_MEM   0x90000000
> -#endif
> -
> -#if !defined (ORION5X_ADR_PCIE_MEM_REMAP_LO)
> -#define ORION5X_ADR_PCIE_MEM_REMAP_LO  0x90000000
> -#endif
> -
> -#if !defined (ORION5X_ADR_PCIE_MEM_REMAP_HI)
> -#define ORION5X_ADR_PCIE_MEM_REMAP_HI  0
> -#endif
> -
> -#if !defined (ORION5X_SZ_PCIE_MEM)
> -#define ORION5X_SZ_PCIE_MEM    (128*1024*1024)
> -#endif
> -
> -#if !defined (ORION5X_ADR_PCIE_IO)
> -#define ORION5X_ADR_PCIE_IO    0xf0000000
> -#endif
> -
> -#if !defined (ORION5X_ADR_PCIE_IO_REMAP_LO)
> -#define ORION5X_ADR_PCIE_IO_REMAP_LO   0xf0000000
> -#endif
> -
> -#if !defined (ORION5X_ADR_PCIE_IO_REMAP_HI)
> -#define ORION5X_ADR_PCIE_IO_REMAP_HI   0
> -#endif
> -
> -#if !defined (ORION5X_SZ_PCIE_IO)
> -#define ORION5X_SZ_PCIE_IO     (64*1024)
> -#endif
> -
> -#if !defined (ORION5X_ADR_PCI_MEM)
> -#define ORION5X_ADR_PCI_MEM    0x98000000
> -#endif
> -
> -#if !defined (ORION5X_SZ_PCI_MEM)
> -#define ORION5X_SZ_PCI_MEM     (128*1024*1024)
> -#endif
> -
> -#if !defined (ORION5X_ADR_PCI_IO)
> -#define ORION5X_ADR_PCI_IO     0xf0100000
> -#endif
> -
> -#if !defined (ORION5X_SZ_PCI_IO)
> -#define ORION5X_SZ_PCI_IO      (64*1024)
> -#endif
> -
> -#if !defined (ORION5X_ADR_DEV_CS0)
> -#define ORION5X_ADR_DEV_CS0    0xfa000000
> -#endif
> -
> -#if !defined (ORION5X_SZ_DEV_CS0)
> -#define ORION5X_SZ_DEV_CS0     (2*1024*1024)
> -#endif
> -
> -#if !defined (ORION5X_ADR_DEV_CS1)
> -#define ORION5X_ADR_DEV_CS1    0xf8000000
> -#endif
> -
> -#if !defined (ORION5X_SZ_DEV_CS1)
> -#define ORION5X_SZ_DEV_CS1     (32*1024*1024)
> -#endif
> -
> -#if !defined (ORION5X_ADR_DEV_CS2)
> -#define ORION5X_ADR_DEV_CS2    0xfa800000
> -#endif
> -
> -#if !defined (ORION5X_SZ_DEV_CS2)
> -#define ORION5X_SZ_DEV_CS2     (1*1024*1024)
> -#endif
> -
> -#if !defined (ORION5X_ADR_BOOTROM)
> -#define ORION5X_ADR_BOOTROM    0xFFF80000
> -#endif
> -
> -#if !defined (ORION5X_SZ_BOOTROM)
> -#define ORION5X_SZ_BOOTROM     (512*1024)
> -#endif
> -
> -/*
> - * PCIE registers are used for SoC device ID and revision
> - */
> -#define PCIE_DEV_ID_OFF         (ORION5X_REG_PCIE_BASE + 0x0000)
> -#define PCIE_DEV_REV_OFF        (ORION5X_REG_PCIE_BASE + 0x0008)
> -
> -/*
> - * The following definitions are intended for identifying
> - * the real device and revision on which u-boot is running
> - * even if it was compiled only for a specific one. Thus,
> - * these constants must not be considered chip-specific.
> - */
> -
> -/* Orion-1 (88F5181) and Orion-VoIP (88F5181L) */
> -#define MV88F5181_DEV_ID        0x5181
> -#define MV88F5181_REV_B1        3
> -#define MV88F5181L_REV_A0       8
> -#define MV88F5181L_REV_A1       9
> -/* Orion-NAS (88F5182) */
> -#define MV88F5182_DEV_ID        0x5182
> -#define MV88F5182_REV_A2        2
> -/* Orion-2 (88F5281) */
> -#define MV88F5281_DEV_ID        0x5281
> -#define MV88F5281_REV_D0        4
> -#define MV88F5281_REV_D1        5
> -#define MV88F5281_REV_D2        6
> -/* Orion-1-90 (88F6183) */
> -#define MV88F6183_DEV_ID        0x6183
> -#define MV88F6183_REV_B0        3
> -
> -/*
> - * read feroceon core extra feature register
> - * using co-proc instruction
> - */
> -static inline unsigned int readfr_extra_feature_reg(void)
> -{
> -       unsigned int val;
> -       asm volatile ("mrc p15, 1, %0, c15, c1, 0 @ readfr exfr" : "=3Dr"
> -                       (val) : : "cc");
> -       return val;
> -}
> -
> -/*
> - * write feroceon core extra feature register
> - * using co-proc instruction
> - */
> -static inline void writefr_extra_feature_reg(unsigned int val)
> -{
> -       asm volatile ("mcr p15, 1, %0, c15, c1, 0 @ writefr exfr" : : "r"
> -                       (val) : "cc");
> -       isb();
> -}
> -
> -/*
> - * AHB to Mbus Bridge Registers
> - * Source: 88F5182 User Manual, Appendix A, section A.4
> - * Note: only windows 0 and 1 have remap capability.
> - */
> -struct orion5x_win_registers {
> -       u32 ctrl;
> -       u32 base;
> -       u32 remap_lo;
> -       u32 remap_hi;
> -};
> -
> -/*
> - * CPU control and status Registers
> - * Source: 88F5182 User Manual, Appendix A, section A.4
> - */
> -struct orion5x_cpu_registers {
> -       u32 config;     /*0x20100 */
> -       u32 ctrl_stat;  /*0x20104 */
> -       u32 rstoutn_mask; /* 0x20108 */
> -       u32 sys_soft_rst; /* 0x2010C */
> -       u32 ahb_mbus_cause_irq; /* 0x20110 */
> -       u32 ahb_mbus_mask_irq; /* 0x20114 */
> -};
> -
> -/*
> - * DDR SDRAM Controller Address Decode Registers
> - * Source: 88F5182 User Manual, Appendix A, section A.5.1
> - */
> -struct orion5x_ddr_addr_decode_registers {
> -       u32 base;
> -       u32 size;
> -};
> -
> -/*
> - * functions
> - */
> -u32 orion5x_device_id(void);
> -u32 orion5x_device_rev(void);
> -unsigned int orion5x_winctrl_calcsize(unsigned int sizeval);
> -void timer_init_r(void);
> -#endif /* __ASSEMBLY__ */
> -#endif /* _ORION5X_CPU_H */
> diff --git a/arch/arm/mach-orion5x/include/mach/mv88f5182.h b/arch/arm/ma=
ch-orion5x/include/mach/mv88f5182.h
> deleted file mode 100644
> index ee0aa94bf2c2..000000000000
> --- a/arch/arm/mach-orion5x/include/mach/mv88f5182.h
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * Copyright (C) 2010 Albert ARIBAUD <albert.u.boot@aribaud.net>
> - *
> - * Based on original Kirkwood 88F6182 support which is
> - * (C) Copyright 2009
> - * Marvell Semiconductor <www.marvell.com>
> - * Written-by: Prafulla Wadaskar <prafulla@marvell.com>
> - *
> - * Header file for Feroceon CPU core 88F5182 SOC.
> - */
> -
> -#ifndef _CONFIG_88F5182_H
> -#define _CONFIG_88F5182_H
> -
> -/* SOC specific definitions */
> -#define F88F5182_REGS_PHYS_BASE                0xf1000000
> -#define ORION5X_REGS_PHY_BASE          F88F5182_REGS_PHYS_BASE
> -
> -/* TCLK Core Clock defination */
> -#define CFG_SYS_TCLK                   166000000 /* 166MHz */
> -
> -#endif /* _CONFIG_88F5182_H */
> diff --git a/arch/arm/mach-orion5x/include/mach/orion5x.h b/arch/arm/mach=
-orion5x/include/mach/orion5x.h
> deleted file mode 100644
> index e41d07e18cc5..000000000000
> --- a/arch/arm/mach-orion5x/include/mach/orion5x.h
> +++ /dev/null
> @@ -1,66 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * Copyright (C) 2010 Albert ARIBAUD <albert.u.boot@aribaud.net>
> - *
> - * Based on original Kirkwood support which is
> - * (C) Copyright 2009
> - * Marvell Semiconductor <www.marvell.com>
> - * Written-by: Prafulla Wadaskar <prafulla@marvell.com>
> - *
> - * Header file for Marvell's Orion SoC with Feroceon CPU core.
> - */
> -
> -#ifndef _ASM_ARCH_ORION5X_H
> -#define _ASM_ARCH_ORION5X_H
> -
> -#if defined(CONFIG_FEROCEON)
> -
> -/* SOC specific definations */
> -#define ORION5X_REGISTER(x)                    (ORION5X_REGS_PHY_BASE + =
x)
> -
> -/* Documented registers */
> -#define ORION5X_DRAM_BASE                      (ORION5X_REGISTER(0x01500=
))
> -#define ORION5X_TWSI_BASE                      (ORION5X_REGISTER(0x11000=
))
> -#define ORION5X_UART0_BASE                     (ORION5X_REGISTER(0x12000=
))
> -#define ORION5X_UART1_BASE                     (ORION5X_REGISTER(0x12100=
))
> -#define ORION5X_MPP_BASE                       (ORION5X_REGISTER(0x10000=
))
> -#define ORION5X_GPIO_BASE                      (ORION5X_REGISTER(0x10100=
))
> -#define ORION5X_CPU_WIN_BASE                   (ORION5X_REGISTER(0x20000=
))
> -#define ORION5X_CPU_REG_BASE                   (ORION5X_REGISTER(0x20100=
))
> -#define ORION5X_TIMER_BASE                     (ORION5X_REGISTER(0x20300=
))
> -#define ORION5X_REG_PCI_BASE                   (ORION5X_REGISTER(0x30000=
))
> -#define ORION5X_REG_PCIE_BASE                  (ORION5X_REGISTER(0x40000=
))
> -#define ORION5X_USB20_PORT0_BASE               (ORION5X_REGISTER(0x50000=
))
> -#define ORION5X_USB20_PORT1_BASE               (ORION5X_REGISTER(0xA0000=
))
> -#define ORION5X_EGIGA_BASE                     (ORION5X_REGISTER(0x72000=
))
> -#define ORION5X_SATA_BASE                      (ORION5X_REGISTER(0x80000=
))
> -#define ORION5X_SATA_PORT0_OFFSET              0x2000
> -#define ORION5X_SATA_PORT1_OFFSET              0x4000
> -
> -/* Orion5x GbE controller has a single port */
> -#define MAX_MVGBE_DEVS 1
> -#define MVGBE0_BASE    ORION5X_EGIGA_BASE
> -
> -/* Orion5x USB Host controller is port 1 */
> -#define MVUSB0_BASE                    ORION5X_USB20_HOST_PORT_BASE
> -#define MVUSB0_CPU_ATTR_DRAM_CS0       ORION5X_ATTR_DRAM_CS0
> -#define MVUSB0_CPU_ATTR_DRAM_CS1       ORION5X_ATTR_DRAM_CS1
> -#define MVUSB0_CPU_ATTR_DRAM_CS2       ORION5X_ATTR_DRAM_CS2
> -#define MVUSB0_CPU_ATTR_DRAM_CS3       ORION5X_ATTR_DRAM_CS3
> -
> -/* Kirkwood CPU memory windows */
> -#define MVCPU_WIN_CTRL_DATA    ORION5X_CPU_WIN_CTRL_DATA
> -#define MVCPU_WIN_ENABLE       ORION5X_WIN_ENABLE
> -#define MVCPU_WIN_DISABLE      ORION5X_WIN_DISABLE
> -
> -#define CFG_MAX_RAM_BANK_SIZE          (64*1024*1024)
> -
> -/* include here SoC variants. 5181, 5281, 6183 should go here when
> -   adding support for them, and this comment should then be updated. */
> -#if defined(CONFIG_88F5182)
> -#include <asm/arch/mv88f5182.h>
> -#else
> -#error "SOC Name not defined"
> -#endif
> -#endif /* CONFIG_FEROCEON */
> -#endif /* _ASM_ARCH_ORION5X_H */
> diff --git a/arch/arm/mach-orion5x/lowlevel_init.S b/arch/arm/mach-orion5=
x/lowlevel_init.S
> deleted file mode 100644
> index 358d2a49fbb4..000000000000
> --- a/arch/arm/mach-orion5x/lowlevel_init.S
> +++ /dev/null
> @@ -1,286 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * Copyright (C) 2010 Albert ARIBAUD <albert.u.boot@aribaud.net>
> - *
> - * (C) Copyright 2009
> - * Marvell Semiconductor <www.marvell.com>
> - * Written-by: Prafulla Wadaskar <prafulla@marvell.com>
> - */
> -
> -#include <config.h>
> -#include "asm/arch/orion5x.h"
> -
> -/*
> - * Configuration values for SDRAM access setup
> - */
> -
> -#define SDRAM_CONFIG                   0x3148400
> -#define SDRAM_MODE                     0x62
> -#define SDRAM_CONTROL                  0x4041000
> -#define SDRAM_TIME_CTRL_LOW            0x11602220
> -#define SDRAM_TIME_CTRL_HI             0x40c
> -#define SDRAM_OPEN_PAGE_EN             0x0
> -/* DDR 1 2x 32M NANYA NT5DS16M16CS-6K =3D=3D> 64MB */
> -#define SDRAM_BANK0_SIZE               0x3ff0001
> -#define SDRAM_ADDR_CTRL                        0x10
> -
> -#define SDRAM_OP_NOP                   0x05
> -#define SDRAM_OP_SETMODE               0x03
> -
> -#define SDRAM_PAD_CTRL_WR_EN           0x80000000
> -#define SDRAM_PAD_CTRL_TUNE_EN         0x00010000
> -#define SDRAM_PAD_CTRL_DRVN_MASK       0x0000003f
> -#define SDRAM_PAD_CTRL_DRVP_MASK       0x00000fc0
> -
> -/*
> - * For Guideline MEM-3 - Drive Strength value
> - */
> -
> -#define DDR1_PAD_STRENGTH_DEFAULT      0x00001000
> -#define SDRAM_PAD_CTRL_DRV_STR_MASK    0x00003000
> -
> -/*
> - * For Guideline MEM-4 - DQS Reference Delay Tuning
> - */
> -
> -#define MSAR_ARMDDRCLCK_MASK           0x000000f0
> -#define MSAR_ARMDDRCLCK_H_MASK         0x00000100
> -
> -#define MSAR_ARMDDRCLCK_333_167                0x00000000
> -#define MSAR_ARMDDRCLCK_500_167                0x00000030
> -#define MSAR_ARMDDRCLCK_667_167                0x00000060
> -#define MSAR_ARMDDRCLCK_400_200_1      0x000001E0
> -#define MSAR_ARMDDRCLCK_400_200                0x00000010
> -#define MSAR_ARMDDRCLCK_600_200                0x00000050
> -#define MSAR_ARMDDRCLCK_800_200                0x00000070
> -
> -#define FTDLL_DDR1_166MHZ              0x0047F001
> -
> -#define FTDLL_DDR1_200MHZ              0x0044D001
> -
> -/*
> - * Low-level init happens right after start.S has switched to SVC32,
> - * flushed and disabled caches and disabled MMU. We're still running
> - * from the boot chip select, so the first thing SPL should do is to
> - * set up the RAM to copy U-Boot into.
> - */
> -
> -.globl lowlevel_init
> -
> -lowlevel_init:
> -
> -#ifdef CONFIG_XPL_BUILD
> -
> -       /* Use 'r2 as the base for internal register accesses */
> -       ldr     r2, =3DORION5X_REGS_PHY_BASE
> -
> -       /* move internal registers from the default 0xD0000000
> -        * to their intended location, defined by SoC */
> -       ldr     r3, =3D0xD0000000
> -       add     r3, r3, #0x20000
> -       str     r2, [r3, #0x80]
> -
> -       /* Use R3 as the base for DRAM registers */
> -       add     r3, r2, #0x01000
> -
> -       /*DDR SDRAM Initialization Control */
> -       ldr     r0, =3D0x00000001
> -       str     r0, [r3, #0x480]
> -
> -       /* Use R3 as the base for PCI registers */
> -       add     r3, r2, #0x31000
> -
> -       /* Disable arbiter */
> -       ldr     r0, =3D0x00000030
> -       str     r0, [r3, #0xd00]
> -
> -       /* Use R3 as the base for DRAM registers */
> -       add     r3, r2, #0x01000
> -
> -       /* set all dram windows to 0 */
> -       mov     r0, #0
> -       str     r0, [r3, #0x504]
> -       str     r0, [r3, #0x50C]
> -       str     r0, [r3, #0x514]
> -       str     r0, [r3, #0x51C]
> -
> -       /* 1) Configure SDRAM  */
> -       ldr     r0, =3DSDRAM_CONFIG
> -       str     r0, [r3, #0x400]
> -
> -       /* 2) Set SDRAM Control reg */
> -       ldr     r0, =3DSDRAM_CONTROL
> -       str     r0, [r3, #0x404]
> -
> -       /* 3) Write SDRAM address control register */
> -       ldr     r0, =3DSDRAM_ADDR_CTRL
> -       str     r0, [r3, #0x410]
> -
> -       /* 4) Write SDRAM bank 0 size register */
> -       ldr     r0, =3DSDRAM_BANK0_SIZE
> -       str     r0, [r3, #0x504]
> -       /* keep other banks disabled */
> -
> -       /* 5) Write SDRAM open pages control register */
> -       ldr     r0, =3DSDRAM_OPEN_PAGE_EN
> -       str     r0, [r3, #0x414]
> -
> -       /* 6) Write SDRAM timing Low register */
> -       ldr     r0, =3DSDRAM_TIME_CTRL_LOW
> -       str     r0, [r3, #0x408]
> -
> -       /* 7) Write SDRAM timing High register */
> -       ldr     r0, =3DSDRAM_TIME_CTRL_HI
> -       str     r0, [r3, #0x40C]
> -
> -       /* 8) Write SDRAM mode register */
> -       /* The CPU must not attempt to change the SDRAM Mode register set=
ting */
> -       /* prior to DRAM controller completion of the DRAM initialization=
     */
> -       /* sequence. To guarantee this restriction, it is recommended tha=
t    */
> -       /* the CPU sets the SDRAM Operation register to NOP command, perf=
orms */
> -       /* read polling until the register is back in Normal operation va=
lue, */
> -       /* and then sets SDRAM Mode register to its new value.           =
     */
> -
> -       /* 8.1 write 'nop' to SDRAM operation */
> -       ldr     r0, =3DSDRAM_OP_NOP
> -       str     r0, [r3, #0x418]
> -
> -       /* 8.2 poll SDRAM operation until back in 'normal' mode.  */
> -1:
> -       ldr     r0, [r3, #0x418]
> -       cmp     r0, #0
> -       bne     1b
> -
> -       /* 8.3 Now its safe to write new value to SDRAM Mode register    =
     */
> -       ldr     r0, =3DSDRAM_MODE
> -       str     r0, [r3, #0x41C]
> -
> -       /* 8.4 Set new mode */
> -       ldr     r0, =3DSDRAM_OP_SETMODE
> -       str     r0, [r3, #0x418]
> -
> -       /* 8.5 poll SDRAM operation until back in 'normal' mode.  */
> -2:
> -       ldr     r0, [r3, #0x418]
> -       cmp     r0, #0
> -       bne     2b
> -
> -       /* DDR SDRAM Address/Control Pads Calibration */
> -       ldr     r0, [r3, #0x4C0]
> -
> -       /* Set Bit [31] to make the register writable                   *=
/
> -       orr     r0, r0, #SDRAM_PAD_CTRL_WR_EN
> -       str     r0, [r3, #0x4C0]
> -
> -       bic     r0, r0, #SDRAM_PAD_CTRL_WR_EN
> -       bic     r0, r0, #SDRAM_PAD_CTRL_TUNE_EN
> -       bic     r0, r0, #SDRAM_PAD_CTRL_DRVN_MASK
> -       bic     r0, r0, #SDRAM_PAD_CTRL_DRVP_MASK
> -
> -       /* Get the final N locked value of driving strength [22:17]     *=
/
> -       mov     r1, r0
> -       mov     r1, r1, LSL #9
> -       mov     r1, r1, LSR #26  /* r1[5:0]<DrvN>  =3D r3[22:17]<LockN>  =
 */
> -       orr     r1, r1, r1, LSL #6 /* r1[11:6]<DrvP> =3D r1[5:0]<DrvN>   =
 */
> -
> -       /* Write to both <DrvN> bits [5:0] and <DrvP> bits [11:6]       *=
/
> -       orr     r0, r0, r1
> -       str     r0, [r3, #0x4C0]
> -
> -       /* DDR SDRAM Data Pads Calibration                              *=
/
> -       ldr     r0, [r3, #0x4C4]
> -
> -       /* Set Bit [31] to make the register writable                   *=
/
> -       orr     r0, r0, #SDRAM_PAD_CTRL_WR_EN
> -       str     r0, [r3, #0x4C4]
> -
> -       bic     r0, r0, #SDRAM_PAD_CTRL_WR_EN
> -       bic     r0, r0, #SDRAM_PAD_CTRL_TUNE_EN
> -       bic     r0, r0, #SDRAM_PAD_CTRL_DRVN_MASK
> -       bic     r0, r0, #SDRAM_PAD_CTRL_DRVP_MASK
> -
> -       /* Get the final N locked value of driving strength [22:17]     *=
/
> -       mov     r1, r0
> -       mov     r1, r1, LSL #9
> -       mov     r1, r1, LSR #26
> -       orr     r1, r1, r1, LSL #6 /* r1[5:0] =3D r3[22:17]<LockN>       =
 */
> -
> -       /* Write to both <DrvN> bits [5:0] and <DrvP> bits [11:6]       *=
/
> -       orr     r0, r0, r1
> -
> -       str     r0, [r3, #0x4C4]
> -
> -       /* Implement Guideline (GL# MEM-3) Drive Strength Value         *=
/
> -       /* Relevant for: 88F5181-A1/B0/B1 and 88F5281-A0/B0             *=
/
> -
> -       ldr     r1, =3DDDR1_PAD_STRENGTH_DEFAULT
> -
> -       /* Enable writes to DDR SDRAM Addr/Ctrl Pads Calibration register=
 */
> -       ldr     r0, [r3, #0x4C0]
> -       orr     r0, r0, #SDRAM_PAD_CTRL_WR_EN
> -       str     r0, [r3, #0x4C0]
> -
> -       /* Correct strength and disable writes again */
> -       bic     r0, r0, #SDRAM_PAD_CTRL_WR_EN
> -       bic     r0, r0, #SDRAM_PAD_CTRL_DRV_STR_MASK
> -       orr     r0, r0, r1
> -       str     r0, [r3, #0x4C0]
> -
> -       /* Enable writes to DDR SDRAM Data Pads Calibration register */
> -       ldr     r0, [r3, #0x4C4]
> -       orr     r0, r0, #SDRAM_PAD_CTRL_WR_EN
> -       str     r0, [r3, #0x4C4]
> -
> -       /* Correct strength and disable writes again */
> -       bic     r0, r0, #SDRAM_PAD_CTRL_DRV_STR_MASK
> -       bic     r0, r0, #SDRAM_PAD_CTRL_WR_EN
> -       orr     r0, r0, r1
> -       str     r0, [r3, #0x4C4]
> -
> -       /* Implement Guideline (GL# MEM-4) DQS Reference Delay Tuning   *=
/
> -       /* Relevant for: 88F5181-A1/B0/B1 and 88F5281-A0/B0             *=
/
> -
> -       /* Get the "sample on reset" register for the DDR frequancy     *=
/
> -       ldr     r3, =3D0x10000
> -       ldr     r0, [r3, #0x010]
> -       ldr     r1, =3DMSAR_ARMDDRCLCK_MASK
> -       and     r1, r0, r1
> -
> -       ldr     r0, =3DFTDLL_DDR1_166MHZ
> -       cmp     r1, #MSAR_ARMDDRCLCK_333_167
> -       beq     3f
> -       cmp     r1, #MSAR_ARMDDRCLCK_500_167
> -       beq     3f
> -       cmp     r1, #MSAR_ARMDDRCLCK_667_167
> -       beq     3f
> -
> -       ldr     r0, =3DFTDLL_DDR1_200MHZ
> -       cmp     r1, #MSAR_ARMDDRCLCK_400_200_1
> -       beq     3f
> -       cmp     r1, #MSAR_ARMDDRCLCK_400_200
> -       beq     3f
> -       cmp     r1, #MSAR_ARMDDRCLCK_600_200
> -       beq     3f
> -       cmp     r1, #MSAR_ARMDDRCLCK_800_200
> -       beq     3f
> -
> -       ldr     r0, =3D0
> -
> -3:
> -       /* Use R3 as the base for DRAM registers */
> -       add     r3, r2, #0x01000
> -
> -       ldr     r2, [r3, #0x484]
> -       orr     r2, r2, r0
> -       str     r2, [r3, #0x484]
> -
> -       /* enable for 2 GB DDR; detection should find out real amount */
> -       sub     r0, r0, r0
> -       str     r0, [r3, #0x500]
> -       ldr     r0, =3D0x7fff0001
> -       str     r0, [r3, #0x504]
> -
> -#endif /* CONFIG_XPL_BUILD */
> -
> -       /* Return to U-Boot via saved link register */
> -       mov     pc, lr
> diff --git a/arch/arm/mach-orion5x/timer.c b/arch/arm/mach-orion5x/timer.=
c
> deleted file mode 100644
> index 85736f04e672..000000000000
> --- a/arch/arm/mach-orion5x/timer.c
> +++ /dev/null
> @@ -1,174 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> -  * Copyright (C) 2010 Albert ARIBAUD <albert.u.boot@aribaud.net>
> - *
> - * Based on original Kirkwood support which is
> - * Copyright (C) Marvell International Ltd. and its affiliates
> - * Written-by: Prafulla Wadaskar <prafulla@marvell.com>
> - */
> -
> -#include <config.h>
> -#include <init.h>
> -#include <time.h>
> -#include <asm/global_data.h>
> -#include <asm/io.h>
> -#include <linux/delay.h>
> -
> -#define UBOOT_CNTR     0       /* counter to use for uboot timer */
> -
> -/* Timer reload and current value registers */
> -struct orion5x_tmr_val {
> -       u32 reload;     /* Timer reload reg */
> -       u32 val;        /* Timer value reg */
> -};
> -
> -/* Timer registers */
> -struct orion5x_tmr_registers {
> -       u32 ctrl;       /* Timer control reg */
> -       u32 pad[3];
> -       struct orion5x_tmr_val tmr[2];
> -       u32 wdt_reload;
> -       u32 wdt_val;
> -};
> -
> -struct orion5x_tmr_registers *orion5x_tmr_regs =3D
> -       (struct orion5x_tmr_registers *)ORION5X_TIMER_BASE;
> -
> -/*
> - * ARM Timers Registers Map
> - */
> -#define CNTMR_CTRL_REG                 (&orion5x_tmr_regs->ctrl)
> -#define CNTMR_RELOAD_REG(tmrnum)       (&orion5x_tmr_regs->tmr[tmrnum].r=
eload)
> -#define CNTMR_VAL_REG(tmrnum)          (&orion5x_tmr_regs->tmr[tmrnum].v=
al)
> -
> -/*
> - * ARM Timers Control Register
> - * CPU_TIMERS_CTRL_REG (CTCR)
> - */
> -#define CTCR_ARM_TIMER_EN_OFFS(cntr)   (cntr * 2)
> -#define CTCR_ARM_TIMER_EN_MASK(cntr)   (1 << CTCR_ARM_TIMER_EN_OFFS)
> -#define CTCR_ARM_TIMER_EN(cntr)                (1 << CTCR_ARM_TIMER_EN_O=
FFS(cntr))
> -#define CTCR_ARM_TIMER_DIS(cntr)       (0 << CTCR_ARM_TIMER_EN_OFFS(cntr=
))
> -
> -#define CTCR_ARM_TIMER_AUTO_OFFS(cntr) ((cntr * 2) + 1)
> -#define CTCR_ARM_TIMER_AUTO_MASK(cntr) (1 << 1)
> -#define CTCR_ARM_TIMER_AUTO_EN(cntr)   (1 << CTCR_ARM_TIMER_AUTO_OFFS(cn=
tr))
> -#define CTCR_ARM_TIMER_AUTO_DIS(cntr)  (0 << CTCR_ARM_TIMER_AUTO_OFFS(cn=
tr))
> -
> -/*
> - * ARM Timer\Watchdog Reload Register
> - * CNTMR_RELOAD_REG (TRR)
> - */
> -#define TRG_ARM_TIMER_REL_OFFS         0
> -#define TRG_ARM_TIMER_REL_MASK         0xffffffff
> -
> -/*
> - * ARM Timer\Watchdog Register
> - * CNTMR_VAL_REG (TVRG)
> - */
> -#define TVR_ARM_TIMER_OFFS             0
> -#define TVR_ARM_TIMER_MASK             0xffffffff
> -#define TVR_ARM_TIMER_MAX              0xffffffff
> -#define TIMER_LOAD_VAL                 0xffffffff
> -
> -static inline ulong read_timer(void)
> -{
> -       return readl(CNTMR_VAL_REG(UBOOT_CNTR))
> -             / (CFG_SYS_TCLK / 1000);
> -}
> -
> -DECLARE_GLOBAL_DATA_PTR;
> -
> -#define timestamp gd->arch.tbl
> -#define lastdec gd->arch.lastinc
> -
> -static ulong get_timer_masked(void)
> -{
> -       ulong now =3D read_timer();
> -
> -       if (lastdec >=3D now) {
> -               /* normal mode */
> -               timestamp +=3D lastdec - now;
> -       } else {
> -               /* we have an overflow ... */
> -               timestamp +=3D lastdec +
> -                       (TIMER_LOAD_VAL / (CFG_SYS_TCLK / 1000)) - now;
> -       }
> -       lastdec =3D now;
> -
> -       return timestamp;
> -}
> -
> -ulong get_timer(ulong base)
> -{
> -       return get_timer_masked() - base;
> -}
> -
> -static inline ulong uboot_cntr_val(void)
> -{
> -       return readl(CNTMR_VAL_REG(UBOOT_CNTR));
> -}
> -
> -void __udelay(unsigned long usec)
> -{
> -       uint current;
> -       ulong delayticks;
> -
> -       current =3D uboot_cntr_val();
> -       delayticks =3D (usec * (CFG_SYS_TCLK / 1000000));
> -
> -       if (current < delayticks) {
> -               delayticks -=3D current;
> -               while (uboot_cntr_val() < current)
> -                       ;
> -               while ((TIMER_LOAD_VAL - delayticks) < uboot_cntr_val())
> -                       ;
> -       } else {
> -               while (uboot_cntr_val() > (current - delayticks))
> -                       ;
> -       }
> -}
> -
> -/*
> - * init the counter
> - */
> -int timer_init(void)
> -{
> -       unsigned int cntmrctrl;
> -
> -       /* load value into timer */
> -       writel(TIMER_LOAD_VAL, CNTMR_RELOAD_REG(UBOOT_CNTR));
> -       writel(TIMER_LOAD_VAL, CNTMR_VAL_REG(UBOOT_CNTR));
> -
> -       /* enable timer in auto reload mode */
> -       cntmrctrl =3D readl(CNTMR_CTRL_REG);
> -       cntmrctrl |=3D CTCR_ARM_TIMER_EN(UBOOT_CNTR);
> -       cntmrctrl |=3D CTCR_ARM_TIMER_AUTO_EN(UBOOT_CNTR);
> -       writel(cntmrctrl, CNTMR_CTRL_REG);
> -       return 0;
> -}
> -
> -void timer_init_r(void)
> -{
> -       /* init the timestamp and lastdec value */
> -       lastdec =3D read_timer();
> -       timestamp =3D 0;
> -}
> -
> -/*
> - * This function is derived from PowerPC code (read timebase as long lon=
g).
> - * On ARM it just returns the timer value.
> - */
> -unsigned long long get_ticks(void)
> -{
> -       return get_timer(0);
> -}
> -
> -/*
> - * This function is derived from PowerPC code (timebase clock frequency)=
.
> - * On ARM it returns the number of timer ticks per second.
> - */
> -ulong get_tbclk(void)
> -{
> -       return (ulong)CONFIG_SYS_HZ;
> -}
> diff --git a/arch/arm/mach-orion5x/u-boot-spl.lds b/arch/arm/mach-orion5x=
/u-boot-spl.lds
> deleted file mode 100644
> index 154bb1206035..000000000000
> --- a/arch/arm/mach-orion5x/u-boot-spl.lds
> +++ /dev/null
> @@ -1,60 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * (C) Copyright 2014 Albert ARIBAUD <albert.u.boot@aribaud.net>
> - *
> - * Based on:
> - *
> - * Allwinner Technology Co., Ltd. <www.allwinnertech.com>
> - * Tom Cubie <tangliang@allwinnertech.com>
> - *
> - * Based on omap-common/u-boot-spl.lds:
> - *
> - * (C) Copyright 2002
> - * Gary Jennejohn, DENX Software Engineering, <garyj@denx.de>
> - *
> - * (C) Copyright 2010
> - * Texas Instruments, <www.ti.com>
> - *     Aneesh V <aneesh@ti.com>
> - */
> -MEMORY { .nor : ORIGIN =3D IMAGE_TEXT_BASE,\
> -               LENGTH =3D IMAGE_MAX_SIZE }
> -MEMORY { .bss : ORIGIN =3D CONFIG_SPL_BSS_START_ADDR, \
> -               LENGTH =3D CONFIG_SPL_BSS_MAX_SIZE }
> -
> -OUTPUT_FORMAT("elf32-littlearm", "elf32-littlearm", "elf32-littlearm")
> -OUTPUT_ARCH(arm)
> -ENTRY(_start)
> -SECTIONS
> -{
> -       .text      :
> -       {
> -               __start =3D .;
> -               *(.vectors)
> -               CPUDIR/start.o  (.text)
> -               *(.text*)
> -       } > .nor
> -
> -       . =3D ALIGN(4);
> -       .rodata : { *(SORT_BY_ALIGNMENT(.rodata*)) } >.nor
> -
> -       . =3D ALIGN(4);
> -       .data : { *(SORT_BY_ALIGNMENT(.data*)) } >.nor
> -
> -       . =3D ALIGN(4);
> -       __u_boot_list : {
> -               KEEP(*(SORT(__u_boot_list*)));
> -       } > .nor
> -
> -       . =3D ALIGN(4);
> -       __image_copy_end =3D .;
> -       _end =3D .;
> -
> -       .bss :
> -       {
> -               . =3D ALIGN(4);
> -               __bss_start =3D .;
> -               *(.bss*)
> -               . =3D ALIGN(4);
> -               __bss_end =3D .;
> -       } > .bss
> -}
> diff --git a/drivers/i2c/mvtwsi.c b/drivers/i2c/mvtwsi.c
> index 44e8e191b039..22a32a2fd76a 100644
> --- a/drivers/i2c/mvtwsi.c
> +++ b/drivers/i2c/mvtwsi.c
> @@ -30,9 +30,7 @@ DECLARE_GLOBAL_DATA_PTR;
>   */
>
>  #if !CONFIG_IS_ENABLED(DM_I2C)
> -#if defined(CONFIG_ARCH_ORION5X)
> -#include <asm/arch/orion5x.h>
> -#elif (defined(CONFIG_ARCH_KIRKWOOD) || defined(CONFIG_ARCH_MVEBU))
> +#if (defined(CONFIG_ARCH_KIRKWOOD) || defined(CONFIG_ARCH_MVEBU))
>  #include <asm/arch/soc.h>
>  #elif defined(CONFIG_ARCH_SUNXI)
>  #include <asm/arch/i2c.h>
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 0089f74c69d9..4fda1b0c28cf 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -539,7 +539,7 @@ config MV88E6XXX
>
>  config MVGBE
>         bool "Marvell Orion5x/Kirkwood network interface support"
> -       depends on ARCH_KIRKWOOD || ARCH_ORION5X
> +       depends on ARCH_KIRKWOOD
>         select PHYLIB
>         help
>           This driver supports the network interface units in the
> diff --git a/drivers/net/mvgbe.c b/drivers/net/mvgbe.c
> index 17b62bbc2052..107a33aa9f54 100644
> --- a/drivers/net/mvgbe.c
> +++ b/drivers/net/mvgbe.c
> @@ -25,12 +25,7 @@
>  #include <asm/system.h>
>  #include <asm/byteorder.h>
>  #include <asm/arch/cpu.h>
> -
> -#if defined(CONFIG_ARCH_KIRKWOOD)
>  #include <asm/arch/soc.h>
> -#elif defined(CONFIG_ARCH_ORION5X)
> -#include <asm/arch/orion5x.h>
> -#endif
>
>  #include "mvgbe.h"
>
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 54df4264a441..d75883e28650 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -187,7 +187,7 @@ config USB_EHCI_EXYNOS
>
>  config USB_EHCI_MARVELL
>         bool "Support for Marvell on-chip EHCI USB controller"
> -       depends on ARCH_MVEBU || ARCH_KIRKWOOD || ARCH_ORION5X
> +       depends on ARCH_MVEBU || ARCH_KIRKWOOD
>         default y
>         select USB_EHCI_IS_TDI if !ARM64
>         select USB_EHCI_IS_TDI if ALLEYCAT_5
> diff --git a/drivers/usb/host/ehci-marvell.c b/drivers/usb/host/ehci-marv=
ell.c
> index ca0ab57d49c2..794a41689138 100644
> --- a/drivers/usb/host/ehci-marvell.c
> +++ b/drivers/usb/host/ehci-marvell.c
> @@ -17,8 +17,6 @@
>
>  #if defined(CONFIG_ARCH_KIRKWOOD)
>  #include <asm/arch/soc.h>
> -#elif defined(CONFIG_ARCH_ORION5X)
> -#include <asm/arch/orion5x.h>
>  #endif
>
>  DECLARE_GLOBAL_DATA_PTR;
> diff --git a/include/configs/mv-common.h b/include/configs/mv-common.h
> index 3dfcb138b490..7c9b41de02b1 100644
> --- a/include/configs/mv-common.h
> +++ b/include/configs/mv-common.h
> @@ -10,7 +10,6 @@
>   * This file should be included in board config header file.
>   *
>   * It supports common definations for Kirkwood platform
> - * TBD: support for Orion5X platforms
>   */
>
>  #ifndef _MV_COMMON_H
> --
> 2.43.0
>
