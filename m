Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21041C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 13:09:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4E6484A20;
	Thu,  2 Jul 2026 15:08:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="L0YuqgVf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0635884A57; Thu,  2 Jul 2026 15:08:52 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2760784A0A
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 15:08:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bastien.curutchet@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id D48684E40C2E;
 Thu,  2 Jul 2026 13:08:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id AA45D5FF03;
 Thu,  2 Jul 2026 13:08:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EBA37104C952F; 
 Thu,  2 Jul 2026 15:08:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782997729; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=2rNKPUL0ZqixtQgV0b/KWN64btCM4oV5ivhZLg6v5aY=;
 b=L0YuqgVfi0GPSlGVJzXprVHDITE3T3EUUNHdFQA5Ht5qySoj6dy8tkgC2J6JOETu6/gsa2
 ids5ns0ek6ozFBEvZyRYhU3N1STZOb4SwWSCXnu1/JbOt20PvE6D45H6out6Anb8ToXx+b
 j+9G+9SkHRwdK/mS199Hp5beAwsotSZFf51893A6oYK6tbNl6UIlYpZ5n0V/oA0mtrL2zm
 VvPiIa3NxqFCHhYFAiUCnRtkVhVPQ31Oc4ahPvzHIeMAkYLR2WRLhbuF4LuN7xApefBqVp
 hI3Omm5YWQQXjxLbjbsncQYdj5jEJFqTF7PhVHA/70uPpekiLznL3oxTZCrzfQ==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Thu, 02 Jul 2026 15:08:44 +0200
Subject: [PATCH v3 4/6] mtd: rawnand: zynq: Do not fail the probe for no reason
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dave-upstream-nand-fixes-v3-4-3814352982ad@bootlin.com>
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

If there is no indication about 16b buswidth, no need to fail the probe,
just assume it is the (very standard) 8b case.

Signed-off-by: Miquel Raynal (DAVE.eu) <miquel.raynal@bootlin.com>
Signed-off-by: Bastien Curutchet (DAVE.eu) <bastien.curutchet@bootlin.com>
---
 drivers/mtd/nand/raw/zynq_nand.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/zynq_nand.c b/drivers/mtd/nand/raw/zynq_nand.c
index 54c25563072..be080cbb074 100644
--- a/drivers/mtd/nand/raw/zynq_nand.c
+++ b/drivers/mtd/nand/raw/zynq_nand.c
@@ -1134,12 +1134,6 @@ static int zynq_nand_probe(struct udevice *dev)
 	nand_chip->write_buf = zynq_nand_write_buf;
 
 	is_16bit_bw = zynq_nand_check_is_16bit_bw_flash();
-	if (is_16bit_bw == NAND_BW_UNKNOWN) {
-		printf("%s: Unable detect NAND based on MIO settings\n",
-		       __func__);
-		return -EINVAL;
-	}
-
 	if (is_16bit_bw == NAND_BW_16BIT)
 		nand_chip->options = NAND_BUSWIDTH_16;
 

-- 
2.54.0

