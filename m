Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861BA1112244
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 00:15:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3F9D840F5;
	Thu,  2 Apr 2026 02:14:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZVy9oSru";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1500580212; Thu,  2 Apr 2026 02:14:33 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F185F839DF
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 02:14:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JkzKC4sNxL4v9PjPAKXJQyuX3qnI655voJMxq32698dvwMxBe7abyHDbxfCPQw42RIog2mgffvCaFbaLgMvM1JYPYx1KwqUjC/EAnjmqlwUedWsPaB1Psaq734jrn4FBB66+0jiDPwg1JYRWODp8T/Q3ytA7SWZxyTpC4P3B4JocHjdUEfvXqKguG+HojmogD/lnlP2DIZVJJCPEbJZCqvQqYH/70LtU6/CiGP+upJMFSSW8ito5YrXGuo8J5yrds8fLiCzVq2YFwysTM8NtHF9knPcot7t91poQY29PL6cK94Bm1FnsLMqSO1qddosoMP2B29xP5HkJl76RsxojPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0JmfRwFk2njrc8sCMXBKKS7zsoyFcP2UD2r3dQeG+I=;
 b=Qv+n6tc6/QhkTlV3yqckGqJb/6Fe3LWEG5Z1HMm+X/Ap9iL15qb4YJ04Mh99ykz5HHWaI4+URxgn37EDEYpdbYmjTbc8jXrOj2lQNf/5qDBIz2uqx+/4+5Fm8fbyQYezxDleny8sl6b+GQ+Acq+xBEmNxrmoHjcUYgaReTO5RxrpE7DdeL6BG7XHme80FqdsfDMe9A9+0LxJ3+gQZBTYim6lByBTqmoEZQQAp2Sp1ZE1jZ8PFwAfMaDrg7YoEW5Oa/tCaczKww1UHcHdAARknIIzZeR7F+NjZcTQWvcLhjhMCAqDgWJHy+EoE23ttdNaKwqwYa8GdjzvaWUoP01jIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0JmfRwFk2njrc8sCMXBKKS7zsoyFcP2UD2r3dQeG+I=;
 b=ZVy9oSrunR1Gq10S+89buSJD7jfuVF/TZhxFrj9UK2zxla+ZmuBGq9luYVkTFSAFEcyJtTzbhs77bewaD0W+21zRoyIbqiALtOQUlvZ3tSVWSnyYlHxzAlIRv59edoFgFsnWCFt2d1/9R6lZGHq6JoF9kD2VoUMbJBuXc7jjpng=
Received: from PH7P220CA0082.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::17)
 by PH5PR10MB997759.namprd10.prod.outlook.com (2603:10b6:510:39e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 00:14:28 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:510:32c:cafe::61) by PH7P220CA0082.outlook.office365.com
 (2603:10b6:510:32c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.18 via Frontend Transport; Thu,
 2 Apr 2026 00:14:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.0 via Frontend Transport; Thu, 2 Apr 2026 00:14:27 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 19:14:21 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 19:14:21 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Apr 2026 19:14:21 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6320EKsG1004385;
 Wed, 1 Apr 2026 19:14:21 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCH 6/6] memory: reserve from start_addr_sp to relocaddr
