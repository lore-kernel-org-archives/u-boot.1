Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C78D2C71135
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 09:46:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 722E482CF5;
	Mon, 16 Jun 2025 11:45:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qw7Jsc4s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC14382CF5; Mon, 16 Jun 2025 11:45:53 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::607])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13E9E829F5
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 11:45:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CYffCW4lE+vAEIZezWn0K09WzcSeTMLt1si0BCM7vkL6mQj/I9Zg0VdUiAklzu9Fq3vY47rJh0NpIvOWcnt2OdsWVxXCvoIadEE+76P1EI5wV5tP21l69NUIKxmEEnaze+8pe4T2yK6e7ehqCik7jn1TS3F8rPGVlDepLSq0R6izGZ8zaDvKqmaSlbLCDU7xZglnHaBGeKpDdtcIBFIXii7fOoDqBksK80YV3VcvkCb3uQ93cacvht4p+wojLDsl4wT/4duYX8KpjfNTluFOM4FgwcdXLqaAXVwGvQ7OsKcPnAxmUd+hUplVAmUub6YfooDD3LYtU3vbvi0pj4zCtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sO7ouRSmsrXw4VLUcihVgW9z8IXsqmp8IvQeYsxprlI=;
 b=B1bR2kY2ORYgH+XsfoEEonosvQEvWEAhiR8ubHpra+GksCPn79L86H7m6XWfWXFqhzfs6N8JyuGgbRW1Bi3F+Y+aZT2G5T1RctDCIM/D5dJleRSNeW2wQSA76haGpwVks/lVFQXQU/XZSEgIMJ4EFvc+tBszngXOxi3bXfy2lImqXKZ6vFQr9g3TcWcApHCb84duGIo7qby1eXe9aD3jG0dVEXVfVaF1YaKoGJSHaCU5VClb8SmDvAQFy7tlzbk00+31nccBLzxtHkKB9tXL5vaqZoIvGWuLVMdJptP2tYcFoOD6xkgi9ySXvkVvocuMwMbUoOpySoQPiyKZbY8MHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sO7ouRSmsrXw4VLUcihVgW9z8IXsqmp8IvQeYsxprlI=;
 b=Qw7Jsc4sh8qowGD2oibA9HSDHRlFWUd+73bLoMWHxwWLu8oqQHbkf/ZrC4fDpxNjAOgYcvi7E6FqtzIrRYkAQA7uu9VYxtvDWGQO1RniPCYexYkQOGCTEQyMdYlBFoQCBXr+E3XBbCA0RhxbuR/orOwh3eqbHbSPhKNYpYm0Ea4=
