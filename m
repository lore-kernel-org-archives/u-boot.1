Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C350CC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 00:45:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6F038701C;
	Sun, 12 Nov 2023 01:44:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WI6ml7MZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6D4E86FB0; Sun, 12 Nov 2023 01:44:11 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2420086FB6
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 01:43:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7a94c5538aeso124505839f.3
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 16:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699749831; x=1700354631; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Dh2t4v1OVeoDdqq+gDuaFoU7q8T3eNgWxabnLR74NA=;
 b=WI6ml7MZcjIT1a6ODvXt6/rMtTMhD85SeULKGqXOSNQxypG2IHejEsVoxZKVwoZw1O
 YcLawa5cu9errki1yOiO2gGaZv0mfaVjVvXTSMI4TH7tZVdlvKI6NtDkwjj2/9LJgkub
 XTTn+RMegpzYfchuM8TIvyw35oMvzNZl+phUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699749831; x=1700354631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Dh2t4v1OVeoDdqq+gDuaFoU7q8T3eNgWxabnLR74NA=;
 b=XruTS4o26WeX/UJ+oq0yVymmtRfFdOLnmYLCoZTdKOrY4OWoY2oOmwtJSTtMRF3Lr6
 iBYGxTP20Y7DTsmgeMCwuWevPph20LWBUMKPFNKArk9MGwrW6xGJRh6rr7/YiVtlY3zY
 eyMn3fDLlu1su+xpzIDzA7sx7+Y0pbdX6oPFRREFsxAtGeL+nMhyFt0IkI4etm4EWkrX
 l+wzwoYsU62Drg26slVeJLjv/STRTR/8i4Vn/PtlqINxT0oOBaHDqnkefWIaxumVu3OE
 RRa0k1S+2igxoem/BW+TYc2AZetm6+/XdnlzRQ9UOcTMZA7vpwHD1jhzv7rygCbPUO4L
 vipg==
X-Gm-Message-State: AOJu0YwhS6qm0x5el4r7Udm9hRPHIjpImdt0ZvxhuFLmCTcOrEqXKsDh
 gx7DpMaGNgOp7PYlbkOJ9cRU7ciaGhgpKnAqkWMYjw==
X-Google-Smtp-Source: AGHT+IHwaXKG077DPa6bgPHzeDNmBytGqaH1RiVVp4vWTNNHikHYHS31/il6HDkBdzzb84QkSx9hew==
X-Received: by 2002:a5d:8b44:0:b0:792:6963:df3b with SMTP id
 c4-20020a5d8b44000000b007926963df3bmr3607113iot.14.1699749831369; 
 Sat, 11 Nov 2023 16:43:51 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 k39-20020a056638372700b00457a6f281ddsm711388jav.59.2023.11.11.16.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 16:43:51 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH v2 3/3] tpm: Drop unwanted special cases for sandbox
Date: Sat, 11 Nov 2023 17:43:38 -0700
Message-ID: <20231111174337.v2.3.I3c84965a4b5e3019562b86a47b34ae4b12469070@changeid>
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
index 8ed337eddc10..47370dad9f60 100644
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
@@ -50,11 +60,6 @@ def force_init(u_boot_console, force=False):
             u_boot_console.run_command('tpm2 clear TPM2_RH_PLATFORM')
         u_boot_console.run_command('echo --- end of init ---')
 
-def is_sandbox(cons):
-    # Array slice removes leading/trailing quotes.
-    sys_arch = cons.config.buildconfig.get('config_sys_arch', '"sandbox"')[1:-1]
-    return sys_arch == 'sandbox'
-
 @pytest.mark.buildconfigspec('cmd_tpm_v2')
 def test_tpm2_autostart(u_boot_console):
     """Init the software stack to use TPMv2 commands."""
@@ -65,20 +70,6 @@ def test_tpm2_autostart(u_boot_console):
     output = u_boot_console.run_command('echo $?')
     assert output.endswith('0')
 
-def tpm2_sandbox_init(u_boot_console):
-    """Put sandbox back into a known state so we can run a test
-
-    This allows all tests to run in parallel, since no test depends on another.
-    """
-    u_boot_console.restart_uboot()
-    u_boot_console.run_command('tpm2 autostart')
-    output = u_boot_console.run_command('echo $?')
-    assert output.endswith('0')
-
-    skip_test = u_boot_console.config.env.get('env__tpm_device_test_skip', False)
-    if skip_test:
-        pytest.skip('skip TPM device test')
-
 @pytest.mark.buildconfigspec('cmd_tpm_v2')
 def test_tpm2_continue_self_test(u_boot_console):
     """Execute a TPM2_SelfTest (continued) command.
@@ -90,8 +81,6 @@ def test_tpm2_continue_self_test(u_boot_console):
     skip_test = u_boot_console.config.env.get('env__tpm_device_test_skip', False)
     if skip_test:
         pytest.skip('skip TPM device test')
-    if is_sandbox(u_boot_console):
-        tpm2_sandbox_init(u_boot_console)
     u_boot_console.run_command('tpm2 self_test continue')
     output = u_boot_console.run_command('echo $?')
     assert output.endswith('0')
@@ -108,9 +97,6 @@ def test_tpm2_clear(u_boot_console):
     not have a password set, otherwise this test will fail. ENDORSEMENT and
     PLATFORM hierarchies are also available.
     """
-    if is_sandbox(u_boot_console):
-        tpm2_sandbox_init(u_boot_console)
-
     skip_test = u_boot_console.config.env.get('env__tpm_device_test_skip', False)
     if skip_test:
         pytest.skip('skip TPM device test')
@@ -131,8 +117,6 @@ def test_tpm2_change_auth(u_boot_console):
     Use the LOCKOUT hierarchy for this. ENDORSEMENT and PLATFORM hierarchies are
     also available.
     """
-    if is_sandbox(u_boot_console):
-        tpm2_sandbox_init(u_boot_console)
     force_init(u_boot_console)
 
     u_boot_console.run_command('tpm2 change_auth TPM2_RH_LOCKOUT unicorn')
@@ -157,9 +141,6 @@ def test_tpm2_get_capability(u_boot_console):
     There is no expected default values because it would depend on the chip
     used. We can still save them in order to check they have changed later.
     """
-    if is_sandbox(u_boot_console):
-        tpm2_sandbox_init(u_boot_console)
-
     force_init(u_boot_console)
     ram = u_boot_utils.find_ram_base(u_boot_console)
 
@@ -181,8 +162,6 @@ def test_tpm2_dam_parameters(u_boot_console):
     the authentication, otherwise the lockout will be engaged after the first
     failed authentication attempt.
     """
-    if is_sandbox(u_boot_console):
-        tpm2_sandbox_init(u_boot_console)
     force_init(u_boot_console)
     ram = u_boot_utils.find_ram_base(u_boot_console)
 
@@ -205,9 +184,6 @@ def test_tpm2_pcr_read(u_boot_console):
 
     Perform a PCR read of the 10th PCR. Must be zero.
     """
-    if is_sandbox(u_boot_console):
-        tpm2_sandbox_init(u_boot_console)
-
     force_init(u_boot_console)
     ram = u_boot_utils.find_ram_base(u_boot_console)
 
@@ -234,8 +210,6 @@ def test_tpm2_pcr_extend(u_boot_console):
     No authentication mechanism is used here, not protecting against packet
     replay, yet.
     """
-    if is_sandbox(u_boot_console):
-        tpm2_sandbox_init(u_boot_console)
     force_init(u_boot_console)
     ram = u_boot_utils.find_ram_base(u_boot_console)
 
-- 
2.42.0.869.gea05f2083d-goog

