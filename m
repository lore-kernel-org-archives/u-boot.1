Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF94ACCFA15
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 04:55:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D942388CC1;
	Thu, 26 Sep 2024 06:55:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lEab/iJM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 159EF88CBA; Thu, 26 Sep 2024 06:55:33 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::621])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD9E587BF4
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 06:55:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJy79p1LECSuahupbscJzgojkIhCPBeMnHGbRt34v8XfyQ8sGDpsLh+HPEQHnNL9LLnWkVwzXJIHMPXtTtG9JpHG9FVo+vq268Gu9oeS77XEo1zM0yjjBC7K7NMQU/K/QqH6NG2pDLr5Mw1BLStTq6/yPWqLY6n0ryC1uaTUYF/aceQSl2iOk5xdmQDUlCjBecj7+77Y/euFkbhDEH9B8/9VyKoB6yln7ZYONwCnU6PoYPPHBpKSglYaDcvt+auAHmcIO7A7L6uY53F9+wfZNKlCeEIztdPU6eRG4osfwYpIuSdDg16JuLyqeidGUiUhBtBeds1NBCSE/YqAs6PRRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwJWLzOT05kw4o2GE1j0jxs9y5+k22BUbHqu70IOmyw=;
 b=YTdIuQwQG/8gKY/wrPXF/rMDSqyD3sG8QQl4g/DgHcGMnhpBQ7KOeS9bmOFAbq/FW2Pm1Q7za10OtG5K0WlfFzP4aFzPwO99SaCBia9bysC9cGpyCLCi2Da4B/pQ0FpeQYpsqaBPFK93vFT4L5M8Si+WXb6lJxkJ23pqQGjYP05UT9eF2mpL3HqEy+jahmvBxjBWZUzTShNeX1OQhEC+BDDcWNMeNJzyJFBLlNXatOJlUNT2GRH6ASWAkA7WCg7YVeWZ9iY0NricFOcvH+gVQ9DtrlE8xnKDMekhyc9QfVxNevuAHM7gxRym2fYemk5byZsAuKldloQxuJGRpI64sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwJWLzOT05kw4o2GE1j0jxs9y5+k22BUbHqu70IOmyw=;
 b=lEab/iJMNXYINqb9/y/3SdJEMQZDzCIQQYUlS3kJ/tR2LdPUPUs0xRgN4HeaY1T+l6G36oMn5KnNoiNEpOXq466LZ/vKKI2A5/+zQV4y63jWTD/8aro+zRdRcH5uN2vyHDC4JsqLmQy7l/cqRtj+XHKphpuXhT6lhlgLydHHjZ8=
