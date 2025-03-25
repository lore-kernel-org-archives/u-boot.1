Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C346C35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 03:59:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D608819FC;
	Tue, 25 Mar 2025 04:58:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Sumwll7q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0D7881DB4; Tue, 25 Mar 2025 04:58:40 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on2070d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::70d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EAC081951
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 04:58:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9Y7KNviW1aWXTPU0jIGlRPFnWQwIqUrJLSu6Eghh2M+ckfXqg8GJDrl8IMWqnPxWT9Ywbk2mkuwhTwbPvwo/Pet4wGEYD7ffO1gpW7WbvgFLknU3t9Fssh0Pml4F1tPQQy0VJY72UMbN688qW0n1f0866oqxDQbr9WQKjCw6VXf31uTQMb/SDBs01NcyWfiPhoUOXPyEozgeyqw32dm/PjF5FsQyYAyDB+ASKkdzGVEoVxTFR+vZuTsn57evrZYS1dvegGwF90h92EAYOLWTiI+qc8VENEmwiR0YVRNEE3L74R8LLEDK87wd3vzItLMMFuXCuDrSqWZaJudrDgwkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnOl1oKkcxj3HxrhAg0tKnesCMVQu7vErMGD0znwxMo=;
 b=CVxU51/d0q2bKiJXzzJ62zWWP2eqbCXdDunY4livaL4/cJ8xDS00gmFYn/pi98ijoViKeZD6P8t/Z3ja1KprPgJMlTljmhXRGWDWLZDXSwLUe/Ey1JEig5zmXGf0XEh1TMicCQ1REtQaKrAAqpZzsjkYkzVSLGde5vQLI9sUxdHa+DTPnZIfBGLlAen8/d4I5hVsggQToh6IRf2YuSxmJix2BDCTfCuqp6w7HzOY8a6rv6dETcaLXoxsxLe3f1Rzj3zhUEimR/NiFWeYJJNugqjGY8lUZJ1n5W1gqdQCp4VI/L6/Qn7CdXUSYVvGnjafblTGA/y1+HRB/EBQU5hM1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnOl1oKkcxj3HxrhAg0tKnesCMVQu7vErMGD0znwxMo=;
 b=Sumwll7qlzBtPQCJQVjaBOBfLidwHBotpERMZgwjQxN+W9JxlPKSl6dxLAXMhPsvOui6Atc/udv1hYEG6op8UAGDOhnNM4lg7fjp9h2RFn0yONiaRVtM3eM/YBuEmgFy7imlKBnZM97Ay71tkH42TD11DdqhzHNig8BMBX/pGW47q5HnLlpyZFaU8SJvMeRqFZoG34StdD5SwEgHELnI/eiHioW5eFu7zQ+9Ibx7YSABRvEnrJKXrnpJkdyLN5a7+xz1YKJQejW4/xPCHw0TT0m3/NdzPJP0u+cuzwuCU4jZ5mVz0oTPBODkQBNZazWvr4klXAG3t0M4gRNU1qSqzQ==
Received: from DU6P191CA0003.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::29)
 by AM9P195MB1045.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1f4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 03:58:34 +0000
