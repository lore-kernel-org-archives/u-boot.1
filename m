Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18CAE9370C
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 12:12:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9783F86C73;
	Thu,  5 Oct 2023 14:08:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="LLEOvGDK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 116C686FA7; Thu,  5 Oct 2023 10:55:14 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F72087229
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 10:54:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 65D1C100007;
 Thu,  5 Oct 2023 11:54:50 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 65D1C100007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1696496090;
 bh=UkgSt8haYnsZlwDRcuu7lA7HL0Vl4ijlLQ60TLQep74=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=LLEOvGDKMLXQjI4NKRlW7kMq53ySJZSJOluTbiM9MWeAxSlraD88KJxtrlX27HoQg
 Vu3ovkY5hMazGrypCoRSHOVogc3h43GF70qXsRft4TAtFi+WbUI8MWs5lgXbgPNdLz
 HSHq3pm0pe6oqbHMGBkyuBSOpVgjR/CR8NlgX/pazwY3e0KRrWmQ5r2wZIJJ9MgpVn
 kpnpr6BjVYCTWH84V57sP6UuFGlETUdlxWhBKHqM6VT417oK3AcBdInrEzaj00X23Q
 vFKvJQxYKoXZro7mjglVh4nxpMGpeW2LduygwqKYlutJ6rHMdrNimh9rJHHvp7p2BE
 wgEnOZbxily4Q==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu,  5 Oct 2023 11:54:50 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 5 Oct 2023 11:54:49 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <narmstrong@baylibre.com>, <sjg@google.com>, 
 <lukma@denx.de>, <marex@denx.de>
CC: <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>,
 <kernel@sberdevices.ru>, Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v3 3/8] phy: get rid of raw hex values
