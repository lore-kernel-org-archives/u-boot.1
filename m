Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60ECAC25B77
	for <u-boot@archiver.kernel.org>; Mon, 20 May 2024 09:59:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE200886B2;
	Mon, 20 May 2024 11:59:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Tg86uEE+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5925E886C1; Mon, 20 May 2024 11:59:42 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCAA4886B0
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 11:59:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44K9xVs7091615;
 Mon, 20 May 2024 04:59:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716199171;
 bh=VPfIcrp95wDMwlKeVeNOQC4sL9lOtRXhG/k0A6Itg9U=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Tg86uEE+ulhy3HE7hdHhRpL9Hu2UPVdjHG8Oo9l8aaxZSL/0eGRp+CB7cva4R6WDd
 ehO4xCWqJ8WuW9kl4OKhbqYe9UgVxz8P5167KI5Bx6/bhlEFFgGsZXnEJPVwIsvKSW
 Aiwpuqwa4tMbeykxSO1r5qF4/uzhbcUib0CseT38=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44K9xVxC001461
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 20 May 2024 04:59:31 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 20
 May 2024 04:59:31 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 20 May 2024 04:59:31 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44K9xHHh047124;
 Mon, 20 May 2024 04:59:27 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <sjg@chromium.org>,
 <alpernebiyasak@gmail.com>, <bb@ti.com>, <nm@ti.com>,
 <sumit.garg@linaro.org>
CC: <michal.simek@amd.com>, <marex@denx.de>, <neil.armstrong@linaro.org>,
 <afd@ti.com>, <vigneshr@ti.com>, <kamlesh@ti.com>, <m-chawdhry@ti.com>,
 <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [PATCH 2/3] configs: j721e_sk: Move to separate defconfig for J721E
 SK board
Date: Mon, 20 May 2024 15:29:15 +0530
Message-ID: <20240520095916.1809962-3-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240520095916.1809962-1-n-francis@ti.com>
References: <20240520095916.1809962-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Add defconfig for J721E SK R5 and A72 configuration.

This includes and modifies the J721E EVM defconfigs:
j721e_evm_r5_defconfig -> j721e_sk_r5_defconfig
j721e_evm_a72_defconfig -> j721e_sk_a72_defconfig

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 arch/arm/dts/k3-j721e-binman.dtsi    | 99 ++--------------------------
 arch/arm/dts/k3-j721e-sk-u-boot.dtsi | 23 +++++++
 board/ti/j721e/MAINTAINERS           |  2 +
 configs/j721e_evm_a72_defconfig      |  2 +-
 configs/j721e_evm_r5_defconfig       |  2 +-
 configs/j721e_sk_a72_defconfig       |  9 +++
 configs/j721e_sk_r5_defconfig        | 10 +++
 7 files changed, 52 insertions(+), 95 deletions(-)
 create mode 100644 configs/j721e_sk_a72_defconfig
 create mode 100644 configs/j721e_sk_r5_defconfig

diff --git a/arch/arm/dts/k3-j721e-binman.dtsi b/arch/arm/dts/k3-j721e-binman.dtsi
index 75a6e9599b9..2867d264664 100644
--- a/arch/arm/dts/k3-j721e-binman.dtsi
+++ b/arch/arm/dts/k3-j721e-binman.dtsi
@@ -212,10 +212,7 @@
 #ifdef CONFIG_TARGET_J721E_A72_EVM
 
 #define SPL_J721E_EVM_DTB "spl/dts/k3-j721e-common-proc-board.dtb"
-#define SPL_J721E_SK_DTB "spl/dts/k3-j721e-sk.dtb"
-
 #define J721E_EVM_DTB "u-boot.dtb"
