Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07256C88E7B
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 12:53:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B02DC40633;
	Tue, 15 Sep 2026 12:53:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hobQweEWIqzL; Tue, 15 Sep 2026 12:53:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B37F04052E
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789476821;
	b=DbnabBuFGipzm1MCwtckosdasOkgt7HbtbVXvofeNmdVZnsTMyJl0gMO0yJirQocugd4
	 pS+BDjF8jg3SzjwcDOnzmOWBphggs2gMg13V30RELfPN4wPjSCgXdJjMZmkKDOvOuRzgm
	 GBluIcMhNSCn9tpbyOnS+VuOo/iXVrD35xGGj52xWNJKdnmYyC+bg3nd0ww28QAbT4yQ/
	 hOVUyPMt4vcnOvce0tqXN+AwjeYWs7+r3G1GJeEy/paz91JHgSwoHo5KSrDkBLlauCte/
	 ppmPQeYl48FCH7gPx7lvjuGx3bsCgoRb58X5l9jpzYKIz3RSnDGOtMAazCJuD81QCEA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789476821;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-Virus-Scanned:X-Virus-Status:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=28mv2Qem4AyuF0T2C7Ky3Ub6oR0f1dVL0YSg5YfqUVc=;
	b=PipyUZOnq1UCKb1o1ACuoJpHB9xW0YDdm/oSvoLrap79iPWI06kbfVZR/TGQCLp54nMH
	 2+A/nVcU7qRdhAE+G5t0sPC2cKvtzubYL02LKU4hzT8ENSOTk7swAHekRl0YBLIQQYzhJ
	 c/LqimibshZiz5cz8s8jPbxOJIgYGijH0bYEFMb/c+n3hc8dol126CEogGALbHzYLmCCw
	 1TEy7rMPHrrB2YtyWrGnMPvX2IMfPDb5gZOKZkPrZCL5sFQPnFmfB25qW9e/7Vgl3g6CA
	 oNdJz4nGd7oLx55Xc/GzraGcg86weSKsB39a8XOlAqA6OMZ8W1GX9gM/mTUUYr5DOWA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789476821;
	bh=28mv2Qem4AyuF0T2C7Ky3Ub6oR0f1dVL0YSg5YfqUVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FYexUJ/iitCJ+9RQkgFmucRG0kUleZMNOotP9rvDuxT/qClSSvgh9K1TpAlSWyZ7j
	 noQBZLqk8ocJGk42+VsdFkdWJwYhElzSQPdgoApGNpxUx4blmCf7HEXbehSXPI3dek
	 zJ3qh9dtZ7gnGydoq1qOhpaep1bLwupmcDX1nKNv6zcz5dcfH2U/Fi2Px7cC3d5z23
	 R9C2OtulXgPkWTQmax4U5pdSL7EYsTubuqw5CAGjsibyjmvDLfsEOgbfR8T2Ul2zkA
	 lLCxJbTiGfepnn0oFssvLoVzYes5t1bg+idA7jxxcT1K7oxBqd8heD1pEzLjNza6Qg
	 Ubp/2Abz7Dm8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B37F04052E;
	Tue, 15 Sep 2026 12:53:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 406F0224
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:53:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3E595401DD
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:53:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zIr4_njD9SCA for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 12:53:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 04EDC4002B
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=85.214.62.61
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789476812;
 b=EJwLpSfET4pP8ZKwRUze+6OvFGjtqEakgbmUUwMwfdSSlcAIMvUUtjOf9Ad0v9PhhYYx
 w7IF1CeIUFbTO87/CVwIglMtDgyvqNEmK0JdOW5jnKeZ4dITF04HN7FdRpcdwn8xIXslO
 FRWbVRO0+Eenac+uJ2fH7kRrlxZE4FTBThAM/UqcKol9XaXmfpMLtZgKLbzT4f+h/A2JG
 URqFhyDy2c94NrDpr8wts/X3cMN/BAnRg7vQ244tjWh0Wrh1y/+1axewFDDEFGjIywz5G
 8vp/ANmBvoshLN3LaXOVOGYdiOVCLe91Yx/mcA2draISqjz1osc8qhNRnUdtc1qoh3Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789476812;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
 X-Flowmailer-Platform:Feedback-ID:X-Virus-Scanned:X-Virus-Status;
 bh=28mv2Qem4AyuF0T2C7Ky3Ub6oR0f1dVL0YSg5YfqUVc=;
 b=L7kVGt/TUVdEKnsAxqY1bVNIR5nyyqwb4LQFx6H/h/T5dVmf2WvL7pgPsdvaLKa+wvtI
 GyYaj5rQmAzGl1yKuVGIeMTmPLbg/7XImPPxUW+42Q7g2/ypdNTqcp/SHF/0ICzwByDjR
 Knf+yl6+pw4OuVm+iC8SJ9E0+9K9psAkbihPMSmYB/xobKUYxu3yNVQqpLgrMPRlEhuMS
 CymfUHP804nbBbTgn501l7kEqi87IriRpkGIdQUmNmhR895dwjGZdmHdkKmQSkeXs8TNz
 LrlkpOC8uFobXG+kQ0cqDpU/paaLXVvdt1TYTxbsN+T1vwAs6VR2EIQDFSPrJ0CH/KQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 spf=fail smtp.mailfrom=siemens.com;
 dkim=pass header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=ni0PBk2d; 
 arc=none smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=ludwig.nussel@siemens.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp2.osuosl.org; spf=fail smtp.mailfrom=siemens.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=ni0PBk2d
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 04EDC4002B
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:53:31 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id A13C8847EE; Tue, 15 Sep 2026 14:53:27 +0200 (CEST)
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7620A847D7
 for <u-boot@lists.denx.de>; Tue, 15 Sep 2026 14:53:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.b="ni0PBk2d"; dkim-atps=neutral
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 202609151253252a8bdc41fb00020776 for <u-boot@lists.denx.de>;
 Tue, 15 Sep 2026 14:53:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=28mv2Qem4AyuF0T2C7Ky3Ub6oR0f1dVL0YSg5YfqUVc=;
 b=ni0PBk2dipC6rYjknW2sfI3OB++NZoYHk4ytNP5TRt0lt2epZ+YOxjMhSk2uzkbAY6GnYk
 T4BhmJrt9V6mYffAqiGW6z/Mrt8ZNxOqj050IWYhMRRaQaSWWRKNYEfL6ScpEUYWrlrtJFNw
 gF4qghszRxA4+YHbxY2G0Mvh9E/7bS8mKaR74VzHexIt+n0TchQpEjTjPq+GaUy1W5rlg9XR
 uSXH7otrxMiIgWzjqcuWl5++e2xC/QjXbJMYDOhOFi/rqZdxfWJPLI3yKleF8CwrPqaAUeQZ
 mJ6ESxEjG8as4mpdMHAVcoqu0vTslg/ihaUgdc3dpqcBlo/qDKqvHAUQ==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [PATCH v9 5/8] test: vboot: handle CONFIG_FIT_REQUIRE_CONFIG_SIGS in
 test_vboot
