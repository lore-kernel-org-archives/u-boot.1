Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6DCC4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 08:03:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79ED48744E;
	Sat,  4 Nov 2023 09:02:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WqzrZCyJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7F23870EF; Sat,  4 Nov 2023 09:02:08 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70B5B8718A
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 09:01:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A481gdb006000;
 Sat, 4 Nov 2023 03:01:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699084902;
 bh=/2cBV/gdYYyPFG25zh8ZaPkoeOz4KKi4pMIyqXn2iEk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=WqzrZCyJlDynwnIaQHAAAGer1tYU4PiMFhbPEsLR25gy2KWqD3TATLeSqfYLJXP+C
 7/EQfKEBw6VWQWWtClXnbO5kM5y1hDcySeyRCrIqPqp9qhTZUgEDlUTNE8heDQptu1
 TrU9YMt39fv5haYjoHALyx47ddg5cBf0QoC/mPjE=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A481ggJ051492
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 4 Nov 2023 03:01:42 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 4
 Nov 2023 03:01:41 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 4 Nov 2023 03:01:41 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A481fNt097898;
 Sat, 4 Nov 2023 03:01:42 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Sinthu Raja <sinthu.raja@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Simon Glass <sjg@chromium.org>, Robert Nelson <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, Nishanth Menon <nm@ti.com>,
 <u-boot@lists.denx.de>, <bb@ti.com>, <praneeth@ti.com>
Subject: [PATCH 1/5] arm: dts: k3-am625-beagleplay-u-boot/r5: Just depend on
 k3-binman.dtsi
Date: Sat, 4 Nov 2023 03:01:33 -0500
Message-ID: <20231104080137.9628-2-nm@ti.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20231104080137.9628-1-nm@ti.com>
References: <20231104080137.9628-1-nm@ti.com>
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

With the upcoming folder separation, there is no further need to depend
on am625-binman.dtsi. Duplicate the existing definitions to u-boot.dtsi
and r5.dts as appropriate.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi | 160 +++++++++++++++++--
 arch/arm/dts/k3-am625-r5-beagleplay.dts      |  39 +++++
 2 files changed, 184 insertions(+), 15 deletions(-)

diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
index d6c6baa5518b..10bdaa194462 100644
--- a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
@@ -6,7 +6,7 @@
  * Copyright (C) 2022-2023 Robert Nelson, BeagleBoard.org Foundation
  */
 
