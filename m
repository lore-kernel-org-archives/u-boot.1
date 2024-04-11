Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 009E6CD1297
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 04:27:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 967B388163;
	Thu, 11 Apr 2024 06:27:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="Vj7xJ8fJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B7D2881D5; Thu, 11 Apr 2024 06:27:21 +0200 (CEST)
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::ac])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7F6F88163
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 06:27:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1712809638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=paUtK0NnEwALzlzF3LD5jhuLTb/ujriiQnuVCtwgfPo=;
 b=Vj7xJ8fJO8OfduZMg6iEgUQTjztojNByxTj/YHAYNCwEStp7cnJDyfC4StR0Y8byU5ntTJ
 +EOqJV2CdB5y+LAvXbwbUDMlDDpYXQepeHwyDu7a/Lw8d+jEmvX8DewFvkt+BDP25TjHHM
 z3qMKTdYuj/YzkOykeJdZnu2mqgZX5zryPkQ90EpHTlTT0qIpJIARvphg34lUKcY7n1+iz
 IrzjIauX+VDdeM2wD9M2KVrB0wf4oEL1D9nyJbvwGBOjs56eoo3XdSdjwhULxYtmT01mtf
 eSzlh1Iq5qTA0sEdVKkXG3UenoIBHRYxmut0ILrqoZa3C+DZnMHEEGuiTO+glw==
From: John Watts <contact@jookia.org>
Date: Thu, 11 Apr 2024 14:25:20 +1000
Subject: [PATCH RFC 03/15] sunxi: SPL SPI: add support for read command
 with 2 byte address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-spinand-v1-3-62d31bb188e8@jookia.org>
References: <20240411-spinand-v1-0-62d31bb188e8@jookia.org>
In-Reply-To: <20240411-spinand-v1-0-62d31bb188e8@jookia.org>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>, 
 Icenowy Zheng <uwu@icenowy.me>, Samuel Holland <samuel@sholland.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1712809541; l=2607;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=rFhh6kIo6tgc0kS7U5WoeWx3IfgYKwXm4CJD2NevHTQ=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAj/4/H+D9wHrKKBjPuXe/OdZ
 YJN7TMpE7IeuFJHIo5Zzy5Isz2p5NpoZ6hbZT/RxfUL5IgEbwzARDRCzsRx5IAwUAAOkc
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

From: Icenowy Zheng <uwu@icenowy.me>

This kind of read command is utilized in SPI NANDs for reading data
inside a selected page, which is obviously smaller than how much 2
byte address can address. So 2 bytes are used for the address and one
dummy byte is needed after the real address. As the address is sent out
in bit endian, this makes it not compatible with usual 3 byte address.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
Reviewed-by: Samuel Holland <samuel@sholland.org>
Tested-by: Samuel Holland <samuel@sholland.org> # Orange Pi Zero Plus
---
 arch/arm/mach-sunxi/spl_spi_sunxi.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-sunxi/spl_spi_sunxi.c b/arch/arm/mach-sunxi/spl_spi_sunxi.c
index e85ae96485..fe95878eae 100644
--- a/arch/arm/mach-sunxi/spl_spi_sunxi.c
+++ b/arch/arm/mach-sunxi/spl_spi_sunxi.c
@@ -344,7 +344,7 @@ static void spi0_xfer(const u8 *txbuf, u32 txlen, u8 *rxbuf, u32 rxlen)
 	}
 }
 
-static void spi0_read_data(void *buf, u32 addr, u32 len)
+static void spi0_read_data(void *buf, u32 addr, u32 len, u32 addr_len)
 {
 	u8 *buf8 = buf;
 	u32 chunk_len;
@@ -355,9 +355,15 @@ static void spi0_read_data(void *buf, u32 addr, u32 len)
 
 		/* Configure the Read Data Bytes (03h) command header */
 		txbuf[0] = 0x03;
-		txbuf[1] = (u8)(addr >> 16);
-		txbuf[2] = (u8)(addr >> 8);
-		txbuf[3] = (u8)(addr);
+		if (addr_len == 3) {
+			txbuf[1] = (u8)(addr >> 16);
+			txbuf[2] = (u8)(addr >> 8);
+			txbuf[3] = (u8)(addr);
+		} else if (addr_len == 2) {
+			txbuf[1] = (u8)(addr >> 8);
+			txbuf[2] = (u8)(addr);
+			txbuf[3] = 0; /* dummy */
+		}
 
 		if (chunk_len > SPI_READ_MAX_SIZE)
 			chunk_len = SPI_READ_MAX_SIZE;
@@ -376,7 +382,7 @@ static void spi0_read_data(void *buf, u32 addr, u32 len)
 static ulong spi_load_read(struct spl_load_info *load, ulong sector,
 			   ulong count, void *buf)
 {
-	spi0_read_data(buf, sector, count);
+	spi0_read_data(buf, sector, count, 3);
 
 	return count;
 }
@@ -395,7 +401,7 @@ static int spl_spi_load_image(struct spl_image_info *spl_image,
 
 	spi0_init();
 
-	spi0_read_data((void *)header, load_offset, 0x40);
+	spi0_read_data((void *)header, load_offset, 0x40, 3);
 
         if (IS_ENABLED(CONFIG_SPL_LOAD_FIT) &&
 		image_get_magic(header) == FDT_MAGIC) {
@@ -412,7 +418,7 @@ static int spl_spi_load_image(struct spl_image_info *spl_image,
 			return ret;
 
 		spi0_read_data((void *)spl_image->load_addr,
-			       load_offset, spl_image->size);
+			       load_offset, spl_image->size, 3);
 	}
 
 	spi0_deinit();

-- 
2.44.0

