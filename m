Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE90C3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 12:31:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AA3C88850;
	Sun, 11 Aug 2024 14:29:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N1oHUzGX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D63B8886A; Sun, 11 Aug 2024 14:29:44 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C79188747
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 14:29:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-81f86fd93acso128506739f.1
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 05:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723379381; x=1723984181; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TS/OF+aGwZ3xBCKyYTT3R7JoRKZpSc/bx+PhtwUMtmc=;
 b=N1oHUzGXNPonmqfuqRJ7pXGLfQpKmxEHzD3wBlYGWQm3gOfhCQw8J4QwFM7Jz4NV52
 gtrHXXKDxCuNcDGDlVnDIlQFNAVUen+Nk2K9670cNwO035jhZS+bgQrb1Y7pI/tQnNPm
 0urtPDz+6t4OnYF2RC8BSKMTyxeek6q1wWN3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723379381; x=1723984181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TS/OF+aGwZ3xBCKyYTT3R7JoRKZpSc/bx+PhtwUMtmc=;
 b=DwmRZ8UNEiLvOxLhMGNyqmwAfBAo17NqNxv/ZMQMVlyHHFmvs1Z247nEjtWsk4sexJ
 FsXf9agGk0jBQyDUIGdmoawf5cpKBAtyhbrT5Ufp+G1XRCrOavGi2BrJviaUkSuWcppB
 j94JdMRifBMs7NNCFXfSemqtVbfqjYxxpCqtSCKqaPlvpCo7t28T6/c7rwj4doe/DIlb
 rcuhJoDGo/S57vkD9Gew89MID04wGAqgA5QGMKWa2k82gtzHvQlrzgMnVJVzAvR1EjJy
 BgfmxK/NC5F1PA5U98oObsCojCpO2wxcpLfnJS5rmkQ1uqkhBC53u+hWH6AuNAAHnCty
 I6cw==
X-Gm-Message-State: AOJu0Yxs0XXA+L3k1JzEwFqmYFbp1zNf6gBjVPj1g73EYg/0Pvzr6JB4
 o/R3jDk+pDnc/WrQXpSB6Cv85jzGp5oDrE5kCNozQ/E5DH0vub9se8Wjl5pLZ1HkQXTQIiokMU0
 =
X-Google-Smtp-Source: AGHT+IH/0eiMQLy11ZiH6pQbJ2L28EOgnEAw7XBa+aYTqCD4xyA1JG1uzkf5rSIkLh/PK26SmijU7g==
X-Received: by 2002:a5e:8d14:0:b0:81f:8665:da0a with SMTP id
 ca18e2360f4ac-822546388acmr1111785339f.1.1723379381043; 
 Sun, 11 Aug 2024 05:29:41 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ca76940448sm1017935173.45.2024.08.11.05.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 05:29:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v3 09/15] spl: mmc: Drop checks for
 CONFIG_SPL_LIBCOMMON_SUPPORT
Date: Sun, 11 Aug 2024 06:29:18 -0600
Message-Id: <20240811122924.4035982-10-sjg@chromium.org>
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

This check is not needed now, since printf() resolved to nothing if not
available. Drop the #ifdefs

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Sean Anderson <seanga2@gmail.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
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

