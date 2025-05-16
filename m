Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6242CC3ABC9
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 13:19:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B21868006D;
	Fri, 16 May 2025 15:19:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qSRfB1mn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E453E80107; Fri, 16 May 2025 15:19:03 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BF5B80050
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 15:19:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 7DC30A4E7B5;
 Fri, 16 May 2025 13:19:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D26DC4CEE4;
 Fri, 16 May 2025 13:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747401540;
 bh=aEOZnmWRvEb6qqgxal3GEJ11+RWuuxM+jk509f/U9PQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qSRfB1mnNJCFkdVhavCs961aEJn6bkaz6Gx++PaK1fQAS9A1+1YHxT+WQdOX91uOb
 tqTOqypRk4EqEskOtkVDmXzWXnE3Blnu8lsGqOOuED8WPffLFJGqhCGFXhCrmaJhs/
 Iwe8bDYkekY4CiUjlGraBoXxZU4awWoB3WCHjOVU1WrXmlyiNEse79G3TwwYXtmva2
 t8DaID+HqDg6R1N4NPV6Ue/sy5/p67C99jW98NWT4TW9PUO26dvoh6vbjldc2oGYfJ
 55ukfXTkYEyG4IDmTtDrLfI8EGpq624d2J2Dox13wc9JLzVXe4gkcsvUk1SjH3w1UI
 O1D0RnDtRFr3w==
Date: Fri, 16 May 2025 18:48:49 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, uboot-imx@nxp.com,
 Mathieu Othacehe <m.othacehe@gmail.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, u-boot@lists.denx.de,
 upstream@lists.phytec.de
Subject: Re: [PATCH] ARM: dts: imx93-phycore: Migrate to OF_UPSTREAM
Message-ID: <aCc7OeezTvDi-uPp@sumit-X1>
References: <20250516104602.2445510-1-primoz.fiser@norik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516104602.2445510-1-primoz.fiser@norik.com>
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

On Fri, May 16, 2025 at 12:46:02PM +0200, Primoz Fiser wrote:
> Migrate to OF_UPSTREAM for phyCORE-i.MX93 since board can use upstream
> Linux kernel device-tree for phyBOARD-Segin-i.MX93.
> 
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
> ---
>  arch/arm/dts/Makefile                  |   3 +-
>  arch/arm/dts/imx93-phyboard-segin.dts  | 117 -----------------------
>  arch/arm/dts/imx93-phycore-som.dtsi    | 126 -------------------------
>  arch/arm/mach-imx/imx9/Kconfig         |   1 +
>  board/phytec/phycore_imx93/MAINTAINERS |   2 -
>  configs/imx93-phycore_defconfig        |   2 +-
>  6 files changed, 3 insertions(+), 248 deletions(-)
>  delete mode 100644 arch/arm/dts/imx93-phyboard-segin.dts
>  delete mode 100644 arch/arm/dts/imx93-phycore-som.dtsi

