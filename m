Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C173CCF9F8
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 08:59:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86A0883B55;
	Thu,  6 Nov 2025 09:59:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dYuH/FJ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADC6883B63; Thu,  6 Nov 2025 09:59:00 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A29F883B4F
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 09:58:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-jain1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bhjDAyJ4/a0WXBuNz52oZ/ChnAv6N7XKCb9OIAk4Sv0Cli0guXEfsm8MSMAmLPpQ1MHZA9RD7YbS2qQ4KFhghIXEJg3L8j5xBvRrU2Iy9jAlaEFu3xn+WIR3q8MCk6kD86jiy/06tpS8sJ+WmH39LJrzmFf/H2cnAXzBAponBcMnVT9cpHtHgCoPH/HyLz9q8aB6jD0lQIhB3PoGQy/QtxoYzTE0/Zi9ko7HPloIC7eNrKYk894sWXoZwnif3sqGIefUgbZ4obqdFZm+yKGG7Q+dPK+OvHAbI6UBje5rt3noH+tZRbOzGrdBEWCpExFa8D/Y4OM4Zk7N4rTj91h4uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlYC1jLofxQ4FGtQz3YzuSTCAfpTbAsOpFFyeRQkKA4=;
 b=Zb52VfDvvBBl/54/jGpSzlhsVoksgJSjIHG9HqW4XkYf0pJMDFnLFj5zruYep4WNTmdbocssAmS6oeH1KnoyriQpyT/4JLudVaW8xb//OdQPWSk3IgjDXJ/DawNyec7eOkDHNEWawpsZrx6q5QNizj3tnb8I9XTMnC8TqVTCd8thxE28ZyMsHqFApIVswcO6jFlYt+4yXUvk6miihSY46sUdIfkyOatOcrqnfCarnsUCZuODxBxwIp1Ya0Th7bHFmgMomagYC9oWSzdqPnRSz+XwtoklOo5ywffVqmA7dvhxHvnC2GFr+9oTsc1n+wW34hfkuKMhColINcGXVsrYMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlYC1jLofxQ4FGtQz3YzuSTCAfpTbAsOpFFyeRQkKA4=;
 b=dYuH/FJ0iMlcf+QWVLu+9JSniZ8U0i0eVEa0fS9Z/nt9/uY016UBeI0MHubIRrdXKdSMRIe/CFhJEws4rtPq7ag+r+p/9NCirLn/jG1pfx42qvHIH95YE/YNEKc3YJdDUQPzms6xJj3Arc66Zr/hpXyflN4NJtupk3+o7BIACzY=
