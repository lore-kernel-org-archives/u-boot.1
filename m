Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23393C4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 04:21:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F5A987B73;
	Fri, 15 Dec 2023 05:19:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OxbgjMr9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8526B87B81; Fri, 15 Dec 2023 05:19:44 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 033CC87B84
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 05:19:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3ba0dfc9001so110963b6e.2
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 20:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702613979; x=1703218779; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sdQr8oGkhdM9lT+L6CqF1s+cfduBl60YL62DprkrgQQ=;
 b=OxbgjMr9mbrht6J1BL0MXc0T3tet6lH/0B8TgAvXITkrHJngQOcrn3rdmFuyNqWehh
 ATLjCmfXEB7ak+8i3r1diYtnin7tN1LW1L6w/Bhms0EW8L5Tu2zsBshN9gcbZGO4CDEv
 wm7fpI7hcdon6ukWOMbhHYsHiYxd8xUoH8ZKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702613979; x=1703218779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sdQr8oGkhdM9lT+L6CqF1s+cfduBl60YL62DprkrgQQ=;
 b=prEM4w58SHZnYrioGC2vvU7WtXcMItRQ702pqzOVXkrOJY1doAR8yqAUa99CLIPwjX
 SXNoHx+527YAyVIbKp0L/cJwOpAsNOQRC+gD/bzSlt+D9fgU0udj6zOKcetXC0O+DXfv
 P2Nb5j0gOu7dC3a+UR0UEd5NoMfKfRmG2+brSOX0UPFI3dJnc4OWUR7x52Qta8slLEhL
 YjLrc8SNeGmnmo11DbtLbJsJ/R0BqjOA6+bTI5E/vbZ0EMpHe/zhZ38ufVsxprwjOhZi
 wjPdpb0Tqk04FmvB+5mjBx3P6tt0FZ+74TYyB/K99hH4sREiv5nxPU8KScR1ae0pWF2e
 9Ybw==
X-Gm-Message-State: AOJu0Yzxc+ujZ1pntOHlPBGvy1IFaitgtZQ/z10EQDgPMr3ncZaPSw0P
 u3dWl+z8KQc/cezrQIz02wOXT6tEuBAvLJW9pBapcw==
X-Google-Smtp-Source: AGHT+IFQSmYHWMelNHVHhv5CZl6cFY7PAvI7aibo2PXR/a0nmArmhxXhUjZ0/dU9j88J9wmRoyW/iw==
X-Received: by 2002:a05:6808:22a3:b0:3b9:f12d:c2ad with SMTP id
 bo35-20020a05680822a300b003b9f12dc2admr8339029oib.52.1702613979540; 
 Thu, 14 Dec 2023 20:19:39 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 be15-20020a056808218f00b003b898ffd8fcsm3601492oib.50.2023.12.14.20.19.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 20:19:39 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Marek Vasut <marex@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Peter Hoyes <peter.hoyes@arm.com>, Sean Edmond <seanedmond@microsoft.com>,
 Thomas Mittelstaedt <thomas.mittelstaedt@de.bosch.com>
Subject: [PATCH v2 14/16] pxe: Allow booting without CMDLINE for bootm methods
Date: Thu, 14 Dec 2023 21:19:12 -0700
Message-ID: <20231214211906.v2.14.I71a8d9d2665494a0cf11dd309216c7badce34388@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231215041919.2197788-1-sjg@chromium.org>
References: <20231215041919.2197788-1-sjg@chromium.org>
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

Use bootm_run() and booti_run() to boot rather than the command line.
This allows extlinux to be used without CMDLINE being enabled.

Collect any error but do not return it, to match the existing code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Update commit message to mention booti
- Use bootm_init() instead of memset()

 boot/pxe_utils.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index a34f4410e07e..c9da82b8e45f 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -5,6 +5,7 @@
  */
 
 #include <common.h>
+#include <bootm.h>
 #include <command.h>
 #include <dm.h>
 #include <env.h>
@@ -566,13 +567,16 @@ static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
 			  char *kernel_addr, char *initrd_str,
 			  char *initrd_addr_str, char *initrd_filesize)
 {
-	char *bootm_argv[] = { "bootm", NULL, NULL, NULL, NULL };
+	struct bootm_info bmi;
 	char *zboot_argv[] = { "zboot", NULL, "0", NULL, NULL };
 	const char *fdt_addr;
 	ulong kernel_addr_r;
-	int bootm_argc = 2;
 	int zboot_argc = 3;
 	void *buf;
+	int ret;
+
+	if (IS_ENABLED(CONFIG_BOOTM))
+		bootm_init(&bmi);
 
 	fdt_addr = env_get("fdt_addr_r");
 
@@ -620,12 +624,11 @@ static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
 		}
 	}
 
-	bootm_argv[1] = kernel_addr;
+	bmi.addr_fit = kernel_addr;
 	zboot_argv[1] = kernel_addr;
 
 	if (initrd_addr_str) {
-		bootm_argv[2] = initrd_str;
-		bootm_argc = 3;
+		bmi.conf_ramdisk = initrd_str;
 
 		zboot_argv[3] = initrd_addr_str;
 		zboot_argv[4] = initrd_filesize;
@@ -641,23 +644,18 @@ static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
 	if (!fdt_addr && genimg_get_format(buf) != IMAGE_FORMAT_FIT)
 		fdt_addr = env_get("fdtcontroladdr");
 
-	if (fdt_addr) {
-		if (!bootm_argv[2])
-			bootm_argv[2] = "-";
-		bootm_argc = 4;
-	}
-	bootm_argv[3] = (char *)fdt_addr;
+	bmi.conf_fdt = fdt_addr;
 
 	/* Try bootm for legacy and FIT format image */
 	if (genimg_get_format(buf) != IMAGE_FORMAT_INVALID &&
-            IS_ENABLED(CONFIG_CMD_BOOTM))
-		do_bootm(ctx->cmdtp, 0, bootm_argc, bootm_argv);
+	    IS_ENABLED(CONFIG_BOOTM))
+		ret = bootm_run(&bmi);
 	/* Try booting an AArch64 Linux kernel image */
-	else if (IS_ENABLED(CONFIG_CMD_BOOTI))
-		do_booti(ctx->cmdtp, 0, bootm_argc, bootm_argv);
+	else if (IS_ENABLED(CONFIG_BOOTM))
+		ret = booti_run(&bmi);
 	/* Try booting a Image */
-	else if (IS_ENABLED(CONFIG_CMD_BOOTZ))
-		do_bootz(ctx->cmdtp, 0, bootm_argc, bootm_argv);
+	else if (IS_ENABLED(CONFIG_BOOTM))
+		ret = bootz_run(&bmi);
 	/* Try booting an x86_64 Linux kernel image */
 	else if (IS_ENABLED(CONFIG_CMD_ZBOOT))
 		do_zboot_parent(ctx->cmdtp, 0, zboot_argc, zboot_argv, NULL);
-- 
2.43.0.472.g3155946c3a-goog

