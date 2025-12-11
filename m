Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7676AD41C17
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 10:11:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F168D83E21;
	Thu, 11 Dec 2025 11:06:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xyI+KAu1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1973F839DE; Thu, 11 Dec 2025 10:26:35 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C7B0835B3
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 10:26:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.sanwal@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SkWP/jRiyLQR6J0cE8dZ2v8sX5W3uPgTyPncP1/t6c2+B2KdfcZ9cZqTdU8OB3MOE/B70RVK4VMiPMEn6fSEmf/6QFjEZGYeIRj0p36PoL8CBIUkVFi/3AXYKxeE1ScP7vkZ2gmeRkfk+33v1b2o3DSlPyGSVDr0hr85fIIh7b1v2y+rqKneHbb2l05nyQWGZkoteN0mRr8MX2x9jsjwzAXfBJRe/BIkRQyDs2g73xHBbJwlIEpOVJAfgEZcWUduhI55UmkVJ10TwDZX3pOkWCRXbRBNiKjPWGogYPZRQXRcFwX1odiopHLD3Lazt0xCoHsf1cejYDlAQ47pNHJcAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6oEX0oby2a7AP/NXk4Ntk2uWBduYCb/opIzsDLcRK4=;
 b=JWQxbSdvr4XBiCPSNtxtfwcAbzpYKMP9DW9ySrJphQD+y60OCJ5ZeQ1sXGVRQp9A86N1DloxfB8+JDyze6djvBZtXxcQSvWCIGfQAq9ySVih3AYW4SFqKO7tWbXVvDzO1NPaTlF+0IX2B8T1oOxbiy+ZBxDzKhEUDikZathO44dFYzEmKR9gUgK7UZHuOfhGSS3ls9KcdpE7ZoOsU/+LrtS2kGrTJiGqjwgHtYo2FWFAU3hjOkzmfgwAEBInaw4Wa+Ev0P66XpsJ+NjcaIEDZgbAQKPMvHWkWWhyzlwAILyePZjgRJmfVr3dVC4e0kv938qGARmHd3Sfwo/XNVgkIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6oEX0oby2a7AP/NXk4Ntk2uWBduYCb/opIzsDLcRK4=;
 b=xyI+KAu1vZgqfNO6+/FAje9eQ1nj6lCFcWC3MS/MpwEfD13bkOT8qqd9mkmcwJHSEMzo0IcTIB8Cjvg/3tDHqd/14M9bh4zMpiZ4fEzjcLUPWNFuW0dtabp39sBxhMqfefunTe6K661G62o511NRVkzGz6Zc65ygSnjFrBCBMzI=
