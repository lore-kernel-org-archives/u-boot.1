Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4724BC47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 11:47:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C9F986FB2;
	Thu, 25 Jan 2024 12:47:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="NkXbTIKT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99740865F5; Thu, 25 Jan 2024 12:47:38 +0100 (CET)
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA68D86FB2
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 12:47:29 +0100 (CET)
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
 bh=IsAqcNoU/Hnn8djqOhjIeO4N/hPe25SOcxuRHQaR64U=; b=NkXbTIKTM3ZAyw7JkGpj31f6Bv
 q85wFYO2F+/Lie24MdHNG2Du7P1GK9eSfB3tNP1SePSzekEAon0vnIYR8Ydeq2GKFYgxc6vg7U8mJ
 iUL/ZXf5RfXUbm1Bm+SQpi1h2ryes/ftfEAy2JZbEslfrATP4UQBE9N856WK52Xg85VTUazn6LQtx
 9qlx7RdNTpn7MiI3473jaDb5sgBwhRdo+N95ll3aCgD1zBF9rAkrikABjhpQLcrZ6xmCid1164HqE
 oZnfuk4ng+SCFVdXUFlTTkDt19r6p3HX6oKQj7yyzcZq4dMYIwK7v8sZivoeJP3TNPQa2UXENOREG
 rqAEj3xQ==;
Received: from [89.212.21.243] (port=45464 helo=[192.168.69.116])
 by cpanel.siel.si with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.96.2)
 (envelope-from <primoz.fiser@norik.com>) id 1rSyCf-004NK5-1Y;
 Thu, 25 Jan 2024 12:47:29 +0100
Message-ID: <4f0dcc58-7a9f-41d9-9604-f9fe2336eb25@norik.com>
Date: Thu, 25 Jan 2024 12:47:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Add Phytec i.MX93 support
Content-Language: en-US
To: Mathieu Othacehe <othacehe@gnu.org>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, Wadim Egorov
 <w.egorov@phytec.de>, Yannic Moog <Y.Moog@phytec.de>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de
References: <20240124134237.819-1-othacehe@gnu.org>
From: Primoz Fiser <primoz.fiser@norik.com>
Organization: Norik systems d.o.o.
In-Reply-To: <20240124134237.819-1-othacehe@gnu.org>
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

First of all, thank you for the v2.

I was able quickly build & test on the actual board.

Here are my findings:

- FEC ethernet doesn't work
- distroboot doesn't work

Did you expirience the same?

Nonetheless, here are my comments for v2:


On 24. 01. 24 14:42, Mathieu Othacehe wrote:
> Add support for the Phytec i.MX93 Segin evaluation kit. The SoM consists
> of an NXP i.MX93 dual A55 CPU. The SoM is mounted on a Phytec Segin SBC.

Can you rework you commit msg + title please?

Something like this would be more appropriate:

title:

"board: phytec: phycore-imx93: Add phyBOARD-Segin-i.MX93 support"

msg:

Add initial support for the PHYTEC phyBOARD-Segin-i.MX93 board based on
the PHYTEC phyCORE-i.MX93 SoM.

Supported features:
- 1GB LPDDR4 RAM
- eMMC
- external SD
- debug UART
- watchdog



Thanks!


> 
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
> ---
> Hello,
> 
> This new revision takes Yannic and Primoz comments into account.  I went
> for a configuration file that is named imx93-phyboard-segin_defconfig,
> which is inline with the imx8mm-phygate-tauri-l_defconfig, as discussed
> with Yannic.>
> This way, the device tree and the configuration files are matching. I
> restored the original phycore_imx93 directory in board/phytec/. The
> documentation is updated accordingly.>
> I aligned the device trees with the v5 revision of the matching kernel
> patch.
> 
> I removed the initialization of fec and eqos Ethernet ports that is not
> tested yet.
> 
> Thanks,
> 
> Mathieu>
> v1: https://lists.denx.de/pipermail/u-boot/2024-January/543599.html
> 
>  arch/arm/dts/Makefile                         |    3 +-
>  arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi |  287 +++
>  arch/arm/dts/imx93-phyboard-segin.dts         |  117 ++
>  arch/arm/dts/imx93-phycore-som.dtsi           |  126 ++
>  arch/arm/mach-imx/imx9/Kconfig                |    6 +
>  board/phytec/phycore_imx93/Kconfig            |   13 +
>  board/phytec/phycore_imx93/MAINTAINERS        |   10 +
>  board/phytec/phycore_imx93/Makefile           |   14 +
>  board/phytec/phycore_imx93/lpddr4_timing.c    | 1546 +++++++++++++++++
>  board/phytec/phycore_imx93/phycore_imx93.c    |   61 +
>  board/phytec/phycore_imx93/phycore_imx93.env  |   96 +
>  board/phytec/phycore_imx93/spl.c              |  182 ++
>  configs/imx93-phyboard-segin_defconfig        |  147 ++
>  doc/board/phytec/imx93-phyboard-segin.rst     |   61 +
>  doc/board/phytec/index.rst                    |    1 +
>  include/configs/phycore_imx93.h               |   47 +
>  16 files changed, 2716 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
>  create mode 100644 arch/arm/dts/imx93-phyboard-segin.dts
>  create mode 100644 arch/arm/dts/imx93-phycore-som.dtsi
>  create mode 100644 board/phytec/phycore_imx93/Kconfig
>  create mode 100644 board/phytec/phycore_imx93/MAINTAINERS
>  create mode 100644 board/phytec/phycore_imx93/Makefile
>  create mode 100644 board/phytec/phycore_imx93/lpddr4_timing.c
>  create mode 100644 board/phytec/phycore_imx93/phycore_imx93.c

board file is named phycore-imx93.c in downstream.

Also other PHYTEC products in upstream use the same:

$ ls board/phytec/phycore_*/phycore*.c
board/phytec/phycore_am62x/phycore-am62x.c
board/phytec/phycore_imx93/phycore_imx93.c
board/phytec/phycore_imx8mm/phycore-imx8mm.c
board/phytec/phycore_rk3288/phycore-rk3288.c
board/phytec/phycore_imx8mp/phycore-imx8mp.c

Can you rename to match other?

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
> index 00000000000..3d4c851b0d0
> --- /dev/null
> +++ b/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
> @@ -0,0 +1,287 @@
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

Can you add:

&wdog3 {
	bootph-all;
	bootph-pre-ram;
};

