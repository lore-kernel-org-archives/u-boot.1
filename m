Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5D4F417F3
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 15:23:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 820F783FA7;
	Mon,  9 Mar 2026 16:23:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="uxR7kNFI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE70283F1F; Mon,  9 Mar 2026 16:23:08 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5AFE83F82
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 16:23:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 941394E425DF;
 Mon,  9 Mar 2026 15:23:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 6AA495FFB8;
 Mon,  9 Mar 2026 15:23:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id AD4F610369BF6; Mon,  9 Mar 2026 16:23:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1773069781; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=kwbENLHc3TSkZHx/pgTcv8T1PrLqADdY2PEhcV2iLTc=;
 b=uxR7kNFIIBAF0iiikdX6WaCjc2cWT2hswyHCVs8k3b7fcI/JJCmQYAhBzr2h+wCHZ3k13S
 3R7DmCZzrhsg/e7Ng8AResmFU1SNBhuxNETTdAgc7VJ24gsm3zbOD8/EllA/aL0KneG357
 RR1gADJtCqcvLtrkpqQ4zuPDGJFE+mMShvFKrIQ/w7r6lv2ACu6prC5aiGDm0qx4lmNXgv
 i0SsK9CydJO/rzkr0CUXK5aLWyb6fFDjsfAt+MRlTxoyqgDZZKaEoWK0OJLo5sYfzJtVZN
 eJDOmqqiSSSCa5at2+FxOxAsWLTy/1Orhu2yp8BtFjTU7L8yrVFrXHrJ4rMXJg==
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
Subject: [PATCH 3/4] mtd: rawnand: sunxi: introduce variable user data length
Date: Mon,  9 Mar 2026 16:22:50 +0100
Message-ID: <20260309152251.70837-4-richard.genoud@bootlin.com>
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

In Allwinner SoCs, user data can be added in OOB before each ECC data.
For older SoCs like A10, the user data size was the size of a register
(4 bytes) and was mandatory before each ECC step.
So, the A10 OOB Layout is:
[4Bytes USER_DATA_STEP0] [ECC_STEP0 bytes]
[4bytes USER_DATA_STEP1] [ECC_STEP1 bytes]
...
NB: the BBM is stored at the beginning of the USER_DATA_STEP0.

Now, for H6/H616 NAND flash controller, this user data can have a
different size for each step.
And the vendor has chosen a different layout from the one on A10, using
8 bytes for step 0 and nothing for further steps:
[8bytes USER_DATA_STEP0] [ECC_STEP0 bytes] [ECC_STEP1 bytes]...
(Still with BBM stored at the beginning of the USER_DATA_STEP0)

In order to be compatible with this layout, the current one for H6/H616
has to be changed.

Fixes: 7d1de9801151 ("mtd: rawnand: sunxi_spl: add support for H6/H616 nand controller")
Fixes: f163da5e6d26 ("mtd: rawnand: sunxi: add support for H6/H616 nand controller")
Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c     | 139 +++++++++++++++++++-------
 drivers/mtd/nand/raw/sunxi_nand.h     |  37 ++++++-
 drivers/mtd/nand/raw/sunxi_nand_spl.c |  25 +++--
 3 files changed, 154 insertions(+), 47 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 9fc9bc5e0198..942bcb4e5774 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -749,14 +749,16 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 				       u8 *oob, int oob_off,
 				       int *cur_off,
 				       unsigned int *max_bitflips,
