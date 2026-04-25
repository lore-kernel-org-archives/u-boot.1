Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470ECFF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:58:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF9E184314;
	Sat, 25 Apr 2026 18:58:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PHyaM8Y8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E614D84374; Sat, 25 Apr 2026 18:58:06 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B1B384314
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:58:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y0asrb7wxF2waORyzkNjLVnxKbxkMVkrwy47wQ73c1qRkht6wox+JSdGBtGf8SHoENNfX94O/kYKDUVYgsQRthjZtaO2vd98SJK7b23WCysgapMtxQkf+RVtoiIFOFe1KuYkULzWL6UbSB2ZsbsNc/1pbbzLDfYL5LuSm09YlHAwlWHr249qt5UGX/PalZokB9usIAGijQ22zNev/r+N1wv1TM34aXy7WtU+MpmyXHogQ2kipPQgZ6IIsihUtAddtyNkcDvWQa0mSbb4ezh02mETOzjOm371R6H7GuIgacaZwk2s914sgDNm1qPMOC/LYoVdaEMx/0+2vCdKOw/9uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1oE46WZVnV/mGsWB0pfzxOqlDZFo0AtHdIgfZNHpik=;
 b=AJN3zl2gQ8WjbT9WZW7k16dTpe9pIcIghQPZGhUx3OdXI3AlIcR2aQg1vgj2uQ1Gc4SZpdBKPCZ81ExQt0bzYvK3DbXp/IfF5ENRIp+DXeM5EyDuXTivULPC3dLtr+8iCTgaA50BPLHtAXs5fcFrFCdLzlIjfcwuqoXr+Mjh3HPdenySUiZ5Q5b40FRugnHSaPPMAM3Ox09cwQf/ybyM0osAx9Xoif96m7SMdlqsHf2a23c+5tHcyMGGs7dMJ9RkyYtC8ZNzvEJ2LQVzavhX0ynkU1o9ff3sGjomxrw9/mH+btf1TsJtDccpT1F7bjcACN57XdKUQKOrOn4E4A4n9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1oE46WZVnV/mGsWB0pfzxOqlDZFo0AtHdIgfZNHpik=;
 b=PHyaM8Y8BnPvLUFxLAOGrOuHS6fO4j3uc8so5N3Ln5qVP+2+5muEuEHoigMVowZDXStmE/chtWaeiTj7odD7CpVa3Nve8u+hLaV/ASV84CmKPr6SRrdz8mzf07QMu+5qrBbVTXRlHLiD7/o9UyJ0+UW3EIqguzAJ/CAJS8r0ETY=
Received: from CO1PR10MB4532.namprd10.prod.outlook.com (2603:10b6:303:6d::17)
 by CO1PR10MB4532.namprd10.prod.outlook.com (2603:10b6:303:6d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Sat, 25 Apr
 2026 16:57:58 +0000
Received: from CO1PR10MB4532.namprd10.prod.outlook.com
 (fe80::2d59:baa8:16c:1700%6) by CO1PR10MB4532.namprd10.prod.outlook.com
 (fe80::2d59:baa8:16c:1700%6) with TransportReplication id Version 15.20
 (Build 9846.16); Sat, 25 Apr 2026 16:57:58 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:27:cafe::e9) by SA9PR13CA0127.outlook.office365.com
 (2603:10b6:806:27::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.20 via Frontend Transport; Sat,
 25 Apr 2026 03:38:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Sat, 25 Apr 2026 03:38:14 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 22:38:14 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 22:38:14 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Apr 2026 22:38:14 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 63P3bk852903263; Fri, 24 Apr 2026 22:38:11 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v4 06/11] arm: dts: k3-{j721s2/j722s/j784s4}-binman: Pack HSM
 firmware inside tispl.bin
