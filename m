Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2724BC4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 04:29:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E97D987C7C;
	Sun, 29 Oct 2023 05:28:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m7DDHAut";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BB5A87C83; Sun, 29 Oct 2023 05:28:39 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 282EC87C83
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 05:28:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3b3f6f330d4so2145785b6e.2
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 21:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698553712; x=1699158512; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U3hXlOYeze3Jbx60zC7jvsXBtnRzMszdBtxrUnxM0xc=;
 b=m7DDHAutmOo9gUPnl7IxTL1GGNnmJpZNQQUgmPx79NaUOpYeGuSIWeRkWXaS99lrry
 4TDzE29v2csnFFI5gkOq+Nb+FAR4UckjUFX4MR7bWQOvOrCW36w57oulNFJm0Pm4skUM
 bTnEFLCbmQm2FKCoY18kiYZDoT0mJQ/+etG7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698553712; x=1699158512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U3hXlOYeze3Jbx60zC7jvsXBtnRzMszdBtxrUnxM0xc=;
 b=nvoSY3a76BlOtOfiWzgBASXZpeVU6lKA8qrsOzlpxh5ckSdlUAhly0qPOdqzz4OCDw
 lSJF5lLv8wCyVcojb1k1LYV+x+IB/ysSvGXtm9yq7dV/Oc6wSS/wYZVLHOYu5zFgf9Gq
 EcZY6A5uN8tU8Z3OgFejOUofKz1u5JQUQnSsR5cRfS33MEg19Bn7kh/zMGJrQzn+mHA+
 3f9z+SGBgQ4CP4DAjjNe2Lhj2S/qeXcqcHVJl8vBBC5G+cfVIJxzBgoaD/4NHESkXzED
 /kqG9SRoRoEOFhgK4v/7wsGLR7xy6nPqfEK+miO0M375XVuTCgKlRpvVbTYg1jYbv221
 n/WQ==
X-Gm-Message-State: AOJu0YyD0tyIk8qO6Ox3BXe/4eLWZggi15RLX0Vr1tZ+UEqqNxqxaWIM
 k329tQ+7LZbGw81l0zgglhz4h50sEoS28sNZ78B8Iw==
X-Google-Smtp-Source: AGHT+IFnesUK9jEL/gZkK/pdXWvr+oaQSFKcmeX42c8WTy8puzUvYkVjrkI+8y8ASo0peBoyXul4kQ==
X-Received: by 2002:a05:6808:f8e:b0:3a8:1c07:17d3 with SMTP id
 o14-20020a0568080f8e00b003a81c0717d3mr9034212oiw.19.1698553712480; 
 Sat, 28 Oct 2023 21:28:32 -0700 (PDT)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 s194-20020a6377cb000000b0058ac101ad83sm2920564pgc.33.2023.10.28.21.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 21:28:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH 2/3] tpm: Convert sandbox-focussed tests to C
Date: Sun, 29 Oct 2023 17:28:13 +1300
Message-ID: <20231029172813.2.I8ff77e0c1288f6a4da564e9454eb223f72809839@changeid>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
In-Reply-To: <20231029042817.3938657-1-sjg@chromium.org>
References: <20231029042817.3938657-1-sjg@chromium.org>
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

Some of the Python tests are a pain because they don't reset the TPM
state before each test. Driver model tests do this, so convert the
tests to C.

This means that these tests won't run on real hardware, but we have
tests which do TPM init, so there is still enough coverage.

Rename and update the Python tpm_init test to use 'tpm autostart',
since this deals with starting up ready for the tests below.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/dm/tpm.c              | 77 +++++++++++++++++++++++++++++++++++++-
 test/py/tests/test_tpm2.py | 57 +---------------------------
 2 files changed, 77 insertions(+), 57 deletions(-)

diff --git a/test/dm/tpm.c b/test/dm/tpm.c
index cde933ab2848..f8264af13789 100644
--- a/test/dm/tpm.c
+++ b/test/dm/tpm.c
@@ -50,14 +50,87 @@ static int test_tpm_init(struct unit_test_state *uts, enum tpm_version version)
 	return 0;
 }
 
-static int dm_test_tpm(struct unit_test_state *uts)
+static int dm_test_tpm_init(struct unit_test_state *uts)
 {
 	ut_assertok(test_tpm_init(uts, TPM_V1));
 	ut_assertok(test_tpm_init(uts, TPM_V2));
 
 	return 0;
 }
