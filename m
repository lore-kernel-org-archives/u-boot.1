Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04720C4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 22:48:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4178F87158;
	Tue,  5 Dec 2023 23:48:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="zMZZkBgo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D68C787032; Tue,  5 Dec 2023 23:48:42 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A506087032
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 23:48:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d64d=HR=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1701816511;
 bh=xCbEALKqCe7FIGiL0S0qPNc3xFOLTpcPV16HPMv8bWA=;
 b=zMZZkBgoMQpNDs/aXe4WT0bs8/cWQ8MQdWQ4ULeRVBB3lwyH2RzGcg3PRcCpuAqGzf8ANyisH
 BLUFAi23HR7V18cffSaj9GO/DkfYnTKtozjLnoBqSUBvGzlmtRYi+yXxxZrLJUJfOFpIW8mFVVg
 q6+Vz6C+rxAfVjTnnTSAMU/2fXJBnG9x/nSKgjITj4WgyrOmm5wiGAvMwfwpJpddnC9O/xLeHIj
 aWQRMtVU5IHVJjV8xM0yE/J4B1GMddct+7YtSOxUyCFcvy+K8zvmN2Y7fdT8+XqliA4QQut2Fis
 iz6nyGV2Vnb+bZqhRvUn9Pyp/kaGYDofKZsw9A2tN4+A==
Message-ID: <791b6412-8f8a-4a55-98ad-7564ec0c283d@kwiboo.se>
Date: Tue, 5 Dec 2023 23:48:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: rockchip: add Powkiddy X55
Content-Language: en-US
To: Chris Morgan <macroalpha82@gmail.com>, Chris Morgan
 <macromorgan@hotmail.com>
Cc: kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 u-boot@lists.denx.de
References: <20231205213929.95324-1-macroalpha82@gmail.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20231205213929.95324-1-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 656fa8beb9615115117f8bb2
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

Hi Chris,

