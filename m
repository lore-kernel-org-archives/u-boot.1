Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A21E937E1
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 11:25:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9672D84119;
	Sun, 12 Apr 2026 13:24:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g783hrTQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8BC88421E; Sun, 12 Apr 2026 13:24:36 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 326E984248
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 13:24:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-66f747175d8so1634986eaf.0
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 04:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775993072; x=1776597872; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LVsX94WfBNFZ9dfeOCiJ3LsiwBs8OAFcDzLzrYwOCjA=;
 b=g783hrTQEMx2JVfPVVRPP/KsSCf5JSHNBikg3kh7Gq2emNkVUgED7TBf6ZtgfzUOLr
 BjXVMN6e6binsvbX6/izo5pcuZzZNXovyLwDGZibfHja28ftyA+AXQpXHwD+RCTbotpD
 KqIL19ZOY0PWb/LWaubo4qXr/2jxdfgF+87ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775993072; x=1776597872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LVsX94WfBNFZ9dfeOCiJ3LsiwBs8OAFcDzLzrYwOCjA=;
 b=LmyEgrGk9v4j7oqV6FOspL3sn+J9iF5HO4Yzpwh/8aiY2a2qBuU+xTtL1mP7lcrIDM
 teBWrV2jQelM8S9Vc35XLGS/fcRH/5W/yr46EtaIKbZ2z8LX7M4BhcwRxTKyyu2zotF0
 A6JkrPd91Q3NFmOmMFDtv9FH5MSK7qlWazPHrl5v6gBjo9W6YLd2Nkt8IvP2A8yaMoZQ
 ABLIhth2PXO3+GryQ+k8pPYh/FxXx7gUj0knMosMDZHttDlL7bOUAD4UXgbue4ODo9xO
 zp8DR91WVMrStKeuXJ1dy+eAwtP9jCHfS3yyUJ3QSfpJUPyGaT2BuB1XjJCiLKebSzZF
 7k6g==
X-Gm-Message-State: AOJu0YzgJLQBilCJSGduKTDlUfWLkXmvWcpXSCQOSATBLShhQQR03e16
 UqnEfy+IhD3i+/fvM++zt8mSxvTaGRf+Ld7LbBNnA9OGNLXBICJcjsCvPXS2i5rZd8Eb8QzhLVs
 pOeLKRg==
X-Gm-Gg: AeBDievxb5Igxz9wxlKZTId5/J6B4l+Pb5r7ASIY5bad+G10j7b1qUnN5Y82gVX1Cwy
 ZMy3wZsJKhTCl0/jevmqjs8pgowP+PVwziIbWkGBC6rjkc5+xjb3wFJsLLVCJL9XV917QvrLDFl
 6omaccRdH8Y7OglPT4bPIvdPh/0qBMJM1Dkd8xK3yT9QqEuGPki9tXdGChi3hQhml5TzPDcG18+
 1hNjRBdXzTozGUbdk1b6BDrnhDqaCs64J/gySNrCtfY+7JC6wgaj9nqIM7t4gs7chDwnYUOr4w0
 bGXCMXW+POaZvvQOBUEzPBs/VSfDFTgCqGCdLjV2YHRohuOg/Et9nq7CW+6rSSBWa31dJ59x+b5
 EUWVAKyvLUr5PGfeHAnMWwDnYqQHeNPvNpPyjYLy0xzImgqTnpyhwU0phvFCYjfmsGSrdGWbK1Z
 6HIFsiP2CoK9wcm/Ogrg==
X-Received: by 2002:a05:6820:134c:b0:67e:29a8:7fd0 with SMTP id
 006d021491bc7-68be8fd0346mr4511743eaf.63.1775993072179; 
 Sun, 12 Apr 2026 04:24:32 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423dd395606sm6622071fac.1.2026.04.12.04.24.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 04:24:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 11/12] test: fs: add C-based filesystem tests
Date: Sun, 12 Apr 2026 05:19:48 -0600
Message-ID: <20260412111958.943933-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260412111958.943933-1-sjg@chromium.org>
References: <20260412111958.943933-1-sjg@chromium.org>
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

Add C implementations of filesystem tests that can be called via
the 'ut fs' command. These tests use UTF_MANUAL flag since they require
external setup, i.e. creation of filesystem images.

