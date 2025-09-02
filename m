Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E737CA1005
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 08:54:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1A8383A8F;
	Tue,  2 Sep 2025 10:54:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vEHGohY+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FF2B831D3; Tue,  2 Sep 2025 10:54:16 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::621])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8239683A81
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 10:54:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INy4ktv4wDkyLi8cpTswZgjhoWqM/k7+tnkhlU0sbiZrDGdDqLJmhdPdSUeUL+RbLRtWk3yJG9MOqFDRc6OL3m66Rhjfugy8Demd3u+hiDDDml7a77zHWVtXjlDrjRr08vyfK31alfgRZstNzupEVm46eenhjCo/Z+fSN5+Gyqi/AhOzvbnvYPnXK0cl9Kq0n5pytl6KODhgIkOWN79UovHJBXZD0hKAPZAucvW6Ay6NEutrFrNF3iWRMO+bt+BjNqqqX7hH/sLnzumJTO5jf8fMTXVOkfdBuACf5CEUX95Wwsq84pisZj3fBto6MQZjpZolnamJ7qo7OE0rc4YUlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GN44RYswrBtNh8k+H79ostjCLp1aUBV0QNYOyno5H7M=;
 b=oWjh/8cxlRJwus4bNSVLs8FJMC/JekUBCTbmVxVGUzdqLu7f2VF78IDvW4HnQM5HuGxO9iWRHot6f2njSbgSgP7VIq9uZBQ5y4FENYhu8H/W+m43Gn/JpxdiNX47GErY2iTMmO/bDUaba4PsVAipHi2vY8VXoELrgcYHdoIjzK06FAuj72dvind/gsHlY1e1fxqiB03+ScrnAgpAxxxrJ7P3RQ80xY3mhxyn6H747j2mG8GNhX72wJvOdQ2/iwgLrkWgEV5irrGkikEYTmk6M6r1nIu65rVb8pKxTxN23jF69w26nOTkJW+imVsgdPHvictpSqtg+0hnlFCAUnlafA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GN44RYswrBtNh8k+H79ostjCLp1aUBV0QNYOyno5H7M=;
 b=vEHGohY+5V+sJj6J2HDVC1aXNSd+ZRaN4QyK/2h8GDfYnbAwK+CyyLpLnRH4+iU7qJrEc6eOzZVH5qoMk2ezd+igBD7WqlDLujZfMD1ZefRfo5ofqSUov3klgD1Iw+kkCJYC1oyQZbztV6pVw+V88MyhqXZlR6DyTtc4eLqYE1Y=
Received: from BN8PR07CA0026.namprd07.prod.outlook.com (2603:10b6:408:ac::39)
 by CH3PR12MB8458.namprd12.prod.outlook.com (2603:10b6:610:155::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 08:54:10 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:ac:cafe::ec) by BN8PR07CA0026.outlook.office365.com
 (2603:10b6:408:ac::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Tue,
 2 Sep 2025 08:54:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 08:54:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 03:54:10 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 03:54:08 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 2 Sep 2025 03:54:08 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Padmarao Begari <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/12] arm64: xilinx: Add i2c mux idle disconnect property
Date: Tue, 2 Sep 2025 10:53:27 +0200
Message-ID: <d75f31d72cadf6d98c0faa51239bf2b239797d2d.1756803198.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756803198.git.michal.simek@amd.com>
References: <cover.1756803198.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3409; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=0T0C1aR0gZz0KVk6+Y+uCbyVDC/SO1sclw2zfDiUZ8o=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRs29BZF7T0vP7EwIQQc8sb09139j46G3FRSn3RLQfur
 dY+RbklHaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjCRD9yMDMcme/XrdhYIvT26
 xfdd1/wTBWZ3ErTqVz2csOGPi9Kf/0KMDBPfHGOdFG/Rsuocz+qTIsFLrOcqvDoQdsV2lf58Red
 /PEwA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|CH3PR12MB8458:EE_
