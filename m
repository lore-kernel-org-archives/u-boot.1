Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A06F483F5
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 20:18:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE75584065;
	Mon, 23 Mar 2026 21:18:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JklJpiiC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC279840B0; Mon, 23 Mar 2026 21:18:10 +0100 (CET)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07016838BB
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 21:18:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-40423dbe98bso1250606fac.2
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 13:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774297087; x=1774901887;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wdjeKdrP4hfC+zNUvX3JUN9kbT/rrtkVjvxMOw+olBY=;
 b=JklJpiiCT3XZvCCTb9FLOn8DOmqeUjwOFWmgnCkO0MadYLuo6/z4UIxXOEQsp8DX+G
 pzJbCp4c36fX+EcfreVoL166LEevZ9BMgWxYMWJL75wCdrF9jQWMPittpfDsv3xrO11/
 1yP0ZYrMEEpemCK3PK+GNwdIVMBykEmPeveoGMb0WFAcA1huTXnYtC4qAF/VR7DsWX5R
 fdAbH1oMHLT80A8X+4kqz170NrrSk/l9EI3Q1+HpcVM8JjiNqt4Coao9Rh6M1RPsy40h
 gxwTHql9yEUPCRayYoAUGtLDRJ3fIBvPwKI+C7hu8KjS8ybKeKfTByTmdvhzjezK8naL
 VD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774297087; x=1774901887;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wdjeKdrP4hfC+zNUvX3JUN9kbT/rrtkVjvxMOw+olBY=;
 b=bRUIA8rmrU3er0xyOolvmoU/+3VWZHkwvn/ujJBA02YX+3hvikXpG84VPjtRY5S4I2
 l6e279ZLliWHrgQWW2kfli9jTSRrhPzWnTiD729C2OI64v9t0GkhTbnG9p7ur4fX/xag
 N1IM9U4T3VTfTbqH7fTavPoAeefCkX43b2pHCxQyR04FfNsvBCpujQ8AyIWe/ZIiBQLO
 KWqNOP9KWXB+aTbS5ZTtryBE/FTziYanzblLkUpWBqaKpnV9gQmSQwqsFJOc2xf+e7zr
 Gy/4plyFlcx3gaSBcVP7+v8IFxckLRRkwIq+pK20fmXSwhB1jbOOlRCW54bogPIL8LI8
 Y0vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/hhIBICmBP3vZv2SOFjWCIxNVgmwDktGPpbXXShuUrzC8X3KxkubZmjSl/nZVYWatssZ2U8M=@lists.denx.de
X-Gm-Message-State: AOJu0YyRnVB5bWWUs3fIo2a2io7d7qb1r+Pl4hIIv62g6PU39sDMvfJW
 V2Kn7JpDVi+TZw3QNNIC4GY+HtSZQ29wN2wFWHsH0uQjXACjqJxl2PgkeikLlPJ334Q=
X-Gm-Gg: ATEYQzycB7dqPcrlAZYCO/XFbFi8bLGFG/v2lvjUYG07deliZjDK/mSuDVjVTIRQLhk
 u+UgEQzCrSBRevWmSnAgSMR6enfHcVs/46LrrC1Y07xpPmogCRzcW5jXBcboaOtONk29Gf8Yyt6
 ck4dnBQOZX/iJbXb72xPUQogViVBeqoYBhFtPmp0ZGsm8+JGWQZ9g2sc85IbT71sE9XT7qINgzU
 9OgUpfvOxxkrYkR2Rz+h9Z3dnBKko5drYwZIbyQ3qd7oMJ56W6bG9j+Ptowg2wA+6nyFtWEVZBf
 3Rsntl3iOwh7FyijEMtdKid43wWAWN5bQnJ0KLO7Rdcx9bHCTG808HojjpKTeyWnSe4j1Z7pMfP
 M2+lD0ias8z7otZu/Y3q6lJHBDx2LL0Kq/GdxczOmESNwvtddc0AewI3IajjiX36qjP/vEjcnvf
 tJLc9GgUCUY6OnrtAnSUf/PjhRjAo=
X-Received: by 2002:a05:6870:2d4:b0:417:2c45:da96 with SMTP id
 586e51a60fabf-41c10e7cdafmr7894612fac.9.1774297086526; 
 Mon, 23 Mar 2026 13:18:06 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:964:f712:dbc7:4119])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41c148a5ca4sm11077540fac.3.2026.03.23.13.18.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 13:18:06 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 23 Mar 2026 15:16:55 -0500
