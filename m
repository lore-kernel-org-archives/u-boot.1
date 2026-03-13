Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1259105F796
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 10:43:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FA90842DB;
	Fri, 13 Mar 2026 11:42:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="w2jgyQXY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2546842DF; Fri, 13 Mar 2026 11:42:50 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E9138427F
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 11:42:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id AF7924E4267A;
 Fri, 13 Mar 2026 10:42:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 85EE160027;
 Fri, 13 Mar 2026 10:42:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2C9C210369E9A; Fri, 13 Mar 2026 11:42:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1773398567; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=TzJC9kt8j/OmDG84trIxZyHISxsw7grMnJdyBGtfAHk=;
 b=w2jgyQXYAdIuxcbq7pv55OQ83EOIAnJLKfgzejhUxCtTSoi8Bz4bYYQeteA34QEtnkfYM7
 Su4EL+S560hljZ9XXoHwihz0LSI6XVzUf3Mwagj8D1wbLmAFRco94DNAfXNE9jNFPmK9cW
 GvKE1xI02S7PqUKAk/jDL5mXp5atbw57d8qAmGXhRbnfK91w+dUoXFapspWddPxeKF4o9O
 SZSZRJr2r9ijrmG6IDkmBSf2YnQDAuw2c9/ufWHYOZ+WDAVOvomyvQ1kWq2zqLkvnvMIY2
 Yw3Q/GtgSl9BWiNgPnuB2YXQxJeqkGteB4D0IirQsN0H4rVVDEJyDJV9cmP4CA==
From: Richard Genoud <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Joao Marcos Costa <joaomarcos.costa@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, u-boot@lists.denx.de,
 Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH 5/7] spl: mmc: support squashfs
Date: Fri, 13 Mar 2026 11:42:27 +0100
Message-ID: <20260313104229.1555236-6-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260313104229.1555236-1-richard.genoud@bootlin.com>
References: <20260313104229.1555236-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

spl_mmc_do_fs_boot supports now loading an image from squashfs.

Also, convert #if defined(CONFIG_SPL_xx) to if (CONFIG_IS_ENABLED(xx))

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 common/spl/spl_mmc.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index 47cfe4aef58f..cc16709dc9b1 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -226,6 +226,11 @@ static int __maybe_unused spl_mmc_fs_load(struct spl_image_info *spl_image,
 		if (!err)
 			return 0;
 	}
+	if (CONFIG_IS_ENABLED(FS_SQUASHFS)) {
+		err = spl_load_image_sqfs(spl_image, bootdev, blk_dev, part, file);
+		if (!err)
+			return 0;
+	}
 
 	return err;
 }
@@ -284,13 +289,15 @@ static int spl_mmc_do_fs_boot(struct spl_image_info *spl_image,
 
 u32 __weak spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
 {
-#if defined(CONFIG_SPL_FS_FAT) || defined(CONFIG_SPL_FS_EXT4)
-	return MMCSD_MODE_FS;
-#elif defined(CONFIG_SUPPORT_EMMC_BOOT)
-	return MMCSD_MODE_EMMCBOOT;
-#else
+	if (CONFIG_IS_ENABLED(FS_FAT) ||
+	    CONFIG_IS_ENABLED(FS_EXT4) ||
+	    CONFIG_IS_ENABLED(FS_SQUASHFS))
+		return MMCSD_MODE_FS;
+
+	if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT))
+		return MMCSD_MODE_EMMCBOOT;
+
 	return MMCSD_MODE_RAW;
-#endif
 }
 
 #ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
