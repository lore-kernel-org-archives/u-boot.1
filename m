Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A1E0C44506
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 19:53:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C163083A83;
	Wed, 21 Jan 2026 20:53:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IT8aHF3R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FC5580077; Wed, 21 Jan 2026 20:53:48 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6359683946
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 20:53:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vishalm@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ysH1OwYKN65JJeZyxPBKRdGVyAYLIp0ZM7fOLBxUSG4EuPNICURS+tnxfEuS/EdFWVYjdG4as45V+TCK/gCvgM+NrTFK9mpytHzJnBwkT/ZWqSLjLWr37t3faGr3dSONM2lyaqz5GLITPqyvHjwvk+d/LHwPBndgrD0eNx/9BPXJNLCUDcY88Lmq4Z6ACqLjz6d3g6D5kTPkC6GLPimInAIALoS9CdjyyP4Uzm1FWiluWJdpM37WiChyHIq3PcrbMDISvysYeXORM9h5J5YG+y2HAC5IYNoiae2hBDfKBuLGagCRsEJyurgi4pp74o/POwJG4O5XRphNHjv0vLw8HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5B+i3EIr6NrotfGWueiAQ7XugHTGNhjeNlWpjkc41Iw=;
 b=qGvJJTagc2vqONHS3u4m/tVVPMLp40pfH6pY1NrrvlPs3krEAm5b3F2fPYg6fS/BBcssZA3MzSfBcWf5gQO0Nl8m7a9tjjE7ZtKtO6QiaeI/uG0E9O6HKtIzAQeluyK1yQUGhotl5UMk/6nkDAhVf+xetspbxl6RNLPkfp1IoNDnuVLobCcSdXg/sIbPt7nmsq0FOHyUZYgN4Te9yrCtLLDakocSx8+Q7HemKvv/4zI3v9FgdF5o3y5eIQB5mDAR4OpYgmb9MUgRjlYl7xUGO2gBJU6T/6/OaBAqYK7L1mP1e3q30jmwpvIytvnqXshgB6Wk41bTmcYA5uuUFdS5Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5B+i3EIr6NrotfGWueiAQ7XugHTGNhjeNlWpjkc41Iw=;
 b=IT8aHF3Rbx9E35QTdfE7jcDyYmmBoDUIeY8XKnsO0+Zr1R+SU/Uv8MWmho5BnOrJB1gmNGgHzqUkZhZLKLJQIUILkq79CHfOVeI45A4dv6v4hrFqy6DevUg5z/2e6pMILKKHOJY7A4dA8TwE9ccVlCZYOAofqETWGFGI9/mJsHk=
Received: from BL1PR13CA0274.namprd13.prod.outlook.com (2603:10b6:208:2bc::9)
 by SA2PR10MB4460.namprd10.prod.outlook.com (2603:10b6:806:118::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Wed, 21 Jan
 2026 19:53:43 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:2bc:cafe::37) by BL1PR13CA0274.outlook.office365.com
 (2603:10b6:208:2bc::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3 via Frontend Transport; Wed,
 21 Jan 2026 19:53:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 19:53:41 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 13:53:41 -0600
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 13:53:41 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 21 Jan 2026 13:53:41 -0600
Received: from uda0271468c.dhcp.ti.com (uda0271468c.dhcp.ti.com
 [128.247.75.68])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60LJre8G3424431;
 Wed, 21 Jan 2026 13:53:41 -0600
From: Vishal Mahaveer <vishalm@ti.com>
To: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Bryan Brattlof
 <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v3 3/4] board: ti: am62ax/am62dx: Enable 32k crystal on the
 board
