Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77432D1CDC6
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 05:51:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBF8A838BB;
	Tue,  9 Dec 2025 06:51:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hNcFeMv6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E03A83935; Tue,  9 Dec 2025 06:51:02 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5E4A838A0
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 06:50:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IOYyY+b8Ey/pvM0iVfdSoDO6mnQsDYMy4w5DREAi9nYf4bHdeSr8/wYjunsBnF4t9HGrgOsxFmrjVn7yEVolThaOy7+XPg10M1M5mze09++vO5nNteOh3lghEZCgVQDXvjy9HmbIylmMXdwyyRBTzyb90hv6AndGDKisdmeZnqZsK4DzFBXbnWTb4XxeYfo9LYITP7y1vFa2phwlSa0GxISJwiD4mjqRO+FO9hmnAHzOOTNhLmuqD6qBI8rKnrZY/4091l7NF1TeUM4XCkXnEnner5VmoTfBaeFHcgPC2X6s4JILqO2ejwGVQb/G/Yrm5VoEwrIfb5o0f1k+H7Hz3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2ejgbLDfeON/p5jfPkuNDQ5PXZOnCKWJF0fhO++IEA=;
 b=bzXjJdM1IpEEgTa21VtQjtoGAYBXYa/jJ81jHTQVUkxsXJSWC1q6LJ6UANTEIUD3eruc7BJXHykuKrroDvfYrHXCAbpUx+pz7g0ld05pRYI65SwSHFl3RxG3zyp5y2olZwyAQ7UvUJ6F6qqDriOYYBOhcsdNumXuNvSf6KofqJkHRQFlPI3hGIZ/PuMP4ZT22dF4V5ZbV133CGasMLzkaEHaj/dB6anOfMaEozL3h7rwmStFFJ2xdqEqBuBEtObPejLnJShb5sNIstvl8bzLZyZMtFufacWnERPl6dU5gFsqPvkLW7qH8Za0gtsCks4a9rLubVh/Tca8YKw7/Ahr/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2ejgbLDfeON/p5jfPkuNDQ5PXZOnCKWJF0fhO++IEA=;
 b=hNcFeMv6q2GwiLGTKXX0iK7ksRRe4vLohFjUChM9SKIY6IeF9SC8aRp6mN6nyH2TK59nVwg6EJ9HBQSE8eyFEoyVKg1meBfj/NmcOtpQgDyujWDcNhP/ucKbDIIO/YGyfmpjNJQ6oVPK5KneO2ntrwQsIDvTUYPo0THHyQp0QTA=
Received: from DM6PR17CA0003.namprd17.prod.outlook.com (2603:10b6:5:1b3::16)
 by CO1PR10MB4644.namprd10.prod.outlook.com (2603:10b6:303:99::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 05:50:56 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:5:1b3:cafe::c0) by DM6PR17CA0003.outlook.office365.com
 (2603:10b6:5:1b3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 05:51:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 05:50:54 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Dec
 2025 23:50:51 -0600
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Dec
 2025 23:50:51 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 8 Dec 2025 23:50:51 -0600
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B95om2M663621;
 Mon, 8 Dec 2025 23:50:49 -0600
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>,
 <u-kumar1@ti.com>, <b-padhi@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH] configs: am43xx: Migrate to CONFIG_SYS_MEM_TOP_HIDE from
 CFG_PRAM
