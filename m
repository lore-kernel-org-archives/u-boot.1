Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3A2CDE03F
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:45:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED73E88FAF;
	Fri, 27 Sep 2024 00:45:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gBuknR6Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2847388FAF; Fri, 27 Sep 2024 00:45:23 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83C1388FF7
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:45:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-4581e0ed0f2so21364281cf.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727390719; x=1727995519; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SnlQtu1eqShVR/mPezAy9rK6NzO1jNS/+rwWCJOTpUQ=;
 b=gBuknR6ZTFWLXWm4SDe0M/RmP6O3ExZnWxpy221sCk8PpST5Gl9Rj98MAOMq3Yzb8Z
 +59jQ5+X3MMMUCWPxY+G6f7P6cT3nlfDWAi9k6XYqqJ1GrLc6E3aYbFI1lJI9qeCsYUR
 +FTXsV5JNmYAPO5xBKLcmaq5s9Be3DMRIMOZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727390719; x=1727995519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SnlQtu1eqShVR/mPezAy9rK6NzO1jNS/+rwWCJOTpUQ=;
 b=wRzfPIhMb32qMVQ7jep2r++dzyFiuc2yaETxp9JFRTJKz0YGbWakzcs31vTWxHRN9d
 X9WiRaexbfqeJsA1tIHYkr8IScOytTmTrKSgh3+tHS3kDtym5L7ieCw6GooCjK3pTh1L
 p/VzvLOTb+6Z/BnpfKfbp74cCEq6Op+ZjZUNEn8RdpeWuIPHIc4Jn4R16wnUZXPijG4s
 aCxGmwmGNE0WcvVi93M4ShWBWIxRzxPs5n7+RBxQm37ht+UhHycSf+F65sm132r/luHE
 rOsNSZdsjnB1zfB9DwTY5ka0c9X/hcl8fj+5ujiZ8mOpvP7Ig0hds3fkRVbcdL6LYKqc
 eG3Q==
X-Gm-Message-State: AOJu0YwuJVQkhCSd5+hoeToG3iL3T58BScNhYUAZ5ogLBmZa49Y/sC6l
 W031AwCXhWCk7OFoRItLZxT6Yli5xIQ+Q8wKANKQO95jtac3Z8ZpgOdNDAatLn4VwAnc055ln6N
 wU91JlFA=
X-Google-Smtp-Source: AGHT+IEfJnXKH9fu8Ew21yXCDGsrRWapEclmdIxTjbTaDP6FB+o3KNOblPXnQW//HzoNQ0QqJV34kA==
X-Received: by 2002:a05:622a:1183:b0:451:b77e:a8c1 with SMTP id
 d75a77b69052e-45c949557bcmr86308341cf.3.1727390719330; 
 Thu, 26 Sep 2024 15:45:19 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f350fadsm2738461cf.80.2024.09.26.15.45.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:45:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Devarsh Thakkar <devarsht@ti.com>, Kever Yang <kever.yang@rock-chips.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Suniel Mahesh <sunil@amarulasolutions.com>
Subject: [PATCH 31/42] spl: Rename SPL_TPL_NAME and SPL_TPL_PROMPT
Date: Fri, 27 Sep 2024 00:35:56 +0200
Message-ID: <20240926223814.1276764-32-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926223814.1276764-1-sjg@chromium.org>
References: <20240926223814.1276764-1-sjg@chromium.org>
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

