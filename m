Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 735C3ECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 12:57:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7C84890B1;
	Tue, 10 Sep 2024 14:56:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="ZhljU6VI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D418088F71; Tue, 10 Sep 2024 11:16:27 +0200 (CEST)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFD6B88F6F
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:16:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bastien.curutchet@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 97DD0240004;
 Tue, 10 Sep 2024 09:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1725959778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=dtNGLU35uHqRhtq2T6AsPJ/PHc3n6SHvQJud6Vas9vs=;
 b=ZhljU6VI2N81DnEDiwXgP19dx+yBzAKCKHQmAMMq1x2SX1tue81ms7yh+q9WDDCZlVGxvk
 hqn2GNywdEds5eo02/7D6BbZrTl4jW2hKP/sgjIkbji2Mqrj0ehuwmiw2gWbCY5IGJSckl
 ng756Bb0WNYKw8AkS9U3XVo92D9bMw+hCe44PMm1oxsL++BVxRi2acfplZ8QF8+xQCQ0Ua
 FGTMrvMmcyzWAv9i/QlXfibhaeluMiiRpXy0HWTUh5Kp1hFjt4vxSY9v+Xk8U8wYMVnC6S
 ZdoTbBso4xBi12jh8uW/BfbzXBjGqGh2XgWdYjUfXK9E0JK5NDn5pOOgnIeVUg==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
	Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Christopher Cordahi <christophercordahi@nanometrics.ca>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: [PATCH] spi: davinci: Drop the preload of TX buffer before
 read/writes operations
Date: Tue, 10 Sep 2024 11:16:16 +0200
Message-ID: <20240910091616.61047-1-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com
X-Mailman-Approved-At: Tue, 10 Sep 2024 14:56:36 +0200
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

