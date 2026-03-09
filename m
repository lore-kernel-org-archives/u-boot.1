Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD2FF4180E
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 16:37:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB3E983F59;
	Mon,  9 Mar 2026 17:37:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9548E83952; Mon,  9 Mar 2026 17:37:02 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 86FB383F86
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 17:36:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE79F1570;
 Mon,  9 Mar 2026 09:36:52 -0700 (PDT)
Received: from debian (X72Y076X74-2.nice.arm.com [10.34.125.13])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0CF153F7BD;
 Mon,  9 Mar 2026 09:36:57 -0700 (PDT)
From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v2 4/4] test/py: add ECPT tests
Date: Mon,  9 Mar 2026 17:36:38 +0100
Message-ID: <20260309163638.2340548-4-vincent.stehle@arm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260305161349.2317130-1-vincent.stehle@arm.com>
References: <20260305161349.2317130-1-vincent.stehle@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add a couple of EFI Conformance Profiles Table (ECPT) tests, which exercise
the "efidebug ecpt" command.

Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

Changes in v2:
- Adapt to follow error message changes

 test/py/tests/test_efi_ecpt.py | 42 ++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 test/py/tests/test_efi_ecpt.py

diff --git a/test/py/tests/test_efi_ecpt.py b/test/py/tests/test_efi_ecpt.py
new file mode 100644
index 00000000000..632a6b90bad
--- /dev/null
+++ b/test/py/tests/test_efi_ecpt.py
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+""" Unit test for the EFI Conformance Profiles Table (ECPT)
+"""
+
+import pytest
+
+
+@pytest.mark.buildconfigspec('cmd_efidebug')
+@pytest.mark.buildconfigspec('efi_ecpt')
+def test_efi_ecpt(ubman) -> None:
+    """ Unit test for the ECPT
+    This test assumes nothing about the ECPT contents, it just checks that the
+    ECPT table is there and that the efidebug ecpt command does not fail.
+
+    Args:
+        ubman -- U-Boot console
+    """
+    response = ubman.run_command('efidebug tables')
+    assert ('36122546-f7e7-4c8f-bd9b-eb8525b50c0b  '
+            'EFI Conformance Profiles Table') in response
+
+    response = ubman.run_command('efidebug ecpt')
+    assert 'Unknown command' not in response
+    assert 'Configure UEFI environment' not in response
+    assert 'Usage:' not in response
+    assert 'table missing' not in response
+
+
+@pytest.mark.buildconfigspec('cmd_efidebug')
+@pytest.mark.buildconfigspec('efi_ecpt')
+@pytest.mark.buildconfigspec('efi_ebbr_2_1_conformance')
+def test_efi_ecpt_ebbr_2_1(ubman) -> None:
+    """ Unit test for the ECPT, with EBBR 2.1 profile
+    This test uses the efidebug ecpt command to dump the ECPT and check that
+    the EBBR 2.1 conformance profile is there.
+
+    Args:
+        ubman -- U-Boot console
+    """
+    response = ubman.run_command('efidebug ecpt')
+    assert ('cce33c35-74ac-4087-bce7-8b29b02eeb27  '
+            'EFI EBBR 2.1 Conformance Profile') in response
-- 
2.53.0