here to also enable WDT in SPL, please.

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
> index 00000000000..2ca5e8f107b
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
> +obj-y += phycore_imx93.o
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
> +	{0x4e300080, 0x80000412},
> +	{0x4e300084, 0x0},
> +	{0x4e300114, 0x1002},
> +	{0x4e300260, 0x4080},
> +	{0x4e300f04, 0x80},
> +	{0x4e300800, 0x43b30002},
> +	{0x4e300804, 0x1f1f1f1f},
> +	{0x4e301000, 0x0},
> +	{0x4e301240, 0x0},
> +	{0x4e301244, 0x0},
> +	{0x4e301248, 0x0},
> +	{0x4e30124c, 0x0},
> +	{0x4e301250, 0x0},
> +	{0x4e301254, 0x0},
> +	{0x4e301258, 0x0},
> +	{0x4e30125c, 0x0},
> +
> +};
> +
> +/* dram fsp cfg */
> +static struct dram_fsp_cfg ddr_dram_fsp_cfg[] = {
> +	{
> +		{
> +			{0x4e300100, 0x24A0421B},
> +			{0x4e300104, 0xF8EE001B},
> +			{0x4e300108, 0x2F263233},
> +			{0x4e30010C, 0x0005E18B},
> +			{0x4e300124, 0x1C770000},
> +			{0x4e300160, 0x00009102},
> +			{0x4e30016C, 0x35F00000},
> +			{0x4e300170, 0x8B0B0608},
> +			{0x4e300250, 0x00000028},
> +			{0x4e300254, 0x00FE00FE},
> +			{0x4e300258, 0x00000008},
> +			{0x4e30025C, 0x00000400},
> +			{0x4e300300, 0x224F2215},
> +			{0x4e300304, 0x00FE2213},
> +			{0x4e300308, 0x0A3C0E3C},
> +		},
> +		{
> +			{0x01, 0xE4},
> +			{0x02, 0x36},
> +			{0x03, 0xF2},
> +			{0x0b, 0x46},
> +			{0x0c, 0x11},
> +			{0x0e, 0x11},
> +			{0x16, 0x04},
> +		},
> +		0,
> +	},
> +
> +};
> +
> +/* PHY Initialize Configuration */
> +static struct dram_cfg_param ddr_ddrphy_cfg[] = {
> +	{0x100a0, 0x0},
> +	{0x100a1, 0x1},
> +	{0x100a2, 0x2},
> +	{0x100a3, 0x3},
> +	{0x100a4, 0x4},
> +	{0x100a5, 0x5},
> +	{0x100a6, 0x6},
> +	{0x100a7, 0x7},
> +	{0x110a0, 0x0},
> +	{0x110a1, 0x1},
> +	{0x110a2, 0x2},
> +	{0x110a3, 0x3},
> +	{0x110a4, 0x4},
> +	{0x110a5, 0x5},
> +	{0x110a6, 0x6},
> +	{0x110a7, 0x7},
> +	{0x1005f, 0x5ff},
> +	{0x1015f, 0x5ff},
> +	{0x1105f, 0x5ff},
> +	{0x1115f, 0x5ff},
> +	{0x55, 0x1ff},
> +	{0x1055, 0x1ff},
> +	{0x2055, 0x1ff},
> +	{0x200c5, 0x19},
> +	{0x2002e, 0x2},
> +	{0x90204, 0x0},
> +	{0x20024, 0x1e3},
> +	{0x2003a, 0x2},
> +	{0x2007d, 0x212},
> +	{0x2007c, 0x61},
> +	{0x20056, 0x3},
> +	{0x1004d, 0x600},
> +	{0x1014d, 0x600},
> +	{0x1104d, 0x600},
> +	{0x1114d, 0x600},
> +	{0x10049, 0xe00},
> +	{0x10149, 0xe00},
> +	{0x11049, 0xe00},
> +	{0x11149, 0xe00},
> +	{0x43, 0x60},
> +	{0x1043, 0x60},
> +	{0x2043, 0x60},
> +	{0x20018, 0x1},
> +	{0x20075, 0x4},
> +	{0x20050, 0x0},
> +	{0x2009b, 0x2},
> +	{0x20008, 0x3a5},
> +	{0x20088, 0x9},
> +	{0x200b2, 0x10c},
> +	{0x10043, 0x5a1},
> +	{0x10143, 0x5a1},
> +	{0x11043, 0x5a1},
> +	{0x11143, 0x5a1},
> +	{0x200fa, 0x2},
> +	{0x20019, 0x1},
> +	{0x200f0, 0x600},
> +	{0x200f1, 0x0},
> +	{0x200f2, 0x4444},
> +	{0x200f3, 0x8888},
> +	{0x200f4, 0x5655},
> +	{0x200f5, 0x0},
> +	{0x200f6, 0x0},
> +	{0x200f7, 0xf000},
> +	{0x20025, 0x0},
> +	{0x2002d, 0x1},
> +	{0x2002c, 0x0},
> +	{0x20021, 0x0},
> +	{0x200c7, 0x21},
> +	{0x1200c7, 0x21},
> +	{0x200ca, 0x24},
> +	{0x1200ca, 0x24},
> +
> +};
> +
> +/* ddr phy trained csr */
> +static struct dram_cfg_param ddr_ddrphy_trained_csr[] = {
> +	{0x1005f, 0x0},
> +	{0x1015f, 0x0},
> +	{0x1105f, 0x0},
> +	{0x1115f, 0x0},
> +	{0x55, 0x0},
> +	{0x1055, 0x0},
> +	{0x2055, 0x0},
> +	{0x200c5, 0x0},
> +	{0x2002e, 0x0},
> +	{0x90204, 0x0},
> +	{0x20024, 0x0},
> +	{0x2003a, 0x0},
> +	{0x2007d, 0x0},
> +	{0x2007c, 0x0},
> +	{0x20056, 0x0},
> +	{0x1004d, 0x0},
> +	{0x1014d, 0x0},
> +	{0x1104d, 0x0},
> +	{0x1114d, 0x0},
> +	{0x10049, 0x0},
> +	{0x10149, 0x0},
> +	{0x11049, 0x0},
> +	{0x11149, 0x0},
> +	{0x43, 0x0},
> +	{0x1043, 0x0},
> +	{0x2043, 0x0},
> +	{0x20018, 0x0},
> +	{0x20075, 0x0},
> +	{0x20050, 0x0},
> +	{0x2009b, 0x0},
> +	{0x20008, 0x0},
> +	{0x20088, 0x0},
> +	{0x200b2, 0x0},
> +	{0x10043, 0x0},
> +	{0x10143, 0x0},
> +	{0x11043, 0x0},
> +	{0x11143, 0x0},
> +	{0x200fa, 0x0},
> +	{0x20019, 0x0},
> +	{0x200f0, 0x0},
> +	{0x200f1, 0x0},
> +	{0x200f2, 0x0},
> +	{0x200f3, 0x0},
> +	{0x200f4, 0x0},
> +	{0x200f5, 0x0},
> +	{0x200f6, 0x0},
> +	{0x200f7, 0x0},
> +	{0x20025, 0x0},
> +	{0x2002d, 0x0},
> +	{0x2002c, 0x0},
> +	{0xd0000, 0x0},
> +	{0x90000, 0x0},
> +	{0x90001, 0x0},
> +	{0x90002, 0x0},
> +	{0x90003, 0x0},
> +	{0x90004, 0x0},
> +	{0x90005, 0x0},
> +	{0x90029, 0x0},
> +	{0x9002a, 0x0},
> +	{0x9002b, 0x0},
> +	{0x9002c, 0x0},
> +	{0x9002d, 0x0},
> +	{0x9002e, 0x0},
> +	{0x9002f, 0x0},
> +	{0x90030, 0x0},
> +	{0x90031, 0x0},
> +	{0x90032, 0x0},
> +	{0x90033, 0x0},
> +	{0x90034, 0x0},
> +	{0x90035, 0x0},
> +	{0x90036, 0x0},
> +	{0x90037, 0x0},
> +	{0x90038, 0x0},
> +	{0x90039, 0x0},
> +	{0x9003a, 0x0},
> +	{0x9003b, 0x0},
> +	{0x9003c, 0x0},
> +	{0x9003d, 0x0},
> +	{0x9003e, 0x0},
> +	{0x9003f, 0x0},
> +	{0x90040, 0x0},
> +	{0x90041, 0x0},
> +	{0x90042, 0x0},
> +	{0x90043, 0x0},
> +	{0x90044, 0x0},
> +	{0x90045, 0x0},
> +	{0x90046, 0x0},
> +	{0x90047, 0x0},
> +	{0x90048, 0x0},
> +	{0x90049, 0x0},
> +	{0x9004a, 0x0},
> +	{0x9004b, 0x0},
> +	{0x9004c, 0x0},
> +	{0x9004d, 0x0},
> +	{0x9004e, 0x0},
> +	{0x9004f, 0x0},
> +	{0x90050, 0x0},
> +	{0x90051, 0x0},
> +	{0x90052, 0x0},
> +	{0x90053, 0x0},
> +	{0x90054, 0x0},
> +	{0x90055, 0x0},
> +	{0x90056, 0x0},
> +	{0x90057, 0x0},
> +	{0x90058, 0x0},
> +	{0x90059, 0x0},
> +	{0x9005a, 0x0},
> +	{0x9005b, 0x0},
> +	{0x9005c, 0x0},
> +	{0x9005d, 0x0},
> +	{0x9005e, 0x0},
> +	{0x9005f, 0x0},
> +	{0x90060, 0x0},
> +	{0x90061, 0x0},
> +	{0x90062, 0x0},
> +	{0x90063, 0x0},
> +	{0x90064, 0x0},
> +	{0x90065, 0x0},
> +	{0x90066, 0x0},
> +	{0x90067, 0x0},
> +	{0x90068, 0x0},
> +	{0x90069, 0x0},
> +	{0x9006a, 0x0},
> +	{0x9006b, 0x0},
> +	{0x9006c, 0x0},
> +	{0x9006d, 0x0},
> +	{0x9006e, 0x0},
> +	{0x9006f, 0x0},
> +	{0x90070, 0x0},
> +	{0x90071, 0x0},
> +	{0x90072, 0x0},
> +	{0x90073, 0x0},
> +	{0x90074, 0x0},
> +	{0x90075, 0x0},
> +	{0x90076, 0x0},
> +	{0x90077, 0x0},
> +	{0x90078, 0x0},
> +	{0x90079, 0x0},
> +	{0x9007a, 0x0},
> +	{0x9007b, 0x0},
> +	{0x9007c, 0x0},
> +	{0x9007d, 0x0},
> +	{0x9007e, 0x0},
> +	{0x9007f, 0x0},
> +	{0x90080, 0x0},
> +	{0x90081, 0x0},
> +	{0x90082, 0x0},
> +	{0x90083, 0x0},
> +	{0x90084, 0x0},
> +	{0x90085, 0x0},
> +	{0x90086, 0x0},
> +	{0x90087, 0x0},
> +	{0x90088, 0x0},
> +	{0x90089, 0x0},
> +	{0x9008a, 0x0},
> +	{0x9008b, 0x0},
> +	{0x9008c, 0x0},
> +	{0x9008d, 0x0},
> +	{0x9008e, 0x0},
> +	{0x9008f, 0x0},
> +	{0x90090, 0x0},
> +	{0x90091, 0x0},
> +	{0x90092, 0x0},
> +	{0x90093, 0x0},
> +	{0x90094, 0x0},
> +	{0x90095, 0x0},
> +	{0x90096, 0x0},
> +	{0x90097, 0x0},
> +	{0x90098, 0x0},
> +	{0x90099, 0x0},
> +	{0x9009a, 0x0},
> +	{0x9009b, 0x0},
> +	{0x9009c, 0x0},
> +	{0x9009d, 0x0},
> +	{0x9009e, 0x0},
> +	{0x9009f, 0x0},
> +	{0x900a0, 0x0},
> +	{0x900a1, 0x0},
> +	{0x900a2, 0x0},
> +	{0x900a3, 0x0},
> +	{0x900a4, 0x0},
> +	{0x900a5, 0x0},
> +	{0x900a6, 0x0},
> +	{0x900a7, 0x0},
> +	{0x900a8, 0x0},
> +	{0x900a9, 0x0},
> +	{0x40000, 0x0},
> +	{0x40020, 0x0},
> +	{0x40040, 0x0},
> +	{0x40060, 0x0},
> +	{0x40001, 0x0},
> +	{0x40021, 0x0},
> +	{0x40041, 0x0},
> +	{0x40061, 0x0},
> +	{0x40002, 0x0},
> +	{0x40022, 0x0},
> +	{0x40042, 0x0},
> +	{0x40062, 0x0},
> +	{0x40003, 0x0},
> +	{0x40023, 0x0},
> +	{0x40043, 0x0},
> +	{0x40063, 0x0},
> +	{0x40004, 0x0},
> +	{0x40024, 0x0},
> +	{0x40044, 0x0},
> +	{0x40064, 0x0},
> +	{0x40005, 0x0},
> +	{0x40025, 0x0},
> +	{0x40045, 0x0},
> +	{0x40065, 0x0},
> +	{0x40006, 0x0},
> +	{0x40026, 0x0},
> +	{0x40046, 0x0},
> +	{0x40066, 0x0},
> +	{0x40007, 0x0},
> +	{0x40027, 0x0},
> +	{0x40047, 0x0},
> +	{0x40067, 0x0},
> +	{0x40008, 0x0},
> +	{0x40028, 0x0},
> +	{0x40048, 0x0},
> +	{0x40068, 0x0},
> +	{0x40009, 0x0},
> +	{0x40029, 0x0},
> +	{0x40049, 0x0},
> +	{0x40069, 0x0},
> +	{0x4000a, 0x0},
> +	{0x4002a, 0x0},
> +	{0x4004a, 0x0},
> +	{0x4006a, 0x0},
> +	{0x4000b, 0x0},
> +	{0x4002b, 0x0},
> +	{0x4004b, 0x0},
> +	{0x4006b, 0x0},
> +	{0x4000c, 0x0},
> +	{0x4002c, 0x0},
> +	{0x4004c, 0x0},
> +	{0x4006c, 0x0},
> +	{0x4000d, 0x0},
> +	{0x4002d, 0x0},
> +	{0x4004d, 0x0},
> +	{0x4006d, 0x0},
> +	{0x4000e, 0x0},
> +	{0x4002e, 0x0},
> +	{0x4004e, 0x0},
> +	{0x4006e, 0x0},
> +	{0x4000f, 0x0},
> +	{0x4002f, 0x0},
> +	{0x4004f, 0x0},
> +	{0x4006f, 0x0},
> +	{0x40010, 0x0},
> +	{0x40030, 0x0},
> +	{0x40050, 0x0},
> +	{0x40070, 0x0},
> +	{0x40011, 0x0},
> +	{0x40031, 0x0},
> +	{0x40051, 0x0},
> +	{0x40071, 0x0},
> +	{0x40012, 0x0},
> +	{0x40032, 0x0},
> +	{0x40052, 0x0},
> +	{0x40072, 0x0},
> +	{0x40013, 0x0},
> +	{0x40033, 0x0},
> +	{0x40053, 0x0},
> +	{0x40073, 0x0},
> +	{0x40014, 0x0},
> +	{0x40034, 0x0},
> +	{0x40054, 0x0},
> +	{0x40074, 0x0},
> +	{0x40015, 0x0},
> +	{0x40035, 0x0},
> +	{0x40055, 0x0},
> +	{0x40075, 0x0},
> +	{0x40016, 0x0},
> +	{0x40036, 0x0},
> +	{0x40056, 0x0},
> +	{0x40076, 0x0},
> +	{0x40017, 0x0},
> +	{0x40037, 0x0},
> +	{0x40057, 0x0},
> +	{0x40077, 0x0},
> +	{0x40018, 0x0},
> +	{0x40038, 0x0},
> +	{0x40058, 0x0},
> +	{0x40078, 0x0},
> +	{0x40019, 0x0},
> +	{0x40039, 0x0},
> +	{0x40059, 0x0},
> +	{0x40079, 0x0},
> +	{0x4001a, 0x0},
> +	{0x4003a, 0x0},
> +	{0x4005a, 0x0},
> +	{0x4007a, 0x0},
> +	{0x900aa, 0x0},
> +	{0x900ab, 0x0},
> +	{0x900ac, 0x0},
> +	{0x900ad, 0x0},
> +	{0x900ae, 0x0},
> +	{0x900af, 0x0},
> +	{0x900b0, 0x0},
> +	{0x900b1, 0x0},
> +	{0x900b2, 0x0},
> +	{0x900b3, 0x0},
> +	{0x900b4, 0x0},
> +	{0x900b5, 0x0},
> +	{0x900b6, 0x0},
> +	{0x900b7, 0x0},
> +	{0x900b8, 0x0},
> +	{0x900b9, 0x0},
> +	{0x900ba, 0x0},
> +	{0x900bb, 0x0},
> +	{0x900bc, 0x0},
> +	{0x900bd, 0x0},
> +	{0x900be, 0x0},
> +	{0x900bf, 0x0},
> +	{0x900c0, 0x0},
> +	{0x900c1, 0x0},
> +	{0x900c2, 0x0},
> +	{0x900c3, 0x0},
> +	{0x900c4, 0x0},
> +	{0x900c5, 0x0},
> +	{0x900c6, 0x0},
> +	{0x900c7, 0x0},
> +	{0x900c8, 0x0},
> +	{0x900c9, 0x0},
> +	{0x900ca, 0x0},
> +	{0x900cb, 0x0},
> +	{0x900cc, 0x0},
> +	{0x900cd, 0x0},
> +	{0x900ce, 0x0},
> +	{0x900cf, 0x0},
> +	{0x900d0, 0x0},
> +	{0x900d1, 0x0},
> +	{0x900d2, 0x0},
> +	{0x900d3, 0x0},
> +	{0x900d4, 0x0},
> +	{0x900d5, 0x0},
> +	{0x900d6, 0x0},
> +	{0x900d7, 0x0},
> +	{0x900d8, 0x0},
> +	{0x900d9, 0x0},
> +	{0x900da, 0x0},
> +	{0x900db, 0x0},
> +	{0x900dc, 0x0},
> +	{0x900dd, 0x0},
> +	{0x900de, 0x0},
> +	{0x900df, 0x0},
> +	{0x900e0, 0x0},
> +	{0x900e1, 0x0},
> +	{0x900e2, 0x0},
> +	{0x900e3, 0x0},
> +	{0x900e4, 0x0},
> +	{0x900e5, 0x0},
> +	{0x900e6, 0x0},
> +	{0x900e7, 0x0},
> +	{0x900e8, 0x0},
> +	{0x900e9, 0x0},
> +	{0x900ea, 0x0},
> +	{0x900eb, 0x0},
> +	{0x900ec, 0x0},
> +	{0x900ed, 0x0},
> +	{0x900ee, 0x0},
> +	{0x900ef, 0x0},
> +	{0x900f0, 0x0},
> +	{0x900f1, 0x0},
> +	{0x900f2, 0x0},
> +	{0x900f3, 0x0},
> +	{0x900f4, 0x0},
> +	{0x900f5, 0x0},
> +	{0x900f6, 0x0},
> +	{0x900f7, 0x0},
> +	{0x900f8, 0x0},
> +	{0x900f9, 0x0},
> +	{0x900fa, 0x0},
> +	{0x900fb, 0x0},
> +	{0x900fc, 0x0},
> +	{0x900fd, 0x0},
> +	{0x900fe, 0x0},
> +	{0x900ff, 0x0},
> +	{0x90100, 0x0},
> +	{0x90101, 0x0},
> +	{0x90102, 0x0},
> +	{0x90103, 0x0},
> +	{0x90104, 0x0},
> +	{0x90105, 0x0},
> +	{0x90106, 0x0},
> +	{0x90107, 0x0},
> +	{0x90108, 0x0},
> +	{0x90109, 0x0},
> +	{0x9010a, 0x0},
> +	{0x9010b, 0x0},
> +	{0x9010c, 0x0},
> +	{0x9010d, 0x0},
> +	{0x9010e, 0x0},
> +	{0x9010f, 0x0},
> +	{0x90110, 0x0},
> +	{0x90111, 0x0},
> +	{0x90112, 0x0},
> +	{0x90113, 0x0},
> +	{0x90114, 0x0},
> +	{0x90115, 0x0},
> +	{0x90116, 0x0},
> +	{0x90117, 0x0},
> +	{0x90118, 0x0},
> +	{0x90119, 0x0},
> +	{0x9011a, 0x0},
> +	{0x9011b, 0x0},
> +	{0x9011c, 0x0},
> +	{0x9011d, 0x0},
> +	{0x9011e, 0x0},
> +	{0x9011f, 0x0},
> +	{0x90120, 0x0},
> +	{0x90121, 0x0},
> +	{0x90122, 0x0},
> +	{0x90123, 0x0},
> +	{0x90124, 0x0},
> +	{0x90125, 0x0},
> +	{0x90126, 0x0},
> +	{0x90127, 0x0},
> +	{0x90128, 0x0},
> +	{0x90129, 0x0},
> +	{0x9012a, 0x0},
> +	{0x9012b, 0x0},
> +	{0x9012c, 0x0},
> +	{0x9012d, 0x0},
> +	{0x9012e, 0x0},
> +	{0x9012f, 0x0},
> +	{0x90130, 0x0},
> +	{0x90131, 0x0},
> +	{0x90132, 0x0},
> +	{0x90133, 0x0},
> +	{0x90134, 0x0},
> +	{0x90135, 0x0},
> +	{0x90136, 0x0},
> +	{0x90137, 0x0},
> +	{0x90138, 0x0},
> +	{0x90139, 0x0},
> +	{0x9013a, 0x0},
> +	{0x9013b, 0x0},
> +	{0x9013c, 0x0},
> +	{0x9013d, 0x0},
> +	{0x9013e, 0x0},
> +	{0x9013f, 0x0},
> +	{0x90140, 0x0},
> +	{0x90141, 0x0},
> +	{0x90142, 0x0},
> +	{0x90143, 0x0},
> +	{0x90144, 0x0},
> +	{0x90145, 0x0},
> +	{0x90146, 0x0},
> +	{0x90147, 0x0},
> +	{0x90148, 0x0},
> +	{0x90149, 0x0},
> +	{0x9014a, 0x0},
> +	{0x9014b, 0x0},
> +	{0x9014c, 0x0},
> +	{0x9014d, 0x0},
> +	{0x9014e, 0x0},
> +	{0x9014f, 0x0},
> +	{0x90150, 0x0},
> +	{0x90151, 0x0},
> +	{0x90152, 0x0},
> +	{0x90153, 0x0},
> +	{0x90154, 0x0},
> +	{0x90155, 0x0},
> +	{0x90156, 0x0},
> +	{0x90157, 0x0},
> +	{0x90158, 0x0},
> +	{0x90159, 0x0},
> +	{0x9015a, 0x0},
> +	{0x9015b, 0x0},
> +	{0x9015c, 0x0},
> +	{0x9015d, 0x0},
> +	{0x9015e, 0x0},
> +	{0x9015f, 0x0},
> +	{0x90160, 0x0},
> +	{0x90161, 0x0},
> +	{0x90162, 0x0},
> +	{0x90163, 0x0},
> +	{0x90164, 0x0},
> +	{0x90165, 0x0},
> +	{0x90166, 0x0},
> +	{0x90167, 0x0},
> +	{0x90168, 0x0},
> +	{0x90169, 0x0},
> +	{0x9016a, 0x0},
> +	{0x9016b, 0x0},
> +	{0x9016c, 0x0},
> +	{0x9016d, 0x0},
> +	{0x9016e, 0x0},
> +	{0x9016f, 0x0},
> +	{0x90170, 0x0},
> +	{0x90171, 0x0},
> +	{0x90172, 0x0},
> +	{0x90173, 0x0},
> +	{0x90174, 0x0},
> +	{0x90175, 0x0},
> +	{0x90176, 0x0},
> +	{0x90177, 0x0},
> +	{0x90178, 0x0},
> +	{0x90179, 0x0},
> +	{0x9017a, 0x0},
> +	{0x9017b, 0x0},
> +	{0x9017c, 0x0},
> +	{0x9017d, 0x0},
> +	{0x9017e, 0x0},
> +	{0x9017f, 0x0},
> +	{0x90180, 0x0},
> +	{0x90181, 0x0},
> +	{0x90182, 0x0},
> +	{0x90183, 0x0},
> +	{0x90184, 0x0},
> +	{0x90006, 0x0},
> +	{0x90007, 0x0},
> +	{0x90008, 0x0},
> +	{0x90009, 0x0},
> +	{0x9000a, 0x0},
> +	{0x9000b, 0x0},
> +	{0xd00e7, 0x0},
> +	{0x90017, 0x0},
> +	{0x9001f, 0x0},
> +	{0x90026, 0x0},
> +	{0x400d0, 0x0},
> +	{0x400d1, 0x0},
> +	{0x400d2, 0x0},
> +	{0x400d3, 0x0},
> +	{0x400d4, 0x0},
> +	{0x400d5, 0x0},
> +	{0x400d6, 0x0},
> +	{0x400d7, 0x0},
> +	{0x200be, 0x0},
> +	{0x2000b, 0x0},
> +	{0x2000c, 0x0},
> +	{0x2000d, 0x0},
> +	{0x2000e, 0x0},
> +	{0x9000c, 0x0},
> +	{0x9000d, 0x0},
> +	{0x9000e, 0x0},
> +	{0x9000f, 0x0},
> +	{0x90010, 0x0},
> +	{0x90011, 0x0},
> +	{0x90012, 0x0},
> +	{0x90013, 0x0},
> +	{0x20010, 0x0},
> +	{0x20011, 0x0},
> +	{0x40080, 0x0},
> +	{0x40081, 0x0},
> +	{0x40082, 0x0},
> +	{0x40083, 0x0},
> +	{0x40084, 0x0},
> +	{0x40085, 0x0},
> +	{0x400fd, 0x0},
> +	{0x400f1, 0x0},
> +	{0x10011, 0x0},
> +	{0x10012, 0x0},
> +	{0x10013, 0x0},
> +	{0x10018, 0x0},
> +	{0x10002, 0x0},
> +	{0x100b2, 0x0},
> +	{0x101b4, 0x0},
> +	{0x102b4, 0x0},
> +	{0x103b4, 0x0},
> +	{0x104b4, 0x0},
> +	{0x105b4, 0x0},
> +	{0x106b4, 0x0},
> +	{0x107b4, 0x0},
> +	{0x108b4, 0x0},
> +	{0x11011, 0x0},
> +	{0x11012, 0x0},
> +	{0x11013, 0x0},
> +	{0x11018, 0x0},
> +	{0x11002, 0x0},
> +	{0x110b2, 0x0},
> +	{0x111b4, 0x0},
> +	{0x112b4, 0x0},
> +	{0x113b4, 0x0},
> +	{0x114b4, 0x0},
> +	{0x115b4, 0x0},
> +	{0x116b4, 0x0},
> +	{0x117b4, 0x0},
> +	{0x118b4, 0x0},
> +	{0x20089, 0x0},
> +	{0xc0080, 0x0},
> +	{0x200cb, 0x0},
> +	{0x10068, 0x0},
> +	{0x10069, 0x0},
> +	{0x10168, 0x0},
> +	{0x10169, 0x0},
> +	{0x10268, 0x0},
> +	{0x10269, 0x0},
> +	{0x10368, 0x0},
> +	{0x10369, 0x0},
> +	{0x10468, 0x0},
> +	{0x10469, 0x0},
> +	{0x10568, 0x0},
> +	{0x10569, 0x0},
> +	{0x10668, 0x0},
> +	{0x10669, 0x0},
> +	{0x10768, 0x0},
> +	{0x10769, 0x0},
> +	{0x10868, 0x0},
> +	{0x10869, 0x0},
> +	{0x100aa, 0x0},
> +	{0x10062, 0x0},
> +	{0x10001, 0x0},
> +	{0x100a0, 0x0},
> +	{0x100a1, 0x0},
> +	{0x100a2, 0x0},
> +	{0x100a3, 0x0},
> +	{0x100a4, 0x0},
> +	{0x100a5, 0x0},
> +	{0x100a6, 0x0},
> +	{0x100a7, 0x0},
> +	{0x11068, 0x0},
> +	{0x11069, 0x0},
> +	{0x11168, 0x0},
> +	{0x11169, 0x0},
> +	{0x11268, 0x0},
> +	{0x11269, 0x0},
> +	{0x11368, 0x0},
> +	{0x11369, 0x0},
> +	{0x11468, 0x0},
> +	{0x11469, 0x0},
> +	{0x11568, 0x0},
> +	{0x11569, 0x0},
> +	{0x11668, 0x0},
> +	{0x11669, 0x0},
> +	{0x11768, 0x0},
> +	{0x11769, 0x0},
> +	{0x11868, 0x0},
> +	{0x11869, 0x0},
> +	{0x110aa, 0x0},
> +	{0x11062, 0x0},
> +	{0x11001, 0x0},
> +	{0x110a0, 0x0},
> +	{0x110a1, 0x0},
> +	{0x110a2, 0x0},
> +	{0x110a3, 0x0},
> +	{0x110a4, 0x0},
> +	{0x110a5, 0x0},
> +	{0x110a6, 0x0},
> +	{0x110a7, 0x0},
> +	{0x80, 0x0},
> +	{0x1080, 0x0},
> +	{0x2080, 0x0},
> +	{0x10020, 0x0},
> +	{0x10080, 0x0},
> +	{0x10081, 0x0},
> +	{0x100d0, 0x0},
> +	{0x100d1, 0x0},
> +	{0x1008c, 0x0},
> +	{0x1008d, 0x0},
> +	{0x10180, 0x0},
> +	{0x10181, 0x0},
> +	{0x101d0, 0x0},
> +	{0x101d1, 0x0},
> +	{0x1018c, 0x0},
> +	{0x1018d, 0x0},
> +	{0x100c0, 0x0},
> +	{0x100c1, 0x0},
> +	{0x101c0, 0x0},
> +	{0x101c1, 0x0},
> +	{0x102c0, 0x0},
> +	{0x102c1, 0x0},
> +	{0x103c0, 0x0},
> +	{0x103c1, 0x0},
> +	{0x104c0, 0x0},
> +	{0x104c1, 0x0},
> +	{0x105c0, 0x0},
> +	{0x105c1, 0x0},
> +	{0x106c0, 0x0},
> +	{0x106c1, 0x0},
> +	{0x107c0, 0x0},
> +	{0x107c1, 0x0},
> +	{0x108c0, 0x0},
> +	{0x108c1, 0x0},
> +	{0x100ae, 0x0},
> +	{0x100af, 0x0},
> +	{0x11020, 0x0},
> +	{0x11080, 0x0},
> +	{0x11081, 0x0},
> +	{0x110d0, 0x0},
> +	{0x110d1, 0x0},
> +	{0x1108c, 0x0},
> +	{0x1108d, 0x0},
> +	{0x11180, 0x0},
> +	{0x11181, 0x0},
> +	{0x111d0, 0x0},
> +	{0x111d1, 0x0},
> +	{0x1118c, 0x0},
> +	{0x1118d, 0x0},
> +	{0x110c0, 0x0},
> +	{0x110c1, 0x0},
> +	{0x111c0, 0x0},
> +	{0x111c1, 0x0},
> +	{0x112c0, 0x0},
> +	{0x112c1, 0x0},
> +	{0x113c0, 0x0},
> +	{0x113c1, 0x0},
> +	{0x114c0, 0x0},
> +	{0x114c1, 0x0},
> +	{0x115c0, 0x0},
> +	{0x115c1, 0x0},
> +	{0x116c0, 0x0},
> +	{0x116c1, 0x0},
> +	{0x117c0, 0x0},
> +	{0x117c1, 0x0},
> +	{0x118c0, 0x0},
> +	{0x118c1, 0x0},
> +	{0x110ae, 0x0},
> +	{0x110af, 0x0},
> +	{0x90201, 0x0},
> +	{0x90202, 0x0},
> +	{0x90203, 0x0},
> +	{0x90205, 0x0},
> +	{0x90206, 0x0},
> +	{0x90207, 0x0},
> +	{0x90208, 0x0},
> +	{0x20020, 0x0},
> +	{0x20077, 0x0},
> +	{0x20072, 0x0},
> +	{0x20073, 0x0},
> +	{0x400c0, 0x0},
> +	{0x10040, 0x0},
> +	{0x10140, 0x0},
> +	{0x10240, 0x0},
> +	{0x10340, 0x0},
> +	{0x10440, 0x0},
> +	{0x10540, 0x0},
> +	{0x10640, 0x0},
> +	{0x10740, 0x0},
> +	{0x10840, 0x0},
> +	{0x11040, 0x0},
> +	{0x11140, 0x0},
> +	{0x11240, 0x0},
> +	{0x11340, 0x0},
> +	{0x11440, 0x0},
> +	{0x11540, 0x0},
> +	{0x11640, 0x0},
> +	{0x11740, 0x0},
> +	{0x11840, 0x0},
> +
> +};
> +
> +/* P0 message block parameter for training firmware */
> +static struct dram_cfg_param ddr_fsp0_cfg[] = {
> +	{0xd0000, 0x0},
> +	{0x54003, 0xe94},
> +	{0x54004, 0x4},
> +	{0x54006, 0x15},
> +	{0x54008, 0x131f},
> +	{0x54009, 0xc8},
> +	{0x5400b, 0x4},
> +	{0x5400d, 0x100},
> +	{0x5400f, 0x100},
> +	{0x54012, 0x110},
> +	{0x54019, 0x36e4},
> +	{0x5401a, 0xf2},
> +	{0x5401b, 0x1146},
> +	{0x5401c, 0x1108},
> +	{0x5401e, 0x4},
> +	{0x5401f, 0x36e4},
> +	{0x54020, 0xf2},
> +	{0x54021, 0x1146},
> +	{0x54022, 0x1108},
> +	{0x54024, 0x4},
> +	{0x54032, 0xe400},
> +	{0x54033, 0xf236},
> +	{0x54034, 0x4600},
> +	{0x54035, 0x811},
> +	{0x54036, 0x11},
> +	{0x54037, 0x400},
> +	{0x54038, 0xe400},
> +	{0x54039, 0xf236},
> +	{0x5403a, 0x4600},
> +	{0x5403b, 0x811},
> +	{0x5403c, 0x11},
> +	{0x5403d, 0x400},
> +	{0xd0000, 0x1}
> +};
> +
> +/* P0 2D message block parameter for training firmware */
> +static struct dram_cfg_param ddr_fsp0_2d_cfg[] = {
> +	{0xd0000, 0x0},
> +	{0x54003, 0xe94},
> +	{0x54004, 0x4},
> +	{0x54006, 0x15},
> +	{0x54008, 0x61},
> +	{0x54009, 0xc8},
> +	{0x5400b, 0x4},
> +	{0x5400d, 0x100},
> +	{0x5400f, 0x100},
> +	{0x54010, 0x2080},
> +	{0x54012, 0x110},
> +	{0x54019, 0x36e4},
> +	{0x5401a, 0xf2},
> +	{0x5401b, 0x1146},
> +	{0x5401c, 0x1108},
> +	{0x5401e, 0x4},
> +	{0x5401f, 0x36e4},
> +	{0x54020, 0xf2},
> +	{0x54021, 0x1146},
> +	{0x54022, 0x1108},
> +	{0x54024, 0x4},
> +	{0x54032, 0xe400},
> +	{0x54033, 0xf236},
> +	{0x54034, 0x4600},
> +	{0x54035, 0x811},
> +	{0x54036, 0x11},
> +	{0x54037, 0x400},
> +	{0x54038, 0xe400},
> +	{0x54039, 0xf236},
> +	{0x5403a, 0x4600},
> +	{0x5403b, 0x811},
> +	{0x5403c, 0x11},
> +	{0x5403d, 0x400},
> +	{0xd0000, 0x1}
> +};
> +
> +/* DRAM PHY init engine image */
> +static struct dram_cfg_param ddr_phy_pie[] = {
> +	{0xd0000, 0x0},
> +	{0x90000, 0x10},
> +	{0x90001, 0x400},
> +	{0x90002, 0x10e},
> +	{0x90003, 0x0},
> +	{0x90004, 0x0},
> +	{0x90005, 0x8},
> +	{0x90029, 0xb},
> +	{0x9002a, 0x480},
> +	{0x9002b, 0x109},
> +	{0x9002c, 0x8},
> +	{0x9002d, 0x448},
> +	{0x9002e, 0x139},
> +	{0x9002f, 0x8},
> +	{0x90030, 0x478},
> +	{0x90031, 0x109},
> +	{0x90032, 0x0},
> +	{0x90033, 0xe8},
> +	{0x90034, 0x109},
> +	{0x90035, 0x2},
> +	{0x90036, 0x10},
> +	{0x90037, 0x139},
> +	{0x90038, 0xb},
> +	{0x90039, 0x7c0},
> +	{0x9003a, 0x139},
> +	{0x9003b, 0x44},
> +	{0x9003c, 0x633},
> +	{0x9003d, 0x159},
> +	{0x9003e, 0x14f},
> +	{0x9003f, 0x630},
> +	{0x90040, 0x159},
> +	{0x90041, 0x47},
> +	{0x90042, 0x633},
> +	{0x90043, 0x149},
> +	{0x90044, 0x4f},
> +	{0x90045, 0x633},
> +	{0x90046, 0x179},
> +	{0x90047, 0x8},
> +	{0x90048, 0xe0},
> +	{0x90049, 0x109},
> +	{0x9004a, 0x0},
> +	{0x9004b, 0x7c8},
> +	{0x9004c, 0x109},
> +	{0x9004d, 0x0},
> +	{0x9004e, 0x1},
> +	{0x9004f, 0x8},
> +	{0x90050, 0x30},
> +	{0x90051, 0x65a},
> +	{0x90052, 0x9},
> +	{0x90053, 0x0},
> +	{0x90054, 0x45a},
> +	{0x90055, 0x9},
> +	{0x90056, 0x0},
> +	{0x90057, 0x448},
> +	{0x90058, 0x109},
> +	{0x90059, 0x40},
> +	{0x9005a, 0x633},
> +	{0x9005b, 0x179},
> +	{0x9005c, 0x1},
> +	{0x9005d, 0x618},
> +	{0x9005e, 0x109},
> +	{0x9005f, 0x40c0},
> +	{0x90060, 0x633},
> +	{0x90061, 0x149},
> +	{0x90062, 0x8},
> +	{0x90063, 0x4},
> +	{0x90064, 0x48},
> +	{0x90065, 0x4040},
> +	{0x90066, 0x633},
> +	{0x90067, 0x149},
> +	{0x90068, 0x0},
> +	{0x90069, 0x4},
> +	{0x9006a, 0x48},
> +	{0x9006b, 0x40},
> +	{0x9006c, 0x633},
> +	{0x9006d, 0x149},
> +	{0x9006e, 0x0},
> +	{0x9006f, 0x658},
> +	{0x90070, 0x109},
> +	{0x90071, 0x10},
> +	{0x90072, 0x4},
> +	{0x90073, 0x18},
> +	{0x90074, 0x0},
> +	{0x90075, 0x4},
> +	{0x90076, 0x78},
> +	{0x90077, 0x549},
> +	{0x90078, 0x633},
> +	{0x90079, 0x159},
> +	{0x9007a, 0xd49},
> +	{0x9007b, 0x633},
> +	{0x9007c, 0x159},
> +	{0x9007d, 0x94a},
> +	{0x9007e, 0x633},
> +	{0x9007f, 0x159},
> +	{0x90080, 0x441},
> +	{0x90081, 0x633},
> +	{0x90082, 0x149},
> +	{0x90083, 0x42},
> +	{0x90084, 0x633},
> +	{0x90085, 0x149},
> +	{0x90086, 0x1},
> +	{0x90087, 0x633},
> +	{0x90088, 0x149},
> +	{0x90089, 0x0},
> +	{0x9008a, 0xe0},
> +	{0x9008b, 0x109},
> +	{0x9008c, 0xa},
> +	{0x9008d, 0x10},
> +	{0x9008e, 0x109},
> +	{0x9008f, 0x9},
> +	{0x90090, 0x3c0},
> +	{0x90091, 0x149},
> +	{0x90092, 0x9},
> +	{0x90093, 0x3c0},
> +	{0x90094, 0x159},
> +	{0x90095, 0x18},
> +	{0x90096, 0x10},
> +	{0x90097, 0x109},
> +	{0x90098, 0x0},
> +	{0x90099, 0x3c0},
> +	{0x9009a, 0x109},
> +	{0x9009b, 0x18},
> +	{0x9009c, 0x4},
> +	{0x9009d, 0x48},
> +	{0x9009e, 0x18},
> +	{0x9009f, 0x4},
> +	{0x900a0, 0x58},
> +	{0x900a1, 0xb},
> +	{0x900a2, 0x10},
> +	{0x900a3, 0x109},
> +	{0x900a4, 0x1},
> +	{0x900a5, 0x10},
> +	{0x900a6, 0x109},
> +	{0x900a7, 0x5},
> +	{0x900a8, 0x7c0},
> +	{0x900a9, 0x109},
> +	{0x40000, 0x811},
> +	{0x40020, 0x880},
> +	{0x40040, 0x0},
> +	{0x40060, 0x0},
> +	{0x40001, 0x4008},
> +	{0x40021, 0x83},
> +	{0x40041, 0x4f},
> +	{0x40061, 0x0},
> +	{0x40002, 0x4040},
> +	{0x40022, 0x83},
> +	{0x40042, 0x51},
> +	{0x40062, 0x0},
> +	{0x40003, 0x811},
> +	{0x40023, 0x880},
> +	{0x40043, 0x0},
> +	{0x40063, 0x0},
> +	{0x40004, 0x720},
> +	{0x40024, 0xf},
> +	{0x40044, 0x1740},
> +	{0x40064, 0x0},
> +	{0x40005, 0x16},
> +	{0x40025, 0x83},
> +	{0x40045, 0x4b},
> +	{0x40065, 0x0},
> +	{0x40006, 0x716},
> +	{0x40026, 0xf},
> +	{0x40046, 0x2001},
> +	{0x40066, 0x0},
> +	{0x40007, 0x716},
> +	{0x40027, 0xf},
> +	{0x40047, 0x2800},
> +	{0x40067, 0x0},
> +	{0x40008, 0x716},
> +	{0x40028, 0xf},
> +	{0x40048, 0xf00},
> +	{0x40068, 0x0},
> +	{0x40009, 0x720},
> +	{0x40029, 0xf},
> +	{0x40049, 0x1400},
> +	{0x40069, 0x0},
> +	{0x4000a, 0xe08},
> +	{0x4002a, 0xc15},
> +	{0x4004a, 0x0},
> +	{0x4006a, 0x0},
> +	{0x4000b, 0x625},
> +	{0x4002b, 0x15},
> +	{0x4004b, 0x0},
> +	{0x4006b, 0x0},
> +	{0x4000c, 0x4028},
> +	{0x4002c, 0x80},
> +	{0x4004c, 0x0},
> +	{0x4006c, 0x0},
> +	{0x4000d, 0xe08},
> +	{0x4002d, 0xc1a},
> +	{0x4004d, 0x0},
> +	{0x4006d, 0x0},
> +	{0x4000e, 0x625},
> +	{0x4002e, 0x1a},
> +	{0x4004e, 0x0},
> +	{0x4006e, 0x0},
> +	{0x4000f, 0x4040},
> +	{0x4002f, 0x80},
> +	{0x4004f, 0x0},
> +	{0x4006f, 0x0},
> +	{0x40010, 0x2604},
> +	{0x40030, 0x15},
> +	{0x40050, 0x0},
> +	{0x40070, 0x0},
> +	{0x40011, 0x708},
> +	{0x40031, 0x5},
> +	{0x40051, 0x0},
> +	{0x40071, 0x2002},
> +	{0x40012, 0x8},
> +	{0x40032, 0x80},
> +	{0x40052, 0x0},
> +	{0x40072, 0x0},
> +	{0x40013, 0x2604},
> +	{0x40033, 0x1a},
> +	{0x40053, 0x0},
> +	{0x40073, 0x0},
> +	{0x40014, 0x708},
> +	{0x40034, 0xa},
> +	{0x40054, 0x0},
> +	{0x40074, 0x2002},
> +	{0x40015, 0x4040},
> +	{0x40035, 0x80},
> +	{0x40055, 0x0},
> +	{0x40075, 0x0},
> +	{0x40016, 0x60a},
> +	{0x40036, 0x15},
> +	{0x40056, 0x1200},
> +	{0x40076, 0x0},
> +	{0x40017, 0x61a},
> +	{0x40037, 0x15},
> +	{0x40057, 0x1300},
> +	{0x40077, 0x0},
> +	{0x40018, 0x60a},
> +	{0x40038, 0x1a},
> +	{0x40058, 0x1200},
> +	{0x40078, 0x0},
> +	{0x40019, 0x642},
> +	{0x40039, 0x1a},
> +	{0x40059, 0x1300},
> +	{0x40079, 0x0},
> +	{0x4001a, 0x4808},
> +	{0x4003a, 0x880},
> +	{0x4005a, 0x0},
> +	{0x4007a, 0x0},
> +	{0x900aa, 0x0},
> +	{0x900ab, 0x790},
> +	{0x900ac, 0x11a},
> +	{0x900ad, 0x8},
> +	{0x900ae, 0x7aa},
> +	{0x900af, 0x2a},
> +	{0x900b0, 0x10},
> +	{0x900b1, 0x7b2},
> +	{0x900b2, 0x2a},
> +	{0x900b3, 0x0},
> +	{0x900b4, 0x7c8},
> +	{0x900b5, 0x109},
> +	{0x900b6, 0x10},
> +	{0x900b7, 0x10},
> +	{0x900b8, 0x109},
> +	{0x900b9, 0x10},
> +	{0x900ba, 0x2a8},
> +	{0x900bb, 0x129},
> +	{0x900bc, 0x8},
> +	{0x900bd, 0x370},
> +	{0x900be, 0x129},
> +	{0x900bf, 0xa},
> +	{0x900c0, 0x3c8},
> +	{0x900c1, 0x1a9},
> +	{0x900c2, 0xc},
> +	{0x900c3, 0x408},
> +	{0x900c4, 0x199},
> +	{0x900c5, 0x14},
> +	{0x900c6, 0x790},
> +	{0x900c7, 0x11a},
> +	{0x900c8, 0x8},
> +	{0x900c9, 0x4},
> +	{0x900ca, 0x18},
> +	{0x900cb, 0xe},
> +	{0x900cc, 0x408},
> +	{0x900cd, 0x199},
> +	{0x900ce, 0x8},
> +	{0x900cf, 0x8568},
> +	{0x900d0, 0x108},
> +	{0x900d1, 0x18},
> +	{0x900d2, 0x790},
> +	{0x900d3, 0x16a},
> +	{0x900d4, 0x8},
> +	{0x900d5, 0x1d8},
> +	{0x900d6, 0x169},
> +	{0x900d7, 0x10},
> +	{0x900d8, 0x8558},
> +	{0x900d9, 0x168},
> +	{0x900da, 0x1ff8},
> +	{0x900db, 0x85a8},
> +	{0x900dc, 0x1e8},
> +	{0x900dd, 0x50},
> +	{0x900de, 0x798},
> +	{0x900df, 0x16a},
> +	{0x900e0, 0x60},
> +	{0x900e1, 0x7a0},
> +	{0x900e2, 0x16a},
> +	{0x900e3, 0x8},
> +	{0x900e4, 0x8310},
> +	{0x900e5, 0x168},
> +	{0x900e6, 0x8},
> +	{0x900e7, 0xa310},
> +	{0x900e8, 0x168},
> +	{0x900e9, 0xa},
> +	{0x900ea, 0x408},
> +	{0x900eb, 0x169},
> +	{0x900ec, 0x6e},
> +	{0x900ed, 0x0},
> +	{0x900ee, 0x68},
> +	{0x900ef, 0x0},
> +	{0x900f0, 0x408},
> +	{0x900f1, 0x169},
> +	{0x900f2, 0x0},
> +	{0x900f3, 0x8310},
> +	{0x900f4, 0x168},
> +	{0x900f5, 0x0},
> +	{0x900f6, 0xa310},
> +	{0x900f7, 0x168},
> +	{0x900f8, 0x1ff8},
> +	{0x900f9, 0x85a8},
> +	{0x900fa, 0x1e8},
> +	{0x900fb, 0x68},
> +	{0x900fc, 0x798},
> +	{0x900fd, 0x16a},
> +	{0x900fe, 0x78},
> +	{0x900ff, 0x7a0},
> +	{0x90100, 0x16a},
> +	{0x90101, 0x68},
> +	{0x90102, 0x790},
> +	{0x90103, 0x16a},
> +	{0x90104, 0x8},
> +	{0x90105, 0x8b10},
> +	{0x90106, 0x168},
> +	{0x90107, 0x8},
> +	{0x90108, 0xab10},
> +	{0x90109, 0x168},
> +	{0x9010a, 0xa},
> +	{0x9010b, 0x408},
> +	{0x9010c, 0x169},
> +	{0x9010d, 0x58},
> +	{0x9010e, 0x0},
> +	{0x9010f, 0x68},
> +	{0x90110, 0x0},
> +	{0x90111, 0x408},
> +	{0x90112, 0x169},
> +	{0x90113, 0x0},
> +	{0x90114, 0x8b10},
> +	{0x90115, 0x168},
> +	{0x90116, 0x1},
> +	{0x90117, 0xab10},
> +	{0x90118, 0x168},
> +	{0x90119, 0x0},
> +	{0x9011a, 0x1d8},
> +	{0x9011b, 0x169},
> +	{0x9011c, 0x80},
> +	{0x9011d, 0x790},
> +	{0x9011e, 0x16a},
> +	{0x9011f, 0x18},
> +	{0x90120, 0x7aa},
> +	{0x90121, 0x6a},
> +	{0x90122, 0xa},
> +	{0x90123, 0x0},
> +	{0x90124, 0x1e9},
> +	{0x90125, 0x8},
> +	{0x90126, 0x8080},
> +	{0x90127, 0x108},
> +	{0x90128, 0xf},
> +	{0x90129, 0x408},
> +	{0x9012a, 0x169},
> +	{0x9012b, 0xc},
> +	{0x9012c, 0x0},
> +	{0x9012d, 0x68},
> +	{0x9012e, 0x9},
> +	{0x9012f, 0x0},
> +	{0x90130, 0x1a9},
> +	{0x90131, 0x0},
> +	{0x90132, 0x408},
> +	{0x90133, 0x169},
> +	{0x90134, 0x0},
> +	{0x90135, 0x8080},
> +	{0x90136, 0x108},
> +	{0x90137, 0x8},
> +	{0x90138, 0x7aa},
> +	{0x90139, 0x6a},
> +	{0x9013a, 0x0},
> +	{0x9013b, 0x8568},
> +	{0x9013c, 0x108},
> +	{0x9013d, 0xb7},
> +	{0x9013e, 0x790},
> +	{0x9013f, 0x16a},
> +	{0x90140, 0x1f},
> +	{0x90141, 0x0},
> +	{0x90142, 0x68},
> +	{0x90143, 0x8},
> +	{0x90144, 0x8558},
> +	{0x90145, 0x168},
> +	{0x90146, 0xf},
> +	{0x90147, 0x408},
> +	{0x90148, 0x169},
> +	{0x90149, 0xd},
> +	{0x9014a, 0x0},
> +	{0x9014b, 0x68},
> +	{0x9014c, 0x0},
> +	{0x9014d, 0x408},
> +	{0x9014e, 0x169},
> +	{0x9014f, 0x0},
> +	{0x90150, 0x8558},
> +	{0x90151, 0x168},
> +	{0x90152, 0x8},
> +	{0x90153, 0x3c8},
> +	{0x90154, 0x1a9},
> +	{0x90155, 0x3},
> +	{0x90156, 0x370},
> +	{0x90157, 0x129},
> +	{0x90158, 0x20},
> +	{0x90159, 0x2aa},
> +	{0x9015a, 0x9},
> +	{0x9015b, 0x8},
> +	{0x9015c, 0xe8},
> +	{0x9015d, 0x109},
> +	{0x9015e, 0x0},
> +	{0x9015f, 0x8140},
> +	{0x90160, 0x10c},
> +	{0x90161, 0x10},
> +	{0x90162, 0x8138},
> +	{0x90163, 0x104},
> +	{0x90164, 0x8},
> +	{0x90165, 0x448},
> +	{0x90166, 0x109},
> +	{0x90167, 0xf},
> +	{0x90168, 0x7c0},
> +	{0x90169, 0x109},
> +	{0x9016a, 0x0},
> +	{0x9016b, 0xe8},
> +	{0x9016c, 0x109},
> +	{0x9016d, 0x47},
> +	{0x9016e, 0x630},
> +	{0x9016f, 0x109},
> +	{0x90170, 0x8},
> +	{0x90171, 0x618},
> +	{0x90172, 0x109},
> +	{0x90173, 0x8},
> +	{0x90174, 0xe0},
> +	{0x90175, 0x109},
> +	{0x90176, 0x0},
> +	{0x90177, 0x7c8},
> +	{0x90178, 0x109},
> +	{0x90179, 0x8},
> +	{0x9017a, 0x8140},
> +	{0x9017b, 0x10c},
> +	{0x9017c, 0x0},
> +	{0x9017d, 0x478},
> +	{0x9017e, 0x109},
> +	{0x9017f, 0x0},
> +	{0x90180, 0x1},
> +	{0x90181, 0x8},
> +	{0x90182, 0x8},
> +	{0x90183, 0x4},
> +	{0x90184, 0x0},
> +	{0x90006, 0x8},
> +	{0x90007, 0x7c8},
> +	{0x90008, 0x109},
> +	{0x90009, 0x0},
> +	{0x9000a, 0x400},
> +	{0x9000b, 0x106},
> +	{0xd00e7, 0x400},
> +	{0x90017, 0x0},
> +	{0x9001f, 0x2b},
> +	{0x90026, 0x69},
> +	{0x400d0, 0x0},
> +	{0x400d1, 0x101},
> +	{0x400d2, 0x105},
> +	{0x400d3, 0x107},
> +	{0x400d4, 0x10f},
> +	{0x400d5, 0x202},
> +	{0x400d6, 0x20a},
> +	{0x400d7, 0x20b},
> +	{0x2003a, 0x2},
> +	{0x200be, 0x3},
> +	{0x2000b, 0x75},
> +	{0x2000c, 0xe9},
> +	{0x2000d, 0x91c},
> +	{0x2000e, 0x2c},
> +	{0x9000c, 0x0},
> +	{0x9000d, 0x173},
> +	{0x9000e, 0x60},
> +	{0x9000f, 0x6110},
> +	{0x90010, 0x2152},
> +	{0x90011, 0xdfbd},
> +	{0x90012, 0x2060},
> +	{0x90013, 0x6152},
> +	{0x20010, 0x5a},
> +	{0x20011, 0x3},
> +	{0x40080, 0xe0},
> +	{0x40081, 0x12},
> +	{0x40082, 0xe0},
> +	{0x40083, 0x12},
> +	{0x40084, 0xe0},
> +	{0x40085, 0x12},
> +	{0x400fd, 0xf},
> +	{0x400f1, 0xe},
> +	{0x10011, 0x1},
> +	{0x10012, 0x1},
> +	{0x10013, 0x180},
> +	{0x10018, 0x1},
> +	{0x10002, 0x6209},
> +	{0x100b2, 0x1},
> +	{0x101b4, 0x1},
> +	{0x102b4, 0x1},
> +	{0x103b4, 0x1},
> +	{0x104b4, 0x1},
> +	{0x105b4, 0x1},
> +	{0x106b4, 0x1},
> +	{0x107b4, 0x1},
> +	{0x108b4, 0x1},
> +	{0x11011, 0x1},
> +	{0x11012, 0x1},
> +	{0x11013, 0x180},
> +	{0x11018, 0x1},
> +	{0x11002, 0x6209},
> +	{0x110b2, 0x1},
> +	{0x111b4, 0x1},
> +	{0x112b4, 0x1},
> +	{0x113b4, 0x1},
> +	{0x114b4, 0x1},
> +	{0x115b4, 0x1},
> +	{0x116b4, 0x1},
> +	{0x117b4, 0x1},
> +	{0x118b4, 0x1},
> +	{0x20089, 0x1},
> +	{0x20088, 0x19},
> +	{0xc0080, 0x0},
> +	{0xd0000, 0x1},
> +
> +};
> +
> +static struct dram_fsp_msg ddr_dram_fsp_msg[] = {
> +	{
> +		/* P0 3733mts 1D */
> +		.drate = 3733,
> +		.fw_type = FW_1D_IMAGE,
> +		.fsp_cfg = ddr_fsp0_cfg,
> +		.fsp_cfg_num = ARRAY_SIZE(ddr_fsp0_cfg),
> +
> +	},
> +
> +	{
> +		/* P0 3733mts 2D */
> +		.drate = 3733,
> +		.fw_type = FW_2D_IMAGE,
> +		.fsp_cfg = ddr_fsp0_2d_cfg,
> +		.fsp_cfg_num = ARRAY_SIZE(ddr_fsp0_2d_cfg),
> +	},
> +
> +};
> +
> +/* ddr timing config params */
> +struct dram_timing_info dram_timing = {
> +	.ddrc_cfg = ddr_ddrc_cfg,
> +	.ddrc_cfg_num = ARRAY_SIZE(ddr_ddrc_cfg),
> +	.ddrphy_cfg = ddr_ddrphy_cfg,
> +	.ddrphy_cfg_num = ARRAY_SIZE(ddr_ddrphy_cfg),
> +	.fsp_msg = ddr_dram_fsp_msg,
> +	.fsp_msg_num = ARRAY_SIZE(ddr_dram_fsp_msg),
> +	.ddrphy_trained_csr = ddr_ddrphy_trained_csr,
> +	.ddrphy_trained_csr_num = ARRAY_SIZE(ddr_ddrphy_trained_csr),
> +	.ddrphy_pie = ddr_phy_pie,
> +	.ddrphy_pie_num = ARRAY_SIZE(ddr_phy_pie),
> +	.fsp_table = { 3733, },
> +	.fsp_cfg = ddr_dram_fsp_cfg,
> +	.fsp_cfg_num = ARRAY_SIZE(ddr_dram_fsp_cfg),
> +};
> diff --git a/board/phytec/phycore_imx93/phycore_imx93.c b/board/phytec/phycore_imx93/phycore_imx93.c
> new file mode 100644
> index 00000000000..144db4f4471
> --- /dev/null
> +++ b/board/phytec/phycore_imx93/phycore_imx93.c
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2022 NXP
> + * Copyright (C) 2023 PHYTEC Messtechnik GmbH
> + * Christoph Stoidner <c.stoidner@phytec.de>
> + * Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
> + */
> +
> +#include <env.h>
> +#include <init.h>
> +#include <miiphy.h>
> +#include <netdev.h>
> +#include <asm/global_data.h>
> +#include <asm/arch-imx9/ccm_regs.h>
> +#include <asm/arch/sys_proto.h>
> +#include <asm/arch-imx9/imx93_pins.h>
> +#include <asm/arch/clock.h>
> +#include <power/pmic.h>
> +#include <dm/device.h>
> +#include <dm/uclass.h>
> +#include <usb.h>
> +#include <dwc3-uboot.h>
> +#include <asm/gpio.h>

