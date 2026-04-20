Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF11F5A8B6
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 19:26:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD27284380;
	Mon, 20 Apr 2026 21:25:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dDDTl8P+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F407C8435B; Mon, 20 Apr 2026 21:25:33 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D86098432A
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 21:25:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZvcEgWcJpd/af50cXLISH54Jbo/1ZWRNH+yAaEHNVAST0d0o9Al5Mxnom7hIsrrKb0qHHuVKwCtK5Gelc3wGX0ozUFCEP48fFJ++/XGhbupxXTjqfhJJiApaTgVOQhiP/spVVfrT3RYuOK1HuwiL1UrIsTvOCkqMKVcLmncPmh3xWHbcd1MiuwM3Um8I2FSx/99EhzBT/q2HlF3DbkLq133GbeC6jxwnu+ytBI5VTUOh3VM/qhmDTSVq1eDYxqKGfd+Yky+TNWiLbD8gCz+r/Az9v9pTg4lp6nNmx+J1mJ2LXYUmAt6MC+xboOEkzyeN64fXkRTIYSxmTgT50fXVmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1O0sSC93B9UVD94Q1Ld5tJEbvxV4r9C0QAMa3h9DKM=;
 b=zMB/i6nzbOKJQ04OcIFDBn+rbfMufeN5Lr0HSiB2+5941qrjp14gFDmBjwjQhszI4w6q3q70sNIJX2kksGZ373coZfRZSqvXK9jGWBH1rdRpgyLXxxShIKxvPJKYJvMkt/5BsjjqqYqnqSTS78/qorrCvZj+8MPJndpO10qXUjeAPKwddybZZZHog/w1MUwJBYvju9Rfm+YEof81JJeGcO1CPi8Z/BoDRVXgwL9F5oYjUVid4L8kD2NehoS04un4wpASPVRkLu5nCgLuWvfxczYchVNBY0LJzgT6z+udAkfR6TUHD3bZXLUz4WDkOGA/lVOvzuyq4fyIEnqgT47cWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1O0sSC93B9UVD94Q1Ld5tJEbvxV4r9C0QAMa3h9DKM=;
 b=dDDTl8P+PjzxldevXKFOAa6aujeRGo4G7HTcRzg6h4AO48o4tnrUPWpNR6KB4yIWviZQlSXuYQ6MwYdWV/asHf+D9V/acwqY/B2k6EbnpFkPz2xxDHMZjuraP3rAPIiKSUHzB4QowAZ/dTN2qKWER8MpEYLG5Tjy04BflJxXO80=
Received: from PH7P221CA0073.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::30)
 by DS0PR10MB8053.namprd10.prod.outlook.com (2603:10b6:8:1f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 19:25:28 +0000
Received: from MW1PEPF0001615C.namprd21.prod.outlook.com
 (2603:10b6:510:328:cafe::fe) by PH7P221CA0073.outlook.office365.com
 (2603:10b6:510:328::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 19:25:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MW1PEPF0001615C.mail.protection.outlook.com (10.167.249.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.4 via Frontend Transport; Mon, 20 Apr 2026 19:25:26 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 20 Apr
 2026 14:25:23 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 20 Apr
 2026 14:25:23 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 20 Apr 2026 14:25:23 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63KJPNh63399024;
 Mon, 20 Apr 2026 14:25:23 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv4 3/6] efi_dt_fixup: use fdtdec_get_bool
Date: Mon, 20 Apr 2026 14:25:17 -0500
Message-ID: <20260420192520.1444749-4-rs@ti.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420192520.1444749-1-rs@ti.com>
References: <20260420192520.1444749-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615C:EE_|DS0PR10MB8053:EE_
X-MS-Office365-Filtering-Correlation-Id: eaaf02c0-e035-4a85-23c4-08de9f1293be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: hhiXeoHOzvittMcmi1Ivy1cLt/BjV7LgHHZCz8e5fkW0c2pQ1eQukuARaHMHGUgBzufKLPPApUtu84Kq50bvLs+ClduIdxJIR4kUmP70jPrBNyQlHJEHz2Tw808xXC3lv+p0Jk3r7xA+EpNwsjZEh7I3QmEvEwA5xTKAuS2tL8HJyGmKIq/AXAX5KoGr8D1Q4ExgZzYjpy1wD7mVvlK+k/kEc3yjCV5Pxjx3wZ3g/z5hDemkbPxGMGj2tUpwB819E3cekKarwZi58KnyRzIrkAMbBWdcVzQw/R0nZwjDWvGEyWrc/NHRCf0Gz7/m2a2bJLcKWtwa8Cwg7VQEg1y21/e6IUCXWmwI7xj0T/FPjR0k9rdDtusDZ0OkzmzDw6RjvL2TFgI5jSBYk2wkog+C1W6+IlUJ2BuBZCvpBskSFmUyaPGwHHyOtTYJs2dxFYwr7rQg2l5lkkwU8nDZfDKRfiF/7YIrJwPtx+8uYqLkeRIJ0wgORYOOTyU97ZFnw/SIE9w3z67m6O1QT18kz/MWLnomEjKLG57WqwTZ441rkLUuqiDv/mRxt7dUR+WdP1fpMPHbFO0aZxh/JVYttRUkDrpPvJnic2vS1mXA1bpR7TtzlHxs6Hysur8p6j5JNCbv8a+k0sGMPexwpBlAxDIgK8pHwgKimUByHo8vK3tEF2KxVMn83wFI+rCUWlDVLJT2FqMR/naO+ADvzDOL9mSepRvs7DHHZ8/r7tPxpna2ivE3AElNziWgFRHNLXbcmA4fH/XQ03WA7ymqALgO4YVi1g==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PhZ+1K08f9iUfMwsmqCXLNYVqvbe8Bzc+gKGDi+jShpgDQxihPgKm2PpI32JEVEdK/2rGoSmBFeLf3NuAu4qBpMv7J5IR5MQSQD+sP4KWLq4Zs7Xadg5LFkZ2t1XrwwiI2AFAYOefAOCldqUc+K5zjLuJWqaFc7yNPKtScAAIErMsVKWJjxZMNNtKMiDNBIg1EpQrGjguIrd3oc9sXkt2NObsAEgNPwa1kQcHl1JG7uvs2YA9yFlwEFLfl/UTa8OUWeq/YSfTyk4358tmWP9PhZbVS7+nEVsP/DdKcZLvW69V3hO9MXunKJady+FGeRHj/Wopq7qECckzLdcqR7Da5H/kSigYZWKQa9/ajXUZIZvEPmJs5MyXB39Qc/h4lc4QhEjj/SD5Y7v/N7lIk0OT2GEGEhHG5rFetD7WrNlEVp27ZV7RU2bI4bGdAR7oEau
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 19:25:26.8783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eaaf02c0-e035-4a85-23c4-08de9f1293be
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8053
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

