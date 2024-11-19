Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4FCD4415D
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:25:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E87D489715;
	Tue, 19 Nov 2024 14:20:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NXm5Pbjn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C1E58972C; Tue, 19 Nov 2024 14:20:41 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0440C8959C
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:20:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3a7750318a2so5303625ab.2
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 05:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732022437; x=1732627237; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pD/En9082oHsFy253e/SqhBl3ky/ypXnPRegyMSDf9Q=;
 b=NXm5PbjnRnjVn38IEMzQVgZJ0BdfrdbCIYeIn6efW4F2NR6+jCc2KZ3dKOgq9wNQqC
 p3jlF6EkX2yhWXfnMlJ2IkWVimhp0NQjStKI2DUNIBs2F+xY03V4LA9d5zAommyCfZvK
 IFuGv8QLQe9w5d6y0xqlSyOnBYWSwjwVHhjtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732022437; x=1732627237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pD/En9082oHsFy253e/SqhBl3ky/ypXnPRegyMSDf9Q=;
 b=PXLGu5xMlAZX8cZYMGRPhMpJxlsDw68uWjGCSEQrxxavIMKW/Hdr13yD+wU9SB1Kup
 GEreKqGC3zOlDe7XBorYn6cI2HecUnX3DYtC3UlGyxGMZhtbaO934Ch7Eth3hBbtV9pU
 QDJicNMkD6VwR3qIREwmTBREpPmovoW7J6OtLBTvmTXmCbcuODuwoVdUJFmhhKs5sT85
 /O4BmfGh89tn2+4vvLukSGt+ASUQg/7ViPNMehmM03OPUVU+59NnrYv5O+2l7gx/iiTg
 gJWguFXjvzHC4rpmnoIVX088zdCA6bircUGCukqUGupcOhL1y/5gcz8OBgUW3OXlVzPf
 0Tfw==
X-Gm-Message-State: AOJu0YyQyluPv80unI4j5x69UAwrryCM/NTrtkH9txlIvMmsVqqvDJXn
 80M8a7m9CyUkjeCSQ+mXuLJfAZDdenzO5WYj92PM1yeCodKh+uL5mMe1PMVhOT5A5vpRjK2YWOo
 =
X-Google-Smtp-Source: AGHT+IGmgQE43PNObVYTq6IigrcSKIajIopNrxpDYyn1PtqhAVEY2tOzoo/YHrhTAiW7h1ti5nd1Cw==
X-Received: by 2002:a05:6e02:2384:b0:3a7:21ad:72a9 with SMTP id
 e9e14a558f8ab-3a748082b82mr171129345ab.17.1732022436749; 
 Tue, 19 Nov 2024 05:20:36 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7811e4905sm753085ab.2.2024.11.19.05.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 05:20:35 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH 39/39] bootmeth_extlinux: Refactor extlinux to split boot
Date: Tue, 19 Nov 2024 06:18:44 -0700
Message-Id: <20241119131844.4078144-40-sjg@chromium.org>
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

Add a new extlinux_setup() function which sets things up so that the
bootflow can either be booted, or just probed.

Provide a readall() method so that images can be read into memory,
without booting the OS. Adjust the boot() method so that it can boot,
after any changes have been made by the user.

Update the test to change the bootargs and check that they are booted
with the changes intact.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/ext_pxe_common.c | 47 ++++++++++++++++++++++++++++---------------
 test/boot/bootflow.c  | 24 ++++++++++++++++++++++
 2 files changed, 55 insertions(+), 16 deletions(-)

diff --git a/boot/ext_pxe_common.c b/boot/ext_pxe_common.c
index c7f690dee17..7fdd3d98834 100644
--- a/boot/ext_pxe_common.c
+++ b/boot/ext_pxe_common.c
@@ -75,27 +75,19 @@ int extlinux_set_property(struct udevice *dev, const char *property,
 	return 0;
 }
 
