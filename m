Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562BDCD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 13:10:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36E6D8466E;
	Mon,  8 Jun 2026 15:09:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.b="LdxqbLdg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EE718493F; Mon,  8 Jun 2026 15:09:38 +0200 (CEST)
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18849848E2
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 15:09:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 202606081309344b6a2787bf00020741 for <u-boot@lists.denx.de>;
 Mon, 08 Jun 2026 15:09:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=wgmfjhuCc20qyqxcy0z0svQGt+iJ6cbPADt2QlLJkag=;
 b=LdxqbLdgu0kWNtnipW6Pkxa7pLzu1S2AezFwBm2dC4Br7+d7T3yXzul21vGjJLA+kos/Dj
 RBAFNVztTbgFdzWrNcl6dbRu5X8tu9KkqxmCyiuQaJVNsbx2iuFhTy4IGk05xRT0+CTG/hBd
 5Z/Widjlxb+7JJgvAWIkv+wgP6s1spiMF5q2B2Zei0p8aqiqW2JvI7rHK9PJfgBdF13soBKc
 XaApYZrWMG/VaTsfFFVKMcXoRJqITnTorBYFFWtDdvZgRojadL7C8hMpvdMguCQYXjAeMTyh
 hlGINxvgQDB+9TjRYzhzYKxYEs6OeC9xqmPU2dM95dJPvj+K9PvOxjBQ==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.denx.de
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 7/7] test: vboot: add iminfo checks
Date: Mon,  8 Jun 2026 15:08:53 +0200
Message-ID: <20260608130924.112831-4-ludwig.nussel@siemens.com>
In-Reply-To: <20260608130924.112831-1-ludwig.nussel@siemens.com>
References: <20260608130924.112831-1-ludwig.nussel@siemens.com>
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

When testing bootm also test iminfo at the same time
Introduces a new assert_fit() function that runs bootm and iminfo tests.
In some cases bootm and iminfo behave slightly differnt so call iminfo
separatey in those cases.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
---

Changes in v6:
- remove superfluous blank line

Changes in v5:
- use helper function shared with bootm
- introduce assert_fit()

Changes in v4:
- test iminfo in test_vboot

 test/py/tests/test_vboot.py | 66 ++++++++++++++++++++++++++++---------
 1 file changed, 50 insertions(+), 16 deletions(-)

diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
index df5db157a52..3e02f0dfdac 100644
--- a/test/py/tests/test_vboot.py
+++ b/test/py/tests/test_vboot.py
@@ -208,6 +208,34 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
             else:
                 assert 'sandbox: continuing, as we cannot run' not in output
 
