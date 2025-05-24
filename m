Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4081C54FC6
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 13:07:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 745068310F;
	Sat, 24 May 2025 15:06:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NR31El1g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAF8183264; Sat, 24 May 2025 15:06:57 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CC71830EB
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 15:06:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-8613f456960so19762939f.1
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 06:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748092014; x=1748696814; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=glU+Awe7ElzIGTnMuLUgPJvC0YKR7FFLKC/Dk3qJs0o=;
 b=NR31El1g6MYd3CWmdSJtUV35KXtMRZzhmJXw3XTruZrZcWFzkH6XDA3qpgwJD3iTYn
 ZA2ZqL2WRGXJRWZScePpYcVHtGnHMVkeTDLoF0gxS/odphpg8UoI0GgIxZWVT+Ss5fgt
 7UHBi8VUan0WKbi7JjWp28S4GwJhBYX1/BTG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748092014; x=1748696814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=glU+Awe7ElzIGTnMuLUgPJvC0YKR7FFLKC/Dk3qJs0o=;
 b=DPH2rvYk25Qs5bYp/zex7T2ipVEVjgOueBsTKf7S6wM221C+cPO9WjgCfJET27P+aV
 +L9bxJ/G4c0xYL90zeOfi0O5SZdDw/c9ToFo6sYBYhCIWiIYVwOj3dxkgyMNWpGBGX39
 RTcz88wwq4KrTEGKWVATG12Y/veulS/i6Xm26+YfYKPJVkNZ8Yat5vUCgnb1SAoi/daB
 sCpnaXiPJ++rRTa+hQ7ImVAojZXvZbcBtkiZOzHURIKUdXP9sg2Kj+fGAIKCdXjT4Rxl
 gSCD+gWdEe9VoRbhB+IPHt8/a8BL76h24Rrv3OD5igbgGCUlt5he+U8ilzX+QbA8ejOG
 kS/g==
X-Gm-Message-State: AOJu0YyS/Jfjhtg80Toatv7P6KPPAK2AFd9T/51Iiq98BgMFKSIxK7ES
 ZrICEHVzUbJ8SPbT1fftsBHpxmamU9Ll2RDckh6/TvTJaQyLC2fq9GwtpsGM4Wngpq2nPtz78QF
 xcIlsmCNj
X-Gm-Gg: ASbGncu6lkiGnrV9lQ3kfp0/9zmc2OsGVj+CfhE0jQEdDgm3Obq38yK5n6wjXaDRVVf
 l6tMqk/rOoOJUJTJiIdFLsHRR8QMqsy8K/rFlnyOLev8W2hBAnEi7EV6i7+Rcf5g07/qPBsW7MA
 XlwrR+cypv9eZ+WgpiiR1OoXJeEkuoVlSC1cNVz5oJKXoocV0SiQ3sAKCLKu6x8exccCfDC/iI2
 FAaqHx9p3H/j8I3nM5GW4g0ogfzYgTsJOW8ax0lTpdDu27NRFelgP9NLE46DKXz4Zj/FhAyTPU/
 1RjQ18icF5YEu+Y0Fu9XaWjZOmpwQzkSoXcsmd+bi97uHN2o+//nUKh6jXS3kOg8RcT2IMivbft
 lBhFOY71zgHqL
X-Google-Smtp-Source: AGHT+IGj7bF8ZGwDHj6cswmMg0VTJJYzwX+Ft+NSgbV0fDxGH4br2lhSoZPcdE0s65mo0shi1MmeuQ==
X-Received: by 2002:a05:6602:3998:b0:86c:af68:67a4 with SMTP id
 ca18e2360f4ac-86cbb7b85f5mr255132339f.2.1748092013667; 
 Sat, 24 May 2025 06:06:53 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-86a236e898dsm373238339f.37.2025.05.24.06.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 06:06:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v3 2/4] tpm: Convert sandbox-focussed tests to C
Date: Sat, 24 May 2025 07:06:35 -0600
Message-ID: <20250524070636.v3.2.I8ff77e0c1288f6a4da564e9454eb223f72809839@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250524130642.902486-1-sjg@chromium.org>
References: <20250524130642.902486-1-sjg@chromium.org>
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

Changes in v3:
- Use 'check' instead of 'test' when naming test helpers
- Add missing tpm_self_test_full() call

Changes in v2:
- Keep test_tpm2_continue_self_test()

 test/dm/tpm.c              | 77 +++++++++++++++++++++++++++++++++++++-
 test/py/tests/test_tpm2.py | 38 +------------------
 2 files changed, 76 insertions(+), 39 deletions(-)

diff --git a/test/dm/tpm.c b/test/dm/tpm.c
index 962a3fd1943..87c5c416daa 100644
--- a/test/dm/tpm.c
+++ b/test/dm/tpm.c
@@ -49,14 +49,87 @@ static int test_tpm_init(struct unit_test_state *uts, enum tpm_version version)
 	return 0;
 }
 
