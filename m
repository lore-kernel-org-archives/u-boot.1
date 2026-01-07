Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01562CD585E
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 12:13:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C9E183B82;
	Wed,  7 Jan 2026 13:13:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="me48NxJ5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EAB383B86; Wed,  7 Jan 2026 13:13:29 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B046839E4
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 13:13:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPTCHUMMu0m12peOTAH5vYW5hgJsFsqPRd1WpHkpXOUfWNcQf5qNuYAh8uuPmG4ILensqiBp9Z5rA6ngc0iu0vykt5gOKiVI77MhcZeGYZnOEbJ5LO2AGeJrT36mhiGkcpYZdDcdaUvG82Zei9QDOzCbPZzFwPKAlTkJKXiW2+/sQ7I9LAvLMAdGlD+8u730gf4iKL3+YKAh634PTQkqSgWlyY4cX1gDkOl2Okdp0x6BxV2TV0zX8BoErXDiTTvh4WbARHgxUAVBr4+eLF8SFP0KgmVJPP/xBy2X5WyN0YW8FjwDoUsWXEQrwfiTaysPT3i29dYz//09zzrLw6J6uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKKgQpIMxorCzJf8neFBcuci0nd16AUOEn8hmm+m9KM=;
 b=ZhhjftdI5Du0lAwcyfAKOjwG1OK57fcBrvzmUfRyfFsQp5nC0vGbz3QDqoHqShdNxMA8NsZhrDXkxES1vBLxFcU71bfaWsfBS2uPOKCEakUjDdmsEzKPqKZjUEqdy7ip4qEUQy67lXpPNAec3bgcpOxIipkt/Cxu6fthW7jk30WWUTo9WRQt2Mp7vTGUWFEiFKIhbxiPM4PDpOaGgO/gejaDwzSTAk3CYpNL9H/LKIeQD6Eb5FA+eg4UHgcV9+wWp7zMkK8XMRw1SzzsUAdt3u1AvWCf61vnWNjCwgjSZ2wT+uzUol/BkWZZhDrwrMbi6AAI5noiGlnh1bsVW1sd9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKKgQpIMxorCzJf8neFBcuci0nd16AUOEn8hmm+m9KM=;
 b=me48NxJ5gDPeL67LMsQAHvxmumuCl6XSYsDtCe37vWd7AgmnRE18DGVQneasPxAqyJq3AlAZk4p0DMhkTDgrtKv0oaEcz16QidLn7jl/yz5Axe4VfrQUqXXYzoeyDHEz0rxUir6pbPH2wujlZ5yilaLon6kucsqqBfd5DGHywys=
