Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8F8CD4F5B
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 02:52:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C52EE848BC;
	Wed, 20 May 2026 04:52:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OgvSwvEx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70902848B9; Wed, 20 May 2026 04:52:14 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCF53848AA
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 04:52:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tN1OFNq6OAwl3f3YX4PQBA/OZHvrKME28dFmXjiCzLtL10oe8/vkUUrAG5q79Iz5MNuuOcDEolLHQTWTbbGDAagijxlPnn3vv2b9PPMJIgvBfBI2XaHUaVJxOC5q5/qr73AZCV1YrRCJPUbpxropl7+Hwh0y5Yyn3ZhklwQq8wOgS85fOxKQtunjf6tusWAqrnCIlj8Zql3xvW0di1KOIeF+VcNDcXD31xS9UxuH7UJXFyd9vRNNIsM4CStNzIOGR+vTL3bTZfWnDrIsjOOhKSj1WuiJuAaJF0OwWbI1mHPe4X7CfHrvQFXZ6A6p5dek/CjHcoh9vY+Eh9vYEMpDNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oy2ZpWYkKuZlrhmKY+FWPGGUykfe6YVAxbfNVW8XMu4=;
 b=NqsBCxKH87tGLPWdthch6UplT22eiBf9X1xO8o8N4e9+SalvOWRybanu6fQAvaO3K9p2Ut8dGuzQgGtLjA8hfT+VV2rrVKfRwejkxajlzSt4VZop5jW7lBSpOeodkt4KaoLvMTmHUSni4FGCA8tMCsq088uNtafSPlHQh0gbXaiKWscnS4pTzmpVEZ+0Am2WkR0/U+ChzhYd2RVLVdcksZIuaaji61/Uu1VXsOQ/auuTr/2jGNpsFQFm7Je+cml86utFhf0GS5GQ2dagzq4gtuZGPtfc/tTA5gMx0vcgiLS82VpSu0RKCXJPp5gCTEl+pAAkk16WTwguqtJC4JWN5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oy2ZpWYkKuZlrhmKY+FWPGGUykfe6YVAxbfNVW8XMu4=;
 b=OgvSwvEx9RG605MPHkuxaIJHzE3jxQSXhZwTk3ifwf7v2beeYH7bvtty5OFbAHVWxpXV26qtH5jgSypuUiloBoQhfE7qK1jPFnh6rQYYOEcjg72rKsGeOOhRlmXL9XsX4dJF/s9OIqs/Ba0jtd7eIAjgbmzTLftAcF1eLcCFcSc=
Received: from PH5P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::16)
 by BN0PR10MB4871.namprd10.prod.outlook.com (2603:10b6:408:128::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 02:52:09 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:510:34b:cafe::5f) by PH5P222CA0005.outlook.office365.com
 (2603:10b6:510:34b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Wed, 20
 May 2026 02:52:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 02:52:09 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 19 May
 2026 21:52:08 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 19 May
 2026 21:52:07 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 19 May 2026 21:52:07 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.72.233])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64K2q6CH570309;
 Tue, 19 May 2026 21:52:07 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Wed, 20 May 2026 08:21:50 +0530
