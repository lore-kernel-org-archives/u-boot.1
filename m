Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E7AC46CD3
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 11:34:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01EB0871C3;
	Wed, 20 Dec 2023 12:34:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="so41D5Ep";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA54487509; Wed, 20 Dec 2023 12:34:42 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 257CF86FCE
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 12:34:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BKBYbqY074247;
 Wed, 20 Dec 2023 05:34:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703072077;
 bh=hqmRcv2aO+3HJnWPg/Br9xxsmigr5PlAl0omIEHFJ4A=;
 h=From:To:CC:Subject:Date;
 b=so41D5EpIrRhoq5oZlS9mJVy7/ZSzqnpH39+qCnJ8yaPJlXTiqz/k2QRyrpEaZ7VE
 SG+7r1J2r+ZR4bI2ZHnQ5E/GqW2sjl1NXIJsx/xskPV0s9KhdRxqe7afPwtS3k6y6d
 4LXVBbdMGaJ6/h9kAS7koNCoiYHWbNmBiZKNQXXM=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BKBYbPF006613
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 20 Dec 2023 05:34:37 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 20
 Dec 2023 05:34:36 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 20 Dec 2023 05:34:36 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BKBYY2X067448;
 Wed, 20 Dec 2023 05:34:35 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <sjg@chromium.org>
CC: <u-boot@lists.denx.de>, <kamlesh@ti.com>, <m-chawdhry@ti.com>,
 <afd@ti.com>, <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [PATCH] arm: dts: k3-j721e-binman: Add support for HS-SE 2.0
Date: Wed, 20 Dec 2023 17:04:33 +0530
Message-ID: <20231220113433.1690312-1-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
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

Add support for J721E HS-SE 2.0 device. Make use of the existing
templates and override the phandles for sysfw.itb so that builds do not
fail.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
Boot log:
https://gist.github.com/nehamalcom/44082b0c94059737e8d5d1ab16b2f55f

 arch/arm/dts/k3-j721e-binman.dtsi | 83 +++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/arm/dts/k3-j721e-binman.dtsi b/arch/arm/dts/k3-j721e-binman.dtsi
index dbc385a852..9707ea3085 100644
--- a/arch/arm/dts/k3-j721e-binman.dtsi
+++ b/arch/arm/dts/k3-j721e-binman.dtsi
@@ -20,6 +20,20 @@
 			no-expanded;
 		};
 	};
+
+	tiboot3-j721e_sr2-hs-evm.bin {
+		filename = "tiboot3-j721e_sr2-hs-evm.bin";
+		ti-secure-rom {
+			content = <&u_boot_spl_sr2>;
+			core = "public";
+			load = <CONFIG_SPL_TEXT_BASE>;
+			keyfile = "custMpk.pem";
+		};
+		u_boot_spl_sr2: u-boot-spl {
+			no-expanded;
+		};
+	};
+
 	sysfw {
 		filename = "sysfw.bin";
 		ti-secure-rom {
@@ -40,10 +54,79 @@
 			optional;
 		};
 	};
+
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
+
 	itb {
 		filename = "sysfw-j721e_sr1_1-hs-evm.itb";
 		insert-template = <&itb_template>;
 	};
+
+	itb_sr2 {
+		filename = "sysfw-j721e_sr2-hs-evm.itb";
+		insert-template = <&itb_template>;
+		fit {
+			images {
+				sysfw.bin {
+					blob-ext {
+						filename = "sysfw.bin_sr2";
+					};
+				};
+				board-cfg.bin {
+					ti-secure {
+						content = <&board_cfg_sr2>;
+					};
+					board_cfg_sr2: board-cfg {
+						filename = "board-cfg.bin";
+					};
+				};
+				pm-cfg.bin {
+					ti-secure {
+						content = <&pm_cfg_sr2>;
+					};
+					pm_cfg_sr2: pm-cfg {
+						filename = "pm-cfg.bin";
+					};
+				};
+				rm-cfg.bin {
+					ti-secure {
+						content = <&rm_cfg_sr2>;
+					};
+					rm_cfg_sr2: rm-cfg {
+						filename = "rm-cfg.bin";
+					};
+				};
+				sec-cfg.bin {
+					ti-secure {
+						content = <&sec_cfg_sr2>;
+					};
+					sec_cfg_sr2: sec-cfg {
+						filename = "sec-cfg.bin";
+					};
+				};
+
+			};
+		};
+	};
 };
 
 &binman {
-- 
2.34.1