Date: Wed, 21 Jan 2026 13:53:39 -0600
Message-ID: <20260121195340.3041549-4-vishalm@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260121195340.3041549-1-vishalm@ti.com>
References: <20260121195340.3041549-1-vishalm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|SA2PR10MB4460:EE_
X-MS-Office365-Filtering-Correlation-Id: 2351ca05-24d4-4bcf-41f6-08de5926c728
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mN3R/tASGdQ81D8QeqMyyigPaMR7LBJ0bWJOURgKjtoSdqKhFhaTMVovNXNR?=
 =?us-ascii?Q?1DF3AK/TwQRXKtCVbq1KPb9xlaZJlQi4mUdOr4WRySqVOiilvsxf0HS4vlQO?=
 =?us-ascii?Q?Dy9y31fCpqK7tT/ZPsiYcDjGtcGCG2WhUUzQdbD2zlcgU+iZqXV81NCR59HH?=
 =?us-ascii?Q?QcsV03oD6dcNMvWJFsEVd8AL0+lnRSxQbuMDGB9zm849K41/aH6EWbRKD1ul?=
 =?us-ascii?Q?Ad2jRZmcWd/eVVKmOQCk6lFP0L0BciWsSv749vDzBIQi2wc6uuRRoduLX75/?=
 =?us-ascii?Q?/M5oxrTW2gYFMrJctFOuWiAo7gBdkYcrEZELbBbvNHmjMQKlWUxKqIHvITsy?=
 =?us-ascii?Q?w3U6yQo8/YxItY+xRJU1yjU3T3RkdSHrzpjHW4ITUNxulsVPzXlpSEw+kH2K?=
 =?us-ascii?Q?Ed63XJjvKlKWw+xkglhPxQO7ZtdfTNAcoKHsk1cqiNrOxphvZp7CaPgUBaDA?=
 =?us-ascii?Q?vrs+J7vsEn19lR5FKWG6QD5GOAXHnRk5zJmvAeLNOuOCdUIZQBoMTQ3fDZFa?=
 =?us-ascii?Q?TNk91ZtxSvjO6+N57kgVsgW/J6FG4JvI+ryb8xpP1g1bY4TDbDgXUsMgIZxF?=
 =?us-ascii?Q?d9SKDDHNR3CdcJK63OTAuRZXft23zEkSKQT58lAVsqy83Kz5qog+yNe34NZa?=
 =?us-ascii?Q?7/RJUwmEM/rJ4MrC45iOAv9r0cGGIeSsW3paBNbKR7L8p+YjAztcXH2OZEeG?=
 =?us-ascii?Q?VC+Q5+2y5pWok4dHnbWDo7k/EA0F4KL4Ndq+57sDw51k7UATsPSeDNSayzPj?=
 =?us-ascii?Q?Hd0lS9D0C6ztcpcLwEzeHvuGOxq5z1lEHmHgZ+8OofbNU9ISKojSzODqI8PA?=
 =?us-ascii?Q?oEI9itch/+RJFnaR7a2SGQmnsqoFz6rVCXva1FELFT93cAhRxeHfzrp+c83P?=
 =?us-ascii?Q?tufZwLp0LYG3fBqxshedAqHR4rKevP0VINJRWruyT3w9VKB3nUVqqHJN3fuB?=
 =?us-ascii?Q?PhtD6OMLnRHF8H7EHp9Q6SFK01+tB2EkntLN83BCsc5fq5/MCQeoH9zb2cwU?=
 =?us-ascii?Q?NNbDR223LQvTlCXxzhKr7oySNtRK2CT5g7ZQegggbiu5uiHx1uvivMYc/EWm?=
 =?us-ascii?Q?wXSNUTh/R5zo1nHMe3buaScVxD4yOrpbB7qTvfAoH4NtZyFOirDQeIXOqBk+?=
 =?us-ascii?Q?4aI/VLeR993LhfLThXw5S6dMXV+icY+ZzXeUcJ3cCSsacyyAgN9dmBkEpioY?=
 =?us-ascii?Q?Gm/S9FDpLN64elC6dEMo4ce0f9c0G1m4Dhguop3OKU3pgMwct+Htr2PDTuUq?=
 =?us-ascii?Q?TZSdxsv/fysiddgl7Z3iX4vZt6VZArn4kHDyq/k50okxXcqEu229pMIq7Uo0?=
 =?us-ascii?Q?PGpYs5lYGT2RHSAT3KWLYSD8dOD/TAz659/Fk56dX7wfpBRFcIwJSdRX9ddN?=
 =?us-ascii?Q?HFxjeT8gKmqHqXS14QaHYG3CqduILaWxMcxrPyFBRu3iT9C0UgMbnUL8ZWJJ?=
 =?us-ascii?Q?Yxf7Lp+4S/R6JD3oX6lXV35hulHiB9oS50nRDN4fCvyrKAEhWPD81eLKogSZ?=
 =?us-ascii?Q?s5XXGwqWtbf0EDJe3RUUOQICwUuJqPBYOxjp7Cttl/dQuN8NQDtmjaxuyv4G?=
 =?us-ascii?Q?qsHX/huR4QQQehGdLsUqyDJBEH1Pz8IZ7DMl4cqnbzEmsON974Kcf9duoQD1?=
 =?us-ascii?Q?7t2OuF1PEEt4eLmrOdyOmMoXikpxjgANWADAIL2YXsTSt6/ZE77PdOI/aGIl?=
 =?us-ascii?Q?KAJRQA=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 19:53:41.6978 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2351ca05-24d4-4bcf-41f6-08de5926c728
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4460
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

