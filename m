Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4951D7237B
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 11:48:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63B1A83CDF;
	Fri, 23 Jan 2026 12:46:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Gwz906P3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DF0983C5E; Fri, 23 Jan 2026 12:46:32 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E83D83CB5
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 12:46:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 45F85C1F1CA;
 Fri, 23 Jan 2026 11:46:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0DE9A6070A;
 Fri, 23 Jan 2026 11:46:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 10BA5119A87BE; Fri, 23 Jan 2026 12:46:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1769168789; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=KEY3h8rQnHeRiB0ooD/uXNSdMVEHbMN/jfzhSF2nrPI=;
 b=Gwz906P3MXhyJTa38TWCzzR3CshnJ9j4LXgCmFYNbNkzb7ZXvTFG8URUensbhomELaUIAC
 /psNwFdUWLmNZE2XW+eyO4mpzbJAe6FbH3BlhM5kpZexbPjWpM+WS0bNfPYMDaa47v+V/X
 iocZcvnLpN39WWczAu51+cW4DoBrln5vCUm+97izV3fRNSEO9WJT5ygM2de+ixKi9I2Aew
 QdSIFobRdshP1H1X39IVXAa0CxYNWH9L0yX04XO3KrbbUN/W/bkEUa3F84V1RGUuxU1gK1
 idW0L+Zc8AY/ylAmrCuk02ZY5e/ZFl11D01AEADDWyMzlh01NZxKHuJW0Eih2A==
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
Subject: [PATCH v3 19/26] mtd: rawnand: sunxi_spl: use NFC_ECC_MODE and
 NFC_RANDOM_SEED macros
Date: Fri, 23 Jan 2026 12:44:54 +0100
Message-ID: <20260123114507.1400918-20-richard.genoud@bootlin.com>
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

Use generic macros for ECC_MODE and RANDOM_SEED

As H6/H616 registers are different, use more generic macros than hard
coded values specific to A10-like SoC.

No functional changes.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand_spl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand_spl.c b/drivers/mtd/nand/raw/sunxi_nand_spl.c
index 9a6286b015d4..76458c2063ea 100644
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
@@ -237,7 +238,9 @@ static int nand_read_page(const struct nfc_config *conf, u32 offs,
 
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

