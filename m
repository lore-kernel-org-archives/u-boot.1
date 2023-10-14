Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72245CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:43:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 083C686D56;
	Sun, 15 Oct 2023 09:15:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Yt9s3zlC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6A7F86E37; Sun, 15 Oct 2023 09:15:22 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9C7586F96
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 09:14:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1e9baf16a86so1770703fac.1
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 00:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697354066; x=1697958866; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VBpqRUjrphQeqj+DuBxVTyZC2UVVJey1TVDmcInv52w=;
 b=Yt9s3zlCUpsLqVDwWH3GVPvcpF6qrk+gEClKwe514DCgE0PlvsrWTV2LzC0c7/ffyp
 MJ5Q9WPNeC/Ajryu/UYVRzOIlZFu0VROZlm8zeH+5empZveI+YVBbMtDZij22c5WCE2Y
 YYIQKn+DRSSvJSLEpSU4ViC8+Y4tihTMFnRUKci7N9UbDLMkAfZVJSJ3k/78oPjdGn3R
 OimMtLlvMk2TVYXELV1iHuDF4SUHm8Bv3jVpAaU8yOmdKtlHOWXjDWj1JjxCQgMDieds
 8BW+o0AP+1kuj/xDuKt//CfsCXANyRETyNIf6JzWw7DE6S9H8C6N07jJWziUbRFVBVQg
 h2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697354066; x=1697958866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VBpqRUjrphQeqj+DuBxVTyZC2UVVJey1TVDmcInv52w=;
 b=pmnitY0uShyN491QYba+TItogwobsovIDNRrax0tivJGwwNO5kwm1QnY5cbjdyVQk/
 PYAqE1lRsZOx/q15Ar/uhZRmJKpiT58n9t4e7lpnJk/1d3gTaLeYU2DqjQ8dIrMi3bdI
 aiMjsdGE9FZsnyUinbu8wkppE2OY/zqAq9m377zhmeag9JfIb6eU0WnPsd74UIvs6zjB
 UvZEYOvW054Gfn46waGM8o/TUX/fL6RuIHI9wyKiv/mvfVd51FcoAqed8bKU2tf+1+PB
 62DEy+H2HnrVgNjiFdka5YmPynVa/fwYERnYOlEjTxA+0neCqP8hQe2uUUOJ9oOCZgq5
 qNFA==
X-Gm-Message-State: AOJu0Yz+p5rWF+71bztZKyO2Tin0kiAP/qWl17o1/Vh2Uj2XnjqXPHUJ
 Zc+fAQsPzdzQFmIrBcA8UFhhzPXxwxEKpQ==
X-Google-Smtp-Source: AGHT+IHHJ6gfGPZJS+8FwGjaR1n4JvG6xFSLuDuNw39fjDrQgBQC2hXlk4IMuUkeVIK4zgV8JMi06w==
X-Received: by 2002:a05:6808:10c1:b0:3af:8ed3:d7a3 with SMTP id
 s1-20020a05680810c100b003af8ed3d7a3mr38391562ois.54.1697316511364; 
 Sat, 14 Oct 2023 13:48:31 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 vq25-20020a05620a559900b0076f35d17d06sm1717278qkn.69.2023.10.14.13.48.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Oct 2023 13:48:31 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 21/29] test: spl: Split tests up and use some configs
Date: Sat, 14 Oct 2023 16:47:57 -0400
Message-Id: <20231014204805.439009-22-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231014204805.439009-1-seanga2@gmail.com>
References: <20231014204805.439009-1-seanga2@gmail.com>
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

In order to make adding new spl unit tests easier, especially when they may
have many dependencies, add some Kconfigs for the existing image test.
Split it into the parts which are generic (such as callbacks) and the
test-specific parts.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Remove redundant condition on CONFIG_SPL_UT_LOAD in test/image/Makefile
- Remove unused mapmem.h include in spl_load_os.c

 test/Kconfig             |  1 +
 test/Makefile            |  5 +--
 test/image/Kconfig       | 20 ++++++++++
 test/image/Makefile      |  3 +-
 test/image/spl_load.c    | 76 +-------------------------------------
 test/image/spl_load_os.c | 80 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 106 insertions(+), 79 deletions(-)
 create mode 100644 test/image/Kconfig
 create mode 100644 test/image/spl_load_os.c