Can we get ride of some of the unused includes here?

> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +#define UART_PAD_CTRL	(PAD_CTL_DSE(6) | PAD_CTL_FSEL2)
> +
> +static const iomux_v3_cfg_t uart_pads[] = {
> +	MX93_PAD_UART1_RXD__LPUART1_RX | MUX_PAD_CTRL(UART_PAD_CTRL),
> +	MX93_PAD_UART1_TXD__LPUART1_TX | MUX_PAD_CTRL(UART_PAD_CTRL),
> +};
> +
> +int board_early_init_f(void)
> +{
> +	imx_iomux_v3_setup_multiple_pads(uart_pads, ARRAY_SIZE(uart_pads));

I don't think this is necessary?

You are using CONFIG_DM_SERIAL.

You may also remove above defines and board_early_init_f() all-together
further simplifying code.

Disable also CONFIG_BOARD_EARLY_INIT_F=y in that case.

> +
> +	return 0;
> +}
> +
> +int board_phy_config(struct phy_device *phydev)
> +{
> +	if (phydev->drv->config)
> +		phydev->drv->config(phydev);

No need to override default board_phy_config if it is the same.

Please remove board_phy_config.

> +
> +	return 0;
> +}
> +
> +int board_init(void)
> +{
> +	return 0;
> +}
> +
> +int board_late_init(void)
> +{
> +	env_set("sec_boot", "no");
> +	if (IS_ENABLED(CONFIG_AHAB_BOOT))
> +		env_set("sec_boot", "yes");


To support eMMC here we should add:

	switch (get_boot_device()) {
	case SD2_BOOT:
		env_set_ulong("mmcdev", 1);
		break;
	case MMC1_BOOT:
		env_set_ulong("mmcdev", 0);
		break;
	default:
		break;
	}

to dynamically set appropriate mmcdev. Otherwise you would boot from
eMMC and then load the rest of binaries from SD-card.

> +
> +	return 0;
> +}
> diff --git a/board/phytec/phycore_imx93/phycore_imx93.env b/board/phytec/phycore_imx93/phycore_imx93.env
> new file mode 100644
> index 00000000000..6af6624f97d
> --- /dev/null
> +++ b/board/phytec/phycore_imx93/phycore_imx93.env
> @@ -0,0 +1,96 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +
> +image=Image
> +console=ttyLP0
> +fdt_addr=0x83000000
> +fdto_addr=0x830c0000
> +bootenv_addr=0x83500000
> +fdt_file=CONFIG_DEFAULT_FDT_FILE
> +ipaddr=192.168.3.11
> +serverip=192.168.3.10
> +netmask=255.255.255.0
> +ip_dyn=no
> +bootenv=bootenv.txt
> +mmc_load_bootenv=fatload mmc ${mmcdev}:${mmcpart} ${bootenv_addr} ${bootenv}
> +mmcdev=__stringify(CONFIG_SYS_MMC_ENV_DEV)
> +mmcpart=1
> +mmcroot=2
> +mmcautodetect=yes
> +mmcargs=setenv bootargs console=${console},${baudrate} earlycon
> +	root=/dev/mmcblk${mmcdev}p${mmcroot} rootwait rw
> +loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
> +loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr} ${fdt_file}
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
> +netargs=setenv bootargs console=${console},${baudrate} earlycon
> +	root=/dev/nfs ip=${nfsip} nfsroot=${serverip}:${nfsroot},v3,tcp
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
> +bsp_bootcmd=echo Running BSP bootcmd ...;> +        mmc dev ${mmcdev}; if mmc rescan; then
> +          if run loadbootscript; then
> +          run bootscript;
> +          else
> +          if test ${sec_boot} = yes; then
> +                   if run loadcntr; then
> +                          run mmcboot;
> +                   else run netboot;
> +                   fi;
> +            else
> +                   if run loadimage; then
> +                           run mmcboot;
> +                   else run netboot;
> +                   fi;
> +                fi;
> +          fi;
> +         fi;

