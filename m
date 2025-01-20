Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 566D2C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:28:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65FDB807FE;
	Mon, 20 Jan 2025 22:26:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VDlsGl2l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A4F7807B6; Mon, 20 Jan 2025 22:26:51 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 299C4807B9
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:26:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-844e61f3902so396058439f.0
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737408406; x=1738013206; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MkdhDmvyQTTbaODrRf7P7vjRsvPpdMMlR7LoDQAgubw=;
 b=VDlsGl2ltpkE57+TR20jHUoi/7QutMQnk2Aedg2T0LaC8JGskUhuEfNQxhxX4GmxxQ
 usJPEsYi6iWJN+k3/TVPu917efs818LrpfXwEGRNCMFujavEMIr/Xekm2cYpItsp34Mt
 ozZoKk5Nttd4awDMwLr5p/blcsGWcLnR/TSKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737408406; x=1738013206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MkdhDmvyQTTbaODrRf7P7vjRsvPpdMMlR7LoDQAgubw=;
 b=oyxRUoVht7gUW26iGnFvo0s1dmsMUhHyZHKOZWQSFlfRYS+13beXOKzMEJfqHOEfmn
 rZKdxbMYMqnd1CDcijUxhdS7jT3sNuK58IdzqffPHaepzQqqrj5ic6srpA5fdQYOaq/b
 rY83PXNjaIa6Q3KwoydHPPZbxivhlM0k/p/i4ZcGbtSyjN1XfyseMerG52+O+7+W5Nwc
 v6A0V/WEXplbxcJZINAWofbl8g6Rvbq03RjkQ2/mqvnGAeNpZRG8I2Fr34gDHjuvgD1v
 BDkwI9PxO9TDsnQbltpcIo1TSAWFsMDzEsiJYr5NNSSbFxgbZfuqBbIBbBTBwElLQ+BU
 64Ug==
X-Gm-Message-State: AOJu0YxjvGp2b+ebTPPZLAbHTETk5eitg4kgb1WA4MHyYaPrughBJnle
 55W1RWA7evBNoCU/uziG+3yFby2sT5VnbR6ZSqS72htOxnNDPrgeBgOGoVeSCfrTwqQIl5RQyR0
 =
X-Gm-Gg: ASbGncvv+gJ8A2GwcVLkkpiJoVbWYCHah6PKuzusdN3+CsDotudxCvy7XD113Lam2No
 opN6DaZVUe5KqbrBqkh9k/Hw3poltjZsE+Nys4JOfCZoPjJCDNA9QqTBXI1uQMFgK8+9Br+npwb
 Lkn3P8c0JafThZOnd7DULrQIOESnyji0ZL7uAspIvdpUB6F7p2pA8cCBR8NqDlOkZEqy3sJjcJg
 WEfZAbIEWvHdVYTU3zkYCBvE6brn86isSoM15y4+Vfe6K7ShYaq0tCTcQ/LPlPp5ZtO3oDHT79f
 akYhYvxDtppQICJdjomuwEP5OT5FDJI=
X-Google-Smtp-Source: AGHT+IHwYoKsoYaTH0iUyt4vA57W9h0RcKH7zZWx8WawM5Xb1ThaCXvd73Q7KRELET70MHA6yV6w7Q==
X-Received: by 2002:a05:6602:418d:b0:844:bb0c:b899 with SMTP id
 ca18e2360f4ac-851b6170923mr1182626839f.1.1737408406230; 
 Mon, 20 Jan 2025 13:26:46 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75440a24sm2847693173.33.2025.01.20.13.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:26:44 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Gendin <agendin@matrox.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Massimiliano Minella <massimiliano.minella@se.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Ravi Minnikanti <rminnikanti@marvell.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Stephen Carlson <stcarlso@linux.microsoft.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 10/44] test: Drop the _test suffix on linker lists
Date: Mon, 20 Jan 2025 14:25:32 -0700
Message-ID: <20250120212613.516664-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250120212613.516664-1-sjg@chromium.org>
References: <20250120212613.516664-1-sjg@chromium.org>
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

Most test suites have a _test suffix. This is not necessary as there is
also a ut_ prefix.

Drop the suffix so that (with future work) the suite name can be used as
the linker-list name.

