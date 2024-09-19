Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8932DCF3962
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 17:00:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A77089247;
	Thu, 19 Sep 2024 19:00:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aZZ+6S0B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EAB089247; Thu, 19 Sep 2024 19:00:50 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50D83871C7
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 19:00:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5356aa9a0afso1901587e87.2
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 10:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726765247; x=1727370047; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dBUB+e1NGedzZukQh5fxm+7IflBBtPOBVTiKdAwHo2s=;
 b=aZZ+6S0B5tqbGEb9u+tmr4G6zRXdNGSMVNAyJRuayu+62iPSkVXermdozbsWysy+7p
 sAWTooQ76BAFXD742JJllc8vPnqam/3rOFbkcNQj3HxhbnrOpckeibiTl6dXRA3fnVyn
 eK8V+42Rwt11Jc2qQwxC/UjnBWaakdL47KRCeSnX/ADKAfW2ykytT+71bzRlmTnw0iY2
 dRs7Rmff62coiBDo1qsjbw5uinwWA6tUu9ywqDxcSKycVKAPhxilxJzlVU1ZkUqQq7gJ
 SwlJBqJPndSMgJqdXNSJkPi80GzeV9GKMYRmKUDpNPzwP3kxOEVdHnJh5q0HuzHneXcT
 h74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726765247; x=1727370047;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dBUB+e1NGedzZukQh5fxm+7IflBBtPOBVTiKdAwHo2s=;
 b=LtyB6vB1an+lzB6g5Gg8nmYPPEHbONkz+/ET7PDgNt3c5gAGT7uJqwWMm37AaCMRMQ
 qvmzdNUCqGN5JKbQiPUV7k9rz6FENjcgBe/cPXOLlP8s0JhNDAhrDWJNJaoziD6UiY4D
 GxqdQHjt7IW5/mSuxevhSprXR+m3gRWYHsCh2i8yVuRYpL+QUqM5VckLbz9sPZl6hakM
 hmqIaJn4bQJAkNtRsaXuj6y4nZO5QfggQC6gEV8fBWjq/1xH2U2ODq1RXfCxJasoBxil
 cnA2QSME4NpsVzoo4/2XJzHeBf1Zo1qfNV5TgH8YjFH0aGNyodpjS5rvZypHM+ZtO5e8
 ytsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL9mwcwlJ+MIeu9NKVudAFxQeRK4XzXaACzE1VoCtOYGMAPIGjhAGD90QA+Ss/VtgjMSvu1dY=@lists.denx.de
X-Gm-Message-State: AOJu0YxpH5DGcQAt2YWproT6lNcETc6n5+T7FFkfQ6U4msw5/sAcZeSi
 G1vEpKKrTb9IGDQ2DDUgxUFrJvmqwgwckSVMJKxIle9gH44w10vc
X-Google-Smtp-Source: AGHT+IHwP5H12yKKLT0e8JQx1gN61OhNXHjvGxtYZ0DdSTvNqfO4lpgbxUfzlzhTaakPIl3thN3ZOA==
X-Received: by 2002:ac2:4c4a:0:b0:52c:76ac:329b with SMTP id
 2adb3069b0e04-5367fef1b91mr16801521e87.35.1726765247204; 
 Thu, 19 Sep 2024 10:00:47 -0700 (PDT)
Received: from wpc.. (host-95-152-62-174.dsl.sura.ru. [95.152.62.174])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-536870967b0sm1874450e87.169.2024.09.19.10.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 10:00:46 -0700 (PDT)
From: bigunclemax@gmail.com
To: 
Cc: bigunclemax@gmail.com, Alexander Razinkov <amrazinkov@ya.ru>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Tom Rini <trini@konsulko.com>, Maxim Kochetkov <fido_max@inbox.ru>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Subject: [PATCH v1] net: xilinx: axi_emac: DMA transfer termination fix
Date: Thu, 19 Sep 2024 20:00:12 +0300
Message-ID: <20240919170022.203450-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.45.2
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

From: Maksim Kiselev <bigunclemax@gmail.com>

According to Xilinx AXI DMA Spec:
"There can be a lag of time between when DMACR.RS = 0 and when
DMASR.Halted = 1"

So to ensure that DMA transfer is really terminated we need to wait
for DMASR.Halted status, which was missed in the Xilinx AXI EMAC driver.

