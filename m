Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB9C2CCD199
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 14:31:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AC3183977;
	Thu, 16 Oct 2025 16:29:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="G1XgvbAx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC98483971; Thu, 16 Oct 2025 16:29:43 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACE418391C
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 16:29:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 5E01A4E41111;
 Thu, 16 Oct 2025 14:29:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 32F5E6062C;
 Thu, 16 Oct 2025 14:29:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D0B80102F231B; 
 Thu, 16 Oct 2025 16:29:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1760624974; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=mkRL1W7ncMuJ54rLYnribiYAUqv1tRr8PYIT6I8TFfY=;
 b=G1XgvbAx1gzQTl43SB5eHEJPiYbh4PPnlr6U5WVtUd2B5RhotS2ebtV2Uh5+uCx8KM2KM4
 FUWpNHU9DXoXiAyyMpW8Zp2ksun7JVLXwdabwA+5TJ6ifID/8WjtVcoADA/So3O1yYiRQv
 kyEb3/HkOiCyG12gKZ2/PNLUQBnet9sXw/B6y9OVTe3JoYJdkIQtm1NHvg8XpROFRK13JS
 5Hd5f7mA3faOFvSNk0baDGZrbNM1BTSY+NrL6OfPtR9U8d+L8uMZh2BoG0AE6HD8/5bNkY
 NrdljYqCP2K1VjKUTjf1eJRGxppL0yGx627b0s64ntXbs1Ua62KnX28Eg46LxA==
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
Subject: [PATCH 17/24] mtd: rawnand: sunxi_spl: use NFC_ECC_ERR_MSK and
 NFC_ECC_PAT_FOUND
Date: Thu, 16 Oct 2025 16:27:40 +0200
Message-ID: <20251016142752.2627710-18-richard.genoud@bootlin.com>
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
index a8224d1f7c85..52200468d343 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.h
+++ b/drivers/mtd/nand/raw/sunxi_nand.h
@@ -151,6 +151,7 @@
 
 /* define bit use in NFC_ECC_ST */
 #define NFC_ECC_ERR(x)		BIT(x)
+#define NFC_ECC_ERR_MSK(nfc)	((nfc)->caps->ecc_err_mask)
 
 /*
  * define bit use in NFC_REG_PAT_FOUND
@@ -178,6 +179,7 @@
  * @reg_spare_area:	Spare Area Register
  * @reg_pat_id:		Pattern ID Register
  * @reg_pat_found:	Data Pattern Status Register
+ * @ecc_err_mask:	ERR_ERR mask in NFC_ECC_ST register
  * @pat_found_mask:	ECC_PAT_FOUND mask in NFC_REG_PAT_FOUND register
  * @ecc_mode_mask:	ECC_MODE mask in NFC_ECC_CTL register
  * @random_en_mask:	RANDOM_EN mask in NFC_ECC_CTL register
@@ -191,6 +193,7 @@ struct sunxi_nfc_caps {
 	unsigned int reg_pat_id;
 	unsigned int reg_pat_found;
 	unsigned int pat_found_mask;
+	unsigned int ecc_err_mask;
 	unsigned int ecc_mode_mask;
 	unsigned int random_en_mask;
 };
diff --git a/drivers/mtd/nand/raw/sunxi_nand_spl.c b/drivers/mtd/nand/raw/sunxi_nand_spl.c
index bb0dbd9977f5..544b46ce1d21 100644
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
 
@@ -202,7 +205,7 @@ static int nand_read_page(const struct nfc_config *conf, u32 offs,
 	u16 rand_seed = 0;
 	int oob_chunk_sz = ecc_bytes[conf->ecc_strength];
 	int page = offs / conf->page_size;
-	u32 ecc_st;
+	u32 ecc_st, pattern_found;
 	int i;
 
 	if (offs % conf->page_size || len % conf->ecc_size ||
@@ -247,15 +250,21 @@ static int nand_read_page(const struct nfc_config *conf, u32 offs,
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
 		memcpy_fromio(data,
