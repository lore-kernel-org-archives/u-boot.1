Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A920C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 18:54:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F25C87686;
	Sat,  9 Dec 2023 19:54:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="uEwQbGuV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E20C876A2; Sat,  9 Dec 2023 19:54:21 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E6C987686
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 19:54:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 5026A4347E; 
 Sat,  9 Dec 2023 18:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702148054;
 bh=gYpkeX34NGSvZYsvwECKuyxo9gy4XmZxcV8YO+y1bj8=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=uEwQbGuVq3x8Vjv1k97RI7TooGdHgY3jl/Y80NjtYiB3uV13E/9pcPzDNUvVoSjwz
 sd4AV1z3xT7EMezlYKF3sXkicYtogFf1u4ICMLL3w1lfyfSeAjrY0vodnyQQ8BK8zm
 Rd9Jkw3nh3jTfZooYsvdZxjjiWJFRQSfyDj03+14HJ4+WrGZ2ON0OimD6nttriZm4l
 jHsKrSYp9w/XrFGQu19z8Jx4cQ8BUBOmlj4WdUnz9lV56V/MdyKjtHfzHImDcrSjR2
 mVc6jKtWW0YN5oiZXPyiaA6mMEzBOQSZgu0iHgFBdEfnUKe2fdXWjpBGNSxpSF30Gh
 hVmSpYNiOThOw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Roman Kopytin <Roman.Kopytin@kaspersky.com>,
 Ivan Mikhaylov <fr0st61te@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/2] test: fit: Using variable 'old_dtb' before assignment
Date: Sat,  9 Dec 2023 19:54:10 +0100
Message-Id: <20231209185411.8212-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231209185411.8212-1-heinrich.schuchardt@canonical.com>
References: <20231209185411.8212-1-heinrich.schuchardt@canonical.com>
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

old_dtb can only be assumed initialized in the finally block
if it is assigned a value before the try statement.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/py/tests/test_fit.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/test/py/tests/test_fit.py b/test/py/tests/test_fit.py
index f45848484e..04f64fd4bc 100755
--- a/test/py/tests/test_fit.py
+++ b/test/py/tests/test_fit.py
@@ -390,10 +390,10 @@ def test_fit(u_boot_console):
 
 
     cons = u_boot_console
+    # We need to use our own device tree file. Remember to restore it
+    # afterwards.
+    old_dtb = cons.config.dtb
     try:
-        # We need to use our own device tree file. Remember to restore it
-        # afterwards.
-        old_dtb = cons.config.dtb
         mkimage = cons.config.build_dir + '/tools/mkimage'
         run_fit_test(mkimage)
     finally:
-- 
2.40.1

