Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2216C1061B1F
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 20:43:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB36283EB3;
	Mon, 30 Mar 2026 22:43:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DHPpOITP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 726DE8352B; Mon, 30 Mar 2026 22:43:15 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A33058406D
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 22:43:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7d91f82d819so4891203a34.1
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 13:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774903390; x=1775508190;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uTufUozaBVLGrZohFS5x0uZOoOHXLSPCJdmf1cvp61Y=;
 b=DHPpOITPz6HB/wBUoejXkwMUpzYBF4r74bHA6iXkhWNRImiwIHniNj6ku8IjEohNwi
 3SKevZQYrthIaF0Jdj1lW6EU8UD4FozgTMqU7R8GBC55dWlKu1sARWr3pWtPQJ4Bm/+X
 Q2wagGf8dP1x/M6NS/C9i/LfX4SH/+aGAv1zI2+BTJ6h/fqEIFOiHGJEmb6DztUleVgL
 /d9hZo1aDBCN3vkX03Q8iPIx/pHyses9O0FkmyLbI2RCKbwy3dDy82UMoHdQl8NxB01m
 NV+HQXP51HS40OqueH3g2ncbyK+OXhDBonFyhX4k1aZXq7Qwnw93U/8guOY59Lpue1Lu
 EtyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774903390; x=1775508190;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uTufUozaBVLGrZohFS5x0uZOoOHXLSPCJdmf1cvp61Y=;
 b=fgQg6o3fVubFceenUhSgWdPG4RVW48JWrM66unvE+z/glpiiEbw85pxYH/HlnFzd2K
 8ubU63ci93DpZCtGcTHug0Jkscn/M90+MymFluUQHmFlUBYjN+rIWceuPC7Lawg0tll+
 PJAVLLMRGvsK9fVaFQjh3rmIF/n/DeeRT58UrKMi/uq8+xPODt0mXjUbs0VboZ+xW7rH
 MEDgFRoVmi9b/76aQUPIyCcR0GYZoXhfaLNHJ9V/fWJLag551+AhOsNJwMV6lCbOrAZ8
 f3UICGJ6EO0QJr/ZSoeD9E9WsLHJ+J1moFvJkGSn0dwgSu0dSjtJ7SHxzqlZI3BXmoWM
 acbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU21xQi7qdgJn2TP/QfLgqH5eOSADNG5Q/6pD9MkquL9pnag5rYR9zCNghymrmst+CumRxPcew=@lists.denx.de
X-Gm-Message-State: AOJu0YwKD9XTxmc4npjjjuS/WByfLuzHuReJS3DJWusFIHqRY+wOHptE
 KK2Qy05i9Vhp3F61zggAUejEFdar/fxK3nSTbcy6nkMthDXQ3Nb295VriZDe3one+xg=
X-Gm-Gg: ATEYQzzSDtR04CwwyEEloWmBuc8VIv0kE1lJWPMzchiY0MMcFZ5X5GE3WjDnNkh/WZr
 LjHCIweLcHAfzxoospoV8rr8PuPuRm7eXl4o76OiFiIiIo6yoKhniEzVHwQDpGIaCS7XABpDJu4
 CrvrK5+bNwSl1ixINV2+q3HYEoFy1ZXjPNhlBXOPOAPH84nHz+cdATLoSk4jU4xrGC3XFYS1nNK
 1g4f0K3FhjHF4qY8gy/1Tjd+HsGIT2M6ukb/gK6LCxRn0r5GIqK6rxtM3Mua52vP0xRpNQVKYfK
 H8P1jLkbhgI/d8zuewdW0ElTsJAtQ2CSfj97AbH6VEVImUjONhK53eY8AFfiWWYyYbcGVjEExV3
 roIFZINIYrIolLnfa+zxgyJKBnAWhBScClLAzXkj6inTlqxN7eXG3ccWnSoqdv4KrIpu0xkwMeA
 GdXwp2WBLx1jg5YofWfZ1ft0TNrDrn
