Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA0AC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 20:43:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DED09885F1;
	Thu, 18 Jul 2024 22:43:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nA4pUyRD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E35A88867B; Thu, 18 Jul 2024 22:43:08 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C928088548
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 22:43:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id C7BE3CE1A98;
 Thu, 18 Jul 2024 20:43:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B2EC116B1;
 Thu, 18 Jul 2024 20:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1721335384;
 bh=GG8kGg1waVqAQntOfuA09Iq3U9LqMwz5vXdU7VQnhY0=;
 h=From:To:Cc:Subject:Date:From;
 b=nA4pUyRDnWUiLyawieizjN20tuNZiyr/9IJuQKEPK9K59lQIh2FMQvSF21HR8LZe5
 O7DUsCG+nQnxwHArk6OJZpIpPboeFtTIQh0HzHvgrHlDZFNdp+yxV2cxD7gqs9QAHR
 eQh67mmzSeD/BIgHQOvwkI9AsKEGp6VEaVvVyzm4wuH0cctUjQazWqa9MTqjhQt5vY
 D82lo539v3h05LEVAWPtw2aI1M/8xtdsVugMtvRhaD3R1wbcAb/liUafnlUgX3OzwB
 lPj46u2zoN6L33lcihqZgRoIEYlbG8yT8YcHVS04PyYDGN4xXzxhqMJSaTl7gsLtgj
 /bQsHLlUfC6IQ==
From: Michael Walle <mwalle@kernel.org>
To: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH v2 1/2] spi: sunxi: fix CDR2 calculation
Date: Thu, 18 Jul 2024 22:42:52 +0200
Message-Id: <20240718204253.1180233-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The CDR2 divider calculation always yield a frequency greater than the
requested one. Use DIV_ROUND_UP() to keep the frequency equal or below
the requested one. This way, we can also drop the "if div > 0" check
because we know for a fact that div cannot be zero.

FWIW, this aligns the CDR2 calculation with the linux driver.

Suggested-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/spi/spi-sunxi.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-sunxi.c b/drivers/spi/spi-sunxi.c
index bfb402902b8..f110a8b7658 100644
--- a/drivers/spi/spi-sunxi.c
+++ b/drivers/spi/spi-sunxi.c
@@ -233,7 +233,7 @@ err_ahb:
 static void sun4i_spi_set_speed_mode(struct udevice *dev)
 {
 	struct sun4i_spi_priv *priv = dev_get_priv(dev);
-	unsigned int div;
+	unsigned int div, div_cdr2;
 	u32 reg;
 
 	/*
@@ -259,15 +259,12 @@ static void sun4i_spi_set_speed_mode(struct udevice *dev)
 	 */
 
 	div = DIV_ROUND_UP(SUNXI_INPUT_CLOCK, priv->freq);
+	div_cdr2 = DIV_ROUND_UP(div, 2);
 	reg = readl(SPI_REG(priv, SPI_CCR));
 
-	if ((div / 2) <= (SUN4I_CLK_CTL_CDR2_MASK + 1)) {
-		div /= 2;
-		if (div > 0)
-			div--;
-
+	if (div_cdr2 <= (SUN4I_CLK_CTL_CDR2_MASK + 1)) {
 		reg &= ~(SUN4I_CLK_CTL_CDR2_MASK | SUN4I_CLK_CTL_DRS);
-		reg |= SUN4I_CLK_CTL_CDR2(div) | SUN4I_CLK_CTL_DRS;
+		reg |= SUN4I_CLK_CTL_CDR2(div_cdr2 - 1) | SUN4I_CLK_CTL_DRS;
 	} else {
 		div = fls(div - 1);
 		/* The F1C100s encodes the divider as 2^(n+1) */
-- 
2.39.2