X-MS-Office365-Filtering-Correlation-Id: 4af16944-aab3-41f6-ea18-08dde9fe4871
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EWu4fnCqh3q3vTU+LnAem2/9E3N62o3tluhEcNcoyNFZhXh3+mqmSNfFuaGw?=
 =?us-ascii?Q?Y2TxkFnPPwEjVkR2lXeKx8S5FLVa4A5J8E9wYOm5eImTEyVnajkWcrRpyuXj?=
 =?us-ascii?Q?FSsDjO0PY36uHiMShu3C/0KMMidU6Y/i8rCxU1sRHgT5ahN/VOCsMc7+MTU0?=
 =?us-ascii?Q?Wy+VpMWvbLx/+yN9jJQg8kF47UnebA2xD/ZGD1mft9ThiX/ZT8HaxYIsi9C9?=
 =?us-ascii?Q?MYWdf2hS5RkFZ3i4FupkziShqUurzrGowUIzSVuN7KL4KcjfJP5Bb7jCFOvI?=
 =?us-ascii?Q?jHw7aABDnjFGwspDce4awBLYzZgM3blHrnrMdIe94ZUG/+76m/fbccQgCvOo?=
 =?us-ascii?Q?9SFf2imMd3WOvtSbShnL4r00RgAB0fIf0brjwEwTviHrtuS3l+JwlrbC6Kqm?=
 =?us-ascii?Q?F8LRR/H6+PY+KcbX7KnBVKSa/LF3O2qkzB0wozDibeaT9FvLMuDOUY3ssezI?=
 =?us-ascii?Q?fRtSlDyrXLfD5ijWGrav4y3piT1CdCfH+rE99c4+aKOmoJ4yY52MAnkiVnAe?=
 =?us-ascii?Q?X8L38UA6pfTc6FE5yHkxIJMDdinfNIun8oQq8A8hl9+uI3sHjddCC4S/Nitf?=
 =?us-ascii?Q?cLjSIAZqQ0UeLIBnVUM/iqvX8sib9fMzMWdDyZEL0T7R8U46xBuJJ2KkTcCl?=
 =?us-ascii?Q?kaQBOECo0Bn2N10g8XLgY8PDly9Guxtnz27qHE9siPuwm9j8oP4f9uPSOXW5?=
 =?us-ascii?Q?tD5o3CwtQmrUJfIXteCeDWDFO9QHwz3FC+HwbxCV2M67R8epiQZOweonu2+o?=
 =?us-ascii?Q?yKJynXop6UASxAdlMARQNzhsVvLeIml4bcP2RYJUXa7CbOoPkTMvrHYZfKwI?=
 =?us-ascii?Q?trpDAg5R1KGaBZXcGj2ORdT9LbVP4630lt3vZtvCkbvXNcZ1Wb+xaBPZRVVR?=
 =?us-ascii?Q?dEvs9+9dK0krv3xkgIyWV4OyqUZPhGemKa11U6cruH6DYHBLFj3LgdUUkuaA?=
 =?us-ascii?Q?dE44Zazq+lImWoy1zrqu8uEVyengJMEa81zaomU255HkUj7XBNuY2AwNL1Kf?=
 =?us-ascii?Q?HAkyfMHv5YlIEFMlOKE1JvMlfJx9rR+hYNFwwISml9oWR/wM3PckuneQ+FU7?=
 =?us-ascii?Q?QazxrbKVwIHcFfY8+fVNxhIjt0sF8gZHEMIRL0I1zmnZoQh70vlZIpXOb4vu?=
 =?us-ascii?Q?Xw4w8QQizfZb2GgX/U3Buu5k6a7W8HLmz50b/FGvMMTDYlCmaVbwi6Ne5Iri?=
 =?us-ascii?Q?Oa7Ly9b7VQaioM5U8VhwiQ6m42ITRjTbt1ctBDi5aI+jdhha+19FaqNJ3FCL?=
 =?us-ascii?Q?ab+10cy4jyE1Iest//A0liwRUhqha7y5TTFQ9MeBmCte9yuRcVr1dmBTRwbO?=
 =?us-ascii?Q?TATr4H7tS7bNDUMWofDEgDk22lNLjKKisX+LoGPQSCohTH1XCLlyM4vupo/Y?=
 =?us-ascii?Q?JhIA+mP2Aa8ZpXdVE2Ysmtaeeaw5m6JlT0q43l7vs+SJtuyNpwjz6XxBIqju?=
 =?us-ascii?Q?vk2i1RL9nIDdqDxQAiYhTx+pWko2oTfanI+hteMnL2Y0N9jFntk92xJUWdCY?=
 =?us-ascii?Q?irjBT671MKoIQKDJo8ooqyqOFvvEMV1mjnTD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:54:10.2441 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af16944-aab3-41f6-ea18-08dde9fe4871
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8458
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

From: Padmarao Begari <padmarao.begari@amd.com>

Add i2c-mux-idle-disconnect property to an i2c mux node.
It is used to configure an i2c mux to disconnect all
its channels when idle.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sc-vek280-revA.dtso | 1 +
 arch/arm/dts/zynqmp-sc-vhk158-revA.dtso | 2 ++
 arch/arm/dts/zynqmp-sc-vpk120-revB.dtso | 2 ++
 arch/arm/dts/zynqmp-sc-vpk180-revA.dtso | 1 +
 arch/arm/dts/zynqmp-sc-vpk180-revB.dtso | 1 +
 5 files changed, 7 insertions(+)

