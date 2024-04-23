Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167A2C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 12:42:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E8888859B;
	Tue, 23 Apr 2024 14:42:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rxg4JaX3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DDC88859C; Tue, 23 Apr 2024 14:42:23 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F964884EC
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 14:42:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2ab48c11534so978507a91.2
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 05:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713876139; x=1714480939; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gpnK8xOnxGvR3NiXeB5eGmGcvS8wrQ/kzK1gnzjOHno=;
 b=Rxg4JaX3u+eDns3KVixJs2WTABmCDdL4iONNaZl5siFwOrzFvUYvJKG7cJzkk2YXOu
 IuHMGH0onTj3BY8vvsyiaKWLjqUcZ9Ub+E1ooivRELtnKilbSxQa7rZRURmObGY9/mzg
 ITwDmpoCs//0TMFlKWJx5nVslnUEyji76KGSfQidv8ZwH5NpWC/amrhbDRKRBhOVEBRm
 +tZrF/J4Zoq7JuITYE3ADE1mANWE/C0iyAG6IKIWqc5jvBWKStTnEStprOgHTHIe7u/D
 W5TPxsLf9OJnu0Q3Sl81ZMewz75djwqYbaXlbIBwJ/P4UGixDolkUxOq3odBQcnWGDxS
 0Bzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713876139; x=1714480939;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gpnK8xOnxGvR3NiXeB5eGmGcvS8wrQ/kzK1gnzjOHno=;
 b=vM/dS9HL0p/5F2fLVcacrRwyNwDWDHSrNsQLA1XegfWnVh/+1VMghrLPdgAJB4M8D8
 7h3mQauT+JQ8OUji/AbMxdVrd0sbypgvMOaNtT+akscQHiq3L2jGB+B9lzQNYOejXVuj
 qyLauMRFf/mBQAE0zyasCQW/V7BnfSg5ZpAwWZQP2es3doGfAW17Wb5eGCfBgJNkeGCu
 iUe84+KziYLNXoutNX/JvCuZMrcPFAYsrr+R/O+iriaw+JMkZ0ATjz4+rwoKxy9ftvJ+
 VaVeF8WThL5xsdn6CJAao0I388/5J9luQcX2iYgRJ0BpyYtOubWqLZET0+dE2EN4wd5E
 dyvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRdSSeM5ZHTvurmBmoFt2/WJDjkKwUbA6UaAzYppI+gCiG1QNzSEZhdWv5RTRfdezTBcheQndV05nFI7AstIGCV/T1/A==
X-Gm-Message-State: AOJu0YxC0sRM7pUptCay2KtyMPC5wlbrePSTFd3PN1aA0pVqtab6Xcl0
 qnW27+u4LhZwyH8zmPZvJOe+URGMQskAqITJIZBcyvJK4QZKwC0M
X-Google-Smtp-Source: AGHT+IGQOFlRSa26Rr0e28hlY67ZpDsZbu4KCJDoxPV7NVOZKeWSCmYqiz9qSdMWYAHbP8kD6tar5A==
X-Received: by 2002:a05:6a20:8403:b0:1ac:fd52:c12d with SMTP id
 c3-20020a056a20840300b001acfd52c12dmr11823371pzd.4.1713876138707; 
 Tue, 23 Apr 2024 05:42:18 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:2423:8028:e153:69b8])
 by smtp.gmail.com with ESMTPSA id
 z21-20020a1709028f9500b001dda32430b3sm9929901plo.89.2024.04.23.05.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 05:42:18 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: kever.yang@rock-chips.com
Cc: otavio@ossystems.com.br, andy.yan@rock-chips.com, trini@konsulko.com,
 u-boot@lists.denx.de, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2] rockchip: rv1108: Convert to OF_UPSTREAM
Date: Tue, 23 Apr 2024 09:42:10 -0300
Message-Id: <20240423124210.95503-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Instead of using the local rv1108 devicetree copies from U-Boot,
let's convert the rv1108 boards to OF_UPSTREAM so that the upstream kernel
devicetrees can be used instead.

