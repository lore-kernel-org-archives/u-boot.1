Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65AFFC282EC
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 12:29:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACC8680F9C;
	Thu, 13 Mar 2025 13:29:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p5+LrYWY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AAA38168B; Thu, 13 Mar 2025 13:29:06 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::61d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5751A8007D
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 13:29:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XURw4Ve+lTiY8s22AIEGeSkznTbMeY4uI4eVtzlUMhbHz79U8Ltu9ZFvRgU1cy6baQ9tPmmf/mjmSbfWekPE2jljO++OTjy7hjLRhFU4TVbIwbhgBGAtlXq/6QDZ8XhA0qdEfykufBAWqb7divOa9/GqKoza5RjgsdHOHt0sEBNsPJ2iQH/Yqe2FclCpFyOL7HSPNUws8A78LlP49FzCcShZRczBmwTBUOcC4prT+6RWfvuyn+YnQHMj6eZf77lsZFNqlD2MVN/FFNHdspn1+P/OFnSAF1MWHzYrt+qp2sv12LJyivxNceCe4eS9f+d8gYdN9vMD+8Tp2L2K2B8dgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjoNhr9eHF5bORlxqKo8jcpTN6A7m0dJybS71GDnhhQ=;
 b=PymfN3+GlP2/N+vAwq7ZHfmuodA74g3kkZOAeB/VXuiGZE7aue0mWQFzCBFXKv+glgbuyr6Ptkp1iq26qW9XuoeyDJt+eHSpMNbushTnmYaVjXStnH4k7IknIJLC9cp2IJpJOHziq6SLx6M+YNKL+BXVctst4pwQMRISzSy5tCvo16EOCTCC8D38GMU79AB/spRpMJm4FOpTN0vTN+YVn5VsTgJSRpzNumCiB27NHCiUDfomuIRknFDUet8Ei+VnuLiLfw9/yT6W2F7iChif6nvLD4SOV5Pv5EF0oxkljCBYb+mTC7SdrktKrSiTWXqpUy1Ysfe5I4VLtpVnuS75HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjoNhr9eHF5bORlxqKo8jcpTN6A7m0dJybS71GDnhhQ=;
 b=p5+LrYWYTXXmq/IiQ4HeLHQqz5hOL/ltZFmtuPLGpPsp8nvqfFBYtJZQAoMlHQRTto+dunOiHdCIJZyQWdFmWguYce5wpg6ek2wTnduem+DaMm+BA6kGDN8mrwyFlKyfjqdazRfT5oSDLG3f4+gmWJos1ptkkhArG3Bfj01Qfek=
