Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BBE4C4167B
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 08:23:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9409C87483;
	Thu,  2 Nov 2023 09:23:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="VzVt4Kfa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05A7B87650; Thu,  2 Nov 2023 09:23:57 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2096E87652
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 09:23:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1cc37fb1310so5354035ad.1
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 01:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698913418; x=1699518218; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3rfg+IeShVOa95+3Ugy0SC04GfTe91gSBY6wd76XRuQ=;
 b=VzVt4KfaBedz57e+Z0Yj/2f4DKSC1xlktF1RK3H9cw2OXibN7TAin1DQ9e7jYEv2tn
 qryG7fxQvOJrl8tuRxFBwnEuBVOrRvgnkOutHCv5J5sf9/6AQFIJydY7pBpCfCb/1VcB
 pZkrrTTDkiEEhoDYNbNajmRKdAr6sVzq/sR2JWqj56F7Q0qtMD8J1oPxhRzNLME7TJ0b
 yy+wV6xkk0ojy3tOwhi+DZxzBRxje6ODL2S3Uy/1qdygaH/bYnyxqlYiFL6vOgT48yuj
 7P2Ni7ZI3bdZjuJPR/ThfH3qbstN6Jfn2iFvLI0NFBfhpAba+GkQJKrmQqxDpcqPoOjI
 hgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698913418; x=1699518218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3rfg+IeShVOa95+3Ugy0SC04GfTe91gSBY6wd76XRuQ=;
 b=RV9CPApYplsenPw5p9upEUTmdnE+29luhYjWcMk3J07XKNg7Kq9x4MhN6/sy1lJvzB
 y40W8XQV4T18HZ+crsW0nhAJjUswrtJ7tbm5c23FFz85Wm1k8LVD27mSPAPFaGxWhoix
 Qf58ECm2Mbw7o1SNqLLQrEyWd+6R9AVoS6DjT5h7SRvSKI6V8eLHatBDEmoVi2VhkFF+
 f60yx+KRpIJ98CHKtW7nHOHDrl2IrBObt3eaJaThOh3LbZXhltu07nkIFXymvq+fQGaw
 yodq0BQoYsU7OluR8e/KiWSH4v73VTyqbwhhBSGLbCEJdG0AVPrQgSSFoCa69E4G6z9r
 5g2Q==
X-Gm-Message-State: AOJu0YxHV3TiDO4e8JTc80OEN47AK93clsdeKTJ4qm0t0FTfko9vd0KQ
 DfYpHu3704/e/qVX+bFdUZRWCw==
X-Google-Smtp-Source: AGHT+IHTzQ9K4L62TLC8TUFuqxZ6FqtbGU8C2a7zirbNXbjEAqACkNgmpBi+iTAE5AAc676ua+lqFg==
X-Received: by 2002:a17:903:22ca:b0:1c7:8446:d65c with SMTP id
 y10-20020a17090322ca00b001c78446d65cmr17784332plg.43.1698913418279; 
 Thu, 02 Nov 2023 01:23:38 -0700 (PDT)
Received: from ThinkPad-T490.dc1.ventanamicro.com
 ([2401:4900:5315:cd32:1e1a:95f3:9ce0:bc69])
 by smtp.googlemail.com with ESMTPSA id
 l9-20020a170902d34900b001cc47c1c29csm2546789plk.84.2023.11.02.01.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 01:23:37 -0700 (PDT)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] drivers: xilinx_spi: Fixes for MMC_SPI
Date: Thu,  2 Nov 2023 13:53:01 +0530
Message-Id: <20231102082303.354944-2-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231102082303.354944-1-mchitale@ventanamicro.com>
References: <20231102082303.354944-1-mchitale@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add the xfer callback which is used by the MMC_SPI driver and generally by
the dm_spi_xfer callback. Also probe the fifo_depth during init as is
done in the linux spi-xilinx driver and fix a compiler warning while at it.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
---
 drivers/spi/xilinx_spi.c | 70 ++++++++++++++++++++++++++++++----------
 1 file changed, 53 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/xilinx_spi.c b/drivers/spi/xilinx_spi.c
