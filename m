Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6423DC369A1
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 15:57:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DAF28353A;
	Wed,  9 Apr 2025 17:57:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z9SyFjGg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C4F6838BF; Wed,  9 Apr 2025 17:57:31 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0E758297E
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 17:57:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3d6d162e516so53978055ab.1
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 08:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744214247; x=1744819047; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fKUmkUFLxJxT5inH1gkDs8JOsbMWYD8kz9aQ9b9TSWc=;
 b=Z9SyFjGgMFu/XQ/A68c7SATl7XTIags2EIiH1KzJZWvS8c4p667ciOGgS0iCF+K2Dj
 EIuOUAngt2pLYPUAtjX0DQiNiwVq915v/egGpQ8Npbzu6v8Nyfr/JXueDa5T+j3NvrPa
 SaC2FSFcxYkVag8ps3A1N7Y1nDZg8rnDhJ/tg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744214247; x=1744819047;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fKUmkUFLxJxT5inH1gkDs8JOsbMWYD8kz9aQ9b9TSWc=;
 b=XV6ZprtI/kYIWeklF5sVvEOSnFyO3EZrTRRmqq9Pfn8hCC2q0oNwKX0uakFsMw7PkR
 XEyth/Eg9PvkkuyZU0TCnJAmuWEvpybyRUVEjJZ0k06pOCrwcPdW4VX4zCyPzJKOuUw+
 icHOwvSZM2w2M3spbw99ujEplw8FvSWwCj1trG33yrWUACW4+3IAVdlAVdyElmeydGKj
 MnIdixey32k1R0Nk0YMiviZZY4bjvASXOlWT1mCLMXcWJBN2eaghSlo6uRxIMcXDOLRm
 LM4z4x39mWTTmv3nEkREKXPY3AjwkbiMxHVdb9KB5DSvXwyD4ZkFHM2vDswxhlm53rP8
 ytww==
X-Gm-Message-State: AOJu0Yz79MypjgfOh2sTrhIwml7A677v13+iuKJfdaHdkxlT3UB9mi8n
 hiOKqxEo5nzXxLkbtBYYp0+bNwct4NpB0zNXTWkMt2Dk0ddE/kCVcbOOf2JVgJymvx4vOAJbx7Q
 =
X-Gm-Gg: ASbGnctqwNJ8rtd37oHeT5tpW108V/rb2i4x+cni/FRQL1So0ugvNs3AVhns49vFc9G
 yQc6Lzb+qlrZlzJpkkXwlYRSWjPxoU/46LOIWteFHfmtzX6/N1+TD8hXXcnQlMf20OpaznF7vs4
 L9ruxsoUVp/aDgkgpa1x4XOObh6tbl0W+RtMP1Pi8ZVscHsiDbJxP3Wc47VMlgwvYezblAZqz0x
 yb71kkKmnNa4OJ210CkdzfZdYyEwkavPsGpXlQZFCXVaREcVqgnYE3uAzysWYAEc1EWkOcn1uNS
 i5g5yF2UBuTvRMebYnclyfnpmVJjoF3+GVl8rqhBojflXMV7X5ssU0BCutaeHigYMtssIYN2sp/
 Yhw==
X-Google-Smtp-Source: AGHT+IHzvASAA6P9CDBHC78z4PLJQp9C4g4UHxbZnH/eupAWFwzBjlRJ9mwhVuZ4p6X5t0Pxra0S3Q==
X-Received: by 2002:a05:6e02:198b:b0:3d0:4a82:3f43 with SMTP id
 e9e14a558f8ab-3d776c8f02emr33787205ab.5.1744214246875; 
 Wed, 09 Apr 2025 08:57:26 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f505e2e05fsm296853173.111.2025.04.09.08.57.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 08:57:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] boot: Add missing code for bootz_run()
Date: Wed,  9 Apr 2025 09:57:21 -0600
Message-ID: <20250409155723.431102-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

The bootz method is special in that it uses its own implementation of
several of the bootm states.

The existing do_bootz() function calls bootz_run() but first does a few
other things. These are missing in the direct call to bootz_run(). I
probably missed this because bootz_start() sets up its own
struct bootm_info so I assumed it was independent. While the struct
itself is independent, changes to the images member (which is a pointer)
persist.

Move the required code into bootz_run()

