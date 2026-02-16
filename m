Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB16DE7BD83
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 10:28:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 439AD8063E;
	Mon, 16 Feb 2026 11:28:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TItTtyZ1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D47088063E; Mon, 16 Feb 2026 11:28:06 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D330183D5D
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 11:28:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JWktyr9WgdQ6lty5Py3peRGeao/6DlqK6HjEn8RbOru1Ai+pcrwZYniQvxoEOiaVwCyHyJ83vWAi2IduJQCdoyTYJAs5MR4r0rY4r5beq/KbxxAamwMCJadEfOvqyHcH+yCUt3sQYBpue5UXRJDlzgxOraLHNGfA2ONznqNeQ0XIyfz/HA/CiSKlU4PGCmxblc2Mke6gMSWpd/YLoU8Us2z6TTP5HXi0cQZD32zR4Ak8a4nCG7zASTJlngK8Aryoy4oNACYcMCDK737O8K7/V4uhXCJy3FafoVQhylh2GIp4LmBo4u/EIuWsu5hW7Xnut3/TKcqQ1vXdXWod2h4pYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZymqZC4UfP6HJtiI3/hGRHSCbCm2m5rX6rLJO6R1+g=;
 b=q36kO0ZS2R1jjbj3F751vu1/oWQqR/GF1go4Om8+vcl0ggGQS6ZnrfvPlGzLys1Y3s2o9giD1szVhNCmVSDVhWwbhSyIG4cuuXd69ppDmcBnDSMv2aqnwJFseGRoJOS37XvLD44Z3GKu73OcLrLqz7NcK6iR/mb1OBc6gh+Ag5OFshct8qZOdRnLy+N1eqTfXRBEhwwsSf09jKmpKGOZ7gL9PEqOHxmaiTIOI5bSVxrR9kRud2x+Ql3L27aoJr+gmffrEL9Kgkch4fvVAdYztBCD0Mkdbu9AEx0O0VeFWn4pB4mMlx6vkczkvljsS5cHT1FJbhPh9yljfXZ5NzhW/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZymqZC4UfP6HJtiI3/hGRHSCbCm2m5rX6rLJO6R1+g=;
 b=TItTtyZ1a1htneRV5BUEsDT4E9ows2B0ULUcATNzXrkQKo2TPe9i36Bjjpg6PNLAYyiwKqHg4PJy3+SG/KapCOlOIslJ1WL9RLMsfBM1jQptBDnJ2KSNliEbEZpd97dAuI+bGx2J1ZMCJnfMwBlPI/9QyYDVSF93sW1SEkrbz78=
Received: from SJ0PR03CA0274.namprd03.prod.outlook.com (2603:10b6:a03:39e::9)
 by DS0PR10MB7509.namprd10.prod.outlook.com (2603:10b6:8:162::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 10:28:01 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::8b) by SJ0PR03CA0274.outlook.office365.com
 (2603:10b6:a03:39e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 10:27:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 10:28:01 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Feb
 2026 04:27:59 -0600
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Feb
 2026 04:27:59 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 16 Feb 2026 04:27:59 -0600
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61GARUHe1147835;
 Mon, 16 Feb 2026 04:27:54 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <m-chawdhry@ti.com>, <c-vankar@ti.com>,
 <neil.armstrong@linaro.org>, <marek.vasut+renesas@mailbox.org>,
 <u-kumar1@ti.com>, <j-keerthy@ti.com>, <semen.protsenko@linaro.org>,
 <afd@ti.com>, <anshuld@ti.com>, <peng.fan@nxp.com>, <ahalaney@redhat.com>,
 <mkorpershoek@kernel.org>, <n-francis@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v5 05/10] configs: j784s4_evm_a72_defconfig: Enable configs
 for PCIe boot
