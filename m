Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B7FC30653
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 07:42:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E4E688950;
	Thu,  4 Jul 2024 09:38:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE00D88936; Thu,  4 Jul 2024 09:38:00 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 9309488937
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 09:37:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BB2A367;
 Thu,  4 Jul 2024 00:38:23 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDAF73F762;
 Thu,  4 Jul 2024 00:37:54 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH v2 31/48] test: lmb: add a separate class of unit tests
 for lmb
Date: Thu,  4 Jul 2024 13:05:27 +0530
Message-Id: <20240704073544.670249-32-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240704073544.670249-1-sughosh.ganu@linaro.org>
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
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

Add the LMB unit tests under a separate class of tests. The LMB tests
involve changing the LMB's memory map. With the memory map now
persistent and global, running these tests has a side effect and
impact any subsequent tests. Run these tests separately so that the
system can be reset on completion of these tests.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V1: New patch

 include/test/suites.h        |  1 +
 test/Kconfig                 |  9 ++++++
 test/Makefile                |  1 +
 test/cmd_ut.c                |  7 +++++
 test/lib/Makefile            |  1 -
 test/{lib/lmb.c => lmb_ut.c} | 53 ++++++++++++++++++++++--------------
 6 files changed, 50 insertions(+), 22 deletions(-)
 rename test/{lib/lmb.c => lmb_ut.c} (93%)

