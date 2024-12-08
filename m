Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 350ADE77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 22:06:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BFBE895A8;
	Sun,  8 Dec 2024 23:06:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="B6a7rx+L";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="lTLtT8LU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00EC089588; Sun,  8 Dec 2024 23:06:27 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15330893AE
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 23:06:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Y5zbh5gGFz9spH;
 Sun,  8 Dec 2024 23:06:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733695584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r5C5KNnzrTkoDfitDTvShMqcJ2cFELc6ksU47/uNxLs=;
 b=B6a7rx+LV+rGjK2qwhuKSTgrBc7yxy6c/auXOrHLLj7sQF7TrCEnURJRcZytp5Gneg2j4J
 FNPMPHQi4+4YI3BYdgATY7M9gBdgrrA7yMZyHJBAdeUPoAaoewMemD9iM3wMGN7XDMobnG
 Zy+3qUBuFIpLX8fFVuBMGYnnOSrk7L9ostw/XZ8shfwXdYZqsRbyXPSSRF58xfVOoSLorJ
 ggBKawBJqYs1btAw1hgi7/LbwBnbIXVUqczlKcT9i5JrOIY7hn1MLTi7MdacHkRUgMidkR
 jxXqZR5oWv6t66+v8HsRybmFsCKfCVQqWAHNQTRUVgxqI3jRRfbncKkVTQc2CA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733695583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r5C5KNnzrTkoDfitDTvShMqcJ2cFELc6ksU47/uNxLs=;
 b=lTLtT8LUynBOjerfuXyC9ICfSbq2t5iErmup7cC7yS5WG7jU9SN5+yMCEoQ0TZQd3VugZt
 HmCT+d8RYqi62ZgjXuYfwIcUWcmSsjCf5/EFE1lAVoTH6Pek5OIUSJSO1Z/j96HcdeTUTG
 sQLdfGnBPt6uHZ2GtyyxHWRzFt1qM32aWizLyEEKcxQ+dXEYbY8DCcRI3VvTA1fpe/O8xp
 WLeuyweMhAB/Oihw/UFd3JwDXK1bUTgRHzv1Zj5l+CYqulRhbknclaxkJidva8SJEZxTT6
 ksOMHFvU8Ub/aJPUzxjwjxLGEFDgFyc612fBu95fyWe+Fy4efFb3gKg/0Z4NsQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/13] mmc: renesas: Fix R-Car spelling
Date: Sun,  8 Dec 2024 23:03:59 +0100
Message-ID: <20241208220551.204743-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241208220551.204743-1-marek.vasut+renesas@mailbox.org>
References: <20241208220551.204743-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: qc3yai7kdw6e7fdx454dkk6z6s6eyc18
X-MBO-RS-ID: 7dfc2269600f15b9a41
X-Rspamd-Queue-Id: 4Y5zbh5gGFz9spH
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
Kconfig strings and comment changes only, no functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

