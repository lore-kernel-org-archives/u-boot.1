Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69EBC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 10:50:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71BD387923;
	Mon,  4 Dec 2023 11:49:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0fnsEyJj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2754E877FF; Mon,  4 Dec 2023 11:49:03 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E74087896
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 11:48:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmasson@baylibre.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33338c47134so1689939f8f.1
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 02:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701686937; x=1702291737;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:references:date
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+IlGredFXOhbN4aEwM5663Vtz8G4rs/HoVw1cpwgt9A=;
 b=0fnsEyJjfb+suWrxF9u5xwj3Upm4XLYvirDvIVWhkgssQRamnIUlcdMUNT4F2ujkAY
 cUj8DUi97r4eMYD2sDKC/oSBV2DDcySvHXHTb60XDVVt4DfjxSnmIIyfJcvCLKsnCfKX
 VDaMymNkMARPUg83qYnwC8ekYjDsUdTsLZM8hEr3f+9Oat/58KY6GURaDdXmWGHy1IA1
 ul+OIar5r3LZJgp36RaYteRiLUssVSKGBhk1DOnIaqePoGHHFchl5FiQiCx1L0bpkBmZ
 voXcj7166r5qCRsjUewB9uTqSwReQ83hyqIuNv9FTaKTec/n39mIOXbhKN/uU62UR8IW
 0HgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701686937; x=1702291737;
 h=content-transfer-encoding:mime-version:message-id:references:date
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+IlGredFXOhbN4aEwM5663Vtz8G4rs/HoVw1cpwgt9A=;
 b=egUIxtRAqN73p8/boyAFJ5dX7jVDWE66sS2tgruh3jAzShFX3ocMdYprbTwSvv1xaY
 +xH9U9EuVY6ou/KLf7iN5cNQum+bCjkzISKlLumbG1tJYS8VBzNj2V0+dvRzoUzZ5UuY
 GO14WwhdOQZQ9qyC2eqquDv8LfFyXNUzfYzdYYNIb6cKOJjbXbXEbwxSW3LZvYo00wja
 RDR3203anyrGgGBUrF8+KqRvoGFzORRpj7+HpfFggucOqH06PiDDBlA5VFtHZTh3NH9W
 dwOpndFR8r3jM/6CszftivCVEqlk3J2mF+Er3S4xeZ2/JBGhDWZlJDvWLE1TNkenjycG
 u4hA==
X-Gm-Message-State: AOJu0YwtEyhOjLB7jqpLyAUEwbvl7FGzNXb+T/EyFhjBgNkd4pb8Ua0V
 9azcXG2cHR5MG1G8g8PNrz6SYYuyoQhgLnpTHG2keg==
X-Google-Smtp-Source: AGHT+IHvJByrdz4vXTBsxmeDATMAMxMaWBd2/Gnpr6QoaKstM6qvC7w6x5GVSYhGr47kiMojmkwRsA==
X-Received: by 2002:a5d:5607:0:b0:333:2fd2:6f6e with SMTP id
 l7-20020a5d5607000000b003332fd26f6emr3135666wrv.120.1701686936657; 
 Mon, 04 Dec 2023 02:48:56 -0800 (PST)
Received: from localhost ([2a04:cec2:b:6009:c298:6724:4971:1296])
 by smtp.gmail.com with ESMTPSA id
 a7-20020a5d5087000000b003333cb59d69sm5681823wrt.35.2023.12.04.02.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 02:48:56 -0800 (PST)
From: Julien Masson <jmasson@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Chunfeng
 Yun <chunfeng.yun@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Sean Anderson <seanga2@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Vitor Sato Eschholz
 <vsatoes@baylibre.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH 4/6] arm: mediatek: add support for MediaTek MT8365 SoC
In-Reply-To: <87plzm450u.fsf@baylibre.com>
Date: Mon,  4 Dec 2023 11:48:55 +0100
References: <87plzm450u.fsf@baylibre.com>
Message-ID: <87jzpu450o.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

This patch adds basic support for MediaTek MT8365 SoC.
The dtsi has been copied from Linux source code tag v6.7-rc2.
(commit 9b5d64654ea8f51fe1e8e29ca1777b620be8fb7c)

Signed-off-by: Julien Masson <jmasson@baylibre.com>
---
 arch/arm/dts/mt8365.dtsi               | 840 +++++++++++++++++++++++++
 arch/arm/mach-mediatek/Kconfig         |   9 +
 arch/arm/mach-mediatek/Makefile        |   1 +
 arch/arm/mach-mediatek/mt8365/Makefile |   3 +
 arch/arm/mach-mediatek/mt8365/init.c   |  51 ++
 include/configs/mt8365.h               |  12 +
 6 files changed, 916 insertions(+)
 create mode 100644 arch/arm/dts/mt8365.dtsi
 create mode 100644 arch/arm/mach-mediatek/mt8365/Makefile
 create mode 100644 arch/arm/mach-mediatek/mt8365/init.c
 create mode 100644 include/configs/mt8365.h

