Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E04ED4921F
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 12:50:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DD4C839E8;
	Fri, 12 Dec 2025 13:49:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YB3DCZVw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AA1B83837; Fri, 12 Dec 2025 11:26:54 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BEDC83015
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 11:26:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.sanwal@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohoxs5lYvSYwKqzmrTYcXZ0487l1KPBVf5XN9uP8KJdAq9/ZAwkAS02f6BZsGD/xE8aPMt3xGKYivWy7NBuCASWKzgfRn+McH+5kuV+pOQImAUNNwt5ZfhXR8ZCRd+Ficegx0WuYfh2yjorwhh7VFs54yEIGgENdkrOK8KU0dFq+Sc1dABvHexo96XYmVkxLmn0Q0zQSpis59JwVPW87Nh5ecCaSnSxO8A8TUPlAwjaC/JKCisJ/Tau9oqffl2aH1nudOqfRDeATsPCr2g/eCvq6I92wHkjeeGRyWhIeAA4VhNAPNRVjN4wCxK50Qk8Z0P7lAxryO0Y4j3nIno6y8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElIo0OTnjTCCUOCK1/lyAeGXn10gxstrYG51+xanE2k=;
 b=xI6fZG0Mu5iiRV8hcSmGP0J1w5frg/1MOhFaIEU1DWfjdoURbvBi1B2HlzxBdTR6FzZuwK7EWATulbOPgBMlfDJAJmPgGA4/4/OAvcSaMNm3MpQV3yqmuHWMqavpurM0N4wn43gr/CE5oqtguSKMgUtmfkVRSrdOq5AaFR/bvSvJNcfx4P1EBUNrhX6hAZgH7LbkATefO0PkPMbqFktU/3HVaKHwcuuvyhy6Q1JZbtd18AM1tqUQOR0fDAiBKBrlFYjj45CGNW+cVlrcQmMneNF06kcbnwlg6KCZjUPs0osPJ9C7GFxqMrVo3m+G239S1DwYPe/azTBIIV/TMNxlHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElIo0OTnjTCCUOCK1/lyAeGXn10gxstrYG51+xanE2k=;
 b=YB3DCZVw8AIiZhKnff/jUyti3oQkK1CrlCRD4kQPBBwpQn+v00fvki+Fdg0iZ6wcGE1uVH0iEenyBHPSjc0mqDTRg/Lnc5TymYmfObBazMSAQYXtODdUVik9hO4CZBYeXH/RPrjuY+TEASyWNyFsUMLABvzGZqaCKG6M9EVxTfc=
Received: from PH8PR07CA0048.namprd07.prod.outlook.com (2603:10b6:510:2cf::19)
 by IA0PR12MB8973.namprd12.prod.outlook.com (2603:10b6:208:48e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Fri, 12 Dec
 2025 10:26:37 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:510:2cf:cafe::42) by PH8PR07CA0048.outlook.office365.com
 (2603:10b6:510:2cf::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.10 via Frontend Transport; Fri,
 12 Dec 2025 10:26:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Fri, 12 Dec 2025 10:26:36 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Dec
 2025 04:26:35 -0600
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 12 Dec 2025 02:26:34 -0800
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH v4 1/2] fdtdec: Add declaration for get_next_memory_node()
 helper
