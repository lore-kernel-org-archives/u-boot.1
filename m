Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9FC8C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 16:52:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15F8C8771B;
	Wed,  8 Nov 2023 17:49:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PgewAhke";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3BFB8775F; Wed,  8 Nov 2023 17:49:35 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA6E4875A7
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 17:49:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5a7eef0b931so84094367b3.0
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 08:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699462162; x=1700066962; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2fY5TCMWDMTNUYdkBtkEG3ITBz2UWidoNRP9rmFOPpY=;
 b=PgewAhkexBvo/EPM36S+hoDBpSZU3tr7lHle9FeARymFcsnBZDEoxrGx27sYMbmlX+
 beTZ5rDbfGoFKAT0IMhEZr1FGJJ1msM8kH46fuL6x5aRKYKd5lZLjh5QmK6yTwERzznq
 vTLLV8pyOXZPZf+7CXIC8mqWDbzVSsG0ZwBRGkMWQ1wdGcsSsmB+PDT5QYw7mo4Kz/QJ
 4pIs2S2/feSMZVMKHgA8uCgABX9EyABlFi/ro2GG33PVcFrRzLiQGYkN9plTPsbrDwFH
 /wbQehbv8BGzIOu/xFnyOUPkl9hnnjiAecmcWtiFDdMuR3CeIeuxndnD1peip+Fo1Rbu
 YCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699462162; x=1700066962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2fY5TCMWDMTNUYdkBtkEG3ITBz2UWidoNRP9rmFOPpY=;
 b=c7kYKX3qH/cqPq/qh16RXbU8mNxQYortsPADKv19S346CGQl4+kh0Y+vb0B0ZqF2dm
 Q9SXExULKuaf7O1M7hNmMiiqXu3Bfct8yJ6WMW/isll7FaGf4k04+BJcsd3++zyO0T6X
 BXlFHx7JydELy7o1BrQUS9pdlBQxoyCDQ+ZVSWUUlhNA5jqH2SrCaP3qhuDQ84KWTrgn
 Ydr73wVeXMS/HFBs5VaxT9oV1kMnfELq3l8na3B1cwzUJSTXG3I3TRCPTTpIi+UfbORL
 890MxtYa1x1XyuvMenFUSK/s5HWaq1n6dd0Dx0KC7KHhpT/5bkaaYw69VQ5vtQmPvd2/
 foPQ==
X-Gm-Message-State: AOJu0YyA5AA94BP+2vqMqXWyL/A796ccp0F1Wsm8MwNX3oi94vhZUhnC
 Nr9hJRzdLAFakT4A8bp4XrI=
X-Google-Smtp-Source: AGHT+IFF1u43u9CPoN3MnafGMk6+oqDobJjKgFw/cnewnhPLHAZrmw6Aiy60jhig80ixLm5JAnq+4w==
X-Received: by 2002:a81:6cd6:0:b0:5a7:f002:4fe4 with SMTP id
 h205-20020a816cd6000000b005a7f0024fe4mr2312692ywc.23.1699462161900; 
 Wed, 08 Nov 2023 08:49:21 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 g4-20020a0cd7c4000000b00658266be23fsm1244342qvj.41.2023.11.08.08.49.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 08:49:21 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>, Marek Vasut <marex@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v7 16/26] spl: Convert ext to use spl_load
Date: Wed,  8 Nov 2023 11:48:48 -0500
Message-Id: <20231108164858.3497420-17-seanga2@gmail.com>
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

This converts the ext load method to use spl_load. As a consequence, it
also adds support for FIT and IMX images.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v6)

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

