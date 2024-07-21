Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A17BBC3DA5D
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 15:27:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A58988210;
	Sun, 21 Jul 2024 17:26:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B77/zqvH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C74AF88189; Sun, 21 Jul 2024 17:26:45 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D31C087E64
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 17:26:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3687fd09251so1271481f8f.0
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 08:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721575603; x=1722180403; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YRZ8nonzOu2KF7dqERVylyOKwqsgAlJtcVzRCaVVML8=;
 b=B77/zqvHa+y+r6sGEvGYDuWYccLJQ0XQkZdjIegEdLmapz4mYqQpARz3/El2SdB9B1
 vm909NIVKb1YgMCV11aMM37af5HFPbtBVpCDoIxdBONjlpmUMZTbk25ahA3tc3h8++cc
 ZNRQjfhQuLhRJwjFccuC522oOiiDcnvbArfSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721575603; x=1722180403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YRZ8nonzOu2KF7dqERVylyOKwqsgAlJtcVzRCaVVML8=;
 b=uAeeFmC8DCbVcHiO3Xs+4jcb59ttDtrIuTKCwco52LkXuFul0vPqlEvIeUBuuNK9dd
 aacUU4xU79SpPPEv5i6DjYDvOVjNjDtzK3TQ+3lEJJowfxi0ujoMgE2Se1P1iPFrF+yb
 NLzJp6kVU5MpTD6GV7n2blXeBPM6amSJKtPD/6iUxKPLlv8kKe5Xb6996yETSLGI9ckg
 koROlvH5ZU9gr3g6ReVvnJk0kvwoYOx660b/BEI5A4bX/havtaUn14nGHVji1Sf7lcFN
 ZCchuFHfd5WkuICFOheyUbyckcwHRKxYoHXiLre+NO2RdMEkMqjUx9cGWnKpKn/fxnAQ
 LJLw==
X-Gm-Message-State: AOJu0Yw+8Q9sIBrJfzLp3y87TfJM14W+Vu3RdJmUyhZjBkpF8vHY4Jed
 5hX19cxR/ubdMYU2MS/GQddcclpKwVjg69JbX+pWb8cklZ6PaCozqSr6W6J6nqUlROEAMzoepkw
 =
X-Google-Smtp-Source: AGHT+IGnwKhy02J5xX+CtBRUORYjRxmWHV6tt/LxPnystUTD45ZWz4Z3YK8oE4Ewr/TWqnQtAaehRg==
X-Received: by 2002:a05:6000:4026:b0:368:5d2:9e58 with SMTP id
 ffacd0b85a97d-369bad7d500mr2805949f8f.0.1721575603177; 
 Sun, 21 Jul 2024 08:26:43 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427e5803bb0sm8702255e9.45.2024.07.21.08.26.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 08:26:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 08/14] spl: mmc: Drop checks for
 CONFIG_SPL_LIBCOMMON_SUPPORT
Date: Sun, 21 Jul 2024 16:25:53 +0100
Message-Id: <20240721152600.3212917-9-sjg@chromium.org>
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

This check is not needed now, since printf() resolved to nothing if not
available. Drop the #ifdefs

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Sean Anderson <seanga2@gmail.com>
---

(no changes since v1)

 common/spl/spl_mmc.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index ccab0be4be2..ddc85aaeda7 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -51,9 +51,7 @@ int mmc_load_image_raw_sector(struct spl_image_info *spl_image,
 	load.read = h_spl_load_read;
 	ret = spl_load(spl_image, bootdev, &load, 0, sector << bd->log2blksz);
 	if (ret) {
-#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
 		puts("mmc_load_image_raw_sector: mmc block read error\n");
-#endif
 		return -1;
 	}
 
@@ -70,9 +68,7 @@ static int spl_mmc_get_device_index(u32 boot_device)
 		return 1;
 	}
 
-#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
 	printf("spl: unsupported mmc boot device.\n");
-#endif
 
 	return -ENODEV;
 }
@@ -91,18 +87,14 @@ static int spl_mmc_find_device(struct mmc **mmcp, u32 boot_device)
 	err = mmc_initialize(NULL);
 #endif /* DM_MMC */
 	if (err) {
-#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
 		printf("spl: could not initialize mmc. error: %d\n", err);
-#endif
 		return err;
 	}
 	*mmcp = find_mmc_device(mmc_dev);
 	err = *mmcp ? 0 : -ENODEV;
 	if (err) {
-#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
 		printf("spl: could not find mmc device %d. error: %d\n",
 		       mmc_dev, err);
-#endif
 		return err;
 	}
 
@@ -135,10 +127,8 @@ static int mmc_load_image_raw_partition(struct spl_image_info *spl_image,
 
 	err = part_get_info(mmc_get_blk_desc(mmc), partition, &info);
 	if (err) {
-#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
 		puts("spl: partition error\n");
-#endif
-		return -1;
+		return -err;
 	}
 
 #ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
@@ -164,9 +154,7 @@ static int mmc_load_image_raw_os(struct spl_image_info *spl_image,
 		CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTORS,
 		(void *)CONFIG_SPL_PAYLOAD_ARGS_ADDR);
 	if (count != CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTORS) {
-#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
 		puts("mmc_load_image_raw_os: mmc block read error\n");
-#endif
 		return -1;
 	}
 #endif	/* CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTOR */
@@ -368,9 +356,7 @@ int spl_mmc_load(struct spl_image_info *spl_image,
 		err = mmc_init(mmc);
 		if (err) {
 			mmc = NULL;
-#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
 			printf("spl: mmc init failed with error: %d\n", err);
-#endif
 			return err;
 		}
 	}
@@ -387,9 +373,7 @@ int spl_mmc_load(struct spl_image_info *spl_image,
 			err = blk_dselect_hwpart(mmc_get_blk_desc(mmc), part);
 
 		if (err) {
-#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
 			puts("spl: mmc partition switch failed\n");
-#endif
 			return err;
 		}
 		/* Fall through */
@@ -428,10 +412,8 @@ int spl_mmc_load(struct spl_image_info *spl_image,
 
 		break;
 #endif
-#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
 	default:
 		puts("spl: mmc: wrong boot mode\n");
-#endif
 	}
 
 	return err;
-- 
2.34.1

