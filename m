Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C7ED7237B
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 11:47:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E00A83C61;
	Fri, 23 Jan 2026 12:46:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="PozgTrWG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E0CE83C5E; Fri, 23 Jan 2026 12:46:22 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97DB783C65
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 12:46:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 270CD4E42216;
 Fri, 23 Jan 2026 11:46:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id EF8BC6070A;
 Fri, 23 Jan 2026 11:46:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D4287119A87C4; Fri, 23 Jan 2026 12:46:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1769168778; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=2ghFIz4xquQx4AUmsfJCByQcl8H4Ihlr7TOVD4LSUf4=;
 b=PozgTrWGGuqONE/zk5/NpcNVESVLr6KvrfewyG9hijVJfcZd6/zNK/e+I0DW/ZHREHr4xs
 ev3Nmc+Tf5xuOZ3wyIPZWG1iBC8RlHUmgqyrMHlrq95coTpOTLJBkrO4MdAKiI0kecs5C/
 0TkuNAwNsZmgm4ANhQYZq1+0bU8gsbHWdj+En/os8XB9vT0z/aiGRjMFTFDunou/yLHmQ3
 69r9PfsEcUK6iXcbIKyA90utRETzIFDKFobGVERyT3GvDi9F2QWuwns5ImPJXyGsEwM4I6
 iFW+kSYfLL+HpbOTeOZclvcVz10cBZxH0sCaiZ3USTT4riWNq9H7jD9L44UZ6A==
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
Subject: [PATCH v3 15/26] mtd: rawnand: sunxi: move NFC_RANDOM_EN register
 offset in SoC caps
Date: Fri, 23 Jan 2026 12:44:50 +0100
Message-ID: <20260123114507.1400918-16-richard.genoud@bootlin.com>
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
index c032cabb4dc9..c35dff75de06 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -608,7 +608,7 @@ static void sunxi_nfc_randomizer_enable(struct mtd_info *mtd)
 	if (!(nand->options & NAND_NEED_SCRAMBLING))
 		return;
 
-	writel(readl(nfc->regs + NFC_REG_ECC_CTL) | NFC_RANDOM_EN,
+	writel(readl(nfc->regs + NFC_REG_ECC_CTL) | NFC_RANDOM_EN(nfc),
 	       nfc->regs + NFC_REG_ECC_CTL);
 }
 
@@ -620,7 +620,7 @@ static void sunxi_nfc_randomizer_disable(struct mtd_info *mtd)
 	if (!(nand->options & NAND_NEED_SCRAMBLING))
 		return;
 
-	writel(readl(nfc->regs + NFC_REG_ECC_CTL) & ~NFC_RANDOM_EN,
+	writel(readl(nfc->regs + NFC_REG_ECC_CTL) & ~NFC_RANDOM_EN(nfc),
 	       nfc->regs + NFC_REG_ECC_CTL);
 }
 
@@ -1730,6 +1730,7 @@ static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
 	.reg_pat_id = NFC_REG_A10_PAT_ID,
 	.pat_found_mask = GENMASK(31, 16),
 	.ecc_mode_mask = GENMASK(15, 12),
+	.random_en_mask = BIT(9),
 };
 
 static const struct udevice_id sunxi_nand_ids[] = {
diff --git a/drivers/mtd/nand/raw/sunxi_nand.h b/drivers/mtd/nand/raw/sunxi_nand.h
index e18feb77c93c..2cbfc5c9c62a 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.h
+++ b/drivers/mtd/nand/raw/sunxi_nand.h
@@ -141,8 +141,7 @@
 #define NFC_ECC_PIPELINE	BIT(3)
 #define NFC_ECC_EXCEPTION	BIT(4)
 #define NFC_ECC_BLOCK_512	BIT(5)
-#define NFC_RANDOM_EN		BIT(9)
-#define NFC_RANDOM_DIRECTION	BIT(10)
+#define NFC_RANDOM_EN(nfc)	((nfc)->caps->random_en_mask)
 #define NFC_ECC_MODE_MSK(nfc)	((nfc)->caps->ecc_mode_mask)
 #define NFC_ECC_MODE(nfc, x)	field_prep(NFC_ECC_MODE_MSK(nfc), (x))
 #define NFC_RANDOM_SEED_MSK	(0x7fff << 16)
@@ -178,6 +177,7 @@
  * @reg_pat_found:	Data Pattern Status Register
  * @pat_found_mask:	ECC_PAT_FOUND mask in NFC_REG_PAT_FOUND register
  * @ecc_mode_mask:	ECC_MODE mask in NFC_ECC_CTL register
+ * @random_en_mask:	RANDOM_EN mask in NFC_ECC_CTL register
  */
 struct sunxi_nfc_caps {
 	bool has_ecc_block_512;
@@ -188,6 +188,7 @@ struct sunxi_nfc_caps {
 	unsigned int reg_pat_found;
 	unsigned int pat_found_mask;
 	unsigned int ecc_mode_mask;
+	unsigned int random_en_mask;
 };
 
 #endif
diff --git a/drivers/mtd/nand/raw/sunxi_nand_spl.c b/drivers/mtd/nand/raw/sunxi_nand_spl.c
index 035b224bb437..49ff56fb695c 100644
--- a/drivers/mtd/nand/raw/sunxi_nand_spl.c
+++ b/drivers/mtd/nand/raw/sunxi_nand_spl.c
@@ -54,6 +54,7 @@ const uint16_t random_seed[128] = {
 
 __maybe_unused static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
 	.has_ecc_block_512 = true,
+	.random_en_mask = BIT(9),
 };
 
 #define DEFAULT_TIMEOUT_US	100000
@@ -233,7 +234,7 @@ static int nand_read_page(const struct nfc_config *conf, u32 offs,
 		/* Clear ECC status and restart ECC engine */
 		writel(0, SUNXI_NFC_BASE + NFC_REG_ECC_ST);
 		writel((rand_seed << 16) | (conf->ecc_strength << 12) |
-		       (conf->randomize ? NFC_RANDOM_EN : 0) |
+		       (conf->randomize ? NFC_RANDOM_EN(conf) : 0) |
 		       ecc512_bit |
 		       NFC_ECC_EN | NFC_ECC_EXCEPTION,
 		       SUNXI_NFC_BASE + NFC_REG_ECC_CTL);
-- 
2.47.3