Tested on a rv1108-elgin-r1 board.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- Fixed typo in commit log.

 arch/arm/dts/rv1108-elgin-r1.dts |  59 ----
 arch/arm/dts/rv1108-evb.dts      |  79 -----
 arch/arm/dts/rv1108.dtsi         | 581 -------------------------------
 arch/arm/mach-rockchip/Kconfig   |   1 +
 configs/elgin-rv1108_defconfig   |   2 +-
 configs/evb-rv1108_defconfig     |   2 +-
 6 files changed, 3 insertions(+), 721 deletions(-)
 delete mode 100644 arch/arm/dts/rv1108-elgin-r1.dts
 delete mode 100644 arch/arm/dts/rv1108-evb.dts
 delete mode 100644 arch/arm/dts/rv1108.dtsi

diff --git a/arch/arm/dts/rv1108-elgin-r1.dts b/arch/arm/dts/rv1108-elgin-r1.dts
deleted file mode 100644
index 83e8b3183847..000000000000
--- a/arch/arm/dts/rv1108-elgin-r1.dts
+++ /dev/null
@@ -1,59 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2016 Rockchip Electronics Co., Ltd
- */
-
-/dts-v1/;
-
-#include "rv1108.dtsi"
-
-/ {
-	model = "Elgin RV1108 R1 board";
-	compatible = "elgin,rv1108-elgin", "rockchip,rv1108";
-
-	memory@60000000 {
-		device_type = "memory";
-		reg = <0x60000000 0x08000000>;
-	};
-
-	chosen {
-		stdout-path = "serial2:1500000n8";
-	};
-};
-
-&emmc {
-	pinctrl-names = "default";
-	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_bus8>;
-	bus-width = <8>;
-	cap-mmc-highspeed;
-	disable-wp;
-	non-removable;
-	status = "okay";
-};
-
-&u2phy {
-	status = "okay";
-
-	u2phy_otg: otg-port {
-		status = "okay";
-	};
-};
-
-&uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart2m0_xfer_pullup>;
-	status = "okay";
-};
-
-&usb20_otg {
-	status = "okay";
-};
-
-&pinctrl {
-	uart2m0 {
-		uart2m0_xfer_pullup: uart2m0-xfer-pullup {
-			rockchip,pins = <2 RK_PD2 RK_FUNC_1 &pcfg_pull_up_drv_8ma>,
-					<2 RK_PD1 RK_FUNC_1 &pcfg_pull_up_drv_8ma>;
-		};
-	};
-};
diff --git a/arch/arm/dts/rv1108-evb.dts b/arch/arm/dts/rv1108-evb.dts
deleted file mode 100644
index c91776bc106e..000000000000
--- a/arch/arm/dts/rv1108-evb.dts
+++ /dev/null
@@ -1,79 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2016 Rockchip Electronics Co., Ltd
- */
-
-/dts-v1/;
-
-#include "rv1108.dtsi"
-
-/ {
-	model = "Rockchip RV1108 Evaluation board";
-	compatible = "rockchip,rv1108-evb", "rockchip,rv1108";
-
-	memory@60000000 {
-		device_type = "memory";
-		reg = <0x60000000 0x08000000>;
-	};
-
-	chosen {
-		stdout-path = "serial2:1500000n8";
-	};
-
-	vcc5v0_otg: vcc5v0-otg-drv {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		regulator-name = "vcc5v0_otg";
-		gpio = <&gpio0 RK_PB0 GPIO_ACTIVE_HIGH>;
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-	};
-};
-
-&gmac {
-	status = "okay";
-	clock_in_out = <0>;
-	snps,reset-active-low;
-	snps,reset-delays-us = <0 10000 1000000>;
-	snps,reset-gpio = <&gpio1 RK_PC1 GPIO_ACTIVE_LOW>;
-};
-
-&saradc {
-	status = "okay";
-};
-
-&sfc {
-	status = "okay";
-	flash@0 {
-		compatible = "gd25q256","jedec,spi-nor";
-		reg = <0>;
-		spi-tx-bus-width = <1>;
-		spi-rx-bus-width = <1>;
-		spi-max-frequency = <96000000>;
-	};
-};
-
-&uart0 {
-	status = "okay";
-};
-
-&uart1 {
-	status = "okay";
-};
-
-&uart2 {
-	status = "okay";
-};
-
-&usb20_otg {
-	vbus-supply = <&vcc5v0_otg>;
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
diff --git a/arch/arm/dts/rv1108.dtsi b/arch/arm/dts/rv1108.dtsi
deleted file mode 100644
index 215d88522587..000000000000
--- a/arch/arm/dts/rv1108.dtsi
+++ /dev/null
@@ -1,581 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2016 Rockchip Electronics Co., Ltd
- */
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/clock/rv1108-cru.h>
-#include <dt-bindings/pinctrl/rockchip.h>
-/ {
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	compatible = "rockchip,rv1108";
-
-	interrupt-parent = <&gic>;
-
-	aliases {
-		serial0 = &uart0;
-		serial1 = &uart1;
-		serial2 = &uart2;
-		spi0	= &sfc;
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu0: cpu@f00 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a7";
-			reg = <0xf00>;
-		};
-	};
-
-	arm-pmu {
-		compatible = "arm,cortex-a7-pmu";
-		interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
-	};
-
-	timer {
-		compatible = "arm,armv7-timer";
-		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>,
-			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;
-		clock-frequency = <24000000>;
-	};
-
-	xin24m: oscillator {
-		compatible = "fixed-clock";
-		clock-frequency = <24000000>;
-		clock-output-names = "xin24m";
-		#clock-cells = <0>;
-	};
-
-	amba {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		pdma: pdma@102a0000 {
-			compatible = "arm,pl330", "arm,primecell";
-			reg = <0x102a0000 0x4000>;
-			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
-			#dma-cells = <1>;
-			arm,pl330-broken-no-flushp;
-			clocks = <&cru ACLK_DMAC>;
-			clock-names = "apb_pclk";
-		};
-	};
-
-	bus_intmem@10080000 {
-		compatible = "mmio-sram";
-		reg = <0x10080000 0x2000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0x10080000 0x2000>;
-	};
-
-	uart2: serial@10210000 {
-		compatible = "rockchip,rv1108-uart", "snps,dw-apb-uart";
-		reg = <0x10210000 0x100>;
-		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
-		clock-frequency = <24000000>;
-		clocks = <&cru SCLK_UART2>, <&cru PCLK_UART2>;
-		clock-names = "baudclk", "apb_pclk";
-		pinctrl-names = "default";
-		pinctrl-0 = <&uart2m0_xfer>;
-		status = "disabled";
-	};
-
-	uart1: serial@10220000 {
-		compatible = "rockchip,rv1108-uart", "snps,dw-apb-uart";
-		reg = <0x10220000 0x100>;
-		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
-		clock-frequency = <24000000>;
-		clocks = <&cru SCLK_UART1>, <&cru PCLK_UART1>;
-		clock-names = "baudclk", "apb_pclk";
-		pinctrl-names = "default";
-		pinctrl-0 = <&uart1_xfer>;
-		status = "disabled";
-	};
-
-	uart0: serial@10230000 {
-		compatible = "rockchip,rv1108-uart", "snps,dw-apb-uart";
-		reg = <0x10230000 0x100>;
-		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
-		clock-frequency = <24000000>;
-		clocks = <&cru SCLK_UART0>, <&cru PCLK_UART0>;
-		clock-names = "baudclk", "apb_pclk";
-		pinctrl-names = "default";
-		pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
-		status = "disabled";
-	};
-
-	grf: syscon@10300000 {
-		compatible = "rockchip,rv1108-grf", "syscon", "simple-mfd";
-		reg = <0x10300000 0x1000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		u2phy: usb2-phy@100 {
-			compatible = "rockchip,rv1108-usb2phy";
-			reg = <0x100 0x0c>;
-			clocks = <&cru SCLK_USBPHY>;
-			clock-names = "phyclk";
-			#clock-cells = <0>;
-			clock-output-names = "usbphy";
-			rockchip,usbgrf = <&usbgrf>;
-			status = "disabled";
-
-			u2phy_otg: otg-port {
-				interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names = "otg-mux";
-				#phy-cells = <0>;
-				status = "disabled";
-			};
-
-			u2phy_host: host-port {
-				interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names = "linestate";
-				#phy-cells = <0>;
-				status = "disabled";
-			};
-		};
-	};
-
-	saradc: saradc@1038c000 {
-		compatible = "rockchip,rv1108-saradc", "rockchip,rk3399-saradc";
-		reg = <0x1038c000 0x100>;
-		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
-		#io-channel-cells = <1>;
-		clock-frequency = <1000000>;
-		clocks = <&cru SCLK_SARADC>, <&cru PCLK_SARADC>;
-		clock-names = "saradc", "apb_pclk";
-		status = "disabled";
-	};
-
-	pmugrf: syscon@20060000 {
-		compatible = "rockchip,rv1108-pmugrf", "syscon";
-		reg = <0x20060000 0x1000>;
-	};
-
-	usbgrf: syscon@202a0000 {
-		compatible = "rockchip,rv1108-usbgrf", "syscon";
-		reg = <0x202a0000 0x1000>;
-	};
-
-	cru: clock-controller@20200000 {
-		compatible = "rockchip,rv1108-cru";
-		reg = <0x20200000 0x1000>;
-		rockchip,grf = <&grf>;
-		#clock-cells = <1>;
-		#reset-cells = <1>;
-	};
-
-	emmc: dwmmc@30110000 {
-		compatible = "rockchip,rv1108-dw-mshc", "rockchip,rk3288-dw-mshc";
-		clock-freq-min-max = <400000 150000000>;
-		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
-			 <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
-		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
-		fifo-depth = <0x100>;
-		interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
-		reg = <0x30110000 0x4000>;
-		status = "disabled";
-	};
-
-	sdio: dwmmc@30120000 {
-		compatible = "rockchip,rv1108-dw-mshc", "rockchip,rk3288-dw-mshc";
-		clock-freq-min-max = <400000 150000000>;
-		clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>,
-			 <&cru SCLK_SDIO_DRV>, <&cru SCLK_SDIO_SAMPLE>;
-		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
-		fifo-depth = <0x100>;
-		interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-		reg = <0x30120000 0x4000>;
-		status = "disabled";
-	};
-
-	sdmmc: dwmmc@30130000 {
-		compatible = "rockchip,rv1108-dw-mshc", "rockchip,rk3288-dw-mshc";
-		clock-freq-min-max = <400000 100000000>;
-		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
-			 <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
-		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
-		fifo-depth = <0x100>;
-		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-		reg = <0x30130000 0x4000>;
-		status = "disabled";
-	};
-
-	usb_host_ehci: usb@30140000 {
-		compatible = "generic-ehci";
-		reg = <0x30140000 0x20000>;
-		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
-		status = "disabled";
-	};
-
-	usb_host_ohci: usb@30160000 {
-		compatible = "generic-ohci";
-		reg = <0x30160000 0x20000>;
-		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
-		status = "disabled";
-	};
-
-	usb20_otg: usb@30180000 {
-		compatible = "rockchip,rv1108-usb", "rockchip,rk3066-usb",
-			     "snps,dwc2";
-		reg = <0x30180000 0x40000>;
-		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cru HCLK_OTG>;
-		clock-names = "otg";
-		dr_mode = "otg";
-		g-np-tx-fifo-size = <16>;
-		g-rx-fifo-size = <280>;
-		g-tx-fifo-size = <256 128 128 64 32 16>;
-		g-use-dma;
-		phys = <&u2phy_otg>;
-		phy-names = "usb2-phy";
-		status = "disabled";
-	};
-
-	sfc: sfc@301c0000 {
-		compatible = "rockchip,sfc";
-		reg = <0x301c0000 0x200>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cru SCLK_SFC>, <&cru HCLK_SFC>;
-		clock-names = "clk_sfc", "hclk_sfc";
-		pinctrl-0 = <&sfc_pins>;
-		pinctrl-names = "default";
-		status = "disabled";
-        };
-
-	gmac: ethernet@30200000 {
-		compatible = "rockchip,rv1108-gmac";
-		reg = <0x30200000 0x10000>;
-		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "macirq";
-		rockchip,grf = <&grf>;
-		clocks = <&cru SCLK_MAC>,
-			<&cru SCLK_MAC_RX>, <&cru SCLK_MAC_TX>,
-			<&cru SCLK_MACREF>, <&cru SCLK_MACREF_OUT>,
-			<&cru ACLK_GMAC>, <&cru PCLK_GMAC>;
-                clock-names = "stmmaceth",
-                        "mac_clk_rx", "mac_clk_tx",
-                        "clk_mac_ref", "clk_mac_refout",
-                        "aclk_mac", "pclk_mac";
-		pinctrl-names = "default";
-		pinctrl-0 = <&rmii_pins>;
-		phy-mode = "rmii";
-		max-speed = <100>;
-		status = "disabled";
-	};
-
-	gic: interrupt-controller@32010000 {
-		compatible = "arm,gic-400";
-		interrupt-controller;
-		#interrupt-cells = <3>;
-		#address-cells = <0>;
-
-		reg = <0x32011000 0x1000>,
-		      <0x32012000 0x1000>,
-		      <0x32014000 0x2000>,
-		      <0x32016000 0x2000>;
-		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;
-	};
-
-	pinctrl: pinctrl {
-		compatible = "rockchip,rv1108-pinctrl";
-		rockchip,grf = <&grf>;
-		rockchip,pmu = <&pmugrf>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		gpio0: gpio0@20030000 {
-			compatible = "rockchip,gpio-bank";
-			reg = <0x20030000 0x100>;
-			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&xin24m>;
-
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-
-		gpio1: gpio1@10310000 {
-			compatible = "rockchip,gpio-bank";
-			reg = <0x10310000 0x100>;
-			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&xin24m>;
-
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-
-		gpio2: gpio2@10320000 {
-			compatible = "rockchip,gpio-bank";
-			reg = <0x10320000 0x100>;
-			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&xin24m>;
-
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-
-		gpio3: gpio3@10330000 {
-			compatible = "rockchip,gpio-bank";
-			reg = <0x10330000 0x100>;
-			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&xin24m>;
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
-		pcfg_pull_none_drv_8ma: pcfg-pull-none-drv-8ma {
-			drive-strength = <8>;
-		};
-
-		pcfg_pull_none_drv_12ma: pcfg-pull-none-drv-12ma {
-			drive-strength = <12>;
-		};
-
-		pcfg_pull_up_drv_8ma: pcfg-pull-up-drv-8ma {
-			bias-pull-up;
-			drive-strength = <8>;
-		};
-
-		pcfg_pull_none_drv_4ma: pcfg-pull-none-drv-4ma {
-			drive-strength = <4>;
-		};
-
-		pcfg_pull_up_drv_4ma: pcfg-pull-up-drv-4ma {
-			bias-pull-up;
-			drive-strength = <4>;
-		};
-
-		pcfg_output_high: pcfg-output-high {
-			output-high;
-		};
-
-		pcfg_output_low: pcfg-output-low {
-			output-low;
-		};
-
-		pcfg_input_high: pcfg-input-high {
-			bias-pull-up;
-			input-enable;
-		};
-
-		gmac {
-			rmii_pins: rmii-pins {
-				rockchip,pins = <1 RK_PC5 RK_FUNC_2 &pcfg_pull_none>,
-						<1 RK_PC3 RK_FUNC_2 &pcfg_pull_none>,
-						<1 RK_PC4 RK_FUNC_2 &pcfg_pull_none>,
-						<1 RK_PB2 RK_FUNC_3 &pcfg_pull_none_drv_12ma>,
-						<1 RK_PB3 RK_FUNC_3 &pcfg_pull_none_drv_12ma>,
-						<1 RK_PB4 RK_FUNC_3 &pcfg_pull_none_drv_12ma>,
-						<1 RK_PB5 RK_FUNC_3 &pcfg_pull_none>,
-						<1 RK_PB6 RK_FUNC_3 &pcfg_pull_none>,
-						<1 RK_PB7 RK_FUNC_3 &pcfg_pull_none>,
-						<1 RK_PC2 RK_FUNC_3 &pcfg_pull_none>;
-			};
-		};
-
-		i2c1 {
-			i2c1_xfer: i2c1-xfer {
-				rockchip,pins = <2 RK_PD3 RK_FUNC_1 &pcfg_pull_up>,
-						<2 RK_PD4 RK_FUNC_1 &pcfg_pull_up>;
-			};
-		};
-
-		i2c2m1 {
-			i2c2m1_xfer: i2c2m1-xfer {
-				rockchip,pins = <0 RK_PC2 RK_FUNC_2 &pcfg_pull_none>,
-						<0 RK_PC6 RK_FUNC_3 &pcfg_pull_none>;
-			};
-
-			i2c2m1_gpio: i2c2m1-gpio {
-				rockchip,pins = <0 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>,
-						<0 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
-			};
-		};
-
-		i2c2m05v {
-			i2c2m05v_xfer: i2c2m05v-xfer {
-				rockchip,pins = <1 RK_PD5 RK_FUNC_2 &pcfg_pull_none>,
-						<1 RK_PD4 RK_FUNC_2 &pcfg_pull_none>;
-			};
-
-			i2c2m05v_gpio: i2c2m05v-gpio {
-				rockchip,pins = <1 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>,
-						<1 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
-			};
-		};
-
-		i2c3 {
-			i2c3_xfer: i2c3-xfer {
-				rockchip,pins = <0 RK_PB6 RK_FUNC_1 &pcfg_pull_none>,
-						<0 RK_PC4 RK_FUNC_2 &pcfg_pull_none>;
-			};
-		};
-
-		sfc {
-			sfc_pins: sfc-pins {
-				rockchip,pins = <2 RK_PA3 RK_FUNC_3 &pcfg_pull_none>,
-						<2 RK_PA2 RK_FUNC_3 &pcfg_pull_none>,
-						<2 RK_PA1 RK_FUNC_3 &pcfg_pull_none>,
-						<2 RK_PA0 RK_FUNC_3 &pcfg_pull_none>,
-						<2 RK_PB7 RK_FUNC_2 &pcfg_pull_none>,
-						<2 RK_PB4 RK_FUNC_3 &pcfg_pull_none>;
-			};
-		};
-
-		emmc {
-			emmc_clk: emmc-clk {
-				rockchip,pins = <2 RK_PB6 RK_FUNC_1 &pcfg_pull_none_drv_8ma>;
-			};
-
-			emmc_cmd: emmc-cmd {
-				rockchip,pins = <2 RK_PB4 RK_FUNC_2 &pcfg_pull_up_drv_8ma>;
-			};
-
-			emmc_pwren: emmc-pwren {
-				rockchip,pins = <2 RK_PC2 RK_FUNC_2 &pcfg_pull_none>;
-			};
-
-			emmc_bus1: emmc-bus1 {
-				rockchip,pins = <2 RK_PA0 RK_FUNC_2 &pcfg_pull_up_drv_8ma>;
-			};
-
-			emmc_bus8: emmc-bus8 {
-				rockchip,pins = <2 RK_PA0 RK_FUNC_2 &pcfg_pull_up_drv_8ma>,
-						<2 RK_PA1 RK_FUNC_2 &pcfg_pull_up_drv_8ma>,
-						<2 RK_PA2 RK_FUNC_2 &pcfg_pull_up_drv_8ma>,
-						<2 RK_PA3 RK_FUNC_2 &pcfg_pull_up_drv_8ma>,
-						<2 RK_PA4 RK_FUNC_2 &pcfg_pull_up_drv_8ma>,
-						<2 RK_PA5 RK_FUNC_2 &pcfg_pull_up_drv_8ma>,
-						<2 RK_PA6 RK_FUNC_2 &pcfg_pull_up_drv_8ma>,
-						<2 RK_PA7 RK_FUNC_2 &pcfg_pull_up_drv_8ma>;
-			};
-		};
-
-		sdmmc {
-			sdmmc_clk: sdmmc-clk {
-				rockchip,pins = <3 RK_PC4 RK_FUNC_1 &pcfg_pull_none_drv_4ma>;
-			};
-
-			sdmmc_cmd: sdmmc-cmd {
-				rockchip,pins = <3 RK_PC5 RK_FUNC_1 &pcfg_pull_up_drv_4ma>;
-			};
-
-			sdmmc_cd: sdmmc-cd {
-				rockchip,pins = <0 RK_PA1 RK_FUNC_1 &pcfg_pull_up_drv_4ma>;
-			};
-
-			sdmmc_bus1: sdmmc-bus1 {
-				rockchip,pins = <3 RK_PC3 RK_FUNC_1 &pcfg_pull_up_drv_4ma>;
-			};
-
-			sdmmc_bus4: sdmmc-bus4 {
-				rockchip,pins = <3 RK_PC3 RK_FUNC_1 &pcfg_pull_up_drv_4ma>,
-						<3 RK_PC2 RK_FUNC_1 &pcfg_pull_up_drv_4ma>,
-						<3 RK_PC1 RK_FUNC_1 &pcfg_pull_up_drv_4ma>,
-						<3 RK_PC0 RK_FUNC_1 &pcfg_pull_up_drv_4ma>;
-			};
-		};
-
-		uart0 {
-			uart0_xfer: uart0-xfer {
-				rockchip,pins = <3 RK_PA6 RK_FUNC_1 &pcfg_pull_up>,
-						<3 RK_PA5 RK_FUNC_1 &pcfg_pull_none>;
-			};
-
-			uart0_cts: uart0-cts {
-				rockchip,pins = <3 RK_PA4 RK_FUNC_1 &pcfg_pull_none>;
-			};
-
-			uart0_rts: uart0-rts {
-				rockchip,pins = <3 RK_PA3 RK_FUNC_1 &pcfg_pull_none>;
-			};
-
-			uart0_rts_gpio: uart0-rts-gpio {
-				rockchip,pins = <3 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
-			};
-		};
-
-		uart1 {
-			uart1_xfer: uart1-xfer {
-				rockchip,pins = <1 RK_PD3 RK_FUNC_1 &pcfg_pull_up>,
-						<1 RK_PD2 RK_FUNC_1 &pcfg_pull_none>;
-			};
-
-			uart1_cts: uart1-cts {
-				rockchip,pins = <1 RK_PD0 RK_FUNC_1 &pcfg_pull_none>;
-			};
-
-			uart01rts: uart1-rts {
-				rockchip,pins = <1 RK_PD1 RK_FUNC_1 &pcfg_pull_none>;
-			};
-		};
-
-		uart2m0 {
-			uart2m0_xfer: uart2m0-xfer {
-				rockchip,pins = <2 RK_PD2 RK_FUNC_1 &pcfg_pull_up>,
-						<2 RK_PD1 RK_FUNC_1 &pcfg_pull_none>;
-			};
-		};
-
-		uart2m1 {
-			uart2m1_xfer: uart2m1-xfer {
-				rockchip,pins = <3 RK_PC3 RK_FUNC_2 &pcfg_pull_up>,
-						<3 RK_PC2 RK_FUNC_2 &pcfg_pull_none>;
-			};
-		};
-
-		uart2_5v {
-			uart2_5v_cts: uart2_5v-cts {
-				rockchip,pins = <1 RK_PD4 RK_FUNC_1 &pcfg_pull_none>;
-			};
-
-			uart2_5v_rts: uart2_5v-rts {
-				rockchip,pins = <1 RK_PD5 RK_FUNC_1 &pcfg_pull_none>;
-			};
-		};
-	};
-};
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 4f22d9bde9f9..b4a10be00249 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -343,6 +343,7 @@ config ROCKCHIP_RV1108
 	bool "Support Rockchip RV1108"
 	select CPU_V7A
 	imply ROCKCHIP_COMMON_BOARD
+	imply OF_UPSTREAM
 	help
 	  The Rockchip RV1108 is a ARM-based SoC with a single-core Cortex-A7
 	  and a DSP.
diff --git a/configs/elgin-rv1108_defconfig b/configs/elgin-rv1108_defconfig
index 446c9c9b7aca..140429f84d29 100644
--- a/configs/elgin-rv1108_defconfig
+++ b/configs/elgin-rv1108_defconfig
@@ -6,7 +6,7 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x60100000
 CONFIG_ENV_OFFSET=0x3F8000
-CONFIG_DEFAULT_DEVICE_TREE="rv1108-elgin-r1"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rv1108-elgin-r1"
 CONFIG_ROCKCHIP_RV1108=y
 CONFIG_ROCKCHIP_BOOT_MODE_REG=0
 CONFIG_TARGET_ELGIN_RV1108=y
diff --git a/configs/evb-rv1108_defconfig b/configs/evb-rv1108_defconfig
index 1c62149a9b57..afc0ce4a0929 100644
--- a/configs/evb-rv1108_defconfig
+++ b/configs/evb-rv1108_defconfig
@@ -5,7 +5,7 @@ CONFIG_TEXT_BASE=0x60000000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x60100000
-CONFIG_DEFAULT_DEVICE_TREE="rv1108-evb"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rv1108-evb"
 CONFIG_ROCKCHIP_RV1108=y
 CONFIG_DEBUG_UART_BASE=0x10210000
 CONFIG_DEBUG_UART_CLOCK=24000000
-- 
2.34.1

