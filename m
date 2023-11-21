Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906F7C61D92
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 19:46:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71A908761B;
	Tue, 21 Nov 2023 20:46:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QnZUMKXc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DE4987642; Tue, 21 Nov 2023 18:10:20 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1612D8766C
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 18:09:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40b2a8575d9so5869365e9.0
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 09:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700586589; x=1701191389; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MFSN8065T0E0lrMICsx4slarUQIGA8v+1pinTvjw1Po=;
 b=QnZUMKXcW5rPoLp8ONgiZeqG2uOS1ed1WZu6T6iht2qUWOUms1hRZFWYuag1zDM0RL
 w/AcVA0IfLYFVyASflzB2eaFuXe49g2LqJ2LxwezyPoZ7ANA8b30tuJupIf4Ivo5RUql
 QCJrYEErDarKYlw2kE1HMzI8OU9BJGhqu0o/GdOay5XBZ1XfiOiONS2i09wq6/RcV9Gt
 VEwzLE8Mjlg7Gi4HW+NnJDTTZnDEHP0+i5mtpSl+MerJt8m+dLFzluB270d4Bo77jJC8
 NrPF0jTtfHtivINOeRUqr6FXn8JmfoSNaBBQYJ9TUVBJ+daVX1W/rVT3DPzHkJk3TVaU
 P/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700586589; x=1701191389;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MFSN8065T0E0lrMICsx4slarUQIGA8v+1pinTvjw1Po=;
 b=YfssRQovOLXF/YkzidLFDA1CjtbKTn5oItBNPM6JOZuGM8Hbo3AdjTWwPRZBbq7LrR
 Mcc/QI4K3mMShNJPpXho915YXBB82KETVNusopmQkPKUu6DKO1G6KM8Sn3Ov8qLsQ5oG
 hGbdLw1yAUnMOEg5oDxi4r+5qhXTwobYOLgZ2GvF8Hbd65FULg2LMyyXCMdI6hmBDbpN
 L6K+SrNL4+fEhZZOtQ2yxreM0qjGKY2i5OzXo1kqNZTp7PXbtDyZmfXkyHexGicv5ZfQ
 hrtvJtYqrgyN1xAcMDkia6MMCVEDWPBDRmbYQCxC9+BTEYf4zb593wZc94Oekw3J3J0u
 dp+w==
X-Gm-Message-State: AOJu0YyXqibGzodD2vuNyLKSLk9ob/vGL6fknPErSSaOaDU3rrOlNTsC
 h2LUHVD4i3+7Ip+zC2uZZS0GMQ==
X-Google-Smtp-Source: AGHT+IF+GH2xtNiXoxBng6vWf/vh1YK0c/qyBx8t85f88sxMANGO8dp6eUmfTlK/OUwxQcn/o58UCQ==
X-Received: by 2002:a05:600c:300b:b0:404:6ed9:98d1 with SMTP id
 j11-20020a05600c300b00b004046ed998d1mr8194575wmh.41.1700586588801; 
 Tue, 21 Nov 2023 09:09:48 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 1-20020a05600c230100b003fefb94ccc9sm17345812wmo.11.2023.11.21.09.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 09:09:47 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 21 Nov 2023 17:09:42 +0000
Subject: [PATCH 19/21] dts: msm8996: import DT from Linux
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231121-b4-qcom-common-target-v1-19-9492198e0c15@linaro.org>
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
In-Reply-To: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=136518;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=7DLh4wv+A7OyDYEExpwwR9vSDbWJdziq+P4aMZ/bHFQ=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSYJ+55MZK3lL9Zv+V9NU//x/WaO457S+Skt3/LLuENu
 NG1SPtkRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZhIRS0jw4JngkLP35R8cPzK
 mrWHP85APMW7tiImLOnwrIIJtpZ1zxkZVppM2rxmvadkbvI7lymH2E3XfHjQ8nPKyUrGly9D9wt
 ZvQEA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Mailman-Approved-At: Tue, 21 Nov 2023 20:46:01 +0100
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

Drop in msm8996.dtsi, pm8994.dtsi, and associated headers. Adjust
dragonboard820c.dts to work properly, and fix the clock driver.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/dts/dragonboard820c-uboot.dtsi            |   32 -
 arch/arm/dts/dragonboard820c.dts                   |  130 +-
 arch/arm/dts/msm8996.dtsi                          | 3959 ++++++++++++++++++++
 arch/arm/dts/pm8994.dtsi                           |  152 +
 drivers/clk/qcom/clock-apq8096.c                   |    5 +-
 include/dt-bindings/clock/qcom,gcc-msm8996.h       |  360 ++
 include/dt-bindings/clock/qcom,mmcc-msm8996.h      |  295 ++
 .../dt-bindings/interconnect/qcom,msm8996-cbf.h    |   12 +
 include/dt-bindings/interconnect/qcom,msm8996.h    |  163 +
 9 files changed, 4960 insertions(+), 148 deletions(-)

diff --git a/arch/arm/dts/dragonboard820c-uboot.dtsi b/arch/arm/dts/dragonboard820c-uboot.dtsi
deleted file mode 100644
index d93c7c1fbdee..000000000000
--- a/arch/arm/dts/dragonboard820c-uboot.dtsi
+++ /dev/null
@@ -1,32 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * U-Boot addition to handle Dragonboard 820c pins
- *
- * (C) Copyright 2017 Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
- */
-
-/ {
-	smem {
-		bootph-all;
-	};
-
-	soc {
-		bootph-all;
-
-		pinctrl@1010000 {
-			bootph-all;
-
-			uart {
-				bootph-all;
-			};
-		};
-
-		clock-controller@300000 {
-			bootph-all;
-		};
-
-		serial@75b0000 {
-			bootph-all;
-		};
-	};
-};
diff --git a/arch/arm/dts/dragonboard820c.dts b/arch/arm/dts/dragonboard820c.dts
index 86b7f83d36d6..067380f2a4fe 100644
--- a/arch/arm/dts/dragonboard820c.dts
+++ b/arch/arm/dts/dragonboard820c.dts
@@ -7,11 +7,12 @@
 
 /dts-v1/;
 
-#include "skeleton64.dtsi"
+#include "msm8996.dtsi"
+#include "pm8994.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. DB820c";
-	compatible = "arrow,apq8096-db820c", "qcom,apq8096-sbc";
+	compatible = "qcom,apq8096-db820c", "qcom,apq8096";
 	#address-cells = <2>;
 	#size-cells = <2>;
 
@@ -23,22 +24,11 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0 0x80000000 0 0xc0000000>;
 	};
 
-	reserved-memory {
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		smem_mem: smem_region@86300000 {
-			reg = <0x0 0x86300000 0x0 0x200000>;
-			no-map;
-		};
-	};
-
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
@@ -48,105 +38,17 @@
 		compatible = "qcom,smem";
 		memory-region = <&smem_mem>;
 	};
-
-	soc: soc {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0 0 0xffffffff>;
-		compatible = "simple-bus";
-
-		gcc: clock-controller@300000 {
-			compatible = "qcom,gcc-msm8996";
-			#clock-cells = <1>;
-			#reset-cells = <1>;
-			#power-domain-cells = <1>;
-			reg = <0x300000 0x90000>;
-		};
-
-		pinctrl: pinctrl@1010000 {
-			compatible = "qcom,msm8996-pinctrl";
-			reg = <0x1010000 0x400000>;
-
-			blsp8_uart: uart {
-				function = "blsp_uart8";
-				pins = "GPIO_4", "GPIO_5";
-				drive-strength = <8>;
-				bias-disable;
-			};
-		};
-
-		blsp2_uart2: serial@75b0000 {
-			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
-			reg = <0x75b0000 0x1000>;
-			clocks = <&gcc 4>;
-			clock-names = "core";
-			pinctrl-names = "uart";
-			pinctrl-0 = <&blsp8_uart>;
-		};
-
-		sdhc2: sdhci@74a4900 {
-			compatible = "qcom,sdhci-msm-v4";
-			reg = <0x74a4900 0x314>, <0x74a4000 0x800>;
-			index = <0x0>;
-			bus-width = <4>;
-			clock = <&gcc 0>;
-			clock-frequency = <200000000>;
-		 };
-
-		spmi_bus: spmi@400f000 {
-			compatible = "qcom,spmi-pmic-arb";
-			reg = <0x0400f000 0x1000>,
-			      <0x04400000 0x800000>,
-			      <0x04c00000 0x800000>,
-			      <0x05800000 0x200000>,
-			      <0x0400a000 0x002100>;
-			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
-			#address-cells = <0x1>;
-			#size-cells = <0x1>;
-
-			pmic0: pm8994@0 {
-				compatible = "qcom,spmi-pmic";
-				reg = <0x0 0x1>;
-				#address-cells = <0x1>;
-				#size-cells = <0x1>;
-
-				pm8994_pon: pon@800 {
-					compatible = "qcom,pm8916-pon";
-					reg = <0x800 0x100>;
-					mode-bootloader = <0x2>;
-					mode-recovery = <0x1>;
-
-					pwrkey {
-						compatible = "qcom,pm8941-pwrkey";
-						debounce = <15625>;
-						bias-pull-up;
-					};
-
-					pm8994_resin: resin {
-						compatible = "qcom,pm8941-resin";
-						debounce = <15625>;
-						bias-pull-up;
-					};
-				};
-
-				pm8994_gpios: pm8994_gpios@c000 {
-					compatible = "qcom,pm8994-gpio";
-					reg = <0xc000 0x400>;
-					gpio-controller;
-					gpio-ranges = <&pm8994_gpios 0 0 22>;
-					#gpio-cells = <2>;
-				};
-			};
-
-			pmic1: pm8994@1 {
-				compatible = "qcom,spmi-pmic";
-				reg = <0x1 0x1>;
-				#address-cells = <0x1>;
-				#size-cells = <0x1>;
-			};
-		};
-	};
-
 };
 