This change was manually tested on an rpi2 with postmarketOS added,
using standard boot and also the 'bootz' command.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: 47eda7e80ea ("boot: pxe: Use bootm_...() functions where possible")
Reported-by: Svyatoslav Ryhel <clamor95@gmail.com>
---

 boot/bootm.c | 33 ++++++++++++++++++++++++++
 cmd/bootz.c  | 65 +++-------------------------------------------------
 2 files changed, 36 insertions(+), 62 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 7807579d5e6..0e63dd4adf3 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -1185,6 +1185,39 @@ int bootm_run(struct bootm_info *bmi)
 
 int bootz_run(struct bootm_info *bmi)
 {
+	struct bootm_headers *images = bmi->images;
+	ulong zi_start, zi_end;
+	int ret;
+
+	ret = bootm_run_states(bmi, BOOTM_STATE_START);
+	if (ret)
+		return ret;
+
+	images->ep = bmi->addr_img ? hextoul(bmi->addr_img, NULL) :
+		image_load_addr;
+
+	ret = bootz_setup(images->ep, &zi_start, &zi_end);
+	if (ret)
+		return ret;
+
+	lmb_reserve(images->ep, zi_end - zi_start);
+
+	/*
+	 * Handle the BOOTM_STATE_FINDOTHER state ourselves as we do not
+	 * have a header that provide this informaiton.
+	 */
+	if (bootm_find_images(images->ep, bmi->conf_ramdisk, bmi->conf_fdt,
+			      images->ep, zi_end - zi_start))
+		return -EINVAL;
+
+	/*
+	 * We are doing the BOOTM_STATE_LOADOS state ourselves, so must
+	 * disable interrupts ourselves
+	 */
+	bootm_disable_interrupts();
+
+	images->os.os = IH_OS_LINUX;
+
 	return boot_run(bmi, "bootz", 0);
 }
 
diff --git a/cmd/bootz.c b/cmd/bootz.c
index 787203f5bd7..acf0c92a42f 100644
--- a/cmd/bootz.c
+++ b/cmd/bootz.c
@@ -20,56 +20,6 @@ int __weak bootz_setup(ulong image, ulong *start, ulong *end)
 	return -1;
 }
 
-/*
- * zImage booting support
- */
-static int bootz_start(struct cmd_tbl *cmdtp, int flag, int argc,
-		       char *const argv[], struct bootm_headers *images)
-{
-	ulong zi_start, zi_end;
-	struct bootm_info bmi;
-	int ret;
-
-	bootm_init(&bmi);
-	if (argc)
-		bmi.addr_img = argv[0];
-	if (argc > 1)
-		bmi.conf_ramdisk = argv[1];
-	if (argc > 2)
-		bmi.conf_fdt = argv[2];
-	/* do not set up argc and argv[] since nothing uses them */
-
-	ret = bootm_run_states(&bmi, BOOTM_STATE_START);
-
-	/* Setup Linux kernel zImage entry point */
-	if (!argc) {
-		images->ep = image_load_addr;
-		debug("*  kernel: default image load address = 0x%08lx\n",
-				image_load_addr);
-	} else {
-		images->ep = hextoul(argv[0], NULL);
-		debug("*  kernel: cmdline image address = 0x%08lx\n",
-			images->ep);
-	}
-
-	ret = bootz_setup(images->ep, &zi_start, &zi_end);
-	if (ret != 0)
-		return 1;
-
-	lmb_reserve(images->ep, zi_end - zi_start);
-
-	/*
-	 * Handle the BOOTM_STATE_FINDOTHER state ourselves as we do not
-	 * have a header that provide this informaiton.
-	 */
-	if (bootm_find_images(image_load_addr, cmd_arg1(argc, argv),
-			      cmd_arg2(argc, argv), images->ep,
-			      zi_end - zi_start))
-		return 1;
-
-	return 0;
-}
-
 int do_bootz(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	struct bootm_info bmi;
@@ -78,17 +28,6 @@ int do_bootz(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	/* Consume 'bootz' */
 	argc--; argv++;
 
-	if (bootz_start(cmdtp, flag, argc, argv, &images))
-		return 1;
-
-	/*
-	 * We are doing the BOOTM_STATE_LOADOS state ourselves, so must
-	 * disable interrupts ourselves
-	 */
-	bootm_disable_interrupts();
-
-	images.os.os = IH_OS_LINUX;
-
 	bootm_init(&bmi);
 	if (argc)
 		bmi.addr_img = argv[0];
@@ -99,8 +38,10 @@ int do_bootz(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	bmi.cmd_name = "bootz";
 
 	ret = bootz_run(&bmi);
+	if (ret)
+		return CMD_RET_FAILURE;
 
-	return ret;
+	return 0;
 }
 
 U_BOOT_LONGHELP(bootz,
-- 
2.43.0

base-commit: ea9e72801c4c3e3542afe40f89e7e0822cabfcf8
branch: fix-bootz
