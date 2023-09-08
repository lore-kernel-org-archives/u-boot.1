Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27EC8EE57E0
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 09:24:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFDEB86580;
	Fri,  8 Sep 2023 11:24:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B743865D0; Fri,  8 Sep 2023 11:24:16 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 6BD428647E
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 11:24:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62D1ED75;
 Fri,  8 Sep 2023 02:24:50 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6ED53F64C;
 Fri,  8 Sep 2023 02:24:11 -0700 (PDT)
Date: Fri, 8 Sep 2023 10:24:04 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: SASANO Takayoshi <uaa@mx5.nisiq.net>, "linux-sunxi@lists.linux.dev"
 <linux-sunxi@lists.linux.dev>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH RESEND] sunxi: add axp313a support
Message-ID: <20230908102404.3f386a43@donnerap.manchester.arm.com>
In-Reply-To: <875y4u9b3t.wl-uaa@mx5.nisiq.net>
References: <875y4u9b3t.wl-uaa@mx5.nisiq.net>
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

On Fri, 01 Sep 2023 06:05:10 +0900
SASANO Takayoshi <uaa@mx5.nisiq.net> wrote:

Hi Takayoshi,

thanks for sending this patch to the list, and for sticking to it!

> There is no response from previous post, I think this patch is not reached to
> suitable person and not reviewed yet.

Running scripts/get_maintainer.pl on your patch file helps to get a list of
people that would take care of your patch - and get quicker responses ;-)

> axp313a code is a part of power/sunxi. This is needed for Mango Pi MQ-Quad
> and Orange Pi Zero3.

So superficially this looks alright, and I had some similar, though
more minimal version hacked up somewhere for my OPi Zero3 experiments.
However you might have realised that this is a complete mess, especially
the part with the #if selection of which regulator to program, depending
on the AXP PMIC selected (in board.c).

So I started some experiments on how to improve the situation, starting
with cleaning up the sunxi_board_init() function, so it becomes easier to
follow what happens there and to extend.
I am thinking we don't need to program all the regulators at this point
(SPL), all we need is probably the DRAM and maybe the CPU rail. Every
other regulator needed can be programmed on demand, via the DT in U-Boot
proper. Which brings me to the next point: You might have noticed
that we have a proper UCLASS_REGULATOR driver, in
drivers/power/regulator/axp_regulator.c. Given the nature of the AXP313a
(with most rails always-on) this might not be needed anytime soon, but you
could make a patch to support the AXP313a in there. I am playing with the
idea of somehow re-using the data structures in there for the SPL driver
as well, so we need that anyway.

Anyway, my plan is to not add anything to the SPL code in its current
shape anymore, instead do some refactoring first, then have a much cleaner
and smaller patch with the AXP313a support. I am more than halfway through
with that, just stuck on some nasty preprocessor problem. I will post
something once that's ready, and will then CC: you, so you can add the
AXP313 parts on top, if you like.

Thanks!
Andre

