Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF4BCA0FFE
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 08:55:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6751B83AAF;
	Tue,  2 Sep 2025 10:54:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vqs2gIDA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D34983AB2; Tue,  2 Sep 2025 10:54:40 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::622])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DBDD83AA9
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 10:54:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tF/UwQc2LfQq4AO6Y8L5O/BIooahUtFXJw05Z5FzuZZzwqCrJiSWVuB3ccjQqRotZJ/k8+h58IIqD3EEp7hpzXSL7JxoLwQQ5yHeiXDFGNKFt6taIsP8h0cODVYLWoYzwdqOjs/KBpOrrkX/DPUYWTCNgKe3w14aQo1fotsIKcvJnm4LEdw3dY0gdED5XaR7rPExjePrqq97dZQ0FbJG0IYjmTeUHNJ4HPrqNyEppOMK9/65S6zUmkuBYHBtnfc4HP1MZzrfMcpG/MmJQDPzJgiYqUo3WTHCgQWEkCqZ3otL6yzowEF7pqpMiXIMvw726Yr7lkL3Bs8Dmf/2dsbT6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFqYg+sarNsGahyhCzfKrLgKlVXhpWLTJELEEHSGzjU=;
 b=xuzyGsaAtmoWNclEzewNmWej0iEcntrXtB7zTSmmXAIMj8KObpRor20U1Bd8KnP4wiIX9JtWWqxnPlw/kLh0XxgDJsMTcTvXcYpp6x0HQZL3WS1UrsJeKSJt9zs1veRRU/EAs06BDv8dIuIMKCn5y8NYFXiFOAoGNWQ05nMHmN79/s3iZNh/BCrBsxbxPlajHviZcdp7BvNreR6fZ1L4VtuWzYkiJrUwUtfzR4UyRgKxOKyIb30FWdanXeMwpMkvUUksCj/iSXpRtrndN71zTLbEcOIEp8iKw9/kRP2+qhPDsrOD6hqJlPkpTFSHCBUDDHyple4MO7/Tye5z+D5fUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFqYg+sarNsGahyhCzfKrLgKlVXhpWLTJELEEHSGzjU=;
 b=vqs2gIDAieS/iitwFPukiQ1Mz8Vh6rB8lBzLN5G5qji773Z9u4HSiLa3TH4V2OcBhoeZd23+9PZFrC3KYhNdKmp7hBOdJMhUN7EOS07NqFtPzzTMksh4E4EZEVv/UAEze6FpRwdolqI1GAbk4zBlaI5JAQUdgci38kRjQiyDzds=
Received: from MW4PR03CA0031.namprd03.prod.outlook.com (2603:10b6:303:8e::6)
 by IA4PR12MB9812.namprd12.prod.outlook.com (2603:10b6:208:55b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 08:54:33 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:303:8e:cafe::45) by MW4PR03CA0031.outlook.office365.com
 (2603:10b6:303:8e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.16 via Frontend Transport; Tue,
 2 Sep 2025 08:54:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 08:54:32 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 03:54:32 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 2 Sep
 2025 01:54:31 -0700
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 2 Sep 2025 03:54:30 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/12] arm64: zynqmp: Update compatible string for tps546X24
Date: Tue, 2 Sep 2025 10:53:31 +0200
Message-ID: <a247b2b57ebe52e9d23525bf4f96c4872288025d.1756803198.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756803198.git.michal.simek@amd.com>
References: <cover.1756803198.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3735; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=gXjyAp79BpUQDIvBMoO5WWXDgYCRugoJ2cqbLB9B+BU=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRs29DjI+CwNOphDvtjNg++E5XLWBNEBfVi3i7b1m84y
 9s8bevUjlIWBjEOBlkxRZbpTDoOa75dWyq2PDIfZg4rE8gQBi5OAZiI5Q1GhmuO+1VnLLgqkK+7
 vPfcqv5bnR0ZteHpW0MXP1j8jXcx13JGhk1+axqV1m7VaFDcudmaz+wrW07HIe3DXwxt6vz9pNw
 /8wIA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|IA4PR12MB9812:EE_
