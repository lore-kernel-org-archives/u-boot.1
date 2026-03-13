Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA474105F7AE
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 14:01:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E89A84378;
	Fri, 13 Mar 2026 14:59:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iT+3Dhjw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BB3D84372; Fri, 13 Mar 2026 14:59:49 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B27084307
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 14:59:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=akTMxcT0+Y1Asqb2sgL7+my4Xm7iGvZGuabxZ5Rxp4YzM3mWAs0Fm3UhW+O9jC7SpyD/HywsvXA+6/OIlgP7wYepfgXPGGaJVv6zS71chftya2DNDiFyFzbaanbDmxaAg5W/TlK+RCglwneIDhLxSKgrqTkQQfDZtQgw/zYphXqpgcOfYSyn9/KqqHzmPE9OBez31g6l/cPlT2QSq6jt8XEkdSwqFG0nyV4DEbAEGm1jE6BoZjFBr1vvUUrmhHkh7yT9yMGuL+KjDRqR6euoPiOVaAwS8OYzFSQFTsTldxu+mX5aKrismkm+Nk/86/kvLNFC+0lD2053Wooe0kWTtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mFkQIFNLF0JEvzvxZrBZqdqdwIn6XjOQD83ZAmpnVw=;
 b=V1U5+bFxsMn6pOTsYELR4l4Lkru1l3aQIBH+c/ZphLV0DuGBdw+WXeTFT2wqKmubgiFVGWo3SEmhL+1FW+SFTIxgxf1zTkxnDSE571p/9ITAuFPlVX0sKr7pKn0ywWTyie5A/dGOZOo7ZDg3pbYVnf5caZmkfN7QT6FGpDmpZhiKZenWEfqWppbMQjaBEz80RQor2bF3Ybq837UjhnRR41aZJMKhVkZ3/GxIGHhkODj9CbnXbPqWe/IW6UrB3s1oXITb6EO+vA616rOp3vWAixsGNaJvgHKqqmCAbxfICC3bc0IuywhD5fAwH2RLnvXc7Y5/qL1hc3P9ThXXia13tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mFkQIFNLF0JEvzvxZrBZqdqdwIn6XjOQD83ZAmpnVw=;
 b=iT+3DhjwNH2wP3HdGJm78jsbbW8fkoBsz4Q09os4fVp8idN0ILx/cF33hp7XUl8GDOueD+Omt6Q9k/2KCduyAr1kzAvvNn6a0+ecaxP7tOSLSAKCECsathLCvebmQz9z7M3bvIpNXQ88/j1q4FJEZpyEBIjvXlVRKhsA7MpG7Xs=
