Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F30C4167D
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 04:29:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 801C487C94;
	Sun, 29 Oct 2023 05:28:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SoN9CHy8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF5AA87C89; Sun, 29 Oct 2023 05:28:41 +0100 (CET)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FF7187C62
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 05:28:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-1dd1714b9b6so2362541fac.0
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 21:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698553715; x=1699158515; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eirhkn3dxc8ehWJT0y72JAi0m+cz1aHWv/pOIG990PE=;
 b=SoN9CHy8A/bCpXzwc02jn95HQOJapu7oZQUzTDXphIZ//fRBIhgRZal58B8mM79LFB
 nZ8VMQXchg5MMeqISFNe1ldJgd8U6gKP9RWQ3BfNp1c59sygaM8jtsC3K+cfYQRC1tBG
 ATzyjIfKFYRhcpxtbMdhJDOIFRJTm1sgAEUow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698553715; x=1699158515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Eirhkn3dxc8ehWJT0y72JAi0m+cz1aHWv/pOIG990PE=;
 b=GBs9TTjC2xTbKEfRn9rYg2Fee+XF9UA7Hg9XJGI77xC7jnhMWkAUjOkKuOUo4sz9i9
 tTqNhlz7spVesYGOV9R4MbzBKzi52HCJ5POiDLFugsof78J0qpm6+Gh9xQHaWH3tc3pU
 45wl5ANU18P2OvJSDgNfC4VnUw/MqVmjHkD0wbXLnGnlfIFjclxwUoB+6rjNZkmsEEVO
 fqRGSxyoZ11/jw249aBy74Q7+Qg2O1PSuaX2upUwhpN0UpfWghwBlFcQj+6erFqoIhtT
 r2VMx5zA7Dj0IF3bU8+6ST/Gt8XXS9CBzx8mIG4PrBwo8G8+aXZpqZeUhPhorMmsmuCv
 xq2Q==
X-Gm-Message-State: AOJu0YzVJSEXNnikm8AZNWUnO9b70A5PMOBGy6KSRCDvNXkCd4U031hs
 pa8r/F8vjyZMfItlCdw5y2woAkR6ri8Fzw4dF35wIA==
X-Google-Smtp-Source: AGHT+IEpbDk2nf0ya+nb6/nYQImNFLuJ7h6CEOeO3uRcmD/6Flqa3kzHc8zfuN2YiryR9p2na7PKFA==
X-Received: by 2002:a05:6871:4807:b0:1e9:feb7:71db with SMTP id
 qc7-20020a056871480700b001e9feb771dbmr9758036oab.36.1698553715621; 
 Sat, 28 Oct 2023 21:28:35 -0700 (PDT)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 s194-20020a6377cb000000b0058ac101ad83sm2920564pgc.33.2023.10.28.21.28.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 21:28:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH 3/3] tpm: Drop unwanted special cases for sandbox
Date: Sun, 29 Oct 2023 17:28:14 +1300
Message-ID: <20231029172813.3.I3c84965a4b5e3019562b86a47b34ae4b12469070@changeid>
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

These don't seem to be needed.

Add a few notes about what to do next. Also mention parallel tests in
at the top of thefile.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/tests/test_tpm2.py | 44 +++++++++-----------------------------
 1 file changed, 10 insertions(+), 34 deletions(-)

diff --git a/test/py/tests/test_tpm2.py b/test/py/tests/test_tpm2.py
index 522ed41de633..e01a05143b63 100644
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
 def test_tpm2_clear(u_boot_console):
     """Execute a TPM2_Clear command.
@@ -91,9 +82,6 @@ def test_tpm2_clear(u_boot_console):
     not have a password set, otherwise this test will fail. ENDORSEMENT and
     PLATFORM hierarchies are also available.
     """
-    if is_sandbox(u_boot_console):
-        tpm2_sandbox_init(u_boot_console)
-
     skip_test = u_boot_console.config.env.get('env__tpm_device_test_skip', False)
     if skip_test:
         pytest.skip('skip TPM device test')
@@ -114,8 +102,6 @@ def test_tpm2_change_auth(u_boot_console):
     Use the LOCKOUT hierarchy for this. ENDORSEMENT and PLATFORM hierarchies are
     also available.
     """
-    if is_sandbox(u_boot_console):
-        tpm2_sandbox_init(u_boot_console)
     force_init(u_boot_console)
 
     u_boot_console.run_command('tpm2 change_auth TPM2_RH_LOCKOUT unicorn')
@@ -140,9 +126,6 @@ def test_tpm2_get_capability(u_boot_console):
     There is no expected default values because it would depend on the chip
     used. We can still save them in order to check they have changed later.
     """
-    if is_sandbox(u_boot_console):
-        tpm2_sandbox_init(u_boot_console)
-
     force_init(u_boot_console)
     ram = u_boot_utils.find_ram_base(u_boot_console)
 
@@ -164,8 +147,6 @@ def test_tpm2_dam_parameters(u_boot_console):
     the authentication, otherwise the lockout will be engaged after the first
     failed authentication attempt.
     """
-    if is_sandbox(u_boot_console):
-        tpm2_sandbox_init(u_boot_console)
     force_init(u_boot_console)
     ram = u_boot_utils.find_ram_base(u_boot_console)
 
@@ -188,9 +169,6 @@ def test_tpm2_pcr_read(u_boot_console):
 
     Perform a PCR read of the 0th PCR. Must be zero.
     """
-    if is_sandbox(u_boot_console):
-        tpm2_sandbox_init(u_boot_console)
-
     force_init(u_boot_console)
     ram = u_boot_utils.find_ram_base(u_boot_console)
 
@@ -217,8 +195,6 @@ def test_tpm2_pcr_extend(u_boot_console):
     No authentication mechanism is used here, not protecting against packet
     replay, yet.
     """
-    if is_sandbox(u_boot_console):
-        tpm2_sandbox_init(u_boot_console)
     force_init(u_boot_console)
     ram = u_boot_utils.find_ram_base(u_boot_console)
 
-- 
2.42.0.820.g83a721a137-goog

