Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2A2CF6498
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 01:55:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F71C88DC8;
	Mon, 30 Sep 2024 03:51:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WR227y+g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FB5288DC8; Mon, 30 Sep 2024 03:51:28 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A53E88EE1
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 03:50:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-82d24e18dfcso190486939f.3
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 18:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727661053; x=1728265853; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z9wi9VFoUk61IOPV2KSeYdB7yY7U5HThDHqE5jkJEx4=;
 b=WR227y+gx4yh2zUWxOKnCHD9an3/X0C/zGAS0I9PJjBDVlLP3preYRkMLTu1NY4pXs
 /24/CXbV6SN6Sqypu8XluR1b81CBunEtbD4MPPyE1UPVJwJ7cLnmzuUN0B2ea+v2vcoh
 cSNckvUxBnzpLyO3eco4yOpR5SSyBHmNzLhls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727661053; x=1728265853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z9wi9VFoUk61IOPV2KSeYdB7yY7U5HThDHqE5jkJEx4=;
 b=UMDRHy4a4sqRXMWFlXJCk2FV2xZFicUD2b9cOFll9jbqjfiU2s8szGPJf39rF9to5R
 vlqZ9szNVAv76mp8QhB+Z5M1hoVl2Znk8RpI+HPOjggPSEE/NsRRqCYc23L8qof32R8i
 lVtEvOqvf3j58OF6oiNhFHdtboZcA68ZtqV4/Pr4cuFJavKldf6OsB3uO2KmpXAiowAc
 IQ+RpdyDd0+seRnmGWFwnE6uXOCL/sfFTn3eUxqL1vm+AtlAMKKF2UWCPVnq1s2BPCRW
 Cj6NjkMs4AodmQ9VIBpX0oSf27w23d1dtsVdHgJxeE8+8WwnXVcVah2GTPeb9Bs+0Fm3
 nk0Q==
X-Gm-Message-State: AOJu0YwzaQVQkwmdxvXRohnQ9O31NFBeDv7QYg/27GKaS9xwC7/9T3oc
 wa8ItBLhk/HihA9Xr8F2w2/MZQyY9TasyCPcUWzP8kZd8zmAWfe9XOP9B2zn4WsNt3HVEKxUUMn
 WXw==
X-Google-Smtp-Source: AGHT+IG8zXKF6emxAxFi0QizoR8uK/bL51xr8ctv4PfDrAgqkhXIpGr9pwy0YkHv+aGJPioU+GDoLg==
X-Received: by 2002:a92:ca0c:0:b0:3a0:533e:3c0a with SMTP id
 e9e14a558f8ab-3a345165300mr92815565ab.7.1727661053048; 
 Sun, 29 Sep 2024 18:50:53 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a344de1d5fsm22074185ab.62.2024.09.29.18.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 18:50:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Devarsh Thakkar <devarsht@ti.com>, Kever Yang <kever.yang@rock-chips.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Suniel Mahesh <sunil@amarulasolutions.com>
Subject: [PATCH v3 32/33] spl: Rename SPL_TPL_NAME and SPL_TPL_PROMPT
Date: Sun, 29 Sep 2024 19:49:55 -0600
Message-Id: <20240930014956.1434060-33-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930014956.1434060-1-sjg@chromium.org>
References: <20240930014956.1434060-1-sjg@chromium.org>
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

(no changes since v1)

 common/spl/spl.c        | 36 ++++++++++++++++++------------------
 common/spl/spl_fit.c    |  2 +-
 common/spl/spl_legacy.c |  2 +-
 include/spl.h           | 14 +++++++-------
 4 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 9748a3fb3e9..94657d00591 100644
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
@@ -623,11 +623,11 @@ static int boot_from_devices(struct spl_image_info *spl_image,
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
@@ -673,7 +673,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 	struct spl_image_info spl_image;
 	int ret, os;
 
-	debug(">>" SPL_TPL_PROMPT "board_init_r()\n");
+	debug(">>" PHASE_PROMPT "board_init_r()\n");
 
 	spl_set_bd();
 
@@ -693,7 +693,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 		if (ret) {
 			debug("%s: Failed to set up bloblist: ret=%d\n",
 			      __func__, ret);
-			puts(SPL_TPL_PROMPT "Cannot set up bloblist\n");
+			puts(PHASE_PROMPT "Cannot set up bloblist\n");
 			hang();
 		}
 	}
@@ -702,7 +702,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 
 		ret = setup_spl_handoff();
 		if (ret) {
-			puts(SPL_TPL_PROMPT "Cannot set up SPL handoff\n");
+			puts(PHASE_PROMPT "Cannot set up SPL handoff\n");
 			hang();
 		}
 	}
@@ -723,7 +723,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 	if (CONFIG_IS_ENABLED(PCI) && !(gd->flags & GD_FLG_DM_DEAD)) {
 		ret = pci_init();
 		if (ret)
-			puts(SPL_TPL_PROMPT "Cannot initialize PCI\n");
+			puts(PHASE_PROMPT "Cannot initialize PCI\n");
 		/* Don't fail. We still can try other boot methods. */
 	}
 
@@ -750,10 +750,10 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
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
 
@@ -807,13 +807,13 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
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
@@ -843,7 +843,7 @@ void preloader_console_init(void)
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
index 3fc50cd9195..269e36bb441 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -241,16 +241,16 @@ static inline const char *xpl_prefix(enum xpl_phase_t phase)
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
2.34.1

