Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E52FEE49AF
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 17:41:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64447864B3;
	Tue, 22 Aug 2023 19:40:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F757864D8; Tue, 22 Aug 2023 19:40:58 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id BF6C1864DB
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 19:40:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 069AA11FB;
 Tue, 22 Aug 2023 10:41:35 -0700 (PDT)
Received: from a076522.blr.arm.com (a076522.blr.arm.com [10.162.46.7])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A908D3F762;
 Tue, 22 Aug 2023 10:40:51 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v11 07/15] test: capsule: Generate EFI capsules through binman
Date: Tue, 22 Aug 2023 23:10:00 +0530
Message-Id: <20230822174008.626239-8-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822174008.626239-1-sughosh.ganu@linaro.org>
References: <20230822174008.626239-1-sughosh.ganu@linaro.org>
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

Support has been added for generating the EFI capsules through
binman. Make changes in the EFI capsule update testing feature to
generate capsules through binman.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V10:
* Remove the sandbox_capsule.dtsi file.
* Remove addition of multiple-images property from sandbox.dts and
  test.dts as the capsule generation is moved to the test.
* Add the capsule_gen_binman.dts with binman nodes for capsule
  generation.
* Call the binman tool as part of the capsule test setup for
  generation of capsules.

 include/sandbox_efi_capsule.h                 |  21 ++
 .../test_efi_capsule/capsule_gen_binman.dts   | 321 ++++++++++++++++++
 test/py/tests/test_efi_capsule/conftest.py    | 163 ++-------
 .../tests/test_efi_capsule/uboot_bin_env.its  |  36 --
 4 files changed, 367 insertions(+), 174 deletions(-)
 create mode 100644 include/sandbox_efi_capsule.h
 create mode 100644 test/py/tests/test_efi_capsule/capsule_gen_binman.dts
 delete mode 100644 test/py/tests/test_efi_capsule/uboot_bin_env.its

