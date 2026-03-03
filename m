Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3287EDEBF5
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 22:18:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E23383E7F;
	Tue,  3 Mar 2026 23:18:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="U+aby+pA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A80583F2D; Tue,  3 Mar 2026 23:18:08 +0100 (CET)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D8E1839DF
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 23:18:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-4094b31a037so912385fac.1
 for <u-boot@lists.denx.de>; Tue, 03 Mar 2026 14:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772576284; x=1773181084;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7MrRi+XQRrM4S28N1iQUXDZB6gqhKmVVIpR6E1qlbWs=;
 b=U+aby+pAA2uD5PAeiEMSPUgbzg7d8jCpa/CuDFaGr1X1D3mRm1l0vU8+ofhnOUJbHQ
 QrDIh2xr8yUYqWO3scVH4eXBqfyfn8htVa9kSoXECxMDtw77JkQlHEZdD0WkhRGZBAUA
 KWdQ2+DixflRZXX7mjSSwX7UMeovPVBPZZjA9zLsL9QHLIEmoFzHz4d3ZDuRU6Bja1ut
 caEwCjX/tniXNQJgxtTF+7o6tfZdjDhURJVXfnWRF2BAjeh3KtFamuW4LW28qXPRubZ+
 GdXpBPYsFR9GrIsi0uJgcDYTmC49J8SRYqWfDhJQ9mnH6QKIQKpd2VNl4JB0b1Zq8Sbi
 xcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772576284; x=1773181084;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7MrRi+XQRrM4S28N1iQUXDZB6gqhKmVVIpR6E1qlbWs=;
 b=IN0wq+Wgv8p3a9zqFeZVMUduY+IfROdmuFebnuEt0k2WB+tRGaD5UY13/mBcEFc/YN
 tezf8Z0CkkO19Qpcu3wS2o+Uo77vmx+u/VEE5+TomjOtzydgIVlAysZEZn3N3vvNapb3
 wpLD5OokcExLHnE6anundbF7LBADNM+Cl488ERt8uFgFaBWiEnIvzaDlPtxMhxiyDUQx
 5mkHceRezQtK3hTpJQ5sQJaaZAXk+uU0iU904bG922Q5s6L4on8WAHqAwesnCju1TGqM
 IsH6RgYE2QrMKhOzhgthD0PMaE4pL7vRux98he15aLC3Ze5ksxhUefVXA+nBrAhX9Nqi
 Vgsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnGNRbcL2JI0/KofzhJMg+2vzsdTotPD17w3FLqKGjBSodLtwMGS+PAy7xKNvGGjcwBpLcHgY=@lists.denx.de
X-Gm-Message-State: AOJu0Yy2hE8gQ4GoHsLIbtwTRdUFXZMfuISmt4pqZ5ZzEZM9Z9fSXVc9
 VTa5EnpYpVQK7qbtnFSobQJsaJmWolsyZkzO6o1uTmhCx0fnSonyKTk9k7czA+tyly8=
X-Gm-Gg: ATEYQzwSSCpgKWp8W5iWjqEWDUU5ECCPVm5Mho23s47Vg6bwZI0HO6cYpBSHxqti8oS
 vB4167zA4wY8IlgaKfyR5HSHpQS1VLZ7+l9+ysVuPb5St6CYSNC6CW7xhLlduFmEjbMEaZs31Ty
 TDC8aBwibEPt9I3Pzzaa+NWrYfNtbE+L6+Hj4y17Ysum7Q457O39AsECljMk0M21QUfZqRFR/eO
 daw2RtZ7rzXsnZUAp6NIlh3+9ltgrKJH2uR2LrSZbAZjz7VeVy914x79IFaOGN1PgsRDWHg3vEN
 l+be4D/SsZ5VAGq6ICpAQKQfDQ4LGkDbTiaZkAJbtD970RTZ61bxl3fY8KZGiq8VF65bG+d759L
 GkBmcj3nELbFsw0Y6fhND44p+Hq2bdWytlx/9COylpl35NQSG1PLf3DnHKCHO6PvThmVFC0I29n
 kX44qg/JiqRmicTuiqo1o/Ru2QMPm7ZnQgOCpzSgI=
X-Received: by 2002:a05:6870:7207:b0:3f5:694f:9362 with SMTP id
 586e51a60fabf-41627069b67mr10461693fac.29.1772576283614; 
 Tue, 03 Mar 2026 14:18:03 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:e10b:3ef0:5af1:d180])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160d2cf00fsm15487157fac.20.2026.03.03.14.18.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 14:18:02 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 03 Mar 2026 16:17:47 -0600
