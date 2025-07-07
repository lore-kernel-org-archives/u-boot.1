Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E18EC8303C
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 09:21:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88F1883046;
	Mon,  7 Jul 2025 11:21:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Mjis7cup";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D6BD8304D; Mon,  7 Jul 2025 11:21:31 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::60b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C79083043
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 11:21:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7QZdxbe5EeTbPz2/sbkrLVDw8ZPITio+ELG8RGI7GRQO/ssFg1DPO//+xU098WHXeX1pYFAuo+niwr7nIeqWpjTcAgAGtuTD696PYWHpRgh0t6I6fvHNKIp/63/OEHIHm+E4X48aVp0tsE0+QLYKoVK75EmKXWigLUovHEqsEh0hLdjjpGufumeyL3MTfhAYJ1PlVBOqBw+lykKRL1uncK5P3fibMgVRmmRy+FgbbyW//WMsYpOJ5j/KxFSo4a4oQdVYp4yxv7Ib/PdM2REt6ATn8Z7ESCMgiln33YGNX/pEkZPI1HNUlf77R4Jb10IQHkyR3VnfuFF4M3y3Z/zYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EeqZVxx86ijm01qCi0RYhsM4xsaO/mv32DgccLVCTyk=;
 b=p7nxZQHWxGNJl5ezrb7GmKyGy2irIT/+65ZKfx0gka1dJQjA/2vpwV5se8/mYxQF/5W9MnsCUmmGSFtF/NNUr/1xJSXOwAdltilVyYfmIAUyqhXLYF2Y+4LJOPae8JHhh7sYq/50d5iFaj7B12a+dUmeKivqctgVdM66E9ZFKF+ZVxhkNTaMOcTGA1/vm18byEvUkJcA46wGhdldG0ZQqrKQg9gK0WcgkN6nkvj/TfpPONlMM3MgZPtua9erXp9kR3SWkFIjA5XtXuwmKGZwjw4zywJOhqlyMXFeKp8e1QwLdsDBZlukMhYJWv7iPMDsQMovidLIr7AJLFMYaQVeVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeqZVxx86ijm01qCi0RYhsM4xsaO/mv32DgccLVCTyk=;
 b=Mjis7cupX/wHSMS1PPHNGbp/4UdqrIFBVjRK8BXS13vPFjM4+s4IXXC7GZ2FooYjBkgjTOPIaaA7zGsRgVIsXzMSK85dMwmOph4i2KpdgHqQQC+MD8ZcjwxVppttDxs4LzsjrIlsp9sG3rkqJxMRGxYLu3da3PSUcNghe5jBVTY=