Subject: [PATCH v3 4/6] arm: dts: mediatek: Add MediaTek MT8189 dtsi file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-mtk-mt8391-initial-support-v3-4-19dd92f4543f@baylibre.com>
References: <20260323-mtk-mt8391-initial-support-v3-0-19dd92f4543f@baylibre.com>
In-Reply-To: <20260323-mtk-mt8391-initial-support-v3-0-19dd92f4543f@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lukasz Majewski <lukma@denx.de>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7974; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Zgmc0ptSGkydfxp8KY6aWe5lm3ZT2cQ7AC2URFaFKYA=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpwZ/k4fjAvI4ERm9Fx/4JnpQpNCEGI++qgWl50
 y65rNsapQqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCacGf5BYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AHP4H/10I3TylnDkAY7Ob0xjg/byUgggAoTknFT1qTfE
 jKBBF+LRLpMuALasaKNI0aiq9WelOk21yGLGVWkkuxteO7w13alWUsOvX2EXM6+Lp1SJuYVWmJe
 4lauIN+MZXq3V33u0NoXgho46qgGJ/Pu70nKNyDA2zYNAUkrHGGzRWq7ghF4EzxxXeMVoBX8od+
 VGvHMObMzUvzF89YgAYC3gRlc0rEljzJF7Hpf7f2khZ39BAPH9shTa0tEutMRSWYgjfH+Ivj3kF
 8KxFjCRmgm/NNni6YgUxB/yzrBG5NUwzTJZU2qNgGpTkX3tbzRLeF7tFcurSjQ7xWPR92AZWIrr
 QSbI=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

From: Chris-QJ Chen <chris-qj.chen@mediatek.com>

Add a basic .dtsi file for MediaTek MT8189. This will suffice until an
upstream devicetree is available from Linux.

Signed-off-by: Chris-QJ Chen <chris-qj.chen@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/mt8189.dtsi | 301 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 301 insertions(+)

