Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E004CCD19A
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 14:30:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73CF9838AE;
	Thu, 16 Oct 2025 16:29:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="VqZaZXeF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A05D83771; Thu, 16 Oct 2025 16:29:31 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BDAC838BF
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 16:29:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 2B3434E4110E;
 Thu, 16 Oct 2025 14:29:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 012616062C;
 Thu, 16 Oct 2025 14:29:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0CA3E102F231C; 
 Thu, 16 Oct 2025 16:29:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1760624967; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=LE6MTyxMv/+WO4m8rqccFiG0qtfaxvN0Y4a8DsFGpPo=;
 b=VqZaZXeFpNZ8/3wiEEqayqLNiM+jjMcGrlLjXiOUGTjevBt/FX0NxcBEShHhX2FkqU2Ws2
 XyQmAYdrMjvdriPLcGGE/f1iKygb2xrwD5SfDszpr2jn0vGWtg9zli97NtX22itSQLPy1G
 cU6bPbLdY1TF/aJhOBvMhS2ScxaU4B24qbjU0lid0tExlpaGHLOgJh9902tZgQyXxrYwrf
 +sISSXJXaRMupmfFQ0ZVWJ9U0aM/WJ2E4JRbzccjUNsqz7umyl4MhOHQIIyuc4dedqk9xm
 y/A+19SsCTzp/UzeTi4B4YsJijY9woJcklS6oTkK+4k1WOwY6q5v+pAYzRG4xg==
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
Subject: [PATCH 15/24] mtd: rawnand: sunxi: cosmetic: move NFC_RANDOM_EN
 register offset in SoC caps
Date: Thu, 16 Oct 2025 16:27:38 +0200
Message-ID: <20251016142752.2627710-16-richard.genoud@bootlin.com>
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

NFC_RANDOM_{EN,DIRECTION} registers offset moved in H616

Let's make it a SoC capability.

NFC_RANDOM_DIRECTION also moved, but it's unused, just remove it.

No functional change.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c     | 5 +++--
 drivers/mtd/nand/raw/sunxi_nand.h     | 5 +++--
 drivers/mtd/nand/raw/sunxi_nand_spl.c | 3 ++-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 1b429e1cbb20..a9fce01fb89c 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -609,7 +609,7 @@ static void sunxi_nfc_randomizer_enable(struct mtd_info *mtd)
 	if (!(nand->options & NAND_NEED_SCRAMBLING))
 		return;
 
-	writel(readl(nfc->regs + NFC_REG_ECC_CTL) | NFC_RANDOM_EN,
+	writel(readl(nfc->regs + NFC_REG_ECC_CTL) | NFC_RANDOM_EN(nfc),
 	       nfc->regs + NFC_REG_ECC_CTL);
 }
 
@@ -621,7 +621,7 @@ static void sunxi_nfc_randomizer_disable(struct mtd_info *mtd)
 	if (!(nand->options & NAND_NEED_SCRAMBLING))
 		return;
 
-	writel(readl(nfc->regs + NFC_REG_ECC_CTL) & ~NFC_RANDOM_EN,
+	writel(readl(nfc->regs + NFC_REG_ECC_CTL) & ~NFC_RANDOM_EN(nfc),
 	       nfc->regs + NFC_REG_ECC_CTL);
 }
 
@@ -1731,6 +1731,7 @@ static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
 	.reg_pat_id = NFC_REG_A10_PAT_ID,
 	.pat_found_mask = GENMASK(31, 16),
 	.ecc_mode_mask = GENMASK(15, 12),
+	.random_en_mask = BIT(9),
 };
 
 static const struct udevice_id sunxi_nand_ids[] = {
diff --git a/drivers/mtd/nand/raw/sunxi_nand.h b/drivers/mtd/nand/raw/sunxi_nand.h
index a0ce098db3f9..99bee478665f 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.h
+++ b/drivers/mtd/nand/raw/sunxi_nand.h
@@ -142,8 +142,7 @@
 #define NFC_ECC_EXCEPTION	BIT(4)
 #define NFC_ECC_BLOCK_SIZE_MSK	BIT(5)
 #define NFC_ECC_BLOCK_512	BIT(5)
-#define NFC_RANDOM_EN		BIT(9)
-#define NFC_RANDOM_DIRECTION	BIT(10)
+#define NFC_RANDOM_EN(nfc)	((nfc)->caps->random_en_mask)
 #define NFC_ECC_MODE_MSK(nfc)	((nfc)->caps->ecc_mode_mask)
 #define NFC_ECC_MODE(nfc, x)	field_prep(NFC_ECC_MODE_MSK(nfc), (x))
 #define NFC_RANDOM_SEED_MSK	(0x7fff << 16)
@@ -179,6 +178,7 @@
  * @reg_pat_found:	Data Pattern Status Register
  * @pat_found_mask:	ECC_PAT_FOUND mask in NFC_REG_PAT_FOUND register
  * @ecc_mode_mask:	ECC_MODE mask in NFC_ECC_CTL register
+ * @random_en_mask:	RANDOM_EN mask in NFC_ECC_CTL register
  */
 struct sunxi_nfc_caps {
 	bool has_ecc_block_512;
@@ -189,6 +189,7 @@ struct sunxi_nfc_caps {
 	unsigned int reg_pat_found;
 	unsigned int pat_found_mask;
 	unsigned int ecc_mode_mask;
+	unsigned int random_en_mask;
 };
 
 #endif
diff --git a/drivers/mtd/nand/raw/sunxi_nand_spl.c b/drivers/mtd/nand/raw/sunxi_nand_spl.c
index 6879890c1536..714518d67740 100644
--- a/drivers/mtd/nand/raw/sunxi_nand_spl.c
+++ b/drivers/mtd/nand/raw/sunxi_nand_spl.c
@@ -54,6 +54,7 @@ const uint16_t random_seed[128] = {
 
 __maybe_unused static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
 	.has_ecc_block_512 = true,
+	.random_en_mask = BIT(9),
 };
 
 #define DEFAULT_TIMEOUT_US	100000
@@ -224,7 +225,7 @@ static int nand_read_page(const struct nfc_config *conf, u32 offs,
 		/* Clear ECC status and restart ECC engine */
 		writel(0, SUNXI_NFC_BASE + NFC_REG_ECC_ST);
 		writel((rand_seed << 16) | (conf->ecc_strength << 12) |
-		       (conf->randomize ? NFC_RANDOM_EN : 0) |
+		       (conf->randomize ? NFC_RANDOM_EN(conf) : 0) |
 		       ecc512_bit |
 		       NFC_ECC_EN | NFC_ECC_EXCEPTION,
 		       SUNXI_NFC_BASE + NFC_REG_ECC_CTL);
