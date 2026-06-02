Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9336CCD6E60
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 12:06:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1A6A84944;
	Tue,  2 Jun 2026 14:06:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="yM+z4jAr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A145840CB; Tue,  2 Jun 2026 12:28:44 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 702B2840CB
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 12:28:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 8DCE0C62202;
 Tue,  2 Jun 2026 10:28:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 30024603BC;
 Tue,  2 Jun 2026 10:28:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7DA0B1088838A; 
 Tue,  2 Jun 2026 12:28:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1780396121; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=m0u5G/4i9embASET237ZG2eNUflS7aRYFa8hamboa7U=;
 b=yM+z4jAr2YxwSykKVafBpVo0bIf9iOWJ3dGHKNdyGeo0/jFysAAtu0SsS/liA6jKbuvPVt
 73NaZl/hG4djw27EGpcsRHRKxp6JNFcnqXaRshiaSQtc/km9p/2N38/tdEYXkzqqJHnHZQ
 RgbYdtlmm/anDx1aMzSyhCReDafuHg9dD6yH2i82BDSpNf6n6JHpPcryTdCYmXRmB9GPg9
 vEsAneQIhR/aw+/iVTxzrN/032IVSpq1sRJ2/RXESB8vVDlbZnuyHhDAHoTJ3eAP6TbyST
 eSwQKsXySC1aRwyk6CXCK037HVzwvQGa4Imd47RmW5gclyWAwVOAapiEfiqygQ==
From: "Miquel Raynal (DAVE.eu)" <miquel.raynal@bootlin.com>
Date: Tue, 02 Jun 2026 12:28:33 +0200
Subject: [PATCH v2 4/5] mtd: rawnand: zynq: Do not fail the probe for no reason
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dave-upstream-nand-fixes-v2-4-412965ee38bf@bootlin.com>
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

If there is no indication about 16b buswidth, no need to fail the probe,
just assume it is the (very standard) 8b case.

Signed-off-by: Miquel Raynal (DAVE.eu) <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/zynq_nand.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/zynq_nand.c b/drivers/mtd/nand/raw/zynq_nand.c
index 54c255630724..be080cbb0743 100644
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
2.53.0

