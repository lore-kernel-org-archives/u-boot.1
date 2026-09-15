Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D9C8C88E75
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 12:53:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 31D2980DCF;
	Tue, 15 Sep 2026 12:53:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 86th6o9IpsE5; Tue, 15 Sep 2026 12:53:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0214080DCA
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789476825;
	b=dQ/CAcabgKFKTwB0bWJjnjCamXh2VdiN/TZYPm/3D9SuD9Eiv2icMVLW9gGuAEVJ7QJR
	 uvq//jVQjC8CXxnHUYhWQV2VsJxaVvDvNRxOkxD1qM4EhcwYkGnvrFc6369JDS10zTix2
	 pJCi+veWra/Q/ju8Md0SPSCD5LrcRBHMo2e2aLX7Jn/ThhYFYojbE2P6G5sIxIg0c9p2k
	 ICm55IZisV6EIBAAf0G6QG0PzLMWH1rVTQi8kNNuqPK4FxS0BoZz+xeXAJR43Fvp/AfxT
	 OeiSo6hZH3IjZrf1ZpES6QEICw+DJWEj/zs1cHSkQyhukFA0HrRwUik/4ymRDe1oBAg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789476825;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-Virus-Scanned:X-Virus-Status:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=94E/KYvESseIbLUh2FrKeqbYMLlJRXH8lRS+AF4eer4=;
	b=IXXu9Wl6is72fQx7ZKvg4CCbC01nJ4YIqNWxhMw/+ZQ3U4Zn3WqlBMnAP30QOT1ekAZ8
	 SP1H4PYjOU7X5pJ3UBz3J30g4+7fJAGKOrskiRN45oUCAfPn4AYKO48Amk6m8y/pVzmho
	 8C/VUp4bGraxV5TgwB8QUrDoqUHW8lYRRk/bZrovN/yDMdWf0N/Rxnywggz+llfBMzHu6
	 nLu/ORsjN0tmr2VxJBIlCR2ksC4HcDnXYffM8d1yGl83CB54w9rCVLTbklgpK26n0UvMh
	 lasadAA5MXzTJpj9JHILG/wDtQmuCmbhe+w1BaeFM/qYn2yb/6hgxty9jtNR46YiNsw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789476825;
	bh=94E/KYvESseIbLUh2FrKeqbYMLlJRXH8lRS+AF4eer4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zTM7P8qUMBOF6hSVMtHCNXp8tdSy/irLQRWLA4ptkOiYMKGamNpPsqqABO11Em5c9
	 iTT5YSou8Dt4BEFCASzr0SFQXrNBqfVMt2CXyEa1E2w/D0boar3xrgiTplPaCzROic
	 JVm3AZ6w407qH71hhnNNfU12qW4iven7ssl17/RFUd7uESxgcctAJlpz3m6YKmsurH
	 91ho+Oc5+4m2FbD/q7GqYg5vwBigJPwgnUWW3FEDGODYnKGyzdku+CCkegl2gixJwQ
	 2RpqH7DhnUdW7DUsNa2iqUyXoIp75s9dilIYTRxHHIbeEyEreLwtdETgFcqERn4FJo
	 SyF1B13DvT2kQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0214080DCA;
	Tue, 15 Sep 2026 12:53:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id ECEB7259
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:53:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D94B76075A
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:53:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SDo4pgOL0KbT for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 12:53:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6C8386074D
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789476813;
 b=ZdWNZe8rx6ZS75NPoJC3WECW9avIkGsxt8HAwForRxcyvywLUGRBTevD8R1O6z6uLW7U
 iC+4CK1ahJT8OtP+mTiaORQGZOHKo+ci7X/mxWox4ecldPBbwW0y1kIephltFbc0PizjJ
 Xk6Aj3PcUdGFT5mScavWLHSsz6RH6BhqdFZdH+QAHRJvHihOEWsrZ21XbCglXK50EybEw
 s5+rwWaLFPUJhfu/Bq8FT0UbNeqCakfEWXgnRbNU+weG0eeyzLeFSm26ciwi51gUbjhdH
 QxzuRfnps+mn0mHIatqWtQDHUmi8EDA2nuo49lxVuCDC69M/31h4ILLYaCb4fM82Plg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789476813;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
 X-Flowmailer-Platform:Feedback-ID:X-Virus-Scanned:X-Virus-Status;
 bh=94E/KYvESseIbLUh2FrKeqbYMLlJRXH8lRS+AF4eer4=;
 b=VWbU4Qf3c0KPIAAKFxUthexH8YuN1QA/rxCIYc62l5ksqZC7UwgSYqr4ls6ScyG2vsq3
 85p6zcP11y1TIgrS7jq1IBUC6chjB8NDGgPLMbnSMMAO0rYPoZV80UbWbK/3AUL/bJ2qb
 mbSMUQLk5OBFNoghI1KBuQJky8RAblsoCbwVCy55jBNi24bYmjDyOXQPJ89LUy/S51n+F
 4OJj7YWJaBuzCct0crbCjEw+ESQC2AIwbEAZSMeHC6zcYYSWH5BBSVHjY79up/ZIW8mYs
 L4hD1SjcogUVBBU46ao8boSLWwRoNOHzDDpF1hh2B2diGfyn089uPtLTXjSD2viw3tw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 spf=fail smtp.mailfrom=siemens.com;
 dkim=pass header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=GJ69oK1o; 
 arc=none smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=ludwig.nussel@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp3.osuosl.org; spf=fail smtp.mailfrom=siemens.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=GJ69oK1o
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6C8386074D
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:53:31 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73C798404D; Tue, 15 Sep 2026 14:53:30 +0200 (CEST)
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52535847D7
 for <u-boot@lists.denx.de>; Tue, 15 Sep 2026 14:53:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.b="GJ69oK1o"; dkim-atps=neutral
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 202609151253271fdda500e200020753 for <u-boot@lists.denx.de>;
 Tue, 15 Sep 2026 14:53:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=94E/KYvESseIbLUh2FrKeqbYMLlJRXH8lRS+AF4eer4=;
 b=GJ69oK1ougVTUOL7cuqzzZsGXI8CYHTVxBcnt/5qnAmcB0qjAbeIukmNKSpeipQXXyxAXP
 h2kS3wcUt6P58KUxYfT4BLs8q0b6H8o1DwaKL9eewRL+SsZAd54H9DR2d/QC+kXzrXVtV4f3
 1u+WtDRYSez3Vpaijxyo0n5OmcYId+BuhjqA0sPzxfOtKpC2E9CBR8hjYoT7YEjnIJAAF6wm
 sXuCFM0HUdbVPZOb3UA+r4NXPkg9cOnsYJrXtvXlfwVfhlORTseknCa88rqSq6Ewoq9+Zs66
 nQbQXw4M4W2E9bw2QDDuXC2zQecYnDwlxXQcnR1rvGD9OGnkos2oU+9g==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [PATCH v9 8/8] test: vboot: add iminfo checks
Date: Tue, 15 Sep 2026 14:52:19 +0200
Message-ID: <20260915125317.180911-4-ludwig.nussel@siemens.com>
In-Reply-To: <20260915125317.180911-1-ludwig.nussel@siemens.com>
References: <20260915125317.180911-1-ludwig.nussel@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328817:519-21489:flowmailer
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
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

