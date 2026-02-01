Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA38E7C6F6
	for <u-boot@archiver.kernel.org>; Sun,  1 Feb 2026 00:46:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FFF383C61;
	Sun,  1 Feb 2026 01:45:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MrGdtLG/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3226A83C23; Sun,  1 Feb 2026 01:45:28 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE89C83BE1
 for <u-boot@lists.denx.de>; Sun,  1 Feb 2026 01:45:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-794c2db2ee5so3452387b3.2
 for <u-boot@lists.denx.de>; Sat, 31 Jan 2026 16:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769906724; x=1770511524; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7JLKAE2Cmv8iP8ltHBabjHUPMpbAEJbVkdDHdyG6III=;
 b=MrGdtLG/CH8LSQeS/H5L0P1dvxPCV/c1P2lJB3bgtCiE6BJ7NijUBhPcFiaWv/PVBQ
 bmv2V3czNC6sC7/szwkm+GMKKxBHkOAtamMmBdnJW15Oj4w/fm5zzNueRvlArBdXK2eY
 6NV9ddayH6TosCpNd3OcD8YCEwftGi0sgZMw9k3pTxticQ1Y1a5wTXehfzBgO3iYYjX6
 RIFfNx5+i/QLdZXjm5kzMIjZJh461OcalnPq7ZT4enUtZ8sfIWXP8zoACYVQEpDPv8Tl
 HT5iM6d8ER5x4XYTeXapPK8nO1uEcJbF3Lz1mTS4qUUfkgejFU2e1f/wm5Kx0l+iYFlQ
 w+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769906724; x=1770511524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7JLKAE2Cmv8iP8ltHBabjHUPMpbAEJbVkdDHdyG6III=;
 b=d1+4zip4VNJ7HZamOyK0YWmtsKkzHKilRko+JSMf1E8jXf6a2dlovemSsFsjsK5nYE
 XIJoZj0m3RN8vtVpEi7Hpt+kzVmT6l3ctu/4R4GGfF61+luOYf5nW+6DsJl1Z4gcU6/1
 aQDL/wjKZyObZkkKKtWNl3dMrlZLJeSgd9rDxouQ19GugrXzi+pLtWxXQVkCNWX2nHxi
 X5KxjiZ05dKOfQ2xnmqF2a2plicn1suL7MW0hGpbERnbzjN0S9nFmesiYuLa6jyoOxux
 6kSPQY+YUJ+IrJ2Hr5IVacMIRDQqvl7/REbCy8ZyqxwFPewQkAItnkQdG0bsijwIbmco
 qsog==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlCcFP6SCo4ccIJrxn9tqoWfdGbnIzANRtcMhrBxIvd0Ilhnc1ejesoxccXtFdVN+Z3+fiP/g=@lists.denx.de
X-Gm-Message-State: AOJu0YwVxPb+FaS0owbv+iU8citlxPhqlww8xyKDZYIUinfsSK2BbCOt
 Lm8EqHoBgjaSfAWnvp1y4ye3u7A3cZ1YBMBhsgT/q3gYAR6pnmOUmgue5a6dtQ==
X-Gm-Gg: AZuq6aK5Ybw16p9lEMF3PfauHpCTrYa2/qIIIcpXwfPmpfAr7kXLiNOrjdlnG/f3qQ1
 3BHLPmulw0Hov/bTHKb6NHekSamcy8LZopI/p8HDTEO9IENsvx7tlyX5jAFsWXCKPAjqiRhgF2Q
 iTOLrtJEty8AduY5xoxEFEFUHdXhjBjGW99okEsUcy/ddxMIsdIkR+P0jJnU6OlUQRsbrNZDFrH
 p4tqF97Hy0x9M75656YhDjA3bhn5YB/3JyxJq8aHRBlMbnkvSsfZ3K1H4wNY/k6fh2vGOxMqbDW
 YnpPHqdf4AKUI+KAr/D5vTv1izSSUenJjdZGPyDXENT6mKLoGvc1D1qajPC4EVdK8bIqmahJilQ
 kQxJPwd0z+pWfn6D9GsgU6yy7s8BAMfNNOlwHuy62Og5xaWZ8fEMAvWZh42kNQZx9O21/9LoCOz
 pRsHtIC3nErrlRd9NFdfvLcuXCpyaqoggS1sY=
