Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896B1E77170
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:43:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 980958965B;
	Fri,  6 Dec 2024 03:38:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YORAUkpg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6A7989620; Fri,  6 Dec 2024 03:38:39 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F04F89788
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:38:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3a77980fe3aso5854415ab.0
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452715; x=1734057515; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FnFdJ6ShazJSrJJt2fufZmBS22KiAPCd/h+jVYrP+oc=;
 b=YORAUkpgQxZCcbB8Aj8c4z/x37MrvOrk5rwO00h7hnj7sReO1Utli+gBdVd3dYJXuf
 4qw7SeFEWiFQIA2l/G9/ibfovzXdvLh7ER742hSVX0QSOzPuaZ22UJg3BS55wJxQRGsc
 kbRWk4Io1GE+u99H6HJNDeCBvQPznTXL5x+3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452715; x=1734057515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FnFdJ6ShazJSrJJt2fufZmBS22KiAPCd/h+jVYrP+oc=;
 b=S1XVPQB8hSydkHKzFNSLJQrgaaSf/HkeHP59J6Ls0xFKpdUlp+os8A8sa98Ov+KXLm
 py+CDDFkhZBHXUo9N6OBnl/0SnAnf02q4c16FadJwWfWwB5pV9lmAmBwo+qCpYBlwpBo
 6/TONrEMLS7Vv6JRgAWWozL9VuBl92HVp5zEAJZdD0ocXAf3b5j4ysjEQJtxOYOscwMv
 w26ldgerC4m/o+XgEQH86fNVaZPgoEXxi6ZwYyfnLmUPj8xLuPc1a5LBOKW7URj9lJYR
 tfijNm5FO9qOXJK6F9+8vUUKIlmlFrIcNVJ6hpBqdWB9s7HzisTLiT32waH5NDmye5tR
 EDbg==
X-Gm-Message-State: AOJu0Yz6hpca3aP1WsZKOBNNq18dcP0q+eMbRiGCEltpdyTmtBB9IWej
 vd+ekLSsAYYJFPiq9O+bNbn5/5KBTmU5vxAnmHrNAkb1yG0rfEPBRy68usP8jr0i6S4zej398R8
 =
X-Gm-Gg: ASbGncu75wU95bfW76cFk898HOTicz4Jv9oMQOkYea56viGGCMYUqP51zX3HPflN973
 MAllrZSZrfsgn45O2WBKYQaftLeXgmHXnmYx2xSBHRXRPO4DduyFo0A1uq17bJiM5xs995kL8Yy
 b9VEO+BSlwJgUlE28PcG3PWtUR+0lNP99ROgk70wJvsgaKB5MVAMu9H5ug7ARdzKyKTnzLHPsrX
 fIXSNgWR9GdhBMi8K/Hr0zuLg/mopF7ps8WZDsHjNP11q7f99/55KwMeERl9dA2KU/wrii+B0Cj
 tFLQLZcGA2E=
X-Google-Smtp-Source: AGHT+IH9jfQ/O5DTu87kO8Nq1rmEghn/ZrQjklJZ3sDAL0ePMYtE8QuFXafBzN+0tqukGflToeSy4Q==
X-Received: by 2002:a05:6e02:10ce:b0:3a8:13d5:bd2c with SMTP id
 e9e14a558f8ab-3a813d5bd8emr8178725ab.2.1733452715557; 
 Thu, 05 Dec 2024 18:38:35 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.38.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:38:34 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v3 46/46] bootmeth_extlinux: Refactor extlinux to split boot
Date: Thu,  5 Dec 2024 19:36:25 -0700
Message-Id: <20241206023626.2456858-47-sjg@chromium.org>
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

Add a new extlinux_setup() function which sets things up so that the
bootflow can either be booted, or just probed.

Provide a readall() method so that images can be read into memory,
without booting the OS. Adjust the boot() method so that it can boot,
after any changes have been made by the user.

Update the test to change the bootargs and check that they are booted
with the changes intact.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Pass through the bootfile since extlinux and PXE are different

 boot/ext_pxe_common.c | 53 +++++++++++++++++++++++++++----------------
 test/boot/bootflow.c  | 24 ++++++++++++++++++++
 2 files changed, 58 insertions(+), 19 deletions(-)

diff --git a/boot/ext_pxe_common.c b/boot/ext_pxe_common.c
index 6e999af5fca..2037099708a 100644
--- a/boot/ext_pxe_common.c
+++ b/boot/ext_pxe_common.c
@@ -75,28 +75,20 @@ int extlinux_set_property(struct udevice *dev, const char *property,
 	return 0;
 }
 
-static int extlinux_process(struct udevice *dev, struct bootflow *bflow,
-			    pxe_getfile_func getfile, bool allow_abs_path,
-			    const char *bootfile, bool no_boot)
+static int extlinux_setup(struct udevice *dev, struct bootflow *bflow,
+			  pxe_getfile_func getfile, bool allow_abs_path,
+			  const char *bootfile, struct pxe_context *ctx)
 {
 	struct extlinux_plat *plat = dev_get_plat(dev);
-	ulong addr;
 	int ret;
 
-	addr = map_to_sysmem(bflow->buf);
-
 	plat->info.dev = dev;
 	plat->info.bflow = bflow;
 
-	ret = pxe_setup_ctx(&plat->ctx, getfile, &plat->info, allow_abs_path,
-			    bootfile, false, plat->use_fallback, bflow);
-	if (ret)
-		return log_msg_ret("ctx", -EINVAL);
-	plat->ctx.no_boot = no_boot;
-
-	ret = pxe_process(&plat->ctx, addr, false);
+	ret = pxe_setup_ctx(ctx, getfile, &plat->info, allow_abs_path, bootfile,
+			    false, plat->use_fallback, bflow);
 	if (ret)
-		return log_msg_ret("bread", -EINVAL);
+		return log_msg_ret("ctx", ret);
 
 	return 0;
 }
@@ -105,20 +97,43 @@ int extlinux_boot(struct udevice *dev, struct bootflow *bflow,
 		  pxe_getfile_func getfile, bool allow_abs_path,
 		  const char *bootfile)
 {
-	return extlinux_process(dev, bflow, getfile, allow_abs_path, bootfile,
-				false);
+	struct extlinux_plat *plat = dev_get_plat(dev);
+	ulong addr;
+	int ret;
+
+	/* if we have already selected a label, just boot it */
+	if (plat->ctx.label) {
+		ret = pxe_do_boot(&plat->ctx);
+	} else {
+		ret = extlinux_setup(dev, bflow, getfile, allow_abs_path,
+				     bootfile, &plat->ctx);
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
 		      pxe_getfile_func getfile, bool allow_abs_path,
 		      const char *bootfile)
 {
+	struct extlinux_plat *plat = dev_get_plat(dev);
+	ulong addr;
 	int ret;
 
-	ret = extlinux_process(dev, bflow, getfile, allow_abs_path, bootfile,
-			       true);
+	ret = extlinux_setup(dev, bflow, getfile, allow_abs_path, bootfile,
+			     &plat->ctx);
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

