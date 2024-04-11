Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC746CD1297
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 04:28:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28892881CD;
	Thu, 11 Apr 2024 06:27:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="0iD3lEV/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 732D8881F3; Thu, 11 Apr 2024 06:27:54 +0200 (CEST)
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com
 [95.215.58.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AE9987FED
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 06:27:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1712809672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gJVRzRleHLgugqH6iGrc7r/C1wu8gWUu+M7PdwezpUo=;
 b=0iD3lEV/xthhRtBP9meg//TzDAE4m7zRISlZD008rVMuLq8Vj2szXJ1I+dUhwZ8Yc3eODr
 zkN/9aV1NvGP2bu08gXhTnsgaf4d2eVZHzqGHQBnOx6xJaxDqirS2dwAQhVvaQ6oFcBCFl
 md24Gf0AnCbAjRkvsZ9vGNGS68s/JddYyeg0BUflvMLxZjaV+ks3lpbJxsA8RAdNZKnKe+
 yS6xKaYdLhJig58WBGrzHKxgRa1ESc1RdSh4l6DPvzCNjAoOHq/Agww8a5Io1EMUahgqd/
 9Iy26vTjslArFuNPxp9HwdLPTW95JW4nRfOG/mdXyBxf1qVpiy5hpEgwLIhlpA==
From: John Watts <contact@jookia.org>
Date: Thu, 11 Apr 2024 14:25:24 +1000
Subject: [PATCH RFC 07/15] sunxi: Separate boot device and boot position
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-spinand-v1-7-62d31bb188e8@jookia.org>
References: <20240411-spinand-v1-0-62d31bb188e8@jookia.org>
In-Reply-To: <20240411-spinand-v1-0-62d31bb188e8@jookia.org>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1712809561; l=2869;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=x0RMOSGdRAJghSgo+Hz4TOgF5oe67guv5wTX6FTmDfM=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABA4PTJM9Bn/UqE21BTtT4ZKEX
 FUkGmlOyBmX1OPt0UUNeuLXD4Lc8NnDkqGC6eBLlHJaCej5C6goVXlAXMtn7JAQUAAOk8
X-Developer-Key: i=contact@jookia.org; a=openssh;
 fpr=SHA256:6LBQmZH5u7i/edmEZXzCTwCrpSevs/ZshZxNmlD1thY
X-Migadu-Flow: FLOW_OUT
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

While MMC1 and MMC2 each currently have only one upper byte possibility,
SPI NAND has quite a few. To solve this, split up the byte handling across
two functions in preparation for SPI NAND support.

I have not tested this patch to validate that MMC SPL offsets are working.
It looks like it should work though.

Signed-off-by: John Watts <contact@jookia.org>
---
 arch/arm/include/asm/arch-sunxi/spl.h |  2 --
 arch/arm/mach-sunxi/board.c           | 22 +++++++++++++---------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/arch-sunxi/spl.h b/arch/arm/include/asm/arch-sunxi/spl.h
index 14944a20ea..92be936d56 100644
--- a/arch/arm/include/asm/arch-sunxi/spl.h
+++ b/arch/arm/include/asm/arch-sunxi/spl.h
@@ -16,8 +16,6 @@
 #define SUNXI_BOOTED_FROM_NAND	1
 #define SUNXI_BOOTED_FROM_MMC2	2
 #define SUNXI_BOOTED_FROM_SPI	3
-#define SUNXI_BOOTED_FROM_MMC0_HIGH	0x10
-#define SUNXI_BOOTED_FROM_MMC2_HIGH	0x12
 
 /*
  * Values taken from the F1C200s BootROM stack
diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
index 9b0d68a7a0..7f4ee92991 100644
--- a/arch/arm/mach-sunxi/board.c
+++ b/arch/arm/mach-sunxi/board.c
@@ -276,6 +276,7 @@ static int sunxi_get_boot_source(void)
 uint32_t sunxi_get_boot_device(void)
 {
 	int boot_source = sunxi_get_boot_source();
+	int boot_dev = (boot_source & 0xF); /* Low nibble is device */
 
 	/*
 	 * When booting from the SD card or NAND memory, the "eGON.BT0"
@@ -293,16 +294,15 @@ uint32_t sunxi_get_boot_device(void)
 	 * binary over USB. If it is found, it determines where SPL was
 	 * read from.
 	 */
-	switch (boot_source) {
-	case SUNXI_INVALID_BOOT_SOURCE:
+	if (boot_source == SUNXI_INVALID_BOOT_SOURCE)
 		return BOOT_DEVICE_BOARD;
+
+	switch (boot_dev) {
 	case SUNXI_BOOTED_FROM_MMC0:
-	case SUNXI_BOOTED_FROM_MMC0_HIGH:
 		return BOOT_DEVICE_MMC1;
 	case SUNXI_BOOTED_FROM_NAND:
 		return BOOT_DEVICE_NAND;
 	case SUNXI_BOOTED_FROM_MMC2:
-	case SUNXI_BOOTED_FROM_MMC2_HIGH:
 		return BOOT_DEVICE_MMC2;
 	case SUNXI_BOOTED_FROM_SPI:
 		return BOOT_DEVICE_SPI;
@@ -312,6 +312,14 @@ uint32_t sunxi_get_boot_device(void)
 	return -1;		/* Never reached */
 }
 
+uint32_t sunxi_get_boot_position(void)
+{
+	int boot_source = sunxi_get_boot_source();
+	int boot_pos = ((boot_source >> 8) & 0xF); /* High nibble is position */
+
+	return boot_pos;
+}
+
 #ifdef CONFIG_SPL_BUILD
 uint32_t sunxi_get_spl_size(void)
 {
@@ -343,12 +351,8 @@ unsigned long board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
 
 	sector = max(raw_sect, spl_size / 512);
 
-	switch (sunxi_get_boot_source()) {
-	case SUNXI_BOOTED_FROM_MMC0_HIGH:
-	case SUNXI_BOOTED_FROM_MMC2_HIGH:
+	if (sunxi_get_boot_position() == 1)
 		sector += (128 - 8) * 2;
-		break;
-	}
 
 	return sector;
 }

-- 
2.44.0

