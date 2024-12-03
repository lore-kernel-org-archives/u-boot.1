Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0BAE77160
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:48:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FC0B89698;
	Wed,  4 Dec 2024 00:46:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HkKPNmlO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C183B8967A; Wed,  4 Dec 2024 00:46:54 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7968A89686
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:46:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-8419ef7c2d8so203485839f.2
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 15:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733269610; x=1733874410; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wIXYdughdEI9D0fFUx6Z+K/ALc2jfG9tXpSxcgAFVH4=;
 b=HkKPNmlOs8a/lFQPqfQZ1Lpmzc0dcUMyD0LWFjsoloAoAJdjrNRe/vIc9aiYyzoBaU
 STXteCX1TzPMP9zUrPYrOMEE2whRrkUj7T50l/D0TOb/4rOzfqV0px3i/v1qO5GASBnG
 4iMABvj7MAZpBuWnrLjOI6U5/x6MMjmRQNAFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733269610; x=1733874410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wIXYdughdEI9D0fFUx6Z+K/ALc2jfG9tXpSxcgAFVH4=;
 b=sECJ+Uvgs23tnbz8wVG4R3TdPSjer7jd2Q+ZIpdB0NdT+945AvzylEBrMd0sCvwDHE
 Gm+TTq5uCASZvEbHXmqya1bnDlaEHEo4EnPWKuX67an0oBbmGVieCz8iULvKngsOjJ0Z
 wAxS3BkFWjodawKXLoFqOD1FFWHLLhPLYiC0ElKFBHyVJqBsSGc9AGNTyz59fslgS+yn
 TsvSmFgLuszL8VXoy+wlClvzhCNvkug+tQkz4am6lqbCx53fkmOuzvFdP/ZCn4uF9hLY
 MX6TYPtQVkpJYx2jwyCVd//IXWQlwt3aKv3GrigHF5kcwmCPIRZtzw96uw25qr2aBtXG
 DYNw==
X-Gm-Message-State: AOJu0Yy6mHwrvU8l/B/3ni6lkSYl5cUm3cWgSPfzP/A6Hk51G4XbOXUa
 xIYk/qxq6JMO+/mS1Oh36mDa+5RBWuMCZjAm8vNPoKf2VR/TdYFQNiA9Ncqqz/X/6siP1nQzDAw
 =
X-Gm-Gg: ASbGnct5Ku0sFRNXoe/GW1I61CCANCWmZxTAs7eRC5GteuF9YpMEd8jnVYrzcj/nQsP
 iXPlP9Wh//C8TlOm3WfObjKqhXHqUnVk5zd1Utr/3h+g8grat7s/jdhfnokhJS9qOBEoRQJvb77
 ohaC8hy8VTthX4MmCVmkb+jYvr+yhrXJ08bf3qjDwY3qpV8PqjZj8OZleV4SG96GpedThdFxuir
 oOgexy07Gieng4jTvQDnth/EpuIDO0vN0w6mexMrOyXPFiauHjmihkS8+Suw2yO0O/SRzu2d90x
 d/V7oDJAC0U=
X-Google-Smtp-Source: AGHT+IExGlQJS2nIeqibfBNM6rAwTb36L2AmuW4PLsnBzvY371emaRDoZ5FOqJqnGH6MEKb7AUfMcA==
X-Received: by 2002:a05:6602:3fcb:b0:843:e9c1:9315 with SMTP id
 ca18e2360f4ac-8445b5e3062mr593638039f.13.1733269610323; 
 Tue, 03 Dec 2024 15:46:50 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405faf14fsm282349939f.42.2024.12.03.15.46.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:46:48 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH v2 14/41] boot: pxe: Use bootm_...() functions where possible
Date: Tue,  3 Dec 2024 16:45:32 -0700
Message-Id: <20241203234559.2938192-15-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203234559.2938192-1-sjg@chromium.org>
References: <20241203234559.2938192-1-sjg@chromium.org>
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

Rather than building a command line for each operation, use the
functions provided by the bootm API.

Make sure that the bootm functions are available if pxe_utils is used.

Since SYS_BOOTM_LEN is not present for the tools-only build, adjust the
code to handle that.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

(no changes since v1)

 boot/Makefile    |  2 +-
 boot/pxe_utils.c | 43 ++++++++++++++++++++-----------------------
 2 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/boot/Makefile b/boot/Makefile
index 43def7c33d7..9ccdc2dc8f4 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_CMD_BOOTM) += bootm.o bootm_os.o
 obj-$(CONFIG_CMD_BOOTZ) += bootm.o bootm_os.o
 obj-$(CONFIG_CMD_BOOTI) += bootm.o bootm_os.o
 
-obj-$(CONFIG_PXE_UTILS) += pxe_utils.o
+obj-$(CONFIG_PXE_UTILS) += bootm.o pxe_utils.o
 
 endif
 
diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 2ada5c4aaac..bbb6ff203b6 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -7,6 +7,7 @@
 #define LOG_CATEGORY	LOGC_BOOT
 
 #include <bootflow.h>
