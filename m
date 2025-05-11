Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B846EC3ABC3
	for <u-boot@archiver.kernel.org>; Sun, 11 May 2025 09:23:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94CC68091A;
	Sun, 11 May 2025 11:23:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6992E80ADF; Sun, 11 May 2025 11:23:33 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 297DB8070C
 for <u-boot@lists.denx.de>; Sun, 11 May 2025 11:23:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D28A1516;
 Sun, 11 May 2025 02:23:17 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 294B83F673;
 Sun, 11 May 2025 02:23:27 -0700 (PDT)
Date: Sun, 11 May 2025 10:23:16 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Cody Eksal <masterr3c0rd@epochal.quest>, Jernej Skrabec
 <jernej.skrabec@gmail.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>, Philippe
 Simons <simons.philippe@gmail.com>, Sumit Garg <sumit.garg@kernel.org>,
 linux-sunxi@lists.linux.dev, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 1/6] sunxi: A133: add DRAM init code
Message-ID: <20250511102316.4bb65ff2@minigeek.lan>
In-Reply-To: <20250511011003.15654-2-andre.przywara@arm.com>
References: <20250511011003.15654-1-andre.przywara@arm.com>
 <20250511011003.15654-2-andre.przywara@arm.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
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

On Sun, 11 May 2025 02:09:58 +0100
Andre Przywara <andre.przywara@arm.com> wrote:

> From: Cody Eksal <masterr3c0rd@epochal.quest>
> 
> This adds preliminary support for the DRAM controller in the Allwinner
> A100/A133 SoCs.
> This is work in progress, and has rough edges, but works on at least
> three different boards. It contains support for DDR4 and LPDDR4.
> 
> [Andre: formatting fixes, adapt to mainline, drop unused parameters,
> 	remove struct struct sunxi_mctl_com_reg, hardcode MR registers,
> 	switch to mctl_check_pattern(), remove simple DRAM check]

I pushed a (just updated) branch to my github which has those changes
split up in separate patches, in case you want to track what has changed
exactly:
https://github.com/apritzel/u-boot/commits/a133-dram-WIP/

Cheers,
Andre


