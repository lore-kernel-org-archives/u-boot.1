Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D1ECDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 07:05:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7566886B05;
	Tue, 17 Oct 2023 09:05:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Spxy2LLi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B947E86B84; Tue, 17 Oct 2023 09:05:23 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC81A86AE9
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 09:05:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2b9338e4695so69352161fa.2
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 00:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697526321; x=1698131121; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xh2hAzi4wKsj2JrkjcQqeChvgFcW/gOJRdU/iS+quKo=;
 b=Spxy2LLiE3Q9bWUNpFit56ATpocomdEBNDpzgmR0B05p0bqWGebDby7UGh1E1W5FT3
 3jnclBXHPkhTCrd/nf1CeBe8ir/P98T3PM/UfQ/JOu87aqrxUsPDa6WVAdJO0gqoYQwk
 8F1xbsd0ITTYXeRzwtDZW00dmevkd5t582ZiV2LHDyCyqOZr+4bRuY5myAKZ19O512Du
 sA5RTApmPL4R7PHuXMtGdB+26bxzMpt9Epmp3ShUglGGPOllKdqxprx+Sotsi76V+kxa
 ZmtyrYFPhT8Yn0dLx3ZfPS8RPQzATC8Dn2PpWof9kSnGMHl7fqaQdhOG7/d4o7fmefNk
 H+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697526321; x=1698131121;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xh2hAzi4wKsj2JrkjcQqeChvgFcW/gOJRdU/iS+quKo=;
 b=RWMyZ1cP1WORy1S3ZYLrrkRhDw2749oy3dzoAjKY8SLsaOqj3guoL9lz8iidVrQjeE
 SKqZ8rlCmvdfDXW80uTnvRfciZ4cM1uQ9D+2ulHgX6zRDF/kxhbDjfq9tUfxhaSbQCC/
 9SObIpFWxdyToVN8p7NJtgaXAGjZ4VdoaqeYWIu223U8bg/2WPwqh2G0WVXrsJJt+AdE
 zNcsB72dmDlsvX/65FQ+vPahu4QGzlf4kjZolFiXpX4ERJW7tzhbMbc3xIZFBJIZvEMz
 eTVL6ldhUeRbVvWa0FT8LuN9QmLh39fhGnlZK5r7Y62k16uWDLlL4ABHQhgAONdR043f
 TS4w==
X-Gm-Message-State: AOJu0YygZsbEf9ng77cnQTXFrFDnNQhTejw04dl+A2o2ZfofEWfPcbcL
 tx60QUDf6pqSCvj4wVMowMH1L0wqe+aUaA==
X-Google-Smtp-Source: AGHT+IGgGHY8cingMiVz69f1V8CKdSjblY1z4LKJsQDQTkpPPzb88ul5Lkl8/FiEQwDdzzoNtiEkYg==
X-Received: by 2002:a05:651c:1a09:b0:2c5:f54:2477 with SMTP id
 by9-20020a05651c1a0900b002c50f542477mr1124230ljb.40.1697526320416; 
 Tue, 17 Oct 2023 00:05:20 -0700 (PDT)
Received: from user-PC.. ([92.51.95.194]) by smtp.gmail.com with ESMTPSA id
 n4-20020a2e7204000000b002bcbb464a28sm134830ljc.59.2023.10.17.00.05.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 00:05:20 -0700 (PDT)
From: Maksim Kiselev <bigunclemax@gmail.com>
To: u-boot@lists.denx.de
Cc: Maksim Kiselev <bigunclemax@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v1] spi: dw: add check for Rx FIFO overflow
Date: Tue, 17 Oct 2023 10:05:06 +0300
Message-Id: <20231017070507.1254286-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.40.1
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

If even one byte is lost due to Rx FIFO overflow then we will never
exit the read loop. Because the (priv->rx != priv->rx_end) condition will
be always true.

Let's check if Rx FIFO overflow occurred and exit the read loop
in this case.

Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 drivers/spi/designware_spi.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/designware_spi.c b/drivers/spi/designware_spi.c
index 1c7d0ca310..0f443bff8e 100644
--- a/drivers/spi/designware_spi.c
+++ b/drivers/spi/designware_spi.c
@@ -111,6 +111,15 @@
 #define SR_TX_ERR			BIT(5)
 #define SR_DCOL				BIT(6)
 
+/* Bit fields in ISR, IMR, RISR, 7 bits */
+#define DW_SPI_INT_MASK			GENMASK(5, 0)
+#define DW_SPI_INT_TXEI			BIT(0)
+#define DW_SPI_INT_TXOI			BIT(1)
+#define DW_SPI_INT_RXUI			BIT(2)
+#define DW_SPI_INT_RXOI			BIT(3)
+#define DW_SPI_INT_RXFI			BIT(4)
+#define DW_SPI_INT_MSTI			BIT(5)
+
 #define RX_TIMEOUT			1000		/* timeout in ms */
 
 struct dw_spi_plat {
@@ -588,7 +597,7 @@ static int dw_spi_exec_op(struct spi_slave *slave, const struct spi_mem_op *op)
 	struct dw_spi_priv *priv = dev_get_priv(bus);
 	u8 op_len = op->cmd.nbytes + op->addr.nbytes + op->dummy.nbytes;
 	u8 op_buf[op_len];
-	u32 cr0;
+	u32 cr0, sts;
 
 	if (read)
 		priv->tmode = CTRLR0_TMOD_EPROMREAD;
@@ -632,12 +641,21 @@ static int dw_spi_exec_op(struct spi_slave *slave, const struct spi_mem_op *op)
 	 * them to fail because we are not reading/writing the fifo fast enough.
 	 */
 	if (read) {
-		priv->rx = op->data.buf.in;
+		void *prev_rx = priv->rx = op->data.buf.in;
 		priv->rx_end = priv->rx + op->data.nbytes;
 
 		dw_write(priv, DW_SPI_SER, 1 << spi_chip_select(slave->dev));
-		while (priv->rx != priv->rx_end)
+		while (priv->rx != priv->rx_end) {
 			dw_reader(priv);
+			if (prev_rx == priv->rx) {
+				sts = dw_read(priv, DW_SPI_RISR);
+				if (sts & DW_SPI_INT_RXOI) {
+					dev_err(bus, "FIFO overflow on Rx\n");
+					return -EIO;
+				}
+			}
+			prev_rx = priv->rx;
+		}
 	} else {
 		u32 val;
 
-- 
2.40.1

