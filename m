Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25521FB5164
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 20:37:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92E1D83EC6;
	Mon,  6 Apr 2026 22:37:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="gEA3bazE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA3AF84101; Mon,  6 Apr 2026 22:37:35 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78B0B83EC6
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 22:37:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-684571567a8so654177eaf.1
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 13:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775507852; x=1776112652;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QsuES9Uw8lEqGTIGY/5uRF7DQl4cd7CzIKDkRxyM0dM=;
 b=gEA3bazEm5+k9mQCm+mC+HgEC2/uyvahYyUeZyr5WWNlwuBZDx2G8BZXeygkrAGg41
 6XlnX9ZcXeUY8vwHYeUcjeuoO/hcbcOMAIY8V7FrLV0zph8g8T27hIJNeq/RZyojlUzH
 iN9B8o3+rIga8hUCDRgSvbnZ/cmGVo8vPrZ8VEFEt9K1FpKgdruKy9NQbT9cV3eRWIyD
 /7B4uueQR6h1mUlktM/GN7reCye17Zf14039+9CHsvnnJNlUFgwJ++geQ4tbQUcOcYZ3
 SStyvW5szIRHFKhJE744rh9+Ky2E+wQQRq3QE6ihfnHCkMEyY7IRYVbwrMCqBOy1U9qX
 ym/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775507852; x=1776112652;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QsuES9Uw8lEqGTIGY/5uRF7DQl4cd7CzIKDkRxyM0dM=;
 b=DZ/73yORMtmv2SbBxR9R0/nVvLDRGQFrPB/1xUulhQ1m69KmFuemLkXkNSTHW+CQIW
 sHa/WHAp6s867eyzQuV2CJsKhDRnHUJk5J8Dx0mapQy11xlXZtm21jfWM2s/vmjzWPBb
 NHYEFyjP1OlIkWaSSJKf1n1yLbPSn1R+BuXpom1jg6zWpnhFA5c5znpPxv8uCNMCP0ji
 SiuYvFD/r5oK56qfCtt/cdsY7EuR+WP4Dh+KyKQ9vWwBf8oLn0uUh//Rew8gjWfCDZvG
 uEk4zUDX8xpAol4NWuevo3niaI+PHw6H/nqT8dn7iWseU9wnuonYyh6FoPPAbYutjvBh
 SDbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqgNfFJ/gnaZjL8Pr/eQqJUCldktuInyKRZext2s7/hwR23zMwMmNjU5WKAC7I379HrwLs9+A=@lists.denx.de
X-Gm-Message-State: AOJu0YyRtxKOFOELtDUbaBQUxHpD1Lqa+jguXPwFIDRdyg0NdMLGUsgY
 hXp2RQ5C+AGN11DzLyA6EC1xJeu1Wu+QEDJHgkInNLxxHd2ksodhYKad8Zhyj0vuYtI=
X-Gm-Gg: AeBDiet4ri2c6BCpm23y9/tVy60VhRntaP11pbeWy91JJjHtyZf/uThLboSK+1l+JT8
 1vyM4pR6G3SL+l1myt2fOFc4svZ8x7ZBxMbG5z16kD+6k5PJOR9JdcEgbOYD6Y7HLNARdcmIERR
 lS0g2YsXff8j24FiS1zbFGQzs3cI06lxHjoHwcS60pIC+WsrRPWzqftF1lZRinMxK5uejXOY4vo
 BZLk/4ZTOrD0gamPE/jR0iWiqpHxiEibqkO0mwrWOqxGp0cSnt2rC56XkjVAf6Ka0N5iqz25yiE
 TRL2WkBMEKSqyrZpwFGT6XX0ddHQhPDxOoAL9+tUMLiutIzscybmVL1w4FA/bZCyxSuNsOVklCr
 i1o3tvR01ifqtxnRY2el+N//7j6QxHDiT3QQ0Fnv2YgLQUPbA0kRUdoBrz5Qmkp+/AHk8BgGEGZ
 dPL/0vBmXOPVlM961qF/dhRCLCmO0=
X-Received: by 2002:a05:6820:2910:b0:684:743e:86a6 with SMTP id
 006d021491bc7-684743e872cmr4918444eaf.20.1775507852177; 
 Mon, 06 Apr 2026 13:37:32 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:90d7:b13f:c53:8ca3])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-68386edba6bsm5359048eaf.14.2026.04.06.13.37.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 13:37:31 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 06 Apr 2026 15:37:09 -0500
