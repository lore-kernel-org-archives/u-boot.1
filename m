Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACDDF013FA
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 21:55:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 485A284209;
	Mon, 16 Mar 2026 22:55:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YrpiyNE4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 129CC841FF; Mon, 16 Mar 2026 22:55:51 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72FFC841FF
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 22:55:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-46701f2077cso156047b6e.0
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 14:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773698147; x=1774302947;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vCBz8e6lDj017Eefksn8iTdYHgLKChYcWkQFoegNjcM=;
 b=YrpiyNE4+oTKmVLJgY+/+8mMVsGDElBiHwX0zfvfD0U+hrDYic5XpX3nRLPciOOpkW
 tcARcqD5SxWpPHTg0iAfjvDm3tTJdTrqLv4I6BTR3lwc7209ebec8nwuS1Rh5z5OaBUd
 j03bLifIEoYPaNvHk+zlzqAyy4/hvMBej3mTz3XDeSWo0/dgyT/nRzfC+lsbQA1Nzg9t
 EgZ0a6+4V29bb5tJXYjdf6N3CW5yeCBpuoY1W6TZylP0JzZhugyO2uSlAPWRdTHH0wnc
 EJ4K0W6M1OgFWJ/yd/E9JXOeqs5zs7frCdjpjfC6zKrmFtTFWOcQz9l2SSSFFjwFjYcU
 Idog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773698147; x=1774302947;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vCBz8e6lDj017Eefksn8iTdYHgLKChYcWkQFoegNjcM=;
 b=NZN+YNFhGzYNSD2wvbPQ2hyjUQ7F73oQSEDXwZMTW5Bl7OfGP+7FLtXReH0kxALQYl
 8bt/efG66qUJ5N6WpjRh8tvGQgFOrlja465yG4Qq/GgJKD5CFDgqMH40ZTXDATLshkun
 5M//m+RHdT4CtCc/H4e8mlei+BfCq5TDSSJUwxU4TYdpM/w2Qkm5Y9YaCQwGEpIuyyhU
 qKSMWwJPzKA1l6li/WCO+v93f+F4i9KmAzUb2W+CPsg/Th/vVTDaajGcqzwcWnlRoZcl
 u7qYgcwgkPaBf2ZFN2H9NY7i890jSfpVdGwmGDt6/hOBHK2JMRHh8ltRiPqvPpXVYdbd
 bETw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWuZmHjZVKCOYG70cf0gdZ6WZAz2HWBA8YAKfHeEJkwh672iwS1KtVjKU0IUqu93sXC0XHyAY=@lists.denx.de
X-Gm-Message-State: AOJu0YwN8Qnq/fKFxnxcWJy6jtp2ANWjxOkeTxQWeTVK/TV7rUnbjlv3
 o7Vo6ASMZyZhr4iexKtJU+fezzEhOYrTwWT1nKLKNNlBSFyw0CxvLAJFO/3RSUNGJQc=
X-Gm-Gg: ATEYQzx9G+krXM4uDkFl143sqQ14X0yyQwpjQ7kJ9xoryHTHhKbfNxChR3Ybf2SPzQ6
 1smfGejYtONCQ46PtyOImID5NAo32s5lVJpIoIlTogyi+DuehCsi9qLCv2nWXEEvizYv8sEUY/3
 FrUaLGtV81qXoRSpuKawrBnmwAlk+feizaQUjsvnhjwFtPK6347Yksu8C1PQyhj3gUD7fQ6BgqE
 iu5GFOuOJr2nG6DplHddyMrBU3fD3+x5N2FTkAk0mTTG7nvtgU/gkAqlH7UMhXfxcJgdtbnaE+f
 03qmXSokVATcNbkdsl1VI5uCOE5Fq6EIOMUZ4j9xXfphGi0EmgeFb4MTUMmyMaoZxdf0rALCxSo
 QgplAKwyFLvjWOC+rn21+q6h3hHfnZpZ+P7FsdOvnB2rD1xWuPGNiMrnHXs9MRt5R02jIbbVBEO
 vSH0UZVwbN9VVj8I2wdSqvNup4FIRs7Hpd3N8SeA==
X-Received: by 2002:a05:6871:79a7:b0:409:6148:e23e with SMTP id
 586e51a60fabf-41bb03234e0mr675898fac.10.1773698147094; 
 Mon, 16 Mar 2026 14:55:47 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:6995:28aa:eeda:102])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41791432d87sm17978547fac.1.2026.03.16.14.55.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 14:55:46 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 16 Mar 2026 16:55:14 -0500
Subject: [PATCH 1/3] arm: dts: mt8371: add SD card nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-mtk-ext-mmc-boot-v1-1-1aae51a44705@baylibre.com>
References: <20260316-mtk-ext-mmc-boot-v1-0-1aae51a44705@baylibre.com>
In-Reply-To: <20260316-mtk-ext-mmc-boot-v1-0-1aae51a44705@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3660; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=IdJ/ptIekUltvbGWxX8Du4eIb3BX8P2NOs4sYcV9o7Q=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpuHxOpp7cc2oz9Rcfk/hNv1HRQ3EeJIZe6aOEf
 d8fo+ynKGuJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabh8ThYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AryoIAIWUOC0xunkZxnyuh7DLSoyvI0xdvOADx/2i+nw
 ++ZM4TbkCZwJqV3qPN/p+ALKeikXEQ5JxZAOneHJHpjPX9xPKSfL4mVs83yBLnoIHI+zO2SflZA
 7Z1Kel/C+AGs6clhxkr/Jl/7w87iEWI21RYnz/EONms61Ds8nw+D3V5rLWzvcndzdzoIqa/G3hX
 AzHJNEVcHLNwK0FnjHjEWnrkTgfR7TutFjUKH2Pr0k/yYquplRt251rSLTWMzaU6bp4zEX7K0rB
 rMGBpNydnGbgbMKNs1v47QLElqHICQVm2SwY7rrK+BQtFJANqotegmVHKMuAAIRO5Ah/uQ63d0h
 OftU=
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

