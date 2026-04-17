Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E1AF8E4A0
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 02:41:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60497842BF;
	Fri, 17 Apr 2026 04:41:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8030384223; Fri, 17 Apr 2026 04:41:06 +0200 (CEST)
Received: from Atcsqr.andestech.com (exmail.andestech.com [60.248.187.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F013F84228
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 04:40:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTP id 63H2edcp033481;
 Fri, 17 Apr 2026 10:40:39 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 Apr
 2026 10:40:39 +0800
From: Leo Yu-Chi Liang <ycliang@andestech.com>
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Vignesh R <vigneshr@ti.com>, "Takahiro
 Kuwano" <takahiro.kuwano@infineon.com>, Jagan Teki
 <jagan@amarulasolutions.com>, <ycliang@andestech.com>
Subject: [PATCH 6/8] spi: atcspi200: Add data merge mode support
Date: Fri, 17 Apr 2026 10:40:32 +0800
Message-ID: <20260417024034.4046667-2-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417024034.4046667-1-ycliang@andestech.com>
References: <20260417024034.4046667-1-ycliang@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 63H2edcp033481
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

Add CONFIG_ATCSPI200_SPI_DATA_MERGE option to enable 4-byte data
merge mode for the ATCSPI200 SPI controller. When enabled, each
write to the data register transmits four bytes, and each read
retrieves four bytes as a single word, improving throughput for
aligned transfers.

- Add DATA_MERGE bit (bit 7) in format register
- Add data_merge field to private data structure
- Update TX/RX helpers to handle u32 access when data_merge is active
- Dynamically enable/disable data merge based on transfer alignment
  (nbytes % 4 == 0) in both spi-mem exec_op and legacy xfer paths
- Use IS_ENABLED() consistently for the Kconfig check
- Add Kconfig entry with proper depends on ATCSPI200_SPI

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 drivers/spi/Kconfig         |  9 ++++++
 drivers/spi/atcspi200_spi.c | 62 ++++++++++++++++++++++++++++++-------
 2 files changed, 59 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 4ff17617d99..f238b2c2534 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -92,6 +92,15 @@ config ATCSPI200_SPI
 	  used to access the SPI flash on AE3XX and AE250 platforms embedding
 	  this Andestech IP core.
 
+config ATCSPI200_SPI_DATA_MERGE
+	bool "Enable ATCSPI200 data merge mode"
+	depends on ATCSPI200_SPI
+	help
+	  Enable data merge mode for the ATCSPI200 SPI controller.
+	  When enabled, each write to the data register transmits four
+	  bytes, and each read retrieves four bytes as a single word.
+	  This improves throughput for aligned transfers.
+
 config ATH79_SPI
 	bool "Atheros SPI driver"
 	depends on ARCH_ATH79
diff --git a/drivers/spi/atcspi200_spi.c b/drivers/spi/atcspi200_spi.c
index cef0bb8188d..b743f80fb8d 100644
--- a/drivers/spi/atcspi200_spi.c
+++ b/drivers/spi/atcspi200_spi.c
@@ -36,6 +36,7 @@
 /* FORMAT register fields */
 #define ADDR_LEN_MASK		GENMASK(17, 16)
 #define DATA_LEN_MASK		GENMASK(12, 8)
+#define DATA_MERGE		BIT(7)
 
 /* TCTRL register fields */
 #define TCTRL_CMD_EN		BIT(30)
@@ -89,6 +90,7 @@ struct atcspi200_priv {
 	size_t		tran_len;
 	void		*din;
 	const void	*dout;
+	bool		data_merge;
 	unsigned int	max_transfer_length;
 };
 
@@ -149,6 +151,10 @@ static int atcspi200_hw_claim_bus(struct atcspi200_priv *priv)
 	priv->cmd_len = 0;
 	format = priv->mode | FIELD_PREP(DATA_LEN_MASK, 8 - 1) |
 		 FIELD_PREP(ADDR_LEN_MASK, 3 - 1);
+	if (IS_ENABLED(CONFIG_ATCSPI200_SPI_DATA_MERGE)) {
+		format |= DATA_MERGE;
+		priv->data_merge = true;
+	}
 	atcspi200_write(priv, ATCSPI200_REG_FORMAT, format);
 	atcspi200_hw_set_speed(priv);
 
@@ -182,20 +188,27 @@ static int atcspi200_hw_stop(struct atcspi200_priv *priv)
 				 SPIBSY, false, SPI_TIMEOUT_MS, false);
 }
 
