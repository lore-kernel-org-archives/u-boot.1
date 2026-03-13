Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A635105F7AE
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 14:02:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 867658436C;
	Fri, 13 Mar 2026 14:59:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Dyk+ugjF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86CB084376; Fri, 13 Mar 2026 14:59:54 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C777484307
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 14:59:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u1UylEecMxlzllxab7Iq+dPOTbBXRCjAWTIKmL/N0MicBt7RBr6hku1EPUkVKlo/SW//GW6u5lq3Ot6YboyJ0yfFPf85ZAEwfN1NKZEDG3yt53E1ETmlnjqOQxUkr5I3SydPJC2zEZqkpaaPJ0O0Ze0dhsMTCTl8TN9Srxyb8dl/wD2Ii87HiUFrZiCGHnNOWTCp2RrUlqix0RyVvfavu7AqTlUFaAzUkVAlNLRO8i8tUhIvUOb1o0mDiTQD9WOiSVHeSXlsIfGQ6M6Vn/k9x0xwx3so69mUeVGRtRPzFde/3WhiTPSQd/O+82KUeQgP0FKHCipjUbNhSiWRpOyAgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqwwJMp7NCVJeXHTbCHUXVZ2mVRhKjy2MitzPSVDgDQ=;
 b=r6OWh1mqbWa1PdmFMlNGSWhZ/RZDT/0WvWqrWMgLoVLXEL+H5ePg13Iq+29nmSydW0MdPchhv4U4v2WddY7NYcU6SdFCrWbroTLr/gC1gz1SQPjgP+6lbwkJAYEZ7jpSDrODEPK0A96r86BtCpz6Gqz+oqu8XRRcJ52BqjkILuRgxt5s9/gZ7rFyns8IZbkeBC01rq1NRolQpTRJxuKuTITyto5OZVQMSc1OMUq1XMqrFuu+Q09ABgL2L/rmhhzAEGqrNcyZKoyOo46B1Rc3eSPtzesB3vu1tpqaW2o0VyNAIf8ZbuUM2XiCdJmNcWG4Sqd2alSJoe0wPICxj63ytg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqwwJMp7NCVJeXHTbCHUXVZ2mVRhKjy2MitzPSVDgDQ=;
 b=Dyk+ugjFrqCatTtO90aLF2C2h+hbjRIb4BfeqJxbvXoytUlxM+6VduNOa34Jb42N5zPvg3dNpHG7MPxRHkn8IkksC7s1ebnbavL0v2MUAP++Ag/Z+qe9MxVDzELBc2D4DvYCpbhonkJL2g75I6x0VlorEs2Jtokv35uP45RJK8s=
Received: from CH0PR04CA0096.namprd04.prod.outlook.com (2603:10b6:610:75::11)
 by CH2PR10MB4392.namprd10.prod.outlook.com (2603:10b6:610:79::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.17; Fri, 13 Mar
 2026 13:59:47 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::c6) by CH0PR04CA0096.outlook.office365.com
 (2603:10b6:610:75::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.16 via Frontend Transport; Fri,
 13 Mar 2026 13:59:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 13:59:47 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 08:59:46 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 08:59:46 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Mar 2026 08:59:46 -0500
Received: from prasanth-server.dhcp.ti.com (prasanth-server.dhcp.ti.com
 [10.24.53.104])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62DDx6Jm638000;
 Fri, 13 Mar 2026 08:59:44 -0500
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <n-francis@ti.com>
CC: <u-kumar1@ti.com>, <vigneshr@ti.com>, <a-kumar2@ti.com>
Subject: [RFC PATCH 16/19] arm: dts: k3-j7200: Extend firewall for ATF region
 to TIFS
Date: Fri, 13 Mar 2026 19:28:57 +0530
Message-ID: <20260313135900.3430264-17-p-mantena@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260313135900.3430264-1-p-mantena@ti.com>
References: <20260313135900.3430264-1-p-mantena@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|CH2PR10MB4392:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bdd7251-a69a-497a-571c-08de8108c978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: eKFn3w6yNUzv+799I8rL5W1VeIHlA9rQYrAqHHazZOI8Tu0StiIWIXqJsJ1mJO4wQO6WB9Kl6S+D+9EF7Gdg61UGF6/wuVo2hucsUjaLUlG9kL3oTUsx762mASnDVFIY+VC4S0bvIMxvzeXu6OR/qGyZsYYMzHXNDm8FaqMKhGH3jiriMxSvyIoDKZ2c67OoTGmBJvDVtozRRIWciFZ2Rs1TjmBCYdiG+SyHV6kRcxyiUhm4rJ/nNDTcIbUfb6q4pOAAZkk/TO9zwFBtAXiuzgkGYxS4yDxy8tHTAe07RHmFYrVRFOrzTMRuw187RfcG2kKQoPUnhzGBskSyzpxc52zW1K9/ZqTuLJHx2r39qWmEHyeBIZajBhZmsESHuTVK6fIHHPT9wg79hQIkGcKo1tPOhYFgNgYDpPtPNJmwDtgf9nQOlQmc0exju7kFzmVtc45FJP9Af9VBUQDUzDIc7NoDhyc4+8DB4oSw8l/HRwqt6/Uaak3vx/AEIfJBXpz5H6Tt6PAXuCwvFwAfRzM/SFDUmlCA0vl4NwtLtxPjjS2tvkomi4RTQQfIWkqt53H6cdrMhnafa1a964UQ9sc/V10hOD8FC7BWDHENS/adYgNKMsXQDPm5X9cwhPK2PPCM6a3tmjinXbJPMphP1rKRBghDT5xbvUBVN9efFu3mFP/LyIl63ZfKb473lodM/zgPsZmxtrxGrGBjCci3E4VJABHgJ26cg2hSX8EABhHL90VjpRmaw61R+/nLbcQEkdVgYO1c/0mN4ROSyK2G93Ujgg==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RxQE/84zkzHBwpoiEubWGxBik0z/bVMP+uU5fkcQ7topIRtG8y/LTuTXdYMDXx0LK1rnhV5hSZstga/YLXm9a2YHy3CCDH5uF5P6mROLvtg3GaYc7Xjd3VmLirDoc0Ki2XN1aRCuTWOzqW3wR6ekHMqUtjv7mV3GbnhLb0C2C+mO7tXWlmaj2ALmQ7TtlyH2u3LO/xFADIxcuyK4WR8T2+fXupoffK8yEhYJZc3u1e5FeZhl0bHpQDVfgaDRAg76RWk5rLKV3Mu9HJjWW8+yJjJIdjKhgsTsc4897bmfoCkWKUfcvpNcC2CgwplNcT15adRHi2+rP+QOPq2cxZpAcGwb7qvPCooHKV/Dqwfc2rg5Z4bpxMwBCOWUuAAXN2o6t1BDwgXb17PWlnS9tuhb5mrfgzasT+ovy7sC7JRgw5jFmgjSyTYu1fGaJRuIeh+H
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 13:59:47.2094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bdd7251-a69a-497a-571c-08de8108c978
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4392
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

Extend the access to SRAM region of ATF to TIFS as well. This is
needed for TIFS for encryption and decryption of ATF as a part of
low power mode sequence. TIFS encrypts the ATF while entering into
low power mode and decrypts it back while resuming back.
So, giving permissions for TIFS to access this region.

Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
---
 arch/arm/dts/k3-binman.dtsi       | 18 ++++++++++++++++--
 arch/arm/dts/k3-j7200-binman.dtsi |  4 ++--
 arch/arm/dts/k3-security.h        |  1 +
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index 0fd93f9536a..4ffd8ec9e1c 100644
--- a/arch/arm/dts/k3-binman.dtsi
+++ b/arch/arm/dts/k3-binman.dtsi
@@ -479,7 +479,21 @@
 		start_address = <0x0 CONFIG_K3_ATF_LOAD_ADDR>;
 		end_address = <0x0 (CONFIG_K3_ATF_LOAD_ADDR + 0x1ffff)>;
 	};
