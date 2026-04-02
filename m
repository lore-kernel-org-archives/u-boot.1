Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1C01112246
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 00:14:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BAF38407E;
	Thu,  2 Apr 2026 02:14:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FA6JluZJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6AC384056; Thu,  2 Apr 2026 02:14:30 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 781FB80517
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 02:14:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NbAM191rGJ/0id+tcboGcSKzM8KzIs5hYSeSwEE+Hm5JS381HZdaQ2QriDIUlZBkMaFQ8xyA2vG1B2qslndImQJVMVwcYSLEI088oydx0VbVYftPPd0w35nWjLGWRiIS9SzXIXG8tCvyULI1Yo0GcEv42BBi7ajjEYCEOlPGUEPvaPfHrfSWXEhS8dJBw4EzXC+46EPk5Y2aMQ0XrahBBic07uK0cQaOY8Fgq+Q/LR7NAqDTz8ld0DZGd/hzXUVfJM0mnTZbo/rC0K+hAnbXLzQ8Z+mgrD5Q0OHshrucOZVW0bpSf2daS4q1mfYS40nLpbGrXOgAAJRmefq/owDd6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/By1qUn9HjRY/3hOAoktC2wR8M3AXnop+rAiqZixiR4=;
 b=fwl94HdXukN8s08e78MB+mkRdOJkB1zCm8HvNlEzlhIKRfFGF72Onpl6BHfL9EqiKanhlNvjSZ2JQKeHtrqM8XERsbW2fwH7ZSOAfNdOv8rOY/PzXqw7e30KFe3dlTOODKjT8A9LwjEBb8jZNSJLO5+YQm+7Y35jCCl49EfnNmRvpPiruem3Yw+Cg51XBZ/aKYHRxuImlKoAiDKtwV/eO6IWlSdIO2zD8c9pOPYbJnZGITlsMkFwQ4Ub72blHU0IpJm0fMyd5kB0a25hMeOTrsLB08ivwPk6rzMRcNpVQhAfW1qPbD+34uoG0e3bQPfboo0OlpccTqnX7RroW4M1UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/By1qUn9HjRY/3hOAoktC2wR8M3AXnop+rAiqZixiR4=;
 b=FA6JluZJF88RnX0r5jgJwPr0OQDaF5Tg+9kXtcnvVJ1pXCuWEgjTD5X7/PkZsYawxAhS6KAZ3PLYiMZdubBxZMI+Tl0s01mJqh1ygcxvyNYFfsLyTjcLvh0qcC1IHIHjtUNoCUyGnJLOGt7FPLvmm0j6yT9Wey/xgP881K2x4Eg=
Received: from PH7P220CA0089.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::14)
 by MN2PR10MB4381.namprd10.prod.outlook.com (2603:10b6:208:1d3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 00:14:22 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:510:32c:cafe::18) by PH7P220CA0089.outlook.office365.com
 (2603:10b6:510:32c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Thu,
 2 Apr 2026 00:14:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.0 via Frontend Transport; Thu, 2 Apr 2026 00:14:21 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 19:14:21 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 19:14:20 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Apr 2026 19:14:20 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6320EKsA1004385;
 Wed, 1 Apr 2026 19:14:20 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCH 0/6] various memory related fixups