Date: Sat, 25 Apr 2026 09:07:37 +0530
Message-ID: <20260425033742.1519298-7-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260425033742.1519298-1-b-padhi@ti.com>
References: <20260425033742.1519298-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|CO1PR10MB4532:EE_
X-MS-Office365-Filtering-Correlation-Id: b5a96477-0878-4f05-32b6-08dea27c1525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZVJZXukDrH+cjcE8I7G2RR4y0XyX3V6wageFJv9MZa6dgL59Ut3aqNnRP/OkFTtdTnY//dyK7uJWxzrTclJqLtmy5DUJ0/34FLyP5pEuBIzfKX7Q+w/LmfVsxp7GichlIm7Q47an2Vb7DvVoE3M+GofprNwqNkCey1dbqFRfURMCWxWt/39do9WHeoMIBL/fiMpUPkcvV8GZ/5zXuJsZNY7Mu6MJRW4+JipawEoVOWCASDQddxqSXO5Wi1uSahCpJyj9cpwRzbFZm+Qtwh5/7KhUW1NdtdSbMKL5Cj5qWuRpeYXvRcBZIzFKOqKEoWvN5DMVIj226RbkRgp6KIVMO45IxkAPzB1i5SYzNE/fT6pUZc6uHyrGllaJDeu962A09eGCBcFGNs33ryhRLWEcVEecTT/zOWZTcZ9lV/q+WPq4FayvrQ81R5pHynSWPUJMzMSiT9gE5Glqd2XPIE0tkW4Xe0/X0op2jLHmpVYlXq3gFhav4Rw2WA8qtjhl0YJjW7Zt8ohCICojU1Hr0U81JWQQF8Lo6CXDil85v8h/Z0luYa8akCkHX43naqUzhPGJAYSmZJKM5vMo4KelZjtxABb5A/r1bQW9D9da3ppsa3GktEi1ChBQ63m8K3K+wAY4Z4OC+dBDjDA8/WC/VHW9L+Te4iiZtfZpG9M+c5fVO40Dx257KIRlOQOR/15qwkpvPFfkoG8C6Nst1L3FtAiq5g2PmNRaCGvXptgdfrC8FfDXKfoEQu2qpfKBnsVWOG1Wagg503pLMEdKyH0uCPcvJbD/OwJ91rPxuTKT1Hb3HAY=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HIfFRxQPGOEMjHlGBJIg6Sy+F60w0uEojyp99gUE6SAuBI4nCR7XE8Kai2M2bN+bdzt+twVrv/uD7Iyx7OmtfOacT8NTsGVvlFC3utjP0vmcEtaf5KS8b5UAGYQMhgtU/vq0mFmeaS1TK6rqCxNoYxFtYFMKsCMcs7PRPih+8tgIQwkIwf5GRW7brAjNS8vhT0BbnbHxACREI4Tw4JGNg6ddtx0xOfooPmVNt01OOfWRXoOmEGwDfudGQ6ZeywcailS4T1DkVgGwRD8xQ2FaQ3ngBSY9yVfeVnWvNvbtZLUKmslR4CyH21vligplXagNyUaV9YNw851Zi2FvdHHBbT4tIkw2TwqrjXI2IAFrjcuaUH/2qrsXYC9lnv37Ewl2DSl2WzX7jrgJo1glN+8loaMkGTxIFh9GBWwyk5bZZOiFQVD8YEavy0r/v91LQJjA
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 03:38:14.6812 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a96477-0878-4f05-32b6-08dea27c1525
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4532
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

Pack the HSM firmware in tispl.bin fit image so that it can be unloaded
and used by R5 SPL to boot the HSM core. By default, point to the
firmware for HS-SE device type. This needs to be changed to point to
appropriate firmware when using a different device type.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
v4: Changelog:
1. Changed node labels from 'hsm' to 'hsm_fw' as 'hsm' was already used
   by the device tree remoteproc node definiton.

Link to v3:
https://lore.kernel.org/all/20251231173621.1069988-7-b-padhi@ti.com/

