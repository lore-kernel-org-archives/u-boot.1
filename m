Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59533D6100C
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 12:00:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EE3983F32;
	Thu, 29 Jan 2026 13:00:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZVy3s62x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7853683F93; Thu, 29 Jan 2026 13:00:39 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48E5283F26
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 13:00:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.sanwal@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gGRy0lGnpSmnS/UMRy6pmXcznAfq8hiBMXDRdlwoe/T0NJBR6z28ki5/AGkaXciLwuWoXN2pW6JLB2Czss6E/yp4/HrYWaCT8U39FSJnn/l/7x6s2BlZgN5ebul9JlEPF2aWAbRuj1Q5WF9BsNPfS20pX4Fuu9ajOfOwxJnaaYlSW8t3OX9viwysslqbS5wDcsI0Vu9zMCQzkM6WCFijiIHO2u0zb7ixfVKpmFbd2x2dQRnAQoNFh6vPf+0rVIQR/v2FW05DOaiZH36UKJBzQ0tf2v/g1EhpcspdXEl7EGPgHN5caGLxBlGR7xVNO3miaIXXVSsauGJwoNWKrSDLvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWAxAvxzdFSLjflnh0wccz37qcT/KMiBaQtuS6Q2OA4=;
 b=GOIUeIQz2tilLm/JXCEB3tfKPALOQo8gkvl2xbWaVVcJK/ZrWmOlJXJd6aZlM0iaNAG+C046l+LSKzVPM1L3c6NkAColg8Js/xeQUmF7DeCq8TVqDclp2DruRSLVxJjzTQHM0CWJjihFmDsKp867FcdoQLP4jiGUs+TwTcgZIyVEZL1nT+6E4sNXrSW1pCNIQMKd+3Pm2GmkQBmTqxgk/amUaGbyVuH6xlAJn/4E0ngQkE6gBklJaDwgz2wEP3hVzV/sGN07PuA0aYG0iWirsnQOGyFLsqnNVCzzxThPw52eMb2B+MBIL2shBwGUIn2BW5hf7KVtQh/hyXxGZgUuPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWAxAvxzdFSLjflnh0wccz37qcT/KMiBaQtuS6Q2OA4=;
 b=ZVy3s62xSewAM8d73wu8d/c1XKBnE55HIEa58w6I5UBRGpE9ly8ILfd1g9sWCaxMn8/7ckTEW9PQ/5I3EqLkku0m2bAwZnFGNOMyD1XX7h3DkhdXcN0QzvdtfoK14YRX6kNP1BUgjLE2/FS/Y6JZvSmUvRA+iiGjdOMwOtFqnf0=
Received: from CH5P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::13)
 by DS0PR12MB8526.namprd12.prod.outlook.com (2603:10b6:8:163::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Thu, 29 Jan
 2026 12:00:33 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::95) by CH5P220CA0007.outlook.office365.com
 (2603:10b6:610:1ef::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.11 via Frontend Transport; Thu,
 29 Jan 2026 12:00:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Thu, 29 Jan 2026 12:00:32 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 29 Jan
 2026 06:00:32 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 29 Jan
 2026 04:00:31 -0800
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 29 Jan 2026 04:00:30 -0800
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH v5 1/2] fdtdec: Add declaration for get_next_memory_node()
 helper
