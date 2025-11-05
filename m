Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E65ACCF9F8
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 16:31:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAAFA83AAE;
	Wed,  5 Nov 2025 17:31:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tc7ES18o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BAE183AAC; Wed,  5 Nov 2025 17:31:07 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1491983936
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 17:31:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-jain1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fO/bZuPZwwdUK5mPw8CC06k0WY5I66d3WQG0qKVdLUNNYn2RCTivg/dLWJcEuLNGELtoXVpRn9fAuzYGFN3tgnjjNTkTUSiiIgqT0qegNe1ROwlKOhJLbm8F5z38+SO0DqZGZMM5ePru40lzfxQLGwRHTxoq6LfsENshKv/YUPUFX6u4+D81QGztcYFvHgVm4hvENX+DJzQVq2A52Oaur7TWf97Jb1wH5TPNVCPNiD+B9cKCgDhAcwJ+JOqvV3yB35oBU1v+yM9m4IS89b/4YoKXhZya/wq0rRHdcZFrp/2bZqWoHH6+Qqnpc4hh8uRHvBsMvLLtIiKNsEED+cTcZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pn4hE9AzLUJf7AKy68/lsnDDjBEsW7Nh4G0Ks8xuu6Q=;
 b=xv8rtJw+yc7ufUqZWre8ImNqGbpFksWD6JPB5jAeTgupsYV13IRlO6YT7sOm/IEtRXlRI6E81Zb8afQbq68spGJYZt4tYJdxd7Qqhk0C3HLhlm/R7Njk2PfAqscPDObZidnHjPcwj56/FxoxdyncT5DIY7NFDtY+0wmWeQUpDEmd/aBH3prNojV/lj4Y1g9cdks28Cuuk7jqbqJVGywCyxGnhv76Z86wnE8X8MKZ4jtArQY1T0KBddArK72Y3x7vIS18+CqFn5qByYwy1xoGPSG24FtLc+NoO7UBXkZykUHjpPgcmTZkLPs0HD3mH56BnNOD629PbFHeE8BvrGvABw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pn4hE9AzLUJf7AKy68/lsnDDjBEsW7Nh4G0Ks8xuu6Q=;
 b=tc7ES18oSq2R8gkj71wJz9N++9IXTu1KSWxBnhUeGFoEFpavoSVRGbqOLjZdmcK+jJxV0zPJuYTrpJH16iVO6Rm/l4Z5yc9paEa2DIcpNH0SkF895YAoLlUIa6C9SL0mzw8XVnFhgtgirQ7sYuxCZQAUBvLeCXLN/WyimDPgbAU=
