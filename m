Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B3CCCF9F8
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 16:15:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 771C683AA4;
	Wed,  5 Nov 2025 17:15:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="jATRV7xF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B06C783AAD; Wed,  5 Nov 2025 17:15:04 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9390583A9A
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 17:15:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-jain1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FYOo1Lsa/30OmvZb67UAIUy7FW+i/tbKYuIy8M/hJbLZRh0LHLl/z85KD+9An4hAOF3PGhdp6JbBmvahw4LjOECSp+R57QJC/XszUkJ02SU5FHxH4KjFoPCI7q3z1pc5rqoIFh2sijwbYMFUfeFhUAgcPh5LcNp6JiUtjwQDgpd0+O+BCSyf/LHFACn5TD/6RrvmiH7zKSwney335bdLKEi4oNc1bPi+U++WKCqmNzNJpuvfM9mz0skaKE6AW/y4bGNJcaMD487g8EQQ/Qjf1AhyAj3qJJPwRVD29oHo2ihfdZP1rZB34tVZX6i2KH6c/Bmy8KvyiArrxcSk55+taQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pn4hE9AzLUJf7AKy68/lsnDDjBEsW7Nh4G0Ks8xuu6Q=;
 b=SgQBq33TuGJtdmLqCKTGZNYI9hi57wCsN9nOIRYjHl8DmF1cnmOyXxx2Tyqsa6xT+jIhe5BXXcfb9EaxxaJAXXsRq4OL5pCjCFm4QUPoiMXjRd6qG9nHkl1D1lIKmdfk30lypekCl0TEApx8+7nCO3aDxH928rmQ/AC6cgk6QJis4D+f4SpsW14eikGeR3GXPM04uYKdj59kI1NaJ+O4vHPdTs5NVsImhRKVkq7kDMigWk0U1k4r/2Y7JLx8c7s4Ni0wKHv+ggEnazz9fbDi2ed1qw79mnLCGkWXovx3mS68+FMYaPiRxWfUBTW4KbHvLgYmmfovkTcU1qWUAgpMrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pn4hE9AzLUJf7AKy68/lsnDDjBEsW7Nh4G0Ks8xuu6Q=;
 b=jATRV7xFLw68Qjsxdk8O5aiwtkA5C6B8BPfp9XEsGniZAvlk7tBFWH9AN6JyJjJlkVx47sMIaQCwexe5WbgSRHGtN620WFijM0s5qLFHqhmmM1Ze+nL+cgdjU1B39YXu2Vjkxf6Dd2PGqlt/pWRXNxz25IP/UD9pUQdO0fJZS6Q=
