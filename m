Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F30EC982EA
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 11:51:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 62D39607F5;
	Wed, 23 Sep 2026 11:51:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N_uGKy1QvkIA; Wed, 23 Sep 2026 11:51:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B176E60745
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790164265;
	b=s3VTnhnutnFMFOmwLDARJ2ad2U9/uyeJCkaOP8pGKVM515Up7w9bYKt55pEovExNaGDn
	 KUQUeF4YDszy0DZsj8MSYQwSpmS72703gHYgnjIyUCuOqcer82r1gcjJph2FWwPXwdzcp
	 JvK1xqrCWYLqeKCmH0iSQG+ttazM1jrYxMknUFdIzPc1ktYGpGOsgBBKtaxKyYaIVPIk0
	 QXyVekh0wBRgmrN3jO+2kJwoxN0mNY6x24AY5NTViT5NM4uM8sWzTOdYfBqrfc2c6/qCj
	 LF/Wr6lsdRrt43LEUXVdg9InW36v+r0nJmjODVwfmhJ1RXbGwT1vLx/MsrsXMWkdAyw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790164265;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uqzw1iRVUMn940E39D2p/3igWIbyLI/emXDN8HbplJ8=;
	b=lwwrmGsmjatyyK2HjENSjlOTnz8TmWs24SXJK+MSJi6BaTEXpM8fYsDGKym0Z8KOWxi6
	 wmZtksqg92zbhCeCdNPIY3IVjwHldfBxMjkE9NRpsWUq56nbqSg52oaMbC52/L6SffGcq
	 GiEH/9+D8s4uEx/0M+sOSYl7SKPUMvwyDDuEiOY9u6zOhtlnigQkxFNpSEZx+r1x2b8me
	 E8r5tMF4KQjE6gDcWdjffx4rm9N0XTMR9zV+nIdB3DGB04e9Rize1BXvVKQsrJ4SFXQZq
	 bkOMFDmj94gcA39SQDIZd9fqotA1ysnaeZi7LhNeiLC+KovoD4CwudglTY+gn1H0GMw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790164265;
	bh=uqzw1iRVUMn940E39D2p/3igWIbyLI/emXDN8HbplJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wmgoYLFrv0cmjhnFofsdXm0uRwzCBqpxvy1roYCOkEmuzZX721tLyaojR4d+Amo3p
	 m+YbvcrYO0Hcj6ZrxLo1lsCZYtmR2VxJ7um0T1PZZEfDeeND4F6FTG+8Ds6VPTxl9l
	 4p2pxNSEcgMcCxEJ5J7AZKdZLnzxjjbIzKAg/iUDy6IphR9L/stLJbM6CcHLdQtguU
	 tgCQhD3rEUt3HOpWq9T3j+YOeP+BSRbAYup0I1lQzFck25epnRhysobv4Fg5DGOuMN
	 fbD1scJURshKCFTGZ+eW7PdLTiKsetC4d04fWQaCKKnBxRZwRTX4AfyC0u09+w+Gd2
	 Ei/5nXLBXvZFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B176E60745;
	Wed, 23 Sep 2026 11:51:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D29CCA29
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 11:51:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C2A5B406D7
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 11:51:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id skQwGJGismGS for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 11:51:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 12E6B406EF
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.136.65.227
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790164261;
 b=TNRKeHR39m9NZLEjg8y/SYx0bj/D5K+9AWmfPYhSpugwoMHYxVig4HWluQfoVzttJcVZ
 I36isT38Zkyy2NDXxmPpsCbH2n3+7o7ZQbT5tzPCqkbrYT7c7P5/mMQuc7uzb90h10DKO
 ulhZyzrQKOh/VsgBtt5oGJjo8QKppB++2yySjY9HJAXs/VfAvBjan6KCkPa0UKhfzybDT
 z2o4uE9BCDZl/NBE2o/r8UsrWYsXBlyna9VC90GUqHzviqlwM7ywYXt1RFcFTVkRp3woP
 V5C60i0u260t2fC3xBPMTohO0Jv0KR8CShQe8WIf+8vy6erS21I3sCgvYU7WU0T2CDA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790164261;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=uqzw1iRVUMn940E39D2p/3igWIbyLI/emXDN8HbplJ8=;
 b=mwZJBLXPijv1T45+Qh4FVw0xTQzlURZR5lJqw9qzeSof8BTYK2zFuoE2BpUUL/WBqxch
 I0pBL0I0CdsfC0wUKlNpMYpLXrtdnB/NOz+z7Wp2HCqDFJXdIR52RTQeEtFl5RjaGVT5g
 W6WgRYfd/KuNgzeSjjzZ1BbMHV+4LUu8ehHvKnQ7k40DkX0NNw+Wt1DR6OxL5l7/Ef/Nz
 3TlY9BjPPLUn68YUeVOGKuc0dahSEaWL7SF2zWs6adFHju/GYz8FkIx6X/bsRR6lxB2QM
 j6fJSzCuIE/tNUGnmr6GFLC2nT4Ljsk3CPtNr49tl9EEqDuK+4dDYZjIj+kYsJy4YNg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=frlmQRfX; 
 arc=none smtp.remote-ip=185.136.65.227
