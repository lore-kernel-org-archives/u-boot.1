Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C79CD3427
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 12:28:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91BE3846DB;
	Sun, 10 May 2026 14:27:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="HcOMQ31f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0FEF846EB; Sun, 10 May 2026 14:27:53 +0200 (CEST)
Received: from mail-m17201.xmail.ntesmail.com (mail-m17201.xmail.ntesmail.com
 [45.195.17.201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FA0383EEF
 for <u-boot@lists.denx.de>; Sun, 10 May 2026 14:27:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from smtpclient.apple (unknown [59.56.83.249])
 by smtp.qiye.163.com (Hmail) with ESMTP id 3dd2090e1;
 Sun, 10 May 2026 20:27:42 +0800 (GMT+08:00)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v2 2/5] rockchip: Switch rk3229 boards to upstream
 devicetree
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <3d1a006b-3e39-4e5d-827c-2ce74ef1e6c2@gmail.com>
Date: Sun, 10 May 2026 20:27:32 +0800
Cc: philipp.tomsich@vrull.eu, sjg@chromium.org, trini@konsulko.com,
 afaerber@suse.de, =?utf-8?B?6Zer5a2d5Yab?= <andy.yan@rock-chips.com>,
 u-boot@lists.denx.de, quentin.schulz@cherry.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <8F02B311-2F45-40F7-89C0-AFBCA4B35D8E@rock-chips.com>
References: <a5bb85ba-c159-4ac0-a1e3-4be1c6db1441@gmail.com>
 <3d1a006b-3e39-4e5d-827c-2ce74ef1e6c2@gmail.com>
To: Johan Jonker <jbx6244@gmail.com>
X-Mailer: Apple Mail (2.3864.400.21)
X-HM-Tid: 0a9e11db91b803afkunm281049625396fb
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaShlOVklIGB9NHU5NTEsdSFYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlOQlVOTVVDSFVJT0JZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=HcOMQ31fbRHemT+9Kv4OoXsjiXQwa7MJ7as/YxlFVOxSTgsOwL1wv7Ndgxiz0jOGSzV+zABI0lM4K7i8FFCSp9jHnEGbM1CLM+nOyJTq/9751NAAVzUpLjMKnfophvkPFGhxrMrOCvAiQQzTGW0fpKvt2ZSMGlzY+2mZnSSkjg0=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=Z298l8W5dsizviu5h2iTiE9KmbVF8M46SjCAQP6o/wI=;
 h=date:mime-version:subject:message-id:from;
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

Hi Johan,


> 2026=E5=B9=B45=E6=9C=888=E6=97=A5 02:38=EF=BC=8CJohan Jonker =
<jbx6244@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Switch rk3229 boards to upstream devicetree.
>=20
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>=20
> Changed V2:
> remove rk322x.dtsi
> ---
> arch/arm/dts/Makefile                  |    3 -
> arch/arm/dts/rk3229-evb.dts            |  256 -----
> arch/arm/dts/rk3229.dtsi               |   52 -
> arch/arm/dts/rk322x.dtsi               | 1293 ------------------------
> arch/arm/mach-rockchip/Kconfig         |    1 +
> board/rockchip/evb_rk3229/MAINTAINERS  |    1 -
> configs/evb-rk3229_defconfig           |    4 +-
> include/dt-bindings/clock/rk3228-cru.h |  287 ------
> 8 files changed, 3 insertions(+), 1894 deletions(-)
> delete mode 100644 arch/arm/dts/rk3229-evb.dts
> delete mode 100644 arch/arm/dts/rk3229.dtsi
> delete mode 100644 arch/arm/dts/rk322x.dtsi
> delete mode 100644 include/dt-bindings/clock/rk3228-cru.h
>=20
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index fdd057fdfe6c..7b2847804835 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -52,9 +52,6 @@ dtb-$(CONFIG_MACH_S900) +=3D \
> dtb-$(CONFIG_MACH_S700) +=3D \
> 	s700-cubieboard7.dtb
>=20
> -dtb-$(CONFIG_ROCKCHIP_RK322X) +=3D \
> -	rk3229-evb.dtb
> -
> dtb-$(CONFIG_ROCKCHIP_RK3368) +=3D \
> 	rk3368-sheep.dtb \
> 	rk3368-geekbox.dtb \
> diff --git a/arch/arm/dts/rk3229-evb.dts b/arch/arm/dts/rk3229-evb.dts
> deleted file mode 100644
> index 797476e8bef1..000000000000
> --- a/arch/arm/dts/rk3229-evb.dts
> +++ /dev/null
> @@ -1,256 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -
> -/dts-v1/;
> -
> -#include <dt-bindings/input/input.h>
> -#include "rk3229.dtsi"
> -
> -/ {
> -	model =3D "Rockchip RK3229 Evaluation board";
> -	compatible =3D "rockchip,rk3229-evb", "rockchip,rk3229";
> -
> -	aliases {
> -		mmc0 =3D &emmc;
> -	};
> -
> -	memory@60000000 {
> -		device_type =3D "memory";
> -		reg =3D <0x60000000 0x40000000>;
> -	};
> -
> -	dc_12v: dc-12v-regulator {
> -		compatible =3D "regulator-fixed";
> -		regulator-name =3D "dc_12v";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt =3D <12000000>;
> -		regulator-max-microvolt =3D <12000000>;
> -	};
> -
> -	ext_gmac: ext_gmac {
> -		compatible =3D "fixed-clock";
> -		clock-frequency =3D <125000000>;
> -		clock-output-names =3D "ext_gmac";
> -		#clock-cells =3D <0>;
> -	};
> -
> -	vcc_host: vcc-host-regulator {
> -		compatible =3D "regulator-fixed";
> -		enable-active-high;
> -		gpio =3D <&gpio3 RK_PC4 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&host_vbus_drv>;
> -		regulator-name =3D "vcc_host";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		vin-supply =3D <&vcc_sys>;
> -	};
> -
> -	vcc_phy: vcc-phy-regulator {
> -		compatible =3D "regulator-fixed";
> -		enable-active-high;
> -		regulator-name =3D "vcc_phy";
> -		regulator-min-microvolt =3D <1800000>;
> -		regulator-max-microvolt =3D <1800000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -		vin-supply =3D <&vccio_1v8>;
> -	};
> -
> -	vcc_sys: vcc-sys-regulator {
> -		compatible =3D "regulator-fixed";
> -		regulator-name =3D "vcc_sys";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt =3D <5000000>;
> -		regulator-max-microvolt =3D <5000000>;
> -		vin-supply =3D <&dc_12v>;
> -	};
> -
> -	vccio_1v8: vccio-1v8-regulator {
> -		compatible =3D "regulator-fixed";
> -		regulator-name =3D "vccio_1v8";
> -		regulator-min-microvolt =3D <1800000>;
> -		regulator-max-microvolt =3D <1800000>;
> -		regulator-always-on;
> -		vin-supply =3D <&vcc_sys>;
> -	};
> -
> -	vccio_3v3: vccio-3v3-regulator {
> -		compatible =3D "regulator-fixed";
> -		regulator-name =3D "vccio_3v3";
> -		regulator-min-microvolt =3D <3300000>;
> -		regulator-max-microvolt =3D <3300000>;
> -		regulator-always-on;
> -		vin-supply =3D <&vcc_sys>;
> -	};
> -
> -	vdd_arm: vdd-arm-regulator {
> -		compatible =3D "pwm-regulator";
> -		pwms =3D <&pwm1 0 25000 1>;
> -		pwm-supply =3D <&vcc_sys>;
> -		regulator-name =3D "vdd_arm";
> -		regulator-min-microvolt =3D <950000>;
> -		regulator-max-microvolt =3D <1400000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -	};
> -
> -	vdd_log: vdd-log-regulator {
> -		compatible =3D "pwm-regulator";
> -		pwms =3D <&pwm2 0 25000 1>;
> -		pwm-supply =3D <&vcc_sys>;
> -		regulator-name =3D "vdd_log";
> -		regulator-min-microvolt =3D <1000000>;
> -		regulator-max-microvolt =3D <1300000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -	};
> -
> -	gpio_keys {
> -		compatible =3D "gpio-keys";
> -		autorepeat;
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&pwr_key>;
> -
> -		power_key: power-key {
> -			label =3D "GPIO Key Power";
> -			gpios =3D <&gpio3 23 GPIO_ACTIVE_LOW>;
> -			linux,code =3D <KEY_POWER>;
> -			debounce-interval =3D <100>;
> -			wakeup-source;
> -		};
> -	};
> -};
> -
> -&cpu0 {
> -	cpu-supply =3D <&vdd_arm>;
> -};
> -
> -&cpu1 {
> -	cpu-supply =3D <&vdd_arm>;
> -};
> -
> -&cpu2 {
> -	cpu-supply =3D <&vdd_arm>;
> -};
> -
> -&cpu3 {
> -	cpu-supply =3D <&vdd_arm>;
> -};
> -
> -&emmc {
> -	cap-mmc-highspeed;
> -	non-removable;
> -	status =3D "okay";
> -};
> -
> -&gmac {
> -	assigned-clocks =3D <&cru SCLK_MAC_EXTCLK>, <&cru SCLK_MAC>;
> -	assigned-clock-parents =3D <&ext_gmac>, <&cru SCLK_MAC_EXTCLK>;
> -	clock_in_out =3D "input";
> -	phy-supply =3D <&vcc_phy>;
> -	phy-mode =3D "rgmii";
> -	pinctrl-names =3D "default";
> -	pinctrl-0 =3D <&rgmii_pins>;
> -	snps,reset-gpio =3D <&gpio2 RK_PD0 GPIO_ACTIVE_LOW>;
> -	snps,reset-active-low;
> -	snps,reset-delays-us =3D <0 10000 1000000>;
> -	tx_delay =3D <0x30>;
> -	rx_delay =3D <0x10>;
> -	status =3D "okay";
> -};
> -
> -&io_domains {
> -	status =3D "okay";
> -
> -	vccio1-supply =3D <&vccio_3v3>;
> -	vccio2-supply =3D <&vccio_1v8>;
> -	vccio4-supply =3D <&vccio_3v3>;
> -};
> -
> -&pinctrl {
> -	keys {
> -		pwr_key: pwr-key {
> -			rockchip,pins =3D <3 RK_PC7 RK_FUNC_GPIO =
&pcfg_pull_up>;
> -		};
> -	};
> -
> -	usb {
> -		host_vbus_drv: host-vbus-drv {
> -			rockchip,pins =3D <3 RK_PC4 RK_FUNC_GPIO =
&pcfg_pull_none>;
> -		};
> -	};
> -};
> -
> -&pwm1 {
> -	status =3D "okay";
> -};
> -
> -&pwm2 {
> -	status =3D "okay";
> -};
> -
> -&tsadc {
> -	rockchip,hw-tshut-mode =3D <0>; /* tshut mode 0:CRU 1:GPIO */
> -	status =3D "okay";
> -};
> -
> -&uart2 {
> -	status =3D "okay";
> -};
> -
> -&u2phy0 {
> -	status =3D "okay";
> -
> -	u2phy0_otg: otg-port {
> -		status =3D "okay";
> -	};
> -
> -	u2phy0_host: host-port {
> -		phy-supply =3D <&vcc_host>;
> -		status =3D "okay";
> -	};
> -};
> -
> -&u2phy1 {
> -	status =3D "okay";
> -
> -	u2phy1_otg: otg-port {
> -		phy-supply =3D <&vcc_host>;
> -		status =3D "okay";
> -	};
> -
> -	u2phy1_host: host-port {
> -		phy-supply =3D <&vcc_host>;
> -		status =3D "okay";
> -	};
> -};
> -
> -&usb_host0_ehci {
> -	status =3D "okay";
> -};
> -
> -&usb_host0_ohci {
> -	status =3D "okay";
> -};
> -
> -&usb_host1_ehci {
> -	status =3D "okay";
> -};
> -
> -&usb_host1_ohci {
> -	status =3D "okay";
> -};
> -
> -&usb_host2_ehci {
> -	status =3D "okay";
> -};
> -
> -&usb_host2_ohci {
> -	status =3D "okay";
> -};
> -
> -&usb_otg {
> -	status =3D "okay";
> -};
> diff --git a/arch/arm/dts/rk3229.dtsi b/arch/arm/dts/rk3229.dtsi
> deleted file mode 100644
> index c340fb30e775..000000000000
> --- a/arch/arm/dts/rk3229.dtsi
> +++ /dev/null
> @@ -1,52 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2017 Fuzhou Rockchip Electronics Co., Ltd
> - */
> -
> -#include "rk322x.dtsi"
> -
> -/ {
> -	compatible =3D "rockchip,rk3229";
> -
> -	/delete-node/ opp-table0;
> -
> -	cpu0_opp_table: opp-table-0 {
> -		compatible =3D "operating-points-v2";
> -		opp-shared;
> -
> -		opp-408000000 {
> -			opp-hz =3D /bits/ 64 <408000000>;
> -			opp-microvolt =3D <950000>;
> -			clock-latency-ns =3D <40000>;
> -			opp-suspend;
> -		};
> -		opp-600000000 {
> -			opp-hz =3D /bits/ 64 <600000000>;
> -			opp-microvolt =3D <975000>;
> -		};
> -		opp-816000000 {
> -			opp-hz =3D /bits/ 64 <816000000>;
> -			opp-microvolt =3D <1000000>;
> -		};
> -		opp-1008000000 {
> -			opp-hz =3D /bits/ 64 <1008000000>;
> -			opp-microvolt =3D <1175000>;
> -		};
> -		opp-1200000000 {
> -			opp-hz =3D /bits/ 64 <1200000000>;
> -			opp-microvolt =3D <1275000>;
> -		};
> -		opp-1296000000 {
> -			opp-hz =3D /bits/ 64 <1296000000>;
> -			opp-microvolt =3D <1325000>;
> -		};
> -		opp-1392000000 {
> -			opp-hz =3D /bits/ 64 <1392000000>;
> -			opp-microvolt =3D <1375000>;
> -		};
> -		opp-1464000000 {
> -			opp-hz =3D /bits/ 64 <1464000000>;
> -			opp-microvolt =3D <1400000>;
> -		};
> -	};
> -};
> diff --git a/arch/arm/dts/rk322x.dtsi b/arch/arm/dts/rk322x.dtsi
> deleted file mode 100644
> index 8eed9e3a92e9..000000000000
> --- a/arch/arm/dts/rk322x.dtsi
> +++ /dev/null
> @@ -1,1293 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/interrupt-controller/irq.h>
> -#include <dt-bindings/interrupt-controller/arm-gic.h>
> -#include <dt-bindings/pinctrl/rockchip.h>
> -#include <dt-bindings/clock/rk3228-cru.h>
> -#include <dt-bindings/thermal/thermal.h>
> -#include <dt-bindings/power/rk3228-power.h>
> -
> -/ {
> -	#address-cells =3D <1>;
> -	#size-cells =3D <1>;
> -
> -	interrupt-parent =3D <&gic>;
> -
> -	aliases {
> -		serial0 =3D &uart0;
> -		serial1 =3D &uart1;
> -		serial2 =3D &uart2;
> -		spi0 =3D &spi0;
> -	};
> -
> -	cpus {
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
> -
> -		cpu0: cpu@f00 {
> -			device_type =3D "cpu";
> -			compatible =3D "arm,cortex-a7";
> -			reg =3D <0xf00>;
> -			resets =3D <&cru SRST_CORE0>;
> -			operating-points-v2 =3D <&cpu0_opp_table>;
> -			#cooling-cells =3D <2>; /* min followed by max =
*/
> -			clock-latency =3D <40000>;
> -			clocks =3D <&cru ARMCLK>;
> -			enable-method =3D "psci";
> -		};
> -
> -		cpu1: cpu@f01 {
> -			device_type =3D "cpu";
> -			compatible =3D "arm,cortex-a7";
> -			reg =3D <0xf01>;
> -			resets =3D <&cru SRST_CORE1>;
> -			operating-points-v2 =3D <&cpu0_opp_table>;
> -			#cooling-cells =3D <2>; /* min followed by max =
*/
> -			enable-method =3D "psci";
> -		};
> -
> -		cpu2: cpu@f02 {
> -			device_type =3D "cpu";
> -			compatible =3D "arm,cortex-a7";
> -			reg =3D <0xf02>;
> -			resets =3D <&cru SRST_CORE2>;
> -			operating-points-v2 =3D <&cpu0_opp_table>;
> -			#cooling-cells =3D <2>; /* min followed by max =
*/
> -			enable-method =3D "psci";
> -		};
> -
> -		cpu3: cpu@f03 {
> -			device_type =3D "cpu";
> -			compatible =3D "arm,cortex-a7";
> -			reg =3D <0xf03>;
> -			resets =3D <&cru SRST_CORE3>;
> -			operating-points-v2 =3D <&cpu0_opp_table>;
> -			#cooling-cells =3D <2>; /* min followed by max =
*/
> -			enable-method =3D "psci";
> -		};
> -	};
> -
> -	cpu0_opp_table: opp-table-0 {
> -		compatible =3D "operating-points-v2";
> -		opp-shared;
> -
> -		opp-408000000 {
> -			opp-hz =3D /bits/ 64 <408000000>;
> -			opp-microvolt =3D <950000>;
> -			clock-latency-ns =3D <40000>;
> -			opp-suspend;
> -		};
> -		opp-600000000 {
> -			opp-hz =3D /bits/ 64 <600000000>;
> -			opp-microvolt =3D <975000>;
> -		};
> -		opp-816000000 {
> -			opp-hz =3D /bits/ 64 <816000000>;
> -			opp-microvolt =3D <1000000>;
> -		};
> -		opp-1008000000 {
> -			opp-hz =3D /bits/ 64 <1008000000>;
> -			opp-microvolt =3D <1175000>;
> -		};
> -		opp-1200000000 {
> -			opp-hz =3D /bits/ 64 <1200000000>;
> -			opp-microvolt =3D <1275000>;
> -		};
> -	};
> -
> -	arm-pmu {
> -		compatible =3D "arm,cortex-a7-pmu";
> -		interrupts =3D <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
> -		interrupt-affinity =3D <&cpu0>, <&cpu1>, <&cpu2>, =
<&cpu3>;
> -	};
> -
> -	psci {
> -		compatible =3D "arm,psci-1.0", "arm,psci-0.2";
> -		method =3D "smc";
> -	};
> -
> -	timer {
> -		compatible =3D "arm,armv7-timer";
> -		arm,cpu-registers-not-fw-configured;
> -		interrupts =3D <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | =
IRQ_TYPE_LEVEL_HIGH)>,
> -			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | =
IRQ_TYPE_LEVEL_HIGH)>,
> -			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | =
IRQ_TYPE_LEVEL_HIGH)>,
> -			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | =
IRQ_TYPE_LEVEL_HIGH)>;
> -		clock-frequency =3D <24000000>;
> -	};
> -
> -	xin24m: oscillator {
> -		compatible =3D "fixed-clock";
> -		clock-frequency =3D <24000000>;
> -		clock-output-names =3D "xin24m";
> -		#clock-cells =3D <0>;
> -	};
> -
> -	display_subsystem: display-subsystem {
> -		compatible =3D "rockchip,display-subsystem";
> -		ports =3D <&vop_out>;
> -	};
> -
> -	i2s1: i2s1@100b0000 {
> -		compatible =3D "rockchip,rk3228-i2s", =
"rockchip,rk3066-i2s";
> -		reg =3D <0x100b0000 0x4000>;
> -		interrupts =3D <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
> -		clock-names =3D "i2s_clk", "i2s_hclk";
> -		clocks =3D <&cru SCLK_I2S1>, <&cru HCLK_I2S1_8CH>;
> -		dmas =3D <&pdma 14>, <&pdma 15>;
> -		dma-names =3D "tx", "rx";
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&i2s1_bus>;
> -		status =3D "disabled";
> -	};
> -
> -	i2s0: i2s0@100c0000 {
> -		compatible =3D "rockchip,rk3228-i2s", =
"rockchip,rk3066-i2s";
> -		reg =3D <0x100c0000 0x4000>;
> -		interrupts =3D <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> -		clock-names =3D "i2s_clk", "i2s_hclk";
> -		clocks =3D <&cru SCLK_I2S0>, <&cru HCLK_I2S0_8CH>;
> -		dmas =3D <&pdma 11>, <&pdma 12>;
> -		dma-names =3D "tx", "rx";
> -		status =3D "disabled";
> -	};
> -
> -	spdif: spdif@100d0000 {
> -		compatible =3D "rockchip,rk3228-spdif";
> -		reg =3D <0x100d0000 0x1000>;
> -		interrupts =3D <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks =3D <&cru SCLK_SPDIF>, <&cru HCLK_SPDIF_8CH>;
> -		clock-names =3D "mclk", "hclk";
> -		dmas =3D <&pdma 10>;
> -		dma-names =3D "tx";
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&spdif_tx>;
> -		status =3D "disabled";
> -	};
> -
> -	i2s2: i2s2@100e0000 {
> -		compatible =3D "rockchip,rk3228-i2s", =
"rockchip,rk3066-i2s";
> -		reg =3D <0x100e0000 0x4000>;
> -		interrupts =3D <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
> -		clock-names =3D "i2s_clk", "i2s_hclk";
> -		clocks =3D <&cru SCLK_I2S2>, <&cru HCLK_I2S2_2CH>;
> -		dmas =3D <&pdma 0>, <&pdma 1>;
> -		dma-names =3D "tx", "rx";
> -		status =3D "disabled";
> -	};
> -
> -	grf: syscon@11000000 {
> -		compatible =3D "rockchip,rk3228-grf", "syscon", =
"simple-mfd";
> -		reg =3D <0x11000000 0x1000>;
> -		#address-cells =3D <1>;
> -		#size-cells =3D <1>;
> -
> -		io_domains: io-domains {
> -			compatible =3D =
"rockchip,rk3228-io-voltage-domain";
> -			status =3D "disabled";
> -		};
> -
> -		power: power-controller {
> -			compatible =3D =
"rockchip,rk3228-power-controller";
> -			#power-domain-cells =3D <1>;
> -			#address-cells =3D <1>;
> -			#size-cells =3D <0>;
> -
> -			power-domain@RK3228_PD_VIO {
> -				reg =3D <RK3228_PD_VIO>;
> -				clocks =3D <&cru ACLK_HDCP>,
> -					 <&cru SCLK_HDCP>,
> -					 <&cru ACLK_IEP>,
> -					 <&cru HCLK_IEP>,
> -					 <&cru ACLK_RGA>,
> -					 <&cru HCLK_RGA>,
> -					 <&cru SCLK_RGA>;
> -				pm_qos =3D <&qos_hdcp>,
> -					 <&qos_iep>,
> -					 <&qos_rga_r>,
> -					 <&qos_rga_w>;
> -				#power-domain-cells =3D <0>;
> -			};
> -
> -			power-domain@RK3228_PD_VOP {
> -				reg =3D <RK3228_PD_VOP>;
> -				clocks =3D<&cru ACLK_VOP>,
> -					<&cru DCLK_VOP>,
> -					<&cru HCLK_VOP>;
> -				pm_qos =3D <&qos_vop>;
> -				#power-domain-cells =3D <0>;
> -			};
> -
> -			power-domain@RK3228_PD_VPU {
> -				reg =3D <RK3228_PD_VPU>;
> -				clocks =3D <&cru ACLK_VPU>,
> -					 <&cru HCLK_VPU>;
> -				pm_qos =3D <&qos_vpu>;
> -				#power-domain-cells =3D <0>;
> -			};
> -
> -			power-domain@RK3228_PD_RKVDEC {
> -				reg =3D <RK3228_PD_RKVDEC>;
> -				clocks =3D <&cru ACLK_RKVDEC>,
> -					 <&cru HCLK_RKVDEC>,
> -					 <&cru SCLK_VDEC_CABAC>,
> -					 <&cru SCLK_VDEC_CORE>;
> -				pm_qos =3D <&qos_rkvdec_r>,
> -					 <&qos_rkvdec_w>;
> -				#power-domain-cells =3D <0>;
> -			};
> -
> -			power-domain@RK3228_PD_GPU {
> -				reg =3D <RK3228_PD_GPU>;
> -				clocks =3D <&cru ACLK_GPU>;
> -				pm_qos =3D <&qos_gpu>;
> -				#power-domain-cells =3D <0>;
> -			};
> -		};
> -
> -		u2phy0: usb2phy@760 {
> -			compatible =3D "rockchip,rk3228-usb2phy";
> -			reg =3D <0x0760 0x0c>;
> -			clocks =3D <&cru SCLK_OTGPHY0>;
> -			clock-names =3D "phyclk";
> -			clock-output-names =3D "usb480m_phy0";
> -			#clock-cells =3D <0>;
> -			status =3D "disabled";
> -
> -			u2phy0_otg: otg-port {
> -				interrupts =3D <GIC_SPI 59 =
IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 60 =
IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 61 =
IRQ_TYPE_LEVEL_HIGH>;
> -				interrupt-names =3D "otg-bvalid", =
"otg-id",
> -						  "linestate";
> -				#phy-cells =3D <0>;
> -				status =3D "disabled";
> -			};
> -
> -			u2phy0_host: host-port {
> -				interrupts =3D <GIC_SPI 62 =
IRQ_TYPE_LEVEL_HIGH>;
> -				interrupt-names =3D "linestate";
> -				#phy-cells =3D <0>;
> -				status =3D "disabled";
> -			};
> -		};
> -
> -		u2phy1: usb2phy@800 {
> -			compatible =3D "rockchip,rk3228-usb2phy";
> -			reg =3D <0x0800 0x0c>;
> -			clocks =3D <&cru SCLK_OTGPHY1>;
> -			clock-names =3D "phyclk";
> -			clock-output-names =3D "usb480m_phy1";
> -			#clock-cells =3D <0>;
> -			status =3D "disabled";
> -
> -			u2phy1_otg: otg-port {
> -				interrupts =3D <GIC_SPI 68 =
IRQ_TYPE_LEVEL_HIGH>;
> -				interrupt-names =3D "linestate";
> -				#phy-cells =3D <0>;
> -				status =3D "disabled";
> -			};
> -
> -			u2phy1_host: host-port {
> -				interrupts =3D <GIC_SPI 69 =
IRQ_TYPE_LEVEL_HIGH>;
> -				interrupt-names =3D "linestate";
> -				#phy-cells =3D <0>;
> -				status =3D "disabled";
> -			};
> -		};
> -	};
> -
> -	uart0: serial@11010000 {
> -		compatible =3D "snps,dw-apb-uart";
> -		reg =3D <0x11010000 0x100>;
> -		interrupts =3D <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
> -		clock-frequency =3D <24000000>;
> -		clocks =3D <&cru SCLK_UART0>, <&cru PCLK_UART0>;
> -		clock-names =3D "baudclk", "apb_pclk";
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&uart0_xfer &uart0_cts &uart0_rts>;
> -		reg-shift =3D <2>;
> -		reg-io-width =3D <4>;
> -		status =3D "disabled";
> -	};
> -
> -	uart1: serial@11020000 {
> -		compatible =3D "snps,dw-apb-uart";
> -		reg =3D <0x11020000 0x100>;
> -		interrupts =3D <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> -		clock-frequency =3D <24000000>;
> -		clocks =3D <&cru SCLK_UART1>, <&cru PCLK_UART1>;
> -		clock-names =3D "baudclk", "apb_pclk";
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&uart1_xfer>;
> -		reg-shift =3D <2>;
> -		reg-io-width =3D <4>;
> -		status =3D "disabled";
> -	};
> -
> -	uart2: serial@11030000 {
> -		compatible =3D "snps,dw-apb-uart";
> -		reg =3D <0x11030000 0x100>;
> -		interrupts =3D <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
> -		clock-frequency =3D <24000000>;
> -		clocks =3D <&cru SCLK_UART2>, <&cru PCLK_UART2>;
> -		clock-names =3D "baudclk", "apb_pclk";
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&uart2_xfer>;
> -		reg-shift =3D <2>;
> -		reg-io-width =3D <4>;
> -		status =3D "disabled";
> -	};
> -
> -	efuse: efuse@11040000 {
> -		compatible =3D "rockchip,rk3228-efuse";
> -		reg =3D <0x11040000 0x20>;
> -		clocks =3D <&cru PCLK_EFUSE_256>;
> -		clock-names =3D "pclk_efuse";
> -		#address-cells =3D <1>;
> -		#size-cells =3D <1>;
> -
> -		/* Data cells */
> -		efuse_id: id@7 {
> -			reg =3D <0x7 0x10>;
> -		};
> -		cpu_leakage: cpu_leakage@17 {
> -			reg =3D <0x17 0x1>;
> -		};
> -	};
> -
> -	i2c0: i2c@11050000 {
> -		compatible =3D "rockchip,rk3228-i2c";
> -		reg =3D <0x11050000 0x1000>;
> -		interrupts =3D <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
> -		clock-names =3D "i2c";
> -		clocks =3D <&cru PCLK_I2C0>;
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&i2c0_xfer>;
> -		status =3D "disabled";
> -	};
> -
> -	i2c1: i2c@11060000 {
> -		compatible =3D "rockchip,rk3228-i2c";
> -		reg =3D <0x11060000 0x1000>;
> -		interrupts =3D <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
> -		clock-names =3D "i2c";
> -		clocks =3D <&cru PCLK_I2C1>;
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&i2c1_xfer>;
> -		status =3D "disabled";
> -	};
> -
> -	i2c2: i2c@11070000 {
> -		compatible =3D "rockchip,rk3228-i2c";
> -		reg =3D <0x11070000 0x1000>;
> -		interrupts =3D <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
> -		clock-names =3D "i2c";
> -		clocks =3D <&cru PCLK_I2C2>;
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&i2c2_xfer>;
> -		status =3D "disabled";
> -	};
> -
> -	i2c3: i2c@11080000 {
> -		compatible =3D "rockchip,rk3228-i2c";
> -		reg =3D <0x11080000 0x1000>;
> -		interrupts =3D <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
> -		clock-names =3D "i2c";
> -		clocks =3D <&cru PCLK_I2C3>;
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&i2c3_xfer>;
> -		status =3D "disabled";
> -	};
> -
> -	spi0: spi@11090000 {
> -		compatible =3D "rockchip,rk3228-spi";
> -		reg =3D <0x11090000 0x1000>;
> -		interrupts =3D <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
> -		clocks =3D <&cru SCLK_SPI0>, <&cru PCLK_SPI0>;
> -		clock-names =3D "spiclk", "apb_pclk";
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&spi0_clk &spi0_tx &spi0_rx &spi0_cs0 =
&spi0_cs1>;
> -		status =3D "disabled";
> -	};
> -
> -	wdt: watchdog@110a0000 {
> -		compatible =3D "rockchip,rk3228-wdt", "snps,dw-wdt";
> -		reg =3D <0x110a0000 0x100>;
> -		interrupts =3D <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks =3D <&cru PCLK_CPU>;
> -		status =3D "disabled";
> -	};
> -
> -	pwm0: pwm@110b0000 {
> -		compatible =3D "rockchip,rk3288-pwm";
> -		reg =3D <0x110b0000 0x10>;
> -		#pwm-cells =3D <3>;
> -		clocks =3D <&cru PCLK_PWM>;
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&pwm0_pin>;
> -		status =3D "disabled";
> -	};
> -
> -	pwm1: pwm@110b0010 {
> -		compatible =3D "rockchip,rk3288-pwm";
> -		reg =3D <0x110b0010 0x10>;
> -		#pwm-cells =3D <3>;
> -		clocks =3D <&cru PCLK_PWM>;
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&pwm1_pin>;
> -		status =3D "disabled";
> -	};
> -
> -	pwm2: pwm@110b0020 {
> -		compatible =3D "rockchip,rk3288-pwm";
> -		reg =3D <0x110b0020 0x10>;
> -		#pwm-cells =3D <3>;
> -		clocks =3D <&cru PCLK_PWM>;
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&pwm2_pin>;
> -		status =3D "disabled";
> -	};
> -
> -	pwm3: pwm@110b0030 {
> -		compatible =3D "rockchip,rk3288-pwm";
> -		reg =3D <0x110b0030 0x10>;
> -		#pwm-cells =3D <2>;
> -		clocks =3D <&cru PCLK_PWM>;
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&pwm3_pin>;
> -		status =3D "disabled";
> -	};
> -
> -	timer: timer@110c0000 {
> -		compatible =3D "rockchip,rk3228-timer", =
"rockchip,rk3288-timer";
> -		reg =3D <0x110c0000 0x20>;
> -		interrupts =3D <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks =3D <&cru PCLK_TIMER>, <&xin24m>;
> -		clock-names =3D "pclk", "timer";
> -	};
> -
> -	cru: clock-controller@110e0000 {
> -		compatible =3D "rockchip,rk3228-cru";
> -		reg =3D <0x110e0000 0x1000>;
> -		rockchip,grf =3D <&grf>;
> -		#clock-cells =3D <1>;
> -		#reset-cells =3D <1>;
> -		assigned-clocks =3D
> -			<&cru PLL_GPLL>, <&cru ARMCLK>,
> -			<&cru PLL_CPLL>, <&cru ACLK_PERI>,
> -			<&cru HCLK_PERI>, <&cru PCLK_PERI>,
> -			<&cru ACLK_CPU>, <&cru HCLK_CPU>,
> -			<&cru PCLK_CPU>;
> -		assigned-clock-rates =3D
> -			<594000000>, <816000000>,
> -			<500000000>, <150000000>,
> -			<150000000>, <75000000>,
> -			<150000000>, <150000000>,
> -			<75000000>;
> -	};
> -
> -	pdma: pdma@110f0000 {
> -		compatible =3D "arm,pl330", "arm,primecell";
> -		reg =3D <0x110f0000 0x4000>;
> -		interrupts =3D <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
> -		#dma-cells =3D <1>;
> -		arm,pl330-periph-burst;
> -		clocks =3D <&cru ACLK_DMAC>;
> -		clock-names =3D "apb_pclk";
> -	};
> -
> -	thermal-zones {
> -		cpu_thermal: cpu-thermal {
> -			polling-delay-passive =3D <100>; /* milliseconds =
*/
> -			polling-delay =3D <5000>; /* milliseconds */
> -
> -			thermal-sensors =3D <&tsadc 0>;
> -
> -			trips {
> -				cpu_alert0: cpu_alert0 {
> -					temperature =3D <70000>; /* =
millicelsius */
> -					hysteresis =3D <2000>; /* =
millicelsius */
> -					type =3D "passive";
> -				};
> -				cpu_alert1: cpu_alert1 {
> -					temperature =3D <75000>; /* =
millicelsius */
> -					hysteresis =3D <2000>; /* =
millicelsius */
> -					type =3D "passive";
> -				};
> -				cpu_crit: cpu_crit {
> -					temperature =3D <90000>; /* =
millicelsius */
> -					hysteresis =3D <2000>; /* =
millicelsius */
> -					type =3D "critical";
> -				};
> -			};
> -
> -			cooling-maps {
> -				map0 {
> -					trip =3D <&cpu_alert0>;
> -					cooling-device =3D
> -						<&cpu0 THERMAL_NO_LIMIT =
6>,
> -						<&cpu1 THERMAL_NO_LIMIT =
6>,
> -						<&cpu2 THERMAL_NO_LIMIT =
6>,
> -						<&cpu3 THERMAL_NO_LIMIT =
6>;
> -				};
> -				map1 {
> -					trip =3D <&cpu_alert1>;
> -					cooling-device =3D
> -						<&cpu0 THERMAL_NO_LIMIT =
THERMAL_NO_LIMIT>,
> -						<&cpu1 THERMAL_NO_LIMIT =
THERMAL_NO_LIMIT>,
> -						<&cpu2 THERMAL_NO_LIMIT =
THERMAL_NO_LIMIT>,
> -						<&cpu3 THERMAL_NO_LIMIT =
THERMAL_NO_LIMIT>;
> -				};
> -			};
> -		};
> -	};
> -
> -	tsadc: tsadc@11150000 {
> -		compatible =3D "rockchip,rk3228-tsadc";
> -		reg =3D <0x11150000 0x100>;
> -		interrupts =3D <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks =3D <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
> -		clock-names =3D "tsadc", "apb_pclk";
> -		assigned-clocks =3D <&cru SCLK_TSADC>;
> -		assigned-clock-rates =3D <32768>;
> -		resets =3D <&cru SRST_TSADC>;
> -		reset-names =3D "tsadc-apb";
> -		pinctrl-names =3D "init", "default", "sleep";
> -		pinctrl-0 =3D <&otp_pin>;
> -		pinctrl-1 =3D <&otp_out>;
> -		pinctrl-2 =3D <&otp_pin>;
> -		#thermal-sensor-cells =3D <1>;
> -		rockchip,hw-tshut-temp =3D <95000>;
> -		status =3D "disabled";
> -	};
> -
> -	hdmi_phy: hdmi-phy@12030000 {
> -		compatible =3D "rockchip,rk3228-hdmi-phy";
> -		reg =3D <0x12030000 0x10000>;
> -		clocks =3D <&cru PCLK_HDMI_PHY>, <&xin24m>, <&cru =
DCLK_HDMI_PHY>;
> -		clock-names =3D "sysclk", "refoclk", "refpclk";
> -		#clock-cells =3D <0>;
> -		clock-output-names =3D "hdmiphy_phy";
> -		#phy-cells =3D <0>;
> -		status =3D "disabled";
> -	};
> -
> -	gpu: gpu@20000000 {
> -		compatible =3D "rockchip,rk3228-mali", "arm,mali-400";
> -		reg =3D <0x20000000 0x10000>;
> -		interrupts =3D <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
> -		interrupt-names =3D "gp",
> -				  "gpmmu",
> -				  "pp0",
> -				  "ppmmu0",
> -				  "pp1",
> -				  "ppmmu1";
> -		clocks =3D <&cru ACLK_GPU>, <&cru ACLK_GPU>;
> -		clock-names =3D "bus", "core";
> -		power-domains =3D <&power RK3228_PD_GPU>;
> -		resets =3D <&cru SRST_GPU_A>;
> -		status =3D "disabled";
> -	};
> -
> -	vpu: video-codec@20020000 {
> -		compatible =3D "rockchip,rk3228-vpu", =
"rockchip,rk3399-vpu";
> -		reg =3D <0x20020000 0x800>;
> -		interrupts =3D <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI  9 IRQ_TYPE_LEVEL_HIGH>;
> -		interrupt-names =3D "vepu", "vdpu";
> -		clocks =3D <&cru ACLK_VPU>, <&cru HCLK_VPU>;
> -		clock-names =3D "aclk", "hclk";
> -		iommus =3D <&vpu_mmu>;
> -		power-domains =3D <&power RK3228_PD_VPU>;
> -	};
> -
> -	vpu_mmu: iommu@20020800 {
> -		compatible =3D "rockchip,iommu";
> -		reg =3D <0x20020800 0x100>;
> -		interrupts =3D <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks =3D <&cru ACLK_VPU>, <&cru HCLK_VPU>;
> -		clock-names =3D "aclk", "iface";
> -		power-domains =3D <&power RK3228_PD_VPU>;
> -		#iommu-cells =3D <0>;
> -	};
> -
> -	vdec: video-codec@20030000 {
> -		compatible =3D "rockchip,rk3228-vdec", =
"rockchip,rk3399-vdec";
> -		reg =3D <0x20030000 0x480>;
> -		interrupts =3D <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks =3D <&cru ACLK_RKVDEC>, <&cru HCLK_RKVDEC>,
> -			 <&cru SCLK_VDEC_CABAC>, <&cru SCLK_VDEC_CORE>;
> -		clock-names =3D "axi", "ahb", "cabac", "core";
> -		assigned-clocks =3D <&cru SCLK_VDEC_CABAC>, <&cru =
SCLK_VDEC_CORE>;
> -		assigned-clock-rates =3D <300000000>, <300000000>;
> -		iommus =3D <&vdec_mmu>;
> -		power-domains =3D <&power RK3228_PD_RKVDEC>;
> -	};
> -
> -	vdec_mmu: iommu@20030480 {
> -		compatible =3D "rockchip,iommu";
> -		reg =3D <0x20030480 0x40>, <0x200304c0 0x40>;
> -		interrupts =3D <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks =3D <&cru ACLK_RKVDEC>, <&cru HCLK_RKVDEC>;
> -		clock-names =3D "aclk", "iface";
> -		power-domains =3D <&power RK3228_PD_RKVDEC>;
> -		#iommu-cells =3D <0>;
> -	};
> -
> -	vop: vop@20050000 {
> -		compatible =3D "rockchip,rk3228-vop";
> -		reg =3D <0x20050000 0x1ffc>;
> -		interrupts =3D <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks =3D <&cru ACLK_VOP>, <&cru DCLK_VOP>, <&cru =
HCLK_VOP>;
> -		clock-names =3D "aclk_vop", "dclk_vop", "hclk_vop";
> -		resets =3D <&cru SRST_VOP_A>, <&cru SRST_VOP_H>, <&cru =
SRST_VOP_D>;
> -		reset-names =3D "axi", "ahb", "dclk";
> -		iommus =3D <&vop_mmu>;
> -		power-domains =3D <&power RK3228_PD_VOP>;
> -		status =3D "disabled";
> -
> -		vop_out: port {
> -			#address-cells =3D <1>;
> -			#size-cells =3D <0>;
> -
> -			vop_out_hdmi: endpoint@0 {
> -				reg =3D <0>;
> -				remote-endpoint =3D <&hdmi_in_vop>;
> -			};
> -		};
> -	};
> -
> -	vop_mmu: iommu@20053f00 {
> -		compatible =3D "rockchip,iommu";
> -		reg =3D <0x20053f00 0x100>;
> -		interrupts =3D <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks =3D <&cru ACLK_VOP>, <&cru HCLK_VOP>;
> -		clock-names =3D "aclk", "iface";
> -		power-domains =3D <&power RK3228_PD_VOP>;
> -		#iommu-cells =3D <0>;
> -		status =3D "disabled";
> -	};
> -
> -	rga: rga@20060000 {
> -		compatible =3D "rockchip,rk3228-rga", =
"rockchip,rk3288-rga";
> -		reg =3D <0x20060000 0x1000>;
> -		interrupts =3D <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks =3D <&cru ACLK_RGA>, <&cru HCLK_RGA>, <&cru =
SCLK_RGA>;
> -		clock-names =3D "aclk", "hclk", "sclk";
> -		power-domains =3D <&power RK3228_PD_VIO>;
> -		resets =3D <&cru SRST_RGA>, <&cru SRST_RGA_A>, <&cru =
SRST_RGA_H>;
> -		reset-names =3D "core", "axi", "ahb";
> -	};
> -
> -	iep_mmu: iommu@20070800 {
> -		compatible =3D "rockchip,iommu";
> -		reg =3D <0x20070800 0x100>;
> -		interrupts =3D <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks =3D <&cru ACLK_IEP>, <&cru HCLK_IEP>;
> -		clock-names =3D "aclk", "iface";
> -		power-domains =3D <&power RK3228_PD_VIO>;
> -		#iommu-cells =3D <0>;
> -		status =3D "disabled";
> -	};
> -
> -	hdmi: hdmi@200a0000 {
> -		compatible =3D "rockchip,rk3228-dw-hdmi";
> -		reg =3D <0x200a0000 0x20000>;
> -		reg-io-width =3D <4>;
> -		interrupts =3D <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> -		assigned-clocks =3D <&cru SCLK_HDMI_PHY>;
> -		assigned-clock-parents =3D <&hdmi_phy>;
> -		clocks =3D <&cru SCLK_HDMI_HDCP>, <&cru PCLK_HDMI_CTRL>, =
<&cru SCLK_HDMI_CEC>;
> -		clock-names =3D "isfr", "iahb", "cec";
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&hdmii2c_xfer &hdmi_hpd &hdmi_cec>;
> -		resets =3D <&cru SRST_HDMI_P>;
> -		reset-names =3D "hdmi";
> -		phys =3D <&hdmi_phy>;
> -		phy-names =3D "hdmi";
> -		rockchip,grf =3D <&grf>;
> -		status =3D "disabled";
> -
> -		ports {
> -			hdmi_in: port {
> -				#address-cells =3D <1>;
> -				#size-cells =3D <0>;
> -				hdmi_in_vop: endpoint@0 {
> -					reg =3D <0>;
> -					remote-endpoint =3D =
<&vop_out_hdmi>;
> -				};
> -			};
> -		};
> -	};
> -
> -	sdmmc: mmc@30000000 {
> -		compatible =3D "rockchip,rk3228-dw-mshc", =
"rockchip,rk3288-dw-mshc";
> -		reg =3D <0x30000000 0x4000>;
> -		interrupts =3D <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks =3D <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
> -			 <&cru SCLK_SDMMC_DRV>, <&cru =
SCLK_SDMMC_SAMPLE>;
> -		clock-names =3D "biu", "ciu", "ciu-drive", "ciu-sample";
> -		fifo-depth =3D <0x100>;
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&sdmmc_clk &sdmmc_cmd &sdmmc_bus4>;
> -		status =3D "disabled";
> -	};
> -
> -	sdio: mmc@30010000 {
> -		compatible =3D "rockchip,rk3228-dw-mshc", =
"rockchip,rk3288-dw-mshc";
> -		reg =3D <0x30010000 0x4000>;
> -		interrupts =3D <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks =3D <&cru HCLK_SDIO>, <&cru SCLK_SDIO>,
> -			 <&cru SCLK_SDIO_DRV>, <&cru SCLK_SDIO_SAMPLE>;
> -		clock-names =3D "biu", "ciu", "ciu-drive", "ciu-sample";
> -		fifo-depth =3D <0x100>;
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&sdio_clk &sdio_cmd &sdio_bus4>;
> -		status =3D "disabled";
> -	};
> -
> -	emmc: mmc@30020000 {
> -		compatible =3D "rockchip,rk3228-dw-mshc", =
"rockchip,rk3288-dw-mshc";
> -		reg =3D <0x30020000 0x4000>;
> -		interrupts =3D <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> -		clock-frequency =3D <37500000>;
> -		max-frequency =3D <37500000>;
> -		clocks =3D <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
> -			 <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
> -		clock-names =3D "biu", "ciu", "ciu-drive", "ciu-sample";
> -		bus-width =3D <8>;
> -		rockchip,default-sample-phase =3D <158>;
> -		fifo-depth =3D <0x100>;
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&emmc_clk &emmc_cmd &emmc_bus8>;
> -		resets =3D <&cru SRST_EMMC>;
> -		reset-names =3D "reset";
> -		status =3D "disabled";
> -	};
> -
> -	usb_otg: usb@30040000 {
> -		compatible =3D "rockchip,rk3228-usb", =
"rockchip,rk3066-usb",
> -			     "snps,dwc2";
> -		reg =3D <0x30040000 0x40000>;
> -		interrupts =3D <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks =3D <&cru HCLK_OTG>;
> -		clock-names =3D "otg";
> -		dr_mode =3D "otg";
> -		g-np-tx-fifo-size =3D <16>;
> -		g-rx-fifo-size =3D <280>;
> -		g-tx-fifo-size =3D <256 128 128 64 32 16>;
> -		phys =3D <&u2phy0_otg>;
> -		phy-names =3D "usb2-phy";
> -		status =3D "disabled";
> -	};
> -
> -	usb_host0_ehci: usb@30080000 {
> -		compatible =3D "generic-ehci";
> -		reg =3D <0x30080000 0x20000>;
> -		interrupts =3D <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks =3D <&cru HCLK_HOST0>, <&u2phy0>;
> -		phys =3D <&u2phy0_host>;
> -		phy-names =3D "usb";
> -		status =3D "disabled";
> -	};
> -
> -	usb_host0_ohci: usb@300a0000 {
> -		compatible =3D "generic-ohci";
> -		reg =3D <0x300a0000 0x20000>;
> -		interrupts =3D <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks =3D <&cru HCLK_HOST0>, <&u2phy0>;
> -		phys =3D <&u2phy0_host>;
> -		phy-names =3D "usb";
> -		status =3D "disabled";
> -	};
> -
> -	usb_host1_ehci: usb@300c0000 {
> -		compatible =3D "generic-ehci";
> -		reg =3D <0x300c0000 0x20000>;
> -		interrupts =3D <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks =3D <&cru HCLK_HOST1>, <&u2phy1>;
> -		phys =3D <&u2phy1_otg>;
> -		phy-names =3D "usb";
> -		status =3D "disabled";
> -	};
> -
> -	usb_host1_ohci: usb@300e0000 {
> -		compatible =3D "generic-ohci";
> -		reg =3D <0x300e0000 0x20000>;
> -		interrupts =3D <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks =3D <&cru HCLK_HOST1>, <&u2phy1>;
> -		phys =3D <&u2phy1_otg>;
> -		phy-names =3D "usb";
> -		status =3D "disabled";
> -	};
> -
> -	usb_host2_ehci: usb@30100000 {
> -		compatible =3D "generic-ehci";
> -		reg =3D <0x30100000 0x20000>;
> -		interrupts =3D <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks =3D <&cru HCLK_HOST2>, <&u2phy1>;
> -		phys =3D <&u2phy1_host>;
> -		phy-names =3D "usb";
> -		status =3D "disabled";
> -	};
> -
> -	usb_host2_ohci: usb@30120000 {
> -		compatible =3D "generic-ohci";
> -		reg =3D <0x30120000 0x20000>;
> -		interrupts =3D <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks =3D <&cru HCLK_HOST2>, <&u2phy1>;
> -		phys =3D <&u2phy1_host>;
> -		phy-names =3D "usb";
> -		status =3D "disabled";
> -	};
> -
> -	gmac: ethernet@30200000 {
> -		compatible =3D "rockchip,rk3228-gmac";
> -		reg =3D <0x30200000 0x10000>;
> -		interrupts =3D <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
> -		interrupt-names =3D "macirq";
> -		clocks =3D <&cru SCLK_MAC>, <&cru SCLK_MAC_RX>,
> -			<&cru SCLK_MAC_TX>, <&cru SCLK_MAC_REF>,
> -			<&cru SCLK_MAC_REFOUT>, <&cru ACLK_GMAC>,
> -			<&cru PCLK_GMAC>;
> -		clock-names =3D "stmmaceth", "mac_clk_rx",
> -			"mac_clk_tx", "clk_mac_ref",
> -			"clk_mac_refout", "aclk_mac",
> -			"pclk_mac";
> -		resets =3D <&cru SRST_GMAC>;
> -		reset-names =3D "stmmaceth";
> -		rockchip,grf =3D <&grf>;
> -		status =3D "disabled";
> -	};
> -
> -	qos_iep: qos@31030080 {
> -		compatible =3D "rockchip,rk3228-qos", "syscon";
> -		reg =3D <0x31030080 0x20>;
> -	};
> -
> -	qos_rga_w: qos@31030100 {
> -		compatible =3D "rockchip,rk3228-qos", "syscon";
> -		reg =3D <0x31030100 0x20>;
> -	};
> -
> -	qos_hdcp: qos@31030180 {
> -		compatible =3D "rockchip,rk3228-qos", "syscon";
> -		reg =3D <0x31030180 0x20>;
> -	};
> -
> -	qos_rga_r: qos@31030200 {
> -		compatible =3D "rockchip,rk3228-qos", "syscon";
> -		reg =3D <0x31030200 0x20>;
> -	};
> -
> -	qos_vpu: qos@31040000 {
> -		compatible =3D "rockchip,rk3228-qos", "syscon";
> -		reg =3D <0x31040000 0x20>;
> -	};
> -
> -	qos_gpu: qos@31050000 {
> -		compatible =3D "rockchip,rk3228-qos", "syscon";
> -		reg =3D <0x31050000 0x20>;
> -	};
> -
> -	qos_vop: qos@31060000 {
> -		compatible =3D "rockchip,rk3228-qos", "syscon";
> -		reg =3D <0x31060000 0x20>;
> -	};
> -
> -	qos_rkvdec_r: qos@31070000 {
> -		compatible =3D "rockchip,rk3228-qos", "syscon";
> -		reg =3D <0x31070000 0x20>;
> -	};
> -
> -	qos_rkvdec_w: qos@31070080 {
> -		compatible =3D "rockchip,rk3228-qos", "syscon";
> -		reg =3D <0x31070080 0x20>;
> -	};
> -
> -	gic: interrupt-controller@32010000 {
> -		compatible =3D "arm,gic-400";
> -		interrupt-controller;
> -		#interrupt-cells =3D <3>;
> -		#address-cells =3D <0>;
> -
> -		reg =3D <0x32011000 0x1000>,
> -		      <0x32012000 0x2000>,
> -		      <0x32014000 0x2000>,
> -		      <0x32016000 0x2000>;
> -		interrupts =3D <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | =
IRQ_TYPE_LEVEL_HIGH)>;
> -	};
> -
> -	pinctrl: pinctrl {
> -		compatible =3D "rockchip,rk3228-pinctrl";
> -		rockchip,grf =3D <&grf>;
> -		#address-cells =3D <1>;
> -		#size-cells =3D <1>;
> -		ranges;
> -
> -		gpio0: gpio@11110000 {
> -			compatible =3D "rockchip,gpio-bank";
> -			reg =3D <0x11110000 0x100>;
> -			interrupts =3D <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks =3D <&cru PCLK_GPIO0>;
> -
> -			gpio-controller;
> -			#gpio-cells =3D <2>;
> -
> -			interrupt-controller;
> -			#interrupt-cells =3D <2>;
> -		};
> -
> -		gpio1: gpio@11120000 {
> -			compatible =3D "rockchip,gpio-bank";
> -			reg =3D <0x11120000 0x100>;
> -			interrupts =3D <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks =3D <&cru PCLK_GPIO1>;
> -
> -			gpio-controller;
> -			#gpio-cells =3D <2>;
> -
> -			interrupt-controller;
> -			#interrupt-cells =3D <2>;
> -		};
> -
> -		gpio2: gpio@11130000 {
> -			compatible =3D "rockchip,gpio-bank";
> -			reg =3D <0x11130000 0x100>;
> -			interrupts =3D <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks =3D <&cru PCLK_GPIO2>;
> -
> -			gpio-controller;
> -			#gpio-cells =3D <2>;
> -
> -			interrupt-controller;
> -			#interrupt-cells =3D <2>;
> -		};
> -
> -		gpio3: gpio@11140000 {
> -			compatible =3D "rockchip,gpio-bank";
> -			reg =3D <0x11140000 0x100>;
> -			interrupts =3D <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks =3D <&cru PCLK_GPIO3>;
> -
> -			gpio-controller;
> -			#gpio-cells =3D <2>;
> -
> -			interrupt-controller;
> -			#interrupt-cells =3D <2>;
> -		};
> -
> -		pcfg_pull_up: pcfg-pull-up {
> -			bias-pull-up;
> -		};
> -
> -		pcfg_pull_down: pcfg-pull-down {
> -			bias-pull-down;
> -		};
> -
> -		pcfg_pull_none: pcfg-pull-none {
> -			bias-disable;
> -		};
> -
> -		pcfg_pull_none_drv_12ma: pcfg-pull-none-drv-12ma {
> -			drive-strength =3D <12>;
> -		};
> -
> -		sdmmc {
> -			sdmmc_clk: sdmmc-clk {
> -				rockchip,pins =3D <1 RK_PC0 1 =
&pcfg_pull_none_drv_12ma>;
> -			};
> -
> -			sdmmc_cmd: sdmmc-cmd {
> -				rockchip,pins =3D <1 RK_PB7 1 =
&pcfg_pull_none_drv_12ma>;
> -			};
> -
> -			sdmmc_bus4: sdmmc-bus4 {
> -				rockchip,pins =3D <1 RK_PC2 1 =
&pcfg_pull_none_drv_12ma>,
> -						<1 RK_PC3 1 =
&pcfg_pull_none_drv_12ma>,
> -						<1 RK_PC4 1 =
&pcfg_pull_none_drv_12ma>,
> -						<1 RK_PC5 1 =
&pcfg_pull_none_drv_12ma>;
> -			};
> -		};
> -
> -		sdio {
> -			sdio_clk: sdio-clk {
> -				rockchip,pins =3D <3 RK_PA0 1 =
&pcfg_pull_none_drv_12ma>;
> -			};
> -
> -			sdio_cmd: sdio-cmd {
> -				rockchip,pins =3D <3 RK_PA1 1 =
&pcfg_pull_none_drv_12ma>;
> -			};
> -
> -			sdio_bus4: sdio-bus4 {
> -				rockchip,pins =3D <3 RK_PA2 1 =
&pcfg_pull_none_drv_12ma>,
> -						<3 RK_PA3 1 =
&pcfg_pull_none_drv_12ma>,
> -						<3 RK_PA4 1 =
&pcfg_pull_none_drv_12ma>,
> -						<3 RK_PA5 1 =
&pcfg_pull_none_drv_12ma>;
> -			};
> -		};
> -
> -		emmc {
> -			emmc_clk: emmc-clk {
> -				rockchip,pins =3D <2 RK_PA7 2 =
&pcfg_pull_none>;
> -			};
> -
> -			emmc_cmd: emmc-cmd {
> -				rockchip,pins =3D <1 RK_PC6 2 =
&pcfg_pull_none>;
> -			};
> -
> -			emmc_bus8: emmc-bus8 {
> -				rockchip,pins =3D <1 RK_PD0 2 =
&pcfg_pull_none>,
> -						<1 RK_PD1 2 =
&pcfg_pull_none>,
> -						<1 RK_PD2 2 =
&pcfg_pull_none>,
> -						<1 RK_PD3 2 =
&pcfg_pull_none>,
> -						<1 RK_PD4 2 =
&pcfg_pull_none>,
> -						<1 RK_PD5 2 =
&pcfg_pull_none>,
> -						<1 RK_PD6 2 =
&pcfg_pull_none>,
> -						<1 RK_PD7 2 =
&pcfg_pull_none>;
> -			};
> -		};
> -
> -		gmac {
> -			rgmii_pins: rgmii-pins {
> -				rockchip,pins =3D <2 RK_PB6 1 =
&pcfg_pull_none>,
> -						<2 RK_PB4 1 =
&pcfg_pull_none>,
> -						<2 RK_PD1 1 =
&pcfg_pull_none>,
> -						<2 RK_PC3 1 =
&pcfg_pull_none_drv_12ma>,
> -						<2 RK_PC2 1 =
&pcfg_pull_none_drv_12ma>,
> -						<2 RK_PC6 1 =
&pcfg_pull_none_drv_12ma>,
> -						<2 RK_PC7 1 =
&pcfg_pull_none_drv_12ma>,
> -						<2 RK_PB1 1 =
&pcfg_pull_none_drv_12ma>,
> -						<2 RK_PB5 1 =
&pcfg_pull_none_drv_12ma>,
> -						<2 RK_PC1 1 =
&pcfg_pull_none>,
> -						<2 RK_PC0 1 =
&pcfg_pull_none>,
> -						<2 RK_PC5 2 =
&pcfg_pull_none>,
> -						<2 RK_PC4 2 =
&pcfg_pull_none>,
> -						<2 RK_PB3 1 =
&pcfg_pull_none>,
> -						<2 RK_PB0 1 =
&pcfg_pull_none>;
> -			};
> -
> -			rmii_pins: rmii-pins {
> -				rockchip,pins =3D <2 RK_PB6 1 =
&pcfg_pull_none>,
> -						<2 RK_PB4 1 =
&pcfg_pull_none>,
> -						<2 RK_PD1 1 =
&pcfg_pull_none>,
> -						<2 RK_PC3 1 =
&pcfg_pull_none_drv_12ma>,
> -						<2 RK_PC2 1 =
&pcfg_pull_none_drv_12ma>,
> -						<2 RK_PB5 1 =
&pcfg_pull_none_drv_12ma>,
> -						<2 RK_PC1 1 =
&pcfg_pull_none>,
> -						<2 RK_PC0 1 =
&pcfg_pull_none>,
> -						<2 RK_PB0 1 =
&pcfg_pull_none>,
> -						<2 RK_PB7 1 =
&pcfg_pull_none>;
> -			};
> -
> -			phy_pins: phy-pins {
> -				rockchip,pins =3D <2 RK_PB6 2 =
&pcfg_pull_none>,
> -						<2 RK_PB0 2 =
&pcfg_pull_none>;
> -			};
> -		};
> -
> -		hdmi {
> -			hdmi_hpd: hdmi-hpd {
> -				rockchip,pins =3D <0 RK_PB7 1 =
&pcfg_pull_down>;
> -			};
> -
> -			hdmii2c_xfer: hdmii2c-xfer {
> -				rockchip,pins =3D <0 RK_PA6 2 =
&pcfg_pull_none>,
> -						<0 RK_PA7 2 =
&pcfg_pull_none>;
> -			};
> -
> -			hdmi_cec: hdmi-cec {
> -				rockchip,pins =3D <0 RK_PC4 1 =
&pcfg_pull_none>;
> -			};
> -		};
> -
> -		i2c0 {
> -			i2c0_xfer: i2c0-xfer {
> -				rockchip,pins =3D <0 RK_PA0 1 =
&pcfg_pull_none>,
> -						<0 RK_PA1 1 =
&pcfg_pull_none>;
> -			};
> -		};
> -
> -		i2c1 {
> -			i2c1_xfer: i2c1-xfer {
> -				rockchip,pins =3D <0 RK_PA2 1 =
&pcfg_pull_none>,
> -						<0 RK_PA3 1 =
&pcfg_pull_none>;
> -			};
> -		};
> -
> -		i2c2 {
> -			i2c2_xfer: i2c2-xfer {
> -				rockchip,pins =3D <2 RK_PC4 1 =
&pcfg_pull_none>,
> -						<2 RK_PC5 1 =
&pcfg_pull_none>;
> -			};
> -		};
> -
> -		i2c3 {
> -			i2c3_xfer: i2c3-xfer {
> -				rockchip,pins =3D <0 RK_PA6 1 =
&pcfg_pull_none>,
> -						<0 RK_PA7 1 =
&pcfg_pull_none>;
> -			};
> -		};
> -
> -		spi0 {
> -			spi0_clk: spi0-clk {
> -				rockchip,pins =3D <0 RK_PB1 2 =
&pcfg_pull_up>;
> -			};
> -			spi0_cs0: spi0-cs0 {
> -				rockchip,pins =3D <0 RK_PB6 2 =
&pcfg_pull_up>;
> -			};
> -			spi0_tx: spi0-tx {
> -				rockchip,pins =3D <0 RK_PB3 2 =
&pcfg_pull_up>;
> -			};
> -			spi0_rx: spi0-rx {
> -				rockchip,pins =3D <0 RK_PB5 2 =
&pcfg_pull_up>;
> -			};
> -			spi0_cs1: spi0-cs1 {
> -				rockchip,pins =3D <1 RK_PB4 1 =
&pcfg_pull_up>;
> -			};
> -		};
> -
> -		spi1 {
> -			spi1_clk: spi1-clk {
> -				rockchip,pins =3D <0 RK_PC7 2 =
&pcfg_pull_up>;
> -			};
> -			spi1_cs0: spi1-cs0 {
> -				rockchip,pins =3D <2 RK_PA2 2 =
&pcfg_pull_up>;
> -			};
> -			spi1_rx: spi1-rx {
> -				rockchip,pins =3D <2 RK_PA0 2 =
&pcfg_pull_up>;
> -			};
> -			spi1_tx: spi1-tx {
> -				rockchip,pins =3D <2 RK_PA1 2 =
&pcfg_pull_up>;
> -			};
> -			spi1_cs1: spi1-cs1 {
> -				rockchip,pins =3D <2 RK_PA3 2 =
&pcfg_pull_up>;
> -			};
> -		};
> -
> -		i2s1 {
> -			i2s1_bus: i2s1-bus {
> -				rockchip,pins =3D <0 RK_PB0 1 =
&pcfg_pull_none>,
> -						<0 RK_PB1 1 =
&pcfg_pull_none>,
> -						<0 RK_PB3 1 =
&pcfg_pull_none>,
> -						<0 RK_PB4 1 =
&pcfg_pull_none>,
> -						<0 RK_PB5 1 =
&pcfg_pull_none>,
> -						<0 RK_PB6 1 =
&pcfg_pull_none>,
> -						<1 RK_PA2 2 =
&pcfg_pull_none>,
> -						<1 RK_PA4 2 =
&pcfg_pull_none>,
> -						<1 RK_PA5 2 =
&pcfg_pull_none>;
> -			};
> -		};
> -
> -		pwm0 {
> -			pwm0_pin: pwm0-pin {
> -				rockchip,pins =3D <3 RK_PC5 1 =
&pcfg_pull_none>;
> -			};
> -		};
> -
> -		pwm1 {
> -			pwm1_pin: pwm1-pin {
> -				rockchip,pins =3D <0 RK_PD6 2 =
&pcfg_pull_none>;
> -			};
> -		};
> -
> -		pwm2 {
> -			pwm2_pin: pwm2-pin {
> -				rockchip,pins =3D <1 RK_PB4 2 =
&pcfg_pull_none>;
> -			};
> -		};
> -
> -		pwm3 {
> -			pwm3_pin: pwm3-pin {
> -				rockchip,pins =3D <1 RK_PB3 2 =
&pcfg_pull_none>;
> -			};
> -		};
> -
> -		spdif {
> -			spdif_tx: spdif-tx {
> -				rockchip,pins =3D <3 RK_PD7 2 =
&pcfg_pull_none>;
> -			};
> -		};
> -
> -		tsadc {
> -			otp_pin: otp-pin {
> -				rockchip,pins =3D <0 RK_PD0 RK_FUNC_GPIO =
&pcfg_pull_none>;
> -			};
> -
> -			otp_out: otp-out {
> -				rockchip,pins =3D <0 RK_PD0 2 =
&pcfg_pull_none>;
> -			};
> -		};
> -
> -		uart0 {
> -			uart0_xfer: uart0-xfer {
> -				rockchip,pins =3D <2 RK_PD2 1 =
&pcfg_pull_none>,
> -						<2 RK_PD3 1 =
&pcfg_pull_none>;
> -			};
> -
> -			uart0_cts: uart0-cts {
> -				rockchip,pins =3D <2 RK_PD5 1 =
&pcfg_pull_none>;
> -			};
> -
> -			uart0_rts: uart0-rts {
> -				rockchip,pins =3D <0 RK_PC1 1 =
&pcfg_pull_none>;
> -			};
> -		};
> -
> -		uart1 {
> -			uart1_xfer: uart1-xfer {
> -				rockchip,pins =3D <1 RK_PB1 1 =
&pcfg_pull_none>,
> -						<1 RK_PB2 1 =
&pcfg_pull_none>;
> -			};
> -
> -			uart1_cts: uart1-cts {
> -				rockchip,pins =3D <1 RK_PB0 1 =
&pcfg_pull_none>;
> -			};
> -
> -			uart1_rts: uart1-rts {
> -				rockchip,pins =3D <1 RK_PB3 1 =
&pcfg_pull_none>;
> -			};
> -		};
> -
> -		uart2 {
> -			uart2_xfer: uart2-xfer {
> -				rockchip,pins =3D <1 RK_PC2 2 =
&pcfg_pull_up>,
> -						<1 RK_PC3 2 =
&pcfg_pull_none>;
> -			};
> -
> -			uart21_xfer: uart21-xfer {
> -				rockchip,pins =3D <1 RK_PB2 2 =
&pcfg_pull_up>,
> -						<1 RK_PB1 2 =
&pcfg_pull_none>;
> -			};
> -
> -			uart2_cts: uart2-cts {
> -				rockchip,pins =3D <0 RK_PD1 1 =
&pcfg_pull_none>;
> -			};
> -
> -			uart2_rts: uart2-rts {
> -				rockchip,pins =3D <0 RK_PD0 1 =
&pcfg_pull_none>;
> -			};
> -		};
> -	};
> -};
> diff --git a/arch/arm/mach-rockchip/Kconfig =
b/arch/arm/mach-rockchip/Kconfig
> index 02737c62df03..d92fcae2bb56 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -109,6 +109,7 @@ config ROCKCHIP_RK322X
> 	select TPL_OF_LIBFDT
> 	select TPL_HAVE_INIT_STACK if TPL
> 	select SPL_DRIVERS_MISC
> +	imply OF_UPSTREAM
> 	imply ROCKCHIP_COMMON_BOARD
> 	imply SPL_SERIAL
> 	imply SPL_ROCKCHIP_COMMON_BOARD
> diff --git a/board/rockchip/evb_rk3229/MAINTAINERS =
b/board/rockchip/evb_rk3229/MAINTAINERS
> index 4de97dbb0a49..7758ee9b9306 100644
> --- a/board/rockchip/evb_rk3229/MAINTAINERS
> +++ b/board/rockchip/evb_rk3229/MAINTAINERS
> @@ -1,7 +1,6 @@
> EVB-RK3229
> M:      Kever Yang <kever.yang@rock-chips.com>
> S:      Maintained
> -F:	arch/arm/dts/rk3229-evb.dts
> F:	arch/arm/dts/rk3229-evb-u-boot.dtsi
> F:      board/rockchip/evb_rk3229
> F:      include/configs/evb_rk3229.h
> diff --git a/configs/evb-rk3229_defconfig =
b/configs/evb-rk3229_defconfig
> index 116c04c914d7..46a682faecb0 100644
> --- a/configs/evb-rk3229_defconfig
> +++ b/configs/evb-rk3229_defconfig
> @@ -9,7 +9,7 @@ CONFIG_NR_DRAM_BANKS=3D2
> CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x61100000
> CONFIG_ENV_OFFSET=3D0x3F8000
> -CONFIG_DEFAULT_DEVICE_TREE=3D"rk3229-evb"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"rockchip/rk3229-evb"
> CONFIG_ROCKCHIP_RK322X=3Dy
> CONFIG_TARGET_EVB_RK3229=3Dy
> CONFIG_SPL_STACK_R_ADDR=3D0x60600000
> @@ -24,7 +24,7 @@ CONFIG_FIT=3Dy
> CONFIG_FIT_VERBOSE=3Dy
> CONFIG_SPL_LOAD_FIT=3Dy
> CONFIG_USE_PREBOOT=3Dy
> -CONFIG_DEFAULT_FDT_FILE=3D"rk3229-evb.dtb"
> +CONFIG_DEFAULT_FDT_FILE=3D"rockchip/rk3229-evb.dtb"
> # CONFIG_DISPLAY_CPUINFO is not set
> CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> CONFIG_SPL_MAX_SIZE=3D0x100000
> diff --git a/include/dt-bindings/clock/rk3228-cru.h =
b/include/dt-bindings/clock/rk3228-cru.h
> deleted file mode 100644
> index de550ea56eeb..000000000000
> --- a/include/dt-bindings/clock/rk3228-cru.h
> +++ /dev/null
> @@ -1,287 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * Copyright (c) 2015 Rockchip Electronics Co. Ltd.
> - * Author: Jeffy Chen <jeffy.chen@rock-chips.com>
> - */
> -
> -#ifndef _DT_BINDINGS_CLK_ROCKCHIP_RK3228_H
> -#define _DT_BINDINGS_CLK_ROCKCHIP_RK3228_H
> -
> -/* core clocks */
> -#define PLL_APLL		1
> -#define PLL_DPLL		2
> -#define PLL_CPLL		3
> -#define PLL_GPLL		4
> -#define ARMCLK			5
> -
> -/* sclk gates (special clocks) */
> -#define SCLK_SPI0		65
> -#define SCLK_NANDC		67
> -#define SCLK_SDMMC		68
> -#define SCLK_SDIO		69
> -#define SCLK_EMMC		71
> -#define SCLK_TSADC		72
> -#define SCLK_UART0		77
> -#define SCLK_UART1		78
> -#define SCLK_UART2		79
> -#define SCLK_I2S0		80
> -#define SCLK_I2S1		81
> -#define SCLK_I2S2		82
> -#define SCLK_SPDIF		83
> -#define SCLK_TIMER0		85
> -#define SCLK_TIMER1		86
> -#define SCLK_TIMER2		87
> -#define SCLK_TIMER3		88
> -#define SCLK_TIMER4		89
> -#define SCLK_TIMER5		90
> -#define SCLK_I2S_OUT		113
> -#define SCLK_SDMMC_DRV		114
> -#define SCLK_SDIO_DRV		115
> -#define SCLK_EMMC_DRV		117
> -#define SCLK_SDMMC_SAMPLE	118
> -#define SCLK_SDIO_SAMPLE	119
> -#define SCLK_SDIO_SRC		120
> -#define SCLK_EMMC_SAMPLE	121
> -#define SCLK_VOP		122
> -#define SCLK_HDMI_HDCP		123
> -#define SCLK_MAC_SRC		124
> -#define SCLK_MAC_EXTCLK		125
> -#define SCLK_MAC		126
> -#define SCLK_MAC_REFOUT		127
> -#define SCLK_MAC_REF		128
> -#define SCLK_MAC_RX		129
> -#define SCLK_MAC_TX		130
> -#define SCLK_MAC_PHY		131
> -#define SCLK_MAC_OUT		132
> -#define SCLK_VDEC_CABAC		133
> -#define SCLK_VDEC_CORE		134
> -#define SCLK_RGA		135
> -#define SCLK_HDCP		136
> -#define SCLK_HDMI_CEC		137
> -#define SCLK_CRYPTO		138
> -#define SCLK_TSP		139
> -#define SCLK_HSADC		140
> -#define SCLK_WIFI		141
> -#define SCLK_OTGPHY0		142
> -#define SCLK_OTGPHY1		143
> -#define SCLK_HDMI_PHY		144
> -
> -/* dclk gates */
> -#define DCLK_VOP		190
> -#define DCLK_HDMI_PHY		191
> -
> -/* aclk gates */
> -#define ACLK_DMAC		194
> -#define ACLK_CPU		195
> -#define ACLK_VPU_PRE		196
> -#define ACLK_RKVDEC_PRE		197
> -#define ACLK_RGA_PRE		198
> -#define ACLK_IEP_PRE		199
> -#define ACLK_HDCP_PRE		200
> -#define ACLK_VOP_PRE		201
> -#define ACLK_VPU		202
> -#define ACLK_RKVDEC		203
> -#define ACLK_IEP		204
> -#define ACLK_RGA		205
> -#define ACLK_HDCP		206
> -#define ACLK_PERI		210
> -#define ACLK_VOP		211
> -#define ACLK_GMAC		212
> -#define ACLK_GPU		213
> -
> -/* pclk gates */
> -#define PCLK_GPIO0		320
> -#define PCLK_GPIO1		321
> -#define PCLK_GPIO2		322
> -#define PCLK_GPIO3		323
> -#define PCLK_VIO_H2P		324
> -#define PCLK_HDCP		325
> -#define PCLK_EFUSE_1024		326
> -#define PCLK_EFUSE_256		327
> -#define PCLK_GRF		329
> -#define PCLK_I2C0		332
> -#define PCLK_I2C1		333
> -#define PCLK_I2C2		334
> -#define PCLK_I2C3		335
> -#define PCLK_SPI0		338
> -#define PCLK_UART0		341
> -#define PCLK_UART1		342
> -#define PCLK_UART2		343
> -#define PCLK_TSADC		344
> -#define PCLK_PWM		350
> -#define PCLK_TIMER		353
> -#define PCLK_CPU		354
> -#define PCLK_PERI		363
> -#define PCLK_HDMI_CTRL		364
> -#define PCLK_HDMI_PHY		365
> -#define PCLK_GMAC		367
> -
> -/* hclk gates */
> -#define HCLK_I2S0_8CH		442
> -#define HCLK_I2S1_8CH		443
> -#define HCLK_I2S2_2CH		444
> -#define HCLK_SPDIF_8CH		445
> -#define HCLK_VOP		452
> -#define HCLK_NANDC		453
> -#define HCLK_SDMMC		456
> -#define HCLK_SDIO		457
> -#define HCLK_EMMC		459
> -#define HCLK_CPU		460
> -#define HCLK_VPU_PRE		461
> -#define HCLK_RKVDEC_PRE		462
> -#define HCLK_VIO_PRE		463
> -#define HCLK_VPU		464
> -#define HCLK_RKVDEC		465
> -#define HCLK_VIO		466
> -#define HCLK_RGA		467
> -#define HCLK_IEP		468
> -#define HCLK_VIO_H2P		469
> -#define HCLK_HDCP_MMU		470
> -#define HCLK_HOST0		471
> -#define HCLK_HOST1		472
> -#define HCLK_HOST2		473
> -#define HCLK_OTG		474
> -#define HCLK_TSP		475
> -#define HCLK_M_CRYPTO		476
> -#define HCLK_S_CRYPTO		477
> -#define HCLK_PERI		478
> -
> -#define CLK_NR_CLKS		(HCLK_PERI + 1)
> -
> -/* soft-reset indices */
> -#define SRST_CORE0_PO		0
> -#define SRST_CORE1_PO		1
> -#define SRST_CORE2_PO		2
> -#define SRST_CORE3_PO		3
> -#define SRST_CORE0		4
> -#define SRST_CORE1		5
> -#define SRST_CORE2		6
> -#define SRST_CORE3		7
> -#define SRST_CORE0_DBG		8
> -#define SRST_CORE1_DBG		9
> -#define SRST_CORE2_DBG		10
> -#define SRST_CORE3_DBG		11
> -#define SRST_TOPDBG		12
> -#define SRST_ACLK_CORE		13
> -#define SRST_NOC		14
> -#define SRST_L2C		15
> -
> -#define SRST_CPUSYS_H		18
> -#define SRST_BUSSYS_H		19
> -#define SRST_SPDIF		20
> -#define SRST_INTMEM		21
> -#define SRST_ROM		22
> -#define SRST_OTG_ADP		23
> -#define SRST_I2S0		24
> -#define SRST_I2S1		25
> -#define SRST_I2S2		26
> -#define SRST_ACODEC_P		27
> -#define SRST_DFIMON		28
> -#define SRST_MSCH		29
> -#define SRST_EFUSE1024		30
> -#define SRST_EFUSE256		31
> -
> -#define SRST_GPIO0		32
> -#define SRST_GPIO1		33
> -#define SRST_GPIO2		34
> -#define SRST_GPIO3		35
> -#define SRST_PERIPH_NOC_A	36
> -#define SRST_PERIPH_NOC_BUS_H	37
> -#define SRST_PERIPH_NOC_P	38
> -#define SRST_UART0		39
> -#define SRST_UART1		40
> -#define SRST_UART2		41
> -#define SRST_PHYNOC		42
> -#define SRST_I2C0		43
> -#define SRST_I2C1		44
> -#define SRST_I2C2		45
> -#define SRST_I2C3		46
> -
> -#define SRST_PWM		48
> -#define SRST_A53_GIC		49
> -#define SRST_DAP		51
> -#define SRST_DAP_NOC		52
> -#define SRST_CRYPTO		53
> -#define SRST_SGRF		54
> -#define SRST_GRF		55
> -#define SRST_GMAC		56
> -#define SRST_PERIPH_NOC_H	58
> -#define SRST_MACPHY		63
> -
> -#define SRST_DMA		64
> -#define SRST_NANDC		68
> -#define SRST_USBOTG		69
> -#define SRST_OTGC		70
> -#define SRST_USBHOST0		71
> -#define SRST_HOST_CTRL0		72
> -#define SRST_USBHOST1		73
> -#define SRST_HOST_CTRL1		74
> -#define SRST_USBHOST2		75
> -#define SRST_HOST_CTRL2		76
> -#define SRST_USBPOR0		77
> -#define SRST_USBPOR1		78
> -#define SRST_DDRMSCH		79
> -
> -#define SRST_SMART_CARD		80
> -#define SRST_SDMMC		81
> -#define SRST_SDIO		82
> -#define SRST_EMMC		83
> -#define SRST_SPI		84
> -#define SRST_TSP_H		85
> -#define SRST_TSP		86
> -#define SRST_TSADC		87
> -#define SRST_DDRPHY		88
> -#define SRST_DDRPHY_P		89
> -#define SRST_DDRCTRL		90
> -#define SRST_DDRCTRL_P		91
> -#define SRST_HOST0_ECHI		92
> -#define SRST_HOST1_ECHI		93
> -#define SRST_HOST2_ECHI		94
> -#define SRST_VOP_NOC_A		95
> -
> -#define SRST_HDMI_P		96
> -#define SRST_VIO_ARBI_H		97
> -#define SRST_IEP_NOC_A		98
> -#define SRST_VIO_NOC_H		99
> -#define SRST_VOP_A		100
> -#define SRST_VOP_H		101
> -#define SRST_VOP_D		102
> -#define SRST_UTMI0		103
> -#define SRST_UTMI1		104
> -#define SRST_UTMI2		105
> -#define SRST_UTMI3		106
> -#define SRST_RGA		107
> -#define SRST_RGA_NOC_A		108
> -#define SRST_RGA_A		109
> -#define SRST_RGA_H		110
> -#define SRST_HDCP_A		111
> -
> -#define SRST_VPU_A		112
> -#define SRST_VPU_H		113
> -#define SRST_VPU_NOC_A		116
> -#define SRST_VPU_NOC_H		117
> -#define SRST_RKVDEC_A		118
> -#define SRST_RKVDEC_NOC_A	119
> -#define SRST_RKVDEC_H		120
> -#define SRST_RKVDEC_NOC_H	121
> -#define SRST_RKVDEC_CORE	122
> -#define SRST_RKVDEC_CABAC	123
> -#define SRST_IEP_A		124
> -#define SRST_IEP_H		125
> -#define SRST_GPU_A		126
> -#define SRST_GPU_NOC_A		127
> -
> -#define SRST_CORE_DBG		128
> -#define SRST_DBG_P		129
> -#define SRST_TIMER0		130
> -#define SRST_TIMER1		131
> -#define SRST_TIMER2		132
> -#define SRST_TIMER3		133
> -#define SRST_TIMER4		134
> -#define SRST_TIMER5		135
> -#define SRST_VIO_H2P		136
> -#define SRST_HDMIPHY		139
> -#define SRST_VDAC		140
> -#define SRST_TIMER_6CH_P	141
> -
> -#endif
> --
> 2.39.5
>=20
>=20
>=20

