Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E774C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 16:52:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70DA38774D;
	Wed,  8 Nov 2023 17:49:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QXKa7nJj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 129C1874D5; Wed,  8 Nov 2023 17:49:38 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF76D8772A
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 17:49:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6707401e1edso43471066d6.1
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 08:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699462163; x=1700066963; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e1P4FVB5CvJVhW1BQiEyhoJmMznB3qckZWf8YgYQH0o=;
 b=QXKa7nJjsmHci7kmSiOvdlv60yTmi92m9z+dzhe1NcLfNTf9gzHgjiGi8Nx+XFlsg+
 yRLqiNf6F5vbsEg0TDTJr32goAO2bsDXnJ3Wb9iiKIjY3OwOBZ/Lv4Pg1a0atogVK9ag
 xMVw9sYkNU5gE3ixv+Vx5VH5+xd/IEa//SaaxG8X3gkNijSabHJndk2WD+d03y/9KiLC
 tIN5TnKeL7WmLR8nnnRBN8edIuTKlceuKc4nwAfwjkTXZ3aGmK1FeVAQnWMNqStvv647
 E1XxfXx9sRYxJhtjDZw1fWrolDwfECuT15X3iqqLLGiww+BrHHMWQJXPlWok8Rrzz7Zi
 25sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699462163; x=1700066963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e1P4FVB5CvJVhW1BQiEyhoJmMznB3qckZWf8YgYQH0o=;
 b=eS4ES8jR5tE3nOTw1ywj39hu+Mw2NOWpwd4EXhtIN+41tz8X9G3LlreOBevM16W3Y4
 Wecx76QRrokEJv7cQAxYWke1G9c9W+zeefUKkKM5Qcv0s5oODipaC0YFX+aKuJHhYlGI
 CzRyiBEHktXeeGe4XQ2zJXKMrYyx/t0BkSQQi7Ny7gCLKCVeAPUZjnCy9VO79J07+nN2
 I3+UMRiO4idET8cQ61F/jHpzkajJzsVV1dnh203OePUFMb5oe/nh5II/bU9HKEQx3gNS
 asILmNoathiYfWGDc6PkvghW8N3T+MMSuIeQrnxPVX366JDaPtrDJIBh2VuRYNLDfaoc
 E1xQ==
X-Gm-Message-State: AOJu0YzgC/sHX/dzgz11wRVweE0d+KUTOYz5SoX8+qFKPj7D0OYWJcvi
 NeQZrPnJ7Q+WzJDJo1EWG1w=
X-Google-Smtp-Source: AGHT+IFSvKAgZHQOfkSAOXnTZYD6Oa7DeBCp7dYwXXQpC0+Q7UrNRGK5ZEEH0KjHJcAtCriLqQT9Ew==
X-Received: by 2002:ad4:4eee:0:b0:66d:14ca:4bcb with SMTP id
 dv14-20020ad44eee000000b0066d14ca4bcbmr3129734qvb.62.1699462163149; 
 Wed, 08 Nov 2023 08:49:23 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 cv4-20020ad44d84000000b0066d15724feesm1244869qvb.68.2023.11.08.08.49.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 08:49:22 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>, Marek Vasut <marex@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v7 17/26] spl: Convert fat to spl_load
Date: Wed,  8 Nov 2023 11:48:49 -0500
Message-Id: <20231108164858.3497420-18-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231108164858.3497420-1-seanga2@gmail.com>
References: <20231108164858.3497420-1-seanga2@gmail.com>
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

This converts the fat loader to use spl_load. Some platforms are very
tight on space, so we take care to only include the code we really need.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v5)

Changes in v5:
- Rework to load header in spl_load

Changes in v3:
- Fix failing on success

 common/spl/spl_fat.c     | 56 +++++++++++++---------------------------
 include/spl_load.h       |  1 +
 test/image/spl_load_fs.c |  3 +--
 3 files changed, 20 insertions(+), 40 deletions(-)

diff --git a/common/spl/spl_fat.c b/common/spl/spl_fat.c
index a0c34eba48f..569f2b32928 100644
--- a/common/spl/spl_fat.c
+++ b/common/spl/spl_fat.c
@@ -11,8 +11,8 @@
 #include <common.h>
 #include <env.h>
 #include <log.h>
