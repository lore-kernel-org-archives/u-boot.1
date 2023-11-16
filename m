Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B6AC47071
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 16:44:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19166874D8;
	Thu, 16 Nov 2023 17:44:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="LmiH2jGM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89577874DC; Thu, 16 Nov 2023 17:44:09 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B841874C7
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 17:44:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1ce28faa92dso9124175ad.2
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 08:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1700153043; x=1700757843; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q363r2CEsBjJTIswiVWdPbubUGcjirgslNecMVbemWs=;
 b=LmiH2jGMZYMrGQDlbv4etRxo/nbi+gicO2A/X7KAGwjp5oiUPJGuHARJbrufj6QfCU
 s0XCVm+iYpTa3VpV6N4ptrqS02e6jQfAQRmb95QW/rTggnFlYxjhs+S6JTFjTF0ZCnJu
 4lAFFh5mEWaZFu4r0tVnfV3ueNCTP685ENKIhLMBLhCLNsNpWKUCDXFf+k2DW4wnt8Oc
 VgykIHlY5iBE19iouRlhmuuTv1Bkz1vmv+f64zIQA4ltN9trb4TmfBv08AyaL/xovm15
 GlRS0YI3M+ajaeZlPqntTa0KObTeWbZVsHYQLRySZEAtp4oclDSja4jVMRpkHnwDPq9n
 jOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700153043; x=1700757843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q363r2CEsBjJTIswiVWdPbubUGcjirgslNecMVbemWs=;
 b=MpyziFQmwbKlQrjcYx/2OSCu9NIt+z4w9GBdBIfQNrAQlCenmG29CiwJuKwwkGAN9o
 zXqq5KBSA5ziT1rDREMGvr216axKc0yVY+2ywIF+XWhylJCaQuWvmeTIWgB2o3jNUvfG
 2v/tVXWIegTg7UN8XQxBO9njOgOgc57yFaCUrV9F40BSQVaLgATDmtDqbXJfKoym7K8h
 sJx/Ctf2/01HHvgm/oLJM05jeKTzWQBBcZRCcagbSVafLdIpYR1ipraIC5AzlDvNCHo9
 hMHhNXIiD0XNvVmfxIS7KJjbuHXDKqzvU2km7k0l4CbigeD12BAmuFki0muhvqEvy6o6
 +MFQ==
X-Gm-Message-State: AOJu0Yyx2YsBupYZliwuvVCUwgvTXcx/gj63wNooKGn6YkF9Kp31KEVn
 RSmeD+99W5SZscNwzvhFui2SsQ==
X-Google-Smtp-Source: AGHT+IEBlEt0vLOsh9/U92dVIwIGpRXCsRUg6LhgaXWKijOPlg5jdwYZnTj6dQRZvV1cI4sGgpa1Bw==
X-Received: by 2002:a17:902:e5cd:b0:1cc:51b8:8100 with SMTP id
 u13-20020a170902e5cd00b001cc51b88100mr10378913plf.7.1700153042837; 
 Thu, 16 Nov 2023 08:44:02 -0800 (PST)
Received: from ThinkPad-T490.dc1.ventanamicro.com
 ([2401:4900:57e3:f37f:e352:7f6c:bf18:83f0])
 by smtp.googlemail.com with ESMTPSA id
 l2-20020a170902f68200b001c5eb37e92csm9439839plg.305.2023.11.16.08.44.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 08:44:02 -0800 (PST)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/3] drivers: xilinx_spi: Use udevice in start_tranfer
Date: Thu, 16 Nov 2023 22:13:34 +0530
Message-Id: <20231116164336.140171-2-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231116164336.140171-1-mchitale@ventanamicro.com>
References: <20231116164336.140171-1-mchitale@ventanamicro.com>
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

