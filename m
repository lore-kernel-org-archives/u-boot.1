Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2A0C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 16:52:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 155238774A;
	Wed,  8 Nov 2023 17:49:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VfE9TFBG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E668F8772D; Wed,  8 Nov 2023 17:49:40 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B20A58770B
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 17:49:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-41cc75c55f0so8517471cf.1
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 08:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699462165; x=1700066965; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hGQ9inhUcGYpil4IPWM6lUxnFpf62MFsqTMPqEnE7G0=;
 b=VfE9TFBGLu1LY5YSewZXKIxr57WijP4tOB1AEjww06Q70yB8cbXtFVK9JrnMf9fyr/
 XP9LCCfkrt5Mq7GvqcGxsJzhd4rvOU4OXgPWEgugOuewdJBlETlLM5nEQpmATSXmifSM
 RjUund+IHORNKicBGcN4e5WvgUJxmTGG4yOeVHHwEHGky5aoKME7iPsEzPEpE6/Fgnz9
 /x8GVnaeCtiuHPLMdzDTErQhKUDMKptqwuqOZOpGcidT4X5hSR/0EOK/+BK3aU/7Tqt2
 rNM7t8z5A9f1qD7XmAdh583MXA/VdrhIbYApv+VaQqbLwPFzJuR1wyg4QUDfpV9JI/fi
 63/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699462165; x=1700066965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hGQ9inhUcGYpil4IPWM6lUxnFpf62MFsqTMPqEnE7G0=;
 b=sH5M/u8GCyTGs4MYZpOn6Y1R5REN+zO4NKU2FuzqX9OTnWmJOw6kINL9CerVRZiyN7
 wprgcDHjRJAt6reZ23PG/VxZ4JnfOM8F+6zCUHfO9QfnHkrjtzPpD9kVdNErK1Bwj9tz
 86/RO9AQggTCQ66FbKIZksyR2W/Q6ilPdiqaX2Nnk+KNkzIqa4030z1mknBWhutK51F1
 yZQT+OBUUq5u39YoGbbZ6ivFNr1IlSh2LHdScc7abpnvMSw1iSufg/hM8uuCgZxe9LIw
 /iJRJUI8dGFtsEHH4arwuj4xOTraoRQhuFxmPBIPmothG5lmR1p/fZMygzOVQPBvSShU
 RRGw==
X-Gm-Message-State: AOJu0Yzr4od/0iilBZPeJUDEcNpuh8b5AbjzAEVHDwYpYABFxXVtpuL3
 SXPRYeG+8uRjDwQvciOVTqDDGngPNqE=
X-Google-Smtp-Source: AGHT+IE2OzOR3YfcZe8hs7knJckMPmV7iRi2TLXwkfizS2QQrLsRNyXkXck0c01qsoHgE8e2l+gY8g==
X-Received: by 2002:a05:622a:170e:b0:403:f389:5793 with SMTP id
 h14-20020a05622a170e00b00403f3895793mr3418484qtk.32.1699462165477; 
 Wed, 08 Nov 2023 08:49:25 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 k16-20020ac84750000000b004033c3948f9sm1062220qtp.42.2023.11.08.08.49.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 08:49:25 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>, Marek Vasut <marex@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH v7 19/26] spl: Convert nand to spl_load
Date: Wed,  8 Nov 2023 11:48:51 -0500
Message-Id: <20231108164858.3497420-20-seanga2@gmail.com>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v6)

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