-#define J721E_SK_DTB "arch/arm/dts/k3-j721e-sk.dtb"
 
 &binman {
 	ti-dm {
@@ -361,28 +358,13 @@
 					arch = "arm";
 					compression = "none";
 					ti-secure {
-						content = <&spl_j721e_evm_dtb>;
+						content = <&spl_j721e_dtb>;
 						keyfile = "custMpk.pem";
 					};
-					spl_j721e_evm_dtb: blob-ext {
+					spl_j721e_dtb: blob-ext {
 						filename = SPL_J721E_EVM_DTB;
 					};
 				};
-
-				fdt-1 {
-					description = "k3-j721e-sk";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					ti-secure {
-						content = <&spl_j721e_sk_dtb>;
-						keyfile = "custMpk.pem";
-
-					};
-					spl_j721e_sk_dtb: blob-ext {
-						filename = SPL_J721E_SK_DTB;
-					};
-				};
 			};
 
 			configurations {
@@ -394,13 +376,6 @@
 					loadables = "tee", "dm", "spl";
 					fdt = "fdt-0";
 				};
-
-				conf-1 {
-					description = "k3-j721e-sk";
-					firmware = "atf";
-					loadables = "tee", "dm", "spl";
-					fdt = "fdt-1";
-				};
 			};
 		};
 	};
@@ -422,35 +397,17 @@
 					arch = "arm";
 					compression = "none";
 					ti-secure {
-						content = <&j721e_evm_dtb>;
+						content = <&j721e_dtb>;
 						keyfile = "custMpk.pem";
 
 					};
-					j721e_evm_dtb: blob-ext {
+					j721e_dtb: blob-ext {
 						filename = J721E_EVM_DTB;
 					};
 					hash {
 						algo = "crc32";
 					};
 				};
-
-				fdt-1 {
-					description = "k3-j721e-sk";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					ti-secure {
-						content = <&j721e_sk_dtb>;
-						keyfile = "custMpk.pem";
-
-					};
-					j721e_sk_dtb: blob-ext {
-						filename = J721E_SK_DTB;
-					};
-					hash {
-						algo = "crc32";
-					};
-				};
 			};
 
 			configurations {
@@ -462,13 +419,6 @@
 					loadables = "uboot";
 					fdt = "fdt-0";
 				};
-
-				conf-1 {
-					description = "k3-j721e-sk";
-					firmware = "uboot";
-					loadables = "uboot";
-					fdt = "fdt-1";
-				};
 			};
 		};
 	};
@@ -491,20 +441,10 @@
 					type = "flat_dt";
 					arch = "arm";
 					compression = "none";
-					blob {
+					spl_j721e_dtb_unsigned: blob {
 						filename = SPL_J721E_EVM_DTB;
 					};
 				};
-
-				fdt-1 {
-					description = "k3-j721e-sk";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					blob {
-						filename = SPL_J721E_SK_DTB;
-					};
-				};
 			};
 
 			configurations {
@@ -516,13 +456,6 @@
 					loadables = "tee", "dm", "spl";
 					fdt = "fdt-0";
 				};
-
-				conf-1 {
-					description = "k3-j721e-sk";
-					firmware = "atf";
-					loadables = "tee", "dm", "spl";
-					fdt = "fdt-1";
-				};
 			};
 		};
 	};
@@ -543,26 +476,13 @@
 					type = "flat_dt";
 					arch = "arm";
 					compression = "none";
-					blob {
+					j721e_dtb_unsigned: blob {
 						filename = J721E_EVM_DTB;
 					};
 					hash {
 						algo = "crc32";
 					};
 				};
-
-				fdt-1 {
-					description = "k3-j721e-sk";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					blob {
-						filename = J721E_SK_DTB;
-					};
-					hash {
-						algo = "crc32";
-					};
-				};
 			};
 
 			configurations {
@@ -574,13 +494,6 @@
 					loadables = "uboot";
 					fdt = "fdt-0";
 				};
-
-				conf-1 {
-					description = "k3-j721e-sk";
-					firmware = "uboot";
-					loadables = "uboot";
-					fdt = "fdt-1";
-				};
 			};
 		};
 	};
diff --git a/arch/arm/dts/k3-j721e-sk-u-boot.dtsi b/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
index 8f4f944263e..6d0f7457ccd 100644
--- a/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
@@ -155,3 +155,26 @@
 		bootph-all;
 	};
 };