Remove the suffix from the pytest regex as well, moving it to the top of
the file, as it is a constant.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/dm/test.h             | 2 +-
 include/test/common.h         | 2 +-
 include/test/env.h            | 2 +-
 include/test/hush.h           | 2 +-
 include/test/lib.h            | 2 +-
 include/test/log.h            | 4 ++--
 include/test/optee.h          | 2 +-
 include/test/overlay.h        | 2 +-
 test/boot/bootm.c             | 6 +++---
 test/boot/bootstd_common.c    | 8 ++++----
 test/boot/bootstd_common.h    | 3 +--
 test/boot/measurement.c       | 6 +++---
 test/boot/upl.c               | 6 +++---
 test/cmd/addrmap.c            | 6 +++---
 test/cmd/bdinfo.c             | 6 +++---
 test/cmd/exit.c               | 6 +++---
 test/cmd/fdt.c                | 6 +++---
 test/cmd/font.c               | 6 +++---
 test/cmd/loadm.c              | 6 +++---
 test/cmd/mbr.c                | 6 +++---
 test/cmd/mem.c                | 4 ++--
 test/cmd/mem_copy.c           | 2 +-
 test/cmd/mem_search.c         | 2 +-
 test/cmd/pci_mps.c            | 6 +++---
 test/cmd/seama.c              | 6 +++---
 test/cmd/setexpr.c            | 6 +++---
 test/common/bloblist.c        | 6 +++---
 test/common/cmd_ut_common.c   | 4 ++--
 test/dm/test-dm.c             | 4 ++--
 test/env/cmd_ut_env.c         | 4 ++--
 test/hush/cmd_ut_hush.c       | 4 ++--
 test/lib/cmd_ut_lib.c         | 4 ++--
 test/log/log_ut.c             | 4 ++--
 test/optee/cmd_ut_optee.c     | 4 ++--
 test/overlay/cmd_ut_overlay.c | 4 ++--
 test/py/conftest.py           | 7 +++++--
 36 files changed, 81 insertions(+), 79 deletions(-)

diff --git a/include/dm/test.h b/include/dm/test.h
index 3cbf2c740d4..4aabb4603b9 100644
--- a/include/dm/test.h
+++ b/include/dm/test.h
@@ -143,7 +143,7 @@ extern struct unit_test_state global_dm_test_state;
 
 /* Declare a new driver model test */
 #define DM_TEST(_name, _flags) \
-	UNIT_TEST(_name, UTF_DM | UTF_CONSOLE | (_flags), dm_test)
+	UNIT_TEST(_name, UTF_DM | UTF_CONSOLE | (_flags), dm)
 
 /*
  * struct sandbox_sdl_plat - Platform data for the SDL video driver
diff --git a/include/test/common.h b/include/test/common.h
index 81260d06ad6..d5a65d5b50b 100644
--- a/include/test/common.h
+++ b/include/test/common.h
@@ -10,6 +10,6 @@
 #include <test/test.h>
 
 /* Declare a new common function test */
-#define COMMON_TEST(_name, _flags) UNIT_TEST(_name, _flags, common_test)
+#define COMMON_TEST(_name, _flags) UNIT_TEST(_name, _flags, common)
 
 #endif /* __TEST_COMMON_H__ */
diff --git a/include/test/env.h b/include/test/env.h
index f45e33d71a4..6a63cc972e9 100644
--- a/include/test/env.h
+++ b/include/test/env.h
@@ -10,6 +10,6 @@
 #include <test/test.h>
 
 /* Declare a new environment test */
-#define ENV_TEST(_name, _flags)	UNIT_TEST(_name, _flags, env_test)
+#define ENV_TEST(_name, _flags)	UNIT_TEST(_name, _flags, env)
 
 #endif /* __TEST_ENV_H__ */
diff --git a/include/test/hush.h b/include/test/hush.h
index cca66544a06..e57bf13ea61 100644
--- a/include/test/hush.h
+++ b/include/test/hush.h
@@ -10,6 +10,6 @@
 #include <test/test.h>
 
 /* Declare a new environment test */
-#define HUSH_TEST(_name, _flags)	UNIT_TEST(_name, _flags, hush_test)
+#define HUSH_TEST(_name, _flags)	UNIT_TEST(_name, _flags, hush)
 
 #endif /* __TEST_HUSH_H__ */
diff --git a/include/test/lib.h b/include/test/lib.h
index 04b6241e54a..b19eb863a33 100644
--- a/include/test/lib.h
+++ b/include/test/lib.h
@@ -9,6 +9,6 @@
 #include <test/test.h>
 
 /* Declare a new library function test */
-#define LIB_TEST(_name, _flags)	UNIT_TEST(_name, _flags, lib_test)
+#define LIB_TEST(_name, _flags)	UNIT_TEST(_name, _flags, lib)
 
 #endif /* __TEST_LIB_H__ */
diff --git a/include/test/log.h b/include/test/log.h
index e3362b85e99..0921c0c1cbc 100644
--- a/include/test/log.h
+++ b/include/test/log.h
@@ -13,8 +13,8 @@
 #define LOGF_TEST (BIT(LOGF_FUNC) | BIT(LOGF_MSG))
 
 /* Declare a new logging test */
