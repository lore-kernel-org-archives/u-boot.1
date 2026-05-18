Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD54CD4F3C
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 05:59:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E752839D9;
	Mon, 18 May 2026 07:58:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="OBBOWlAo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 707238466F; Mon, 18 May 2026 07:58:00 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 929B384683
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 07:57:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-046-114-109-175.46.114.pool.telefonica.de
 [46.114.109.175])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 8053041799; 
 Mon, 18 May 2026 05:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779083878;
 bh=xEWQS2T7OkzeUKBXKc2GcKYGi1ur+BDSuuyyEdvwzjw=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=OBBOWlAo1R3Q/xHOHF59c6mcHSdesPg9uE9WvCU/+nRZSENoqif1txGBPTkdgFFjm
 W+tBOiigogPxzGYNROiEtQG+lDy02XFzgAGZ5UAhinlQi7YOQ6pnk6GeuMvvyrRU9X
 Xanvu244fFvPMuMMTE9fZAhaCCyNoEO5043GzONFM9AZxqu9l0olGAm3Oeze5IIdx/
 iXt+J5NfxQkoIaO+TyrORElsZWHOfsxn1ixtnzxz4YUoujhZKXSohhLF0XyCFNG2os
 Zu/K96yDSxGwMEv0gFpInkBJEqrQPQsYF9l8pPVrMGB83jiDjXXltfmHQzSilYRVMv
 SS6XM8MslUYHWYZMdOq+WYe/uWYjYyuE/7XQihkxgUrh+M9GoGjR84p6qNn6fBpbd1
 KPQF0J9p05T8zlof/vtTfoX+9YEhQG3uATSQki+h+eZ5uGTxq8+lXUbvBvMR58aDbF
 vydDajlrFEfy/ksKsg/ALeNrMILrWC7pUrZchocek5IgJKzcP6RsVq1ur1fh3m5fDO
 xzmNiYGNZH05PT55BfptNOetE3hmbLxAq3ZjmaiR2Nk4pPhAlvns5j9hqsckecAuOU
 oM9LtFsV0phXjl9YEPCkVSmHD54u3RJroVfRd0caqOtZFGDLE3Kzn05R3b13ErqsCm
 sxBq04cf+WXcVx7imNnqcoUQ=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Huang Jianan <jnhuang95@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tony Dinh <mibodhi@gmail.com>,
 =?UTF-8?q?Timo=20tp=20Prei=C3=9Fl?= <t.preissl@proton.me>,
 Francois Berder <fberder@outlook.fr>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Daniel Palmer <daniel@thingy.jp>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.denx.de, linux-erofs@lists.ozlabs.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 9/9] test: test_erofs: adjust expected ls output
Date: Mon, 18 May 2026 07:57:28 +0200
Message-ID: <20260518055728.178507-10-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518055728.178507-1-heinrich.schuchardt@canonical.com>
References: <20260518055728.178507-1-heinrich.schuchardt@canonical.com>
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

With the addition of the date field the space between columns in the ls
output has been reduced. Reflect this in the expected lines of the erofs
test.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/py/tests/test_fs/test_erofs.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/test/py/tests/test_fs/test_erofs.py b/test/py/tests/test_fs/test_erofs.py
index a2bb6b505f2..0531f99cd9c 100644
--- a/test/py/tests/test_fs/test_erofs.py
+++ b/test/py/tests/test_fs/test_erofs.py
@@ -73,8 +73,8 @@ def erofs_ls_at_root(ubman):
     slash = ubman.run_command('erofsls host 0 /')
     assert no_slash == slash
 
-    expected_lines = ['./', '../', '4096   f4096', '7812   f7812', 'subdir/',
-                      '<SYM>   symdir', '<SYM>   symfile', '4 file(s), 3 dir(s)']
+    expected_lines = ['./', '../', '4096 f4096', '7812 f7812', 'subdir/',
+                      '<SYM> symdir', '<SYM> symfile', '4 file(s), 3 dir(s)']
 
     output = ubman.run_command('erofsls host 0')
     for line in expected_lines:
@@ -84,7 +84,7 @@ def erofs_ls_at_subdir(ubman):
     """
     Test if the path resolution works.
     """
-    expected_lines = ['./', '../', '100   subdir-file', '1 file(s), 2 dir(s)']
+    expected_lines = ['./', '../', '100 subdir-file', '1 file(s), 2 dir(s)']
     output = ubman.run_command('erofsls host 0 subdir')
     for line in expected_lines:
         assert line in output
@@ -97,7 +97,7 @@ def erofs_ls_at_symlink(ubman):
     output_subdir = ubman.run_command('erofsls host 0 subdir')
     assert output == output_subdir
 
-    expected_lines = ['./', '../', '100   subdir-file', '1 file(s), 2 dir(s)']
+    expected_lines = ['./', '../', '100 subdir-file', '1 file(s), 2 dir(s)']
     for line in expected_lines:
         assert line in output
 
-- 
2.53.0

