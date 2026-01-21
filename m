Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67330C44506
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 19:53:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F9CE83015;
	Wed, 21 Jan 2026 20:53:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jpABq475";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34F8483A6A; Wed, 21 Jan 2026 20:53:48 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C78B580077
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 20:53:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vishalm@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DHxKpwz9kSURxqAYI6Qr3VBcgk7AK3TY9nrYHNjuUIUlDyx1Pgy1bBaEla+ZYWJxRE5cYn1NLQQud6nalqhIy15tIrdOWOdbTpwjBhBsp1ps4a2vHDzotxgZiFnB5F52KGMgalUGUEY8uaJgMYCfmbTRnt2BwaTAZxz2hPOroVC3tHWAVV8w4Ll19uxacZ0LUl9bXMBfeuqINMVk9teJ1rwP4hPLugut2hAT3EiF3q0pefErpO8lvnCkbwDRN3DkqmblDkKwB9GaYfy3N3aTvFw/f/MGlgJi5sxHEbpUh8sjP6+WS5WkkvSmdleHPS7Y+XzcRbr4qsFeQEjKQ3GEBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6s1b2zZyWYXwnxulo8QuLbOwutlA2IzJW4UB3EfuUCg=;
 b=IgO4H4UQJgkKG8MR1uMXOKYxExNnRmcERnLvSRjOPa4pWShZVJpQwUiuK5z1s8o0IGduJRbDYDu5lfj5clbWyUKTf+wPZBj1foDGrW1H5vpCxuKKtVCHWnFzEXPNFMvH09NB4wCxepgk7IjRxH/CM9XcDI4aCiK8N+9qg06ZoTYzZhCoi6ANcFvj2Sj5kd2GjfJBJSKXRNesJiu6zUpkBOfKMYSK2/3izTKtxaLILVyILV1IYAEMQzCMUNLwNDSYb5/ptVsdkauoC2X+2S8+FXm1kfbJ+iFXQ3XC3LOPavDjl/UdKiugS23eYDkeA12hyqUxIOlJgCdBsotFH+LodA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6s1b2zZyWYXwnxulo8QuLbOwutlA2IzJW4UB3EfuUCg=;
 b=jpABq475By6qxs6bfVC45sGOO6drir69YwM48nmbTGjIpAMf6o1DAYAx+t0SULI64Qfg1toRIfcAsQgqRdU/Id7qNDCRmVvpUmfy7g1H0TSoJBCC2mv1EYxLiKAS92YltsDAprVvG95FDaf/RkdkiKQA9QakRIxWJk34rAEESg4=
Received: from MN0P221CA0017.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::28)
 by CY8PR10MB6658.namprd10.prod.outlook.com (2603:10b6:930:54::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 19:53:43 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:52a:cafe::89) by MN0P221CA0017.outlook.office365.com
 (2603:10b6:208:52a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 19:53:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 19:53:42 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 13:53:41 -0600
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 13:53:41 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 21 Jan 2026 13:53:41 -0600
Received: from uda0271468c.dhcp.ti.com (uda0271468c.dhcp.ti.com
 [128.247.75.68])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60LJre8F3424431;
 Wed, 21 Jan 2026 13:53:41 -0600
From: Vishal Mahaveer <vishalm@ti.com>
To: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Bryan Brattlof
 <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v3 2/4] board: ti: am62x: Enable 32k crystal on the board