On 2023-12-05 22:39, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> The Powkiddy X55 is a Rockchip RK3566 based handheld gaming device.
> UART, ADC, eMMC, and SDMMC are tested to work.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  arch/arm/dts/Makefile                        |   1 +
>  arch/arm/dts/rk3566-powkiddy-x55-u-boot.dtsi |  67 ++
>  arch/arm/dts/rk3566-powkiddy-x55.dts         | 926 +++++++++++++++++++
>  arch/arm/mach-rockchip/rk3568/Kconfig        |   6 +
>  board/powkiddy/x55/Kconfig                   |  15 +
>  board/powkiddy/x55/MAINTAINERS               |   8 +
>  board/powkiddy/x55/Makefile                  |   6 +
>  board/powkiddy/x55/x55.c                     | 101 ++
>  configs/powkiddy-x55-rk3566_defconfig        |  86 ++
>  doc/board/index.rst                          |   1 +
>  doc/board/powkiddy/index.rst                 |   9 +
>  doc/board/powkiddy/x55.rst                   |  46 +
>  include/configs/powkiddy-x55-rk3566.h        |  12 +
>  13 files changed, 1284 insertions(+)
>  create mode 100644 arch/arm/dts/rk3566-powkiddy-x55-u-boot.dtsi
>  create mode 100644 arch/arm/dts/rk3566-powkiddy-x55.dts
>  create mode 100644 board/powkiddy/x55/Kconfig
>  create mode 100644 board/powkiddy/x55/MAINTAINERS
>  create mode 100644 board/powkiddy/x55/Makefile
>  create mode 100644 board/powkiddy/x55/x55.c
>  create mode 100644 configs/powkiddy-x55-rk3566_defconfig
>  create mode 100644 doc/board/powkiddy/index.rst
>  create mode 100644 doc/board/powkiddy/x55.rst
>  create mode 100644 include/configs/powkiddy-x55-rk3566.h
> 
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 1be08c5fdc..9e38bab6eb 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -174,6 +174,7 @@ dtb-$(CONFIG_ROCKCHIP_RK3568) += \
>  	rk3566-anbernic-rgxx3.dtb \
>  	rk3566-quartz64-a.dtb \
>  	rk3566-quartz64-b.dtb \
> +	rk3566-powkiddy-x55.dtb \
>  	rk3566-radxa-cm3-io.dtb \
>  	rk3566-soquartz-blade.dtb \
>  	rk3566-soquartz-cm4.dtb \
> diff --git a/arch/arm/dts/rk3566-powkiddy-x55-u-boot.dtsi b/arch/arm/dts/rk3566-powkiddy-x55-u-boot.dtsi
> new file mode 100644
> index 0000000000..2e3998a65a
> --- /dev/null
> +++ b/arch/arm/dts/rk3566-powkiddy-x55-u-boot.dtsi
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk356x-u-boot.dtsi"
> +
> +/ {
> +	chosen {
> +		stdout-path = &uart2;
> +		u-boot,spl-boot-order = "same-as-spl", &sdmmc0, &sdhci;

This matches what is set in rk356x-u-boot.dtsi and can be droped.

> +	};
> +
> +	rng: rng@fe388000 {
> +		compatible = "rockchip,cryptov2-rng";
> +		reg = <0x0 0xfe388000 0x0 0x2000>;
> +		status = "okay";
> +	};
> +};
> +
> +&cru {
> +	assigned-clocks =
> +			<&pmucru CLK_RTC_32K>, <&pmucru PLL_PPLL>,
> +			<&pmucru PCLK_PMU>, <&cru PLL_CPLL>,
> +			<&cru PLL_GPLL>, <&cru PLL_VPLL>,
> +			<&cru ACLK_BUS>, <&cru PCLK_BUS>,
> +			<&cru ACLK_TOP_HIGH>, <&cru ACLK_TOP_LOW>,
> +			<&cru HCLK_TOP>, <&cru PCLK_TOP>,
> +			<&cru ACLK_PERIMID>, <&cru HCLK_PERIMID>,
> +			<&cru CPLL_500M>, <&cru CPLL_333M>,
> +			<&cru CPLL_250M>, <&cru CPLL_125M>,
> +			<&cru CPLL_100M>, <&cru CPLL_62P5M>,
> +			<&cru CPLL_50M>, <&cru CPLL_25M>;
> +		assigned-clock-rates =
> +			<32768>, <200000000>,
> +			<100000000>, <1000000000>,
> +			<1200000000>, <126400000>,
> +			<150000000>, <100000000>,
> +			<500000000>, <400000000>,
> +			<150000000>, <100000000>,
> +			<300000000>, <150000000>,
> +			<500000000>, <333333333>,
> +			<250000000>, <125000000>,
> +			<100000000>, <62500000>,
> +			<50000000>, <25000000>;
> +		assigned-clock-parents =
> +			<&pmucru CLK_RTC32K_FRAC>;
> +};
> +
> +&pmucru {
> +	assigned-clocks = <&pmucru SCLK_32K_IOE>;
> +	assigned-clock-parents = <&pmucru CLK_RTC_32K>;
> +};
> +
> +/*
> + * We don't need the clocks, but if they are present they may cause
> + * probing to fail so we remove them for U-Boot.
> + */
> +&rk817 {
> +	/delete-property/ assigned-clocks;
> +	/delete-property/ assigned-clock-parents;
> +	/delete-property/ clocks;
> +	/delete-property/ clock-names;
> +};

You should not need to remove these clock properties, the clk driver has
dummy support for the referenced I2S1_MCLKOUT_TX clock.

> +
> +&uart2 {
> +	clock-frequency = <24000000>;
> +	bootph-all;
> +	status = "okay";
> +};

[...]

