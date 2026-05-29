Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CF3CD6E49
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 18:43:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D72D584859;
	Fri, 29 May 2026 20:42:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="sDNV8Sw2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71513846AA; Fri, 29 May 2026 18:39:11 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9D1E846A3
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 18:39:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 3E8BA4E42D94;
 Fri, 29 May 2026 16:39:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0CFCC601FA;
 Fri, 29 May 2026 16:39:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A02CC10888CBC; 
 Fri, 29 May 2026 18:39:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1780072747; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Rs/+eBprCbYo4CgjSf5c5AYb4L8tq7JzmzC9wuTp92Y=;
 b=sDNV8Sw2QStheoJWJN/O3gMY1Wo3bNwEhcilfBsWTyvMxXlZLBYUcabyU1s55pRpJ136HF
 bgwua+xddldF8bJR73/DXXoxqFyYXOGJdrDm4ghCPKq/FmX9Q9Q02KFAYV7tfzaOjWG9C8
 j9iXzSacFyww4sBU6FgZaShCHzfFr6S4IYqVBuqnzyBsNFZFNqU7jXt3lNn62B0EYFOmjq
 9LL5AQQLRfP6RHtAuckecPy1c/VEIIkTEi0v9uFjYufAfQWgP3yrsymE76r81/X3GYtlwi
 hWjLwnHu7zyWDwD8yBBYGUzrNE3860EaB9QdTzdL9uvvtrOZsIP0fJxoTLIgBQ==
From: "Miquel Raynal (DAVE)" <miquel.raynal@bootlin.com>
Date: Fri, 29 May 2026 18:39:01 +0200
Subject: [PATCH 5/5] mtd: rawnand: zynq: Fix Software ECC engine support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-dave-upstream-nand-fixes-v1-5-e5bbddb10676@bootlin.com>
References: <20260529-dave-upstream-nand-fixes-v1-0-e5bbddb10676@bootlin.com>
In-Reply-To: <20260529-dave-upstream-nand-fixes-v1-0-e5bbddb10676@bootlin.com>
To: u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Andrea Scian <andrea.scian@dave.eu>, Tom Rini <trini@konsulko.com>, 
 "Miquel Raynal (DAVE)" <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Fri, 29 May 2026 20:42:29 +0200
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

Software ECC engine was not partially working but more importantly was
unaligned with the default software layout that has been in place for
decades due to the fact that the driver was enforcing the hardware ECC
layout (for wrong reasons). Fix the software ECC implementation, which
has the side effect of also aligning it with Linux and making the
interoperability work.

Reported-by: Andrea Scian <andrea.scian@dave.eu>
Signed-off-by: Miquel Raynal (DAVE) <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/zynq_nand.c | 88 +++++-----------------------------------
 1 file changed, 11 insertions(+), 77 deletions(-)

diff --git a/drivers/mtd/nand/raw/zynq_nand.c b/drivers/mtd/nand/raw/zynq_nand.c
index be080cbb0743..a697557c722c 100644
--- a/drivers/mtd/nand/raw/zynq_nand.c
+++ b/drivers/mtd/nand/raw/zynq_nand.c
@@ -631,34 +631,6 @@ static int zynq_nand_write_page_hwecc(struct mtd_info *mtd,
 	return 0;
 }
 
