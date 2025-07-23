Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53876C83F25
	for <u-boot@archiver.kernel.org>; Wed, 23 Jul 2025 03:08:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E09DA8331F;
	Wed, 23 Jul 2025 05:07:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="eoeqGo93";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C162583093; Wed, 23 Jul 2025 05:07:55 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::62b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C28383253
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 05:07:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=donalds@nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IJjmauTUBLEI0P8hg5G7Pv037V4djF4kDh0gXdEyufbD0TPHbq8BIa/dX8Co9U4X7ovRozBnTl6bXd5PfiK+SY1Wg73egeVl5N0zpRt9cBiYEjl10rOHby+aqmEx0tnEIU9rafUXuPhTP0yHbHS77lb8CS7RfBRbsf5sXdn0L2yJztFrgqLGXZtnI+dkahvOjc0PYDjxqKR4llUGUvDxeOkc4RzGEr7c+uwHDKeaqr9ZXOgY/AZGEXwwtdfDbquKdne9HS3OvCtQdX9jyVLcWlc488LYKZ9yOTA0biyL/1AYgSkygfS6Peur5lQbOXTKmFUHHsSPMo29rHSSLElVHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18DpAayWeGLpEa/NGPG7X+ucqeC5lSkUdMmfq/Tm1nk=;
 b=Vcq+Qxs1/RrSPvK7uIt/og7S7JQrJ8SE/9hPNhA1VV1hhYg+QuZTpJrCUnxBc+vbyxCHe4tzaoqnIesUlvx6/JmX6Lf9h+Hqc7OLMonamPnka4nfyZY6+28gVcbI7zPmkO2O2jlWpyDgwzlysBBB+6MMjUy1N7qCh/He0VeL1Umwjzdxg31fQmviHGYumcJ72tkwDbO4VUPemJv85BYIYUNgulQXF4q3SzQrSQghozmoy7bO1WdGJVOkFtr5XOAy3RNCLYPGycLO0jm8gdCJ9EK85wv9GvebaqdczxbMf3V6jWwv3HrKkuyla/E+NLhm071U0Xz01ro7hQOIW9MSBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=aribaud.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18DpAayWeGLpEa/NGPG7X+ucqeC5lSkUdMmfq/Tm1nk=;
 b=eoeqGo93Z01GHSaRKyDGQrb6nFBOaUfqSyg3RM8J+HSdSzVgjQXrlAEJ9YcAR4g3LNK7W6gNtTAj4FuWeWWjcWDFf7PVvFh3sA4ImIycqEhvxh8h71BNbkNMdLqNZ4RGlUsLlN3KYEnUVxF4kunoxf0SRVk2SrN7DHYcbp2y2oEneSzAk+DZ/5YkSC2AbXS04ca/1QlZT0oiEU2Q4IMxaLJzVUkudNSOznr8Ru7cF9H+KeNLAKfktHxLXN451iBB46B9CbAtgJ+k+q+tWFze11h4D6Wttv7ygUsV9TvHisfVw0PE6oK1VHIq6iSeGgDDtEoPLQU79bLoaOMczTlc+g==
Received: from CH0PR04CA0009.namprd04.prod.outlook.com (2603:10b6:610:76::14)
 by DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Wed, 23 Jul
 2025 03:07:48 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:610:76:cafe::5b) by CH0PR04CA0009.outlook.office365.com
 (2603:10b6:610:76::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Wed,
 23 Jul 2025 03:07:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025 03:07:47 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 22 Jul
 2025 20:07:43 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 22 Jul 2025 20:07:42 -0700
Received: from dondevbox.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 22 Jul 2025 20:07:42 -0700
From: Donald Shannon <donalds@nvidia.com>
To: <albert.u.boot@aribaud.net>, <andrew@codeconstruct.com.au>,
 <thai@nvidia.com>, <donalds@nvidia.com>, <dkodihalli@nvidia.com>,
 <etanous@nvidia.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v2 1/1] ARM: dts: aspeed: Add NVIDIA GB200 UT3.0b
