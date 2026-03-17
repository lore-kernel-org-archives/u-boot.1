Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4966F3381B
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 08:48:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09BC984159;
	Tue, 17 Mar 2026 09:48:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B70BA8415D; Tue, 17 Mar 2026 09:48:33 +0100 (CET)
Received: from Atcsqr.andestech.com (unknown [60.248.187.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02C428414E
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 09:48:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTP id 62H8mJDJ057297;
 Tue, 17 Mar 2026 16:48:19 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Mar
 2026 16:48:19 +0800
Date: Tue, 17 Mar 2026 16:48:16 +0800
From: Leo Liang <ycliang@andestech.com>
To: Uros Stajic <uros.stajic@htecgroup.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu <cfu@mips.com>
Subject: Re: [PATCH v5 2/8] board: boston-riscv: Add initial support for
 P8700 Boston board
Message-ID: <abkVUL17gV6cAZwl@swlinux02>
References: <20251224154449.946780-1-uros.stajic@htecgroup.com>
 <20251224154449.946780-3-uros.stajic@htecgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251224154449.946780-3-uros.stajic@htecgroup.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 62H8mJDJ057297
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

On Wed, Dec 24, 2025 at 03:45:47PM +0000, Uros Stajic wrote:
> From: Chao-ying Fu <cfu@mips.com>
> 
> Implement initial board-level support for the P8700 Boston SoC.
> 
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
> Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
> ---
>  arch/riscv/Kconfig                      |  11 +
>  arch/riscv/dts/Makefile                 |   1 +
>  arch/riscv/dts/boston-p8700.dts         | 264 ++++++++++++++++++++++++
>  board/mips/boston-riscv/Kconfig         |  43 ++++
>  board/mips/boston-riscv/MAINTAINERS     |   9 +
>  board/mips/boston-riscv/Makefile        |   8 +
>  board/mips/boston-riscv/boston-lcd.h    |  20 ++
>  board/mips/boston-riscv/boston-regs.h   |  38 ++++
>  board/mips/boston-riscv/boston-riscv.c  |  30 +++
>  board/mips/boston-riscv/checkboard.c    |  43 ++++
>  board/mips/boston-riscv/config.mk       |  15 ++
>  board/mips/boston-riscv/lowlevel_init.S |  18 ++
>  board/mips/boston-riscv/reset.c         |  15 ++
>  configs/boston-p8700_defconfig          |  98 +++++++++
>  drivers/clk/Kconfig                     |   2 +-
>  include/configs/boston-riscv.h          |   9 +
>  16 files changed, 623 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/dts/boston-p8700.dts
>  create mode 100644 board/mips/boston-riscv/Kconfig
>  create mode 100644 board/mips/boston-riscv/MAINTAINERS
>  create mode 100644 board/mips/boston-riscv/Makefile
>  create mode 100644 board/mips/boston-riscv/boston-lcd.h
>  create mode 100644 board/mips/boston-riscv/boston-regs.h
>  create mode 100644 board/mips/boston-riscv/boston-riscv.c
>  create mode 100644 board/mips/boston-riscv/checkboard.c
>  create mode 100644 board/mips/boston-riscv/config.mk
>  create mode 100644 board/mips/boston-riscv/lowlevel_init.S
>  create mode 100644 board/mips/boston-riscv/reset.c
>  create mode 100644 configs/boston-p8700_defconfig
>  create mode 100644 include/configs/boston-riscv.h
> 
> ...
> diff --git a/board/mips/boston-riscv/Kconfig b/board/mips/boston-riscv/Kconfig
> new file mode 100644
> index 00000000000..68c5fc50489
> --- /dev/null
> +++ b/board/mips/boston-riscv/Kconfig
> @@ -0,0 +1,43 @@
> +if TARGET_MIPS_BOSTON
> +
> +config SYS_BOARD
> +	default "boston-riscv"
> +
> +config SYS_VENDOR
> +	default "mips"
> +
> +config SYS_CONFIG_NAME
> +	default "boston-riscv"
> +
> +config SYS_CPU
> +	default "p8700"
> +
> +config BOARD_SPECIFIC_OPTIONS
> +    def_bool y
> +    select P8700_RISCV
> +    imply SYS_NS16550
> +
> +config SYS_CACHELINE_SIZE
> +    default 64
> +
> +config SYS_SDRAM_BASE
> +    hex
> +    default 0x80000000
> +
> +config SYS_INIT_SP_ADDR
> +    hex
> +    default 0x80200000
> +
> +config STANDALONE_LOAD_ADDR
> +    hex
> +    default 0x80200000
> +
> +config SYS_MAX_FLASH_BANKS_DETECT
> +    bool
> +    default y
> +
> +config PHY_REALTEK
> +    bool
> +    default y
> +

Use tab instead of space.

> +endif
> diff --git a/board/mips/boston-riscv/MAINTAINERS b/board/mips/boston-riscv/MAINTAINERS
> new file mode 100644
> index 00000000000..e350121395e
> --- /dev/null
> +++ b/board/mips/boston-riscv/MAINTAINERS
> @@ -0,0 +1,9 @@
> +BOSTON-RISCV BOARD
> +M:	Chao-ying Fu <cfu@mips.com>
> +S:	Maintained
> +F:	board/mips/boston-riscv/
> +F:	include/configs/boston-riscv.h
> +F:  arch/riscv/cpu/p8700/
> +F:  arch/riscv/include/asm/arch-p8700/
> +F:  configs/boston-p8700_defconfig
> +F:  arch/riscv/dts/boston-p8700.dts

Ditto.

> diff --git a/board/mips/boston-riscv/Makefile b/board/mips/boston-riscv/Makefile
> new file mode 100644
> index 00000000000..0615c677d23
> --- /dev/null
> +++ b/board/mips/boston-riscv/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) 2016 Imagination Technologies
> +
> +obj-y += boston-riscv.o
> +obj-y += checkboard.o
> +obj-y += lowlevel_init.o
> +obj-y += reset.o
> diff --git a/board/mips/boston-riscv/boston-lcd.h b/board/mips/boston-riscv/boston-lcd.h
> new file mode 100644
> index 00000000000..5f5cd0fe126
> --- /dev/null
> +++ b/board/mips/boston-riscv/boston-lcd.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2016 Imagination Technologies
> + */
> +
> +#ifndef __BOARD_BOSTON_LCD_H__
> +#define __BOARD_BOSTON_LCD_H__
> +
> +/**
> + * lowlevel_display() - Display a message on Boston's LCD
> + * @msg: The string to display
> + *
> + * Display the string @msg on the 7 character LCD display of the Boston board.
> + * This is typically used for debug or to present some form of status
> + * indication to the user, allowing faults to be identified when things go
> + * wrong early enough that the UART isn't up.
> + */
> +void lowlevel_display(const char msg[static 8]);
> +
> +#endif /* __BOARD_BOSTON_LCD_H__ */
> diff --git a/board/mips/boston-riscv/boston-regs.h b/board/mips/boston-riscv/boston-regs.h
> new file mode 100644
> index 00000000000..4d5ea8833ab
> --- /dev/null
> +++ b/board/mips/boston-riscv/boston-regs.h
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2016 Imagination Technologies
> + */
> +
> +#ifndef __BOARD_BOSTON_REGS_H__
> +#define __BOARD_BOSTON_REGS_H__
> +
> +#ifndef BOSTON_PLAT_BASE
> +#define BOSTON_PLAT_BASE		(0x17ffd000)
> +#endif

This causes redefinition error.

> +#define BOSTON_LCD_BASE			(0x17fff000)
> +
> +/*
> + * Platform Register Definitions
> + */
> +#define BOSTON_PLAT_CORE_CL		(BOSTON_PLAT_BASE + 0x04)
> +
> +#define BOSTON_PLAT_SOFT_RST		(BOSTON_PLAT_BASE + 0x10)
> +#define BOSTON_PLAT_SOFT_RST_SYSTEM	(0x1 << 4)
> +
> +#define BOSTON_PLAT_DDR3STAT		(BOSTON_PLAT_BASE + 0x14)
> +#define BOSTON_PLAT_DDR3STAT_CALIB	(0x1 << 2)
> +
> +#define BOSTON_PLAT_BUILDCFG0           (BOSTON_PLAT_BASE + 0x34)
> +#define BOSTON_PLAT_BUILDCFG0_IOCU     (0x1 << 0)
> +#define BOSTON_PLAT_BUILDCFG0_PCIE0    (0x1 << 1)
> +#define BOSTON_PLAT_BUILDCFG0_PCIE1    (0x1 << 2)
> +#define BOSTON_PLAT_BUILDCFG0_PCIE2    (0x1 << 3)
> +#define BOSTON_PLAT_BUILDCFG0_CFG_LTR  (0xf << 4)
> +#define BOSTON_PLAT_BUILDCFG0_CFG_NUM  (0xff << 8)
> +#define BOSTON_PLAT_BUILDCFG0_DP       (0x1 << 24)
> +#define BOSTON_PLAT_BUILDCFG0_DP_MULT  (0xf << 28)
> +
> +#define BOSTON_PLAT_DDRCONF0		(BOSTON_PLAT_BASE + 0x38)
> +#define BOSTON_PLAT_DDRCONF0_SIZE	(0xf << 0)
> +
> ...