Date: Mon, 16 Feb 2026 15:58:33 +0530
Message-ID: <20260216102858.2745657-6-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260216102858.2745657-1-s-vadapalli@ti.com>
References: <20260216102858.2745657-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|DS0PR10MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: d731d241-5468-4aef-7d46-08de6d460fb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nuwDbOZ8NcluRP8u8pfDzlM1PhYheJNZAeqgOS10HppdM/IgEBhcNSI4ouMo?=
 =?us-ascii?Q?IFr4OyoLzDNwwWyBtL8YMQq+CP32C7HeIerYJW5YFd7a2JOcinqLvtqcUYX4?=
 =?us-ascii?Q?rKzRp6IPMKKhiw6/9r1TShMqEB3gyo/nFSg0m/Kidl8SGx5XucSl6b4xlKsI?=
 =?us-ascii?Q?rm+bedGSuZwWaX+B049ie71Sl++xUHNeSGmuX0KZQH8ZfuAO6anjxzflyyv6?=
 =?us-ascii?Q?cMyxlMM7NGA3ilwpYKhGYGYd8noctuOa89pp3u0AYHOQYeD+VTLne+TNCksj?=
 =?us-ascii?Q?bZbnNwWO6e93H4oaEcSUWcFJ3mxTMjTCQidXXgYveEtvjTtMwRZAGrBm04Cx?=
 =?us-ascii?Q?wmrFyWWxbA11JHEFfFIEfntgZrUBejd+V4VusXd5vOL0f8/96MPZCXyCQyUX?=
 =?us-ascii?Q?2eMDir/9hbNyYfxZ5vsXTHlVjZAKJdXKvAY2U03CwfPBEynaWIsdb8S/U2fB?=
 =?us-ascii?Q?fs1+eNE8viK+k+tCvpA+j+/6x3TznKl9ALjaFNxODM6MljUbRgV5242am0yZ?=
 =?us-ascii?Q?orY3gdH/vOibHGRRNY4bbFg+2VIfC43rczC+qimrSSqkrR6txKSImiB1scnI?=
 =?us-ascii?Q?n1GjWT/MU8e1bDyG7FjJwa9HVxxhIM13NfP5iyQKmYPv+0GlXbJ2bYXzUkHy?=
 =?us-ascii?Q?jMptxiQbyvjbm1R62c8BUSTfIaIkWOCua4nF2IaHWYyDd3usE6+UYXOwuYrI?=
 =?us-ascii?Q?Kkz/sQBp6WbSs6f/G0WUwjX9hlvyHU45zO+bOJxDuPBoeEeKyUxgfX9YckVF?=
 =?us-ascii?Q?LNotKNhCmcEN4FO87jFuGv9xqmBtMhKgAHA3bPpfjl+9iJr00OJ8UtVs0o6g?=
 =?us-ascii?Q?fk4jGyyZfGrHKCaujMckSjawtHr3tWkv62P5nYRtymqt5XBTLXXxxt6Dnffx?=
 =?us-ascii?Q?Fej0JsKN57xRjuy1B2ZmmiWFAyiQyxnBjQaAvSXNNguNcVPFd+REZ2KEjWZR?=
 =?us-ascii?Q?2SHZplAfwGVxLWTgEI3/YrmNh1WVrqmY68H6EQTGypW5F0ZFx1BP9B3RxRl9?=
 =?us-ascii?Q?/cNw7M2lkurJ5uPNIsrYz39hZTXRgA08tnfX0t18hnFSs6ojEldqysmuuAsY?=
 =?us-ascii?Q?pipNqxK3EbKXFAnJkAW6rS3Q7NxGCjUe9/iDy2QsMHhGxgeg64WhxHEucpkb?=
 =?us-ascii?Q?f7pPeAcA/O/6daBKGYyy84twbLEcGyWjAsbopawRMgwkWymxzVlEhyFrdZTP?=
 =?us-ascii?Q?eb2dxO0/qJEekV07KPDImh9t/T5nUoe7YEotgHii3mswr3nhPJXsMdhMhYsf?=
 =?us-ascii?Q?N+a9vUpHaWtTK3QbiT/Mri7nuLayOWm8AWLLgtGAiJw3sUE/ybTfgP809HCH?=
 =?us-ascii?Q?NWZNxk7aXqvNvEwwWy2Ixyojl/m5HTDY4YZmeNvc4UAHup1Y7skRA/O3PSvB?=
 =?us-ascii?Q?uEk1ESMxOCDyLrjoiNx1Nd3Jek0p0zrM2/fsjkAzI1m9aY12ZgZPG3ag+1wG?=
 =?us-ascii?Q?yP7ag8hS6lKxm0CFz4Lo8HFwPIB/BfjJ5npfI2LIch8xfuxlHEe9iEklhIQX?=
 =?us-ascii?Q?iQxKbQ/dKVexmWSP5/LuZ3qN5Rx5SKVXM6DoDfKB/85qAp2kkzr9W6gPztSb?=
 =?us-ascii?Q?eC2w+OGaeqzr+A4m7T/213e4FCEfDrsT+GYouLn/QT13E2XhdYc87hJTnwRj?=
 =?us-ascii?Q?c0InAq7mMQe1NLARN7KA5cca+dadmORNkgyblh8BbGoBJSVZXhR65iqfc2cx?=
 =?us-ascii?Q?AWOmiw=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kuiiXoHumMD1fjNBPAT83at+DQHA+CAPwIQ6k4mbGkKPKAFKaxv/wPbcqBjGJ9+9OBCIL7AWpShFCaTDPY2YWPS8yhbEMS0V6WjY/hSz7CgRzkbcCw46AL78A6Kl/sHHWtkYRcCElqtXPE2B0Ci92mk5t5qdMqPNlGMJd6FZCdrHnDpCloy/BH4nOdTSoMcdxQlfFm6CetmOQ0P2kP1wAFgyuJ3p43zQ7cyHlCf887We3gYZ7o5KyeVsJ00c/VDRlX7lERxEyVOgKzPZXUhkkdeDXgjfZEQ0ysgpCcphnr37oUY3pUFTRR2fVFrFGGG76FT/2eqmamoGxOcVRteSRyt4rfhoxgKaoO/wJes2R+2T7Gn+Zjs++uAWSVtZYp8zJCgNBMLArwA19FhmelQlhlIbDwHbL/58KWFaNtvx1+f2XJQAIbm0d79IuSfa+fRI
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 10:28:01.0347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d731d241-5468-4aef-7d46-08de6d460fb1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7509
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

