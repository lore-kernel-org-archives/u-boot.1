Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CE6105F7A6
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 13:59:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37D1B84221;
	Fri, 13 Mar 2026 14:59:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Odmsxpv8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAF0E84307; Fri, 13 Mar 2026 14:59:23 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD75D84221
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 14:59:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NY4xWy4/FbY9MBmWLPhPL0Dho3cjyxv2NA+c/Muxm1Umm+nsl/gb6FwbFWCFvGOrMqWjKYesd+1KaGCuI/aY1hO07ebhE8XEzpzBdYmPjhFFsxa26rFelONT1b8Jr1kSWKNn4Cn4LYEzCtXah8CY4vyzozr5LiQZwuYK+fU5ZDLgvvr9xIHD5hVCIckgsihSzLEkRjlMdfdZKmrALOdf889GJqFWKEJnRsrEfN5ID3ged0CSixDxOgG44noYUoRqrJIv4uDxKaQxCkAak9Y6RjKsutm8cde2qPMt3EyvG2ZW7FCujf4YS3fhgf6eQE0ovaW3rxe9yfhNt0loM9YiSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubK616dPDyGR8ncMw3o05UO0GPYlOV70aU/egECTOm4=;
 b=arIHBtaSK7ZrZDWuQzUH3gJJZaJm8kWl7mwZaq06v62YmrM0DehEIOoC/FbW5qcRYfxdriq8lqdSJuLwDdc402qVnBWZRiDbuhWG3RLeVqy8BHAtMp3b3t0nZn5obQW8kLmK7xgs08Xty8UBDAcCOh0U02z2To1Rw/nRCjPaBn7dsEY5Du2NGVZPMfOb9DW8eAivrunVwba8iW2oGbTFSRtrh6m4R2/28f9+fBbcfJJP95wbgK4LP9k2kYbvbWM+hgIrWj1ZKdefZQRwN9YWL1Y+Zhkql19TSydkQHqcaPfkwlShapWkF2AV/9l2lsquLhOF6IX7Pq+61N0oyx91qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubK616dPDyGR8ncMw3o05UO0GPYlOV70aU/egECTOm4=;
 b=Odmsxpv8zeFjHF1wr0HyGzsfLmPhZCf+j7J/aXsDSCcGHILp2Z9/zpORP7Ls7oNmui/YCMY4Akoo1KlmzOgm4VjXgoFdka8S+jpt7xNjTC07y23twhnLAY2XhBMaoi8tJ0lWqaGPovSu8JSydR2iYNccHctVVwkiGC91oGINQpY=
