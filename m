Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC27E606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 10:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0nDdXW1R;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=ZfXG08eZ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E85B4054A;
	Thu, 29 Oct 2026 10:05:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r0HhaYYIBiIH; Thu, 29 Oct 2026 10:05:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 519C640815
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793268320;
	b=EIZrwE0Pc/tT4YB5VMvJbNl642CgqgfF0AEXgH7yXRnBXtzFNL3X3t7CSoZsinb9n4bM
	 HDwwz7ZNbWuCNaT4mBbKZ7StYatBbPtm1TVEF/z/UhJBmXTzKo+r4E5ieDYyW1m0V3t+e
	 zl+c4VmcGzhrMcnMKtxs1URdaZ725zM4xI1nbcuse8sXUUrwA63vF6KVy0mojsTqMzzkT
	 tVtF1UAkolcLUMRhaCjhCdVpY8fMGYiFbQWbBr9PPpS1R1NsG6lPOrTaw7NZ5Dp3OOfkQ
	 uM6ZaXOMwdQy2zrFwb4fKeuPHT1G/pNAKGErceRLqZeCujMoDD99p4++VQzAOERiKGA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793268320;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LJxMopRXh7ul5IEs4ibCq0H0Vj3a0rjIIZ6gI+0qngA=;
	b=Uj7ApSsSNpTl5Gia2YsMQD6D0PWWgnKHNIm0bYnRjfsgJ+4z7CTzjYcvvgH+b+aatGjr
	 xuGzaP4GoX9zLmMu05FcKwjqy+fL5OtaQ5cQCrs6hxQmqSkF+QJisWqOoRw0fWHybLI/o
	 +gWRCEgqiBeQZgL9P9nVA68+XNqpNrAvUOILwDAo68EnAgNriajA3vYpXxLjzqvYpAcs2
	 A3qMe0EbTYt5VQ6B1tFCBZh80GpmWlE/Jw1FR1zEfXoBf+0FPDFn3NYb+5yseP2b+NfmJ
	 CnevMyEvlT9LvsuGnznmqwwAiocRSLJf++GXgRUSFJLnXLtLmm+jpaidgJ0mMVqz1kA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793268320;
	bh=LJxMopRXh7ul5IEs4ibCq0H0Vj3a0rjIIZ6gI+0qngA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0nDdXW1RHIRzpBupfhPecZHjo0TaiLOKN1LrFuREDNevPP6odSDZqMu+WHwNd3lc0
	 tVQSTK8MSafUme5veu76iqLCJbbUWuOyIZg2IJFCBhY/GMQ/LR4KRRQbiF53eWBuRR
	 OzNgrEIQ303Ea0iv0keDe53rNkzAfaq4uyWF19Mk4DqH7ra/I9Mi1c8d0rciMRVE8T
	 F/sVa5cipTU3E6hP/KkxTjZTqXig9pSw5H1EDkPvreWRc43vkuwMJagJOb4fOhTsBa
	 JtgYYA/EeOAB3QHDYecQtemUgzosuYzvSNZreLnvBcXsucfx3F6gA+T2pomrfKIxok
	 EHI6TxXICUpQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 519C640815;
	Thu, 29 Oct 2026 10:05:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1C31C356
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:05:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0247760677
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:05:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QJZ0zh_-B4qy for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 10:05:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 023AA606CA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.136.64.228
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793268308;
 b=VBaOLWgMOnITn3weMLiGFfHjynep8Rr+PWnt64W+nzEaEjCW1T7vI/OkSy5vgpkKFQTA
 2MMZa/nD4bo0RJWq+Z4MPwssMumo3Ua1Utu1ziNSbbAK2GC9usqi3quCPgIDK9Hlh7dd3
 JrfZ2axYp0kqlUDZAD0H5TRXsupwhCU6ZvI5aEEoHiohpkKODFZ/b2M+jsWOwyR1B2paL
 4Q8Snr0fYQ6aabmRbkyU2cNYeBebK0xzkMFM9AIx91MlxnoV3EZFdXsM3yAUvASmnVcM/
 g4SD0pO9Uf0lqGPBUmwCO4bCVMg+7LAEexEUOHWPwiLVQQwlhNiTN2zOp3c16jH6eEw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793268308;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=LJxMopRXh7ul5IEs4ibCq0H0Vj3a0rjIIZ6gI+0qngA=;
 b=SxjGpWThQktUxFDyhShc6v7kSMOxJmBdTdRoVwe58fKoEcnOfQds4vb5JLWw7ahcDhxg
 6jwFHzBdgksXCaCll5WYxIJut7nykOgkONtRIwNCjXcvfOVn/lpq4RSnbKQNT/K8aekU1
 uRJWajTYKX9xw1Y8Q7yJ2QIE/o9z21NCdQ18dvMdxC2taesdLs8TQI+aHGeh3rOg24yr2
 L3vJrU9agvGt+/4dzUAB7tjnHZ0r9gc+m3ZnSOEqrNC81XG2E7Zl0msLCFUeH96wCzxuy
 enSsi3Pnk0Gj1dgKwKrT2HGuqV+fAXWPvp1bx5QTZcCXE4bA5c84pLEewiek8WU8PVQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=ZfXG08eZ; 
 arc=none smtp.remote-ip=185.136.64.228
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.228;
 helo=mta-64-228.siemens.flowmailer.net;
 envelope-from=fm-1328817-2026102910050378ad0823180002072e-aqyydi@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=ZfXG08eZ
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 023AA606CA
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:05:05 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 2026102910050378ad0823180002072e
 for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 11:05:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=LJxMopRXh7ul5IEs4ibCq0H0Vj3a0rjIIZ6gI+0qngA=;
 b=ZfXG08eZ5nSibJkkIImlZ7yjV7JsN2oh87XzKKuVSvytwA1i//Qq8fxOmFgJrz3irkBoeM
 9Uvv5Qo4NILNWNnGx4Ayv340VPBg73l5sgJjEvIqc9D9DvILeamt8Mps2Yzd/uYbVO5KWZx5
 ny6IrPrHRpKXnfvhfscqNxi+JPFX/eqf/vtWyKOLwVU6w+l0VJ0j1ae0NKlw0Uo0jPB51fQZ
 q+sSu+Ax2q1SNNH/TZPn1CRLVfIRNDnCOUEWqtIKgIzl5udOfeJwjlKfb9taSmy3SsOz4Pnz
 y1aoXLBzp6tSOkDUSNoH1qtNEFVS9i/yEIPmzZGiFhjUuVrcQR3a67pg==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Simon Glass <sjg@chromium.org>,
 Anton Ivanov <anton@binarly.io>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v11 6/6] test: vboot: add iminfo checks
Date: Thu, 29 Oct 2026 11:03:57 +0100
Message-ID: <20261029100455.31820-4-ludwig.nussel@siemens.com>
In-Reply-To: <20261029100455.31820-1-ludwig.nussel@siemens.com>
References: <20261029100455.31820-1-ludwig.nussel@siemens.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328817:519-21489:flowmailer
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

