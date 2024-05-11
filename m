Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512CDC04FFE
	for <u-boot@archiver.kernel.org>; Sat, 11 May 2024 12:46:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44DEB882CB;
	Sat, 11 May 2024 14:46:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=testtoast.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=testtoast.com header.i=@testtoast.com header.b="oqo6ucQB";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="OvH6I4pG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9853877AF; Sat, 11 May 2024 12:05:23 +0200 (CEST)
Received: from wfhigh8-smtp.messagingengine.com
 (wfhigh8-smtp.messagingengine.com [64.147.123.159])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF6F587617
 for <u-boot@lists.denx.de>; Sat, 11 May 2024 12:05:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=testtoast.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ryan@testtoast.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfhigh.west.internal (Postfix) with ESMTP id 16B8C18000AB;
 Sat, 11 May 2024 06:05:17 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
 by compute5.internal (MEProxy); Sat, 11 May 2024 06:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=testtoast.com;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1715421916; x=
 1715508316; bh=1sUAOsupSl+06+ETwTDSXhyjJ9nUXT4TuDagN4GDRSQ=; b=o
 qo6ucQBXX4SEqZOzvMHON4cfMn2rik4BxqTjFMEdTOr+kHAie6ilYMHYFL9I1udZ
 Yx/l+btH9dWeLHXxvbB4xKwj8q1AuGCSuqfcdA9WLk1Tkfsx0ff1jIiM2ZWccezx
 4l/hQvujWM3YQtKoMNavHVlLilVWYOTK84sfqGznfCPOERf59VG/fO+p4/PpyU1w
 PEGo+O5GJvvDnOLHRcZOB5J+dD5QTLyWrc7zI8v7pA3k8QlAU2zy1mAdEFordHT+
 +VLCm1xN5Ixk85nSXZkE0V3h+jBvIVVY84c1RGY7zEMmFTj+schDMz8K02Xp3nkB
 VC/G2toIdXvpDEa0x7oFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1715421916; x=1715508316; bh=1sUAOsupSl+06+ETwTDSXhyjJ9nU
 XT4TuDagN4GDRSQ=; b=OvH6I4pGQy4CH1S65NtTi0g5QuO4WEN6wzHHnFuTxU+1
 z7ZnhNB8PTN0X/Db7yfHcdTVJJGLq9rPnNfJ0FJmOccMPAFXv43ofWUvaKEQcMV9
 hSpOzBOG0FTITC2l8dy5Kf/NcjAAWwL0K+xIlfhC4wcw7rWDW9mk0JEGUpnbJwk8
 jnvcD+bawL0cRcHLfvA1a/tQZs2QCIIqykF2loAr0XqLdM7iG0EwNPzBzxjUoj6D
 XrDyRukdhSBa68kwEwZhdyIxE/IsD36/6iRV4CB4vJRbqSQ63GtLQLq9GpyVPdhm
 5JfPN+Y/wv0xBqj+uLt81rSt44IPh7ixGURGttOkBQ==
X-ME-Sender: <xms:20I_ZluIy1UEEtdIgQaiPsMx_9mpflGOi5l0QW99aOTbJwE2RBx3JA>
 <xme:20I_ZufsBEp47g57hqJ38U0y_v-lcB6wAomHzse5saFb3S9MpyKUblq7i0N-VapsU
 Wog4y-rBoMyu9f4mg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegtddgvdegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftfih
 rghnucghrghlkhhlihhnfdcuoehrhigrnhesthgvshhtthhorghsthdrtghomheqnecugg
 ftrfgrthhtvghrnhephedvveeigedujeeufeegffehhfffveduhfeijefgtdffteelgfet
 ueevieduieejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homheprhihrghnsehtvghsthhtohgrshhtrdgtohhm
X-ME-Proxy: <xmx:20I_ZozARJ9LeWI6ZHOOV50CeGfM2ADqlUNh8N2-h3YqYBh0O1Prng>
 <xmx:20I_ZsMvN8MFGnIfkaM8n-eLn2nCRZ4U0SDGtlQX7h1mEo8dChqZHw>
 <xmx:20I_Zl9McBE6uQy-hMzeARy9uDiR0u6q7UjYP4jK4Tofd6TM1DA6Dw>
 <xmx:20I_ZsV66JvRfnqO9TKtgl8LnKJ7dKAIadvhHMjFU7WQKP0TL9WNvQ>
 <xmx:3EI_ZuN-L8BqQhBpIkbh0sOh6eHNFehivm-w11MZ6tHozzRGZLqsWlZw>
