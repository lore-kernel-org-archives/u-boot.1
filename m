Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E8EC36010
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 22:02:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E15D82ABA;
	Sun,  6 Apr 2025 00:02:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D046A82ACF; Sun,  6 Apr 2025 00:02:05 +0200 (CEST)
Received: from smtp.gentoo.org (smtp.gentoo.org
 [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A72F82AB2
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 00:02:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from localhost (unknown [116.232.27.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id 7F2BC343178;
 Sat, 05 Apr 2025 22:02:00 +0000 (UTC)
Date: Sat, 5 Apr 2025 22:01:50 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Mikhail Kalashnikov <iuncuim@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 30/34] sunxi: A523: add DRAM initialisation routine
Message-ID: <20250405215823-GYA11067@gentoo>
References: <20250323113544.7933-1-andre.przywara@arm.com>
 <20250323113544.7933-31-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250323113544.7933-31-andre.przywara@arm.com>
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

Hi Andre:

On 11:35 Sun 23 Mar     , Andre Przywara wrote:
> From: Jernej Skrabec <jernej.skrabec@gmail.com>
> 
> DRAM init code, as per reverse engineering and matching against
> previous SoCs.
> Supports LPDDR4 for now only.
> ---
>  arch/arm/include/asm/arch-sunxi/dram.h        |    2 +
>  .../include/asm/arch-sunxi/dram_sun55i_a523.h |  183 ++
>  arch/arm/mach-sunxi/Kconfig                   |   31 +-
>  arch/arm/mach-sunxi/Makefile                  |    2 +
>  arch/arm/mach-sunxi/dram_sun55i_a523.c        | 1468 +++++++++++++++++
>  arch/arm/mach-sunxi/dram_timings/Makefile     |    1 +
>  .../arm/mach-sunxi/dram_timings/a523_lpddr4.c |  119 ++
>  7 files changed, 1804 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/include/asm/arch-sunxi/dram_sun55i_a523.h
>  create mode 100644 arch/arm/mach-sunxi/dram_sun55i_a523.c
>  create mode 100644 arch/arm/mach-sunxi/dram_timings/a523_lpddr4.c
> 
> diff --git a/arch/arm/include/asm/arch-sunxi/dram.h b/arch/arm/include/asm/arch-sunxi/dram.h
> index 9d21b492418..9676c747442 100644
> --- a/arch/arm/include/asm/arch-sunxi/dram.h
> +++ b/arch/arm/include/asm/arch-sunxi/dram.h
> @@ -33,6 +33,8 @@
>  #include <asm/arch/dram_sun50i_h616.h>
>  #elif defined(CONFIG_MACH_SUNIV)
>  #include <asm/arch/dram_suniv.h>
> +#elif defined(CONFIG_MACH_SUN55I_A523)
> +#include <asm/arch/dram_sun55i_a523.h>
>  #else
>  #include <asm/arch/dram_sun4i.h>
>  #endif
> diff --git a/arch/arm/include/asm/arch-sunxi/dram_sun55i_a523.h b/arch/arm/include/asm/arch-sunxi/dram_sun55i_a523.h
> new file mode 100644
> index 00000000000..24e487b6880
> --- /dev/null
> +++ b/arch/arm/include/asm/arch-sunxi/dram_sun55i_a523.h
> @@ -0,0 +1,183 @@
> +/*
> + * t527 dram controller register and constant defines
> + *
> + * (C) Copyright 2024  Jernej Skrabec <jernej.skrabec@gmail.com>
> + *
> + * SPDX-License-Identifier:	GPL-2.0+
> + */
> +
> +#ifndef _SUNXI_DRAM_SUN55I_A523_H
> +#define _SUNXI_DRAM_SUN55I_A523_H
> +
> +#include <stdbool.h>
> +#ifndef __ASSEMBLY__
> +#include <linux/bitops.h>
> +#endif
> +
> +enum sunxi_dram_type {
> +	SUNXI_DRAM_TYPE_DDR3 = 3,
> +	SUNXI_DRAM_TYPE_DDR4,
> +	SUNXI_DRAM_TYPE_LPDDR3 = 7,
> +	SUNXI_DRAM_TYPE_LPDDR4
> +};
> +
> +/* MBUS part is largely the same as in H6, except for one special register */
> +struct sunxi_mctl_com_reg {
> +	u32 cr;			/* 0x000 control register */
> +	u8 reserved_0x004[4];	/* 0x004 */
> +	u32 unk_0x008;		/* 0x008 */
> +	u32 tmr;		/* 0x00c timer register */
> +	u8 reserved_0x010[4];	/* 0x010 */
> +	u32 unk_0x014;		/* 0x014 */
> +	u8 reserved_0x018[8];	/* 0x018 */
> +	u32 unk_0x020;		/* 0x020 */
> +	u32 unk_0x024;		/* 0x024 */
> +	u32 unk_0x028;		/* 0x028 */
> +	u8 reserved_0x02c[468];	/* 0x02c */
> +	u32 bwcr;		/* 0x200 bandwidth control register */
> +	u8 reserved_0x204[12];	/* 0x204 */
> +	/*
> +	 * The last master configured by BSP libdram is at 0x49x, so the
> +	 * size of this struct array is set to 41 (0x29) now.
> +	 */
> +	struct {
> +		u32 cfg0;		/* 0x0 */
> +		u32 cfg1;		/* 0x4 */
> +		u8 reserved_0x8[8];	/* 0x8 */
> +	} master[41];		/* 0x210 + index * 0x10 */
> +	u8 reserved_0x4a0[96];	/* 0x4a0 */
> +	u32 unk_0x500;		/* 0x500 */
> +};
> +check_member(sunxi_mctl_com_reg, unk_0x500, 0x500);
> +
> +/*
> + * Controller registers seems to be the same or at least very similar
> + * to those in H6.
> + */
> +struct sunxi_mctl_ctl_reg {
> +	u32 mstr;		/* 0x000 */
> +	u32 statr;		/* 0x004 unused */
> +	u32 mstr1;		/* 0x008 unused */
> +	u32 clken;		/* 0x00c */
> +	u32 mrctrl0;		/* 0x010 unused */
> +	u32 mrctrl1;		/* 0x014 unused */
> +	u32 mrstatr;		/* 0x018 unused */
> +	u32 mrctrl2;		/* 0x01c unused */
> +	u32 derateen;		/* 0x020 unused */
> +	u32 derateint;		/* 0x024 unused */
> +	u8 reserved_0x028[8];	/* 0x028 */
> +	u32 pwrctl;		/* 0x030 */
> +	u32 pwrtmg;		/* 0x034 unused */
> +	u32 hwlpctl;		/* 0x038 */
> +	u8 reserved_0x03c[20];	/* 0x03c */
> +	u32 rfshctl0;		/* 0x050 unused */
> +	u32 rfshctl1;		/* 0x054 unused */
> +	u8 reserved_0x058[8];	/* 0x05c */
> +	u32 rfshctl3;		/* 0x060 */
> +	u32 rfshtmg;		/* 0x064 */
> +	u8 reserved_0x068[104];	/* 0x068 */
> +	u32 init[8];		/* 0x0d0 */
> +	u32 dimmctl;		/* 0x0f0 unused */
> +	u32 rankctl;		/* 0x0f4 */
> +	u8 reserved_0x0f8[8];	/* 0x0f8 */
> +	u32 dramtmg[17];	/* 0x100 */
> +	u8 reserved_0x144[60];	/* 0x144 */
> +	u32 zqctl[3];		/* 0x180 */
> +	u32 zqstat;		/* 0x18c unused */
> +	u32 dfitmg0;		/* 0x190 */
> +	u32 dfitmg1;		/* 0x194 */
> +	u32 dfilpcfg[2];	/* 0x198 unused */
> +	u32 dfiupd[3];		/* 0x1a0 */
> +	u32 reserved_0x1ac;	/* 0x1ac */
> +	u32 dfimisc;		/* 0x1b0 */
> +	u32 dfitmg2;		/* 0x1b4 unused */
> +	u32 dfitmg3;		/* 0x1b8 unused */
> +	u32 dfistat;		/* 0x1bc */
> +	u32 dbictl;		/* 0x1c0 */
> +	u8 reserved_0x1c4[60];	/* 0x1c4 */
> +	u32 addrmap[12];	/* 0x200 */
> +	u8 reserved_0x230[16];	/* 0x230 */
> +	u32 odtcfg;		/* 0x240 */
> +	u32 odtmap;		/* 0x244 */
> +	u8 reserved_0x248[8];	/* 0x248 */
> +	u32 sched[2];		/* 0x250 */
> +	u8 reserved_0x258[12];	/* 0x258 */
> +	u32 unk_0x264;		/* 0x264 */
> +	u8 reserved_0x268[8];	/* 0x268 */
> +	u32 unk_0x270;		/* 0x270 */
> +	u8 reserved_0x274[152];	/* 0x274 */
> +	u32 dbgcmd;		/* 0x30c unused */
> +	u32 dbgstat;		/* 0x310 unused */
> +	u8 reserved_0x314[12];	/* 0x314 */
> +	u32 swctl;		/* 0x320 */
> +	u32 swstat;		/* 0x324 */
> +	u8 reserved_0x328[7768];/* 0x328 */
> +	u32 unk_0x2180;		/* 0x2180 */
> +	u8 reserved_0x2184[188];/* 0x2184 */
> +	u32 unk_0x2240;		/* 0x2240 */
> +	u8 reserved_0x2244[3900];/* 0x2244 */
> +	u32 unk_0x3180;		/* 0x3180 */
> +	u8 reserved_0x3184[188];/* 0x3184 */
> +	u32 unk_0x3240;		/* 0x3240 */
> +	u8 reserved_0x3244[3900];/* 0x3244 */
> +	u32 unk_0x4180;		/* 0x4180 */
> +	u8 reserved_0x4184[188];/* 0x4184 */
> +	u32 unk_0x4240;		/* 0x4240 */
> +};
> +check_member(sunxi_mctl_ctl_reg, swstat, 0x324);
> +check_member(sunxi_mctl_ctl_reg, unk_0x4240, 0x4240);
> +
> +#define MSTR_DEVICETYPE_DDR3	BIT(0)
> +#define MSTR_DEVICETYPE_LPDDR2	BIT(2)
> +#define MSTR_DEVICETYPE_LPDDR3	BIT(3)
> +#define MSTR_DEVICETYPE_DDR4	BIT(4)
> +#define MSTR_DEVICETYPE_LPDDR4	BIT(5)
> +#define MSTR_DEVICETYPE_MASK	GENMASK(5, 0)
> +#define MSTR_2TMODE		BIT(10)
> +#define MSTR_BUSWIDTH_FULL	(0 << 12)
> +#define MSTR_BUSWIDTH_HALF	(1 << 12)
> +#define MSTR_ACTIVE_RANKS(x)	(((x == 2) ? 3 : 1) << 24)
> +#define MSTR_BURST_LENGTH(x)	(((x) >> 1) << 16)
> +
> +#define TPR10_CA_BIT_DELAY	0xffff0000
> +#define TPR10_DX_BIT_DELAY0	BIT(17)
> +#define TPR10_DX_BIT_DELAY1	BIT(18)
> +#define TPR10_WRITE_LEVELING	BIT(20)
> +#define TPR10_READ_CALIBRATION	BIT(21)
> +#define TPR10_READ_TRAINING	BIT(22)
> +#define TPR10_WRITE_TRAINING	BIT(23)
> +
> +struct dram_para {
> +	enum sunxi_dram_type type;
> +	u32 dx_odt;
> +	u32 dx_dri;
> +	u32 ca_dri;
> +	u32 tpr0;
> +	u32 tpr1;
> +	u32 tpr2;
> +	u32 tpr6;
> +	u32 tpr10;
> +};
> +
> +struct dram_config {
> +	u8 cols;
> +	u8 rows;
> +	u8 ranks;
> +	u8 bus_full_width;
> +	u32 clk;
> +	u32 odt_en;
> +	u32 tpr11;
> +	u32 tpr12;
> +	u32 tpr14;
> +};
> +
> +static inline int ns_to_t(int nanoseconds, u32 clk)
> +{
> +	const unsigned int ctrl_freq = clk / 2;
> +
> +	return DIV_ROUND_UP(ctrl_freq * nanoseconds, 1000);
> +}
> +
> +void mctl_set_timing_params(u32 clk);
> +
> +#endif /* _SUNXI_DRAM_SUN55I_T527_H */
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index ab432390d3c..aeab2b3f6dd 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -51,7 +51,12 @@ config DRAM_SUN50I_H616
>  	  Select this dram controller driver for some sun50i platforms,
>  	  like H616.
>  
> -if DRAM_SUN50I_H616
> +config DRAM_SUN55I_A523
> +	bool
> +	help
> +	  Select this DRAM controller driver for A523/T527 SoCs.
> +
> +if DRAM_SUN50I_H616 || DRAM_SUN55I_A523
>  config DRAM_SUNXI_DX_ODT
>  	hex "DRAM DX ODT parameter"
>  	help
> @@ -79,6 +84,12 @@ config DRAM_SUNXI_TPR0
>  	help
>  	  TPR0 value from vendor DRAM settings.
>  
> +config DRAM_SUNXI_TPR1
> +	hex "DRAM TPR1 parameter"
> +	default 0x0
> +	help
> +	  TPR1 value from vendor DRAM settings.
> +
>  config DRAM_SUNXI_TPR2
>  	hex "DRAM TPR2 parameter"
>  	default 0x0
> @@ -109,6 +120,13 @@ config DRAM_SUNXI_TPR12
>  	help
>  	  TPR12 value from vendor DRAM settings.
>  
> +config DRAM_SUNXI_TPR14
> +	hex "DRAM TPR14 parameter"
> +	depends on MACH_SUN55I_A523
> +	default 0x48484848
> +	help
> +	  TPR14 value from vendor DRAM settings.
> +
>  choice
>  	prompt "DRAM PHY pin mapping selection"
>  	default DRAM_SUNXI_PHY_ADDR_MAP_0
> @@ -497,7 +515,7 @@ config ARM_BOOT_HOOK_RMR
>  	This allows both the SPL and the U-Boot proper to be entered in
>  	either mode and switch to AArch64 if needed.
>  
> -if SUNXI_DRAM_DW || DRAM_SUN50I_H6 || DRAM_SUN50I_H616
> +if SUNXI_DRAM_DW || DRAM_SUN50I_H6 || DRAM_SUN50I_H616 || DRAM_SUN55I_A523
>  config SUNXI_DRAM_DDR3
>  	bool
>  
> @@ -512,6 +530,7 @@ config SUNXI_DRAM_LPDDR4
>  
>  choice
>  	prompt "DRAM Type and Timing"
> +	default SUNXI_DRAM_A523_LPDDR4 if MACH_SUN55I_A523
>  	default SUNXI_DRAM_DDR3_1333 if !MACH_SUN8I_V3S
>  	default SUNXI_DRAM_DDR2_V3S if MACH_SUN8I_V3S
>  
> @@ -577,6 +596,13 @@ config SUNXI_DRAM_DDR2_V3S
>  	This option is only for the DDR2 memory chip which is co-packaged in
>  	Allwinner V3s SoC.
>  
> +config SUNXI_DRAM_A523_LPDDR4
> +	bool "LPDDR4 DRAM chips on the A523/T527 DRAM controller"
> +	select SUNXI_DRAM_LPDDR4
> +	depends on DRAM_SUN55I_A523
> +	help
> +	  This option is the LPDDR4 timing used by the stock boot0 by
> +	  Allwinner.
>  endchoice
>  endif
>  
> @@ -597,6 +623,7 @@ config DRAM_CLK
>  	default 672 if MACH_SUN50I
>  	default 744 if MACH_SUN50I_H6
>  	default 720 if MACH_SUN50I_H616
> +	default 1200 if MACH_SUN55I_A523
>  	---help---
>  	Set the dram clock speed, valid range 240 - 480 (prior to sun9i),
>  	must be a multiple of 24. For the sun9i (A80), the tested values
> diff --git a/arch/arm/mach-sunxi/Makefile b/arch/arm/mach-sunxi/Makefile
> index eb6a49119a1..3521335dbbf 100644
> --- a/arch/arm/mach-sunxi/Makefile
> +++ b/arch/arm/mach-sunxi/Makefile
> @@ -45,4 +45,6 @@ obj-$(CONFIG_DRAM_SUN50I_H6)	+= dram_sun50i_h6.o
>  obj-$(CONFIG_DRAM_SUN50I_H6)	+= dram_timings/
>  obj-$(CONFIG_DRAM_SUN50I_H616)	+= dram_sun50i_h616.o
>  obj-$(CONFIG_DRAM_SUN50I_H616)	+= dram_timings/
> +obj-$(CONFIG_MACH_SUN55I_A523)	+= dram_sun55i_a523.o
> +obj-$(CONFIG_DRAM_SUN55I_A523)	+= dram_timings/
>  endif
> diff --git a/arch/arm/mach-sunxi/dram_sun55i_a523.c b/arch/arm/mach-sunxi/dram_sun55i_a523.c
> new file mode 100644
> index 00000000000..fae02062547
> --- /dev/null
> +++ b/arch/arm/mach-sunxi/dram_sun55i_a523.c
> @@ -0,0 +1,1468 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * sun55i A523/A527/T527/H728 platform DRAM controller driver
> + *
> + * This driver supports DDR3 and LPDDR4 memory.
> + *
> + * (C) Copyright 2024 Jernej Skrabec <jernej.skrabec@gmail.com>
> + *
> + */
> +#include <init.h>
> +#include <log.h>
> +#include <asm/io.h>
> +#include <asm/arch/clock.h>
> +#include <asm/arch/dram.h>
> +#include <asm/arch/cpu.h>
> +#include <asm/arch/prcm.h>
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +
...snip
> +static void mctl_auto_detect_dram_size(const struct dram_para *para,
> +				       struct dram_config *config)
> +{
> +	/* detect row address bits */
> +	config->cols = 8;
> +	config->rows = 16;
> +	mctl_core_init(para, config);
> +
> +	for (config->rows = 13; config->rows < 16; config->rows++) {
> +		/* 8 banks, 8 bit per byte and 16/32 bit width */
> +		if (mctl_mem_matches((1 << (config->rows + config->cols +
> +					    4 + config->bus_full_width))))
> +			break;
> +	}
> +
> +	/* detect column address bits */
> +	config->cols = 11;
> +	mctl_core_init(para, config);
> +
...
> +	for (config->cols = 8; config->cols < 11; config->cols++) {
> +		/* 8 bits per byte and 16/32 bit width */
> +		if (mctl_mem_matches(1 << (config->cols + 1 +
> +					   config->bus_full_width)))
> +			break;
> +	}
on radxa a5e, I've got occasionally wrong dram size, roughly 2/10 rate
in the wrong case it got 8192M, while actually should be 4096M..

spent a few time to debug, found it got config->cols = 11 while should be 10
and above for loop has been skipped, thus fail to detect correct cols value..

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55