-				       bool bbm, int page)
+				       int step, int page)
 {
 	struct nand_chip *nand = mtd_to_nand(mtd);
 	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
+	unsigned int user_data_sz = nfc->caps->user_data_len(step);
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
 	int raw_mode = 0;
 	u32 status;
 	u32 pattern_found;
+	bool bbm = !step;
 	int ret;
 	/* From the controller point of view, we are at step 0 */
 	const int nfc_step = 0;
@@ -773,8 +775,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 	if (ret)
 		return ret;
 
-	sunxi_nfc_reset_user_data_len(nfc);
-	sunxi_nfc_set_user_data_len(nfc, USER_DATA_SZ, nfc_step);
+	sunxi_nfc_set_user_data_len(nfc, user_data_sz, nfc_step);
 
 	sunxi_nfc_randomizer_enable(mtd);
 	writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | NFC_ECC_OP,
@@ -785,7 +786,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 	if (ret)
 		return ret;
 
-	*cur_off = oob_off + ecc->bytes + USER_DATA_SZ;
+	*cur_off = oob_off + ecc->bytes + user_data_sz;
 
 	pattern_found = readl(nfc->regs + nfc->caps->reg_pat_found);
 	pattern_found = field_get(NFC_ECC_PAT_FOUND_MSK(nfc), pattern_found);
@@ -796,7 +797,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 			pattern = 0x0;
 
 		memset(data, pattern, ecc->size);
-		memset(oob, pattern, ecc->bytes + USER_DATA_SZ);
+		memset(oob, pattern, ecc->bytes + user_data_sz);
 
 		return 1;
 	}
@@ -806,7 +807,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 	memcpy_fromio(data, nfc->regs + NFC_RAM0_BASE, ecc->size);
 
 	nand->cmdfunc(mtd, NAND_CMD_RNDOUT, oob_off, -1);