Received: from PH8PR21CA0008.namprd21.prod.outlook.com (2603:10b6:510:2ce::29)
 by CH4PR10MB8171.namprd10.prod.outlook.com (2603:10b6:610:242::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 16:14:56 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:510:2ce:cafe::3f) by PH8PR21CA0008.outlook.office365.com
 (2603:10b6:510:2ce::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.5 via Frontend Transport; Wed, 5
 Nov 2025 16:14:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=fail
 action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.0 via Frontend Transport; Wed, 5 Nov 2025 16:14:54 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 10:14:50 -0600
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 10:14:49 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 5 Nov 2025 10:14:49 -0600
Received: from a0512632.dhcp.ti.com (a0512632.dhcp.ti.com [172.24.233.20])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A5GEbF13983374;
 Wed, 5 Nov 2025 10:14:45 -0600
From: swamiljain <swamil.jain2016@gmail.com>
To: <devarsht@ti.com>, <aradhya.bhatia@linux.dev>, <n-jain1@ti.com>,
 <tomi.valkeinen@ideasonboard.com>, <trini@konsulko.com>, <agust@denx.de>
CC: <vigneshr@ti.com>, <praneeth@ti.com>, <h-shenoy@ti.com>,
 <u-kumar1@ti.com>, <n-francis@ti.com>, <u-boot@lists.denx.de>,
 <s-jain1@ti.com>
Subject: [PATCH v3 2/2] configs: am62x_evm_a53_defconfig: Enable A53
 splashscreen at u-boot SPL
Date: Wed, 5 Nov 2025 21:44:37 +0530
Message-ID: <20251105161437.4064391-3-swamil.jain2016@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105161437.4064391-1-swamil.jain2016@gmail.com>
References: <20251105161437.4064391-1-swamil.jain2016@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|CH4PR10MB8171:EE_
X-MS-Office365-Filtering-Correlation-Id: 421f696e-0160-4f2f-4804-08de1c867535
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|34020700016|376014|48200799018|36860700013|7093399015|61400799027|43062017|35450700002;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0UMNShus6mFW8Wo2aCHsIYV1FpKwA9re7g1R3wm5id0hgIjfATUKFZhB7dZf?=
 =?us-ascii?Q?XNEMg3oxW+p4Nc81h68yMqoLpkggOyjLcNCwBpeN04TTfaWTR4lXZiz/45MN?=
 =?us-ascii?Q?6C1NyNVCxtZDPsY6R6jhJxNnVMNmkzEy5BQm/QTgIyFyBzJ8CZtlPOPvJtiM?=
 =?us-ascii?Q?OVGR121RrJez6hRK+qAY8C+F/7y48vmd8haeQ+9VG0JqJYd6C7qx1wKHfM1u?=
 =?us-ascii?Q?hGDn/xhVYiRQ/gvv8liX22o/+9f81ee1yIlD0qfy00Z+Qztss5WRumGJZMuc?=
 =?us-ascii?Q?OTDH554YfHEPbldcIV4BHJ3fT6PKvx57gvPWLqemWCUs6F9H7KORdyrONH+m?=
 =?us-ascii?Q?bzC383/jFbxBUgoffNXJPlIy6tVzhH8a7DL2R+ZQEKIluhkXMaH+nEhpm6jn?=
 =?us-ascii?Q?vs69gmiR3Cf7NR0B6OewqRzWVKYeopXHFFzHd3Qe+xBlm9v6MLOQ/Lk87Qb/?=
 =?us-ascii?Q?iPK1LIS/jhSbLc+0Ns1XdnRspMFkLQkkWlOjaVXx4jyI+QBIoYpU2J1+c4w+?=
 =?us-ascii?Q?4MnO+wmyd1CnYfz9OF5bWCzYVCOFFuQnCSp9CP8Q5xQgxlJCL4L+EC6NM60U?=
 =?us-ascii?Q?XSaZA1tMwQmgEyBO4hSlHneQgYoo38LTNWCqabTUdRnwUPh7alhQVjy+W6Wg?=
 =?us-ascii?Q?r+k6EVsuELIkIk7H1ICJsss6qgZXsG+KhZulN8xpW1nOS8q8qv6NXdZJHuvk?=
 =?us-ascii?Q?yoU7fz7PMx8q/6uc4jDi5Lq0YnNw9givJOEgnEsPcZnzvLUZpaHhkro9mgGI?=
 =?us-ascii?Q?IFwPjf2892rmZQl7Eya1QofoehZHi3CDl9CfEZtRpxOGE/IABR2U87GncY6m?=
 =?us-ascii?Q?+yhlmWKOu3Smths2k0yjtfE6iZsrnYlHYXLl026j0cP2W6mZGeYrMbzicyp0?=
 =?us-ascii?Q?bFo6t0hJrcettHO8lm54h0MTvqlZTeoJMNhf2MWBEpsGTR+Uwf6e9gR0wKdp?=
 =?us-ascii?Q?UbcrvT/yzU6JxxQ2FvqzcwJYga8Za4BkbdCy1Y66PIOAifqpAkgLMoLTwEVf?=
 =?us-ascii?Q?sIFlpysI0o4k5eoqShvd8+ZeMHRBFn4Vy2+JBKTR1/y3eT3anjcgSBk7Go0L?=
 =?us-ascii?Q?o19+EFYV/wHHfPN48OEjjceYEGhdkCYk05staFrz8kILH6zGfvVePO5OcF7Z?=
 =?us-ascii?Q?w/gidD0uYJik5PP0qpE6fUo18xu+IF+ogk9fqjeLcE6jIk/mBlQO/Rq1qnKh?=
 =?us-ascii?Q?gjqGbV7cH/tRV3IqjUHzGcIlQRs7G1mVNoRb5BNPj4qo2L7a3N0cIJLLDF7X?=
 =?us-ascii?Q?c/4Tto+m+TfFj0Ji5bBpW9ZJZC6nxW5AqVbLpcn7faCyj4k/AeO/dc7bq15j?=
 =?us-ascii?Q?jocGz2M0UoypGm7mo8htcjolg2lHk+0WJ8IqLWkkP8CwkubUdUSpscq/lyjF?=
 =?us-ascii?Q?EIzGhdiACQsriEg1ZAzBNvmOpTL9cuq0tgKrUAznkUM6jnOlJZAppC8St4YD?=
 =?us-ascii?Q?wGQ+Z2hbYCabjyRzYKi/GBBs0/tfguA0c+fSyKqrKF1qQy8l6oM/F7qeKbto?=
 =?us-ascii?Q?TZUhoaBP+9k8+NYBSEhZ3maDLghkdtlhu+K/jVKJ/mupXKq1dMxcg6jmH8O2?=
 =?us-ascii?Q?oxm8g8eMJLS2hKxsakgRQuRaNjasBYjL26pfcZ/fXjxtDoBpshTUH2W7f5Wu?=
 =?us-ascii?Q?4g=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(34020700016)(376014)(48200799018)(36860700013)(7093399015)(61400799027)(43062017)(35450700002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 16:14:54.9479 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 421f696e-0160-4f2f-4804-08de1c867535
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8171
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

From: Devarsh Thakkar <devarsht@ti.com>

Enable A53 splashscreen at u-boot SPL stage. SPL_MAX_SIZE is bumped up
to 0x80000 to accommodate splash related code. Bloblist related macros
are enabled to preserve splash context till u-boot proper.  SPL Board
initialization Kconfig is set to dynamically update simple-framebuffer
and reserved-memory DT nodes before kernel bootup.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
Signed-off-by: Swamil Jain <s-jain1@ti.com>
---
 configs/am62x_a53_splashscreen.config | 16 ++++++++++++++++
 configs/am62x_evm_a53_defconfig       |  4 +++-
 2 files changed, 19 insertions(+), 1 deletion(-)
 create mode 100644 configs/am62x_a53_splashscreen.config

diff --git a/configs/am62x_a53_splashscreen.config b/configs/am62x_a53_splashscreen.config
new file mode 100644
index 00000000000..0419d60e281
--- /dev/null
+++ b/configs/am62x_a53_splashscreen.config
@@ -0,0 +1,16 @@
+CONFIG_FDT_SIMPLEFB=y
+CONFIG_VIDEO=y
+CONFIG_SYS_WHITE_ON_BLACK=y
+CONFIG_SPL_VIDEO_TIDSS=y
+CONFIG_BMP_24BPP=y
+CONFIG_BMP_32BPP=y
+CONFIG_SPL_VIDEO=y
+CONFIG_SPL_SPLASH_SCREEN=y
+CONFIG_SPL_SYS_WHITE_ON_BLACK=y
+CONFIG_SPL_SPLASH_SCREEN_ALIGN=y
+CONFIG_SPL_SPLASH_SOURCE=y
+CONFIG_SPL_BMP=y
+CONFIG_SPL_VIDEO_BMP_GZIP=y
+CONFIG_SPL_BMP_24BPP=y
+CONFIG_SPL_BMP_32BPP=y
+CONFIG_SPL_HIDE_LOGO_VERSION=y
diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defconfig
index 4da668396d0..57d0cec2222 100644
--- a/configs/am62x_evm_a53_defconfig
+++ b/configs/am62x_evm_a53_defconfig
@@ -24,7 +24,7 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x80c80000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_STACK_R=y
-CONFIG_SPL_SIZE_LIMIT=0x40000
+CONFIG_SPL_SIZE_LIMIT=0x80000
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x800
 CONFIG_SPL_FS_FAT=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
@@ -88,6 +88,7 @@ CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_OMAP24XX=y
 CONFIG_DM_MAILBOX=y
 CONFIG_K3_SEC_PROXY=y
+CONFIG_FS_LOADER=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_SPL_MMC_IO_VOLTAGE=y
@@ -143,3 +144,4 @@ CONFIG_EFI_SET_TIME=y
 
 #include <configs/k3_efi_capsule.config>
 #include <configs/am62x_a53_usbdfu.config>
+#include <configs/am62x_a53_splashscreen.config>
\ No newline at end of file
