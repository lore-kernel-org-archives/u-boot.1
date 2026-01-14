Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1DAD37E40
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 15:16:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18A578388D;
	Wed, 14 Jan 2026 16:16:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KJB0O24R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C272C8063E; Wed, 14 Jan 2026 16:16:19 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EB888389A
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 16:16:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cHrg4ZFhwMGm0ZNNmfnAnOqsIgaYBs55iBpznIGNVnv0KL89bhLzz93Ail2ByKQ+8o1uKgb6pX+afIf9HMagee1V24GsM4w9m76n7cGtw6LHQAFGsQx3xNg2eFZFb/lZbLbsguLYFU3OW3tEqH9DNMmNCs5RecsfZ8jzJyHKgYOShKGTuEpW5msISISFbOO6oLD9q34ubbpzvTWoSCYT8QaAmJf3nZlZTNobI5ZaCS1M0tKOLLM61pt7Tx1YQKe/OOVBjW8ZzXgGvTPwoAYH4NRDcOOMWu2wFJjKv7MiRTstO4cjGn6ERDCXqEzCEAl04GOxE4pahjE9doWemaR7CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEBZdmGyGFC4PunRsrGadCX6HtISbRSlNHfzDvRaKA8=;
 b=YGuf3Pn0IbV8TXNU5tth133W2G739o4R6AoyO7xhF4j0I/VrYnqX7nH/QVds15PnlC1U3yEy/6N4XMPIjO8sPNT7s7T2TzlgDEsb4YVAWk395VH9PrdExYOizdSHvkDtQkpFPpgV0eoNDolHFvgGrSiW4enYp2N/J5Aq8XaY4vNelhsSa0hnbL4TwqLFZh7ptV7jkywyAOW7+jHwSXaMo+3IYOh5E4j684o1DqC94OEEvy/XpmB+9VOQxwDMp1H+rbxVdx8Z0KhKdIjqeJOACdOXAnNxEARgTj3sBaed1X1yaEOtEbmr6aL0lllpelmO0WG1S/9eYD1OMz+4WfQ6Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEBZdmGyGFC4PunRsrGadCX6HtISbRSlNHfzDvRaKA8=;
 b=KJB0O24RKp9KalLb8mVyxY2D1zFSv9cOxZ8FfUG1D2Ae5bFixTr6Xke4/LixNNcaCaTmkeUWWQJCa+sHrVnOgGLWyBMIu+1+N3x7+qZqoOWmcwGC4apAp4jKVFzR6AdcIEi8z+FBr//OdT2ZCmB7+KdIV5IBkeqPM2W6M+/ltFA=
