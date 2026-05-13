Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B84B0CD4F21
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 14:11:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBB8A84690;
	Wed, 13 May 2026 16:10:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.b="f85P1KRW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19EF980F0E; Wed, 13 May 2026 16:10:49 +0200 (CEST)
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12A728468A
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 16:10:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 2026051314104613a39e44e200020768 for <u-boot@lists.denx.de>;
 Wed, 13 May 2026 16:10:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=rI4nZQJMKQREwe4Q/pHXiujko9IRgodIRoanek5Grvs=;
 b=f85P1KRWzPQIAi8qn7e8UYrmg/kXModv+kFSLHKYnvs7jqCx+Ol+25TbOkrgKw0eY+y/0F
 FrQIKenHrOdwy+rNLrXIMahJEdus9KE7u205h1sa14xxG1DweLNSpwre13JMZQYPxnzyQRu9
 Y67lZlu4Zy3NC/0qX9bCEp/l21ARxXGOWQnQSYKxTBFuc2hkJYJDXTrfHyeGvkjo9uB7Gnw7
 Fqnhu5+uCuo6MOqyiWDYPJBrrocDBi3syOqDY0WFXXvEVwI+64EKbGxQu4j/Mu8HycCh2NPl
 JYY5krW+ufmCqE9T09h4Yck7ajEKxPBGrd5JBrT1lUx/9WYBl/lqWFRQ==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.denx.de
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>,
 Copilot <223556219+Copilot@users.noreply.github.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 6/6] test: vboot: add iminfo checks for config signature
 verification
Date: Wed, 13 May 2026 16:08:16 +0200
Message-ID: <20260513141027.351280-3-ludwig.nussel@siemens.com>
In-Reply-To: <20260513141027.351280-1-ludwig.nussel@siemens.com>
References: <20260513141027.351280-1-ludwig.nussel@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328817:519-21489:flowmailer
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

Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>

Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
---

Changes in v4:
- test iminfo in test_vboot

 test/py/tests/test_vboot.py | 47 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
index f7156943c24..8a298a31fdb 100644
--- a/test/py/tests/test_vboot.py
+++ b/test/py/tests/test_vboot.py
@@ -231,6 +231,34 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         ubman.log.action('%s: Sign images' % sha_algo)
         utils.run_and_log(ubman, args)
 
+    def run_iminfo(sha_algo, test_type, expect_string, succeeds, fit=None):
+        """Run an 'iminfo' command in U-Boot.
+
+        This always starts a fresh U-Boot instance since the device tree may
+        contain a new public key.
+
+        Args:
+            sha_algo: Either 'sha1' or 'sha256', to select the algorithm to
+                    use.
+            test_type: A string identifying the test type.
+            expect_string: A string which is expected in the output.
+            succeeds: A boolean that is True if iminfo should succeed and
+                    False if failure is expected.
+            fit: FIT filename to load and verify
+        """
+        if not fit:
+            fit = '%stest.fit' % tmpdir
+        ubman.restart_uboot()
+        with ubman.log.section('iminfo %s %s' % (sha_algo, test_type)):
+            output = ubman.run_command_list(
+                ['host load hostfs - 100 %s' % fit,
+                 'iminfo 100'])
+        assert expect_string in ''.join(output)
+        if succeeds:
+            assert 'FAIL' not in ''.join(output)
+        else:
+            assert 'FAIL' in ''.join(output)
+
     def replace_fit_totalsize(size):
         """Replace FIT header's totalsize with something greater.
 
@@ -326,9 +354,11 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
         if require_config_sigs:
             # DTB has no /signature node; FIT_REQUIRE_CONFIG_SIGS makes this
-            # fail-closed, so U-Boot must reject the unsigned config FIT.
+            # fail-closed, so both bootm and iminfo must reject the unsigned FIT.
             run_bootm(sha_algo, 'unsigned config',
                       'No signature node found', False)
+            run_iminfo(sha_algo, 'unsigned config', 'No signature node found',
+                       False)
         else:
             # No required keys in the DTB, so an unsigned config FIT is fine.
             run_bootm(sha_algo, 'unsigned config',
@@ -348,6 +378,8 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         if require_config_sigs:
             run_bootm(sha_algo, 'signed config, no DTB keys',
                       'No signature node found', False)
+            run_iminfo(sha_algo, 'signed config, no DTB keys',
+                       'No signature node found', False)
         else:
             run_bootm(sha_algo, 'signed config, no DTB keys',
                       '%s+ OK' % ('sha256' if algo_arg else sha_algo), True)
@@ -425,6 +457,10 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         run_bootm(sha_algo, 'signed config', 'dev+', True)
         ubman.log.action('%s: Check default FIT header totalsize' % sha_algo)
 
+        # Test that iminfo also verifies configuration signatures
+        run_iminfo(sha_algo, 'signed config',
+                   'Checking configuration signatures', True)
+
         # Increment the first byte of the signature, which should cause failure
         sig = utils.run_and_log(ubman, 'fdtget -t bx %s %s value' %
                                 (fit, sig_node))
@@ -438,6 +474,15 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         run_bootm(sha_algo, 'Signed config with bad hash', 'Bad Data Hash',
                   False)
 
+        # Test that iminfo also detects the corrupted signature.
+        # Skip for external-data FIT (-E): fdtput rewrites only the FDT
+        # portion of the file, truncating the appended image data, so
+        # fit_all_image_verify() would fail on a missing-data hash error
+        # before fit_all_configurations_verify() is ever reached.
+        if '-E' not in (sign_options or ''):
+            run_iminfo(sha_algo, 'corrupted config',
+                       'Checking configuration signatures', False)
+
         ubman.log.action('%s: Check bad config on the host' % sha_algo)
         utils.run_and_log_expect_exception(
             ubman, [fit_check_sign, '-f', fit, '-k', dtb],
-- 
2.43.0

