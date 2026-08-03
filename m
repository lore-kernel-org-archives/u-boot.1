Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52803C55184
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 23:21:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 25F36606E7;
	Mon,  3 Aug 2026 23:21:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jBZbB2WlTCy9; Mon,  3 Aug 2026 23:21:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8D6BD606D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785799303;
	bh=Mtufnxz5JMzHpcBhvDG5E2F4qL1UIOX/q1lfRKsF22Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pnpIEKPURw4f26/TwdthaCnmeWxJwu5bDdME6RC4CRi9HBDf+Gu4s099pkwKnv0YB
	 U/upODg+lQdXeq0CX6V6oNkh+20n4H/J8u4doB+IWhHd+lQMHnkamsY7rsKkHgOFoo
	 XV4tdy32xn6iqMGQS7aiV79sbPWj2puSxPPJPk2VOr4CSh6SKVkcmY2p+fG/oq+IaN
	 XfiQQajYm9Q6hNdWjX+xdldPxxHH+69CAFe1BQA1O4mQ7wW50AUMRxusjs7DfLk/pY
	 nb+LPnZJAJqEYSIPShx5ANcf42lzy8RVIQuUanS8DJg+j7VcR78IvkpStUMQiCTQMf
	 Bt7UDl+2QX1rA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8D6BD606D4;
	Mon,  3 Aug 2026 23:21:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EAD3D2CE
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 23:21:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CE98A80C10
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 23:21:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ctJRgyW1DqaT for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 23:21:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2e; helo=mail-oa1-x2e.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E34B380B88
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E34B380B88
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E34B380B88
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 23:21:36 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-43b7e186a0cso1548130fac.0
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 16:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785799296; x=1786404096;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Mtufnxz5JMzHpcBhvDG5E2F4qL1UIOX/q1lfRKsF22Q=;
 b=ZPpkegAdJuPkSgb82AXarJQf2T2ATgKTTs/G/Ak2XLHaB0JKSxwGndCSIRXXCJe5S9
 CvzAKTKMCqLSn7M2YIhWh0skcrGiGjOVuekNKVtN/s537jf46dqfV2v4NoGI6XZWCfor
 fJbOdkWcVuCgwkkiJV1NDwVk/p/MO3B4gqGj2RJB32u1moj0mzgfD0JCdVdOrV6DTJ5+
 ZS6uy0P6yavQzbjmXC2R26JTdEvIO2SbSnlCbjiN8Y1JH7fR7t2XUA26s19gvVqMKgRq
 2GI2ikqFdU726wSNLAprfHzfK/Yn0u2DH1uxEqe9mV5Nx9mHgUpgddh/yfPj915/CC+4
 qQrg==
X-Gm-Message-State: AOJu0YxEk+FvGuihDGOsBzJsNFVRU/KEfhcdB0E1WUh7W9zF6tTsTq25
 w+s2OgtVMMiY3uPF4Vmhf0+dyLpbZLObAXqfsCmCUXB2CIMQ4lmy/ZAx57omOxVqx6I=
X-Gm-Gg: AR+sD10BcjVN1pM3N8ucYi5RbIqXRwM86YtOosDqSshZyUpakMCrc5kOw9Npg5NqouP
 kC6yjdAnWtb/f9CVSzVN4he86awEvmLS4ECdrhONU7sIYH7yucdVUnjarzQt9Dp9uFgoU8B7xte
 kAlkMS2Y22BvWYysC4J0LKzZQbl1h2WZUw0bFBMXnYcCvrj/fEu9PSVMf+CIIb9/smLPyi26OSV
 iuEPN8I1LqUV/nQo8JxvPvqFNv4hZbs/Cd8BJQH5smJoEGhpR3F/BiwnbItgDmN5jpUecXDMCK0
 mDK6/9zEXnR0UOSF5gSLj9at622Pb4lVqBjDDxSrA/3RmYMBgA7OmST9DlY5XW9fJdMT2OKOcc7
 /u7+Z1oSp6aRUa8MIA/hrErpvmKX1iy6Iw+yvOtCZJFhyIaDtMG3rzXTUho/FtC0iwEG9tz8+B2
 VW/F7FFULBZ23q25DVmLmriIzRI/FT0qsoqtGlF41nkfsZBrMZikAjv6G99ko6Lg4=