index b58a3f632a..0d4ff25600 100644
--- a/drivers/spi/xilinx_spi.c
+++ b/drivers/spi/xilinx_spi.c
@@ -67,7 +67,7 @@
 /* SPI Slave Select Register (spissr), [1] p13, [2] p13 */
 #define SPISSR_MASK(cs)		(1 << (cs))
 #define SPISSR_ACT(cs)		~SPISSR_MASK(cs)
-#define SPISSR_OFF		~0UL
+#define SPISSR_OFF		(~0U)
 
 /* SPI Software Reset Register (ssr) */
 #define SPISSR_RESET_VALUE	0x0a
@@ -109,6 +109,27 @@ struct xilinx_spi_priv {
 	u8 startup;
 };
 
+/* Detect fifo depth. Ported from linux sha: 4c9a761402d78 */
+static int xilinx_spi_find_buffer_size(struct xilinx_spi_regs *regs)
+{
+	u8 sr;
+	int n_words = 0;
+
+	/*
+	 * Before the buffer_size detection we reset the core
+	 * to make sure we start with a clean state.
+	 */
+	writel(SPISSR_RESET_VALUE, &regs->srr);
+
+	/* Fill the Tx FIFO with as many words as possible */
+	do {
+		writel(0, &regs->spidtr);
+		sr = readl(&regs->spisr);
+		n_words++;
+	} while (!(sr & SPISR_TX_FULL));
+
+	return n_words;
+}
 static int xilinx_spi_probe(struct udevice *bus)
 {
 	struct xilinx_spi_priv *priv = dev_get_priv(bus);
@@ -116,6 +137,8 @@ static int xilinx_spi_probe(struct udevice *bus)
 
 	regs = priv->regs = dev_read_addr_ptr(bus);
 	priv->fifo_depth = dev_read_u32_default(bus, "fifo-size", 0);
+	if (!priv->fifo_depth)
+		priv->fifo_depth = xilinx_spi_find_buffer_size(regs);
 
 	writel(SPISSR_RESET_VALUE, &regs->srr);
 
@@ -197,7 +220,7 @@ static u32 xilinx_spi_fill_txfifo(struct udevice *bus, const u8 *txp,
 	return i;
 }
 
-static u32 xilinx_spi_read_rxfifo(struct udevice *bus, u8 *rxp, u32 rxbytes)
+static u32 xilinx_spi_read_rxfifo(struct udevice *bus, u8 *rxp, int rxbytes)
 {
 	struct xilinx_spi_priv *priv = dev_get_priv(bus);
 	struct xilinx_spi_regs *regs = priv->regs;
@@ -217,9 +240,9 @@ static u32 xilinx_spi_read_rxfifo(struct udevice *bus, u8 *rxp, u32 rxbytes)
 	return i;
 }
 
-static int start_transfer(struct spi_slave *spi, const void *dout, void *din, u32 len)
+static int start_transfer(struct udevice *dev, const void *dout, void *din, u32 len)
 {
-	struct udevice *bus = spi->dev->parent;
+	struct udevice *bus = dev->parent;
 	struct xilinx_spi_priv *priv = dev_get_priv(bus);
 	struct xilinx_spi_regs *regs = priv->regs;
 	u32 count, txbytes, rxbytes;
@@ -259,10 +282,9 @@ static int start_transfer(struct spi_slave *spi, const void *dout, void *din, u3
 	return 0;
 }
 
-static void xilinx_spi_startup_block(struct spi_slave *spi)
+static void xilinx_spi_startup_block(struct udevice *dev)
 {
-	struct dm_spi_slave_plat *slave_plat =
-				dev_get_parent_plat(spi->dev);
+	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
 	unsigned char txp;
 	unsigned char rxp[8];
 
@@ -270,13 +292,25 @@ static void xilinx_spi_startup_block(struct spi_slave *spi)
 	 * Perform a dummy read as a work around for
 	 * the startup block issue.
 	 */
-	spi_cs_activate(spi->dev, slave_plat->cs);
+	spi_cs_activate(dev, slave_plat->cs);
 	txp = 0x9f;
-	start_transfer(spi, (void *)&txp, NULL, 1);
+	start_transfer(dev, (void *)&txp, NULL, 1);
 
-	start_transfer(spi, NULL, (void *)rxp, 6);
+	start_transfer(dev, NULL, (void *)rxp, 6);
 
-	spi_cs_deactivate(spi->dev);
+	spi_cs_deactivate(dev);
+}
+
+static int xilinx_spi_xfer(struct udevice *dev, unsigned int bitlen,
+			   const void *dout, void *din, unsigned long flags)
+{
+	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
+	int ret;
+
+	spi_cs_activate(dev, slave_plat->cs);
+	ret = start_transfer(dev, dout, din, (bitlen / 8));
+	spi_cs_deactivate(dev);
+	return ret;
 }
 
 static int xilinx_spi_mem_exec_op(struct spi_slave *spi,
@@ -294,14 +328,15 @@ static int xilinx_spi_mem_exec_op(struct spi_slave *spi,
 	 * as QSPI provides command. So first command fails.
 	 */
 	if (!startup) {
-		xilinx_spi_startup_block(spi);
+		xilinx_spi_startup_block(spi->dev);
 		startup++;
 	}
 
 	spi_cs_activate(spi->dev, slave_plat->cs);
 
 	if (op->cmd.opcode) {
-		ret = start_transfer(spi, (void *)&op->cmd.opcode, NULL, 1);
+		ret = start_transfer(spi->dev, (void *)&op->cmd.opcode,
+				     NULL, 1);
 		if (ret)
 			goto done;
 	}
@@ -313,7 +348,7 @@ static int xilinx_spi_mem_exec_op(struct spi_slave *spi,
 			addr_buf[i] = op->addr.val >>
 			(8 * (op->addr.nbytes - i - 1));
 
-		ret = start_transfer(spi, (void *)addr_buf, NULL,
+		ret = start_transfer(spi->dev, (void *)addr_buf, NULL,
 				     op->addr.nbytes);
 		if (ret)
 			goto done;
@@ -322,16 +357,16 @@ static int xilinx_spi_mem_exec_op(struct spi_slave *spi,
 		dummy_len = (op->dummy.nbytes * op->data.buswidth) /
 			     op->dummy.buswidth;
 
-		ret = start_transfer(spi, NULL, NULL, dummy_len);
+		ret = start_transfer(spi->dev, NULL, NULL, dummy_len);
 		if (ret)
 			goto done;
 	}
 	if (op->data.nbytes) {
 		if (op->data.dir == SPI_MEM_DATA_IN) {
-			ret = start_transfer(spi, NULL,
+			ret = start_transfer(spi->dev, NULL,
 					     op->data.buf.in, op->data.nbytes);
 		} else {
-			ret = start_transfer(spi, op->data.buf.out,
+			ret = start_transfer(spi->dev, op->data.buf.out,
 					     NULL, op->data.nbytes);
 		}
 		if (ret)
@@ -427,6 +462,7 @@ static const struct spi_controller_mem_ops xilinx_spi_mem_ops = {
 static const struct dm_spi_ops xilinx_spi_ops = {
 	.claim_bus	= xilinx_spi_claim_bus,
 	.release_bus	= xilinx_spi_release_bus,
+	.xfer           = xilinx_spi_xfer,
 	.set_speed	= xilinx_spi_set_speed,
 	.set_mode	= xilinx_spi_set_mode,
 	.mem_ops	= &xilinx_spi_mem_ops,
-- 
2.34.1

