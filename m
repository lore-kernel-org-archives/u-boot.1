Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B60C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 18:03:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AE4188792;
	Mon, 22 Jul 2024 19:58:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="L1kmu7e+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07025884AC; Mon, 22 Jul 2024 19:58:09 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9A7C884F9
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 19:58:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5d57d8882eeso585650eaf.1
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 10:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721671085; x=1722275885; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F6n6p02MgaNQdakttvFqsRWuDRqBTpx7N8fwwOIzWXw=;
 b=L1kmu7e+4/oY5Bn8hguBc7dlqxTctgQyN3rkI3eAhhcCc5n/mYmnF/bnJ0AnjeIoKI
 ZjeaDYgSMoYkRTH2btx0BGuykWcYuJgws1oU+3uWwpWWwIqHxhIjUwyB3t9ByPXDtVZB
 ua74vXkGqfDPEJkb1Hp+ELly9PxOyM/vfPZ3ecBm6//XPQMBoqi5Of2/Yc1Q9EglhdXV
 5K+R8zmxRDDraYLfV+m2bJzzY64s5J9CHhFRVViHvgB50DpQw7ad36VBx14+I4feZGCo
 UAQWEVKGeWWWCZAFMKDwAmUMJXTm6qvd+WNFmqUqFM/HK34yK5Zdoo0G/6DGObZNxIEL
 VpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721671085; x=1722275885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F6n6p02MgaNQdakttvFqsRWuDRqBTpx7N8fwwOIzWXw=;
 b=PK4mXwuvoJgIN7qjyxVigQ1/JUDeJxSxatk7ua+wOkNmlBX3NjnuKsOaCmB0hkMQq2
 PKgQLryreFwOIHHY+q6PzWf5ZDoEb2axmhVlOdpnDgVAJgDgnFUCxq0frJ7C6w+hOGvo
 3dRW9cRRcy+c48okLyTnghxNnLC1pHWWXnVNsq97woXkWD4sEN3MiPuS3Px9vEqNqG1+
 gwPnlnVXvE7k3B9vKXDdcFdre+ySzJ1nKpfPiPo7fnp6f2vsmrkvpyzr4+XHDmK06ylW
 q0/EPCyykmzZPWMl0gPiEVpEVNNJEQZIVYerOJ3F2W4Qs8SiZ9e0HXiuXale1rqTIOJL
 HY4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfXJ+B27TFnJSveXBW/Zl1tqGRKKdWKKF8CH//T7B0tF94j69XMroSrAsUDg6kLq+Dgl4OWEHCL2i3KJ844ptPhIAD8w==
X-Gm-Message-State: AOJu0YzwzFRJUIjrJKscr/fJRP+7wnbxIGYA3TFmIdzNNUaNsZXrdcBQ
 BEQkiyPKimLHg4L+WmoA8KFGdkvxvn5KfxGyOxddvl6o1yeGQcF9sfh8pa0cdzE=
X-Google-Smtp-Source: AGHT+IGSY8SVUYiupgQ9Hk32/HzVuDsiB2F4uJd9bMSwFaH0kTjxGe1MgtN922U4SMbJHqxQlXNmIg==
X-Received: by 2002:a05:6820:2782:b0:5d5:5e54:4f11 with SMTP id
 006d021491bc7-5d564f41be0mr9865154eaf.3.1721671085653; 
 Mon, 22 Jul 2024 10:58:05 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d55a857934sm1413618eaf.25.2024.07.22.10.58.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 10:58:05 -0700 (PDT)
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
Subject: [PATCH v3 33/38] mmc: exynos_dw_mmc: Don't call dwmci_setup_cfg()
 after add_dwmci()
Date: Mon, 22 Jul 2024 12:57:35 -0500
Message-Id: <20240722175740.6985-34-semen.protsenko@linaro.org>
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

add_dwmci() is already calling dwmci_setup_cfg() internally, there is no
needed to call dwmci_setup_cfg() again in case when add_dwmci() is used
(for non-DM cases). Fix it by calling dwmci_setup_cfg() only in DM
cases, when add_dwmci() wasn't called. Also, this assignment:

    host->mmc = &plat->mmc;

is wrong in non-DM case when add_dwmci() was called, as it's creating
mmc object internally. Fix that by pulling that assignment into DM case,
when add_dwmci() isn't called.

While at it, add also this missing assignment:

    host->mmc->dev = dev;

Fixes: 3537ee879e04 ("mmc: exynos_dw_mmc: support the Driver mode for Exynos")
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v3:
  - (none)

Changes in v2:
  - Replaced CONFIG_IS_ENABLED() with #ifdef

 drivers/mmc/exynos_dw_mmc.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 41fb32c579ef..43111b749a6b 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -333,19 +333,21 @@ static int exynos_dwmmc_probe(struct udevice *dev)
 	host->clksel = exynos_dwmci_clksel;
 	host->get_mmc_clk = exynos_dwmci_get_clk;
 
-#ifndef CONFIG_DM_MMC
-	/* Add the mmc channel to be registered with mmc core */
-	if (add_dwmci(host, DWMMC_MAX_FREQ, DWMMC_MIN_FREQ)) {
+#ifdef CONFIG_BLK
+	dwmci_setup_cfg(&plat->cfg, host, DWMMC_MAX_FREQ, DWMMC_MIN_FREQ);
+	host->mmc = &plat->mmc;
+#else
+	err = add_dwmci(host, DWMMC_MAX_FREQ, DWMMC_MIN_FREQ);
+	if (err) {
 		printf("DWMMC%d registration failed\n", host->dev_index);
-		return -1;
+		return err;
 	}
 #endif
 
-	dwmci_setup_cfg(&plat->cfg, host, DWMMC_MAX_FREQ, DWMMC_MIN_FREQ);
-	host->mmc = &plat->mmc;
 	host->mmc->priv = &priv->host;
-	host->priv = dev;
 	upriv->mmc = host->mmc;
+	host->mmc->dev = dev;
+	host->priv = dev;
 
 	return dwmci_probe(dev);
 }
-- 
2.39.2