Subject: [PATCH] clk: mediatek: mt8365: drop topckgen map
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-mtk-clk-8365-drop-map-v1-1-17f81c375290@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6DIBCF4auQWXcSCylVr9K4QBzaCUUUsGliv
 HtJXX4vef8OmRJThl7skOjDmeNccb0IsC8zPwl5qgbZSN2oRmIoHu3bY6v0DacUFwxmQSKnlGz
 v2nUd1O+SyPH3330MpxOtW82Xc4TRZEIbQ+DSiw3HGAsGmtgU8jAcxw+Z3mchmgAAAA==
X-Change-ID: 20260302-mtk-clk-8365-drop-map-eef332876f99
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=23241;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=qyHaUCcfYZhjO+kbJk9o/wrj0KwweOvd/JI1K4YzQWk=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpp14S7lUI0b7kh+ICefCglWfRnu+vYuRli66pm
 lldZEDZdzWJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaadeEhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AphwH/0rDGseKLMtSm75dgDmhJTv9RnUU5SITKTa4ow5
 D7voz1/ia3Ff55ZtNfVcTgsd+l1idvMle8scGGkRft5O2zvl9Lu+0uIiU5jTtZKEwkPKIA7P6Ni
 P8e51oamVhCXzzNa+k62HvMGcoC3FbPHDzMqFs046Xtq9timSbwiMmd92yJLJ+t6VBSS2EQwZkL
 XE5ZsnkZ57M8eFIl9i74mj7Wc6owPF0CRXet4ULMv2HK6NAC6/6x0yawVYfYsaP2Pb4r3kocfdS
 PWAMxXPgWa86xmGK4Fg2cVEn/1RU8QmXkesePPOqwk5Quj9xxmmG1pszFjA2HdiGtyg9xKViEOZ
 Af8U=
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

Drop the clock ID map for MT8365 TOPCKGEN clocks.

Previously, we didn't have the EXT clock feature, so we needed the map.
Now we can replace it with the new feature to avoid the map.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
This was tested by comparing the `clk dump` output from before and after
the changes on mt8365_evk for the expected changes.

This depends on:
* https://lore.kernel.org/u-boot/20260303-mtk-mt8189-clocks-v4-0-ee85f8dd2f0d@baylibre.com/
* https://lore.kernel.org/u-boot/20260223-clk-mtk-remove-clk-bypass-xtal-flag-v1-0-a7dc97bc2660@baylibre.com/
* https://lore.kernel.org/u-boot/20260302-clk-mtk-unify-mux-parents-v1-0-32f45085f4d0@baylibre.com/
---
 drivers/clk/mediatek/clk-mt8365.c | 307 +++++++++++++-------------------------
 1 file changed, 103 insertions(+), 204 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index c6803090f35..16531491a0f 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -13,9 +13,15 @@
 #include <dt-bindings/clock/mediatek,mt8365-clk.h>
 #include "clk-mtk.h"
 
-/* Missing topckgen clocks definition in dt-bindings */
-#define CLK_TOP_CLK26M		141
-#define CLK_TOP_CLK32K		142
+enum {
+	CLK_PAD_CLK32K,
+	CLK_PAD_CLK26M,
+};
+
+static const ulong ext_clk_rates[] = {
+	[CLK_PAD_CLK32K] = 32000,
+	[CLK_PAD_CLK26M] = 26000000,
+};
 
 /* apmixedsys */
 #define MT8365_PLL_FMAX		(3800UL * MHZ)
@@ -70,151 +76,14 @@ static const struct mtk_pll_data apmixed_plls[] = {
 static const struct mtk_clk_tree mt8365_apmixed_tree = {
 	.xtal_rate = 26 * MHZ,
 	.xtal2_rate = 26 * MHZ,
+	.ext_clk_rates = ext_clk_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clk_rates),
 	.plls = apmixed_plls,
 	.num_plls = ARRAY_SIZE(apmixed_plls),
 };
 
 /* topckgen */
 
