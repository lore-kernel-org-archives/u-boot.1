Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8983C4167B
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 12:04:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2A8887CA9;
	Tue, 31 Oct 2023 13:04:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VjAjn1Cy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 810B287CA7; Tue, 31 Oct 2023 13:04:11 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46535875F0
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 13:04:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39VC456g065826;
 Tue, 31 Oct 2023 07:04:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698753845;
 bh=Ms6vw/gj7WGJyCw+ZYOX1njUrMN5jnzFaOQFp3+gGTw=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=VjAjn1CyXf7SKt0SAXxMh4dmYF/DWfWrPHeb3rLImkO+yOmJsJiPdglRIYtDEUMfZ
 ehbCg5k6w4aswmhP33eKO6MH0QIgjHbVc6P5Dhy0smUaNSMc6Cl1dLyz/nxpOVw7HC
 vET0mNQzzibITaHua06Qpi3x77AO/ZNWELTYTROo=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39VC45Wb089291
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 31 Oct 2023 07:04:05 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 31
 Oct 2023 07:04:05 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 31 Oct 2023 07:04:05 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39VC45Jd074751;
 Tue, 31 Oct 2023 07:04:05 -0500
Date: Tue, 31 Oct 2023 07:04:05 -0500
From: Nishanth Menon <nm@ti.com>
To: Nitin Yadav <n-yadav@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 2/4] arm: dts: Add support for AM62x LP SK
Message-ID: <20231031120405.t3g4tdkvj7vwl5vx@skype>
References: <20231030110138.1347603-1-n-yadav@ti.com>
 <20231030110138.1347603-3-n-yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231030110138.1347603-3-n-yadav@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 16:31-20231030, Nitin Yadav wrote:
> The AM62x LP SK board is similar to the AM62x SK board,
> but has some significant changes that requires different
> device tree.
> 
> The differences are mainly:
> - AM62x SoC in the AMC package that meets AECQ100 automotive standard.
> - LPDDR4 versus DDR4 on the AM62x SK.
> - TPS65219 PMIC instead of discrete regulators.
> - IO expander pin names are wired differently.

IO expander pins are wired differently

> - Second ethernet port is currently disabled as the boards do not have
>   the part physically installed.

Not sure I understand this. does this mean, it will be physically
installed later?

> - OSPI NAND vs OSPI NOR.

Which one is it on LP?

> - No WLAN chip instead a SDIO M.2 connector.

Please use complete sentence.
> 
> Sk-AM62-LP: https://www.ti.com/lit/zip/sprr471

Why not use https://www.ti.com/tool/SK-AM62-LP ?

> 
> Switch to binman for building bootloader images. Reuse
> k3-am625-sk-binman and override the dtb names to that
> of AM62x LP SK board.

Drop this paragraph. There is nothing to switch to since we are
already using binman for am62x.

> 

Please document in commit message which rev of kernel we picked
arch/arm/dts/k3-am62-lp-sk.dts from.

> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
> ---
>  arch/arm/dts/Makefile                         |    2 +
>  arch/arm/dts/k3-am62-lp-sk-u-boot.dtsi        |   32 +
>  arch/arm/dts/k3-am62-lp-sk.dts                |  231 ++
>  arch/arm/dts/k3-am62-r5-lp-sk.dts             |   12 +
>  arch/arm/dts/k3-am62x-ddr-lp4-50-800-800.dtsi | 2190 +++++++++++++++++
>  5 files changed, 2467 insertions(+)
>  create mode 100644 arch/arm/dts/k3-am62-lp-sk-u-boot.dtsi
>  create mode 100644 arch/arm/dts/k3-am62-lp-sk.dts
>  create mode 100644 arch/arm/dts/k3-am62-r5-lp-sk.dts
>  create mode 100644 arch/arm/dts/k3-am62x-ddr-lp4-50-800-800.dtsi
> 
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index bde2176ec7..72ea57885f 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -1337,6 +1337,8 @@ dtb-$(CONFIG_SOC_K3_AM642) += k3-am642-evm.dtb \
>  
>  dtb-$(CONFIG_SOC_K3_AM625) += k3-am625-sk.dtb \
>  			      k3-am625-r5-sk.dtb \
> +			      k3-am62-lp-sk.dtb \
> +			      k3-am62-r5-lp-sk.dtb \
>  			      k3-am625-beagleplay.dtb \
>  			      k3-am625-r5-beagleplay.dtb \
>  			      k3-am625-verdin-wifi-dev.dtb \
> diff --git a/arch/arm/dts/k3-am62-lp-sk-u-boot.dtsi b/arch/arm/dts/k3-am62-lp-sk-u-boot.dtsi
> new file mode 100644
> index 0000000000..721865371d
> --- /dev/null
> +++ b/arch/arm/dts/k3-am62-lp-sk-u-boot.dtsi
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AM62x LP SK dts file for SPLs
> + * Copyright (C) 2021-2023 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +#include "k3-am62x-sk-common-u-boot.dtsi"
> +
> +#include "k3-am625-sk-binman.dtsi"
> +
> +#ifdef CONFIG_TARGET_AM625_A53_EVM
> +
> +#define SPL_AM62_LP_SK_DTB "spl/dts/k3-am62-lp-sk.dtb"
> +#define AM62_LP_SK_DTB "u-boot.dtb"
> +
> +&spl_am625_sk_dtb_unsigned {
> +	filename = SPL_AM62_LP_SK_DTB;
> +};
> +
> +&am625_sk_dtb_unsigned {
> +	filename = AM62_LP_SK_DTB;
> +};
> +
> +&spl_am625_sk_dtb {
> +	filename = SPL_AM62_LP_SK_DTB;
> +};
> +
> +&am625_sk_dtb {
> +	filename = AM62_LP_SK_DTB;
> +};
> +