Received: from DS7PR06CA0040.namprd06.prod.outlook.com (2603:10b6:8:54::28) by
 PH8PR12MB6818.namprd12.prod.outlook.com (2603:10b6:510:1c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 12:13:18 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:8:54:cafe::d6) by DS7PR06CA0040.outlook.office365.com
 (2603:10b6:8:54::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Wed, 7
 Jan 2026 12:13:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 12:13:17 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 06:13:01 -0600
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 7 Jan 2026 04:13:01 -0800
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Jonathan Stroud <jonathan.stroud@amd.com>, Nithish Kumar Naroju
 <nithishkumar.naroju@amd.com>, Radhey Shyam Pandey
 <radhey.shyam.pandey@amd.com>, Rohit Visavalia <rohit.visavalia@amd.com>,
 "Tom Rini" <trini@konsulko.com>
Subject: [PATCH 2/2] arm64: xilinx: Fix DT coding style violations
Date: Wed, 7 Jan 2026 13:12:49 +0100
Message-ID: <f1811d2e9303bb63ddfa809cbebf2a7fa52afa0d.1767787961.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <138720bf2ff976974f5ce3566446ecfd93b9259d.1767787961.git.michal.simek@amd.com>
References: <138720bf2ff976974f5ce3566446ecfd93b9259d.1767787961.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=23466; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=SifIYCKL7ejN4CUi6ztVsXGoxtiWiA6/SKSk8fjxAtc=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTG+R66GPczwlboruC5D1VyWVneusyXXnbU7J/pmtX8I
 q9P4s6rjlIWBjEOBlkxRZbpTDoOa75dWyq2PDIfZg4rE8gQBi5OAZjIgxJGht3twb/3V19z+sAr
 8FSKwdiT5fOnfP71TpaX1sS+rta89o/hr9Rknm7Lf0aMWr1qZjULHjxyjWy6tPoo64J43qNKJYe
 OMgIA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|PH8PR12MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: 59c03cb2-6794-4d45-4540-08de4de623e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KgurGplGZh6HzrPQQ4a7heLIEHk+YNyGS8PjIFar/5yp2ZUHfu+sPQh6YKph?=
 =?us-ascii?Q?N3PzEKYYXVo/UqimvCyUzUv7MtHaENnBKiKbQ/XP7KipGWxgZLygaR57ycLC?=
 =?us-ascii?Q?TtM/iaJhwKK3CUUsseiyQcNlTcnciuFDOcDPnqxkNnG3XpGdvXWqYz/kk8UX?=
 =?us-ascii?Q?Ju94NQpZFU+bEE4VYeRzsg+BK8LtmZ42B3FJbYJPi1cvomcbmcZWnGqfZvd+?=
 =?us-ascii?Q?Zyj4q749VOq6qjRJMHJek6U5hOsM6u5ci7rgDffCi/tZW14yx2weo57SzcYK?=
 =?us-ascii?Q?yd6Mz0PPpMpFPHowpi/Nxl6St+G7ltwUyy84sJHeplZh4ss6OHpo0t3TTl+S?=
 =?us-ascii?Q?l3X9FSKd706Tm7TeiiNFDBQX7Rnkha1aKnqyw6V6xC1odzihtgLtR86lX25I?=
 =?us-ascii?Q?W9EPURoSWOuNlS45ElbYLb7mKn58wdhTexZG9izT3OIfAx+RHa4+lBltB7Mc?=
 =?us-ascii?Q?pRIItL4M653anrx1wEi6USVhwDmZZBaEEcSa4raevLaGkZktnegpRg8jNlE2?=
 =?us-ascii?Q?hE60RSQYHqjQphE7bJ1+91gan308fxWBWMVE/r1U77jglPhrWNtWFIyQU+CG?=
 =?us-ascii?Q?qfm0sM0u4JvZfnRsk7Cpey6tioCYd5it+ZnWjAylEpFIBtA8iwR4e7UlgvR8?=
 =?us-ascii?Q?vM9wWHPT2d63GE0he/zWN31r3AIBXPvp4OFX3Vn4Cfyd92VZ8ZkPJZJ+BHqO?=
 =?us-ascii?Q?IMikF5tKpKDro7pS7wICf8gKxOrElLTAFxTFfaDwf3KHoaFCCfsdnpvw2QKd?=
 =?us-ascii?Q?Pb72L3VzqLvSk7LKXFsduu8khyn6MxAWkf3EfNHVIfKbH1C98Jbd0tKU5ByR?=
 =?us-ascii?Q?TZRX1FjTaJRCT6JicO5HI8+Dh6i0NmCpAF7RzfTLhZmuOoAd6TKayZregJ11?=
 =?us-ascii?Q?QlU80DqM+gspsyIgwTFBDAOsJ+dRHP4g9Brqe0zKfxg79fs1CfrGxlffWovs?=
 =?us-ascii?Q?YzoVWGvCZKkXHtXyyMu/GyzZL1nlw8uR3InqGAmSV5CcGBsCvEfH5J2YeFfY?=
 =?us-ascii?Q?qJoTHqJNY9WLNWRtZwrFs/pVUdiuPMQaRdSMPFptc9Dg0JFtkQu2qSYTjaix?=
 =?us-ascii?Q?agbTgDPaHQheNjt6Pbn+1Kn9+/+TDAR01I1B7XH/YwOR8po7IBcEdOfvdnPo?=
 =?us-ascii?Q?FA8qk+E3xIeZ/qNAiad+r9Ei14OGvNS+2nF4RVtpa6LdfAZz8hBTpFqIjBok?=
 =?us-ascii?Q?GA7xHB/VKcuQs5AZe4CT/L+uFDtetx66HrGy6kAwDpPVzcJWVXnjWWpurI4K?=
 =?us-ascii?Q?ZOssiXZeFqM/fnkxINke8D4yyRyQkkQQVQNkfF3C+S8jnae8u6Gc3tDccXA1?=
 =?us-ascii?Q?WpIm1bB+zU6jsLiSmHW/vavB/7EEjp/AwVMRKvbSBJ+b2XPcY30+gXv72N4Z?=
 =?us-ascii?Q?KWF0siVRTNIcnDWrN8KHBO3j0tzPqfFYWxqjYbyvBG3ji6bfFWhfL/aFduQG?=
 =?us-ascii?Q?uDoXNFKrsc2D27bed5+Pf3oPV6sBOgTxqq0mYrkqyGt1E6DzljSKnHp7WYxG?=
 =?us-ascii?Q?Qyxo4KfpYG7DMTe67J3vSbpEUAn4fIc35KYzDj1oXGfi7lTq5yK5rs3P2uH6?=
 =?us-ascii?Q?7QjTNvZRibFRvHujrvc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 12:13:17.2302 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c03cb2-6794-4d45-4540-08de4de623e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6818
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

All these violations have been found by https://github.com/kylebonnici/dts-linter
but not all of them are taken. Adding newlines or long lines changes are
not taken.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-dlc21-revA.dts       |  8 ++++----
 arch/arm/dts/zynqmp-e-a2197-00-revA.dts  |  4 ++--
 arch/arm/dts/zynqmp-g-a2197-00-revA.dts  |  2 +-
 arch/arm/dts/zynqmp-m-a2197-01-revA.dts  | 13 +++++++------
 arch/arm/dts/zynqmp-m-a2197-02-revA.dts  | 11 ++++++-----
 arch/arm/dts/zynqmp-m-a2197-03-revA.dts  | 11 ++++++-----
 arch/arm/dts/zynqmp-p-a2197-00-revA.dts  |  8 ++++----
 arch/arm/dts/zynqmp-sc-revB.dts          | 20 ++++++++++----------
 arch/arm/dts/zynqmp-vpk120-revA.dts      |  1 -
 arch/arm/dts/zynqmp-zc1232-revA.dts      |  2 +-
 arch/arm/dts/zynqmp-zc1254-revA.dts      |  2 +-
 arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts |  2 +-
 arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts |  8 ++++----
 arch/arm/dts/zynqmp-zc1751-xm018-dc4.dts |  2 +-
 arch/arm/dts/zynqmp-zcu102-revA.dts      |  2 +-
 arch/arm/dts/zynqmp-zcu104-revA.dts      |  2 +-
 arch/arm/dts/zynqmp-zcu104-revC.dts      |  2 +-
 arch/arm/dts/zynqmp-zcu106-revA.dts      |  2 +-
 arch/arm/dts/zynqmp-zcu111-revA.dts      |  2 +-
 arch/arm/dts/zynqmp-zcu1275-revA.dts     |  2 +-
 arch/arm/dts/zynqmp-zcu1275-revB.dts     |  2 +-
 arch/arm/dts/zynqmp-zcu1285-revA.dts     |  2 --
 arch/arm/dts/zynqmp-zcu208-revA.dts      | 22 ++++++++++++----------
 arch/arm/dts/zynqmp-zcu216-revA.dts      | 22 ++++++++++++----------
 arch/arm/dts/zynqmp-zcu670-revA.dts      | 18 +++++++++++-------
 arch/arm/dts/zynqmp-zcu670-revB.dts      | 18 +++++++++++-------
 26 files changed, 101 insertions(+), 89 deletions(-)

diff --git a/arch/arm/dts/zynqmp-dlc21-revA.dts b/arch/arm/dts/zynqmp-dlc21-revA.dts
index d540f334f511..d48b6f3a8ec8 100644
--- a/arch/arm/dts/zynqmp-dlc21-revA.dts
+++ b/arch/arm/dts/zynqmp-dlc21-revA.dts
@@ -176,12 +176,12 @@
 };
 
 &dwc3_1 {
-	/delete-property/ phy-names ;
-	/delete-property/ phys ;
+	/delete-property/ phy-names;
+	/delete-property/ phys;
 	dr_mode = "host";
 	maximum-speed = "high-speed";
-	snps,dis_u2_susphy_quirk ;
-	snps,dis_u3_susphy_quirk ;
+	snps,dis_u2_susphy_quirk;
+	snps,dis_u3_susphy_quirk;
 	status = "okay";
 };
 