+
+#ifdef CONFIG_TARGET_J721E_A72_EVM
+
+#define SPL_J721E_SK_DTB "spl/dts/k3-j721e-sk.dtb"
+#define J721E_SK_DTB "u-boot.dtb"
+
+&spl_j721e_dtb {
+	filename = SPL_J721E_SK_DTB;
+};
+
+&j721e_dtb {
+	filename = J721E_SK_DTB;
+};
+
+&spl_j721e_dtb_unsigned {
+	filename = SPL_J721E_SK_DTB;
+};
+
+&j721e_dtb_unsigned {
+	filename = J721E_SK_DTB;
+};
+
+#endif
diff --git a/board/ti/j721e/MAINTAINERS b/board/ti/j721e/MAINTAINERS
index f5ca7d06a34..06aba53d9b0 100644
--- a/board/ti/j721e/MAINTAINERS
+++ b/board/ti/j721e/MAINTAINERS
@@ -5,5 +5,7 @@ F:	board/ti/j721e
 F:	include/configs/j721e_evm.h
 F:	configs/j721e_evm_r5_defconfig
 F:	configs/j721e_evm_a72_defconfig
+F:	configs/j721e_sk_r5_defconfig
+F:	configs/j721e_sk_a72_defconfig
 F:	configs/j7200_evm_r5_defconfig
 F:	configs/j7200_evm_a72_defconfig
diff --git a/configs/j721e_evm_a72_defconfig b/configs/j721e_evm_a72_defconfig
index 3d8e9391987..b8d7c33c45c 100644
--- a/configs/j721e_evm_a72_defconfig
+++ b/configs/j721e_evm_a72_defconfig
@@ -88,7 +88,7 @@ CONFIG_MMC_SPEED_MODE_SET=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_LIST="k3-j721e-common-proc-board k3-j721e-sk"
+CONFIG_OF_LIST="k3-j721e-common-proc-board"
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
diff --git a/configs/j721e_evm_r5_defconfig b/configs/j721e_evm_r5_defconfig
index cea48b26136..37d582b7750 100644
--- a/configs/j721e_evm_r5_defconfig
+++ b/configs/j721e_evm_r5_defconfig
@@ -81,7 +81,7 @@ CONFIG_CMD_MTDPARTS=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_SPL_MULTI_DTB_FIT=y
-CONFIG_SPL_OF_LIST="k3-j721e-r5-common-proc-board k3-j721e-r5-sk"
+CONFIG_SPL_OF_LIST="k3-j721e-r5-common-proc-board"
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
diff --git a/configs/j721e_sk_a72_defconfig b/configs/j721e_sk_a72_defconfig
new file mode 100644
index 00000000000..8907b8ae58f
--- /dev/null
+++ b/configs/j721e_sk_a72_defconfig
@@ -0,0 +1,9 @@
+#include <configs/j721e_evm_a72_defconfig>
+
+CONFIG_ARM=y
+CONFIG_ARCH_K3=y
+CONFIG_SOC_K3_J721E=y
+CONFIG_TARGET_J721E_A72_EVM=y
+
+CONFIG_DEFAULT_DEVICE_TREE="k3-j721e-sk"
+CONFIG_OF_LIST="k3-j721e-sk"
diff --git a/configs/j721e_sk_r5_defconfig b/configs/j721e_sk_r5_defconfig
new file mode 100644
index 00000000000..b361c691747
--- /dev/null
+++ b/configs/j721e_sk_r5_defconfig
@@ -0,0 +1,10 @@
+#include <configs/j721e_evm_r5_defconfig>
+
+CONFIG_ARM=y
+CONFIG_ARCH_K3=y
+CONFIG_SOC_K3_J721E=y
+CONFIG_TARGET_J721E_R5_EVM=y
+
+CONFIG_DEFAULT_DEVICE_TREE="k3-j721e-r5-sk"
+CONFIG_SPL_OF_LIST="k3-j721e-r5-sk"
+CONFIG_OF_LIST="k3-j721e-r5-sk"
-- 
2.34.1

