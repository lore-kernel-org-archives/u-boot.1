Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 185E5E677F8
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 10:09:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4468188FF1;
	Sat,  2 Nov 2024 11:08:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Rd8CwNyL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4C5F89023; Sat,  2 Nov 2024 11:08:53 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD6BB88FF1
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 11:08:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 8AECD408ED; 
 Sat,  2 Nov 2024 10:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730542122;
 bh=UyHlsA+oy2uphHFYbPt1oOs+8KuXU9+RcHVXoxlDRw4=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Rd8CwNyL78xWfkZhUh3gILQlCht3ec9zKox+YRw3ro6wdFSDww+AWMoalckQQWkMp
 nMSLzQCLU0Fgptl7gaqs4a9XWCEL4KbQPgoUQz0EUsrF7CQJ/evsWcSB/mzT+W+Gfv
 WUrMhnpVYCEmV+F6EzQxeSrCD9CjTKZ8cLpgJ9WG54lC+nvha0IvrSrpNVJ2SR5c+T
 QKPDJlOhVrgUQCEZbpXkrlc/uzFXjYQeK5KCX2QoDwk7E0Z/ppV8wteP1N6JDEOppf
 u5z+D2Rnx56ipfTjuLQIYaTTFv3fBJRrqmYC2ENAqT49K9jEQKwWBIScxW2RgdBFQ9
 KifYg6XUh+KKw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/2] test: unit test for hash command
Date: Sat,  2 Nov 2024 11:08:36 +0100
Message-ID: <20241102100836.103005-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241102100836.103005-1-heinrich.schuchardt@canonical.com>
References: <20241102100836.103005-1-heinrich.schuchardt@canonical.com>
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

Provide a unit test testing the hash command.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/cmd/Makefile |   1 +
 test/cmd/hash.c   | 101 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+)
 create mode 100644 test/cmd/hash.c

diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index fe7a2165af2..1fd3e89efff 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_CMD_ADDRMAP) += addrmap.o
 obj-$(CONFIG_CMD_BDI) += bdinfo.o
 obj-$(CONFIG_CMD_FDT) += fdt.o
 obj-$(CONFIG_CONSOLE_TRUETYPE) += font.o
+obj-$(CONFIG_CMD_HASH) += hash.o
 obj-$(CONFIG_CMD_HISTORY) += history.o
 obj-$(CONFIG_CMD_LOADM) += loadm.o
 obj-$(CONFIG_CMD_MEMINFO) += meminfo.o
diff --git a/test/cmd/hash.c b/test/cmd/hash.c
new file mode 100644
index 00000000000..2fcec9cadcd
--- /dev/null
+++ b/test/cmd/hash.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Tests for hash command
+ *
+ * Copyright 2024, Heinrich Schuchardt <heinrich.schuchardt@canoncal.com>
+ */
+
+#include <command.h>
+#include <dm.h>
+#include <dm/test.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+static int dm_test_cmd_hash_md5(struct unit_test_state *uts)
+{
+	if (!CONFIG_IS_ENABLED(MD5)) {
+		ut_assert(run_command("hash md5 $loadaddr 0", 0));
+
+		return 0;
+	}
+
+	ut_assertok(run_command("hash md5 $loadaddr 0", 0));
+	console_record_readline(uts->actual_str, sizeof(uts->actual_str));
+	ut_asserteq_ptr(uts->actual_str,
+			strstr(uts->actual_str, "md5 for "));
+	ut_assert(strstr(uts->actual_str,
+			 "d41d8cd98f00b204e9800998ecf8427e"));
+	ut_assert_console_end();
+
+	ut_assertok(run_command("hash md5 $loadaddr 0 foo; echo $foo", 0));
+	console_record_readline(uts->actual_str, sizeof(uts->actual_str));
+	ut_asserteq_ptr(uts->actual_str,
+			strstr(uts->actual_str, "md5 for "));
+	ut_assert(strstr(uts->actual_str,
+			 "d41d8cd98f00b204e9800998ecf8427e"));
+	ut_check_console_line(uts, "d41d8cd98f00b204e9800998ecf8427e");
+
+	if (!CONFIG_IS_ENABLED(HASH_VERIFY)) {
+		ut_assert(run_command("hash -v sha256 $loadaddr 0 foo", 0));
+		ut_check_console_line(uts, "hash - compute hash message digest");
+
+		return 0;
+	}
+
+	ut_assertok(run_command("hash -v md5 $loadaddr 0 foo", 0));
+	ut_assert_console_end();
+
+	env_set("foo", "ffffffffffffffffffffffffffffffff");
+	ut_assert(run_command("hash -v md5 $loadaddr 0 foo", 0));
+	console_record_readline(uts->actual_str, sizeof(uts->actual_str));
+	ut_assert(strstr(uts->actual_str, "!="));
+	ut_assert_console_end();
+
+	return 0;
+}
+DM_TEST(dm_test_cmd_hash_md5, UTF_CONSOLE);
+
+static int dm_test_cmd_hash_sha256(struct unit_test_state *uts)
+{
+	if (!CONFIG_IS_ENABLED(SHA256)) {
+		ut_assert(run_command("hash sha256 $loadaddr 0", 0));
+
+		return 0;
+	}
+
+	ut_assertok(run_command("hash sha256 $loadaddr 0", 0));
+	console_record_readline(uts->actual_str, sizeof(uts->actual_str));
+	ut_asserteq_ptr(uts->actual_str,
+			strstr(uts->actual_str, "sha256 for "));
+	ut_assert(strstr(uts->actual_str,
+			 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"));
+	ut_assert_console_end();
+
+	ut_assertok(run_command("hash sha256 $loadaddr 0 foo; echo $foo", 0));
+	console_record_readline(uts->actual_str, sizeof(uts->actual_str));
+	ut_asserteq_ptr(uts->actual_str,
+			strstr(uts->actual_str, "sha256 for "));
+	ut_assert(strstr(uts->actual_str,
+			 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"));
+	ut_check_console_line(uts,
+			      "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855");
+
+	if (!CONFIG_IS_ENABLED(HASH_VERIFY)) {
+		ut_assert(run_command("hash -v sha256 $loadaddr 0 foo", 0));
+		ut_check_console_line(uts, "hash - compute hash message digest");
+
+		return 0;
+	}
+
+	ut_assertok(run_command("hash -v sha256 $loadaddr 0 foo", 0));
+	ut_assert_console_end();
+
+	env_set("foo", "ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff");
+	ut_assert(run_command("hash -v sha256 $loadaddr 0 foo", 0));
+	console_record_readline(uts->actual_str, sizeof(uts->actual_str));
+	ut_assert(strstr(uts->actual_str, "!="));
+	ut_assert_console_end();
+
+	return 0;
+}
+DM_TEST(dm_test_cmd_hash_sha256, UTF_CONSOLE);
-- 
2.45.2

