Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26524C02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:38:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A92A80C6D;
	Wed, 15 Jan 2025 14:32:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z9Fmp2NC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A65BF80BAA; Wed, 15 Jan 2025 14:32:23 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5544E80714
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:32:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-844ce6d0716so467578039f.1
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947939; x=1737552739; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kdgkERWxJf2f8v6gZMHipEh1Pu/zQne6mbLP6QADYNg=;
 b=Z9Fmp2NCH8GDm5OI7RmPAB6PeLKUWcIU3pGIHNuUmI374F4IBEvft3VWhSz0/3gKej
 kLZJWbK8/q0m3KF77GE6hLXkHWXnYfGVmOWCP7k+zr0U9QiPoZaKeoWhLKzkkmPYtemT
 RA+SXEZ7NpJocDroEhG/wchABCECI5LqYakcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947939; x=1737552739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kdgkERWxJf2f8v6gZMHipEh1Pu/zQne6mbLP6QADYNg=;
 b=h+0SLuYpXeW9YzepnDN0lGQHxfbdCMHj2E8N8AktblpbKrO7Dnw/3aA8hxTU2DKj4g
 SEHPaYslrI5RBj+fTxVLF0kuOd4dJCaNvF/oWeW1ZrMgv8iJbow9RcioIwMZ3V9BnoaO
 QdSiyG56MEhFpfC+2Yq4u1cVAIaPj191SplaqIK0zCGVRYNf5f5Vq3/IofzyYgDeK488
 hiKFFyGHzfGlcC5RgCUwLQBt/WRRKB9FFLMfX3HFWFBcyTmrboQD4rtTEgOlGdPvvWef
 Y7Ngrrl6ywIVGSg1LvMT54K30l1EtwpgKLBRdnIHMRH/GwRgvv/R836wVj32MI2Y2p82
 S1eA==
X-Gm-Message-State: AOJu0YzHvpV5/RdMBAZWsv5DPnnuz/4MhbSMksUk6fz274sf1P070Y3V
 J7dtNKxAxAuwF9FipDn5EfQoGEHNqR/FHts4Peod4EBDnu0hWS1nwsuq/KzfXiT9h3rl3hvUt98
 =
X-Gm-Gg: ASbGncsdd4mD2J6x4ndDJJYD78d5HZ+tXRDYM58Wfw7LYL3KwXBO6VFb0NxIIpppDKc
 TjVKYjRAlbk0kfzc6KBHOyDb0VgzKKOlLTAG7AFbTaIdpecvUIpOG5HxZ0wdjw9JTZjlQy1xxVs
 baQdaJEK6kn/U54tG7LVrkATVFxp+HdRKiMVMtgAsVSc1A4N9dMy8VdT8f7ldbZPq9NKKmHnZFe
 f0G3oQ32W4U+d+2IfWrrk4JApIu/PTnAV8tHrwX3mdp6r67VfHwjr55XTgvhfUawVG7APPXHi36
 N5YuwdTBpv9zW4SOSQ==
X-Google-Smtp-Source: AGHT+IHWK/tdqHKuyDwI6p6NF28A8Zc4SwLjvp56lZ/4xVh8UP23AEutvq2thWHglK3n3+KOsvPWDQ==
X-Received: by 2002:a05:6e02:1525:b0:3ce:78bf:3c0e with SMTP id
 e9e14a558f8ab-3ce78bf3de3mr82911905ab.1.1736947939494; 
 Wed, 15 Jan 2025 05:32:19 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm4091248173.20.2025.01.15.05.32.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:32:18 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 35/43] test: Drop conditional compilation for suites
Date: Wed, 15 Jan 2025 06:31:05 -0700
Message-Id: <20250115133114.590375-36-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250115133114.590375-1-sjg@chromium.org>
References: <20250115133114.590375-1-sjg@chromium.org>
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

This is not needed anymore. If a test suite is not built, then it will
have no linker-list entries. So we can just check for that and know that
the suite is not present.

