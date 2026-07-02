Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE76C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 13:09:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61F7184A4C;
	Thu,  2 Jul 2026 15:08:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="ZFlEUpQq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3275984A49; Thu,  2 Jul 2026 15:08:49 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F2F984A04
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 15:08:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bastien.curutchet@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 6716FC4FEE1;
 Thu,  2 Jul 2026 13:08:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0E0375FF03;
 Thu,  2 Jul 2026 13:08:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6950E104C9523; 
 Thu,  2 Jul 2026 15:08:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782997726; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=niI9L3BMglaZ0KmrLqzWkiOyt/9J+kRnPLnUctgy+UI=;
 b=ZFlEUpQqtVl3ZijyJ9c1nlCcduD/dIeaRZc1iq6dmEFT1/irfN1MsbyKyE0RS6G5rlyYvh
 7UlY+SBSwnhxGXcplU23dnqf8iTIZFXxJ06iFo/vBpS1v9yhRhLft51PDKyY2717ZD4KnK
 f1Eczl9bb7c2h/n7jtbTaehWId2IP9Uc04wK3qf+OvUeiYJ40bZ1Dz0vxnfm203OTS63nI
 iTURqNLhfVzu71iUXYMiF+R4c13ItBKhkLTz62g6C6Y3TRmpWR0UIolbX6QBiyEfNaCA2i
 cngmMUYf0Ez41F+eqYiL1QJ3Tn4EUV+Wz/sCfYu+tXx+BfGprq3eveJD5Zb9Nw==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Thu, 02 Jul 2026 15:08:42 +0200
Subject: [PATCH v3 2/6] mtd: rawnand: zynq: Add comments about very bad
 practices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dave-upstream-nand-fixes-v3-2-3814352982ad@bootlin.com>
References: <20260702-dave-upstream-nand-fixes-v3-0-3814352982ad@bootlin.com>
In-Reply-To: <20260702-dave-upstream-nand-fixes-v3-0-3814352982ad@bootlin.com>
To: u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Andrea Scian <andrea.scian@dave.eu>, Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 "Miquel Raynal (DAVE.eu)" <miquel.raynal@bootlin.com>, 
 "Bastien Curutchet (DAVE.eu)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
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

From: "Miquel Raynal (DAVE.eu)" <miquel.raynal@bootlin.com>

The driver goes through very (very) wrong steps during initialization as
it completely hardcodes support for Micron chips.

Flag these sections as undesirable in case someone ever cares about
fixing this properly, or simply stumbles about these pieces of code and
wonders why this is there.

Signed-off-by: Miquel Raynal (DAVE.eu) <miquel.raynal@bootlin.com>
Signed-off-by: Bastien Curutchet (DAVE.eu) <bastien.curutchet@bootlin.com>
---
 drivers/mtd/nand/raw/zynq_nand.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mtd/nand/raw/zynq_nand.c b/drivers/mtd/nand/raw/zynq_nand.c
index 05b500d0961..2d07b29ecab 100644
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
2.54.0

