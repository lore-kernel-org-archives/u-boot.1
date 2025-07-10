Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466A5C83F1B
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 16:22:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7209183653;
	Thu, 10 Jul 2025 18:21:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="ccssNxzI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17BEA83666; Thu, 10 Jul 2025 18:21:58 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BFEF8362C
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 18:21:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 3A5FE2025F;
 Thu, 10 Jul 2025 18:21:55 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N99JOvlpHosh; Thu, 10 Jul 2025 18:21:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1752164512; bh=Fi6WgaUGVwYQ3caJyoAx3uY4yWGWfG1yOJBKgg5qwSE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ccssNxzIClyvssfyOaRzx1IA31qptLUYcW2vwUuVJpKL55AyzaQol+NKrHQQPr4nn
 UDjs4tDoREhI4CM0I4V/fR891usEC2KFsYtk1m8VqdshHsdJGQ4wJxredNkxAHjnX/
 QKoRps5hwTlJAIBldLOPA42EjbHXu8r/GoJ1HSxxp6JJX3RYIxz86ExAX1vJ9xzPvQ
 5cebF8LHoZlGdkpAk0TDzjvzP4c4UyOEcmoMVKsRRiZLUFdibCJbK2UPEZoLufcq2H
 2alDrZQU2BahM4cSSW+AGKl1rO8/76oEQjE6c3UJGxMp5CMxeEIcgWZ626elrB0TFH
 45ZvyDJt7A+Rw==
Date: Thu, 10 Jul 2025 16:21:37 +0000
From: Yao Zi <ziyao@disroot.org>
To: Uros Stajic <uros.stajic@htecgroup.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Chao-ying Fu <cfu@mips.com>
Subject: Re: [PATCH v2 01/11] riscv: Add initial support for P8700 SoC
Message-ID: <aG_okTanKFAwOCjQ@pie.lan>
References: <20250624102449.324410-1-uros.stajic@htecgroup.com>
 <20250624102449.324410-2-uros.stajic@htecgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624102449.324410-2-uros.stajic@htecgroup.com>
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

On Tue, Jun 24, 2025 at 10:25:30AM +0000, Uros Stajic wrote:
> From: Chao-ying Fu <cfu@mips.com>
> 
> Add initial platform support for the P8700-F, a high-performance
> multi-core RV64GC SoC with optional multi-cluster configuration and
> hardware multithreading.
> 
> This patch implements initial support required for U-Boot to run on
> the P8700-based Boston board.
> 
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
> ---
>  arch/riscv/Kconfig                          |  11 +
>  arch/riscv/cpu/Makefile                     |   2 +
>  arch/riscv/cpu/p8700/Kconfig                |  15 ++
>  arch/riscv/cpu/p8700/Makefile               |   7 +
>  arch/riscv/cpu/p8700/cache.c                |  74 ++++++
>  arch/riscv/cpu/p8700/cpu.c                  |  22 ++
>  arch/riscv/cpu/p8700/dram.c                 |  37 +++
>  arch/riscv/cpu/p8700/p8700_platform_setup.S | 155 ++++++++++++
>  arch/riscv/cpu/start.S                      |   8 +
>  arch/riscv/dts/Makefile                     |   1 +
>  arch/riscv/dts/boston-p8700.dts             | 253 ++++++++++++++++++++
>  arch/riscv/include/asm/arch-p8700/p8700.h   | 110 +++++++++
>  board/mips/boston-riscv/Kconfig             |  43 ++++
>  board/mips/boston-riscv/MAINTAINERS         |   9 +
>  board/mips/boston-riscv/Makefile            |   8 +
>  board/mips/boston-riscv/boston-lcd.h        |  20 ++
>  board/mips/boston-riscv/boston-regs.h       |  38 +++
>  board/mips/boston-riscv/boston-riscv.c      |   9 +
>  board/mips/boston-riscv/checkboard.c        |  43 ++++
>  board/mips/boston-riscv/config.mk           |  15 ++
>  board/mips/boston-riscv/lowlevel_init.S     |  18 ++
>  board/mips/boston-riscv/reset.c             |  15 ++
>  configs/boston-p8700_defconfig              |  94 ++++++++
>  drivers/clk/Kconfig                         |   2 +-
>  include/asm-generic/global_data.h           |   5 +
>  include/configs/boston-riscv.h              |  11 +
>  26 files changed, 1024 insertions(+), 1 deletion(-)

