Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0FCC19F32
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 00:30:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EC8380E94;
	Thu,  6 Mar 2025 01:27:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cHU0tz9p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EB8080805; Thu,  6 Mar 2025 01:27:18 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 318DB80E94
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 01:27:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-85afcb0c18fso3489339f.1
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 16:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741220834; x=1741825634; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E7rPZTA14ouyqv0XIQoDk8itFV2LVK2EL3s3c6TfBjo=;
 b=cHU0tz9pbQUHv5xMaXij+pGxsZLfQ4wV1zOulmWwZ8yp8QwgCfP5SLF0GvVBULX/yg
 77LlQ+YAfEpBLl97TABuq/elhX2SQ1rlFGdXlle3TWsvwSiLlU7ECcnEqIzdC5sjJaAa
 h4162H/CsjyWYpax932yyWfB4A2WpnsBafZ80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741220834; x=1741825634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E7rPZTA14ouyqv0XIQoDk8itFV2LVK2EL3s3c6TfBjo=;
 b=MrAyB2qC20AquKz9X2rbMR/BrM7WQ17crwQFmg09JCPhfWDqfOWI/xXabnev3l8aBH
 2dPkyly6AqH2xQfYUh3Ks46rDv0z/Agx8pqXBM0SYb8n5v94Y6GkzZoQZSHfj5UYNqsS
 B13ryslJZio5j0LGrwLczgnzni0kHkU3RCXStRAWC09mgNvzrTUOFIdWU6gamabaKOW5
 JXaBVr4q5cW5FWaSZykpxcRZ3/9cBm00Q6ue4y9L8vqMQUG4nkIj4S7f4QjQrpzzpavx
 dsD1OOXxORcirYbwUhVgOjwsRpCqwbRURDO4YcAmDAUCO0b/WDTgVcH4hvky+l9j7ODF
 R/XQ==
X-Gm-Message-State: AOJu0YzOo4bD14dUfFNFygLJsYhGHanBkxdrjyiRY2XFCehD+pElHe5y
 VmbFHXbJ6AF18Bxfw9Adpd1vnPigFOoSsQK5z2U6icHfDwD8OHf+mvQo1g8OoPV0ajxG3nUFxck
 =
X-Gm-Gg: ASbGncsg/xvdzR9JP/gXh2jCbxIzD9QTmL0DEgmeywBJLfzasbQHCDaEJvZmOX4Jqq4
 rBJ9hL3Xgr6/HU12gdc1hn3I3TholTNTt9sjzEBY5ckTC5X4Gn9dm8yCtDwT9/DMZSBZ8kwNOyX
 JPgNxCwn9ATuY76US1rlMTynulZ8Mf0z6Gn7U3+4NRjf1Na34Rl+VlyJj1LNQq14w1F+gucYj0F
 0lOEn5EOekeCd9qYlZt30sBYUDh7jinEmt1lkdN+Ken2pFvBoXYAJi5Fm/Y3O43geZVo/xiwA9g
 3CZz00wLEBg9k0UlMVS9U5+aqsDNqQFmOnPf++182ecmVC3BZYG2QbqpaSBtjy2Zny7WTDlEK83
 4Ct14PA==
X-Google-Smtp-Source: AGHT+IHpfpDvoCwlUK6hDVCgjp+LgCY4nuAMrQorZrHCwH0YR4s3yleZfbeXdglrT0lqciWgrJNDTQ==
X-Received: by 2002:a05:6602:4a06:b0:855:7837:ab12 with SMTP id
 ca18e2360f4ac-85aff8986bcmr775406939f.3.1741220834035; 
 Wed, 05 Mar 2025 16:27:14 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85b11986869sm1106239f.1.2025.03.05.16.27.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 16:27:12 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v5 18/29] boot: pxe: Use bootm_...() functions where possible
Date: Wed,  5 Mar 2025 17:25:12 -0700
Message-ID: <20250306002533.2380866-19-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306002533.2380866-1-sjg@chromium.org>
References: <20250306002533.2380866-1-sjg@chromium.org>
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
index 34bac26c4e2..f1e4444aa0a 100644
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
2.43.0