X-Received: by 2002:a05:6870:d364:b0:457:4470:96e2 with SMTP id
 586e51a60fabf-45905d3828cmr18223743fac.12.1785799295593; 
 Mon, 03 Aug 2026 16:21:35 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b8f7:1f5e:7c:a7d1])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-458f60df63fsm9440852fac.6.2026.08.03.16.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 16:21:35 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 03 Aug 2026 18:20:42 -0500
Subject: [PATCH 3/6] arm: dts: add MT8366 application processor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-mtk-genio-360-bringup-v1-3-606ee60755b5@baylibre.com>
References: <20260803-mtk-genio-360-bringup-v1-0-606ee60755b5@baylibre.com>
In-Reply-To: <20260803-mtk-genio-360-bringup-v1-0-606ee60755b5@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=19485;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=KRVMg+OgKMiGJcfADip0mPsWX+Eu/qBoZ/wGim1qrHw=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqcSJd4uMLEgFLr7cruS4sluAFAttij58kTT6Di
 Z4uI5oHDKGJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanEiXRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AspwH/iXEdd6A0o7QQpx/K+k0u6nsL+a75i06bZ7c8dC
 Zh/b6HTFHMfoik2ni022fID0CHm35Xlc6mZXiVfGKxT6l5uvNHEcr47ozN+WFnJAGPjz0SMryFy
 5UHvk1PhK3lv/4/gj/hTgrwkaOTfoG7wKUUr+Ml/IIzRXvSKsbHqcwZhU4C4XnXBiV+mH7gQCoU
 JE678XfzdEz/qH4pBWAQIsb6/9ZiEV/fEEIU8l9RMfCmqcM5oB6v2LW4aCh2cB0LvveP+Duw1in
 3F4/MbYaEknebZ34y7PwZNX19XlicyXfRewPvPTZNXASoyOnZVi0Qn+XlstP4VgQ1jCCSm89X/J
 6uvo=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785799296; x=1786404096;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Mtufnxz5JMzHpcBhvDG5E2F4qL1UIOX/q1lfRKsF22Q=;
 b=bp0OsMu08Bkn5Q739YFu0sJmuERnEr9LD9NisERBUO2MKLkDwSqyKaqDseKd0O1+lH
 fJ9eDI9zcUe9z0MY+JW7JYh+c+W3cu4yj07tY32wQSsFRfZd7Umu/8UYiG8iiIF6B7Gj
 S3gGYo8hs1cHcV6vJtRfc6905701YCEwgdLjcV5dtF15IOC+MdQKPRCaTpXdITdJ9H1O
 y0JLGUbbVsvrXIi4u5JF8lhVMBjJ7d3bReBInTIcvKXB9eBVRQ8dXJ4HfvZ8rjlceEA4
 PBvoK6E46bEqO4Nn82dyInsARw1QgnGQd2G/249vyS/bO6TBjf72NbVj4nU7tOcN+z28
 el4w==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=bp0OsMu0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Macpaul Lin <macpaul.lin@mediatek.com>

Add MT8366 application processor .dtsi file for systems based on this
chip.

Upstreaming of MT8366 has not even started yet, so we will have to
carry a downstream version of this for some time.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/mt8366.dtsi | 662 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 662 insertions(+)

