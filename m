Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D998C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 11:21:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1363C88093;
	Wed, 28 Feb 2024 12:21:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JtXeLbqD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A884487F95; Wed, 28 Feb 2024 12:21:15 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4184E88082
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 12:21:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41SBL16g062256;
 Wed, 28 Feb 2024 05:21:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709119261;
 bh=GcHMGcVpAd0vSkfUu53FDghe2w2z0U1IScId6HRC2gU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=JtXeLbqDPwzpis0b/2JYVN+Tw1I8hGNF7ITy8I2DeuglI/Pl0HmKNTVQ+1SVbMdg7
 P2aGwIqVlA6UXOkbJ6qIL7+/cdbYwZ54/42PWUyJy+RTbiEH2tvqTMnHRGkVRd+uxY
 GHjpdIuaD8nVnpUA0OzdQtKHzC8SRk0EaeUOOTHM=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41SBL19p115056
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 28 Feb 2024 05:21:01 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Feb 2024 05:21:01 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Feb 2024 05:21:01 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41SBKgNi027918;
 Wed, 28 Feb 2024 05:20:57 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <sjg@chromium.org>,
 <alpernebiyasak@gmail.com>, <bb@ti.com>, <nm@ti.com>,
 <sumit.garg@linaro.org>
CC: <michal.simek@amd.com>, <marex@denx.de>, <neil.armstrong@linaro.org>,
 <afd@ti.com>, <vigneshr@ti.com>, <kamlesh@ti.com>, <m-chawdhry@ti.com>,
 <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [RFC PATCH 3/4] arm: dts: k3-j721e: Separate boot binary build
Date: Wed, 28 Feb 2024 16:50:41 +0530
Message-ID: <20240228112042.3437691-4-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228112042.3437691-1-n-francis@ti.com>
References: <20240228112042.3437691-1-n-francis@ti.com>
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

Separate out the boot binaries built for J721E boards; J721E EVM and
J721E SK by using the common templates in k3-j721e-binman.dtsi.

Only the required boot binaries can be built from the templates in the
boards' respective -u-boot.dtsi file. FDTs and configurations are also
moved to the -u-boot.dtsi file to allow clear distinction between the
SoC common stuff vs. what is needed to boot up a board.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
Note: I have added "dummy" sections so that node for a phandle is found
correctly. The node for a phandle is searched for among sub-nodes of a
section (check tools/binman/etype/section.py GetContentsByPhandle) and
having a template as the section instead, causes failure to find the
phandle despite it being present in the FDT. So the dummy section
bypasses this.

Avoided correct DTS alignment for the RFC at least so that it's clear
what is actually being changed.

 arch/arm/dts/k3-j721e-binman.dtsi             | 178 +++++-------------
 .../k3-j721e-common-proc-board-u-boot.dtsi    | 138 ++++++++++++++
 arch/arm/dts/k3-j721e-sk-u-boot.dtsi          | 104 ++++++++++
 3 files changed, 284 insertions(+), 136 deletions(-)

diff --git a/arch/arm/dts/k3-j721e-binman.dtsi b/arch/arm/dts/k3-j721e-binman.dtsi
index 75a6e9599b9..284613545ea 100644
--- a/arch/arm/dts/k3-j721e-binman.dtsi
+++ b/arch/arm/dts/k3-j721e-binman.dtsi
@@ -5,11 +5,12 @@
 
 #include "k3-binman.dtsi"
 
