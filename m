Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE1AD41C14
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 10:12:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32E4A83DF3;
	Thu, 11 Dec 2025 11:06:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zsqukkUR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FE1E83B48; Thu, 11 Dec 2025 10:26:41 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78915835B3
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 10:26:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.sanwal@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xHXnwnDUESY3Xu5YoFMmRv/Y0jNUdKu7WvDvMb0l0T3gwOsR7C7pCJViV/oeaFW7BawYqbOgK7oI/OQSH/TdPXc4+/do5MSliCft4NRgoQL+v9G3K2psnsvjtpxHZQFnMsslYxcsUO9t+Yccx31pbwl04x8fkbyB16iw/6QHBPIq3YG5glbxpCtYgaEhliMpY2k6FsdPrTGqYEH5FsPm2cPfwJDezLbaHQgYFCcl1OE4+lzM8YxOMeN1u/slfmvp6FZbaVIypM608YRhtZlaQzKao7nVPqHTb4I+oDrfnyVrPn3+ngJq8Hp83yn5GOkf3j1rAnoYAwaTQHbz3zW7tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElIo0OTnjTCCUOCK1/lyAeGXn10gxstrYG51+xanE2k=;
 b=b3HI01ClAHljLTl25P+eo5CAqCREtp8qeGFkz8P1CYBrK3Vx21yt39LhswZaZtB9VgD97C+SHf/7hYPAV5cVbJUwdfYMjZZG3z3CWsRq6imgQLe479q9tidUP2IH5dmU092clOU/Vvhu5Akx4tZXlsphrvZiu7esC8Ho0w1o4d/0mGMVfnEKz6ljwN+rljEn1oj6ZGW59+lnSfDSNqpcYhUVkXrQOJd7NZgikarpCpTvEO9lOJcotdcqMtBICeSyV84uK8Wt6/7jepIuq1hDy/Bt8e+qSH3klDPaHoL5Sdjq8QMCjyPzp0JWfgDla2zZQY6zUQJmDYwMRHdx1VL1sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElIo0OTnjTCCUOCK1/lyAeGXn10gxstrYG51+xanE2k=;
 b=zsqukkURNkLvei1FGYiKWEtqzvLgqU5DUVOGxpWshUoTG2j1J6fHWnfCwxGuUFAYcWy+kGcRTpAiYrHnL9eLcNU1VUs8mfXLcWBMkcEZ4yjyvti70sk9ARHvbR8EgF/ox59AzfM1MkQ/CAvg2VTlEeFe8chjs9mVyNcbluM2QW8=
Received: from DM5PR07CA0118.namprd07.prod.outlook.com (2603:10b6:4:ae::47) by
 IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 09:26:29 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:4:ae:cafe::97) by DM5PR07CA0118.outlook.office365.com
 (2603:10b6:4:ae::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.9 via Frontend Transport; Thu,
 11 Dec 2025 09:26:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Thu, 11 Dec 2025 09:26:28 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Dec
 2025 03:26:27 -0600
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 11 Dec 2025 01:26:26 -0800
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH v3 1/2] fdtdec: Add declaration for get_next_memory_node()
 helper
