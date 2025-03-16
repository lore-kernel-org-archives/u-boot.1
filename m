Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE778C282DE
	for <u-boot@archiver.kernel.org>; Sun, 16 Mar 2025 13:55:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50B52810EB;
	Sun, 16 Mar 2025 14:54:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="MwxXPuZg";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="QSUatYtc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DCCE81101; Sun, 16 Mar 2025 14:54:50 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 790A2810EB
 for <u-boot@lists.denx.de>; Sun, 16 Mar 2025 14:54:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ZG03D1XkZz9sbY;
 Sun, 16 Mar 2025 14:54:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742133288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ap38yoL6kpx29g8d5LgKmw72McZ1mLP8v/PcqnDtb5E=;
 b=MwxXPuZgEllcjb/iGg/K+5bhabRgcYw+WL6ipf8L5wBNKGtgj9uYtK9/M0MMwgSDfIGL/D
 G579y34dnsg0dYf7BSTX5P+MSifBQSR7gJSt649lfEPP3ighyWMhrUXg0YDHi4lHGJIe3f
 awo2sf5M4eo0irNBXyUbnplLDOoipgwFy+up/q76udRcyXTDCHNFglAaIi0a57UIdm1Tq4
 vznYuiFyqcpPBztO34CTo61zpnJORVI3h5zSNg7AJkwrX/euCPXbZVod14wvqVF0Y/eM1p
 bS2jzX6MIZEA28wkWjs78R7JqXCVfbgCh2hVvsKKoc10n9WOm/Ejx8PNeBx8fw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742133286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ap38yoL6kpx29g8d5LgKmw72McZ1mLP8v/PcqnDtb5E=;
 b=QSUatYtc8jl1SbUIuyTB/+ei2F6zOAj4Bsgow5KuAf2k2gycKpBcZTRF2NxeDRyNgmggbz
 ou2EeG16eYWok6imiS/6/ZUpWSh45Ww03N8vulPJqf5uk9I87cFNHCpaaTdIQHwiUjSq0r
 zwgZ2H2SPbn5fza21d9zLst5EO6IbQB8ENsGeh3/OJ1+45ieDuPZMe0KXrh2JNMXAhkaJJ
 EjEs5Mv0fDyJbImOA19krLqNIqzR0jw5b+88/82fNIzjlE/5upTYiQFgGWmfoa+Jgj+y2f
 8Xv8yPHRyRcvsI3/1jZkU77M29NM0VvzhFS21smwTvO7LGXzLuX8698npfiDlQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/7] ram: renesas: dbsc5: Synchronize initialization code to
 rev.1.10
Date: Sun, 16 Mar 2025 14:51:42 +0100
Message-ID: <20250316135417.7909-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250316135417.7909-1-marek.vasut+renesas@mailbox.org>
References: <20250316135417.7909-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: qyjeticcocabyg4dddrw9qs7qbabgmsn
X-MBO-RS-ID: 7d02cbe64d63e94b3c6
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

Update the DRAM initialization code to match DBSC5 initialization code
rev.1.10 , which is currently the latest version available. This makes
DRAM initialization operational on Renesas R-Car V4H R8A779G0 rev.3.0.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/ram/renesas/dbsc5/dram.c | 67 +++++++++++++++-----------------
 1 file changed, 31 insertions(+), 36 deletions(-)