> ---
>  .../include/asm/arch-sunxi/cpu_sun50i_h6.h    |    4 +
>  arch/arm/include/asm/arch-sunxi/dram.h        |    2 +
>  .../include/asm/arch-sunxi/dram_sun50i_a133.h |  230 ++++
>  arch/arm/mach-sunxi/Kconfig                   |  104 +-
>  arch/arm/mach-sunxi/Makefile                  |    2 +
>  arch/arm/mach-sunxi/dram_sun50i_a133.c        | 1204 +++++++++++++++++
>  arch/arm/mach-sunxi/dram_timings/Makefile     |    2 +
>  arch/arm/mach-sunxi/dram_timings/a133_ddr4.c  |   80 ++
>  .../arm/mach-sunxi/dram_timings/a133_lpddr4.c |  102 ++
>  9 files changed, 1722 insertions(+), 8 deletions(-)
>  create mode 100644 arch/arm/include/asm/arch-sunxi/dram_sun50i_a133.h
>  create mode 100644 arch/arm/mach-sunxi/dram_sun50i_a133.c
>  create mode 100644 arch/arm/mach-sunxi/dram_timings/a133_ddr4.c
>  create mode 100644 arch/arm/mach-sunxi/dram_timings/a133_lpddr4.c
> 
> diff --git a/arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h b/arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h
> index 8a3f465545a..2a9b086991c 100644
> --- a/arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h
> +++ b/arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h
> @@ -29,6 +29,10 @@
>  #define SUNXI_DRAM_COM_BASE		0x047FA000
>  #define SUNXI_DRAM_CTL0_BASE		0x047FB000
>  #define SUNXI_DRAM_PHY0_BASE		0x04800000
> +#elif CONFIG_MACH_SUN50I_A133
> +#define SUNXI_DRAM_COM_BASE		0x04810000
> +#define SUNXI_DRAM_CTL0_BASE		0x04820000
> +#define SUNXI_DRAM_PHY0_BASE		0x04830000
>  #endif
>  
>  #define SUNXI_TWI0_BASE			0x05002000
> diff --git a/arch/arm/include/asm/arch-sunxi/dram.h b/arch/arm/include/asm/arch-sunxi/dram.h
> index 9d21b492418..0708ae3ee3b 100644
> --- a/arch/arm/include/asm/arch-sunxi/dram.h
> +++ b/arch/arm/include/asm/arch-sunxi/dram.h
> @@ -31,6 +31,8 @@
>  #include <asm/arch/dram_sun50i_h6.h>
>  #elif defined(CONFIG_MACH_SUN50I_H616)
>  #include <asm/arch/dram_sun50i_h616.h>
> +#elif defined(CONFIG_DRAM_SUN50I_A133)
> +#include <asm/arch/dram_sun50i_a133.h>
>  #elif defined(CONFIG_MACH_SUNIV)
>  #include <asm/arch/dram_suniv.h>
>  #else
> diff --git a/arch/arm/include/asm/arch-sunxi/dram_sun50i_a133.h b/arch/arm/include/asm/arch-sunxi/dram_sun50i_a133.h
> new file mode 100644
> index 00000000000..a5fc6ad3656
> --- /dev/null
> +++ b/arch/arm/include/asm/arch-sunxi/dram_sun50i_a133.h
> @@ -0,0 +1,230 @@
> +// SPDX-License-Identifier:	GPL-2.0+
> +/*
> + * A133 dram controller register and constant defines
> + *
> + * (C) Copyright 2024  MasterR3C0RD <masterr3c0rd@epochal.quest>
> + */
> +
> +#ifndef _SUNXI_DRAM_SUN50I_A133_H
> +#define _SUNXI_DRAM_SUN50I_A133_H
> +
> +#include <linux/bitops.h>
> +
> +enum sunxi_dram_type {
> +	SUNXI_DRAM_TYPE_DDR3 = 3,
> +	SUNXI_DRAM_TYPE_DDR4,
> +	SUNXI_DRAM_TYPE_LPDDR3 = 7,
> +	SUNXI_DRAM_TYPE_LPDDR4
> +};
> +
> +static inline int ns_to_t(int nanoseconds)
> +{
> +	const unsigned int ctrl_freq = CONFIG_DRAM_CLK / 2;
> +
> +	return DIV_ROUND_UP(ctrl_freq * nanoseconds, 1000);
> +}
> +
> +/* MBUS part is largely the same as in H6, except for one special register */
> +#define MCTL_COM_UNK_008	0x008
> +/* NOTE: This register has the same importance as mctl_ctl->clken in H616 */
> +#define MCTL_COM_MAER0		0x020
> +
> +/*
> + * Controller registers seems to be the same or at least very similar
> + * to those in H6.
> + */
> +struct sunxi_mctl_ctl_reg {
> +	u32 mstr; 			/* 0x000 */
> +	u32 statr; 			/* 0x004 unused */
> +	u32 mstr1; 			/* 0x008 unused */
> +	u32 clken; 			/* 0x00c */
> +	u32 mrctrl0; 			/* 0x010 unused */
> +	u32 mrctrl1; 			/* 0x014 unused */
> +	u32 mrstatr; 			/* 0x018 unused */
> +	u32 mrctrl2; 			/* 0x01c unused */
> +	u32 derateen; 			/* 0x020 unused */
> +	u32 derateint; 			/* 0x024 unused */
> +	u8 reserved_0x028[8]; 		/* 0x028 */
> +	u32 pwrctl; 			/* 0x030 unused */
> +	u32 pwrtmg; 			/* 0x034 unused */
> +	u32 hwlpctl; 			/* 0x038 unused */
> +	u8 reserved_0x03c[20];		/* 0x03c */
> +	u32 rfshctl0;			/* 0x050 unused */
> +	u32 rfshctl1;			/* 0x054 unused */
> +	u8 reserved_0x058[8];		/* 0x05c */
> +	u32 rfshctl3;			/* 0x060 */
> +	u32 rfshtmg;			/* 0x064 */
> +	u8 reserved_0x068[104];		/* 0x068 */
> +	u32 init[8];			/* 0x0d0 */
> +	u32 dimmctl;			/* 0x0f0 unused */
> +	u32 rankctl;			/* 0x0f4 */
> +	u8 reserved_0x0f8[8];		/* 0x0f8 */
> +	u32 dramtmg[17];		/* 0x100 */
> +	u8 reserved_0x144[60];		/* 0x144 */
> +	u32 zqctl[3];			/* 0x180 */
> +	u32 zqstat;			/* 0x18c unused */
> +	u32 dfitmg0;			/* 0x190 */
> +	u32 dfitmg1;			/* 0x194 */
> +	u32 dfilpcfg[2];		/* 0x198 unused */
> +	u32 dfiupd[3];			/* 0x1a0 */
> +	u32 reserved_0x1ac;		/* 0x1ac */
> +	u32 dfimisc;			/* 0x1b0 */
> +	u32 dfitmg2;			/* 0x1b4 unused */
> +	u32 dfitmg3;			/* 0x1b8 unused */
> +	u32 dfistat;			/* 0x1bc */
> +	u32 dbictl;			/* 0x1c0 */
> +	u8 reserved_0x1c4[60];		/* 0x1c4 */
> +	u32 addrmap[12];		/* 0x200 */
> +	u8 reserved_0x230[16];		/* 0x230 */
> +	u32 odtcfg;			/* 0x240 */
> +	u32 odtmap;			/* 0x244 */
> +	u8 reserved_0x248[8];		/* 0x248 */
> +	u32 sched[2];			/* 0x250 */
> +	u8 reserved_0x258[180]; 	/* 0x258 */
> +	u32 dbgcmd;			/* 0x30c unused */
> +	u32 dbgstat;			/* 0x310 unused */
> +	u8 reserved_0x314[12];		/* 0x314 */
> +	u32 swctl;			/* 0x320 */
> +	u32 swstat;			/* 0x324 */
> +	u8 reserved_0x328[7768];	/* 0x328 */
> +	u32 unk_0x2180;			/* 0x2180 */
> +	u8 reserved_0x2184[188];	/* 0x2184 */
> +	u32 unk_0x2240;			/* 0x2240 */
> +	u8 reserved_0x2244[3900];	/* 0x2244 */
> +	u32 unk_0x3180;			/* 0x3180 */
> +	u8 reserved_0x3184[188];	/* 0x3184 */
> +	u32 unk_0x3240;			/* 0x3240 */
> +	u8 reserved_0x3244[3900];	/* 0x3244 */
> +	u32 unk_0x4180;			/* 0x4180 */
> +	u8 reserved_0x4184[188];	/* 0x4184 */
> +	u32 unk_0x4240;			/* 0x4240 */
> +};
> +
> +check_member(sunxi_mctl_ctl_reg, swstat, 0x324);
> +check_member(sunxi_mctl_ctl_reg, unk_0x4240, 0x4240);
> +
> +#define MSTR_DEVICETYPE_DDR3	BIT(0)
> +#define MSTR_DEVICETYPE_LPDDR2	BIT(2)
> +#define MSTR_DEVICETYPE_LPDDR3	BIT(3)
> +#define MSTR_DEVICETYPE_DDR4	BIT(4)
> +#define MSTR_DEVICETYPE_LPDDR4	BIT(5)
> +#define MSTR_DEVICETYPE_MASK	GENMASK(5, 0)
> +#define MSTR_GEARDOWNMODE	BIT(0)		/* Same as MSTR_DEVICETYPE_DDR3, only used for DDR4 */
> +#define MSTR_2TMODE		BIT(10)
> +#define MSTR_BUSWIDTH_FULL	(0 << 12)
> +#define MSTR_BUSWIDTH_HALF	(1 << 12)
> +#define MSTR_ACTIVE_RANKS(x)	(((x == 1) ? 3 : 1) << 24)
> +#define MSTR_BURST_LENGTH(x)	(((x) >> 1) << 16)
> +#define MSTR_DEVICECONFIG_X32	(3 << 30)
> +
> +#define TPR10_CA_BIT_DELAY	BIT(16)
> +#define TPR10_DX_BIT_DELAY0	BIT(17)
> +#define TPR10_DX_BIT_DELAY1	BIT(18)
> +#define TPR10_WRITE_LEVELING	BIT(20)
> +#define TPR10_READ_CALIBRATION	BIT(21)
> +#define TPR10_READ_TRAINING	BIT(22)
> +#define TPR10_WRITE_TRAINING	BIT(23)
> +
> +/* MRCTRL constants */
> +#define MRCTRL0_MR_RANKS_ALL	(3 << 4)
> +#define MRCTRL0_MR_ADDR(x)	(x << 12)
> +#define MRCTRL0_MR_WR		BIT(31)
> +
> +#define MRCTRL1_MR_ADDR(x)	(x << 8)
> +#define MRCTRL1_MR_DATA(x)	(x)
> +
> +/* ADDRMAP constants */
> +#define ADDRMAP_DISABLED_3F_B(b)	(0x3f + b)
> +#define ADDRMAP_DISABLED_1F_B(b)	(0x1f + b)
> +#define ADDRMAP_DISABLED_0F_B(b)	(0x0f + b)
> +
> +#define _ADDRMAP_VALUE(a,x,b)		(((a) - b) << (x * 8))
> +
> +/*
> + * Bx = internal base
> + * The selected HIF address bit for each address bit is determined
> + * by adding the internal base to the value of each field
> + * */
> +
> +#define ADDRMAP0_CS0_B6(v)	_ADDRMAP_VALUE(v, 0, 6)
> +
> +#define ADDRMAP1_BANK0_B2(v) 	_ADDRMAP_VALUE(v, 0, 2)
> +#define ADDRMAP1_BANK1_B3(v)	_ADDRMAP_VALUE(v, 1, 3)
> +#define ADDRMAP1_BANK2_B4(v)	_ADDRMAP_VALUE(v, 2, 4)
> +
> +#define ADDRMAP2_COL2_B2(v)	_ADDRMAP_VALUE(v, 0, 2)
> +#define ADDRMAP2_COL3_B3(v)	_ADDRMAP_VALUE(v, 1, 3)
> +#define ADDRMAP2_COL4_B4(v)	_ADDRMAP_VALUE(v, 2, 4)
> +#define ADDRMAP2_COL5_B5(v)	_ADDRMAP_VALUE(v, 3, 5)
> +
> +#define ADDRMAP3_COL6_B6(v)	_ADDRMAP_VALUE(v, 0, 6)
> +#define ADDRMAP3_COL7_B7(v)	_ADDRMAP_VALUE(v, 1, 7)
> +#define ADDRMAP3_COL8_B8(v)	_ADDRMAP_VALUE(v, 2, 8)
> +#define ADDRMAP3_COL9_B9(v)	_ADDRMAP_VALUE(v, 3, 9)
> +
> +#define ADDRMAP4_COL10_B10(v)	_ADDRMAP_VALUE(v, 0, 10)
> +#define ADDRMAP4_COL11_B11(v)	_ADDRMAP_VALUE(v, 1, 11)
> +
> +#define ADDRMAP5_ROW0_B6(v)	_ADDRMAP_VALUE(v, 0, 6)
> +#define ADDRMAP5_ROW1_B7(v)	_ADDRMAP_VALUE(v, 1, 7)
> +#define ADDRMAP5_ROW2_10_B8(v)	_ADDRMAP_VALUE(v, 2, 8)
> +#define ADDRMAP5_ROW11_B17(v)	_ADDRMAP_VALUE(v, 3, 17)
> +
> +#define ADDRMAP6_ROW12_B18(v)	_ADDRMAP_VALUE(v, 0, 18)
> +#define ADDRMAP6_ROW13_B19(v)	_ADDRMAP_VALUE(v, 1, 19)
> +#define ADDRMAP6_ROW14_B20(v)	_ADDRMAP_VALUE(v, 2, 20)
> +#define ADDRMAP6_ROW15_B21(v)	_ADDRMAP_VALUE(v, 3, 21)
> +
> +#define ADDRMAP7_ROW16_B22(v)	_ADDRMAP_VALUE(v, 0, 22)
> +#define ADDRMAP7_ROW17_B23(v)	_ADDRMAP_VALUE(v, 1, 23)
> +
> +#define ADDRMAP8_BG0_B2(v)	_ADDRMAP_VALUE(v, 0, 2)
> +#define ADDRMAP8_BG1_B3(v)	_ADDRMAP_VALUE(v, 1, 3)
> +
> +/* These are only used if ADDRMAP5_ROW_BITS_2_10 = ADDRMAP_DISABLED_0F */
> +#define ADDRMAP9_ROW2_B8(v)	_ADDRMAP_VALUE(v, 0, 8)
> +#define ADDRMAP9_ROW3_B9(v)	_ADDRMAP_VALUE(v, 1, 9)
> +#define ADDRMAP9_ROW4_B10(v)	_ADDRMAP_VALUE(v, 2, 10)
> +#define ADDRMAP9_ROW5_B11(v)	_ADDRMAP_VALUE(v, 3, 11)
> +
> +#define ADDRMAP10_ROW6_B12(v)	_ADDRMAP_VALUE(v, 0, 12)
> +#define ADDRMAP10_ROW7_B13(v)	_ADDRMAP_VALUE(v, 1, 13)
> +#define ADDRMAP10_ROW8_B14(v)	_ADDRMAP_VALUE(v, 2, 14)
> +#define ADDRMAP10_ROW9_B15(v)	_ADDRMAP_VALUE(v, 3, 15)
> +
> +#define ADDRMAP11_ROW10_B16(v)	_ADDRMAP_VALUE(v, 0, 16)
> +
> +struct dram_para {
> +	uint32_t clk;
> +	enum sunxi_dram_type type;
> +	uint32_t dx_odt;
> +	uint32_t dx_dri;
> +	uint32_t ca_dri;
> +	uint32_t para0;
> +	uint32_t mr11;
> +	uint32_t mr12;
> +	uint32_t mr13;
> +	uint32_t mr14;
> +	uint32_t tpr1;
> +	uint32_t tpr2;
> +	uint32_t tpr3;
> +	uint32_t tpr6;
> +	uint32_t tpr10;
> +	uint32_t tpr11;
> +	uint32_t tpr12;
> +	uint32_t tpr13;
> +	uint32_t tpr14;
> +};
> +
> +void mctl_set_timing_params(const struct dram_para *para);
> +
> +struct dram_config {
> +	u8 cols;		/* Column bits */
> +	u8 rows;		/* Row bits */
> +	u8 ranks;		/* Rank bits (different from H616!) */
> +	u8 banks;		/* Bank bits */
> +	u8 bankgrps;		/* Bank group bits */
> +	u8 bus_full_width;	/* 1 = x32, 0 = x16 */
> +};
> +
> +#endif /* _SUNXI_DRAM_SUN50I_A133_H */
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index c3718126cec..98b947f6e33 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -51,7 +51,13 @@ config DRAM_SUN50I_H616
>  	  Select this dram controller driver for some sun50i platforms,
>  	  like H616.
>  
> -if DRAM_SUN50I_H616
> +config DRAM_SUN50I_A133
> +	bool
> +	help
> +	  Select this dram controller driver for some sun50i platforms,
> +	  like A133.
> +
> +if DRAM_SUN50I_H616 || DRAM_SUN50I_A133
>  config DRAM_SUNXI_DX_ODT
>  	hex "DRAM DX ODT parameter"
>  	help
> @@ -73,18 +79,64 @@ config DRAM_SUNXI_ODT_EN
>  	help
>  	  ODT EN value from vendor DRAM settings.
>  
> +config DRAM_SUNXI_PARA0
> +	hex "DRAM PARA0 parameter"
> +	depends on DRAM_SUN50I_A133
> +	help
> +	  PARA0 value from vendor DRAM settings.
> +
> +config DRAM_SUNXI_MR11
> +	hex "DRAM MR11 parameter"
> +	depends on DRAM_SUN50I_A133
> +	default 0x0
> +	help
> +	  MR11 value from vendor DRAM settings.
> +
> +config DRAM_SUNXI_MR12
> +	hex "DRAM MR12 parameter"
> +	depends on DRAM_SUN50I_A133
> +	default 0x0
> +	help
> +	  MR12 value from vendor DRAM settings.
> +
> +config DRAM_SUNXI_MR13
> +	hex "DRAM MR13 parameter"
> +	depends on DRAM_SUN50I_A133
> +	default 0x0
> +	help
> +	  MR13 value from vendor DRAM settings.
> +
> +config DRAM_SUNXI_MR14
> +	hex "DRAM MR14 parameter"
> +	depends on DRAM_SUN50I_A133
> +	default 0x0
> +	help
> +	  MR14 value from vendor DRAM settings.
> +
>  config DRAM_SUNXI_TPR0
>  	hex "DRAM TPR0 parameter"
>  	default 0x0
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
>  	help
>  	  TPR2 value from vendor DRAM settings.
>  
> +config DRAM_SUNXI_TPR3
> +	hex "DRAM TPR3 parameter"
> +	default 0x0
> +	help
> +	  TPR3 value from vendor DRAM settings.
> +
>  config DRAM_SUNXI_TPR6
>  	hex "DRAM TPR6 parameter"
>  	default 0x3300c080
> @@ -109,6 +161,20 @@ config DRAM_SUNXI_TPR12
>  	help
>  	  TPR12 value from vendor DRAM settings.
>  
> +config DRAM_SUNXI_TPR13
> +	hex "DRAM TPR13 parameter"
> +	depends on DRAM_SUN50I_A133
> +	default 0x0
> +	help
> +	  TPR13 value from vendor DRAM settings.
> +
> +config DRAM_SUNXI_TPR14
> +	hex "DRAM TPR14 parameter"
> +	depends on DRAM_SUN50I_A133
> +	default 0x0
> +	help
> +	  TPR14 value from vendor DRAM settings.
> +
>  choice
>  	prompt "DRAM PHY pin mapping selection"
>  	default DRAM_SUNXI_PHY_ADDR_MAP_0
> @@ -116,7 +182,8 @@ choice
>  config DRAM_SUNXI_PHY_ADDR_MAP_0
>  	bool "DRAM PHY address map 0"
>  	help
> -	  This pin mapping selection should be used by the H313, H616, H618.
> +	  This pin mapping selection should be used by the H313, H616, H618,
> +	  and A133, R818 SoCs.
>  
>  config DRAM_SUNXI_PHY_ADDR_MAP_1
>  	bool "DRAM PHY address map 1"
> @@ -500,7 +567,7 @@ config ARM_BOOT_HOOK_RMR
>  	This allows both the SPL and the U-Boot proper to be entered in
>  	either mode and switch to AArch64 if needed.
>  
> -if SUNXI_DRAM_DW || DRAM_SUN50I_H6 || DRAM_SUN50I_H616
> +if SUNXI_DRAM_DW || DRAM_SUN50I_H6 || DRAM_SUN50I_H616 || DRAM_SUN50I_A133
>  config SUNXI_DRAM_DDR3
>  	bool
>  
> @@ -513,6 +580,9 @@ config SUNXI_DRAM_LPDDR3
>  config SUNXI_DRAM_LPDDR4
>  	bool
>  
> +config SUNXI_DRAM_DDR4
> +	bool
> +
>  choice
>  	prompt "DRAM Type and Timing"
>  	default SUNXI_DRAM_DDR3_1333 if !MACH_SUN8I_V3S
> @@ -521,6 +591,7 @@ choice
>  config SUNXI_DRAM_DDR3_1333
>  	bool "DDR3 1333"
>  	select SUNXI_DRAM_DDR3
> +	depends on !DRAM_SUN50I_A133
>  	---help---
>  	This option is the original only supported memory type, which suits
>  	many H3/H5/A64 boards available now.
> @@ -528,6 +599,7 @@ config SUNXI_DRAM_DDR3_1333
>  config SUNXI_DRAM_LPDDR3_STOCK
>  	bool "LPDDR3 with Allwinner stock configuration"
>  	select SUNXI_DRAM_LPDDR3
> +	depends on !DRAM_SUN50I_A133
>  	---help---
>  	This option is the LPDDR3 timing used by the stock boot0 by
>  	Allwinner.
> @@ -551,7 +623,7 @@ config SUNXI_DRAM_H6_DDR3_1333
>  config SUNXI_DRAM_H616_LPDDR3
>  	bool "LPDDR3 DRAM chips on the H616 DRAM controller"
>  	select SUNXI_DRAM_LPDDR3
> -	depends on DRAM_SUN50I_H616
> +	depends on DRAM_SUN50I_H616 || DRAM_SUN50I_A133
>  	help
>  	  This option is the LPDDR3 timing used by the stock boot0 by
>  	  Allwinner.
> @@ -559,7 +631,7 @@ config SUNXI_DRAM_H616_LPDDR3
>  config SUNXI_DRAM_H616_LPDDR4
>  	bool "LPDDR4 DRAM chips on the H616 DRAM controller"
>  	select SUNXI_DRAM_LPDDR4
> -	depends on DRAM_SUN50I_H616
> +	depends on DRAM_SUN50I_H616 || DRAM_SUN50I_A133
>  	help
>  	  This option is the LPDDR4 timing used by the stock boot0 by
>  	  Allwinner.
> @@ -567,11 +639,27 @@ config SUNXI_DRAM_H616_LPDDR4
>  config SUNXI_DRAM_H616_DDR3_1333
>  	bool "DDR3-1333 boot0 timings on the H616 DRAM controller"
>  	select SUNXI_DRAM_DDR3
> -	depends on DRAM_SUN50I_H616
> +	depends on DRAM_SUN50I_H616 || DRAM_SUN50I_A133
>  	help
>  	  This option is the DDR3 timing used by the boot0 on H616 TV boxes
>  	  which use a DDR3-1333 timing.
>  
> +config SUNXI_DRAM_A133_DDR4
> +	bool "DDR4 boot0 timings on the A133 DRAM controller"
> +	select SUNXI_DRAM_DDR4
> +	depends on DRAM_SUN50I_A133
> +	help
> +	  This option is the DDR4 timing used by the boot0 on A133 devices
> +	  which use a DDR4 timing.
> +
> +config SUNXI_DRAM_A133_LPDDR4
> +	bool "LPDDR4 boot0 timings on the A133 DRAM controller"
> +	select SUNXI_DRAM_LPDDR4
> +	depends on DRAM_SUN50I_A133
> +	help
> +	  This option is the LPDDR4 timing used by the boot0 on A133 devices
> +	  which use an LPDDR4 timing.
> +
>  config SUNXI_DRAM_DDR2_V3S
>  	bool "DDR2 found in V3s chip"
>  	select SUNXI_DRAM_DDR2
> @@ -599,7 +687,7 @@ config DRAM_CLK
>  		       MACH_SUN8I_V3S
>  	default 672 if MACH_SUN50I
>  	default 744 if MACH_SUN50I_H6
> -	default 720 if MACH_SUN50I_H616
> +	default 720 if MACH_SUN50I_H616 || MACH_SUN50I_A133
>  	---help---
>  	Set the dram clock speed, valid range 240 - 480 (prior to sun9i),
>  	must be a multiple of 24. For the sun9i (A80), the tested values
> @@ -616,7 +704,7 @@ endif
>  
>  config DRAM_ZQ
>  	int "sunxi dram zq value"
> -	depends on !MACH_SUN50I_H616
> +	depends on !MACH_SUN50I_H616 && !MACH_SUN50I_A133
>  	default 123 if MACH_SUN4I || MACH_SUN5I || MACH_SUN6I || \
>  		       MACH_SUN8I_A23 || MACH_SUN8I_A33 || MACH_SUN8I_A83T
>  	default 127 if MACH_SUN7I
> diff --git a/arch/arm/mach-sunxi/Makefile b/arch/arm/mach-sunxi/Makefile
> index a33cd5b0f07..8eff20b77bf 100644
> --- a/arch/arm/mach-sunxi/Makefile
> +++ b/arch/arm/mach-sunxi/Makefile
> @@ -45,4 +45,6 @@ obj-$(CONFIG_DRAM_SUN50I_H6)	+= dram_sun50i_h6.o dram_dw_helpers.o
>  obj-$(CONFIG_DRAM_SUN50I_H6)	+= dram_timings/
>  obj-$(CONFIG_DRAM_SUN50I_H616)	+= dram_sun50i_h616.o dram_dw_helpers.o
>  obj-$(CONFIG_DRAM_SUN50I_H616)	+= dram_timings/
> +obj-$(CONFIG_DRAM_SUN50I_A133)	+= dram_sun50i_a133.o
> +obj-$(CONFIG_DRAM_SUN50I_A133)	+= dram_timings/
>  endif
> diff --git a/arch/arm/mach-sunxi/dram_sun50i_a133.c b/arch/arm/mach-sunxi/dram_sun50i_a133.c
> new file mode 100644
> index 00000000000..a0fca3738f4
> --- /dev/null
> +++ b/arch/arm/mach-sunxi/dram_sun50i_a133.c
> @@ -0,0 +1,1204 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * sun50i A133 platform dram controller driver
> + *
> + * Controller and PHY appear to be quite similar to that of the H616;
> + * however certain offsets, timings, and other details are different enough that
> + * the original code does not work as expected. Some device flags and
> + * calibrations are not yet implemented, and configuration aside from DDR4
> + * have not been tested.
> + *
> + * (C) Copyright 2024 MasterR3C0RD <masterr3c0rd@epochal.quest>
> + *
> + * Uses code from H616 driver, which is
> + * (C) Copyright 2020 Jernej Skrabec <jernej.skrabec@siol.net>
> + *
> + */
> +
> +//#define DEBUG
> +
> +#include <asm/arch/clock.h>
> +#include <asm/arch/cpu.h>
> +#include <asm/arch/dram.h>
> +#include <asm/arch/prcm.h>
> +#include <asm/io.h>
> +#include <init.h>
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <log.h>
> +
> +#ifdef CONFIG_DRAM_SUNXI_PHY_ADDR_MAP_1
> +static const u8 phy_init[] = {
> +#ifdef CONFIG_SUNXI_DRAM_DDR3
> +	0x0c, 0x08, 0x19, 0x18, 0x10, 0x06, 0x0a, 0x03, 0x0e,
> +	0x00, 0x0b, 0x05, 0x09, 0x1a, 0x04, 0x13, 0x16, 0x11,
> +	0x01, 0x15, 0x0d, 0x07, 0x12, 0x17, 0x14, 0x02, 0x0f
> +#elif CONFIG_SUNXI_DRAM_DDR4
> +	0x19, 0x1a, 0x04, 0x12, 0x09, 0x06, 0x08, 0x0a, 0x16,
> +	0x17, 0x18, 0x0f, 0x0c, 0x13, 0x02, 0x05, 0x01, 0x11,
> +	0x0e, 0x00, 0x0b, 0x07, 0x03, 0x14, 0x15, 0x0d, 0x10
> +#elif CONFIG_SUNXI_DRAM_LPDDR3
> +	0x08, 0x03, 0x02, 0x00, 0x18, 0x19, 0x09, 0x01, 0x06,
> +	0x17, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10, 0x11,
> +	0x12, 0x13, 0x14, 0x15, 0x16, 0x04, 0x05, 0x07, 0x1a
> +#elif CONFIG_SUNXI_DRAM_LPDDR4
> +	0x01, 0x05, 0x02, 0x00, 0x19, 0x03, 0x06, 0x07, 0x08,
> +	0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10, 0x11,
> +	0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x04, 0x1a
> +#endif
> +};
> +#else
> +static const u8 phy_init[] = {
> +#ifdef CONFIG_SUNXI_DRAM_DDR3
> +	0x03, 0x19, 0x18, 0x02, 0x10, 0x15, 0x16, 0x07, 0x06,
> +	0x0e, 0x05, 0x08, 0x0d, 0x04, 0x17, 0x1a, 0x13, 0x11,
> +	0x12, 0x14, 0x00, 0x01, 0x0c, 0x0a, 0x09, 0x0b, 0x0f
> +#elif CONFIG_SUNXI_DRAM_DDR4
> +	0x13, 0x17, 0x0e, 0x01, 0x06, 0x12, 0x14, 0x07, 0x09,
> +	0x02, 0x0f, 0x00, 0x0d, 0x05, 0x16, 0x0c, 0x0a, 0x11,
> +	0x04, 0x03, 0x18, 0x15, 0x08, 0x10, 0x0b, 0x19, 0x1a
> +#elif CONFIG_SUNXI_DRAM_LPDDR3
> +	0x05, 0x06, 0x17, 0x02, 0x19, 0x18, 0x04, 0x07, 0x03,
> +	0x01, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10, 0x11,
> +	0x12, 0x13, 0x14, 0x15, 0x16, 0x08, 0x09, 0x00, 0x1a
> +#elif CONFIG_SUNXI_DRAM_LPDDR4
> +	0x01, 0x03, 0x02, 0x19, 0x17, 0x00, 0x06, 0x07, 0x08,
> +	0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10, 0x11,
> +	0x12, 0x13, 0x14, 0x15, 0x16, 0x04, 0x18, 0x05, 0x1a
> +#endif
> +};
> +#endif
> +
> +static void mctl_clk_init(u32 clk)
> +{
> +	void * const ccm = (void *)SUNXI_CCM_BASE;
> +
> +	/* Place all DRAM blocks into reset */
> +	clrbits_le32(ccm + CCU_H6_MBUS_CFG, MBUS_ENABLE);
> +	clrbits_le32(ccm + CCU_H6_MBUS_CFG, MBUS_RESET);
> +	clrbits_le32(ccm + CCU_H6_DRAM_GATE_RESET, BIT(GATE_SHIFT));
> +	clrbits_le32(ccm + CCU_H6_DRAM_GATE_RESET, BIT(RESET_SHIFT));
> +	clrbits_le32(ccm + CCU_H6_PLL5_CFG, CCM_PLL5_CTRL_EN);
> +	clrbits_le32(ccm + CCU_H6_DRAM_CLK_CFG, DRAM_MOD_RESET);
> +	udelay(5);
> +
> +	/* Set up PLL5 clock, used for DRAM */
> +	clrsetbits_le32(ccm + CCU_H6_PLL5_CFG, 0xff03,
> +			CCM_PLL5_CTRL_N((clk * 2) / 24) | CCM_PLL5_CTRL_EN);
> +	setbits_le32(ccm + CCU_H6_PLL5_CFG, BIT(24));
> +	clrsetbits_le32(ccm + CCU_H6_PLL5_CFG, 0x3,
> +			CCM_PLL5_LOCK_EN | CCM_PLL5_CTRL_EN | BIT(30));
> +	clrbits_le32(ccm + CCU_H6_PLL5_CFG, 0x3 | BIT(30));
> +	mctl_await_completion(ccm + CCU_H6_PLL5_CFG,
> +			      CCM_PLL5_LOCK, CCM_PLL5_LOCK);
> +
> +	/* Enable DRAM clock and gate*/
> +	clrbits_le32(ccm + CCU_H6_DRAM_CLK_CFG, BIT(24) | BIT(25));
> +	clrsetbits_le32(ccm + CCU_H6_DRAM_CLK_CFG, 0x1f, BIT(1) | BIT(0));
> +	setbits_le32(ccm + CCU_H6_DRAM_CLK_CFG, DRAM_CLK_UPDATE);
> +	setbits_le32(ccm + CCU_H6_DRAM_GATE_RESET, BIT(RESET_SHIFT));
> +	setbits_le32(ccm + CCU_H6_DRAM_GATE_RESET, BIT(GATE_SHIFT));
> +
> +	/* Re-enable MBUS and reset the DRAM module */
> +	setbits_le32(ccm + CCU_H6_MBUS_CFG, MBUS_RESET);
> +	setbits_le32(ccm + CCU_H6_MBUS_CFG, MBUS_ENABLE);
> +	setbits_le32(ccm + CCU_H6_DRAM_CLK_CFG, DRAM_MOD_RESET);
> +	udelay(5);
> +}
> +
> +static void mctl_set_odtmap(const struct dram_para *para,
> +			    const struct dram_config *config)
> +{
> +	struct sunxi_mctl_ctl_reg *mctl_ctl =
> +		(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
> +
> +	u32 val, temp1, temp2;
> +
> +	/* Set ODT/rank mappings*/
> +	if (config->bus_full_width)
> +		writel_relaxed(0x0201, &mctl_ctl->odtmap);
> +	else
> +		writel_relaxed(0x0303, &mctl_ctl->odtmap);
> +
> +	switch (para->type) {
> +	case SUNXI_DRAM_TYPE_DDR3:
> +		val = 0x06000400;
> +		break;
> +	case SUNXI_DRAM_TYPE_LPDDR3:
> +		/* TODO: What's the purpose of these values? */
> +		temp1 = para->clk * 7 / 2000;
> +		if (para->clk < 400)
> +			temp2 = 0x3;
> +		else
> +			temp2 = 0x4;
> +
> +		val = 0x400 | (temp2 - temp1) << 16 | temp1 << 24;
> +		break;
> +	case SUNXI_DRAM_TYPE_DDR4:
> +		/* MR4: CS to CMD / ADDR Latency   and  write preamble */
> +		val = 0x400 | (0x000 << 10 & 0x70000) |
> +		      (((0x0000 >> 12) & 1) + 6) << 24;
> +		break;
> +	case SUNXI_DRAM_TYPE_LPDDR4:
> +		val = 0x4000400;
> +		break;
> +	}
> +
> +	writel_relaxed(val, &mctl_ctl->odtcfg);
> +	/* Documented as ODTCFG_SHADOW */
> +	writel_relaxed(val, &mctl_ctl->unk_0x2240);
> +	/* Offset's interesting; additional undocumented shadows? */
> +	writel_relaxed(val, &mctl_ctl->unk_0x3240);
> +	writel_relaxed(val, &mctl_ctl->unk_0x4240);
> +}
> +
> +/*
> + * This function produces address mapping parameters, used internally by the
> + * controller to map address lines to HIF addresses. HIF addresses are word
> + * addresses, not byte addresses;
> + * In other words, DDR address 0x400 maps to HIF address 0x100.
> + *
> + * This implementation sets up a reasonable mapping where HIF address
> + * ordering (LSB->MSB) is as such:
> + * - Bank Groups
> + * - Columns
> + * - Banks
> + * - Rows
> + * - Ranks
> + *
> + * TODO: Handle 1.5GB + 3GB configurations. Info about these is stored in
> + * upper bits of TPR13 after autoscan in boot0, and then some extra logic
> + * happens in the address mapping
> + */
> +#define INITIAL_HIF_OFFSET 3
> +
> +static void mctl_set_addrmap(const struct dram_config *config)
> +{
> +	struct sunxi_mctl_ctl_reg *mctl_ctl =
> +		(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
> +
> +	u8 bankgrp_bits = config->bankgrps;
> +	u8 col_bits = config->cols;
> +	u8 bank_bits = config->banks;
> +	u8 row_bits = config->rows;
> +	u8 rank_bits = config->ranks;
> +
> +	unsigned int i, hif_offset, hif_bits[6];
> +
> +	/*
> +	 * When the bus is half width, we need to adjust address mapping,
> +	 * as COL[0] will be reallocated as part of the byte address,
> +	 * offsetting the column address mapping values by 1
> +	 */
> +	if (!config->bus_full_width)
> +		col_bits--;
> +
> +	/* Match boot0's DRAM requirements */
> +	if (bankgrp_bits > 2)
> +		panic("invalid dram configuration (bankgrps_bits = %d)",
> +		      bankgrp_bits);
> +	if (col_bits < 8 || col_bits > 12)
> +		panic("invalid dram configuration (col_bits = %d)", col_bits);
> +
> +	if (bank_bits < 2 || bank_bits > 3)
> +		panic("invalid dram configuration (bank_bits = %d)", bank_bits);
> +
> +	if (row_bits < 14 || row_bits > 18)
> +		panic("invalid dram configuration (row_bits = %d)", row_bits);
> +
> +	if (rank_bits > 1)
> +		panic("invalid dram configuration (rank_bits = %d)", rank_bits);
> +
> +	/*
> +	 * Col[0:1] + HIF[0:1] (hardwired), Col[2] = HIF[2] (required)
> +	 * Thus, we start allocating from HIF[3] onwards
> +	 */
> +	hif_offset = INITIAL_HIF_OFFSET;
> +
> +	/* BG[bankgrp_bits:0] = HIF[3 + bankgrp_bits:3]*/
> +	switch (bankgrp_bits) {
> +	case 0:
> +		writel_relaxed(ADDRMAP8_BG0_B2(ADDRMAP_DISABLED_1F_B(2)) |
> +			       ADDRMAP8_BG1_B3(ADDRMAP_DISABLED_1F_B(3)),
> +			&mctl_ctl->addrmap[8]);
> +		break;
> +	case 1:
> +		writel_relaxed(ADDRMAP8_BG0_B2(hif_offset) |
> +			       ADDRMAP8_BG1_B3(ADDRMAP_DISABLED_1F_B(3)),
> +			&mctl_ctl->addrmap[8]);
> +		break;
> +	case 2:
> +		writel_relaxed(ADDRMAP8_BG0_B2(hif_offset) |
> +			       ADDRMAP8_BG1_B3(hif_offset + 1),
> +			       &mctl_ctl->addrmap[8]);
> +		break;
> +	default:
> +		panic("invalid dram configuration (bankgrp_bits = %d)",
> +		      bankgrp_bits);
> +	}
> +
> +	hif_offset += bankgrp_bits;
> +
> +	/* Col[2] = HIF[2], Col[5:3] = HIF[offset + 2:offset] */
> +	writel_relaxed(ADDRMAP2_COL2_B2(2) | ADDRMAP2_COL3_B3(hif_offset) |
> +		       ADDRMAP2_COL4_B4(hif_offset + 1) |
> +		       ADDRMAP2_COL5_B5(hif_offset + 2),
> +		       &mctl_ctl->addrmap[2]);
> +
> +	/* Col[col_bits:6] = HIF[col_bits + offset - 3:offset - 3] */
> +	for (i = 6; i < 12; i++) {
> +		if (i < col_bits)
> +			hif_bits[i - 6] = hif_offset + (i - INITIAL_HIF_OFFSET);
> +		else
> +			hif_bits[i - 6] = ADDRMAP_DISABLED_1F_B(i);
> +	}
> +
> +	writel_relaxed(ADDRMAP3_COL6_B6(hif_bits[0]) |
> +		       ADDRMAP3_COL7_B7(hif_bits[1]) |
> +		       ADDRMAP3_COL8_B8(hif_bits[2]) |
> +		       ADDRMAP3_COL9_B9(hif_bits[3]),
> +		       &mctl_ctl->addrmap[3]);
> +
> +	writel_relaxed(ADDRMAP4_COL10_B10(hif_bits[4]) |
> +		       ADDRMAP4_COL11_B11(hif_bits[5]),
> +		       &mctl_ctl->addrmap[4]);
> +
> +	hif_offset = bankgrp_bits + col_bits;
> +
> +	/* Bank[bank_bits:0] = HIF[bank_bits + offset:offset] */
> +	if (bank_bits == 3)
> +		writel_relaxed(ADDRMAP1_BANK0_B2(hif_offset) |
> +			       ADDRMAP1_BANK1_B3(hif_offset + 1) |
> +			       ADDRMAP1_BANK2_B4(hif_offset + 2),
> +			       &mctl_ctl->addrmap[1]);
> +	else
> +		writel_relaxed(ADDRMAP1_BANK0_B2(hif_offset) |
> +			       ADDRMAP1_BANK1_B3(hif_offset + 1) |
> +			       ADDRMAP1_BANK2_B4(ADDRMAP_DISABLED_1F_B(4)),
> +			       &mctl_ctl->addrmap[1]);
> +
> +	hif_offset += bank_bits;
> +
> +	/* Row[11:0] = HIF[11 + offset:offset] */
> +	writel_relaxed(ADDRMAP5_ROW0_B6(hif_offset) |
> +		       ADDRMAP5_ROW1_B7(hif_offset + 1) |
> +		       ADDRMAP5_ROW2_10_B8(hif_offset + 2) |
> +		       ADDRMAP5_ROW11_B17(hif_offset + 11),
> +		       &mctl_ctl->addrmap[5]);
> +
> +	/*
> +	 * There's some complexity here because of a special case
> +	 * in boot0 code that appears to work around a hardware bug.
> +	 * For (col_bits, row_bits, rank_bits) = (10, 16, 1), we have to
> +	 * place CS[0] in the position we would normally place ROW[14],
> +	 * and shift ROW[14] and ROW[15] over by one. Using the bit following
> +	 * ROW[15], as would be standard here, seems to cause nonsensical
> +	 * aliasing patterns.
> +	 *
> +	 * Aside from this case, mapping is simple:
> +	 * Row[row_bits:12] = HIF[offset + row_bits:offset + 12]
> +	 */
> +	for (i = 12; i < 18; i++) {
> +		if (i >= row_bits)
> +			hif_bits[i - 12] = ADDRMAP_DISABLED_0F_B(6 + i);
> +		else if (rank_bits != 1 || col_bits != 10 || row_bits != 16 ||
> +			 i < 14)
> +			hif_bits[i - 12] = hif_offset + i;
> +		else
> +			hif_bits[i - 12] = hif_offset + i + 1;
> +	}
> +
> +	writel_relaxed(ADDRMAP6_ROW12_B18(hif_bits[0]) |
> +		       ADDRMAP6_ROW13_B19(hif_bits[1]) |
> +		       ADDRMAP6_ROW14_B20(hif_bits[2]) |
> +		       ADDRMAP6_ROW15_B21(hif_bits[3]),
> +		       &mctl_ctl->addrmap[6]);
> +
> +	writel_relaxed(ADDRMAP7_ROW16_B22(hif_bits[4]) |
> +		       ADDRMAP7_ROW17_B23(hif_bits[5]),
> +		       &mctl_ctl->addrmap[7]);
> +
> +	hif_offset += row_bits;
> +
> +	/*
> +	 * Ranks
> +	 * Most cases: CS[0] = HIF[offset]
> +	 * Special case (see above): CS[0] = HIF[offset - 2]
> +	 */
> +	if (rank_bits == 0)
> +		writel_relaxed(ADDRMAP0_CS0_B6(ADDRMAP_DISABLED_1F_B(6)),
> +			       &mctl_ctl->addrmap[0]);
> +	else if (col_bits == 10 && row_bits == 16)
> +		writel_relaxed(ADDRMAP0_CS0_B6(hif_offset - 2),
> +			       &mctl_ctl->addrmap[0]);
> +	else
> +		writel_relaxed(ADDRMAP0_CS0_B6(hif_offset),
> +			       &mctl_ctl->addrmap[0]);
> +}
> +
> +static void mctl_com_init(const struct dram_para *para,
> +			  const struct dram_config *config)
> +{
> +	void *const mctl_com = (void *)SUNXI_DRAM_COM_BASE;
> +	struct sunxi_mctl_ctl_reg *mctl_ctl =
> +		(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
> +
> +	/* Might control power/reset of DDR-related blocks */
> +	clrsetbits_le32(mctl_com + MCTL_COM_UNK_008, BIT(24), BIT(25) | BIT(9));
> +
> +	/* Unlock mctl_ctl registers */
> +	setbits_le32(mctl_com + MCTL_COM_MAER0, BIT(15));
> +
> +	if (para->type == SUNXI_DRAM_TYPE_LPDDR4)
> +		setbits_le32(0x03102ea8, BIT(0));
> +
> +	clrsetbits_le32(&mctl_ctl->sched[0], 0xff << 8, 0x30 << 8);
> +	if (!(para->tpr13 & BIT(28)))
> +		clrsetbits_le32(&mctl_ctl->sched[0], 0xf, BIT(0));
> +
> +	writel_relaxed(0, &mctl_ctl->hwlpctl);
> +
> +	/* Master settings */
> +	u32 mstr_value = MSTR_DEVICECONFIG_X32 |
> +			 MSTR_ACTIVE_RANKS(config->ranks);
> +
> +	if (config->bus_full_width)
> +		mstr_value |= MSTR_BUSWIDTH_FULL;
> +	else
> +		mstr_value |= MSTR_BUSWIDTH_HALF;
> +
> +	/*
> +	 * Geardown and 2T mode are always enabled here, but is controlled by a flag in boot0;
> +	 * it has not been a problem so far, but may be suspect if a particular board isn't booting.
> +	 */
> +	switch (para->type) {
> +	case SUNXI_DRAM_TYPE_DDR3:
> +		mstr_value |= MSTR_DEVICETYPE_DDR3 | MSTR_BURST_LENGTH(8) |
> +			      MSTR_2TMODE;
> +		break;
> +	case SUNXI_DRAM_TYPE_DDR4:
> +		mstr_value |= MSTR_DEVICETYPE_DDR4 | MSTR_BURST_LENGTH(8) |
> +			      MSTR_GEARDOWNMODE | MSTR_2TMODE;
> +		break;
> +	case SUNXI_DRAM_TYPE_LPDDR3:
> +		mstr_value |= MSTR_DEVICETYPE_LPDDR3 | MSTR_BURST_LENGTH(8);
> +		break;
> +	case SUNXI_DRAM_TYPE_LPDDR4:
> +		mstr_value |= MSTR_DEVICETYPE_LPDDR4 | MSTR_BURST_LENGTH(16);
> +		break;
> +	}
> +
> +	writel_relaxed(mstr_value, &mctl_ctl->mstr);
> +
> +	mctl_set_odtmap(para, config);
> +	mctl_set_addrmap(config);
> +	mctl_set_timing_params(para);
> +
> +	dsb();
> +	writel(0, &mctl_ctl->pwrctl);
> +
> +	/* Disable automatic controller updates + automatic controller update requests */
> +	setbits_le32(&mctl_ctl->dfiupd[0], BIT(31) | BIT(30));
> +	setbits_le32(&mctl_ctl->zqctl[0], BIT(31) | BIT(30));
> +	setbits_le32(&mctl_ctl->unk_0x2180, BIT(31) | BIT(30));
> +	setbits_le32(&mctl_ctl->unk_0x3180, BIT(31) | BIT(30));
> +	setbits_le32(&mctl_ctl->unk_0x4180, BIT(31) | BIT(30));
> +
> +	/*
> +	 * Data bus inversion
> +	 * Controlled by a flag in boot0, enabled by default here.
> +	 */
> +	if (para->type == SUNXI_DRAM_TYPE_DDR4 ||
> +	    para->type == SUNXI_DRAM_TYPE_LPDDR4)
> +		setbits_le32(&mctl_ctl->dbictl, BIT(2));
> +}
> +
> +static void mctl_drive_odt_config(const struct dram_para *para)
> +{
> +	u32 val;
> +	u64 base;
> +	u32 i;
> +
> +	/* DX drive */
> +	for (i = 0; i < 4; i++) {
> +		base = SUNXI_DRAM_PHY0_BASE + 0x388 + 0x40 * i;
> +		val = (para->dx_dri >> (i * 8)) & 0x1f;
> +
> +		writel_relaxed(val, base);
> +		if (para->type == SUNXI_DRAM_TYPE_LPDDR4) {
> +			if (para->tpr3 & 0x1f1f1f1f)
> +				val = (para->tpr3 >> (i * 8)) & 0x1f;
> +			else
> +				val = 4;
> +		}
> +		writel_relaxed(val, base + 4);
> +	}
> +
> +	/* CA drive */
> +	for (i = 0; i < 2; i++) {
> +		base = SUNXI_DRAM_PHY0_BASE + 0x340 + 0x8 * i;
> +		val = (para->ca_dri >> (i * 8)) & 0x1f;
> +
> +		writel_relaxed(val, base);
> +		writel_relaxed(val, base + 4);
> +	}
> +
> +	/* DX ODT */
> +	for (i = 0; i < 4; i++) {
> +		base = SUNXI_DRAM_PHY0_BASE + 0x380 + 0x40 * i;
> +		val = (para->dx_odt >> (i * 8)) & 0x1f;
> +
> +		if (para->type == SUNXI_DRAM_TYPE_DDR4 ||
> +		    para->type == SUNXI_DRAM_TYPE_LPDDR3)
> +			writel_relaxed(0, base);
> +		else
> +			writel_relaxed(val, base);
> +
> +		if (para->type == SUNXI_DRAM_TYPE_LPDDR4)
> +			writel_relaxed(0, base + 4);
> +		else
> +			writel_relaxed(val, base + 4);
> +	}
> +	dsb();
> +}
> +
> +static void mctl_phy_ca_bit_delay_compensation(const struct dram_para *para)
> +{
> +	u32 val, i;
> +	u32 *ptr;
> +
> +	if (para->tpr10 & BIT(31)) {
> +		val = para->tpr2;
> +	} else {
> +		val = ((para->tpr10 << 1) & 0x1e) |
> +		      ((para->tpr10 << 5) & 0x1e00) |
> +		      ((para->tpr10 << 9) & 0x1e0000) |
> +		      ((para->tpr10 << 13) & 0x1e000000);
> +
> +		if (para->tpr10 >> 29 != 0)
> +			val <<= 1;
> +	}
> +
> +	ptr = (u32 *)(SUNXI_DRAM_PHY0_BASE + 0x780);
> +	for (i = 0; i < 32; i++)
> +		writel_relaxed((val >> 8) & 0x3f, &ptr[i]);
> +
> +	writel_relaxed(val & 0x3f, SUNXI_DRAM_PHY0_BASE + 0x7dc);
> +	writel_relaxed(val & 0x3f, SUNXI_DRAM_PHY0_BASE + 0x7e0);
> +
> +	switch (para->type) {
> +	case SUNXI_DRAM_TYPE_DDR3:
> +		writel_relaxed((val >> 16) & 0x3f,
> +			       SUNXI_DRAM_PHY0_BASE + 0x7b8);
> +		writel_relaxed((val >> 24) & 0x3f,
> +			       SUNXI_DRAM_PHY0_BASE + 0x784);
> +		break;
> +	case SUNXI_DRAM_TYPE_DDR4:
> +		writel_relaxed((val >> 16) & 0x3f,
> +			       SUNXI_DRAM_PHY0_BASE + 0x784);
> +		break;
> +	case SUNXI_DRAM_TYPE_LPDDR3:
> +		writel_relaxed((val >> 16) & 0x3f,
> +			       SUNXI_DRAM_PHY0_BASE + 0x788);
> +		writel_relaxed((val >> 24) & 0x3f,
> +			       SUNXI_DRAM_PHY0_BASE + 0x790);
> +		break;
> +	case SUNXI_DRAM_TYPE_LPDDR4:
> +		writel_relaxed((val >> 16) & 0x3f,
> +			       SUNXI_DRAM_PHY0_BASE + 0x790);
> +		writel_relaxed((val >> 24) & 0x3f,
> +			       SUNXI_DRAM_PHY0_BASE + 0x78c);
> +		break;
> +	}
> +
> +	dsb();
> +}
> +
> +static void mctl_phy_init(const struct dram_para *para,
> +			  const struct dram_config *config)
> +{
> +	struct sunxi_mctl_ctl_reg *mctl_ctl =
> +		(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
> +	void *const prcm = (void *)SUNXI_PRCM_BASE;
> +	void *const mctl_com = (void *)SUNXI_DRAM_COM_BASE;
> +
> +	u32 val, val2, i;
> +	u32 *ptr;
> +
> +	/* Disable auto refresh. */
> +	setbits_le32(&mctl_ctl->rfshctl3, BIT(0));
> +
> +	/* Set "phy_dbi_mode" to mark the DFI as implementing DBI functionality */
> +	writel_relaxed(0, &mctl_ctl->pwrctl);
> +	clrbits_le32(&mctl_ctl->dfimisc, 1);
> +	writel_relaxed(0x20, &mctl_ctl->pwrctl);
> +
> +	/* PHY cold reset */
> +	clrsetbits_le32(mctl_com + MCTL_COM_UNK_008, BIT(24), BIT(9));
> +	udelay(1);
> +	setbits_le32(mctl_com + MCTL_COM_UNK_008, BIT(24));
> +
> +	/* Not sure what this gates the power of. */
> +	clrbits_le32(prcm + CCU_PRCM_SYS_PWROFF_GATING, BIT(4));
> +
> +	if (para->type == SUNXI_DRAM_TYPE_LPDDR4)
> +		clrbits_le32(SUNXI_DRAM_PHY0_BASE + 0x4, BIT(7));
> +
> +	/* Note: Similar enumeration of values is used during read training */
> +	if (config->bus_full_width)
> +		val = 0xf;
> +	else
> +		val = 0x3;
> +
> +	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 0x3c, 0xf, val);
> +
> +	switch (para->type) {
> +	case SUNXI_DRAM_TYPE_DDR3:
> +		val = 13;
> +		val2 = 9;
> +		break;
> +	case SUNXI_DRAM_TYPE_DDR4:
> +		val = 13;
> +		val2 = 10;
> +		break;
> +	case SUNXI_DRAM_TYPE_LPDDR3:
> +		val = 14;
> +		val2 = 8;
> +		break;
> +	case SUNXI_DRAM_TYPE_LPDDR4:
> +		if (para->tpr13 & BIT(28))
> +			val = 22;
> +		else
> +			val = 20;
> +
> +		val2 = 10;
> +		break;
> +	}
> +
> +	writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x14);
> +	writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x35c);
> +	writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x368);
> +	writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x374);
> +	writel_relaxed(0, SUNXI_DRAM_PHY0_BASE + 0x18);
> +	writel_relaxed(0, SUNXI_DRAM_PHY0_BASE + 0x360);
> +	writel_relaxed(0, SUNXI_DRAM_PHY0_BASE + 0x36c);
> +	writel_relaxed(0, SUNXI_DRAM_PHY0_BASE + 0x378);
> +	writel_relaxed(val2, SUNXI_DRAM_PHY0_BASE + 0x1c);
> +	writel_relaxed(val2, SUNXI_DRAM_PHY0_BASE + 0x364);
> +	writel_relaxed(val2, SUNXI_DRAM_PHY0_BASE + 0x370);
> +	writel_relaxed(val2, SUNXI_DRAM_PHY0_BASE + 0x37c);
> +
> +	/* Set up SDQ swizzle */
> +	ptr = (u32 *)(SUNXI_DRAM_PHY0_BASE + 0xc0);
> +	for (i = 0; i < ARRAY_SIZE(phy_init); i++)
> +		writel_relaxed(phy_init[i], &ptr[i]);
> +
> +	/* Set VREF */
> +	val = 0;
> +	switch (para->type) {
> +	case SUNXI_DRAM_TYPE_DDR3:
> +		val = para->tpr6 & 0xff;
> +		if (val == 0)
> +			val = 0x80;
> +		break;
> +	case SUNXI_DRAM_TYPE_DDR4:
> +		val = (para->tpr6 >> 8) & 0xff;
> +		if (val == 0)
> +			val = 0x80;
> +		break;
> +	case SUNXI_DRAM_TYPE_LPDDR3:
> +		val = (para->tpr6 >> 16) & 0xff;
> +		if (val == 0)
> +			val = 0x80;
> +		break;
> +	case SUNXI_DRAM_TYPE_LPDDR4:
> +		val = (para->tpr6 >> 24) & 0xff;
> +		if (val == 0)
> +			val = 0x33;
> +		break;
> +	}
> +	writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x3dc);
> +	writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x45c);
> +
> +	mctl_drive_odt_config(para);
> +
> +	if (para->tpr10 & TPR10_CA_BIT_DELAY)
> +		mctl_phy_ca_bit_delay_compensation(para);
> +
> +	switch (para->type) {
> +	case SUNXI_DRAM_TYPE_DDR3:
> +		val = 2;
> +		break;
> +	case SUNXI_DRAM_TYPE_LPDDR3:
> +		val = 3;
> +		break;
> +	case SUNXI_DRAM_TYPE_DDR4:
> +		val = 4;
> +		break;
> +	case SUNXI_DRAM_TYPE_LPDDR4:
> +		val = 5;
> +		break;
> +	}
> +
> +	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 0x4, 0x7, val | 8);
> +
> +	if (para->clk <= 672)
> +		writel_relaxed(0xf, SUNXI_DRAM_PHY0_BASE + 0x20);
> +
> +	if (para->clk > 500) {
> +		val = 0;
> +		val2 = 0;
> +	} else {
> +		val = 0x80;
> +		val2 = 0x20;
> +	}
> +
> +	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 0x144, 0x80, val);
> +	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 0x14c, 0xe0, val2);
> +
> +	dsb();
> +	clrbits_le32(mctl_com + MCTL_COM_UNK_008, BIT(9));
> +	udelay(1);
> +	clrbits_le32(SUNXI_DRAM_PHY0_BASE + 0x14c, BIT(3));
> +
> +	mctl_await_completion((u32 *)(SUNXI_DRAM_PHY0_BASE + 0x180), BIT(2),
> +			      BIT(2));
> +
> +	/*
> +	 * This delay is controlled by a tpr13 flag in boot0; doesn't hurt
> +	 * to always do it though.
> +	 */
> +	udelay(1000);
> +	writel(0x37, SUNXI_DRAM_PHY0_BASE + 0x58);
> +
> +	setbits_le32(prcm + CCU_PRCM_SYS_PWROFF_GATING, BIT(4));
> +}
> +
> +/* Helpers for updating mode registers */
> +static inline void mctl_mr_write(u32 mrctrl0, u32 mrctrl1)
> +{
> +	struct sunxi_mctl_ctl_reg *mctl_ctl =
> +		(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
> +
> +	writel(mrctrl1, &mctl_ctl->mrctrl1);
> +	writel(mrctrl0 | MRCTRL0_MR_WR | MRCTRL0_MR_RANKS_ALL,
> +	       &mctl_ctl->mrctrl0);
> +	mctl_await_completion(&mctl_ctl->mrctrl0, MRCTRL0_MR_WR, 0);
> +}
> +
> +static inline void mctl_mr_write_lpddr4(u8 addr, u8 value)
> +{
> +	mctl_mr_write(0, MRCTRL1_MR_ADDR(addr) | MRCTRL1_MR_DATA(value));
> +}
> +
> +static inline void mctl_mr_write_lpddr3(u8 addr, u8 value)
> +{
> +	/* Bit [7:6] are set by boot0, but undocumented */
> +	mctl_mr_write(BIT(6) | BIT(7),
> +		      MRCTRL1_MR_ADDR(addr) | MRCTRL1_MR_DATA(value));
> +}
> +
> +static void mctl_dfi_init(const struct dram_para *para)
> +{
> +	void *const mctl_com = (void *)SUNXI_DRAM_COM_BASE;
> +	struct sunxi_mctl_ctl_reg *mctl_ctl =
> +		(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
> +
> +	/* Unlock DFI registers? */
> +	setbits_le32(mctl_com + MCTL_COM_MAER0, BIT(8));
> +
> +	/* Enable dfi_init_complete signal and trigger PHY init start request */
> +	writel_relaxed(0, &mctl_ctl->swctl);
> +	setbits_le32(&mctl_ctl->dfimisc, BIT(0));
> +	setbits_le32(&mctl_ctl->dfimisc, BIT(5));
> +	writel_relaxed(1, &mctl_ctl->swctl);
> +	mctl_await_completion(&mctl_ctl->swstat, BIT(0), BIT(0));
> +
> +	/* Stop sending init request and wait for DFI initialization to complete. */
> +	writel_relaxed(0, &mctl_ctl->swctl);
> +	clrbits_le32(&mctl_ctl->dfimisc, BIT(5));
> +	writel_relaxed(1, &mctl_ctl->swctl);
> +	mctl_await_completion(&mctl_ctl->swstat, BIT(0), BIT(0));
> +	mctl_await_completion(&mctl_ctl->dfistat, BIT(0), BIT(0));
> +
> +	/* Enter Software Exit from Self Refresh */
> +	writel_relaxed(0, &mctl_ctl->swctl);
> +	clrbits_le32(&mctl_ctl->pwrctl, BIT(5));
> +	writel_relaxed(1, &mctl_ctl->swctl);
> +	mctl_await_completion(&mctl_ctl->swstat, BIT(0), BIT(0));
> +	mctl_await_completion(&mctl_ctl->statr, 0x3, 1);
> +
> +	udelay(200);
> +
> +	/* Disable dfi_init_complete signal */
> +	writel_relaxed(0, &mctl_ctl->swctl);
> +	clrbits_le32(&mctl_ctl->dfimisc, BIT(0));
> +	writel_relaxed(1, &mctl_ctl->swctl);
> +	mctl_await_completion(&mctl_ctl->swstat, BIT(0), BIT(0));
> +
> +	/* Write mode registers, fixed in the JEDEC spec */
> +	switch (para->type) {
> +	case SUNXI_DRAM_TYPE_DDR3:
> +		mctl_mr_write(MRCTRL0_MR_ADDR(0), 0x1c70);	/* MR0 */
> +		/*
> +		 * outbuf en, TDQs dis, write leveling dis, out drv 40 Ohms,
> +		 * DLL en, Rtt_nom 120 Ohms
> +		 */
> +		mctl_mr_write(MRCTRL0_MR_ADDR(1), 0x40);	/* MR1 */
> +		/*
> +		 * full array self-ref, CAS: 8 cyc, SRT w/ norm temp range,
> +		 * dynamic ODT off
> +		 */
> +		mctl_mr_write(MRCTRL0_MR_ADDR(2), 0x18);	/* MR2 */
> +		/* predef MPR pattern */
> +		mctl_mr_write(MRCTRL0_MR_ADDR(3), 0);		/* MR3 */
> +		break;
> +	case SUNXI_DRAM_TYPE_DDR4:
> +		mctl_mr_write(MRCTRL0_MR_ADDR(0), 0x840);
> +		mctl_mr_write(MRCTRL0_MR_ADDR(1), 0x601);
> +		mctl_mr_write(MRCTRL0_MR_ADDR(2), 0x8);
> +		mctl_mr_write(MRCTRL0_MR_ADDR(3), 0);
> +		mctl_mr_write(MRCTRL0_MR_ADDR(4), 0);
> +		mctl_mr_write(MRCTRL0_MR_ADDR(5), 0x400);
> +
> +		mctl_mr_write(MRCTRL0_MR_ADDR(6), 0x862 | BIT(7));
> +		mctl_mr_write(MRCTRL0_MR_ADDR(6), 0x862 | BIT(7));
> +		mctl_mr_write(MRCTRL0_MR_ADDR(6), 0x862 & (~BIT(7)));
> +		break;
> +	case SUNXI_DRAM_TYPE_LPDDR3:
> +		mctl_mr_write_lpddr3(1, 0xc3);	/* MR1: nWR=8, BL8 */
> +		mctl_mr_write_lpddr3(2, 0xa);	/* MR2: RL=12, WL=6 */
> +		mctl_mr_write_lpddr3(3, 0x2);	/* MR3: 40 0hms PD/PU */
> +		mctl_mr_write_lpddr3(11, para->mr11);
> +		break;
> +	case SUNXI_DRAM_TYPE_LPDDR4:
> +		mctl_mr_write_lpddr4(0, 0);	/* MR0 */
> +		mctl_mr_write_lpddr4(1, 0x34);	/* MR1 */
> +		mctl_mr_write_lpddr4(2, 0x1b);	/* MR2 */
> +		mctl_mr_write_lpddr4(3, 0x33);	/* MR3 */
> +		mctl_mr_write_lpddr4(4, 0x3);	/* MR4 */
> +		mctl_mr_write_lpddr4(11, para->mr11);
> +		mctl_mr_write_lpddr4(12, para->mr12);
> +		mctl_mr_write_lpddr4(13, para->mr13);
> +		mctl_mr_write_lpddr4(14, para->mr14);
> +		mctl_mr_write_lpddr4(22, para->tpr1);
> +		break;
> +	}
> +
> +	writel(0, SUNXI_DRAM_PHY0_BASE + 0x54);
> +
> +	/* Re-enable controller refresh */
> +	writel(0, &mctl_ctl->swctl);
> +	clrbits_le32(&mctl_ctl->rfshctl3, BIT(0));
> +	writel(1, &mctl_ctl->swctl);
> +}
> +
> +/* Slightly modified from H616 driver */
> +static bool mctl_phy_read_calibration(const struct dram_config *config)
> +{
> +	bool result = true;
> +	u32 val, tmp;
> +
> +	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 8, 0x30, 0x20);
> +
> +	setbits_le32(SUNXI_DRAM_PHY0_BASE + 8, 1);
> +
> +	if (config->bus_full_width)
> +		val = 0xf;
> +	else
> +		val = 3;
> +
> +	while ((readl_relaxed(SUNXI_DRAM_PHY0_BASE + 0x184) & val) != val) {
> +		if (readl_relaxed(SUNXI_DRAM_PHY0_BASE + 0x184) & 0x20) {
> +			result = false;
> +			break;
> +		}
> +	}
> +
> +	clrbits_le32(SUNXI_DRAM_PHY0_BASE + 8, 1);
> +
> +	clrbits_le32(SUNXI_DRAM_PHY0_BASE + 8, 0x30);
> +
> +	if (config->ranks == 1) {
> +		clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 8, 0x30, 0x10);
> +
> +		setbits_le32(SUNXI_DRAM_PHY0_BASE + 8, 1);
> +
> +		while ((readl_relaxed(SUNXI_DRAM_PHY0_BASE + 0x184) & val) !=
> +		       val) {
> +			if (readl_relaxed(SUNXI_DRAM_PHY0_BASE + 0x184) &
> +			    0x20) {
> +				result = false;
> +				break;
> +			}
> +		}
> +
> +		clrbits_le32(SUNXI_DRAM_PHY0_BASE + 8, 1);
> +	}
> +
> +	clrbits_le32(SUNXI_DRAM_PHY0_BASE + 8, 0x30);
> +
> +	val = readl_relaxed(SUNXI_DRAM_PHY0_BASE + 0x274) & 7;
> +	tmp = readl_relaxed(SUNXI_DRAM_PHY0_BASE + 0x26c) & 7;
> +	if (val < tmp)
> +		val = tmp;
> +	tmp = readl_relaxed(SUNXI_DRAM_PHY0_BASE + 0x32c) & 7;
> +	if (val < tmp)
> +		val = tmp;
> +	tmp = readl_relaxed(SUNXI_DRAM_PHY0_BASE + 0x334) & 7;
> +	if (val < tmp)
> +		val = tmp;
> +	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 0x38, 0x7, (val + 2) & 7);
> +
> +	setbits_le32(SUNXI_DRAM_PHY0_BASE + 4, 0x20);
> +
> +	return result;
> +}
> +
> +static inline void mctl_phy_dx_delay1_inner(u32 *base, u32 val1, u32 val2)
> +{
> +	u32 *ptr = base;
> +
> +	for (int i = 0; i < 9; i++) {
> +		writel_relaxed(val1, ptr);
> +		writel_relaxed(val1, ptr + 0x30);
> +		ptr += 2;
> +	}
> +
> +	writel_relaxed(val2, ptr + 1);
> +	writel_relaxed(val2, ptr + 49);
> +	writel_relaxed(val2, ptr);
> +	writel_relaxed(val2, ptr + 48);
> +}
> +
> +static inline void mctl_phy_dx_delay0_inner(u32 *base1, u32 *base2, u32 val1,
> +					    u32 val2)
> +{
> +	u32 *ptr = base1;
> +
> +	for (int i = 0; i < 9; i++) {
> +		writel_relaxed(val1, ptr);
> +		writel_relaxed(val1, ptr + 0x30);
> +		ptr += 2;
> +	}
> +
> +	writel_relaxed(val2, base2);
> +	writel_relaxed(val2, base2 + 48);
> +	writel_relaxed(val2, ptr);
> +	writel_relaxed(val2, base2 + 44);
> +}
> +
> +/*
> + * This might be somewhat transferable to H616; whether or not people like
> + * the design is another question
> + */
> +static void mctl_phy_dx_delay_compensation(const struct dram_para *para)
> +{
> +	if (para->tpr10 & TPR10_DX_BIT_DELAY1) {
> +		clrbits_le32(SUNXI_DRAM_PHY0_BASE + 0x60, 1);
> +		setbits_le32(SUNXI_DRAM_PHY0_BASE + 8, BIT(3));
> +		clrbits_le32(SUNXI_DRAM_PHY0_BASE + 0x190, BIT(4));
> +
> +		if (para->type == SUNXI_DRAM_TYPE_DDR4)
> +			clrbits_le32(SUNXI_DRAM_PHY0_BASE + 0x4, BIT(7));
> +
> +		mctl_phy_dx_delay1_inner((u32 *)(SUNXI_DRAM_PHY0_BASE + 0x484),
> +					 para->tpr11 & 0x3f,
> +					 para->para0 & 0x3f);
> +		mctl_phy_dx_delay1_inner((u32 *)(SUNXI_DRAM_PHY0_BASE + 0x4d8),
> +					 (para->tpr11 >> 8) & 0x3f,
> +					 (para->para0 >> 8) & 0x3f);
> +		mctl_phy_dx_delay1_inner((u32 *)(SUNXI_DRAM_PHY0_BASE + 0x604),
> +					 (para->tpr11 >> 16) & 0x3f,
> +					 (para->para0 >> 16) & 0x3f);
> +		mctl_phy_dx_delay1_inner((u32 *)(SUNXI_DRAM_PHY0_BASE + 0x658),
> +					 (para->tpr11 >> 24) & 0x3f,
> +					 (para->para0 >> 24) & 0x3f);
> +
> +		setbits_le32(SUNXI_DRAM_PHY0_BASE + 0x60, 1);
> +	}
> +
> +	if (para->tpr10 & TPR10_DX_BIT_DELAY0) {
> +		clrbits_le32(SUNXI_DRAM_PHY0_BASE + 0x54, BIT(7));
> +		clrbits_le32(SUNXI_DRAM_PHY0_BASE + 0x190, BIT(2));
> +
> +		mctl_phy_dx_delay0_inner((u32 *)(SUNXI_DRAM_PHY0_BASE + 0x480),
> +					 (u32 *)(SUNXI_DRAM_PHY0_BASE + 0x528),
> +					 para->tpr12 & 0x3f,
> +					 para->tpr14 & 0x3f);
> +
> +		mctl_phy_dx_delay0_inner((u32 *)(SUNXI_DRAM_PHY0_BASE + 0x4d4),
> +					 (u32 *)(SUNXI_DRAM_PHY0_BASE + 0x52c),
> +					 (para->tpr12 >> 8) & 0x3f,
> +					 (para->tpr14 >> 8) & 0x3f);
> +
> +		mctl_phy_dx_delay0_inner((u32 *)(SUNXI_DRAM_PHY0_BASE + 0x600),
> +					 (u32 *)(SUNXI_DRAM_PHY0_BASE + 0x6a8),
> +					 (para->tpr12 >> 16) & 0x3f,
> +					 (para->tpr14 >> 16) & 0x3f);
> +
> +		mctl_phy_dx_delay0_inner((u32 *)(SUNXI_DRAM_PHY0_BASE + 0x6ac),
> +					 (u32 *)(SUNXI_DRAM_PHY0_BASE + 0x528),
> +					 (para->tpr12 >> 24) & 0x3f,
> +					 (para->tpr14 >> 24) & 0x3f);
> +
> +		setbits_le32(SUNXI_DRAM_PHY0_BASE + 0x54, BIT(7));
> +	}
> +}
> +
> +static bool mctl_calibrate_phy(const struct dram_para *para,
> +			       const struct dram_config *config)
> +{
> +	struct sunxi_mctl_ctl_reg *mctl_ctl =
> +		(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
> +
> +	int i;
> +
> +	/* TODO: Implement write levelling */
> +	if (para->tpr10 & TPR10_READ_CALIBRATION) {
> +		for (i = 0; i < 5; i++)
> +			if (mctl_phy_read_calibration(config))
> +				break;
> +		if (i == 5) {
> +			debug("read calibration failed\n");
> +			return false;
> +		}
> +	}
> +
> +	/* TODO: Implement read training */
> +	/* TODO: Implement write training */
> +
> +	mctl_phy_dx_delay_compensation(para);
> +	/* TODO: Implement DFS */
> +	clrbits_le32(SUNXI_DRAM_PHY0_BASE + 0x60, BIT(0));
> +	clrbits_le32(SUNXI_DRAM_PHY0_BASE + 0x54, 7);
> +
> +	/* Q: Does self-refresh get disabled by a calibration? */
> +	writel_relaxed(0, &mctl_ctl->swctl);
> +	clrbits_le32(&mctl_ctl->rfshctl3, BIT(1));
> +	writel_relaxed(1, &mctl_ctl->swctl);
> +	mctl_await_completion(&mctl_ctl->swstat, BIT(0), BIT(0));
> +
> +	return true;
> +}
> +
> +static bool mctl_core_init(const struct dram_para *para,
> +			   const struct dram_config *config)
> +{
> +	mctl_clk_init(para->clk);
> +	mctl_com_init(para, config);
> +	mctl_phy_init(para, config);
> +	mctl_dfi_init(para);
> +
> +	return mctl_calibrate_phy(para, config);
> +}
> +
> +/* Heavily inspired from H616 driver. */
> +static void auto_detect_ranks(const struct dram_para *para,
> +			      struct dram_config *config)
> +{
> +	int i;
> +
> +	config->cols = 9;
> +	config->rows = 14;
> +	config->banks = 2;
> +	config->bankgrps = 0;
> +
> +	/* Test ranks */
> +	for (i = 1; i >= 0; i--) {
> +		config->ranks = i;
> +		config->bus_full_width = true;
> +		debug("Testing ranks = %d, 32-bit bus: ", i);
> +		if (mctl_core_init(para, config)) {
> +			debug("OK\n");
> +			break;
> +		}
> +
> +		config->bus_full_width = false;
> +		debug("Testing ranks = %d, 16-bit bus: ", i);
> +		if (mctl_core_init(para, config)) {
> +			debug("OK\n");
> +			break;
> +		}
> +	}
> +
> +	if (i < 0)
> +		debug("rank testing failed\n");
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
> +static void mctl_auto_detect_dram_size(const struct dram_para *para,
> +				       struct dram_config *config)
> +{
> +	unsigned int shift;
> +	u32 buffer[16];
> +
> +	/* max config for bankgrps on DDR4, minimum for everything else */
> +	config->cols = 8;
> +	config->banks = 2;
> +	config->rows = 14;
> +
> +	shift = 1 + config->bus_full_width;
> +	if (para->type == SUNXI_DRAM_TYPE_DDR4) {
> +		config->bankgrps = 2;
> +		mctl_core_init(para, config);
> +
> +		/* store content so it can be restored later. */
> +		memcpy(buffer, (u32 *)CFG_SYS_SDRAM_BASE, sizeof(buffer));
> +		mctl_write_pattern();
> +
> +		if (mctl_check_pattern(1ULL << (shift + 4)))
> +			config->bankgrps = 1;
> +
> +		/* restore data */
> +		memcpy((u32 *)CFG_SYS_SDRAM_BASE, buffer, sizeof(buffer));
> +	} else {
> +		/* No bank groups in (LP)DDR3/LPDDR4 */
> +		config->bankgrps = 0;
> +	}
> +
> +	/* reconfigure to make sure all active columns are accessible */
> +	config->cols = 12;
> +	mctl_core_init(para, config);
> +
> +	/* store data again as it might be moved */
> +	memcpy(buffer, (u32 *)CFG_SYS_SDRAM_BASE, sizeof(buffer));
> +	mctl_write_pattern();
> +
> +	/*
> +	 * Detect column address bits. The last number of columns checked
> +	 * is 11, if that doesn't match, is must be 12, no more checks needed.
> +	 */
> +	shift = 1 + config->bus_full_width + config->bankgrps;
> +	for (config->cols = 8; config->cols < 12; config->cols++) {
> +		if (mctl_check_pattern(1ULL << (config->cols + shift)))
> +			break;
> +	}
> +	memcpy((u32 *)CFG_SYS_SDRAM_BASE, buffer, sizeof(buffer));
> +
> +	/* reconfigure to make sure that all active banks are accessible */
> +	config->banks = 3;
> +	mctl_core_init(para, config);
> +
> +	memcpy(buffer, (u32 *)CFG_SYS_SDRAM_BASE, sizeof(buffer));
> +	mctl_write_pattern();
> +
> +	/* detect bank bits */
> +	shift += config->cols;
> +	for (config->banks = 2; config->banks < 3; config->banks++) {
> +		if (mctl_check_pattern(1ULL << (config->banks + shift)))
> +			break;
> +	}
> +	memcpy((u32 *)CFG_SYS_SDRAM_BASE, buffer, sizeof(buffer));
> +
> +	/* reconfigure to make sure that all active rows are accessible */
> +	config->rows = 18;
> +	mctl_core_init(para, config);
> +
> +	memcpy(buffer, (u32 *)CFG_SYS_SDRAM_BASE, sizeof(buffer));
> +	mctl_write_pattern();
> +
> +	/* detect row address bits */
> +	shift += config->banks;
> +	for (config->rows = 14; config->rows < 18; config->rows++) {
> +		if (mctl_check_pattern(1ULL << (config->rows + shift)))
> +			break;
> +	}
> +	memcpy((u32 *)CFG_SYS_SDRAM_BASE, buffer, sizeof(buffer));
> +}
> +
> +/* Modified from H616 driver to add banks and bank groups */
> +static unsigned long calculate_dram_size(const struct dram_config *config)
> +{
> +	/* Bootrom only uses x32 or x16 bus widths */
> +	u8 width = config->bus_full_width ? 4 : 2;
> +
> +	return (1ULL << (config->cols + config->rows + config->banks +
> +			 config->bankgrps)) *
> +	       width * (1ULL << config->ranks);
> +}
> +
> +static const struct dram_para para = {
> +	.clk = CONFIG_DRAM_CLK,
> +#ifdef CONFIG_SUNXI_DRAM_DDR3
> +	.type = SUNXI_DRAM_TYPE_DDR3,
> +#elif defined(CONFIG_SUNXI_DRAM_DDR4)
> +	.type = SUNXI_DRAM_TYPE_DDR4,
> +#elif defined(CONFIG_SUNXI_DRAM_LPDDR3)
> +	.type = SUNXI_DRAM_TYPE_LPDDR3,
> +#elif defined(CONFIG_SUNXI_DRAM_LPDDR4)
> +	.type = SUNXI_DRAM_TYPE_LPDDR4,
> +#endif
> +	/* TODO: Populate from config */
> +	.dx_odt = CONFIG_DRAM_SUNXI_DX_ODT,
> +	.dx_dri = CONFIG_DRAM_SUNXI_DX_DRI,
> +	.ca_dri = CONFIG_DRAM_SUNXI_CA_DRI,
> +	.para0 = CONFIG_DRAM_SUNXI_PARA0,
> +	.mr11 = CONFIG_DRAM_SUNXI_MR11,
> +	.mr12 = CONFIG_DRAM_SUNXI_MR12,
> +	.mr13 = CONFIG_DRAM_SUNXI_MR13,
> +	.mr14 = CONFIG_DRAM_SUNXI_MR14,
> +	.tpr1 = CONFIG_DRAM_SUNXI_TPR1,
> +	.tpr2 = CONFIG_DRAM_SUNXI_TPR2,
> +	.tpr3 = CONFIG_DRAM_SUNXI_TPR3,
> +	.tpr6 = CONFIG_DRAM_SUNXI_TPR6,
> +	.tpr10 = CONFIG_DRAM_SUNXI_TPR10,
> +	.tpr11 = CONFIG_DRAM_SUNXI_TPR11,
> +	.tpr12 = CONFIG_DRAM_SUNXI_TPR12,
> +	.tpr13 = CONFIG_DRAM_SUNXI_TPR13,
> +	.tpr14 = CONFIG_DRAM_SUNXI_TPR14,
> +};
> +
> +unsigned long sunxi_dram_init(void)
> +{
> +	struct dram_config config;
> +
> +	/* Writing to undocumented SYS_CFG area, according to user manual. */
> +	setbits_le32(0x03000160, BIT(8));
> +	clrbits_le32(0x03000168, 0x3f);
> +
> +	auto_detect_ranks(&para, &config);
> +	mctl_auto_detect_dram_size(&para, &config);
> +
> +	if (!mctl_core_init(&para, &config))
> +		return 0;
> +
> +	debug("cols = 2^%d, rows = 2^%d, banks = %d, bank groups = %d, ranks = %d, width = %d\n",
> +	      config.cols, config.rows, 1U << config.banks,
> +	      1U << config.bankgrps, 1U << config.ranks,
> +	      16U << config.bus_full_width);
> +
> +	return calculate_dram_size(&config);
> +}
> diff --git a/arch/arm/mach-sunxi/dram_timings/Makefile b/arch/arm/mach-sunxi/dram_timings/Makefile
> index 5f203419240..4dc1f29fc08 100644
> --- a/arch/arm/mach-sunxi/dram_timings/Makefile
> +++ b/arch/arm/mach-sunxi/dram_timings/Makefile
> @@ -6,3 +6,5 @@ obj-$(CONFIG_SUNXI_DRAM_H6_DDR3_1333)	+= h6_ddr3_1333.o
>  obj-$(CONFIG_SUNXI_DRAM_H616_DDR3_1333)	+= h616_ddr3_1333.o
>  obj-$(CONFIG_SUNXI_DRAM_H616_LPDDR3)	+= h616_lpddr3.o
>  obj-$(CONFIG_SUNXI_DRAM_H616_LPDDR4)	+= h616_lpddr4_2133.o
> +obj-$(CONFIG_SUNXI_DRAM_A133_DDR4)	+= a133_ddr4.o
> +obj-$(CONFIG_SUNXI_DRAM_A133_LPDDR4)	+= a133_lpddr4.o
> diff --git a/arch/arm/mach-sunxi/dram_timings/a133_ddr4.c b/arch/arm/mach-sunxi/dram_timings/a133_ddr4.c
> new file mode 100644
> index 00000000000..dec208e22df
> --- /dev/null
> +++ b/arch/arm/mach-sunxi/dram_timings/a133_ddr4.c
> @@ -0,0 +1,80 @@
> +#include <asm/arch/cpu.h>
> +#include <asm/arch/dram.h>
> +
> +void mctl_set_timing_params(const struct dram_para *para)
> +{
> +	struct sunxi_mctl_ctl_reg *const mctl_ctl =
> +		(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
> +
> +	u8 txsr = 4;
> +	u8 tccd = 3;
> +	u8 rd2wr = 5;
> +	u8 tmrd = 4;
> +	u8 tmrw = 0;
> +	u8 wrlat = 5;
> +	u8 rdlat = 7;
> +	u8 wr2pre = 14;
> +	u8 dfi_tphy_wrlat = 6;
> +	u8 dfi_trddata_en = 10;
> +
> +	u8 tfaw = ns_to_t(35);
> +	u8 trrd = max(ns_to_t(8), 2);
> +	u8 txp = max(ns_to_t(6), 2);
> +	u8 tmrd_pda = max(ns_to_t(10), 8);
> +	u8 trp = ns_to_t(15);
> +	u8 trc = ns_to_t(49);
> +	u8 wr2rd_s = max(ns_to_t(3), 1) + 7;
> +	u8 tras_min = ns_to_t(34);
> +	u16 trefi_x32 = ns_to_t(7800) / 32;
> +	u16 trfc_min = ns_to_t(350);
> +	u16 txs_x32 = ns_to_t(360) / 32;
> +	u16 tmod = max(ns_to_t(15), 12);
> +	u8 tcke = max(ns_to_t(5), 2);
> +	u8 tcksrx = max(ns_to_t(10), 3);
> +	u8 txs_abort_x32 = ns_to_t(170) / 32;
> +	u8 tras_max = ns_to_t(70200) / 1024;
> +
> +	u8 rd2pre = (trp < 5 ? 9 - trp : 4);
> +	u8 wr2rd = trrd + 7;
> +	u8 tckesr = tcke + 1;
> +	u8 trcd = trp;
> +	u8 trrd_s = txp;
> +	u8 tcksre = tcksrx;
> +
> +	writel(tras_min | tras_max << 8 | tfaw << 16 | wr2pre << 24,
> +	       &mctl_ctl->dramtmg[0]);
> +	writel(trc | rd2pre << 8 | txp << 16, &mctl_ctl->dramtmg[1]);
> +	writel(wr2rd | rd2wr << 8 | rdlat << 16 | wrlat << 24,
> +	       &mctl_ctl->dramtmg[2]);
> +	writel(tmod | tmrd << 12 | tmrw << 20, &mctl_ctl->dramtmg[3]);
> +	writel(trp | trrd << 8 | tccd << 16 | trcd << 24,
> +	       &mctl_ctl->dramtmg[4]);
> +	writel(tcke | tckesr << 8 | tcksre << 16 | tcksrx << 24,
> +	       &mctl_ctl->dramtmg[5]);
> +	writel((txp + 2) | 0x20 << 16 | 0x20 << 24,
> +	       &mctl_ctl->dramtmg[6]);
> +	writel(txs_x32 | 0x10 << 8 | txs_abort_x32 << 16 | txs_abort_x32 << 24,
> +	       &mctl_ctl->dramtmg[8]);
> +	writel(wr2rd_s | trrd_s << 8 | 0x2 << 16, &mctl_ctl->dramtmg[9]);
> +	writel(0xe0c05, &mctl_ctl->dramtmg[10]);
> +	writel(0x440c021c, &mctl_ctl->dramtmg[11]);
> +	writel(tmrd_pda, &mctl_ctl->dramtmg[12]);
> +	writel(0xa100002, &mctl_ctl->dramtmg[13]);
> +	writel(txsr, &mctl_ctl->dramtmg[14]);
> +
> +	clrsetbits_le32(&mctl_ctl->init[0], 0xc0000fff, 1008);
> +	writel(0x1f20000, &mctl_ctl->init[1]);
> +	clrsetbits_le32(&mctl_ctl->init[2], 0xff0f, 0xd05);
> +	writel(0, &mctl_ctl->dfimisc);
> +
> +	writel(0x840 << 16 | 0x601, &mctl_ctl->init[3]);	/* MR0 / MR1 */
> +	writel(0x8 << 16 | 0x0, &mctl_ctl->init[4]);		/* MR2 / MR3 */
> +	writel(0x0 << 16 | 0x400, &mctl_ctl->init[6]);		/* MR4 / MR5 */
> +	writel(0x826, &mctl_ctl->init[7]);			/* MR6 */
> +
> +	clrsetbits_le32(&mctl_ctl->rankctl, 0xff0, 0x660);
> +	writel((dfi_tphy_wrlat - 1) | 0x2000000 | (dfi_trddata_en - 1) << 16 |
> +	       0x808000, &mctl_ctl->dfitmg0);
> +	writel(0x100202, &mctl_ctl->dfitmg1);
> +	writel(trfc_min | trefi_x32 << 16, &mctl_ctl->rfshtmg);
> +}
> diff --git a/arch/arm/mach-sunxi/dram_timings/a133_lpddr4.c b/arch/arm/mach-sunxi/dram_timings/a133_lpddr4.c
> new file mode 100644
> index 00000000000..1e607381023
> --- /dev/null
> +++ b/arch/arm/mach-sunxi/dram_timings/a133_lpddr4.c
> @@ -0,0 +1,102 @@
> +#include <asm/arch/cpu.h>
> +#include <asm/arch/dram.h>
> +
> +void mctl_set_timing_params(const struct dram_para *para)
> +{
> +	struct sunxi_mctl_ctl_reg *const mctl_ctl =
> +		(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
> +
> +	bool tpr13_flag1 = para->tpr13 & BIT(28);
> +	bool tpr13_flag2 = para->tpr13 & BIT(3);
> +	bool tpr13_flag3 = para->tpr13 & BIT(5);
> +
> +	u8 tccd		= 4;
> +	u8 tfaw		= ns_to_t(40);
> +	u8 trrd		= max(ns_to_t(10), 2);
> +	u8 trcd		= max(ns_to_t(18), 2);
> +	u8 trc		= ns_to_t(65);
> +	u8 txp		= max(ns_to_t(8), 2);
> +
> +	u8 trp		= ns_to_t(21);
> +	u8 tras_min	= ns_to_t(42);
> +	u16 trefi_x32	= ns_to_t(3904) / 32;
> +	u16 trfc_min	= ns_to_t(180);
> +	u16 txsr	= ns_to_t(190);
> +
> +	u8 tmrw		= max(ns_to_t(14), 5);
> +	u8 tmrd		= max(ns_to_t(14), 5);
> +	u8 tmod		= 12;
> +	u8 tcke		= max(ns_to_t(15), 2);
> +	u8 tcksrx	= max(ns_to_t(2), 2);
> +	u8 tcksre	= max(ns_to_t(5), 2);
> +	u8 tckesr	= max(ns_to_t(15), 2);
> +	u8 tras_max	= (trefi_x32 * 9) / 32;
> +	u8 txs_x32	= 4;
> +	u8 txsabort_x32 = 4;
> +
> +	u8 wrlat        = 5;
> +	u8 wr2rd_s      = 8;
> +	u8 trrd_s       = 2;
> +	u8 tmrd_pda     = 8;
> +
> +	u8 wr2pre       = 24;
> +	u8 rd2pre       = 4;
> +	u8 wr2rd        = 14 + max(ns_to_t(tpr13_flag1 ? 10 : 12), 4);
> +	u8 rd2wr        = 17 + ns_to_t(4) - ns_to_t(1);
> +	u8 tphy_wrlat	= 5;
> +
> +	u8 rdlat	= 10;
> +	u8 trddata_en	= 17;
> +
> +	if (tpr13_flag1) {
> +		rdlat = 11;
> +		trddata_en = 19;
> +	}
> +
> +	writel(tras_min | tras_max << 8 | tfaw << 16 | wr2pre << 24,
> +	       &mctl_ctl->dramtmg[0]);
> +	writel(trc | rd2pre << 8 | txp << 16, &mctl_ctl->dramtmg[1]);
> +	writel(wr2rd | rd2wr << 8 | rdlat << 16 | wrlat << 24,
> +	       &mctl_ctl->dramtmg[2]);
> +	writel(tmod | tmrd << 12 | tmrw << 20, &mctl_ctl->dramtmg[3]);
> +	writel(trp | trrd << 8 | tccd << 16 | trcd << 24,
> +	       &mctl_ctl->dramtmg[4]);
> +	writel(tcke | tckesr << 8 | tcksre << 16 | tcksrx << 24,
> +	       &mctl_ctl->dramtmg[5]);
> +	writel((txp + 2) | 0x20 << 16 | 0x20 << 24, &mctl_ctl->dramtmg[6]);
> +	writel(txs_x32 | 0x10 << 8 | txsabort_x32 << 16 | txsabort_x32 << 24,
> +	       &mctl_ctl->dramtmg[8]);
> +	writel(wr2rd_s | trrd_s << 8 | 0x2 << 16, &mctl_ctl->dramtmg[9]);
> +	writel(0xe0c05, &mctl_ctl->dramtmg[10]);
> +	writel(0x440c021c, &mctl_ctl->dramtmg[11]);
> +	writel(tmrd_pda, &mctl_ctl->dramtmg[12]);
> +	writel(0xa100002, &mctl_ctl->dramtmg[13]);
> +	writel(txsr, &mctl_ctl->dramtmg[14]);
> +
> +	clrsetbits_le32(&mctl_ctl->init[0], 0xc0000fff, 1008);
> +
> +	if (tpr13_flag2)
> +		writel(0x420000, &mctl_ctl->init[1]);
> +	else
> +		writel(0x1f20000, &mctl_ctl->init[1]);
> +
> +	clrsetbits_le32(&mctl_ctl->init[2], 0xff0f, 0xd05);
> +	writel(0, &mctl_ctl->dfimisc);
> +
> +	writel(0x34 << 16 | 0x1b, &mctl_ctl->init[3]);		/* MR1/MR2 */
> +	writel(0x33 << 16, &mctl_ctl->init[4]);			/* MR3 */
> +	writel(para->mr11 << 16 | para->mr12, &mctl_ctl->init[6]);
> +	writel(para->tpr1 << 16 | para->mr14, &mctl_ctl->init[7]);
> +
> +	clrsetbits_le32(&mctl_ctl->rankctl, 0xff0, 0x660);
> +	if (!tpr13_flag3) {
> +		tphy_wrlat -= 1;
> +		trddata_en -= 1;
> +	}
> +
> +	writel(tphy_wrlat | trddata_en << 16 | 0x808000 | 0x2000000,
> +	       &mctl_ctl->dfitmg0);
> +	writel(0x100202, &mctl_ctl->dfitmg1);
> +
> +	writel(trfc_min | trefi_x32 << 16, &mctl_ctl->rfshtmg);
> +}

