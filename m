Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C900D4921F
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 12:50:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FC80839D7;
	Fri, 12 Dec 2025 13:49:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XrUr9t6H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D974B83045; Fri, 12 Dec 2025 11:26:49 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEF6B82B20
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 11:26:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.sanwal@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vTwT8OqTJ6ggW8+YqKObD5/6EAUwfgfFsJrR+jnTxJ43er50nYEO1mRDhbINKvQmx8Ez5nPEMmoAak5d7hUmAF7t1MW0ItQZ3d5WryypJeBXFlSBdXIUJJB9QHEmKbjKNWY2myd4jIcQUqgwK1T+orifjrb3cxHMdQOkKHDX2sXsMEqhr7f9/Nt2ZUOUO68VGSs6aO2YcmvRZLoYPvNyvOQQvC2H3VKN18QtuDo+ut48RYIMdV7BZSHKEigs5lBUNMmhyMhJYnHZNnigcqdfeBuRNNvzci5qtm2X9kzig1Vqcqcsk6t0qCrsaH2MzUGKKy2qp4NhXzq0/b0GHiz5DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQjgm25ASRKGDnZ83o/IT/XE3BUlpqKoMQJ2MxfOBCY=;
 b=snRMqa7E9LmyeSkOa3wIlEfRGGMEf3cd9A+BoXMAeUTN7XQVS/Xx6lfwD67DXqU+cIMNHdmcmeHQoT8+Rk7OixSDxZWc/UmPPm8pfPuY1V3L5LgQPRQ9faP/ZGI4HlwRqQLWI/lu6WITgj5YHNIrEU87vfUXPpmcbNjptBztQiE+ZJFlWEt5AEcfnrG2ugnqznxoaQZ6jg7zZ6HR4+ImtyQ657do2JpsiAkT7RQb1soiUUtfsOZtJU/SDtUEkLEIDsr6CGaXvpZf8IsHN1Q4X2L3ABzyLepaKJDeEFXouga1UaGNxwYXRmsLVtc63ujPN7fP3im/LjObRdleNKHBWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQjgm25ASRKGDnZ83o/IT/XE3BUlpqKoMQJ2MxfOBCY=;
 b=XrUr9t6H8bOgXlo2Y1VSA+Dcij4V9bLREuMXGf0Qo4dkYPR4D+oqN8O5CN1ycywDgM6VMzeNzTDZlLfob8NP5tMdX5zBTUA6kk79WJJLXgjxz8Tvuenw7BVIlLJ8GaLUIf8ZdsxbwaQyYNXiezJr3KrXSjYdTMh7bu0RbFeEo7c=
