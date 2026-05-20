Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9A0CD4F3C
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 08:58:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD98E8460E;
	Wed, 20 May 2026 10:58:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NCmfgZbt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02CFE846A7; Wed, 20 May 2026 10:58:26 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE6D4844CF
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 10:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dpxc+L9icNAuzEBp/1laLTbZYCbtu8KxRpGs7S/kQlqsxvYUUwcW5fOkZF/oi1j9XSqEhs8NwGJD5J+9SF/aR7TZp03l6j3/IysJ+eDd3BBESJxL/aZyA+ek1iog7ccrzu5JgmPxMZT1h/hWBvFdOXtelGCa4Z0cTkD1Hw4HWmw4HGCDQROd6vtdfz8QAEZN+ZExOo8QDA+uWvze15aPgsTIRmcauv2YJfOScv/ASPLJ+FyXe4Hh7SNfYGtfCmMirYfRTt+PN0xWn2WOyUqDUABr+XEUgiXKHHpczJhoph1ndESaDk87jFrl9KW0ZKP9fD9CHkd99Pin4RKThkRzGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Szw99DnLt0q001Ly4A0NkDt8OpEBxpMpXa9g+Yhpjvk=;
 b=b7hUOFHSjcG8NDS8+zzaqfioO2CmeR5fZSmqeReAKZg05C37x5Nl+u8iUxw6vEpwObgtWuWU1aQ1RQmyx2Qcj9gbt8QedGCziEHUUCbBYrWK1QQkTyAX0uKl797T0XYT7H3F09ITY7lXsf4TcHT2wEjiRZSBvEaiEAF3ItTc/7tcotZfoU3ZylX+ulX1yPEw77eRfU3Ix59DhQ42WXClETajN8ziDXyXr6vHsHPoUjKG60lc7TwFVdf4AQAEHDYlmMfxj3tu/db5us4LWesRO2BK0IC2Rtfaaej5Pmmaxo6wDB34FJowVYljIgK0U75hGp34BhKcK/YBfSRv5LvqPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Szw99DnLt0q001Ly4A0NkDt8OpEBxpMpXa9g+Yhpjvk=;
 b=NCmfgZbt8j/O+sXKf2I2RURcmanl7z3VtN49HhTVrBNq7WKY3xWA0d1QBcwqyZIcFmjnRT2dOgrBUCuUuLQvvR2TNIbZBvyHbPHWDmTwrc0DMdOZWCr3S+Ak5tHQ6StaOXprDpxDBKn9nP+Uy8gLbvFRL7a3vN30Ioiii8DIFAc=
Received: from SN7PR04CA0228.namprd04.prod.outlook.com (2603:10b6:806:127::23)
 by SJ2PR10MB6989.namprd10.prod.outlook.com (2603:10b6:a03:4cf::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Wed, 20 May
 2026 08:58:20 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:127:cafe::2) by SN7PR04CA0228.outlook.office365.com
 (2603:10b6:806:127::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 08:58:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 08:58:19 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 20 May
 2026 03:58:18 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 20 May
 2026 03:58:17 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 20 May 2026 03:58:17 -0500
Received: from moteen-ubuntu-desk.dhcp.ti.com (moteen-ubuntu-desk.dhcp.ti.com
 [10.24.50.20])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64K8wEXM1125148;
 Wed, 20 May 2026 03:58:15 -0500
From: Moteen Shah <m-shah@ti.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <gehariprasath@ti.com>, <m-shah@ti.com>
Subject: [PATCH v2] am57xx: restore bootm_size for ARMv7 HighMem constraint
Date: Wed, 20 May 2026 14:28:13 +0530
Message-ID: <20260520085814.2561216-1-m-shah@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|SJ2PR10MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d0f4b95-9c85-4c73-1e34-08deb64df061
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|18002099003|56012099003|5023799004;
X-Microsoft-Antispam-Message-Info: TLzBSlA/wv16iXEAz9dhbftCJTyDAyeyAocSjBI5cydCEHG0rq7/qxs25rcsPeHcNDQL2vBBKs83i4PNiLQNtpPvz+XDxnxpqGzqlXMacUk0tbXbznblyw9IsgsL6KV6bty2pyzbJPl8sTTdPV/A5RApHPrgeOkX+20bQe2K04W6kQgWsfFwE6k3oI0dZGvU0kKRddQrjKGDda2VodQZfJlLAO+OrbQp5FhFIJP2giaLvuG7ESqRaPlrKJ0XYXdVt2uy9rLOk6ZF/ArIAtEeVqabxzO7vZmoE+zmfpIqWPwGceUiIq0OZYLmCVNfFnjtBpbe/U849nVGWGBX0DHiT0g5DKAOVyDwrQ1eu4mWKAxWl8EmnuKsnUYI4ISe6t/b4gp7jNfoqHkGt+YbIIxx0tEwV54g9IPodblTIDufLXjBfMf/FZ8ay7bYd7w+dtgDNDVX4bj6LojNUHlhEtVNEvnfwPoPl6Dvlm5U8ZWUjqwdVeKF8Z0zDPQHegnqJUZOHn1qJHCYMdI5VlELIl9GZVwLkyW8nR6Z6ehLpmIAfXzYYHtPql/40MzxHtEFsLYvvVDW5iS5DbL6HYL0VzuWaeImgWPXLWMJLGLE+JADzKDnPlWOfFmr1coKz48A/kyN9W33SLafZoxfVfRsNoI4q7eWaEbCHcMb42gT6RSY7qVAlrX+bLNRWb9uOEwLQA54tWA/nvRCsIFAxCeCSe29k+57eC5WMIFBxoLWzKCyWWc=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(56012099003)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WHIp0feHzfsByEIun1VMQYAg97zE+HORT9rUc7yi99OJhGlKQBtIjIMB9xf868hs4bblat6HAZ3hFluLiecszhPvB1bTmFx0k/eME7ifQEmsVHwjSMzIY2MEEkgDTEbuEMoRolF7uHTmLeoCWN6Nodd36TVGXqQaBPnkbigl7tvP9kMEv00G+WHOCtDU1tVpTegWDZf2q3eXkxyPkoENnZ+Ztq6kgH4tARiyUYbKIcu2abFwp7RK8tpJO4JjLJnUgJfksDXQvag22ptlCSEIYeyBAkLxh9d5mW8SaomZL8WfmgK+r1fXuEjLNnFV/wN6HTJ2uIw+uy1Y8ZLR/WCw2jDFYK4wu341Ez0w/AJm5FUwppF9dWDxzQ1HEnCo/wq1+JwJl6mOtCEl20bvRdGhue8JSCgZbh9tpJO4AIJ7Wp6PjagKIuiSinkvMFKtSOnT
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 08:58:19.4084 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0f4b95-9c85-4c73-1e34-08deb64df061
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB6989
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

Fixes: babae80169dd ("include: env: ti_common: remove bootm_size")

Signed-off-by: Moteen Shah <m-shah@ti.com>
---
Changelog:
- Fixed the prefix of the commit message subject line
- Fixed the fixed tag to follow the guidelines
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

