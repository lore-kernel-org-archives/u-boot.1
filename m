Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8675C0032E
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 21:53:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D50A86F46;
	Fri, 20 Oct 2023 23:53:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JV0RT7Sl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 171A587536; Fri, 20 Oct 2023 23:53:10 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66E8C87520
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 23:53:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5a7af20c488so14324167b3.1
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 14:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697838785; x=1698443585; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5FrPKO6Db4LbK3bbpd3rCrl9RSq79g6/T8qs+vVcrVA=;
 b=JV0RT7SlZDcvYzGv8AdLEPqxP+o3U2F7FMgqonEosildU7mNtBnjhOFiZ4XZeZPMz9
 qAxxEUpi18hGkdZoJd6p9/kJP5HCuOuGPjBButmeeQoltLf7IcVpBt7vSoijOpYODoF0
 K59CE7x7TeBjMSbOdx6MJLDOw3om3XMe7qGPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697838785; x=1698443585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5FrPKO6Db4LbK3bbpd3rCrl9RSq79g6/T8qs+vVcrVA=;
 b=YOFZCyF1Kbh2OjpjIiLOF4AXh21cnJdoObzGHf2eVcmAnnb9mzKt+sLjvP1s67J/Ky
 MG+V8rWlt9eKkcDX4Ghh758XgHu/yInJfI+BBd1btWlSrt32PdqWK3k4oAkjhaWuQRAC
 iqUe1DlgMZXwdYJO8eLjfj3JBFgwrchkrz3rr2MTN8i85E35e096pRreOwskvLxpl9Ug
 YpoY/5gHxq8lF/crqCJsbGimADx8C4vjC88a0jQwb8sBvusOH1o1yG9HhwwFUPCzGTRP
 Wc09B4jGfKvn5dpdDx7RUi9ptJ8smujBkEgms5cuMYmF8oIOVoeS+e77GLXkMlFu27RN
 C9SA==
X-Gm-Message-State: AOJu0Yx6tZXSe6dc9S1ELTx8dlvPTyeziJoReynb2buXfmrYw2QTgdHq
 +e8OfNCywyo9jpvZO8QhxkEmfIBtvNgF4lGReAggFw==
X-Google-Smtp-Source: AGHT+IFyYsvd94KHyq2Ya5bFb68CxEf9MIK8oyYsMyRZrBDendRONYlso50mcu0mOKLq/txf7PDmiQ==
X-Received: by 2002:a05:690c:f88:b0:5a8:2007:b5e4 with SMTP id
 df8-20020a05690c0f8800b005a82007b5e4mr3822256ywb.36.1697838784813; 
 Fri, 20 Oct 2023 14:53:04 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 x63-20020a81a042000000b00583803487ccsm996111ywg.122.2023.10.20.14.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 14:53:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [v4.1 2/2] CI, pytest: Add a test for sandbox without LTO
Date: Fri, 20 Oct 2023 17:53:02 -0400
Message-Id: <20231020215302.3511807-2-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020215302.3511807-1-trini@konsulko.com>
References: <20231019150105.714407-24-trini@konsulko.com>
 <20231020215302.3511807-1-trini@konsulko.com>
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

The primary motivation for having a sandbox without LTO build in CI is
to ensure that we don't have that option break. We now have the ability
to run tests of specific options being enabled/disabled, so drop the
parts of CI that build and test that configuration specifically and add
a build test instead. We still test that "NO_LTO=1" rather than editing
the config file works via the ftrace tests.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
This creates a small bisectability gap in CI itself, but I think is more
reasonable than reworking the introduction of
test/py/tests/test_sandbox_opts.py

Cc: Simon Glass <sjg@chromium.org>
---
 .azure-pipelines.yml               |  3 ---
 .gitlab-ci.yml                     | 12 ------------
 test/py/tests/test_sandbox_opts.py | 10 ++++++++++
 3 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 6f91553e8613..65533b36dde4 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -287,9 +287,6 @@ stages:
         sandbox64_clang:
           TEST_PY_BD: "sandbox64"
           OVERRIDE: "-O clang-16"
-        sandbox_nolto:
-          TEST_PY_BD: "sandbox"
-          BUILD_ENV: "NO_LTO=1"
         sandbox_spl:
           TEST_PY_BD: "sandbox_spl"
           TEST_PY_TEST_SPEC: "test_ofplatdata or test_handoff or test_spl"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 6decdfdee334..97c964fb8079 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -258,12 +258,6 @@ sandbox with clang test.py:
     OVERRIDE: "-O clang-16"
   <<: *buildman_and_testpy_dfn
 
-sandbox without LTO test.py:
-  variables:
-    TEST_PY_BD: "sandbox"
-    BUILD_ENV: "NO_LTO=1"
-  <<: *buildman_and_testpy_dfn
-
 sandbox64 test.py:
   variables:
     TEST_PY_BD: "sandbox64"
@@ -275,12 +269,6 @@ sandbox64 with clang test.py:
     OVERRIDE: "-O clang-16"
   <<: *buildman_and_testpy_dfn
 
-sandbox64 without LTO test.py:
-  variables:
-    TEST_PY_BD: "sandbox64"
-    BUILD_ENV: "NO_LTO=1"
-  <<: *buildman_and_testpy_dfn
-
 sandbox_spl test.py:
   variables:
     TEST_PY_BD: "sandbox_spl"
diff --git a/test/py/tests/test_sandbox_opts.py b/test/py/tests/test_sandbox_opts.py
index 91790b3374b4..422b43cb3bc1 100644
--- a/test/py/tests/test_sandbox_opts.py
+++ b/test/py/tests/test_sandbox_opts.py
@@ -18,3 +18,13 @@ def test_sandbox_cmdline(u_boot_console):
     out = util.run_and_log(
         cons, ['./tools/buildman/buildman', '-m', '--board', 'sandbox',
                '-a', '~CMDLINE', '-o', TMPDIR])
+
+@pytest.mark.slow
+@pytest.mark.boardspec('sandbox')
+def test_sandbox_lto(u_boot_console):
+    """Test building sandbox without CONFIG_LTO"""
+    cons = u_boot_console
+
+    out = util.run_and_log(
+        cons, ['./tools/buildman/buildman', '-m', '--board', 'sandbox',
+               '-a', '~LTO', '-o', TMPDIR])
-- 
2.34.1

