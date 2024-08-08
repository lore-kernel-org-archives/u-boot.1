Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB4AC3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 03:16:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30D3988AF6;
	Thu,  8 Aug 2024 05:15:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="L7RDndfT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CBA98873C; Thu,  8 Aug 2024 05:14:55 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B78A48871A
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 05:14:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2611da054fbso393890fac.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 20:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723086890; x=1723691690; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lajTQ3JYoTyQySiuDMhbE4W09/EbwBdHGoc2IwlOBbU=;
 b=L7RDndfTf2X01URl93pc84NUFEuRt541PiZ4qjnuIgEf8o45P01aQ5l1hAYyxHYMxh
 KpxODW9kEEb6gRCC3dZ2UfuW4W1MUQcFJwOW5IqfETbngTedEWqeCemIwGhc3Fs2WxB8
 9zhI0f7VftGFGJlAgAVMQuvCdEo/IliKAfawwP+TipvT2PNomCSAf75MkvDE3obbZ6jJ
 JPc7f64NpCdx3BYtbKaqruWQeoduPYXorJDrX24eR3anSyKIlPirelK3VoKlz63kNlmS
 U2qDRUnFLilL50244gXvkW4np4/ZIBQ2ueFE0RgLsQJqCY5ddqNCH5H6fgn4tptl24yK
 Q3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723086890; x=1723691690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lajTQ3JYoTyQySiuDMhbE4W09/EbwBdHGoc2IwlOBbU=;
 b=MIPYdEH/Yzc4hHxnpi5mxGY53rCAs50OM50xvcI7lwv9rbirY+PuJHVSFdKlB8Rd4s
 DyWsxPpgSxT2yvxggM1J2QLLb8dvBlQwgJ/slDlYqbFiujDc2llFZA2u+fT1f/jMRBSV
 8ZtwTbMhX6tSS23ZA8l+OiJ5J9JIk60OnwhJsfnFeK2rD5aJqgmzNovMSv5DyRpqE9b/
 OD3ZjLtMbJ653pqeTHw/LIiTzrwGxjvTdDBqFmgTyPZDpagEz0LhroQb4MGg2ad2dybe
 163KWcYw9wu0iqdy5qqIem1EFjZsRAW8YQ3xkdYWaXTnAtrjYMvXwe9vsSkTW4Zvpm+N
 Ov0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3nZIX+gR9nBOco+/QqEsluTpn3m4kiBv3iu7/lBkJ6dHcM+Wp1kAXjDI22sM9vvVZbT3oXfYOoN2xvpmxjXNID9zgsg==
X-Gm-Message-State: AOJu0Yz9dLEGpIlgLlCWKuedhipIeZcCMBP7vmD3s6oe/ibUthwwJf2O
 st2Q4FI9i0oXsD4GE/a7nZvYr+w/SihR60VHNyxiBKNNOcttIm3GBwLBExdHjqo=
X-Google-Smtp-Source: AGHT+IESr+Ym6H4kcFfpMNkZM+wJuXXuIBYyK4+C3zAioYh+7sdgrkUSTwOu/oOh3gGDzfC8BJBlOg==
X-Received: by 2002:a05:6870:d107:b0:260:fdd5:4147 with SMTP id
 586e51a60fabf-2692b63ef02mr709416fac.15.1723086890236; 
 Wed, 07 Aug 2024 20:14:50 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2689a2f1af9sm4379042fac.13.2024.08.07.20.14.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 20:14:49 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <promsoft@gmail.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Tom Rini <trini@konsulko.com>, Henrik Grimler <henrik@grimler.se>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v5 07/38] mmc: dw_mmc: Extract DMA transfer handling code into
 a separate routine
Date: Wed,  7 Aug 2024 22:14:13 -0500
Message-Id: <20240808031444.9619-8-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240808031444.9619-1-semen.protsenko@linaro.org>
References: <20240808031444.9619-1-semen.protsenko@linaro.org>
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
Changes in v5:
  - (none)

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

