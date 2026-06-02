Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A861CD6E66
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 12:06:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1823184956;
	Tue,  2 Jun 2026 14:06:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="viAC8Vef";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96330848A1; Tue,  2 Jun 2026 12:28:46 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F492840CB
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 12:28:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id AB84FC6247F;
 Tue,  2 Jun 2026 10:28:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 4F4D2603BC;
 Tue,  2 Jun 2026 10:28:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8438510888429; 
 Tue,  2 Jun 2026 12:28:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1780396123; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=iJPEVSV/uyu99QKrrQojnABc4SKf7Lj76tSh63s5qIE=;
 b=viAC8VefitqfiH+GPRO1R0YEjAbO2g+AjbzrOVCDIDzLInfZV8dWzv+lq+7G0jKdh/ci5t
 lyFYx4VgvGRtamIDbMCLvQJxS+4dVhCGZwYdELcDSfbLaJUvNbpOo+TCOe4aMoCwrjkgby
 O/vSYsnSZPVqX2qPLqp2/nUTbJPgUbgczyuyMa8cyzNcN3A6XeJ3+j2eFsVH5fJhbAxdCF
 jzsh/cpHxfw5X8eXaPleaDu60Nb1smN87YTV/rc0Z7iJ4Zoie0T3RRSGCjpJGsMZR2qIWr
 oUoH6jAUDVNCrx2D9OLy+1v8U4Nh7IqA1Xy41HFgGhgVhN1Z6YaSiNeDPfeOTQ==
From: "Miquel Raynal (DAVE.eu)" <miquel.raynal@bootlin.com>
Date: Tue, 02 Jun 2026 12:28:34 +0200
Subject: [PATCH v2 5/5] mtd: rawnand: zynq: Fix Software ECC engine support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dave-upstream-nand-fixes-v2-5-412965ee38bf@bootlin.com>
References: <20260602-dave-upstream-nand-fixes-v2-0-412965ee38bf@bootlin.com>
In-Reply-To: <20260602-dave-upstream-nand-fixes-v2-0-412965ee38bf@bootlin.com>
To: u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Andrea Scian <andrea.scian@dave.eu>, Tom Rini <trini@konsulko.com>, 
 "Miquel Raynal (DAVE.eu)" <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Tue, 02 Jun 2026 14:06:02 +0200
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
Signed-off-by: Miquel Raynal (DAVE.eu) <miquel.raynal@bootlin.com>
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

