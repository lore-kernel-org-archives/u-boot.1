Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F15C47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 13:11:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61A25881D9;
	Fri, 22 Mar 2024 14:10:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rl68s6L9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02B8B881D9; Fri, 22 Mar 2024 14:10:45 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08170881FD
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 14:10:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42MDAV7q011508;
 Fri, 22 Mar 2024 08:10:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1711113031;
 bh=Kjp0jltcDZ7krHhuXOy2X+CwDGJma2egoVQGJgOIFEM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=rl68s6L9VIpYJ1ig8IjkRgBPaTDHb/i2C79jXEwo+Oy73uGc4hOs+XmKlISEqVaqx
 PeR/DwE2Op6+TWaZC6KfdYLduGPz2BTndZsG8QGMPn3pcsGSMoKC/d+NiQvxY5Gus2
 UjIDTnUyla6o2NUjj1CobaGMTGxS3xK+8E4U92YU=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42MDAVbw010033
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 22 Mar 2024 08:10:31 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 22
 Mar 2024 08:10:30 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 22 Mar 2024 08:10:30 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42MDABZA026606;
 Fri, 22 Mar 2024 08:10:26 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <sjg@chromium.org>,
 <alpernebiyasak@gmail.com>, <bb@ti.com>, <nm@ti.com>,
 <sumit.garg@linaro.org>
CC: <michal.simek@amd.com>, <marex@denx.de>, <neil.armstrong@linaro.org>,
 <afd@ti.com>, <vigneshr@ti.com>, <kamlesh@ti.com>, <m-chawdhry@ti.com>,
 <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [PATCH 3/4] arm: dts: k3-*-binman.dtsi: Clean up and templatize boot
 binaries
Date: Fri, 22 Mar 2024 18:40:10 +0530
Message-ID: <20240322131011.1029620-4-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322131011.1029620-1-n-francis@ti.com>
References: <20240322131011.1029620-1-n-francis@ti.com>
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

Clean up templatized boot binaries for all K3 boards. This includes
modifying the k3-binman.dtsi to use SPL_BOARD_DTB, BOARD_DESCRIPTION and
UBOOT_BOARD_DESCRIPTION from the files that include it to further reuse
code.

All k3-<soc>-binman.dtsi will contain only templates. Only required boot
binaries can be built from the templates in the boards' respective
-u-boot.dtsi file (or k3-<board>-binman.dtsi if it exists). This allows
clear distinction between the SoC common stuff vs. what is additionally
needed to boot up a specific board.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi  | 161 +---------
 arch/arm/dts/k3-am625-phycore-som-binman.dtsi | 291 +----------------
 arch/arm/dts/k3-am625-r5-beagleplay.dts       |  39 ---
 arch/arm/dts/k3-am625-sk-binman.dtsi          | 148 +--------
 arch/arm/dts/k3-am625-sk-u-boot.dtsi          |  42 +++
 .../dts/k3-am625-verdin-wifi-dev-binman.dtsi  | 296 +-----------------
 arch/arm/dts/k3-am62a-sk-binman.dtsi          | 146 +--------
 arch/arm/dts/k3-am62a7-sk-u-boot.dtsi         |  42 +++
 arch/arm/dts/k3-am642-evm-u-boot.dtsi         |  42 +++
 arch/arm/dts/k3-am642-sk-u-boot.dtsi          |  42 +++
 arch/arm/dts/k3-am64x-binman.dtsi             | 239 +-------------
 arch/arm/dts/k3-am654-base-board-u-boot.dtsi  |  49 +++
 arch/arm/dts/k3-am65x-binman.dtsi             | 144 +--------
 .../arm/dts/k3-am68-sk-base-board-u-boot.dtsi |  26 ++
 arch/arm/dts/k3-am69-sk-u-boot.dtsi           |  31 +-
 arch/arm/dts/k3-binman.dtsi                   |  96 ++++++
 arch/arm/dts/k3-j7200-binman.dtsi             | 145 +--------
 .../k3-j7200-common-proc-board-u-boot.dtsi    |  40 +++
 .../dts/k3-j721e-beagleboneai64-u-boot.dtsi   | 154 +--------
 arch/arm/dts/k3-j721e-binman.dtsi             | 262 +++-------------
 .../k3-j721e-common-proc-board-u-boot.dtsi    |  84 +++++
 arch/arm/dts/k3-j721e-r5-beagleboneai64.dts   |  91 +-----
 arch/arm/dts/k3-j721e-sk-u-boot.dtsi          |  84 +++++
 arch/arm/dts/k3-j721s2-binman.dtsi            | 231 +-------------
 .../k3-j721s2-common-proc-board-u-boot.dtsi   |  42 +++
 arch/arm/dts/k3-j784s4-binman.dtsi            | 154 +--------
 arch/arm/dts/k3-j784s4-evm-u-boot.dtsi        |  42 +++
 27 files changed, 858 insertions(+), 2305 deletions(-)

diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
index cca0f44b7d8..fc1898f1510 100644
--- a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
@@ -6,7 +6,11 @@
  * Copyright (C) 2022-2023 Robert Nelson, BeagleBoard.org Foundation
  */
 
