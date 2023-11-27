Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64012C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 19:55:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E145877FD;
	Mon, 27 Nov 2023 20:53:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XYU3eyZL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A6A387804; Mon, 27 Nov 2023 20:53:26 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57FC6877FB
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 20:53:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-67a12079162so19211956d6.1
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 11:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701114803; x=1701719603; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ejyU/17OA7+LpnQ5DHNeybrJzdfcjbcslmZo3Bl9HiU=;
 b=XYU3eyZLoVh+Er4Oy5LANiaq+fh9ll7jOMCIQ6+8Aj+GjawJJBDtTnEg2cICXKgevh
 81xSaRDPbKXJgCuXyuoXffPQz888dyGdgXjMJv6qnS3GarWoBWBbCHPUulKQwhGwY/C6
 PwD3afeux0ZzbG+eCabn637J5G0Rl4BOh10pXqv+BMppDTmJwr1KbN5RyVIcfStQ6QG8
 0UBaXfi1j56i+kLJMA1E8UMdQFWMydY+nmb44jZNKwVLG8/YOovFEkQygTDkRhzKLhwv
 T5D5T5xxEaudLre9L4IMt4UW7aXLPeOBUN2Z/qOwfKRfQJdytvR3AoYrw8sCY+goTh1d
 aGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701114803; x=1701719603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ejyU/17OA7+LpnQ5DHNeybrJzdfcjbcslmZo3Bl9HiU=;
 b=HtbFztqLQSXu1xftpaoPO1ufAZrzSnYmfo4XXtsfoluNgkigcvUrfOLTur/+T7FMBi
 8jTM7HiW8MHzkzfnnx5Zm8GbHwMka1/G8LGWs5B28UXuhclcxjA3HLe1xdoJPLT53twz
 2iECqXFSSXn8evkoPy8tTEidyMm2Mb4L7Nz92fC6HWSsVpy9sFkNJWxKwD4JBdTv4f2z
 FNc1u/T0Z49/n7U9gz+UZNSHCG/xTDIf/jhKs5rg5wVBvsboOqxkVm1OwzCotiOFW9dc
 Pvu9xh19ueilsZOZ8r5w4cWh8PY8pmnAiTRK2Lqh+RG9ouAUlOz2i1NYxyfTEPNy+pOm
 edow==
X-Gm-Message-State: AOJu0YxNef51pgZ7c0c9ljFdKYDkM9egeG1+G3naCk7wTIdtbsHWtLxs
 Zz6MHZv2iwFiFUawDkhV6wlnLk+FFWCt7seoWLA=
X-Google-Smtp-Source: AGHT+IFTvRh8+gXu7iEKC5mhRX7lYgnyM4gIsW9uQmEx3t71TqEjh8793UuvI6A41qEHt6LPvhQRCQ==
X-Received: by 2002:a05:6214:4b81:b0:67a:3852:288e with SMTP id
 qf1-20020a0562144b8100b0067a3852288emr7321986qvb.27.1701114802782; 
 Mon, 27 Nov 2023 11:53:22 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 g6-20020ad45106000000b0067a2061fc21sm3087047qvp.101.2023.11.27.11.53.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 11:53:22 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de,
	ilias.apalodimas@linaro.org,
	sjg@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Nikhil M Jain <n-jain1@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Baruch Siach <baruch@tkos.co.il>,
 Michal Simek <michal.simek@amd.com>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 15/18] fdt: Allow the devicetree to come from a bloblist
Date: Mon, 27 Nov 2023 11:50:26 -0800
Message-Id: <20231127195029.90951-16-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231127195029.90951-1-raymond.mao@linaro.org>
References: <20231127195029.90951-1-raymond.mao@linaro.org>
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

From: Simon Glass <sjg@chromium.org>

Standard passage provides for a bloblist to be passed from one firmware
phase to the next. That can be used to pass the devicetree along as well.
If CONFIG_OF_BOARD is defined, a board custom routine will provide a
bloblist or a specified memory address to retrieve the devicetree at
runtime.
A devicetree from a bloblist is prioritized than the one from specified
memory region.

Tests for this will be added as part of the Universal Payload work.

Signed-off-by: Simon Glass <sjg@chromium.org>
Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- New patch file created for v2.
  Amended from the original patch
  "[v2,30/32] fdt: Allow the devicetree to come from a bloblist".
  Remove CONFIG_OF_BLOBLIST and FDTSRC_BLOBLIST, a DTB from a previous
  loader is defined by CONFIG_OF_BOARD. The DTB can be located either in the
  bloblist or from a specified memory address.

 doc/develop/devicetree/control.rst |  8 +++--
 dts/Kconfig                        |  9 ++++--
 include/fdtdec.h                   |  3 +-
 lib/fdtdec.c                       | 52 +++++++++++++++++++++++-------
 4 files changed, 53 insertions(+), 19 deletions(-)

diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
index cbb65c9b17..a7f0f87841 100644
--- a/doc/develop/devicetree/control.rst
+++ b/doc/develop/devicetree/control.rst
@@ -104,9 +104,11 @@ in u-boot.bin so you can still just flash u-boot.bin onto your board. If you are
 using CONFIG_SPL_FRAMEWORK, then u-boot.img will be built to include the device
 tree binary.
 