v3: Changelog:
1. Pack firmware for J722S SoC as well.

Link to v2:
https://lore.kernel.org/all/20250506104202.16741-5-b-padhi@ti.com/

v2: Changelog:
None to this patch.

Link to v1:
https://lore.kernel.org/all/20250422095430.363792-4-b-padhi@ti.com/

 arch/arm/dts/k3-j721s2-binman.dtsi | 12 ++++++++++++
 arch/arm/dts/k3-j722s-binman.dtsi  | 12 ++++++++++++
 arch/arm/dts/k3-j784s4-binman.dtsi | 14 ++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/arch/arm/dts/k3-j721s2-binman.dtsi b/arch/arm/dts/k3-j721s2-binman.dtsi
index f79b3e543ae..2b36b04965e 100644
--- a/arch/arm/dts/k3-j721s2-binman.dtsi
+++ b/arch/arm/dts/k3-j721s2-binman.dtsi
@@ -268,6 +268,14 @@
 
 					};
 				};
+#ifdef CONFIG_K3_HSM_FW
+				hsm {
+					hsm_fw: blob-ext {
+						filename = "ti-hsm/hsm-demo-firmware-j721s2-hs.bin";
+					};
+				};
+#endif
+
 				dm {
 					ti-secure {
 						content = <&dm>;
@@ -300,7 +308,11 @@
 				conf-0 {
 					description = "k3-j721s2-common-proc-board";
 					firmware = "atf";
+#ifdef CONFIG_K3_HSM_FW
+					loadables = "hsm", "tee", "dm", "spl";
+#else
 					loadables = "tee", "dm", "spl";
+#endif
 					fdt = "fdt-0";
 				};
 			};
diff --git a/arch/arm/dts/k3-j722s-binman.dtsi b/arch/arm/dts/k3-j722s-binman.dtsi
index 278b7bfac7f..3834d081c30 100644
--- a/arch/arm/dts/k3-j722s-binman.dtsi
+++ b/arch/arm/dts/k3-j722s-binman.dtsi
@@ -117,6 +117,14 @@
 
 		fit {
 			images {
+#ifdef CONFIG_K3_HSM_FW
+				hsm {
+					hsm_fw: blob-ext {
+						filename = "ti-hsm/hsm-demo-firmware-j722s-hs.bin";
+					};
+				};
+#endif
+
 				dm {
 					ti-secure {
 						content = <&dm>;
@@ -153,7 +161,11 @@
 				conf-0 {
 					description = "k3-j722s-evm";
 					firmware = "atf";
+#ifdef CONFIG_K3_HSM_FW
+					loadables = "hsm", "tee", "dm", "spl";
+#else
 					loadables = "tee", "dm", "spl";
+#endif
 					fdt = "fdt-0";
 				};
 			};
diff --git a/arch/arm/dts/k3-j784s4-binman.dtsi b/arch/arm/dts/k3-j784s4-binman.dtsi
index 34b2cc1e681..1da98228ff8 100644
--- a/arch/arm/dts/k3-j784s4-binman.dtsi
+++ b/arch/arm/dts/k3-j784s4-binman.dtsi
@@ -154,6 +154,16 @@
 
 		fit {
 			images {
+
+#ifdef CONFIG_K3_HSM_FW
+				hsm {
+					hsm_fw: blob-ext {
+						filename = "ti-hsm/hsm-demo-firmware-j784s4-hs.bin";
+					};
+				};
+
+#endif
+
 				dm {
 					ti-secure {
 						content = <&dm>;
@@ -188,7 +198,11 @@
 				conf-0 {
 					description = BOARD_DESCRIPTION;
 					firmware = "atf";
+#ifdef CONFIG_K3_HSM_FW
+					loadables = "hsm", "tee", "dm", "spl";
+#else
 					loadables = "tee", "dm", "spl";
+#endif
 					fdt = "fdt-0";
 				};
 			};
-- 
2.34.1

