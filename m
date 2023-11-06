Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDAECC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 03:04:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 983F286EF2;
	Mon,  6 Nov 2023 03:37:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K8BRDxOw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DAA286F80; Mon,  6 Nov 2023 03:28:39 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D6C187001
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 03:26:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-66d190a8f87so26432386d6.0
 for <u-boot@lists.denx.de>; Sun, 05 Nov 2023 18:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699237584; x=1699842384; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3AuRUASkriSfutJn3tIscrRI6AiAm52NLtDQswPflFY=;
 b=K8BRDxOw8oln9CFImBGwxBXvp9oFtOpWl0+LFR8BmyJBGEJoMi4ChCyzAaYLVliMau
 5E9eBsJbyNfLoGt+KQXri7FLrUghNZUgBAAw3TIWljsfkqOGcAI43ZW3IY21uyPMdnIY
 52Al+2UcisUjUADT8s4RamlQbrovtJ6nDn4kXCeAbT4vBJUxvp4mB7P1BiZ5g5jaKNxa
 bvMySeCoD+6O3rUycEYngHLSg4tUwNp9VTDAzozgbyb085xpoPwmhhn2bG0r0OrXq1fL
 qDwj4qVGpy7KAj5WhevhhqSgsHC9VCas5Sfa0vAm8YfB5QZ4HWqekKXHkxaPtAlll2jM
 V8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699237584; x=1699842384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3AuRUASkriSfutJn3tIscrRI6AiAm52NLtDQswPflFY=;
 b=I2IaEASsH+AXo3jged4b57xDebP5m/8hTpmrR/8TFo2keLWrBJwUy5cvVASVFUCtdV
 a2mIyzl2aNDCbJIfXoErOBpLwbOv7Ak2Wnmw33IKwKOVWcUI63KsQagHJDiAb5wxepgG
 5eFAaUHOrBlSpAVwraRvS/33dIJiorZHoPYY+vY6F4aXK9AMGmAfNcbYpulzphSGXlof
 +xtXUnkVtBzzhLFTQeFWzQQsFw5Ex+gClPadqu35PM7bDe/lLvm6jya3FgVW/GIqx+f6
 SpIasCOIgk6pJy5R5xAAIgeji6DdwBJrFgmGPQJnppmPLrJjoOjfmVLHpg62pILUfnsl
 +ytg==
X-Gm-Message-State: AOJu0YxC2Yqluf83VP9MqCR+EFh+HJLlWdVEZfmurNVH4VvegIV2tJ46
 014cFOMLVYIOZvOVELFIw4g=
X-Google-Smtp-Source: AGHT+IHoWEG3J5UpJ4+wpDMm5b+cOSUNNjAnRO0QgFWaehqDbxgF7Pragkab1je3oNme/le1psBA1g==
X-Received: by 2002:ad4:5f08:0:b0:672:3a8a:b1ab with SMTP id
 fo8-20020ad45f08000000b006723a8ab1abmr28008531qvb.15.1699237583825; 
 Sun, 05 Nov 2023 18:26:23 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 s10-20020ad4524a000000b00670c15033aesm3004730qvq.144.2023.11.05.18.26.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Nov 2023 18:26:23 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v6 15/25] spl: Convert ext to use spl_load
Date: Sun,  5 Nov 2023 21:25:53 -0500
Message-Id: <20231106022603.3405551-16-seanga2@gmail.com>
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

This converts the ext load method to use spl_load. As a consequence, it
also adds support for FIT and IMX images.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

Changes in v6:
- Explicitly initialize load_info members

Changes in v5:
- Rework to load header in spl_load

 common/spl/spl_ext.c     | 36 ++++++++++++++++++------------------
 include/spl_load.h       |  1 +
 test/image/spl_load_fs.c |  9 ++++++---
 3 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/common/spl/spl_ext.c b/common/spl/spl_ext.c
index af836ca15b8..d280b69c387 100644
--- a/common/spl/spl_ext.c
+++ b/common/spl/spl_ext.c
@@ -2,25 +2,35 @@
 
 #include <common.h>
 #include <env.h>
-#include <mapmem.h>
 #include <part.h>
 #include <spl.h>
