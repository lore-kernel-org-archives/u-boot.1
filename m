Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F7C2D0E6EC
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 15:43:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76838840B0;
	Tue, 25 Nov 2025 16:43:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jHsisTa0";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="S9ySOyJU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A9D5840D8; Tue, 25 Nov 2025 16:43:35 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6033883FDB
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 16:43:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dG6RT0p1Lz9v0V;
 Tue, 25 Nov 2025 16:43:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764085413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hQbCJwUt4t1IJf1Tw4Y4gYlM0Fsi92ENhsJpogCZHvg=;
 b=jHsisTa0PtrE9gxQatbr30GqUh6sRzPjUFOgosEPaQfmDYxIUjNNiI0tbLHQ5Ip65G2KSF
 DlvWAK8DyQWl3Ma1OAV5X0FckQRbwk8H2K4MDUfTBS/b6fn3gZRnwBd7naxyRBTQ8VgK+3
 nt6IhTJ3YuyvhClCW7uxC5x/1u89mvHeFpn839y2/9TR8EaOBzR1BK4LbUOrUYRDzIyra7
 GiOxSIqT1hOzl7XJG9DSlJymdZPF76WKFJsN08lJ8nRzNmH+5p+SSyq+bY4CyPqRr18SJE
 qfz4wRK0fmyVLACUfnYqzcffAyFC3JaAMDZBWyzyGNKmfYxjFOagycMrf8iO5w==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764085411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hQbCJwUt4t1IJf1Tw4Y4gYlM0Fsi92ENhsJpogCZHvg=;
 b=S9ySOyJUfQz3FCTeURdichxbH2wd8F5EdE0ZPxfzY24+R4/02xMsSxqcN77zsQUlK9i/IL
 fh3gm2gnmoBhF98YoVae/YvGKt0v29Mtx3TdXdnDQneDCkgRdkav+KTF9rSdkEX58BSbg2
 W2HvlG5pmAk7Ajtoai1Xbh4d+d1QHuTwARgb2zCVuxFfG1fO/Ouf2MTz42FWqcJGZACHHV
 e/+HYY1FegOHQu/mnwBJXsRBOyOOfM/jwvehRKcXSbu0nT1QI1G25JdXa32bo6oCQiyB6G
 bvJmDiHvQerrLFjzYRIjChw2+IVQLLe2rmEhysgiVaTCscg65c06JuU3ZuRaTw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 =?UTF-8?q?Carlos=20L=C3=B3pez?= <carlos.lopezr4096@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 u-boot@dh-electronics.com
Subject: [PATCH v3 1/2] test/py: fit: Deduplicate the test
Date: Tue, 25 Nov 2025 16:42:56 +0100
Message-ID: <20251125154324.51940-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: myzhzqucntdzqdeczxuyw4uq7aurcsst
X-MBO-RS-ID: 78bf9bde0093444ce91
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

Introduce generate_and_check_fit_image() and call it with various
parameters to test various configurations of the fitImage. This is
identical to the existing test, expect for the code duplication.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: "Carlos López" <carlos.lopezr4096@gmail.com>
Cc: Aristo Chen <jj251510319013@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Julien Masson <jmasson@baylibre.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: Paul HENRYS <paul.henrys_ext@softathome.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Rasmus Villemoes <ravi@prevas.dk>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
Cc: u-boot@lists.denx.de
Cc: u-boot@dh-electronics.com
---
V2: New patch
V3: - Report test configuration on failure
    - Add RB from Quentin
---
 test/py/tests/test_fit_auto_signed.py | 97 +++++++++++----------------
 1 file changed, 38 insertions(+), 59 deletions(-)

diff --git a/test/py/tests/test_fit_auto_signed.py b/test/py/tests/test_fit_auto_signed.py
index 0b5dbd5401c..6220fe6ff59 100644
--- a/test/py/tests/test_fit_auto_signed.py
+++ b/test/py/tests/test_fit_auto_signed.py
@@ -138,6 +138,28 @@ class SignedFitHelper(object):
 @pytest.mark.buildconfigspec('fit_signature')
 @pytest.mark.requiredtool('fdtget')
 def test_fit_auto_signed(ubman):
+    def generate_and_check_fit_image(cmd, crc=False, simgs=False, scfgs=False, bl31present=False, key_name="", sign_algo="", verifier=""):
+        """Generate fitImage and test for expected entries.
+
+        Generate a fitImage and test whether suitable entries are part of
+        the generated fitImage. Test whether checksums and signatures are
+        part of the generated fitImage.
+        """
+        mkimage = ubman.config.build_dir + '/tools/mkimage'
+        utils.run_and_log(ubman, mkimage + cmd)
+
+        fit = SignedFitHelper(ubman, fit_file)
+        if fit.build_nodes_sets() == 0:
+            raise ValueError(f'FIT has no "/image" nor "/configuration" nodes, test settings: cmd={cmd} crc={crc} simgs={simgs} scfgs={scfgs} bl31present={bl31present} teepresent={teepresent} key_name={key_name} sign_algo={sign_algo} verifier={verifier}')
+        if crc:
+            fit.check_fit_crc32_images()
+        if simgs:
+            fit.check_fit_signed_images(key_name, sign_algo, verifier)
+        if scfgs:
+            fit.check_fit_signed_confgs(key_name, sign_algo)
+
+        fit.check_fit_loadables(bl31present)
+
     """Test that mkimage generates auto-FIT with signatures/hashes as expected.
 
     The mkimage tool can create auto generated (i.e. without an ITS file
@@ -150,7 +172,6 @@ def test_fit_auto_signed(ubman):
 
     The test does not run the sandbox. It only checks the host tool mkimage.
     """
