Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E971EC02182
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:27:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 699C4806F8;
	Mon, 20 Jan 2025 22:26:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PW+RcGoh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8525B806F8; Mon, 20 Jan 2025 22:26:44 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3959E807B9
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:26:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-844d5444b3dso172084439f.1
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737408400; x=1738013200; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JNA6NpLSY1BRZcdmcHoSO9SPr/E4tTOb+tIM9h4xQJo=;
 b=PW+RcGohH6pgB8QIhUheWE4j67J9CFq9EeBLQ6D7eyBHQ+tlwAD2iSX6/t7jyZRDD7
 kbLDOcKOU//B6HilttCrda5cn5GVpOz+x0W5vnuAV4TX/6hKu2U66dC5U3rN5Yxd9EWU
 bPUgS7FBIdx4kDXPLfUYpkm49fDfflEOYSIkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737408400; x=1738013200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JNA6NpLSY1BRZcdmcHoSO9SPr/E4tTOb+tIM9h4xQJo=;
 b=sp4I38mVanKZRym5Qs8xwtjOovtmAwaIwZyBe8GSQg0FwTNpVzYIaYS9IiXMU/eXdK
 Y06KDsjK3a2NwZNF9hma9x1ZzO49oZgKWLDEp8/LjXCaqvLJITCFpORK1JuiEWaPoknE
 SQNPY5i4pNXr2uJq03mWfXOPrvylFYlIErxq3w0C9UEz/TGg7eum7ov+3MEcRM0PFG8R
 aL+ReoqguxEfAflW6BG75MUgQ0LVUHS8L87luERuEBD/v7p2/bul2BOhtLCWrMwRDGx8
 QR0DxGh+NwbsbcTZrIdSy9Le6NgQ2IbnZctwEW6mvoaeIuTSZOj0kfCaUXCZeGlFrwJO
 TLQA==
X-Gm-Message-State: AOJu0YzSSpjfraOEZq1esmAc4l663gRklC35pD58EdowYKvV2kBXbPxU
 tmgygmGNivH7vZKFfVbYYSW1UalUbtdL/zJgTSTg8HZ4Y0cC+ShqpageGG+CdiY9TLTbTHI6VSM
 =
X-Gm-Gg: ASbGnct9KtsYvb15GLDbeL5Ig8aPOxfXQ4oDFfDyKQ2MPLLFwsoMFa188jX0moFoQQt
 rfZ+QnQTayTktXGIV4jvn/hZOJFSoN/c45bRH4+Bjdy5dlgORbqYACfOX17shH6dGeLnQle74o4
 3+uR137d6M7C7BziROuMJMAZzn4b5SdC3k33K5Z1veo5NUecrCA3gbxmaTCe6XM33B4CYKG688Y
 vewMc4wrVmVTp9YN4i9C/eLf3+3MtkxKwpisNLNoub9m06zaAd4tiLKNIRktLaZUs8K3ypXyxq1
 D8amlOo3W/dYRRMlUYIpTn2s++XgLQk=
X-Google-Smtp-Source: AGHT+IECn/I4OFYRhfjqXSIBe8GBfc5I/466ZlcM5r/jaZCrAwmvv0lScJ1zjZQKpZti1NFZzoa6bg==
X-Received: by 2002:a05:6602:4745:b0:835:39a8:e201 with SMTP id
 ca18e2360f4ac-84f67175a09mr2040725139f.0.1737408399958; 
 Mon, 20 Jan 2025 13:26:39 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75440a24sm2847693173.33.2025.01.20.13.26.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:26:38 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Massimiliano Minella <massimiliano.minella@se.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Ravi Minnikanti <rminnikanti@marvell.com>,
 Stephen Carlson <stcarlso@linux.microsoft.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 07/44] test: Rename test suites to match their linker-list
 name
Date: Mon, 20 Jan 2025 14:25:29 -0700
Message-ID: <20250120212613.516664-8-sjg@chromium.org>
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

Some suites have a different name from that used in the linker list.
That makes it hard to programmatically match the name printed when the
suite runs to the linker-list name it has.

Update the names so they are the same.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/test/cmd.h    | 2 +-
 test/boot/upl.c       | 3 +--
 test/cmd/addrmap.c    | 2 +-
 test/cmd/cmd_ut_cmd.c | 4 ++--
 test/cmd/exit.c       | 2 +-
 test/cmd/mem.c        | 2 +-
 test/cmd/pci_mps.c    | 2 +-
 test/cmd/setexpr.c    | 2 +-
 test/dm/test-dm.c     | 3 +--
 test/env/cmd_ut_env.c | 3 +--
 10 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/include/test/cmd.h b/include/test/cmd.h
index c200570e423..3d1e3e3bddb 100644
--- a/include/test/cmd.h
+++ b/include/test/cmd.h
@@ -10,6 +10,6 @@
 #include <test/test.h>
 
 /* Declare a new command test */
-#define CMD_TEST(_name, _flags) UNIT_TEST(_name, _flags, cmd_test)
+#define CMD_TEST(_name, _flags) UNIT_TEST(_name, _flags, cmd)
 
 #endif /* __TEST_CMD_H__ */
diff --git a/test/boot/upl.c b/test/boot/upl.c
index 99f02b7951b..ef65cf34055 100644
--- a/test/boot/upl.c
+++ b/test/boot/upl.c
@@ -432,6 +432,5 @@ int do_ut_upl(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	struct unit_test *tests = UNIT_TEST_SUITE_START(upl_test);
 	const int n_ents = UNIT_TEST_SUITE_COUNT(upl_test);
 
-	return cmd_ut_category("cmd_upl", "cmd_upl_", tests, n_ents, argc,
-			       argv);
+	return cmd_ut_category("upl", "cmd_upl_", tests, n_ents, argc, argv);
 }