> From 9127de42691f86ef5ed22dcf5fa0b44b03288a07 Mon Sep 17 00:00:00 2001
> From: SASANO Takayoshi <uaa@uaa.org.uk>
> Date: Thu, 13 Jul 2023 20:41:40 +0900
> Subject: [PATCH] add axp313a support
> 
> Signed-off-by: SASANO Takayoshi <uaa@uaa.org.uk>
> ---
> 
>  arch/arm/mach-sunxi/pmic_bus.c |   4 +-
>  board/sunxi/board.c            |   9 +-
>  drivers/power/Kconfig          |  16 ++-
>  drivers/power/Makefile         |   1 +
>  drivers/power/axp313a.c        | 171 +++++++++++++++++++++++++++++++++
>  drivers/power/pmic/axp.c       |   1 +
>  include/axp313a.h              |  31 ++++++
>  include/axp_pmic.h             |   2 +
>  8 files changed, 226 insertions(+), 9 deletions(-)
>  create mode 100644 drivers/power/axp313a.c
>  create mode 100644 include/axp313a.h
> 
> diff --git a/arch/arm/mach-sunxi/pmic_bus.c b/arch/arm/mach-sunxi/pmic_bus.c
> index c090840637..3e7bb5a5d1 100644
> --- a/arch/arm/mach-sunxi/pmic_bus.c
> +++ b/arch/arm/mach-sunxi/pmic_bus.c
> @@ -21,7 +21,7 @@
>  
>  #define AXP209_I2C_ADDR			0x34
>  
> -#define AXP305_I2C_ADDR			0x36
> +#define AXP305_I2C_ADDR			0x36 /* AXP305 and AXP313A */
>  
>  #define AXP221_CHIP_ADDR		0x68
>  
> @@ -32,7 +32,7 @@ static int pmic_i2c_address(void)
>  {
>  	if (IS_ENABLED(CONFIG_AXP152_POWER))
>  		return AXP152_I2C_ADDR;
> -	if (IS_ENABLED(CONFIG_AXP305_POWER))
> +	if (IS_ENABLED(CONFIG_AXP305_POWER) || IS_ENABLED(CONFIG_AXP313A_POWER))
>  		return AXP305_I2C_ADDR;
>  
>  	/* Other AXP2xx and AXP8xx variants */
> diff --git a/board/sunxi/board.c b/board/sunxi/board.c
> index f321cd58a6..9b0069cd52 100644
> --- a/board/sunxi/board.c
> +++ b/board/sunxi/board.c
> @@ -584,6 +584,7 @@ void sunxi_board_init(void)
>  
>  #if defined CONFIG_AXP152_POWER || defined CONFIG_AXP209_POWER || \
>  	defined CONFIG_AXP221_POWER || defined CONFIG_AXP305_POWER || \
> +	defined CONFIG_AXP313A_POWER || \
>  	defined CONFIG_AXP809_POWER || defined CONFIG_AXP818_POWER
>  	power_failed = axp_init();
>  
> @@ -605,7 +606,8 @@ void sunxi_board_init(void)
>  	power_failed |= axp_set_dcdc2(CONFIG_AXP_DCDC2_VOLT);
>  	power_failed |= axp_set_dcdc3(CONFIG_AXP_DCDC3_VOLT);
>  #endif
> -#if !defined(CONFIG_AXP209_POWER) && !defined(CONFIG_AXP818_POWER)
> +#if !defined(CONFIG_AXP209_POWER) && !defined(CONFIG_AXP818_POWER) && \
> +	!defined(CONFIG_AXP313A_POWER)
>  	power_failed |= axp_set_dcdc4(CONFIG_AXP_DCDC4_VOLT);
>  #endif
>  #if defined CONFIG_AXP221_POWER || defined CONFIG_AXP809_POWER || \
> @@ -617,10 +619,11 @@ void sunxi_board_init(void)
>  	defined CONFIG_AXP818_POWER
>  	power_failed |= axp_set_aldo1(CONFIG_AXP_ALDO1_VOLT);
>  #endif
> -#if !defined(CONFIG_AXP305_POWER)
> +#if !defined(CONFIG_AXP305_POWER) && !defined(CONFIG_AXP313A_POWER)
>  	power_failed |= axp_set_aldo2(CONFIG_AXP_ALDO2_VOLT);
>  #endif
> -#if !defined(CONFIG_AXP152_POWER) && !defined(CONFIG_AXP305_POWER)
> +#if !defined(CONFIG_AXP152_POWER) && !defined(CONFIG_AXP305_POWER) && \
> +	!defined(CONFIG_AXP313A_POWER)
>  	power_failed |= axp_set_aldo3(CONFIG_AXP_ALDO3_VOLT);
>  #endif
>  #ifdef CONFIG_AXP209_POWER
> diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
> index 7f3b990d23..12189eec9f 100644
> --- a/drivers/power/Kconfig
> +++ b/drivers/power/Kconfig
> @@ -101,6 +101,14 @@ config AXP305_POWER
>  	Select this to enable support for the axp305 pmic found on most
>  	H616 boards.
>  
> +config AXP313A_POWER
> +	bool "axp313a pmic support"
> +	select AXP_PMIC_BUS
> +	select CMD_POWEROFF
> +	---help---
> +	Select this to enable support for the axp313a pmic found on some
> +	H616 boards.
> +
>  config AXP809_POWER
>  	bool "axp809 pmic support"
>  	depends on MACH_SUN9I
> @@ -143,8 +151,8 @@ config AXP_DCDC1_VOLT
>  
>  config AXP_DCDC2_VOLT
>  	int "axp pmic dcdc2 voltage"
> -	depends on AXP152_POWER || AXP209_POWER || AXP221_POWER || AXP809_POWER || AXP818_POWER
> -	default 900 if AXP818_POWER
> +	depends on AXP152_POWER || AXP209_POWER || AXP221_POWER || AXP809_POWER || AXP818_POWER || AXP313A_POWER
> +	default 900 if AXP818_POWER || AXP313A_POWER
>  	default 1400 if AXP152_POWER || AXP209_POWER
>  	default 1200 if MACH_SUN6I
>  	default 1100 if MACH_SUN8I
> @@ -161,8 +169,8 @@ config AXP_DCDC2_VOLT
>  
>  config AXP_DCDC3_VOLT
>  	int "axp pmic dcdc3 voltage"
> -	depends on AXP152_POWER || AXP209_POWER || AXP221_POWER || AXP809_POWER || AXP818_POWER
> -	default 900 if AXP809_POWER || AXP818_POWER
> +	depends on AXP152_POWER || AXP209_POWER || AXP221_POWER || AXP809_POWER || AXP818_POWER || AXP313A_POWER
> +	default 900 if AXP809_POWER || AXP818_POWER || AXP313A_POWER
>  	default 1500 if AXP152_POWER
>  	default 1250 if AXP209_POWER
>  	default 1100 if MACH_SUN8I_R40
> diff --git a/drivers/power/Makefile b/drivers/power/Makefile
> index ba64b2c593..f851f4a94e 100644
> --- a/drivers/power/Makefile
> +++ b/drivers/power/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_AXP152_POWER)	+= axp152.o
>  obj-$(CONFIG_AXP209_POWER)	+= axp209.o
>  obj-$(CONFIG_AXP221_POWER)	+= axp221.o
>  obj-$(CONFIG_AXP305_POWER)	+= axp305.o
> +obj-$(CONFIG_AXP313A_POWER)	+= axp313a.o
>  obj-$(CONFIG_AXP809_POWER)	+= axp809.o
>  obj-$(CONFIG_AXP818_POWER)	+= axp818.o
>  obj-$(CONFIG_EXYNOS_TMU)	+= exynos-tmu.o
> diff --git a/drivers/power/axp313a.c b/drivers/power/axp313a.c
> new file mode 100644
> index 0000000000..90be8942bb
> --- /dev/null
> +++ b/drivers/power/axp313a.c
> @@ -0,0 +1,171 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * AXP313A driver based on AXP221 driver
> + *
> + *
> + * (C) Copyright 2023 SASANO Takayoshi <uaa@uaa.org.uk>
> + *
> + * Based on axp221.c
> + * (C) Copyright 2014 Hans de Goede <hdegoede@redhat.com>
> + * (C) Copyright 2013 Oliver Schinagl <oliver@schinagl.nl>
> + */
> +
> +#include <common.h>
> +#include <command.h>
> +#include <errno.h>
> +#include <asm/arch/pmic_bus.h>
> +#include <axp_pmic.h>
> +
> +static u8 axp313a_mvolt_to_cfg(int mvolt, int min, int max, int div)
> +{
> +	if (mvolt < min)
> +		mvolt = min;
> +	else if (mvolt > max)
> +		mvolt = max;
> +
> +	return (mvolt - min) / div;
> +}
> +
> +int axp_set_dcdc1(unsigned int mvolt)
> +{
> +	int ret;
> +	u8 cfg;
> +
> +	if (mvolt >= 1600)
> +		cfg = 88 + axp313a_mvolt_to_cfg(mvolt, 1600, 3400, 100);
> +	else if (mvolt >= 1220)
> +		cfg = 71 + axp313a_mvolt_to_cfg(mvolt, 1220, 1540, 20);
> +	else
> +		cfg = axp313a_mvolt_to_cfg(mvolt, 500, 1200, 10);
> +
> +	if (mvolt == 0)
> +		return pmic_bus_clrbits(AXP313A_OUTPUT_CTRL,
> +					AXP313A_OUTPUT_CTRL_DCDC1);
> +
> +	ret = pmic_bus_write(AXP313A_DCDC1_CTRL, cfg);
> +	if (ret)
> +		return ret;
> +
> +	return pmic_bus_setbits(AXP313A_OUTPUT_CTRL,
> +				AXP313A_OUTPUT_CTRL_DCDC1);
> +}
> +
> +int axp_set_dcdc2(unsigned int mvolt)
> +{
> +	int ret;
> +	u8 cfg;
> +
> +	if (mvolt >= 1220)
> +		cfg = 71 + axp313a_mvolt_to_cfg(mvolt, 1220, 1540, 20);
> +	else
> +		cfg = axp313a_mvolt_to_cfg(mvolt, 500, 1200, 10);
> +
> +	if (mvolt == 0)
> +		return pmic_bus_clrbits(AXP313A_OUTPUT_CTRL,
> +					AXP313A_OUTPUT_CTRL_DCDC2);
> +
> +	ret = pmic_bus_write(AXP313A_DCDC2_CTRL, cfg);
> +	if (ret)
> +		return ret;
> +
> +	return pmic_bus_setbits(AXP313A_OUTPUT_CTRL,
> +				AXP313A_OUTPUT_CTRL_DCDC2);
> +}
> +
> +int axp_set_dcdc3(unsigned int mvolt)
> +{
> +	int ret;
> +	u8 cfg;
> +
> +	if (mvolt >= 1220)
> +		cfg = 71 + axp313a_mvolt_to_cfg(mvolt, 1220, 1840, 20);
> +	else
> +		cfg = axp313a_mvolt_to_cfg(mvolt, 500, 1200, 10);
> +
> +	if (mvolt == 0)
> +		return pmic_bus_clrbits(AXP313A_OUTPUT_CTRL,
> +					AXP313A_OUTPUT_CTRL_DCDC3);
> +
> +	ret = pmic_bus_write(AXP313A_DCDC3_CTRL, cfg);
> +	if (ret)
> +		return ret;
> +
> +	return pmic_bus_setbits(AXP313A_OUTPUT_CTRL,
> +				AXP313A_OUTPUT_CTRL_DCDC3);
> +}
> +
> +int axp_set_aldo1(unsigned int mvolt)
> +{
> +	int ret;
> +	u8 cfg = axp313a_mvolt_to_cfg(mvolt, 500, 3500, 100);
> +
> +	if (mvolt == 0)
> +		return pmic_bus_clrbits(AXP313A_OUTPUT_CTRL,
> +					AXP313A_OUTPUT_CTRL_ALDO1);
> +
> +	ret = pmic_bus_write(AXP313A_ALDO1_CTRL, cfg);
> +	if (cfg)
> +		return ret;
> +
> +	return pmic_bus_setbits(AXP313A_OUTPUT_CTRL,
> +				AXP313A_OUTPUT_CTRL_ALDO1);
> +}
> +
> +int axp_set_dldo(int dldo_num, unsigned int mvolt)
> +{
> +	int ret;
> +	u8 cfg = axp313a_mvolt_to_cfg(mvolt, 500, 3500, 100);
> +
> +	if (dldo_num != 1)
> +		return -EINVAL;
> +
> +	if (mvolt == 0)
> +		return pmic_bus_clrbits(AXP313A_OUTPUT_CTRL,
> +					AXP313A_OUTPUT_CTRL_DLDO1);
> +
> +	ret = pmic_bus_write(AXP313A_DLDO1_CTRL, cfg);
> +	if (cfg)
> +		return ret;
> +
> +	return pmic_bus_setbits(AXP313A_OUTPUT_CTRL,
> +				AXP313A_OUTPUT_CTRL_DLDO1);
> +}
> +
> +int axp_init(void)
> +{
> +	int ret;
> +	u8 axp_chip_id;
> +
> +	ret = pmic_bus_init();
> +	if (ret)
> +		return ret;
> +
> +	ret = pmic_bus_read(AXP313A_CHIP_VERSION, &axp_chip_id);
> +	if (ret)
> +		return ret;
> +
> +	axp_chip_id &= AXP313A_CHIP_VERSION_MASK;
> +	switch (axp_chip_id) {
> +	case AXP313A_CHIP_VERSION_AXP1530:
> +	case AXP313A_CHIP_VERSION_AXP313A:
> +	case AXP313A_CHIP_VERSION_AXP313B:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +#if !IS_ENABLED(CONFIG_SYSRESET_CMD_POWEROFF)
> +int do_poweroff(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> +{
> +	pmic_bus_write(AXP313A_SHUTDOWN, AXP313A_POWEROFF);
> +
> +	/* infinite loop during shutdown */
> +	while (1);
> +
> +	/* not reached */
> +	return 0;
> +}
> +#endif
> diff --git a/drivers/power/pmic/axp.c b/drivers/power/pmic/axp.c
> index 025dac24f2..d23c16d996 100644
> --- a/drivers/power/pmic/axp.c
> +++ b/drivers/power/pmic/axp.c
> @@ -87,6 +87,7 @@ static const struct udevice_id axp_pmic_ids[] = {
>  	{ .compatible = "x-powers,axp209", .data = AXP209_ID },
>  	{ .compatible = "x-powers,axp221", .data = AXP221_ID },
>  	{ .compatible = "x-powers,axp223", .data = AXP223_ID },
> +	{ .compatible = "x-powers,axp313a", .data = AXP313A_ID },
>  	{ .compatible = "x-powers,axp803", .data = AXP803_ID },
>  	{ .compatible = "x-powers,axp806", .data = AXP806_ID },
>  	{ .compatible = "x-powers,axp809", .data = AXP809_ID },
> diff --git a/include/axp313a.h b/include/axp313a.h
> new file mode 100644
> index 0000000000..a61a11a53c
> --- /dev/null
> +++ b/include/axp313a.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * (C) Copyright 2023 SASANO Takayoshi <uaa@uaa.org.uk>
> + */
> +
> +enum axp313a_reg {
> +	AXP313A_POWER_STATUS = 0x00,
> +	AXP313A_CHIP_VERSION = 0x03,
> +	AXP313A_OUTPUT_CTRL = 0x10,
> +	AXP313A_DCDC1_CTRL = 0x13,
> +	AXP313A_DCDC2_CTRL = 0x14,
> +	AXP313A_DCDC3_CTRL = 0x15,
> +	AXP313A_ALDO1_CTRL = 0x16,
> +	AXP313A_DLDO1_CTRL = 0x17,
> +	AXP313A_SHUTDOWN = 0x1a,
> +	AXP313A_IRQ_ENABLE = 0x20,
> +	AXP313A_IRQ_STATUS = 0x21,
> +};
> +
> +#define AXP313A_CHIP_VERSION_MASK	0xcf
> +#define AXP313A_CHIP_VERSION_AXP1530	0x48
> +#define AXP313A_CHIP_VERSION_AXP313A	0x4b
> +#define AXP313A_CHIP_VERSION_AXP313B	0x4c
> +
> +#define AXP313A_OUTPUT_CTRL_DCDC1	BIT(0)
> +#define AXP313A_OUTPUT_CTRL_DCDC2	BIT(1)
> +#define AXP313A_OUTPUT_CTRL_DCDC3	BIT(2)
> +#define AXP313A_OUTPUT_CTRL_ALDO1	BIT(3)
> +#define AXP313A_OUTPUT_CTRL_DLDO1	BIT(4)
> +
> +#define AXP313A_POWEROFF		BIT(7)
> diff --git a/include/axp_pmic.h b/include/axp_pmic.h
> index 4ac6486583..9b6d7d900c 100644
> --- a/include/axp_pmic.h
> +++ b/include/axp_pmic.h
> @@ -13,6 +13,7 @@
>  #include <axp209.h>
>  #include <axp221.h>
>  #include <axp305.h>
> +#include <axp313a.h>
>  #include <axp809.h>
>  #include <axp818.h>
>  
> @@ -32,6 +33,7 @@ enum {
>  	AXP209_ID,
>  	AXP221_ID,
>  	AXP223_ID,
> +	AXP313A_ID,
>  	AXP803_ID,
>  	AXP806_ID,
>  	AXP809_ID,

