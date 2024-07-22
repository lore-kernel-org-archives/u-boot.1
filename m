Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A39C3DA63
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 17:58:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9B3288578;
	Mon, 22 Jul 2024 19:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PDi2YLLt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF2A58850A; Mon, 22 Jul 2024 19:57:49 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8C2D88403
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 19:57:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3d934cb84b6so2749111b6e.3
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 10:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721671066; x=1722275866; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=11WuBB5C6fLNVutMYcUdxo6m0qC6Z3s9HJbjOLj/k8Y=;
 b=PDi2YLLtKibC0c9i49n05YxWkkp6hBcL5Kz3v+W7zVkTK2T0KgZlbl99I2P/XketlZ
 wiuLZAgsZB6pb7W+ANtsjNT70FYGp5vu2neGoWje90cHNWaqrYAKc3/DXZCQvR9BuhL/
 elrE4ga27Fitfam0Z14AvNBLO9jzEk7Z34O+B5v5MG1P0LkwrlmRXgG+TIpjP66TZDKQ
 Ycf8iWRyktsNSg/MaDg7bC/ErgDr/3NLX2aC9ENwC+rZLigSnhzZlj1oF86+FmhrUEGE
 30qx/B7tA3RAtvMZIfaw6Z1PTKLaihsBZqWZRFZ9/plkU2BRx4KL1Ipsgo20rOeWVGgy
 9X9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721671066; x=1722275866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=11WuBB5C6fLNVutMYcUdxo6m0qC6Z3s9HJbjOLj/k8Y=;
 b=hwJwXfT3fmOYDKsILNORFBf9q5NUMTicsQB2R6YRWum79oVU17JdVVHP7PnTlSth0p
 LKsEaledi2EJ7RCnqXRPGBB2GTJsZJDmOUdMbJop1zU8t5/OfxexKXfBPzctjjXBG8s9
 v2d/0ASg2ekh5qitLLpOiWG0+qxBV2K/L0YlgsEzYhd5EuNGX4ELLG+HIEChQ+EtRkKn
 5mdteW1faCdG1DGgMPHrNx4VKgGGaBmcTBP0+ZVLcvnekpeq10n8HsE8S495WT1hXdbV
 wQEGp9L+CVuYTVJcNo3IBOGjuyNctFddsQAp2GXmLVcIxibhHuEX2Ozzx6vUSYPzP6zH
 i3Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdoOxsl9Am3G0CxKs581/tdfjtxJtWIKWa1xAPoAAiv5bUDElzqTzqkLY6kLgm7b/6imDSDMQa5EFEF6BZRS0eW12ZEA==
X-Gm-Message-State: AOJu0YxQRgpB7nUH5El8yy1ouICiPMDZ0l8BKzN1aprXsih6b/iI0Ecd
 OUGx0HUPI5pqugKxiya3FrzyrOcsP1GsPVqbrisrw+Krl+uz89efdHPsyNLMp18=
X-Google-Smtp-Source: AGHT+IGrMQjbB1BkbYsxSCZnVVz7kqTjqUqEjvTlJeyb/uJ9ybTKy8GVEclNp1Fdhl9uckCHm5CZIA==
X-Received: by 2002:a05:6808:1688:b0:3d9:37b8:dae7 with SMTP id
 5614622812f47-3dafd0ba558mr796315b6e.1.1721671066473; 
 Mon, 22 Jul 2024 10:57:46 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3dae098bea1sm1599821b6e.27.2024.07.22.10.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 10:57:46 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>,
	Minkyu Kang <promsoft@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v3 07/38] mmc: dw_mmc: Extract DMA transfer handling code into
 a separate routine
Date: Mon, 22 Jul 2024 12:57:09 -0500
Message-Id: <20240722175740.6985-8-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240722175740.6985-1-semen.protsenko@linaro.org>
References: <20240722175740.6985-1-semen.protsenko@linaro.org>
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
Changes in v3:
  - (none)

Changes in v2:
  - Added R-b tag from Quentin

 drivers/mmc/dw_mmc.c | 51 ++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index 37a1125fba4f..7b20f4936b62 100644
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

