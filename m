Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D150C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 10:49:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F4B988096;
	Wed, 27 Mar 2024 11:49:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF5DF880A1; Wed, 27 Mar 2024 11:49:21 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A98468780A
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 11:49:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32E352F4;
 Wed, 27 Mar 2024 03:49:53 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2BB93F694;
 Wed, 27 Mar 2024 03:49:16 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 2/4] sandbox: capsule: binman: generate some capsules as
 part of build
Date: Wed, 27 Mar 2024 16:19:00 +0530
Message-Id: <20240327104902.905144-3-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327104902.905144-1-sughosh.ganu@linaro.org>
References: <20240327104902.905144-1-sughosh.ganu@linaro.org>
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

Currently, all the capsules for the sandbox platform are generated at
the time of running the capsule tests. To showcase generation of
capsules through binman, generate all raw(non FIT payload) capsules
needed for the sandbox platform as part of the build. This acts as an
illustrative example for generating capsules as part of a platform's
build.

Make corresponding change in the capsule test's configuration to get
these capsules from the build directory.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---

Changes since V1:
* Fix the typo in the commit message about raw capsules being
  generated as part of the build, and not signed capsules.

 arch/sandbox/dts/sandbox.dts                  |   4 +
 arch/sandbox/dts/sandbox_capsule.dtsi         | 169 ++++++++++++++++++
 arch/sandbox/dts/test.dts                     |   4 +
 .../test_efi_capsule/capsule_gen_binman.dts   | 167 +----------------
 test/py/tests/test_efi_capsule/conftest.py    |   1 +
 5 files changed, 185 insertions(+), 160 deletions(-)
 create mode 100644 arch/sandbox/dts/sandbox_capsule.dtsi

diff --git a/arch/sandbox/dts/sandbox.dts b/arch/sandbox/dts/sandbox.dts
index 12d3eff5fa..8392206eea 100644
--- a/arch/sandbox/dts/sandbox.dts
+++ b/arch/sandbox/dts/sandbox.dts
@@ -106,3 +106,7 @@
 #if IS_ENABLED(CONFIG_SUPPORT_VPL)
 #include "sandbox_vpl.dtsi"
 #endif
