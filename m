Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B71E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 07:33:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6512802EF;
	Wed, 11 Dec 2024 08:32:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="c15A0WJf";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mXNhBlJA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBD3C80245; Wed, 11 Dec 2024 08:32:37 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 928D08020B
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 08:32:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Y7S432XlJz9sxX;
 Wed, 11 Dec 2024 08:32:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733902355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hLsKZkrSq/5KHv4KiMjIU+RtfPnKw6CtjBMlbaysEck=;
 b=c15A0WJfAF7ueHoxe628YuuppdkRqoyUN2jGvO+4SNHRkf8M7Bw4fkm+OpEaH839EtpnSb
 U9QwacvtDW38HuirpPqOx9+QV9/qSgDmrqrqfiZqYbMfsYLPal0KEs2xI5fM7+fd7yC++8
 rCa7TIM4eyhjO+Qqh3iBnkgGR4p1Y6Q0lEh6OyhgUlICkCJCDGJ3DXCrWeUwQtZMOiKA69
 C8tOVYLkoWU9O7DjkM58Jp+GCDim2IPAMQrM+PiqBWt01DSkJfnlCCif8fZw0z3nvcaO13
 Z6mztZnyy0LSQsFnAJvft1WDuk0PkFGbGwnf3HojN/pHPuW1c6aQvV+yVREgUQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733902353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hLsKZkrSq/5KHv4KiMjIU+RtfPnKw6CtjBMlbaysEck=;
 b=mXNhBlJAQrsc2Aseq8LO23XAfkLNeWgsezKIhhDmQ7PEQQeTTSA4xhlOMk1stbhg6J9d3w
 gltb87WzNVl3OxKsZMqF9NyO2fcPMrXGC/5/zhtCAXhTebZYVvp8TcP6TP8oDkKgXStSP/
 yxlAuTAcdGNE5AeulYIzqVrBhz2JcjHGLCEf6txhTW1MFgwEan/b9vGHezmwmmjKjF4QuW
 2B06IHXgBpJdK3LntZtK9AKMidzWb4RaTm16iX+UN8ylirCdGRmRLLIJT/gI6O0KmWRRsc
 V8cSxW3+iXBkhTgyuqHCmGU8OQPOjRgz5NNuUaWkP4Q33860ewNf1vqjcCSYUQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 06/13] mmc: renesas: Fix R-Car spelling
Date: Wed, 11 Dec 2024 08:30:30 +0100
Message-ID: <20241211073210.8087-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241211073210.8087-1-marek.vasut+renesas@mailbox.org>
References: <20241211073210.8087-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: kw9iwemk9xa4pwdz3jsdfhiiuds9skb9
X-MBO-RS-ID: 79422e829b7e752177b
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

The correct spelling is R-Car, including the dash, update the usage.
Comment changes only, no functional change.

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: - Update commit message, do not mention Kconfig
    - Add RB from Jaehoon
---
 drivers/mmc/renesas-sdhi.c |  2 +-
 drivers/mmc/tmio-common.h  | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/renesas-sdhi.c b/drivers/mmc/renesas-sdhi.c
index 92afa6adcda..556f07eaf8f 100644
--- a/drivers/mmc/renesas-sdhi.c
+++ b/drivers/mmc/renesas-sdhi.c
@@ -571,7 +571,7 @@ int renesas_sdhi_execute_tuning(struct udevice *dev, uint opcode)
 	int i, ret = 0, sret;
 	u32 caps, reg;
 
-	/* Only supported on Renesas RCar */
+	/* Only supported on Renesas R-Car */
 	if (!(priv->caps & TMIO_SD_CAP_RCAR_UHS))
 		return -EINVAL;
 
diff --git a/drivers/mmc/tmio-common.h b/drivers/mmc/tmio-common.h
index f489fb70766..657aba75148 100644
--- a/drivers/mmc/tmio-common.h
+++ b/drivers/mmc/tmio-common.h
@@ -64,7 +64,7 @@
 #define   TMIO_SD_CLKCTL_DIV4		BIT(0)	/* SDCLK = CLK / 4 */
 #define   TMIO_SD_CLKCTL_DIV2		0	/* SDCLK = CLK / 2 */
 #define   TMIO_SD_CLKCTL_DIV1		BIT(10)	/* SDCLK = CLK */
-#define   TMIO_SD_CLKCTL_RCAR_DIV1	0xff	/* SDCLK = CLK (RCar ver.) */
+#define   TMIO_SD_CLKCTL_RCAR_DIV1	0xff	/* SDCLK = CLK (R-Car ver.) */
 #define   TMIO_SD_CLKCTL_OFFEN		BIT(9)	/* stop SDCLK when unused */
 #define   TMIO_SD_CLKCTL_SCLKEN	BIT(8)	/* SDCLK output enable */
 #define TMIO_SD_SIZE			0x04c	/* block size */
@@ -90,7 +90,7 @@
 #define   TMIO_SD_VOLT_180		(2 << 0)/* 1.8V signal */
 #define TMIO_SD_DMA_MODE		0x410
 #define   TMIO_SD_DMA_MODE_DIR_RD	BIT(16)	/* 1: from device, 0: to dev */
-#define   TMIO_SD_DMA_MODE_BUS_WIDTH	(BIT(5) | BIT(4)) /* RCar, 64bit */
+#define   TMIO_SD_DMA_MODE_BUS_WIDTH	(BIT(5) | BIT(4)) /* R-Car, 64bit */
 #define   TMIO_SD_DMA_MODE_ADDR_INC	BIT(0)	/* 1: address inc, 0: fixed */
 #define TMIO_SD_DMA_CTL		0x414
 #define   TMIO_SD_DMA_CTL_START	BIT(0)	/* start DMA (auto cleared) */
@@ -128,9 +128,9 @@ struct tmio_sd_priv {
 #define TMIO_SD_CAP_DIV1024		BIT(2)	/* divisor 1024 is available */
 #define TMIO_SD_CAP_64BIT		BIT(3)	/* Controller is 64bit */
 #define TMIO_SD_CAP_16BIT		BIT(4)	/* Controller is 16bit */
-#define TMIO_SD_CAP_RCAR_GEN2		BIT(5)	/* Renesas RCar version of IP */
-#define TMIO_SD_CAP_RCAR_GEN3		BIT(6)	/* Renesas RCar version of IP */
-#define TMIO_SD_CAP_RCAR_UHS		BIT(7)	/* Renesas RCar UHS/SDR modes */
+#define TMIO_SD_CAP_RCAR_GEN2		BIT(5)	/* Renesas R-Car version of IP */
+#define TMIO_SD_CAP_RCAR_GEN3		BIT(6)	/* Renesas R-Car version of IP */
+#define TMIO_SD_CAP_RCAR_UHS		BIT(7)	/* Renesas R-Car UHS/SDR modes */
 #define TMIO_SD_CAP_RCAR		\
 	(TMIO_SD_CAP_RCAR_GEN2 | TMIO_SD_CAP_RCAR_GEN3)
 	struct udevice *vqmmc_dev;
-- 
2.45.2

