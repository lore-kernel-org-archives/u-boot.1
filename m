Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F045C982FA
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 11:51:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A93980EC6;
	Wed, 23 Sep 2026 11:51:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id doadUektrIPH; Wed, 23 Sep 2026 11:51:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 74F6980EC8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790164270;
	b=Tq1/mOyw82GHVXMwlNQR44Sxh9iuuaFntdSMZd2nUGI3Oa+c16zt5aqROfUHP681xato
	 dem+wTljphsP++nfkegGl/uFfxgDs6HDIwL0pfGSUQoSW+/ICh5dqVwfiW3bOb/mvGnRy
	 UhiBP2VsMkDsLLAG4s5WIDyPigI1xavkwwLGzpXCl+Txq90CvuGejqvl1BzaYI+ydfqiB
	 Pd/Hg+cazo/sbPBPbyp2SFOFI7itmK7hyo3FxO1CAtAsRG6KoYNmgtHE4cjnRNCN9sMS1
	 gm1jDEXpeZj6wrXr+YoOdwWc5058OkFPKS9XOAFhy+9Tbx+If6k2y23TeXdIVzIVAGw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790164270;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LJxMopRXh7ul5IEs4ibCq0H0Vj3a0rjIIZ6gI+0qngA=;
	b=cBvLjFKSvRn/pI799iq6pyBCUe2Bz9woT+xXL4iqPW9++DR1cMUI+HmuACZ04h7Z4tyg
	 ua5MMuBqapzhnxc2izJCSPXHjLBF3DKTZwJmFI22oMUmatVLb5t47i8+3COknODLDgGJD
	 UeE3Q185GyuB8zpgr15g3sWcVW6UY5RZ+LAsqk3s2jfkOwAkIKxgs3ysefbTHNBibj2PV
	 5OsXCpjb5/3ylqUtIi7aqP//evnNJ0S8npFofX9Ei+8vpXFyOEW3sKyIRSqfDJsVVdadk
	 yEvwNBRKtUW53QiMgYkTp5aaABBsThkMK7mFXmPnZpgxqc8gm+krkKtQ3cmw5WjfhdA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790164270;
	bh=LJxMopRXh7ul5IEs4ibCq0H0Vj3a0rjIIZ6gI+0qngA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CcypLoE02fCG4VAHZ3hJ+QLk74Ua8Llzf1H91v69AaB12537NkwMAn7x5ODsvm3uu
	 0CaCkTb5QcyGcrqsheFxenuWSkZXL5r/ZjRtc1p6iwE6C9VXZvqOiQ2zl2ilKB4Egr
	 BxqXRXX3hTQVkAJZkhRCd9CXgOwMCp1wGWBcdnTvjmOP3tVUxLePDpyL9p9CdZKeCL
	 dK0RJGL9kX/JIiE8d7wQOmFIpgvr/ROFBQshO+eM9kx4T2dHTmSN9ddu3PkzghyJ2c
	 Lu9wPLciZJ5RZ8HypEb20/icWEDy88aClozgec8F4khM7I2OwlQiWrdCSeS0kpaGPz
	 Z8BaF7fpHXEcA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 74F6980EC8;
	Wed, 23 Sep 2026 11:51:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id ECB9635A
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 11:51:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DDC9D406AE
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 11:51:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fGE83vSSOVki for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 11:51:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CB796406B2
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.136.65.227
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790164262;
 b=UdFW1/iRXuDggEtrOEZy3uTWdqYRE8feexTyCebEsc+VlFMppPeroPYxNRDJDUTcMT/7
 YhCflUc6c7wEJcokEx9/YfXJi6d/7zlpe7pVW4ygWDzuhg1FLOEL0a17PGFzhkJmlOoTO
 yKdlcTr911Sh1VjwRA5xb4Wr1ZuN+6rqqZzSP2hvfNDoOUdzK3NI2cyi0ZV6FgCv+Rwe0
 i1P7xDV4ABxpP5ycxVpXU5OXPf63kQE0pSaeY8zmC6uNlJ77ThGXaEAHvPrS3n7OAppfK
 5D5be2VJ9/gSWc05rkvVYrmLOjdnCMDv1LQTjxoiJbiK6UhF+jFGKeF1zYbd3z2pfeg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790164262;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=LJxMopRXh7ul5IEs4ibCq0H0Vj3a0rjIIZ6gI+0qngA=;
 b=MOCylx9TIdMU7J25asX3knmktm2aAr+WI0/hVzZyvnla/ohKZNhPVzy9qKX7OT7/YNuW
 uSefV5FzB2X8o68s2M9+IBw0x0GUDDgT2kT1O2xmBJoLY8nSqWd7irjtFq0bRRnamHZHB
 agIWUzuFhBSeoWvH68ToAD1SJVHwMPmxcvYCMxuH5LvvBBGgQZpFArL45gmrNJwstO+DK
 KSB9DuG4A/d53kqPfFrDpit0IbiBzOFrrMAEQ2Ay38CspqCU0sUJiyFwySdCWXPNit67z
 BQBE/2kPo+7z9xji52etgZtdGTNTxQRY+u6LWng6/+4NMWTW1P0iVbOGuwEAQD9bMVg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=BE9S4nXw; 
 arc=none smtp.remote-ip=185.136.65.227