diff --git a/arch/arm/dts/mt8365.dtsi b/arch/arm/dts/mt8365.dtsi
new file mode 100644
index 0000000000..24581f7410
--- /dev/null
+++ b/arch/arm/dts/mt8365.dtsi
@@ -0,0 +1,840 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * (C) 2018 MediaTek Inc.
+ * Copyright (C) 2022 BayLibre SAS
+ * Fabien Parent <fparent@baylibre.com>
+ * Bernhard Rosenkr=C3=A4nzer <bero@baylibre.com>
+ */
+#include <dt-bindings/clock/mediatek,mt8365-clk.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/power/mediatek,mt8365-power.h>
+
+/ {
+	compatible =3D "mediatek,mt8365";
+	interrupt-parent =3D <&sysirq>;
+	#address-cells =3D <2>;
+	#size-cells =3D <2>;
+
+	cpus {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+
+	cluster0_opp: opp-table-0 {
+		compatible =3D "operating-points-v2";
+		opp-shared;
+
+		opp-850000000 {
+			opp-hz =3D /bits/ 64 <850000000>;
+			opp-microvolt =3D <650000>;
+		};
+
+		opp-918000000 {
+			opp-hz =3D /bits/ 64 <918000000>;
+			opp-microvolt =3D <668750>;
+		};
+
+		opp-987000000 {
+			opp-hz =3D /bits/ 64 <987000000>;
+			opp-microvolt =3D <687500>;
+		};
+
+		opp-1056000000 {
+			opp-hz =3D /bits/ 64 <1056000000>;
+			opp-microvolt =3D <706250>;
+		};
+
+		opp-1125000000 {
+			opp-hz =3D /bits/ 64 <1125000000>;
+			opp-microvolt =3D <725000>;
+		};
+
+		opp-1216000000 {
+			opp-hz =3D /bits/ 64 <1216000000>;
+			opp-microvolt =3D <750000>;
+		};
+
+		opp-1308000000 {
+			opp-hz =3D /bits/ 64 <1308000000>;
+			opp-microvolt =3D <775000>;
+		};
+
+		opp-1400000000 {
+			opp-hz =3D /bits/ 64 <1400000000>;
+			opp-microvolt =3D <800000>;
+		};
+
+		opp-1466000000 {
+			opp-hz =3D /bits/ 64 <1466000000>;
+			opp-microvolt =3D <825000>;
+		};
+
+		opp-1533000000 {
+			opp-hz =3D /bits/ 64 <1533000000>;
+			opp-microvolt =3D <850000>;
+		};
+
+		opp-1633000000 {
+			opp-hz =3D /bits/ 64 <1633000000>;
+			opp-microvolt =3D <887500>;
+		};
+
+		opp-1700000000 {
+			opp-hz =3D /bits/ 64 <1700000000>;
+			opp-microvolt =3D <912500>;
+		};
+
+		opp-1767000000 {
+			opp-hz =3D /bits/ 64 <1767000000>;
+			opp-microvolt =3D <937500>;
+		};
+
+		opp-1834000000 {
+			opp-hz =3D /bits/ 64 <1834000000>;
+			opp-microvolt =3D <962500>;
+		};
+
+		opp-1917000000 {
+			opp-hz =3D /bits/ 64 <1917000000>;
+			opp-microvolt =3D <993750>;
+		};
+
+		opp-2001000000 {
+			opp-hz =3D /bits/ 64 <2001000000>;
+			opp-microvolt =3D <1025000>;
+		};
+	};
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu =3D <&cpu0>;
+				};
+				core1 {
+					cpu =3D <&cpu1>;
+				};
+				core2 {
+					cpu =3D <&cpu2>;
+				};
+				core3 {
+					cpu =3D <&cpu3>;
+				};
+			};
+		};
+
+		cpu0: cpu@0 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a53";
+			reg =3D <0x0>;
+			#cooling-cells =3D <2>;
+			enable-method =3D "psci";
+			cpu-idle-states =3D <&CPU_MCDI &CLUSTER_MCDI &CLUSTER_DPIDLE>;
+			i-cache-size =3D <0x8000>;
+			i-cache-line-size =3D <64>;
+			i-cache-sets =3D <256>;
+			d-cache-size =3D <0x8000>;
+			d-cache-line-size =3D <64>;
+			d-cache-sets =3D <256>;
+			next-level-cache =3D <&l2>;
+			clocks =3D <&mcucfg CLK_MCU_BUS_SEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names =3D "cpu", "intermediate";
+			operating-points-v2 =3D <&cluster0_opp>;
+		};
+
+		cpu1: cpu@1 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a53";
+			reg =3D <0x1>;
+			#cooling-cells =3D <2>;
+			enable-method =3D "psci";
+			cpu-idle-states =3D <&CPU_MCDI &CLUSTER_MCDI &CLUSTER_DPIDLE>;
+			i-cache-size =3D <0x8000>;
+			i-cache-line-size =3D <64>;
+			i-cache-sets =3D <256>;
+			d-cache-size =3D <0x8000>;
+			d-cache-line-size =3D <64>;
+			d-cache-sets =3D <256>;
+			next-level-cache =3D <&l2>;
+			clocks =3D <&mcucfg CLK_MCU_BUS_SEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names =3D "cpu", "intermediate", "armpll";
+			operating-points-v2 =3D <&cluster0_opp>;
+		};
+
+		cpu2: cpu@2 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a53";
+			reg =3D <0x2>;
+			#cooling-cells =3D <2>;
+			enable-method =3D "psci";
+			cpu-idle-states =3D <&CPU_MCDI &CLUSTER_MCDI &CLUSTER_DPIDLE>;
+			i-cache-size =3D <0x8000>;
+			i-cache-line-size =3D <64>;
+			i-cache-sets =3D <256>;
+			d-cache-size =3D <0x8000>;
+			d-cache-line-size =3D <64>;
+			d-cache-sets =3D <256>;
+			next-level-cache =3D <&l2>;
+			clocks =3D <&mcucfg CLK_MCU_BUS_SEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names =3D "cpu", "intermediate", "armpll";
+			operating-points-v2 =3D <&cluster0_opp>;
+		};
+
+		cpu3: cpu@3 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a53";
+			reg =3D <0x3>;
+			#cooling-cells =3D <2>;
+			enable-method =3D "psci";
+			cpu-idle-states =3D <&CPU_MCDI &CLUSTER_MCDI &CLUSTER_DPIDLE>;
+			i-cache-size =3D <0x8000>;
+			i-cache-line-size =3D <64>;
+			i-cache-sets =3D <256>;
+			d-cache-size =3D <0x8000>;
+			d-cache-line-size =3D <64>;
+			d-cache-sets =3D <256>;
+			next-level-cache =3D <&l2>;
+			clocks =3D <&mcucfg CLK_MCU_BUS_SEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names =3D "cpu", "intermediate", "armpll";
+			operating-points-v2 =3D <&cluster0_opp>;
+		};
+
+		idle-states {
+			entry-method =3D "psci";
+
+			CPU_MCDI: cpu-mcdi {
+				compatible =3D "arm,idle-state";
+				local-timer-stop;
+				arm,psci-suspend-param =3D <0x00010001>;
+				entry-latency-us =3D <300>;
+				exit-latency-us =3D <200>;
+				min-residency-us =3D <1000>;
+			};
+
+			CLUSTER_MCDI: cluster-mcdi {
+				compatible =3D "arm,idle-state";
+				local-timer-stop;
+				arm,psci-suspend-param =3D <0x01010001>;
+				entry-latency-us =3D <350>;
+				exit-latency-us =3D <250>;
+				min-residency-us =3D <1200>;
+			};
+
+			CLUSTER_DPIDLE: cluster-dpidle {
+				compatible =3D "arm,idle-state";
+				local-timer-stop;
+				arm,psci-suspend-param =3D <0x01010004>;
+				entry-latency-us =3D <300>;
+				exit-latency-us =3D <800>;
+				min-residency-us =3D <3300>;
+			};
+		};
+
+		l2: l2-cache {
+			compatible =3D "cache";
+			cache-level =3D <2>;
+			cache-size =3D <0x80000>;
+			cache-line-size =3D <64>;
+			cache-sets =3D <512>;
+			cache-unified;
+		};
+	};
+
+	clk26m: oscillator {
+		compatible =3D "fixed-clock";
+		#clock-cells =3D <0>;
+		clock-frequency =3D <26000000>;
+		clock-output-names =3D "clk26m";
+	};
+
+	psci {
+		compatible =3D "arm,psci-1.0";
+		method =3D "smc";
+	};
+
+	soc {
+		#address-cells =3D <2>;
+		#size-cells =3D <2>;
+		compatible =3D "simple-bus";
+		ranges;
+
+		gic: interrupt-controller@c000000 {
+			compatible =3D "arm,gic-v3";
+			#interrupt-cells =3D <3>;
+			interrupt-parent =3D <&gic>;
+			interrupt-controller;
+			reg =3D <0 0x0c000000 0 0x10000>, /* GICD */
+			      <0 0x0c080000 0 0x80000>, /* GICR */
+			      <0 0x0c400000 0 0x2000>,  /* GICC */
+			      <0 0x0c410000 0 0x1000>,  /* GICH */
+			      <0 0x0c420000 0 0x2000>;  /* GICV */
+
+			interrupts =3D <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		topckgen: syscon@10000000 {
+			compatible =3D "mediatek,mt8365-topckgen", "syscon";
+			reg =3D <0 0x10000000 0 0x1000>;
+			#clock-cells =3D <1>;
+		};
+
+		infracfg: syscon@10001000 {
+			compatible =3D "mediatek,mt8365-infracfg", "syscon";
+			reg =3D <0 0x10001000 0 0x1000>;
+			#clock-cells =3D <1>;
+		};
+
+		pericfg: syscon@10003000 {
+			compatible =3D "mediatek,mt8365-pericfg", "syscon";
+			reg =3D <0 0x10003000 0 0x1000>;
+			#clock-cells =3D <1>;
+		};
+
+		syscfg_pctl: syscfg-pctl@10005000 {
+			compatible =3D "mediatek,mt8365-syscfg", "syscon";
+			reg =3D <0 0x10005000 0 0x1000>;
+		};
+
+		scpsys: syscon@10006000 {
+			compatible =3D "mediatek,mt8365-syscfg", "syscon", "simple-mfd";
+			reg =3D <0 0x10006000 0 0x1000>;
+			#power-domain-cells =3D <1>;
+
+			/* System Power Manager */
+			spm: power-controller {
+				compatible =3D "mediatek,mt8365-power-controller";
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				#power-domain-cells =3D <1>;
+
+				/* power domains of the SoC */
+				power-domain@MT8365_POWER_DOMAIN_MM {
+					reg =3D <MT8365_POWER_DOMAIN_MM>;
+					clocks =3D <&topckgen CLK_TOP_MM_SEL>,
+						 <&mmsys CLK_MM_MM_SMI_COMMON>,
+						 <&mmsys CLK_MM_MM_SMI_COMM0>,
+						 <&mmsys CLK_MM_MM_SMI_COMM1>,
+						 <&mmsys CLK_MM_MM_SMI_LARB0>;
+					clock-names =3D "mm", "mm-0", "mm-1",
+						      "mm-2", "mm-3";
+					#power-domain-cells =3D <0>;
+					mediatek,infracfg =3D <&infracfg>;
+					mediatek,infracfg-nao =3D <&infracfg_nao>;
+					#address-cells =3D <1>;
+					#size-cells =3D <0>;
+
+					power-domain@MT8365_POWER_DOMAIN_CAM {
+						reg =3D <MT8365_POWER_DOMAIN_CAM>;
+						clocks =3D <&camsys CLK_CAM_LARB2>,
+							 <&camsys CLK_CAM_SENIF>,
+							 <&camsys CLK_CAMSV0>,
+							 <&camsys CLK_CAMSV1>,
+							 <&camsys CLK_CAM_FDVT>,
+							 <&camsys CLK_CAM_WPE>;
+						clock-names =3D "cam-0", "cam-1",
+							      "cam-2", "cam-3",
+							      "cam-4", "cam-5";
+						#power-domain-cells =3D <0>;
+						mediatek,infracfg =3D <&infracfg>;
+						mediatek,smi =3D <&smi_common>;
+					};
+
+					power-domain@MT8365_POWER_DOMAIN_VDEC {
+						reg =3D <MT8365_POWER_DOMAIN_VDEC>;
+						#power-domain-cells =3D <0>;
+						mediatek,smi =3D <&smi_common>;
+					};
+
+					power-domain@MT8365_POWER_DOMAIN_VENC {
+						reg =3D <MT8365_POWER_DOMAIN_VENC>;
+						#power-domain-cells =3D <0>;
+						mediatek,smi =3D <&smi_common>;
+					};
+
+					power-domain@MT8365_POWER_DOMAIN_APU {
+						reg =3D <MT8365_POWER_DOMAIN_APU>;
+						clocks =3D <&infracfg CLK_IFR_APU_AXI>,
+							 <&apu CLK_APU_IPU_CK>,
+							 <&apu CLK_APU_AXI>,
+							 <&apu CLK_APU_JTAG>,
+							 <&apu CLK_APU_IF_CK>,
+							 <&apu CLK_APU_EDMA>,
+							 <&apu CLK_APU_AHB>;
+						clock-names =3D "apu", "apu-0",
+							      "apu-1", "apu-2",
+							      "apu-3", "apu-4",
+							      "apu-5";
+						#power-domain-cells =3D <0>;
+						mediatek,infracfg =3D <&infracfg>;
+						mediatek,smi =3D <&smi_common>;
+					};
+				};
+
+				power-domain@MT8365_POWER_DOMAIN_CONN {
+					reg =3D <MT8365_POWER_DOMAIN_CONN>;
+					clocks =3D <&topckgen CLK_TOP_CONN_32K>,
+						 <&topckgen CLK_TOP_CONN_26M>;
+					clock-names =3D "conn", "conn1";
+					#power-domain-cells =3D <0>;
+					mediatek,infracfg =3D <&infracfg>;
+				};
+
+				power-domain@MT8365_POWER_DOMAIN_MFG {
+					reg =3D <MT8365_POWER_DOMAIN_MFG>;
+					clocks =3D <&topckgen CLK_TOP_MFG_SEL>;
+					clock-names =3D "mfg";
+					#power-domain-cells =3D <0>;
+					mediatek,infracfg =3D <&infracfg>;
+				};
+
+				power-domain@MT8365_POWER_DOMAIN_AUDIO {
+					reg =3D <MT8365_POWER_DOMAIN_AUDIO>;
+					clocks =3D <&topckgen CLK_TOP_AUD_INTBUS_SEL>,
+						 <&infracfg CLK_IFR_AUDIO>,
+						 <&infracfg CLK_IFR_AUD_26M_BK>;
+					clock-names =3D "audio", "audio1", "audio2";
+					#power-domain-cells =3D <0>;
+					mediatek,infracfg =3D <&infracfg>;
+				};
+
+				power-domain@MT8365_POWER_DOMAIN_DSP {
+					reg =3D <MT8365_POWER_DOMAIN_DSP>;
+					clocks =3D <&topckgen CLK_TOP_DSP_SEL>,
+						 <&topckgen CLK_TOP_DSP_26M>;
+					clock-names =3D "dsp", "dsp1";
+					#power-domain-cells =3D <0>;
+					mediatek,infracfg =3D <&infracfg>;
+				};
+			};
+		};
+
+		watchdog: watchdog@10007000 {
+			compatible =3D "mediatek,mt8365-wdt", "mediatek,mt6589-wdt";
+			reg =3D <0 0x10007000 0 0x100>;
+			#reset-cells =3D <1>;
+		};
+
+		pio: pinctrl@1000b000 {
+			compatible =3D "mediatek,mt8365-pinctrl";
+			reg =3D <0 0x1000b000 0 0x1000>;
+			mediatek,pctl-regmap =3D <&syscfg_pctl>;
+			gpio-controller;
+			#gpio-cells =3D <2>;
+			interrupt-controller;
+			#interrupt-cells =3D <2>;
+			interrupts =3D <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		apmixedsys: syscon@1000c000 {
+			compatible =3D "mediatek,mt8365-apmixedsys", "syscon";
+			reg =3D <0 0x1000c000 0 0x1000>;
+			#clock-cells =3D <1>;
+		};
+
+		pwrap: pwrap@1000d000 {
+			compatible =3D "mediatek,mt8365-pwrap";
+			reg =3D <0 0x1000d000 0 0x1000>;
+			reg-names =3D "pwrap";
+			interrupts =3D <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&infracfg CLK_IFR_PWRAP_SPI>,
+				 <&infracfg CLK_IFR_PMIC_AP>,
+				 <&infracfg CLK_IFR_PWRAP_SYS>,
+				 <&infracfg CLK_IFR_PWRAP_TMR>;
+			clock-names =3D "spi", "wrap", "sys", "tmr";
+		};
+
+		keypad: keypad@10010000 {
+			compatible =3D "mediatek,mt6779-keypad";
+			reg =3D <0 0x10010000 0 0x1000>;
+			wakeup-source;
+			interrupts =3D <GIC_SPI 124 IRQ_TYPE_EDGE_FALLING>;
+			clocks =3D <&clk26m>;
+			clock-names =3D "kpd";
+			status =3D "disabled";
+		};
+
+		mcucfg: syscon@10200000 {
+			compatible =3D "mediatek,mt8365-mcucfg", "syscon";
+			reg =3D <0 0x10200000 0 0x2000>;
+			#clock-cells =3D <1>;
+		};
+
+		sysirq: interrupt-controller@10200a80 {
+			compatible =3D "mediatek,mt8365-sysirq", "mediatek,mt6577-sysirq";
+			interrupt-controller;
+			#interrupt-cells =3D <3>;
+			interrupt-parent =3D <&gic>;
+			reg =3D <0 0x10200a80 0 0x20>;
+		};
+
+		iommu: iommu@10205000 {
+			compatible =3D "mediatek,mt8365-m4u";
+			reg =3D <0 0x10205000 0 0x1000>;
+			interrupts =3D <GIC_SPI 102 IRQ_TYPE_LEVEL_LOW>;
+			mediatek,larbs =3D <&larb0>, <&larb1>, <&larb2>, <&larb3>;
+			#iommu-cells =3D <1>;
+		};
+
+		infracfg_nao: infracfg@1020e000 {
+			compatible =3D "mediatek,mt8365-infracfg", "syscon";
+			reg =3D <0 0x1020e000 0 0x1000>;
+			#clock-cells =3D <1>;
+		};
+
+		rng: rng@1020f000 {
+			compatible =3D "mediatek,mt8365-rng", "mediatek,mt7623-rng";
+			reg =3D <0 0x1020f000 0 0x100>;
+			clocks =3D <&infracfg CLK_IFR_TRNG>;
+			clock-names =3D "rng";
+		};
+
+		apdma: dma-controller@11000280 {
+			compatible =3D "mediatek,mt8365-uart-dma", "mediatek,mt6577-uart-dma";
+			reg =3D <0 0x11000280 0 0x80>,
+			      <0 0x11000300 0 0x80>,
+			      <0 0x11000380 0 0x80>,
+			      <0 0x11000400 0 0x80>,
+			      <0 0x11000580 0 0x80>,
+			      <0 0x11000600 0 0x80>;
+			interrupts =3D <GIC_SPI 45 IRQ_TYPE_LEVEL_LOW>,
+				     <GIC_SPI 46 IRQ_TYPE_LEVEL_LOW>,
+				     <GIC_SPI 47 IRQ_TYPE_LEVEL_LOW>,
+				     <GIC_SPI 48 IRQ_TYPE_LEVEL_LOW>,
+				     <GIC_SPI 51 IRQ_TYPE_LEVEL_LOW>,
+				     <GIC_SPI 52 IRQ_TYPE_LEVEL_LOW>;
+			dma-requests =3D <6>;
+			clocks =3D <&infracfg CLK_IFR_AP_DMA>;
+			clock-names =3D "apdma";
+			#dma-cells =3D <1>;
+		};
+
+		uart0: serial@11002000 {
+			compatible =3D "mediatek,mt8365-uart", "mediatek,mt6577-uart";
+			reg =3D <0 0x11002000 0 0x1000>;
+			interrupts =3D <GIC_SPI 35 IRQ_TYPE_LEVEL_LOW>;
+			clocks =3D <&clk26m>, <&infracfg CLK_IFR_UART0>;
+			clock-names =3D "baud", "bus";
+			dmas =3D <&apdma 0>, <&apdma 1>;
+			dma-names =3D "tx", "rx";
+			status =3D "disabled";
+		};
+
+		uart1: serial@11003000 {
+			compatible =3D "mediatek,mt8365-uart", "mediatek,mt6577-uart";
+			reg =3D <0 0x11003000 0 0x1000>;
+			interrupts =3D <GIC_SPI 36 IRQ_TYPE_LEVEL_LOW>;
+			clocks =3D <&clk26m>, <&infracfg CLK_IFR_UART1>;
+			clock-names =3D "baud", "bus";
+			dmas =3D <&apdma 2>, <&apdma 3>;
+			dma-names =3D "tx", "rx";
+			status =3D "disabled";
+		};
+
+		uart2: serial@11004000 {
+			compatible =3D "mediatek,mt8365-uart", "mediatek,mt6577-uart";
+			reg =3D <0 0x11004000 0 0x1000>;
+			interrupts =3D <GIC_SPI 37 IRQ_TYPE_LEVEL_LOW>;
+			clocks =3D <&clk26m>, <&infracfg CLK_IFR_UART2>;
+			clock-names =3D "baud", "bus";
+			dmas =3D <&apdma 4>, <&apdma 5>;
+			dma-names =3D "tx", "rx";
+			status =3D "disabled";
+		};
+
+		pwm: pwm@11006000 {
+			compatible =3D "mediatek,mt8365-pwm";
+			reg =3D <0 0x11006000 0 0x1000>;
+			#pwm-cells =3D <2>;
+			interrupts =3D <GIC_SPI 76 IRQ_TYPE_LEVEL_LOW>;
+			clocks =3D <&infracfg CLK_IFR_PWM_HCLK>,
+				 <&infracfg CLK_IFR_PWM>,
+				 <&infracfg CLK_IFR_PWM1>,
+				 <&infracfg CLK_IFR_PWM2>,
+				 <&infracfg CLK_IFR_PWM3>;
+			clock-names =3D "top", "main", "pwm1", "pwm2", "pwm3";
+		};
+
+		i2c0: i2c@11007000 {
+			compatible =3D "mediatek,mt8365-i2c", "mediatek,mt8168-i2c";
+			reg =3D <0 0x11007000 0 0xa0>, <0 0x11000080 0 0x80>;
+			interrupts =3D <GIC_SPI 28 IRQ_TYPE_LEVEL_LOW>;
+			clock-div =3D <1>;
+			clocks =3D <&infracfg CLK_IFR_I2C0_AXI>, <&infracfg CLK_IFR_AP_DMA>;
+			clock-names =3D "main", "dma";
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		i2c1: i2c@11008000 {
+			compatible =3D "mediatek,mt8365-i2c", "mediatek,mt8168-i2c";
+			reg =3D <0 0x11008000 0 0xa0>, <0 0x11000100 0 0x80>;
+			interrupts =3D <GIC_SPI 29 IRQ_TYPE_LEVEL_LOW>;
+			clock-div =3D <1>;
+			clocks =3D <&infracfg CLK_IFR_I2C1_AXI>, <&infracfg CLK_IFR_AP_DMA>;
+			clock-names =3D "main", "dma";
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		i2c2: i2c@11009000 {
+			compatible =3D "mediatek,mt8365-i2c", "mediatek,mt8168-i2c";
+			reg =3D <0 0x11009000 0 0xa0>, <0 0x11000180 0 0x80>;
+			interrupts =3D <GIC_SPI 30 IRQ_TYPE_LEVEL_LOW>;
+			clock-div =3D <1>;
+			clocks =3D <&infracfg CLK_IFR_I2C2_AXI>, <&infracfg CLK_IFR_AP_DMA>;
+			clock-names =3D "main", "dma";
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		spi: spi@1100a000 {
+			compatible =3D "mediatek,mt8365-spi", "mediatek,mt7622-spi";
+			reg =3D <0 0x1100a000 0 0x100>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			interrupts =3D <GIC_SPI 62 IRQ_TYPE_LEVEL_LOW>;
+			clocks =3D <&topckgen CLK_TOP_UNIVPLL2_D4>,
+				 <&topckgen CLK_TOP_SPI_SEL>,
+				 <&infracfg CLK_IFR_SPI0>;
+			clock-names =3D "parent-clk", "sel-clk", "spi-clk";
+			status =3D "disabled";
+		};
+
+		i2c3: i2c@1100f000 {
+			compatible =3D "mediatek,mt8365-i2c", "mediatek,mt8168-i2c";
+			reg =3D <0 0x1100f000 0 0xa0>, <0 0x11000200 0 0x80>;
+			interrupts =3D <GIC_SPI 31 IRQ_TYPE_LEVEL_LOW>;
+			clock-div =3D <1>;
+			clocks =3D <&infracfg CLK_IFR_I2C3_AXI>, <&infracfg CLK_IFR_AP_DMA>;
+			clock-names =3D "main", "dma";
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		ssusb: usb@11201000 {
+			compatible =3D "mediatek,mt8365-mtu3", "mediatek,mtu3";
+			reg =3D <0 0x11201000 0 0x2e00>, <0 0x11203e00 0 0x0100>;
+			reg-names =3D "mac", "ippc";
+			interrupts =3D <GIC_SPI 16 IRQ_TYPE_LEVEL_LOW>;
+			phys =3D <&u2port0 PHY_TYPE_USB2>,
+			       <&u2port1 PHY_TYPE_USB2>;
+			clocks =3D <&topckgen CLK_TOP_SSUSB_TOP_CK_EN>,
+				 <&infracfg CLK_IFR_SSUSB_REF>,
+				 <&infracfg CLK_IFR_SSUSB_SYS>,
+				 <&infracfg CLK_IFR_ICUSB>;
+			clock-names =3D "sys_ck", "ref_ck", "mcu_ck", "dma_ck";
+			#address-cells =3D <2>;
+			#size-cells =3D <2>;
+			ranges;
+			status =3D "disabled";
+
+			usb_host: usb@11200000 {
+				compatible =3D "mediatek,mt8365-xhci", "mediatek,mtk-xhci";
+				reg =3D <0 0x11200000 0 0x1000>;
+				reg-names =3D "mac";
+				interrupts =3D <GIC_SPI 67 IRQ_TYPE_LEVEL_LOW>;
+				clocks =3D <&topckgen CLK_TOP_SSUSB_TOP_CK_EN>,
+					 <&infracfg CLK_IFR_SSUSB_REF>,
+					 <&infracfg CLK_IFR_SSUSB_SYS>,
+					 <&infracfg CLK_IFR_ICUSB>,
+					 <&infracfg CLK_IFR_SSUSB_XHCI>;
+				clock-names =3D "sys_ck", "ref_ck", "mcu_ck",
+					      "dma_ck", "xhci_ck";
+				status =3D "disabled";
+			};
+		};
+
+		mmc0: mmc@11230000 {
+			compatible =3D "mediatek,mt8365-mmc", "mediatek,mt8183-mmc";
+			reg =3D <0 0x11230000 0 0x1000>,
+			      <0 0x11cd0000 0 0x1000>;
+			interrupts =3D <GIC_SPI 23 IRQ_TYPE_LEVEL_LOW>;
+			clocks =3D <&topckgen CLK_TOP_MSDC50_0_SEL>,
+				 <&infracfg CLK_IFR_MSDC0_HCLK>,
+				 <&infracfg CLK_IFR_MSDC0_SRC>;
+			clock-names =3D "source", "hclk", "source_cg";
+			status =3D "disabled";
+		};
+
+		mmc1: mmc@11240000 {
+			compatible =3D "mediatek,mt8365-mmc", "mediatek,mt8183-mmc";
+			reg =3D <0 0x11240000 0 0x1000>,
+			      <0 0x11c90000 0 0x1000>;
+			interrupts =3D <GIC_SPI 24 IRQ_TYPE_LEVEL_LOW>;
+			clocks =3D <&topckgen CLK_TOP_MSDC30_1_SEL>,
+				 <&infracfg CLK_IFR_MSDC1_HCLK>,
+				 <&infracfg CLK_IFR_MSDC1_SRC>;
+			clock-names =3D "source", "hclk", "source_cg";
+			status =3D "disabled";
+		};
+
+		mmc2: mmc@11250000 {
+			compatible =3D "mediatek,mt8365-mmc", "mediatek,mt8183-mmc";
+			reg =3D <0 0x11250000 0 0x1000>,
+			      <0 0x11c60000 0 0x1000>;
+			interrupts =3D <GIC_SPI 68 IRQ_TYPE_LEVEL_LOW>;
+			clocks =3D <&topckgen CLK_TOP_MSDC50_2_SEL>,
+				 <&infracfg CLK_IFR_MSDC2_HCLK>,
+				 <&infracfg CLK_IFR_MSDC2_SRC>,
+				 <&infracfg CLK_IFR_MSDC2_BK>,
+				 <&infracfg CLK_IFR_AP_MSDC0>;
+			clock-names =3D "source", "hclk", "source_cg",
+				      "bus_clk", "sys_cg";
+			status =3D "disabled";
+		};
+
+		ethernet: ethernet@112a0000 {
+			compatible =3D "mediatek,mt8365-eth";
+			reg =3D <0 0x112a0000 0 0x1000>;
+			mediatek,pericfg =3D <&infracfg>;
+			interrupts =3D <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&topckgen CLK_TOP_ETH_SEL>,
+				 <&infracfg CLK_IFR_NIC_AXI>,
+				 <&infracfg CLK_IFR_NIC_SLV_AXI>;
+			clock-names =3D "core", "reg", "trans";
+			status =3D "disabled";
+		};
+
+		u3phy: t-phy@11cc0000 {
+			compatible =3D "mediatek,mt8365-tphy", "mediatek,generic-tphy-v2";
+			#address-cells =3D <1>;
+			#size-cells =3D <1>;
+			ranges =3D <0 0 0x11cc0000 0x9000>;
+
+			u2port0: usb-phy@0 {
+				reg =3D <0x0 0x400>;
+				clocks =3D <&topckgen CLK_TOP_SSUSB_PHY_CK_EN>,
+					 <&topckgen CLK_TOP_USB20_48M_EN>;
+				clock-names =3D "ref", "da_ref";
+				#phy-cells =3D <1>;
+			};
+
+			u2port1: usb-phy@1000 {
+				reg =3D <0x1000 0x400>;
+				clocks =3D <&topckgen CLK_TOP_SSUSB_PHY_CK_EN>,
+					 <&topckgen CLK_TOP_USB20_48M_EN>;
+				clock-names =3D "ref", "da_ref";
+				#phy-cells =3D <1>;
+			};
+		};
+
+		mmsys: syscon@14000000 {
+			compatible =3D "mediatek,mt8365-mmsys", "syscon";
+			reg =3D <0 0x14000000 0 0x1000>;
+			#clock-cells =3D <1>;
+		};
+
+		smi_common: smi@14002000 {
+			compatible =3D "mediatek,mt8365-smi-common";
+			reg =3D <0 0x14002000 0 0x1000>;
+			clocks =3D <&mmsys CLK_MM_MM_SMI_COMMON>,
+				 <&mmsys CLK_MM_MM_SMI_COMMON>,
+				 <&mmsys CLK_MM_MM_SMI_COMM0>,
+				 <&mmsys CLK_MM_MM_SMI_COMM1>;
+			clock-names =3D "apb", "smi", "gals0", "gals1";
+			power-domains =3D <&spm MT8365_POWER_DOMAIN_MM>;
+		};
+
+		larb0: larb@14003000 {
+			compatible =3D "mediatek,mt8365-smi-larb",
+				     "mediatek,mt8186-smi-larb";
+			reg =3D <0 0x14003000 0 0x1000>;
+			mediatek,smi =3D <&smi_common>;
+			clocks =3D <&mmsys CLK_MM_MM_SMI_LARB0>,
+				 <&mmsys CLK_MM_MM_SMI_LARB0>;
+			clock-names =3D "apb", "smi";
+			power-domains =3D <&spm MT8365_POWER_DOMAIN_MM>;
+			mediatek,larb-id =3D <0>;
+		};
+
+		camsys: syscon@15000000 {
+			compatible =3D "mediatek,mt8365-imgsys", "syscon";
+			reg =3D <0 0x15000000 0 0x1000>;
+			#clock-cells =3D <1>;
+		};
+
+		larb2: larb@15001000 {
+			compatible =3D "mediatek,mt8365-smi-larb",
+				     "mediatek,mt8186-smi-larb";
+			reg =3D <0 0x15001000 0 0x1000>;
+			mediatek,smi =3D <&smi_common>;
+			clocks =3D <&mmsys CLK_MM_MM_SMI_IMG>,
+				 <&camsys CLK_CAM_LARB2>;
+			clock-names =3D "apb", "smi";
+			power-domains =3D <&spm MT8365_POWER_DOMAIN_CAM>;
+			mediatek,larb-id =3D <2>;
+		};
+
+		vdecsys: syscon@16000000 {
+			compatible =3D "mediatek,mt8365-vdecsys", "syscon";
+			reg =3D <0 0x16000000 0 0x1000>;
+			#clock-cells =3D <1>;
+		};
+
+		larb3: larb@16010000 {
+			compatible =3D "mediatek,mt8365-smi-larb",
+				     "mediatek,mt8186-smi-larb";
+			reg =3D <0 0x16010000 0 0x1000>;
+			mediatek,smi =3D <&smi_common>;
+			clocks =3D <&vdecsys CLK_VDEC_LARB1>,
+				 <&vdecsys CLK_VDEC_LARB1>;
+			clock-names =3D "apb", "smi";
+			power-domains =3D <&spm MT8365_POWER_DOMAIN_VDEC>;
+			mediatek,larb-id =3D <3>;
+		};
+
+		vencsys: syscon@17000000 {
+			compatible =3D "mediatek,mt8365-vencsys", "syscon";
+			reg =3D <0 0x17000000 0 0x1000>;
+			#clock-cells =3D <1>;
+		};
+
+		larb1: larb@17010000 {
+			compatible =3D "mediatek,mt8365-smi-larb",
+				     "mediatek,mt8186-smi-larb";
+			reg =3D <0 0x17010000 0 0x1000>;
+			mediatek,smi =3D <&smi_common>;
+			clocks =3D <&vencsys CLK_VENC>, <&vencsys CLK_VENC>;
+			clock-names =3D "apb", "smi";
+			power-domains =3D <&spm MT8365_POWER_DOMAIN_VENC>;
+			mediatek,larb-id =3D <1>;
+		};
+
+		apu: syscon@19020000 {
+			compatible =3D "mediatek,mt8365-apu", "syscon";
+			reg =3D <0 0x19020000 0 0x1000>;
+			#clock-cells =3D <1>;
+		};
+	};
+
+	timer {
+		compatible =3D "arm,armv8-timer";
+		interrupt-parent =3D <&gic>;
+		interrupts =3D <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	system_clk: dummy13m {
+		compatible =3D "fixed-clock";
+		clock-frequency =3D <13000000>;
+		#clock-cells =3D <0>;
+	};
+
+	systimer: timer@10017000 {
+		compatible =3D "mediatek,mt8365-systimer", "mediatek,mt6765-timer";
+		reg =3D <0 0x10017000 0 0x100>;
+		interrupts =3D <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+		clocks =3D <&system_clk>;
+		clock-names =3D "clk13m";
+	};
+};
diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 8971e2d2b0..c3872f4286 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -76,6 +76,14 @@ config TARGET_MT8183
 	  SD and MMC cards, UFS, PWM, I2C, I2S, S/PDIF, and several LPDDR3
 	  and LPDDR4 options.
=20
+config TARGET_MT8365
+	bool "MediaTek MT8365 SoC"
+	select ARM64
+	help
+	  The MediaTek MT8365 is a ARM64-based SoC with a quad-core Cortex-A53.
+	  It is including UART, SPI, USB2.0 dual role, SD and MMC cards, NAND, PW=
M,
+	  I2C, I2S, S/PDIF, and several LPDDR3 and LPDDR4 options.
+
 config TARGET_MT8512
         bool "MediaTek MT8512 M1 Board"
         select ARM64
@@ -133,6 +141,7 @@ config SYS_CONFIG_NAME
 	default "mt7986" if TARGET_MT7986
 	default "mt7988" if TARGET_MT7988
 	default "mt8183" if TARGET_MT8183
+	default "mt8365" if TARGET_MT8365
 	default "mt8512" if TARGET_MT8512
 	default "mt8516" if TARGET_MT8516
 	default "mt8518" if TARGET_MT8518
diff --git a/arch/arm/mach-mediatek/Makefile b/arch/arm/mach-mediatek/Makef=
ile
index 71aa341e34..46bdab8820 100644
--- a/arch/arm/mach-mediatek/Makefile
+++ b/arch/arm/mach-mediatek/Makefile
@@ -11,5 +11,6 @@ obj-$(CONFIG_TARGET_MT7981) +=3D mt7981/
 obj-$(CONFIG_TARGET_MT7986) +=3D mt7986/
 obj-$(CONFIG_TARGET_MT7988) +=3D mt7988/
 obj-$(CONFIG_TARGET_MT8183) +=3D mt8183/
+obj-$(CONFIG_TARGET_MT8365) +=3D mt8365/
 obj-$(CONFIG_TARGET_MT8516) +=3D mt8516/
 obj-$(CONFIG_TARGET_MT8518) +=3D mt8518/
diff --git a/arch/arm/mach-mediatek/mt8365/Makefile b/arch/arm/mach-mediate=
k/mt8365/Makefile
new file mode 100644
index 0000000000..886ab7e4eb
--- /dev/null
+++ b/arch/arm/mach-mediatek/mt8365/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier:	GPL-2.0
+
+obj-y +=3D init.o
diff --git a/arch/arm/mach-mediatek/mt8365/init.c b/arch/arm/mach-mediatek/=
mt8365/init.c
new file mode 100644
index 0000000000..8f03ed2876
--- /dev/null
+++ b/arch/arm/mach-mediatek/mt8365/init.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 MediaTek Inc.
+ * Copyright (C) 2023 BayLibre, SAS
+ * Author: Julien Masson <jmasson@baylibre.com>
+ * Author: Fabien Parent <fparent@baylibre.com>
+ */
+
+#include <asm/global_data.h>
+#include <asm/system.h>
+#include <dm/uclass.h>
+#include <wdt.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int dram_init(void)
+{
+	return fdtdec_setup_mem_size_base();
+}
+
+int dram_init_banksize(void)
+{
+	gd->bd->bi_dram[0].start =3D gd->ram_base;
+	gd->bd->bi_dram[0].size =3D gd->ram_size;
+
+	return 0;
+}
+
+int mtk_soc_early_init(void)
+{
+	return 0;
+}
+
+void reset_cpu(void)
+{
+	struct udevice *wdt;
+
+	if (IS_ENABLED(CONFIG_PSCI_RESET)) {
+		psci_system_reset();
+	} else {
+		uclass_first_device(UCLASS_WDT, &wdt);
+		if (wdt)
+			wdt_expire_now(wdt, 0);
+	}
+}
+
+int print_cpuinfo(void)
+{
+	printf("CPU:   MediaTek MT8365\n");
+	return 0;
+}
diff --git a/include/configs/mt8365.h b/include/configs/mt8365.h
new file mode 100644
index 0000000000..e8aacf8c5d
--- /dev/null
+++ b/include/configs/mt8365.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Configuration for MT8365 based boards
+ *
+ * Copyright (C) 2023 BayLibre, SAS
+ * Author: Julien Masson <jmasson@baylibre.com>
+ */
+
+#ifndef __MT8365_H
+#define __MT8365_H
+
+#endif
--=20
2.43.0