Date: Wed, 1 Apr 2026 19:14:04 -0500
Message-ID: <20260402001410.3736815-1-rs@ti.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|MN2PR10MB4381:EE_
X-MS-Office365-Filtering-Correlation-Id: 9608d467-c9ac-46f6-a536-08de904cca2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5MqkKf5zyS9+VcOoADmA202JjHrgE2kKUcN8FJG6EMr3dxHYcypGjKe4UKKBRF6g5nPdPK8Bdq0+GzNOkjRbKyg8cTl3Cx1AuDV0ouD2tM49XRpHRo7luOM+69RqMx9jlNOHdl1ObFbCTcBmR7F79dsDKQ1CWVtGpsdacLYQLH48M16jNe/7KWsGgkumuNnpp7Cu3g8V+02hy9kQETi2NX/K5PQlF4GapSfh0GQSRlxXgy21LG9FxW9SgtY/6lWptEZvKFnMEwMbuelo9K1t4QFNJdzxQSGaC2NeeI8TNNOcOXeiEXD47vI4SlZt3IbI8NOj4V0dtsodr7oLsvlaejIQlwPqKOVvZ7AOcJ4IWm6OiAKo8yA0J0dxvCcYhVXgIcnUJ6JGgSwR5FcQyg+k9Mp/iaUPs4U3P0XIw8yXVunZ4GT8sYom4zOcr4+qmr7uyom2iFcFCT+bd5EuwVCl80ucB78G7S7VYAc9lhQj5zdLx7vNhlZwMVVYEPBtn5uRjMWLDKj9TzhObYXpRLz5jNtHIkvwdO7qqybIWOiwDBrXiVduU2HNEpcw2K3Y2heoU5e12McPolF1ngkGwKeIMY1GbmghV+rykd0KXG855ly5CUnxHSrqZLQUKYaOYg9vpX9/ve1xZiFk8Lb3BRKQB9wVvFf32ev2csrmekvkAy38nJTL7beRkBq9u21UCgS50xwwHiB6o0jY9XoKlF6ep7W8Z1aQhcKx0Yfv8Ge4iJ0y4EI+pP6aM0GYN9NuvAqHNyAPrjbCmx5GKtkiYMT09Gbx7BeU7pu+9aKj6MGZQao=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VFYehllgHMiznrH9pRkNo7V087YJafRJRt6W6Sy1ui2a/XEqEt9jwPPfINxwVzyVnmU37mBQ3h5bYhJoV/DyPXpgMdYM2VqkgrhdnDJA9RFrJqcgUFhfPkHNdBayX9uBSt3K11BLwHujPnsN4i5+bQySdZOiwYGRHC+EH8lu6k77+ioMWbheK0Jo4/wRjIaTQro2PoR85Dad4zCEzO60ett+9rCPo2wxitySljya/fyx6StL6xy8BCMgWPPJd4yLVNosAr+hvansa12t/es3hi6FQWiBFjJv7VXrmxbqV16Tv+9iDyi4Am1nyrkB+ZBqr7zLPT6odvKvKKjurQchfZKaDhLyLZG6ksEQOwzOlri7JWpHwPapojkIQ6wglX+OJcVdKiQfsZ9pk3wR4rHxfKLajnyBl5gPAwUrPUyMFNSNm2TVYYEYGDa+mBx8iuWn
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 00:14:21.5864 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9608d467-c9ac-46f6-a536-08de904cca2e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4381
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

From: Randolph Sapp <rs@ti.com>

Nitpicks and fixes from the discovery thread on adding PocketBeagle2 support
[1]. This does a lot of general setup required for the device, but these
modifications themselves aren't device specific. For those specifically
interested in PocketBeagle2 support and don't care about these details, my
development branch is public [2].

That first patch may provoke some opinions, but honestly if that warning was
still present I wouldn't have spent a week poking holes in both the EFI and LMB
allocations systems. Please let me know if there is a specific usecase that it
breaks though.

[1] https://lore.kernel.org/all/DHHC66BBMD27.YHGIH43C6XBK@ti.com/
[2] https://github.com/StaticRocket/u-boot/tree/feature/pocketbeagle2

Randolph Sapp (6):
  lmb: add LMB_FDT for fdt reserved regions
  efi_dt_fixup: use fdtdec_get_bool
  efi_selftest_memory: check for duplicates first
  efi_memory: nitpick removal loop
  efi_memory: backfill EFI_CONVENTIONAL_MEMORY
  memory: reserve from start_addr_sp to relocaddr

 boot/image-fdt.c                       |  5 +++-
 include/lmb.h                          |  7 +++++
 lib/efi_loader/efi_dt_fixup.c          |  3 +-
 lib/efi_loader/efi_memory.c            | 41 ++++++++++++++++++++++----
 lib/efi_selftest/efi_selftest_memory.c | 21 +++++++------
 lib/lmb.c                              | 25 +++++++++++++++-
 6 files changed, 82 insertions(+), 20 deletions(-)

-- 
2.53.0