Received: from DM6PR17CA0031.namprd17.prod.outlook.com (2603:10b6:5:1b3::44)
 by IA3PR10MB8300.namprd10.prod.outlook.com (2603:10b6:208:582::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Fri, 13 Mar
 2026 13:59:44 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:5:1b3:cafe::a4) by DM6PR17CA0031.outlook.office365.com
 (2603:10b6:5:1b3::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Fri,
 13 Mar 2026 13:59:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 13:59:43 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 08:59:42 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 08:59:42 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Mar 2026 08:59:42 -0500
Received: from prasanth-server.dhcp.ti.com (prasanth-server.dhcp.ti.com
 [10.24.53.104])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62DDx6Jk638000;
 Fri, 13 Mar 2026 08:59:40 -0500
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <n-francis@ti.com>
CC: <u-kumar1@ti.com>, <vigneshr@ti.com>, <a-kumar2@ti.com>
Subject: [RFC PATCH 14/19] arm: mach-k3: j784s4: Enable DDR_RET exit for j742s2
Date: Fri, 13 Mar 2026 19:28:55 +0530
Message-ID: <20260313135900.3430264-15-p-mantena@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260313135900.3430264-1-p-mantena@ti.com>
References: <20260313135900.3430264-1-p-mantena@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|IA3PR10MB8300:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a4de368-b3d5-482c-a95a-08de8108c70d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: YNDzZG8S1Pe7hntW17Ui17f2cPL53N2xuqQRiLiLQA+TVKLqJKyxS8IuWhFs+oBH9Sm/xhBYxe08Gvra/3cavtRn2BNbGjZ1BkpkBDFBNFN+tYiCgfvsptglzB8gYpQ6P3KXwGohIY9lwV91JHbnChu9RpQSGsDjQmg7yE4k436LIbeWKfnyOB0o1bDiTVDsuehfqgliCZmYY5VuWYW0blOE5yNuKr6InKlrk+iNt4HdI2EGk7eGYFfDQ1Vyp2Ho5laikXt8rfDBHJoVsEJgIfXxeVrA1IhPzq9xhUrhEU29qS5NNHyQ0IYq2FNZC1jQQeNC3O+FGDZZaOpufO9dRNa7kyW/blrN/moxWHOkElT/KU2pNnyezfOhFJ/oQS44juZrcj22bawPdRqkxTI0y5W0ksE2ZF4NvvpctRgbRgu37E5bJRhmx9/xX5vvd7Jx+TbdsVmaS5flzYBzqvVgUWF2KoFXLbJCK5YscAB6dTTPqjs147kz7yPTqMJgN8clzvKLfBSZ+m37qCNHDjdXUhazHKqnXub6eIeQWdA6RSH9Czp0Kg21+DQhTtDslzoV6sGgqIEJdz+b2naszk+kAiiHdcY2b0xcy7nZPB5zIAzoeIQlnZnK9oN2Qgrxig/OITayf6BRwIZjME7pid7GnF/jxVbxECdHaxQ/8UEwL6hJg7ehQKAA5BwqAHHOqObq7SmQ3WKF3qnTC2jDCxI7YHpwkL0nB4h+L1vJvW3bNxhqeGjw5WHDrxVdRb/HnB9ntc6gBmRfKkzdkK2mBeBWaQ==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zQzy9r8ZD1f3ps+j9Y7r22E6NN1jIZmQ11THjuqsOfDwAxov3C2ANmiWfDxdDSzn5L1WafTibA7lM1hbQXJW6kz/POGBwmiTudOumoqLIVBRxQBqNfjHC7H37mPdWZ54A383mLFJw6qRiCAw3yMf9mAQBxfzAsNFJdIEWan7Y6tMV/XKgIs81nGrLQ+Owwico3V9ZvxZpWS8/KP5lFoJLiqnooh6eNujDS9r4UYOvYOPvL/x4xwVOZE/iRoJD4464xUNH2vZ+0Dk9pEG3cI6aMSqOXxJWor+bVHRxOHECdVZ2hr/hvnPFic2E3aim5cmSEeIkiV3OJGibj7tQ35Gy4SNUGLWpFR4tjj+3kMOnnJpuy7fR9SvsJXXXgd4/X/uFnTZlNcNuJb1SS2yDdUH+nVbofeIP38zpboBFNVY0VwTOq0dC3UdlvR0Yj4BWNHD
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 13:59:43.1657 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4de368-b3d5-482c-a95a-08de8108c70d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8300
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

From: Abhash Kumar Jha <a-kumar2@ti.com>

On the resume path, we perform an exit from the DDR self refresh state.
The self-refresh exit sequence is performed in a loop for each DDR controller.

The J784S4 has 4 ddr controllers and J742S2 has 2 controllers.

Select the number of ddr controllers on the basis of
CONFIG_TARGET_J742S2_R5_EVM build flag.

Signed-off-by: Abhash Kumar Jha <a-kumar2@ti.com>
Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
---
 arch/arm/mach-k3/j784s4/j784s4_init.c | 18 +++++++++++-------
 board/ti/j784s4/evm.c                 |  2 +-
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-k3/j784s4/j784s4_init.c b/arch/arm/mach-k3/j784s4/j784s4_init.c
index f039eb3f752..be04f88d23e 100644
--- a/arch/arm/mach-k3/j784s4/j784s4_init.c
+++ b/arch/arm/mach-k3/j784s4/j784s4_init.c
@@ -24,7 +24,11 @@
 #include "../sysfw-loader.h"
 #include "../common.h"
 
-#define J784S4_MAX_DDR_CONTROLLERS	4
+#if IS_ENABLED(CONFIG_TARGET_J742S2_R5_EVM)
+#define MAX_DDR_CONTROLLERS	2
+#else
+#define MAX_DDR_CONTROLLERS	4
+#endif
 
 #define CTRL_MMR_CFG0_AUDIO_REFCLK1_CTRL	0x001082e4
 #define AUDIO_REFCLK1_DEFAULT			0x1c
@@ -296,8 +300,8 @@ void k3_mem_init(void)
 	int ret, ctrl = 0;
 
 	if (IS_ENABLED(CONFIG_K3_J721E_DDRSS)) {
-		struct udevice *devs[J784S4_MAX_DDR_CONTROLLERS];
-		struct k3_ddrss_regs regs[J784S4_MAX_DDR_CONTROLLERS];
+		struct udevice *devs[MAX_DDR_CONTROLLERS];
+		struct k3_ddrss_regs regs[MAX_DDR_CONTROLLERS];
 
 		ret = uclass_get_device(UCLASS_RAM, 0, &dev);
 		if (ret)
@@ -306,7 +310,7 @@ void k3_mem_init(void)
 		devs[0] = dev;
 		ctrl++;
 
-		while (ctrl < J784S4_MAX_DDR_CONTROLLERS) {
+		while (ctrl < MAX_DDR_CONTROLLERS) {
 			ret = uclass_next_device_err(&dev);
 			if (ret == -ENODEV)
 				break;
@@ -319,7 +323,7 @@ void k3_mem_init(void)
 
 		if (board_is_resuming()) {
 			/* exit DDRs from retention */
-			for (ctrl = 0; ctrl < J784S4_MAX_DDR_CONTROLLERS; ctrl++) {
+			for (ctrl = 0; ctrl < MAX_DDR_CONTROLLERS; ctrl++) {
 				k3_ddrss_lpddr4_exit_retention(devs[ctrl],
 							       &regs[ctrl]);
 			}
@@ -328,11 +332,11 @@ void k3_mem_init(void)
 			k3_deassert_DDR_RET();
 
 			/* restore DDR max frequency */
-			for (ctrl = 0; ctrl < J784S4_MAX_DDR_CONTROLLERS; ctrl++)
+			for (ctrl = 0; ctrl < MAX_DDR_CONTROLLERS; ctrl++)
 				k3_ddrss_lpddr4_change_freq(devs[ctrl]);
 
 			/* exit DDR from low power */
-			for (ctrl = 0; ctrl < J784S4_MAX_DDR_CONTROLLERS; ctrl++) {
+			for (ctrl = 0; ctrl < MAX_DDR_CONTROLLERS; ctrl++) {
 				k3_ddrss_lpddr4_exit_low_power(devs[ctrl],
 							       &regs[ctrl]);
 			}
diff --git a/board/ti/j784s4/evm.c b/board/ti/j784s4/evm.c
index 3fd1a00c683..e7c427c71f0 100644
--- a/board/ti/j784s4/evm.c
+++ b/board/ti/j784s4/evm.c
@@ -64,7 +64,7 @@ int board_late_init(void)
 }
 #endif
 
-#if (IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_TARGET_J784S4_R5_EVM))
+#if (IS_ENABLED(CONFIG_SPL_BUILD) && (IS_ENABLED(CONFIG_TARGET_J784S4_R5_EVM) || IS_ENABLED(CONFIG_TARGET_J742S2_R5_EVM)))
 
 #define SCRATCH_PAD_REG_3 0xCB
 #define MAGIC_SUSPEND 0xBA
-- 
2.34.1

