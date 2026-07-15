Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BFC8C44508
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 17:01:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67A8C84C12;
	Wed, 15 Jul 2026 19:01:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="KX0spBza";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FAAC84C11; Wed, 15 Jul 2026 19:01:06 +0200 (CEST)
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04AEE84C12
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 19:01:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id ECB9DB00573;
 Wed, 15 Jul 2026 19:00:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1784134863;
 bh=Q5xhFu/8NFi1TT/C5YC3XwoEA1/sDVl9JculJ+QP0Ho=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KX0spBzalJCsCdCsvFN5OE2WVB57nxbxCEyNzUkJJF5YqW8rOgmGbvspohQBnR+Jf
 E5Jh5Mp8eE5s+koEVU/DPoVGMj863fSRbCxwtpOqtODLMxKq0Pp3cwlk4SRN92IzWC
 jldbuIQjlj7qA0MWPYFeAbaFfkkPX4oWCCF3J+1hEB6dUmLWWP7kZc3RLz+CmAFsR/
 KCffatPDHqR0lkonWeG6h8s4whfRC52LZiVs7aRBI0gz1pJZYZOX6JbgV4DydpcMl7
 rdj5kmJaAF+h4urLqYa6oGyq431Snn/rN52IAYQjHBMnuIdejI6gi4eRDWAe8lom2h
 +rtMvpOmMX/cA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: Vincent Jardin <vjardin@free.fr>, Simon Glass <sjg@chromium.org>,
 Sean Anderson <sean.anderson@linux.dev>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 3/3] test: py: load: check null_dev_desc_ok dispatch
Date: Wed, 15 Jul 2026 18:57:17 +0200
Message-ID: <20260715165735.3207801-4-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715165735.3207801-1-vjardin@free.fr>
References: <20260715165735.3207801-1-vjardin@free.fr>
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

Some pytest modules exercising the dispatch added by
  fs: dispatch null_dev_desc_ok filesystems before lookup

test_load_semihosting.py:
  "load semihosting - <addr> <file>" and the optional
  [bytes] [pos] variant. Runs on qemu_arm64 with
  CONFIG_SEMIHOSTING=y; reuses test_hostfs.py's host-staged
  fixture.

test_load_sandbox.py:
  "load sandbox - <addr> <file>" and the optional [bytes] [pos]
  variant. Runs on sandbox (boardspec('sandbox')); the sandbox
  fstype is registered with name="sandbox" and
    null_dev_desc_ok=true,
  so the same fs_lookup_null_dev_info() helper that
  routes semihosting also routes the "sandbox".

A "load ubifs - <addr> <file>" test is intentionally not provided.
UBIFS is built on UBI on MTD, which requires some additional works
that are not available with qemu/sandbox-ing.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
Reviewed-by: Simon Glass <sjg@chromium.org>

---

Changes in v5:
- test/py/tests/test_semihosting/conftest.py: fix CI
  issue reported by Tom Rini

 test/py/tests/test_load_sandbox.py            | 51 +++++++++++++++++++
 test/py/tests/test_semihosting/conftest.py    |  4 +-
 .../test_semihosting/test_load_semihosting.py | 38 ++++++++++++++
 3 files changed, 91 insertions(+), 2 deletions(-)
 create mode 100644 test/py/tests/test_load_sandbox.py
 create mode 100644 test/py/tests/test_semihosting/test_load_semihosting.py

