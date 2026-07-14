Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0C2C44507
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 23:20:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD89384A4A;
	Wed, 15 Jul 2026 01:20:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="On1MgMOP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22D2884A4B; Wed, 15 Jul 2026 01:20:19 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C062A8494B
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 01:20:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-43bfe209e45so1215923fac.0
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 16:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784071215; x=1784676015; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iDMETCc40BmGdAHC0GZiTPKkTJRLOqQovI6NRIHKFj8=;
 b=On1MgMOPsurhC4PErzTvxOdRny7WBFRZBpJO4wC04Hb/eJgqHvIIXfALSSmdWYjf+a
 Ij6IHMm9MMMt+vFY91UVFFFA6C1JNC/7SoeCHZkgNB2qbU5HqS9YAqY5sEDib2Cv86jd
 OVZ/zICKQ1zD5Ar9LQhaD3T82/Poi9cJd8Hi/6EUMe3rT2K5readGaWKDJx6CW6CJOG7
 WSebD+9NMA0J67BrqSI28WfJ9tpg8GO0t0po+JfX7rFH79Rgg5liNbv8U8PqYlXmEsID
 4+Jq867rhQlk4Pj0wJ8ECQ+l4bXijfmgaj98tGYqn0EkLoQ93v/9sdAL0f7XrY0cINvf
 4eBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784071215; x=1784676015;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iDMETCc40BmGdAHC0GZiTPKkTJRLOqQovI6NRIHKFj8=;
 b=hBWRx/SIhsY2hvCnLdDegBANW2WAvhc7gzIVa2/aaG+bSBnmkaVk66LIXFC0aqxKXa
 pPafurEkQR9WHGPvq5U1UkfstEZ0Yee5GVJ0E3G/8YM96UL0p/gkYIQIoJJs9lCfWc5L
 vWFpifIwbA1BuYsrJ1/3SDjRGnhfi5d231zDzmZIRGKoEjE7aTnWlIcDC/iJQiudOt5Y
 j/o64Sk5Bip1jL/cW/zlFMkQkzutIqDcR0AEVWuxyVMv0svzUEmuBTZBPHZvpXHYGPsu
 Uqsz9XlSczjxpxQp5GFXsknbNg508srLoTxITWPhE6YKhr/biUL6hHZkaMNyP3mfmhLj
 1eVQ==
X-Gm-Message-State: AOJu0YwRFMCaTY13HQqVWPUDIEv8gu6PHqVKRh4XGE8+Jkb4lyPxbThM
 IYgIXWnLpZ/d/ru92KeJHlL9LmmwANi/mWrnDfcRHVbVUrko0WO5O7IRQ/i9bePvJIY=
X-Gm-Gg: AfdE7ckHhMQGjM0tW7s/n9FulWQdAcU2sJqw4OnhpoFhm9BictAASzaR5SxLznRm/or
 JzqF9Wutq3csMgyIcWlIIZfT5jSVoTsSMxA7pF4WG1kKkY3uoS6jsbktFmHRXSSQUjDVZ/tvVTK
 tOfvuR0hBz3MrFlXBKUT8iNqDjlCJBEXU740hGp2jDmM/Uhm9SrtUwh/CgsJf7yc0hQ/N5nk/Wy
 BD5G8muAwW3qdyC1DluM4AQDyEOxkZP3c6Wz2S4DVxpwi9kmqHuYgCIXCgBwROhfBUAGjgAhckq
 +STe9SPMt9whXKtijwl1iJJBC795hUZy8H/PT0MA30XkgvJo5Msfk0g0Mn6qho4209rq0iGKaO6
 tOsjLQ+vs7yCRAsY4UI0/2IsJmlefYO/Ok+St/g3ZA8bbZEHaIshmiGWdF5NepgY1nZpZwUBhWu
 fPeTwkeBsK1MNUXCYgbkYshAI4gqsH7t8oy4EsIME0P3IvIHCaoy8XGHno9+LpQh78vvjJMpuPt
 GKnxLeO6mVdcMJ8ycEhwHjlspHySLxrtaOTIIG37HRHpGqCL1alF4Xs6Nc8PT9/+noaAQtYTFR6
 WQD8WGuvf7vnu1PsRJfg