Received: from BN9PR03CA0285.namprd03.prod.outlook.com (2603:10b6:408:f5::20)
 by DS4PPF9390CCBA1.namprd10.prod.outlook.com (2603:10b6:f:fc00::d33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Thu, 6 Nov
 2025 08:58:56 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:f5:cafe::e4) by BN9PR03CA0285.outlook.office365.com
 (2603:10b6:408:f5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Thu, 6
 Nov 2025 08:58:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.0 via Frontend Transport; Thu, 6 Nov 2025 08:58:55 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 02:58:54 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 02:58:54 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 6 Nov 2025 02:58:54 -0600
Received: from a0512632.dhcp.ti.com (a0512632.dhcp.ti.com [172.24.233.20])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A68whm8994350;
 Thu, 6 Nov 2025 02:58:50 -0600
From: Swamil Jain <s-jain1@ti.com>
To: <devarsht@ti.com>, <aradhya.bhatia@linux.dev>, <n-jain1@ti.com>,
 <tomi.valkeinen@ideasonboard.com>, <trini@konsulko.com>
CC: <vigneshr@ti.com>, <praneeth@ti.com>, <h-shenoy@ti.com>,
 <u-kumar1@ti.com>, <n-francis@ti.com>, <u-boot@lists.denx.de>,
 <s-jain1@ti.com>
Subject: [PATCH v4 2/2] configs: am62x_evm_a53_defconfig: Enable A53
 splashscreen at u-boot SPL
Date: Thu, 6 Nov 2025 14:28:42 +0530
Message-ID: <20251106085842.629521-3-s-jain1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251106085842.629521-1-s-jain1@ti.com>
References: <20251106085842.629521-1-s-jain1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|DS4PPF9390CCBA1:EE_
X-MS-Office365-Filtering-Correlation-Id: dd9f4f81-65a5-48de-c2b8-08de1d12b78f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|34020700016|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RNovPD57rjGp+TIM45ieHHfff12sJBhzFLP/P2+nXzD2PyVDZgyzRhODMJJx?=
 =?us-ascii?Q?Jj5Gx3co76+OTvFiZabXIrq7MhJQE9K5DF8+aJGXx5ixoPjQ5JKdLSmYz2JN?=
 =?us-ascii?Q?RyVVzab2rGBY/DgBTk9POie7MTpTUSnAQOAnuf5wFL1f4qUFivKM9JckTidA?=
 =?us-ascii?Q?1EG5MJlRezkmSoii/UJDp3b2Roe13/VN/Z+gOKD68u6iV+c0KyAoRttNtTGK?=
 =?us-ascii?Q?nyoPii9Lr/+eGxrChXT6vSaYdNtQLIBtBDvX6V9h+yGKHNfFKa6JZIP5Yn4k?=
 =?us-ascii?Q?6SaveUPNXVMdDLiwxmLX84ewMAEXGTGMWU6+pgmllycTKqALE/47DGSB+I03?=
 =?us-ascii?Q?uKdxXO9sseLBzeiGfQnivtdCV8gia0QkhJXeKM7S3tn+0HsiVhKkeqM97o8A?=
 =?us-ascii?Q?2qMNdWju9LgdF8ajHk3CSSnMHM2lqX4SIKUSLDPv+gIECX8FQ2irMT7IPfo4?=
 =?us-ascii?Q?m7s6vcP6c3mc1IHzjGL7FJIwSnUhWKpulSJl0liC9gwVyUjyruawPhGKzD7V?=
 =?us-ascii?Q?6hHIaBxBaVyCCclA0gE7XJ0Dp1wX277y3r8XxZMI6ndFTSFVgUR3LzozIBR1?=
 =?us-ascii?Q?bH6fFJHxlBVu9V1dYh0WuCV534NEtH6aGoEZAXQlJW05mEPdcxlnubNYn2xM?=
 =?us-ascii?Q?og3X66VVhcBGvgScEZmMnhUxUs1Oh+1CZce4fqbrUc0AlwU3LtJFjvSFcoLf?=
 =?us-ascii?Q?PvlrW+/biXlE6tW8YZTUvHxNdWOQo5vmAjWuKDyP454GYQ67VHzjUWJGRuV2?=
 =?us-ascii?Q?2mNZ2mj63h4tdZDLhYokhuCMo5UkgJzMLnyf9lsvnLCRPg2cg4ZUI98TGHvL?=
 =?us-ascii?Q?FMtKQ9eZ70F/ZYJsk3VaqE6aW6tLytxCIujkHkit5No4GgekLQ74pjRm96e3?=
 =?us-ascii?Q?mBTsTpvTnXVChB6SzVpMHc/45Y82yJMMd3It0QRCYVduGDDXj1GDW+ZB9pat?=
 =?us-ascii?Q?LdvuTB4Q0x1n27olNj2ixWyg5fu+NfTewUjIl5nEjKH/FTp7qqLslGpSEKeL?=
 =?us-ascii?Q?4yLtwRbN2XsFiAWN/2+IR7QVbvTDNvq8Qlb1mv6k6DGXFLv7psGFFnFrCGaX?=
 =?us-ascii?Q?rcVuGCDl878w+EUny3d0OSkfw8zsGDah052OEYGK1szqKV5D/Dj0n5QAbjYt?=
 =?us-ascii?Q?ZplYvAMyxqU7oTOrY87UMfF03OoHTAv1mqp/VeN5OroBdPlgzBi3d6Vb/7aG?=
 =?us-ascii?Q?c0jLsA44DkTbrH31Qn61b6xnVABOlGVg0hnbbGbgJjboSoM+KdRoWEDXzTwP?=
 =?us-ascii?Q?DGwPwJoaTGl986LU8U54qpGuV0wtv0of6+R4hHarCxKbqfu1Ig1OD9ZapF5L?=
 =?us-ascii?Q?lzlhtfxpc56+9o4ecbMb4yui/h5XkyOnBfjmejrxJPgct1YmOf2vGQJw4rwz?=
 =?us-ascii?Q?ooyYzmbuh5EIH4mPtfSn2OqaBrvjbnXhjBckwfAKJImJamPiwJJnDki+0NcI?=
 =?us-ascii?Q?z329u1ZZqE5OgWct86ssBOjrHnweUOowRD3pLflV8qpmYEAkxZX0KZpQG+aw?=
 =?us-ascii?Q?NvR/t9xWCFC2s3Mf7h2bH0pzmuZAxmnEW85K6k8VbbSuB8O44gx82Mf1fKnj?=
 =?us-ascii?Q?IyTUl5Ye4F0xi3SpTP4=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(34020700016)(1800799024)(36860700013)(376014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 08:58:55.8240 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd9f4f81-65a5-48de-c2b8-08de1d12b78f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF9390CCBA1
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
to 0x80000 to accommodate splash related code. SPL Board initialization
Kconfig is set to dynamically update simple-framebuffer and
reserved-memory DT nodes before kernel bootup.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
Signed-off-by: Swamil Jain <s-jain1@ti.com>
---
 configs/am62x_a53_splashscreen.config | 17 +++++++++++++++++
 configs/am62x_evm_a53_defconfig       |  3 ++-
 2 files changed, 19 insertions(+), 1 deletion(-)
 create mode 100644 configs/am62x_a53_splashscreen.config

diff --git a/configs/am62x_a53_splashscreen.config b/configs/am62x_a53_splashscreen.config
new file mode 100644
index 00000000000..e043caad00f
--- /dev/null
+++ b/configs/am62x_a53_splashscreen.config
@@ -0,0 +1,17 @@
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
+CONFIG_FS_LOADER=y
diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defconfig
index 4da668396d0..2e857653cac 100644
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
@@ -143,3 +143,4 @@ CONFIG_EFI_SET_TIME=y
 
 #include <configs/k3_efi_capsule.config>
 #include <configs/am62x_a53_usbdfu.config>
+#include <configs/am62x_a53_splashscreen.config>