X-Received: by 2002:a05:6830:828b:b0:7d9:b189:d938 with SMTP id
 46e09a7af769-7d9faddcfecmr8292516a34.10.1774903390206; 
 Mon, 30 Mar 2026 13:43:10 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:a67f:a092:38d7:379e])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7da0a384631sm6595736a34.7.2026.03.30.13.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 13:43:09 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 30 Mar 2026 15:42:16 -0500
Subject: [PATCH 4/6] arm: dts: mt8189: add UFS nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-mtk-genio-720-ufs-v1-4-3bad8362ed70@baylibre.com>
References: <20260330-mtk-genio-720-ufs-v1-0-3bad8362ed70@baylibre.com>
In-Reply-To: <20260330-mtk-genio-720-ufs-v1-0-3bad8362ed70@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4233; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=YRukyZS+0FRf8nrT1/GZGMvVv9wyXCshQvpCFxYGO7I=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpyuBFpKieOEGDJ2cv6r0MlclK8ez+BYQjpOcZh
 zRB5b8atymJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCacrgRRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ArRkH/08RprhGGdptwH3SYqGkAXZktjtU6Sftd4ZqjAS
 3aRi5tHkV4NxloqTurvgUJlVrUcqcoYt4CCR+xlSCTlGUtQSrExZbakE08co5BQngHLUWFe1Tf3
 5pe5/9ahUcDNVSR+aK7d4ZYo4tqsZkRsSmykmkQAtn2p9FRj6EOQ3gXDaUliZ1bdPv0ttmk1vzg
 DcjgSt869SDqWH9b0usG+b9/TZS5dgS1y1/4761nW1LDPY0TCdUDSk4AS3rkNelJL8oYM8mRJBo
 O6Hd6ZHH2JYYvayx1ni5e03bguSIwOweF/QuU8vxXSH+l9snV9BIVSmZQ9tjz4m8ZZn8qq7I24T
 SCu4=
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

Add UFS nodes to mt8189.dtsi.

This is copied from the proposed upstream patch [1].

Link: https://lore.kernel.org/linux-mediatek/20251111070031.305281-10-jh.hsu@mediatek.com/ [1]
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/mt8189.dtsi | 115 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/arch/arm/dts/mt8189.dtsi b/arch/arm/dts/mt8189.dtsi
index d246be63293..e9fd21ea095 100644
--- a/arch/arm/dts/mt8189.dtsi
+++ b/arch/arm/dts/mt8189.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/clock/mediatek,mt8189-clk.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/reset/ti-syscon.h>
 
 / {
 	compatible = "mediatek,mt8189";
@@ -286,6 +287,120 @@
 			#interrupt-cells = <2>;
 		};
 
