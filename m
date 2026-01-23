Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A8FD7237D
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 11:46:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F69C8397D;
	Fri, 23 Jan 2026 12:46:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Lc51YIBH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BCC183BC9; Fri, 23 Jan 2026 12:45:59 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42E9B83B82
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 12:45:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 39A60C21ABF;
 Fri, 23 Jan 2026 11:45:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 032EF6070A;
 Fri, 23 Jan 2026 11:45:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 40BBD119A87C4; Fri, 23 Jan 2026 12:45:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1769168755; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=0pDg+kahDRnc9gOQ60thMNZO0vOWcBztBorKt6zF1vw=;
 b=Lc51YIBHt1pfX8+OwFWGXtW71lrw59OnRb1XR5ypoxX35r8mo5EK3CtWb4dXQO96cKlBBo
 MFP7TLMImsseGPq1jd+zsfNpmuJmGG3UGKu6hjbfbkuvfJHa1mGGjGAPXG6mFYjt79gOIz
 /z7zyQ27yo+ePV1A+dkNVAJic6AT/GmJfASIzOdNDIHxN3EiTSmksZGvObDj97SZz9Dxji
 Ug/kRynIhNzm47SmtdyXlXZfqkBFuoqELPHP53A+PrNfWaFaV8wfs7XZf/TWN0o0ELnrdW
 FFQoFBIr7K0NEZz6Qrw9P9F7GjmA/A2+pGYtBZPeSNgFMxBRJGbgyMz0on+sFA==
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
Subject: [PATCH v3 07/26] mtd: rawnand: sunxi: add per SoC capabilities
Date: Fri, 23 Jan 2026 12:44:42 +0100
Message-ID: <20260123114507.1400918-8-richard.genoud@bootlin.com>
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

Introduce per SoC capabilities in sunxi_nand.c

This prepares for the H616 support that has quite a lot differences in
registers offset and capabilities.

Start with the ECC strength table.

No functional change.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 18 ++++++++++++++++--
 drivers/mtd/nand/raw/sunxi_nand.h | 10 ++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 20028d539ac6..41262b089cb9 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -149,6 +149,7 @@ static inline struct sunxi_nand_chip *to_sunxi_nand(struct nand_chip *nand)
  * @clk_rate:		NAND controller current clock rate
  * @chips:		a list containing all the NAND chips attached to
  *			this NAND controller
+ * @caps:		NAND Controller capabilities
  */
 struct sunxi_nfc {
 	struct nand_hw_control controller;
@@ -159,6 +160,7 @@ struct sunxi_nfc {
 	unsigned long assigned_cs;
 	unsigned long clk_rate;
 	struct list_head chips;
+	const struct sunxi_nfc_caps *caps;
 };
 
 static inline struct sunxi_nfc *to_sunxi_nfc(struct nand_hw_control *ctrl)
@@ -1269,6 +1271,9 @@ static int sunxi_nand_hw_common_ecc_ctrl_init(struct mtd_info *mtd,
 					      struct nand_ecc_ctrl *ecc)
 {
 	static const u8 strengths[] = { 16, 24, 28, 32, 40, 48, 56, 60, 64 };
+	struct nand_chip *nand = mtd_to_nand(mtd);
+	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
+	struct sunxi_nfc *nfc = to_sunxi_nfc(sunxi_nand->nand.controller);
 	struct sunxi_nand_hw_ecc *data;
 	struct nand_ecclayout *layout;
 	int nsectors;
@@ -1291,7 +1296,7 @@ static int sunxi_nand_hw_common_ecc_ctrl_init(struct mtd_info *mtd,
 	}
 
 	/* Add ECC info retrieval from DT */
-	for (i = 0; i < ARRAY_SIZE(strengths); i++) {
+	for (i = 0; i < nfc->caps->nstrengths; i++) {
 		if (ecc->strength <= strengths[i]) {
 			/*
 			 * Update ecc->strength value with the actual strength
@@ -1302,7 +1307,7 @@ static int sunxi_nand_hw_common_ecc_ctrl_init(struct mtd_info *mtd,
 		}
 	}
 
-	if (i >= ARRAY_SIZE(strengths)) {
+	if (i >= nfc->caps->nstrengths) {
 		dev_err(mtd->dev, "unsupported strength\n");
 		ret = -ENOTSUPP;
 		goto err;
@@ -1680,6 +1685,10 @@ static int sunxi_nand_probe(struct udevice *dev)
 	if (!nfc->regs)
 		return -EINVAL;
 
+	nfc->caps = (const struct sunxi_nfc_caps *)dev_get_driver_data(dev);
+	if (!nfc->caps)
+		return -EINVAL;
+
 	ret = reset_get_bulk(dev, &rst_bulk);
 	if (!ret)
 		reset_deassert_bulk(&rst_bulk);
@@ -1701,9 +1710,14 @@ static int sunxi_nand_probe(struct udevice *dev)
 	return 0;
 }
 
+static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
+	.nstrengths = 9,
+};
+
 static const struct udevice_id sunxi_nand_ids[] = {
 	{
 		.compatible = "allwinner,sun4i-a10-nand",
+		.data = (unsigned long)&sunxi_nfc_a10_caps,
 	},
 	{ }
 };
diff --git a/drivers/mtd/nand/raw/sunxi_nand.h b/drivers/mtd/nand/raw/sunxi_nand.h
index 59803ccc9f22..80fbc8df0090 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.h
+++ b/drivers/mtd/nand/raw/sunxi_nand.h
@@ -153,4 +153,14 @@
 
 #define NFC_MAX_CS		7
 
+/*
+ * NAND Controller capabilities structure: stores NAND controller capabilities
+ * for distinction between compatible strings.
+ *
+ * @nstrengths:		Number of element of ECC strengths array
+ */
+struct sunxi_nfc_caps {
+	unsigned int nstrengths;
+};
+
 #endif
-- 
2.47.3

