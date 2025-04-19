Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D113C369BD
	for <u-boot@archiver.kernel.org>; Sat, 19 Apr 2025 10:24:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D92682B33;
	Sat, 19 Apr 2025 12:24:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="eiHWeXAT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FE8182A31; Sat, 19 Apr 2025 12:24:43 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EA2682A96
 for <u-boot@lists.denx.de>; Sat, 19 Apr 2025 12:24:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-106-045.46.114.pool.telefonica.de
 [46.114.106.45])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 7B2EF40443; 
 Sat, 19 Apr 2025 10:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1745058257;
 bh=h/K26hTeXV04NM+KiFJNY+KF3VcJTOdaejDs9qVJrHQ=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=eiHWeXAT7RYVhHxfb19XQ9DXLz4g4HnFDlYhUlUktoKG+8c6jKum7UjE9L8CHp4Ik
 JddGejHYY0U+rEjq7peCFH6cbF/fEFSRev7lzMj5BPEX12c6Gn5k91BIgWFZOLNnCF
 ODorwALVSUCYPjkV5BniZKaQyqG29mXyAww2U5xjM9cZl5WcZ+LL1uml2SXOr8JawS
 Q24mOV/GXVAvQDuHZo+RhfYTtrwC3vHZdjxQ62vYLhk+++jf0OMyKTCD4YHYzaCC21
 1jzbWygtLfjbs1XxvmtD0lVigOEFcEKH89BGlg+paI7X9HERK2rXDWKTi1xwyli8j3
 dAFi28l4QQE1Q==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Brandon Maier <brandon.maier@collins.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v5 2/3] buildman: unit test for configuration fragments
Date: Sat, 19 Apr 2025 12:23:57 +0200
Message-ID: <20250419102358.13127-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250419102358.13127-1-heinrich.schuchardt@canonical.com>
References: <20250419102358.13127-1-heinrich.schuchardt@canonical.com>
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

Check that configuration fragments provided to buildman as comma-
separated list are passed on to the make command of the builder.

In the %_defconfig: target of scripts/kconfig/Makefile the defconfig
file and the fragments are combined via the gcc preprocessor.
Modeling this step in the buildman testbench without invoking the actual
Makefile would not provide better test coverage.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v5:
	Fix typo comma-separated
v4:
	no change
v3:
	no change
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
+        # Multiple fragments passed as comma-separated list
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

