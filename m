Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B525FD7F9C
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 11:57:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35F4783E83;
	Fri, 27 Feb 2026 12:57:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="b6Hteh9B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F59683AA9; Fri, 27 Feb 2026 12:57:29 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FFB183D1A
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 12:57:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TtXU0iHyuQgjY22G/mtOPohR9OPreHlhOsGBA0l50FPXK+y5ixTktVn2HErZDEYMlpNXhp2tbxLVfJoxLbEjH0dikA55imbMBtV5rIDz8EH1XkTWaf+4LFxFqMjJUA5hKPx1BuqW0S3ylVbITe3KDjhxQ8kR4T5AUkxlTCY6uW7pfUUxDWCgi7rGyW/k6x8vjYmKSlv98x4Id8N48J5aXA5nPTjg5hBeXqzzLCtZ3HB/OBpszrGv4GHuIlPXXnP8g8JUvmbUAYmgWvs8Iluhv8KKpLsaglONxLhLMYOQlkYIQyU96sz07GXTUpfod/adgmBKbuNphbikY/d2D95sPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVKbXQJPGCnjIqCxUjm4VF3vDmk++TGmwhM3S8FWKJk=;
 b=YxDKQbO/jn0ej/J9w735n02jQOgQjmGaz9aiQFgmAkz9rHLHUAlc466XpaGpBollnkeOaWaaFXWXaNuMxb63ZgBb14/NQbb6GNMaPSRNgy988w6La5Y7N0MZkt5vOKhN1urs+GBWtmaUh7zFaY5FtRDHYrS486Uwi1NcLpg3kFgO0CX1vhrIFvY/uKebLJyas/H08r70zYGL7MfZ53mKTUVCFBXYALJS44DNCmkgI+wHUxF0ailm9JBnXJJfDTce99iWUEKXTT9IVbzHKNaDxlfAQmxkjrvyt3Z+Bu8U0gKFLZTWeETkUmUGX0Cbt+ez6dxFlgyR4zzBfE1lHgH8Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVKbXQJPGCnjIqCxUjm4VF3vDmk++TGmwhM3S8FWKJk=;
 b=b6Hteh9BgD99nII1ue+ttZr4J0xSbDgkfTmQzD1WYbqWbFfcb6kFUbX+CFGoXBLA+ZBtfvW9qn2di1hpsXZmagV0hkHiZeP9xTO14YpXK37DDHQgSDhbwvClKdNC5EhmrtYzt9B0BiTfU+uBIt9la2vSM9hgwsvW/enWb64D6f8=
Received: from BL1P223CA0020.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::25)
 by CH3PR10MB7259.namprd10.prod.outlook.com (2603:10b6:610:12a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 11:57:23 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::9a) by BL1P223CA0020.outlook.office365.com
 (2603:10b6:208:2c4::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.27 via Frontend Transport; Fri,
 27 Feb 2026 11:57:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 11:57:21 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 05:57:21 -0600
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 05:57:21 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 27 Feb 2026 05:57:21 -0600
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61RBvApY3689228;
 Fri, 27 Feb 2026 05:57:16 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <anshuld@ti.com>,
 <d-gole@ti.com>, <n-francis@ti.com>, <bb@ti.com>, <jm@ti.com>, <s-k6@ti.com>, 
 <afd@ti.com>, <u-kumar1@ti.com>, <marek.vasut+renesas@mailbox.org>,
 <a-dutta@ti.com>, <neil.armstrong@linaro.org>, <semen.protsenko@linaro.org>,
 <peng.fan@nxp.com>, <george.mccollister@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 1/6] arm: mach-k3: arm64-mmu: add mapping for PCIe 4 GB
 Address Windows