Don't you need bootph params for the PMIC OR the mmc voltage regulator?

> +#endif
> diff --git a/arch/arm/dts/k3-am62-lp-sk.dts b/arch/arm/dts/k3-am62-lp-sk.dts
> new file mode 100644
> index 0000000000..5e6feb8cd1
> --- /dev/null
> +++ b/arch/arm/dts/k3-am62-lp-sk.dts
> @@ -0,0 +1,231 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AM62x LP SK: https://www.ti.com/tool/SK-AM62-LP
> + *
> + * Copyright (C) 2021-2023 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +/dts-v1/;
> +
> +#include "k3-am62x-sk-common.dtsi"
> +
> +/ {
> +	compatible = "ti,am62-lp-sk", "ti,am625";
> +	model = "Texas Instruments AM62x LP SK";
> +
> +	vmain_pd: regulator-0 {
> +		/* TPS65988 PD CONTROLLER OUTPUT */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vmain_pd";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vcc_5v0: regulator-1 {
> +		/* Output of TPS630702RNMR */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_5v0";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vmain_pd>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vcc_3v3_sys: regulator-2 {
> +		/* output of LM61460-Q1 */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_3v3_sys";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vmain_pd>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vdd_mmc1: regulator-3 {
> +		/* TPS22918DBVR */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd_mmc1";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		enable-active-high;
> +		vin-supply = <&vcc_3v3_sys>;
> +		gpio = <&exp1 3 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	vddshv_sdio: regulator-4 {
> +		compatible = "regulator-gpio";
> +		regulator-name = "vddshv_sdio";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vddshv_sdio_pins_default>;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		vin-supply = <&ldo1_reg>;
> +		gpios = <&main_gpio0 31 GPIO_ACTIVE_HIGH>;
> +		states = <1800000 0x0>,
> +			 <3300000 0x1>;
> +	};
> +};
> +
> +&main_pmx0 {
> +	vddshv_sdio_pins_default: vddshv-sdio-default-pins {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x07c, PIN_OUTPUT, 7) /* (M19) GPMC0_CLK.GPIO0_31 */
> +		>;
> +	};
> +
> +	main_gpio1_ioexp_intr_pins_default: main-gpio1-ioexp-intr-default-pins {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x01d4, PIN_INPUT, 7) /* (C13) UART0_RTSn.GPIO1_23 */
> +		>;
> +	};
> +
> +	pmic_irq_pins_default: pmic-irq-default-pins {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x01f4, PIN_INPUT, 0) /* (B16) EXTINTn */
> +		>;
> +	};
> +};
> +
> +&main_i2c1 {
> +	exp1: gpio@22 {
> +		compatible = "ti,tca6424";
> +		reg = <0x22>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		gpio-line-names = "GPIO_CPSW2_RST", "GPIO_CPSW1_RST",
> +				   "PRU_DETECT", "MMC1_SD_EN",
> +				   "VPP_LDO_EN", "EXP_PS_3V3_En",
> +				   "EXP_PS_5V0_En", "EXP_HAT_DETECT",
> +				   "GPIO_AUD_RSTn", "GPIO_eMMC_RSTn",
> +				   "UART1_FET_BUF_EN", "BT_UART_WAKE_SOC",
> +				   "GPIO_HDMI_RSTn", "CSI_GPIO0",
> +				   "CSI_GPIO1", "GPIO_OLDI_INT",
> +				   "HDMI_INTn", "TEST_GPIO2",
> +				   "MCASP1_FET_EN", "MCASP1_BUF_BT_EN",
> +				   "MCASP1_FET_SEL", "UART1_FET_SEL",
> +				   "", "IO_EXP_TEST_LED";
> +
> +		interrupt-parent = <&main_gpio1>;
> +		interrupts = <23 IRQ_TYPE_EDGE_FALLING>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&main_gpio1_ioexp_intr_pins_default>;
> +	};
> +
> +	exp2: gpio@23 {
> +		compatible = "ti,tca6424";
> +		reg = <0x23>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		gpio-line-names = "", "",
> +				   "", "",
> +				   "", "",
> +				   "", "",
> +				   "WL_LT_EN", "CSI_RSTz",
> +				   "", "",
> +				   "", "",
> +				   "", "",
> +				   "SPI0_FET_SEL", "SPI0_FET_OE",
> +				   "GPIO_OLDI_RSTn", "PRU_3V3_EN",
> +				   "", "",
> +				   "CSI_VLDO_SEL", "SOC_WLAN_SDIO_RST";
> +	};
> +};
> +
> +&sdhci1 {
> +	vmmc-supply = <&vdd_mmc1>;
> +	vqmmc-supply = <&vddshv_sdio>;
> +};
> +
> +&cpsw_port2 {
> +	status = "disabled";
> +};
> +
> +&main_i2c0 {
> +	tps65219: pmic@30 {
> +		compatible = "ti,tps65219";
> +		reg = <0x30>;
> +		buck1-supply = <&vcc_3v3_sys>;
> +		buck2-supply = <&vcc_3v3_sys>;
> +		buck3-supply = <&vcc_3v3_sys>;
> +		ldo1-supply = <&vcc_3v3_sys>;
> +		ldo2-supply = <&buck2_reg>;
> +		ldo3-supply = <&vcc_3v3_sys>;
> +		ldo4-supply = <&vcc_3v3_sys>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pmic_irq_pins_default>;
> +
> +		interrupt-parent = <&gic500>;
> +		interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
> +		ti,power-button;
> +
> +		regulators {
> +			buck1_reg: buck1 {
> +				regulator-name = "VDD_CORE";
> +				regulator-min-microvolt = <750000>;
> +				regulator-max-microvolt = <750000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck2_reg: buck2 {
> +				regulator-name = "VCC1V8_SYS";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck3_reg: buck3 {
> +				regulator-name = "VDD_LPDDR4";
> +				regulator-min-microvolt = <1100000>;
> +				regulator-max-microvolt = <1100000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo1_reg: ldo1 {
> +				regulator-name = "VDDSHV_SDIO";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +			};
> +
> +			ldo2_reg: ldo2 {
> +				regulator-name = "VDDAR_CORE";
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <850000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo3_reg: ldo3 {
> +				regulator-name = "VDDA_1V8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo4_reg: ldo4 {
> +				regulator-name = "VDD_1V2";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1200000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +};
> +
> +&tlv320aic3106 {
> +	DVDD-supply = <&buck2_reg>;
> +};
> diff --git a/arch/arm/dts/k3-am62-r5-lp-sk.dts b/arch/arm/dts/k3-am62-r5-lp-sk.dts
> new file mode 100644
> index 0000000000..9f4f454aec
> --- /dev/null
> +++ b/arch/arm/dts/k3-am62-r5-lp-sk.dts
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AM62x LP SK dts file for R5 SPL
> + * Copyright (C) 2021-2023 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +#include "k3-am62-lp-sk.dts"
> +#include "k3-am62x-ddr-lp4-50-800-800.dtsi"
> +#include "k3-am62-ddr.dtsi"
> +
> +#include "k3-am62-lp-sk-u-boot.dtsi"
> +#include "k3-am62x-r5-sk-common.dtsi"
> diff --git a/arch/arm/dts/k3-am62x-ddr-lp4-50-800-800.dtsi b/arch/arm/dts/k3-am62x-ddr-lp4-50-800-800.dtsi
> new file mode 100644
> index 0000000000..a0d0376608
> --- /dev/null
> +++ b/arch/arm/dts/k3-am62x-ddr-lp4-50-800-800.dtsi
> @@ -0,0 +1,2190 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * This file was generated with the
> + * AM62x SysConfig DDR Subsystem Register Configuration Tool v0.08.61
> + * Tue Mar 22 2022 17:03:08 GMT-0500 (Central Daylight Time)
> + * DDR Type: LPDDR4 (MT53E1G16D1FW-046 WT:A)
> + * F0 = 50MHz    F1 = 800MHz    F2 = 800MHz
> + * Density (per channel): 16Gb
> + * Number of Ranks: 1
> + */
> +
> +#define DDRSS_PLL_FHS_CNT 6
> +#define DDRSS_PLL_FREQUENCY_1 400000000
> +#define DDRSS_PLL_FREQUENCY_2 400000000
> +
[...]

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