X-Received: by 2002:a4a:e84b:0:b0:6a0:b429:443e with SMTP id
 006d021491bc7-6a39a6737edmr9095758eaf.23.1784071215366; 
 Tue, 14 Jul 2026 16:20:15 -0700 (PDT)
Received: from james-x399.tailafd1a.ts.net (174-29-11-8.hlrn.qwest.net.
 [174.29.11.8]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451a7c8fe33sm16595680fac.0.2026.07.14.16.20.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 16:20:14 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Richard Genoud <richard.genoud@bootlin.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH] mtd: rawnand: sunxi: fix H6/H616 controller timings
Date: Tue, 14 Jul 2026 17:19:56 -0600
Message-ID: <20260714232001.491769-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The NAND timing calculation was written for the original A10 NDFC. It
assumes command and address setup and hold intervals T1-T4, T7 and T11
are one controller clock and uses the A10 timing-register encodings.

The H6/H616 NDFC instead defines those intervals as two internal clock
cycles and uses different encodings for tWB, tADL, tWHR and tRHW, as
documented in the H616 User Manual.

Describe the timing characteristics in the controller capability data
so the clock solver can select a rate permitted by the NAND SDR timings
and program valid delay fields. Keep the legacy A10 behavior unchanged.

Fixes: f163da5e6d26 ("mtd: rawnand: sunxi: add support for H6/H616 nand controller")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 97 ++++++++++++++++++++++---------
 drivers/mtd/nand/raw/sunxi_nand.h |  4 ++
 2 files changed, 72 insertions(+), 29 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 49748fddf80..869c305d51d 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1249,16 +1249,41 @@ static int sunxi_nfc_hw_syndrome_ecc_write_page(struct mtd_info *mtd,
 	return 0;
 }
 
-static const s32 tWB_lut[] = {6, 12, 16, 20};
-static const s32 tRHW_lut[] = {4, 8, 12, 20};
+#define SUNXI_NFC_TIMING_STEPS 4
+
+/* Delay arrays contain internal NDFC clock cycles for field values 0 to 3. */
+struct sunxi_nfc_timings {
+	/* Internal clock cycles used by T1-T4, T7 and T11. */
+	u8 setup_cycles;
+	u8 tWB[SUNXI_NFC_TIMING_STEPS];
+	u8 tADL[SUNXI_NFC_TIMING_STEPS];
+	u8 tWHR[SUNXI_NFC_TIMING_STEPS];
+	u8 tRHW[SUNXI_NFC_TIMING_STEPS];
+};
+
+static const struct sunxi_nfc_timings sun4i_a10_nfc_timings = {
+	.setup_cycles = 1,
+	.tWB = { 6, 12, 16, 20 },
+	.tADL = { 7, 15, 23, 31 },
+	.tWHR = { 7, 15, 23, 31 },
+	.tRHW = { 4, 8, 12, 20 },
+};
+
+static const struct sunxi_nfc_timings sun50i_h6_nfc_timings = {
+	.setup_cycles = 2,
+	.tWB = { 28, 44, 60, 76 },
+	.tADL = { 0, 12, 28, 44 },
+	.tWHR = { 0, 12, 28, 44 },
+	.tRHW = { 8, 24, 40, 56 },
+};
 
