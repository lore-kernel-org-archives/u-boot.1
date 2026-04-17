Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5C9F8E497
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 02:22:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CDCD8425F;
	Fri, 17 Apr 2026 04:21:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A52984262; Fri, 17 Apr 2026 04:21:44 +0200 (CEST)
Received: from Atcsqr.andestech.com (unknown [60.248.187.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E63E08425F
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 04:21:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTP id 63H2LBPa015786;
 Fri, 17 Apr 2026 10:21:11 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 Apr
 2026 10:21:10 +0800
From: Leo Yu-Chi Liang <ycliang@andestech.com>
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Vignesh R <vigneshr@ti.com>, "Takahiro
 Kuwano" <takahiro.kuwano@infineon.com>, Jagan Teki
 <jagan@amarulasolutions.com>, <ycliang@andestech.com>
Subject: [PATCH 4/8] spi: atcspi200: Fix double stop call and simplify
 transfer loop
Date: Fri, 17 Apr 2026 10:21:00 +0800
Message-ID: <20260417022104.3973576-5-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417022104.3973576-1-ycliang@andestech.com>
References: <20260417022104.3973576-1-ycliang@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 63H2LBPa015786
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

- Remove duplicate atcspi200_hw_stop() call after the while loop;
  the stop inside the loop already handles the final chunk
- Simplify the CHUNK_SIZE=1 transfer logic: since CHUNK_SIZE was
  always 1, remove the constant and inline its value, eliminating
  dead num_bytes/rf_cnt/rx_bytes variables
- Simplify atcspi200_rx_byte() to void (return value was unused)
- Add clarifying comment on the multi-chunk address increment

Fixes: b41e12e73b2 ("spi: Add SPI driver for Andestech ATCSPI200 controller")
Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 drivers/spi/atcspi200_spi.c | 41 ++++++++++++-------------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/drivers/spi/atcspi200_spi.c b/drivers/spi/atcspi200_spi.c
index 38345a88260..0e7f7b83081 100644
--- a/drivers/spi/atcspi200_spi.c
+++ b/drivers/spi/atcspi200_spi.c
@@ -18,7 +18,6 @@
 #include <linux/bitops.h>
 
 #define MAX_TRANSFER_LEN	512
-#define CHUNK_SIZE		1
 #define SPI_TIMEOUT_MS		1000
 #define SPI_DEF_SRC_CLK		100000000
 #define SPI_DEF_MAX_CLK		40000000
@@ -188,26 +187,22 @@ static void atcspi200_tx_byte(struct atcspi200_priv *priv, const void *dout)
 	atcspi200_write(priv, ATCSPI200_REG_DATA, *(u8 *)dout);
 }
 
-static int atcspi200_rx_byte(struct atcspi200_priv *priv, void *din,
-			     unsigned int bytes)
+static void atcspi200_rx_byte(struct atcspi200_priv *priv, void *din)
 {
 	*(u8 *)din = (u8)atcspi200_read(priv, ATCSPI200_REG_DATA);
-	return bytes;
 }
 
 static int atcspi200_hw_xfer(struct atcspi200_priv *priv,
 			     unsigned int bitlen, const void *data_out,
 			     void *data_in, unsigned long flags)
 {
-	unsigned int event, rx_bytes;
+	unsigned int event;
 	const void *dout = NULL;
 	void *din = NULL;
 	int num_blks, num_chunks, max_tran_len, tran_len;
-	int num_bytes;
 	u8 *cmd_buf = priv->cmd_buf;
 	size_t cmd_len = priv->cmd_len;
 	unsigned long data_len = bitlen / 8;
-	int rf_cnt;
 	int ret = 0;
 	unsigned long start;
 
@@ -250,10 +245,7 @@ static int atcspi200_hw_xfer(struct atcspi200_priv *priv,
 	while (num_chunks--) {
 		tran_len = min((size_t)data_len, (size_t)max_tran_len);
 		priv->tran_len = tran_len;
-		num_blks = DIV_ROUND_UP(tran_len, CHUNK_SIZE);
-		num_bytes = tran_len % CHUNK_SIZE;
-		if (num_bytes == 0)
-			num_bytes = CHUNK_SIZE;
+		num_blks = tran_len;
 		start = get_timer(0);
 		atcspi200_hw_start(priv);
 
@@ -267,30 +259,24 @@ static int atcspi200_hw_xfer(struct atcspi200_priv *priv,
 
 			if ((event & TXEPTY) && data_out) {
 				atcspi200_tx_byte(priv, dout);
-				num_blks -= CHUNK_SIZE;
-				dout += CHUNK_SIZE;
+				num_blks--;
+				dout++;
 			}
 
 			if ((event & RXFVE_MASK) && data_in) {
-				rf_cnt = FIELD_GET(RXFVE_MASK, event);
-				if (rf_cnt >= CHUNK_SIZE)
-					rx_bytes = CHUNK_SIZE;
-				else if (num_blks == 1 &&
-					 rf_cnt == num_bytes)
-					rx_bytes = num_bytes;
-				else
-					continue;
-
-				if (atcspi200_rx_byte(priv, din, rx_bytes) ==
-				    rx_bytes) {
-					num_blks -= CHUNK_SIZE;
-					din = (unsigned char *)din + rx_bytes;
-				}
+				atcspi200_rx_byte(priv, din);
+				num_blks--;
+				din = (unsigned char *)din + 1;
 			}
 		}
 
 		data_len -= tran_len;
 		if (data_len) {
+			/*
+			 * Increment SPI NOR read address in cmd buffer
+			 * for multi-chunk transfers (3-byte big-endian
+			 * address at cmd_buf[1..3]).
+			 */
 			priv->cmd_buf[1] += ((tran_len >> 16) & 0xff);
 			priv->cmd_buf[2] += ((tran_len >> 8) & 0xff);
 			priv->cmd_buf[3] += (tran_len & 0xff);
@@ -298,7 +284,6 @@ static int atcspi200_hw_xfer(struct atcspi200_priv *priv,
 		}
 		ret = atcspi200_hw_stop(priv);
 	}
-	ret = atcspi200_hw_stop(priv);
 
 	return ret;
 }
-- 
2.34.1

