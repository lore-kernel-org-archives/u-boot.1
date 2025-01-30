Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A30C0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 23:08:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 294B580ADE;
	Fri, 31 Jan 2025 00:08:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="dzJJDji1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FAF780EF6; Fri, 31 Jan 2025 00:08:10 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06B3D80834
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 00:08:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2de8=UX=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1738278485;
 bh=uqqAMVWTXb0iTof26TmuO0m6MmR8ZSvuNf3X8bcJ4Hk=;
 b=dzJJDji1Z2dpIHZOgu3IlSWYLMLhskV59+pi7fJn6hOes3q0RkY+2SoL4OPJfqGzYQAMjpaPH
 H+CgiqZl0H48HDNYJLadJcrmXFSTPUYzN6ivHp07iUM2NJ/s+cFcaReK6IW/Mpqrd05u7+pmC7r
 RGNc/foKTv3wzwqywLfrAJUSCmg25DQRJZmhD+iKKkK8SSPMiEtisFPXXbk4e1XEWx8J+iBc7d2
 lM3/tfzQ8MQRBLDGDuW9f94421rG4VwN8u0Cqihykxxp1yUYz9mj2Yn4fgvGENI0bXGwBEF2f4X
 PMn2l7wR/ar+OtDrNDS+OsSWrzXYB9i2nom3Y/4zFw8Q==
X-Forward-Email-ID: 679c06492d70e7e0588402a7
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <3a372007-dc04-4e3a-86f5-40fc337f6e84@kwiboo.se>
Date: Fri, 31 Jan 2025 00:07:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/20] arm: rockchip: Add RK3576 arch core support
To: Heiko Stuebner <heiko@sntech.de>
Cc: "sjg@chromium.org" <sjg@chromium.org>,
 "philipp.tomsich@vrull.eu" <philipp.tomsich@vrull.eu>,
 "kever.yang@rock-chips.com" <kever.yang@rock-chips.com>,
 "lukma@denx.de" <lukma@denx.de>, "seanga2@gmail.com" <seanga2@gmail.com>,
 "peng.fan@nxp.com" <peng.fan@nxp.com>,
 "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
 "joe.hershberger@ni.com" <joe.hershberger@ni.com>,
 "rfried.dev@gmail.com" <rfried.dev@gmail.com>,
 "quentin.schulz@cherry.de" <quentin.schulz@cherry.de>,
 "detlev.casanova@collabora.com" <detlev.casanova@collabora.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "sebastian.reichel@collabora.com" <sebastian.reichel@collabora.com>,
 Xuhui Lin <xuhui.lin@rock-chips.com>
References: <20241121142731.1202209-1-heiko@sntech.de>
 <20241121142731.1202209-12-heiko@sntech.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20241121142731.1202209-12-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8
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

Hi Heiko,

