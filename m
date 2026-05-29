Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC0ACD6E49
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 18:42:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA324846E2;
	Fri, 29 May 2026 20:42:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="BJDDOn3+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C44FF846A3; Fri, 29 May 2026 18:39:06 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76096846AA
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 18:39:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id D764C1A373D;
 Fri, 29 May 2026 16:39:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id AE15C601FA;
 Fri, 29 May 2026 16:39:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4656110888CC2; 
 Fri, 29 May 2026 18:39:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1780072742; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=VylvlSkHExceFlM1rSrXJDym5wJ/EVW6gTDmUh9hzYk=;
 b=BJDDOn3+EsfODHcyRV87nnb2+1bn5ZzXzmpx+JJkUam0eGdlse6ut5PYspxwNm080VC4Rc
 X6XVCV4Mc9OtFgDTw/UGApMkjSa5cCQ9NcZ5IBBkN/g1E9g+EoUD+xXDrLXg1pQ693AOAY
 sDVWHFWZfP7uklsAj8VhPU/mHsKh7dBMnp0UfjkBGLqamHYqcRELAO0BZQsfthem6B6fpB
 ldfdpSKRreHmF/tMv+gf2T8SOs8EbnGkDnW1K69+DGwOi0Dc6MK8LHaDFkfWxUmTMQOUAX
 cjVOuKkWTAiQcYeTK8P48MzDOxrh7OyVxoek2a0ca/cQ5ibgKBDvf3FYq+P3+g==
From: "Miquel Raynal (DAVE)" <miquel.raynal@bootlin.com>
Date: Fri, 29 May 2026 18:38:57 +0200
Subject: [PATCH 1/5] mtd: rawnand: zynq: Align the layout structures with
 the driver namespace
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-dave-upstream-nand-fixes-v1-1-e5bbddb10676@bootlin.com>
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

nand_oob_16/64 are names already used in the core and it is very
misleading to reuse them here for something that is Zynq specific. It
works because the core structures are not exported, but it is bad
practice, so rename them to prefix them "zynq_" instead.

Signed-off-by: Miquel Raynal (DAVE) <miquel.raynal@bootlin.com>
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

