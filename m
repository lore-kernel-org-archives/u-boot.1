Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B44ACFD2F6
	for <u-boot@archiver.kernel.org>; Sun, 23 Nov 2025 22:58:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADF7A83BF4;
	Sun, 23 Nov 2025 23:58:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="XgPESfA2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB54883C02; Sun, 23 Nov 2025 23:58:00 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05A1883BF1
 for <u-boot@lists.denx.de>; Sun, 23 Nov 2025 23:57:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id CF5A3402DA; 
 Sun, 23 Nov 2025 22:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763938673;
 bh=zXIrRwEWw1IjJOzxJm++YSS9ULdkA8oM5LJPnCXXpYE=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=XgPESfA2u56seh6rgQwRorFCwlH7GMGO5spJxsMlGtMy47t45mJFbfU3Xbze+e5iK
 m5WW9awSeL2eSmHhhjrptysSEECXpy4LvyW6BUdm2W4NDwbSc8OY9gYEB0S/Bd/YbJ
 yqw/Hrbh5ZnfnBF8x8odzXfAvQbfTpI7ofK/2vZ8I2C7T7991MF4yZMu0X7milNHuh
 D22rnY64unbzuCMWNTbGq4GY7NbI8sEVssZt6b4llcLvv4K02wI2sfEA7axhpIhaD/
 T6uNbh9XyYFcHkjaUo5pmOX4sqpB1B59l/VcFhbVcYvaL8pNOnb9MqTzMmJruvOIia
 yYkhyWyGr5lG4yBHpMETmeBcF1jHMVBXZYpDZ81RZtoeacZrDnrbCJBIuc5t/PqRHU
 i2SzlUfN2kq4r5JWbzQUpRK+etcMEX/lCmw3BU28JGg0+vcIhJUsSvuiJ8kjgULPU0
 0nRb7L2nqnTKAhfjI/REHzfABS7kys/OXo/vRHGUcdTlxTb+4uWDXeoMaWvlzLLFqV
 Dzog+POQX2QWXbV4Z4ROrvUu6tK5Ucg+KXwk3tYI8Em4jc2mjRbIvi3zDJWpX2NX5z
 Z59ey2n8Q0mR8dHq/iiOrEUsfz6HMY7692PdYsJyVzqrOWRTKI8th7t1nMHaYdIQSx
 DGMJKuCh8T6QczybHvmG32iM=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Paul Burton <paulburton@kernel.org>,
 Alexander Graf <agraf@csgraf.de>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Heiko Schocher <hs@nabladev.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Richard Weinberger <richard@nod.at>,
 Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [RESEND][PATCH 01/19] test: Let pytest indicate skipped C unit tests
Date: Sun, 23 Nov 2025 23:56:53 +0100
Message-ID: <20251123225711.227016-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251123225711.227016-1-heinrich.schuchardt@canonical.com>
References: <20251123225711.227016-1-heinrich.schuchardt@canonical.com>
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

From: Heinrich Schuchardt <xypron.glpk@gmx.de>

We invoke the ut command in test_ut.py. Currently we only check for
failures. Instead we should also indicate if sub-tests were skipped.

With this change we will get output like the following for skipped tests:

test/py/tests/test_ut.py ..sssss......ss..............s.sssss.s.s...
================================ short test summary info ================================
SKIPPED [1] test/py/tests/test_ut.py:597: Test addrmap addrmap_test_basic has 1 skipped sub-test(s).
SKIPPED [1] test/py/tests/test_ut.py:597: Test bdinfo bdinfo_test_eth has 4 skipped sub-test(s).

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 test/py/tests/test_ut.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index cdf54adc600..6d535b5206d 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -11,6 +11,7 @@ import collections
 import gzip
 import os
 import os.path
+import re
 import pytest
 
 import utils
@@ -589,3 +590,9 @@ def test_ut(ubman, ut_subtest):
     else:
         output = ubman.run_command('ut ' + ut_subtest)
     assert output.endswith('failures: 0')
+    lastline = output.splitlines()[-1]
+    if "skipped: 0," not in lastline:
+        match = re.search(r'skipped:\s*(\d+),', lastline)
+        if match:
+            count = match.group(1)
+            pytest.skip(f'Test {ut_subtest} has {count} skipped sub-test(s).')
-- 
2.51.0

