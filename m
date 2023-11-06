Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E3CFC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 03:08:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 437A387148;
	Mon,  6 Nov 2023 03:37:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eFESaNi+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04D2D86CF7; Mon,  6 Nov 2023 03:29:24 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB18A86FB0
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 03:26:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7781b176131so201177285a.1
 for <u-boot@lists.denx.de>; Sun, 05 Nov 2023 18:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699237591; x=1699842391; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YaLQKHC+zvdPOY+o6hQ5bBBmRhMXgy0GIM1b3IN0l6E=;
 b=eFESaNi+cntJrtZR59LbuWgt/jb6VVgkNevZZWqoUewWJhcatl7DYCvX+Qy51Wxwwa
 AuCWS5hmnD1c0y1sVnhTOcI70tZQmgEn/cQfSRhxhzmLyaW69IPTjbsVuAVKvIUnTnXo
 L2ABgK/EEWD5y+ExuAAbp6KVDTZLtd1/hofQPXXtFWSZ7+oAtgsqSmGR3Tz8nG8QBq0G
 mcVfpDFAaINdMWBKeU4Y0pIwSy1IWlTmpRcTUHoUsNoSBx0o+5MuMFuwedjVzQrbpRZh
 y5eTlMGbiEwpfHPuR39MWqMiX+LNxLoA+DIb48T49F7Y0/PmK9cn0V38EU1t0MVQ+HK2
 e+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699237591; x=1699842391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YaLQKHC+zvdPOY+o6hQ5bBBmRhMXgy0GIM1b3IN0l6E=;
 b=nQhmVoQNRIzAdBJbCGEXN6SyCqpLj3RUMrDLLlbbwagSFRFAtp81iIpzHwluMrkj8I
 YlbLfJeQFiySlqKhYVT6rnqKjYbRWLnRNx5TB4h5qdFCQmQ4Rph7O5THubwblyCgN0rQ
 vRx2Vmg4ykyQzjMsFJquxmlVPgDMALlyx3IQ9uQ8OLvNHfimJMZLp4ls/7XhYu592+Wo
 wGnzJj8HQWJSeofzls8bltRT8hDHaCPDkx0bsWN5/5anwmGKTvhmcUJb0FgPsxU1PCzw
 yWHtXOHocru+bXlrd5VTeQ9KDONNXV+es+nF+oW7lJYDbbv00YIVmFinuPPTm6waZCOg
 KryQ==
X-Gm-Message-State: AOJu0YweTbP461YkZmuBNq8Zeub/trL46g3eephue4ZnUrKYaMXcFjlE
 gohHqrXSefA2+PL4siJtockseDZvvxXFXQ==
X-Google-Smtp-Source: AGHT+IFLAitfKEBfczTU9sf0chzyDATk/fSVPUQYrbtPiaJTlIFMf6QxCZm19lSkvey4PTyZacM3iQ==
X-Received: by 2002:a05:620a:284a:b0:77b:94c0:ecf1 with SMTP id
 h10-20020a05620a284a00b0077b94c0ecf1mr1217837qkp.11.1699237590682; 
 Sun, 05 Nov 2023 18:26:30 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 bj39-20020a05620a192700b007676f3859fasm2892253qkb.30.2023.11.05.18.26.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Nov 2023 18:26:30 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Sean Anderson <seanga2@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: [PATCH v6 21/25] spl: Convert NVMe to spl_load
Date: Sun,  5 Nov 2023 21:25:59 -0500
Message-Id: <20231106022603.3405551-22-seanga2@gmail.com>
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

This converts the blk load method (used exclusively by NVMe) to use
spl_load. As a consequence, it also adds support for LOAD_FIT_FULL and
IMX images.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

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