This issue resulted in Linux kernel vmalloc area corruption by AXI Rx DMA
Buffer Descriptor caused by the occasional Ethernet packet arrival in case
the Linux image was loaded via tftp and then immediately launched.

Signed-off-by: Alexander Razinkov <amrazinkov@ya.ru>
Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 drivers/net/xilinx_axi_emac.c | 62 +++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 24 deletions(-)

diff --git a/drivers/net/xilinx_axi_emac.c b/drivers/net/xilinx_axi_emac.c
index 4d87e2d1f3..62af64b1eb 100644
--- a/drivers/net/xilinx_axi_emac.c
+++ b/drivers/net/xilinx_axi_emac.c
@@ -453,11 +453,33 @@ static int setup_phy(struct udevice *dev)
 	return 1;
 }
 
+/* Reset DMA engine */
+static void axi_dma_reset(struct axidma_priv *priv)
+{
+	u32 timeout = 500;
+
+	/* Reset the engine so the hardware starts from a known state */
+	writel(XAXIDMA_CR_RESET_MASK, &priv->dmatx->control);
+	writel(XAXIDMA_CR_RESET_MASK, &priv->dmarx->control);
+
+	/* At the initialization time, hardware should finish reset quickly */
+	while (timeout--) {
+		/* Check transmit/receive channel */
+		/* Reset is done when the reset bit is low */
+		if (!((readl(&priv->dmatx->control) |
+		    readl(&priv->dmarx->control)) & XAXIDMA_CR_RESET_MASK))
+			break;
+	}
+	if (!timeout)
+		printf("%s: DMA reset timeout!\n", __func__);
+}
+
 /* STOP DMA transfers */
 static void axiemac_stop(struct udevice *dev)
 {
 	struct axidma_priv *priv = dev_get_priv(dev);
 	u32 temp;
+	int count;
 
 	/* Stop the hardware */
 	temp = readl(&priv->dmatx->control);
@@ -468,6 +490,21 @@ static void axiemac_stop(struct udevice *dev)
 	temp &= ~XAXIDMA_CR_RUNSTOP_MASK;
 	writel(temp, &priv->dmarx->control);
 
+	/* Give DMAs a chance to halt gracefully */
+	temp = readl(&priv->dmarx->status);
+	for (count = 0; !(temp & XAXIDMA_HALTED_MASK) && count < 5; ++count) {
+		mdelay(20);
+		temp = readl(&priv->dmarx->status);
+	}
+
+	temp = readl(&priv->dmatx->status);
+	for (count = 0; !(temp & XAXIDMA_HALTED_MASK) && count < 5; ++count) {
+		mdelay(20);
+		temp = readl(&priv->dmatx->status);
+	}
+
+	axi_dma_reset(priv);
+
 	debug("axiemac: Halted\n");
 }
 
@@ -552,29 +589,6 @@ static int axiemac_write_hwaddr(struct udevice *dev)
 	return 0;
 }
 
-/* Reset DMA engine */
-static void axi_dma_init(struct axidma_priv *priv)
-{
-	u32 timeout = 500;
-
-	/* Reset the engine so the hardware starts from a known state */
-	writel(XAXIDMA_CR_RESET_MASK, &priv->dmatx->control);
-	writel(XAXIDMA_CR_RESET_MASK, &priv->dmarx->control);
-
-	/* At the initialization time, hardware should finish reset quickly */
-	while (timeout--) {
-		/* Check transmit/receive channel */
-		/* Reset is done when the reset bit is low */
-		if (!((readl(&priv->dmatx->control) |
-				readl(&priv->dmarx->control))
-						& XAXIDMA_CR_RESET_MASK)) {
-			break;
-		}
-	}
-	if (!timeout)
-		printf("%s: Timeout\n", __func__);
-}
-
 static int axiemac_start(struct udevice *dev)
 {
 	struct axidma_priv *priv = dev_get_priv(dev);
@@ -587,7 +601,7 @@ static int axiemac_start(struct udevice *dev)
 	 * reset, and since AXIDMA reset line is connected to AxiEthernet, this
 	 * would ensure a reset of AxiEthernet.
 	 */
-	axi_dma_init(priv);
+	axi_dma_reset(priv);
 
 	/* Initialize AxiEthernet hardware. */
 	if (priv->mactype == EMAC_1G) {
-- 
2.45.2

