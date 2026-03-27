Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F65610ED67C
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 14:06:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CAD983C14;
	Fri, 27 Mar 2026 15:05:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="m8MzCdTp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC8AF83FE9; Fri, 27 Mar 2026 15:05:39 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8349D83DA7
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 15:05:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 0BF154E4282B;
 Fri, 27 Mar 2026 14:05:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id CF31060230;
 Fri, 27 Mar 2026 14:05:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EC01010451269; Fri, 27 Mar 2026 15:05:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774620336; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=Z7iIlbzbNAkOYN2yvM6AfIsi74NeXG3jjpKWdMs4gDQ=;
 b=m8MzCdTpXa0o7uZn7Fy2/AQcu2ihxYRkt58Aky+Zagn7kVvfwkpDCjc8rHduFgU/Q+JTxm
 ad7qMy4sLOoHWfJ35ATgi6OVk5Tb2vGTuJc8jZy66P04kJ215An7HJgrBpNNfMZwHLIvB+
 NsSK+F8PbiXZGz5+T9+72NOrj6gLd1p6qZz8MAKua4x2eOGz8W4tuynZy3npXSUOUChwqL
 uJW1vq5ICqksFVFU207rqVeZAqKl3Xxfn5UwiOgLnemmYK9s5USVp4LlbuylD/sRxv0L6P
 I94/faWRXmpKvjmQt06KELrqRbXDs+yDi7VaE5OIT/p2kImAhFPgY9rW3oQAjQ==
From: Richard Genoud <richard.genoud@bootlin.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Boris Brezillon <bbrezillon@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de,
 Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH v2 3/5] mtd: rawnand: sunxi: clean sunxi_nand_chip_init()
Date: Fri, 27 Mar 2026 15:05:06 +0100
Message-ID: <20260327140508.3680105-4-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327140508.3680105-1-richard.genoud@bootlin.com>
References: <20260327140508.3680105-1-richard.genoud@bootlin.com>
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

In sunxi_nand_chip_init there's quite a lot of kfree/return, it's easy
to forget a kfree(), so use a goto/kfree instead.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 41 ++++++++++++++-----------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 9fc9bc5e0198..ecab9ebc9576 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1600,21 +1600,20 @@ static int sunxi_nand_chip_init(struct udevice *dev, struct sunxi_nfc *nfc,
 		if (ret) {
 			dev_err(dev, "could not retrieve reg property: %d\n",
 				ret);
-			kfree(chip);
-			return ret;
+			goto out;
 		}
 
 		if (tmp > NFC_MAX_CS) {
 			dev_err(dev,
 				"invalid reg value: %u (max CS = 7)\n", tmp);
-			kfree(chip);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out;
 		}
 
 		if (test_and_set_bit(tmp, &nfc->assigned_cs)) {
 			dev_err(dev, "CS %d already assigned\n", tmp);
-			kfree(chip);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out;
 		}
 
 		chip->sels[i].cs = tmp;
@@ -1640,15 +1639,13 @@ static int sunxi_nand_chip_init(struct udevice *dev, struct sunxi_nfc *nfc,
 		dev_err(dev,
 			"could not retrieve timings for ONFI mode 0: %d\n",
 			ret);
-		kfree(chip);
-		return ret;
+		goto out;
 	}
 
 	ret = sunxi_nand_chip_set_timings(nfc, chip, timings);
 	if (ret) {
 		dev_err(dev, "could not configure chip timings: %d\n", ret);
-		kfree(chip);
-		return ret;
+		goto out;
 	}
 
 	nand = &chip->nand;
@@ -1669,10 +1666,8 @@ static int sunxi_nand_chip_init(struct udevice *dev, struct sunxi_nfc *nfc,
 
 	mtd = nand_to_mtd(nand);
 	ret = nand_scan_ident(mtd, nsels, NULL);
-	if (ret) {
-		kfree(chip);
-		return ret;
-	}
+	if (ret)
+		goto out;
 
 	if (nand->bbt_options & NAND_BBT_USE_FLASH)
 		nand->bbt_options |= NAND_BBT_NO_OOB;
@@ -1685,34 +1680,34 @@ static int sunxi_nand_chip_init(struct udevice *dev, struct sunxi_nfc *nfc,
 	ret = sunxi_nand_chip_init_timings(nfc, chip);
 	if (ret) {
 		dev_err(dev, "could not configure chip timings: %d\n", ret);
-		kfree(chip);
-		return ret;
+		goto out;
 	}
 
 	ret = sunxi_nand_ecc_init(mtd, &nand->ecc);
 	if (ret) {
 		dev_err(dev, "ECC init failed: %d\n", ret);
-		kfree(chip);
-		return ret;
+		goto out;
 	}
 
 	ret = nand_scan_tail(mtd);
 	if (ret) {
 		dev_err(dev, "nand_scan_tail failed: %d\n", ret);
-		kfree(chip);
-		return ret;
+		goto out;
 	}
 
 	ret = nand_register(devnum, mtd);
 	if (ret) {
 		dev_err(dev, "failed to register mtd device: %d\n", ret);
-		kfree(chip);
-		return ret;
+		goto out;
 	}
 
 	list_add_tail(&chip->node, &nfc->chips);
 
-	return 0;
+out:
+	if (ret)
+		kfree(chip);
+
+	return ret;
 }
 
 static int sunxi_nand_chips_init(struct udevice *dev, struct sunxi_nfc *nfc)
