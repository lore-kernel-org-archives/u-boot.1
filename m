Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF066CD4F3C
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 08:30:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 492BA8460E;
	Wed, 20 May 2026 10:30:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="thOxcVoz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F38198467A; Wed, 20 May 2026 10:30:20 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94059803C6
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 10:30:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HyqLkIquCst21N4bdWMQ3iXbChU9T6uEBceqJiEjAfN+9kUzH1rMlQEB23E+uFttK9r88SPHWQh7lA2LDotyQ6L5jLxpGsCKrHlUxYMBtNz9eLlc9YvgUlAuAD3vNZ+sVt6bFlqjFvG80Q5ncIkYXj2m6xclS5vxA1IhMjZG7cCp4RmnpBOlbNghR4d8+kpJqRrkai4lfZOnHF2UOaoQAuUEt1CO90aJvoI00QlcjqDOtKcRp9dtbU2N7Tt4fRtXSdVs4HI8sghylNY8BgPSRY+xFV9c4lVYkrZSRhMUHHpEiRkhKYH+4GtlqhQzPsYIAJWqyrxMlZsihqbT3gdHeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZByAyjijLnLDocu7wMX1YJpEWhiYbPMZj1hkFlfj87k=;
 b=XVfTY1p4cD8Z8hqTnZXq7Ov/SCG1iQLZygOw/cBSVt7Q0RlIag9eHQAbODamTANAtlOTAsrDwXRMFTqSmvukXk3M/8Q9i1ALhBhTo1ZnYrNWj2ybhELgUhkTZxIOobUZSKScu2VjIo73yjVvQBvFPf3j93FE3ghGzcF3XY+XMyVRowk3QkLxZb+u04aAn1vJc79dq3PI2xzPY0LsXB8RCymf9z2RkMeMebUkn0ojXY5pF+R//wMVvjCKRYjTpPtJq74nJ64PKQVP4wMVMkqfXq3dtHOZxpAQhLc3Hc0dhq6XhPy2Noev6RTdGVgLT6RTeECeAOpcBhYYg9BMBEb7gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZByAyjijLnLDocu7wMX1YJpEWhiYbPMZj1hkFlfj87k=;
 b=thOxcVozhWgRnoyVpYVSPejMfATqjDRay9NKUZap3J9T8ShFTMGJe1lZ5XLmkpcFxtVfO95VQ54hBmz+KdWtJlQp7iZPMeb8Ln3R3DHVqsYbyuyRuXZDrKgj+oXs9RIDEcfI68QNNiUItz+X+ISGQl3K3kbsIptfocKCQyA9eO8=
Received: from PH1PEPF000132EF.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::37)
 by BL3PR10MB6017.namprd10.prod.outlook.com (2603:10b6:208:3b0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Wed, 20 May
 2026 08:30:13 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2a01:111:f403:f910::2) by PH1PEPF000132EF.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 08:30:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 08:30:12 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 20 May
 2026 03:30:11 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 20 May
 2026 03:30:11 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 20 May 2026 03:30:11 -0500
Received: from moteen-ubuntu-desk.dhcp.ti.com (moteen-ubuntu-desk.dhcp.ti.com
 [10.24.50.20])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64K8U8QP1601556;
 Wed, 20 May 2026 03:30:09 -0500