-/*
- * The devicetree bindings missed a few clocks and can't be changed, so we need
- * to provide a mapping to fix the omissions.
- */
-static const int mt8365_topckgen_id_map[] = {
-	[0 ... CLK_TOP_NR_CLK - 1]	= -1,
-	/* FIXED */
-	/* Fixed 32K oscillator is not available in devicetree definitions */
-	[CLK_TOP_CLK32K]		= 0,
-	[CLK_TOP_CLK_NULL]		= 1,
-	[CLK_TOP_I2S0_BCK]		= 2,
-	[CLK_TOP_DSI0_LNTC_DSICK]	= 3,
-	[CLK_TOP_VPLL_DPIX]		= 4,
-	[CLK_TOP_LVDSTX_CLKDIG_CTS]	= 5,
-	/* FACTOR */
-	[CLK_TOP_MFGPLL]		= 6,
-	[CLK_TOP_SYSPLL_D2]		= 7,
-	[CLK_TOP_SYSPLL1_D2]		= 8,
-	[CLK_TOP_SYSPLL1_D4]		= 9,
-	[CLK_TOP_SYSPLL1_D8]		= 10,
-	[CLK_TOP_SYSPLL1_D16]		= 11,
-	[CLK_TOP_SYSPLL_D3]		= 12,
-	[CLK_TOP_SYSPLL2_D2]		= 13,
-	[CLK_TOP_SYSPLL2_D4]		= 14,
-	[CLK_TOP_SYSPLL2_D8]		= 15,
-	[CLK_TOP_SYSPLL_D5]		= 16,
-	[CLK_TOP_SYSPLL3_D2]		= 17,
-	[CLK_TOP_SYSPLL3_D4]		= 18,
-	[CLK_TOP_SYSPLL_D7]		= 19,
-	[CLK_TOP_SYSPLL4_D2]		= 20,
-	[CLK_TOP_SYSPLL4_D4]		= 21,
-	/* Skipping CLK_TOP_UNIVPLL since isn't a real clock. */
-	[CLK_TOP_UNIVPLL_D2]		= 22,
-	[CLK_TOP_UNIVPLL1_D2]		= 23,
-	[CLK_TOP_UNIVPLL1_D4]		= 24,
-	[CLK_TOP_UNIVPLL_D3]		= 25,
-	[CLK_TOP_UNIVPLL2_D2]		= 26,
-	[CLK_TOP_UNIVPLL2_D4]		= 27,
-	[CLK_TOP_UNIVPLL2_D8]		= 28,
-	[CLK_TOP_UNIVPLL2_D32]		= 29,
-	[CLK_TOP_UNIVPLL_D5]		= 30,
-	[CLK_TOP_UNIVPLL3_D2]		= 31,
-	[CLK_TOP_UNIVPLL3_D4]		= 32,
-	[CLK_TOP_MMPLL]			= 33,
-	[CLK_TOP_MMPLL_D2]		= 34,
-	[CLK_TOP_LVDSPLL_D2]		= 35,
-	[CLK_TOP_LVDSPLL_D4]		= 36,
-	[CLK_TOP_LVDSPLL_D8]		= 37,
-	[CLK_TOP_LVDSPLL_D16]		= 38,
-	[CLK_TOP_USB20_192M]		= 39,
-	[CLK_TOP_USB20_192M_D4]		= 40,
-	[CLK_TOP_USB20_192M_D8]		= 41,
-	[CLK_TOP_USB20_192M_D16]	= 42,
-	[CLK_TOP_USB20_192M_D32]	= 43,
-	[CLK_TOP_APLL1]			= 44,
-	[CLK_TOP_APLL1_D2]		= 45,
-	[CLK_TOP_APLL1_D4]		= 46,
-	[CLK_TOP_APLL1_D8]		= 47,
-	[CLK_TOP_APLL2]			= 48,
-	[CLK_TOP_APLL2_D2]		= 49,
-	[CLK_TOP_APLL2_D4]		= 50,
-	[CLK_TOP_APLL2_D8]		= 51,
-	/* Fixed 26M oscillator is not available in devicetree definitions */
-	[CLK_TOP_CLK26M]		= 52,
-	[CLK_TOP_SYS_26M_D2]		= 53,
-	[CLK_TOP_MSDCPLL]		= 54,
-	[CLK_TOP_MSDCPLL_D2]		= 55,
-	[CLK_TOP_DSPPLL]		= 56,
-	[CLK_TOP_DSPPLL_D2]		= 57,
-	[CLK_TOP_DSPPLL_D4]		= 58,
-	[CLK_TOP_DSPPLL_D8]		= 59,
-	[CLK_TOP_APUPLL]		= 60,
-	[CLK_TOP_CLK26M_D52]		= 61,
-	/* MUX */
-	[CLK_TOP_AXI_SEL]		= 62,
-	[CLK_TOP_MEM_SEL]		= 63,
-	[CLK_TOP_MM_SEL]		= 64,
-	[CLK_TOP_SCP_SEL]		= 65,
-	[CLK_TOP_MFG_SEL]		= 66,
-	[CLK_TOP_ATB_SEL]		= 67,
-	[CLK_TOP_CAMTG_SEL]		= 68,
-	[CLK_TOP_CAMTG1_SEL]		= 69,
-	[CLK_TOP_UART_SEL]		= 70,
-	[CLK_TOP_SPI_SEL]		= 71,
-	[CLK_TOP_MSDC50_0_HC_SEL]	= 72,
-	[CLK_TOP_MSDC2_2_HC_SEL]	= 73,
-	[CLK_TOP_MSDC50_0_SEL]		= 74,
-	[CLK_TOP_MSDC50_2_SEL]		= 75,
-	[CLK_TOP_MSDC30_1_SEL]		= 76,
-	[CLK_TOP_AUDIO_SEL]		= 77,
-	[CLK_TOP_AUD_INTBUS_SEL]	= 78,
-	[CLK_TOP_AUD_1_SEL]		= 79,
-	[CLK_TOP_AUD_2_SEL]		= 80,
-	[CLK_TOP_AUD_ENGEN1_SEL]	= 81,
-	[CLK_TOP_AUD_ENGEN2_SEL]	= 82,
-	[CLK_TOP_AUD_SPDIF_SEL]		= 83,
-	[CLK_TOP_DISP_PWM_SEL]		= 84,
-	[CLK_TOP_DXCC_SEL]		= 85,
-	[CLK_TOP_SSUSB_SYS_SEL]		= 86,
-	[CLK_TOP_SSUSB_XHCI_SEL]	= 87,
-	[CLK_TOP_SPM_SEL]		= 88,
-	[CLK_TOP_I2C_SEL]		= 89,
-	[CLK_TOP_PWM_SEL]		= 90,
-	[CLK_TOP_SENIF_SEL]		= 91,
-	[CLK_TOP_AES_FDE_SEL]		= 92,
-	[CLK_TOP_CAMTM_SEL]		= 93,
-	[CLK_TOP_DPI0_SEL]		= 94,
-	[CLK_TOP_DPI1_SEL]		= 95,
-	[CLK_TOP_DSP_SEL]		= 96,
-	[CLK_TOP_NFI2X_SEL]		= 97,
-	[CLK_TOP_NFIECC_SEL]		= 98,
-	[CLK_TOP_ECC_SEL]		= 99,
-	[CLK_TOP_ETH_SEL]		= 100,
-	[CLK_TOP_GCPU_SEL]		= 101,
-	[CLK_TOP_GCPU_CPM_SEL]		= 102,
-	[CLK_TOP_APU_SEL]		= 103,
-	[CLK_TOP_APU_IF_SEL]		= 104,
-	/* GATE */
-	[CLK_TOP_AUD_I2S0_M]		= 105,
-	[CLK_TOP_AUD_I2S1_M]		= 106,
-	[CLK_TOP_AUD_I2S2_M]		= 107,
-	[CLK_TOP_AUD_I2S3_M]		= 108,
-	[CLK_TOP_AUD_TDMOUT_M]		= 109,
-	[CLK_TOP_AUD_TDMOUT_B]		= 110,
-	[CLK_TOP_AUD_TDMIN_M]		= 111,
-	[CLK_TOP_AUD_TDMIN_B]		= 112,
-	[CLK_TOP_AUD_SPDIF_M]		= 113,
-	[CLK_TOP_USB20_48M_EN]		= 114,
-	[CLK_TOP_UNIVPLL_48M_EN]	= 115,
-	[CLK_TOP_LVDSTX_CLKDIG_EN]	= 116,
-	[CLK_TOP_VPLL_DPIX_EN]		= 117,
-	[CLK_TOP_SSUSB_TOP_CK_EN]	= 118,
-	[CLK_TOP_SSUSB_PHY_CK_EN]	= 119,
-	[CLK_TOP_CONN_32K]		= 120,
-	[CLK_TOP_CONN_26M]		= 121,
-	[CLK_TOP_DSP_32K]		= 122,
-	[CLK_TOP_DSP_26M]		= 123,
-};
-
 #define FIXED_CLK0(_id, _rate)						\
 	FIXED_CLK(_id, CLK_XTAL, CLK_PARENT_XTAL, _rate)
 
