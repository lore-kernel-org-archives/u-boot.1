Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 057DAC369D1
	for <u-boot@archiver.kernel.org>; Sun, 27 Apr 2025 21:46:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 068C780FDA;
	Sun, 27 Apr 2025 23:46:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SloxEzi+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E187D80FDE; Sun, 27 Apr 2025 23:46:32 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFEE780F9C
 for <u-boot@lists.denx.de>; Sun, 27 Apr 2025 23:46:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@gmail.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ace98258d4dso177972166b.2
 for <u-boot@lists.denx.de>; Sun, 27 Apr 2025 14:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745790390; x=1746395190; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oAjFa7yTygzk4roM4dfrhOe8g6XJCS7IoRb6035k42w=;
 b=SloxEzi+JJv2StP6uDKgGq25ZvVD37rmVGF7J1x8LH4dVigGKcmlA61tICxyxBZThT
 3MwiJNa6GbWaEjiVAc0mYgX3SwAPIeWlKk+rKRNb/5S/gq2SMFG1tZ+kdFbDX+yyw985
 Ta9MEAczpHWf7eZPASr9kD8ckS6KByzWtcMCIAnRKeWD7aUx2y6hzpCpJ0KjQwUgsWLM
 OHkV9XsYDI4n9pmP/omCfX9V1BjFrUxnKThTtjh8dPiW0bqcqMSU7U+cU61Bgw5eNX6m
 SkN5KkQtlfTNdbDgZcSSsnEwg65orOerk2zdmQBwdg4GUQa3iVAV7sb4vkPcTOo0ZQ8N
 +ahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745790390; x=1746395190;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oAjFa7yTygzk4roM4dfrhOe8g6XJCS7IoRb6035k42w=;
 b=JJ5epIvmEPQlMJsOpEo8Fd5+i08e/hqH0PgK/AAX8t25D8+noERnsxy4Ne+XpVD+1e
 hB2sDAoxS07HvrZxHGexiX1mq5hmNWQZhQypBbj7oc1wmUc5B7Dt9LTccx6nO+dYbthJ
 G2nRK2VfSLOdOxJDMXr8yTM6sGI9rBJ3CwyKdyoBOh85nMxzw01NLq38FD6GTeCsgfB1
 7ieW+iBnokFp1/+HNcXHzpxIIkGjHNJB8fM6Mnoidu5Id2njX7Fcvj7hjARSnKrrM67T
 eGZMJ+FW1zNL09JCPKqtZ9W/hwe35tH7007eCISryzLBUenzNXBNZYD4HVf4rITHIpYf
 eQHg==
X-Gm-Message-State: AOJu0Yy43293EKNZAm8jEtJNatke1yX/QseprXj07Ytg26az+ISje5Qm
 CnhZOZHBLZYKl4hM32qCovV4MnXNM9kU4SLzPnm5rt7WEWqGsyV18Ucuzr2Q
X-Gm-Gg: ASbGncv6s1Bslofv9Ta3Y1AgWq67S64jQ5HKHC+/crm1qxSVgPHyE0hs2YhPS+lm4w4
 qfK7fE8eRdvwGt1Z1vBMXx31wN8DD1Os5Wopm4Be4Z4B4Z9/4UUoeJRRzeqQabI9nPDuctpwz0H
 mvtrjjYU204v7Gw4pGYfdFrBeE+qrg7GYAuHzlK7jCnl6J2oeXTu0CbD+OaBj7imzbfcxuQD9rb
 1RdymgDLvVys9QrJWknQxrcTLdbK9OURb77M4TsVPmohzbaQwoEO8NVxrYp9fO++hF16U1llYtA
 9340gT7qhDhmIwgOSy3VKtnUNf+KdrpVA97+Z1xqzmeh8ZXTDktpow==
X-Google-Smtp-Source: AGHT+IGDwAhbYXZ7aDAxmUK2ZrXZXbnmdhTzR2SkoJq83+THigGhlbHv7/ihaYT6w1Nohw0NmQvH2Q==
X-Received: by 2002:a17:907:3e12:b0:abf:6ec7:65e9 with SMTP id
 a640c23a62f3a-ace7136ed20mr954136166b.43.1745790389956; 
 Sun, 27 Apr 2025 14:46:29 -0700 (PDT)
Received: from giga-mm.. ([2a02:1210:8608:9200:82ee:73ff:feb8:99e3])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ace6e41b5e7sm518974266b.13.2025.04.27.14.46.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Apr 2025 14:46:29 -0700 (PDT)
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: u-boot@lists.denx.de
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Kongyang Liu <seashell11234455@gmail.com>
Subject: [PATCH] mmc: cv1800b: Fix build without MMC_SUPPORTS_TUNING
Date: Sun, 27 Apr 2025 23:46:19 +0200
Message-ID: <20250427214637.321693-1-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.49.0
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

That's how it looks like without CONFIG_MMC_SUPPORTS_TUNING before the
patch:

aarch64-buildroot-linux-gnu-ld.bfd: drivers/mmc/cv1800b_sdhci.o: in function `cv1800b_execute_tuning':
drivers/mmc/cv1800b_sdhci.c:47:(.text.cv1800b_execute_tuning+0x50): undefined reference to `mmc_send_tuning'

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 drivers/mmc/cv1800b_sdhci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/cv1800b_sdhci.c b/drivers/mmc/cv1800b_sdhci.c
index 4e75051c317..377e6a887df 100644
--- a/drivers/mmc/cv1800b_sdhci.c
+++ b/drivers/mmc/cv1800b_sdhci.c
@@ -31,6 +31,7 @@ static void cv1800b_sdhci_reset(struct sdhci_host *host, u8 mask)
 		udelay(10);
 }
 
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 static int cv1800b_execute_tuning(struct mmc *mmc, u8 opcode)
 {
 	struct sdhci_host *host = dev_get_priv(mmc->dev);
@@ -61,9 +62,12 @@ static int cv1800b_execute_tuning(struct mmc *mmc, u8 opcode)
 
 	return 0;
 }
+#endif
 
 const struct sdhci_ops cv1800b_sdhci_sd_ops = {
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 	.platform_execute_tuning = cv1800b_execute_tuning,
+#endif
 };
 
 static int cv1800b_sdhci_bind(struct udevice *dev)
-- 
2.49.0

