Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216C2CFD30D
	for <u-boot@archiver.kernel.org>; Sat, 22 Nov 2025 23:49:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6473083B7E;
	Sun, 23 Nov 2025 00:49:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="aDH35kp/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B1CA83B7F; Sun, 23 Nov 2025 00:49:32 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7985F83B72
 for <u-boot@lists.denx.de>; Sun, 23 Nov 2025 00:49:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1763855370; x=1764460170; i=xypron.glpk@gmx.de;
 bh=pt/dQBw0mGHImiufv38EqjtTxwEKO0i70Xi0OZgV2gk=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=aDH35kp/IMXhZ3gDeLpxZs5yx0h8TC4ZBA6/EDxlIRqgmTfuZ2cv7GY4vjByYNbc
 T/CVil+cBB/mhw1D5sFM0bviAHZtkCejNKfJZcNXX54oZkw8+FUvlchKJJ7Q0XCdj
 W72Vud/Qg9uDEMWoD4CzhstUviXmQb3HyPZeUpRl0ycKB1/e2mgLqFygc7Tiz184P
 tnayvBZzW3hsB19nE5+iw5iu8HCyVb7OpMzINQCjeMtchX9St501SBbEwWIYQAbLx
 zp10SPHw6M2oX2dIrAZquTnhUggD4U10T80v4epV593iKoTowas+iErEto1+kiSZY
 5YMhxbtY6/gtBfIK6Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from LT03.fritz.box ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbzyJ-1vzJ7035hf-00b0fp; Sun, 23
 Nov 2025 00:49:29 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Richard Weinberger <richard@nod.at>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] test: Let pytest indicate skipped C unit tests
Date: Sun, 23 Nov 2025 00:49:20 +0100
Message-ID: <20251122234920.80114-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:owJWCXhIUq2PPnR6EnQQo/lI7rfHqrP3jsdmCmNPRrcj9Bi2i7O
 TooA9U3+ZYGu7+MC9AFJd3kbKpfLl9Be9o6PCn6CbUb4d9bvkEr0tgCJPuVFccVcY0ylgSC
 WJ/M/kSf36N6uiYoG5xbTBKjQFIFfjC7KP9mm5E0gvLVYa+3Vq7cAOucUpmIahIq0MWWWpw
 /9EDeZc3LbehP6YbVk76A==
UI-OutboundReport: notjunk:1;M01:P0:I9aB7laaqjU=;gE+F3urUSO11XTLpxX6a6k+0gui
 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
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

We invoke the ut command in test_ut.py. Currently we only check for
failures. Instead we should also indicate if sub-tests were skipped.

With this change we will get output like the following for skipped tests:

test/py/tests/test_ut.py ..sssss......ss..............s.sssss.s.s...
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D short test summary info =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
SKIPPED [1] test/py/tests/test_ut.py:597: Test addrmap addrmap_test_basic =
has 1 skipped sub-test(s).
SKIPPED [1] test/py/tests/test_ut.py:597: Test bdinfo bdinfo_test_eth has =
4 skipped sub-test(s).

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 test/py/tests/test_ut.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index cdf54adc600..0cd4a8b6c7c 100644
=2D-- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -11,6 +11,7 @@ import collections
 import gzip
 import os
 import os.path
+import re
 import pytest
=20
 import utils
@@ -589,3 +590,9 @@ def test_ut(ubman, ut_subtest):
     else:
         output =3D ubman.run_command('ut ' + ut_subtest)
     assert output.endswith('failures: 0')
+    lastline =3D output.splitlines()[-1]
+    if "skipped: 0," not in lastline:
+        match =3D re.search(r'skipped:\s*(\d+),', lastline)
+        if match:
+            count =3D match.group(1)
+            pytest.skip(f'Test {ut_subtest} has {count} skipped sub-test(=
s).')
=2D-=20
2.51.0

