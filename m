Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A5EECD6E4A
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 12:06:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D62A84875;
	Tue,  2 Jun 2026 14:06:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="itS7A3L/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02023848A9; Tue,  2 Jun 2026 12:28:39 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 212F6848A1
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 12:28:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 3FF19C62202;
 Tue,  2 Jun 2026 10:28:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D1391603BC;
 Tue,  2 Jun 2026 10:28:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EF2C3108883E7; 
 Tue,  2 Jun 2026 12:28:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1780396116; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=gkwUjVcY15OdkOznrrj3cbp2nooh/cgC2OaB/F7vlu8=;
 b=itS7A3L/YL+PRko5njTEB8lv3mCDisqpa6xoXYNYrzfwJbuI98CIYfJvK/P4y3ls2OF37G
 gpk4raDRFL7va63f0RRiTFdZBOP+w9UWXPMO3t1PXVbJYwQcFTnoBy+W883BQujEy8J4jB
 8sgDCqjmgIpSjCKF540Xdi6Nv4/hR5rKAiaPKHqlSnxIEiyK90aEbgHPa1/gDkfnAGzi29
 63/8TmjyReh4c+By5Y/grpkyz7+bY0Y0MmNk7Y8qLyTDTl0fP8YaqpLc3yvK9uelPJjuO1
 Rvk26Qwqvpj3AceA+UvzLY6RR1xKCymdWlcfYOFlJfYeuFxrCh5y3AfCPv1URA==
From: "Miquel Raynal (DAVE.eu)" <miquel.raynal@bootlin.com>
Date: Tue, 02 Jun 2026 12:28:30 +0200
Subject: [PATCH v2 1/5] mtd: rawnand: zynq: Align the layout structures
 with the driver namespace
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dave-upstream-nand-fixes-v2-1-412965ee38bf@bootlin.com>
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

nand_oob_16/64 are names already used in the core and it is very
misleading to reuse them here for something that is Zynq specific. It
works because the core structures are not exported, but it is bad
practice, so rename them to prefix them "zynq_" instead.

Signed-off-by: Miquel Raynal (DAVE.eu) <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/zynq_nand.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/zynq_nand.c b/drivers/mtd/nand/raw/zynq_nand.c
index ca1aff25a522..05b500d09613 100644
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
2.53.0