-static void atcspi200_tx_byte(struct atcspi200_priv *priv, const void *dout)
+static void atcspi200_tx(struct atcspi200_priv *priv, const void *dout)
 {
-	atcspi200_write(priv, ATCSPI200_REG_DATA, *(u8 *)dout);
+	if (priv->data_merge)
+		atcspi200_write(priv, ATCSPI200_REG_DATA, *(u32 *)dout);
+	else
+		atcspi200_write(priv, ATCSPI200_REG_DATA, *(u8 *)dout);
 }
 
-static void atcspi200_rx_byte(struct atcspi200_priv *priv, void *din)
+static void atcspi200_rx(struct atcspi200_priv *priv, void *din)
 {
-	*(u8 *)din = (u8)atcspi200_read(priv, ATCSPI200_REG_DATA);
+	if (priv->data_merge)
+		*(u32 *)din = atcspi200_read(priv, ATCSPI200_REG_DATA);
+	else
+		*(u8 *)din = (u8)atcspi200_read(priv, ATCSPI200_REG_DATA);
 }
 
 static void atcspi200_pio_transfer(struct atcspi200_priv *priv,
 				   void *din, const void *dout,
 				   unsigned int len)
 {
+	unsigned int step = priv->data_merge ? 4 : 1;
 	unsigned int tx_remain = dout ? len : 0;
 	unsigned int rx_remain = din ? len : 0;
 	unsigned long start = get_timer(0);
@@ -205,15 +218,15 @@ static void atcspi200_pio_transfer(struct atcspi200_priv *priv,
 		u32 status = atcspi200_read(priv, ATCSPI200_REG_STATUS);
 
 		if (tx_remain && !(status & TXFFL)) {
-			atcspi200_tx_byte(priv, dout);
-			dout = (const u8 *)dout + 1;
-			tx_remain--;
+			atcspi200_tx(priv, dout);
+			dout = (const u8 *)dout + step;
+			tx_remain -= step;
 		}
 
 		if (rx_remain && (status & RXFVE_MASK)) {
-			atcspi200_rx_byte(priv, din);
-			din = (u8 *)din + 1;
-			rx_remain--;
+			atcspi200_rx(priv, din);
+			din = (u8 *)din + step;
+			rx_remain -= step;
 		}
 	}
 
@@ -232,6 +245,19 @@ static int atcspi200_hw_xfer(struct atcspi200_priv *priv,
 	unsigned long data_len = bitlen / 8;
 	int ret = 0;
 
+	if (IS_ENABLED(CONFIG_ATCSPI200_SPI_DATA_MERGE)) {
+		u32 format = atcspi200_read(priv, ATCSPI200_REG_FORMAT);
+
+		if (data_len % 4 == 0) {
+			format |= DATA_MERGE;
+			priv->data_merge = true;
+		} else {
+			format &= ~DATA_MERGE;
+			priv->data_merge = false;
+		}
+		atcspi200_write(priv, ATCSPI200_REG_FORMAT, format);
+	}
+
 	max_tran_len = priv->max_transfer_length;
 	switch (flags) {
 	case SPI_XFER_BEGIN:
@@ -335,13 +361,25 @@ static int atcspi200_spi_mem_exec_op(struct spi_slave *slave,
 	u32 format;
 	int ret;
 
+	format = atcspi200_read(priv, ATCSPI200_REG_FORMAT);
+
+	/* Dynamically enable/disable data merge based on alignment */
+	if (IS_ENABLED(CONFIG_ATCSPI200_SPI_DATA_MERGE)) {
+		if (op->data.nbytes && (op->data.nbytes % 4 == 0)) {
+			format |= DATA_MERGE;
+			priv->data_merge = true;
+		} else {
+			format &= ~DATA_MERGE;
+			priv->data_merge = false;
+		}
+	}
+
 	/* Update address length in format register if needed */
 	if (op->addr.nbytes) {
-		format = atcspi200_read(priv, ATCSPI200_REG_FORMAT);
 		format &= ~ADDR_LEN_MASK;
 		format |= FIELD_PREP(ADDR_LEN_MASK, op->addr.nbytes - 1);
-		atcspi200_write(priv, ATCSPI200_REG_FORMAT, format);
 	}
+	atcspi200_write(priv, ATCSPI200_REG_FORMAT, format);
 
 	/* Set up transfer control for this operation */
 	atcspi200_set_transfer_ctl(priv, op);
-- 
2.34.1

