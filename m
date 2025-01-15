Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD0EC02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:38:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC88C80BAE;
	Wed, 15 Jan 2025 14:32:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XxaLYGN1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA9D380BA6; Wed, 15 Jan 2025 14:32:30 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DAC680C89
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:32:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-844ee166150so214571939f.2
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947946; x=1737552746; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iyvLMmZOJfluayJ4EIYtotBULddcvFRca779fTaOVSw=;
 b=XxaLYGN1HAo5JUIRNrUeWT0+LH7ugREIZZUr/x6yzqpElv0GgBwOyAPccC1jfSOe8B
 l+vR9+dW2a2t3pGdK4xhRBM5blQt83uacnvIyuaQ7rjJW9h7IETTVUnzJMtWks5OXx9s
 8IRT7GiU71SD6WHazqVzPjLGaxNSzTSSkPe+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947946; x=1737552746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iyvLMmZOJfluayJ4EIYtotBULddcvFRca779fTaOVSw=;
 b=HYO1VxImRzsVbMeQKqWyXjOFOldk8XJ1ukkSlIuqz3J8hPNdHDQgAHpMmslb0+cKcB
 YsYPvDVXIecqqSb40LOoaZ6eet4VIZ80ZjuLs6Tts2EB5Wq83DTQPlMSFszEuMh0r1PY
 EhmUXLGnTvb9d57a9qCwvq4GjmKdyG0JgDimehaoQ+TusjW8DUh+cd+zjObBLJWcbtb1
 ieUoG6uV77n8B50nJty2/YL8gYJsq3TgWTKQ8GeCSp2TEVDJp0jfuh2R0occlsU+lyE3
 73VvJ1/fy0JcquHsDOyU3KT/agKvSEuexFf0vgPZPoavE9oJbtqilldXIPCnF5L4MbPy
 lHSg==
X-Gm-Message-State: AOJu0YxG4auYYw4eQ///YCBb0T92iPkrVLbeuTsiYRw5PZdEr8HUHe6c
 uy1D9Xe7YdpDY6XhjX96dJMBp3XQVv8m+CecYhvPewm9Z9KJX5ATFtPti47+0rVx6DmbM/MUiys
 =
X-Gm-Gg: ASbGncvT7wArTD2+8wGVqKRZKbpQaZ8rzOnZwTIinaZXe8/aoZmJ8521FjLX0RYonwi
 KJSesjrtmeKZHTlh+mNsaxxVaY8K0yeHBUcsfjvumCc5u+hkKSaZir79lL1mZlJngubuqPOm3V6
 HBzrSmO15jZuAbLUZ+lRny4p3xmut9J2P6nBnyjLDv41VsPcxM8Q2V6ECSlucSJHZ4dJ3ZGOftj
 sdxrGU3VkE4FbS9yxcVNGN8z+2w7Q7Rb03Lb9ZbRf9fGIpmmLBETjn9tBuLoLZoj68pGO8e98Tv
 E9nqFUOiiOC7T+jSIQ==
X-Google-Smtp-Source: AGHT+IF2ThfQboQLAtB4tnIGYNyKMlzrUtO+tmHNajBtVDOIb9r2AK2bKvHZGU3jrIyeZuwTV+ptOw==
X-Received: by 2002:a05:6602:4c07:b0:844:e21a:e805 with SMTP id
 ca18e2360f4ac-84ce014c328mr2654391239f.9.1736947946481; 
 Wed, 15 Jan 2025 05:32:26 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm4091248173.20.2025.01.15.05.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:32:25 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Richard Weinberger <richard@nod.at>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 39/43] test: Move stat-printing into its own function
Date: Wed, 15 Jan 2025 06:31:09 -0700
Message-Id: <20250115133114.590375-40-sjg@chromium.org>
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

Add a function to show the stats, so we can decide when to print it.

This slightly adjusts the output, so that any 'test not found' message
appears on its own line after all other output.

The 'failures' message now appears in lower case so update pytest
accordingly.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/sandbox/cpu/spl.c    |  1 +
 include/test/ut.h         |  8 ++++++++
 test/py/tests/test_spl.py |  2 +-
 test/py/tests/test_upl.py |  2 +-
 test/py/tests/test_ut.py  |  2 +-
 test/py/tests/test_vbe.py |  2 +-
 test/py/tests/test_vpl.py |  2 +-
 test/test-main.c          | 14 +++++++++-----
 8 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/arch/sandbox/cpu/spl.c b/arch/sandbox/cpu/spl.c
index 0ad23e4ba95..544ea8717eb 100644
--- a/arch/sandbox/cpu/spl.c
+++ b/arch/sandbox/cpu/spl.c
@@ -153,6 +153,7 @@ void spl_board_init(void)
 		ut_init_state(&uts);
 		ret = ut_run_list(&uts, "spl", NULL, tests, count,
 				  state->select_unittests, 1, false, NULL);
+		ut_report(&uts.cur, "Tests");
 		ut_uninit_state(&uts);
 		/* continue execution into U-Boot */
 	}
