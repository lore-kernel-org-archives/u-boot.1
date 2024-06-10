Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F98C27C53
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 01:14:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7175B884C6;
	Mon, 10 Jun 2024 03:12:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KL5GKd9b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F18368841D; Mon, 10 Jun 2024 03:12:35 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C524E88459
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 03:12:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-25488f4e55aso909038fac.0
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 18:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717981952; x=1718586752; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kmQzsdi9Soif9EzjVQYm9oTsPMvYEvpChPnpkt76le8=;
 b=KL5GKd9bS+fDqNBGAMIJbGrwtL11CVTx7SVbyc25ZdF167vA/QkYxO+138SxIXNTLs
 WX6iWuHLE8Uz046RKOw2wVe8DPgYpn9FJcImcIlGfbENmS0nr1uo881YX8rM9laYeQHj
 i/mlq4tHIkPB8eIEymhKTvX5wG6Akxd5jXG906U2PeOiRiNAjjTaiwEl3lIQERxOptV6
 apIYcb0KbvagMyfoyAte7AL7UbLYwzt2lyMkgbHOmZVjAz7w1nEYR7f9hgv8PZ9iLHbI
 0isf7EARHPYAiYjJ2jPzLnY/a9aDj1mqUE9uHwRIf64OUH2rJmSi26Iz7WdTZubqwhXG
 12NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717981952; x=1718586752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kmQzsdi9Soif9EzjVQYm9oTsPMvYEvpChPnpkt76le8=;
 b=uDB/Q8+ism1hKALEUSkQnakoS16KRgi27gyfZ/ZmkbNo7w2YgApHyEp9CTZ33M8LLK
 +VW66qz2c0MyQ2Hj01D2gMVYfwPuKZJPsjGBgAWVjrPA6yoQK8PPRazrf4SVErDeXNXk
 tRCIduFqyc8r/ucqt4PTVuHTdbydNO3OaBM9epvny3KqPSr0BoQMlBcQ/tSxFDkh3w9j
 aRT5xkSuJ5zWI8Ek+/NtTKC2Q/8RiYHT50F4ls7dBVo4Q0m4al9+jG1iHk335yZE5Kps
 rZ0mt8HkRWkNChpn4YbEqF18B/iEveluugfvn2M8Q4eNcn2d+yNWbYGmE73zewdh9aSL
 l4Og==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaPql9L/HbPpVyNTC3pO0DudR46ksUhhJdfqSBdTz2zRkZqUF5O9KO4/kgK8Zw8UYKJwahxVyIx0dSXkEsVj15CV7CKg==
X-Gm-Message-State: AOJu0Yy/7pOBBYxa47dNxJqnKjRumhI0vehj98l3Mopml48m3SVBPt2F
 Bq3L9dn0ccOL+m2z58HSOMzH59LlMEspZ7yYyzh2Pn3V6rF+HmciVpx2RNxbcwI=
X-Google-Smtp-Source: AGHT+IG4dCuBlY6c/trAQPpu6gvim+qYOuNxYP4t4q0ILtixygCEpHCMFdKmApmftMrJ2ROE9M+uNQ==
X-Received: by 2002:a05:6870:470e:b0:254:ad5e:da49 with SMTP id
 586e51a60fabf-254ad5efae1mr3043611fac.41.1717981952508; 
 Sun, 09 Jun 2024 18:12:32 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25447ecd779sm2070165fac.30.2024.06.09.18.12.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jun 2024 18:12:32 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v2 08/40] mmc: dw_mmc: Extract DMA transfer handling code into
 a separate routine
Date: Sun,  9 Jun 2024 20:11:54 -0500
Message-Id: <20240610011226.4050-9-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610011226.4050-1-semen.protsenko@linaro.org>
References: <20240610011226.4050-1-semen.protsenko@linaro.org>
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