diff --git a/test/Kconfig b/test/Kconfig
index 830245b6f9a..ca648d23376 100644
--- a/test/Kconfig
+++ b/test/Kconfig
@@ -101,6 +101,7 @@ config UT_UNICODE
 
 source "test/dm/Kconfig"
 source "test/env/Kconfig"
+source "test/image/Kconfig"
 source "test/lib/Kconfig"
 source "test/optee/Kconfig"
 source "test/overlay/Kconfig"
diff --git a/test/Makefile b/test/Makefile
index 178773647a8..8e1fed2c28b 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -3,9 +3,6 @@
 # (C) Copyright 2012 The Chromium Authors
 
 obj-y += test-main.o
-ifdef CONFIG_SPL_LOAD_FIT
-obj-$(CONFIG_SANDBOX) += image/
-endif
 
 ifneq ($(CONFIG_$(SPL_)BLOBLIST),)
 obj-$(CONFIG_$(SPL_)CMDLINE) += bloblist.o
@@ -30,4 +27,6 @@ obj-$(CONFIG_UNIT_TEST) += boot/
 obj-$(CONFIG_UNIT_TEST) += common/
 obj-y += log/
 obj-$(CONFIG_$(SPL_)UT_UNICODE) += unicode_ut.o
+else
+obj-$(CONFIG_SPL_UT_LOAD) += image/
 endif
diff --git a/test/image/Kconfig b/test/image/Kconfig
new file mode 100644
index 00000000000..70ffe0ff276
--- /dev/null
+++ b/test/image/Kconfig
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2023 Sean Anderson <seanga2@gmail.com>
+
+config SPL_UT_LOAD
+	bool "Unit tests for SPL load methods"
+	depends on SPL_UNIT_TEST
+	default y if SANDBOX
+	help
+	  Test various SPL load methods.
+
+if SPL_UT_LOAD
+
+config SPL_UT_LOAD_OS
+	bool "Test loading from the host OS"
+	depends on SANDBOX && SPL_LOAD_FIT
+	default y
+	help
+	  Smoke test to ensure that loading U-boot works in sandbox.
+
+endif
diff --git a/test/image/Makefile b/test/image/Makefile
index c4039df707f..f7ae996bc86 100644
--- a/test/image/Makefile
+++ b/test/image/Makefile
@@ -2,4 +2,5 @@
 #
 # Copyright 2021 Google LLC
 
-obj-$(CONFIG_SPL_BUILD) += spl_load.o
+obj-y += spl_load.o
+obj-$(CONFIG_SPL_UT_LOAD_OS) += spl_load_os.o
diff --git a/test/image/spl_load.c b/test/image/spl_load.c
index 4e27ff460ab..1a57bf846d2 100644
--- a/test/image/spl_load.c
+++ b/test/image/spl_load.c
@@ -1,48 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright 2021 Google LLC
- * Written by Simon Glass <sjg@chromium.org>
+ * Copyright (C) 2023 Sean Anderson <seanga2@gmail.com>
  */
 
 #include <common.h>
-#include <image.h>
 #include <mapmem.h>