From: Hrushikesh Salunke <h-salunke@ti.com>

J784S4 SoC has two instances of PCIe, namely PCIe0 and PCIe1. The
PCIe1 instance is used for PCIe endpoint boot. Enable the configs
required for PCIe boot on the J784S4 platform.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 configs/j784s4_evm_a72_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configs/j784s4_evm_a72_defconfig b/configs/j784s4_evm_a72_defconfig
index f440b18c6fc..7ca5e88276e 100644
--- a/configs/j784s4_evm_a72_defconfig
+++ b/configs/j784s4_evm_a72_defconfig
@@ -44,9 +44,16 @@ CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
 CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_MAILBOX=y
 CONFIG_SPL_DM_SPI_FLASH=y
+CONFIG_SPL_PCI_ENDPOINT=y
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_RAM_DEVICE=y
+CONFIG_SPL_PCI_DFU=y
+CONFIG_SPL_PCI_DFU_SPL_LOAD_FIT_ADDRESS=0x81000000
+CONFIG_SPL_PCI_DFU_BAR_SIZE=0x400000
+CONFIG_SPL_PCI_DFU_VENDOR_ID=0x104c
+CONFIG_SPL_PCI_DFU_DEVICE_ID=0xb012
+CONFIG_SPL_PCI_DFU_BOOT_PHASE="tispl.bin"
 # CONFIG_SPL_SPI_FLASH_TINY is not set
 CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
-- 
2.51.1

