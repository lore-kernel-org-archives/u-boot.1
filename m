Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8324C02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 16:28:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9940803CB;
	Sat, 18 Jan 2025 17:27:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=epochal.quest
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=epochal.quest header.i=@epochal.quest header.b="FPQqQ5L3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3553680716; Sat, 18 Jan 2025 16:20:27 +0100 (CET)
Received: from thales.epochal.quest (thales.epochal.quest [51.222.15.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A27280312
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 16:20:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=epochal.quest
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masterr3c0rd@epochal.quest
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epochal.quest;
 s=default; t=1737213622;
 bh=YVywVokcRioh6zjHBEntKk3yKq6bSPETAl1lc8197co=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=FPQqQ5L3ZkNSg1TnkyUvveic5Mg+awcl1xcHJ7DmbMFZmzt09QstG1j0TYmNQcSCy
 XZ4lkTD6zkKVA6lGJyvNlrulYH36yeXhpYc5olAOE8xCCb3eKNom+3+64zmcHzQ2GJ
 OyPfPUxb7M2R+jbxytRHIs9Y0WIxiazAGG7g6Ygrraesy5A8NrXXY45IPN4NPnqVQY
 5ldP/PZ9O5StHput01WnECV3ynknbUegUvdnYcHBTETOUwdazGpHPcxA9cRyMCT2v9
 mRU+yh+Zx6EWGGNse4+xQO7Fd3GPUqO/YeqdCO/BWPnqzJG9iXWfOtBiplx0hjJF94
 EJ95XSoXWG50Q==
MIME-Version: 1.0
Date: Sat, 18 Jan 2025 11:20:19 -0400
From: Cody Eksal <masterr3c0rd@epochal.quest>
To: =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>, Sean Anderson
 <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Andre Przywara
 <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@chromium.org>, linux-sunxi@lists.linux.dev, Parthiban
 <parthiban@linumiz.com>
Subject: Re: [PATCH 7/8] sunxi: A133: add DRAM init code [WIP!]
In-Reply-To: <23798710.6Emhk5qWAg@jernej-laptop>
References: <20250117014537.22513-1-andre.przywara@arm.com>
 <20250117014537.22513-8-andre.przywara@arm.com>
 <23798710.6Emhk5qWAg@jernej-laptop>
Message-ID: <d361206f2e25a155e67238770a140ac2@epochal.quest>
X-Sender: masterr3c0rd@epochal.quest
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 18 Jan 2025 17:27:57 +0100
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

On 2025/01/18 4:17 am, Jernej Škrabec wrote:
> Dne petek, 17. januar 2025 ob 02:45:36 Srednjeevropski standardni čas 
> je Andre Przywara napisal(a):
>> From: Cody Eksal <masterr3c0rd@epochal.quest>
>> 
>> This adds preliminary support for the DRAM controller in the Allwinner
>> A100/A133 SoCs.
>> This is work in progress, and has rough edges, but works on at least
>> three different boards. It contains support for DDR4 and LPDDR4.
> 
> Since this is clearly WIP and SoF missing, just some comments below.
Hi Jernej; thank you for your feedback! Some replies and
clarifications below.

>> ---
*snip*
>> +/* TODO: Remove unused fields */
>> +struct dram_para {
>> +	uint32_t clk;
>> +	enum sunxi_dram_type type;
>> +	uint32_t dx_odt;
>> +	uint32_t dx_dri;
>> +	uint32_t ca_dri;
>> +	uint32_t para0;
>> +	uint32_t para1;
>> +	uint32_t para2;
>> +	uint32_t mr0;
>> +	uint32_t mr1;
>> +	uint32_t mr2;
>> +	uint32_t mr3;
>> +	uint32_t mr4;
>> +	uint32_t mr5;
>> +	uint32_t mr6;
>> +	uint32_t mr11;
>> +	uint32_t mr12;
>> +	uint32_t mr13;
>> +	uint32_t mr14;
>> +	uint32_t mr16;
>> +	uint32_t mr17;
>> +	uint32_t mr22;
>> +	uint32_t tpr1;
>> +	uint32_t tpr2;
>> +	uint32_t tpr3;
>> +	uint32_t tpr6;
>> +	uint32_t tpr10;
>> +	uint32_t tpr11;
>> +	uint32_t tpr12;
>> +	uint32_t tpr13;
>> +	uint32_t tpr14;
> 
> para0 - para2 are not needed once auto size, width, rank and (in case 
> of
> DDR4) bank groups is implemented.
This is partially true; para1/para2/tpr13 do store DRAM organization
parameters, but para0 also stores a value that's written during
`phy_dx_delay_compensation`; it's most similar to `odt_en` on the H616.
I have further revisions of this code that implement DRAM detection and 
fix
some issues with DRAM detection, and those do away with 
para1/para2/tpr13.

> Mode registers, or MR for short, don't need to be parameterized. They 
> are
> constant for specific type of DRAM, except ones that are clock 
> dependent.
> Those are overriden in code anyway.
Not all are overridden in the case of DDR4; quite a few are provided by 
the
DRAM config. It's very possible these are similar across different 
devices,
but considering the relatively small number of DDR4 sunxi devices in
general, this seemed hard to say for sure.

> TPR13 is not needed. It holds bits which tell if detection of size, 
> rank
> and width is needed and similar things. Those are (or should be) done 
> anyway.
> 
>> +};
>> +
>> +void mctl_set_timing_params(const struct dram_para *para);
>> +
>> +struct dram_config {
>> +	u8 cols;		/* Column bits */
>> +	u8 rows;		/* Row bits */
>> +	u8 ranks;		/* Rank bits (different from H616!) */
>> +	u8 banks;		/* Bank bits */
>> +	u8 bankgrps;		/* Bank group bits */
>> +	u8 bus_full_width;	/* 1 = x32, 0 = x16 */
>> +};
>> +
>> +#endif /* _SUNXI_DRAM_SUN50I_A133_H */
>> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
>> index 78fd74f3f28..ccf0c9a403e 100644
>> --- a/arch/arm/mach-sunxi/Kconfig
>> +++ b/arch/arm/mach-sunxi/Kconfig
>> @@ -51,7 +51,13 @@ config DRAM_SUN50I_H616
>>  	  Select this dram controller driver for some sun50i platforms,
>>  	  like H616.
>> 
>> -if DRAM_SUN50I_H616
>> +config DRAM_SUN50I_A133
>> +	bool
>> +	help
>> +	  Select this dram controller driver for some sun50i platforms,
>> +	  like A133.
>> +
>> +if DRAM_SUN50I_H616 || DRAM_SUN50I_A133
>>  config DRAM_SUNXI_DX_ODT
>>  	hex "DRAM DX ODT parameter"
>>  	help
>> @@ -73,18 +79,144 @@ config DRAM_SUNXI_ODT_EN
>>  	help
>>  	  ODT EN value from vendor DRAM settings.
>> 
>> +config DRAM_SUNXI_PARA0
>> +	hex "DRAM PARA0 parameter"
>> +	depends on DRAM_SUN50I_A133
>> +	help
>> +	  PARA0 value from vendor DRAM settings.
>> +
>> +config DRAM_SUNXI_PARA1
>> +	hex "DRAM PARA1 parameter"
>> +	help
>> +	  PARA1 value from vendor DRAM settings.
>> +
>> +config DRAM_SUNXI_PARA2
>> +	hex "DRAM PARA2 parameter"
>> +	help
>> +	  PARA2 value from vendor DRAM settings.
>> +
>> +config DRAM_SUNXI_MR0
>> +	hex "DRAM MR0 parameter"
>> +	depends on DRAM_SUN50I_A133
>> +	default 0x0
>> +	help
>> +	  MR0 value from vendor DRAM settings.
>> +
>> +config DRAM_SUNXI_MR1
>> +	hex "DRAM MR1 parameter"
>> +	depends on DRAM_SUN50I_A133
>> +	default 0x0
>> +	help
>> +	  MR1 value from vendor DRAM settings.
>> +
>> +config DRAM_SUNXI_MR2
>> +	hex "DRAM MR2 parameter"
>> +	depends on DRAM_SUN50I_A133
>> +	default 0x0
>> +	help
>> +	  MR2 value from vendor DRAM settings.
>> +
>> +config DRAM_SUNXI_MR3
>> +	hex "DRAM MR3 parameter"
>> +	depends on DRAM_SUN50I_A133
>> +	default 0x0
>> +	help
>> +	  MR3 value from vendor DRAM settings.
>> +
>> +config DRAM_SUNXI_MR4
>> +	hex "DRAM MR4 parameter"
>> +	depends on DRAM_SUN50I_A133
>> +	default 0x0
>> +	help
>> +	  MR4 value from vendor DRAM settings.
>> +
>> +config DRAM_SUNXI_MR5
>> +	hex "DRAM MR5 parameter"
>> +	depends on DRAM_SUN50I_A133
>> +	default 0x0
>> +	help
>> +	  MR5 value from vendor DRAM settings.
>> +
>> +config DRAM_SUNXI_MR6
>> +	hex "DRAM MR6 parameter"
>> +	depends on DRAM_SUN50I_A133
>> +	default 0x0
>> +	help
>> +	  MR6 value from vendor DRAM settings.
>> +
>> +config DRAM_SUNXI_MR11
>> +	hex "DRAM MR11 parameter"
>> +	depends on DRAM_SUN50I_A133
>> +	default 0x0
>> +	help
>> +	  MR11 value from vendor DRAM settings.
>> +
>> +config DRAM_SUNXI_MR12
>> +	hex "DRAM MR12 parameter"
>> +	depends on DRAM_SUN50I_A133
>> +	default 0x0
>> +	help
>> +	  MR12 value from vendor DRAM settings.
>> +
>> +config DRAM_SUNXI_MR13
>> +	hex "DRAM MR13 parameter"
>> +	depends on DRAM_SUN50I_A133
>> +	default 0x0
>> +	help
>> +	  MR13 value from vendor DRAM settings.
>> +
>> +config DRAM_SUNXI_MR14
>> +	hex "DRAM MR14 parameter"
>> +	depends on DRAM_SUN50I_A133
>> +	default 0x0
>> +	help
>> +	  MR14 value from vendor DRAM settings.
>> +
>> +config DRAM_SUNXI_MR16
>> +	hex "DRAM MR16 parameter"
>> +	depends on DRAM_SUN50I_A133
>> +	default 0x0
>> +	help
>> +	  MR16 value from vendor DRAM settings.
>> +
>> +config DRAM_SUNXI_MR17
>> +	hex "DRAM MR17 parameter"
>> +	depends on DRAM_SUN50I_A133
>> +	default 0x0
>> +	help
>> +	  MR17 value from vendor DRAM settings.
>> +
>> +config DRAM_SUNXI_MR22
>> +	hex "DRAM MR22 parameter"
>> +	depends on !DRAM_SUN50I_A133
> 
> I guess exclamation point is a mistake here, but this config shouldn't
> be needed (see above.)
Good catch.
>> +	default 0x0
>> +	help
>> +	  MR22 value from vendor DRAM settings.
>> +
>>  config DRAM_SUNXI_TPR0
>>  	hex "DRAM TPR0 parameter"
>>  	default 0x0
>>  	help
>>  	  TPR0 value from vendor DRAM settings.
>> 
>> +config DRAM_SUNXI_TPR1
>> +	hex "DRAM TPR1 parameter"
>> +	default 0x0
>> +	help
>> +	  TPR1 value from vendor DRAM settings.
>> +
>>  config DRAM_SUNXI_TPR2
>>  	hex "DRAM TPR2 parameter"
>>  	default 0x0
>>  	help
>>  	  TPR2 value from vendor DRAM settings.
>> 
>> +config DRAM_SUNXI_TPR3
>> +	hex "DRAM TPR3 parameter"
>> +	default 0x0
>> +	help
>> +	  TPR3 value from vendor DRAM settings.
>> +
>>  config DRAM_SUNXI_TPR6
>>  	hex "DRAM TPR6 parameter"
>>  	default 0x3300c080
>> @@ -109,6 +241,20 @@ config DRAM_SUNXI_TPR12
>>  	help
>>  	  TPR12 value from vendor DRAM settings.
>> 
>> +config DRAM_SUNXI_TPR13
>> +	hex "DRAM TPR13 parameter"
>> +	depends on DRAM_SUN50I_A133
>> +	default 0x0
>> +	help
>> +	  TPR13 value from vendor DRAM settings.
>> +
>> +config DRAM_SUNXI_TPR14
>> +	hex "DRAM TPR14 parameter"
>> +	depends on DRAM_SUN50I_A133
>> +	default 0x0
>> +	help
>> +	  TPR14 value from vendor DRAM settings.
>> +
> 
> Most of new configs are not needed, as discussed above.
> 
>>  choice
>>  	prompt "DRAM PHY pin mapping selection"
>>  	default DRAM_SUNXI_PHY_ADDR_MAP_0
>> @@ -116,7 +262,8 @@ choice
>>  config DRAM_SUNXI_PHY_ADDR_MAP_0
>>  	bool "DRAM PHY address map 0"
>>  	help
>> -	  This pin mapping selection should be used by the H313, H616, H618.
>> +	  This pin mapping selection should be used by the H313, H616, H618,
>> +	  and A133, R818 SoCs.
>> 
>>  config DRAM_SUNXI_PHY_ADDR_MAP_1
>>  	bool "DRAM PHY address map 1"
>> @@ -497,7 +644,7 @@ config ARM_BOOT_HOOK_RMR
>>  	This allows both the SPL and the U-Boot proper to be entered in
>>  	either mode and switch to AArch64 if needed.
>> 
>> -if SUNXI_DRAM_DW || DRAM_SUN50I_H6 || DRAM_SUN50I_H616
>> +if SUNXI_DRAM_DW || DRAM_SUN50I_H6 || DRAM_SUN50I_H616 || 
>> DRAM_SUN50I_A133
>>  config SUNXI_DRAM_DDR3
>>  	bool
>> 
>> @@ -510,6 +657,9 @@ config SUNXI_DRAM_LPDDR3
>>  config SUNXI_DRAM_LPDDR4
>>  	bool
>> 
>> +config SUNXI_DRAM_DDR4
>> +	bool
>> +
>>  choice
>>  	prompt "DRAM Type and Timing"
>>  	default SUNXI_DRAM_DDR3_1333 if !MACH_SUN8I_V3S
>> @@ -518,6 +668,7 @@ choice
>>  config SUNXI_DRAM_DDR3_1333
>>  	bool "DDR3 1333"
>>  	select SUNXI_DRAM_DDR3
>> +	depends on !DRAM_SUN50I_A133
>>  	---help---
>>  	This option is the original only supported memory type, which suits
>>  	many H3/H5/A64 boards available now.
>> @@ -525,6 +676,7 @@ config SUNXI_DRAM_DDR3_1333
>>  config SUNXI_DRAM_LPDDR3_STOCK
>>  	bool "LPDDR3 with Allwinner stock configuration"
>>  	select SUNXI_DRAM_LPDDR3
>> +	depends on !DRAM_SUN50I_A133
>>  	---help---
>>  	This option is the LPDDR3 timing used by the stock boot0 by
>>  	Allwinner.
>> @@ -548,7 +700,7 @@ config SUNXI_DRAM_H6_DDR3_1333
>>  config SUNXI_DRAM_H616_LPDDR3
>>  	bool "LPDDR3 DRAM chips on the H616 DRAM controller"
>>  	select SUNXI_DRAM_LPDDR3
>> -	depends on DRAM_SUN50I_H616
>> +	depends on DRAM_SUN50I_H616 || DRAM_SUN50I_A133
>>  	help
>>  	  This option is the LPDDR3 timing used by the stock boot0 by
>>  	  Allwinner.
>> @@ -556,7 +708,7 @@ config SUNXI_DRAM_H616_LPDDR3
>>  config SUNXI_DRAM_H616_LPDDR4
>>  	bool "LPDDR4 DRAM chips on the H616 DRAM controller"
>>  	select SUNXI_DRAM_LPDDR4
>> -	depends on DRAM_SUN50I_H616
>> +	depends on DRAM_SUN50I_H616 || DRAM_SUN50I_A133
>>  	help
>>  	  This option is the LPDDR4 timing used by the stock boot0 by
>>  	  Allwinner.
>> @@ -564,11 +716,27 @@ config SUNXI_DRAM_H616_LPDDR4
>>  config SUNXI_DRAM_H616_DDR3_1333
>>  	bool "DDR3-1333 boot0 timings on the H616 DRAM controller"
>>  	select SUNXI_DRAM_DDR3
>> -	depends on DRAM_SUN50I_H616
>> +	depends on DRAM_SUN50I_H616 || DRAM_SUN50I_A133
>>  	help
>>  	  This option is the DDR3 timing used by the boot0 on H616 TV boxes
>>  	  which use a DDR3-1333 timing.
>> 
>> +config SUNXI_DRAM_A133_DDR4
>> +	bool "DDR4 boot0 timings on the A133 DRAM controller"
>> +	select SUNXI_DRAM_DDR4
>> +	depends on DRAM_SUN50I_A133
>> +	help
>> +	  This option is the DDR4 timing used by the boot0 on A133 devices
>> +	  which use a DDR4 timing.
>> +
>> +config SUNXI_DRAM_A133_LPDDR4
>> +	bool "LPDDR4 boot0 timings on the A133 DRAM controller"
>> +	select SUNXI_DRAM_LPDDR4
>> +	depends on DRAM_SUN50I_A133
>> +	help
>> +	  This option is the LPDDR4 timing used by the boot0 on A133 devices
>> +	  which use an LPDDR4 timing.
>> +
>>  config SUNXI_DRAM_DDR2_V3S
>>  	bool "DDR2 found in V3s chip"
>>  	select SUNXI_DRAM_DDR2
>> @@ -596,7 +764,7 @@ config DRAM_CLK
>>  		       MACH_SUN8I_V3S
>>  	default 672 if MACH_SUN50I
>>  	default 744 if MACH_SUN50I_H6
>> -	default 720 if MACH_SUN50I_H616
>> +	default 720 if MACH_SUN50I_H616 || MACH_SUN50I_A133
>>  	---help---
>>  	Set the dram clock speed, valid range 240 - 480 (prior to sun9i),
>>  	must be a multiple of 24. For the sun9i (A80), the tested values
>> @@ -613,7 +781,7 @@ endif
>> 
>>  config DRAM_ZQ
>>  	int "sunxi dram zq value"
>> -	depends on !MACH_SUN50I_H616
>> +	depends on !MACH_SUN50I_H616 && !MACH_SUN50I_A133
>>  	default 123 if MACH_SUN4I || MACH_SUN5I || MACH_SUN6I || \
>>  		       MACH_SUN8I_A23 || MACH_SUN8I_A33 || MACH_SUN8I_A83T
>>  	default 127 if MACH_SUN7I
>> diff --git a/arch/arm/mach-sunxi/Makefile 
>> b/arch/arm/mach-sunxi/Makefile
>> index eb6a49119a1..9b38f1d8663 100644
>> --- a/arch/arm/mach-sunxi/Makefile
>> +++ b/arch/arm/mach-sunxi/Makefile
>> @@ -45,4 +45,6 @@ obj-$(CONFIG_DRAM_SUN50I_H6)	+= dram_sun50i_h6.o
>>  obj-$(CONFIG_DRAM_SUN50I_H6)	+= dram_timings/
>>  obj-$(CONFIG_DRAM_SUN50I_H616)	+= dram_sun50i_h616.o
>>  obj-$(CONFIG_DRAM_SUN50I_H616)	+= dram_timings/
>> +obj-$(CONFIG_DRAM_SUN50I_A133)	+= dram_sun50i_a133.o
>> +obj-$(CONFIG_DRAM_SUN50I_A133)	+= dram_timings/
>>  endif
>> diff --git a/arch/arm/mach-sunxi/dram_sun50i_a133.c 
>> b/arch/arm/mach-sunxi/dram_sun50i_a133.c
>> new file mode 100644
>> index 00000000000..1221244cbb6
>> --- /dev/null
>> +++ b/arch/arm/mach-sunxi/dram_sun50i_a133.c
>> @@ -0,0 +1,1217 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * sun50i A133 platform dram controller driver
>> + *
>> + * Controller and PHY appear to be quite similar to that of the H616;
>> + * however certain offsets, timings, and other details are different 
>> enough that
>> + * the original code does not work as expected. Some device flags and 
>> calibrations
>> + * are not yet implemented, and configuration aside from DDR4 have 
>> not been tested.
>> + *
>> + * (C) Copyright 2024 MasterR3C0RD <masterr3c0rd@epochal.quest>
>> + *
>> + * Uses code from H616 driver, which is
>> + * (C) Copyright 2020 Jernej Skrabec <jernej.skrabec@siol.net>
>> + *
>> + */
>> +
>> +#define DEBUG
> 
> This should go away in final version.
Will not be present in final versions.
>> +
>> +#include <asm/arch/clock.h>
>> +#include <asm/arch/cpu.h>
>> +#include <asm/arch/dram.h>
>> +#include <asm/arch/prcm.h>
>> +#include <asm/io.h>
>> +#include <init.h>
>> +#include <linux/bitops.h>
>> +#include <linux/delay.h>
>> +#include <log.h>
>> +
*snip*
>> +/* Heavily inspired from H616 driver. UNUSED */
>> +/* static */ void auto_detect_ranks(const struct dram_para *para,
>> +				    struct dram_config *config)
>> +{
>> +	int i;
>> +	bool found_config;
>> +
>> +	config->cols = 9;
>> +	config->rows = 14;
>> +	config->ranks = 0;
>> +	config->banks = 0;
>> +	config->bankgrps = 0;
>> +
>> +	/* Test ranks */
>> +	found_config = false;
>> +	for (i = 1; i >= 0; i--) {
>> +		config->ranks = i;
>> +		config->bus_full_width = true;
>> +		debug("Testing ranks = %d, 32-bit bus\n", i);
>> +		if (mctl_core_init(para, config)) {
>> +			found_config = true;
>> +			break;
>> +		}
>> +
>> +		config->bus_full_width = false;
>> +		debug("Testing ranks = %d, 16-bit bus\n", i);
>> +		if (mctl_core_init(para, config)) {
>> +			found_config = true;
>> +			break;
>> +		}
>> +	}
>> +
>> +	debug("Found ranks = %d\n", config->ranks);
>> +}
>> +
>> +/* UNUSED? */
> 
> Needless to say, instead of relying on hardcoded values, it's better to 
> use
> autodetection in order to cover multiple version of same board with 
> different
> DRAM sizes.
I have some working auto scan code that I hope to submit in the future; 
these
were unused when this patch was pulled into Andre's patch series due to 
it
not functioning as expected.

A newer, rewritten driver is available at [1], though I still need to 
find some
time to clean it up and properly submit it as I had to make some silly 
patches
to fix edge cases on systems with the full 4GiB of RAM.

Thanks for your comments!
- Cody

[1] 
https://github.com/BrokenR3C0RD/u-boot/blob/allwinner-a133/arch/arm/mach-sunxi/dram_sun50i_a133.c
> Best regards,
> Jernej
> 
