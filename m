Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1865D6E2C9
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 08:05:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B02689666;
	Wed, 20 Nov 2024 09:05:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hCSY+B89";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4064C89667; Wed, 20 Nov 2024 09:05:47 +0100 (CET)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::62a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5227289270
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 09:05:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oIB7Qla7YeSqI9Kt/Rf18abMQvV8oyT6+0yqQGWbza/OsAQvcIlL3k8+ILnN/bdop1VKYLwcVEZcPYS8UzvNLAc4vcNltAY+WHdExup75+9okitrY7HGn1EPT9iOBbmmq3dc0M/AjyaSceKO/SNOJpjSwwUZI7PDospcY2hBhLMrQYm2ccK39U9vj+fIBJRy8JDLD2qfTHCWFkWTDide4RHIKw8J9pTqadmYcCv9TwopNe+37Xepu+NSjQBWI5/24hmGdRs8OHeibpeEsb0nJai2J/dpr29lho2qsZ27uwO0LkVhYHUNVfel5CvCQ3houPdgYc1+0Xw9XxMIaHHrCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/1fPY+4VQtqBNrx0GQt3PgcgU5foDB/BdQg6duEMnA=;
 b=SLkGzezdmSRgKkFlw9h5EJcOtRYISyuw0io+huNeIWsrox9pPqtNGg7XjMajY9Mlv9i11N3mP4AfurgzZ1axYzKY3jXsCamJTqMMCliVGwXAEDLBnYjjThrFy1cgnPkOq5Np75FsaOQ8grOxVqi2bSkFM9GDwmTSwanbMJObJD4GV6TeaHh4rf+JT6W4G9w6aJcBcQLR9kbMChPv7Bn5ebOrcpYU0YBStZ0C9pJD2lyWJGrKNpe5c2A8QsPpdUHabBxcgHT0Ul+0CuibzfL9qo/4B3NQn54kZS98ehTiufnb1Q4Qx7V9OZG9QhOSFttLrEj7q9laeQ40ZKVHyJRiRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/1fPY+4VQtqBNrx0GQt3PgcgU5foDB/BdQg6duEMnA=;
 b=hCSY+B89tpMFv4b9/yrH+3FLBiAHB8QJIIG18/s5goO4fGbVwSBl8oix+o1xU1gGqo1P7lgee/ItCHtkK7uwW2WoBrQ6ftor16SebMufA56HgADQoZHTdtYe84Tj4dKTvCr3G3mIedYl6e+B3WOcVU+9WpQ27oRNre/YfaaQEwM=