-	firewall_armv8_optee_fg: template-8 {
+	firewall_armv8_atf_tifs_fg: template-8 {
+		control = <(FWCTRL_EN | FWCTRL_LOCK |
+					FWCTRL_CACHE)>;
+		permissions = <((FWPRIVID_ARMV8 << FWPRIVID_SHIFT) |
+						FWPERM_SECURE_PRIV_RWCD |
+						FWPERM_SECURE_USER_RWCD)>,
+					<((FWPRIVID_TIFS << FWPRIVID_SHIFT) |
+						FWPERM_SECURE_PRIV_RWCD |
+						FWPERM_SECURE_USER_RWCD |
+						FWPERM_NON_SECURE_PRIV_RWCD |
+						FWPERM_NON_SECURE_USER_RWCD)>;
+		start_address = <0x0 0x70000000>;
+		end_address = <0x0 0x7001ffff>;
+	};
+	firewall_armv8_optee_fg: template-9 {
 		control = <(FWCTRL_EN | FWCTRL_LOCK |
 					FWCTRL_CACHE)>;
 		permissions = <((FWPRIVID_ARMV8 << FWPRIVID_SHIFT) |
@@ -489,7 +503,7 @@
 		end_address = <0x0 (CONFIG_K3_OPTEE_LOAD_ADDR + 0x17fffff)>;
 	};
 
-	ti_falcon_template: template-9 {
+	ti_falcon_template: template-10 {
 		filename = "tifalcon.bin";
 		pad-byte = <0xff>;
 
diff --git a/arch/arm/dts/k3-j7200-binman.dtsi b/arch/arm/dts/k3-j7200-binman.dtsi
index 81be4d69187..0bb1b0fc75d 100644
--- a/arch/arm/dts/k3-j7200-binman.dtsi
+++ b/arch/arm/dts/k3-j7200-binman.dtsi
@@ -259,7 +259,7 @@
 
 						firewall-4760-1 {
 							/* nb_slv0__mem0 Foreground Firewall */
-							insert-template = <&firewall_armv8_atf_fg>;
+							insert-template = <&firewall_armv8_atf_tifs_fg>;
 							id = <4760>;
 							region = <1>;
 						};
@@ -272,7 +272,7 @@
 
 						firewall-4761-1 {
 							/* nb_slv1__mem0 Foreground Firewall */
-							insert-template = <&firewall_armv8_atf_fg>;
+							insert-template = <&firewall_armv8_atf_tifs_fg>;
 							id = <4761>;
 							region = <1>;
 						};
diff --git a/arch/arm/dts/k3-security.h b/arch/arm/dts/k3-security.h
index 33609caa8fb..0b3f2cf3df1 100644
--- a/arch/arm/dts/k3-security.h
+++ b/arch/arm/dts/k3-security.h
@@ -7,6 +7,7 @@
 #define DTS_ARM64_TI_K3_FIREWALL_H
 
 #define FWPRIVID_ALL    0xc3
+#define FWPRIVID_TIFS	0xca
 #define FWPRIVID_ARMV8  1
 #define FWPRIVID_SHIFT  16
 
-- 
2.34.1

