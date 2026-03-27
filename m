Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C65F010ED660
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 12:11:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0559B83F14;
	Fri, 27 Mar 2026 13:10:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QaflU3Yu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67CFB83FE9; Fri, 27 Mar 2026 13:10:43 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46B4A83C14
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 13:10:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.sanwal@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=onjABtnDUICh3sKExX9iJSjU7d9uod7S/YcShqkO14u3ehGxmFJ9hl6o09CkQxgeMjBrEUerutS+oiWNOdjBP9+yVnVjT0U6LY9UOtYIXZ4VAjFm8oomQsCAzumuZg4wT9ehv+s08ovAPn3gAKnFNnrvNWqc5n1DpZ+rSJaPyf3Y1kzP6jkkz0M4xDs7Ie3rohacpBjY5REcdO2D7mRuaNUbondyvoF4ZU71i/4VXPSIsbcPS6tZoGKYCqeda/Y+2pgSdagK+gQDod9JcnB1ljIXsMWy+Cgtm/Ojdp5IfKvLpxiQhmcodCWyOPl++Y2n1OucxuVVEkeF8DyMFtqxAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0X5KKfIUfzO8HAdTEpY8X5WCjEtf/H9BIbVoiJSJl/0=;
 b=tn/vGiAQ5rt4OnihjioGGo4jlKJsKHrK60MZz+JkbZm+2fxhIqTPZrtDPfP1u+jVfdy3V/2WOXWvh50Xzt+orshoUgQL0Ibu96v05Fuz5X0AXvgWnXZwEDhD8MnQxhJ/YI5y6Y7I9ByikuGJeI2/1h3n+XlcG2GFeaGWe10Ddi2H30PnCuu9icWCqMeBRtEYpDgdl929nEW+dAbHpdkNXzkMIwGhc2I6QnpHCc3ngWjAraqYaEPZOQ5ztU9d+uHTHvIeFlLXu7Ljf85UzsQmqgd/iCL6kuDkGKC3BBxTm6juOTiZBxNJgajDKqEpb+xiLwoeMNwSd6dzN+6QwvfoGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0X5KKfIUfzO8HAdTEpY8X5WCjEtf/H9BIbVoiJSJl/0=;
 b=QaflU3YurQtoYElrncjqDZcBEPKtmQvLhnYtTHn742zDZ0LEf0X3TR4Z2HL1NdcpgNbCPEs7S0tgEKWIh4dBIdfnOHN0Q9RlyvlTamOKRV0ftq5aQaBoBPtOUFgPdHk41Xx7K3mdTP1c5BOGJfmWJgDgNzR3y4jD0ddVy9SI9sw=
Received: from SJ0PR03CA0141.namprd03.prod.outlook.com (2603:10b6:a03:33c::26)
 by PH0PR12MB7932.namprd12.prod.outlook.com (2603:10b6:510:280::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Fri, 27 Mar
 2026 12:10:35 +0000
Received: from CO1PEPF00012E82.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::cb) by SJ0PR03CA0141.outlook.office365.com
 (2603:10b6:a03:33c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.23 via Frontend Transport; Fri,
 27 Mar 2026 12:10:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E82.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 12:10:34 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Mar
 2026 07:10:28 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Mar
 2026 05:10:27 -0700
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 27 Mar 2026 07:10:25 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH 2/3] arm: versal2: Map PCIe DBI and config regions when PCIe
 is enabled
