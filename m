Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF61FCCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 09:15:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9340E83AAD;
	Tue, 28 Oct 2025 10:14:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="URLvI2tT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6869783AA0; Tue, 28 Oct 2025 10:14:08 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82C0E83AAD
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 10:14:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 3DB8A1A16ED;
 Tue, 28 Oct 2025 09:14:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 12C26606AB;
 Tue, 28 Oct 2025 09:14:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6B1B9102F49F9; Tue, 28 Oct 2025 10:14:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1761642844; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=DbbPzkzx8eHwTuBCJi4THUqpOd/0V+I6hx2zT2MtYHU=;
 b=URLvI2tTqOTpQ1N5wdf9fiTOj+b7bdJMVzwPq6AYnOhKwEhOvy3QqhHPLWIs4cVPlbGQn2
 Cl0hQN07xRyTfr7aV8YGviMtHrWuew+N3NDgBF8qkfqH9tPT9qB8/t5FYRhrFtKwh/YY4f
 cjONvEcEI/+TrSMJIRvjPPUCeAhYxT9SexPHiUv5v/RSWIPPFevZTGVpTju21zYsgT6qku
 0bV/OXFJpGB/00SvVA/XEQV8jScjjrVKQi1EC43Eq3qcBSpNkIOmRgIhejWf/mkLkEz0gP
 rHYk1phVCn0QBTowLkFX+aDvxVTdzjug/DFud9egDFr12Necf/t+AInZU7467w==
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
Subject: [PATCH v2 14/24] mtd: rawnand: sunxi_spl: add per SoC capabilities
Date: Tue, 28 Oct 2025 10:12:35 +0100
Message-ID: <20251028091256.600992-15-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251028091256.600992-1-richard.genoud@bootlin.com>
References: <20251028091256.600992-1-richard.genoud@bootlin.com>
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
index 98fa18c4dde5..c9afc3d9f624 100644
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
@@ -222,12 +227,16 @@ static int nand_read_page(const struct nfc_config *conf, u32 offs,
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
 
@@ -391,6 +400,8 @@ static int nand_detect_config(struct nfc_config *conf, u32 offs, void *dest)
 	if (conf->valid)
 		return 0;
 
+	conf->caps = &sunxi_nfc_a10_caps;
+
 	/*
 	 * Modern NANDs are more likely than legacy ones, so we start testing
 	 * with 5 address cycles.
-- 
2.47.3

