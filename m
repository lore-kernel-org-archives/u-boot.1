Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42157F8E49E
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 02:22:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23EB48423F;
	Fri, 17 Apr 2026 04:21:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBD9983EEF; Fri, 17 Apr 2026 04:21:38 +0200 (CEST)
Received: from Atcsqr.andestech.com (unknown [60.248.187.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19334841C8
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 04:21:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTP id 63H2LABm015785;
 Fri, 17 Apr 2026 10:21:10 +0800 (+08)
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
Subject: [PATCH 3/8] spi: atcspi200: Use proper timeout handling for busy-wait
 loops
Date: Fri, 17 Apr 2026 10:20:59 +0800
Message-ID: <20260417022104.3973576-4-ycliang@andestech.com>
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
X-MAIL: Atcsqr.andestech.com 63H2LABm015785
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

Replace manual busy-wait counters with standard U-Boot timeout APIs:

- Use wait_for_bit_le32() for FIFO reset wait in claim_bus and SPI
  busy wait in stop, providing time-based timeouts with watchdog
  support
- Use get_timer() for the transfer polling loop where TX/RX work
  is done inside the loop
- Remove the 'to' field from private data (no longer needed)
- Replace iteration-count SPI_TIMEOUT with time-based SPI_TIMEOUT_MS

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 drivers/spi/atcspi200_spi.c | 41 ++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/atcspi200_spi.c b/drivers/spi/atcspi200_spi.c
index 33cf7583581..38345a88260 100644
--- a/drivers/spi/atcspi200_spi.c
+++ b/drivers/spi/atcspi200_spi.c
@@ -11,13 +11,15 @@
 #include <dm/device_compat.h>
 #include <log.h>
 #include <spi.h>
+#include <time.h>
+#include <wait_bit.h>
 #include <asm/io.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 
 #define MAX_TRANSFER_LEN	512
 #define CHUNK_SIZE		1
-#define SPI_TIMEOUT		0x100000
+#define SPI_TIMEOUT_MS		1000
 #define SPI_DEF_SRC_CLK		100000000
 #define SPI_DEF_MAX_CLK		40000000
 
@@ -68,7 +70,6 @@
 
 struct atcspi200_priv {
 	void		*regs;
-	int		to;
 	unsigned int	freq;
 	unsigned int	src_clk;
 	unsigned int	max_clk;
@@ -126,14 +127,16 @@ static int atcspi200_hw_set_speed(struct atcspi200_priv *priv)
 static int atcspi200_hw_claim_bus(struct atcspi200_priv *priv)
 {
 	unsigned int format;
+	int ret;
 
 	atcspi200_write(priv, ATCSPI200_REG_CTRL,
 			atcspi200_read(priv, ATCSPI200_REG_CTRL) |
 			TXFRST | RXFRST | SPIRST);
-	while ((atcspi200_read(priv, ATCSPI200_REG_CTRL) &
-		(TXFRST | RXFRST | SPIRST)) && priv->to--)
-		if (!priv->to)
-			return -EINVAL;
+	ret = wait_for_bit_le32(priv->regs + ATCSPI200_REG_CTRL,
+				TXFRST | RXFRST | SPIRST,
+				false, SPI_TIMEOUT_MS, false);
+	if (ret)
+		return ret;
 
 	priv->cmd_len = 0;
 	format = priv->mode | FIELD_PREP(DATA_LEN_MASK, 8 - 1);
@@ -176,12 +179,8 @@ static int atcspi200_hw_start(struct atcspi200_priv *priv)
 
 static int atcspi200_hw_stop(struct atcspi200_priv *priv)
 {
-	while ((atcspi200_read(priv, ATCSPI200_REG_STATUS) & SPIBSY) &&
-	       priv->to--)
-		if (!priv->to)
-			return -EINVAL;
-
-	return 0;
+	return wait_for_bit_le32(priv->regs + ATCSPI200_REG_STATUS,
+				 SPIBSY, false, SPI_TIMEOUT_MS, false);
 }
 
 static void atcspi200_tx_byte(struct atcspi200_priv *priv, const void *dout)
@@ -209,7 +208,8 @@ static int atcspi200_hw_xfer(struct atcspi200_priv *priv,
 	size_t cmd_len = priv->cmd_len;
 	unsigned long data_len = bitlen / 8;
 	int rf_cnt;
-	int ret = 0, timeout = 0;
+	int ret = 0;
+	unsigned long start;
 
 	max_tran_len = priv->max_transfer_length;
 	switch (flags) {
@@ -252,12 +252,17 @@ static int atcspi200_hw_xfer(struct atcspi200_priv *priv,
 		priv->tran_len = tran_len;
 		num_blks = DIV_ROUND_UP(tran_len, CHUNK_SIZE);
 		num_bytes = tran_len % CHUNK_SIZE;
-		timeout = SPI_TIMEOUT;
 		if (num_bytes == 0)
 			num_bytes = CHUNK_SIZE;
+		start = get_timer(0);
 		atcspi200_hw_start(priv);
 
-		while (num_blks && timeout--) {
+		while (num_blks) {
+			if (get_timer(start) > SPI_TIMEOUT_MS) {
+				debug("spi_xfer: %s() timeout\n", __func__);
+				break;
+			}
+
 			event = atcspi200_read(priv, ATCSPI200_REG_STATUS);
 
 			if ((event & TXEPTY) && data_out) {
@@ -282,11 +287,6 @@ static int atcspi200_hw_xfer(struct atcspi200_priv *priv,
 					din = (unsigned char *)din + rx_bytes;
 				}
 			}
-
-			if (!timeout) {
-				debug("spi_xfer: %s() timeout\n", __func__);
-				break;
-			}
 		}
 
 		data_len -= tran_len;
@@ -385,7 +385,6 @@ static int atcspi200_spi_probe(struct udevice *bus)
 {
 	struct atcspi200_priv *priv = dev_get_priv(bus);
 
-	priv->to = SPI_TIMEOUT;
 	priv->max_transfer_length = MAX_TRANSFER_LEN;
 	atcspi200_spi_get_clk(bus);
 
-- 
2.34.1

