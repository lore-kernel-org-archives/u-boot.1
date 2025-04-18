Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF7FC369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 04:32:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08F37830A0;
	Fri, 18 Apr 2025 06:31:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Z7WRvz9q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A24AA83125; Fri, 18 Apr 2025 06:31:54 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B118D82F33
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 06:31:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-106-148.46.114.pool.telefonica.de
 [46.114.106.148])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id C4FA63FFD7; 
 Fri, 18 Apr 2025 04:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1744950709;
 bh=GrFUbVt2luDiQIGWAL3fVOAmQMeB8KVh+PYJlNdZlg0=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Z7WRvz9qjmuO/JJ3lFvgTOKvhmWmOIYKGedDTAGt5M3eSAP8BUANVf2rxLi+9lGGs
 hR8Cm7KTXZJNevW57uTIMeKaNMpLEVYRnJg8von5aHrIQA2ud7CBUJT2qukVCj5KWP
 +zUffqrFwIXUMNhHLLF1G3jVS757VmkytkExYwm6x6KBH68mZzmRo4bcLC6toHTZB5
 8JnPxx5Sfx3ESuP4aI5S/laI/HIDZlp8RlPIleYOFdIBFgCvw7vysS4qWKfkX7HKOe
 Mb2HYhmyKmW3Gi9u+/N5vuFEJksAiEmGAXB/lvzzEy3SRfNcBpf8TqQ+h9kC6PnT+M
 y/OLi/6uAsPlw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v4 2/3] buildman: unit test for configuration fragments
Date: Fri, 18 Apr 2025 06:31:36 +0200
Message-ID: <20250418043137.537340-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250418043137.537340-1-heinrich.schuchardt@canonical.com>
References: <20250418043137.537340-1-heinrich.schuchardt@canonical.com>
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

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
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

