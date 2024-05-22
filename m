Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E09CC25B7C
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 23:33:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C3CD88546;
	Thu, 23 May 2024 01:31:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="T+jhb3/P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21C3F88505; Thu, 23 May 2024 01:31:46 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC321884DB
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 01:31:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6f0e4212d5aso3043594a34.3
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716420702; x=1717025502; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HcY0epwhpfO0hsI44S2jc8vf2UMELxebOpqmzAF7DOw=;
 b=T+jhb3/PAzEKERsb1kjjZqx12MZEyNj/GFr1T51RLX7tAyEj8HTuAfSRhinLjlCm2Y
 w2XUtqKnP1SO8iXdE92iYwAVsqhv4A6rvMGYG+F3IrftyA9XyoxdRrvjf5eYJDJhyMcu
 8eTQIU6Wu7o/CoYNZsdPgmxb91mwLRohjS1GmrD982r9GBaVL+8LU4pU0OIc9NgRN/uu
 dMo9O8BqyUNzrVLkUdhD90yNNJWScRGGKWMpVh0FEZBPQzwUO9uCT2Qac95Q8gnYO9tg
 EtwXk25/c1KHazP8rhxmCgj+4acJNBi8RuSyGKHeH/2eNQz22WsNWbll6F0Y6eqPGMqK
 LtXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716420702; x=1717025502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HcY0epwhpfO0hsI44S2jc8vf2UMELxebOpqmzAF7DOw=;
 b=KL6NVPtRqleXhKuw6fDisaJb1FHsjwGQatbmZJVlDpFLXMUMwFmmHqteESTcM7GO+m
 vNo7OeXp93HSXGvYrQbn+5Jj3OgwO2ugr9IaCpc4HomnpX1xNoOQ3SRM7hia1kXCpWkA
 0Cc3YPiKQgYvhbyYmxRFR70MXh0z1XP0HAc34mV4ty+r0goJbYYXckirAyuLsPJg1n0g
 FIAFfsASsxSBv4AsShVpj8VJip0ZqOpiVHeB/pA7hYwsF0nmr+nIxOWk01dEWHlb15Fp
 /hTl3PCC1bLDiQyWzeBlzYVrqfadarEZt8AepwX8jwHMt52K0uJQpGiLjDAJ6lDJJin5
 5Glg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcSURCMiZzUFM8moCDScwgeAWlK9KHoUw/n3xG+IpdXadFUL56yGctQrrJHETaQmBpY3P7F0tIjztJ27YR70YjiPqS8w==
X-Gm-Message-State: AOJu0Yx8Ryro3d2JJ4127X0KzfJg5VHJpNVGLTLe/iLaNlIb2aHhC7Po
 98Vjvtiuooz54W/rbLOfSOsWpL7EEyysWbCWRwEbNfZglznzduu/j4VmrYFcfxI=
X-Google-Smtp-Source: AGHT+IHhfOTJCP5yyCXydOEXzZeIEMOiJKAkVZ3RX++XqlzAaadEZ+eAbwSu2njARj2oTgkhrbqg5g==
X-Received: by 2002:a05:6871:550:b0:24c:6024:9d61 with SMTP id
 586e51a60fabf-24c68a4e95dmr3844418fac.12.1716420702586; 
 Wed, 22 May 2024 16:31:42 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2412a3c82edsm6675098fac.12.2024.05.22.16.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 16:31:42 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH 08/42] mmc: dw_mmc: Extract DMA transfer handling code into a
 separate routine
Date: Wed, 22 May 2024 18:31:01 -0500
Message-Id: <20240522233135.26835-9-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240522233135.26835-1-semen.protsenko@linaro.org>
References: <20240522233135.26835-1-semen.protsenko@linaro.org>
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
---
 drivers/mmc/dw_mmc.c | 51 ++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index 144f29f09240..439f8eb3fb4c 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -233,6 +233,33 @@ static int dwmci_data_transfer(struct dwmci_host *host, struct mmc_data *data)
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
@@ -275,7 +302,7 @@ static int dwmci_send_cmd(struct mmc *mmc, struct mmc_cmd *cmd,
 				 data ? DIV_ROUND_UP(data->blocks, 8) : 0);
 	int ret = 0, flags = 0, i;
 	u32 retry = 100000;
-	u32 mask, ctrl;
+	u32 mask;
 	struct bounce_buffer bbstate;
 
 	dwmci_wait_while_busy(host, cmd);
@@ -384,26 +411,8 @@ static int dwmci_send_cmd(struct mmc *mmc, struct mmc_cmd *cmd,
 
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

