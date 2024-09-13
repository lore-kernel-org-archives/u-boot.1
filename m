Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 601B3FA3736
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 09:29:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89F99889E9;
	Fri, 13 Sep 2024 11:29:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WJpfs5Wn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0CC388A30; Fri, 13 Sep 2024 11:29:10 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8985B887FA
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 11:29:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9pgxAQoa/yWmIGkdNT1NPYg+emkAzbaCEjNjkN62C12TZiqRbYu/LmwuX9i4124TcUpZKHQnk0R2qT/xv4eNJSfBHKCBYzImooh8CxMbpRQLwk7QjUGJIntJd4bRsokjCgdnB/Lbh9KTG4lRsdMtCea9I/pOgwkhK1BPaIaFy7K6H7C6h6/+Dy5cS0HMqXlNxZ0md6nW/nAd80UG9I9rAlMyW2wG6YhHwdIULrV7hie7giFhH3w+srcM7OMcIeHwPtSSxSzJjaTavD6pCpO7JDf8rWM1qzTtUqXFRJINj+8ZUEuKw/1b7ZsFQs9Ehocc+3liqTHv+Ki1Be3gXNGiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oePj20wWPAUijO1tJjDl3zy28qAOH0NDbtf3W0SisGY=;
 b=sNM7F2pBx1EI+rcxW8albGh/zz+nGQyxKxHuqnmjBnO3FAF1uRimn8q8q0u42wrV1RsWWQ7L5rn43riuCwH4NHcYRkDoeW69DKa6uBqFxiEMidumId37gSzH9avsTiFrWIxkhwxMBmJoyWHeYHz07RX8szFMoELRg7gVdxh5iRWBHxPqRXlQXBbKiiGxGJgA7nF9NGvAf84qzP5oAWKA3HKxSSRSJ2lkAxMj2PmumzNJBs1U03H8cgWRwMguLZOmU5NZMZ4hXpPl654DPowofwQno3QBESElgFlIBy3hOcumgZdMSXTD/MrpV7rFrZJLJh1JmvkGTcvTMWAGs3rQDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oePj20wWPAUijO1tJjDl3zy28qAOH0NDbtf3W0SisGY=;
 b=WJpfs5WnVWWsb3go5ia4fOUkjtt+Z2h7M+56oIG9m7/cf1UaEpYvrhj5UQJTSo/OaRwOZcsmS4g72k/gE+BqfF8ae2arxvCQORctEvceuJAlrc7GhWj2u9qVfN4YgczrQ+hVZHTOzf283Nwntqvt69b4JqJ3XBlP/QRVeSAzzcI=
Received: from SN6PR05CA0024.namprd05.prod.outlook.com (2603:10b6:805:de::37)
 by PH0PR12MB8797.namprd12.prod.outlook.com (2603:10b6:510:28d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.22; Fri, 13 Sep
 2024 09:29:04 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:805:de:cafe::55) by SN6PR05CA0024.outlook.office365.com
 (2603:10b6:805:de::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Fri, 13 Sep 2024 09:29:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 13 Sep 2024 09:29:04 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 04:29:02 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH 03/10] xilinx: Fix axi and mmc node names in mini configuration
Date: Fri, 13 Sep 2024 11:28:44 +0200
Message-ID: <1b18a69ae47bdcb1a0795af7621d13bfecfc9861.1726219714.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1726219714.git.michal.simek@amd.com>
References: <cover.1726219714.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5252; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=eZvN+2zqWeH2VEekGKEwsgDOa4O2i1Bji+qhDBlUwk0=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrQnrGdmHn8Qz7/isK1+u/Gd2ji2VKFXUZ0ncsrsT3zQm
 xvQcL2zI5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEwk9RPDXNFrjv+WCcvvXeBX
 oG3Mk7n121uRLoZ5+isc/1Vscfd/rahdvV5v0u1Wv8e2AA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|PH0PR12MB8797:EE_
