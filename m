Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E19FA1FD6
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 17:11:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFB4D84413;
	Wed, 22 Apr 2026 19:10:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="j7zcRT1B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E56D843F3; Wed, 22 Apr 2026 19:10:16 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC7E78439F
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 19:10:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ilXvWB0iqdGbylPE5GxDQYxZiAeQ93L6g31vTk/k6iKoXZFBB/vlVc906XXNq7pTEyMEiKwM5SrEF4ux5nmOqGMeoFtg97MSL7WqsJ/s4ylmN/xM8S7UmQAOqLZM1hG+JI8830FpH6Ai1kSi5BxoB5c2NuAAFNOAS7+T3T6O7Gzu+78Vg70cO65IFXCq64h70RpmFA9aoPKO/U/gqUx5Ewn41uU50Doo7JuLpEXe+CYgSMZgRaTv84wtzb26r0TkmIT1RAWuCfRNOocb4EpnpUMiB/yDn8m398Uv4+exQPegwAKvuqbtWJbGvco2gjsTTs3mm7v418/3/TyTjyCMVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1O0sSC93B9UVD94Q1Ld5tJEbvxV4r9C0QAMa3h9DKM=;
 b=ByYVLNIJgHFyaTewJ8coCCuQoVu4TEcG60Gav3jjE616K9ugDEn50GZ2BJkIMkjTOfszVptHOY0ypmGYtEPJZi01BSdugVjEHK13Nquv8VOzdK9TBo9gd/ujb99n/HMa/oO/5ERy+tV6QNNGJIiguYtd1P5r4yGO1okUv5F9DUYA4fkpPjpM9rhc2uadnGQAeyVvHpODOOVYTGf6BG4nxwF/xwp42uQwlX2VJERSOR0H7TvQHkrtw9ANxMagNIZv1GNj766fCf7ashhl1q0EvUCfpOnw22sQ9o8PFhqlOod3x09mIGrenIof0F+GZa0N8OuzDYOgDTI8LKE9wO157Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1O0sSC93B9UVD94Q1Ld5tJEbvxV4r9C0QAMa3h9DKM=;
 b=j7zcRT1Bjqh5MnOllKOvq86yq2Pb/FcLUxa1PkTQCFWbDlufQ6X9NdN+DYPhFfj/KLlvcMoE+2qVLZqLrO21zd/95lO28G9nJmpXJvYO5bH9fuPG1KGNIo3HRtalKGx0I08KC3lcYUFfq/JpaWxbJ5rQwpCijnbNhlFFbKkaZX4=
Received: from CH2PR07CA0037.namprd07.prod.outlook.com (2603:10b6:610:5b::11)
 by CH0PR10MB7412.namprd10.prod.outlook.com (2603:10b6:610:184::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 17:10:10 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::c) by CH2PR07CA0037.outlook.office365.com
 (2603:10b6:610:5b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 17:10:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 17:10:09 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Apr
 2026 12:09:57 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Apr
 2026 12:09:57 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 22 Apr 2026 12:09:57 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63MH9uPN2769561;
 Wed, 22 Apr 2026 12:09:57 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv5 3/6] efi_dt_fixup: use fdtdec_get_bool
Date: Wed, 22 Apr 2026 12:09:43 -0500
Message-ID: <20260422170946.3394481-4-rs@ti.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422170946.3394481-1-rs@ti.com>
References: <20260422170946.3394481-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|CH0PR10MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d6d9ed1-5c64-4408-fac5-08dea09201ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: +uM9p5CDI21TyRulYKAOAzKTo2mKDaUfqzTop9B86gYRHby3KKmKZplm3AoLiWmmylsv+6iM44syMrwtPU2xIrxXcZAqpON9olqiba1E9swjB4Hmh/IkcT2VvLbsS9D0aGkPAUQGAvIda+wXBNKvGaCBGnFnaAp+rOkDQLWCzwHM+m5rn/m7iXygJOZruVlGzgoYCYNyhX8fc3NrWNahPxCfpSGevpYE7YET+DgS6FhvqTMCliByCkzi2hLbAdZfVMEN/iyOXg7drba9hZDisfHJtNCXJdSMn+T0f46izDvFRPbVxjcUuSrpGMjYVjH3q4/imOHg1DHXQ78MkSxdoVO6t4diB6rARaZPCTRyAHTmFKZnXrCozpEUJ1T1QNwDiNr8Ddan/GJzgKlBKKDBHnXufnE27995onqKmCJhJjRdu5OhZgxTVyFb7h9XEE+JQsolGath7qEQfXtazCuIo7SOYcN/pel3YR31zdO8qNPeCqj6U+wVn/XC5zw4tGKDPbSlWiKcbL19x/u7hfqDNSzUicsXKRNxFc7FI6Yd4fU0833WrZ9a7I7s1yOgT6fHdwleGkZUJYltT3aYaOhtwm6bxDKg+jSiwu4RF9lCmAS0eHTEf2WF5BnhRHH+PPj/5wSPm80UJkvEo4k8PEXYwxZrp3i4Q06QxCR95b2HU2xI3BZgOWM8kmn7DFZyz0RGxZ/BwNdvkCAp4og+k+8CG8zJlN/Pgs/5IH/g3AhNFM6mf4MHmpMVTX2CDGaoXukidVWl18MBhDTp/ClwLPxhag==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iBpBE73iEtDp9pweDFP/QXa2ldnGAx0B7Wj+wBkPrwYDN9ZdfCY+JKJQ7M1ksX7SwWJs+EfMZaWaoKXwHQwVz9pfaEBIJ1xIp4BoXg1h6sPIoiQrx5V2h2T8lXV8//wWBrZaWIZLEhTmO1IdA3s+n47c41CseVOG76JH6gaCQMK1jHDhyXOdf0lS2657R2qGCSFDPG7tfHeFD5K8x9rSVl1UFKbjiiOhR32beRPpuf95QCBwXgmGpNejd0P4579NAJ9Q2+0/rH33918vUwizIPgNBZaHIye4wL5hy3uknisBCLDZddAj8PvBXYy2SDDXG2eLPHm8pXGDhAu2yFc28RuN4i70EFsVfQLqWmCasEnhFhEcpk/YvzwJUALL+vgc1eycml/A3xCBuMim47BKZSVi9hIoqzEwaxwx84//xsyhACogO2mK6tZ0XwrhtBx7
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 17:10:09.0300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d6d9ed1-5c64-4408-fac5-08dea09201ed
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7412
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
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Anshul Dalal <anshuld@ti.com>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Simon Glass <sjg@chromium.org>
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