This allows removal of the #ifdefs and the need to keep them in sync
with the associated Makefile rules, which has actually failed, since the
help does not match what commands are actually present.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/cmd_ut.c               | 75 ++++++++++++++++---------------------
 test/py/tests/test_suite.py | 19 +++++++---
 2 files changed, 46 insertions(+), 48 deletions(-)

diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 798710972e5..2ba99a26c63 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -120,76 +120,55 @@ SUITE_DECL(seama);
 SUITE_DECL(upl);
 
 static struct suite suites[] = {
-#ifdef CONFIG_CMD_BDI
 	SUITE(bdinfo),
-#endif
 #ifdef CONFIG_UT_BOOTSTD
 	SUITE_CMD(bootstd, do_ut_bootstd),
 #endif
-#ifdef CONFIG_CMDLINE
 	SUITE(cmd),
-#endif
 	SUITE(common),
-#if defined(CONFIG_UT_DM)
 	SUITE(dm),
-#endif
-#if defined(CONFIG_UT_ENV)
 	SUITE(env),
-#endif
 	SUITE(exit),
-#ifdef CONFIG_CMD_FDT
 	SUITE(fdt),
-#endif
-#ifdef CONFIG_CONSOLE_TRUETYPE
 	SUITE(font),
-#endif
 #ifdef CONFIG_UT_OPTEE
 	SUITE_CMD(optee, do_ut_optee),
 #endif
 #ifdef CONFIG_UT_OVERLAY
 	SUITE_CMD(overlay, do_ut_overlay),
 #endif
-#ifdef CONFIG_UT_LIB
 	SUITE(lib),
-#endif
-#ifdef CONFIG_UT_LOG
 	SUITE(log),
-#endif
-#if defined(CONFIG_SANDBOX) && defined(CONFIG_CMD_MBR) && defined(CONFIG_CMD_MMC) \
-        && defined(CONFIG_MMC_SANDBOX) && defined(CONFIG_MMC_WRITE)
 	SUITE(mbr),
-#endif
 	SUITE(mem),
-#if defined(CONFIG_SANDBOX) && defined(CONFIG_CMD_SETEXPR)
 	SUITE(setexpr),
-#endif
-#ifdef CONFIG_MEASURED_BOOT
 	SUITE(measurement),
-#endif
-#ifdef CONFIG_SANDBOX
 	SUITE(bloblist),
 	SUITE(bootm),
-#endif
-#ifdef CONFIG_CMD_ADDRMAP
 	SUITE(addrmap),
-#endif
-#if CONFIG_IS_ENABLED(HUSH_PARSER)
 	SUITE(hush),
-#endif
-#ifdef CONFIG_CMD_LOADM
 	SUITE(loadm),
-#endif
-#ifdef CONFIG_CMD_PCI_MPS
 	SUITE(pci_mps),
-#endif
-#ifdef CONFIG_CMD_SEAMA
 	SUITE(seama),
-#endif
-#ifdef CONFIG_CMD_UPL
 	SUITE(upl),
-#endif
 };
 
+/**
+ * has_tests() - Check if a suite has tests, i.e. is supported in this build
+ *
+ * If the suite is run using a command, we have to assume that tests may be
+ * present, since we have no visibility
+ *
+ * @ste: Suite to check
+ * Return: true if supported, false if not
+ */
+static bool has_tests(struct suite *ste)
+{
+	int n_ents = ste->end - ste->start;
+
+	return n_ents || ste->cmd;
+}
+
 /** run_suite() - Run a suite of tests */
 static int run_suite(struct suite *ste, struct cmd_tbl *cmdtp, int flag,
 		     int argc, char *const argv[])
@@ -222,10 +201,12 @@ static int do_ut_all(struct cmd_tbl *cmdtp, int flag, int argc,
 		struct suite *ste = &suites[i];
 		char *const argv[] = {(char *)ste->name, NULL};
 
-		printf("----Running %s tests----\n", ste->name);
-		retval = run_suite(ste, cmdtp, flag, 1, argv);
-		if (!any_fail)
-			any_fail = retval;
+		if (has_tests(ste)) {
+			printf("----Running %s tests----\n", ste->name);
+			retval = run_suite(ste, cmdtp, flag, 1, argv);
+			if (!any_fail)
+				any_fail = retval;
+		}
 	}
 
 	return any_fail;
