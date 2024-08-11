Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DC8C52D7C
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 12:31:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5114E88876;
	Sun, 11 Aug 2024 14:29:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y6CRc5rn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CED3E88847; Sun, 11 Aug 2024 14:29:46 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1DBE8885D
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 14:29:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-81f921c40a0so133589439f.0
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 05:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723379382; x=1723984182; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uKA9BygWuK8ucs9YyTkqi0uoRhd5AMeZwOpaTtqeS3A=;
 b=Y6CRc5rn5S/xCyvEq3F+s7nvxf53bVpiq0YNLxfFJLwJ49saR4dUkRIIFfOUixsK1L
 a+N8T9XKzoNPpaSbN8VTZm70GzW8Iajyc5QvyUdDHxY2bPulrrbOEnBxBh+DKzqGffYa
 haY6GgHW2/GHXCirdXyOoexcxyGbXOUhMsLEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723379382; x=1723984182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uKA9BygWuK8ucs9YyTkqi0uoRhd5AMeZwOpaTtqeS3A=;
 b=MBdtKuxlnMaYIUGjTfygZXjww5J2XFfHJJqDkofo9d8z9hwp3/CdulqJWtaY2DrrLE
 rYKRJqNQifvCKJxiJerRXdF8YG+xHpwdWLS4CGmcNuZL/xgwx/WRoX3T+npVu6dAzwNC
 tpbxxpZWgCU0aFORE1bYbidCOkzW2EJcSSLyHA/JlsB2O+ixqX5AfDFH6c/oWc34kfpI
 YPL/dWmoDYxjHOu3YIgMYwBatLt/ymzbxtTkOi71Ogdgp0WpaVx3QWVhuNLv9P9NYRdK
 FXsdUifA/VCW2KYSU3T5m1nEU2I+eu1HKm0WMdcXUBlbDlXMn444ZN2bnjK/1eQxwpXK
 6Qsg==
X-Gm-Message-State: AOJu0YwpRxDtHXX34OM46zwXmG78gyothNTvd6V+DhLt3ZP6VoEqPwTK
 sdCAfYrsQy62zutVg10GBKNkXGM6Pj848IkgtaqkFjXXYuZj5NhPT5IFJXAL2ZMFhu8Nt8r1qoA
 =
X-Google-Smtp-Source: AGHT+IGfu7vd54KPaISbmjZOICf8smlCfa3NWRg30gAOLnns042JTkqXe0Q0UolHhp9upQXWi1b9Ig==
X-Received: by 2002:a05:6602:3f90:b0:7eb:7f2e:5b3a with SMTP id
 ca18e2360f4ac-8225ece249dmr829364039f.2.1723379382523; 
 Sun, 11 Aug 2024 05:29:42 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ca76940448sm1017935173.45.2024.08.11.05.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 05:29:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v3 11/15] spl: mmc: Adjust args of spl_mmc_find_device()
Date: Sun, 11 Aug 2024 06:29:20 -0600
Message-Id: <20240811122924.4035982-12-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811122924.4035982-1-sjg@chromium.org>
References: <20240811122924.4035982-1-sjg@chromium.org>
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