-/*
- * zynq_nand_write_page_swecc - [REPLACABLE] software ecc based page
- * write function
- * @mtd:	mtd info structure
- * @chip:	nand chip info structure
- * @buf:	data buffer
- * @oob_required: must write chip->oob_poi to OOB
- */
-static int zynq_nand_write_page_swecc(struct mtd_info *mtd,
-	struct nand_chip *chip, const u8 *buf, int oob_required, int page)
-{
-	int i, eccsize = chip->ecc.size;
-	int eccbytes = chip->ecc.bytes;
-	int eccsteps = chip->ecc.steps;
-	u8 *ecc_calc = chip->buffers->ecccalc;
-	const u8 *p = buf;
-	u32 *eccpos = chip->ecc.layout->eccpos;
-
-	/* Software ecc calculation */
-	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize)
-		chip->ecc.calculate(mtd, p, &ecc_calc[i]);
-
-	for (i = 0; i < chip->ecc.total; i++)
-		chip->oob_poi[eccpos[i]] = ecc_calc[i];
-
-	return chip->ecc.write_page_raw(mtd, chip, buf, 1, page);
-}
-
 /*
  * nand_read_page_hwecc - Hardware ECC based page read function
  * @mtd:	Pointer to the mtd info structure
@@ -736,48 +708,6 @@ static int zynq_nand_read_page_hwecc(struct mtd_info *mtd,
 	return 0;
 }
 
-/*
- * zynq_nand_read_page_swecc - [REPLACABLE] software ecc based page
- * read function
- * @mtd:	mtd info structure
- * @chip:	nand chip info structure
- * @buf:	buffer to store read data
- * @page:	page number to read
- */
-static int zynq_nand_read_page_swecc(struct mtd_info *mtd,
-	struct nand_chip *chip, u8 *buf, int oob_required,  int page)
-{
-	int i, eccsize = chip->ecc.size;
-	int eccbytes = chip->ecc.bytes;
-	int eccsteps = chip->ecc.steps;
-	u8 *p = buf;
-	u8 *ecc_calc = chip->buffers->ecccalc;
-	u8 *ecc_code = chip->buffers->ecccode;
-	u32 *eccpos = chip->ecc.layout->eccpos;
-
-	chip->ecc.read_page_raw(mtd, chip, buf, 1, page);
-
-	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize)
-		chip->ecc.calculate(mtd, p, &ecc_calc[i]);
-
-	for (i = 0; i < chip->ecc.total; i++)
-		ecc_code[i] = chip->oob_poi[eccpos[i]];
-
-	eccsteps = chip->ecc.steps;
-	p = buf;
-
-	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize) {
-		int stat;
-
-		stat = chip->ecc.correct(mtd, p, &ecc_code[i], &ecc_calc[i]);
-		if (stat < 0)
-			mtd->ecc_stats.failed++;
-		else
-			mtd->ecc_stats.corrected += stat;
-	}
-	return 0;
-}
-
 /*
  * zynq_nand_select_chip - Select the flash device
  * @mtd:	Pointer to the mtd_info structure
@@ -1219,6 +1149,16 @@ static int zynq_nand_probe(struct udevice *dev)
 		/* Use the BBT pattern descriptors */
 		nand_chip->bbt_td = &bbt_main_descr;
 		nand_chip->bbt_md = &bbt_mirror_descr;
+	} else if (nand_chip->ecc.mode == NAND_ECC_SOFT ||
+		   nand_chip->ecc.mode == NAND_ECC_SOFT_BCH ||
+		   nand_chip->ecc.mode == NAND_ECC_NONE) {
+		/* Make sure the ECC engine is off */
+		ecc_cfg = readl(&smc->reg->emcr);
+		ecc_cfg &= ~ZYNQ_MEMC_NAND_ECC_MODE_MASK;
+		writel(ecc_cfg, &smc->reg->emcr);
+
+		nand_chip->ecc.read_page_raw = zynq_nand_read_page_raw;
+		nand_chip->ecc.write_page_raw = zynq_nand_write_page_raw;
 	} else {
 		/* Hardware ECC generates 3 bytes ECC code for each 512 bytes */
 		nand_chip->ecc.mode = NAND_ECC_HW;
@@ -1255,13 +1195,7 @@ static int zynq_nand_probe(struct udevice *dev)
 			       &smc->reg->emcr);
 			break;
 		default:
-			nand_chip->ecc.mode = NAND_ECC_SOFT;
-			nand_chip->ecc.calculate = nand_calculate_ecc;
-			nand_chip->ecc.correct = nand_correct_data;
-			nand_chip->ecc.read_page = zynq_nand_read_page_swecc;
-			nand_chip->ecc.write_page = zynq_nand_write_page_swecc;
-			nand_chip->ecc.size = 256;
-			break;
+			return -EINVAL;
 		}
 
 		if (mtd->oobsize == 16)

-- 
2.53.0