X-MS-Office365-Filtering-Correlation-Id: a22ff496-259f-4ef7-a921-08dcd3d682a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rCH9De+Mdikp3CJUHZSYD12LyAQcVnH1qX4yDZptTc4mwrLYM6TQFyEfA2Oe?=
 =?us-ascii?Q?tOZ5ZJJSz4i6AzCa2kEg63aZIDrJ5jJAWk6MUhA+ZnGFABuE14HpxYBLSN7c?=
 =?us-ascii?Q?ybRlUGt6fT88iOeH8iA+8WceU8yCZtzrd0aAgN6jt6P/sKfyQxhcd/+Q0KN2?=
 =?us-ascii?Q?uJwD0x0Fhn3lF02ssaYDSY2DYG4mkyLMLrvMhPYAHLe7ZeyyrP9ZZgkLCytE?=
 =?us-ascii?Q?fQ1ywYMoU+avjknCP/t83ZJ2lL5tyTqEpGAyAyflggEX4xYlTQdSX4msHvIm?=
 =?us-ascii?Q?veyY6bSlc9SvqON7wvSBHr2fl35B8/wCFmSFx4hLilAieBMzQKIrOB4jFV3j?=
 =?us-ascii?Q?kiaMNbOSfPieb5mrUTA9HoJKdQBzzK23wxCRVmh28Ifzt9f9zeotiun+uK9Q?=
 =?us-ascii?Q?XOPvx2ygLgbsM752XpzMfxbEX6pDF5aBb2/q/7KsOtsOza9sTXekt48Z/qUG?=
 =?us-ascii?Q?yqJWlJvFcjpjAwcVRe+cr8shtV+/AD+fX+kRCc5imWiTW+OGTGFXvSk+ONrN?=
 =?us-ascii?Q?+35izm0la3TqIwD7z51GlmgP0jmM2Dh12Xwr6WJfUVgNFigQyZCGmBnW5eCZ?=
 =?us-ascii?Q?AnpxcgglHCDpGMW7quPtzmJUQOcYL4nSiR7aky6WRG6CGOmCM4D1zpfYXzOj?=
 =?us-ascii?Q?OdgH6xAScNifHyjoZKXBT3wHbBHXlI8Qxjy9o9kB1x8fmd42+WFQQP08Kzyy?=
 =?us-ascii?Q?CkFSGBjJJovwwh8/09Sc9gws7gM81tpBH/t+CACMRSLMNhatfbzIH8LjPC9c?=
 =?us-ascii?Q?mB3/ATSuA3UTPZXqp/6MrVcYlxDijIKCuS+432l94XTxd87rQRAQXcXwto3M?=
 =?us-ascii?Q?9lquPB0YrfhQXZzIDpGQzUFJkfANI78siiXcFZme8iqWoDpl5K8kB+XpBiLC?=
 =?us-ascii?Q?2Dkxeus+GuTcI65Q0H6PLRn3YAP8piOy3QGok22dwov2ANoYKF8yDj4rbJeX?=
 =?us-ascii?Q?eCUx/Otx9cV9B25recbdoHjmNmmuhs1bSPv/TJflpQYf3QDjMOpLDoJ7LAs1?=
 =?us-ascii?Q?skDD2hXoGi9za79UHmWtEHX6fUyN/bDh+iLofkUeJla9wavLiS7lGnmLNtce?=
 =?us-ascii?Q?FBquZ6cYoEG3AuPim4+9BKjKrdDeZ8JHceP9FOUkBvJTA8rHCy8h6fJRMuPY?=
 =?us-ascii?Q?GOZspyOT9h3J9z10WUV8KWKALVg92IxE0eSbdyAr9tHRYhLiC+lfl4T/j6pr?=
 =?us-ascii?Q?CEGESPXiLoG7dlX+EBf+itGI3sAFTDlLIIF67js3rGRqgwBgpAQcr+u5sMh6?=
 =?us-ascii?Q?BSb9brceb2swm3id71c62O04XomRcFgPwWA+ZYaXixFeAXyXHu6an2zHiIw9?=
 =?us-ascii?Q?CTs6SiDkCF7sOsaNYo08FPb9Ne6fViwuxhdCX1G1vE+3wYLmev7pP8RAWf15?=
 =?us-ascii?Q?bYULXDqzcsghMSNuXLm5/vdwuUECkd4ipUKv3AX1gHVyoZdIn1h7pz5qVeZe?=
 =?us-ascii?Q?WGvXKyniTb9lr51Cnlh9h8af7mU8os3h?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 09:29:04.7081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a22ff496-259f-4ef7-a921-08dcd3d682a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8797
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