-DM_TEST(dm_test_tpm, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_tpm_init, UT_TESTF_SCAN_FDT);
+
+/* Test TPM startup */
+static int test_tpm_startup(struct unit_test_state *uts,
+			    enum tpm_version version)
+{
+	struct udevice *dev;
+
+	/* check probe success */
+	ut_assertok(get_tpm_version(version, &dev));
+
+	ut_assertok(tpm_init(dev));
+	ut_assertok(tpm_startup(dev, TPM_ST_CLEAR));
+
+	return 0;
+}
+
+static int dm_test_tpm_startup(struct unit_test_state *uts)
+{
+	ut_assertok(test_tpm_startup(uts, TPM_V1));
+	ut_assertok(test_tpm_startup(uts, TPM_V2));
+
+	return 0;
+}
+DM_TEST(dm_test_tpm_startup, UT_TESTF_SCAN_FDT);
+
+/* Test TPM self-test full */
+static int test_tpm_self_test_full(struct unit_test_state *uts,
+				   enum tpm_version version)
+{
+	struct udevice *dev;
+
+	/* check probe success */
+	ut_assertok(get_tpm_version(version, &dev));
+
+	ut_assertok(tpm_init(dev));
+	ut_assertok(tpm_startup(dev, TPM_ST_CLEAR));
+
+	return 0;
+}
+
+static int dm_test_tpm_self_test_full(struct unit_test_state *uts)
+{
+	ut_assertok(test_tpm_self_test_full(uts, TPM_V1));
+	ut_assertok(test_tpm_self_test_full(uts, TPM_V2));
+
+	return 0;
+}
+DM_TEST(dm_test_tpm_self_test_full, UT_TESTF_SCAN_FDT);
+
+/* Test TPM self-test continue */
+static int test_tpm_self_test_cont(struct unit_test_state *uts,
+				   enum tpm_version version)
+{
+	struct udevice *dev;
+
+	/* check probe success */
+	ut_assertok(get_tpm_version(version, &dev));
+
+	ut_assertok(tpm_init(dev));
+	ut_assertok(tpm_startup(dev, TPM_ST_CLEAR));
+	ut_assertok(tpm_continue_self_test(dev));
+
+	return 0;
+}
+
+static int dm_test_tpm_self_test_cont(struct unit_test_state *uts)
+{
+	ut_assertok(test_tpm_self_test_cont(uts, TPM_V1));
+	ut_assertok(test_tpm_self_test_cont(uts, TPM_V2));
+
+	return 0;
+}
+DM_TEST(dm_test_tpm_self_test_cont, UT_TESTF_SCAN_FDT);
 
 /* Test report_state */
 static int dm_test_tpm_report_state(struct unit_test_state *uts)
diff --git a/test/py/tests/test_tpm2.py b/test/py/tests/test_tpm2.py
index c2579fa02c58..522ed41de633 100644
--- a/test/py/tests/test_tpm2.py
+++ b/test/py/tests/test_tpm2.py
@@ -56,25 +56,12 @@ def is_sandbox(cons):
     return sys_arch == 'sandbox'
 
 @pytest.mark.buildconfigspec('cmd_tpm_v2')
-def test_tpm2_init(u_boot_console):
+def test_tpm2_autostart(u_boot_console):
     """Init the software stack to use TPMv2 commands."""
     skip_test = u_boot_console.config.env.get('env__tpm_device_test_skip', False)
     if skip_test:
         pytest.skip('skip TPM device test')
-    u_boot_console.run_command('tpm2 init')
-    output = u_boot_console.run_command('echo $?')
-    assert output.endswith('0')
-
-@pytest.mark.buildconfigspec('cmd_tpm_v2')
-def test_tpm2_startup(u_boot_console):
-    """Execute a TPM2_Startup command.
-
-    Initiate the TPM internal state machine.
-    """
-    skip_test = u_boot_console.config.env.get('env__tpm_device_test_skip', False)
-    if skip_test:
-        pytest.skip('skip TPM device test')
-    u_boot_console.run_command('tpm2 startup TPM2_SU_CLEAR')
+    u_boot_console.run_command('tpm2 autostart')
     output = u_boot_console.run_command('echo $?')
     assert output.endswith('0')
 
@@ -92,46 +79,6 @@ def tpm2_sandbox_init(u_boot_console):
     if skip_test:
         pytest.skip('skip TPM device test')
 
-@pytest.mark.buildconfigspec('cmd_tpm_v2')
-def test_tpm2_sandbox_self_test_full(u_boot_console):
-    """Execute a TPM2_SelfTest (full) command.
-
-    Ask the TPM to perform all self tests to also enable full capabilities.
-    """
-    if is_sandbox(u_boot_console):
-        u_boot_console.restart_uboot()
-        u_boot_console.run_command('tpm2 init')
-        output = u_boot_console.run_command('echo $?')
-        assert output.endswith('0')
-
-        u_boot_console.run_command('tpm2 startup TPM2_SU_CLEAR')
-        output = u_boot_console.run_command('echo $?')
-        assert output.endswith('0')
-
-    skip_test = u_boot_console.config.env.get('env__tpm_device_test_skip', False)
-    if skip_test:
-        pytest.skip('skip TPM device test')
-    u_boot_console.run_command('tpm2 self_test full')
-    output = u_boot_console.run_command('echo $?')
-    assert output.endswith('0')
-
-@pytest.mark.buildconfigspec('cmd_tpm_v2')
-def test_tpm2_continue_self_test(u_boot_console):
-    """Execute a TPM2_SelfTest (continued) command.
-
-    Ask the TPM to finish its self tests (alternative to the full test) in order
-    to enter a fully operational state.
-    """
-
-    skip_test = u_boot_console.config.env.get('env__tpm_device_test_skip', False)
-    if skip_test:
-        pytest.skip('skip TPM device test')
-    if is_sandbox(u_boot_console):
-        tpm2_sandbox_init(u_boot_console)
-    u_boot_console.run_command('tpm2 self_test continue')
-    output = u_boot_console.run_command('echo $?')
-    assert output.endswith('0')
-
 @pytest.mark.buildconfigspec('cmd_tpm_v2')
 def test_tpm2_clear(u_boot_console):
     """Execute a TPM2_Clear command.
-- 
2.42.0.820.g83a721a137-goog

