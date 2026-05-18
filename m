Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20209CD4F49
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 08:23:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 918098466F;
	Mon, 18 May 2026 10:23:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ws6VQJmN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C29F83EF9; Mon, 18 May 2026 10:23:07 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14A2A8466F
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 10:23:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPGjvHZcUUy0iUyNfwUBOqkH/10j/eHNr9aHcs0Kqz8PzmJm4bjy7rosCuqa9GR+cSLp7ZPFDnSxBmlxaVAOvc8NsUpfmUNQI+uIhUwcw8NNEIyMzXl8STq4O2uPK4HqW7pyb8OanU8ABTA2XO16Bu2705Jk3lwJKZ55SX2HQ757BoEwUw/YzdXjxOgmjZlVWZWC5l4oPDb6Pp+y0w3bcu4NNMI2pVQL9AT3hbwIlVv+LJt+q96BqhBOY53a1dVrsThXYNUEd7ISx9x5oiOt3OSlFJWXsV0HrD+qB0yMbwYOtY8U5OrxlNe2xsUdkw/wjIBfYA/M9HslzU+/C9KMrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLFSMzy3eKTB6kATyWr7vzTW/H8ii9vQ30aiJAWXavk=;
 b=mK6SncaP8UdfxL3qigIOhMRhuVPGfSaqRJ5sUZMkvfJjN/GI0ipGh6kxr4GRcxGQqMoVD31/wHV5rb+7R8x0GnrAsg6xwGQqzBOmClOOWltN9lIA/ZGCWUtHVfyeHj+RHtLLclNvI40Xay/OlZYI646AWOyU+SLUScphM/qfYlgXFP6b1W7WiN/68T02qfC62UMJdSUS8s+VFX4kSoFzvgnd6BlcZVAIwR5Zpbtqe532hy2W8mlrx6NReQpEGmKz+4JteEPi2d+64CFUtpOFgLymS6j+d5F+LUu6sdCd6pq+gRxq7IH+Bytpqtl2QXmCofEnS0xPIiGhcEYELdxb+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLFSMzy3eKTB6kATyWr7vzTW/H8ii9vQ30aiJAWXavk=;
 b=ws6VQJmNHnkmekJeoic+64mWzaTJ2zSUz0f2exPN2iAU1rfMw0DbzS5TKDMzFqkGEddXvHU/OSebmKMgm/p8CK1gfpCQ0O0UxPFCyHYM7VP7p2d9g9tJX7FrnEb1eISQSMJCUh+jHKXm2n/L7a+CJ5okTtPhcUHvSecJFINUyNE=
Received: from DM6PR03CA0080.namprd03.prod.outlook.com (2603:10b6:5:333::13)
 by IA4PR10MB8445.namprd10.prod.outlook.com (2603:10b6:208:568::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 08:23:03 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:333:cafe::56) by DM6PR03CA0080.outlook.office365.com
 (2603:10b6:5:333::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Mon, 18
 May 2026 08:23:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 08:23:01 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 18 May
 2026 03:23:01 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 18 May
 2026 03:23:00 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 18 May 2026 03:23:00 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.72.233])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64I8MxIE1478924;
 Mon, 18 May 2026 03:23:00 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Mon, 18 May 2026 13:52:53 +0530
