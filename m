Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36325CFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 15:05:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8DA884589;
	Fri, 28 Nov 2025 16:05:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WeM1sPW6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68DC484595; Fri, 28 Nov 2025 16:05:15 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDA0E8457D
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 16:05:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F2SbuFUFs1T8KxrLC2RxTUx9LK9HwePlNfQ8bBoVtgBAPXq1+FW7vI49JZFAVErYXxpAQrimJS8EhHOWEL2SMe1rB/9FQnsN5jGDSZnDMtrSRGm6qN7abtdDd++fiKyrtCkgqNTqc3FLQwXXYXCtGOxmjB8Ye53qerdqg8/YBRskuIsQyH9VvzUpDMCyCQcO+I54k+7oYzXwZOVSBWd9vxRTyUGNcTu7X8Vy8JmH8XnyQEwOW/Pv/ug8LsK4skcceugynJhxGgtcGnaVEJDTHuATawmCM3gga1YFhNlInPN/SBO+lcFgD2tD19Dek1QJQRsxtj90irMqy3s2PVZK6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ecs0V/vgYj5UwVFj1ccG3mcI6Uhdoe/EFRMnh6X1i0A=;
 b=FwLR6CLGuSQGsCWGn9j4lHk8tORyrlXS1Gv2vdrJLKMyzOSHiDdS7apam0RcBF6EH8k2/lw/eVLiYEUxAgFgWRYGcSN2Dy2aqs/ofN7iWghhxi0rd6IGITXds+1q6oFzOE5v3qI1mHCZdryteLpdZZ3ibatvRhvdc9KgM8kPqFJuruSYTWYF7WEZiQ7juIseVZayi0B9xC4/izh5b4sYBe0dTOrY6J1XDk1qnGJRP+g31BoPKd5S5xxyuNzFThicSbD+FQbXJr+riKCrIMplPFZ4oULixPhlj5uAUY8vr95A9u11qRV6UO9X/rbKFJogvv5KIueVvFRANHlHmP6ckQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ecs0V/vgYj5UwVFj1ccG3mcI6Uhdoe/EFRMnh6X1i0A=;
 b=WeM1sPW6TzVHFtAPFPS72wnPRNNjZNej2xXh4M6CvMMfZWNnbsu8FuySxeUX7FVD1AF7dxg7P822sxlsoY8Bta+j5ZFzgiKrSSW4cChe2AZg01fgMZsAeBwozXCeoZPiMZLQeUg6ok3wH1IKEl9nISbAx5YDS8Fkjk2HDV0YNBU=
Received: from BLAPR03CA0053.namprd03.prod.outlook.com (2603:10b6:208:32d::28)
 by CO1PR10MB4674.namprd10.prod.outlook.com (2603:10b6:303:9c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Fri, 28 Nov
 2025 15:05:04 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:32d:cafe::4b) by BLAPR03CA0053.outlook.office365.com
 (2603:10b6:208:32d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Fri,
 28 Nov 2025 15:05:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Fri, 28 Nov 2025 15:05:03 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 28 Nov
 2025 09:04:58 -0600
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 28 Nov
 2025 09:04:58 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 28 Nov 2025 09:04:58 -0600
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ASF4t9D489066;
 Fri, 28 Nov 2025 09:04:56 -0600
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v2] configs: am571x_hs_evm_defconfig: Reserve EMIF memory used
 by PPA