-static int dm_test_tpm(struct unit_test_state *uts)
+static int dm_test_tpm_init(struct unit_test_state *uts)
 {
 	ut_assertok(test_tpm_init(uts, TPM_V1));
 	ut_assertok(test_tpm_init(uts, TPM_V2));
 
 	return 0;
 }
-DM_TEST(dm_test_tpm, UTF_SCAN_FDT);
+DM_TEST(dm_test_tpm_init, UTF_SCAN_FDT);
+
+/* check TPM startup */
+static int check_tpm_startup(struct unit_test_state *uts,
+			     enum tpm_version version)
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
+/* test TPM startup */
+static int dm_test_tpm_startup(struct unit_test_state *uts)
+{
+	ut_assertok(check_tpm_startup(uts, TPM_V1));
+	ut_assertok(check_tpm_startup(uts, TPM_V2));
+
+	return 0;
+}
+DM_TEST(dm_test_tpm_startup, UTF_SCAN_FDT);
+
+static int check_tpm_self_test_full(struct unit_test_state *uts,
+				    enum tpm_version version)
+{
+	struct udevice *dev;
+
+	ut_assertok(check_tpm_startup(uts, version));
+
+	ut_assertok(get_tpm_version(version, &dev));
+	ut_assertok(tpm_self_test_full(dev));
+
+	return 0;
+}
+
+/* Test TPM self-test full */
+static int dm_test_tpm_self_test_full(struct unit_test_state *uts)
+{
+	ut_assertok(check_tpm_self_test_full(uts, TPM_V1));
+	ut_assertok(check_tpm_self_test_full(uts, TPM_V2));
+
+	return 0;
+}
+DM_TEST(dm_test_tpm_self_test_full, UTF_SCAN_FDT);
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
+DM_TEST(dm_test_tpm_self_test_cont, UTF_SCAN_FDT);
 
 /* Test report_state */
 static int dm_test_tpm_report_state(struct unit_test_state *uts)
diff --git a/test/py/tests/test_tpm2.py b/test/py/tests/test_tpm2.py
index 064651c3e23..e55adfe784c 100644
--- a/test/py/tests/test_tpm2.py
+++ b/test/py/tests/test_tpm2.py
@@ -56,7 +56,7 @@ def is_sandbox(ubman):
     return sys_arch == 'sandbox'
 
 @pytest.mark.buildconfigspec('cmd_tpm_v2')
-def test_tpm2_init(ubman):
+def test_tpm2_autostart(ubman):
     """Init the software stack to use TPMv2 commands."""
     skip_test = ubman.config.env.get('env__tpm_device_test_skip', False)
     if skip_test:
@@ -65,19 +65,6 @@ def test_tpm2_init(ubman):
     output = ubman.run_command('echo $?')
     assert output.endswith('0')
 
-@pytest.mark.buildconfigspec('cmd_tpm_v2')
-def test_tpm2_startup(ubman):
-    """Execute a TPM2_Startup command.
-
-    Initiate the TPM internal state machine.
-    """
-    skip_test = ubman.config.env.get('env__tpm_device_test_skip', False)
-    if skip_test:
-        pytest.skip('skip TPM device test')
-    ubman.run_command('tpm2 startup TPM2_SU_CLEAR')
-    output = ubman.run_command('echo $?')
-    assert output.endswith('0')
-
 def tpm2_sandbox_init(ubman):
     """Put sandbox back into a known state so we can run a test
 
@@ -92,29 +79,6 @@ def tpm2_sandbox_init(ubman):
     if skip_test:
         pytest.skip('skip TPM device test')
 
-@pytest.mark.buildconfigspec('cmd_tpm_v2')
-def test_tpm2_sandbox_self_test_full(ubman):
-    """Execute a TPM2_SelfTest (full) command.
-
-    Ask the TPM to perform all self tests to also enable full capabilities.
-    """
-    if is_sandbox(ubman):
-        ubman.restart_uboot()
-        ubman.run_command('tpm2 autostart')
-        output = ubman.run_command('echo $?')
-        assert output.endswith('0')
-
-        ubman.run_command('tpm2 startup TPM2_SU_CLEAR')
-        output = ubman.run_command('echo $?')
-        assert output.endswith('0')
-
-    skip_test = ubman.config.env.get('env__tpm_device_test_skip', False)
-    if skip_test:
-        pytest.skip('skip TPM device test')
-    ubman.run_command('tpm2 self_test full')
-    output = ubman.run_command('echo $?')
-    assert output.endswith('0')
-
 @pytest.mark.buildconfigspec('cmd_tpm_v2')
 def test_tpm2_continue_self_test(ubman):
     """Execute a TPM2_SelfTest (continued) command.
-- 
2.43.0

