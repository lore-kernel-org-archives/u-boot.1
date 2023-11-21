Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F93C54FB9
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 07:01:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3233987585;
	Tue, 21 Nov 2023 08:01:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AEC58757E; Tue, 21 Nov 2023 08:01:01 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E68BF867E2
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 08:00:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1C05FEC;
 Mon, 20 Nov 2023 23:01:44 -0800 (PST)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 312703F7CE;
 Mon, 20 Nov 2023 23:00:55 -0800 (PST)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 4/4] test: capsule: Generate capsules through config file
Date: Tue, 21 Nov 2023 12:30:28 +0530
Message-Id: <20231121070028.2614095-5-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121070028.2614095-1-sughosh.ganu@linaro.org>
References: <20231121070028.2614095-1-sughosh.ganu@linaro.org>
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
index e8a1858509..c4e9ebac46 100644
--- a/test/py/tests/test_efi_capsule/capsule_gen_binman.dts
+++ b/test/py/tests/test_efi_capsule/capsule_gen_binman.dts
@@ -54,6 +54,7 @@
 		};
 	};
 
+#if !defined(CONFIG_EFI_USE_CAPSULE_CFG_FILE)
 	capsule1 {
 		filename = "Test01";
 		efi-capsule {
@@ -319,3 +320,4 @@
 		};
 	};
 };
+#endif /* CONFIG_EFI_USE_CAPSULE_CFG_FILE */
diff --git a/test/py/tests/test_efi_capsule/conftest.py b/test/py/tests/test_efi_capsule/conftest.py
index dd41da9284..d3702180ef 100644
--- a/test/py/tests/test_efi_capsule/conftest.py
+++ b/test/py/tests/test_efi_capsule/conftest.py
@@ -87,6 +87,13 @@ def efi_capsule_data(request, u_boot_config):
                    % (u_boot_config.source_dir, u_boot_config.build_dir, data_dir, data_dir, data_dir), shell=True)
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