Date: Tue, 22 Jul 2025 20:07:39 -0700
Message-ID: <20250723030739.51264-2-donalds@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250723030739.51264-1-donalds@nvidia.com>
References: <20250723030739.51264-1-donalds@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|DS0PR12MB8245:EE_
X-MS-Office365-Filtering-Correlation-Id: 80f22ebb-800c-4a06-bfee-08ddc9961a1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xhPUO/Ek+HRmq9slPWdwEebQPR55QER82hPryxlbThOiQhhYrk1mefp66lAX?=
 =?us-ascii?Q?ixkJUHqePbNf1qdx65Zb9ipTTBVjNBklc811Iqu0Lc7eoDEHKCBbeSepYe5Y?=
 =?us-ascii?Q?uOWjlUMRLTfApItba7CHrAfVB/H1iybSy/9UJ40vdYzxuJ4TiG5x9+34KVae?=
 =?us-ascii?Q?DVsNJ0SZuRXjq8Xc5wT7XBs6Tv2egxEqYmFdF7LGWtM/+O4fQYiPEcMlmir3?=
 =?us-ascii?Q?b1hJJUuDDfy71EZO315HggUeSMcQgA0tF6HOcfe1fZ+8GykB0pOYTsTyGx8j?=
 =?us-ascii?Q?CONP/j2+UrlVY+ANjlAjVoUGC+hdJKM1ogxfu7ftA9WQizbBxKZMSOvmq+dO?=
 =?us-ascii?Q?2M58E3r5ede2bCYNhBpNVuTSU6rHq+zDCU4qMO2NxOgNfyOXzZrpktB7Eq1+?=
 =?us-ascii?Q?tVBKu9x/l3+Tixo8YLnWSc88Unfqgk2iYime1kKfnoPWO1qevvaj6GI1rF3B?=
 =?us-ascii?Q?d/FNWieOJc1htxkXcMq/r/9FkYLcXDqKQr9nVcMWSnqBjfSdq+FrMlk3jDys?=
 =?us-ascii?Q?/FNEuRqlDgXNbtHtKTJc6rJP048qZmtpeyiMlCG3QiDmJ1G188aNzaikE+w6?=
 =?us-ascii?Q?c36S7Q1pCorD4MLXokiV55ZVkyPVdUhx9jTyJTy+DeO9C2jLQFUVNRF2Caeq?=
 =?us-ascii?Q?GuBRLXMpmo7XxrM7T3GA3o4UW98/HODrkTPnWr7TrtkIbX32gznWYN80gLNP?=
 =?us-ascii?Q?CFUR7Dm/0c5bjrSlOVXNlndebD85+rtrm2VM7fQS131ebn9EtM3WZVMw2GXG?=
 =?us-ascii?Q?KqiuYqD0/q7TBuKA71f/cY5Qi4mbDTQCR872k6kfPFujcflO7zUcoRv1CjDL?=
 =?us-ascii?Q?tDvNnR8JH6rFArRSSUT5Gs6Nld1+n/HF5MmP4yoV8QtFuMjtjQ1g6uiGXFIS?=
 =?us-ascii?Q?X+iKcYRkOR/89A0qkqY3gtqrEoZFGvHoASt18rBWjnVl4ifhgDs5H8AEKp47?=
 =?us-ascii?Q?QQDgW6o02XfEky9wM2E7aBYRtO/Rya83lUZHa7/m6D4+WT/IfqhSZFWVZwhT?=
 =?us-ascii?Q?DxbCOv4Vl6xqEjEumCG7EAD6Pz6cFS15zOprhu1ElxCa85sRHYrYY/Syi6J7?=
 =?us-ascii?Q?5954h7B7yYFQrVBjWXFpR5EM8C5h7Ppi3Ymi/aPUyLq02SWStw0CwTz2ybsy?=
 =?us-ascii?Q?od9gM439droL6pLtxvmS+xsDwl4hJ3WNuCS+UouMoqtREYKvJ96fW2055aFs?=
 =?us-ascii?Q?eRqiWlJe51X5OI7+QlprMrjzhidBK+j+RZi2O+dGwEQv+F603kRoBJVy5zBk?=
 =?us-ascii?Q?usS+Ts+twZoNXA0teH3MekPrOnZbPzp+zy3RjkbAlieZ3cPtJk1tbu56/PSE?=
 =?us-ascii?Q?uCNsfopx/Q2QcMp+KJRDG4Jqs558mssLmm0nlQeaATZRsfS6WOT/unE9tNqM?=
 =?us-ascii?Q?2vEoA/mCkBvE2Pi9ezRgcbwbXLlyercu29E9HheB6aOFuT2YcsI6MMDJBFH/?=
 =?us-ascii?Q?M1q377q5G6Lr5v+PQutvztdAtzRxVvF2OZnL6XN6/LdF6A1dUORFO/e/Q0fp?=
 =?us-ascii?Q?Q1GAHsjGCAZY47QxOLxFFCF8DoRfnjphrfyaOHnKRwDzOutiqqthVfc9SA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 03:07:47.5849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f22ebb-800c-4a06-bfee-08ddc9961a1c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8245
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

GB200 is an Aspeed 2600 based BMC+baseboard for NVIDIA's Blackwell GB200
platform.
UT3.0b is a unit tester variant that uses a different networking topology.

Reference to Ast2600 SOC [1].
Reference to Blackwell GB200NVL Platform [2].

Link: https://www.aspeedtech.com/server_ast2600/ [1]
Link: https://nvdam.widen.net/s/wwnsxrhm2w/blackwell-datasheet-3384703 [2]

