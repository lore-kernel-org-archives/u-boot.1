Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C1ACD7237B
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 11:47:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8171383C19;
	Fri, 23 Jan 2026 12:46:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="pX4iPV35";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27DC083C14; Fri, 23 Jan 2026 12:46:14 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C7E483B63
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 12:46:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id B0B7D4E42213;
 Fri, 23 Jan 2026 11:46:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 850D16070A;
 Fri, 23 Jan 2026 11:46:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B8768119A87C2; Fri, 23 Jan 2026 12:46:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1769168770; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=BUcwJ15/aJUAObodShVIca/aeem/+vsWiNuVEXZWOhM=;
 b=pX4iPV350i2rLtuDZkIsjac2+M1HfD2/lCFcagJkBggOfBkptke/yzfLbK4uvBsEaanUSZ
 bTOMDVEOE2iZ32SdqtFLEsgxEwuiuJdM5pkJqh5wtK+eoD3pJze7lCIoagVCJKZ6VutTlQ
 YfrAZ8tnQPYGQ3BSMrVqUvsXhcaMQOZ9d8p2CjCj2JTnWDyu0B8hjjCG5Wc6fXZclWa7U1
 NjkvXcZJ61A2JUBXKV9fjchdJI40wD8J2mMyPVUHY5KFXq2mhRnHVQnXRWrxbJDp1ZQ+RJ
 7vjClcsAlew4LqoTuAwC3wfz45K69/iJOj7NZBU19qBRpOEbatlyYCOOZ/YhKg==
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
Subject: [PATCH v3 12/26] mtd: rawnand: sunxi: move NFC_ECC_MODE offset in SoC
 caps
Date: Fri, 23 Jan 2026 12:44:47 +0100
Message-ID: <20260123114507.1400918-13-richard.genoud@bootlin.com>
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

NFC_ECC_MODE register offset moved in H616, so let's make it a SoC cap

No functional change.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 6 ++++--
 drivers/mtd/nand/raw/sunxi_nand.h | 9 ++++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index d14a12b6662c..c5efafa2414c 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -659,10 +659,11 @@ static void sunxi_nfc_hw_ecc_enable(struct mtd_info *mtd)
 	u32 ecc_ctl;
 
 	ecc_ctl = readl(nfc->regs + NFC_REG_ECC_CTL);
-	ecc_ctl &= ~(NFC_ECC_MODE_MSK | NFC_ECC_PIPELINE);
+	ecc_ctl &= ~(NFC_ECC_MODE_MSK(nfc) | NFC_ECC_PIPELINE);
 	if (nfc->caps->has_ecc_block_512)
 		ecc_ctl &= ~NFC_ECC_BLOCK_512;
-	ecc_ctl |= NFC_ECC_EN | NFC_ECC_MODE(data->mode) | NFC_ECC_EXCEPTION;
+	ecc_ctl |= NFC_ECC_EN | NFC_ECC_MODE(nfc, data->mode)
+		| NFC_ECC_EXCEPTION;
 
 	if (nand->ecc.size == 512 && nfc->caps->has_ecc_block_512)
 		ecc_ctl |= NFC_ECC_BLOCK_512;
@@ -1727,6 +1728,7 @@ static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
 	.reg_user_data = NFC_REG_A10_USER_DATA,
 	.reg_pat_found = NFC_REG_ECC_ST,
 	.pat_found_mask = GENMASK(31, 16),
+	.ecc_mode_mask = GENMASK(15, 12),
 };
 
 static const struct udevice_id sunxi_nand_ids[] = {
diff --git a/drivers/mtd/nand/raw/sunxi_nand.h b/drivers/mtd/nand/raw/sunxi_nand.h
index b4a05733c810..3b155b0c8f3e 100644
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
@@ -141,8 +142,8 @@
 #define NFC_ECC_BLOCK_512	BIT(5)
 #define NFC_RANDOM_EN		BIT(9)
 #define NFC_RANDOM_DIRECTION	BIT(10)
-#define NFC_ECC_MODE_MSK	(0xf << 12)
-#define NFC_ECC_MODE(x)		((x) << 12)
+#define NFC_ECC_MODE_MSK(nfc)	((nfc)->caps->ecc_mode_mask)
+#define NFC_ECC_MODE(nfc, x)	field_prep(NFC_ECC_MODE_MSK(nfc), (x))
 #define NFC_RANDOM_SEED_MSK	(0x7fff << 16)
 #define NFC_RANDOM_SEED(x)	((x) << 16)
 
@@ -174,6 +175,7 @@
  * @reg_user_data:	User data register
  * @reg_pat_found:	Data Pattern Status Register
  * @pat_found_mask:	ECC_PAT_FOUND mask in NFC_REG_PAT_FOUND register
+ * @ecc_mode_mask:	ECC_MODE mask in NFC_ECC_CTL register
  */
 struct sunxi_nfc_caps {
 	bool has_ecc_block_512;
@@ -182,6 +184,7 @@ struct sunxi_nfc_caps {
 	unsigned int reg_user_data;
 	unsigned int reg_pat_found;
 	unsigned int pat_found_mask;
+	unsigned int ecc_mode_mask;
 };
 
 #endif
-- 
2.47.3

