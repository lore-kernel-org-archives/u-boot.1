Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07880CD4F21
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 14:11:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B9E78465A;
	Wed, 13 May 2026 16:10:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.b="aDL5i94G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6B94846A4; Wed, 13 May 2026 16:10:47 +0200 (CEST)
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B91284683
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 16:10:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 202605131410426e1c245db50002076c for <u-boot@lists.denx.de>;
 Wed, 13 May 2026 16:10:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=AkIntdw311wkiV+wdX7Hl034xjLTqusYAEt6Bmp6Xl4=;
 b=aDL5i94GfHVuU1UydoeSrVk7AThN7pG5yncJbQj2N0vVturhofSViAoDuY2r7AUgkS0K4t
 NZ+wLB78lWmAB/D8ayDlnSAamb1VAhiTSqpOE2tTxmKfJGmzlQGaZMjHveHSnCsfZugYFb6v
 XWnPDoHNVasUyYUnrJGSf2vPawxqjo34hAONTNYXg0KVfnBqz35CZ03/zFZjUB6JzGQbTl1Q
 IgNn4Is/Wl3YYFuKR+Hv3W4HZ6TnSCnhXCnshYHE5enBDjmSKt1YXfajMyLsM69GAAz3hQ2w
 K315e04AbjxPw+9d8ydJrcusKDL/Pu1kCAD6/Pag4A4n6LwpZDbaC9Tw==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.denx.de
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>,
 Copilot <223556219+Copilot@users.noreply.github.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 4/6] test: vboot: handle CONFIG_FIT_REQUIRE_CONFIG_SIGS in
 test_vboot
Date: Wed, 13 May 2026 16:08:14 +0200
Message-ID: <20260513141027.351280-2-ludwig.nussel@siemens.com>
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

Make sure test_vboot works with CONFIG_FIT_REQUIRE_CONFIG_SIGS set
and unset.
Enable CONFIG_FIT_REQUIRE_CONFIG_SIGS in sandbox_defconfig and leave
it off in other sandbox configs

Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>

Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
---

Changes in v4:
- test CONFIG_FIT_REQUIRE_CONFIG_SIGS in test_vboot
- set CONFIG_FIT_REQUIRE_CONFIG_SIGS in sandbox_defconfig

 configs/sandbox_defconfig   |  1 +
 test/py/tests/test_vboot.py | 60 +++++++++++++++++++++++++++++--------
 2 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index ba800f7d19d..e9866a92fcb 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -21,6 +21,7 @@ CONFIG_EFI_CAPSULE_CRT_FILE="board/sandbox/capsule_pub_key_good.crt"
 CONFIG_BUTTON_CMD=y
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_REQUIRE_CONFIG_SIGS=y
 CONFIG_FIT_CIPHER=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_BOOTMETH_ANDROID=y
diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
index 55518bed07e..f7156943c24 100644
--- a/test/py/tests/test_vboot.py
+++ b/test/py/tests/test_vboot.py
@@ -306,26 +306,54 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         dtc('sandbox-kernel.dts', ubman, dtc_args, datadir, tmpdir, dtb)
         dtc('sandbox-u-boot.dts', ubman, dtc_args, datadir, tmpdir, dtb)
 
-        # Build the FIT, but don't sign anything yet
-        ubman.log.action('%s: Test FIT with signed images' % sha_algo)
-        make_fit('sign-images-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
-        run_bootm(sha_algo, 'unsigned images', ' - OK' if algo_arg else 'dev-', True)
+        bcfg = ubman.config.buildconfig
+        require_config_sigs = bcfg.get('config_fit_require_config_sigs', False)
 
-        # Sign images with our dev keys
-        sign_fit(sha_algo, sign_options)
-        run_bootm(sha_algo, 'signed images', 'dev+', True)
+        if not require_config_sigs:
+            # Build the FIT, but don't sign anything yet
+            ubman.log.action('%s: Test FIT with signed images' % sha_algo)
+            make_fit('sign-images-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
+            run_bootm(sha_algo, 'unsigned images', ' - OK' if algo_arg else 'dev-', True)
 
-        # Create a fresh .dtb without the public keys
-        dtc('sandbox-u-boot.dts', ubman, dtc_args, datadir, tmpdir, dtb)
+            # Sign images with our dev keys
+            sign_fit(sha_algo, sign_options)
+            run_bootm(sha_algo, 'signed images', 'dev+', True)
 
-        ubman.log.action('%s: Test FIT with signed configuration' % sha_algo)
+            # Create a fresh .dtb without the public keys
+            dtc('sandbox-u-boot.dts', ubman, dtc_args, datadir, tmpdir, dtb)
+
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
@@ -485,6 +513,14 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
             padding: Either '' or '-pss', to select the padding to use for the
                     rsa signature algorithm.
         """
+        # test_fdt_add_pubkey reuses this tmpdir and needs sandbox-kernel.dtb,
+        # so compile it unconditionally before any early exit.
+        dtc('sandbox-kernel.dts', ubman, dtc_args, datadir, tmpdir, None)
+
+        bcfg = ubman.config.buildconfig
+        if bcfg.get('config_fit_require_config_sigs', False):
+            pytest.skip('simple-images.its has no config-level signatures; '
+                        'incompatible with CONFIG_FIT_REQUIRE_CONFIG_SIGS')
 
         dtb = '%ssandbox-u-boot-global%s.dtb' % (tmpdir, padding)
         ubman.config.dtb = dtb
-- 
2.43.0

