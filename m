Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C042BF41807
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 15:23:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 396AF83F1F;
	Mon,  9 Mar 2026 16:23:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="soDrImuQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6933583BC8; Mon,  9 Mar 2026 16:23:05 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A51883BC8
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 16:23:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 2C9ED4E425DE;
 Mon,  9 Mar 2026 15:23:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0205B5FFB8;
 Mon,  9 Mar 2026 15:23:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5985010369BC4; Mon,  9 Mar 2026 16:22:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1773069780; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=d0HDTQLtWj6oXQIGyZ/8udQ/OdPfsb4WsCXMrBzuxeo=;
 b=soDrImuQcDixY6H+JIGX47c78xkKFA4gBivk5K9D53YxQ4R+NQbz/yao3U6l5vl1TJXFkW
 g/qF+rBv9TUc5211rnopBEpBdY9UGWsIJy3npxiNtTws8/+WJsmhD19baotHps9yBwEue5
 OwhG8hmqsufTegpdLPL21Zt8/WiS1QqQxx3CVdvVrbGzp8QNBPD/rH4lrSY19UcoDYMMpx
 8hC6iojl3UsZLTmf85IWQEa7uMNO+tsxwCnHbOtGE+BFWj2jrDMQJzDOio9ag4JXwxQhEy
 HFY4j0mY3fTvjpXwzCMfx0cb1MpdCvrlmAhetk4o9lOW8t65u5R98TYzmc85dA==
From: Richard Genoud <richard.genoud@bootlin.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Boris Brezillon <bbrezillon@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de,
 Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH 2/4] mtd: rawnand: sunxi: make the code mode self-explanatory
Date: Mon,  9 Mar 2026 16:22:49 +0100
Message-ID: <20260309152251.70837-3-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260309152251.70837-1-richard.genoud@bootlin.com>
References: <20260309152251.70837-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

In sunxi_nfc_hw_ecc_{read,write}_chunk(), the ECC step was force to 0,
the reason is not trivial to get when reading the code.

The explanation is that, from the NAND flash controller perspective, we
are indeed at step 0 for user data length and ECC errors.

Just add a const value with an explanation to clarify things.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c     | 20 ++++++++++++--------
 drivers/mtd/nand/raw/sunxi_nand_spl.c |  6 ++++--
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 91f7da2c5ce5..9fc9bc5e0198 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -758,6 +758,8 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 	u32 status;
 	u32 pattern_found;
 	int ret;
+	/* From the controller point of view, we are at step 0 */
+	const int nfc_step = 0;
 
 	if (*cur_off != data_off)
 		nand->cmdfunc(mtd, NAND_CMD_RNDOUT, data_off, -1);
@@ -772,7 +774,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 		return ret;
 
 	sunxi_nfc_reset_user_data_len(nfc);
-	sunxi_nfc_set_user_data_len(nfc, USER_DATA_SZ, 0);
+	sunxi_nfc_set_user_data_len(nfc, USER_DATA_SZ, nfc_step);
 
 	sunxi_nfc_randomizer_enable(mtd);
 	writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | NFC_ECC_OP,
@@ -787,7 +789,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 
 	pattern_found = readl(nfc->regs + nfc->caps->reg_pat_found);
 	pattern_found = field_get(NFC_ECC_PAT_FOUND_MSK(nfc), pattern_found);
