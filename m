Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14935CDB465
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 02:34:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B64F86EC2;
	Thu, 12 Oct 2023 04:04:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DioLZTku";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD1AE86E4B; Thu, 12 Oct 2023 04:02:00 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51CD786E9E
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 03:58:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-774105e8c37so30428985a.3
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 18:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697075810; x=1697680610; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iqRQQ8mb6NmMoqQhmfAcTVNnE1hSRrDonFFsebjbr3Q=;
 b=DioLZTku1nMiC51ZSQxdqI9wJj0HOlMRZAMYTn9/94enGVxrCqng+vmGYHzG9B3TK5
 m85pP+HTaq80K3FUUew00SlVp/kDAVigGF1Ah2jml9uJaps3WlXpHxD9Usv1y+Azh43B
 D2+NsZuRzSSDqIaX2308WmKkBPp3zSYwq7vjGqvOCIuj1y2K+Ikm2wRv84Xv6/S3dH8C
 D+P4vJdv1/L2695uj/qY4JsGyTook9WiyfkZZ7ZwtlJcN7TB5LIShy+ZPeh0YpZJEdSG
 ceGVwZ3mRVWrzl6uHTrFWbm+BBhNOcMlduR+UG2Itj5tVLXQ3WedmeeRq29RuOvQvL3X
 X8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697075810; x=1697680610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iqRQQ8mb6NmMoqQhmfAcTVNnE1hSRrDonFFsebjbr3Q=;
 b=X1H5h//f9qP5/MPqIqL29cuzaNkL4KsanQuwI9ti25hI3S4XW4jTwk6VmsyV8h0ivz
 LtzthZuBy1C9JPsDJt3HKrMGPu8W2SJ4ldrJyyBV6x8Yybe304+kz2vsHgXkJdIfRap/
 d1dk7e8qazmf9pgs2+Iu8kKuB+sjx0aHZuW+9g5I1iGnsln+PfOsgxS9IGm/EweAlxtj
 +Iv3WZK2rTJ8pDGjvaA+N7CvC6Kp4cO6u64dFC1L2k1q9ibrcX1lVHSRvI4KCWQEL95u
 WYSS5pFMNd/S4MyiCKiZIVKs6yN3MNxl2eLkRCG+Fta+nuuJhd33iJUVDJRXJOL/b60u
 rNrA==
X-Gm-Message-State: AOJu0YwO75mVgn4Da266EormjgufBat1ApfYapxC2d0r6iNVhLBqiS4v
 uFHSUYzrDrauDKQ4eSrxgYzIO/U6M4cfqw==
X-Google-Smtp-Source: AGHT+IE5amhd3Aq/NIXFtNYyAwGEc40W0HnN7JZ38J5wOSLPjup1msgEf/lpOBmLrCewJNk3i2gRcQ==
X-Received: by 2002:a05:620a:29d2:b0:776:fad0:cc3c with SMTP id
 s18-20020a05620a29d200b00776fad0cc3cmr17497007qkp.4.1697075809838; 
 Wed, 11 Oct 2023 18:56:49 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 d9-20020a05620a166900b00773fe8971bbsm5666940qko.90.2023.10.11.18.56.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 18:56:49 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 18/26] test: spl: Split tests up and use some configs
Date: Wed, 11 Oct 2023 21:56:18 -0400
Message-Id: <20231012015626.3487451-19-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231012015626.3487451-1-seanga2@gmail.com>
References: <20231012015626.3487451-1-seanga2@gmail.com>
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
---

 test/Kconfig             |  1 +
 test/Makefile            |  5 +--
 test/image/Kconfig       | 20 ++++++++++
 test/image/Makefile      |  3 +-
 test/image/spl_load.c    | 76 +------------------------------------
 test/image/spl_load_os.c | 81 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 107 insertions(+), 79 deletions(-)
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
index c4039df707f..1f62d54453c 100644
--- a/test/image/Makefile
+++ b/test/image/Makefile
@@ -2,4 +2,5 @@
 #
 # Copyright 2021 Google LLC
 
-obj-$(CONFIG_SPL_BUILD) += spl_load.o
+obj-$(CONFIG_SPL_UT_LOAD) += spl_load.o
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
index 00000000000..06daa3700b8
--- /dev/null
+++ b/test/image/spl_load_os.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2021 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#include <common.h>
+#include <image.h>
+#include <mapmem.h>
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

