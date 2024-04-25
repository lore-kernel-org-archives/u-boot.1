Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5010C4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 22:07:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6C018906E;
	Fri, 26 Apr 2024 00:07:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="h8+FBeGA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34F198901A; Fri, 26 Apr 2024 00:07:15 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC0A7885A0
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 00:07:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43PM7Ag5091116;
 Thu, 25 Apr 2024 17:07:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1714082830;
 bh=kghsIhZJRX0j3k76h+zjmt07Pv8A6xiwt1iLSyX4acg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=h8+FBeGAb8RiwqFHUYXlt5O6k3CtHeMnegamU/8NbyVAl/FE4wDDJsJ6SEgkVHDxX
 XzPX48ndMfpgAaqgMKNJV6jqiID6hDteRFgZUnxhAPMdbcXjjbcqzgAhaU7lZegyEE
 K6lKni+WdhtBopyQt39bFjduWX9ZowFcXQ9Gc6TE=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43PM7ATp007065
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 25 Apr 2024 17:07:10 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Apr 2024 17:07:10 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Apr 2024 17:07:10 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43PM6xPb047679;
 Thu, 25 Apr 2024 17:07:07 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <sjg@chromium.org>
CC: <afd@ti.com>, <kamlesh@ti.com>, <m-chawdhry@ti.com>, <u-kumar1@ti.com>,
 <n-francis@ti.com>, <bsheraw@ti.com>, <s-anna@ti.com>, <a-limaye@ti.com>
Subject: [PATCH v2 2/2] arm: dts: k3-j7200-binman: Add support for HSSE1.0 and
 HSFS1.0
Date: Fri, 26 Apr 2024 03:36:59 +0530
Message-ID: <20240425220659.2056955-3-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425220659.2056955-1-n-francis@ti.com>
References: <20240425220659.2056955-1-n-francis@ti.com>
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

J7200  has SR1.0 and SR2.0 having three variants of each GP, HS-FS and
HS-SE. Current build does not generate HS-SE SR1.0 and HS-FS SR1.0 so
add support for them.

Reported-by: Suman Anna <s-anna@ti.com>
Reported-by: Aniket Limaye <a-limaye@ti.com>
Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 arch/arm/dts/k3-j7200-binman.dtsi | 95 ++++++++++++++++++++++++++++++-
 1 file changed, 94 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/k3-j7200-binman.dtsi b/arch/arm/dts/k3-j7200-binman.dtsi
index 06db8659876..e8020fec2dc 100644
--- a/arch/arm/dts/k3-j7200-binman.dtsi
+++ b/arch/arm/dts/k3-j7200-binman.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include "k3-binman.dtsi"
@@ -47,6 +47,52 @@
 	config = "pm-cfg_j7200.yaml";
 };
 
+&binman {
+	tiboot3-j7200-hs-evm.bin {
+		filename = "tiboot3-j7200-hs-evm.bin";
+		ti-secure-rom {
+			content = <&u_boot_spl_sr1>, <&ti_fs_enc_sr1>, <&combined_tifs_cfg_sr1>,
+				<&combined_dm_cfg_sr1>, <&sysfw_inner_cert_sr1>;
+			combined;
+			dm-data;
+			core-opts = <2>;
+			sysfw-inner-cert;
+			keyfile = "custMpk.pem";
+			sw-rev = <1>;
+			content-sbl = <&u_boot_spl_sr1>;
+			content-sysfw = <&ti_fs_enc_sr1>;
+			content-sysfw-data = <&combined_tifs_cfg_sr1>;
+			content-sysfw-inner-cert = <&sysfw_inner_cert_sr1>;
+			content-dm-data = <&combined_dm_cfg_sr1>;
+			load = <0x41c00000>;
+			load-sysfw = <0x40000>;
+			load-sysfw-data = <0x7f000>;
+			load-dm-data = <0x41c80000>;
+		};
+		u_boot_spl_sr1: u-boot-spl {
+			no-expanded;
+		};
+		ti_fs_enc_sr1: ti-fs-enc.bin {
+			filename = "ti-sysfw/ti-fs-firmware-j7200-hs-enc.bin";
+			type = "blob-ext";
+			optional;
+		};
+		combined_tifs_cfg_sr1: combined-tifs-cfg.bin {
+			filename = "combined-tifs-cfg.bin";
+			type = "blob-ext";
+		};
+		sysfw_inner_cert_sr1: sysfw-inner-cert {
+			filename = "ti-sysfw/ti-fs-firmware-j7200-hs-cert.bin";
+			type = "blob-ext";
+			optional;
+		};
+		combined_dm_cfg_sr1: combined-dm-cfg.bin {
+			filename = "combined-dm-cfg.bin";
+			type = "blob-ext";
+		};
+	};
+};
+
 &binman {
 	tiboot3-j7200_sr2-hs-evm.bin {
 		filename = "tiboot3-j7200_sr2-hs-evm.bin";
@@ -92,6 +138,53 @@
 	};
 };
 
+&binman {
+	tiboot3-j7200-hs-fs-evm.bin {
+		filename = "tiboot3-j7200-hs-fs-evm.bin";
+		ti-secure-rom {
+			content = <&u_boot_spl_fs_sr1>, <&ti_fs_enc_fs_sr1>,
+				  <&combined_tifs_cfg_fs_sr1>, <&combined_dm_cfg_fs_sr1>,
+				  <&sysfw_inner_cert_fs_sr1>;
+			combined;
+			dm-data;
+			core-opts = <2>;
+			sysfw-inner-cert;
+			keyfile = "custMpk.pem";
+			sw-rev = <1>;
+			content-sbl = <&u_boot_spl_fs_sr1>;
+			content-sysfw = <&ti_fs_enc_fs_sr1>;
+			content-sysfw-data = <&combined_tifs_cfg_fs_sr1>;
+			content-sysfw-inner-cert = <&sysfw_inner_cert_fs_sr1>;
+			content-dm-data = <&combined_dm_cfg_fs_sr1>;
+			load = <0x41c00000>;
+			load-sysfw = <0x40000>;
+			load-sysfw-data = <0x7f000>;
+			load-dm-data = <0x41c80000>;
+		};
+		u_boot_spl_fs_sr1: u-boot-spl {
+			no-expanded;
+		};
+		ti_fs_enc_fs_sr1: ti-fs-enc.bin {
+			filename = "ti-sysfw/ti-fs-firmware-j7200-hs-fs-enc.bin";
+			type = "blob-ext";
+			optional;
+		};
+		combined_tifs_cfg_fs_sr1: combined-tifs-cfg.bin {
+			filename = "combined-tifs-cfg.bin";
+			type = "blob-ext";
+		};
+		sysfw_inner_cert_fs_sr1: sysfw-inner-cert {
+			filename = "ti-sysfw/ti-fs-firmware-j7200-hs-fs-cert.bin";
+			type = "blob-ext";
+			optional;
+		};
+		combined_dm_cfg_fs_sr1: combined-dm-cfg.bin {
+			filename = "combined-dm-cfg.bin";
+			type = "blob-ext";
+		};
+	};
+};
+
 &binman {
 	tiboot3-j7200_sr2-hs-fs-evm.bin {
 		filename = "tiboot3-j7200_sr2-hs-fs-evm.bin";
-- 
2.34.1