X-Received: by 2002:a05:690c:a91:b0:794:795d:4732 with SMTP id
 00721157ae682-7949dfb672fmr62090167b3.40.1769906724560; 
 Sat, 31 Jan 2026 16:45:24 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:419e:8d46:1302:65da])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-794828ad9cfsm52105097b3.29.2026.01.31.16.45.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Jan 2026 16:45:24 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: kever.yang@rock-chips.com
Cc: trini@konsulko.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH 6/7] ARM: dts: Add RV1103 Omega4 support
Date: Sat, 31 Jan 2026 21:44:55 -0300
Message-Id: <20260201004456.763107-7-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260201004456.763107-1-festevam@gmail.com>
References: <20260201004456.763107-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@nabladev.com>

Add minimal devicetree support for the Onion RV1103 Omega4 board.

These devicetrees are currently not upstream in Linux. They allow U-Boot to
boot the board and progress with development, independent of the Linux RV1103
upstream process.

Once the RV1103 devicetrees are merged into the upstream Linux kernel,
he OF_UPSTREAM mechanism can be enabled to use the kernel-provided devicetree.

This patch enables the Onion's Omega4 board to be supported in U-Boot
without blocking other upstreaming efforts.

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
 arch/arm/dts/rv1103-omega4-u-boot.dtsi |  11 +
 arch/arm/dts/rv1103-omega4.dts         |  40 ++++
 arch/arm/dts/rv1103-u-boot.dtsi        |   4 +
 arch/arm/dts/rv1103.dtsi               | 267 +++++++++++++++++++++++++
 4 files changed, 322 insertions(+)
 create mode 100644 arch/arm/dts/rv1103-omega4-u-boot.dtsi
 create mode 100644 arch/arm/dts/rv1103-omega4.dts
 create mode 100644 arch/arm/dts/rv1103-u-boot.dtsi
 create mode 100644 arch/arm/dts/rv1103.dtsi

