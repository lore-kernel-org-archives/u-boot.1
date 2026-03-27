Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B0EB10ED67C
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 14:06:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D0C483FEE;
	Fri, 27 Mar 2026 15:05:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="T33agafP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F2EF83FE9; Fri, 27 Mar 2026 15:05:41 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 970878394E
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 15:05:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 467131A3024;
 Fri, 27 Mar 2026 14:05:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 17A9660230;
 Fri, 27 Mar 2026 14:05:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5E95E10451311; Fri, 27 Mar 2026 15:05:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774620337; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=e6arHqfx3UpIt9MS80W5Xz5KcPyt1hSDoSrI2pam0YQ=;
 b=T33agafPqEZjQXBxm0Gloj0StEzaMcohFz/DQLa9FeJJmfi36GZWYofrYPfzoEkgQH1638
 n7EcGFaL6uNeI8yRB1CVYhW4uFqgiW61RrJXXvyGZsN87ZcTzlqNbWNKgyytq5ui5RmvXf
 e6/QooCC5XrJLkUxEeE7oTH9q2GpwQUyJcE08ipU38p60FvJsl91dGj2/oi2ClXIz0lCgD
 kZ0NLypaYwCCNBB9Nqt3i8ahDymE/5/rUOixC6gaZGfI/wjrJtRxhPEuNgiuGO1QZTMqhM
 TkIsjxwBcsnGqsKuRZoELH+dYHZ9gX/ggCTV5lxoWbGmaKMU9jWu65fDaVgfew==
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
Subject: [PATCH v2 4/5] mtd: rawnand: sunxi: introduce variable user data
 length
Date: Fri, 27 Mar 2026 15:05:07 +0100
Message-ID: <20260327140508.3680105-5-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327140508.3680105-1-richard.genoud@bootlin.com>
References: <20260327140508.3680105-1-richard.genoud@bootlin.com>
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
So, we are maximizing the user data length to use as many OOB bytes as
possible.

