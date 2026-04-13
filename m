Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DBF2F531CC
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 20:36:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22F6283DC9;
	Mon, 13 Apr 2026 22:36:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pxX5VwLQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 755F284199; Mon, 13 Apr 2026 22:36:22 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23B54839DF
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 22:36:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X0cdRciX/9M+oqFEJXzNGL+A869m5MfcuTZusU/Jx86KQEYrPQQmE78rIhuSaJO3BHZ3+VNUzDTSo0Yfi62+SSfhOkIlzYTcWZ1GMDNnSvJKA/lTkhyyOVpCt09KwTaaNkFLFjoqRURSQoNDXSnEIGCMkGMj5y6d7+H9AYHFh9+KWZQzGvqqpECJFUcgQWsEAau/wi5G+jKnIlIpBE2uYd8GvIMW5UoFQfruwXwr179usrJ38Cd+6Vkv2qnIvF3nQ+v02o5oKfb3JSp06r8LiFGxYJKyq9XQTuRgqW87csvxnC0HIWIFxLStvKpVC4/LtQcCFkov3sAdyDiFDRkDJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfYJVoZHhxvyDVmGv9lwcDKJzRLIxluEWHmIYVuz5f8=;
 b=M7fxkyGZ+uoGbJ44n4UNRefLHyG+i/ioqWfbD1+vRIiDqRni8CQTYSwZ/Vmz7KJEp4LzrPonPlm8e13WF9EziOZm2bb8EZ7va9C6bIqPRkCXlPMdHYo5D3tONAFOj8IDyXhaLQvYv4R4C4XEEQ9qhauGEMk7bnjovqxVAaDZpu8EA75rf1uIITYN+jXvWqOuigo3HPd2uD2rPqLTJDODdiWvqDzwZqS1A36mjvt/sixxu+ZaPpzc6QLuwGFQZpUlpeCmR+QVEpj1qCPJ9xopB7pTv/ZC1zQaqDKcxPHVQORLb6ZvUpBhGm3TQnHDnynJ9a4/67OsRj/RQJJ/wH/oCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfYJVoZHhxvyDVmGv9lwcDKJzRLIxluEWHmIYVuz5f8=;
 b=pxX5VwLQulgR1SezRBNK8Qs1ku1gv5KR2sJPobJEKAxAZJa7oh5UV1fyltD/Ra0GmWuHb7cytVCfIZx34cmiJ07yoOiWoS3pFeW7JalkoX55X+lbPmzRLnN7KBPoEGfAWzuSY1ooxQ4L4Aa7z4rpSrJ0KQCK9uxff6puf4WqUmY=
Received: from BY1P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::7)
 by DS0PR10MB8174.namprd10.prod.outlook.com (2603:10b6:8:1fc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 20:36:16 +0000
Received: from MWH0EPF000C6192.namprd02.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::e6) by BY1P220CA0020.outlook.office365.com
 (2603:10b6:a03:5c3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 20:36:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MWH0EPF000C6192.mail.protection.outlook.com (10.167.249.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 13 Apr 2026 20:36:15 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Apr
 2026 15:36:12 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Apr
 2026 15:36:12 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 13 Apr 2026 15:36:12 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63DKaBsd2729634;
 Mon, 13 Apr 2026 15:36:12 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv3 3/6] efi_dt_fixup: use fdtdec_get_bool
Date: Mon, 13 Apr 2026 15:35:52 -0500
Message-ID: <20260413203555.1990337-4-rs@ti.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413203555.1990337-1-rs@ti.com>
References: <20260413203555.1990337-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6192:EE_|DS0PR10MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a86be09-2203-4d02-cad0-08de999c4ef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZtIrtKBw5qDqjpz6fGSUDTTsMr+Upt9O1NTeus9DxR8ijgVwqqEZZfMC4Y5431Viqc7E1YGv3b4XjgulzSkEYis192CjYUtMuE4XLLYHfny9CouOr01tCWplF8vf3c/D+ngUUeCmOaPJVsKNmEDgjrGMXXe0dVMabMDHN43/3gLGZlPm6Fg/JifpBzJCA6ctrlTyhykxviPFwK6QUmEtPGNtrRoOn1cYmTBq8bd/ONPMu0DtnpJSUwVWjnzbKA+vAz9vFm9OHEGKiNWiOi6FExk6GOZfDWxVenDqVeP/I/bAy9GS/S82NKuxc5mW8+KotC4mYzQBc1GLh6HWrgyvJtJ0AryoaMFzpJe+E457IcYvZ3xvL5CM9mzKInA4sQlV/Ayd2ZFfxA/vCvWe2uExDWEals3F41GPEydcvkh1v6e3Dw1jJe875nofzcZMWCJFrYu3we4XgZ0Bn+eyseX5ZTtWFD4k4ANrsFCc8/Vu9TD1sND1vR4xSZfokgsu8qb0tNyqcn8OtdzL0rxy7pE59OVQnaFZQ05HRVbMhT6+MzgxROGl5H8F/8iKrHceK/gwlWD6jZGqtx/Y7cRvgIR75oXh2vlTrzoMaAs8TEx19XQr7SBV5cRV/gtmNRQskOBZD6g77DcckB6Jj1+DPISg/+Cqbi9Ib+Ipxrls2Usq/WqKNOJv0LNz0fw5GH5SK5azJdwBIDaWbPmpmcWjNtUqSMgGHg034V+bEuYUhdQeIDmAzcOtLl7Z9bClTPVXfCc2T7quxWUUaibfFp93hzbspw==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MM8aBwhQjvE46blWPxDqr8EYXI876AEoB2zSY9MFwXZAXaicxHqNjKw1OfuUSsoqdF9QC4o8pW+xX82MbcanUCl91GD/MwJUJQuVzKKVMi0a2MSwr2wMdkfsSj3lGwNHzwaJc0fM3R2JTVLF4otkd3I/4l66AEweW0gHPXmRQxvOaI8rYjOwjbTmFTrCrxsbSj55+NJ8WLyVvJdLl2oHcPcFxJLk53twEFG+9M3H+WB9p0Ydng5D9ALkouQNEl8AuFM00B4dkO0Imcgu9TGUF+Rbm2M9+dsTRDMzKzfBqaOI6YXxIbHC32B86ce6JAbAk85NUEz1mK+Acss86/KZYHBSxXmDEG/v2fal0omo34ToEj4y+YOry1u0o/aQ04XSf4mp1gHmH3uAb1rySDCwX0EBCI4rkAAbZZmHjB9jgt/c7CMTmYR+PEc9V0LpXKNw
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 20:36:15.0705 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a86be09-2203-4d02-cad0-08de999c4ef7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6192.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8174
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