diff --git a/include/sandbox_efi_capsule.h b/include/sandbox_efi_capsule.h
new file mode 100644
index 0000000000..3e288e8a84
--- /dev/null
+++ b/include/sandbox_efi_capsule.h
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#if !defined(_SANDBOX_EFI_CAPSULE_H_)
+#define _SANDBOX_EFI_CAPSULE_H_
+
+#define SANDBOX_UBOOT_IMAGE_GUID	"09d7cf52-0720-4710-91d1-08469b7fe9c8"
+#define SANDBOX_UBOOT_ENV_IMAGE_GUID	"5a7021f5-fef2-48b4-aaba-832e777418c0"
+#define SANDBOX_FIT_IMAGE_GUID		"3673b45d-6a7c-46f3-9e60-adabb03f7937"
+#define SANDBOX_INCORRECT_GUID		"058b7d83-50d5-4c47-a195-60d86ad341c4"
+
+#define UBOOT_FIT_IMAGE			"u-boot_bin_env.itb"
+
+#define CAPSULE_PRIV_KEY		"capsule_priv_key_good.key"
+#define CAPSULE_PUB_KEY			"capsule_pub_key_good.crt"
+#define CAPSULE_INVAL_KEY		"capsule_priv_key_bad.key"
+#define CAPSULE_INVAL_PUB_KEY		"capsule_pub_key_bad.crt"
+
+#endif /* _SANDBOX_EFI_CAPSULE_H_ */
diff --git a/test/py/tests/test_efi_capsule/capsule_gen_binman.dts b/test/py/tests/test_efi_capsule/capsule_gen_binman.dts
new file mode 100644
index 0000000000..e8a1858509
--- /dev/null
+++ b/test/py/tests/test_efi_capsule/capsule_gen_binman.dts
@@ -0,0 +1,321 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Devicetree for capsule generation through binman
+ */
+
+/dts-v1/;
+
+#include <sandbox_efi_capsule.h>
+
+/ {
+	binman: binman {
+		multiple-images;
+	};
+};
+
+&binman {
+	itb {
+		filename = UBOOT_FIT_IMAGE;
+
+		fit {
+			description = "Automatic U-Boot environment update";
+			#address-cells = <2>;
+
+			images {
+				u-boot-bin {
+					description = "U-Boot binary on SPI Flash";
+					compression = "none";
+					type = "firmware";
+					arch = "sandbox";
+					load = <0>;
+					text {
+						text = "u-boot:New";
+					};
+
+					hash-1 {
+						algo = "sha1";
+					};
+				};
+				u-boot-env {
+					description = "U-Boot environment on SPI Flash";
+					compression = "none";
+					type = "firmware";
+					arch = "sandbox";
+					load = <0>;
+					text {
+						text = "u-boot-env:New";
+					};
+
+					hash-1 {
+						algo = "sha1";
+					};
+				};
+			};
+		};
+	};
+
+	capsule1 {
+		filename = "Test01";
+		efi-capsule {
+			image-index = <0x1>;
+			image-guid = SANDBOX_UBOOT_IMAGE_GUID;
+
+			text {
+				text = "u-boot:New";
+			};
+		};
+	};
+
+	capsule2 {
+		filename = "Test02";
+		efi-capsule {
+			image-index = <0x2>;
+			image-guid = SANDBOX_UBOOT_ENV_IMAGE_GUID;
+
+			text {
+				text = "u-boot-env:New";
+			};
+		};
+	};
+
+	capsule3 {
+		filename = "Test03";
+		efi-capsule {
+			image-index = <0x1>;
+			image-guid = SANDBOX_INCORRECT_GUID;
+
+			text {
+				text = "u-boot:New";
+			};
+		};
+	};
+
+	capsule4 {
+		filename = "Test04";
+		efi-capsule {
+			image-index = <0x1>;
+			image-guid = SANDBOX_FIT_IMAGE_GUID;
+
+			blob {
+				filename = UBOOT_FIT_IMAGE;
+			};
+		};
+	};
+
+	capsule5 {
+		filename = "Test05";
+		efi-capsule {
+			image-index = <0x1>;
+			image-guid = SANDBOX_INCORRECT_GUID;
+
+			blob {
+				filename = UBOOT_FIT_IMAGE;
+			};
+		};
+	};
+
+	capsule6 {
+		filename = "Test101";
+		efi-capsule {
+			image-index = <0x1>;
+			fw-version = <0x5>;
+			image-guid = SANDBOX_UBOOT_IMAGE_GUID;
+
+			text {
+				text = "u-boot:New";
+			};
+		};
+	};
+
+	capsule7 {
+		filename = "Test102";
+		efi-capsule {
+			image-index = <0x2>;
+			fw-version = <0xa>;
+			image-guid = SANDBOX_UBOOT_ENV_IMAGE_GUID;
+
+			text {
+				text = "u-boot-env:New";
+			};
+		};
+	};
+
+	capsule8 {
+		filename = "Test103";
+		efi-capsule {
+			image-index = <0x1>;
+			fw-version = <0x2>;
+			image-guid = SANDBOX_UBOOT_IMAGE_GUID;
+
+			text {
+				text = "u-boot:New";
+			};
+		};
+	};
+
+	capsule9 {
+		filename = "Test104";
+		efi-capsule {
+			image-index = <0x1>;
+			fw-version = <0x5>;
+			image-guid = SANDBOX_FIT_IMAGE_GUID;
+
+			blob {
+				filename = UBOOT_FIT_IMAGE;
+			};
+		};
+	};
+
+	capsule10 {
+		filename = "Test105";
+		efi-capsule {
+			image-index = <0x1>;
+			fw-version = <0x2>;
+			image-guid = SANDBOX_FIT_IMAGE_GUID;
+
+			blob {
+				filename = UBOOT_FIT_IMAGE;
+			};
+		};
+	};
+
+	capsule11 {
+		filename = "Test11";
+		efi-capsule {
+			image-index = <0x1>;
+			image-guid = SANDBOX_UBOOT_IMAGE_GUID;
+			private-key = CAPSULE_PRIV_KEY;
+			public-key-cert = CAPSULE_PUB_KEY;
+			monotonic-count = <0x1>;
+
+			text {
+				text = "u-boot:New";
+			};
+		};
+	};
+
+	capsule12 {
+		filename = "Test12";
+		efi-capsule {
+			image-index = <0x1>;
+			image-guid = SANDBOX_UBOOT_IMAGE_GUID;
+			private-key = CAPSULE_INVAL_KEY;
+			public-key-cert = CAPSULE_INVAL_PUB_KEY;
+			monotonic-count = <0x1>;
+
+			text {
+				text = "u-boot:New";
+			};
+		};
+	};
+
+	capsule13 {
+		filename = "Test13";
+		efi-capsule {
+			image-index = <0x1>;
+			image-guid = SANDBOX_FIT_IMAGE_GUID;
+			private-key = CAPSULE_PRIV_KEY;
+			public-key-cert = CAPSULE_PUB_KEY;
+			monotonic-count = <0x1>;
+
+			blob {
+				filename = UBOOT_FIT_IMAGE;
+			};
+		};
+	};
+
+	capsule14 {
+		filename = "Test14";
+		efi-capsule {
+			image-index = <0x1>;
+			image-guid = SANDBOX_FIT_IMAGE_GUID;
+			private-key = CAPSULE_INVAL_KEY;
+			public-key-cert = CAPSULE_INVAL_PUB_KEY;
+			monotonic-count = <0x1>;
+
+			blob {
+				filename = UBOOT_FIT_IMAGE;
+			};
+		};
+	};
+
+	capsule15 {
+		filename = "Test111";
+		efi-capsule {
+			image-index = <0x1>;
+			fw-version = <0x5>;
+			image-guid = SANDBOX_UBOOT_IMAGE_GUID;
+			private-key = CAPSULE_PRIV_KEY;
+			public-key-cert = CAPSULE_PUB_KEY;
+			monotonic-count = <0x1>;
+
+			text {
+				text = "u-boot:New";
+			};
+		};
+	};
+
+	capsule16 {
+		filename = "Test112";
+		efi-capsule {
+			image-index = <0x2>;
+			fw-version = <0xa>;
+			image-guid = SANDBOX_UBOOT_ENV_IMAGE_GUID;
+			private-key = CAPSULE_PRIV_KEY;
+			public-key-cert = CAPSULE_PUB_KEY;
+			monotonic-count = <0x1>;
+
+			text {
+				text = "u-boot-env:New";
+			};
+		};
+	};
+
+	capsule17 {
+		filename = "Test113";
+		efi-capsule {
+			image-index = <0x1>;
+			fw-version = <0x2>;
+			image-guid = SANDBOX_UBOOT_IMAGE_GUID;
+			private-key = CAPSULE_PRIV_KEY;
+			public-key-cert = CAPSULE_PUB_KEY;
+			monotonic-count = <0x1>;
+
+			text {
+				text = "u-boot:New";
+			};
+		};
+	};
+
+	capsule18 {
+		filename = "Test114";
+		efi-capsule {
+			image-index = <0x1>;
+			fw-version = <0x5>;
+			image-guid = SANDBOX_FIT_IMAGE_GUID;
+			private-key = CAPSULE_PRIV_KEY;
+			public-key-cert = CAPSULE_PUB_KEY;
+			monotonic-count = <0x1>;
+
+			blob {
+				filename = UBOOT_FIT_IMAGE;
+			};
+		};
+	};
+
+	capsule19 {
+		filename = "Test115";
+		efi-capsule {
+			image-index = <0x1>;
+			fw-version = <0x2>;
+			image-guid = SANDBOX_FIT_IMAGE_GUID;
+			private-key = CAPSULE_PRIV_KEY;
+			public-key-cert = CAPSULE_PUB_KEY;
+			monotonic-count = <0x1>;
+
+			blob {
+				filename = UBOOT_FIT_IMAGE;
+			};
+		};
+	};
+};
diff --git a/test/py/tests/test_efi_capsule/conftest.py b/test/py/tests/test_efi_capsule/conftest.py
index 054be1ee97..9160f294e6 100644
--- a/test/py/tests/test_efi_capsule/conftest.py
+++ b/test/py/tests/test_efi_capsule/conftest.py
@@ -4,6 +4,8 @@
 
 """Fixture for UEFI capsule test."""
 
