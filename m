Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5A1CCD199
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 14:30:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58C8383890;
	Thu, 16 Oct 2025 16:29:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="IvY719cb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4BDD836F0; Thu, 16 Oct 2025 16:29:16 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD61683885
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 16:29:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 6D6664E41109;
 Thu, 16 Oct 2025 14:29:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 438A56062C;
 Thu, 16 Oct 2025 14:29:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 02F49102F231F; 
 Thu, 16 Oct 2025 16:29:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1760624952; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=i4PCbrK6CIqNB8T1S/DuF5O6U220GrCIb3q0G9KXwXA=;
 b=IvY719cbEh/nlTtyR2KqbJhIpF9Dp/kn1vX3MiXAbi+hIlfxyp+k+3OQT9Hp63aNlmHYrw
 ZB+l4lx1Ve5tnabsJtPj8hjWJhCJdU0Skmdgmh6gyF8dbDvvCIt89sJ+6+pY6VLPNzFSg9
 Te2y6fG4YezkCBYDbavZwmCRsgIB31/2No7B6f+WERoB8g7MyYng1QS9jNZEaMN+/X7p2p
 byb/yO/9SGNOxlFkOO3gO3wz2lWh8zYhPEHx7yy+ENqnPX+Juk0phs4nwB8+f7lfGU/vd4
 KkD74B1kis/2DGX1QeNjowFJ3KlX/pVQr9eRyqpjcZC0u3fRAvPmzV3i2x0OQA==
From: Richard Genoud <richard.genoud@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Hans de Goede <hdegoede@redhat.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Andrey Skvortsov <andrej.skvortzov@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dinesh Maniyam <dinesh.maniyam@intel.com>,
 Anand Gore <anand.gore@broadcom.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 david regan <dregan@broadcom.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de,
 Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH 11/24] mtd: rawnand: sunxi: cosmetic: add has_ecc_block_512
 capability
Date: Thu, 16 Oct 2025 16:27:34 +0200
Message-ID: <20251016142752.2627710-12-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251016142752.2627710-1-richard.genoud@bootlin.com>
References: <20251016142752.2627710-1-richard.genoud@bootlin.com>
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

Introduce has_ecc_block_512 capability

The H616 controller can't handle 512 bytes ECC block size.
Let it be a capability.

No functional change.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 14 +++++++++++---
 drivers/mtd/nand/raw/sunxi_nand.h |  2 ++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 869b3ddd971c..fddb1cada023 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -660,11 +660,12 @@ static void sunxi_nfc_hw_ecc_enable(struct mtd_info *mtd)
 	u32 ecc_ctl;
 
 	ecc_ctl = readl(nfc->regs + NFC_REG_ECC_CTL);
-	ecc_ctl &= ~(NFC_ECC_MODE_MSK | NFC_ECC_PIPELINE |
-		     NFC_ECC_BLOCK_SIZE_MSK);
+	ecc_ctl &= ~(NFC_ECC_MODE_MSK | NFC_ECC_PIPELINE);
+	if (nfc->caps->has_ecc_block_512)
+		ecc_ctl &= ~NFC_ECC_BLOCK_SIZE_MSK;
 	ecc_ctl |= NFC_ECC_EN | NFC_ECC_MODE(data->mode) | NFC_ECC_EXCEPTION;
 
-	if (nand->ecc.size == 512)
+	if (nand->ecc.size == 512 && nfc->caps->has_ecc_block_512)
 		ecc_ctl |= NFC_ECC_BLOCK_512;
 
 	writel(ecc_ctl, nfc->regs + NFC_REG_ECC_CTL);
@@ -1454,6 +1455,8 @@ static void sunxi_nand_ecc_cleanup(struct nand_ecc_ctrl *ecc)
 static int sunxi_nand_ecc_init(struct mtd_info *mtd, struct nand_ecc_ctrl *ecc)
 {
 	struct nand_chip *nand = mtd_to_nand(mtd);
+	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
+	struct sunxi_nfc *nfc = to_sunxi_nfc(sunxi_nand->nand.controller);
 	int ret;
 
 	if (!ecc->size) {
@@ -1464,6 +1467,10 @@ static int sunxi_nand_ecc_init(struct mtd_info *mtd, struct nand_ecc_ctrl *ecc)
 	if (!ecc->size || !ecc->strength)
 		return -EINVAL;
 
+	/* If 512B ECC is not supported, switch to 1024 */
+	if (ecc->size == 512 && !nfc->caps->has_ecc_block_512)
+		ecc->size = 1024;
+
 	switch (ecc->mode) {
 	case NAND_ECC_SOFT_BCH:
 		break;
@@ -1715,6 +1722,7 @@ static int sunxi_nand_probe(struct udevice *dev)
 }
 
 static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
+	.has_ecc_block_512 = true,
 	.nstrengths = 9,
 	.reg_ecc_err_cnt = NFC_REG_A10_ECC_ERR_CNT,
 	.reg_user_data = NFC_REG_A10_USER_DATA,
diff --git a/drivers/mtd/nand/raw/sunxi_nand.h b/drivers/mtd/nand/raw/sunxi_nand.h
index 35079d37bb1f..be294d7cea0a 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.h
+++ b/drivers/mtd/nand/raw/sunxi_nand.h
@@ -169,6 +169,7 @@
  * NAND Controller capabilities structure: stores NAND controller capabilities
  * for distinction between compatible strings.
  *
+ * @has_ecc_block_512:	If the ECC can handle 512B or only 1024B chuncks
  * @nstrengths:		Number of element of ECC strengths array
  * @reg_ecc_err_cnt:	ECC error counter register
  * @reg_user_data:	User data register
@@ -176,6 +177,7 @@
  * @pat_found_mask:	ECC_PAT_FOUND mask in NFC_REG_PAT_FOUND register
  */
 struct sunxi_nfc_caps {
+	bool has_ecc_block_512;
 	unsigned int nstrengths;
 	unsigned int reg_ecc_err_cnt;
 	unsigned int reg_user_data;