On 2024-11-21 15:27, Heiko Stuebner wrote:
> From: Xuhui Lin <xuhui.lin@rock-chips.com>
> 
> The Rockchip RK3588 is a ARM-based SoC with quad-core Cortex-A72
> and quad-core Cortex-A53 including 6TOPS NPU, Mali-G52 MC3, HDMI Out,
> DP, eDP, MIPI DSI, MIPI CSI2, LPDDR4/4X/5, eMMC5.1, SD3.0/MMC4.5, UFS,
> USB OTG 3.0, Type-C, USB 2.0, PCIe 2.1, SATA 3, Ethernet, SDIO3.0, I2C,
> UART, SPI, GPIO and PWM.
> 
> Add arch core support for it.
> 
> Signed-off-by: Xuhui Lin <xuhui.lin@rock-chips.com>
> [adapted for mainline u-boot]
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/arm/dts/rk3576-u-boot.dtsi               | 119 +++++++++
>  arch/arm/include/asm/arch-rk3576/boot0.h      |  11 +
>  arch/arm/include/asm/arch-rk3576/gpio.h       |  11 +
>  .../include/asm/arch-rockchip/grf_rk3576.h    | 225 ++++++++++++++++
>  .../include/asm/arch-rockchip/ioc_rk3576.h    | 244 ++++++++++++++++++
>  arch/arm/mach-rockchip/Kconfig                |  46 +++-
>  arch/arm/mach-rockchip/Makefile               |   1 +
>  arch/arm/mach-rockchip/rk3576/Kconfig         |  48 ++++
>  arch/arm/mach-rockchip/rk3576/Makefile        |   9 +
>  arch/arm/mach-rockchip/rk3576/clk_rk3576.c    |  32 +++
>  arch/arm/mach-rockchip/rk3576/rk3576.c        | 169 ++++++++++++
>  arch/arm/mach-rockchip/rk3576/syscon_rk3576.c |  26 ++
>  arch/arm/mach-rockchip/sdram.c                |   1 +
>  doc/board/rockchip/rockchip.rst               |   9 +
>  include/configs/rk3576_common.h               |  42 +++
>  15 files changed, 992 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/dts/rk3576-u-boot.dtsi
>  create mode 100644 arch/arm/include/asm/arch-rk3576/boot0.h
>  create mode 100644 arch/arm/include/asm/arch-rk3576/gpio.h
>  create mode 100644 arch/arm/include/asm/arch-rockchip/grf_rk3576.h
>  create mode 100644 arch/arm/include/asm/arch-rockchip/ioc_rk3576.h
>  create mode 100644 arch/arm/mach-rockchip/rk3576/Kconfig
>  create mode 100644 arch/arm/mach-rockchip/rk3576/Makefile
>  create mode 100644 arch/arm/mach-rockchip/rk3576/clk_rk3576.c
>  create mode 100644 arch/arm/mach-rockchip/rk3576/rk3576.c
>  create mode 100644 arch/arm/mach-rockchip/rk3576/syscon_rk3576.c
>  create mode 100644 include/configs/rk3576_common.h
> 
> diff --git a/arch/arm/dts/rk3576-u-boot.dtsi b/arch/arm/dts/rk3576-u-boot.dtsi
> new file mode 100644
> index 00000000000..1399faf47df
> --- /dev/null
> +++ b/arch/arm/dts/rk3576-u-boot.dtsi
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2022 Edgeble AI Technologies Pvt. Ltd.
> + */
> +
> +#include "rockchip-u-boot.dtsi"
> +
> +/ {
> +	chosen {
> +		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
> +	};
> +
> +	dmc {
> +		compatible = "rockchip,rk3576-dmc";
> +		bootph-all;
> +	};
> +};
> +
> +&cru {
> +	bootph-all;
> +};
> +
> +&emmc_bus8 {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&emmc_clk {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&emmc_cmd {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};

This is missing:

&emmc_rstnout {
	bootph-pre-ram;
	bootph-some-ram;
};

> +
> +&emmc_strb {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};

And to use pinctrl in SPL we need:

&ioc_grf {
	bootph-all;
};

> +
> +&pcfg_pull_down {
> +	bootph-all;
> +};

pcfg_pull_down is not used and can be dropped.

> +
> +&pcfg_pull_none {
> +	bootph-all;
> +};
> +
> +&pcfg_pull_up {
> +	bootph-all;
> +};
> +
> +&pcfg_pull_up_drv_level_2 {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};

For sdmmc0 we need:

&pcfg_pull_up_drv_level_3 {
	bootph-pre-ram;
	bootph-some-ram;
};

> +
> +&php_grf {
> +	bootph-all;
> +};

Nothing use php_grf and this can be dropped.

> +
> +&pinctrl {
> +	bootph-all;
> +};
> +
> +&pmu1_grf {
> +	bootph-all;
> +};
> +
> +&sdhci {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +	u-boot,spl-fifo-mode;
> +};
> +
> +&sdmmc {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +	u-boot,spl-fifo-mode;
> +};
> +
> +&sdmmc0_bus4 {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&sdmmc0_clk {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&sdmmc0_cmd {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&sdmmc0_det {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};

This is missing:

&sdmmc0_pwren {
	bootph-pre-ram;
	bootph-some-ram;
};

> +
> +&sys_grf {
> +	bootph-all;
> +};
> +
> +&uart0 {
> +	bootph-all;
> +	clock-frequency = <24000000>;
> +};
> +
> +&uart0m0_xfer {
> +	bootph-all;
> +};
> +
> +&xin24m {
> +	bootph-all;
> +};

[snip]

> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 269c219a6f8..568ce7389ed 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -341,6 +341,49 @@ config ROCKCHIP_RK3568
>  	  and video codec support. Peripherals include Gigabit Ethernet,
>  	  USB2 host and OTG, SDIO, I2S, UARTs, SPI, I2C and PWMs.
>  
> +config ROCKCHIP_RK3576
> +	bool "Support Rockchip RK3576"
> +	select ARM64
> +	select SUPPORT_SPL
> +	select SPL
> +	select CLK
> +	select PINCTRL
> +	select RAM
> +	select REGMAP
> +	select SYSCON
> +	select BOARD_LATE_INIT
> +	select DM_REGULATOR_FIXED
> +	select DM_RESET

Please add:

imply ARMV8_CRYPTO
imply ARMV8_SET_SMPEN

> +	imply BOOTSTD_FULL
> +	imply CLK_SCMI

SCMI clk is not used, please drop.

> +	imply DM_RNG

Please add:

imply FIT
imply LEGACY_IMAGE_FORMAT
imply MISC

> +	imply MISC_INIT_R
> +	imply MMC_HS200_SUPPORT if MMC_SDHCI_ROCKCHIP
> +	imply OF_LIBFDT_OVERLAY

Please add:

imply OF_LIVE

> +	imply OF_UPSTREAM
> +	imply PHY_GIGE if DWC_ETH_QOS_ROCKCHIP
> +	imply RNG_ROCKCHIP
> +	imply ROCKCHIP_COMMON_BOARD

Please add:

imply ROCKCHIP_COMMON_STACK_ADDR
imply ROCKCHIP_EXTERNAL_TPL

> +	imply ROCKCHIP_OTP
> +	imply SCMI_FIRMWARE

SCMI firmware is not used, please drop.

Please add:

imply SPL_ATF

> +	imply SPL_ATF_NO_PLATFORM_PARAM if SPL_ATF

Please add:

imply SPL_CLK
imply SPL_DM_SEQ_ALIAS
imply SPL_FIT_SIGNATURE
imply SPL_LOAD_FIT

> +	imply SPL_MMC_HS200_SUPPORT if SPL_MMC && MMC_HS200_SUPPORT

Please add:

imply SPL_OF_CONTROL
imply SPL_PINCTRL
imply SPL_RAM
imply SPL_REGMAP
imply SPL_SERIAL
imply SPL_SYSCON
imply SYS_RELOC_GD_ENV_ADDR
imply SYSRESET

With all the extra imply rk3576 board defconfigs will have much less SPL
related option to enable.

The below select and imply can be dropped with [1]

[1] https://patchwork.ozlabs.org/patch/2039045/

> +	select HAS_CUSTOM_SYS_INIT_SP_ADDR
> +	imply SPL_LIBCOMMON_SUPPORT if SPL
> +	imply SPL_LIBGENERIC_SUPPORT if SPL
> +	imply SPL_ROCKCHIP_COMMON_BOARD
> +	imply SPL_SYS_MALLOC_F if SPL
> +	imply SPL_SYS_MALLOC_SIMPLE if SPL
> +	imply TPL_LIBCOMMON_SUPPORT if TPL
> +	imply TPL_LIBGENERIC_SUPPORT if TPL
> +	imply TPL_ROCKCHIP_COMMON_BOARD if TPL
> +	imply TPL_SYS_MALLOC_F if TPL
> +	imply TPL_SYS_MALLOC_SIMPLE if TPL
> +
> +	help
> +	  The Rockchip RK3576 is a ARM-based SoC with a quad-core Cortex-A53
> +	  and a quad-core Cortex-A72.
> +
>  config ROCKCHIP_RK3588
>  	bool "Support Rockchip RK3588"
>  	select ARM64
> @@ -490,7 +533,7 @@ config TPL_ROCKCHIP_COMMON_BOARD
>  
>  config ROCKCHIP_EXTERNAL_TPL
>  	bool "Use external TPL binary"
> -	default y if ROCKCHIP_RK3308 || ROCKCHIP_RK3568 || ROCKCHIP_RK3588
> +	default y if ROCKCHIP_RK3308 || ROCKCHIP_RK3568 || ROCKCHIP_RK3576 || ROCKCHIP_RK3588

This should be moved to an imply under ROCKCHIP_RK3576.

>  	help
>  	  Some Rockchip SoCs require an external TPL to initialize DRAM.
>  	  Enable this option and build with ROCKCHIP_TPL=/path/to/ddr.bin to
> @@ -627,6 +670,7 @@ source "arch/arm/mach-rockchip/rk3328/Kconfig"
>  source "arch/arm/mach-rockchip/rk3368/Kconfig"
>  source "arch/arm/mach-rockchip/rk3399/Kconfig"
>  source "arch/arm/mach-rockchip/rk3568/Kconfig"
> +source "arch/arm/mach-rockchip/rk3576/Kconfig"
>  source "arch/arm/mach-rockchip/rk3588/Kconfig"
>  source "arch/arm/mach-rockchip/rv1108/Kconfig"
>  source "arch/arm/mach-rockchip/rv1126/Kconfig"
> diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
> index 5e7edc99cdc..52464b01f4e 100644
> --- a/arch/arm/mach-rockchip/Makefile
> +++ b/arch/arm/mach-rockchip/Makefile
> @@ -43,6 +43,7 @@ obj-$(CONFIG_ROCKCHIP_RK3328) += rk3328/
>  obj-$(CONFIG_ROCKCHIP_RK3368) += rk3368/
>  obj-$(CONFIG_ROCKCHIP_RK3399) += rk3399/
>  obj-$(CONFIG_ROCKCHIP_RK3568) += rk3568/
> +obj-$(CONFIG_ROCKCHIP_RK3576) += rk3576/
>  obj-$(CONFIG_ROCKCHIP_RK3588) += rk3588/
>  obj-$(CONFIG_ROCKCHIP_RV1108) += rv1108/
>  obj-$(CONFIG_ROCKCHIP_RV1126) += rv1126/
> diff --git a/arch/arm/mach-rockchip/rk3576/Kconfig b/arch/arm/mach-rockchip/rk3576/Kconfig
> new file mode 100644
> index 00000000000..2e46b2b90d2
> --- /dev/null
> +++ b/arch/arm/mach-rockchip/rk3576/Kconfig
> @@ -0,0 +1,48 @@
> +if ROCKCHIP_RK3576
> +
> +config ROCKCHIP_BOOT_MODE_REG
> +	default 0x26024040
> +
> +config ROCKCHIP_STIMER_BASE
> +	default 0x27400000
> +
> +config SYS_SOC
> +	default "rk3576"

Please add following to simplify adding a board defconfig without
requiring a new TARGET_ symbol.

config SYS_CONFIG_NAME
	default "rk3576_common"

The below defaults can be dropped with [1].

> +
> +config CUSTOM_SYS_INIT_SP_ADDR
> +	default 0x43f00000
> +
> +config SYS_MALLOC_F_LEN
> +	default 0x10000
> +
> +config SPL_SYS_MALLOC_F_LEN
> +	default 0x8000
> +
> +config TPL_SYS_MALLOC_F_LEN
> +	default 0x4000
> +
> +config TEXT_BASE
> +	default 0x40200000
> +
> +config SPL_TEXT_BASE
> +	default 0x40000000
> +
> +config SPL_HAS_BSS_LINKER_SECTION
> +	default y if ARM64
> +
> +config SPL_BSS_START_ADDR
> +	default 0x43f80000
> +
> +config SPL_BSS_MAX_SIZE
> +	default 0x8000
> +
> +config SPL_STACK_R
> +	default y
> +
> +config SPL_STACK_R_ADDR
> +	default 0x43e00000
> +
> +config SPL_STACK_R_MALLOC_SIMPLE_LEN
> +	default 0x200000

[1] https://patchwork.ozlabs.org/patch/2039045/

> +
> +endif

[snip]

> diff --git a/arch/arm/mach-rockchip/rk3576/clk_rk3576.c b/arch/arm/mach-rockchip/rk3576/clk_rk3576.c
> new file mode 100644
> index 00000000000..cc580b33e9c
> --- /dev/null
> +++ b/arch/arm/mach-rockchip/rk3576/clk_rk3576.c
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * (C) Copyright 2020 Rockchip Electronics Co., Ltd.
> + */
> +
> +#include <dm.h>
> +#include <syscon.h>
> +#include <asm/arch-rockchip/clock.h>
> +#include <asm/arch-rockchip/cru_rk3576.h>
> +#include <linux/err.h>

With the suggested change below following includes can be removed:

- syscon.h
- asm/arch-rockchip/clock.h
- linux/err.h

> +
> +int rockchip_get_clk(struct udevice **devp)
> +{
> +	return uclass_get_device_by_driver(UCLASS_CLK,
> +			DM_DRIVER_GET(rockchip_rk3576_cru), devp);
> +}
> +
> +void *rockchip_get_cru(void)
> +{
> +	struct rk3576_clk_priv *priv;
> +	struct udevice *dev;
> +	int ret;
> +
> +	ret = rockchip_get_clk(&dev);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	priv = dev_get_priv(dev);
> +
> +	return priv->cru;

This entire function can be simplified to just:

  return (void *)RK3576_CRU_BASE;

This will save a few ms of boot time.

> +}
> +
> diff --git a/arch/arm/mach-rockchip/rk3576/rk3576.c b/arch/arm/mach-rockchip/rk3576/rk3576.c
> new file mode 100644
> index 00000000000..a0fe1803e37
> --- /dev/null
> +++ b/arch/arm/mach-rockchip/rk3576/rk3576.c
> @@ -0,0 +1,169 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2024 Rockchip Electronics Co., Ltd
> + */
> +
> +#include <spl.h>
> +#include <asm/armv8/mmu.h>
> +#include <asm/arch-rockchip/bootrom.h>
> +#include <asm/arch-rockchip/grf_rk3576.h>
> +#include <asm/arch-rockchip/hardware.h>
> +#include <asm/arch-rockchip/ioc_rk3576.h>

Following includes can be removed:

- spl.h
- asm/arch-rockchip/grf_rk3576.h
- asm/arch-rockchip/ioc_rk3576.h

> +
> +#define SYS_GRF_BASE		0x2600A000
> +#define SYS_GRF_SOC_CON2	0x0008
> +#define SYS_GRF_SOC_CON7	0x001c
> +#define SYS_GRF_SOC_CON11	0x002c
> +#define SYS_GRF_SOC_CON12	0x0030
> +
> +#define GPIO0_IOC_BASE		0x26040000
> +#define GPIO0B_PULL_L		0x0024
> +#define GPIO0B_IE_L		0x002C
> +
> +#define SYS_SGRF_BASE		0x26004000
> +#define SYS_SGRF_SOC_CON14	0x0058
> +#define SYS_SGRF_SOC_CON15	0x005C
> +#define SYS_SGRF_SOC_CON20	0x0070
> +
> +#define FW_SYS_SGRF_BASE	0x26005000
> +#define SGRF_DOMAIN_CON1	0x4
> +#define SGRF_DOMAIN_CON2	0x8
> +#define SGRF_DOMAIN_CON3	0xc
> +#define SGRF_DOMAIN_CON4	0x10
> +#define SGRF_DOMAIN_CON5	0x14
> +
> +const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
> +	[BROM_BOOTSOURCE_EMMC] = "/soc/mmc@2a330000",
> +	[BROM_BOOTSOURCE_SD] = "/soc/mmc@2a310000",
> +};
> +
> +static struct mm_region rk3576_mem_map[] = {
> +	{
> +		/*
> +		 * sdhci_send_command sets the start_addr to 0, while
> +		 * sdhci_transfer_data calls dma_unmap_single on that
> +		 * address when the transfer is done, which in turn calls
> +		 * invalidate_dcache_range on that memory block.
> +		 * Map the Bootrom that sits in that memory area, to just
> +		 * let the invalidate_dcache_range call pass.
> +		 */
> +		.virt = 0x0UL,
> +		.phys = 0x0UL,
> +		.size = 0x00008000UL,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {

Above workaround should not be needed with [2] and [3], please drop.

[2] https://patchwork.ozlabs.org/patch/2038102/
[3] https://patchwork.ozlabs.org/patch/2039037/

> +		/* I/O area */
> +		.virt = 0x20000000UL,
> +		.phys = 0x20000000UL,
> +		.size = 0xb080000UL,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* PMU_SRAM, CBUF, SYSTEM_SRAM */
> +		.virt = 0x3fe70000UL,
> +		.phys = 0x3fe70000UL,
> +		.size = 0x190000UL,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* MSCH_DDR_PORT */
> +		.virt = 0x40000000UL,
> +		.phys = 0x40000000UL,
> +		.size = 0x400000000UL,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> +			 PTE_BLOCK_INNER_SHARE
> +	}, {
> +		/* PCIe 0+1 */
> +		.virt = 0x900000000UL,
> +		.phys = 0x900000000UL,
> +		.size = 0x100800000UL,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* List terminator */
> +		0,
> +	}
> +};
> +
> +struct mm_region *mem_map = rk3576_mem_map;
> +
> +void board_debug_uart_init(void)
> +{
> +}
> +
> +#ifdef CONFIG_XPL_BUILD
> +void rockchip_stimer_init(void)
> +{
> +	u32 reg;
> +
> +	/* If Timer already enabled, don't re-init it */
> +	reg = readl(CONFIG_ROCKCHIP_STIMER_BASE + 0x4);
> +	if (reg & 0x1)
> +		return;
> +
> +	asm volatile("msr CNTFRQ_EL0, %0" : : "r" (CONFIG_COUNTER_FREQUENCY));
> +	writel(0xffffffff, CONFIG_ROCKCHIP_STIMER_BASE + 0x14);
> +	writel(0xffffffff, CONFIG_ROCKCHIP_STIMER_BASE + 0x18);
> +	writel(0x00010001, CONFIG_ROCKCHIP_STIMER_BASE + 0x04);

These magic constans could be replaced with constants. See the commit
"fixup: arm: rockchip: Add RK3576 arch core support - rk3576.c" at [4]
for a possible option.

[4] https://github.com/Kwiboo/u-boot-rockchip/commits/rk3576-2025.04-wip/

> +}
> +#endif
> +
> +#ifndef CONFIG_TPL_BUILD
> +int arch_cpu_init(void)
> +{
> +#ifdef CONFIG_XPL_BUILD

Above ifndef CONFIG_TPL_BUILD and ifdef CONFIG_XPL_BUILD combo can be
replaced with a single ifdef CONFIG_SPL_BUILD.

> +	u32 val;
> +
> +	/* Set the emmc to access ddr memory */
> +	val = readl(FW_SYS_SGRF_BASE + SGRF_DOMAIN_CON2);
> +	writel(val | 0x7, FW_SYS_SGRF_BASE + SGRF_DOMAIN_CON2);
> +
> +	/* Set the sdmmc0 to access ddr memory */
> +	val = readl(FW_SYS_SGRF_BASE + SGRF_DOMAIN_CON5);
> +	writel(val | 0x700, FW_SYS_SGRF_BASE + SGRF_DOMAIN_CON5);
> +
> +	/* Set the UFS to access ddr memory */
> +	val = readl(FW_SYS_SGRF_BASE + SGRF_DOMAIN_CON3);
> +	writel(val | 0x70000, FW_SYS_SGRF_BASE + SGRF_DOMAIN_CON3);
> +
> +	/* Set the fspi0 and fspi1 to access ddr memory */
> +	val = readl(FW_SYS_SGRF_BASE + SGRF_DOMAIN_CON4);
> +	writel(val | 0x7700, FW_SYS_SGRF_BASE + SGRF_DOMAIN_CON4);
> +
> +	/* Set the decom to access ddr memory */
> +	val = readl(FW_SYS_SGRF_BASE + SGRF_DOMAIN_CON1);
> +	writel(val | 0x700, FW_SYS_SGRF_BASE + SGRF_DOMAIN_CON1);
> +
> +	/*
> +	 * Set the GPIO0B0~B3 pull up and input enable.
> +	 * Keep consistent with other IO.
> +	 */
> +	writel(0x00ff00ff, GPIO0_IOC_BASE + GPIO0B_PULL_L);
> +	writel(0x000f000f, GPIO0_IOC_BASE + GPIO0B_IE_L);
> +
> +	/*
> +	 * Set SYS_GRF_SOC_CON2[12](input of pwm2_ch0) as 0,
> +	 * keep consistent with other pwm.
> +	 */
> +	writel(0x10000000, SYS_GRF_BASE + SYS_GRF_SOC_CON2);
> +
> +	/* Enable noc slave response timeout */
> +	writel(0x80008000, SYS_GRF_BASE + SYS_GRF_SOC_CON11);
> +	writel(0xffffffe0, SYS_GRF_BASE + SYS_GRF_SOC_CON12);
> +
> +	/*
> +	 * Enable cci channels for below module AXI R/W
> +	 * Module: GMAC0/1, MMU0/1(PCIe, SATA, USB3)
> +	 */
> +	writel(0xffffff00, SYS_SGRF_BASE + SYS_SGRF_SOC_CON20);
> +#endif
> +
> +	return 0;
> +}
> +#endif
> +
> diff --git a/arch/arm/mach-rockchip/rk3576/syscon_rk3576.c b/arch/arm/mach-rockchip/rk3576/syscon_rk3576.c
> new file mode 100644
> index 00000000000..7c15df97d28
> --- /dev/null
> +++ b/arch/arm/mach-rockchip/rk3576/syscon_rk3576.c
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * (C) Copyright 2023 Rockchip Electronics Co., Ltd
> + */
> +
> +#include <dm.h>
> +#include <syscon.h>

syscon.h is not needed and can be removed.

> +#include <asm/arch-rockchip/clock.h>
> +
> +static const struct udevice_id rk3576_syscon_ids[] = {
> +	{ .compatible = "rockchip,rk3576-sys-grf", .data = ROCKCHIP_SYSCON_GRF },
> +	{ .compatible = "rockchip,rk3576-ioc-grf", .data = ROCKCHIP_SYSCON_IOC },
> +	{ .compatible = "rockchip,rk3576-php-grf", .data = ROCKCHIP_SYSCON_PHP_GRF },
> +	{ .compatible = "rockchip,rk3576-pmu1-grf",  .data = ROCKCHIP_SYSCON_PMUGRF },
> +	{ .compatible = "rockchip,rk3576-sdgmac-grf", .data = ROCKCHIP_SYSCON_SDGMAC },

None of these should be needed, suggest you only keep SYSCON_GRF and
SYSCON_PMUGRF.

> +	{ }
> +};
> +
> +U_BOOT_DRIVER(syscon_rk3576) = {
> +	.name = "rk3576_syscon",
> +	.id = UCLASS_SYSCON,
> +	.of_match = rk3576_syscon_ids,
> +#if CONFIG_IS_ENABLED(OF_REAL)
> +	.bind = dm_scan_fdt_dev,
> +#endif
> +};

[snip]

> diff --git a/include/configs/rk3576_common.h b/include/configs/rk3576_common.h
> new file mode 100644
> index 00000000000..d52a0c18da2
> --- /dev/null
> +++ b/include/configs/rk3576_common.h
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * (C) Copyright 2024 Rockchip Electronics Co., Ltd
> + */
> +
> +#ifndef __CONFIG_RK3576_COMMON_H
> +#define __CONFIG_RK3576_COMMON_H

RK3576 has cpu-id at 0xa in otp so we need:

#define CFG_CPUID_OFFSET	0xa

> +
> +#include "rockchip-common.h"
> +
> +#define CFG_IRAM_BASE			0x3ff80000
> +
> +#define CFG_SYS_SDRAM_BASE		0x40000000
> +
> +/*
> + * 16G according to the TRM memory map, but things like efi_memory
> + * handling (efi_loader) choke on a main block going out side the
> + * 4G area.
> + */
> +//#define SDRAM_MAX_SIZE			(SZ_4G - CFG_SYS_SDRAM_BASE)
> +#define SDRAM_MAX_SIZE 0x400000000UL

Typically SDRAM_MAX_SIZE has been used for space below the 4G address
boundary. With the patch at [5] this no longer matter, but for
consistency with all other rockchip targets I suggest you change to use
the commented out version, SZ_4G - CFG_SYS_SDRAM_BASE.

[5] https://patchwork.ozlabs.org/patch/2040760/

Suggest we add following to make it possible to used this header as-is
as SYS_CONFIG_NAME="rk3576_common".

#ifndef ROCKCHIP_DEVICE_SETTINGS
#define ROCKCHIP_DEVICE_SETTINGS
#endif

> +
> +#define ENV_MEM_LAYOUT_SETTINGS		\
> +	"scriptaddr=0x40c00000\0" \
> +	"script_offset_f=0xffe000\0"	\
> +	"script_size_f=0x2000\0"	\
> +	"pxefile_addr_r=0x40e00000\0" \
> +	"kernel_addr_r=0x42000000\0" \
> +	"kernel_comp_addr_r=0x4a000000\0"	\
> +	"fdt_addr_r=0x52000000\0"	\
> +	"fdtoverlay_addr_r=0x52100000\0"	\
> +	"ramdisk_addr_r=0x52180000\0"	\
> +	"kernel_comp_size=0x8000000\0"
> +
> +#define CFG_EXTRA_ENV_SETTINGS		\
> +	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0"	\
> +	"partitions=" PARTS_DEFAULT	\

I suggest we remove this partitions env var, it include legacy
partitioning that has never been that useful.

> +	ENV_MEM_LAYOUT_SETTINGS		\
> +	ROCKCHIP_DEVICE_SETTINGS	\
> +	"boot_targets=" BOOT_TARGETS "\0"
> +
> +#endif /* __CONFIG_RK3576_COMMON_H */

I have created a few fixup commits at [4] that include my suggested
changes, please feel free to squash any changes you feel is relevant :-)

[4] https://github.com/Kwiboo/u-boot-rockchip/commits/rk3576-2025.04-wip/

Regards,
Jonas