This covers the existing TestFsBasic tests.

The tests use typed arguments (fs_type, fs_image, md5 values) passed
via the command line.

Add a few helpers to make the code easier to read.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/test/fs.h  |  39 +++++
 test/Makefile      |   1 +
 test/cmd_ut.c      |   2 +
 test/fs/Makefile   |   3 +
 test/fs/fs_basic.c | 407 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 452 insertions(+)
 create mode 100644 include/test/fs.h
 create mode 100644 test/fs/Makefile
 create mode 100644 test/fs/fs_basic.c

diff --git a/include/test/fs.h b/include/test/fs.h
new file mode 100644
index 00000000000..7fdb8d70451
--- /dev/null
+++ b/include/test/fs.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2026 Canonical Ltd
+ */
+
+#ifndef __TEST_FS_H
+#define __TEST_FS_H
+
+#include <test/test.h>
+#include <test/ut.h>
+
+/**
+ * FS_TEST() - Define a new filesystem test
+ *
+ * @name:	Name of test function
+ * @flags:	Flags for the test (see enum ut_flags)
+ */
+#define FS_TEST(_name, _flags)	UNIT_TEST(_name, UTF_DM | (_flags), fs)
+
+/**
+ * FS_TEST_ARGS() - Define a filesystem test with inline arguments
+ *
+ * Like FS_TEST() but for tests that take arguments.
+ * The test can access arguments via uts->args[].
+ * The NULL terminator is added automatically.
+ *
+ * Example:
+ *   FS_TEST_ARGS(my_test, UTF_MANUAL,
+ *       { "fs_type", UT_ARG_STR },
+ *       { "fs_image", UT_ARG_STR });
+ *
+ * @name:	Name of test function
+ * @flags:	Flags for the test (see enum ut_flags)
+ * @...:	Argument definitions (struct ut_arg_def initializers)
+ */
+#define FS_TEST_ARGS(_name, _flags, ...) \
+	UNIT_TEST_ARGS(_name, UTF_DM | (_flags), fs, __VA_ARGS__)
+
+#endif /* __TEST_FS_H */
diff --git a/test/Makefile b/test/Makefile
index 5676bd35963..02ded045995 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -22,6 +22,7 @@ obj-y += boot/
 obj-y += common/
 obj-$(CONFIG_UT_ENV) += env/
 obj-$(CONFIG_UT_FDT_OVERLAY) += fdt_overlay/
+obj-$(CONFIG_SANDBOX) += fs/
 obj-y += log/
 else
 obj-$(CONFIG_SPL_UT_LOAD) += image/
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 9d36bd5dc87..827fcbc9fcb 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -60,6 +60,7 @@ SUITE_DECL(exit);
 SUITE_DECL(fdt);
 SUITE_DECL(fdt_overlay);
 SUITE_DECL(font);
+SUITE_DECL(fs);
 SUITE_DECL(hush);
 SUITE_DECL(lib);
 SUITE_DECL(loadm);
