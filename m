Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26555C54747
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 01:48:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74B6388BE4;
	Wed, 28 Aug 2024 03:46:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OMfEW5Ma";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B29B188BFB; Wed, 28 Aug 2024 03:46:04 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98B1F88AFA
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 03:46:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-829e8718502so98511139f.3
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 18:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724809561; x=1725414361; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tq/7ltiwmS1U9Dej37uRjYbV7sDi1OVdTasyPfjGvEc=;
 b=OMfEW5MaywyJmYKVd5ri0nrrNx+y2Cm1iVgtPgovTEGUdQ81up9vaFtS81rQEza9Fu
 pVQ6ovWfiH++zwPkzBtD0a8qYnH+D7/gWjcIhXCkUB1Zyk35gHqPaqU9cyRkL/xk648I
 B03r1PjR/0ACMqDiKS9qjMWtMolJOUT6/CeKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724809561; x=1725414361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tq/7ltiwmS1U9Dej37uRjYbV7sDi1OVdTasyPfjGvEc=;
 b=Vkbpfm4oLT7/QnXASJ7b1iYbzOYdvSLZS1ZvvjJMDsJo1K6Ie5bCjBvtEIAaKER3AT
 qJfbfGgJaFdZrkNtSddUzVtQrgr5cUijV2MlCcRaSaA5ZgnMKTxzddvUjNjSkuSeGDBd
 Cn++iwNHHTD/RGNyBuohgLaQhz0UL0cPWBphc+i/5sB+b0mHmxmaNhWB1VMqII4w8MiI
 pP3TVZmuzzrajdVvlK8ddB3TZIPdPzPgrK3kgVEAs5HisCwAN6eqDp+JSzbBUyHFBlCk
 l53vdJ2Dq5ZSmAVEIDfGQ7bc1IhITSKSleKNaqOVFp/vpoUnESEx6NYUJuBY7vTjsgFS
 vQgA==
X-Gm-Message-State: AOJu0YyKmkra8wNrW3uVbp9/q89rc1TdwcU3YpdzceqGEa3KEYj1sgCq
 3fCf1KQlP05y6bRgH0774rYPKqpPb0N8hBKrEGNGULAPqXwT9qybRcNX50PzaBZjaE2ymqqqP/M
 =
X-Google-Smtp-Source: AGHT+IFpUhkKIoOLO3RNI9nnebwLAbG0wYX5jPGTR5sZzNtc2L0R2lRtWwHNLOG7f3i7wyxRTBi4Lw==
X-Received: by 2002:a05:6602:611b:b0:803:5e55:ecb2 with SMTP id
 ca18e2360f4ac-82787121f31mr1655301139f.0.1724809561149; 
 Tue, 27 Aug 2024 18:46:01 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ce70f5ca7csm2898342173.63.2024.08.27.18.46.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 18:46:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Dragan Simic <dsimic@manjaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH 16/18] mmc: rockchip: Allow clocks to be missing
Date: Tue, 27 Aug 2024 19:45:35 -0600
Message-Id: <20240828014538.3322013-17-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828014538.3322013-1-sjg@chromium.org>
References: <20240828014538.3322013-1-sjg@chromium.org>
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

Allow MMC init when clock support is not enabled in a particular phase.

Refactor the setting of priv->emmc_clk so it is a bit clearer.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/mmc/rockchip_dw_mmc.c | 6 ++----
 drivers/mmc/rockchip_sdhci.c  | 9 ++++-----
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/rockchip_dw_mmc.c b/drivers/mmc/rockchip_dw_mmc.c
index 7e341665aa3..5ba99d68b7d 100644
--- a/drivers/mmc/rockchip_dw_mmc.c
+++ b/drivers/mmc/rockchip_dw_mmc.c
@@ -131,13 +131,11 @@ static int rockchip_dwmmc_probe(struct udevice *dev)
 	priv->minmax[1] = dtplat->max_frequency;
 
 	ret = clk_get_by_phandle(dev, &dtplat->clocks[1], &priv->clk);
-	if (ret < 0)
-		return ret;
 #else
 	ret = clk_get_by_index(dev, 1, &priv->clk);
-	if (ret < 0)
-		return ret;
 #endif
+	if (ret < 0 && ret != -ENOSYS)
+		return log_msg_ret("clk", ret);
 	host->fifo_depth = priv->fifo_depth;
 	host->fifo_mode = priv->fifo_mode;
 
diff --git a/drivers/mmc/rockchip_sdhci.c b/drivers/mmc/rockchip_sdhci.c
index 35667b86b50..15b4a39770a 100644
--- a/drivers/mmc/rockchip_sdhci.c
+++ b/drivers/mmc/rockchip_sdhci.c
@@ -571,20 +571,19 @@ static int rockchip_sdhci_probe(struct udevice *dev)
 	struct rockchip_sdhc *priv = dev_get_priv(dev);
 	struct mmc_config *cfg = &plat->cfg;
 	struct sdhci_host *host = &priv->host;
-	struct clk clk;
+	struct clk *clk = &priv->emmc_clk;
 	int ret;
 
 	host->max_clk = cfg->f_max;
-	ret = clk_get_by_index(dev, 0, &clk);
+	ret = clk_get_by_index(dev, 0, clk);
 	if (!ret) {
-		ret = clk_set_rate(&clk, host->max_clk);
+		ret = clk_set_rate(clk, host->max_clk);
 		if (IS_ERR_VALUE(ret))
 			printf("%s clk set rate fail!\n", __func__);
-	} else {
+	} else if (ret != -ENOSYS) {
 		printf("%s fail to get clk\n", __func__);
 	}
 
-	priv->emmc_clk = clk;
 	priv->dev = dev;
 
 	if (data->get_phy) {
-- 
2.34.1

