Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC17FD7236C
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 11:47:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20B1683C51;
	Fri, 23 Jan 2026 12:46:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="EmMye/of";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F3DB83C72; Fri, 23 Jan 2026 12:46:20 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29B9183C4B
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 12:46:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id D2D6F1A2B4C;
 Fri, 23 Jan 2026 11:46:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 9D7A66070A;
 Fri, 23 Jan 2026 11:46:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5E08C119A87BE; Fri, 23 Jan 2026 12:46:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1769168776; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=86VPIpZ7oVS5fF32jLzWT4xL718MeG2ZJN85x7qq1Cw=;
 b=EmMye/ofZju0owKNe5dQe2EKj+nSELpb6lsyAoz2f4X3DlzgmCeW2BxilvFrui4SCoxItc
 y5vw8AGmo3HqNnyQHgd/LoxrmcNn2OmwOprXuI9ynCJ5ZHlaOc/QCaxIdgiJE6XBxFjMmm
 /OU33JVYHOzxEQzFSvPyP3Yb92odG6ExisctqHdLWz7rVYDWzbRiIVsc6W8LyKZrVH4U37
 pojtN3Kn30/Ob9U0+nR0WTu8x+NY8B2RdWKsst0CprwgPXKt79ulRKwd6sRgXkIt2vrnNu
 C9VKt89EuLDickOmX1ZG/QmIhrFUZgjKaw8ubn50lyJM7vWD9VLMSrlgej5MEA==
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
Subject: [PATCH v3 14/26] mtd: rawnand: sunxi_spl: add per SoC capabilities
Date: Fri, 23 Jan 2026 12:44:49 +0100
Message-ID: <20260123114507.1400918-15-richard.genoud@bootlin.com>
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
index 909c846e0207..035b224bb437 100644
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
@@ -220,12 +225,16 @@ static int nand_read_page(const struct nfc_config *conf, u32 offs,
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
 
@@ -389,6 +398,8 @@ static int nand_detect_config(struct nfc_config *conf, u32 offs, void *dest)
 	if (conf->valid)
 		return 0;
 
+	conf->caps = &sunxi_nfc_a10_caps;
+
 	/*
 	 * Modern NANDs are more likely than legacy ones, so we start testing
 	 * with 5 address cycles.
-- 
2.47.3

