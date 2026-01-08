Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A0F9D1D461
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 14:37:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 322B8841CD;
	Thu,  8 Jan 2026 15:37:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CDq0E6Fe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A346484253; Thu,  8 Jan 2026 15:37:26 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84C018416C
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 15:37:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vishalm@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PpYdCWj2IX5QDeetXFz1vwg4ohywQfpnaO9k95HuXLquhpbl/PuZsVycvHVjOGViC9BaA5AkvCEMC450bDgnGdA7dmrKnVUdxHcS7vUCp2CyNI3QYrBagrPIpmcBnbMShPESQhJ9YB86XfmaAM2Rogl4DGiuvv6uE7MSvujNPPwkIpjszUHLCRhJX6qKmqRRiwapPBiZqEYhCz8axSAf3Lm6RtHNx4OLf+LDJuY0xwzZ0QqDZzDh/9tQhrobcSiAZDbMd312YyfszC7P1OBs/isjn0Fv2mXlUQIPNAVfBzpGm8ufNKg9hiR5SIhlNBB7QERu8vPmHxSZuJSkGREuXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6s1b2zZyWYXwnxulo8QuLbOwutlA2IzJW4UB3EfuUCg=;
 b=FJA+yzh347fbNYQh3dd/dVBBb00tfsvh7hajRDcRbs3zO6FgPbUHPFoDo0HFwlBp0Bgy+8l4yh+waQWC05sv254v4IFL6sw2uno9ZIIZX7G/humvRpy5LHer0lHW71uFG3ppWMcfNXrXe/OU6qF1okOrRRQhHWhxMaiAVyI31p2LDpWpmnLft/D13arKhy4hoi7w5RpFkwxOMQYS9WB2juYs+NC57vfdzkR0WVoLHokoUgdeKgueN2oz/Cc58VId00UNXjCEtTbVhW2dNcD/YYNG8WseFk5PVpVwKzLsuD1+qkF0AhGg+FuYdrfZb6j0dm1kJaD47svQS+ISUXfPbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6s1b2zZyWYXwnxulo8QuLbOwutlA2IzJW4UB3EfuUCg=;
 b=CDq0E6FetWUpq27a8FGdsb9hzybIvXvUeNotDsf5t45eOZmxqam4FPa3Rd7RQrBCzVCJQNjaMWW70hLfZAvFcZrGTEUaJQzGz2BcNB4ILiD4B8tdJuhUbMQpKuUSndoY7v9gJvXD4VSUqpnx3ZpnaCHofdMKKmtII+yM3LKvj2U=
Received: from SJ0PR13CA0099.namprd13.prod.outlook.com (2603:10b6:a03:2c5::14)
 by BY5PR10MB4193.namprd10.prod.outlook.com (2603:10b6:a03:202::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 8 Jan
 2026 14:37:19 +0000
Received: from BY1PEPF0001AE1B.namprd04.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::12) by SJ0PR13CA0099.outlook.office365.com
 (2603:10b6:a03:2c5::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Thu, 8
 Jan 2026 14:37:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BY1PEPF0001AE1B.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:37:19 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 8 Jan
 2026 08:37:14 -0600
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 8 Jan
 2026 08:37:14 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 8 Jan 2026 08:37:14 -0600
Received: from uda0271468c.dhcp.ti.com (uda0271468c.dhcp.ti.com
 [128.247.75.68])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 608EbEVh2521105;
 Thu, 8 Jan 2026 08:37:14 -0600
From: Vishal Mahaveer <vishalm@ti.com>
To: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Bryan Brattlof
 <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v2 2/4] board: ti: am62x: Enable 32k crystal on the board