Date: Fri, 12 Dec 2025 15:56:20 +0530
Message-ID: <20251212102621.2888015-2-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251212102621.2888015-1-pranav.sanwal@amd.com>
References: <20251212102621.2888015-1-pranav.sanwal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|IA0PR12MB8973:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c6ef4c1-7ee2-485f-5ad6-08de3968ee1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QLT2lUOeWwdTSv5ZrTKxDLbU4el6D2JvarLCTlx5WGX99UXC7L5MsL7f9Lbo?=
 =?us-ascii?Q?PCwI5uUElFxvupyavlWCkn0/yJChKE8TyNXndA9M7C3zxmkeWQCvPPFUElLd?=
 =?us-ascii?Q?bxLeUxXqysHu61GzEMTrEDu6q6jyM9UA8yk+6nJ2mzwqCOb2577L6biTYKKi?=
 =?us-ascii?Q?AXFLwiKM9jPiqrho3QqEJaVYuRAIN8BfH23ivzIxaCFsD0haJUBUQnoba7Ck?=
 =?us-ascii?Q?GjC71BmWPFwIr150ZW/QMjx5KZX6FnaBufzLX06tfYu79EJj6YZgmb+8YoFa?=
 =?us-ascii?Q?F2KQ7YOmkp6s0bmnla66MV1e3hTH1PIAqqgauIZ+uyjaX5bNU62v7F6kiRlR?=
 =?us-ascii?Q?HqwI4QqQCf1JPu/CushC8Yu8cl7uIow8AyOBCJ+qY5gGfoWbz/88+d6WFAgn?=
 =?us-ascii?Q?G3hB0REbCRhlGM66TFp5hW00FR9hcXUsLBcPpN7uCw7URSF3Ay+fNw3ssDgZ?=
 =?us-ascii?Q?reWB25/IrFZ/xFRGiNegSxLxeGCBdLFiWjVWRFPS8bgKkU730v2cHPaLzdaI?=
 =?us-ascii?Q?gS602XF6Mb3sblhxPZBO3XmYI5/ExmZP/af8e+WgnnxG0AXLGFo/97o5eN0W?=
 =?us-ascii?Q?1sa9cmgld9LuqzHM7pw59n2wQLb8jYwqdQLxE6feOS31zy6eud8+Yi28rfd/?=
 =?us-ascii?Q?EV/Qly78nbxnxOpgaiJtjQ5yFjxax8D9VaGi55qMWpyuzg400nC+vnOhOrnl?=
 =?us-ascii?Q?/S70i6y1wJCtgs0hVZUyruxnrdLTI32OUYLePimOaC3L9ugTEbFajca1mUwA?=
 =?us-ascii?Q?6m8t5aTn0eTHfzxlm4UUs5BzIv7O6m02/ucwB628bioqTPsTiIE1Xypg9B+B?=
 =?us-ascii?Q?wj5XRkaANVrwLfkbEeAGKIL12Gm38hShX4hjcabIshdKJwnFDGNM+SBUD5fr?=
 =?us-ascii?Q?9QHl3+Zoj2vpjsMHbtnpIMS0U7gG89LAcqYZJ+TkK/0+sQwOt27DjeQifbq0?=
 =?us-ascii?Q?FfNXYOVKDhJeawLi6Om4k0YhVV36R9L/Nx/Y4tZ2nPIcvOhaqFFo3ayzMDq7?=
 =?us-ascii?Q?iqxug/5/Yg1og3/NTGlHHls4dSLX7A/BtJZp3hp97qwXPw2Fox/LsG88WqwC?=
 =?us-ascii?Q?1S3ankCN1o2VQa3a9xrkBBJUrRr7QaXHgwIRko4PpgZWQPr6MJH+tbMI9uKK?=
 =?us-ascii?Q?QILif5dmSrBlxmo/iA2wvDoddTxssBRo1hCMYi7rfX3EwMc/jZcSGsvLWN2s?=
 =?us-ascii?Q?61fuy2N4aCQ8fPaEuNME7PsVRT4+2faXvMZ30v7P49sWDlvbO1SL05WXjRC3?=
 =?us-ascii?Q?9CXbBHJIqWcu7P4ya7yisAu/B2mDDyIc/Dzldl05RZJEwlYKSUJBvNnFDvkI?=
 =?us-ascii?Q?ZcsCCM4Gq0eOGexcZ1JX0b+WXRYxTFFVyOclkHWZm/Dm4c2yWf0AELJY90u0?=
 =?us-ascii?Q?KfGtvkp9HKoTPmk7RFMKbU48MvPE7bTygY0FI78iaW/1SWW3mVinTMr3G1fP?=
 =?us-ascii?Q?yJ+WhJjiXBVj8jboq/QJaWDvjpm5z/AyrfxLCuEEeryZ3dROLQppT44/IUZD?=
 =?us-ascii?Q?e7HaZoYLpE8W2eThHTaHm6S6hCWk+G6ZPXcjYjG5Wo5W6cIXOL6FaLicsGPf?=
 =?us-ascii?Q?6yuOCwfwK6vl3EWCop8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 10:26:36.6443 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c6ef4c1-7ee2-485f-5ad6-08de3968ee1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8973
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

