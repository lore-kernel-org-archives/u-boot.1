Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A8210FCAE8
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 21:54:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2396E83CE3;
	Wed,  1 Apr 2026 23:54:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mNgvrtt/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5D52840B5; Wed,  1 Apr 2026 23:54:22 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C159680517
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 23:54:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d7e5e8c907so174342a34.0
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 14:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1775080458; x=1775685258;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=if8qA5Q3rrt+7hDIa9byY/lifIqTvlXPsbMeTLaYUWY=;
 b=mNgvrtt/wJ7G5Pa/PY7YYo344eLxVgQwN8H4c2KeGj+4oBlMtHHy2PCzlrI1wMo2qw
 72as3xKqjJrFldjCT8EzYomv5xye8qazQ3qE35wBcIQxUZcTMU3LFgQoA98UTtMlA5MY
 9rnD1rGVTRVG3LuFFiWoqTXe/1vSJmF34HBBiGNn4yBBR8Z6HltsGIB+NpO2OJ4dGkLY
 BOG8lsi9KbD+YMw5INs53lTcrxKh19QXHhiCoxpO9QW00ccJ30Tg9DXJSg+gWLOaSIlt
 dzbMpWJbbRQqktnBwpP8cFIJcqjjDhn4e8saBDlscWZT2Fs2ZT2m/a3P1cI2Tm7Hkncm
 NYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775080458; x=1775685258;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=if8qA5Q3rrt+7hDIa9byY/lifIqTvlXPsbMeTLaYUWY=;
 b=FpshhzWNicjYpuSegybVZ4JwF3Cpfw1ipj6HKpkDJwP6sJsWZXUUZ/tYQkrcb9/uUt
 dqoishj9/jserwPUqaVpzXdd51uvTD+0eVpo5Z8hulfKFctMRPb7Z/sbsGaHX1s1o1y9
 18I9dkdZwBUVVptDInK2+HjCob091LPMudSHiI6Sq/R+xUzepEezwoHopyhKqsGjgdw/
 DN8jqQyt8gETzVDM1t/DPQsV3XYXZ1w6hKApaZu0RU8kESjBm3FycQgV5yCTgC2PJDrr
 RBBKeV5YhbjreefZpe7pX9qGyRSN0iA/LEfvmgzhQAOv3jVXsnUc8m3VO6/XvurMFIqT
 T4TA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWj7U5yVJSHH25iGKTkcZRdDTgOlLjO74ILQHpd8lpywYJs9JvYqSZfoDYNCipS7qluPAXFMHQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyHetyEjyY4JbG4U8waUgv1d3RHtFWLNp5JRCF+LWsKjV49fa/h
 v7G/f6i9N/XRnTjBvK699uTkOEVkdcUwMXPMSaZ+SUYMcNFiE2dtEotzRs2stEk26yc=
X-Gm-Gg: ATEYQzx1LDVUx49lu6buVOlbP7cNIKhQGeIYZ491KSEsFhIT82WVCUZmQtMPExwgL99
 Ie82h7nQ1u8yHkIvEbXFBqGdDrn1F/eh6HMF9dxgEiZgU4/klkJEzuLJdJlJeSx+RtfuoflPinp
 2CfF8Vyc46mfN8FI/zieiqGl+Vsdvyb1UTSSQPQDqt+AzFYzaZwuJpbY35d948SidY2ZWjyW9sY
 TQAEyJWtUAZgjWkfsyukwzV4NL3rdG465DjsOpTwCRLVYXX6CPEEhY0q8X7iu42MpBYcyx03JYC
 +AIev7mx2s7HjusmaJdNOznOrmnWudzeZEQvbFxISm9k221cAHzZfG/UzX6KR9uEjpFr1MgNDsB
 v3SMUtBDTpDBPfY742XRfdoTp3hxpVUU11gWvj8vbORGVFCCpgG7GQHDP/WV+APE4YOr8JpmdT5
 MIwCO4VdDZDPE3/uZviRnqmiY3sBef
X-Received: by 2002:a05:6830:81da:b0:7d7:dfc6:e1d1 with SMTP id
 46e09a7af769-7dba7dca046mr821467a34.3.1775080457866; 
 Wed, 01 Apr 2026 14:54:17 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:57c4:ef89:4ac4:d6d9])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dba7184e14sm743492a34.11.2026.04.01.14.54.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 14:54:17 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 01 Apr 2026 16:53:46 -0500
