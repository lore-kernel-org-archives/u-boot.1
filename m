Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D07FD3C54A
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 13:13:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3818D83CCF;
	Wed, 10 Dec 2025 14:13:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yhYIxN/D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 769AF81D6A; Wed, 10 Dec 2025 13:16:16 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81CFD8352B
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 13:16:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.sanwal@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RDHqplB6gd4wtUjg1a7wCU0QjucgBwIyCf9iy5zM9Rl8S1cj17n6UbmfH61b9oQbeiC0Y5lI1mzbOc355FrUCJ0QpK7lh2rtmN+WK493nb5H4nuhjUmVqUC9otVkYtyFDv6XC7oBihnHmm66zlDYEBykRUTeJWpuX+MpOOx4aT4gXTQMkmJLYw3OwlhAXmMnkOmfVP6HUeg7sMkkINacol92xmYXweJnEUOcgV2M5UO3Hg8TrhEaYR78ejycDOOhLPNTXT/AQSi3GP1A0zeNVNTZ3FlDsjlfU/fFGlmYQMg1UuxZ8aR5fUF8+5l89sc2SC0Bgwbw+O7J1gTcu3QJEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElIo0OTnjTCCUOCK1/lyAeGXn10gxstrYG51+xanE2k=;
 b=A0O0xqXLUkVuDtF5L9aXRNIJwOzLBKAEWIGlxUGVyXTqNDqmAD4SqcdjxflInrVvjbvqw1dkxIbWkLOTm4Rvm2ZhGC7PDKuWOpIGffhZThzMFnwuGJ157J0GqlqVKqYzxn8DJfKpcG08BzIujPDJX6vX218l092+M+/eZkg3KRWqjquyjnovVMNFsW+m5XcizyabtDagvZP6Jkfsdc2vOsCNvKXUOp9PUvaqzHLSseLLhwjbbDz+Z0wciFW1+BuVUOP9+62tBWLYGoUlZfBidxS63Kj1212fGJ9EoJh6kI82TjsmU84iJl/p8TSGedcNoxFATgWCe7Nw+zuQTOJQjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElIo0OTnjTCCUOCK1/lyAeGXn10gxstrYG51+xanE2k=;
 b=yhYIxN/DS7a8MBJdd055V5h/Tuvk/sYdMPUlpTtK+cpFuP/vsK0+bYiLsftN7vKMDKhRJc8KgoNd0wQjfuWFn/QHLBR7c9GwhQeO93wWvasGADA3oXvmbqNmRg0qVDrYXWW8pLZZ6P8fqY4KOLMvWM8fB+67rkr1qvFwrBMvgjY=
Received: from BN9PR03CA0966.namprd03.prod.outlook.com (2603:10b6:408:109::11)
 by CH3PR12MB7593.namprd12.prod.outlook.com (2603:10b6:610:141::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 12:16:09 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:408:109:cafe::ae) by BN9PR03CA0966.outlook.office365.com
 (2603:10b6:408:109::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.15 via Frontend Transport; Wed,
 10 Dec 2025 12:16:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Wed, 10 Dec 2025 12:16:08 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 06:15:54 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 04:15:53 -0800
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 10 Dec 2025 04:15:52 -0800
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH v2 1/2] fdtdec: Add declaration for get_next_memory_node()
 helper