diff --git a/arch/arm/dts/rv1103-omega4-u-boot.dtsi b/arch/arm/dts/rv1103-omega4-u-boot.dtsi
new file mode 100644
index 000000000000..d838206af4af
--- /dev/null
+++ b/arch/arm/dts/rv1103-omega4-u-boot.dtsi
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0+
+// (C) Copyright 2024 Rockchip Electronics Co., Ltd
+
+#include "rockchip-u-boot.dtsi"
+
+/ {
+	chosen {
+		stdout-path = &uart0;
+		u-boot,spl-boot-order = &spi_nand;
+	};
+};
diff --git a/arch/arm/dts/rv1103-omega4.dts b/arch/arm/dts/rv1103-omega4.dts
new file mode 100644
index 000000000000..ebedf9843934
--- /dev/null
+++ b/arch/arm/dts/rv1103-omega4.dts
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier:     GPL-2.0+
+// (C) Copyright 2024 Rockchip Electronics Co., Ltd
+
+/dts-v1/;
+#include "rv1103.dtsi"
+
+/ {
+	model = "Onion RV1103 Omega4 board";
+	compatible = "onion,rv1103-omega4", "rockchip,rv1103";
+
+	chosen {
+		stdout-path = &uart0;
+	};
+};
+
+&sfc {
+	bootph-all;
+	status = "okay";
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+	spi_nand: flash@0 {
+		compatible = "spi-nand";
+		reg = <0>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <4>;
+		spi-max-frequency = <24000000>;
+		bootph-all;
+	};
+};
+
+&uart0 {
+	bootph-pre-ram;
+	status = "okay";
+};
+
+&wdt {
+	bootph-pre-ram;
+	status = "okay";
+};
diff --git a/arch/arm/dts/rv1103-u-boot.dtsi b/arch/arm/dts/rv1103-u-boot.dtsi
new file mode 100644
index 000000000000..3b77dd31152f
--- /dev/null
+++ b/arch/arm/dts/rv1103-u-boot.dtsi
@@ -0,0 +1,4 @@
+// SPDX-License-Identifier:     GPL-2.0+
+// (C) Copyright 2024 Rockchip Electronics Co., Ltd
+
+#include "rockchip-u-boot.dtsi"
diff --git a/arch/arm/dts/rv1103.dtsi b/arch/arm/dts/rv1103.dtsi
new file mode 100644
index 000000000000..8ac7658231b1
--- /dev/null
+++ b/arch/arm/dts/rv1103.dtsi
@@ -0,0 +1,267 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2024 Rockchip Electronics Co., Ltd.
+ */
+
+#include <dt-bindings/clock/rv1103-cru.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/pinctrl/rockchip.h>
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	compatible = "rockchip,rv1103";
+
+	interrupt-parent = <&gic>;
+
+	aliases {
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+		gpio2 = &gpio2;
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+	};
+
+	arm-pmu {
+		compatible = "arm,cortex-a7-pmu";
+		interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x0>;
+			clocks = <&cru ARMCLK>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;
+		clock-frequency = <24000000>;
+	};
+
+	cru: clock-controller@20000000 {
+		compatible = "rockchip,rv1103-cru";
+		reg = <0x20000000 0x81000>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+		assigned-clocks = <&cru PLL_GPLL>, <&cru CLK_GPLL_DIV12>;
+		assigned-clock-rates = <1188000000>, <100000000>;
+		bootph-all;
+	};
+
+	grf: syscon@20100000 {
+		compatible = "rockchip,rv1103-grf", "syscon", "simple-mfd";
+		reg = <0x20100000 0x61000>;
+		bootph-all;
+	};
+
+	ioc: syscon@20170000 {
+		compatible = "rockchip,rv1103-ioc", "syscon";
+		reg = <0x20170000 0x60000>;
+		bootph-all;
+	};
+
+	gic: interrupt-controller@20411000 {
+		compatible = "arm,gic-400";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		#address-cells = <0>;
+
+		reg = <0x20411000 0x1000>,
+		      <0x20412000 0x2000>,
+		      <0x20414000 0x2000>,
+		      <0x20416000 0x2000>;
+		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;
+	};
+
+	uart0: serial@20540000 {
+		compatible = "rockchip,rv1103-uart", "snps,dw-apb-uart";
+		reg = <0x20540000 0x100>;
+		interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		clock-frequency = <24000000>;
+		clocks = <&cru SCLK_UART0>, <&cru PCLK_UART0>;
+		clock-names = "baudclk", "apb_pclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&uart0m0_xfer_pins>;
+		status = "disabled";
+	};
+
+	uart1: serial@20870000 {
+		compatible = "rockchip,rv1103-uart", "snps,dw-apb-uart";
+		reg = <0x20870000 0x100>;
+		interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		clock-frequency = <24000000>;
+		clocks = <&cru SCLK_UART1>, <&cru PCLK_UART1>;
+		clock-names = "baudclk", "apb_pclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&uart1m0_xfer_pins>;
+		status = "disabled";
+	};
+
+	uart2: serial@20880000 {
+		compatible = "rockchip,rv1103-uart", "snps,dw-apb-uart";
+		reg = <0x20880000 0x100>;
+		interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		clock-frequency = <24000000>;
+		clocks = <&cru SCLK_UART2>, <&cru PCLK_UART2>;
+		clock-names = "baudclk", "apb_pclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&uart2m0_xfer_pins>;
+		status = "disabled";
+	};
+
+	wdt: watchdog@208d0000 {
+		compatible = "rockchip,rv1103-wdt", "snps,dw-wdt";
+		reg = <0x208d0000 0x100>;
+		clocks = <&cru TCLK_WDT_NS>, <&cru PCLK_WDT_NS>;
+		clock-names = "tclk", "pclk";
+		interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	sfc: spi@20d40000 {
+		compatible = "rockchip,sfc";
+		reg = <0x20d40000 0x4000>;
+		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_SFC_2X>, <&cru HCLK_SFC>;
+		clock-names = "clk_sfc", "hclk_sfc";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	system_sram: sram@210f6000 {
+		compatible = "mmio-sram";
+		reg = <0x210f6000 0x8000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x210f6000 0x8000>;
+	};
+
+	pinctrl: pinctrl {
+		compatible = "rockchip,rv1103-pinctrl";
+		rockchip,grf = <&ioc>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		bootph-all;
+
+		gpio0: gpio@20520000 {
+			compatible = "rockchip,gpio-bank";
+			reg = <0x20520000 0x200>;
+			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru PCLK_PMU_GPIO0>, <&cru DBCLK_PMU_GPIO0>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl 0 0 32>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			bootph-pre-ram;
+		};
+
+		gpio1: gpio@20d80000 {
+			compatible = "rockchip,gpio-bank";
+			reg = <0x20d80000 0x200>;
+			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru PCLK_GPIO1>, <&cru DBCLK_GPIO1>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl 0 32 32>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			bootph-pre-ram;
+		};
+
+		gpio2: gpio@20840000 {
+			compatible = "rockchip,gpio-bank";
+			reg = <0x20840000 0x200>;
+			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru PCLK_GPIO2>, <&cru DBCLK_GPIO2>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl 0 64 32>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			bootph-pre-ram;
+		};
+
+		pcfg_pull_none: pcfg-pull-none {
+			bias-disable;
+		};
+
+		pcfg_pull_up: pcfg-pull-up {
+			bias-pull-up;
+		};
+
+		spi0 {
+			spi0m0_clk_pins: spi0m0-clk-pins {
+				rockchip,pins =
+					/* spi0_clk_m0 */
+					<2 RK_PB0 2 &pcfg_pull_none>,
+					/* spi0_miso_m0 */
+					<2 RK_PB3 2 &pcfg_pull_none>,
+					/* spi0_mosi_m0 */
+					<2 RK_PB1 2 &pcfg_pull_none>;
+			};
+
+			spi0m0_cs0_pins: spi0m0-cs0-pins {
+				rockchip,pins =
+					/* spi0_cs0n_m0 */
+					<2 RK_PB2 2 &pcfg_pull_none>;
+			};
+
+			spi0m0_cs1_pins: spi0m0-cs1-pins {
+				rockchip,pins =
+					/* spi0_cs1n_m0 */
+					<2 RK_PA7 2 &pcfg_pull_none>;
+			};
+		};
+
+		uart0 {
+			uart0m0_xfer_pins: uart0m0-xfer-pins {
+				rockchip,pins =
+					/* uart0_rx_m0 */
+					<0 RK_PA6 1 &pcfg_pull_up>,
+					/* uart0_tx_m0 */
+					<0 RK_PA5 1 &pcfg_pull_up>;
+			};
+		};
+
+		uart1 {
+			uart1m0_xfer_pins: uart1m0-xfer-pins {
+				rockchip,pins =
+					/* uart1_rx_m0 */
+					<0 RK_PB2 2 &pcfg_pull_up>,
+					/* uart1_tx_m0 */
+					<0 RK_PB3 2 &pcfg_pull_up>;
+			};
+		};
+
+		uart2 {
+			uart2m0_xfer_pins: uart2m0-xfer-pins {
+				rockchip,pins =
+					/* uart2_rx_m0 */
+					<0 RK_PB1 2 &pcfg_pull_up>,
+					/* uart2_tx_m0 */
+					<0 RK_PB0 2 &pcfg_pull_up>;
+			};
+		};
+	};
+};
-- 
2.34.1

