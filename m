Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF780C5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 16:13:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C4A780E36;
	Fri,  7 Aug 2026 16:13:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s88J04KTQAYF; Fri,  7 Aug 2026 16:13:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 27DBB81346
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786119215;
	bh=ex/rKhBqYbZpXngirvybVlP1raweyWcH9qxOD/Y+/Xs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f7xtWn0NFjrI/hAb0+WqEOZnmUkTNa7u9kmNwwzEJDAQy4s6D29R1DIE1cr2Rh3nr
	 GjrX6I+W+aF+ztO7boW13dNpQYX9KHVpzsRaC6xSqRrbdSUQz6a5oIVXMOd3Ltv7Sf
	 mgBNE5q/v2NzLVUGHQYwOEnWF4Zjqk1WtOujfouadUzjvvUPc9DIuTwr85n3M6klGl
	 fSv2sql3Br7U6+p6xT3kBfzmvXo0A3ANIQp4vqWTeyi1Nru2Tk7fxVxceAt+1bPDMi
	 hLXgRVraMGmJazR0tsSAoa/MOog6coPc8e0huSaCUHELxPBzoN3J8ZfSxul5qoCfN7
	 eNGB7fxsV+a3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 27DBB81346;
	Fri,  7 Aug 2026 16:13:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 199E5198
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:13:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0054E607FF
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:13:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hrjCzaMEc4Qy for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 16:13:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::336; helo=mail-ot1-x336.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7585E607E6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7585E607E6
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7585E607E6
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:13:31 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7eb4d532e65so1678085a34.0
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 09:13:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786119210; x=1786724010;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ex/rKhBqYbZpXngirvybVlP1raweyWcH9qxOD/Y+/Xs=;
 b=XaVMpMYXd6C/9VqYgrUmlfs+h44MxXjwdQW23Uo2nXjqRfk7EzKbEpi8xzP0r7IU/4
 IU5wGVsh7V/tostbjuGQidXY+VOcvs0l/kemjA3Pu3k/dc/1y9nv/c4K2GEHAi2Qs8dg
 912pwZd2aixbtD1W1g63aeUyPaTdb1+oyPs84ruo9+NhbenmqVsVPmoivBAYLzXNwWvf
 8idR/t1Euh0mTuavux93XWXahPaMDVcbGWXo/z3LRzyMuw7CaOiayIG/3FRjfXMtt1gO
 X9O/h1eqtHJTUfBzF6jukTRRNq4ZzmgBW+rEMlIWHSciQj/xCKLopXc6Cm2iLufcr+ii
 T23Q==
X-Gm-Message-State: AOJu0YwvBMVuGf82qWbolTVZEquBHWS6orfxZIkBEbIseLQXRLLSjIWy
 FgYW4l/RdP+cjB3Aj+R1Q24RFeYGHS4p7HTus1abmbYX/5YQiFgzEhA4JecG0C81yeTsIPob6wc
 3Eo42aUQ=
X-Gm-Gg: AR+sD12yeWDRoXASBQ1WEP+pcSYUDXQZ2EiETeliOB540GnjPX5qXN6pk66Z2i91oGL
 kFgsnmLAkgNqH/17/0Vg2P5RIaNiTnQBhS4tCg3jQcr+OML3GnxVRsIrQ99vQ3klUR7iSPsyt9L
 V4Pddp8Qs31D2LTAF7meutDSPdey2ayDOlFOW5HWehoa2jSQ5QKh4RC446sXW0rOeLtpnORu5df
 Uzq4evMu7c5cK4edcJQBpRSvcxBLQ2bk7JRyio5Qi7MtLZY9+AIo9BeEqEjpa95HfgSP4FdypwQ
 r90L+vy581HfDIxmjltkIRISn3ZnIxypGo2XHWc2oXrpOTv+soKPHgNMaaCRcQPoBwX/HACNWqV
 rHbtZA447/TLdKBqFe3lTHbX85VDuYhYVssSXnsGVGSNBa23s8kuGZsGIi6fUbFvJzMXp/NxVS4
 pb0twD52sbvqnq4mrJKDhg3RFGa0aQ6tRfI3RPABSnv/Jb8XsyimO7m6osNuyUA2sN