Received: from BN9P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::7)
 by MW4PR12MB7165.namprd12.prod.outlook.com (2603:10b6:303:21b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 12:28:56 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:408:13e:cafe::16) by BN9P220CA0002.outlook.office365.com
 (2603:10b6:408:13e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.25 via Frontend Transport; Thu,
 13 Mar 2025 12:28:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 12:28:55 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 07:28:52 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Tom Rini <trini@konsulko.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: [PATCH] arm64: versal2: Disable debug console
Date: Thu, 13 Mar 2025 13:28:48 +0100
Message-ID: <aa122482cf5b32ded4497469cac1829c6944f0fa.1741868926.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1122; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=L4qc64GRyrYN5cmSMfII9/uDESw7cwlbx7kT0g+bbYw=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvRL5xuf/L+zp6Y1ifuNdaWIXJWpx8kdRSwbch2vcjbeX
 Wz+e2JORywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZjIzvsMcyUFG+N2uq/9K6Dv
 c/fxnvwQLe0ligxzRSdknLGwz31bfUJ367fIsLvWab4aAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|MW4PR12MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: 60e00189-42c1-4cd2-a95d-08dd622a9f0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FM8MeuYhCcLn9DFMFnltcpIApG0CJeb2WJAsRRlBdmlLWddQIOuOQaWNVUsM?=
 =?us-ascii?Q?aairdU0LCL0CRHZav00bLhzZyeCP7+au/ZFX1vCbRkdU39/1cAsnsElGqRvN?=
 =?us-ascii?Q?+Hcw8Cm61zXeIrMx42XyXYSgWtzNYVtXZYpSuspH5oZAF+TfEjxF25kjEnY8?=
 =?us-ascii?Q?y1qu/J8G2JerUDdIbTfvwGLRfvIFKrXmzNgcAiKkVVZYjrI1L4wfQeMA8qNP?=
 =?us-ascii?Q?A/RkOtB90eIItO1+KKGiTFbttwCo4R+ovB5097gBM9rx66lYyqM56XunlCfe?=
 =?us-ascii?Q?soMpoqMD2eLtHD6rgRwGhyUxBejJgrHo/+ZT7AqZvNifqG4Kz8mlLFIkJCTN?=
 =?us-ascii?Q?XV+u6+Gla4Q9tEqjCnrpV/5el3n1qRiAzTtF1TL01KCXTRGXuJ7pY991wbF1?=
 =?us-ascii?Q?Ip8o+9dmrdasG8E6Tcsww+nWoJvr1XztYlHPVSFhjkpT0PMyeKqCo9+fgimh?=
 =?us-ascii?Q?kPna9vI8eKn/bxXniZRJzwuY/53vW3zEYEvyR0DxcgTqW6YQAJZ6IECZeXps?=
 =?us-ascii?Q?X4c1QR7k6SoFHnEvn1e0p+yGuVFy6/ZNNOVVIaDcUF0id512ODtwFV8gy/BB?=
 =?us-ascii?Q?e9+ONJnbzbhfOaQWzeaOemgTq115xn6qUH/1olewsrA4gxlfKQweyS7BAx03?=
 =?us-ascii?Q?iTGLVVU9NM1JYoGqlNC4PwidyEkCH/tG10+IT7rscORZISVrN77VIaJfQOoE?=
 =?us-ascii?Q?6wOZJ77NRleUAFgmWal8ukGEdKye3S7gdXsi3jTgs3uNodGWQjmqlT6ILO+s?=
 =?us-ascii?Q?BdH8z2ejH9AalkAf8YpwgD/4DwB47MYbCbvdDfj6NVBcvZaQh8clTDPhiL+1?=
 =?us-ascii?Q?CegB+AEPIyO2j3UI6mb7aWzFCdqjmK9yX9RXQALJw4+gEUODS9ECvYyFbWO5?=
 =?us-ascii?Q?UwlmLL1qtqSRCV+Na+4hTfOqg2JbQ7d2L5PaVIPuvp+LeOWGuI+oILNaxIFC?=
 =?us-ascii?Q?qQKwEXqT5UjXGDfytHERlha+iNomlgV1N+MZ2dB6rRvupHWyLy6NZuP8mWQS?=
 =?us-ascii?Q?FwxWdTpEYBPnz//tvKRmPUjejkIjOSFlc0GL57VJDYgojrNFeFAA+JUmElRw?=
 =?us-ascii?Q?MPxPGGDWEds0DNrhVMwkGhVJhAdBWl4brM5hePCVLNrC3CCQ4F9ti8/xKGpG?=
 =?us-ascii?Q?XALdvrfWYGEQlD3Kv9RJRdGJbeLc0UM4Rma7zBVZ5ezY4nuUwvFKkqv/UxAF?=
 =?us-ascii?Q?zx4Jfz35aiVJCRzTkPk+l4y+vyO8H1+ZZhqcVKxm0I46wGrDDe35fphKXm6E?=
 =?us-ascii?Q?Zzv6JKJdjCvsCjav3bUDvb2qRMlVtGjAaDxUtbt78iTUpll4gxHUhZxKPFfa?=
 =?us-ascii?Q?/DNey+EwTIvPIAa86vZtHHcoGriV789lZKK8A7T7YLnWc6JE/Q0PNExs0W4o?=
 =?us-ascii?Q?lQzZTR9aq9gq34rGO2dQigCmxkRj2LkzOoefR/lHZmnJSmaPkStvzfSFrR2c?=
 =?us-ascii?Q?9lFCEk955VJa1gkLOzUEO/Sx4L8U4/HVokqSLt7COWeLTcyVmh3MZA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 12:28:55.2918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e00189-42c1-4cd2-a95d-08dd622a9f0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7165
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

Platforms can use uart0, uart1, dcc or even any other console that's why
disable debug console. It should be used for debugging purpose only.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/amd_versal2_virt_defconfig | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index a80a62612397..59bda4c71fb0 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -10,10 +10,7 @@ CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_SYS_BOOTM_LEN=0x6400000
 CONFIG_SYS_LOAD_ADDR=0x8000000
-CONFIG_DEBUG_UART_BASE=0xf1920000
-CONFIG_DEBUG_UART_CLOCK=100000000
 CONFIG_CMD_FRU=y
-CONFIG_DEBUG_UART=y
 CONFIG_SYS_MEMTEST_START=0x00000000
 CONFIG_SYS_MEMTEST_END=0x00001000
 CONFIG_REMAKE_ELF=y
@@ -117,9 +114,6 @@ CONFIG_ZYNQMP_POWER_DOMAIN=y
 CONFIG_RESET_SCMI=y
 CONFIG_RESET_ZYNQMP=y
 CONFIG_SCSI=y
-CONFIG_DEBUG_UART_PL011=y
-CONFIG_DEBUG_UART_ANNOUNCE=y
-CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_ARM_DCC=y
 CONFIG_PL01X_SERIAL=y
 CONFIG_SOC_DEVICE=y
-- 
2.43.0

