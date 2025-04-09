Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CCFCC36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 16:27:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E3DD838E7;
	Wed,  9 Apr 2025 18:26:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UI30MEJ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A529838E4; Wed,  9 Apr 2025 18:26:57 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::629])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93BB9838D7
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 18:26:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=koTMe5bpvqPPjw9d7Iplvh8zCM6+G/sTuB6miQpIQixjoQrGTictvNU4eChkTH7Ml//eKohfoEt8sI0dkbZss0au7ozhahWqEmS9PnmY/BgXkc7vs2cyUv8rbkCpYPOczyvdES9owwcDf27N7ldlspOVzZNzUWlqz9pCVRgWuBzPnTLGQI3TnscSWyYC+lcTDFMrYejC59snRrJDcVNKe+rtNQck9vYxuDrvPZuYDVtQMRHl0II3ffGL/LPZwp+xK2Mf1UM+V3GpQfYXDcPSL84y3IkoFYg/rzwm+YFSwlpzlCSa9IWx/PGjO/x3H6Y9TXB8VTrj/ZYNJ1JQzp6uKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGOgD8xSDH6/IuraDQgfDfRP58OqmC9TnQYg33GhQZw=;
 b=W3c20/sOPsYFNB1nj8s+y8bDhaQCbIe6h1y2AP37ZNHq1O6OD9+Y+AhHhXVqZx/wNPWm5sFRAqiuulE1nIlJMxgsC96Zo0vOAbZwKdZsqINpjRmQZtLeDfWnUkGbInmfZyOsrg4NssN9mDnsdWt9cdWaHzKcIASSTaZVmOjCZH2QvNIOdR6Hx52aDryrAMwi1BXeT+SAq/GVslUBtJTorVuT8i2Kn7AbRrACHc7jjibc8rD5Ds6UDIP8aRF3CC3ewThHx279rcYKZ1LIv7NMTRnpkLOILeVxIJFbot0DigBggGYUWoXF5lm6co/yyfsvz1s9gYGbClvAsCJ4955PUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGOgD8xSDH6/IuraDQgfDfRP58OqmC9TnQYg33GhQZw=;
 b=UI30MEJ++KYKWwHdu3CrW3Rc+57uFPKR1Mdi4jyE8KQrOamSJDQ1bCi0VfQOY1qeoOxsXJnpiiRYJUAA7nWkWTcpi+44BLF0vbv812GkgNmZkJbfR8w0aW/wXJ/MpZRpy+aiR2vfv5Yzkn7aFXm/PUFGutEIcmy+HAEZR5f1sJo=
