Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D4DD7236C
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 11:47:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9B5783B97;
	Fri, 23 Jan 2026 12:46:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="n1dZuw4N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4394A83BE1; Fri, 23 Jan 2026 12:46:11 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA76883B63
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 12:46:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 93B1E1A2B46;
 Fri, 23 Jan 2026 11:46:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 68B546070A;
 Fri, 23 Jan 2026 11:46:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5D407119A87C0; Fri, 23 Jan 2026 12:46:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1769168767; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=+uvmXlim36gH1WQuMNDfppVmldDi12gBjmBO6GsUMW4=;
 b=n1dZuw4Nk+2/4VMgJLdhx0If8jWmdbTfAasphjOW77ItukPP9+EUpsLhdNg/XemmBnx2EH
 tYDjcopMLeFcXxc+a4VlXE4iEgs/FM1LpqmDJTgPMtfHYN23kHBvcS4iWxOZMDIV/zr9Dr
 1RysxDrN+5TwbnHOZJbt+tzZ70JxTaDz9J6NVN7HoL4ob7Z9U3SKEpKP/xNcV30Kkcvvn/
 KDeL3kNNoKSO5amK3AjH5EB4NJnU2L48siqMv2LOT1H557PSyBzQID5iCmWhW1nwB3B0Ao
 BUshG7HDnWm+um06EwKehC5/UniCczxb5LBstMulSSzKxcXxKcnKADzhKnxtGg==
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
Subject: [PATCH v3 11/26] mtd: rawnand: sunxi: add has_ecc_block_512 capability
Date: Fri, 23 Jan 2026 12:44:46 +0100
Message-ID: <20260123114507.1400918-12-richard.genoud@bootlin.com>
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

Introduce has_ecc_block_512 capability

The H616 controller can't handle 512 bytes ECC block size. The
NFC_ECC_BLOCK_512 bit disappeared in H6, and NDFC_RANDOM_EN took its
place.

So, add has_ecc_block_512 capability to only set this bit on SoC having
it.
On the way, let's drop NFC_ECC_BLOCK_SIZE_MSK which was just a mask for
the very same bit.

No functional change.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 14 +++++++++++---
 drivers/mtd/nand/raw/sunxi_nand.h |  3 ++-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 07026ced0af6..d14a12b6662c 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -659,11 +659,12 @@ static void sunxi_nfc_hw_ecc_enable(struct mtd_info *mtd)
 	u32 ecc_ctl;
 
 	ecc_ctl = readl(nfc->regs + NFC_REG_ECC_CTL);
-	ecc_ctl &= ~(NFC_ECC_MODE_MSK | NFC_ECC_PIPELINE |
-		     NFC_ECC_BLOCK_SIZE_MSK);
+	ecc_ctl &= ~(NFC_ECC_MODE_MSK | NFC_ECC_PIPELINE);
+	if (nfc->caps->has_ecc_block_512)
+		ecc_ctl &= ~NFC_ECC_BLOCK_512;
 	ecc_ctl |= NFC_ECC_EN | NFC_ECC_MODE(data->mode) | NFC_ECC_EXCEPTION;
 
-	if (nand->ecc.size == 512)
+	if (nand->ecc.size == 512 && nfc->caps->has_ecc_block_512)
 		ecc_ctl |= NFC_ECC_BLOCK_512;
 
 	writel(ecc_ctl, nfc->regs + NFC_REG_ECC_CTL);
@@ -1453,6 +1454,8 @@ static void sunxi_nand_ecc_cleanup(struct nand_ecc_ctrl *ecc)
 static int sunxi_nand_ecc_init(struct mtd_info *mtd, struct nand_ecc_ctrl *ecc)
 {
 	struct nand_chip *nand = mtd_to_nand(mtd);
+	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
+	struct sunxi_nfc *nfc = to_sunxi_nfc(sunxi_nand->nand.controller);
 	int ret;
 
 	if (!ecc->size) {
@@ -1463,6 +1466,10 @@ static int sunxi_nand_ecc_init(struct mtd_info *mtd, struct nand_ecc_ctrl *ecc)
 	if (!ecc->size || !ecc->strength)
 		return -EINVAL;
 
+	/* If 512B ECC is not supported, switch to 1024 */
+	if (ecc->size == 512 && !nfc->caps->has_ecc_block_512)
+		ecc->size = 1024;
+
 	switch (ecc->mode) {
 	case NAND_ECC_SOFT_BCH:
 		break;
@@ -1714,6 +1721,7 @@ static int sunxi_nand_probe(struct udevice *dev)
 }
 
 static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
+	.has_ecc_block_512 = true,
 	.nstrengths = 9,
 	.reg_ecc_err_cnt = NFC_REG_A10_ECC_ERR_CNT,
 	.reg_user_data = NFC_REG_A10_USER_DATA,
diff --git a/drivers/mtd/nand/raw/sunxi_nand.h b/drivers/mtd/nand/raw/sunxi_nand.h
index 35079d37bb1f..b4a05733c810 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.h
+++ b/drivers/mtd/nand/raw/sunxi_nand.h
@@ -138,7 +138,6 @@
 #define NFC_ECC_EN		BIT(0)
 #define NFC_ECC_PIPELINE	BIT(3)
 #define NFC_ECC_EXCEPTION	BIT(4)
-#define NFC_ECC_BLOCK_SIZE_MSK	BIT(5)
 #define NFC_ECC_BLOCK_512	BIT(5)
 #define NFC_RANDOM_EN		BIT(9)
 #define NFC_RANDOM_DIRECTION	BIT(10)
@@ -169,6 +168,7 @@
  * NAND Controller capabilities structure: stores NAND controller capabilities
  * for distinction between compatible strings.
  *
+ * @has_ecc_block_512:	If the ECC can handle 512B or only 1024B chuncks
  * @nstrengths:		Number of element of ECC strengths array
  * @reg_ecc_err_cnt:	ECC error counter register
  * @reg_user_data:	User data register
@@ -176,6 +176,7 @@
  * @pat_found_mask:	ECC_PAT_FOUND mask in NFC_REG_PAT_FOUND register
  */
 struct sunxi_nfc_caps {
+	bool has_ecc_block_512;
 	unsigned int nstrengths;
 	unsigned int reg_ecc_err_cnt;
 	unsigned int reg_user_data;
-- 
2.47.3

