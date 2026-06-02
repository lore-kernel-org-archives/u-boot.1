Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FBCCD6E60
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 12:06:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A359848F5;
	Tue,  2 Jun 2026 14:06:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="WQytdfcC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F156848A1; Tue,  2 Jun 2026 12:28:40 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9D39840CB
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 12:28:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id C2AB3C62209;
 Tue,  2 Jun 2026 10:28:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 65C29603BC;
 Tue,  2 Jun 2026 10:28:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BF6A41088838A; 
 Tue,  2 Jun 2026 12:28:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1780396117; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=8wLPlgRJrJSWz2W2r/Ky7GlEdAb9sNg0KrtypPGcDRY=;
 b=WQytdfcCn/mBGX7tgtxlcaQxAEJoeTlYDv2fC6v8PsKslQv7sF7ylNw2xiZyh48JbNPpLs
 JJ3dzKMS0M9yD6gNluFLTGBqAONec3Kecps0KxTzjtrMdvJ2Zgd0SqFewhHg7NQMChaL1M
 v4UinC8H+sjUqNc/unvz6sakbKsXOWgXqgdjez1B/4v9eSksGA0ycVSQgHXaK1ImMOS0jU
 vjTBfjIJvvYbDA2pma61/EM3HrUprRrOcDKCSaQaDHIFtWdyh+qMexCmbx+Ih9hP0nrvZs
 wx0iX7XcBgYFh8e8J+RClz5Yz50KmXIXn3HMA5jkqdaAH4ORSC/MZELhnLAE0A==
From: "Miquel Raynal (DAVE.eu)" <miquel.raynal@bootlin.com>
Date: Tue, 02 Jun 2026 12:28:31 +0200
Subject: [PATCH v2 2/5] mtd: rawnand: zynq: Add comments about very bad
 practices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dave-upstream-nand-fixes-v2-2-412965ee38bf@bootlin.com>
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

The driver goes through very (very) wrong steps during initialization as
it completely hardcodes support for Micron chips.

Flag these sections as undesirable in case someone ever cares about
fixing this properly, or simply stumbles about these pieces of code and
wonders why this is there.

Signed-off-by: Miquel Raynal (DAVE.eu) <miquel.raynal@bootlin.com>
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

