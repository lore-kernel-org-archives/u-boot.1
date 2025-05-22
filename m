Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A63C54756
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 07:19:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B74983022;
	Thu, 22 May 2025 09:18:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="W5M6vzmc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F15C83043; Thu, 22 May 2025 09:18:54 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9FA282E31
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 09:18:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54M7Inir1746462;
 Thu, 22 May 2025 02:18:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1747898329;
 bh=ZFCwzrOsNV5pXVuU8qikylMlZ8sIAe83vhVpPfuFGvY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=W5M6vzmc+p5+3ZWpAVhnRBKilkx+9/C7uGLtMtGuVyezjkTQQn11F4g5sPXa//Olp
 3eeoRs51EIFjPfjGl7OSyy2eLJ/LRMq3sti+Ztn3Jr1L6IC9ly5BH7dQxzCLyq4aCD
 OBNuX31P2L4q3JIOyH78DhBgkY1bQERJARGS1xvs=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54M7In433314414
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 22 May 2025 02:18:49 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 May 2025 02:18:48 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 May 2025 02:18:48 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 54M7IT9N467991;
 Thu, 22 May 2025 02:18:45 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <nm@ti.com>, <hnagalla@ti.com>, <n-francis@ti.com>,
 <jm@ti.com>, <u-kumar1@ti.com>, <m-shah@ti.com>, <b-padhi@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 5/6] arm: dts: k3-j7*-binman: Enable split mode for MCU R5F
Date: Thu, 22 May 2025 12:48:27 +0530
Message-ID: <20250522071828.285462-6-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250522071828.285462-1-b-padhi@ti.com>
References: <20250522071828.285462-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Set boot core-opts to enable split mode for MCU R5 cluster by default.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
 arch/arm/dts/k3-j7200-binman.dtsi  | 3 +++
 arch/arm/dts/k3-j721e-binman.dtsi  | 4 ++++
 arch/arm/dts/k3-j721s2-binman.dtsi | 3 +++
 arch/arm/dts/k3-j784s4-binman.dtsi | 3 +++
 4 files changed, 13 insertions(+)

diff --git a/arch/arm/dts/k3-j7200-binman.dtsi b/arch/arm/dts/k3-j7200-binman.dtsi
index 47a4cde6b85..cf281bc72e0 100644
--- a/arch/arm/dts/k3-j7200-binman.dtsi
+++ b/arch/arm/dts/k3-j7200-binman.dtsi
@@ -61,6 +61,7 @@
 				<&combined_dm_cfg>, <&sysfw_inner_cert>;
 			combined;
 			dm-data;
+			core-opts = <2>;
 			sysfw-inner-cert;
 			keyfile = "custMpk.pem";
 			sw-rev = <1>;
@@ -153,6 +154,7 @@
 				<&combined_dm_cfg_fs>, <&sysfw_inner_cert_fs>;
 			combined;
 			dm-data;
+			core-opts = <2>;
 			sysfw-inner-cert;
 			keyfile = "custMpk.pem";
 			sw-rev = <1>;
@@ -199,6 +201,7 @@
 				<&combined_tifs_cfg_gp>, <&combined_dm_cfg_gp>;
 			combined;
 			dm-data;
+			core-opts = <2>;
 			content-sbl = <&u_boot_spl_unsigned>;
 			load = <0x41c00000>;
 			content-sysfw = <&ti_fs_gp>;
diff --git a/arch/arm/dts/k3-j721e-binman.dtsi b/arch/arm/dts/k3-j721e-binman.dtsi
index 6adfab164ee..54c7ad92069 100644
--- a/arch/arm/dts/k3-j721e-binman.dtsi
+++ b/arch/arm/dts/k3-j721e-binman.dtsi
@@ -13,6 +13,7 @@
 		ti-secure-rom {
 			content = <&u_boot_spl>;
 			core = "public";
+			core-opts = <2>;
 			load = <CONFIG_SPL_TEXT_BASE>;
 			keyfile = "custMpk.pem";
 		};
@@ -26,6 +27,7 @@
 		ti-secure-rom {
 			content = <&u_boot_spl_sr2>;
 			core = "public";
+			core-opts = <2>;
 			load = <CONFIG_SPL_TEXT_BASE>;
 			keyfile = "custMpk.pem";
 		};
@@ -223,6 +225,7 @@
 		ti-secure-rom {
 			content = <&u_boot_spl_fs>;
 			core = "public";
+			core-opts = <2>;
 			load = <CONFIG_SPL_TEXT_BASE>;
 			keyfile = "custMpk.pem";
 		};
@@ -256,6 +259,7 @@
 		ti-secure-rom {
 			content = <&u_boot_spl_unsigned>;
 			core = "public";
+			core-opts = <2>;
 			load = <CONFIG_SPL_TEXT_BASE>;
 			sw-rev = <CONFIG_K3_X509_SWRV>;
 			keyfile = "ti-degenerate-key.pem";
diff --git a/arch/arm/dts/k3-j721s2-binman.dtsi b/arch/arm/dts/k3-j721s2-binman.dtsi
index 73af184d27e..2d34b193813 100644
--- a/arch/arm/dts/k3-j721s2-binman.dtsi
+++ b/arch/arm/dts/k3-j721s2-binman.dtsi
@@ -15,6 +15,7 @@
 				<&combined_dm_cfg>, <&sysfw_inner_cert>;
 			combined;
 			dm-data;
+			core-opts = <2>;
 			sysfw-inner-cert;
 			keyfile = "custMpk.pem";
 			sw-rev = <1>;
@@ -60,6 +61,7 @@
 				<&combined_dm_cfg_fs>, <&sysfw_inner_cert_fs>;
 			combined;
 			dm-data;
+			core-opts = <2>;
 			sysfw-inner-cert;
 			keyfile = "custMpk.pem";
 			sw-rev = <1>;
@@ -106,6 +108,7 @@
 				<&combined_tifs_cfg_gp>, <&combined_dm_cfg_gp>;
 			combined;
 			dm-data;
+			core-opts = <2>;
 			content-sbl = <&u_boot_spl_unsigned>;
 			load = <0x41c00000>;
 			content-sysfw = <&ti_fs_gp>;
diff --git a/arch/arm/dts/k3-j784s4-binman.dtsi b/arch/arm/dts/k3-j784s4-binman.dtsi
index cb1fbc65923..14e71ab0f20 100644
--- a/arch/arm/dts/k3-j784s4-binman.dtsi
+++ b/arch/arm/dts/k3-j784s4-binman.dtsi
@@ -19,6 +19,7 @@
 				<&combined_dm_cfg>, <&sysfw_inner_cert>;
 			combined;
 			dm-data;
+			core-opts = <2>;
 			sysfw-inner-cert;
 			keyfile = "custMpk.pem";
 			sw-rev = <1>;
@@ -68,6 +69,7 @@
 				<&combined_dm_cfg_fs>, <&sysfw_inner_cert_fs>;
 			combined;
 			dm-data;
+			core-opts = <2>;
 			sysfw-inner-cert;
 			keyfile = "custMpk.pem";
 			sw-rev = <1>;
@@ -117,6 +119,7 @@
 				<&combined_tifs_cfg_gp>, <&combined_dm_cfg_gp>;
 			combined;
 			dm-data;
+			core-opts = <2>;
 			content-sbl = <&u_boot_spl_unsigned>;
 			load = <0x41c00000>;
 			content-sysfw = <&ti_fs_gp>;
-- 
2.34.1