diff --git a/arch/arm/dts/zynqmp-sc-vek280-revA.dtso b/arch/arm/dts/zynqmp-sc-vek280-revA.dtso
index 3320bbc11fcd..e94b784e8e1f 100644
--- a/arch/arm/dts/zynqmp-sc-vek280-revA.dtso
+++ b/arch/arm/dts/zynqmp-sc-vek280-revA.dtso
@@ -43,6 +43,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		reg = <0x74>;
+		i2c-mux-idle-disconnect;
 		/* reset-gpios = <&gpio SYSCTLR_IIC_MUX0_RESET_B GPIO_ACTIVE_HIGH>; */
 		pmbus_i2c: i2c@0 {
 			#address-cells = <1>;
diff --git a/arch/arm/dts/zynqmp-sc-vhk158-revA.dtso b/arch/arm/dts/zynqmp-sc-vhk158-revA.dtso
index 2ce69374c154..fd25731b0b43 100644
--- a/arch/arm/dts/zynqmp-sc-vhk158-revA.dtso
+++ b/arch/arm/dts/zynqmp-sc-vhk158-revA.dtso
@@ -44,6 +44,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		reg = <0x74>;
+		i2c-mux-idle-disconnect;
 		/* reset-gpios = <&gpio SYSCTLR_IIC_MUX0_RESET_B GPIO_ACTIVE_HIGH>; */
 		pmbus_i2c: i2c@0 {
 			#address-cells = <1>;
@@ -269,6 +270,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		reg = <0x74>;
+		i2c-mux-idle-disconnect;
 		/* reset-gpios = <&gpio SYSCTLR_IIC_MUX1_RESET_B GPIO_ACTIVE_HIGH>; */
 		ddr4_dimm0: i2c@0 { /* wired but NC */
 			#address-cells = <1>;
diff --git a/arch/arm/dts/zynqmp-sc-vpk120-revB.dtso b/arch/arm/dts/zynqmp-sc-vpk120-revB.dtso
index 853d9817dd2a..29b3a73fde01 100644
--- a/arch/arm/dts/zynqmp-sc-vpk120-revB.dtso
+++ b/arch/arm/dts/zynqmp-sc-vpk120-revB.dtso
@@ -38,6 +38,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		reg = <0x74>;
+		i2c-mux-idle-disconnect;
 		/* reset-gpios = <&gpio SYSCTLR_IIC_MUX0_RESET_B GPIO_ACTIVE_HIGH>; */
 		pmbus_i2c: i2c@0 {
 			#address-cells = <1>;
@@ -232,6 +233,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		reg = <0x74>;
+		i2c-mux-idle-disconnect;
 		/* reset-gpios = <&gpio SYSCTLR_IIC_MUX1_RESET_B GPIO_ACTIVE_HIGH>; */
 		ref_clk_i2c: i2c@0 {
 			#address-cells = <1>;
diff --git a/arch/arm/dts/zynqmp-sc-vpk180-revA.dtso b/arch/arm/dts/zynqmp-sc-vpk180-revA.dtso
index ba5484573c99..10466ce99de6 100644
--- a/arch/arm/dts/zynqmp-sc-vpk180-revA.dtso
+++ b/arch/arm/dts/zynqmp-sc-vpk180-revA.dtso
@@ -44,6 +44,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		reg = <0x74>;
+		i2c-mux-idle-disconnect;
 		/* reset-gpios = <&gpio SYSCTLR_IIC_MUX0_RESET_B GPIO_ACTIVE_HIGH>; */
 		pmbus_i2c: i2c@0 {
 			#address-cells = <1>;
diff --git a/arch/arm/dts/zynqmp-sc-vpk180-revB.dtso b/arch/arm/dts/zynqmp-sc-vpk180-revB.dtso
index 3990d053c351..74e1c5c6dc94 100644
--- a/arch/arm/dts/zynqmp-sc-vpk180-revB.dtso
+++ b/arch/arm/dts/zynqmp-sc-vpk180-revB.dtso
@@ -44,6 +44,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		reg = <0x74>;
+		i2c-mux-idle-disconnect;
 		/* reset-gpios = <&gpio SYSCTLR_IIC_MUX0_RESET_B GPIO_ACTIVE_HIGH>; */
 		pmbus_i2c: i2c@0 {
 			#address-cells = <1>;
-- 
2.43.0