Please use tabs here instead of spaces here?

IMHO I would disable distroboot and sync with downstream.
From my tests it also doesn't work so +1 to remove bsp_bootcmd here.


> diff --git a/board/phytec/phycore_imx93/spl.c b/board/phytec/phycore_imx93/spl.c
> new file mode 100644
> index 00000000000..dbf9ebd96ec
> --- /dev/null
> +++ b/board/phytec/phycore_imx93/spl.c
> @@ -0,0 +1,182 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2022 NXP
> + * Copyright (C) 2023 PHYTEC Messtechnik GmbH
> + * Christoph Stoidner <c.stoidner@phytec.de>
> + * Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
> + */
> +
> +#include <command.h>
> +#include <cpu_func.h>
> +#include <hang.h>
> +#include <image.h>
> +#include <init.h>
> +#include <log.h>
> +#include <spl.h>
> +#include <asm/global_data.h>
> +#include <asm/io.h>
> +#include <asm/arch/imx93_pins.h>
> +#include <asm/arch/clock.h>
> +#include <asm/arch/sys_proto.h>
> +#include <asm/mach-imx/boot_mode.h>
> +#include <asm/mach-imx/mxc_i2c.h>
> +#include <asm/arch-mx7ulp/gpio.h>
> +#include <asm/sections.h>
> +#include <asm/mach-imx/syscounter.h>
> +#include <asm/mach-imx/ele_api.h>
> +#include <dm/uclass.h>
> +#include <dm/device.h>
> +#include <dm/uclass-internal.h>
> +#include <dm/device-internal.h>
> +#include <linux/delay.h>
> +#include <asm/arch/clock.h>
> +#include <asm/arch/ccm_regs.h>
> +#include <asm/arch/ddr.h>
> +#include <power/pmic.h>
> +#include <power/pca9450.h>
> +#include <asm/arch/trdc.h>

