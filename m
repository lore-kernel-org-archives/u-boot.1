Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B77CDE77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 21:36:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E51C803DC;
	Tue,  7 Jan 2025 22:36:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KNKrHR4l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAC16805E1; Tue,  7 Jan 2025 22:36:07 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1EB78036B
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 22:36:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5d3d69e5b63so2625634a12.1
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 13:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736285764; x=1736890564; darn=lists.denx.de;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m8U27QkgGfb65ui7uXXDOc4PZNwrVlnQIs0Pl+J/670=;
 b=KNKrHR4l/Ty4RqzBihZYqMuwgMHOAWocY3BkFBFK8JybJckN8SqwJ0ROxsnKPx2Yha
 rCVAeVDtWwAsgvxlScEJxhXbPaekltRKLtjFE/+l9CSadN215FmCPSru08dBY6F4cmbe
 BcFUgorbxhjfBrmPMCPRe4ixrhDTO7wtK1hnG88lY7+K8mMjkjhy7ftjy4vi+6TdP6AD
 pstMFVw4knuUbUEbHamhnvAqMpHw8EhF0c4/hadt+SQfSoDKmf872mcb8YLP3eiSxTcv
 3Bewe4kyNSCEV19ruqJt96qCz2htlTCJd7lNz4LFnSlhHIi1sPk1jfwE7EN2BBG928CH
 ereA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736285764; x=1736890564;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=m8U27QkgGfb65ui7uXXDOc4PZNwrVlnQIs0Pl+J/670=;
 b=EUzmA8T6hzQtDaCN+uATte9oj299fyfgZEF2s2wn8x89Gk3MMqYkGB/yaMPDIkCB+i
 25EucamwLUv6APewGjGELXe49bYMRetV6BtPYKBzufzB7jhYF1toRI1+LHou0qMMDEKK
 4qNJgcfTg6Fg8XNP6tqaxudlCOEwyKUY/a+vGXG9CfWOzumsMEby2hDeVG6p4FikTsot
 c4yZ5gFrQD9DqeoCtEOYKBAeSesPFwprTad2JazI2zlEVD1GocaoFvl0ypnkOmk/CaKC
 ZfZWvotyI1FDMCxASxLwxT1nUJqc+jqqy7lIMGA1h8hto5mIKT3e1k6j/aC+5oK1hn7f
 8xiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTUeU5H5rEXGIXwD32e5YH0LlKCs9YdnJRVhd28I7W7HLsWPhLX+Kva3OuESOwwIUQKR/bNxg=@lists.denx.de
X-Gm-Message-State: AOJu0YzZhZmVqdLeVOvEiKgSl8g7sQgJXVCpIi3KXwgGQsP9EpPA+n6A
 V2+IGSrwhAbXHPZbsUc+748eZ0VX3kCH9l2uIw0F2F2QZY/MzQsW
X-Gm-Gg: ASbGnctsXkUaenzfAZw31yhACtgu7NPo5GA/ORqbRrdDzsy2LLdQ5C6PyHAQqLZ81j4
 YWBEotom5u1gkhfCtILrobnfw9eCQDPeuuy4jp7tU4h8hXnE8AKKx+bM49I/I9UQjbphjF8DIQ9
 AsSoAqkrrlFywwKjC+ZugfF30vfDrz4Ejucgblb2gkKOQ7eP6iB1AV0OvAlK4QeXKPmf3IGfpDt
 RhdOa+CxfG5tGPc3VWC9Trvf1aQOQw1KdrRGJfnIODZpzYL3QEf1x+/Isv/DrahH707HxicEo0f
 qWL/naOWzE6GkOQJ/aAH
X-Google-Smtp-Source: AGHT+IFkgmrzFxDU800MxJ7SgY8L46m+JQHWMbQa6SGHYvwVBehL6YUhkYWZSpsUhsQMCqCf0NjchQ==
X-Received: by 2002:a05:6402:2548:b0:5d9:a5d:b203 with SMTP id
 4fb4d7f45d1cf-5d972e6c4c6mr129498a12.8.1736285763872; 
 Tue, 07 Jan 2025 13:36:03 -0800 (PST)