+#include <spl_load.h>
 #include <asm/u-boot.h>
 #include <ext4fs.h>
 #include <errno.h>
 #include <image.h>
 
+static ulong spl_fit_read(struct spl_load_info *load, ulong file_offset,
+			  ulong size, void *buf)
+{
+	int ret;
+	loff_t actlen;
+
+	ret = ext4fs_read(buf, file_offset, size, &actlen);
+	if (ret)
+		return ret;
+	return actlen;
+}
+
 int spl_load_image_ext(struct spl_image_info *spl_image,
 		       struct spl_boot_device *bootdev,
 		       struct blk_desc *block_dev, int partition,
 		       const char *filename)
 {
 	s32 err;
-	struct legacy_img_hdr *header;
-	loff_t filelen, actlen;
+	loff_t filelen;
 	struct disk_partition part_info = {};
-
-	header = spl_get_load_buffer(-sizeof(*header), sizeof(*header));
+	struct spl_load_info load;
 
 	if (part_get_info(block_dev, partition, &part_info)) {
 		printf("spl: no partition table found\n");
@@ -42,20 +52,10 @@ int spl_load_image_ext(struct spl_image_info *spl_image,
 		puts("spl: ext4fs_open failed\n");
 		goto end;
 	}
-	err = ext4fs_read((char *)header, 0, sizeof(struct legacy_img_hdr), &actlen);
-	if (err < 0) {
-		puts("spl: ext4fs_read failed\n");
-		goto end;
-	}
 
-	err = spl_parse_image_header(spl_image, bootdev, header);
-	if (err < 0) {
-		puts("spl: ext: failed to parse image header\n");
-		goto end;
-	}
-
-	err = ext4fs_read(map_sysmem(spl_image->load_addr, filelen), 0, filelen,
-			  &actlen);
+	spl_set_bl_len(&load, 1);
+	load.read = spl_fit_read;
+	err = spl_load(spl_image, bootdev, &load, filelen, 0);
 
 end:
 #ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
diff --git a/include/spl_load.h b/include/spl_load.h
index 406f8b577b2..65aa6bb4493 100644
--- a/include/spl_load.h
+++ b/include/spl_load.h
@@ -95,6 +95,7 @@ static inline int _spl_load(struct spl_image_info *spl_image,
  * inline if there is one caller, and extern otherwise.
  */
 #define SPL_LOAD_USERS \
+	IS_ENABLED(CONFIG_SPL_FS_EXT4) + \
 	0
 
 #if SPL_LOAD_USERS > 1
diff --git a/test/image/spl_load_fs.c b/test/image/spl_load_fs.c
index 59d0244d44b..01559e98c4f 100644
--- a/test/image/spl_load_fs.c
+++ b/test/image/spl_load_fs.c
@@ -422,20 +422,23 @@ static int spl_test_mmc(struct unit_test_state *uts, const char *test_name,
 	spl_mmc_clear_cache();
 	spl_fat_force_reregister();
 
-	if (type == LEGACY &&
-	    spl_test_mmc_fs(uts, test_name, type, create_ext2, false))
+	if (spl_test_mmc_fs(uts, test_name, type, create_ext2, false))
 		return CMD_RET_FAILURE;
 
-	if (type != IMX8 &&
+	if (type != IMX8 && type != LEGACY_LZMA &&
 	    spl_test_mmc_fs(uts, test_name, type, create_fat, false))
 		return CMD_RET_FAILURE;
 
+	if (type == LEGACY_LZMA)
+		return 0;
+
 	return do_spl_test_load(uts, test_name, type,
 				SPL_LOAD_IMAGE_GET(0, BOOT_DEVICE_MMC1,
 						   spl_mmc_load_image),
 				spl_test_mmc_write_image);
 }
 SPL_IMG_TEST(spl_test_mmc, LEGACY, DM_FLAGS);
+SPL_IMG_TEST(spl_test_mmc, LEGACY_LZMA, DM_FLAGS);
 SPL_IMG_TEST(spl_test_mmc, IMX8, DM_FLAGS);
 SPL_IMG_TEST(spl_test_mmc, FIT_EXTERNAL, DM_FLAGS);
 SPL_IMG_TEST(spl_test_mmc, FIT_INTERNAL, DM_FLAGS);
-- 
2.37.1

