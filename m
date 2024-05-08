Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F54BC04FFE
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 07:27:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79A318869F;
	Wed,  8 May 2024 09:26:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kGCEXr0G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C559D8873A; Wed,  8 May 2024 09:26:46 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0A5088760
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 09:26:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4487QegY123992;
 Wed, 8 May 2024 02:26:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1715153200;
 bh=NMmlXkAFZH2aufWorz+3pVo6cZez0LYcDmqP1a63FQk=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=kGCEXr0GBfF8dVnb6xw4xM1QLpCnHKorM3ifVfnvaSdq674wFRFVkFABr4BKPg6xr
 br5KAhZ4egb0G8do9g1Q38fBLg3vukrWlZJOeKCP/0NT6+RYl+YPy0O2+zOBB8Dwpe
 EikGG9Y7rHZAD8y3cF12nyLAiT/brj51JSmDizR8=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4487Qe6u104002
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 8 May 2024 02:26:40 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 8
 May 2024 02:26:40 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 8 May 2024 02:26:40 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4487QRJv015339;
 Wed, 8 May 2024 02:26:37 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Wed, 8 May 2024 12:56:27 +0530
Subject: [PATCH 3/6] configs: am68_sk: Move to separate defconfig for AM68
 SK board
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240508-b4-upstream-j721s2-of-upstream-v1-3-ed0933172410@ti.com>
References: <20240508-b4-upstream-j721s2-of-upstream-v1-0-ed0933172410@ti.com>
In-Reply-To: <20240508-b4-upstream-j721s2-of-upstream-v1-0-ed0933172410@ti.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Alper Nebi
 Yasak <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Nishanth
 Menon <nm@ti.com>, Andrew Davis <afd@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Aniket Limaye <a-limaye@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715153187; l=7542;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=yV1Islj54fxKexainHg60t9gQsLBRT7fxtfz9KufD3I=;
 b=Ta+rRHbgHaLiHAET+r9aVYSGGkqhFj2HJwj3j1EDK5L9MgyDyf+/cQG3yTssFTB0XZ+Y12a/6
 sVVe/k9M7lbCUo2/PhlFVSWjOWOhA+wHi0ElwQNQFASUDrteFcUzO8y
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
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

Add defconfig for AM68 SK R5 and A72 configuration.

This includes and modifies the AM68 EVM defconfigs:
j721s2_evm_r5_defconfig -> am68_sk_r5_defconfig
j721s2_evm_a72_defconfig -> am68_sk_a72_defconfig

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi | 23 +++++++
 arch/arm/dts/k3-j721s2-binman.dtsi             | 89 +-------------------------
 board/ti/j721s2/MAINTAINERS                    |  2 +
 configs/am68_sk_a72_defconfig                  | 10 +++
 configs/am68_sk_r5_defconfig                   | 10 +++
 configs/j721s2_evm_a72_defconfig               |  2 +-
 configs/j721s2_evm_r5_defconfig                |  2 +-
 7 files changed, 49 insertions(+), 89 deletions(-)

diff --git a/arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi b/arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi
index b8fc62f0dd1c..dca588485d41 100644
--- a/arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi
@@ -129,3 +129,26 @@
 	dr_mode = "peripheral";
 	bootph-all;
 };
+
+#ifdef CONFIG_TARGET_J721S2_A72_EVM
+
+#define SPL_AM68_SK_DTB "spl/dts/k3-am68-sk-base-board.dtb"
+#define AM68_SK_DTB "u-boot.dtb"
+
+&spl_j721s2_evm_dtb {
+	filename = SPL_AM68_SK_DTB;
+};
+
+&j721s2_evm_dtb {
+	filename = AM68_SK_DTB;
+};
+
+&spl_j721s2_evm_dtb_unsigned {
+	filename = SPL_AM68_SK_DTB;
+};
+
+&j721s2_evm_dtb_unsigned {
+	filename = AM68_SK_DTB;
+};
+
+#endif
diff --git a/arch/arm/dts/k3-j721s2-binman.dtsi b/arch/arm/dts/k3-j721s2-binman.dtsi
index 7efb135bdff9..c46fda66b0b2 100644
--- a/arch/arm/dts/k3-j721s2-binman.dtsi
+++ b/arch/arm/dts/k3-j721s2-binman.dtsi
@@ -142,10 +142,7 @@
 #ifdef CONFIG_TARGET_J721S2_A72_EVM
 
 #define SPL_J721S2_EVM_DTB "spl/dts/k3-j721s2-common-proc-board.dtb"