-static int _sunxi_nand_lookup_timing(const s32 *lut, int lut_size, u32 duration,
-		u32 clk_period)
+static int sunxi_nand_lookup_timing(const u8 *lut, u32 duration,
+				    u32 clk_period)
 {
 	u32 clk_cycles = DIV_ROUND_UP(duration, clk_period);
 	int i;
 
-	for (i = 0; i < lut_size; i++) {
+	for (i = 0; i < SUNXI_NFC_TIMING_STEPS; i++) {
 		if (clk_cycles <= lut[i])
 			return i;
 	}
@@ -1267,31 +1292,37 @@ static int _sunxi_nand_lookup_timing(const s32 *lut, int lut_size, u32 duration,
 	return -EINVAL;
 }
 
-#define sunxi_nand_lookup_timing(l, p, c) \
-			_sunxi_nand_lookup_timing(l, ARRAY_SIZE(l), p, c)
-
 static int sunxi_nand_chip_set_timings(struct sunxi_nfc *nfc,
 				       struct sunxi_nand_chip *chip,
 				       const struct nand_sdr_timings *timings)
 {
+	const struct sunxi_nfc_timings *nfc_timings = nfc->caps->timings;
 	u32 min_clk_period = 0;
 	s32 tWB, tADL, tWHR, tRHW, tCAD;
 
 	/* T1 <=> tCLS */
-	if (timings->tCLS_min > min_clk_period)
-		min_clk_period = timings->tCLS_min;
+	if (timings->tCLS_min >
+	    min_clk_period * nfc_timings->setup_cycles)
+		min_clk_period = DIV_ROUND_UP(timings->tCLS_min,
+					      nfc_timings->setup_cycles);
 
 	/* T2 <=> tCLH */
-	if (timings->tCLH_min > min_clk_period)
-		min_clk_period = timings->tCLH_min;
+	if (timings->tCLH_min >
+	    min_clk_period * nfc_timings->setup_cycles)
+		min_clk_period = DIV_ROUND_UP(timings->tCLH_min,
+					      nfc_timings->setup_cycles);
 
 	/* T3 <=> tCS */
-	if (timings->tCS_min > min_clk_period)
-		min_clk_period = timings->tCS_min;
+	if (timings->tCS_min >
+	    min_clk_period * nfc_timings->setup_cycles)
+		min_clk_period = DIV_ROUND_UP(timings->tCS_min,
+					      nfc_timings->setup_cycles);
 
 	/* T4 <=> tCH */
-	if (timings->tCH_min > min_clk_period)
-		min_clk_period = timings->tCH_min;
+	if (timings->tCH_min >
+	    min_clk_period * nfc_timings->setup_cycles)
+		min_clk_period = DIV_ROUND_UP(timings->tCH_min,
+					      nfc_timings->setup_cycles);
 
 	/* T5 <=> tWP */
 	if (timings->tWP_min > min_clk_period)
@@ -1302,8 +1333,10 @@ static int sunxi_nand_chip_set_timings(struct sunxi_nfc *nfc,
 		min_clk_period = timings->tWH_min;
 
 	/* T7 <=> tALS */
-	if (timings->tALS_min > min_clk_period)
-		min_clk_period = timings->tALS_min;
+	if (timings->tALS_min >
+	    min_clk_period * nfc_timings->setup_cycles)
+		min_clk_period = DIV_ROUND_UP(timings->tALS_min,
+					      nfc_timings->setup_cycles);
 
 	/* T8 <=> tDS */
 	if (timings->tDS_min > min_clk_period)
@@ -1318,8 +1351,10 @@ static int sunxi_nand_chip_set_timings(struct sunxi_nfc *nfc,
 		min_clk_period = DIV_ROUND_UP(timings->tRR_min, 3);
 
 	/* T11 <=> tALH */
-	if (timings->tALH_min > min_clk_period)
-		min_clk_period = timings->tALH_min;
+	if (timings->tALH_min >
+	    min_clk_period * nfc_timings->setup_cycles)
+		min_clk_period = DIV_ROUND_UP(timings->tALH_min,
+					      nfc_timings->setup_cycles);
 
 	/* T12 <=> tRP */
 	if (timings->tRP_min > min_clk_period)
@@ -1338,26 +1373,28 @@ static int sunxi_nand_chip_set_timings(struct sunxi_nfc *nfc,
 		min_clk_period = DIV_ROUND_UP(timings->tWC_min, 2);
 
 	/* T16 - T19 + tCAD */
-	tWB  = sunxi_nand_lookup_timing(tWB_lut, timings->tWB_max,
+	tWB  = sunxi_nand_lookup_timing(nfc_timings->tWB, timings->tWB_max,
 					min_clk_period);
 	if (tWB < 0) {
 		dev_err(nfc->dev, "unsupported tWB\n");
 		return tWB;
 	}
 
-	tADL = DIV_ROUND_UP(timings->tADL_min, min_clk_period) >> 3;
-	if (tADL > 3) {
+	tADL = sunxi_nand_lookup_timing(nfc_timings->tADL,
+					timings->tADL_min, min_clk_period);
+	if (tADL < 0) {
 		dev_err(nfc->dev, "unsupported tADL\n");
-		return -EINVAL;
+		return tADL;
 	}
 
-	tWHR = DIV_ROUND_UP(timings->tWHR_min, min_clk_period) >> 3;
-	if (tWHR > 3) {
+	tWHR = sunxi_nand_lookup_timing(nfc_timings->tWHR,
+					timings->tWHR_min, min_clk_period);
+	if (tWHR < 0) {
 		dev_err(nfc->dev, "unsupported tWHR\n");
-		return -EINVAL;
+		return tWHR;
 	}
 
-	tRHW = sunxi_nand_lookup_timing(tRHW_lut, timings->tRHW_min,
+	tRHW = sunxi_nand_lookup_timing(nfc_timings->tRHW, timings->tRHW_min,
 					min_clk_period);
 	if (tRHW < 0) {
 		dev_err(nfc->dev, "unsupported tRHW\n");
@@ -1370,7 +1407,7 @@ static int sunxi_nand_chip_set_timings(struct sunxi_nfc *nfc,
 	 */
 	tCAD = 0x7;
 
-	/* TODO: A83 has some more bits for CDQSS, CS, CLHZ, CCS, WC */
+	/* TODO: A83 and H6 have more bits for CDQSS, CS, CLHZ, CCS, WC */
 	chip->timing_cfg = NFC_TIMING_CFG(tWB, tADL, tWHR, tRHW, tCAD);
 
 	/*
@@ -1956,6 +1993,7 @@ static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
 	.ecc_mode_mask = GENMASK(15, 12),
 	.random_en_mask = BIT(9),
 	.max_ecc_steps = 16,
+	.timings = &sun4i_a10_nfc_timings,
 };
 
 static const struct sunxi_nfc_caps sunxi_nfc_h616_caps = {
@@ -1973,6 +2011,7 @@ static const struct sunxi_nfc_caps sunxi_nfc_h616_caps = {
 	.user_data_len_tab = sunxi_user_data_len_h6,
 	.nuser_data_tab = ARRAY_SIZE(sunxi_user_data_len_h6),
 	.max_ecc_steps = 32,
+	.timings = &sun50i_h6_nfc_timings,
 };
 
 static const struct udevice_id sunxi_nand_ids[] = {
diff --git a/drivers/mtd/nand/raw/sunxi_nand.h b/drivers/mtd/nand/raw/sunxi_nand.h
index 1b2c514852d..12ce26d2e2a 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.h
+++ b/drivers/mtd/nand/raw/sunxi_nand.h
@@ -181,6 +181,8 @@
 /* On A10, the user data length register is 4 bytes */
 #define USER_DATA_SZ 4
 
+struct sunxi_nfc_timings;
+
 /*
  * NAND Controller capabilities structure: stores NAND controller capabilities
  * for distinction between compatible strings.
@@ -205,6 +207,7 @@
  * @nuser_data_tab:	Size of @user_data_len_tab
  * @max_ecc_steps:	Maximum supported steps for ECC, this is also the
  *			number of user data registers
+ * @timings:		Controller-specific timing characteristics
  */
 struct sunxi_nfc_caps {
 	bool has_ecc_block_512;
@@ -223,6 +226,7 @@ struct sunxi_nfc_caps {
 	const u8 *user_data_len_tab;
 	unsigned int nuser_data_tab;
 	unsigned int max_ecc_steps;
+	const struct sunxi_nfc_timings *timings;
 };
 
 #endif
-- 
2.53.0