Date: Thu, 8 Jan 2026 08:37:11 -0600
Message-ID: <20260108143713.1130054-3-vishalm@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260108143713.1130054-1-vishalm@ti.com>
References: <20260108143713.1130054-1-vishalm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1B:EE_|BY5PR10MB4193:EE_
X-MS-Office365-Filtering-Correlation-Id: e130bef4-0e39-47d5-95cc-08de4ec36d64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|34020700016|34070700014|82310400026|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ndqJbJvF23KfEc7THViY4Oj5Wxmfvdk1AcjqbvaKHLAzxjFiFCpw3agh+rxr?=
 =?us-ascii?Q?YYDn4NqywOuQDi8QpOKV1AGVmpPHud1/B7iq0mujhXjIC4cjmWL+dKRSRxje?=
 =?us-ascii?Q?BK6eM/L9c3jia+KEi0Tb/MLktgnHVwemr8WzPOyNcwtzafDDWk8LsgehkuKO?=
 =?us-ascii?Q?zq3GDM5L0rmtdS7tSG0U0jfd4I2RDxwPBWJBOIy0ov+t8iPngjafMWMdkPhm?=
 =?us-ascii?Q?UncYy7t5GwafNegy4y/qAzosSa7TnvoEpFGTfLJa1QHMVp2itMoHUqz0T6rm?=
 =?us-ascii?Q?50LkEdAmbZ8h6rogv5XtuO8h4GO3ul8F2rykciIYL4DL968eX2zDY1PSGzur?=
 =?us-ascii?Q?ooVezCxZp9MGNvBWwK1MJjgEcAHYSUDbjM781tgZPLgSaYgo5sFEh8XbBIGg?=
 =?us-ascii?Q?znXX2Jhk690yKToFfs15vXiNhlG6MQpU1v+L/txJVEK1BKFMMvmRqoEwr5JJ?=
 =?us-ascii?Q?1kkTyHNZ87LuM5elZT/dFnFs+QeY0z16C8hyx2h+so3iae+RVovDeIYfJkt+?=
 =?us-ascii?Q?Ffl+rlxGMzAPa3Te8TwtIbyux1uS9urLoU27sZeFD5RBNirbsC6gKq9/RnlR?=
 =?us-ascii?Q?qtFjjOJ4AXy/k6i75For7j1B4RurHIonaQkq56OcOS9iY/zH9IFVqNNaiE0D?=
 =?us-ascii?Q?H2CLLB6st/CCYfYJGVqB27Be+Rnotqs3RnUWVX17yjiFSx3OxN96X1o9YYJV?=
 =?us-ascii?Q?M6BajyoZTauXDHfABVyTF5ibCx7pLhP+kReK1esyE3EMFf9QHU1WWYLNq/dg?=
 =?us-ascii?Q?Ay3RjyaDabnyLzEsh7NWv5AfuVVc8ErdFya/hrUNz1hNwkYWxT+vADvlfMno?=
 =?us-ascii?Q?VTo3C4XvFZGfl25BmgMSrzqoIX9D0hB240y5zvBkix0uqvK/hy4m8BusDTkr?=
 =?us-ascii?Q?z8eyulmM6nI5aIj+N/YgdeuomKCahoRS7H/6xfTOWkrv/shUBjjza3SJxZ/4?=
 =?us-ascii?Q?zW7GAV/zieYEWB+PVZTBv+9QP3PJ6Hg4e5QhkBgL++nD9y8xO5lyPaymAJkW?=
 =?us-ascii?Q?pKze7TYvi/IkfkZFBFxCWE2MJ4JuldA9VWNrxonJDSU53l+DZIvQWoUYGK+H?=
 =?us-ascii?Q?OAd+lQb2ghxXyWehpEXO4Dz4AtpjZdhtDuw2pzGdaoZFuiA1QjDmA65gtjW9?=
 =?us-ascii?Q?OdvgRZBPa4SAwPoM+yyjTn1LL/9435vFguIAoHk0RLbOqk8SalJUhJxb9fa0?=
 =?us-ascii?Q?dEAwov24prj9c21z3MF7LFTXG+5eeOXLfzFHLUvcoYD8Y2Ru9Aev1nFd7BVm?=
 =?us-ascii?Q?e7kN7i4GxY0DKjbc0xlzPWBFOFLt47NBPSG+phpxJ+fEbqrKzX2Bmpzp0OC8?=
 =?us-ascii?Q?lfIqiA3TujkL6/7lFECCGSibD9Tm4WJItiFz+g7gnQfFQojcI/kg31leA59b?=
 =?us-ascii?Q?Q1TTidZ67tmeBe97n/xeaw8NPb3bxhKDojAaaa0zEgHfaMVS6d1zsQhOXhfz?=
 =?us-ascii?Q?F20fF2albx+Abmu3dLaYtzxPKvOiLPmDR/rv0V8GTdtRjYgJuTv25X2qH0kj?=
 =?us-ascii?Q?gNST6bd6dbBHBitm+0mt+E5L5cxIrf5IOH3apA+zkiy4RpREwcRvsxPDIRtJ?=
 =?us-ascii?Q?nFOJesEhggOhSYujo+0=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(34020700016)(34070700014)(82310400026)(376014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:37:19.2826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e130bef4-0e39-47d5-95cc-08de4ec36d64
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4193
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