-#include "dragonboard820c-uboot.dtsi"
+&blsp2_uart2 {
+	status = "okay";
+};
+
+&pm8994_resin {
+	status = "okay";
+};
+
+&sdhc1 {
+	status = "okay";
+	clock-frequency = <100000000>;
+};
diff --git a/arch/arm/dts/msm8996.dtsi b/arch/arm/dts/msm8996.dtsi
new file mode 100644
index 000000000000..ec23b5c5e024
--- /dev/null
+++ b/arch/arm/dts/msm8996.dtsi
@@ -0,0 +1,3959 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2014-2015, The Linux Foundation. All rights reserved.
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/qcom,gcc-msm8996.h>
+#include <dt-bindings/clock/qcom,mmcc-msm8996.h>
+#include <dt-bindings/clock/qcom,rpmcc.h>
+#include <dt-bindings/interconnect/qcom,msm8996.h>
+#include <dt-bindings/interconnect/qcom,msm8996-cbf.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/soc/qcom,apr.h>
+#include <dt-bindings/thermal/thermal.h>
+
+/ {
+	interrupt-parent = <&intc>;
+
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	chosen { };
+
+	clocks {
+		xo_board: xo-board {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <19200000>;
+			clock-output-names = "xo_board";
+		};
+
+		sleep_clk: sleep-clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32764>;
+			clock-output-names = "sleep_clk";
+		};
+	};
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		CPU0: cpu@0 {
+			device_type = "cpu";
+			compatible = "qcom,kryo";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP_0>;
+			capacity-dmips-mhz = <1024>;
+			clocks = <&kryocc 0>;
+			interconnects = <&cbf MASTER_CBF_M4M &cbf SLAVE_CBF_M4M>;
+			operating-points-v2 = <&cluster0_opp>;
+			#cooling-cells = <2>;
+			next-level-cache = <&L2_0>;
+			L2_0: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
+			};
+		};
+
+		CPU1: cpu@1 {
+			device_type = "cpu";
+			compatible = "qcom,kryo";
+			reg = <0x0 0x1>;
+			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP_0>;
+			capacity-dmips-mhz = <1024>;
+			clocks = <&kryocc 0>;
+			interconnects = <&cbf MASTER_CBF_M4M &cbf SLAVE_CBF_M4M>;
+			operating-points-v2 = <&cluster0_opp>;
+			#cooling-cells = <2>;
+			next-level-cache = <&L2_0>;
+		};
+
+		CPU2: cpu@100 {
+			device_type = "cpu";
+			compatible = "qcom,kryo";
+			reg = <0x0 0x100>;
+			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP_0>;
+			capacity-dmips-mhz = <1024>;
+			clocks = <&kryocc 1>;
+			interconnects = <&cbf MASTER_CBF_M4M &cbf SLAVE_CBF_M4M>;
+			operating-points-v2 = <&cluster1_opp>;
+			#cooling-cells = <2>;
+			next-level-cache = <&L2_1>;
+			L2_1: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
+			};
+		};
+
+		CPU3: cpu@101 {
+			device_type = "cpu";
+			compatible = "qcom,kryo";
+			reg = <0x0 0x101>;
+			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP_0>;
+			capacity-dmips-mhz = <1024>;
+			clocks = <&kryocc 1>;
+			interconnects = <&cbf MASTER_CBF_M4M &cbf SLAVE_CBF_M4M>;
+			operating-points-v2 = <&cluster1_opp>;
+			#cooling-cells = <2>;
+			next-level-cache = <&L2_1>;
+		};
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&CPU0>;
+				};
+
+				core1 {
+					cpu = <&CPU1>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&CPU2>;
+				};
+
+				core1 {
+					cpu = <&CPU3>;
+				};
+			};
+		};
+
+		idle-states {
+			entry-method = "psci";
+
+			CPU_SLEEP_0: cpu-sleep-0 {
+				compatible = "arm,idle-state";
+				idle-state-name = "standalone-power-collapse";
+				arm,psci-suspend-param = <0x00000004>;
+				entry-latency-us = <130>;
+				exit-latency-us = <80>;
+				min-residency-us = <300>;
+			};
+		};
+	};
+
+	cluster0_opp: opp-table-cluster0 {
+		compatible = "operating-points-v2-kryo-cpu";
+		nvmem-cells = <&speedbin_efuse>;
+		opp-shared;
+
+		/* Nominal fmax for now */
+		opp-307200000 {
+			opp-hz = /bits/ 64 <307200000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <307200>;
+		};
+		opp-422400000 {
+			opp-hz = /bits/ 64 <422400000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <307200>;
+		};
+		opp-480000000 {
+			opp-hz = /bits/ 64 <480000000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <307200>;
+		};
+		opp-556800000 {
+			opp-hz = /bits/ 64 <556800000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <307200>;
+		};
+		opp-652800000 {
+			opp-hz = /bits/ 64 <652800000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <384000>;
+		};
+		opp-729600000 {
+			opp-hz = /bits/ 64 <729600000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <460800>;
+		};
+		opp-844800000 {
+			opp-hz = /bits/ 64 <844800000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <537600>;
+		};
+		opp-960000000 {
+			opp-hz = /bits/ 64 <960000000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <672000>;
+		};
+		opp-1036800000 {
+			opp-hz = /bits/ 64 <1036800000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <672000>;
+		};
+		opp-1113600000 {
+			opp-hz = /bits/ 64 <1113600000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <825600>;
+		};
+		opp-1190400000 {
+			opp-hz = /bits/ 64 <1190400000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <825600>;
+		};
+		opp-1228800000 {
+			opp-hz = /bits/ 64 <1228800000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <902400>;
+		};
+		opp-1324800000 {
+			opp-hz = /bits/ 64 <1324800000>;
+			opp-supported-hw = <0xd>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1056000>;
+		};
+		opp-1363200000 {
+			opp-hz = /bits/ 64 <1363200000>;
+			opp-supported-hw = <0x2>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1132800>;
+		};
+		opp-1401600000 {
+			opp-hz = /bits/ 64 <1401600000>;
+			opp-supported-hw = <0xd>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1132800>;
+		};
+		opp-1478400000 {
+			opp-hz = /bits/ 64 <1478400000>;
+			opp-supported-hw = <0x9>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1190400>;
+		};
+		opp-1497600000 {
+			opp-hz = /bits/ 64 <1497600000>;
+			opp-supported-hw = <0x04>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1305600>;
+		};
+		opp-1593600000 {
+			opp-hz = /bits/ 64 <1593600000>;
+			opp-supported-hw = <0x9>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1382400>;
+		};
+	};
+
+	cluster1_opp: opp-table-cluster1 {
+		compatible = "operating-points-v2-kryo-cpu";
+		nvmem-cells = <&speedbin_efuse>;
+		opp-shared;
+
+		/* Nominal fmax for now */
+		opp-307200000 {
+			opp-hz = /bits/ 64 <307200000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <307200>;
+		};
+		opp-403200000 {
+			opp-hz = /bits/ 64 <403200000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <307200>;
+		};
+		opp-480000000 {
+			opp-hz = /bits/ 64 <480000000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <307200>;
+		};
+		opp-556800000 {
+			opp-hz = /bits/ 64 <556800000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <307200>;
+		};
+		opp-652800000 {
+			opp-hz = /bits/ 64 <652800000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <307200>;
+		};
+		opp-729600000 {
+			opp-hz = /bits/ 64 <729600000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <307200>;
+		};
+		opp-806400000 {
+			opp-hz = /bits/ 64 <806400000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <384000>;
+		};
+		opp-883200000 {
+			opp-hz = /bits/ 64 <883200000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <460800>;
+		};
+		opp-940800000 {
+			opp-hz = /bits/ 64 <940800000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <537600>;
+		};
+		opp-1036800000 {
+			opp-hz = /bits/ 64 <1036800000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <595200>;
+		};
+		opp-1113600000 {
+			opp-hz = /bits/ 64 <1113600000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <672000>;
+		};
+		opp-1190400000 {
+			opp-hz = /bits/ 64 <1190400000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <672000>;
+		};
+		opp-1248000000 {
+			opp-hz = /bits/ 64 <1248000000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <748800>;
+		};
+		opp-1324800000 {
+			opp-hz = /bits/ 64 <1324800000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <825600>;
+		};
+		opp-1401600000 {
+			opp-hz = /bits/ 64 <1401600000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <902400>;
+		};
+		opp-1478400000 {
+			opp-hz = /bits/ 64 <1478400000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <979200>;
+		};
+		opp-1555200000 {
+			opp-hz = /bits/ 64 <1555200000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1056000>;
+		};
+		opp-1632000000 {
+			opp-hz = /bits/ 64 <1632000000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1190400>;
+		};
+		opp-1708800000 {
+			opp-hz = /bits/ 64 <1708800000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1228800>;
+		};
+		opp-1785600000 {
+			opp-hz = /bits/ 64 <1785600000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1305600>;
+		};
+		opp-1804800000 {
+			opp-hz = /bits/ 64 <1804800000>;
+			opp-supported-hw = <0xe>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1305600>;
+		};
+		opp-1824000000 {
+			opp-hz = /bits/ 64 <1824000000>;
+			opp-supported-hw = <0x1>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1382400>;
+		};
+		opp-1900800000 {
+			opp-hz = /bits/ 64 <1900800000>;
+			opp-supported-hw = <0x4>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1305600>;
+		};
+		opp-1920000000 {
+			opp-hz = /bits/ 64 <1920000000>;
+			opp-supported-hw = <0x1>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1459200>;
+		};
+		opp-1996800000 {
+			opp-hz = /bits/ 64 <1996800000>;
+			opp-supported-hw = <0x1>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1593600>;
+		};
+		opp-2073600000 {
+			opp-hz = /bits/ 64 <2073600000>;
+			opp-supported-hw = <0x1>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1593600>;
+		};
+		opp-2150400000 {
+			opp-hz = /bits/ 64 <2150400000>;
+			opp-supported-hw = <0x1>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1593600>;
+		};
+	};
+
+	firmware {
+		scm {
+			compatible = "qcom,scm-msm8996", "qcom,scm";
+			qcom,dload-mode = <&tcsr_2 0x13000>;
+		};
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the reg */
+		reg = <0x0 0x80000000 0x0 0x0>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	rpm: remoteproc {
+		compatible = "qcom,msm8996-rpm-proc", "qcom,rpm-proc";
+
+		glink-rpm {
+			compatible = "qcom,glink-rpm";
+			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
+			qcom,rpm-msg-ram = <&rpm_msg_ram>;
+			mboxes = <&apcs_glb 0>;
+
+			rpm_requests: rpm-requests {
+				compatible = "qcom,rpm-msm8996";
+				qcom,glink-channels = "rpm_requests";
+
+				rpmcc: clock-controller {
+					compatible = "qcom,rpmcc-msm8996", "qcom,rpmcc";
+					#clock-cells = <1>;
+					clocks = <&xo_board>;
+					clock-names = "xo";
+				};
+
+				rpmpd: power-controller {
+					compatible = "qcom,msm8996-rpmpd";
+					#power-domain-cells = <1>;
+					operating-points-v2 = <&rpmpd_opp_table>;
+
+					rpmpd_opp_table: opp-table {
+						compatible = "operating-points-v2";
+
+						rpmpd_opp1: opp1 {
+							opp-level = <1>;
+						};
+
+						rpmpd_opp2: opp2 {
+							opp-level = <2>;
+						};
+
+						rpmpd_opp3: opp3 {
+							opp-level = <3>;
+						};
+
+						rpmpd_opp4: opp4 {
+							opp-level = <4>;
+						};
+
+						rpmpd_opp5: opp5 {
+							opp-level = <5>;
+						};
+
+						rpmpd_opp6: opp6 {
+							opp-level = <6>;
+						};
+					};
+				};
+			};
+		};
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		hyp_mem: memory@85800000 {
+			reg = <0x0 0x85800000 0x0 0x600000>;
+			no-map;
+		};
+
+		xbl_mem: memory@85e00000 {
+			reg = <0x0 0x85e00000 0x0 0x200000>;
+			no-map;
+		};
+
+		smem_mem: smem-mem@86000000 {
+			reg = <0x0 0x86000000 0x0 0x200000>;
+			no-map;
+		};
+
+		tz_mem: memory@86200000 {
+			reg = <0x0 0x86200000 0x0 0x2600000>;
+			no-map;
+		};
+
+		rmtfs_mem: rmtfs {
+			compatible = "qcom,rmtfs-mem";
+
+			size = <0x0 0x200000>;
+			alloc-ranges = <0x0 0xa0000000 0x0 0x2000000>;
+			no-map;
+
+			qcom,client-id = <1>;
+			qcom,vmid = <15>;
+		};
+
+		mpss_mem: mpss@88800000 {
+			reg = <0x0 0x88800000 0x0 0x6200000>;
+			no-map;
+		};
+
+		adsp_mem: adsp@8ea00000 {
+			reg = <0x0 0x8ea00000 0x0 0x1b00000>;
+			no-map;
+		};
+
+		slpi_mem: slpi@90500000 {
+			reg = <0x0 0x90500000 0x0 0xa00000>;
+			no-map;
+		};
+
+		gpu_mem: gpu@90f00000 {
+			compatible = "shared-dma-pool";
+			reg = <0x0 0x90f00000 0x0 0x100000>;
+			no-map;
+		};
+
+		venus_mem: venus@91000000 {
+			reg = <0x0 0x91000000 0x0 0x500000>;
+			no-map;
+		};
+
+		mba_mem: mba@91500000 {
+			reg = <0x0 0x91500000 0x0 0x200000>;
+			no-map;
+		};
+
+		mdata_mem: mpss-metadata {
+			alloc-ranges = <0x0 0xa0000000 0x0 0x20000000>;
+			size = <0x0 0x4000>;
+			no-map;
+		};
+	};
+
+	smem {
+		compatible = "qcom,smem";
+		memory-region = <&smem_mem>;
+		hwlocks = <&tcsr_mutex 3>;
+	};
+
+	smp2p-adsp {
+		compatible = "qcom,smp2p";
+		qcom,smem = <443>, <429>;
+
+		interrupts = <0 158 IRQ_TYPE_EDGE_RISING>;
+
+		mboxes = <&apcs_glb 10>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <2>;
+
+		adsp_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		adsp_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smp2p-mpss {
+		compatible = "qcom,smp2p";
+		qcom,smem = <435>, <428>;
+
+		interrupts = <GIC_SPI 451 IRQ_TYPE_EDGE_RISING>;
+
+		mboxes = <&apcs_glb 14>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <1>;
+
+		mpss_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		mpss_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smp2p-slpi {
+		compatible = "qcom,smp2p";
+		qcom,smem = <481>, <430>;
+
+		interrupts = <GIC_SPI 178 IRQ_TYPE_EDGE_RISING>;
+
+		mboxes = <&apcs_glb 26>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <3>;
+
+		slpi_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		slpi_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	soc: soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 0 0xffffffff>;
+		compatible = "simple-bus";
+
+		pcie_phy: phy-wrapper@34000 {
+			compatible = "qcom,msm8996-qmp-pcie-phy";
+			reg = <0x00034000 0x488>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x00034000 0x4000>;
+
+			clocks = <&gcc GCC_PCIE_PHY_AUX_CLK>,
+				<&gcc GCC_PCIE_PHY_CFG_AHB_CLK>,
+				<&gcc GCC_PCIE_CLKREF_CLK>;
+			clock-names = "aux", "cfg_ahb", "ref";
+
+			resets = <&gcc GCC_PCIE_PHY_BCR>,
+				<&gcc GCC_PCIE_PHY_COM_BCR>,
+				<&gcc GCC_PCIE_PHY_COM_NOCSR_BCR>;
+			reset-names = "phy", "common", "cfg";
+
+			status = "disabled";
+
+			pciephy_0: phy@1000 {
+				reg = <0x1000 0x130>,
+				      <0x1200 0x200>,
+				      <0x1400 0x1dc>;
+
+				clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
+				clock-names = "pipe0";
+				resets = <&gcc GCC_PCIE_0_PHY_BCR>;
+				reset-names = "lane0";
+
+				#clock-cells = <0>;
+				clock-output-names = "pcie_0_pipe_clk_src";
+
+				#phy-cells = <0>;
+			};
+
+			pciephy_1: phy@2000 {
+				reg = <0x2000 0x130>,
+				      <0x2200 0x200>,
+				      <0x2400 0x1dc>;
+
+				clocks = <&gcc GCC_PCIE_1_PIPE_CLK>;
+				clock-names = "pipe1";
+				resets = <&gcc GCC_PCIE_1_PHY_BCR>;
+				reset-names = "lane1";
+
+				#clock-cells = <0>;
+				clock-output-names = "pcie_1_pipe_clk_src";
+
+				#phy-cells = <0>;
+			};
+
+			pciephy_2: phy@3000 {
+				reg = <0x3000 0x130>,
+				      <0x3200 0x200>,
+				      <0x3400 0x1dc>;
+
+				clocks = <&gcc GCC_PCIE_2_PIPE_CLK>;
+				clock-names = "pipe2";
+				resets = <&gcc GCC_PCIE_2_PHY_BCR>;
+				reset-names = "lane2";
+
+				#clock-cells = <0>;
+				clock-output-names = "pcie_2_pipe_clk_src";
+
+				#phy-cells = <0>;
+			};
+		};
+
+		rpm_msg_ram: sram@68000 {
+			compatible = "qcom,rpm-msg-ram";
+			reg = <0x00068000 0x6000>;
+		};
+
+		qfprom@74000 {
+			compatible = "qcom,msm8996-qfprom", "qcom,qfprom";
+			reg = <0x00074000 0x8ff>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			qusb2p_hstx_trim: hstx_trim@24e {
+				reg = <0x24e 0x2>;
+				bits = <5 4>;
+			};
+
+			qusb2s_hstx_trim: hstx_trim@24f {
+				reg = <0x24f 0x1>;
+				bits = <1 4>;
+			};
+
+			speedbin_efuse: speedbin@133 {
+				reg = <0x133 0x1>;
+				bits = <5 3>;
+			};
+		};
+
+		rng: rng@83000 {
+			compatible = "qcom,prng-ee";
+			reg = <0x00083000 0x1000>;
+			clocks = <&gcc GCC_PRNG_AHB_CLK>;
+			clock-names = "core";
+		};
+
+		gcc: clock-controller@300000 {
+			compatible = "qcom,gcc-msm8996";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+			reg = <0x00300000 0x90000>;
+
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
+				 <&rpmcc RPM_SMD_LN_BB_CLK>,
+				 <&sleep_clk>,
+				 <&pciephy_0>,
+				 <&pciephy_1>,
+				 <&pciephy_2>,
+				 <&ssusb_phy_0>,
+				 <&ufsphy_lane 0>,
+				 <&ufsphy_lane 1>,
+				 <&ufsphy_lane 2>;
+			clock-names = "cxo",
+				      "cxo2",
+				      "sleep_clk",
+				      "pcie_0_pipe_clk_src",
+				      "pcie_1_pipe_clk_src",
+				      "pcie_2_pipe_clk_src",
+				      "usb3_phy_pipe_clk_src",
+				      "ufs_rx_symbol_0_clk_src",
+				      "ufs_rx_symbol_1_clk_src",
+				      "ufs_tx_symbol_0_clk_src";
+		};
+
+		bimc: interconnect@408000 {
+			compatible = "qcom,msm8996-bimc";
+			reg = <0x00408000 0x5a000>;
+			#interconnect-cells = <1>;
+			clock-names = "bus", "bus_a";
+			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
+				 <&rpmcc RPM_SMD_BIMC_A_CLK>;
+		};
+
+		tsens0: thermal-sensor@4a9000 {
+			compatible = "qcom,msm8996-tsens", "qcom,tsens-v2";
+			reg = <0x004a9000 0x1000>, /* TM */
+			      <0x004a8000 0x1000>; /* SROT */
+			#qcom,sensors = <13>;
+			interrupts = <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow", "critical";
+			#thermal-sensor-cells = <1>;
+		};
+
+		tsens1: thermal-sensor@4ad000 {
+			compatible = "qcom,msm8996-tsens", "qcom,tsens-v2";
+			reg = <0x004ad000 0x1000>, /* TM */
+			      <0x004ac000 0x1000>; /* SROT */
+			#qcom,sensors = <8>;
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 430 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow", "critical";
+			#thermal-sensor-cells = <1>;
+		};
+
+		cryptobam: dma-controller@644000 {
+			compatible = "qcom,bam-v1.7.0";
+			reg = <0x00644000 0x24000>;
+			interrupts = <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_CE1_CLK>;
+			clock-names = "bam_clk";
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			qcom,controlled-remotely;
+		};
+
+		crypto: crypto@67a000 {
+			compatible = "qcom,crypto-v5.4";
+			reg = <0x0067a000 0x6000>;
+			clocks = <&gcc GCC_CE1_AHB_CLK>,
+				 <&gcc GCC_CE1_AXI_CLK>,
+				 <&gcc GCC_CE1_CLK>;
+			clock-names = "iface", "bus", "core";
+			dmas = <&cryptobam 6>, <&cryptobam 7>;
+			dma-names = "rx", "tx";
+		};
+
+		cnoc: interconnect@500000 {
+			compatible = "qcom,msm8996-cnoc";
+			reg = <0x00500000 0x1000>;
+			#interconnect-cells = <1>;
+			clock-names = "bus", "bus_a";
+			clocks = <&rpmcc RPM_SMD_CNOC_CLK>,
+				 <&rpmcc RPM_SMD_CNOC_A_CLK>;
+		};
+
+		snoc: interconnect@524000 {
+			compatible = "qcom,msm8996-snoc";
+			reg = <0x00524000 0x1c000>;
+			#interconnect-cells = <1>;
+			clock-names = "bus", "bus_a";
+			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
+				 <&rpmcc RPM_SMD_SNOC_A_CLK>;
+		};
+
+		a0noc: interconnect@543000 {
+			compatible = "qcom,msm8996-a0noc";
+			reg = <0x00543000 0x6000>;
+			#interconnect-cells = <1>;
+			clock-names = "aggre0_snoc_axi",
+				      "aggre0_cnoc_ahb",
+				      "aggre0_noc_mpu_cfg";
+			clocks = <&gcc GCC_AGGRE0_SNOC_AXI_CLK>,
+				 <&gcc GCC_AGGRE0_CNOC_AHB_CLK>,
+				 <&gcc GCC_AGGRE0_NOC_MPU_CFG_AHB_CLK>;
+			power-domains = <&gcc AGGRE0_NOC_GDSC>;
+		};
+
+		a1noc: interconnect@562000 {
+			compatible = "qcom,msm8996-a1noc";
+			reg = <0x00562000 0x5000>;
+			#interconnect-cells = <1>;
+			clock-names = "bus", "bus_a";
+			clocks = <&rpmcc RPM_SMD_AGGR1_NOC_CLK>,
+				 <&rpmcc RPM_SMD_AGGR1_NOC_A_CLK>;
+		};
+
+		a2noc: interconnect@583000 {
+			compatible = "qcom,msm8996-a2noc";
+			reg = <0x00583000 0x7000>;
+			#interconnect-cells = <1>;
+			clock-names = "bus", "bus_a", "aggre2_ufs_axi", "ufs_axi";
+			clocks = <&rpmcc RPM_SMD_AGGR2_NOC_CLK>,
+				 <&rpmcc RPM_SMD_AGGR2_NOC_A_CLK>,
+				 <&gcc GCC_AGGRE2_UFS_AXI_CLK>,
+				 <&gcc GCC_UFS_AXI_CLK>;
+		};
+
+		mnoc: interconnect@5a4000 {
+			compatible = "qcom,msm8996-mnoc";
+			reg = <0x005a4000 0x1c000>;
+			#interconnect-cells = <1>;
+			clock-names = "bus", "bus_a", "iface";
+			clocks = <&rpmcc RPM_SMD_MMAXI_CLK>,
+				 <&rpmcc RPM_SMD_MMAXI_A_CLK>,
+				 <&mmcc AHB_CLK_SRC>;
+		};
+
+		pnoc: interconnect@5c0000 {
+			compatible = "qcom,msm8996-pnoc";
+			reg = <0x005c0000 0x3000>;
+			#interconnect-cells = <1>;
+			clock-names = "bus", "bus_a";
+			clocks = <&rpmcc RPM_SMD_PCNOC_CLK>,
+				 <&rpmcc RPM_SMD_PCNOC_A_CLK>;
+		};
+
+		tcsr_mutex: hwlock@740000 {
+			compatible = "qcom,tcsr-mutex";
+			reg = <0x00740000 0x20000>;
+			#hwlock-cells = <1>;
+		};
+
+		tcsr_1: syscon@760000 {
+			compatible = "qcom,tcsr-msm8996", "syscon";
+			reg = <0x00760000 0x20000>;
+		};
+
+		tcsr_2: syscon@7a0000 {
+			compatible = "qcom,tcsr-msm8996", "syscon";
+			reg = <0x007a0000 0x18000>;
+		};
+
+		mmcc: clock-controller@8c0000 {
+			compatible = "qcom,mmcc-msm8996";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+			reg = <0x008c0000 0x40000>;
+			clocks = <&xo_board>,
+				 <&gcc GCC_MMSS_NOC_CFG_AHB_CLK>,
+				 <&gcc GPLL0>,
+				 <&dsi0_phy 1>,
+				 <&dsi0_phy 0>,
+				 <&dsi1_phy 1>,
+				 <&dsi1_phy 0>,
+				 <&hdmi_phy>;
+			clock-names = "xo",
+				      "gcc_mmss_noc_cfg_ahb_clk",
+				      "gpll0",
+				      "dsi0pll",
+				      "dsi0pllbyte",
+				      "dsi1pll",
+				      "dsi1pllbyte",
+				      "hdmipll";
+			assigned-clocks = <&mmcc MMPLL9_PLL>,
+					  <&mmcc MMPLL1_PLL>,
+					  <&mmcc MMPLL3_PLL>,
+					  <&mmcc MMPLL4_PLL>,
+					  <&mmcc MMPLL5_PLL>;
+			assigned-clock-rates = <624000000>,
+					       <810000000>,
+					       <980000000>,
+					       <960000000>,
+					       <825000000>;
+		};
+
+		mdss: display-subsystem@900000 {
+			compatible = "qcom,mdss";
+
+			reg = <0x00900000 0x1000>,
+			      <0x009b0000 0x1040>,
+			      <0x009b8000 0x1040>;
+			reg-names = "mdss_phys",
+				    "vbif_phys",
+				    "vbif_nrt_phys";
+
+			power-domains = <&mmcc MDSS_GDSC>;
+			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			clocks = <&mmcc MDSS_AHB_CLK>,
+				 <&mmcc MDSS_MDP_CLK>;
+			clock-names = "iface", "core";
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			status = "disabled";
+
+			mdp: display-controller@901000 {
+				compatible = "qcom,msm8996-mdp5", "qcom,mdp5";
+				reg = <0x00901000 0x90000>;
+				reg-names = "mdp_phys";
+
+				interrupt-parent = <&mdss>;
+				interrupts = <0>;
+
+				clocks = <&mmcc MDSS_AHB_CLK>,
+					 <&mmcc MDSS_AXI_CLK>,
+					 <&mmcc MDSS_MDP_CLK>,
+					 <&mmcc SMMU_MDP_AXI_CLK>,
+					 <&mmcc MDSS_VSYNC_CLK>;
+				clock-names = "iface",
+					      "bus",
+					      "core",
+					      "iommu",
+					      "vsync";
+
+				iommus = <&mdp_smmu 0>;
+
+				assigned-clocks = <&mmcc MDSS_MDP_CLK>,
+					 <&mmcc MDSS_VSYNC_CLK>;
+				assigned-clock-rates = <300000000>,
+					 <19200000>;
+
+				interconnects = <&mnoc MASTER_MDP_PORT0 &bimc SLAVE_EBI_CH0>,
+						<&mnoc MASTER_MDP_PORT1 &bimc SLAVE_EBI_CH0>,
+						<&mnoc MASTER_ROTATOR &bimc SLAVE_EBI_CH0>;
+				interconnect-names = "mdp0-mem", "mdp1-mem", "rotator-mem";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						mdp5_intf3_out: endpoint {
+							remote-endpoint = <&hdmi_in>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+						mdp5_intf1_out: endpoint {
+							remote-endpoint = <&dsi0_in>;
+						};
+					};
+
+					port@2 {
+						reg = <2>;
+						mdp5_intf2_out: endpoint {
+							remote-endpoint = <&dsi1_in>;
+						};
+					};
+				};
+			};
+
+			dsi0: dsi@994000 {
+				compatible = "qcom,msm8996-dsi-ctrl",
+					     "qcom,mdss-dsi-ctrl";
+				reg = <0x00994000 0x400>;
+				reg-names = "dsi_ctrl";
+
+				interrupt-parent = <&mdss>;
+				interrupts = <4>;
+
+				clocks = <&mmcc MDSS_MDP_CLK>,
+					 <&mmcc MDSS_BYTE0_CLK>,
+					 <&mmcc MDSS_AHB_CLK>,
+					 <&mmcc MDSS_AXI_CLK>,
+					 <&mmcc MMSS_MISC_AHB_CLK>,
+					 <&mmcc MDSS_PCLK0_CLK>,
+					 <&mmcc MDSS_ESC0_CLK>;
+				clock-names = "mdp_core",
+					      "byte",
+					      "iface",
+					      "bus",
+					      "core_mmss",
+					      "pixel",
+					      "core";
+				assigned-clocks = <&mmcc BYTE0_CLK_SRC>, <&mmcc PCLK0_CLK_SRC>;
+				assigned-clock-parents = <&dsi0_phy 0>, <&dsi0_phy 1>;
+
+				phys = <&dsi0_phy>;
+				status = "disabled";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						dsi0_in: endpoint {
+							remote-endpoint = <&mdp5_intf1_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+						dsi0_out: endpoint {
+						};
+					};
+				};
+			};
+
+			dsi0_phy: phy@994400 {
+				compatible = "qcom,dsi-phy-14nm";
+				reg = <0x00994400 0x100>,
+				      <0x00994500 0x300>,
+				      <0x00994800 0x188>;
+				reg-names = "dsi_phy",
+					    "dsi_phy_lane",
+					    "dsi_pll";
+
+				#clock-cells = <1>;
+				#phy-cells = <0>;
+
+				clocks = <&mmcc MDSS_AHB_CLK>, <&rpmcc RPM_SMD_XO_CLK_SRC>;
+				clock-names = "iface", "ref";
+				status = "disabled";
+			};
+
+			dsi1: dsi@996000 {
+				compatible = "qcom,msm8996-dsi-ctrl",
+					     "qcom,mdss-dsi-ctrl";
+				reg = <0x00996000 0x400>;
+				reg-names = "dsi_ctrl";
+
+				interrupt-parent = <&mdss>;
+				interrupts = <4>;
+
+				clocks = <&mmcc MDSS_MDP_CLK>,
+					 <&mmcc MDSS_BYTE1_CLK>,
+					 <&mmcc MDSS_AHB_CLK>,
+					 <&mmcc MDSS_AXI_CLK>,
+					 <&mmcc MMSS_MISC_AHB_CLK>,
+					 <&mmcc MDSS_PCLK1_CLK>,
+					 <&mmcc MDSS_ESC1_CLK>;
+				clock-names = "mdp_core",
+					      "byte",
+					      "iface",
+					      "bus",
+					      "core_mmss",
+					      "pixel",
+					      "core";
+				assigned-clocks = <&mmcc BYTE1_CLK_SRC>, <&mmcc PCLK1_CLK_SRC>;
+				assigned-clock-parents = <&dsi1_phy 0>, <&dsi1_phy 1>;
+
+				phys = <&dsi1_phy>;
+				status = "disabled";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						dsi1_in: endpoint {
+							remote-endpoint = <&mdp5_intf2_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+						dsi1_out: endpoint {
+						};
+					};
+				};
+			};
+
+			dsi1_phy: phy@996400 {
+				compatible = "qcom,dsi-phy-14nm";
+				reg = <0x00996400 0x100>,
+				      <0x00996500 0x300>,
+				      <0x00996800 0x188>;
+				reg-names = "dsi_phy",
+					    "dsi_phy_lane",
+					    "dsi_pll";
+
+				#clock-cells = <1>;
+				#phy-cells = <0>;
+
+				clocks = <&mmcc MDSS_AHB_CLK>, <&rpmcc RPM_SMD_XO_CLK_SRC>;
+				clock-names = "iface", "ref";
+				status = "disabled";
+			};
+
+			hdmi: hdmi-tx@9a0000 {
+				compatible = "qcom,hdmi-tx-8996";
+				reg =	<0x009a0000 0x50c>,
+					<0x00070000 0x6158>,
+					<0x009e0000 0xfff>;
+				reg-names = "core_physical",
+					    "qfprom_physical",
+					    "hdcp_physical";
+
+				interrupt-parent = <&mdss>;
+				interrupts = <8>;
+
+				clocks = <&mmcc MDSS_MDP_CLK>,
+					 <&mmcc MDSS_AHB_CLK>,
+					 <&mmcc MDSS_HDMI_CLK>,
+					 <&mmcc MDSS_HDMI_AHB_CLK>,
+					 <&mmcc MDSS_EXTPCLK_CLK>;
+				clock-names =
+					"mdp_core",
+					"iface",
+					"core",
+					"alt_iface",
+					"extp";
+
+				phys = <&hdmi_phy>;
+				#sound-dai-cells = <1>;
+
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						hdmi_in: endpoint {
+							remote-endpoint = <&mdp5_intf3_out>;
+						};
+					};
+				};
+			};
+
+			hdmi_phy: phy@9a0600 {
+				#phy-cells = <0>;
+				compatible = "qcom,hdmi-phy-8996";
+				reg = <0x009a0600 0x1c4>,
+				      <0x009a0a00 0x124>,
+				      <0x009a0c00 0x124>,
+				      <0x009a0e00 0x124>,
+				      <0x009a1000 0x124>,
+				      <0x009a1200 0x0c8>;
+				reg-names = "hdmi_pll",
+					    "hdmi_tx_l0",
+					    "hdmi_tx_l1",
+					    "hdmi_tx_l2",
+					    "hdmi_tx_l3",
+					    "hdmi_phy";
+
+				clocks = <&mmcc MDSS_AHB_CLK>,
+					 <&gcc GCC_HDMI_CLKREF_CLK>,
+					 <&xo_board>;
+				clock-names = "iface",
+					      "ref",
+					      "xo";
+
+				#clock-cells = <0>;
+
+				status = "disabled";
+			};
+		};
+
+		gpu: gpu@b00000 {
+			compatible = "qcom,adreno-530.2", "qcom,adreno";
+
+			reg = <0x00b00000 0x3f000>;
+			reg-names = "kgsl_3d0_reg_memory";
+
+			interrupts = <0 300 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&mmcc GPU_GX_GFX3D_CLK>,
+				<&mmcc GPU_AHB_CLK>,
+				<&mmcc GPU_GX_RBBMTIMER_CLK>,
+				<&gcc GCC_BIMC_GFX_CLK>,
+				<&gcc GCC_MMSS_BIMC_GFX_CLK>;
+
+			clock-names = "core",
+				"iface",
+				"rbbmtimer",
+				"mem",
+				"mem_iface";
+
+			interconnects = <&bimc MASTER_GRAPHICS_3D &bimc SLAVE_EBI_CH0>;
+			interconnect-names = "gfx-mem";
+
+			power-domains = <&mmcc GPU_GX_GDSC>;
+			iommus = <&adreno_smmu 0>;
+
+			nvmem-cells = <&speedbin_efuse>;
+			nvmem-cell-names = "speed_bin";
+
+			operating-points-v2 = <&gpu_opp_table>;
+
+			status = "disabled";
+
+			#cooling-cells = <2>;
+
+			gpu_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				/*
+				 * 624Mhz is only available on speed bins 0 and 3.
+				 * 560Mhz is only available on speed bins 0, 2 and 3.
+				 * All the rest are available on all bins of the hardware.
+				 */
+				opp-624000000 {
+					opp-hz = /bits/ 64 <624000000>;
+					opp-supported-hw = <0x09>;
+				};
+				opp-560000000 {
+					opp-hz = /bits/ 64 <560000000>;
+					opp-supported-hw = <0x0d>;
+				};
+				opp-510000000 {
+					opp-hz = /bits/ 64 <510000000>;
+					opp-supported-hw = <0xff>;
+				};
+				opp-401800000 {
+					opp-hz = /bits/ 64 <401800000>;
+					opp-supported-hw = <0xff>;
+				};
+				opp-315000000 {
+					opp-hz = /bits/ 64 <315000000>;
+					opp-supported-hw = <0xff>;
+				};
+				opp-214000000 {
+					opp-hz = /bits/ 64 <214000000>;
+					opp-supported-hw = <0xff>;
+				};
+				opp-133000000 {
+					opp-hz = /bits/ 64 <133000000>;
+					opp-supported-hw = <0xff>;
+				};
+			};
+
+			zap-shader {
+				memory-region = <&gpu_mem>;
+			};
+		};
+
+		tlmm: pinctrl@1010000 {
+			compatible = "qcom,msm8996-pinctrl";
+			reg = <0x01010000 0x300000>;
+			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			gpio-ranges = <&tlmm 0 0 150>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			blsp1_spi1_default: blsp1-spi1-default-state {
+				spi-pins {
+					pins = "gpio0", "gpio1", "gpio3";
+					function = "blsp_spi1";
+					drive-strength = <12>;
+					bias-disable;
+				};
+
+				cs-pins {
+					pins = "gpio2";
+					function = "gpio";
+					drive-strength = <16>;
+					bias-disable;
+					output-high;
+				};
+			};
+
+			blsp1_spi1_sleep: blsp1-spi1-sleep-state {
+				pins = "gpio0", "gpio1", "gpio2", "gpio3";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			blsp2_uart2_2pins_default: blsp2-uart2-2pins-state {
+				pins = "gpio4", "gpio5";
+				function = "blsp_uart8";
+				drive-strength = <16>;
+				bias-disable;
+			};
+
+			blsp2_uart2_2pins_sleep: blsp2-uart2-2pins-sleep-state {
+				pins = "gpio4", "gpio5";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			blsp2_i2c2_default: blsp2-i2c2-state {
+				pins = "gpio6", "gpio7";
+				function = "blsp_i2c8";
+				drive-strength = <16>;
+				bias-disable;
+			};
+
+			blsp2_i2c2_sleep: blsp2-i2c2-sleep-state {
+				pins = "gpio6", "gpio7";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			blsp1_i2c6_default: blsp1-i2c6-state {
+				pins = "gpio27", "gpio28";
+				function = "blsp_i2c6";
+				drive-strength = <16>;
+				bias-disable;
+			};
+
+			blsp1_i2c6_sleep: blsp1-i2c6-sleep-state {
+				pins = "gpio27", "gpio28";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			cci0_default: cci0-default-state {
+				pins = "gpio17", "gpio18";
+				function = "cci_i2c";
+				drive-strength = <16>;
+				bias-disable;
+			};
+
+			camera0_state_on:
+			camera_rear_default: camera-rear-default-state {
+				camera0_mclk: mclk0-pins {
+					pins = "gpio13";
+					function = "cam_mclk";
+					drive-strength = <16>;
+					bias-disable;
+				};
+
+				camera0_rst: rst-pins {
+					pins = "gpio25";
+					function = "gpio";
+					drive-strength = <16>;
+					bias-disable;
+				};
+
+				camera0_pwdn: pwdn-pins {
+					pins = "gpio26";
+					function = "gpio";
+					drive-strength = <16>;
+					bias-disable;
+				};
+			};
+
+			cci1_default: cci1-default-state {
+				pins = "gpio19", "gpio20";
+				function = "cci_i2c";
+				drive-strength = <16>;
+				bias-disable;
+			};
+
+			camera1_state_on:
+			camera_board_default: camera-board-default-state {
+				mclk1-pins {
+					pins = "gpio14";
+					function = "cam_mclk";
+					drive-strength = <16>;
+					bias-disable;
+				};
+
+				pwdn-pins {
+					pins = "gpio98";
+					function = "gpio";
+					drive-strength = <16>;
+					bias-disable;
+				};
+
+				rst-pins {
+					pins = "gpio104";
+					function = "gpio";
+					drive-strength = <16>;
+					bias-disable;
+				};
+			};
+
+			camera2_state_on:
+			camera_front_default: camera-front-default-state {
+				camera2_mclk: mclk2-pins {
+					pins = "gpio15";
+					function = "cam_mclk";
+					drive-strength = <16>;
+					bias-disable;
+				};
+
+				camera2_rst: rst-pins {
+					pins = "gpio23";
+					function = "gpio";
+					drive-strength = <16>;
+					bias-disable;
+				};
+
+				pwdn-pins {
+					pins = "gpio133";
+					function = "gpio";
+					drive-strength = <16>;
+					bias-disable;
+				};
+			};
+
+			pcie0_state_on: pcie0-state-on-state {
+				perst-pins {
+					pins = "gpio35";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+
+				clkreq-pins {
+					pins = "gpio36";
+					function = "pci_e0";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+
+				wake-pins {
+					pins = "gpio37";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+			};
+
+			pcie0_state_off: pcie0-state-off-state {
+				perst-pins {
+					pins = "gpio35";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+
+				clkreq-pins {
+					pins = "gpio36";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-disable;
+				};
+
+				wake-pins {
+					pins = "gpio37";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-disable;
+				};
+			};
+
+			blsp1_uart2_default: blsp1-uart2-default-state {
+				pins = "gpio41", "gpio42", "gpio43", "gpio44";
+				function = "blsp_uart2";
+				drive-strength = <16>;
+				bias-disable;
+			};
+
+			blsp1_uart2_sleep: blsp1-uart2-sleep-state {
+				pins = "gpio41", "gpio42", "gpio43", "gpio44";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			blsp1_i2c3_default: blsp1-i2c3-default-state {
+				pins = "gpio47", "gpio48";
+				function = "blsp_i2c3";
+				drive-strength = <16>;
+				bias-disable;
+			};
+
+			blsp1_i2c3_sleep: blsp1-i2c3-sleep-state {
+				pins = "gpio47", "gpio48";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			blsp2_uart3_4pins_default: blsp2-uart3-4pins-state {
+				pins = "gpio49", "gpio50", "gpio51", "gpio52";
+				function = "blsp_uart9";
+				drive-strength = <16>;
+				bias-disable;
+			};
+
+			blsp2_uart3_4pins_sleep: blsp2-uart3-4pins-sleep-state {
+				pins = "gpio49", "gpio50", "gpio51", "gpio52";
+				function = "blsp_uart9";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			blsp2_i2c3_default: blsp2-i2c3-state-state {
+				pins = "gpio51", "gpio52";
+				function = "blsp_i2c9";
+				drive-strength = <16>;
+				bias-disable;
+			};
+
+			blsp2_i2c3_sleep: blsp2-i2c3-sleep-state {
+				pins = "gpio51", "gpio52";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			wcd_intr_default: wcd-intr-default-state {
+				pins = "gpio54";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			blsp2_i2c1_default: blsp2-i2c1-state {
+				pins = "gpio55", "gpio56";
+				function = "blsp_i2c7";
+				drive-strength = <16>;
+				bias-disable;
+			};
+
+			blsp2_i2c1_sleep: blsp2-i2c1-sleep-state {
+				pins = "gpio55", "gpio56";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			blsp2_i2c5_default: blsp2-i2c5-state {
+				pins = "gpio60", "gpio61";
+				function = "blsp_i2c11";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			/* Sleep state for BLSP2_I2C5 is missing.. */
+
+			cdc_reset_active: cdc-reset-active-state {
+				pins = "gpio64";
+				function = "gpio";
+				drive-strength = <16>;
+				bias-pull-down;
+				output-high;
+			};
+
+			cdc_reset_sleep: cdc-reset-sleep-state {
+				pins = "gpio64";
+				function = "gpio";
+				drive-strength = <16>;
+				bias-disable;
+				output-low;
+			};
+
+			blsp2_spi6_default: blsp2-spi6-default-state {
+				spi-pins {
+					pins = "gpio85", "gpio86", "gpio88";
+					function = "blsp_spi12";
+					drive-strength = <12>;
+					bias-disable;
+				};
+
+				cs-pins {
+					pins = "gpio87";
+					function = "gpio";
+					drive-strength = <16>;
+					bias-disable;
+					output-high;
+				};
+			};
+
+			blsp2_spi6_sleep: blsp2-spi6-sleep-state {
+				pins = "gpio85", "gpio86", "gpio87", "gpio88";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			blsp2_i2c6_default: blsp2-i2c6-state {
+				pins = "gpio87", "gpio88";
+				function = "blsp_i2c12";
+				drive-strength = <16>;
+				bias-disable;
+			};
+
+			blsp2_i2c6_sleep: blsp2-i2c6-sleep-state {
+				pins = "gpio87", "gpio88";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			pcie1_state_on: pcie1-on-state {
+				perst-pins {
+					pins = "gpio130";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+
+				clkreq-pins {
+					pins = "gpio131";
+					function = "pci_e1";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+
+				wake-pins {
+					pins = "gpio132";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+			};
+
+			pcie1_state_off: pcie1-off-state {
+				/* Perst is missing? */
+				clkreq-pins {
+					pins = "gpio131";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-disable;
+				};
+
+				wake-pins {
+					pins = "gpio132";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-disable;
+				};
+			};
+
+			pcie2_state_on: pcie2-on-state {
+				perst-pins {
+					pins = "gpio114";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+
+				clkreq-pins {
+					pins = "gpio115";
+					function = "pci_e2";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+
+				wake-pins {
+					pins = "gpio116";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+			};
+
+			pcie2_state_off: pcie2-off-state {
+				/* Perst is missing? */
+				clkreq-pins {
+					pins = "gpio115";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-disable;
+				};
+
+				wake-pins {
+					pins = "gpio116";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-disable;
+				};
+			};
+
+			sdc1_state_on: sdc1-on-state {
+				clk-pins {
+					pins = "sdc1_clk";
+					bias-disable;
+					drive-strength = <16>;
+				};
+
+				cmd-pins {
+					pins = "sdc1_cmd";
+					bias-pull-up;
+					drive-strength = <10>;
+				};
+
+				data-pins {
+					pins = "sdc1_data";
+					bias-pull-up;
+					drive-strength = <10>;
+				};
+
+				rclk-pins {
+					pins = "sdc1_rclk";
+					bias-pull-down;
+				};
+			};
+
+			sdc1_state_off: sdc1-off-state {
+				clk-pins {
+					pins = "sdc1_clk";
+					bias-disable;
+					drive-strength = <2>;
+				};
+
+				cmd-pins {
+					pins = "sdc1_cmd";
+					bias-pull-up;
+					drive-strength = <2>;
+				};
+
+				data-pins {
+					pins = "sdc1_data";
+					bias-pull-up;
+					drive-strength = <2>;
+				};
+
+				rclk-pins {
+					pins = "sdc1_rclk";
+					bias-pull-down;
+				};
+			};
+
+			sdc2_state_on: sdc2-on-state {
+				clk-pins {
+					pins = "sdc2_clk";
+					bias-disable;
+					drive-strength = <16>;
+				};
+
+				cmd-pins {
+					pins = "sdc2_cmd";
+					bias-pull-up;
+					drive-strength = <10>;
+				};
+
+				data-pins {
+					pins = "sdc2_data";
+					bias-pull-up;
+					drive-strength = <10>;
+				};
+			};
+
+			sdc2_state_off: sdc2-off-state {
+				clk-pins {
+					pins = "sdc2_clk";
+					bias-disable;
+					drive-strength = <2>;
+				};
+
+				cmd-pins {
+					pins = "sdc2_cmd";
+					bias-pull-up;
+					drive-strength = <2>;
+				};
+
+				data-pins {
+					pins = "sdc2_data";
+					bias-pull-up;
+					drive-strength = <2>;
+				};
+			};
+		};
+
+		sram@290000 {
+			compatible = "qcom,rpm-stats";
+			reg = <0x00290000 0x10000>;
+		};
+
+		spmi_bus: spmi@400f000 {
+			compatible = "qcom,spmi-pmic-arb";
+			reg = <0x0400f000 0x1000>,
+			      <0x04400000 0x800000>,
+			      <0x04c00000 0x800000>,
+			      <0x05800000 0x200000>,
+			      <0x0400a000 0x002100>;
+			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
+			interrupt-names = "periph_irq";
+			interrupts = <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>;
+			qcom,ee = <0>;
+			qcom,channel = <0>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+			interrupt-controller;
+			#interrupt-cells = <4>;
+		};
+
+		bus@0 {
+			power-domains = <&gcc AGGRE0_NOC_GDSC>;
+			compatible = "simple-pm-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			pcie0: pcie@600000 {
+				compatible = "qcom,pcie-msm8996";
+				status = "disabled";
+				power-domains = <&gcc PCIE0_GDSC>;
+				bus-range = <0x00 0xff>;
+				num-lanes = <1>;
+
+				reg = <0x00600000 0x2000>,
+				      <0x0c000000 0xf1d>,
+				      <0x0c000f20 0xa8>,
+				      <0x0c100000 0x100000>;
+				reg-names = "parf", "dbi", "elbi","config";
+
+				phys = <&pciephy_0>;
+				phy-names = "pciephy";
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges = <0x01000000 0x0 0x00000000 0x0c200000 0x0 0x100000>,
+					 <0x02000000 0x0 0x0c300000 0x0c300000 0x0 0xd00000>;
+
+				device_type = "pci";
+
+				interrupts = <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "msi";
+				#interrupt-cells = <1>;
+				interrupt-map-mask = <0 0 0 0x7>;
+				interrupt-map = <0 0 0 1 &intc 0 244 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+						<0 0 0 2 &intc 0 245 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+						<0 0 0 3 &intc 0 247 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+						<0 0 0 4 &intc 0 248 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+				pinctrl-names = "default", "sleep";
+				pinctrl-0 = <&pcie0_state_on>;
+				pinctrl-1 = <&pcie0_state_off>;
+
+				linux,pci-domain = <0>;
+
+				clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
+					<&gcc GCC_PCIE_0_AUX_CLK>,
+					<&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+					<&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
+					<&gcc GCC_PCIE_0_SLV_AXI_CLK>;
+
+				clock-names = "pipe",
+						"aux",
+						"cfg",
+						"bus_master",
+						"bus_slave";
+			};
+
+			pcie1: pcie@608000 {
+				compatible = "qcom,pcie-msm8996";
+				power-domains = <&gcc PCIE1_GDSC>;
+				bus-range = <0x00 0xff>;
+				num-lanes = <1>;
+
+				status = "disabled";
+
+				reg = <0x00608000 0x2000>,
+				      <0x0d000000 0xf1d>,
+				      <0x0d000f20 0xa8>,
+				      <0x0d100000 0x100000>;
+
+				reg-names = "parf", "dbi", "elbi","config";
+
+				phys = <&pciephy_1>;
+				phy-names = "pciephy";
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges = <0x01000000 0x0 0x00000000 0x0d200000 0x0 0x100000>,
+					 <0x02000000 0x0 0x0d300000 0x0d300000 0x0 0xd00000>;
+
+				device_type = "pci";
+
+				interrupts = <GIC_SPI 413 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "msi";
+				#interrupt-cells = <1>;
+				interrupt-map-mask = <0 0 0 0x7>;
+				interrupt-map = <0 0 0 1 &intc 0 272 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+						<0 0 0 2 &intc 0 273 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+						<0 0 0 3 &intc 0 274 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+						<0 0 0 4 &intc 0 275 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+				pinctrl-names = "default", "sleep";
+				pinctrl-0 = <&pcie1_state_on>;
+				pinctrl-1 = <&pcie1_state_off>;
+
+				linux,pci-domain = <1>;
+
+				clocks = <&gcc GCC_PCIE_1_PIPE_CLK>,
+					<&gcc GCC_PCIE_1_AUX_CLK>,
+					<&gcc GCC_PCIE_1_CFG_AHB_CLK>,
+					<&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
+					<&gcc GCC_PCIE_1_SLV_AXI_CLK>;
+
+				clock-names = "pipe",
+						"aux",
+						"cfg",
+						"bus_master",
+						"bus_slave";
+			};
+
+			pcie2: pcie@610000 {
+				compatible = "qcom,pcie-msm8996";
+				power-domains = <&gcc PCIE2_GDSC>;
+				bus-range = <0x00 0xff>;
+				num-lanes = <1>;
+				status = "disabled";
+				reg = <0x00610000 0x2000>,
+				      <0x0e000000 0xf1d>,
+				      <0x0e000f20 0xa8>,
+				      <0x0e100000 0x100000>;
+
+				reg-names = "parf", "dbi", "elbi","config";
+
+				phys = <&pciephy_2>;
+				phy-names = "pciephy";
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges = <0x01000000 0x0 0x00000000 0x0e200000 0x0 0x100000>,
+					 <0x02000000 0x0 0x0e300000 0x0e300000 0x0 0x1d00000>;
+
+				device_type = "pci";
+
+				interrupts = <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "msi";
+				#interrupt-cells = <1>;
+				interrupt-map-mask = <0 0 0 0x7>;
+				interrupt-map = <0 0 0 1 &intc 0 142 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+						<0 0 0 2 &intc 0 143 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+						<0 0 0 3 &intc 0 144 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+						<0 0 0 4 &intc 0 145 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+				pinctrl-names = "default", "sleep";
+				pinctrl-0 = <&pcie2_state_on>;
+				pinctrl-1 = <&pcie2_state_off>;
+
+				linux,pci-domain = <2>;
+				clocks = <&gcc GCC_PCIE_2_PIPE_CLK>,
+					<&gcc GCC_PCIE_2_AUX_CLK>,
+					<&gcc GCC_PCIE_2_CFG_AHB_CLK>,
+					<&gcc GCC_PCIE_2_MSTR_AXI_CLK>,
+					<&gcc GCC_PCIE_2_SLV_AXI_CLK>;
+
+				clock-names = "pipe",
+						"aux",
+						"cfg",
+						"bus_master",
+						"bus_slave";
+			};
+		};
+
+		ufshc: ufshc@624000 {
+			compatible = "qcom,msm8996-ufshc", "qcom,ufshc",
+				     "jedec,ufs-2.0";
+			reg = <0x00624000 0x2500>;
+			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
+
+			phys = <&ufsphy_lane>;
+			phy-names = "ufsphy";
+
+			power-domains = <&gcc UFS_GDSC>;
+
+			clock-names =
+				"core_clk_src",
+				"core_clk",
+				"bus_clk",
+				"bus_aggr_clk",
+				"iface_clk",
+				"core_clk_unipro_src",
+				"core_clk_unipro",
+				"core_clk_ice",
+				"ref_clk",
+				"tx_lane0_sync_clk",
+				"rx_lane0_sync_clk";
+			clocks =
+				<&gcc UFS_AXI_CLK_SRC>,
+				<&gcc GCC_UFS_AXI_CLK>,
+				<&gcc GCC_SYS_NOC_UFS_AXI_CLK>,
+				<&gcc GCC_AGGRE2_UFS_AXI_CLK>,
+				<&gcc GCC_UFS_AHB_CLK>,
+				<&gcc UFS_ICE_CORE_CLK_SRC>,
+				<&gcc GCC_UFS_UNIPRO_CORE_CLK>,
+				<&gcc GCC_UFS_ICE_CORE_CLK>,
+				<&rpmcc RPM_SMD_LN_BB_CLK>,
+				<&gcc GCC_UFS_TX_SYMBOL_0_CLK>,
+				<&gcc GCC_UFS_RX_SYMBOL_0_CLK>;
+			freq-table-hz =
+				<100000000 200000000>,
+				<0 0>,
+				<0 0>,
+				<0 0>,
+				<0 0>,
+				<150000000 300000000>,
+				<0 0>,
+				<0 0>,
+				<0 0>,
+				<0 0>,
+				<0 0>;
+
+			interconnects = <&a2noc MASTER_UFS &bimc SLAVE_EBI_CH0>,
+					<&bimc MASTER_AMPSS_M0 &cnoc SLAVE_UFS_CFG>;
+			interconnect-names = "ufs-ddr", "cpu-ufs";
+
+			lanes-per-direction = <1>;
+			#reset-cells = <1>;
+			status = "disabled";
+		};
+
+		ufsphy: phy@627000 {
+			compatible = "qcom,msm8996-qmp-ufs-phy";
+			reg = <0x00627000 0x1c4>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			clocks = <&gcc GCC_UFS_CLKREF_CLK>;
+			clock-names = "ref";
+
+			resets = <&ufshc 0>;
+			reset-names = "ufsphy";
+			status = "disabled";
+
+			ufsphy_lane: phy@627400 {
+				reg = <0x627400 0x12c>,
+				      <0x627600 0x200>,
+				      <0x627c00 0x1b4>;
+				#clock-cells = <1>;
+				#phy-cells = <0>;
+			};
+		};
+
+		camss: camss@a00000 {
+			compatible = "qcom,msm8996-camss";
+			reg = <0x00a34000 0x1000>,
+			      <0x00a00030 0x4>,
+			      <0x00a35000 0x1000>,
+			      <0x00a00038 0x4>,
+			      <0x00a36000 0x1000>,
+			      <0x00a00040 0x4>,
+			      <0x00a30000 0x100>,
+			      <0x00a30400 0x100>,
+			      <0x00a30800 0x100>,
+			      <0x00a30c00 0x100>,
+			      <0x00a31000 0x500>,
+			      <0x00a00020 0x10>,
+			      <0x00a10000 0x1000>,
+			      <0x00a14000 0x1000>;
+			reg-names = "csiphy0",
+				"csiphy0_clk_mux",
+				"csiphy1",
+				"csiphy1_clk_mux",
+				"csiphy2",
+				"csiphy2_clk_mux",
+				"csid0",
+				"csid1",
+				"csid2",
+				"csid3",
+				"ispif",
+				"csi_clk_mux",
+				"vfe0",
+				"vfe1";
+			interrupts = <GIC_SPI 78 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 79 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 80 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 296 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 297 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 298 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 299 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 309 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 314 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 315 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "csiphy0",
+				"csiphy1",
+				"csiphy2",
+				"csid0",
+				"csid1",
+				"csid2",
+				"csid3",
+				"ispif",
+				"vfe0",
+				"vfe1";
+			power-domains = <&mmcc VFE0_GDSC>,
+					<&mmcc VFE1_GDSC>;
+			clocks = <&mmcc CAMSS_TOP_AHB_CLK>,
+				<&mmcc CAMSS_ISPIF_AHB_CLK>,
+				<&mmcc CAMSS_CSI0PHYTIMER_CLK>,
+				<&mmcc CAMSS_CSI1PHYTIMER_CLK>,
+				<&mmcc CAMSS_CSI2PHYTIMER_CLK>,
+				<&mmcc CAMSS_CSI0_AHB_CLK>,
+				<&mmcc CAMSS_CSI0_CLK>,
+				<&mmcc CAMSS_CSI0PHY_CLK>,
+				<&mmcc CAMSS_CSI0PIX_CLK>,
+				<&mmcc CAMSS_CSI0RDI_CLK>,
+				<&mmcc CAMSS_CSI1_AHB_CLK>,
+				<&mmcc CAMSS_CSI1_CLK>,
+				<&mmcc CAMSS_CSI1PHY_CLK>,
+				<&mmcc CAMSS_CSI1PIX_CLK>,
+				<&mmcc CAMSS_CSI1RDI_CLK>,
+				<&mmcc CAMSS_CSI2_AHB_CLK>,
+				<&mmcc CAMSS_CSI2_CLK>,
+				<&mmcc CAMSS_CSI2PHY_CLK>,
+				<&mmcc CAMSS_CSI2PIX_CLK>,
+				<&mmcc CAMSS_CSI2RDI_CLK>,
+				<&mmcc CAMSS_CSI3_AHB_CLK>,
+				<&mmcc CAMSS_CSI3_CLK>,
+				<&mmcc CAMSS_CSI3PHY_CLK>,
+				<&mmcc CAMSS_CSI3PIX_CLK>,
+				<&mmcc CAMSS_CSI3RDI_CLK>,
+				<&mmcc CAMSS_AHB_CLK>,
+				<&mmcc CAMSS_VFE0_CLK>,
+				<&mmcc CAMSS_CSI_VFE0_CLK>,
+				<&mmcc CAMSS_VFE0_AHB_CLK>,
+				<&mmcc CAMSS_VFE0_STREAM_CLK>,
+				<&mmcc CAMSS_VFE1_CLK>,
+				<&mmcc CAMSS_CSI_VFE1_CLK>,
+				<&mmcc CAMSS_VFE1_AHB_CLK>,
+				<&mmcc CAMSS_VFE1_STREAM_CLK>,
+				<&mmcc CAMSS_VFE_AHB_CLK>,
+				<&mmcc CAMSS_VFE_AXI_CLK>;
+			clock-names = "top_ahb",
+				"ispif_ahb",
+				"csiphy0_timer",
+				"csiphy1_timer",
+				"csiphy2_timer",
+				"csi0_ahb",
+				"csi0",
+				"csi0_phy",
+				"csi0_pix",
+				"csi0_rdi",
+				"csi1_ahb",
+				"csi1",
+				"csi1_phy",
+				"csi1_pix",
+				"csi1_rdi",
+				"csi2_ahb",
+				"csi2",
+				"csi2_phy",
+				"csi2_pix",
+				"csi2_rdi",
+				"csi3_ahb",
+				"csi3",
+				"csi3_phy",
+				"csi3_pix",
+				"csi3_rdi",
+				"ahb",
+				"vfe0",
+				"csi_vfe0",
+				"vfe0_ahb",
+				"vfe0_stream",
+				"vfe1",
+				"csi_vfe1",
+				"vfe1_ahb",
+				"vfe1_stream",
+				"vfe_ahb",
+				"vfe_axi";
+			iommus = <&vfe_smmu 0>,
+				 <&vfe_smmu 1>,
+				 <&vfe_smmu 2>,
+				 <&vfe_smmu 3>;
+			status = "disabled";
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
+		cci: cci@a0c000 {
+			compatible = "qcom,msm8996-cci";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0xa0c000 0x1000>;
+			interrupts = <GIC_SPI 295 IRQ_TYPE_EDGE_RISING>;
+			power-domains = <&mmcc CAMSS_GDSC>;
+			clocks = <&mmcc CAMSS_TOP_AHB_CLK>,
+				 <&mmcc CAMSS_CCI_AHB_CLK>,
+				 <&mmcc CAMSS_CCI_CLK>,
+				 <&mmcc CAMSS_AHB_CLK>;
+			clock-names = "camss_top_ahb",
+				      "cci_ahb",
+				      "cci",
+				      "camss_ahb";
+			assigned-clocks = <&mmcc CAMSS_CCI_AHB_CLK>,
+					  <&mmcc CAMSS_CCI_CLK>;
+			assigned-clock-rates = <80000000>, <37500000>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&cci0_default &cci1_default>;
+			status = "disabled";
+
+			cci_i2c0: i2c-bus@0 {
+				reg = <0>;
+				clock-frequency = <400000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			cci_i2c1: i2c-bus@1 {
+				reg = <1>;
+				clock-frequency = <400000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
+		adreno_smmu: iommu@b40000 {
+			compatible = "qcom,msm8996-smmu-v2", "qcom,adreno-smmu", "qcom,smmu-v2";
+			reg = <0x00b40000 0x10000>;
+
+			#global-interrupts = <1>;
+			interrupts = <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+
+			clocks = <&gcc GCC_MMSS_BIMC_GFX_CLK>,
+				 <&mmcc GPU_AHB_CLK>;
+			clock-names = "bus", "iface";
+
+			power-domains = <&mmcc GPU_GDSC>;
+		};
+
+		venus: video-codec@c00000 {
+			compatible = "qcom,msm8996-venus";
+			reg = <0x00c00000 0xff000>;
+			interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&mmcc VENUS_GDSC>;
+			clocks = <&mmcc VIDEO_CORE_CLK>,
+				 <&mmcc VIDEO_AHB_CLK>,
+				 <&mmcc VIDEO_AXI_CLK>,
+				 <&mmcc VIDEO_MAXI_CLK>;
+			clock-names = "core", "iface", "bus", "mbus";
+			interconnects = <&mnoc MASTER_VIDEO_P0 &bimc SLAVE_EBI_CH0>,
+					<&bimc MASTER_AMPSS_M0 &mnoc SLAVE_VENUS_CFG>;
+			interconnect-names = "video-mem", "cpu-cfg";
+			iommus = <&venus_smmu 0x00>,
+				 <&venus_smmu 0x01>,
+				 <&venus_smmu 0x0a>,
+				 <&venus_smmu 0x07>,
+				 <&venus_smmu 0x0e>,
+				 <&venus_smmu 0x0f>,
+				 <&venus_smmu 0x08>,
+				 <&venus_smmu 0x09>,
+				 <&venus_smmu 0x0b>,
+				 <&venus_smmu 0x0c>,
+				 <&venus_smmu 0x0d>,
+				 <&venus_smmu 0x10>,
+				 <&venus_smmu 0x11>,
+				 <&venus_smmu 0x21>,
+				 <&venus_smmu 0x28>,
+				 <&venus_smmu 0x29>,
+				 <&venus_smmu 0x2b>,
+				 <&venus_smmu 0x2c>,
+				 <&venus_smmu 0x2d>,
+				 <&venus_smmu 0x31>;
+			memory-region = <&venus_mem>;
+			status = "disabled";
+
+			video-decoder {
+				compatible = "venus-decoder";
+				clocks = <&mmcc VIDEO_SUBCORE0_CLK>;
+				clock-names = "core";
+				power-domains = <&mmcc VENUS_CORE0_GDSC>;
+			};
+
+			video-encoder {
+				compatible = "venus-encoder";
+				clocks = <&mmcc VIDEO_SUBCORE1_CLK>;
+				clock-names = "core";
+				power-domains = <&mmcc VENUS_CORE1_GDSC>;
+			};
+		};
+
+		mdp_smmu: iommu@d00000 {
+			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
+			reg = <0x00d00000 0x10000>;
+
+			#global-interrupts = <1>;
+			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			clocks = <&mmcc SMMU_MDP_AXI_CLK>,
+				 <&mmcc SMMU_MDP_AHB_CLK>;
+			clock-names = "bus", "iface";
+
+			power-domains = <&mmcc MDSS_GDSC>;
+		};
+
+		venus_smmu: iommu@d40000 {
+			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
+			reg = <0x00d40000 0x20000>;
+			#global-interrupts = <1>;
+			interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&mmcc MMAGIC_VIDEO_GDSC>;
+			clocks = <&mmcc SMMU_VIDEO_AXI_CLK>,
+				 <&mmcc SMMU_VIDEO_AHB_CLK>;
+			clock-names = "bus", "iface";
+			#iommu-cells = <1>;
+			status = "okay";
+		};
+
+		vfe_smmu: iommu@da0000 {
+			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
+			reg = <0x00da0000 0x10000>;
+
+			#global-interrupts = <1>;
+			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&mmcc MMAGIC_CAMSS_GDSC>;
+			clocks = <&mmcc SMMU_VFE_AXI_CLK>,
+				 <&mmcc SMMU_VFE_AHB_CLK>;
+			clock-names = "bus", "iface";
+			#iommu-cells = <1>;
+		};
+
+		lpass_q6_smmu: iommu@1600000 {
+			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
+			reg = <0x01600000 0x20000>;
+			#iommu-cells = <1>;
+			power-domains = <&gcc HLOS1_VOTE_LPASS_CORE_GDSC>;
+
+			#global-interrupts = <1>;
+			interrupts = <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 393 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 394 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_HLOS1_VOTE_LPASS_ADSP_SMMU_CLK>,
+				 <&gcc GCC_HLOS1_VOTE_LPASS_CORE_SMMU_CLK>;
+			clock-names = "bus", "iface";
+		};
+
+		slpi_pil: remoteproc@1c00000 {
+			compatible = "qcom,msm8996-slpi-pil";
+			reg = <0x01c00000 0x4000>;
+
+			interrupts-extended = <&intc 0 390 IRQ_TYPE_EDGE_RISING>,
+					      <&slpi_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&slpi_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&slpi_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&slpi_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog",
+					  "fatal",
+					  "ready",
+					  "handover",
+					  "stop-ack";
+
+			clocks = <&xo_board>,
+				 <&rpmcc RPM_SMD_AGGR2_NOC_CLK>;
+			clock-names = "xo", "aggre2";
+
+			memory-region = <&slpi_mem>;
+
+			qcom,smem-states = <&slpi_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			power-domains = <&rpmpd MSM8996_VDDSSCX>;
+			power-domain-names = "ssc_cx";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts = <GIC_SPI 452 IRQ_TYPE_EDGE_RISING>;
+				label = "dsps";
+				qcom,remote-pid = <1>;
+				mboxes = <&apcs_glb 27>;
+			};
+
+			smd-edge {
+				interrupts = <GIC_SPI 176 IRQ_TYPE_EDGE_RISING>;
+
+				label = "dsps";
+				mboxes = <&apcs_glb 25>;
+				qcom,smd-edge = <3>;
+				qcom,remote-pid = <3>;
+			};
+		};
+
+		mss_pil: remoteproc@2080000 {
+			compatible = "qcom,msm8996-mss-pil";
+			reg = <0x2080000 0x100>,
+			      <0x2180000 0x020>;
+			reg-names = "qdsp6", "rmb";
+
+			interrupts-extended = <&intc 0 448 IRQ_TYPE_EDGE_RISING>,
+					      <&mpss_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&mpss_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&mpss_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&mpss_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
+					      <&mpss_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready",
+					  "handover", "stop-ack",
+					  "shutdown-ack";
+
+			clocks = <&gcc GCC_MSS_CFG_AHB_CLK>,
+				 <&gcc GCC_MSS_Q6_BIMC_AXI_CLK>,
+				 <&gcc GCC_BOOT_ROM_AHB_CLK>,
+				 <&xo_board>,
+				 <&gcc GCC_MSS_GPLL0_DIV_CLK>,
+				 <&gcc GCC_MSS_SNOC_AXI_CLK>,
+				 <&gcc GCC_MSS_MNOC_BIMC_AXI_CLK>,
+				 <&rpmcc RPM_SMD_PCNOC_CLK>,
+				 <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "iface", "bus", "mem", "xo", "gpll0_mss",
+				      "snoc_axi", "mnoc_axi", "pnoc", "qdss";
+
+			resets = <&gcc GCC_MSS_RESTART>;
+			reset-names = "mss_restart";
+
+			power-domains = <&rpmpd MSM8996_VDDCX>,
+					<&rpmpd MSM8996_VDDMX>;
+			power-domain-names = "cx", "mx";
+
+			qcom,smem-states = <&mpss_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			qcom,halt-regs = <&tcsr_1 0x3000 0x5000 0x4000>;
+
+			status = "disabled";
+
+			mba {
+				memory-region = <&mba_mem>;
+			};
+
+			mpss {
+				memory-region = <&mpss_mem>;
+			};
+
+			metadata {
+				memory-region = <&mdata_mem>;
+			};
+
+			glink-edge {
+				interrupts = <GIC_SPI 452 IRQ_TYPE_EDGE_RISING>;
+				label = "modem";
+				qcom,remote-pid = <1>;
+				mboxes = <&apcs_glb 15>;
+			};
+
+			smd-edge {
+				interrupts = <GIC_SPI 449 IRQ_TYPE_EDGE_RISING>;
+
+				label = "mpss";
+				mboxes = <&apcs_glb 12>;
+				qcom,smd-edge = <0>;
+				qcom,remote-pid = <1>;
+			};
+		};
+
+		stm@3002000 {
+			compatible = "arm,coresight-stm", "arm,primecell";
+			reg = <0x3002000 0x1000>,
+			      <0x8280000 0x180000>;
+			reg-names = "stm-base", "stm-stimulus-base";
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			out-ports {
+				port {
+					stm_out: endpoint {
+						remote-endpoint =
+						  <&funnel0_in>;
+					};
+				};
+			};
+		};
+
+		tpiu@3020000 {
+			compatible = "arm,coresight-tpiu", "arm,primecell";
+			reg = <0x3020000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			in-ports {
+				port {
+					tpiu_in: endpoint {
+						remote-endpoint =
+						  <&replicator_out1>;
+					};
+				};
+			};
+		};
+
+		funnel@3021000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0x3021000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@7 {
+					reg = <7>;
+					funnel0_in: endpoint {
+						remote-endpoint =
+						  <&stm_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					funnel0_out: endpoint {
+						remote-endpoint =
+						  <&merge_funnel_in0>;
+					};
+				};
+			};
+		};
+
+		funnel@3022000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0x3022000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@6 {
+					reg = <6>;
+					funnel1_in: endpoint {
+						remote-endpoint =
+						  <&apss_merge_funnel_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					funnel1_out: endpoint {
+						remote-endpoint =
+						  <&merge_funnel_in1>;
+					};
+				};
+			};
+		};
+
+		funnel@3023000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0x3023000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+
+			out-ports {
+				port {
+					funnel2_out: endpoint {
+						remote-endpoint =
+						  <&merge_funnel_in2>;
+					};
+				};
+			};
+		};
+
+		funnel@3025000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0x3025000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					merge_funnel_in0: endpoint {
+						remote-endpoint =
+						  <&funnel0_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					merge_funnel_in1: endpoint {
+						remote-endpoint =
+						  <&funnel1_out>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+					merge_funnel_in2: endpoint {
+						remote-endpoint =
+						  <&funnel2_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					merge_funnel_out: endpoint {
+						remote-endpoint =
+						  <&etf_in>;
+					};
+				};
+			};
+		};
+
+		replicator@3026000 {
+			compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
+			reg = <0x3026000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			in-ports {
+				port {
+					replicator_in: endpoint {
+						remote-endpoint =
+						  <&etf_out>;
+					};
+				};
+			};
+
+			out-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					replicator_out0: endpoint {
+						remote-endpoint =
+						  <&etr_in>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					replicator_out1: endpoint {
+						remote-endpoint =
+						  <&tpiu_in>;
+					};
+				};
+			};
+		};
+
+		etf@3027000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0x3027000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			in-ports {
+				port {
+					etf_in: endpoint {
+						remote-endpoint =
+						  <&merge_funnel_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					etf_out: endpoint {
+						remote-endpoint =
+						  <&replicator_in>;
+					};
+				};
+			};
+		};
+
+		etr@3028000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0x3028000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+			arm,scatter-gather;
+
+			in-ports {
+				port {
+					etr_in: endpoint {
+						remote-endpoint =
+						  <&replicator_out0>;
+					};
+				};
+			};
+		};
+
+		debug@3810000 {
+			compatible = "arm,coresight-cpu-debug", "arm,primecell";
+			reg = <0x3810000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			cpu = <&CPU0>;
+		};
+
+		etm@3840000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x3840000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			cpu = <&CPU0>;
+
+			out-ports {
+				port {
+					etm0_out: endpoint {
+						remote-endpoint =
+						  <&apss_funnel0_in0>;
+					};
+				};
+			};
+		};
+
+		debug@3910000 {
+			compatible = "arm,coresight-cpu-debug", "arm,primecell";
+			reg = <0x3910000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			cpu = <&CPU1>;
+		};
+
+		etm@3940000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x3940000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			cpu = <&CPU1>;
+
+			out-ports {
+				port {
+					etm1_out: endpoint {
+						remote-endpoint =
+						  <&apss_funnel0_in1>;
+					};
+				};
+			};
+		};
+
+		funnel@39b0000 { /* APSS Funnel 0 */
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0x39b0000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					apss_funnel0_in0: endpoint {
+						remote-endpoint = <&etm0_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					apss_funnel0_in1: endpoint {
+						remote-endpoint = <&etm1_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					apss_funnel0_out: endpoint {
+						remote-endpoint =
+						  <&apss_merge_funnel_in0>;
+					};
+				};
+			};
+		};
+
+		debug@3a10000 {
+			compatible = "arm,coresight-cpu-debug", "arm,primecell";
+			reg = <0x3a10000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			cpu = <&CPU2>;
+		};
+
+		etm@3a40000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x3a40000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			cpu = <&CPU2>;
+
+			out-ports {
+				port {
+					etm2_out: endpoint {
+						remote-endpoint =
+						  <&apss_funnel1_in0>;
+					};
+				};
+			};
+		};
+
+		debug@3b10000 {
+			compatible = "arm,coresight-cpu-debug", "arm,primecell";
+			reg = <0x3b10000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			cpu = <&CPU3>;
+		};
+
+		etm@3b40000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x3b40000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			cpu = <&CPU3>;
+
+			out-ports {
+				port {
+					etm3_out: endpoint {
+						remote-endpoint =
+						  <&apss_funnel1_in1>;
+					};
+				};
+			};
+		};
+
+		funnel@3bb0000 { /* APSS Funnel 1 */
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0x3bb0000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					apss_funnel1_in0: endpoint {
+						remote-endpoint = <&etm2_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					apss_funnel1_in1: endpoint {
+						remote-endpoint = <&etm3_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					apss_funnel1_out: endpoint {
+						remote-endpoint =
+						  <&apss_merge_funnel_in1>;
+					};
+				};
+			};
+		};
+
+		funnel@3bc0000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0x3bc0000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					apss_merge_funnel_in0: endpoint {
+						remote-endpoint =
+						  <&apss_funnel0_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					apss_merge_funnel_in1: endpoint {
+						remote-endpoint =
+						  <&apss_funnel1_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					apss_merge_funnel_out: endpoint {
+						remote-endpoint =
+						  <&funnel1_in>;
+					};
+				};
+			};
+		};
+
+		kryocc: clock-controller@6400000 {
+			compatible = "qcom,msm8996-apcc";
+			reg = <0x06400000 0x90000>;
+
+			clock-names = "xo", "sys_apcs_aux";
+			clocks = <&rpmcc RPM_SMD_XO_A_CLK_SRC>, <&apcs_glb>;
+
+			#clock-cells = <1>;
+		};
+
+		usb3: usb@6af8800 {
+			compatible = "qcom,msm8996-dwc3", "qcom,dwc3";
+			reg = <0x06af8800 0x400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			interrupts = <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hs_phy_irq", "ss_phy_irq";
+
+			clocks = <&gcc GCC_SYS_NOC_USB3_AXI_CLK>,
+				 <&gcc GCC_USB30_MASTER_CLK>,
+				 <&gcc GCC_AGGRE2_USB3_AXI_CLK>,
+				 <&gcc GCC_USB30_SLEEP_CLK>,
+				 <&gcc GCC_USB30_MOCK_UTMI_CLK>;
+			clock-names = "cfg_noc",
+				      "core",
+				      "iface",
+				      "sleep",
+				      "mock_utmi";
+
+			assigned-clocks = <&gcc GCC_USB30_MOCK_UTMI_CLK>,
+					  <&gcc GCC_USB30_MASTER_CLK>;
+			assigned-clock-rates = <19200000>, <120000000>;
+
+			interconnects = <&a2noc MASTER_USB3 &bimc SLAVE_EBI_CH0>,
+					<&bimc MASTER_AMPSS_M0 &snoc SLAVE_USB3>;
+			interconnect-names = "usb-ddr", "apps-usb";
+
+			power-domains = <&gcc USB30_GDSC>;
+			status = "disabled";
+
+			usb3_dwc3: usb@6a00000 {
+				compatible = "snps,dwc3";
+				reg = <0x06a00000 0xcc00>;
+				interrupts = <0 131 IRQ_TYPE_LEVEL_HIGH>;
+				phys = <&hsusb_phy1>, <&ssusb_phy_0>;
+				phy-names = "usb2-phy", "usb3-phy";
+				snps,hird-threshold = /bits/ 8 <0>;
+				snps,dis_u2_susphy_quirk;
+				snps,dis_enblslpm_quirk;
+				snps,is-utmi-l1-suspend;
+				tx-fifo-resize;
+			};
+		};
+
+		usb3phy: phy@7410000 {
+			compatible = "qcom,msm8996-qmp-usb3-phy";
+			reg = <0x07410000 0x1c4>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			clocks = <&gcc GCC_USB3_PHY_AUX_CLK>,
+				<&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
+				<&gcc GCC_USB3_CLKREF_CLK>;
+			clock-names = "aux", "cfg_ahb", "ref";
+
+			resets = <&gcc GCC_USB3_PHY_BCR>,
+				<&gcc GCC_USB3PHY_PHY_BCR>;
+			reset-names = "phy", "common";
+			status = "disabled";
+
+			ssusb_phy_0: phy@7410200 {
+				reg = <0x07410200 0x200>,
+				      <0x07410400 0x130>,
+				      <0x07410600 0x1a8>;
+				#phy-cells = <0>;
+
+				#clock-cells = <0>;
+				clock-output-names = "usb3_phy_pipe_clk_src";
+				clocks = <&gcc GCC_USB3_PHY_PIPE_CLK>;
+				clock-names = "pipe0";
+			};
+		};
+
+		hsusb_phy1: phy@7411000 {
+			compatible = "qcom,msm8996-qusb2-phy";
+			reg = <0x07411000 0x180>;
+			#phy-cells = <0>;
+
+			clocks = <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
+				<&gcc GCC_RX1_USB2_CLKREF_CLK>;
+			clock-names = "cfg_ahb", "ref";
+
+			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
+			nvmem-cells = <&qusb2p_hstx_trim>;
+			status = "disabled";
+		};
+
+		hsusb_phy2: phy@7412000 {
+			compatible = "qcom,msm8996-qusb2-phy";
+			reg = <0x07412000 0x180>;
+			#phy-cells = <0>;
+
+			clocks = <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
+				<&gcc GCC_RX2_USB2_CLKREF_CLK>;
+			clock-names = "cfg_ahb", "ref";
+
+			resets = <&gcc GCC_QUSB2PHY_SEC_BCR>;
+			nvmem-cells = <&qusb2s_hstx_trim>;
+			status = "disabled";
+		};
+
+		sdhc1: mmc@7464900 {
+			compatible = "qcom,msm8996-sdhci", "qcom,sdhci-msm-v4";
+			reg = <0x07464900 0x11c>, <0x07464000 0x800>;
+			reg-names = "hc", "core";
+
+			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clock-names = "iface", "core", "xo";
+			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
+				<&gcc GCC_SDCC1_APPS_CLK>,
+				<&rpmcc RPM_SMD_XO_CLK_SRC>;
+			resets = <&gcc GCC_SDCC1_BCR>;
+
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&sdc1_state_on>;
+			pinctrl-1 = <&sdc1_state_off>;
+
+			bus-width = <8>;
+			non-removable;
+			status = "disabled";
+		};
+
+		sdhc2: mmc@74a4900 {
+			compatible = "qcom,msm8996-sdhci", "qcom,sdhci-msm-v4";
+			reg = <0x074a4900 0x314>, <0x074a4000 0x800>;
+			reg-names = "hc", "core";
+
+			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clock-names = "iface", "core", "xo";
+			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
+				<&gcc GCC_SDCC2_APPS_CLK>,
+				<&rpmcc RPM_SMD_XO_CLK_SRC>;
+			resets = <&gcc GCC_SDCC2_BCR>;
+
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&sdc2_state_on>;
+			pinctrl-1 = <&sdc2_state_off>;
+
+			bus-width = <4>;
+			status = "disabled";
+		 };
+
+		blsp1_dma: dma-controller@7544000 {
+			compatible = "qcom,bam-v1.7.0";
+			reg = <0x07544000 0x2b000>;
+			interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "bam_clk";
+			qcom,controlled-remotely;
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+		};
+
+		blsp1_uart2: serial@7570000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x07570000 0x1000>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp1_uart2_default>;
+			pinctrl-1 = <&blsp1_uart2_sleep>;
+			dmas = <&blsp1_dma 2>, <&blsp1_dma 3>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		blsp1_spi1: spi@7575000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x07575000 0x600>;
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_QUP1_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp1_spi1_default>;
+			pinctrl-1 = <&blsp1_spi1_sleep>;
+			dmas = <&blsp1_dma 12>, <&blsp1_dma 13>;
+			dma-names = "tx", "rx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp1_i2c3: i2c@7577000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x07577000 0x1000>;
+			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp1_i2c3_default>;
+			pinctrl-1 = <&blsp1_i2c3_sleep>;
+			dmas = <&blsp1_dma 16>, <&blsp1_dma 17>;
+			dma-names = "tx", "rx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp1_i2c6: i2c@757a000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x757a000 0x1000>;
+			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_QUP6_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp1_i2c6_default>;
+			pinctrl-1 = <&blsp1_i2c6_sleep>;
+			dmas = <&blsp1_dma 22>, <&blsp1_dma 23>;
+			dma-names = "tx", "rx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp2_dma: dma-controller@7584000 {
+			compatible = "qcom,bam-v1.7.0";
+			reg = <0x07584000 0x2b000>;
+			interrupts = <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "bam_clk";
+			qcom,controlled-remotely;
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+		};
+
+		blsp2_uart2: serial@75b0000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x075b0000 0x1000>;
+			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP2_UART2_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			status = "disabled";
+		};
+
+		blsp2_uart3: serial@75b1000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x075b1000 0x1000>;
+			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP2_UART3_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			status = "disabled";
+		};
+
+		blsp2_i2c1: i2c@75b5000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x075b5000 0x1000>;
+			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP2_QUP1_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp2_i2c1_default>;
+			pinctrl-1 = <&blsp2_i2c1_sleep>;
+			dmas = <&blsp2_dma 12>, <&blsp2_dma 13>;
+			dma-names = "tx", "rx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp2_i2c2: i2c@75b6000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x075b6000 0x1000>;
+			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP2_QUP2_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp2_i2c2_default>;
+			pinctrl-1 = <&blsp2_i2c2_sleep>;
+			dmas = <&blsp2_dma 14>, <&blsp2_dma 15>;
+			dma-names = "tx", "rx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp2_i2c3: i2c@75b7000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x075b7000 0x1000>;
+			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP2_QUP3_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			clock-frequency = <400000>;
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp2_i2c3_default>;
+			pinctrl-1 = <&blsp2_i2c3_sleep>;
+			dmas = <&blsp2_dma 16>, <&blsp2_dma 17>;
+			dma-names = "tx", "rx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp2_i2c5: i2c@75b9000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x75b9000 0x1000>;
+			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP2_QUP5_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp2_i2c5_default>;
+			dmas = <&blsp2_dma 20>, <&blsp2_dma 21>;
+			dma-names = "tx", "rx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp2_i2c6: i2c@75ba000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x75ba000 0x1000>;
+			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP2_QUP6_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp2_i2c6_default>;
+			pinctrl-1 = <&blsp2_i2c6_sleep>;
+			dmas = <&blsp2_dma 22>, <&blsp2_dma 23>;
+			dma-names = "tx", "rx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp2_spi6: spi@75ba000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x075ba000 0x600>;
+			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP2_QUP6_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp2_spi6_default>;
+			pinctrl-1 = <&blsp2_spi6_sleep>;
+			dmas = <&blsp2_dma 22>, <&blsp2_dma 23>;
+			dma-names = "tx", "rx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		usb2: usb@76f8800 {
+			compatible = "qcom,msm8996-dwc3", "qcom,dwc3";
+			reg = <0x076f8800 0x400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			clocks = <&gcc GCC_PERIPH_NOC_USB20_AHB_CLK>,
+				<&gcc GCC_USB20_MASTER_CLK>,
+				<&gcc GCC_USB20_MOCK_UTMI_CLK>,
+				<&gcc GCC_USB20_SLEEP_CLK>,
+				<&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>;
+			clock-names = "cfg_noc",
+				      "core",
+				      "iface",
+				      "sleep",
+				      "mock_utmi";
+
+			assigned-clocks = <&gcc GCC_USB20_MOCK_UTMI_CLK>,
+					  <&gcc GCC_USB20_MASTER_CLK>;
+			assigned-clock-rates = <19200000>, <60000000>;
+
+			power-domains = <&gcc USB30_GDSC>;
+			qcom,select-utmi-as-pipe-clk;
+			status = "disabled";
+
+			usb2_dwc3: usb@7600000 {
+				compatible = "snps,dwc3";
+				reg = <0x07600000 0xcc00>;
+				interrupts = <0 138 IRQ_TYPE_LEVEL_HIGH>;
+				phys = <&hsusb_phy2>;
+				phy-names = "usb2-phy";
+				maximum-speed = "high-speed";
+				snps,dis_u2_susphy_quirk;
+				snps,dis_enblslpm_quirk;
+			};
+		};
+
+		slimbam: dma-controller@9184000 {
+			compatible = "qcom,bam-v1.7.0";
+			qcom,controlled-remotely;
+			reg = <0x09184000 0x32000>;
+			num-channels = <31>;
+			interrupts = <0 164 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			qcom,ee = <1>;
+			qcom,num-ees = <2>;
+		};
+
+		slim_msm: slim-ngd@91c0000 {
+			compatible = "qcom,slim-ngd-v1.5.0";
+			reg = <0x091c0000 0x2c000>;
+			interrupts = <0 163 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&slimbam 3>, <&slimbam 4>;
+			dma-names = "rx", "tx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disabled";
+		};
+
+		adsp_pil: remoteproc@9300000 {
+			compatible = "qcom,msm8996-adsp-pil";
+			reg = <0x09300000 0x80000>;
+
+			interrupts-extended = <&intc 0 162 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready",
+					  "handover", "stop-ack";
+
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
+			clock-names = "xo";
+
+			memory-region = <&adsp_mem>;
+
+			qcom,smem-states = <&adsp_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			power-domains = <&rpmpd MSM8996_VDDCX>;
+			power-domain-names = "cx";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts = <GIC_SPI 157 IRQ_TYPE_EDGE_RISING>;
+				label = "lpass";
+				qcom,remote-pid = <2>;
+				mboxes = <&apcs_glb 9>;
+			};
+
+
+			smd-edge {
+				interrupts = <GIC_SPI 156 IRQ_TYPE_EDGE_RISING>;
+
+				label = "lpass";
+				mboxes = <&apcs_glb 8>;
+				qcom,smd-edge = <1>;
+				qcom,remote-pid = <2>;
+
+				apr {
+					power-domains = <&gcc HLOS1_VOTE_LPASS_ADSP_GDSC>;
+					compatible = "qcom,apr-v2";
+					qcom,smd-channels = "apr_audio_svc";
+					qcom,domain = <APR_DOMAIN_ADSP>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					service@3 {
+						reg = <APR_SVC_ADSP_CORE>;
+						compatible = "qcom,q6core";
+					};
+
+					q6afe: service@4 {
+						compatible = "qcom,q6afe";
+						reg = <APR_SVC_AFE>;
+						q6afedai: dais {
+							compatible = "qcom,q6afe-dais";
+							#address-cells = <1>;
+							#size-cells = <0>;
+							#sound-dai-cells = <1>;
+							dai@1 {
+								reg = <1>;
+							};
+						};
+					};
+
+					q6asm: service@7 {
+						compatible = "qcom,q6asm";
+						reg = <APR_SVC_ASM>;
+						q6asmdai: dais {
+							compatible = "qcom,q6asm-dais";
+							#address-cells = <1>;
+							#size-cells = <0>;
+							#sound-dai-cells = <1>;
+							iommus = <&lpass_q6_smmu 1>;
+						};
+					};
+
+					q6adm: service@8 {
+						compatible = "qcom,q6adm";
+						reg = <APR_SVC_ADM>;
+						q6routing: routing {
+							compatible = "qcom,q6adm-routing";
+							#sound-dai-cells = <0>;
+						};
+					};
+				};
+
+				fastrpc {
+					compatible = "qcom,fastrpc";
+					qcom,smd-channels = "fastrpcsmd-apps-dsp";
+					label = "adsp";
+
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					cb@1 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <1>;
+						iommus = <&lpass_q6_smmu 8>;
+					};
+
+					cb@2 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <2>;
+						iommus = <&lpass_q6_smmu 9>;
+					};
+
+					cb@3 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <3>;
+						iommus = <&lpass_q6_smmu 10>;
+					};
+
+					cb@4 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <4>;
+						iommus = <&lpass_q6_smmu 11>;
+					};
+
+					cb@5 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <5>;
+						iommus = <&lpass_q6_smmu 12>;
+					};
+
+					cb@6 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <6>;
+						iommus = <&lpass_q6_smmu 5>;
+					};
+
+					cb@7 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <7>;
+						iommus = <&lpass_q6_smmu 6>;
+					};
+
+					cb@8 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <8>;
+						iommus = <&lpass_q6_smmu 7>;
+					};
+				};
+			};
+		};
+
+		apcs_glb: mailbox@9820000 {
+			compatible = "qcom,msm8996-apcs-hmss-global";
+			reg = <0x09820000 0x1000>;
+
+			#mbox-cells = <1>;
+			#clock-cells = <0>;
+		};
+
+		timer@9840000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			compatible = "arm,armv7-timer-mem";
+			reg = <0x09840000 0x1000>;
+			clock-frequency = <19200000>;
+
+			frame@9850000 {
+				frame-number = <0>;
+				interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x09850000 0x1000>,
+				      <0x09860000 0x1000>;
+			};
+
+			frame@9870000 {
+				frame-number = <1>;
+				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x09870000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@9880000 {
+				frame-number = <2>;
+				interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x09880000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@9890000 {
+				frame-number = <3>;
+				interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x09890000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@98a0000 {
+				frame-number = <4>;
+				interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x098a0000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@98b0000 {
+				frame-number = <5>;
+				interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x098b0000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@98c0000 {
+				frame-number = <6>;
+				interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x098c0000 0x1000>;
+				status = "disabled";
+			};
+		};
+
+		saw3: syscon@9a10000 {
+			compatible = "syscon";
+			reg = <0x09a10000 0x1000>;
+		};
+
+		cbf: clock-controller@9a11000 {
+			compatible = "qcom,msm8996-cbf";
+			reg = <0x09a11000 0x10000>;
+			clocks = <&rpmcc RPM_SMD_XO_A_CLK_SRC>, <&apcs_glb>;
+			#clock-cells = <0>;
+			#interconnect-cells = <1>;
+		};
+
+		intc: interrupt-controller@9bc0000 {
+			compatible = "qcom,msm8996-gic-v3", "arm,gic-v3";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			#redistributor-regions = <1>;
+			redistributor-stride = <0x0 0x40000>;
+			reg = <0x09bc0000 0x10000>,
+			      <0x09c00000 0x100000>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
+
+	sound: sound {
+	};
+
+	thermal-zones {
+		cpu0-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 3>;
+
+			trips {
+				cpu0_alert0: trip-point0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu0_crit: cpu-crit {
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu1-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 5>;
+
+			trips {
+				cpu1_alert0: trip-point0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu1_crit: cpu-crit {
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu2-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 8>;
+
+			trips {
+				cpu2_alert0: trip-point0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu2_crit: cpu-crit {
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu3-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 10>;
+
+			trips {
+				cpu3_alert0: trip-point0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu3_crit: cpu-crit {
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpu-top-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 6>;
+
+			trips {
+				gpu1_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpu1_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		gpu-bottom-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 7>;
+
+			trips {
+				gpu2_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpu2_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		m4m-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 1>;
+
+			trips {
+				m4m_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		l3-or-venus-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 2>;
+
+			trips {
+				l3_or_venus_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		cluster0-l2-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 7>;
+
+			trips {
+				cluster0_l2_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		cluster1-l2-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 12>;
+
+			trips {
+				cluster1_l2_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		camera-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 1>;
+
+			trips {
+				camera_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		q6-dsp-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 2>;
+
+			trips {
+				q6_dsp_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		mem-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 3>;
+
+			trips {
+				mem_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		modemtx-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 4>;
+
+			trips {
+				modemtx_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
diff --git a/arch/arm/dts/pm8994.dtsi b/arch/arm/dts/pm8994.dtsi
new file mode 100644
index 000000000000..672094c8ca58
--- /dev/null
+++ b/arch/arm/dts/pm8994.dtsi
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+
+/ {
+	thermal-zones {
+		pm8994-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&pm8994_temp>;
+
+			trips {
+				pm8994_alert0: pm8994-alert0 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				pm8994_crit: pm8994-crit {
+					temperature = <125000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+};
+
+&spmi_bus {
+
+	pmic@0 {
+		compatible = "qcom,pm8994", "qcom,spmi-pmic";
+		reg = <0x0 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		rtc@6000 {
+			compatible = "qcom,pm8941-rtc";
+			reg = <0x6000>, <0x6100>;
+			reg-names = "rtc", "alarm";
+			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
+		};
+
+		pm8994_pon: pon@800 {
+			compatible = "qcom,pm8916-pon";
+			reg = <0x800>;
+			mode-bootloader = <0x2>;
+			mode-recovery = <0x1>;
+
+			pwrkey {
+				compatible = "qcom,pm8941-pwrkey";
+				interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
+				debounce = <15625>;
+				bias-pull-up;
+				linux,code = <KEY_POWER>;
+			};
+
+			pm8994_resin: resin {
+				compatible = "qcom,pm8941-resin";
+				interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
+				debounce = <15625>;
+				bias-pull-up;
+				status = "disabled";
+			};
+		};
+
+		pm8994_temp: temp-alarm@2400 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0x2400>;
+			interrupts = <0x0 0x24 0x0 IRQ_TYPE_EDGE_RISING>;
+			io-channels = <&pm8994_vadc VADC_DIE_TEMP>;
+			io-channel-names = "thermal";
+			#thermal-sensor-cells = <0>;
+		};
+
+		pm8994_vadc: adc@3100 {
+			compatible = "qcom,spmi-vadc";
+			reg = <0x3100>;
+			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#io-channel-cells = <1>;
+
+			adc-chan@7 {
+				reg = <VADC_VSYS>;
+				qcom,pre-scaling = <1 3>;
+				label = "vph_pwr";
+			};
+			adc-chan@8 {
+				reg = <VADC_DIE_TEMP>;
+				label = "die_temp";
+			};
+			adc-chan@9 {
+				reg = <VADC_REF_625MV>;
+				label = "ref_625mv";
+			};
+			adc-chan@a {
+				reg = <VADC_REF_1250MV>;
+				label = "ref_1250mv";
+			};
+			adc-chan@e {
+				reg = <VADC_GND_REF>;
+			};
+			adc-chan@f {
+				reg = <VADC_VDD_VADC>;
+			};
+		};
+
+		pm8994_gpios: gpio@c000 {
+			compatible = "qcom,pm8994-gpio", "qcom,spmi-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			gpio-ranges = <&pm8994_gpios 0 0 22>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		pm8994_mpps: mpps@a000 {
+			compatible = "qcom,pm8994-mpp", "qcom,spmi-mpp";
+			reg = <0xa000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pm8994_mpps 0 0 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	pmic@1 {
+		compatible = "qcom,pm8994", "qcom,spmi-pmic";
+		reg = <0x1 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm8994_lpg: pwm {
+			compatible = "qcom,pm8994-lpg";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#pwm-cells = <2>;
+
+			status = "disabled";
+		};
+
+		pm8994_spmi_regulators: regulators {
+			compatible = "qcom,pm8994-regulators";
+		};
+	};
+};
diff --git a/drivers/clk/qcom/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
index 1e6fdb5cd42d..a4731613c5e0 100644
--- a/drivers/clk/qcom/clock-apq8096.c
+++ b/drivers/clk/qcom/clock-apq8096.c
@@ -13,6 +13,7 @@
 #include <errno.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,gcc-msm8996.h>
 
 #include "clock-qcom.h"
 
@@ -107,10 +108,10 @@ static ulong apq8096_clk_set_rate(struct clk *clk, ulong rate)
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
 
 	switch (clk->id) {
-	case 0: /* SDC1 */
+	case GCC_SDCC1_APPS_CLK: /* SDC1 */
 		return clk_init_sdc(priv, rate);
 		break;
-	case 4: /*UART2*/
+	case GCC_BLSP2_UART2_APPS_CLK: /*UART2*/
 		return clk_init_uart(priv);
 	default:
 		return 0;
diff --git a/include/dt-bindings/clock/qcom,gcc-msm8996.h b/include/dt-bindings/clock/qcom,gcc-msm8996.h
new file mode 100644
index 000000000000..45b320503905
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,gcc-msm8996.h
@@ -0,0 +1,360 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2015, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_MSM_GCC_8996_H
+#define _DT_BINDINGS_CLK_MSM_GCC_8996_H
+
+#define GPLL0_EARLY						0
+#define GPLL0							1
+#define GPLL1_EARLY						2
+#define GPLL1							3
+#define GPLL2_EARLY						4
+#define GPLL2							5
+#define GPLL3_EARLY						6
+#define GPLL3							7
+#define GPLL4_EARLY						8
+#define GPLL4							9
+#define SYSTEM_NOC_CLK_SRC					10
+// U-Boot: Breaks CI, this clock is unused anyway
+/* #define CONFIG_NOC_CLK_SRC					11 */
+#define PERIPH_NOC_CLK_SRC					12
+#define MMSS_BIMC_GFX_CLK_SRC					13
+#define USB30_MASTER_CLK_SRC					14
+#define USB30_MOCK_UTMI_CLK_SRC					15
+#define USB3_PHY_AUX_CLK_SRC					16
+#define USB20_MASTER_CLK_SRC					17
+#define USB20_MOCK_UTMI_CLK_SRC					18
+#define SDCC1_APPS_CLK_SRC					19
+#define SDCC1_ICE_CORE_CLK_SRC					20
+#define SDCC2_APPS_CLK_SRC					21
+#define SDCC3_APPS_CLK_SRC					22
+#define SDCC4_APPS_CLK_SRC					23
+#define BLSP1_QUP1_SPI_APPS_CLK_SRC				24
+#define BLSP1_QUP1_I2C_APPS_CLK_SRC				25
+#define BLSP1_UART1_APPS_CLK_SRC				26
+#define BLSP1_QUP2_SPI_APPS_CLK_SRC				27
+#define BLSP1_QUP2_I2C_APPS_CLK_SRC				28
+#define BLSP1_UART2_APPS_CLK_SRC				29
+#define BLSP1_QUP3_SPI_APPS_CLK_SRC				30
+#define BLSP1_QUP3_I2C_APPS_CLK_SRC				31
+#define BLSP1_UART3_APPS_CLK_SRC				32
+#define BLSP1_QUP4_SPI_APPS_CLK_SRC				33
+#define BLSP1_QUP4_I2C_APPS_CLK_SRC				34
+#define BLSP1_UART4_APPS_CLK_SRC				35
+#define BLSP1_QUP5_SPI_APPS_CLK_SRC				36
+#define BLSP1_QUP5_I2C_APPS_CLK_SRC				37
+#define BLSP1_UART5_APPS_CLK_SRC				38
+#define BLSP1_QUP6_SPI_APPS_CLK_SRC				39
+#define BLSP1_QUP6_I2C_APPS_CLK_SRC				40
+#define BLSP1_UART6_APPS_CLK_SRC				41
+#define BLSP2_QUP1_SPI_APPS_CLK_SRC				42
+#define BLSP2_QUP1_I2C_APPS_CLK_SRC				43
+#define BLSP2_UART1_APPS_CLK_SRC				44
+#define BLSP2_QUP2_SPI_APPS_CLK_SRC				45
+#define BLSP2_QUP2_I2C_APPS_CLK_SRC				46
+#define BLSP2_UART2_APPS_CLK_SRC				47
+#define BLSP2_QUP3_SPI_APPS_CLK_SRC				48
+#define BLSP2_QUP3_I2C_APPS_CLK_SRC				49
+#define BLSP2_UART3_APPS_CLK_SRC				50
+#define BLSP2_QUP4_SPI_APPS_CLK_SRC				51
+#define BLSP2_QUP4_I2C_APPS_CLK_SRC				52
+#define BLSP2_UART4_APPS_CLK_SRC				53
+#define BLSP2_QUP5_SPI_APPS_CLK_SRC				54
+#define BLSP2_QUP5_I2C_APPS_CLK_SRC				55
+#define BLSP2_UART5_APPS_CLK_SRC				56
+#define BLSP2_QUP6_SPI_APPS_CLK_SRC				57
+#define BLSP2_QUP6_I2C_APPS_CLK_SRC				58
+#define BLSP2_UART6_APPS_CLK_SRC				59
+#define PDM2_CLK_SRC						60
+#define TSIF_REF_CLK_SRC					61
+#define CE1_CLK_SRC						62
+#define GCC_SLEEP_CLK_SRC					63
+#define BIMC_CLK_SRC						64
+#define HMSS_AHB_CLK_SRC					65
+#define BIMC_HMSS_AXI_CLK_SRC					66
+#define HMSS_RBCPR_CLK_SRC					67
+#define HMSS_GPLL0_CLK_SRC					68
+#define GP1_CLK_SRC						69
+#define GP2_CLK_SRC						70
+#define GP3_CLK_SRC						71
+#define PCIE_AUX_CLK_SRC					72
+#define UFS_AXI_CLK_SRC						73
+#define UFS_ICE_CORE_CLK_SRC					74
+#define QSPI_SER_CLK_SRC					75
+#define GCC_SYS_NOC_AXI_CLK					76
+#define GCC_SYS_NOC_HMSS_AHB_CLK				77
+#define GCC_SNOC_CNOC_AHB_CLK					78
+#define GCC_SNOC_PNOC_AHB_CLK					79
+#define GCC_SYS_NOC_AT_CLK					80
+#define GCC_SYS_NOC_USB3_AXI_CLK				81
+#define GCC_SYS_NOC_UFS_AXI_CLK					82
+#define GCC_CFG_NOC_AHB_CLK					83
+#define GCC_PERIPH_NOC_AHB_CLK					84
+#define GCC_PERIPH_NOC_USB20_AHB_CLK				85
+#define GCC_TIC_CLK						86
+#define GCC_IMEM_AXI_CLK					87
+#define GCC_MMSS_SYS_NOC_AXI_CLK				88
+#define GCC_MMSS_NOC_CFG_AHB_CLK				89
+#define GCC_MMSS_BIMC_GFX_CLK					90
+#define GCC_USB30_MASTER_CLK					91
+#define GCC_USB30_SLEEP_CLK					92
+#define GCC_USB30_MOCK_UTMI_CLK					93
+#define GCC_USB3_PHY_AUX_CLK					94
+#define GCC_USB3_PHY_PIPE_CLK					95
+#define GCC_USB20_MASTER_CLK					96
+#define GCC_USB20_SLEEP_CLK					97
+#define GCC_USB20_MOCK_UTMI_CLK					98
+#define GCC_USB_PHY_CFG_AHB2PHY_CLK				99
+#define GCC_SDCC1_APPS_CLK					100
+#define GCC_SDCC1_AHB_CLK					101
+#define GCC_SDCC1_ICE_CORE_CLK					102
+#define GCC_SDCC2_APPS_CLK					103
+#define GCC_SDCC2_AHB_CLK					104
+#define GCC_SDCC3_APPS_CLK					105
+#define GCC_SDCC3_AHB_CLK					106
+#define GCC_SDCC4_APPS_CLK					107
+#define GCC_SDCC4_AHB_CLK					108
+#define GCC_BLSP1_AHB_CLK					109
+#define GCC_BLSP1_SLEEP_CLK					110
+#define GCC_BLSP1_QUP1_SPI_APPS_CLK				111
+#define GCC_BLSP1_QUP1_I2C_APPS_CLK				112
+#define GCC_BLSP1_UART1_APPS_CLK				113
+#define GCC_BLSP1_QUP2_SPI_APPS_CLK				114
+#define GCC_BLSP1_QUP2_I2C_APPS_CLK				115
+#define GCC_BLSP1_UART2_APPS_CLK				116
+#define GCC_BLSP1_QUP3_SPI_APPS_CLK				117
+#define GCC_BLSP1_QUP3_I2C_APPS_CLK				118
+#define GCC_BLSP1_UART3_APPS_CLK				119
+#define GCC_BLSP1_QUP4_SPI_APPS_CLK				120
+#define GCC_BLSP1_QUP4_I2C_APPS_CLK				121
+#define GCC_BLSP1_UART4_APPS_CLK				122
+#define GCC_BLSP1_QUP5_SPI_APPS_CLK				123
+#define GCC_BLSP1_QUP5_I2C_APPS_CLK				124
+#define GCC_BLSP1_UART5_APPS_CLK				125
+#define GCC_BLSP1_QUP6_SPI_APPS_CLK				126
+#define GCC_BLSP1_QUP6_I2C_APPS_CLK				127
+#define GCC_BLSP1_UART6_APPS_CLK				128
+#define GCC_BLSP2_AHB_CLK					129
+#define GCC_BLSP2_SLEEP_CLK					130
+#define GCC_BLSP2_QUP1_SPI_APPS_CLK				131
+#define GCC_BLSP2_QUP1_I2C_APPS_CLK				132
+#define GCC_BLSP2_UART1_APPS_CLK				133
+#define GCC_BLSP2_QUP2_SPI_APPS_CLK				134
+#define GCC_BLSP2_QUP2_I2C_APPS_CLK				135
+#define GCC_BLSP2_UART2_APPS_CLK				136
+#define GCC_BLSP2_QUP3_SPI_APPS_CLK				137
+#define GCC_BLSP2_QUP3_I2C_APPS_CLK				138
+#define GCC_BLSP2_UART3_APPS_CLK				139
+#define GCC_BLSP2_QUP4_SPI_APPS_CLK				140
+#define GCC_BLSP2_QUP4_I2C_APPS_CLK				141
+#define GCC_BLSP2_UART4_APPS_CLK				142
+#define GCC_BLSP2_QUP5_SPI_APPS_CLK				143
+#define GCC_BLSP2_QUP5_I2C_APPS_CLK				144
+#define GCC_BLSP2_UART5_APPS_CLK				145
+#define GCC_BLSP2_QUP6_SPI_APPS_CLK				146
+#define GCC_BLSP2_QUP6_I2C_APPS_CLK				147
+#define GCC_BLSP2_UART6_APPS_CLK				148
+#define GCC_PDM_AHB_CLK						149
+#define GCC_PDM_XO4_CLK						150
+#define GCC_PDM2_CLK						151
+#define GCC_PRNG_AHB_CLK					152
+#define GCC_TSIF_AHB_CLK					153
+#define GCC_TSIF_REF_CLK					154
+#define GCC_TSIF_INACTIVITY_TIMERS_CLK				155
+#define GCC_TCSR_AHB_CLK					156
+#define GCC_BOOT_ROM_AHB_CLK					157
+#define GCC_MSG_RAM_AHB_CLK					158
+#define GCC_TLMM_AHB_CLK					159
+#define GCC_TLMM_CLK						160
+#define GCC_MPM_AHB_CLK						161
+#define GCC_SPMI_SER_CLK					162
+#define GCC_SPMI_CNOC_AHB_CLK					163
+#define GCC_CE1_CLK						164
+#define GCC_CE1_AXI_CLK						165
+#define GCC_CE1_AHB_CLK						166
+#define GCC_BIMC_HMSS_AXI_CLK					167
+#define GCC_BIMC_GFX_CLK					168
+#define GCC_HMSS_AHB_CLK					169
+#define GCC_HMSS_SLV_AXI_CLK					170
+#define GCC_HMSS_MSTR_AXI_CLK					171
+#define GCC_HMSS_RBCPR_CLK					172
+#define GCC_GP1_CLK						173
+#define GCC_GP2_CLK						174
+#define GCC_GP3_CLK						175
+#define GCC_PCIE_0_SLV_AXI_CLK					176
+#define GCC_PCIE_0_MSTR_AXI_CLK					177
+#define GCC_PCIE_0_CFG_AHB_CLK					178
+#define GCC_PCIE_0_AUX_CLK					179
+#define GCC_PCIE_0_PIPE_CLK					180
+#define GCC_PCIE_1_SLV_AXI_CLK					181
+#define GCC_PCIE_1_MSTR_AXI_CLK					182
+#define GCC_PCIE_1_CFG_AHB_CLK					183
+#define GCC_PCIE_1_AUX_CLK					184
+#define GCC_PCIE_1_PIPE_CLK					185
+#define GCC_PCIE_2_SLV_AXI_CLK					186
+#define GCC_PCIE_2_MSTR_AXI_CLK					187
+#define GCC_PCIE_2_CFG_AHB_CLK					188
+#define GCC_PCIE_2_AUX_CLK					189
+#define GCC_PCIE_2_PIPE_CLK					190
+#define GCC_PCIE_PHY_CFG_AHB_CLK				191
+#define GCC_PCIE_PHY_AUX_CLK					192
+#define GCC_UFS_AXI_CLK						193
+#define GCC_UFS_AHB_CLK						194
+#define GCC_UFS_TX_CFG_CLK					195
+#define GCC_UFS_RX_CFG_CLK					196
+#define GCC_UFS_TX_SYMBOL_0_CLK					197
+#define GCC_UFS_RX_SYMBOL_0_CLK					198
+#define GCC_UFS_RX_SYMBOL_1_CLK					199
+#define GCC_UFS_UNIPRO_CORE_CLK					200
+#define GCC_UFS_ICE_CORE_CLK					201
+#define GCC_UFS_SYS_CLK_CORE_CLK				202
+#define GCC_UFS_TX_SYMBOL_CLK_CORE_CLK				203
+#define GCC_AGGRE0_SNOC_AXI_CLK					204
+#define GCC_AGGRE0_CNOC_AHB_CLK					205
+#define GCC_SMMU_AGGRE0_AXI_CLK					206
+#define GCC_SMMU_AGGRE0_AHB_CLK					207
+#define GCC_AGGRE1_PNOC_AHB_CLK					208
+#define GCC_AGGRE2_UFS_AXI_CLK					209
+#define GCC_AGGRE2_USB3_AXI_CLK					210
+#define GCC_QSPI_AHB_CLK					211
+#define GCC_QSPI_SER_CLK					212
+#define GCC_USB3_CLKREF_CLK					213
+#define GCC_HDMI_CLKREF_CLK					214
+#define GCC_UFS_CLKREF_CLK					215
+#define GCC_PCIE_CLKREF_CLK					216
+#define GCC_RX2_USB2_CLKREF_CLK					217
+#define GCC_RX1_USB2_CLKREF_CLK					218
+#define GCC_HLOS1_VOTE_LPASS_CORE_SMMU_CLK			219
+#define GCC_HLOS1_VOTE_LPASS_ADSP_SMMU_CLK			220
+#define GCC_EDP_CLKREF_CLK					221
+#define GCC_MSS_CFG_AHB_CLK					222
+#define GCC_MSS_Q6_BIMC_AXI_CLK					223
+#define GCC_MSS_SNOC_AXI_CLK					224
+#define GCC_MSS_MNOC_BIMC_AXI_CLK				225
+#define GCC_DCC_AHB_CLK						226
+#define GCC_AGGRE0_NOC_MPU_CFG_AHB_CLK				227
+#define GCC_MMSS_GPLL0_DIV_CLK					228
+#define GCC_MSS_GPLL0_DIV_CLK					229
+
+#define GCC_SYSTEM_NOC_BCR					0
+#define GCC_CONFIG_NOC_BCR					1
+#define GCC_PERIPH_NOC_BCR					2
+#define GCC_IMEM_BCR						3
+#define GCC_MMSS_BCR						4
+#define GCC_PIMEM_BCR						5
+#define GCC_QDSS_BCR						6
+#define GCC_USB_30_BCR						7
+#define GCC_USB_20_BCR						8
+#define GCC_QUSB2PHY_PRIM_BCR					9
+#define GCC_QUSB2PHY_SEC_BCR					10
+#define GCC_USB_PHY_CFG_AHB2PHY_BCR				11
+#define GCC_SDCC1_BCR						12
+#define GCC_SDCC2_BCR						13
+#define GCC_SDCC3_BCR						14
+#define GCC_SDCC4_BCR						15
+#define GCC_BLSP1_BCR						16
+#define GCC_BLSP1_QUP1_BCR					17
+#define GCC_BLSP1_UART1_BCR					18
+#define GCC_BLSP1_QUP2_BCR					19
+#define GCC_BLSP1_UART2_BCR					20
+#define GCC_BLSP1_QUP3_BCR					21
+#define GCC_BLSP1_UART3_BCR					22
+#define GCC_BLSP1_QUP4_BCR					23
+#define GCC_BLSP1_UART4_BCR					24
+#define GCC_BLSP1_QUP5_BCR					25
+#define GCC_BLSP1_UART5_BCR					26
+#define GCC_BLSP1_QUP6_BCR					27
+#define GCC_BLSP1_UART6_BCR					28
+#define GCC_BLSP2_BCR						29
+#define GCC_BLSP2_QUP1_BCR					30
+#define GCC_BLSP2_UART1_BCR					31
+#define GCC_BLSP2_QUP2_BCR					32
+#define GCC_BLSP2_UART2_BCR					33
+#define GCC_BLSP2_QUP3_BCR					34
+#define GCC_BLSP2_UART3_BCR					35
+#define GCC_BLSP2_QUP4_BCR					36
+#define GCC_BLSP2_UART4_BCR					37
+#define GCC_BLSP2_QUP5_BCR					38
+#define GCC_BLSP2_UART5_BCR					39
+#define GCC_BLSP2_QUP6_BCR					40
+#define GCC_BLSP2_UART6_BCR					41
+#define GCC_PDM_BCR						42
+#define GCC_PRNG_BCR						43
+#define GCC_TSIF_BCR						44
+#define GCC_TCSR_BCR						45
+#define GCC_BOOT_ROM_BCR					46
+#define GCC_MSG_RAM_BCR						47
+#define GCC_TLMM_BCR						48
+#define GCC_MPM_BCR						49
+#define GCC_SEC_CTRL_BCR					50
+#define GCC_SPMI_BCR						51
+#define GCC_SPDM_BCR						52
+#define GCC_CE1_BCR						53
+#define GCC_BIMC_BCR						54
+#define GCC_SNOC_BUS_TIMEOUT0_BCR				55
+#define GCC_SNOC_BUS_TIMEOUT2_BCR				56
+#define GCC_SNOC_BUS_TIMEOUT1_BCR				57
+#define GCC_SNOC_BUS_TIMEOUT3_BCR				58
+#define GCC_SNOC_BUS_TIMEOUT_EXTREF_BCR				59
+#define GCC_PNOC_BUS_TIMEOUT0_BCR				60
+#define GCC_PNOC_BUS_TIMEOUT1_BCR				61
+#define GCC_PNOC_BUS_TIMEOUT2_BCR				62
+#define GCC_PNOC_BUS_TIMEOUT3_BCR				63
+#define GCC_PNOC_BUS_TIMEOUT4_BCR				64
+#define GCC_CNOC_BUS_TIMEOUT0_BCR				65
+#define GCC_CNOC_BUS_TIMEOUT1_BCR				66
+#define GCC_CNOC_BUS_TIMEOUT2_BCR				67
+#define GCC_CNOC_BUS_TIMEOUT3_BCR				68
+#define GCC_CNOC_BUS_TIMEOUT4_BCR				69
+#define GCC_CNOC_BUS_TIMEOUT5_BCR				70
+#define GCC_CNOC_BUS_TIMEOUT6_BCR				71
+#define GCC_CNOC_BUS_TIMEOUT7_BCR				72
+#define GCC_CNOC_BUS_TIMEOUT8_BCR				73
+#define GCC_CNOC_BUS_TIMEOUT9_BCR				74
+#define GCC_CNOC_BUS_TIMEOUT_EXTREF_BCR				75
+#define GCC_APB2JTAG_BCR					76
+#define GCC_RBCPR_CX_BCR					77
+#define GCC_RBCPR_MX_BCR					78
+#define GCC_PCIE_0_BCR						79
+#define GCC_PCIE_0_PHY_BCR					80
+#define GCC_PCIE_1_BCR						81
+#define GCC_PCIE_1_PHY_BCR					82
+#define GCC_PCIE_2_BCR						83
+#define GCC_PCIE_2_PHY_BCR					84
+#define GCC_PCIE_PHY_BCR					85
+#define GCC_DCD_BCR						86
+#define GCC_OBT_ODT_BCR						87
+#define GCC_UFS_BCR						88
+#define GCC_SSC_BCR						89
+#define GCC_VS_BCR						90
+#define GCC_AGGRE0_NOC_BCR					91
+#define GCC_AGGRE1_NOC_BCR					92
+#define GCC_AGGRE2_NOC_BCR					93
+#define GCC_DCC_BCR						94
+#define GCC_IPA_BCR						95
+#define GCC_QSPI_BCR						96
+#define GCC_SKL_BCR						97
+#define GCC_MSMPU_BCR						98
+#define GCC_MSS_Q6_BCR						99
+#define GCC_QREFS_VBG_CAL_BCR					100
+#define GCC_PCIE_PHY_COM_BCR					101
+#define GCC_PCIE_PHY_COM_NOCSR_BCR				102
+#define GCC_USB3_PHY_BCR					103
+#define GCC_USB3PHY_PHY_BCR					104
+#define GCC_MSS_RESTART						105
+
+
+/* Indexes for GDSCs */
+#define AGGRE0_NOC_GDSC			0
+#define HLOS1_VOTE_AGGRE0_NOC_GDSC	1
+#define HLOS1_VOTE_LPASS_ADSP_GDSC	2
+#define HLOS1_VOTE_LPASS_CORE_GDSC	3
+#define USB30_GDSC			4
+#define PCIE0_GDSC			5
+#define PCIE1_GDSC			6
+#define PCIE2_GDSC			7
+#define UFS_GDSC			8
+
+#endif
diff --git a/include/dt-bindings/clock/qcom,mmcc-msm8996.h b/include/dt-bindings/clock/qcom,mmcc-msm8996.h
new file mode 100644
index 000000000000..d51f9ac70566
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,mmcc-msm8996.h
@@ -0,0 +1,295 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2015, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_MSM_MMCC_8996_H
+#define _DT_BINDINGS_CLK_MSM_MMCC_8996_H
+
+#define MMPLL0_EARLY					0
+#define MMPLL0_PLL					1
+#define MMPLL1_EARLY					2
+#define MMPLL1_PLL					3
+#define MMPLL2_EARLY					4
+#define MMPLL2_PLL					5
+#define MMPLL3_EARLY					6
+#define MMPLL3_PLL					7
+#define MMPLL4_EARLY					8
+#define MMPLL4_PLL					9
+#define MMPLL5_EARLY					10
+#define MMPLL5_PLL					11
+#define MMPLL8_EARLY					12
+#define MMPLL8_PLL					13
+#define MMPLL9_EARLY					14
+#define MMPLL9_PLL					15
+#define AHB_CLK_SRC					16
+#define AXI_CLK_SRC					17
+#define MAXI_CLK_SRC					18
+#define DSA_CORE_CLK_SRC				19
+#define GFX3D_CLK_SRC					20
+#define RBBMTIMER_CLK_SRC				21
+#define ISENSE_CLK_SRC					22
+#define RBCPR_CLK_SRC					23
+#define VIDEO_CORE_CLK_SRC				24
+#define VIDEO_SUBCORE0_CLK_SRC				25
+#define VIDEO_SUBCORE1_CLK_SRC				26
+#define PCLK0_CLK_SRC					27
+#define PCLK1_CLK_SRC					28
+#define MDP_CLK_SRC					29
+#define EXTPCLK_CLK_SRC					30
+#define VSYNC_CLK_SRC					31
+#define HDMI_CLK_SRC					32
+#define BYTE0_CLK_SRC					33
+#define BYTE1_CLK_SRC					34
+#define ESC0_CLK_SRC					35
+#define ESC1_CLK_SRC					36
+#define CAMSS_GP0_CLK_SRC				37
+#define CAMSS_GP1_CLK_SRC				38
+#define MCLK0_CLK_SRC					39
+#define MCLK1_CLK_SRC					40
+#define MCLK2_CLK_SRC					41
+#define MCLK3_CLK_SRC					42
+#define CCI_CLK_SRC					43
+#define CSI0PHYTIMER_CLK_SRC				44
+#define CSI1PHYTIMER_CLK_SRC				45
+#define CSI2PHYTIMER_CLK_SRC				46
+#define CSIPHY0_3P_CLK_SRC				47
+#define CSIPHY1_3P_CLK_SRC				48
+#define CSIPHY2_3P_CLK_SRC				49
+#define JPEG0_CLK_SRC					50
+#define JPEG2_CLK_SRC					51
+#define JPEG_DMA_CLK_SRC				52
+#define VFE0_CLK_SRC					53
+#define VFE1_CLK_SRC					54
+#define CPP_CLK_SRC					55
+#define CSI0_CLK_SRC					56
+#define CSI1_CLK_SRC					57
+#define CSI2_CLK_SRC					58
+#define CSI3_CLK_SRC					59
+#define FD_CORE_CLK_SRC					60
+#define MMSS_CXO_CLK					61
+#define MMSS_SLEEPCLK_CLK				62
+#define MMSS_MMAGIC_AHB_CLK				63
+#define MMSS_MMAGIC_CFG_AHB_CLK				64
+#define MMSS_MISC_AHB_CLK				65
+#define MMSS_MISC_CXO_CLK				66
+#define MMSS_BTO_AHB_CLK				67
+#define MMSS_MMAGIC_AXI_CLK				68
+#define MMSS_S0_AXI_CLK					69
+#define MMSS_MMAGIC_MAXI_CLK				70
+#define DSA_CORE_CLK					71
+#define DSA_NOC_CFG_AHB_CLK				72
+#define MMAGIC_CAMSS_AXI_CLK				73
+#define MMAGIC_CAMSS_NOC_CFG_AHB_CLK			74
+#define THROTTLE_CAMSS_CXO_CLK				75
+#define THROTTLE_CAMSS_AHB_CLK				76
+#define THROTTLE_CAMSS_AXI_CLK				77
+#define SMMU_VFE_AHB_CLK				78
+#define SMMU_VFE_AXI_CLK				79
+#define SMMU_CPP_AHB_CLK				80
+#define SMMU_CPP_AXI_CLK				81
+#define SMMU_JPEG_AHB_CLK				82
+#define SMMU_JPEG_AXI_CLK				83
+#define MMAGIC_MDSS_AXI_CLK				84
+#define MMAGIC_MDSS_NOC_CFG_AHB_CLK			85
+#define THROTTLE_MDSS_CXO_CLK				86
+#define THROTTLE_MDSS_AHB_CLK				87
+#define THROTTLE_MDSS_AXI_CLK				88
+#define SMMU_ROT_AHB_CLK				89
+#define SMMU_ROT_AXI_CLK				90
+#define SMMU_MDP_AHB_CLK				91
+#define SMMU_MDP_AXI_CLK				92
+#define MMAGIC_VIDEO_AXI_CLK				93
+#define MMAGIC_VIDEO_NOC_CFG_AHB_CLK			94
+#define THROTTLE_VIDEO_CXO_CLK				95
+#define THROTTLE_VIDEO_AHB_CLK				96
+#define THROTTLE_VIDEO_AXI_CLK				97
+#define SMMU_VIDEO_AHB_CLK				98
+#define SMMU_VIDEO_AXI_CLK				99
+#define MMAGIC_BIMC_AXI_CLK				100
+#define MMAGIC_BIMC_NOC_CFG_AHB_CLK			101
+#define GPU_GX_GFX3D_CLK				102
+#define GPU_GX_RBBMTIMER_CLK				103
+#define GPU_AHB_CLK					104
+#define GPU_AON_ISENSE_CLK				105
+#define VMEM_MAXI_CLK					106
+#define VMEM_AHB_CLK					107
+#define MMSS_RBCPR_CLK					108
+#define MMSS_RBCPR_AHB_CLK				109
+#define VIDEO_CORE_CLK					110
+#define VIDEO_AXI_CLK					111
+#define VIDEO_MAXI_CLK					112
+#define VIDEO_AHB_CLK					113
+#define VIDEO_SUBCORE0_CLK				114
+#define VIDEO_SUBCORE1_CLK				115
+#define MDSS_AHB_CLK					116
+#define MDSS_HDMI_AHB_CLK				117
+#define MDSS_AXI_CLK					118
+#define MDSS_PCLK0_CLK					119
+#define MDSS_PCLK1_CLK					120
+#define MDSS_MDP_CLK					121
+#define MDSS_EXTPCLK_CLK				122
+#define MDSS_VSYNC_CLK					123
+#define MDSS_HDMI_CLK					124
+#define MDSS_BYTE0_CLK					125
+#define MDSS_BYTE1_CLK					126
+#define MDSS_ESC0_CLK					127
+#define MDSS_ESC1_CLK					128
+#define CAMSS_TOP_AHB_CLK				129
+#define CAMSS_AHB_CLK					130
+#define CAMSS_MICRO_AHB_CLK				131
+#define CAMSS_GP0_CLK					132
+#define CAMSS_GP1_CLK					133
+#define CAMSS_MCLK0_CLK					134
+#define CAMSS_MCLK1_CLK					135
+#define CAMSS_MCLK2_CLK					136
+#define CAMSS_MCLK3_CLK					137
+#define CAMSS_CCI_CLK					138
+#define CAMSS_CCI_AHB_CLK				139
+#define CAMSS_CSI0PHYTIMER_CLK				140
+#define CAMSS_CSI1PHYTIMER_CLK				141
+#define CAMSS_CSI2PHYTIMER_CLK				142
+#define CAMSS_CSIPHY0_3P_CLK				143
+#define CAMSS_CSIPHY1_3P_CLK				144
+#define CAMSS_CSIPHY2_3P_CLK				145
+#define CAMSS_JPEG0_CLK					146
+#define CAMSS_JPEG2_CLK					147
+#define CAMSS_JPEG_DMA_CLK				148
+#define CAMSS_JPEG_AHB_CLK				149
+#define CAMSS_JPEG_AXI_CLK				150
+#define CAMSS_VFE_AHB_CLK				151
+#define CAMSS_VFE_AXI_CLK				152
+#define CAMSS_VFE0_CLK					153
+#define CAMSS_VFE0_STREAM_CLK				154
+#define CAMSS_VFE0_AHB_CLK				155
+#define CAMSS_VFE1_CLK					156
+#define CAMSS_VFE1_STREAM_CLK				157
+#define CAMSS_VFE1_AHB_CLK				158
+#define CAMSS_CSI_VFE0_CLK				159
+#define CAMSS_CSI_VFE1_CLK				160
+#define CAMSS_CPP_VBIF_AHB_CLK				161
+#define CAMSS_CPP_AXI_CLK				162
+#define CAMSS_CPP_CLK					163
+#define CAMSS_CPP_AHB_CLK				164
+#define CAMSS_CSI0_CLK					165
+#define CAMSS_CSI0_AHB_CLK				166
+#define CAMSS_CSI0PHY_CLK				167
+#define CAMSS_CSI0RDI_CLK				168
+#define CAMSS_CSI0PIX_CLK				169
+#define CAMSS_CSI1_CLK					170
+#define CAMSS_CSI1_AHB_CLK				171
+#define CAMSS_CSI1PHY_CLK				172
+#define CAMSS_CSI1RDI_CLK				173
+#define CAMSS_CSI1PIX_CLK				174
+#define CAMSS_CSI2_CLK					175
+#define CAMSS_CSI2_AHB_CLK				176
+#define CAMSS_CSI2PHY_CLK				177
+#define CAMSS_CSI2RDI_CLK				178
+#define CAMSS_CSI2PIX_CLK				179
+#define CAMSS_CSI3_CLK					180
+#define CAMSS_CSI3_AHB_CLK				181
+#define CAMSS_CSI3PHY_CLK				182
+#define CAMSS_CSI3RDI_CLK				183
+#define CAMSS_CSI3PIX_CLK				184
+#define CAMSS_ISPIF_AHB_CLK				185
+#define FD_CORE_CLK					186
+#define FD_CORE_UAR_CLK					187
+#define FD_AHB_CLK					188
+#define MMSS_SPDM_CSI0_CLK				189
+#define MMSS_SPDM_JPEG_DMA_CLK				190
+#define MMSS_SPDM_CPP_CLK				191
+#define MMSS_SPDM_PCLK0_CLK				192
+#define MMSS_SPDM_AHB_CLK				193
+#define MMSS_SPDM_GFX3D_CLK				194
+#define MMSS_SPDM_PCLK1_CLK				195
+#define MMSS_SPDM_JPEG2_CLK				196
+#define MMSS_SPDM_DEBUG_CLK				197
+#define MMSS_SPDM_VFE1_CLK				198
+#define MMSS_SPDM_VFE0_CLK				199
+#define MMSS_SPDM_VIDEO_CORE_CLK			200
+#define MMSS_SPDM_AXI_CLK				201
+#define MMSS_SPDM_MDP_CLK				202
+#define MMSS_SPDM_JPEG0_CLK				203
+#define MMSS_SPDM_RM_AXI_CLK				204
+#define MMSS_SPDM_RM_MAXI_CLK				205
+
+#define MMAGICAHB_BCR					0
+#define MMAGIC_CFG_BCR					1
+#define MISC_BCR					2
+#define BTO_BCR						3
+#define MMAGICAXI_BCR					4
+#define MMAGICMAXI_BCR					5
+#define DSA_BCR						6
+#define MMAGIC_CAMSS_BCR				7
+#define THROTTLE_CAMSS_BCR				8
+#define SMMU_VFE_BCR					9
+#define SMMU_CPP_BCR					10
+#define SMMU_JPEG_BCR					11
+#define MMAGIC_MDSS_BCR					12
+#define THROTTLE_MDSS_BCR				13
+#define SMMU_ROT_BCR					14
+#define SMMU_MDP_BCR					15
+#define MMAGIC_VIDEO_BCR				16
+#define THROTTLE_VIDEO_BCR				17
+#define SMMU_VIDEO_BCR					18
+#define MMAGIC_BIMC_BCR					19
+#define GPU_GX_BCR					20
+#define GPU_BCR						21
+#define GPU_AON_BCR					22
+#define VMEM_BCR					23
+#define MMSS_RBCPR_BCR					24
+#define VIDEO_BCR					25
+#define MDSS_BCR					26
+#define CAMSS_TOP_BCR					27
+#define CAMSS_AHB_BCR					28
+#define CAMSS_MICRO_BCR					29
+#define CAMSS_CCI_BCR					30
+#define CAMSS_PHY0_BCR					31
+#define CAMSS_PHY1_BCR					32
+#define CAMSS_PHY2_BCR					33
+#define CAMSS_CSIPHY0_3P_BCR				34
+#define CAMSS_CSIPHY1_3P_BCR				35
+#define CAMSS_CSIPHY2_3P_BCR				36
+#define CAMSS_JPEG_BCR					37
+#define CAMSS_VFE_BCR					38
+#define CAMSS_VFE0_BCR					39
+#define CAMSS_VFE1_BCR					40
+#define CAMSS_CSI_VFE0_BCR				41
+#define CAMSS_CSI_VFE1_BCR				42
+#define CAMSS_CPP_TOP_BCR				43
+#define CAMSS_CPP_BCR					44
+#define CAMSS_CSI0_BCR					45
+#define CAMSS_CSI0RDI_BCR				46
+#define CAMSS_CSI0PIX_BCR				47
+#define CAMSS_CSI1_BCR					48
+#define CAMSS_CSI1RDI_BCR				49
+#define CAMSS_CSI1PIX_BCR				50
+#define CAMSS_CSI2_BCR					51
+#define CAMSS_CSI2RDI_BCR				52
+#define CAMSS_CSI2PIX_BCR				53
+#define CAMSS_CSI3_BCR					54
+#define CAMSS_CSI3RDI_BCR				55
+#define CAMSS_CSI3PIX_BCR				56
+#define CAMSS_ISPIF_BCR					57
+#define FD_BCR						58
+#define MMSS_SPDM_RM_BCR				59
+
+/* Indexes for GDSCs */
+#define MMAGIC_VIDEO_GDSC	0
+#define MMAGIC_MDSS_GDSC	1
+#define MMAGIC_CAMSS_GDSC	2
+#define GPU_GDSC		3
+#define VENUS_GDSC		4
+#define VENUS_CORE0_GDSC	5
+#define VENUS_CORE1_GDSC	6
+#define CAMSS_GDSC		7
+#define VFE0_GDSC		8
+#define VFE1_GDSC		9
+#define JPEG_GDSC		10
+#define CPP_GDSC		11
+#define FD_GDSC			12
+#define MDSS_GDSC		13
+#define GPU_GX_GDSC		14
+#define MMAGIC_BIMC_GDSC	15
+
+#endif
diff --git a/include/dt-bindings/interconnect/qcom,msm8996-cbf.h b/include/dt-bindings/interconnect/qcom,msm8996-cbf.h
new file mode 100644
index 000000000000..aac5e69f6bd5
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,msm8996-cbf.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2023 Linaro Ltd. All rights reserved.
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_MSM8996_CBF_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_MSM8996_CBF_H
+
+#define MASTER_CBF_M4M		0
+#define SLAVE_CBF_M4M		1
+
+#endif
diff --git a/include/dt-bindings/interconnect/qcom,msm8996.h b/include/dt-bindings/interconnect/qcom,msm8996.h
new file mode 100644
index 000000000000..a0b7c0ec7bed
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,msm8996.h
@@ -0,0 +1,163 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
+/*
+ * Qualcomm MSM8996 interconnect IDs
+ *
+ * Copyright (c) 2021 Yassine Oudjana <y.oudjana@protonmail.com>
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_MSM8996_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_MSM8996_H
+
+/* A0NOC */
+#define MASTER_PCIE_0			0
+#define MASTER_PCIE_1			1
+#define MASTER_PCIE_2			2
+
+/* A1NOC */
+#define MASTER_CNOC_A1NOC		0
+#define MASTER_CRYPTO_CORE0		1
+#define MASTER_PNOC_A1NOC		2
+
+/* A2NOC */
+#define MASTER_USB3			0
+#define MASTER_IPA			1
+#define MASTER_UFS			2
+
+/* BIMC */
+#define MASTER_AMPSS_M0			0
+#define MASTER_GRAPHICS_3D		1
+#define MASTER_MNOC_BIMC		2
+#define MASTER_SNOC_BIMC		3
+#define SLAVE_EBI_CH0			4
+#define SLAVE_HMSS_L3			5
+#define SLAVE_BIMC_SNOC_0		6
+#define SLAVE_BIMC_SNOC_1		7
+
+/* CNOC */
+#define MASTER_SNOC_CNOC		0
+#define MASTER_QDSS_DAP			1
+#define SLAVE_CNOC_A1NOC		2
+#define SLAVE_CLK_CTL			3
+#define SLAVE_TCSR			4
+#define SLAVE_TLMM			5
+#define SLAVE_CRYPTO_0_CFG		6
+#define SLAVE_MPM			7
+#define SLAVE_PIMEM_CFG			8
+#define SLAVE_IMEM_CFG			9
+#define SLAVE_MESSAGE_RAM		10
+#define SLAVE_BIMC_CFG			11
+#define SLAVE_PMIC_ARB			12
+#define SLAVE_PRNG			13
+#define SLAVE_DCC_CFG			14
+#define SLAVE_RBCPR_MX			15
+#define SLAVE_QDSS_CFG			16
+#define SLAVE_RBCPR_CX			17
+#define SLAVE_QDSS_RBCPR_APU		18
+#define SLAVE_CNOC_MNOC_CFG		19
+#define SLAVE_SNOC_CFG			20
+#define SLAVE_SNOC_MPU_CFG		21
+#define SLAVE_EBI1_PHY_CFG		22
+#define SLAVE_A0NOC_CFG			23
+#define SLAVE_PCIE_1_CFG		24
+#define SLAVE_PCIE_2_CFG		25
+#define SLAVE_PCIE_0_CFG		26
+#define SLAVE_PCIE20_AHB2PHY		27
+#define SLAVE_A0NOC_MPU_CFG		28
+#define SLAVE_UFS_CFG			29
+#define SLAVE_A1NOC_CFG			30
+#define SLAVE_A1NOC_MPU_CFG		31
+#define SLAVE_A2NOC_CFG			32
+#define SLAVE_A2NOC_MPU_CFG		33
+#define SLAVE_SSC_CFG			34
+#define SLAVE_A0NOC_SMMU_CFG		35
+#define SLAVE_A1NOC_SMMU_CFG		36
+#define SLAVE_A2NOC_SMMU_CFG		37
+#define SLAVE_LPASS_SMMU_CFG		38
+#define SLAVE_CNOC_MNOC_MMSS_CFG	39
+
+/* MNOC */
+#define MASTER_CNOC_MNOC_CFG		0
+#define MASTER_CPP			1
+#define MASTER_JPEG			2
+#define MASTER_MDP_PORT0		3
+#define MASTER_MDP_PORT1		4
+#define MASTER_ROTATOR			5
+#define MASTER_VIDEO_P0			6
+#define MASTER_VFE			7
+#define MASTER_SNOC_VMEM		8
+#define MASTER_VIDEO_P0_OCMEM		9
+#define MASTER_CNOC_MNOC_MMSS_CFG	10
+#define SLAVE_MNOC_BIMC			11
+#define SLAVE_VMEM			12
+#define SLAVE_SERVICE_MNOC		13
+#define SLAVE_MMAGIC_CFG		14
+#define SLAVE_CPR_CFG			15
+#define SLAVE_MISC_CFG			16
+#define SLAVE_VENUS_THROTTLE_CFG	17
+#define SLAVE_VENUS_CFG			18
+#define SLAVE_VMEM_CFG			19
+#define SLAVE_DSA_CFG			20
+#define SLAVE_MMSS_CLK_CFG		21
+#define SLAVE_DSA_MPU_CFG		22
+#define SLAVE_MNOC_MPU_CFG		23
+#define SLAVE_DISPLAY_CFG		24
+#define SLAVE_DISPLAY_THROTTLE_CFG	25
+#define SLAVE_CAMERA_CFG		26
+#define SLAVE_CAMERA_THROTTLE_CFG	27
+#define SLAVE_GRAPHICS_3D_CFG		28
+#define SLAVE_SMMU_MDP_CFG		29
+#define SLAVE_SMMU_ROT_CFG		30
+#define SLAVE_SMMU_VENUS_CFG		31
+#define SLAVE_SMMU_CPP_CFG		32
+#define SLAVE_SMMU_JPEG_CFG		33
+#define SLAVE_SMMU_VFE_CFG		34
+
+/* PNOC */
+#define MASTER_SNOC_PNOC		0
+#define MASTER_SDCC_1			1
+#define MASTER_SDCC_2			2
+#define MASTER_SDCC_4			3
+#define MASTER_USB_HS			4
+#define MASTER_BLSP_1			5
+#define MASTER_BLSP_2			6
+#define MASTER_TSIF			7
+#define SLAVE_PNOC_A1NOC		8
+#define SLAVE_USB_HS			9
+#define SLAVE_SDCC_2			10
+#define SLAVE_SDCC_4			11
+#define SLAVE_TSIF			12
+#define SLAVE_BLSP_2			13
+#define SLAVE_SDCC_1			14
+#define SLAVE_BLSP_1			15
+#define SLAVE_PDM			16
+#define SLAVE_AHB2PHY			17
+
+/* SNOC */
+#define MASTER_HMSS			0
+#define MASTER_QDSS_BAM			1
+#define MASTER_SNOC_CFG			2
+#define MASTER_BIMC_SNOC_0		3
+#define MASTER_BIMC_SNOC_1		4
+#define MASTER_A0NOC_SNOC		5
+#define MASTER_A1NOC_SNOC		6
+#define MASTER_A2NOC_SNOC		7
+#define MASTER_QDSS_ETR			8
+#define SLAVE_A0NOC_SNOC		9
+#define SLAVE_A1NOC_SNOC		10
+#define SLAVE_A2NOC_SNOC		11
+#define SLAVE_HMSS			12
+#define SLAVE_LPASS			13
+#define SLAVE_USB3			14
+#define SLAVE_SNOC_BIMC			15
+#define SLAVE_SNOC_CNOC			16
+#define SLAVE_IMEM			17
+#define SLAVE_PIMEM			18
+#define SLAVE_SNOC_VMEM			19
+#define SLAVE_SNOC_PNOC			20
+#define SLAVE_QDSS_STM			21
+#define SLAVE_PCIE_0			22
+#define SLAVE_PCIE_1			23
+#define SLAVE_PCIE_2			24
+#define SLAVE_SERVICE_SNOC		25
+
+#endif

-- 
2.42.1