Received: from MN0PR04CA0022.namprd04.prod.outlook.com (2603:10b6:208:52d::21)
 by SJ2PR12MB9191.namprd12.prod.outlook.com (2603:10b6:a03:55a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Thu, 11 Dec
 2025 09:26:28 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:52d:cafe::5f) by MN0PR04CA0022.outlook.office365.com
 (2603:10b6:208:52d::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.9 via Frontend Transport; Thu,
 11 Dec 2025 09:26:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Thu, 11 Dec 2025 09:26:27 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Dec
 2025 03:26:26 -0600
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 11 Dec 2025 01:26:25 -0800
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH v3 0/2] Enable dynamic MMU page table sizing
Date: Thu, 11 Dec 2025 14:56:16 +0530
Message-ID: <20251211092618.2320004-1-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|SJ2PR12MB9191:EE_
X-MS-Office365-Filtering-Correlation-Id: f1d61f30-e2e9-4dc9-d663-08de38975c52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AOcsj/pvkz22YeW6fTN6UT99I1iVNViNBpqMxd/eV2m1GLqTfDdSZdm95BRu?=
 =?us-ascii?Q?3NNg1Z9ASj3S1ALIHReMERB8mAAAzO36XAH506+wO1lq+n4Wrksu3tCjb3Cf?=
 =?us-ascii?Q?0q8nLlv0opDjIHSIiu0AGmTi4jbr3qlgmgp/djeaPohEb0W/Uapir0xa98GC?=
 =?us-ascii?Q?G4aLmZTi/7Z/kuVk/ZkDUVgVmpVmrYiZdCI22BddduqsaO3lCbcKpgjWZ8rT?=
 =?us-ascii?Q?fPt8utJyqZYHmpBOuLM4M/iITiWyNI+gzgkiOuAU93tktYgdXadOYx9PAi08?=
 =?us-ascii?Q?4sdcRE7cqVo2dN8/8KgSUIxiEDqD6aSJ3qMZF3Rll+U9mS8+byV2i63NWjGu?=
 =?us-ascii?Q?dg8YtZzI5MOZFkpx4pbSw45TgdH5S3ZxaHqQZLxgfaGGgPY8K6QrBnSHn7t/?=
 =?us-ascii?Q?WRs/fHPy/YkUBtqCXNTdRwuzm+gXETdCL9RXd29k5U5S9xCF63D0ImO2dL7s?=
 =?us-ascii?Q?+d04r9UBJfyPq8vF3a9lpEVSYr5CYQhq4aEbZ5euGJHTh2mN1dmxPgKR/9gn?=
 =?us-ascii?Q?Li2vZFH5/c+6TfhzCctlaup8ZxaYpXjXlVRe1EzTCjfKmTz1cdOeBbsSb1Ni?=
 =?us-ascii?Q?FnFO3Q3lPFMr+CMpCEOdT1rIMN2ebr+aUW0dZeFztSDF1U1ultdMCvowjuix?=
 =?us-ascii?Q?pmtKZV0/Dk07uADH4Eggv/5nSfVcxzsiK1RCTALOrGomeNL0xB+JxKunuOHg?=
 =?us-ascii?Q?xlHh3qpz2CVbckbtlwNvw7zcV6DzOgZu9XJ3BG92AsLfFhGV6uGVaK26Hp4E?=
 =?us-ascii?Q?d1G2fLdGeY2JdpTowV822QZe/ZKZpOZ7oViSHNN3c2swjIPE8p/1IcwcwMmw?=
 =?us-ascii?Q?7srLCCMFMClziIMWNxPSuRhLon1tW+MrdIqqLdDK+DwSgLMQqHZe86/mCuxn?=
 =?us-ascii?Q?wIiIazLY+wtJLijd8rlbXjROn/UnbxIZtk+J3W91hMmw/Z1rXErTfZ/+Fh0J?=
 =?us-ascii?Q?92uOYkO4GFP2sUTuCJ5d8BNVu1TL0BITMZXIAdh23UWWRD6yiNCdVGoGfZYZ?=
 =?us-ascii?Q?Aaa5rh+ONGRndYUBkjRjpnFb8oXCDK/0Fj5i38Lwn2AMDmFqhHx42LL5fV29?=
 =?us-ascii?Q?TluPEI5L6js63GQCQJwDimXBWOJSsQ8/X9s2k7NDwVgkiVuOD3w2RDPLvfoP?=
 =?us-ascii?Q?rHyJJYt1C4kLMQWshW1Y80YlTOjs+2CzDm839+KNZ+7C0atrF+/T/MzrtOgC?=
 =?us-ascii?Q?wX/wXXW9lrccukDHzI/KgaqsYyRS/TFDatKjNvjwG48+rj5rYz6tab5nxDJD?=
 =?us-ascii?Q?qX4S1HLaSXd2hcWmuXD0SuhUh0SwxuBk/75XFSMcX7/aCr06gfJdvSlh602f?=
 =?us-ascii?Q?aiAHbqpgF/+/MWrDoJ/eTwAuaMQ9RxEDqkR+6hFc+r2QNsr0QIASB83hjsxg?=
 =?us-ascii?Q?rlFCzJVDnPk+u08TmqW491YQ1Jw5oJz7um57B7cjoYxEMhO/4fIySHFGlEFr?=
 =?us-ascii?Q?uKCmMSABICuTZ6BYp8JzSetKMLf90uy4kIg05sHDyMKd03L27ugy496LIaq0?=
 =?us-ascii?Q?oA+YcnveoG4ndpv76t66ztABWkz92qF7zQw0VDO0iu1dihCjM1JvGzEdWl2T?=
 =?us-ascii?Q?KbuKPAAltRVl3tTs0m4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 09:26:27.2983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d61f30-e2e9-4dc9-d663-08de38975c52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9191
X-Mailman-Approved-At: Thu, 11 Dec 2025 11:05:15 +0100
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

Changes in v3:
- Fix DRAM base detection boundary condition (text >= bank_phys)

Changes in v2:
-Address boundary case where U-Boot is loaded at the
 beginning of a memory region.
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

