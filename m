Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466F8CD8C9D
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 13:10:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1FD784942;
	Mon,  8 Jun 2026 15:09:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.b="uGWLu9aZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D325283FEC; Mon,  8 Jun 2026 15:09:36 +0200 (CEST)
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 877BF848CF
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 15:09:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 202606081309331b3219eca900020727 for <u-boot@lists.denx.de>;
 Mon, 08 Jun 2026 15:09:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=28mv2Qem4AyuF0T2C7Ky3Ub6oR0f1dVL0YSg5YfqUVc=;
 b=uGWLu9aZSt4mHRfG6omQYrhSH4x4PYmm6dp7ReJKowrtyA6TG4bGz4kvMRseavwKuw+PoV
 jWdMiPShdfcPJ02D0y4MCZ9PQfDDSSw9G3kUN7wIUcJberu7azRMtn2Xd+rNGNpA+TMNJFym
 aNh27FIxXQhP4Ef1Id9LH4gzyTMw5DhK38zN3nHtCsEaf53bhijpXWhRFkRfAmV26QvADVAh
 62sykVNIyKHQAcB0TYqugEhbwBzWUtX8tJaYJWqagFBx6F2aBre2WO4eUw7eD9jZO6v8kAdO
 +Rz1xxh2WRJyEqWFHyq5kfVXWlcBdKUAUv9XROwYxTadMmlKMBJxn2OQ==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.denx.de
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 4/7] test: vboot: handle CONFIG_FIT_REQUIRE_CONFIG_SIGS in
 test_vboot
Date: Mon,  8 Jun 2026 15:08:50 +0200
Message-ID: <20260608130924.112831-2-ludwig.nussel@siemens.com>
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

