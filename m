Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A38C54F30
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 13:07:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3A9A83082;
	Sat, 24 May 2025 15:07:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m013sZIU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B70E883303; Sat, 24 May 2025 15:07:00 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8139383055
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 15:06:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-8644aa73dfcso20217339f.0
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 06:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748092017; x=1748696817; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G9qr8JYnD0TLXQJjavjWKU32UgBOTKIGPqxUETGV1lg=;
 b=m013sZIUGpuxGHzpeDgxbCwc/QbIo22/D88YRjytJOP5kCpKTgNuDYbxJteUfdfCJL
 FGAdGo5CRoi7Zib3+j5AoQ7lxwMiVi6x4Js4J4lSgrhlQ9zwINQMglcuGnGmRjuDTcCM
 1LGIA4R52o5EhBHOZjY/u/5Zdbgwtac/OXCxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748092017; x=1748696817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G9qr8JYnD0TLXQJjavjWKU32UgBOTKIGPqxUETGV1lg=;
 b=CVJE6AWa4Mdf6NsszwASGwWeQEgSJWbpyenBUUrud69UdJPFxAokZY9w9pg8iqoB7C
 THhxjW7c6U0VXuX1YkVc5WaSy+ajQwIsMVHAHFcMhuGaBvrimPVe0UldMT8c110wFS8w
 m3y5W5zmA5kZgW9ZojYpqA6idtge2yIL+xtCznEo3FBF/u49kFkiuGb++GNibitU5skW
 Ov99+8uxEZx5QD1AG7wKRvD2HVpdwZvt2ti/1UGd/i3muy33uOgiHPB8klPqFMwdds+y
 URwAt7pkbPIOIN5lDoi116TqCAaGuLM9VXcWjmcOxsBeVE1Za9lZttl20hyw/tOkwjkk
 AnDg==
X-Gm-Message-State: AOJu0YxrdK7kXpYf18dQ0E9L/wBlD6z0nxbLuhzXaV5GlZIcHEAN7Jy2
 1Zh29d3QMMew2B66m9dQNwAKLNT+uvdLz5bYSNdPrceuLSp9aQqmA35B3jg6+IAGsGbZ8ksbUr2
 Sw7tLvmM0
X-Gm-Gg: ASbGncsvXvcyzDvWmigBaRJQMJuhWzY2TcOypeQeYQiR1om6DBRDgsHe7JXyrwG+bGO
 62zyJly07fzvV3frXghQWOi3ixgFT8PNn9YMmllR8kPV/mCTEvjBJk03xoHMyY89d1/eyal2yLc
 itHC7XpBp+di8OakXJPU1aSAFX/gSir7VCzx3RvZTtt5YMRH2Q9dMEomE3DWD2htcOlOVu2OwZn
 jKwb03aQoY/bwEd77wwwuesP+Fbp301jhGprIz5revaBwYf/ZFb25ufCvifhmvs6myshLZmOUHS
 gUYpG0qH9b2MBVEEKCxigon2m+++lIOcygCyUn7OoeC4M3YXjRoVsuoaqFMke3+seLwwoiV5DRX
 LruVgzhWjh9c4
X-Google-Smtp-Source: AGHT+IG3GD6F35wrHa0PhHPw4N6fygCImf0XkoFBgY+j3SOHIwT1MFQ/6fd4ZIIz7Eb66EnyyNHJLw==
X-Received: by 2002:a05:6602:3689:b0:862:ba37:eb0e with SMTP id
 ca18e2360f4ac-86cbb8aa450mr393945239f.12.1748092016618; 
 Sat, 24 May 2025 06:06:56 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-86a236e898dsm373238339f.37.2025.05.24.06.06.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 06:06:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v3 3/4] tpm: Drop unwanted special cases for sandbox
Date: Sat, 24 May 2025 07:06:36 -0600
Message-ID: <20250524070636.v3.3.I3c84965a4b5e3019562b86a47b34ae4b12469070@changeid>
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

These don't seem to be needed.

Add a few notes about what to do next. Also mention parallel tests in
at the top of thefile.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v1)

 test/py/tests/test_tpm2.py | 46 +++++++++-----------------------------
 1 file changed, 10 insertions(+), 36 deletions(-)

diff --git a/test/py/tests/test_tpm2.py b/test/py/tests/test_tpm2.py
index e55adfe784c..fecce248fbd 100644
--- a/test/py/tests/test_tpm2.py
+++ b/test/py/tests/test_tpm2.py
@@ -27,6 +27,16 @@ behavior.
 * Setup env__tpm_device_test_skip to True if tests with TPM devices should be
 skipped.
 