Received: from BL1PR13CA0376.namprd13.prod.outlook.com (2603:10b6:208:2c0::21)
 by PH7PR12MB7332.namprd12.prod.outlook.com (2603:10b6:510:20f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.43; Wed, 9 Apr
 2025 16:26:50 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::56) by BL1PR13CA0376.outlook.office365.com
 (2603:10b6:208:2c0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.8 via Frontend Transport; Wed, 9
 Apr 2025 16:26:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Wed, 9 Apr 2025 16:26:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Apr
 2025 11:26:47 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 9 Apr 2025 11:26:46 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>
Subject: [PATCH 0/2] arm64: versal2: Read an eeprom
Date: Wed, 9 Apr 2025 21:56:37 +0530
Message-ID: <20250409162639.588487-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.44.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: padmarao.begari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|PH7PR12MB7332:EE_
X-MS-Office365-Filtering-Correlation-Id: b4dbd662-266b-49b5-a6c3-08dd7783543f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zmTm1U6giQ+g0zvhH1demmSUGEBIKfmsBn1PbxDxK8ODRauk13YmIjWeJLtd?=
 =?us-ascii?Q?xNsK/eLC1TDkHnAWTzqZfhxCLBKJgUmJGmwjALGYLnq8zwzF9Mijas4dTAX8?=
 =?us-ascii?Q?t0f7ycDSeSTrev5nrLDro6eCZ6Y7dtIIK3cmO9C5sb2Nq0mBhyK/VFmoz+JJ?=
 =?us-ascii?Q?eIqdBYyFzakeyfbBhnw3T6wnbf54S5U+Yf0Y9ZIr6XThkCSxhWM9OdAbrWQX?=
 =?us-ascii?Q?M8BfEAex9FZBh4zeoF0xEogLREitMQ+AKGTjo/8kxD4Zxa/i0FR7hLWzIieT?=
 =?us-ascii?Q?2ZytypcgMmxzdQSUKcD868GMAwuGLH8BRKG1ve+lHGsSHVBi+nFqNZQzqHJD?=
 =?us-ascii?Q?alcmWmKhgLfNE9mMLjXCi4H47APvGTy6cs7rXZHDf3pNrZMIOaONM8ST6nuY?=
 =?us-ascii?Q?t7+R7YbDdAHS8UkyN3NsS4B1dd+sShdrzzLqhO889Wo9GtUFsNzqZAZQ+UWQ?=
 =?us-ascii?Q?HOIevxmaAWrwNaY2+plTWVSm2MFH4wISCRpuYkhJmIvsvB4E6Qn1j4skzuEX?=
 =?us-ascii?Q?9eQVgk21wS5vNhLMiHiHZWVvClZRU867pSryPNG3il4kRttK3IjVp7u7Evxz?=
 =?us-ascii?Q?7VCm1ZX3CXdUa2/U3DhdV2FRQA3wNdLPrRIr0/BRVr2bwunnAb2on7woWMx1?=
 =?us-ascii?Q?Siu4nIjyiwdsgtR0Mbaieo0er2xoybsnbUKK4MGo2Ud1NxWfa84PYm4lRiik?=
 =?us-ascii?Q?bYDztlc49Nh5HKkmp/7scsK1NhnVAZ0dTneJsAOpGLKJwGdH29WmoGM9i+Ao?=
 =?us-ascii?Q?ud/cXw/hmoTS0VwIkLucFulU9DlhsJzDr/5KHtz9ak7oXLi3kA2fpCspBjak?=
 =?us-ascii?Q?OZ2N2Z1K9WffqRBWi8tdG15u0Clisnz+41jM6MNKb3ZfsERNajpRTZT+ceDv?=
 =?us-ascii?Q?u7XBNgkt91nsUEoY0iD9uccra31IEtnrPHQ0munU4UrqE9o/o1CWYsQcwaKe?=
 =?us-ascii?Q?Tb+CJ6txOXcMSRC40YA53LjtiG1ibLjAgM30iVLr/wfyz2iY/IKntYZhsY9v?=
 =?us-ascii?Q?Xni7IaFQj/xofPR/J2f8Q5V6aMEjrNkHZXJ+KLYhuuNKOTXNauPcMA/HOxGO?=
 =?us-ascii?Q?TYpH8oV/S4LYpKY9aJrP8fNxS1cya77lZL5cYZ8VXHAK0fGoI2hUvxQayHGZ?=
 =?us-ascii?Q?Apvthdk5q4bjaRW+FFWFWvQd6OzcNWMBUb/Dew4sfSO5Ev0hVjkcbMT0Uxes?=
 =?us-ascii?Q?aXq9qmPTpssu8c9Yb6990X9l8OtATVxErSDuN5AKlGBAKpIh3iPkXrpYllZQ?=
 =?us-ascii?Q?KSFdlyrPhVNzxuvojgEV+xuIYFNjyleIdI0q53TUcx7bvCJAEkHWMofEX3u2?=
 =?us-ascii?Q?uRvM/mYbkOMNBE/LItwswHFs4ks4JyVq8i7c4vDI7wg9VKTvvaoSwiNN4RVb?=
 =?us-ascii?Q?3JKr2TjWjbz6zKnOryq+1xna0eMW8FPOvRdqniyqCMKuipNcKieMgPag0t3s?=
 =?us-ascii?Q?YKj5N9VO9tS/ShOBxzRS67qK9H6qY1NJp6mdB6TRpSKVuzF7emMpmITTC9MC?=
 =?us-ascii?Q?wtv1joEsiufgOH0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 16:26:49.3263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4dbd662-266b-49b5-a6c3-08dd7783543f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7332
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

Read an eeprom after relocation if multi dtb's are disabled.

Padmarao Begari (2):
  arm64: versal2: Remove dtb reselect and multi dtb
  board: amd: Read an eeprom after relocation

 board/amd/versal2/board.c          | 3 +++
 configs/amd_versal2_virt_defconfig | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.44.1