X-MS-Office365-Filtering-Correlation-Id: ef115143-a591-4226-8a62-08dde9fe55e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qMtUDB29X7Nnpw4pvA7ddcmkKJkQDw4CKbOgMEEyU7oXjHqqBvP/uxBsT5Qp?=
 =?us-ascii?Q?EnnSEqR+CMIKlzSoJdqpQwe7pevEnyYgOsTgvOq3zY5AbdnqgDt+tT5ZQm9N?=
 =?us-ascii?Q?z+1WVBkIIeuZXLP99qhFEkGMBv1JcwFOxAIWjHdzunadKZvPzmaw92ZevhjP?=
 =?us-ascii?Q?fX3Z9uJqFww+m1ZeI8Ji2jM0MQ5T2MGfdYLxerx09AUN998+Tqqugqscxyek?=
 =?us-ascii?Q?yQ65S+dNJKzjJ+JxMJwGD4CZzHbY4f9nW08dPMJgd8Kj+Z3Fgmt8Yl9QwIF2?=
 =?us-ascii?Q?7yr5XeO8vY/+u9Z0FaLkTwL0C4OrRNf8pBGEzzvV0kYNjIJJQmEswUZSBPD+?=
 =?us-ascii?Q?XuSuefqhG1IhIdumxyaVQHmDCSiCU6Rcmwc1TMVO4EWqAe7Hoi9bRaxZGznU?=
 =?us-ascii?Q?bf4TdKs3fV8gJ2iUtT9BNN06xEAZYpwHKBcHaz815Q3OqibaH1m7j4p4xWQd?=
 =?us-ascii?Q?t5/2zQ9ioE/AAYybE8UarrJcGKKnDJ7vYuHmc0ggbSWVHks0c9YVvXQ0/fMs?=
 =?us-ascii?Q?vCSjnK0Gy+qMHkMImVIpy+EzSTvabVfM0LO3fZJ7svkQgzvA2XMnM3OFWHur?=
 =?us-ascii?Q?Ugf5p+15l86tz8IjZx3V1+z3+hOR/Bmat2cbBcxWhFDRktMi+t5N1PkHd6LH?=
 =?us-ascii?Q?zVRrOw3EqhuetLTODmx3sY80suUgo4lPXGIFRFBQaLFJu7gAgd30ci1CEdhl?=
 =?us-ascii?Q?dQTJtVUXaAZF4QaldSxJqDtfHzrw2Zg10eb7vdyrhXa559i1LTR37P4EvTnw?=
 =?us-ascii?Q?cUp4VVoKZ+ngcZsGfP3trKb9qadpl2sjo7j3VuXd/fGKc14p5FBcR//Fbjs8?=
 =?us-ascii?Q?k5/I/D8d4T9x4OHS8GE8xrVM2AtBKMykfG39dsyJw72oKq+Nzs1KNfZ1EL1g?=
 =?us-ascii?Q?YVPm8E0GVqu1WVc8pRoePHo78lyuxySGnP2zodVuh2fY2rrwfF9dv2cM5MMi?=
 =?us-ascii?Q?+xqGvfVHIZxv+XuF7aCKfn+k/9jWX7725BhTBzHRCbxGhLhtxaXcxpUUmgaj?=
 =?us-ascii?Q?3uBJEyiNhjy9ZC0NMieBkgan1XCSJ1NPSHgi/MBTom1WRfmjWId8NGnA7b/R?=
 =?us-ascii?Q?Ag/erhggZkqum4tCUtmEKlEjwvc1a2XcTDIaeO7/mQ5hDZL74BmZfG0RAJwo?=
 =?us-ascii?Q?JztlY7RLtIRimdENMad91H+o+IKh9kInNLmGezAMg/BEp8py0iVNBM2Abza7?=
 =?us-ascii?Q?0FNfKIeq+Y41y/GiowBQ2BDZfm56CsqwdVnu8XU1S72PF70v9K4UjMCuVw2B?=
 =?us-ascii?Q?XGK2/K8hzVjOCs/95NtzqxV2NIo3RG+rmDl74nvGv1b+gSF9P/nnCFInv24K?=
 =?us-ascii?Q?YgpLjNZL5A3piFWdACSAB1RnjdRrbBrdH9lbAGlLcc8aaEhitBk9x5T7ZBZO?=
 =?us-ascii?Q?BJiBcNlyur4oaptQGEVaU6rQMT0bf9SJlNkvvd87L6byyrQW3lfxvkRHOBEF?=
 =?us-ascii?Q?45bYw934WlnlUfibi2f2GxNY0UZXgAKU9d7hel99PENqBbqBJIAqhyXiG6Vs?=
 =?us-ascii?Q?dqcgIRQO6vFD4uxeOoWSBDEdyoyWtzq2lYVd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:54:32.7337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef115143-a591-4226-8a62-08dde9fe55e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9812
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

