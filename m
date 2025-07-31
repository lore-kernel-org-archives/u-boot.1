Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D82A3C83F17
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 09:21:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2594083623;
	Thu, 31 Jul 2025 11:20:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="exSep3N8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90A14836AB; Thu, 31 Jul 2025 11:20:48 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83F9C83689
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 11:20:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0307a9198e=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56V89Y1a010749;
 Thu, 31 Jul 2025 11:20:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 3afVYuV6f3hTEhO0tRWIG0kUK5hzba9233rJ73qHdws=; b=exSep3N8H3KQcOzL
 6cXennJ6wADt7vSXyhzLvRDmMtKH9cbxYRnYppXNABIdv88se9+UP97rEscFURlU
 VQFyh0ZbKM5jvD2YowxMX7TM9pxFkIQ1QJmg200nlwJFljnsVDdM9WhABuiGPMTb
 mP5y75qdkXjKMj3mloj3EEtpYZGZu73//8+aczdr8Fmrp1Ezggg1CRm9t/qmHUxo
 cA1HOLcwsv0cJN9QnOyBqC6svluRYHrlwv3e0Pk8kENJsXYLQSYvsA5IsjOrkDp0
 voyMg8mGzbzODksn8mdcBz5O+ber1EOtOjLj9dOtVe4a+A0rWmMIlXnmEhDAD3lF
 wY+ebg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 484pc2pe29-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 31 Jul 2025 11:20:39 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B288F4004F;
 Thu, 31 Jul 2025 11:19:31 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0B5846D884F;
 Thu, 31 Jul 2025 11:18:58 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Jul
 2025 11:18:57 +0200
Message-ID: <9071420e-effe-4fe3-bae4-c2cfb4fc40d6@foss.st.com>
Date: Thu, 31 Jul 2025 11:18:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] ARM: dts: stm32: Add SPL specifics for DH
 STM32MP13xx DHCOR DHSBC
To: Marek Vasut <marek.vasut@mailbox.org>, <u-boot@lists.denx.de>
CC: Cheick Traore <cheick.traore@foss.st.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>,
 Lionel Debieve <lionel.debieve@foss.st.com>,
 Pascal Zimmermann <pzimmermann@dh-electronics.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 <u-boot@dh-electronics.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250630001053.952342-1-marek.vasut@mailbox.org>
 <20250630001053.952342-9-marek.vasut@mailbox.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250630001053.952342-9-marek.vasut@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_01,2025-07-31_01,2025-03-28_01
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



