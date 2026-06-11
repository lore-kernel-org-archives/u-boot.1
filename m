Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936D5CD98D2
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 12:10:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4BF2846A7;
	Thu, 11 Jun 2026 14:10:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qz3CG8RB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A4D184704; Thu, 11 Jun 2026 14:10:51 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2118F8466E
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 14:10:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyiEd3iNA5w+Dr77vt426z+KimbgmSGWIBTx/MNUGP4KzIhM8+oFp7FxwQX8hd0KA/WZ6TLI8Mo6zsSR88podWkAs5UpsC6wpe0ymNZAEmgR6nIuUvsupASxK4G0vYzyeuCAirimxAgyLloNIDhq+1LPvw26MSVXcBNh3fzkvVL+Pqv3rjFKl0H8EvQ4tQHh9e2R+ce2Jn1WjyEj2liTyiJANe6iVecmnllfhk/7DPBwqmV/DiXGRXVP9TiFw0w6VRnOCpeBaaF5jWsroELd0qsUHCWnAxiDvkzX339kNGafuPhlaSfviyqzjxSqCTRA9NvaIyMeGBGX3tfsetOmsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/1cSRyYpnLKrghq2t23ZWnuyxypzLYUI2S1/7dHpZY=;
 b=WPi83NG6hHMUV6JZ2XMW1CpFhKS/vOq5chqy+JvI8+cAtMMUR23Mo67yiwDiqeDSbnBpAoIX7+85eEcjSrJYRpV/jewHk/2BrJZRWFiRiWUwBvvpPrvWvXcwXlwWC2dzDOKJxKVyEtEQzVTQLw13qNw6NLOROgVph1cT8PQ3ArZDgRC8w0crpqeiTISbASToNKH55NdoHlQ5qyxo6ki031f84bVbK6slLux24XRCFJuDqoYdraV1//u1bQuddNeC2C8Tg3yD7Uwcdc6WAkcqz6BFn2nF2OaCMBJEglvALjbHm7itl7+ApsAx6JVbwkvu+WMEOZmj4YYPKJWI7HnQWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/1cSRyYpnLKrghq2t23ZWnuyxypzLYUI2S1/7dHpZY=;
 b=Qz3CG8RB8X27Bx4kICXk28u1toVrGysWYJlOLHHTqAkuvtzbSpAxMnH72dqRxMILVQ1QGCV52yzglVTA4CptGwKLBoyS1hXDlpFuYDE7U6kQE7815g/s8aP+5579evD7FoHKiMBZDqV0hO4eOOvSz4gWqA5cQOAaW0qF8/dUcYE=
Received: from BLAPR03CA0082.namprd03.prod.outlook.com (2603:10b6:208:329::27)
 by SA3PR12MB7831.namprd12.prod.outlook.com (2603:10b6:806:311::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 12:10:44 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::38) by BLAPR03CA0082.outlook.office365.com
 (2603:10b6:208:329::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.13 via Frontend Transport; Thu,
 11 Jun 2026 12:10:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 12:10:43 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 07:10:42 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 05:10:41 -0700
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Thu, 11 Jun 2026 07:10:40 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] arm64: versal: Drop static DDR and PCIe MMU mappings
Date: Thu, 11 Jun 2026 14:10:26 +0200
Message-ID: <6fad36f9e7abdfee2fd29943f3a5b63d1421eaf9.1781179823.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <156e48d8228acfeba8866618038b48cd51490ea7.1781179823.git.michal.simek@amd.com>
References: <156e48d8228acfeba8866618038b48cd51490ea7.1781179823.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2339; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=52zI1cSCTccGMbIdj8u2NuPR4b48uFN57MEulQtwpdc=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRpLd1mfnXht3b1BTaCAl+3yB6vO7nq3OQN3n9mKNnn7
 /y1oHPv+45SFgYxDgZZMUWW6Uw6Dmu+XVsqtjwyH2YOKxPIEAYuTgGYyNtkhv8hn5cHZhRcFzUz
 17K1kn4V4r+/YW/VxA2ms+4c2lD9QpeH4Z++VFac7cXCy5/X9+kl1O6PiRXo3LDE87ZfSObrgMM
 cu3gA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|SA3PR12MB7831:EE_
