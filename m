Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F3DC07548
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 10:10:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A580A86F46;
	Wed, 15 Nov 2023 11:10:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Fm0WsZ7a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FA1086F46; Wed, 15 Nov 2023 11:10:41 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 498AE86DB8
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 11:10:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AFAAZjw030975;
 Wed, 15 Nov 2023 04:10:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700043035;
 bh=p8C1oijPhjFnmFXZUDQvKwakB90z98XH/U3PU0EjTac=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Fm0WsZ7aGMSjkRQhkt6K6vqFrt7yiers11z0JJWMtCoZnAlpmmlRnugDCNsU76OPP
 hYrstZ5XHc/6uPikYgdQ/vG5g4CQhSdKu1YvutMLfseMJBoDD3Fu95YjVKZ/46PLR4
 EwBJmNvalzTC+yczCOChM6zCDLzlsvxteS+TXTOI=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AFAAZiK023032
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 15 Nov 2023 04:10:35 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 15
 Nov 2023 04:10:35 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 15 Nov 2023 04:10:34 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AFAAOSX027039;
 Wed, 15 Nov 2023 04:10:32 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <sjg@chromium.org>, <marcel.ziswiler@toradex.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <nm@ti.com>, <u-kumar1@ti.com>, 
 <kamlesh@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>,
 <mkorpershoek@baylibre.com>, <n-francis@ti.com>
Subject: [PATCH 2/2] arm: dts: k3-*-binman: Move to using templated FITs
Date: Wed, 15 Nov 2023 15:40:24 +0530
Message-ID: <20231115101024.3441093-3-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231115101024.3441093-1-n-francis@ti.com>
References: <20231115101024.3441093-1-n-francis@ti.com>
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

Reduce redundancy in code by using templates to generate the A72 boot
binaries (tispl.bin and u-boot.img) as well as R5 boot binary sysfw.itb
(for legacy boot following devices J721E and AM65x).

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 arch/arm/dts/k3-am625-sk-binman.dtsi          | 157 +--------
 .../dts/k3-am625-verdin-wifi-dev-binman.dtsi  | 155 +-------
 arch/arm/dts/k3-am62a-sk-binman.dtsi          | 158 +--------
 arch/arm/dts/k3-am64x-binman.dtsi             | 151 +-------
 arch/arm/dts/k3-am65x-binman.dtsi             | 273 +-------------
 arch/arm/dts/k3-j7200-binman.dtsi             | 159 +--------
 arch/arm/dts/k3-j721e-binman.dtsi             | 332 +-----------------
 arch/arm/dts/k3-j721s2-binman.dtsi            | 157 +--------
 8 files changed, 54 insertions(+), 1488 deletions(-)

diff --git a/arch/arm/dts/k3-am625-sk-binman.dtsi b/arch/arm/dts/k3-am625-sk-binman.dtsi
index 41277bf4bf..b7b5368886 100644
--- a/arch/arm/dts/k3-am625-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am625-sk-binman.dtsi
@@ -141,10 +141,7 @@
 
 #ifdef CONFIG_TARGET_AM625_A53_EVM
 
-#define SPL_NODTB "spl/u-boot-spl-nodtb.bin"
 #define SPL_AM625_SK_DTB "spl/dts/k3-am625-sk.dtb"
