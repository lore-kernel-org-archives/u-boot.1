Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF63CD6E49
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 18:42:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 041D7846FD;
	Fri, 29 May 2026 20:42:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="mhoOAt5x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E67F846A3; Fri, 29 May 2026 18:39:08 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFB41846E6
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 18:39:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 445A54E42D92;
 Fri, 29 May 2026 16:39:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 17C9C601FA;
 Fri, 29 May 2026 16:39:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8D6B410888CBC; 
 Fri, 29 May 2026 18:39:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1780072743; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=GikB0QUBAZO4nLeuxnxYRs7w/Wr2G2gExPW58tDPkag=;
 b=mhoOAt5x+x1N4vPcqr1DQ3lWGNiZSbSOu0CbnC0ugLA6THBOtVOEbMVx9spqlQ+el2aVxp
 jwd8BbBzb/a221JR8M9mh/7gZrIf5MOqzoL1VWjmeKQL89Smd6KOCChE1umvfCsrhjfkIP
 pMneA/ZpfRaH4B6IPrtBcgIz6h2L+8mdADLpC7fOCX2pFB+H+6oos5meCfPqi04bvCfTYj
 ZA2YSvwfZDniaJtfiSQbzyMwG83k+f3RfSB4/bwhRu+X0Uz+UzmwHoKPmJwCFWjczIt5wI
 v8OYQZBJ/3DfTaranF5EhvfLIH7BP2RtjSqlw/JJk6KzRgPewAI1KYq/tHUApA==
From: "Miquel Raynal (DAVE)" <miquel.raynal@bootlin.com>
Date: Fri, 29 May 2026 18:38:58 +0200
Subject: [PATCH 2/5] mtd: rawnand: zynq: Add comments about very bad practices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-dave-upstream-nand-fixes-v1-2-e5bbddb10676@bootlin.com>
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

The driver goes through very (very) wrong steps during initialization as
it completely hardcodes support for Micron chips.

Flag these sections as undesirable in case someone ever cares about
fixing this properly, or simply stumbles about these pieces of code and
wonders why this is there.

Signed-off-by: Miquel Raynal (DAVE) <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/zynq_nand.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mtd/nand/raw/zynq_nand.c b/drivers/mtd/nand/raw/zynq_nand.c
index 05b500d09613..2d07b29ecabd 100644
--- a/drivers/mtd/nand/raw/zynq_nand.c
+++ b/drivers/mtd/nand/raw/zynq_nand.c
@@ -203,6 +203,10 @@ static struct nand_ecclayout zynq_oob_64 = {
 	}
 };
 
+/*
+ * FIXME: This is a very (Micron) specific layout, which should not reside at
+ * the spi/ level.
+ */
 static struct nand_ecclayout ondie_nand_oob_64 = {
 	.eccbytes = 32,
 
@@ -1155,6 +1159,10 @@ static int zynq_nand_probe(struct udevice *dev)
 	maf_id = nand_chip->read_byte(mtd);
 	dev_id = nand_chip->read_byte(mtd);
 
+	/*
+	 * FIXME: This is horribly wrong, it checks if Micron chips have on-die
+	 * ECC support enabled. This should be moved away.
+	 */
 	if ((maf_id == 0x2c) && ((dev_id == 0xf1) ||
 				 (dev_id == 0xa1) || (dev_id == 0xb1) ||
 				 (dev_id == 0xaa) || (dev_id == 0xba) ||

-- 
2.53.0