@@ -234,9 +215,17 @@ static int do_ut_all(struct cmd_tbl *cmdtp, int flag, int argc,
 static int do_ut_info(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[])
 {
+	int suite_count, i;
 	const char *flags;
 
-	printf("Test suites: %d\n", (int)ARRAY_SIZE(suites));
+	for (suite_count = 0, i = 0; i < ARRAY_SIZE(suites); i++) {
+		struct suite *ste = &suites[i];
+
+		if (has_tests(ste))
+			suite_count++;
+	}
+
+	printf("Test suites: %d\n", suite_count);
 	printf("Total tests: %d\n", (int)UNIT_TEST_ALL_COUNT());
 
 	flags = cmd_arg1(argc, argv);
@@ -251,7 +240,7 @@ static int do_ut_info(struct cmd_tbl *cmdtp, int flag, int argc,
 
 			if (n_ent)
 				printf("%5ld  %s\n", n_ent, ste->name);
-			else
+			else if (ste->cmd)
 				printf("%5s  %s\n", "?", ste->name);
 		}
 	}
diff --git a/test/py/tests/test_suite.py b/test/py/tests/test_suite.py
index 938dfb468f6..1c248602199 100644
--- a/test/py/tests/test_suite.py
+++ b/test/py/tests/test_suite.py
@@ -106,7 +106,7 @@ def process_ut_info(cons, output):
     test_count = {}
     for line in output.splitlines():
         if DEBUG_ME:
-            cons.log.info(f'line: {line}')
+            cons.log.info(f'line: {line.rstrip()}')
         m = re.match(r'Test suites: (.*)', line)
         if m:
             suite_count = int(m.group(1))
@@ -122,7 +122,7 @@ def process_ut_info(cons, output):
 @pytest.mark.buildconfigspec('sandbox')
 @pytest.mark.notbuildconfigspec('sandbox_spl')
 @pytest.mark.notbuildconfigspec('sandbox64')
-def test_suite(u_boot_console):
+def test_suite(u_boot_console, u_boot_config):
     """Perform various checks on the unit tests, including:
 
        - The number of suites matches that reported by the 'ut info'
@@ -135,6 +135,7 @@ def test_suite(u_boot_console):
 
     """
     cons = u_boot_console
+    buildconfig = u_boot_config.buildconfig
     with cons.log.section('Run all unit tests'):
         # ut hush hush_test_simple_dollar prints "Unknown command" on purpose.
         with u_boot_console.disable_check('unknown_command'):
@@ -144,9 +145,17 @@ def test_suite(u_boot_console):
     with cons.log.section('Check output'):
         suites, all_tests, exp_test_count, missing, extra = collect_info(cons,
                                                                          output)
+    cons.log.info(f'missing {missing}')
+    cons.log.info(f'extra {extra}')
 
     # Make sure we got a test count for each suite
-    assert suites - exp_test_count.keys() == set()
+    assert not (suites - exp_test_count.keys())
+
+    # Deal with missing suites
+    with cons.log.section('Check missing suites'):
+        if 'config_cmd_seama' not in buildconfig:
+            cons.log.info("CMD_SEAMA not enabled: Ignoring suite 'seama'")
+            missing.discard('seama')
 
     # Run 'ut info' and compare with the log results
     with cons.log.section('Check suite test-counts'):
@@ -160,8 +169,8 @@ def test_suite(u_boot_console):
             cons.log.error(f'missing: {sorted(list(missing))}')
             cons.log.error(f'extra: {sorted(list(extra))}')
 
-        assert not missing
-        assert not extra
+        assert not missing, f'Missing suites {missing}'
+        assert not extra, f'Extra suites {extra}'
 
         cons.log.info(str(exp_test_count))
         for suite in EXPECTED_SUITES:
-- 
2.34.1