From: Moteen Shah <m-shah@ti.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <gehariprasath@ti.com>, <m-shah@ti.com>
Subject: [uU PATCH 1/1] am57xx: restore bootm_size for ARMv7 HighMem constraint
Date: Wed, 20 May 2026 14:00:07 +0530
Message-ID: <20260520083007.2557081-1-m-shah@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|BL3PR10MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: 1662d373-c62c-4a74-71ff-08deb64a0331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: xH8YyGQ7Tny7j76f7gujqcxJyfyad0mOqIOtq/JD/xTzIM+HWfz5Z/yrmPOG0bn7P0q6dafZaMbNYR+6F0KjXQ1+zVZ3WVT9T+9KdRtwzGX5C0F3PzpPW9R/PI5QTxUeHt3mkWij/uKA/5t8xg6iHSk56h90dQUs1rQ2WkvJDLgNu73hS0uqaL7SzleLfhGa4mG5HAaGiYchAat98Dv472j0mZoA6/rZZVffh7kECH9jvJnR4EjTkM6/dUL8M35xYvrbrYGtSPF5DFvzvzeFIzgKOfAR1JWGYNTAGPwezT50mG/AEbI57otTIbfckJG4fgi2UCqk4/j+4xq5HMGUXzCFN8cc8uEnXjtoz9ovyyUmOz0nhOaMndCho1dyfYpioSw5nlw6VOriWaFTv2t9gE4LjU4vGKj5XbHTijSJ0vxek8dLwcxQwF5VZDb9YVboj2m0tZWT1eUCBe3rtOBbHgl9XCWV7cXivft7NlpOEhucFSLj8mM3NTGxYihkrmnFmZJWGQgm4T7sk4iImnDrbhOljaUuRZk9Jg9iubs/7H/i4IG5cQE6eph84GP2lPkKmwQ504r3TR7gDYHHlanzbM+QlOUaF37TuBhVjgFh6eW6AW5IvC1D9JSZarXwOfVSGFQsoB40wI+DaZPCRufSx/xRIDC7SoMAOaJv/KT0N/9/aHzXOdoWKWWLRhkERyTQ
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rE1Qk8Olnmm058OcU9a9X/bq9KoZxh6w5cIOUjVqjnoHDw++A/+pK9FP/gMlaDp11fZ6iWJ9SeNDJNJiEi1yeY2047MeTKNZmKftIWxyu7HFGh2sXM5C8vyr6WKpOfN1lWigpXBHBMCFcU3r+fmdYNned+BEfCsmMCXWBN7tqVB3b86HZirM8YrLvdrN7e01nYhLp+g+BwemmZbVsrJD1vr47M1JeCiPM7XTHlccxxkOWTT/SGpPWR6KB2D3wXO/dpjqJH3oq8CJTD/gz7YH6sYM1ua4C+ShBKZMr0TZLSkmQH+ssH/E8C4aquhZZ4I1uEJYlKqcL6EmejZzIupGFWf1nBb0a3hD306/c1SgY9gEGTCBf1Q3F8Fy4PXS0VIbAc3j0SlcLoxa2v5dJ+xTe1+X04odzy1sDIUoAvw/ZZrceIzXjPhDxJNZERW0QbP1
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 08:30:12.9694 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1662d373-c62c-4a74-71ff-08deb64a0331
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6017
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

babae80169d removed bootm_size from ti_common.env to allow K3 boards
to process images larger than 256MB, but preserved it in
ti_armv7_keystone2.env for ARMv7 Keystone2 boards. AM57xx (also ARMv7)
was not covered by that preservation.

Without bootm_size, env_get_bootm_size() falls back to gd->ram_size,
causing initrd_high to be computed as the top of all RAM. On ARM32
boards with more RAM than the DMA zone (e.g. AM572x IDK with 2GiB),
this places the ramdisk above 0xafe00000 (HighMem), which is not
directly accessible by the kernel after MMU setup, causing a silent
crash.

With bootm_size=0x10000000, initrd_high is constrained to
0x80000000 + 0x10000000 = 0x90000000, keeping the ramdisk in the
DMA zone and allowing the kernel to access it correctly.

Fixes: babae80169d ("include: env: ti_common: remove bootm_size")

Signed-off-by: Moteen Shah <m-shah@ti.com>
---
Logs: https://gist.github.com/Jamm02/4dc37a837eded0490d7f16b457807dc3

 board/ti/am57xx/am57xx.env | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/ti/am57xx/am57xx.env b/board/ti/am57xx/am57xx.env
index a7cbbced099..74659279484 100644
--- a/board/ti/am57xx/am57xx.env
+++ b/board/ti/am57xx/am57xx.env
@@ -1,6 +1,7 @@
 #include <env/ti/ti_common.env>
 #include <env/ti/mmc.env>
 #include <env/ti/dfu.env>
+bootm_size=0x10000000
 
 bootpart=0:2
 bootdir=/boot
-- 
2.34.1

