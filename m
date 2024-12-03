Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6B8E77160
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:52:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A79689684;
	Wed,  4 Dec 2024 00:48:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kFFPzT99";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C78B78967D; Wed,  4 Dec 2024 00:48:13 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A1A489684
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:48:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-84198253281so216059739f.0
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 15:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733269690; x=1733874490; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ly3TgyVogkDmuhzy2M7jKm3e/Z7ibEWqnc6664ySZAY=;
 b=kFFPzT99Vz2e1ovjqI0zO+xkrmds7St7yglSogubnRY3taxvVckQaMd5M77toc/NKO
 8L8YuTv+VA4tRU3Z+dEhwYQFgFRsApwbSLZYae/ugEyy2I1pFOgHdjus68mtTX7xJmjc
 9wB/GV+0wwjbXJuO+GqZn9K1Ni1AjYuyopwFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733269690; x=1733874490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ly3TgyVogkDmuhzy2M7jKm3e/Z7ibEWqnc6664ySZAY=;
 b=Q4YknYJPJ/u6NpxTtNkSpRtgDd6b9+dPkBYmKNGF1Lgf0sos49u41ILzzWgta/HLNH
 lZc1HOzOY0VRratTjECX7T6GfWRLNptabj24QmCNoMUCgdV+pJIG9s0gOY3NXvoodzyy
 XCdACyWQqp9uFigFqj0CHgA3geCuB4E8KMy98QfBuF9dO7ZzVu2rXJzbjshsnM1iCV/7
 4xyD0su/twkrSpJwujz1T4ePXqR8R/fOFs1rVVVRCvyhWytaK9SjcjmMqG5UCXRsUwnt
 48CqS7X3pzqQqFh8X1G5UnBVRld6M8YbVxZB9Slo8gpb5o8LOl8EuuhgwmJ6Wpb8eu1e
 H6mw==
X-Gm-Message-State: AOJu0YzMSuU14nY/Ft3Vf5W0nLzimQ9B0TXIxI7UaCCzKhe0cfEZVtr4
 zdBFr4BYF+acxKpHmUMs+q3qj6U4v2Lca/5FVKmvIjOiGuZHsglLtIpQep/wyrYGwafrsF+v3Vk
 =
X-Gm-Gg: ASbGnctP9mybdNaqJ4X4IGxMbQVl5h7uybTWJFI7+goS9I6uLFbzfb3imgHOufTR1Wp
 KzZIhwT7FisCz2kAgPgZWVbVBs7H6JZ+ZZs4t/d3vZrh70cRYcOUrDTEe0EzHDlT4A7+WZ3RzpC
 mCUxkmn469qAz9/7dDEMQNrPJi23X4NSeodIW+qNIJh+sNMOG12vHZ7oB9dmgiYbKnGK4MBuWfZ
 G2W8iWhhzFUcV55mXurApnqFN7PI9Z7j+DOYu6EZ2skyHjaJMoNTpkRxy7njBOfmVDHX3rmwSgX
 2hRoiEnM4Xo=
X-Google-Smtp-Source: AGHT+IE3ETBox0vN+J9ONVwnmbkGYXzLYKC1iy2rGKEt7QqXC0EMWUo1iSYnLwA6E7SK3CXfiOmaTg==
X-Received: by 2002:a05:6602:1695:b0:83d:e526:fde7 with SMTP id
 ca18e2360f4ac-8445b551c71mr630329439f.6.1733269689708; 
 Tue, 03 Dec 2024 15:48:09 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405faf14fsm282349939f.42.2024.12.03.15.48.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:48:08 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v2 41/41] bootmeth_extlinux: Refactor extlinux to split boot
Date: Tue,  3 Dec 2024 16:45:59 -0700
Message-Id: <20241203234559.2938192-42-sjg@chromium.org>
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

Add a new extlinux_setup() function which sets things up so that the
bootflow can either be booted, or just probed.

Provide a readall() method so that images can be read into memory,
without booting the OS. Adjust the boot() method so that it can boot,
after any changes have been made by the user.

Update the test to change the bootargs and check that they are booted
with the changes intact.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

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
index 640a7cdb7c9..35580cee90c 100644
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
@@ -1440,6 +1441,9 @@ static int bootflow_scan_extlinux(struct unit_test_state *uts)
 	const struct bootflow_img *img;
 	struct bootstd_priv *std;
 	struct bootflow *bflow;
+	const char *cline;
+	const void *fdt;
+	int node;
 
 	ut_assertok(run_command("bootflow scan", 0));
 	ut_assert_console_end();
@@ -1477,6 +1481,26 @@ static int bootflow_scan_extlinux(struct unit_test_state *uts)
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