Add SD card nodes to the MT8371 Genio common and MT8189 SoC device tree
files. This is coming from what has been submitted upstream in Linux
[1]. The process is going slow, so we a copy in U-Boot until we can
switch to CONFIG_OF_UPSTREAM.

Link: https://lore.kernel.org/linux-mediatek/20251203-add-mediatek-genio-520-720-evk-v1-0-df794b2a30ae@collabora.com/ [1]
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/mt8189.dtsi              | 12 +++++++
 arch/arm/dts/mt8371-genio-common.dtsi | 67 +++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/arch/arm/dts/mt8189.dtsi b/arch/arm/dts/mt8189.dtsi
index 3aafb9b151f..d246be63293 100644
--- a/arch/arm/dts/mt8189.dtsi
+++ b/arch/arm/dts/mt8189.dtsi
@@ -191,6 +191,18 @@
 			status = "disabled";
 		};
 
+		mmc1: mmc@11240000 {
+			compatible = "mediatek,mt8189-mmc";
+			reg = <0 0x11240000 0 0x1000>,
+			      <0 0x11d80000 0 0x1000>;
+			clocks = <&topckgen_clk CLK_TOP_MSDC30_1_SEL>,
+				 <&pericfg_ao_clk CLK_PERAO_MSDC1_H>,
+				 <&pericfg_ao_clk CLK_PERAO_MSDC1>;
+			clock-names = "source", "hclk", "source_cg";
+			interrupts = <GIC_SPI 388 IRQ_TYPE_LEVEL_HIGH 0>;
+			status = "disabled";
+		};
+
 		clock-controller@1000c000 {
 			compatible = "mediatek,mt8189-apmixedsys", "syscon";
 			reg = <0 0x1000c000 0 0x1000>;
diff --git a/arch/arm/dts/mt8371-genio-common.dtsi b/arch/arm/dts/mt8371-genio-common.dtsi
index c6aa22b7d10..58322193aef 100644
--- a/arch/arm/dts/mt8371-genio-common.dtsi
+++ b/arch/arm/dts/mt8371-genio-common.dtsi
@@ -4,6 +4,8 @@
  * Author: Macpaul Lin <macpaul.lin@mediatek.com>
  */
 
+#include <dt-bindings/gpio/gpio.h>
+
 #include "mt8189.dtsi"
 #include "mt8189-pinfunc.h"
 #include "mt6359.dtsi"
@@ -94,6 +96,23 @@
 	status = "okay";
 };
 
+&mmc1 {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	cd-gpios = <&pio 2 GPIO_ACTIVE_HIGH>;
+	max-frequency = <200000000>;
+	no-mmc;
+	no-sdio;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc1_default_pins>;
+	pinctrl-1 = <&mmc1_uhs_pins>;
+	vmmc-supply = <&mt6359_vpa_buck_reg>;
+	vqmmc-supply = <&mt6359_vsim1_ldo_reg>;
+	status = "okay";
+};
+
 &mt6359_vufs_ldo_reg {
 	regulator-always-on;
 };
@@ -162,6 +181,54 @@
 		};
 	};
 
+	mmc1_default_pins: mmc1-default-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO169__FUNC_MSDC1_CLK>;
+			drive-strength = <6>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO170__FUNC_MSDC1_DAT0>,
+				 <PINMUX_GPIO171__FUNC_MSDC1_DAT1>,
+				 <PINMUX_GPIO172__FUNC_MSDC1_DAT2>,
+				 <PINMUX_GPIO173__FUNC_MSDC1_DAT3>,
+				 <PINMUX_GPIO168__FUNC_MSDC1_CMD>;
+			input-enable;
+			drive-strength = <6>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins-insert {
+			pinmux = <PINMUX_GPIO2__FUNC_GPIO2>;
+			bias-pull-up;
+		};
+	};
+
+	mmc1_uhs_pins: mmc1-uhs-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO169__FUNC_MSDC1_CLK>;
+			drive-strength = <8>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO170__FUNC_MSDC1_DAT0>,
+				 <PINMUX_GPIO171__FUNC_MSDC1_DAT1>,
+				 <PINMUX_GPIO172__FUNC_MSDC1_DAT2>,
+				 <PINMUX_GPIO173__FUNC_MSDC1_DAT3>,
+				 <PINMUX_GPIO168__FUNC_MSDC1_CMD>;
+			input-enable;
+			drive-strength = <8>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins-insert {
+			pinmux = <PINMUX_GPIO2__FUNC_GPIO2>;
+			bias-pull-up;
+		};
+	};
+
 	uart0_pins: uart0-pins {
 		pins {
 			pinmux = <PINMUX_GPIO31__FUNC_UTXD0>,

-- 
2.43.0