-#define LOG_TEST(_name) UNIT_TEST(_name, UTF_CONSOLE, log_test)
+#define LOG_TEST(_name) UNIT_TEST(_name, UTF_CONSOLE, log)
 #define LOG_TEST_FLAGS(_name, _flags) \
-		UNIT_TEST(_name, _flags | UTF_CONSOLE, log_test)
+		UNIT_TEST(_name, _flags | UTF_CONSOLE, log)
 
 #endif /* __TEST_LOG_H__ */
diff --git a/include/test/optee.h b/include/test/optee.h
index a8c6e6395f5..f4255b39ee3 100644
--- a/include/test/optee.h
+++ b/include/test/optee.h
@@ -9,6 +9,6 @@
 #include <test/test.h>
 
 /* Declare a new environment test */
-#define OPTEE_TEST(_name, _flags)	UNIT_TEST(_name, _flags, optee_test)
+#define OPTEE_TEST(_name, _flags)	UNIT_TEST(_name, _flags, optee)
 
 #endif /* __TEST_OPTEE_H__ */
diff --git a/include/test/overlay.h b/include/test/overlay.h
index c13f4d66e09..5dc98399ce7 100644
--- a/include/test/overlay.h
+++ b/include/test/overlay.h
@@ -10,6 +10,6 @@
 #include <test/test.h>
 
 /* Declare a new environment test */
-#define OVERLAY_TEST(_name, _flags)	UNIT_TEST(_name, _flags, overlay_test)
+#define OVERLAY_TEST(_name, _flags)	UNIT_TEST(_name, _flags, overlay)
 
 #endif /* __TEST_OVERLAY_H__ */