Received: from BN9P222CA0024.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::29)
 by DS0PR12MB8786.namprd12.prod.outlook.com (2603:10b6:8:149::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Wed, 20 Nov
 2024 08:05:41 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:408:10c:cafe::f9) by BN9P222CA0024.outlook.office365.com
 (2603:10b6:408:10c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Wed, 20 Nov 2024 08:05:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Wed, 20 Nov 2024 08:05:40 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Nov
 2024 02:05:35 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: zynqmp: Also generate images with single DT
Date: Wed, 20 Nov 2024 09:05:27 +0100
Message-ID: <9362da506c13382da0c0d41ad8a111d9c1150f08.1732089924.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2964; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=IdwCOuVHvZ/VvIeAPVMwmcq4eh/ko8b4CKK8EFalEbk=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhnTbGR7SD/XKPa5Fise8fji1LLUqfP6JtdzmSnaM00JSL
 Bhfi8l2xLIwCDIxyIopskjbXDmzt3LGFOGLh+Vg5rAygQxh4OIUgInc4GFYML3+sY7JXREn9kWn
 StfKM5pOSdSewjA/VfKPYM2vpL0PCqf9N3Vb8is4smsqAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|DS0PR12MB8786:EE_
X-MS-Office365-Filtering-Correlation-Id: e9196d6a-5260-43ef-5155-08dd093a1fec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s8iIUxtHjj6pVlDyvnl033sNxF+W3VXxDCrmoeyy6LQUrmhxwnf5j5hOzRMm?=
 =?us-ascii?Q?VFEZ3ctHHGsxhV9v3J82SlO8EIeC/14Uxvn2yAe7G0l6zOliP+4sduJ6OEAm?=
 =?us-ascii?Q?L61Q+cVte13g8d6fSwNpiYMrk0xhIgWctP4jdmuLr02j1dG/by2XQzY345kR?=
 =?us-ascii?Q?B2dM+0FZxTtbKEut1qtT0ek71FWSrfkb9tXSnVpZ/vwYZLTbCcWjcRNj1vHM?=
 =?us-ascii?Q?0pm/VpqUlRmXwAREKDGAr80UWtpdukXyLehMpB9s4+Fam6cuAN3SiBM1cdvv?=
 =?us-ascii?Q?TDBypdULOuCR16A4tr5WqBpRxKwuHtPQukT0hWdziDJuKXcv4Qm4ErXlfndF?=
 =?us-ascii?Q?6zVBT4lz0tZOArekliTjnkDMrhcUCk/ImhMZBpLjs5x2aMiS6yyFMJ0KIoEM?=
 =?us-ascii?Q?Sbr9v32BuN+DzQSrOcl6mV3RrNXw90mnIoerbKjNtg5dqjeo1GpCLtyAL0Fy?=
 =?us-ascii?Q?rB6FKOxvkmseR7EShUlznXS8qfbW1rsxnT/yL/CJ6HJoVo8BiV6et2IDaCZF?=
 =?us-ascii?Q?bAQphuZ80mMsffrbmxHhvHWGgP6iRjRtvteGIPwK3XlABp7FU9jLb4vcijFU?=
 =?us-ascii?Q?V5M6pG5LdldjmHaZMV2bj8zNqxHJu54Fr19/Ih4JGwqlzLSEhgpavnHTLA8u?=
 =?us-ascii?Q?mRoNfSLdta6IoiaGoW14gETDGdtx2eSpwhM9BTCPNknfL66oOe72DXoEeFIU?=
 =?us-ascii?Q?3py2g0w5P8zi5WjHNQVy6CbkCtneqHjHyOBrtvJtXhdb79sgAfoKtI+5MY5t?=
 =?us-ascii?Q?ZRWhXLFfksHr1KOn5p2a8qsW3yRzkx9AFPJYYJdb6jefVjk9UnmuWcqYwC4Y?=
 =?us-ascii?Q?ODtC67biXQd2V0Rv2uxEvEc9Mx9zopNUwnT5EKTcG/e4DAROxLZB3WoUJDi1?=
 =?us-ascii?Q?1p35hqFToWaGVCLQBPOLjj1ZfuslTVEXwK+PgRq1pECT30VQ6Sf0f4UopHWi?=
 =?us-ascii?Q?o5MHcDfx5FKft2n1Fpta97aARCsDxsHB/cbhIoSRUwtmw77jYlt+epbZWNka?=
 =?us-ascii?Q?squoF1znD9x3vrRW+J3wp0l3WLqVt/fw2yu4sPFI3s+hsZCnDj8YehZ3Yi8P?=
 =?us-ascii?Q?SdJH7Rfg3KAxKZEuy1fJrdrve+uWI1TFoW8WDrv1Hcv1sYq4tULAtBeF29kS?=
 =?us-ascii?Q?DCw1whPO8RJfMjEx/CqKm30/fj3E8sVO3XEXCOP7ggqhXCSO/9IdYmUt+Swf?=
 =?us-ascii?Q?uzVUVTECEFOyzue0GiUhDbEstcm+62JKuj8RkuJvHuh2JmHDTuiYxx3xvl4i?=
 =?us-ascii?Q?GwaNKLOkQ91KlhgAUlKOoHvTdhitnKqZS8/PDk000f3G31pw+RLPBo7g/7zC?=
 =?us-ascii?Q?fP/6h0vwR5ZgVwHPHAIQjR8F5edeMtzm2qDsteLs2lXva0fl+Wn2DfrVwAHx?=
 =?us-ascii?Q?OkVuNX/c8pfnYTrrI1TcAHEkCzSNPvyM6SKjO6I7D21zRV69mA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 08:05:40.4187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9196d6a-5260-43ef-5155-08dd093a1fec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8786
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

Create u-boot-single.itb where only actual DTB is used not really multiple
of DTS from OF_LIST. This results in small files without option to change
DT.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Based on the top of
https://lore.kernel.org/all/cover.1730452668.git.michal.simek@amd.com/
---
 arch/arm/dts/zynqmp-binman.dts | 95 ++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/arch/arm/dts/zynqmp-binman.dts b/arch/arm/dts/zynqmp-binman.dts
index df0fdf465107..675f6bf51ebd 100644
--- a/arch/arm/dts/zynqmp-binman.dts
+++ b/arch/arm/dts/zynqmp-binman.dts
@@ -89,6 +89,85 @@
 			};
 		};
 
