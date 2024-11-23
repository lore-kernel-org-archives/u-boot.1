Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32202E66889
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 21:47:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DA8B893EE;
	Sat, 23 Nov 2024 22:46:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="SJ8d5MJP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64F0B893EE; Sat, 23 Nov 2024 22:46:46 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 677E789160
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 22:46:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id B2DD641005; 
 Sat, 23 Nov 2024 21:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732398400;
 bh=gt3v8pZeChvpJfNiBHbI23J7TKx7WoXlXHmAd1AXCf8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=SJ8d5MJPq1FWEzSUrky+QQllBDQmUDhM/VPqATQ130qhE9IepxhviBDqrBkzwCEuF
 K1rxp7rwl2EPOoJNptQ8vq9BMupe0BVmD4889GGGKU/zau8qw90awK1WmMCh5fGZZ2
 svnoluQcEIIwj25cTRwIn4y40Vu8xNB4TRkI3BBXfDiE4JXnrQzg6okr1pg5boYjEN
 m7uyWMJ+CzDEXmj30LMOo2ZpH6QShQGkmGo5usSZDxsQSyi++Velek3K8We6Y59aiM
 FwtVLZVnApSbjbyR+EqamrKR0r4ocHEZRF09vdzIlJM5LgfGciNsZE3iSRuzTgFk8W
 LXKcbFp5N1XEw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 T Karthik Reddy <t.karthik.reddy@xilinx.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/6] test: fix test_extension.py
Date: Sat, 23 Nov 2024 22:45:49 +0100
Message-ID: <20241123214554.305285-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241123214554.305285-1-heinrich.schuchardt@canonical.com>
References: <20241123214554.305285-1-heinrich.schuchardt@canonical.com>
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

test_extension.py assumes that no extension is known at test start.
This assumption is wrong because we do not come out of reboot.
A prior test may have already hunted for the extension bootdev.

Remove the invalid assert.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	new patch
---
 test/py/tests/test_extension.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/test/py/tests/test_extension.py b/test/py/tests/test_extension.py
index 267cf2ff27c..2a3c5116171 100644
--- a/test/py/tests/test_extension.py
+++ b/test/py/tests/test_extension.py
@@ -26,7 +26,9 @@ def test_extension(u_boot_console):
     load_dtb(u_boot_console)
 
     output = u_boot_console.run_command('extension list')
-    assert('No extension' in output)
+    # extension_bootdev_hunt may have already run.
+    # Without reboot we cannot make any assumption here.
+    # assert('No extension' in output)
 
     output = u_boot_console.run_command('extension scan')
     assert output == 'Found 2 extension board(s).'
-- 
2.45.2