Subject: [PATCH 2/3] arm: dts: mediatek: add USB/PHY nodes for Genio
 520/720
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-mtk-mt8189-usb-v1-2-a4bf951aa8ad@baylibre.com>
References: <20260401-mtk-mt8189-usb-v1-0-a4bf951aa8ad@baylibre.com>
In-Reply-To: <20260401-mtk-mt8189-usb-v1-0-a4bf951aa8ad@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=10606;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=wFDvqO94INRvOY6w/VFTGlICghIPP89IJAYu0aFzDEQ=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpzZP4YJfIqlRhSZv2VFTbfgoqAyGsGpH+KDgyh
 MvXciDnVrKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCac2T+BYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AAa4H/jFRjZMZH0PAFpQ1MCxLX9oDEErhP0l8PGqwg6f
 fdzIlXcEkzqS+2uxo5ElkWfjX0cmD91PtEnU4xKdwOVUTTq4vM2yio9iCr/aZAmh/nukkFBkig+
 CQff3yWW3aKugEIyvp7rtXLhszz9hT6MdR4LLsMK48ykrMooMf3ZyXHp7jwk908pBLu4h1P3xU4
 Q1czRqsCmLaaG6bw/85iTHXzJqSlm7nUZ03uaYnhTSfNAN+K85FD+z56DD+3hRgH6NYi2kyQ3PW
 e5uxJh83jzjNRD0s6QHVxKX7CjSTpFueDoPcCfHHwQU2SFnURsBpLYpJqyu293Z/ac5TyzKorV6
 oPBY=
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

Add USB and PHY nodes for USB support on Genio 520/720 EVKs.

The devicetree hasn't been accepted upstream yet, so this comes from the
latest submission [1]. Some power domain and reset references have been
left out to minimize what we need to add at this time since U-Boot
doesn't need them.

Link: https://lore.kernel.org/linux-mediatek/20251111070031.305281-10-jh.hsu@mediatek.com/ [1]
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/mt8189.dtsi              | 210 ++++++++++++++++++++++++++++++++++
 arch/arm/dts/mt8371-genio-common.dtsi |  70 ++++++++++++
 2 files changed, 280 insertions(+)

diff --git a/arch/arm/dts/mt8189.dtsi b/arch/arm/dts/mt8189.dtsi
index e9fd21ea095..e550745ac5d 100644
--- a/arch/arm/dts/mt8189.dtsi
+++ b/arch/arm/dts/mt8189.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/clock/mediatek,mt8189-clk.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/phy/phy.h>
 #include <dt-bindings/reset/ti-syscon.h>
 
 / {
@@ -180,6 +181,79 @@
 			status = "disabled";
 		};
 
+		xhci0: usb@11200000 {
+			compatible = "mediatek,mt8189-xhci", "mediatek,mtk-xhci";
+			reg = <0 0x11200000 0 0x1000>,
+			      <0 0x11203e00 0 0x0100>;
+			reg-names = "mac", "ippc";
+			interrupts-extended = <&gic GIC_SPI 385 IRQ_TYPE_LEVEL_HIGH 0>,
+					      <&pio 207 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "host","wakeup";
+			phys = <&u2port0 PHY_TYPE_USB2>,
+			       <&u3port0 PHY_TYPE_USB3>;
+			clocks = <&pericfg_ao_clk CLK_PERAO_SSUSB0_SYS>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB0_REF>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB0_H>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB0_F>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB0_XHCI>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB0_FRMCNT>;
+			clock-names = "sys_ck", "ref_ck", "mcu_ck",
+				      "dma_ck", "xhci_ck", "frmcnt_ck";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			wakeup-source;
+			mediatek,syscon-wakeup = <&pericfg_ao_clk 0x214 110>;
+			status = "disabled";
+		};
+
+		xhci1: usb@11210000 {
+			compatible = "mediatek,mt8189-xhci", "mediatek,mtk-xhci";
+			reg = <0 0x11210000 0 0x1000>,
+			      <0 0x11213e00 0 0x0100>;
+			reg-names = "mac", "ippc";
+			interrupts-extended = <&gic GIC_SPI 386 IRQ_TYPE_LEVEL_HIGH 0>,
+					      <&pio 203 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "host","wakeup";
+			phys = <&u2port1 PHY_TYPE_USB2>;
+			clocks = <&pericfg_ao_clk CLK_PERAO_SSUSB1_SYS>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB1_REF>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB1_H>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB1_F>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB1_XHCI>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB1_FRMCNT>;
+			clock-names = "sys_ck", "ref_ck","mcu_ck",
+				      "dma_ck", "xhci_ck", "frmcnt_ck";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			wakeup-source;
+			mediatek,syscon-wakeup = <&pericfg_ao_clk 0x21c 110>;
+			status = "disabled";
+		};
+
+		xhci2: usb@11220000 {
+			compatible = "mediatek,mt8189-xhci", "mediatek,mtk-xhci";
+			reg = <0 0x11220000 0 0x1000>,
+			      <0 0x11223e00 0 0x0100>;
+			reg-names = "mac", "ippc";
+			interrupts-extended = <&gic GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH 0>,
+					      <&pio 193 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "host","wakeup";
+			phys = <&u2port2 PHY_TYPE_USB2>;
+			clocks = <&pericfg_ao_clk CLK_PERAO_SSUSB2_SYS>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB2_REF>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB2_H>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB2_F>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB2_XHCI>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB2_FRMCNT>;
+			clock-names = "sys_ck", "ref_ck","mcu_ck",
+				      "dma_ck", "xhci_ck", "frmcnt_ck";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			wakeup-source;
+			mediatek,syscon-wakeup = <&pericfg_ao_clk 0x27c 110>;
+			status = "disabled";
+		};
+
 		mmc0: mmc@11230000 {
 			compatible = "mediatek,mt8189-mmc";
 			reg = <0 0x11230000 0 0x10000>,
@@ -204,6 +278,55 @@
 			status = "disabled";
 		};
 
