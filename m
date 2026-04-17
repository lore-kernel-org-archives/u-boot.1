Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A13DF8E49E
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 02:21:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E467984214;
	Fri, 17 Apr 2026 04:21:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C35883EEF; Fri, 17 Apr 2026 04:21:30 +0200 (CEST)
Received: from Atcsqr.andestech.com (exmail.andestech.com [60.248.187.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FF1E83FC0
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 04:21:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTP id 63H2LAtN015784;
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
Subject: [PATCH 1/8] spi: atcspi200: Clean up register access, macros, naming,
 DT parsing, and style
Date: Fri, 17 Apr 2026 10:20:57 +0800
Message-ID: <20260417022104.3973576-2-ycliang@andestech.com>
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
X-MAIL: Atcsqr.andestech.com 63H2LAtN015784
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

Modernize the ATCSPI200 SPI controller driver:

- Replace volatile struct pointer register access with readl()/writel()
  using register offset defines and inline wrappers
- Convert bit field macros from raw shifts to BIT()/GENMASK()/FIELD_PREP()
- Remove unused macros (SPI0_BUS, SPI1_BUS, SPI0_BASE, SPI1_BASE,
  NSPI_MAX_CS_NUM) and unused includes (malloc.h, asm/global_data.h)
- Remove empty __atcspi200_spi_release_bus() function
- Modernize DT parsing: replace fdtdec_get_int() with
  dev_read_u32_default(), map_physmem() with dev_remap_addr()
- Rename struct nds_spi_slave to atcspi200_priv, ns to priv
- Remove __ prefix from static helpers, rename for consistency
- Fix typo: atcspi200_ofdata_to_platadata -> atcspi200_spi_of_to_plat
- Fix coding style: spacing, braces, indentation throughout

No functional change.

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 drivers/spi/atcspi200_spi.c | 471 ++++++++++++++++++------------------
 1 file changed, 234 insertions(+), 237 deletions(-)

diff --git a/drivers/spi/atcspi200_spi.c b/drivers/spi/atcspi200_spi.c
index 72b612c6560..8cae96ee23c 100644
--- a/drivers/spi/atcspi200_spi.c
+++ b/drivers/spi/atcspi200_spi.c
@@ -7,75 +7,63 @@
  */
 
 #include <clk.h>
+#include <dm.h>
+#include <dm/device_compat.h>
 #include <log.h>
-#include <malloc.h>
 #include <spi.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
-#include <dm.h>
-
-DECLARE_GLOBAL_DATA_PTR;
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
 
 #define MAX_TRANSFER_LEN	512
 #define CHUNK_SIZE		1
 #define SPI_TIMEOUT		0x100000
-#define SPI0_BUS		0
-#define SPI1_BUS		1
-#define SPI0_BASE		0xf0b00000
-#define SPI1_BASE		0xf0f00000
-#define NSPI_MAX_CS_NUM		1
-
-struct atcspi200_spi_regs {
-	u32	rev;
-	u32	reserve1[3];
-	u32	format;		/* 0x10 */
-#define DATA_LENGTH(x)	((x-1)<<8)
-	u32	pio;
-	u32	reserve2[2];
-	u32	tctrl;		/* 0x20 */
-#define TRAMODE_OFFSET	24
-#define TRAMODE_MASK	(0x0F<<TRAMODE_OFFSET)
-#define TRAMODE_WR_SYNC	(0<<TRAMODE_OFFSET)
-#define TRAMODE_WO	(1<<TRAMODE_OFFSET)
-#define TRAMODE_RO	(2<<TRAMODE_OFFSET)
-#define TRAMODE_WR	(3<<TRAMODE_OFFSET)
-#define TRAMODE_RW	(4<<TRAMODE_OFFSET)
-#define TRAMODE_WDR	(5<<TRAMODE_OFFSET)
-#define TRAMODE_RDW	(6<<TRAMODE_OFFSET)
-#define TRAMODE_NONE	(7<<TRAMODE_OFFSET)
-#define TRAMODE_DW	(8<<TRAMODE_OFFSET)
-#define TRAMODE_DR	(9<<TRAMODE_OFFSET)
-#define WCNT_OFFSET	12
-#define WCNT_MASK	(0x1FF<<WCNT_OFFSET)
-#define RCNT_OFFSET	0
-#define RCNT_MASK	(0x1FF<<RCNT_OFFSET)
-	u32	cmd;
-	u32	addr;
-	u32	data;
-	u32	ctrl;		/* 0x30 */
-#define TXFTH_OFFSET	16
-#define RXFTH_OFFSET	8
-#define TXDMAEN		(1<<4)
-#define RXDMAEN		(1<<3)
-#define TXFRST		(1<<2)
-#define RXFRST		(1<<1)
-#define SPIRST		(1<<0)
-	u32	status;
-#define TXFFL		(1<<23)
-#define TXEPTY		(1<<22)
-#define TXFVE_MASK	(0x1F<<16)
-#define RXFEM		(1<<14)
-#define RXFVE_OFFSET	(8)
-#define RXFVE_MASK	(0x1F<<RXFVE_OFFSET)
-#define SPIBSY		(1<<0)
-	u32	inten;
-	u32	intsta;
-	u32	timing;		/* 0x40 */
-#define SCLK_DIV_MASK	0xFF
-};
 
-struct nds_spi_slave {
-	volatile struct atcspi200_spi_regs *regs;
+/* Register offsets */
+#define ATCSPI200_REG_FORMAT	0x10
+#define ATCSPI200_REG_TCTRL	0x20
+#define ATCSPI200_REG_CMD	0x24
+#define ATCSPI200_REG_ADDR	0x28
+#define ATCSPI200_REG_DATA	0x2c
+#define ATCSPI200_REG_CTRL	0x30
+#define ATCSPI200_REG_STATUS	0x34
+#define ATCSPI200_REG_TIMING	0x40
+
+/* FORMAT register fields */
+#define DATA_LEN_MASK		GENMASK(12, 8)
+
+/* TCTRL register fields */
+#define TRAMODE_MASK		GENMASK(27, 24)
+#define TRAMODE_WR_SYNC		FIELD_PREP(TRAMODE_MASK, 0)
+#define TRAMODE_WO		FIELD_PREP(TRAMODE_MASK, 1)
+#define TRAMODE_RO		FIELD_PREP(TRAMODE_MASK, 2)
+#define TRAMODE_WR		FIELD_PREP(TRAMODE_MASK, 3)
+#define TRAMODE_RW		FIELD_PREP(TRAMODE_MASK, 4)
+#define TRAMODE_WDR		FIELD_PREP(TRAMODE_MASK, 5)
+#define TRAMODE_RDW		FIELD_PREP(TRAMODE_MASK, 6)
+#define TRAMODE_NONE		FIELD_PREP(TRAMODE_MASK, 7)
+#define TRAMODE_DW		FIELD_PREP(TRAMODE_MASK, 8)
+#define TRAMODE_DR		FIELD_PREP(TRAMODE_MASK, 9)
+#define WCNT_MASK		GENMASK(20, 12)
+#define RCNT_MASK		GENMASK(8, 0)
+
+/* CTRL register fields */
+#define TXFRST			BIT(2)
+#define RXFRST			BIT(1)
+#define SPIRST			BIT(0)
+
+/* STATUS register fields */
+#define TXFFL			BIT(23)
+#define TXEPTY			BIT(22)
+#define TXFVE_MASK		GENMASK(20, 16)
+#define RXFVE_MASK		GENMASK(12, 8)
+#define SPIBSY			BIT(0)
+
+/* TIMING register fields */
+#define SCLK_DIV_MASK		GENMASK(7, 0)
+
+struct atcspi200_priv {
+	void		*regs;
 	int		to;
 	unsigned int	freq;
 	ulong		clock;
@@ -88,265 +76,278 @@ struct nds_spi_slave {
 	size_t		tran_len;
 	u8		*din;
 	u8		*dout;
-	unsigned int    max_transfer_length;
+	unsigned int	max_transfer_length;
 };
 
-static int __atcspi200_spi_set_speed(struct nds_spi_slave *ns)
+static inline u32 atcspi200_read(struct atcspi200_priv *priv, u32 offset)
+{
+	return readl(priv->regs + offset);
+}
+
+static inline void atcspi200_write(struct atcspi200_priv *priv, u32 offset,
+				   u32 val)
+{
+	writel(val, priv->regs + offset);
+}
+
+static int atcspi200_hw_set_speed(struct atcspi200_priv *priv)
 {
 	u32 tm;
 	u8 div;
-	tm = ns->regs->timing;
+
+	tm = atcspi200_read(priv, ATCSPI200_REG_TIMING);
 	tm &= ~SCLK_DIV_MASK;
 
-	if(ns->freq >= ns->clock)
-		div =0xff;
-	else{
+	if (priv->freq >= priv->clock) {
+		div = 0xff;
+	} else {
 		for (div = 0; div < 0xff; div++) {
-			if (ns->freq >= ns->clock / (2 * (div + 1)))
+			if (priv->freq >= priv->clock / (2 * (div + 1)))
 				break;
 		}
 	}
 
 	tm |= div;
-	ns->regs->timing = tm;
+	atcspi200_write(priv, ATCSPI200_REG_TIMING, tm);
 
 	return 0;
-
 }
 
-static int __atcspi200_spi_claim_bus(struct nds_spi_slave *ns)
+static int atcspi200_hw_claim_bus(struct atcspi200_priv *priv)
 {
-		unsigned int format=0;
-		ns->regs->ctrl |= (TXFRST|RXFRST|SPIRST);
-		while((ns->regs->ctrl &(TXFRST|RXFRST|SPIRST))&&(ns->to--))
-			if(!ns->to)
-				return -EINVAL;
-
-		ns->cmd_len = 0;
-		format = ns->mode|DATA_LENGTH(8);
-		ns->regs->format = format;
-		__atcspi200_spi_set_speed(ns);
+	unsigned int format;
+
+	atcspi200_write(priv, ATCSPI200_REG_CTRL,
+			atcspi200_read(priv, ATCSPI200_REG_CTRL) |
+			TXFRST | RXFRST | SPIRST);
+	while ((atcspi200_read(priv, ATCSPI200_REG_CTRL) &
+		(TXFRST | RXFRST | SPIRST)) && priv->to--)
+		if (!priv->to)
+			return -EINVAL;
 
-		return 0;
-}
+	priv->cmd_len = 0;
+	format = priv->mode | FIELD_PREP(DATA_LEN_MASK, 8 - 1);
+	atcspi200_write(priv, ATCSPI200_REG_FORMAT, format);
+	atcspi200_hw_set_speed(priv);
 
-static int __atcspi200_spi_release_bus(struct nds_spi_slave *ns)
-{
-	/* do nothing */
 	return 0;
 }
 
-static int __atcspi200_spi_start(struct nds_spi_slave *ns)
+static int atcspi200_hw_start(struct atcspi200_priv *priv)
 {
-	int i,olen=0;
-	int tc = ns->regs->tctrl;
+	int i, olen = 0;
+	u32 tc;
 
-	tc &= ~(WCNT_MASK|RCNT_MASK|TRAMODE_MASK);
-	if ((ns->din)&&(ns->cmd_len))
+	tc = atcspi200_read(priv, ATCSPI200_REG_TCTRL);
+	tc &= ~(WCNT_MASK | RCNT_MASK | TRAMODE_MASK);
+
+	if (priv->din && priv->cmd_len)
 		tc |= TRAMODE_WR;
-	else if (ns->din)
+	else if (priv->din)
 		tc |= TRAMODE_RO;
 	else
 		tc |= TRAMODE_WO;
 
-	if(ns->dout)
-		olen = ns->tran_len;
-	tc |= (ns->cmd_len+olen-1) << WCNT_OFFSET;
+	if (priv->dout)
+		olen = priv->tran_len;
+	tc |= FIELD_PREP(WCNT_MASK, priv->cmd_len + olen - 1);
 
-	if(ns->din)
-		tc |= (ns->tran_len-1) << RCNT_OFFSET;
+	if (priv->din)
+		tc |= FIELD_PREP(RCNT_MASK, priv->tran_len - 1);
 
-	ns->regs->tctrl = tc;
-	ns->regs->cmd = 1;
+	atcspi200_write(priv, ATCSPI200_REG_TCTRL, tc);
+	atcspi200_write(priv, ATCSPI200_REG_CMD, 1);
 
-	for (i=0;i<ns->cmd_len;i++)
-		ns->regs->data = ns->cmd_buf[i];
+	for (i = 0; i < priv->cmd_len; i++)
+		atcspi200_write(priv, ATCSPI200_REG_DATA, priv->cmd_buf[i]);
 
 	return 0;
 }
 
-static int __atcspi200_spi_stop(struct nds_spi_slave *ns)
+static int atcspi200_hw_stop(struct atcspi200_priv *priv)
 {
-	ns->regs->timing = ns->mtiming;
-	while ((ns->regs->status & SPIBSY)&&(ns->to--))
-		if (!ns->to)
+	atcspi200_write(priv, ATCSPI200_REG_TIMING, priv->mtiming);
+	while ((atcspi200_read(priv, ATCSPI200_REG_STATUS) & SPIBSY) &&
+	       priv->to--)
+		if (!priv->to)
 			return -EINVAL;
 
 	return 0;
 }
 
-static void __nspi_espi_tx(struct nds_spi_slave *ns, const void *dout)
+static void atcspi200_tx_byte(struct atcspi200_priv *priv, const void *dout)
 {
-	ns->regs->data = *(u8 *)dout;
+	atcspi200_write(priv, ATCSPI200_REG_DATA, *(u8 *)dout);
 }
 
-static int __nspi_espi_rx(struct nds_spi_slave *ns, void *din, unsigned int bytes)
+static int atcspi200_rx_byte(struct atcspi200_priv *priv, void *din,
+			     unsigned int bytes)
 {
-	*(u8 *)din = ns->regs->data;
+	*(u8 *)din = (u8)atcspi200_read(priv, ATCSPI200_REG_DATA);
 	return bytes;
 }
 
-static int __atcspi200_spi_xfer(struct nds_spi_slave *ns,
-		unsigned int bitlen,  const void *data_out, void *data_in,
-		unsigned long flags)
+static int atcspi200_hw_xfer(struct atcspi200_priv *priv,
+			     unsigned int bitlen, const void *data_out,
+			     void *data_in, unsigned long flags)
 {
-		unsigned int event, rx_bytes;
-		const void *dout = NULL;
-		void *din = NULL;
-		int num_blks, num_chunks, max_tran_len, tran_len;
-		int num_bytes;
-		u8 *cmd_buf = ns->cmd_buf;
-		size_t cmd_len = ns->cmd_len;
-		unsigned long data_len = bitlen / 8;
-		int rf_cnt;
-		int ret = 0, timeout = 0;
-
-		max_tran_len = ns->max_transfer_length;
-		switch (flags) {
-		case SPI_XFER_BEGIN:
-			cmd_len = ns->cmd_len = data_len;
-			memcpy(cmd_buf, data_out, cmd_len);
+	unsigned int event, rx_bytes;
+	const void *dout = NULL;
+	void *din = NULL;
+	int num_blks, num_chunks, max_tran_len, tran_len;
+	int num_bytes;
+	u8 *cmd_buf = priv->cmd_buf;
+	size_t cmd_len = priv->cmd_len;
+	unsigned long data_len = bitlen / 8;
+	int rf_cnt;
+	int ret = 0, timeout = 0;
+
+	max_tran_len = priv->max_transfer_length;
+	switch (flags) {
+	case SPI_XFER_BEGIN:
+		cmd_len = priv->cmd_len = data_len;
+		memcpy(cmd_buf, data_out, cmd_len);
+		return 0;
+
+	case 0:
+	case SPI_XFER_END:
+		if (bitlen == 0)
 			return 0;
+		priv->data_len = data_len;
+		priv->din = (u8 *)data_in;
+		priv->dout = (u8 *)data_out;
+		break;
+
+	case SPI_XFER_BEGIN | SPI_XFER_END:
+		priv->data_len = 0;
+		priv->din = 0;
+		priv->dout = 0;
+		cmd_len = priv->cmd_len = data_len;
+		memcpy(cmd_buf, data_out, cmd_len);
+		data_out = 0;
+		data_len = 0;
+		atcspi200_hw_start(priv);
+		break;
+	}
 
-		case 0:
-		case SPI_XFER_END:
-			if (bitlen == 0) {
-				return 0;
+	if (data_out)
+		debug("spi_xfer: data_out %08X(%p) data_in %08X(%p) data_len %lu\n",
+		      *(uint *)data_out, data_out, *(uint *)data_in,
+		      data_in, data_len);
+
+	num_chunks = DIV_ROUND_UP(data_len, max_tran_len);
+	din = data_in;
+	dout = data_out;
+	while (num_chunks--) {
+		tran_len = min((size_t)data_len, (size_t)max_tran_len);
+		priv->tran_len = tran_len;
+		num_blks = DIV_ROUND_UP(tran_len, CHUNK_SIZE);
+		num_bytes = tran_len % CHUNK_SIZE;
+		timeout = SPI_TIMEOUT;
+		if (num_bytes == 0)
+			num_bytes = CHUNK_SIZE;
+		atcspi200_hw_start(priv);
+
+		while (num_blks && timeout--) {
+			event = atcspi200_read(priv, ATCSPI200_REG_STATUS);
+
+			if ((event & TXEPTY) && data_out) {
+				atcspi200_tx_byte(priv, dout);
+				num_blks -= CHUNK_SIZE;
+				dout += CHUNK_SIZE;
 			}
-			ns->data_len = data_len;
-			ns->din = (u8 *)data_in;
-			ns->dout = (u8 *)data_out;
-			break;
-
-		case SPI_XFER_BEGIN | SPI_XFER_END:
-			ns->data_len = 0;
-			ns->din = 0;
-			ns->dout = 0;
-			cmd_len = ns->cmd_len = data_len;
-			memcpy(cmd_buf, data_out, cmd_len);
-			data_out = 0;
-			data_len = 0;
-			__atcspi200_spi_start(ns);
-			break;
-		}
-		if (data_out)
-			debug("spi_xfer: data_out %08X(%p) data_in %08X(%p) data_len %lu\n",
-			      *(uint *)data_out, data_out, *(uint *)data_in,
-			      data_in, data_len);
-		num_chunks = DIV_ROUND_UP(data_len, max_tran_len);
-		din = data_in;
-		dout = data_out;
-		while (num_chunks--) {
-			tran_len = min((size_t)data_len, (size_t)max_tran_len);
-			ns->tran_len = tran_len;
-			num_blks = DIV_ROUND_UP(tran_len , CHUNK_SIZE);
-			num_bytes = (tran_len) % CHUNK_SIZE;
-			timeout = SPI_TIMEOUT;
-			if(num_bytes == 0)
-				num_bytes = CHUNK_SIZE;
-			__atcspi200_spi_start(ns);
-
-			while (num_blks && (timeout--)) {
-				event = in_le32(&ns->regs->status);
-				if ((event & TXEPTY) && (data_out)) {
-					__nspi_espi_tx(ns, dout);
-					num_blks -= CHUNK_SIZE;
-					dout += CHUNK_SIZE;
-				}
-
-				if ((event & RXFVE_MASK) && (data_in)) {
-					rf_cnt = ((event & RXFVE_MASK)>> RXFVE_OFFSET);
-					if (rf_cnt >= CHUNK_SIZE)
-						rx_bytes = CHUNK_SIZE;
-					else if (num_blks == 1 && rf_cnt == num_bytes)
-						rx_bytes = num_bytes;
-					else
-						continue;
-
-					if (__nspi_espi_rx(ns, din, rx_bytes) == rx_bytes) {
-						num_blks -= CHUNK_SIZE;
-						din = (unsigned char *)din + rx_bytes;
-					}
-				}
 
-				if (!timeout) {
-					debug("spi_xfer: %s() timeout\n", __func__);
-					break;
+			if ((event & RXFVE_MASK) && data_in) {
+				rf_cnt = FIELD_GET(RXFVE_MASK, event);
+				if (rf_cnt >= CHUNK_SIZE)
+					rx_bytes = CHUNK_SIZE;
+				else if (num_blks == 1 &&
+					 rf_cnt == num_bytes)
+					rx_bytes = num_bytes;
+				else
+					continue;
+
+				if (atcspi200_rx_byte(priv, din, rx_bytes) ==
+				    rx_bytes) {
+					num_blks -= CHUNK_SIZE;
+					din = (unsigned char *)din + rx_bytes;
 				}
 			}
 
-			data_len -= tran_len;
-			if(data_len)
-			{
-				ns->cmd_buf[1] += ((tran_len>>16)&0xff);
-				ns->cmd_buf[2] += ((tran_len>>8)&0xff);
-				ns->cmd_buf[3] += ((tran_len)&0xff);
-				ns->data_len = data_len;
+			if (!timeout) {
+				debug("spi_xfer: %s() timeout\n", __func__);
+				break;
 			}
-			ret = __atcspi200_spi_stop(ns);
 		}
-		ret = __atcspi200_spi_stop(ns);
 
-		return ret;
+		data_len -= tran_len;
+		if (data_len) {
+			priv->cmd_buf[1] += ((tran_len >> 16) & 0xff);
+			priv->cmd_buf[2] += ((tran_len >> 8) & 0xff);
+			priv->cmd_buf[3] += (tran_len & 0xff);
+			priv->data_len = data_len;
+		}
+		ret = atcspi200_hw_stop(priv);
+	}
+	ret = atcspi200_hw_stop(priv);
+
+	return ret;
 }
 
 static int atcspi200_spi_set_speed(struct udevice *bus, uint max_hz)
 {
-	struct nds_spi_slave *ns = dev_get_priv(bus);
+	struct atcspi200_priv *priv = dev_get_priv(bus);
 
 	debug("%s speed %u\n", __func__, max_hz);
 
-	ns->freq = max_hz;
-	__atcspi200_spi_set_speed(ns);
+	priv->freq = max_hz;
+	atcspi200_hw_set_speed(priv);
 
 	return 0;
 }
 
 static int atcspi200_spi_set_mode(struct udevice *bus, uint mode)
 {
-	struct nds_spi_slave *ns = dev_get_priv(bus);
+	struct atcspi200_priv *priv = dev_get_priv(bus);
 
 	debug("%s mode %u\n", __func__, mode);
-	ns->mode = mode;
+	priv->mode = mode;
 
 	return 0;
 }
 
 static int atcspi200_spi_claim_bus(struct udevice *dev)
 {
-	struct dm_spi_slave_plat *slave_plat =
-		dev_get_parent_plat(dev);
+	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
 	struct udevice *bus = dev->parent;
-	struct nds_spi_slave *ns = dev_get_priv(bus);
+	struct atcspi200_priv *priv = dev_get_priv(bus);
 
-	if (slave_plat->cs[0] >= ns->num_cs) {
-		printf("Invalid SPI chipselect\n");
+	if (slave_plat->cs[0] >= priv->num_cs) {
+		dev_err(dev, "Invalid SPI chipselect\n");
 		return -EINVAL;
 	}
 
-	return __atcspi200_spi_claim_bus(ns);
+	return atcspi200_hw_claim_bus(priv);
 }
 
 static int atcspi200_spi_release_bus(struct udevice *dev)
 {
-	struct nds_spi_slave *ns = dev_get_priv(dev->parent);
-
-	return __atcspi200_spi_release_bus(ns);
+	return 0;
 }
 
 static int atcspi200_spi_xfer(struct udevice *dev, unsigned int bitlen,
-			    const void *dout, void *din,
-			    unsigned long flags)
+			      const void *dout, void *din,
+			      unsigned long flags)
 {
 	struct udevice *bus = dev->parent;
-	struct nds_spi_slave *ns = dev_get_priv(bus);
+	struct atcspi200_priv *priv = dev_get_priv(bus);
 
-	return __atcspi200_spi_xfer(ns, bitlen, dout, din, flags);
+	return atcspi200_hw_xfer(priv, bitlen, dout, din, flags);
 }
 
 static int atcspi200_spi_get_clk(struct udevice *bus)
 {
-	struct nds_spi_slave *ns = dev_get_priv(bus);
+	struct atcspi200_priv *priv = dev_get_priv(bus);
 	struct clk clk;
 	ulong clk_rate;
 	int ret;
@@ -359,37 +360,33 @@ static int atcspi200_spi_get_clk(struct udevice *bus)
 	if (!clk_rate)
 		return -EINVAL;
 
-	ns->clock = clk_rate;
+	priv->clock = clk_rate;
 
 	return 0;
 }
 
 static int atcspi200_spi_probe(struct udevice *bus)
 {
-	struct nds_spi_slave *ns = dev_get_priv(bus);
+	struct atcspi200_priv *priv = dev_get_priv(bus);
 
-	ns->to = SPI_TIMEOUT;
-	ns->max_transfer_length = MAX_TRANSFER_LEN;
-	ns->mtiming = ns->regs->timing;
+	priv->to = SPI_TIMEOUT;
+	priv->max_transfer_length = MAX_TRANSFER_LEN;
+	priv->mtiming = atcspi200_read(priv, ATCSPI200_REG_TIMING);
 	atcspi200_spi_get_clk(bus);
 
 	return 0;
 }
 
-static int atcspi200_ofdata_to_platadata(struct udevice *bus)
+static int atcspi200_spi_of_to_plat(struct udevice *bus)
 {
-	struct nds_spi_slave *ns = dev_get_priv(bus);
-	const void *blob = gd->fdt_blob;
-	int node = dev_of_offset(bus);
-
-	ns->regs = map_physmem(dev_read_addr(bus),
-				 sizeof(struct atcspi200_spi_regs),
-				 MAP_NOCACHE);
-	if (!ns->regs) {
-		printf("%s: could not map device address\n", __func__);
+	struct atcspi200_priv *priv = dev_get_priv(bus);
+
+	priv->regs = dev_remap_addr(bus);
+	if (!priv->regs) {
+		dev_err(bus, "could not map device address\n");
 		return -EINVAL;
 	}
-	ns->num_cs = fdtdec_get_int(blob, node, "num-cs", 4);
+	priv->num_cs = dev_read_u32_default(bus, "num-cs", 4);
 
 	return 0;
 }
@@ -412,7 +409,7 @@ U_BOOT_DRIVER(atcspi200_spi) = {
 	.id = UCLASS_SPI,
 	.of_match = atcspi200_spi_ids,
 	.ops = &atcspi200_spi_ops,
-	.of_to_plat = atcspi200_ofdata_to_platadata,
-	.priv_auto	= sizeof(struct nds_spi_slave),
+	.of_to_plat = atcspi200_spi_of_to_plat,
+	.priv_auto = sizeof(struct atcspi200_priv),
 	.probe = atcspi200_spi_probe,
 };
-- 
2.34.1

