Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CFABC47422
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 10:24:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5637387BC6;
	Mon, 29 Jan 2024 11:24:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="YFfayrZu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C796C8784B; Mon, 29 Jan 2024 11:24:49 +0100 (CET)
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B43FA87BC6
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 11:24:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=primoz.fiser@norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com; 
 s=default;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=F7iHEBG/mgMlfZBxW8pHFOOgX54Dwv2Nl1mz3nTdbXE=; b=YFfayrZuVATaDDciBP7o6MBIfu
 9CQGBqo0MzJawEx4amiuQtkIiXA5ke2t8+El2jX7RX6U/lVjVYPDKxFM+eRzJRJqfmlZYaatd4ZAt
 3mrn1blP1IChZtPCnCBTSHYzp+cCDhIMscayqXVgvR1D74e8rNfaDOv4o5XnaV5Bfz/1Nl9Et6EtP
 ln0C2sL42Ch+omrf+t0W8XBt1bJCzN6nTLoIZC9l5P44q4WLOaCJF3aoVMm3DdE0SiN9rM8FjT3Iq
 SZkbgENi0rtVhhrWj0Ic1bjv+dHguNbI0zojxYWqRHCNnkYrYpCJQOVX4L3HsyASJFVPT49QDTUVc
 vaMnf6iw==;
Received: from [89.212.21.243] (port=56046 helo=[192.168.69.116])
 by cpanel.siel.si with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.96.2)
 (envelope-from <primoz.fiser@norik.com>) id 1rUOoi-0042gJ-19;
 Mon, 29 Jan 2024 11:24:39 +0100
Message-ID: <9f20708a-eefb-4a27-a413-8a9f5a472788@norik.com>
Date: Mon, 29 Jan 2024 11:24:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] board: phytec: phycore-imx93: Add
 phyBOARD-Segin-i.MX93 support
To: Mathieu Othacehe <othacehe@gnu.org>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, Wadim Egorov
 <w.egorov@phytec.de>, Yannic Moog <Y.Moog@phytec.de>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de
References: <20240125164503.32097-1-othacehe@gnu.org>
Content-Language: en-US
From: Primoz Fiser <primoz.fiser@norik.com>
Organization: Norik systems d.o.o.
In-Reply-To: <20240125164503.32097-1-othacehe@gnu.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id:
 primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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


Hi Mathieu,

thanks for fixing my remarks.

Here are just a few left for v4.


