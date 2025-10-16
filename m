Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3D7CCD199
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 14:30:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F3F5838C7;
	Thu, 16 Oct 2025 16:29:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="r5CdoT9S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3357D838C1; Thu, 16 Oct 2025 16:29:28 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53424838AE
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 16:29:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 0BAAD1A1440;
 Thu, 16 Oct 2025 14:29:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D52DE6062C;
 Thu, 16 Oct 2025 14:29:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DDEF8102F2325; 
 Thu, 16 Oct 2025 16:29:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1760624964; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=NgAlrs/HJFsBLTNDcyo6TMGCbloeafya3ak9MM9YMrQ=;
 b=r5CdoT9SSudBR9HjpOrORFVx9MVe5TSCDv+4mrLhalNuzT2ZBjv5srt5CCRBZ7enwt7C+b
 OWFMtQSfvyWzcFznnYF62NCEEZGzv2YNy3W8V4paeE3eodHMD8fo8GtyyPY2dYSUdfucbi
 4U/LTMYlw+WJlIsE2U9NToi42PLbuh6b2a9m1SRQYDfgsogu2gKFmuXSuIipbkc0DienFy
 ulknHSnZWLlurtYyYZ+BcGiSrnBsoQc0RKfGkxSj7Si3HCr9dw4ARZWw+O6ZUuQ4+izRij
 ZxmgrOW1JA/A+2NmuY4O7QTusEGbu4AB088xmMVQH7XpfHZEHYaUX8eh+59x+A==
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
Subject: [PATCH 14/24] mtd: rawnand: sunxi_spl: cosmetic: add per SoC
 capabilities
Date: Thu, 16 Oct 2025 16:27:37 +0200
Message-ID: <20251016142752.2627710-15-richard.genoud@bootlin.com>
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

Introduce per SoC capabilities in sunxi_nand_spl.c

Prepare for the H616 support that has quite a lot of differences in
registers offset and capabilities.

Start with the 512 bytes ECC capability.

No functional change.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand_spl.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand_spl.c b/drivers/mtd/nand/raw/sunxi_nand_spl.c
index f75ea473765e..6879890c1536 100644
--- a/drivers/mtd/nand/raw/sunxi_nand_spl.c
+++ b/drivers/mtd/nand/raw/sunxi_nand_spl.c
@@ -27,6 +27,7 @@ struct nfc_config {
 	int nseeds;
 	bool randomize;
 	bool valid;
+	const struct sunxi_nfc_caps *caps;
 };
 
 /* minimal "boot0" style NAND support for Allwinner A20 */
@@ -51,6 +52,10 @@ const uint16_t random_seed[128] = {
 	0x7c57, 0x0fbe, 0x46ce, 0x4939, 0x6b17, 0x37bb, 0x3e91, 0x76db,
 };
 
+__maybe_unused static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
+	.has_ecc_block_512 = true,
+};
+
 #define DEFAULT_TIMEOUT_US	100000
 
 static int check_value_inner(int offset, int expected_bits,
@@ -211,12 +216,16 @@ static int nand_read_page(const struct nfc_config *conf, u32 offs,
 		int data_off = i * conf->ecc_size;
 		int oob_off = conf->page_size + (i * oob_chunk_sz);
 		u8 *data = dest + data_off;
+		u32 ecc512_bit = 0;
+
+		if (conf->caps->has_ecc_block_512 && conf->ecc_size == 512)
+			ecc512_bit = NFC_ECC_BLOCK_512;
 
 		/* Clear ECC status and restart ECC engine */
 		writel(0, SUNXI_NFC_BASE + NFC_REG_ECC_ST);
 		writel((rand_seed << 16) | (conf->ecc_strength << 12) |
 		       (conf->randomize ? NFC_RANDOM_EN : 0) |
-		       (conf->ecc_size == 512 ? NFC_ECC_BLOCK_512 : 0) |
+		       ecc512_bit |
 		       NFC_ECC_EN | NFC_ECC_EXCEPTION,
 		       SUNXI_NFC_BASE + NFC_REG_ECC_CTL);
 
@@ -380,6 +389,8 @@ static int nand_detect_config(struct nfc_config *conf, u32 offs, void *dest)
 	if (conf->valid)
 		return 0;
 
+	conf->caps = &sunxi_nfc_a10_caps;
+
 	/*
 	 * Modern NANDs are more likely than legacy ones, so we start testing
 	 * with 5 address cycles.
