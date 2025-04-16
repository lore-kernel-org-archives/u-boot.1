Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2749AC369C7
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 22:41:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4649E82F8C;
	Thu, 17 Apr 2025 00:40:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="CbvA8Ble";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C959382F8C; Thu, 17 Apr 2025 00:40:50 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C97B82F75
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 00:40:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-106-153.46.114.pool.telefonica.de
 [46.114.106.153])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 9D1934006B; 
 Wed, 16 Apr 2025 22:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1744843245;
 bh=r3sOb3qCJ+03DACJghiqRvAaZpy7aRy8txvFfLMd2Qo=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=CbvA8BleO5KOYwq3Sxv3NPF3M7oEEqkACTBKzq+4h8Ozi0nyCNvUojUWLmsqifTHs
 djp2nCRNvb4IYB9MbZydu5P0GqypCgicV6luVpTcjnFQ8eZEH3Kb2J/z4UXO1eL/fD
 uU5QON41gY2FXmpUJYS2RfWG4aAb5QE8xJOyvGpp1nIUYTDrTgFTaqWVv9neE1QiKm
 9NA5aFlqGXA7tKYwKWlGZXQgyEF5nfhFP4texmtd1qeufsjrw0Gi75E/k/6WeXfvU/
 5KgNod6kZARodHgPRkkJQx2L54CJ193P6s5Mp/E/Tw7ExKvwcUd+UnL1LtfmDHqc/t
 ErR6pn7RLyI+w==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 3/3] buildman: unit test for configuration fragments
Date: Thu, 17 Apr 2025 00:40:32 +0200
Message-ID: <20250416224032.144791-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250416224032.144791-1-heinrich.schuchardt@canonical.com>
References: <20250416224032.144791-1-heinrich.schuchardt@canonical.com>
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

Check that configuration fragments provided to buildman as comma
separated list are passed on to the make command of the builder.

In the %_defconfig: target of scripts/kconfig/Makefile the defconfig
file and the fragments are combined via the gcc preprocessor.
Modeling this step in the buildman testbench without invoking the actual
Makefile would not provide better test coverage.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	new patch
---
 tools/buildman/func_test.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/buildman/func_test.py b/tools/buildman/func_test.py
index b45eb95a1e6..95b51af0249 100644
--- a/tools/buildman/func_test.py
+++ b/tools/buildman/func_test.py
@@ -798,6 +798,21 @@ Some images are invalid'''
         lines = self.check_command('-L')[0]
         self.assertIn(b'NO_LTO=1', lines[0])
 
+    def testFragments(self):
+        """Test passing of configuration fragments to the make command"""
+        # Single fragment passed as argument
+        extra_args = ['board0', '--fragments', 'f1.config']
+        lines, cfg_data = self.check_command(*extra_args)
+        self.assertRegex(lines[0].decode('utf-8'),
+                         r'make O=/.*board0_defconfig\s+f1\.config',
+                         'Test single fragment')
+        # Multiple fragments passed as comma separated list
+        extra_args = ['board0', '--fragments', 'f1.config,f2.config']
+        lines, cfg_data = self.check_command(*extra_args)
+        self.assertRegex(lines[0].decode('utf-8'),
+                         r'make O=/.*board0_defconfig\s+f1\.config\s+f2\.config',
+                         'Test multiple fragments')
+
     def testReproducible(self):
         """Test that the -r flag works"""
         lines, cfg_data = self.check_command('-r')
-- 
2.48.1