Subject: [PATCH master v3 2/2] mach-k3: enable mmu after reserved memory is
 unmapped
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260520-am62_firewall_exception_fix-v3-2-9ca3dc40aea4@ti.com>
References: <20260520-am62_firewall_exception_fix-v3-0-9ca3dc40aea4@ti.com>
In-Reply-To: <20260520-am62_firewall_exception_fix-v3-0-9ca3dc40aea4@ti.com>
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Mark Kettenis <kettenis@openbsd.org>, "Patrice
 Chotard" <patrice.chotard@foss.st.com>, Moteen Shah <m-shah@ti.com>,
 "Beleswar Padhi" <b-padhi@ti.com>, Wadim Egorov <w.egorov@phytec.de>, Chintan
 Vankar <c-vankar@ti.com>, Suhaas Joshi <s-joshi@ti.com>, Anshul Dalal
 <anshuld@ti.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779245522; l=1576;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=51OnXWlo4eTCUxrXn7Ne3M3MpnCfhHD7y2hVtxV0pGc=;
 b=6ru4iMXEnQ4ppxD5yxUH1EbE0bcHMQijYifEoovZHGNZKJi9doir1eEZv7ct+YzHvYmDAO1PE
 y4jdv8zCfcTBp3ThbyH2O7pIkXkHiqno5WQsufZ4etJNmVL4s6sa5fY
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|BN0PR10MB4871:EE_
X-MS-Office365-Filtering-Correlation-Id: 8018d3f3-8ccf-4a36-b60b-08deb61ac90a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: ZyxKCUp9ZEVUW8IBbYHO/WUF1S9g0/oDL+LHimyXaR7WzYaoeUh0JikUbzR648zu8gvFeHzsXyNFrhymHx9395O5m/uGhLZjIll+TJ3DffrAy+YYgj1dzLvoED6VhfTO1yhqN6Gir3iFleaE9c+eQSbyf2nbkZpbJYdoMHGSeXoV1qekVZpVH+MXOGLktMPLbMFcsiv6c9qI3mgYIO/xPqZZHqrrzyOGkVfDZEqYUYJp4DDf1liUZayEx6+tWZoGUgWwHY1j2I30Bf2QrrXIfoSaopd2Lr9UJvlFU4eCUaaEQzBmkJWxiCu9m67bao1E10LOZBf+GVHW9D6KCf2hV6skhre9bFS7fZCBBhZ0626+sCA3iSNK23vyardduUS2E5HtEXmkdy/TTTS1vCpdPqkYeoYt2y/v33lnUvQReo+wpjggZmgCACJBE0uLLkNcDByHYf28gUSG6Oo7FiSpaNhYBhHMqfvcMWj3OlzkFLwU8F9UTSnRPHfyJ8HIOMY3GLUdi7YHNB6AbBFMb4G0U+QYgq5esQIcRj3QImT335M5x3/mU2EMUUw6N0sEa8oTDtuMI9mrVoD5xo9xreBl6vOoJJUIalg1To6OmSZAhd7REDy3b0hIm9SEg61eoVvuKGEOjcUnneae2IjchLItMy8Z7FYysFYdhlS0FWAcOCMYl6sbdSpOUVsgtQbftXNP6LN7Et4CYdqf7Qa047j4YloXBlvvnaN8UvuNuCYQm8s=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bUW93+DUJCwwy9MRMCFeGc9suhl1KPMOGBucpY+xOayV8qiyGUWnPTg+60Zm4nJorqWUSg8SuJSPA6K0VKdD0qfPua5xZoTi8XclVrjgn41/mx6jrKdUsTk3gcl+SWTRuuEteXlM9CVxb6o2FXR4yLpH+1enlAZF9lcd+iSh3TJCTOtrZwHVeTfx2a4X8I2mPwsz3IDYoZkq1cKeUA0LLfXooYWyuqqP4daIg5nQ/+ZYlwvQDHQcG33dV9XmelvtgzgCDfIj51EttIn7HFQnZP59ZCs9L8z8BB8fX/uHI6hSxRTB4aUKr8RqMT7jQF4UDVZkPSzpD7DEhidM/UFGmdLEwOdtqS2lv3XBado4fXQ98xsyChsPDHUHWSftlIwN+7DcuhADD8G44m28j9NGwDrM7rWaQcEleFvkUDlBTAxdcd2ksMKEXBtGgc30t+vB
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 02:52:09.0669 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8018d3f3-8ccf-4a36-b60b-08deb61ac90a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4871
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

Currently the sequence to enable caches for the A53/A72 core on K3
devices looks as follows:

 1. Map entire DDR banks
 2. Setup page tables (done by mmu_setup)
 3. Enable MMU
 4. Unmap reserved-memory regions
 5. Enable caches

However there is a brief period of execution between #3 and #4 where the
core can issue speculative accesses to the entire DDR space (including
the reserved-memory regions) despite the caches being disabled.

A firewall exception is triggered whenever such speculative access is
made to secure DDR region of TFA or OP-TEE. This patch fixes the issue
by re-ordering the sequence as follows:

 1. Map entire DDR banks
 2. Setup page tables
 3. Unmap reserved-memory regions
 4. Enable MMU
 5. Enable caches

Fixes: f1c694b8fdde ("mach-k3: map all banks using mem_map_from_dram_banks")
Reported-by: Suhaas Joshi <s-joshi@ti.com>
Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/mach-k3/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index 396018b7a7a..19a6e24f38b 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -279,7 +279,6 @@ void enable_caches(void)
 		       __func__, fdt_strerror(ret));
 
 	mmu_setup();
-	mmu_enable();
 
 	if (CONFIG_K3_ATF_LOAD_ADDR >= CFG_SYS_SDRAM_BASE) {
 		ret = mmu_unmap_reserved_mem("tfa", true);
@@ -295,6 +294,7 @@ void enable_caches(void)
 			       __func__, ret);
 	}
 
+	mmu_enable();
 	icache_enable();
 	dcache_enable();
 }

-- 
2.53.0