> diff --git a/arch/arm/mach-rockchip/rk3568/Kconfig b/arch/arm/mach-rockchip/rk3568/Kconfig
> index baa51349f4..a97da8ae55 100644
> --- a/arch/arm/mach-rockchip/rk3568/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3568/Kconfig
> @@ -22,6 +22,11 @@ config TARGET_ODROID_M1_RK3568
>  	help
>  	  Hardkernel ODROID-M1 single board computer with a RK3568B2 SoC.
>  
> +config TARGET_POWKIDDY_X55_RK3566
> +	bool "Powkiddy X55"
> +	help
> +	  Powkiddy X55 handheld gaming console with an RK3566 SoC.
> +
>  config TARGET_QUARTZ64_RK3566
>  	bool "Pine64 Quartz64"
>  	help
> @@ -45,5 +50,6 @@ source "board/rockchip/evb_rk3568/Kconfig"
>  source "board/anbernic/rgxx3_rk3566/Kconfig"
>  source "board/hardkernel/odroid_m1/Kconfig"
>  source "board/pine64/quartz64_rk3566/Kconfig"
> +source "board/powkiddy/x55/Kconfig"
>  
>  endif
> diff --git a/board/powkiddy/x55/Kconfig b/board/powkiddy/x55/Kconfig
> new file mode 100644
> index 0000000000..a7b3ed4d0d
> --- /dev/null
> +++ b/board/powkiddy/x55/Kconfig
> @@ -0,0 +1,15 @@
> +if TARGET_POWKIDDY_X55_RK3566
> +
> +config SYS_BOARD
> +	default "x55"
> +
> +config SYS_VENDOR
> +	default "powkiddy"
> +
> +config SYS_CONFIG_NAME
> +	default "powkiddy-x55-rk3566"
> +
> +config BOARD_SPECIFIC_OPTIONS
> +	def_bool y
> +
> +endif
> diff --git a/board/powkiddy/x55/MAINTAINERS b/board/powkiddy/x55/MAINTAINERS
> new file mode 100644
> index 0000000000..2c83cd6ee1
> --- /dev/null
> +++ b/board/powkiddy/x55/MAINTAINERS
> @@ -0,0 +1,8 @@
> +X55
> +M:	Chris Morgan <macromorgan@hotmail.com>
> +S:	Maintained
> +F:	board/powkiddy/x55
> +F:	include/configs/powkiddy-x55-rk3566.h
> +F:	configs/powkiddy-x55-rk3566_defconfig
> +F:	arch/arm/dts/rk3566-powkiddy-x55.dts
> +F:	arch/arm/dts/rk3566-powkiddy-x55-u-boot.dtsi

doc/board/powkiddy/x55.rst should probably also be listed.

