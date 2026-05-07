Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9E53CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 18:37:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E2E38484F;
	Thu,  7 May 2026 20:37:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k2J4T/Gc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04F018488B; Thu,  7 May 2026 20:37:56 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FD7B84099
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 20:37:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-bc32563f82cso17591666b.0
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 11:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778179072; x=1778783872; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mnpwXH0bQTEKOc9pSisP6zChFOzEu40BNmLT21B/Nao=;
 b=k2J4T/GcvOwp0MzW3UfsgphIOAXD20MqpoEdpGOnvNOZKAnpWTv0DHozfSIIAQymvN
 1R9Hhmb2Hd6eXKlSGh8mVrSmb3HaKSFIET8Jf4o39t0TSeD4BwYEJ1TBrgNZqUnL41G/
 XF3sBNpsJHw1LCravE1WvCivy8BEY6GsIHne0s5eBiXV4QW/j7gdTMu8u69nuUsx8b8d
 iJu3MRYMzhL7ScyixN2yax7qEL7Dg+PylRTPL/MsQ/gfYN4btw5vRZSfe+7c63UDbIIu
 1GC+V/ALmlghsdtk+Wwh06w8sX9XShwyn+KrrUZLIh45YFsMHo64CkGRMtk5+kLgfXGm
 B6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778179072; x=1778783872;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mnpwXH0bQTEKOc9pSisP6zChFOzEu40BNmLT21B/Nao=;
 b=Wv492ypEwZ6mlV6JlqyUpjuYFe0etqaZ1NWZzMdwoo33moQ+Ej5cyEY9MJ64t4N+Pt
 1aYhEeaDH+HHVSQQm7+mI7O6km3FcyeTAqdHuwaiWpg+AMGXG1bGh9uUoAuJBQxt/MZr
 3w0zWTqgPK8jshIm/ie4804eSbdHLST62tVB6RWXQX9a6KcPGDUtv9EDsPDkUytQYSP0
 CSm2QecEe5U2xWJDtWmR/oGmlSXC0JLI7ugKSw9mh5YooDr9WnGnl80rwRzPrGI81Y9u
 Ub/ylbITkZjBQ1mcwDA0/nvCNM8n4H6B4XFx7WBNoWXwR632GN9qRYgHIdAQs5y7AaRu
 +hng==
X-Forwarded-Encrypted: i=1;
 AFNElJ8UHpsyNohXBorYvAviqNYyac03JNOjtu6t3Kx7B3CmVaDUwnw0pAsjUL8V2M/Z1Go7scmQXIo=@lists.denx.de
X-Gm-Message-State: AOJu0YyEpVrE3zHGkostJ/z44W2/xhT4Utj2gATjbsojd5B9CgZbRPfH
 ItFee1CZeH2tDl5H7bd553ZlxSZtlo5swFy7WKEgiyClCid4Gk5WjZjk
X-Gm-Gg: AeBDietlXXsmfmvEex2F8YoD/wcAwaPUGghfs3WGfI+JVqpUQpUlUknS5NtrP925s86
 OTWzyOdW6FPa32uQnb1K9Ba7JRGTW1SntqOUskGlKJh1v6Xbhb5FgrUepQJ5dhxgNZjOgAtHDED
 ZJPS7Oy38zNSd2KSWhB5K+fm80bie8mSNyWvDuwcoNYB/sb/pcI3tgZPsTYC7gZ+rzD7eTc1ReS
 6U0JOvuad1ITd5hP90cZPuy/dDiPjfiFfsjkW/eW2k4CKGFYdzXX6qBuXCUcaXNnRh3pJobG+mc
 2KDVD8ocNDiFI81E1MjWwonHdJo/QINd/XBrWHLa1AV3+cGCvpfhSX9Q4hgeUYS/4B2+Y8E97fV
 VZWUF+ihXBgiHMKsNZk5/9i7rRBe92ZSWSgz4oizVSPqIjpEXP9OMbA/z/hxvVOWmctWWyIHaDh
 o+V6cVN+Sc+2j9qw3+4OUFGP9Stb/BFVTy4KwAi0mSsZW021WQIoiuhBz02RMsNRFlTa//J8mT
X-Received: by 2002:a17:907:c19:b0:b9c:fc84:942 with SMTP id
 a640c23a62f3a-bc56cb2d6bfmr203538466b.8.1778179071948; 
 Thu, 07 May 2026 11:37:51 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bca583dd7e4sm15248666b.58.2026.05.07.11.37.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 11:37:51 -0700 (PDT)
Message-ID: <0dd99123-acbe-48cb-b90f-ee2679d7465e@gmail.com>
Date: Thu, 7 May 2026 20:37:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 1/5] rockchip: Switch rk3128 boards to upstream devicetree
To: kever.yang@rock-chips.com
Cc: philipp.tomsich@vrull.eu, sjg@chromium.org, trini@konsulko.com,
 afaerber@suse.de, andy.yan@rock-chips.com, u-boot@lists.denx.de,
 quentin.schulz@cherry.de
References: <a5bb85ba-c159-4ac0-a1e3-4be1c6db1441@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <a5bb85ba-c159-4ac0-a1e3-4be1c6db1441@gmail.com>
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