+		itb-single {
+			filename = "u-boot-single.itb";
+			pad-byte = <0>;
+
+			fit {
+				description = "Configuration for Xilinx ZynqMP SoC";
+				fit,align = <0x8>;
+				fit,external-offset = <0x0>;
+				fit,fdt-list = "of-list";
+				images {
+					uboot {
+						description = "U-Boot (64-bit)";
+						type = "firmware";
+						os = "u-boot";
+						arch = "arm64";
+						compression = "none";
+						load = /bits/ 64 <CONFIG_TEXT_BASE>;
+						entry = /bits/ 64 <CONFIG_TEXT_BASE>;
+						hash {
+							algo = "md5";
+						};
+						u-boot-nodtb {
+						};
+					};
+					atf {
+						description = "Trusted Firmware-A";
+						type = "firmware";
+						os = "arm-trusted-firmware";
+						arch = "arm64";
+						compression = "none";
+						load = /bits/ 64 <CONFIG_BL31_LOAD_ADDR>;
+						entry = /bits/ 64 <CONFIG_BL31_LOAD_ADDR>;
+						hash {
+							algo = "md5";
+						};
+						atf-bl31 {
+							optional;
+						};
+					};
+					tee {
+						description = "OP-TEE";
+						type = "tee";
+						arch = "arm64";
+						compression = "none";
+						os = "tee";
+						load = /bits/ 64 <CONFIG_BL31_LOAD_ADDR>;
+						entry = /bits/ 64 <CONFIG_BL31_LOAD_ADDR>;
+						tee-os {
+							optional;
+						};
+					};
+					fdt {
+						description = "DT";
+						type = "flat_dt";
+						arch = "arm64";
+						compression = "none";
+						load = <0x0 0x100000>;
+						uboot-fdt-blob {
+							filename = "u-boot.dtb";
+							type = "blob-ext";
+						};
+						hash-1 {
+							algo = "md5";
+						};
+
+					};
+				};
+				configurations {
+					default = "conf-1";
+					conf-1 {
+						description = "Single DT";
+						firmware = "atf";
+						loadables = "tee", "uboot";
+						fdt = "fdt";
+					};
+				};
+			};
+		};
+
 #ifdef CONFIG_SYS_SPI_U_BOOT_OFFS
 		/* QSPI image for testing QSPI boot mode */
 		image {
@@ -106,6 +185,22 @@
 			fdtmap {
 			};
 		};
+
+		image-single {
+			filename = "qspi-single.bin";
+			pad-byte = <0>;
+
+			blob-ext@1 {
+				offset = <0x0>;
+				filename = "spl/boot.bin";
+			};
+			blob-ext@2 {
+				offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
+				filename = "u-boot-single.itb";
+			};
+			fdtmap {
+			};
+		};
 #endif
 	};
 };
-- 
2.43.0