> diff --git a/board/powkiddy/x55/Makefile b/board/powkiddy/x55/Makefile
> new file mode 100644
> index 0000000000..55c8c16aa1
> --- /dev/null
> +++ b/board/powkiddy/x55/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier:     GPL-2.0+
> +#
> +# Copyright (c) 2023 Chris Morgan <macromorgan@hotmail.com>
> +#
> +
> +obj-y += x55.o
> diff --git a/board/powkiddy/x55/x55.c b/board/powkiddy/x55/x55.c
> new file mode 100644
> index 0000000000..5c8d7e2bcd
> --- /dev/null
> +++ b/board/powkiddy/x55/x55.c
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2023 Chris Morgan <macromorgan@hotmail.com>
> + */
> +
> +#include <asm/io.h>
> +#include <command.h>
> +#include <linux/iopoll.h>
> +
> +#define BOOT_BROM_DOWNLOAD	0xef08a53c
> +
> +#define GPIO4_BASE		0xfe770000
> +#define GPIO_SWPORT_DR_L	0x0000
> +#define GPIO_SWPORT_DDR_L	0x0008
> +#define GPIO_B4			BIT(12)
> +#define GPIO_B5			BIT(13)
> +#define GPIO_B6			BIT(14)
> +
> +#define GPIO_WRITEMASK(bits)	((bits) << 16)
> +
> +#define SARADC_BASE		0xfe720000
> +#define SARADC_DATA		0x0000
> +#define SARADC_STAS		0x0004
> +#define SARADC_ADC_STATUS	BIT(0)
> +#define SARADC_CTRL		0x0008
> +#define SARADC_INPUT_SRC_MSK	0x7
> +#define SARADC_POWER_CTRL	BIT(3)
> +
> +/*
> + * Read the function "button" to determine if we need to boot straight
> + * into download mode. In this case a user would hold the left joystick
> + * all the way to the left when powering on the device. This function is
> + * needed because 1) on some devices it may not be possible to bypass the
> + * eMMC in the bootpath and 2) after A-TF loads the device will simply
> + * reboot instead of booting into download mode.
> + */
> +void read_func_button(void)
> +{
> +	int ret;
> +	u32 reg;
> +
> +	/* Turn off SARADC to reset it. */
> +	writel(0, (SARADC_BASE + SARADC_CTRL));
> +
> +	/* Enable channel 0 and power on SARADC. */
> +	writel(((0 & SARADC_INPUT_SRC_MSK) | SARADC_POWER_CTRL),
> +	       (SARADC_BASE + SARADC_CTRL));
> +
> +	/*
> +	 * Wait for data to be ready. Use timeout of 20000us from
> +	 * rockchip_saradc driver.
> +	 */
> +	ret = readl_poll_timeout((SARADC_BASE + SARADC_STAS), reg,
> +				 !(reg & SARADC_ADC_STATUS), 20000);
> +	if (ret) {
> +		printf("ADC Timeout");
> +		return;
> +	}
> +
> +	/* Read the data from the SARADC. */
> +	reg = readl((SARADC_BASE + SARADC_DATA));
> +
> +	/* Turn the SARADC back off so it's ready to be used again. */
> +	writel(0, (SARADC_BASE + SARADC_CTRL));
> +
> +	/*
> +	 * If the value is less than 30 the button is being pressed.
> +	 * Reset the device back into Rockchip download mode.
> +	 */
> +	if (reg <= 30) {
> +		printf("download key pressed, entering download mode...");
> +		writel(BOOT_BROM_DOWNLOAD, CONFIG_ROCKCHIP_BOOT_MODE_REG);
> +		do_reset(NULL, 0, 0, NULL);
> +	}
> +};

Would be nice if this could be made more generic for all rockchip boards,
and using a value from devicetree to configure the channel to use.

Possible something like rockchip,brom-download-adc-channel = <0> under
chosen node or something similar could work?

We should also have enough space in SPL to be able to use driver model
for interaction with adc.

> +
> +/*
> + * Start LED very early so user knows device is on. Set color
> + * to red.
> + */
> +void spl_board_init(void)
> +{
> +	read_func_button();
> +
> +	/* Set GPIO4_B4, GPIO4_B5, and GPIO4_B6 to output. */
> +	writel(GPIO_WRITEMASK(GPIO_B6 | GPIO_B5 | GPIO_B4) | \
> +	       (GPIO_B6 | GPIO_B5 | GPIO_B4),
> +	       (GPIO4_BASE + GPIO_SWPORT_DDR_L));
> +	/* Set GPIO4_B5 and GPIO4_B6 to 0 and GPIO4_B4 to 1. */
> +	writel(GPIO_WRITEMASK(GPIO_B6 | GPIO_B5 | GPIO_B4) | GPIO_B4,
> +	       (GPIO4_BASE + GPIO_SWPORT_DR_L));
> +}
> +
> +int rk_board_late_init(void)
> +{
> +	/* Turn off red LED and turn on orange LED. */
> +	writel(GPIO_WRITEMASK(GPIO_B6 | GPIO_B5 | GPIO_B4) | GPIO_B6,
> +	       (GPIO4_BASE + GPIO_SWPORT_DR_L));
> +
> +	return 0;
> +}
> diff --git a/configs/powkiddy-x55-rk3566_defconfig b/configs/powkiddy-x55-rk3566_defconfig
> new file mode 100644
> index 0000000000..aa29df04d1
> --- /dev/null
> +++ b/configs/powkiddy-x55-rk3566_defconfig
> @@ -0,0 +1,86 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_TEXT_BASE=0x00a00000
> +CONFIG_SPL_LIBCOMMON_SUPPORT=y
> +CONFIG_SPL_LIBGENERIC_SUPPORT=y
> +CONFIG_NR_DRAM_BANKS=2
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
> +CONFIG_DEFAULT_DEVICE_TREE="rk3566-powkiddy-x55"
> +CONFIG_ROCKCHIP_RK3568=y
> +CONFIG_SPL_ROCKCHIP_BACK_TO_BROM=y

