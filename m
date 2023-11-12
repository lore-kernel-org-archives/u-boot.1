Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E80B5C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 00:44:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7D6086F84;
	Sun, 12 Nov 2023 01:44:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UK5UYb67";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6FB086EB8; Sun, 12 Nov 2023 01:44:02 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 241CE86FB0
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 01:43:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7ad501764f4so138461139f.3
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 16:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699749830; x=1700354630; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NU0bxQ474wiaRkKIDrXkg9hmNYjnxrhx+rYSicKAlpk=;
 b=UK5UYb670JxzPlEagqJ2ZyAIJIwSmXH9M0HbhMqfpvmsvEq2pI6DnWG+o8+jxYwxyP
 fj3puLp0W+pYUjUPyn6cIZglMlhMn1MBLVD3rsZBOkm3OtoXI+rIDlEEbXyAIMontrcF
 ArdOSwQS16DT9EnbZ/fa6sg41BoNNjVO6ljmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699749830; x=1700354630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NU0bxQ474wiaRkKIDrXkg9hmNYjnxrhx+rYSicKAlpk=;
 b=PE5V8fOg2PTT4AZpSsr8rlyikyQKvo9sYcagt0scQxdDfc3rx1CRQBicpA31l2W6xE
 AOnxWTGeRi+UB1m2cURLw+X3/YSqCQt2DGvQPk0bXIvRpWZpCToWS54pfdmBqEBgrX8Z
 +LW6NfwcTPteivi2qSHVhHdenajguIG8Sl6t8jC5of7bx3tJ5Ver2Qrge7mXXZRh8i40
 DxDCdzpSl6Snw80EUEP912JZX9VDQlQtwaxYvObPlBkikv0OZOOMyKOYkrj+PiHzzmiv
 czANHeLlkWP8Np+PqGFy4poWuV5vQ7TkaF4WRWVTFkecSzgdnkLHLK/dmJnqQcHmGzJA
 WneA==
X-Gm-Message-State: AOJu0YwlkHuVW35iryr0kSJkbfpgRhOUjr35sn6wzc6y6Y/WLPYcJmk7
 rAAksS09OEIlp8JBaaViBM4UAiJQLAjdmE4Po7VB0g==
X-Google-Smtp-Source: AGHT+IGmNwLNVSlSUbYgnSpeFBSHXowZP6kRPuKE1bR3uWNMPRkIANbDOoCv7cgI4iuL7kFmUW+saA==
X-Received: by 2002:a05:6602:371a:b0:79a:b526:2f1c with SMTP id
 bh26-20020a056602371a00b0079ab5262f1cmr4146910iob.21.1699749830638; 
 Sat, 11 Nov 2023 16:43:50 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 k39-20020a056638372700b00457a6f281ddsm711388jav.59.2023.11.11.16.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 16:43:50 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH v2 2/3] tpm: Convert sandbox-focussed tests to C
Date: Sat, 11 Nov 2023 17:43:37 -0700
Message-ID: <20231111174337.v2.2.I8ff77e0c1288f6a4da564e9454eb223f72809839@changeid>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112004345.80145-1-sjg@chromium.org>
References: <20231112004345.80145-1-sjg@chromium.org>
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

Changes in v2:
- Keep test_tpm2_continue_self_test()

 test/dm/tpm.c              | 77 +++++++++++++++++++++++++++++++++++++-
 test/py/tests/test_tpm2.py | 38 +------------------
 2 files changed, 76 insertions(+), 39 deletions(-)

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
index 1d654cd4a23b..8ed337eddc10 100644
--- a/test/py/tests/test_tpm2.py
+++ b/test/py/tests/test_tpm2.py
@@ -56,7 +56,7 @@ def is_sandbox(cons):
     return sys_arch == 'sandbox'
 
 @pytest.mark.buildconfigspec('cmd_tpm_v2')
-def test_tpm2_init(u_boot_console):
+def test_tpm2_autostart(u_boot_console):
     """Init the software stack to use TPMv2 commands."""
     skip_test = u_boot_console.config.env.get('env__tpm_device_test_skip', False)
     if skip_test:
@@ -65,19 +65,6 @@ def test_tpm2_init(u_boot_console):
     output = u_boot_console.run_command('echo $?')
     assert output.endswith('0')
 
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
-    output = u_boot_console.run_command('echo $?')
-    assert output.endswith('0')
-
 def tpm2_sandbox_init(u_boot_console):
     """Put sandbox back into a known state so we can run a test
 
@@ -92,29 +79,6 @@ def tpm2_sandbox_init(u_boot_console):
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
-        u_boot_console.run_command('tpm2 autostart')
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
 @pytest.mark.buildconfigspec('cmd_tpm_v2')
 def test_tpm2_continue_self_test(u_boot_console):
     """Execute a TPM2_SelfTest (continued) command.
-- 
2.42.0.869.gea05f2083d-goog