+
+#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
+#include "sandbox_capsule.dtsi"
+#endif
diff --git a/arch/sandbox/dts/sandbox_capsule.dtsi b/arch/sandbox/dts/sandbox_capsule.dtsi
new file mode 100644
index 0000000000..34d29916b3
--- /dev/null
+++ b/arch/sandbox/dts/sandbox_capsule.dtsi
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Devicetree file with binman nodes needed for generating EFI
+ * capsules.
+ *
+ */
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
+	capsule5 {
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
+	capsule6 {
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
+	capsule7 {
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
+	capsule8 {
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
+	capsule9 {
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
+	capsule10 {
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
+	capsule11 {
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
+};
diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index e264b29554..a012f5c4c9 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -1990,4 +1990,8 @@
 #include "sandbox_vpl.dtsi"
 #endif
 
+#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
+#include "sandbox_capsule.dtsi"
+#endif
+
 #include "cedit.dtsi"
diff --git a/test/py/tests/test_efi_capsule/capsule_gen_binman.dts b/test/py/tests/test_efi_capsule/capsule_gen_binman.dts
index e8a1858509..1a62c26047 100644
--- a/test/py/tests/test_efi_capsule/capsule_gen_binman.dts
+++ b/test/py/tests/test_efi_capsule/capsule_gen_binman.dts
@@ -55,42 +55,6 @@
 	};
 
 	capsule1 {
-		filename = "Test01";
-		efi-capsule {
-			image-index = <0x1>;
-			image-guid = SANDBOX_UBOOT_IMAGE_GUID;
-
-			text {
-				text = "u-boot:New";
-			};
-		};
-	};
-
-	capsule2 {
-		filename = "Test02";
-		efi-capsule {
-			image-index = <0x2>;
-			image-guid = SANDBOX_UBOOT_ENV_IMAGE_GUID;
-
-			text {
-				text = "u-boot-env:New";
-			};
-		};
-	};
-
-	capsule3 {
-		filename = "Test03";
-		efi-capsule {
-			image-index = <0x1>;
-			image-guid = SANDBOX_INCORRECT_GUID;
-
-			text {
-				text = "u-boot:New";
-			};
-		};
-	};
-
-	capsule4 {
 		filename = "Test04";
 		efi-capsule {
 			image-index = <0x1>;
@@ -102,7 +66,7 @@
 		};
 	};
 
-	capsule5 {
+	capsule2 {
 		filename = "Test05";
 		efi-capsule {
 			image-index = <0x1>;
@@ -114,46 +78,7 @@
 		};
 	};
 
-	capsule6 {
-		filename = "Test101";
-		efi-capsule {
-			image-index = <0x1>;
-			fw-version = <0x5>;
-			image-guid = SANDBOX_UBOOT_IMAGE_GUID;
-
-			text {
-				text = "u-boot:New";
-			};
-		};
-	};
-
-	capsule7 {
-		filename = "Test102";
-		efi-capsule {
-			image-index = <0x2>;
-			fw-version = <0xa>;
-			image-guid = SANDBOX_UBOOT_ENV_IMAGE_GUID;
-
-			text {
-				text = "u-boot-env:New";
-			};
-		};
-	};
-
-	capsule8 {
-		filename = "Test103";
-		efi-capsule {
-			image-index = <0x1>;
-			fw-version = <0x2>;
-			image-guid = SANDBOX_UBOOT_IMAGE_GUID;
-
-			text {
-				text = "u-boot:New";
-			};
-		};
-	};
-
-	capsule9 {
+	capsule3 {
 		filename = "Test104";
 		efi-capsule {
 			image-index = <0x1>;
@@ -166,7 +91,7 @@
 		};
 	};
 
-	capsule10 {
+	capsule4 {
 		filename = "Test105";
 		efi-capsule {
 			image-index = <0x1>;
@@ -179,37 +104,7 @@
 		};
 	};
 
-	capsule11 {
-		filename = "Test11";
-		efi-capsule {
-			image-index = <0x1>;
-			image-guid = SANDBOX_UBOOT_IMAGE_GUID;
-			private-key = CAPSULE_PRIV_KEY;
-			public-key-cert = CAPSULE_PUB_KEY;
-			monotonic-count = <0x1>;
-
-			text {
-				text = "u-boot:New";
-			};
-		};
-	};
-
-	capsule12 {
-		filename = "Test12";
-		efi-capsule {
-			image-index = <0x1>;
-			image-guid = SANDBOX_UBOOT_IMAGE_GUID;
-			private-key = CAPSULE_INVAL_KEY;
-			public-key-cert = CAPSULE_INVAL_PUB_KEY;
-			monotonic-count = <0x1>;
-
-			text {
-				text = "u-boot:New";
-			};
-		};
-	};
-
-	capsule13 {
+	capsule5 {
 		filename = "Test13";
 		efi-capsule {
 			image-index = <0x1>;
@@ -224,7 +119,7 @@
 		};
 	};
 
-	capsule14 {
+	capsule6 {
 		filename = "Test14";
 		efi-capsule {
 			image-index = <0x1>;
@@ -239,55 +134,7 @@
 		};
 	};
 
-	capsule15 {
-		filename = "Test111";
-		efi-capsule {
-			image-index = <0x1>;
-			fw-version = <0x5>;
-			image-guid = SANDBOX_UBOOT_IMAGE_GUID;
-			private-key = CAPSULE_PRIV_KEY;
-			public-key-cert = CAPSULE_PUB_KEY;
-			monotonic-count = <0x1>;
-
-			text {
-				text = "u-boot:New";
-			};
-		};
-	};
-
-	capsule16 {
-		filename = "Test112";
-		efi-capsule {
-			image-index = <0x2>;
-			fw-version = <0xa>;
-			image-guid = SANDBOX_UBOOT_ENV_IMAGE_GUID;
-			private-key = CAPSULE_PRIV_KEY;
-			public-key-cert = CAPSULE_PUB_KEY;
-			monotonic-count = <0x1>;
-
-			text {
-				text = "u-boot-env:New";
-			};
-		};
-	};
-
-	capsule17 {
-		filename = "Test113";
-		efi-capsule {
-			image-index = <0x1>;
-			fw-version = <0x2>;
-			image-guid = SANDBOX_UBOOT_IMAGE_GUID;
-			private-key = CAPSULE_PRIV_KEY;
-			public-key-cert = CAPSULE_PUB_KEY;
-			monotonic-count = <0x1>;
-
-			text {
-				text = "u-boot:New";
-			};
-		};
-	};
-
-	capsule18 {
+	capsule7 {
 		filename = "Test114";
 		efi-capsule {
 			image-index = <0x1>;
@@ -303,7 +150,7 @@
 		};
 	};
 
-	capsule19 {
+	capsule8 {
 		filename = "Test115";
 		efi-capsule {
 			image-index = <0x1>;
diff --git a/test/py/tests/test_efi_capsule/conftest.py b/test/py/tests/test_efi_capsule/conftest.py
index dd41da9284..80b12977d6 100644
--- a/test/py/tests/test_efi_capsule/conftest.py
+++ b/test/py/tests/test_efi_capsule/conftest.py
@@ -85,6 +85,7 @@ def efi_capsule_data(request, u_boot_config):
         check_call('cd %s; '
                    './tools/binman/binman --toolpath %s/tools build -u -d %s/capsule_binman.dtb -O %s -m --allow-missing -I %s -I ./board/sandbox -I ./arch/sandbox/dts'
                    % (u_boot_config.source_dir, u_boot_config.build_dir, data_dir, data_dir, data_dir), shell=True)
+        check_call('cp %s/Test* %s' % (u_boot_config.build_dir, data_dir), shell=True)
         os.environ['PYTHONPATH'] = pythonpath
 
         # Create a disk image with EFI system partition
-- 
2.34.1

