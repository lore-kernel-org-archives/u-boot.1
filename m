Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80749FA3737
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 09:30:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6239588A47;
	Fri, 13 Sep 2024 11:29:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZdbOl3mz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56A6088A5F; Fri, 13 Sep 2024 11:29:37 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::60c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46FF9887FA
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 11:29:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idLL33OhMHp8ydqnmkIMNmwQQIoBOuNeGpQmQzuW/8anW/5vZPSKLlgpeJfX80vm8zaXWJr5tpdzwKtbgCa9UbgmKGIs2Yt2CF9U2sSIq/zuuG5lNeODCLYhC1+nX6A2z6PXnDuZGoRzTotd0CUnTXSefgRKVVH4Hq9G/965SF/Vx2bY4+/D8IJHunMW4UqdCbh5jYRZjjL6BRUdDERqOQYyTJJ8To28MbQPm5Uiz0h55lJHgY0Stubw6yExT0E6EABa7MJXmpFyuCGxeSX9S2Tq2yJKLT+/ZsBWALekePQ+WVc07CGleNZXP15dNhJPGLAjgNYyUmrr0HnqMgyoEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rn5WwsLO+6kqMAruJbYOZX4ixbdQOEH58VI5KwJDTU=;
 b=QLtNOelpDXGj8PYVMUJwIxsqqSEE+3OckgrFmsiRUGtsRROKkUV6TkhdSjtz56kavDILP6Z0IxMHPn9TlZ6AKcb8mw8vU58vpSSHoV1c6RDsMOvhzuEBoysjk7GNPFyiJ8Cafc9W2bL7zFYIF1ErzDK1mrDnZXU9PWfzL7xfGsNIfnvvaaajeXbozMAK2Qp5gfxy6fw3qRUuL1C/FIX8TGrL22WJ2qKY51u+BDWIigew7SNZ1DY2PtXYg0vOjNIZCVIyP+Y8Z2zXYRnW8SWEnoJCzea6iAWhXbOhmrBRuLNag7OGWZZ3wf40mk1l+oyeklxiRvUadgp147wFen4hhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rn5WwsLO+6kqMAruJbYOZX4ixbdQOEH58VI5KwJDTU=;
 b=ZdbOl3mzgxJuANIDrNxv87GwEwKh1ALhOZ0eTP9iK81hOrOg4i7I4c5pOV7vb7iwFiGtQbCLarTTaX8imS+asMsLYArSupkGRJ7N73GQyVGv40TDJf84EhNkOOPwYLb8W8/L3H3I2BBf23ou3tyFOSUI589TLu4bfypcof/S3dE=
Received: from SN6PR05CA0025.namprd05.prod.outlook.com (2603:10b6:805:de::38)
 by IA1PR12MB9063.namprd12.prod.outlook.com (2603:10b6:208:3a9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.33; Fri, 13 Sep
 2024 09:29:30 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:805:de:cafe::94) by SN6PR05CA0025.outlook.office365.com
 (2603:10b6:805:de::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Fri, 13 Sep 2024 09:29:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 13 Sep 2024 09:29:29 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 04:29:28 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/10] arm64: zynqmp: Align mini-qspi DT with dt-schema
Date: Fri, 13 Sep 2024 11:28:48 +0200
Message-ID: <0e4721eda8d0f23a9d9f0c15cf887f0bba639cd4.1726219714.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1726219714.git.michal.simek@amd.com>
References: <cover.1726219714.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1337; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=vik2PX6U7wN4CzCpdfciA+t3atcnDdedZXevUIeDjDo=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrQnrOeku48zc045FFCXNEv4l1uMQPVTQ8vz9ouzCk/ct
 DLvWBDREcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACZy/xDD/ORyHwal8J8n9/zd
 8/bUlp1PW5ZYLGKYZxF8RfzUGrUJpuyqExYetJjt/M7XFQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|IA1PR12MB9063:EE_
