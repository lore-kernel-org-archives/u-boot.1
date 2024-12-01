Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DAFD49771
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 14:44:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC5E5893D0;
	Sun,  1 Dec 2024 15:43:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Wr4ig2WN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43B5F8912B; Sun,  1 Dec 2024 15:43:08 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 978A689138
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 15:43:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-84192e4788dso107088539f.2
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 06:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733064181; x=1733668981; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AdL46tOHw7gGRLskG/vSnt14kZdIX8KQrNa7Rz5EOH4=;
 b=Wr4ig2WNHn63RQgm6a9rhf4sdfwQV7TW0yuYQVOhlIDs1JkwObylJP78erC4+/QINR
 vzRtBjBn2SJZ0Ohz2h3feGE9iEdp7b5SLwOM96V1NITcZKikthAWx/OBqIEUsdhlv+Wj
 np0or6gryMXJ42HmGi+Uvqj8FPttdVIfwthk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733064181; x=1733668981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AdL46tOHw7gGRLskG/vSnt14kZdIX8KQrNa7Rz5EOH4=;
 b=K+9xvGQdLBquL4kCy4MoFyRl085fqt460PK0Nm90hRGcd+yXzykBTIjfG1aB6Ys99G
 ZTLWaVlatawoY3zBeoDjL6gTkP4wIYywn12q7zCX5ihTIavLRdm/xlMbgOQAdJYSQ5Gn
 A0QMZEQuvZnk5OnjYEviWY5pIxGRITzKuJjapZmhvjGfvD0Vjzy6ECotSLHCKDjg1ekX
 +vR5+LIL/t/L38WDdMZSbmkBZe6q63x6CKUmfmlQmNICih0GeV7XDFPG8kDWTGxTPZHh
 ng/gIjEy5+CYupv9WXo64lQ+F0a9xO6wSKib9W5s/5CAa7sIedVrF6DZ6fLWfBsZOa3T
 8o3Q==
X-Gm-Message-State: AOJu0Ywmp6En9TDUr7x1u1/s4KkhZddfyvUMq+RnxeCWvplHqVUSMj9N
 FgwWsf1dRBZ6VZoX+RaQOEAfZCBj4t77ofAA3kmekuGOkw4Y6N5W05lRZ/rFM0FBCjSpU2J7P9w
 =
X-Gm-Gg: ASbGncsdsLg7FssOg6jJyjGgRiMctZagnlFDrJjv6bcXIR6cS8SLzy/MTMoZ2fXS8aw
 OOmLJ1I0dyrwZMLyjq9iudKzbEAlKlzJ4CqaXGB7EjewkZtpWP5BUUjaSJb4+idijIh9vH/VVFt
 cHnvsI9Oe9lsGjT9UmGzmvTgNiRU4GcLeZ9WznLO9F/gHHUA6uLkUk5Zt1VFg0/50QS6tDDFi+J
 omaWTcRHLni3ztREjO1tS1Dww5BF993SzbwuAHjVML+
X-Google-Smtp-Source: AGHT+IF2zzxcGnLjSS48srQGbjpf4DZ578QV2kAv9BZ5Aosjz8SsulER6EJ9MbrgisP6hwusfeYS4A==
X-Received: by 2002:a05:6602:2d8f:b0:83a:ab63:20b with SMTP id
 ca18e2360f4ac-843ecec8bd5mr2349339439f.4.1733064180765; 
 Sun, 01 Dec 2024 06:43:00 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405ec8755sm160826839f.17.2024.12.01.06.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 06:42:59 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 mason1920 <mason1920@use.startmail.com>
Subject: [PATCH 4/8] Revert "fdt: Allow the devicetree to come from a bloblist"
Date: Sun,  1 Dec 2024 07:42:32 -0700
Message-ID: <20241201144240.1664398-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201144240.1664398-1-sjg@chromium.org>
References: <20241201144240.1664398-1-sjg@chromium.org>
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

This stops coral, bob and kevin from booting.

The correct way to do this was always to use a Kconfig option, so let's
first revert this broken idea.

This reverts commit 70fe23859437ffe4efe0793423937d8b78ebf9d6.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/develop/devicetree/control.rst |  5 +---
 include/fdtdec.h                   |  6 ++--
 lib/fdtdec.c                       | 45 +++++++-----------------------
 3 files changed, 13 insertions(+), 43 deletions(-)

diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
index 0233945f8b6..2a3b48fa6c7 100644
--- a/doc/develop/devicetree/control.rst
+++ b/doc/develop/devicetree/control.rst
@@ -137,10 +137,7 @@ If `OF_BOARD` is selected by Kconfig, a board-specific routine will provide the
 devicetree at runtime, for example if an earlier bootloader stage creates
 it and passes it to U-Boot.
 