Subject: [PATCH 2/2] env: ti: k3_dfu: use Kconfig options for addresses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260518-env_to_kconfig_migration-v1-2-24c8fba75ad3@ti.com>
References: <20260518-env_to_kconfig_migration-v1-0-24c8fba75ad3@ti.com>
In-Reply-To: <20260518-env_to_kconfig_migration-v1-0-24c8fba75ad3@ti.com>
To: <u-boot@lists.denx.de>
CC: Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>, Anshul Dalal
 <anshuld@ti.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779092575; l=1460;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=0Bs3bAu6d/zYSpp7vmrGzCWNhzv0gkAOTPrnrLtgsEI=;
 b=Ncio1Cp0/bjkbwCdOSWmzZvP4Zyiq6KhVoHsL+rWosnfm47/YyIq4PZuPlAuRL6PvHOgqDBjk
 DG0hkBc/HoPArfIqFVmqFI1sa0zs1qSGrNBXNA/p60VZyoHbzifLcsW
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|IA4PR10MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: 4252c499-c705-4683-f4b0-08deb4b6ad42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 2+TEMce5cHHpoptHBCG7E9aPZm75nTOQNBzu93BeLQ/9+QLFHzvQH1om3Kkvm6MlZ2lCJTzA+oavHrRww4EsDtouxR0m6Z7u7auzrR1h1wD0jbuZO6CRUNmzypUhIO02oxVKFxXcpsR11WasLHykIhHzoIEtxhdcAsivTRQumeSmZ53Z37yRqMyiy086tR+bEVxlWnTN7jQPOXUdOfduZodjXY5GYT7EDz+OKyuq5L6vrQpzU8lBT5riM05EPT4d6cfyJdY/P5JkMFEFvkv9qsU655zS403iJNQGGOwRe/GfUT2JibNiPbJK0wJJlcumMEYqUunOhO2QyG5I7WEqlRDa9G27tcFLm3qrkdRQbvQB9jrAFyqqPj1b+hFu6LdfiFyTI8rAWmAUKDzo/5XwkHodR0fq4ydGDliJOqbbJqs5RlFvxwEEOH7QuLhQsZ2gnTNIkuTuyslQarfj0cSWh1o3yoFqz7d6SNdB6+tKCpDv1tkg/7tKwdPsuIH/P37j5YkJMiG8dHenp5fu2vARbfbD4ce1MZGHxO9LZm8tPbi6srxC+cVGHMTJmYMG6dJNqp+A9+WqNkPHaQc7nZotV3oW62wY9mczDYl1ZlbekAS5S6JHkUCWZdW17ScLuewW90vsP5Lk317cBXUyIlpY9VnuYyKCTex5o8hZayAWjnZ6SUolQsRkjBQW0LzAq2GCFaj3F/CvRnjbAzp4g0TOR6VslwWyn8sFk8rRJA2Ctgo=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2Z9Em0ANk1LA0mHpaAe7wJfHZKJPpp4ncrzQM9uYNea/W9xPkeLnKEWglzvllZDUkHn0rfvppgtj7R9z5Q4VqAu6tPC1EHEvFrft31oDllxrnEoDV+SN3qd+NbCAcbYp+i+J0tGR36OIbfZTk1lY8lGnx1VdFx26I7Da4WguYI75pjLE+3MA4xMaRwEzC3xJ/Z6Xv6ODxtmgsrFbqUuAeAM6mCt+r/LI/SAFfi8JlU9MPG2AykbVSo+/cEtHkz2t5LufO8F5/kaOea3XvWw1siy8GM7tKp/afMBhkQwaCxcHJ0JHGdhShU04JtFJgbob/Iu1bJk9iarjRwzkjfshHYEliVI0OXy+nm7A4lpeAWMsAGYKNo/h5137wgOPMm/38rA00VSUxDVqZPqGalasMRu0OYvSYfnyZmUPphXFgFyiomSDrZ+50fp3RPy0glSf
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 08:23:01.6107 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4252c499-c705-4683-f4b0-08deb4b6ad42
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8445
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

The load addresses for DFU download binaries were hardcoded for K3
devices which required redefinition of such env for boards that deviated
from the expected K3 memory map (such as AM6254atl EMV).

This patch replaces the hardcoded addresses with their corresponding
Kconfig options making the k3_dfu.env more general.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 board/ti/am62x/am6254atl.env | 7 -------
 include/env/ti/k3_dfu.env    | 4 ++--
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/board/ti/am62x/am6254atl.env b/board/ti/am62x/am6254atl.env
index dabc77245d4..a9187c2b1aa 100644
--- a/board/ti/am62x/am6254atl.env
+++ b/board/ti/am62x/am6254atl.env
@@ -27,13 +27,6 @@ splashimage=0x82180000
 splashpos=m,m
 splashsource=sf
 
-dfu_alt_info_ram=
-#if CONFIG_ARM64
-	u-boot.img ram 0x82f80000 0x400000
-#else
-	tispl.bin ram 0x82000000 0x200000
-#endif
-
 #if CONFIG_BOOTMETH_ANDROID
 #include <env/ti/android.env>
 adtb_idx=0
diff --git a/include/env/ti/k3_dfu.env b/include/env/ti/k3_dfu.env
index 0f82a8afb42..1ae9ae6ae15 100644
--- a/include/env/ti/k3_dfu.env
+++ b/include/env/ti/k3_dfu.env
@@ -26,8 +26,8 @@ dfu_alt_info_ospi=
 
 dfu_alt_info_ram=
 #if CONFIG_ARM64
-	u-boot.img ram 0x81000000 0x400000
+	u-boot.img ram CONFIG_SPL_LOAD_FIT_ADDRESS 0x400000
 #else
-	tispl.bin ram 0x80080000 0x200000
+	tispl.bin ram CONFIG_SPL_LOAD_FIT_ADDRESS 0x200000
 #endif
 

-- 
2.53.0

