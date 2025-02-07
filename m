Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E69C02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 18:32:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1E5080840;
	Fri,  7 Feb 2025 19:31:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kms/f6QG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB37D808E6; Fri,  7 Feb 2025 19:31:49 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FE4480819
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 19:31:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-844e39439abso65509639f.1
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 10:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738953105; x=1739557905; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d6/wmGBIF1XCwWTU1BqVVTuf+IK8NiLTPoaXxyEtulQ=;
 b=kms/f6QGCaHnGf5aev86zCrDEtw53e81AyjFnBNj32aIZOQknoUmX5t6CyFyEKFURP
 V8jkIGKT/vO0SDbMElXb7NsL+tCeKDeelqDymQ+ULII7ETXzrs50LeWpp+QinQGr6RM1
 sT9zryHW9fy4oHQl+8KZajpdbIHKhA4rbPw14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738953105; x=1739557905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d6/wmGBIF1XCwWTU1BqVVTuf+IK8NiLTPoaXxyEtulQ=;
 b=tVmPyx3hiHMpDYAgtDG7P3WbKS/qmWrtBswiykq8E3LTqFjbwDRJNiiWqXjobvjXkr
 skEJkMf6GPwfKVvX8igbvCoFF/vU9iU+Yvi4hYJZdvulaf2An8eHj+mUs6ioGj9hVc7C
 GYH3qHqE6t3Aj4+Z2achk4KWfnvOV/aC5GCSjgewQnVF7+L//Bqwr+2+PgoIy8kc3OIM
 EWxgLD3sg2HN/CVzx7Nf1cZA1vxcRJoWQ0842clPCDLzgCXSFWWA2lkRFa7kj4Ay9gCz
 idOB3vRWsj8RHIpY/Zg6BfZXQ3a+cS7U/pmceJixuWyYSWIUUGfvW3Ac9ruwbz6VI7H4
 PH8g==
X-Gm-Message-State: AOJu0YyI2ZPJzKYSXWC3kxLKv5RW0kv1su+dwWiqeYRHk5fIr8hKWceX
 QpIVYv3MKZauxB0k4zN6BwToiO8SRhunhmUrqZzyvNwh5bkH3kn5hgjdpnm98G11Je9FrhZ72PM
 =
X-Gm-Gg: ASbGncu0T02n4wNzia3mTrHHcmYNqcgHBSZ2k/wW/pRKfmCIwajn+7XZbsF9g7iJaHM
 g9C6Yw2IsCzfJWrwdcTNgJPML6Ul+c4LLS+2KhoATBjy2Wm/5cj30AMefKQdM17hpbXKoBhMCDL
 lsy+kC+jppz29hKPIazw+IlGZHvhu3xL+UaVZJXl0QECB9gb6ou20j1ZEChQxglu7487e55c0mB
 d1n9ZybvomGH3TogiNl4W2Nwm7kq4VSs2I58BZdNT0AQZz6CF/AIjXxbdUihQ6W8manDTr190BM
 bHW+0HXx/KFwLG9UOyEPz13r+SHueL3BSu5MYb3a+xMV0dbgUlfd
X-Google-Smtp-Source: AGHT+IH/KQy73Ww+uh5yqyT7edHmC69ffPUKeVfxfwJRsU/qz4Y0770Y70wEWIYJWQyQo7UnHHnq5g==
X-Received: by 2002:a05:6602:7210:b0:847:51e2:eac with SMTP id
 ca18e2360f4ac-854fd8b43f4mr497565039f.7.1738953105012; 
 Fri, 07 Feb 2025 10:31:45 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-854f67bc3ecsm74850439f.47.2025.02.07.10.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 10:31:43 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 08/29] test: Tweak FDT-overlay tests
Date: Fri,  7 Feb 2025 11:30:39 -0700
Message-ID: <20250207183121.117663-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207183121.117663-1-sjg@chromium.org>
References: <20250207183121.117663-1-sjg@chromium.org>
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

