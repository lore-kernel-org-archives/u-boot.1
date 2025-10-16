Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66F4CCD195
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 14:31:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAFFC838F0;
	Thu, 16 Oct 2025 16:29:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="XYC+k6jl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1F7F83771; Thu, 16 Oct 2025 16:29:34 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9BB6838C5
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 16:29:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 239C1C041D1;
 Thu, 16 Oct 2025 14:29:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5931C6062C;
 Thu, 16 Oct 2025 14:29:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5F54A102F231D; 
 Thu, 16 Oct 2025 16:29:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1760624970; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=pNUhuCD/HuEt4ghPX/U2CCSpV/yovk/ej52Vs2QEC0A=;
 b=XYC+k6jlO1SekxPAkl3FnlFDHQ0OzhUWiT7V4dfIp8cAycRkYVqHtkg+Y/lyfwklm1d6PQ
 O8n3Jp9m6fJS3Xr2LZya4v+xNAdupUiW7HC781XROh81qpTlhPIeXFZOpJADHM4reFrS3X
 GocfS6ftTw6ti8ImLJkRpkGdAsVO/JtSGrpYafkeVIfNj69qN/RBLIFzWHtHUTV2G4pQrq
 9RMXlSQrzegXaFLRLa6MlcqRFIrcL/FAyRSm0sQS7NPGYfhdJTNP15YWfcIMq45LA5mWEA
 HXgFLy35U6VG0vH4WNYKRWCdvRqhxJtYjcL1yrRgBRFnCvttpSkKOxWi8dlO/A==
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
Subject: [PATCH 16/24] mtd: rawnand: sunxi: cosmetic: introduce reg_spare_area
 in sunxi_nfc_caps
Date: Thu, 16 Oct 2025 16:27:39 +0200
Message-ID: <20251016142752.2627710-17-richard.genoud@bootlin.com>
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

Introduce NDFC Spare Area Register offset in SoC capabilities

The H6/H616 spare area register is not at the same offset as the
A10/A23 one, so move its offset into sunxi_nfc_caps.

No functional change.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c     | 3 ++-
 drivers/mtd/nand/raw/sunxi_nand.h     | 7 +++++--
 drivers/mtd/nand/raw/sunxi_nand_spl.c | 3 ++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index a9fce01fb89c..58c895095ce9 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -329,7 +329,7 @@ static void sunxi_nfc_select_chip(struct mtd_info *mtd, int chip)
 				ctl |= NFC_RB_SEL(sel->rb.info.nativeid);
 		}
 
-		writel(mtd->writesize, nfc->regs + NFC_REG_SPARE_AREA);
+		writel(mtd->writesize, nfc->regs + NFC_REG_SPARE_AREA(nfc));
 
 		if (nfc->clk_rate != sunxi_nand->clk_rate) {
 			sunxi_nfc_set_clk_rate(sunxi_nand->clk_rate);
@@ -1728,6 +1728,7 @@ static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
 	.reg_ecc_err_cnt = NFC_REG_A10_ECC_ERR_CNT,
 	.reg_user_data = NFC_REG_A10_USER_DATA,
 	.reg_pat_found = NFC_REG_ECC_ST,
+	.reg_spare_area = NFC_REG_A10_SPARE_AREA,
 	.reg_pat_id = NFC_REG_A10_PAT_ID,
 	.pat_found_mask = GENMASK(31, 16),
 	.ecc_mode_mask = GENMASK(15, 12),
diff --git a/drivers/mtd/nand/raw/sunxi_nand.h b/drivers/mtd/nand/raw/sunxi_nand.h
index 99bee478665f..a8224d1f7c85 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.h
+++ b/drivers/mtd/nand/raw/sunxi_nand.h
@@ -49,8 +49,9 @@
 #define NFC_REG_ECC_ERR_CNT(nfc, x)	(((nfc)->caps->reg_ecc_err_cnt + (x)) & ~0x3)
 #define NFC_REG_A10_USER_DATA	0x0050
 #define NFC_REG_USER_DATA(nfc, x)	((nfc)->caps->reg_user_data + ((x) * 4))
-#define NFC_REG_SPARE_AREA	0x00A0
-#define NFC_REG_PAT_ID(nfc)	((nfc)->caps->reg_pat_id)
+#define NFC_REG_SPARE_AREA(nfc) ((nfc)->caps->reg_spare_area)
+#define NFC_REG_A10_SPARE_AREA	0x00A0
+#define NFC_REG_PAT_ID(nfc) ((nfc)->caps->reg_pat_id)
 #define NFC_REG_A10_PAT_ID	0x00A4
 #define NFC_RAM0_BASE		0x0400
 #define NFC_RAM1_BASE		0x0800
@@ -174,6 +175,7 @@
  * @nstrengths:		Number of element of ECC strengths array
  * @reg_ecc_err_cnt:	ECC error counter register
  * @reg_user_data:	User data register
+ * @reg_spare_area:	Spare Area Register
  * @reg_pat_id:		Pattern ID Register
  * @reg_pat_found:	Data Pattern Status Register
  * @pat_found_mask:	ECC_PAT_FOUND mask in NFC_REG_PAT_FOUND register
@@ -185,6 +187,7 @@ struct sunxi_nfc_caps {
 	unsigned int nstrengths;
 	unsigned int reg_ecc_err_cnt;
 	unsigned int reg_user_data;
+	unsigned int reg_spare_area;
 	unsigned int reg_pat_id;
 	unsigned int reg_pat_found;
 	unsigned int pat_found_mask;
diff --git a/drivers/mtd/nand/raw/sunxi_nand_spl.c b/drivers/mtd/nand/raw/sunxi_nand_spl.c
index 714518d67740..bb0dbd9977f5 100644
--- a/drivers/mtd/nand/raw/sunxi_nand_spl.c
+++ b/drivers/mtd/nand/raw/sunxi_nand_spl.c
@@ -54,6 +54,7 @@ const uint16_t random_seed[128] = {
 
 __maybe_unused static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
 	.has_ecc_block_512 = true,
+	.reg_spare_area = NFC_REG_A10_SPARE_AREA,
 	.random_en_mask = BIT(9),
 };
 
@@ -151,7 +152,7 @@ static void nand_apply_config(const struct nfc_config *conf)
 	writel(val | NFC_PAGE_SIZE(conf->page_size),
 	       SUNXI_NFC_BASE + NFC_REG_CTL);
 	writel(conf->ecc_size, SUNXI_NFC_BASE + NFC_REG_CNT);
-	writel(conf->page_size, SUNXI_NFC_BASE + NFC_REG_SPARE_AREA);
+	writel(conf->page_size, SUNXI_NFC_BASE + NFC_REG_SPARE_AREA(conf));
 }
 
 static int nand_load_page(const struct nfc_config *conf, u32 offs)
