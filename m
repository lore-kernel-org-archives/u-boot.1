Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F00CFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 11:03:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C364E844F6;
	Fri, 28 Nov 2025 12:02:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OtRlTczG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEE5A844F6; Fri, 28 Nov 2025 12:02:57 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FE52844DE
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 12:02:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-bhagat@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iaRpWiMXtd/L48ZbGctmAAary4Ri5ojIXCtJfx6Ed3H6gTktHchUwfyq4HCztImjP8aIR6b8qCJnODVnm3QnpsmJfNh/cO8QqkVdFI/70kAqcdhtBo0j3alO4llvbng7tRHMB8EYorw41VmwRzj6IjXD10A3S8PT3wjTH56uT95Q5yHHxxJyJiHa7nHMNUVBF9H+6NhjGwCR3wQ/xo0LPUVQvNKymB1Kios0pH+wKC/pCNuBHwQ3ajAd4mQwiwTvfyhybgp7TzhudjirJY+zcUKub7esQ50fygG6DUTr1yfNzPJgp6Htoc/YWAC3guVl73uU4UVUasw7xnMt+sW3UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aY0VVYM3g4JGf2Z/Y9sNn3PbV20Qs31LMETMSNQUsO0=;
 b=NMweGpWvgdUksMPgMPQVoQ+d2pR4t4WC9Z0Cwf9fFG1kk5N5hHna+kRjMDQRnhQzy+BXKQf4wu8fofaMhV2b89pt280bgBZ1Pon46zTiTqJlWqKaJhj2bbuFqWmymKDbl4Kivve88DIkzHkQO4tdAMfOSOkxZCwMbDCtfs6OZEVJwVUAmxcfHSkZZe1PuO7LyJdYM9irC8harqeOcTWkyxkXWD02J14Sdpslww41BwLiAj7U969M+N5o9Tzrih9mLuI1OLAz25u31XQmCNDXDe7pGy1a1xFeYgB0xokMn3xXfk6N2C8AZ9PV6avtOIkZkPdcGJKwU4EwcjG0P5PH3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aY0VVYM3g4JGf2Z/Y9sNn3PbV20Qs31LMETMSNQUsO0=;
 b=OtRlTczGldbf2+DvhM6FAVCnZ1W/LGfOYsum2ERv+xJ1lPtL5fojOMJrMMOZepIn/7TU0Kxiht7ElX8BWOCPibSLDGmA6hYbkNidKyIa0yiAO9wHD1/Xy3jtj0sQklAlDG8tlVzetf0Q7SKpbF51fiQUezGePkP9+9Cv/2uo3hE=