Enable 32k crystal on the board. If external 32k source is not
used, 32k rc-osc comes into play, which is accurate to +-20%.

Signed-off-by: Vishal Mahaveer <vishalm@ti.com>
---
 board/ti/am62ax/evm.c           | 7 +++++++
 board/ti/am62dx/evm.c           | 7 +++++++
 configs/am62ax_evm_r5_defconfig | 2 ++
 3 files changed, 16 insertions(+)

diff --git a/board/ti/am62ax/evm.c b/board/ti/am62ax/evm.c
index da6c31176cd..4916eec3b2b 100644
--- a/board/ti/am62ax/evm.c
+++ b/board/ti/am62ax/evm.c
@@ -15,6 +15,7 @@
 #include <asm/arch/k3-ddr.h>
 
 #include "../common/fdt_ops.h"
+#include "../common/k3_32k_lfosc.h"
 
 #if defined(CONFIG_XPL_BUILD)
 void spl_perform_board_fixups(struct spl_image_info *spl_image)
@@ -26,6 +27,12 @@ void spl_perform_board_fixups(struct spl_image_info *spl_image)
 		fixup_memory_node(spl_image);
 	}
 }
+
+void spl_board_init(void)
+{
+	if (IS_ENABLED(CONFIG_TI_K3_BOARD_LFOSC))
+		enable_32k_lfosc();
+}
 #endif
 
 #ifdef CONFIG_BOARD_LATE_INIT
diff --git a/board/ti/am62dx/evm.c b/board/ti/am62dx/evm.c
index 0924954c738..94d6043200a 100644
--- a/board/ti/am62dx/evm.c
+++ b/board/ti/am62dx/evm.c
@@ -15,6 +15,7 @@
 #include <asm/arch/k3-ddr.h>
 
 #include "../common/fdt_ops.h"
+#include "../common/k3_32k_lfosc.h"
 
 #if defined(CONFIG_XPL_BUILD)
 void spl_perform_board_fixups(struct spl_image_info *spl_image)
@@ -26,6 +27,12 @@ void spl_perform_board_fixups(struct spl_image_info *spl_image)
 		fixup_memory_node(spl_image);
 	}
 }
+
+void spl_board_init(void)
+{
+	if (IS_ENABLED(CONFIG_TI_K3_BOARD_LFOSC))
+		enable_32k_lfosc();
+}
 #endif
 
 #ifdef CONFIG_BOARD_LATE_INIT
diff --git a/configs/am62ax_evm_r5_defconfig b/configs/am62ax_evm_r5_defconfig
index 36bd340305d..18488918c4a 100644
--- a/configs/am62ax_evm_r5_defconfig
+++ b/configs/am62ax_evm_r5_defconfig
@@ -103,3 +103,5 @@ CONFIG_SPL_TIMER=y
 CONFIG_OMAP_TIMER=y
 CONFIG_LIB_RATIONAL=y
 CONFIG_SPL_LIB_RATIONAL=y
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_TI_K3_BOARD_LFOSC=y
-- 
2.34.1

