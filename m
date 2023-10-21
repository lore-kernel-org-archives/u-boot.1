Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A7AC001E0
	for <u-boot@archiver.kernel.org>; Sat, 21 Oct 2023 06:39:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B53B8748D;
	Sat, 21 Oct 2023 08:39:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I82DiVtV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 465E887545; Sat, 21 Oct 2023 08:39:55 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B80EF87284
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 08:39:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2c17de836fbso21193801fa.1
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 23:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697870390; x=1698475190; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WpgSrI/bnyxZPBU9bXOXVxk/tQKmTA1WhisoRQHwd1w=;
 b=I82DiVtVqpN/2OR6wlxHIDDvmeGG9tXoWrfKdRGRmnQsG8/XjKdFeM4gs1LdXw5peN
 A6f4scAd9cvyFk08ghZC6fqvZFfnDfyPQDRzVISlLh4UWLf6uw402eJUjSXVGPCwiJU8
 0qnwu5q0B0TdfwXJjQ8LEj4RMzk1XO7BG6hGBx6ogrmzbHzKqPYSqSWB7r566QzMv2cn
 h4bT/pNz3dz4k34LkHr9dlIqgCPQkWftURK/JyKLqBkh+5JVaWG3BP5pVX4f6GaoqOjm
 xiecxS5QUYDf/R//JIfIb3ZNeCVKc027/gLS2TqT2OxnGLUNjiJ+nHG5Y7CvyKPQwu0G
 Armw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697870390; x=1698475190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WpgSrI/bnyxZPBU9bXOXVxk/tQKmTA1WhisoRQHwd1w=;
 b=MA5oOx6+95p3ugb8EWt0n3DLAfBkrFU0p963OD9eHwFaL1xVU+FUhNMpy8BdK13CLN
 UgtDg62KsFXOSetMMhUOqEYuQe+ICQafHnskV9pvWBo2v40VYzffykYbB/2TER2mnFxG
 TBb6WJX0YV03QTfIND1CLiS0kPjO+4HgS0a/A6X51MSel0or+8UsLDMBoXLZjPACuYwm
 KGHrtyW8wXXr+f2fdGvDPudcEQadfldMhs9ohVccn0YKrt2yewusFBobPGlytJhuBiFj
 9jOkJPxNpsaxgLnH7g0CZAh5lomKPRO0/IhUp9z1URYoPj6HTGPAeij1Yp8Ti0TDL+K6
 KGmg==
X-Gm-Message-State: AOJu0YxshQi2wQckD/+n7OswSfj47cE8mKmEasJJDhih28iDunmDU10R
 1ZlfoKWHefn9bo5Al5WaNjhQl4nvnygbIw==
X-Google-Smtp-Source: AGHT+IH/r4dHnQjS3KaHYzJJ4CGbTZnd6HwFwbjqZnLijV6tj60xR7YF+a77rnh3+u9SpPSt6XYMuw==
X-Received: by 2002:a2e:be1c:0:b0:2c0:20c4:925a with SMTP id
 z28-20020a2ebe1c000000b002c020c4925amr2918980ljq.26.1697870389727; 
 Fri, 20 Oct 2023 23:39:49 -0700 (PDT)
Received: from archlinux.localnet (82-149-12-148.dynamic.telemach.net.
 [82.149.12.148]) by smtp.gmail.com with ESMTPSA id
 dj18-20020a0560000b1200b0032d96dd703bsm3120985wrb.70.2023.10.20.23.39.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 23:39:49 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Samuel Holland <samuel@sholland.org>, SASANO Takayoshi <uaa@mx5.nisiq.net>,
 Mikhail Kalashnikov <iuncuim@gmail.com>,
 Piotr Oniszczuk <piotr.oniszczuk@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 2/3] power: pmic: sunxi: add AXP313 SPL driver
Date: Sat, 21 Oct 2023 08:39:48 +0200
Message-ID: <23260910.6Emhk5qWAg@archlinux>
In-Reply-To: <20231018155014.383566-3-andre.przywara@arm.com>
References: <20231018155014.383566-1-andre.przywara@arm.com>
 <20231018155014.383566-3-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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