@@ -222,7 +91,6 @@ static const int mt8365_topckgen_id_map[] = {
 	FIXED_CLK(_id, CLK_TOP_CLK_NULL, CLK_PARENT_TOPCKGEN, _rate)
 
 static const struct mtk_fixed_clk top_fixed_clks[] = {
-	FIXED_CLK0(CLK_TOP_CLK32K, 32000),
 	FIXED_CLK0(CLK_TOP_CLK_NULL, 0),
 	FIXED_CLK1(CLK_TOP_I2S0_BCK, 26000000),
 	FIXED_CLK0(CLK_TOP_DSI0_LNTC_DSICK, 75000000),
@@ -256,6 +124,7 @@ static const struct mtk_fixed_factor top_divs[] = {
 	PLL_FACTOR(CLK_TOP_SYSPLL_D7, "syspll_d7", CLK_APMIXED_MAINPLL, 1, 7),
 	PLL_FACTOR(CLK_TOP_SYSPLL4_D2, "syspll4_d2", CLK_APMIXED_MAINPLL, 1, 14),
 	PLL_FACTOR(CLK_TOP_SYSPLL4_D4, "syspll4_d4", CLK_APMIXED_MAINPLL, 1, 28),
+	PLL_FACTOR(CLK_TOP_UNIVPLL, "univpll", CLK_APMIXED_UNIVPLL, 1, 1),
 	PLL_FACTOR(CLK_TOP_UNIVPLL_D2, "univpll_d2", CLK_APMIXED_UNIVPLL, 1, 2),
 	PLL_FACTOR(CLK_TOP_UNIVPLL1_D2, "univpll1_d2", CLK_APMIXED_UNIVPLL, 1, 4),
 	PLL_FACTOR(CLK_TOP_UNIVPLL1_D4, "univpll1_d4", CLK_APMIXED_UNIVPLL, 1, 8),
@@ -286,7 +155,6 @@ static const struct mtk_fixed_factor top_divs[] = {
 	PLL_FACTOR1(CLK_TOP_APLL2_D2, "apll2_d2", CLK_TOP_APLL2, 1, 2),
 	PLL_FACTOR1(CLK_TOP_APLL2_D4, "apll2_d4", CLK_TOP_APLL2, 1, 4),
 	PLL_FACTOR1(CLK_TOP_APLL2_D8, "apll2_d8", CLK_TOP_APLL2, 1, 8),
-	PLL_FACTOR2(CLK_TOP_CLK26M, "clk26m_ck", CLK_XTAL, 1, 1),
 	PLL_FACTOR2(CLK_TOP_SYS_26M_D2, "sys_26m_d2", CLK_XTAL, 1, 2),
 	PLL_FACTOR(CLK_TOP_MSDCPLL, "msdcpll_ck", CLK_APMIXED_MSDCPLL, 1, 1),
 	PLL_FACTOR(CLK_TOP_MSDCPLL_D2, "msdcpll_d2", CLK_APMIXED_MSDCPLL, 1, 2),
@@ -299,21 +167,21 @@ static const struct mtk_fixed_factor top_divs[] = {
 };
 
 static const struct mtk_parent axi_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_SYSPLL_D7),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
 	TOP_PARENT(CLK_TOP_SYSPLL3_D2),
 };
 
 static const struct mtk_parent mem_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MMPLL),
 	TOP_PARENT(CLK_TOP_SYSPLL_D3),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
 };
 
 static const struct mtk_parent mm_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MMPLL),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
 	TOP_PARENT(CLK_TOP_SYSPLL_D5),