It's a relatively large patch, and it'll be nice if you could split it
into several smaller ones, for exampe, one for CPU stuff and one for
board stuff.

>  create mode 100644 arch/riscv/cpu/p8700/Kconfig
>  create mode 100644 arch/riscv/cpu/p8700/Makefile
>  create mode 100644 arch/riscv/cpu/p8700/cache.c
>  create mode 100644 arch/riscv/cpu/p8700/cpu.c
>  create mode 100644 arch/riscv/cpu/p8700/dram.c
>  create mode 100644 arch/riscv/cpu/p8700/p8700_platform_setup.S
>  create mode 100644 arch/riscv/dts/boston-p8700.dts
>  create mode 100644 arch/riscv/include/asm/arch-p8700/p8700.h
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

...

> diff --git a/arch/riscv/cpu/Makefile b/arch/riscv/cpu/Makefile
> index 6bf6f911c67..38894861694 100644
> --- a/arch/riscv/cpu/Makefile
> +++ b/arch/riscv/cpu/Makefile
> @@ -5,3 +5,5 @@
>  extra-y = start.o
>  
>  obj-y += cpu.o mtrap.o
> +
> +obj-$(CONFIG_P8700_RISCV) += p8700/p8700_platform_setup.o

This could be moved to arch/riscv/cpu/p8700/Makefile. It seems more
natural to me since arch/riscv/cpu/p8700 contains p8700_platform_setup.S

...

> diff --git a/arch/riscv/cpu/p8700/Makefile b/arch/riscv/cpu/p8700/Makefile
> new file mode 100644
> index 00000000000..ecdd232da6f
> --- /dev/null
> +++ b/arch/riscv/cpu/p8700/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright (C) 2021, Chao-ying Fu <cfu@mips.com>
> +
> +obj-y += dram.o
> +obj-y += cpu.o
> +obj-y += cache.o

It'll be nice to sort the files in alphabetical order. Same for headers
included in files below.

> diff --git a/arch/riscv/cpu/p8700/cache.c b/arch/riscv/cpu/p8700/cache.c
> new file mode 100644
> index 00000000000..27641035d80
> --- /dev/null
> +++ b/arch/riscv/cpu/p8700/cache.c
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2021, Chao-ying Fu <cfu@mips.com>
> + */
> +
> +#include <cpu_func.h>
> +#include <asm/global_data.h>
> +#include <asm/arch-p8700/p8700.h>
> +
> +/* NOTE: We force to use a0 in mcache to encode via .word. */
> +#define cache_loop(start, end, lsize, op) do {				\
> +	const __typeof__(lsize) __lsize = (lsize);			\
> +	const register void *addr asm("a0") = (const void *)((start) & ~(__lsize - 1));	\
> +	const void *aend = (const void *)(((end) - 1) & ~(__lsize - 1));	\
> +	for (; addr <= aend; addr += __lsize)				\
> +		asm volatile (".word 0xec0500f3|%0 # force to use %1" \
> +								::"i"((op) << 20), "r"(addr));	\

It's unclear what the magical instruction does, could you please add a
comment and use a meaningful macro to make it easier to understand?