+import os
+
 from subprocess import call, check_call, CalledProcessError
 import pytest
 from capsule_defs import CAPSULE_DATA_DIR, CAPSULE_INSTALL_DIR, EFITOOLS_PATH
@@ -34,15 +36,20 @@ def efi_capsule_data(request, u_boot_config):
 
         capsule_auth_enabled = u_boot_config.buildconfig.get(
                     'config_efi_capsule_authenticate')
+        key_dir = u_boot_config.source_dir + '/board/sandbox'
         if capsule_auth_enabled:
-            # Create private key (SIGNER.key) and certificate (SIGNER.crt)
-            check_call('cd %s; '
-                       'openssl req -x509 -sha256 -newkey rsa:2048 '
-                            '-subj /CN=TEST_SIGNER/ -keyout SIGNER.key '
-                            '-out SIGNER.crt -nodes -days 365'
-                       % data_dir, shell=True)
-            check_call('cd %s; %scert-to-efi-sig-list SIGNER.crt SIGNER.esl'
-                       % (data_dir, EFITOOLS_PATH), shell=True)
+            # Get the keys from the board directory
+            check_call('cp %s/capsule_priv_key_good.key %s/SIGNER.key'
+                       % (key_dir, data_dir), shell=True)
+            check_call('cp %s/capsule_pub_key_good.crt %s/SIGNER.crt'
+                       % (key_dir, data_dir), shell=True)
+            check_call('cp %s/capsule_pub_esl_good.esl %s/SIGNER.esl'
+                       % (key_dir, data_dir), shell=True)
+
+            check_call('cp %s/capsule_priv_key_bad.key %s/SIGNER2.key'
+                       % (key_dir, data_dir), shell=True)
+            check_call('cp %s/capsule_pub_key_bad.crt %s/SIGNER2.crt'
+                       % (key_dir, data_dir), shell=True)
 
             # Update dtb adding capsule certificate
             check_call('cd %s; '
@@ -54,14 +61,6 @@ def efi_capsule_data(request, u_boot_config):
                             '-o test_sig.dtb signature.dtbo'
                        % (data_dir, u_boot_config.build_dir), shell=True)
 