Received: from CH2PR12CA0028.namprd12.prod.outlook.com (2603:10b6:610:57::38)
 by BN5PR12MB9485.namprd12.prod.outlook.com (2603:10b6:408:2a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Fri, 12 Dec
 2025 10:26:36 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::a5) by CH2PR12CA0028.outlook.office365.com
 (2603:10b6:610:57::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.9 via Frontend Transport; Fri,
 12 Dec 2025 10:26:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Fri, 12 Dec 2025 10:26:36 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 12 Dec
 2025 04:26:35 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 12 Dec
 2025 04:26:34 -0600
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 12 Dec 2025 02:26:32 -0800
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH v4 0/2] Enable dynamic MMU page table sizing 
Date: Fri, 12 Dec 2025 15:56:19 +0530
Message-ID: <20251212102621.2888015-1-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: pranav.sanwal@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|BN5PR12MB9485:EE_
X-MS-Office365-Filtering-Correlation-Id: a5fae9cd-27e4-44ae-d8fd-08de3968edb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?50UDH5t9yofiPZhpgxqQxZdjfzOrFV1X4CM2OMI8xc8pQaxQ21NvRqKBOkEi?=
 =?us-ascii?Q?qQushs4Fvv2iaFqysMcAmvN4lo4wQ6NS1tErRRB4kOvsJFR0V3zU2lvN0e6P?=
 =?us-ascii?Q?xbuE6xKcor762qfidWamydo1H5+MdPL4LRPsjsj9VtjgJgfZmB/eckhbMCEn?=
 =?us-ascii?Q?XQpn3H95vxpQuNEeLgmxKx49vKXb8Ns2nN6HqgdF17Wxq9CrjGLw2Cv2Ba90?=
 =?us-ascii?Q?jM+QlpkwL10jbV+yx1O8Ft29SzDOX8xt605TVDb5x/8iczLWjUpQ6DkaWFUi?=
 =?us-ascii?Q?MBCnZ45QGH3PPNn8260rQrprp9j4/FBqptvDzpxJz2A+SJPjZaGKLAQaMkKQ?=
 =?us-ascii?Q?WpyLCqbqZhE6P15cJ8Uw0Wq7Fl++hFoeylrLINU22p4zifeFju8OxGWmm+2a?=
 =?us-ascii?Q?2MruouBUWfX+NVfSs+C0k6/MK9ZFgGfwyjk4RkIxluHlUYVOG20vTfDgfxxn?=
 =?us-ascii?Q?f/cbc0AhgwzXgCYycGFlivES+tjewUcwE/8vRx+lLPfTShnvtD0aHiHRsr9e?=
 =?us-ascii?Q?HHAjJywEdyGvBwob/VVMkYs5kcIRF9YqdhUCcStMusMGSfTV14ukoopDwbPg?=
 =?us-ascii?Q?IfoDkt3iFeh18TOCR/kxhTGAEZlXmZ84RG3nWJLiFWstQEjEk2GmP22DSKiK?=
 =?us-ascii?Q?gezdKCBH1YcPhATSEJvF+O+wdGXs9j5GQubNU28tTtI2hMeZx1ILn6QfR612?=
 =?us-ascii?Q?0T2fvNBfYT7Ya1FVmOvJ6i1c5/XeXdCbrXhSlB/k00l6O8hDLrv3/45S7jW4?=
 =?us-ascii?Q?9NixoZdzRIakZbdOZnVVzHTN3txHWaMhJPwBGw8D5tmIZjShx5aWLFu2OSVB?=
 =?us-ascii?Q?9Bsk/fAHZnBkBYU5kvhgQs1huwySEpn3CmknonVMVvCBLu9Be44IIT8LoeX5?=
 =?us-ascii?Q?6GWx8iribboNaVb6LprZNR3noycP5D5yVIXVnquxagHGq28moGDduirQqnYg?=
 =?us-ascii?Q?bRgl97F5prIlEzo3T5/4EO9UnrDM0V2W9oI/JI3RilSKh9EOMbG9kj/MR7kB?=
 =?us-ascii?Q?juEA+Nj0bY7ZSBFPsFeWI1m1kLelFC3y8uRtQIN79iCGw55Ao1p2ziHcmWtS?=
 =?us-ascii?Q?aslHUM2fmuwQXdKhMhPgV/Rl0yD2XzIjF+KrlkJQ3R5UhydBhv+klOYUZXqE?=
 =?us-ascii?Q?LOkg1RhT8o1Asqg4wIfIsvY6t1VmLFWFHTlkDOTRYMOgVzb5eYNyebaqNW+C?=
 =?us-ascii?Q?z1DnSBH0sTt3XHlRI32CTgM3IuuIAAQ271tSUFJyAQwE1BOeAPDG0jB689HU?=
 =?us-ascii?Q?j7EofIpmS/oj2KY0kMdufgAs71va9xvHzyml17WGsRfrWUfCT9o7koj7lv61?=
 =?us-ascii?Q?Zjg76HKNex+t3VTWflG6urUpAaFCepmtWpWF69LZ/CRnuYHLRdFkO9raRjSc?=
 =?us-ascii?Q?etvFp8IC9UGlS1UvZAkPwIKcAykeR81nDEKLarrA7ZEnaSP8rl2qJE7GQdD8?=
 =?us-ascii?Q?jmnpy1agg6EZlpAy7d5Cp+TpYCxWUTZ57kqHroZGfQi2a6+u2TY+akPVsXle?=
 =?us-ascii?Q?7ymsuTIbOoIn7NqViz2dx92+fsnFj1gw79kRekoviMSene/OV7g2GcjX385/?=
 =?us-ascii?Q?iYlmbAkFyU//0hEOPHk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 10:26:36.0212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5fae9cd-27e4-44ae-d8fd-08de3968edb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9485
X-Mailman-Approved-At: Fri, 12 Dec 2025 13:49:05 +0100
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

Changes in v4:
-Better debug logs alignment.

Changes in v3:
-Fix DRAM base detection boundary condition (text >= bank_phys)

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

