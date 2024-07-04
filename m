Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39C3C3065C
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 07:42:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C36CF88936;
	Thu,  4 Jul 2024 09:38:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F744888CC; Thu,  4 Jul 2024 09:38:04 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 3665F8889D
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 09:38:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B788B367;
 Thu,  4 Jul 2024 00:38:26 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 955FA3F762;
 Thu,  4 Jul 2024 00:37:58 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH v2 32/48] test: lmb: invoke the LMB unit tests from a
 separate script
Date: Thu,  4 Jul 2024 13:05:28 +0530
Message-Id: <20240704073544.670249-33-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240704073544.670249-1-sughosh.ganu@linaro.org>
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
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

With the LMB tests moved under a separate class of unit tests, invoke
these from a separate script which would allow for a system reset once
the tests have been run. This enables clearing up the LMB memory map
after having run the tests.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V1: New patch

 test/py/tests/test_lmb.py | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 test/py/tests/test_lmb.py

diff --git a/test/py/tests/test_lmb.py b/test/py/tests/test_lmb.py
new file mode 100644
index 0000000000..b6f9ff9c6a
--- /dev/null
+++ b/test/py/tests/test_lmb.py
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright 2024 Linaro Ltd
+#
+# Run the LMB tests
+
+import pytest
+
+base_script = '''
+ut lmb -f
+'''
+
+@pytest.mark.boardspec('sandbox')
+def test_lmb(u_boot_console):
+    cons = u_boot_console
+    cmd = base_script
+
+    with cons.log.section('LMB Unit Test'):
+        output = cons.run_command_list(cmd.splitlines())
+
+    assert 'Failures: 0' in output[-1]
+
+    # Restart so that the LMB memory map starts with
+    # a clean slate for the next set of tests.
+    u_boot_console.restart_uboot()
-- 
2.34.1

