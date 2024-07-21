Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B6E3C3DA61
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 15:28:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83A1787FCD;
	Sun, 21 Jul 2024 17:26:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fxkM3atI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F13487FC8; Sun, 21 Jul 2024 17:26:48 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58B72880DB
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 17:26:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4272738eb9eso25905825e9.3
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 08:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721575604; x=1722180404; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7my0wq2xTfxMkihNoXREdndWHL/RZnT90h6r1lGDcIU=;
 b=fxkM3atIUwd9cHl9GS7piWkwl5QEc2ZRI/fa3IopoZTLN4tlPJ5SJ6GhGmvVbCXlmF
 tdihvhc8edJoKJM9dUlfPFg4sucWWk8aHmrY+eT32e8N9TQwBLYyjJEyi5FV31T2yjYh
 Gtew4JpK87N94tccm7NjPFcvdciyR/XKfPANI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721575604; x=1722180404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7my0wq2xTfxMkihNoXREdndWHL/RZnT90h6r1lGDcIU=;
 b=mLli6KGrmjTLLnaX8jspcLMG3N7VjiJFjwsrsnSLVzU54HAqXKE2RV4di5MvWJuyfy
 PGf5mrMOvFnxa3TrmYLP0pVsDW+5gaxa0sSeEmME1+wwkaGNSIckDByhNypmKCa4yBlT
 ybTFn7qKwY0xEBMOmUOW2Bgjp2cIUGnzsHb98Wt1nzHX6bH0B16svLr39MZra+WUfSRs
 7Lc+GMZxo0UrIDs4rj0+wOQi80WnPe+ivnMx7UHn3b0cgnEs7K+ylfSITPdlIgMMUj1m
 i19F+BcjefX1NWqCIzDWC7f2BZgw+5IsfXsFi2XwBnJOBOqLcL2u6elgrWgMTODAbO7b
 JJDw==
X-Gm-Message-State: AOJu0YwZE0w/qTxGvy+JbCBj58R6EAm4Sqc2q+RgWj8uUhBtMNGwRwDk
 6Q18JjMVxnitTdYXKPhtSE9Pq5F+IzBas6sSnrbASPucizbsTqMgrksfNAXVuljjkHgmfMVZAng
 =
X-Google-Smtp-Source: AGHT+IHkP9TVcVfnSq+DYvHKHPLho1m1079LMp0VgCbDGtip5V1YLLHKu1IlyS71tkOXApr8TjbJpw==
X-Received: by 2002:a05:600c:3542:b0:426:59fe:ac2e with SMTP id
 5b1f17b1804b1-427dc559b85mr31770835e9.29.1721575604714; 
 Sun, 21 Jul 2024 08:26:44 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427e5803bb0sm8702255e9.45.2024.07.21.08.26.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 08:26:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 10/14] spl: mmc: Adjust args of spl_mmc_find_device()
Date: Sun, 21 Jul 2024 16:25:55 +0100
Message-Id: <20240721152600.3212917-11-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240721152600.3212917-1-sjg@chromium.org>
References: <20240721152600.3212917-1-sjg@chromium.org>
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
---

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

