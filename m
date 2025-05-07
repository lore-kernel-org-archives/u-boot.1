Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CED6C3ABBF
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 23:25:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B493828B3;
	Thu,  8 May 2025 01:25:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ro6uJf0j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BE598212F; Thu,  8 May 2025 01:25:11 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDE8682162
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 01:25:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-401e77e5443so269693b6e.3
 for <u-boot@lists.denx.de>; Wed, 07 May 2025 16:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746660307; x=1747265107; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f9nn393zvj3BWl953rmYJl7u2lJSRhlLSLHbkuy46YQ=;
 b=Ro6uJf0jelQfZE1I6JeiPXR4c8ok3hrvY2YXLSoKuGqvEeFZSN8aAjp7wbJAwJNFZ2
 e0eBcyaOk+nHl+em0dR3BtxfiU24fxkGKf5cVdFHEkoD/8zzqNmQf44WPfpmymZFeTrm
 fLwWOLlcYyNJcXpaFX0Cbmj/YhsGEF+hANEyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746660307; x=1747265107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f9nn393zvj3BWl953rmYJl7u2lJSRhlLSLHbkuy46YQ=;
 b=IEegGhQJJK0/JX0ObUbt3597T06PW3QQ8bxfN+zkNqPlAzYAZgcZbevWx/cXLGLPDl
 L+l29fTBwWLiJf6FxstLLHJeZSXeFnflvuCGSvpBw8C5kxFs43NpIditp3iTUU8yikUm
 f81zPiengh/0ZODam5HDWUlIPW5iOXg2y9pev65d3kchYOrONB83ZS7fJOJM4RlvAKKY
 5zgeuZF9nEjBdMD0qX6EpooTM1vIRiVD01vV+H7wKTkhapAJsB7HMVAp9lsU02XIBj8T
 h1pbJ37M/rGYy76kZYrxh2sFh3K9rGqA++/cb/MdW0NsRmJfwF6MfBqCQXL+OXkW4gwd
 E6tQ==
X-Gm-Message-State: AOJu0Yx1X3QikzUKjRNsMlUXgL5MVfa7AHDgZuPts627UPFaowEG+0Y3
 qJn3tVCJCAP5lvgCIcld930oZ+hq2433fZfYdrqTn3iBjUvJY8VDemAzQPV6Mfh5h8SCBPpHFVw
 C
X-Gm-Gg: ASbGncvOnbT6jCYq/9Gp+mDWHQaKGY7g6KPkOD4AiSA0UI08zSkLI1EESfXuflViCh4
 Mz3zskaBCK6yzsslJR2tbq1oKpXnVGA6LLTGKsTJcDEnGZA1RJC2zki9yPp0smq7Ifk5Vmd8mqg
 aqnND9w3fhNnz7bjU9Lyzt5HbjtkD84iNSDzZcdNYaCNkodd+MjlUWaM6pcwIULpY2vn5lF5OUT
 aaBDrbJXt7YvJoIs55F0Q15RxKqOPzeW317zdauknmIYvBvKTkmeDO6QSIX7NNbIMtQjrZLT7KM
 cHG9pKFRHCoFMk2B6qrGv5CDO57+UA8v3LOgYVyOY49dYkYkXdRVg2FysU44KN05uia8jvo/3Co
 fZlGN
X-Google-Smtp-Source: AGHT+IHaH2o+ZdPOT6lGUGNv+0zhGWfJ6vnOfioORHLC5GSDg1Ydib9zBcPiF5Vk2QxBAEIixBXplQ==
X-Received: by 2002:a05:6808:200b:b0:3fe:b0ad:f935 with SMTP id
 5614622812f47-40377ec0827mr743616b6e.4.1746660307586; 
 Wed, 07 May 2025 16:25:07 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4036f3af356sm831979b6e.46.2025.05.07.16.25.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:25:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/3] doc: pytest: Document the test_bootstage test
