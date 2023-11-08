Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D492CC4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 16:53:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AB1687761;
	Wed,  8 Nov 2023 17:49:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k5Xu91yy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 603F58771C; Wed,  8 Nov 2023 17:49:42 +0100 (CET)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18C6F8774E
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 17:49:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-d9fe0a598d8so7080894276.2
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 08:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699462169; x=1700066969; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kAwW6mxBnQ4ZlCX5clPm7R/vvbYnTwepI6dZufRl0Ys=;
 b=k5Xu91yyRL2KZeAC28P43UW+8FT9XiHF/TKz12Xc3DOyLb+fWya3MwC4IgULpJeGC/
 PpsCjbXo+iPsYCB5GzY+wWOtq+Di3XrJ6SDPCxuGalvwn8AVamhAOVZtyQCm9n2EQx1B
 MiE8LAFS4yw3Hob/iIobfrsULLcHVzUWiPYb7wm1HMDLzxDor7AoEm8Qka/G7iBT5R95
 hHBmzpyMJ7J8Z08D5w9iYAB5L1BonQr93+O+ajCuR8tN5j576RmYG/J8zKKGmZRmYrmn
 NyNId+n9Jx6/bZld3WMQ65+kPAPZtB/Dm9x2YFyDasm8kX974AZHCq4r7LEIRX77S/Y7
 49YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699462169; x=1700066969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kAwW6mxBnQ4ZlCX5clPm7R/vvbYnTwepI6dZufRl0Ys=;
 b=LYKvn617tbIRQuGBvIuOK70pYf0ErMcSIBrdK1KH5JTc0ByNZYqOaNxd45c9TU/1qp
 4/Gb3Y4Fh5+4t2nkSUwJn76UWQHfAmsL52N2Zvk8UR3xQ9ufHwivZZbgqj7h1U9M5PKl
 bXYpi11QamDq3t7/8Wo0GZc+PEV5nGph7X13Tk5aCU2gmFUjoCFuTjELKdRNcAN55750
 cExbLwZhKZ8wXdqy6ZuJNLadhI/gu+PjXvUkgxC/4Z9yBYDUomio0YcU2AF+nfNay9zi
 OfImJVIMtHaeDtbBOhxR1wb+cnyWLbU+wgwJPPLnU5BUfSrWlg3XIqmadrlTeZ3uje8H
 7gzA==
X-Gm-Message-State: AOJu0YyaD+U9bLNO3W+JOlLQOxJ5hpvmQnxWvlw1Hi1gToVie6xRclbB
 JwghqVFqCkRfLT/jeObs6txv+840oZM=
X-Google-Smtp-Source: AGHT+IEdZGGRh5E+oQkWSXjCreR6GzY/fcCKlzz3F1f36zUDytxmOfcwv1/pCGZLYhgZ/1JMAwTQrQ==
X-Received: by 2002:a25:29c4:0:b0:d81:504f:f879 with SMTP id
 p187-20020a2529c4000000b00d81504ff879mr2015326ybp.28.1699462169122; 
 Wed, 08 Nov 2023 08:49:29 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 px9-20020a056214050900b0065b08bb01afsm1233888qvb.124.2023.11.08.08.49.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 08:49:28 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>, Marek Vasut <marex@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: [PATCH v7 22/26] spl: Convert NVMe to spl_load
Date: Wed,  8 Nov 2023 11:48:54 -0500
Message-Id: <20231108164858.3497420-23-seanga2@gmail.com>
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

This converts the blk load method (used exclusively by NVMe) to use
spl_load. As a consequence, it also adds support for LOAD_FIT_FULL and
IMX images.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v6)

Changes in v6:
- Fix invalid return from spl_blk_load_image
- Explicitly initialize load_info members

Changes in v5:
- New

 common/spl/spl_blk_fs.c  | 66 +++++++---------------------------------
 include/spl_load.h       |  1 +
 test/image/spl_load_fs.c |  2 ++
 3 files changed, 14 insertions(+), 55 deletions(-)

diff --git a/common/spl/spl_blk_fs.c b/common/spl/spl_blk_fs.c
index 53b8e1b11b4..ac267ab979b 100644
--- a/common/spl/spl_blk_fs.c
+++ b/common/spl/spl_blk_fs.c
@@ -7,6 +7,7 @@
 
 #include <common.h>
 #include <spl.h>
+#include <spl_load.h>
 #include <image.h>
 #include <fs.h>
 #include <asm/cache.h>