@@ -324,7 +192,7 @@ static const struct mtk_parent mm_parents[] = {
 };
 
 static const struct mtk_parent scp_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
@@ -334,20 +202,20 @@ static const struct mtk_parent scp_parents[] = {
 };
 
 static const struct mtk_parent mfg_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MFGPLL),
 	TOP_PARENT(CLK_TOP_SYSPLL_D3),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
 };
 
 static const struct mtk_parent atb_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
 };
 
 static const struct mtk_parent camtg_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_USB20_192M_D8),
 	TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
 	TOP_PARENT(CLK_TOP_USB20_192M_D4),
@@ -357,26 +225,26 @@ static const struct mtk_parent camtg_parents[] = {
 };
 
 static const struct mtk_parent uart_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
 };
 
 static const struct mtk_parent spi_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
 };
 
 static const struct mtk_parent msdc50_0_hc_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL1_D4),
 	TOP_PARENT(CLK_TOP_SYSPLL2_D2),
 };
 
 static const struct mtk_parent msdc50_0_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MSDCPLL),
 	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
@@ -387,7 +255,7 @@ static const struct mtk_parent msdc50_0_parents[] = {
 };
 
 static const struct mtk_parent msdc50_2_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MSDCPLL),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
 	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
@@ -398,7 +266,7 @@ static const struct mtk_parent msdc50_2_parents[] = {
 };
 
 static const struct mtk_parent msdc30_1_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MSDCPLL_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
 	TOP_PARENT(CLK_TOP_SYSPLL2_D2),
@@ -409,73 +277,73 @@ static const struct mtk_parent msdc30_1_parents[] = {
 };
 
 static const struct mtk_parent audio_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_SYSPLL3_D4),
 	TOP_PARENT(CLK_TOP_SYSPLL4_D4),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D16),
 };
 
 static const struct mtk_parent aud_intbus_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
 	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
 };
 
 static const struct mtk_parent aud_1_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_APLL1),
 };
 
 static const struct mtk_parent aud_2_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_APLL2),
 };
 
 static const struct mtk_parent aud_engen1_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_APLL1_D2),
 	TOP_PARENT(CLK_TOP_APLL1_D4),
 	TOP_PARENT(CLK_TOP_APLL1_D8),
 };
 
 static const struct mtk_parent aud_engen2_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_APLL2_D2),
 	TOP_PARENT(CLK_TOP_APLL2_D4),
 	TOP_PARENT(CLK_TOP_APLL2_D8),
 };
 
 static const struct mtk_parent aud_spdif_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D2),
 };
 
 static const struct mtk_parent disp_pwm_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
 };
 
 static const struct mtk_parent dxcc_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
 };
 
 static const struct mtk_parent ssusb_sys_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL3_D2),
 };
 
 static const struct mtk_parent spm_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
 };
 
 static const struct mtk_parent i2c_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL3_D2),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
@@ -483,20 +351,20 @@ static const struct mtk_parent i2c_parents[] = {
 };
 
 static const struct mtk_parent pwm_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
 };
 
 static const struct mtk_parent senif_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL1_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
 };
 
 static const struct mtk_parent aes_fde_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MSDCPLL),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
 	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