Date: Thu, 11 Dec 2025 14:56:17 +0530
Message-ID: <20251211092618.2320004-2-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251211092618.2320004-1-pranav.sanwal@amd.com>
References: <20251211092618.2320004-1-pranav.sanwal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|IA1PR12MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ece7def-1643-4a92-cd72-08de38975d53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hV3ohWQccsnnEbvL3TA3HMxSXXd2WXy3K7EndEUuTbw2vD+1nOtuQrO22/LX?=
 =?us-ascii?Q?oLmFp5OkqbPx36nMSTC+S4K0dwWcZ1NTfkVacKSxeuZ7WwvXKEntP04E9vBZ?=
 =?us-ascii?Q?kr9JHN7zaJSMOhKd4KNIj0zgZcBdg64UShJh5zOXm8I1vMpbgh+wQQGSb6AS?=
 =?us-ascii?Q?pR7Zzkg51E190azY/Ljtg2T7pmpmvkr+0Joalranf0iGXxUZCpIDsn0lwazO?=
 =?us-ascii?Q?ZBJSEt3K6c8mCWsDQE23Q7/X23roFd9Ee8ECMla2QbYi4snju1ZtSmV/O30R?=
 =?us-ascii?Q?8u13/Sz+2fWzHrFzJHHV6sXrm9JZfgLVx49SSKpZgTp633tgwx/fnh16l/Z/?=
 =?us-ascii?Q?BhoT51DbU7pTwxuAKK99od/hQC27pQlsNV+WWfWpgrLe44mMH3nLU3iW3HAw?=
 =?us-ascii?Q?A8a8QXrTUuv/1dipNsMKRQ/2sB86pY+ZeKwj6koCqFXEmg6BqT6vgYqzJLvw?=
 =?us-ascii?Q?J/9YuHf7I5Nf+lUoha2liJgzChJqUND/9IuH2sH7EFoCqrvSTdok/CLTKX4i?=
 =?us-ascii?Q?L0pbBmHiJ2I2wEDgG+KcHjYZD/bta8c8RTlubTYeq8MR1PB43WGICa4EezYj?=
 =?us-ascii?Q?gL1ZUYjI1qvT4+H6l8IUWf5aZLFMWFojIGkVODiPgNypaHu8m9zCs/HnuSJR?=
 =?us-ascii?Q?WYRneFTALisFSo0ArEJTLDcNhr9QAT4NYndURWRBGGbYijonS2JObDNYiIX5?=
 =?us-ascii?Q?kVZd72XM0tWn+hEcCTGX82JKgg8A3EQte1rhjCPx2IjumQ9HXwNqzgiGQ+f+?=
 =?us-ascii?Q?jfTi2H+dngCISWwnbjC/ONzCGSwZ+uMp8gSBNTm63P3XOVyCPxSDlBFBiIg+?=
 =?us-ascii?Q?31+vW24uo7WjqnbM3gJaaWIqfVxjC38S8rQe1aGZQ1RIa0jmHPeqS1QpDuaP?=
 =?us-ascii?Q?ee69CHzfYPeaq0SfMu/GoxxV+D+B9kSvRkIf03wJy3DXI9IdLA6iljWpZtvI?=
 =?us-ascii?Q?gA/MGBQ99SLtKu4AvJxyOkt9pcG++E3+nzlttsF7oQEqOkixDPxEtqHw9PKE?=
 =?us-ascii?Q?SYAdbN9b8tybw3A0SOpvxuZnYqxWe9xexsV3zgfJmOEYeF9t8YBmkFGI8/FJ?=
 =?us-ascii?Q?D/+6CKDnD2lIDcqjTjUpjCpfV8TKifr3TLwOQDC23EohuJWNFGBZle2ch8gN?=
 =?us-ascii?Q?mME3YxyVaCMuIFgcmOt8PPA3whcWt3H9cpB9CY75UWrak94cnMCExrjylxRu?=
 =?us-ascii?Q?4JBo3hJ1DpccfgL9KXsqXM642PZum2cTTXvIDO4fNX9vJcOhv+9NN4kMwVQZ?=
 =?us-ascii?Q?QDxbbEbYLN5puWO6yTbkgdF+6SdaGgvdF5gWYi+6rRyKYfZul8WwN1DeMdbz?=
 =?us-ascii?Q?vr0q4qoMeltQ0NDGlDkE1VbXwLQefNQ1u/eKaVWrCCuBfdsbZZU62nbenuvx?=
 =?us-ascii?Q?oBFg0pcxSLrYnoS9hPJxa1/HIhzd2YRU2DKdCL9L0kkYXGUXNWAy+JzZPjyu?=
 =?us-ascii?Q?JVQsSyEJ3OCQOU27P+Ikdo1dBrygWArwNbVgm9TRoB3zQTNC3cxkIfi/7SxG?=
 =?us-ascii?Q?4j5l+aF5XIh82YP9J8RwfFjKTVwUQB7plzfqCCiD0fR3EjL8tiHiFik8qtW4?=
 =?us-ascii?Q?va0nBbdmIn7a/5SerWI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 09:26:28.9399 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ece7def-1643-4a92-cd72-08de38975d53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7736
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