diff --git a/arch/arm/dts/zynqmp-e-a2197-00-revA.dts b/arch/arm/dts/zynqmp-e-a2197-00-revA.dts
index 6e2d9542012a..aebceb207369 100644
--- a/arch/arm/dts/zynqmp-e-a2197-00-revA.dts
+++ b/arch/arm/dts/zynqmp-e-a2197-00-revA.dts
@@ -107,7 +107,8 @@
 	};
 	ina226-vcc-1v2-ddr4 {
 		compatible = "iio-hwmon";
-		io-channels = <&vcc_1v2_ddr4 0>, <&vcc_1v2_ddr4 1>, <&vcc_1v2_ddr4 2>, <&vcc_1v2_ddr4 3>;
+		io-channels = <&vcc_1v2_ddr4 0>, <&vcc_1v2_ddr4 1>, <&vcc_1v2_ddr4 2>,
+			      <&vcc_1v2_ddr4 3>;
 	};
 	ina226-vcc-1v1-lp4 {
 		compatible = "iio-hwmon";
@@ -465,7 +466,6 @@
 				clock-output-names = "si570_user1";
 				silabs,skip-recall;
 			};
-
 		};
 		i2c@7 { /* USER_SI570_2 */
 			#address-cells = <1>;
diff --git a/arch/arm/dts/zynqmp-g-a2197-00-revA.dts b/arch/arm/dts/zynqmp-g-a2197-00-revA.dts
index 27ea639b7417..7c9764c31f7a 100644
--- a/arch/arm/dts/zynqmp-g-a2197-00-revA.dts
+++ b/arch/arm/dts/zynqmp-g-a2197-00-revA.dts
@@ -89,7 +89,7 @@
 		phy0: ethernet-phy@0 { /* marwell m88e1512 */
 			reg = <0>;
 			reset-gpios = <&gpio 42 GPIO_ACTIVE_LOW>;
-/*		xlnx,phy-type = <PHY_TYPE_SGMII>; */
+			/* xlnx,phy-type = <PHY_TYPE_SGMII>; */
 		};
 	};
 };
diff --git a/arch/arm/dts/zynqmp-m-a2197-01-revA.dts b/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
index ece01e73d29f..f9d7528ff2ed 100644
--- a/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
@@ -61,7 +61,8 @@
 	};
 	ina226-vdd1-1v8-lp4 {
 		compatible = "iio-hwmon";
-		io-channels = <&vdd1_1v8_lp4 0>, <&vdd1_1v8_lp4 1>, <&vdd1_1v8_lp4 2>, <&vdd1_1v8_lp4 3>;
+		io-channels = <&vdd1_1v8_lp4 0>, <&vdd1_1v8_lp4 1>, <&vdd1_1v8_lp4 2>,
+			      <&vdd1_1v8_lp4 3>;
 	};
 	ina226-vcc0v6-lp4 {
 		compatible = "iio-hwmon";
@@ -120,7 +121,7 @@
 		reset-gpios = <&gpio 142 GPIO_ACTIVE_LOW>;
 		phy0: ethernet-phy@0 { /* marwell m88e1512 - SGMII */
 			reg = <0>;
-/*		xlnx,phy-type = <PHY_TYPE_SGMII>; */
+			/* xlnx,phy-type = <PHY_TYPE_SGMII>; */
 		};
 	};
 };
@@ -483,10 +484,10 @@
 };
 
 &dwc3_1 {
-	/delete-property/ phy-names ;
-	/delete-property/ phys ;
+	/delete-property/ phy-names;
+	/delete-property/ phys;
 	maximum-speed = "high-speed";
-	snps,dis_u2_susphy_quirk ;
-	snps,dis_u3_susphy_quirk ;
+	snps,dis_u2_susphy_quirk;
+	snps,dis_u3_susphy_quirk;
 	status = "disabled";
 };
