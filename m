Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3951CC3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 06:22:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03F3B88C6D;
	Sat, 20 Jul 2024 08:20:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ov1odNZJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AC6988C5D; Sat, 20 Jul 2024 08:20:54 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5D2C88C4E
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 08:20:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-367963ea053so1405555f8f.2
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 23:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721456451; x=1722061251; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2QhLZbLlT8i94O8/BuZps2G9lEyRaHUJPx2qUxp+M0s=;
 b=Ov1odNZJPBuG4hezIBGgG6VplJJVRTviy+6aLywwsmUoXpc33Vpm4pG1LCvIkg2yzr
 K0jJG8e4+jZ6S3unXULoccBVQIyzGzuNaueaQHs0LmA68m/lfLWKPHY1g873ymvYn9N+
 oLIXIQ0jX/6/o5dySbJWq41bd4tK0SzQyHY90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721456451; x=1722061251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2QhLZbLlT8i94O8/BuZps2G9lEyRaHUJPx2qUxp+M0s=;
 b=Vy3SxEBSbA9RRrhX8iyv0cMT1CpScN8dQfbIhQTyqYgEEuD8nWh3RX6ydVPsShpswV
 FDXexeEHJpIxWYUgxv/vV8IjIgSfbphAaqtGbWd193BtEGsO5HkZEM2BBzdkd3E4ylTK
 3wxGQeYKTSZNn89Dh/By9YqxwSooxjQ4HEupLAv6Hy63SeEkruv8uuRaBAelWziBbxI+
 KcmA3nikGjy0WiAJZzLeFRwR2R8NmZv7XZPzEPH1iGxHmAkNMU2AGo2g2wLX6LZxLuLC
 eG6yyMpT2fAwrfm1Up5iLHvLqxJcW7tbKsCXKx+F2sOxj1cpf1SWI1C/sX4lCjcL7gI4
 um0g==
X-Gm-Message-State: AOJu0YyXFhyGCbtJd9+3kvj4HeQ2El6YZvlLlqU1JHfXZPCIemyMjSwS
 VCm/Z+h6jMOirBjSrulAN21sWjWHoll28JL67Px9lD+MXdEZMwQm4zWGg8IyE/+GvhfdttsZnCk
 =
X-Google-Smtp-Source: AGHT+IHNmCRW0oZC8PUH/89QvFHbEHmFcKpG3x2HwCIPYjOpH+93+JuOLfIdDuyByP4+njBmc+HiNg==
X-Received: by 2002:a5d:4005:0:b0:367:9c46:198 with SMTP id
 ffacd0b85a97d-369bae3a8b6mr466741f8f.1.1721456451106; 
 Fri, 19 Jul 2024 23:20:51 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684773sm3226281f8f.7.2024.07.19.23.20.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 23:20:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/14] spl: mmc: Adjust args of spl_mmc_find_device()
Date: Sat, 20 Jul 2024 07:17:02 +0100
Message-Id: <20240720061706.2644229-11-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240720061706.2644229-1-sjg@chromium.org>
References: <20240720061706.2644229-1-sjg@chromium.org>
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
---

 common/spl/spl_mmc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index 70e376c0ed8..3cb4b698f7f 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -58,7 +58,7 @@ int mmc_load_image_raw_sector(struct spl_image_info *spl_image,
 	return 0;
 }
 
-static int spl_mmc_get_device_index(u32 boot_device)
+static int spl_mmc_get_device_index(int boot_device)
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