Fixes: 7d1de9801151 ("mtd: rawnand: sunxi_spl: add support for H6/H616 nand controller")
Fixes: f163da5e6d26 ("mtd: rawnand: sunxi: add support for H6/H616 nand controller")
Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c     | 235 +++++++++++++++++++++-----
 drivers/mtd/nand/raw/sunxi_nand_spl.c | 107 ++++++++++--
 2 files changed, 287 insertions(+), 55 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index ecab9ebc9576..c3bec1fe517e 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -114,6 +114,7 @@ struct sunxi_nand_hw_ecc {
  * @clk_rate:		clk_rate required for this NAND chip
  * @timing_cfg		TIMING_CFG register value for this NAND chip
  * @selected:		current active CS
+ * @user_data_bytes	array of user data lengths for all ECC steps
  * @nsels:		number of CS lines required by the NAND chip
  * @sels:		array of CS lines descriptions
  */
@@ -128,6 +129,7 @@ struct sunxi_nand_chip {
 	u32 addr[2];
 	int cmd_cycles;
 	u8 cmd[2];
+	u8 *user_data_bytes;
 	int nsels;
 	struct sunxi_nand_chip_sel sels[0];
 };
@@ -744,19 +746,73 @@ static void sunxi_nfc_set_user_data_len(struct sunxi_nfc *nfc,
 	writel(val, nfc->regs + NFC_REG_USER_DATA_LEN(nfc, step));
 }
 
+static u8 sunxi_nfc_user_data_sz(const struct sunxi_nand_chip *sunxi_nand, int step)
+{
+	if (!sunxi_nand->user_data_bytes)
+		return USER_DATA_SZ;
+
+	return sunxi_nand->user_data_bytes[step];
+}
+
+static void sunxi_nfc_hw_ecc_get_prot_oob_bytes(struct nand_chip *nand, u8 *oob,
+						int step, bool bbm, int page,
+						unsigned int user_data_sz)
+{
+	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
+	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
+	u32 user_data;
+
+	if (!nfc->caps->reg_user_data_len) {
+		/*
+		 * For A10, the user data for step n is in the nth
+		 * REG_USER_DATA
+		 */
+		user_data = readl(nfc->regs + NFC_REG_USER_DATA(nfc, step));
+		sunxi_nfc_user_data_to_buf(user_data, oob);
+
+	} else {
+		/*
+		 * For H6 NAND controller, the user data for all steps is
+		 * contained in 32 user data registers, but not at a specific
+		 * offset for each step, they are just concatenated.
+		 */
+		unsigned int user_data_off = 0;
+		unsigned int reg_off;
+		u8 *ptr = oob;
+		unsigned int i;
+
+		for (i = 0; i < step; i++)
+			user_data_off += sunxi_nfc_user_data_sz(sunxi_nand, i);
+
+		user_data_off /= 4;
+		for (i = 0; i < user_data_sz / 4; i++, ptr += 4) {
+			reg_off = NFC_REG_USER_DATA(nfc, user_data_off + i);
+			user_data = readl(nfc->regs + reg_off);
+			sunxi_nfc_user_data_to_buf(user_data, ptr);
+		}
+	}
+
+	/* De-randomize the Bad Block Marker. */
+	if (bbm && nand->options & NAND_NEED_SCRAMBLING)
+		sunxi_nfc_randomize_bbm(&nand->mtd, page, oob);
+}
+
 static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 				       u8 *data, int data_off,
 				       u8 *oob, int oob_off,
 				       int *cur_off,
 				       unsigned int *max_bitflips,
-				       bool bbm, int page)
+				       int step, int page)
 {
 	struct nand_chip *nand = mtd_to_nand(mtd);
 	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
+	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
+	unsigned int user_data_sz = sunxi_nfc_user_data_sz(sunxi_nand, step);
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
 	int raw_mode = 0;
 	u32 status;
 	u32 pattern_found;
+	bool bbm = !step;
 	int ret;
 	/* From the controller point of view, we are at step 0 */
 	const int nfc_step = 0;
@@ -773,8 +829,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 	if (ret)
 		return ret;
 
-	sunxi_nfc_reset_user_data_len(nfc);
-	sunxi_nfc_set_user_data_len(nfc, USER_DATA_SZ, nfc_step);
+	sunxi_nfc_set_user_data_len(nfc, user_data_sz, nfc_step);
 
 	sunxi_nfc_randomizer_enable(mtd);
 	writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | NFC_ECC_OP,
@@ -785,7 +840,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 	if (ret)
 		return ret;
 
-	*cur_off = oob_off + ecc->bytes + USER_DATA_SZ;
+	*cur_off = oob_off + ecc->bytes + user_data_sz;
 
 	pattern_found = readl(nfc->regs + nfc->caps->reg_pat_found);
 	pattern_found = field_get(NFC_ECC_PAT_FOUND_MSK(nfc), pattern_found);
@@ -796,7 +851,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 			pattern = 0x0;
 
 		memset(data, pattern, ecc->size);
-		memset(oob, pattern, ecc->bytes + USER_DATA_SZ);
+		memset(oob, pattern, ecc->bytes + user_data_sz);
 
 		return 1;
 	}
@@ -806,7 +861,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 	memcpy_fromio(data, nfc->regs + NFC_RAM0_BASE, ecc->size);
 
 	nand->cmdfunc(mtd, NAND_CMD_RNDOUT, oob_off, -1);
-	sunxi_nfc_randomizer_read_buf(mtd, oob, ecc->bytes + USER_DATA_SZ, true, page);
+	sunxi_nfc_randomizer_read_buf(mtd, oob, ecc->bytes + user_data_sz, true, page);
 
 	status = readl(nfc->regs + NFC_REG_ECC_ST);
 	if (status & NFC_ECC_ERR(nfc_step)) {
@@ -818,26 +873,21 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
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
-		sunxi_nfc_user_data_to_buf(readl(nfc->regs +
-						 NFC_REG_USER_DATA(nfc, nfc_step)),
-					   oob);
-
-		/* De-randomize the Bad Block Marker. */
-		if (bbm && nand->options & NAND_NEED_SCRAMBLING)
-			sunxi_nfc_randomize_bbm(mtd, page, oob);
+		sunxi_nfc_hw_ecc_get_prot_oob_bytes(nand, oob, nfc_step,
+						    bbm, page, user_data_sz);
 	}
 
 	if (ret < 0) {
@@ -850,13 +900,30 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 	return raw_mode;
 }
 