Date: Wed,  7 May 2025 17:23:01 -0600
Message-ID: <20250507232500.527782-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507232500.527782-1-trini@konsulko.com>
References: <20250507221112.518041-1-trini@konsulko.com>
 <20250507232500.527782-1-trini@konsulko.com>
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

Add this test to the documentation. We need to move the import to follow
the main comment so that it renders correctly, and add a code-block
annotation to the example and indent it correctly. Next, neither of the
functions had comments themselves, so document them now.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>
---
 doc/develop/pytest/index.rst          |  1 +
 doc/develop/pytest/test_bootstage.rst |  8 ++++++
 test/py/tests/test_bootstage.py       | 35 +++++++++++++++++++++------
 3 files changed, 37 insertions(+), 7 deletions(-)
 create mode 100644 doc/develop/pytest/test_bootstage.rst

diff --git a/doc/develop/pytest/index.rst b/doc/develop/pytest/index.rst
index e2131a2f4a68..5bcda1f0952c 100644
--- a/doc/develop/pytest/index.rst
+++ b/doc/develop/pytest/index.rst
@@ -18,5 +18,6 @@ Individual tests
    :maxdepth: 1
 
    test_000_version
+   test_bootstage
    test_net
    test_net_boot
diff --git a/doc/develop/pytest/test_bootstage.rst b/doc/develop/pytest/test_bootstage.rst
new file mode 100644
index 000000000000..f8f10e96a42c
--- /dev/null
+++ b/doc/develop/pytest/test_bootstage.rst
@@ -0,0 +1,8 @@
+test_bootstage
+==============
+
+.. automodule:: test_bootstage
+   :synopsis:
+   :member-order: bysource
+   :members:
+   :undoc-members:
diff --git a/test/py/tests/test_bootstage.py b/test/py/tests/test_bootstage.py
index 379c1cae6dd5..2505862c5a4d 100644
--- a/test/py/tests/test_bootstage.py
+++ b/test/py/tests/test_bootstage.py
@@ -1,8 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 # (C) Copyright 2023, Advanced Micro Devices, Inc.
 
-import pytest
-
 """
 Test the bootstage command.
 
@@ -15,16 +13,32 @@ common/bootstage.c). Without this, bootstage stash and unstash tests will be
 automatically skipped.
 
 For example:
-env__bootstage_cmd_file = {
-    'addr': 0x200000,
-    'size': 0x1000,
-    'bootstage_magic_addr': 0xb00757a3,
-}
+
+.. code-block:: python
+
+    env__bootstage_cmd_file = {
+        'addr': 0x200000,
+        'size': 0x1000,
+        'bootstage_magic_addr': 0xb00757a3,
+    }
 """
 
+import pytest
+
 @pytest.mark.buildconfigspec('bootstage')
 @pytest.mark.buildconfigspec('cmd_bootstage')
 def test_bootstage_report(ubman):
+    """Test the bootstage report subcommand
+
+    This will run the 'bootstage report' subcommand and ensure that we are
+    reporting:
+
+    - A timer summary in microseconds
+    - The accumulated time
+    - That at least the phrase 'dm_r' is in the output
+
+    Note that the time values are not checked.
+    """
     output = ubman.run_command('bootstage report')
     assert 'Timer summary in microseconds' in output
     assert 'Accumulated time:' in output
@@ -34,6 +48,13 @@ def test_bootstage_report(ubman):
 @pytest.mark.buildconfigspec('cmd_bootstage')
 @pytest.mark.buildconfigspec('bootstage_stash')
 def test_bootstage_stash_and_unstash(ubman):
+    """Test the bootstage stash and unstash subcommands
+
+    After checking that we have configured an environment file to use, we will
+    use the stash subcommand to save information. Then we will use the md
+    command to verify the contents in memory. Finally we confirm the unstash
+    subcommand runs successfully.
+    """
     f = ubman.config.env.get('env__bootstage_cmd_file', None)
     if not f:
         pytest.skip('No bootstage environment file is defined')
-- 
2.43.0

