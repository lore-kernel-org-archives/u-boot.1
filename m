Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1806D44157
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:21:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47AD1895DF;
	Tue, 19 Nov 2024 14:19:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="myf1EKAv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84CF2895D8; Tue, 19 Nov 2024 14:19:28 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 477718954F
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:19:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3a75f77d859so9770705ab.3
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 05:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732022364; x=1732627164; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PEqYqBkmlnEijNaOBupWJ1K5dRzvA4egycg9IEiRles=;
 b=myf1EKAvRqI5j2dWDpKMYjA0Y1yAxV+cqZHPJy2ZEA0aaKaxB2PYg8FUQM9PkSQIHN
 SRvrvokb86e+iMtSPk2t/+LYO84L/D3r0HmeD31ETJL7I7px/SksqEH1cwLCY6cgtXe7
 FYhNbIo0wvg8Mza+rtv5O+j84Vs2BTmYDCego=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732022364; x=1732627164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PEqYqBkmlnEijNaOBupWJ1K5dRzvA4egycg9IEiRles=;
 b=CtxRaSTPqB7X0tHYQGGHUK3uvF6B0N8T4grmMFT+6UFMp9DbhfiTkidBMmVfNyKZsA
 b6zJ/h2W/sFe6yl0/LaETGHDDJp/0YntP+Nv27QSkbORIFQ5Czkkbnlfvo5PoDXz8Pz0
 EKODkbZ6lYoV75YVwjXazUVpIrdTWhk+LDWtvZAJsYNNltV03f4PZDF+rtnOP1x1XTnn
 x91wpCKuWs3gbpMksNxag06gFFUvxRO86DOtYiS4BJk/w64gSl6Z8ZOkhewwL6p+N0jW
 RXn72t+elGDe3E+MqOlyrTX3c0wtfjDq4JsWK+xC9Zmm+lJ/0KSO7KwYhNfaQhrvkK9Q
 C80g==
X-Gm-Message-State: AOJu0Yz7NyzNOXCxzjsT0jME0hy2Spneucgj5YcoHksvfy0IDvRUpmuZ
 cHle2OA3tK7p3HiR7DYDtHnuQhMFbnwh6we6kc+//BC5AL97674fOkbpxz/Kmn+wRLoeFfs4ccA
 =
X-Google-Smtp-Source: AGHT+IHLBgJy/d7xJ9qj5nMpz+hlKu5Ls9dlsuWLIFSHmBiX+stUo0NmfBgD9NgRRx+WlflS2FERgw==
X-Received: by 2002:a92:c566:0:b0:3a7:15aa:3583 with SMTP id
 e9e14a558f8ab-3a74801888dmr183937125ab.6.1732022364518; 
 Tue, 19 Nov 2024 05:19:24 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7811e4905sm753085ab.2.2024.11.19.05.19.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 05:19:23 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH 13/39] boot: pxe: Use bootm_...() functions where possible
Date: Tue, 19 Nov 2024 06:18:18 -0700
Message-Id: <20241119131844.4078144-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119131844.4078144-1-sjg@chromium.org>
References: <20241119131844.4078144-1-sjg@chromium.org>
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
---

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
index 66f82d3fbc1..2517999d408 100644
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

