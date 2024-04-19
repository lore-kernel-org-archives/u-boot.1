Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D030AC4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 06:56:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D1D388684;
	Fri, 19 Apr 2024 08:56:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BF5688684; Fri, 19 Apr 2024 08:56:18 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 3474588010
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 08:56:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DD242F;
 Thu, 18 Apr 2024 23:56:43 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 566CD3F792;
 Thu, 18 Apr 2024 23:56:13 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 4/4] test: capsule: Generate capsules through config file
Date: Fri, 19 Apr 2024 12:25:42 +0530
Message-Id: <20240419065542.1160527-5-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240419065542.1160527-1-sughosh.ganu@linaro.org>
References: <20240419065542.1160527-1-sughosh.ganu@linaro.org>
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

Add logic to generate capsules through a config file while testing the
EFI capsule update functionality. Capsule generation through config
file is enabled on the sandbox variant.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 test/py/tests/test_efi_capsule/capsule_gen_binman.dts | 2 ++
 test/py/tests/test_efi_capsule/conftest.py            | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/test/py/tests/test_efi_capsule/capsule_gen_binman.dts b/test/py/tests/test_efi_capsule/capsule_gen_binman.dts
index 1a62c26047..d1c0067064 100644
--- a/test/py/tests/test_efi_capsule/capsule_gen_binman.dts
+++ b/test/py/tests/test_efi_capsule/capsule_gen_binman.dts
@@ -54,6 +54,7 @@
 		};
 	};
 
+#if !defined(CONFIG_EFI_USE_CAPSULE_CFG_FILE)
 	capsule1 {
 		filename = "Test04";
 		efi-capsule {
@@ -165,4 +166,5 @@
 			};
 		};
 	};
+#endif /* CONFIG_EFI_USE_CAPSULE_CFG_FILE */
 };
diff --git a/test/py/tests/test_efi_capsule/conftest.py b/test/py/tests/test_efi_capsule/conftest.py
index 80b12977d6..b5abd7ab45 100644
--- a/test/py/tests/test_efi_capsule/conftest.py
+++ b/test/py/tests/test_efi_capsule/conftest.py
@@ -88,6 +88,13 @@ def efi_capsule_data(request, u_boot_config):
         check_call('cp %s/Test* %s' % (u_boot_config.build_dir, data_dir), shell=True)
         os.environ['PYTHONPATH'] = pythonpath
 
+        capsule_cfg_file_gen = u_boot_config.buildconfig.get('config_efi_use_capsule_cfg_file')
+        if capsule_cfg_file_gen:
+            cfg_file = u_boot_config.source_dir + '/' +  u_boot_config.buildconfig.get('config_efi_capsule_cfg_file')[1:-1]
+            check_call('cd %s; '
+                       '%s/tools/mkeficapsule -f %s'
+                       % (data_dir, u_boot_config.build_dir, cfg_file), shell=True)
+
         # Create a disk image with EFI system partition
         check_call('virt-make-fs --partition=gpt --size=+1M --type=vfat %s %s' %
                    (mnt_point, image_path), shell=True)
-- 
2.34.1