Received: from DB5PEPF00014B9B.eurprd02.prod.outlook.com
 (2603:10a6:10:540:cafe::5f) by DU6P191CA0003.outlook.office365.com
 (2603:10a6:10:540::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 03:58:34 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB5PEPF00014B9B.mail.protection.outlook.com (10.167.8.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 25 Mar 2025 03:58:34 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 25 Mar
 2025 04:58:32 +0100
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 25 Mar
 2025 04:58:32 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <ggiordano@phytec.com>, <d.schultz@phytec.de>,
 <afd@ti.com>, <n-francis@ti.com>, <nmorrisson@phytec.com>, <vigneshr@ti.com>, 
 <s-k6@ti.com>, <dannenberg@ti.com>, <bb@ti.com>
Subject: [PATCH 3/8] configs: phycore_am62x_a53_defconfig: Update for ethernet
 boot
Date: Tue, 25 Mar 2025 04:58:19 +0100
Message-ID: <20250325035824.2304200-4-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250325035824.2304200-1-w.egorov@phytec.de>
References: <20250325035824.2304200-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9B:EE_|AM9P195MB1045:EE_
X-MS-Office365-Filtering-Correlation-Id: 69caf1b9-7b0a-49d5-25da-08dd6b515082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gPs8eAEWzgq/OVqs/C8vlN/ee70tpCSr+iGZpFJ48q4WBXvBBuIQjXfDYzsn?=
 =?us-ascii?Q?4zSez7uHx6DRytH9fWAc61PnaNSKTg8JwjEmDggNPraTQQgo/NsH43uVLZzs?=
 =?us-ascii?Q?gF8AchnEkIO2vZLfI60wqrnYDGljM3N/0wIvU3x4ihnjSyflSfOJaYGzL+pG?=
 =?us-ascii?Q?fe1DC7aKc7igrRJrZ8871Jb9sTglRtM1qVy/2vpEml+u4EB0yCcWgje1bbh/?=
 =?us-ascii?Q?BaTxdJVZ5BDucpnnmp4mhJWrajcrlbuRPmfVMWWBLmbZYIuA0C58Cl06gFaw?=
 =?us-ascii?Q?4RtKUisbJv4DUID1qiY5QEOzUQ6ZRh8gnM7735KOvIB66xq33x30Y+C5t5qj?=
 =?us-ascii?Q?8ZfALb2eXfivecp0GeyEQbMuI47IIDogyRbimGI4k2sq3CvVuMOep3M1qkVv?=
 =?us-ascii?Q?FvY0XRQqch3cvRWdogYYnw90Ol8sD12YCezOzU4aBUt5F7c9jujJh2OFvc3r?=
 =?us-ascii?Q?/SVl0eZiYQW98wV8MSaGllfdb3RgkcZDZUzwOCKKlaze34WJj95P3y5AfynV?=
 =?us-ascii?Q?FEg+A4T6n+Jqi1O1hoqcQDG5csxgEwiwfVWx/HJBvEYPVb+YByQoYkQbIA0L?=
 =?us-ascii?Q?SoDQYXFStOcTwY55e3dytNKRV/ZQPvDBwp9TdEgZ7BPDEc6mftYbrlMCVnsB?=
 =?us-ascii?Q?0D/+U70zcjLXiUZkbiaDE2TE2d3BvsoRZ2kzr+HT2B13d6bsFsR57Z6LqPZ2?=
 =?us-ascii?Q?yIkO7btoFnygWoI1xrPPna9rDvyh2Xkc17nU+xePQ2V/emsjVB6NKn7lExHo?=
 =?us-ascii?Q?zDSGS6AbgImbSiLDFW9VxvCw8fZvzntjcu15ZGWNsShJeb/sNmLta6+GLx72?=
 =?us-ascii?Q?QYGA6InFGvC1IjiYOvyHqRQ7GkKESUwFxpwGeRHGZmKNoBMvt1eip3DGDw3D?=
 =?us-ascii?Q?+eDKFigUfkhG2MHBQyFa5hc0X8TH8j3H9EOWxwSRDC9/69HQ3KJy4FAP8Bp1?=
 =?us-ascii?Q?H/G8FTNTJgZH8VgOIs0lhE/FHIK/D65FPHbun3nY18oIJfWCppjogV7UfxiV?=
 =?us-ascii?Q?bH/rEv8QFLGktrQdClKyEgGS5cDNF6kkwmrzvCdDhqPwrqJaHAbI0/B+22vw?=
 =?us-ascii?Q?T2h8E04byAD+OCuVBVg2AxvvmhQj8KJyh4xUUKo2AFniTJV8QyBQFI942gp9?=
 =?us-ascii?Q?Z9/IjdpbrY7VqlrABtBoXMJW/p9P5/Pinjx1QiakTY3DC9N8oYHmsIh5WzKx?=
 =?us-ascii?Q?H7D+RXdb89p3+jbKnr1RRIHG24wBmH/GY0DOzRm9xe5xS4jaE9VyUvAsNbdW?=
 =?us-ascii?Q?GLfyjVWXjqDXTrBGVRDErAJ1MkMdQ4T6vQxhnItyD4ecO011ZyRWXuWc+uT4?=
 =?us-ascii?Q?QHj7Z26zWjWxaP8qcFcGJtgahV5jDOcbZZD0/oAD1GX/UQZGw0HoZ6SDV0E7?=
 =?us-ascii?Q?a5oJ3eFvi2lkqV5eaLOgRhtFi89iD++cYXOgAaPptD8TWPPCn8LW6lZJCG4u?=
 =?us-ascii?Q?iuByy4Q0gmYgMGl3lmQcrILT0pmPiUnJzM1FhtYWhNYl/1tgYVr9GQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 03:58:34.2926 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69caf1b9-7b0a-49d5-25da-08dd6b515082
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB1045
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

Add support for ethernet boot in the A53 SPL. Increase the SPL Size
limit and update SPL_STACK_R_ADDR.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 configs/phycore_am62x_a53_defconfig | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
index 0494fc408b7..0111ad12e20 100644
--- a/configs/phycore_am62x_a53_defconfig
+++ b/configs/phycore_am62x_a53_defconfig
@@ -19,14 +19,15 @@ CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
-CONFIG_SPL_STACK_R_ADDR=0x82000000
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_STACK_R_ADDR=0x83000000
 CONFIG_SPL_TEXT_BASE=0x80080000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x80c80000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_STACK_R=y
 CONFIG_SYS_BOOTM_LEN=0x800000
-CONFIG_SPL_SIZE_LIMIT=0x40000
+CONFIG_SPL_SIZE_LIMIT=0x80000
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x800
 CONFIG_ENV_OFFSET_REDUND=0x6c0000
 CONFIG_SPL_FS_FAT=y
@@ -51,11 +52,15 @@ CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1400
+CONFIG_SPL_DMA=y
 CONFIG_SPL_ENV_SUPPORT=y
+CONFIG_SPL_ETH=y
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
 CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_MAILBOX=y
 CONFIG_SPL_DM_SPI_FLASH=y
+CONFIG_SPL_NET=y
+CONFIG_SPL_NET_VCI_STRING="AM62X U-Boot A53 SPL"
 CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_RAM_DEVICE=y
 # CONFIG_SPL_SPI_FLASH_TINY is not set
-- 
2.34.1