-#ifdef CONFIG_TARGET_J721E_R5_EVM
+#ifdef CONFIG_CPU_V7R
 
 &binman {
-	tiboot3-j721e_sr1_1-hs-evm.bin {
+	tiboot3_j721e_sr1_1_hs: template-9 {
 		filename = "tiboot3-j721e_sr1_1-hs-evm.bin";
+		section {
 		ti-secure-rom {
 			content = <&u_boot_spl>;
 			core = "public";
@@ -19,10 +20,12 @@
 		u_boot_spl: u-boot-spl {
 			no-expanded;
 		};
+		};
 	};
 
-	tiboot3-j721e_sr2-hs-evm.bin {
+	tiboot3_j721e_sr2_hs: template-10 {
 		filename = "tiboot3-j721e_sr2-hs-evm.bin";
+		section {
 		ti-secure-rom {
 			content = <&u_boot_spl_sr2>;
 			core = "public";
@@ -32,10 +35,12 @@
 		u_boot_spl_sr2: u-boot-spl {
 			no-expanded;
 		};
+		};
 	};
 
-	sysfw {
+	sysfw: template-11 {
 		filename = "sysfw.bin";
+		section {
 		ti-secure-rom {
 			content = <&ti_fs_cert>;
 			core = "secure";
@@ -53,10 +58,12 @@
 			type = "blob-ext";
 			optional;
 		};
+		};
 	};
 
-	sysfw_sr2 {
+	sysfw_sr2: template-12 {
 		filename = "sysfw.bin_sr2";
+		section {
 		ti-secure-rom {
 			content = <&ti_fs_cert_sr2>;
 			core = "secure";
@@ -74,15 +81,17 @@
 			type = "blob-ext";
 			optional;
 		};
+		};
 	};
 
-	itb {
+	itb: template-13 {
 		filename = "sysfw-j721e_sr1_1-hs-evm.itb";
 		insert-template = <&itb_template>;
 	};
 
-	itb_sr2 {
+	itb_sr2: template-14 {
 		filename = "sysfw-j721e_sr2-hs-evm.itb";
+		section {
 		insert-template = <&itb_template>;
 		fit {
 			images {
@@ -127,11 +136,13 @@
 			};
 		};
 	};
+	};
 };
 
 &binman {
-	tiboot3-j721e_sr2-hs-fs-evm.bin {
+	tiboot3_j721e_sr2_hs_fs: template-15 {
 		filename = "tiboot3-j721e_sr2-hs-fs-evm.bin";
+		section {
 		ti-secure-rom {
 			content = <&u_boot_spl_fs>;
 			core = "public";
@@ -142,8 +153,10 @@
 			no-expanded;
 		};
 	};
-	sysfw_fs {
+	};
+	sysfw_fs: template-16 {
 		filename = "sysfw.bin_fs";
+		section {
 		ti-fs-cert-fs.bin {
 			filename = "ti-sysfw/ti-fs-firmware-j721e_sr2-hs-fs-cert.bin";
 			type = "blob-ext";
@@ -155,16 +168,18 @@
 			optional;
 		};
 	};
-	itb_fs {
+	};
+	itb_fs: template-17 {
 		filename = "sysfw-j721e_sr2-hs-fs-evm.itb";
 		insert-template = <&itb_unsigned_template>;
 	};
 };
 
 &binman {
-	tiboot3-j721e-gp-evm.bin {
+	tiboot3_j721e_gp: template-18 {
 		filename = "tiboot3-j721e-gp-evm.bin";
 		symlink = "tiboot3.bin";
+		section {
 		ti-secure-rom {
 			content = <&u_boot_spl_unsigned>;
 			core = "public";
@@ -176,8 +191,10 @@
 			no-expanded;
 		};
 	};
-	sysfw_gp {
+	};
+	sysfw_gp: template-19 {
 		filename = "sysfw.bin_gp";
+		section {
 		ti-secure-rom {
 			content = <&ti_fs>;
 			core = "secure";
@@ -191,9 +208,11 @@
 			optional;
 		};
 	};
-	itb_gp {
+	};
+	itb_gp: template-20 {
 		filename = "sysfw-j721e-gp-evm.itb";
 		symlink = "sysfw.itb";
+		section {
 		insert-template = <&itb_unsigned_template>;
 
 		fit {
@@ -206,16 +225,11 @@
 			};
 		};
 	};
+	};
 };
 #endif
 
-#ifdef CONFIG_TARGET_J721E_A72_EVM
-
-#define SPL_J721E_EVM_DTB "spl/dts/k3-j721e-common-proc-board.dtb"
-#define SPL_J721E_SK_DTB "spl/dts/k3-j721e-sk.dtb"
-
-#define J721E_EVM_DTB "u-boot.dtb"
-#define J721E_SK_DTB "arch/arm/dts/k3-j721e-sk.dtb"
+#ifdef CONFIG_ARM64
 
 &binman {
 	ti-dm {
@@ -224,7 +238,7 @@
 			filename = "ti-dm/j721e/ipc_echo_testb_mcu1_0_release_strip.xer5f";
 		};
 	};
-	ti-spl {
+	ti_spl: template-21 {
 		insert-template = <&ti_spl_template>;
 
 		fit {
@@ -354,98 +368,41 @@
 						filename = "ti-dm.bin";
 					};
 				};
-
-				fdt-0 {
-					description = "k3-j721e-common-proc-board";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					ti-secure {
-						content = <&spl_j721e_evm_dtb>;
-						keyfile = "custMpk.pem";
-					};
-					spl_j721e_evm_dtb: blob-ext {
-						filename = SPL_J721E_EVM_DTB;
-					};
-				};
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
 				default = "conf-0";
 
 				conf-0 {
-					description = "k3-j721e-common-proc-board";
 					firmware = "atf";
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
 };
 
 &binman {
-	u-boot {
+	u_boot: template-22 {
 		insert-template = <&u_boot_template>;
 		fit {
-
 			images {
 				uboot {
 					description = "U-Boot for J721E Board";
 				};
 
 				fdt-0 {
-					description = "k3-j721e-common-proc-board";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					ti-secure {
-						content = <&j721e_evm_dtb>;
-						keyfile = "custMpk.pem";
-
-					};
-					j721e_evm_dtb: blob-ext {
-						filename = J721E_EVM_DTB;
-					};
-					hash {
-						algo = "crc32";
-					};
-				};
-
-				fdt-1 {
-					description = "k3-j721e-sk";
 					type = "flat_dt";
 					arch = "arm";
 					compression = "none";
 					ti-secure {
-						content = <&j721e_sk_dtb>;
+						content = <&j721e_dtb>;
 						keyfile = "custMpk.pem";
 
 					};
-					j721e_sk_dtb: blob-ext {
-						filename = J721E_SK_DTB;
+					j721e_dtb: blob {
+						filename = "u-boot.dtb";
 					};
 					hash {
 						algo = "crc32";
@@ -457,25 +414,17 @@
 				default = "conf-0";
 
 				conf-0 {
-					description = "k3-j721e-common-proc-board";
 					firmware = "uboot";
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
 };
 
 &binman {
-	ti-spl_unsigned {
+	ti_spl_unsigned: template-23 {
 		insert-template = <&ti_spl_unsigned_template>;
 
 		fit {
@@ -487,23 +436,9 @@
 				};
 
 				fdt-0 {
-					description = "k3-j721e-common-proc-board";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					blob {
-						filename = SPL_J721E_EVM_DTB;
-					};
-				};
-
-				fdt-1 {
-					description = "k3-j721e-sk";
 					type = "flat_dt";
 					arch = "arm";
 					compression = "none";
-					blob {
-						filename = SPL_J721E_SK_DTB;
-					};
 				};
 			};
 
@@ -511,25 +446,17 @@
 				default = "conf-0";
 
 				conf-0 {
-					description = "k3-j721e-common-proc-board";
 					firmware = "atf";
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
 };
 
 &binman {
-	u-boot_unsigned {
+	u_boot_unsigned: template-24 {
 		insert-template = <&u_boot_unsigned_template>;
 
 		fit {
@@ -539,25 +466,11 @@
 				};
 
 				fdt-0 {
-					description = "k3-j721e-common-proc-board";
 					type = "flat_dt";
 					arch = "arm";
 					compression = "none";
-					blob {
-						filename = J721E_EVM_DTB;
-					};
-					hash {
-						algo = "crc32";
-					};
-				};
 
-				fdt-1 {
-					description = "k3-j721e-sk";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					blob {
-						filename = J721E_SK_DTB;
+					u-boot-dtb {
 					};
 					hash {
 						algo = "crc32";
@@ -574,13 +487,6 @@
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
diff --git a/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi b/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
index 7ae7cf3d4c9..ff96bc3f724 100644
--- a/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
@@ -187,3 +187,141 @@
 &mcu_fss0_ospi1_pins_default {
 	bootph-all;
 };
+
+#ifdef CONFIG_TARGET_J721E_R5_EVM
+
+&binman {
+	tiboot3-j721e-sr1-1-hs-evm {
+		insert-template = <&tiboot3_j721e_sr1_1_hs>;
+	};
+	sysfw-j721e-sr1-1-hs-evm {
+		insert-template = <&sysfw>;
+	};
+	itb-j721e-sr1-1-hs-evm {
+		insert-template = <&itb>;
+	};
+};
+
+&binman {
+	tiboot3-j721e-sr2-hs-evm {
+		insert-template = <&tiboot3_j721e_sr2_hs>;
+	};
+	sysfw-j721e-sr2-hs-evm {
+		insert-template = <&sysfw_sr2>;
+	};
+	itb-j721e-sr2-hs-evm {
+		insert-template = <&itb_sr2>;
+	};
+};
+
+&binman {
+	tiboot3-j721e-sr2-hs-fs-evm {
+		insert-template = <&tiboot3_j721e_sr2_hs_fs>;
+	};
+	sysfw-j721e-sr2-hs-fs-evm {
+		insert-template = <&sysfw_fs>;
+	};
+	itb-j721e-sr2-hs-fs-evm {
+		insert-template = <&itb_fs>;
+	};
+};
+
+&binman {
+	tiboot3-j721e-gp-evm {
+		insert-template = <&tiboot3_j721e_gp>;
+	};
+	sysfw-j721e-gp-evm {
+		insert-template = <&sysfw_gp>;
+	};
+	itb-j721e-gp-evm {
+		insert-template = <&itb_gp>;
+	};
+};
+
+#else
+
+#define SPL_J721E_EVM_DTB "spl/dts/k3-j721e-common-proc-board.dtb"
+
+&binman {
+	tispl {
+		insert-template = <&ti_spl>;
+		fit {
+			images {
+				fdt-0 {
+					description = "k3-j721e-common-proc-board";
+					ti-secure {
+						content = <&spl_j721e_evm_dtb>;
+						keyfile = "custMpk.pem";
+					};
+					spl_j721e_evm_dtb: blob-ext {
+						filename = SPL_J721E_EVM_DTB;
+					};
+				};
+			};
+
+			configurations {
+				conf-0 {
+					description = "k3-j721e-common-proc-board";
+				};
+			};
+		};
+	};
+
+	u-boot {
+		insert-template = <&u_boot>;
+		fit {
+			images {
+				fdt-0 {
+					description = "k3-j721e-common-proc-board";
+				};
+			};
+
+			configurations {
+				conf-0 {
+					description = "k3-j721e-common-proc-board";
+				};
+			};
+		};
+	};
+
+	tispl-unsigned {
+		insert-template = <&ti_spl_unsigned>;
+
+		fit {
+			images {
+				fdt-0 {
+					description = "k3-j721e-common-proc-board";
+					blob {
+						filename = SPL_J721E_EVM_DTB;
+					};
+				};
+			};
+
+			configurations {
+				conf-0 {
+					description = "k3-j721e-common-proc-board";
+				};
+			};
+		};
+	};
+
+	u-boot-unsigned {
+		insert-template = <&u_boot_unsigned>;
+
+		fit {
+			images {
+				fdt-0 {
+					description = "k3-j721e-common-proc-board";
+				};
+			};
+
+			configurations {
+				conf-0 {
+					description = "k3-j721e-common-proc-board";
+				};
+			};
+		};
+	};
+};
+
+#endif
diff --git a/arch/arm/dts/k3-j721e-sk-u-boot.dtsi b/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
index 479b7bcd6f8..ca18dd5f8ed 100644
--- a/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
@@ -163,3 +163,107 @@
 		};
 	};
 };
+
+#ifndef CONFIG_ARM64
+
+&binman {
+	tiboot3-j721e-gp-sk {
+		insert-template = <&tiboot3_j721e_gp>;
+		filename = "tiboot3-j721e-gp-sk.bin";
+	};
+	sysfw-j721e-gp-sk {
+		insert-template = <&sysfw_gp>;
+	};
+	itb-j721e-gp-sk {
+		insert-template = <&itb_gp>;
+		filename = "sysfw-j721e-gp-sk.itb";
+	};
+};
+
+#else
+
+#define SPL_J721E_SK_DTB "spl/dts/k3-j721e-sk.dtb"
+
+&binman {
+	tispl {
+		insert-template = <&ti_spl>;
+		fit {
+			images {
+				fdt-0 {
+					description = "k3-j721e-sk";
+					ti-secure {
+						content = <&spl_j721e_sk_dtb>;
+						keyfile = "custMpk.pem";
+					};
+					spl_j721e_sk_dtb: blob-ext {
+						filename = SPL_J721E_SK_DTB;
+					};
+				};
+			};
+
+			configurations {
+				conf-0 {
+					description = "k3-j721e-sk";
+				};
+			};
+		};
+	};
+
+	u-boot {
+		insert-template = <&u_boot>;
+		fit {
+			images {
+				fdt-0 {
+					description = "k3-j721e-sk";
+				};
+			};
+
+			configurations {
+				conf-0 {
+					description = "k3-j721e-sk";
+				};
+			};
+		};
+	};
+
+	tispl-unsigned {
+		insert-template = <&ti_spl_unsigned>;
+
+		fit {
+			images {
+				fdt-0 {
+					description = "k3-j721e-sk";
+					blob {
+						filename = SPL_J721E_SK_DTB;
+					};
+				};
+			};
+
+			configurations {
+				conf-0 {
+					description = "k3-j721e-sk";
+				};
+			};
+		};
+	};
+
+	u-boot-unsigned {
+		insert-template = <&u_boot_unsigned>;
+
+		fit {
+			images {
+				fdt-0 {
+					description = "k3-j721e-sk";
+				};
+			};
+
+			configurations {
+				conf-0 {
+					description = "k3-j721e-sk";
+				};
+			};
+		};
+	};
+};
+
+#endif
-- 
2.34.1