diff --git a/test/py/tests/test_load_sandbox.py b/test/py/tests/test_load_sandbox.py
new file mode 100644
index 00000000000..8d28a630e76
--- /dev/null
+++ b/test/py/tests/test_load_sandbox.py
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier:      GPL-2.0+
+# Copyright 2026 Free Mobile - Vincent Jardin
+
+"""Regression test for `load sandbox - <addr> <file>`.
+
+Exercises the null_dev_desc_ok dispatch added in
+"fs: dispatch null_dev_desc_ok filesystems before block lookup".
+
+It is the counterpart of test_load_semihosting.py
+"""
+
+import os
+import pytest
+
+
+@pytest.fixture(scope='session')
+def sandbox_fixture(u_boot_config):
+    """Host-staged fixture file read by `load sandbox`."""
+    path = os.path.join(u_boot_config.persistent_data_dir,
+                        'sandbox-fstype.txt')
+    with open(path, 'w', encoding='utf-8') as f:
+        f.write('Das U-Boot\n')   # 11 bytes, same as test_hostfs.py / semihosting
+    yield path
+    os.remove(path)
+
+
+@pytest.mark.boardspec('sandbox')
+def test_sandbox_load(ubman, sandbox_fixture):
+    """Run `load sandbox - <addr> <file>` and check the bytes."""
+    response = ubman.run_command(
+        f'load sandbox - $loadaddr {sandbox_fixture}')
+
+    # Fixture is "Das U-Boot\n" (11 bytes).
+    assert '11 bytes read' in response
+
+    # crc32("Das U-Boot\n") -- identical to the semihosting / hostfs checks.
+    response = ubman.run_command('crc32 $loadaddr $filesize')
+    assert '==> 60cfccfc' in response
+
+
+@pytest.mark.boardspec('sandbox')
+def test_sandbox_load_offset(ubman, sandbox_fixture):
+    """Run the [bytes] [pos] variant through the same dispatch."""
+    response = ubman.run_command(
+        f'load sandbox - $loadaddr {sandbox_fixture} 4 6')
+    # bytes=4 pos=6 over "Das U-Boot\n" -> "Boot".
+    assert '4 bytes read' in response
+
+    # crc32("Boot")
+    response = ubman.run_command('crc32 $loadaddr $filesize')
+    assert '==> e6df01fa' in response
diff --git a/test/py/tests/test_semihosting/conftest.py b/test/py/tests/test_semihosting/conftest.py
index b00d8f4ea9c..6b7f3f3c2d9 100644
--- a/test/py/tests/test_semihosting/conftest.py
+++ b/test/py/tests/test_semihosting/conftest.py
@@ -6,9 +6,9 @@
 import os
 import pytest
 
-@pytest.fixture(scope='session')
+@pytest.fixture(scope='function')
 def semihosting_data(u_boot_config):
-    """Set up a file system to be used in semihosting tests
+    """Set up a new file for each semihosting test
 
     Args:
         u_boot_config -- U-Boot configuration.
diff --git a/test/py/tests/test_semihosting/test_load_semihosting.py b/test/py/tests/test_semihosting/test_load_semihosting.py
new file mode 100644
index 00000000000..7c2eb72c69a
--- /dev/null
+++ b/test/py/tests/test_semihosting/test_load_semihosting.py
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier:      GPL-2.0+
+# Copyright 2026 Free Mobile - Vincent Jardin
+
+"""Regression test for `load semihosting - <addr> <file>`.
+
+Companion to test_hostfs.py: same fixture, same crc32, different
+fstype routing:
+see the doc/usage/cmd/load.rst "Null-block-device interfaces" section.
+"""
+
+import pytest
+
+
+@pytest.mark.buildconfigspec('semihosting')
+def test_semihosting_load(ubman, semihosting_data):
+    """Run `load semihosting - <addr> <file>` and check the bytes."""
+    response = ubman.run_command(
+        f'load semihosting - $loadaddr {semihosting_data}')
+
+    # Fixture is "Das U-Boot\n" (11 bytes).
+    assert '11 bytes read' in response
+
+    # crc32("Das U-Boot\n")
+    response = ubman.run_command('crc32 $loadaddr $filesize')
+    assert '==> 60cfccfc' in response
+
+
+@pytest.mark.buildconfigspec('semihosting')
+def test_semihosting_load_offset(ubman, semihosting_data):
+    """Run the [bytes] [pos] variant through the same dispatch."""
+    response = ubman.run_command(
+        f'load semihosting - $loadaddr {semihosting_data} 4 6')
+    # bytes=4 pos=6 over "Das U-Boot\n" -> "Boot".
+    assert '4 bytes read' in response
+
+    # crc32("Boot")
+    response = ubman.run_command('crc32 $loadaddr $filesize')
+    assert '==> e6df01fa' in response
-- 
2.43.0

