Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0271098792
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 14:37:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C823584010;
	Fri, 20 Mar 2026 15:37:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k7/7b0yp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AD5083FC5; Fri, 20 Mar 2026 15:37:39 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECF6684010
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 15:37:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b977165c465so33823966b.3
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 07:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774017456; x=1774622256; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=njtsYUoIqOVYg5dN//3Cb9cc4phXqB3TGTc8FTWjksk=;
 b=k7/7b0ypYMckTv6J32+dkpmTBvTYQK3n+2t8zsPlpq3fK7S7a/TaL2/SQp1AhobeUB
 ppHvjQG7DtKtTvvQyd3BO02APYPbLKdY9uL5z8eCAsc/+cX8skTuccdN8XAx6Mw7DgQG
 nalqc66WHBEgR9NzLjH5/HhyQHXTj3xxFQWUjlqmMpIdU2SwHRLt6/p2WjNAIqz3Do7q
 QOVtVOj14b4kWbxHc/xfJvlZhR5ivOzxDx+lIxKLc1ixogKVrlqizNrXoKjNjFx6eqqZ
 SB2wCungzfQNLumnBCd5I5aLsZL/CddO/x9BcGV5dSHcvaHd4Wjub6JVFn8ZeYhEvMXj
 MmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774017456; x=1774622256;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=njtsYUoIqOVYg5dN//3Cb9cc4phXqB3TGTc8FTWjksk=;
 b=f00kwXOHUkj1sbA4gNJ+len2U5NYhLdsudLgCw7mohoFkxub74lX+XEbQrUxyLidur
 eto4+e58M7aLcjbfp0BKa1ehLveGvOE73JKiCRLLJ0nFBNwrVrgOus20mjlF/2mMWPLV
 y2Yp0f0MNatVNPDiDJ1vbSRLQY0yk3dAq5RPm2qKNfImPRFT2B5ZdeuqX88k3yDVTaKr
 dyUIe2sikXsLpYlVyeD/PjfrPdf9e3vfxXtBulyv7PcZzYF+0S3+c2+1sYsCYERAzvYp
 2SaSRleRTYvhF/KWsaMY2OighGt/a2UL+k1iIdFeqWz78+KYXC77/7NoksJYaHg4uokZ
 HgyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2G9WMx52cDZieR9BrqiyJSmTQrFeWgp+GzQi7F2ibC9j12uDn5I+i08QZ+ddQDwM6KYbHdAE=@lists.denx.de
X-Gm-Message-State: AOJu0Yw48mL3IzAVBJMqoW7lfOPxQlhlFk5mLvxRqyIx+fqpp4K4i9JH
 2okfytpOfL0Cv0/vtXRvSK0iKXD4PB2QWx2mB5ozeMIYPBdM4kMTsbIZ
X-Gm-Gg: ATEYQzwzOGYxtsV2KgAGDvnhDobnePqkT4QIP/yNRExcKpCwUDfHf7GE5f2tWGEE0qP
 VaDA2pSOwmvIM0Igcv48fO83xjEAjIVpBJEg2iVDjWk7vqG9/asN52u0ovw3uH6OV33mQqZvQcl
 o0wera4EPs91qnhEC8IE+AX1tguQwUPY40vUjq7fW7zg9ufKMBz+V3iRFk+vUx1KF93/2cuY1zo
 mykh1cFYUJmm25hJgN3MH1l5VQNiTmyfpdVkazIwg/BreZZHROobOezweh2zK7n2lhS9oh9wbsH
 J9/HqRcrbdavf9SdXstjMho2cLVk9U5Q0OR9AFp23Pn2WGc2WJuhpqQ5Dh0qUeubOz4ShH49q5T
 vVRsppg/0Xb8EG5KrDMaMNUFwqWVsj0HuDy7/QKuYtAYjurxld3CqsuUIdxcMI1YtiPqNIhY1Ji
 cT2eIgNN1SJ1GYKWhsFSez8zKwKLowS4XjzoJ4sELgKHk/2ZhpTNklkRmJNdGLGQ==
