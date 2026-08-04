Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B573C55822
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 22:33:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B3A1440742;
	Tue,  4 Aug 2026 22:33:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pcaWyCI9ppzO; Tue,  4 Aug 2026 22:33:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 852104079D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785882796;
	bh=jBGQGy9nlslKBA2rfcl4vUzHDL8Kg9k3KZp2UQnqwWw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OZXVrj7vhVxUx8ift1t2GA4ZpAVk4T6hYVfQWYUxCeWIFmgTAwoFhSOyncs6YOeE7
	 iZ0BbBcuoUQrhkHDWR0W6dJhsnuKsyO1G/GfO8PRGs8+hHzI/2MU9MD7XftvLPwJC4
	 DDWm4O5mZn/yv750eSmY7KmrVwUfCfYoh3+RTyY1B/D06PnVx0ohTORvGOfgsKSKMx
	 EtyvL+72MFcDW10peedhQnJvlWbjBfsAXTyMxhmCe8+SmOgEeE3cN5iHEkk2ouJy0B
	 xF4crhCq0AaENVQ9kn1IVcEVVKMDVEWA9R0HCg33cGXkhO6z/FObvLU4LjCkGaV4pC
	 BECv1botSGo6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 852104079D;
	Tue,  4 Aug 2026 22:33:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4EE9B2B6
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 22:33:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 49DE64073A
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 22:33:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vqqY4vfpsHNa for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 22:33:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4BFF740759
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4BFF740759
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4BFF740759
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 22:33:08 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7e9ecb1e13cso450023a34.3
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 15:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785882787; x=1786487587;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jBGQGy9nlslKBA2rfcl4vUzHDL8Kg9k3KZp2UQnqwWw=;
 b=fc/u1do7GHQ8rvTTJRuH5buQI29AYntxCM/LGseVw4Kcc+tg85E9RJCqjXS6yanp3G
 SGkJUTrHBdbdIRRoqCRDBBKesfjwPABorIbxiH1TxLwubivqB0ZPn+yMzxtlBKag5gs2
 bz4drnv/Pake6rD2hk91j19O9Ct0BX1uZvyi1CrIJEXczJU0V0QQDJ03RpIBD/rFwQdI
 CCQA0gdHz0SRWxpv6oW/CNpqfA5xdCtSEQBsnhxdxQOysCtwhB8AhEBFAd7o5/KRjMyD
 hTbJ3GfU81qW5DzBNLsmGGoRICfrpqH3P0cTUX+6XQ1pzooZ7st0eMmDIuLYkRHA5xUo
 0cHw==
X-Gm-Message-State: AOJu0YyPkIcuU+MZ4PJaaAYF0iCcLYgTqm9LWHHZvabFquO8NI/knqZb
 SAi9QzZ0QWeOSUW88VwFkCUzQw5qNa05jGU3e0yD50lax7PYoA0EEPOGRD2GN1mN1zE=
X-Gm-Gg: AR+sD13hogxUcND0fiFvZ/mGqieNHY6A8pJm5JBPr81cMjco57cJwzKPuyRu2TryW1O
 4qXqKECSFKTINmK2laFCFg0fSON+mSawisaNznXKM7sQ1pHUkBdGWTqNho++Htm5BnaY4lTKg+L
 LbNLBQ/Ts304ggiNt2s0GyUecD+yxS9D5IwO085w2oeskQ1QvQuh9CqCmQwSK79/ZjPUoUsD9Ki
 KFmBqaX9f1/MYl2MdjQ8KeeWusuG+PnGUhFS2XmNcrxdS37ldouQSu5rkz5kPGkvfe3VW1FiWFT
 sKNo3QkQSzRBVH8RkZK5wekguRUJV5FxhXiK1hqsT32ZY9Vhd0qImvD20voorKwVBgaZL7YMpQH
 hwx+mt3hGBTyRQN84VL+x3P00ObGHC5GTfqHZdOSJ/ZSgG51J2v1Ogjp+1qXNlRVGJekd95s8eJ
 X2NMALEVwDHLl7/5NjX5Pnzg9fPN/XUppnEF1SgT0RZVrYlg3PH3O8M2E4yez3lGhUbDFWzHjSF
 svB
X-Received: by 2002:a05:6820:6acf:b0:6a1:98fe:3da2 with SMTP id
 006d021491bc7-6ae96c84830mr1430202eaf.11.1785882787103; 
 Tue, 04 Aug 2026 15:33:07 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:a444:841f:6b21:eaf5])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6ae93d524d3sm1016111eaf.6.2026.08.04.15.33.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 15:33:06 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 04 Aug 2026 17:32:06 -0500
