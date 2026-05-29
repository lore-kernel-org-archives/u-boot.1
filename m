Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D294CD6E49
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 18:43:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90BDC84839;
	Fri, 29 May 2026 20:42:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Vl98KYu+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E29D846AA; Fri, 29 May 2026 18:39:09 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72AF4846FA
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 18:39:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id F3DD21A373C;
 Fri, 29 May 2026 16:39:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C9675601FA;
 Fri, 29 May 2026 16:39:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 74F4910888CC2; 
 Fri, 29 May 2026 18:39:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1780072746; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Gwt8/xYqre8nkc+PkTfvGW6pDaqj8ouWMtcBgVQtUzU=;
 b=Vl98KYu+84qLk8P5BCzgT5x25pUb8lCAnsddjjCOQaW0K8kUWWvW6zh0Xr8rEApLnWABPs
 ypVL3N7M+dQMLGqupM3Of5OHWssgeE45vgLTt879tLA5w6a+cWcrB+7fPEPDAsQqD5rCo1
 kdvCkuLsOTv9AfH1VanjT4JIuza1FiJTCrUgOqETfqsZm1/DnDrN3CuvzCW1Q1XlDQ4Tim
 VDUM4HOIYPS8D6FF4ABsSDCLcaLuWSkioCV7fQJppz6vy2O3gTqgujIOM/m/f+gJ4oh00f
 65XwC7yV8kHmG5grfknbGyEXRmP03wpoUKvpoRuxMBXfzKPpn1GMlPUM+VSSrw==
From: "Miquel Raynal (DAVE)" <miquel.raynal@bootlin.com>
Date: Fri, 29 May 2026 18:39:00 +0200
Subject: [PATCH 4/5] mtd: rawnand: zynq: Do not fail the probe for no
 reason
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-dave-upstream-nand-fixes-v1-4-e5bbddb10676@bootlin.com>
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

If there is no indication about 16b buswidth, no need to fail the probe,
just assume it is the (very standard) 8b case.

Signed-off-by: Miquel Raynal (DAVE) <miquel.raynal@bootlin.com>
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