SPL load U-Boot proper from FIT image, so this should not be needed.

> +CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
> +CONFIG_ROCKCHIP_RK8XX_DISABLE_BOOT_ON_POWERON=y
> +CONFIG_SPL_MMC=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_SPL_STACK_R_ADDR=0x600000
> +CONFIG_TARGET_POWKIDDY_X55_RK3566=y
> +CONFIG_SPL_STACK=0x400000
> +CONFIG_DEBUG_UART_BASE=0xFE660000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_DEBUG_UART=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y

Recommend adding following for an added integrity check of loaded FIT
images.

CONFIG_SPL_FIT_SIGNATURE=y
CONFIG_LEGACY_IMAGE_FORMAT=y

Try following patch to speed up boot when signature check is enabled.
https://patchwork.ozlabs.org/patch/1802303/

> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_OF_STDOUT_VIA_ALIAS=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-powkiddy-x55.dtb"
> +# CONFIG_CONSOLE_MUX is not set
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_SPL_MAX_SIZE=0x20000

Should be 0x40000 not 0x20000

> +CONFIG_SPL_PAD_TO=0x7f8000
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> +CONFIG_SPL_BSS_START_ADDR=0x4000000
> +CONFIG_SPL_BSS_MAX_SIZE=0x4000
> +CONFIG_SPL_BOARD_INIT=y
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK_R=y
> +CONFIG_SPL_ATF=y
> +CONFIG_CMD_PWM=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_MMC=y
> +# CONFIG_CMD_SETEXPR is not set
> +# CONFIG_CMD_CLS is not set
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y

Recommend adding following to ensure pinctrl for sdmmc/sdhci is
configured at SPL stage.

CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
CONFIG_SPL_DM_SEQ_ALIAS=y
CONFIG_SPL_PINCTRL=y

> +CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
> +# CONFIG_NET is not set
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_SPL_CLK=y
> +CONFIG_ARM_SMCCC_FEATURES=y
> +CONFIG_SCMI_FIRMWARE=y
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_MISC=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_DM_PMIC=y
> +CONFIG_DM_PMIC_FAN53555=y

I do not see fcs,fan53555 compatible in the device tree, this can be
droped.

> +CONFIG_PMIC_RK8XX=y
> +CONFIG_REGULATOR_PWM=y
> +CONFIG_DM_REGULATOR_GPIO=y

I do not see any pwm-regulator or regulator-gpio compatible in the
device tree, these two can be dropped.

> +CONFIG_REGULATOR_RK8XX=y
> +CONFIG_DM_REGULATOR_SCMI=y

SCMI clock protocol is only used to control cpu and gpu clock on rk356x,
this can be droped.

