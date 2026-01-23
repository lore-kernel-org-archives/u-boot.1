Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6595CD7237B
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 11:47:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CC7E83C02;
	Fri, 23 Jan 2026 12:46:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="CYxwQ4h1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7470783BF4; Fri, 23 Jan 2026 12:46:09 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94BC883B97
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 12:46:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 864A9C21ABF;
 Fri, 23 Jan 2026 11:46:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 4C82B6070A;
 Fri, 23 Jan 2026 11:46:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A609E119A87BF; Fri, 23 Jan 2026 12:46:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1769168764; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=heWJ4evxathZbpQ14QtK75rxQ95sRqMPhUcLVgMxAbE=;
 b=CYxwQ4h1Tb6Xbib+8f/jypDSvDxQpPn0AVhvT1kCqtXjGyEzqvjyEUR5ETECyCJHJfRSmL
 aTfhE4sQzR4uMdT3lBKKgu3k2cBXdZ8Dq70Ycdkzw9IDCrs57Ey4wblfXOZoTGBe7doxFe
 vJEdRL3j4CB80MoiCAKHiqxm3O8U/cSA+dbBqw4frsEmds8RhQCI9A2zwoSkNXf1RBDHwv
 F3lf/Nw1mqFq2BBXv7+pvtys4r7zFN6RBfz/Fe19gAadHeN+j2/ttR85vXVmOGiOpyjD/T
 /FobtY4eWYqwAG9R3nREKnB2M/H+WobXGnoNcFAFRxdIh6SHMyLk4QZiBArfqg==
From: Richard Genoud <richard.genoud@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Hans de Goede <hdegoede@redhat.com>, Lukasz Majewski <lukma@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Andrey Skvortsov <andrej.skvortzov@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Boris Brezillon <bbrezillon@kernel.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>, u-boot@lists.denx.de,
 Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH v3 10/26] mtd: rawnand: sunxi: move ECC_PAT_FOUND register in
 SoC caps
Date: Fri, 23 Jan 2026 12:44:45 +0100
Message-ID: <20260123114507.1400918-11-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123114507.1400918-1-richard.genoud@bootlin.com>
References: <20260123114507.1400918-1-richard.genoud@bootlin.com>
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

Move ECC_PAT_FOUND register in SoC capabilities structure

This register offset moved in H616, it's now its own register (@0x3c,
bits 0-31), not shared with NFC_ECC_ST any more (was @0x38 bits 16-31).
Push that specificity in caps structure.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c |  9 +++++++--
 drivers/mtd/nand/raw/sunxi_nand.h | 16 +++++++++++++++-
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 942789569e18..07026ced0af6 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -698,6 +698,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
 	int raw_mode = 0;
 	u32 status;
+	u32 pattern_found;
 	int ret;
 
 	if (*cur_off != data_off)
@@ -723,8 +724,9 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 
 	*cur_off = oob_off + ecc->bytes + 4;
 
-	status = readl(nfc->regs + NFC_REG_ECC_ST);
-	if (status & NFC_ECC_PAT_FOUND(0)) {
+	pattern_found = readl(nfc->regs + nfc->caps->reg_pat_found);
+	pattern_found = field_get(NFC_ECC_PAT_FOUND_MSK(nfc), pattern_found);
+	if (pattern_found & NFC_ECC_PAT_FOUND(0)) {
 		u8 pattern = 0xff;
 
 		if (unlikely(!(readl(nfc->regs + NFC_REG_PAT_ID) & 0x1)))
@@ -743,6 +745,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 	nand->cmdfunc(mtd, NAND_CMD_RNDOUT, oob_off, -1);
 	sunxi_nfc_randomizer_read_buf(mtd, oob, ecc->bytes + 4, true, page);
 
+	status = readl(nfc->regs + NFC_REG_ECC_ST);
 	if (status & NFC_ECC_ERR(0)) {
 		/*
 		 * Re-read the data with the randomizer disabled to identify
@@ -1714,6 +1717,8 @@ static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
 	.nstrengths = 9,
 	.reg_ecc_err_cnt = NFC_REG_A10_ECC_ERR_CNT,
 	.reg_user_data = NFC_REG_A10_USER_DATA,
+	.reg_pat_found = NFC_REG_ECC_ST,
+	.pat_found_mask = GENMASK(31, 16),
 };
 
 static const struct udevice_id sunxi_nand_ids[] = {
diff --git a/drivers/mtd/nand/raw/sunxi_nand.h b/drivers/mtd/nand/raw/sunxi_nand.h
index 1977d1bd8eaf..35079d37bb1f 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.h
+++ b/drivers/mtd/nand/raw/sunxi_nand.h
@@ -25,6 +25,9 @@
 
 #include <linux/bitops.h>
 
+/* non compile-time field get */
+#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
+
 #define NFC_REG_CTL		0x0000
 #define NFC_REG_ST		0x0004
 #define NFC_REG_INT		0x0008
@@ -146,7 +149,14 @@
 
 /* define bit use in NFC_ECC_ST */
 #define NFC_ECC_ERR(x)		BIT(x)
-#define NFC_ECC_PAT_FOUND(x)	BIT((x) + 16)
+
+/*
+ * define bit use in NFC_REG_PAT_FOUND
+ * For A10/A23, NFC_REG_PAT_FOUND == NFC_ECC_ST register
+ */
+#define NFC_ECC_PAT_FOUND(x)	BIT(x)
+#define NFC_ECC_PAT_FOUND_MSK(nfc) ((nfc)->caps->pat_found_mask)
+
 #define NFC_ECC_ERR_CNT(b, x)	(((x) >> ((b) * 8)) & 0xff)
 
 #define NFC_DEFAULT_TIMEOUT_MS	1000
@@ -162,11 +172,15 @@
  * @nstrengths:		Number of element of ECC strengths array
  * @reg_ecc_err_cnt:	ECC error counter register
  * @reg_user_data:	User data register
+ * @reg_pat_found:	Data Pattern Status Register
+ * @pat_found_mask:	ECC_PAT_FOUND mask in NFC_REG_PAT_FOUND register
  */
 struct sunxi_nfc_caps {
 	unsigned int nstrengths;
 	unsigned int reg_ecc_err_cnt;
 	unsigned int reg_user_data;
+	unsigned int reg_pat_found;
+	unsigned int pat_found_mask;
 };
 
 #endif
-- 
2.47.3