+/*
+ * Returns the offset of the OOB for each step.
+ * (it includes the user data before the ECC data.)
+ */
+static int sunxi_get_oob_offset(struct sunxi_nand_chip *sunxi_nand,
+				struct nand_ecc_ctrl *ecc, int step)
+{
+	int ecc_off = step * ecc->bytes;
+	int i;
+
+	for (i = 0; i < step; i++)
+		ecc_off += sunxi_nfc_user_data_sz(sunxi_nand, i);
+
+	return ecc_off;
+}
+
 static void sunxi_nfc_hw_ecc_read_extra_oob(struct mtd_info *mtd,
 					    u8 *oob, int *cur_off,
 					    bool randomize, int page)
 {
 	struct nand_chip *nand = mtd_to_nand(mtd);
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
-	int offset = ((ecc->bytes + USER_DATA_SZ) * ecc->steps);
+	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
+	int offset = sunxi_get_oob_offset(sunxi_nand, ecc, ecc->steps);
 	int len = mtd->oobsize - offset;
 
 	if (len <= 0)
@@ -883,12 +950,15 @@ static inline u32 sunxi_nfc_buf_to_user_data(const u8 *buf)
 static int sunxi_nfc_hw_ecc_write_chunk(struct mtd_info *mtd,
 					const u8 *data, int data_off,
 					const u8 *oob, int oob_off,
-					int *cur_off, bool bbm,
+					int *cur_off, int step,
 					int page)
 {
 	struct nand_chip *nand = mtd_to_nand(mtd);
 	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
+	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
+	unsigned int user_data_sz = sunxi_nfc_user_data_sz(sunxi_nand, step);
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
+	bool bbm = !step;
 	int ret;
 	/* From the controller point of view, we are at step 0 */
 	const int nfc_step = 0;
@@ -900,12 +970,17 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct mtd_info *mtd,
 
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
@@ -918,8 +993,7 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct mtd_info *mtd,
 	if (ret)
 		return ret;
 
-	sunxi_nfc_reset_user_data_len(nfc);
-	sunxi_nfc_set_user_data_len(nfc, USER_DATA_SZ, nfc_step);
+	sunxi_nfc_set_user_data_len(nfc, user_data_sz, nfc_step);
 
 	sunxi_nfc_randomizer_enable(mtd);
 	writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD |
@@ -931,7 +1005,7 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct mtd_info *mtd,
 	if (ret)
 		return ret;
 
-	*cur_off = oob_off + ecc->bytes + USER_DATA_SZ;
+	*cur_off = oob_off + ecc->bytes + user_data_sz;
 
 	return 0;
 }
@@ -942,7 +1016,8 @@ static void sunxi_nfc_hw_ecc_write_extra_oob(struct mtd_info *mtd,
 {
 	struct nand_chip *nand = mtd_to_nand(mtd);
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
-	int offset = ((ecc->bytes + USER_DATA_SZ) * ecc->steps);
+	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
+	int offset = sunxi_get_oob_offset(sunxi_nand, ecc, ecc->steps);
 	int len = mtd->oobsize - offset;
 
 	if (len <= 0)
@@ -961,6 +1036,8 @@ static int sunxi_nfc_hw_ecc_read_page(struct mtd_info *mtd,
 				      struct nand_chip *chip, uint8_t *buf,
 				      int oob_required, int page)
 {
+	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(chip);
+	struct sunxi_nfc *nfc = to_sunxi_nfc(sunxi_nand->nand.controller);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	unsigned int max_bitflips = 0;
 	int ret, i, cur_off = 0;
@@ -968,16 +1045,17 @@ static int sunxi_nfc_hw_ecc_read_page(struct mtd_info *mtd,
 
 	sunxi_nfc_hw_ecc_enable(mtd);
 
+	sunxi_nfc_reset_user_data_len(nfc);
 	for (i = 0; i < ecc->steps; i++) {
 		int data_off = i * ecc->size;
-		int oob_off = i * (ecc->bytes + USER_DATA_SZ);
+		int oob_off = sunxi_get_oob_offset(sunxi_nand, ecc, i);
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
@@ -998,23 +1076,26 @@ static int sunxi_nfc_hw_ecc_read_subpage(struct mtd_info *mtd,
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
+		int oob_off = sunxi_get_oob_offset(sunxi_nand, ecc, i);
 		u8 *data = bufpoi + data_off;
 		u8 *oob = chip->oob_poi + oob_off;
 
 		ret = sunxi_nfc_hw_ecc_read_chunk(mtd, data, data_off,
 			oob, oob_off + mtd->writesize,
-			&cur_off, &max_bitflips, !i, page);
+			&cur_off, &max_bitflips, i, page);
 		if (ret < 0)
 			return ret;
 	}
@@ -1029,20 +1110,23 @@ static int sunxi_nfc_hw_ecc_write_page(struct mtd_info *mtd,
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
+		int oob_off = sunxi_get_oob_offset(sunxi_nand, ecc, i);
 		const u8 *data = buf + data_off;
 		const u8 *oob = chip->oob_poi + oob_off;
 
 		ret = sunxi_nfc_hw_ecc_write_chunk(mtd, data, data_off, oob,
 						   oob_off + mtd->writesize,
-						   &cur_off, !i, page);
+						   &cur_off, i, page);
 		if (ret)
 			return ret;
 	}
@@ -1062,21 +1146,24 @@ static int sunxi_nfc_hw_ecc_write_subpage(struct mtd_info *mtd,
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
+		int oob_off = sunxi_get_oob_offset(sunxi_nand, ecc, i);
 		const u8 *data = buf + data_off;
 		const u8 *oob = chip->oob_poi + oob_off;
 
 		ret = sunxi_nfc_hw_ecc_write_chunk(mtd, data, data_off, oob,
 						   oob_off + mtd->writesize,
-						   &cur_off, !i, page);
+						   &cur_off, i, page);
 		if (ret)
 			return ret;
 	}
@@ -1091,18 +1178,23 @@ static int sunxi_nfc_hw_syndrome_ecc_read_page(struct mtd_info *mtd,
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
+	unsigned int user_data_sz = sunxi_nfc_user_data_sz(sunxi_nand, 0);
 
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
@@ -1127,16 +1219,19 @@ static int sunxi_nfc_hw_syndrome_ecc_write_page(struct mtd_info *mtd,
 						const uint8_t *buf,
 						int oob_required, int page)
 {
+	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(chip);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	int ret, i, cur_off = 0;
+	/* With hw_syndrome, user data length is fixed */
+	unsigned int user_data_sz = sunxi_nfc_user_data_sz(sunxi_nand, 0);
 
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
@@ -1338,6 +1433,34 @@ static int sunxi_nand_chip_init_timings(struct sunxi_nfc *nfc,
 	return sunxi_nand_chip_set_timings(nfc, chip, timings);
 }
 
+static int sunxi_nfc_maximize_user_data(struct nand_chip *nand, uint32_t oobsize,
+					int ecc_bytes, int nsectors)
+{
+	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
+	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
+	const struct sunxi_nfc_caps *c = nfc->caps;
+	int remaining_bytes = oobsize - (ecc_bytes * nsectors);
+	int i, step;
+
+	sunxi_nand->user_data_bytes = devm_kzalloc(nfc->dev, nsectors,
+						   GFP_KERNEL);
+	if (!sunxi_nand->user_data_bytes)
+		return -ENOMEM;
+
+	for (step = 0; (step < nsectors) && (remaining_bytes > 0); step++) {
+		for (i = 0; i < c->nuser_data_tab; i++) {
+			if (c->user_data_len_tab[i] > remaining_bytes)
+				break;
+			sunxi_nand->user_data_bytes[step] = c->user_data_len_tab[i];
+		}
+		remaining_bytes -= sunxi_nand->user_data_bytes[step];
+		if (sunxi_nand->user_data_bytes[step] == 0)
+			break;
+	}
+
+	return 0;
+}
+
 static int sunxi_nand_hw_common_ecc_ctrl_init(struct mtd_info *mtd,
 					      struct nand_ecc_ctrl *ecc)
 {
@@ -1346,6 +1469,7 @@ static int sunxi_nand_hw_common_ecc_ctrl_init(struct mtd_info *mtd,
 	struct sunxi_nfc *nfc = to_sunxi_nfc(sunxi_nand->nand.controller);
 	struct sunxi_nand_hw_ecc *data;
 	struct nand_ecclayout *layout;
+	unsigned int total_user_data_sz = 0;
 	int nsectors;
 	int ret;
 	int i;
@@ -1394,7 +1518,15 @@ static int sunxi_nand_hw_common_ecc_ctrl_init(struct mtd_info *mtd,
 	layout = &data->layout;
 	nsectors = mtd->writesize / ecc->size;
 
-	if (mtd->oobsize < ((ecc->bytes + USER_DATA_SZ) * nsectors)) {
+	/* Use the remaining OOB space for user data */
+	if (nfc->caps->reg_user_data_len)
+		sunxi_nfc_maximize_user_data(nand, mtd->oobsize, ecc->bytes,
+					     nsectors);
+
+	for (i = 0; i < nsectors; i++)
+		total_user_data_sz += sunxi_nfc_user_data_sz(sunxi_nand, i);
+
+	if (mtd->oobsize < ecc->bytes * nsectors + total_user_data_sz) {
 		ret = -EINVAL;
 		goto err;
 	}
@@ -1408,6 +1540,8 @@ static int sunxi_nand_hw_common_ecc_ctrl_init(struct mtd_info *mtd,
 
 err:
 	kfree(data);
+	devm_kfree(nfc->dev, sunxi_nand->user_data_bytes);
+	sunxi_nand->user_data_bytes = NULL;
 
 	return ret;
 }
@@ -1422,7 +1556,10 @@ static void sunxi_nand_hw_common_ecc_ctrl_cleanup(struct nand_ecc_ctrl *ecc)
 static int sunxi_nand_hw_ecc_ctrl_init(struct mtd_info *mtd,
 				       struct nand_ecc_ctrl *ecc)
 {
+	struct nand_chip *nand = mtd_to_nand(mtd);
+	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
 	struct nand_ecclayout *layout;
+	unsigned int total_user_data_sz = 0;
 	int nsectors;
 	int i, j;
 	int ret;
@@ -1444,14 +1581,14 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct mtd_info *mtd,
 				layout->oobfree[i - 1].offset +
 				layout->oobfree[i - 1].length +
 				ecc->bytes;
-			layout->oobfree[i].length = USER_DATA_SZ;
+			layout->oobfree[i].length = sunxi_nfc_user_data_sz(sunxi_nand, i);
 		} else {
 			/*
 			 * The first 2 bytes are used for BB markers, hence we
-			 * only have USER_DATA_SZ - 2 bytes available in the
+			 * only have user_data_len(0) - 2 bytes available in the
 			 * first user data section.
 			 */
-			layout->oobfree[i].length = USER_DATA_SZ - 2;
+			layout->oobfree[i].length = sunxi_nfc_user_data_sz(sunxi_nand, i) - 2;
 			layout->oobfree[i].offset = 2;
 		}
 
@@ -1461,13 +1598,16 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct mtd_info *mtd,
 					layout->oobfree[i].length + j;
 	}
 
-	if (mtd->oobsize > (ecc->bytes + USER_DATA_SZ) * nsectors) {
+	for (i = 0; i < nsectors; i++)
+		total_user_data_sz += sunxi_nfc_user_data_sz(sunxi_nand, i);
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
@@ -1476,6 +1616,8 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct mtd_info *mtd,
 static int sunxi_nand_hw_syndrome_ecc_ctrl_init(struct mtd_info *mtd,
 						struct nand_ecc_ctrl *ecc)
 {
+	struct nand_chip *nand = mtd_to_nand(mtd);
+	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
 	struct nand_ecclayout *layout;
 	int nsectors;
 	int i;
@@ -1485,7 +1627,13 @@ static int sunxi_nand_hw_syndrome_ecc_ctrl_init(struct mtd_info *mtd,
 	if (ret)
 		return ret;
 
-	ecc->prepad = USER_DATA_SZ;
+	for (i = 0; i < nsectors; i++)
+		if (sunxi_nfc_user_data_sz(sunxi_nand, i) !=
+		    sunxi_nfc_user_data_sz(sunxi_nand, 0)) {
+			dev_err(mtd->dev, "Variable user data length not upported with NAND_ECC_HW_SYNDROME\n");
+			return -EOPNOTSUPP;
+		}
+	ecc->prepad = sunxi_nfc_user_data_sz(sunxi_nand, 0);
 	ecc->read_page = sunxi_nfc_hw_syndrome_ecc_read_page;
 	ecc->write_page = sunxi_nfc_hw_syndrome_ecc_write_page;
 
@@ -1735,6 +1883,7 @@ static void sunxi_nand_chips_cleanup(struct sunxi_nfc *nfc)
 		nand_release(&chip->mtd);
 		sunxi_nand_ecc_cleanup(&chip->nand.ecc);
 		list_del(&chip->node);
+		devm_kfree(nfc->dev, chip->user_data_bytes);
 		kfree(chip);
 	}
 }
diff --git a/drivers/mtd/nand/raw/sunxi_nand_spl.c b/drivers/mtd/nand/raw/sunxi_nand_spl.c
index 0d1f060cc425..784ffb00cf70 100644
--- a/drivers/mtd/nand/raw/sunxi_nand_spl.c
+++ b/drivers/mtd/nand/raw/sunxi_nand_spl.c
@@ -28,6 +28,7 @@ struct nfc_config {
 	bool randomize;
 	bool valid;
 	const struct sunxi_nfc_caps *caps;
+	u8 *user_data_bytes;
 };
 
 /* minimal "boot0" style NAND support for Allwinner A20 */
@@ -271,16 +272,17 @@ static void sunxi_nfc_set_user_data_len(const struct nfc_config *nfc,
 
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
 
@@ -293,6 +295,14 @@ static void nand_readlcpy(u32 *dest, u32 * __iomem src, size_t len)
 		*dest++ = readl(src++);
 }
 
+static u8 nand_user_data_sz(const struct nfc_config *conf, int step)
+{
+	if (!conf->user_data_bytes)
+		return USER_DATA_SZ;
+
+	return conf->user_data_bytes[step];
+}
+
 static int nand_read_page(const struct nfc_config *conf, u32 offs,
 			  void *dest, int len)
 {
@@ -300,6 +310,7 @@ static int nand_read_page(const struct nfc_config *conf, u32 offs,
 	u16 rand_seed = 0;
 	int oob_chunk_sz = ecc_bytes[conf->ecc_strength];
 	int page = offs / conf->page_size;
+	int oob_off = conf->page_size;
 	u32 ecc_st, pattern_found;
 	int i;
 	/* From the controller point of view, we are at step 0 */
@@ -316,9 +327,9 @@ static int nand_read_page(const struct nfc_config *conf, u32 offs,
 	/* Retrieve data from SRAM (PIO) */
 	for (i = 0; i < nsectors; i++) {
 		int data_off = i * conf->ecc_size;
-		int oob_off = conf->page_size + (i * oob_chunk_sz);
 		u8 *data = dest + data_off;
 		u32 ecc512_bit = 0;
+		unsigned int user_data_sz = nand_user_data_sz(conf, i);
 
 		if (conf->caps->has_ecc_block_512 && conf->ecc_size == 512)
 			ecc512_bit = NFC_ECC_BLOCK_512;
@@ -345,7 +356,7 @@ static int nand_read_page(const struct nfc_config *conf, u32 offs,
 		nand_change_column(oob_off);
 
 		sunxi_nfc_reset_user_data_len(conf);
-		sunxi_nfc_set_user_data_len(conf, USER_DATA_SZ, nfc_step);
+		sunxi_nfc_set_user_data_len(conf, user_data_sz, nfc_step);
 
 		nand_exec_cmd(NFC_DATA_TRANS | NFC_ECC_OP);
 		/* Get the ECC status */
@@ -371,13 +382,61 @@ static int nand_read_page(const struct nfc_config *conf, u32 offs,
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
+	}
+
+	return 0;
+}
+
+static int nand_min_user_data_sz(struct nfc_config *conf, int nsectors)
+{
+	const struct sunxi_nfc_caps *c = conf->caps;
+	int min_user_data_sz = 0;
+	int i;
+
+	if (!c->reg_user_data_len) {
+		for (i = 0; i < nsectors; i++)
+			min_user_data_sz += nand_user_data_sz(conf, i);
+	} else {
+		for (i = 0; i < c->nuser_data_tab; i++)
+			/* We want at least enough size for the BBM */
+			if (c->user_data_len_tab[i] >= 2)
+				break;
+		min_user_data_sz = c->user_data_len_tab[i];
+	}
+
+	return min_user_data_sz;
+}
+
+static int nand_maximize_user_data(struct nfc_config *conf, uint32_t oobsize,
+				   int ecc_len, int nsectors)
+{
+	const struct sunxi_nfc_caps *c = conf->caps;
+	int remaining_bytes = oobsize - (ecc_len * nsectors);
+	int i, step;
+
+	kfree(conf->user_data_bytes);
+
+	conf->user_data_bytes = kzalloc(nsectors, GFP_KERNEL);
+	if (!conf->user_data_bytes)
+		return -ENOMEM;
+
+	for (step = 0; (step < nsectors) && (remaining_bytes > 0); step++) {
+		for (i = 0; i < c->nuser_data_tab; i++) {
+			if (c->user_data_len_tab[i] > remaining_bytes)
+				break;
+			conf->user_data_bytes[step] = c->user_data_len_tab[i];
+		}
+		remaining_bytes -= conf->user_data_bytes[step];
+		if (conf->user_data_bytes[step] == 0)
+			break;
 	}
 
 	return 0;
@@ -387,7 +446,8 @@ static int nand_max_ecc_strength(struct nfc_config *conf)
 {
 	int max_oobsize, max_ecc_bytes;
 	int nsectors = conf->page_size / conf->ecc_size;
-	int i;
+	unsigned int total_user_data_sz = 0;
+	int ecc_idx, i;
 
 	/*
 	 * ECC strength is limited by the size of the OOB area which is
@@ -412,15 +472,38 @@ static int nand_max_ecc_strength(struct nfc_config *conf)
 
 	max_ecc_bytes = max_oobsize / nsectors;
 
-	for (i = 0; i < ARRAY_SIZE(ecc_bytes); i++) {
-		if (ecc_bytes[i] > max_ecc_bytes)
+	/*
+	 * nand_min_user_data_sz() will return the total_user_data_sz in case
+	 * of a fixed user data length, or the minimal usable user data size
+	 * in case of variable data length (with at least enough space for the
+	 * BBM.
+	 */
+	total_user_data_sz = nand_min_user_data_sz(conf, nsectors);
+
+	for (ecc_idx = 0; ecc_idx < ARRAY_SIZE(ecc_bytes); ecc_idx++) {
+		if (ecc_bytes[ecc_idx] + total_user_data_sz > max_ecc_bytes)
 			break;
 	}
 
-	if (!i)
+	if (!ecc_idx)
 		return -EINVAL;
 
-	return i - 1;
+	ecc_idx--;
+
+	/*
+	 * The rationale for variable data length is to prioritize maximum ECC
+	 * strength, and then use the remaining space for user data.
+	 */
+	if (conf->caps->reg_user_data_len) {
+		nand_maximize_user_data(conf, max_oobsize,
+					ecc_bytes[ecc_idx], nsectors);
+
+		total_user_data_sz = 0;
+		for (i = 0; i < nsectors; i++)
+			total_user_data_sz += nand_user_data_sz(conf, i);
+	}
+
+	return ecc_idx;
 }
 
 static int nand_detect_ecc_config(struct nfc_config *conf, u32 offs,