Signed-off-by: Donald Shannon <donalds@nvidia.com>
---
 arch/arm/dts/Makefile                       |   1 +
 arch/arm/dts/ast2600-gb200-ut30b-nvidia.dts | 238 ++++++++++++++++++++
 2 files changed, 239 insertions(+)
 create mode 100644 arch/arm/dts/ast2600-gb200-ut30b-nvidia.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index dbb2fafc4f..92a529e8f5 100755
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -688,6 +688,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	ast2600-evb.dtb \
 	ast2600-facebook.dtb \
 	ast2600-fpga.dtb \
+	ast2600-gb200-ut30b-nvidia.dtb \
 	ast2600-gb200nvl-bmc-nvidia.dtb \
 	ast2600-greatlakes.dtb \
 	ast2600-intel.dtb \
diff --git a/arch/arm/dts/ast2600-gb200-ut30b-nvidia.dts b/arch/arm/dts/ast2600-gb200-ut30b-nvidia.dts
new file mode 100644
index 0000000000..68e1f51fe7
--- /dev/null
+++ b/arch/arm/dts/ast2600-gb200-ut30b-nvidia.dts
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+#include "ast2600-u-boot.dtsi"
+
+/ {
+	model = "AST2600 GB200 UT3.0b BMC";
+	compatible = "nvidia,gb200nvl-bmc", "aspeed,ast2600";
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x40000000>;
+	};
+
+	chosen {
+		stdout-path = &uart5;
+	};
+
+	aliases {
+		mmc0 = &emmc_slot0;
+		mmc1 = &sdhci_slot0;
+		mmc2 = &sdhci_slot1;
+		spi0 = &fmc;
+		spi1 = &spi1;
+		spi2 = &spi2;
+		ethernet0 = &mac0;
+		ethernet1 = &mac1;
+		ethernet2 = &mac2;
+		ethernet3 = &mac3;
+	};
+
+	cpus {
+		cpu@0 {
+			clock-frequency = <800000000>;
+		};
+		cpu@1 {
+			clock-frequency = <800000000>;
+		};
+	};
+};
+
+&uart5 {
+	u-boot,dm-pre-reloc;
+	status = "okay";
+};
+
+&sdrammc {
+	clock-frequency = <400000000>;
+};
+
+&wdt1 {
+	status = "okay";
+};
+
+&wdt2 {
+	status = "okay";
+};
+
+&wdt3 {
+	status = "okay";
+};
+
+&mdio {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mdio1_default>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	ethphy0: ethernet-phy@0 {
+		reg = <0>;
+	};
+};
+
+&mac0 {
+	status = "okay";
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&ethphy0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii1_default>;
+};
+
+&fmc {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fmcquad_default>;
+
+	flash@0 {
+		compatible = "spi-flash", "sst,w25q256";
+		status = "okay";
+		spi-max-frequency = <50000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+
+	flash@1 {
+		compatible = "spi-flash", "sst,w25q256";
+		status = "okay";
+		spi-max-frequency = <50000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+
+	flash@2 {
+		compatible = "spi-flash", "sst,w25q256";
+		status = "okay";
+		spi-max-frequency = <50000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+};
+
+&spi1 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default &pinctrl_spi1abr_default
+			&pinctrl_spi1cs1_default &pinctrl_spi1wp_default
+			&pinctrl_spi1wp_default &pinctrl_spi1quad_default>;
+
+	flash@0 {
+		compatible = "spi-flash", "sst,w25q256";
+		status = "okay";
+		spi-max-frequency = <50000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+
+	flash@1 {
+		compatible = "spi-flash", "sst,w25q256";
+		status = "disabled";
+		spi-max-frequency = <50000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+};
+
+&spi2 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi2_default &pinctrl_spi2cs1_default
+			&pinctrl_spi2cs2_default &pinctrl_spi2quad_default>;
+	num-cs = <1>;
+
+	flash@0 {
+		compatible = "spi-flash", "sst,w25q256";
+		status = "okay";
+		spi-max-frequency = <50000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+
+};
+
+&i2c4 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c5_default>;
+};
+
+&i2c5 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c6_default>;
+};
+
+&i2c6 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c7_default>;
+};
+
+&i2c7 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c8_default>;
+};
+
+&i2c8 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c9_default>;
+};
+
+&i2c10 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c11_default>;
+};
+
+&pcie_phy1 {
+	status = "okay";
+};
+
+&pcie_bridge {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&scu {
+	mac0-clk-delay = <0x10 0x0a
+			  0x10 0x10
+			  0x10 0x10>;
+	mac1-clk-delay = <0x10 0x0a
+			  0x10 0x10
+			  0x10 0x10>;
+	mac2-clk-delay = <0x08 0x04
+			  0x08 0x04
+			  0x08 0x04>;
+	mac3-clk-delay = <0x08 0x04
+			  0x08 0x04
+			  0x08 0x04>;
+};
+
+&hace {
+	u-boot,dm-pre-reloc;
+	status = "okay";
+};
+
+&acry {
+	u-boot,dm-pre-reloc;
+	status = "okay";
+};
+
+&display_port {
+	status = "okay";
+};
-- 
2.43.0