Nice diffstat, FWIW:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 32b698a7f411..976dbda48c37 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -918,8 +918,7 @@ dtb-$(CONFIG_ARCH_IMX8M) += \
>  	imx8mq-librem5-r4.dtb
>  
>  dtb-$(CONFIG_ARCH_IMX9) += \
> -	imx93-var-som-symphony.dtb \
> -	imx93-phyboard-segin.dtb
> +	imx93-var-som-symphony.dtb
>  
>  dtb-$(CONFIG_ARCH_IMXRT) += imxrt1020-evk.dtb \
>  	imxrt1170-evk.dtb \
> diff --git a/arch/arm/dts/imx93-phyboard-segin.dts b/arch/arm/dts/imx93-phyboard-segin.dts
> deleted file mode 100644
> index 85fb188b057f..000000000000
> --- a/arch/arm/dts/imx93-phyboard-segin.dts
> +++ /dev/null
> @@ -1,117 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (C) 2023 PHYTEC Messtechnik GmbH
> - * Author: Wadim Egorov <w.egorov@phytec.de>, Christoph Stoidner <c.stoidner@phytec.de>
> - * Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
> - *
> - * Product homepage:
> - * phyBOARD-Segin carrier board is reused for the i.MX93 design.
> - * https://www.phytec.eu/en/produkte/single-board-computer/phyboard-segin-imx6ul/
> - */
> -/dts-v1/;
> -
> -#include "imx93-phycore-som.dtsi"
> -
> -/{
> -	model = "PHYTEC phyBOARD-Segin-i.MX93";
> -	compatible = "phytec,imx93-phyboard-segin", "phytec,imx93-phycore-som",
> -		     "fsl,imx93";
> -
> -	chosen {
> -		stdout-path = &lpuart1;
> -	};
> -
> -	reg_usdhc2_vmmc: regulator-usdhc2 {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		regulator-name = "VCC_SD";
> -	};
> -};
> -
> -/* Console */
> -&lpuart1 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_uart1>;
> -	status = "okay";
> -};
> -
> -/* eMMC */
> -&usdhc1 {
> -	no-1-8-v;
> -};
> -
> -/* SD-Card */
> -&usdhc2 {
> -	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> -	pinctrl-0 = <&pinctrl_usdhc2_default>, <&pinctrl_usdhc2_cd>;
> -	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_cd>;
> -	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_cd>;
> -	bus-width = <4>;
> -	cd-gpios = <&gpio3 0 GPIO_ACTIVE_LOW>;
> -	no-mmc;
> -	no-sdio;
> -	vmmc-supply = <&reg_usdhc2_vmmc>;
> -	status = "okay";
> -};
> -
> -&iomuxc {
> -	pinctrl_uart1: uart1grp {
> -		fsl,pins = <
> -			MX93_PAD_UART1_RXD__LPUART1_RX		0x31e
> -			MX93_PAD_UART1_TXD__LPUART1_TX		0x30e
> -		>;
> -	};
> -
> -	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
> -		fsl,pins = <
> -			MX93_PAD_SD2_RESET_B__GPIO3_IO07	0x31e
> -		>;
> -	};
> -
> -	pinctrl_usdhc2_cd: usdhc2cdgrp {
> -		fsl,pins = <
> -			MX93_PAD_SD2_CD_B__GPIO3_IO00		0x31e
> -		>;
> -	};
> -
> -	pinctrl_usdhc2_default: usdhc2grp {
> -		fsl,pins = <
> -			MX93_PAD_SD2_CLK__USDHC2_CLK		0x179e
> -			MX93_PAD_SD2_CMD__USDHC2_CMD		0x139e
> -			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x138e
> -			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x138e
> -			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x138e
> -			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x139e
> -			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
> -		>;
> -	};
> -
> -	pinctrl_usdhc2_100mhz: usdhc2grp {
> -		fsl,pins = <
> -			MX93_PAD_SD2_CLK__USDHC2_CLK            0x179e
> -			MX93_PAD_SD2_CMD__USDHC2_CMD            0x139e
> -			MX93_PAD_SD2_DATA0__USDHC2_DATA0        0x138e
> -			MX93_PAD_SD2_DATA1__USDHC2_DATA1        0x138e
> -			MX93_PAD_SD2_DATA2__USDHC2_DATA2        0x139e
> -			MX93_PAD_SD2_DATA3__USDHC2_DATA3        0x139e
> -			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT    0x51e
> -		>;
> -	};
> -
> -	pinctrl_usdhc2_200mhz: usdhc2grp {
> -		fsl,pins = <
> -			MX93_PAD_SD2_CLK__USDHC2_CLK            0x178e
> -			MX93_PAD_SD2_CMD__USDHC2_CMD            0x139e
> -			MX93_PAD_SD2_DATA0__USDHC2_DATA0        0x139e
> -			MX93_PAD_SD2_DATA1__USDHC2_DATA1        0x139e
> -			MX93_PAD_SD2_DATA2__USDHC2_DATA2        0x139e
> -			MX93_PAD_SD2_DATA3__USDHC2_DATA3        0x139e
> -			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT    0x51e
> -		>;
> -	};
> -};
> diff --git a/arch/arm/dts/imx93-phycore-som.dtsi b/arch/arm/dts/imx93-phycore-som.dtsi
> deleted file mode 100644
> index 88c2657b50e6..000000000000
> --- a/arch/arm/dts/imx93-phycore-som.dtsi
> +++ /dev/null
> @@ -1,126 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (C) 2023 PHYTEC Messtechnik GmbH
> - * Author: Wadim Egorov <w.egorov@phytec.de>, Christoph Stoidner <c.stoidner@phytec.de>
> - * Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
> - *
> - * Product homepage:
> - * https://www.phytec.eu/en/produkte/system-on-modules/phycore-imx-91-93/
> - */
> -
> -#include <dt-bindings/leds/common.h>
> -
> -#include "imx93.dtsi"
> -
> -/{
> -	model = "PHYTEC phyCORE-i.MX93";
> -	compatible = "phytec,imx93-phycore-som", "fsl,imx93";
> -
> -	reserved-memory {
> -		ranges;
> -		#address-cells = <2>;
> -		#size-cells = <2>;
> -
> -		linux,cma {
> -			compatible = "shared-dma-pool";
> -			reusable;
> -			alloc-ranges = <0 0x80000000 0 0x40000000>;
> -			size = <0 0x10000000>;
> -			linux,cma-default;
> -		};
> -	};
> -
> -	leds {
> -		compatible = "gpio-leds";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pinctrl_leds>;
> -
> -		led-0 {
> -			color = <LED_COLOR_ID_GREEN>;
> -			function = LED_FUNCTION_HEARTBEAT;
> -			gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
> -			linux,default-trigger = "heartbeat";
> -		};
> -	};
> -};
> -
> -/* Ethernet */
> -&fec {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_fec>;
> -	phy-mode = "rmii";
> -	phy-handle = <&ethphy1>;
> -	fsl,magic-packet;
> -	assigned-clocks = <&clk IMX93_CLK_ENET_TIMER1>,
> -			  <&clk IMX93_CLK_ENET_REF>,
> -			  <&clk IMX93_CLK_ENET_REF_PHY>;
> -	assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
> -				 <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
> -				 <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
> -	assigned-clock-rates = <100000000>, <50000000>, <50000000>;
> -	status = "okay";
> -
> -	mdio: mdio {
> -		clock-frequency = <5000000>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		ethphy1: ethernet-phy@1 {
> -			compatible = "ethernet-phy-ieee802.3-c22";
> -			reg = <1>;
> -		};
> -	};
> -};
> -
> -/* eMMC */
> -&usdhc1 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_usdhc1>;
> -	bus-width = <8>;
> -	non-removable;
> -	status = "okay";
> -};
> -
> -/* Watchdog */
> -&wdog3 {
> -	status = "okay";
> -};
> -
> -&iomuxc {
> -	pinctrl_fec: fecgrp {
> -		fsl,pins = <
> -			MX93_PAD_ENET2_MDC__ENET1_MDC			0x50e
> -			MX93_PAD_ENET2_MDIO__ENET1_MDIO			0x502
> -			MX93_PAD_ENET2_RD0__ENET1_RGMII_RD0		0x57e
> -			MX93_PAD_ENET2_RD1__ENET1_RGMII_RD1		0x57e
> -			MX93_PAD_ENET2_RXC__ENET1_RX_ER			0x5fe
> -			MX93_PAD_ENET2_RX_CTL__ENET1_RGMII_RX_CTL	0x57e
> -			MX93_PAD_ENET2_TD0__ENET1_RGMII_TD0		0x50e
> -			MX93_PAD_ENET2_TD1__ENET1_RGMII_TD1		0x50e
> -			MX93_PAD_ENET2_TX_CTL__ENET1_RGMII_TX_CTL	0x50e
> -			MX93_PAD_ENET2_TD2__ENET1_TX_CLK		0x4000050e
> -		>;
> -	};
> -
> -	pinctrl_leds: ledsgrp {
> -		fsl,pins = <
> -			MX93_PAD_I2C1_SDA__GPIO1_IO01		0x31e
> -		>;
> -	};
> -
> -	pinctrl_usdhc1: usdhc1grp {
> -		fsl,pins = <
> -			MX93_PAD_SD1_CLK__USDHC1_CLK		0x179e
> -			MX93_PAD_SD1_CMD__USDHC1_CMD		0x1386
> -			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x138e
> -			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x1386
> -			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x138e
> -			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x1386
> -			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x1386
> -			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x1386
> -			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x1386
> -			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x1386
> -			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x179e
> -		>;
> -	};
> -};
> diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
> index 0fd82dc08110..e6cafdcd8133 100644
> --- a/arch/arm/mach-imx/imx9/Kconfig
> +++ b/arch/arm/mach-imx/imx9/Kconfig
> @@ -73,6 +73,7 @@ config TARGET_PHYCORE_IMX93
>  	bool "phycore_imx93"
>  	select IMX93
>  	select IMX9_LPDDR4X
> +	imply OF_UPSTREAM
>  	select OF_BOARD_FIXUP
>  	select OF_BOARD_SETUP
>  
> diff --git a/board/phytec/phycore_imx93/MAINTAINERS b/board/phytec/phycore_imx93/MAINTAINERS
> index 718f89a084a2..7393061707de 100644
> --- a/board/phytec/phycore_imx93/MAINTAINERS
> +++ b/board/phytec/phycore_imx93/MAINTAINERS
> @@ -3,8 +3,6 @@ M:      Mathieu Othacehe <m.othacehe@gmail.com>
>  R:      Christoph Stoidner <c.stoidner@phytec.de>
>  W:      https://www.phytec.eu/en/produkte/system-on-modules/phycore-imx-91-93/
>  S:      Maintained
> -F:      arch/arm/dts/imx93-phyboard-segin.dts
> -F:      arch/arm/dts/imx93-phycore-som.dtsi
>  F:      arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
>  F:      board/phytec/phycore_imx93/
>  F:      board/phytec/common/imx93_som_detection.c
> diff --git a/configs/imx93-phycore_defconfig b/configs/imx93-phycore_defconfig
> index 7187fd708333..66a431244b0e 100644
> --- a/configs/imx93-phycore_defconfig
> +++ b/configs/imx93-phycore_defconfig
> @@ -12,7 +12,7 @@ CONFIG_ENV_SIZE=0x10000
>  CONFIG_ENV_OFFSET=0x700000
>  CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/imximage.cfg"
>  CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="imx93-phyboard-segin"
> +CONFIG_DEFAULT_DEVICE_TREE="freescale/imx93-phyboard-segin"
>  CONFIG_AHAB_BOOT=y
>  CONFIG_TARGET_PHYCORE_IMX93=y
>  CONFIG_OF_LIBFDT_OVERLAY=y
> -- 
> 2.34.1
> 
