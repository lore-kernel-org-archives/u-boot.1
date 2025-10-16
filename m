Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9CC0CCD199
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 14:30:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CF83836F0;
	Thu, 16 Oct 2025 16:29:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="k7CzEuUZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D58E836F0; Thu, 16 Oct 2025 16:29:20 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8EA6838A0
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 16:29:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 571344E4110B;
 Thu, 16 Oct 2025 14:29:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 275406062C;
 Thu, 16 Oct 2025 14:29:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A4A32102F231D; 
 Thu, 16 Oct 2025 16:29:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1760624956; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=RvKWjaJ7Y+EwCPf3Cb3eatM6EzhtXTkpJ9mvEgE34DQ=;
 b=k7CzEuUZ+hgs7/3h/PpZZOHtLBAOKZmY4+/nb7X5YWlk+8nFwcr8tsAmPAvkXAnZ9Q65p0
 968OKbzFIXvapYYydC9MLXR8DLdrxgFsEEiU4W1WXd67HrinayRy1wrwe/E2lYOLFm6LgO
 FJsMqWIUj2I9r65p8fzIVfyUcpDMHh5824dr50Oyqmov2Xx0JjL05yBhhJO3D0B4ywP9ZG
 R3UQmX862szjIj+NfueHgivkMy/0MOUMaLA6tzDjXu4NA7Oy1vJkjs3m8fF5D1kRvuLFyB
 OklgIOm7DMkIeMxZ/wMMiiwrQQ0Hq2DAAapHCXMeQftfoPgPGfwoP6b4Go+XFQ==
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
Subject: [PATCH 12/24] mtd: rawnand: sunxi: cosmetic: move NFC_ECC_MODE offset
 in SoC caps
Date: Thu, 16 Oct 2025 16:27:35 +0200
Message-ID: <20251016142752.2627710-13-richard.genoud@bootlin.com>
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

NFC_ECC_MODE register offset moved in H616, so let's make it a SoC cap

No functional change.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 6 ++++--
 drivers/mtd/nand/raw/sunxi_nand.h | 9 ++++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index fddb1cada023..fd74aa290c92 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -660,10 +660,11 @@ static void sunxi_nfc_hw_ecc_enable(struct mtd_info *mtd)
 	u32 ecc_ctl;
 
 	ecc_ctl = readl(nfc->regs + NFC_REG_ECC_CTL);
-	ecc_ctl &= ~(NFC_ECC_MODE_MSK | NFC_ECC_PIPELINE);
+	ecc_ctl &= ~(NFC_ECC_MODE_MSK(nfc) | NFC_ECC_PIPELINE);
 	if (nfc->caps->has_ecc_block_512)
 		ecc_ctl &= ~NFC_ECC_BLOCK_SIZE_MSK;
-	ecc_ctl |= NFC_ECC_EN | NFC_ECC_MODE(data->mode) | NFC_ECC_EXCEPTION;
+	ecc_ctl |= NFC_ECC_EN | NFC_ECC_MODE(nfc, data->mode)
+		| NFC_ECC_EXCEPTION;
 
 	if (nand->ecc.size == 512 && nfc->caps->has_ecc_block_512)
 		ecc_ctl |= NFC_ECC_BLOCK_512;
@@ -1728,6 +1729,7 @@ static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
 	.reg_user_data = NFC_REG_A10_USER_DATA,
 	.reg_pat_found = NFC_REG_ECC_ST,
 	.pat_found_mask = GENMASK(31, 16),
+	.ecc_mode_mask = GENMASK(15, 12),
 };
 
 static const struct udevice_id sunxi_nand_ids[] = {
diff --git a/drivers/mtd/nand/raw/sunxi_nand.h b/drivers/mtd/nand/raw/sunxi_nand.h
index be294d7cea0a..069beaa5289d 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.h
+++ b/drivers/mtd/nand/raw/sunxi_nand.h
@@ -25,8 +25,9 @@
 
 #include <linux/bitops.h>
 
-/* non compile-time field get */
+/* non compile-time field get/prep */
 #define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
+#define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
 
 #define NFC_REG_CTL		0x0000
 #define NFC_REG_ST		0x0004
@@ -142,8 +143,8 @@
 #define NFC_ECC_BLOCK_512	BIT(5)
 #define NFC_RANDOM_EN		BIT(9)
 #define NFC_RANDOM_DIRECTION	BIT(10)
-#define NFC_ECC_MODE_MSK	(0xf << 12)
-#define NFC_ECC_MODE(x)		((x) << 12)
+#define NFC_ECC_MODE_MSK(nfc)	((nfc)->caps->ecc_mode_mask)
+#define NFC_ECC_MODE(nfc, x)	field_prep(NFC_ECC_MODE_MSK(nfc), (x))
 #define NFC_RANDOM_SEED_MSK	(0x7fff << 16)
 #define NFC_RANDOM_SEED(x)	((x) << 16)
 
@@ -175,6 +176,7 @@
  * @reg_user_data:	User data register
  * @reg_pat_found:	Data Pattern Status Register
  * @pat_found_mask:	ECC_PAT_FOUND mask in NFC_REG_PAT_FOUND register
+ * @ecc_mode_mask:	ECC_MODE mask in NFC_ECC_CTL register
  */
 struct sunxi_nfc_caps {
 	bool has_ecc_block_512;
@@ -183,6 +185,7 @@ struct sunxi_nfc_caps {
 	unsigned int reg_user_data;
 	unsigned int reg_pat_found;
 	unsigned int pat_found_mask;
+	unsigned int ecc_mode_mask;
 };
 
 #endif