Subject: [PATCH 6/7] arm: dts: mt8366: enable PMIC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-mtk-pmic-mt6366-v1-6-f3b36b8a1a47@baylibre.com>
References: <20260804-mtk-pmic-mt6366-v1-0-f3b36b8a1a47@baylibre.com>
In-Reply-To: <20260804-mtk-pmic-mt6366-v1-0-f3b36b8a1a47@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Julien Masson <jmasson@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2615; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=earrLM0eMFcYQ7q2MlgykjCHIA42kOxVRzK43nziZsU=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqcmiMdnJrfQnS2d+L3N146GjiT6UH3173Ff4U6
 IdRjX7DXEmJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanJojBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AkW4IAI7KZ7ZpDkMDBzkBFg9mGnAAFyHcIla8k4vQkZW
 GvWu7lvOJ7qBOClm1QAOTrO6lndAtWHmqlDdKn+Y8aCiXNA157eTuu64glGaHh8/rJ9kugmq3yg
 nml+w5V5LkXK68unF49uEfeM6im5S1HreNR9BAfOUkMZOGa5Zmrx5VopIPF6l/quEsp7tkJPjSp
 EhIhd9xsxLCMMo+ZSzbkhZuF+TiF8BYQTPhRoNKrZn/ygnqAj7utpdAfS7gCIf7rQndmn63Z0SJ
 qgIh14JvZQZUx44fx5wetePh1P4WBdMiqjL36ec4nRN+x6BPbRxlYoaVkPqrlYRSve1WhYb4t0t
 uJpc=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785882787; x=1786487587;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jBGQGy9nlslKBA2rfcl4vUzHDL8Kg9k3KZp2UQnqwWw=;
 b=l7Tmn/lCGfUCEIYV+dN7zy2wsplCWHfiAFxmshzwUcz5yNoCJCdhROUA3QMyaxY3gd
 2/1QAksT/DzFpF7Y7LPlG2UBg0eRQ83gHneJBpupurVYwHpv4ZEiITZaWVMceb0OwsKw
 HOLgwOGU8MWw+L4PrBVrGR5SIL86jhR16w0TDKwo7xdZlxH/ssQ7T/eLOmtdVuOnn15/
 ZXiaTl/VQiJ4Cb9IlhquoblIsG+TMoq9oLkl/34YY/PiA5mhJQSNgABGodVw7Apxfr8F
 5Y2yyweN/K+WcXGe2zpWzVApiQk1bLx5J5j8h4uafd/HtxipXPtImEyDD9k+Fsoh56YR
 Z34w==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=l7Tmn/lC
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

Add the required include for the MT6366 PMIC and add the pwrap node
used to communicate with it.

Now that we have the correct regulator providers from the PMIC, we can
replace the fake regulators that were being used to make the eMMC work.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/mt8366-genio-360-evk-common.dtsi | 23 +++--------------------
 arch/arm/dts/mt8366.dtsi                      | 12 ++++++++++++
 2 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/arch/arm/dts/mt8366-genio-360-evk-common.dtsi b/arch/arm/dts/mt8366-genio-360-evk-common.dtsi
index 13055e4740c..8157d8f8da1 100644
--- a/arch/arm/dts/mt8366-genio-360-evk-common.dtsi
+++ b/arch/arm/dts/mt8366-genio-360-evk-common.dtsi
@@ -5,6 +5,7 @@
  */
 
 #include "mt8366.dtsi"
+#include "mt6366.dtsi"
 
 / {
 	memory@40000000 {
@@ -59,24 +60,6 @@
 		stdout-path = &uart0;
 	};
 
-	reg_1p8v: regulator-1p8v {
-		compatible = "regulator-fixed";
-		regulator-name = "fixed-1.8V";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		regulator-boot-on;
-		regulator-always-on;
-	};
-
-	reg_3p3v: regulator-3p3v {
-		compatible = "regulator-fixed";
-		regulator-name = "fixed-3.3V";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-boot-on;
-		regulator-always-on;
-	};
-
 	usb_p0_vbus: regulator-usb-p0 {
 		compatible = "regulator-fixed";
 		regulator-name = "usb_p0_vbus";
@@ -376,8 +359,8 @@
 	mmc-hs400-1_8v;
 	hs400-ds-delay = <0x10100>;
 	cap-mmc-hw-reset;
-	vmmc-supply = <&reg_3p3v>;
-	vqmmc-supply = <&reg_1p8v>;
+	vmmc-supply = <&mt6366_vemc_reg>;
+	vqmmc-supply = <&mt6366_vio18_reg>;
 	non-removable;
 	status = "okay";
 };
diff --git a/arch/arm/dts/mt8366.dtsi b/arch/arm/dts/mt8366.dtsi
index 263b0149a85..9fc4c9cfcaf 100644
--- a/arch/arm/dts/mt8366.dtsi
+++ b/arch/arm/dts/mt8366.dtsi
@@ -229,6 +229,18 @@
 			#clock-cells = <1>;
 		};
 
+		pwrap: pwrap@10026000 {
+			compatible = "mediatek,mt8366-pwrap", "mediatek,mt8195-pwrap";
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
 		gce_clk: clock-controller@10228000 {
 			compatible = "mediatek,mt8366-gce";
 			reg = <0 0x10228000 0 0x1000>;

-- 
2.43.0