-#include "k3-am625-sk-binman.dtsi"
+#include "k3-binman.dtsi"
 
 / {
 	chosen {
@@ -171,25 +171,155 @@
 	bootph-all;
 };
 
-#ifdef CONFIG_TARGET_AM625_A53_EVM
+#ifdef CONFIG_TARGET_AM625_A53_BEAGLEPLAY
 
+#define SPL_NODTB "spl/u-boot-spl-nodtb.bin"
 #define SPL_AM625_BEAGLEPLAY_DTB "spl/dts/k3-am625-beagleplay.dtb"
+#define UBOOT_NODTB "u-boot-nodtb.bin"
 #define AM625_BEAGLEPLAY_DTB "arch/arm/dts/k3-am625-beagleplay.dtb"
 
-&spl_am625_sk_dtb {
-	filename = SPL_AM625_BEAGLEPLAY_DTB;
-};
-
-&am625_sk_dtb {
-	filename = AM625_BEAGLEPLAY_DTB;
-};
+&binman {
+	ti-dm {
+		filename = "ti-dm.bin";
+		blob-ext {
+			filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+		};
+	};
 
-&spl_am625_sk_dtb_unsigned {
-	filename = SPL_AM625_BEAGLEPLAY_DTB;
-};
+	ti-spl_unsigned {
+		filename = "tispl.bin_unsigned";
+		pad-byte = <0xff>;
+
+		fit {
+			description = "Configuration to load ATF and SPL";
+			#address-cells = <1>;
+
+			images {
+
+				atf {
+					description = "ARM Trusted Firmware";
+					type = "firmware";
+					arch = "arm64";
+					compression = "none";
+					os = "arm-trusted-firmware";
+					load = <CONFIG_K3_ATF_LOAD_ADDR>;
+					entry = <CONFIG_K3_ATF_LOAD_ADDR>;
+					atf-bl31 {
+						filename = "bl31.bin";
+					};
+				};
+
+				tee {
+					description = "OP-TEE";
+					type = "tee";
+					arch = "arm64";
+					compression = "none";
+					os = "tee";
+					load = <0x9e800000>;
+					entry = <0x9e800000>;
+					tee-os {
+						filename = "tee-raw.bin";
+					};
+				};
+
+				dm {
+					description = "DM binary";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "DM";
+					load = <0x89000000>;
+					entry = <0x89000000>;
+					blob-ext {
+						filename = "ti-dm.bin";
+					};
+				};
+
+				spl {
+					description = "SPL (64-bit)";
+					type = "standalone";
+					os = "U-Boot";
+					arch = "arm64";
+					compression = "none";
+					load = <CONFIG_SPL_TEXT_BASE>;
+					entry = <CONFIG_SPL_TEXT_BASE>;
+					blob {
+						filename = "spl/u-boot-spl-nodtb.bin";
+					};
+				};
+
+				fdt-0 {
+					description = "k3-am625-beagleplay";
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
+					spl_am625_bp_dtb_unsigned: blob {
+						filename = SPL_AM625_BEAGLEPLAY_DTB;
+					};
+				};
+			};
+
+			configurations {
+				default = "conf-0";
+
+				conf-0 {
+					description = "k3-am625-beagleplay";
+					firmware = "atf";
+					loadables = "tee", "dm", "spl";
+					fdt = "fdt-0";
+				};
+			};
+		};
+	};
 
-&am625_sk_dtb_unsigned {
-	filename = AM625_BEAGLEPLAY_DTB;
+	u-boot_unsigned {
+		filename = "u-boot.img_unsigned";
+		pad-byte = <0xff>;
+
+		fit {
+			description = "FIT image with multiple configurations";
+
+			images {
+				uboot {
+					description = "U-Boot for AM625 board";
+					type = "firmware";
+					os = "u-boot";
+					arch = "arm";
+					compression = "none";
+					load = <CONFIG_TEXT_BASE>;
+					blob {
+						filename = UBOOT_NODTB;
+					};
+					hash {
+						algo = "crc32";
+					};
+				};
+
+				fdt-0 {
+					description = "k3-am625-beagleplay";
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
+					am625_bp_dtb_unsigned: blob {
+						filename = AM625_BEAGLEPLAY_DTB;
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
+					description = "k3-am625-beagleplay";
+					firmware = "uboot";
+					loadables = "uboot";
+					fdt = "fdt-0";
+				};
+			};
+		};
+	};
 };
-
 #endif
diff --git a/arch/arm/dts/k3-am625-r5-beagleplay.dts b/arch/arm/dts/k3-am625-r5-beagleplay.dts
index 9c9d0570592a..864ed54bdaa2 100644
--- a/arch/arm/dts/k3-am625-r5-beagleplay.dts
+++ b/arch/arm/dts/k3-am625-r5-beagleplay.dts
@@ -84,3 +84,42 @@
 &main_bcdma {
 	ti,sci = <&dm_tifs>;
 };
+
+&binman {
+	tiboot3-am62x-gp-evm.bin {
+		filename = "tiboot3-am62x-gp-evm.bin";
+		ti-secure-rom {
+			content = <&u_boot_spl_unsigned>, <&ti_fs_gp>,
+				<&combined_tifs_cfg_gp>, <&combined_dm_cfg_gp>;
+			combined;
+			dm-data;
+			content-sbl = <&u_boot_spl_unsigned>;
+			load = <0x43c00000>;
+			content-sysfw = <&ti_fs_gp>;
+			load-sysfw = <0x40000>;
+			content-sysfw-data = <&combined_tifs_cfg_gp>;
+			load-sysfw-data = <0x67000>;
+			content-dm-data = <&combined_dm_cfg_gp>;
+			load-dm-data = <0x43c3a800>;
+			sw-rev = <1>;
+			keyfile = "ti-degenerate-key.pem";
+		};
+		u_boot_spl_unsigned: u-boot-spl {
+			no-expanded;
+		};
+		ti_fs_gp: ti-fs-gp.bin {
+			filename = "ti-sysfw/ti-fs-firmware-am62x-gp.bin";
+			type = "blob-ext";
+			optional;
+		};
+		combined_tifs_cfg_gp: combined-tifs-cfg-gp.bin {
+			filename = "combined-tifs-cfg.bin";
+			type = "blob-ext";
+		};
+		combined_dm_cfg_gp: combined-dm-cfg-gp.bin {
+			filename = "combined-dm-cfg.bin";
+			type = "blob-ext";
+		};
+
+	};
+};
-- 
2.37.2