+Parallel tests
+--------------
+
+These tests can be run in parallel on sandbox. In that case any action taken
+by one test may be independent of another. For sandbox, care should be taken to
+ensure that tests are independent.
+
+Unfortunately, tests cannot be made independent on real hardware, since there is
+no way to reset the TPM other than restarting the board. Perhaps that would be
+the best approach?
 """
 
 updates = 0
@@ -50,11 +60,6 @@ def force_init(ubman, force=False):
             ubman.run_command('tpm2 clear TPM2_RH_PLATFORM')
         ubman.run_command('echo --- end of init ---')
 
-def is_sandbox(ubman):
-    # Array slice removes leading/trailing quotes.
-    sys_arch = ubman.config.buildconfig.get('config_sys_arch', '"sandbox"')[1:-1]
-    return sys_arch == 'sandbox'
-
 @pytest.mark.buildconfigspec('cmd_tpm_v2')
 def test_tpm2_autostart(ubman):
     """Init the software stack to use TPMv2 commands."""
@@ -65,20 +70,6 @@ def test_tpm2_autostart(ubman):
     output = ubman.run_command('echo $?')
     assert output.endswith('0')
 
-def tpm2_sandbox_init(ubman):
-    """Put sandbox back into a known state so we can run a test
-
-    This allows all tests to run in parallel, since no test depends on another.
-    """
-    ubman.restart_uboot()
-    ubman.run_command('tpm2 autostart')
-    output = ubman.run_command('echo $?')
-    assert output.endswith('0')
-
-    skip_test = ubman.config.env.get('env__tpm_device_test_skip', False)
-    if skip_test:
-        pytest.skip('skip TPM device test')
-
 @pytest.mark.buildconfigspec('cmd_tpm_v2')
 def test_tpm2_continue_self_test(ubman):
     """Execute a TPM2_SelfTest (continued) command.
@@ -90,8 +81,6 @@ def test_tpm2_continue_self_test(ubman):
     skip_test = ubman.config.env.get('env__tpm_device_test_skip', False)
     if skip_test:
         pytest.skip('skip TPM device test')
-    if is_sandbox(ubman):
-        tpm2_sandbox_init(ubman)
     ubman.run_command('tpm2 self_test continue')
     output = ubman.run_command('echo $?')
     assert output.endswith('0')
@@ -108,9 +97,6 @@ def test_tpm2_clear(ubman):
     not have a password set, otherwise this test will fail. ENDORSEMENT and
     PLATFORM hierarchies are also available.
     """
-    if is_sandbox(ubman):
-        tpm2_sandbox_init(ubman)
-
     skip_test = ubman.config.env.get('env__tpm_device_test_skip', False)
     if skip_test:
         pytest.skip('skip TPM device test')
@@ -131,8 +117,6 @@ def test_tpm2_change_auth(ubman):
     Use the LOCKOUT hierarchy for this. ENDORSEMENT and PLATFORM hierarchies are
     also available.
     """
-    if is_sandbox(ubman):
-        tpm2_sandbox_init(ubman)
     force_init(ubman)
 
     ubman.run_command('tpm2 change_auth TPM2_RH_LOCKOUT unicorn')
@@ -157,9 +141,6 @@ def test_tpm2_get_capability(ubman):
     There is no expected default values because it would depend on the chip
     used. We can still save them in order to check they have changed later.
     """
-    if is_sandbox(ubman):
-        tpm2_sandbox_init(ubman)
-
     force_init(ubman)
     ram = utils.find_ram_base(ubman)
 
@@ -181,8 +162,6 @@ def test_tpm2_dam_parameters(ubman):
     the authentication, otherwise the lockout will be engaged after the first
     failed authentication attempt.
     """
-    if is_sandbox(ubman):
-        tpm2_sandbox_init(ubman)
     force_init(ubman)
     ram = utils.find_ram_base(ubman)
 
@@ -205,9 +184,6 @@ def test_tpm2_pcr_read(ubman):
 
     Perform a PCR read of the 10th PCR. Must be zero.
     """
-    if is_sandbox(ubman):
-        tpm2_sandbox_init(ubman)
-
     force_init(ubman)
     ram = utils.find_ram_base(ubman)
 
@@ -234,8 +210,6 @@ def test_tpm2_pcr_extend(ubman):
     No authentication mechanism is used here, not protecting against packet
     replay, yet.
     """
-    if is_sandbox(ubman):
-        tpm2_sandbox_init(ubman)
     force_init(ubman)
     ram = utils.find_ram_base(ubman)
 
-- 
2.43.0

