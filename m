Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1907CF58E3
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:28:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F2C2893FE;
	Fri, 20 Sep 2024 09:25:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VaHx2vig";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CE3789402; Fri, 20 Sep 2024 09:25:39 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CB6A893D1
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:25:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42cbaf9bfdbso14853505e9.0
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 00:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726817120; x=1727421920; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HiGZqNy5JACrg4auQhNxNzfpuIuwXcvj6OAp1Au8vfs=;
 b=VaHx2viga723WxLu6hY5gwCvPPoDXILJMyb5gIgF5woDANnKpUBwXodGMsKKsPh0Su
 CAY1Xke0yisDAF5fdId4IbrR75jwMrDaj/ECz80omYfjzn/ZglhbI7pc+20rt+ypl5xg
 hZNbUpU6mQQpzOkdwlx3j6aYOT4JbpUsogeqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726817120; x=1727421920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HiGZqNy5JACrg4auQhNxNzfpuIuwXcvj6OAp1Au8vfs=;
 b=i6pdhKjBMXUNn4wGwWXzeHxgQtpKnxf62gMxq/7P3IODBmdY0YRg02qWyaooagWDVR
 9S8PTZOiKlX+1UltU5o8SlBxXQ4dKLHK6HOrXTSATFbN+/VTKyznhxQq/Aky8UF+Ymwu
 VRyVlAIOaVsQx5q65lpaw11yf9O1KWgYk6d1cYMEaJHmQDf6A/sPEPuS4YIuewYTFoIb
 15rY2RWotzTVeRgDZDh6qFihOb+Ww+kqPrKWHj71SJr3NILhGtH1EiIwx9P58X6CgFi5
 h3ir/C8z3iqNXozpIZVq47AaLpXwpsHVd+wvFqNiMlCY98N6r/8c4ImuKrsLkOI9dEKm
 ImKA==
X-Gm-Message-State: AOJu0YxuHfiLSptjHevAjp3EPK3o263gCpmem7o51BCKYR0WN6n2wvi8
 QdvH9JBGHqyTe5UUzrEnP/E5KC6XS3zllOskO2lorDCXbn0F5Pd9SpT9kVtuID56/Ie851RNkdY
 bkSWL
X-Google-Smtp-Source: AGHT+IFMg37jzTMYt+pRpMgqYwPviTXVZr1UuMhQ1hZAOAvjD0ej+jO56Qnt+FEJEgI5nJMqSwbU6Q==
X-Received: by 2002:a05:600c:1987:b0:42c:b9b1:8342 with SMTP id
 5b1f17b1804b1-42e7ac2deb9mr12835005e9.19.1726817120409; 
 Fri, 20 Sep 2024 00:25:20 -0700 (PDT)
Received: from chromium.org ([185.44.53.103]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e7540e32fsm41504535e9.9.2024.09.20.00.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 00:25:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Minkyu Kang <mk7.kang@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 16/18] mmc: rockchip: Allow clocks to be missing
Date: Fri, 20 Sep 2024 09:24:40 +0200
Message-ID: <20240920072444.134997-17-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920072444.134997-1-sjg@chromium.org>
References: <20240920072444.134997-1-sjg@chromium.org>
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

(no changes since v1)

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
2.43.0

