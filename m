Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0268C19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 09:18:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F247809A5;
	Fri, 28 Feb 2025 10:17:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D6jfLI+r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE420809A5; Fri, 28 Feb 2025 10:17:56 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::60f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29250807D7
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 10:17:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Prasad.Kummari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vUDlHkfHXbpRS94AWcIwNOilmHJ2kVxGJWpZRkboJkKTtjdRZvSCNLwWJTQXIHUOf/vaqTY7TctllgTQwQ85r4ZgiIK3meMj3OjXzs3PPi0g7pVquhWrX2IVrEW4Tj2PsAhN5zUefV01pzcatFDJtBVJJHKrxRGUz/fisUP4Go9N6RusoMqkccVKDogn+RNRwNsObeee/VBCLRMWEUrfjKWe1mRwimzAcM/yEZxqULo2n9gGjoLJQCuZTMsQiGTvuLKBZJSI1TjaYRDDebTDV31ZcGyBdNXzu/j/qvyveaSwSH+64i1DgK9nrxL/LpPSb4K1lZGqPd58uVftcI63qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cP2cAJfMlWY1bCBRtZTNYJ3rHWVeEChfD2ClYooChHs=;
 b=Cbo/gbSxEQs5MHHBE1N36jXCmcMWz0Yy5UqxCucZnKFxMpzYRi0h5UE4Ppp/kgsGPfUqwHwYPKKP2+a2g1g2zPZNnO9eni+fZpQKEjgFGWsEiS8dJ6/YZhD5CARZMhH+YzVbl4NQLmc5UJc4yIogJm31tjcnGpPoZ1lS0QNLpWgDXznSyu51KLQruZ2fP/vb0rErqkKoy110BaK1sd3MTRdYy3Onnw2wXvg0hqaNpCTOF+lASu8lQZpQWj6PzbwmIZknkHN4v9nyqMIZpuWlf8lSfU3bLigo00HERCCP7k7NhTLRm9m77ynmnJKSo6bZG19ErqsqmHiSbObR6qdYlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cP2cAJfMlWY1bCBRtZTNYJ3rHWVeEChfD2ClYooChHs=;
 b=D6jfLI+rwA+XAgyXYRuA81TeZO02mzxJv6nXi8ZvkNDvw9w2JkbvhGY1L+cZW82gqwuX61us/Az/AImvGMDFRMNyDgFxdSR9tlHclEgX2uDs2pP3Xe33KmExXEtlWmjB/xe/Fd8YjB52OJGC5XWtJQhFpsUWYXOsaWptmXNSuwA=