diff --git a/arch/arm/dts/mt8189.dtsi b/arch/arm/dts/mt8189.dtsi
new file mode 100644
index 00000000000..3aafb9b151f
--- /dev/null
+++ b/arch/arm/dts/mt8189.dtsi
@@ -0,0 +1,301 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2026 MediaTek Inc.
+ * Author: Macpaul Lin <macpaul.lin@mediatek.com>
+ */
+
+#include <dt-bindings/clock/mediatek,mt8189-clk.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "mediatek,mt8189";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	clk26m: oscillator {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+		clock-output-names = "clk26m";
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x000>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <282>;
+		};
+
+		cpu1: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x100>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <282>;
+		};
+
+		cpu2: cpu@200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x200>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <282>;
+		};
+
+		cpu3: cpu@300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x300>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <282>;
+		};
+
+		cpu4: cpu@400 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x400>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <282>;
+		};
+
+		cpu5: cpu@500 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x500>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <282>;
+		};
+
+		cpu6: cpu@600 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a78";
+			reg = <0x600>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
+		};
+
+		cpu7: cpu@700 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a78";
+			reg = <0x700>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
+		};
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+
+				core1 {
+					cpu = <&cpu1>;
+				};
+
+				core2 {
+					cpu = <&cpu2>;
+				};
+
+				core3 {
+					cpu = <&cpu3>;
+				};
+
+				core4 {
+					cpu = <&cpu4>;
+				};
+
+				core5 {
+					cpu = <&cpu5>;
+				};
+
+				core6 {
+					cpu = <&cpu6>;
+				};
+
+				core7 {
+					cpu = <&cpu7>;
+				};
+			};
+		};
+	};
+
+	memory: memory@40000000 {
+		device_type = "memory";
+		/* This memory size is filled in by the bootloader */
+		reg = <0 0x40000000 0 0>;
+	};
+
+	soc {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		compatible = "simple-bus";
+		ranges;
+
+		watchdog: watchdog@1c00a000 {
+			compatible = "mediatek,mt8391-wdt",
+				     "mediatek,wdt";
+			reg = <0 0x1c00a000 0 0x100>;
+			status = "disabled";
+		};
+
+		gic: interrupt-controller@c000000 {
+			compatible = "arm,gic-v3";
+			reg = <0 0xc000000 0 0x40000>, /* distributor */
+			      <0 0xc040000 0 0x200000>; /* redistributor */
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
+			interrupt-controller;
+			#interrupt-cells = <4>;
+			#redistributor-regions = <1>;
+
+			ppi-partitions {
+				ppi_cluster0: interrupt-partition-0 {
+					affinity = <&cpu0 &cpu1 &cpu2 &cpu3 &cpu4 &cpu5>;
+				};
+
+				ppi_cluster1: interrupt-partition-1 {
+					affinity = <&cpu6 &cpu7>;
+				};
+			};
+		};
+
+		uart0: serial@11001000 {
+			compatible = "mediatek,mt8189-uart", "mediatek,mt6577-uart";
+			reg = <0 0x11001000 0 0x1000>;
+			interrupts = <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&clk26m>, <&pericfg_ao_clk CLK_PERAO_UART0>;
+			clock-names = "baud", "bus";
+			status = "disabled";
+		};
+
+		mmc0: mmc@11230000 {
+			compatible = "mediatek,mt8189-mmc";
+			reg = <0 0x11230000 0 0x10000>,
+			      <0 0x11e70000 0 0x1000>;
+			clocks = <&topckgen_clk CLK_TOP_MSDC50_0_SEL>,
+				 <&pericfg_ao_clk CLK_PERAO_MSDC0_H>,
+				 <&pericfg_ao_clk CLK_PERAO_MSDC0>;
+			clock-names = "source", "hclk", "source_cg";
+			interrupts = <GIC_SPI 387 IRQ_TYPE_LEVEL_HIGH 0>;
+			status = "disabled";
+		};
+
+		clock-controller@1000c000 {
+			compatible = "mediatek,mt8189-apmixedsys", "syscon";
+			reg = <0 0x1000c000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		clock-controller@14000000 {
+			compatible = "mediatek,mt8189-dispsys", "syscon";
+			reg = <0 0x14000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		clock-controller@1e980000 {
+			compatible = "mediatek,mt8189-gce-d", "syscon";
+			reg = <0 0x1e980000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		clock-controller@1e990000 {
+			compatible = "mediatek,mt8189-gce-m", "syscon";
+			reg = <0 0x1e990000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		clock-controller@1e800000 {
+			compatible = "mediatek,mt8189-mm-infra", "syscon";
+			reg = <0 0x1e800000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		pericfg_ao_clk: clock-controller@11036000 {
+			compatible = "mediatek,mt8189-peri-ao", "syscon";
+			reg = <0 0x11036000 0 0x1000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		topckgen_clk: clock-controller@10000000 {
+			compatible = "mediatek,mt8189-topckgen", "syscon";
+			reg = <0 0x10000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		pio: pinctrl@10005000 {
+			compatible = "mediatek,mt8189-pinctrl";
+			reg = <0 0x10005000 0 0x1000>,
+			      <0 0x11b50000 0 0x1000>,
+			      <0 0x11c50000 0 0x1000>,
+			      <0 0x11c60000 0 0x1000>,
+			      <0 0x11d20000 0 0x1000>,
+			      <0 0x11d30000 0 0x1000>,
+			      <0 0x11d40000 0 0x1000>,
+			      <0 0x11e20000 0 0x1000>,
+			      <0 0x11e30000 0 0x1000>,
+			      <0 0x11f20000 0 0x1000>,
+			      <0 0x11ce0000 0 0x1000>,
+			      <0 0x11de0000 0 0x1000>,
+			      <0 0x11e60000 0 0x1000>,
+			      <0 0x1c01e000 0 0x1000>,
+			      <0 0x11f00000 0 0x1000>;
+			reg-names = "base",
+				    "lm",
+				    "rb0",
+				    "rb1",
+				    "bm0",
+				    "bm1",
+				    "bm2",
+				    "lt0",
+				    "lt1",
+				    "rt",
+				    "eint0",
+				    "eint1",
+				    "eint2",
+				    "eint3",
+				    "eint4";
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pio 0 0 182>;
+			interrupt-controller;
+			interrupts = <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH 0>;
+			#interrupt-cells = <2>;
+		};
+
+		pwrap: pwrap@1cc04000 {
+			compatible = "mediatek,mt8189-pwrap", "mediatek,mt8195-pwrap", "syscon";
+			reg = <0 0x1cc04000 0 0x1000>;
+			reg-names = "pwrap";
+			assigned-clocks = <&vlpckgen_clk CLK_VLP_CK_PWRAP_ULPOSC_SEL>;
+			assigned-clock-parents = <&topckgen_clk CLK_TOP_OSC_D10>;
+			clocks =  <&vlpcfg_ao_clk CLK_VLPCFG_REG_PMIF_SPMI_M_SYS>,
+				  <&vlpcfg_ao_clk CLK_VLPCFG_REG_PMIF_SPMI_M_TMR>;
+			clock-names = "spi", "wrap";
+			interrupts = <GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH 0>;
+		};
+
+		vlpcfg_ao_clk: clock-controller@1c00c000 {
+			compatible = "mediatek,mt8189-vlpcfg-ao", "syscon";
+			reg = <0 0x1c00c000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		vlpckgen_clk: clock-controller@1c012000 {
+			compatible = "mediatek,mt8189-vlpckgen", "syscon";
+			reg = <0 0x1c012000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+	};
+};

-- 
2.43.0

