Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD7EE7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 06:37:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A90718031D;
	Wed,  1 Jan 2025 07:37:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 637DF8036B; Wed,  1 Jan 2025 07:37:23 +0100 (CET)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 404318021A
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 07:37:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from hay.lan. (unknown
 [IPv6:2605:59c8:31de:bf00:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 4DE78B4B3464;
 Wed,  1 Jan 2025 07:37:19 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>
Cc: E Shattow <e@freeshell.de>,
	u-boot@lists.denx.de
Subject: [PATCH v1] riscv: dts: starfive: split out visionfive2 target
 specific configuration
Date: Tue, 31 Dec 2024 22:35:57 -0800
Message-ID: <20250101063610.260296-1-e@freeshell.de>
X-Mailer: git-send-email 2.45.2
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

Split out StarFive VisionFive2 multi-board target specific configuration
into starfive-visionfive2-binman.dtsi in preparation for removal of
jh7110-u-boot and jh7110-common-u-boot in part or whole as sent upstream.

Signed-off-by: E Shattow <e@freeshell.de>
---
 arch/riscv/dts/jh7110-common-u-boot.dtsi      |  95 ----------------
 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi  |   1 +
 .../dts/jh7110-pine64-star64-u-boot.dtsi      |   1 +
 ...10-starfive-visionfive-2-v1.2a-u-boot.dtsi |   1 +
 ...10-starfive-visionfive-2-v1.3b-u-boot.dtsi |   1 +
 .../dts/starfive-visionfive2-binman.dtsi      | 102 ++++++++++++++++++
 6 files changed, 106 insertions(+), 95 deletions(-)
 create mode 100644 arch/riscv/dts/starfive-visionfive2-binman.dtsi

diff --git a/arch/riscv/dts/jh7110-common-u-boot.dtsi b/arch/riscv/dts/jh7110-common-u-boot.dtsi
index 7871294e90d..6d85b2d91a7 100644
--- a/arch/riscv/dts/jh7110-common-u-boot.dtsi
+++ b/arch/riscv/dts/jh7110-common-u-boot.dtsi
@@ -3,7 +3,6 @@
  * Copyright (C) 2023 StarFive Technology Co., Ltd.
  */
 
-#include "binman.dtsi"
 #include "jh7110-u-boot.dtsi"
 / {
 	aliases {
@@ -19,11 +18,6 @@
 		bootph-pre-ram;
 	};
 
-	config {
-		bootph-pre-ram;
-		u-boot,spl-payload-offset = <0x100000>;
-	};
-
 	memory@40000000 {
 		bootph-pre-ram;
 	};
@@ -104,92 +98,3 @@
 		pagesize = <16>;
 	};
 };
-
-&binman {
-	itb {
-		fit {
-			images {
-				fdt-jh7110-milkv-mars {
-					description = "jh7110-milkv-mars";
-					load = <0x40400000>;
-					compression = "none";
-
-					blob-ext {
-						filename = "dts/upstream/src/riscv/starfive/jh7110-milkv-mars.dtb";
-					};
-				};
-
-				fdt-jh7110-pine64-star64 {
-					description = "jh7110-pine64-star64";
-					load = <0x40400000>;
-					compression = "none";
-
-					blob-ext {
-						filename = "dts/upstream/src/riscv/starfive/jh7110-pine64-star64.dtb";
-					};
-				};
-
-				fdt-jh7110-starfive-visionfive-2-v1.2a {
-					description = "jh7110-starfive-visionfive-2-v1.2a";
-					load = <0x40400000>;
-					compression = "none";
-
-					blob-ext {
-						filename = "dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2-v1.2a.dtb";
-					};
-				};
-
-				fdt-jh7110-starfive-visionfive-2-v1.3b {
-					description = "jh7110-starfive-visionfive-2-v1.3b";
-					load = <0x40400000>;
-					compression = "none";
-
-					blob-ext {
-						filename = "dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2-v1.3b.dtb";
-					};
-				};
-			};
-
-			configurations {
-				conf-jh7110-milkv-mars {
-					description = "jh7110-milkv-mars";
-					firmware = "opensbi";
-					loadables = "uboot";
-					fdt = "fdt-jh7110-milkv-mars";
-				};
-
-				conf-jh7110-pine64-star64 {
-					description = "jh7110-pine64-star64";
-					firmware = "opensbi";
-					loadables = "uboot";
-					fdt = "fdt-jh7110-pine64-star64";
-				};
-
-				conf-jh7110-starfive-visionfive-2-v1.2a {
-					description = "jh7110-starfive-visionfive-2-v1.2a";
-					firmware = "opensbi";
-					loadables = "uboot";
-					fdt = "fdt-jh7110-starfive-visionfive-2-v1.2a";
-				};
-
-				conf-jh7110-starfive-visionfive-2-v1.3b {
-					description = "jh7110-starfive-visionfive-2-v1.3b";
-					firmware = "opensbi";
-					loadables = "uboot";
-					fdt = "fdt-jh7110-starfive-visionfive-2-v1.3b";
-				};
-			};
-		};
-	};
-
-	spl-img {
-		filename = "spl/u-boot-spl.bin.normal.out";
-
-		mkimage {
-			args = "-T sfspl";
-
-			u-boot-spl {
-			};
-		};
-	};
-};
diff --git a/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi b/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
index 9df1e5db553..ab882d07f6f 100644
--- a/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
+++ b/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
@@ -4,3 +4,4 @@
  */
 
 #include "jh7110-common-u-boot.dtsi"
+#include "starfive-visionfive2-binman.dtsi"
diff --git a/arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi b/arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
index 9df1e5db553..ab882d07f6f 100644
--- a/arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
+++ b/arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
@@ -4,3 +4,4 @@
  */
 
 #include "jh7110-common-u-boot.dtsi"
+#include "starfive-visionfive2-binman.dtsi"
diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi
index 9df1e5db553..ab882d07f6f 100644
--- a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi
+++ b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi
@@ -4,3 +4,4 @@
  */
 
 #include "jh7110-common-u-boot.dtsi"
+#include "starfive-visionfive2-binman.dtsi"
diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
index e6bc6630dcd..874074174ff 100644
--- a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
+++ b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
@@ -4,3 +4,4 @@
  */
 
 #include "jh7110-common-u-boot.dtsi"
+#include "starfive-visionfive2-binman.dtsi"
diff --git a/arch/riscv/dts/starfive-visionfive2-binman.dtsi b/arch/riscv/dts/starfive-visionfive2-binman.dtsi
new file mode 100644
index 00000000000..4cce001e80d
--- /dev/null
+++ b/arch/riscv/dts/starfive-visionfive2-binman.dtsi
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ */
+
+#include "binman.dtsi"
+
+/ {
+	config {
+		bootph-pre-ram;
+		u-boot,spl-payload-offset = <0x100000>;
+	};
+};
+
+&binman {
+	itb {
+		fit {
+			images {
+				fdt-jh7110-milkv-mars {
+					description = "jh7110-milkv-mars";
+					load = <0x40400000>;
+					compression = "none";
+
+					blob-ext {
+						filename = "dts/upstream/src/riscv/starfive/jh7110-milkv-mars.dtb";
+					};
+				};
+
+				fdt-jh7110-pine64-star64 {
+					description = "jh7110-pine64-star64";
+					load = <0x40400000>;
+					compression = "none";
+
+					blob-ext {
+						filename = "dts/upstream/src/riscv/starfive/jh7110-pine64-star64.dtb";
+					};
+				};
+
+				fdt-jh7110-starfive-visionfive-2-v1.2a {
+					description = "jh7110-starfive-visionfive-2-v1.2a";
+					load = <0x40400000>;
+					compression = "none";
+
+					blob-ext {
+						filename = "dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2-v1.2a.dtb";
+					};
+				};
+
+				fdt-jh7110-starfive-visionfive-2-v1.3b {
+					description = "jh7110-starfive-visionfive-2-v1.3b";
+					load = <0x40400000>;
+					compression = "none";
+
+					blob-ext {
+						filename = "dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2-v1.3b.dtb";
+					};
+				};
+			};
+
+			configurations {
+				conf-jh7110-milkv-mars {
+					description = "jh7110-milkv-mars";
+					firmware = "opensbi";
+					loadables = "uboot";
+					fdt = "fdt-jh7110-milkv-mars";
+				};
+
+				conf-jh7110-pine64-star64 {
+					description = "jh7110-pine64-star64";
+					firmware = "opensbi";
+					loadables = "uboot";
+					fdt = "fdt-jh7110-pine64-star64";
+				};
+
+				conf-jh7110-starfive-visionfive-2-v1.2a {
+					description = "jh7110-starfive-visionfive-2-v1.2a";
+					firmware = "opensbi";
+					loadables = "uboot";
+					fdt = "fdt-jh7110-starfive-visionfive-2-v1.2a";
+				};
+
+				conf-jh7110-starfive-visionfive-2-v1.3b {
+					description = "jh7110-starfive-visionfive-2-v1.3b";
+					firmware = "opensbi";
+					loadables = "uboot";
+					fdt = "fdt-jh7110-starfive-visionfive-2-v1.3b";
+				};
+			};
+		};
+	};
+
+	spl-img {
+		filename = "spl/u-boot-spl.bin.normal.out";
+
+		mkimage {
+			args = "-T sfspl";
+
+			u-boot-spl {
+			};
+		};
+	};
+};

base-commit: 43cae09eabf398ede30fd4ed1664e2ee6c447d34
-- 
2.45.2

