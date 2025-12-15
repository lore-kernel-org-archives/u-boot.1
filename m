Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B99D41D74
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 10:46:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FCE3801CF;
	Mon, 15 Dec 2025 11:46:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fZ8mBINg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3649B80325; Mon, 15 Dec 2025 11:46:35 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4A0180107
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 11:46:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IMZhz2p/9x7bXd4rUBZQ6ntBq9/icF3+70URPUQ913Gfifgj8JmOwpd+crtkhk5kIcVVXEMNQWDnn53niVxX05waT52VzIgiBNarEp+AhoGgIAqYotNab0IN3A2B+s9toxZ7dggmvInNPBPah2ILY4Nn1Uq0I+Ejk1Z6um+HKE8ZNGxp7BMVVliKPgoejwJg+7eFNEvCbeRcIyqAehQ6FHW0uYHiml8kvqs61tpINOR8nK7VigY+qEh48dsFCwXjZLObaHhSs4Snb+/7GWcFi8o+HLxGd9X6bK0Od45iWe7uAiqQC6eAYpxGIBeIdHw5MF8NP6Y/kEtCnrJiBzLBJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+/es+wgvfRgi8Mz0a09jKA126onlICmpr+H+kNbdnE=;
 b=klCFk1S2IoHLr0bfJ3z0OI9x4aR06gokFkB/5+PlmzdBnhcR589Hv5F0VT+sh4NO3c3rH2sbO0x7mwhnunhpx7x+bL/fX8STS9kUJZVv/2+8uiZc98ndKBl/1BdTXVjgijnio3kj2LMDAnnQ3jYot2cUPsi6Ben+icjbuYb3fIiByUbiaujODBW9yDBdNaJuQUoOo7P97Ad72gbZ92JnOB3ypFVzCp1CBDXOnJ7J0XePzUKKzFU+431Cv3Rw+O+Qvo5nSq94RDGcXcxEwbuoM1wq3e16LviqvhkfzwHgXzllqxofJT1iIys7mrQPuIR6Ah6ZSkSFLbN+0F93npVF3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+/es+wgvfRgi8Mz0a09jKA126onlICmpr+H+kNbdnE=;
 b=fZ8mBINgKHePnys+sScWdpM5DtfMGRZcbOLw+aJ2L/dxpew+n8bwQptRTReSf27oKMYJU7tAyx/qoa/8WzzKhRkrR8beIb2AK7oqErgvLHjePXQz08IHW59q1WE/9dHUwotbdGtZwWa6FvZUi4Fo3Uzg3e9biUli2etWY0vYuwY=
