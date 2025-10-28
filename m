Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5ADCCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 09:16:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6A4183AED;
	Tue, 28 Oct 2025 10:14:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="B6MAtuZo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1394983ACA; Tue, 28 Oct 2025 10:14:29 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3558E83AA0
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 10:14:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id DBB934E41392;
 Tue, 28 Oct 2025 09:14:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B1E7D606AB;
 Tue, 28 Oct 2025 09:14:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BF1D4102F4A82; Tue, 28 Oct 2025 10:14:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1761642864; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=by17oOHjNLw/DEghdKpM0lYmtPJFWBJ35nYrWdihmzo=;
 b=B6MAtuZodtmOcdOL2yVzEDnMM+BV95e8R1JSA1OiQDi06NZE0jHR0c/wULAwtWGU/9yQas
 PSduaB4sIMrCNbHvD9WqQ3C5R2Z19jkWFtcHODJHazQ9fdbIwiXr7euiVkhQ567tueuvQP
 rdiDAPLojc3t20YBUtV/X73NMrWNiE5Lqcq2JTrOX1/8hIYFQ7IqARSPEZyVr3J4OIJQg8
 VqfIb756TgzGBqZrkHcLuIFRugvNPQRTohRTmHxWccLhXscPS8/uvg4Qcyy4PRg2P0zUV8
 R+MBvrDMqRfvlr5xvDuV/+MeQS0HWCY58HMN7+5HgzN9BCpOc9yWu6wIqmcV+w==
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
Subject: [PATCH v2 19/24] mtd: rawnand: sunxi_spl: use NFC_ECC_MODE and
 NFC_RANDOM_SEED macros
Date: Tue, 28 Oct 2025 10:12:40 +0100
Message-ID: <20251028091256.600992-20-richard.genoud@bootlin.com>
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

Use generic macros for ECC_MODE and RANDOM_SEED

As H6/H616 registers are different, use more generic macros than hard
coded values specific to A10-like SoC.

No functional changes.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand_spl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand_spl.c b/drivers/mtd/nand/raw/sunxi_nand_spl.c
index 786c46254838..8c80a3085bc1 100644
--- a/drivers/mtd/nand/raw/sunxi_nand_spl.c
+++ b/drivers/mtd/nand/raw/sunxi_nand_spl.c
@@ -57,6 +57,7 @@ __maybe_unused static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
 	.reg_spare_area = NFC_REG_A10_SPARE_AREA,
 	.reg_pat_found = NFC_REG_ECC_ST,
 	.pat_found_mask = GENMASK(31, 16),
+	.ecc_mode_mask = GENMASK(15, 12),
 	.ecc_err_mask = GENMASK(15, 0),
 	.random_en_mask = BIT(9),
 };
@@ -239,7 +240,9 @@ static int nand_read_page(const struct nfc_config *conf, u32 offs,
 
 		/* Clear ECC status and restart ECC engine */
 		writel(0, SUNXI_NFC_BASE + NFC_REG_ECC_ST);
-		writel((rand_seed << 16) | (conf->ecc_strength << 12) |
+
+		writel(NFC_RANDOM_SEED(rand_seed) |
+		       NFC_ECC_MODE(conf, conf->ecc_strength) |
 		       (conf->randomize ? NFC_RANDOM_EN(conf) : 0) |
 		       ecc512_bit |
 		       NFC_ECC_EN | NFC_ECC_EXCEPTION,
-- 
2.47.3

