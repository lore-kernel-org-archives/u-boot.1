Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07B6D3C54A
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 13:13:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E76C583CAA;
	Wed, 10 Dec 2025 14:13:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qdE1SR3M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57D7183A71; Wed, 10 Dec 2025 13:16:16 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81CA581D6A
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 13:16:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.sanwal@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqDxJUamsjQFQudc9NajN0w4twU6my+dsrEkxNz9dNvz2uHFlJlgqnIuTuH4unSoBEQACvSfhkkB1M8kpdoAgVlFYuVsZensBvnmqMEOLaLieSkgLfUVz9EHen6j7W++xEnDFzYxuKjluC8CiKxFDguB2N2QKKwVavPmcID+KpsSLkoTcVnu+AVQFQlzM2mTLkXyPsDTQSjwaETgbhv4VFAr3ETWk2gYbXcGxf0XkMy0/t9cfrvB/4/IrAOxV5o1bGN8mY6ALBXifxySprw0t8xbJOL2P9pHPq5hKNt0eIk4czuxFB+BWppYfPcZb/5NpczUFUmoJym9SH5Si3TVVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uH0R8lY1iZV40NPwAsSlyrML2IoFR2FmIZ7JTFiUOOI=;
 b=SMoy8z0Ig9tzNfr/91rDmOJM9rBperdhwOloBhgbPY8/tsIwVAHUUzQP1FX+B7/r7v/vgBB44gAuPSgFc/8YbEkR/IxnBUlq0AZHaWownOusg9ZBSV3dwcpBTxMJT4wybfgtOHJrh83XU30FVLc22QjollZ08pmYbQqzBYEZZ0KwhG0f5q7fTp3hwmcf898c4VIaVhdzIjUrWqSPkpQFwsUerIXPb1ExwMDyUzd63VsUkbZ6ldG93DBZ9nm115y6KUdgQzygV1zwPYoOXyjFRutiQyxNhbmQ0GqynqmhV4bR1+zcabERlE9jIw79stU3ByEH+sb5F/xhj3FdNUQFpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uH0R8lY1iZV40NPwAsSlyrML2IoFR2FmIZ7JTFiUOOI=;
 b=qdE1SR3M/L9CD4wun89ksF2DM3IMvlegPWpXX35xUTeIO3/5gqsfGPN1XlqE55YXiGsvDj/88SxzOHPZpB1KDbSS8wLL2NUh/wrd6NzEglZH2Ttv0yKScI3VwTWUD4Ou23S/f0Kh7f2hfqL70GCPQhoA300oN3mdV+eN4ybBe3M=
