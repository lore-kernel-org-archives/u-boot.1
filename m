Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72EBC47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 21:53:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB43987971;
	Wed, 17 Jan 2024 22:53:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E6FF87889; Wed, 17 Jan 2024 22:53:32 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 53EC58798C
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 22:53:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA4CE11FB;
 Wed, 17 Jan 2024 13:54:15 -0800 (PST)
Received: from minigeek.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A4113F73F;
 Wed, 17 Jan 2024 13:53:28 -0800 (PST)
Date: Wed, 17 Jan 2024 21:52:45 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Nick Alilovic <nickalilovic@gmail.com>
Cc: u-boot@lists.denx.de, jagan@amarulasolutions.com,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 1/2] arm: dts: Transpeed 8K618-T: Add Transpeed 8K618-T
 board support
Message-ID: <20240117215245.65fc0282@minigeek.lan>
In-Reply-To: <20240117163756.63875-1-nickalilovic@gmail.com>
References: <20240117163756.63875-1-nickalilovic@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
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

On Wed, 17 Jan 2024 11:37:55 -0500
Nick Alilovic <nickalilovic@gmail.com> wrote:

Hi Nick,

> This is the DT I used from the Linux kernel. Made changes to the Makefile to build the new DTB.

thanks, I will copy in this file along with other changes during the
upcoming DT sync, with all the sunxi DT bits queued for Linux v6.8 -
after the merge window closes. Weather permitting ;-) this should be
early next week.

Cheers,
Andre

> Signed-off-by: Nick Alilovic <nickalilovic@gmail.com>
> ---
>  arch/arm/dts/Makefile                         |   1 +
>  .../arm/dts/sun50i-h618-transpeed-8k618-t.dts | 161 ++++++++++++++++++
>  2 files changed, 162 insertions(+)
>  create mode 100644 arch/arm/dts/sun50i-h618-transpeed-8k618-t.dts
> 
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index d456a524b3..cacd21558a 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -836,6 +836,7 @@ dtb-$(CONFIG_MACH_SUN50I_H6) += \
>  dtb-$(CONFIG_MACH_SUN50I_H616) += \
>  	sun50i-h616-orangepi-zero2.dtb \
>  	sun50i-h618-orangepi-zero3.dtb \
> +	sun50i-h618-transpeed-8k618-t.dtb \
>  	sun50i-h616-x96-mate.dtb
>  dtb-$(CONFIG_MACH_SUN50I) += \
>  	sun50i-a64-amarula-relic.dtb \
> diff --git a/arch/arm/dts/sun50i-h618-transpeed-8k618-t.dts b/arch/arm/dts/sun50i-h618-transpeed-8k618-t.dts
> new file mode 100644
> index 0000000000..8ea1fd41ae
> --- /dev/null
> +++ b/arch/arm/dts/sun50i-h618-transpeed-8k618-t.dts
> @@ -0,0 +1,161 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2023 Arm Ltd.
> + */
> +
> +/dts-v1/;
> +
> +#include "sun50i-h616.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	model = "Transpeed 8K618-T";
> +	compatible = "transpeed,8k618-t", "allwinner,sun50i-h618";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	reg_vcc5v: vcc5v {
> +		/* board wide 5V supply directly from the DC input */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc-5v";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +	};
> +
> +	reg_vcc3v3: vcc3v3 {
> +		/* discrete 3.3V regulator */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc-3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +	};
> +};
> +
> +&ehci0 {
> +	status = "okay";
> +};
> +
> +&ehci1 {
> +	status = "okay";
> +};
> +
> +&ir {
> +	status = "okay";
> +};
> +
> +&mmc0 {
> +	vmmc-supply = <&reg_dldo1>;
> +	cd-gpios = <&pio 8 16 GPIO_ACTIVE_LOW>;	/* PI16 */
> +	bus-width = <4>;
> +	status = "okay";
> +};
> +
> +&mmc2 {
> +	vmmc-supply = <&reg_dldo1>;
> +	vqmmc-supply = <&reg_aldo1>;
> +	bus-width = <8>;
> +	non-removable;
> +	cap-mmc-hw-reset;
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +	status = "okay";
> +};
> +
> +&ohci0 {
> +	status = "okay";
> +};
> +
> +&ohci1 {
> +	status = "okay";
> +};
> +
> +&r_i2c {
> +	status = "okay";
> +
> +	axp313: pmic@36 {
> +		compatible = "x-powers,axp313a";
> +		reg = <0x36>;
> +		#interrupt-cells = <1>;
> +		interrupt-controller;
> +
> +		vin1-supply = <&reg_vcc5v>;
> +		vin2-supply = <&reg_vcc5v>;
> +		vin3-supply = <&reg_vcc5v>;
> +
> +		regulators {
> +			reg_aldo1: aldo1 {
> +				regulator-always-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "vcc-1v8-pll";
> +			};
> +
> +			reg_dldo1: dldo1 {
> +				regulator-always-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vcc-3v3-io-mmc";
> +			};
> +
> +			reg_dcdc1: dcdc1 {
> +				regulator-always-on;
> +				regulator-min-microvolt = <810000>;
> +				regulator-max-microvolt = <990000>;
> +				regulator-name = "vdd-gpu-sys";
> +			};
> +
> +			reg_dcdc2: dcdc2 {
> +				regulator-always-on;
> +				regulator-min-microvolt = <810000>;
> +				regulator-max-microvolt = <1100000>;
> +				regulator-name = "vdd-cpu";
> +			};
> +
> +			reg_dcdc3: dcdc3 {
> +				regulator-always-on;
> +				regulator-min-microvolt = <1360000>;
> +				regulator-max-microvolt = <1360000>;
> +				regulator-name = "vdd-dram";
> +			};
> +		};
> +	};
> +};
> +
> +&pio {
> +	vcc-pc-supply = <&reg_aldo1>;
> +	vcc-pg-supply = <&reg_dldo1>;
> +	vcc-ph-supply = <&reg_dldo1>;
> +	vcc-pi-supply = <&reg_dldo1>;
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_ph_pins>;
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
> +	uart-has-rtscts;
> +	status = "okay";
> +};
> +
> +&usbotg {
> +	dr_mode = "host";	/* USB A type receptable */
> +	status = "okay";
> +};
> +
> +&usbphy {
> +	status = "okay";
> +};