Switch rk3128 boards to upstream devicetree.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/dts/Makefile                  |   3 -
 arch/arm/dts/rk3128-evb.dts            |  99 ----
 arch/arm/dts/rk3128.dtsi               | 780 -------------------------
 arch/arm/mach-rockchip/Kconfig         |   1 +
 configs/evb-rk3128_defconfig           |   4 +-
 include/dt-bindings/clock/rk3128-cru.h | 273 ---------
 6 files changed, 3 insertions(+), 1157 deletions(-)
 delete mode 100644 arch/arm/dts/rk3128-evb.dts
 delete mode 100644 arch/arm/dts/rk3128.dtsi
 delete mode 100644 include/dt-bindings/clock/rk3128-cru.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index e79cfb4b6337..fdd057fdfe6c 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -52,9 +52,6 @@ dtb-$(CONFIG_MACH_S900) += \
 dtb-$(CONFIG_MACH_S700) += \
 	s700-cubieboard7.dtb

-dtb-$(CONFIG_ROCKCHIP_RK3128) += \
-	rk3128-evb.dtb
-
 dtb-$(CONFIG_ROCKCHIP_RK322X) += \
 	rk3229-evb.dtb

diff --git a/arch/arm/dts/rk3128-evb.dts b/arch/arm/dts/rk3128-evb.dts
deleted file mode 100644
index 93291d787341..000000000000
--- a/arch/arm/dts/rk3128-evb.dts
+++ /dev/null
@@ -1,99 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2017 Rockchip Electronics Co., Ltd
- */
-
-/dts-v1/;
-
-#include "rk3128.dtsi"
-
-/ {
-	model = "Rockchip RK3128 Evaluation board";
-	compatible = "rockchip,rk3128-evb", "rockchip,rk3128";
-
-	chosen {
-		stdout-path = &uart2;
-	};
-
-	memory@60000000 {
-		device_type = "memory";
-		reg = <0x60000000 0x40000000>;
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
-&emmc {
-	fifo-mode;
-	status = "okay";
-};
-
-&i2c1 {
-	status = "okay";
-
-	hym8563: hym8563@51 {
-		compatible = "haoyu,hym8563";
-		reg = <0x51>;
-		#clock-cells = <0>;
-		clock-frequency = <32768>;
-		clock-output-names = "xin32k";
-	};
-};
-
-&u2phy {
-	status = "okay";
-};
-
-&u2phy_otg {
-	status = "okay";
-};
-
-&u2phy_host {
-	status = "okay";
-};
-
-&usb_host_ehci {
-	status = "okay";
-};
-
-&usb_host_ohci {
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
-			rockchip,pins = <0 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	usb_host {
-		host_vbus_drv: host-vbus-drv {
-			rockchip,pins = <2 RK_PC7 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-};
diff --git a/arch/arm/dts/rk3128.dtsi b/arch/arm/dts/rk3128.dtsi
deleted file mode 100644
index 3253c6403413..000000000000
--- a/arch/arm/dts/rk3128.dtsi
+++ /dev/null
@@ -1,780 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2017 Rockchip Electronics Co., Ltd
- */
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/pinctrl/rockchip.h>
-#include <dt-bindings/clock/rk3128-cru.h>
-
-/ {
-	compatible = "rockchip,rk3128";
-	rockchip,sram = <&sram>;
-	interrupt-parent = <&gic>;
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	aliases {
-		gpio0 = &gpio0;
-		gpio1 = &gpio1;
-		gpio2 = &gpio2;
-		gpio3 = &gpio3;
-		i2c0 = &i2c0;
-		i2c1 = &i2c1;
-		i2c2 = &i2c2;
-		i2c3 = &i2c3;
-		spi0 = &spi0;
-		serial0 = &uart0;
-		serial1 = &uart1;
-		serial2 = &uart2;
-		mmc0 = &emmc;
-		mmc1 = &sdmmc;
-	};
-
-	arm-pmu {
-		compatible = "arm,cortex-a7-pmu";
-		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		enable-method = "rockchip,rk3128-smp";
-
-		cpu0: cpu@0 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a7";
-			reg = <0x0>;
-			operating-points = <
-				/* KHz    uV */
-				 816000 1000000
-			>;
-			#cooling-cells = <2>; /* min followed by max */
-			clock-latency = <40000>;
-			clocks = <&cru ARMCLK>;
-		};
-
-		cpu1: cpu@1 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a7";
-			reg = <0x1>;
-		};
-
-		cpu2: cpu@2 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a7";
-			reg = <0x2>;
-		};
-
-		cpu3: cpu@3 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a7";
-			reg = <0x3>;
-		};
-	};
-
-	cpu_axi_bus: cpu_axi_bus {
-		compatible = "rockchip,cpu_axi_bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		qos {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-
-			crypto {
-				reg = <0x10128080 0x20>;
-			};
-
-			core {
-				reg = <0x1012a000 0x20>;
-			};
-
-			peri {
-				reg = <0x1012c000 0x20>;
-			};
-
-			gpu {
-				reg = <0x1012d000 0x20>;
-			};
-
-			vpu {
-				reg = <0x1012e000 0x20>;
-			};
-
-			rga {
-				reg = <0x1012f000 0x20>;
-			};
-			ebc {
-				reg = <0x1012f080 0x20>;
-			};
-
-			iep {
-				reg = <0x1012f100 0x20>;
-			};
-
-			lcdc {
-				reg = <0x1012f180 0x20>;
-				rockchip,priority = <3 3>;
-			};
-
-			vip {
-				reg = <0x1012f200 0x20>;
-				rockchip,priority = <3 3>;
-			};
-		};
-
-		msch {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-
-			msch@10128000 {
-				reg = <0x10128000 0x20>;
-				rockchip,read-latency = <0x3f>;
-			};
-		};
-	};
-
-	psci {
-		compatible      = "arm,psci";
-		method          = "smc";
-		cpu_suspend     = <0x84000001>;
-		cpu_off         = <0x84000002>;
-		cpu_on          = <0x84000003>;
-		migrate         = <0x84000005>;
-	};
-
-	amba {
-		compatible = "arm,amba-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		interrupt-parent = <&gic>;
-		ranges;
-
-		pdma: dma-controller@20078000 {
-			compatible = "arm,pl330", "arm,primecell";
-			reg = <0x20078000 0x4000>;
-			arm,pl330-broken-no-flushp;//2
-			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
-			#dma-cells = <1>;
-			clocks = <&cru ACLK_DMAC>;
-			clock-names = "apb_pclk";
-		};
-	};
-
-	xin24m: xin24m {
-		compatible = "fixed-clock";
-		clock-frequency = <24000000>;
-		clock-output-names = "xin24m";
-		#clock-cells = <0>;
-	};
-
-	xin12m: xin12m {
-		compatible = "fixed-clock";
-		clock-frequency = <12000000>;
-		clock-output-names = "xin12m";
-		#clock-cells = <0>;
-	};
-
-	timer {
-		compatible = "arm,armv7-timer";
-		arm,cpu-registers-not-fw-configured;
-		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
-			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
-		clock-frequency = <24000000>;
-	};
-
-	timer@20044000 {
-		compatible = "arm,armv7-timer";
-		reg = <0x20044000 0xb8>;
-		interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
-		rockchip,broadcast = <1>;
-	};
-
-	watchdog: watchdog@2004c000 {
-		compatible = "rockchip,rk3128-wdt", "snps,dw-wdt";
-		reg = <0x2004c000 0x100>;
-		clocks = <&cru PCLK_WDT>;
-		interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
-		rockchip,irq = <1>;
-		rockchip,timeout = <60>;
-		rockchip,atboot = <1>;
-		rockchip,debug = <0>;
-	};
-
-	reset: reset@20000110 {
-		compatible = "rockchip,reset";
-		reg = <0x20000110 0x24>;
-		#reset-cells = <1>;
-	};
-
-	nandc: nand-controller@10500000 {
-		compatible = "rockchip,rk3128-nfc", "rockchip,rk2928-nfc";
-		reg = <0x10500000 0x4000>;
-		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&nandc_ale &nandc_cle &nandc_wrn &nandc_rdn &nandc_rdy &nandc_cs0 &nandc_data>;
-		clocks = <&cru HCLK_NANDC>, <&cru SCLK_NANDC>;
-		clock-names = "ahb", "nfc";
-	};
-
-	cru: clock-controller@20000000 {
-		compatible = "rockchip,rk3128-cru";
-		reg = <0x20000000 0x1000>;
-		clocks = <&xin24m>;
-		clock-names = "xin24m";
-		rockchip,grf = <&grf>;
-		#clock-cells = <1>;
-		#reset-cells = <1>;
-		assigned-clocks = <&cru PLL_GPLL>;
-		assigned-clock-rates = <594000000>;
-	};
-
-	uart0: serial@20060000 {
-		compatible = "rockchip,rk3128-uart", "snps,dw-apb-uart";
-		reg = <0x20060000 0x100>;
-		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
-		clock-frequency = <24000000>;
-		clocks = <&cru SCLK_UART0>, <&cru PCLK_UART0>;
-		clock-names = "baudclk", "apb_pclk";
-		pinctrl-names = "default";
-		pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
-		dmas = <&pdma 2>, <&pdma 3>;
-		#dma-cells = <2>;
-	};
-
-	uart1: serial@20064000 {
-		compatible = "rockchip,rk3128-uart", "snps,dw-apb-uart";
-		reg = <0x20064000 0x100>;
-		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
-		clock-frequency = <24000000>;
-		clocks = <&cru SCLK_UART1>, <&cru PCLK_UART1>;
-		clock-names = "baudclk", "apb_pclk";
-		pinctrl-names = "default";
-		pinctrl-0 = <&uart1_xfer>;
-		dmas = <&pdma 4>, <&pdma 5>;
-		#dma-cells = <2>;
-	};
-
-	uart2: serial@20068000 {
-		compatible = "rockchip,rk3128-uart", "snps,dw-apb-uart";
-		reg = <0x20068000 0x100>;
-		interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
-		clock-frequency = <24000000>;
-		clocks = <&cru SCLK_UART2>, <&cru PCLK_UART2>;
-		clock-names = "baudclk", "apb_pclk";
-		pinctrl-names = "default";
-		pinctrl-0 = <&uart2_xfer>;
-		dmas = <&pdma 6>, <&pdma 7>;
-		#dma-cells = <2>;
-	};
-
-	saradc: saradc@2006c000 {
-		compatible = "rockchip,saradc";
-		reg = <0x2006c000 0x100>;
-		interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
-		#io-channel-cells = <1>;
-		clocks = <&cru SCLK_SARADC>, <&cru PCLK_SARADC>;
-		clock-names = "saradc", "apb_pclk";
-		resets = <&cru SRST_SARADC>;
-		reset-names = "saradc-apb";
-		status = "disabled";
-	};
-
-	pwm0: pwm@20050000 {
-		compatible = "rockchip,rk3128-pwm", "rockchip,rk3288-pwm";
-		reg = <0x20050000 0x10>;
-		#pwm-cells = <3>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pwm0_pin>;
-		clocks = <&cru PCLK_PWM>;
-	};
-
-	pwm1: pwm@20050010 {
-		compatible = "rockchip,rk3128-pwm", "rockchip,rk3288-pwm";
-		reg = <0x20050010 0x10>;
-		#pwm-cells = <3>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pwm1_pin>;
-		clocks = <&cru PCLK_PWM>;
-	};
-
-	pwm2: pwm@20050020 {
-		compatible = "rockchip,rk3128-pwm", "rockchip,rk3288-pwm";
-		reg = <0x20050020 0x10>;
-		#pwm-cells = <3>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pwm2_pin>;
-		clocks = <&cru PCLK_PWM>;
-	};
-
-	pwm3: pwm@20050030 {
-		compatible = "rockchip,rk3128-pwm", "rockchip,rk3288-pwm";
-		reg = <0x20050030 0x10>;
-		#pwm-cells = <3>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pwm3_pin>;
-		clocks = <&cru PCLK_PWM>;
-	};
-
-	sram: sram@10080400 {
-		compatible = "rockchip,rk3128-smp-sram", "mmio-sram";
-		reg = <0x10080400 0x1C00>;
-		map-exec;
-		map-cacheable;
-	};
-
-	pmu: syscon@100a0000 {
-		compatible = "rockchip,rk3128-pmu", "syscon", "simple-mfd";
-		reg = <0x100a0000 0x1000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-	};
-
-	gic: interrupt-controller@10139000 {
-		compatible = "arm,gic-400";
-		interrupt-controller;
-		#interrupt-cells = <3>;
-		#address-cells = <0>;
-		reg = <0x10139000 0x1000>,
-		      <0x1013a000 0x1000>,
-		      <0x1013c000 0x2000>,
-		      <0x1013e000 0x2000>;
-		interrupts = <GIC_PPI 9 0xf04>;
-	};
-
-	u2phy: usb2phy {
-		compatible = "rockchip,rk3128-usb2phy";
-		reg = <0x017c 0x0c>;
-		rockchip,grf = <&grf>;
-		clocks = <&cru SCLK_OTGPHY0>;
-		clock-names = "phyclk";
-		#clock-cells = <0>;
-		clock-output-names = "usb480m_phy";
-		status = "disabled";
-
-		u2phy_otg: otg-port {
-			#phy-cells = <0>;
-			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "otg-bvalid", "otg-id",
-					  "linestate";
-			status = "disabled";
-		};
-
-		u2phy_host: host-port {
-			#phy-cells = <0>;
-			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "linestate";
-			status = "disabled";
-		};
-	};
-
-	usb_otg: usb@10180000 {
-		compatible = "rockchip,rk3128-usb", "rockchip,rk3066-usb", "snps,dwc2";
-		reg = <0x10180000 0x40000>;
-		interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cru HCLK_OTG>;
-		clock-names = "otg";
-		dr_mode = "otg";
-		phys = <&u2phy_otg>;
-		phy-names = "usb2-phy";
-		status = "disabled";
-	};
-
-	usb_host_ehci: usb@101c0000 {
-		compatible = "generic-ehci";
-		reg = <0x101c0000 0x20000>;
-		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-		phys = <&u2phy_host>;
-		phy-names = "usb";
-		status = "disabled";
-	};
-
-	usb_host_ohci: usb@101e0000 {
-		compatible = "generic-ohci";
-		reg = <0x101e0000 0x20000>;
-		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-		phys = <&u2phy_host>;
-		phy-names = "usb";
-		status = "disabled";
-	};
-
-	sdmmc: mmc@10214000 {
-		compatible = "rockchip,rk3128-dw-mshc", "rockchip,rk3288-dw-mshc";
-		reg = <0x10214000 0x4000>;
-		max-frequency = <150000000>;
-		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
-			 <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
-		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
-		fifo-depth = <0x100>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_bus4>;
-		bus-width = <4>;
-		status = "disabled";
-	};
-
-	emmc: mmc@1021c000 {
-		compatible = "rockchip,rk3128-dw-mshc", "rockchip,rk3288-dw-mshc";
-		reg = <0x1021c000 0x4000>;
-		max-frequency = <150000000>;
-		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
-			 <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
-		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
-		bus-width = <8>;
-		default-sample-phase = <158>;
-		num-slots = <1>;
-		fifo-depth = <0x100>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_bus8>;
-		resets = <&cru SRST_EMMC>;
-		reset-names = "reset";
-		status = "disabled";
-	};
-
-	i2c0: i2c@20072000 {
-		compatible = "rockchip,rk3128-i2c", "rockchip,rk3288-i2c";
-		reg = <20072000 0x1000>;
-		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clock-names = "i2c";
-		clocks = <&cru PCLK_I2C0>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&i2c0_xfer>;
-	};
-
-	i2c1: i2c@20056000 {
-		compatible = "rockchip,rk3128-i2c", "rockchip,rk3288-i2c";
-		reg = <0x20056000 0x1000>;
-		interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clock-names = "i2c";
-		clocks = <&cru PCLK_I2C1>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&i2c1_xfer>;
-	};
-
-	i2c2: i2c@2005a000 {
-		compatible = "rockchip,rk3128-i2c", "rockchip,rk3288-i2c";
-		reg = <0x2005a000 0x1000>;
-		interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clock-names = "i2c";
-		clocks = <&cru PCLK_I2C2>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&i2c2_xfer>;
-	};
-
-	i2c3: i2c@2005e000 {
-		compatible = "rockchip,rk3128-i2c", "rockchip,rk3288-i2c";
-		reg = <0x2005e000 0x1000>;
-		interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clock-names = "i2c";
-		clocks = <&cru PCLK_I2C3>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&i2c3_xfer>;
-	};
-
-	spi0: spi@20074000 {
-		compatible = "rockchip,rk3128-spi", "rockchip,rk3066-spi";
-		reg = <0x20074000 0x1000>;
-		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&spi0_txd_mux0 &spi0_rxd_mux0 &spi0_clk_mux0 &spi0_cs0_mux0 &spi0_cs1_mux0>;
-		rockchip,spi-src-clk = <0>;
-		num-cs = <2>;
-		clocks = <&cru SCLK_SPI0>, <&cru PCLK_SPI0>;
-		clock-names = "spiclk", "apb_pclk";
-		dmas = <&pdma 8>, <&pdma 9>;
-		#dma-cells = <2>;
-		dma-names = "tx", "rx";
-	};
-
-	grf: syscon@20008000 {
-		compatible = "rockchip,rk3128-grf", "syscon";
-		reg = <0x20008000 0x1000>;
-	};
-
-	pinctrl: pinctrl@20008000 {
-		compatible = "rockchip,rk3128-pinctrl";
-		reg = <0x20008000 0xA8>,
-		      <0x200080A8 0x4C>,
-		      <0x20008118 0x20>,
-		      <0x20008100 0x04>;
-		reg-names = "base", "mux", "pull", "drv";
-		rockchip,grf = <&grf>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		gpio0: gpio@2007c000 {
-			compatible = "rockchip,gpio-bank";
-			reg = <0x2007c000 0x100>;
-			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cru PCLK_GPIO0>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-
-		gpio1: gpio@20080000 {
-			compatible = "rockchip,gpio-bank";
-			reg = <0x20080000 0x100>;
-			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cru PCLK_GPIO1>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-
-		gpio2: gpio@20084000 {
-			compatible = "rockchip,gpio-bank";
-			reg = <0x20084000 0x100>;
-			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cru PCLK_GPIO2>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-
-		gpio3: gpio@20088000 {
-			compatible = "rockchip,gpio-bank";
-			reg = <0x20088000 0x100>;
-			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cru PCLK_GPIO3>;
-			gpio-controller;
-			#gpio-cells = <2>;
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
-
-			emmc_clk: emmc-clk {
-				rockchip,pins = <2 RK_PA7 2 &pcfg_pull_none>;
-			};
-
-			emmc_cmd: emmc-cmd {
-				rockchip,pins = <2 RK_PA4 2 &pcfg_pull_none>;
-			};
-
-			emmc_pwren: emmc-pwren {
-				rockchip,pins = <2 RK_PA5 2 &pcfg_pull_none>;
-			};
-
-			emmc_bus8: emmc-bus8 {
-				rockchip,pins = <1 RK_PD0 2 &pcfg_pull_none>,
-						<1 RK_PD1 2 &pcfg_pull_none>,
-						<1 RK_PD2 2 &pcfg_pull_none>,
-						<1 RK_PD3 2 &pcfg_pull_none>,
-						<1 RK_PD4 2 &pcfg_pull_none>,
-						<1 RK_PD5 2 &pcfg_pull_none>,
-						<1 RK_PD6 2 &pcfg_pull_none>,
-						<1 RK_PD7 2 &pcfg_pull_none>;
-			};
-		};
-
-		nandc{
-			nandc_ale:nandc-ale {
-				rockchip,pins = <0 RK_PC2 1 &pcfg_pull_none>;
-			};
-
-			nandc_cle:nandc-cle {
-				rockchip,pins = <0 RK_PC2 1 &pcfg_pull_none>;
-			};
-
-			nandc_wrn:nandc-wrn {
-				rockchip,pins = <0 RK_PC2 1 &pcfg_pull_none>;
-			};
-
-			nandc_rdn:nandc-rdn {
-				rockchip,pins = <0 RK_PC2 1 &pcfg_pull_none>;
-			};
-
-			nandc_rdy:nandc-rdy {
-				rockchip,pins = <0 RK_PC2 1 &pcfg_pull_none>;
-			};
-
-			nandc_cs0:nandc-cs0 {
-				rockchip,pins = <0 RK_PC2 1 &pcfg_pull_none>;
-			};
-
-			nandc_data: nandc-data {
-				rockchip,pins = <0 RK_PC2 1 &pcfg_pull_none>;
-			};
-		};
-
-		uart0 {
-			uart0_xfer: uart0-xfer {
-				rockchip,pins = <0 RK_PC0 1 &pcfg_pull_none>,
-						<0 RK_PC1 1 &pcfg_pull_none>;
-			};
-
-			uart0_cts: uart0-cts {
-				rockchip,pins = <0 RK_PC2 1 &pcfg_pull_none>;
-			};
-
-			uart0_rts: uart0-rts {
-				rockchip,pins = <0 RK_PC3 1 &pcfg_pull_none>;
-			};
-		};
-
-		uart1 {
-			uart1_xfer: uart1-xfer {
-				rockchip,pins = <2 RK_PC6 1 &pcfg_pull_none>,
-						<2 RK_PC7 1 &pcfg_pull_none>;
-			};
-		};
-
-		uart2 {
-			uart2_xfer: uart2-xfer {
-				rockchip,pins = <1 RK_PC2 2 &pcfg_pull_none>,
-						<1 RK_PC3 2 &pcfg_pull_none>;
-			};
-		};
-
-		sdmmc {
-			sdmmc_clk: sdmmc-clk {
-				rockchip,pins = <1 RK_PC0 1 &pcfg_pull_none>;
-			};
-
-			sdmmc_cmd: sdmmc-cmd {
-				rockchip,pins = <1 RK_PC1 1 &pcfg_pull_up>;
-			};
-
-			sdmmc_wp: sdmmc-wp {
-				rockchip,pins = <1 RK_PA7 1 &pcfg_pull_up>;
-			};
-
-			sdmmc_pwren: sdmmc-pwren {
-				rockchip,pins = <1 RK_PB6 1 &pcfg_pull_up>;
-			};
-
-			sdmmc_bus4: sdmmc-bus4 {
-				rockchip,pins = <1 RK_PC2 1 &pcfg_pull_up>,
-						<1 RK_PC3 1 &pcfg_pull_up>,
-						<1 RK_PC4 1 &pcfg_pull_up>,
-						<1 RK_PC5 1 &pcfg_pull_up>;
-			};
-		};
-
-		pwm0 {
-			pwm0_pin: pwm0-pin {
-				rockchip,pins = <0 RK_PA0 2 &pcfg_pull_none>;
-			};
-		};
-
-		pwm1 {
-			pwm1_pin: pwm1-pin {
-				rockchip,pins = <0 RK_PA1 2 &pcfg_pull_none>;
-			};
-		};
-
-		pwm2 {
-			pwm2_pin: pwm2-pin {
-				rockchip,pins = <0 RK_PA1 2 &pcfg_pull_none>;
-			};
-		};
-
-		pwm3 {
-			pwm3_pin: pwm3-pin {
-				rockchip,pins = <0 RK_PD3 1 &pcfg_pull_none>;
-			};
-		};
-
-		i2c0 {
-			i2c0_xfer: i2c0-xfer {
-				rockchip,pins = <0 RK_PA0 1 &pcfg_pull_none>,
-						<0 RK_PA1 1 &pcfg_pull_none>;
-			};
-		};
-
-		i2c1 {
-			i2c1_xfer: i2c1-xfer {
-				rockchip,pins = <0 RK_PA2 1 &pcfg_pull_none>,
-						<0 RK_PA3 1 &pcfg_pull_none>;
-			};
-		};
-
-		i2c2 {
-			i2c2_xfer: i2c2-xfer {
-				rockchip,pins = <2 RK_PC4 3 &pcfg_pull_none>,
-						<2 RK_PC5 3 &pcfg_pull_none>;
-			};
-		};
-
-		i2c3 {
-			i2c3_xfer: i2c3-xfer {
-				rockchip,pins = <0 RK_PA6 1 &pcfg_pull_none>,
-						<0 RK_PA7 1 &pcfg_pull_none>;
-			};
-		};
-
-		spi0 {
-			spi0_txd_mux0:spi0-txd-mux0 {
-				rockchip,pins = <2 RK_PA4 2 &pcfg_pull_none>;
-			};
-
-			spi0_rxd_mux0:spi0-rxd-mux0 {
-				rockchip,pins = <2 RK_PA4 2 &pcfg_pull_none>;
-			};
-
-			spi0_clk_mux0:spi0-clk-mux0 {
-				rockchip,pins = <2 RK_PA4 2 &pcfg_pull_none>;
-			};
-
-			spi0_cs0_mux0:spi0-cs0-mux0 {
-				rockchip,pins = <2 RK_PA4 2 &pcfg_pull_none>;
-			};
-
-			spi0_cs1_mux0:spi0-cs1-mux0 {
-				rockchip,pins = <2 RK_PA4 2 &pcfg_pull_none>;
-			};
-		};
-
-	};
-};
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 108713488af1..02737c62df03 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -65,6 +65,7 @@ config ROCKCHIP_RK3066
 config ROCKCHIP_RK3128
 	bool "Support Rockchip RK3128"
 	select CPU_V7A
+	imply OF_UPSTREAM
 	imply ROCKCHIP_COMMON_BOARD
 	help
 	  The Rockchip RK3128 is a ARM-based SoC with a quad-core Cortex-A7
diff --git a/configs/evb-rk3128_defconfig b/configs/evb-rk3128_defconfig
index 90cbf55806af..eb009c7c36ae 100644
--- a/configs/evb-rk3128_defconfig
+++ b/configs/evb-rk3128_defconfig
@@ -8,7 +8,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x60100000
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_OFFSET=0x0
-CONFIG_DEFAULT_DEVICE_TREE="rk3128-evb"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3128-evb"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3128=y
 CONFIG_SYS_BOOTM_LEN=0x4000000
@@ -18,7 +18,7 @@ CONFIG_DEBUG_UART_CLOCK=24000000
 # CONFIG_DEBUG_UART_BOARD_INIT is not set
 CONFIG_DEBUG_UART=y
 CONFIG_FIT=y
-CONFIG_DEFAULT_FDT_FILE="rk3128-evb.dtb"
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3128-evb.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_CMD_GPT=y
diff --git a/include/dt-bindings/clock/rk3128-cru.h b/include/dt-bindings/clock/rk3128-cru.h
deleted file mode 100644
index 6a47825dac5d..000000000000
--- a/include/dt-bindings/clock/rk3128-cru.h
+++ /dev/null
@@ -1,273 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (c) 2017 Rockchip Electronics Co. Ltd.
- * Author: Elaine <zhangqing@rock-chips.com>
- */
-
-#ifndef _DT_BINDINGS_CLK_ROCKCHIP_RK3128_H
-#define _DT_BINDINGS_CLK_ROCKCHIP_RK3128_H
-
-/* core clocks */
-#define PLL_APLL		1
-#define PLL_DPLL		2
-#define PLL_CPLL		3
-#define PLL_GPLL		4
-#define ARMCLK			5
-#define PLL_GPLL_DIV2		6
-#define PLL_GPLL_DIV3		7
-
-/* sclk gates (special clocks) */
-#define SCLK_SPI0		65
-#define SCLK_NANDC		67
-#define SCLK_SDMMC		68
-#define SCLK_SDIO		69
-#define SCLK_EMMC		71
-#define SCLK_UART0		77
-#define SCLK_UART1		78
-#define SCLK_UART2		79
-#define SCLK_I2S0		80
-#define SCLK_I2S1		81
-#define SCLK_SPDIF		83
-#define SCLK_TIMER0		85
-#define SCLK_TIMER1		86
-#define SCLK_TIMER2		87
-#define SCLK_TIMER3		88
-#define SCLK_TIMER4		89
-#define SCLK_TIMER5		90
-#define SCLK_SARADC		91
-#define SCLK_I2S_OUT		113
-#define SCLK_SDMMC_DRV		114
-#define SCLK_SDIO_DRV		115
-#define SCLK_EMMC_DRV		117
-#define SCLK_SDMMC_SAMPLE	118
-#define SCLK_SDIO_SAMPLE	119
-#define SCLK_EMMC_SAMPLE	121
-#define SCLK_VOP		122
-#define SCLK_MAC_SRC		124
-#define SCLK_MAC		126
-#define SCLK_MAC_REFOUT		127
-#define SCLK_MAC_REF		128
-#define SCLK_MAC_RX		129
-#define SCLK_MAC_TX		130
-#define SCLK_HEVC_CORE		134
-#define SCLK_RGA		135
-#define SCLK_CRYPTO		138
-#define SCLK_TSP		139
-#define SCLK_OTGPHY0		142
-#define SCLK_OTGPHY1		143
-#define SCLK_DDRC		144
-#define SCLK_PVTM_FUNC		145
-#define SCLK_PVTM_CORE		146
-#define SCLK_PVTM_GPU		147
-#define SCLK_MIPI_24M		148
-#define SCLK_PVTM		149
-#define SCLK_CIF_SRC		150
-#define SCLK_CIF_OUT_SRC	151
-#define SCLK_CIF_OUT		152
-#define SCLK_SFC		153
-#define SCLK_USB480M		154
-
-/* dclk gates */
-#define DCLK_VOP		190
-#define DCLK_EBC		191
-
-/* aclk gates */
-#define ACLK_VIO0		192
-#define ACLK_VIO1		193
-#define ACLK_DMAC		194
-#define ACLK_CPU		195
-#define ACLK_VEPU		196
-#define ACLK_VDPU		197
-#define ACLK_CIF		198
-#define ACLK_IEP		199
-#define ACLK_LCDC0		204
-#define ACLK_RGA		205
-#define ACLK_PERI		210
-#define ACLK_VOP		211
-#define ACLK_GMAC		212
-#define ACLK_GPU		213
-
-/* pclk gates */
-#define PCLK_SARADC		318
-#define PCLK_WDT		319
-#define PCLK_GPIO0		320
-#define PCLK_GPIO1		321
-#define PCLK_GPIO2		322
-#define PCLK_GPIO3		323
-#define PCLK_VIO_H2P		324
-#define PCLK_MIPI		325
-#define PCLK_EFUSE		326
-#define PCLK_HDMI		327
-#define PCLK_ACODEC		328
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
-#define PCLK_GMAC		367
-#define PCLK_PMU_PRE		368
-#define PCLK_SIM_CARD		369
-
-/* hclk gates */
-#define HCLK_SPDIF		440
-#define HCLK_GPS		441
-#define HCLK_USBHOST		442
-#define HCLK_I2S_8CH		443
-#define HCLK_I2S_2CH		444
-#define HCLK_VOP		452
-#define HCLK_NANDC		453
-#define HCLK_SDMMC		456
-#define HCLK_SDIO		457
-#define HCLK_EMMC		459
-#define HCLK_CPU		460
-#define HCLK_VEPU		461
-#define HCLK_VDPU		462
-#define HCLK_LCDC0		463
-#define HCLK_EBC		465
-#define HCLK_VIO		466
-#define HCLK_RGA		467
-#define HCLK_IEP		468
-#define HCLK_VIO_H2P		469
-#define HCLK_CIF		470
-#define HCLK_HOST2		473
-#define HCLK_OTG		474
-#define HCLK_TSP		475
-#define HCLK_CRYPTO		476
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
-#define SRST_STRC_SYS_A		14
-#define SRST_L2C		15
-
-#define SRST_CPUSYS_H		18
-#define SRST_AHB2APBSYS_H	19
-#define SRST_SPDIF		20
-#define SRST_INTMEM		21
-#define SRST_ROM		22
-#define SRST_PERI_NIU		23
-#define SRST_I2S_2CH		24
-#define SRST_I2S_8CH		25
-#define SRST_GPU_PVTM		26
-#define SRST_FUNC_PVTM		27
-#define SRST_CORE_PVTM		29
-#define SRST_EFUSE_P		30
-#define SRST_ACODEC_P		31
-
-#define SRST_GPIO0		32
-#define SRST_GPIO1		33
-#define SRST_GPIO2		34
-#define SRST_GPIO3		35
-#define SRST_MIPIPHY_P		36
-#define SRST_UART0		39
-#define SRST_UART1		40
-#define SRST_UART2		41
-#define SRST_I2C0		43
-#define SRST_I2C1		44
-#define SRST_I2C2		45
-#define SRST_I2C3		46
-#define SRST_SFC		47
-
-#define SRST_PWM		48
-#define SRST_DAP_PO		50
-#define SRST_DAP		51
-#define SRST_DAP_SYS		52
-#define SRST_CRYPTO		53
-#define SRST_GRF		55
-#define SRST_GMAC		56
-#define SRST_PERIPH_SYS_A	57
-#define SRST_PERIPH_SYS_H	58
-#define SRST_PERIPH_SYS_P       59
-#define SRST_SMART_CARD		60
-#define SRST_CPU_PERI		61
-#define SRST_EMEM_PERI		62
-#define SRST_USB_PERI		63
-
-#define SRST_DMA		64
-#define SRST_GPS		67
-#define SRST_NANDC		68
-#define SRST_USBOTG0		69
-#define SRST_OTGC0		71
-#define SRST_USBOTG1		72
-#define SRST_OTGC1		74
-#define SRST_DDRMSCH		79
-
-#define SRST_SDMMC		81
-#define SRST_SDIO		82
-#define SRST_EMMC		83
-#define SRST_SPI		84
-#define SRST_WDT		86
-#define SRST_SARADC		87
-#define SRST_DDRPHY		88
-#define SRST_DDRPHY_P		89
-#define SRST_DDRCTRL		90
-#define SRST_DDRCTRL_P		91
-#define SRST_TSP		92
-#define SRST_TSP_CLKIN		93
-#define SRST_HOST0_ECHI		94
-
-#define SRST_HDMI_P		96
-#define SRST_VIO_ARBI_H		97
-#define SRST_VIO0_A		98
-#define SRST_VIO_BUS_H		99
-#define SRST_VOP_A		100
-#define SRST_VOP_H		101
-#define SRST_VOP_D		102
-#define SRST_UTMI0		103
-#define SRST_UTMI1		104
-#define SRST_USBPOR		105
-#define SRST_IEP_A		106
-#define SRST_IEP_H		107
-#define SRST_RGA_A		108
-#define SRST_RGA_H		109
-#define SRST_CIF0		110
-#define SRST_PMU		111
-
-#define SRST_VCODEC_A		112
-#define SRST_VCODEC_H		113
-#define SRST_VIO1_A		114
-#define SRST_HEVC_CORE		115
-#define SRST_VCODEC_NIU_A	116
-#define SRST_PMU_NIU_P		117
-#define SRST_LCDC0_S		119
-#define SRST_GPU		120
-#define SRST_GPU_NIU_A		122
-#define SRST_EBC_A		123
-#define SRST_EBC_H		124
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
-#define SRST_VIO_MIPI_DSI	137
-
-#endif
--
2.39.5