Date: Thu, 5 Oct 2023 11:54:24 +0300
Message-ID: <20231005085434.74755-4-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231005085434.74755-1-avromanov@salutedevices.com>
References: <20231005085434.74755-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180369 [Oct 05 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 535 535
 da804c0ea8918f802fc60e7a20ba49783d957ba2,
 {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;
 salutedevices.com:7.1.1; 127.0.0.199:7.1.2;
 p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s,
 ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/10/05 07:49:00 #22061642
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Thu, 05 Oct 2023 14:07:47 +0200
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

It is better to use defines instead of write raw
hex values in regmap.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/phy/meson-g12a-usb2.c | 161 ++++++++++++++++++++++++++++++++--
 1 file changed, 153 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/meson-g12a-usb2.c b/drivers/phy/meson-g12a-usb2.c
index 8b24322515..a803b6796c 100644
--- a/drivers/phy/meson-g12a-usb2.c
+++ b/drivers/phy/meson-g12a-usb2.c
@@ -24,12 +24,28 @@
 
 #include <linux/bitops.h>
 #include <linux/compat.h>
+#include <linux/bitfield.h>
 
 #define PHY_CTRL_R0						0x0
 #define PHY_CTRL_R1						0x4
 #define PHY_CTRL_R2						0x8
+
 #define PHY_CTRL_R3						0xc
+	#define PHY_CTRL_R3_SQUELCH_REF				GENMASK(1, 0)
+	#define PHY_CTRL_R3_HSDIC_REF				GENMASK(3, 2)
+	#define PHY_CTRL_R3_DISC_THRESH				GENMASK(7, 4)
+
 #define PHY_CTRL_R4						0x10
+	#define PHY_CTRL_R4_CALIB_CODE_7_0			GENMASK(7, 0)
+	#define PHY_CTRL_R4_CALIB_CODE_15_8			GENMASK(15, 8)
+	#define PHY_CTRL_R4_CALIB_CODE_23_16			GENMASK(23, 16)
+	#define PHY_CTRL_R4_I_C2L_CAL_EN			BIT(24)
+	#define PHY_CTRL_R4_I_C2L_CAL_RESET_N			BIT(25)
+	#define PHY_CTRL_R4_I_C2L_CAL_DONE			BIT(26)
+	#define PHY_CTRL_R4_TEST_BYPASS_MODE_EN			BIT(27)
+	#define PHY_CTRL_R4_I_C2L_BIAS_TRIM_1_0			GENMASK(29, 28)
+	#define PHY_CTRL_R4_I_C2L_BIAS_TRIM_3_2			GENMASK(31, 30)
+
 #define PHY_CTRL_R5						0x14
 #define PHY_CTRL_R6						0x18
 #define PHY_CTRL_R7						0x1c
@@ -38,15 +54,93 @@
 #define PHY_CTRL_R10						0x28
 #define PHY_CTRL_R11						0x2c
 #define PHY_CTRL_R12						0x30
+
 #define PHY_CTRL_R13						0x34
+	#define PHY_CTRL_R13_CUSTOM_PATTERN_19			GENMASK(7, 0)
+	#define PHY_CTRL_R13_LOAD_STAT				BIT(14)
+	#define PHY_CTRL_R13_UPDATE_PMA_SIGNALS			BIT(15)
+	#define PHY_CTRL_R13_MIN_COUNT_FOR_SYNC_DET		GENMASK(20, 16)
+	#define PHY_CTRL_R13_CLEAR_HOLD_HS_DISCONNECT		BIT(21)
+	#define PHY_CTRL_R13_BYPASS_HOST_DISCONNECT_VAL		BIT(22)
+	#define PHY_CTRL_R13_BYPASS_HOST_DISCONNECT_EN		BIT(23)
+	#define PHY_CTRL_R13_I_C2L_HS_EN			BIT(24)
+	#define PHY_CTRL_R13_I_C2L_FS_EN			BIT(25)
+	#define PHY_CTRL_R13_I_C2L_LS_EN			BIT(26)
+	#define PHY_CTRL_R13_I_C2L_HS_OE			BIT(27)
+	#define PHY_CTRL_R13_I_C2L_FS_OE			BIT(28)
+	#define PHY_CTRL_R13_I_C2L_HS_RX_EN			BIT(29)
+	#define PHY_CTRL_R13_I_C2L_FSLS_RX_EN			BIT(30)
+
 #define PHY_CTRL_R14						0x38
 #define PHY_CTRL_R15						0x3c
+
 #define PHY_CTRL_R16						0x40
+	#define PHY_CTRL_R16_MPLL_M				GENMASK(8, 0)
+	#define PHY_CTRL_R16_MPLL_N				GENMASK(14, 10)
+	#define PHY_CTRL_R16_MPLL_TDC_MODE			BIT(20)
+	#define PHY_CTRL_R16_MPLL_SDM_EN			BIT(21)
+	#define PHY_CTRL_R16_MPLL_LOAD				BIT(22)
+	#define PHY_CTRL_R16_MPLL_DCO_SDM_EN			BIT(23)
+	#define PHY_CTRL_R16_MPLL_LOCK_LONG			GENMASK(25, 24)
+	#define PHY_CTRL_R16_MPLL_LOCK_F			BIT(26)
+	#define PHY_CTRL_R16_MPLL_FAST_LOCK			BIT(27)
+	#define PHY_CTRL_R16_MPLL_EN				BIT(28)
+	#define PHY_CTRL_R16_MPLL_RESET				BIT(29)
+	#define PHY_CTRL_R16_MPLL_LOCK				BIT(30)
+	#define PHY_CTRL_R16_MPLL_LOCK_DIG			BIT(31)
+
 #define PHY_CTRL_R17						0x44
+	#define PHY_CTRL_R17_MPLL_FRAC_IN			GENMASK(13, 0)
+	#define PHY_CTRL_R17_MPLL_FIX_EN			BIT(16)
+	#define PHY_CTRL_R17_MPLL_LAMBDA1			GENMASK(19, 17)
+	#define PHY_CTRL_R17_MPLL_LAMBDA0			GENMASK(22, 20)
+	#define PHY_CTRL_R17_MPLL_FILTER_MODE			BIT(23)
+	#define PHY_CTRL_R17_MPLL_FILTER_PVT2			GENMASK(27, 24)
+	#define PHY_CTRL_R17_MPLL_FILTER_PVT1			GENMASK(31, 28)
+
 #define PHY_CTRL_R18						0x48
+	#define PHY_CTRL_R18_MPLL_LKW_SEL			GENMASK(1, 0)
+	#define PHY_CTRL_R18_MPLL_LK_W				GENMASK(5, 2)
+	#define PHY_CTRL_R18_MPLL_LK_S				GENMASK(11, 6)
+	#define PHY_CTRL_R18_MPLL_DCO_M_EN			BIT(12)
+	#define PHY_CTRL_R18_MPLL_DCO_CLK_SEL			BIT(13)
+	#define PHY_CTRL_R18_MPLL_PFD_GAIN			GENMASK(15, 14)
+	#define PHY_CTRL_R18_MPLL_ROU				GENMASK(18, 16)
+	#define PHY_CTRL_R18_MPLL_DATA_SEL			GENMASK(21, 19)
+	#define PHY_CTRL_R18_MPLL_BIAS_ADJ			GENMASK(23, 22)
+	#define PHY_CTRL_R18_MPLL_BB_MODE			GENMASK(25, 24)
+	#define PHY_CTRL_R18_MPLL_ALPHA				GENMASK(28, 26)
+	#define PHY_CTRL_R18_MPLL_ADJ_LDO			GENMASK(30, 29)
+	#define PHY_CTRL_R18_MPLL_ACG_RANGE			BIT(31)
+
 #define PHY_CTRL_R19						0x4c
+
 #define PHY_CTRL_R20						0x50
+	#define PHY_CTRL_R20_USB2_IDDET_EN			BIT(0)
+	#define PHY_CTRL_R20_USB2_OTG_VBUS_TRIM_2_0		GENMASK(3, 1)
+	#define PHY_CTRL_R20_USB2_OTG_VBUSDET_EN		BIT(4)
+	#define PHY_CTRL_R20_USB2_AMON_EN			BIT(5)
+	#define PHY_CTRL_R20_USB2_CAL_CODE_R5			BIT(6)
+	#define PHY_CTRL_R20_BYPASS_OTG_DET			BIT(7)
+	#define PHY_CTRL_R20_USB2_DMON_EN			BIT(8)
+	#define PHY_CTRL_R20_USB2_DMON_SEL_3_0			GENMASK(12, 9)
+	#define PHY_CTRL_R20_USB2_EDGE_DRV_EN			BIT(13)
+	#define PHY_CTRL_R20_USB2_EDGE_DRV_TRIM_1_0		GENMASK(15, 14)
+	#define PHY_CTRL_R20_USB2_BGR_ADJ_4_0			GENMASK(20, 16)
+	#define PHY_CTRL_R20_USB2_BGR_START			BIT(21)
+	#define PHY_CTRL_R20_USB2_BGR_VREF_4_0			GENMASK(28, 24)
+	#define PHY_CTRL_R20_USB2_BGR_DBG_1_0			GENMASK(30, 29)
+	#define PHY_CTRL_R20_BYPASS_CAL_DONE_R5			BIT(31)
+
 #define PHY_CTRL_R21						0x54
+	#define PHY_CTRL_R21_USB2_BGR_FORCE			BIT(0)
+	#define PHY_CTRL_R21_USB2_CAL_ACK_EN			BIT(1)
+	#define PHY_CTRL_R21_USB2_OTG_ACA_EN			BIT(2)
+	#define PHY_CTRL_R21_USB2_TX_STRG_PD			BIT(3)
+	#define PHY_CTRL_R21_USB2_OTG_ACA_TRIM_1_0		GENMASK(5, 4)
+	#define PHY_CTRL_R21_BYPASS_UTMI_CNTR			GENMASK(15, 6)
+	#define PHY_CTRL_R21_BYPASS_UTMI_REG			GENMASK(25, 20)
+
 #define PHY_CTRL_R22						0x58
 #define PHY_CTRL_R23						0x5c
 
@@ -79,25 +173,76 @@ static int phy_meson_g12a_usb2_init(struct phy *phy)
 	regmap_update_bits(priv->regmap, PHY_CTRL_R21, BIT(2), 0);
 
 	/* PLL Setup : 24MHz * 20 / 1 = 480MHz */
-	regmap_write(priv->regmap, PHY_CTRL_R16, 0x39400414);
-	regmap_write(priv->regmap, PHY_CTRL_R17, 0x927e0000);
-	regmap_write(priv->regmap, PHY_CTRL_R18, 0xac5f49e5);
+	regmap_write(priv->regmap, PHY_CTRL_R16,
+		FIELD_PREP(PHY_CTRL_R16_MPLL_M, 20) |
+		FIELD_PREP(PHY_CTRL_R16_MPLL_N, 1) |
+		PHY_CTRL_R16_MPLL_LOAD |
+		FIELD_PREP(PHY_CTRL_R16_MPLL_LOCK_LONG, 1) |
+		PHY_CTRL_R16_MPLL_FAST_LOCK |
+		PHY_CTRL_R16_MPLL_EN |
+		PHY_CTRL_R16_MPLL_RESET);
+
+	regmap_write(priv->regmap, PHY_CTRL_R17,
+		FIELD_PREP(PHY_CTRL_R17_MPLL_FRAC_IN, 0) |
+		FIELD_PREP(PHY_CTRL_R17_MPLL_LAMBDA1, 7) |
+		FIELD_PREP(PHY_CTRL_R17_MPLL_LAMBDA0, 7) |
+		FIELD_PREP(PHY_CTRL_R17_MPLL_FILTER_PVT2, 2) |
+		FIELD_PREP(PHY_CTRL_R17_MPLL_FILTER_PVT1, 9));
+
+	regmap_write(priv->regmap, PHY_CTRL_R18,
+		FIELD_PREP(PHY_CTRL_R18_MPLL_LKW_SEL, 1) |
+		FIELD_PREP(PHY_CTRL_R18_MPLL_LK_W, 9) |
+		FIELD_PREP(PHY_CTRL_R18_MPLL_LK_S, 0x27) |
+		FIELD_PREP(PHY_CTRL_R18_MPLL_PFD_GAIN, 1) |
+		FIELD_PREP(PHY_CTRL_R18_MPLL_ROU, 7) |
+		FIELD_PREP(PHY_CTRL_R18_MPLL_DATA_SEL, 3) |
+		FIELD_PREP(PHY_CTRL_R18_MPLL_BIAS_ADJ, 1) |
+		FIELD_PREP(PHY_CTRL_R18_MPLL_BB_MODE, 0) |
+		FIELD_PREP(PHY_CTRL_R18_MPLL_ALPHA, 3) |
+		FIELD_PREP(PHY_CTRL_R18_MPLL_ADJ_LDO, 1) |
+		PHY_CTRL_R18_MPLL_ACG_RANGE;
 
 	udelay(PLL_RESET_COMPLETE_TIME);
 
 	/* UnReset PLL */
-	regmap_write(priv->regmap, PHY_CTRL_R16, 0x19400414);
+	regmap_write(priv->regmap, PHY_CTRL_R16,
+		FIELD_PREP(PHY_CTRL_R16_MPLL_M, 20) |
+		FIELD_PREP(PHY_CTRL_R16_MPLL_N, 1) |
+		PHY_CTRL_R16_MPLL_LOAD |
+		FIELD_PREP(PHY_CTRL_R16_MPLL_LOCK_LONG, 1) |
+		PHY_CTRL_R16_MPLL_FAST_LOCK |
+		PHY_CTRL_R16_MPLL_EN);
 
 	/* PHY Tuning */
-	regmap_write(priv->regmap, PHY_CTRL_R20, 0xfe18);
-	regmap_write(priv->regmap, PHY_CTRL_R4, 0x8000fff);
+	regmap_write(priv->regmap, PHY_CTRL_R20,
+		FIELD_PREP(PHY_CTRL_R20_USB2_OTG_VBUS_TRIM_2_0, 4) |
+		PHY_CTRL_R20_USB2_OTG_VBUSDET_EN |
+		FIELD_PREP(PHY_CTRL_R20_USB2_DMON_SEL_3_0, 15) |
+		PHY_CTRL_R20_USB2_EDGE_DRV_EN |
+		FIELD_PREP(PHY_CTRL_R20_USB2_EDGE_DRV_TRIM_1_0, 3) |
+		FIELD_PREP(PHY_CTRL_R20_USB2_BGR_ADJ_4_0, 0) |
+		FIELD_PREP(PHY_CTRL_R20_USB2_BGR_VREF_4_0, 0) |
+		FIELD_PREP(PHY_CTRL_R20_USB2_BGR_DBG_1_0, 0));
+
+	regmap_write(priv->regmap, PHY_CTRL_R4,
+		FIELD_PREP(PHY_CTRL_R4_CALIB_CODE_7_0, 0xf) |
+		FIELD_PREP(PHY_CTRL_R4_CALIB_CODE_15_8, 0xf) |
+		FIELD_PREP(PHY_CTRL_R4_CALIB_CODE_23_16, 0xf) |
+		PHY_CTRL_R4_TEST_BYPASS_MODE_EN |
+		FIELD_PREP(PHY_CTRL_R4_I_C2L_BIAS_TRIM_1_0, 0) |
+		FIELD_PREP(PHY_CTRL_R4_I_C2L_BIAS_TRIM_3_2, 0));
 
 	/* Tuning Disconnect Threshold */
-	regmap_write(priv->regmap, PHY_CTRL_R3, 0x34);
+	regmap_write(priv->regmap, PHY_CTRL_R3,
+		FIELD_PREP(PHY_CTRL_R3_SQUELCH_REF, 0) |
+		FIELD_PREP(PHY_CTRL_R3_HSDIC_REF, 1) |
+		FIELD_PREP(PHY_CTRL_R3_DISC_THRESH, 3));
 
 	/* Analog Settings */
 	regmap_write(priv->regmap, PHY_CTRL_R14, 0);
-	regmap_write(priv->regmap, PHY_CTRL_R13, 0x78000);
+	regmap_write(priv->regmap, PHY_CTRL_R13,
+		PHY_CTRL_R13_UPDATE_PMA_SIGNALS |
+		FIELD_PREP(PHY_CTRL_R13_MIN_COUNT_FOR_SYNC_DET, 7));
 
 	return 0;
 }
-- 
2.25.1