Received: from CH2PR14CA0032.namprd14.prod.outlook.com (2603:10b6:610:56::12)
 by SJ5PPF87E558B7D.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::7b3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Fri, 13 Mar
 2026 13:59:17 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:610:56:cafe::5e) by CH2PR14CA0032.outlook.office365.com
 (2603:10b6:610:56::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.16 via Frontend Transport; Fri,
 13 Mar 2026 13:59:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 13:59:15 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 08:59:11 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 08:59:11 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Mar 2026 08:59:11 -0500
Received: from prasanth-server.dhcp.ti.com (prasanth-server.dhcp.ti.com
 [10.24.53.104])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62DDx6JX638000;
 Fri, 13 Mar 2026 08:59:09 -0500
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <n-francis@ti.com>
CC: <u-kumar1@ti.com>, <vigneshr@ti.com>, <a-kumar2@ti.com>
Subject: [RFC PATCH 01/19] configs: j7200_evm_r5: Used main_r5 reserved memory
 in DDR for malloc heap
Date: Fri, 13 Mar 2026 19:28:42 +0530
Message-ID: <20260313135900.3430264-2-p-mantena@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260313135900.3430264-1-p-mantena@ti.com>
References: <20260313135900.3430264-1-p-mantena@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|SJ5PPF87E558B7D:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dd2245c-edc4-49a2-de0a-08de8108b689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: A/UPvC0DemWBZ5CbNiKfivOj1cq3y6ZOaT3YOXK2YdcamkBl03RghFekMj+jr+SJFeuKVMA0+xwjtakHKp2LYeX4P8TbvmokRMz19yYYcimipxZPH3rPxc163gPUsrRshx3p554EtH4kG/K1nhK3/xE9wTCH/DjnLyYY3InLwjuu4Ck5pz6vw4xLZG/f7jGCDoV2EcFKwifHx01Yu/ZUl6+4NKbvyHSBxidK9521gr7ryZheqwlFu34x2VDsijxCRQCtVkUVW6KjsVUkIjH3LJkRZ6/TgO+ePaZLTwfLdVtabqI+WSt2HcqHHjjEfWfk5pVhi6ZCfEyzMCMcjieV9xCweKieag1KRat/7tfiDy5KlEEVmZTF6URJUdM3wVETWPoADNz9EtB4GP/IP3sPXXdCooYxCjIUpJVmigyzlNm9E0/uzTlTFn/SoEhSGnAjW0yqPlBWCIFdOZvygqPJDISMvnjz1kBbZCXJK3KOnPIcifHCe7DNMLXbSE2KEP5o6VXVVi8LLCGw5KJnpXABqNfz4T/GD67R6Hgtoon20gUeLdbe6dFmVqyJA9AcyiSl5RZ1zmrJB9PqnevxpaI7T1byF7neLjQauDj0QRZdklBwaj01sto4hJhY++HIklKbyH0hOfBlKFnCvfWSoAOclIdVyyCNbenxXVpMmhKuoPQ/d1VxAvBFQgLSefa6K854NITfZMhId/d6yLDEUu73k3zPEIWoZgoBR5hQGrLD4NHXrIkag9eZrAcJ/xdWHdbOp9z3Hp8MxeEzF8uYNTE6Hg==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LUc+6k4C9e7bcEbjy1z7wALD8z8LlGvz4PRrvo+9L7yQbHhFxeh4qht8lX8KVck1vCDbrRJauux5irNBEcNJoelFQsicapSlVEh+4fA/1MyzVpN//DVrEi+HQCJ28axOrEqmlu0dzwpsnLkj0CZVGjfrLrbneHHRzXA7DbM7px2wEENWR16eMlx77bN2yi/Fqtf45ILM9cEgbWZ9yR6omodDhONkCW4XwjEtZOJfn9DuW1WoQWj+RJoDlpR3PW7szqaAAE4DNYZL1gQ0hop8TsAWTlZV8RSnoHobplt4Vpkp6FwnaQZuZ08A3oKPuMlihM+Zh2/pENyTiZftbpLvNzrM6pux9pEoPc2Oa0QavySZm+SpoBe0KsJb6YjnUKfvYAAx7jm60OD9r0rfyFxyi2EahyRy0x8AY0U/5puthWtVI1m4LEGMXlaajNdr7Mca
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 13:59:15.4350 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd2245c-edc4-49a2-de0a-08de8108b689
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF87E558B7D
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

While resuming from suspend, DDR is in retention, which was in use by
Linux. Memory used by linux can't be modified while resuming at spl stage.

So, move stack and heap allocations of R5 SPL to reserved memory location,
which is not used by linux at resume. Use main_r5 reserved regions as we
reload the firmwares on resume when linux comes back and r5 cores reload.

Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
---
 configs/j7200_evm_r5_defconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/configs/j7200_evm_r5_defconfig b/configs/j7200_evm_r5_defconfig
index 893aaafaa9c..a37f5bffa13 100644
--- a/configs/j7200_evm_r5_defconfig
+++ b/configs/j7200_evm_r5_defconfig
@@ -19,7 +19,7 @@ CONFIG_DM_RESET=y
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
-CONFIG_SPL_STACK_R_ADDR=0x82000000
+CONFIG_SPL_STACK_R_ADDR=0xa3000000
 CONFIG_SPL_TEXT_BASE=0x41c00000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x41cf5bfc
@@ -38,6 +38,9 @@ CONFIG_SPL_MAX_SIZE=0xc0000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SEPARATE_BSS=y
 CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0xa3000000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
 CONFIG_SPL_EARLY_BSS=y
 CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x800
-- 
2.34.1