amba is not approved node name for simple-bus that's why use axi instead to
be aligned with other xilinx boards. Node reference is not changed that's
why there is no impact but also mini configuration will never gets to OS
that's why nothing should be affected from OS perspective (paths in /proc/
for example).

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/versal-mini-emmc0.dts | 2 +-
 arch/arm/dts/versal-mini-emmc1.dts | 2 +-
 arch/arm/dts/versal-mini-ospi.dtsi | 2 +-
 arch/arm/dts/versal-mini-qspi.dtsi | 2 +-
 arch/arm/dts/zynq-cse-nand.dts     | 2 +-
 arch/arm/dts/zynq-cse-nor.dts      | 2 +-
 arch/arm/dts/zynq-cse-qspi.dtsi    | 2 +-
 arch/arm/dts/zynqmp-mini-emmc0.dts | 4 ++--
 arch/arm/dts/zynqmp-mini-emmc1.dts | 4 ++--
 arch/arm/dts/zynqmp-mini-nand.dts  | 2 +-
 arch/arm/dts/zynqmp-mini-qspi.dts  | 2 +-
 11 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/dts/versal-mini-emmc0.dts b/arch/arm/dts/versal-mini-emmc0.dts
index 60b1c0e1fc44..b98ed16bc5ff 100644
--- a/arch/arm/dts/versal-mini-emmc0.dts
+++ b/arch/arm/dts/versal-mini-emmc0.dts
@@ -28,7 +28,7 @@
 		bootph-all;
 	};
 