On 25. 01. 24 17:45, Mathieu Othacehe wrote:
> Add initial support for the PHYTEC phyBOARD-Segin-i.MX93 board based on
> the PHYTEC phyCORE-i.MX93 SoM.
> 
> Supported features:
> - 1GB LPDDR4 RAM
> - eMMC
> - external SD
> - debug UART
> - watchdog
> 
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
> ---
> Hello,
> 
> This new revision fixes the remarks of Primoz. It uses configuration and an
> environment files closer to what's inside the downstream project.
> 
> Thanks,
> 
> Mathieu
> 
> v2: https://lists.denx.de/pipermail/u-boot/2024-January/544396.html
> 
>  arch/arm/dts/Makefile                         |    3 +-
>  arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi |  293 ++++
>  arch/arm/dts/imx93-phyboard-segin.dts         |  117 ++
>  arch/arm/dts/imx93-phycore-som.dtsi           |  126 ++
>  arch/arm/mach-imx/imx9/Kconfig                |    6 +
>  board/phytec/phycore_imx93/Kconfig            |   13 +
>  board/phytec/phycore_imx93/MAINTAINERS        |   10 +
>  board/phytec/phycore_imx93/Makefile           |   14 +
>  board/phytec/phycore_imx93/lpddr4_timing.c    | 1546 +++++++++++++++++
>  board/phytec/phycore_imx93/phycore-imx93.c    |   42 +
>  board/phytec/phycore_imx93/phycore_imx93.env  |   85 +
>  board/phytec/phycore_imx93/spl.c              |  150 ++
>  configs/imx93-phyboard-segin_defconfig        |  149 ++
>  doc/board/phytec/imx93-phyboard-segin.rst     |   61 +
>  doc/board/phytec/index.rst                    |    1 +
>  include/configs/phycore_imx93.h               |   28 +
>  16 files changed, 2643 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
>  create mode 100644 arch/arm/dts/imx93-phyboard-segin.dts
>  create mode 100644 arch/arm/dts/imx93-phycore-som.dtsi
>  create mode 100644 board/phytec/phycore_imx93/Kconfig
>  create mode 100644 board/phytec/phycore_imx93/MAINTAINERS
>  create mode 100644 board/phytec/phycore_imx93/Makefile
>  create mode 100644 board/phytec/phycore_imx93/lpddr4_timing.c
>  create mode 100644 board/phytec/phycore_imx93/phycore-imx93.c
>  create mode 100644 board/phytec/phycore_imx93/phycore_imx93.env
>  create mode 100644 board/phytec/phycore_imx93/spl.c
>  create mode 100644 configs/imx93-phyboard-segin_defconfig
>  create mode 100644 doc/board/phytec/imx93-phyboard-segin.rst
>  create mode 100644 include/configs/phycore_imx93.h
> 
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index d456a524b36..e7687a1b57d 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -1127,7 +1127,8 @@ dtb-$(CONFIG_ARCH_IMX8M) += \
>  
>  dtb-$(CONFIG_ARCH_IMX9) += \
>  	imx93-11x11-evk.dtb \
> -	imx93-var-som-symphony.dtb
> +	imx93-var-som-symphony.dtb \
> +	imx93-phyboard-segin.dtb
>  
>  dtb-$(CONFIG_ARCH_IMXRT) += imxrt1050-evk.dtb \
>  	imxrt1020-evk.dtb \
> diff --git a/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi b/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
> new file mode 100644
> index 00000000000..c194b009274
> --- /dev/null
> +++ b/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
> @@ -0,0 +1,293 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2023 PHYTEC Messtechnik GmbH
> + * Christoph Stoidner <c.stoidner@phytec.de>
> + *
> + * Product homepage:
> + * phyBOARD-Segin carrier board is reused for the i.MX93 design.
> + * https://www.phytec.eu/en/produkte/single-board-computer/phyboard-segin-imx6ul/
> + */
> +
> +#include "imx93-u-boot.dtsi"
> +
> +/ {
> +	wdt-reboot {
> +		compatible = "wdt-reboot";
> +		wdt = <&wdog3>;
> +		bootph-pre-ram;
> +		bootph-some-ram;
> +	};
> +
> +	aliases {
> +		ethernet0 = &eqos;
> +		ethernet1 = &fec;

Please make "fec" the primary eth interface here, like so:

	aliases {
		ethernet0 = &fec;
		ethernet1 = &eqos;
	};

Reason: FEC's phy is on the SoM while EQOS' phy is on the base-board. To
reuse phycore-imx93 code between multiple base-boards PHYTEC prefers to
make the SoM's eth interface the primary one.


> +	};
> +
> +	firmware {
> +		optee {
> +			compatible = "linaro,optee-tz";
> +			method = "smc";
> +		};
> +	};
> +};
> +
> +&{/soc@0} {
> +	bootph-all;
> +	bootph-pre-ram;
> +};
> +
> +&aips1 {
> +	bootph-pre-ram;
> +	bootph-all;
> +};
> +
> +&aips2 {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&aips3 {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&iomuxc {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&reg_usdhc2_vmmc {
> +	u-boot,off-on-delay-us = <20000>;
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&pinctrl_reg_usdhc2_vmmc {
> +	bootph-pre-ram;
> +};
> +
> +&pinctrl_uart1 {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&pinctrl_usdhc1 {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&pinctrl_usdhc2_cd {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&pinctrl_usdhc2_default {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&pinctrl_usdhc2_100mhz {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&pinctrl_usdhc2_200mhz {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&gpio1 {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&gpio2 {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&gpio3 {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&gpio4 {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&lpuart1 {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&usdhc1 {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&usdhc2 {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +	fsl,signal-voltage-switch-extra-delay-ms = <8>;
> +};
> +
> +&lpi2c1 {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&lpi2c2 {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&lpi2c3 {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&s4muap {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +	status = "okay";
> +};
> +
> +&clk {
> +	bootph-all;
> +	bootph-pre-ram;
> +	/delete-property/ assigned-clocks;
> +	/delete-property/ assigned-clock-rates;
> +	/delete-property/ assigned-clock-parents;
> +};
> +
> +&osc_32k {
> +	bootph-all;
> +	bootph-pre-ram;
> +};
> +
> +&osc_24m {
> +	bootph-all;
> +	bootph-pre-ram;
> +};
> +
> +&clk_ext1 {
> +	bootph-all;
> +	bootph-pre-ram;
> +};
> +
> +&wdog3 {
> +	bootph-all;
> +	bootph-pre-ram;
> +};
> +
> +/*
> + * The two nodes below won't be needed once nxp,pca9451a
> + * support is added to the Linux kernel.
> + */
> +&iomuxc {
> +	pinctrl_lpi2c3: lpi2c3grp {
> +	bootph-pre-ram;
> +	fsl,pins = <
> +		MX93_PAD_GPIO_IO28__LPI2C3_SDA			0x40000b9e
> +		MX93_PAD_GPIO_IO29__LPI2C3_SCL			0x40000b9e
> +	>;
> +	};
> +
> +	pinctrl_pmic: pmicgrp {
> +	bootph-pre-ram;
> +		fsl,pins = <
> +			MX93_PAD_ENET2_RD3__GPIO4_IO27			0x31e
> +		>;
> +	};
> +};
> +
> +&lpi2c3 {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&pinctrl_lpi2c3>;
> +	pinctrl-1 = <&pinctrl_lpi2c3>;
> +	status = "okay";
> +
> +	pmic@25 {
> +		bootph-pre-ram;
> +		bootph-some-ram;
> +		compatible = "nxp,pca9451a";
> +		reg = <0x25>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pmic>;
> +		interrupt-parent = <&gpio4>;
> +		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
> +
> +		regulators {
> +			bootph-pre-ram;
> +			bootph-some-ram;
> +			buck1: BUCK1 {
> +				regulator-name = "VDD_SOC";
> +				regulator-min-microvolt = <610000>;
> +				regulator-max-microvolt = <950000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <3125>;
> +			};
> +
> +			buck2: BUCK2 {
> +				regulator-name = "VDDQ_0V6";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <600000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck4: BUCK4 {
> +				regulator-name = "VDD_3V3_BUCK";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck5: BUCK5 {
> +				regulator-name = "VDD_1V8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck6: BUCK6 {
> +				regulator-name = "VDD_1V1";
> +				regulator-min-microvolt = <1100000>;
> +				regulator-max-microvolt = <1100000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo1: LDO1 {
> +				regulator-name = "PMIC_SNVS_1V8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo4: LDO4 {
> +				regulator-name = "VDD_0V8";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo5: LDO5 {
> +				regulator-name = "NVCC_SD2";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm/dts/imx93-phyboard-segin.dts b/arch/arm/dts/imx93-phyboard-segin.dts
> new file mode 100644
> index 00000000000..85fb188b057
> --- /dev/null
> +++ b/arch/arm/dts/imx93-phyboard-segin.dts
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2023 PHYTEC Messtechnik GmbH
> + * Author: Wadim Egorov <w.egorov@phytec.de>, Christoph Stoidner <c.stoidner@phytec.de>
> + * Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
> + *
> + * Product homepage:
> + * phyBOARD-Segin carrier board is reused for the i.MX93 design.
> + * https://www.phytec.eu/en/produkte/single-board-computer/phyboard-segin-imx6ul/
> + */
> +/dts-v1/;
> +
> +#include "imx93-phycore-som.dtsi"
> +
> +/{
> +	model = "PHYTEC phyBOARD-Segin-i.MX93";
> +	compatible = "phytec,imx93-phyboard-segin", "phytec,imx93-phycore-som",
> +		     "fsl,imx93";
> +
> +	chosen {
> +		stdout-path = &lpuart1;
> +	};
> +
> +	reg_usdhc2_vmmc: regulator-usdhc2 {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-name = "VCC_SD";
> +	};
> +};
> +
> +/* Console */
> +&lpuart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	status = "okay";
> +};
> +
> +/* eMMC */
> +&usdhc1 {
> +	no-1-8-v;
> +};
> +
> +/* SD-Card */
> +&usdhc2 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc2_default>, <&pinctrl_usdhc2_cd>;
> +	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_cd>;
> +	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_cd>;
> +	bus-width = <4>;
> +	cd-gpios = <&gpio3 0 GPIO_ACTIVE_LOW>;
> +	no-mmc;
> +	no-sdio;
> +	vmmc-supply = <&reg_usdhc2_vmmc>;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			MX93_PAD_UART1_RXD__LPUART1_RX		0x31e
> +			MX93_PAD_UART1_TXD__LPUART1_TX		0x30e
> +		>;
> +	};
> +
> +	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
> +		fsl,pins = <
> +			MX93_PAD_SD2_RESET_B__GPIO3_IO07	0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_cd: usdhc2cdgrp {
> +		fsl,pins = <
> +			MX93_PAD_SD2_CD_B__GPIO3_IO00		0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_default: usdhc2grp {
> +		fsl,pins = <
> +			MX93_PAD_SD2_CLK__USDHC2_CLK		0x179e
> +			MX93_PAD_SD2_CMD__USDHC2_CMD		0x139e
> +			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x138e
> +			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x138e
> +			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x138e
> +			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x139e
> +			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_100mhz: usdhc2grp {
> +		fsl,pins = <
> +			MX93_PAD_SD2_CLK__USDHC2_CLK            0x179e
> +			MX93_PAD_SD2_CMD__USDHC2_CMD            0x139e
> +			MX93_PAD_SD2_DATA0__USDHC2_DATA0        0x138e
> +			MX93_PAD_SD2_DATA1__USDHC2_DATA1        0x138e
> +			MX93_PAD_SD2_DATA2__USDHC2_DATA2        0x139e
> +			MX93_PAD_SD2_DATA3__USDHC2_DATA3        0x139e
> +			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT    0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_200mhz: usdhc2grp {
> +		fsl,pins = <
> +			MX93_PAD_SD2_CLK__USDHC2_CLK            0x178e
> +			MX93_PAD_SD2_CMD__USDHC2_CMD            0x139e
> +			MX93_PAD_SD2_DATA0__USDHC2_DATA0        0x139e
> +			MX93_PAD_SD2_DATA1__USDHC2_DATA1        0x139e
> +			MX93_PAD_SD2_DATA2__USDHC2_DATA2        0x139e
> +			MX93_PAD_SD2_DATA3__USDHC2_DATA3        0x139e
> +			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT    0x51e
> +		>;
> +	};
> +};
> diff --git a/arch/arm/dts/imx93-phycore-som.dtsi b/arch/arm/dts/imx93-phycore-som.dtsi
> new file mode 100644
> index 00000000000..88c2657b50e
> --- /dev/null
> +++ b/arch/arm/dts/imx93-phycore-som.dtsi
> @@ -0,0 +1,126 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2023 PHYTEC Messtechnik GmbH
> + * Author: Wadim Egorov <w.egorov@phytec.de>, Christoph Stoidner <c.stoidner@phytec.de>
> + * Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
> + *
> + * Product homepage:
> + * https://www.phytec.eu/en/produkte/system-on-modules/phycore-imx-91-93/
> + */
> +
> +#include <dt-bindings/leds/common.h>
> +
> +#include "imx93.dtsi"
> +
> +/{
> +	model = "PHYTEC phyCORE-i.MX93";
> +	compatible = "phytec,imx93-phycore-som", "fsl,imx93";
> +
> +	reserved-memory {
> +		ranges;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +
> +		linux,cma {
> +			compatible = "shared-dma-pool";
> +			reusable;
> +			alloc-ranges = <0 0x80000000 0 0x40000000>;
> +			size = <0 0x10000000>;
> +			linux,cma-default;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_leds>;
> +
> +		led-0 {
> +			color = <LED_COLOR_ID_GREEN>;
> +			function = LED_FUNCTION_HEARTBEAT;
> +			gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +};
> +
> +/* Ethernet */
> +&fec {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_fec>;
> +	phy-mode = "rmii";
> +	phy-handle = <&ethphy1>;
> +	fsl,magic-packet;
> +	assigned-clocks = <&clk IMX93_CLK_ENET_TIMER1>,
> +			  <&clk IMX93_CLK_ENET_REF>,
> +			  <&clk IMX93_CLK_ENET_REF_PHY>;
> +	assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
> +				 <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
> +				 <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
> +	assigned-clock-rates = <100000000>, <50000000>, <50000000>;
> +	status = "okay";
> +
> +	mdio: mdio {
> +		clock-frequency = <5000000>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy1: ethernet-phy@1 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <1>;
> +		};
> +	};
> +};
> +
> +/* eMMC */
> +&usdhc1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	bus-width = <8>;
> +	non-removable;
> +	status = "okay";
> +};
> +
> +/* Watchdog */
> +&wdog3 {
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_fec: fecgrp {
> +		fsl,pins = <
> +			MX93_PAD_ENET2_MDC__ENET1_MDC			0x50e
> +			MX93_PAD_ENET2_MDIO__ENET1_MDIO			0x502
> +			MX93_PAD_ENET2_RD0__ENET1_RGMII_RD0		0x57e
> +			MX93_PAD_ENET2_RD1__ENET1_RGMII_RD1		0x57e
> +			MX93_PAD_ENET2_RXC__ENET1_RX_ER			0x5fe
> +			MX93_PAD_ENET2_RX_CTL__ENET1_RGMII_RX_CTL	0x57e
> +			MX93_PAD_ENET2_TD0__ENET1_RGMII_TD0		0x50e
> +			MX93_PAD_ENET2_TD1__ENET1_RGMII_TD1		0x50e
> +			MX93_PAD_ENET2_TX_CTL__ENET1_RGMII_TX_CTL	0x50e
> +			MX93_PAD_ENET2_TD2__ENET1_TX_CLK		0x4000050e
> +		>;
> +	};
> +
> +	pinctrl_leds: ledsgrp {
> +		fsl,pins = <
> +			MX93_PAD_I2C1_SDA__GPIO1_IO01		0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins = <
> +			MX93_PAD_SD1_CLK__USDHC1_CLK		0x179e
> +			MX93_PAD_SD1_CMD__USDHC1_CMD		0x1386
> +			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x138e
> +			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x1386
> +			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x138e
> +			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x1386
> +			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x1386
> +			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x1386
> +			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x1386
> +			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x1386
> +			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x179e
> +		>;
> +	};
> +};
> diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
> index 961d6f527ab..b79485f1f75 100644
> --- a/arch/arm/mach-imx/imx9/Kconfig
> +++ b/arch/arm/mach-imx/imx9/Kconfig
> @@ -37,9 +37,15 @@ config TARGET_IMX93_VAR_SOM
>  	select IMX93
>  	select IMX9_LPDDR4X
>  
> +config TARGET_PHYCORE_IMX93
> +	bool "phycore_imx93"
> +	select IMX93
> +	select IMX9_LPDDR4X
> +
>  endchoice
>  
>  source "board/freescale/imx93_evk/Kconfig"
> +source "board/phytec/phycore_imx93/Kconfig"
>  source "board/variscite/imx93_var_som/Kconfig"
>  
>  endif
> diff --git a/board/phytec/phycore_imx93/Kconfig b/board/phytec/phycore_imx93/Kconfig
> new file mode 100644
> index 00000000000..a70104cb798
> --- /dev/null
> +++ b/board/phytec/phycore_imx93/Kconfig
> @@ -0,0 +1,13 @@
> +
> +if TARGET_PHYCORE_IMX93
> +
> +config SYS_BOARD
> +	default "phycore_imx93"
> +
> +config SYS_VENDOR
> +	default "phytec"
> +
> +config SYS_CONFIG_NAME
> +	default "phycore_imx93"
> +
> +endif
> diff --git a/board/phytec/phycore_imx93/MAINTAINERS b/board/phytec/phycore_imx93/MAINTAINERS
> new file mode 100644
> index 00000000000..9e91a29dc31
> --- /dev/null
> +++ b/board/phytec/phycore_imx93/MAINTAINERS
> @@ -0,0 +1,10 @@
> +phyCORE-i.MX93
> +M:	Mathieu Othacehe <m.othacehe@gmail.com>
> +W:      https://www.phytec.eu/en/produkte/system-on-modules/phycore-imx-91-93/
> +S:      Maintained
> +F:      arch/arm/dts/imx93-phyboard-segin.dts
> +F:      arch/arm/dts/imx93-phycore-som.dtsi
> +F:      arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
> +F:      board/phytec/phycore_imx93/
> +F:      configs/imx93-phyboard-segin_defconfig
> +F:      include/configs/phycore_imx93.h
> diff --git a/board/phytec/phycore_imx93/Makefile b/board/phytec/phycore_imx93/Makefile
> new file mode 100644
> index 00000000000..ce35326a156
> --- /dev/null
> +++ b/board/phytec/phycore_imx93/Makefile
> @@ -0,0 +1,14 @@
> +#
> +# Copyright 2022 NXP
> +# Copyright (C) 2023 PHYTEC Messtechnik GmbH
> +# Christoph Stoidner <c.stoidner@phytec.de>
> +# Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
> +#
> +# SPDX-License-Identifier:      GPL-2.0+
> +#
> +
> +obj-y += phycore-imx93.o
> +
> +ifdef CONFIG_SPL_BUILD
> +obj-y += spl.o lpddr4_timing.o
> +endif
> diff --git a/board/phytec/phycore_imx93/lpddr4_timing.c b/board/phytec/phycore_imx93/lpddr4_timing.c
> new file mode 100644
> index 00000000000..2111972a40e
> --- /dev/null
> +++ b/board/phytec/phycore_imx93/lpddr4_timing.c
> @@ -0,0 +1,1546 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2023 NXP
> + * Copyright (C) 2023 PHYTEC Messtechnik GmbH
> + * Christoph Stoidner <c.stoidner@phytec.de>
> + *
> + * Code generated with DDR Tool v1.0.0.
> + */
> +
> +#include <linux/kernel.h>
> +#include <asm/arch/ddr.h>
> +
> +static struct dram_cfg_param ddr_ddrc_cfg[] = {
> +	/** Initialize DDRC registers **/
> +	{0x4e300110, 0x44100001},
> +	{0x4e300000, 0x8000bf},
> +	{0x4e300008, 0x0},

<snip>

> +	.fsp_cfg_num = ARRAY_SIZE(ddr_dram_fsp_cfg),
> +};
> diff --git a/board/phytec/phycore_imx93/phycore-imx93.c b/board/phytec/phycore_imx93/phycore-imx93.c
> new file mode 100644
> index 00000000000..085c8e195a6
> --- /dev/null
> +++ b/board/phytec/phycore_imx93/phycore-imx93.c
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2023 PHYTEC Messtechnik GmbH
> + * Author: Christoph Stoidner <c.stoidner@phytec.de>
> + * Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
> + */
> +
> +#include <asm/arch-imx9/ccm_regs.h>
> +#include <asm/arch/sys_proto.h>
> +#include <asm/arch-imx9/imx93_pins.h>
> +#include <asm/arch/clock.h>
> +#include <asm/global_data.h>
> +#include <asm/mach-imx/boot_mode.h>
> +#include <env.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +int board_init(void)
> +{
> +	return 0;
> +}
> +
> +int board_mmc_get_env_dev(int devno)
> +{
> +	return devno;
> +}
> +
> +int board_late_init(void)
> +{
> +	switch (get_boot_device()) {
> +	case SD2_BOOT:
> +		env_set_ulong("mmcdev", 1);
> +		break;
> +	case MMC1_BOOT:
> +		env_set_ulong("mmcdev", 0);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> diff --git a/board/phytec/phycore_imx93/phycore_imx93.env b/board/phytec/phycore_imx93/phycore_imx93.env
> new file mode 100644
> index 00000000000..464935ba567
> --- /dev/null
> +++ b/board/phytec/phycore_imx93/phycore_imx93.env
> @@ -0,0 +1,85 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +
> +image=Image
> +console=ttyLP0
> +fdt_addr=0x83000000
> +fdto_addr=0x830c0000
> +bootenv_addr=0x83500000
> +fdt_file=undefined

Can you set fdt_file to CONFIG_DEFAULT_FDT_FILE like it was in v2?

> +ipaddr=192.168.3.11
> +serverip=192.168.3.10
> +netmask=255.255.255.0

I saw Fabio's request to remove static IP configuration.

When you remove it, please

> +ip_dyn=no

set ip_dyn=yes.

> +bootenv=bootenv.txt
> +prepare_mcore=setenv mcore_clk clk-imx93.mcore_booted;

Please remove prepare_mcore. This only applies to vendor u-boot-imx.

> +mmc_load_bootenv=fatload mmc ${mmcdev}:${mmcpart} ${bootenv_addr} ${bootenv}
> +sd_dev=1
> +emmc_dev=0

Please remove sd_dev and emmc_dev. They were not in the v2 and only
apply to vendor u-boot (uuu).

> +mmcdev=1

Please set:

mmcdev=__stringify(CONFIG_SYS_MMC_ENV_DEV)

like in v2.

> +mmcpart=1
> +mmcroot=2
> +mmcautodetect=yes
> +mmcargs=setenv bootargs ${mcore_clk} console=${console},${baudrate} earlycon
> +	root=/dev/mmcblk${mmcdev}p${mmcroot} ${raucargs} rootwait rw

Drop mcore_clk from mmcargs like in v2.

> +loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
> +findfdt=if test $fdt_file = undefined; then
> +            setenv fdt_file CONFIG_DEFAULT_FDT_FILE ;
> +        fi;
> +        echo fdt_file=${fdt_file};

Please remove findfdt script.

Not needed when you set fdt_file to CONFIG_DEFAULT_FDT_FILE above.

> +loadfdt=run findfdt;fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr} ${fdt_file}

Remove findfdt from loadfdt.

> +mmc_load_overlay=fatload mmc ${mmcdev}:${mmcpart} ${fdto_addr} ${overlay}
> +mmc_apply_overlays=
> +	fdt address ${fdt_addr};
> +	for overlay in ${overlays};
> +	do;
> +		if run mmc_load_overlay; then
> +			fdt resize ${filesize};
> +			fdt apply ${fdto_addr};
> +		fi;
> +	done;
> +mmcboot=
> +	echo Booting from mmc ...;
> +	if run mmc_load_bootenv; then
> +		env import -t ${bootenv_addr} ${filesize};
> +	fi;
> +	run mmcargs;
> +	if run loadfdt; then
> +		run mmc_apply_overlays;
> +		booti ${loadaddr} - ${fdt_addr};
> +	else
> +		echo WARN: Cannot load the DT;
> +	fi;
> +nfsroot=/nfs
> +netargs=setenv bootargs ${mcore_clk} console=${console},${baudrate} earlycon
> +	root=/dev/nfs ip=${nfsip} nfsroot=${serverip}:${nfsroot},v3,tcp

Drop mcore_clk from netargs.

Also hardcode ip=dhcp since you cannot use static IP anymore in v4.


> +net_load_bootenv=${get_cmd} ${bootenv_addr} ${bootenv}
> +net_load_overlay=${get_cmd} ${fdto_addr} ${overlay}
> +net_apply_overlays=
> +	fdt address ${fdt_addr};
> +	for overlay in ${overlays};
> +	do;
> +		if run net_load_overlay; then
> +			fdt resize ${filesize};
> +			fdt apply ${fdto_addr};
> +		fi;
> +	done;
> +netboot=
> +	echo Booting from net ...;
> +	if test ${ip_dyn} = yes; then
> +		setenv nfsip dhcp;
> +		setenv get_cmd dhcp;
> +	else
> +		setenv nfsip ${ipaddr}:${serverip}::${netmask}::eth0:on;
> +		setenv get_cmd tftp;
> +	fi;
> +	if run net_load_bootenv; then
> +		env import -t ${bootenv_addr} ${filesize};
> +	fi;
> +	run netargs;
> +	${get_cmd} ${loadaddr} ${image};
> +	if ${get_cmd} ${fdt_addr} ${fdt_file}; then
> +		run net_apply_overlays;
> +		booti ${loadaddr} - ${fdt_addr};
> +	else
> +		echo WARN: Cannot load the DT;
> +	fi;

netboot script needs to be re-written when you remove static IP
configuration in v4.

Please make it something like this:

> netboot=
> 	echo Booting from net ...;
> 	run netargs;
> 	if test ${ip_dyn} = yes; then
> 		setenv get_cmd dhcp;
> 	else
> 		setenv get_cmd tftp;
> 	fi;
> 	if run net_load_bootenv; then
> 		env import -t ${bootenv_addr} ${filesize};
> 	fi;
> 	${get_cmd} ${loadaddr} ${image};
> 	if ${get_cmd} ${fdt_addr} ${fdt_file}; then
> 		run net_apply_overlays;
> 		booti ${loadaddr} - ${fdt_addr};
> 	else
> 		echo WARN: Cannot load the DT;
> 	fi;


Refer to phycore_imx8mm.h or phycore_imx8mp.h.


> diff --git a/board/phytec/phycore_imx93/spl.c b/board/phytec/phycore_imx93/spl.c
> new file mode 100644
> index 00000000000..efdcd60ef5f
> --- /dev/null
> +++ b/board/phytec/phycore_imx93/spl.c
> @@ -0,0 +1,150 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2023 PHYTEC Messtechnik GmbH
> + * Author: Christoph Stoidner <c.stoidner@phytec.de>
> + * Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
> + */
> +
> +#include <asm/arch/clock.h>
> +#include <asm/arch/ddr.h>
> +#include <asm/arch/sys_proto.h>
> +#include <asm/arch/trdc.h>
> +#include <asm/mach-imx/boot_mode.h>
> +#include <asm/sections.h>
> +#include <hang.h>
> +#include <init.h>
> +#include <log.h>
> +#include <power/pmic.h>
> +#include <power/pca9450.h>
> +#include <spl.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +/*
> + * Will be part of drivers/power/regulator/pca9450.c
> + * when pca9451a support is added.
> + */
> +#define PCA9450_REG_PWRCTRL_TOFF_DEB    BIT(5)
> +
> +#define EEPROM_ADDR            0x50
> +
> +int spl_board_boot_device(enum boot_device boot_dev_spl)
> +{
> +	return BOOT_DEVICE_BOOTROM;
> +}
> +
> +void spl_board_init(void)
> +{
> +	puts("Normal Boot\n");
> +}
> +
> +void spl_dram_init(void)
> +{
> +	ddr_init(&dram_timing);
> +}
> +
> +int power_init_board(void)
> +{
> +	struct udevice *dev;
> +	int ret;
> +	unsigned int val = 0;
> +
> +	ret = pmic_get("pmic@25", &dev);
> +	if (ret == -ENODEV) {
> +		puts("No pca9450@25\n");
> +		return 0;
> +	}
> +
> +	if (ret != 0)
> +		return ret;
> +
> +	/* BUCKxOUT_DVS0/1 control BUCK123 output */
> +	pmic_reg_write(dev, PCA9450_BUCK123_DVS, 0x29);
> +
> +	/* enable DVS control through PMIC_STBY_REQ */
> +	pmic_reg_write(dev, PCA9450_BUCK1CTRL, 0x59);
> +
> +	ret = pmic_reg_read(dev, PCA9450_PWR_CTRL);
> +	if (ret < 0)
> +		return ret;
> +	val = ret;
> +
> +	if (IS_ENABLED(CONFIG_IMX9_LOW_DRIVE_MODE)) {
> +		/* 0.8v for Low drive mode */
> +		if (val & PCA9450_REG_PWRCTRL_TOFF_DEB) {
> +			pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, 0x0c);
> +			pmic_reg_write(dev, PCA9450_BUCK3OUT_DVS0, 0x0c);
> +		} else {
> +			pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, 0x10);
> +			pmic_reg_write(dev, PCA9450_BUCK3OUT_DVS0, 0x10);
> +		}
> +	} else {
> +		/* 0.9v for Over drive mode */
> +		if (val & PCA9450_REG_PWRCTRL_TOFF_DEB) {
> +			pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, 0x14);
> +			pmic_reg_write(dev, PCA9450_BUCK3OUT_DVS0, 0x14);
> +		} else {
> +			pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, 0x18);
> +			pmic_reg_write(dev, PCA9450_BUCK3OUT_DVS0, 0x18);
> +		}
> +	}
> +
> +	/* set standby voltage to 0.65v */
> +	if (val & PCA9450_REG_PWRCTRL_TOFF_DEB)
> +		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS1, 0x0);
> +	else
> +		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS1, 0x4);
> +
> +	/* I2C_LT_EN*/
> +	pmic_reg_write(dev, 0xa, 0x3);
> +
> +	return 0;
> +}
> +
> +extern int imx9_probe_mu(void *ctx, struct event *event);
> +void board_init_f(ulong dummy)
> +{
> +	int ret;
> +
> +	/* Clear the BSS. */
> +	memset(__bss_start, 0, __bss_end - __bss_start);
> +
> +	timer_init();
> +
> +	arch_cpu_init();
> +
> +	spl_early_init();
> +
> +	preloader_console_init();
> +
> +	ret = imx9_probe_mu(NULL, NULL);
> +	if (ret) {
> +		printf("Fail to init ELE API\n");
> +	} else {
> +		printf("SOC: 0x%x\n", gd->arch.soc_rev);
> +		printf("LC: 0x%x\n", gd->arch.lifecycle);
> +	}
> +
> +	clock_init();
> +
> +	power_init_board();
> +
> +	if (!IS_ENABLED(CONFIG_IMX9_LOW_DRIVE_MODE))
> +		set_arm_core_max_clk();
> +
> +	/* Init power of mix */
> +	soc_power_init();
> +
> +	/* Setup TRDC for DDR access */
> +	trdc_init();
> +
> +	/* DDR initialization */
> +	spl_dram_init();
> +
> +	/* Put M33 into CPUWAIT for following kick */
> +	ret = m33_prepare();
> +	if (!ret)
> +		printf("M33 prepare ok\n");
> +
> +	board_init_r(NULL, 0);
> +}
> diff --git a/configs/imx93-phyboard-segin_defconfig b/configs/imx93-phyboard-segin_defconfig
> new file mode 100644
> index 00000000000..228f0aed61f
> --- /dev/null
> +++ b/configs/imx93-phyboard-segin_defconfig
> @@ -0,0 +1,149 @@

If I do:

make imx93-phyboard-segin_defconfig
make savedefconfig
cp defconfig configs/imx93-phyboard-segin_defconfig

I get a diff. Mostly reordering issues, but some options from downstream
u-boot like:

-CONFIG_PHYTEC_SOM_DETECTION

or

-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x83200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000

etc...

got included in v3.

Can you sort this out for v4, please?

BR,
Primoz

> +CONFIG_ARM=y
> +CONFIG_ARCH_IMX9=y
> +CONFIG_TEXT_BASE=0x80200000
> +CONFIG_SYS_MALLOC_LEN=0x2000000
> +CONFIG_SYS_MALLOC_F_LEN=0x20000
> +CONFIG_SPL_LIBCOMMON_SUPPORT=y
> +CONFIG_SPL_LIBGENERIC_SUPPORT=y
> +CONFIG_NR_DRAM_BANKS=2
> +CONFIG_ENV_SIZE=0x10000
> +CONFIG_ENV_OFFSET=0x700000
> +CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/imximage.cfg"
> +CONFIG_DM_GPIO=y
> +CONFIG_DEFAULT_DEVICE_TREE="imx93-phyboard-segin"
> +CONFIG_SPL_TEXT_BASE=0x2049A000
> +CONFIG_TARGET_PHYCORE_IMX93=y
> +CONFIG_PHYTEC_SOM_DETECTION=y
> +CONFIG_SYS_PROMPT="u-boot=> "
> +CONFIG_SPL_SERIAL=y
> +CONFIG_SPL_DRIVERS_MISC=y
> +CONFIG_SPL_STACK=0x20519dd0
> +CONFIG_SPL=y
> +CONFIG_ENV_OFFSET_REDUND=0x720000
> +CONFIG_CMD_DEKBLOB=y
> +CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x88000000
> +CONFIG_SPL_LOAD_IMX_CONTAINER=y
> +CONFIG_SYS_LOAD_ADDR=0x80400000
> +CONFIG_SYS_MEMTEST_START=0x80000000
> +CONFIG_SYS_MEMTEST_END=0x90000000
> +CONFIG_REMAKE_ELF=y
> +CONFIG_SYS_MONITOR_LEN=524288
> +# CONFIG_ANDROID_BOOT_IMAGE is not set
> +CONFIG_OF_SYSTEM_SETUP=y
> +CONFIG_DISTRO_DEFAULTS=y
> +CONFIG_BOOTCOMMAND="mmc dev ${mmcdev}; if mmc rescan; then if run loadimage; then run mmcboot; else run netboot; fi; fi;"
> +CONFIG_DEFAULT_FDT_FILE="oftree"
> +CONFIG_BOARD_LATE_INIT=y
> +CONFIG_SPL_MAX_SIZE=0x26000
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> +CONFIG_SPL_BSS_START_ADDR=0x2051a000
> +CONFIG_SPL_BSS_MAX_SIZE=0x2000
> +CONFIG_SPL_BOARD_INIT=y
> +CONFIG_SPL_BOOTROM_SUPPORT=y
> +CONFIG_IMX_CONTAINER_CFG="arch/arm/mach-imx/imx9/container.cfg"
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SYS_SPL_MALLOC=y
> +CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
> +CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x83200000
> +CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
> +CONFIG_SPL_I2C=y
> +CONFIG_SPL_POWER=y
> +CONFIG_SPL_WATCHDOG=y
> +CONFIG_SYS_MAXARGS=64
> +CONFIG_SYS_CBSIZE=2048
> +CONFIG_SYS_PBSIZE=2074
> +CONFIG_CMD_ERASEENV=y
> +CONFIG_CMD_NVEDIT_EFI=y
> +CONFIG_CRC32_VERIFY=y
> +CONFIG_CMD_EEPROM=y
> +CONFIG_SYS_I2C_EEPROM_BUS=2
> +CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
> +CONFIG_SYS_EEPROM_SIZE=4096
> +CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=5
> +CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=5
> +CONFIG_CMD_MEMTEST=y
> +CONFIG_CMD_CLK=y
> +CONFIG_CMD_DFU=y
> +CONFIG_CMD_FUSE=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_POWEROFF=y
> +CONFIG_CMD_SNTP=y
> +CONFIG_CMD_CACHE=y
> +CONFIG_CMD_EFIDEBUG=y
> +CONFIG_CMD_RTC=y
> +CONFIG_CMD_TIME=y
> +CONFIG_CMD_GETTIME=y
> +CONFIG_CMD_TIMER=y
> +CONFIG_CMD_REGULATOR=y
> +CONFIG_CMD_HASH=y
> +CONFIG_CMD_EXT4_WRITE=y
> +CONFIG_OF_CONTROL=y
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_ENV_SOURCE_FILE="phycore_imx93"
> +CONFIG_ENV_OVERWRITE=y
> +CONFIG_ENV_IS_NOWHERE=y
> +CONFIG_ENV_IS_IN_MMC=y
> +CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_SYS_MMC_ENV_DEV=1
> +CONFIG_USE_ETHPRIME=y
> +CONFIG_ETHPRIME="eth1"
> +CONFIG_NET_RANDOM_ETHADDR=y
> +CONFIG_SPL_DM=y
> +CONFIG_SYSCON=y
> +CONFIG_SPL_CLK_IMX93=y
> +CONFIG_CLK_IMX93=y
> +CONFIG_DFU_MMC=y
> +CONFIG_DFU_RAM=y
> +CONFIG_GPIO_HOG=y
> +CONFIG_IMX_RGPIO2P=y
> +CONFIG_DM_I2C=y
> +CONFIG_SYS_I2C_IMX_LPI2C=y
> +CONFIG_I2C_EEPROM=y
> +CONFIG_SYS_I2C_EEPROM_ADDR=0x50
> +CONFIG_SUPPORT_EMMC_BOOT=y
> +CONFIG_MMC_IO_VOLTAGE=y
> +CONFIG_MMC_UHS_SUPPORT=y
> +CONFIG_MMC_HS400_ES_SUPPORT=y
> +CONFIG_MMC_HS400_SUPPORT=y
> +CONFIG_FSL_USDHC=y
> +CONFIG_SF_DEFAULT_SPEED=40000000
> +CONFIG_SPI_FLASH_STMICRO=y
> +CONFIG_PHY_TI_GENERIC=y
> +CONFIG_DM_ETH_PHY=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_IMX=y
> +CONFIG_FEC_MXC=y
> +CONFIG_MII=y
> +CONFIG_PINCTRL=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_PINCTRL_IMX93=y
> +CONFIG_POWER_DOMAIN=y
> +CONFIG_IMX93_BLK_CTRL=y
> +CONFIG_DM_PMIC=y
> +CONFIG_DM_PMIC_PCA9450=y
> +CONFIG_SPL_DM_PMIC_PCA9450=y
> +CONFIG_DM_REGULATOR=y
> +CONFIG_DM_REGULATOR_PCA9450=y
> +CONFIG_DM_REGULATOR_FIXED=y
> +CONFIG_DM_REGULATOR_GPIO=y
> +CONFIG_DM_RTC=y
> +CONFIG_DM_SERIAL=y
> +CONFIG_FSL_LPUART=y
> +CONFIG_SPI=y
> +CONFIG_DM_SPI=y
> +CONFIG_NXP_FSPI=y
> +CONFIG_SYSRESET=y
> +CONFIG_SPL_SYSRESET=y
> +CONFIG_SYSRESET_WATCHDOG=y
> +CONFIG_DM_THERMAL=y
> +CONFIG_IMX_TMU=y
> +CONFIG_ULP_WATCHDOG=y
> +CONFIG_WDT=y
> +CONFIG_LZO=y
> +CONFIG_BZIP2=y
> +CONFIG_OF_LIBFDT_OVERLAY=y
> diff --git a/doc/board/phytec/imx93-phyboard-segin.rst b/doc/board/phytec/imx93-phyboard-segin.rst
> new file mode 100644
> index 00000000000..da8772ecd5c
> --- /dev/null
> +++ b/doc/board/phytec/imx93-phyboard-segin.rst
> @@ -0,0 +1,61 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +phyBOARD-Segin-i.MX93
> +=====================
> +
> +U-Boot for the phyBOARD-Segin-i.MX93.
> +
> +Quick Start
> +-----------
> +
> +- Get and Build the ARM Trusted firmware
> +- Get the DDR firmware
> +- Get ahab-container.img
> +- Build U-Boot
> +
> +Get and Build the ARM Trusted firmware
> +--------------------------------------
> +
> +Note: srctree is U-Boot source directory
> +Get ATF from: https://github.com/nxp-imx/imx-atf/
> +branch: lf_v2.8
> +
> +.. code-block:: bash
> +
> +   $ unset LDFLAGS
> +   $ make PLAT=imx93 bl31
> +   $ cp build/imx93/release/bl31.bin $(srctree)
> +
> +Get the DDR firmware
> +--------------------
> +
> +.. code-block:: bash
> +
> +   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.21.bin
> +   $ chmod +x firmware-imx-8.21.bin
> +   $ ./firmware-imx-8.21.bin
> +   $ cp firmware-imx-8.21/firmware/ddr/synopsys/lpddr4*.bin $(srctree)
> +
> +Get ahab-container.img
> +---------------------------------------
> +
> +.. code-block:: bash
> +
> +   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-sentinel-0.10.bin
> +   $ chmod +x firmware-sentinel-0.10.bin
> +   $ ./firmware-sentinel-0.10.bin
> +   $ cp firmware-sentinel-0.10/mx93a0-ahab-container.img $(srctree)
> +
> +Build U-Boot
> +------------
> +
> +.. code-block:: bash
> +
> +   $ make imx93-phyboard-segin_defconfig
> +   $ make
> +
> +Burn the flash.bin to MicroSD card offset 32KB:
> +
> +.. code-block:: bash
> +
> +   $ dd if=flash.bin of=/dev/sd[x] bs=1024 seek=32 conv=notrunc
> diff --git a/doc/board/phytec/index.rst b/doc/board/phytec/index.rst
> index 9996bce9741..b2833db684f 100644
> --- a/doc/board/phytec/index.rst
> +++ b/doc/board/phytec/index.rst
> @@ -7,5 +7,6 @@ PHYTEC
>     :maxdepth: 2
>  
>     imx8mm-phygate-tauri-l
> +   imx93-phyboard-segin
>     phycore-imx8mm
>     phycore-imx8mp
> diff --git a/include/configs/phycore_imx93.h b/include/configs/phycore_imx93.h
> new file mode 100644
> index 00000000000..07364dff403
> --- /dev/null
> +++ b/include/configs/phycore_imx93.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2022 NXP
> + * Copyright (C) 2023 PHYTEC Messtechnik GmbH
> + * Christoph Stoidner <c.stoidner@phytec.de>
> + * Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
> + */
> +
> +#ifndef __PHYCORE_IMX93_H
> +#define __PHYCORE_IMX93_H
> +
> +#include <linux/sizes.h>
> +#include <asm/arch/imx-regs.h>
> +
> +#define CFG_SYS_UBOOT_BASE	\
> +	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
> +
> +#define CFG_SYS_INIT_RAM_ADDR        0x80000000
> +#define CFG_SYS_INIT_RAM_SIZE        0x200000
> +
> +#define CFG_SYS_SDRAM_BASE           0x80000000
> +#define PHYS_SDRAM                   0x80000000
> +#define PHYS_SDRAM_SIZE              0x80000000
> +
> +/* Using ULP WDOG for reset */
> +#define WDOG_BASE_ADDR          WDG3_BASE_ADDR
> +
> +#endif /* __PHYCORE_IMX93_H */

-- 