Feedback-ID: idc0145fc:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id CF833A60078; Sat, 11 May 2024 06:05:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-443-g0dc955c2a-fm-20240507.001-g0dc955c2
MIME-Version: 1.0
Message-Id: <6bc35c1c-e0b9-469a-ad46-0a694252d47a@app.fastmail.com>
In-Reply-To: <20240509234319.13104-2-andre.przywara@arm.com>
References: <20240509234319.13104-1-andre.przywara@arm.com>
 <20240509234319.13104-2-andre.przywara@arm.com>
Date: Sat, 11 May 2024 22:04:55 +1200
From: "Ryan Walklin" <ryan@testtoast.com>
To: "Andre Przywara" <andre.przywara@arm.com>,
 "Jaehoon Chung" <jh80.chung@samsung.com>,
 "Jagan Teki" <jagan@amarulasolutions.com>
Cc: "Jernej Skrabec" <jernej.skrabec@gmail.com>,
 "Chris Morgan" <macromorgan@hotmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev, "Tom Rini" <trini@konsulko.com>
Subject: Re: [PATCH 1/2] power: pmic: sunxi: add AXP717 SPL driver
Content-Type: text/plain
X-Mailman-Approved-At: Sat, 11 May 2024 14:46:24 +0200
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

On Fri, 10 May 2024, at 11:43 AM, Andre Przywara wrote:
> On boards using the AXP717 PMIC, the DRAM rail is often not setup
> correctly at reset time, so we have to program the PMIC very early in
> the SPL, before running the DRAM initialisation.
>
> Add a simple AXP717 PMIC driver that knows about the buck converters, so
> that we can set the voltage for the DRAM chips and the CPU cores.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm/mach-sunxi/pmic_bus.c |  3 ++
>  board/sunxi/board.c            |  2 +-
>  drivers/power/Kconfig          | 17 +++++--
>  drivers/power/Makefile         |  1 +
>  drivers/power/axp717.c         | 92 ++++++++++++++++++++++++++++++++++
>  5 files changed, 110 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/power/axp717.c
>
> diff --git a/arch/arm/mach-sunxi/pmic_bus.c b/arch/arm/mach-sunxi/pmic_bus.c
> index 87df312725c..8e19324c8ac 100644
> --- a/arch/arm/mach-sunxi/pmic_bus.c
> +++ b/arch/arm/mach-sunxi/pmic_bus.c
> @@ -19,6 +19,7 @@
>  #define AXP152_I2C_ADDR			0x30
> 
>  #define AXP209_I2C_ADDR			0x34
> +#define AXP717_I2C_ADDR			0x34
> 
>  #define AXP305_I2C_ADDR			0x36
>  #define AXP313_I2C_ADDR			0x36
> @@ -36,6 +37,8 @@ static int pmic_i2c_address(void)
>  		return AXP305_I2C_ADDR;
>  	if (IS_ENABLED(CONFIG_AXP313_POWER))
>  		return AXP313_I2C_ADDR;
> +	if (IS_ENABLED(CONFIG_AXP717_POWER))
> +		return AXP717_I2C_ADDR;
> 
>  	/* Other AXP2xx and AXP8xx variants */
>  	return AXP209_I2C_ADDR;
> diff --git a/board/sunxi/board.c b/board/sunxi/board.c
> index 1313b01dcea..2c65f4c93cb 100644
> --- a/board/sunxi/board.c
> +++ b/board/sunxi/board.c
> @@ -563,7 +563,7 @@ void sunxi_board_init(void)
>  #if defined CONFIG_AXP152_POWER || defined CONFIG_AXP209_POWER || \
>  	defined CONFIG_AXP221_POWER || defined CONFIG_AXP305_POWER || \
>  	defined CONFIG_AXP809_POWER || defined CONFIG_AXP818_POWER || \
> -	defined CONFIG_AXP313_POWER
> +	defined CONFIG_AXP313_POWER || defined CONFIG_AXP717_POWER
>  	power_failed = axp_init();
> 
>  	if (IS_ENABLED(CONFIG_AXP_DISABLE_BOOT_ON_POWERON) && !power_failed) {
> diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
> index 33b8bc1214d..5556a22cf69 100644
> --- a/drivers/power/Kconfig
> +++ b/drivers/power/Kconfig
> @@ -109,6 +109,13 @@ config AXP313_POWER
>  	Select this to enable support for the AXP313 PMIC found on some
>  	H616 boards.
> 
> +config AXP717_POWER
> +	bool "axp717 pmic support"
> +	select AXP_PMIC_BUS
> +	select CMD_POWEROFF
> +	---help---
> +	Select this to enable support for the AXP717 PMIC found on some boards.
> +
>  config AXP809_POWER
>  	bool "axp809 pmic support"
>  	depends on MACH_SUN9I
> @@ -151,10 +158,11 @@ config AXP_DCDC1_VOLT
> 
>  config AXP_DCDC2_VOLT
>  	int "axp pmic dcdc2 voltage"
> -	depends on AXP152_POWER || AXP209_POWER || AXP221_POWER || 
> AXP809_POWER || AXP818_POWER || AXP313_POWER
> +	depends on AXP152_POWER || AXP209_POWER || AXP221_POWER || 
> AXP809_POWER || AXP818_POWER || AXP313_POWER || AXP717_POWER
>  	default 900 if AXP818_POWER
>  	default 1400 if AXP152_POWER || AXP209_POWER
>  	default 1000 if AXP313_POWER
> +	default 1000 if AXP717_POWER
>  	default 1200 if MACH_SUN6I
>  	default 1100 if MACH_SUN8I
>  	default 0 if MACH_SUN9I
> @@ -167,11 +175,11 @@ config AXP_DCDC2_VOLT
>  	On A80 boards dcdc2 powers the GPU and can be left off.
>  	On A83T boards dcdc2 is used for VDD-CPUA(cluster 0) and should be 
> 0.9V.
>  	On R40 boards dcdc2 is VDD-CPU and should be 1.1V
> -	On boards using the AXP313 it's often VDD-CPU.
> +	On boards using the AXP313 or AXP717 it's often VDD-CPU.
> 
>  config AXP_DCDC3_VOLT
>  	int "axp pmic dcdc3 voltage"
> -	depends on AXP152_POWER || AXP209_POWER || AXP221_POWER || 
> AXP809_POWER || AXP818_POWER || AXP313_POWER
> +	depends on AXP152_POWER || AXP209_POWER || AXP221_POWER || 
> AXP809_POWER || AXP818_POWER || AXP313_POWER || AXP717_POWER
>  	default 900 if AXP809_POWER || AXP818_POWER
>  	default 1500 if AXP152_POWER
>  	default 1250 if AXP209_POWER
> @@ -188,7 +196,8 @@ config AXP_DCDC3_VOLT
>  	On A80 boards dcdc3 is used for VDD-CPUA(cluster 0) and should be 
> 0.9V.
>  	On A83T boards dcdc3 is used for VDD-CPUB(cluster 1) and should be 
> 0.9V.
>  	On R40 boards dcdc3 is VDD-SYS and VDD-GPU and should be 1.1V.
> -	On boards using the AXP313 it's often VDD-DRAM and should be 1.1V for 
> LPDDR4.
> +	On boards using the AXP313 or AXP717 it's often VDD-DRAM and should
> +	be 1.1V for LPDDR4.
> 
>  config AXP_DCDC4_VOLT
>  	int "axp pmic dcdc4 voltage"
> diff --git a/drivers/power/Makefile b/drivers/power/Makefile
> index c7ee4595fc8..41ebb494fff 100644
> --- a/drivers/power/Makefile
> +++ b/drivers/power/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_AXP209_POWER)	+= axp209.o
>  obj-$(CONFIG_AXP221_POWER)	+= axp221.o
>  obj-$(CONFIG_AXP305_POWER)	+= axp305.o
>  obj-$(CONFIG_AXP313_POWER)	+= axp313.o
> +obj-$(CONFIG_AXP717_POWER)	+= axp717.o
>  obj-$(CONFIG_AXP809_POWER)	+= axp809.o
>  obj-$(CONFIG_AXP818_POWER)	+= axp818.o
>  obj-$(CONFIG_EXYNOS_TMU)	+= exynos-tmu.o
> diff --git a/drivers/power/axp717.c b/drivers/power/axp717.c
> new file mode 100644
> index 00000000000..7c77c09ea8f
> --- /dev/null
> +++ b/drivers/power/axp717.c
> @@ -0,0 +1,92 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * AXP717 SPL driver
> + * (C) Copyright 2024 Arm Ltd.
> + */
> +
> +#include <common.h>
> +#include <command.h>
> +#include <errno.h>
> +#include <asm/arch/pmic_bus.h>
> +#include <axp_pmic.h>
> +
> +enum axp717_reg {
> +	AXP717_CHIP_VERSION = 0x3,
> +	AXP717_SHUTDOWN = 0x27,
> +	AXP717_OUTPUT_CTRL1 = 0x80,
> +	AXP717_DCDC1_VOLTAGE = 0x83,
> +};
> +
> +#define AXP717_CHIP_VERSION_MASK	0xc8
> +#define AXP717_DCDC_1220MV_OFFSET	71
> +#define AXP717_POWEROFF			(1U << 0)
> +#define DCDC_DVM_ENABLE			(1U << 7)
> +
> +static u8 axp_mvolt_to_cfg(int mvolt, int min, int max, int div)
> +{
> +	if (mvolt < min)
> +		mvolt = min;
> +	else if (mvolt > max)
> +		mvolt = max;
> +
> +	return (mvolt - min) / div;
> +}
> +
> +static int axp_set_dcdc(int dcdc_num, unsigned int mvolt)
> +{
> +	int ret;
> +	u8 cfg = DCDC_DVM_ENABLE;
> +
> +	if (dcdc_num < 1 || dcdc_num > 3)
> +		return -EINVAL;
> +
> +	if (mvolt >= 1220)
> +		cfg |= AXP717_DCDC_1220MV_OFFSET +
> +			axp_mvolt_to_cfg(mvolt, 1220,
> +					 dcdc_num == 3 ? 1840 : 1540, 20);
> +	else
> +		cfg |= axp_mvolt_to_cfg(mvolt, 500, 1200, 10);
> +
> +	if (mvolt == 0)
> +		return pmic_bus_clrbits(AXP717_OUTPUT_CTRL1,
> +					1U << (dcdc_num -1));
> +
> +	ret = pmic_bus_write(AXP717_DCDC1_VOLTAGE + dcdc_num - 1, cfg);
> +	if (ret)
> +		return ret;
> +
> +	return pmic_bus_setbits(AXP717_OUTPUT_CTRL1, 1U << (dcdc_num - 1));
> +}
> +
> +int axp_set_dcdc1(unsigned int mvolt)
> +{
> +	return axp_set_dcdc(1, mvolt);
> +}
> +
> +int axp_set_dcdc2(unsigned int mvolt)
> +{
> +	return axp_set_dcdc(2, mvolt);
> +}
> +
> +int axp_set_dcdc3(unsigned int mvolt)
> +{
> +	return axp_set_dcdc(3, mvolt);
> +}
> +
> +int axp_init(void)
> +{
> +	return pmic_bus_init();
> +}
> +
> +#if !CONFIG_IS_ENABLED(ARM_PSCI_FW) && 
> !IS_ENABLED(CONFIG_SYSRESET_CMD_POWEROFF)
> +int do_poweroff(struct cmd_tbl *cmdtp, int flag, int argc, char *const 
> argv[])
> +{
> +	pmic_bus_setbits(AXP717_SHUTDOWN, AXP717_POWEROFF);
> +
> +	/* infinite loop during shutdown */
> +	while (1) {}
> +
> +	/* not reached */
> +	return 0;
> +}
> +#endif
> -- 
> 2.35.8

Confirmed working on H700 board with AXP717 PMIC and LPDDR4 DRAM controller (Anbernic RG35XX-H) and verified I2C address and registers from datasheet.

Reviewed-by: Ryan Walklin <ryan@testtoast.com>

Regards,

Ryan