+    def run_iminfo(sha_algo, test_type, expect_string, succeeds, fit=None):
+        """Run 'iminfo' in U-Boot.
+
+        This always starts a fresh U-Boot instance since the device tree may
+        contain a new public key.
+
+        Args:
+            test_type: A string identifying the test type.
+            expect_string: A string which is expected in the output.
+            sha_algo: Either 'sha1' or 'sha256', to select the algorithm to
+                    use.
+            succeeds: A boolean that is True if iminfo should succeed and
+                    False if failure is expected.
+            fit: FIT filename to load and verify
+        """
+
+        with ubman.log.section(f'iminfo {sha_algo} {test_type}: looking for "{expect_string}"'):
+            output = run_fit_commands(['iminfo 100'], expect_string, fit)
+
+            if succeeds:
+                assert 'FAIL' not in output
+            else:
+                assert 'FAIL' in output
+
+    def assert_fit(sha_algo, test_type, expect_string, boots, fit=None):
+        run_bootm(sha_algo, test_type, expect_string, boots, fit)
+        run_iminfo(sha_algo, test_type, expect_string, boots, fit)
+
     def sign_fit(sha_algo, options):
         """Sign the FIT
 
@@ -338,11 +366,11 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
             # Build the FIT, but don't sign anything yet
             ubman.log.action('%s: Test FIT with signed images' % sha_algo)
             make_fit('sign-images-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
-            run_bootm(sha_algo, 'unsigned images', ' - OK' if algo_arg else 'dev-', True)
+            assert_fit(sha_algo, 'unsigned images', ' - OK' if algo_arg else 'dev-', True)
 
             # Sign images with our dev keys
             sign_fit(sha_algo, sign_options)
-            run_bootm(sha_algo, 'signed images', 'dev+', True)
+            assert_fit(sha_algo, 'signed images', 'dev+', True)
 
             # Create a fresh .dtb without the public keys
             dtc('sandbox-u-boot.dts', ubman, dtc_args, datadir, tmpdir, dtb)
@@ -352,16 +380,16 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         if require_config_sigs:
             # DTB has no /signature node; FIT_REQUIRE_CONFIG_SIGS makes this
             # fail-closed, so U-Boot must reject the unsigned config FIT.
-            run_bootm(sha_algo, 'unsigned config',
+            assert_fit(sha_algo, 'unsigned config',
                       'No signature node found', False)
         else:
             # No required keys in the DTB, so an unsigned config FIT is fine.
-            run_bootm(sha_algo, 'unsigned config',
+            assert_fit(sha_algo, 'unsigned config',
                       '%s+ OK' % ('sha256' if algo_arg else sha_algo), True)
 
         ubman.log.action('%s: Test FIT with signed configuration' % sha_algo)
         sign_fit(sha_algo, sign_options)
-        run_bootm(sha_algo, 'signed config', 'dev+', True)
+        assert_fit(sha_algo, 'signed config', 'dev+', True)
 
         # Test a signed FIT config when the DTB has no keys at all.
         # Without FIT_REQUIRE_CONFIG_SIGS the absence of keys in the DTB means
@@ -371,10 +399,10 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         ubman.log.action('%s: Test signed FIT with no keys in DTB' % sha_algo)
         dtc('sandbox-u-boot.dts', ubman, dtc_args, datadir, tmpdir, dtb)
         if require_config_sigs:
-            run_bootm(sha_algo, 'signed config, no DTB keys',
+            assert_fit(sha_algo, 'signed config, no DTB keys',
                       'No signature node found', False)
         else:
-            run_bootm(sha_algo, 'signed config, no DTB keys',
+            assert_fit(sha_algo, 'signed config, no DTB keys',
                       '%s+ OK' % ('sha256' if algo_arg else sha_algo), True)
         # Restore keys in the DTB for the checks that follow.
         sign_fit(sha_algo, sign_options)
@@ -397,7 +425,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
                 ubman, [fit_check_sign, '-f', ffit, '-k', dtb],
                 1, 'Failed to verify required signature')
 
-            run_bootm(sha_algo, 'forged config', 'Bad Data Hash', False, ffit)
+            assert_fit(sha_algo, 'forged config', 'Failed to verify required signature', False, ffit)
 
             # Try adding an evil root node. This should be detected.
             efit = '%stest.evilf.fit' % tmpdir
@@ -407,8 +435,11 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
             utils.run_and_log_expect_exception(
                 ubman, [fit_check_sign, '-f', efit, '-k', dtb],
                 1, 'Failed to verify required signature')
+            # Different code path between iminfo and bootm here
             run_bootm(sha_algo, 'evil fakeroot', 'Bad FIT kernel image format',
                       False, efit)
+            run_iminfo(sha_algo, 'evil fakeroot', 'Bad FIT image format',
+                      True, efit)
 
             # Try adding an @ to the kernel node name. This should be detected.
             efit = '%stest.evilk.fit' % tmpdir
@@ -424,6 +455,9 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
             # bootm catches it earlier, at fit_check_format() time
             msg = 'Signature checking prevents use of unit addresses (@) in nodes'
             run_bootm(sha_algo, 'evil kernel@', msg, False, efit)
+            # iminfo has no special error message
+            run_iminfo(sha_algo, 'evil kernel@',
+                       "Bad FIT image format", True, efit)
 
             # Try doing a clone of the images
             efit = '%stest.evilclone.fit' % tmpdir
@@ -433,20 +467,20 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
             utils.run_and_log_expect_exception(
                 ubman, [fit_check_sign, '-f', efit, '-k', dtb],
                 1, 'Failed to verify required signature')
-            run_bootm(sha_algo, 'evil clone', 'Bad Data Hash', False, efit)
+            assert_fit(sha_algo, 'evil clone', 'Failed to verify required signature', False, efit)
 
         # Create a new properly signed fit and replace header bytes
         make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
         sign_fit(sha_algo, sign_options)
         max_size = int(bcfg.get('config_fit_signature_max_size', 0x10000000), 0)
         existing_size = replace_fit_totalsize(max_size + 1)
-        run_bootm(sha_algo, 'Signed config with bad hash', 'Bad Data Hash',
+        assert_fit(sha_algo, 'Signed config with bad hash', "Total size too large for 'conf-1' config node",
                   False)
         ubman.log.action('%s: Check overflowed FIT header totalsize' % sha_algo)
 
         # Replace with existing header bytes
         replace_fit_totalsize(existing_size)
-        run_bootm(sha_algo, 'signed config', 'dev+', True)
+        assert_fit(sha_algo, 'signed config', 'dev+', True)
         ubman.log.action('%s: Check default FIT header totalsize' % sha_algo)
 
         # Increment the first byte of the signature, which should cause failure
@@ -459,8 +493,8 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         utils.run_and_log(ubman, 'fdtput -t bx %s %s value %s' %
                           (fit, sig_node, sig))
 
-        run_bootm(sha_algo, 'Signed config with bad hash', 'Bad Data Hash',
-                  False)
+        assert_fit(sha_algo, 'corrupted signature',
+                   'Failed to verify required signature', False)
 
         ubman.log.action('%s: Check bad config on the host' % sha_algo)
         utils.run_and_log_expect_exception(
@@ -502,7 +536,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         # a dev signature only (sign_fit_norequire() overwrites the FIT).
         # Try to boot the FIT with dev key. This FIT should not be accepted by
         # U-Boot because the prod key is required.
-        run_bootm(sha_algo, 'required key', '', False)
+        assert_fit(sha_algo, 'required key', '', False)
 
         # Build the FIT with dev key (keys required) and sign it. This puts the
         # signature into sandbox-u-boot.dtb, marked 'required'.
@@ -517,7 +551,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         # U-Boot because the dev key is required and policy is "any" required key.
         utils.run_and_log(ubman, 'fdtput -t s %s /signature required-mode any' %
                           dtb)
-        run_bootm(sha_algo, 'multi required key', 'dev+', True)
+        assert_fit(sha_algo, 'multi required key', 'dev+', True)
 
         # Set the required-mode policy to "all".
         # So now sandbox-u-boot.dtb two signatures, for the prod and dev keys.
@@ -527,7 +561,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         # U-Boot because the prod key is required and policy is "all" required key
         utils.run_and_log(ubman, 'fdtput -t s %s /signature required-mode all' %
                           dtb)
-        run_bootm(sha_algo, 'multi required key', '', False)
+        assert_fit(sha_algo, 'multi required key', '', False)
 
     def test_global_sign(sha_algo, padding, sign_options):
         """Test global image signature with the given hash algorithm and padding.
-- 
2.43.0