Use fdt_overlay consistently in the identifiers and file/dir names.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 Makefile                                      |  2 +-
 include/test/{overlay.h => fdt_overlay.h}     |  4 +-
 include/test/suites.h                         |  4 +-
 test/Kconfig                                  |  2 +-
 test/cmd_ut.c                                 |  8 +--
 test/{overlay => fdt_overlay}/Kconfig         |  2 +-
 test/{overlay => fdt_overlay}/Makefile        |  2 +-
 .../cmd_ut_fdt_overlay.c}                     | 49 ++++++++++---------
 .../test-fdt-base.dts                         |  0
 .../test-fdt-overlay-stacked.dtso             |  0
 .../test-fdt-overlay.dtso                     |  0
 test/py/tests/test_suite.py                   |  4 +-
 12 files changed, 39 insertions(+), 38 deletions(-)
 rename include/test/{overlay.h => fdt_overlay.h} (66%)
 rename test/{overlay => fdt_overlay}/Kconfig (93%)
 rename test/{overlay => fdt_overlay}/Makefile (89%)
 rename test/{overlay/cmd_ut_overlay.c => fdt_overlay/cmd_ut_fdt_overlay.c} (77%)
 rename test/{overlay => fdt_overlay}/test-fdt-base.dts (100%)
 rename test/{overlay => fdt_overlay}/test-fdt-overlay-stacked.dtso (100%)
 rename test/{overlay => fdt_overlay}/test-fdt-overlay.dtso (100%)

diff --git a/Makefile b/Makefile
index 2f7614191a1..db663979206 100644
--- a/Makefile
+++ b/Makefile
@@ -895,7 +895,7 @@ endif
 libs-$(CONFIG_$(PHASE_)UNIT_TEST) += test/
 libs-$(CONFIG_UT_ENV) += test/env/
 libs-$(CONFIG_UT_OPTEE) += test/optee/
-libs-$(CONFIG_UT_OVERLAY) += test/overlay/
+libs-$(CONFIG_UT_FDT_OVERLAY) += test/fdt_overlay/
 
 libs-y += $(if $(wildcard $(srctree)/board/$(BOARDDIR)/Makefile),board/$(BOARDDIR)/)
 
diff --git a/include/test/overlay.h b/include/test/fdt_overlay.h
similarity index 66%
rename from include/test/overlay.h
rename to include/test/fdt_overlay.h
index 5dc98399ce7..34e8020a496 100644
--- a/include/test/overlay.h
+++ b/include/test/fdt_overlay.h
@@ -9,7 +9,7 @@
 
 #include <test/test.h>
 
-/* Declare a new environment test */
-#define OVERLAY_TEST(_name, _flags)	UNIT_TEST(_name, _flags, overlay)
+/* Declare a new FDT-overlay test */
+#define FDT_OVERLAY_TEST(_name, _flags)	UNIT_TEST(_name, _flags, fdt_overlay)
 
 #endif /* __TEST_OVERLAY_H__ */
