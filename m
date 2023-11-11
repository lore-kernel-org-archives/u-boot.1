Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE3C3C4332F
	for <u-boot@archiver.kernel.org>; Sat, 11 Nov 2023 17:33:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67E6C86F67;
	Sat, 11 Nov 2023 18:33:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="NF+pK2T6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A66C86F1C; Sat, 11 Nov 2023 18:33:07 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE40E86ED6
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 18:33:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-28003daaaa6so2725734a91.0
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 09:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1699723982; x=1700328782; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q363r2CEsBjJTIswiVWdPbubUGcjirgslNecMVbemWs=;
 b=NF+pK2T6UiccX4sPY2rJyb2I2aB7cmzrqD7OrV0PLt5AwtSsHB8dU6BNfkWvXyCxLJ
 RcKRY4HXcNoncQ6diWlj7vgw357oklx/2KTMRkQRCYV5gjMoFqBrUZsUT0MPCL8AattI
 MXKDr4BWHyptIV1NdGLMus5u9XXqqdOX3UbYB2t4pL5EQRlWOW+JBk4R8CqFmXO7Tb0i
 XrJR4VCE7WaG6YFLs+0tEOc0lij5eSI5gtxyhqGccLsxajK9xY/+8MsEsuyQN/FmP8pm
 FIq1w5RI/7IGkhd5ltzuKfbsmx7JVBVNwe/QEYTMw06eSpHf2FeL96SZac/4MBPNVwKL
 iVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699723982; x=1700328782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q363r2CEsBjJTIswiVWdPbubUGcjirgslNecMVbemWs=;
 b=K0eqTtkr3mvO/px9Gem1GTao6cDDDK9bxFujQCvkS8ZMG4Hu23R9T6OUSIskq1sprV
 cQCLyvWZjUkR34gW9z1vSzIgOEnnnfkrMS75EcYtW3Cq6JiELoO9fiyrzrnCE3xJBagi
 mgvUVhBQA4Hy82pTqgJq1BMt0JwYBAHw2FYFdEEmRCXj7l5Qq9oRx/V1q/9jk1wsc190
 o+SMz9tZ+57PWoKeFYFQFpubtfxb6pYMfx7AWjoUmM1aIkd/NCOm3L7+CUGQWWDE7t54
 kTlBNMfH6Ufhe0o/mY5AeciXdEkBLxajD3xt5vPerR3bnaiiqZju+6vDO6YtsNj6sm18
 hhnQ==
X-Gm-Message-State: AOJu0YwM4MQCWFU1+DG6aAaTK+p+RvmEfOiUnIJwGEIuoBoIy2CMn9Df
 auiqsTMCWU7b7eVOSATC+/qqx84X4GRke3c8EGxdog==
X-Google-Smtp-Source: AGHT+IH+/4gHT/ImejMVhjImo2UK2qH3o7JItVeZM0C7nSltnyK8Y1pDnXiK66ojSrvX1jvY5KVhRA==
X-Received: by 2002:a17:90b:1d06:b0:280:2823:6615 with SMTP id
 on6-20020a17090b1d0600b0028028236615mr2282645pjb.36.1699723981989; 
 Sat, 11 Nov 2023 09:33:01 -0800 (PST)
Received: from ThinkPad-T490.dc1.ventanamicro.com ([223.233.86.194])
 by smtp.googlemail.com with ESMTPSA id
 c64-20020a17090a494600b0027cf8869ee7sm3772218pjh.0.2023.11.11.09.32.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 09:33:00 -0800 (PST)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 1/3] drivers: xilinx_spi: Use udevice in start_tranfer
Date: Sat, 11 Nov 2023 23:01:19 +0530
Message-Id: <20231111173121.92889-2-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231111173121.92889-1-mchitale@ventanamicro.com>
References: <20231111173121.92889-1-mchitale@ventanamicro.com>
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

Modify start_transfer and related functions to take a udevice parameter
as input instead of spi_slave. This is needed so that start_transfer can
be used directly via the xfer callback. Also fix a compiler warning.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
---
 drivers/spi/xilinx_spi.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/xilinx_spi.c b/drivers/spi/xilinx_spi.c
index b58a3f632a..d9faceec18 100644
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
@@ -217,9 +217,9 @@ static u32 xilinx_spi_read_rxfifo(struct udevice *bus, u8 *rxp, u32 rxbytes)
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
@@ -259,10 +259,9 @@ static int start_transfer(struct spi_slave *spi, const void *dout, void *din, u3
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
 
@@ -270,13 +269,13 @@ static void xilinx_spi_startup_block(struct spi_slave *spi)
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
 }
 
 static int xilinx_spi_mem_exec_op(struct spi_slave *spi,
@@ -294,14 +293,15 @@ static int xilinx_spi_mem_exec_op(struct spi_slave *spi,
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
@@ -313,7 +313,7 @@ static int xilinx_spi_mem_exec_op(struct spi_slave *spi,
 			addr_buf[i] = op->addr.val >>
 			(8 * (op->addr.nbytes - i - 1));
 
-		ret = start_transfer(spi, (void *)addr_buf, NULL,
+		ret = start_transfer(spi->dev, (void *)addr_buf, NULL,
 				     op->addr.nbytes);
 		if (ret)
 			goto done;
@@ -322,16 +322,16 @@ static int xilinx_spi_mem_exec_op(struct spi_slave *spi,
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
-- 
2.34.1