X-Received: by 2002:a17:907:868b:b0:b97:d398:7f41 with SMTP id
 a640c23a62f3a-b982f0b3214mr102497366b.2.1774017455882; 
 Fri, 20 Mar 2026 07:37:35 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9832f42c8fsm160536366b.9.2026.03.20.07.37.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2026 07:37:35 -0700 (PDT)
Message-ID: <93ffa607-48a5-47d5-b26b-5d58ae388927@gmail.com>
Date: Fri, 20 Mar 2026 15:37:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 2/3] rockchip: Switch rk3229 boards to upstream devicetree
To: andy.yan@rock-chips.com
Cc: philipp.tomsich@vrull.eu, sjg@chromium.org, trini@konsulko.com,
 afaerber@suse.de, u-boot@lists.denx.de
References: <0ca86716-5e46-4f16-a579-d04dbeaa15d3@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <0ca86716-5e46-4f16-a579-d04dbeaa15d3@gmail.com>
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

Switch rk3229 boards to upstream devicetree.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/dts/Makefile                  |   3 -
 arch/arm/dts/rk3229-evb.dts            | 256 ----------------------
 arch/arm/dts/rk3229.dtsi               |  52 -----
 arch/arm/mach-rockchip/Kconfig         |   1 +
 board/rockchip/evb_rk3229/MAINTAINERS  |   1 -
 configs/evb-rk3229_defconfig           |   4 +-
 include/dt-bindings/clock/rk3228-cru.h | 287 -------------------------
 7 files changed, 3 insertions(+), 601 deletions(-)
 delete mode 100644 arch/arm/dts/rk3229-evb.dts
 delete mode 100644 arch/arm/dts/rk3229.dtsi
 delete mode 100644 include/dt-bindings/clock/rk3228-cru.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 465bc393d5f4..c3bfd664a942 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -52,9 +52,6 @@ dtb-$(CONFIG_MACH_S900) += \
 dtb-$(CONFIG_MACH_S700) += \
 	s700-cubieboard7.dtb

-dtb-$(CONFIG_ROCKCHIP_RK322X) += \
-	rk3229-evb.dtb
-
 dtb-$(CONFIG_ROCKCHIP_RK3368) += \
 	rk3368-sheep.dtb \
 	rk3368-geekbox.dtb \
