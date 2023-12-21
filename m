Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED16C46CCD
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 10:13:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE01B87751;
	Thu, 21 Dec 2023 11:13:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mZY9szxG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FB08877A1; Thu, 21 Dec 2023 11:13:45 +0100 (CET)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99F7F876F3
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 11:13:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2cc6121c113so6060191fa.0
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 02:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703153623; x=1703758423; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gOmW2/BDuSBOp/0YnoX/ZsUs5OQkLOL1XGcB43CQkZI=;
 b=mZY9szxGd4JFtt75DVF06iD/TsIuKQ0KIRcS2BS3q/uW2XhpZ4SdTf+TCRGEMbrDdL
 gfR3mdKRdXIXES/WbpQGbmYylvCXv2oxhN+OZVqDJWSj6cOMzKXuflOA+dKccPo0ZCng
 GtteCaYXvwN+ZeKQRLI0pjTDvySAvlvG5qiw4DdyM30xmPKH+pyarcqX6zL7RiwLIK+S
 LSn2tHiltQbhH8EhjMQ1wjltkXlzuBak4ShBmUCgqr/3v6Qx/v5rFprxADyDlxJxlztz
 KknHvnW/r/2q2naDKcUuQT+q9mbqBqrviOXvoLigsa+Us9KXG2sDflhZMNjRJgXA5eZm
 q7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703153623; x=1703758423;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gOmW2/BDuSBOp/0YnoX/ZsUs5OQkLOL1XGcB43CQkZI=;
 b=OIE/8t+I+juafsA6lsl82IWXblHHSe8gYuD8b67ODo93Yus3GYtgM/Hr5ILRvdFM92
 8HRX4yiMBSxkBzTEovWPFb17hk3yqSFcigB6BTWR6XGM0XxEFF6vQepWbT03CsY/5s/r
 0aT0mjocllhNhJuZnHzacm0U8zxnGWXZVIyq+150AXHEJJtX6UyvBe9t9VeVPitkZeLv
 NhwxzG1TMl1yRnEAHZh82KhuTgxi+P5lQtMee8mohj8jWWpFoCV3IbjrO8DclwbJZwlf
 JkH3LMaZ0XYvFXpWZdTGPmx/plcp7HZxTIbeWk1muaBPjNPsIdcKsrv4TdBNDkksQzht
 h6ZQ==
X-Gm-Message-State: AOJu0YzthWb24rgzwpzWK5ePxmj0V9G7AdDW/bGOZ3nP1GdSIvdHYHJj
 a04fKy1XyLqSLbczP35YSnk=
X-Google-Smtp-Source: AGHT+IGgNKi/qXEZyisrp0Mxa85vyAgYGtwPV0cYh2ak3bp+nldoOkmd+J990Ur1w3u70bUfjSmStg==
X-Received: by 2002:a2e:95d6:0:b0:2cc:67fd:6091 with SMTP id
 y22-20020a2e95d6000000b002cc67fd6091mr1842829ljh.112.1703153622526; 
 Thu, 21 Dec 2023 02:13:42 -0800 (PST)
Received: from user-PC.. ([92.51.95.194]) by smtp.gmail.com with ESMTPSA id
 a11-20020a2e860b000000b002cc6a59d55fsm211050lji.85.2023.12.21.02.13.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 02:13:42 -0800 (PST)
From: Maksim Kiselev <bigunclemax@gmail.com>
To: 
Cc: Maksim Kiselev <bigunclemax@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de
Subject: [PATCH v2] spi: dw: add check for Rx FIFO overflow
Date: Thu, 21 Dec 2023 13:13:30 +0300
Message-Id: <20231221101331.3263153-1-bigunclemax@gmail.com>
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
 drivers/spi/designware_spi.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/designware_spi.c b/drivers/spi/designware_spi.c
index 1c7d0ca310..98908c5217 100644
--- a/drivers/spi/designware_spi.c
+++ b/drivers/spi/designware_spi.c
@@ -111,6 +111,9 @@
 #define SR_TX_ERR			BIT(5)
 #define SR_DCOL				BIT(6)
 
+/* Bit field in RISR */
+#define RISR_INT_RXOI			BIT(3)
+
 #define RX_TIMEOUT			1000		/* timeout in ms */
 
 struct dw_spi_plat {
@@ -588,7 +591,7 @@ static int dw_spi_exec_op(struct spi_slave *slave, const struct spi_mem_op *op)
 	struct dw_spi_priv *priv = dev_get_priv(bus);
 	u8 op_len = op->cmd.nbytes + op->addr.nbytes + op->dummy.nbytes;
 	u8 op_buf[op_len];
-	u32 cr0;
+	u32 cr0, sts;
 
 	if (read)
 		priv->tmode = CTRLR0_TMOD_EPROMREAD;
@@ -632,12 +635,21 @@ static int dw_spi_exec_op(struct spi_slave *slave, const struct spi_mem_op *op)
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
+				if (sts & RISR_INT_RXOI) {
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