diff --git a/include/test/suites.h b/include/test/suites.h
index 774dd893378..dce720b4e78 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -36,8 +36,8 @@ int cmd_ut_category(struct unit_test_state *uts, const char *name,
 
 int do_ut_bootstd(struct unit_test_state *uts, struct cmd_tbl *cmdtp, int flag,
 		  int argc, char *const argv[]);
+int do_ut_fdt_overlay(struct unit_test_state *uts, struct cmd_tbl *cmdtp,
+		      int flag, int argc, char *const argv[]);
 int do_ut_optee(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
-int do_ut_overlay(struct unit_test_state *uts, struct cmd_tbl *cmdtp, int flag,
-		  int argc, char *const argv[]);
 
 #endif /* __TEST_SUITES_H__ */
diff --git a/test/Kconfig b/test/Kconfig
index 1c8e3d16300..01d64642fdb 100644
--- a/test/Kconfig
+++ b/test/Kconfig
@@ -120,7 +120,7 @@ source "test/env/Kconfig"
 source "test/image/Kconfig"
 source "test/lib/Kconfig"
 source "test/optee/Kconfig"
-source "test/overlay/Kconfig"
+source "test/fdt_overlay/Kconfig"
 
 config POST
 	bool "Power On Self Test support"
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 0b923ee7e2e..958b591c605 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -105,6 +105,7 @@ SUITE_DECL(dm);
 SUITE_DECL(env);
 SUITE_DECL(exit);
 SUITE_DECL(fdt);
+SUITE_DECL(fdt_overlay);
 SUITE_DECL(font);
 SUITE_DECL(hush);
 SUITE_DECL(lib);
@@ -114,7 +115,6 @@ SUITE_DECL(mbr);
 SUITE_DECL(measurement);
 SUITE_DECL(mem);
 SUITE_DECL(optee);
-SUITE_DECL(overlay);
 SUITE_DECL(pci_mps);
 SUITE_DECL(seama);
 SUITE_DECL(setexpr);
@@ -134,6 +134,9 @@ static struct suite suites[] = {
 	SUITE(env, "environment"),
 	SUITE(exit, "shell exit and variables"),
 	SUITE(fdt, "fdt command"),
+#ifdef CONFIG_UT_FDT_OVERLAY
+	SUITE_CMD(fdt_overlay, do_ut_fdt_overlay, "device tree overlays"),
+#endif
 	SUITE(font, "font command"),
 	SUITE(hush, "hush behaviour"),
 	SUITE(lib, "library functions"),
@@ -144,9 +147,6 @@ static struct suite suites[] = {
 	SUITE(mem, "memory-related commands"),
 #ifdef CONFIG_UT_OPTEE
 	SUITE_CMD(optee, do_ut_optee, "OP-TEE"),
-#endif
-#ifdef CONFIG_UT_OVERLAY
-	SUITE_CMD(overlay, do_ut_overlay, "device tree overlays"),
 #endif
 	SUITE(pci_mps, "PCI Express Maximum Payload Size"),
 	SUITE(seama, "seama command parameters loading and decoding"),
diff --git a/test/overlay/Kconfig b/test/fdt_overlay/Kconfig
similarity index 93%
rename from test/overlay/Kconfig
rename to test/fdt_overlay/Kconfig
index 881848968bb..c2bb70fc970 100644
--- a/test/overlay/Kconfig
+++ b/test/fdt_overlay/Kconfig
@@ -1,4 +1,4 @@
-config UT_OVERLAY
+config UT_FDT_OVERLAY
 	bool "Enable Device Tree Overlays Unit Tests"
 	depends on UNIT_TEST && OF_CONTROL && SANDBOX
 	default y
diff --git a/test/overlay/Makefile b/test/fdt_overlay/Makefile
similarity index 89%
rename from test/overlay/Makefile
rename to test/fdt_overlay/Makefile
index 47937e3c108..5625c0d8885 100644
--- a/test/overlay/Makefile
+++ b/test/fdt_overlay/Makefile
@@ -4,7 +4,7 @@
 # Copyright (c) 2016 Free Electrons
 
 # Test files
-obj-y += cmd_ut_overlay.o
+obj-y += cmd_ut_fdt_overlay.o
 
 DTC_FLAGS += -@
 
diff --git a/test/overlay/cmd_ut_overlay.c b/test/fdt_overlay/cmd_ut_fdt_overlay.c
similarity index 77%
rename from test/overlay/cmd_ut_overlay.c
rename to test/fdt_overlay/cmd_ut_fdt_overlay.c
index aefa147ec04..9fe18b60aca 100644
--- a/test/overlay/cmd_ut_overlay.c
+++ b/test/fdt_overlay/cmd_ut_fdt_overlay.c
@@ -13,8 +13,8 @@
 
 #include <linux/sizes.h>
 
+#include <test/fdt_overlay.h>
 #include <test/ut.h>
-#include <test/overlay.h>
 #include <test/suites.h>
 
 /* 4k ought to be enough for anybody */
@@ -68,7 +68,7 @@ static int fdt_getprop_str(void *fdt, const char *path, const char *name,
 	return len < 0 ? len : 0;
 }
 
-static int fdt_overlay_change_int_property(struct unit_test_state *uts)
+static int fdt_overlay_test_change_int_property(struct unit_test_state *uts)
 {
 	u32 val = 0;
 
@@ -78,9 +78,9 @@ static int fdt_overlay_change_int_property(struct unit_test_state *uts)
 
 	return CMD_RET_SUCCESS;
 }
-OVERLAY_TEST(fdt_overlay_change_int_property, 0);
+FDT_OVERLAY_TEST(fdt_overlay_test_change_int_property, 0);
 
-static int fdt_overlay_change_str_property(struct unit_test_state *uts)
+static int fdt_overlay_test_change_str_property(struct unit_test_state *uts)
 {
 	const char *val = NULL;
 
@@ -90,9 +90,9 @@ static int fdt_overlay_change_str_property(struct unit_test_state *uts)
 
 	return CMD_RET_SUCCESS;
 }
-OVERLAY_TEST(fdt_overlay_change_str_property, 0);
+FDT_OVERLAY_TEST(fdt_overlay_test_change_str_property, 0);
 
-static int fdt_overlay_add_str_property(struct unit_test_state *uts)
+static int fdt_overlay_test_add_str_property(struct unit_test_state *uts)
 {
 	const char *val = NULL;
 
@@ -102,9 +102,9 @@ static int fdt_overlay_add_str_property(struct unit_test_state *uts)
 
 	return CMD_RET_SUCCESS;
 }
-OVERLAY_TEST(fdt_overlay_add_str_property, 0);
+FDT_OVERLAY_TEST(fdt_overlay_test_add_str_property, 0);
 
-static int fdt_overlay_add_node_by_phandle(struct unit_test_state *uts)
+static int fdt_overlay_test_add_node_by_phandle(struct unit_test_state *uts)
 {
 	int off;
 
@@ -115,9 +115,9 @@ static int fdt_overlay_add_node_by_phandle(struct unit_test_state *uts)
 
 	return CMD_RET_SUCCESS;
 }
-OVERLAY_TEST(fdt_overlay_add_node_by_phandle, 0);
+FDT_OVERLAY_TEST(fdt_overlay_test_add_node_by_phandle, 0);
 
-static int fdt_overlay_add_node_by_path(struct unit_test_state *uts)
+static int fdt_overlay_test_add_node_by_path(struct unit_test_state *uts)
 {
 	int off;
 
@@ -128,9 +128,9 @@ static int fdt_overlay_add_node_by_path(struct unit_test_state *uts)
 
 	return CMD_RET_SUCCESS;
 }
-OVERLAY_TEST(fdt_overlay_add_node_by_path, 0);
+FDT_OVERLAY_TEST(fdt_overlay_test_add_node_by_path, 0);
 
-static int fdt_overlay_add_subnode_property(struct unit_test_state *uts)
+static int fdt_overlay_test_add_subnode_property(struct unit_test_state *uts)
 {
 	int off;
 
@@ -142,9 +142,9 @@ static int fdt_overlay_add_subnode_property(struct unit_test_state *uts)
 
 	return CMD_RET_SUCCESS;
 }
-OVERLAY_TEST(fdt_overlay_add_subnode_property, 0);
+FDT_OVERLAY_TEST(fdt_overlay_test_add_subnode_property, 0);
 
-static int fdt_overlay_local_phandle(struct unit_test_state *uts)
+static int fdt_overlay_test_local_phandle(struct unit_test_state *uts)
 {
 	uint32_t local_phandle;
 	u32 val = 0;
@@ -166,9 +166,9 @@ static int fdt_overlay_local_phandle(struct unit_test_state *uts)
 
 	return CMD_RET_SUCCESS;
 }
-OVERLAY_TEST(fdt_overlay_local_phandle, 0);
+FDT_OVERLAY_TEST(fdt_overlay_test_local_phandle, 0);
 
-static int fdt_overlay_local_phandles(struct unit_test_state *uts)
+static int fdt_overlay_test_local_phandles(struct unit_test_state *uts)
 {
 	uint32_t local_phandle, test_phandle;
 	u32 val = 0;
@@ -196,9 +196,9 @@ static int fdt_overlay_local_phandles(struct unit_test_state *uts)
 
 	return CMD_RET_SUCCESS;
 }
-OVERLAY_TEST(fdt_overlay_local_phandles, 0);
+FDT_OVERLAY_TEST(fdt_overlay_test_local_phandles, 0);
 
-static int fdt_overlay_stacked(struct unit_test_state *uts)
+static int fdt_overlay_test_stacked(struct unit_test_state *uts)
 {
 	u32 val = 0;
 
@@ -208,13 +208,13 @@ static int fdt_overlay_stacked(struct unit_test_state *uts)
 
 	return CMD_RET_SUCCESS;
 }
-OVERLAY_TEST(fdt_overlay_stacked, 0);
+FDT_OVERLAY_TEST(fdt_overlay_test_stacked, 0);
 
-int do_ut_overlay(struct unit_test_state *uts, struct cmd_tbl *cmdtp, int flag,
-		  int argc, char *const argv[])
+int do_ut_fdt_overlay(struct unit_test_state *uts, struct cmd_tbl *cmdtp,
+		      int flag, int argc, char *const argv[])
 {
-	struct unit_test *tests = UNIT_TEST_SUITE_START(overlay);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(overlay);
+	struct unit_test *tests = UNIT_TEST_SUITE_START(fdt_overlay);
+	const int n_ents = UNIT_TEST_SUITE_COUNT(fdt_overlay);
 	void *fdt_base = &__dtb_test_fdt_base_begin;
 	void *fdt_overlay = &__dtbo_test_fdt_overlay_begin;
 	void *fdt_overlay_stacked = &__dtbo_test_fdt_overlay_stacked_begin;
@@ -268,7 +268,8 @@ int do_ut_overlay(struct unit_test_state *uts, struct cmd_tbl *cmdtp, int flag,
 	/* Apply the stacked overlay */
 	ut_assertok(fdt_overlay_apply(fdt, fdt_overlay_stacked_copy));
 
-	ret = cmd_ut_category(uts, "overlay", "", tests, n_ents, argc, argv);
+	ret = cmd_ut_category(uts, "fdt_overlay", "fdt_overlay_test_", tests,
+			      n_ents, argc, argv);
 
 	free(fdt_overlay_stacked_copy);
 err3:
diff --git a/test/overlay/test-fdt-base.dts b/test/fdt_overlay/test-fdt-base.dts
similarity index 100%
rename from test/overlay/test-fdt-base.dts
rename to test/fdt_overlay/test-fdt-base.dts
diff --git a/test/overlay/test-fdt-overlay-stacked.dtso b/test/fdt_overlay/test-fdt-overlay-stacked.dtso
similarity index 100%
rename from test/overlay/test-fdt-overlay-stacked.dtso
rename to test/fdt_overlay/test-fdt-overlay-stacked.dtso
diff --git a/test/overlay/test-fdt-overlay.dtso b/test/fdt_overlay/test-fdt-overlay.dtso
similarity index 100%
rename from test/overlay/test-fdt-overlay.dtso
rename to test/fdt_overlay/test-fdt-overlay.dtso
diff --git a/test/py/tests/test_suite.py b/test/py/tests/test_suite.py
index ae127301fd7..1e02d67efe2 100644
--- a/test/py/tests/test_suite.py
+++ b/test/py/tests/test_suite.py
@@ -7,10 +7,10 @@ import re
 # List of test suites we expect to find with 'ut info' and 'ut all'
 EXPECTED_SUITES = [
     'addrmap', 'bdinfo', 'bloblist', 'bootm', 'bootstd',
-    'cmd', 'common', 'dm', 'env', 'exit',
+    'cmd', 'common', 'dm', 'env', 'exit', 'fdt_overlay',
     'fdt', 'font', 'hush', 'lib',
     'loadm', 'log', 'mbr', 'measurement', 'mem',
-    'overlay', 'pci_mps', 'setexpr', 'upl',
+    'pci_mps', 'setexpr', 'upl',
     ]
 
 
-- 
2.43.0

