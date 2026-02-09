Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C755E7E0D5
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 18:39:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC05E83D0B;
	Mon,  9 Feb 2026 19:39:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wMOrT8+x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBA6183BF4; Mon,  9 Feb 2026 19:24:07 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4A6E80325
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 19:24:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-460f3f9fdb1so3449847b6e.0
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 10:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770661443; x=1771266243;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lOtrVfkVVj5XAHz5Iq1tJiASfXc6bx94GODGh1Dany8=;
 b=wMOrT8+xn+VFmhT3uB46DeaPqz4Vp7br8MsgQE+hfetkm5gcCww6uBWxVYG8/6JXlI
 YeJhBNMOzGK0GGU9LkgX9iZQo4yIb2I9A+49W+6ioUKalydK3u2Et3AKQ+9PlGalNWrT
 yz0yrbLVkduufFwreiJZoM+Wp36EHn/PNOaCAh6aJk/KzpM53aonRADwt30Ij1KfTuEj
 qmIsXc6xiK42xfV2NKlceHf5I1RSirZIYfwYlOpGnaIschMAEgvlQ2mhr/HOM+Oh6unG
 ve7ypODr5dNbeQ7W78EzNKpWcaRw412rd4TEKv3QaYRuLpqoyqrDxweJIVFpypibYYhv
 RkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770661443; x=1771266243;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lOtrVfkVVj5XAHz5Iq1tJiASfXc6bx94GODGh1Dany8=;
 b=oNhMezmb4Ma0qHyQubA/mxpx4TuEw4rvGF9d4xaHr1zINxEljJF5Dh3b+49HNnL6YS
 AQE6Ovan9gnuKYRvt5+rMSvEsbMxCjD9E9QhzAzTyT1jxHMlWSb/SACZn89fp1mKNNgH
 gNdZcXdtjye/4uYLLKT9Od23F/uBzHdOyiyE3E7LcckorCDzjpGrwl4aaOTylsQ6oM4U
 pAVqW2bDai6t9dToVJiEqjIUtdRElAXuSyqNvhoj4uknY8PMS6NVRjXQvG0uGlDlTtwp
 NUYvquHcb4dijvobuAx/oAY7MV7xn8HKVM2D5tFdAA5XDrYVM7ZEg7fwM91OO3Vl7UL8
 rOyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX07lBRhwZoFxkUVX8fS8iFwBo9jawsR0IxAzn0L0nD9wrXxybvzI+MPggTTvaqN3AVThUWeWU=@lists.denx.de
X-Gm-Message-State: AOJu0YyIG/OsgBhbmpM7DiGMEpo0+U3tOAAH0qlFxdobKLtHtI0MIFqe
 2ksNg6sUI4BAnldu4ZW9/cSEnFjoa6/e9tezfXwWO2VXARqxgp/rQLJqDgJrjKclZkY=
X-Gm-Gg: AZuq6aJ3mtlR+bmpWHH23vB2BYUE0cewwHgDlQy/AZTD1keAqaGhZ3gs3ul0tzIfsZS
 se7BmHAB9hKSN2BtNXTxE8MrD93QOps3QFAHS1xGoK179dk2LMqS27m32AyQNr2dakzeuYIBfOL
 0ZmfRubExvteXj54HhwI2+gG9TRW/tkTXRYffUh3Dg1kX5xzytdJJf/NbzV/1yiRWyXFDCih0HF
 aWSjiSjh+m4eJMRi6kGiwpRLdddwqpk7ZH1YacSvMqpnT4swybiyZGlehEukxz3dc6N6pVofkWp
 NzykN9j1P1qVYFhUDnke8wpdFB6pV7gwJcP0ArhQCY5SeJ8Xq6sKURxaqZVwgNRvoFqQTdQCRsf
 cRUNztahhdwnduO4sqMwZJBYUfY4ah+sLt+qvsvm3h1eDTZbN/ifx/ky1BAp80ud1UuAMGedPKp
 U6VHE7JUi2xx81JhacLWi7f5egjg==
X-Received: by 2002:a05:6808:d50:b0:45f:1901:148a with SMTP id
 5614622812f47-4634f99aaa6mr179980b6e.27.1770661443602; 
 Mon, 09 Feb 2026 10:24:03 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:cee0:eb0c:b683:ad1d])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a99359eb4sm7993335fac.9.2026.02.09.10.24.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 10:24:02 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 09 Feb 2026 12:23:16 -0600
Subject: [PATCH 2/4] arm: dts: mediatek: Add MediaTek MT8189 dtsi file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-mtk-mt8391-initial-support-v1-2-b23ab9d0b9bc@baylibre.com>
References: <20260209-mtk-mt8391-initial-support-v1-0-b23ab9d0b9bc@baylibre.com>
In-Reply-To: <20260209-mtk-mt8391-initial-support-v1-0-b23ab9d0b9bc@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6181; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=xCpjDx1IEmWZG/ufmbkSHBjqiu9Xe07a90z2kan2oxE=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpiiYrBhZRbZIIWGXfb7QjElLSBos6crAiIjalw
 0d54g0+L6WJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaYomKxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A0SUIAIsIrusAfrR9XV1GOI/OjAg/XRE6j3PdBJVZBzc
 QSwk4+hul9aW0HTXfOWDtJT0qd+MfMt+sKJ6ZSMu+YaYu1cXztJAE7EGNiX4CSnX085F62dGJyu
 /4Z5cgneQZBu1dUOLqle2NQ6Ck0gE+UI0KFY3hwl/2IN50jo95nNyfxgmqwajExu2YDV5ShIcMt
 W0HVNHTytCeYiQqkNFNgZGQN2LKLr1tqdIMeJjA6ZDkXYn3nFIk6Tqo9brFZqBiP1jRVYI/nufM
 0OoauBnQZZPuRWF85rLEzoECq/RIG/GKf5uhj2JR9ZBQqega0kJsNxV7MtZP1Rd/HQm8/tubxnd
 N0iE=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Mon, 09 Feb 2026 19:39:13 +0100
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
 arch/arm/dts/mt8189.dtsi | 243 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 243 insertions(+)

diff --git a/arch/arm/dts/mt8189.dtsi b/arch/arm/dts/mt8189.dtsi
new file mode 100644
index 00000000000..cbece7b89c7
--- /dev/null
+++ b/arch/arm/dts/mt8189.dtsi
@@ -0,0 +1,243 @@
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
+		clock-controller@1c00c000 {
+			compatible = "mediatek,mt8189-vlpcfg-ao", "syscon";
+			reg = <0 0x1c00c000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+	};
+};

-- 
2.43.0