-If `BLOBLIST` is selected by Kconfig, the devicetree may come from a bloblist
-passed from a previous stage, if present.
-
-If `SANDBOX` is selected by Kconfig, then it will be read from a file on
+If CONFIG_SANDBOX is defined, then it will be read from a file on
 startup. Use the -d flag to U-Boot to specify the file to read, -D for the
 default and -T for the test devicetree, used to run sandbox unit tests.
 
diff --git a/include/fdtdec.h b/include/fdtdec.h
index 555c9520379..8f25e1b7e92 100644
--- a/include/fdtdec.h
+++ b/include/fdtdec.h
@@ -72,7 +72,7 @@ struct bd_info;
  *	U-Boot is packaged as an ELF file, e.g. for debugging purposes
  * @FDTSRC_ENV: Provided by the fdtcontroladdr environment variable. This should
  *	be used for debugging/development only
- * @FDTSRC_BLOBLIST: Provided by a bloblist from an earlier phase
+ * @FDTSRC_NONE: No devicetree at all
  */
 enum fdt_source_t {
 	FDTSRC_SEPARATE,
@@ -80,7 +80,6 @@ enum fdt_source_t {
 	FDTSRC_BOARD,
 	FDTSRC_EMBED,
 	FDTSRC_ENV,
-	FDTSRC_BLOBLIST,
 };
 
 /*
@@ -1191,8 +1190,7 @@ int fdtdec_resetup(int *rescan);
  *
  * The existing devicetree is available at gd->fdt_blob
  *
- * @err: 0 on success, -EEXIST if the devicetree is already correct, or other
- * internal error code if we fail to setup a DTB
+ * @err internal error code if we fail to setup a DTB
  * @returns new devicetree blob pointer
  */
 void *board_fdt_blob_setup(int *err);
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index 1842da62f37..d36b01bd3f1 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -7,10 +7,6 @@
  */
 
 #ifndef USE_HOSTCC
-
-#define LOG_CATEGORY	LOGC_DT
-
-#include <bloblist.h>
 #include <boot_fit.h>
 #include <display_options.h>
 #include <dm.h>
@@ -90,7 +86,6 @@ static const char *const fdt_src_name[] = {
 	[FDTSRC_BOARD] = "board",
 	[FDTSRC_EMBED] = "embed",
 	[FDTSRC_ENV] = "env",
-	[FDTSRC_BLOBLIST] = "bloblist",
 };
 
 const char *fdtdec_get_srcname(void)
@@ -1666,43 +1661,23 @@ static void setup_multi_dtb_fit(void)
 
 int fdtdec_setup(void)
 {
-	int ret = -ENOENT;
-
-	/* If allowing a bloblist, check that first */
-	if (CONFIG_IS_ENABLED(BLOBLIST)) {
-		ret = bloblist_maybe_init();
-		if (!ret) {
-			gd->fdt_blob = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
-			if (gd->fdt_blob) {
-				gd->fdt_src = FDTSRC_BLOBLIST;
-				log_debug("Devicetree is in bloblist at %p\n",
-					  gd->fdt_blob);
-				ret = 0;
-			} else {
-				log_debug("No FDT found in bloblist\n");
-				ret = -ENOENT;
-			}
-		}
-	}
+	int ret;
 
-	/* Otherwise, the devicetree is typically appended to U-Boot */
-	if (ret) {
-		if (IS_ENABLED(CONFIG_OF_SEPARATE)) {
-			gd->fdt_blob = fdt_find_separate();
-			gd->fdt_src = FDTSRC_SEPARATE;
-		} else { /* embed dtb in ELF file for testing / development */
-			gd->fdt_blob = dtb_dt_embedded();
-			gd->fdt_src = FDTSRC_EMBED;
-		}
+	/* The devicetree is typically appended to U-Boot */
+	if (IS_ENABLED(CONFIG_OF_SEPARATE)) {
+		gd->fdt_blob = fdt_find_separate();
+		gd->fdt_src = FDTSRC_SEPARATE;
+	} else { /* embed dtb in ELF file for testing / development */
+		gd->fdt_blob = dtb_dt_embedded();
+		gd->fdt_src = FDTSRC_EMBED;
 	}
 
 	/* Allow the board to override the fdt address. */
 	if (IS_ENABLED(CONFIG_OF_BOARD)) {
 		gd->fdt_blob = board_fdt_blob_setup(&ret);
-		if (!ret)
-			gd->fdt_src = FDTSRC_BOARD;
-		else if (ret != -EEXIST)
+		if (ret)
 			return ret;
+		gd->fdt_src = FDTSRC_BOARD;
 	}
 
 	/* Allow the early environment to override the fdt address */
-- 
2.43.0