X-Received: by 2002:a05:6830:81fb:b0:7e9:e488:3bce with SMTP id
 46e09a7af769-7f1e5cc39f2mr15798123a34.6.1786119210034; 
 Fri, 07 Aug 2026 09:13:30 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b714:88c:313d:dee2])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f35b7b9678sm1537878a34.21.2026.08.07.09.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 09:13:29 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 07 Aug 2026 11:12:51 -0500
Subject: [PATCH v2 1/4] arm: dts: add MT8366 application processor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-mtk-genio-360-bringup-v2-1-7c3830297d97@baylibre.com>
References: <20260807-mtk-genio-360-bringup-v2-0-7c3830297d97@baylibre.com>
In-Reply-To: <20260807-mtk-genio-360-bringup-v2-0-7c3830297d97@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=21488;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=UdnABiBTvN2UdiJitXKyxg16S/SKVneYHRwDT2yiVEM=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqdgQNQUPR7Q1W+fJ1XCrMeg8Ojrt0ZabP6KbNp
 LEe9DjJ/0iJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanYEDRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AfCAH/2tglfc3sNW0cAZw+MRukWTreNUN/+m767WIdRe
 YVhBfbXLxLWfoPZoWV6f0KRf7diCv6IueyQWy1ZF7qFI1x+d3+l4kJ0liO7XQayO/vBcwM+PlqQ
 vVGzfTEpV+xsu+/50bpjNgLVBUBTKtEb7Noz+d9pNSpCBWwIW0T2AZtEmUAB4QTmr3VdIiZVEFZ
 /IJdYB7SVHu+/IPoT1FSK49U+NiiruVfJJx84u99M+jgbFAzePVnZG8Tpv9fDwoRSVEM1c0Tp8L
 OP/OkPhrivAaQoJzqSwhFGJNG6uBprKZewGOyZMxOSa6AEANB7R2/iNtAzJ3UDXaLVG4aU8benK
 +oHs=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786119210; x=1786724010;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ex/rKhBqYbZpXngirvybVlP1raweyWcH9qxOD/Y+/Xs=;
 b=dZMIJFLZJXlfevAHfYC5nU2WvWXkuvX2r00CXiltPmDTtdN+ATz6dnDPoCp95xiRtc
 If6fXKnDmZrd0oBYfmfqtv1Uci6P4vosWDvwFH5UhIaGWJNNdgoGTQltf1rmnLX+YrbH
 vgCOEqTj2l+h8iueuS4J6ez2WWrvYxJAvYARXl2+a7rgU31WW3b3llrbMBvn4lSJHnv1
 XAbYAHz4Snvsr9TzTo9UIOXjfhfxPj1EF7lcq/fE6AVeWIfTUbmprHVJ03ShQmcg+aRZ
 9Cc68BjOzSMZrUjMw71FCVz3TViimVDblO+vGrScDCAfmea2xxA0IWupaS9XpqesfM1B
 0xbA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=dZMIJFLZ
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
 arch/arm/dts/mt8366.dtsi | 693 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 693 insertions(+)

