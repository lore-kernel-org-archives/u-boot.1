Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8765CC4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 21:41:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F14AF88A79;
	Mon, 22 Apr 2024 23:41:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RTJHuV/6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B9E388A77; Mon, 22 Apr 2024 23:41:01 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C24AD88A6C
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 23:40:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43MLeunP038939;
 Mon, 22 Apr 2024 16:40:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1713822056;
 bh=fQ1fiEgknnshP4TqbrXX0HNB98/rR3smply9He16CUk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=RTJHuV/6oGmrPw52PPKeohUBPUfD89HrVLTQ7Z9fajP7PA8OeCS90Fn97fJEtZYpr
 /tRMjhYDVcl4UmzwNeDGn+ZL92bSSqtmsZS/bEW/ijKCnkwKtoaBwVz72JC3v8Cdnj
 UQMmLD/r9AV5F/LCYz9PEcXOln7fb50NV6vp5MD0=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43MLeuWq049930
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 22 Apr 2024 16:40:56 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 22
 Apr 2024 16:40:56 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 22 Apr 2024 16:40:56 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43MLenlC051404;
 Mon, 22 Apr 2024 16:40:53 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <sjg@chromium.org>
CC: <afd@ti.com>, <kamlesh@ti.com>, <m-chawdhry@ti.com>, <u-kumar1@ti.com>,
 <n-francis@ti.com>, <bsheraw@ti.com>, <s-anna@ti.com>, <a-limaye@ti.com>
Subject: [PATCH 1/2] arm: dts: k3-j721e-binman: Add support for HSSE2.0 and
 HSFS1.1
Date: Tue, 23 Apr 2024 03:10:47 +0530
Message-ID: <20240422214048.1292713-2-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422214048.1292713-1-n-francis@ti.com>
References: <20240422214048.1292713-1-n-francis@ti.com>
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

J721E has SR1.1 and SR2.0 having three variants of each GP, HS-FS and
HS-SE. Current build does not generate HS-SE SR2.0 and HS-FS SR1.1 so
add support for them.

Reported-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 arch/arm/dts/k3-j721e-binman.dtsi | 201 +++++++++++++++++++++++++++++-
 1 file changed, 200 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/k3-j721e-binman.dtsi b/arch/arm/dts/k3-j721e-binman.dtsi
index 75a6e9599b9..90e4a31329e 100644
--- a/arch/arm/dts/k3-j721e-binman.dtsi
+++ b/arch/arm/dts/k3-j721e-binman.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include "k3-binman.dtsi"
@@ -129,6 +129,205 @@
 	};
 };
 