Subject: [PATCH 1/2] arm: dts: mediatek: add Genio 520/720 SNOR support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260406-mtk-genio-720-snor-v1-1-cbfd5fc4e59a@baylibre.com>
References: <20260406-mtk-genio-720-snor-v1-0-cbfd5fc4e59a@baylibre.com>
In-Reply-To: <20260406-mtk-genio-720-snor-v1-0-cbfd5fc4e59a@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2730; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Ir6aQ2njfjkzSajWz6T8f357/1QDfjo9ySyVTwEhpWw=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp1Bl98CX8tLoAlU8ziIIDHXhEowupngg+YJbD4
 R2xo27Xr7OJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCadQZfRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A6fgH/0RD1/ppdixZmbrzJUDZPdQP8xu3/55EGlWZplr
 xOySJS2syKvIxkK3XbE2krSDlMvoijjHiH7wGTXY72z4Sgf2RVaQlw4bg+9RjcyC6gWKfxdkCOH
 tDVf5fJOwuZkEZ39oz+/GWIIIyiOlJgGn571UWjlq+TlfYwRui6ZXhCfiQM3++yKjoy/xpiAbSF
 nqgRVs17yzjZ7F+eMjTflNf0rE9YqQ98L4NgkV/CExKJcKmQi9Bl2tqg1WY7Aj312WpP8aF/2eF
 PlAonFJ/tgtZZD2ifAg5TagJ8ihQL1JF9vULD0vji6GRqPazbgHGUEMv9N4POxVZLEvxK0nTcAY
 kU5M=
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

Add devicetree nodes needed to enable SNOR support on Genio 520 and 720
EVKs. This is copied from the most recent upstream submission [1] of the
devicetree for these boards, so there should be minimal differences when
we eventually switch to OF_UPSTREAM.

Link: https://lore.kernel.org/linux-mediatek/20251111070031.305281-10-jh.hsu@mediatek.com/ [1]
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/mt8189.dtsi              | 17 +++++++++++++++++
 arch/arm/dts/mt8371-genio-common.dtsi | 31 +++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/arch/arm/dts/mt8189.dtsi b/arch/arm/dts/mt8189.dtsi
index e550745ac5d..891d3249ecd 100644
--- a/arch/arm/dts/mt8189.dtsi
+++ b/arch/arm/dts/mt8189.dtsi
@@ -181,6 +181,23 @@
 			status = "disabled";
 		};
 
+		nor_flash: spi@11018000 {
+			compatible = "mediatek,mt8189-nor","mediatek,mt8186-nor";
+			reg = <0 0x11018000 0 0x1000>;
+			clocks = <&topckgen_clk CLK_TOP_SFLASH_SEL>,
+				 <&pericfg_ao_clk CLK_PERAO_SFLASH>,
+				 <&pericfg_ao_clk CLK_PERAO_SFLASH_F>,
+				 <&pericfg_ao_clk CLK_PERAO_SFLASH_H>,
+				 <&pericfg_ao_clk CLK_PERAO_SFLASH_P>;
+			clock-names = "spi", "sf", "axi_f", "axi_h", "axi_p";
+			assigned-clocks = <&topckgen_clk CLK_TOP_SFLASH_SEL>;
+			assigned-clock-parents = <&topckgen_clk CLK_TOP_UNIVPLL_D6_D8>;
+			interrupts = <GIC_SPI 390 IRQ_TYPE_LEVEL_HIGH 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		xhci0: usb@11200000 {
 			compatible = "mediatek,mt8189-xhci", "mediatek,mtk-xhci";
 			reg = <0 0x11200000 0 0x1000>,
diff --git a/arch/arm/dts/mt8371-genio-common.dtsi b/arch/arm/dts/mt8371-genio-common.dtsi
index 046e9d57752..1d4728e3732 100644
--- a/arch/arm/dts/mt8371-genio-common.dtsi
+++ b/arch/arm/dts/mt8371-genio-common.dtsi
@@ -162,6 +162,21 @@
 	regulator-always-on;
 };
 
+&nor_flash {
+	pinctrl-names = "default";
+	pinctrl-0 = <&nor_pins>;
+
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <52000000>;
+		spi-rx-bus-width = <2>;
+		spi-tx-bus-width = <2>;
+	};
+};
+
 &pio {
 	mmc0_default_pins: mmc0-default-pins {
 		pins-clk {
@@ -274,6 +289,22 @@
 		};
 	};
 
+	nor_pins: nor-pins {
+		pins-ck-io {
+			pinmux = <PINMUX_GPIO150__FUNC_SPINOR_CK>,
+				 <PINMUX_GPIO152__FUNC_SPINOR_IO0>,
+				 <PINMUX_GPIO153__FUNC_SPINOR_IO1>;
+			drive-strength = <8>;
+			bias-pull-down;
+		};
+
+		pins-cs {
+			pinmux = <PINMUX_GPIO151__FUNC_SPINOR_CS>;
+			drive-strength = <8>;
+			bias-pull-up;
+		};
+	};
+
 	uart0_pins: uart0-pins {
 		pins {
 			pinmux = <PINMUX_GPIO31__FUNC_UTXD0>,

-- 
2.43.0

