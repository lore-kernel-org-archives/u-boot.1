Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74332C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 19:48:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52504879FF;
	Thu, 28 Dec 2023 20:48:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PHCU7mQY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 018DF879FF; Thu, 28 Dec 2023 20:48:06 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 921D887A01
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 20:47:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40d5aa35b60so22076105e9.0
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 11:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703792878; x=1704397678; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8b0SFvIriQu94uzJSZKZR+40PCsBG+7zMCB4GXTieMw=;
 b=PHCU7mQY7CBaqzmFlXXRq1WN5L8F4Ufy1gKUz/PEok1d6KfNpm7ghy+ATgAfK9wpdD
 zoQM1JTxjIhheRn1kcLxECtrVFaqGtP2NzjvjM+ufxoLDuR/KLudNVfmNdmS3/93pOlh
 geMK4Pd6WCVd39ODxnElgLHTgeNdFWSsMVIIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703792878; x=1704397678;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8b0SFvIriQu94uzJSZKZR+40PCsBG+7zMCB4GXTieMw=;
 b=NcfSLd5VwtCq8+kBG5Jc63HhyLffGDlBKfpEaiBs1jzs7oIp4RQyr63REoswH0Lwzv
 wnW6SsOBQ9hU7KXi1mF4ec3YsBRgxuRSQHcirvgcVquopqKbJQJ4VokAHsjyfddzGo7O
 Iobc9/4eeXuaYVuGy8Ucp7YMySG9bjJ2nVD94ti+2Dr1QgZTrkqBjK3LBxYeNcABc3GW
 Zx+OLvdNRR70H4lP2MNqjwrFTT7AqRDiYU0pmYEctB/z7Rvi1jychbTXI3HO+rey8zb6
 XctcLXosZ425n+VJ/IuMTgvH7H79WtmvMGqtEtoyK5coWPIFBoc85XKBsq2CLBIgVrP/
 tuuw==
X-Gm-Message-State: AOJu0Yz5/rsMr+isprzwNlzhaYJfiVbX8M7/PSt+Fc2KDbimxKMem78g
 WlG2r7JzL31in7uNDIG6htAO9A/mWkIpzerMDrgzmzmvlw==
X-Google-Smtp-Source: AGHT+IENJ5KB+uZ5T/bvRrbF0PD+hzjNcLRhJAkP+KerKjlcC/kVmHA4Cs+m5lvNnzSXsFWe0p9j1g==
X-Received: by 2002:a05:600c:3d85:b0:40d:5575:a17f with SMTP id
 bi5-20020a05600c3d8500b0040d5575a17fmr2015075wmb.128.1703792877651; 
 Thu, 28 Dec 2023 11:47:57 -0800 (PST)
Received: from tasman.chapterst.org (80-42-48-87.dynamic.dsl.as9105.com.
 [80.42.48.87]) by smtp.gmail.com with ESMTPSA id
 p2-20020a05600c1d8200b0040596352951sm37337685wms.5.2023.12.28.11.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 11:47:57 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Raymond Mao <raymond.mao@linaro.org>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Baruch Siach <baruch@tkos.co.il>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerry Van Baren <vanbaren@cideas.com>, Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nikhil M Jain <n-jain1@ti.com>,
 Qu Wenruo <wqu@suse.com>, Sean Anderson <seanga2@gmail.com>,
 Stefan Roese <sr@denx.de>
Subject: [PATCH v6] fdt: Allow the devicetree to come from a bloblist
Date: Thu, 28 Dec 2023 19:47:25 +0000
Message-Id: <20231228194725.2482268-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

Standard passage provides for a bloblist to be passed from one firmware
phase to the next. That can be used to pass the devicetree along as well.
Add an option to support this.

Tests for this will be added as part of the Universal Payload work.

Signed-off-by: Simon Glass <sjg@chromium.org>
---
The discussion on this was not resolved and is now important due to the
bloblist series from Raymond. So I am sending it again since I believe
this is a better starting point than building on OF_BOARD