-#include <os.h>
-#include <spl.h>
-#include <test/ut.h>
-
-/* Declare a new SPL test */
-#define SPL_TEST(_name, _flags)		UNIT_TEST(_name, _flags, spl_test)
-
-/* Context used for this test */
-struct text_ctx {
-	int fd;
-};
-
-static ulong read_fit_image(struct spl_load_info *load, ulong sector,
-			    ulong count, void *buf)
-{
-	struct text_ctx *text_ctx = load->priv;
-	off_t offset, ret;
-	ssize_t res;
-
-	offset = sector * load->bl_len;
-	ret = os_lseek(text_ctx->fd, offset, OS_SEEK_SET);
-	if (ret != offset) {
-		printf("Failed to seek to %zx, got %zx (errno=%d)\n", offset,
-		       ret, errno);
-		return 0;
-	}
-
-	res = os_read(text_ctx->fd, buf, count * load->bl_len);
-	if (res == -1) {
-		printf("Failed to read %lx bytes, got %ld (errno=%d)\n",
-		       count * load->bl_len, res, errno);
-		return 0;
-	}
-
-	return count;
-}
 
 int board_fit_config_name_match(const char *name)
 {
@@ -53,39 +15,3 @@ struct legacy_img_hdr *spl_get_load_buffer(ssize_t offset, size_t size)
 {
 	return map_sysmem(0x100000, 0);
 }
-
-static int spl_test_load(struct unit_test_state *uts)
-{
-	struct spl_image_info image;
-	struct legacy_img_hdr *header;
-	struct text_ctx text_ctx;
-	struct spl_load_info load;
-	char fname[256];
-	int ret;
-	int fd;
-
-	memset(&load, '\0', sizeof(load));
-	load.bl_len = 512;
-	load.read = read_fit_image;
-
-	ret = sandbox_find_next_phase(fname, sizeof(fname), true);
-	if (ret) {
-		printf("(%s not found, error %d)\n", fname, ret);
-		return ret;
-	}
-	load.filename = fname;
-
-	header = spl_get_load_buffer(-sizeof(*header), sizeof(*header));
-
-	fd = os_open(fname, OS_O_RDONLY);
-	ut_assert(fd >= 0);
-	ut_asserteq(512, os_read(fd, header, 512));
-	text_ctx.fd = fd;
-
-	load.priv = &text_ctx;
-
-	ut_assertok(spl_load_simple_fit(&image, &load, 0, header));
-
-	return 0;
-}
-SPL_TEST(spl_test_load, 0);
diff --git a/test/image/spl_load_os.c b/test/image/spl_load_os.c
new file mode 100644
index 00000000000..bf374f2164d
--- /dev/null
+++ b/test/image/spl_load_os.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2021 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#include <common.h>
+#include <image.h>
+#include <os.h>
+#include <spl.h>
+#include <test/ut.h>
+
+/* Declare a new SPL test */
+#define SPL_TEST(_name, _flags)		UNIT_TEST(_name, _flags, spl_test)
+
+/* Context used for this test */
+struct text_ctx {
+	int fd;
+};
+
+static ulong read_fit_image(struct spl_load_info *load, ulong sector,
+			    ulong count, void *buf)
+{
+	struct text_ctx *text_ctx = load->priv;
+	off_t offset, ret;
+	ssize_t res;
+
+	offset = sector * load->bl_len;
+	ret = os_lseek(text_ctx->fd, offset, OS_SEEK_SET);
+	if (ret != offset) {
+		printf("Failed to seek to %zx, got %zx (errno=%d)\n", offset,
+		       ret, errno);
+		return 0;
+	}
+
+	res = os_read(text_ctx->fd, buf, count * load->bl_len);
+	if (res == -1) {
+		printf("Failed to read %lx bytes, got %ld (errno=%d)\n",
+		       count * load->bl_len, res, errno);
+		return 0;
+	}
+
+	return count;
+}
+
+static int spl_test_load(struct unit_test_state *uts)
+{
+	struct spl_image_info image;
+	struct legacy_img_hdr *header;
+	struct text_ctx text_ctx;
+	struct spl_load_info load;
+	char fname[256];
+	int ret;
+	int fd;
+
+	memset(&load, '\0', sizeof(load));
+	load.bl_len = 512;
+	load.read = read_fit_image;
+
+	ret = sandbox_find_next_phase(fname, sizeof(fname), true);
+	if (ret) {
+		printf("(%s not found, error %d)\n", fname, ret);
+		return ret;
+	}
+	load.filename = fname;
+
+	header = spl_get_load_buffer(-sizeof(*header), sizeof(*header));
+
+	fd = os_open(fname, OS_O_RDONLY);
+	ut_assert(fd >= 0);
+	ut_asserteq(512, os_read(fd, header, 512));
+	text_ctx.fd = fd;
+
+	load.priv = &text_ctx;
+
+	ut_assertok(spl_load_simple_fit(&image, &load, 0, header));
+
+	return 0;
+}
+SPL_TEST(spl_test_load, 0);
-- 
2.37.1