diff --git a/arch/arm/dts/zynqmp-m-a2197-02-revA.dts b/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
index 021fdce4abba..b4da0d341c39 100644
--- a/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
@@ -61,7 +61,8 @@
 	};
 	ina226-vdd1-1v8-lp4 {
 		compatible = "iio-hwmon";
-		io-channels = <&vdd1_1v8_lp4 0>, <&vdd1_1v8_lp4 1>, <&vdd1_1v8_lp4 2>, <&vdd1_1v8_lp4 3>;
+		io-channels = <&vdd1_1v8_lp4 0>, <&vdd1_1v8_lp4 1>, <&vdd1_1v8_lp4 2>,
+			      <&vdd1_1v8_lp4 3>;
 	};
 };
 
@@ -485,10 +486,10 @@
 };
 
 &dwc3_1 {
-	/delete-property/ phy-names ;
-	/delete-property/ phys ;
+	/delete-property/ phy-names;
+	/delete-property/ phys;
 	maximum-speed = "high-speed";
-	snps,dis_u2_susphy_quirk ;
-	snps,dis_u3_susphy_quirk ;
+	snps,dis_u2_susphy_quirk;
+	snps,dis_u3_susphy_quirk;
 	status = "disabled";
 };
diff --git a/arch/arm/dts/zynqmp-m-a2197-03-revA.dts b/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
index c45822e1423a..729efd4098cb 100644
--- a/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
@@ -61,7 +61,8 @@
 	};
 	ina226-vdd1-1v8-lp4 {
 		compatible = "iio-hwmon";
-		io-channels = <&vdd1_1v8_lp4 0>, <&vdd1_1v8_lp4 1>, <&vdd1_1v8_lp4 2>, <&vdd1_1v8_lp4 3>;
+		io-channels = <&vdd1_1v8_lp4 0>, <&vdd1_1v8_lp4 1>, <&vdd1_1v8_lp4 2>,
+			      <&vdd1_1v8_lp4 3>;
 	};
 };
 
@@ -479,10 +480,10 @@
 };
 
 &dwc3_1 {
-	/delete-property/ phy-names ;
-	/delete-property/ phys ;
+	/delete-property/ phy-names;
+	/delete-property/ phys;
 	maximum-speed = "high-speed";
-	snps,dis_u2_susphy_quirk ;
-	snps,dis_u3_susphy_quirk ;
+	snps,dis_u2_susphy_quirk;
+	snps,dis_u3_susphy_quirk;
 	status = "disabled";
 };
diff --git a/arch/arm/dts/zynqmp-p-a2197-00-revA.dts b/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
index 6aae2ad642d5..60bab4078057 100644
--- a/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
+++ b/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
@@ -558,12 +558,12 @@
 };
 
 &dwc3_1 {
-	/delete-property/ phy-names ;
-	/delete-property/ phys ;
+	/delete-property/ phy-names;
+	/delete-property/ phys;
 	dr_mode = "host";
 	maximum-speed = "high-speed";
-	snps,dis_u2_susphy_quirk ;
-	snps,dis_u3_susphy_quirk ;
+	snps,dis_u2_susphy_quirk;
+	snps,dis_u3_susphy_quirk;
 	status = "okay";
 };
 
diff --git a/arch/arm/dts/zynqmp-sc-revB.dts b/arch/arm/dts/zynqmp-sc-revB.dts
index 6f5856017bf3..6181072c1da1 100644
--- a/arch/arm/dts/zynqmp-sc-revB.dts
+++ b/arch/arm/dts/zynqmp-sc-revB.dts
@@ -222,35 +222,35 @@
 		};
 		partition@140000 {
 			label = "Open_1";
-			reg = <0x140000 0xC0000>; /* 768KB */
+			reg = <0x140000 0xc0000>; /* 768KB */
 		};
 		partition@200000 {
 			label = "Image A (FSBL, PMU, ATF, U-Boot)";
-			reg = <0x200000 0xD00000>; /* 13MB */
+			reg = <0x200000 0xd00000>; /* 13MB */
 		};
 		partition@f00000 {
 			label = "ImgSel Image A Catch";
-			reg = <0xF00000 0x80000>; /* 512KB */
+			reg = <0xf00000 0x80000>; /* 512KB */
 			read-only;
 			lock;
 		};
 		partition@f80000 {
 			label = "Image B (FSBL, PMU, ATF, U-Boot)";
-			reg = <0xF80000 0xD00000>; /* 13MB */
+			reg = <0xf80000 0xd00000>; /* 13MB */
 		};
 		partition@1c80000 {
 			label = "ImgSel Image B Catch";
-			reg = <0x1C80000 0x80000>; /* 512KB */
+			reg = <0x1c80000 0x80000>; /* 512KB */
 			read-only;
 			lock;
 		};
 		partition@1d00000 {
 			label = "Open_2";
-			reg = <0x1D00000 0x100000>; /* 1MB */
+			reg = <0x1d00000 0x100000>; /* 1MB */
 		};
 		partition@1e00000 {
 			label = "Recovery Image";
-			reg = <0x1E00000 0x200000>; /* 2MB */
+			reg = <0x1e00000 0x200000>; /* 2MB */
 			read-only;
 			lock;
 		};
@@ -278,9 +278,9 @@
 			label = "Secure OS Storage";
 			reg = <0x2280000 0x20000>; /* 128KB */
 		};
-		partition@22A0000 {
+		partition@22a0000 {
 			label = "User";
-			reg = <0x22A0000 0x1d60000>; /* 29.375 MB */
+			reg = <0x22a0000 0x1d60000>; /* 29.375 MB */
 		};
 	};
 };