Received: from SJ0PR05CA0034.namprd05.prod.outlook.com (2603:10b6:a03:33f::9)
 by SA1PR12MB8841.namprd12.prod.outlook.com (2603:10b6:806:376::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 09:21:23 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::ac) by SJ0PR05CA0034.outlook.office365.com
 (2603:10b6:a03:33f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.17 via Frontend Transport; Mon,
 7 Jul 2025 09:21:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 09:21:22 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 04:21:10 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 7 Jul 2025 04:21:09 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@amd.com>
Subject: [PATCH v2] arm64: versal2: Remove the ZynqMP Firmware from mini ospi
Date: Mon, 7 Jul 2025 14:51:02 +0530
Message-ID: <20250707092102.831697-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|SA1PR12MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: 38a86d55-3465-41c3-a0ce-08ddbd37a408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f2MSAB33eO06g0A7K11yVZUdYl7OQgqBuc0bwuaiO9YWIzgsVZbINp2LggbY?=
 =?us-ascii?Q?U3fqbFb7NLm6S3O3+o/uq8Edn8jQnF0ohZ2cBWYkbihfo++ZUVHNBolFjUul?=
 =?us-ascii?Q?L2i0C7o+6I/th+7jOM3G6X1O6NV3XELT50P+vbiTCtwYUQmzqNeNXFFpA+ia?=
 =?us-ascii?Q?982oQTxVFGWENO7s6RJfcyqvrPBIUjDlUQQwc8k24dLQvfkkB1BqhfSTjdc3?=
 =?us-ascii?Q?gF3lujwpNUmeLWamTYx+ciUFkfbzb5j1/HQObHZ5UbWiw/t9A/xZp8aQ5KRF?=
 =?us-ascii?Q?LoZFm3fDFZtNXIJVaFIYLn3b8DAr/iZNs5Q9Frb4VVg6uhsWOns0nGaSAgiR?=
 =?us-ascii?Q?qEwXMX79h4L+BJ7KppgpjcXgPN018dewQ8zpJnq6us91Lkm6GYAN0R18p3M9?=
 =?us-ascii?Q?uz4GVdmTKG79yRUTNY5w774GrUBGDM8cBSJSSK1pW/CRLMFR9rMn/+CJDWmS?=
 =?us-ascii?Q?6uXxDLkRANBA03h5R/LXIRutWPTslbIHwZXWMNyrjfTxE1/ULAzOUgVt/n2/?=
 =?us-ascii?Q?twLQCXy0/uzNH/hPFyy6iyMoqjNYleRwKbFz56q3Zi7XxYW1rWgbga/z1Fdq?=
 =?us-ascii?Q?VKVWlYApXr7UJjmQm7TmOUG/YjcCxsPOqfGZeiBwuG0y6zmLnyohjQ8mvDD1?=
 =?us-ascii?Q?PpChCO7sSMEqQc/fpzSqhO7ZYm49bUnNL1gNwgO86UaKiVNyw9eAgxn/WMMn?=
 =?us-ascii?Q?bRqYLoHnuwOhbtCj58QuBZJ37qu4t4wS6BGfwnYKOIzGDaLQ1ciGk3rIb29j?=
 =?us-ascii?Q?s5k1DXJ156rn0CO7O62Srxqqfk6DygmdfB8opDKuGLZZQO5Ex9r5p6bQeJYx?=
 =?us-ascii?Q?Fawh+lDoPhhfMRkLl6KjUDVfDdq+2ZIt2jBkgXzGABX17m7SKeS3Bsn/oF3Q?=
 =?us-ascii?Q?P24ofVwdnH8x1p1OyDd9YRowPyNw/Ed37w3cqAm9VsDWTClHL9RJSuOkiImK?=
 =?us-ascii?Q?3/Gli3+Cuj/RB2P4UvCvL00jobSJ8EMmau9VhC1qcDDw4jLEJCTkNAUiLWH5?=
 =?us-ascii?Q?YdFm5CXaCydW8om2Uk5d5HaQctm+IJOz/dQIuorF3l1NLN4Sslb8qA4YYL40?=
 =?us-ascii?Q?yCLvm35ZoBWlLEfLntAQFC9DlJEb2Rf4/FfJVJiSsq/oxdMWC+6PK8lEI95B?=
 =?us-ascii?Q?UQ487iDJwr4u7GIowvmhHQ8OOycvXufYuH3rGh2tDrMZfYSzfHkMfl69Wne2?=
 =?us-ascii?Q?vAxUpXVoB++FMsMiPBaoduWdmqjvuYZv+gNqQEwSWLYuKiqRxor36wyBdqtl?=
 =?us-ascii?Q?SRhq09k602X6zPtDA8dKA7oAPNStuVeNIEBQ7IwhWtADts576YxLkVozRwYs?=
 =?us-ascii?Q?mm9VW5sI2IotRhQtsmSMWOkHx2m9RGQ39TWJEJOjMyrzaJE7y4xqhIkHolwU?=
 =?us-ascii?Q?7JrzRdKh5nBVyOWTDDM2CHBOHFV+zD+k9WdyAHn4qf8fKYHx4ec4JLp2kD1t?=
 =?us-ascii?Q?ie8fM/xd67Vh2YLmG5CD+CQBwoSfJ5TLzFreA84OubSvwgBDcIFnzSVpSGlz?=
 =?us-ascii?Q?+hVL9pYWIRiLt0IYT/Sg8oreBvu8LEQJYAGO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 09:21:22.8469 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a86d55-3465-41c3-a0ce-08ddbd37a408
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8841
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

Remove the config ZYNQMP_FIRMWARE and also update the initial
stack address.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
Changes in v2:
- Remove the config FIRMWARE as well.
---
 configs/amd_versal2_mini_ospi_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/amd_versal2_mini_ospi_defconfig b/configs/amd_versal2_mini_ospi_defconfig
index 54328e85784..e0430434ba3 100644
--- a/configs/amd_versal2_mini_ospi_defconfig
+++ b/configs/amd_versal2_mini_ospi_defconfig
@@ -9,7 +9,7 @@ CONFIG_SYS_MALLOC_LEN=0x20000
 CONFIG_SYS_MALLOC_F_LEN=0x4000
 CONFIG_NR_DRAM_BANKS=3
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xBBF20000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xBBFF8000
 CONFIG_ENV_SIZE=0x80
 CONFIG_DEFAULT_DEVICE_TREE="amd-versal2-mini"
 CONFIG_SYS_LOAD_ADDR=0xBBF80000
@@ -57,6 +57,7 @@ CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
+# CONFIG_ZYNQMP_FIRMWARE is not set
 # CONFIG_GPIO is not set
 # CONFIG_I2C is not set
 # CONFIG_INPUT is not set
-- 
2.34.1

