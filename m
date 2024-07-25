Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ADD7C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 20:46:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82C8488578;
	Thu, 25 Jul 2024 22:45:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Azokvtah";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB3788842C; Thu, 25 Jul 2024 22:45:29 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A576A883BB
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 22:45:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-703775e4d5dso178452a34.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 13:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721940326; x=1722545126; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YZy7bY3iVSg1wM0zqnDmY47LgMxJoEvXU8nrH0f8DpQ=;
 b=Azokvtahcps5O9YP9xEQ2WISQHKp14L7KExEzjREj6lO4pac/YZVZyFqB8V57KDGy1
 MzPeE1/JC6lRhq+T6EYhTzfSxOiZb6fhm2831118MPAfgd/KPcBb3i88fiFHe6JrFhdM
 6T2puyQVQ++dKunAjjDUzmb03YbmLUAAYGOCig42Ih0I4UGSnNiqBS4xIIHYfDjChzbL
 WAEjNpiHM/B9fnQLLIWW357uOwciZ6zBo+BGMp5haaAM1v49ummerHGKmbcdek8A4COu
 nXfMQonapVNdeI5bFJlFpz4SmNDbLz3LAqXaHS3LVz7yDSvEdMkj+xbO2DWjCTInCK6T
 QehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721940326; x=1722545126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YZy7bY3iVSg1wM0zqnDmY47LgMxJoEvXU8nrH0f8DpQ=;
 b=RZY/DkmIqELrX7YExP5PGlU14pcRf7G2Ki0xaoCge4B5XnivcCZlKTin02PfqhiEkT
 xrZwOTUNu4ZN9mRJ4GVeK23DN3DKMrHcmV9e8DjrLjPzkyce4oXVd+lhjLncOOh2KUsh
 nTDeGsbcdU35gVhaJbyM1ZusdU4imS0QP1JFGLu4lHlKVJWUHvBjjv1WpdVXxHj64M8I
 7ca60tZk2Wp6h070qtJhAjVkSg9eauvRHBXbL/EkIwM0FeNg2ljwp+BOgyNP88S9XJwG
 REts1xbvNMIjQ50A40f/bnXJt2+Fb6oJS2VMboRHXIF40SwtHRRDxLfSdluq3vssI2rD
 cPhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrnfB1HZaY9Us8cXxmNpNu7ycIFSqymMwlSt2G18cTBkSnBZsmOloqlWtRWGMYfcc0HZvB1dE9f9zrAsRhK0oxc4KYkQ==
X-Gm-Message-State: AOJu0YyOQTu3CsPRd+Q+qu21rdUOq243WCX6EQoT15jG3ShfgG21Pf82
 2hWE3XESW8zmoUDPRsz1gDzz51Q932tdULgqckO/qFWrVoFAMTqhPHaSTDGFarQ=
X-Google-Smtp-Source: AGHT+IGrY5jJ1QntpeJ52MDbHpRr+5rfVmI2rWUkjOrVjFiHYm3oP2WtQJ7CykZr3FmL8ZX2oYA3xQ==
X-Received: by 2002:a05:6830:f93:b0:708:b286:f6f1 with SMTP id
 46e09a7af769-70932223625mr3830304a34.13.1721940326438; 
 Thu, 25 Jul 2024 13:45:26 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7093050a35fsm452471a34.6.2024.07.25.13.45.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 13:45:26 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Minkyu Kang <mk7.kang@samsung.com>, Minkyu Kang <promsoft@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v4 07/38] mmc: dw_mmc: Extract DMA transfer handling code into
 a separate routine
Date: Thu, 25 Jul 2024 15:44:49 -0500
Message-Id: <20240725204520.18134-8-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240725204520.18134-1-semen.protsenko@linaro.org>
References: <20240725204520.18134-1-semen.protsenko@linaro.org>
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

Make dwmci_send_cmd() easier to read by moving the DMA transfer handling
code into a dedicated function.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v4:
  - (none)

Changes in v3:
  - (none)

Changes in v2:
  - Added R-b tag from Quentin

 drivers/mmc/dw_mmc.c | 51 ++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index b99f63a6f8bd..8fc26399034b 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -232,6 +232,33 @@ static int dwmci_data_transfer(struct dwmci_host *host, struct mmc_data *data)
 	return ret;
 }
 
+static int dwmci_dma_transfer(struct dwmci_host *host, uint flags,
+			      struct bounce_buffer *bbstate)
+{
+	int ret;
+	u32 mask, ctrl;
+
+	if (flags == MMC_DATA_READ)
+		mask = DWMCI_IDINTEN_RI;
+	else
+		mask = DWMCI_IDINTEN_TI;
+
+	ret = wait_for_bit_le32(host->ioaddr + DWMCI_IDSTS,
+				mask, true, 1000, false);
+	if (ret)
+		debug("%s: DWMCI_IDINTEN mask 0x%x timeout\n", __func__, mask);
+
+	/* Clear interrupts */
+	dwmci_writel(host, DWMCI_IDSTS, DWMCI_IDINTEN_MASK);
+
+	ctrl = dwmci_readl(host, DWMCI_CTRL);
+	ctrl &= ~DWMCI_DMA_EN;
+	dwmci_writel(host, DWMCI_CTRL, ctrl);
+
+	bounce_buffer_stop(bbstate);
+	return ret;
+}
+
 static int dwmci_set_transfer_mode(struct dwmci_host *host,
 		struct mmc_data *data)
 {
@@ -274,7 +301,7 @@ static int dwmci_send_cmd(struct mmc *mmc, struct mmc_cmd *cmd,
 				 data ? DIV_ROUND_UP(data->blocks, 8) : 0);
 	int ret = 0, flags = 0, i;
 	u32 retry = 100000;
-	u32 mask, ctrl;
+	u32 mask;
 	struct bounce_buffer bbstate;
 
 	dwmci_wait_while_busy(host, cmd);
@@ -382,26 +409,8 @@ static int dwmci_send_cmd(struct mmc *mmc, struct mmc_cmd *cmd,
 
 	if (data) {
 		ret = dwmci_data_transfer(host, data);
-
-		/* only dma mode need it */
-		if (!host->fifo_mode) {
-			if (data->flags == MMC_DATA_READ)
-				mask = DWMCI_IDINTEN_RI;
-			else
-				mask = DWMCI_IDINTEN_TI;
-			ret = wait_for_bit_le32(host->ioaddr + DWMCI_IDSTS,
-						mask, true, 1000, false);
-			if (ret)
-				debug("%s: DWMCI_IDINTEN mask 0x%x timeout.\n",
-				      __func__, mask);
-			/* clear interrupts */
-			dwmci_writel(host, DWMCI_IDSTS, DWMCI_IDINTEN_MASK);
-
-			ctrl = dwmci_readl(host, DWMCI_CTRL);
-			ctrl &= ~(DWMCI_DMA_EN);
-			dwmci_writel(host, DWMCI_CTRL, ctrl);
-			bounce_buffer_stop(&bbstate);
-		}
+		if (!host->fifo_mode)
+			ret = dwmci_dma_transfer(host, data->flags, &bbstate);
 	}
 
 	udelay(100);
-- 
2.39.2