X-MS-Office365-Filtering-Correlation-Id: ae832617-e8a9-4f86-4ad4-08dcd3d691b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?92ylFtEBf4BJxVbwHYP+9kAsnD/GM9ydj+2XHwUHMSN9jGgr3vUB9Sbv8oBu?=
 =?us-ascii?Q?57/0LZ/FSMv/mba3ImQuzLT1OLUepoHGadLDcXSpiAKwCsGDIZDCVw0GEXZj?=
 =?us-ascii?Q?TccEfoV/QKyKjRG7GVr7c9l1N/rSWvrRoZSZ9pEnspRrAe1RFWBaG0zlLnGe?=
 =?us-ascii?Q?GqB0oLbPsXrCkSHWmch8ktIhAx4Zo5T4q1a/A7/onjXP2py7HRrdmKISNLnb?=
 =?us-ascii?Q?XXQzcOxjiPzbO9jjQwX7E0bqHVcTuowSunPnrxqUbRMAcEbhc+uaom1KxvXA?=
 =?us-ascii?Q?Z9xrPGTrrNJKk8A5Q//aKPmvUSyBfNFZeZKgX0apykoCgxbxdbF9BwrElVKY?=
 =?us-ascii?Q?u27/lFclNu4UAqYvasbt44A9CnmYkw+XI7dJLPXg4FkT7mYqF7wntzr+bsge?=
 =?us-ascii?Q?Qw65nnPkXOib6vQsjl3Lp0cVDdNw/fMdEXq7SpDUnH9Lfq8v4DW+tNFl3xa2?=
 =?us-ascii?Q?XvM/pFZ6GyfU6Ta+VWgGvhqj4i6saY1Gtq3wONU7QyFYCDcH4lj6ypscjcny?=
 =?us-ascii?Q?ESHrtcXoZU6sJ2EkuHBJe/JLEUzCai5MIpar17MuXwpfyrh6cm89PNWethYX?=
 =?us-ascii?Q?zQUgRXVSM0EbWZjJywdNL9FQVV0+CEWLJS41BilqavPEFEH9mrmrrRrvnf38?=
 =?us-ascii?Q?xgLw5p5w3P9OWutC4oyPiMF7275e3rNLK8BIOhXB1V5Fre7DrQKrqtBG5MBD?=
 =?us-ascii?Q?3/+gKuHNp38ar78uxoC6laCSiBUiSNHwqMnhQS7bKbB+aRGAJQHG0BhdDLKA?=
 =?us-ascii?Q?t5BJu0IDhgAuJR6Wq8Cy6E46dRAsUr8TroHYSWvRut16i7mDKP1jGOhz9vpI?=
 =?us-ascii?Q?vWbTsa1tHdNJLzF9E8/GqRPRWeExgvM728u1/fqD4PY/+1T2kPReH+JawFhk?=
 =?us-ascii?Q?doDm8QNpj0kJ3FsV1S/CvdelAxmXBZvU2eXiPt/hmLd5IegQP4SjqlYrzuuW?=
 =?us-ascii?Q?9YXNWGL91rUJlv6ZMSoKuUq4q1J0Lq8pN36dujrH8735WsUFhHvZ9Bvt71Vp?=
 =?us-ascii?Q?1P/xuo2LR7/0PwRhFYUQHcTUE6bWgJ7DqTiHHGjdsZe9m5zxMqSHEzE8qvRG?=
 =?us-ascii?Q?DQylwZC7s7N8YTgO6CRDG6ktX9e8Wh6Rvd+ycMddZvUjmr2TEg/SmfObpI1V?=
 =?us-ascii?Q?m9IF0uYKDLBrN8q9FGXb14sfTeGDIWtY6YQFQNLCcdLSoq0Pjv+BedTkF81b?=
 =?us-ascii?Q?X+P3lNN+crPcu5a3qe2J7Ab+Q+44SsLrEF147TYyyEFmRwIgTc7gKWBD/ynd?=
 =?us-ascii?Q?jjlF6JMwfyqZRJUcfF6dzehPjvEQC9IWvOEq0IemPZmpUR/R6qOo8cf0Y96C?=
 =?us-ascii?Q?ETf8KQ3k+V/pCiVnQVpIvD+qdG5caBzM1s0YYvXkgm6TpjpzXtctdaRH/jqe?=
 =?us-ascii?Q?FaAbKpgAPIFky1lOX3WoXS7+9RZqZV4eB4TJM0iNzwctWSjBUtO+CV4hAeaq?=
 =?us-ascii?Q?TWS8Z7iKtTrjr4ifHpPAJcalF8uUGNJz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 09:29:29.9895 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae832617-e8a9-4f86-4ad4-08dcd3d691b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9063
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

fixed-clock can't be described on the bus because it is missing reg
property. Also remove additional compatible string for flash. Mini qspi
configuration is used with multiple different flashes that's why describing
only one is not correct but also not required based on DT schema.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-mini-qspi.dts | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/dts/zynqmp-mini-qspi.dts b/arch/arm/dts/zynqmp-mini-qspi.dts
index a02a3d68dd52..917603dec61d 100644
--- a/arch/arm/dts/zynqmp-mini-qspi.dts
+++ b/arch/arm/dts/zynqmp-mini-qspi.dts
@@ -36,6 +36,12 @@
 		bootph-all;
 	};
 
+	misc_clk: misc-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+	};
+
 	amba: axi {
 		compatible = "simple-bus";
 		#address-cells = <2>;
@@ -52,19 +58,13 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
-
-		misc_clk: misc-clk {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <125000000>;
-		};
 	};
 };
 
 &qspi {
 	status = "okay";
 	flash0: flash@0 {
-		compatible = "n25q512a11", "jedec,spi-nor";
+		compatible = "jedec,spi-nor";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		reg = <0x0>;
-- 
2.43.0

