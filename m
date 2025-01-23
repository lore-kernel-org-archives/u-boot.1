Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9059C0218B
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 12:13:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F1E1801B0;
	Thu, 23 Jan 2025 13:12:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="nP3ulPfN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D89480805; Thu, 23 Jan 2025 13:12:29 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DFE2807A8
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 13:12:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D114E148A1EE; Thu, 23 Jan 2025 13:12:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1737634345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TUaVyFTYLrvLV3utprPuF+uQXyx9qcx3T2KQwyqx4kU=;
 b=nP3ulPfNI9N2BJK36ZuFpaKl/ETOhDdjak/cvtRNkFPV48969/UbzShuUcrE+DY1VYEQjJ
 p2dCKNPhf4gRq7CHbenEAM5hxGe1iMvW3XAdYIMHPc61gGwn968lQeDuQ/98M7tIERipcG
 ++XtMpEkokQCpPdfzJ1B5b9ivyqdQinodyDbj3PvgYsys1xpBGUB058C2lOJ76ieH+1yIE
 LhdOrZUrFwchkinc2hRmypuDks0OkXNgYw4gRUVRVouUZBRcFbBC5sjLRfw+GAC9GsHO6T
 zpsE3oC7PgJHycH20lx+dGJZJRqdGf/bhg6SaYpnql26pxrvYnk7sV3r13Om9g==
From: Alexander Dahl <ada@thorsis.com>
To: Tudor Ambarus <tudor.ambarus@microchip.com>,
 Eugen Hristev <eugen.hristev@microchip.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>,
 u-boot@lists.denx.de
Subject: [PATCH 7/7] spi: atmel-quadspi: Improve probe debugging
Date: Thu, 23 Jan 2025 13:12:15 +0100
Message-Id: <20250123121215.21001-8-ada@thorsis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250123121215.21001-1-ada@thorsis.com>
References: <20250123121215.21001-1-ada@thorsis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Report spi clk speed and make use of `log_ret()`.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 drivers/spi/atmel-quadspi.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index a2faac5a505..8aa7a83aef4 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -1082,6 +1082,7 @@ static int atmel_qspi_set_speed(struct udevice *bus, uint hz)
 		return atmel_qspi_sama7g5_set_speed(bus, hz);
 
 	/* Compute the QSPI baudrate */
+	dev_dbg(bus, "bus_clk_rate: %lu, hz: %u\n", aq->bus_clk_rate, hz);
 	scbr = DIV_ROUND_UP(aq->bus_clk_rate, hz);
 	if (scbr > 0)
 		scbr--;
@@ -1214,7 +1215,7 @@ static int atmel_qspi_probe(struct udevice *dev)
 	aq->caps = (struct atmel_qspi_caps *)dev_get_driver_data(dev);
 	if (!aq->caps) {
 		dev_err(dev, "Could not retrieve QSPI caps\n");
-		return -EINVAL;
+		return log_ret(-EINVAL);
 	};
 
 	if (aq->caps->has_gclk)
@@ -1227,7 +1228,7 @@ static int atmel_qspi_probe(struct udevice *dev)
 						ARRAY_SIZE(aq->cs_gpios), 0);
 		if (ret < 0) {
 			pr_err("Can't get %s gpios! Error: %d", dev->name, ret);
-			return ret;
+			return log_ret(ret);
 		}
 
 		for (int i = 0; i < ARRAY_SIZE(aq->cs_gpios); i++) {
@@ -1243,32 +1244,32 @@ static int atmel_qspi_probe(struct udevice *dev)
 	ret = dev_read_resource_byname(dev, "qspi_base", &res);
 	if (ret) {
 		dev_err(dev, "missing registers\n");
-		return ret;
+		return log_ret(ret);
 	}
 
 	aq->regs = devm_ioremap(dev, res.start, resource_size(&res));
 	if (IS_ERR(aq->regs))
-		return PTR_ERR(aq->regs);
+		return log_ret(PTR_ERR(aq->regs));
 
 	/* Map the AHB memory */
 	ret = dev_read_resource_byname(dev, "qspi_mmap", &res);
 	if (ret) {
 		dev_err(dev, "missing AHB memory\n");
-		return ret;
+		return log_ret(ret);
 	}
 
 	aq->mem = devm_ioremap(dev, res.start, resource_size(&res));
 	if (IS_ERR(aq->mem))
-		return PTR_ERR(aq->mem);
+		return log_ret(PTR_ERR(aq->mem));
 
 	aq->mmap_size = resource_size(&res);
 
 	ret = atmel_qspi_enable_clk(dev);
 	if (ret)
-		return ret;
+		return log_ret(ret);
 
 	aq->dev = dev;
-	return atmel_qspi_init(aq);
+	return log_ret(atmel_qspi_init(aq));
 }
 
 static const struct spi_controller_mem_ops atmel_qspi_mem_ops = {
-- 
2.39.5