-#define SPL_AM68_SK_DTB "spl/dts/k3-am68-sk-base-board.dtb"
-
 #define J721S2_EVM_DTB "u-boot.dtb"
-#define AM68_SK_DTB "arch/arm/dts/k3-am68-sk-base-board.dtb"
 
 &binman {
 	ti-dm {
@@ -306,20 +303,6 @@
 					};
 
 				};
-
-				fdt-1 {
-					description = "k3-am68-sk-base-board";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					ti-secure {
-						content = <&spl_am68_sk_dtb>;
-						keyfile = "custMpk.pem";
-					};
-					spl_am68_sk_dtb: blob-ext {
-						filename = SPL_AM68_SK_DTB;
-					};
-				};
 			};
 
 			configurations {
@@ -331,13 +314,6 @@
 					loadables = "tee", "dm", "spl";
 					fdt = "fdt-0";
 				};
-
-				conf-1 {
-					description = "k3-am68-sk-base-board";
-					firmware = "atf";
-					loadables = "tee", "dm", "spl";
-					fdt = "fdt-1";
-				};
 			};
 		};
 	};
@@ -370,25 +346,6 @@
 						algo = "crc32";
 					};
 				};
-
-				fdt-1 {
-					description = "k3-am68-sk-base-board";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					ti-secure {
-						content = <&am68_sk_dtb>;
-						keyfile = "custMpk.pem";
-					};
-					am68_sk_dtb: blob-ext {
-						filename = AM68_SK_DTB;
-					};
-
-					hash {
-						algo = "crc32";
-					};
-				};
-
 			};
 
 			configurations {
@@ -400,13 +357,6 @@
 					loadables = "uboot";
 					fdt = "fdt-0";
 				};
-				conf-1 {
-					description = "k3-am68-sk-base-board";
-					firmware = "uboot";
-					loadables = "uboot";
-					fdt = "fdt-1";
-				};
-
 			};
 		};
 	};
@@ -429,20 +379,10 @@
 					type = "flat_dt";
 					arch = "arm";
 					compression = "none";
-					blob {
+					spl_j721s2_evm_dtb_unsigned: blob {
 						filename = SPL_J721S2_EVM_DTB;
 					};
 				};
-				fdt-1 {
-					description = "k3-am68-sk-base-board";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					blob {
-						filename = SPL_AM68_SK_DTB;
-					};
-				};
-
 			};
 
 			configurations {
@@ -454,12 +394,6 @@
 					loadables = "tee", "dm", "spl";
 					fdt = "fdt-0";
 				};
-				conf-1 {
-					description = "k3-am68-sk-base-board";
-					firmware = "atf";
-					loadables = "tee", "dm", "spl";
-					fdt = "fdt-1";
-				};
 			};
 		};
 	};
@@ -480,26 +414,13 @@
 					type = "flat_dt";
 					arch = "arm";
 					compression = "none";
-					blob {
+					j721s2_evm_dtb_unsigned: blob {
 						filename = J721S2_EVM_DTB;
 					};
 					hash {
 						algo = "crc32";
 					};
 				};
-				fdt-1 {
-					description = "k3-am68-sk-base-board";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					blob {
-						filename = AM68_SK_DTB;
-					};
-					hash {
-						algo = "crc32";
-					};
-				};
-
 			};
 
 			configurations {
@@ -511,12 +432,6 @@
 					loadables = "uboot";
 					fdt = "fdt-0";
 				};
