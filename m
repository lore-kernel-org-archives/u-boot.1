Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DE1C25B7C
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 23:38:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F7588851F;
	Thu, 23 May 2024 01:32:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eYFRtchp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA7C5885A3; Thu, 23 May 2024 01:32:13 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 159B68857C
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 01:32:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3cabac56b38so1282148b6e.3
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716420728; x=1717025528; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YzAlt0nt8nijIC8dJO5yduLfiDFKIZnuxjP1HyL3So8=;
 b=eYFRtchpdPzsj7ptOdRq3w84y1fWq046144s5r5pfmXDr6/y1eGh+A1cQMrr39lKax
 YAhzVdij0viBqSftqPrOoENiuQVE2lEBmLs7Xs82btLyYPtcVI9dFWR5E/uJGFf+qLFj
 ZZyBpKEvXRsTw4RLCgDgyKz9qCM1SG85OphadlJ9+CYCfOUzD05BeQiTjW/+tLZfrmab
 xphssWv924Ls0ryDj7z5zFFUVPVgSL8BeLe7881ZB1qgsWKtqALJrhSxPjBYtUCcsCAJ
 CoPa8UOAkqNAOvHlfvLETNnpmBWXyhVDLH7BxZZ0rfpP/K75tKiSaKbcJqvrZ5ll8KAP
 JeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716420728; x=1717025528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YzAlt0nt8nijIC8dJO5yduLfiDFKIZnuxjP1HyL3So8=;
 b=ooKzrOnAjiWbUzrTQRtXETdfBMtnnwE4tZug06WMyyvCsLjMBZp+V0ewJVXiMN241t
 yim+FYqOQJPyGK4zlqbMEYFiwr1skTgVwttBfcocKQN9vuMpWwlqS7HRcvwQ7rXqFm7X
 MoTdDMb869WW5m6IS6sgoSR0prd4lf2V/nadEKvqdez7nnZ1XXrcRdSAu5EHYJannMbH
 TFjlFwVMDVyjegxEr/UvcWgSg7OacvUNAKculuGfBrrTMNfIt2asK+5UL8dpR6Oj1bFj
 0vB8V72mMHpLIavkToqH7TbnWuxw2IbzUXzHeTAUC0HddZ6HtbZF5HyB685Gd44oKhCp
 aejA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVu/aY1SZ1liXJhdVKpsFPviSgacMpHscDvwX4j+qFWQ8nZIHB9/M4wX4MGOPJP9BZFNO6EWDIee1FWNrBVtl0qk74lfQ==
X-Gm-Message-State: AOJu0Yzlo2xq8c/Wf9psT3m6K7vOuQcL5T466kSIMKmVk4pNDdbUL+q1
 O8pPLAM5obRwdaPSFoXjIqAp/p2ldB6rbGFQUXMBz4gxGDv6CHDtt6/+Np0aCQE=
X-Google-Smtp-Source: AGHT+IG+V2hY1uq6trPmAqJ3ALNRaRkP2dxvz1k3ukz9D+Zu19KhpEYqc4FpxYmJDxlwS+vLsOHNyw==
X-Received: by 2002:a05:6808:13c3:b0:3c9:93bd:c3b1 with SMTP id
 5614622812f47-3cdb20afe3cmr4529417b6e.23.1716420727877; 
 Wed, 22 May 2024 16:32:07 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3c9a5f0e6cfsm3861695b6e.2.2024.05.22.16.32.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 16:32:07 -0700 (PDT)
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
Subject: [PATCH 38/42] mmc: exynos_dw_mmc: Use dev->name as driver's displayed
 name
Date: Wed, 22 May 2024 18:31:31 -0500
Message-Id: <20240522233135.26835-39-semen.protsenko@linaro.org>
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

Reduce U-Boot footprint by reusing dev->name as a driver's displayed
name. This changes boot device name (and "mmc info" output) from "EXYNOS
DWMMC" to something like "mmc@12100000".

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/mmc/exynos_dw_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 373dd2df206e..84a079256bca 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -327,7 +327,7 @@ static int exynos_dwmmc_probe(struct udevice *dev)
 		       "continue anyway\n", host->dev_index, err);
 	}
 
-	host->name = "EXYNOS DWMMC";
+	host->name = dev->name;
 	host->board_init = exynos_dwmci_board_init;
 	host->caps = MMC_MODE_DDR_52MHz;
 	host->clksel = exynos_dwmci_clksel;
-- 
2.39.2