@@ -505,7 +373,7 @@ static const struct mtk_parent aes_fde_parents[] = {
 };
 
 static const struct mtk_parent dpi0_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_LVDSPLL_D2),
 	TOP_PARENT(CLK_TOP_LVDSPLL_D4),
 	TOP_PARENT(CLK_TOP_LVDSPLL_D8),
@@ -513,7 +381,7 @@ static const struct mtk_parent dpi0_parents[] = {
 };
 
 static const struct mtk_parent dsp_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_SYS_26M_D2),
 	TOP_PARENT(CLK_TOP_DSPPLL),
 	TOP_PARENT(CLK_TOP_DSPPLL_D2),
@@ -522,7 +390,7 @@ static const struct mtk_parent dsp_parents[] = {
 };
 
 static const struct mtk_parent nfi2x_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_SYSPLL2_D2),
 	TOP_PARENT(CLK_TOP_SYSPLL_D7),
 	TOP_PARENT(CLK_TOP_SYSPLL_D3),
@@ -533,7 +401,7 @@ static const struct mtk_parent nfi2x_parents[] = {
 };
 
 static const struct mtk_parent nfiecc_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
 	TOP_PARENT(CLK_TOP_SYSPLL_D7),
@@ -544,7 +412,7 @@ static const struct mtk_parent nfiecc_parents[] = {
 };
 
 static const struct mtk_parent ecc_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
@@ -552,7 +420,7 @@ static const struct mtk_parent ecc_parents[] = {
 };
 
 static const struct mtk_parent eth_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
 	TOP_PARENT(CLK_TOP_SYSPLL4_D4),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
@@ -560,7 +428,7 @@ static const struct mtk_parent eth_parents[] = {
 };
 
 static const struct mtk_parent gcpu_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
 	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
 	TOP_PARENT(CLK_TOP_SYSPLL_D3),
@@ -568,13 +436,13 @@ static const struct mtk_parent gcpu_parents[] = {
 };
 
 static const struct mtk_parent gcpu_cpm_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
 	TOP_PARENT(CLK_TOP_SYSPLL2_D2),
 };
 
 static const struct mtk_parent apu_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D2),
 	TOP_PARENT(CLK_TOP_APUPLL),
 	TOP_PARENT(CLK_TOP_MMPLL),
@@ -684,6 +552,14 @@ static const struct mtk_gate_regs top2_cg_regs = {
 		.flags = CLK_GATE_NO_SETCLR_INV | CLK_PARENT_TOPCKGEN, \
 	}
 