diff --git a/arch/arm/dts/mt8366.dtsi b/arch/arm/dts/mt8366.dtsi
new file mode 100644
index 00000000000..263b0149a85
--- /dev/null
+++ b/arch/arm/dts/mt8366.dtsi
@@ -0,0 +1,662 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2025 MediaTek Inc.
+ * Author: Macpaul Lin <macpaul.lin@mediatek.com>
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/pinctrl/mediatek,mt8366-pinfunc.h>
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/clock/mt8366-clk.h>
+
+/ {
+	compatible = "mediatek,mt8366";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		serial0 = &uart0;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
+		i2c5 = &i2c5;
+		i2c6 = &i2c6;
+		i2c7 = &i2c7;
+		i2c8 = &i2c8;
+		i2c9 = &i2c9;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
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
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&cpu5>;
+				};
+			};
+		};
+
+		cpu0: cpu@0 {
+			compatible = "arm,cortex-a55", "arm,armv8";
+			reg = <0x000>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <282>;
+		};
+
+		cpu1: cpu@1 {
+			compatible = "arm,cortex-a55", "arm,armv8";
+			reg = <0x100>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <282>;
+		};
+
+		cpu2: cpu@2 {
+			compatible = "arm,cortex-a55", "arm,armv8";
+			reg = <0x200>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <282>;
+		};
+
+		cpu3: cpu@3 {
+			compatible = "arm,cortex-a55", "arm,armv8";
+			reg = <0x300>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <282>;
+		};
+
+		cpu4: cpu@4 {
+			compatible = "arm,cortex-a55", "arm,armv8";
+			reg = <0x400>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <282>;
+		};
+
+		cpu5: cpu@600 {
+			compatible = "arm,cortex-a76", "arm,armv8";
+			reg = <0x600>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
+		};
+	};
+
+	clk26m: oscillator {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+		clock-output-names = "clk26m";
+	};
+
+	stmmac_axi_setup: stmmac-axi-config {
+		snps,wr-osr-lmt = <0x7>;
+		snps,rd-osr-lmt = <0x7>;
+		snps,blen = <0 0 0 0 16 8 4>;
+	};
+
+	mtl_rx_setup: rx-queues-config {
+		snps,rx-queues-to-use = <4>;
+		snps,rx-sched-sp;
+
+		queue0 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x0>;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x0>;
+		};
+
+		queue2 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x0>;
+		};
+
+		queue3 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x0>;
+		};
+	};
+
+	mtl_tx_setup: tx-queues-config {
+		snps,tx-queues-to-use = <4>;
+		snps,tx-sched-wrr;
+
+		queue0 {
+			snps,weight = <0x10>;
+			snps,dcb-algorithm;
+			snps,priority = <0x0>;
+		};
+
+		queue1 {
+			snps,weight = <0x11>;
+			snps,dcb-algorithm;
+			snps,priority = <0x1>;
+		};
+
+		queue2 {
+			snps,weight = <0x12>;
+			snps,dcb-algorithm;
+			snps,priority = <0x2>;
+		};
+
+		queue3 {
+			snps,weight = <0x13>;
+			snps,dcb-algorithm;
+			snps,priority = <0x3>;
+		};
+	};
+
+	soc {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		compatible = "simple-bus";
+		ranges;
+
+		watchdog: watchdog@10007000 {
+			compatible = "mediatek,wdt";
+			reg = <0 0x10007000 0 0x100>;
+			status = "disabled";
+		};
+
+		gic: interrupt-controller@c000000 {
+			compatible = "arm,gic-v3";
+			#interrupt-cells = <4>;
+			interrupt-parent = <&gic>;
+			interrupt-controller;
+			reg = <0 0x0c000000 0 0x40000>,  /* GICD */
+			      <0 0x0c100000 0 0x200000>, /* GICR */
+			      <0 0x0c400000 0 0x2000>,   /* GICC */
+			      <0 0x0c410000 0 0x1000>,   /* GICH */
+			      <0 0x0c420000 0 0x2000>;   /* GICV */
+
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
+
+			ppi-partitions {
+				ppi_cluster0: interrupt-partition-0 {
+					affinity = <&cpu0 &cpu1 &cpu2 &cpu3 &cpu4>;
+				};
+
+				ppi_cluster1: interrupt-partition-1 {
+					affinity = <&cpu5>;
+				};
+			};
+		};
+
+		topckgen_clk: clock-controller@10000000 {
+			compatible = "mediatek,mt8366-topckgen";
+			reg = <0 0x10000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		infracfg_ao_clk: clock-controller@10001000 {
+			compatible = "mediatek,mt8366-infracfg-ao", "syscon";
+			reg = <0 0x10001000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		apmixedsys_clk: clock-controller@1000c000 {
+			compatible = "mediatek,mt8366-apmixedsys";
+			reg = <0 0x1000c000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		gce_clk: clock-controller@10228000 {
+			compatible = "mediatek,mt8366-gce";
+			reg = <0 0x10228000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		uart0: serial@11002000 {
+			compatible = "mediatek,hsuart";
+			reg = <0 0x11002000 0 0x1000>;
+			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_LOW 0>;
+			clock-frequency = <26000000>;
+			clocks = <&clk26m>, <&clk26m>;
+			clock-names = "baud", "bus";
+			status = "disabled";
+		};
+
+		spi0: spi@11010800 {
+			compatible = "mediatek,ipm-spi";
+			reg = <0 0x11010800 0 0x100>;
+			interrupts = <GIC_SPI 459 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&infracfg_ao_clk CLK_INFRACFG_AO_REG_SPI0>;
+			clock-names = "spi-clk";
+			status = "disabled";
+		};
+
+		spi1: spi@11011800 {
+			compatible = "mediatek,ipm-spi";
+			reg = <0 0x11011800 0 0x100>;
+			interrupts = <GIC_SPI 460 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&infracfg_ao_clk CLK_INFRACFG_AO_REG_SPI1>;
+			clock-names = "spi-clk";
+			status = "disabled";
+		};
+
+		spi2: spi@11012800 {
+			compatible = "mediatek,ipm-spi";
+			reg = <0 0x11012800 0 0x100>;
+			interrupts = <GIC_SPI 461 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&infracfg_ao_clk CLK_INFRACFG_AO_REG_SPI2>;
+			clock-names = "spi-clk";
+			status = "disabled";
+		};
+
+		spi3: spi@11013800 {
+			compatible = "mediatek,ipm-spi";
+			reg = <0 0x11013800 0 0x100>;
+			interrupts = <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&infracfg_ao_clk CLK_INFRACFG_AO_REG_SPI3>;
+			clock-names = "spi-clk";
+			status = "disabled";
+		};
+
+		spi4: spi@11014800 {
+			compatible = "mediatek,ipm-spi";
+			reg = <0 0x11014800 0 0x100>;
+			interrupts = <GIC_SPI 463 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&infracfg_ao_clk CLK_INFRACFG_AO_REG_SPI4>;
+			clock-names = "spi-clk";
+			status = "disabled";
+		};
+
+		spi5: spi@11015800 {
+			compatible = "mediatek,ipm-spi";
+			reg = <0 0x11015800 0 0x100>;
+			interrupts = <GIC_SPI 464 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&infracfg_ao_clk CLK_INFRACFG_AO_REG_SPI5>;
+			clock-names = "spi-clk";
+			status = "disabled";
+		};
+
+		i2c0: i2c@11fc0000 {
+			compatible = "mediatek,mt8171-i2c";
+			reg = <0 0x11fc0000 0 0x1000>,
+			      <0 0x10217080 0 0x200>;
+			interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&iic_wrap_e_clk CLK_IMPE_I2C0>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_DMA_B>;
+			clock-names = "main", "dma";
+			clock-div = <1>;
+		};
+
+		i2c1: i2c@11290000 {
+			compatible = "mediatek,mt8171-i2c";
+			reg = <0 0x11290000 0 0x1000>,
+			      <0 0x10217280 0 0x200>;
+			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&iic_wrap_c_clk CLK_IMPC_I2C1>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_DMA_B>;
+			clock-names = "main", "dma";
+			clock-div = <1>;
+		};
+
+		i2c2: i2c@11291000 {
+			compatible = "mediatek,mt8171-i2c";
+			reg = <0 0x11291000 0 0x1000>,
+			      <0 0x10217480 0 0x80>;
+			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&iic_wrap_c_clk CLK_IMPC_I2C2>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_DMA_B>;
+			clock-names = "main", "dma";
+			clock-div = <1>;
+		};
+
+		i2c3: i2c@11292000 {
+			compatible = "mediatek,mt8171-i2c";
+			reg = <0 0x11292000 0 0x1000>,
+			      <0 0x10217500 0 0x80>;
+			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&iic_wrap_c_clk CLK_IMPC_I2C3>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_DMA_B>;
+			clock-names = "main", "dma";
+			clock-div = <1>;
+		};
+
+		i2c4: i2c@11fc1000 {
+			compatible = "mediatek,mt8171-i2c";
+			reg = <0 0x11fc1000 0 0x1000>,
+			      <0 0x10217580 0 0x80>;
+			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&iic_wrap_e_clk CLK_IMPE_I2C4>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_DMA_B>;
+			clock-names = "main", "dma";
+			clock-div = <1>;
+		};
+
+		i2c5: i2c@11293000 {
+			compatible = "mediatek,mt8171-i2c";
+			reg = <0 0x11293000 0 0x1000>,
+			      <0 0x10217600 0 0x80>;
+			interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&iic_wrap_c_clk CLK_IMPC_I2C5>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_DMA_B>;
+			clock-names = "main", "dma";
+			clock-div = <1>;
+		};
+
+		i2c6: i2c@11294000 {
+			compatible = "mediatek,mt8171-i2c";
+			reg = <0 0x11294000 0 0x1000>,
+			      <0 0x10217680 0 0x80>;
+			interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&iic_wrap_c_clk CLK_IMPC_I2C6>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_DMA_B>;
+			clock-names = "main", "dma";
+			clock-div = <1>;
+		};
+
+		i2c7: i2c@11295000 {
+			compatible = "mediatek,mt8171-i2c";
+			reg = <0 0x11295000 0 0x1000>,
+			      <0 0x10217700 0 0x80>;
+			interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&iic_wrap_c_clk CLK_IMPC_I2C7>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_DMA_B>;
+			clock-names = "main", "dma";
+			clock-div = <1>;
+		};
+
+		i2c8: i2c@11296000 {
+			compatible = "mediatek,mt8171-i2c";
+			reg = <0 0x11296000 0 0x1000>,
+			      <0 0x10217780 0 0x80>;
+			interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&iic_wrap_c_clk CLK_IMPC_I2C8>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_DMA_B>;
+			clock-names = "main", "dma";
+			clock-div = <1>;
+		};
+
+		i2c9: i2c@11297000 {
+			compatible = "mediatek,mt8171-i2c";
+			reg = <0 0x11297000 0 0x1000>,
+			      <0 0x10217800 0 0x80>;
+			interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&iic_wrap_c_clk CLK_IMPC_I2C9>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_DMA_B>;
+			clock-names = "main", "dma";
+			clock-div = <1>;
+		};
+
+		eth: ethernet@11019000 {
+			compatible = "mediatek,mt8171-gmac", "snps,dwmac-5.10a";
+			reg = <0 0x11019000 0 0x4000>;
+			interrupts = <GIC_SPI 527 IRQ_TYPE_LEVEL_HIGH 0>;
+			interrupt-names = "macirq";
+			clock-names = "mac_main",
+				      "ptp_ref",
+				      "rmii_internal";
+			clocks = <&topckgen_clk CLK_TOP_SNPS_ETH_250M_SEL>,
+				 <&topckgen_clk CLK_TOP_SNPS_ETH_62P4M_PTP_SEL>,
+				 <&topckgen_clk CLK_TOP_SNPS_ETH_50M_RMII_SEL>;
+			assigned-clocks = <&topckgen_clk CLK_TOP_SNPS_ETH_250M_SEL>,
+					  <&topckgen_clk CLK_TOP_SNPS_ETH_62P4M_PTP_SEL>,
+					  <&topckgen_clk CLK_TOP_SNPS_ETH_50M_RMII_SEL>;
+			assigned-clock-parents = <&topckgen_clk CLK_TOP_ETHPLL_D2>,
+						 <&topckgen_clk CLK_TOP_ETHPLL_D8>,
+						 <&topckgen_clk CLK_TOP_ETHPLL_D10>;
+			mediatek,pericfg = <&infracfg_ao_clk>;
+			snps,axi-config = <&stmmac_axi_setup>;
+			snps,mtl-rx-config = <&mtl_rx_setup>;
+			snps,mtl-tx-config = <&mtl_tx_setup>;
+			snps,txpbl = <16>;
+			snps,rxpbl = <16>;
+			clk-csr = <2>;
+			status = "disabled";
+		};
+
+		mmc0: mmc@11230000 {
+			compatible = "mediatek,mt8366-mmc", "mediatek,mt8183-mmc";
+			reg = <0 0x11230000 0 0x1000>,
+			      <0 0x11ed0000 0 0x1000>;
+			interrupts-extended = <&gic GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&topckgen_clk CLK_TOP_MSDC50_0_SEL>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_MSDC0_H>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_MSDC0>;
+			clock-names = "source", "hclk", "source_cg";
+			status = "disabled";
+		};
+
+		pio: pinctrl@10005000 {
+			compatible = "mediatek,mt8366-pinctrl";
+			reg = <0 0x10005000 0 0x1000>,
+			      <0 0x11c30000 0 0x1000>,
+			      <0 0x11d40000 0 0x1000>,
+			      <0 0x11e20000 0 0x1000>,
+			      <0 0x11ea0000 0 0x1000>,
+			      <0 0x11f10000 0 0x1000>,
+			      <0 0x11f20000 0 0x1000>;
+			reg-names = "gpio", "iocfg_rm", "iocfg_bm",
+				    "iocfg_lb", "iocfg_tr", "iocfg_lt",
+				    "iocfg_tl";
+
+			gpio: gpio-controller {
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+		};
+
+		usb: usb@11200000 {
+			compatible = "mediatek,mtu3";
+			reg = <0 0x11200000 0 0x3e00>,
+			      <0 0x11203e00 0 0x0100>;
+			reg-names = "mac", "ippc";
+			phy-cells = <1>;
+			phys = <&u2port0 PHY_TYPE_USB2>;
+			mediatek,u3p-dis-msk = <0x1>;
+			clocks = <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB0_XCHI>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB0_SYS>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB0_H>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB0_F>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB0_REF>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB0_FRMCNT>;
+			clock-names = "host_ck",
+				      "sys_ck",
+				      "mcu_ck",
+				      "dma_ck",
+				      "ref_ck",
+				      "frmcnt_ck";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			status = "disabled";
+
+			ssusb: ssusb@11200000 {
+				compatible = "mediatek,ssusb";
+				reg = <0 0x11200000 0 0x3e00>;
+				reg-names = "mac";
+				interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH 0>;
+				status = "disabled";
+			};
+
+			xhci0: xhci@11200000 {
+				compatible = "mediatek,mtk-xhci";
+				reg = <0 0x11200000 0 0x1000>;
+				reg-names = "mac";
+				interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH 0>;
+				clocks = <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB0_XCHI>;
+				clock-names = "xhci_ck";
+				status = "disabled";
+			};
+		};
+
+		xhci1: xhci@11210000 {
+			compatible = "mediatek,mtk-xhci";
+			reg = <0 0x11210000 0 0x1000>,
+			      <0 0x11213e00 0 0x0100>;
+			reg-names = "mac", "ippc";
+			interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH 0>;
+			phy-cells = <1>;
+			phys = <&u2port1 PHY_TYPE_USB2>;
+			assigned-clocks = <&topckgen_clk CLK_TOP_USB_TOP_P1_SEL>,
+					  <&topckgen_clk CLK_TOP_USB_XHCI_P1_SEL>;
+			assigned-clock-parents = <&topckgen_clk CLK_TOP_UNIVPLL_D5_D4>,
+						 <&topckgen_clk CLK_TOP_UNIVPLL_D5_D4>;
+			clocks = <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB1_XCHI>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB1_SYS>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB1_H>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB1_F>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB1_REF>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB1_FRMCNT>;
+			clock-names = "xhci_ck",
+				      "sys_ck",
+				      "mcu_ck",
+				      "dma_ck",
+				      "ref_ck",
+				      "frmcnt_ck";
+			maximum-speed = "high-speed";
+			status = "disabled";
+		};
+
+		xhci2: xhci@11220000 {
+			compatible = "mediatek,mtk-xhci";
+			reg = <0 0x11220000 0 0x1000>,
+			      <0 0x11223e00 0 0x0100>;
+			reg-names = "mac", "ippc";
+			interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_HIGH 0>;
+			phy-cells = <1>;
+			phys = <&u2port2 PHY_TYPE_USB2>;
+			assigned-clocks = <&topckgen_clk CLK_TOP_USB_TOP_P2_SEL>,
+					  <&topckgen_clk CLK_TOP_USB_XHCI_P2_SEL>;
+			assigned-clock-parents = <&topckgen_clk CLK_TOP_UNIVPLL_D5_D4>,
+						 <&topckgen_clk CLK_TOP_UNIVPLL_D5_D4>;
+			clocks = <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB2_XCHI>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB2_SYS>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB2_H>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB2_F>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB2_REF>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB2_FRMCNT>;
+			clock-names = "xhci_ck",
+				      "sys_ck",
+				      "mcu_ck",
+				      "dma_ck",
+				      "ref_ck",
+				      "frmcnt_ck";
+			status = "disabled";
+		};
+
+		iic_wrap_c_clk: clock-controller@11298000 {
+			compatible = "mediatek,mt8366-iic-wrap-c";
+			reg = <0 0x11298000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		snor: spi@11018000 {
+			compatible = "mediatek,mt8366-nor";
+			reg = <0 0x11018000 0 0x1000>;
+			clocks = <&topckgen_clk CLK_TOP_SFLASH_SEL>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SFLASH>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SFLASH_F>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SFLASH_H>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SFLASH_P>;
+			clock-names = "spi", "sf", "axi_f", "axi_h", "axi_p";
+			assigned-clocks = <&topckgen_clk CLK_TOP_SFLASH_SEL>;
+			assigned-clock-parents = <&topckgen_clk CLK_TOP_UNIVPLL_D6_D8>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		u2phy2: phy@11e40000 {
+			compatible = "mediatek,generic-tphy-v2";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			status = "disabled";
+
+			u2port2: usb2-phy2@11e40000 {
+				reg = <0 0x11e40000 0 0x700>;
+				clocks = <&topckgen_clk CLK_TOP_USB2_PHY_REFCK_P2_EN>;
+				clock-names = "ref";
+				#phy-cells = <1>;
+			};
+		};
+
+		u3phy0: phy@11e80000 {
+			compatible = "mediatek,generic-tphy-v2";
+			reg = <0 0x11e80000 0 0x1000>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			status = "disabled";
+
+			u2port0: usb2-phy@11e80000 {
+				reg = <0 0x11e80000 0 0x700>;
+				#phy-cells = <1>;
+				clocks = <&topckgen_clk CLK_TOP_USB2_PHY_REFCK_P0_EN>;
+				clock-names = "ref";
+			};
+		};
+
+		dptx_clk: clock-controller@11ec1400 {
+			compatible = "mediatek,mt8366-dptx";
+			reg = <0 0x11ec1400 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		u2phy1: phy@11ef0000 {
+			compatible = "mediatek,generic-tphy-v2";
+			reg = <0 0x11ef0000 0 0x1000>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			status = "disabled";
+
+			u2port1: usb2-phy1@11ef0000 {
+				reg = <0 0x11ef0000 0 0x700>;
+				clocks = <&topckgen_clk CLK_TOP_USB2_PHY_REFCK_P1_EN>;
+				clock-names = "ref";
+				#phy-cells = <1>;
+			};
+		};
+
+		iic_wrap_e_clk: clock-controller@11fc2000 {
+			compatible = "mediatek,mt8366-iic-wrap-e";
+			reg = <0 0x11fc2000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		dispsys_clk: clock-controller@14000000 {
+			compatible = "mediatek,mt8366-dispsys";
+			reg = <0 0x14000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		epdsys_clk: clock-controller@1c000000 {
+			compatible = "mediatek,mt8366-epdsys";
+			reg = <0 0x1c000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+	};
+};

-- 
2.43.0