Received: from MN2PR05CA0031.namprd05.prod.outlook.com (2603:10b6:208:c0::44)
 by BY5PR12MB4324.namprd12.prod.outlook.com (2603:10b6:a03:209::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Mon, 16 Jun
 2025 09:45:47 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:208:c0:cafe::ba) by MN2PR05CA0031.outlook.office365.com
 (2603:10b6:208:c0::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Mon,
 16 Jun 2025 09:45:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 09:45:46 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 04:45:40 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 16 Jun 2025 04:45:38 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <sughosh.ganu@linaro.org>, <ilias.apalodimas@linaro.org>
Subject: [PATCH 0/2] xilinx: update guid with fwu metadata
Date: Mon, 16 Jun 2025 15:15:29 +0530
Message-ID: <20250616094531.4158505-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: padmarao.begari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|BY5PR12MB4324:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fcab8d0-6ea8-4c49-d243-08ddacba91bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dc0dAIhGeAIflYtdy341pFQor/eE1Azoel5Wi/DkzaYfP3oBpXLVXK+YBpeS?=
 =?us-ascii?Q?cmo3mHCHNRNNFbSyZVNICmlUmY/QK9JZYMV8WJdsYAgOzi5J0Ow+vqmGEgue?=
 =?us-ascii?Q?uOHLMAkngkUbaKMrudASvnnO57i61tZVxSKNiW1NvLghwMH4NI6LWoG+Audz?=
 =?us-ascii?Q?R3lHR1RACB8684Yuqz7BUFfR6n9HO0QPaEjWSet+W18KHpLYrXhSEGvzdq5N?=
 =?us-ascii?Q?SB7bGSorso3QOD908+j4475oaDKcdbjg+jZokL57WpoMV/6b0DyI4+1UHXd7?=
 =?us-ascii?Q?t8+IK29g2b/3aMzrj9ISsFEEH0gdaRXvn52/oC8va9fAG0MznjlM3+K7l1LJ?=
 =?us-ascii?Q?vMpDodxy1MqsDqPOD96MCD+IlKPYXhHwMmN46L8412fd0xqfsA/kpzISqEkv?=
 =?us-ascii?Q?louc7kjBZ596rQ6Uv77oEw02kBYAX28PqpIyIZRgVs38I/LAeGlLanrAjJK0?=
 =?us-ascii?Q?v9Tv2mVluZ6IP8TugPZukwJBuCr0ix1IR1L4vRnpBCxC3KN0Ywln/NzFI0uR?=
 =?us-ascii?Q?F9HaJFfTwY7gL04WzFQZJ1Gdb2ClmAwxhLdyFoZRwJksQbPb2z0ZMV2XhUSP?=
 =?us-ascii?Q?AvopIdOPqpQMv8SPoHOhw3Et+van8aoH22kUW4eYlXz+X8aTBOgJEeIAC9sh?=
 =?us-ascii?Q?Qe53veEZc8okhIQYd6EMljHDN/AtnSv/eljQFtHasmNxGHv3isNfC6xb6o90?=
 =?us-ascii?Q?BXUCcTeji+bZNOSn9Rvw9+M5s6Sy6TIjksSrpFxDQaWBRkcqk397dTG8MuxQ?=
 =?us-ascii?Q?lZ2oKg3s7MhTbasshoztbUTwmZteJEJNM+shczh/wcObyY0Gk74zqBp0v8Sl?=
 =?us-ascii?Q?pGSjmi69Cvy5WSWRVjUrfwtGWf/Ne/V7pfG0Ve5fKXMSRQMYm9tvNuK2upd0?=
 =?us-ascii?Q?M1DTdTjxDX3Q2fEodq7bTiO8zcg9Ok2Pg2ETK067nKwQXHnqs6biTWEuTNKL?=
 =?us-ascii?Q?PZTRgE4CbVXoTYlWf97kyK+VluAh+k41ywRbOqJNCgisZUi7SrIOrPi1Y+d4?=
 =?us-ascii?Q?NbQFTEKCnU92fPMnDBmYJ5kKIufbwMI+xNxzfpthlsEs971DaA3p1DwbiyKL?=
 =?us-ascii?Q?5N+dS1643ytnl7/zRbCzzW4iieifrHj+IWsDzCST/6DezYRmuJoAHM4XkLpJ?=
 =?us-ascii?Q?vkxveKkPFy/toKYefKpLfW/rOALbJ3awIC7oBaQNBxk9nG8hm2zPHnDZHo/y?=
 =?us-ascii?Q?6jCnRBnbVc1ItSqvIpGeLNHk7LwZRflh+KRTDwVGAoAZgQIBjbRhtykpM2r+?=
 =?us-ascii?Q?2C00Be96RQWMwmuIBI3RdYdouzv4Zpams4RcpN7fC3ycukN9TwTNtnrRRw+Q?=
 =?us-ascii?Q?00ZMIMdAuhTY/uPXJhvSZK9EJAn3xKp+4Fkktmkvrvd/0+iIjnD4xj/8l73q?=
 =?us-ascii?Q?v1JmMqwb0fNvL1SPodrS1aXizqiISh2D5zKbr+5yfk10pinKQTiKhAJXUKj7?=
 =?us-ascii?Q?gBEByBEjZIlSn3MPHw9T149IiS/2iNBcuooHpgBnoipi9hXBffAoY8+TCBYU?=
 =?us-ascii?Q?+R436fia33yZ6JSIeCP6rora++eWMm7oZjzF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 09:45:46.5210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fcab8d0-6ea8-4c49-d243-08ddacba91bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4324
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

Introducing the fwu platform hook function from fwu
initialization to process fwu metadata information with
platform specific operation, and use image uuid(GUID)
from fwu metadata structure for fwu multi bank update.

Padmarao Begari (2):
  FWU: Add platform hook support for fwu metadata
  board: xilinx: update guid based on metadata

 board/xilinx/common/board.c          | 13 +++++++++++
 drivers/fwu-mdata/fwu-mdata-uclass.c | 17 +++++++++++++++
 drivers/fwu-mdata/raw_mtd.c          |  6 ++++++
 include/fwu.h                        | 32 ++++++++++++++++++++++++++++
 lib/fwu_updates/fwu.c                |  8 +++++++
 5 files changed, 76 insertions(+)

-- 
2.25.1