Received: from CH0PR04CA0120.namprd04.prod.outlook.com (2603:10b6:610:75::35)
 by SJ2PR12MB8650.namprd12.prod.outlook.com (2603:10b6:a03:544::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 15:16:02 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::16) by CH0PR04CA0120.outlook.office365.com
 (2603:10b6:610:75::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 15:15:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 15:16:02 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 14 Jan
 2026 09:15:54 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Jan
 2026 09:15:52 -0600
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 09:15:52 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Shantur Rathore <i@shantur.com>, Gabriel Dalimonte
 <gabriel.dalimonte@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jonathan Humphreys
 <j-humphreys@ti.com>, Raymond Mao <raymondmaoca@gmail.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, "Ying-Chun Liu (PaulLiu)"
 <paul.liu@linaro.org>
Subject: [PATCH v4 3/3] efi_vars: Implement SPI Flash store
Date: Wed, 14 Jan 2026 16:15:35 +0100
Message-ID: <da6f7b65cfb5aa81b7ff13848f532cde1b009227.1768403729.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1768403729.git.michal.simek@amd.com>
References: <cover.1768403729.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6911; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=gN9eJyuJlYzHzAyjSURVPXDJB31PrZihxCwZRCeTzDw=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSmbxYXDFi93rE/KVNzifJMFUuNU/JrPWuUL5z8XjVHx
 v9572q9jlIWBjEOBlkxRZbpTDoOa75dWyq2PDIfZg4rE8gQBi5OAZhImjEjw2fBG3OjOUo+XA3I
 jy/8nJeztnLXCbMKNTaGi/uEWG7pGzD8M5uYrBvV5F3T2Kyj7VD0oU7wiFL3Tlmryq96PGlP5Gr
 4AQ==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|SJ2PR12MB8650:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eb0dff1-06d6-4463-7bf4-08de537fd45f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|7416014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LEcqKYQ+QeZoDjlx6QFaLaxENXMScJkAAVdu9KxL4d6tVFvJ4sLF5ZAWKXBR?=
 =?us-ascii?Q?r3wyenyGJHC2ZlUlTUf2+9dHmih9Bz7JfW2o6VWm4966nyeSByEP56xPdQ75?=
 =?us-ascii?Q?qyOzYbCVXY/vhR7MlpyshOz4fh5J9OLglrFEz/n/HQC3VNaBALG+EgYJqD+u?=
 =?us-ascii?Q?6NSvpQZA2AHRAMd1xtEeZqdpHnQsYe5oHa51BwgDwmjwE0bnh9ote2TsO2aE?=
 =?us-ascii?Q?nZ3uU8eNTFXdiL2u0qMK6+J9ubkks+4I+foFQIEZbE7FZhSEZssIIyo2NOl4?=
 =?us-ascii?Q?ZnUCpDqqACuB0Hev6Hm2KNO8iQCdIqSm8DeC2LEZiZU2fLYFMW6QELG13hWJ?=
 =?us-ascii?Q?JXaBqEz8iZYMVfqhQyF/+fiw8W9hkupTOXdsDLFgEWQKv8zhfPup4RLSOecO?=
 =?us-ascii?Q?1iFy2DrSxWTQJveKHcyH9G99Qt39+bElZRAkLOwJIby1jdZg0zm+t8v6g5sC?=
 =?us-ascii?Q?AgiPKxPBVZ0wPnBhOh/iZ7QXmjImGCvnbYs+HuXYbjM0Tnx3nOMJs3HUcC05?=
 =?us-ascii?Q?AI8F7asg+HErzEVEOVwAb/T8LpzWCSbVD+r2HBzBfrgqtrNQRFA875WbYwmN?=
 =?us-ascii?Q?TtySi4XBol9N3uZ6yRJhxO9JkCeZF7JGdnsBfHJ/tjUShGEk0EEVLfRmSVTN?=
 =?us-ascii?Q?bC6gfFNH+V9f54IUqHhiGcdMuXV4/yV6zQXGIHfYqUWof+OhxgWwCFznJGKO?=
 =?us-ascii?Q?kJ43mJZDXCEAapu4Z6WpqVJzm69OyYsibps3mmKak860CFbOhNXq0ej/QYdS?=
 =?us-ascii?Q?KqMHiRu9vAlYM1jEll1QK+VUOUQRVWgIPIZL5EjNkATHaSThPlb/On8VGtWA?=
 =?us-ascii?Q?YEsfgqo3tvK19/p4bg+P7Zcypz7ZLi4aDrEZDz7LQJysOsE0vnKaZl6eIprw?=
 =?us-ascii?Q?YNTwsHww8UQkIVfTYWik9TzaLkqN0wx8/cun1xsRUTaC8etg44nduya/EHa2?=
 =?us-ascii?Q?oqq0ik+WwpLurMq2GjoNj8rbubqGs4WIfgoaAcJiawYLu4y3t7G4qFqSuWUU?=
 =?us-ascii?Q?INLAY5GOv2kn57LBd0W++NNjwqpDNqcTnCWrTnogDiNyCRifpSmq4BLnA/uE?=
 =?us-ascii?Q?iDivUoFEHawWbeiWe68sx+CzCkiXGZAMoyK5crODJxv2wV/Z8cAhxLtVfIEn?=
 =?us-ascii?Q?ybg5W/C+qdXgkyFQjLXdAUZB1pbcjHHHzFBFTP+hOd/V5HisbIvH72norbaO?=
 =?us-ascii?Q?n4XZePU4l94Bys3atSDbnhYFBqugIr48Pgmb71sX1CV26tnyWk9GRGB7XE2M?=
 =?us-ascii?Q?x4+8t04dTwBEBxt3jRVNUfsPbnLwlU9S02dsg61liSYYhhPpjIojxn++OIq1?=
 =?us-ascii?Q?RjWksX02rIbZWGclw786Q2js5UY/AGiCyZt69p6NNQnpzzUDNr25XP+on2u7?=
 =?us-ascii?Q?Lfkn0S0Myx8GgYyZwYcHT0gOoZ9gMLuSdlzgRVW3UVrgsCmSQnI0834aF98R?=
 =?us-ascii?Q?u8b9aDf/tHL/XHtV+eaMovfDB3e54vF4ww6+ObaY3PiCuIk/0XX8QDk6mzO7?=
 =?us-ascii?Q?XwyEdHbKmzokmFUQ0RS5L+xrb6kY7x61BaIK8OhZrhdffF3b/nSytVIineQc?=
 =?us-ascii?Q?oy6PwMaJab4aEBkge20HGMSrQEy+zHKUPn3wO+dxb/ed7asRzu1Rq56NrtN5?=
 =?us-ascii?Q?NXF9X+DJPMd4hVLX2DEsWtllAsNSM09pBfT2o8vGmfiqwztO/V+lixdiKx2w?=
 =?us-ascii?Q?aM8XRg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 15:16:02.1893 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb0dff1-06d6-4463-7bf4-08de537fd45f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8650
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

From: Shantur Rathore <i@shantur.com>

Currently U-boot uses ESP as storage for EFI variables.
Devices with SPI Flash are used for storing environment with this
commit we allow EFI variables to be stored on SPI Flash.

Signed-off-by: Shantur Rathore <i@shantur.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v4:
- use unify methods for reading/writing variable

Changes in v3:
- Fixed compiler warnings.

Changes in v2:
- Refactored efi_var_file to move common parts out as requested
- Changed ifdefs to use CONFIG_IS_DEFINED
- Fixed typos

 lib/efi_loader/Kconfig        | 26 +++++++++-
 lib/efi_loader/Makefile       |  1 +
 lib/efi_loader/efi_var_sf.c   | 91 +++++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_variable.c |  6 +--
 4 files changed, 120 insertions(+), 4 deletions(-)
 create mode 100644 lib/efi_loader/efi_var_sf.c

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 13e44be1d067..e753a3aef36d 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -123,6 +123,16 @@ config EFI_VARIABLE_FILE_STORE
 	  Select this option if you want non-volatile UEFI variables to be
 	  stored as file /ubootefi.var on the EFI system partition.
 
+config EFI_VARIABLE_SF_STORE
+	bool "Store non-volatile UEFI variables in SPI Flash"
+	depends on SPI_FLASH
+	help
+	  Select this option if you want non-volatile UEFI variables to be
+	  stored in SPI Flash.
+	  Define CONFIG_EFI_VARIABLE_SF_OFFSET as offset in SPI Flash to use as
+	  the storage for variables. CONFIG_EFI_VAR_BUF_SIZE defines the space
+	  needed.
+
 config EFI_MM_COMM_TEE
 	bool "UEFI variables storage service via the trusted world"
 	depends on OPTEE
@@ -152,7 +162,7 @@ endchoice
 
 config EFI_RT_VOLATILE_STORE
 	bool "Allow variable runtime services in volatile storage (e.g RAM)"
-	depends on EFI_VARIABLE_FILE_STORE
+	depends on EFI_VARIABLE_FILE_STORE || EFI_VARIABLE_SF_STORE
 	help
 	  When EFI variables are stored on file we don't allow SetVariableRT,
 	  since the OS doesn't know how to write that file. At the same time
@@ -193,6 +203,20 @@ config FFA_SHARED_MM_BUF_ADDR
 	  the MM SP in secure world.
 	  It is assumed that the MM SP knows the address of the shared MM communication buffer.
 
+config EFI_VARIABLE_SF_OFFSET
+	hex "EFI variables in SPI flash offset"
+	depends on EFI_VARIABLE_SF_STORE
+	help
+	  Offset from the start of the SPI Flash where EFI variables will be stored.
+	  This should be aligned to the sector size of SPI Flash.
+
+config EFI_VARIABLE_SF_DEVICE_INDEX
+	int "Device Index for target SPI Flash"
+	default 0
+	help
+	  The index of SPI Flash device used for storing EFI variables. This would be
+	  needed if there are more than 1 SPI Flash devices available to use.
+
 config EFI_VARIABLES_PRESEED
 	bool "Initial values for UEFI variables"
 	depends on !COMPILE_TEST
diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index 07ae048f2e0c..0eb9826c7ed8 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -54,6 +54,7 @@ obj-y += efi_variable_tee.o
 else
 obj-y += efi_variable.o
 obj-$(CONFIG_EFI_VARIABLE_FILE_STORE) += efi_var_file.o
+obj-$(CONFIG_EFI_VARIABLE_SF_STORE) += efi_var_sf.o
 obj-$(CONFIG_EFI_VARIABLES_PRESEED) += efi_var_seed.o
 endif
 obj-y += efi_watchdog.o
diff --git a/lib/efi_loader/efi_var_sf.c b/lib/efi_loader/efi_var_sf.c
new file mode 100644
index 000000000000..fd6b1ce22322
--- /dev/null
+++ b/lib/efi_loader/efi_var_sf.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * SPI Flash interface for UEFI variables
+ *
+ * Copyright (c) 2023, Shantur Rathore
+ */
+
+#define LOG_CATEGORY LOGC_EFI
+
+#include <efi_loader.h>
+#include <efi_variable.h>
+#include <spi_flash.h>
+#include <dm.h>
+
+efi_status_t efi_var_write(void)
+{
+	efi_status_t ret;
+	struct efi_var_file *buf;
+	loff_t len;
+	struct udevice *sfdev;
+
+	ret = efi_var_collect(&buf, &len, EFI_VARIABLE_NON_VOLATILE);
+	if (len > EFI_VAR_BUF_SIZE) {
+		log_err("EFI var buffer length more than target SPI Flash size");
+		ret = EFI_OUT_OF_RESOURCES;
+		goto error;
+	}
+
+	log_debug("%s - Got buffer to write buf->len : %d\n", __func__, buf->length);
+
+	if (ret != EFI_SUCCESS)
+		goto error;
+
+	ret = uclass_get_device(UCLASS_SPI_FLASH, CONFIG_EFI_VARIABLE_SF_DEVICE_INDEX, &sfdev);
+	if (ret)
+		goto error;
+
+	ret = spi_flash_erase_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET, EFI_VAR_BUF_SIZE);
+	log_debug("%s - Erased SPI Flash offset %x\n", __func__, CONFIG_EFI_VARIABLE_SF_OFFSET);
+	if (ret)
+		goto error;
+
+	ret = spi_flash_write_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET, len, buf);
+	log_debug("%s - Wrote buffer to SPI Flash : %ld\n", __func__, ret);
+
+	if (ret)
+		goto error;
+
+	ret = EFI_SUCCESS;
+error:
+	if (ret)
+		log_err("Failed to persist EFI variables in SF\n");
+	free(buf);
+	return ret;
+}
+
+efi_status_t efi_var_read(void)
+{
+	struct efi_var_file *buf;
+	efi_status_t ret;
+	struct udevice *sfdev;
+
+	buf = calloc(1, EFI_VAR_BUF_SIZE);
+	if (!buf) {
+		log_err("%s - Unable to allocate buffer\n", __func__);
+		return EFI_OUT_OF_RESOURCES;
+	}
+
+	ret = uclass_get_device(UCLASS_SPI_FLASH, 0, &sfdev);
+	if (ret)
+		goto error;
+
+	ret = spi_flash_read_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET,
+				EFI_VAR_BUF_SIZE, buf);
+
+	log_debug("%s - read buffer buf->length: %x\n", __func__, buf->length);
+
+	if (ret || buf->length < sizeof(struct efi_var_file)) {
+		log_err("%s - buffer read from SPI Flash isn't valid\n", __func__);
+		goto error;
+	}
+
+	ret = efi_var_restore(buf, false);
+	if (ret != EFI_SUCCESS)
+		log_err("%s - Unable to restore EFI variables from buffer\n", __func__);
+
+	ret = EFI_SUCCESS;
+error:
+	free(buf);
+	return ret;
+}
diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
index be670a8e7c25..feab212b245b 100644
--- a/lib/efi_loader/efi_variable.c
+++ b/lib/efi_loader/efi_variable.c
@@ -397,11 +397,11 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
 		ret = EFI_SUCCESS;
 
 	/*
-	 * Write non-volatile EFI variables to file
+	 * Write non-volatile EFI variables to file or SPI Flash
 	 * TODO: check if a value change has occured to avoid superfluous writes
 	 */
 	if (attributes & EFI_VARIABLE_NON_VOLATILE) {
-#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE)
+#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE) || CONFIG_IS_ENABLED(EFI_VARIABLE_SF_STORE)
 		efi_var_write();
 #else
 		return EFI_NOT_READY;
@@ -599,7 +599,7 @@ efi_status_t efi_init_variables(void)
 	if (ret != EFI_SUCCESS)
 		return ret;
 
-#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE)
+#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE) || CONFIG_IS_ENABLED(EFI_VARIABLE_SF_STORE)
 	ret = efi_var_read();
 	if (ret != EFI_SUCCESS)
 		return ret;
-- 
2.43.0