-If CONFIG_OF_BOARD is defined, a board-specific routine will provide the
-devicetree at runtime, for example if an earlier bootloader stage creates
-it and passes it to U-Boot.
+If CONFIG_OF_BOARD is defined, a board-specific routine will provide a bloblist
+or a specified memory region to retrieve the devicetree at runtime, for example
+if an earlier bootloader stage creates it and passes it to U-Boot.
+A devicetree from a bloblist is prioritized than the one from a specified memory
+region.
 
 If CONFIG_SANDBOX is defined, then it will be read from a file on
 startup. Use the -d flag to U-Boot to specify the file to read, -D for the
diff --git a/dts/Kconfig b/dts/Kconfig
index 00c0aeff89..4faf4ba633 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -110,8 +110,13 @@ config OF_BOARD
 	default y if SANDBOX || OF_HAS_PRIOR_STAGE
 	help
 	  If this option is enabled, the device tree is provided at runtime by
-	  a custom function called board_fdt_blob_setup(). The board must
-	  implement this function if it wishes to provide special behaviour.
+	  bloblist via a custom function called board_bloblist_from_boot_arg()
+	  or a memory region from a custom function called
+	  board_fdt_blob_setup(). The board must implement either these
+	  functions if it wishes to provide special behaviour.
+
+	  A devicetree from a bloblist is prioritized then the one from a
+	  specified memory region if the board provides both methods.
 
 	  With this option, the device tree build by U-Boot may be overridden or
 	  ignored. See OF_HAS_PRIOR_STAGE.
diff --git a/include/fdtdec.h b/include/fdtdec.h
index bd1149f46d..0824fe1359 100644
--- a/include/fdtdec.h
+++ b/include/fdtdec.h
@@ -72,14 +72,13 @@ struct bd_info;
  *	U-Boot is packaged as an ELF file, e.g. for debugging purposes
  * @FDTSRC_ENV: Provided by the fdtcontroladdr environment variable. This should
  *	be used for debugging/development only
- * @FDTSRC_NONE: No devicetree at all
  */
 enum fdt_source_t {
 	FDTSRC_SEPARATE,
 	FDTSRC_FIT,
 	FDTSRC_BOARD,
 	FDTSRC_EMBED,
-	FDTSRC_ENV,
+	FDTSRC_ENV
 };
 
 /*
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index 7a69167648..025baca4a4 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -7,7 +7,11 @@
  */
 
 #ifndef USE_HOSTCC
+
+#define LOG_CATEGORY	LOGC_DT
+
 #include <common.h>
+#include <bloblist.h>
 #include <boot_fit.h>
 #include <display_options.h>
 #include <dm.h>
@@ -86,7 +90,7 @@ static const char *const fdt_src_name[] = {
 	[FDTSRC_FIT] = "fit",
 	[FDTSRC_BOARD] = "board",
 	[FDTSRC_EMBED] = "embed",
-	[FDTSRC_ENV] = "env",
+	[FDTSRC_ENV] = "env"
 };
 
 const char *fdtdec_get_srcname(void)
@@ -1665,21 +1669,45 @@ int fdtdec_setup(void)
 {
 	int ret;
 
-	/* The devicetree is typically appended to U-Boot */
-	if (IS_ENABLED(CONFIG_OF_SEPARATE)) {
-		gd->fdt_blob = fdt_find_separate();
-		gd->fdt_src = FDTSRC_SEPARATE;
-	} else { /* embed dtb in ELF file for testing / development */
-		gd->fdt_blob = dtb_dt_embedded();
-		gd->fdt_src = FDTSRC_EMBED;
-	}
-
-	/* Allow the board to override the fdt address. */
+	/*
+	 * The devicetree is typically appended to U-Boot.
+	 * Option 1: From bloblist.
+	 * Option 2: From a specified memory address.
+	 */
 	if (IS_ENABLED(CONFIG_OF_BOARD)) {
-		gd->fdt_blob = board_fdt_blob_setup(&ret);
+		/*
+		 * DTB is from board.
+		 * Either from bloblist or a platform specified memory.
+		 */
+		ret = bloblist_maybe_init();
 		if (ret)
 			return ret;
+
+		/* Check if a DTB exists in bloblist first */
+		if (IS_ENABLED(CONFIG_BLOBLIST)) {
+			gd->fdt_blob = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
+			if (gd->fdt_blob) {
+				log_info("Fdt from bloblist at 0x%lx\n",
+					 (unsigned long)gd->fdt_blob);
+			}
+		}
+		if (!gd->fdt_blob) {
+			/* Apply DTB from a platform specified memory */
+			gd->fdt_blob = board_fdt_blob_setup(&ret);
+			if (ret)
+				return ret;
+			log_info("Fdt from memory at 0x%lx\n",
+				 (unsigned long)gd->fdt_blob);
+		}
 		gd->fdt_src = FDTSRC_BOARD;
+	} else {
+		if (IS_ENABLED(CONFIG_OF_SEPARATE)) {
+			gd->fdt_blob = fdt_find_separate();
+			gd->fdt_src = FDTSRC_SEPARATE;
+		} else { /* embed dtb in ELF file for testing / development */
+			gd->fdt_blob = dtb_dt_embedded();
+			gd->fdt_src = FDTSRC_EMBED;
+		}
 	}
 
 	/* Allow the early environment to override the fdt address */
-- 
2.25.1