-	if (pattern_found & NFC_ECC_PAT_FOUND(0)) {
+	if (pattern_found & NFC_ECC_PAT_FOUND(nfc_step)) {
 		u8 pattern = 0xff;
 
 		if (unlikely(!(readl(nfc->regs + NFC_REG_PAT_ID(nfc)) & 0x1)))
@@ -799,7 +801,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 		return 1;
 	}
 
-	ret = NFC_ECC_ERR_CNT(0, readl(nfc->regs + NFC_REG_ECC_ERR_CNT(nfc, 0)));
+	ret = NFC_ECC_ERR_CNT(nfc_step, readl(nfc->regs + NFC_REG_ECC_ERR_CNT(nfc, nfc_step)));
 
 	memcpy_fromio(data, nfc->regs + NFC_RAM0_BASE, ecc->size);
 
@@ -807,7 +809,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 	sunxi_nfc_randomizer_read_buf(mtd, oob, ecc->bytes + USER_DATA_SZ, true, page);
 
 	status = readl(nfc->regs + NFC_REG_ECC_ST);
-	if (status & NFC_ECC_ERR(0)) {
+	if (status & NFC_ECC_ERR(nfc_step)) {
 		/*
 		 * Re-read the data with the randomizer disabled to identify
 		 * bitflips in erased pages.
@@ -830,7 +832,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 		 * Retrieve the corrected OOB bytes.
 		 */
 		sunxi_nfc_user_data_to_buf(readl(nfc->regs +
-						 NFC_REG_USER_DATA(nfc, 0)),
+						 NFC_REG_USER_DATA(nfc, nfc_step)),
 					   oob);
 
 		/* De-randomize the Bad Block Marker. */
@@ -888,6 +890,8 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct mtd_info *mtd,
 	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
 	int ret;
+	/* From the controller point of view, we are at step 0 */
+	const int nfc_step = 0;
 
 	if (data_off != *cur_off)
 		nand->cmdfunc(mtd, NAND_CMD_RNDIN, data_off, -1);
@@ -901,10 +905,10 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct mtd_info *mtd,
 		memcpy(user_data, oob, USER_DATA_SZ);
 		sunxi_nfc_randomize_bbm(mtd, page, user_data);
 		writel(sunxi_nfc_buf_to_user_data(user_data),
-		       nfc->regs + NFC_REG_USER_DATA(nfc, 0));
+		       nfc->regs + NFC_REG_USER_DATA(nfc, nfc_step));
 	} else {
 		writel(sunxi_nfc_buf_to_user_data(oob),
-		       nfc->regs + NFC_REG_USER_DATA(nfc, 0));
+		       nfc->regs + NFC_REG_USER_DATA(nfc, nfc_step));
 	}
 
 	if (data_off + ecc->size != oob_off)
@@ -915,7 +919,7 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct mtd_info *mtd,
 		return ret;
 
 	sunxi_nfc_reset_user_data_len(nfc);
-	sunxi_nfc_set_user_data_len(nfc, USER_DATA_SZ, 0);
+	sunxi_nfc_set_user_data_len(nfc, USER_DATA_SZ, nfc_step);
 
 	sunxi_nfc_randomizer_enable(mtd);
 	writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD |
diff --git a/drivers/mtd/nand/raw/sunxi_nand_spl.c b/drivers/mtd/nand/raw/sunxi_nand_spl.c
index 3a5271b49c36..0d1f060cc425 100644
--- a/drivers/mtd/nand/raw/sunxi_nand_spl.c
+++ b/drivers/mtd/nand/raw/sunxi_nand_spl.c
@@ -302,6 +302,8 @@ static int nand_read_page(const struct nfc_config *conf, u32 offs,
 	int page = offs / conf->page_size;
 	u32 ecc_st, pattern_found;
 	int i;
+	/* From the controller point of view, we are at step 0 */
+	const int nfc_step = 0;
 
 	if (offs % conf->page_size || len % conf->ecc_size ||
 	    len > conf->page_size || len < 0)
@@ -343,7 +345,7 @@ static int nand_read_page(const struct nfc_config *conf, u32 offs,
 		nand_change_column(oob_off);
 
 		sunxi_nfc_reset_user_data_len(conf);
-		sunxi_nfc_set_user_data_len(conf, USER_DATA_SZ, 0);
+		sunxi_nfc_set_user_data_len(conf, USER_DATA_SZ, nfc_step);
 
 		nand_exec_cmd(NFC_DATA_TRANS | NFC_ECC_OP);
 		/* Get the ECC status */
@@ -361,7 +363,7 @@ static int nand_read_page(const struct nfc_config *conf, u32 offs,
 			pattern_found = readl_nfc(conf->caps->reg_pat_found);
 			pattern_found = field_get(NFC_ECC_PAT_FOUND_MSK(conf),
 						  pattern_found);
-			if (pattern_found & NFC_ECC_PAT_FOUND(0))
+			if (pattern_found & NFC_ECC_PAT_FOUND(nfc_step))
 				return 1;
 		}
 