-#include "k3-binman.dtsi"
+#define SPL_BOARD_DTB "spl/dts/k3-am625-beagleplay.dtb"
+#define BOARD_DESCRIPTION "k3-am625-beagleplay"
+#define UBOOT_BOARD_DESCRIPTION "U-Boot for AM625 BeaglePlay"
+
+#include "k3-am625-sk-binman.dtsi"
 
 / {
 	chosen {
@@ -61,155 +65,24 @@
 	>;
 };
 
-#ifdef CONFIG_TARGET_AM625_A53_BEAGLEPLAY
-
-#define SPL_NODTB "spl/u-boot-spl-nodtb.bin"
-#define SPL_AM625_BEAGLEPLAY_DTB "spl/dts/k3-am625-beagleplay.dtb"
-#define UBOOT_NODTB "u-boot-nodtb.bin"
-#define AM625_BEAGLEPLAY_DTB "arch/arm/dts/k3-am625-beagleplay.dtb"
+#ifndef CONFIG_ARM64
 
 &binman {
-	ti-dm {
-		filename = "ti-dm.bin";
-		blob-ext {
-			filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-		};
+	tiboot3-am62x-gp {
+		insert-template = <&tiboot3_am62x_gp>;
 	};
+};
 
-	ti-spl_unsigned {
-		filename = "tispl.bin_unsigned";
-		pad-byte = <0xff>;
-
-		fit {
-			description = "Configuration to load ATF and SPL";
-			#address-cells = <1>;
-
-			images {
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
-					load = <CONFIG_K3_OPTEE_LOAD_ADDR>;
-					entry = <CONFIG_K3_OPTEE_LOAD_ADDR>;
-					tee-os {
-						filename = "tee-raw.bin";
-					};
-				};
-
-				dm {
-					description = "DM binary";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "DM";
-					load = <0x89000000>;
-					entry = <0x89000000>;
-					blob-ext {
-						filename = "ti-dm.bin";
-					};
-				};
-
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
-				fdt-0 {
-					description = "k3-am625-beagleplay";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					spl_am625_bp_dtb_unsigned: blob {
-						filename = SPL_AM625_BEAGLEPLAY_DTB;
-					};
-				};
-			};
-
-			configurations {
-				default = "conf-0";
-
-				conf-0 {
-					description = "k3-am625-beagleplay";
-					firmware = "atf";
-					loadables = "tee", "dm", "spl";
-					fdt = "fdt-0";
-				};
-			};
-		};
+#else
+
+&binman {
+	tispl-unsigned {
+		insert-template = <&ti_spl_unsigned>;
 	};
 
-	u-boot_unsigned {
-		filename = "u-boot.img_unsigned";
-		pad-byte = <0xff>;
-
-		fit {
-			description = "FIT image with multiple configurations";
-
-			images {
-				uboot {
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
-				};
-
-				fdt-0 {
-					description = "k3-am625-beagleplay";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					am625_bp_dtb_unsigned: blob {
-						filename = AM625_BEAGLEPLAY_DTB;
-					};
-					hash {
-						algo = "crc32";
-					};
-				};
-			};
-
-			configurations {
-				default = "conf-0";
-
-				conf-0 {
-					description = "k3-am625-beagleplay";
-					firmware = "uboot";
-					loadables = "uboot";
-					fdt = "fdt-0";
-				};
-			};
-		};
+	u-boot-unsigned {
+		insert-template = <&u_boot_unsigned>;
 	};
 };
+
 #endif
diff --git a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
index ed50bfeb031..14fc8468c56 100644
--- a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
@@ -6,309 +6,48 @@
  * Author: Wadim Egorov <w.egorov@phytec.de>
  */
 
-#include "k3-binman.dtsi"
+#define SPL_BOARD_DTB "spl/dts/k3-am625-phyboard-lyra-rdk.dtb"
+#define BOARD_DESCRIPTION "k3-am625-phyboard-lyra-rdk"
+#define UBOOT_BOARD_DESCRIPTION "U-Boot for phyCORE-AM62x"
+
+#include "k3-am625-sk-binman.dtsi"
 
 #ifdef CONFIG_TARGET_PHYCORE_AM62X_R5
 &binman {
 	tiboot3-am62x-hs-phycore-som.bin {
 		filename = "tiboot3-am62x-hs-phycore-som.bin";
-		ti-secure-rom {
-			content = <&u_boot_spl>, <&ti_fs_enc>, <&combined_tifs_cfg>,
-				<&combined_dm_cfg>, <&sysfw_inner_cert>;
-			combined;
-			dm-data;
-			sysfw-inner-cert;
-			keyfile = "custMpk.pem";
-			sw-rev = <1>;
-			content-sbl = <&u_boot_spl>;
-			content-sysfw = <&ti_fs_enc>;
-			content-sysfw-data = <&combined_tifs_cfg>;
-			content-sysfw-inner-cert = <&sysfw_inner_cert>;
-			content-dm-data = <&combined_dm_cfg>;
-			load = <0x43c00000>;
-			load-sysfw = <0x40000>;
-			load-sysfw-data = <0x67000>;
-			load-dm-data = <0x43c3a800>;
-		};
-		u_boot_spl: u-boot-spl {
-			no-expanded;
-		};
-		ti_fs_enc: ti-fs-enc.bin {
-			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-enc.bin";
-			type = "blob-ext";
-			optional;
-		};
-		combined_tifs_cfg: combined-tifs-cfg.bin {
-			filename = "combined-tifs-cfg.bin";
-			type = "blob-ext";
-		};
-		sysfw_inner_cert: sysfw-inner-cert {
-			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-cert.bin";
-			type = "blob-ext";
-			optional;
-		};
-		combined_dm_cfg: combined-dm-cfg.bin {
-			filename = "combined-dm-cfg.bin";
-			type = "blob-ext";
-		};
+		insert-template = <&tiboot3_am62x_hs>;
 	};
-};
 
-&binman {
 	tiboot3-am62x-hs-fs-phycore-som.bin {
 		filename = "tiboot3-am62x-hs-fs-phycore-som.bin";
-		symlink = "tiboot3.bin";
-		ti-secure-rom {
-			content = <&u_boot_spl_fs>, <&ti_fs_enc_fs>, <&combined_tifs_cfg_fs>,
-				<&combined_dm_cfg_fs>, <&sysfw_inner_cert_fs>;
-			combined;
-			dm-data;
-			sysfw-inner-cert;
-			keyfile = "custMpk.pem";
-			sw-rev = <1>;
-			content-sbl = <&u_boot_spl_fs>;
-			content-sysfw = <&ti_fs_enc_fs>;
-			content-sysfw-data = <&combined_tifs_cfg_fs>;
-			content-sysfw-inner-cert = <&sysfw_inner_cert_fs>;
-			content-dm-data = <&combined_dm_cfg_fs>;
-			load = <0x43c00000>;
-			load-sysfw = <0x40000>;
-			load-sysfw-data = <0x67000>;
-			load-dm-data = <0x43c3a800>;
-		};
-		u_boot_spl_fs: u-boot-spl {
-			no-expanded;
-		};
-		ti_fs_enc_fs: ti-fs-enc.bin {
-			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-fs-enc.bin";
-			type = "blob-ext";
-			optional;
-		};
-		combined_tifs_cfg_fs: combined-tifs-cfg.bin {
-			filename = "combined-tifs-cfg.bin";
-			type = "blob-ext";
-		};
-		sysfw_inner_cert_fs: sysfw-inner-cert {
-			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-fs-cert.bin";
-			type = "blob-ext";
-			optional;
-		};
-		combined_dm_cfg_fs: combined-dm-cfg.bin {
-			filename = "combined-dm-cfg.bin";
-			type = "blob-ext";
-		};
+		insert-template = <&tiboot3_am62x_hs_fs>;
 	};
-};
 
-&binman {
 	tiboot3-am62x-gp-phycore-som.bin {
 		filename = "tiboot3-am62x-gp-phycore-som.bin";
-		ti-secure-rom {
-			content = <&u_boot_spl_unsigned>, <&ti_fs_gp>,
-				<&combined_tifs_cfg_gp>, <&combined_dm_cfg_gp>;
-			combined;
-			dm-data;
-			content-sbl = <&u_boot_spl_unsigned>;
-			load = <0x43c00000>;
-			content-sysfw = <&ti_fs_gp>;
-			load-sysfw = <0x40000>;
-			content-sysfw-data = <&combined_tifs_cfg_gp>;
-			load-sysfw-data = <0x67000>;
-			content-dm-data = <&combined_dm_cfg_gp>;
-			load-dm-data = <0x43c3a800>;
-			sw-rev = <1>;
-			keyfile = "ti-degenerate-key.pem";
-		};
-		u_boot_spl_unsigned: u-boot-spl {
-			no-expanded;
-		};
-		ti_fs_gp: ti-fs-gp.bin {
-			filename = "ti-sysfw/ti-fs-firmware-am62x-gp.bin";
-			type = "blob-ext";
-			optional;
-		};
-		combined_tifs_cfg_gp: combined-tifs-cfg-gp.bin {
-			filename = "combined-tifs-cfg.bin";
-			type = "blob-ext";
-		};
-		combined_dm_cfg_gp: combined-dm-cfg-gp.bin {
-			filename = "combined-dm-cfg.bin";
-			type = "blob-ext";
-		};
+		insert-template = <&tiboot3_am62x_gp>;
 	};
 };
 #endif /* CONFIG_TARGET_PHYCORE_AM62X_R5 */
 
 #ifdef CONFIG_TARGET_PHYCORE_AM62X_A53
-#define SPL_AM625_PHYBOARD_LYRA_DTB "spl/dts/k3-am625-phyboard-lyra-rdk.dtb"
-#define AM625_PHYBOARD_LYRA_DTB "u-boot.dtb"
 
 &binman {
-	ti-dm {
-		filename = "ti-dm.bin";
-		blob-ext {
-			filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-		};
+	tispl {
+		insert-template = <&ti_spl>;
 	};
-	ti-spl {
-		insert-template = <&ti_spl_template>;
-
-		fit {
-
-			images {
-				dm {
-					ti-secure {
-						content = <&dm>;
-						keyfile = "custMpk.pem";
-					};
-					dm: blob-ext {
-						filename = "ti-dm.bin";
-					};
-				};
-
-				fdt-0 {
-					description = "k3-am625-phyboard-lyra-rdk";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					ti-secure {
-						content = <&spl_am625_phyboard_lyra_dtb>;
-						keyfile = "custMpk.pem";
-					};
-					spl_am625_phyboard_lyra_dtb: blob-ext {
-						filename = SPL_AM625_PHYBOARD_LYRA_DTB;
-					};
-				};
-			};
 
-			configurations {
-				default = "conf-0";
-
-				conf-0 {
-					description = "k3-am625-phyboard-lyra-rdk";
-					firmware = "atf";
-					loadables = "tee", "dm", "spl";
-					fdt = "fdt-0";
-				};
-			};
-		};
-	};
-};
-
-&binman {
 	u-boot {
-		insert-template = <&u_boot_template>;
-
-		fit {
-			images {
-				uboot {
-					description = "U-Boot for phyCORE-AM62x";
-				};
-
-				fdt-0 {
-					description = "k3-am625-phyboard-lyra-rdk";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					ti-secure {
-						content = <&am625_phyboard_lyra_dtb>;
-						keyfile = "custMpk.pem";
-					};
-					am625_phyboard_lyra_dtb: blob-ext {
-						filename = AM625_PHYBOARD_LYRA_DTB;
-					};
-					hash {
-						algo = "crc32";
-					};
-				};
-			};
-
-			configurations {
-				default = "conf-0";
-
-				conf-0 {
-					description = "k3-am625-phyboard-lyra-rdk";
-					firmware = "uboot";
-					loadables = "uboot";
-					fdt = "fdt-0";
-				};
-			};
-		};
+		insert-template = <&u_boot>;
 	};
-};
-
-&binman {
-	ti-spl_unsigned {
-		insert-template = <&ti_spl_unsigned_template>;
-
-		fit {
-			images {
-				dm {
-					blob-ext {
-						filename = "ti-dm.bin";
-					};
-				};
-
-				fdt-0 {
-					description = "k3-am625-phyboard-lyra-rdk";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					spl_am625_phyboard_lyra_dtb_unsigned: blob {
-						filename = SPL_AM625_PHYBOARD_LYRA_DTB;
-					};
-				};
-			};
 
-			configurations {
-				default = "conf-0";
-
-				conf-0 {
-					description = "k3-am625-phyboard-lyra-rdk";
-					firmware = "atf";
-					loadables = "tee", "dm", "spl";
-					fdt = "fdt-0";
-				};
-			};
-		};
+	tispl-unsigned {
+		insert-template = <&ti_spl_unsigned>;
 	};
-};
-
-&binman {
-	u-boot_unsigned {
-		insert-template = <&u_boot_unsigned_template>;
-
-		fit {
-			images {
-				uboot {
-					description = "U-Boot for phyCORE-AM62x";
-				};
-
-				fdt-0 {
-					description = "k3-am625-phyboard-lyra-rdk";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					am625_phyboard_lyra_dtb_unsigned: blob {
-						filename = AM625_PHYBOARD_LYRA_DTB;
-					};
-					hash {
-						algo = "crc32";
-					};
-				};
-			};
-
-			configurations {
-				default = "conf-0";
 
-				conf-0 {
-					description = "k3-am625-phyboard-lyra-rdk";
-					firmware = "uboot";
-					loadables = "uboot";
-					fdt = "fdt-0";
-				};
-			};
-		};
+	u-boot-unsigned {
+		insert-template = <&u_boot_unsigned>;
 	};
 };
 #endif /* CONFIG_TARGET_PHYCORE_AM62X_A53 */
diff --git a/arch/arm/dts/k3-am625-r5-beagleplay.dts b/arch/arm/dts/k3-am625-r5-beagleplay.dts
index 9db58f093c8..1f450f55c1d 100644
--- a/arch/arm/dts/k3-am625-r5-beagleplay.dts
+++ b/arch/arm/dts/k3-am625-r5-beagleplay.dts
@@ -75,42 +75,3 @@
 &main_bcdma {
 	ti,sci = <&dm_tifs>;
 };
-
-&binman {
-	tiboot3-am62x-gp-evm.bin {
-		filename = "tiboot3-am62x-gp-evm.bin";
-		ti-secure-rom {
-			content = <&u_boot_spl_unsigned>, <&ti_fs_gp>,
-				<&combined_tifs_cfg_gp>, <&combined_dm_cfg_gp>;
-			combined;
-			dm-data;
-			content-sbl = <&u_boot_spl_unsigned>;
-			load = <0x43c00000>;
-			content-sysfw = <&ti_fs_gp>;
-			load-sysfw = <0x40000>;
-			content-sysfw-data = <&combined_tifs_cfg_gp>;
-			load-sysfw-data = <0x67000>;
-			content-dm-data = <&combined_dm_cfg_gp>;
-			load-dm-data = <0x43c3a800>;
-			sw-rev = <1>;
-			keyfile = "ti-degenerate-key.pem";
-		};
-		u_boot_spl_unsigned: u-boot-spl {
-			no-expanded;
-		};
-		ti_fs_gp: ti-fs-gp.bin {
-			filename = "ti-sysfw/ti-fs-firmware-am62x-gp.bin";
-			type = "blob-ext";
-			optional;
-		};
-		combined_tifs_cfg_gp: combined-tifs-cfg-gp.bin {
-			filename = "combined-tifs-cfg.bin";
-			type = "blob-ext";
-		};
-		combined_dm_cfg_gp: combined-dm-cfg-gp.bin {
-			filename = "combined-dm-cfg.bin";
-			type = "blob-ext";
-		};
-
-	};
-};
diff --git a/arch/arm/dts/k3-am625-sk-binman.dtsi b/arch/arm/dts/k3-am625-sk-binman.dtsi
index 5b058bd03a0..7b67eb2d8d4 100644
--- a/arch/arm/dts/k3-am625-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am625-sk-binman.dtsi
@@ -5,11 +5,12 @@
 
 #include "k3-binman.dtsi"
 
-#ifdef CONFIG_TARGET_AM625_R5_EVM
+#ifndef CONFIG_ARM64
 
 &binman {
-	tiboot3-am62x-hs-evm.bin {
+	tiboot3_am62x_hs: template-9 {
 		filename = "tiboot3-am62x-hs-evm.bin";
+		section {
 		ti-secure-rom {
 			content = <&u_boot_spl>, <&ti_fs_enc>, <&combined_tifs_cfg>,
 				<&combined_dm_cfg>, <&sysfw_inner_cert>;
@@ -49,13 +50,15 @@
 			filename = "combined-dm-cfg.bin";
 			type = "blob-ext";
 		};
+		};
 	};
 };
 
 &binman {
-	tiboot3-am62x-hs-fs-evm.bin {
+	tiboot3_am62x_hs_fs: template-10 {
 		filename = "tiboot3-am62x-hs-fs-evm.bin";
 		symlink = "tiboot3.bin";
+		section {
 		ti-secure-rom {
 			content = <&u_boot_spl_fs>, <&ti_fs_enc_fs>, <&combined_tifs_cfg_fs>,
 				<&combined_dm_cfg_fs>, <&sysfw_inner_cert_fs>;
@@ -96,11 +99,13 @@
 			type = "blob-ext";
 		};
 	};
+	};
 };
 
 &binman {
-	tiboot3-am62x-gp-evm.bin {
+	tiboot3_am62x_gp: template-11 {
 		filename = "tiboot3-am62x-gp-evm.bin";
+		section {
 		ti-secure-rom {
 			content = <&u_boot_spl_unsigned>, <&ti_fs_gp>,
 				<&combined_tifs_cfg_gp>, <&combined_dm_cfg_gp>;
@@ -133,16 +138,11 @@
 			filename = "combined-dm-cfg.bin";
 			type = "blob-ext";
 		};
-
+	};
 	};
 };
 
-#endif
-
-#ifdef CONFIG_TARGET_AM625_A53_EVM
-
-#define SPL_AM625_SK_DTB "spl/dts/k3-am625-sk.dtb"
-#define AM625_SK_DTB "u-boot.dtb"
+#else
 
 &binman {
 	ti-dm {
@@ -151,7 +151,7 @@
 			filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
 		};
 	};
-	ti-spl {
+	ti_spl: template-12 {
 		insert-template = <&ti_spl_template>;
 
 		fit {
@@ -165,154 +165,36 @@
 						filename = "ti-dm.bin";
 					};
 				};
-
-				fdt-0 {
-					description = "k3-am625-sk";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					ti-secure {
-						content = <&spl_am625_sk_dtb>;
-						keyfile = "custMpk.pem";
-					};
-					spl_am625_sk_dtb: blob-ext {
-						filename = SPL_AM625_SK_DTB;
-					};
-
-				};
-
-			};
-
-			configurations {
-				default = "conf-0";
-
-				conf-0 {
-					description = "k3-am625-sk";
-					firmware = "atf";
-					loadables = "tee", "dm", "spl";
-					fdt = "fdt-0";
-				};
 			};
 		};
 	};
 };
 
 &binman {
-	u-boot {
+	u_boot: template-13 {
 		insert-template = <&u_boot_template>;
-
-		fit {
-			images {
-				uboot {
-					description = "U-Boot for AM625 Board";
-				};
-
-				fdt-0 {
-					description = "k3-am625-sk";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					ti-secure {
-						content = <&am625_sk_dtb>;
-						keyfile = "custMpk.pem";
-					};
-					am625_sk_dtb: blob-ext {
-						filename = AM625_SK_DTB;
-					};
-					hash {
-						algo = "crc32";
-					};
-				};
-			};
-
-			configurations {
-				default = "conf-0";
-
-				conf-0 {
-					description = "k3-am625-sk";
-					firmware = "uboot";
-					loadables = "uboot";
-					fdt = "fdt-0";
-				};
-
-			};
-		};
 	};
 };
 
 &binman {
-	ti-spl_unsigned {
+	ti_spl_unsigned: template-14 {
 		insert-template = <&ti_spl_unsigned_template>;
 
 		fit {
 			images {
-
 				dm {
 					ti-dm {
 						filename = "ti-dm.bin";
 					};
 				};
-
-				fdt-0 {
-					description = "k3-am625-sk";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					spl_am625_sk_dtb_unsigned: blob {
-						filename = SPL_AM625_SK_DTB;
-					};
-				};
-			};
-
-			configurations {
-				default = "conf-0";
-
-				conf-0 {
-					description = "k3-am625-sk";
-					firmware = "atf";
-					loadables = "tee", "dm", "spl";
-					fdt = "fdt-0";
-				};
 			};
 		};
 	};
 };
 
 &binman {
-	u-boot_unsigned {
+	u_boot_unsigned: template-15 {
 		insert-template = <&u_boot_unsigned_template>;
-
-		fit {
-			images {
-				uboot {
-					description = "U-Boot for AM625 Board";
-				};
-
-				fdt-0 {
-					description = "k3-am625-sk";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					am625_sk_dtb_unsigned: blob {
-						filename = AM625_SK_DTB;
-					};
-					hash {
-						algo = "crc32";
-					};
-				};
-			};
-
-			configurations {
-				default = "conf-0";
-
-				conf-0 {
-					description = "k3-am625-sk";
-					firmware = "uboot";
-					loadables = "uboot";
-					fdt = "fdt-0";
-				};
-			};
-		};
 	};
 };
 #endif
diff --git a/arch/arm/dts/k3-am625-sk-u-boot.dtsi b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
index fa778b0ff4c..3871359bf43 100644
--- a/arch/arm/dts/k3-am625-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
@@ -4,6 +4,10 @@
  * Copyright (C) 2021-2022 Texas Instruments Incorporated - https://www.ti.com/
  */
 
+#define SPL_BOARD_DTB "spl/dts/k3-am625-sk.dtb"
+#define BOARD_DESCRIPTION "k3-am625-sk"
+#define UBOOT_BOARD_DESCRIPTION "U-Boot for AM625 SK"
+
 #include "k3-am625-sk-binman.dtsi"
 
 / {
@@ -46,3 +50,41 @@
 &cpsw_port2 {
 	status = "disabled";
 };
+
+#ifndef CONFIG_ARM64
+
+&binman {
+	tiboot3-am62x-hs {
+		insert-template = <&tiboot3_am62x_hs>;
+	};
+
+	tiboot3-am62x-hs-fs {
+		insert-template = <&tiboot3_am62x_hs_fs>;
+	};
+
+	tiboot3-am62x-gp {
+		insert-template = <&tiboot3_am62x_gp>;
+	};
+};
+
+#else
+
+&binman {
+	tispl {
+		insert-template = <&ti_spl>;
+	};
+
+	u-boot {
+		insert-template = <&u_boot>;
+	};
+
+	tispl-unsigned {
+		insert-template = <&ti_spl_unsigned>;
+	};
+
+	u-boot-unsigned {
+		insert-template = <&u_boot_unsigned>;
+	};
+};
+
+#endif
diff --git a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
index 4e3704809a6..0a2ae7cd19c 100644
--- a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
+++ b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
@@ -3,136 +3,28 @@
  * Copyright 2023 Toradex
  */
 
-#include "k3-binman.dtsi"
+#define SPL_BOARD_DTB "spl/dts/k3-am625-verdin-wifi-dev.dtb"
+#define BOARD_DESCRIPTION "k3-am625-verdin-wifi-dev"
+#define UBOOT_BOARD_DESCRIPTION "U-Boot fot AM625 Verdin Board"
+
+#include "k3-am625-sk-binman.dtsi"
 
 #ifdef CONFIG_TARGET_VERDIN_AM62_R5
 
 &binman {
 	tiboot3-am62x-hs-verdin.bin {
 		filename = "tiboot3-am62x-hs-verdin.bin";
-		ti-secure-rom {
-			content = <&u_boot_spl>, <&ti_fs_enc>, <&combined_tifs_cfg>,
-				<&combined_dm_cfg>, <&sysfw_inner_cert>;
-			combined;
-			dm-data;
-			sysfw-inner-cert;
-			keyfile = "custMpk.pem";
-			sw-rev = <1>;
-			content-sbl = <&u_boot_spl>;
-			content-sysfw = <&ti_fs_enc>;
-			content-sysfw-data = <&combined_tifs_cfg>;
-			content-sysfw-inner-cert = <&sysfw_inner_cert>;
-			content-dm-data = <&combined_dm_cfg>;
-			load = <0x43c00000>;
-			load-sysfw = <0x40000>;
-			load-sysfw-data = <0x67000>;
-			load-dm-data = <0x43c3a800>;
-		};
-		u_boot_spl: u-boot-spl {
-			no-expanded;
-		};
-		ti_fs_enc: ti-fs-enc.bin {
-			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-enc.bin";
-			type = "blob-ext";
-			optional;
-		};
-		combined_tifs_cfg: combined-tifs-cfg.bin {
-			filename = "combined-tifs-cfg.bin";
-			type = "blob-ext";
-		};
-		sysfw_inner_cert: sysfw-inner-cert {
-			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-cert.bin";
-			type = "blob-ext";
-			optional;
-		};
-		combined_dm_cfg: combined-dm-cfg.bin {
-			filename = "combined-dm-cfg.bin";
-			type = "blob-ext";
-		};
+		insert-template = <&tiboot3_am62x_hs>;
 	};
-};
 
-&binman {
-	tiboot3-am62x-hs-fs-verdin.bin {
+	tiboot3-am62x-hs-fs-verdin {
 		filename = "tiboot3-am62x-hs-fs-verdin.bin";
-		symlink = "tiboot3.bin";
-		ti-secure-rom {
-			content = <&u_boot_spl_fs>, <&ti_fs_enc_fs>, <&combined_tifs_cfg_fs>,
-				<&combined_dm_cfg_fs>, <&sysfw_inner_cert_fs>;
-			combined;
-			dm-data;
-			sysfw-inner-cert;
-			keyfile = "custMpk.pem";
-			sw-rev = <1>;
-			content-sbl = <&u_boot_spl_fs>;
-			content-sysfw = <&ti_fs_enc_fs>;
-			content-sysfw-data = <&combined_tifs_cfg_fs>;
-			content-sysfw-inner-cert = <&sysfw_inner_cert_fs>;
-			content-dm-data = <&combined_dm_cfg_fs>;
-			load = <0x43c00000>;
-			load-sysfw = <0x40000>;
-			load-sysfw-data = <0x67000>;
-			load-dm-data = <0x43c3a800>;
-		};
-		u_boot_spl_fs: u-boot-spl {
-			no-expanded;
-		};
-		ti_fs_enc_fs: ti-fs-enc.bin {
-			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-fs-enc.bin";
-			type = "blob-ext";
-			optional;
-		};
-		combined_tifs_cfg_fs: combined-tifs-cfg.bin {
-			filename = "combined-tifs-cfg.bin";
-			type = "blob-ext";
-		};
-		sysfw_inner_cert_fs: sysfw-inner-cert {
-			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-fs-cert.bin";
-			type = "blob-ext";
-			optional;
-		};
-		combined_dm_cfg_fs: combined-dm-cfg.bin {
-			filename = "combined-dm-cfg.bin";
-			type = "blob-ext";
-		};
+		insert-template = <&tiboot3_am62x_hs_fs>;
 	};
-};
 
-&binman {
-	tiboot3-am62x-gp-verdin.bin {
+	tiboot3-am62x-gp-verdin {
 		filename = "tiboot3-am62x-gp-verdin.bin";
-		ti-secure-rom {
-			content = <&u_boot_spl_unsigned>, <&ti_fs_gp>,
-				<&combined_tifs_cfg_gp>, <&combined_dm_cfg_gp>;
-			combined;
-			dm-data;
-			content-sbl = <&u_boot_spl_unsigned>;
-			load = <0x43c00000>;
-			content-sysfw = <&ti_fs_gp>;
-			load-sysfw = <0x40000>;
-			content-sysfw-data = <&combined_tifs_cfg_gp>;
-			load-sysfw-data = <0x67000>;
-			content-dm-data = <&combined_dm_cfg_gp>;
-			load-dm-data = <0x43c3a800>;
-			sw-rev = <1>;
-			keyfile = "ti-degenerate-key.pem";
-		};
-		u_boot_spl_unsigned: u-boot-spl {
-			no-expanded;
-		};
-		ti_fs_gp: ti-fs-gp.bin {
-			filename = "ti-sysfw/ti-fs-firmware-am62x-gp.bin";
-			type = "blob-ext";
-			optional;
-		};
-		combined_tifs_cfg_gp: combined-tifs-cfg-gp.bin {
-			filename = "combined-tifs-cfg.bin";
-			type = "blob-ext";
-		};
-		combined_dm_cfg_gp: combined-dm-cfg-gp.bin {
-			filename = "combined-dm-cfg.bin";
-			type = "blob-ext";
-		};
+		insert-template = <&tiboot3_am62x_gp>;
 	};
 };
 
@@ -140,175 +32,21 @@
 
 #ifdef CONFIG_TARGET_VERDIN_AM62_A53
 
-#define SPL_VERDIN_AM62_DTB "spl/dts/k3-am625-verdin-wifi-dev.dtb"
-#define VERDIN_AM62_DTB "u-boot.dtb"
-
 &binman {
-	ti-dm {
-		filename = "ti-dm.bin";
-		blob-ext {
-			filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-		};
+	tispl {
+		insert-template = <&ti_spl>;
 	};
-	ti-spl {
-		insert-template = <&ti_spl_template>;
-
-		fit {
-
-			images {
-				dm {
-					ti-secure {
-						content = <&dm>;
-						keyfile = "custMpk.pem";
-					};
-					dm: ti-dm {
-						filename = "ti-dm.bin";
-					};
-				};
 
-				fdt-0 {
-					description = "k3-am625-verdin-wifi-dev";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					ti-secure {
-						content = <&spl_verdin_am62_dtb>;
-						keyfile = "custMpk.pem";
-					};
-					spl_verdin_am62_dtb: blob-ext {
-						filename = SPL_VERDIN_AM62_DTB;
-					};
-				};
-			};
-
-			configurations {
-				default = "conf-0";
-
-				conf-0 {
-					description = "k3-am625-verdin-wifi-dev";
-					firmware = "atf";
-					loadables = "tee", "dm", "spl";
-					fdt = "fdt-0";
-				};
-			};
-		};
-	};
-};
-
-&binman {
 	u-boot {
-		insert-template = <&u_boot_template>;
-
-		fit {
-			images {
-				uboot {
-					description = "U-Boot fot AM625 Verdin Board";
-				};
-
-				fdt-0 {
-					description = "k3-am625-verdin-wifi-dev";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					ti-secure {
-						content = <&verdin_am62_dtb>;
-						keyfile = "custMpk.pem";
-					};
-					verdin_am62_dtb: blob-ext {
-						filename = VERDIN_AM62_DTB;
-					};
-					hash {
-						algo = "crc32";
-					};
-				};
-			};
-
-			configurations {
-				default = "conf-0";
-
-				conf-0 {
-					description = "k3-am625-verdin-wifi-dev";
-					firmware = "uboot";
-					loadables = "uboot";
-					fdt = "fdt-0";
-				};
-			};
-		};
+		insert-template = <&u_boot>;
 	};
-};
-
-&binman {
-	ti-spl_unsigned {
-		insert-template = <&ti_spl_unsigned_template>;
-
-		fit {
-			images {
-				dm {
-					ti-dm {
-						filename = "ti-dm.bin";
-					};
-				};
-
-				fdt-0 {
-					description = "k3-am625-verdin-wifi-dev";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					blob {
-						filename = SPL_VERDIN_AM62_DTB;
-					};
-				};
-			};
 
-			configurations {
-				default = "conf-0";
-
-				conf-0 {
-					description = "k3-am625-verdin-wifi-dev";
-					firmware = "atf";
-					loadables = "tee", "dm", "spl";
-					fdt = "fdt-0";
-				};
-			};
-		};
+	tispl-unsigned {
+		insert-template = <&ti_spl_unsigned>;
 	};
-};
-
-&binman {
-	u-boot_unsigned {
-		insert-template = <&u_boot_unsigned_template>;
-
-		fit {
-			images {
-				uboot {
-					description = "U-Boot for AM625 Verdin Board";
-				};
-
-				fdt-0 {
-					description = "k3-am625-verdin-wifi-dev";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					blob {
-						filename = VERDIN_AM62_DTB;
-					};
-					hash {
-						algo = "crc32";
-					};
-				};
-			};
-
-			configurations {
-				default = "conf-0";
 
-				conf-0 {
-					description = "k3-am625-verdin-wifi-dev";
-					firmware = "uboot";
-					loadables = "uboot";
-					fdt = "fdt-0";
-				};
-			};
-		};
+	u-boot-unsigned {
+		insert-template = <&u_boot_unsigned>;
 	};
 };
 
diff --git a/arch/arm/dts/k3-am62a-sk-binman.dtsi b/arch/arm/dts/k3-am62a-sk-binman.dtsi
index ec3bf7ce913..1fc0b3ef14c 100644
--- a/arch/arm/dts/k3-am62a-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am62a-sk-binman.dtsi
@@ -5,14 +5,15 @@
 
 #include "k3-binman.dtsi"
 
-#ifdef CONFIG_TARGET_AM62A7_R5_EVM
+#ifndef CONFIG_ARM64
 
 &rcfg_yaml_tifs {
 	config = "tifs-rm-cfg.yaml";
 };
 
 &binman {
-	tiboot3-am62ax-hs-evm.bin {
+	tiboot3_am62ax_hs: template-9 {
+		section {
 		filename = "tiboot3-am62ax-hs-evm.bin";
 		ti-secure-rom {
 			content = <&u_boot_spl>, <&ti_fs_enc>, <&combined_tifs_cfg>,
@@ -53,13 +54,15 @@
 			filename = "combined-dm-cfg.bin";
 			type = "blob-ext";
 		};
+		};
 	};
 };
 
 &binman {
-	tiboot3-am62ax-hs-fs-evm.bin {
+	tiboot3_am62ax_hs_fs: template-10 {
 		filename = "tiboot3-am62ax-hs-fs-evm.bin";
 		symlink = "tiboot3.bin";
+		section {
 		ti-secure-rom {
 			content = <&u_boot_spl_fs>, <&ti_fs_enc_fs>, <&combined_tifs_cfg_fs>,
 				<&combined_dm_cfg_fs>, <&sysfw_inner_cert_fs>;
@@ -99,12 +102,14 @@
 			filename = "combined-dm-cfg.bin";
 			type = "blob-ext";
 		};
+		};
 	};
 };
 
 &binman {
-	tiboot3-am62ax-gp-evm.bin {
+	tiboot3_am62ax_gp: template-11 {
 		filename = "tiboot3-am62ax-gp-evm.bin";
+		section {
 		ti-secure-rom {
 			content = <&u_boot_spl_unsigned>, <&ti_fs_gp>,
 				<&combined_tifs_cfg_gp>, <&combined_dm_cfg_gp>;
@@ -137,15 +142,11 @@
 			filename = "combined-dm-cfg.bin";
 			type = "blob-ext";
 		};
+		};
 	};
 };
 
-#endif
-
-#ifdef CONFIG_TARGET_AM62A7_A53_EVM
-
-#define SPL_AM62A7_SK_DTB "spl/dts/k3-am62a7-sk.dtb"
-#define AM62A7_SK_DTB "u-boot.dtb"
+#else
 
 &binman {
 	ti-dm {
@@ -154,7 +155,7 @@
 			filename = "ti-dm/am62axx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
 		};
 	};
-	ti-spl {
+	ti_spl: template-12 {
 		insert-template = <&ti_spl_template>;
 
 		fit {
@@ -168,83 +169,19 @@
 						filename = "ti-dm.bin";
 					};
 				};
-
-				fdt-0 {
-					description = "k3-am62a7-sk";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					ti-secure {
-						content = <&spl_am62a7_sk_dtb>;
-						keyfile = "custMpk.pem";
-					};
-					spl_am62a7_sk_dtb: blob-ext {
-						filename = SPL_AM62A7_SK_DTB;
-					};
-
-				};
-
-			};
-
-			configurations {
-				default = "conf-0";
-
-				conf-0 {
-					description = "k3-am62a7-sk";
-					firmware = "atf";
-					loadables = "tee", "dm", "spl";
-					fdt = "fdt-0";
-				};
 			};
 		};
 	};
 };
 
 &binman {
-	u-boot {
+	u_boot: template-13 {
 		insert-template = <&u_boot_template>;
-
-		fit {
-			images {
-				uboot {
-					description = "U-Boot for AM62Ax Board";
-				};
-
-				fdt-0 {
-					description = "k3-am62a7-sk";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					ti-secure {
-						content = <&am62a7_sk_dtb>;
-						keyfile = "custMpk.pem";
-					};
-					am62a7_sk_dtb: blob-ext {
-						filename = AM62A7_SK_DTB;
-					};
-					hash {
-						algo = "crc32";
-					};
-				};
-			};
-
-			configurations {
-				default = "conf-0";
-
-				conf-0 {
-					description = "k3-am62a7-sk";
-					firmware = "uboot";
-					loadables = "uboot";
-					fdt = "fdt-0";
-				};
-
-			};
-		};
 	};
 };
 
 &binman {
-	ti-spl_unsigned {
+	ti_spl_unsigned: template-14 {
 		insert-template = <&ti_spl_unsigned_template>;
 
 		fit {
@@ -254,67 +191,14 @@
 						filename = "ti-dm.bin";
 					};
 				};
-
-				fdt-0 {
-					description = "k3-am62a7-sk";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					blob {
-						filename = SPL_AM62A7_SK_DTB;
-					};
-				};
-			};
-
-			configurations {
-				default = "conf-0";
-
-				conf-0 {
-					description = "k3-am62a7-sk";
-					firmware = "atf";
-					loadables = "tee", "dm", "spl";
-					fdt = "fdt-0";
-				};
 			};
 		};
 	};
 };
 
 &binman {
-	u-boot_unsigned {
+	u_boot_unsigned: template-15 {
 		insert-template = <&u_boot_unsigned_template>;
-
-		fit {
-			images {
-				uboot {
-					description = "U-Boot for AM62Ax Board";
-				};
-
-				fdt-0 {
-					description = "k3-am62a7-sk";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					blob {
-						filename = AM62A7_SK_DTB;
-					};
-					hash {
-						algo = "crc32";
-					};
-				};
-			};
-
-			configurations {
-				default = "conf-0";
-
-				conf-0 {
-					description = "k3-am62a7-sk";
-					firmware = "uboot";
-					loadables = "uboot";
-					fdt = "fdt-0";
-				};
-			};
-		};
 	};
 };
 #endif
diff --git a/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi b/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi
index 31b89b41748..d8ee892dcd5 100644
--- a/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi
@@ -4,6 +4,10 @@
  * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
  */
 
+#define SPL_BOARD_DTB "spl/dts/k3-am62a7-sk.dtb"
+#define BOARD_DESCRIPTION "k3-am62a7-sk"
+#define UBOOT_BOARD_DESCRIPTION "U-Boot for AM62Ax SK"
+
 #include "k3-am62a-sk-binman.dtsi"
 
 / {
@@ -187,3 +191,41 @@
 &cpsw_port1 {
 	bootph-all;
 };
+
+#ifndef CONFIG_ARM64
+
+&binman {
+	tiboot3-am62ax-hs-sk {
+		insert-template = <&tiboot3_am62ax_hs>;
+	};
+
+	tiboot3-am62ax-hs-fs-sk {
+		insert-template = <&tiboot3_am62ax_hs_fs>;
+	};
+
+	tiboot3-am62ax-gp-sk {
+		insert-template = <&tiboot3_am62ax_gp>;
+	};
+};
+
+#else
+
+&binman {
+	tispl {
+		insert-template = <&ti_spl>;
+	};
+
+	u-boot {
+		insert-template = <&u_boot>;
+	};
+
+	tispl-unsigned {
+		insert-template = <&ti_spl_unsigned>;
+	};
+
+	u-boot-unsigned {
+		insert-template = <&u_boot_unsigned>;
+	};
+};
+
+#endif
diff --git a/arch/arm/dts/k3-am642-evm-u-boot.dtsi b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
index ee6656774d6..4e9a2d4bd4a 100644
--- a/arch/arm/dts/k3-am642-evm-u-boot.dtsi
+++ b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
@@ -3,6 +3,10 @@
  * Copyright (C) 2020-2021 Texas Instruments Incorporated - https://www.ti.com/
  */
 
+#define SPL_BOARD_DTB "spl/dts/ti/k3-am642-evm.dtb"
+#define BOARD_DESCRIPTION "k3-am642-evm"
+#define UBOOT_BOARD_DESCRIPTION "U-Boot for AM642 EVM"
+
 #include "k3-am64x-binman.dtsi"
 
 / {
@@ -88,3 +92,41 @@
 		bootph-all;
 	};
 };
+
+#ifndef CONFIG_ARM64
+
+&binman {
+	tiboot3-am64x-sr2-hs-evm {
+		insert-template = <&tiboot3_am64x_sr2_hs_evm>;
+	};
+
+	tiboot3-am64x-sr2-hs-fs-evm {
+		insert-template = <&tiboot3_am64x_sr2_hs_fs_evm>;
+	};
+
+	tiboot3-am64x-gp-evm {
+		insert-template = <&tiboot3_am64x_gp_evm>;
+	};
+};
+
+#else
+
+&binman {
+	tispl {
+		insert-template = <&ti_spl>;
+	};
+
+	u-boot {
+		insert-template = <&u_boot>;
+	};
+
+	tispl-unsigned {
+		insert-template = <&ti_spl_unsigned>;
+	};
+
+	u-boot-unsigned {
+		insert-template = <&u_boot_unsigned>;
+	};
+};
+
+#endif
diff --git a/arch/arm/dts/k3-am642-sk-u-boot.dtsi b/arch/arm/dts/k3-am642-sk-u-boot.dtsi
index 7e6b2981346..7b5a8640cc6 100644
--- a/arch/arm/dts/k3-am642-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am642-sk-u-boot.dtsi
@@ -3,6 +3,10 @@
  * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
  */
 
+#define SPL_BOARD_DTB "spl/dts/ti/k3-am642-sk.dtb"
+#define BOARD_DESCRIPTION "k3-am642-sk"
+#define UBOOT_BOARD_DESCRIPTION "U-Boot for AM642 SK"
+
 #include "k3-am64x-binman.dtsi"
 
 / {
@@ -133,3 +137,41 @@
 		bootph-all;
 	};
 };
+
+#ifndef CONFIG_ARM64
+
+&binman {
+	tiboot3-am64x-sr2-hs-sk {
+		insert-template = <&tiboot3_am64x_sr2_hs_evm>;
+	};
+
+	tiboot3-am64x-sr2-hs-fs-sk {
+		insert-template = <&tiboot3_am64x_sr2_hs_fs_evm>;
+	};
+
+	tiboot3-am64x-gp-sk {
+		insert-template = <&tiboot3_am64x_gp_evm>;
+	};
+};
+
+#else
+
+&binman {
+	tispl {
+		insert-template = <&ti_spl>;
+	};
+
+	u-boot {
+		insert-template = <&u_boot>;
+	};
+
+	tispl-unsigned {
+		insert-template = <&ti_spl_unsigned>;
+	};
+
+	u-boot-unsigned {
+		insert-template = <&u_boot_unsigned>;
+	};
+};
+
+#endif
diff --git a/arch/arm/dts/k3-am64x-binman.dtsi b/arch/arm/dts/k3-am64x-binman.dtsi
index 37817ba60d2..c8ae6250129 100644
--- a/arch/arm/dts/k3-am64x-binman.dtsi
+++ b/arch/arm/dts/k3-am64x-binman.dtsi
@@ -3,11 +3,12 @@
 
 #include "k3-binman.dtsi"
 
-#ifdef CONFIG_TARGET_AM642_R5_EVM
+#ifndef CONFIG_ARM64
 
 &binman {
-	tiboot3-am64x_sr2-hs-evm.bin {
+	tiboot3_am64x_sr2_hs_evm: template-9 {
 		filename = "tiboot3-am64x_sr2-hs-evm.bin";
+		section {
 		ti-secure-rom {
 			content = <&u_boot_spl>, <&ti_sci_enc>,
 				<&combined_sysfw_cfg>, <&sysfw_inner_cert>;
@@ -40,14 +41,15 @@
 			type = "blob-ext";
 			optional;
 		};
-
+	};
 	};
 };
 
 &binman {
-	tiboot3-am64x_sr2-hs-fs-evm.bin {
+	tiboot3_am64x_sr2_hs_fs_evm: template-10 {
 		filename = "tiboot3-am64x_sr2-hs-fs-evm.bin";
 		symlink = "tiboot3.bin";
+		section {
 		ti-secure-rom {
 			content = <&u_boot_spl_fs>, <&ti_sci_enc_fs>,
 				<&combined_sysfw_cfg_fs>, <&sysfw_inner_cert_fs>;
@@ -80,13 +82,14 @@
 			type = "blob-ext";
 			optional;
 		};
-
+	};
 	};
 };
 
 &binman {
-	tiboot3-am64x-gp-evm.bin {
+	tiboot3_am64x_gp_evm: template-11 {
 		filename = "tiboot3-am64x-gp-evm.bin";
+		section {
 		ti-secure-rom {
 			content = <&u_boot_spl_unsigned>, <&ti_sci_gp>, <&combined_sysfw_cfg_gp>;
 			combined;
@@ -112,157 +115,35 @@
 			type = "blob-ext";
 		};
 	};
+	};
 };
 
-#endif
-
-#ifdef CONFIG_TARGET_AM642_A53_EVM
-
-#define SPL_AM642_EVM_DTB "spl/dts/ti/k3-am642-evm.dtb"
-#define SPL_AM642_SK_DTB "spl/dts/ti/k3-am642-sk.dtb"
-
-#define AM642_EVM_DTB "u-boot.dtb"
-#define AM642_SK_DTB "dts/upstream/src/arm64/ti/k3-am642-sk.dtb"
+#else
 
 &binman {
-	ti-spl {
+	ti_spl: template-12 {
 		insert-template = <&ti_spl_template>;
 
 		fit {
-			description = "Configuration to load ATF and SPL";
-			#address-cells = <1>;
-
 			images {
 				dm {
 					blob-ext {
 						filename = "/dev/null";
 					};
 				};
-
-
-				fdt-0 {
-					description = "k3-am642-evm";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					ti-secure {
-						content = <&spl_am64x_evm_dtb>;
-						keyfile = "custMpk.pem";
-					};
-					spl_am64x_evm_dtb: blob-ext {
-						filename = SPL_AM642_EVM_DTB;
-					};
-
-				};
-
-				fdt-1 {
-					description = "k3-am642-sk";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					ti-secure {
-						content = <&spl_am64x_sk_dtb>;
-						keyfile = "custMpk.pem";
-					};
-					spl_am64x_sk_dtb: blob-ext {
-						filename = SPL_AM642_SK_DTB;
-					};
-
-				};
-			};
-
-			configurations {
-				default = "conf-0";
-
-				conf-0 {
-					description = "k3-am642-evm";
-					firmware = "atf";
-					loadables = "tee", "dm", "spl";
-					fdt = "fdt-0";
-				};
-
-				conf-1 {
-					description = "k3-am642-sk";
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
+	u_boot: template-13 {
 		insert-template = <&u_boot_template>;
-
-		fit {
-			images {
-				uboot {
-					description = "U-Boot for AM64 Board";
-				};
-
-				fdt-0 {
-					description = "k3-am642-evm";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					ti-secure {
-						content = <&am64x_evm_dtb>;
-						keyfile = "custMpk.pem";
-
-					};
-					am64x_evm_dtb: blob-ext {
-						filename = AM642_EVM_DTB;
-					};
-					hash {
-						algo = "crc32";
-					};
-				};
-
-				fdt-1 {
-					description = "k3-am642-sk";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					ti-secure {
-						content = <&am64x_sk_dtb>;
-						keyfile = "custMpk.pem";
-
-					};
-					am64x_sk_dtb: blob-ext {
-						filename = AM642_SK_DTB;
-					};
-					hash {
-						algo = "crc32";
-					};
-				};
-
-			};
-
-			configurations {
-				default = "conf-0";
-
-				conf-0 {
-					description = "k3-am642-evm";
-					firmware = "uboot";
-					loadables = "uboot";
-					fdt = "fdt-0";
-				};
-
-				conf-1 {
-					description = "k3-am642-sk";
-					firmware = "uboot";
-					loadables = "uboot";
-					fdt = "fdt-1";
-				};
-			};
-		};
 	};
 };
 
 &binman {
-	ti-spl_unsigned {
+	ti_spl_unsigned: template-14 {
 		insert-template = <&ti_spl_unsigned_template>;
 
 		fit {
@@ -273,104 +154,14 @@
 						filename = "/dev/null";
 					};
 				};
-
-				fdt-0 {
-					description = "k3-am642-evm";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					blob {
-						filename = SPL_AM642_EVM_DTB;
-					};
-				};
-
-				fdt-1 {
-					description = "k3-am642-sk";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					blob {
-						filename = SPL_AM642_SK_DTB;
-					};
-				};
-			};
-
-			configurations {
-				default = "conf-0";
-
-				conf-0 {
-					description = "k3-am642-evm";
-					firmware = "atf";
-					loadables = "tee", "dm", "spl";
-					fdt = "fdt-0";
-				};
-
-				conf-1 {
-					description = "k3-am642-sk";
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
+	u_boot_unsigned: template-15 {
 		insert-template = <&u_boot_unsigned_template>;
-
-		fit {
-			images {
-				uboot {
-					description = "U-Boot for AM64 Board";
-				};
-
-				fdt-0 {
-					description = "k3-am642-evm";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					blob {
-						filename = AM642_EVM_DTB;
-					};
-					hash {
-						algo = "crc32";
-					};
-				};
-
-				fdt-1 {
-					description = "k3-am642-sk";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					blob {
-						filename = AM642_SK_DTB;
-					};
-					hash {
-						algo = "crc32";
-					};
-				};
-			};
-
-			configurations {
-				default = "conf-0";
-
-				conf-0 {
-					description = "k3-am642-evm";
-					firmware = "uboot";
-					loadables = "uboot";
-					fdt = "fdt-0";
-				};
-
-				conf-1 {
-					description = "k3-am642-sk";
-					firmware = "uboot";
-					loadables = "uboot";
-					fdt = "fdt-1";
-				};
-			};
-		};
 	};
 };
 #endif
diff --git a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
index 4fd188fa191..8899e5599ec 100644
--- a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
@@ -3,6 +3,11 @@
  * Copyright (C) 2018-2021 Texas Instruments Incorporated - https://www.ti.com/
  */
 
+#define SPL_BOARD_DTB "spl/dts/k3-am654-base-board.dtb"
+#define BOARD_DESCRIPTION "k3-am654-base-board"
+
+#define UBOOT_BOARD_DESCRIPTION "U-Boot for AM654 Base Board"
+
 #include "k3-am65x-binman.dtsi"
 
 / {
@@ -274,3 +279,47 @@
 	reg-names = "gcfg", "rchanrt", "tchanrt",
 		    "tchan", "rchan", "rflow";
 };
+
+#ifndef CONFIG_ARM64
+
+&binman {
+	tiboot3-am65x-sr2-hs-evm {
+		insert-template = <&tiboot3_am65x_sr2_hs_evm>;
+	};
+
+	itb-am65x-sr2-hs-evm {
+		insert-template = <&itb>;
+	};
+};
+
+&binman {
+	tiboot3-am65x-sr2-gp-evm {
+		insert-template = <&tiboot3_am65x_sr2_gp_evm>;
+	};
+
+	itb-am65x-sr2-gp-evm {
+		insert-template = <&itb_gp>;
+	};
+};
+
+#else
+
+&binman {
+	tispl {
+		insert-template = <&ti_spl>;
+	};
+
+	u-boot {
+		insert-template = <&u_boot>;
+	};
+
+	tispl-unsigned {
+		insert-template = <&ti_spl_unsigned>;
+	};
+
+	u-boot-unsigned {
+		insert-template = <&u_boot_unsigned>;
+	};
+};
+
+#endif
diff --git a/arch/arm/dts/k3-am65x-binman.dtsi b/arch/arm/dts/k3-am65x-binman.dtsi
index 8cc24da1f3f..f1f0093bbb1 100644
--- a/arch/arm/dts/k3-am65x-binman.dtsi
+++ b/arch/arm/dts/k3-am65x-binman.dtsi
@@ -5,11 +5,12 @@
 
 #include "k3-binman.dtsi"
 
-#ifdef CONFIG_TARGET_AM654_R5_EVM
+#ifndef CONFIG_ARM64
 
 &binman {
-	tiboot3-am65x_sr2-hs-evm.bin {
+	tiboot3_am65x_sr2_hs_evm: template-9 {
 		filename = "tiboot3-am65x_sr2-hs-evm.bin";
+		section {
 		ti-secure-rom {
 			content = <&u_boot_spl>;
 			core = "public";
@@ -20,6 +21,7 @@
 			no-expanded;
 		};
 	};
+	};
 	sysfw {
 		filename = "sysfw.bin";
 		ti-secure-rom {
@@ -40,16 +42,17 @@
 			optional;
 		};
 	};
-	itb {
+	itb: template-10 {
 		filename = "sysfw-am65x_sr2-hs-evm.itb";
 		insert-template = <&itb_template>;
 	};
 };
 
 &binman {
-	tiboot3-am65x_sr2-gp-evm.bin {
+	tiboot3_am65x_sr2_gp_evm: template-11 {
 		filename = "tiboot3-am65x_sr2-gp-evm.bin";
 		symlink = "tiboot3.bin";
+		section {
 		ti-secure-rom {
 			content = <&u_boot_spl_unsigned>;
 			core = "public";
@@ -61,6 +64,7 @@
 			no-expanded;
 		};
 	};
+	};
 	sysfw_gp {
 		filename = "sysfw.bin_gp";
 		ti-secure-rom {
@@ -76,7 +80,7 @@
 			optional;
 		};
 	};
-	itb_gp {
+	itb_gp: template-12 {
 		filename = "sysfw-am65x_sr2-gp-evm.itb";
 		symlink = "sysfw.itb";
 		insert-template = <&itb_unsigned_template>;
@@ -91,15 +95,11 @@
 		};
 	};
 };
-#endif
-
-#ifdef CONFIG_TARGET_AM654_A53_EVM
 
-#define SPL_AM654_EVM_DTB "spl/dts/k3-am654-base-board.dtb"
-#define AM654_EVM_DTB "u-boot.dtb"
+#else
 
 &binman {
-	ti-spl {
+	ti_spl: template-13 {
 		insert-template = <&ti_spl_template>;
 
 		fit {
@@ -110,82 +110,19 @@
 						filename = "/dev/null";
 					};
 				};
-
-				fdt-0 {
-					description = "k3-am654-base-board";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					ti-secure {
-						content = <&spl_am65x_evm_dtb>;
-						keyfile = "custMpk.pem";
-					};
-					spl_am65x_evm_dtb: blob-ext {
-						filename = SPL_AM654_EVM_DTB;
-					};
-				};
-			};
-
-			configurations {
-				default = "conf-0";
-
-				conf-0 {
-					description = "k3-am654-base-board";
-					firmware = "atf";
-					loadables = "tee", "dm", "spl";
-					fdt = "fdt-0";
-				};
 			};
 		};
 	};
 };
 
 &binman {
-	u-boot {
+	u_boot: template-14 {
 		insert-template = <&u_boot_template>;
-
-		fit {
-			images {
-				uboot {
-					description = "U-Boot for AM65 Board";
-				};
-
-				fdt-0 {
-					description = "k3-am654-base-board";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					ti-secure {
-						content = <&am65x_evm_dtb>;
-						keyfile = "custMpk.pem";
-
-					};
-					am65x_evm_dtb: blob-ext {
-						filename = AM654_EVM_DTB;
-					};
-					hash {
-						algo = "crc32";
-					};
-				};
-
-			};
-
-			configurations {
-				default = "conf-0";
-
-				conf-0 {
-					description = "k3-am654-base-board";
-					firmware = "uboot";
-					loadables = "uboot";
-					fdt = "fdt-0";
-				};
-			};
-		};
 	};
 };
 
 &binman {
-	ti-spl_unsigned {
+	ti_spl_unsigned: template-15 {
 		insert-template = <&ti_spl_unsigned_template>;
 
 		fit {
@@ -195,67 +132,14 @@
 						filename = "/dev/null";
 					};
 				};
-
-				fdt-0 {
-					description = "k3-j721e-common-proc-board";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					blob {
-						filename = SPL_AM654_EVM_DTB;
-					};
-				};
-			};
-
-			configurations {
-				default = "conf-0";
-
-				conf-0 {
-					description = "k3-am654-base-board";
-					firmware = "atf";
-					loadables = "tee", "dm", "spl";
-					fdt = "fdt-0";
-				};
 			};
 		};
 	};
 };
 
 &binman {
-	u-boot_unsigned {
+	u_boot_unsigned: template-16 {
 		insert-template = <&u_boot_unsigned_template>;
-
-		fit {
-			images {
-				uboot {
-					description = "U-Boot for AM65 Board";
-				};
-
-				fdt-0 {
-					description = "k3-am654-base-board";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					blob {
-						filename = AM654_EVM_DTB;
-					};
-					hash {
-						algo = "crc32";
-					};
-				};
-			};
-
-			configurations {
-				default = "conf-0";
-
-				conf-0 {
-					description = "k3-am654-base-board";
-					firmware = "uboot";
-					loadables = "uboot";
-					fdt = "fdt-0";
-				};
-			};
-		};
 	};
 };
 #endif
diff --git a/arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi b/arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi
index 4f34347586e..0ade1ef53cb 100644
--- a/arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi
@@ -3,6 +3,10 @@
  * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
  */
 
+#define SPL_BOARD_DTB "spl/dts/k3-am68-sk-base-board.dtb"
+#define BOARD_DESCRIPTION "k3-am68-sk-base-board"
+#define UBOOT_BOARD_DESCRIPTION "U-Boot for AM68 SK"
+
 #include "k3-j721s2-binman.dtsi"
 
 &wkup_i2c0 {
@@ -133,3 +137,25 @@
 	dr_mode = "peripheral";
 	bootph-all;
 };
+
+#ifndef CONFIG_ARM64
+
+&binman {
+	tiboot3-am68-sk {
+		insert-template = <&tiboot3_j721s2_hs_fs_evm>;
+	};
+};
+
+#else
+
+&binman {
+	tispl {
+		insert-template = <&ti_spl>;
+	};
+
+	u-boot {
+		insert-template = <&u_boot>;
+	};
+};
+
+#endif
diff --git a/arch/arm/dts/k3-am69-sk-u-boot.dtsi b/arch/arm/dts/k3-am69-sk-u-boot.dtsi
index bed330e6d4e..866836909df 100644
--- a/arch/arm/dts/k3-am69-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am69-sk-u-boot.dtsi
@@ -3,6 +3,10 @@
  * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
  */
 
+#define SPL_BOARD_DTB "spl/dts/ti/k3-am69-sk.dtb"
+#define BOARD_DESCRIPTION "k3-am68-sk"
+#define UBOOT_BOARD_DESCRIPTION "U-Boot for AM69 SK"
+
 #include "k3-j784s4-binman.dtsi"
 
 / {
@@ -30,25 +34,24 @@
 	};
 };
 
-#ifdef CONFIG_TARGET_J784S4_A72_EVM
-
-#define SPL_AM69_SK_DTB "spl/dts/ti/k3-am69-sk.dtb"
-#define AM69_SK_DTB "u-boot.dtb"
+#ifndef CONFIG_ARM64
 
-&spl_j784s4_evm_dtb {
-	filename = SPL_AM69_SK_DTB;
+&binman {
+	tiboot3-am69-sk {
+		insert-template = <&tiboot3_j784s4_hs_fs_evm>;
+	};
 };
 
-&j784s4_evm_dtb {
-	filename = AM69_SK_DTB;
-};
+#else
 
-&spl_j784s4_evm_dtb_unsigned {
-	filename = SPL_AM69_SK_DTB;
-};
+&binman {
+	tispl {
+		insert-template = <&ti_spl>;
+	};
 
-&j784s4_evm_dtb_unsigned {
-	filename = AM69_SK_DTB;
+	u-boot {
+		insert-template = <&u_boot>;
+	};
 };
 
 #endif
diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index 5163161b94d..eb920c092ef 100644
--- a/arch/arm/dts/k3-binman.dtsi
+++ b/arch/arm/dts/k3-binman.dtsi
@@ -325,6 +325,27 @@
 					};
 				};
 
+				fdt-0 {
+					description = BOARD_DESCRIPTION;
+					ti-secure {
+						content = <&spl_board_dtb>;
+						keyfile = "custMpk.pem";
+					};
+					spl_board_dtb: blob-ext {
+						filename = SPL_BOARD_DTB;
+					};
+				};
+			};
+
+			configurations {
+				default = "conf-0";
+
+				conf-0 {
+					description = BOARD_DESCRIPTION;
+					firmware = "atf";
+					loadables = "tee", "dm", "spl";
+					fdt = "fdt-0";
+				};
 			};
 		};
 	};
@@ -387,6 +408,27 @@
 						filename = "spl/u-boot-spl-nodtb.bin";
 					};
 				};
+
+				fdt-0 {
+					description = BOARD_DESCRIPTION;
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
+					blob {
+						filename = SPL_BOARD_DTB;
+					};
+				};
+			};
+
+			configurations {
+				default = "conf-0";
+
+				conf-0 {
+					description = BOARD_DESCRIPTION;
+					firmware = "atf";
+					loadables = "tee", "dm", "spl";
+					fdt = "fdt-0";
+				};
 			};
 		};
 	};
@@ -399,6 +441,7 @@
 
 			images {
 				uboot {
+					description = UBOOT_BOARD_DESCRIPTION;
 					type = "firmware";
 					os = "u-boot";
 					arch = "arm";
@@ -414,6 +457,35 @@
 						algo = "crc32";
 					};
 				};
+
+				fdt-0 {
+					description = BOARD_DESCRIPTION;
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
+					ti-secure {
+						content = <&board_dtb>;
+						keyfile = "custMpk.pem";
+
+					};
+					board_dtb: blob {
+						filename = "u-boot.dtb";
+					};
+					hash {
+						algo = "crc32";
+					};
+				};
+			};
+
+			configurations {
+				default = "conf-0";
+
+				conf-0 {
+					description = BOARD_DESCRIPTION;
+					firmware = "uboot";
+					loadables = "uboot";
+					fdt = "fdt-0";
+				};
 			};
 		};
 	};
@@ -426,6 +498,7 @@
 
 			images {
 				uboot {
+					description = UBOOT_BOARD_DESCRIPTION;
 					type = "firmware";
 					os = "u-boot";
 					arch = "arm";
@@ -438,6 +511,29 @@
 						algo = "crc32";
 					};
 				};
+
+				fdt-0 {
+					description = BOARD_DESCRIPTION;
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
+					u-boot-dtb {
+					};
+					hash {
+						algo = "crc32";
+					};
+				};
+			};
+
+			configurations {
+				default = "conf-0";
+
+				conf-0 {
+					description = BOARD_DESCRIPTION;
+					firmware = "uboot";
+					loadables = "uboot";
+					fdt = "fdt-0";
+				};
 			};
 		};
 	};
diff --git a/arch/arm/dts/k3-j7200-binman.dtsi b/arch/arm/dts/k3-j7200-binman.dtsi
index 06db8659876..69efa81942a 100644
--- a/arch/arm/dts/k3-j7200-binman.dtsi
+++ b/arch/arm/dts/k3-j7200-binman.dtsi
@@ -5,7 +5,7 @@
 
 #include "k3-binman.dtsi"
 
-#ifdef CONFIG_TARGET_J7200_R5_EVM
+#ifndef CONFIG_ARM64
 
 &bcfg_yaml {
 	config = "board-cfg_j7200.yaml";
@@ -48,8 +48,9 @@
 };
 
 &binman {
-	tiboot3-j7200_sr2-hs-evm.bin {
+	tiboot3_j7200_sr2_hs_evm: template-9 {
 		filename = "tiboot3-j7200_sr2-hs-evm.bin";
+		section {
 		ti-secure-rom {
 			content = <&u_boot_spl>, <&ti_fs_enc>, <&combined_tifs_cfg>,
 				<&combined_dm_cfg>, <&sysfw_inner_cert>;
@@ -90,11 +91,13 @@
 			type = "blob-ext";
 		};
 	};
+	};
 };
 
 &binman {
-	tiboot3-j7200_sr2-hs-fs-evm.bin {
+	tiboot3_j7200_sr2_hs_fs_evm: template-10 {
 		filename = "tiboot3-j7200_sr2-hs-fs-evm.bin";
+		section {
 		ti-secure-rom {
 			content = <&u_boot_spl_fs>, <&ti_fs_enc_fs>, <&combined_tifs_cfg_fs>,
 				<&combined_dm_cfg_fs>, <&sysfw_inner_cert_fs>;
@@ -135,12 +138,14 @@
 			type = "blob-ext";
 		};
 	};
+	};
 };
 
 &binman {
-	tiboot3-j7200-gp-evm.bin {
+	tiboot3_j7200_gp_evm: template-11 {
 		filename = "tiboot3-j7200-gp-evm.bin";
 		symlink = "tiboot3.bin";
+		section {
 		ti-secure-rom {
 			content = <&u_boot_spl_unsigned>, <&ti_fs_gp>,
 				<&combined_tifs_cfg_gp>, <&combined_dm_cfg_gp>;
@@ -173,15 +178,11 @@
 			filename = "combined-dm-cfg.bin";
 			type = "blob-ext";
 		};
+		};
 	};
 };
 
-#endif
-
-#ifdef CONFIG_TARGET_J7200_A72_EVM
-
-#define SPL_J7200_EVM_DTB "spl/dts/k3-j7200-common-proc-board.dtb"
-#define J7200_EVM_DTB "u-boot.dtb"
+#else
 
 &binman {
 	ti-dm {
@@ -190,7 +191,7 @@
 			filename = "ti-dm/j7200/ipc_echo_testb_mcu1_0_release_strip.xer5f";
 		};
 	};
-	ti-spl {
+	ti_spl: template-12 {
 		insert-template = <&ti_spl_template>;
 
 		fit {
@@ -294,82 +295,19 @@
 						filename = "ti-dm.bin";
 					};
 				};
-
-				fdt-0 {
-					description = "k3-j7200-common-proc-board";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					ti-secure {
-						content = <&spl_j7200_evm_dtb>;
-						keyfile = "custMpk.pem";
-					};
-					spl_j7200_evm_dtb: blob-ext {
-						filename = SPL_J7200_EVM_DTB;
-					};
-				};
-
-			};
-
-			configurations {
-				default = "conf-0";
-
-				conf-0 {
-					description = "k3-j7200-common-proc-board";
-					firmware = "atf";
-					loadables = "tee", "dm", "spl";
-					fdt = "fdt-0";
-				};
 			};
 		};
 	};
 };
 
 &binman {
-	u-boot {
+	u_boot: template-13 {
 		insert-template = <&u_boot_template>;
-
-		fit {
-			images {
-				uboot {
-					description = "U-Boot for J7200 Board";
-				};
-
-				fdt-0 {
-					description = "k3-j7200-common-proc-board";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					ti-secure {
-						content = <&j7200_evm_dtb>;
-						keyfile = "custMpk.pem";
-					};
-					j7200_evm_dtb: blob-ext {
-						filename = J7200_EVM_DTB;
-					};
-					hash {
-						algo = "crc32";
-					};
-				};
-			};
-
-			configurations {
-				default = "conf-0";
-
-				conf-0 {
-					description = "k3-j7200-common-proc-board";
-					firmware = "uboot";
-					loadables = "uboot";
-					fdt = "fdt-0";
-				};
-
-			};
-		};
 	};
 };
 
 &binman {
-	ti-spl_unsigned {
+	ti_spl_unsigned: template-14 {
 		insert-template = <&ti_spl_unsigned_template>;
 
 		fit {
@@ -379,67 +317,14 @@
 						filename = "ti-dm.bin";
 					};
 				};
-
-				fdt-1 {
-					description = "k3-j7200-common-proc-board";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					blob {
-						filename = SPL_J7200_EVM_DTB;
-					};
-				};
-			};
-
-			configurations {
-				default = "conf-1";
-
-				conf-1 {
-					description = "k3-j7200-common-proc-board";
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
+	u_boot_unsigned: template-15 {
 		insert-template = <&u_boot_unsigned_template>;
-
-		fit {
-			images {
-				uboot {
-					description = "U-Boot for J7200 Board";
-				};
-
-				fdt-1 {
-					description = "k3-j7200-common-proc-board";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					blob {
-						filename = J7200_EVM_DTB;
-					};
-					hash {
-						algo = "crc32";
-					};
-				};
-			};
-
-			configurations {
-				default = "conf-1";
-
-				conf-1 {
-					description = "k3-j7200-common-proc-board";
-					firmware = "uboot";
-					loadables = "uboot";
-					fdt = "fdt-1";
-				};
-			};
-		};
 	};
 };
 #endif
diff --git a/arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi b/arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi
index c9fee0ea99b..c09672104d5 100644
--- a/arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi
@@ -3,6 +3,10 @@
  * Copyright (C) 2020-2023 Texas Instruments Incorporated - https://www.ti.com/
  */
 
+#define SPL_BOARD_DTB "spl/dts/k3-j7200-common-proc-board.dtb"
+#define BOARD_DESCRIPTION "k3-j7200-common-proc-board"
+#define UBOOT_BOARD_DESCRIPTION "U-Boot for J7200 EVM"
+
 #include "k3-j7200-binman.dtsi"
 
 / {
@@ -212,3 +216,39 @@
 &serdes0 {
 	bootph-all;
 };
+
+#ifndef CONFIG_ARM64
+
+&binman {
+	tiboot3-j7200-sr2-hs-evm {
+		insert-template = <&tiboot3_j7200_sr2_hs_evm>;
+	};
+	tiboot3-j7200-sr2-hs-fs-evm {
+		insert-template = <&tiboot3_j7200_sr2_hs_fs_evm>;
+	};
+	tiboot3-j7200-gp-evm {
+		insert-template = <&tiboot3_j7200_gp_evm>;
+	};
+};
+
+#else
+
+&binman {
+	tispl {
+		insert-template = <&ti_spl>;
+	};
+
+	u-boot {
+		insert-template = <&u_boot>;
+	};
+
+	tispl-unsigned {
+		insert-template = <&ti_spl_unsigned>;
+	};
+
+	u-boot-unsigned {
+		insert-template = <&u_boot_unsigned>;
+	};
+};
+
+#endif
diff --git a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
index 116ee373118..2059ace6c5b 100644
--- a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
+++ b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
@@ -7,7 +7,11 @@
  * Copyright (C) 2022-2023 Robert Nelson, BeagleBoard.org Foundation
  */
 
-#include "k3-binman.dtsi"
+#define SPL_BOARD_DTB "spl/dts/k3-j721e-beagleboneai64.dtb"
+#define BOARD_DESCRIPTION "k3-j721e-beagleboneai64"
+#define UBOOT_BOARD_DESCRIPTION "U-Boot for J721E BeagleBoneAI64"
+
+#include "k3-j721e-binman.dtsi"
 
 / {
 	memory@80000000 {
@@ -205,154 +209,14 @@
 
 #ifdef CONFIG_TARGET_J721E_A72_BEAGLEBONEAI64
 
-#define SPL_NODTB "spl/u-boot-spl-nodtb.bin"
-#define SPL_J721E_BBAI64_DTB "spl/dts/k3-j721e-beagleboneai64.dtb"
-
-#define UBOOT_NODTB "u-boot-nodtb.bin"
-#define J721E_BBAI64_DTB "arch/arm/dts/k3-j721e-beagleboneai64.dtb"
-
 &binman {
-	ti-dm {
-		filename = "ti-dm.bin";
-		blob-ext {
-			filename = "ti-dm/j721e/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-		};
-	};
 
-	ti-spl_unsigned {
-		filename = "tispl.bin_unsigned";
-		pad-byte = <0xff>;
-
-		fit {
-			description = "Configuration to load ATF and SPL";
-			#address-cells = <1>;
-
-			images {
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
-					load = <CONFIG_K3_OPTEE_LOAD_ADDR>;
-					entry = <CONFIG_K3_OPTEE_LOAD_ADDR>;
-					tee-os {
-						filename = "tee-raw.bin";
-					};
-				};
-
-				dm {
-					description = "DM binary";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "DM";
-					load = <0x89000000>;
-					entry = <0x89000000>;
-					blob-ext {
-						filename = "ti-dm.bin";
-					};
-				};
-
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
-				fdt-0 {
-					description = "k3-j721e-beagleboneai64";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					blob {
-						filename = SPL_J721E_BBAI64_DTB;
-					};
-				};
-			};
-
-			configurations {
-				default = "conf-0";
-
-				conf-0 {
-					description = "k3-j721e-beagleboneai64";
-					firmware = "atf";
-					loadables = "tee", "dm", "spl";
-					fdt = "fdt-0";
-				};
-			};
-		};
+	tispl-unsigned {
+		insert-template = <&ti_spl_unsigned>;
 	};
 
-	u-boot_unsigned {
-		filename = "u-boot.img_unsigned";
-		pad-byte = <0xff>;
-
-		fit {
-			description = "FIT image with multiple configurations";
-
-			images {
-				uboot {
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
-				};
-
-				fdt-0 {
-					description = "k3-j721e-beagleboneai64";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					blob {
-						filename = J721E_BBAI64_DTB;
-					};
-					hash {
-						algo = "crc32";
-					};
-				};
-			};
-
-			configurations {
-				default = "conf-0";
-
-				conf-0 {
-					description = "k3-j721e-beagleboneai64";
-					firmware = "uboot";
-					loadables = "uboot";
-					fdt = "fdt-0";
-				};
-			};
-		};
+	u-boot-unsigned {
+		insert-template = <&u_boot_unsigned>;
 	};
 };
 #endif
diff --git a/arch/arm/dts/k3-j721e-binman.dtsi b/arch/arm/dts/k3-j721e-binman.dtsi
index 75a6e9599b9..fb0f645774b 100644
--- a/arch/arm/dts/k3-j721e-binman.dtsi
+++ b/arch/arm/dts/k3-j721e-binman.dtsi
@@ -5,11 +5,12 @@
 
 #include "k3-binman.dtsi"
 
-#ifdef CONFIG_TARGET_J721E_R5_EVM
+#ifndef CONFIG_ARM64
 
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
@@ -141,9 +152,11 @@
 		u_boot_spl_fs: u-boot-spl {
 			no-expanded;
 		};
+		};
 	};
-	sysfw_fs {
+	sysfw_fs: template-16 {
 		filename = "sysfw.bin_fs";
+		section {
 		ti-fs-cert-fs.bin {
 			filename = "ti-sysfw/ti-fs-firmware-j721e_sr2-hs-fs-cert.bin";
 			type = "blob-ext";
@@ -154,17 +167,19 @@
 			type = "blob-ext";
 			optional;
 		};
+		};
 	};
-	itb_fs {
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
@@ -175,9 +190,11 @@
 		u_boot_spl_unsigned: u-boot-spl {
 			no-expanded;
 		};
+		};
 	};
-	sysfw_gp {
+	sysfw_gp: template-19 {
 		filename = "sysfw.bin_gp";
+		section {
 		ti-secure-rom {
 			content = <&ti_fs>;
 			core = "secure";
@@ -190,10 +207,12 @@
 			type = "blob-ext";
 			optional;
 		};
+		};
 	};
-	itb_gp {
+	itb_gp: template-20 {
 		filename = "sysfw-j721e-gp-evm.itb";
 		symlink = "sysfw.itb";
+		section {
 		insert-template = <&itb_unsigned_template>;
 
 		fit {
@@ -205,17 +224,11 @@
 				};
 			};
 		};
+		};
 	};
 };
-#endif
-
-#ifdef CONFIG_TARGET_J721E_A72_EVM
 
-#define SPL_J721E_EVM_DTB "spl/dts/k3-j721e-common-proc-board.dtb"
-#define SPL_J721E_SK_DTB "spl/dts/k3-j721e-sk.dtb"
-
-#define J721E_EVM_DTB "u-boot.dtb"
-#define J721E_SK_DTB "arch/arm/dts/k3-j721e-sk.dtb"
+#else
 
 &binman {
 	ti-dm {
@@ -224,7 +237,7 @@
 			filename = "ti-dm/j721e/ipc_echo_testb_mcu1_0_release_strip.xer5f";
 		};
 	};
-	ti-spl {
+	ti_spl: template-21 {
 		insert-template = <&ti_spl_template>;
 
 		fit {
@@ -354,128 +367,19 @@
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
-			};
-
-			configurations {
-				default = "conf-0";
-
-				conf-0 {
-					description = "k3-j721e-common-proc-board";
-					firmware = "atf";
-					loadables = "tee", "dm", "spl";
-					fdt = "fdt-0";
-				};
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
-		fit {
-
-			images {
-				uboot {
-					description = "U-Boot for J721E Board";
-				};
-
-				fdt-0 {
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
-			};
-
-			configurations {
-				default = "conf-0";
-
-				conf-0 {
-					description = "k3-j721e-common-proc-board";
-					firmware = "uboot";
-					loadables = "uboot";
-					fdt = "fdt-0";
-				};
-
-				conf-1 {
-					description = "k3-j721e-sk";
-					firmware = "uboot";
-					loadables = "uboot";
-					fdt = "fdt-1";
-				};
-			};
-		};
 	};
 };
 
 &binman {
-	ti-spl_unsigned {
+	ti_spl_unsigned: template-23 {
 		insert-template = <&ti_spl_unsigned_template>;
 
 		fit {
@@ -485,104 +389,14 @@
 						filename = "ti-dm.bin";
 					};
 				};
-
-				fdt-0 {
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
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					blob {
-						filename = SPL_J721E_SK_DTB;
-					};
-				};
-			};
-
-			configurations {
-				default = "conf-0";
-
-				conf-0 {
-					description = "k3-j721e-common-proc-board";
-					firmware = "atf";
-					loadables = "tee", "dm", "spl";
-					fdt = "fdt-0";
-				};
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
-
-		fit {
-			images {
-				uboot {
-					description = "U-Boot for J721E Board";
-				};
-
-				fdt-0 {
-					description = "k3-j721e-common-proc-board";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					blob {
-						filename = J721E_EVM_DTB;
-					};
-					hash {
-						algo = "crc32";
-					};
-				};
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
-			};
-
-			configurations {
-				default = "conf-0";
-
-				conf-0 {
-					description = "k3-j721e-common-proc-board";
-					firmware = "uboot";
-					loadables = "uboot";
-					fdt = "fdt-0";
-				};
-
-				conf-1 {
-					description = "k3-j721e-sk";
-					firmware = "uboot";
-					loadables = "uboot";
-					fdt = "fdt-1";
-				};
-			};
-		};
 	};
 };
 #endif
diff --git a/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi b/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
index 9433f3bafae..1db18044756 100644
--- a/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
@@ -3,6 +3,10 @@
  * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  */
 
+#define SPL_BOARD_DTB "spl/dts/k3-j721e-common-proc-board.dtb"
+#define BOARD_DESCRIPTION "k3-j721e-common-proc-board"
+#define UBOOT_BOARD_DESCRIPTION "U-Boot for J721E EVM"
+
 #include "k3-j721e-binman.dtsi"
 
 &cbass_main {
@@ -187,3 +191,83 @@
 &mcu_fss0_ospi1_pins_default {
 	bootph-all;
 };
+
+#ifndef CONFIG_ARM64
+
+&binman {
+	tiboot3-j721e-sr1-1-hs-evm {
+		insert-template = <&tiboot3_j721e_sr1_1_hs>;
+	};
+
+	sysfw-j721e-sr1-1-hs-evm {
+		insert-template = <&sysfw>;
+	};
+
+	itb-j721e-sr1-1-hs-evm {
+		insert-template = <&itb>;
+	};
+};
+
+&binman {
+	tiboot3-j721e-sr2-hs-evm {
+		insert-template = <&tiboot3_j721e_sr2_hs>;
+	};
+
+	sysfw-j721e-sr2-hs-evm {
+		insert-template = <&sysfw_sr2>;
+	};
+
+	itb-j721e-sr2-hs-evm {
+		insert-template = <&itb_sr2>;
+	};
+};
+
+&binman {
+	tiboot3-j721e-sr2-hs-fs-evm {
+		insert-template = <&tiboot3_j721e_sr2_hs_fs>;
+	};
+
+	sysfw-j721e-sr2-hs-fs-evm {
+		insert-template = <&sysfw_fs>;
+	};
+
+	itb-j721e-sr2-hs-fs-evm {
+		insert-template = <&itb_fs>;
+	};
+};
+
+&binman {
+	tiboot3-j721e-gp-evm {
+		insert-template = <&tiboot3_j721e_gp>;
+	};
+
+	sysfw-j721e-gp-evm {
+		insert-template = <&sysfw_gp>;
+	};
+
+	itb-j721e-gp-evm {
+		insert-template = <&itb_gp>;
+	};
+};
+
+#else
+
+&binman {
+	tispl {
+		insert-template = <&ti_spl>;
+	};
+
+	u-boot {
+		insert-template = <&u_boot>;
+	};
+
+	tispl-unsigned {
+		insert-template = <&ti_spl_unsigned>;
+	};
+
+	u-boot-unsigned {
+		insert-template = <&u_boot_unsigned>;
+	};
+};
+
+#endif
diff --git a/arch/arm/dts/k3-j721e-r5-beagleboneai64.dts b/arch/arm/dts/k3-j721e-r5-beagleboneai64.dts
index 43da4dafba8..c75f8aac302 100644
--- a/arch/arm/dts/k3-j721e-r5-beagleboneai64.dts
+++ b/arch/arm/dts/k3-j721e-r5-beagleboneai64.dts
@@ -95,91 +95,20 @@
 	bootph-pre-ram;
 };
 
+#ifndef CONFIG_ARM64
+
 &binman {
-	tiboot3-j721e-gp-evm.bin {
-		filename = "tiboot3-j721e-gp-evm.bin";
-		symlink = "tiboot3.bin";
-		ti-secure-rom {
-			content = <&u_boot_spl_unsigned>;
-			core = "public";
-			load = <CONFIG_SPL_TEXT_BASE>;
-			sw-rev = <CONFIG_K3_X509_SWRV>;
-			keyfile = "ti-degenerate-key.pem";
-		};
-		u_boot_spl_unsigned: u-boot-spl {
-			no-expanded;
-		};
+	tiboot3-j721e-beagleboneai64 {
+		insert-template = <&tiboot3_j721e_gp>;
 	};
 
-	sysfw_gp {
-		filename = "sysfw.bin_gp";
-		ti-secure-rom {
-			content = <&ti_fs>;
-			core = "secure";
-			load = <0x40000>;
-			sw-rev = <CONFIG_K3_X509_SWRV>;
-			keyfile = "ti-degenerate-key.pem";
-		};
-		ti_fs: ti-fs.bin {
-			filename = "ti-sysfw/ti-fs-firmware-j721e-gp.bin";
-			type = "blob-ext";
-			optional;
-		};
+	sysfw-j721e-beagleboneai64 {
+		insert-template = <&sysfw_gp>;
 	};
 
-	itb_gp {
-		filename = "sysfw-j721e-gp-evm.itb";
-		symlink = "sysfw.itb";
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
-					    filename = "sysfw.bin_gp";
-					};
-				};
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
-			};
-		};
+	itb-j721e-beagleboneai64 {
+		insert-template = <&itb_gp>;
 	};
 };
+
+#endif
diff --git a/arch/arm/dts/k3-j721e-sk-u-boot.dtsi b/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
index 8b205553cdf..644a11005ed 100644
--- a/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
@@ -3,6 +3,10 @@
  * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
  */
 
+#define SPL_BOARD_DTB "spl/dts/k3-j721e-sk.dtb"
+#define BOARD_DESCRIPTION "k3-j721e-sk"
+#define UBOOT_BOARD_DESCRIPTION "U-Boot for J721E SK"
+
 #include "k3-j721e-binman.dtsi"
 
 &cbass_main {
@@ -159,3 +163,83 @@
 		bootph-all;
 	};
 };
+
+#ifndef CONFIG_ARM64
+
+&binman {
+	tiboot3-j721e-sr1-1-sk {
+		insert-template = <&tiboot3_j721e_sr1_1_hs>;
+	};
+
+	sysfw-j721e-sr1-1-hs-sk {
+		insert-template = <&sysfw>;
+	};
+
+	itb-j721e-sr1-1-hs-sk {
+		insert-template = <&itb>;
+	};
+};
+
+&binman {
+	tiboot3-j721e-sr2-hs-sk {
+		insert-template = <&tiboot3_j721e_sr2_hs>;
+	};
+
+	sysfw-j721e-sr2-hs-sk {
+		insert-template = <&sysfw_sr2>;
+	};
+
+	itb-j721e-sr2-hs-sk {
+		insert-template = <&itb_sr2>;
+	};
+};
+
+&binman {
+	tiboot3-j721e-sr2-hs-fs-sk {
+		insert-template = <&tiboot3_j721e_sr2_hs_fs>;
+	};
+
+	sysfw-j721e-sr2-hs-fs-sk {
+		insert-template = <&sysfw_fs>;
+	};
+
+	itb-j721e-sr2-hs-fs-sk {
+		insert-template = <&itb_fs>;
+	};
+};
+
+&binman {
+	tiboot3-j721e-gp-sk {
+		insert-template = <&tiboot3_j721e_gp>;
+	};
+
+	sysfw-j721e-gp-sk {
+		insert-template = <&sysfw_gp>;
+	};
+
+	itb-j721e-gp-sk {
+		insert-template = <&itb_gp>;
+	};
+};
+
+#else
+
+&binman {
+	tispl {
+		insert-template = <&ti_spl>;
+	};
+
+	u-boot {
+		insert-template = <&u_boot>;
+	};
+
+	tispl-unsigned {
+		insert-template = <&ti_spl_unsigned>;
+	};
+
+	u-boot-unsigned {
+		insert-template = <&u_boot_unsigned>;
+	};
+};
+
+#endif
diff --git a/arch/arm/dts/k3-j721s2-binman.dtsi b/arch/arm/dts/k3-j721s2-binman.dtsi
index 7efb135bdff..57521f2d356 100644
--- a/arch/arm/dts/k3-j721s2-binman.dtsi
+++ b/arch/arm/dts/k3-j721s2-binman.dtsi
@@ -5,11 +5,12 @@
 
 #include "k3-binman.dtsi"
 
-#ifdef CONFIG_TARGET_J721S2_R5_EVM
+#ifndef CONFIG_ARM64
 
 &binman {
-	tiboot3-j721s2-hs-evm.bin {
+	tiboot3_j721s2_hs_evm: template-9 {
 		filename = "tiboot3-j721s2-hs-evm.bin";
+		section {
 		ti-secure-rom {
 			content = <&u_boot_spl>, <&ti_fs_enc>, <&combined_tifs_cfg>,
 				<&combined_dm_cfg>, <&sysfw_inner_cert>;
@@ -49,12 +50,14 @@
 			filename = "combined-dm-cfg.bin";
 			type = "blob-ext";
 		};
+		};
 	};
 };
 
 &binman {
-	tiboot3-j721s2-hs-fs-evm.bin {
+	tiboot3_j721s2_hs_fs_evm: template-10 {
 		filename = "tiboot3-j721s2-hs-fs-evm.bin";
+		section {
 		ti-secure-rom {
 			content = <&u_boot_spl_fs>, <&ti_fs_enc_fs>, <&combined_tifs_cfg_fs>,
 				<&combined_dm_cfg_fs>, <&sysfw_inner_cert_fs>;
@@ -94,13 +97,15 @@
 			filename = "combined-dm-cfg.bin";
 			type = "blob-ext";
 		};
+		};
 	};
 };
 
 &binman {
-	tiboot3-j721s2-gp-evm.bin {
+	tiboot3_j721s2_gp_evm: template-11 {
 		filename = "tiboot3-j721s2-gp-evm.bin";
 		symlink = "tiboot3.bin";
+		section {
 		ti-secure-rom {
 			content = <&u_boot_spl_unsigned>, <&ti_fs_gp>,
 				<&combined_tifs_cfg_gp>, <&combined_dm_cfg_gp>;
@@ -133,19 +138,11 @@
 			filename = "combined-dm-cfg.bin";
 			type = "blob-ext";
 		};
-
+		};
 	};
 };
 
-#endif
-
-#ifdef CONFIG_TARGET_J721S2_A72_EVM
-
-#define SPL_J721S2_EVM_DTB "spl/dts/k3-j721s2-common-proc-board.dtb"
-#define SPL_AM68_SK_DTB "spl/dts/k3-am68-sk-base-board.dtb"
-
-#define J721S2_EVM_DTB "u-boot.dtb"
-#define AM68_SK_DTB "arch/arm/dts/k3-am68-sk-base-board.dtb"
+#else
 
 &binman {
 	ti-dm {
@@ -154,7 +151,7 @@
 			filename = "ti-dm/j721s2/ipc_echo_testb_mcu1_0_release_strip.xer5f";
 		};
 	};
-	ti-spl {
+	ti_spl: template-12 {
 		insert-template = <&ti_spl_template>;
 
 		fit {
@@ -291,129 +288,19 @@
 						filename = "ti-dm.bin";
 					};
 				};
-
-				fdt-0 {
-					description = "k3-j721s2-common-proc-board";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					ti-secure {
-						content = <&spl_j721s2_evm_dtb>;
-						keyfile = "custMpk.pem";
-					};
-					spl_j721s2_evm_dtb: blob-ext {
-						filename = SPL_J721S2_EVM_DTB;
-					};
-
-				};
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
-			};
-
-			configurations {
-				default = "conf-0";
-
-				conf-0 {
-					description = "k3-j721s2-common-proc-board";
-					firmware = "atf";
-					loadables = "tee", "dm", "spl";
-					fdt = "fdt-0";
-				};
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
 };
 
 &binman {
-	u-boot {
+	u_boot: template-13 {
 		insert-template = <&u_boot_template>;
-
-		fit {
-			images {
-				uboot {
-					description = "U-Boot for J721S2 Board";
-				};
-
-				fdt-0 {
-					description = "k3-j721s2-common-proc-board";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					ti-secure {
-						content = <&j721s2_evm_dtb>;
-						keyfile = "custMpk.pem";
-					};
-					j721s2_evm_dtb: blob-ext {
-						filename = J721S2_EVM_DTB;
-					};
-
-					hash {
-						algo = "crc32";
-					};
-				};
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
-			};
-
-			configurations {
-				default = "conf-0";
-
-				conf-0 {
-					description = "k3-j721s2-common-proc-board";
-					firmware = "uboot";
-					loadables = "uboot";
-					fdt = "fdt-0";
-				};
-				conf-1 {
-					description = "k3-am68-sk-base-board";
-					firmware = "uboot";
-					loadables = "uboot";
-					fdt = "fdt-1";
-				};
-
-			};
-		};
 	};
 };
 
 &binman {
-	ti-spl_unsigned {
+	ti_spl_unsigned: template-14 {
 		insert-template = <&ti_spl_unsigned_template>;
 
 		fit {
@@ -423,102 +310,14 @@
 						filename = "ti-dm.bin";
 					};
 				};
-
-				fdt-0 {
-					description = "k3-j721s2-common-proc-board";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					blob {
-						filename = SPL_J721S2_EVM_DTB;
-					};
-				};
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
-			};
-
-			configurations {
-				default = "conf-0";
-
-				conf-0 {
-					description = "k3-j721s2-common-proc-board";
-					firmware = "atf";
-					loadables = "tee", "dm", "spl";
-					fdt = "fdt-0";
-				};
-				conf-1 {
-					description = "k3-am68-sk-base-board";
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
+	u_boot_unsigned: template-15 {
 		insert-template = <&u_boot_unsigned_template>;
-
-		fit {
-			images {
-				uboot {
-					description = "U-Boot for J721S2 Board";
-				};
-
-				fdt-0 {
-					description = "k3-j721s2-common-proc-board";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					blob {
-						filename = J721S2_EVM_DTB;
-					};
-					hash {
-						algo = "crc32";
-					};
-				};
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
-			};
-
-			configurations {
-				default = "conf-0";
-
-				conf-0 {
-					description = "k3-j721s2-common-proc-board";
-					firmware = "uboot";
-					loadables = "uboot";
-					fdt = "fdt-0";
-				};
-				conf-1 {
-					description = "k3-am68-sk-base-board";
-					firmware = "uboot";
-					loadables = "uboot";
-					fdt = "fdt-1";
-				};
-			};
-		};
 	};
 };
 #endif
diff --git a/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi b/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
index a3ebf5996ea..4ef8f54b87e 100644
--- a/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
@@ -3,6 +3,10 @@
  * Copyright (C) 2021-2023 Texas Instruments Incorporated - https://www.ti.com/
  */
 
+#define SPL_BOARD_DTB "spl/dts/k3-j721s2-common-proc-board.dtb"
+#define BOARD_DESCRIPTION "k3-j721s2-common-proc-board"
+#define UBOOT_BOARD_DESCRIPTION "U-Boot for J721S2 EVM"
+
 #include "k3-j721s2-binman.dtsi"
 
 &wkup_i2c0 {
@@ -125,3 +129,41 @@
 	dr_mode = "peripheral";
 	bootph-all;
 };
+
+#ifndef CONFIG_ARM64
+
+&binman {
+	tiboot3-j721s2-hs-evm {
+		insert-template = <&tiboot3_j721s2_hs_evm>;
+	};
+
+	tiboot3-j721s2-hs-fs-evm {
+		insert-template = <&tiboot3_j721s2_hs_fs_evm>;
+	};
+
+	tiboot3-j721s2-gp-evm {
+		insert-template = <&tiboot3_j721s2_gp_evm>;
+	};
+};
+
+#else
+
+&binman {
+	tispl {
+		insert-template = <&ti_spl>;
+	};
+
+	u-boot {
+		insert-template = <&u_boot>;
+	};
+
+	tispl-unsigned {
+		insert-template = <&ti_spl_unsigned>;
+	};
+
+	u-boot-unsigned {
+		insert-template = <&u_boot_unsigned>;
+	};
+};
+
+#endif
diff --git a/arch/arm/dts/k3-j784s4-binman.dtsi b/arch/arm/dts/k3-j784s4-binman.dtsi
index e4dd6e14a66..afe9829e62f 100644
--- a/arch/arm/dts/k3-j784s4-binman.dtsi
+++ b/arch/arm/dts/k3-j784s4-binman.dtsi
@@ -5,16 +5,16 @@
 
 #include "k3-binman.dtsi"
 
-#ifdef CONFIG_TARGET_J784S4_R5_EVM
+#ifndef CONFIG_ARM64
 
 &rcfg_yaml_tifs {
 	config = "tifs-rm-cfg.yaml";
 };
 
 &binman {
-	tiboot3-j784s4-hs-evm.bin {
+	tiboot3_j784s4_hs_evm: template-9 {
 		filename = "tiboot3-j784s4-hs-evm.bin";
-
+		section {
 		ti-secure-rom {
 			content = <&u_boot_spl>, <&ti_fs_enc>, <&combined_tifs_cfg>,
 				<&combined_dm_cfg>, <&sysfw_inner_cert>;
@@ -59,13 +59,14 @@
 			filename = "combined-dm-cfg.bin";
 			type = "blob-ext";
 		};
+		};
 	};
 };
 
 &binman {
-	tiboot3-j784s4-hs-fs-evm.bin {
+	tiboot3_j784s4_hs_fs_evm: template-10 {
 		filename = "tiboot3-j784s4-hs-fs-evm.bin";
-
+		section {
 		ti-secure-rom {
 			content = <&u_boot_spl_fs>, <&ti_fs_enc_fs>, <&combined_tifs_cfg_fs>,
 				<&combined_dm_cfg_fs>, <&sysfw_inner_cert_fs>;
@@ -110,14 +111,15 @@
 			filename = "combined-dm-cfg.bin";
 			type = "blob-ext";
 		};
+		};
 	};
 };
 
 &binman {
-	tiboot3-j784s4-gp-evm.bin {
+	tiboot3_j784s4_gp_evm: template-11 {
 		filename = "tiboot3-j784s4-gp-evm.bin";
 		symlink = "tiboot3.bin";
-
+		section {
 		ti-secure-rom {
 			content = <&u_boot_spl_unsigned>, <&ti_fs_gp>,
 				<&combined_tifs_cfg_gp>, <&combined_dm_cfg_gp>;
@@ -154,15 +156,11 @@
 			filename = "combined-dm-cfg.bin";
 			type = "blob-ext";
 		};
-
+		};
 	};
 };
-#endif
-
-#ifdef CONFIG_TARGET_J784S4_A72_EVM
 
-#define SPL_J784S4_EVM_DTB "spl/dts/ti/k3-j784s4-evm.dtb"
-#define J784S4_EVM_DTB "u-boot.dtb"
+#else
 
 &binman {
 	ti-dm {
@@ -173,7 +171,7 @@
 		};
 	};
 
-	ti-spl {
+	ti_spl: template-12 {
 		insert-template = <&ti_spl_template>;
 
 		fit {
@@ -188,85 +186,19 @@
 						filename = "ti-dm.bin";
 					};
 				};
-
-				fdt-0 {
-					description = "k3-j784s4-evm";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-
-					ti-secure {
-						content = <&spl_j784s4_evm_dtb>;
-						keyfile = "custMpk.pem";
-					};
-
-					spl_j784s4_evm_dtb: blob-ext {
-						filename = SPL_J784S4_EVM_DTB;
-					};
-				};
-			};
-
-			configurations {
-				default = "conf-0";
-
-				conf-0 {
-					description = "k3-j784s4-evm";
-					firmware = "atf";
-					loadables = "tee", "dm", "spl";
-					fdt = "fdt-0";
-				};
 			};
 		};
 	};
 };
 
 &binman {
-	u-boot {
+	u_boot: template-13 {
 		insert-template = <&u_boot_template>;
-
-		fit {
-			images {
-				uboot {
-					description = "U-Boot for J784S4 board";
-				};
-
-				fdt-0 {
-					description = "k3-j784s4-evm";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-
-					ti-secure {
-						content = <&j784s4_evm_dtb>;
-						keyfile = "custMpk.pem";
-					};
-
-					j784s4_evm_dtb: blob-ext {
-						filename = J784S4_EVM_DTB;
-					};
-
-					hash {
-						algo = "crc32";
-					};
-				};
-			};
-
-			configurations {
-				default = "conf-0";
-
-				conf-0 {
-					description = "k3-j784s4-evm";
-					firmware = "uboot";
-					loadables = "uboot";
-					fdt = "fdt-0";
-				};
-			};
-		};
 	};
 };
 
 &binman {
-	ti-spl_unsigned {
+	ti_spl_unsigned: template-14 {
 		insert-template = <&ti_spl_unsigned_template>;
 
 		fit {
@@ -276,70 +208,14 @@
 						filename = "ti-dm.bin";
 					};
 				};
-
-				fdt-0 {
-					description = "k3-j784s4-evm";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-
-					spl_j784s4_evm_dtb_unsigned: blob {
-						filename = SPL_J784S4_EVM_DTB;
-					};
-				};
-			};
-
-			configurations {
-				default = "conf-0";
-
-				conf-0 {
-					description = "k3-j784s4-evm";
-					firmware = "atf";
-					loadables = "tee", "dm", "spl";
-					fdt = "fdt-0";
-				};
 			};
 		};
 	};
 };
 
 &binman {
-	u-boot_unsigned {
+	u_boot_unsigned: template-15 {
 		insert-template = <&u_boot_unsigned_template>;
-
-		fit {
-			images {
-				uboot {
-					description = "U-Boot for J784S4 board";
-				};
-
-				fdt-0 {
-					description = "k3-j784s4-evm";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-
-					j784s4_evm_dtb_unsigned: blob {
-						filename = J784S4_EVM_DTB;
-					};
-
-					hash {
-						algo = "crc32";
-					};
-				};
-			};
-
-			configurations {
-				default = "conf-0";
-
-				conf-0 {
-					description = "k3-j784s4-evm";
-					firmware = "uboot";
-					loadables = "uboot";
-					fdt = "fdt-0";
-				};
-			};
-		};
 	};
 };
 #endif
diff --git a/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi b/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
index ac749782bfc..e5e5a6c75be 100644
--- a/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
+++ b/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
@@ -3,6 +3,10 @@
  * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
  */
 
+#define SPL_BOARD_DTB "spl/dts/ti/k3-j784s4-evm.dtb"
+#define BOARD_DESCRIPTION "k3-j784s4-evm"
+#define UBOOT_BOARD_DESCRIPTION "U-Boot for J784S4 EVM"
+
 #include "k3-j784s4-binman.dtsi"
 
 / {
@@ -29,3 +33,41 @@
 		bootph-pre-ram;
 	};
 };
+
+#ifndef CONFIG_ARM64
+
+&binman {
+	tiboot3-j784s4-hs-evm {
+		insert-template = <&tiboot3_j784s4_hs_evm>;
+	};
+
+	tiboot3-j784s4-hs-fs-evm {
+		insert-template = <&tiboot3_j784s4_hs_fs_evm>;
+	};
+
+	tiboot3-j784s4-gp-evm {
+		insert-template = <&tiboot3_j784s4_gp_evm>;
+	};
+};
+
+#else
+
+&binman {
+	tispl {
+		insert-template = <&ti_spl>;
+	};
+
+	u-boot {
+		insert-template = <&u_boot>;
+	};
+
+	tispl-unsigned {
+		insert-template = <&ti_spl_unsigned>;
+	};
+
+	u-boot-unsigned {
+		insert-template = <&u_boot_unsigned>;
+	};
+};
+
+#endif
-- 
2.34.1

