Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD675E77170
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:39:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FE1D89622;
	Fri,  6 Dec 2024 03:37:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BgjMhJn4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D70B895DE; Fri,  6 Dec 2024 03:37:23 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E513A8918C
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:37:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3a81324bbdcso2359755ab.1
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452639; x=1734057439; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dk3ymu+0Or0zVIKukkowNqICfAbtE0w5QwF2dDVtBFs=;
 b=BgjMhJn4rOTqqOVUQTHYsz2pAgXmkntMiHe/0KkZAKAMaHlPp6MJPixWQmgTVjjKrc
 KmmcGYsQDO2/NtO3RoVfGHs4AGW4KxRj/88zJdaSkoab5TBho8qc3b6tV0wlTmWOLj0/
 wd1iLeHjl2z7so12hFri5UaZhQrzGMZ1tLUtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452639; x=1734057439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dk3ymu+0Or0zVIKukkowNqICfAbtE0w5QwF2dDVtBFs=;
 b=q0iIqBn+rgQfGRLKFaLcvfubag5W+p+HvK+yI6kSZR7UaHCt2F8JowBcUy6vqdawVr
 jVPvJttgbECoaYyd/9dvWkfrx3/EQyZYHeSRzAm1fdXoUM7OhwMnc9oXGGAyCWw6vPHB
 a6G5OgMUUW/mLesCn9zwVWcftMQk6p3eJHfW/7LIdgzgzDXnSOUFhoWwPrM6iyEpXGa+
 WLkRq8ZpXZr5mRS4rpKuaxCPGx2JOjrR0XFkOQvh1ukTrmXCWaFclkrWBmXA2aK72sM2
 WJDGsQamXLwfaFdMNAIsPoGfjmcqtl1QKn1mSS9K5bv9omE4fb77yaOmIX6QEsgt9C5P
 XWlQ==
X-Gm-Message-State: AOJu0YzICM6gdhx/MeYgb0KaDA1eFNlSc3vvdK4T5qWHwdw/76UA5nrs
 6YbE6Ne49RVVh/BMrFpuZKV88E3qvnIdVRPXvb25tmOIqqmaAJvaIaUMxep+ZFXjouqmCoUUgIc
 =
X-Gm-Gg: ASbGncu2SIuQAUT2aHdvjljlv2JFDtZTbv9aBhnDofYeoBGHtTNPJZ2FG2H6CEIn0pd
 x1voQIsOKZ9SHWwU+Imrt9RVo1Rd+NlkUS90RJTIsS0lXBeGF4Esodac+OzbCG5aZMflIssRnPd
 XA4w9gZ9jt2z6QGuqtNDnWwn1r0nhKwvVSA9hgE1QZLEg9ogdD1fGlvc2qX0RH7npNonpQEs6kg
 JAhN0S04rVuFRClu9yYjjm13EJ1JQJyuW2faZI4JcgqBYKOxC8tehFCIV810fG+7eyCAL5w7N4d
 3MM5Ai8JFVo=
X-Google-Smtp-Source: AGHT+IFaA+6byK8qj/o8ZtonH/JiADLrhoRLFWBRjdlxvMQPS/KcUwtBw0hJv/2qTZ0ld9n2dD85Bw==
X-Received: by 2002:a05:6e02:198a:b0:3a7:6a98:3fdf with SMTP id
 e9e14a558f8ab-3a811daf831mr19521245ab.14.1733452639195; 
 Thu, 05 Dec 2024 18:37:19 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.37.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:37:17 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH v3 18/46] boot: pxe: Use bootm_...() functions where possible
Date: Thu,  5 Dec 2024 19:35:57 -0700
Message-Id: <20241206023626.2456858-19-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206023626.2456858-1-sjg@chromium.org>
References: <20241206023626.2456858-1-sjg@chromium.org>
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
index b03d628187b..ef9943bbfc1 100644
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