Received: from BY5PR16CA0028.namprd16.prod.outlook.com (2603:10b6:a03:1a0::41)
 by DM3PPFC7DCDCAD9.namprd10.prod.outlook.com (2603:10b6:f:fc00::c4b)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 16:31:00 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::ea) by BY5PR16CA0028.outlook.office365.com
 (2603:10b6:a03:1a0::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Wed, 5
 Nov 2025 16:31:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 16:30:59 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 10:30:54 -0600
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 10:30:54 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 5 Nov 2025 10:30:54 -0600
Received: from a0512632.dhcp.ti.com (a0512632.dhcp.ti.com [172.24.233.20])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A5GUfsN4005513;
 Wed, 5 Nov 2025 10:30:50 -0600
From: Swamil Jain <s-jain1@ti.com>
To: <devarsht@ti.com>, <aradhya.bhatia@linux.dev>, <n-jain1@ti.com>,
 <tomi.valkeinen@ideasonboard.com>, <trini@konsulko.com>, <jd@denx.de>,
 <tl@denx.de>, <agust@denx.de>
CC: <vigneshr@ti.com>, <praneeth@ti.com>, <h-shenoy@ti.com>,
 <u-kumar1@ti.com>, <n-francis@ti.com>, <u-boot@lists.denx.de>,
 <s-jain1@ti.com>
Subject: [RESEND PATCH v3 2/2] configs: am62x_evm_a53_defconfig: Enable A53
 splashscreen at u-boot SPL
Date: Wed, 5 Nov 2025 22:00:40 +0530
Message-ID: <20251105163040.4086273-3-s-jain1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105163040.4086273-1-s-jain1@ti.com>
References: <20251105163040.4086273-1-s-jain1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|DM3PPFC7DCDCAD9:EE_
X-MS-Office365-Filtering-Correlation-Id: 3655830e-5a8a-4c42-29c2-08de1c88b456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|34020700016|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vkB9xPg2q/6fZsGsuu/wEhMZhtRXFE8UuzsjF3jEhV49XqI6uBXGYtgRFtca?=
 =?us-ascii?Q?3sQ3NBsYqZVjSi4szIM5JzyyKBkOTvSKweJpXrdWCJNq98Vi+uxjcDGBYCtH?=
 =?us-ascii?Q?nRH/V/cZhb6Vqvs9sjeEmDQFYtS8SkWWhb3GK5tkoXiRMGpSLYVbYYK5pRuY?=
 =?us-ascii?Q?j0elfFVkqJyWFwAZOYDKOLev4gfi999/iWsMxMHX3IXbFNB0H0DNqRbER81V?=
 =?us-ascii?Q?FVGlA/5erA0U3rt9fhFY6G03KRpZO44zVgdtk9yk6w9VjOls4RdJ/YQHqB50?=
 =?us-ascii?Q?w0gfihQGFjimrvG0jm4m34uWG86p8Hdl0VILllgkYYQcRXPSA5M4zKG8O6uC?=
 =?us-ascii?Q?K9Wu0nOvZNE4TtqF6VTaMvM4RLF5NesWsHqRqvo3M0dhyfDLQSJjKZIo4Qry?=
 =?us-ascii?Q?9HkRZx4w2+9wyWHBnq0M90L+fzp+S+cFqlfT7hEAUsyfxXezeE1N7uedVrde?=
 =?us-ascii?Q?T+hDUBWRmvDg4iWOlztz18GlIGflfySYfhAbZqPIad+KRCvPrc1ykvx3czKk?=
 =?us-ascii?Q?OyTv96d7fAjtdh2ZPZvodwxjzsgtIXE6gT3FJhxX2VHNJ7ZohMXTq3Z7ESuz?=
 =?us-ascii?Q?jitvrpQzObtvoKlZgp3XDMoFy4X9Xk9c3J1h2/wxzU/uv/+YI67pNlaCZUk5?=
 =?us-ascii?Q?VsBTVA7zf1HCnClrrbYI6JK9y86YhhW8rFyVYAW/YERmIvX8/JvDP4FR6qPa?=
 =?us-ascii?Q?VLWkK2qpxFtvtUcC2VpCTUVKv4Vxiov/vmUA5wxhoKdc+tLfO4vv8HxhhPEo?=
 =?us-ascii?Q?wgRrBRt7zlGsidEskHi0IjibtzSNimB+8Z9y1tpgM3rqm7f8v7KjI5DBPbHJ?=
 =?us-ascii?Q?Ln+iPGghqWWsdNxQHrxvip1TYRJ9sipHfU5+faj3JUx1512RyGbS2l4Md7/u?=
 =?us-ascii?Q?/DY5nEh+XwdPoHlRRxNa4yKst5O5VGPIFx0DtrL00X8C1xNKFUfUM8NR/lff?=
 =?us-ascii?Q?J76zjWgrwsWQIMj8gf0N+yEiPLnew0C8aqlpXdm9pw4VUVt6nefrE7CVnPss?=
 =?us-ascii?Q?yAT+/br8G3nhYUkunx/C7mEMI6aDavuIPsx9TG8cNkZvnIOsIqcPa3GaU0b+?=
 =?us-ascii?Q?ZCvV37calQ8EPvkRxcyerUewGWp5P68ziGe8LJF7BisU8X0eA2ddoJhdHHPC?=
 =?us-ascii?Q?sEZg19ujbT0c2sT9DWznFIQeYMLEJno/lsgLg53g3dZBOyp4m9+eECot3pLV?=
 =?us-ascii?Q?m98vbHEEx3DkX/qrf+3nOYfMsVZlRg2YVEncImvVLXJmqeb0muTbJLRsxVWc?=
 =?us-ascii?Q?+wLo2B+OXknS7Fe5vRJND5xT4BU6Z1qV1Kon3/pxqf7nBeK4BV7O0Gxs2dV/?=
 =?us-ascii?Q?QIUSXeGzOeODhZPPiB3OAkcHqvYfix6bRZlHiuiXpxRYR2rJHw9otkOQ5xU8?=
 =?us-ascii?Q?etzM3CZ33sWD5xVklwrHrR5RzpsEctJ8yZaSOI7re05YnSFo1sWcDGibNh6N?=
 =?us-ascii?Q?8KFjSU0Kwrvq+qX4K4/Uc/CEnCXXjYRDuaPU6h1KTtDYeVtlmj2yWUL/eKQv?=
 =?us-ascii?Q?jZdDDSebPstVJUfvo5QClU202N2qClByjZiRd3CDA+uJy7khjxwNgZ7HMsp2?=
 =?us-ascii?Q?3GlEOXBQBMU/0V0NPMA=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(34020700016)(376014)(36860700013)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 16:30:59.8699 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3655830e-5a8a-4c42-29c2-08de1c88b456
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFC7DCDCAD9
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
