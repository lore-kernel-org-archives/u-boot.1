Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15DC2C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 13:08:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23FB884A3C;
	Thu,  2 Jul 2026 15:08:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="jUl0Gczr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 385C984A20; Thu,  2 Jul 2026 15:08:48 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C59884A1C
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 15:08:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bastien.curutchet@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id F08EA1A0DEF;
 Thu,  2 Jul 2026 13:08:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id BEE2C5FF03;
 Thu,  2 Jul 2026 13:08:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0B780104C9538; 
 Thu,  2 Jul 2026 15:08:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782997725; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=/F4Yn02qcAqX2Okh0FQk1k/qfoLBAZdxq6h6yYwuLB0=;
 b=jUl0Gczryqbv1njk93VrHOGXAv1sNfLQ53YVGUtOM9GvRQ7Zt9gr1Vzk7UBSbzfEi0Q8PZ
 j3iY7SoUdVQRrnE0IrWdzIsCt1Ik80rug7gz6aH5TdN5UZZrqdVBlLyGqmB7L+23YPFxE1
 xd0xfQocEKQWq6QZyTflOxl8lPd6N6SHjV/bqivEi5Cjq5cI31tJjwnxPfJMnBl5ywA61T
 CebBwAmNpnVJkyx5BH9weT84zsIX0E2pzlTj2TQDAxVj/E59fXD1buhOyssf1G7X5jquG7
 iTHuwnG48mPaWk13d4xgase6sR5ivZa+Wqix5XQFFnRPsO4paRPeUpgpoFWNWQ==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Thu, 02 Jul 2026 15:08:41 +0200
Subject: [PATCH v3 1/6] mtd: rawnand: zynq: Align the layout structures
 with the driver namespace
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dave-upstream-nand-fixes-v3-1-3814352982ad@bootlin.com>
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

nand_oob_16/64 are names already used in the core and it is very
misleading to reuse them here for something that is Zynq specific. It
works because the core structures are not exported, but it is bad
practice, so rename them to prefix them "zynq_" instead.

Signed-off-by: Miquel Raynal (DAVE.eu) <miquel.raynal@bootlin.com>
Signed-off-by: Bastien Curutchet (DAVE.eu) <bastien.curutchet@bootlin.com>
---
 drivers/mtd/nand/raw/zynq_nand.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/zynq_nand.c b/drivers/mtd/nand/raw/zynq_nand.c
index ca1aff25a52..05b500d0961 100644
--- a/drivers/mtd/nand/raw/zynq_nand.c
+++ b/drivers/mtd/nand/raw/zynq_nand.c
@@ -185,7 +185,7 @@ static const struct zynq_nand_command_format zynq_nand_commands[] = {
 };
 
 /* Define default oob placement schemes for large and small page devices */
-static struct nand_ecclayout nand_oob_16 = {
+static struct nand_ecclayout zynq_oob_16 = {
 	.eccbytes = 3,
 	.eccpos = {0, 1, 2},
 	.oobfree = {
@@ -193,7 +193,7 @@ static struct nand_ecclayout nand_oob_16 = {
 	}
 };
 
-static struct nand_ecclayout nand_oob_64 = {
+static struct nand_ecclayout zynq_oob_64 = {
 	.eccbytes = 12,
 	.eccpos = {
 		   52, 53, 54, 55, 56, 57,
@@ -1258,9 +1258,9 @@ static int zynq_nand_probe(struct udevice *dev)
 		}
 
 		if (mtd->oobsize == 16)
-			nand_chip->ecc.layout = &nand_oob_16;
+			nand_chip->ecc.layout = &zynq_oob_16;
 		else if (mtd->oobsize == 64)
-			nand_chip->ecc.layout = &nand_oob_64;
+			nand_chip->ecc.layout = &zynq_oob_64;
 		else
 			printf("%s: No oob layout found\n", __func__);
 	}

-- 
2.54.0