-				conf-1 {
-					description = "k3-am68-sk-base-board";
-					firmware = "uboot";
-					loadables = "uboot";
-					fdt = "fdt-1";
-				};
 			};
 		};
 	};
diff --git a/board/ti/j721s2/MAINTAINERS b/board/ti/j721s2/MAINTAINERS
index 08c8d110ac0a..e690aeeaf0c1 100644
--- a/board/ti/j721s2/MAINTAINERS
+++ b/board/ti/j721s2/MAINTAINERS
@@ -7,6 +7,8 @@ F:	doc/board/ti/j721s2_evm.rst
 F:	include/configs/j721s2_evm.h
 F:	configs/j721s2_evm_r5_defconfig
 F:	configs/j721s2_evm_a72_defconfig
+F:	configs/am68_sk_r5_defconfig
+F:	configs/am68_sk_a72_defconfig
 F:	arch/arm/dts/k3-j721s2.dtsi
 F:	arch/arm/dts/k3-j721s2-main.dtsi
 F:	arch/arm/dts/k3-j721s2-mcu-wakeup.dtsi
diff --git a/configs/am68_sk_a72_defconfig b/configs/am68_sk_a72_defconfig
new file mode 100644
index 000000000000..d477f9e4e988
--- /dev/null
+++ b/configs/am68_sk_a72_defconfig
@@ -0,0 +1,10 @@
+#include <configs/j721s2_evm_a72_defconfig>
+
+CONFIG_ARM=y
+CONFIG_ARCH_K3=y
+CONFIG_SOC_K3_J721S2=y
+CONFIG_TARGET_J721S2_A72_EVM=y
+
+CONFIG_DEFAULT_DEVICE_TREE="k3-am68-sk-base-board"
+CONFIG_SPL_OF_LIST="k3-am68-sk-base-board"
+CONFIG_OF_LIST="k3-am68-sk-base-board"
diff --git a/configs/am68_sk_r5_defconfig b/configs/am68_sk_r5_defconfig
new file mode 100644
index 000000000000..e9b6882c1f68
--- /dev/null
+++ b/configs/am68_sk_r5_defconfig
@@ -0,0 +1,10 @@
+#include <configs/j721s2_evm_r5_defconfig>
+
+CONFIG_ARM=y
+CONFIG_ARCH_K3=y
+CONFIG_SOC_K3_J721S2=y
+CONFIG_TARGET_J721S2_R5_EVM=y
+
+CONFIG_DEFAULT_DEVICE_TREE="k3-am68-sk-r5-base-board"
+CONFIG_SPL_OF_LIST="k3-am68-sk-r5-base-board"
+CONFIG_OF_LIST="k3-am68-sk-r5-base-board"
diff --git a/configs/j721s2_evm_a72_defconfig b/configs/j721s2_evm_a72_defconfig
index 8b02d07a9f09..dd86b5c05092 100644
--- a/configs/j721s2_evm_a72_defconfig
+++ b/configs/j721s2_evm_a72_defconfig
@@ -84,7 +84,7 @@ CONFIG_CMD_UBI=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_LIST="k3-j721s2-common-proc-board k3-am68-sk-base-board"
+CONFIG_OF_LIST="k3-j721s2-common-proc-board"
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
diff --git a/configs/j721s2_evm_r5_defconfig b/configs/j721s2_evm_r5_defconfig
index 5ef5247a3e00..3c958cafbe8f 100644
--- a/configs/j721s2_evm_r5_defconfig
+++ b/configs/j721s2_evm_r5_defconfig
@@ -82,7 +82,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_SPL_MULTI_DTB_FIT=y
-CONFIG_SPL_OF_LIST="k3-j721s2-r5-common-proc-board k3-am68-sk-r5-base-board"
+CONFIG_SPL_OF_LIST="k3-j721s2-r5-common-proc-board"
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y

-- 
2.43.2