Date: Tue, 15 Sep 2026 14:52:16 +0200
Message-ID: <20260915125317.180911-2-ludwig.nussel@siemens.com>
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

Make sure test_vboot works with CONFIG_FIT_REQUIRE_CONFIG_SIGS set
and unset.
Enable CONFIG_FIT_REQUIRE_CONFIG_SIGS in sandbox_noinst_defconfig and
leave it off in other sandbox configs
This has the side effect of not testing pre-load global signature in
that configuration.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
---

(no changes since v5)

Changes in v5:
- refactor ubman.config.buildconfig access
- reword commit message to mention disabling of pre-load global
  signature test

Changes in v4:
- test CONFIG_FIT_REQUIRE_CONFIG_SIGS in test_vboot
- set CONFIG_FIT_REQUIRE_CONFIG_SIGS in sandbox_defconfig

 configs/sandbox_noinst_defconfig |  2 ++
 test/py/tests/test_vboot.py      | 62 +++++++++++++++++++++++++-------
 2 files changed, 51 insertions(+), 13 deletions(-)

diff --git a/configs/sandbox_noinst_defconfig b/configs/sandbox_noinst_defconfig
index 076be6586cf..c9adf08576e 100644
--- a/configs/sandbox_noinst_defconfig
+++ b/configs/sandbox_noinst_defconfig
@@ -20,6 +20,7 @@ CONFIG_SYS_MEMTEST_START=0x00100000
 CONFIG_SYS_MEMTEST_END=0x00101000
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_REQUIRE_CONFIG_SIGS=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_HAS_LOAD_FIT_ADDRESS=y
@@ -262,6 +263,7 @@ CONFIG_FS_CRAMFS=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
 CONFIG_CMD_DHRYSTONE=y
 CONFIG_RSA_VERIFY_WITH_PKEY=y
+CONFIG_RSASSA_PSS=y
 CONFIG_TPM=y
 CONFIG_ZSTD=y
 CONFIG_SPL_LZMA=y
diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
index 55518bed07e..6459c7c313e 100644
--- a/test/py/tests/test_vboot.py
+++ b/test/py/tests/test_vboot.py
@@ -106,6 +106,7 @@ TESTDATA = [TESTDATA_IN[0]]
 TESTDATA += [pytest.param(*v, marks=pytest.mark.slow) for v in TESTDATA_IN[1:]]
 
 @pytest.mark.boardspec('sandbox')
+@pytest.mark.boardspec('sandbox_noinst')
 @pytest.mark.buildconfigspec('fit_signature')
 @pytest.mark.requiredtool('dtc')
 @pytest.mark.requiredtool('fdtget')
@@ -306,26 +307,51 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         dtc('sandbox-kernel.dts', ubman, dtc_args, datadir, tmpdir, dtb)
         dtc('sandbox-u-boot.dts', ubman, dtc_args, datadir, tmpdir, dtb)
 
