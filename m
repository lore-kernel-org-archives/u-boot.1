Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C635DC021B2
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 03:01:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B42480207;
	Mon, 24 Feb 2025 04:01:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="szSy75aL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3869805C3; Mon, 24 Feb 2025 04:01:55 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::628])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC39080017
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 04:01:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=usgStJiNn2HATR7Qke0MNCWazCemh69GpnT4iBgcxWSOk8HRozLT7HL6HJmQ93e/3k5f0l5ZburbEu8+GLusCEeit9TV2vSEtpxMQ+cwJFEhYITKMsMuP62xdmwwKltmwBrEzR3waumE1H/Dfu1/9fVrJsianihu93GnmjnBo0nfeEf1K+issBMwQiPybuWwlY509thWAwsdqGMsvAiQOSmpFiuPEMIkZ+3d+/GM6Qa8qnCVuB9BnCKFr0gpN+mNIk+Uqm19jzdfChKPb+bKh58Gm8u8B7jRSh96rWG+XDgVH8ZwaS+kgLCAosq25L6huFhTN3y6EhiSZj9sWX/u/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eqRCepwwVp3Sc+rPjIMUF58viLvjCP7ch+fM0yj6ug=;
 b=si79K6JaAW2UgwDhE5HAVSJzvQb8y40qrQ6/I8Dmr9Fe2XLy+02BfC2gy8TO93Xdx4jKU4JUhBKqo/8uankQmVONjbtxv0+xU+tcz/eoW1a3hIR/LRoXhSx3fA44aStM7SJaXRRx9vR4fKkOvrMdvhVeZuvyjyYIOUxRGEnhXLKTdRhNpVpJBjjBVdUgG1Nqg29VwgDkZfroD8CLB6WKP+FDELYX2yHdNVoP3k39haHkPuKBQUedlW4E6iMP1q2D9Bpk7fj6owY7HvHCtanMC8Ci7wBXuKPdWsjwE40HggOy+Y/kbF4jX9W984iTcgEg2ZtuI+DeTiDmvnTQGR7Kfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eqRCepwwVp3Sc+rPjIMUF58viLvjCP7ch+fM0yj6ug=;
 b=szSy75aLZ3bWTQ5mlkgRgOkoimnXpa2HdFTocNCFnYaG6GLv6DXIZSBl8qPGhSGJP1GlU4N2anDVcS/kKDQMhLMKkkQejb1iDxkWzUf0Gm3trYm3v0iMQdoCEh53GF55pyQpwcOSEjNqdz5t0GPl4OeO/Rz6RFBhlUJ3IE+Q5LM=