> +} while (0)
> +
> +static unsigned long lsize;
> +static unsigned long l1d_total_size;
> +static unsigned long slsize;
> +
> +static void probe_cache_config(void)
> +{
> +	lsize = 64;
> +	l1d_total_size = 64 * 1024;
> +
> +	int l2_config = 0;
> +	long address = GCR_L2_CONFIG;
> +
> +	asm volatile ("lw %0,0(%1)" : "=r"(l2_config) : "r"(address) : "memory");

Is it really necessary to use inline assembly? If GCR_L2_CONFIG is an
MMIO register, readl() should work here.

> +	int l2_line_size_info = (l2_config >> L2_LINE_SIZE_SHIFT)
> +				& L2_LINE_SIZE_MASK;
> +	slsize = (l2_line_size_info == 0) ? 0 : 1 << (l2_line_size_info + 1);
> +}
> +
> +void flush_dcache_range(unsigned long start, unsigned long end)
> +{
> +	if (lsize == 0)
> +		probe_cache_config();
> +
> +	/* aend will be miscalculated when size is zero, so we return here */
> +	if (start >= end)
> +		return;
> +
> +	cache_loop(start, end, lsize, HIT_WRITEBACK_INV_D);
> +
> +	/* flush L2 cache */
> +	if (slsize)
> +		cache_loop(start, end, slsize, HIT_WRITEBACK_INV_SD);
> +
> +	/* ensure cache ops complete before any further memory access */
> +	asm volatile ("slli x0,x0,1 # ihb");

This instruction also looks confusing: slli usually means left-shift
with an immediate in the context of RISC-V, which obviously doesn't
match the corresponding comment. Could you please provide a macro for
the instruction, and explain it further if possible? This applies also
for the asm statement in invalidate_dcache_range().

> +}
> +
> +void invalidate_dcache_range(unsigned long start, unsigned long end)
> +{
> +	if (lsize == 0)
> +		probe_cache_config();
> +
> +	/* aend will be miscalculated when size is zero, so we return here */
> +	if (start >= end)
> +		return;
> +
> +	/* invalidate L2 cache */
> +	if (slsize)
> +		cache_loop(start, end, slsize, HIT_INVALIDATE_SD);
> +
> +	cache_loop(start, end, lsize, HIT_INVALIDATE_D);
> +
> +	/* ensure cache ops complete before any further memory access */
> +	asm volatile ("slli x0,x0,1 # ihb");
> +}
> diff --git a/arch/riscv/cpu/p8700/cpu.c b/arch/riscv/cpu/p8700/cpu.c
> new file mode 100644
> index 00000000000..f13c18942f3
> --- /dev/null
> +++ b/arch/riscv/cpu/p8700/cpu.c
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
> + */
> +
> +#include <irq_func.h>
> +#include <asm/cache.h>
> +
> +/*
> + * cleanup_before_linux() is called just before we call linux
> + * it prepares the processor for linux
> + *
> + * we disable interrupt and caches.
> + */
> +int cleanup_before_linux(void)
> +{
> +	disable_interrupts();
> +
> +	cache_flush();
> +
> +	return 0;
> +}

We have a weak, general implementation in arch/riscv/cpu.c, thus the
whole file could be dropped.

...

> diff --git a/arch/riscv/cpu/p8700/p8700_platform_setup.S b/arch/riscv/cpu/p8700/p8700_platform_setup.S
> new file mode 100644
> index 00000000000..c2999045175
> --- /dev/null
> +++ b/arch/riscv/cpu/p8700/p8700_platform_setup.S
> @@ -0,0 +1,155 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2021, Chao-ying Fu <cfu@mips.com>
> + */
> +
> +#include <asm-offsets.h>
> +#include <config.h>
> +#include <elf.h>
> +#include <system-constants.h>
> +#include <asm/encoding.h>
> +#include <generated/asm-offsets.h>
> +#include <asm/arch-p8700/p8700.h>
> +
> +.global p8700_platform_setup
> +.global set_flash_uncached
> +
> +p8700_platform_setup:
> +	move s6, ra
> +	li	x1,0
> +	li	x2,0
> +	li	x3,0
> +	li	x4,0
> +	li	x5,0
> +	li	x6,0
> +	li	x7,0
> +	li	x8,0
> +	li	x9,0
> +	li	x10,0
> +	li	x11,0
> +	li	x12,0
> +	li	x13,0
> +	li	x14,0
> +	li	x15,0
> +	li	x16,0
> +	li	x17,0
> +	li	x18,0
> +	li	x19,0
> +	li	x20,0
> +	li	x21,0
> +	li	x23,0
> +	li	x24,0
> +	li	x25,0
> +	li	x26,0
> +	li	x27,0
> +	li	x28,0
> +	li	x29,0
> +	li	x30,0
> +	li	x31,0