-        # Build the FIT, but don't sign anything yet
-        ubman.log.action('%s: Test FIT with signed images' % sha_algo)
-        make_fit('sign-images-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
-        run_bootm(sha_algo, 'unsigned images', ' - OK' if algo_arg else 'dev-', True)
+        if not require_config_sigs:
+            # Build the FIT, but don't sign anything yet
+            ubman.log.action('%s: Test FIT with signed images' % sha_algo)
+            make_fit('sign-images-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
+            run_bootm(sha_algo, 'unsigned images', ' - OK' if algo_arg else 'dev-', True)
 
-        # Sign images with our dev keys
-        sign_fit(sha_algo, sign_options)
-        run_bootm(sha_algo, 'signed images', 'dev+', True)
+            # Sign images with our dev keys
+            sign_fit(sha_algo, sign_options)
+            run_bootm(sha_algo, 'signed images', 'dev+', True)
 
-        # Create a fresh .dtb without the public keys
-        dtc('sandbox-u-boot.dts', ubman, dtc_args, datadir, tmpdir, dtb)
+            # Create a fresh .dtb without the public keys
+            dtc('sandbox-u-boot.dts', ubman, dtc_args, datadir, tmpdir, dtb)
 
-        ubman.log.action('%s: Test FIT with signed configuration' % sha_algo)
+        ubman.log.action('%s: Test FIT with unsigned configuration' % sha_algo)
         make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
-        run_bootm(sha_algo, 'unsigned config', '%s+ OK' % ('sha256' if algo_arg else sha_algo), True)
+        if require_config_sigs:
+            # DTB has no /signature node; FIT_REQUIRE_CONFIG_SIGS makes this
+            # fail-closed, so U-Boot must reject the unsigned config FIT.
+            run_bootm(sha_algo, 'unsigned config',
+                      'No signature node found', False)
+        else:
+            # No required keys in the DTB, so an unsigned config FIT is fine.
+            run_bootm(sha_algo, 'unsigned config',
+                      '%s+ OK' % ('sha256' if algo_arg else sha_algo), True)
 
-        # Sign images with our dev keys
+        ubman.log.action('%s: Test FIT with signed configuration' % sha_algo)
         sign_fit(sha_algo, sign_options)
         run_bootm(sha_algo, 'signed config', 'dev+', True)
 
+        # Test a signed FIT config when the DTB has no keys at all.
+        # Without FIT_REQUIRE_CONFIG_SIGS the absence of keys in the DTB means
+        # there are no required-key checks, so the boot must succeed.
+        # With FIT_REQUIRE_CONFIG_SIGS the missing /signature node in the DTB is
+        # treated as a hard failure regardless of whether the FIT is signed.
+        ubman.log.action('%s: Test signed FIT with no keys in DTB' % sha_algo)
+        dtc('sandbox-u-boot.dts', ubman, dtc_args, datadir, tmpdir, dtb)
+        if require_config_sigs:
+            run_bootm(sha_algo, 'signed config, no DTB keys',
+                      'No signature node found', False)
+        else:
+            run_bootm(sha_algo, 'signed config, no DTB keys',
+                      '%s+ OK' % ('sha256' if algo_arg else sha_algo), True)
+        # Restore keys in the DTB for the checks that follow.
+        sign_fit(sha_algo, sign_options)
+
         ubman.log.action('%s: Check signed config on the host' % sha_algo)
 
         utils.run_and_log(ubman, [fit_check_sign, '-f', fit, '-k', dtb])
@@ -385,7 +411,6 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         # Create a new properly signed fit and replace header bytes
         make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
         sign_fit(sha_algo, sign_options)
-        bcfg = ubman.config.buildconfig
         max_size = int(bcfg.get('config_fit_signature_max_size', 0x10000000), 0)
         existing_size = replace_fit_totalsize(max_size + 1)
         run_bootm(sha_algo, 'Signed config with bad hash', 'Bad Data Hash',
@@ -485,6 +510,13 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
             padding: Either '' or '-pss', to select the padding to use for the
                     rsa signature algorithm.
         """
+        # test_fdt_add_pubkey reuses this tmpdir and needs sandbox-kernel.dtb,
+        # so compile it unconditionally before any early exit.
+        dtc('sandbox-kernel.dts', ubman, dtc_args, datadir, tmpdir, None)
+
+        if require_config_sigs:
+            pytest.skip('simple-images.its has no config-level signatures; '
+                        'incompatible with CONFIG_FIT_REQUIRE_CONFIG_SIGS')
 
         dtb = '%ssandbox-u-boot-global%s.dtb' % (tmpdir, padding)
         ubman.config.dtb = dtb
@@ -551,6 +583,10 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
     old_dtb = ubman.config.dtb
     try:
         ubman.config.dtb = dtb
+
+        bcfg = ubman.config.buildconfig
+        require_config_sigs = bcfg.get('config_fit_require_config_sigs', False)
+
         if global_sign:
             test_global_sign(sha_algo, padding, sign_options)
         elif required:
-- 
2.43.0