X-MS-Office365-Filtering-Correlation-Id: f423d934-ece2-40e5-73eb-08dec7b27652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: IhoWcuQWsqXIGydh/ImCAtvAYR7QQ0tLOGQLJXnaAGYLHCYXIhG579qWU5uPk4RQ3uEurz2JKx3xKvsECdbZhcllYhYb0bw14Z4KI0ypdi80KVmUhrmY4iI5Y6J5ArXYgJ4BsyokfM5AOXTJowsJhSPW4tk5a44AQFZrtfvIO1SwmnqnhXzNAw5ZhxN9zHue1CVvQr4288gVlbbwgU2wIaFpG5iQRpjeH7a18Cz4q/XXT6XjDAsRZcRQN1GzHetDOg/TQG1vQL66suytYZdjR3zsEBNlaReBDbm8Ac5cVoVDj9FaZA8IOR8R7k2Lq9+XUdl6qDotAHqboWICubdpRiUfX5eTM4m8iAOGnHRMpD4ksNUjXkpjoCDsRHhgbNm5x3w7p2ifr6TzB4JBX5xud7MLvsIWG+rJQwDf2lBNUhvBSzH5WzXjmHd7kuWxrNoYYDgLD6lFInXD9h32LSCmo2WyiYaJMVd2eeAUhvlMl3erODAY2Z4/9GCidw9MvNi6ZyV0l1fhtcLnK0MVg29koXz3YOuX/fFtENJa71kS5A6wjH2xDpbXhnSnQSy7q4jvc8eOJrhkgNN9khP5rIP9cspZ8Rf4wgQ5uaoPl1jVxFM25oQhhdw1pfNHv/k8nFkA8QPoqU4FkdQTGjJaKu6pgJzTY7B6p/ArEROU1K3xK6Bw4opz4aFYxyjJRH5XTRDPVJc4QaE05HsQYcMqC/qjVuCRerRtMNC/U77ZjXlfYww=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PQiTJfxa1BJqnq0s0qpw+uIBJzJW15m5xuNHmkOHXQX0DgRgurZj7ocIiazxSsGKTeTy475f//tcPOceKBneFF5sBnpMtRPQujJ6gCrLsJgwWQk8SlX0S6On0v68nJPqYk+5ul7ZFZLsOH99e2CgQ0mM0yt/44H4jBFBdcjGJJ1bPIvzCxkCjc5EpEz191OuAhQVDZvA6ZFXl80Th8SoAq3lqux32aHabWf10kgWUwDI8VUiVZm7vjnSHbbXEfMWE7eSh7JfxS4xawXiIFfoVx1f+cqg5FeyqTi5VeVDGk79E7auBKR8a8RAI1PUKHmwoQSJi+ItHiURND+iY0icvKAGxeQ5qOin/iScemMqGl7oQealMa8fJ85ZhOCP6svKLzlRrwX6H5Huet2iTQcJiyg6AtL+RPWS69a/dI6Oqzeh+i7CuqAFpMZREDwg1Qb7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 12:10:43.6050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f423d934-ece2-40e5-73eb-08dec7b27652
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7831
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

AM011 Versal ACAP TRM, Table 43, defines:
- 0x006_0000_0000 - 0x007_FFFF_FFFF PCIe region 1
- 0x008_0000_0000 - 0x00F_FFFF_FFFF DDR controller 0 region 1
- 0x040_0000_0000 - 0x04F_FFFF_FFFF HBM0
- 0x050_0000_0000 - 0x05F_FFFF_FFFF HBM1
- 0x060_0000_0000 - 0x06F_FFFF_FFFF HBM2
- 0x070_0000_0000 - 0x07F_FFFF_FFFF HBM3
- 0x080_0000_0000 - 0x0BF_FFFF_FFFF PCIe region 2
- 0x0C0_0000_0000 - 0x0FF_FFFF_FFFF DDR controller 0 region 2

The old static normal-memory mapping spans PCIe, while DDR coverage is
already populated later from the DRAM banks discovered by mem_map_fill().
Drop the stale static mapping so the MMU table matches the Versal address
map. Also matting was using wrong attributes.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/mach-versal/cpu.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-versal/cpu.c b/arch/arm/mach-versal/cpu.c
index 960f97754dba..76cf3181e28c 100644
--- a/arch/arm/mach-versal/cpu.c
+++ b/arch/arm/mach-versal/cpu.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * (C) Copyright 2016 - 2018 Xilinx, Inc.
+ * (C) Copyright 2026, Advanced Micro Devices, Inc.
+ *
  * Michal Simek <michal.simek@amd.com>
  */
 
@@ -18,7 +20,7 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-#define VERSAL_MEM_MAP_USED	5
+#define VERSAL_MEM_MAP_USED	3
 
 #define DRAM_BANKS CONFIG_NR_DRAM_BANKS
 
@@ -46,26 +48,13 @@ static struct mm_region versal_mem_map[VERSAL_MEM_MAP_MAX] = {
 		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
 			 PTE_BLOCK_NON_SHARE |
 			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
+	}, { /* FPD_AXI_PL_high */
 		.virt = 0x400000000UL,
 		.phys = 0x400000000UL,
 		.size = 0x200000000UL,
 		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
 			 PTE_BLOCK_NON_SHARE |
 			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		.virt = 0x600000000UL,
-		.phys = 0x600000000UL,
-		.size = 0x800000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
-			 PTE_BLOCK_INNER_SHARE
-	}, {
-		.virt = 0xe00000000UL,
-		.phys = 0xe00000000UL,
-		.size = 0xf200000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
 	}
 };
 
-- 
2.43.0

base-commit: 19d429b48dc3eaea37494e69313d58ba1c1da24e
branch: debian-sent3