-    mkimage = ubman.config.build_dir + '/tools/mkimage'
     tempdir = os.path.join(ubman.config.result_dir, 'auto_fit')
     os.makedirs(tempdir, exist_ok=True)
     kernel_file = f'{tempdir}/vmlinuz'
@@ -186,39 +207,18 @@ def test_fit_auto_signed(ubman):
     s_args = " -k" + tempdir + " -g" + key_name + " -o" + sign_algo
 
     # 1 - Create auto FIT with images crc32 checksum, and verify it
-    utils.run_and_log(ubman, mkimage + ' -fauto' + b_args + " " + fit_file)
-
-    fit = SignedFitHelper(ubman, fit_file)
-    if fit.build_nodes_sets() == 0:
-        raise ValueError('FIT-1 has no "/image" nor "/configuration" nodes')
-
-    fit.check_fit_crc32_images()
-
-    fit.check_fit_loadables(present=False)
+    generate_and_check_fit_image(' -fauto' + b_args + " " + fit_file,
+                                 crc=True)
 
     # 2 - Create auto FIT with signed images, and verify it
-    utils.run_and_log(ubman, mkimage + ' -fauto' + b_args + s_args + " " +
-                      fit_file)
-
-    fit = SignedFitHelper(ubman, fit_file)
-    if fit.build_nodes_sets() == 0:
-        raise ValueError('FIT-2 has no "/image" nor "/configuration" nodes')
-
-    fit.check_fit_signed_images(key_name, sign_algo, verifier)
-
-    fit.check_fit_loadables(present=False)
+    generate_and_check_fit_image(' -fauto' + b_args + s_args + " " + fit_file,
+                                 simgs=True,
+                                 key_name=key_name, sign_algo=sign_algo, verifier=verifier)
 
     # 3 - Create auto FIT with signed configs and hashed images, and verify it
-    utils.run_and_log(ubman, mkimage + ' -fauto-conf' + b_args + s_args + " " +
-                      fit_file)
-
-    fit = SignedFitHelper(ubman, fit_file)
-    if fit.build_nodes_sets() == 0:
-        raise ValueError('FIT-3 has no "/image" nor "/configuration" nodes')
-
-    fit.check_fit_signed_confgs(key_name, sign_algo)
-
-    fit.check_fit_loadables(present=False)
+    generate_and_check_fit_image(' -fauto-conf' + b_args + s_args + " " + fit_file,
+                                 scfgs=True,
+                                 key_name=key_name, sign_algo=sign_algo)
 
     # Run the same tests as 1/2/3 above, but this time with TFA BL31
     # options -y tfa-bl31.bin -Y 0x12340000 to cover both mkimage with
@@ -226,36 +226,15 @@ def test_fit_auto_signed(ubman):
     b_args = " -d" + kernel_file + " -b" + dt1_file + " -b" + dt2_file + " -y" + tfa_file + " -Y 0x12340000"
 
     # 4 - Create auto FIT with images crc32 checksum, and verify it
-    utils.run_and_log(ubman, mkimage + ' -fauto' + b_args + " " + fit_file)
-
-    fit = SignedFitHelper(ubman, fit_file)
-    if fit.build_nodes_sets() == 0:
-        raise ValueError('FIT-4 has no "/image" nor "/configuration" nodes')
-
-    fit.check_fit_crc32_images()
-
-    fit.check_fit_loadables(present=True)
+    generate_and_check_fit_image(' -fauto' + b_args + " " + fit_file,
+                                 crc=True, bl31present=True)
 
     # 5 - Create auto FIT with signed images, and verify it
-    utils.run_and_log(ubman, mkimage + ' -fauto' + b_args + s_args + " " +
-                      fit_file)
-
-    fit = SignedFitHelper(ubman, fit_file)
-    if fit.build_nodes_sets() == 0:
-        raise ValueError('FIT-5 has no "/image" nor "/configuration" nodes')
-
-    fit.check_fit_signed_images(key_name, sign_algo, verifier)
-
-    fit.check_fit_loadables(present=True)
+    generate_and_check_fit_image(' -fauto' + b_args + s_args + " " + fit_file,
+                                 simgs=True, bl31present=True,
+                                 key_name=key_name, sign_algo=sign_algo, verifier=verifier)
 
     # 6 - Create auto FIT with signed configs and hashed images, and verify it
-    utils.run_and_log(ubman, mkimage + ' -fauto-conf' + b_args + s_args + " " +
-                      fit_file)
-
-    fit = SignedFitHelper(ubman, fit_file)
-    if fit.build_nodes_sets() == 0:
-        raise ValueError('FIT-6 has no "/image" nor "/configuration" nodes')
-
-    fit.check_fit_signed_confgs(key_name, sign_algo)
-
-    fit.check_fit_loadables(present=True)
+    generate_and_check_fit_image(' -fauto-conf' + b_args + s_args + " " + fit_file,
+                                 scfgs=True, bl31present=True,
+                                 key_name=key_name, sign_algo=sign_algo)
-- 
2.51.0