X-Greylist: delayed 62 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 23 Sep 2026 11:51:00 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=BE9S4nXw
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.65.227;
 helo=mta-65-227.siemens.flowmailer.net;
 envelope-from=fm-1328817-20260923114955822df96b48000207e0-irofmy@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-65-227.siemens.flowmailer.net
 (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CB796406B2
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 11:51:00 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id
 20260923114955822df96b48000207e0
 for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 13:49:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=LJxMopRXh7ul5IEs4ibCq0H0Vj3a0rjIIZ6gI+0qngA=;
 b=BE9S4nXwEyHZQoDgou/iHMtHpccRRYSjoJ1YPWZtmzVa2T0EFta0iRQK8wfGgQtgQ6M0zw
 YirVUWpGs05WmRPoKyc7b4adlRF31sOqGxegwgBdWuHyyk8oQxikQUo6iBrzElYhTkQICrFB
 fnHzhZ6DT5pN8Nzw9ArtMPj+q1VlT+n/pA8/KZqyRRD/cZ6z44MDVXZUwyIeCL/lqS9bJlmY
 zlgsJ7n4b7L4F6a3fzLB+oSxyZ+CxJl9mRwu2uDLPI9jXfcBAcK0PKkM/fyrkpFuf2gbZarG
 LXkLCrQp1g6QwKGqZVlWyOGPjWk6iAOWO7sPBu4DjEk3LGjjaotZsEOA==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Simon Glass <sjg@chromium.org>,
 Anton Ivanov <anton@binarly.io>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v10 7/7] test: vboot: add iminfo checks
Date: Wed, 23 Sep 2026 13:49:34 +0200
Message-ID: <20260923114940.349985-4-ludwig.nussel@siemens.com>
In-Reply-To: <20260923114940.349985-1-ludwig.nussel@siemens.com>
References: <20260923114940.349985-1-ludwig.nussel@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328817:519-21489:flowmailer
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

When testing bootm also test iminfo at the same time
Introduces a new assert_fit() function that runs bootm and iminfo tests.
In some cases bootm and iminfo behave slightly differnt so call iminfo
separatey in those cases.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
---

(no changes since v6)

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
index 0ecb804832a..fd63d8b4e08 100644
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
@@ -352,11 +380,11 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
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
@@ -368,7 +396,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
                         'hashed-nodes']).split()
             assert '/images/firmware' in hashed_nodes
             assert '/images/firmware/hash-1' in hashed_nodes
-        run_bootm(sha_algo, 'signed config', 'dev+', True)
+        assert_fit(sha_algo, 'signed config', 'dev+', True)
 
         # Test a signed FIT config when the DTB has no keys at all.
         # Without FIT_REQUIRE_CONFIG_SIGS the absence of keys in the DTB means
@@ -378,10 +406,10 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
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
@@ -404,7 +432,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
                 ubman, [fit_check_sign, '-f', ffit, '-k', dtb],
                 1, 'Failed to verify required signature')
 
-            run_bootm(sha_algo, 'forged config', 'Bad Data Hash', False, ffit)
+            assert_fit(sha_algo, 'forged config', 'Failed to verify required signature', False, ffit)
 
             # Try adding an evil root node. This should be detected.
             efit = '%stest.evilf.fit' % tmpdir
@@ -414,8 +442,11 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
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
@@ -431,6 +462,9 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
             # bootm catches it earlier, at fit_check_format() time
             msg = 'Signature checking prevents use of unit addresses (@) in nodes'
             run_bootm(sha_algo, 'evil kernel@', msg, False, efit)
+            # iminfo has no special error message
+            run_iminfo(sha_algo, 'evil kernel@',
+                       "Bad FIT image format", True, efit)
 
             # Try doing a clone of the images
             efit = '%stest.evilclone.fit' % tmpdir
@@ -440,20 +474,20 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
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
@@ -466,8 +500,8 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         utils.run_and_log(ubman, 'fdtput -t bx %s %s value %s' %
                           (fit, sig_node, sig))
 
-        run_bootm(sha_algo, 'Signed config with bad hash', 'Bad Data Hash',
-                  False)
+        assert_fit(sha_algo, 'corrupted signature',
+                   'Failed to verify required signature', False)
 
         ubman.log.action('%s: Check bad config on the host' % sha_algo)
         utils.run_and_log_expect_exception(
@@ -535,7 +569,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         # a dev signature only (sign_fit_norequire() overwrites the FIT).
         # Try to boot the FIT with dev key. This FIT should not be accepted by
         # U-Boot because the prod key is required.
-        run_bootm(sha_algo, 'required key', '', False)
+        assert_fit(sha_algo, 'required key', '', False)
 
         # Build the FIT with dev key (keys required) and sign it. This puts the
         # signature into sandbox-u-boot.dtb, marked 'required'.
@@ -550,7 +584,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         # U-Boot because the dev key is required and policy is "any" required key.
         utils.run_and_log(ubman, 'fdtput -t s %s /signature required-mode any' %
                           dtb)
-        run_bootm(sha_algo, 'multi required key', 'dev+', True)
+        assert_fit(sha_algo, 'multi required key', 'dev+', True)
 
         # Set the required-mode policy to "all".
         # So now sandbox-u-boot.dtb two signatures, for the prod and dev keys.
@@ -560,7 +594,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         # U-Boot because the prod key is required and policy is "all" required key
         utils.run_and_log(ubman, 'fdtput -t s %s /signature required-mode all' %
                           dtb)
-        run_bootm(sha_algo, 'multi required key', '', False)
+        assert_fit(sha_algo, 'multi required key', '', False)
 
     def test_global_sign(sha_algo, padding, sign_options):
         """Test global image signature with the given hash algorithm and padding.
-- 
2.43.0