Date: Wed, 1 Apr 2026 19:14:10 -0500
Message-ID: <20260402001410.3736815-7-rs@ti.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402001410.3736815-1-rs@ti.com>
References: <20260402001410.3736815-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|PH5PR10MB997759:EE_
X-MS-Office365-Filtering-Correlation-Id: ff68787a-458a-40cb-0f6e-08de904ccd73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: vz00xvI/XNmQQLOYJLSil2N631oPJyS/nOs1yPoKtpr78oUBE/idGTYtAZ1OuRa6gi1e2ty/z9I5IFu2KT8BChR10bN3QuNmtTHLGqemLwc8lm24vX4DSs4PGUqPhm77TNKyrMNtK1x4U+5teBLG/wcas4YAlBBdZGTctXxfs3FSIzLE+dnBarcA/hmSGW6Uk0+DShF/JCcHbQ2Ax+VrZgyL+KoFogoxIct/ENZHKn54ugs5W6rbmzpds6gV2qTi1xod7HgJslNeZs29sywJDgHnvWbPKybgWqn/SiI0d+mrmvabtq98oLgdlprJ0QhUH38YcqmYwRSjkB6ZkQKmHch8hIyFfEpDgbMy0ZKnOJAjPtOtWTRpIWdKhQSv6T18/JesAMTNH/01E27TlcQzApu547cG3fkBhLQhjSQdsUCoPeDdy/NKz7yAa5WA9AtVH9QFMsBTNFcjs4tRBcDsJgBbosJ5AUtdJbdiM4nXi6JP1nFgh009cZJ56QtuOBRDLDLpeJlQ1r3OZjqkhdTdKt33Efisvtl1ntl7LYy0WKNosiVtFQ3NsrYzwEMJ/fiujMlZ5+JDuIJnNZOHVewKXnCio8QIVjqFdvxmHCZGydfZ3QzCBMl3vuQtAv9hEpBqXG4F2iWO7uoNUH443pp+D1Bb29CpEFsd+OYyoNhJ3jdneIZt9Zpymc/N9GS60u5f6yQq14EIrYK1R0fAxgK2OP/LOhR7Zsz95bRGd+4cewzPfemoR95myU1gvsXDUk9dkUFr8IQoeuz2x/fstkyInA==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qzgPx5FwkJUZoB9qphl3Zar/4f/Moq1JLW2Y8Am/xsmiqlhMGAxP/UM1YMO2+bug/8b9eBidAvclI8EAgU0+fwtsuKfFwPhAlGxoNXQSO5TuqaKR5Kt7nMYCWi8Pn8WEwEo+GcigtOkU3Vp/oXNcKv9Pvh0LQMyuOcu8M7U61JlSn7SHtcE85KwRyoMq7YyZBv1oV3ns1xwgzVlLTXcBdNmR/8tVvX2P3WvsXDtE46sbHwe17FrJFlsvqW+Sv8ZHPCziYNhZw2PJLDNldRPPMi5tZugvJvjIvxkHaNvvM61CM834ipe6G4AKj70QVVc+7xPgmjbXXTJtHg/59uoQpZ6byZw2UJo1ysjzfxi/8LFjDbxh2YWZVCwioRxhQJFrL4S2/PJPnF95AtjaYQKZRiAlf2m/AO0Dlwr2QZAMmysTUwHqyJHN1i9c2xHTaYUS
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 00:14:27.0724 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff68787a-458a-40cb-0f6e-08de904ccd73
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR10MB997759
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

Reserve the memory from gd->start_addr_sp - CONFIG_STACK_SIZE to
gd->relocaddr instead of gd->ram_top. This allows platform specific
relocation addresses to work without unnecessarily painting over a large
range.

Signed-off-by: Randolph Sapp <rs@ti.com>
---
 lib/efi_loader/efi_memory.c | 4 ++--
 lib/lmb.c                   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index f07cc39b157..57691d15758 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -915,8 +915,8 @@ static void add_u_boot_and_runtime(void)
 	/* Add U-Boot */
 	uboot_start = ((uintptr_t)map_sysmem(gd->start_addr_sp, 0) -
 		       uboot_stack_size) & ~EFI_PAGE_MASK;
-	uboot_pages = ((uintptr_t)map_sysmem(gd->ram_top - 1, 0) -
-		       uboot_start + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT;
+	uboot_pages = ((gd->relocaddr - uboot_start) + EFI_PAGE_MASK) >>
+		      EFI_PAGE_SHIFT;
 	efi_update_memory_map(uboot_start, uboot_pages, EFI_BOOT_SERVICES_CODE,
 			      false, false);
 #if defined(__aarch64__)
diff --git a/lib/lmb.c b/lib/lmb.c
index 542bb11dcf5..0df8157db7f 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -540,7 +540,7 @@ static void lmb_reserve_uboot_region(void)
 	ulong pram = 0;
 
 	rsv_start = gd->start_addr_sp - CONFIG_STACK_SIZE;
-	end = gd->ram_top;
+	end = gd->relocaddr;
 
 	/*
 	 * Reserve memory from aligned address below the bottom of U-Boot stack
-- 
2.53.0