+#include <bootm.h>
 #include <command.h>
 #include <dm.h>
 #include <env.h>
@@ -461,7 +462,7 @@ skip_overlay:
  * Scenario 4: fdt blob is not available.
  */
 static int label_process_fdt(struct pxe_context *ctx, struct pxe_label *label,
-			     char *kernel_addr, char **fdt_argp)
+			     char *kernel_addr, const char **fdt_argp)
 {
 	/* For FIT, the label can be identical to kernel one */
 	if (label->fdt && !strcmp(label->kernel_label, label->fdt)) {
@@ -584,72 +585,66 @@ static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
 			  char *kernel_addr, char *initrd_addr_str,
 			  char *initrd_filesize, char *initrd_str)
 {
-	char *bootm_argv[] = { "bootm", NULL, NULL, NULL, NULL };
 	char *zboot_argv[] = { "zboot", NULL, "0", NULL, NULL };
+	struct bootm_info bmi;
 	ulong kernel_addr_r;
-	int bootm_argc = 2;
 	int zboot_argc = 3;
 	void *buf;
 	int ret;
 
-	bootm_argv[3] = env_get("fdt_addr_r");
+	bootm_init(&bmi);
 
-	ret = label_process_fdt(ctx, label, kernel_addr, &bootm_argv[3]);
+	bmi.conf_fdt = env_get("fdt_addr_r");
+
+	ret = label_process_fdt(ctx, label, kernel_addr, &bmi.conf_fdt);
 	if (ret)
 		return ret;
 
-	bootm_argv[1] = kernel_addr;
+	bmi.addr_img = kernel_addr;
 	zboot_argv[1] = kernel_addr;
 
 	if (initrd_addr_str) {
-		bootm_argv[2] = initrd_str;
-		bootm_argc = 3;
+		bmi.conf_ramdisk = initrd_str;
 
 		zboot_argv[3] = initrd_addr_str;
 		zboot_argv[4] = initrd_filesize;
 		zboot_argc = 5;
 	}
 
-	if (!bootm_argv[3]) {
+	if (!bmi.conf_fdt) {
 		if (IS_ENABLED(CONFIG_SUPPORT_PASSING_ATAGS)) {
 			if (strcmp("-", label->fdt))
-				bootm_argv[3] = env_get("fdt_addr");
+				bmi.conf_fdt = env_get("fdt_addr");
 		} else {
-			bootm_argv[3] = env_get("fdt_addr");
+			bmi.conf_fdt = env_get("fdt_addr");
 		}
 	}
 
 	kernel_addr_r = genimg_get_kernel_addr(kernel_addr);
 	buf = map_sysmem(kernel_addr_r, 0);
 
-	if (!bootm_argv[3] && genimg_get_format(buf) != IMAGE_FORMAT_FIT) {
+	if (!bmi.conf_fdt && genimg_get_format(buf) != IMAGE_FORMAT_FIT) {
 		if (IS_ENABLED(CONFIG_SUPPORT_PASSING_ATAGS)) {
 			if (strcmp("-", label->fdt))
-				bootm_argv[3] = env_get("fdtcontroladdr");
+				bmi.conf_fdt = env_get("fdtcontroladdr");
 		} else {
-			bootm_argv[3] = env_get("fdtcontroladdr");
+			bmi.conf_fdt = env_get("fdtcontroladdr");
 		}
 	}
 
-	if (bootm_argv[3]) {
-		if (!bootm_argv[2])
-			bootm_argv[2] = "-";
-		bootm_argc = 4;
-	}
-
 	/* Try bootm for legacy and FIT format image */
 	if (genimg_get_format(buf) != IMAGE_FORMAT_INVALID &&
 	    IS_ENABLED(CONFIG_CMD_BOOTM)) {
 		log_debug("using bootm\n");
-		do_bootm(ctx->cmdtp, 0, bootm_argc, bootm_argv);
+		ret = bootm_run(&bmi);
 	/* Try booting an AArch64 Linux kernel image */
 	} else if (IS_ENABLED(CONFIG_CMD_BOOTI)) {
 		log_debug("using booti\n");
-		do_booti(ctx->cmdtp, 0, bootm_argc, bootm_argv);
+		ret = booti_run(&bmi);
 	/* Try booting a Image */
 	} else if (IS_ENABLED(CONFIG_CMD_BOOTZ)) {
 		log_debug("using bootz\n");
-		do_bootz(ctx->cmdtp, 0, bootm_argc, bootm_argv);
+		ret = bootz_run(&bmi);
 	/* Try booting an x86_64 Linux kernel image */
 	} else if (IS_ENABLED(CONFIG_CMD_ZBOOT)) {
 		log_debug("using zboot\n");
@@ -657,6 +652,8 @@ static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
 	}
 
 	unmap_sysmem(buf);
+	if (ret)
+		return ret;
 
 	return 0;
 }
-- 
2.34.1

