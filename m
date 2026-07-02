Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62DA6C43602
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 13:09:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A65984A3A;
	Thu,  2 Jul 2026 15:08:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="D+W8NLE0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA4F584A51; Thu,  2 Jul 2026 15:08:50 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6DEC84A20
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 15:08:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bastien.curutchet@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 7402E4E40C31;
 Thu,  2 Jul 2026 13:08:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 498D95FF03;
 Thu,  2 Jul 2026 13:08:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id AE9D6104C953E; 
 Thu,  2 Jul 2026 15:08:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782997727; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=wK/T6dieYLfbzBdQYR9gFYCyQvVv3B/1LOV+Db90iKM=;
 b=D+W8NLE0XFrTW6YbMsNgL4XqTOy3/3trTmAoJA9BC/BmjcHZU5GtHmNJpGO+j/cuDOu/Y4
 EfSS0rt/IP4N+3nfxs5J8o4YYRmahHkUgOXr2F3Gjxanf0MaH77gleX1f5JLIdMGZbcbZV
 tBwAL5mob8JPsCf3OwHTb3SeuIWK/01nf+y0rI8WJCZT0fu7hnrzf1oyR9oGQA4PMVVZvu
 N94XbJzrPUZpTLGGJOzCusgxEII979Irvuyj8OoD+U+zWH588x3uTCW2pqkx2+EgaClQnY
 dPeq9rHwJyPVi5C2qDErdcRQaQvTKtK7N+N7fU6nV7mbusVreJ75ofDgxsQuKg==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Thu, 02 Jul 2026 15:08:43 +0200
Subject: [PATCH v3 3/6] mtd: rawnand: zynq: Make sure an of node is
 attached
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dave-upstream-nand-fixes-v3-3-3814352982ad@bootlin.com>
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

If no ofnode is attached by the controller driver, DT parsing does not
happen.

Signed-off-by: Miquel Raynal (DAVE.eu) <miquel.raynal@bootlin.com>
Signed-off-by: Bastien Curutchet (DAVE.eu) <bastien.curutchet@bootlin.com>
---
 drivers/mtd/nand/raw/zynq_nand.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/nand/raw/zynq_nand.c b/drivers/mtd/nand/raw/zynq_nand.c
index 2d07b29ecab..54c25563072 100644
--- a/drivers/mtd/nand/raw/zynq_nand.c
+++ b/drivers/mtd/nand/raw/zynq_nand.c
@@ -1103,6 +1103,11 @@ static int zynq_nand_probe(struct udevice *dev)
 		return dm_scan_fdt_dev(dev);
 	}
 
+	if (!ofnode_get_child_count(of_nand))
+		nand_set_flash_node(nand_chip, of_nand);
+	else
+		nand_set_flash_node(nand_chip, ofnode_first_subnode(of_nand));
+
 	if (ofnode_read_resource(of_nand, 0, &res)) {
 		printf("Failed to get nand resource\n");
 		return -ENODEV;

-- 
2.54.0

