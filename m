Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87450C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 17:15:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D464887E3;
	Fri, 12 Jul 2024 19:15:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ED3JrAgt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAA8C887E3; Fri, 12 Jul 2024 19:15:12 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA405885EC
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 19:15:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id D9995CE1B5F;
 Fri, 12 Jul 2024 17:15:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FC2C4AF0B;
 Fri, 12 Jul 2024 17:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1720804508;
 bh=rJecYR7ZxPb39GtF3ogxtHLdIKbxvONogG63GnTHESA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ED3JrAgtvRokeXB64zc/iysS7dFlVocYlObvZ7XK6RbIPujCFCosgbMfPueoRyCMA
 U1rh8g0erFd7erHef3wMu7zeUjnjrhOtCHDS9tQ851apULL1WPSthS4xjh0Fp91EJK
 tiVTPGFDNzQK9eIvR3Esf6/gP7wvGQOWwuAJ8JBfPsxwPE9XUq8WyPKtt+91IV56ve
 /uESOlxzsSIMkLupx2EcQtMuGk7i8yyVVv2vf8Q8LAFHGZwvkqwJlcRhuajlqtVzJ+
 37Hrr7pxhejzomeI7uIk+TvxYoT0oL0LZNKsXL2WZv5+68c/nBH3fYb7W7RB6nJRog
 7Cxu49FRvRS4Q==
From: Michael Walle <mwalle@kernel.org>
To: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH 1/2] spi: sunxi: drop max_hz handling
Date: Fri, 12 Jul 2024 19:14:56 +0200
Message-Id: <20240712171457.3104804-2-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240712171457.3104804-1-mwalle@kernel.org>
References: <20240712171457.3104804-1-mwalle@kernel.org>
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

The driver is trying to read the "spi-max-frequency" property of the
*controller* driver node. There is no such property. The
"spi-max-frequency" property belongs to the SPI devices on the bus.

Right now, the driver will always fall back to the default value of 1MHz
and thus flash reads are very slow with just about 215kb/s.

In fact, the SPI uclass will already take care of everything and we just
have to clamp the frequency to the values the driver/hardware supports.
Thus, drop the whole max_hz handling.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/spi/spi-sunxi.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-sunxi.c b/drivers/spi/spi-sunxi.c
index 13725ee7a2d..bfb402902b8 100644
--- a/drivers/spi/spi-sunxi.c
+++ b/drivers/spi/spi-sunxi.c
@@ -135,7 +135,6 @@ struct sun4i_spi_variant {
 struct sun4i_spi_plat {
 	struct sun4i_spi_variant *variant;
 	u32 base;
-	u32 max_hz;
 };
 
 struct sun4i_spi_priv {
@@ -237,6 +236,13 @@ static void sun4i_spi_set_speed_mode(struct udevice *dev)
 	unsigned int div;
 	u32 reg;
 
+	/*
+	 * The uclass should take care that this won't happen. But anyway,
+	 * avoid a div-by-zero exception.
+	 */
+	if (!priv->freq)
+		return;
+
 	/*
 	 * Setup clock divider.
 	 *
@@ -401,11 +407,10 @@ static int sun4i_spi_xfer(struct udevice *dev, unsigned int bitlen,
 
 static int sun4i_spi_set_speed(struct udevice *dev, uint speed)
 {
-	struct sun4i_spi_plat *plat = dev_get_plat(dev);
 	struct sun4i_spi_priv *priv = dev_get_priv(dev);
 
-	if (speed > plat->max_hz)
-		speed = plat->max_hz;
+	if (speed > SUN4I_SPI_MAX_RATE)
+		speed = SUN4I_SPI_MAX_RATE;
 
 	if (speed < SUN4I_SPI_MIN_RATE)
 		speed = SUN4I_SPI_MIN_RATE;
@@ -458,7 +463,6 @@ static int sun4i_spi_probe(struct udevice *bus)
 
 	priv->variant = plat->variant;
 	priv->base = plat->base;
-	priv->freq = plat->max_hz;
 
 	return 0;
 }
@@ -466,16 +470,9 @@ static int sun4i_spi_probe(struct udevice *bus)
 static int sun4i_spi_of_to_plat(struct udevice *bus)
 {
 	struct sun4i_spi_plat *plat = dev_get_plat(bus);
-	int node = dev_of_offset(bus);
 
 	plat->base = dev_read_addr(bus);
 	plat->variant = (struct sun4i_spi_variant *)dev_get_driver_data(bus);
-	plat->max_hz = fdtdec_get_int(gd->fdt_blob, node,
-				      "spi-max-frequency",
-				      SUN4I_SPI_DEFAULT_RATE);
-
-	if (plat->max_hz > SUN4I_SPI_MAX_RATE)
-		plat->max_hz = SUN4I_SPI_MAX_RATE;
 
 	return 0;
 }
-- 
2.39.2