diff --git a/test/boot/bootm.c b/test/boot/bootm.c
index 0dd8bc2979f..c8e32023acb 100644
--- a/test/boot/bootm.c
+++ b/test/boot/bootm.c
@@ -13,7 +13,7 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-#define BOOTM_TEST(_name, _flags)	UNIT_TEST(_name, _flags, bootm_test)
+#define BOOTM_TEST(_name, _flags)	UNIT_TEST(_name, _flags, bootm)
 
 enum {
 	BUF_SIZE	= 1024,
@@ -259,8 +259,8 @@ BOOTM_TEST(bootm_test_subst_both, 0);
 
 int do_ut_bootm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	struct unit_test *tests = UNIT_TEST_SUITE_START(bootm_test);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(bootm_test);
+	struct unit_test *tests = UNIT_TEST_SUITE_START(bootm);
+	const int n_ents = UNIT_TEST_SUITE_COUNT(bootm);
 
 	return cmd_ut_category("bootm", "bootm_test_", tests, n_ents,
 			       argc, argv);
diff --git a/test/boot/bootstd_common.c b/test/boot/bootstd_common.c
index ff8ed2303b3..6bd9bb65a40 100644
--- a/test/boot/bootstd_common.c
+++ b/test/boot/bootstd_common.c
@@ -96,8 +96,8 @@ void bootstd_reset_usb(void)
 
 int do_ut_bootstd(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	struct unit_test *tests = UNIT_TEST_SUITE_START(bootstd_test);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(bootstd_test);
+	struct unit_test *tests = UNIT_TEST_SUITE_START(bootstd);
+	const int n_ents = UNIT_TEST_SUITE_COUNT(bootstd);
 	int ret;
 
 	ret = bootstd_setup_for_tests();
@@ -106,6 +106,6 @@ int do_ut_bootstd(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		return CMD_RET_FAILURE;
 	}
 
-	return cmd_ut_category("bootstd", "bootstd_test_",
-			       tests, n_ents, argc, argv);
+	return cmd_ut_category("bootstd", "bootstd_", tests, n_ents,
+			       argc, argv);
 }
diff --git a/test/boot/bootstd_common.h b/test/boot/bootstd_common.h
index e29036c897c..ea3ecd1166c 100644
--- a/test/boot/bootstd_common.h
+++ b/test/boot/bootstd_common.h
@@ -12,8 +12,7 @@
 #include <version_string.h>
 
 /* Declare a new bootdev test */
-#define BOOTSTD_TEST(_name, _flags) \
-		UNIT_TEST(_name, _flags, bootstd_test)
+#define BOOTSTD_TEST(_name, _flags)	UNIT_TEST(_name, _flags, bootstd)
 
 #define NVDATA_START_BLK	((0x400 + 0x400) / MMC_MAX_BLOCK_LEN)
 #define VERSION_START_BLK	((0x400 + 0x800) / MMC_MAX_BLOCK_LEN)
diff --git a/test/boot/measurement.c b/test/boot/measurement.c
index 29be495412d..018e8af45f0 100644
--- a/test/boot/measurement.c
+++ b/test/boot/measurement.c
@@ -14,7 +14,7 @@
 #include <asm/io.h>
 
 #define MEASUREMENT_TEST(_name, _flags)	\
-	UNIT_TEST(_name, _flags, measurement_test)
+	UNIT_TEST(_name, _flags, measurement)
 
 static int measure(struct unit_test_state *uts)
 {
@@ -57,8 +57,8 @@ MEASUREMENT_TEST(measure, 0);
 int do_ut_measurement(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[])
 {
-	struct unit_test *tests = UNIT_TEST_SUITE_START(measurement_test);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(measurement_test);
+	struct unit_test *tests = UNIT_TEST_SUITE_START(measurement);
+	const int n_ents = UNIT_TEST_SUITE_COUNT(measurement);
 
 	return cmd_ut_category("measurement", "measurement_test_", tests,
 			       n_ents, argc, argv);
diff --git a/test/boot/upl.c b/test/boot/upl.c
index ef65cf34055..2c9b8bc8bc0 100644
--- a/test/boot/upl.c
+++ b/test/boot/upl.c
@@ -16,7 +16,7 @@
 #include "bootstd_common.h"
 
 /* Declare a new upl test */
-#define UPL_TEST(_name, _flags)	UNIT_TEST(_name, _flags, upl_test)
+#define UPL_TEST(_name, _flags)	UNIT_TEST(_name, _flags, upl)
 
 static int add_region(struct unit_test_state *uts, struct alist *lst,
 		      ulong base, ulong size)
@@ -429,8 +429,8 @@ UPL_TEST(upl_test_info_norun, UTF_CONSOLE | UTF_MANUAL);
 
 int do_ut_upl(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	struct unit_test *tests = UNIT_TEST_SUITE_START(upl_test);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(upl_test);
+	struct unit_test *tests = UNIT_TEST_SUITE_START(upl);
+	const int n_ents = UNIT_TEST_SUITE_COUNT(upl);
 
 	return cmd_ut_category("upl", "cmd_upl_", tests, n_ents, argc, argv);
 }
diff --git a/test/cmd/addrmap.c b/test/cmd/addrmap.c
index 43897615aa9..fd0117102e2 100644
--- a/test/cmd/addrmap.c
+++ b/test/cmd/addrmap.c
@@ -10,7 +10,7 @@
 #include <test/ut.h>
 
 /* Declare a new addrmap test */
-#define ADDRMAP_TEST(_name, _flags)	UNIT_TEST(_name, _flags, addrmap_test)
+#define ADDRMAP_TEST(_name, _flags)	UNIT_TEST(_name, _flags, addrmap)
 
 /* Test 'addrmap' command output */
 static int addrmap_test_basic(struct unit_test_state *uts)
@@ -27,8 +27,8 @@ ADDRMAP_TEST(addrmap_test_basic, UTF_CONSOLE);
 
 int do_ut_addrmap(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	struct unit_test *tests = UNIT_TEST_SUITE_START(addrmap_test);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(addrmap_test);
+	struct unit_test *tests = UNIT_TEST_SUITE_START(addrmap);
+	const int n_ents = UNIT_TEST_SUITE_COUNT(addrmap);
 
 	return cmd_ut_category("addrmap", "cmd_addrmap_", tests, n_ents,
 			       argc, argv);
diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index bb419ab2394..46482b1f56b 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -26,7 +26,7 @@
 DECLARE_GLOBAL_DATA_PTR;
 
 /* Declare a new bdinfo test */
-#define BDINFO_TEST(_name, _flags)	UNIT_TEST(_name, _flags, bdinfo_test)
+#define BDINFO_TEST(_name, _flags)	UNIT_TEST(_name, _flags, bdinfo)
 
 static int test_num_l(struct unit_test_state *uts, const char *name,
 		      ulong value)
@@ -285,8 +285,8 @@ BDINFO_TEST(bdinfo_test_eth, UTF_CONSOLE);
 
 int do_ut_bdinfo(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	struct unit_test *tests = UNIT_TEST_SUITE_START(bdinfo_test);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(bdinfo_test);
+	struct unit_test *tests = UNIT_TEST_SUITE_START(bdinfo);
+	const int n_ents = UNIT_TEST_SUITE_COUNT(bdinfo);
 
 	return cmd_ut_category("bdinfo", "bdinfo_test_", tests, n_ents, argc, argv);
 }
diff --git a/test/cmd/exit.c b/test/cmd/exit.c
index cf65c05e283..d1eacdc36c2 100644
--- a/test/cmd/exit.c
+++ b/test/cmd/exit.c
@@ -14,7 +14,7 @@
 DECLARE_GLOBAL_DATA_PTR;
 
 /* Declare a new exit test */
-#define EXIT_TEST(_name, _flags)	UNIT_TEST(_name, _flags, exit_test)
+#define EXIT_TEST(_name, _flags)	UNIT_TEST(_name, _flags, exit)
 
 /* Test 'exit addr' getting/setting address */
 static int cmd_exit_test(struct unit_test_state *uts)
@@ -113,8 +113,8 @@ EXIT_TEST(cmd_exit_test, UTF_CONSOLE);
 
 int do_ut_exit(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	struct unit_test *tests = UNIT_TEST_SUITE_START(exit_test);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(exit_test);
+	struct unit_test *tests = UNIT_TEST_SUITE_START(exit);
+	const int n_ents = UNIT_TEST_SUITE_COUNT(exit);
 
 	return cmd_ut_category("exit", "exit_test_", tests, n_ents,
 			       argc, argv);
diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
index e64785101cd..74fd603bb02 100644
--- a/test/cmd/fdt.c
+++ b/test/cmd/fdt.c
@@ -23,7 +23,7 @@ DECLARE_GLOBAL_DATA_PTR;
  */
 
 /* Declare a new fdt test */
-#define FDT_TEST(_name, _flags)	UNIT_TEST(_name, _flags, fdt_test)
+#define FDT_TEST(_name, _flags)	UNIT_TEST(_name, _flags, fdt)
 
 /**
  * make_test_fdt() - Create an FDT with just a root node
@@ -1465,8 +1465,8 @@ FDT_TEST(fdt_test_apply, UTF_CONSOLE);
 
 int do_ut_fdt(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	struct unit_test *tests = UNIT_TEST_SUITE_START(fdt_test);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(fdt_test);
+	struct unit_test *tests = UNIT_TEST_SUITE_START(fdt);
+	const int n_ents = UNIT_TEST_SUITE_COUNT(fdt);
 
 	return cmd_ut_category("fdt", "fdt_test_", tests, n_ents, argc, argv);
 }
diff --git a/test/cmd/font.c b/test/cmd/font.c
index 3335dd65bea..d860efe8ce5 100644
--- a/test/cmd/font.c
+++ b/test/cmd/font.c
@@ -12,7 +12,7 @@
 #include <test/ut.h>
 
 /* Declare a new fdt test */
-#define FONT_TEST(_name, _flags)	UNIT_TEST(_name, _flags, font_test)
+#define FONT_TEST(_name, _flags)	UNIT_TEST(_name, _flags, font)
 
 /* Test 'fdt addr' resizing an fdt */
 static int font_test_base(struct unit_test_state *uts)
@@ -88,8 +88,8 @@ FONT_TEST(font_test_base, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_CONSOLE |
 
 int do_ut_font(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	struct unit_test *tests = UNIT_TEST_SUITE_START(font_Test);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(font_test);
+	struct unit_test *tests = UNIT_TEST_SUITE_START(font);
+	const int n_ents = UNIT_TEST_SUITE_COUNT(font);
 
 	return cmd_ut_category("font", "font_test_", tests, n_ents, argc, argv);
 }
diff --git a/test/cmd/loadm.c b/test/cmd/loadm.c
index dedb4f7683e..78bb12ce88c 100644
--- a/test/cmd/loadm.c
+++ b/test/cmd/loadm.c
@@ -19,7 +19,7 @@
 
 #define BUF_SIZE 0x100
 
-#define LOADM_TEST(_name, _flags)	UNIT_TEST(_name, _flags, loadm_test)
+#define LOADM_TEST(_name, _flags)	UNIT_TEST(_name, _flags, loadm)
 
 static int loadm_test_params(struct unit_test_state *uts)
 {
@@ -61,8 +61,8 @@ LOADM_TEST(loadm_test_load, UTF_CONSOLE);
 
 int do_ut_loadm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	struct unit_test *tests = UNIT_TEST_SUITE_START(loadm_test);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(loadm_test);
+	struct unit_test *tests = UNIT_TEST_SUITE_START(loadm);
+	const int n_ents = UNIT_TEST_SUITE_COUNT(loadm);
 
 	return cmd_ut_category("loadm", "loadm_test_", tests, n_ents, argc,
 			       argv);
diff --git a/test/cmd/mbr.c b/test/cmd/mbr.c
index d137378a3be..ad859921ce5 100644
--- a/test/cmd/mbr.c
+++ b/test/cmd/mbr.c
@@ -470,12 +470,12 @@ static int mbr_test_run(struct unit_test_state *uts)
 }
 
 /* Declare mbr test */
-UNIT_TEST(mbr_test_run, UTF_CONSOLE, mbr_test);
+UNIT_TEST(mbr_test_run, UTF_CONSOLE, mbr);
 
 int do_ut_mbr(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	struct unit_test *tests = UNIT_TEST_SUITE_START(mbr_test);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(mbr_test);
+	struct unit_test *tests = UNIT_TEST_SUITE_START(mbr);
+	const int n_ents = UNIT_TEST_SUITE_COUNT(mbr);
 
 	return cmd_ut_category("mbr", "mbr_test_", tests, n_ents, argc, argv);
 }
diff --git a/test/cmd/mem.c b/test/cmd/mem.c
index d6f2544a4e9..2b78e421a9c 100644
--- a/test/cmd/mem.c
+++ b/test/cmd/mem.c
@@ -11,8 +11,8 @@
 
 int do_ut_mem(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	struct unit_test *tests = UNIT_TEST_SUITE_START(mem_test);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(mem_test);
+	struct unit_test *tests = UNIT_TEST_SUITE_START(mem);
+	const int n_ents = UNIT_TEST_SUITE_COUNT(mem);
 
 	return cmd_ut_category("mem", "mem_test_", tests, n_ents, argc,
 			       argv);
diff --git a/test/cmd/mem_copy.c b/test/cmd/mem_copy.c
index 67eca328777..3e904fc4e4b 100644
--- a/test/cmd/mem_copy.c
+++ b/test/cmd/mem_copy.c
@@ -12,7 +12,7 @@
 #define BUF_SIZE	256
 
 /* Declare a new mem test */
-#define MEM_TEST(_name)	UNIT_TEST(_name, 0, mem_test)
+#define MEM_TEST(_name)	UNIT_TEST(_name, 0, mem)
 
 struct param {
 	int d, s, count;
diff --git a/test/cmd/mem_search.c b/test/cmd/mem_search.c
index 3a031eed7ed..df8938bdb6c 100644
--- a/test/cmd/mem_search.c
+++ b/test/cmd/mem_search.c
@@ -14,7 +14,7 @@
 #define BUF_SIZE	0x100
 
 /* Declare a new mem test */
-#define MEM_TEST(_name, _flags)	UNIT_TEST(_name, _flags, mem_test)
+#define MEM_TEST(_name, _flags)	UNIT_TEST(_name, _flags, mem)
 
 /* Test 'ms' command with bytes */
 static int mem_test_ms_b(struct unit_test_state *uts)
diff --git a/test/cmd/pci_mps.c b/test/cmd/pci_mps.c
index 0c57d15d636..2595ea103ff 100644
--- a/test/cmd/pci_mps.c
+++ b/test/cmd/pci_mps.c
@@ -11,7 +11,7 @@
 #include <test/suites.h>
 #include <test/ut.h>
 
-#define PCI_MPS_TEST(_name, _flags) UNIT_TEST(_name, _flags, pci_mps_test)
+#define PCI_MPS_TEST(_name, _flags) UNIT_TEST(_name, _flags, pci_mps)
 
 /* Test "pci_mps" command in safe "s" mode */
 static int test_pci_mps_safe(struct unit_test_state *uts)
@@ -32,8 +32,8 @@ PCI_MPS_TEST(test_pci_mps_safe, UTF_CONSOLE);
 int do_ut_pci_mps(struct cmd_tbl *cmdtp, int flag, int argc,
 		  char * const argv[])
 {
-	struct unit_test *tests = UNIT_TEST_SUITE_START(pci_mps_test);
-	const int n = UNIT_TEST_SUITE_COUNT(pci_mps_test);
+	struct unit_test *tests = UNIT_TEST_SUITE_START(pci_mps);
+	const int n = UNIT_TEST_SUITE_COUNT(pci_mps);
 
 	return cmd_ut_category("pci_mps", "pci_mps_test_", tests, n,
 			       argc, argv);
diff --git a/test/cmd/seama.c b/test/cmd/seama.c
index 28d6b9ab517..39590d162ac 100644
--- a/test/cmd/seama.c
+++ b/test/cmd/seama.c
@@ -11,7 +11,7 @@
 #include <test/test.h>
 #include <test/ut.h>
 
-#define SEAMA_TEST(_name, _flags)	UNIT_TEST(_name, _flags, seama_test)
+#define SEAMA_TEST(_name, _flags)	UNIT_TEST(_name, _flags, seama)
 
 static int seama_test_noargs(struct unit_test_state *uts)
 {
@@ -59,8 +59,8 @@ SEAMA_TEST(seama_test_index, UTF_CONSOLE);
 
 int do_ut_seama(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	struct unit_test *tests = UNIT_TEST_SUITE_START(seama_test);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(seama_test);
+	struct unit_test *tests = UNIT_TEST_SUITE_START(seama);
+	const int n_ents = UNIT_TEST_SUITE_COUNT(seama);
 
 	return cmd_ut_category("seama", "seama_test_", tests, n_ents, argc,
 			       argv);
diff --git a/test/cmd/setexpr.c b/test/cmd/setexpr.c
index 9b3277f2ad9..49eac5890aa 100644
--- a/test/cmd/setexpr.c
+++ b/test/cmd/setexpr.c
@@ -15,7 +15,7 @@
 #define BUF_SIZE	0x100
 
 /* Declare a new setexpr test */
-#define SETEXPR_TEST(_name, _flags)	UNIT_TEST(_name, _flags, setexpr_test)
+#define SETEXPR_TEST(_name, _flags)	UNIT_TEST(_name, _flags, setexpr)
 
 /* Test 'setexpr' command with simply setting integers */
 static int setexpr_test_int(struct unit_test_state *uts)
@@ -482,8 +482,8 @@ SETEXPR_TEST(setexpr_test_fmt, UTF_CONSOLE);
 
 int do_ut_setexpr(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	struct unit_test *tests = UNIT_TEST_SUITE_START(setexpr_test);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(setexpr_test);
+	struct unit_test *tests = UNIT_TEST_SUITE_START(setexpr);
+	const int n_ents = UNIT_TEST_SUITE_COUNT(setexpr);
 
 	return cmd_ut_category("setexpr", "setexpr_test_", tests, n_ents,
 			       argc, argv);
diff --git a/test/common/bloblist.c b/test/common/bloblist.c
index 4bca62110a5..f5d98774862 100644
--- a/test/common/bloblist.c
+++ b/test/common/bloblist.c
@@ -12,7 +12,7 @@
 
 /* Declare a new bloblist test */
 #define BLOBLIST_TEST(_name, _flags) \
-		UNIT_TEST(_name, _flags, bloblist_test)
+		UNIT_TEST(_name, _flags, bloblist)
 
 enum {
 	TEST_TAG		= BLOBLISTT_U_BOOT_SPL_HANDOFF,
@@ -606,8 +606,8 @@ BLOBLIST_TEST(bloblist_test_blob_maxsize, UFT_BLOBLIST);
 int do_ut_bloblist(struct cmd_tbl *cmdtp, int flag, int argc,
 		   char *const argv[])
 {
-	struct unit_test *tests = UNIT_TEST_SUITE_START(bloblist_test);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(bloblist_test);
+	struct unit_test *tests = UNIT_TEST_SUITE_START(bloblist);
+	const int n_ents = UNIT_TEST_SUITE_COUNT(bloblist);
 
 	return cmd_ut_category("bloblist", "bloblist_test_",
 			       tests, n_ents, argc, argv);
diff --git a/test/common/cmd_ut_common.c b/test/common/cmd_ut_common.c
index 2f03a58af47..0724c9361b8 100644
--- a/test/common/cmd_ut_common.c
+++ b/test/common/cmd_ut_common.c
@@ -13,8 +13,8 @@
 
 int do_ut_common(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	struct unit_test *tests = UNIT_TEST_SUITE_START(common_test);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(common_test);
+	struct unit_test *tests = UNIT_TEST_SUITE_START(common);
+	const int n_ents = UNIT_TEST_SUITE_COUNT(common);
 
 	return cmd_ut_category("common", "common_test_", tests, n_ents, argc,
 			       argv);
diff --git a/test/dm/test-dm.c b/test/dm/test-dm.c
index 7cfbefe02da..8f83110163a 100644
--- a/test/dm/test-dm.c
+++ b/test/dm/test-dm.c
@@ -8,8 +8,8 @@
 
 int do_ut_dm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	struct unit_test *tests = UNIT_TEST_SUITE_START(dm_test);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(dm_test);
+	struct unit_test *tests = UNIT_TEST_SUITE_START(dm);
+	const int n_ents = UNIT_TEST_SUITE_COUNT(dm);
 
 	return cmd_ut_category("dm", "dm_test_", tests, n_ents, argc, argv);
 }
diff --git a/test/env/cmd_ut_env.c b/test/env/cmd_ut_env.c
index 494b5db395b..332139bb803 100644
--- a/test/env/cmd_ut_env.c
+++ b/test/env/cmd_ut_env.c
@@ -77,8 +77,8 @@ ENV_TEST(env_test_env_cmd, UTF_CONSOLE);
 
 int do_ut_env(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	struct unit_test *tests = UNIT_TEST_SUITE_START(env_test);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(env_test);
+	struct unit_test *tests = UNIT_TEST_SUITE_START(env);
+	const int n_ents = UNIT_TEST_SUITE_COUNT(env);
 
 	return cmd_ut_category("env", "env_test_", tests, n_ents, argc, argv);
 }
diff --git a/test/hush/cmd_ut_hush.c b/test/hush/cmd_ut_hush.c
index abad44f3216..141203d766b 100644
--- a/test/hush/cmd_ut_hush.c
+++ b/test/hush/cmd_ut_hush.c
@@ -11,8 +11,8 @@
 
 int do_ut_hush(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	struct unit_test *tests = UNIT_TEST_SUITE_START(hush_test);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(hush_test);
+	struct unit_test *tests = UNIT_TEST_SUITE_START(hush);
+	const int n_ents = UNIT_TEST_SUITE_COUNT(hush);
 
 	return cmd_ut_category("hush", "hush_test_",
 			       tests, n_ents, argc, argv);
diff --git a/test/lib/cmd_ut_lib.c b/test/lib/cmd_ut_lib.c
index f98cb9b3c57..90a8c0728b7 100644
--- a/test/lib/cmd_ut_lib.c
+++ b/test/lib/cmd_ut_lib.c
@@ -12,8 +12,8 @@
 
 int do_ut_lib(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	struct unit_test *tests = UNIT_TEST_SUITE_START(lib_test);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(lib_test);
+	struct unit_test *tests = UNIT_TEST_SUITE_START(lib);
+	const int n_ents = UNIT_TEST_SUITE_COUNT(lib);
 
 	return cmd_ut_category("lib", "lib_test_", tests, n_ents, argc, argv);
 }
diff --git a/test/log/log_ut.c b/test/log/log_ut.c
index 6617ed8b152..2aa3afe286a 100644
--- a/test/log/log_ut.c
+++ b/test/log/log_ut.c
@@ -12,8 +12,8 @@
 
 int do_ut_log(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
 {
-	struct unit_test *tests = UNIT_TEST_SUITE_START(log_test);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(log_test);
+	struct unit_test *tests = UNIT_TEST_SUITE_START(log);
+	const int n_ents = UNIT_TEST_SUITE_COUNT(log);
 
 	return cmd_ut_category("log", "log_test_",
 			       tests, n_ents, argc, argv);
diff --git a/test/optee/cmd_ut_optee.c b/test/optee/cmd_ut_optee.c
index c6f50e0995a..fc6674764f9 100644
--- a/test/optee/cmd_ut_optee.c
+++ b/test/optee/cmd_ut_optee.c
@@ -93,8 +93,8 @@ OPTEE_TEST(optee_fdt_protected_memory, 0);
 
 int do_ut_optee(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	struct unit_test *tests = UNIT_TEST_SUITE_START(optee_test);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(optee_test);
+	struct unit_test *tests = UNIT_TEST_SUITE_START(optee);
+	const int n_ents = UNIT_TEST_SUITE_COUNT(optee);
 	struct unit_test_state *uts;
 	void *fdt_optee = &__dtb_test_optee_optee_begin;
 	void *fdt_no_optee = &__dtb_test_optee_no_optee_begin;
diff --git a/test/overlay/cmd_ut_overlay.c b/test/overlay/cmd_ut_overlay.c
index 256afd115d2..e0483afc31d 100644
--- a/test/overlay/cmd_ut_overlay.c
+++ b/test/overlay/cmd_ut_overlay.c
@@ -212,8 +212,8 @@ OVERLAY_TEST(fdt_overlay_stacked, 0);
 
 int do_ut_overlay(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	struct unit_test *tests = UNIT_TEST_SUITE_START(overlay_test);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(overlay_test);
+	struct unit_test *tests = UNIT_TEST_SUITE_START(overlay);
+	const int n_ents = UNIT_TEST_SUITE_COUNT(overlay);
 	struct unit_test_state *uts;
 	void *fdt_base = &__dtb_test_fdt_base_begin;
 	void *fdt_overlay = &__dtbo_test_fdt_overlay_begin;
diff --git a/test/py/conftest.py b/test/py/conftest.py
index d4127dd0a93..3bd333bfd24 100644
--- a/test/py/conftest.py
+++ b/test/py/conftest.py
@@ -33,6 +33,9 @@ console = None
 
 TEST_PY_DIR = os.path.dirname(os.path.abspath(__file__))
 
+# Regex for test-function symbols
+RE_UT_TEST_LIST = re.compile(r'[^a-zA-Z0-9_]_u_boot_list_2_ut_(.*)_2_(.*)\s*$')
+
 def mkdir_p(path):
     """Create a directory path.
 
@@ -341,7 +344,7 @@ def pytest_configure(config):
         import u_boot_console_exec_attach
         console = u_boot_console_exec_attach.ConsoleExecAttach(log, ubconfig)
 
-re_ut_test_list = re.compile(r'[^a-zA-Z0-9_]_u_boot_list_2_ut_(.*)_test_2_(.*)\s*$')
+
 def generate_ut_subtest(metafunc, fixture_name, sym_path):
     """Provide parametrization for a ut_subtest fixture.
 
@@ -368,7 +371,7 @@ def generate_ut_subtest(metafunc, fixture_name, sym_path):
 
     vals = []
     for l in lines:
-        m = re_ut_test_list.search(l)
+        m = RE_UT_TEST_LIST.search(l)
         if not m:
             continue
         suite, name = m.groups()
-- 
2.43.0