Received: from ?IPV6:2a02:a449:4071:1:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:1:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d80675a5a8sm24554299a12.13.2025.01.07.13.36.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2025 13:36:02 -0800 (PST)
Message-ID: <f540efc8-0624-4bd0-a4aa-eb3c1159162e@gmail.com>
Date: Tue, 7 Jan 2025 22:36:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2] rockchip: use OF_UPSTREAM for rk3036
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, u-boot@lists.denx.de,
 Andy Yan <andyshrk@163.com>
Content-Language: en-US
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

The device tree for rk3036 combined is now
available in the /dts/upstream directory.
Use imply OF_UPSTREAM to migrate all rk3036 boards.

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Apply after due to Makefile changes:
  [PATCH v2] rockchip: use OF_UPSTREAM for rk3066a/rk3188
  https://lore.kernel.org/u-boot/93c8f104-8596-433d-bc28-c82034addfaa@gmail.com/

Changed V2:
  Keep MAINTAINERS is as-is
---

SPL/TPL output status is unknown with current defconfig

---
 arch/arm/dts/Makefile                         |   3 -
 ...sdk-u-boot.dtsi => rk3036-evb-u-boot.dtsi} |   6 +-
 arch/arm/dts/rk3036-kylin-u-boot.dtsi         |  13 +
 arch/arm/dts/rk3036-sdk.dts                   |  74 ---
 arch/arm/dts/rk3036.dtsi                      | 439 ------------------
 arch/arm/mach-rockchip/Kconfig                |   1 +
 configs/evb-rk3036_defconfig                  |   4 +-
 configs/kylin-rk3036_defconfig                |   4 +-
 include/dt-bindings/clock/rk3036-cru.h        | 185 --------
 9 files changed, 21 insertions(+), 708 deletions(-)
 rename arch/arm/dts/{rk3036-sdk-u-boot.dtsi => rk3036-evb-u-boot.dtsi} (100%)
 create mode 100644 arch/arm/dts/rk3036-kylin-u-boot.dtsi
 delete mode 100644 arch/arm/dts/rk3036-sdk.dts
 delete mode 100644 arch/arm/dts/rk3036.dtsi
 delete mode 100644 include/dt-bindings/clock/rk3036-cru.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 166f9628dc8a..eb5962b52d2f 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -52,9 +52,6 @@ dtb-$(CONFIG_MACH_S900) += \
 dtb-$(CONFIG_MACH_S700) += \
 	s700-cubieboard7.dtb

-dtb-$(CONFIG_ROCKCHIP_RK3036) += \
-	rk3036-sdk.dtb
-
 dtb-$(CONFIG_ROCKCHIP_RK3128) += \
 	rk3128-evb.dtb

diff --git a/arch/arm/dts/rk3036-sdk-u-boot.dtsi b/arch/arm/dts/rk3036-evb-u-boot.dtsi
similarity index 100%
rename from arch/arm/dts/rk3036-sdk-u-boot.dtsi
rename to arch/arm/dts/rk3036-evb-u-boot.dtsi
index ef7e0207c3e9..f8857c736d07 100644
--- a/arch/arm/dts/rk3036-sdk-u-boot.dtsi
+++ b/arch/arm/dts/rk3036-evb-u-boot.dtsi
@@ -1,13 +1,13 @@
 #include "rk3036-u-boot.dtsi"

