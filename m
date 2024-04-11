Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BC3CD1297
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 04:27:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C370881B7;
	Thu, 11 Apr 2024 06:27:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="iMv6lSw1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5512E88163; Thu, 11 Apr 2024 06:27:12 +0200 (CEST)
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com
 [95.215.58.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5251D87D8E
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 06:27:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1712809629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZmAOLTvkMt83ZgNtT+HRER8yRuihQiEdRvd7/3/TEyo=;
 b=iMv6lSw11RUHOQf2Q1qSxTAFB7EcNwcrzXpiktW0uvR2GAhBMKcOeVNvsekeT6XtC52Ott
 YAbcU21/KLW7RXQys4xoaKoAY/EUeC6c6wwD5CjnyRZmMcp6v4djbo/Tvbo10cOJ/oCEe/
 6d19sSlKoT96daT6CzgX7uVb/Ixr4Y2x/SYl7Mgbcp50iSyVQQSSMxdV14+skIifRhI30u
 3Wm2zpXDKISyQ6QQI/P/i5ZfXeYhCJBa+M1XjSpfypbJrSk5YoHalyU35d1Sv8ABdvF83L
 lGWXDfaNNJmubqv3d5sCM6sWnHvDXfqnBtpY6RzntPzE7rOARRQ1mDWGMlk67A==
From: John Watts <contact@jookia.org>
Date: Thu, 11 Apr 2024 14:25:19 +1000
Subject: [PATCH RFC 02/15] sunxi: SPL SPI: extract code for doing SPI transfer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-spinand-v1-2-62d31bb188e8@jookia.org>
References: <20240411-spinand-v1-0-62d31bb188e8@jookia.org>
In-Reply-To: <20240411-spinand-v1-0-62d31bb188e8@jookia.org>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>, 
 Icenowy Zheng <uwu@icenowy.me>, Samuel Holland <samuel@sholland.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1712809535; l=4782;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=OE+ahwD60s3nDTSJGLaw1ny6AsOdAgL1ZbQ7cHlfat0=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAvEzV0k+/oCMa4rkmRTvi4pz
 ov83+4q6flP+oI9LkDsL2xiJMf9mJOVPwhDFNRJ0EcrAhGmnq3tmZPxZmIJlaCAUAAOkY
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

To support SPI NAND flashes, more commands than Read (03h) are needed.

Extract the code for doing SPI transfer from the reading code for code
reuse.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
Reviewed-by: Samuel Holland <samuel@sholland.org>
Tested-by: Samuel Holland <samuel@sholland.org> # Orange Pi Zero Plus
---
 arch/arm/mach-sunxi/spl_spi_sunxi.c | 105 ++++++++++++++++++++----------------
 1 file changed, 59 insertions(+), 46 deletions(-)

diff --git a/arch/arm/mach-sunxi/spl_spi_sunxi.c b/arch/arm/mach-sunxi/spl_spi_sunxi.c
index 7acb44f52a..e85ae96485 100644
--- a/arch/arm/mach-sunxi/spl_spi_sunxi.c
+++ b/arch/arm/mach-sunxi/spl_spi_sunxi.c
@@ -282,77 +282,90 @@ static void spi0_deinit(void)
 
 #define SPI_READ_MAX_SIZE 60 /* FIFO size, minus 4 bytes of the header */
 
-static void sunxi_spi0_read_data(u8 *buf, u32 addr, u32 bufsize,
-				 ulong spi_ctl_reg,
-				 ulong spi_ctl_xch_bitmask,
-				 ulong spi_fifo_reg,
-				 ulong spi_tx_reg,
-				 ulong spi_rx_reg,
-				 ulong spi_bc_reg,
-				 ulong spi_tc_reg,
-				 ulong spi_bcc_reg)
+static void sunxi_spi0_xfer(const u8 *txbuf, u32 txlen,
+			    u8 *rxbuf, u32 rxlen,
+			    ulong spi_ctl_reg,
+			    ulong spi_ctl_xch_bitmask,
+			    ulong spi_fifo_reg,
+			    ulong spi_tx_reg,
+			    ulong spi_rx_reg,
+			    ulong spi_bc_reg,
+			    ulong spi_tc_reg,
+			    ulong spi_bcc_reg)
 {
-	writel(4 + bufsize, spi_bc_reg); /* Burst counter (total bytes) */
-	writel(4, spi_tc_reg);           /* Transfer counter (bytes to send) */
+	writel(txlen + rxlen, spi_bc_reg); /* Burst counter (total bytes) */
+	writel(txlen, spi_tc_reg);         /* Transfer counter (bytes to send) */
 	if (spi_bcc_reg)
-		writel(4, spi_bcc_reg);  /* SUN6I also needs this */
+		writel(txlen, spi_bcc_reg);  /* SUN6I also needs this */
 
-	/* Send the Read Data Bytes (03h) command header */
-	writeb(0x03, spi_tx_reg);
-	writeb((u8)(addr >> 16), spi_tx_reg);
-	writeb((u8)(addr >> 8), spi_tx_reg);
-	writeb((u8)(addr), spi_tx_reg);
+	for (u32 i = 0; i < txlen; i++)
+		writeb(*(txbuf++), spi_tx_reg);
 
 	/* Start the data transfer */
 	setbits_le32(spi_ctl_reg, spi_ctl_xch_bitmask);
 
 	/* Wait until everything is received in the RX FIFO */
-	while ((readl(spi_fifo_reg) & 0x7F) < 4 + bufsize)
+	while ((readl(spi_fifo_reg) & 0x7F) < txlen + rxlen)
 		;
 
-	/* Skip 4 bytes */
-	readl(spi_rx_reg);
+	/* Skip txlen bytes */
+	for (u32 i = 0; i < txlen; i++)
+		readb(spi_rx_reg);
 
 	/* Read the data */
-	while (bufsize-- > 0)
-		*buf++ = readb(spi_rx_reg);
+	while (rxlen-- > 0)
+		*rxbuf++ = readb(spi_rx_reg);
+}
+
+static void spi0_xfer(const u8 *txbuf, u32 txlen, u8 *rxbuf, u32 rxlen)
+{
+	uintptr_t base = spi0_base_address();
 
-	/* tSHSL time is up to 100 ns in various SPI flash datasheets */
-	udelay(1);
+	if (is_sun6i_gen_spi()) {
+		sunxi_spi0_xfer(txbuf, txlen, rxbuf, rxlen,
+				base + SUN6I_SPI0_TCR,
+				SUN6I_TCR_XCH,
+				base + SUN6I_SPI0_FIFO_STA,
+				base + SUN6I_SPI0_TXD,
+				base + SUN6I_SPI0_RXD,
+				base + SUN6I_SPI0_MBC,
+				base + SUN6I_SPI0_MTC,
+				base + SUN6I_SPI0_BCC);
+	} else {
+		sunxi_spi0_xfer(txbuf, txlen, rxbuf, rxlen,
+				base + SUN4I_SPI0_CTL,
+				SUN4I_CTL_XCH,
+				base + SUN4I_SPI0_FIFO_STA,
+				base + SUN4I_SPI0_TX,
+				base + SUN4I_SPI0_RX,
+				base + SUN4I_SPI0_BC,
+				base + SUN4I_SPI0_TC,
+				0);
+	}
 }
 
 static void spi0_read_data(void *buf, u32 addr, u32 len)
 {
 	u8 *buf8 = buf;
 	u32 chunk_len;
-	uintptr_t base = spi0_base_address();
+	u8 txbuf[4];
 
 	while (len > 0) {
 		chunk_len = len;
+
+		/* Configure the Read Data Bytes (03h) command header */
+		txbuf[0] = 0x03;
+		txbuf[1] = (u8)(addr >> 16);
+		txbuf[2] = (u8)(addr >> 8);
+		txbuf[3] = (u8)(addr);
+
 		if (chunk_len > SPI_READ_MAX_SIZE)
 			chunk_len = SPI_READ_MAX_SIZE;
 
-		if (is_sun6i_gen_spi()) {
-			sunxi_spi0_read_data(buf8, addr, chunk_len,
-					     base + SUN6I_SPI0_TCR,
-					     SUN6I_TCR_XCH,
-					     base + SUN6I_SPI0_FIFO_STA,
-					     base + SUN6I_SPI0_TXD,
-					     base + SUN6I_SPI0_RXD,
-					     base + SUN6I_SPI0_MBC,
-					     base + SUN6I_SPI0_MTC,
-					     base + SUN6I_SPI0_BCC);
-		} else {
-			sunxi_spi0_read_data(buf8, addr, chunk_len,
-					     base + SUN4I_SPI0_CTL,
-					     SUN4I_CTL_XCH,
-					     base + SUN4I_SPI0_FIFO_STA,
-					     base + SUN4I_SPI0_TX,
-					     base + SUN4I_SPI0_RX,
-					     base + SUN4I_SPI0_BC,
-					     base + SUN4I_SPI0_TC,
-					     0);
-		}
+		spi0_xfer(txbuf, 4, buf8, chunk_len);
+
+		/* tSHSL time is up to 100 ns in various SPI flash datasheets */
+		udelay(1);
 
 		len  -= chunk_len;
 		buf8 += chunk_len;

-- 
2.44.0

