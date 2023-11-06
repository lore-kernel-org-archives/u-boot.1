Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD514C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 03:05:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D06A870C4;
	Mon,  6 Nov 2023 03:37:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QJBhWXna";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F92786F2A; Mon,  6 Nov 2023 03:28:54 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71AA58701C
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 03:26:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-67131800219so28402806d6.3
 for <u-boot@lists.denx.de>; Sun, 05 Nov 2023 18:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699237587; x=1699842387; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F8vktCbqqJ/eVN33ccfsaYpJv+LoLinY7dU86zs4lg0=;
 b=QJBhWXnavtaTc+uFNe490l5Zir3sxA9c9o8Dklz9mP2QwjD86kkt7JSjhwlmyxoJu3
 QFd4CazoBAdfmhvEMsTs9eNZ+dt5zzyh7zCFDT1XMJeqpKTnAqCAm/SKePcGTo8NSfR3
 qEvCKU4EsLi5b0eCj+Oo/KaBcXDS50Q/GXIA7rIdpDQjEfpc6404tMaCgcycdbbQOTjA
 kTZlQpRxVsiHcG6JgTEJxAY7+ayzxhRjerRJfb9zL/gLQGNKOuhJSYZa/zAwdwVkGQqo
 J7jJlYxclFAVztVy6Z/QKqT/dZcVXSqx0vOXLXd9C37Fer3CI48CaRurHIdAds5D+tlN
 tHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699237587; x=1699842387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F8vktCbqqJ/eVN33ccfsaYpJv+LoLinY7dU86zs4lg0=;
 b=hyT1HS9trZ4O0gll3vgLhBvXD3akQ4xDqNcnDnFn+O4a01oYpoFwr9r1az2TAJVl/i
 JaAg8/M5e6M3TJAPtnTBIRGneBdX1dfvCvibh6XeaIUrrKhg0hsvM659KEF66TNHLK/u
 mvyCh7u0wDBH4eVVpT2P2OfolesA0xRna82mQvqOAdpOqxXJEkEs0Vs5UXpHs+rpEc+7
 xua/xV2ss8XeweeSC/V6hJ85DOCdGYDj0s+wT6HwSKRh4QbFqFvmR5Qoznvpa0cKp+Ai
 UnfEJL7rYLDuqAJzOutNdni2juHamN7vjGseOLjoOtMAD3zK8kKrVc5Dia4cLs5T56hn
 2dCA==
X-Gm-Message-State: AOJu0YwYELdp6i78Ki0DDbkK6HqriBJhegXdiHIw/yPdXzw1TEZxqNYA
 Awq0OHlNt6ggBffvatiZJm4=
X-Google-Smtp-Source: AGHT+IHA2A8Lfa2lRXyw+xHrujXMuS/n/kOmGUwThVKV8JvACGy5xOrGFf49xbqzustDq5ETTerLCQ==
X-Received: by 2002:a05:6214:d85:b0:66d:33d2:4ff5 with SMTP id
 e5-20020a0562140d8500b0066d33d24ff5mr33892413qve.41.1699237587400; 
 Sun, 05 Nov 2023 18:26:27 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 cw12-20020ad44dcc000000b00670e7ae4964sm3044724qvb.91.2023.11.05.18.26.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Nov 2023 18:26:27 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Sean Anderson <seanga2@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH v6 18/25] spl: Convert nand to spl_load
Date: Sun,  5 Nov 2023 21:25:56 -0500
Message-Id: <20231106022603.3405551-19-seanga2@gmail.com>
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

This converts the nand load method to use spl_load. nand_page_size may not
be valid until after nand_spl_load_image is called (see e.g. fsl_ifc_spl),
so we set bl_len in spl_nand_read. Since spl_load reads the header for us,
we can remove that argument from spl_nand_load_element.

There are two possible regressions which could result from this commit.
First, we ask for a negative address from spl_get_load_buffer. That is,
instead of

	header = spl_get_load_buffer(0, sizeof(*header));

we do

	header = spl_get_load_buffer(-sizeof(*header), sizeof(*header));

