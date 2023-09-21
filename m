Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E497ACD4938
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 02:02:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFEB686D69;
	Thu, 21 Sep 2023 03:58:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lzmgw2V4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 726C486D9B; Thu, 21 Sep 2023 03:58:29 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21D8986D58
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:58:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-34fe2814b0dso1497865ab.3
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695261497; x=1695866297; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zpeBRXqrjaFAnOyGLGLwyYcXtyYYcgmf7eX5cS6N2EY=;
 b=lzmgw2V4oWxNS0mdnMGVZv+8OjF2P86oNSoUQwj3VwmjgH7tKcjwzTcUo2+wEeYhC5
 3KAlTTZDTaT9jJBvpF29w43n/pXL3k3DnaezhHm4H7ggaEWRCdfPFQQdJ/n+uJKRS6il
 wfC7KLxlpietvDfCryTz+8klDGyZhm4OQJ5M8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695261497; x=1695866297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zpeBRXqrjaFAnOyGLGLwyYcXtyYYcgmf7eX5cS6N2EY=;
 b=CVSIHaVbTQB9ATohNW1D71a5OQ3wNExqr4AaWhPX5rePPgymDje6L2AIpjhDEDnDv0
 4K3uYJHzqZYw5tR6W+NWbH6eqtMbmmZEPWc02Ga0b6lI9xRfriU+14qACPKz6mNJlGOj
 +jyWQ/QDwv2lX2F8EveV540DG9DnChjHppnIUZ55AQ6BKQLxNtwRUq0wsMTf/gQ83J2u
 47jTYFlcF7UTojW/E6U8AToMe0uit2dhvlByAbyrcX5JIQMeL64SLRtr3hfUGBjT/h5z
 A1vyAHHGmFJGp/hhn2xbtAHLOa3JhXL73Dd9q0wAO2hvzsG9quz54u8DIil/L4gKjdAo
 ReTQ==
X-Gm-Message-State: AOJu0Yybooufou9RqGxZ+hPvxoZDHLnklPuUExLYcAmvXybfV7zGR7+V
 La91zyUKPwjMBWx88D/pQW/JtMOW2W/WYbXG624=
X-Google-Smtp-Source: AGHT+IHGfm63CimQRV5OLmKeHW6w5jNAud8Fh2ChhnKwR4HGCP5gk8bfFCvsiqR6Uzx4Zo4PR3etvg==
X-Received: by 2002:a05:6e02:cb1:b0:348:ac7f:69a2 with SMTP id
 17-20020a056e020cb100b00348ac7f69a2mr4427282ilg.15.1695261497707; 
 Wed, 20 Sep 2023 18:58:17 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 y4-20020a02c004000000b00437c3a7b49dsm85317jai.156.2023.09.20.18.58.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 18:58:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Baruch Siach <baruch@tkos.co.il>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerry Van Baren <vanbaren@cideas.com>, Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nikhil M Jain <n-jain1@ti.com>,
 Qu Wenruo <wqu@suse.com>
Subject: [PATCH v2 30/32] fdt: Allow the devicetree to come from a bloblist
Date: Wed, 20 Sep 2023 19:57:19 -0600
Message-ID: <20230921015730.1511373-31-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230921015730.1511373-1-sjg@chromium.org>
References: <20230921015730.1511373-1-sjg@chromium.org>
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

Changes in v2:
- No changes as it still seems unclear what should be done

 common/bloblist.c                  |  2 ++
 doc/develop/devicetree/control.rst |  3 ++
 dts/Kconfig                        |  8 ++++++
 include/bloblist.h                 |  5 ++++
 include/fdtdec.h                   |  3 +-
 lib/fdtdec.c                       | 44 ++++++++++++++++++++++--------
 6 files changed, 52 insertions(+), 13 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 6f2a4577708d..b07ede11cfe2 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -48,9 +48,11 @@ static struct tag_name {
 	{ BLOBLISTT_ACPI_TABLES, "ACPI tables for x86" },
 	{ BLOBLISTT_SMBIOS_TABLES, "SMBIOS tables for x86" },
 	{ BLOBLISTT_VBOOT_CTX, "Chrome OS vboot context" },
+	{ BLOBLISTT_CONTROL_FDT, "Control FDT" },
 
 	/* BLOBLISTT_PROJECT_AREA */
 	{ BLOBLISTT_U_BOOT_SPL_HANDOFF, "SPL hand-off" },
+	{ BLOBLISTT_VBE, "VBE" },
 	{ BLOBLISTT_U_BOOT_VIDEO, "SPL video handoff" },
 
 	/* BLOBLISTT_VENDOR_AREA */
diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
index cbb65c9b177f..56e00090166f 100644
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
index 9152f5885e9a..6c1edbddb57b 100644
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
index 080cc46a1266..e16d122f4fb1 100644
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
index bd1149f46d08..1888c4645619 100644
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
index 7a6916764835..bd88e6a418eb 100644
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
@@ -87,6 +91,7 @@ static const char *const fdt_src_name[] = {
 	[FDTSRC_BOARD] = "board",
 	[FDTSRC_EMBED] = "embed",
 	[FDTSRC_ENV] = "env",
+	[FDTSRC_BLOBLIST] = "bloblist",
 };
 
 const char *fdtdec_get_srcname(void)
@@ -1666,20 +1671,35 @@ int fdtdec_setup(void)
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
2.42.0.515.g380fc7ccd1-goog

