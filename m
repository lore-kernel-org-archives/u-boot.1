Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3BFBE85389
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 20:12:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FB3784132;
	Fri,  3 Apr 2026 22:11:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="pgeitUCv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF617840D8; Fri,  3 Apr 2026 18:17:34 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAA57840B0
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 18:17:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 74E251A312D;
 Fri,  3 Apr 2026 16:17:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 3AE01603C1;
 Fri,  3 Apr 2026 16:17:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 447B210450102; 
 Fri,  3 Apr 2026 18:17:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1775233051; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=QUO7RVFa2vwds+YZmlKBo/ky9tqOPNc3WvnjUUvspZY=;
 b=pgeitUCvtS5jLQKlOBpGmrW0N8HUkPFKWOMNmGdbt3TnawFnkbirkbcT8qBNMGCgJDVeET
 A248ePc/HGnNzNt9dUygFY3ypnoPvU8cd18tpB87zFGGV0WbEvkhC1h8pBzgAx+K/dVVfD
 IMZBbWutt1c96tJrYJa9gloy3/N4BwDpUJ8HBe4qreDU7CbkCiaP1/+dtKgoKj1FdGh1dl
 XKxRvmdGN6MHrDz0/t8fDckCczwhQAmUvxPNcx3YKwAVsv3UWE+/OT5MNR54HQlZLHpi+t
 J6h22R2gw6uJ3YKwRqchkSScQuqN+vXJXlqApotVZOex62sCpZT3SCxqu2KKyA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 03 Apr 2026 18:17:09 +0200
Subject: [PATCH 1/3] cmd: mtd: Prevent out-of-bound check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-winbond-ma35d1-v1-1-e2b08c4c5e35@bootlin.com>
References: <20260403-winbond-ma35d1-v1-0-e2b08c4c5e35@bootlin.com>
In-Reply-To: <20260403-winbond-ma35d1-v1-0-e2b08c4c5e35@bootlin.com>
To: u-boot@lists.denx.de, Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, Steam Lin <stlin2@winbond.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Fri, 03 Apr 2026 22:11:58 +0200
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

The while() loops searching for the next "good" block is unbounded,
which means in some cases when looking close to the end of the
device (or during development purposes) this check may lead to
unexpected behaviours.

For instance, I observed the SPI NAND core complaining because there was
a single "target" (as in "die"), but the core was selecting the second
one, which is simply impossible as it does not exist.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 cmd/mtd.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/cmd/mtd.c b/cmd/mtd.c
index 7f25144098bb..d3289ab5edbf 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -559,8 +559,13 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	/* Search for the first good block after the given offset */
 	off = start_off;
-	while (mtd_block_isbad(mtd, off))
+	while (mtd_block_isbad(mtd, off)) {
 		off += mtd->erasesize;
+		if (off >= mtd->size) {
+			ret = CMD_RET_FAILURE;
+			goto out_put_mtd;
+		}
+	}
 
 	led_activity_blink();
 
@@ -573,6 +578,11 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 		if (mtd_is_aligned_with_block_size(mtd, off) &&
 		    mtd_block_isbad(mtd, off)) {
 			off += mtd->erasesize;
+			if (off >= mtd->size) {
+				ret = CMD_RET_FAILURE;
+				goto out_put_mtd;
+			}
+
 			continue;
 		}
 

-- 
2.53.0

