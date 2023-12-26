Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB577C46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:46:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C34487831;
	Tue, 26 Dec 2023 10:46:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GJB7o1SU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FBA78781A; Tue, 26 Dec 2023 10:46:31 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37F8587835
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:46:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3368b9bbeb4so3595889f8f.2
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703583988; x=1704188788; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=a+7wJSHke+nf0x3T4ywcnyPxlecC395QxFk5vRlPQg4=;
 b=GJB7o1SU+k0jP1sLLq/nM3MB4zbYZ1VlsgUcICCwH8ndnyYdsMegdwU1pW51W1YDqJ
 BUKMms3mi0nenmzFnMPpZe0cccIy3AkyVTz1RsVyBGS6Duk2ImuA9buBMFlvoUZPiF9q
 QK8M8PAxRfoWzZpRgy+yggmabLhFeCLWf6MN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703583988; x=1704188788;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a+7wJSHke+nf0x3T4ywcnyPxlecC395QxFk5vRlPQg4=;
 b=S6DVv9pLL2pUIuDksClEG0J5KmunfPTnPAeVPb6iponNfp5PWUw91aOgC+Skxp/Qx+
 Pec9psY/rW8VQb63yyZeAmgp3yrOVN2W/QwHK42L4+DOQQwQRwFlzjMdBemQpeNX+tGu
 EZh68ZRRWeheqDY8DzhsXjafr/oadThar651VpbuU3OHJZQ4WrPsNKiNJ7Of00PSgYgy
 ioI3whWHktW+zPmrrshj3bON3nSLuCjp9xhCy5RO6KM8ayktKAGTt/zdTnYk1Iyq36c9
 ZSwJYGYEyV3mWcRvNKdCYF/k83lzbJLKUFDocC8Grown8GyVcSiChVZ3lKmyLA67dwFu
 W+GA==
X-Gm-Message-State: AOJu0YwV+rI+12YHejOomR8oljmu7UD9p7s97DuOUtUq9HEQAk0eV0F5
 asqtJcC3nJhrV9T++pnGdcGY9AB6T8okgNzwcOq6lgGEv5VY
X-Google-Smtp-Source: AGHT+IHN3L7gqltB1J3YYyLn2Wk4NrIaETOR9SG+TOWudUqE3058niVWSTMDFmafN3ug3owEwDGDJQ==
X-Received: by 2002:a05:600c:450c:b0:40d:4dc7:1399 with SMTP id
 t12-20020a05600c450c00b0040d4dc71399mr1633068wmo.110.1703583988022; 
 Tue, 26 Dec 2023 01:46:28 -0800 (PST)
Received: from tasman.chapterst.org (80-42-48-87.dynamic.dsl.as9105.com.
 [80.42.48.87]) by smtp.gmail.com with ESMTPSA id
 iw11-20020a05600c54cb00b0040b3515cdf8sm19822317wmb.7.2023.12.26.01.46.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 01:46:27 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Baruch Siach <baruch@tkos.co.il>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerry Van Baren <vanbaren@cideas.com>, Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nikhil M Jain <n-jain1@ti.com>,
 Qu Wenruo <wqu@suse.com>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v4] fdt: Allow the devicetree to come from a bloblist
Date: Tue, 26 Dec 2023 09:46:25 +0000
Message-Id: <20231226094625.221671-1-sjg@chromium.org>
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

Changes in v4:
- Rebase to -next

 common/bloblist.c                  |  1 +
 doc/develop/devicetree/control.rst |  3 ++
 dts/Kconfig                        |  8 ++++++
 include/bloblist.h                 |  5 ++++
 include/fdtdec.h                   |  3 +-
 lib/fdtdec.c                       | 44 ++++++++++++++++++++++--------
 6 files changed, 51 insertions(+), 13 deletions(-)

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
index cbb65c9b177..56e00090166 100644
--- a/doc/develop/devicetree/control.rst
+++ b/doc/develop/devicetree/control.rst
@@ -108,6 +108,9 @@ If CONFIG_OF_BOARD is defined, a board-specific routine will provide the
 devicetree at runtime, for example if an earlier bootloader stage creates
 it and passes it to U-Boot.
 
+If CONFIG_OF_BLOBLIST is defined, the devicetree comes from a bloblist passed
+from a previous stage.
+
 If CONFIG_SANDBOX is defined, then it will be read from a file on
 startup. Use the -d flag to U-Boot to specify the file to read, -D for the
 default and -T for the test devicetree, used to run sandbox unit tests.
diff --git a/dts/Kconfig b/dts/Kconfig
index 00c0aeff893..2d02bccf4fc 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -105,6 +105,14 @@ config OF_EMBED
 
 endchoice
 
+config OF_BLOBLIST
+	bool "DTB is provided by a bloblist"
+	help
+	  Select this to read the devicetree from the bloblist. This allows
+	  using a bloblist to transfer the devicetree between  U-Boot phases.
+	  The devicetree is stored in the bloblist by an early phase so that
+	  U-Boot can read it.
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
index bd1149f46d0..1888c464561 100644
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
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index 4016bf3c113..6bd4a0c03a4 100644
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
@@ -1665,20 +1670,35 @@ int fdtdec_setup(void)
 	int ret;
 
 	/* The devicetree is typically appended to U-Boot */
-	if (IS_ENABLED(CONFIG_OF_SEPARATE)) {
-		gd->fdt_blob = fdt_find_separate();
-		gd->fdt_src = FDTSRC_SEPARATE;
-	} else { /* embed dtb in ELF file for testing / development */
-		gd->fdt_blob = dtb_dt_embedded();
-		gd->fdt_src = FDTSRC_EMBED;
-	}
-
-	/* Allow the board to override the fdt address. */
-	if (IS_ENABLED(CONFIG_OF_BOARD)) {
-		gd->fdt_blob = board_fdt_blob_setup(&ret);
+	if (CONFIG_IS_ENABLED(OF_BLOBLIST)) {
+		ret = bloblist_maybe_init();
 		if (ret)
 			return ret;
-		gd->fdt_src = FDTSRC_BOARD;
+		gd->fdt_blob = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
+		if (!gd->fdt_blob) {
+			printf("Not FDT found in bloblist\n");
+			bloblist_show_list();
+			return -ENOENT;
+		}
+		gd->fdt_src = FDTSRC_BLOBLIST;
+		bloblist_show_list();
+		log_debug("Devicetree is in bloblist at %p\n", gd->fdt_blob);
+	} else {
+		if (IS_ENABLED(CONFIG_OF_SEPARATE)) {
+			gd->fdt_blob = fdt_find_separate();
+			gd->fdt_src = FDTSRC_SEPARATE;
+		} else { /* embed dtb in ELF file for testing / development */
+			gd->fdt_blob = dtb_dt_embedded();
+			gd->fdt_src = FDTSRC_EMBED;
+		}
+
+		/* Allow the board to override the fdt address. */
+		if (IS_ENABLED(CONFIG_OF_BOARD)) {
+			gd->fdt_blob = board_fdt_blob_setup(&ret);
+			if (ret)
+				return ret;
+			gd->fdt_src = FDTSRC_BOARD;
+		}
 	}
 
 	/* Allow the early environment to override the fdt address */
-- 
2.34.1