> +CONFIG_PWM_ROCKCHIP=y
> +CONFIG_SPL_RAM=y
> +# CONFIG_RAM_ROCKCHIP_DEBUG is not set
> +CONFIG_DM_RNG=y
> +CONFIG_RNG_ROCKCHIP=y
> +# CONFIG_RNG_SMCCC_TRNG is not set
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_SYSRESET=y
> +CONFIG_REGEX=y
> +CONFIG_ERRNO_STR=y
> +# CONFIG_EFI_LOADER is not set
> diff --git a/doc/board/index.rst b/doc/board/index.rst
> index 531e547e7e..dd4bce9981 100644
> --- a/doc/board/index.rst
> +++ b/doc/board/index.rst
> @@ -36,6 +36,7 @@ Board-specific doc
>     nxp/index
>     openpiton/index
>     phytec/index
> +   powkiddy/index
>     purism/index
>     qualcomm/index
>     renesas/index
> diff --git a/doc/board/powkiddy/index.rst b/doc/board/powkiddy/index.rst
> new file mode 100644
> index 0000000000..b0115a73d4
> --- /dev/null
> +++ b/doc/board/powkiddy/index.rst
> @@ -0,0 +1,9 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +Powkiddy
> +========
> +
> +.. toctree::
> +   :maxdepth: 2
> +
> +   x55.rst
> diff --git a/doc/board/powkiddy/x55.rst b/doc/board/powkiddy/x55.rst
> new file mode 100644
> index 0000000000..66d02944c9
> --- /dev/null
> +++ b/doc/board/powkiddy/x55.rst
> @@ -0,0 +1,46 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +U-Boot for Powkiddy X55 Handheld Gaming Console
> +===============================================
> +
> +This allows U-Boot to boot the Powkiddy X55 handheld gaming console.
> +The X55 is very similar to the other existing Powkiddy RK3566 based
> +devices, except that ADC channels 0-3 are used for the ADC joysticks.
> +As a result the same auto detection functionality cannot be used on
> +this device as the others.
> +
> +The indicator LED will change color based on the boot stage. Red means
> +the device is powered on but has yet to start U-Boot, amber means the
> +device has started U-Boot and is waiting to boot Linux, and when Linux
> +has taken over the LED should change to green (or however it has been
> +configured by the user).
> +
> +In the event the device needs to enter Rockchip download mode, a user
> +can, starting with the power off, hold the left joystick all the way
> +to the left and then power on the device. At this point the USB-C port
> +marked DC/OTG should be set to peripheral mode and allow a user to
> +manipulate the device with the rkdeveloptool tool.
> +
> +Building U-Boot
> +---------------
> +
> +.. code-block:: bash
> +
> +    $ export CROSS_COMPILE=aarch64-linux-gnu-
> +    $ export BL31=../rkbin/bin/rk35/rk3568_bl31_v1.34.elf
> +    $ export ROCKCHIP_TPL=../rkbin/bin/rk35/rk3568_ddr_1056MHz_v1.13.bin

I know that the rk3566/rk3568 ddr blobs are identical, but suggest you
reference correct ddr blob here.

> +    $ make powkiddy-x55-rk3566_defconfig
> +    $ make
> +
> +This will build ``u-boot-rockchip.bin`` which can be written to an SD
> +card.
> +
> +Image installation
> +------------------
> +
> +Write the ``u-boot-rockchip.bin`` to an SD card or the internal eMMC
> +offset 32kb from the start.
> +
> +.. code-block:: bash
> +
> +    $ dd if=u-boot-rockchip.bin of=/dev/mmcblk0 bs=512 seek=64

Why just not reference the common Rockchip build and flashing
instructions at doc/board/rockchip/rockchip.rst ? Are they missing
something and could/should be updated?

Also missing addition of this board under the rk3566 heading in that doc.

Regards,
Jonas

> diff --git a/include/configs/powkiddy-x55-rk3566.h b/include/configs/powkiddy-x55-rk3566.h
> new file mode 100644
> index 0000000000..4b25c6a877
> --- /dev/null
> +++ b/include/configs/powkiddy-x55-rk3566.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#ifndef __POWKIDDY_X55_RK3566_H
> +#define __POWKIDDY_X55_RK3566_H
> +
> +#include <configs/rk3568_common.h>
> +
> +#define ROCKCHIP_DEVICE_SETTINGS \
> +			"stdout=serial,vidconsole\0" \
> +			"stderr=serial,vidconsole\0"
> +
> +#endif