On Wednesday, October 18, 2023 5:50:13 PM CEST Andre Przywara wrote:
> On boards using the AXP313 PMIC, the DRAM rail is often not setup
> correctly at reset time, so we have to program the PMIC very early in
> the SPL, before running the DRAM initialisation.
> 
> Add a simple AXP313 PMIC driver that knows about DCDC2(CPU) and
> DCDC3(DRAM), so that we can bump up the voltage before the DRAM init.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm/mach-sunxi/pmic_bus.c |   3 +
>  board/sunxi/board.c            |   3 +-
>  drivers/power/Kconfig          |  17 ++++-
>  drivers/power/Makefile         |   1 +
>  drivers/power/axp313.c         | 134 +++++++++++++++++++++++++++++++++
>  5 files changed, 155 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/power/axp313.c
> 
> diff --git a/arch/arm/mach-sunxi/pmic_bus.c b/arch/arm/mach-sunxi/pmic_bus.c
> index c0908406370..8e7625fe057 100644
> --- a/arch/arm/mach-sunxi/pmic_bus.c
> +++ b/arch/arm/mach-sunxi/pmic_bus.c
> @@ -22,6 +22,7 @@
>  #define AXP209_I2C_ADDR			0x34
> 
>  #define AXP305_I2C_ADDR			0x36
> +#define AXP313_I2C_ADDR			0x36
> 
>  #define AXP221_CHIP_ADDR		0x68
> 
> @@ -34,6 +35,8 @@ static int pmic_i2c_address(void)
>  		return AXP152_I2C_ADDR;
>  	if (IS_ENABLED(CONFIG_AXP305_POWER))
>  		return AXP305_I2C_ADDR;
> +	if (IS_ENABLED(CONFIG_AXP313_POWER))
> +		return AXP313_I2C_ADDR;
> 
>  	/* Other AXP2xx and AXP8xx variants */
>  	return AXP209_I2C_ADDR;
> diff --git a/board/sunxi/board.c b/board/sunxi/board.c
> index 65d79a02c25..39b0ad73a9c 100644
> --- a/board/sunxi/board.c
> +++ b/board/sunxi/board.c
> @@ -584,7 +584,8 @@ void sunxi_board_init(void)
> 
>  #if defined CONFIG_AXP152_POWER || defined CONFIG_AXP209_POWER || \
>  	defined CONFIG_AXP221_POWER || defined CONFIG_AXP305_POWER || \
> -	defined CONFIG_AXP809_POWER || defined CONFIG_AXP818_POWER
> +	defined CONFIG_AXP809_POWER || defined CONFIG_AXP818_POWER || \
> +	defined CONFIG_AXP313_POWER
>  	power_failed = axp_init();
> 
>  	if (IS_ENABLED(CONFIG_AXP_DISABLE_BOOT_ON_POWERON) && !
power_failed) {
> diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
> index 83cb31c937a..a9117d215eb 100644
> --- a/drivers/power/Kconfig
> +++ b/drivers/power/Kconfig
> @@ -101,6 +101,15 @@ config AXP305_POWER
>  	Select this to enable support for the axp305 pmic found on most
>  	H616 boards.
> 
> +config AXP313_POWER
> +	bool "axp311 pmic support"

Typo: axp311 -> axp313

Other than that, it looks good. I can't test it since I don't have any 
hardware with such PMIC.

So FWIW:
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> +	depends on MACH_SUN50I_H616
> +	select AXP_PMIC_BUS
> +	select CMD_POWEROFF
> +	---help---
> +	Select this to enable support for the AXP313 PMIC found on some
> +	H616 boards.
> +
>  config AXP809_POWER
>  	bool "axp809 pmic support"
>  	depends on MACH_SUN9I
> @@ -143,9 +152,10 @@ config AXP_DCDC1_VOLT
> 
>  config AXP_DCDC2_VOLT
>  	int "axp pmic dcdc2 voltage"
> -	depends on AXP152_POWER || AXP209_POWER || AXP221_POWER || 
AXP809_POWER ||
> AXP818_POWER +	depends on AXP152_POWER || AXP209_POWER || AXP221_POWER 
||
> AXP809_POWER || AXP818_POWER || AXP313_POWER default 900 if AXP818_POWER
>  	default 1400 if AXP152_POWER || AXP209_POWER
> +	default 1000 if AXP313_POWER
>  	default 1200 if MACH_SUN6I
>  	default 1100 if MACH_SUN8I
>  	default 0 if MACH_SUN9I
> @@ -158,13 +168,15 @@ config AXP_DCDC2_VOLT
>  	On A80 boards dcdc2 powers the GPU and can be left off.
>  	On A83T boards dcdc2 is used for VDD-CPUA(cluster 0) and should be 
0.9V.
>  	On R40 boards dcdc2 is VDD-CPU and should be 1.1V
> +	On boards using the AXP313 it's often VDD-CPU.
> 
>  config AXP_DCDC3_VOLT
>  	int "axp pmic dcdc3 voltage"
> -	depends on AXP152_POWER || AXP209_POWER || AXP221_POWER || 
AXP809_POWER ||
> AXP818_POWER +	depends on AXP152_POWER || AXP209_POWER || AXP221_POWER 
||
> AXP809_POWER || AXP818_POWER || AXP313_POWER default 900 if AXP809_POWER ||
> AXP818_POWER
>  	default 1500 if AXP152_POWER
>  	default 1250 if AXP209_POWER
> +	default 1100 if AXP313_POWER
>  	default 1100 if MACH_SUN8I_R40
>  	default 1200 if MACH_SUN6I || MACH_SUN8I
>  	---help---
> @@ -177,6 +189,7 @@ config AXP_DCDC3_VOLT
>  	On A80 boards dcdc3 is used for VDD-CPUA(cluster 0) and should be 
0.9V.
>  	On A83T boards dcdc3 is used for VDD-CPUB(cluster 1) and should be 
0.9V.
>  	On R40 boards dcdc3 is VDD-SYS and VDD-GPU and should be 1.1V.
> +	On boards using the AXP313 it's often VDD-DRAM and should be 1.1V 
for
> LPDDR4.
> 
>  config AXP_DCDC4_VOLT
>  	int "axp pmic dcdc4 voltage"
> diff --git a/drivers/power/Makefile b/drivers/power/Makefile
> index ba64b2c5938..c7ee4595fc8 100644
> --- a/drivers/power/Makefile
> +++ b/drivers/power/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_AXP152_POWER)	+= axp152.o
>  obj-$(CONFIG_AXP209_POWER)	+= axp209.o
>  obj-$(CONFIG_AXP221_POWER)	+= axp221.o
>  obj-$(CONFIG_AXP305_POWER)	+= axp305.o
> +obj-$(CONFIG_AXP313_POWER)	+= axp313.o
>  obj-$(CONFIG_AXP809_POWER)	+= axp809.o
>  obj-$(CONFIG_AXP818_POWER)	+= axp818.o
>  obj-$(CONFIG_EXYNOS_TMU)	+= exynos-tmu.o
> diff --git a/drivers/power/axp313.c b/drivers/power/axp313.c
> new file mode 100644
> index 00000000000..bbc9e911115
> --- /dev/null
> +++ b/drivers/power/axp313.c
> @@ -0,0 +1,134 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * AXP313(a) driver
> + *
> + * (C) Copyright 2023 Arm Ltd.
> + *
> + * Based on axp305.c
> + * (C) Copyright 2020 Jernej Skrabec <jernej.skrabec@siol.net>
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
> +enum axp313_reg {
> +	AXP313_CHIP_VERSION	= 0x03,
> +	AXP313_OUTPUT_CTRL	= 0x10,
> +	AXP313_DCDC1_CTRL	= 0x13,
> +	AXP313_SHUTDOWN		= 0x1a,
> +};
> +
> +#define AXP313_CHIP_VERSION_MASK	0xcf
> +#define AXP313_CHIP_VERSION_AXP1530	0x48
> +#define AXP313_CHIP_VERSION_AXP313A	0x4b
> +#define AXP313_CHIP_VERSION_AXP313B	0x4c
> +
> +#define AXP313_DCDC_SPLIT_OFFSET	71
> +#define AXP313_DCDC_SPLIT_MVOLT		1200
> +
> +#define AXP313_POWEROFF			BIT(7)
> +
> +static u8 mvolt_to_cfg(int mvolt, int min, int max, int div)
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
> +	u8 cfg, enable_mask = 1U << (dcdc_num - 1);
> +	int volt_reg = AXP313_DCDC1_CTRL + dcdc_num - 1;
> +	int max_mV;
> +
> +	switch (dcdc_num) {
> +	case 1:
> +	case 2:
> +		max_mV	= 1540;
> +		break;
> +	case 3:
> +		/*
> +		 * The manual defines a different split point, but tests
> +		 * show that it's the same 1200mV as for DCDC1/2.
> +		 */
> +		max_mV	= 1840;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (mvolt > AXP313_DCDC_SPLIT_MVOLT)
> +		cfg = AXP313_DCDC_SPLIT_OFFSET + mvolt_to_cfg(mvolt,
> +				AXP313_DCDC_SPLIT_MVOLT + 20, 
max_mV, 20);
> +	else
> +		cfg = mvolt_to_cfg(mvolt, 500, AXP313_DCDC_SPLIT_MVOLT, 
10);
> +
> +	if (mvolt == 0)
> +		return pmic_bus_clrbits(AXP313_OUTPUT_CTRL, 
enable_mask);
> +
> +	debug("DCDC%d: writing 0x%x to reg 0x%x\n", dcdc_num, cfg, 
volt_reg);
> +	ret = pmic_bus_write(volt_reg, cfg);
> +	if (ret)
> +		return ret;
> +
> +	return pmic_bus_setbits(AXP313_OUTPUT_CTRL, enable_mask);
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
> +	u8 axp_chip_id;
> +	int ret;
> +
> +	ret = pmic_bus_init();
> +	if (ret)
> +		return ret;
> +
> +	ret = pmic_bus_read(AXP313_CHIP_VERSION, &axp_chip_id);
> +	if (ret)
> +		return ret;
> +
> +	axp_chip_id &= AXP313_CHIP_VERSION_MASK;
> +	switch (axp_chip_id) {
> +	case AXP313_CHIP_VERSION_AXP1530:
> +	case AXP313_CHIP_VERSION_AXP313A:
> +	case AXP313_CHIP_VERSION_AXP313B:
> +		break;
> +	default:
> +		debug("unknown PMIC: 0x%x\n", axp_chip_id);
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +#if !CONFIG_IS_ENABLED(ARM_PSCI_FW) &&
> !IS_ENABLED(CONFIG_SYSRESET_CMD_POWEROFF) +int do_poweroff(struct cmd_tbl
> *cmdtp, int flag, int argc, char *const argv[]) +{
> +	pmic_bus_write(AXP313_SHUTDOWN, AXP313_POWEROFF);
> +
> +	/* infinite loop during shutdown */
> +	while (1) {}
> +
> +	/* not reached */
> +	return 0;
> +}
> +#endif