Received: from MW3PR05CA0003.namprd05.prod.outlook.com (2603:10b6:303:2b::8)
 by MW5PR12MB5683.namprd12.prod.outlook.com (2603:10b6:303:1a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.23; Thu, 26 Sep
 2024 04:55:20 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:303:2b:cafe::86) by MW3PR05CA0003.outlook.office365.com
 (2603:10b6:303:2b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.17 via Frontend
 Transport; Thu, 26 Sep 2024 04:55:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Thu, 26 Sep 2024 04:55:20 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 23:55:20 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 23:55:18 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 25 Sep 2024 23:55:17 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>,
 <trini@konsulko.com>, <git@amd.com>
Subject: [PATCH v14 1/8] config: mx6sabresd: Default don't enable the flash
 lock
Date: Thu, 26 Sep 2024 10:25:01 +0530
Message-ID: <20240926045508.1492638-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240926045508.1492638-1-venkatesh.abbarapu@amd.com>
References: <20240926045508.1492638-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|MW5PR12MB5683:EE_
X-MS-Office365-Filtering-Correlation-Id: db6076a7-5a58-48f1-bdd4-08dcdde76c56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L7K89UjbNSDoGaAU1nNhmnN9FZFgupBAQOHvpkOgs2VSqUoUZRPtAKqw1oCW?=
 =?us-ascii?Q?R+HqKJ7agr/o7kZ16JdTPV+656XluMvyOxnfuiahcAWtzB97f0Esn+0gLPct?=
 =?us-ascii?Q?uytCXajhZCA/iJXmh4ZX7DSosSZ0LxTszp9viLU3DD9geG81y5wevIcLEwTG?=
 =?us-ascii?Q?2PYUgCqE2ntA+YT2SNJN2s5J1ERECeESJDdf3n0tYE5ZoorPcJH1YMAU0CpI?=
 =?us-ascii?Q?RgfFCZaQn3rpjA1HglQMBRcI3gEeVbMY6zvW+45GZf1q2Fc4HwFAbtq4C9bJ?=
 =?us-ascii?Q?1/SAM9eHbU8+BMc8FD6zAxtDnKh3lWKuzoI6RpNWcUwYTpPtrUYZg+tOha0x?=
 =?us-ascii?Q?bVdHhfqJy24MSVzqbrCKWQ/qcQw00wgjTUWwhtCCVxX5jAV+I1eXsvsz1KlE?=
 =?us-ascii?Q?4LQLGdHkxwL5L62T42CDmxKgpLLkwOvwTe1xMo1336J5hbUsSZBRFKxFoc/1?=
 =?us-ascii?Q?KtQJulNZ1wwP05J2zY6vzxu0cFMTAdbEoFdNl9ZHGJvzrtmPIdcQgT3Ak20/?=
 =?us-ascii?Q?/rTzgz6QRfzlAXEsXvop0gIRbuBE6xORJlDSmtues4gPZl1SH2ewlnEBV9XM?=
 =?us-ascii?Q?glrgpiPjAv4mlbcstJGCeuRtLvdj3l+8EJZmwUAEpyvZT1t8f/+hK7pWnVUI?=
 =?us-ascii?Q?2on/JiBPgQ3mTAR3bGb44qhPRipKdC4Vt6OvTwrvECUW8EowrMM+z/yVMT6b?=
 =?us-ascii?Q?sFNrC1og91R7pScSIR3bqUXapYsOwC5K91t94D4JlFcwI+nBYP3sbahn0kIo?=
 =?us-ascii?Q?zxKFDh/uDllezOBtQs0NqeiwcraG4kNm8TJMNbGHnubjE4WCTJ1neLqldJC0?=
 =?us-ascii?Q?rvxbuGgBJN8zxHk5p+iINQGbvRR+Lcx0OJtK0pJfnkLAIp8TG1zDPQK8QrBH?=
 =?us-ascii?Q?PIHtLsQ11a+8tqvlJGNfy+URxtVCEcEEyzOnCzKPi/o5fj0+ARhh20Wvmdt9?=
 =?us-ascii?Q?nD+7KBSolpmDczsHxgpBN9FO0nRaGjytXKb5u6TFzL8bQ2DD8tLwF2q0YWCH?=
 =?us-ascii?Q?742us/tSNM7vzC4juXlRbTexX9kqCttf7RbTvik7zlbzrHSDAkRsp2b+DZ8o?=
 =?us-ascii?Q?jLUQEIGcEgpBt5kzifHGouAOWG6abWzqPRN26T9ys0C+e0qDc9vBH9QYuZvy?=
 =?us-ascii?Q?iGkVPINvqgooyGoKfBgd2BEVI3V8cNDYIV1A0o8UI5HURzaeiZFt9OEvq3Pl?=
 =?us-ascii?Q?KmOPoqikHxQqoyMyip0MQcW3YwMrcMnLbwH/BFfhFBrr9i/OgZng1RINpgpA?=
 =?us-ascii?Q?XZSfsPdzKONyXQqWVV+Q3aTjPqfQMMaL56p7sRhH5hu+D6vCj5MT8GAyaf9W?=
 =?us-ascii?Q?Tx7zqSsWMTXtNGhf7LKlslTG0c5pIl3PEAf2KON2cUZGpK+XxLzfGFgsxkMD?=
 =?us-ascii?Q?HLpJpHcNsnzQ9UwWuYTAtene1BRR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 04:55:20.3169 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db6076a7-5a58-48f1-bdd4-08dcdde76c56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5683
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

By default flash lock option is enabled, enable this option only
when it is required. By disabling the lock config will save some
amount of memory.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/mx6sabresd_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/mx6sabresd_defconfig b/configs/mx6sabresd_defconfig
index 80f7cd60b5..2a83b8cd06 100644
--- a/configs/mx6sabresd_defconfig
+++ b/configs/mx6sabresd_defconfig
@@ -86,6 +86,7 @@ CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_FSL_USDHC=y
 CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
+# CONFIG_SPI_FLASH_LOCK is not set
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_PHYLIB=y
 CONFIG_PHY_ATHEROS=y
-- 
2.25.1

