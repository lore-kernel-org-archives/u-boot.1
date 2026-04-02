Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 537B51112246
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 00:14:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B37A683CE3;
	Thu,  2 Apr 2026 02:14:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hR66JU9Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2B30840CF; Thu,  2 Apr 2026 02:14:32 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD87583D8A
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 02:14:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5IHX3jNF+q+D66YQ+WyyVOKAxw05j2YoR9RgP8DvqV4hZDo7Ps/uMiagL1wKK4iSTLhUz5U6pyyHHSVa2fKlE+iA5U3Qq/jysevAaHT+zUjyUWfq4TdjDw+zpNe/Z/du/v+ZZUrVpX2iAymvmqx/7oBjMubz3tBQfWbwp+mW/FxG5vPQxaS2XBroYs1ZfZqrRRZbZ2c/TCA/x6iGIPBG9gXQu6Psta16+itBwrhxv/fimUt/+wM0Ii5njVrXvgEhqc2JFRpVwaHP1QI5GNAzmiKE4e6ci7uWtfFAYFV8gNWu57ujc+LwsbyhJ0PeNvj9YkkruXAhn5v2ojbcpw1TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8X4ZosKKjdfaQlkcQ6ETce3mJFBqT8XNG/0Z+Ii1HqA=;
 b=sAAIatxasUjfYBUd5H9qG7E0emm+Wfh7lJgZQKDHuziL1ji9fNATUDb+Eu1JjNQFwBZcj6Nv2QyXItcqJKFzBIKbeQMjONV1sjJ89ERIuTXiexMj1mYvcgpS8kuCk89E57XdPXLAjstrIzDdnbUnx7uMjgyYQmiK7CUb1Uxf7wmT4zjLbn/qpeB3N61ebr+RDkaWZajM8mCJWz3ZK3251jzT/TDhr0PwR7Xarj0BbF6N+yR0/0w/tEfQCcZlQKjod3yO62qdoXi82pKJzcODZDwz/RTEM46VzvM39d0y55Gd+tKNx+2DURzu5ym8k2vfr9VkXDmtYuKxi19QymrDZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8X4ZosKKjdfaQlkcQ6ETce3mJFBqT8XNG/0Z+Ii1HqA=;
 b=hR66JU9Y7LI0f5Je4cTUaoBDB+7/sYiBZnxHwePdVJLpG9ape6eRbbzrZVNbkYWcxBbbEyVsJBHRgEm9e0BCFTo05Zvzs9TsXDDTx9pclWyIs6A7psAFf3o1vJJ6bNkIMI/bHteDpPf4H+sI2TrQfGk7oPz4J+mo9MIwP6kQslY=
Received: from PH7P220CA0086.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::15)
 by LV8PR10MB7872.namprd10.prod.outlook.com (2603:10b6:408:1e7::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 00:14:24 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:510:32c:cafe::65) by PH7P220CA0086.outlook.office365.com
 (2603:10b6:510:32c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Thu,
 2 Apr 2026 00:14:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.0 via Frontend Transport; Thu, 2 Apr 2026 00:14:23 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 19:14:21 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 19:14:20 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Apr 2026 19:14:20 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6320EKsC1004385;
 Wed, 1 Apr 2026 19:14:20 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCH 2/6] efi_dt_fixup: use fdtdec_get_bool