Received: from BLAPR03CA0102.namprd03.prod.outlook.com (2603:10b6:208:32a::17)
 by DM6PR12MB4219.namprd12.prod.outlook.com (2603:10b6:5:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Wed, 10 Dec
 2025 12:16:06 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:32a:cafe::7b) by BLAPR03CA0102.outlook.office365.com
 (2603:10b6:208:32a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.15 via Frontend Transport; Wed,
 10 Dec 2025 12:15:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Wed, 10 Dec 2025 12:16:06 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 06:15:52 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 06:15:52 -0600
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 10 Dec 2025 04:15:51 -0800
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH v2 0/2] Enable dynamic MMU page table sizing
Date: Wed, 10 Dec 2025 17:45:37 +0530
Message-ID: <20251210121539.1679229-1-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|DM6PR12MB4219:EE_
X-MS-Office365-Filtering-Correlation-Id: 480f16a1-1fc2-4204-53d6-08de37e5e533
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YWE8M7ZZznRcVdhly4JF/eXed2okpE5+64Y6hLh9HRjvnLVk6fZwKP9BzzA9?=
 =?us-ascii?Q?7A0ujq76QV2xJvoevE54fRi8kd7kKqDa6m5HMqWR5W1MoH6ETk5aFAjAY3O8?=
 =?us-ascii?Q?86/yADT782l9dpK7yfdWG6/uBSlV0qScECuaeGsDZi5yf1Kq2Z8geOMuGlK9?=
 =?us-ascii?Q?+inBR1fNZ03ggckVoa4S3sQPHwWHMgTOD8YVU8tQOIe4NGGrToS64A/c7XmT?=
 =?us-ascii?Q?36TJAHjjfIfXAdrjOTvIyIT05QNsg4RkH8+80dvS5ny05ZfbSmXcyREurcTf?=
 =?us-ascii?Q?WabiTiCvbbH7YxSoPj9kDf3S++sFZYCLmjLnxsOu8xSTR4ATPm9QbEAlqn+f?=
 =?us-ascii?Q?sph4RFWrZY/mo7iAazTEqvu5xDsap5tAnrXjDfwO2qjFE1C5cvem2c3qTuME?=
 =?us-ascii?Q?wUenptiX7wycOXv/h0v0vlIdFNzXpgViAq9UFi88xwbEwZi2FIROgkvVhfRT?=
 =?us-ascii?Q?zpnRzJna4SsZ0hAdFFppEWWxYnp+Ze3PZ1gkxBqm3sHvLfeg0fj3dE9JnG7u?=
 =?us-ascii?Q?jW3Ck1jtTQhr5cnVw19FBY7b78g1kG1K5kknzaYqXw4vbevHbx4sAn3d+/YA?=
 =?us-ascii?Q?EiKTyN5ggGxJchHBMK87gg1nCYaN19hUeI9rCXYtHku9mMH6aLmTgrCesfhn?=
 =?us-ascii?Q?me3sdX2hSr40RNhVridtO2osu6GDUY6jYoB9XDJG/BLYKV/5WOlQpT6pp9Sg?=
 =?us-ascii?Q?R0z8VUhfIBdXQdWiZ+lxGPk8wXw9VGYA5iRwcSsLbR5uVGOwuXpDH8MovNEH?=
 =?us-ascii?Q?j2fKy+LNHPR/1C8af16wB48/8YQNnvpZI3tu7LH57ThfQ0vckSs7MzKRFfiw?=
 =?us-ascii?Q?umxOlSWRxk87QZ7ZqbtwUoF6vTKOwpMR9IXOn3H1NOPZsOfwX7EGy0H9/cVE?=
 =?us-ascii?Q?zfVO/BKT++Kiwa7uY1+MTtbET+JIai6oRktHSvwiuC5+v7TLFrO/JQZrC/SQ?=
 =?us-ascii?Q?79/oYI72B6gQk6TBv2fmNsgxHf3SAKJeWPEihv2tO479MVUUloPnR9nDlTjo?=
 =?us-ascii?Q?pGZIwdsZQff/fY93pEP7GXuNPvJeOiCbLazmiByX3hFLTzzPfHK2fKt3My9r?=
 =?us-ascii?Q?l8cmRYPtcA7Jv9TwCFb0U0t1b11OpAmfsgdx79Dd+dsNJDvKvxOnKK387kG9?=
 =?us-ascii?Q?hXElpuy2uYXa1XUWmArXPL4hNlWH7KnsfRHhx3+pfOZ7fQz+RumuNQeRYSl4?=
 =?us-ascii?Q?qeuI0aNk/Wp8FwtULfFd5A+ZSIM4eCCgTU+rh7yHMGMh2kicRhcckfbgJWTn?=
 =?us-ascii?Q?DpcU9FKMAs25d6z4Pi0Cr3PyUhmv61p/re6w7s8g0FraXn3p1ohcnqcZmvLZ?=
 =?us-ascii?Q?SNe3Gyxi5Jf/k4iQ8QRn5CGFDleYgs6Qa0mB/YhUqiobU9zRbWSev2Vc4Fnv?=
 =?us-ascii?Q?5t+KBXbyRvGqh09kQuHFCjvHIhveC3nO6MW39NS/XT5RqMqB9C7H+ORCzNBI?=
 =?us-ascii?Q?6GVW3RzwREl95P0BdJjKOzoOf4H7CDHnEwtmk/i6BHM5nzsrsdaYPwIxJhlJ?=
 =?us-ascii?Q?j+96/lKyybDlKme7OlA5MFrPUXrxi4kvOyhuic75TwLqs0K+VajaSITMkArP?=
 =?us-ascii?Q?IeLSWjPTaeOEleSgmOI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 12:16:06.5137 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 480f16a1-1fc2-4204-53d6-08de37e5e533
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219
X-Mailman-Approved-At: Wed, 10 Dec 2025 14:13:29 +0100
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

This patch series fixes a boot sequence issue in AMD Versal Gen 2,
where DRAM banks are populated too late during MMU initialization.
The fdtdec-based approach doesn't provide memory information
early enough.

Changes in v2:
-Export get_next_memory_node() helper from fdtdec for reuse
-Split previous monolithic patch into two focused patches
-Add comprehensive documentation for new functions
-Include proper header dependencies (dm/ofnode_decl.h)

Pranav Sanwal (2):
  fdtdec: Add declaration for get_next_memory_node() helper
  arm64: versal2: Populate DRAM banks before page table size calculation

 arch/arm/mach-versal2/cpu.c                   | 57 ++++++++++++---
 .../arm/mach-versal2/include/mach/sys_proto.h |  4 +-
 board/amd/versal2/board.c                     | 70 +++++++++++++++----
 include/fdtdec.h                              | 23 ++++++
 4 files changed, 130 insertions(+), 24 deletions(-)

-- 
2.34.1