Received: from CH0PR03CA0231.namprd03.prod.outlook.com (2603:10b6:610:e7::26)
 by SN7PR12MB7132.namprd12.prod.outlook.com (2603:10b6:806:2a4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Fri, 28 Feb
 2025 09:17:49 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::80) by CH0PR03CA0231.outlook.office365.com
 (2603:10b6:610:e7::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.23 via Frontend Transport; Fri,
 28 Feb 2025 09:17:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 09:17:49 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 03:17:47 -0600
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 28 Feb 2025 03:17:44 -0600
From: Prasad Kummari <prasad.kummari@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <padmarao.begari@amd.com>, <git@xilinx.com>, <jagan@amarulasolutions.com>,
 <n-francis@ti.com>, <d-gole@ti.com>, Prasad Kummari <prasad.kummari@amd.com>
Subject: [PATCH] Revert "mtd: spi-nor: Remove recently added SST special case"
Date: Fri, 28 Feb 2025 14:47:24 +0530
Message-ID: <20250228091723.1732878-1-prasad.kummari@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: prasad.kummari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|SN7PR12MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dc3afb4-bbdd-4fe5-a38d-08dd57d8c573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TlRqdHRkK3h5QUtaWTRqWlpENTZ6L3N1dzk5QkQ3d2p1Q3lsbHduUW1oMkpu?=
 =?utf-8?B?Ny9NZnducGhCMHU4aVprUUhYQmdDVTJkSkZrOXIrMGQzb1U2R05kdmY1VHJ1?=
 =?utf-8?B?T2xwWW8rbGEvMzdhdnNQMlJxM1hyRWx5ZU9XZDhPMzBXM1RtcU9qUHNnWE1t?=
 =?utf-8?B?QUQ5RUROWUxZZ1UwTjY2RTB3TC9Dc1VINmVWeXRqMlhieUIrT1VkZk4vOXBo?=
 =?utf-8?B?ZFNUZ1pHYVRlVmpxMXZTQ3Zwd0FTMjFlbFZwb0hHR2NiVkNSVWtCUzJ4eEhH?=
 =?utf-8?B?bjd1ZDNDRGpIeWt2bWo3ZmQrQzJzUGRtOVMvVXpsLzdibkFJSExGWTZ5K2lF?=
 =?utf-8?B?S0NZajFjYnhxTTZPdHRRM0VBOXNLV0lPdll6VDZINVd3bHlsK09KNk9JV2ti?=
 =?utf-8?B?ajliZ2ZIS2ZnTngrWUpUMHI0NEJ6SnRmR0pad0JQQXJTeThHODBTZUZWME9U?=
 =?utf-8?B?NEpOWXAxRnhIeGRqMVUyN1hmRmczWU1Yb1hWK3V3VTNHa0daSUNvYklnTWhD?=
 =?utf-8?B?NXpsZ09DTHhRcTNqMXV0M3Nsc04zNFBKQzk5bVV2Z3BaUEJwM2swWXZZRC96?=
 =?utf-8?B?bkZYNVlRU21kYXJYc1M4SE5MQ01kb1NhRzI3eldIbnh0N2NuSno4UUh4NEpx?=
 =?utf-8?B?UzMyd3RXUTl2WmV6Sy80ckZHSWlnVEN2MW5DOHFKMTdLbE1BZkYxa1R0R2Uw?=
 =?utf-8?B?eENqYXM3MXpkMEV2WlE2WjQxK25TMXJHTDJOSmlma2p3a09tN3dJNTk5bXRZ?=
 =?utf-8?B?MWxFeWNqQXhlUzBnanIvc0h5SFRqOExOZFluU2FnVzRDVWd5TElpQ0gwUmZJ?=
 =?utf-8?B?MEw3SkVDVklBOVZUNzFOSWxGb3VCbG10L3h0QllSSjdlNjY2aFBnbTJib0FP?=
 =?utf-8?B?cENFaTNZbEdFZzdud2NJQngxMU1IZnRCTTk5SitvVTF3ZVZtTnYzUDE5MGx1?=
 =?utf-8?B?dmhqWjlLN1ljbWl2aGwxWnJhcUd0aVZXYldzUnZRU3lubzVkUndObk0zSUlq?=
 =?utf-8?B?bGJsWGx6aDJlTmRBVEl6TzJFTk1uK1RwQnBOWUpYWmdFV2J4NFptVjREbkVi?=
 =?utf-8?B?SWNsQk9USjVsdWNkZVVoTkxNRFZsWVFoZEhPVEM3TTZIeHBwU1Y4VG9RUE1w?=
 =?utf-8?B?YkgrQ1Q3V2lhc1k3a0pHQy9YZGFDcXpHeWREWWtYaThkbmpHUldRZ05SQjEw?=
 =?utf-8?B?bTAxUVVCSUtjOXFmUENIT3JicVdEWFpnUW4vdXRHeHJ2ekZiN2RHRm5VRWNu?=
 =?utf-8?B?VFJHQVlyRlpPS0ZMalZmb25MVFptbE9FeS9FTXBWVys3bDZRRVZGTkk4MC9v?=
 =?utf-8?B?UEpjTmtQSTBnQTZnRzVHMmwyaGVrbzVFMmhaTklBSUsrV3dZN0VJakFySnpS?=
 =?utf-8?B?S0NXV0J1dlU1eXhTVHdIK3pzVm10VlAzc21VVktuc25yUzdqT1p5aGxDZmpm?=
 =?utf-8?B?MnVDVHN1TTIzeGlUZnlNYWR6cHZDVXBaaFd6N3hTZHpNWVlKd2FSeXh3TXRl?=
 =?utf-8?B?TUU4aTBtSGcydjNZOVkvdkhNeUQ4bk5YWWx1T1IybWgxcEJ1NnZHZlVLWU1r?=
 =?utf-8?B?VHJXVlM5RldGV010SmZNQjBqa2YzUU01cXNvVzdTek56Y3JaU2Ezc05QSXpJ?=
 =?utf-8?B?T3A1ZTQrWklieDNIUm1WdWMwWW5hMXZZZjhPWUhmU1NINWlwSThlc0pmMjNW?=
 =?utf-8?B?ci9vRzN2bkFXWmtIZ0lkQVlic3FURk9Za3dUdzhGQjNnZmpWZXNCSzIzbm1o?=
 =?utf-8?B?U0tLbS9aN3Y4c29CampGNlZBdDlCQllOQ0Q5SmVobTh3OUV3SS95UWtrdnpi?=
 =?utf-8?B?K0VGRE9HNzk1aS9pb0d0NXFDdENRVmpPcmQ1aVFJMnViU1U1WEtIYXk3OWJH?=
 =?utf-8?B?Q0RtaC9hc1Q3eGFYQTlvWW9RbU5DdXdsYW5LNllPUUVDSUdJajVEaWtnTDFP?=
 =?utf-8?Q?Nvsk19w4CuQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 09:17:49.2939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc3afb4-bbdd-4fe5-a38d-08dd57d8c573
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7132
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

SST(sst26wf016) flashes have multiple erase block sizes, including
8 KB, 32 KB, and 64 KB. Since a 64 KB sector erase cannot be performed
on all blocks, the 4 KB sector erase command should be used instead.
Enabling the SPI_FLASH_USE_4K_SECTORS configuration allows the use of
4 KB sector erases, but it may increase the erase operation time for large
memory flashes.

This reverts commit 34cd4a72fb2d113e2754c0d643618a8e3fa549ab

MEMORY ORGANIZATION:
The SST26WF016B/016BA SQI memory array is organized
in uniform, 4 KByte erasable sectors with the following
erasable blocks: eight 8 KByte parameter, two
32 KByte overlay, and thirty 64 KByte overlay blocks.
See Figure 3-1.

Top of Memory Block
┌──────────┐
│  8 KByte │
├──────────┤
│  8 KByte │
├──────────┤
│  8 KByte │
├──────────┤
│  8 KByte │
├──────────┤
│ 32 KByte │
├──────────┤
│ 64 KByte │
├──────────┤
│ 64 KByte │
├──────────┤
│ 64 KByte │
├──────────┤
│ 32 KByte │
├──────────┤
│  8 KByte │
├──────────┤
│  8 KByte │
├──────────┤
│  8 KByte │
├──────────┤
│  8 KByte │
└──────────┘
Bottom of Memory Block

      ┌────────────────────────────────┐
      │            64 KByte            │
      ├────────────────────────────────┤
      │            64 KByte            │
      └────────────────────────────────┘

      Expanded View:
      ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐
      │ 4 KB │ │ 4 KB │ │ 4 KB │ │ 4 KB │
      ├──────┤ ├──────┤ ├──────┤ ├──────┤
      │  . .  .  (continues) . .  .   │
      └──────┘ └──────┘ └──────┘ └──────┘

2 Sectors for 8 KByte blocks
8 Sectors for 32 KByte blocks
16 Sectors for 64 KByte blocks

data sheet:
chrome-extension://efaidnbmnnnibpcajpcglclefindmkaj/https://ww1.microchip.com/downloads/en/DeviceDoc/20005013D.pdf

Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
---
 drivers/mtd/spi/spi-nor-core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 6f352c5c0e2..43ca2e9d97b 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -3592,6 +3592,19 @@ static int spi_nor_select_erase(struct spi_nor *nor,
 			mtd->erasesize = info->sector_size;
 	}
 
+	if ((JEDEC_MFR(info) == SNOR_MFR_SST) && info->flags & SECT_4K) {
+		nor->erase_opcode = SPINOR_OP_BE_4K;
+		/*
+		 * In parallel-memories the erase operation is
+		 * performed on both the flashes simultaneously
+		 * so, double the erasesize.
+		 */
+		if (nor->flags & SNOR_F_HAS_PARALLEL)
+			mtd->erasesize = 4096 * 2;
+		else
+			mtd->erasesize = 4096;
+	}
+
 	return 0;
 }
 
-- 
2.25.1