Date: Wed, 1 Apr 2026 19:14:06 -0500
Message-ID: <20260402001410.3736815-3-rs@ti.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402001410.3736815-1-rs@ti.com>
References: <20260402001410.3736815-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|LV8PR10MB7872:EE_
X-MS-Office365-Filtering-Correlation-Id: e8daa3bc-f67a-4742-5271-08de904ccb1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: KnfXT0LT5aa63z6LDmhJffB4/ikB3aftF45CrSmO3+DaacfLOdGr8PqWgrp/C3uB+TGTi5c1blAJxBm8Jw3AzGMpF3NYt56E94VYFzXBpOAF2whuJqO7wJvQzYpZYh49EfoYNP8F7ycbOQaAU62/S1FYVRvX3eV7SScGR+vabwWId5fdJl/Z5RJfgK0CuLzHHgbF8634Z/t9N5ABvZXa+6mwnsN3l8oe+oTKc2Z50VScgye5PR9v3UkT26A3IVsyh+lfu4jwbMZbgKaMZBQhKRdEGpZczNUk4jvt8wPhO3QP+S22y2QQ1SUrlh9Rwwz7uu5WWjmaR/yJKc8C6HJdUQ4zf/onmc53XajoJwTkDOoiwn2n2D3mORlCFPxvXOPpRi6gWJoewADSnx/xRilObOWFSfDRakZrEYWg//V+y43aThzZIRaAIb3Z/+Z+ECguhWOEp60QXB1qaS2Zd1U7FU/IifcCGNFb35anryzffV696kuf5RMxtPOusvEPAI5IzSrCOSqocHmImLevO6Zx3Bz8jgae+0z4XZbZY6N1g0iWNZvz5Yte6+rtumBUEX/2AEltxCproD5ODhYmctHFYAy9EYfFl0y4ixAFNLri6pt8Alko1v0O6+aSv4BsRw999G2T4aoJZlUP0Wqp5+JzQC3j4TxOYDSsjKjOAJZ/Qp2aF2QiavbxCB9xemyuCWIQW52mqphpEVqFJYVQn9NNsb+Li4JjSOWxQpQyW4sAIgmibgOQZjnRUasOTgbsYv7tbM1oSKlRHli1KF8x4LmUMQ==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Po3uGagJgiCF0RgKecH0fzUAHvLkOzkEe+aAJD8OA8jdaVY8l6femHvqHKLuBP6IS1+3afb12YwBLTj9rjGuJQll2xI2lKGAO/blmfVKSm8e0CU7Wkfhiotl8tIuRFPthORKA2t0jsthhl0N1hj905ZhfVO9sdHaXNhVTUTIVs9cZG6iSgrs33fv9RKEb/6hFX0BnjkGAe7/U5Iz3YYe56z70tw3AKTJTxaUFYBikltSc6R7jrjWgIXFd2Qba6ugOsF+rUFw0TtzYqkJ6nFdFpEDeN4Q52vV0Z8Eitdt1Jkip+d0uPKZ10X88bF5ZF4FDuBUFRP9/JxnCSFEDhm+b/GlphMjYdqJSZ84pt0iWPZI7pE5Z1sClOleGwK6WWxVgZDEDTFxDXp2UBjSXa5VHW/irIUXLP1IQq75roCSPs82lUdTo8KiKiGUn3lWYZvk
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 00:14:23.1270 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8daa3bc-f67a-4742-5271-08de904ccb1b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7872
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

Use the more straightforward fdtdec_get_bool instead of fdt_getprop and
a return code check.

Signed-off-by: Randolph Sapp <rs@ti.com>
---
 lib/efi_loader/efi_dt_fixup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_dt_fixup.c b/lib/efi_loader/efi_dt_fixup.c
index 544e1aa9808..333711b9957 100644
--- a/lib/efi_loader/efi_dt_fixup.c
+++ b/lib/efi_loader/efi_dt_fixup.c
@@ -123,8 +123,7 @@ void efi_carve_out_dt_rsv(void *fdt)
 			    fdtdec_get_is_enabled(fdt, subnode)) {
 				bool nomap;
 
-				nomap = !!fdt_getprop(fdt, subnode, "no-map",
-						      NULL);
+				nomap = fdtdec_get_bool(fdt, subnode, "no-map");
 				efi_reserve_memory(fdt_addr, fdt_size, nomap);
 			}
 			subnode = fdt_next_subnode(fdt, subnode);
-- 
2.53.0

