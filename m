Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7AFC52D7C
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 13:57:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 524D988A99;
	Thu, 22 Aug 2024 15:55:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LWdpLZmJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BFF688995; Thu, 22 Aug 2024 15:55:37 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA9F7889A7
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 15:55:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-39d2256ee95so3790625ab.2
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 06:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724334933; x=1724939733; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TS/OF+aGwZ3xBCKyYTT3R7JoRKZpSc/bx+PhtwUMtmc=;
 b=LWdpLZmJ8dPeeq8prlqWnaDuBn5sJigDq54RruO/knLJOwYBPbs0PFjxzOFb1/QUo+
 c/No5EnA0F850k6jA2mh5b5EZcWx9wniP4mGBod1p4NMrX/2yEISsGTfH2JM3biQxMHE
 Rt3WxV0ukJxP9kcX0fasIpxmIboIKQSkjUu4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724334933; x=1724939733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TS/OF+aGwZ3xBCKyYTT3R7JoRKZpSc/bx+PhtwUMtmc=;
 b=GrTpraSCHV0vHvCn0F2PrjVlwKFj69BWC6Y97thisJ8aUc1qzvlp6k6ic2y8g4iaE2
 1ZRs8t7ZX8it8HEOpigGyQoZ6LVff0axG1QO2cKeAx0Sb1suCmKrGWjJlGDWWbchcI34
 VN9+XEuFfJmMoON0lM+MFNqsmq7X9cDekfYl3ZhDq1qAaFnZ48u1hd668GZhiSTuyvGY
 1MulkRyF2DewEDhYE/ZPa/kSIko/D59fhJE7kgvZTx40hLOAAUNLMJa+76gyh+aAfHhP
 sxSfgkW3H2MW0nvVKBrfMgoF4+3cWlPVl8oxNuBWZDJJ2Vz21tL6Jdt8ip5JoXkOItG1
 64Tg==
X-Gm-Message-State: AOJu0Yw5Yb4VZKvlZemt1FgMOPxHYpxIjCBng0tlzvcJK7kB7UWssxsb
 FNDtSg36fTAIi96N7wVRAUBGgTTPKeFqxET1WGCZ/WG3h9wnnNBp3wCm8bDnEbjeHjPi7xzfrg4
 =
X-Google-Smtp-Source: AGHT+IHZQO9KyQlWuFDc5ZcNH/rnGBPcmwCAogyCqhqf0iYeMlinAmwCyx+VWFT/walSCGslgfIuJA==
X-Received: by 2002:a05:6e02:b23:b0:374:aa87:bcaa with SMTP id
 e9e14a558f8ab-39d6c38328cmr63892445ab.14.1724334933552; 
 Thu, 22 Aug 2024 06:55:33 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e7c1eesm6692585ab.39.2024.08.22.06.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 06:55:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v4 08/14] spl: mmc: Drop checks for
 CONFIG_SPL_LIBCOMMON_SUPPORT
Date: Thu, 22 Aug 2024 07:54:57 -0600
Message-Id: <20240822135503.2363706-9-sjg@chromium.org>
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