Received: from BN9PR03CA0854.namprd03.prod.outlook.com (2603:10b6:408:13d::19)
 by SJ0PR10MB4749.namprd10.prod.outlook.com (2603:10b6:a03:2da::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Fri, 28 Nov
 2025 11:02:51 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:408:13d:cafe::90) by BN9PR03CA0854.outlook.office365.com
 (2603:10b6:408:13d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Fri,
 28 Nov 2025 11:02:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 28 Nov 2025 11:02:49 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 28 Nov
 2025 05:02:46 -0600
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 28 Nov
 2025 05:02:45 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 28 Nov 2025 05:02:45 -0600
Received: from localhost (ula0502350.dhcp.ti.com [172.24.233.249])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ASB2ifs229575;
 Fri, 28 Nov 2025 05:02:45 -0600
From: Paresh Bhagat <p-bhagat@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <v-singh1@ti.com>, <khasim@ti.com>, 
 <afd@ti.com>, <anshuld@ti.com>
Subject: [PATCH] arm: dts: k3-am62d-evm-binman: Update DM
Date: Fri, 28 Nov 2025 16:32:10 +0530
Message-ID: <20251128110210.4143342-1-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|SJ0PR10MB4749:EE_
X-MS-Office365-Filtering-Correlation-Id: b9ced201-030d-4953-4336-08de2e6dab7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Do0b0vyh0+5nR9umAmqrmmHwumnYhaxUWs9657QyrtlOscC8IVLK5/Pv7cbB?=
 =?us-ascii?Q?7iDDi0Hu6w4QgsGoszD8idNtg63Env9FgOC9u3vxfq4Z8voyl7Xu/pJazmTs?=
 =?us-ascii?Q?bLwZ1/eXk+SYlFMQnJyqDJnxG2T3shvtnw5GVl4dN02onmhLqP9BDd80JWQ+?=
 =?us-ascii?Q?Qu2PZRkV4aFbT/CycxS6DUU/meZQJ57+Fr++BwNoaVEQMe4okn+/bz8M7tDR?=
 =?us-ascii?Q?UV+7DOzZNhbhkXAtiDKhPIo3CVA4v2rULvsqeUWyMk/gD9FYZqHV6PpIKM5s?=
 =?us-ascii?Q?DwTx0vhmPUV1O7NE8OXVPKO+o7U+8R3BZZCXF1wz0lFMgbzzkEypZPQjjFa3?=
 =?us-ascii?Q?ByVIkHPBi/ObHX+Lj42Zyg0UCwroUTK+ZO8h5zBVyWOXwqPkKYgjeySgytjO?=
 =?us-ascii?Q?GMrhX0cp0nn9LOF3tdoKcM2Lduw7ivkJgdfrYc601dUg1Y9Kguk0XhlxVBzF?=
 =?us-ascii?Q?A7kfEpqNuCjhzayr9QSmTb9ezSboSgb6EeSZZ+ETYl2xUY9GwFWDcHwMDYDT?=
 =?us-ascii?Q?a5wLOuiXZ0dEBcFYBL4zsn2BvidPONr+/6HmIUCkTkm7rlTzejG9nRNScfLF?=
 =?us-ascii?Q?6cYtqYal1PETb09ReRxnJBu2jTHCiOSmL6eFxy4Us/sW4A2beYSSBy+atIH7?=
 =?us-ascii?Q?cDoLCy+8vKMofyuXGJvpE51OZhDjLVTm2tbZQ4bEsD3hE81VVoCuL8SPlY0Z?=
 =?us-ascii?Q?wLbf0X+d+htPLXMhVcfiSqJCmWm7BnaSBV0muVy4NGNkiuwU2XGXy4oWb4RU?=
 =?us-ascii?Q?MduQ2QZzeK1rLBYESFWZGCWtB3BgEWRVPkj+fBEXFPWkdgon7EE6Ioasl8/V?=
 =?us-ascii?Q?Ev0n5BbjYHCbo0Zw+do/TNe/xN1yOCTLSdUzVrgE6IrwGPMCP32qpsI7Vq08?=
 =?us-ascii?Q?jJMAO3GbJTwpTJwgYuNqMfliIMptf80tnXtQrPRhczpcA9mxrdO7XzFu7k3x?=
 =?us-ascii?Q?PwusuyJwZ7oH1Uc8KVEp1u9PK64IPNWcQuW6nSxwByUYDpEKyIhdi+kocFxY?=
 =?us-ascii?Q?5ZUBwSUTKKFxkk2pvzJEVj7jE0cfsczkCLmube8cXzp1Wf+j9IlUptrPzqES?=
 =?us-ascii?Q?X9qkCJ5JkCE+eD2ftfiEEVbDG5F52oCE0LHSpG6eN7DSpYcTDGly3MSFayRW?=
 =?us-ascii?Q?hmpVN/tuOgQGUmM4UjbhkliixsSN5cOzcYoTxFzT+ioYViTtk6t55qY2hO8A?=
 =?us-ascii?Q?mfWkdDnFMiESWkVE0kIcIvrMv3BG9zT/v2j2TpAqRoPnhG7gxW1heINMAswg?=
 =?us-ascii?Q?4unw5Kn7NT7XTNzqnbO81L3QmGzzoHZPWgWNif9/DK9jKOh/dgmz9xPz/RIN?=
 =?us-ascii?Q?ltFao+TbgBklxEdsoBMvIN+TuYHlXmI7nxtvob2LYNoBe7Z+G2+In7VobLJ6?=
 =?us-ascii?Q?Lx9XrN2cVq1UbQcXYkgERxmr4qEXM7PI2RWA15Moy8e+p6qvFgEHxALZ4bKn?=
 =?us-ascii?Q?cCLJviho9Ek4lwI78Y5bMrJHDW6QCWtyVPy/j5M7b3yX2vnBN1BKCahRrnWz?=
 =?us-ascii?Q?xGD4FxNFUBRiBj3MDbCOt4eZO71jTXB2h6ybZLWo3xriGwL3D7wFC0z9N4lD?=
 =?us-ascii?Q?NtrnZXlfsTJocG/toig=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 11:02:49.5931 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ced201-030d-4953-4336-08de2e6dab7e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4749
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

AM62d previously reused the AM62a DM. Since a dedicated DM is now
available, migrate to device specific DM.

Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
---
Boot logs
https://gist.github.com/paresh-bhagat12/38bce75c43466b5074271f4cb2ddc3f3

 arch/arm/dts/k3-am62d-evm-binman.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/dts/k3-am62d-evm-binman.dtsi b/arch/arm/dts/k3-am62d-evm-binman.dtsi
index 7bf0e955645..3a0ab9f8b2b 100644
--- a/arch/arm/dts/k3-am62d-evm-binman.dtsi
+++ b/arch/arm/dts/k3-am62d-evm-binman.dtsi
@@ -101,4 +101,12 @@
 	description = "k3-am62d2-evm";
 };
 
+&dm_falcon {
+	filename = "ti-dm/am62dxx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+};
+
+&dm {
+	filename = "ti-dm/am62dxx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+};
+
 #endif
-- 
2.34.1