Date: Fri, 27 Feb 2026 17:28:29 +0530
Message-ID: <20260227115841.333073-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260227115841.333073-1-s-vadapalli@ti.com>
References: <20260227115841.333073-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|CH3PR10MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: 8745c6bd-f4d5-4311-9e46-08de75f75d99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|34020700016|1800799024|82310400026|921020; 
X-Microsoft-Antispam-Message-Info: 8f+yh0i80aMGeV0xmeJHTBZcRbQ9minA7tVbsHDO9gqXwr4rWEDO65NMF6DJ330i038TrU6Xy8sO13YHH0pEtPdGlBqjqN5Qnmuct6e/UCTvvLJN0wOuFdaI8DzXm4JdG33JXnuqYpbR+TynzBahTD5XQWxTr/ILxhz56/IdDpcEjppmifm3+vgdHhhgNOjOt9Amp9bT1BBkqFU+yM6jAsWB+BlSvc0IyckMXbskacVBCfvX/wKnlnwDhdNKfuoUvyfPnBk3Rzts4sM+ODJgfZn4lPXvAVlT/R+kA/vJpWQcRlSB75lxaL/NejP7NU/T1g2pb3GL8inZDvJTQjsbt4v6BRKqpH+K2clsQCjyp9T61vEijOwn9l2co0C5e+SnrYNOh6Xqy3h0XxOLt+ojJMOefG5CkK0TglseiZE+4cXXOC6kfOXIBLduSbLYTB4Fffs6bHVKIjGtl+8qTB7qxuTkrgdiboCzzuU+q+0jNAzamUvcbNG9dbj8ExNKZwNynGn0ACWG3n1/TzTX0tkUIRtftYlqyAZDzRD5DcSycGZt6oxQFilonWgW+hiimgWQpOLLE2KhAtLOKHg3iBuXhUysjRMsaJoar5qiREz2vYqsFmBBpfwUzqEo3CWyG1QAMBO0TgWfL6KLCJE0kMAoVpgiJAjQz6+QBMoCl5vcCndAgB/M4cQOCBsYh8Fb4/1VKlaEC5rOR8N3evhbPxCJKT4AHZ+37qqHfpgmQmb0y3QDq0VB2kjbkU4eihyVkbBBgGKYlivw50OG+HPOk1xX1khv+nOWPviOzJTN39I0JW7QioJhIclG0i9ZXcLEqYB07q7F7EKrj+A4ppPC8GMiyk0Bs6lLfLwDD6MjxNri68o=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(34020700016)(1800799024)(82310400026)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jsCtnlPZ9h+7oXKMaYvMmU4zc/hYbbhdZa0CAycE7sVwBj4AW3rtjz9QftWTt4A5qYUd47unastKk9MytvtvNewmTG5wvLN4Dy7RAkRKVC5VGQLQABwtAZVy0XR/l1EKzP/8UnmLV5oqpZQgXDnM/BM/rkAKLF70+sRYblmmgRrq/3+76Gx+/2X6Z14uOF1TC/bv9NhDGn1eYGfDYvQBSJpsJnDqt92sNv64Cn1sJOLhLsllcxoFMTKlbz8HXJe2ibelnLXHM+Utk7kM9qyrNHqw8hsHD9ubMavbRI/TKIzcFTOQZ6w88457g8z13zDTbJEwrBU4BqvgZltgtNBHeTMsl6XWrGeH5hC9N5l4wCY/73VcVNl6syCoalCNdbNgE7Z1Ra/gdgbg6JZcnlU6bMKR3v4QdFoF1rVKKFzbjLqcx+jzSGU0wmY4eKw2meRi
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 11:57:21.9793 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8745c6bd-f4d5-4311-9e46-08de75f75d99
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7259
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

The PCIe Controllers in the K3 SoCs have 4 GB Address Windows in the
64-bit address space to map System (CPU) Addresses to PCIe Bus Addresses.
The physical addresses for these Address Windows across PCIe instances
across SoCs is as follows:

