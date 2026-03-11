Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC71FD88D4
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 00:18:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5704C8401F;
	Wed, 11 Mar 2026 01:17:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yzjy6Uqy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 096F984020; Wed, 11 Mar 2026 01:17:50 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A872C83FC1
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 01:17:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7d74d6bcc00so1675704a34.2
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 17:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773188266; x=1773793066;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wdjeKdrP4hfC+zNUvX3JUN9kbT/rrtkVjvxMOw+olBY=;
 b=yzjy6Uqy6AhrsWcufAtGJnQQMOnooRV6Rkily01vc+Y+z5joCpEPPd9TK5WjA1RAcu
 fUc8mRQoqAmbGyJtkUpitKX8ZlPoSg06Mw6/C7/UfSWM5WDSc+VgURRuqPP25fgc7GfP
 BGhNcfXLfYnYQRn9rxGdRW9I1rBEnoH6dWbrT4IYAAcNaOW36+nx2k1HIuajjD+Mz8L+
 OC8yxx2xfXmSHmSVEn4vmufNBtSWd82L9YidOZT2YSiSBlvz1t1AIv3XtMg/7BgFugdp
 B1Zr01vHaxTP0G7Vw9ziVUm3pUu/1jlz47kBWCSijsV4zFKZ2p6uql3CIZBg1fj9ZCE8
 2g2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773188266; x=1773793066;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wdjeKdrP4hfC+zNUvX3JUN9kbT/rrtkVjvxMOw+olBY=;
 b=GLWWJIlDkX0KQ+PtXWT9Z0oOHa7XduEIoUTH6QDfjqgXWUQOEUFXHvRseoL/vrS1tW
 RehNnUnGD7ZPSJCwPY2wrNiEEVg71bFBglhNlMMMa6lV+iWwjkV4CK7uC2yRjCJ6bFZ6
 /Rrcj8IYEIl2eG7y4wBOdIiGvlGhUB7P+bmN9RDQLmIgYS0fYFSQxnU0b/PecT4UF7M5
 bTYPvxybrtK3C8HuHQCvwyyuTVkZxxlfd0gsA4XvBx7w3QK7qZPEFxZ6YyiS73QNz+CN
 II3N66+oLobkI4A21nbsQYvoo/N08VPSWo7hiQkqjBUv9uj5D85bEEnykJmeSCTise1B
 BEnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVOWeEaeGwIsuWYbvDfBjVizkuj5RHFGrMp36yFvQ9KbgNezdGaY8wMcbulNlL/mPQmJrbcZg=@lists.denx.de
X-Gm-Message-State: AOJu0YxHzOAU+aPRfebtt3MF0CJFDg1LFWoBoUjAleKCmPPFH5a6fFBI
 fDT2GneZ9cuE1iuR3rc3OnVtvpPnwWPkVpEt6PsK5u8XDitOIIisLqwb84YWTa59T/0=
X-Gm-Gg: ATEYQzx3Sc/mrgfdbkpqzwsrLUDEok2+nWLrQM7+7tuX34qhm3vD0wINh0Fx29rnQrh
 OfOpFwGKYcHR++rSsl/ThZu1DXU9lO98AKJTQf6i/CEFxaJGcd36jNelrsd7matWtmp/NddGOaW
 RiGFR/uHQbSRA2K9hUZWVeqbfeZTxXTs4Ht5veoqk5FTOZcqtCg+R3nfKnglRFE+E+Da2458DV9
 jmGYUtBIA5TN7BNg6tB+1NwTVvWe981jfXtRcQtw8CMgjs7oTLI1aE02avFwFCDrvb3X41h+724
 bHI0WwLh+oH3eZno4uCdO5MmczuaHDgksDAmjPXf1zosIn7++6HSmjK4Vgn+Ibzi7xxcwIu2Utk
 Ug6J5ucISgAnRrlQ5QIu4YYlTSCdgclWCv9SaSx0dERo3H+30mGwjYCREbzvvPiO98Ww2ZOe4CK
 XyX6+yGXOc1bC4+ATzuYWCTa3lHGpk
X-Received: by 2002:a05:6830:913:b0:7d7:4dbd:6dc with SMTP id
 46e09a7af769-7d76a5e9d34mr574511a34.8.1773188266395; 
 Tue, 10 Mar 2026 17:17:46 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:82ac:f3fe:2e5f:ec03])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae6a361sm466304a34.20.2026.03.10.17.17.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 17:17:45 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 10 Mar 2026 19:16:53 -0500
Subject: [PATCH v2 4/6] arm: dts: mediatek: Add MediaTek MT8189 dtsi file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-mtk-mt8391-initial-support-v2-4-1dc862d58532@baylibre.com>
References: <20260310-mtk-mt8391-initial-support-v2-0-1dc862d58532@baylibre.com>
In-Reply-To: <20260310-mtk-mt8391-initial-support-v2-0-1dc862d58532@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lukasz Majewski <lukma@denx.de>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7974; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Zgmc0ptSGkydfxp8KY6aWe5lm3ZT2cQ7AC2URFaFKYA=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpsLSSMSWFGSDpa1dBTluCz/QHAgNT+DWvOsf5Z
 0JtkDAu9BuJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabC0khYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A6RoH/j/HCtSGDLo4oMZfKLrvjMcwvrxo3DimfdhfolH
 GMYuon558pmmZcnzx27wrVZjfeg57cfWBU5OMzpFg6j+Mld/k5w2B/sjpPh/o18DbJWw0R0Xqjo
 9gasZQEjLIJsGtMZdQeKxIBIvfmrhr1tk+aIQ6Ft2RXLs6UMMHxEJSijUl04rIYHwGuJiZfg/BW
 vokz4eJoV5pd0dk61R5Yil230M3gZFhs4Azb0XaJ3MKouBk9Vm4kW/sDdRteLTpkieolc4qtwGs
 mT/IqI16BOpivskLOKm6hXvZ485apTcDH9cWqW4tCtnZMNllIKivD/BupGvxc/riclCCV2P3t9v
 3bjs=
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