-	amba: amba {
+	amba: axi {
 		bootph-all;
 		compatible = "simple-bus";
 		#address-cells = <0x2>;
diff --git a/arch/arm/dts/versal-mini-emmc1.dts b/arch/arm/dts/versal-mini-emmc1.dts
index 751cc38ee5c0..e6a5c2b699e0 100644
--- a/arch/arm/dts/versal-mini-emmc1.dts
+++ b/arch/arm/dts/versal-mini-emmc1.dts
@@ -28,7 +28,7 @@
 		bootph-all;
 	};
 
-	amba: amba {
+	amba: axi {
 		bootph-all;
 		compatible = "simple-bus";
 		#address-cells = <0x2>;
diff --git a/arch/arm/dts/versal-mini-ospi.dtsi b/arch/arm/dts/versal-mini-ospi.dtsi
index 8735292a1273..9ca0cf3c027f 100644
--- a/arch/arm/dts/versal-mini-ospi.dtsi
+++ b/arch/arm/dts/versal-mini-ospi.dtsi
@@ -28,7 +28,7 @@
 		bootph-all;
 	};
 
-	amba: amba {
+	amba: axi {
 		bootph-all;
 		compatible = "simple-bus";
 		#address-cells = <0x2>;
diff --git a/arch/arm/dts/versal-mini-qspi.dtsi b/arch/arm/dts/versal-mini-qspi.dtsi
index 9347ea32c9cb..57427e099f9e 100644
--- a/arch/arm/dts/versal-mini-qspi.dtsi
+++ b/arch/arm/dts/versal-mini-qspi.dtsi
@@ -28,7 +28,7 @@
 		bootph-all;
 	};
 
-	amba: amba {
+	amba: axi {
 		bootph-all;
 		compatible = "simple-bus";
 		#address-cells = <0x2>;
diff --git a/arch/arm/dts/zynq-cse-nand.dts b/arch/arm/dts/zynq-cse-nand.dts
index 18f627f3d72b..f1fb15902a79 100644
--- a/arch/arm/dts/zynq-cse-nand.dts
+++ b/arch/arm/dts/zynq-cse-nand.dts
@@ -31,7 +31,7 @@
 		bootph-all;
 	};
 
-	amba: amba {
+	amba: axi {
 		bootph-all;
 		compatible = "simple-bus";
 		#address-cells = <1>;
diff --git a/arch/arm/dts/zynq-cse-nor.dts b/arch/arm/dts/zynq-cse-nor.dts
index a5c8a0813ffb..8e60d17b9448 100644
--- a/arch/arm/dts/zynq-cse-nor.dts
+++ b/arch/arm/dts/zynq-cse-nor.dts
@@ -31,7 +31,7 @@
 		bootph-all;
 	};
 
-	amba: amba {
+	amba: axi {
 		bootph-all;
 		compatible = "simple-bus";
 		#address-cells = <1>;
diff --git a/arch/arm/dts/zynq-cse-qspi.dtsi b/arch/arm/dts/zynq-cse-qspi.dtsi
index 2e4afafebf51..3b7e6c798740 100644
--- a/arch/arm/dts/zynq-cse-qspi.dtsi
+++ b/arch/arm/dts/zynq-cse-qspi.dtsi
@@ -32,7 +32,7 @@
 		bootph-all;
 	};
 
-	amba: amba {
+	amba: axi {
 		bootph-all;
 		compatible = "simple-bus";
 		#address-cells = <1>;
diff --git a/arch/arm/dts/zynqmp-mini-emmc0.dts b/arch/arm/dts/zynqmp-mini-emmc0.dts
index 7823c58cb272..cf2219797a58 100644
--- a/arch/arm/dts/zynqmp-mini-emmc0.dts
+++ b/arch/arm/dts/zynqmp-mini-emmc0.dts
@@ -41,13 +41,13 @@
 		clock-frequency = <200000000>;
 	};
 
-	amba: amba {
+	amba: axi {
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
 
-		sdhci0: sdhci@ff160000 {
+		sdhci0: mmc@ff160000 {
 			bootph-all;
 			compatible = "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a";
 			status = "disabled";
diff --git a/arch/arm/dts/zynqmp-mini-emmc1.dts b/arch/arm/dts/zynqmp-mini-emmc1.dts
index 2f6ba95073ab..4c9f56a80763 100644
--- a/arch/arm/dts/zynqmp-mini-emmc1.dts
+++ b/arch/arm/dts/zynqmp-mini-emmc1.dts
@@ -41,13 +41,13 @@
 		clock-frequency = <200000000>;
 	};
 
-	amba: amba {
+	amba: axi {
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
 
-		sdhci1: sdhci@ff170000 {
+		sdhci1: mmc@ff170000 {
 			bootph-all;
 			compatible = "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a";
 			status = "disabled";
diff --git a/arch/arm/dts/zynqmp-mini-nand.dts b/arch/arm/dts/zynqmp-mini-nand.dts
index e08a7840d8e1..5e2135158cd5 100644
--- a/arch/arm/dts/zynqmp-mini-nand.dts
+++ b/arch/arm/dts/zynqmp-mini-nand.dts
@@ -35,7 +35,7 @@
 		bootph-all;
 	};
 
-	amba: amba {
+	amba: axi {
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <1>;
diff --git a/arch/arm/dts/zynqmp-mini-qspi.dts b/arch/arm/dts/zynqmp-mini-qspi.dts
index e35317f3e2d4..a02a3d68dd52 100644
--- a/arch/arm/dts/zynqmp-mini-qspi.dts
+++ b/arch/arm/dts/zynqmp-mini-qspi.dts
@@ -36,7 +36,7 @@
 		bootph-all;
 	};
 
-	amba: amba {
+	amba: axi {
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <1>;
-- 
2.43.0