Can we get rid of unused includes here?

> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +/*
> + * Will be part of drivers/power/regulator/pca9450.c
> + * when pca9451a support is added.
> + */
> +#define PCA9450_REG_PWRCTRL_TOFF_DEB    BIT(5)
> +
> +int spl_board_boot_device(enum boot_device boot_dev_spl)
> +{
> +	if (IS_ENABLED(CONFIG_SPL_BOOTROM_SUPPORT))
> +		return BOOT_DEVICE_BOOTROM;
> +
> +	switch (boot_dev_spl) {
> +	case SD1_BOOT:
> +	case MMC1_BOOT:
> +		return BOOT_DEVICE_MMC1;
> +	case SD2_BOOT:
> +	case MMC2_BOOT:
> +		return BOOT_DEVICE_MMC2;
> +	default:
> +		return BOOT_DEVICE_NONE;

Can we remove switch-case constructs and rely on BOOTROM here:

int spl_board_boot_device(enum boot_device boot_dev_spl)
{
	return BOOT_DEVICE_BOOTROM;
}

> +	}
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
> +	if (!IS_ENABLED(CONFIG_DM_PMIC_PCA9450))
> +		return 0;
> +
> +	ret = pmic_get("pmic@25", &dev);
> +	if (ret == -ENODEV) {
> +		puts("No pca9450@25\n");
> +		return 0;
> +	}
> +	if (ret != 0)

Insert a new-line above this if statement.

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
> +
> +	val = ret

Remove new-line above this statement and add it bellow.

> +	if (IS_ENABLED(CONFIG_IMX9_LOW_DRIVE_MODE)) {
> +		/* 0.8v for Low drive mode
> +		 */
> +		if (val & PCA9450_REG_PWRCTRL_TOFF_DEB) {
> +			pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, 0x0c);
> +			pmic_reg_write(dev, PCA9450_BUCK3OUT_DVS0, 0x0c);
> +		} else {
> +			pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, 0x10);
> +			pmic_reg_write(dev, PCA9450_BUCK3OUT_DVS0, 0x10);
> +		}
> +	} else {
> +		/* 0.9v for Over drive mode
> +		 */
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
> +	board_early_init_f();
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
> index 00000000000..befe8723898
> --- /dev/null
> +++ b/configs/imx93-phyboard-segin_defconfig
> @@ -0,0 +1,147 @@

Hummm lots of unused stuff is enabled.

I will drop a comment on obvious ones.

Maybe run savedefconfig to get rid of some stuff automatically?

> +CONFIG_ARM=y
> +CONFIG_ARCH_IMX9=y
> +CONFIG_TEXT_BASE=0x80200000
> +CONFIG_SYS_MALLOC_LEN=0x2000000
> +CONFIG_SYS_MALLOC_F_LEN=0x18000
> +CONFIG_SPL_LIBCOMMON_SUPPORT=y
> +CONFIG_SPL_LIBGENERIC_SUPPORT=y
> +CONFIG_NR_DRAM_BANKS=2
> +CONFIG_ENV_SIZE=0x4000

Please set size to 0x10000 like in the downstream.

> +CONFIG_ENV_OFFSET=0x700000

Can we also enable the redundant env at offset:

CONFIG_ENV_OFFSET_REDUND=0x720000

like we did in downstream?

I would like it to be in sync.


> +CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/imximage.cfg"
> +CONFIG_DM_GPIO=y
> +CONFIG_DEFAULT_DEVICE_TREE="imx93-phyboard-segin"
> +CONFIG_SPL_TEXT_BASE=0x2049A000
> +CONFIG_TARGET_PHYCORE_IMX93=y
> +CONFIG_OF_LIBFDT_OVERLAY=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_SPL_DRIVERS_MISC=y
> +CONFIG_SPL_STACK=0x20519dd0
> +CONFIG_SPL=y
> +CONFIG_CMD_DEKBLOB=y
> +CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x88000000
> +CONFIG_SPL_LOAD_IMX_CONTAINER=y
> +CONFIG_SYS_LOAD_ADDR=0x80400000
> +CONFIG_SYS_MEMTEST_START=0x80000000
> +CONFIG_SYS_MEMTEST_END=0x90000000
> +CONFIG_REMAKE_ELF=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SYS_MONITOR_LEN=524288
> +CONFIG_DISTRO_DEFAULTS=y
> +CONFIG_BOOTDELAY=1

Remove BOOTDELAY=1 will use default.

> +CONFIG_OF_SYSTEM_SETUP=y
> +CONFIG_BOOTCOMMAND="run distro_bootcmd;run bsp_bootcmd"

IMHO not sure if we want to go with distro_bootcmd here...

If you decide to disable it, please go with downstream
CONFIG_BOOTCOMMAND here:

"mmc dev ${mmcdev}; if mmc rescan; then if run loadimage; then run
mmcboot; else run netboot; fi; fi;"


> +CONFIG_DEFAULT_FDT_FILE="imx93-phyboard-segin.dtb"

PHYTEC uses "oftree" for CONFIG_DEFAULT_FDT_FILE and then symlinks
correct dtb in yocto. Please rename.

> +CONFIG_BOARD_EARLY_INIT_F=y

Like said above, you can remove BOARD_EARLY_INIT_F if it becomes a dummy
function.

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
> +CONFIG_SYS_PROMPT="u-boot=> "
> +CONFIG_SYS_MAXARGS=64
> +CONFIG_SYS_CBSIZE=2048
> +CONFIG_SYS_PBSIZE=2074
> +CONFIG_CMD_ERASEENV=y
> +CONFIG_CMD_NVEDIT_EFI=y
> +CONFIG_CRC32_VERIFY=y
> +CONFIG_CMD_MEMTEST=y
> +CONFIG_CMD_CLK=y
> +CONFIG_CMD_DFU=y
> +CONFIG_CMD_FUSE=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_POWEROFF=y
> +CONFIG_CMD_READ=y
> +CONFIG_CMD_WDT=y
> +CONFIG_BOOTP_PREFER_SERVERIP=y

Not sure we want to have CONFIG_BOOTP_PREFER_SERVERIP enabled by
default. See ip_dyn variable in phycore_imx93.env.

> +CONFIG_CMD_SNTP=y
> +CONFIG_CMD_BMP=y

Disable CMD_BMP as FB is not supported in bootloader.

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

What about adding CONFIG_ENV_IS_IN_MMC=y here?

Downstream u-boot stores env in MMC.

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
> +CONFIG_DM_PCA953X=y

No PCA953x on phyCORE-i.MX93, disable.

> +CONFIG_DM_I2C=y
> +CONFIG_SYS_I2C_IMX_LPI2C=y
> +CONFIG_SUPPORT_EMMC_BOOT=y
> +CONFIG_MMC_IO_VOLTAGE=y
> +CONFIG_MMC_UHS_SUPPORT=y
> +CONFIG_MMC_HS400_ES_SUPPORT=y
> +CONFIG_MMC_HS400_SUPPORT=y
> +CONFIG_FSL_USDHC=y
> +CONFIG_DM_SPI_FLASH=y

No SPI flash on phyCORE-i.MX93, you can disable it.

> +CONFIG_SF_DEFAULT_SPEED=40000000
> +CONFIG_SPI_FLASH_STMICRO=y
> +CONFIG_PHY_REALTEK=y

No realtek PHY, disable it.

> +CONFIG_DM_ETH_PHY=y
> +CONFIG_PHY_GIGE=y

No GIGE PHY, disable it.


Can you enable CONFIG_PHY_TI_GENERIC though since we have TI eth phy?

> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_IMX=y
> +CONFIG_FEC_MXC=y
> +CONFIG_MII=y
> +CONFIG_MIPI_DPHY_HELPERS=y
> +CONFIG_PHY_IMX93_MIPI_DPHY=y

Disable MIPI stuff

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
> +CONFIG_RTC_PCF2131=y

No such RTC on phyCORE-i.MX93, disable it.

> +CONFIG_DM_SERIAL=y
> +CONFIG_FSL_LPUART=y
> +CONFIG_SPI=y
> +CONFIG_DM_SPI=y
> +CONFIG_NXP_FSPI=y
> +CONFIG_DM_THERMAL=y
> +CONFIG_IMX_TMU=y
> +CONFIG_ULP_WATCHDOG=y
> +CONFIG_WDT=y
> +CONFIG_LZO=y
> +CONFIG_BZIP2=y
> diff --git a/doc/board/phytec/imx93-phyboard-segin.rst b/doc/board/phytec/imx93-phyboard-segin.rst
> new file mode 100644
> index 00000000000..5793cafcedc
> --- /dev/null
> +++ b/doc/board/phytec/imx93-phyboard-segin.rst
> @@ -0,0 +1,61 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +phyCORE-i.MX 93 on a phyBOARD-Segin
> +===================================

Replace title with:

phyBOARD-Segin-i.MX93

> +
> +U-Boot for the phyCORE-i.MX 93 on a phyBOARD-Segin.

same here, use:

U-Boot for the phyBOARD-Segin-i.MX93.

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

We have to start thinking about i.MX93 A1 SoC REVs here...

But for now, leave as is, we can fix it later for all the in-tree i.MX93
boards.

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
> index 00000000000..95ec1fd4c9c
> --- /dev/null
> +++ b/include/configs/phycore_imx93.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2022 NXP
> + * Copyright (C) 2023 PHYTEC Messtechnik GmbH
> + * Christoph Stoidner <c.stoidner@phytec.de>
> + */
> +
> +#ifndef __IMX93_PHYBOARD_SEGIN_H
> +#define __IMX93_PHYBOARD_SEGIN_H

Please rename this to __IMX93_PHYCORE_H
> +
> +#include <linux/sizes.h>
> +#include <linux/stringify.h>

Drop stringify.h here, not required as we are using .env file.

> +#include <asm/arch/imx-regs.h>
> +
> +#define CFG_SYS_UBOOT_BASE	\
> +	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
> +

If you decide to drop distroboot, please drop all distro_bootcmd related
stuff from here.

> +#define BOOT_TARGET_DEVICES(func) \
> +	func(MMC, mmc, 0) \
> +	func(MMC, mmc, 1)
> +
> +#include <config_distro_bootcmd.h>> +
> +/* Initial environment variables */
> +#define CFG_EXTRA_ENV_SETTINGS BOOTENV
> +
> +#define CFG_SYS_INIT_RAM_ADDR        0x80000000
> +#define CFG_SYS_INIT_RAM_SIZE        0x200000
> +
> +#define CFG_SYS_SDRAM_BASE           0x80000000
> +#define PHYS_SDRAM                   0x80000000
> +#define PHYS_SDRAM_SIZE              0x80000000
> +
> +#define CFG_SYS_FSL_USDHC_NUM	2

Can we drop this define if not used?

> +
> +/* Using ULP WDOG for reset */
> +#define WDOG_BASE_ADDR          WDG3_BASE_ADDR
> +
> +#if defined(CONFIG_CMD_NET)
> +#define PHY_ANEG_TIMEOUT 20000
> +#endif

Please, drop this PHY_ANEG_TIMEOUT stuff, it is not required.

> +
> +#ifdef CONFIG_IMX_MATTER_TRUSTY
> +#define NS_ARCH_ARM64 1
> +#endif

Drop CONFIG_IMX_MATTER_TRUSTY, this is only available in u-boot-imx?

> +
> +#endif

BR,
Primoz


-- 
Primoz Fiser                    | phone: +386-41-540-545
<tel:+386-41-390-545> |
---------------------------------------------------------|
Norik systems d.o.o.            | https://www.norik.com
<https://www.norik.com>  |
Your embedded software partner  | email: info@norik.com
<mailto:info@norik.com> |
Slovenia, EU                    | phone: +386-41-540-545
<tel:+386-41-540-545> |