diff --git a/drivers/ram/renesas/dbsc5/dram.c b/drivers/ram/renesas/dbsc5/dram.c
index 0616658e9f8..1b70faff7f7 100644
--- a/drivers/ram/renesas/dbsc5/dram.c
+++ b/drivers/ram/renesas/dbsc5/dram.c
@@ -220,6 +220,7 @@ static const u16 jedec_spec2_tRFC_ab[] = {
 #define PHY_RDLVL_RDDQS_DQ_TE_DLY_OBS		DDR_REGDEF(0x00, 0x09, 0x103F)
 #define PHY_WDQLVL_STATUS_OBS			DDR_REGDEF(0x00, 0x20, 0x1043)
 #define PHY_DATA_DC_CAL_START			DDR_REGDEF(0x18, 0x01, 0x104D)
+#define PHY_SLV_DLY_CTRL_GATE_DISABLE		DDR_REGDEF(0x10, 0x01, 0x104E)
 #define PHY_REGULATOR_EN_CNT			DDR_REGDEF(0x18, 0x06, 0x1050)
 #define PHY_VREF_INITIAL_START_POINT		DDR_REGDEF(0x00, 0x09, 0x1055)
 #define PHY_VREF_INITIAL_STOP_POINT		DDR_REGDEF(0x10, 0x09, 0x1055)
@@ -469,7 +470,7 @@ static const u32 DDR_PHY_SLICE_REGSET_V4H[DDR_PHY_SLICE_REGSET_NUM_V4H] = {
 	0x00000000, 0x00500050, 0x00500050, 0x00500050,
 	0x00500050, 0x0D000050, 0x10100004, 0x06102010,
 	0x61619041, 0x07097000, 0x00644180, 0x00803280,
-	0x00808001, 0x13010100, 0x02000016, 0x10001003,
+	0x00808001, 0x13010101, 0x02000016, 0x10001003,
 	0x06093E42, 0x0F063D01, 0x011700C8, 0x04100140,
 	0x00000100, 0x000001D1, 0x05000068, 0x00030402,
 	0x01400000, 0x80800300, 0x00160010, 0x76543210,
@@ -512,8 +513,8 @@ static const u32 DDR_PHY_ADR_G_REGSET_V4H[DDR_PHY_ADR_G_REGSET_NUM_V4H] = {
 	0x00040101, 0x00000000, 0x00000000, 0x00000064,
 	0x00000000, 0x00000000, 0x39421B42, 0x00010124,
 	0x00520052, 0x00000052, 0x00000000, 0x00000000,
-	0x00000000, 0x00000000, 0x00000000, 0x00000000,
-	0x00000000, 0x00000000, 0x00000000, 0x07030102,
+	0x00010001, 0x00000000, 0x00000000, 0x00010001,
+	0x00000000, 0x00000000, 0x00010001, 0x07030102,
 	0x01030307, 0x00000054, 0x00004096, 0x08200820,
 	0x08200820, 0x08200820, 0x08200820, 0x00000820,
 	0x004103B8, 0x0000003F, 0x000C0006, 0x00000000,
@@ -1294,7 +1295,7 @@ static const struct dbsc5_table_patch dbsc5_table_patch_slice_mbpsdiv_572 = {
 };
 
 static const struct dbsc5_table_patch dbsc5_table_patch_adr_g_mbpsdiv_572 = {
-	PHY_PAD_ACS_RX_PCLK_CLK_SEL, 0x03
+	PHY_PAD_ACS_RX_PCLK_CLK_SEL, 0x02
 };
 
 static const struct dbsc5_table_patch dbsc5_table_patch_adr_g_mbpsdiv_400[] = {
@@ -1713,14 +1714,17 @@ static void dbsc5_clk_wait_dbpdstat1(struct udevice *dev, u32 status)
 {
 	struct renesas_dbsc5_dram_priv *priv = dev_get_priv(dev);
 	void __iomem *regs_dbsc_d = priv->regs + DBSC5_DBSC_D_OFFSET;
-	u32 i, ch, reg;
+	u32 i, ch, chk, reg;
 
 	for (i = 0; i < 2; i++) {
 		do {
 			reg = status;
-			r_foreach_vch(dev, ch)
+			chk = 0;
+			r_foreach_vch(dev, ch) {
 				reg &= readl(regs_dbsc_d + DBSC_DBPDSTAT1(ch));
-		} while (reg != status);
+				chk |= readl(regs_dbsc_d + DBSC_DBPDSTAT0(ch));
+			}
+		} while (reg != status && !(chk & BIT(0)));
 	}
 }
 
@@ -3491,13 +3495,10 @@ static void dbsc5_manual_write_dca(struct udevice *dev)
 {
 	struct renesas_dbsc5_dram_priv *priv = dev_get_priv(dev);
 	const u32 rank = priv->ch_have_this_cs[1] ? 0x2 : 0x1;
-	u32 slv_dly_center[DRAM_CH_CNT][CS_CNT][SLICE_CNT];
-	u32 slv_dly_center_cyc;
-	u32 slv_dly_center_dly;
+	u32 phy_slv_dly[DRAM_CH_CNT][CS_CNT][SLICE_CNT];
+	u32 phy_slv_dly_avg[DRAM_CH_CNT][SLICE_CNT];
 	u32 slv_dly_min[DRAM_CH_CNT][SLICE_CNT];
 	u32 slv_dly_max[DRAM_CH_CNT][SLICE_CNT];
-	u32 slv_dly_min_tmp[DRAM_CH_CNT][CS_CNT][SLICE_CNT];
-	u32 slv_dly_max_tmp[DRAM_CH_CNT][CS_CNT][SLICE_CNT];
 	u32 phy_dcc_code_min[DRAM_CH_CNT][SLICE_CNT];
 	u32 phy_dcc_code_max[DRAM_CH_CNT][SLICE_CNT];
 	u32 phy_dcc_code_mid;
@@ -3521,18 +3522,9 @@ static void dbsc5_manual_write_dca(struct udevice *dev)
 		dbsc5_ddr_setval_all_ch_all_slice(dev, PHY_PER_CS_TRAINING_INDEX, cs);
 		r_foreach_vch(dev, ch) {
 			for (slice = 0; slice < SLICE_CNT; slice++) {
-				slv_dly_center[ch][cs][slice] =
-					dbsc5_ddr_getval_slice(dev, ch, slice, PHY_CLK_WRDQS_SLAVE_DELAY);
-				slv_dly_center_cyc = slv_dly_center[ch][cs][slice] & 0x180;
-				slv_dly_center_dly = slv_dly_center[ch][cs][slice] & 0x7F;
-				slv_dly_min_tmp[ch][cs][slice] =
-					slv_dly_center_cyc |
-					(slv_dly_center_dly * ratio_min / ratio_min_div);
-				slv_dly_max_tmp[ch][cs][slice] = slv_dly_center_cyc;
-				if ((slv_dly_center_dly * ratio_max) > (0x7F * ratio_max_div))
-					slv_dly_max_tmp[ch][cs][slice] |= 0x7F;
-				else
-					slv_dly_max_tmp[ch][cs][slice] |= slv_dly_center_dly * ratio_max / ratio_max_div;
+				phy_slv_dly[ch][cs][slice] =
+					dbsc5_ddr_getval_slice(dev, ch, slice,
+							       PHY_CLK_WRDQS_SLAVE_DELAY);
 			}
 		}
 	}
@@ -3540,22 +3532,22 @@ static void dbsc5_manual_write_dca(struct udevice *dev)
 	r_foreach_vch(dev, ch) {
 		for (slice = 0; slice < SLICE_CNT; slice++) {
 			if (rank == 0x2) {
-				if (slv_dly_max_tmp[ch][0][slice] < slv_dly_max_tmp[ch][1][slice])
-					slv_dly_max[ch][slice] = slv_dly_max_tmp[ch][1][slice];
-				else
-					slv_dly_max[ch][slice] = slv_dly_max_tmp[ch][0][slice];
-
-				if (slv_dly_min_tmp[ch][0][slice] < slv_dly_min_tmp[ch][1][slice])
-					slv_dly_min[ch][slice] = slv_dly_min_tmp[ch][0][slice];
-				else
-					slv_dly_min[ch][slice] = slv_dly_min_tmp[ch][1][slice];
+				/* Calculate average between ranks */
+				phy_slv_dly_avg[ch][slice] = (phy_slv_dly[ch][0][slice] +
+							      phy_slv_dly[ch][1][slice]) / 2;
 			} else {
-				slv_dly_max[ch][slice] = slv_dly_max_tmp[ch][0][slice];
-				slv_dly_min[ch][slice] = slv_dly_min_tmp[ch][0][slice];
+				phy_slv_dly_avg[ch][slice] = phy_slv_dly[ch][0][slice];
 			}
+			/* Determine the search range */
+			slv_dly_min[ch][slice] = (phy_slv_dly_avg[ch][slice] & 0x07F) * ratio_min / ratio_min_div;
+			slv_dly_max[ch][slice] = (phy_slv_dly_avg[ch][slice] & 0x07F) * ratio_max / ratio_max_div;
+			if (slv_dly_max[ch][slice] > 0x7F)
+				slv_dly_max[ch][slice] = 0x7F;
 		}
 	}
 
+	dbsc5_ddr_setval_all_ch_all_slice(dev, PHY_SLV_DLY_CTRL_GATE_DISABLE, 0x1);
+
 	for (i = 0; i <= 0x7F; i++) {
 		r_foreach_vch(dev, ch) {
 			for (slice = 0; slice < SLICE_CNT; slice++) {
@@ -3621,13 +3613,16 @@ static void dbsc5_manual_write_dca(struct udevice *dev)
 			for (slice = 0; slice < SLICE_CNT; slice++) {
 				dbsc5_ddr_setval_slice(dev, ch, slice,
 						       PHY_CLK_WRDQS_SLAVE_DELAY,
-						       slv_dly_center[ch][cs][slice]);
+						       phy_slv_dly[ch][cs][slice]);
 				dbsc5_ddr_setval_slice(dev, ch, slice,
 						       SC_PHY_WCK_CALC, 0x1);
 				dbsc5_ddr_setval(dev, ch, SC_PHY_MANUAL_UPDATE, 0x1);
 			}
 		}
 	}
+
+	dbsc5_ddr_setval_all_ch_all_slice(dev, PHY_SLV_DLY_CTRL_GATE_DISABLE, 0x0);
+
 	dbsc5_ddr_setval_all_ch_all_slice(dev, PHY_PER_CS_TRAINING_MULTICAST_EN, 0x1);
 
 	r_foreach_vch(dev, ch) {
-- 
2.47.2