@@ -409,7 +409,7 @@
 
 		conf-tx {
 			pins = "MIO38", "MIO39", "MIO40",
-				"MIO41", "MIO42", "MIO43";
+			       "MIO41", "MIO42", "MIO43";
 			bias-disable;
 			low-power-enable;
 		};
diff --git a/arch/arm/dts/zynqmp-vpk120-revA.dts b/arch/arm/dts/zynqmp-vpk120-revA.dts
index f281c7fb9fdd..bd1e25571870 100644
--- a/arch/arm/dts/zynqmp-vpk120-revA.dts
+++ b/arch/arm/dts/zynqmp-vpk120-revA.dts
@@ -375,7 +375,6 @@
 				clock-frequency = <100000000>;
 				clock-output-names = "fmc_si570";
 			};
-
 		};
 		/* 7 unused */
 	};
diff --git a/arch/arm/dts/zynqmp-zc1232-revA.dts b/arch/arm/dts/zynqmp-zc1232-revA.dts
index a288029797b6..9dcb90953712 100644
--- a/arch/arm/dts/zynqmp-zc1232-revA.dts
+++ b/arch/arm/dts/zynqmp-zc1232-revA.dts
@@ -61,7 +61,7 @@
 		};
 		partition@620000 { /* for testing purpose */
 			label = "qspi-rootfs";
-			reg = <0x620000 0x5E0000>;
+			reg = <0x620000 0x5e0000>;
 		};
 	};
 };
diff --git a/arch/arm/dts/zynqmp-zc1254-revA.dts b/arch/arm/dts/zynqmp-zc1254-revA.dts
index cb9ef3746803..cf3e95832040 100644
--- a/arch/arm/dts/zynqmp-zc1254-revA.dts
+++ b/arch/arm/dts/zynqmp-zc1254-revA.dts
@@ -62,7 +62,7 @@
 		};
 		partition@620000 { /* for testing purpose */
 			label = "qspi-rootfs";
-			reg = <0x620000 0x5E0000>;
+			reg = <0x620000 0x5e0000>;
 		};
 	};
 };
diff --git a/arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts b/arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts
index 27b38e981a05..32f317f3df40 100644
--- a/arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts
+++ b/arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts
@@ -378,7 +378,7 @@
 		};
 		partition@620000 { /* for testing purpose */
 			label = "qspi-rootfs";
-			reg = <0x620000 0x5E0000>;
+			reg = <0x620000 0x5e0000>;
 		};
 	};
 };
diff --git a/arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts b/arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts
index e187818f333f..a8856c20f5b5 100644
--- a/arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts
+++ b/arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts
@@ -156,7 +156,7 @@
 		};
 		partition@3 {	/* for testing purpose */
 			label = "nand-rootfs";
-			reg = <0x0 0x1C00000 0x1400000>;
+			reg = <0x0 0x1c00000 0x1400000>;
 		};
 		partition@4 {	/* for testing purpose */
 			label = "nand-bitstream";
@@ -164,7 +164,7 @@
 		};
 		partition@5 {	/* for testing purpose */
 			label = "nand-misc";
-			reg = <0x0 0x3400000 0xFCC00000>;
+			reg = <0x0 0x3400000 0xfcc00000>;
 		};
 	};
 	nand@1 {
@@ -192,7 +192,7 @@
 		};
 		partition@3 {	/* for testing purpose */
 			label = "nand1-rootfs";
-			reg = <0x0 0x1C00000 0x1400000>;
+			reg = <0x0 0x1c00000 0x1400000>;
 		};
 		partition@4 {	/* for testing purpose */
 			label = "nand1-bitstream";
@@ -200,7 +200,7 @@
 		};
 		partition@5 {	/* for testing purpose */
 			label = "nand1-misc";
-			reg = <0x0 0x3400000 0xFCC00000>;
+			reg = <0x0 0x3400000 0xfcc00000>;
 		};
 	};
 };
diff --git a/arch/arm/dts/zynqmp-zc1751-xm018-dc4.dts b/arch/arm/dts/zynqmp-zc1751-xm018-dc4.dts
index 2b66abc9f7e6..3b03b39e456a 100644
--- a/arch/arm/dts/zynqmp-zc1751-xm018-dc4.dts
+++ b/arch/arm/dts/zynqmp-zc1751-xm018-dc4.dts
@@ -194,7 +194,7 @@
 		};
 		partition@620000 { /* for testing purpose */
 			label = "qspi-rootfs";
-			reg = <0x620000 0x5E0000>;
+			reg = <0x620000 0x5e0000>;
 		};
 	};
 };
diff --git a/arch/arm/dts/zynqmp-zcu102-revA.dts b/arch/arm/dts/zynqmp-zcu102-revA.dts
index 7fa77b59906e..6b1aea95e65a 100644
--- a/arch/arm/dts/zynqmp-zcu102-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu102-revA.dts
@@ -1008,7 +1008,7 @@
 		};
 		partition@620000 { /* for testing purpose */
 			label = "qspi-rootfs";
-			reg = <0x620000 0x5E0000>;
+			reg = <0x620000 0x5e0000>;
 		};
 	};
 };
diff --git a/arch/arm/dts/zynqmp-zcu104-revA.dts b/arch/arm/dts/zynqmp-zcu104-revA.dts
index 135bfa080828..0bfeed4293cb 100644
--- a/arch/arm/dts/zynqmp-zcu104-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu104-revA.dts
@@ -473,7 +473,7 @@
 		};
 		partition@620000 { /* for testing purpose */
 			label = "qspi-rootfs";
-			reg = <0x620000 0x5E0000>;
+			reg = <0x620000 0x5e0000>;
 		};
 	};
 };