Received: from CH5P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::14)
 by SN7PR12MB7274.namprd12.prod.outlook.com (2603:10b6:806:2ad::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 03:01:46 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::6f) by CH5P221CA0009.outlook.office365.com
 (2603:10b6:610:1f2::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Mon,
 24 Feb 2025 03:01:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Mon, 24 Feb 2025 03:01:45 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 23 Feb
 2025 21:01:41 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 23 Feb
 2025 21:01:40 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Sun, 23 Feb 2025 21:01:39 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@amd.com>
Subject: [PATCH] amd: versal2: Add the UFS boot mode support
Date: Mon, 24 Feb 2025 08:31:32 +0530
Message-ID: <20250224030132.1741582-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|SN7PR12MB7274:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b97a853-7969-46b2-a0ca-08dd547f92ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eSv1t54uSfIGoRVEcIpOBRo6o4YWwGXrv79iSxDVxOu2BYjO0rQ4GAIza4bV?=
 =?us-ascii?Q?saEd5inFdXdXY6AmObdULewvxzQ7ugcKAqoPlDXtLdGVJzlFCOv+gS1DvPPY?=
 =?us-ascii?Q?YqtMNapMfxj1dxBC/YTBJwKvBQ09cdMkSzKueznbCUZ93Qn1SZB4EmxQoZzX?=
 =?us-ascii?Q?GXS9Os2oVMW513TsTvuxd32b6MxUTNyOT0coDJzgoJlKDdYi1BBp/QhtJyiD?=
 =?us-ascii?Q?HPk8Ec8YtxkZDr6O6qTZhCm7WslM+jqhGEBXOCYHTXISo3b5uviGq22xsCdp?=
 =?us-ascii?Q?SJOIX3TkVEu80VDz3fhjSs1uXx11s/xMw3qOlGI5ydGYDUTZm9zxxoDa/McR?=
 =?us-ascii?Q?MopR/ivKzt/l3koH0k85FNZNmQ72hdB3du4tLjhnOe9+9wEph+TlsqfGq/QH?=
 =?us-ascii?Q?pQm1PIxvDhNNhdC50wMuXMS/2ss9yX2A+wkB40V9f7XwQvcvcL2zfyLx6g9A?=
 =?us-ascii?Q?i/VELxljSr/xl94U94RGCleLFIkm0pVsmXUbRZTtf/XyK2k9bQVCuwhXobhx?=
 =?us-ascii?Q?YsyLiMy9YGJ68wZsUexl0FlFKUZDHguM/vaQfEY4LJqnU0YmCAsTB9rfkRq6?=
 =?us-ascii?Q?xI7HvzjYKt62sK4sfhYc6qRRvtX4oYyvQ/BC+OnMUS7AOC6KXH7TDb2ivobP?=
 =?us-ascii?Q?PGtEtIjfGb18yJwEx5G05Fnct6YYQQX8N5JJ2xuKGl2F4fgg7ofqaLrCpFxr?=
 =?us-ascii?Q?EkzGyzZo7flBZNtH0t1eFFFjfRwH75D8BTGIGbImMNRIyTm12xN/+CqktA98?=
 =?us-ascii?Q?xSMWcssJq52KD1vCC+aw9gjG0XQDyASBjc0kw3PYN3fw+vrsmtCvAssh48QM?=
 =?us-ascii?Q?ru005RfbyrA9W0gwGl05/9gZiydFLt/kHnsZ4MygJozP0m12ubbnUo50cxEt?=
 =?us-ascii?Q?B1bwboYsmSyHR0W2hUo9aqUTM8RUbNvBERdbxwg4Jd+btIZMRpKXOrLY9FU0?=
 =?us-ascii?Q?zX2WEbhubDpqo8vfyR2NXb7WsXYTWXhKWWZPqqlQgLqBlX4k0l75J6yAHMiX?=
 =?us-ascii?Q?uzxAixHjMi/tE2c+DDLW3envjnXWVVe8l1Iy7msHhLtB3BNGhnTErg5UbByb?=
 =?us-ascii?Q?TMmO1tYmsr5Rx6m4Sv9bHm6ZSEq1by9dT+Ym8DPvXDvq8xy9QRSSqEgEfx6X?=
 =?us-ascii?Q?Xhlwbj4SYs8JpGURUuXtySnNZh4H7mirXFiJ6/iBJkt0RS49paVpTg6FFTsn?=
 =?us-ascii?Q?lOtbo7Rn+JrbA9NfAP/Ky6/K30pH+ml5OQkHUSWjThbfLf+Nq2Tcqumerybv?=
 =?us-ascii?Q?bqV7gkCfkr5esOae9YVn3l/NqkYWHhYh1L4OiuqW8YapKFLK/K53mZrfNnhX?=
 =?us-ascii?Q?O5Zc2n0o2M4tMxy66NgGsWzaeRwlUTyTSOKxDiRptEw0Hti4Q06p26118k7n?=
 =?us-ascii?Q?SJsoHJXazdCJfehheMsEny+IwKlwGFRF+V6M8olw1pqzG5X4SBsNj19TvHDz?=
 =?us-ascii?Q?6OXoFBsCJlMSRaGl1tqaMT1AN97M2HggICbIl4VgyFSvoKngf9YR81z03c0B?=
 =?us-ascii?Q?Qe0fJMKhkB7EVso=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 03:01:45.8323 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b97a853-7969-46b2-a0ca-08dd547f92ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7274
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

Add the UFS boot mode support and update the boot_targets with
ufs mode. If the UFS device is not accessible from APU and
running this is detected as a warning, as the device is not
accessible.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 arch/arm/mach-versal2/include/mach/hardware.h |  1 +
 board/amd/versal2/board.c                     | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/mach-versal2/include/mach/hardware.h b/arch/arm/mach-versal2/include/mach/hardware.h
index 42e3061a0ae..022c8b3c832 100644
--- a/arch/arm/mach-versal2/include/mach/hardware.h
+++ b/arch/arm/mach-versal2/include/mach/hardware.h
@@ -67,6 +67,7 @@ struct crp_regs {
 #define USB_MODE	0x00000007
 #define OSPI_MODE	0x00000008
 #define SELECTMAP_MODE	0x0000000A
+#define UFS_MODE	0x0000000B
 #define SD1_LSHFT_MODE	0x0000000E /* SD1 Level shifter */
 #define JTAG_MODE	0x00000000
 #define BOOT_MODE_USE_ALT	0x100
diff --git a/board/amd/versal2/board.c b/board/amd/versal2/board.c
index 5651d516a9e..24c99a28082 100644
--- a/board/amd/versal2/board.c
+++ b/board/amd/versal2/board.c
@@ -252,6 +252,17 @@ static int boot_targets_setup(void)
 		mode = "mmc";
 		bootseq = dev_seq(dev);
 		break;
+	case UFS_MODE:
+		puts("UFS_MODE\n");
+		if (uclass_get_device_by_name(UCLASS_UFS,
+					      "ufs@f10b0000", &dev)) {
+			debug("UFS driver for UFS device is not present\n");
+			break;
+		}
+		debug("ufs device found at %p\n", dev);
+
+		mode = "ufs";
+		break;
 	default:
 		printf("Invalid Boot Mode:0x%x\n", bootmode);
 		break;
-- 
2.34.1