Rename these to use the word PHASE instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/spl/spl.c        | 36 ++++++++++++++++++------------------
 common/spl/spl_fit.c    |  2 +-
 common/spl/spl_legacy.c |  2 +-
 include/spl.h           | 14 +++++++-------
 4 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index c13b2b8f714..dc73d3aff00 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -97,9 +97,9 @@ __weak int dram_init_banksize(void)
 #if CONFIG_IS_ENABLED(OS_BOOT)
 __weak int spl_start_uboot(void)
 {
-	puts(SPL_TPL_PROMPT
+	puts(PHASE_PROMPT
 	     "Please implement spl_start_uboot() for your board\n");
-	puts(SPL_TPL_PROMPT "Direct Linux boot not active!\n");
+	puts(PHASE_PROMPT "Direct Linux boot not active!\n");
 	return 1;
 }
 
@@ -140,13 +140,13 @@ void spl_fixup_fdt(void *fdt_blob)
 	/* fixup the memory dt node */
 	err = fdt_shrink_to_minimum(fdt_blob, 0);
 	if (err == 0) {
-		printf(SPL_TPL_PROMPT "fdt_shrink_to_minimum err - %d\n", err);
+		printf(PHASE_PROMPT "fdt_shrink_to_minimum err - %d\n", err);
 		return;
 	}
 
 	err = arch_fixup_fdt(fdt_blob);
 	if (err) {
-		printf(SPL_TPL_PROMPT "arch_fixup_fdt err - %d\n", err);
+		printf(PHASE_PROMPT "arch_fixup_fdt err - %d\n", err);
 		return;
 	}
 #endif
@@ -330,7 +330,7 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
 			spl_image->load_addr = start;
 			spl_image->entry_point = start;
 			spl_image->size = size;
-			debug(SPL_TPL_PROMPT
+			debug(PHASE_PROMPT
 			      "payload Image, load addr: 0x%lx size: %d\n",
 			      spl_image->load_addr, spl_image->size);
 			return 0;
@@ -344,7 +344,7 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
 			spl_image->load_addr = CONFIG_SYS_LOAD_ADDR;
 			spl_image->entry_point = CONFIG_SYS_LOAD_ADDR;
 			spl_image->size = end - start;
-			debug(SPL_TPL_PROMPT
+			debug(PHASE_PROMPT
 			      "payload zImage, load addr: 0x%lx size: %d\n",
 			      spl_image->load_addr, spl_image->size);
 			return 0;
@@ -423,7 +423,7 @@ static int write_spl_handoff(void)
 	ret = handoff_arch_save(ho);
 	if (ret)
 		return ret;
-	debug(SPL_TPL_PROMPT "Wrote SPL handoff\n");
+	debug(PHASE_PROMPT "Wrote SPL handoff\n");
 
 	return 0;
 }
@@ -624,11 +624,11 @@ static int boot_from_devices(struct spl_image_info *spl_image,
 					printf("Trying to boot from %s\n",
 					       spl_loader_name(loader));
 				else if (CONFIG_IS_ENABLED(SHOW_ERRORS)) {
-					printf(SPL_TPL_PROMPT
+					printf(PHASE_PROMPT
 					       "Unsupported Boot Device %d\n",
 					       bootdev);
 				} else {
-					puts(SPL_TPL_PROMPT
+					puts(PHASE_PROMPT
 					     "Unsupported Boot Device!\n");
 				}
 			}
@@ -674,7 +674,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 	struct spl_image_info spl_image;
 	int ret, os;
 
-	debug(">>" SPL_TPL_PROMPT "board_init_r()\n");
+	debug(">>" PHASE_PROMPT "board_init_r()\n");
 
 	spl_set_bd();
 
@@ -694,7 +694,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 		if (ret) {
 			debug("%s: Failed to set up bloblist: ret=%d\n",
 			      __func__, ret);
-			puts(SPL_TPL_PROMPT "Cannot set up bloblist\n");
+			puts(PHASE_PROMPT "Cannot set up bloblist\n");
 			hang();
 		}
 	}
@@ -703,7 +703,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 
 		ret = setup_spl_handoff();
 		if (ret) {
-			puts(SPL_TPL_PROMPT "Cannot set up SPL handoff\n");
+			puts(PHASE_PROMPT "Cannot set up SPL handoff\n");
 			hang();
 		}
 	}
@@ -724,7 +724,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 	if (CONFIG_IS_ENABLED(PCI) && !(gd->flags & GD_FLG_DM_DEAD)) {
 		ret = pci_init();
 		if (ret)
-			puts(SPL_TPL_PROMPT "Cannot initialize PCI\n");
+			puts(PHASE_PROMPT "Cannot initialize PCI\n");
 		/* Don't fail. We still can try other boot methods. */
 	}
 
@@ -751,10 +751,10 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 				ARRAY_SIZE(spl_boot_list));
 	if (ret) {
 		if (CONFIG_IS_ENABLED(SHOW_ERRORS))
-			printf(SPL_TPL_PROMPT "failed to boot from all boot devices (err=%d)\n",
+			printf(PHASE_PROMPT "failed to boot from all boot devices (err=%d)\n",
 			       ret);
 		else
-			puts(SPL_TPL_PROMPT "failed to boot from all boot devices\n");
+			puts(PHASE_PROMPT "failed to boot from all boot devices\n");
 		hang();
 	}
 
@@ -808,13 +808,13 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 	if (CONFIG_IS_ENABLED(HANDOFF)) {
 		ret = write_spl_handoff();
 		if (ret)
-			printf(SPL_TPL_PROMPT
+			printf(PHASE_PROMPT
 			       "SPL hand-off write failed (err=%d)\n", ret);
 	}
 	if (CONFIG_IS_ENABLED(UPL_OUT) && (gd->flags & GD_FLG_UPL)) {
 		ret = spl_write_upl_handoff(&spl_image);
 		if (ret) {
-			printf(SPL_TPL_PROMPT
+			printf(PHASE_PROMPT
 			       "UPL hand-off write failed (err=%d)\n", ret);
 			hang();
 		}
@@ -844,7 +844,7 @@ void preloader_console_init(void)
 	gd->flags |= GD_FLG_HAVE_CONSOLE;
 
 #if CONFIG_IS_ENABLED(BANNER_PRINT)
-	puts("\nU-Boot " SPL_TPL_NAME " " PLAIN_VERSION " (" U_BOOT_DATE " - "
+	puts("\nU-Boot " PHASE_NAME " " PLAIN_VERSION " (" U_BOOT_DATE " - "
 	     U_BOOT_TIME " " U_BOOT_TZ ")\n");
 #endif
 #ifdef CONFIG_SPL_DISPLAY_PRINT
diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 1ad5a69d807..3160f573bfb 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -904,7 +904,7 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
 		spl_image->os = IH_OS_INVALID;
 	spl_image->name = genimg_get_os_name(spl_image->os);
 
-	debug(SPL_TPL_PROMPT "payload image: %32s load addr: 0x%lx size: %d\n",
+	debug(PHASE_PROMPT "payload image: %32s load addr: 0x%lx size: %d\n",
 	      spl_image->name, spl_image->load_addr, spl_image->size);
 
 #ifdef CONFIG_SPL_FIT_SIGNATURE
diff --git a/common/spl/spl_legacy.c b/common/spl/spl_legacy.c
index a77893455f2..9252b3a3de0 100644
--- a/common/spl/spl_legacy.c
+++ b/common/spl/spl_legacy.c
@@ -71,7 +71,7 @@ int spl_parse_legacy_header(struct spl_image_info *spl_image,
 
 	spl_image->os = image_get_os(header);
 	spl_image->name = image_get_name(header);
-	debug(SPL_TPL_PROMPT
+	debug(PHASE_PROMPT
 	      "payload image: %32s load addr: 0x%lx size: %d\n",
 	      spl_image->name, spl_image->load_addr, spl_image->size);
 
diff --git a/include/spl.h b/include/spl.h
index 415d198da56..47666eace91 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -229,16 +229,16 @@ static inline const char *spl_phase_prefix(enum u_boot_phase phase)
 /* A string name for SPL or TPL */
 #ifdef CONFIG_XPL_BUILD
 # ifdef CONFIG_TPL_BUILD
-#  define SPL_TPL_NAME	"TPL"
+#  define PHASE_NAME	"TPL"
 # elif defined(CONFIG_VPL_BUILD)
-#  define SPL_TPL_NAME	"VPL"
-# else
-#  define SPL_TPL_NAME	"SPL"
+#  define PHASE_NAME	"VPL"
+# elif defined(CONFIG_SPL_BUILD)
+#  define PHASE_NAME	"SPL"
 # endif
-# define SPL_TPL_PROMPT	SPL_TPL_NAME ": "
+# define PHASE_PROMPT	PHASE_NAME ": "
 #else
-# define SPL_TPL_NAME	""
-# define SPL_TPL_PROMPT	""
+# define PHASE_NAME	""
+# define PHASE_PROMPT	""
 #endif
 
 /**
-- 
2.43.0