-	sunxi_nfc_randomizer_read_buf(mtd, oob, ecc->bytes + USER_DATA_SZ, true, page);
+	sunxi_nfc_randomizer_read_buf(mtd, oob, ecc->bytes + user_data_sz, true, page);
 
 	status = readl(nfc->regs + NFC_REG_ECC_ST);
 	if (status & NFC_ECC_ERR(nfc_step)) {
@@ -818,17 +819,17 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 			nand->cmdfunc(mtd, NAND_CMD_RNDOUT, data_off, -1);
 			nand->read_buf(mtd, data, ecc->size);
 			nand->cmdfunc(mtd, NAND_CMD_RNDOUT, oob_off, -1);
-			nand->read_buf(mtd, oob, ecc->bytes + USER_DATA_SZ);
+			nand->read_buf(mtd, oob, ecc->bytes + user_data_sz);
 		}
 
 		ret = nand_check_erased_ecc_chunk(data,	ecc->size,
-						  oob, ecc->bytes + USER_DATA_SZ,
+						  oob, ecc->bytes + user_data_sz,
 						  NULL, 0, ecc->strength);
 		if (ret >= 0)
 			raw_mode = 1;
 	} else {
 		/*
-		 * The engine protects USER_DATA_SZ bytes of OOB data per chunk.
+		 * The engine protects user_data_sz bytes of OOB data per chunk.
 		 * Retrieve the corrected OOB bytes.
 		 */
 		sunxi_nfc_user_data_to_buf(readl(nfc->regs +
@@ -850,13 +851,30 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 	return raw_mode;
 }
 
+/*
+ * Returns the offset of the OOB for each step.
+ * (it includes the user data before the ECC data.)
+ */
+static int sunxi_get_oob_offset(struct sunxi_nfc *nfc,
+				struct nand_ecc_ctrl *ecc, int step)
+{
+	int ecc_off = step * ecc->bytes;
+	int i;
+
+	for (i = 0; i < step; i++)
+		ecc_off += nfc->caps->user_data_len(i);
+
+	return ecc_off;
+}
+
 static void sunxi_nfc_hw_ecc_read_extra_oob(struct mtd_info *mtd,
 					    u8 *oob, int *cur_off,
 					    bool randomize, int page)
 {
 	struct nand_chip *nand = mtd_to_nand(mtd);
+	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
-	int offset = ((ecc->bytes + USER_DATA_SZ) * ecc->steps);
+	int offset = sunxi_get_oob_offset(nfc, ecc, ecc->steps);
 	int len = mtd->oobsize - offset;
 
 	if (len <= 0)
@@ -883,12 +901,14 @@ static inline u32 sunxi_nfc_buf_to_user_data(const u8 *buf)
 static int sunxi_nfc_hw_ecc_write_chunk(struct mtd_info *mtd,
 					const u8 *data, int data_off,
 					const u8 *oob, int oob_off,
-					int *cur_off, bool bbm,
+					int *cur_off, int step,
 					int page)
 {
 	struct nand_chip *nand = mtd_to_nand(mtd);
 	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
+	unsigned int user_data_sz = nfc->caps->user_data_len(step);
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
+	bool bbm = !step;
 	int ret;
 	/* From the controller point of view, we are at step 0 */
 	const int nfc_step = 0;
@@ -900,12 +920,17 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct mtd_info *mtd,
 
 	/* Fill OOB data in */
 	if ((nand->options & NAND_NEED_SCRAMBLING) && bbm) {
-		u8 user_data[USER_DATA_SZ];
+		u8 *user_data;
 
-		memcpy(user_data, oob, USER_DATA_SZ);
+		user_data = kzalloc(user_data_sz, GFP_KERNEL);
+		if (!user_data)
+			return -ENOMEM;
+
+		memcpy(user_data, oob, user_data_sz);
 		sunxi_nfc_randomize_bbm(mtd, page, user_data);
 		writel(sunxi_nfc_buf_to_user_data(user_data),
 		       nfc->regs + NFC_REG_USER_DATA(nfc, nfc_step));
+		kfree(user_data);
 	} else {
 		writel(sunxi_nfc_buf_to_user_data(oob),
 		       nfc->regs + NFC_REG_USER_DATA(nfc, nfc_step));
@@ -918,8 +943,7 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct mtd_info *mtd,
 	if (ret)
 		return ret;
 
-	sunxi_nfc_reset_user_data_len(nfc);
-	sunxi_nfc_set_user_data_len(nfc, USER_DATA_SZ, nfc_step);
+	sunxi_nfc_set_user_data_len(nfc, user_data_sz, nfc_step);
 
 	sunxi_nfc_randomizer_enable(mtd);
 	writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD |
@@ -931,7 +955,7 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct mtd_info *mtd,
 	if (ret)
 		return ret;
 
-	*cur_off = oob_off + ecc->bytes + USER_DATA_SZ;
+	*cur_off = oob_off + ecc->bytes + user_data_sz;
 
 	return 0;
 }
@@ -942,7 +966,8 @@ static void sunxi_nfc_hw_ecc_write_extra_oob(struct mtd_info *mtd,
 {
 	struct nand_chip *nand = mtd_to_nand(mtd);
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
-	int offset = ((ecc->bytes + USER_DATA_SZ) * ecc->steps);
+	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
+	int offset = sunxi_get_oob_offset(nfc, ecc, ecc->steps);
 	int len = mtd->oobsize - offset;
 
 	if (len <= 0)
@@ -961,6 +986,8 @@ static int sunxi_nfc_hw_ecc_read_page(struct mtd_info *mtd,
 				      struct nand_chip *chip, uint8_t *buf,
 				      int oob_required, int page)
 {
+	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(chip);
+	struct sunxi_nfc *nfc = to_sunxi_nfc(sunxi_nand->nand.controller);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	unsigned int max_bitflips = 0;
 	int ret, i, cur_off = 0;
@@ -968,16 +995,17 @@ static int sunxi_nfc_hw_ecc_read_page(struct mtd_info *mtd,
 
 	sunxi_nfc_hw_ecc_enable(mtd);
 
+	sunxi_nfc_reset_user_data_len(nfc);
 	for (i = 0; i < ecc->steps; i++) {
 		int data_off = i * ecc->size;
-		int oob_off = i * (ecc->bytes + USER_DATA_SZ);
+		int oob_off = sunxi_get_oob_offset(nfc, ecc, i);
 		u8 *data = buf + data_off;
 		u8 *oob = chip->oob_poi + oob_off;
 
 		ret = sunxi_nfc_hw_ecc_read_chunk(mtd, data, data_off, oob,
 						  oob_off + mtd->writesize,
 						  &cur_off, &max_bitflips,
-						  !i, page);
+						  i, page);
 		if (ret < 0)
 			return ret;
 		else if (ret)
@@ -998,23 +1026,26 @@ static int sunxi_nfc_hw_ecc_read_subpage(struct mtd_info *mtd,
 					 uint32_t data_offs, uint32_t readlen,
 					 uint8_t *bufpoi, int page)
 {
+	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(chip);
+	struct sunxi_nfc *nfc = to_sunxi_nfc(sunxi_nand->nand.controller);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	int ret, i, cur_off = 0;
 	unsigned int max_bitflips = 0;
 
 	sunxi_nfc_hw_ecc_enable(mtd);
 
+	sunxi_nfc_reset_user_data_len(nfc);
 	chip->cmdfunc(mtd, NAND_CMD_READ0, 0, page);
 	for (i = data_offs / ecc->size;
 	     i < DIV_ROUND_UP(data_offs + readlen, ecc->size); i++) {
 		int data_off = i * ecc->size;
-		int oob_off = i * (ecc->bytes + USER_DATA_SZ);
+		int oob_off = sunxi_get_oob_offset(nfc, ecc, i);
 		u8 *data = bufpoi + data_off;
 		u8 *oob = chip->oob_poi + oob_off;
 
 		ret = sunxi_nfc_hw_ecc_read_chunk(mtd, data, data_off,
 			oob, oob_off + mtd->writesize,
-			&cur_off, &max_bitflips, !i, page);
+			&cur_off, &max_bitflips, i, page);
 		if (ret < 0)
 			return ret;
 	}
@@ -1029,20 +1060,23 @@ static int sunxi_nfc_hw_ecc_write_page(struct mtd_info *mtd,
 				       const uint8_t *buf, int oob_required,
 				       int page)
 {
+	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(chip);
+	struct sunxi_nfc *nfc = to_sunxi_nfc(sunxi_nand->nand.controller);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	int ret, i, cur_off = 0;
 
 	sunxi_nfc_hw_ecc_enable(mtd);
 
+	sunxi_nfc_reset_user_data_len(nfc);
 	for (i = 0; i < ecc->steps; i++) {
 		int data_off = i * ecc->size;
-		int oob_off = i * (ecc->bytes + USER_DATA_SZ);
+		int oob_off = sunxi_get_oob_offset(nfc, ecc, i);
 		const u8 *data = buf + data_off;
 		const u8 *oob = chip->oob_poi + oob_off;
 
 		ret = sunxi_nfc_hw_ecc_write_chunk(mtd, data, data_off, oob,
 						   oob_off + mtd->writesize,
-						   &cur_off, !i, page);
+						   &cur_off, i, page);
 		if (ret)
 			return ret;
 	}
@@ -1062,21 +1096,24 @@ static int sunxi_nfc_hw_ecc_write_subpage(struct mtd_info *mtd,
 					  const u8 *buf, int oob_required,
 					  int page)
 {
+	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(chip);
+	struct sunxi_nfc *nfc = to_sunxi_nfc(sunxi_nand->nand.controller);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	int ret, i, cur_off = 0;
 
 	sunxi_nfc_hw_ecc_enable(mtd);
 
+	sunxi_nfc_reset_user_data_len(nfc);
 	for (i = data_offs / ecc->size;
 	     i < DIV_ROUND_UP(data_offs + data_len, ecc->size); i++) {
 		int data_off = i * ecc->size;
-		int oob_off = i * (ecc->bytes + USER_DATA_SZ);
+		int oob_off = sunxi_get_oob_offset(nfc, ecc, i);
 		const u8 *data = buf + data_off;
 		const u8 *oob = chip->oob_poi + oob_off;
 
 		ret = sunxi_nfc_hw_ecc_write_chunk(mtd, data, data_off, oob,
 						   oob_off + mtd->writesize,
-						   &cur_off, !i, page);
+						   &cur_off, i, page);
 		if (ret)
 			return ret;
 	}
@@ -1091,18 +1128,23 @@ static int sunxi_nfc_hw_syndrome_ecc_read_page(struct mtd_info *mtd,
 					       uint8_t *buf, int oob_required,
 					       int page)
 {
+	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(chip);
+	struct sunxi_nfc *nfc = to_sunxi_nfc(sunxi_nand->nand.controller);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	unsigned int max_bitflips = 0;
 	int ret, i, cur_off = 0;
 	bool raw_mode = false;
+	/* With hw_syndrome, user data length is fixed */
+	unsigned int user_data_sz = nfc->caps->user_data_len(0);
 
 	sunxi_nfc_hw_ecc_enable(mtd);
 
+	sunxi_nfc_reset_user_data_len(nfc);
 	for (i = 0; i < ecc->steps; i++) {
-		int data_off = i * (ecc->size + ecc->bytes + USER_DATA_SZ);
+		int data_off = i * (ecc->size + ecc->bytes + user_data_sz);
 		int oob_off = data_off + ecc->size;
 		u8 *data = buf + (i * ecc->size);
-		u8 *oob = chip->oob_poi + (i * (ecc->bytes + USER_DATA_SZ));
+		u8 *oob = chip->oob_poi + (i * (ecc->bytes + user_data_sz));
 
 		ret = sunxi_nfc_hw_ecc_read_chunk(mtd, data, data_off, oob,
 						  oob_off, &cur_off,
@@ -1127,16 +1169,20 @@ static int sunxi_nfc_hw_syndrome_ecc_write_page(struct mtd_info *mtd,
 						const uint8_t *buf,
 						int oob_required, int page)
 {
+	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(chip);
+	struct sunxi_nfc *nfc = to_sunxi_nfc(sunxi_nand->nand.controller);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	int ret, i, cur_off = 0;
+	/* With hw_syndrome, user data length is fixed */
+	unsigned int user_data_sz = nfc->caps->user_data_len(0);
 
 	sunxi_nfc_hw_ecc_enable(mtd);
 
 	for (i = 0; i < ecc->steps; i++) {
-		int data_off = i * (ecc->size + ecc->bytes + USER_DATA_SZ);
+		int data_off = i * (ecc->size + ecc->bytes + user_data_sz);
 		int oob_off = data_off + ecc->size;
 		const u8 *data = buf + (i * ecc->size);
-		const u8 *oob = chip->oob_poi + (i * (ecc->bytes + USER_DATA_SZ));
+		const u8 *oob = chip->oob_poi + (i * (ecc->bytes + user_data_sz));
 
 		ret = sunxi_nfc_hw_ecc_write_chunk(mtd, data, data_off,
 						   oob, oob_off, &cur_off,
@@ -1346,6 +1392,7 @@ static int sunxi_nand_hw_common_ecc_ctrl_init(struct mtd_info *mtd,
 	struct sunxi_nfc *nfc = to_sunxi_nfc(sunxi_nand->nand.controller);
 	struct sunxi_nand_hw_ecc *data;
 	struct nand_ecclayout *layout;
+	unsigned int total_user_data_sz = 0;
 	int nsectors;
 	int ret;
 	int i;
@@ -1394,7 +1441,10 @@ static int sunxi_nand_hw_common_ecc_ctrl_init(struct mtd_info *mtd,
 	layout = &data->layout;
 	nsectors = mtd->writesize / ecc->size;
 
-	if (mtd->oobsize < ((ecc->bytes + USER_DATA_SZ) * nsectors)) {
+	for (i = 0; i < nsectors; i++)
+		total_user_data_sz += nfc->caps->user_data_len(i);
+
+	if (mtd->oobsize < ecc->bytes * nsectors + total_user_data_sz) {
 		ret = -EINVAL;
 		goto err;
 	}
@@ -1422,7 +1472,11 @@ static void sunxi_nand_hw_common_ecc_ctrl_cleanup(struct nand_ecc_ctrl *ecc)
 static int sunxi_nand_hw_ecc_ctrl_init(struct mtd_info *mtd,
 				       struct nand_ecc_ctrl *ecc)
 {
+	struct nand_chip *nand = mtd_to_nand(mtd);
+	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
+	struct sunxi_nfc *nfc = to_sunxi_nfc(sunxi_nand->nand.controller);
 	struct nand_ecclayout *layout;
+	unsigned int total_user_data_sz = 0;
 	int nsectors;
 	int i, j;
 	int ret;
@@ -1444,14 +1498,14 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct mtd_info *mtd,
 				layout->oobfree[i - 1].offset +
 				layout->oobfree[i - 1].length +
 				ecc->bytes;
-			layout->oobfree[i].length = USER_DATA_SZ;
+			layout->oobfree[i].length = nfc->caps->user_data_len(i);
 		} else {
 			/*
 			 * The first 2 bytes are used for BB markers, hence we
-			 * only have USER_DATA_SZ - 2 bytes available in the
+			 * only have user_data_len(0) - 2 bytes available in the
 			 * first user data section.
 			 */
-			layout->oobfree[i].length = USER_DATA_SZ - 2;
+			layout->oobfree[i].length = nfc->caps->user_data_len(i) - 2;
 			layout->oobfree[i].offset = 2;
 		}
 
@@ -1461,13 +1515,16 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct mtd_info *mtd,
 					layout->oobfree[i].length + j;
 	}
 
-	if (mtd->oobsize > (ecc->bytes + USER_DATA_SZ) * nsectors) {
+	for (i = 0; i < nsectors; i++)
+		total_user_data_sz += nfc->caps->user_data_len(i);
+
+	if (mtd->oobsize > ecc->bytes * nsectors + total_user_data_sz) {
 		layout->oobfree[nsectors].offset =
 				layout->oobfree[nsectors - 1].offset +
 				layout->oobfree[nsectors - 1].length +
 				ecc->bytes;
 		layout->oobfree[nsectors].length = mtd->oobsize -
-				((ecc->bytes + USER_DATA_SZ) * nsectors);
+				(ecc->bytes * nsectors + total_user_data_sz);
 	}
 
 	return 0;
@@ -1476,6 +1533,9 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct mtd_info *mtd,
 static int sunxi_nand_hw_syndrome_ecc_ctrl_init(struct mtd_info *mtd,
 						struct nand_ecc_ctrl *ecc)
 {
+	struct nand_chip *nand = mtd_to_nand(mtd);
+	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
+	struct sunxi_nfc *nfc = to_sunxi_nfc(sunxi_nand->nand.controller);
 	struct nand_ecclayout *layout;
 	int nsectors;
 	int i;
@@ -1485,7 +1545,12 @@ static int sunxi_nand_hw_syndrome_ecc_ctrl_init(struct mtd_info *mtd,
 	if (ret)
 		return ret;
 
-	ecc->prepad = USER_DATA_SZ;
+	for (i = 0; i < nsectors; i++)
+		if (nfc->caps->user_data_len(i) != nfc->caps->user_data_len(0)) {
+			dev_err(mtd->dev, "Variable user data length not upported with NAND_ECC_HW_SYNDROME\n");
+			return -EOPNOTSUPP;
+		}
+	ecc->prepad = nfc->caps->user_data_len(0);
 	ecc->read_page = sunxi_nfc_hw_syndrome_ecc_read_page;
 	ecc->write_page = sunxi_nfc_hw_syndrome_ecc_write_page;
 
@@ -1811,6 +1876,7 @@ static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
 	.ecc_mode_mask = GENMASK(15, 12),
 	.random_en_mask = BIT(9),
 	.max_ecc_steps = 16,
+	.user_data_len = &sunxi_user_data_len_a10,
 };
 
 static const struct sunxi_nfc_caps sunxi_nfc_h616_caps = {
@@ -1828,6 +1894,7 @@ static const struct sunxi_nfc_caps sunxi_nfc_h616_caps = {
 	.user_data_len_tab = sunxi_user_data_len_h6,
 	.nuser_data_tab = ARRAY_SIZE(sunxi_user_data_len_h6),
 	.max_ecc_steps = 32,
+	.user_data_len = &sunxi_user_data_len_h616,
 };
 
 static const struct udevice_id sunxi_nand_ids[] = {
diff --git a/drivers/mtd/nand/raw/sunxi_nand.h b/drivers/mtd/nand/raw/sunxi_nand.h
index d7a8b3dd40c3..93a198784a5a 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.h
+++ b/drivers/mtd/nand/raw/sunxi_nand.h
@@ -181,9 +181,6 @@
 
 #define NFC_MAX_CS		7
 
-/* On A10, the user data length register is 4 bytes */
-#define USER_DATA_SZ 4
-
 /*
  * NAND Controller capabilities structure: stores NAND controller capabilities
  * for distinction between compatible strings.
@@ -208,6 +205,7 @@
  * @nuser_data_tab:	Size of @user_data_len_tab
  * @max_ecc_steps:	Maximum supported steps for ECC, this is also the
  *			number of user data registers
+ * @user_data_len	Function returning the user data length for a step
  */
 struct sunxi_nfc_caps {
 	bool has_ecc_block_512;
@@ -226,6 +224,39 @@ struct sunxi_nfc_caps {
 	const u8 *user_data_len_tab;
 	unsigned int nuser_data_tab;
 	unsigned int max_ecc_steps;
+	unsigned int (*user_data_len)(int step);
 };
 
+static inline unsigned int sunxi_user_data_len_h616(int step)
+{
+	/*
+	 * On H6/H616, the user data size became configurable,
+	 * from 0 bytes to 32, via the USER_DATA_LEN registers.
+	 *
+	 * In H616 vendor image, the user data length is 8 byte on step 0
+	 * (that includes the BBM) and 0 bytes for the rest.
+	 * So the OOB layout is:
+	 * [BBM] [BBM] [6bytes USER_DATA_STEP0] [ECC_STEP0 bytes] [ECC_STEP1 bytes]...
+	 */
+	if (step == 0)
+		return 8;
+	return 0;
+}
+
+static inline unsigned int sunxi_user_data_len_a10(int step)
+{
+	/*
+	 * On A10/A23, this is the size of the NDFC User Data Register,
+	 * containing the mandatory user data bytes preceding the ECC for each
+	 * ECC step (and including the BBM)
+	 * Thus, for each ECC step, we need USER_DATA_SZ + ECC bytes.
+	 *
+	 * So the layout is:
+	 * [BBM] [BBM] [2Bytes USER_DATA_STEP0] [ECC_STEP0 bytes]
+	 * [4bytes USER_DATA_STEP1] [ECC_step1 bytes]...
+	 */
+
+	return 4;
+}
+
 #endif
diff --git a/drivers/mtd/nand/raw/sunxi_nand_spl.c b/drivers/mtd/nand/raw/sunxi_nand_spl.c
index 0d1f060cc425..7dd7a7b44427 100644
--- a/drivers/mtd/nand/raw/sunxi_nand_spl.c
+++ b/drivers/mtd/nand/raw/sunxi_nand_spl.c
@@ -64,6 +64,7 @@ __maybe_unused static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
 	.ecc_mode_mask = GENMASK(15, 12),
 	.ecc_err_mask = GENMASK(15, 0),
 	.random_en_mask = BIT(9),
+	.user_data_len = &sunxi_user_data_len_a10,
 };
 
 __maybe_unused static const struct sunxi_nfc_caps sunxi_nfc_h616_caps = {
@@ -76,6 +77,7 @@ __maybe_unused static const struct sunxi_nfc_caps sunxi_nfc_h616_caps = {
 	.user_data_len_tab = sunxi_user_data_len_h6,
 	.nuser_data_tab = ARRAY_SIZE(sunxi_user_data_len_h6),
 	.random_en_mask = BIT(5),
+	.user_data_len = &sunxi_user_data_len_h616,
 };
 
 #define DEFAULT_TIMEOUT_US	100000
@@ -271,16 +273,17 @@ static void sunxi_nfc_set_user_data_len(const struct nfc_config *nfc,
 
 /*
  * Values in this table are obtained by doing:
- * DIV_ROUND_UP(info->ecc_strength * 14, 8) + USER_DATA_SZ
- * So it's the number of bytes needed for ECC + user data for one step.
+ * DIV_ROUND_UP(info->ecc_strength * 14, 8)
+ * So it's the number of bytes needed for ECC one step
+ * (not counting the user data length)
  */
 #if defined(CONFIG_MACH_SUN50I_H616) || defined(CONFIG_MACH_SUN50I_H6)
 static const int ecc_bytes[] = {
-	32, 46, 54, 60, 74, 82, 88, 96, 102, 110, 116, 124, 130, 138, 144
+	28, 42, 50, 56, 70, 78, 84, 92, 98, 106, 112, 120, 126, 134, 140
 };
 #else
 static const int ecc_bytes[] = {
-	32, 46, 54, 60, 74, 88, 102, 110, 116
+	28, 42, 50, 56, 70, 84, 98, 106, 112
 };
 #endif
 
@@ -300,6 +303,7 @@ static int nand_read_page(const struct nfc_config *conf, u32 offs,
 	u16 rand_seed = 0;
 	int oob_chunk_sz = ecc_bytes[conf->ecc_strength];
 	int page = offs / conf->page_size;
+	int oob_off = conf->page_size;
 	u32 ecc_st, pattern_found;
 	int i;
 	/* From the controller point of view, we are at step 0 */
@@ -316,9 +320,9 @@ static int nand_read_page(const struct nfc_config *conf, u32 offs,
 	/* Retrieve data from SRAM (PIO) */
 	for (i = 0; i < nsectors; i++) {
 		int data_off = i * conf->ecc_size;
-		int oob_off = conf->page_size + (i * oob_chunk_sz);
 		u8 *data = dest + data_off;
 		u32 ecc512_bit = 0;
+		unsigned int user_data_sz = conf->caps->user_data_len(i);
 
 		if (conf->caps->has_ecc_block_512 && conf->ecc_size == 512)
 			ecc512_bit = NFC_ECC_BLOCK_512;
@@ -345,7 +349,7 @@ static int nand_read_page(const struct nfc_config *conf, u32 offs,
 		nand_change_column(oob_off);
 
 		sunxi_nfc_reset_user_data_len(conf);
-		sunxi_nfc_set_user_data_len(conf, USER_DATA_SZ, nfc_step);
+		sunxi_nfc_set_user_data_len(conf, user_data_sz, nfc_step);
 
 		nand_exec_cmd(NFC_DATA_TRANS | NFC_ECC_OP);
 		/* Get the ECC status */
@@ -371,13 +375,14 @@ static int nand_read_page(const struct nfc_config *conf, u32 offs,
 		nand_readlcpy((u32 *)data,
 			      (void *)(uintptr_t)SUNXI_NFC_BASE + NFC_RAM0_BASE,
 			      conf->ecc_size);
-
 		/* Stop the ECC engine */
 		writel_nfc(readl_nfc(NFC_REG_ECC_CTL) & ~NFC_ECC_EN,
 			   NFC_REG_ECC_CTL);
 
 		if (data_off + conf->ecc_size >= len)
 			break;
+
+		oob_off += oob_chunk_sz + user_data_sz;
 	}
 
 	return 0;
@@ -387,6 +392,7 @@ static int nand_max_ecc_strength(struct nfc_config *conf)
 {
 	int max_oobsize, max_ecc_bytes;
 	int nsectors = conf->page_size / conf->ecc_size;
+	unsigned int total_user_data_sz = 0;
 	int i;
 
 	/*
@@ -412,8 +418,11 @@ static int nand_max_ecc_strength(struct nfc_config *conf)
 
 	max_ecc_bytes = max_oobsize / nsectors;
 
+	for (i = 0; i < nsectors; i++)
+		total_user_data_sz += conf->caps->user_data_len(i);
+
 	for (i = 0; i < ARRAY_SIZE(ecc_bytes); i++) {
-		if (ecc_bytes[i] > max_ecc_bytes)
+		if (ecc_bytes[i] + total_user_data_sz > max_ecc_bytes)
 			break;
 	}
 