diff --git a/test/cmd/addrmap.c b/test/cmd/addrmap.c
index b34be895f5d..43897615aa9 100644
--- a/test/cmd/addrmap.c
+++ b/test/cmd/addrmap.c
@@ -30,6 +30,6 @@ int do_ut_addrmap(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	struct unit_test *tests = UNIT_TEST_SUITE_START(addrmap_test);
 	const int n_ents = UNIT_TEST_SUITE_COUNT(addrmap_test);
 
-	return cmd_ut_category("cmd_addrmap", "cmd_addrmap_", tests, n_ents,
+	return cmd_ut_category("addrmap", "cmd_addrmap_", tests, n_ents,
 			       argc, argv);
 }
diff --git a/test/cmd/cmd_ut_cmd.c b/test/cmd/cmd_ut_cmd.c
index e77fa1c7f01..ad192563c5a 100644
--- a/test/cmd/cmd_ut_cmd.c
+++ b/test/cmd/cmd_ut_cmd.c
@@ -13,8 +13,8 @@
 
 int do_ut_cmd(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	struct unit_test *tests = UNIT_TEST_SUITE_START(cmd_test);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(cmd_test);
+	struct unit_test *tests = UNIT_TEST_SUITE_START(cmd);
+	const int n_ents = UNIT_TEST_SUITE_COUNT(cmd);
 
 	return cmd_ut_category("cmd", "cmd_test_", tests, n_ents, argc, argv);
 }
diff --git a/test/cmd/exit.c b/test/cmd/exit.c
index af58a57fca7..cf65c05e283 100644
--- a/test/cmd/exit.c
+++ b/test/cmd/exit.c
@@ -116,6 +116,6 @@ int do_ut_exit(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	struct unit_test *tests = UNIT_TEST_SUITE_START(exit_test);
 	const int n_ents = UNIT_TEST_SUITE_COUNT(exit_test);
 
-	return cmd_ut_category("cmd_exit", "exit_test_", tests, n_ents,
+	return cmd_ut_category("exit", "exit_test_", tests, n_ents,
 			       argc, argv);
 }
diff --git a/test/cmd/mem.c b/test/cmd/mem.c
index f1bbab6055b..d6f2544a4e9 100644
--- a/test/cmd/mem.c
+++ b/test/cmd/mem.c
@@ -14,6 +14,6 @@ int do_ut_mem(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	struct unit_test *tests = UNIT_TEST_SUITE_START(mem_test);
 	const int n_ents = UNIT_TEST_SUITE_COUNT(mem_test);
 
-	return cmd_ut_category("cmd_mem", "mem_test_", tests, n_ents, argc,
+	return cmd_ut_category("mem", "mem_test_", tests, n_ents, argc,
 			       argv);
 }
diff --git a/test/cmd/pci_mps.c b/test/cmd/pci_mps.c
index a265105600c..0c57d15d636 100644
--- a/test/cmd/pci_mps.c
+++ b/test/cmd/pci_mps.c
@@ -35,6 +35,6 @@ int do_ut_pci_mps(struct cmd_tbl *cmdtp, int flag, int argc,
 	struct unit_test *tests = UNIT_TEST_SUITE_START(pci_mps_test);
 	const int n = UNIT_TEST_SUITE_COUNT(pci_mps_test);
 
-	return cmd_ut_category("cmd_pci_mps", "pci_mps_test_", tests, n,
+	return cmd_ut_category("pci_mps", "pci_mps_test_", tests, n,
 			       argc, argv);
 }
diff --git a/test/cmd/setexpr.c b/test/cmd/setexpr.c
index 21a3268bd81..9b3277f2ad9 100644
--- a/test/cmd/setexpr.c
+++ b/test/cmd/setexpr.c
@@ -485,6 +485,6 @@ int do_ut_setexpr(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	struct unit_test *tests = UNIT_TEST_SUITE_START(setexpr_test);
 	const int n_ents = UNIT_TEST_SUITE_COUNT(setexpr_test);
 
-	return cmd_ut_category("cmd_setexpr", "setexpr_test_", tests, n_ents,
+	return cmd_ut_category("setexpr", "setexpr_test_", tests, n_ents,
 			       argc, argv);
 }
diff --git a/test/dm/test-dm.c b/test/dm/test-dm.c
index 4bc2c45db61..7cfbefe02da 100644
--- a/test/dm/test-dm.c
+++ b/test/dm/test-dm.c
@@ -11,6 +11,5 @@ int do_ut_dm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	struct unit_test *tests = UNIT_TEST_SUITE_START(dm_test);
 	const int n_ents = UNIT_TEST_SUITE_COUNT(dm_test);
 
-	return cmd_ut_category("driver model", "dm_test_", tests, n_ents, argc,
-			       argv);
+	return cmd_ut_category("dm", "dm_test_", tests, n_ents, argc, argv);
 }
diff --git a/test/env/cmd_ut_env.c b/test/env/cmd_ut_env.c
index 9f16a978f2a..494b5db395b 100644
--- a/test/env/cmd_ut_env.c
+++ b/test/env/cmd_ut_env.c
@@ -80,6 +80,5 @@ int do_ut_env(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	struct unit_test *tests = UNIT_TEST_SUITE_START(env_test);
 	const int n_ents = UNIT_TEST_SUITE_COUNT(env_test);
 
-	return cmd_ut_category("environment", "env_test_",
-			       tests, n_ents, argc, argv);
+	return cmd_ut_category("env", "env_test_", tests, n_ents, argc, argv);
 }
-- 
2.43.0

