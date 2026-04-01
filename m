Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 345AF1112241
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 23:25:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 704DE8407E;
	Thu,  2 Apr 2026 01:24:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="EOf5ID9x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EF3484056; Wed,  1 Apr 2026 21:16:38 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CEAD80517
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 21:16:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5999510DBE8; Wed,  1 Apr 2026 21:16:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1775070995; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=Zks0Ywk80WzOc4gTliB85hoAXzm4YrdFfM/d5Y95LK4=;
 b=EOf5ID9xVbjTEZ83CPiUu0TPUenhWo82ry6+7CJPbEGHLY5I5OodRvSQDJTDmgVetRzrTE
 I3BwQ252FWSWx1m+jRbqdKQTYUvzrjyJQ7jTu2x1vccY7EcDf3Y06Aj4DhpPJMO8ik7btC
 pk3VSccvFcvBFLWGVCRhvGkI2dg0FOARgZlFKa06UakLsMgwc7h0oYxPAmWpPw8O5OGESB
 cr5M8Q/oJS5Plxp844TaAUJzgvqBd9wLK0lDqPR/3dLgVUZUJdhkiirt1tjo0kUAEtAGZG
 q97ZI1011jtUe+6YJy9GCQVhF32ySH90P/BzBes2dw2DCEhEWA9LKnrTN2nidQ==
From: Marek Vasut <marex@nabladev.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
Subject: [PATCH 1/4] arm64: imx8mp: Fold inline ECC into spl.c on DH i.MX8MP
 DHCOM SoM
Date: Wed,  1 Apr 2026 21:15:53 +0200
Message-ID: <20260401191617.20141-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Thu, 02 Apr 2026 01:24:51 +0200
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

The inline ECC configuration is identical for 2 GiB DRAM variants
and 4 GiB DRAM variants of the SoM, no matter the rank count. Fold
the ECC configuration directly into spl.c to simplify the upcoming
deduplication. No functional change.

Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
---
 board/dhelectronics/dh_imx8mp/lpddr4_timing.h |  4 ---
 .../dh_imx8mp/lpddr4_timing_2G_32.c           | 14 ----------
 .../dh_imx8mp/lpddr4_timing_4G_32.c           | 14 ----------
 board/dhelectronics/dh_imx8mp/spl.c           | 26 +++++++++++++++++++
 4 files changed, 26 insertions(+), 32 deletions(-)

diff --git a/board/dhelectronics/dh_imx8mp/lpddr4_timing.h b/board/dhelectronics/dh_imx8mp/lpddr4_timing.h
index c4d51174a33..f8078051f2f 100644
--- a/board/dhelectronics/dh_imx8mp/lpddr4_timing.h
+++ b/board/dhelectronics/dh_imx8mp/lpddr4_timing.h
@@ -9,10 +9,6 @@
 extern struct dram_timing_info dh_imx8mp_dhcom_dram_timing_16g_x32;
 extern struct dram_timing_info dh_imx8mp_dhcom_dram_timing_32g_x32;
 
-typedef void (*scrub_func_t)(void);
-extern void dh_imx8mp_dhcom_dram_scrub_16g_x32(void);
-extern void dh_imx8mp_dhcom_dram_scrub_32g_x32(void);
-
 u8 dh_get_memcfg(void);
 
 #define DDRC_ECCCFG0_ECC_MODE_MASK	0x7
diff --git a/board/dhelectronics/dh_imx8mp/lpddr4_timing_2G_32.c b/board/dhelectronics/dh_imx8mp/lpddr4_timing_2G_32.c
index add7a0bf23b..3cb868311f3 100644
--- a/board/dhelectronics/dh_imx8mp/lpddr4_timing_2G_32.c
+++ b/board/dhelectronics/dh_imx8mp/lpddr4_timing_2G_32.c
@@ -1853,17 +1853,3 @@ struct dram_timing_info dh_imx8mp_dhcom_dram_timing_16g_x32 = {
 	.ddrphy_pie_num = ARRAY_SIZE(ddr_phy_pie),
 	.fsp_table = { 3600, 400, 100, },
 };