-static int extlinux_process(struct udevice *dev, struct bootflow *bflow,
-			    pxe_getfile_func getfile, bool no_boot)
+static int extlinux_setup(struct udevice *dev, struct bootflow *bflow,
+			  pxe_getfile_func getfile, struct pxe_context *ctx)
 {
 	struct extlinux_plat *plat = dev_get_plat(dev);
-	ulong addr;
 	int ret;
 
-	addr = map_to_sysmem(bflow->buf);
-
 	plat->info.dev = dev;
 	plat->info.bflow = bflow;
 
-	ret = pxe_setup_ctx(&plat->ctx, getfile, &plat->info, true,
-			    bflow->fname, false, plat->use_fallback, bflow);
-	if (ret)
-		return log_msg_ret("ctx", -EINVAL);
-	plat->ctx.no_boot = no_boot;
-
-	ret = pxe_process(&plat->ctx, addr, false);
+	ret = pxe_setup_ctx(ctx, getfile, &plat->info, true, bflow->fname,
+			    false, plat->use_fallback, bflow);
 	if (ret)
-		return log_msg_ret("bread", -EINVAL);
+		return log_msg_ret("ctx", ret);
 
 	return 0;
 }
@@ -103,17 +95,40 @@ static int extlinux_process(struct udevice *dev, struct bootflow *bflow,
 int extlinux_boot(struct udevice *dev, struct bootflow *bflow,
 		  pxe_getfile_func getfile)
 {
-	return extlinux_process(dev, bflow, getfile, false);
+	struct extlinux_plat *plat = dev_get_plat(dev);
+	ulong addr;
+	int ret;
+
+	/* if we have already selected a label, just boot it */
+	if (plat->ctx.label) {
+		ret = pxe_do_boot(&plat->ctx);
+	} else {
+		ret = extlinux_setup(dev, bflow, getfile, &plat->ctx);
+		if (ret)
+			return log_msg_ret("elb", ret);
+		addr = map_to_sysmem(bflow->buf);
+		ret = pxe_process(&plat->ctx, addr, false);
+	}
+	if (ret)
+		return log_msg_ret("elb", -EFAULT);
+
+	return 0;
 }
 
 int extlinux_read_all(struct udevice *dev, struct bootflow *bflow,
 		      pxe_getfile_func getfile)
 {
+	struct extlinux_plat *plat = dev_get_plat(dev);
+	ulong addr;
 	int ret;
 
-	ret = extlinux_process(dev, bflow, getfile, true);
+	ret = extlinux_setup(dev, bflow, getfile, &plat->ctx);
+	if (ret)
+		return log_msg_ret("era", ret);
+	addr = map_to_sysmem(bflow->buf);
+	ret = pxe_probe(&plat->ctx, addr, false);
 	if (ret)
-		return log_msg_ret("era", -EINVAL);
+		return log_msg_ret("elb", -EFAULT);
 
 	return 0;
 }
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index cbd65cb3eb5..4d21054e10a 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -21,6 +21,7 @@
 #endif
 #include <dm/device-internal.h>
 #include <dm/lists.h>
+#include <linux/libfdt.h>
 #include <test/suites.h>
 #include <test/ut.h>
 #include "bootstd_common.h"
@@ -1417,6 +1418,9 @@ static int bootflow_scan_extlinux(struct unit_test_state *uts)
 	const struct bootflow_img *img;
 	struct bootstd_priv *std;
 	struct bootflow *bflow;
+	const char *cline;
+	const void *fdt;
+	int node;
 
 	ut_assertok(run_command("bootflow scan", 0));
 	ut_assert_console_end();
@@ -1454,6 +1458,26 @@ static int bootflow_scan_extlinux(struct unit_test_state *uts)
 	ut_asserteq(IH_TYPE_FLATDT, img->type);
 	ut_asserteq(0xc00000, img->addr);	/* fdt_addr_r */
 
+	/* adjust the command line */
+	ut_assertok(run_command("bootflow cmdline set root /dev/mmc2", 0));
+
+	ut_asserteq(-EFAULT, bootflow_boot(bflow));
+	ut_assert_skip_to_line("sandbox: continuing, as we cannot run Linux");
+	ut_assert_console_end();
+
+	/* check that the images were not loaded again */
+	ut_asserteq(4, bflow->images.count);
+
+	/* check the cmdline in the booted FDT */
+	fdt = working_fdt;
+	node = fdt_subnode_offset(fdt, 0, "chosen");
+	ut_assert(node > 0);
+	cline = fdt_getprop(fdt, node, "bootargs", 0);
+	ut_assertnonnull(cline);
+	ut_asserteq_str(
+		"ro root=/dev/mmc2 rhgb quiet LANG=en_US.UTF-8 cma=192MB cma=256MB",
+		bflow->cmdline);
+
 	return 0;
 }
 BOOTSTD_TEST(bootflow_scan_extlinux, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
-- 
2.34.1