diff --git a/arch/arm/dts/zynqmp-zcu104-revC.dts b/arch/arm/dts/zynqmp-zcu104-revC.dts
index 20d17a07e7eb..a7387f4a0e6f 100644
--- a/arch/arm/dts/zynqmp-zcu104-revC.dts
+++ b/arch/arm/dts/zynqmp-zcu104-revC.dts
@@ -485,7 +485,7 @@
 		};
 		partition@620000 { /* for testing purpose */
 			label = "qspi-rootfs";
-			reg = <0x620000 0x5E0000>;
+			reg = <0x620000 0x5e0000>;
 		};
 	};
 };
diff --git a/arch/arm/dts/zynqmp-zcu106-revA.dts b/arch/arm/dts/zynqmp-zcu106-revA.dts
index 1ec95c67a7d1..7b1097579fc2 100644
--- a/arch/arm/dts/zynqmp-zcu106-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu106-revA.dts
@@ -1002,7 +1002,7 @@
 		};
 		partition@620000 { /* for testing purpose */
 			label = "qspi-rootfs";
-			reg = <0x620000 0x5E0000>;
+			reg = <0x620000 0x5e0000>;
 		};
 	};
 };
diff --git a/arch/arm/dts/zynqmp-zcu111-revA.dts b/arch/arm/dts/zynqmp-zcu111-revA.dts
index cfb4f6487675..ba1b63391005 100644
--- a/arch/arm/dts/zynqmp-zcu111-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu111-revA.dts
@@ -825,7 +825,7 @@
 		};
 		partition@620000 { /* for testing purpose */
 			label = "qspi-rootfs";
-			reg = <0x620000 0x5E0000>;
+			reg = <0x620000 0x5e0000>;
 		};
 	};
 };
diff --git a/arch/arm/dts/zynqmp-zcu1275-revA.dts b/arch/arm/dts/zynqmp-zcu1275-revA.dts
index b75b2a796eb3..cc9f5b160254 100644
--- a/arch/arm/dts/zynqmp-zcu1275-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu1275-revA.dts
@@ -66,7 +66,7 @@
 		};
 		partition@620000 { /* for testing purpose */
 			label = "qspi-rootfs";
-			reg = <0x620000 0x5E0000>;
+			reg = <0x620000 0x5e0000>;
 		};
 	};
 };
diff --git a/arch/arm/dts/zynqmp-zcu1275-revB.dts b/arch/arm/dts/zynqmp-zcu1275-revB.dts
index ed83ba327916..f78da0362800 100644
--- a/arch/arm/dts/zynqmp-zcu1275-revB.dts
+++ b/arch/arm/dts/zynqmp-zcu1275-revB.dts
@@ -93,7 +93,7 @@
 		};
 		partition@620000 { /* for testing purpose */
 			label = "qspi-rootfs";
-			reg = <0x620000 0x5E0000>;
+			reg = <0x620000 0x5e0000>;
 		};
 	};
 };
diff --git a/arch/arm/dts/zynqmp-zcu1285-revA.dts b/arch/arm/dts/zynqmp-zcu1285-revA.dts
index 38735b1ce1ac..86a3217f9ab6 100644
--- a/arch/arm/dts/zynqmp-zcu1285-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu1285-revA.dts
@@ -36,7 +36,6 @@
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
-
 };
 
 &dcc {
@@ -46,7 +45,6 @@
 &i2c0 {
 	status = "okay";
 	clock-frequency = <400000>;
-
 };
 
 &gem1 {
diff --git a/arch/arm/dts/zynqmp-zcu208-revA.dts b/arch/arm/dts/zynqmp-zcu208-revA.dts
index 88536e917d96..888f711aad97 100644
--- a/arch/arm/dts/zynqmp-zcu208-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu208-revA.dts
@@ -70,7 +70,8 @@
 	};
 	ina226-vccint-io-bram {
 		compatible = "iio-hwmon";
-		io-channels = <&vccint_io_bram_ps 0>, <&vccint_io_bram_ps 1>, <&vccint_io_bram_ps 2>, <&vccint_io_bram_ps 3>;
+		io-channels = <&vccint_io_bram_ps 0>, <&vccint_io_bram_ps 1>,
+			      <&vccint_io_bram_ps 2>, <&vccint_io_bram_ps 3>;
 	};
 	ina226-vcc1v8 {
 		compatible = "iio-hwmon";
@@ -106,7 +107,8 @@
 	};
 	ina226-dac-avccaux {
 		compatible = "iio-hwmon";
-		io-channels = <&dac_avccaux 0>, <&dac_avccaux 1>, <&dac_avccaux 2>, <&dac_avccaux 3>;
+		io-channels = <&dac_avccaux 0>, <&dac_avccaux 1>, <&dac_avccaux 2>,
+			      <&dac_avccaux 3>;
 	};
 	ina226-adc-avcc {
 		compatible = "iio-hwmon";
@@ -114,7 +116,8 @@
 	};
 	ina226-adc-avccaux {
 		compatible = "iio-hwmon";
-		io-channels = <&adc_avccaux 0>, <&adc_avccaux 1>, <&adc_avccaux 2>, <&adc_avccaux 3>;
+		io-channels = <&adc_avccaux 0>, <&adc_avccaux 1>, <&adc_avccaux 2>,
+			      <&adc_avccaux 3>;
 	};
 	ina226-dac-avcc {
 		compatible = "iio-hwmon";
@@ -379,7 +382,6 @@
 				reg = <0x45>; /* i2c addr 0x15 */
 			};
 			/* J21 header too */
-
 		};
 		i2c@3 {
 			#address-cells = <1>;
@@ -671,13 +673,13 @@
 	status = "okay";
 	/* SATA OOB timing settings */
 	ceva,p0-cominit-params = /bits/ 8 <0x18 0x40 0x18 0x28>;
-	ceva,p0-comwake-params = /bits/ 8 <0x06 0x14 0x08 0x0E>;
-	ceva,p0-burst-params = /bits/ 8 <0x13 0x08 0x4A 0x06>;
-	ceva,p0-retry-params = /bits/ 16 <0x96A4 0x3FFC>;
+	ceva,p0-comwake-params = /bits/ 8 <0x06 0x14 0x08 0x0e>;
+	ceva,p0-burst-params = /bits/ 8 <0x13 0x08 0x4a 0x06>;
+	ceva,p0-retry-params = /bits/ 16 <0x96a4 0x3ffc>;
 	ceva,p1-cominit-params = /bits/ 8 <0x18 0x40 0x18 0x28>;
-	ceva,p1-comwake-params = /bits/ 8 <0x06 0x14 0x08 0x0E>;
-	ceva,p1-burst-params = /bits/ 8 <0x13 0x08 0x4A 0x06>;
-	ceva,p1-retry-params = /bits/ 16 <0x96A4 0x3FFC>;
+	ceva,p1-comwake-params = /bits/ 8 <0x06 0x14 0x08 0x0e>;
+	ceva,p1-burst-params = /bits/ 8 <0x13 0x08 0x4a 0x06>;
+	ceva,p1-retry-params = /bits/ 16 <0x96a4 0x3ffc>;
 	phy-names = "sata-phy";
 	phys = <&psgtr 3 PHY_TYPE_SATA 1 3>;
 };