X-Greylist: delayed 63 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 23 Sep 2026 11:51:00 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=frlmQRfX
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.65.227;
 helo=mta-65-227.siemens.flowmailer.net;
 envelope-from=fm-1328817-20260923114954518cd3db52000207d8-j46yei@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-65-227.siemens.flowmailer.net
 (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 12E6B406EF
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 11:50:59 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id
 20260923114954518cd3db52000207d8
 for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 13:49:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=uqzw1iRVUMn940E39D2p/3igWIbyLI/emXDN8HbplJ8=;
 b=frlmQRfXK4Zo0DUqzXs4pcWeAm6lJpMw68yQ5ikRjlaqBHDgLdm3/wZpXE7KHgyKZPjU9C
 7dwnvwVWnWXsUHCwHVYHOb+kfYVJ5eSr+q78DmNCsPrO0CqI4i89BTWwOIYL1MOhvkaDIXgG
 6S52W3lFgTIBM2A22HmcnaRpPHZfxQXXKQZ8Wapf2rsq7C/DpcdjoU5UG6gm7AMqC/skpNgk
 wXVG8XBc639PSNMkjPPWqA8DW0QcGXq4IcUEkBKVyK49cg5BCYShBeFo+sjkDzlIb3IwIaX5
 u9tqDA/IjaFXUywFYQ14jeJxJFGuzCcE2UMEG3o0MN1BkIrVI1Yc66uQ==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Simon Glass <sjg@chromium.org>,
 Anton Ivanov <anton@binarly.io>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v10 4/7] test: vboot: handle CONFIG_FIT_REQUIRE_CONFIG_SIGS in
 test_vboot
Date: Wed, 23 Sep 2026 13:49:31 +0200
Message-ID: <20260923114940.349985-2-ludwig.nussel@siemens.com>
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
index 0708b65ea80..e93f61ceb8a 100644
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
@@ -260,6 +261,7 @@ CONFIG_FS_CRAMFS=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
 CONFIG_CMD_DHRYSTONE=y
 CONFIG_RSA_VERIFY_WITH_PKEY=y
+CONFIG_RSASSA_PSS=y
 CONFIG_TPM=y
 CONFIG_ZSTD=y
 CONFIG_SPL_LZMA=y
diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
index 101d25bd5c2..a39cf698b54 100644
--- a/test/py/tests/test_vboot.py
+++ b/test/py/tests/test_vboot.py
@@ -106,6 +106,7 @@ TESTDATA = [TESTDATA_IN[0]]
 TESTDATA += [pytest.param(*v, marks=pytest.mark.slow) for v in TESTDATA_IN[1:]]
 
 @pytest.mark.boardspec('sandbox')
+@pytest.mark.boardspec('sandbox_noinst')
 @pytest.mark.buildconfigspec('fit_signature')
 @pytest.mark.requiredtool('dtc')
 @pytest.mark.requiredtool('fdtget')
@@ -306,23 +307,32 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
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
         sign_output = sign_fit(sha_algo, sign_options)
         if sha_algo == 'sha1' and not padding:
             assert "'sign-images' is ignored" in sign_output
@@ -333,6 +343,22 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
             assert '/images/firmware/hash-1' in hashed_nodes
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
@@ -392,7 +418,6 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         # Create a new properly signed fit and replace header bytes
         make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
         sign_fit(sha_algo, sign_options)
-        bcfg = ubman.config.buildconfig
         max_size = int(bcfg.get('config_fit_signature_max_size', 0x10000000), 0)
         existing_size = replace_fit_totalsize(max_size + 1)
         run_bootm(sha_algo, 'Signed config with bad hash', 'Bad Data Hash',
@@ -518,6 +543,13 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
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
@@ -584,6 +616,10 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
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