Changes in v6:
- Don't allow bloblist with OF_EMBED

Changes in v5:
- Make OF_BLOBLIST default y
- Make OF_BLOBLIST optional at runtime

Changes in v4:
- Rebase to -next

 common/bloblist.c                  |  1 +
 doc/develop/devicetree/control.rst |  3 ++
 dts/Kconfig                        | 13 +++++++++
 include/bloblist.h                 |  5 ++++
 include/fdtdec.h                   |  6 ++--
 lib/fdtdec.c                       | 44 +++++++++++++++++++++++-------
 6 files changed, 60 insertions(+), 12 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index a22f6c12b0c..b07ede11cfe 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -48,6 +48,7 @@ static struct tag_name {
 	{ BLOBLISTT_ACPI_TABLES, "ACPI tables for x86" },
 	{ BLOBLISTT_SMBIOS_TABLES, "SMBIOS tables for x86" },
 	{ BLOBLISTT_VBOOT_CTX, "Chrome OS vboot context" },
+	{ BLOBLISTT_CONTROL_FDT, "Control FDT" },
 
 	/* BLOBLISTT_PROJECT_AREA */
 	{ BLOBLISTT_U_BOOT_SPL_HANDOFF, "SPL hand-off" },
diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
index cbb65c9b177..444c55de4e4 100644
--- a/doc/develop/devicetree/control.rst
+++ b/doc/develop/devicetree/control.rst
@@ -108,6 +108,9 @@ If CONFIG_OF_BOARD is defined, a board-specific routine will provide the
 devicetree at runtime, for example if an earlier bootloader stage creates
 it and passes it to U-Boot.
 
+If CONFIG_OF_BLOBLIST is defined, the devicetree comes from a bloblist passed
+from a previous stage, if present.
+
 If CONFIG_SANDBOX is defined, then it will be read from a file on
 startup. Use the -d flag to U-Boot to specify the file to read, -D for the
 default and -T for the test devicetree, used to run sandbox unit tests.
diff --git a/dts/Kconfig b/dts/Kconfig
index 00c0aeff893..ae451b9caf7 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -105,6 +105,19 @@ config OF_EMBED
 
 endchoice
 
+config OF_BLOBLIST
+	bool "Provided by a bloblist at runtime"
+	depends on BLOBLIST && OF_SEPARATE
+	default y
+	help
+	  Select this to read the devicetree from the bloblist. This allows
+	  using a bloblist to transfer the devicetree between  U-Boot phases.
+	  The devicetree is stored in the bloblist by an early phase so that
+	  U-Boot can read it.
+
+	  If the bloblist does not contain a devicetree, then other methods will
+	  be used.
+
 config OF_BOARD
 	bool "Provided by the board (e.g a previous loader) at runtime"
 	default y if SANDBOX || OF_HAS_PRIOR_STAGE
diff --git a/include/bloblist.h b/include/bloblist.h
index 080cc46a126..e16d122f4fb 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -103,6 +103,11 @@ enum bloblist_tag_t {
 	BLOBLISTT_ACPI_TABLES = 0x104,	/* ACPI tables for x86 */
 	BLOBLISTT_SMBIOS_TABLES = 0x105, /* SMBIOS tables for x86 */
 	BLOBLISTT_VBOOT_CTX = 0x106,	/* Chromium OS verified boot context */
+	/*
+	 * Devicetree for use by firmware. On some platforms this is passed to
+	 * the OS also
+	 */
+	BLOBLISTT_CONTROL_FDT = 0x107,
 
 	/*
 	 * Project-specific tags are permitted here. Projects can be open source
diff --git a/include/fdtdec.h b/include/fdtdec.h
index bd1149f46d0..e80de24076c 100644
--- a/include/fdtdec.h
+++ b/include/fdtdec.h
@@ -72,7 +72,7 @@ struct bd_info;
  *	U-Boot is packaged as an ELF file, e.g. for debugging purposes
  * @FDTSRC_ENV: Provided by the fdtcontroladdr environment variable. This should
  *	be used for debugging/development only
- * @FDTSRC_NONE: No devicetree at all
+ * @FDTSRC_BLOBLIST: Provided by a bloblist from an earlier phase
  */
 enum fdt_source_t {
 	FDTSRC_SEPARATE,
@@ -80,6 +80,7 @@ enum fdt_source_t {
 	FDTSRC_BOARD,
 	FDTSRC_EMBED,
 	FDTSRC_ENV,
+	FDTSRC_BLOBLIST,
 };
 
 /*
@@ -1190,7 +1191,8 @@ int fdtdec_resetup(int *rescan);
  *
  * The existing devicetree is available at gd->fdt_blob
  *
- * @err internal error code if we fail to setup a DTB
+ * @err: 0 on success, -EEXIST if the devicetree is already correct, or other
+ * internal error code if we fail to setup a DTB
  * @returns new devicetree blob pointer
  */
 void *board_fdt_blob_setup(int *err);
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index 4016bf3c113..af3026dd42b 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -7,6 +7,10 @@
  */
 
 #ifndef USE_HOSTCC
+
+#define LOG_CATEGORY	LOGC_DT
+
+#include <bloblist.h>
 #include <boot_fit.h>
 #include <display_options.h>
 #include <dm.h>
@@ -86,6 +90,7 @@ static const char *const fdt_src_name[] = {
 	[FDTSRC_BOARD] = "board",
 	[FDTSRC_EMBED] = "embed",
 	[FDTSRC_ENV] = "env",
+	[FDTSRC_BLOBLIST] = "bloblist",
 };
 
 const char *fdtdec_get_srcname(void)
@@ -1662,23 +1667,42 @@ static void setup_multi_dtb_fit(void)
 
 int fdtdec_setup(void)
 {
-	int ret;
+	int ret = -ENOENT;
+
+	/* If allowing a bloblist, check that first */
+	if (CONFIG_IS_ENABLED(OF_BLOBLIST)) {
+		ret = bloblist_maybe_init();
+		if (!ret) {
+			gd->fdt_blob = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
+			if (gd->fdt_blob) {
+				gd->fdt_src = FDTSRC_BLOBLIST;
+				log_debug("Devicetree is in bloblist at %p\n",
+					  gd->fdt_blob);
+			} else {
+				log_debug("No FDT found in bloblist\n");
+				ret = -ENOENT;
+			}
+		}
+	}
 
-	/* The devicetree is typically appended to U-Boot */
-	if (IS_ENABLED(CONFIG_OF_SEPARATE)) {
-		gd->fdt_blob = fdt_find_separate();
-		gd->fdt_src = FDTSRC_SEPARATE;
-	} else { /* embed dtb in ELF file for testing / development */
-		gd->fdt_blob = dtb_dt_embedded();
-		gd->fdt_src = FDTSRC_EMBED;
+	/* Otherwise, the devicetree is typically appended to U-Boot */
+	if (ret) {
+		if (IS_ENABLED(CONFIG_OF_SEPARATE)) {
+			gd->fdt_blob = fdt_find_separate();
+			gd->fdt_src = FDTSRC_SEPARATE;
+		} else { /* embed dtb in ELF file for testing / development */
+			gd->fdt_blob = dtb_dt_embedded();
+			gd->fdt_src = FDTSRC_EMBED;
+		}
 	}
 
 	/* Allow the board to override the fdt address. */
 	if (IS_ENABLED(CONFIG_OF_BOARD)) {
 		gd->fdt_blob = board_fdt_blob_setup(&ret);
-		if (ret)
+		if (!ret)
+			gd->fdt_src = FDTSRC_BOARD;
+		else if (ret != -EEXIST)
 			return ret;
-		gd->fdt_src = FDTSRC_BOARD;
 	}
 
 	/* Allow the early environment to override the fdt address */
-- 
2.34.1

