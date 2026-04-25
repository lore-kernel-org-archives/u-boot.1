Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8449FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:10:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6924084309;
	Sat, 25 Apr 2026 18:10:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Q4dakRTQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77D148439E; Sat, 25 Apr 2026 18:10:37 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0937842CE
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:09:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from MW5PR10MB5737.namprd10.prod.outlook.com (2603:10b6:303:190::7)
 by BLAPR10MB4977.namprd10.prod.outlook.com (2603:10b6:208:306::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.24; Sat, 25 Apr
 2026 13:47:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RAkt/F8Rg7wP3CJs6z0cz7Amlt1ywVLIMsWwZnuXg1ojNlc80nZ/hrqPlndRkgb2P2PjlI4Q107Apy4Xu9U8JIg26x0DjCSjBFLO2+V2pltIi46fydkajYVJ5/NnHmrnDuV7b+P0xmgcGx9CBt60QvzmiK6Xy46HCyb7ctin5YK6gyoVxngNW1Oo4EWd0tsO5Q1lCTp6SkD/ybXXfAOwG3dgUt6uukwX4Pss0YnbyOeF6vhJwL2JEs9HQtGASpJC0ewbj0xWowCCPxxpOHlScmTm3TOcmizrbKLjeBgzKSAFyQvdLD/yJkXia75J4PD5kIdaGvhyRph6xk/uyU4a/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaTIG33rGJgRzmda9YCNjX2V1zPbe703Vt4u8X8G4Jk=;
 b=x28M8l3sJoNqoJhlQwSHVSffOZCyU3222yO7ku8b//Ies8+ZTVpCpIRI3U6Q17/lYBDuqIQVFsQAxA95Qn7FAB8LK8NFfcITdGZvIa5/O8LHzf9pN2rrd0A+lkw7gxDjNA9c6gjgSQtVz5q9RESo1OUSep5O/ydlstfaKEsFltpHEjphIoiUrlj8W/kqa9AF/knbgWUw9LYfIGkNY4aWXqtAw1lG0ScpvESr0IO6apPPdinc2Jgf1XVja78fQcn/FBv/E01hxkVoIQLOXx8yAH41o/c9cpTBNGg/eDJ4U8yrTnQUY4PMvoofjS4MC+pnePuemQWsOKxokN9EJA8TrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=chromium.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaTIG33rGJgRzmda9YCNjX2V1zPbe703Vt4u8X8G4Jk=;
 b=Q4dakRTQPTtHWWbznxrJX8yMVNdlhEKNr1NsJzAVLHqwoNg8ZFmXBjJcv0TVhH3ncJLI1L3s1SI+EUL9UV7yB/dQCISKwz3xX7cAUmDPRgC+DrnIn1KN7p5BM0f8yuqnhImlZSWUy0Ei03zQNfZPjyPjD8rmZUX9EcRKUj3oHaM=
Received: from MN2PR05CA0038.namprd05.prod.outlook.com (2603:10b6:208:236::7)
 by MW5PR10MB5737.namprd10.prod.outlook.com (2603:10b6:303:190::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Sat, 25 Apr
 2026 03:37:56 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::e8) by MN2PR05CA0038.outlook.office365.com
 (2603:10b6:208:236::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.23 via Frontend Transport; Sat,
 25 Apr 2026 03:37:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Sat, 25 Apr 2026 03:37:55 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 22:37:55 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 22:37:54 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Apr 2026 22:37:54 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 63P3bk802903263; Fri, 24 Apr 2026 22:37:51 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 01/11] spl: Use FIT data address as fallback when 'load'
 property is absent
Date: Sat, 25 Apr 2026 09:07:32 +0530
Message-ID: <20260425033742.1519298-2-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260425033742.1519298-1-b-padhi@ti.com>
References: <20260425033742.1519298-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|MW5PR10MB5737:EE_|BLAPR10MB4977:EE_
X-MS-Office365-Filtering-Correlation-Id: 852a4253-d4e9-43cd-9bf6-08dea27c09c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 96ipQkgAF+ph6A/zgfU8e8olOEq1kKfr7rCdUpPFqchfpYRdlQxCNtl5oqjUBnTUCHRpOf7k8D9ab5grbqFOY3jzgbZX7BNUlKZAzt4HTkjXTrUJ/9fBT0vn7v+KsQtxrkEaRgsRdEc7bU4HNJbOkeLg0WOVEqfxr7TYfwshGBNqYeluJOmchy6NBHuKyLNWVtofXY/ykdz+o68CWvA2hiQ1QQURQDlc6Qh5nwhQ0OxtwzwTWaAsIsafBfEIH5wks9WZr6QKenbb5irKaKPKyIHr4+noqU7OXkmABgDx7599Wyv69gbMI/DzxeYo1j/Rh/gXdIgZy/AIoAAdW3FcF+/tfv6qQqmqrC9nNwCzVBUtrxT9SLJGsXgexw3xeZrZF8mxEmHlric+WOfBUEopwd11B3mWbgztUEz26LqDPdcfcKwapCUIU6Bt1KWVJ75Nq2toB5YGG9QO2j9W2LIKu/pHFkPF8pJA69Rb/b5Ku2rjMKM0TmNBfm/M4uMrLYgzJc3wWoMaCb643LkSMQ5usqwDsauT485CCldicySTFmr7yNe4uXG+b+X5JAGIsl9jSuDe6R8OsLXV24cHltXZrf2/WvAEzALD32gT6l1uUWIebKqknD6bs2ixoxZaEatpQ+auyHX6CwIdUD2WYpq6nIwiIW4B+lL7QPoROVIlhjWIpNG2OHD8B3Te0IOCZHrWGlQkXVoC6mPrMJjM8wZUu0U9l4oz4rk0QjZEHZ8d8LgKzyQdq0oj6/KuZyNcQXxy1ezx47Yp1X2CKE/nN9eF4PCzRLo4uRW89DtrgaBLp4M=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dRhHy9oKJEOn9HgryfH62TXq/pnRlBdUR+W6CfKlc6HKBd34axnm1STDYJrAruC6xqDURke7G6RxQqr1bbKd7s6DpV/QAydd8kjJ043RcxI4DUtK8VQfCwGx56uD9vIl34HH0xyixts3bgfOg0O5tUpkRVm2sdCuYYDWoe6R1bjuNzmg9lCn0QI0U2NHogiO1SmyGsJO0+UjSI/U/ma7uQVfwnSBNaYWPccwIW7lcUpRUAsIJ8oKYGe6M7RP4UbCLv28btIn/ELZX6nzVDmXC1iQDGoTMIVBZCPDycHDYy8biZhW6NK4sBnxfKtahoFpcdzg0jzdGsbWqrKJZlKFO4bfrz/45soDv3v3WphOJWcDlOzvnpZ/liZwGLP8ULzbMLzlnLhLtaedNDSlP9RGFnHcRp27EKY4g5mvoKWAajWMYhY8ItqmcJ8vGhb9AO8V
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 03:37:55.5542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 852a4253-d4e9-43cd-9bf6-08dea27c09c4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5737
X-OriginatorOrg: ti.com
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

In cases where the 'load' property is not defined in a FIT image node,
fallback to using the data address returned by `fit_image_get_data()`.
This enables FIT images to omit the 'load' property during FIT creation.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
Cc: Simon Glass <sjg@chromium.org>

v4: Changelog:
1. None

Link to v3:
https://lore.kernel.org/all/20251231173621.1069988-2-b-padhi@ti.com/

v3: Changelog:
1. None

Link to v2:
https://lore.kernel.org/all/20250506104202.16741-3-b-padhi@ti.com/

v2: Changelog:
1. New patch. Add support to load images without 'load' property.

 common/spl/spl_fit.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 46ebcabe56a..87d01b8b8e6 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -799,6 +799,8 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 {
 	struct spl_image_info image_info;
 	struct spl_fit_info ctx;
+	const void *fit_image_loadaddr;
+	size_t fit_image_size;
 	int node = -1;
 	int ret;
 	int index = 0;
@@ -889,7 +891,19 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 		if (firmware_node == node)
 			continue;
 
-		image_info.load_addr = 0;
+		/*
+		 * If the 'load' property is not present in the image node,
+		 * use the FIT image's data address as the fallback load
+		 * address. This allows flexibility in omitting the load address
+		 * during FIT creation time.
+		 */
+		ret = fit_image_get_data(ctx.fit, node,
+					 &fit_image_loadaddr, &fit_image_size);
+		if (ret < 0)
+			panic("Error accessing node = %d in FIT (%d)\n", node,
+			      ret);
+
+		image_info.load_addr = (ulong)fit_image_loadaddr;
 		ret = load_simple_fit(info, offset, &ctx, node, &image_info);
 		if (ret < 0 && ret != -EBADSLT) {
 			printf("%s: can't load image loadables index %d (ret = %d)\n",
-- 
2.34.1