These instructions miss some space between the two operands.

...

> +	/* Map all PCIe DMA access to its default, non-IOCU, target */
> +	li	t0,BOSTON_PLAT_NOCPCIE0ADDR
> +	sw	zero, 0(t0)
> +	li	t0,BOSTON_PLAT_NOCPCIE1ADDR
> +	sw	zero, 0(t0)
> +	li	t0,BOSTON_PLAT_NOCPCIE2ADDR
> +	sw	zero, 0(t0)

Here miss some space between the two operands of the li instructions.

> +	/* Test mhartid */
> +	beq	a0, zero, 1f
> +	/* Jump to 0x80000000 */
> +	li	t0, 0x80000000

Why choose this specific address? If possible please use a macro instead
(I noticed it's actually CONFIG_SYS_LOAD_ADDR).

> +	jr	t0

...

> diff --git a/arch/riscv/cpu/start.S b/arch/riscv/cpu/start.S
> index 7bafdfd390a..e36abb5957b 100644
> --- a/arch/riscv/cpu/start.S
> +++ b/arch/riscv/cpu/start.S
> @@ -39,6 +39,10 @@ secondary_harts_relocation_error:
>  .section .text
>  .globl _start
>  _start:
> +#ifdef CONFIG_P8700_RISCV
> +	call p8700_platform_setup
> +#endif
> +
>  #if CONFIG_IS_ENABLED(RISCV_MMODE)
>  	csrr	a0, CSR_MHARTID
>  #endif
> @@ -416,6 +420,10 @@ call_board_init_r:
>  	mv	a1, s4			/* dest_addr */
>  	mv	s0, zero		/* fp == NULL */
>  
> +#ifdef CONFIG_P8700_RISCV
> +	call set_flash_uncached
> +#endif

Is it necessary to call these initialization rountines so early that
even harts_early_init() doesn't work? It really doesn't look clean
especially IIRC there's no platform-specific code in
arch/riscv/cpu/start.S.

>  /*
>   * jump to it ...
>   */

...

> diff --git a/arch/riscv/dts/boston-p8700.dts b/arch/riscv/dts/boston-p8700.dts
> new file mode 100644
> index 00000000000..6d700a5675c
> --- /dev/null
> +++ b/arch/riscv/dts/boston-p8700.dts
> @@ -0,0 +1,253 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2021, Chao-ying Fu <cfu@mips.com>
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/clock/boston-clock.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/mips-gic.h>
> +
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	model = "p8700";
> +	compatible = "img,boston";
> +
> +	chosen {
> +		stdout-path = &uart0;
> +		bootargs = "root=/dev/sda rw earlycon console=ttyS0,115200n8r";
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		timebase-frequency = <20000000>;
> +
> +		cpu@0 {
> +			device_type = "cpu";
> +			compatible = "riscv";
> +			mmu-type = "riscv,sv39";
> +			riscv,isa = "rv64imafdcsu";

riscv,isa is already deprecated in devicetree-binding upstream, it'll
be nice if you could provide a riscv,isa-extensions property as well.

> +			status = "okay";
> +			reg = <0>;
> +			clocks = <&clk_boston BOSTON_CLK_CPU>;
> +			clock-frequency = <20000000>;
> +			bootph-all;

These properties should be sorted, compatible goes first, then reg, and
status should be the last property[1]. This should apply for other nodes
as well.

> +		};
> +	};

Regards,
Yao Zi