+		xhci3: usb@11260000 {
+			compatible = "mediatek,mt8189-xhci", "mediatek,mtk-xhci";
+			reg = <0 0x11260000 0 0x2e00>,
+			      <0 0x11263e00 0 0x0100>;
+			reg-names = "mac", "ippc";
+			interrupts-extended = <&gic GIC_SPI 473 IRQ_TYPE_LEVEL_HIGH 0>,
+					      <&pio 188 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "host","wakeup";
+			phys = <&u2port3 PHY_TYPE_USB2>,
+			       <&u3port3 PHY_TYPE_USB3>;
+			clocks = <&pericfg_ao_clk CLK_PERAO_SSUSB3_SYS>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB3_REF>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB3_H>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB3_F>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB3_XHCI>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB3_FRMCNT>;
+			clock-names = "sys_ck", "ref_ck", "mcu_ck",
+				      "dma_ck", "xhci_ck", "frmcnt_ck";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			wakeup-source;
+			mediatek,syscon-wakeup = <&pericfg_ao_clk 0x284 110>;
+			status = "disabled";
+		};
+
+		xhci4: usb@11270000 {
+			compatible = "mediatek,mt8189-xhci", "mediatek,mtk-xhci";
+			reg = <0 0x11270000 0 0x1000>,
+			      <0 0x11273e00 0 0x0100>;
+			reg-names = "mac", "ippc";
+			interrupts-extended = <&gic GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH 0>,
+					      <&pio 184 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "host","wakeup";
+			phys = <&u2port4 PHY_TYPE_USB2>;
+			clocks = <&pericfg_ao_clk CLK_PERAO_SSUSB4_SYS>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB4_REF>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB4_H>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB4_F>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB4_XHCI>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB4_FRMCNT>;
+			clock-names = "sys_ck", "ref_ck", "mcu_ck",
+				      "dma_ck", "xhci_ck", "frmcnt_ck";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			wakeup-source;
+			mediatek,syscon-wakeup = <&pericfg_ao_clk 0x28c 110>;
+			status = "disabled";
+		};
+
 		clock-controller@1000c000 {
 			compatible = "mediatek,mt8189-apmixedsys", "syscon";
 			reg = <0 0x1000c000 0 0x1000>;
@@ -359,6 +482,93 @@
 			status = "disabled";
 		};
 
