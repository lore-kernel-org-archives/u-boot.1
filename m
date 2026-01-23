Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2308D7237B
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 11:48:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAA0683C91;
	Fri, 23 Jan 2026 12:46:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="eImAqqGV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA7C783C5E; Fri, 23 Jan 2026 12:46:27 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C907183C72
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 12:46:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 8200D1A2B52;
 Fri, 23 Jan 2026 11:46:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 574EA6070A;
 Fri, 23 Jan 2026 11:46:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 59EE2119A83E7; Fri, 23 Jan 2026 12:46:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1769168784; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=YCsgo3vzRJqo3y5sfEhY6ycW8e78aW0oXxM5SPOKKt4=;
 b=eImAqqGVsXHwmbAAtXq+jAvUp/+1GKUbC72OSDnMAfJQCamwL1JWuHoKpgH9O07yDCiTYk
 u6iQzTafz7AtCMBlqXa3AexMIcNTVPXNlNPhMvVILfsSvpqT5wGVFlau/HcHf6xPU2gp8Z
 +vGOCWdhUk3KyY6hYTn+g0hYXj3EKBDJtS59KYTX/ormaAkmq6N5r6AFOJVhd+vEunKmW9
 5zyypdLQvPwEez+YVDm/3TDx5isJyTLnXepFEhVsHAOTHL7YypO89hA34I1/l6KzGB1Nd9
 yjk7qV34H4b54KKjcB1AOvRfw7MNPOZtK/zoRg7cc3mTJEVqww8pGA3Tm9IHHQ==
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
Subject: [PATCH v3 17/26] mtd: rawnand: sunxi_spl: use NFC_ECC_ERR_MSK and
 NFC_ECC_PAT_FOUND
Date: Fri, 23 Jan 2026 12:44:52 +0100
Message-ID: <20260123114507.1400918-18-richard.genoud@bootlin.com>
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

Use defines instead of hardcoded values for NFC_ECC_{ERR_MSK,PAT_FOUND}

SPL is using hard coded values for ECC error detection and empty chunk
detection.
The H6/H616 registers for that have changed, the pattern found is no
more in the NFC_REG_ECC_ST register.

So, don't presume anymore that pattern_found is in NFC_REG_ECC_ST, and
read the pattern_found register to get this information.

Apart from an additional register reading, no functional change.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand.h     |  3 +++
 drivers/mtd/nand/raw/sunxi_nand_spl.c | 21 +++++++++++++++------
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.h b/drivers/mtd/nand/raw/sunxi_nand.h
index b5a3800d33d2..25d18eaa0b81 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.h
+++ b/drivers/mtd/nand/raw/sunxi_nand.h
@@ -150,6 +150,7 @@
 
 /* define bit use in NFC_ECC_ST */
 #define NFC_ECC_ERR(x)		BIT(x)
+#define NFC_ECC_ERR_MSK(nfc)	((nfc)->caps->ecc_err_mask)
 
 /*
  * define bit use in NFC_REG_PAT_FOUND
@@ -177,6 +178,7 @@
  * @reg_spare_area:	Spare Area Register
  * @reg_pat_id:		Pattern ID Register
  * @reg_pat_found:	Data Pattern Status Register
+ * @ecc_err_mask:	ERR_ERR mask in NFC_ECC_ST register
  * @pat_found_mask:	ECC_PAT_FOUND mask in NFC_REG_PAT_FOUND register
  * @ecc_mode_mask:	ECC_MODE mask in NFC_ECC_CTL register
  * @random_en_mask:	RANDOM_EN mask in NFC_ECC_CTL register
@@ -190,6 +192,7 @@ struct sunxi_nfc_caps {
 	unsigned int reg_pat_id;
 	unsigned int reg_pat_found;
 	unsigned int pat_found_mask;
+	unsigned int ecc_err_mask;
 	unsigned int ecc_mode_mask;
 	unsigned int random_en_mask;
 };
diff --git a/drivers/mtd/nand/raw/sunxi_nand_spl.c b/drivers/mtd/nand/raw/sunxi_nand_spl.c
index 7f9ee14ffc3c..da94285e6b72 100644
--- a/drivers/mtd/nand/raw/sunxi_nand_spl.c
+++ b/drivers/mtd/nand/raw/sunxi_nand_spl.c
@@ -55,6 +55,9 @@ const uint16_t random_seed[128] = {
 __maybe_unused static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
 	.has_ecc_block_512 = true,
 	.reg_spare_area = NFC_REG_A10_SPARE_AREA,
+	.reg_pat_found = NFC_REG_ECC_ST,
+	.pat_found_mask = GENMASK(31, 16),
+	.ecc_err_mask = GENMASK(15, 0),
 	.random_en_mask = BIT(9),
 };
 
@@ -211,7 +214,7 @@ static int nand_read_page(const struct nfc_config *conf, u32 offs,
 	u16 rand_seed = 0;
 	int oob_chunk_sz = ecc_bytes[conf->ecc_strength];
 	int page = offs / conf->page_size;
-	u32 ecc_st;
+	u32 ecc_st, pattern_found;
 	int i;
 
 	if (offs % conf->page_size || len % conf->ecc_size ||
@@ -256,15 +259,21 @@ static int nand_read_page(const struct nfc_config *conf, u32 offs,
 		ecc_st = readl(SUNXI_NFC_BASE + NFC_REG_ECC_ST);
 
 		/* ECC error detected. */
-		if (ecc_st & 0xffff)
+		if (ecc_st & NFC_ECC_ERR_MSK(conf))
 			return -EIO;
 
 		/*
-		 * Return 1 if the first chunk is empty (needed for
-		 * configuration detection).
+		 * Return 1 if the first chunk is empty (all 00 or ff)
+		 * (needed for configuration detection).
 		 */
-		if (!i && (ecc_st & 0x10000))
-			return 1;
+		if (!i) {
+			pattern_found = readl(SUNXI_NFC_BASE +
+					      conf->caps->reg_pat_found);
+			pattern_found = field_get(NFC_ECC_PAT_FOUND_MSK(conf),
+						  pattern_found);
+			if (pattern_found & NFC_ECC_PAT_FOUND(0))
+				return 1;
+		}
 
 		/* Retrieve the data from SRAM */
 		nand_readlcpy((u32 *)data,
-- 
2.47.3

