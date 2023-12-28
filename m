Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93DDEC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 13:41:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF87F876CA;
	Thu, 28 Dec 2023 14:39:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SkfRmLnk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D06BC87A06; Thu, 28 Dec 2023 14:39:06 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCB1187A3B
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 14:39:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40d5adef341so19203305e9.3
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 05:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703770743; x=1704375543; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gI2XCqFWBcZnUrKYK7hdhVv+5mPnIGL9ZpRCezrzXq4=;
 b=SkfRmLnkVWQ9LhG0AxhInt5lRCiYCJyebdmaOZuQzID2SYLeJK39xzxI9yS/C7flls
 woDSwvPClcLduUrLzbvOtOjFbuJIEGUbcOpyFeky45ycRt+01QAK0a5pWu1M7ZkXmfUw
 nvjLWEXbRgva5ke+bshrDmfrDmLvEI2OX25Bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703770743; x=1704375543;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gI2XCqFWBcZnUrKYK7hdhVv+5mPnIGL9ZpRCezrzXq4=;
 b=w2acBnccaIdViGIHtKupjhMcDz/6mzuVGilP80dC5LLh4x4SH4lR0OubTtjDP/g3ZU
 KduozQtstfwl4OLiBtw883ycNj8C/jThLn/V8ORQ82mh9TMeINRtqB2+F9rt7nvX6Q4G
 +dwWu4K3slsstEn54mAhwBlGu5p01ulx2dhL4QVNikPctCeDP3jjJh0qONou7w3LlA2K
 Rl9FMgVm7xNyEkYQgN52suBoCfklVqLQZxC0HpMZxIMlIOjLwosR/j2ZWTxqhPq50+14
 mt9Nz9aCTKMRX6+XrnaNcLmmGIFSr4uswB9fJVs3eAbvX3Z6Kfoj5LmAyYGJ3n6rMcr3
 YXpg==
X-Gm-Message-State: AOJu0YzSZbKyKf6ybSt6W5AZhJ6NFwHTYGkGrjBWt0TOBxx9Q6t2hsdW
 Km0oqjwrz18SFuvB1igT3fzIUhj2FLhxnKLgX7LBuvhxBA==
X-Google-Smtp-Source: AGHT+IGQWeXIzq4lkPfHVl4UEVdUcNuJ/OwplAfDPSD+BU3e0zfQ1sPQ29Pynp48T7XfR6SnU6+I4Q==
X-Received: by 2002:a05:600c:19d1:b0:40d:5f5b:48a6 with SMTP id
 u17-20020a05600c19d100b0040d5f5b48a6mr622016wmq.102.1703770742574; 
 Thu, 28 Dec 2023 05:39:02 -0800 (PST)
Received: from tasman.chapterst.org (80-42-48-87.dynamic.dsl.as9105.com.
 [80.42.48.87]) by smtp.gmail.com with ESMTPSA id
 m5-20020adfe945000000b003366c058509sm17096421wrn.23.2023.12.28.05.39.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 05:39:02 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Baruch Siach <baruch@tkos.co.il>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerry Van Baren <vanbaren@cideas.com>, Michal Simek <michal.simek@amd.com>,
 Nikhil M Jain <n-jain1@ti.com>, Qu Wenruo <wqu@suse.com>,
 Sean Anderson <seanga2@gmail.com>, Stefan Roese <sr@denx.de>
Subject: [PATCH v5] fdt: Allow the devicetree to come from a bloblist
Date: Thu, 28 Dec 2023 13:36:54 +0000
Message-Id: <20231228133654.2356023-1-sjg@chromium.org>
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
index 00c0aeff893..352431d59a3 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -105,6 +105,19 @@ config OF_EMBED
 
 endchoice
 
+config OF_BLOBLIST
+	bool "Provided by a bloblist at runtime"
+	depends on BLOBLIST
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