diff --git a/arch/arm/dts/mt8366.dtsi b/arch/arm/dts/mt8366.dtsi
new file mode 100644
index 00000000000..dec3315ee3d
--- /dev/null
+++ b/arch/arm/dts/mt8366.dtsi
@@ -0,0 +1,693 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+/*
+ * Copyright (C) 2026 MediaTek Inc.
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
+			compatible = "mediatek,mt6589-wdt";
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
+			compatible = "mediatek,mt8366-topckgen", "syscon";
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
+			compatible = "mediatek,mt8366-apmixedsys" , "syscon";
+			reg = <0 0x1000c000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		pwrap: pwrap@10026000 {
+			compatible = "mediatek,mt8366-pwrap", "mediatek,mt8195-pwrap", "syscon";
+			reg = <0 0x10026000 0 0x1000>;
+			reg-names = "pwrap";
+			interrupts = <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&infracfg_ao_clk CLK_INFRACFG_AO_REG_PMIC_AP>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REG_PMIC_TMR>,
+				 <&topckgen_clk CLK_TOP_PWRAP_ULPOSC_SEL>,
+				 <&topckgen_clk CLK_TOP_OSC_D10>;
+			clock-names = "spi", "wrap", "sys", "tmr";
+		};
+
+		gce_clk: clock-controller@10228000 {
+			compatible = "mediatek,mt8366-gce", "syscon";
+			reg = <0 0x10228000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		uart0: serial@11002000 {
+			compatible = "mediatek,mt8366-uart", "mediatek,mt6577-uart";
+			reg = <0 0x11002000 0 0x1000>;
+			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_LOW 0>;
+			clocks = <&clk26m>, <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_UART0>;
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
+			compatible = "mediatek,mt8366-i2c";
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
+			compatible = "mediatek,mt8366-i2c";
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
+			compatible = "mediatek,mt8366-i2c";
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
+			compatible = "mediatek,mt8366-i2c";
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
+			compatible = "mediatek,mt8366-i2c";
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
+			compatible = "mediatek,mt8366-i2c";
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
+			compatible = "mediatek,mt8366-i2c";
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
+			compatible = "mediatek,mt8366-i2c";
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
+			compatible = "mediatek,mt8366-i2c";
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
+			compatible = "mediatek,mt8366-i2c";
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
+			compatible = "mediatek,mt8366-gmac", "snps,dwmac-5.10a";
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
+			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&topckgen_clk CLK_TOP_MSDC50_0_SEL>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_MSDC0_H>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_MSDC0>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_MSDC0_MST_F>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_MSDC0_SLV_H>;
+			clock-names = "source", "hclk", "source_cg", "bus_clk", "macro";
+			status = "disabled";
+		};
+
+		mmc1: mmc@11240000 {
+			compatible = "mediatek,mt8366-mmc", "mediatek,mt8183-mmc";
+			reg = <0 0x11240000 0 0x1000>,
+			      <0 0x11e90000 0 0x1000>;
+			interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&topckgen_clk CLK_TOP_MSDC30_1_SEL>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_MSDC1_H>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_MSDC1>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_MSDC1_MST_F>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_MSDC1_SLV_H>;
+			clock-names = "source", "hclk", "source_cg", "bus_clk", "macro";
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
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		ssusb: usb@11201000 {
+			compatible = "mediatek,mt8366-mtu3", "mediatek,mtu3";
+			reg = <0 0x11201000 0 0x2e00>,
+			      <0 0x11203e00 0 0x0100>;
+			reg-names = "mac", "ippc";
+			interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH 0>;
+			phys = <&u2port0 PHY_TYPE_USB2>,
+			       <&u3port0 PHY_TYPE_USB3>;
+			assigned-clocks = <&topckgen_clk CLK_TOP_USB_TOP_P0_SEL>;
+			assigned-clock-parents = <&topckgen_clk CLK_TOP_UNIVPLL_D5_D4>;
+			clocks = <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB0_SYS>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB0_REF>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB0_H>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB0_F>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB0_XCHI>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB0_FRMCNT>;
+			clock-names = "sys_ck",
+				      "ref_ck",
+				      "mcu_ck",
+				      "dma_ck",
+				      "xhci_ck",
+				      "frmcnt_ck";
+			mediatek,syscon-wakeup = <&infracfg_ao_clk 0x3d4 103>;
+			dr_mode = "otg";
+			usb-role-switch;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			usb_host0: usb@11200000 {
+				compatible = "mediatek,mt8366-xhci", "mediatek,mtk-xhci";
+				reg = <0 0x11200000 0 0x1000>;
+				reg-names = "mac";
+				interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH 0>;
+				assigned-clocks = <&topckgen_clk CLK_TOP_USB_XHCI_P0_SEL>;
+				assigned-clock-parents = <&topckgen_clk CLK_TOP_UNIVPLL_D5_D4>;
+				clocks = <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB0_SYS>,
+					 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB0_REF>,
+					 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB0_H>,
+					 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB0_F>,
+					 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB0_XCHI>;
+				clock-names = "sys_ck",
+					      "ref_ck",
+					      "mcu_ck",
+					      "dma_ck",
+					      "xhci_ck";
+			};
+		};
+
+		usb_host1: usb@11210000 {
+			compatible = "mediatek,mt8366-xhci", "mediatek,mtk-xhci";
+			reg = <0 0x11210000 0 0x1000>,
+			      <0 0x11213e00 0 0x0100>;
+			reg-names = "mac", "ippc";
+			interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH 0>;
+			phys = <&u2port1 PHY_TYPE_USB2>;
+			assigned-clocks = <&topckgen_clk CLK_TOP_USB_TOP_P1_SEL>,
+					  <&topckgen_clk CLK_TOP_USB_XHCI_P1_SEL>;
+			assigned-clock-parents = <&topckgen_clk CLK_TOP_UNIVPLL_D5_D4>,
+						 <&topckgen_clk CLK_TOP_UNIVPLL_D5_D4>;
+			clocks = <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB1_SYS>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB1_REF>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB1_H>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB1_F>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB1_XCHI>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB1_FRMCNT>;
+			clock-names = "sys_ck",
+				      "ref_ck",
+				      "mcu_ck",
+				      "dma_ck",
+				      "xhci_ck",
+				      "frmcnt_ck";
+			mediatek,syscon-wakeup = <&infracfg_ao_clk 0x3dc 107>;
+			status = "disabled";
+		};
+
+		usb_host2: usb@11220000 {
+			compatible = "mediatek,mt8366-xhci", "mediatek,mtk-xhci";
+			reg = <0 0x11220000 0 0x1000>,
+			      <0 0x11223e00 0 0x0100>;
+			reg-names = "mac", "ippc";
+			interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_HIGH 0>;
+			phys = <&u2port2 PHY_TYPE_USB2>;
+			assigned-clocks = <&topckgen_clk CLK_TOP_USB_TOP_P2_SEL>,
+					  <&topckgen_clk CLK_TOP_USB_XHCI_P2_SEL>;
+			assigned-clock-parents = <&topckgen_clk CLK_TOP_UNIVPLL_D5_D4>,
+						 <&topckgen_clk CLK_TOP_UNIVPLL_D5_D4>;
+			clocks = <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB2_SYS>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB2_REF>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB2_H>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB2_F>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB2_XCHI>,
+				 <&infracfg_ao_clk CLK_INFRACFG_AO_REGP_SSUSB2_FRMCNT>;
+			clock-names = "sys_ck",
+				      "ref_ck",
+				      "mcu_ck",
+				      "dma_ck",
+				      "xhci_ck",
+				      "frmcnt_ck";
+			mediatek,syscon-wakeup = <&infracfg_ao_clk 0x3e4 107>;
+			status = "disabled";
+		};
+
+		u2phy2: t-phy@11e40000 {
+			compatible = "mediatek,mt8366-tphy", "mediatek,generic-tphy-v3";
+			reg = <0 0x11e40000 0 0x400>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			status = "disabled";
+
+			u2port2: usb-phy@11e40000 {
+				reg = <0 0x11e40000 0 0x700>;
+				clocks = <&topckgen_clk CLK_TOP_USB2_PHY_REFCK_P2_EN>;
+				clock-names = "ref";
+				#phy-cells = <1>;
+			};
+		};
+
+		u3phy0: t-phy@11e80000 {
+			compatible = "mediatek,mt8366-tphy", "mediatek,generic-tphy-v3";
+			reg = <0 0x11e80000 0 0x400>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			status = "disabled";
+
+			u2port0: usb-phy@11e80000 {
+				reg = <0 0x11e80000 0 0x700>;
+				clocks = <&topckgen_clk CLK_TOP_USB2_PHY_REFCK_P0_EN>;
+				clock-names = "ref";
+				#phy-cells = <1>;
+			};
+
+			u3port0: usb-phy@11e80700 {
+				reg = <0 0x11e80700 0 0x700>;
+				clocks = <&topckgen_clk CLK_TOP_USB2_PHY_REFCK_P0_EN>;
+				clock-names = "ref";
+				#phy-cells = <1>;
+			};
+		};
+
+		u2phy1: t-phy@11ef0000 {
+			compatible = "mediatek,mt8366-tphy", "mediatek,generic-tphy-v3";
+			reg = <0 0x11ef0000 0 0x400>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			status = "disabled";
+
+			u2port1: usb-phy@11ef0000 {
+				reg = <0 0x11ef0000 0 0x700>;
+				clocks = <&topckgen_clk CLK_TOP_USB2_PHY_REFCK_P1_EN>;
+				clock-names = "ref";
+				#phy-cells = <1>;
+			};
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