+#define GATE_EXT(_id, _parent, _shift) {			       \
+		.id = _id,					       \
+		.parent = _parent,				       \
+		.regs = &top0_cg_regs,				       \
+		.shift = _shift,				       \
+		.flags = CLK_GATE_NO_SETCLR | CLK_PARENT_EXT,	       \
+	}
+
 static const struct mtk_gate top_clk_gates[] = {
 	GATE_TOP2(CLK_TOP_AUD_I2S0_M, CLK_TOP_APLL12_CK_DIV0, 0),
 	GATE_TOP2(CLK_TOP_AUD_I2S1_M, CLK_TOP_APLL12_CK_DIV1, 1),
@@ -700,19 +576,19 @@ static const struct mtk_gate top_clk_gates[] = {
 	GATE_TOP1(CLK_TOP_VPLL_DPIX_EN, CLK_TOP_VPLL_DPIX, 21),
 	GATE_TOP1(CLK_TOP_SSUSB_TOP_CK_EN, CLK_TOP_CLK_NULL, 22),
 	GATE_TOP1(CLK_TOP_SSUSB_PHY_CK_EN, CLK_TOP_CLK_NULL, 23),
-	GATE_TOP0(CLK_TOP_CONN_32K, CLK_TOP_CLK32K, 10),
-	GATE_TOP0(CLK_TOP_CONN_26M, CLK_TOP_CLK26M, 11),
-	GATE_TOP0(CLK_TOP_DSP_32K, CLK_TOP_CLK32K, 16),
-	GATE_TOP0(CLK_TOP_DSP_26M, CLK_TOP_CLK26M, 17),
+	GATE_EXT(CLK_TOP_CONN_32K, CLK_PAD_CLK32K, 10),
+	GATE_EXT(CLK_TOP_CONN_26M, CLK_PAD_CLK26M, 11),
+	GATE_EXT(CLK_TOP_DSP_32K, CLK_PAD_CLK32K, 16),
+	GATE_EXT(CLK_TOP_DSP_26M, CLK_PAD_CLK26M, 17),
 };
 
 static const struct mtk_clk_tree mt8365_topckgen_tree = {
 	.xtal_rate = 26 * MHZ,
-	.id_offs_map = mt8365_topckgen_id_map,
-	.id_offs_map_size = ARRAY_SIZE(mt8365_topckgen_id_map),
-	.fdivs_offs = mt8365_topckgen_id_map[CLK_TOP_MFGPLL],
-	.muxes_offs = mt8365_topckgen_id_map[CLK_TOP_AXI_SEL],
-	.gates_offs = mt8365_topckgen_id_map[CLK_TOP_AUD_I2S0_M],
+	.ext_clk_rates = ext_clk_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clk_rates),
+	.fdivs_offs = CLK_TOP_MFGPLL,
+	.muxes_offs = CLK_TOP_AXI_SEL,
+	.gates_offs = CLK_TOP_AUD_I2S0_M,
 	.fclks = top_fixed_clks,
 	.fdivs = top_divs,
 	.muxes = top_muxes,
@@ -778,12 +654,33 @@ static const struct mtk_gate_regs ifr6_cg_regs = {
 #define GATE_IFR6(_id, _parent, _shift)				\
 	GATE_IFRX(_id, _parent, _shift, &ifr6_cg_regs)
 
+#define GATE_IFRX_EXT(_id, _parent, _shift, _regs)		\
+	{							\
+		.id = _id,					\
+		.parent = _parent,				\
+		.regs = _regs,					\
+		.shift = _shift,				\
+		.flags = CLK_GATE_SETCLR | CLK_PARENT_EXT,	\
+	}
+
+#define GATE_IFR2_EXT(_id, _parent, _shift)			\
+	GATE_IFRX_EXT(_id, _parent, _shift, &ifr2_cg_regs)
+
+#define GATE_IFR3_EXT(_id, _parent, _shift)			\
+	GATE_IFRX_EXT(_id, _parent, _shift, &ifr3_cg_regs)
+
+#define GATE_IFR4_EXT(_id, _parent, _shift)			\
+	GATE_IFRX_EXT(_id, _parent, _shift, &ifr4_cg_regs)
+
+#define GATE_IFR5_EXT(_id, _parent, _shift)			\
+	GATE_IFRX_EXT(_id, _parent, _shift, &ifr5_cg_regs)
+
 static const struct mtk_gate ifr_clks[] = {
 	/* IFR2 */
-	GATE_IFR2(CLK_IFR_PMIC_TMR, CLK_TOP_CLK26M, 0),
-	GATE_IFR2(CLK_IFR_PMIC_AP, CLK_TOP_CLK26M, 1),
-	GATE_IFR2(CLK_IFR_PMIC_MD, CLK_TOP_CLK26M, 2),
-	GATE_IFR2(CLK_IFR_PMIC_CONN, CLK_TOP_CLK26M, 3),
+	GATE_IFR2_EXT(CLK_IFR_PMIC_TMR, CLK_PAD_CLK26M, 0),
+	GATE_IFR2_EXT(CLK_IFR_PMIC_AP, CLK_PAD_CLK26M, 1),
+	GATE_IFR2_EXT(CLK_IFR_PMIC_MD, CLK_PAD_CLK26M, 2),
+	GATE_IFR2_EXT(CLK_IFR_PMIC_CONN, CLK_PAD_CLK26M, 3),
 	GATE_IFR2(CLK_IFR_ICUSB, CLK_TOP_AXI_SEL, 8),
 	GATE_IFR2(CLK_IFR_GCE, CLK_TOP_AXI_SEL, 9),
 	GATE_IFR2(CLK_IFR_THERM, CLK_TOP_AXI_SEL, 10),
@@ -798,7 +695,7 @@ static const struct mtk_gate ifr_clks[] = {
 	GATE_IFR2(CLK_IFR_UART1, CLK_TOP_UART_SEL, 23),
 	GATE_IFR2(CLK_IFR_UART2, CLK_TOP_UART_SEL, 24),
 	GATE_IFR2(CLK_IFR_DSP_UART, CLK_TOP_UART_SEL, 26),
-	GATE_IFR2(CLK_IFR_GCE_26M, CLK_TOP_CLK26M, 27),
+	GATE_IFR2_EXT(CLK_IFR_GCE_26M, CLK_PAD_CLK26M, 27),
 	GATE_IFR2(CLK_IFR_CQ_DMA_FPC, CLK_TOP_AXI_SEL, 28),
 	GATE_IFR2(CLK_IFR_BTIF, CLK_TOP_AXI_SEL, 31),
 	/* IFR3 */
@@ -806,19 +703,19 @@ static const struct mtk_gate ifr_clks[] = {
 	GATE_IFR3(CLK_IFR_MSDC0_HCLK, CLK_TOP_AXI_SEL, 2),
 	GATE_IFR3(CLK_IFR_MSDC2_HCLK, CLK_TOP_AXI_SEL, 3),
 	GATE_IFR3(CLK_IFR_MSDC1_HCLK, CLK_TOP_AXI_SEL, 4),
-	GATE_IFR3(CLK_IFR_DVFSRC, CLK_TOP_CLK26M, 7),
+	GATE_IFR3_EXT(CLK_IFR_DVFSRC, CLK_PAD_CLK26M, 7),
 	GATE_IFR3(CLK_IFR_GCPU, CLK_TOP_AXI_SEL, 8),
 	GATE_IFR3(CLK_IFR_TRNG, CLK_TOP_AXI_SEL, 9),
-	GATE_IFR3(CLK_IFR_AUXADC, CLK_TOP_CLK26M, 10),
+	GATE_IFR3_EXT(CLK_IFR_AUXADC, CLK_PAD_CLK26M, 10),
 	GATE_IFR3(CLK_IFR_CPUM, CLK_TOP_AXI_SEL, 11),
-	GATE_IFR3(CLK_IFR_AUXADC_MD, CLK_TOP_CLK26M, 14),
+	GATE_IFR3_EXT(CLK_IFR_AUXADC_MD, CLK_PAD_CLK26M, 14),
 	GATE_IFR3(CLK_IFR_AP_DMA, CLK_TOP_AXI_SEL, 18),
 	GATE_IFR3(CLK_IFR_DEBUGSYS, CLK_TOP_AXI_SEL, 24),
 	GATE_IFR3(CLK_IFR_AUDIO, CLK_TOP_AXI_SEL, 25),
 	/* IFR4 */
 	GATE_IFR4(CLK_IFR_PWM_FBCLK6, CLK_TOP_PWM_SEL, 0),
 	GATE_IFR4(CLK_IFR_DISP_PWM, CLK_TOP_DISP_PWM_SEL, 2),
-	GATE_IFR4(CLK_IFR_AUD_26M_BK, CLK_TOP_CLK26M, 4),
+	GATE_IFR4_EXT(CLK_IFR_AUD_26M_BK, CLK_PAD_CLK26M, 4),
 	GATE_IFR4(CLK_IFR_CQ_DMA, CLK_TOP_AXI_SEL, 27),
 	/* IFR5 */
 	GATE_IFR5(CLK_IFR_MSDC0_SF, CLK_TOP_MSDC50_0_SEL, 0),
@@ -829,12 +726,12 @@ static const struct mtk_gate ifr_clks[] = {
 	GATE_IFR5(CLK_IFR_MSDC0_SRC, CLK_TOP_MSDC50_0_SEL, 9),
 	GATE_IFR5(CLK_IFR_MSDC1_SRC, CLK_TOP_MSDC30_1_SEL, 10),
 	GATE_IFR5(CLK_IFR_MSDC2_SRC, CLK_TOP_MSDC50_2_SEL, 11),
-	GATE_IFR5(CLK_IFR_PWRAP_TMR, CLK_TOP_CLK26M, 12),
-	GATE_IFR5(CLK_IFR_PWRAP_SPI, CLK_TOP_CLK26M, 13),
-	GATE_IFR5(CLK_IFR_PWRAP_SYS, CLK_TOP_CLK26M, 14),
+	GATE_IFR5_EXT(CLK_IFR_PWRAP_TMR, CLK_PAD_CLK26M, 12),
+	GATE_IFR5_EXT(CLK_IFR_PWRAP_SPI, CLK_PAD_CLK26M, 13),
+	GATE_IFR5_EXT(CLK_IFR_PWRAP_SYS, CLK_PAD_CLK26M, 14),
 	GATE_IFR5(CLK_IFR_MCU_PM_BK, CLK_TOP_AXI_SEL, 16),
-	GATE_IFR5(CLK_IFR_IRRX_26M, CLK_TOP_CLK26M, 22),
-	GATE_IFR5(CLK_IFR_IRRX_32K, CLK_TOP_CLK32K, 23),
+	GATE_IFR5_EXT(CLK_IFR_IRRX_26M, CLK_PAD_CLK26M, 22),
+	GATE_IFR5_EXT(CLK_IFR_IRRX_32K, CLK_PAD_CLK32K, 23),
 	GATE_IFR5(CLK_IFR_I2C0_AXI, CLK_TOP_I2C_SEL, 24),
 	GATE_IFR5(CLK_IFR_I2C1_AXI, CLK_TOP_I2C_SEL, 25),
 	GATE_IFR5(CLK_IFR_I2C2_AXI, CLK_TOP_I2C_SEL, 26),
@@ -859,6 +756,8 @@ static const struct mtk_gate ifr_clks[] = {
 
 static const struct mtk_clk_tree mt8365_infracfg_tree = {
 	.xtal_rate = 26 * MHZ,
+	.ext_clk_rates = ext_clk_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clk_rates),
 };
 
 static int mt8365_apmixedsys_probe(struct udevice *dev)

---
base-commit: 5f01b24d93976de4d38656df24fcc4f56869753d
change-id: 20260302-mtk-clk-8365-drop-map-eef332876f99

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