+&binman {
+	tiboot3-j721e_sr2-hs-evm.bin {
+		filename = "tiboot3-j721e_sr2-hs-evm.bin";
+		ti-secure-rom {
+			content = <&u_boot_spl_sr2>;
+			core = "public";
+			core-opts = <2>;
+			load = <CONFIG_SPL_TEXT_BASE>;
+			keyfile = "custMpk.pem";
+		};
+		u_boot_spl_sr2: u-boot-spl {
+			no-expanded;
+		};
+	};
+	sysfw_sr2 {
+		filename = "sysfw.bin_sr2";
+		ti-secure-rom {
+			content = <&ti_fs_cert_sr2>;
+			core = "secure";
+			load = <0x40000>;
+			keyfile = "custMpk.pem";
+			countersign;
+		};
+		ti_fs_cert_sr2: ti-fs-cert.bin {
+			filename = "ti-sysfw/ti-fs-firmware-j721e_sr2-hs-cert.bin";
+			type = "blob-ext";
+			optional;
+		};
+		ti-fs-firmware-j721e_sr2-hs-enc.bin {
+			filename = "ti-sysfw/ti-fs-firmware-j721e_sr2-hs-enc.bin";
+			type = "blob-ext";
+			optional;
+		};
+	};
+	itb_sr2 {
+		filename = "sysfw-j721e_sr2-hs-evm.itb";
+		fit {
+			description = "SYSFW and Config fragments";
+			#address-cells = <1>;
+			images {
+				sysfw.bin {
+					description = "sysfw";
+					type = "firmware";
+					arch = "arm";
+					compression = "none";
+					blob-ext {
+					    filename = "sysfw.bin_sr2";
+					};
+				};
+				board-cfg.bin {
+					description = "board-cfg";
+					type = "firmware";
+					arch = "arm";
+					compression = "none";
+					ti-secure {
+						content = <&board_cfg_sr2>;
+						keyfile = "custMpk.pem";
+					};
+					board_cfg_sr2: board-cfg {
+						filename = "board-cfg.bin";
+						type = "blob-ext";
+					};
+
+				};
+				pm-cfg.bin {
+					description = "pm-cfg";
+					type = "firmware";
+					arch = "arm";
+					compression = "none";
+					ti-secure {
+						content = <&pm_cfg_sr2>;
+						keyfile = "custMpk.pem";
+					};
+					pm_cfg_sr2: pm-cfg {
+						filename = "pm-cfg.bin";
+						type = "blob-ext";
+					};
+				};
+				rm-cfg.bin {
+					description = "rm-cfg";
+					type = "firmware";
+					arch = "arm";
+					compression = "none";
+					ti-secure {
+						content = <&rm_cfg_sr2>;
+						keyfile = "custMpk.pem";
+					};
+					rm_cfg_sr2: rm-cfg {
+						filename = "rm-cfg.bin";
+						type = "blob-ext";
+					};
+				};
+				sec-cfg.bin {
+					description = "sec-cfg";
+					type = "firmware";
+					arch = "arm";
+					compression = "none";
+					ti-secure {
+						content = <&sec_cfg_sr2>;
+						keyfile = "custMpk.pem";
+					};
+					sec_cfg_sr2: sec-cfg {
+						filename = "sec-cfg.bin";
+						type = "blob-ext";
+					};
+				};
+			};
+		};
+	};
+};
+
+&binman {
+	tiboot3-j721e_sr1_1-hs-fs-evm.bin {
+		filename = "tiboot3-j721e_sr1_1-hs-fs-evm.bin";
+		ti-secure-rom {
+			content = <&u_boot_spl_fs_sr1_1>;
+			core = "public";
+			core-opts = <2>;
+			load = <CONFIG_SPL_TEXT_BASE>;
+			keyfile = "custMpk.pem";
+		};
+		u_boot_spl_fs_sr1_1: u-boot-spl {
+			no-expanded;
+		};
+	};
+	sysfw_fs_sr1_1 {
+		filename = "sysfw.bin_fs_sr1_1";
+		ti-fs-cert-fs.bin {
+			filename = "ti-sysfw/ti-fs-firmware-j721e_sr1_1-hs-fs-cert.bin";
+			type = "blob-ext";
+			optional;
+		};
+		ti-fs-firmware-j721e-hs-fs-enc.bin {
+			filename = "ti-sysfw/ti-fs-firmware-j721e_sr1_1-hs-fs-enc.bin";
+			type = "blob-ext";
+			optional;
+		};
+	};
+	itb_fs_sr1_1 {
+		filename = "sysfw-j721e_sr1_1-hs-fs-evm.itb";
+		fit {
+			description = "SYSFW and Config fragments";
+			#address-cells = <1>;
+			images {
+				sysfw.bin {
+					description = "sysfw";
+					type = "firmware";
+					arch = "arm";
+					compression = "none";
+					blob-ext {
+					    filename = "sysfw.bin_fs_sr1_1";
+					};
+				};
+				board-cfg.bin {
+					description = "board-cfg";
+					type = "firmware";
+					arch = "arm";
+					compression = "none";
+					board-cfg {
+						filename = "board-cfg.bin";
+						type = "blob-ext";
+					};
+
+				};
+				pm-cfg.bin {
+					description = "pm-cfg";
+					type = "firmware";
+					arch = "arm";
+					compression = "none";
+					pm-cfg {
+						filename = "pm-cfg.bin";
+						type = "blob-ext";
+					};
+				};
+				rm-cfg.bin {
+					description = "rm-cfg";
+					type = "firmware";
+					arch = "arm";
+					compression = "none";
+					rm-cfg {
+						filename = "rm-cfg.bin";
+						type = "blob-ext";
+					};
+				};
+				sec-cfg.bin {
+					description = "sec-cfg";
+					type = "firmware";
+					arch = "arm";
+					compression = "none";
+					sec-cfg {
+						filename = "sec-cfg.bin";
+						type = "blob-ext";
+					};
+				};
+			};
+		};
+	};
+};
+
 &binman {
 	tiboot3-j721e_sr2-hs-fs-evm.bin {
 		filename = "tiboot3-j721e_sr2-hs-fs-evm.bin";
-- 
2.34.1

