Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB2AC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 14:44:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 961B884AA8;
	Thu,  2 Jul 2026 16:44:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="L/am4ILv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 312B484A91; Thu,  2 Jul 2026 16:44:49 +0200 (CEST)
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B3FA84AA8
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 16:44:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 13130B0054C;
 Thu,  2 Jul 2026 16:44:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783003483;
 bh=rBKmMKwUSULB78Z/1XtF3YJwhICAqWECASAtacVVzBY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=L/am4ILvXadVD0mtaPbUGXLG9vyMfn90TMtl0frKc4SeS/i7I3yqvNHb9vLabDPZH
 DNWtGvzdb1xyOu6ze4jdU2qmS+DFtKf8nOO5xckCUq3hqsLFwuib29t6FzjF0de2NI
 bgRqJXAfGRjxREvrbF/ol5DPCMq7VkpnASHRm3GhQYsPE7fjGGIlIqWe62rYtMQPyk
 c+mM4X2//wKkJ19Z6o4MscdejvtzDYdxz5xIOp1+T1L+CIebJvSzwpKBuuYb4WRQlK
 aSxQvt6ufVi4o3VKkHyF7DTdbeDLrfy62yiS87IS55/hA6vshpEJ2bNdHcTyT+QbuH
 LmCLETWdLbeBg==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: Vincent Jardin <vjardin@free.fr>, Simon Glass <sjg@chromium.org>,
 Sean Anderson <sean.anderson@linux.dev>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 3/3] test: py: load: check null_dev_desc_ok dispatch
Date: Thu,  2 Jul 2026 16:42:14 +0200
Message-ID: <20260702144359.1583239-4-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702144359.1583239-1-vjardin@free.fr>
References: <"<20260601131311.1163914-1-vjardin@free.fr>">
 <20260702144359.1583239-1-vjardin@free.fr>
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

(no changes since v1)

 test/py/tests/test_load_sandbox.py            | 51 +++++++++++++++++++
 .../test_semihosting/test_load_semihosting.py | 38 ++++++++++++++
 2 files changed, 89 insertions(+)
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