-#include <mapmem.h>
 #include <spl.h>
+#include <spl_load.h>
 #include <asm/u-boot.h>
 #include <fat.h>
 #include <errno.h>
@@ -66,58 +66,38 @@ int spl_load_image_fat(struct spl_image_info *spl_image,
 		       const char *filename)
 {
 	int err;
-	struct legacy_img_hdr *header;
+	loff_t size;
+	struct spl_load_info load;
 
 	err = spl_register_fat_device(block_dev, partition);
 	if (err)
 		goto end;
 
-	header = spl_get_load_buffer(-sizeof(*header), sizeof(*header));
-
-	err = file_fat_read(filename, header, sizeof(struct legacy_img_hdr));
-	if (err <= 0)
-		goto end;
-
-	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT_FULL) &&
-	    image_get_magic(header) == FDT_MAGIC) {
-		err = file_fat_read(filename,
-				    map_sysmem(CONFIG_SYS_LOAD_ADDR, 0), 0);
-		if (err <= 0)
-			goto end;
-		err = spl_parse_image_header(spl_image, bootdev,
-					     map_sysmem(CONFIG_SYS_LOAD_ADDR,
-							err));
-		if (err == -EAGAIN)
-			return err;
-		if (err == 0)
-			err = 1;
-	} else if (IS_ENABLED(CONFIG_SPL_LOAD_FIT) &&
-	    image_get_magic(header) == FDT_MAGIC) {
-		struct spl_load_info load;
-
-		debug("Found FIT\n");
-		load.read = spl_fit_read;
-		spl_set_bl_len(&load, ARCH_DMA_MINALIGN);
-		load.priv = (void *)filename;
-
-		return spl_load_simple_fit(spl_image, &load, 0, header);
-	} else {
-		err = spl_parse_image_header(spl_image, bootdev, header);
+	/*
+	 * Avoid pulling in this function for other image types since we are
+	 * very short on space on some boards.
+	 */
+	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT_FULL)) {
+		err = fat_size(filename, &size);
 		if (err)
 			goto end;
-
-		err = file_fat_read(filename, map_sysmem(spl_image->load_addr,
-							 spl_image->size), 0);
+	} else {
+		size = 0;
 	}
 
+	load.read = spl_fit_read;
+	spl_set_bl_len(&load, ARCH_DMA_MINALIGN);
+	load.priv = (void *)filename;
+	err = spl_load(spl_image, bootdev, &load, size, 0);
+
 end:
 #ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
-	if (err <= 0)
+	if (err < 0)
 		printf("%s: error reading image %s, err - %d\n",
 		       __func__, filename, err);
 #endif
 
-	return (err <= 0);
+	return err;
 }
 
 #if CONFIG_IS_ENABLED(OS_BOOT)
diff --git a/include/spl_load.h b/include/spl_load.h
index 65aa6bb4493..5e0460d956d 100644
--- a/include/spl_load.h
+++ b/include/spl_load.h
@@ -96,6 +96,7 @@ static inline int _spl_load(struct spl_image_info *spl_image,
  */
 #define SPL_LOAD_USERS \
 	IS_ENABLED(CONFIG_SPL_FS_EXT4) + \
+	IS_ENABLED(CONFIG_SPL_FS_FAT) + \
 	0
 
 #if SPL_LOAD_USERS > 1
diff --git a/test/image/spl_load_fs.c b/test/image/spl_load_fs.c
index 01559e98c4f..333df2dfb53 100644
--- a/test/image/spl_load_fs.c
+++ b/test/image/spl_load_fs.c
@@ -425,8 +425,7 @@ static int spl_test_mmc(struct unit_test_state *uts, const char *test_name,
 	if (spl_test_mmc_fs(uts, test_name, type, create_ext2, false))
 		return CMD_RET_FAILURE;
 
-	if (type != IMX8 && type != LEGACY_LZMA &&
-	    spl_test_mmc_fs(uts, test_name, type, create_fat, false))
+	if (spl_test_mmc_fs(uts, test_name, type, create_fat, false))
 		return CMD_RET_FAILURE;
 
 	if (type == LEGACY_LZMA)
-- 
2.37.1