-
-#define UBOOT_NODTB "u-boot-nodtb.bin"
 #define AM625_SK_DTB "u-boot.dtb"
 
 &binman {
@@ -155,55 +152,11 @@
 		};
 	};
 	ti-spl {
-		filename = "tispl.bin";
-		pad-byte = <0xff>;
+		insert-template = <&ti_spl_template>;
 
 		fit {
-			description = "Configuration to load ATF and SPL";
-			#address-cells = <1>;
-
 			images {
-
-				atf {
-					description = "ARM Trusted Firmware";
-					type = "firmware";
-					arch = "arm64";
-					compression = "none";
-					os = "arm-trusted-firmware";
-					load = <CONFIG_K3_ATF_LOAD_ADDR>;
-					entry = <CONFIG_K3_ATF_LOAD_ADDR>;
-					ti-secure {
-						content = <&atf>;
-						keyfile = "custMpk.pem";
-					};
-					atf: atf-bl31 {
-					};
-				};
-
-				tee {
-					description = "OP-TEE";
-					type = "tee";
-					arch = "arm64";
-					compression = "none";
-					os = "tee";
-					load = <0x9e800000>;
-					entry = <0x9e800000>;
-					ti-secure {
-						content = <&tee>;
-						keyfile = "custMpk.pem";
-					};
-					tee: tee-os {
-					};
-				};
-
 				dm {
-					description = "DM binary";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "DM";
-					load = <0x89000000>;
-					entry = <0x89000000>;
 					ti-secure {
 						content = <&dm>;
 						keyfile = "custMpk.pem";
@@ -213,23 +166,6 @@
 					};
 				};
 
-				spl {
-					description = "SPL (64-bit)";
-					type = "standalone";
-					os = "U-Boot";
-					arch = "arm64";
-					compression = "none";
-					load = <CONFIG_SPL_TEXT_BASE>;
-					entry = <CONFIG_SPL_TEXT_BASE>;
-					ti-secure {
-						content = <&u_boot_spl_nodtb>;
-						keyfile = "custMpk.pem";
-					};
-					u_boot_spl_nodtb: blob-ext {
-						filename = SPL_NODTB;
-					};
-				};
-
 				fdt-0 {
 					description = "k3-am625-sk";
 					type = "flat_dt";
@@ -263,29 +199,12 @@
 
 &binman {
 	u-boot {
-		filename = "u-boot.img";
-		pad-byte = <0xff>;
+		insert-template = <&u_boot_template>;
 
 		fit {
-			description = "FIT image with multiple configurations";
-
 			images {
 				uboot {
-					description = "U-Boot for AM625 board";
-					type = "firmware";
-					os = "u-boot";
-					arch = "arm";
-					compression = "none";
-					load = <CONFIG_TEXT_BASE>;
-					ti-secure {
-						content = <&u_boot_nodtb>;
-						keyfile = "custMpk.pem";
-					};
-					u_boot_nodtb: u-boot-nodtb {
-					};
-					hash {
-						algo = "crc32";
-					};
+					description = "U-Boot for AM625 Board";
 				};
 
 				fdt-0 {
@@ -323,67 +242,17 @@
 
 &binman {
 	ti-spl_unsigned {
-		filename = "tispl.bin_unsigned";
-		pad-byte = <0xff>;
+		insert-template = <&ti_spl_unsigned_template>;
 
 		fit {
-			description = "Configuration to load ATF and SPL";
-			#address-cells = <1>;
-
 			images {
 
-				atf {
-					description = "ARM Trusted Firmware";
-					type = "firmware";
-					arch = "arm64";
-					compression = "none";
-					os = "arm-trusted-firmware";
-					load = <CONFIG_K3_ATF_LOAD_ADDR>;
-					entry = <CONFIG_K3_ATF_LOAD_ADDR>;
-					atf-bl31 {
-						filename = "bl31.bin";
-					};
-				};
-
-				tee {
-					description = "OP-TEE";
-					type = "tee";
-					arch = "arm64";
-					compression = "none";
-					os = "tee";
-					load = <0x9e800000>;
-					entry = <0x9e800000>;
-					tee-os {
-						filename = "tee-raw.bin";
-					};
-				};
-
 				dm {
-					description = "DM binary";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "DM";
-					load = <0x89000000>;
-					entry = <0x89000000>;
 					blob-ext {
 						filename = "ti-dm.bin";
 					};
 				};
 
-				spl {
-					description = "SPL (64-bit)";
-					type = "standalone";
-					os = "U-Boot";
-					arch = "arm64";
-					compression = "none";
-					load = <CONFIG_SPL_TEXT_BASE>;
-					entry = <CONFIG_SPL_TEXT_BASE>;
-					blob {
-						filename = "spl/u-boot-spl-nodtb.bin";
-					};
-				};
-
 				fdt-0 {
 					description = "k3-am625-sk";
 					type = "flat_dt";
@@ -411,26 +280,12 @@
 
 &binman {
 	u-boot_unsigned {
-		filename = "u-boot.img_unsigned";
-		pad-byte = <0xff>;
+		insert-template = <&u_boot_unsigned_template>;
 
 		fit {
-			description = "FIT image with multiple configurations";
-
 			images {
 				uboot {
-					description = "U-Boot for AM625 board";
-					type = "firmware";
-					os = "u-boot";
-					arch = "arm";
-					compression = "none";
-					load = <CONFIG_TEXT_BASE>;
-					blob {
-						filename = UBOOT_NODTB;
-					};
-					hash {
-						algo = "crc32";
-					};
+					description = "U-Boot for AM625 Board";
 				};
 
 				fdt-0 {
diff --git a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
index 089b2a5f5c..eafd3310bb 100644
--- a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
+++ b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
@@ -214,10 +214,7 @@
 
 #ifdef CONFIG_TARGET_VERDIN_AM62_A53
 
-#define SPL_NODTB "spl/u-boot-spl-nodtb.bin"
 #define SPL_VERDIN_AM62_DTB "spl/dts/k3-am625-verdin-wifi-dev.dtb"
-
-#define UBOOT_NODTB "u-boot-nodtb.bin"
 #define VERDIN_AM62_DTB "u-boot.dtb"
 
 &binman {
@@ -228,54 +225,12 @@
 		};
 	};
 	ti-spl {
-		filename = "tispl.bin";
-		pad-byte = <0xff>;
+		insert-template = <&ti_spl_template>;
 
 		fit {
-			description = "Configuration to load ATF and SPL";
-			#address-cells = <1>;
 
 			images {
-				atf {
-					description = "ARM Trusted Firmware";
-					type = "firmware";
-					arch = "arm64";
-					compression = "none";
-					os = "arm-trusted-firmware";
-					load = <CONFIG_K3_ATF_LOAD_ADDR>;
-					entry = <CONFIG_K3_ATF_LOAD_ADDR>;
-					ti-secure {
-						content = <&atf>;
-						keyfile = "custMpk.pem";
-					};
-					atf: atf-bl31 {
-					};
-				};
-
-				tee {
-					description = "OP-TEE";
-					type = "tee";
-					arch = "arm64";
-					compression = "none";
-					os = "tee";
-					load = <0x9e800000>;
-					entry = <0x9e800000>;
-					ti-secure {
-						content = <&tee>;
-						keyfile = "custMpk.pem";
-					};
-					tee: tee-os {
-					};
-				};
-
 				dm {
-					description = "DM binary";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "DM";
-					load = <0x89000000>;
-					entry = <0x89000000>;
 					ti-secure {
 						content = <&dm>;
 						keyfile = "custMpk.pem";
@@ -285,23 +240,6 @@
 					};
 				};
 
-				spl {
-					description = "SPL (64-bit)";
-					type = "standalone";
-					os = "U-Boot";
-					arch = "arm64";
-					compression = "none";
-					load = <CONFIG_SPL_TEXT_BASE>;
-					entry = <CONFIG_SPL_TEXT_BASE>;
-					ti-secure {
-						content = <&u_boot_spl_nodtb>;
-						keyfile = "custMpk.pem";
-					};
-					u_boot_spl_nodtb: blob-ext {
-						filename = SPL_NODTB;
-					};
-				};
-
 				fdt-0 {
 					description = "k3-am625-verdin-wifi-dev";
 					type = "flat_dt";
@@ -333,29 +271,12 @@
 
 &binman {
 	u-boot {
-		filename = "u-boot.img";
-		pad-byte = <0xff>;
+		insert-template = <&u_boot_template>;
 
 		fit {
-			description = "FIT image with multiple configurations";
-
 			images {
 				uboot {
-					description = "U-Boot for AM625 board";
-					type = "firmware";
-					os = "u-boot";
-					arch = "arm";
-					compression = "none";
-					load = <CONFIG_TEXT_BASE>;
-					ti-secure {
-						content = <&u_boot_nodtb>;
-						keyfile = "custMpk.pem";
-					};
-					u_boot_nodtb: u-boot-nodtb {
-					};
-					hash {
-						algo = "crc32";
-					};
+					description = "U-Boot fot AM625 Verdin Board";
 				};
 
 				fdt-0 {
@@ -392,66 +313,16 @@
 
 &binman {
 	ti-spl_unsigned {
-		filename = "tispl.bin_unsigned";
-		pad-byte = <0xff>;
+		insert-template = <&ti_spl_unsigned_template>;
 
 		fit {
-			description = "Configuration to load ATF and SPL";
-			#address-cells = <1>;
-
 			images {
-				atf {
-					description = "ARM Trusted Firmware";
-					type = "firmware";
-					arch = "arm64";
-					compression = "none";
-					os = "arm-trusted-firmware";
-					load = <CONFIG_K3_ATF_LOAD_ADDR>;
-					entry = <CONFIG_K3_ATF_LOAD_ADDR>;
-					atf-bl31 {
-						filename = "bl31.bin";
-					};
-				};
-
-				tee {
-					description = "OP-TEE";
-					type = "tee";
-					arch = "arm64";
-					compression = "none";
-					os = "tee";
-					load = <0x9e800000>;
-					entry = <0x9e800000>;
-					tee-os {
-						filename = "tee-raw.bin";
-					};
-				};
-
 				dm {
-					description = "DM binary";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "DM";
-					load = <0x89000000>;
-					entry = <0x89000000>;
 					blob-ext {
 						filename = "ti-dm.bin";
 					};
 				};
 
-				spl {
-					description = "SPL (64-bit)";
-					type = "standalone";
-					os = "U-Boot";
-					arch = "arm64";
-					compression = "none";
-					load = <CONFIG_SPL_TEXT_BASE>;
-					entry = <CONFIG_SPL_TEXT_BASE>;
-					blob {
-						filename = "spl/u-boot-spl-nodtb.bin";
-					};
-				};
-
 				fdt-0 {
 					description = "k3-am625-verdin-wifi-dev";
 					type = "flat_dt";
@@ -479,26 +350,12 @@
 
 &binman {
 	u-boot_unsigned {
-		filename = "u-boot.img_unsigned";
-		pad-byte = <0xff>;
+		insert-template = <&u_boot_unsigned_template>;
 
 		fit {
-			description = "FIT image with multiple configurations";
-
 			images {
 				uboot {
-					description = "U-Boot for AM625 board";
-					type = "firmware";
-					os = "u-boot";
-					arch = "arm";
-					compression = "none";
-					load = <CONFIG_TEXT_BASE>;
-					blob {
-						filename = UBOOT_NODTB;
-					};
-					hash {
-						algo = "crc32";
-					};
+					description = "U-Boot for AM625 Verdin Board";
 				};
 
 				fdt-0 {
diff --git a/arch/arm/dts/k3-am62a-sk-binman.dtsi b/arch/arm/dts/k3-am62a-sk-binman.dtsi
index de09430d93..c5e027d44d 100644
--- a/arch/arm/dts/k3-am62a-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am62a-sk-binman.dtsi
@@ -144,10 +144,7 @@
 
 #ifdef CONFIG_TARGET_AM62A7_A53_EVM
 
-#define SPL_NODTB "spl/u-boot-spl-nodtb.bin"
 #define SPL_AM62A7_SK_DTB "spl/dts/k3-am62a7-sk.dtb"
-
-#define UBOOT_NODTB "u-boot-nodtb.bin"
 #define AM62A7_SK_DTB "u-boot.dtb"
 
 &binman {
@@ -158,55 +155,11 @@
 		};
 	};
 	ti-spl {
-		filename = "tispl.bin";
-		pad-byte = <0xff>;
+		insert-template = <&ti_spl_template>;
 
 		fit {
-			description = "Configuration to load ATF and SPL";
-			#address-cells = <1>;
-
 			images {
-
-				atf {
-					description = "ARM Trusted Firmware";
-					type = "firmware";
-					arch = "arm64";
-					compression = "none";
-					os = "arm-trusted-firmware";
-					load = <CONFIG_K3_ATF_LOAD_ADDR>;
-					entry = <CONFIG_K3_ATF_LOAD_ADDR>;
-					ti-secure {
-						content = <&atf>;
-						keyfile = "custMpk.pem";
-					};
-					atf: atf-bl31 {
-					};
-				};
-
-				tee {
-					description = "OP-TEE";
-					type = "tee";
-					arch = "arm64";
-					compression = "none";
-					os = "tee";
-					load = <0x9e800000>;
-					entry = <0x9e800000>;
-					ti-secure {
-						content = <&tee>;
-						keyfile = "custMpk.pem";
-					};
-					tee: tee-os {
-					};
-				};
-
 				dm {
-					description = "DM binary";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "DM";
-					load = <0x89000000>;
-					entry = <0x89000000>;
 					ti-secure {
 						content = <&dm>;
 						keyfile = "custMpk.pem";
@@ -216,23 +169,6 @@
 					};
 				};
 
-				spl {
-					description = "SPL (64-bit)";
-					type = "standalone";
-					os = "U-Boot";
-					arch = "arm64";
-					compression = "none";
-					load = <CONFIG_SPL_TEXT_BASE>;
-					entry = <CONFIG_SPL_TEXT_BASE>;
-					ti-secure {
-						content = <&u_boot_spl_nodtb>;
-						keyfile = "custMpk.pem";
-					};
-					u_boot_spl_nodtb: blob-ext {
-						filename = SPL_NODTB;
-					};
-				};
-
 				fdt-0 {
 					description = "k3-am62a7-sk";
 					type = "flat_dt";
@@ -266,29 +202,12 @@
 
 &binman {
 	u-boot {
-		filename = "u-boot.img";
-		pad-byte = <0xff>;
+		insert-template = <&u_boot_template>;
 
 		fit {
-			description = "FIT image with multiple configurations";
-
 			images {
 				uboot {
-					description = "U-Boot for AM62Ax board";
-					type = "firmware";
-					os = "u-boot";
-					arch = "arm";
-					compression = "none";
-					load = <CONFIG_TEXT_BASE>;
-					ti-secure {
-						content = <&u_boot_nodtb>;
-						keyfile = "custMpk.pem";
-					};
-					u_boot_nodtb: u-boot-nodtb {
-					};
-					hash {
-						algo = "crc32";
-					};
+					description = "U-Boot for AM62Ax Board";
 				};
 
 				fdt-0 {
@@ -326,67 +245,16 @@
 
 &binman {
 	ti-spl_unsigned {
-		filename = "tispl.bin_unsigned";
-		pad-byte = <0xff>;
+		insert-template = <&ti_spl_unsigned_template>;
 
 		fit {
-			description = "Configuration to load ATF and SPL";
-			#address-cells = <1>;
-
 			images {
-
-				atf {
-					description = "ARM Trusted Firmware";
-					type = "firmware";
-					arch = "arm64";
-					compression = "none";
-					os = "arm-trusted-firmware";
-					load = <CONFIG_K3_ATF_LOAD_ADDR>;
-					entry = <CONFIG_K3_ATF_LOAD_ADDR>;
-					atf-bl31 {
-						filename = "bl31.bin";
-					};
-				};
-
-				tee {
-					description = "OP-TEE";
-					type = "tee";
-					arch = "arm64";
-					compression = "none";
-					os = "tee";
-					load = <0x9e800000>;
-					entry = <0x9e800000>;
-					tee-os {
-						filename = "tee-raw.bin";
-					};
-				};
-
 				dm {
-					description = "DM binary";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "DM";
-					load = <0x89000000>;
-					entry = <0x89000000>;
 					blob-ext {
 						filename = "ti-dm.bin";
 					};
 				};
 
-				spl {
-					description = "SPL (64-bit)";
-					type = "standalone";
-					os = "U-Boot";
-					arch = "arm64";
-					compression = "none";
-					load = <CONFIG_SPL_TEXT_BASE>;
-					entry = <CONFIG_SPL_TEXT_BASE>;
-					blob {
-						filename = "spl/u-boot-spl-nodtb.bin";
-					};
-				};
-
 				fdt-0 {
 					description = "k3-am62a7-sk";
 					type = "flat_dt";
@@ -414,26 +282,12 @@
 
 &binman {
 	u-boot_unsigned {
-		filename = "u-boot.img_unsigned";
-		pad-byte = <0xff>;
+		insert-template = <&u_boot_unsigned_template>;
 
 		fit {
-			description = "FIT image with multiple configurations";
-
 			images {
 				uboot {
-					description = "U-Boot for AM62Ax board";
-					type = "firmware";
-					os = "u-boot";
-					arch = "arm";
-					compression = "none";
-					load = <CONFIG_TEXT_BASE>;
-					blob {
-						filename = UBOOT_NODTB;
-					};
-					hash {
-						algo = "crc32";
-					};
+					description = "U-Boot for AM62Ax Board";
 				};
 
 				fdt-0 {
diff --git a/arch/arm/dts/k3-am64x-binman.dtsi b/arch/arm/dts/k3-am64x-binman.dtsi
index a5e54006b4..88df214954 100644
--- a/arch/arm/dts/k3-am64x-binman.dtsi
+++ b/arch/arm/dts/k3-am64x-binman.dtsi
@@ -118,87 +118,27 @@
 
 #ifdef CONFIG_TARGET_AM642_A53_EVM
 
-#define SPL_NODTB "spl/u-boot-spl-nodtb.bin"
 #define SPL_AM642_EVM_DTB "spl/dts/k3-am642-evm.dtb"
 #define SPL_AM642_SK_DTB "spl/dts/k3-am642-sk.dtb"
 
-#define UBOOT_NODTB "u-boot-nodtb.bin"
 #define AM642_EVM_DTB "u-boot.dtb"
 #define AM642_SK_DTB "arch/arm/dts/k3-am642-sk.dtb"
 
 &binman {
 	ti-spl {
-		filename = "tispl.bin";
-		pad-byte = <0xff>;
+		insert-template = <&ti_spl_template>;
 
 		fit {
 			description = "Configuration to load ATF and SPL";
 			#address-cells = <1>;
 
 			images {
-
-				atf {
-					description = "ARM Trusted Firmware";
-					type = "firmware";
-					arch = "arm64";
-					compression = "none";
-					os = "arm-trusted-firmware";
-					load = <CONFIG_K3_ATF_LOAD_ADDR>;
-					entry = <CONFIG_K3_ATF_LOAD_ADDR>;
-					ti-secure {
-						content = <&atf>;
-						keyfile = "custMpk.pem";
-					};
-					atf: atf-bl31 {
-					};
-				};
-
-				tee {
-					description = "OP-TEE";
-					type = "tee";
-					arch = "arm64";
-					compression = "none";
-					os = "tee";
-					load = <0x9e800000>;
-					entry = <0x9e800000>;
-					ti-secure {
-						content = <&tee>;
-						keyfile = "custMpk.pem";
-					};
-					tee: tee-os {
-					};
-				};
-
 				dm {
-					description = "DM binary";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "DM";
-					load = <0x89000000>;
-					entry = <0x89000000>;
 					blob-ext {
 						filename = "/dev/null";
 					};
 				};
 
-				spl {
-					description = "SPL (64-bit)";
-					type = "standalone";
-					os = "U-Boot";
-					arch = "arm64";
-					compression = "none";
-					load = <CONFIG_SPL_TEXT_BASE>;
-					entry = <CONFIG_SPL_TEXT_BASE>;
-					ti-secure {
-						content = <&u_boot_spl_nodtb>;
-						keyfile = "custMpk.pem";
-
-					};
-					u_boot_spl_nodtb: blob-ext {
-						filename = SPL_NODTB;
-					};
-				};
 
 				fdt-0 {
 					description = "k3-am642-evm";
@@ -254,29 +194,12 @@
 
 &binman {
 	u-boot {
-		filename = "u-boot.img";
-		pad-byte = <0xff>;
+		insert-template = <&u_boot_template>;
 
 		fit {
-			description = "FIT image with multiple configurations";
-
 			images {
 				uboot {
-					description = "U-Boot for AM64 board";
-					type = "firmware";
-					os = "u-boot";
-					arch = "arm";
-					compression = "none";
-					load = <CONFIG_TEXT_BASE>;
-					ti-secure {
-						content = <&u_boot_nodtb>;
-						keyfile = "custMpk.pem";
-					};
-					u_boot_nodtb: u-boot-nodtb {
-					};
-					hash {
-						algo = "crc32";
-					};
+					description = "U-Boot for AM64 Board";
 				};
 
 				fdt-0 {
@@ -340,65 +263,17 @@
 
 &binman {
 	ti-spl_unsigned {
-		filename = "tispl.bin_unsigned";
-		pad-byte = <0xff>;
+		insert-template = <&ti_spl_unsigned_template>;
 
 		fit {
-			description = "Configuration to load ATF and SPL";
-			#address-cells = <1>;
-
 			images {
 
-				atf {
-					description = "ARM Trusted Firmware";
-					type = "firmware";
-					arch = "arm64";
-					compression = "none";
-					os = "arm-trusted-firmware";
-					load = <CONFIG_K3_ATF_LOAD_ADDR>;
-					entry = <CONFIG_K3_ATF_LOAD_ADDR>;
-					atf-bl31 {
-					};
-				};
-
-				tee {
-					description = "OP-TEE";
-					type = "tee";
-					arch = "arm64";
-					compression = "none";
-					os = "tee";
-					load = <0x9e800000>;
-					entry = <0x9e800000>;
-					tee-os {
-					};
-				};
-
 				dm {
-					description = "DM binary";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "DM";
-					load = <0x89000000>;
-					entry = <0x89000000>;
 					blob-ext {
 						filename = "/dev/null";
 					};
 				};
 
-				spl {
-					description = "SPL (64-bit)";
-					type = "standalone";
-					os = "U-Boot";
-					arch = "arm64";
-					compression = "none";
-					load = <CONFIG_SPL_TEXT_BASE>;
-					entry = <CONFIG_SPL_TEXT_BASE>;
-					blob {
-						filename = "spl/u-boot-spl-nodtb.bin";
-					};
-				};
-
 				fdt-0 {
 					description = "k3-am642-evm";
 					type = "flat_dt";
@@ -443,26 +318,12 @@
 
 &binman {
 	u-boot_unsigned {
-		filename = "u-boot.img_unsigned";
-		pad-byte = <0xff>;
+		insert-template = <&u_boot_unsigned_template>;
 
 		fit {
-			description = "FIT image with multiple configurations";
-
 			images {
 				uboot {
-					description = "U-Boot for AM64 board";
-					type = "firmware";
-					os = "u-boot";
-					arch = "arm";
-					compression = "none";
-					load = <CONFIG_TEXT_BASE>;
-					blob {
-						filename = UBOOT_NODTB;
-					};
-					hash {
-						algo = "crc32";
-					};
+					description = "U-Boot for AM64 Board";
 				};
 
 				fdt-0 {
diff --git a/arch/arm/dts/k3-am65x-binman.dtsi b/arch/arm/dts/k3-am65x-binman.dtsi
index 59605ca597..8cc24da1f3 100644
--- a/arch/arm/dts/k3-am65x-binman.dtsi
+++ b/arch/arm/dts/k3-am65x-binman.dtsi
@@ -42,77 +42,7 @@
 	};
 	itb {
 		filename = "sysfw-am65x_sr2-hs-evm.itb";
-		fit {
-			description = "SYSFW and Config fragments";
-			#address-cells = <1>;
-			images {
-				sysfw.bin {
-					description = "sysfw";
-					type = "firmware";
-					arch = "arm";
-					compression = "none";
-					blob-ext {
-					    filename = "sysfw.bin";
-					};
-				};
-				board-cfg.bin {
-					description = "board-cfg";
-					type = "firmware";
-					arch = "arm";
-					compression = "none";
-					ti-secure {
-						content = <&board_cfg>;
-						keyfile = "custMpk.pem";
-					};
-					board_cfg: board-cfg {
-						filename = "board-cfg.bin";
-						type = "blob-ext";
-					};
-				};
-				pm-cfg.bin {
-					description = "pm-cfg";
-					type = "firmware";
-					arch = "arm";
-					compression = "none";
-					ti-secure {
-						content = <&pm_cfg>;
-						keyfile = "custMpk.pem";
-					};
-					pm_cfg: pm-cfg {
-						filename = "pm-cfg.bin";
-						type = "blob-ext";
-					};
-				};
-				rm-cfg.bin {
-					description = "rm-cfg";
-					type = "firmware";
-					arch = "arm";
-					compression = "none";
-					ti-secure {
-						content = <&rm_cfg>;
-						keyfile = "custMpk.pem";\
-					};
-					rm_cfg: rm-cfg {
-						filename = "rm-cfg.bin";
-						type = "blob-ext";
-					};
-				};
-				sec-cfg.bin {
-					description = "sec-cfg";
-					type = "firmware";
-					arch = "arm";
-					compression = "none";
-					ti-secure {
-						content = <&sec_cfg>;
-						keyfile = "custMpk.pem";
-					};
-					sec_cfg: sec-cfg {
-						filename = "sec-cfg.bin";
-						type = "blob-ext";
-					};
-				};
-			};
-		};
+		insert-template = <&itb_template>;
 	};
 };
 
@@ -149,55 +79,14 @@
 	itb_gp {
 		filename = "sysfw-am65x_sr2-gp-evm.itb";
 		symlink = "sysfw.itb";
+		insert-template = <&itb_unsigned_template>;
 		fit {
-			description = "SYSFW and Config fragments";
-			#address-cells = <1>;
 			images {
 				sysfw.bin {
-					description = "sysfw";
-					type = "firmware";
-					arch = "arm";
-					compression = "none";
 					blob-ext {
 					    filename = "sysfw.bin_gp";
 					};
 				};
-				board-cfg.bin {
-					description = "board-cfg";
-					type = "firmware";
-					arch = "arm";
-					compression = "none";
-					blob-ext {
-						filename = "board-cfg.bin";
-					};
-				};
-				pm-cfg.bin {
-					description = "pm-cfg";
-					type = "firmware";
-					arch = "arm";
-					compression = "none";
-					blob-ext {
-						filename = "pm-cfg.bin";
-					};
-				};
-				rm-cfg.bin {
-					description = "rm-cfg";
-					type = "firmware";
-					arch = "arm";
-					compression = "none";
-					blob-ext {
-						filename = "rm-cfg.bin";
-					};
-				};
-				sec-cfg.bin {
-					description = "sec-cfg";
-					type = "firmware";
-					arch = "arm";
-					compression = "none";
-					blob-ext {
-						filename = "sec-cfg.bin";
-					};
-				};
 			};
 		};
 	};
@@ -206,86 +95,22 @@
 
 #ifdef CONFIG_TARGET_AM654_A53_EVM
 
-#define SPL_NODTB "spl/u-boot-spl-nodtb.bin"
 #define SPL_AM654_EVM_DTB "spl/dts/k3-am654-base-board.dtb"
-
-#define UBOOT_NODTB "u-boot-nodtb.bin"
 #define AM654_EVM_DTB "u-boot.dtb"
 
 &binman {
 	ti-spl {
-		filename = "tispl.bin";
-		pad-byte = <0xff>;
+		insert-template = <&ti_spl_template>;
 
 		fit {
-			description = "Configuration to load ATF and SPL";
-			#address-cells = <1>;
-
 			images {
 
-				atf {
-					description = "ARM Trusted Firmware";
-					type = "firmware";
-					arch = "arm64";
-					compression = "none";
-					os = "arm-trusted-firmware";
-					load = <CONFIG_K3_ATF_LOAD_ADDR>;
-					entry = <CONFIG_K3_ATF_LOAD_ADDR>;
-					ti-secure {
-						content = <&atf>;
-						keyfile = "custMpk.pem";
-					};
-					atf: atf-bl31 {
-					};
-				};
-
-				tee {
-					description = "OP-TEE";
-					type = "tee";
-					arch = "arm64";
-					compression = "none";
-					os = "tee";
-					load = <0x9e800000>;
-					entry = <0x9e800000>;
-					ti-secure {
-						content = <&tee>;
-						keyfile = "custMpk.pem";
-					};
-					tee: tee-os {
-					};
-				};
-
 				dm {
-					description = "DM binary";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "DM";
-					load = <0x89000000>;
-					entry = <0x89000000>;
 					blob-ext {
 						filename = "/dev/null";
 					};
 				};
 
-				spl {
-					description = "SPL (64-bit)";
-					type = "standalone";
-					os = "U-Boot";
-					arch = "arm64";
-					compression = "none";
-					load = <CONFIG_SPL_TEXT_BASE>;
-					entry = <CONFIG_SPL_TEXT_BASE>;
-					ti-secure {
-						content = <&u_boot_spl_nodtb>;
-						keyfile = "custMpk.pem";
-
-					};
-					u_boot_spl_nodtb: blob-ext {
-						filename = SPL_NODTB;
-					};
-				};
-
 				fdt-0 {
 					description = "k3-am654-base-board";
 					type = "flat_dt";
@@ -317,29 +142,12 @@
 
 &binman {
 	u-boot {
-		filename = "u-boot.img";
-		pad-byte = <0xff>;
+		insert-template = <&u_boot_template>;
 
 		fit {
-			description = "FIT image with multiple configurations";
-
 			images {
 				uboot {
-					description = "U-Boot for AM65 board";
-					type = "firmware";
-					os = "u-boot";
-					arch = "arm";
-					compression = "none";
-					load = <CONFIG_TEXT_BASE>;
-					ti-secure {
-						content = <&u_boot_nodtb>;
-						keyfile = "custMpk.pem";
-					};
-					u_boot_nodtb: u-boot-nodtb {
-					};
-					hash {
-						algo = "crc32";
-					};
+					description = "U-Boot for AM65 Board";
 				};
 
 				fdt-0 {
@@ -378,67 +186,16 @@
 
 &binman {
 	ti-spl_unsigned {
-		filename = "tispl.bin_unsigned";
-		pad-byte = <0xff>;
+		insert-template = <&ti_spl_unsigned_template>;
 
 		fit {
-			description = "Configuration to load ATF and SPL";
-			#address-cells = <1>;
-
 			images {
-
-				atf {
-					description = "ARM Trusted Firmware";
-					type = "firmware";
-					arch = "arm64";
-					compression = "none";
-					os = "arm-trusted-firmware";
-					load = <CONFIG_K3_ATF_LOAD_ADDR>;
-					entry = <CONFIG_K3_ATF_LOAD_ADDR>;
-					atf-bl31 {
-						filename = "bl31.bin";
-					};
-				};
-
-				tee {
-					description = "OP-TEE";
-					type = "tee";
-					arch = "arm64";
-					compression = "none";
-					os = "tee";
-					load = <0x9e800000>;
-					entry = <0x9e800000>;
-					tee-os {
-						filename = "tee-raw.bin";
-					};
-				};
-
 				dm {
-					description = "DM binary";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "DM";
-					load = <0x89000000>;
-					entry = <0x89000000>;
 					blob-ext {
 						filename = "/dev/null";
 					};
 				};
 
-				spl {
-					description = "SPL (64-bit)";
-					type = "standalone";
-					os = "U-Boot";
-					arch = "arm64";
-					compression = "none";
-					load = <CONFIG_SPL_TEXT_BASE>;
-					entry = <CONFIG_SPL_TEXT_BASE>;
-					blob-ext {
-						filename = SPL_NODTB;
-					};
-				};
-
 				fdt-0 {
 					description = "k3-j721e-common-proc-board";
 					type = "flat_dt";
@@ -466,26 +223,12 @@
 
 &binman {
 	u-boot_unsigned {
-		filename = "u-boot.img_unsigned";
-		pad-byte = <0xff>;
+		insert-template = <&u_boot_unsigned_template>;
 
 		fit {
-			description = "FIT image with multiple configurations";
-
 			images {
 				uboot {
-					description = "U-Boot for AM65 board";
-					type = "firmware";
-					os = "u-boot";
-					arch = "arm";
-					compression = "none";
-					load = <CONFIG_TEXT_BASE>;
-					blob {
-						filename = UBOOT_NODTB;
-					};
-					hash {
-						algo = "crc32";
-					};
+					description = "U-Boot for AM65 Board";
 				};
 
 				fdt-0 {
diff --git a/arch/arm/dts/k3-j7200-binman.dtsi b/arch/arm/dts/k3-j7200-binman.dtsi
index 14f7dea65e..10c9d6cba7 100644
--- a/arch/arm/dts/k3-j7200-binman.dtsi
+++ b/arch/arm/dts/k3-j7200-binman.dtsi
@@ -180,10 +180,7 @@
 
 #ifdef CONFIG_TARGET_J7200_A72_EVM
 
-#define SPL_NODTB "spl/u-boot-spl-nodtb.bin"
 #define SPL_J7200_EVM_DTB "spl/dts/k3-j7200-common-proc-board.dtb"
-
-#define UBOOT_NODTB "u-boot-nodtb.bin"
 #define J7200_EVM_DTB "u-boot.dtb"
 
 &binman {
@@ -194,82 +191,20 @@
 		};
 	};
 	ti-spl {
-		filename = "tispl.bin";
-		pad-byte = <0xff>;
+		insert-template = <&ti_spl_template>;
 
 		fit {
-			description = "Configuration to load ATF and SPL";
-			#address-cells = <1>;
-
 			images {
-
-				atf {
-					description = "ARM Trusted Firmware";
-					type = "firmware";
-					arch = "arm64";
-					compression = "none";
-					os = "arm-trusted-firmware";
-					load = <CONFIG_K3_ATF_LOAD_ADDR>;
-					entry = <CONFIG_K3_ATF_LOAD_ADDR>;
-					ti-secure {
-						content = <&atf>;
-						keyfile = "custMpk.pem";
-					};
-					atf: atf-bl31 {
-					};
-				};
-
-				tee {
-					description = "OP-TEE";
-					type = "tee";
-					arch = "arm64";
-					compression = "none";
-					os = "tee";
-					load = <0x9e800000>;
-					entry = <0x9e800000>;
-					ti-secure {
-						content = <&tee>;
-						keyfile = "custMpk.pem";
-					};
-					tee: tee-os {
-					};
-				};
-
 				dm {
-					description = "DM binary";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "DM";
-					load = <0x89000000>;
-					entry = <0x89000000>;
 					ti-secure {
 						content = <&dm>;
 						keyfile = "custMpk.pem";
 					};
-
 					dm: blob-ext {
 						filename = "ti-dm.bin";
 					};
 				};
 
-				spl {
-					description = "SPL (64-bit)";
-					type = "standalone";
-					os = "U-Boot";
-					arch = "arm64";
-					compression = "none";
-					load = <CONFIG_SPL_TEXT_BASE>;
-					entry = <CONFIG_SPL_TEXT_BASE>;
-					ti-secure {
-						content = <&u_boot_spl_nodtb>;
-						keyfile = "custMpk.pem";
-					};
-					u_boot_spl_nodtb: blob-ext {
-						filename = SPL_NODTB;
-					};
-				};
-
 				fdt-0 {
 					description = "k3-j7200-common-proc-board";
 					type = "flat_dt";
@@ -302,29 +237,12 @@
 
 &binman {
 	u-boot {
-		filename = "u-boot.img";
-		pad-byte = <0xff>;
+		insert-template = <&u_boot_template>;
 
 		fit {
-			description = "FIT image with multiple configurations";
-
 			images {
 				uboot {
-					description = "U-Boot for J7200 board";
-					type = "firmware";
-					os = "u-boot";
-					arch = "arm";
-					compression = "none";
-					load = <CONFIG_TEXT_BASE>;
-					ti-secure {
-						content = <&u_boot_nodtb>;
-						keyfile = "custMpk.pem";
-					};
-					u_boot_nodtb: u-boot-nodtb {
-					};
-					hash {
-						algo = "crc32";
-					};
+					description = "U-Boot for J7200 Board";
 				};
 
 				fdt-0 {
@@ -362,67 +280,16 @@
 
 &binman {
 	ti-spl_unsigned {
-		filename = "tispl.bin_unsigned";
-		pad-byte = <0xff>;
+		insert-template = <&ti_spl_unsigned_template>;
 
 		fit {
-			description = "Configuration to load ATF and SPL";
-			#address-cells = <1>;
-
 			images {
-
-				atf {
-					description = "ARM Trusted Firmware";
-					type = "firmware";
-					arch = "arm64";
-					compression = "none";
-					os = "arm-trusted-firmware";
-					load = <CONFIG_K3_ATF_LOAD_ADDR>;
-					entry = <CONFIG_K3_ATF_LOAD_ADDR>;
-					atf-bl31 {
-						filename = "bl31.bin";
-					};
-				};
-
-				tee {
-					description = "OP-TEE";
-					type = "tee";
-					arch = "arm64";
-					compression = "none";
-					os = "tee";
-					load = <0x9e800000>;
-					entry = <0x9e800000>;
-					tee-os {
-						filename = "tee-raw.bin";
-					};
-				};
-
 				dm {
-					description = "DM binary";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "DM";
-					load = <0x89000000>;
-					entry = <0x89000000>;
 					blob-ext {
 						filename = "ti-dm.bin";
 					};
 				};
 
-				spl {
-					description = "SPL (64-bit)";
-					type = "standalone";
-					os = "U-Boot";
-					arch = "arm64";
-					compression = "none";
-					load = <CONFIG_SPL_TEXT_BASE>;
-					entry = <CONFIG_SPL_TEXT_BASE>;
-					blob {
-						filename = SPL_NODTB;
-					};
-				};
-
 				fdt-1 {
 					description = "k3-j7200-common-proc-board";
 					type = "flat_dt";
@@ -450,26 +317,12 @@
 
 &binman {
 	u-boot_unsigned {
-		filename = "u-boot.img_unsigned";
-		pad-byte = <0xff>;
+		insert-template = <&u_boot_unsigned_template>;
 
 		fit {
-			description = "FIT image with multiple configurations";
-
 			images {
 				uboot {
-					description = "U-Boot for J7200 board";
-					type = "firmware";
-					os = "u-boot";
-					arch = "arm";
-					compression = "none";
-					load = <CONFIG_TEXT_BASE>;
-					blob {
-						filename = UBOOT_NODTB;
-					};
-					hash {
-						algo = "crc32";
-					};
+					description = "U-Boot for J7200 Board";
 				};
 
 				fdt-1 {
diff --git a/arch/arm/dts/k3-j721e-binman.dtsi b/arch/arm/dts/k3-j721e-binman.dtsi
index 4f566c21a9..5ddb474e3a 100644
--- a/arch/arm/dts/k3-j721e-binman.dtsi
+++ b/arch/arm/dts/k3-j721e-binman.dtsi
@@ -42,78 +42,7 @@
 	};
 	itb {
 		filename = "sysfw-j721e_sr1_1-hs-evm.itb";
-		fit {
-			description = "SYSFW and Config fragments";
-			#address-cells = <1>;
-			images {
-				sysfw.bin {
-					description = "sysfw";
-					type = "firmware";
-					arch = "arm";
-					compression = "none";
-					blob-ext {
-					    filename = "sysfw.bin";
-					};
-				};
-				board-cfg.bin {
-					description = "board-cfg";
-					type = "firmware";
-					arch = "arm";
-					compression = "none";
-					ti-secure {
-						content = <&board_cfg>;
-						keyfile = "custMpk.pem";
-					};
-					board_cfg: board-cfg {
-						filename = "board-cfg.bin";
-						type = "blob-ext";
-					};
-
-				};
-				pm-cfg.bin {
-					description = "pm-cfg";
-					type = "firmware";
-					arch = "arm";
-					compression = "none";
-					ti-secure {
-						content = <&pm_cfg>;
-						keyfile = "custMpk.pem";
-					};
-					pm_cfg: pm-cfg {
-						filename = "pm-cfg.bin";
-						type = "blob-ext";
-					};
-				};
-				rm-cfg.bin {
-					description = "rm-cfg";
-					type = "firmware";
-					arch = "arm";
-					compression = "none";
-					ti-secure {
-						content = <&rm_cfg>;
-						keyfile = "custMpk.pem";
-					};
-					rm_cfg: rm-cfg {
-						filename = "rm-cfg.bin";
-						type = "blob-ext";
-					};
-				};
-				sec-cfg.bin {
-					description = "sec-cfg";
-					type = "firmware";
-					arch = "arm";
-					compression = "none";
-					ti-secure {
-						content = <&sec_cfg>;
-						keyfile = "custMpk.pem";
-					};
-					sec_cfg: sec-cfg {
-						filename = "sec-cfg.bin";
-						type = "blob-ext";
-					};
-				};
-			};
-		};
+		insert-template = <&itb_template>;
 	};
 };
 
@@ -145,62 +74,7 @@
 	};
 	itb_fs {
 		filename = "sysfw-j721e_sr2-hs-fs-evm.itb";
-		fit {
-			description = "SYSFW and Config fragments";
-			#address-cells = <1>;
-			images {
-				sysfw.bin {
-					description = "sysfw";
-					type = "firmware";
-					arch = "arm";
-					compression = "none";
-					blob-ext {
-					    filename = "sysfw.bin_fs";
-					};
-				};
-				board-cfg.bin {
-					description = "board-cfg";
-					type = "firmware";
-					arch = "arm";
-					compression = "none";
-					board-cfg {
-						filename = "board-cfg.bin";
-						type = "blob-ext";
-					};
-
-				};
-				pm-cfg.bin {
-					description = "pm-cfg";
-					type = "firmware";
-					arch = "arm";
-					compression = "none";
-					pm-cfg {
-						filename = "pm-cfg.bin";
-						type = "blob-ext";
-					};
-				};
-				rm-cfg.bin {
-					description = "rm-cfg";
-					type = "firmware";
-					arch = "arm";
-					compression = "none";
-					rm-cfg {
-						filename = "rm-cfg.bin";
-						type = "blob-ext";
-					};
-				};
-				sec-cfg.bin {
-					description = "sec-cfg";
-					type = "firmware";
-					arch = "arm";
-					compression = "none";
-					sec-cfg {
-						filename = "sec-cfg.bin";
-						type = "blob-ext";
-					};
-				};
-			};
-		};
+		insert-template = <&itb_unsigned_template>;
 	};
 };
 
@@ -237,55 +111,15 @@
 	itb_gp {
 		filename = "sysfw-j721e-gp-evm.itb";
 		symlink = "sysfw.itb";
+		insert-template = <&itb_unsigned_template>;
+
 		fit {
-			description = "SYSFW and Config fragments";
-			#address-cells = <1>;
 			images {
 				sysfw.bin {
-					description = "sysfw";
-					type = "firmware";
-					arch = "arm";
-					compression = "none";
 					blob-ext {
 					    filename = "sysfw.bin_gp";
 					};
 				};
-				board-cfg.bin {
-					description = "board-cfg";
-					type = "firmware";
-					arch = "arm";
-					compression = "none";
-					blob-ext {
-						filename = "board-cfg.bin";
-					};
-				};
-				pm-cfg.bin {
-					description = "pm-cfg";
-					type = "firmware";
-					arch = "arm";
-					compression = "none";
-					blob-ext {
-						filename = "pm-cfg.bin";
-					};
-				};
-				rm-cfg.bin {
-					description = "rm-cfg";
-					type = "firmware";
-					arch = "arm";
-					compression = "none";
-					blob-ext {
-						filename = "rm-cfg.bin";
-					};
-				};
-				sec-cfg.bin {
-					description = "sec-cfg";
-					type = "firmware";
-					arch = "arm";
-					compression = "none";
-					blob-ext {
-						filename = "sec-cfg.bin";
-					};
-				};
 			};
 		};
 	};
@@ -294,11 +128,9 @@
 
 #ifdef CONFIG_TARGET_J721E_A72_EVM
 
-#define SPL_NODTB "spl/u-boot-spl-nodtb.bin"
 #define SPL_J721E_EVM_DTB "spl/dts/k3-j721e-common-proc-board.dtb"
 #define SPL_J721E_SK_DTB "spl/dts/k3-j721e-sk.dtb"
 
-#define UBOOT_NODTB "u-boot-nodtb.bin"
 #define J721E_EVM_DTB "u-boot.dtb"
 #define J721E_SK_DTB "arch/arm/dts/k3-j721e-sk.dtb"
 
@@ -310,55 +142,11 @@
 		};
 	};
 	ti-spl {
-		filename = "tispl.bin";
-		pad-byte = <0xff>;
+		insert-template = <&ti_spl_template>;
 
 		fit {
-			description = "Configuration to load ATF and SPL";
-			#address-cells = <1>;
-
 			images {
-
-				atf {
-					description = "ARM Trusted Firmware";
-					type = "firmware";
-					arch = "arm64";
-					compression = "none";
-					os = "arm-trusted-firmware";
-					load = <CONFIG_K3_ATF_LOAD_ADDR>;
-					entry = <CONFIG_K3_ATF_LOAD_ADDR>;
-					ti-secure {
-						content = <&atf>;
-						keyfile = "custMpk.pem";
-					};
-					atf: atf-bl31 {
-					};
-				};
-
-				tee {
-					description = "OP-TEE";
-					type = "tee";
-					arch = "arm64";
-					compression = "none";
-					os = "tee";
-					load = <0x9e800000>;
-					entry = <0x9e800000>;
-					ti-secure {
-						content = <&tee>;
-						keyfile = "custMpk.pem";
-					};
-					tee: tee-os {
-					};
-				};
-
 				dm {
-					description = "DM binary";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "DM";
-					load = <0x89000000>;
-					entry = <0x89000000>;
 					ti-secure {
 						content = <&dm>;
 						keyfile = "custMpk.pem";
@@ -368,24 +156,6 @@
 					};
 				};
 
-				spl {
-					description = "SPL (64-bit)";
-					type = "standalone";
-					os = "U-Boot";
-					arch = "arm64";
-					compression = "none";
-					load = <CONFIG_SPL_TEXT_BASE>;
-					entry = <CONFIG_SPL_TEXT_BASE>;
-					ti-secure {
-						content = <&u_boot_spl_nodtb>;
-						keyfile = "custMpk.pem";
-
-					};
-					u_boot_spl_nodtb: blob-ext {
-						filename = SPL_NODTB;
-					};
-				};
-
 				fdt-0 {
 					description = "k3-j721e-common-proc-board";
 					type = "flat_dt";
@@ -439,29 +209,12 @@
 
 &binman {
 	u-boot {
-		filename = "u-boot.img";
-		pad-byte = <0xff>;
-
+		insert-template = <&u_boot_template>;
 		fit {
-			description = "FIT image with multiple configurations";
 
 			images {
 				uboot {
-					description = "U-Boot for j721e board";
-					type = "firmware";
-					os = "u-boot";
-					arch = "arm";
-					compression = "none";
-					load = <CONFIG_TEXT_BASE>;
-					ti-secure {
-						content = <&u_boot_nodtb>;
-						keyfile = "custMpk.pem";
-					};
-					u_boot_nodtb: u-boot-nodtb {
-					};
-					hash {
-						algo = "crc32";
-					};
+					description = "U-Boot for J721E Board";
 				};
 
 				fdt-0 {
@@ -524,67 +277,16 @@
 
 &binman {
 	ti-spl_unsigned {
-		filename = "tispl.bin_unsigned";
-		pad-byte = <0xff>;
+		insert-template = <&ti_spl_unsigned_template>;
 
 		fit {
-			description = "Configuration to load ATF and SPL";
-			#address-cells = <1>;
-
 			images {
-
-				atf {
-					description = "ARM Trusted Firmware";
-					type = "firmware";
-					arch = "arm64";
-					compression = "none";
-					os = "arm-trusted-firmware";
-					load = <CONFIG_K3_ATF_LOAD_ADDR>;
-					entry = <CONFIG_K3_ATF_LOAD_ADDR>;
-					atf-bl31 {
-						filename = "bl31.bin";
-					};
-				};
-
-				tee {
-					description = "OP-TEE";
-					type = "tee";
-					arch = "arm64";
-					compression = "none";
-					os = "tee";
-					load = <0x9e800000>;
-					entry = <0x9e800000>;
-					tee-os {
-						filename = "tee-raw.bin";
-					};
-				};
-
 				dm {
-					description = "DM binary";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "DM";
-					load = <0x89000000>;
-					entry = <0x89000000>;
 					blob-ext {
 						filename = "ti-dm.bin";
 					};
 				};
 
-				spl {
-					description = "SPL (64-bit)";
-					type = "standalone";
-					os = "U-Boot";
-					arch = "arm64";
-					compression = "none";
-					load = <CONFIG_SPL_TEXT_BASE>;
-					entry = <CONFIG_SPL_TEXT_BASE>;
-					blob-ext {
-						filename = SPL_NODTB;
-					};
-				};
-
 				fdt-0 {
 					description = "k3-j721e-common-proc-board";
 					type = "flat_dt";
@@ -629,26 +331,12 @@
 
 &binman {
 	u-boot_unsigned {
-		filename = "u-boot.img_unsigned";
-		pad-byte = <0xff>;
+		insert-template = <&u_boot_unsigned_template>;
 
 		fit {
-			description = "FIT image with multiple configurations";
-
 			images {
 				uboot {
-					description = "U-Boot for j721e board";
-					type = "firmware";
-					os = "u-boot";
-					arch = "arm";
-					compression = "none";
-					load = <CONFIG_TEXT_BASE>;
-					blob {
-						filename = UBOOT_NODTB;
-					};
-					hash {
-						algo = "crc32";
-					};
+					description = "U-Boot for J721E Board";
 				};
 
 				fdt-0 {
diff --git a/arch/arm/dts/k3-j721s2-binman.dtsi b/arch/arm/dts/k3-j721s2-binman.dtsi
index 5bca4e94ec..3922007b3b 100644
--- a/arch/arm/dts/k3-j721s2-binman.dtsi
+++ b/arch/arm/dts/k3-j721s2-binman.dtsi
@@ -141,11 +141,9 @@
 
 #ifdef CONFIG_TARGET_J721S2_A72_EVM
 
-#define SPL_NODTB "spl/u-boot-spl-nodtb.bin"
 #define SPL_J721S2_EVM_DTB "spl/dts/k3-j721s2-common-proc-board.dtb"
 #define SPL_AM68_SK_DTB "spl/dts/k3-am68-sk-base-board.dtb"
 
-#define UBOOT_NODTB "u-boot-nodtb.bin"
 #define J721S2_EVM_DTB "u-boot.dtb"
 #define AM68_SK_DTB "arch/arm/dts/k3-am68-sk-base-board.dtb"
 
@@ -157,55 +155,11 @@
 		};
 	};
 	ti-spl {
-		filename = "tispl.bin";
-		pad-byte = <0xff>;
+		insert-template = <&ti_spl_template>;
 
 		fit {
-			description = "Configuration to load ATF and SPL";
-			#address-cells = <1>;
-
 			images {
-
-				atf {
-					description = "ARM Trusted Firmware";
-					type = "firmware";
-					arch = "arm64";
-					compression = "none";
-					os = "arm-trusted-firmware";
-					load = <CONFIG_K3_ATF_LOAD_ADDR>;
-					entry = <CONFIG_K3_ATF_LOAD_ADDR>;
-					ti-secure {
-						content = <&atf>;
-						keyfile = "custMpk.pem";
-					};
-					atf: atf-bl31 {
-					};
-				};
-
-				tee {
-					description = "OP-TEE";
-					type = "tee";
-					arch = "arm64";
-					compression = "none";
-					os = "tee";
-					load = <0x9e800000>;
-					entry = <0x9e800000>;
-					ti-secure {
-						content = <&tee>;
-						keyfile = "custMpk.pem";
-					};
-					tee: tee-os {
-					};
-				};
-
 				dm {
-					description = "DM binary";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "DM";
-					load = <0x89000000>;
-					entry = <0x89000000>;
 					ti-secure {
 						content = <&dm>;
 						keyfile = "custMpk.pem";
@@ -215,23 +169,6 @@
 					};
 				};
 
-				spl {
-					description = "SPL (64-bit)";
-					type = "standalone";
-					os = "U-Boot";
-					arch = "arm64";
-					compression = "none";
-					load = <CONFIG_SPL_TEXT_BASE>;
-					entry = <CONFIG_SPL_TEXT_BASE>;
-					ti-secure {
-						content = <&u_boot_spl_nodtb>;
-						keyfile = "custMpk.pem";
-					};
-					u_boot_spl_nodtb: blob-ext {
-						filename = SPL_NODTB;
-					};
-				};
-
 				fdt-0 {
 					description = "k3-j721s2-common-proc-board";
 					type = "flat_dt";
@@ -285,29 +222,12 @@
 
 &binman {
 	u-boot {
-		filename = "u-boot.img";
-		pad-byte = <0xff>;
+		insert-template = <&u_boot_template>;
 
 		fit {
-			description = "FIT image with multiple configurations";
-
 			images {
 				uboot {
-					description = "U-Boot for J721S2 board";
-					type = "firmware";
-					os = "u-boot";
-					arch = "arm";
-					compression = "none";
-					load = <CONFIG_TEXT_BASE>;
-					ti-secure {
-						content = <&u_boot_nodtb>;
-						keyfile = "custMpk.pem";
-					};
-					u_boot_nodtb: u-boot-nodtb {
-					};
-					hash {
-						algo = "crc32";
-					};
+					description = "U-Boot for J721S2 Board";
 				};
 
 				fdt-0 {
@@ -371,67 +291,16 @@
 
 &binman {
 	ti-spl_unsigned {
-		filename = "tispl.bin_unsigned";
-		pad-byte = <0xff>;
+		insert-template = <&ti_spl_unsigned_template>;
 
 		fit {
-			description = "Configuration to load ATF and SPL";
-			#address-cells = <1>;
-
 			images {
-
-				atf {
-					description = "ARM Trusted Firmware";
-					type = "firmware";
-					arch = "arm64";
-					compression = "none";
-					os = "arm-trusted-firmware";
-					load = <CONFIG_K3_ATF_LOAD_ADDR>;
-					entry = <CONFIG_K3_ATF_LOAD_ADDR>;
-					atf-bl31 {
-						filename = "bl31.bin";
-					};
-				};
-
-				tee {
-					description = "OP-TEE";
-					type = "tee";
-					arch = "arm64";
-					compression = "none";
-					os = "tee";
-					load = <0x9e800000>;
-					entry = <0x9e800000>;
-					tee-os {
-						filename = "tee-raw.bin";
-					};
-				};
-
 				dm {
-					description = "DM binary";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "DM";
-					load = <0x89000000>;
-					entry = <0x89000000>;
 					blob-ext {
 						filename = "ti-dm.bin";
 					};
 				};
 
-				spl {
-					description = "SPL (64-bit)";
-					type = "standalone";
-					os = "U-Boot";
-					arch = "arm64";
-					compression = "none";
-					load = <CONFIG_SPL_TEXT_BASE>;
-					entry = <CONFIG_SPL_TEXT_BASE>;
-					blob {
-						filename = "spl/u-boot-spl-nodtb.bin";
-					};
-				};
-
 				fdt-0 {
 					description = "k3-j721s2-common-proc-board";
 					type = "flat_dt";
@@ -475,26 +344,12 @@
 
 &binman {
 	u-boot_unsigned {
-		filename = "u-boot.img_unsigned";
-		pad-byte = <0xff>;
+		insert-template = <&u_boot_unsigned_template>;
 
 		fit {
-			description = "FIT image with multiple configurations";
-
 			images {
 				uboot {
-					description = "U-Boot for J721S2 board";
-					type = "firmware";
-					os = "u-boot";
-					arch = "arm";
-					compression = "none";
-					load = <CONFIG_TEXT_BASE>;
-					blob {
-						filename = UBOOT_NODTB;
-					};
-					hash {
-						algo = "crc32";
-					};
+					description = "U-Boot for J721S2 Board";
 				};
 
 				fdt-0 {
-- 
2.34.1