Date: Fri, 28 Nov 2025 20:34:55 +0530
Message-ID: <20251128150455.3279166-1-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|CO1PR10MB4674:EE_
X-MS-Office365-Filtering-Correlation-Id: c6f00629-5a36-42de-4df3-08de2e8f8295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u9Bh/2Nm+5nz5ibZvqKqzkdtM1sL8eC6/MYA1mZohecKEXGUa4RL9tSyrsMw?=
 =?us-ascii?Q?yn9rEs4llj2Igw7Am/WZ3JKbgWsnjm+MGDMs+LXj7/UmV6ZTC5awCPuL/wkF?=
 =?us-ascii?Q?Wqf1WISq5L4K4NE7moMoR38m+JklKyAB27ECjGwmclnV+AaNDcz9xbAaeFTa?=
 =?us-ascii?Q?68vK+XQgns/z0p5sQiEzR28vv5t4pI0a+0LVVHLjsDZoChzE9q/zknbpwjEk?=
 =?us-ascii?Q?n92cQf9pSR4waiFGHyloFRjT5gtHdqwhY78wO+oWQh80Oddy19jDGCa4c1f4?=
 =?us-ascii?Q?0muCPYMK0SEFsp4Hi3n8EnrmJdN0RIpuuJN5i+nJzva1aDZPrGObZXloEFxl?=
 =?us-ascii?Q?SUHzGZb3KHAIcv45oijh5/qGIrLEIR6HUPEO2WxMhqzeQFkpE4jA8R7h2eP7?=
 =?us-ascii?Q?lO4hg1JHL3KRDyJ5iTR1Ggb+fF943fKLCgCKlquLcW4XiKhh9wYigk4CLRRY?=
 =?us-ascii?Q?2duQw9RDmcDCWFc9qwjfdA5b2DOsUuqx9w/VDIefEwycnKh7Oscvx8w7m7+N?=
 =?us-ascii?Q?4svrLMZW4/9TvNf7im8f5srpy926vO820JhmMvhGnNBCVInqv3QcChv4SJO3?=
 =?us-ascii?Q?XfsOzYEfc8OpdZmD+9jBN+bZRpV9cWHGJYdfex8heIfHqOgvwMi+n0eZH6m4?=
 =?us-ascii?Q?Dy51d78Ky0UeHlUsN2cFNTv+w603zsYIcdNnqTv7xNjdWQAQe8nYr3PA+FKz?=
 =?us-ascii?Q?oLRMBIiDaXwMOAu50CLexcQmsh9MtLGCs0Cf0jCY/8SiamqzwZ6XySfIXT0e?=
 =?us-ascii?Q?YejsnswZVgPWDqxY4KFKDqvYqOixSw4HgEwX2Tfsz/m7RHwB4pGZl9jNS5ag?=
 =?us-ascii?Q?x1lvqJtKg7SvAB46YDVgnhVK1Blp1NUTElz501ehEvCLCa0Cc77oanT/88XF?=
 =?us-ascii?Q?ntZYqoxZi6T5ogwy+dkaVAI3S+n4Ph0daw67dpG03xaxFb/QoQxfv8toJLD8?=
 =?us-ascii?Q?gXs2OT06tOpPoi8IWWayZ2Fbmvppjh42Z7m8wR4PXMClpSIQbtkDINf3fycx?=
 =?us-ascii?Q?DMnCfYfp0TeMji26pEd4Qh0OrDw3AFauLQNiVYiy806qv0cAJ7yPWJRzehFX?=
 =?us-ascii?Q?OHc8vW07rfY9hPWL1mFEE212nrsNUO1/ltqrvcRdPJedswIatN/VdOzXYQVB?=
 =?us-ascii?Q?DPCbkNTWcuVmG46/oMbiEv5JjTQd2E0igCcvB/2NehXny70/VEvSuoCQzb2k?=
 =?us-ascii?Q?T1ZNM5GFIa24Gy36IudwCfFMpIZOCnc+2TwHxu14Mzi5NpF69USDc6N36AWd?=
 =?us-ascii?Q?vF3PFy3Wxgo/QCMdDvzGaAQsicAam7/HItP+rqwfJlu+v2mp79v2nlvSuTdl?=
 =?us-ascii?Q?d1JQVtblReZYfHGy8tVM5y/V/o8o+xAodkCV5DtMLjXvLQby3XdLj1pkLgZz?=
 =?us-ascii?Q?geKBrZImORIJoTMenkFGFjG9GipmJ95GyqmIMwkgrqcHNG1eiDLHXqPuRGd5?=
 =?us-ascii?Q?QlJF0mqBCw4/tNrd7m9ze9U1q6wJkj6Q2ujyO5jlYgcbvV61oAygo/qfPmix?=
 =?us-ascii?Q?I4PwyrLsGEc5dz5iRB3/t0SPmQLxwD20AJrL?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 15:05:03.8596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f00629-5a36-42de-4df3-08de2e8f8295
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4674
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

The AM571x SoC has 1 GB DDR space. As part of normal re-location process
U-Boot copies itself to the top of DDR bank. However, on HS devices, the
top 37 MB is used by PPA and is firewalled. This results in an exception
and the boot fails.

Introduce a new defconfig for AM571x HS platforms and set
CONFIG_SYS_MEM_TOP_HIDE to reserve the top 38 MB memory (aligned to 2MB
as per page size for ARM32) for the same.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
Fix boot for TI AM571x HS EVM board
v2: Changelog:
1. Drop [PATCH v1 2/2] in v2 series. There is no need to add reserved
memory node in DT as it is done by U-Boot as part of FDT fixups
https://github.com/u-boot/u-boot/blob/master/arch/arm/mach-omap2/fdt-common.c#L72-L107
2. Add entry in MAINTAINERS for new config.
3. Update commit message to use memory size in MB than raw hex bytes

Link to v1:
https://lore.kernel.org/all/20251128064353.1295063-1-b-padhi@ti.com/

Test logs:
https://gist.github.com/3V3RYONE/e86b3f4551986b0400d0e0f66d6ecc66

 MAINTAINERS                     | 1 +
 configs/am571x_hs_evm_defconfig | 3 +++
 2 files changed, 4 insertions(+)
 create mode 100644 configs/am571x_hs_evm_defconfig

diff --git a/MAINTAINERS b/MAINTAINERS
index b43dae882b3..e5d564cd760 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1780,6 +1780,7 @@ F:	configs/am335x_hs_evm_spi_defconfig
 F:	configs/am335x_hs_evm_uart_defconfig
 F:	configs/am43xx_hs_evm_defconfig
 F:	configs/am43xx_hs_evm_qspi_defconfig
+F:	configs/am571x_hs_evm_defconfig
 F:	configs/am57xx_hs_evm_defconfig
 F:	configs/am57xx_hs_evm_usb_defconfig
 F:	configs/dra7xx_hs_evm_defconfig
diff --git a/configs/am571x_hs_evm_defconfig b/configs/am571x_hs_evm_defconfig
new file mode 100644
index 00000000000..7e44ee5221a
--- /dev/null
+++ b/configs/am571x_hs_evm_defconfig
@@ -0,0 +1,3 @@
+#include <configs/am57xx_hs_evm_defconfig>
+
+CONFIG_SYS_MEM_TOP_HIDE=0x2600000
-- 
2.34.1