-
-#if IS_ENABLED(CONFIG_IMX8M_DRAM_INLINE_ECC)
-void dh_imx8mp_dhcom_dram_scrub_16g_x32(void)
-{
-	ddrc_inline_ecc_scrub(0x0,0x3ffffff);
-	ddrc_inline_ecc_scrub(0x4000000,0x7ffffff);
-	ddrc_inline_ecc_scrub(0x8000000,0xbffffff);
-	ddrc_inline_ecc_scrub(0xc000000,0xfffffff);
-	ddrc_inline_ecc_scrub(0x10000000,0x13ffffff);
-	ddrc_inline_ecc_scrub(0x14000000,0x17ffffff);
-	ddrc_inline_ecc_scrub(0x18000000,0x1bffffff);
-	ddrc_inline_ecc_scrub_end(0x0,0x1fffffff);
-}
-#endif
diff --git a/board/dhelectronics/dh_imx8mp/lpddr4_timing_4G_32.c b/board/dhelectronics/dh_imx8mp/lpddr4_timing_4G_32.c
index 41b078f6e9f..3a475076e75 100644
--- a/board/dhelectronics/dh_imx8mp/lpddr4_timing_4G_32.c
+++ b/board/dhelectronics/dh_imx8mp/lpddr4_timing_4G_32.c
@@ -1857,17 +1857,3 @@ struct dram_timing_info dh_imx8mp_dhcom_dram_timing_32g_x32 = {
 	.ddrphy_pie_num = ARRAY_SIZE(ddr_phy_pie),
 	.fsp_table = { 3600, 400, 100, },
 };
-
-#if IS_ENABLED(CONFIG_IMX8M_DRAM_INLINE_ECC)
-void dh_imx8mp_dhcom_dram_scrub_32g_x32(void)
-{
-	ddrc_inline_ecc_scrub(0x0,0x7ffffff);
-	ddrc_inline_ecc_scrub(0x8000000,0xfffffff);
-	ddrc_inline_ecc_scrub(0x10000000,0x17ffffff);
-	ddrc_inline_ecc_scrub(0x18000000,0x1fffffff);
-	ddrc_inline_ecc_scrub(0x20000000,0x27ffffff);
-	ddrc_inline_ecc_scrub(0x28000000,0x2fffffff);
-	ddrc_inline_ecc_scrub(0x30000000,0x37ffffff);
-	ddrc_inline_ecc_scrub_end(0x0,0x3fffffff);
-}
-#endif
diff --git a/board/dhelectronics/dh_imx8mp/spl.c b/board/dhelectronics/dh_imx8mp/spl.c
index 727e1ff3774..d8a928639b2 100644
--- a/board/dhelectronics/dh_imx8mp/spl.c
+++ b/board/dhelectronics/dh_imx8mp/spl.c
@@ -139,6 +139,32 @@ static void spl_dram_init(void)
 }
 
 #if IS_ENABLED(CONFIG_IMX8M_DRAM_INLINE_ECC)
+static void dh_imx8mp_dhcom_dram_scrub_16g_x32(void)
+{
+	ddrc_inline_ecc_scrub(0x0,0x3ffffff);
+	ddrc_inline_ecc_scrub(0x4000000,0x7ffffff);
+	ddrc_inline_ecc_scrub(0x8000000,0xbffffff);
+	ddrc_inline_ecc_scrub(0xc000000,0xfffffff);
+	ddrc_inline_ecc_scrub(0x10000000,0x13ffffff);
+	ddrc_inline_ecc_scrub(0x14000000,0x17ffffff);
+	ddrc_inline_ecc_scrub(0x18000000,0x1bffffff);
+	ddrc_inline_ecc_scrub_end(0x0,0x1fffffff);
+}
+
+static void dh_imx8mp_dhcom_dram_scrub_32g_x32(void)
+{
+	ddrc_inline_ecc_scrub(0x0,0x7ffffff);
+	ddrc_inline_ecc_scrub(0x8000000,0xfffffff);
+	ddrc_inline_ecc_scrub(0x10000000,0x17ffffff);
+	ddrc_inline_ecc_scrub(0x18000000,0x1fffffff);
+	ddrc_inline_ecc_scrub(0x20000000,0x27ffffff);
+	ddrc_inline_ecc_scrub(0x28000000,0x2fffffff);
+	ddrc_inline_ecc_scrub(0x30000000,0x37ffffff);
+	ddrc_inline_ecc_scrub_end(0x0,0x3fffffff);
+}
+
+typedef void (*scrub_func_t)(void);
+
 static const scrub_func_t dram_scrub_fn[8] = {
 	NULL,					/* 512 MiB */
 	NULL,					/* 1024 MiB */
-- 
2.53.0

