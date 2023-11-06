Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E21C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 03:00:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADE6C8711B;
	Mon,  6 Nov 2023 03:37:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JQvV00r/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1239E86FA5; Mon,  6 Nov 2023 03:28:40 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EFD187005
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 03:26:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-41cb76f3cf0so25893471cf.2
 for <u-boot@lists.denx.de>; Sun, 05 Nov 2023 18:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699237585; x=1699842385; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jPV4Kn1XuXE4HLTvSmNG4v5+OfJcnqNbnSzhctivj1w=;
 b=JQvV00r/zMCMVCXqy/fQfWyxMH8iP8nrXHOVVeD7Efh2d4mNr3ldotgworYGt67nou
 dzPO7yporbMkSpcNFA6GzZIJmGoCeyuIovE+fns2yD/lp47vJu+aiG6Oc31/d5vPsdKl
 +G3VWuHWYdPljzSqLwdLvcDhbcRHnbqK66mJ8QcDx2h+ky2UjnOjFCJkRAF2z2+wXQ7U
 B+y1T1WiK0PdCZOGX2MSM3dvD3JFOYmVWT1EEtxJIKlR04bYPiE4tVfY7cEIyUr++XMU
 eDi6fnrgqI6o4keummqPaynsf7VPs8bDVBcymmLD+J7m1iK2nUCPSaLD2cVbiNtIKjA/
 sFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699237585; x=1699842385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jPV4Kn1XuXE4HLTvSmNG4v5+OfJcnqNbnSzhctivj1w=;
 b=ROK6gfKEtxfSRfJQlElX4pEdDTF8bWxfWYpbvRdQUWfK0zEJYCqnVB9Gh13hwdvTPK
 8X31FzbsRHDM9r+tRhsI55s8c2l9CGaP1d6K+f2EYf7M2ZC1pHqpASGbvoATZHOEd7Yl
 NYd1K5fqeWJ0sSAcEWcWskvzNSppXcBJrrYa401kvTXuafxKSzEUGMbw/9qxELRoffLq
 97SXuzgg6WyQ4BKHVMt7pDXv93XMw0gAmEOmKxR30707rbZEJz1zdSNJf4lXOpArk/XA
 nS5c/ZUybPmLSLoQCTlUP40M67VmBvkerLS102YEVe1NYktOHra+bba+xwVs5TzPHL/i
 /xfQ==
X-Gm-Message-State: AOJu0YxDQ+ZYBdj+fJuy+xGUn+Z8uI8SsC+WiifxgN7ilM+xgii7cwAW
 /fdlIirgA9OCgkZ83f+UNeeZ+Bm6Efbp9w==
X-Google-Smtp-Source: AGHT+IEVt5wgCRB+SX8nHkwop1VNKbz4PEBq/APo1kVaeIykxD5HjqhXR7cUE5n110FG3bXMkECAsQ==
X-Received: by 2002:ac8:7d0d:0:b0:41c:d8b6:27ef with SMTP id
 g13-20020ac87d0d000000b0041cd8b627efmr32481315qtb.65.1699237584975; 
 Sun, 05 Nov 2023 18:26:24 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 t25-20020ac87619000000b004199f47ccdbsm2997736qtq.51.2023.11.05.18.26.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Nov 2023 18:26:24 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v6 16/25] spl: Convert fat to spl_load
Date: Sun,  5 Nov 2023 21:25:54 -0500
Message-Id: <20231106022603.3405551-17-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231106022603.3405551-1-seanga2@gmail.com>
References: <20231106022603.3405551-1-seanga2@gmail.com>
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

