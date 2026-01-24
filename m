Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A57D715EE
	for <u-boot@archiver.kernel.org>; Sat, 24 Jan 2026 17:24:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE64383BE1;
	Sat, 24 Jan 2026 18:23:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="PiKzhY7Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7558E83BC8; Sat, 24 Jan 2026 18:23:54 +0100 (CET)
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4E7383B72
 for <u-boot@lists.denx.de>; Sat, 24 Jan 2026 18:23:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=linux@fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
 by mxout3.routing.net (Postfix) with ESMTP id 71F6360182;
 Sat, 24 Jan 2026 17:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
 s=routing; t=1769275431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E6shiLaeIZ6u2Lb4U2UEyPEdYRE/pvV8VshuRyB1E+0=;
 b=PiKzhY7YXemnPUXneR/R0HvizO+Pa2CyCW204xbQRU3vN1iaBKbVDZcngTIGeXe6msWQnP
 Lg9+RbB6s7HnBLkav3+PgvXSsvV0gp4SMxVPNufOROwiin9x+HVMY68iT8X5wzCpKtfsBB
 DIgbvjImpMuF1aFuIbEkdAOHab0MPcw=
Received: from frank-u24.. (fttx-pool-80.245.78.113.bambit.de [80.245.78.113])
 by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 597191226B6;
 Sat, 24 Jan 2026 17:23:51 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Tom Rini <trini@konsulko.com>
Cc: Frank Wunderlich <frank-w@public-files.de>, u-boot@lists.denx.de,
 Daniel Golle <daniel@makrotopia.org>
Subject: [PATCH v5 2/3] test: cmd: add test for memsize
Date: Sat, 24 Jan 2026 18:23:41 +0100
Message-ID: <20260124172344.926755-3-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260124172344.926755-1-linux@fw-web.de>
References: <20260124172344.926755-1-linux@fw-web.de>
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

From: Frank Wunderlich <frank-w@public-files.de>

Add a test for memsize command in same way as meminfo.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
tested via:
$ ./u-boot -T -c "ut cmd cmd_test_memsize"
...
Test: memsize: meminfo.c
Tests run: 1, 0 ms, average: 0 ms, failures: 0
---
 cmd/Kconfig        |  1 +
 test/cmd/meminfo.c | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index be79bf0747df..2bafa156ca8a 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -927,6 +927,7 @@ config CMD_MEMINFO_MAP
 
 config CMD_MEMSIZE
 	bool "memsize"
+	default y if SANDBOX
 	depends on CMD_MEMINFO
 	help
 	  Get RAM via command for use in scripts.
diff --git a/test/cmd/meminfo.c b/test/cmd/meminfo.c
index 53b41e3b49e0..ba772a8b7616 100644
--- a/test/cmd/meminfo.c
+++ b/test/cmd/meminfo.c
@@ -7,6 +7,7 @@
  */
 
 #include <dm/test.h>
+#include <env.h>
 #include <test/cmd.h>
 #include <test/ut.h>
 
@@ -39,4 +40,20 @@ static int cmd_test_meminfo(struct unit_test_state *uts)
 
 	return 0;
 }
+
+/* Test 'memsize' command */
+static int cmd_test_memsize(struct unit_test_state *uts)
+{
+	ut_assertok(run_command("memsize", 0));
+	ut_assert_nextline("256 MiB");
+	ut_assert_console_end();
+
+	ut_assertok(run_command("memsize memsz", 0));
+	ut_asserteq_str("256", env_get("memsz"));
+	ut_assert_console_end();
+
+	return 0;
+}
+
 CMD_TEST(cmd_test_meminfo, UTF_CONSOLE);
+CMD_TEST(cmd_test_memsize, UTF_CONSOLE);
-- 
2.43.0