@@ -48,11 +49,11 @@ int spl_blk_load_image(struct spl_image_info *spl_image,
 		       enum uclass_id uclass_id, int devnum, int partnum)
 {
 	const char *filename = CONFIG_SPL_FS_LOAD_PAYLOAD_NAME;
-	struct legacy_img_hdr *header;
 	struct blk_desc *blk_desc;
-	loff_t actlen, filesize;
+	loff_t filesize;
 	struct blk_dev dev;
-	int ret = -ENODEV;
+	struct spl_load_info load;
+	int ret;
 
 	blk_desc = blk_get_devnum_by_uclass_id(uclass_id, devnum);
 	if (!blk_desc) {
@@ -61,8 +62,8 @@ int spl_blk_load_image(struct spl_image_info *spl_image,
 	}
 
 	blk_show_device(uclass_id, devnum);
-	header = spl_get_load_buffer(-sizeof(*header), sizeof(*header));
 
+	dev.filename = filename;
 	dev.ifname = blk_get_uclass_name(uclass_id);
 	snprintf(dev.dev_part_str, sizeof(dev.dev_part_str) - 1, "%x:%x",
 		 devnum, partnum);
@@ -70,63 +71,18 @@ int spl_blk_load_image(struct spl_image_info *spl_image,
 	if (ret) {
 		printf("spl: unable to set blk_dev %s %s. Err - %d\n",
 		       dev.ifname, dev.dev_part_str, ret);
-		goto out;
-	}
-
-	ret = fs_read(filename, virt_to_phys(header), 0,
-		      sizeof(struct legacy_img_hdr), &actlen);
-	if (ret) {
-		printf("spl: unable to read file %s. Err - %d\n", filename,
-		       ret);
-		goto out;
-	}
-
-	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT) &&
-	    image_get_magic(header) == FDT_MAGIC) {
-		struct spl_load_info load;
-
-		debug("Found FIT\n");
-		load.read = spl_fit_read;
-		spl_set_bl_len(&load, ARCH_DMA_MINALIGN);
-		load.priv = &dev;
-		dev.filename = filename;
-
-		return spl_load_simple_fit(spl_image, &load, 0, header);
-	}
-
-	ret = spl_parse_image_header(spl_image, bootdev, header);
-	if (ret) {
-		printf("spl: unable to parse image header. Err - %d\n",
-		       ret);
-		goto out;
-	}
-
-	ret = fs_set_blk_dev(dev.ifname, dev.dev_part_str, FS_TYPE_ANY);
-	if (ret) {
-		printf("spl: unable to set blk_dev %s %s. Err - %d\n",
-		       dev.ifname, dev.dev_part_str, ret);
-		goto out;
+		return ret;
 	}
 
 	ret = fs_size(filename, &filesize);
 	if (ret) {
 		printf("spl: unable to get file size: %s. Err - %d\n",
 		       filename, ret);
-		goto out;
+		return ret;
 	}
 
-	ret = fs_set_blk_dev(dev.ifname, dev.dev_part_str, FS_TYPE_ANY);
-	if (ret) {
-		printf("spl: unable to set blk_dev %s %s. Err - %d\n",
-		       dev.ifname, dev.dev_part_str, ret);
-		goto out;
-	}
-
-	ret = fs_read(filename, (ulong)spl_image->load_addr, 0, filesize,
-		      &actlen);
-	if (ret)
-		printf("spl: unable to read file %s. Err - %d\n",
-		       filename, ret);
-out:
-	return ret;
+	load.read = spl_fit_read;
+	spl_set_bl_len(&load, ARCH_DMA_MINALIGN);
+	load.priv = &dev;
+	return spl_load(spl_image, bootdev, &load, filesize, 0);
 }
diff --git a/include/spl_load.h b/include/spl_load.h
index b48f80324bb..2618109cee0 100644
--- a/include/spl_load.h
+++ b/include/spl_load.h
@@ -95,6 +95,7 @@ static inline int _spl_load(struct spl_image_info *spl_image,
  * inline if there is one caller, and extern otherwise.
  */
 #define SPL_LOAD_USERS \
+	IS_ENABLED(CONFIG_SPL_BLK_FS) + \
 	IS_ENABLED(CONFIG_SPL_FS_EXT4) + \
 	IS_ENABLED(CONFIG_SPL_FS_FAT) + \
 	IS_ENABLED(CONFIG_SPL_SYS_MMCSD_RAW_MODE) + \
diff --git a/test/image/spl_load_fs.c b/test/image/spl_load_fs.c
index 67c19da95e7..5f1de5486f4 100644
--- a/test/image/spl_load_fs.c
+++ b/test/image/spl_load_fs.c
@@ -395,6 +395,8 @@ static int spl_test_blk(struct unit_test_state *uts, const char *test_name,
 	return spl_test_mmc_fs(uts, test_name, type, create_ext2, true);
 }
 SPL_IMG_TEST(spl_test_blk, LEGACY, DM_FLAGS);
+SPL_IMG_TEST(spl_test_blk, LEGACY_LZMA, DM_FLAGS);
+SPL_IMG_TEST(spl_test_blk, IMX8, DM_FLAGS);
 SPL_IMG_TEST(spl_test_blk, FIT_EXTERNAL, DM_FLAGS);
 SPL_IMG_TEST(spl_test_blk, FIT_INTERNAL, DM_FLAGS);
 
-- 
2.37.1

