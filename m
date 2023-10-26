Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 505FAC25B6B
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 18:37:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47EF887BE6;
	Thu, 26 Oct 2023 20:32:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IXHu2IBr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7FD787641; Thu, 26 Oct 2023 20:32:08 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A85787B60
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 20:32:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6ce2c5b2154so765985a34.3
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 11:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698345125; x=1698949925; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NYS+kbUkDRH9Gtx75/ceADeXRIqUT+dwEW0hZKMBFPM=;
 b=IXHu2IBrBFKxUc9w4aeAyuHpFASr6dVbexqyRVogDORoJx6+fNHtBGEVTpjGI73HLj
 IVMob+IAfQ2jaQGCewqjhbfDk78nmGtxYRgtvWr8oA4pYY8roHDhiRpninRcsmbfkpSF
 2jjcUWFHwGAMS63ZrIsjQkS14+qNFsoQsuYRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698345125; x=1698949925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NYS+kbUkDRH9Gtx75/ceADeXRIqUT+dwEW0hZKMBFPM=;
 b=aJ2q2tSRYPYT964UZLgzgZP6pdGDWtdfeQ2c9vNeEHmQmkM7DuW1U67watlWLadusP
 QPBjGUgbKR5BQ8bfscmHYcU1NnLu2Ib36uwXwtRvd7uCSgGHSntRXytTu7ff64Mdcg8i
 dLOcwSpXskg2jDQw7vwHUeDSypFpOdHorAVkHjn4kKWFNwd29efpteTLfCzIRtfcuW6/
 9kUD4tspoVGdW769OsmYWIcGE3tgRFMPdJlbAVHa1cnHceb3Q2BWoAu3++aE6/IzAm6/
 mij7F26uEAX71HYsjVdRjEoruI01Dq8p1Y37zcPjzUVjP2VextQzI7x7WNZHiBp3glKj
 dnaw==
X-Gm-Message-State: AOJu0Yz/38hHy4htz0z9sWwZ9rHK0bRfR6vmcBtpiwdJNYbNj5ZZK7ZO
 87FGSVHYar2Zw2ytgx10kvWpo1vod7TWaZ9PIfCnkQ==
X-Google-Smtp-Source: AGHT+IEFkQ7ri8+Cy0QqbxoVLAlE8kWK3rZZVJNkeFr9hMOTFkzlata2ZihpnZuH5tQxPMCDLrm+eg==
X-Received: by 2002:a9d:7c8b:0:b0:6be:fdab:dc65 with SMTP id
 q11-20020a9d7c8b000000b006befdabdc65mr302771otn.19.1698345124845; 
 Thu, 26 Oct 2023 11:32:04 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-6a0e-a72f-3fdd-31b7.res6.spectrum.com.
 [2603:6081:7b00:6400:6a0e:a72f:3fdd:31b7])
 by smtp.gmail.com with ESMTPSA id
 az39-20020a05620a172700b00777611164c5sm5175623qkb.106.2023.10.26.11.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 11:32:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [v5 30/30] CI, pytest: Add a test for sandbox without LTO
Date: Thu, 26 Oct 2023 14:31:38 -0400
Message-Id: <20231026183138.636948-30-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026183138.636948-1-trini@konsulko.com>
References: <20231026183138.636948-1-trini@konsulko.com>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes in v5:
- Drop now incorrect worry about bisectability
---
 .azure-pipelines.yml               |  3 ---
 .gitlab-ci.yml                     | 12 ------------
 test/py/tests/test_sandbox_opts.py | 10 ++++++++++
 3 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index eb9353fc3dcf..ec498a832d73 100644
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
index 1e11b5a6fea8..f328f3331f6d 100644
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