ti,tps546d24 is already described in DT binding and ti,tps546b24 should be
described in the same way that's why update compatible string to match
them.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 .../arm/dts/zynqmp-sc-vm-p-m1369-00-revA.dtso | 28 +++++++++----------
 .../arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso | 10 +++----
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm/dts/zynqmp-sc-vm-p-m1369-00-revA.dtso b/arch/arm/dts/zynqmp-sc-vm-p-m1369-00-revA.dtso
index 8412aecd726c..4d0f10e13c38 100644
--- a/arch/arm/dts/zynqmp-sc-vm-p-m1369-00-revA.dtso
+++ b/arch/arm/dts/zynqmp-sc-vm-p-m1369-00-revA.dtso
@@ -262,73 +262,73 @@
 
 	/* pmbus - j105 - disable main PMBUS - also going to j102 connector */
 	vcc_pslp: regulator@15 { /* u24 */
-		compatible = "ti,tps546b24a";
+		compatible = "ti,tps546b24";
 		reg = <0x15>;
 	};
 
 	vccaux_pmc: regulator@17 { /* u26 */
-		compatible = "ti,tps546b24a";
+		compatible = "ti,tps546b24";
 		reg = <0x17>;
 	};
 
 	vcco_500: regulator@18 { /* u27 */
-		compatible = "ti,tps546b24a";
+		compatible = "ti,tps546b24";
 		reg = <0x18>;
 	};
 
 	vcco_501: regulator@19 { /* u28 */
-		compatible = "ti,tps546b24a";
+		compatible = "ti,tps546b24";
 		reg = <0x19>;
 	};
 
 	vcco_502: regulator@1a { /* u29 */
-		compatible = "ti,tps546b24a";
+		compatible = "ti,tps546b24";
 		reg = <0x1a>;
 	};
 
 	vcco_503: regulator@1b { /* u30 */
-		compatible = "ti,tps546b24a";
+		compatible = "ti,tps546b24";
 		reg = <0x1b>;
 	};
 
 	vcc_ddr5_rdimm: regulator@1c { /* u31 */
-		compatible = "ti,tps546b24a";
+		compatible = "ti,tps546b24";
 		reg = <0x1c>;
 	};
 
 	gtm_avcc: regulator@22 { /* u37 */
-		compatible = "ti,tps546b24a";
+		compatible = "ti,tps546b24";
 		reg = <0x22>;
 	};
 
 	gtm_avtt: regulator@20 { /* u38 */
-		compatible = "ti,tps546b24a";
+		compatible = "ti,tps546b24";
 		reg = <0x20>;
 	};
 
 	gtm_avccaux: regulator@21 { /* u39 */
-		compatible = "ti,tps546b24a";
+		compatible = "ti,tps546b24";
 		reg = <0x21>;
 	};
 
 	vccint_gt: regulator@2a { /* u44 */
-		compatible = "ti,tps546b24a";
+		compatible = "ti,tps546b24";
 		reg = <0x2a>;
 	};
 
 	util_1v8: regulator@2b { /* u1839 */
-		compatible = "ti,tps546b24a";
+		compatible = "ti,tps546b24";
 		reg = <0x2b>;
 	};
 
 	vcc_pmc: regulator@2c { /* u46 */
-		compatible = "ti,tps546b24a";
+		compatible = "ti,tps546b24";
 		reg = <0x2c>;
 	};
 
 	/* pmbus via U62 as ext_pmbus - disable via j104 */
 	vccint: regulator@10 { /* u18 */
-		compatible = "ti,tps546b24";
+		compatible = "ti,tps546d24";
 		reg = <0x10>;
 	};
 
diff --git a/arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso b/arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso
index ce1832127156..c1945ea6f8d1 100644
--- a/arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso
+++ b/arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso
@@ -356,7 +356,7 @@
 	};
 
 	vcco_503: regulator@12 { /* u1744 */
-		compatible = "ti,tps546b24a";
+		compatible = "ti,tps546b24";
 		reg = <0x12>;
 	};
 
@@ -414,17 +414,17 @@
 	};
 
 	vcco_500: regulator@13 { /* u1738 */
-		compatible = "ti,tps546b24a";
+		compatible = "ti,tps546b24";
 		reg = <0x13>;
 	};
 
 	vcco_501: regulator@10 { /* u1740 */
-		compatible = "ti,tps546b24a";
+		compatible = "ti,tps546b24";
 		reg = <0x10>;
 	};
 
 	vcco_502: regulator@11 { /* u1742 */
-		compatible = "ti,tps546b24a";
+		compatible = "ti,tps546b24";
 		reg = <0x11>;
 	};
 
@@ -454,7 +454,7 @@
 	};
 
 	lp5_vddq_0v5: regulator@14 { /* u1763 - FIXME no ina226 */
-		compatible = "ti,tps546b24a";
+		compatible = "ti,tps546b24";
 		reg = <0x14>;
 	};
 };
-- 
2.43.0