Date: Thu, 29 Jan 2026 17:30:20 +0530
Message-ID: <20260129120021.1328653-2-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260129120021.1328653-1-pranav.sanwal@amd.com>
References: <20260129120021.1328653-1-pranav.sanwal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|DS0PR12MB8526:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b8f4557-c7ac-4a24-f0ed-08de5f2e0157
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z2r55MZQUU5mQZHVEWMLOBkjNVm/cYxu0MOPsxO6Mrv430SD1VN1yzK/LibT?=
 =?us-ascii?Q?nYhKz/8tTJWBX0jKltfDLoRvqBCxq76q/QBZe9Zauh3UboJ3qwx8JDjZDd76?=
 =?us-ascii?Q?ijRe90obTBuI/Osr4VB6/D/4EU7tYZ8/tw5P3Vf/opv2jIqPjSSbKKS81+CB?=
 =?us-ascii?Q?MxlQOm9zapFkg+I8z+Khk16zzuWlbB1qsg/rwAESrxT+fInNSCKZIXtLZXBO?=
 =?us-ascii?Q?/ngQ44l/PNCgByTXqYrhzHV3DjQ0KzwHsODu0QtWvLM/0ohzGQm13SUMJspJ?=
 =?us-ascii?Q?tXykXNUQ6ZPb2eYoOziOu/jQgIPK6bLw4H8LVSLz7cRbWTK3pO/giX5oycPN?=
 =?us-ascii?Q?csrlOeUNXYkLNinfb4VDakMXEbhAlgjgGzND+4PaczMkk3OW5gcNIFU+8+yF?=
 =?us-ascii?Q?trwtvfTi2bWAkHP0V2xd1Fv2G/xY6ZwERMXUrQvVQDtsMrBvFF8A7NbdxfbQ?=
 =?us-ascii?Q?aDq1uCMOcoU9cheSmxZ5Mz+whdqqmxKo+CG3ANEa+/kTQBAMCebZLseKwLRn?=
 =?us-ascii?Q?fYM/Fv1AfDg7gvCdTcAAHpPF5yWoK+vgDc6jQrr/rHzsF7mdvVGxhZyuL3gF?=
 =?us-ascii?Q?1BZrySIMFd0+CAqY36dRhYbQ560XfdA8Ijp7CKmUGQH0tp/pDbgQf1ZR5z2R?=
 =?us-ascii?Q?eXfvCpcHLyI7k8OXAPfmrl1eo3XhJwrBof/vproxFjU2k3oB6TDGHge3Rp9Q?=
 =?us-ascii?Q?EuGsDT3dm036D8XmSRQJIPvUcwx63R/bNQWUwwUrqj8qJReSjpbY9aqJ3FR5?=
 =?us-ascii?Q?OZlOf5/vnA5ncdRy+9cE+reZxB3hN90Ul42jwKZzpEs4trRgX6IZXts1QYQw?=
 =?us-ascii?Q?PJri46yQCHavGELt1kq2GL2UGMuQc4lf/XLDl4CKd3adxOxO2pF8awWCbbfA?=
 =?us-ascii?Q?lXVz7RhMJ0N8ha7x1XEffEjf4SMwQwTcumy+ArEYtcJPcfTd7mf2xTwpEfJs?=
 =?us-ascii?Q?GqCVKdrVVjg+9a4upvl2T6m1rUfc0MmGlZ6qzYmX1NEY7ssHpSiA91zIcWQJ?=
 =?us-ascii?Q?S3kBgUrbar7HspSz0dl9m76GGDEIC/6YXzO+2FAZF7nXMFHyK0LfiF9jYKuT?=
 =?us-ascii?Q?nAE7pyjkpG57K4v/lTNZ6Bd3A47FpQQNNfd518/UwzRatjldYPBCwOREoSH7?=
 =?us-ascii?Q?8XY/rtJZruTpTIpo5ZrOJ5G0yxmuGStYLpQAWyCYYalFsIlhlIT2v6vSIzMG?=
 =?us-ascii?Q?4WhYyAEUhHKv7d2qtU3iVlaXcGW6QdWLf8pWPBeAnE+3DqO+6x1TB2RmFRQk?=
 =?us-ascii?Q?t7UQo7oTBa05kydFYffUmUEy7wA8vu+1MjRsZYV96vU9Dpd1NM1Iqx8STVpN?=
 =?us-ascii?Q?z0diqJoRVMZ9zEqC8AmuP7IiZST1JzNNI75ujCxP9TJh3JfQzfW56dagELme?=
 =?us-ascii?Q?1Vao9HsTG9HUaiyvfZCAKBlmhVRZPlnI0kNOBi2SJ/aCwu8lHjs5nbERrdYR?=
 =?us-ascii?Q?KDIaMjGSJQcPdaZv1XGQe/HoDKGz+0FqfxJvtCOpgjyXAse7RggKRmlCmJ6A?=
 =?us-ascii?Q?79BUnXfirOQ137O8x7CkwEjI03qWJpgyfcoiHmX7mXPtFeAhTt5iU/f0B1Vw?=
 =?us-ascii?Q?ul34KJp8a8LpeF8d5u+AZ39F+P8nmf8kzbRk7csy3tDIzo4QsRFOoSBjTwnr?=
 =?us-ascii?Q?cGFMKtgkD1Wdo+q/6rGkCZw5zt+Zdm3F41i1WuVHXkluGzTZKrRMLLkN2Uag?=
 =?us-ascii?Q?LTDCcQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 12:00:32.8573 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8f4557-c7ac-4a24-f0ed-08de5f2e0157
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8526
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
 include/fdtdec.h | 24 ++++++++++++++++++++++++
 lib/fdtdec.c     |  7 ++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/include/fdtdec.h b/include/fdtdec.h
index d9fcd037ed2..4e09f9d718c 100644
--- a/include/fdtdec.h
+++ b/include/fdtdec.h
@@ -16,6 +16,7 @@
 
 #include <linux/libfdt.h>
 #include <pci.h>
+#include <dm/ofnode_decl.h>
 
 /*
  * Support for 64bit fdt addresses.
@@ -198,6 +199,29 @@ struct fdtdec_phandle_args {
 	uint32_t args[MAX_PHANDLE_ARGS];
 };
 
+/**
+ * fdtdec_get_next_memory_node() - Get the next enabled memory node from device tree
+ *
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
+ * Can be called multiple times to iterate through all memory nodes.
+ * Pass ofnode_null() on first call, then pass the returned node
+ * on subsequent calls until an invalid node is returned.
+ *
+ * Return: Next valid, enabled memory ofnode, or invalid ofnode if no more
+ *         memory nodes exist
+ */
+ofnode fdtdec_get_next_memory_node(ofnode mem);
+
 /**
  * fdtdec_parse_phandle_with_args() - Find a node pointed by phandle in a list
  *
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index c38738b48c7..3779076377f 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1083,7 +1083,7 @@ int fdtdec_setup_mem_size_base(void)
 	return 0;
 }
 
-ofnode get_next_memory_node(ofnode mem)
+static ofnode get_next_memory_node(ofnode mem)
 {
 	do {
 		mem = ofnode_by_prop_value(mem, "device_type", "memory", 7);
@@ -1092,6 +1092,11 @@ ofnode get_next_memory_node(ofnode mem)
 	return mem;
 }
 
+ofnode fdtdec_get_next_memory_node(ofnode mem)
+{
+	return get_next_memory_node(mem);
+}
+
 int fdtdec_setup_memory_banksize(void)
 {
 	int bank, ret, reg = 0;
-- 
2.34.1

