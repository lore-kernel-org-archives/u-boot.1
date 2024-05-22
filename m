Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04C7C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 23:34:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F22588576;
	Thu, 23 May 2024 01:31:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pDF07FNh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4207F88545; Thu, 23 May 2024 01:31:54 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78603884F1
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 01:31:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6f0f728d373so3079778a34.0
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716420707; x=1717025507; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Im5kRYqjyNpmw7Qa9SARNYoYZaSzc8/1LwpQ1B6RgKM=;
 b=pDF07FNh+e2KRb/O+Rg8gL5ilMlipPKtNIfQG8J7BusT1l81MewjIA4L9X+gznckhr
 K476Z//H4jrO//+q3T6sxcb5Tlvd00yBAdjgM1br9lXfdtFvntbpV0kofaa3lSMzALhV
 sb4FHqcvRWfT2Lqg+LtVbd3xxf79UjOm8P7iFu4jFnD+vlc9usPHiRAEmFdTFizHFCmP
 n4ge7J9pTQc1+cymdnimWlNczBxLaXumKOXY+PpFSy9Yy6tfMin2aVYygS4mnn938evW
 BhvzYDdC9J9xPTxVv5OBoZeP2lafXoIVTllOkBR5E4oyraFcHhd+cF4miPPzv1i+kck6
 4nvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716420707; x=1717025507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Im5kRYqjyNpmw7Qa9SARNYoYZaSzc8/1LwpQ1B6RgKM=;
 b=SJ5wmF+EoKjS4LNjHS7oKKCV8TdzKxHau7t5Px7sh7KWTEbW97JVbbwWkCyb2aTyBt
 hAf67qHa5lGN5K3dyyEUdSK1FV1SF1p1bWvRvB0cQF9gE7BN9I4S8dZqVrd/KwOsCsR6
 JbOFJLl2RWLKuy/z4yuFJz8twoMdYTcNNJmRkI/Z3Q6rQ32uHvO+CEgQJ6hF6pTJeUZJ
 Qr6OzHr6k66NJHq/1OsybA/Kf1mUNlUm2sdPf9LmCfq5LWey3eIX72dXXCQMU6zThASE
 +/LIpBZ7Tzt8UAOEwSgqQkfiYeTaTE67A/+aYzZFmOt8uXYVijb+ktQCgtZTzgTye3ey
 5jbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbjMn7Rtq3EJxpQPHtrlUwEQOHoD7WHhC95OLZ+vtwjFPTWKdX2QCXOSCDXCYXkAYKNdB/dSqC0I3zgn57tQqF/nHWZw==
X-Gm-Message-State: AOJu0Yw9A1CQkGxOK3DCnkSwMU/IiTXX6itCZn9RC3iB2e9ZfnPYemBb
 Q1VhPYSzToK+975Ko7yjnvAvEHM7DX0FdR8amfznIjiD5onFkpzc9b9I/3VDork=
X-Google-Smtp-Source: AGHT+IHvX8uhPXIO8+w3JwI8wropGbRUuY4H6zooSTJAGMbJUX0PVAA+qLiytRyitzd+5CDqhipI6A==
X-Received: by 2002:a05:6830:1e32:b0:6f7:fd41:b60f with SMTP id
 46e09a7af769-6f7fd41ddcamr351734a34.20.1716420707688; 
 Wed, 22 May 2024 16:31:47 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f137fa5d17sm2244071a34.76.2024.05.22.16.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 16:31:47 -0700 (PDT)
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
Subject: [PATCH 14/42] mmc: dw_mmc: Use CONFIG_IS_ENABLED() to check config
 options
Date: Wed, 22 May 2024 18:31:07 -0500
Message-Id: <20240522233135.26835-15-semen.protsenko@linaro.org>
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

Use CONFIG_IS_ENABLED() macro to check config options as recommended by
checkpatch, instead of checking those with just #ifdef CONFIG_...

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/mmc/dw_mmc.c | 6 +++---
 include/dwmmc.h      | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index a1f06931b7ac..ebe239547a7d 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -573,7 +573,7 @@ static int dwmci_setup_bus(struct dwmci_host *host, u32 freq)
 	return 0;
 }
 
-#ifdef CONFIG_DM_MMC
+#if CONFIG_IS_ENABLED(DM_MMC)
 static int dwmci_set_ios(struct udevice *dev)
 {
 	struct mmc *mmc = mmc_get_mmc_dev(dev);
@@ -713,7 +713,7 @@ static int dwmci_init(struct mmc *mmc)
 	return 0;
 }
 
-#ifdef CONFIG_DM_MMC
+#if CONFIG_IS_ENABLED(DM_MMC)
 int dwmci_probe(struct udevice *dev)
 {
 	struct mmc *mmc = mmc_get_mmc_dev(dev);
@@ -738,7 +738,7 @@ void dwmci_setup_cfg(struct mmc_config *cfg, struct dwmci_host *host,
 		u32 max_clk, u32 min_clk)
 {
 	cfg->name = host->name;
-#ifndef CONFIG_DM_MMC
+#if !CONFIG_IS_ENABLED(DM_MMC)
 	cfg->ops = &dwmci_ops;
 #endif
 	cfg->f_min = min_clk;
diff --git a/include/dwmmc.h b/include/dwmmc.h
index 77c8989148a1..9252bef24329 100644
--- a/include/dwmmc.h
+++ b/include/dwmmc.h
@@ -268,7 +268,7 @@ static inline u8 dwmci_readb(struct dwmci_host *host, int reg)
 	return readb(host->ioaddr + reg);
 }
 
-#ifdef CONFIG_BLK
+#if CONFIG_IS_ENABLED(BLK)
 /**
  * dwmci_setup_cfg() - Set up the configuration for DWMMC
  * @cfg:	Configuration structure to fill in (generally &plat->mmc)
@@ -334,7 +334,7 @@ int dwmci_bind(struct udevice *dev, struct mmc *mmc, struct mmc_config *cfg);
 int add_dwmci(struct dwmci_host *host, u32 max_clk, u32 min_clk);
 #endif /* !CONFIG_BLK */
 
-#ifdef CONFIG_DM_MMC
+#if CONFIG_IS_ENABLED(DM_MMC)
 /* Export the operations to drivers */
 int dwmci_probe(struct udevice *dev);
 extern const struct dm_mmc_ops dm_dwmci_ops;
-- 
2.39.2