@@ -87,6 +88,7 @@ static struct suite suites[] = {
 	SUITE(fdt, "fdt command"),
 	SUITE(fdt_overlay, "device tree overlays"),
 	SUITE(font, "font command"),
+	SUITE(fs, "filesystem tests"),
 	SUITE(hush, "hush behaviour"),
 	SUITE(lib, "library functions"),
 	SUITE(loadm, "loadm command parameters and loading memory blob"),
diff --git a/test/fs/Makefile b/test/fs/Makefile
new file mode 100644
index 00000000000..5899be8e667
--- /dev/null
+++ b/test/fs/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-y += fs_basic.o
diff --git a/test/fs/fs_basic.c b/test/fs/fs_basic.c
new file mode 100644
index 00000000000..a6f1e056f5b
--- /dev/null
+++ b/test/fs/fs_basic.c
@@ -0,0 +1,407 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Basic filesystem tests - C implementation for Python wrapper
+ *
+ * These tests are marked UTF_MANUAL and are intended to be called from
+ * test_basic.py which sets up the filesystem image and expected values.
+ *
+ * Copyright 2026 Canonical Ltd
+ */
+
+#include <command.h>
+#include <dm.h>
+#include <env.h>
+#include <fs.h>
+#include <hexdump.h>
+#include <image.h>
+#include <linux/sizes.h>
+#include <mapmem.h>
+#include <test/fs.h>
+#include <test/test.h>
+#include <test/ut.h>
+#include <u-boot/md5.h>
+
+/* Test constants matching fstest_defs.py */
+#define ADDR	0x01000008
+
+/*
+ * Common argument indices. Each test declares only the arguments it needs,
+ * so indices 2+ vary per test - see comments in each test.
+ */
+#define FS_ARG_TYPE	0	/* fs_type: ext4, fat, exfat, fs_generic */
+#define FS_ARG_IMAGE	1	/* fs_image: path to filesystem image */
+
+/* Common arguments for all filesystem tests (indices 0 and 1) */
+#define COMMON_ARGS \
+	{ "fs_type", UT_ARG_STR }, \
+	{ "fs_image", UT_ARG_STR }
+
+/**
+ * get_fs_type(uts) - Get filesystem type enum from test argument
+ *
+ * Reads the fs_type argument and returns the appropriate FS_TYPE_* enum value.
+ *
+ * Return: filesystem type enum
+ */
+static int get_fs_type(struct unit_test_state *uts)
+{
+	const char *fs_type = ut_str(FS_ARG_TYPE);
+
+	if (!fs_type)
+		return FS_TYPE_ANY;
+
+	if (!strcmp(fs_type, "ext4"))
+		return FS_TYPE_EXT;
+	if (!strcmp(fs_type, "fat"))
+		return FS_TYPE_FAT;
+	if (!strcmp(fs_type, "exfat"))
+		return FS_TYPE_EXFAT;
+
+	/* fs_generic uses FS_TYPE_ANY */
+	return FS_TYPE_ANY;
+}
+
+/* Set up the host filesystem block device */
+static int set_fs(struct unit_test_state *uts)
+{
+	return fs_set_blk_dev("host", "0:0", get_fs_type(uts));
+}
+
+/* Build a path by prepending "/" to the leaf filename, with optional suffix */
+static const char *getpath(struct unit_test_state *uts, const char *leaf,
+			   const char *suffix)
+{
+	snprintf(uts->priv, sizeof(uts->priv), "/%s%s", leaf, suffix ?: "");
+
+	return uts->priv;
+}
+
+/**
+ * prep_fs() - Prepare filesystem for testing
+ *
+ * Binds the fs_image argument as host device 0, sets up the block device,
+ * and optionally returns a zeroed buffer.
+ *
+ * @uts: Unit test state
+ * @len: Length of buffer to allocate and zero, or 0 for none
+ * @bufp: Returns pointer to zeroed buffer, or NULL if @len is 0
+ * Return: 0 on success, negative on error
+ */
+static int prep_fs(struct unit_test_state *uts, uint len, void **bufp)
+{
+	const char *fs_image = ut_str(FS_ARG_IMAGE);
+
+	ut_assertnonnull(fs_image);
+	ut_assertok(run_commandf("host bind 0 %s", fs_image));
+	ut_assertok(set_fs(uts));
+
+	if (len) {
+		*bufp = map_sysmem(ADDR, len);
+		memset(*bufp, '\0', len);
+	}
+
+	return 0;
+}
+
+/**
+ * fs_write_supported(uts) - Check if write is supported for current fs type
+ *
+ * Reads the fs_type argument and checks if write support is enabled
+ * for that filesystem type.
+ *
+ * Return: true if write is supported, false otherwise
+ */
+static bool fs_write_supported(struct unit_test_state *uts)
+{
+	const char *fs_type = ut_str(FS_ARG_TYPE);
+
+	if (!fs_type)
+		return false;
+
+	if (!strcmp(fs_type, "ext4"))
+		return IS_ENABLED(CONFIG_EXT4_WRITE);
+	if (!strcmp(fs_type, "fat"))
+		return IS_ENABLED(CONFIG_CMD_FAT_WRITE);
+
+	/* fs_generic and exfat use generic write which is always available */
+	return true;
+}
+
+/**
+ * verify_md5() - Calculate MD5 of buffer and verify against expected
+ *
+ * Uses arg 3 (md5val) as the expected MD5 hex string.
+ *
+ * @uts: Unit test state
+ * @buf: Buffer to calculate MD5 of
+ * @len: Length of buffer
+ *
+ * Return: 0 if MD5 matches, -EINVAL otherwise
+ */
+static int verify_md5(struct unit_test_state *uts, const void *buf, size_t len)
+{
+	u8 digest[MD5_SUM_LEN], expected[MD5_SUM_LEN];
+	const char *expected_hex = ut_str(3);
+
+	ut_assertok(hex2bin(expected, expected_hex, MD5_SUM_LEN));
+
+	md5_wd(buf, len, digest, CHUNKSZ_MD5);
+	ut_asserteq_mem(expected, digest, MD5_SUM_LEN);
+
+	return 0;
+}
+
+/* Test Case 1 - ls command, listing root directory and invalid directory */
+static int fs_test_ls_norun(struct unit_test_state *uts)
+{
+	const char *small = ut_str(2);
+	const char *big = ut_str(3);
+	struct fs_dir_stream *dirs;
+	struct fs_dirent *dent;
+	bool found_big = false, found_small = false, found_subdir = false;
+
+	ut_assertok(prep_fs(uts, 0, NULL));
+
+	/* Test listing root directory */
+	dirs = fs_opendir("/");
+	ut_assertnonnull(dirs);
+
+	while ((dent = fs_readdir(dirs))) {
+		if (!strcmp(dent->name, big)) {
+			found_big = true;
+			ut_asserteq(FS_DT_REG, dent->type);
+		} else if (!strcmp(dent->name, small)) {
+			found_small = true;
+			ut_asserteq(FS_DT_REG, dent->type);
+		} else if (!strcmp(dent->name, "SUBDIR")) {
+			found_subdir = true;
+			ut_asserteq(FS_DT_DIR, dent->type);
+		}
+	}
+	fs_closedir(dirs);
+
+	ut_assert(found_big);
+	ut_assert(found_small);
+	ut_assert(found_subdir);
+
+	/* Test invalid directory returns error */
+	ut_assertok(set_fs(uts));
+	dirs = fs_opendir("/invalid_d");
+	ut_assertnull(dirs);
+
+	/* Test file exists */
+	ut_assertok(set_fs(uts));
+	ut_assert(fs_exists(small));
+
+	/* Test non-existent file */
+	ut_assertok(set_fs(uts));
+	ut_assert(!fs_exists("nonexistent.file"));
+
+	return 0;
+}
+FS_TEST_ARGS(fs_test_ls_norun, UTF_SCAN_FDT | UTF_CONSOLE | UTF_MANUAL,
+	     COMMON_ARGS, { "small", UT_ARG_STR }, { "big", UT_ARG_STR });
+
+/* Test Case 2 - size command for small file (1MB) */
+static int fs_test_size_small_norun(struct unit_test_state *uts)
+{
+	const char *small = ut_str(2);
+	loff_t size;
+
+	ut_assertok(prep_fs(uts, 0, NULL));
+	ut_assertok(fs_size(getpath(uts, small, NULL), &size));
+	ut_asserteq(SZ_1M, size);
+
+	/* Test size via path with '..' */
+	ut_assertok(set_fs(uts));
+	snprintf(uts->priv, sizeof(uts->priv), "/SUBDIR/../%s", small);
+	ut_assertok(fs_size(uts->priv, &size));
+	ut_asserteq(SZ_1M, size);
+
+	return 0;
+}
+FS_TEST_ARGS(fs_test_size_small_norun, UTF_SCAN_FDT | UTF_MANUAL,
+	     COMMON_ARGS, { "small", UT_ARG_STR });
+
+/* Test Case 3 - size command for large file (2500 MiB) */
+static int fs_test_size_big_norun(struct unit_test_state *uts)
+{
+	const char *big = ut_str(2);
+	loff_t size;
+
+	ut_assertok(prep_fs(uts, 0, NULL));
+	ut_assertok(fs_size(getpath(uts, big, NULL), &size));
+	ut_asserteq_64((loff_t)SZ_1M * 2500, size);  /* 2500 MiB = 0x9c400000 */
+
+	return 0;
+}
+FS_TEST_ARGS(fs_test_size_big_norun, UTF_SCAN_FDT | UTF_MANUAL,
+	     COMMON_ARGS, { "big", UT_ARG_STR });
+
+/* Load a file at a given offset and verify the size and MD5 */
+static int check_load(struct unit_test_state *uts, const char *fname,
+		      ulong offset, ulong read_len, ulong expect_len,
+		      bool check_md5)
+{
+	loff_t actual;
+	void *buf;
+
+	ut_assertok(prep_fs(uts, expect_len, &buf));
+	ut_assertok(fs_read(getpath(uts, fname, NULL), ADDR, offset, read_len,
+			    &actual));
+	ut_asserteq(expect_len, actual);
+	if (check_md5)
+		ut_assertok(verify_md5(uts, buf, expect_len));
+
+	return 0;
+}
+
+/* Test Case 4 - load small file, verify MD5 */
+static int fs_test_load_small_norun(struct unit_test_state *uts)
+{
+	return check_load(uts, ut_str(2), 0, 0, SZ_1M, true);
+}
+FS_TEST_ARGS(fs_test_load_small_norun, UTF_SCAN_FDT | UTF_MANUAL,
+	     COMMON_ARGS, { "small", UT_ARG_STR }, { "md5val", UT_ARG_STR });
+
+/* Test Case 5 - load first 1MB of big file */
+static int fs_test_load_big_first_norun(struct unit_test_state *uts)
+{
+	return check_load(uts, ut_str(2), 0, SZ_1M, SZ_1M, true);
+}
+FS_TEST_ARGS(fs_test_load_big_first_norun, UTF_SCAN_FDT | UTF_MANUAL,
+	     COMMON_ARGS, { "big", UT_ARG_STR }, { "md5val", UT_ARG_STR });
+
+/* Test Case 6 - load last 1MB of big file (offset 0x9c300000) */
+static int fs_test_load_big_last_norun(struct unit_test_state *uts)
+{
+	return check_load(uts, ut_str(2), 0x9c300000, SZ_1M, SZ_1M, true);
+}
+FS_TEST_ARGS(fs_test_load_big_last_norun, UTF_SCAN_FDT | UTF_MANUAL,
+	     COMMON_ARGS, { "big", UT_ARG_STR }, { "md5val", UT_ARG_STR });
+
+/* Test Case 7 - load 1MB from last 1MB chunk of 2GB (offset 0x7ff00000) */
+static int fs_test_load_big_2g_last_norun(struct unit_test_state *uts)
+{
+	return check_load(uts, ut_str(2), 0x7ff00000, SZ_1M, SZ_1M, true);
+}
+FS_TEST_ARGS(fs_test_load_big_2g_last_norun, UTF_SCAN_FDT | UTF_MANUAL,
+	     COMMON_ARGS, { "big", UT_ARG_STR }, { "md5val", UT_ARG_STR });
+
+/* Test Case 8 - load first 1MB in 2GB region (offset 0x80000000) */
+static int fs_test_load_big_2g_first_norun(struct unit_test_state *uts)
+{
+	return check_load(uts, ut_str(2), 0x80000000, SZ_1M, SZ_1M, true);
+}
+FS_TEST_ARGS(fs_test_load_big_2g_first_norun, UTF_SCAN_FDT | UTF_MANUAL,
+	     COMMON_ARGS, { "big", UT_ARG_STR }, { "md5val", UT_ARG_STR });
+
+/* Test Case 9 - load 1MB crossing 2GB boundary (offset 0x7ff80000) */
+static int fs_test_load_big_2g_cross_norun(struct unit_test_state *uts)
+{
+	return check_load(uts, ut_str(2), 0x7ff80000, SZ_1M, SZ_1M, true);
+}
+FS_TEST_ARGS(fs_test_load_big_2g_cross_norun, UTF_SCAN_FDT | UTF_MANUAL,
+	     COMMON_ARGS, { "big", UT_ARG_STR }, { "md5val", UT_ARG_STR });
+
+/* Test Case 10 - load beyond file end (2MB from offset, only 1MB remains) */
+static int fs_test_load_beyond_norun(struct unit_test_state *uts)
+{
+	return check_load(uts, ut_str(2), 0x9c300000, SZ_2M, SZ_1M, false);
+}
+FS_TEST_ARGS(fs_test_load_beyond_norun, UTF_SCAN_FDT | UTF_MANUAL,
+	     COMMON_ARGS, { "big", UT_ARG_STR });
+
+/* Test Case 11 - write file */
+static int fs_test_write_norun(struct unit_test_state *uts)
+{
+	const char *small = ut_str(2);
+	loff_t actread, actwrite;
+	void *buf;
+
+	if (!fs_write_supported(uts))
+		return -EAGAIN;
+
+	ut_assertok(prep_fs(uts, SZ_1M, &buf));
+
+	/* Read small file */
+	ut_assertok(fs_read(getpath(uts, small, NULL), ADDR, 0, 0, &actread));
+	ut_asserteq(SZ_1M, actread);
+
+	/* Write it back with new name */
+	ut_assertok(set_fs(uts));
+	ut_assertok(fs_write(getpath(uts, small, ".w"), ADDR, 0, SZ_1M,
+			     &actwrite));
+	ut_asserteq(SZ_1M, actwrite);
+
+	/* Read back and verify MD5 */
+	ut_assertok(set_fs(uts));
+	memset(buf, '\0', SZ_1M);
+	ut_assertok(fs_read(getpath(uts, small, ".w"), ADDR, 0, 0, &actread));
+	ut_asserteq(SZ_1M, actread);
+
+	ut_assertok(verify_md5(uts, buf, SZ_1M));
+
+	return 0;
+}
+FS_TEST_ARGS(fs_test_write_norun, UTF_SCAN_FDT | UTF_MANUAL,
+	     COMMON_ARGS, { "small", UT_ARG_STR }, { "md5val", UT_ARG_STR });
+
+/* Test Case 12 - write to "." directory (should fail) */
+static int fs_test_write_dot_norun(struct unit_test_state *uts)
+{
+	loff_t actwrite;
+
+	if (!fs_write_supported(uts))
+		return -EAGAIN;
+
+	ut_assertok(prep_fs(uts, 0, NULL));
+
+	/* Writing to "." should fail */
+	ut_assert(fs_write("/.", ADDR, 0, 0x10, &actwrite));
+
+	return 0;
+}
+FS_TEST_ARGS(fs_test_write_dot_norun, UTF_SCAN_FDT | UTF_MANUAL,
+	     COMMON_ARGS);
+
+/* Test Case 13 - write via "./" path */
+static int fs_test_write_dotpath_norun(struct unit_test_state *uts)
+{
+	const char *small = ut_str(2);
+	loff_t actread, actwrite;
+	void *buf;
+
+	if (!fs_write_supported(uts))
+		return -EAGAIN;
+
+	ut_assertok(prep_fs(uts, SZ_1M, &buf));
+
+	/* Read small file */
+	ut_assertok(fs_read(getpath(uts, small, NULL), ADDR, 0, 0, &actread));
+	ut_asserteq(SZ_1M, actread);
+
+	/* Write via "./" path */
+	ut_assertok(set_fs(uts));
+	snprintf(uts->priv, sizeof(uts->priv), "/./%s2", small);
+	ut_assertok(fs_write(uts->priv, ADDR, 0, SZ_1M, &actwrite));
+	ut_asserteq(SZ_1M, actwrite);
+
+	/* Read back via "./" path and verify */
+	ut_assertok(set_fs(uts));
+	memset(buf, '\0', SZ_1M);
+	ut_assertok(fs_read(uts->priv, ADDR, 0, 0, &actread));
+	ut_asserteq(SZ_1M, actread);
+	ut_assertok(verify_md5(uts, buf, SZ_1M));
+
+	/* Also verify via normal path */
+	ut_assertok(set_fs(uts));
+	memset(buf, '\0', SZ_1M);
+	ut_assertok(fs_read(getpath(uts, small, "2"), ADDR, 0, 0, &actread));
+	ut_asserteq(SZ_1M, actread);
+	ut_assertok(verify_md5(uts, buf, SZ_1M));
+
+	return 0;
+}
+FS_TEST_ARGS(fs_test_write_dotpath_norun, UTF_SCAN_FDT | UTF_MANUAL,
+	     COMMON_ARGS, { "small", UT_ARG_STR }, { "md5val", UT_ARG_STR });
-- 
2.43.0