+		u3phy3: t-phy@11b00000 {
+			compatible = "mediatek,mt8189-tphy",
+				     "mediatek,generic-tphy-v2";
+			reg = <0 0x11b00000 0 0x700>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			u2port3: usb-phy@11b00000 {
+				reg = <0 0x11b00000 0 0x700>;
+				clocks = <&topckgen_clk CLK_TOP_USB2_PHY_RF_P3_EN>;
+				clock-names = "ref";
+				#phy-cells = <1>;
+			};
+
+			u3port3: usb-phy@11b00700 {
+				reg = <0 0x11b00700 0 0x700>;
+				clocks = <&topckgen_clk CLK_TOP_USB2_PHY_RF_P3_EN>;
+				clock-names = "ref";
+				#phy-cells = <1>;
+			};
+		};
+
+		u2phy4: xs-phy@11b10000 {
+			compatible = "mediatek,mt8189-xsphy", "mediatek,xsphy";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			u2port4: usb-phy@11b10000 {
+				reg = <0 0x11b10000 0 0x700>;
+				clocks = <&topckgen_clk CLK_TOP_USB2_PHY_RF_P4_EN>;
+				clock-names = "ref";
+				#phy-cells = <1>;
+			};
+		};
+
+		u3phy0: xs-phy@11e80000 {
+			compatible = "mediatek,mt8189-xsphy", "mediatek,xsphy";
+			reg = <0 0x11e83000 0 0x200>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			u2port0: usb-phy@11e80000 {
+				reg = <0 0x11e80000 0 0x700>;
+				clocks = <&topckgen_clk CLK_TOP_USB2_PHY_RF_P0_EN>;
+				clock-names = "ref";
+				#phy-cells = <1>;
+			};
+
+			u3port0: usb-phy@11e83000 {
+				reg = <0 0x11e83400 0 0x500>;
+				clocks = <&topckgen_clk CLK_TOP_USB2_PHY_RF_P0_EN>;
+				clock-names = "ref";
+				#phy-cells = <1>;
+			};
+		};
+
+		u2phy1: xs-phy@11e90000 {
+			compatible = "mediatek,mt8189-xsphy", "mediatek,xsphy";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			u2port1: usb-phy@11e90000 {
+				reg = <0 0x11e90000 0 0x700>;
+				clocks = <&topckgen_clk CLK_TOP_USB2_PHY_RF_P1_EN>;
+				clock-names = "ref";
+				#phy-cells = <1>;
+			};
+		};
+
+		u2phy2: xs-phy@11ef0000 {
+			compatible = "mediatek,mt8189-xsphy", "mediatek,xsphy";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			u2port2: usb-phy@11ef0000 {
+				reg = <0 0x11ef0000 0 0x700>;
+				clocks = <&topckgen_clk CLK_TOP_USB2_PHY_RF_P2_EN>;
+				clock-names = "ref";
+				#phy-cells = <1>;
+			};
+		};
+
 		ufscfg_ao_reg_clk: syscon@112b8000 {
 			compatible = "mediatek,mt8189-ufscfg-ao", "syscon", "simple-mfd";
 			reg = <0 0x112b8000 0 0x1000>;
diff --git a/arch/arm/dts/mt8371-genio-common.dtsi b/arch/arm/dts/mt8371-genio-common.dtsi
index 58322193aef..046e9d57752 100644
--- a/arch/arm/dts/mt8371-genio-common.dtsi
+++ b/arch/arm/dts/mt8371-genio-common.dtsi
@@ -19,6 +19,51 @@
 		stdout-path = "serial0:921600n8";
 	};
 
+	usb_p0_vbus: regulator@0 {
+		compatible = "regulator-fixed";
+		regulator-name = "p0_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pio 82 0>;
+		enable-active-high;
+	};
+
+	usb_p1_vbus: regulator@1 {
+		compatible = "regulator-fixed";
+		regulator-name = "p1_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pio 84 0>;
+		enable-active-high;
+	};
+
+	usb_p2_vbus: regulator@2 {
+		compatible = "regulator-fixed";
+		regulator-name = "p2_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pio 85 0>;
+		enable-active-high;
+	};
+
+	usb_p3_vbus: regulator@3 {
+		compatible = "regulator-fixed";
+		regulator-name = "p3_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pio 86 0>;
+		enable-active-high;
+	};
+
+	usb_p4_vbus: regulator@4 {
+		compatible = "regulator-fixed";
+		regulator-name = "p4_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pio 87 0>;
+		enable-active-high;
+	};
+
 	firmware {
 		optee {
 			compatible = "linaro,optee-tz";
@@ -241,3 +286,28 @@
 &pmic {
 	interrupts-extended = <&pio 194 IRQ_TYPE_LEVEL_HIGH>;
 };
+
+&xhci0{
+	vbus-supply = <&usb_p0_vbus>;
+	status = "okay";
+};
+
+&xhci1{
+	vbus-supply = <&usb_p1_vbus>;
+	status = "okay";
+};
+
+&xhci2{
+	vbus-supply = <&usb_p2_vbus>;
+	status = "okay";
+};
+
+&xhci3{
+	vbus-supply = <&usb_p3_vbus>;
+	status = "okay";
+};
+
+&xhci4{
+	vbus-supply = <&usb_p4_vbus>;
+	status = "okay";
+};

-- 
2.43.0