diff --git a/include/test/ut.h b/include/test/ut.h
index a51defc3b90..55bb5aa2092 100644
--- a/include/test/ut.h
+++ b/include/test/ut.h
@@ -530,4 +530,12 @@ int ut_run_list(struct unit_test_state *uts, const char *category,
 		const char *select_name, int runs_per_test, bool force_run,
 		const char *test_insert);
 
+/**
+ * ut_report() - Report stats on a test run
+ *
+ * @stats: Stats to show
+ * @prefix: Name of this run type, e.g. "Tests" or "Total tests"
+ */
+void ut_report(struct ut_stats *stats, const char *prefix);
+
 #endif
diff --git a/test/py/tests/test_spl.py b/test/py/tests/test_spl.py
index 42e4c4342b2..474f430a344 100644
--- a/test/py/tests/test_spl.py
+++ b/test/py/tests/test_spl.py
@@ -36,7 +36,7 @@ def test_spl(u_boot_console, ut_spl_subtest):
         cons = u_boot_console
         cons.restart_uboot_with_flags(['-u', '-k', ut_spl_subtest.split()[1]])
         output = cons.get_spawn_output().replace('\r', '')
-        assert 'Failures: 0' in output
+        assert 'failures: 0' in output
     finally:
         # Restart afterward in case a non-SPL test is run next. This should not
         # happen since SPL tests are run in their own invocation of test.py, but
diff --git a/test/py/tests/test_upl.py b/test/py/tests/test_upl.py
index 3164bda6b71..d94359d8b9b 100644
--- a/test/py/tests/test_upl.py
+++ b/test/py/tests/test_upl.py
@@ -35,4 +35,4 @@ def test_upl_handoff(u_boot_console):
 
     # Check the FIT offsets look correct
     output = cons.run_command('ut upl -f upl_test_info_norun')
-    assert 'Failures: 0' in output
+    assert 'failures: 0' in output
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index cacf11f7c0a..d2d8ce10755 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -607,4 +607,4 @@ def test_ut(u_boot_console, ut_subtest):
         assert 'Unknown command \'quux\' - try \'help\'' in output
     else:
         output = u_boot_console.run_command('ut ' + ut_subtest)
-    assert output.endswith('Failures: 0')
+    assert output.endswith('failures: 0')
diff --git a/test/py/tests/test_vbe.py b/test/py/tests/test_vbe.py
index 50b6c1cd911..861df3f8266 100644
--- a/test/py/tests/test_vbe.py
+++ b/test/py/tests/test_vbe.py
@@ -117,4 +117,4 @@ def test_vbe(u_boot_console):
     with cons.log.section('Kernel load'):
         output = cons.run_command_list(cmd.splitlines())
 
-    assert 'Failures: 0' in output[-1]
+    assert 'failures: 0' in output[-1]
diff --git a/test/py/tests/test_vpl.py b/test/py/tests/test_vpl.py
index 4af578b9173..8c472ca7a92 100644
--- a/test/py/tests/test_vpl.py
+++ b/test/py/tests/test_vpl.py
@@ -26,7 +26,7 @@ def test_vpl(u_boot_console, ut_vpl_subtest):
         cons = u_boot_console
         cons.restart_uboot_with_flags(['-u', '-k', ut_vpl_subtest.split()[1]])
         output = cons.get_spawn_output().replace('\r', '')
-        assert 'Failures: 0' in output
+        assert 'failures: 0' in output
     finally:
         # Restart afterward in case a non-VPL test is run next. This should not
         # happen since VPL tests are run in their own invocation of test.py, but
diff --git a/test/test-main.c b/test/test-main.c
index e36bc37d29e..a0a3f6086ef 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -673,6 +673,14 @@ static int ut_run_tests(struct unit_test_state *uts, const char *prefix,
 	return uts->cur.fail_count ? -EBADF : 0;
 }
 
+void ut_report(struct ut_stats *stats, const char *prefix)
+{
+	printf("%s run: %d, ", prefix, stats->test_count);
+	if (stats->skip_count)
+		printf("skipped: %d, ", stats->skip_count);
+	printf("failures: %d\n", stats->fail_count);
+}
+
 int ut_run_list(struct unit_test_state *uts, const char *category,
 		const char *prefix, struct unit_test *tests, int count,
 		const char *select_name, int runs_per_test, bool force_run,
@@ -718,13 +726,9 @@ int ut_run_list(struct unit_test_state *uts, const char *category,
 	if (has_dm_tests)
 		dm_test_restore(uts->of_root);
 
-	printf("Tests run: %d, ", uts->cur.test_count);
-	if (uts->cur.skip_count)
-		printf("Skipped: %d, ", uts->cur.skip_count);
+	ut_report(&uts->cur, "Tests");
 	if (ret == -ENOENT)
 		printf("Test '%s' not found\n", select_name);
-	else
-		printf("Failures: %d\n", uts->cur.fail_count);
 
 	return ret;
 }
-- 
2.34.1