diff --git a/include/test/suites.h b/include/test/suites.h
index 365d5f20df..5ef164a956 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -45,6 +45,7 @@ int do_ut_fdt(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_font(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_hush(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_lib(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
+int do_ut_lmb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_loadm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_log(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[]);
 int do_ut_mbr(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
diff --git a/test/Kconfig b/test/Kconfig
index e2ec0994a2..49c24722dc 100644
--- a/test/Kconfig
+++ b/test/Kconfig
@@ -79,6 +79,15 @@ config UT_COMPRESSION
 	  Enables tests for compression and decompression routines for simple
 	  sanity and for buffer overflow conditions.
 
+config UT_LMB
+	bool "Unit tests for LMB functions"
+	depends on !SPL && UNIT_TEST
+	default y
+	help
+	  Enables the 'ut lmb' commands which tests the lmb functions
+	  responsible for reserving memory for loading images into
+	  memory.
+
 config UT_LOG
 	bool "Unit tests for logging functions"
 	depends on UNIT_TEST
diff --git a/test/Makefile b/test/Makefile
index ed312cd0a4..e9bdd14eba 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_$(SPL_)CMDLINE) += command_ut.o
 obj-$(CONFIG_$(SPL_)UT_COMPRESSION) += compression.o
 obj-y += dm/
 obj-$(CONFIG_FUZZ) += fuzz/
+obj-$(CONFIG_UT_LMB) += lmb_ut.o
 ifndef CONFIG_SANDBOX_VPL
 obj-$(CONFIG_UNIT_TEST) += lib/
 endif
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 4e4aa8f1cb..60ff872723 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -78,6 +78,7 @@ static struct cmd_tbl cmd_ut_sub[] = {
 #ifdef CONFIG_CONSOLE_TRUETYPE
 	U_BOOT_CMD_MKENT(font, CONFIG_SYS_MAXARGS, 1, do_ut_font, "", ""),
 #endif
+
 #ifdef CONFIG_UT_OPTEE
 	U_BOOT_CMD_MKENT(optee, CONFIG_SYS_MAXARGS, 1, do_ut_optee, "", ""),
 #endif
@@ -87,6 +88,9 @@ static struct cmd_tbl cmd_ut_sub[] = {
 #ifdef CONFIG_UT_LIB
 	U_BOOT_CMD_MKENT(lib, CONFIG_SYS_MAXARGS, 1, do_ut_lib, "", ""),
 #endif
+#ifdef CONFIG_UT_LMB
+	U_BOOT_CMD_MKENT(lmb, CONFIG_SYS_MAXARGS, 1, do_ut_lmb, "", ""),
+#endif
 #ifdef CONFIG_UT_LOG
 	U_BOOT_CMD_MKENT(log, CONFIG_SYS_MAXARGS, 1, do_ut_log, "", ""),
 #endif
@@ -228,6 +232,9 @@ U_BOOT_LONGHELP(ut,
 #ifdef CONFIG_UT_LIB
 	"\nlib - library functions"
 #endif
+#ifdef CONFIG_UT_LMB
+	"\nlmb - lmb functions"
+#endif
 #ifdef CONFIG_UT_LOG
 	"\nlog - logging functions"
 #endif
diff --git a/test/lib/Makefile b/test/lib/Makefile
index 70f14c46b1..ecb96dc1d7 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -10,7 +10,6 @@ obj-$(CONFIG_EFI_LOADER) += efi_device_path.o
 obj-$(CONFIG_EFI_SECURE_BOOT) += efi_image_region.o
 obj-y += hexdump.o
 obj-$(CONFIG_SANDBOX) += kconfig.o
-obj-y += lmb.o
 obj-y += longjmp.o
 obj-$(CONFIG_CONSOLE_RECORD) += test_print.o
 obj-$(CONFIG_SSCANF) += sscanf.o
diff --git a/test/lib/lmb.c b/test/lmb_ut.c
similarity index 93%
rename from test/lib/lmb.c
rename to test/lmb_ut.c
index 878aacee8d..a304e9317e 100644
--- a/test/lib/lmb.c
+++ b/test/lmb_ut.c
@@ -9,10 +9,13 @@
 #include <log.h>
 #include <malloc.h>
 #include <dm/test.h>
-#include <test/lib.h>
+#include <test/suites.h>
 #include <test/test.h>
 #include <test/ut.h>
 
+
+#define LMB_TEST(_name, _flags)	UNIT_TEST(_name, _flags, lmb_test)
+
 static inline bool lmb_is_nomap(struct lmb_region *m)
 {
 	return m->flags & LMB_NOMAP;
@@ -200,7 +203,7 @@ static int test_multi_alloc_512mb_x2(struct unit_test_state *uts,
 }
 
 /* Create a memory region with one reserved region and allocate */
-static int lib_test_lmb_simple_norun(struct unit_test_state *uts)
+static int lmb_test_lmb_simple_norun(struct unit_test_state *uts)
 {
 	int ret;
 
@@ -212,10 +215,10 @@ static int lib_test_lmb_simple_norun(struct unit_test_state *uts)
 	/* simulate 512 MiB RAM beginning at 1.5GiB */
 	return test_multi_alloc_512mb(uts, 0xE0000000);
 }
-LIB_TEST(lib_test_lmb_simple_norun, UT_TESTF_MANUAL);
+LMB_TEST(lmb_test_lmb_simple_norun, UT_TESTF_MANUAL);
 
 /* Create two memory regions with one reserved region and allocate */
-static int lib_test_lmb_simple_x2_norun(struct unit_test_state *uts)
+static int lmb_test_lmb_simple_x2_norun(struct unit_test_state *uts)
 {
 	int ret;
 
@@ -227,7 +230,7 @@ static int lib_test_lmb_simple_x2_norun(struct unit_test_state *uts)
 	/* simulate 512 MiB RAM beginning at 3.5GiB and 1 GiB */
 	return test_multi_alloc_512mb_x2(uts, 0xE0000000, 0x40000000);
 }
-LIB_TEST(lib_test_lmb_simple_x2_norun, UT_TESTF_MANUAL);
+LMB_TEST(lmb_test_lmb_simple_x2_norun, UT_TESTF_MANUAL);
 
 /* Simulate 512 MiB RAM, allocate some blocks that fit/don't fit */
 static int test_bigblock(struct unit_test_state *uts, const phys_addr_t ram)
@@ -286,7 +289,7 @@ static int test_bigblock(struct unit_test_state *uts, const phys_addr_t ram)
 	return 0;
 }
 
-static int lib_test_lmb_big_norun(struct unit_test_state *uts)
+static int lmb_test_lmb_big_norun(struct unit_test_state *uts)
 {
 	int ret;
 
@@ -298,7 +301,7 @@ static int lib_test_lmb_big_norun(struct unit_test_state *uts)
 	/* simulate 512 MiB RAM beginning at 1.5GiB */
 	return test_bigblock(uts, 0xE0000000);
 }
-LIB_TEST(lib_test_lmb_big_norun, UT_TESTF_MANUAL);
+LMB_TEST(lmb_test_lmb_big_norun, UT_TESTF_MANUAL);
 
 /* Simulate 512 MiB RAM, allocate a block without previous reservation */
 static int test_noreserved(struct unit_test_state *uts, const phys_addr_t ram,
@@ -368,7 +371,7 @@ static int test_noreserved(struct unit_test_state *uts, const phys_addr_t ram,
 	return 0;
 }
 
-static int lib_test_lmb_noreserved_norun(struct unit_test_state *uts)
+static int lmb_test_lmb_noreserved_norun(struct unit_test_state *uts)
 {
 	int ret;
 
@@ -380,9 +383,9 @@ static int lib_test_lmb_noreserved_norun(struct unit_test_state *uts)
 	/* simulate 512 MiB RAM beginning at 1.5GiB */
 	return test_noreserved(uts, 0xE0000000, 4, 1);
 }
-LIB_TEST(lib_test_lmb_noreserved_norun, UT_TESTF_MANUAL);
+LMB_TEST(lmb_test_lmb_noreserved_norun, UT_TESTF_MANUAL);
 
-static int lib_test_lmb_unaligned_size_norun(struct unit_test_state *uts)
+static int lmb_test_lmb_unaligned_size_norun(struct unit_test_state *uts)
 {
 	int ret;
 
@@ -394,13 +397,13 @@ static int lib_test_lmb_unaligned_size_norun(struct unit_test_state *uts)
 	/* simulate 512 MiB RAM beginning at 1.5GiB */
 	return test_noreserved(uts, 0xE0000000, 5, 8);
 }
-LIB_TEST(lib_test_lmb_unaligned_size_norun, UT_TESTF_MANUAL);
+LMB_TEST(lmb_test_lmb_unaligned_size_norun, UT_TESTF_MANUAL);
 
 /*
  * Simulate a RAM that starts at 0 and allocate down to address 0, which must
  * fail as '0' means failure for the lmb_alloc functions.
  */
-static int lib_test_lmb_at_0_norun(struct unit_test_state *uts)
+static int lmb_test_lmb_at_0_norun(struct unit_test_state *uts)
 {
 	const phys_addr_t ram = 0;
 	const phys_size_t ram_size = 0x20000000;
@@ -442,10 +445,10 @@ static int lib_test_lmb_at_0_norun(struct unit_test_state *uts)
 
 	return 0;
 }
-LIB_TEST(lib_test_lmb_at_0_norun, UT_TESTF_MANUAL);
+LMB_TEST(lmb_test_lmb_at_0_norun, UT_TESTF_MANUAL);
 
 /* Check that calling lmb_reserve with overlapping regions fails. */
-static int lib_test_lmb_overlapping_reserve_norun(struct unit_test_state *uts)
+static int lmb_test_lmb_overlapping_reserve_norun(struct unit_test_state *uts)
 {
 	const phys_addr_t ram = 0x40000000;
 	const phys_size_t ram_size = 0x20000000;
@@ -496,7 +499,7 @@ static int lib_test_lmb_overlapping_reserve_norun(struct unit_test_state *uts)
 
 	return 0;
 }
-LIB_TEST(lib_test_lmb_overlapping_reserve_norun, UT_TESTF_MANUAL);
+LMB_TEST(lmb_test_lmb_overlapping_reserve_norun, UT_TESTF_MANUAL);
 
 /*
  * Simulate 512 MiB RAM, reserve 3 blocks, allocate addresses in between.
@@ -618,7 +621,7 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 	return 0;
 }
 
-static int lib_test_lmb_alloc_addr_norun(struct unit_test_state *uts)
+static int lmb_test_lmb_alloc_addr_norun(struct unit_test_state *uts)
 {
 	int ret;
 
@@ -630,7 +633,7 @@ static int lib_test_lmb_alloc_addr_norun(struct unit_test_state *uts)
 	/* simulate 512 MiB RAM beginning at 1.5GiB */
 	return test_alloc_addr(uts, 0xE0000000);
 }
-LIB_TEST(lib_test_lmb_alloc_addr_norun, UT_TESTF_MANUAL);
+LMB_TEST(lmb_test_lmb_alloc_addr_norun, UT_TESTF_MANUAL);
 
 /* Simulate 512 MiB RAM, reserve 3 blocks, check addresses in between */
 static int test_get_unreserved_size(struct unit_test_state *uts,
@@ -693,7 +696,7 @@ static int test_get_unreserved_size(struct unit_test_state *uts,
 	return 0;
 }
 
-static int lib_test_lmb_get_free_size_norun(struct unit_test_state *uts)
+static int lmb_test_lmb_get_free_size_norun(struct unit_test_state *uts)
 {
 	int ret;
 
@@ -705,9 +708,9 @@ static int lib_test_lmb_get_free_size_norun(struct unit_test_state *uts)
 	/* simulate 512 MiB RAM beginning at 1.5GiB */
 	return test_get_unreserved_size(uts, 0xE0000000);
 }
-LIB_TEST(lib_test_lmb_get_free_size_norun, UT_TESTF_MANUAL);
+LMB_TEST(lmb_test_lmb_get_free_size_norun, UT_TESTF_MANUAL);
 
-static int lib_test_lmb_flags_norun(struct unit_test_state *uts)
+static int lmb_test_lmb_flags_norun(struct unit_test_state *uts)
 {
 	struct lmb_region *mem, *used;
 	struct alist *mem_lst, *used_lst;
@@ -797,4 +800,12 @@ static int lib_test_lmb_flags_norun(struct unit_test_state *uts)
 
 	return 0;
 }
-LIB_TEST(lib_test_lmb_flags_norun, UT_TESTF_MANUAL);
+LMB_TEST(lmb_test_lmb_flags_norun, UT_TESTF_MANUAL);
+
+int do_ut_lmb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	struct unit_test *tests = UNIT_TEST_SUITE_START(lmb_test);
+	const int n_ents = UNIT_TEST_SUITE_COUNT(lmb_test);
+
+	return cmd_ut_category("lmb", "lmb_test_", tests, n_ents, argc, argv);
+}
-- 
2.34.1