+--------+----------------+----------------+----------------+----------------+
| SoC    | PCIe0          | PCIe1          | PCIe2          | PCIe3          |
+--------+----------------+----------------+----------------+----------------+
| AM64   | 0x6_0000_0000  | NA             | NA             | NA             |
| J722S  | 0x6_0000_0000  | NA             | NA             | NA             |
| AM68   | NA             | 0x41_0000_0000 | NA             | NA             |
| J7200  | NA             | 0x41_0000_0000 | NA             | NA             |
| J721S2 | NA             | 0x41_0000_0000 | NA             | NA             |
| J742S2 | 0x40_0000_0000 | 0x41_0000_0000 | NA             | NA             |
| AM69   | 0x40_0000_0000 | 0x41_0000_0000 | 0x42_0000_0000 | 0x43_0000_0000 |
| J721E  | 0x40_0000_0000 | 0x41_0000_0000 | 0x42_0000_0000 | 0x43_0000_0000 |
| J784S4 | 0x40_0000_0000 | 0x41_0000_0000 | 0x42_0000_0000 | 0x43_0000_0000 |
+--------+----------------+----------------+----------------+----------------+

Two regions for a 1:1 mapping from virtual addresses to physical addresses
catering to all of the above will be required, which are:
1. For AM64 and J722S SoCs
=> Start: 0x6_0000_0000 Size: 0x1_0000_0000
2. For AM68, AM69, J7200, J721E, J721S2, J742S2 and J784S4 SoCs
=> Start: 0x40_0000_0000 Size: 0x4_0000_0000

Since the 'Flash Peripherals' region from 0x5_0000_0000 to 0x8_7FFF_FFFF
includes the mapping for AM64 and J722S SoCs, only the second region
mentioned above needs to be added.

Hence, add the region to support 64-bit address space for PCIe.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 arch/arm/mach-k3/arm64/arm64-mmu.c     | 16 ++++++++++++++++
 arch/arm/mach-k3/include/mach/k3-ddr.h | 11 +++++++----
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-k3/arm64/arm64-mmu.c b/arch/arm/mach-k3/arm64/arm64-mmu.c
index f999af143fb..e032755db0d 100644
--- a/arch/arm/mach-k3/arm64/arm64-mmu.c
+++ b/arch/arm/mach-k3/arm64/arm64-mmu.c
@@ -29,6 +29,22 @@ struct mm_region k3_mem_map[K3_MEM_MAP_LEN] = {
 		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
 			 PTE_BLOCK_NON_SHARE |
 			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, { /*
+	      * PCIe 4 GB Address Window for AM64 and J722S SoCs starts
+	      * from 0x6_0000_0000 and has a size of 0x1_0000_0000.
+	      * Since this is already enabled by the 'Flash Peripherals'
+	      * region above, we don't need to add it again.
+	      *
+	      * The PCIe 4 GB Address Windows for AM68, AM69, J7200, J721E,
+	      * J721S2, J742S2 and J784S4 SoCs are enabled by the following
+	      * region.
+	      */
+		.virt = 0x4000000000UL,
+		.phys = 0x4000000000UL,
+		.size = 0x400000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
 	}, [K3_MEM_MAP_FIRST_BANK_IDX] = { /* First DRAM Bank of size 2G */
 		.virt = CFG_SYS_SDRAM_BASE,
 		.phys = CFG_SYS_SDRAM_BASE,
diff --git a/arch/arm/mach-k3/include/mach/k3-ddr.h b/arch/arm/mach-k3/include/mach/k3-ddr.h
index 207e60b2763..6ac7f682fb8 100644
--- a/arch/arm/mach-k3/include/mach/k3-ddr.h
+++ b/arch/arm/mach-k3/include/mach/k3-ddr.h
@@ -8,11 +8,14 @@
 
 #include <spl.h>
 
-/* We need 3 extra entries for:
- *   SoC peripherals, flash and the sentinel value.
+/* We need 4 extra entries for:
+ * 1. SoC peripherals
+ * 2. Flash
+ * 3. PCIe 4GB Windows for AM68, AM69, J7200, J721E, J721S2, J742S2 and J784S4 SoCs
+ * 4. Sentinel value
  */
-#define K3_MEM_MAP_LEN			((CONFIG_NR_DRAM_BANKS) + 3)
-#define K3_MEM_MAP_FIRST_BANK_IDX	2
+#define K3_MEM_MAP_LEN			((CONFIG_NR_DRAM_BANKS) + 4)
+#define K3_MEM_MAP_FIRST_BANK_IDX	3
 
 int dram_init(void);
 int dram_init_banksize(void);
-- 
2.51.1

