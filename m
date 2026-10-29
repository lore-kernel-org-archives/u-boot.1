Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB258606A325
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 10:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fObuoHj7;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=ePelIuNx
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 810EE40812;
	Thu, 29 Oct 2026 10:05:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fL31IuHBV0Sz; Thu, 29 Oct 2026 10:05:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5ACFD4080F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793268318;
	b=q+AfLOpM+N04uIVVQeqKVGsvMe2KRMGA6SG2rf+HkIoO7tRzyvpXCXSIytKlYXmcAIW+
	 eVlrdwPThHgT2YDgSb/Aq9hjb3hcsbNCZzLrmwYxXNS7JbMVYbUN6xpOVUUKFUyOsrkBq
	 0C981cx12NULWPx0OI96x8+GV0vqFVE2lzLU0hfaXtl30h29oTD8S3MHPrlTShr5hK0J7
	 tsPKSwMglmpbFQ4qPbZu2ZAdsl066xmwfCg7g6Cl98A5Gkd8bRScSzEl7nFsVJ40Kzs0D
	 NE9o9Ly4EjEg9VkR5ceZ1Gp4+it2gMWcqKGMC3hyY0U3Zrf0IeG9599H8hTt56rAE0w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793268318;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ROMXekWxCcAeQhAdLshx2HgwICmqpSCSfpoKGPraPzQ=;
	b=DLGo4aVB3XvD/YS808oLbpf6WhUCE2p5vylOwJ0MKa73avJTO/Gn1un+mNsQJlnShrOK
	 KVNvGluN8gan5TvqOygv4WIuCtPJX06PFCMAz/FY0eD4yHSYU/IQIzkP6EekimyhrvzuV
	 fwejot9MOdlZDyfuG44546FMOR0CDqI7s3VCFvkXwpe3QWDJ5D1pxKFNf3AkRO1uetXj0
	 cYZEpXyG3URYrVDDlEZT43MyD9RGY+vLLxCMwd8tlNPPFZwpNGyO2vWMJlq/zQ7j6SGXf
	 vI7NnSA5LhZSu0L9azJrFiHV8gu9nLmM22RnImtHt4I/a/aXf3WQdHBiz8b4rM7m5xg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793268318;
	bh=ROMXekWxCcAeQhAdLshx2HgwICmqpSCSfpoKGPraPzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fObuoHj7zDXzx/ZYE5nndV8EnngQc+/WLDDKML815fubcw3o47bbOLDpqNZ4OSV0t
	 wd/ByfmWUjUwxHgLXUqPdt1ksV6cw88uGdmuyvJcAt6eb4jNaWkmxskj7dj0u/dpwe
	 KM4wigH+Rd0xJYzo8s6r02elToq35YfOrvjuf/kIwEEiwP/CBUfMJNzg1XN7LV8yad
	 nhfRVPpKlxOcSNr1xCJaXYt1KIcn45/tP7rOVQn3ei+3BD6BsFN//4Susf5DUnFwk3
	 QMe93JFNj7Ya72JYWOpEw7uxtN3QJX1iCBehhVIigkT5WPTDG+bka29KftwlvtkELd
	 tXASr7oKFqPbw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5ACFD4080F;
	Thu, 29 Oct 2026 10:05:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C9CD5356
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:05:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BB92F60677
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:05:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HPRzgGKG1vIl for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 10:05:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BE3BA606C2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.136.64.225
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793268308;
 b=St6lWtpF51qV6QRwYwdHJ6k24/beuLUlOpGYRYdbSFa6p16uLP/CMPYE3HbszS99w+jI
 Wf/TJoJvC8jki7xnfW86Zs7TvLmzZtYhPFIcOIzI1Juk+j4S9+bMyCJ21cQHWiNXDkx9c
 vzbO9T91sinrZ5WVJ47VNWWUyr6VgYyaPP+dZEX+HL4uvfU8i7RBORWf+SVuzakjRnKD/
 GGiMQScCUNeY40lHpsCJRLL/mtXMN8VTvnjSypWFKFqS6p1RKc0Y9THIWyw4/wbHev7tx
 pCjOC+VtqE3qaxIKy4Pp7RWNjx7ss2RmCf++YGH4MPDf4ry7Dq7w0OC2LdpVHNcpECg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793268308;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=ROMXekWxCcAeQhAdLshx2HgwICmqpSCSfpoKGPraPzQ=;
 b=WoOg4Vppt12lFXWvgsSYOwp/hWWMth0Jd9NgVMvEbQQ1KP77vJmcXPFpNsmfzbCKOIvk
 6rzoLIeYO81D1E83k5NacXMLcXQB+nZ0HwJlnCfE8y0ITrqLGDJAo2OkR5o6veI8L8uqi
 AW/RfqA3M99wSilJhg11W3rOYKLTekP3y+4yQCuRyxXVYX0DUdaGb46rZDDlokxlksC7s
 FU7fsPIroxfT2M22nXgTs9U4tDs2pEPb0KflvmGsXEfRLp5jwgXfS9gVhqJ8mrQXkTOjB
 chNghRufSO67p+ofjidsQ8bfgR/E/IMl5bKihWEeywvoRr+vg9lKJSNsK3ixHWx/1pA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=ePelIuNx; 
 arc=none smtp.remote-ip=185.136.64.225
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.225;
 helo=mta-64-225.siemens.flowmailer.net;
 envelope-from=fm-1328817-20261029100501bd3a875f4e000207dc-ul4x0f@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=ePelIuNx
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BE3BA606C2
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:05:05 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 20261029100501bd3a875f4e000207dc
 for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 11:05:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ROMXekWxCcAeQhAdLshx2HgwICmqpSCSfpoKGPraPzQ=;
 b=ePelIuNxLhibn/9uQKl0briFyGLpSCrSK8/mTyfzs1ckml709rT+Mue59b2ILBkoH/CMK3
 xvUfFWK7LqIYoVgkgRA9mpziLabEy34X0LaQZFDDWY6HAtM+9PEo2iAwFfzDjorK6p4YD1Np
 c8C5oSSKr8ywn945KnOgHuTYD1esRTQ2UOfd6/0ygFJ485g6fe0fABKtw1z/UCWTZ7aV2hyo
 EH6dnpl0C3aWyqYv/yXpm7b0yMFrsYMPdksce0uYZAGxgNEUtmacl80ZsRP4+ZcIhYbSJnL5
 Uf2TvhXC3WrC8trIYa7/A5t/QJ3zU3JxP4jNZc67RSHU7lp+pzBYZwiA==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Simon Glass <sjg@chromium.org>,
 Alexey Charkov <alchark@flipper.net>, Anton Ivanov <anton@binarly.io>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v11 3/6] test: vboot: handle CONFIG_FIT_REQUIRE_CONFIG_SIGS in
 test_vboot
Date: Thu, 29 Oct 2026 11:03:54 +0100
Message-ID: <20261029100455.31820-2-ludwig.nussel@siemens.com>
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
index 7a755012795..2e952060543 100644
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
@@ -261,6 +262,7 @@ CONFIG_FS_CRAMFS=y
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

