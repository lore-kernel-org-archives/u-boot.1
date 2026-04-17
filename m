Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E495F8E499
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 02:41:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC46B84258;
	Fri, 17 Apr 2026 04:41:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6B2E84223; Fri, 17 Apr 2026 04:41:03 +0200 (CEST)
Received: from Atcsqr.andestech.com (unknown [60.248.187.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F8D684223
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 04:40:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTP id 63H2edpU033480;
 Fri, 17 Apr 2026 10:40:39 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 Apr
 2026 10:40:38 +0800
From: Leo Yu-Chi Liang <ycliang@andestech.com>
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Vignesh R <vigneshr@ti.com>, "Takahiro
 Kuwano" <takahiro.kuwano@infineon.com>, Jagan Teki
 <jagan@amarulasolutions.com>, <ycliang@andestech.com>
Subject: [PATCH 5/8] spi: atcspi200: Add spi-mem framework support
Date: Fri, 17 Apr 2026 10:40:31 +0800
Message-ID: <20260417024034.4046667-1-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 63H2edpU033480
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

Add spi_controller_mem_ops implementation to support SPI memory
operations with single, dual, and quad modes:

- Add atcspi200_spi_mem_exec_op() for executing SPI memory operations
  with proper command, address, dummy, and data phase handling
- Add atcspi200_set_transfer_ctl() to configure the transfer control
  register for different bus widths and transfer modes
- Add atcspi200_pio_transfer() as a shared PIO data pump used by both
  the spi-mem exec_op and legacy xfer paths
- Add atcspi200_spi_adjust_op_size() to cap transfers to hardware max
- Add new TCTRL field definitions for cmd/addr enable, address format,
  dual/quad mode, dummy count, and token enable
- Add ADDR_LEN_MASK for configurable address length in format register
- Wire spi_controller_mem_ops into dm_spi_ops.mem_ops
- Simplify hw_start() for the legacy xfer path since cmd/addr handling
  is now done by the spi-mem framework for flash operations

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 drivers/spi/atcspi200_spi.c | 208 ++++++++++++++++++++++++++----------
 1 file changed, 151 insertions(+), 57 deletions(-)

diff --git a/drivers/spi/atcspi200_spi.c b/drivers/spi/atcspi200_spi.c
index 0e7f7b83081..cef0bb8188d 100644
--- a/drivers/spi/atcspi200_spi.c
+++ b/drivers/spi/atcspi200_spi.c
@@ -11,6 +11,7 @@
 #include <dm/device_compat.h>
 #include <log.h>
 #include <spi.h>
+#include <spi-mem.h>
 #include <time.h>
 #include <wait_bit.h>
 #include <asm/io.h>
@@ -33,9 +34,13 @@
 #define ATCSPI200_REG_TIMING	0x40
 
 /* FORMAT register fields */
+#define ADDR_LEN_MASK		GENMASK(17, 16)
 #define DATA_LEN_MASK		GENMASK(12, 8)
 
 /* TCTRL register fields */
+#define TCTRL_CMD_EN		BIT(30)
+#define TCTRL_ADDR_EN		BIT(29)
+#define TCTRL_ADDR_FMT		BIT(28)
 #define TRAMODE_MASK		GENMASK(27, 24)
 #define TRAMODE_WR_SYNC		FIELD_PREP(TRAMODE_MASK, 0)
 #define TRAMODE_WO		FIELD_PREP(TRAMODE_MASK, 1)
@@ -47,7 +52,11 @@
 #define TRAMODE_NONE		FIELD_PREP(TRAMODE_MASK, 7)
 #define TRAMODE_DW		FIELD_PREP(TRAMODE_MASK, 8)
 #define TRAMODE_DR		FIELD_PREP(TRAMODE_MASK, 9)
+#define TCTRL_DUAL_QUAD_MASK	GENMASK(23, 22)
+#define TCTRL_TOKEN_EN		BIT(21)
 #define WCNT_MASK		GENMASK(20, 12)
+#define TCTRL_TOKEN_VAL		BIT(11)
+#define TCTRL_DUMMY_CNT_MASK	GENMASK(10, 9)
 #define RCNT_MASK		GENMASK(8, 0)
 
 /* CTRL register fields */
@@ -78,8 +87,8 @@ struct atcspi200_priv {
 	u8		cmd_buf[16];
 	size_t		data_len;
 	size_t		tran_len;
-	u8		*din;
-	u8		*dout;
+	void		*din;
+	const void	*dout;
 	unsigned int	max_transfer_length;
 };
 
@@ -138,7 +147,8 @@ static int atcspi200_hw_claim_bus(struct atcspi200_priv *priv)
 		return ret;
 
 	priv->cmd_len = 0;
-	format = priv->mode | FIELD_PREP(DATA_LEN_MASK, 8 - 1);
+	format = priv->mode | FIELD_PREP(DATA_LEN_MASK, 8 - 1) |
+		 FIELD_PREP(ADDR_LEN_MASK, 3 - 1);
 	atcspi200_write(priv, ATCSPI200_REG_FORMAT, format);
 	atcspi200_hw_set_speed(priv);
 
@@ -147,22 +157,15 @@ static int atcspi200_hw_claim_bus(struct atcspi200_priv *priv)
 
 static int atcspi200_hw_start(struct atcspi200_priv *priv)
 {
-	int i, olen = 0;
-	u32 tc;
+	u32 tc = 0;
 
-	tc = atcspi200_read(priv, ATCSPI200_REG_TCTRL);
-	tc &= ~(WCNT_MASK | RCNT_MASK | TRAMODE_MASK);
-
-	if (priv->din && priv->cmd_len)
-		tc |= TRAMODE_WR;
-	else if (priv->din)
+	if (priv->din && !priv->dout)
 		tc |= TRAMODE_RO;
-	else
+	else if (priv->dout && !priv->din)
 		tc |= TRAMODE_WO;
 
 	if (priv->dout)
-		olen = priv->tran_len;
-	tc |= FIELD_PREP(WCNT_MASK, priv->cmd_len + olen - 1);
+		tc |= FIELD_PREP(WCNT_MASK, priv->tran_len - 1);
 
 	if (priv->din)
 		tc |= FIELD_PREP(RCNT_MASK, priv->tran_len - 1);
@@ -170,9 +173,6 @@ static int atcspi200_hw_start(struct atcspi200_priv *priv)
 	atcspi200_write(priv, ATCSPI200_REG_TCTRL, tc);
 	atcspi200_write(priv, ATCSPI200_REG_CMD, 1);
 
-	for (i = 0; i < priv->cmd_len; i++)
-		atcspi200_write(priv, ATCSPI200_REG_DATA, priv->cmd_buf[i]);
-
 	return 0;
 }
 
@@ -192,19 +192,45 @@ static void atcspi200_rx_byte(struct atcspi200_priv *priv, void *din)
 	*(u8 *)din = (u8)atcspi200_read(priv, ATCSPI200_REG_DATA);
 }
 
+static void atcspi200_pio_transfer(struct atcspi200_priv *priv,
+				   void *din, const void *dout,
+				   unsigned int len)
+{
+	unsigned int tx_remain = dout ? len : 0;
+	unsigned int rx_remain = din ? len : 0;
+	unsigned long start = get_timer(0);
+
+	while ((tx_remain || rx_remain) &&
+	       get_timer(start) <= SPI_TIMEOUT_MS) {
+		u32 status = atcspi200_read(priv, ATCSPI200_REG_STATUS);
+
+		if (tx_remain && !(status & TXFFL)) {
+			atcspi200_tx_byte(priv, dout);
+			dout = (const u8 *)dout + 1;
+			tx_remain--;
+		}
+
+		if (rx_remain && (status & RXFVE_MASK)) {
+			atcspi200_rx_byte(priv, din);
+			din = (u8 *)din + 1;
+			rx_remain--;
+		}
+	}
+
+	if (tx_remain || rx_remain)
+		debug("%s: timeout, tx_remain=%u rx_remain=%u\n",
+		      __func__, tx_remain, rx_remain);
+}
+
 static int atcspi200_hw_xfer(struct atcspi200_priv *priv,
 			     unsigned int bitlen, const void *data_out,
 			     void *data_in, unsigned long flags)
 {
-	unsigned int event;
-	const void *dout = NULL;
-	void *din = NULL;
-	int num_blks, num_chunks, max_tran_len, tran_len;
+	unsigned int num_chunks, max_tran_len, tran_len;
 	u8 *cmd_buf = priv->cmd_buf;
 	size_t cmd_len = priv->cmd_len;
 	unsigned long data_len = bitlen / 8;
 	int ret = 0;
-	unsigned long start;
 
 	max_tran_len = priv->max_transfer_length;
 	switch (flags) {
@@ -218,19 +244,14 @@ static int atcspi200_hw_xfer(struct atcspi200_priv *priv,
 		if (bitlen == 0)
 			return 0;
 		priv->data_len = data_len;
-		priv->din = (u8 *)data_in;
-		priv->dout = (u8 *)data_out;
+		priv->din = data_in;
+		priv->dout = data_out;
 		break;
 
 	case SPI_XFER_BEGIN | SPI_XFER_END:
-		priv->data_len = 0;
-		priv->din = 0;
-		priv->dout = 0;
-		cmd_len = priv->cmd_len = data_len;
-		memcpy(cmd_buf, data_out, cmd_len);
-		data_out = 0;
-		data_len = 0;
-		atcspi200_hw_start(priv);
+		priv->data_len = data_len;
+		priv->din = data_in;
+		priv->dout = data_out;
 		break;
 	}
 
@@ -240,35 +261,11 @@ static int atcspi200_hw_xfer(struct atcspi200_priv *priv,
 		      data_in, data_len);
 
 	num_chunks = DIV_ROUND_UP(data_len, max_tran_len);
-	din = data_in;
-	dout = data_out;
 	while (num_chunks--) {
 		tran_len = min((size_t)data_len, (size_t)max_tran_len);
 		priv->tran_len = tran_len;
-		num_blks = tran_len;
-		start = get_timer(0);
 		atcspi200_hw_start(priv);
-
-		while (num_blks) {
-			if (get_timer(start) > SPI_TIMEOUT_MS) {
-				debug("spi_xfer: %s() timeout\n", __func__);
-				break;
-			}
-
-			event = atcspi200_read(priv, ATCSPI200_REG_STATUS);
-
-			if ((event & TXEPTY) && data_out) {
-				atcspi200_tx_byte(priv, dout);
-				num_blks--;
-				dout++;
-			}
-
-			if ((event & RXFVE_MASK) && data_in) {
-				atcspi200_rx_byte(priv, din);
-				num_blks--;
-				din = (unsigned char *)din + 1;
-			}
-		}
+		atcspi200_pio_transfer(priv, priv->din, priv->dout, tran_len);
 
 		data_len -= tran_len;
 		if (data_len) {
@@ -288,6 +285,97 @@ static int atcspi200_hw_xfer(struct atcspi200_priv *priv,
 	return ret;
 }
 
+static void atcspi200_set_transfer_ctl(struct atcspi200_priv *priv,
+				       const struct spi_mem_op *op)
+{
+	u32 tc = 0;
+
+	if (op->cmd.nbytes)
+		tc |= TCTRL_CMD_EN;
+
+	if (op->addr.nbytes) {
+		tc |= TCTRL_ADDR_EN;
+		if (op->addr.buswidth > 1)
+			tc |= TCTRL_ADDR_FMT;
+	}
+
+	if (op->data.nbytes) {
+		if (op->data.buswidth == 2)
+			tc |= FIELD_PREP(TCTRL_DUAL_QUAD_MASK, 1);
+		else if (op->data.buswidth == 4)
+			tc |= FIELD_PREP(TCTRL_DUAL_QUAD_MASK, 2);
+
+		if (op->data.dir == SPI_MEM_DATA_IN) {
+			if (op->dummy.nbytes) {
+				tc |= TRAMODE_DR;
+				tc |= FIELD_PREP(TCTRL_DUMMY_CNT_MASK,
+						 op->dummy.nbytes - 1);
+				if (op->data.buswidth == 4)
+					tc |= TCTRL_TOKEN_EN;
+			} else {
+				tc |= TRAMODE_RO;
+			}
+			tc |= FIELD_PREP(RCNT_MASK, op->data.nbytes - 1);
+		} else {
+			tc |= TRAMODE_WO;
+			tc |= FIELD_PREP(WCNT_MASK, op->data.nbytes - 1);
+		}
+	} else {
+		tc |= TRAMODE_NONE;
+	}
+
+	atcspi200_write(priv, ATCSPI200_REG_TCTRL, tc);
+}
+
+static int atcspi200_spi_mem_exec_op(struct spi_slave *slave,
+				     const struct spi_mem_op *op)
+{
+	struct udevice *bus = slave->dev->parent;
+	struct atcspi200_priv *priv = dev_get_priv(bus);
+	u32 format;
+	int ret;
+
+	/* Update address length in format register if needed */
+	if (op->addr.nbytes) {
+		format = atcspi200_read(priv, ATCSPI200_REG_FORMAT);
+		format &= ~ADDR_LEN_MASK;
+		format |= FIELD_PREP(ADDR_LEN_MASK, op->addr.nbytes - 1);
+		atcspi200_write(priv, ATCSPI200_REG_FORMAT, format);
+	}
+
+	/* Set up transfer control for this operation */
+	atcspi200_set_transfer_ctl(priv, op);
+
+	/* Write address and command to hardware */
+	if (op->addr.nbytes)
+		atcspi200_write(priv, ATCSPI200_REG_ADDR, op->addr.val);
+	atcspi200_write(priv, ATCSPI200_REG_CMD, op->cmd.opcode);
+
+	/* Transfer data via PIO */
+	if (op->data.nbytes) {
+		void *din = NULL;
+		const void *dout = NULL;
+
+		if (op->data.dir == SPI_MEM_DATA_IN)
+			din = op->data.buf.in;
+		else
+			dout = op->data.buf.out;
+
+		atcspi200_pio_transfer(priv, din, dout, op->data.nbytes);
+	}
+
+	ret = atcspi200_hw_stop(priv);
+
+	return ret;
+}
+
+static int atcspi200_spi_adjust_op_size(struct spi_slave *slave,
+					struct spi_mem_op *op)
+{
+	op->data.nbytes = min(op->data.nbytes, (unsigned int)MAX_TRANSFER_LEN);
+	return 0;
+}
+
 static int atcspi200_spi_set_speed(struct udevice *bus, uint max_hz)
 {
 	struct atcspi200_priv *priv = dev_get_priv(bus);
@@ -390,12 +478,18 @@ static int atcspi200_spi_of_to_plat(struct udevice *bus)
 	return 0;
 }
 
+static const struct spi_controller_mem_ops atcspi200_spi_mem_ops = {
+	.exec_op = atcspi200_spi_mem_exec_op,
+	.adjust_op_size = atcspi200_spi_adjust_op_size,
+};
+
 static const struct dm_spi_ops atcspi200_spi_ops = {
 	.claim_bus	= atcspi200_spi_claim_bus,
 	.release_bus	= atcspi200_spi_release_bus,
 	.xfer		= atcspi200_spi_xfer,
 	.set_speed	= atcspi200_spi_set_speed,
 	.set_mode	= atcspi200_spi_set_mode,
+	.mem_ops	= &atcspi200_spi_mem_ops,
 };
 
 static const struct udevice_id atcspi200_spi_ids[] = {
-- 
2.34.1