diff --git a/arch/arm/dts/rk3229-evb.dts b/arch/arm/dts/rk3229-evb.dts
deleted file mode 100644
index 797476e8bef1..000000000000
--- a/arch/arm/dts/rk3229-evb.dts
+++ /dev/null
@@ -1,256 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-
-/dts-v1/;
-
-#include <dt-bindings/input/input.h>
-#include "rk3229.dtsi"
-
-/ {
-	model = "Rockchip RK3229 Evaluation board";
-	compatible = "rockchip,rk3229-evb", "rockchip,rk3229";
-
-	aliases {
-		mmc0 = &emmc;
-	};
-
-	memory@60000000 {
-		device_type = "memory";
-		reg = <0x60000000 0x40000000>;
-	};
-
-	dc_12v: dc-12v-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "dc_12v";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <12000000>;
-		regulator-max-microvolt = <12000000>;
-	};
-
-	ext_gmac: ext_gmac {
-		compatible = "fixed-clock";
-		clock-frequency = <125000000>;
-		clock-output-names = "ext_gmac";
-		#clock-cells = <0>;
-	};
-
-	vcc_host: vcc-host-regulator {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio3 RK_PC4 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&host_vbus_drv>;
-		regulator-name = "vcc_host";
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&vcc_sys>;
-	};
-
-	vcc_phy: vcc-phy-regulator {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		regulator-name = "vcc_phy";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&vccio_1v8>;
-	};
-
-	vcc_sys: vcc-sys-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc_sys";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		vin-supply = <&dc_12v>;
-	};
-
-	vccio_1v8: vccio-1v8-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vccio_1v8";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		regulator-always-on;
-		vin-supply = <&vcc_sys>;
-	};
-
-	vccio_3v3: vccio-3v3-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vccio_3v3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-always-on;
-		vin-supply = <&vcc_sys>;
-	};
-
-	vdd_arm: vdd-arm-regulator {
-		compatible = "pwm-regulator";
-		pwms = <&pwm1 0 25000 1>;
-		pwm-supply = <&vcc_sys>;
-		regulator-name = "vdd_arm";
-		regulator-min-microvolt = <950000>;
-		regulator-max-microvolt = <1400000>;
-		regulator-always-on;
-		regulator-boot-on;
-	};
-
-	vdd_log: vdd-log-regulator {
-		compatible = "pwm-regulator";
-		pwms = <&pwm2 0 25000 1>;
-		pwm-supply = <&vcc_sys>;
-		regulator-name = "vdd_log";
-		regulator-min-microvolt = <1000000>;
-		regulator-max-microvolt = <1300000>;
-		regulator-always-on;
-		regulator-boot-on;
-	};
-
-	gpio_keys {
-		compatible = "gpio-keys";
-		autorepeat;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pwr_key>;
-
-		power_key: power-key {
-			label = "GPIO Key Power";
-			gpios = <&gpio3 23 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_POWER>;
-			debounce-interval = <100>;
-			wakeup-source;
-		};
-	};
-};
-
-&cpu0 {
-	cpu-supply = <&vdd_arm>;
-};
-
-&cpu1 {
-	cpu-supply = <&vdd_arm>;
-};
-
-&cpu2 {
-	cpu-supply = <&vdd_arm>;
-};
-
-&cpu3 {
-	cpu-supply = <&vdd_arm>;
-};
-
-&emmc {
-	cap-mmc-highspeed;
-	non-removable;
-	status = "okay";
-};
-
-&gmac {
-	assigned-clocks = <&cru SCLK_MAC_EXTCLK>, <&cru SCLK_MAC>;
-	assigned-clock-parents = <&ext_gmac>, <&cru SCLK_MAC_EXTCLK>;
-	clock_in_out = "input";
-	phy-supply = <&vcc_phy>;
-	phy-mode = "rgmii";
-	pinctrl-names = "default";
-	pinctrl-0 = <&rgmii_pins>;
-	snps,reset-gpio = <&gpio2 RK_PD0 GPIO_ACTIVE_LOW>;
-	snps,reset-active-low;
-	snps,reset-delays-us = <0 10000 1000000>;
-	tx_delay = <0x30>;
-	rx_delay = <0x10>;
-	status = "okay";
-};
-
-&io_domains {
-	status = "okay";
-
-	vccio1-supply = <&vccio_3v3>;
-	vccio2-supply = <&vccio_1v8>;
-	vccio4-supply = <&vccio_3v3>;
-};
-
-&pinctrl {
-	keys {
-		pwr_key: pwr-key {
-			rockchip,pins = <3 RK_PC7 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-
-	usb {
-		host_vbus_drv: host-vbus-drv {
-			rockchip,pins = <3 RK_PC4 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-};
-
-&pwm1 {
-	status = "okay";
-};
-
-&pwm2 {
-	status = "okay";
-};
-
-&tsadc {
-	rockchip,hw-tshut-mode = <0>; /* tshut mode 0:CRU 1:GPIO */
-	status = "okay";
-};
-
-&uart2 {
-	status = "okay";
-};
-
-&u2phy0 {
-	status = "okay";
-
-	u2phy0_otg: otg-port {
-		status = "okay";
-	};
-
-	u2phy0_host: host-port {
-		phy-supply = <&vcc_host>;
-		status = "okay";
-	};
-};
-
-&u2phy1 {
-	status = "okay";
-
-	u2phy1_otg: otg-port {
-		phy-supply = <&vcc_host>;
-		status = "okay";
-	};
-
-	u2phy1_host: host-port {
-		phy-supply = <&vcc_host>;
-		status = "okay";
-	};
-};
-
-&usb_host0_ehci {
-	status = "okay";
-};
-
-&usb_host0_ohci {
-	status = "okay";
-};
-
-&usb_host1_ehci {
-	status = "okay";
-};
-
-&usb_host1_ohci {
-	status = "okay";
-};
-
-&usb_host2_ehci {
-	status = "okay";
-};
-
-&usb_host2_ohci {
-	status = "okay";
-};
-
-&usb_otg {
-	status = "okay";
-};
diff --git a/arch/arm/dts/rk3229.dtsi b/arch/arm/dts/rk3229.dtsi
deleted file mode 100644
index c340fb30e775..000000000000
--- a/arch/arm/dts/rk3229.dtsi
+++ /dev/null
@@ -1,52 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (c) 2017 Fuzhou Rockchip Electronics Co., Ltd
- */
-
-#include "rk322x.dtsi"
-
-/ {
-	compatible = "rockchip,rk3229";
-
-	/delete-node/ opp-table0;
-
-	cpu0_opp_table: opp-table-0 {
-		compatible = "operating-points-v2";
-		opp-shared;
-
-		opp-408000000 {
-			opp-hz = /bits/ 64 <408000000>;
-			opp-microvolt = <950000>;
-			clock-latency-ns = <40000>;
-			opp-suspend;
-		};
-		opp-600000000 {
-			opp-hz = /bits/ 64 <600000000>;
-			opp-microvolt = <975000>;
-		};
-		opp-816000000 {
-			opp-hz = /bits/ 64 <816000000>;
-			opp-microvolt = <1000000>;
-		};
-		opp-1008000000 {
-			opp-hz = /bits/ 64 <1008000000>;
-			opp-microvolt = <1175000>;
-		};
-		opp-1200000000 {
-			opp-hz = /bits/ 64 <1200000000>;
-			opp-microvolt = <1275000>;
-		};
-		opp-1296000000 {
-			opp-hz = /bits/ 64 <1296000000>;
-			opp-microvolt = <1325000>;
-		};
-		opp-1392000000 {
-			opp-hz = /bits/ 64 <1392000000>;
-			opp-microvolt = <1375000>;
-		};
-		opp-1464000000 {
-			opp-hz = /bits/ 64 <1464000000>;
-			opp-microvolt = <1400000>;
-		};
-	};
-};
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 855dba2ffb62..6b32f18e2124 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -109,6 +109,7 @@ config ROCKCHIP_RK322X
 	select TPL_OF_LIBFDT
 	select TPL_HAVE_INIT_STACK if TPL
 	select SPL_DRIVERS_MISC
+	imply OF_UPSTREAM
 	imply ROCKCHIP_COMMON_BOARD
 	imply SPL_SERIAL
 	imply SPL_ROCKCHIP_COMMON_BOARD
diff --git a/board/rockchip/evb_rk3229/MAINTAINERS b/board/rockchip/evb_rk3229/MAINTAINERS
index 4de97dbb0a49..7758ee9b9306 100644
--- a/board/rockchip/evb_rk3229/MAINTAINERS
+++ b/board/rockchip/evb_rk3229/MAINTAINERS
@@ -1,7 +1,6 @@
 EVB-RK3229
 M:      Kever Yang <kever.yang@rock-chips.com>
 S:      Maintained
-F:	arch/arm/dts/rk3229-evb.dts
 F:	arch/arm/dts/rk3229-evb-u-boot.dtsi
 F:      board/rockchip/evb_rk3229
 F:      include/configs/evb_rk3229.h
diff --git a/configs/evb-rk3229_defconfig b/configs/evb-rk3229_defconfig
index 116c04c914d7..46a682faecb0 100644
--- a/configs/evb-rk3229_defconfig
+++ b/configs/evb-rk3229_defconfig
@@ -9,7 +9,7 @@ CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x61100000
 CONFIG_ENV_OFFSET=0x3F8000
-CONFIG_DEFAULT_DEVICE_TREE="rk3229-evb"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3229-evb"
 CONFIG_ROCKCHIP_RK322X=y
 CONFIG_TARGET_EVB_RK3229=y
 CONFIG_SPL_STACK_R_ADDR=0x60600000
@@ -24,7 +24,7 @@ CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_USE_PREBOOT=y
-CONFIG_DEFAULT_FDT_FILE="rk3229-evb.dtb"
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3229-evb.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x100000
diff --git a/include/dt-bindings/clock/rk3228-cru.h b/include/dt-bindings/clock/rk3228-cru.h
deleted file mode 100644
index de550ea56eeb..000000000000
--- a/include/dt-bindings/clock/rk3228-cru.h
+++ /dev/null
@@ -1,287 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (c) 2015 Rockchip Electronics Co. Ltd.
- * Author: Jeffy Chen <jeffy.chen@rock-chips.com>
- */
-
-#ifndef _DT_BINDINGS_CLK_ROCKCHIP_RK3228_H
-#define _DT_BINDINGS_CLK_ROCKCHIP_RK3228_H
-
-/* core clocks */
-#define PLL_APLL		1
-#define PLL_DPLL		2
-#define PLL_CPLL		3
-#define PLL_GPLL		4
-#define ARMCLK			5
-
-/* sclk gates (special clocks) */
-#define SCLK_SPI0		65
-#define SCLK_NANDC		67
-#define SCLK_SDMMC		68
-#define SCLK_SDIO		69
-#define SCLK_EMMC		71
-#define SCLK_TSADC		72
-#define SCLK_UART0		77
-#define SCLK_UART1		78
-#define SCLK_UART2		79
-#define SCLK_I2S0		80
-#define SCLK_I2S1		81
-#define SCLK_I2S2		82
-#define SCLK_SPDIF		83
-#define SCLK_TIMER0		85
-#define SCLK_TIMER1		86
-#define SCLK_TIMER2		87
-#define SCLK_TIMER3		88
-#define SCLK_TIMER4		89
-#define SCLK_TIMER5		90
-#define SCLK_I2S_OUT		113
-#define SCLK_SDMMC_DRV		114
-#define SCLK_SDIO_DRV		115
-#define SCLK_EMMC_DRV		117
-#define SCLK_SDMMC_SAMPLE	118
-#define SCLK_SDIO_SAMPLE	119
-#define SCLK_SDIO_SRC		120
-#define SCLK_EMMC_SAMPLE	121
-#define SCLK_VOP		122
-#define SCLK_HDMI_HDCP		123
-#define SCLK_MAC_SRC		124
-#define SCLK_MAC_EXTCLK		125
-#define SCLK_MAC		126
-#define SCLK_MAC_REFOUT		127
-#define SCLK_MAC_REF		128
-#define SCLK_MAC_RX		129
-#define SCLK_MAC_TX		130
-#define SCLK_MAC_PHY		131
-#define SCLK_MAC_OUT		132
-#define SCLK_VDEC_CABAC		133
-#define SCLK_VDEC_CORE		134
-#define SCLK_RGA		135
-#define SCLK_HDCP		136
-#define SCLK_HDMI_CEC		137
-#define SCLK_CRYPTO		138
-#define SCLK_TSP		139
-#define SCLK_HSADC		140
-#define SCLK_WIFI		141
-#define SCLK_OTGPHY0		142
-#define SCLK_OTGPHY1		143
-#define SCLK_HDMI_PHY		144
-
-/* dclk gates */
-#define DCLK_VOP		190
-#define DCLK_HDMI_PHY		191
-
-/* aclk gates */
-#define ACLK_DMAC		194
-#define ACLK_CPU		195
-#define ACLK_VPU_PRE		196
-#define ACLK_RKVDEC_PRE		197
-#define ACLK_RGA_PRE		198
-#define ACLK_IEP_PRE		199
-#define ACLK_HDCP_PRE		200
-#define ACLK_VOP_PRE		201
-#define ACLK_VPU		202
-#define ACLK_RKVDEC		203
-#define ACLK_IEP		204
-#define ACLK_RGA		205
-#define ACLK_HDCP		206
-#define ACLK_PERI		210
-#define ACLK_VOP		211
-#define ACLK_GMAC		212
-#define ACLK_GPU		213
-
-/* pclk gates */
-#define PCLK_GPIO0		320
-#define PCLK_GPIO1		321
-#define PCLK_GPIO2		322
-#define PCLK_GPIO3		323
-#define PCLK_VIO_H2P		324
-#define PCLK_HDCP		325
-#define PCLK_EFUSE_1024		326
-#define PCLK_EFUSE_256		327
-#define PCLK_GRF		329
-#define PCLK_I2C0		332
-#define PCLK_I2C1		333
-#define PCLK_I2C2		334
-#define PCLK_I2C3		335
-#define PCLK_SPI0		338
-#define PCLK_UART0		341
-#define PCLK_UART1		342
-#define PCLK_UART2		343
-#define PCLK_TSADC		344
-#define PCLK_PWM		350
-#define PCLK_TIMER		353
-#define PCLK_CPU		354
-#define PCLK_PERI		363
-#define PCLK_HDMI_CTRL		364
-#define PCLK_HDMI_PHY		365
-#define PCLK_GMAC		367
-
-/* hclk gates */
-#define HCLK_I2S0_8CH		442
-#define HCLK_I2S1_8CH		443
-#define HCLK_I2S2_2CH		444
-#define HCLK_SPDIF_8CH		445
-#define HCLK_VOP		452
-#define HCLK_NANDC		453
-#define HCLK_SDMMC		456
-#define HCLK_SDIO		457
-#define HCLK_EMMC		459
-#define HCLK_CPU		460
-#define HCLK_VPU_PRE		461
-#define HCLK_RKVDEC_PRE		462
-#define HCLK_VIO_PRE		463
-#define HCLK_VPU		464
-#define HCLK_RKVDEC		465
-#define HCLK_VIO		466
-#define HCLK_RGA		467
-#define HCLK_IEP		468
-#define HCLK_VIO_H2P		469
-#define HCLK_HDCP_MMU		470
-#define HCLK_HOST0		471
-#define HCLK_HOST1		472
-#define HCLK_HOST2		473
-#define HCLK_OTG		474
-#define HCLK_TSP		475
-#define HCLK_M_CRYPTO		476
-#define HCLK_S_CRYPTO		477
-#define HCLK_PERI		478
-
-#define CLK_NR_CLKS		(HCLK_PERI + 1)
-
-/* soft-reset indices */
-#define SRST_CORE0_PO		0
-#define SRST_CORE1_PO		1
-#define SRST_CORE2_PO		2
-#define SRST_CORE3_PO		3
-#define SRST_CORE0		4
-#define SRST_CORE1		5
-#define SRST_CORE2		6
-#define SRST_CORE3		7
-#define SRST_CORE0_DBG		8
-#define SRST_CORE1_DBG		9
-#define SRST_CORE2_DBG		10
-#define SRST_CORE3_DBG		11
-#define SRST_TOPDBG		12
-#define SRST_ACLK_CORE		13
-#define SRST_NOC		14
-#define SRST_L2C		15
-
-#define SRST_CPUSYS_H		18
-#define SRST_BUSSYS_H		19
-#define SRST_SPDIF		20
-#define SRST_INTMEM		21
-#define SRST_ROM		22
-#define SRST_OTG_ADP		23
-#define SRST_I2S0		24
-#define SRST_I2S1		25
-#define SRST_I2S2		26
-#define SRST_ACODEC_P		27
-#define SRST_DFIMON		28
-#define SRST_MSCH		29
-#define SRST_EFUSE1024		30
-#define SRST_EFUSE256		31
-
-#define SRST_GPIO0		32
-#define SRST_GPIO1		33
-#define SRST_GPIO2		34
-#define SRST_GPIO3		35
-#define SRST_PERIPH_NOC_A	36
-#define SRST_PERIPH_NOC_BUS_H	37
-#define SRST_PERIPH_NOC_P	38
-#define SRST_UART0		39
-#define SRST_UART1		40
-#define SRST_UART2		41
-#define SRST_PHYNOC		42
-#define SRST_I2C0		43
-#define SRST_I2C1		44
-#define SRST_I2C2		45
-#define SRST_I2C3		46
-
-#define SRST_PWM		48
-#define SRST_A53_GIC		49
-#define SRST_DAP		51
-#define SRST_DAP_NOC		52
-#define SRST_CRYPTO		53
-#define SRST_SGRF		54
-#define SRST_GRF		55
-#define SRST_GMAC		56
-#define SRST_PERIPH_NOC_H	58
-#define SRST_MACPHY		63
-
-#define SRST_DMA		64
-#define SRST_NANDC		68
-#define SRST_USBOTG		69
-#define SRST_OTGC		70
-#define SRST_USBHOST0		71
-#define SRST_HOST_CTRL0		72
-#define SRST_USBHOST1		73
-#define SRST_HOST_CTRL1		74
-#define SRST_USBHOST2		75
-#define SRST_HOST_CTRL2		76
-#define SRST_USBPOR0		77
-#define SRST_USBPOR1		78
-#define SRST_DDRMSCH		79
-
-#define SRST_SMART_CARD		80
-#define SRST_SDMMC		81
-#define SRST_SDIO		82
-#define SRST_EMMC		83
-#define SRST_SPI		84
-#define SRST_TSP_H		85
-#define SRST_TSP		86
-#define SRST_TSADC		87
-#define SRST_DDRPHY		88
-#define SRST_DDRPHY_P		89
-#define SRST_DDRCTRL		90
-#define SRST_DDRCTRL_P		91
-#define SRST_HOST0_ECHI		92
-#define SRST_HOST1_ECHI		93
-#define SRST_HOST2_ECHI		94
-#define SRST_VOP_NOC_A		95
-
-#define SRST_HDMI_P		96
-#define SRST_VIO_ARBI_H		97
-#define SRST_IEP_NOC_A		98
-#define SRST_VIO_NOC_H		99
-#define SRST_VOP_A		100
-#define SRST_VOP_H		101
-#define SRST_VOP_D		102
-#define SRST_UTMI0		103
-#define SRST_UTMI1		104
-#define SRST_UTMI2		105
-#define SRST_UTMI3		106
-#define SRST_RGA		107
-#define SRST_RGA_NOC_A		108
-#define SRST_RGA_A		109
-#define SRST_RGA_H		110
-#define SRST_HDCP_A		111
-
-#define SRST_VPU_A		112
-#define SRST_VPU_H		113
-#define SRST_VPU_NOC_A		116
-#define SRST_VPU_NOC_H		117
-#define SRST_RKVDEC_A		118
-#define SRST_RKVDEC_NOC_A	119
-#define SRST_RKVDEC_H		120
-#define SRST_RKVDEC_NOC_H	121
-#define SRST_RKVDEC_CORE	122
-#define SRST_RKVDEC_CABAC	123
-#define SRST_IEP_A		124
-#define SRST_IEP_H		125
-#define SRST_GPU_A		126
-#define SRST_GPU_NOC_A		127
-
-#define SRST_CORE_DBG		128
-#define SRST_DBG_P		129
-#define SRST_TIMER0		130
-#define SRST_TIMER1		131
-#define SRST_TIMER2		132
-#define SRST_TIMER3		133
-#define SRST_TIMER4		134
-#define SRST_TIMER5		135
-#define SRST_VIO_H2P		136
-#define SRST_HDMIPHY		139
-#define SRST_VDAC		140
-#define SRST_TIMER_6CH_P	141
-
-#endif
--
2.39.5

