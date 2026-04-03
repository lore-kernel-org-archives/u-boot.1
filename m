Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62EDE85389
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 20:12:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CE8884159;
	Fri,  3 Apr 2026 22:12:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="sGu9fBQu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7926840D8; Fri,  3 Apr 2026 18:17:39 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1744840B0
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 18:17:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 96C1A1A312C;
 Fri,  3 Apr 2026 16:17:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 6D8AB603C1;
 Fri,  3 Apr 2026 16:17:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5E7A9104500FA; 
 Fri,  3 Apr 2026 18:17:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1775233056; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=gQcHQJoz24TyUAw4tN/RD2C66izTzhrqFZzYFIUF/ig=;
 b=sGu9fBQutTS5UTjca4dNmEJJtwIeOqdc+zbPoQKTwLKLjbczjWYXP3qHtBOuHE7Eb8Kf9S
 rY5bPLMJfNeYaeRA3Y9HOsBUDKginf3QhHpH7qN6SD0VEWo8EwguB7tGNUBVIx8PcZ2wfa
 TKRLrKHZ4EBcOcztVAAwIpKw6PDicalybdpo91WY+4xggp9RThLbOwc/O/brLJG8fffYW4
 psESNImynwjPvesShZxnE5ePBjHrFmAYxCagBCwKXF2G0+ADQDpHXbR8tGe8ViDyNpDTZ2
 Edmt+eI3BoTLhlsjt3MYT/x1xi34Kgp+rTVlQktV67nzgrqiT9BdM6ve6kdEjw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 03 Apr 2026 18:17:11 +0200
Subject: [PATCH 3/3] mtd: spinand: winbond: Clarify when to enable the HS bit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-winbond-ma35d1-v1-3-e2b08c4c5e35@bootlin.com>
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

Above 104MHz when in fast dual or quad I/O reads, the delay between
address and data cycles is too short. It is possible to reach higher
frequencies, up to 166MHz, by adding a few more dummy cycles through the
setting of the HS bit. Improve the condition for enabling this bit, and
also make sure we set it at soon as we go over 104MHz.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
This is a port from Linux.
---
 drivers/mtd/nand/spi/winbond.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 79c3354efb65..accb46dfeb03 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -261,16 +261,19 @@ static int w25n0xjw_hs_cfg(struct spinand_device *spinand)
 	u8 sr4;
 	int ret;
 
+	/*
+	 * SDR dual and quad I/O operations over 104MHz require the HS bit to
+	 * enable a few more dummy cycles.
+	 */
 	op = spinand->op_templates.read_cache;
 	if (op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr)
 		hs = false;
-	else if (op->cmd.buswidth == 1 && op->addr.buswidth == 1 &&
-		 op->dummy.buswidth == 1 && op->data.buswidth == 1)
+	else if (op->cmd.buswidth != 1 || op->addr.buswidth != 1)
+		hs = false;
+	else if (op->max_freq && op->max_freq <= 104 * HZ_PER_MHZ)
 		hs = false;
-	else if (!op->max_freq)
-		hs = true;
 	else
-		hs = false;
+		hs = true;
 
 	ret = spinand_read_reg_op(spinand, W25N0XJW_SR4, &sr4);
 	if (ret)

-- 
2.53.0

