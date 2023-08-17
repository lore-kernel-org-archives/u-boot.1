Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 210F0C2FC04
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 05:50:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADC6486A68;
	Thu, 17 Aug 2023 07:49:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D2A686A8E; Thu, 17 Aug 2023 07:49:28 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 89E8286979
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 07:49:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9E5AD75;
 Wed, 16 Aug 2023 22:50:05 -0700 (PDT)
Received: from a076522.blr.arm.com (a076522.blr.arm.com [10.162.46.7])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E4BB3F762;
 Wed, 16 Aug 2023 22:49:22 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 5/6] test: capsule: Remove logic to add public key ESL
Date: Thu, 17 Aug 2023 11:18:55 +0530
Message-Id: <20230817054856.2019253-6-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817054856.2019253-1-sughosh.ganu@linaro.org>
References: <20230817054856.2019253-1-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The public key EFI Signature List(ESL) needed for capsule
authentication is now embedded into the platform's DTB as part of the
build. Remove the superfluous logic from the test setup.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V1: None

 test/py/tests/test_efi_capsule/conftest.py   | 28 +++++---------------
 test/py/tests/test_efi_capsule/signature.dts | 10 -------
 2 files changed, 7 insertions(+), 31 deletions(-)
 delete mode 100644 test/py/tests/test_efi_capsule/signature.dts

diff --git a/test/py/tests/test_efi_capsule/conftest.py b/test/py/tests/test_efi_capsule/conftest.py
index 7eead9bc64..67761a9708 100644
--- a/test/py/tests/test_efi_capsule/conftest.py
+++ b/test/py/tests/test_efi_capsule/conftest.py
@@ -49,33 +49,19 @@ def efi_capsule_data(request, u_boot_config):
             check_call('cp %s/capsule_pub_key_bad.crt %s/SIGNER2.crt'
                        % (key_dir, data_dir), shell=True)
 
-            # Update dtb adding capsule certificate
-            check_call('cd %s; '
-                       'cp %s/test/py/tests/test_efi_capsule/signature.dts .'
-                       % (data_dir, u_boot_config.source_dir), shell=True)
+        if capsule_auth_enabled:
             check_call('cd %s; '
-                       'dtc -@ -I dts -O dtb -o signature.dtbo signature.dts; '
-                       'fdtoverlay -i %s/arch/sandbox/dts/test.dtb '
-                            '-o test_sig.dtb signature.dtbo'
+                       'cp %s/arch/sandbox/dts/test.dtb test_sig.dtb'
                        % (data_dir, u_boot_config.build_dir), shell=True)
-
         # Update dtb to add the version information
         check_call('cd %s; '
                    'cp %s/test/py/tests/test_efi_capsule/version.dts .'
                    % (data_dir, u_boot_config.source_dir), shell=True)
-        if capsule_auth_enabled:
-            check_call('cd %s; '
-                       'dtc -@ -I dts -O dtb -o version.dtbo version.dts; '
-                       'fdtoverlay -i test_sig.dtb '
-                            '-o test_ver.dtb version.dtbo'
-                       % (data_dir), shell=True)
-        else:
-            check_call('cd %s; '
-                       'dtc -@ -I dts -O dtb -o version.dtbo version.dts; '
-                       'fdtoverlay -i %s/arch/sandbox/dts/test.dtb '
-                            '-o test_ver.dtb version.dtbo'
-                       % (data_dir, u_boot_config.build_dir), shell=True)
-
+        check_call('cd %s; '
+                   'dtc -@ -I dts -O dtb -o version.dtbo version.dts; '
+                   'fdtoverlay -i %s/arch/sandbox/dts/test.dtb '
+                   '-o test_ver.dtb version.dtbo'
+                   % (data_dir, u_boot_config.build_dir), shell=True)
 
         check_call('cp %s/u-boot_bin_env.itb %s ' % (u_boot_config.build_dir, data_dir), shell=True)
         check_call('cp %s/Test* %s ' % (u_boot_config.build_dir, data_dir), shell=True)
diff --git a/test/py/tests/test_efi_capsule/signature.dts b/test/py/tests/test_efi_capsule/signature.dts
deleted file mode 100644
index 078cfc76c9..0000000000
--- a/test/py/tests/test_efi_capsule/signature.dts
+++ /dev/null
@@ -1,10 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-
-/dts-v1/;
-/plugin/;
-
-&{/} {
-	signature {
-		capsule-key = /incbin/("SIGNER.esl");
-	};
-};
-- 
2.34.1