Date: Wed, 21 Jan 2026 13:53:38 -0600
Message-ID: <20260121195340.3041549-3-vishalm@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260121195340.3041549-1-vishalm@ti.com>
References: <20260121195340.3041549-1-vishalm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|CY8PR10MB6658:EE_
X-MS-Office365-Filtering-Correlation-Id: ec80c2d7-a701-4713-e2b5-08de5926c797
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IemmYLCFkp8O4gNNv3r4Kw005HZ2Et4fHENuEcHP4uPVM1U6B3wL0WuhKA7c?=
 =?us-ascii?Q?a0GIOeOeZbCeh5Vjxo6xVktCjGMCZBF4weVpJjFJLLv3vi+/OMyP/EOlODN9?=
 =?us-ascii?Q?ZkFOKs+obfx4EqF27l5yTHz1P8xmxQ7+dHU3BNggdlu7Ssvu8vUjTZKV8Opk?=
 =?us-ascii?Q?IBFsbcDNIldvM3fiJyGyKAam8PlCaodAHlMJn/UPMg2kB8uc40LV+PZAn366?=
 =?us-ascii?Q?OYXzeJe9RN78lEVl1JhWgRB8bW+CSgLxOppP8esjKWl8uIwTvabHKt2OAbF7?=
 =?us-ascii?Q?jtQKlUnlTbw/Pna9GkqMuXZ2dOnkBQAEU+rr5tvAZEWKy6PmOE8PcMxTYCX8?=
 =?us-ascii?Q?Nmd+cJd5qVlC7fA3nbclooIBlerpHnQ35vgOSNBHRTu1fXDrr0bT+pnTblio?=
 =?us-ascii?Q?ZcHHzEnVxgJFjgHBrgu3YTI/AsRbT0g8oBEUhPe4snCC5hlv30iO2zkReDF/?=
 =?us-ascii?Q?eq7KGYG0/Km06OZ4RsUt9GsheTETxXzegZmj/gdYLOEPduuMncCLzmZKhuIT?=
 =?us-ascii?Q?KF76cbZzoIpyLbZbc4LoKua3XVNM7f0ZkV599QTLE+6/FdJc0R+m+zq2Rv/+?=
 =?us-ascii?Q?KOWwHb4QyNvCvlVrE++sjQTCu/qQefnFPDA4SfQV9Xg6NdabCBgOG0M1vK9i?=
 =?us-ascii?Q?Mx1lK247gn75Aj5F8IuUrBxDSr14aNDEV7Uy5qY25QyXtyznHGTHpB0uhPmd?=
 =?us-ascii?Q?BvMYeGX34NTdVPBz0QnhfuLpfCg5baR+MkZO6EZ40WH5TbuiQUayz259VGHh?=
 =?us-ascii?Q?rpLYW+lkjLNmZ1FVGau9VWoQZBElgaGIHHa8onB5IIMigTOavOEzPyfihm8u?=
 =?us-ascii?Q?UYaRce1rzNyoSWLbmMhF0GqDpzV3ua2sPMF1YZvXz5i6T/5VOu2rzhTEt/mW?=
 =?us-ascii?Q?8qD1AU63sxWgUeqNFzchrIfRvWAIZZpnScCaT7Z097EoZ9m96roI+Mz8ABi3?=
 =?us-ascii?Q?a8NSIo4P71nUjfXEhhCk3FIZcMcPeasHSeo9nzQlAAvrbr4LvMTCZj4N3sE2?=
 =?us-ascii?Q?ONiLyTCXpWxqjyaFXf8NI5pYAbwunib5ImM6xLUg3T/KiF/5a+aY1EYcIpyM?=
 =?us-ascii?Q?QqTZkWzAqQEvFc+rSrfVaVYe3JWvKhLEG+/emru+Z+Nh34n5hcaIFZD2zDNX?=
 =?us-ascii?Q?T0U7GuhPsIuawxrA7uvMMzWx1U8wI7akGGigpuSoi8CArnNowoQvSEu3MxH3?=
 =?us-ascii?Q?5CBn51dRjxE0Ajjn4puveW/LA67tD36iETs5VjlrxKbvrDjNVPFenukkz6C6?=
 =?us-ascii?Q?3k0jQ5rRv95qAv+Xs3/hr1e/H7EYPQYglFagGKucFA5qjpAnLZiNOJf+6DTv?=
 =?us-ascii?Q?HiZcBeiu8+wUBLm6OsMg2WjTcMFmbvlftD2kozYmR9DQgxX+I9ya/zuBWaAE?=
 =?us-ascii?Q?hoPmAl/vXL9mZ8TT9EVwX1wO3dQe6ZGSODJ0g3z5FSh7/GzoVFreVkT5oXPs?=
 =?us-ascii?Q?1by8hJGO2RJ/vsQZHAOYrta1eEJa3WYDFJmVEjzZmLJdEfmJI54mpMPdJ3st?=
 =?us-ascii?Q?wpX8y7Y5TsTiFqZu/rqKKuKa2h35Bw/khWrHpKsgLoRS02ADnQEgQTiN92RL?=
 =?us-ascii?Q?NBGD8oH7BNDHeP2xnxG17lAb64kT5etJc2Js8kLui7C84EqR3M5LgQMmJRXp?=
 =?us-ascii?Q?C42ov+TOJA50YwUaytFeIK0QJlMk8E1P7lCaW6mC/08IE48joe8T8/BSoijl?=
 =?us-ascii?Q?gn1txQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 19:53:42.4203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec80c2d7-a701-4713-e2b5-08de5926c797
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6658
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
 board/ti/am62x/evm.c           | 4 ++++
 configs/am62x_evm_r5_defconfig | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/board/ti/am62x/evm.c b/board/ti/am62x/evm.c
index e9eba57eba7..2e8336900d1 100644
--- a/board/ti/am62x/evm.c
+++ b/board/ti/am62x/evm.c
@@ -24,6 +24,7 @@
 
 #include "../common/board_detect.h"
 #include "../common/fdt_ops.h"
+#include "../common/k3_32k_lfosc.h"
 
 #define board_is_am62x_skevm()  (board_ti_k3_is("AM62-SKEVM") || \
 				 board_ti_k3_is("AM62B-SKEVM"))
@@ -139,6 +140,9 @@ int board_late_init(void)
 #if defined(CONFIG_XPL_BUILD)
 void spl_board_init(void)
 {
+	if (IS_ENABLED(CONFIG_TI_K3_BOARD_LFOSC))
+		enable_32k_lfosc();
+
 	enable_caches();
 	if (IS_ENABLED(CONFIG_SPL_SPLASH_SCREEN) && IS_ENABLED(CONFIG_SPL_BMP))
 		splash_display();
diff --git a/configs/am62x_evm_r5_defconfig b/configs/am62x_evm_r5_defconfig
index dd3b4e58009..6d039f9acb6 100644
--- a/configs/am62x_evm_r5_defconfig
+++ b/configs/am62x_evm_r5_defconfig
@@ -119,3 +119,5 @@ CONFIG_SPL_TIMER=y
 CONFIG_OMAP_TIMER=y
 CONFIG_LIB_RATIONAL=y
 CONFIG_SPL_LIB_RATIONAL=y
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_TI_K3_BOARD_LFOSC=y
-- 
2.34.1

