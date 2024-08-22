Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F3C4C52D7C
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 13:57:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B6DA88AA9;
	Thu, 22 Aug 2024 15:55:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bdO151F+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57C1888A9B; Thu, 22 Aug 2024 15:55:39 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB85788965
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 15:55:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-39d21fdc11bso3105535ab.2
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 06:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724334935; x=1724939735; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uKA9BygWuK8ucs9YyTkqi0uoRhd5AMeZwOpaTtqeS3A=;
 b=bdO151F+YaHMNwF5+0JX45ViohwdT343qyWpgkYxylhugFmQ72XoRu32Wv2qksR9cZ
 yKvkLWvo/WlO8M15JKKGev00+2pVASDCDHsDi8YmxTEtudOFHuZy7xHx1mf3qoMBM0gy
 krfap5sG1MjuSJToUvgNI3Io3Ax+Q/hyItg+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724334935; x=1724939735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uKA9BygWuK8ucs9YyTkqi0uoRhd5AMeZwOpaTtqeS3A=;
 b=aFGVHLcdoZpGfNJYodQ6qHzBNpBzwS2p1/xcr2PhTJTfR/THhsAbeq9rmLOVvY/8Gr
 DvOD/PPQvEStFxZ4wF1m4RCkt/AHnhxdcUA4yBORmonM43YMUS+RrY6eyN8C76pdDgRl
 hpRv8ZbTbSKPKHCI6H43kMtz85nj78Po2ajUA8QAKPxV8mC1n7hXWVBz7XJ03/5u0H2U
 3fWNPeTIQzmyj6YGSps2KpV5h5C4uQHf4MU/QS0B5+y14CAmPJMg+ENNY3F1E1fXdPPs
 Tf2FBC9xI5l52Zz/WS+tNhqG7bcz3dfD43b/Pv5mJYlwkSfPod8pGD3svRaw+HeTdNHW
 bIbw==
X-Gm-Message-State: AOJu0Yz7BUHwEKsxWX34qyamB2Wc5m+UgtHRwBqHPiAzkhd0U2gxTckl
 pusWa3eQI+55H3Xi7WUEFVhWSKZOOP+aWnO7Jk7JSI7eX5v4s7jzvN6bIf19O5Ucp2ZK62H5kwE
 =
X-Google-Smtp-Source: AGHT+IGc1vUDruesvPZsiH8TWpwVgz46P7jRW3TsIVSJT5XQKsAc2vHu45l4DZJVS5BC7fCWsmPi7Q==
X-Received: by 2002:a05:6e02:1c26:b0:39b:649:f5e2 with SMTP id
 e9e14a558f8ab-39d74b6f89fmr23226415ab.13.1724334935390; 
 Thu, 22 Aug 2024 06:55:35 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e7c1eesm6692585ab.39.2024.08.22.06.55.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 06:55:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v4 10/14] spl: mmc: Adjust args of spl_mmc_find_device()
Date: Thu, 22 Aug 2024 07:54:59 -0600
Message-Id: <20240822135503.2363706-11-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822135503.2363706-1-sjg@chromium.org>
References: <20240822135503.2363706-1-sjg@chromium.org>
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

At present spl_mmc_load() is the only caller of this function, passing
it a boot_device, an index into the available MMC devices. Pass the
device number instead, since it is known by the caller and simplifies
the code.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Sean Anderson <seanga2@gmail.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

(no changes since v2)

Changes in v2:
- Use uint for arg to spl_mmc_get_device_index()

 common/spl/spl_mmc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index bc6087e88cd..887ea760b84 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -58,7 +58,7 @@ int mmc_load_image_raw_sector(struct spl_image_info *spl_image,
 	return 0;
 }
 
-static int spl_mmc_get_device_index(u32 boot_device)
+static int spl_mmc_get_device_index(uint boot_device)
 {
 	switch (boot_device) {
 	case BOOT_DEVICE_MMC1:
@@ -73,13 +73,9 @@ static int spl_mmc_get_device_index(u32 boot_device)
 	return -ENODEV;
 }
 
-static int spl_mmc_find_device(struct mmc **mmcp, u32 boot_device)
+static int spl_mmc_find_device(struct mmc **mmcp, int mmc_dev)
 {
-	int ret, mmc_dev;
-
-	mmc_dev = spl_mmc_get_device_index(boot_device);
-	if (mmc_dev < 0)
-		return mmc_dev;
+	int ret;
 
 #if CONFIG_IS_ENABLED(DM_MMC)
 	ret = mmc_init_device(mmc_dev);
@@ -349,7 +345,7 @@ int spl_mmc_load(struct spl_image_info *spl_image,
 	/* Perform peripheral init only once for an mmc device */
 	mmc_dev = spl_mmc_get_device_index(bootdev->boot_device);
 	if (!mmc || spl_mmc_get_mmc_devnum(mmc) != mmc_dev) {
-		ret = spl_mmc_find_device(&mmc, bootdev->boot_device);
+		ret = spl_mmc_find_device(&mmc, mmc_dev);
 		if (ret)
 			return ret;
 
-- 
2.34.1