this could cause a problem if spl_get_load_buffer does not return valid
memory for negative offsets. Second, we now set bl_len for legacy images.
This can cause memory up to a bl_len - 1 before the image load address to
be written, which might not have been the case before. If this turns out to
be a problem, we can add an option for a bounce buffer.

We can't load FITs with external data with SPL_LOAD_FIT_FULL, so disable the
test in that case. No boards enable SPL_NAND_SUPPORT and SPL_LOAD_FIT_FULL, so
this is not a regression.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

Changes in v6:
- New

 common/spl/spl_nand.c      | 70 +++++++++-----------------------------
 include/spl_load.h         |  1 +
 test/image/spl_load_nand.c |  2 ++
 3 files changed, 19 insertions(+), 54 deletions(-)

diff --git a/common/spl/spl_nand.c b/common/spl/spl_nand.c
index 91fa7674f17..3b0a1524238 100644
--- a/common/spl/spl_nand.c
+++ b/common/spl/spl_nand.c
@@ -10,6 +10,7 @@
 #include <imx_container.h>
 #include <log.h>
 #include <spl.h>
+#include <spl_load.h>
 #include <asm/io.h>
 #include <mapmem.h>
 #include <nand.h>
@@ -59,6 +60,7 @@ static ulong spl_nand_read(struct spl_load_info *load, ulong offs, ulong size,
 	sector = *(int *)load->priv;
 	offs = sector + nand_spl_adjust_offset(sector, offs - sector);
 	err = nand_spl_load_image(offs, size, dst);
+	spl_set_bl_len(load, nand_page_size());
 	if (err)
 		return 0;
 
@@ -66,60 +68,20 @@ static ulong spl_nand_read(struct spl_load_info *load, ulong offs, ulong size,
 }
 
 static int spl_nand_load_element(struct spl_image_info *spl_image,
-				 struct spl_boot_device *bootdev,
-				 int offset, struct legacy_img_hdr *header)
+				 struct spl_boot_device *bootdev, int offset)
 {
-	int bl_len;
-	int err;
+	struct spl_load_info load;
 
-	err = nand_spl_load_image(offset, sizeof(*header), (void *)header);
-	if (err)
-		return err;
-
-	bl_len = nand_page_size();
-	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT) &&
-	    image_get_magic(header) == FDT_MAGIC) {
-		struct spl_load_info load;
-
-		debug("Found FIT\n");
-		load.priv = &offset;
-		spl_set_bl_len(&load, bl_len);
-		load.read = spl_nand_read;
-		return spl_load_simple_fit(spl_image, &load, offset, header);
-	} else if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER) &&
-		   valid_container_hdr((void *)header)) {
-		struct spl_load_info load;
-
-		load.priv = &offset;
-		spl_set_bl_len(&load, bl_len);
-		load.read = spl_nand_read;
-		return spl_load_imx_container(spl_image, &load, offset);
-	} else if (IS_ENABLED(CONFIG_SPL_LEGACY_IMAGE_FORMAT) &&
-		   image_get_magic(header) == IH_MAGIC) {
-		struct spl_load_info load;
-
-		debug("Found legacy image\n");
-		load.priv = &offset;
-		spl_set_bl_len(&load, IS_ENABLED(CONFIG_SPL_LZMA) ? bl_len : 1);
-		load.read = spl_nand_read;
-		return spl_load_legacy_img(spl_image, bootdev, &load, offset, header);
-	} else {
-		err = spl_parse_image_header(spl_image, bootdev, header);
-		if (err)
-			return err;
-		return nand_spl_load_image(offset, spl_image->size,
-					   map_sysmem(spl_image->load_addr,
-						      spl_image->size));
-	}
+	load.priv = &offset;
+	spl_set_bl_len(&load, 1);
+	load.read = spl_nand_read;
+	return spl_load(spl_image, bootdev, &load, 0, offset);
 }
 
 static int spl_nand_load_image(struct spl_image_info *spl_image,
 			       struct spl_boot_device *bootdev)
 {
 	int err;
-	struct legacy_img_hdr *header;
-	int *src __attribute__((unused));
-	int *dst __attribute__((unused));
 
 #ifdef CONFIG_SPL_NAND_SOFTECC
 	debug("spl: nand - using sw ecc\n");
@@ -128,10 +90,12 @@ static int spl_nand_load_image(struct spl_image_info *spl_image,
 #endif
 	nand_init();
 
-	header = spl_get_load_buffer(0, sizeof(*header));
-
 #if CONFIG_IS_ENABLED(OS_BOOT)
 	if (!spl_start_uboot()) {
+		int *src, *dst;
+		struct legacy_img_hdr *header =
+			spl_get_load_buffer(0, sizeof(*header));
+
 		/*
 		 * load parameter image
 		 * load to temp position since nand_spl_load_image reads
@@ -174,20 +138,18 @@ static int spl_nand_load_image(struct spl_image_info *spl_image,
 	}
 #endif
 #ifdef CONFIG_NAND_ENV_DST
-	spl_nand_load_element(spl_image, bootdev, CONFIG_ENV_OFFSET, header);
+	spl_nand_load_element(spl_image, bootdev, CONFIG_ENV_OFFSET);
 #ifdef CONFIG_ENV_OFFSET_REDUND
-	spl_nand_load_element(spl_image, bootdev, CONFIG_ENV_OFFSET_REDUND, header);
+	spl_nand_load_element(spl_image, bootdev, CONFIG_ENV_OFFSET_REDUND);
 #endif
 #endif
 	/* Load u-boot */
-	err = spl_nand_load_element(spl_image, bootdev, spl_nand_get_uboot_raw_page(),
-				    header);
+	err = spl_nand_load_element(spl_image, bootdev, spl_nand_get_uboot_raw_page());
 #ifdef CONFIG_SYS_NAND_U_BOOT_OFFS_REDUND
 #if CONFIG_SYS_NAND_U_BOOT_OFFS != CONFIG_SYS_NAND_U_BOOT_OFFS_REDUND
 	if (err)
 		err = spl_nand_load_element(spl_image, bootdev,
-					    CONFIG_SYS_NAND_U_BOOT_OFFS_REDUND,
-					    header);
+					    CONFIG_SYS_NAND_U_BOOT_OFFS_REDUND);
 #endif
 #endif
 	nand_deselect();
diff --git a/include/spl_load.h b/include/spl_load.h
index d55a47ae7d7..38294a21ad0 100644
--- a/include/spl_load.h
+++ b/include/spl_load.h
@@ -98,6 +98,7 @@ static inline int _spl_load(struct spl_image_info *spl_image,
 	IS_ENABLED(CONFIG_SPL_FS_EXT4) + \
 	IS_ENABLED(CONFIG_SPL_FS_FAT) + \
 	IS_ENABLED(CONFIG_SPL_SYS_MMCSD_RAW_MODE) + \
+	(IS_ENABLED(CONFIG_SPL_NAND_SUPPORT) && !IS_ENABLED(CONFIG_SPL_UBI)) + \
 	0
 
 #if SPL_LOAD_USERS > 1
diff --git a/test/image/spl_load_nand.c b/test/image/spl_load_nand.c
index 30179de98e7..ec242207948 100644
--- a/test/image/spl_load_nand.c
+++ b/test/image/spl_load_nand.c
@@ -51,4 +51,6 @@ SPL_IMG_TEST(spl_test_nand, LEGACY, DM_FLAGS);
 SPL_IMG_TEST(spl_test_nand, LEGACY_LZMA, DM_FLAGS);
 SPL_IMG_TEST(spl_test_nand, IMX8, DM_FLAGS);
 SPL_IMG_TEST(spl_test_nand, FIT_INTERNAL, DM_FLAGS);
+#if !IS_ENABLED(CONFIG_SPL_LOAD_FIT_FULL)
 SPL_IMG_TEST(spl_test_nand, FIT_EXTERNAL, DM_FLAGS);
+#endif
-- 
2.37.1

