Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29808CF58F4
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 09:16:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A9AC89434;
	Fri, 20 Sep 2024 11:15:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="DzUqEHAi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2D8789386; Fri, 20 Sep 2024 10:28:11 +0200 (CEST)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
 [217.70.183.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6DED89379
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 10:28:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bastien.curutchet@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id ED4C0240002;
 Fri, 20 Sep 2024 08:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1726820889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=dtNGLU35uHqRhtq2T6AsPJ/PHc3n6SHvQJud6Vas9vs=;
 b=DzUqEHAiCxeijt8htt711eG9uh9+tWTT9daLBcX8K/K/+yrGxFy9/RoY/IXN33x6Ucautq
 +Gwa1/6Se17dQ0M8lnhUxQFUq+iNS11qHyoT/Zgb6zt520f/COh7sDDlqoRap4gCq9n2pR
 ZKdcJo6gIni3EC6yeMQkMPX5a77jsuqdhvXxg4QmdTrJQVISdxooaHdpCzCYAzk8wq2jTS
 LJR4bADBO21Duh+xoBm5xlLet8iQzr/oLqhsC9Q4yfz8NgwLQvZE0ue+kGeW0FEo0Ju9q7
 TSn3nrd6knqKahWgTAn1RwGc8Jls6cWXaQabUeqyjk02xSEUIEXSQqEjT8tFSg==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
	Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Christopher Cordahi <christophercordahi@nanometrics.ca>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: [PATCH] spi: davinci: Drop the preload of TX buffer before
 read/writes operations
Date: Fri, 20 Sep 2024 10:28:06 +0200
Message-ID: <20240920082806.74253-1-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com
X-Mailman-Approved-At: Fri, 20 Sep 2024 11:15:35 +0200
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

A write to the TX buffer is performed before entering the loop to "avoid
clock starvation". This sometimes results in subsequent writes in
davinci_spi_xfer_data() to occur while the TXFULL bit is asserted,
leading to write failures.

Remove the preload of the TX buffer.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
Hi all,

I've ran into write failures to flash on my platform based on the
DAVINCI/OMAP L138. This patch fixes it.

 drivers/spi/davinci_spi.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index 25f5e9fdeb..07c46b8b66 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -129,9 +129,6 @@ static int davinci_spi_read(struct davinci_spi_slave *ds, unsigned int len,
 	while (readl(&ds->regs->buf) & SPIBUF_TXFULL_MASK)
 		;
 
-	/* preload the TX buffer to avoid clock starvation */
-	writel(data1_reg_val, &ds->regs->dat1);
-
 	/* keep reading 1 byte until only 1 byte left */
 	while ((len--) > 1)
 		*rxp++ = davinci_spi_xfer_data(ds, data1_reg_val);
@@ -159,12 +156,6 @@ static int davinci_spi_write(struct davinci_spi_slave *ds, unsigned int len,
 	while (readl(&ds->regs->buf) & SPIBUF_TXFULL_MASK)
 		;
 
-	/* preload the TX buffer to avoid clock starvation */
-	if (len > 2) {
-		writel(data1_reg_val | *txp++, &ds->regs->dat1);
-		len--;
-	}
-
 	/* keep writing 1 byte until only 1 byte left */
 	while ((len--) > 1)
 		davinci_spi_xfer_data(ds, data1_reg_val | *txp++);
-- 
2.46.0