+		ufshci: ufshci@112b0000 {
+			compatible = "mediatek,mt8183-ufshci";
+			reg = <0 0x112b0000 0 0x2300>;
+			interrupts = <GIC_SPI 393 IRQ_TYPE_LEVEL_HIGH 0>;
+
+			clocks = <&topckgen_clk CLK_TOP_U_SEL>,
+				 <&clk26m>,
+				 <&topckgen_clk CLK_TOP_MSDCPLL_D2>,
+				 <&topckgen_clk CLK_TOP_AES_UFSFDE_SEL>,
+				 <&topckgen_clk CLK_TOP_U_MBIST_SEL>,
+				 <&ufscfg_ao_reg_clk CLK_UFSCFG_AO_REG_UNIPRO_TX_SYM>,
+				 <&ufscfg_ao_reg_clk CLK_UFSCFG_AO_REG_UNIPRO_RX_SYM0>,
+				 <&ufscfg_ao_reg_clk CLK_UFSCFG_AO_REG_UNIPRO_RX_SYM1>,
+				 <&ufscfg_ao_reg_clk CLK_UFSCFG_AO_REG_UNIPRO_SYS>,
+				 <&ufscfg_ao_reg_clk CLK_UFSCFG_AO_REG_U_SAP_CFG>,
+				 <&ufscfg_ao_reg_clk CLK_UFSCFG_AO_REG_U_PHY_TOP_AHB_S_BUS>,
+				 <&ufscfg_pdn_reg_clk CLK_UFSCFG_REG_UFSHCI_UFS>,
+				 <&ufscfg_pdn_reg_clk CLK_UFSCFG_REG_UFSHCI_AES>,
+				 <&ufscfg_pdn_reg_clk CLK_UFSCFG_REG_UFSHCI_U_AHB>,
+				 <&ufscfg_pdn_reg_clk CLK_UFSCFG_REG_UFSHCI_U_AXI>;
+
+			clock-names = "ufs_sel",
+				      "ufs_sel_min_src",
+				      "ufs_sel_max_src",
+				      "ufs_fde",
+				      "ufs_mbist",
+				      "unipro_tx_sym",
+				      "unipro_rx_sym0",
+				      "unipro_rx_sym1",
+				      "unipro_sys",
+				      "unipro_phy_sap",
+				      "phy_top_ahb_s_bus",
+				      "ufshci_ufs",
+				      "ufshci_aes",
+				      "ufshci_ufs_ahb",
+				      "ufshci_aes_axi";
+
+			freq-table-hz = <26000000 208000000>,
+					<0 0>,
+					<0 0>,
+					<0 0>,
+					<0 0>,
+					<0 0>,
+					<0 0>,
+					<0 0>,
+					<0 0>,
+					<0 0>,
+					<0 0>,
+					<0 0>,
+					<0 0>,
+					<0 0>,
+					<0 0>;
+
+			vcc-supply = <&mt6359_vemc_1_ldo_reg>;
+			vccq-supply = <&mt6359_vio18_ldo_reg>;
+			vccq2-supply = <&mt6359_vufs_ldo_reg>;
+
+			resets = <&ufscfgpdn_rst 0>,
+				 <&ufscfgpdn_rst 1>,
+				 <&ufscfgpdn_rst 2>;
+
+			reset-names = "unipro_rst",
+				      "crypto_rst",
+				      "hci_rst";
+
+			mediatek,ufs-disable-mcq;
+			mediatek,ufs-rtff-mtcmos;
+			mediatek,ufs-broken-vcc;
+
+			status = "disabled";
+		};
+
+		ufscfg_ao_reg_clk: syscon@112b8000 {
+			compatible = "mediatek,mt8189-ufscfg-ao", "syscon", "simple-mfd";
+			reg = <0 0x112b8000 0 0x1000>;
+			#clock-cells = <1>;
+
+			ufscfgao_rst: reset-controller {
+				compatible = "ti,syscon-reset";
+				#reset-cells = <1>;
+
+				ti,reset-bits = <
+					/* ufs mphy reset */
+					/* 8: mphy */
+					0x48  8 0x4c  8 0 0
+					(ASSERT_SET | DEASSERT_SET | STATUS_NONE)
+				>;
+			};
+		};
+
+		ufscfg_pdn_reg_clk: syscon@112bb000 {
+			compatible = "mediatek,mt8189-ufscfg-pdn", "syscon", "simple-mfd";
+			reg = <0 0x112bb000 0 0x1000>;
+			#clock-cells = <1>;
+
+			ufscfgpdn_rst: reset-controller {
+				compatible = "ti,syscon-reset";
+				#reset-cells = <1>;
+
+				ti,reset-bits = <
+					/* ufs ufschi/crypto/unipro reset */
+					/* 0: unipro */
+					0x48  0 0x4c  0 0 0
+					(ASSERT_SET | DEASSERT_SET | STATUS_NONE)
+					/* 1: ufs-crypto */
+					0x48  1 0x4c  1 0 0
+					(ASSERT_SET | DEASSERT_SET | STATUS_NONE)
+					/* 2: ufshci */
+					0x48  2 0x4c  2 0 0
+					(ASSERT_SET | DEASSERT_SET | STATUS_NONE)
+				>;
+			};
+		};
+
 		pwrap: pwrap@1cc04000 {
 			compatible = "mediatek,mt8189-pwrap", "mediatek,mt8195-pwrap", "syscon";
 			reg = <0 0x1cc04000 0 0x1000>;

-- 
2.43.0