Date: Fri, 27 Mar 2026 17:40:14 +0530
Message-ID: <20260327121015.996806-3-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260327121015.996806-1-pranav.sanwal@amd.com>
References: <20260327121015.996806-1-pranav.sanwal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E82:EE_|PH0PR12MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: 701ed661-a34e-4c03-fa07-08de8bf9d9a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: bFuWrvpXZvCw7vwQ6hXgxBKgHDkBtClPfqJg9c1xOiwwxeEriV+kzz8MzRFcXR8BpKcKc37OgkU/UmarWj2OZC10oi/bCWCcQ6A+Ii3Z0ZJLVwx0IUDUVeXbT3Zc3trdsE+SBB7g8rVbldBUwe7piU1bfSnuQlyY5bNcGt/S5nYh/iw8VVPcMoT9GtW1vobWUsmgQwensp0VAnNgRvyBIGoZuiIZeFwMJCO39hKMFUbYzrq35tbBms1GbpiNic3n3EKIqQ2gN9GcwUoNyK5tTWvDRwSVddVUt4EwQgdwMQ/orfdoinq6LpYEV0FRAgNKcYU9XPBM5oSl5dSM/3cpIFERI0ZleRbEA2xmFCFpzThwR5VgWQMT7/mwtTld4PHgxw6c7OYE62fll7ewukudF1Zeqi60dI8C3OiqPPdGpedf7zDvPh9kDejt4JU3ZRx9JBEWWlVM0nxllSjYPnWX+KrC+LztCPXW6X8Fxr1+GNjmFnsyR26udb0tkzT60iICblXcJvw724e5y07tdNsa/pyfnF562DPtLKTDciruKCwfB+9Fp+NEd77BRh5mxI2OSYjBbI2Nhgg6487YuxZjJ+FyTf6UZPs5nEosd4J911jv+jZhcCYVQa4c6Fa3eNeQ4uMCRBz+TbJ4MDQlVNsSf3PdIuZxqEGSZYilGJqyrZpv1GHdqEVSkjbF0XQPaQdSioh7poTDYwVydCtZlm3fRCJfu18P6l0v07BxZJsi3L+8FdpdSKsXhhB/iYbRf/1Us0JzMjRkyExvzHhPPIXdcQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9xSSnCIYlBGTa6yb51CGB8DS5tZOPeUKZ1abhN4hjVamP8oeU9VTAFBfr5Kb+fHt8cR9LnH9NM4iiE3BBJlL8b+V4Kb1jHnrs7xJt/CgR8WrcPHRtO3WDxDxngzhPGhOL8UbJdYiVlqpHnhHZG1D1Dqgu8LFQv+zB8I5y/R1h5Ikl9TxbDtpuH0xZMXmlWDp5Z3V7A0p45eSPPspnFEgOBIlOWM/q2j4S43GLpYPuSUDSMkUSBIGePosOklW4QC6zjYMO2PE6LdKo6FSV01k3yrwyiZK5xmntAooNYMB9qdCc/INyXGSfyxviEUgZk4eTkIzp50/N1VHZu9rKTUAvI7T8Z741o7xkPZPtvTjbyl4DkbfSRdCGf9Oh5ARC5SufKldivLUVAUy+JIg1N61cJKoqu4uItoO5n9Kheqq2W9qGAO/0FpOWxKcZz9vQ+2O
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 12:10:34.6986 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 701ed661-a34e-4c03-fa07-08de8bf9d9a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E82.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7932
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

The AMD Versal Gen 2 PCIe host controller places its DBI registers
(0x100000000000, 1 MB) and config space (0x100000100000, 255 MB)
above 1 TB. Without MMU entries covering these ranges, U-Boot faults
when the PCIe driver accesses them.

The two regions are merged into a single entry as these are
contiguous and share identical MMU attributes. Add this
entry under a CONFIG_IS_ENABLED(PCIE_DW_AMD) guard so it is only
included when the PCIe driver is configured. VERSAL2_MEM_MAP_USED is
adjusted from 5 to 6 accordingly, keeping the DRAM bank index correct.

Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
---
 arch/arm/mach-versal2/cpu.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-versal2/cpu.c b/arch/arm/mach-versal2/cpu.c
index 9a02fe40733..9998386fed4 100644
--- a/arch/arm/mach-versal2/cpu.c
+++ b/arch/arm/mach-versal2/cpu.c
@@ -18,7 +18,11 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+#if CONFIG_IS_ENABLED(PCIE_DW_AMD)
+#define VERSAL2_MEM_MAP_USED	6
+#else
 #define VERSAL2_MEM_MAP_USED	5
+#endif
 
 #define DRAM_BANKS CONFIG_NR_DRAM_BANKS
 
@@ -60,6 +64,16 @@ static struct mm_region versal2_mem_map[VERSAL2_MEM_MAP_MAX] = {
 		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
 			 PTE_BLOCK_NON_SHARE |
 			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+#if CONFIG_IS_ENABLED(PCIE_DW_AMD)
+	}, {
+		/* PCIe DBI (1 MB) and config space (255 MB) are contiguous */
+		.virt = 0x100000000000UL,
+		.phys = 0x100000000000UL,
+		.size = 0x10000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+#endif
 	}
 };
 
@@ -69,7 +83,7 @@ static struct mm_region versal2_mem_map[VERSAL2_MEM_MAP_MAX] = {
  * @num_banks: Number of valid DRAM banks in bank_info array
  *
  * Copies DRAM bank information into the global versal2_mem_map[] array
- * starting at index VERSAL2_MEM_MAP_USED (5), which is after the fixed
+ * starting at index VERSAL2_MEM_MAP_USED, which is after the fixed
  * device mappings. This must be called early in boot before MMU
  * initialization so that get_page_table_size() can calculate the
  * required page table size based on actual memory configuration.
-- 
2.34.1