Received: from PH7P220CA0070.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::10)
 by SJ2PR10MB7084.namprd10.prod.outlook.com (2603:10b6:a03:4c4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 10:46:29 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:510:32c:cafe::4f) by PH7P220CA0070.outlook.office365.com
 (2603:10b6:510:32c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Mon,
 15 Dec 2025 10:46:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 10:46:28 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 15 Dec
 2025 04:46:27 -0600
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 15 Dec
 2025 04:46:27 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 15 Dec 2025 04:46:27 -0600
Received: from prasanth-server.dhcp.ti.com (prasanth-server.dhcp.ti.com
 [172.24.235.150])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BFAkPMH2230798;
 Mon, 15 Dec 2025 04:46:25 -0600
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <n-francis@ti.com>
CC: <u-kumar1@ti.com>, <vigneshr@ti.com>, <m-chawdhry@ti.com>
Subject: [PATCH] arm: dts: k3-j7200: Extend firewall for ATF region to TIFS
Date: Mon, 15 Dec 2025 16:16:23 +0530
Message-ID: <20251215104623.1665884-1-p-mantena@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|SJ2PR10MB7084:EE_
X-MS-Office365-Filtering-Correlation-Id: 66c2f639-7186-4a0f-389b-08de3bc73372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yN9TcFsUov36ooZalvVjWc9a6hnHQ9aaYIdBKf1NecNPazGNsRI5AHIif7ma?=
 =?us-ascii?Q?OeAKKxxD3ZtrGXJo9ZGaXyOlhCy7CETE/tff6vd2tzj6zSFGWHeghmfihqUJ?=
 =?us-ascii?Q?b5PjfK6a2NIpCFdFB26oKwi+dMiRYBfgaArVifO5FgziSkvx0idOlJhpyzEF?=
 =?us-ascii?Q?CyIiLQucsYAiABcKa48ilKGeLniFCvk7vLbpAd/MgJMsPYWiD2h79nGXOVa5?=
 =?us-ascii?Q?aHjqbrLb+Jq4hgh5mEYh/aPz4wR1jG9sajTePQEpbBjnwmVb/RRUgwVjKYBQ?=
 =?us-ascii?Q?cR4Dl0JT8qTSLFPSa++OFfQ3k9hEFIU/UbM9qF+AkCgPRS3eCdhFYfiUEPGT?=
 =?us-ascii?Q?umozmvSQaP57djCT/v7B1xKkk/xAPoFob+Y3SZKLEjVGkfsx+lle32J80Y/6?=
 =?us-ascii?Q?XzCxOplSMgPtLvVJHBiFiNqXLprKcfler8Jr7LPfrfnOY0idEVxkhmEZ4n5F?=
 =?us-ascii?Q?dGG7/Hl1vhKioEa/otK2KgEvOq6S1AhwYtNAS/61UcO9EFYIDwK5deFm51sg?=
 =?us-ascii?Q?liU+fMmz7Pkj1D7EdeeOu7iG1PLSNRckZ7sqwFAmvsW6OhY8ZGFLKg8X4ty+?=
 =?us-ascii?Q?OJxGuAbig/oQxj/142slLccoLuhVK/4pIjbgRpTTn+BQcNrgu8ZDQnc37VNH?=
 =?us-ascii?Q?aa5Qu9/qc/C7DeXz/LKB5gpcev3ALZOsTBTZeQvqWXYu/06GhZr47R7/bIT2?=
 =?us-ascii?Q?OiwA2ZMh8++5sdlOftP+VLcMXBeMKJuO4JWMJc4GBtlX94mqLm2uo4+7qLHN?=
 =?us-ascii?Q?Uim5d6eMEO+eOF8he6P+ugvnaA2hOfWQuzpEIsdUcCbO7sefCh1P4KGt1qRo?=
 =?us-ascii?Q?I7llUz4ktb63Jhmtvnq7b9+OfqdOFDwPFDCsko71CaUOoI47eNukze4Druse?=
 =?us-ascii?Q?lsi16nqJad6qJfsgex2RY28wQpzIMWPZukRiqDg5udbbqZxDWtVkL8e/75Eq?=
 =?us-ascii?Q?GeknR/CnRPDvat/cwSBlGubXlRMVTigm+bMq5Sp6+7ri0QusKvdChNsMhSjN?=
 =?us-ascii?Q?mGPQrFqJgfR1Z8m6eE0kRHU1DzToDV4AFjpKrXaThDjn5UT/kbRjnHaZGria?=
 =?us-ascii?Q?BmefVdx1PRGm59mCfJb0ldxlCN/vJZFG305po5zG6itH2afKKx5WVp4DiMC5?=
 =?us-ascii?Q?hSsYAu4EWc2iBu+3b+1AvASlCUJVHN/m1imKAaARrNnoorLN0rk0ijFn7e+k?=
 =?us-ascii?Q?LYqT8UPu7mw4uPDpyEL2Ni3GCQ1tD5ZJZVrzzl9ePcKVdIeGaPGr0PA5Hka5?=
 =?us-ascii?Q?aCE0AS3oBy+Bb/p/d6JAkrjSlrNOPsogWqXM4hmEE3HkYZZ1hrh7+ZdqWq7p?=
 =?us-ascii?Q?SL5d5mzu17OaavI6CdhlJfXYwIWCzqUn1MBXVF9oFx6E9BC2g1PTU2oM92Ji?=
 =?us-ascii?Q?1xkJJ92rM3RzY4tLGMwtOuNa7TiIcKBtYLiug+LT4YcmWteA98HFRus9koru?=
 =?us-ascii?Q?Q/RBWaAirkhsaVG2P4+LeEYYsSmTMgcSCRO861V6lKyYsCU3Po7jueyBW6Sy?=
 =?us-ascii?Q?x6eE+Hf8VHlDldavwivGUGdQXe6vVcu+/BuhRLE28JskDhnnre4DO35Vn5hx?=
 =?us-ascii?Q?uXTt9xQdmCfcG8+kk8Y=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 10:46:28.0077 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c2f639-7186-4a0f-389b-08de3bc73372
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7084
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
low power sequence.
So, give permissions for TIFS to access this region.

Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
---
 arch/arm/dts/k3-binman.dtsi       | 18 ++++++++++++++++--
 arch/arm/dts/k3-j7200-binman.dtsi |  4 ++--
 arch/arm/dts/k3-security.h        |  1 +
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index 761b1730464..6c5ebaa1f35 100644
--- a/arch/arm/dts/k3-binman.dtsi
+++ b/arch/arm/dts/k3-binman.dtsi
@@ -479,7 +479,21 @@
 		start_address = <0x0 0x70000000>;
 		end_address = <0x0 0x7001ffff>;
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
 		end_address = <0x0 0x9fffffff>;
 	};
 
-	ti_falcon_template: template-9 {
+	ti_falcon_template: template-10 {
 		filename = "tifalcon.bin";
 		pad-byte = <0xff>;
 
diff --git a/arch/arm/dts/k3-j7200-binman.dtsi b/arch/arm/dts/k3-j7200-binman.dtsi
index b4e0ce8bfcf..72490fc7617 100644
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