-&uart2 {
+&grf {
 	bootph-all;
 };

-&grf {
+&pinctrl {
 	bootph-all;
 };

-&pinctrl {
+&uart2 {
 	bootph-all;
 };
diff --git a/arch/arm/dts/rk3036-kylin-u-boot.dtsi b/arch/arm/dts/rk3036-kylin-u-boot.dtsi
new file mode 100644
index 000000000000..f8857c736d07
--- /dev/null
+++ b/arch/arm/dts/rk3036-kylin-u-boot.dtsi
@@ -0,0 +1,13 @@
+#include "rk3036-u-boot.dtsi"
+
+&grf {
+	bootph-all;
+};
+
+&pinctrl {
+	bootph-all;
+};
+
+&uart2 {
+	bootph-all;
+};
diff --git a/arch/arm/dts/rk3036-sdk.dts b/arch/arm/dts/rk3036-sdk.dts
deleted file mode 100644
index 3493150df927..000000000000
--- a/arch/arm/dts/rk3036-sdk.dts
+++ /dev/null
@@ -1,74 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2015 Rockchip Electronics Co., Ltd
- */
-
-/dts-v1/;
-
-#include "rk3036.dtsi"
-
-/ {
-	model = "SDK-RK3036";
-	compatible = "sdk,sdk-rk3036", "rockchip,rk3036";
-
-	chosen {
-		stdout-path = &uart2;
-	};
-
-	vcc5v0_otg: vcc5v0-otg-drv {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc5v0_otg";
-		gpio = <&gpio0 26 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&otg_vbus_drv>;
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-	};
-
-	vcc5v0_host: vcc5v0-host-drv {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc5v0_host";
-		gpio = <&gpio2 23 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&host_vbus_drv>;
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		regulator-always-on;
-	};
-};
-
-&i2c1 {
-	status = "okay";
-
-        hym8563: hym8563@51 {
-		compatible = "haoyu,hym8563";
-		reg = <0x51>;
-		#clock-cells = <0>;
-		clock-frequency = <32768>;
-		clock-output-names = "xin32k";
-	};
-};
-
-&usb_host {
-	vbus-supply = <&vcc5v0_host>;
-	status = "okay";
-};
-
-&usb_otg {
-	vbus-supply = <&vcc5v0_otg>;
-	status = "okay";
-};
-
-&pinctrl {
-	usb_otg {
-		otg_vbus_drv: host-vbus-drv {
-			rockchip,pins = <0 26 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	usb_host {
-		host_vbus_drv: host-vbus-drv {
-			rockchip,pins = <2 23 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-};
diff --git a/arch/arm/dts/rk3036.dtsi b/arch/arm/dts/rk3036.dtsi
deleted file mode 100644
index 75588de48639..000000000000
--- a/arch/arm/dts/rk3036.dtsi
+++ /dev/null
@@ -1,439 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/pinctrl/rockchip.h>
-#include <dt-bindings/clock/rk3036-cru.h>
-#include "skeleton.dtsi"
-
-/ {
-	compatible = "rockchip,rk3036";
-
-	interrupt-parent = <&gic>;
-
-	aliases {
-		gpio0 = &gpio0;
-		gpio1 = &gpio1;
-		gpio2 = &gpio2;
-		i2c1 = &i2c1;
-		serial0 = &uart0;
-		serial1 = &uart1;
-		serial2 = &uart2;
-		mmc0 = &emmc;
-		mmc1 = &sdmmc;
-	};
-
-	memory {
-		device_type = "memory";
-		reg = <0x60000000 0x40000000>;
-	};
-
-        arm-pmu {
-                compatible = "arm,cortex-a7-pmu";
-                interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
-                             <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
-                interrupt-affinity = <&cpu0>, <&cpu1>;
-        };
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		enable-method = "rockchip,rk3036-smp";
-
-		cpu0: cpu@f00 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a7";
-			reg = <0xf00>;
-			operating-points = <
-				/* KHz    uV */
-				 816000 1000000
-			>;
-			#cooling-cells = <2>; /* min followed by max */
-			clock-latency = <40000>;
-			clocks = <&cru ARMCLK>;
-			resets = <&cru SRST_CORE0>;
-		};
-		cpu1: cpu@f01 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a7";
-			reg = <0xf01>;
-			resets = <&cru SRST_CORE1>;
-		};
-	};
-
-	amba {
-		compatible = "arm,amba-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-                pdma: pdma@20078000 {
-                        compatible = "arm,pl330", "arm,primecell";
-                        reg = <0x20078000 0x4000>;
-                        arm,pl330-broken-no-flushp;
-                        interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
-                                     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
-                        #dma-cells = <1>;
-                        clocks = <&cru ACLK_DMAC2>;
-                        clock-names = "apb_pclk";
-                };
-	};
-
-	xin24m: oscillator {
-		compatible = "fixed-clock";
-		clock-frequency = <24000000>;
-		clock-output-names = "xin24m";
-		#clock-cells = <0>;
-	};
-
-	timer {
-		compatible = "arm,armv7-timer";
-		arm,cpu-registers-not-fw-configured;
-		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
-			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
-			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
-			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
-		clock-frequency = <24000000>;
-	};
-
-	cru: clock-controller@20000000 {
-		compatible = "rockchip,rk3036-cru";
-		reg = <0x20000000 0x1000>;
-		rockchip,grf = <&grf>;
-		#clock-cells = <1>;
-		#reset-cells = <1>;
-		assigned-clocks = <&cru PLL_GPLL>;
-		assigned-clock-rates = <594000000>;
-	};
-
-	uart0: serial@20060000 {
-		compatible = "rockchip,rk3036-uart", "snps,dw-apb-uart";
-		reg = <0x20060000 0x100>;
-		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
-		clock-frequency = <24000000>;
-		clocks = <&cru SCLK_UART0>, <&cru PCLK_UART0>;
-		clock-names = "baudclk", "apb_pclk";
-		pinctrl-names = "default";
-		pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
-	};
-
-	uart1: serial@20064000 {
-		compatible = "rockchip,rk3036-uart", "snps,dw-apb-uart";
-		reg = <0x20064000 0x100>;
-		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
-		clock-frequency = <24000000>;
-		clocks = <&cru SCLK_UART1>, <&cru PCLK_UART1>;
-		clock-names = "baudclk", "apb_pclk";
-		pinctrl-names = "default";
-		pinctrl-0 = <&uart1_xfer>;
-	};
-
-	uart2: serial@20068000 {
-		compatible = "rockchip,rk3036-uart", "snps,dw-apb-uart";
-		reg = <0x20068000 0x100>;
-		interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
-		clock-frequency = <24000000>;
-		clocks = <&cru SCLK_UART2>, <&cru PCLK_UART2>;
-		clock-names = "baudclk", "apb_pclk";
-		pinctrl-names = "default";
-		pinctrl-0 = <&uart2_xfer>;
-	};
-
-	pwm0: pwm@20050000 {
-		compatible = "rockchip,rk2928-pwm";
-		reg = <0x20050000 0x10>;
-		#pwm-cells = <3>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pwm0_pin>;
-		clocks = <&cru PCLK_PWM>;
-		clock-names = "pwm";
-		status = "disabled";
-	};
-
-	pwm1: pwm@20050010 {
-		compatible = "rockchip,rk2928-pwm";
-		reg = <0x20050010 0x10>;
-		#pwm-cells = <3>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pwm1_pin>;
-		clocks = <&cru PCLK_PWM>;
-		clock-names = "pwm";
-		status = "disabled";
-	};
-
-	pwm2: pwm@20050020 {
-		compatible = "rockchip,rk2928-pwm";
-		reg = <0x20050020 0x10>;
-		#pwm-cells = <3>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pwm2_pin>;
-		clocks = <&cru PCLK_PWM>;
-		clock-names = "pwm";
-		status = "disabled";
-	};
-
-	pwm3: pwm@20050030 {
-		compatible = "rockchip,rk2928-pwm";
-		reg = <0x20050030 0x10>;
-		#pwm-cells = <2>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pwm3_pin>;
-		clocks = <&cru PCLK_PWM>;
-		clock-names = "pwm";
-		status = "disabled";
-	};
-
-	sram: sram@10080000 {
-		compatible = "rockchip,rk3036-smp-sram", "mmio-sram";
-		reg = <0x10080000 0x2000>;
-	};
-
-	gic: interrupt-controller@10139000 {
-		compatible = "arm,gic-400";
-		interrupt-controller;
-		#interrupt-cells = <3>;
-		#address-cells = <0>;
-
-		reg = <0x10139000 0x1000>,
-		      <0x1013a000 0x1000>,
-		      <0x1013c000 0x2000>,
-		      <0x1013e000 0x2000>;
-		interrupts = <GIC_PPI 9 0xf04>;
-	};
-
-	grf: syscon@20008000 {
-		compatible = "rockchip,rk3036-grf", "syscon";
-		reg = <0x20008000 0x1000>;
-	};
-
-	usb_otg: usb@10180000 {
-		compatible = "rockchip,rk3288-usb", "rockchip,rk3066-usb",
-				"snps,dwc2";
-		reg = <0x10180000 0x40000>;
-		interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cru HCLK_OTG0>;
-		clock-names = "otg";
-		dr_mode = "otg";
-		g-np-tx-fifo-size = <16>;
-		g-rx-fifo-size = <275>;
-		g-tx-fifo-size = <256 128 128 64 64 32>;
-		g-use-dma;
-		status = "disabled";
-	};
-
-	usb_host: usb@101c0000 {
-		compatible = "rockchip,rk3288-usb", "rockchip,rk3066-usb",
-				"snps,dwc2";
-		reg = <0x101c0000 0x40000>;
-		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cru HCLK_OTG1>;
-		clock-names = "otg";
-		dr_mode = "host";
-		status = "disabled";
-	};
-
-	emmc: dwmmc@1021c000 {
-		compatible = "rockchip,rk3288-dw-mshc";
-		clock-frequency = <37500000>;
-		max-frequency = <37500000>;
-		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
-		<&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
-		clock-names = "biu", "ciu", "ciu_drv", "ciu_sample";
-		dmas = <&pdma 12>;
-		dma-names = "rx-tx";
-		fifo-depth = <0x100>;
-		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
-		reg = <0x1021c000 0x4000>;
-		broken-cd;
-		bus-width = <8>;
-		cap-mmc-highspeed;
-		mmc-ddr-1_8v;
-		disable-wp;
-		fifo-mode;
-		non-removable;
-		num-slots = <1>;
-		default-sample-phase = <158>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_bus8>;
-	};
-
-	sdmmc: dwmmc@10214000 {
-		compatible = "rockchip,rk3036-dw-mshc", "rockchip,rk3288-dw-mshc";
-		reg = <0x10214000 0x4000>;
-		clock-frequency = <37500000>;
-		max-frequency = <37500000>;
-		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>;
-		clock-names = "biu", "ciu";
-		fifo-depth = <0x100>;
-		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-		status = "disabled";
-	};
-
-	pinctrl: pinctrl {
-		compatible = "rockchip,rk3036-pinctrl";
-		rockchip,grf = <&grf>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		gpio0: gpio0@2007c000 {
-			compatible = "rockchip,gpio-bank";
-			reg = <0x2007c000 0x100>;
-			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cru PCLK_GPIO0>;
-
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-
-		gpio1: gpio1@20080000 {
-			compatible = "rockchip,gpio-bank";
-			reg = <0x20080000 0x100>;
-			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cru PCLK_GPIO1>;
-
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-
-		gpio2: gpio2@20084000 {
-			compatible = "rockchip,gpio-bank";
-			reg = <0x20084000 0x100>;
-			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cru PCLK_GPIO2>;
-
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-
-		pcfg_pull_up: pcfg-pull-up {
-			bias-pull-up;
-		};
-
-		pcfg_pull_down: pcfg-pull-down {
-			bias-pull-down;
-		};
-
-		pcfg_pull_none: pcfg-pull-none {
-			bias-disable;
-		};
-
-		emmc {
-			/*
-			 * We run eMMC at max speed; bump up drive strength.
-			 * We also have external pulls, so disable the internal ones.
-			 */
-			emmc_clk: emmc-clk {
-				rockchip,pins = <2 4 RK_FUNC_2 &pcfg_pull_none>;
-			};
-
-			emmc_cmd: emmc-cmd {
-				rockchip,pins = <2 1 RK_FUNC_2 &pcfg_pull_none>;
-			};
-
-			emmc_bus8: emmc-bus8 {
-				rockchip,pins = <1 24 RK_FUNC_2 &pcfg_pull_none>,
-						<1 25 RK_FUNC_2 &pcfg_pull_none>,
-						<1 26 RK_FUNC_2 &pcfg_pull_none>,
-						<1 27 RK_FUNC_2 &pcfg_pull_none>;
-				/*
-						<1 28 RK_FUNC_2 &pcfg_pull_up>,
-						<1 29 RK_FUNC_2 &pcfg_pull_up>,
-						<1 30 RK_FUNC_2 &pcfg_pull_up>,
-						<1 31 RK_FUNC_2 &pcfg_pull_up>;
-						*/
-			};
-		};
-
-		uart0 {
-			uart0_xfer: uart0-xfer {
-				rockchip,pins = <0 16 RK_FUNC_1 &pcfg_pull_none>,
-						<0 17 RK_FUNC_1 &pcfg_pull_none>;
-			};
-
-			uart0_cts: uart0-cts {
-				rockchip,pins = <0 18 RK_FUNC_1 &pcfg_pull_none>;
-			};
-
-			uart0_rts: uart0-rts {
-				rockchip,pins = <0 19 RK_FUNC_1 &pcfg_pull_none>;
-			};
-		};
-
-		uart1 {
-			uart1_xfer: uart1-xfer {
-				rockchip,pins = <2 22 RK_FUNC_1 &pcfg_pull_none>,
-						<2 23 RK_FUNC_1 &pcfg_pull_none>;
-			};
-			/* no rts / cts for uart1 */
-		};
-
-                uart2 {
-                        uart2_xfer: uart2-xfer {
-                                rockchip,pins = <1 18 RK_FUNC_2 &pcfg_pull_none>,
-                                                <1 19 RK_FUNC_2 &pcfg_pull_none>;
-                        };
-                        /* no rts / cts for uart2 */
-                };
-
-		pwm0 {
-			pwm0_pin: pwm0-pin {
-				rockchip,pins = <0 0 RK_FUNC_2 &pcfg_pull_none>;
-			};
-		};
-
-		pwm1 {
-			pwm1_pin: pwm1-pin {
-				rockchip,pins = <0 1 RK_FUNC_2 &pcfg_pull_none>;
-			};
-		};
-
-		pwm2 {
-			pwm2_pin: pwm2-pin {
-				rockchip,pins = <0 1 2 &pcfg_pull_none>;
-			};
-		};
-
-		pwm3 {
-			pwm3_pin: pwm3-pin {
-				rockchip,pins = <0 27 1 &pcfg_pull_none>;
-			};
-		};
-
-		i2c1 {
-			i2c1_xfer: i2c1-xfer {
-				rockchip,pins = <0 2 RK_FUNC_1 &pcfg_pull_none>,
-						<0 3 RK_FUNC_1 &pcfg_pull_none>;
-			};
-		};
-	};
-
-	i2c1: i2c@20056000 {
-		compatible = "rockchip,rk3288-i2c";
-		reg = <0x20056000 0x1000>;
-		interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clock-names = "i2c";
-		clocks = <&cru PCLK_I2C1>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&i2c1_xfer>;
-		status = "disabled";
-	};
-};
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index a9420406649c..5576a9369f24 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -29,6 +29,7 @@ config ROCKCHIP_RK3036
 	select CPU_V7A
 	select SUPPORT_SPL
 	select SPL
+	imply OF_UPSTREAM
 	imply USB_FUNCTION_ROCKUSB
 	imply CMD_ROCKUSB
 	imply ROCKCHIP_COMMON_BOARD
diff --git a/configs/evb-rk3036_defconfig b/configs/evb-rk3036_defconfig
index ba79960495ee..d215af0c046e 100644
--- a/configs/evb-rk3036_defconfig
+++ b/configs/evb-rk3036_defconfig
@@ -11,7 +11,7 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x60100000
 CONFIG_SF_DEFAULT_SPEED=20000000
-CONFIG_DEFAULT_DEVICE_TREE="rk3036-sdk"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3036-evb"
 CONFIG_ROCKCHIP_RK3036=y
 CONFIG_SPL_STACK_R_ADDR=0x80000
 CONFIG_SPL_STACK=0x10081fff
@@ -23,7 +23,7 @@ CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set
 CONFIG_USE_PREBOOT=y
-CONFIG_DEFAULT_FDT_FILE="rk3036-evb.dtb"
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3036-evb.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 # CONFIG_SPL_FRAMEWORK is not set
diff --git a/configs/kylin-rk3036_defconfig b/configs/kylin-rk3036_defconfig
index dd25fd601078..bc60bc570758 100644
--- a/configs/kylin-rk3036_defconfig
+++ b/configs/kylin-rk3036_defconfig
@@ -12,7 +12,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x60100000
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_OFFSET=0x3F8000
-CONFIG_DEFAULT_DEVICE_TREE="rk3036-sdk"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3036-kylin"
 CONFIG_ROCKCHIP_RK3036=y
 CONFIG_TARGET_KYLIN_RK3036=y
 CONFIG_SPL_STACK_R_ADDR=0x80000
@@ -25,7 +25,7 @@ CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set
 CONFIG_USE_PREBOOT=y
-CONFIG_DEFAULT_FDT_FILE="rk3036-kylin.dtb"
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3036-kylin.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 # CONFIG_SPL_FRAMEWORK is not set
diff --git a/include/dt-bindings/clock/rk3036-cru.h b/include/dt-bindings/clock/rk3036-cru.h
deleted file mode 100644
index 2c0552d1a936..000000000000
--- a/include/dt-bindings/clock/rk3036-cru.h
+++ /dev/null
@@ -1,185 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (c) 2014 MundoReader S.L.
- * Author: Heiko Stuebner <heiko@sntech.de>
- */
-
-#ifndef _DT_BINDINGS_CLK_ROCKCHIP_RK3036_H
-#define _DT_BINDINGS_CLK_ROCKCHIP_RK3036_H
-
-/* core clocks */
-#define PLL_APLL		1
-#define PLL_DPLL		2
-#define PLL_GPLL		3
-#define ARMCLK			4
-
-/* sclk gates (special clocks) */
-#define SCLK_GPU		64
-#define SCLK_SPI		65
-#define SCLK_SDMMC		68
-#define SCLK_SDIO		69
-#define SCLK_EMMC		71
-#define SCLK_NANDC		76
-#define SCLK_UART0		77
-#define SCLK_UART1		78
-#define SCLK_UART2		79
-#define SCLK_I2S		82
-#define SCLK_SPDIF		83
-#define SCLK_TIMER0		85
-#define SCLK_TIMER1		86
-#define SCLK_TIMER2		87
-#define SCLK_TIMER3		88
-#define SCLK_OTGPHY0		93
-#define SCLK_LCDC		100
-#define SCLK_HDMI		109
-#define SCLK_HEVC		111
-#define SCLK_I2S_OUT		113
-#define SCLK_SDMMC_DRV		114
-#define SCLK_SDIO_DRV		115
-#define SCLK_EMMC_DRV		117
-#define SCLK_SDMMC_SAMPLE	118
-#define SCLK_SDIO_SAMPLE	119
-#define SCLK_EMMC_SAMPLE	121
-#define SCLK_PVTM_CORE          123
-#define SCLK_PVTM_GPU           124
-#define SCLK_PVTM_VIDEO         125
-#define SCLK_MAC		151
-#define SCLK_MACREF		152
-#define SCLK_SFC		160
-
-#define DCLK_LCDC		190
-
-/* aclk gates */
-#define ACLK_DMAC2		194
-#define ACLK_LCDC		197
-#define ACLK_VIO		203
-#define ACLK_VCODEC		208
-#define ACLK_CPU		209
-#define ACLK_PERI		210
-
-/* pclk gates */
-#define PCLK_GPIO0		320
-#define PCLK_GPIO1		321
-#define PCLK_GPIO2		322
-#define PCLK_GRF		329
-#define PCLK_I2C0		332
-#define PCLK_I2C1		333
-#define PCLK_I2C2		334
-#define PCLK_SPI		338
-#define PCLK_UART0		341
-#define PCLK_UART1		342
-#define PCLK_UART2		343
-#define PCLK_PWM		350
-#define PCLK_TIMER		353
-#define PCLK_HDMI		360
-#define PCLK_CPU		362
-#define PCLK_PERI		363
-#define PCLK_DDRUPCTL		364
-#define PCLK_WDT		368
-
-/* hclk gates */
-#define HCLK_OTG0		449
-#define HCLK_OTG1		450
-#define HCLK_NANDC		453
-#define HCLK_SDMMC		456
-#define HCLK_SDIO		457
-#define HCLK_EMMC		459
-#define HCLK_I2S		462
-#define HCLK_LCDC		465
-#define HCLK_ROM		467
-#define HCLK_VIO_BUS		472
-#define HCLK_VCODEC		476
-#define HCLK_CPU		477
-#define HCLK_PERI		478
-
-#define CLK_NR_CLKS		(HCLK_PERI + 1)
-
-/* soft-reset indices */
-#define SRST_CORE0		0
-#define SRST_CORE1		1
-#define SRST_CORE0_DBG		4
-#define SRST_CORE1_DBG		5
-#define SRST_CORE0_POR		8
-#define SRST_CORE1_POR		9
-#define SRST_L2C		12
-#define SRST_TOPDBG		13
-#define SRST_STRC_SYS_A		14
-#define SRST_PD_CORE_NIU	15
-
-#define SRST_TIMER2		16
-#define SRST_CPUSYS_H		17
-#define SRST_AHB2APB_H		19
-#define SRST_TIMER3		20
-#define SRST_INTMEM		21
-#define SRST_ROM		22
-#define SRST_PERI_NIU		23
-#define SRST_I2S		24
-#define SRST_DDR_PLL		25
-#define SRST_GPU_DLL		26
-#define SRST_TIMER0		27
-#define SRST_TIMER1		28
-#define SRST_CORE_DLL		29
-#define SRST_EFUSE_P		30
-#define SRST_ACODEC_P		31
-
-#define SRST_GPIO0		32
-#define SRST_GPIO1		33
-#define SRST_GPIO2		34
-#define SRST_UART0		39
-#define SRST_UART1		40
-#define SRST_UART2		41
-#define SRST_I2C0		43
-#define SRST_I2C1		44
-#define SRST_I2C2		45
-#define SRST_SFC		47
-
-#define SRST_PWM0		48
-#define SRST_DAP		51
-#define SRST_DAP_SYS		52
-#define SRST_GRF		55
-#define SRST_PERIPHSYS_A	57
-#define SRST_PERIPHSYS_H	58
-#define SRST_PERIPHSYS_P	59
-#define SRST_CPU_PERI		61
-#define SRST_EMEM_PERI		62
-#define SRST_USB_PERI		63
-
-#define SRST_DMA2		64
-#define SRST_MAC		66
-#define SRST_NANDC		68
-#define SRST_USBOTG0		69
-#define SRST_OTGC0		71
-#define SRST_USBOTG1		72
-#define SRST_OTGC1		74
-#define SRST_DDRMSCH		79
-
-#define SRST_MMC0		81
-#define SRST_SDIO		82
-#define SRST_EMMC		83
-#define SRST_SPI0		84
-#define SRST_WDT		86
-#define SRST_DDRPHY		88
-#define SRST_DDRPHY_P		89
-#define SRST_DDRCTRL		90
-#define SRST_DDRCTRL_P		91
-
-#define SRST_HDMI_P		96
-#define SRST_VIO_BUS_H		99
-#define SRST_UTMI0		103
-#define SRST_UTMI1		104
-#define SRST_USBPOR		105
-
-#define SRST_VCODEC_A		112
-#define SRST_VCODEC_H		113
-#define SRST_VIO1_A		114
-#define SRST_HEVC		115
-#define SRST_VCODEC_NIU_A	116
-#define SRST_LCDC1_A		117
-#define SRST_LCDC1_H		118
-#define SRST_LCDC1_D		119
-#define SRST_GPU		120
-#define SRST_GPU_NIU_A		122
-
-#define SRST_DBG_P		131
-
-#endif
--
2.39.5

