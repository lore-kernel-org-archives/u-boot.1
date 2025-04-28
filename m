Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B7C8C3ABA4
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 14:01:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD92082A33;
	Mon, 28 Apr 2025 16:01:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69F0382A53; Mon, 28 Apr 2025 16:01:08 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 5DFB482A31
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 16:01:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28F271516;
 Mon, 28 Apr 2025 07:00:58 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6232E3F66E;
 Mon, 28 Apr 2025 07:01:03 -0700 (PDT)
Date: Mon, 28 Apr 2025 15:01:00 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: jagan@amarulasolutions.com, trini@konsulko.com, macromorgan@hotmail.com,
 uwu@icenowy.me, u-boot@lists.denx.de, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 5/5] sunxi: h6/h616: Reuse common DRAM infrastructure
Message-ID: <20250428150100.30950848@donnerap.manchester.arm.com>
In-Reply-To: <20250411161439.4743-6-jernej.skrabec@gmail.com>
References: <20250411161439.4743-1-jernej.skrabec@gmail.com>
 <20250411161439.4743-6-jernej.skrabec@gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 11 Apr 2025 18:14:39 +0200
Jernej Skrabec <jernej.skrabec@gmail.com> wrote:

> H616 rank and size detection code is superior to the H6. Nevertheless,
> they are structurally the same. Split functions from H616 into new file
> and reuse them in H6 DRAM driver too. This should also fix some bugs for
> H6 too, like incorrect DRAM size detection.

So as I dropped patch 1/5 for now, I also backed out the respective
changes from this patch.
The H616 part is basically identical before and after, but of course the
H6 sees code changes. I tested this on my two H6 boards, and they still
worked (TM), so I am going to take it.

> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  .../include/asm/arch-sunxi/dram_dw_helpers.h  |  22 +++
>  arch/arm/mach-sunxi/Makefile                  |   4 +-
>  arch/arm/mach-sunxi/dram_dw_helpers.c         | 160 ++++++++++++++++++
>  arch/arm/mach-sunxi/dram_sun50i_h6.c          |  91 +---------
>  arch/arm/mach-sunxi/dram_sun50i_h616.c        | 155 +----------------
>  5 files changed, 190 insertions(+), 242 deletions(-)
>  create mode 100644 arch/arm/include/asm/arch-sunxi/dram_dw_helpers.h
>  create mode 100644 arch/arm/mach-sunxi/dram_dw_helpers.c
> 
> diff --git a/arch/arm/include/asm/arch-sunxi/dram_dw_helpers.h b/arch/arm/include/asm/arch-sunxi/dram_dw_helpers.h
> new file mode 100644
> index 000000000000..bc9e0d868c55
> --- /dev/null
> +++ b/arch/arm/include/asm/arch-sunxi/dram_dw_helpers.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Helpers that are commonly used with DW memory controller.
> + *
> + * (C) Copyright 2025 Jernej Skrabec <jernej.skrabec@gmail.com>
> + *
> + */
> +
> +#ifndef _DRAM_DW_HELPERS_H
> +#define _DRAM_DW_HELPERS_H
> +
> +#include <asm/arch/dram.h>
> +
> +bool mctl_core_init(const struct dram_para *para,
> +		    const struct dram_config *config);
> +void mctl_auto_detect_rank_width(const struct dram_para *para,
> +				 struct dram_config *config);
> +void mctl_auto_detect_dram_size(const struct dram_para *para,
> +				struct dram_config *config);
> +unsigned long mctl_calc_size(const struct dram_config *config);
> +
> +#endif
> diff --git a/arch/arm/mach-sunxi/Makefile b/arch/arm/mach-sunxi/Makefile
> index eb6a49119a13..a33cd5b0f07a 100644
> --- a/arch/arm/mach-sunxi/Makefile
> +++ b/arch/arm/mach-sunxi/Makefile
> @@ -41,8 +41,8 @@ obj-$(CONFIG_DRAM_SUN9I)	+= dram_sun9i.o
>  obj-$(CONFIG_SPL_SPI_SUNXI)	+= spl_spi_sunxi.o
>  obj-$(CONFIG_SUNXI_DRAM_DW)	+= dram_sunxi_dw.o
>  obj-$(CONFIG_SUNXI_DRAM_DW)	+= dram_timings/
> -obj-$(CONFIG_DRAM_SUN50I_H6)	+= dram_sun50i_h6.o
> +obj-$(CONFIG_DRAM_SUN50I_H6)	+= dram_sun50i_h6.o dram_dw_helpers.o
>  obj-$(CONFIG_DRAM_SUN50I_H6)	+= dram_timings/
> -obj-$(CONFIG_DRAM_SUN50I_H616)	+= dram_sun50i_h616.o
> +obj-$(CONFIG_DRAM_SUN50I_H616)	+= dram_sun50i_h616.o dram_dw_helpers.o
>  obj-$(CONFIG_DRAM_SUN50I_H616)	+= dram_timings/
>  endif
> diff --git a/arch/arm/mach-sunxi/dram_dw_helpers.c b/arch/arm/mach-sunxi/dram_dw_helpers.c
> new file mode 100644
> index 000000000000..885d1f2c0b12
> --- /dev/null
> +++ b/arch/arm/mach-sunxi/dram_dw_helpers.c
> @@ -0,0 +1,160 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Helpers that are commonly used with DW memory controller.
> + *
> + * (C) Copyright 2025 Jernej Skrabec <jernej.skrabec@gmail.com>
> + *
> + */
> +
> +#include <init.h>
> +#include <asm/arch/dram_dw_helpers.h>
> +
> +void mctl_auto_detect_rank_width(const struct dram_para *para,
> +				 struct dram_config *config)
> +{
> +	/* this is minimum size that it's supported */
> +	config->cols = 8;
> +	config->rows = 13;
> +
> +	/*
> +	 * Strategy here is to test most demanding combination first and least
> +	 * demanding last, otherwise HW might not be fully utilized. For
> +	 * example, half bus width and rank = 1 combination would also work
> +	 * on HW with full bus width and rank = 2, but only 1/4 RAM would be
> +	 * visible.
> +	 */
> +
> +	debug("testing 32-bit width, rank = 2\n");
> +	config->bus_full_width = 1;
> +	config->ranks = 2;
> +	if (mctl_core_init(para, config))
> +		return;
> +
> +	debug("testing 32-bit width, rank = 1\n");
> +	config->bus_full_width = 1;
> +	config->ranks = 1;
> +	if (mctl_core_init(para, config))
> +		return;
> +
> +	debug("testing 16-bit width, rank = 2\n");
> +	config->bus_full_width = 0;
> +	config->ranks = 2;
> +	if (mctl_core_init(para, config))
> +		return;
> +
> +	debug("testing 16-bit width, rank = 1\n");
> +	config->bus_full_width = 0;
> +	config->ranks = 1;
> +	if (mctl_core_init(para, config))
> +		return;
> +
> +	panic("This DRAM setup is currently not supported.\n");
> +}
> +
> +static void mctl_write_pattern(void)
> +{
> +	unsigned int i;
> +	u32 *ptr, val;
> +
> +	ptr = (u32 *)CFG_SYS_SDRAM_BASE;
> +	for (i = 0; i < 16; ptr++, i++) {
> +		if (i & 1)
> +			val = ~(ulong)ptr;
> +		else
> +			val = (ulong)ptr;
> +		writel(val, ptr);
> +	}
> +}
> +
> +static bool mctl_check_pattern(ulong offset)
> +{
> +	unsigned int i;
> +	u32 *ptr, val;
> +
> +	ptr = (u32 *)CFG_SYS_SDRAM_BASE;
> +	for (i = 0; i < 16; ptr++, i++) {
> +		if (i & 1)
> +			val = ~(ulong)ptr;
> +		else
> +			val = (ulong)ptr;
> +		if (val != *(ptr + offset / 4))
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
> +void mctl_auto_detect_dram_size(const struct dram_para *para,
> +				struct dram_config *config)
> +{
> +	unsigned int shift, cols, rows, found;
> +	u32 buffer[16];
> +
> +	/* max. config for columns, but not rows */
> +	config->cols = 11;
> +	config->rows = 13;
> +	mctl_core_init(para, config);
> +
> +	/*
> +	 * Store content so it can be restored later. This is important
> +	 * if controller was already initialized and holds any data
> +	 * which is important for restoring system.
> +	 */
> +	memcpy(buffer, (u32 *)CFG_SYS_SDRAM_BASE, sizeof(buffer));
> +
> +	mctl_write_pattern();
> +
> +	shift = config->bus_full_width + 1;
> +
> +	/* detect column address bits */
> +	found = 0;
> +	for (cols = 8; cols < 11; cols++) {
> +		if (mctl_check_pattern(1ULL << (cols + shift))) {
> +			found = 1;
> +			break;
> +		}
> +	}
> +	if (!found)
> +		panic("DRAM init failed: Can't detect number of columns!");
> +	debug("detected %u columns\n", cols);
> +
> +	/* restore data */
> +	memcpy((u32 *)CFG_SYS_SDRAM_BASE, buffer, sizeof(buffer));
> +
> +	/* reconfigure to make sure that all active rows are accessible */
> +	config->cols = 8;
> +	config->rows = 17;
> +	mctl_core_init(para, config);
> +
> +	/* store data again as it might be moved */
> +	memcpy(buffer, (u32 *)CFG_SYS_SDRAM_BASE, sizeof(buffer));
> +
> +	mctl_write_pattern();
> +
> +	/* detect row address bits */
> +	shift = config->bus_full_width + 4 + config->cols;
> +	found = 0;
> +	for (rows = 13; rows < 17; rows++) {
> +		if (mctl_check_pattern(1ULL << (rows + shift))) {
> +			found = 1;
> +			break;
> +		}
> +	}
> +	if (!found)
> +		panic("DRAM init failed: Can't detect number of rows!");
> +	debug("detected %u rows\n", rows);
> +
> +	/* restore data again */
> +	memcpy((u32 *)CFG_SYS_SDRAM_BASE, buffer, sizeof(buffer));
> +
> +	config->cols = cols;
> +	config->rows = rows;
> +}
> +
> +unsigned long mctl_calc_size(const struct dram_config *config)
> +{
> +	u8 width = config->bus_full_width ? 4 : 2;
> +
> +	/* 8 banks */
> +	return (1ULL << (config->cols + config->rows + 3)) * width * config->ranks;
> +}
> diff --git a/arch/arm/mach-sunxi/dram_sun50i_h6.c b/arch/arm/mach-sunxi/dram_sun50i_h6.c
> index 6a9e53f965eb..fbb865131e08 100644
> --- a/arch/arm/mach-sunxi/dram_sun50i_h6.c
> +++ b/arch/arm/mach-sunxi/dram_sun50i_h6.c
> @@ -10,6 +10,7 @@
>  #include <asm/io.h>
>  #include <asm/arch/clock.h>
>  #include <asm/arch/dram.h>
> +#include <asm/arch/dram_dw_helpers.h>
>  #include <asm/arch/cpu.h>
>  #include <asm/arch/prcm.h>
>  #include <linux/bitops.h>
> @@ -40,8 +41,8 @@ static void mctl_com_init(const struct dram_para *para,
>  static bool mctl_channel_init(const struct dram_para *para,
>  			      const struct dram_config *config);
>  
> -static bool mctl_core_init(const struct dram_para *para,
> -			   const struct dram_config *config)
> +bool mctl_core_init(const struct dram_para *para,
> +		    const struct dram_config *config)
>  {
>  	mctl_sys_init(para->clk);
>  	mctl_com_init(para, config);
> @@ -560,92 +561,6 @@ static bool mctl_channel_init(const struct dram_para *para,
>  	return true;
>  }
>  
> -static void mctl_auto_detect_rank_width(const struct dram_para *para,
> -					struct dram_config *config)
> -{
> -	/* this is minimum size that it's supported */
> -	config->cols = 8;
> -	config->rows = 13;
> -
> -	/*
> -	 * Previous versions of this driver tried to auto detect the rank
> -	 * and width by looking at controller registers. However this proved
> -	 * to be not reliable, so this approach here is the more robust
> -	 * solution. Check the git history for details.
> -	 *
> -	 * Strategy here is to test most demanding combination first and least
> -	 * demanding last, otherwise HW might not be fully utilized. For
> -	 * example, half bus width and rank = 1 combination would also work
> -	 * on HW with full bus width and rank = 2, but only 1/4 RAM would be
> -	 * visible.
> -	 */
> -
> -	debug("testing 32-bit width, rank = 2\n");
> -	config->bus_full_width = 1;
> -	config->ranks = 2;
> -	if (mctl_core_init(para, config))
> -		return;
> -
> -	debug("testing 32-bit width, rank = 1\n");
> -	config->bus_full_width = 1;
> -	config->ranks = 1;
> -	if (mctl_core_init(para, config))
> -		return;
> -
> -	debug("testing 16-bit width, rank = 2\n");
> -	config->bus_full_width = 0;
> -	config->ranks = 2;
> -	if (mctl_core_init(para, config))
> -		return;
> -
> -	debug("testing 16-bit width, rank = 1\n");
> -	config->bus_full_width = 0;
> -	config->ranks = 1;
> -	if (mctl_core_init(para, config))
> -		return;
> -
> -	panic("This DRAM setup is currently not supported.\n");
> -}
> -
> -static void mctl_auto_detect_dram_size(const struct dram_para *para,
> -				       struct dram_config *config)
> -{
> -	/* TODO: non-(LP)DDR3 */
> -
> -	/* detect row address bits */
> -	config->cols = 8;
> -	config->rows = 18;
> -	mctl_core_init(para, config);
> -
> -	for (config->rows = 13; config->rows < 18; config->rows++) {
> -		/* 8 banks, 8 bit per byte and 16/32 bit width */
> -		if (mctl_mem_matches((1 << (config->rows + config->cols +
> -					    4 + config->bus_full_width))))
> -			break;
> -	}
> -
> -	/* detect column address bits */
> -	config->cols = 11;
> -	mctl_core_init(para, config);
> -
> -	for (config->cols = 8; config->cols < 11; config->cols++) {
> -		/* 8 bits per byte and 16/32 bit width */
> -		if (mctl_mem_matches(1 << (config->cols + 1 +
> -					   config->bus_full_width)))
> -			break;
> -	}
> -}
> -
> -unsigned long mctl_calc_size(const struct dram_config *config)
> -{
> -	u8 width = config->bus_full_width ? 4 : 2;
> -
> -	/* TODO: non-(LP)DDR3 */
> -
> -	/* 8 banks */
> -	return (1ULL << (config->cols + config->rows + 3)) * width * config->ranks;
> -}
> -
>  #define SUN50I_H6_LPDDR3_DX_WRITE_DELAYS			\
>  	{{  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0 },	\
>  	 {  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0 },	\
> diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
> index d1768a7e7d3a..80d9de557876 100644
> --- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
> +++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
> @@ -17,6 +17,7 @@
>  #include <asm/io.h>
>  #include <asm/arch/clock.h>
>  #include <asm/arch/dram.h>
> +#include <asm/arch/dram_dw_helpers.h>
>  #include <asm/arch/cpu.h>
>  #include <asm/arch/prcm.h>
>  #include <linux/bitops.h>
> @@ -1310,164 +1311,14 @@ static bool mctl_ctrl_init(const struct dram_para *para,
>  	return true;
>  }
>  
> -static bool mctl_core_init(const struct dram_para *para,
> -			   const struct dram_config *config)
> +bool mctl_core_init(const struct dram_para *para,
> +		    const struct dram_config *config)
>  {
>  	mctl_sys_init(para->clk);
>  
>  	return mctl_ctrl_init(para, config);
>  }
>  
> -static void mctl_auto_detect_rank_width(const struct dram_para *para,
> -					struct dram_config *config)
> -{
> -	/* this is minimum size that it's supported */
> -	config->cols = 8;
> -	config->rows = 13;
> -
> -	/*
> -	 * Strategy here is to test most demanding combination first and least
> -	 * demanding last, otherwise HW might not be fully utilized. For
> -	 * example, half bus width and rank = 1 combination would also work
> -	 * on HW with full bus width and rank = 2, but only 1/4 RAM would be
> -	 * visible.
> -	 */
> -
> -	debug("testing 32-bit width, rank = 2\n");
> -	config->bus_full_width = 1;
> -	config->ranks = 2;
> -	if (mctl_core_init(para, config))
> -		return;
> -
> -	debug("testing 32-bit width, rank = 1\n");
> -	config->bus_full_width = 1;
> -	config->ranks = 1;
> -	if (mctl_core_init(para, config))
> -		return;
> -
> -	debug("testing 16-bit width, rank = 2\n");
> -	config->bus_full_width = 0;
> -	config->ranks = 2;
> -	if (mctl_core_init(para, config))
> -		return;
> -
> -	debug("testing 16-bit width, rank = 1\n");
> -	config->bus_full_width = 0;
> -	config->ranks = 1;
> -	if (mctl_core_init(para, config))
> -		return;
> -
> -	panic("This DRAM setup is currently not supported.\n");
> -}
> -
> -static void mctl_write_pattern(void)
> -{
> -	unsigned int i;
> -	u32 *ptr, val;
> -
> -	ptr = (u32 *)CFG_SYS_SDRAM_BASE;
> -	for (i = 0; i < 16; ptr++, i++) {
> -		if (i & 1)
> -			val = ~(ulong)ptr;
> -		else
> -			val = (ulong)ptr;
> -		writel(val, ptr);
> -	}
> -}
> -
> -static bool mctl_check_pattern(ulong offset)
> -{
> -	unsigned int i;
> -	u32 *ptr, val;
> -
> -	ptr = (u32 *)CFG_SYS_SDRAM_BASE;
> -	for (i = 0; i < 16; ptr++, i++) {
> -		if (i & 1)
> -			val = ~(ulong)ptr;
> -		else
> -			val = (ulong)ptr;
> -		if (val != *(ptr + offset / 4))
> -			return false;
> -	}
> -
> -	return true;
> -}
> -
> -static void mctl_auto_detect_dram_size(const struct dram_para *para,
> -				       struct dram_config *config)
> -{
> -	unsigned int shift, cols, rows, found;
> -	u32 buffer[16];
> -
> -	/* max. config for columns, but not rows */
> -	config->cols = 11;
> -	config->rows = 13;
> -	mctl_core_init(para, config);
> -
> -	/*
> -	 * Store content so it can be restored later. This is important
> -	 * if controller was already initialized and holds any data
> -	 * which is important for restoring system.
> -	 */
> -	memcpy(buffer, (u32 *)CFG_SYS_SDRAM_BASE, sizeof(buffer));
> -
> -	mctl_write_pattern();
> -
> -	shift = config->bus_full_width + 1;
> -
> -	/* detect column address bits */
> -	found = 0;
> -	for (cols = 8; cols < 11; cols++) {
> -		if (mctl_check_pattern(1ULL << (cols + shift))) {
> -			found = 1;
> -			break;
> -		}
> -	}
> -	if (!found)
> -		panic("DRAM init failed: Can't detect number of columns!");
> -	debug("detected %u columns\n", cols);
> -
> -	/* restore data */
> -	memcpy((u32 *)CFG_SYS_SDRAM_BASE, buffer, sizeof(buffer));
> -
> -	/* reconfigure to make sure that all active rows are accessible */
> -	config->cols = 8;
> -	config->rows = 17;
> -	mctl_core_init(para, config);
> -
> -	/* store data again as it might be moved */
> -	memcpy(buffer, (u32 *)CFG_SYS_SDRAM_BASE, sizeof(buffer));
> -
> -	mctl_write_pattern();
> -
> -	/* detect row address bits */
> -	shift = config->bus_full_width + 4 + config->cols;
> -	found = 0;
> -	for (rows = 13; rows < 17; rows++) {
> -		if (mctl_check_pattern(1ULL << (rows + shift))) {
> -			found = 1;
> -			break;
> -		}
> -	}
> -	if (!found)
> -		panic("DRAM init failed: Can't detect number of rows!");
> -	debug("detected %u rows\n", rows);
> -
> -	/* restore data again */
> -	memcpy((u32 *)CFG_SYS_SDRAM_BASE, buffer, sizeof(buffer));
> -
> -	config->cols = cols;
> -	config->rows = rows;
> -}
> -
> -static unsigned long mctl_calc_size(const struct dram_config *config)
> -{
> -	u8 width = config->bus_full_width ? 4 : 2;
> -
> -	/* 8 banks */
> -	return (1ULL << (config->cols + config->rows + 3)) * width * config->ranks;
> -}
> -
>  static const struct dram_para para = {
>  	.clk = CONFIG_DRAM_CLK,
>  #ifdef CONFIG_SUNXI_DRAM_H616_DDR3_1333