diff --git a/arch/arm/dts/zynqmp-zcu216-revA.dts b/arch/arm/dts/zynqmp-zcu216-revA.dts
index 29087aa7cb91..ccdbf8967aa0 100644
--- a/arch/arm/dts/zynqmp-zcu216-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu216-revA.dts
@@ -70,7 +70,8 @@
 	};
 	ina226-vccint-io-bram {
 		compatible = "iio-hwmon";
-		io-channels = <&vccint_io_bram_ps 0>, <&vccint_io_bram_ps 1>, <&vccint_io_bram_ps 2>, <&vccint_io_bram_ps 3>;
+		io-channels = <&vccint_io_bram_ps 0>, <&vccint_io_bram_ps 1>,
+			      <&vccint_io_bram_ps 2>, <&vccint_io_bram_ps 3>;
 	};
 	ina226-vcc1v8 {
 		compatible = "iio-hwmon";
@@ -106,7 +107,8 @@
 	};
 	ina226-dac-avccaux {
 		compatible = "iio-hwmon";
-		io-channels = <&dac_avccaux 0>, <&dac_avccaux 1>, <&dac_avccaux 2>, <&dac_avccaux 3>;
+		io-channels = <&dac_avccaux 0>, <&dac_avccaux 1>, <&dac_avccaux 2>,
+			      <&dac_avccaux 3>;
 	};
 	ina226-adc-avcc {
 		compatible = "iio-hwmon";
@@ -114,7 +116,8 @@
 	};
 	ina226-adc-avccaux {
 		compatible = "iio-hwmon";
-		io-channels = <&adc_avccaux 0>, <&adc_avccaux 1>, <&adc_avccaux 2>, <&adc_avccaux 3>;
+		io-channels = <&adc_avccaux 0>, <&adc_avccaux 1>, <&adc_avccaux 2>,
+			      <&adc_avccaux 3>;
 	};
 	ina226-dac-avcc {
 		compatible = "iio-hwmon";
@@ -389,7 +392,6 @@
 				reg = <0x45>; /* i2c addr 0x15 */
 			};
 			/* J21 header too */
-
 		};
 		i2c@3 {
 			#address-cells = <1>;
@@ -674,13 +676,13 @@
 	status = "okay";
 	/* SATA OOB timing settings */
 	ceva,p0-cominit-params = /bits/ 8 <0x18 0x40 0x18 0x28>;
-	ceva,p0-comwake-params = /bits/ 8 <0x06 0x14 0x08 0x0E>;
-	ceva,p0-burst-params = /bits/ 8 <0x13 0x08 0x4A 0x06>;
-	ceva,p0-retry-params = /bits/ 16 <0x96A4 0x3FFC>;
+	ceva,p0-comwake-params = /bits/ 8 <0x06 0x14 0x08 0x0e>;
+	ceva,p0-burst-params = /bits/ 8 <0x13 0x08 0x4a 0x06>;
+	ceva,p0-retry-params = /bits/ 16 <0x96a4 0x3ffc>;
 	ceva,p1-cominit-params = /bits/ 8 <0x18 0x40 0x18 0x28>;
-	ceva,p1-comwake-params = /bits/ 8 <0x06 0x14 0x08 0x0E>;
-	ceva,p1-burst-params = /bits/ 8 <0x13 0x08 0x4A 0x06>;
-	ceva,p1-retry-params = /bits/ 16 <0x96A4 0x3FFC>;
+	ceva,p1-comwake-params = /bits/ 8 <0x06 0x14 0x08 0x0e>;
+	ceva,p1-burst-params = /bits/ 8 <0x13 0x08 0x4a 0x06>;
+	ceva,p1-retry-params = /bits/ 16 <0x96a4 0x3ffc>;
 	phy-names = "sata-phy";
 	phys = <&psgtr 3 PHY_TYPE_SATA 1 3>;
 };