-            # Create *malicious* private key (SIGNER2.key) and certificate
-            # (SIGNER2.crt)
-            check_call('cd %s; '
-                       'openssl req -x509 -sha256 -newkey rsa:2048 '
-                            '-subj /CN=TEST_SIGNER/ -keyout SIGNER2.key '
-                            '-out SIGNER2.crt -nodes -days 365'
-                       % data_dir, shell=True)
-
         # Update dtb to add the version information
         check_call('cd %s; '
                    'cp %s/test/py/tests/test_efi_capsule/version.dts .'
@@ -79,132 +78,20 @@ def efi_capsule_data(request, u_boot_config):
                             '-o test_ver.dtb version.dtbo'
                        % (data_dir, u_boot_config.build_dir), shell=True)
 
-        # Create capsule files
         # two regions: one for u-boot.bin and the other for u-boot.env
         check_call('cd %s; echo -n u-boot:Old > u-boot.bin.old; echo -n u-boot:New > u-boot.bin.new; echo -n u-boot-env:Old > u-boot.env.old; echo -n u-boot-env:New > u-boot.env.new' % data_dir,
                    shell=True)
-        check_call('sed -e \"s?BINFILE1?u-boot.bin.new?\" -e \"s?BINFILE2?u-boot.env.new?\" %s/test/py/tests/test_efi_capsule/uboot_bin_env.its > %s/uboot_bin_env.its' %
-                   (u_boot_config.source_dir, data_dir),
-                   shell=True)
-        check_call('cd %s; %s/tools/mkimage -f uboot_bin_env.its uboot_bin_env.itb' %
-                   (data_dir, u_boot_config.build_dir),
-                   shell=True)
-        check_call('cd %s; %s/tools/mkeficapsule --index 1 --guid 09D7CF52-0720-4710-91D1-08469B7FE9C8 u-boot.bin.new Test01' %
-                   (data_dir, u_boot_config.build_dir),
-                   shell=True)
-        check_call('cd %s; %s/tools/mkeficapsule --index 2 --guid 5A7021F5-FEF2-48B4-AABA-832E777418C0 u-boot.env.new Test02' %
-                   (data_dir, u_boot_config.build_dir),
-                   shell=True)
-        check_call('cd %s; %s/tools/mkeficapsule --index 1 --guid 058B7D83-50D5-4C47-A195-60D86AD341C4 u-boot.bin.new Test03' %
-                   (data_dir, u_boot_config.build_dir),
-                   shell=True)
-        check_call('cd %s; %s/tools/mkeficapsule --index 1 --guid 3673B45D-6A7C-46F3-9E60-ADABB03F7937 uboot_bin_env.itb Test04' %
-                   (data_dir, u_boot_config.build_dir),
-                   shell=True)
-        check_call('cd %s; %s/tools/mkeficapsule --index 1 --guid  058B7D83-50D5-4C47-A195-60D86AD341C4 uboot_bin_env.itb Test05' %
-                   (data_dir, u_boot_config.build_dir),
-                   shell=True)
-        check_call('cd %s; %s/tools/mkeficapsule --index 1 --fw-version 5 '
-                        '--guid 09D7CF52-0720-4710-91D1-08469B7FE9C8 u-boot.bin.new Test101' %
-                   (data_dir, u_boot_config.build_dir),
-                   shell=True)
-        check_call('cd %s; %s/tools/mkeficapsule --index 2 --fw-version 10 '
-                        '--guid 5A7021F5-FEF2-48B4-AABA-832E777418C0 u-boot.env.new Test102' %
-                   (data_dir, u_boot_config.build_dir),
-                   shell=True)
-        check_call('cd %s; %s/tools/mkeficapsule --index 1 --fw-version 2 '
-                        '--guid 09D7CF52-0720-4710-91D1-08469B7FE9C8 u-boot.bin.new Test103' %
-                   (data_dir, u_boot_config.build_dir),
-                   shell=True)
-        check_call('cd %s; %s/tools/mkeficapsule --index 1 --fw-version 5 '
-                        '--guid 3673B45D-6A7C-46F3-9E60-ADABB03F7937 uboot_bin_env.itb Test104' %
-                   (data_dir, u_boot_config.build_dir),
-                   shell=True)
-        check_call('cd %s; %s/tools/mkeficapsule --index 1 --fw-version 2 '
-                        '--guid 3673B45D-6A7C-46F3-9E60-ADABB03F7937 uboot_bin_env.itb Test105' %
-                   (data_dir, u_boot_config.build_dir),
-                   shell=True)
 