Date: Wed, 10 Dec 2025 17:45:38 +0530
Message-ID: <20251210121539.1679229-2-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251210121539.1679229-1-pranav.sanwal@amd.com>
References: <20251210121539.1679229-1-pranav.sanwal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|CH3PR12MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: fa11947f-8774-4ef3-c68a-08de37e5e699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OMpJeLY+iZp73CY4PRM4RoKIPXXF6XMt8/iQI3f5XB4DsH0FuSB5UZX9XBZn?=
 =?us-ascii?Q?4Z5MiOY7taOXRbMGUJMO8IAMQXFla/VV2jh2ry2AMzyUJcT8LPn2iicETBOl?=
 =?us-ascii?Q?jxqm5zwHxjN3dtTKymvlLO8Ff2BguikBvtu3Accf/8Nw7c1GrS96Ne2Iy3GH?=
 =?us-ascii?Q?s4AqZq4XxZ7BFUSQW28l8j5soUEYXUwqJ+qIJ7nyss1ftOwYQQ0PomPA8m5a?=
 =?us-ascii?Q?ZpuDR6/WQjZUkBt5bI6OfBVv7Pr7078wSpskaYzGn4mld+XiOWeUuTTxL59g?=
 =?us-ascii?Q?1SykcfJ+jDgsWQl5zEm1nCdeUsQpQbm2ZsbllYXozZKq+EwXef4JmL8sn19e?=
 =?us-ascii?Q?xeqzpfW7DbJI8hOERXF0SsA3QnQmEcftjIJnPfZRyfLygZXpknORNXR5zxv8?=
 =?us-ascii?Q?Kaox30VIBUuP9PVyfo8eKX32gPrJfb4fjf6CKMTlbpEzPKm1VE4hpxVlYM7p?=
 =?us-ascii?Q?6DKuBnp6+4KB5ptYV3jXJwOEkSDC3cuOvYrGxuE4cwjPcRpU/ghp7ArBjEgW?=
 =?us-ascii?Q?2mkbiInPOB7CvmZUj6sDjJsGcDCbIWmbA7xThqkroZT0luJUfVN07LbyzQ3o?=
 =?us-ascii?Q?1yxTVcC3wsViXpSUfnL4ZekjQnSDb6GMTDFwboYnUTFDYhj2/nhdVk7JGyji?=
 =?us-ascii?Q?B6z4WSeYK3Udmnq9SskIhaCbJyD/nCpmBeCfecSeSe59ggLsaDem7XpZ+6wm?=
 =?us-ascii?Q?YzVHhYB6HEn3GVDmi7JtzN5jk8pe/hnQxZQXNGMINgFbJEEtvv0I1eAz4EKV?=
 =?us-ascii?Q?V9o5g9JJ/PMMOp0JdhMrmisd/3JNR7p+EMT5QcmOwncIj7WB/ubq9op232ov?=
 =?us-ascii?Q?/1ZiQISp9+a/FacdHeTkSpocN48fjgUHl5uSD+CIIqiMf4kwpHfvfjktxmt2?=
 =?us-ascii?Q?36yJRkuDfKgysv99fAUNQR7TIEgtO3fSL8iZEwVtGSbSipx37QizXEc3vZK8?=
 =?us-ascii?Q?mke0TeiYOEjm+aimPPIQ8rlDz8sOUSdQfuwBy/a5RugPWu6AvA2G079NKe22?=
 =?us-ascii?Q?gCqaMMXfGNepBaj6LXniJbXp7CHUWxLy4ZK7NKuXSK/dGeuNESuqDQbFUiYS?=
 =?us-ascii?Q?WoUXljQFgSml2f5Xk1wuYTyGO55TrH52OTW3ylZ9eDYZ3wa0mBpeC2vfAgIM?=
 =?us-ascii?Q?3WcHWBXaLLi4JBK2xT+zmxHm2fg0FycKwR6NvbvQtrU5PfQT/ngiJXtkRhUm?=
 =?us-ascii?Q?kCCtXpQPrBp9Q89L1/S4uy9B1aBFtDJB2y0a9pilDTLaYueeuo6pDJH0rKK9?=
 =?us-ascii?Q?vlRKnaMXH0fF6LdU0UnZ8TRUXmtwKDmxut8J8GD+3greQAhQZDNupOL4vDjQ?=
 =?us-ascii?Q?xW66qXh0XRfBPC1N8BauT0cZjaQxK6GIAmW9URaJKmKEfskebilnR6LLKWTu?=
 =?us-ascii?Q?n6aWcDLWaksS8QGznrZuRMEiJwt7i+d1ht8v5HWyJVsoSslUh+VsLEwIKuEM?=
 =?us-ascii?Q?ZsvLvGCUObI4i68QOZHi547hVC5FNwuBWcQ/F9F0zG+7mrBzX1KJWAUAhi4W?=
 =?us-ascii?Q?U+EyZV5G6fEraOO5lAL6qg8vVPsmXY+IJKtJ8mY7GDZl6442WVfEGWoven3X?=
 =?us-ascii?Q?rd2EVkeHXCPXFivxtnY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 12:16:08.8622 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa11947f-8774-4ef3-c68a-08de37e5e699
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7593
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

Add get_next_memory_node() function declaration to fdtdec.h to support
iterating through multiple memory nodes in device tree. This function
is used to enumerate memory banks when the system has non-contiguous
or multiple memory regions defined with device_type = "memory".

The function implementation already exists in lib/fdtdec.c (lines
1298-1305) but was missing the public declaration in the header file.
This patch adds the declaration and includes dm/ofnode_decl.h for the
ofnode type definition.

This is needed for platforms that require early memory enumeration
before standard fdtdec_setup_memory_banksize() is called, particularly
for dynamic MMU page table size calculation based on actual DRAM
configuration.

Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
---
 include/fdtdec.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/fdtdec.h b/include/fdtdec.h
index d9fcd037ed2..87e97635ce1 100644
--- a/include/fdtdec.h
+++ b/include/fdtdec.h
@@ -16,6 +16,7 @@
 
 #include <linux/libfdt.h>
 #include <pci.h>
+#include <dm/ofnode_decl.h>
 
 /*
  * Support for 64bit fdt addresses.
@@ -198,6 +199,28 @@ struct fdtdec_phandle_args {
 	uint32_t args[MAX_PHANDLE_ARGS];
 };
 
+/**
+ * get_next_memory_node() - Get the next enabled memory node from device tree
+ * @mem: Current memory node to start search from, or ofnode_null() to get first node
+ *
+ * This function iterates through device tree nodes with device_type = "memory"
+ * property, automatically skipping disabled nodes (status != "okay").
+ *
+ * It is used to enumerate multiple memory regions when the system has
+ * non-contiguous or multiple memory banks defined in the device tree.
+ * The function continues searching from the given node onwards, looking
+ * for the next node with the "memory" device_type property and checking
+ * its status property.
+ *
+ * Context: Can be called multiple times to iterate through all memory nodes.
+ *          Pass ofnode_null() on first call, then pass the returned node
+ *          on subsequent calls until an invalid node is returned.
+ *
+ * Return: Next valid, enabled memory ofnode, or invalid ofnode if no more
+ *         memory nodes exist
+ */
+ofnode get_next_memory_node(ofnode mem);
+
 /**
  * fdtdec_parse_phandle_with_args() - Find a node pointed by phandle in a list
  *
-- 
2.34.1