On 6/30/25 02:10, Marek Vasut wrote:
> Add SPL specific DT additions to DH STM32MP13xx DHCOR DHSBC . These
> include I2C3 configuration which is required to access the PMIC,
> PMIC regulator and QSPI NOR bootph-all properties to allow SPL to
> configure PMIC buck regulators and load from QSPI NOR respectively,
> etzpc bus switch to simple-bus to prevent interference from TFABOOT
> specific configuration, and RCC configuration to define clock tree
> configuration used by this platform.
> 
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
> ---
> Cc: Cheick Traore <cheick.traore@foss.st.com>
> Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Cc: Gatien Chevallier <gatien.chevallier@foss.st.com>
> Cc: Lionel Debieve <lionel.debieve@foss.st.com>
> Cc: Pascal Zimmermann <pzimmermann@dh-electronics.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@dh-electronics.com
> Cc: u-boot@lists.denx.de
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
> V2: - Add RB from Patrice
>     - Wrap the RCC node in if !TFABOOT
> ---
>  arch/arm/dts/stm32mp13xx-dhcor-u-boot.dtsi | 159 ++++++++++++++++++++-
>  1 file changed, 158 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/stm32mp13xx-dhcor-u-boot.dtsi b/arch/arm/dts/stm32mp13xx-dhcor-u-boot.dtsi
> index 6117da10bbf..f76fe63281b 100644
> --- a/arch/arm/dts/stm32mp13xx-dhcor-u-boot.dtsi
> +++ b/arch/arm/dts/stm32mp13xx-dhcor-u-boot.dtsi
> @@ -3,6 +3,7 @@
>   * Copyright (C) 2024 Marek Vasut <marex@denx.de>
>   */
>  
> +#include <dt-bindings/clock/stm32mp13-clksrc.h>
>  #include "stm32mp13-u-boot.dtsi"
>  #include "stm32mp13-ddr3-dhsom-1x2Gb-1066-binG.dtsi"
>  
> @@ -19,8 +20,12 @@
>  	};
>  };
>  
> +&etzpc {
> +	compatible = "simple-bus";
> +};
> +
>  &flash0 {
> -	bootph-pre-ram;
> +	bootph-all;
>  
>  	partitions {
>  		compatible = "fixed-partitions";
> @@ -49,6 +54,138 @@
>  	};
>  };
>  
> +&i2c3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c3_pins_a>;
> +};
> +
> +&qspi {
> +	bootph-all;
> +};
> +
> +&qspi_clk_pins_a {
> +	bootph-all;
> +	pins {
> +		bootph-all;
> +	};
> +};
> +
> +&qspi_bk1_pins_a {
> +	bootph-all;
> +	pins {
> +		bootph-all;
> +	};
> +};
> +
> +&qspi_cs1_pins_a {
> +	bootph-all;
> +	pins {
> +		bootph-all;
> +	};
> +};
> +
> +&pinctrl {
> +	bootph-all;
> +	i2c3_pins_a: i2c3-0 {
> +	        bootph-all;
> +		pins {
> +			bootph-all;
> +			pinmux = <STM32_PINMUX('B', 8, AF5)>, /* I2C3_SCL */
> +				 <STM32_PINMUX('H', 14, AF4)>; /* I2C3_SDA */
> +			bias-disable;
> +			drive-open-drain;
> +			slew-rate = <0>;
> +		};
> +	};
> +};
> +
> +#if !defined(CONFIG_TFABOOT)
> +&rcc {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	clocks = <&clk_hse>, <&clk_hsi>, <&clk_csi>, <&clk_lse>, <&clk_lsi>;
> +
> +	st,clksrc = <
> +		CLK_MPU_PLL1P
> +		CLK_AXI_PLL2P
> +		CLK_MLAHBS_PLL3
> +		CLK_PLL12_HSE
> +		CLK_PLL3_HSE
> +		CLK_PLL4_HSE
> +		CLK_CKPER_HSE
> +		CLK_RTC_LSE
> +		CLK_MCO1_LSI
> +		CLK_MCO2_HSI
> +	>;
> +
> +	st,clkdiv = <
> +		0 /*AXI*/
> +		0 /*MLHAB*/
> +		1 /*APB1*/
> +		1 /*APB2*/
> +		1 /*APB3*/
> +		1 /*APB4*/
> +		2 /*APB5*/
> +		1 /*APB6*/
> +		0 /*RTC*/
> +	>;
> +
> +	st,pkcs = <
> +		CLK_I2C12_HSI
> +		CLK_I2C3_HSI
> +		CLK_QSPI_PLL3R
> +		CLK_SAES_AXI
> +		CLK_SDMMC1_PLL3R
> +		CLK_SDMMC2_PLL3R
> +		CLK_STGEN_HSE
> +		CLK_UART2_HSI
> +		CLK_UART4_HSI
> +		CLK_USBO_USBPHY
> +		CLK_USBPHY_HSE
> +	>;
> +
> +	/*
> +	 * cfg = < DIVM1 DIVN P Q R PQR(p,q,r) >;
> +	 * frac = < f >;
> +	 *
> +	 * PRQ(p,q,r) ... for p,q,r: 0-output disabled / 1-output enabled
> +	 * DIVN ... actually multiplier, but RCC_PLL1CFGR1 calls the field DIVN
> +	 * m ... for PLL1,2: m=2 ; for PLL3,4: m=1
> +	 * XTAL = 24 MHz
> +	 *
> +	 * VCO = ( XTAL / (DIVM1 + 1) ) * m * ( DIVN + 1 + ( f / 8192 ) )
> +	 *   P = VCO / (P + 1)
> +	 *   Q = VCO / (Q + 1)
> +	 *   R = VCO / (R + 1)
> +	 */
> +
> +	/* VCO = 1066.0 MHz => P = 266 (AXI), Q = 266, R = 533 (DDR) */
> +	pll2: st,pll@1 {
> +		compatible = "st,stm32mp1-pll";
> +		reg = <1>;
> +		cfg = < 2 65 1 1 0 PQR(1,1,1) >;
> +		frac = < 0x1400 >;
> +		bootph-all;
> +	};
> +
> +	/* VCO = 600 MHz => P = 200, Q = 150, R = 200 */
> +	pll3: st,pll@2 {
> +		compatible = "st,stm32mp1-pll";
> +		reg = <2>;
> +		cfg = < 2 74 2 3 2 PQR(1,1,1) >;
> +		bootph-all;
> +	};
> +
> +	/* VCO = 750.0 MHz => P = 125, Q = 83, R = 75 */
> +	pll4: st,pll@3 {
> +		compatible = "st,stm32mp1-pll";
> +		reg = <3>;
> +		cfg = < 3 124 5 8 9 PQR(1,1,1) >;
> +		bootph-all;
> +	};
> +};
> +#endif
> +
>  &sdmmc1 {
>  	status = "disabled";
>  };
> @@ -56,3 +193,23 @@
>  &usbotg_hs {
>  	u-boot,force-b-session-valid;
>  };
> +
> +&vddcpu {
> +	bootph-all;
> +};
> +
> +&vdd_ddr {
> +	bootph-all;
> +};
> +
> +&vdd {
> +	bootph-all;
> +};
> +
> +&vddcore {
> +	bootph-all;
> +};
> +
> +&vref_ddr {
> +	bootph-all;
> +};
Applied to u-boot-stm32/master

Thanks
Patrice