Date: Tue, 9 Dec 2025 11:20:43 +0530
Message-ID: <20251209055043.1410085-1-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|CO1PR10MB4644:EE_
X-MS-Office365-Filtering-Correlation-Id: 51e077f5-3333-4842-44d7-08de36e6eaef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QR9btkb6XEtFrPGW1ONklFGKdPpLQbUvyFRepoeXpMiaotwH7Bs2Vb99qElt?=
 =?us-ascii?Q?ZAKUm5SVNtSgqyZ81cjBP0eQGB5s/Jn98/nRZW8lTLIqHkN/UzO2AtbvdpUQ?=
 =?us-ascii?Q?JnXLxGtumfX3Y47FKbCTObfJznGZuHZhFHODOMREOzlXTG5kxhn56d39p9rl?=
 =?us-ascii?Q?GQWDle88tsNJ/A090nMKU/9J8avMtTdYM0pPRKt6Av92yRZPQUcuWR1W/h5H?=
 =?us-ascii?Q?Qlzofl/aEA+i0es+BAPUDtCcNEkPQAfkBIJAsVwsDEKusadLjUuUkOVBDOMU?=
 =?us-ascii?Q?CUhqGRfihPJ9MiPepA9IY/hD2dyMZ4D4UXtIXcvz2f8QZalaqb9cwpZbByYD?=
 =?us-ascii?Q?mJ3NFcbc7rUOE77vYBCNeAEN2/iTPHehljuNGWyEg8JHvJL72rKwAl0eyP2w?=
 =?us-ascii?Q?C6kKf6SLZsTKIFnv048+j9c20YpgBcK2gxJa1Q9jLSlmS9J+s9WtBXFzo6F0?=
 =?us-ascii?Q?anXEky4o3bgNnLqKFWvUt7EVWrvGVcatY/xMozWdFavyLIExmFdGR/Xtqeai?=
 =?us-ascii?Q?XElJig7K4BgEswQgade+IzwyTM4pUIXQilctOCe4NyYAA5gL4e4d4isjAmVT?=
 =?us-ascii?Q?enypkzHO+rYt1KpIHMB+VDZW2hnATYi/XrJTDiaqAbOFSCrSn+v9EBto+wRp?=
 =?us-ascii?Q?wkHAz2yHAKbJbZrWAfSUyrqXmUPZoAxDWhOiqMPXmW76emLmmVh+byP3/40X?=
 =?us-ascii?Q?LDatZK0aSgNAQqLDIYOKM7R5pmrGBN3+761H8frnk2i3azFn0kedweqHgDZO?=
 =?us-ascii?Q?kmJtsi7+ygdl93Vq2clEavsarOUQNUqctLoyt932A/aNqPBZ3LLJdRCkMEUk?=
 =?us-ascii?Q?jAFwgyztJMIn8C09BGtpqDw4eVRIO0pB0GWNWzjwxrQekxlV7JWFUDF/kcRL?=
 =?us-ascii?Q?XNq7CdGGEj3Kpzp1R4ZLN/0FaQdbxRQ9xcjs1XRg29FXnsS+GOyJLZu+FwbY?=
 =?us-ascii?Q?dQXc8DrALVN8IHXAaGgwZjqpF8ihAkCXOyYj53pdTnD4wNJzuEe4ao+d1TAY?=
 =?us-ascii?Q?KLyqtZ5I5X4rd27Gm/M75dt09EVRarZNfMEiIpapNhA18I8jE1vAZImhe3oA?=
 =?us-ascii?Q?tjpg//yqPbsRToikFBiJt7/myATYSUaKjHIjivZhWfqRWRqY/Hhtz4msm1YV?=
 =?us-ascii?Q?c0NBfnXMj5JEMUPLj1NE2G3DMMXl2pGUNdRe3YQaEaxhwYWH0/NKqIBo7SRD?=
 =?us-ascii?Q?ikGFBFleV5b9K5x4EQaPvND/+7zmTV2JbTCzDzBqB6ICDI9gbYQAUlzJroyE?=
 =?us-ascii?Q?aaiu/BJsyuslogxJPZ9xg6Hdi7wNHiFO5tc3bWqUvqpcgfbQ9SrEVl3m0Cf8?=
 =?us-ascii?Q?/QujRCWU0H8sH/1ixWxGyrRSyxMM71X257jGfmkPoMF8vtiybDDMjmG3KqEJ?=
 =?us-ascii?Q?4IGK3weJZvXG/kUOkZLup1BhYqrd+x2bjK21UIJoLpRxyaeQwXK9H6qPvQm9?=
 =?us-ascii?Q?kGUEqikI3rQmeOEafIyCBBIXBfCGMMLPAEYk+PYEYuoIRX39l0TPkLvMCMjj?=
 =?us-ascii?Q?yFJCcsd/U8MnAIPEQCDNVKmtHG6W1jUd4N93De09hZ2qOBqz50sglORB5dm2?=
 =?us-ascii?Q?t43Ew9Tm9v/twAr8d+I=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 05:50:54.4364 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e077f5-3333-4842-44d7-08de36e6eaef
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4644
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

The TI AM43xx HS boards have been using CFG_PRAM to hide the top 64MB
firewalled DRAM memory from U-Boot. However, CFG_PRAM only prevents
U-Boot from relocating into that memory, but it is still open for access
for any other usage.

Therefore, migrate into using CONFIG_SYS_MEM_TOP_HIDE which reduces the
ram size itself ensuring that memory is not visible to U-Boot at all
(either for reloc, or general usage).

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
Note: Build tested only.
Cc: Judith Mendez <jm@ti.com>

 configs/am43xx_hs_evm_defconfig      | 1 +
 configs/am43xx_hs_evm_qspi_defconfig | 1 +
 include/configs/am43xx_evm.h         | 5 -----
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/configs/am43xx_hs_evm_defconfig b/configs/am43xx_hs_evm_defconfig
index c95fc0886bf..8bb13848a6a 100644
--- a/configs/am43xx_hs_evm_defconfig
+++ b/configs/am43xx_hs_evm_defconfig
@@ -15,6 +15,7 @@ CONFIG_TI_SECURE_EMIF_PROTECTED_REGION_SIZE=0x01c00000
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL_TEXT_BASE=0x403018e0
 CONFIG_SPL=y
+CONFIG_SYS_MEM_TOP_HIDE=0x4000000
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
diff --git a/configs/am43xx_hs_evm_qspi_defconfig b/configs/am43xx_hs_evm_qspi_defconfig
index cc444ac2817..9b4bc178ed0 100644
--- a/configs/am43xx_hs_evm_qspi_defconfig
+++ b/configs/am43xx_hs_evm_qspi_defconfig
@@ -14,6 +14,7 @@ CONFIG_TI_SECURE_EMIF_REGION_START=0xbdb00000
 CONFIG_TI_SECURE_EMIF_TOTAL_REGION_SIZE=0x02000000
 CONFIG_TI_SECURE_EMIF_PROTECTED_REGION_SIZE=0x01c00000
 CONFIG_ENV_OFFSET_REDUND=0x120000
+CONFIG_SYS_MEM_TOP_HIDE=0x4000000
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_QSPI_BOOT=y
 CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
diff --git a/include/configs/am43xx_evm.h b/include/configs/am43xx_evm.h
index 036995cbb48..99d3ecb3fff 100644
--- a/include/configs/am43xx_evm.h
+++ b/include/configs/am43xx_evm.h
@@ -148,9 +148,4 @@
 #define NANDBOOT
 #endif /* CONFIG_MTD_RAW_NAND */
 
-#if defined(CONFIG_TI_SECURE_DEVICE)
-/* Avoid relocating onto firewalled area at end of DRAM */
-#define CFG_PRAM (64 * 1024)
-#endif /* CONFIG_TI_SECURE_DEVICE */
-
 #endif	/* __CONFIG_AM43XX_EVM_H */
-- 
2.34.1