diff --git a/arch/arm/dts/zynqmp-zcu670-revA.dts b/arch/arm/dts/zynqmp-zcu670-revA.dts
index 2928ebe56fc2..058d6b2e6486 100644
--- a/arch/arm/dts/zynqmp-zcu670-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu670-revA.dts
@@ -73,7 +73,8 @@
 	};
 	ina226-vccint-io-bram {
 		compatible = "iio-hwmon";
-		io-channels = <&vccint_io_bram_ps 0>, <&vccint_io_bram_ps 1>, <&vccint_io_bram_ps 2>, <&vccint_io_bram_ps 3>;
+		io-channels = <&vccint_io_bram_ps 0>, <&vccint_io_bram_ps 1>,
+			      <&vccint_io_bram_ps 2>, <&vccint_io_bram_ps 3>;
 	};
 	ina226-vcc1v8 {
 		compatible = "iio-hwmon";
@@ -109,7 +110,8 @@
 	};
 	ina226-dac-avccaux {
 		compatible = "iio-hwmon";
-		io-channels = <&dac_avccaux 0>, <&dac_avccaux 1>, <&dac_avccaux 2>, <&dac_avccaux 3>;
+		io-channels = <&dac_avccaux 0>, <&dac_avccaux 1>, <&dac_avccaux 2>,
+			      <&dac_avccaux 3>;
 	};
 	ina226-adc-avcc {
 		compatible = "iio-hwmon";
@@ -117,7 +119,8 @@
 	};
 	ina226-adc-avccaux {
 		compatible = "iio-hwmon";
-		io-channels = <&adc_avccaux 0>, <&adc_avccaux 1>, <&adc_avccaux 2>, <&adc_avccaux 3>;
+		io-channels = <&adc_avccaux 0>, <&adc_avccaux 1>, <&adc_avccaux 2>,
+			      <&adc_avccaux 3>;
 	};
 	ina226-dac-avcc {
 		compatible = "iio-hwmon";
@@ -388,7 +391,6 @@
 				reg = <0x45>; /* i2c addr 0x15 */
 			};
 			/* J21 header too */
-
 		};
 		i2c@3 {
 			#address-cells = <1>;
@@ -437,9 +439,11 @@
 			#size-cells = <0>;
 			reg = <1>;
 			/* SI5381 - u43 */
-			/* si5381: clock-generator@68 {
-				reg = <0x68>;
-			};*/
+			/*
+			 * si5381: clock-generator@68 {
+			 *	reg = <0x68>;
+			 * };
+			 */
 		};
 		i2c_si570_user_c0: i2c@2 {
 			#address-cells = <1>;
diff --git a/arch/arm/dts/zynqmp-zcu670-revB.dts b/arch/arm/dts/zynqmp-zcu670-revB.dts
index 1a99d1e08fb2..010d412b2027 100644
--- a/arch/arm/dts/zynqmp-zcu670-revB.dts
+++ b/arch/arm/dts/zynqmp-zcu670-revB.dts
@@ -73,7 +73,8 @@
 	};
 	ina226-vccint-io-bram {
 		compatible = "iio-hwmon";
-		io-channels = <&vccint_io_bram_ps 0>, <&vccint_io_bram_ps 1>, <&vccint_io_bram_ps 2>, <&vccint_io_bram_ps 3>;
+		io-channels = <&vccint_io_bram_ps 0>, <&vccint_io_bram_ps 1>,
+			      <&vccint_io_bram_ps 2>, <&vccint_io_bram_ps 3>;
 	};
 	ina226-vcc1v8 {
 		compatible = "iio-hwmon";
@@ -109,7 +110,8 @@
 	};
 	ina226-dac-avccaux {
 		compatible = "iio-hwmon";
-		io-channels = <&dac_avccaux 0>, <&dac_avccaux 1>, <&dac_avccaux 2>, <&dac_avccaux 3>;
+		io-channels = <&dac_avccaux 0>, <&dac_avccaux 1>, <&dac_avccaux 2>,
+			      <&dac_avccaux 3>;
 	};
 	ina226-adc-avcc {
 		compatible = "iio-hwmon";
@@ -117,7 +119,8 @@
 	};
 	ina226-adc-avccaux {
 		compatible = "iio-hwmon";
-		io-channels = <&adc_avccaux 0>, <&adc_avccaux 1>, <&adc_avccaux 2>, <&adc_avccaux 3>;
+		io-channels = <&adc_avccaux 0>, <&adc_avccaux 1>, <&adc_avccaux 2>,
+			      <&adc_avccaux 3>;
 	};
 	ina226-dac-avcc {
 		compatible = "iio-hwmon";
@@ -388,7 +391,6 @@
 				reg = <0x45>; /* i2c addr 0x15 */
 			};
 			/* J21 header too */
-
 		};
 		i2c@3 {
 			#address-cells = <1>;
@@ -437,9 +439,11 @@
 			#size-cells = <0>;
 			reg = <1>;
 			/* SI5381 - u43 */
-			/* si5381: clock-generator@68 {
-				reg = <0x68>;
-			};*/
+			/*
+			 * si5381: clock-generator@68 {
+			 *	reg = <0x68>;
+			 * };
+			 */
 		};
 		i2c_si570_user_c0: i2c@2 {
 			#address-cells = <1>;
-- 
2.43.0

base-commit: 988a6f38ed9cfbb9757b76a16cb9cfec4601de85
branch: debian-sent3