-        if capsule_auth_enabled:
-            # raw firmware signed with proper key
-            check_call('cd %s; '
-                       '%s/tools/mkeficapsule --index 1 --monotonic-count 1 '
-                            '--private-key SIGNER.key --certificate SIGNER.crt '
-                            '--guid 09D7CF52-0720-4710-91D1-08469B7FE9C8 '
-                            'u-boot.bin.new Test11'
-                       % (data_dir, u_boot_config.build_dir),
-                       shell=True)
-            # raw firmware signed with *mal* key
-            check_call('cd %s; '
-                       '%s/tools/mkeficapsule --index 1 --monotonic-count 1 '
-                            '--private-key SIGNER2.key '
-                            '--certificate SIGNER2.crt '
-                            '--guid 09D7CF52-0720-4710-91D1-08469B7FE9C8 '
-                            'u-boot.bin.new Test12'
-                       % (data_dir, u_boot_config.build_dir),
-                       shell=True)
-            # FIT firmware signed with proper key
-            check_call('cd %s; '
-                       '%s/tools/mkeficapsule --index 1 --monotonic-count 1 '
-                            '--private-key SIGNER.key --certificate SIGNER.crt '
-                            '--guid 3673B45D-6A7C-46F3-9E60-ADABB03F7937 '
-                            'uboot_bin_env.itb Test13'
-                       % (data_dir, u_boot_config.build_dir),
-                       shell=True)
-            # FIT firmware signed with *mal* key
-            check_call('cd %s; '
-                       '%s/tools/mkeficapsule --index 1 --monotonic-count 1 '
-                            '--private-key SIGNER2.key '
-                            '--certificate SIGNER2.crt '
-                            '--guid 3673B45D-6A7C-46F3-9E60-ADABB03F7937 '
-                            'uboot_bin_env.itb Test14'
-                       % (data_dir, u_boot_config.build_dir),
-                       shell=True)
-            # raw firmware signed with proper key with version information
-            check_call('cd %s; '
-                       '%s/tools/mkeficapsule --index 1 --monotonic-count 1 '
-                            '--fw-version 5 '
-                            '--private-key SIGNER.key --certificate SIGNER.crt '
-                            '--guid 09D7CF52-0720-4710-91D1-08469B7FE9C8 '
-                            'u-boot.bin.new Test111'
-                       % (data_dir, u_boot_config.build_dir),
-                       shell=True)
-            # raw firmware signed with proper key with version information
-            check_call('cd %s; '
-                       '%s/tools/mkeficapsule --index 2 --monotonic-count 1 '
-                            '--fw-version 10 '
-                            '--private-key SIGNER.key --certificate SIGNER.crt '
-                            '--guid 5A7021F5-FEF2-48B4-AABA-832E777418C0 '
-                            'u-boot.env.new Test112'
-                       % (data_dir, u_boot_config.build_dir),
-                       shell=True)
-            # raw firmware signed with proper key with lower version information
-            check_call('cd %s; '
-                       '%s/tools/mkeficapsule --index 1 --monotonic-count 1 '
-                            '--fw-version 2 '
-                            '--private-key SIGNER.key --certificate SIGNER.crt '
-                            '--guid 09D7CF52-0720-4710-91D1-08469B7FE9C8 '
-                            'u-boot.bin.new Test113'
-                       % (data_dir, u_boot_config.build_dir),
-                       shell=True)
-            # FIT firmware signed with proper key with version information
-            check_call('cd %s; '
-                       '%s/tools/mkeficapsule --index 1 --monotonic-count 1 '
-                            '--fw-version 5 '
-                            '--private-key SIGNER.key --certificate SIGNER.crt '
-                            '--guid 3673B45D-6A7C-46F3-9E60-ADABB03F7937 '
-                            'uboot_bin_env.itb Test114'
-                       % (data_dir, u_boot_config.build_dir),
-                       shell=True)
-            # FIT firmware signed with proper key with lower version information
-            check_call('cd %s; '
-                       '%s/tools/mkeficapsule --index 1 --monotonic-count 1 '
-                            '--fw-version 2 '
-                            '--private-key SIGNER.key --certificate SIGNER.crt '
-                            '--guid 3673B45D-6A7C-46F3-9E60-ADABB03F7937 '
-                            'uboot_bin_env.itb Test115'
-                       % (data_dir, u_boot_config.build_dir),
-                       shell=True)
+        pythonpath = os.environ.get('PYTHONPATH', '')
+        os.environ['PYTHONPATH'] = pythonpath + ':' + '%s/scripts/dtc/pylibfdt' % u_boot_config.build_dir
+        check_call('cd %s; '
+                   'cc -E -I %s/include -x assembler-with-cpp -o capsule_gen_tmp.dts %s/test/py/tests/test_efi_capsule/capsule_gen_binman.dts; '
+                   'dtc -I dts -O dtb capsule_gen_tmp.dts -o capsule_binman.dtb;'
+                   % (data_dir, u_boot_config.source_dir, u_boot_config.source_dir), shell=True)
+        check_call('cd %s; '
+                   './tools/binman/binman --toolpath %s/tools build -u -d %s/capsule_binman.dtb -O %s -m --allow-missing -I %s -I ./board/sandbox -I ./arch/sandbox/dts'
+                   % (u_boot_config.source_dir, u_boot_config.build_dir, data_dir, data_dir, data_dir), shell=True)
+        os.environ['PYTHONPATH'] = pythonpath
 
         # Create a disk image with EFI system partition
         check_call('virt-make-fs --partition=gpt --size=+1M --type=vfat %s %s' %
diff --git a/test/py/tests/test_efi_capsule/uboot_bin_env.its b/test/py/tests/test_efi_capsule/uboot_bin_env.its
deleted file mode 100644
index fc65907481..0000000000
--- a/test/py/tests/test_efi_capsule/uboot_bin_env.its
+++ /dev/null
@@ -1,36 +0,0 @@
-/*
- * Automatic software update for U-Boot
- * Make sure the flashing addresses ('load' prop) is correct for your board!
- */
-
-/dts-v1/;
-
-/ {
-	description = "Automatic U-Boot environment update";
-	#address-cells = <2>;
-
-	images {
-		u-boot-bin {
-			description = "U-Boot binary on SPI Flash";
-			data = /incbin/("BINFILE1");
-			compression = "none";
-			type = "firmware";
-			arch = "sandbox";
-			load = <0>;
-			hash-1 {
-				algo = "sha1";
-			};
-		};
-		u-boot-env {
-			description = "U-Boot environment on SPI Flash";
-			data = /incbin/("BINFILE2");
-			compression = "none";
-			type = "firmware";
-			arch = "sandbox";
-			load = <0>;
-			hash-1 {
-				algo = "sha1";
-			};
-		};
-	};
-};
-- 
2.34.1

