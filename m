Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8674FED2F0
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 08:38:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35A6583F2A;
	Thu, 12 Mar 2026 09:38:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KfNWc2tj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3030F840A2; Thu, 12 Mar 2026 09:38:21 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C76783DA6
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 09:38:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qftUqEzC9QCr0WOuXeYFAxKjpqdR+o8YV1r1mZPygf/UytCnTskH8ioYuy6dtrH77pn0idgyXcMKk1jcJ4TvimrVc7YWt+4ayFlrUj1gr4bIO/g+q1/pTEixksWJPboFq6EbsIG7SYZvMmAACO/JPkEll9nmlm+MF8+QEIS7MB+oHfRYsdWrBd4yAvFCE+xWY+L39HmuzujpTM9RCYqcHzoJwqVR1djDpCZJ2j94Szmz3nrV8VJBCm84y5iAr7Yh9aWYgu/Ke+lZ2QeCIj7vaAGnFP03KFmM8QeAFfOGPZaJ4rAIZRh7EglEl3kCe8tBtCmLfZ90WpNdhZx1SSd/sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kNKCXLHzL5Ca8J6hU1yQ5lURt08czt1CCO6bJ/bJIc=;
 b=UHXxuYmO9qIhk3D+yo8290mxhn0t6ao6+/8lnD6WVdUOcnZSmn0tjP+knEIw28H/vsOi8owrgQu6+xuWsymnWTGM07yAz6xbMAIKjKZc28bHdyZ2Nz0dv4li2l/QgvXFa6hmn5KtoWD+TDPGH6BLlzgeHnuUkuQ1ryL02RCo18CFp8qdssK7Wtk6dw1cPIEtN4phWBJ2lqDBd9BXD53U0XGC9xVjypzwPFkqJJoWtmUOqdMuSqGzyJhVhUg8zVi6clezehE4fkZi4VKLKKVXoMA+9jsDkex2ROzMcX3R8UUJb5qiBlvTDt9HIqO+1JIyx4HBMdCX++Ev0lgYmUX7TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kNKCXLHzL5Ca8J6hU1yQ5lURt08czt1CCO6bJ/bJIc=;
 b=KfNWc2tjslZJddRgsEHjZfqSzYIJtvGCLcSccYP82Z9trY2kLkTZYyoazy+QHJ8MJf3EP0v6B0BEB51b/zv+c4We3oQoYRkGt7UHuwyDYlRygZYLuuOroji1ysJTcoivrpG6HQ5XK4VRdGIndsdZnra9LmgNzWAmm02NfTDYbdg=
Received: from PH5P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::7)
 by DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 08:38:12 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:510:34a:cafe::22) by PH5P220CA0006.outlook.office365.com
 (2603:10b6:510:34a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Thu,
 12 Mar 2026 08:38:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 08:38:11 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 03:38:08 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 03:38:07 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 12 Mar 2026 03:38:07 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Shantur Rathore <i@shantur.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonathan Humphreys
 <j-humphreys@ti.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, "Simon
 Glass" <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini
 <trini@konsulko.com>, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Subject: [PATCH v10] efi_vars: Implement SPI Flash store
Date: Thu, 12 Mar 2026 09:37:53 +0100
Message-ID: <1e8eb1c27210e3beb5d3f4402a40d2e8886bcf9f.1773304671.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6970; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=dLkXGRw3JYKiVWmXBSNzy/RVcqAHQi8++WkZlePD2TU=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRuqk6x/Xj3UG/kRjNjvxXivktTkj4tnxxT89i1nbNNQ
 sh7utesjlIWBjEOBlkxRZbpTDoOa75dWyq2PDIfZg4rE8gQBi5OAZhIpgfD//ATf+Tctm+vblke
 rH2r7dy35BnV/+b5fNLsL8myW7dw9SRGhlUVR7znBK1ZHj+z+X7NvWnR1/X4FgUqxVi+WMrSF3o
 4mR0A
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|DS0PR12MB6608:EE_
X-MS-Office365-Filtering-Correlation-Id: fb00e3cc-ca60-4bd5-eadc-08de8012b214
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|7416014|376014|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: X4QENErmyi9paKwGG6t5THC3l7/7LcW0i85gk164ahiA7HeQHsNLJKiwgvDgL60LlIAfvBQNLXZLjv5o8qsY/OsJGmAENNT/mnLf99m9Gf5rnXrTegPjxLKTZkxt4IOHVUY0Psc4UizuAGTHUSK1mdwWPvPopXQBt3CGs2i/LavtG0X/0GOsh7F9gjJl5UodD1C3fWdjh6fI35YKAKl9jLzQqFgQlRhQwlV1QEEM6+9RcmzrzU23BuIFHB5p3l9zxDZFzo5lL4hZ0L334mB46442mVXaO0C7dNbUyS+pipuQA7Ve25khXtRKIcIQmf4ukOUddxJUyRN+DSBLpDcpmmUrrtsBY2KTqJirxzy6/B4aonBgMKuSZmnPT6igrXXFYN4haLfOTcTTWaQob4ST2xDR5gW6iTD4Yejx3l3ecRCrjUVZNkQD1erpDba1ihAnyiU40GVSiDawtDQo0AtT8MmGX/S7QM7IoW8xD1HhrtRs8ti1VRcXyAFH/4/7mV2ELMv70DUv4w2MEA0DGn28R200QwY8ZlAJL24LWDFJwAhsSsyU1ZIFpkmYQVgbHbZW4QHRFROBuZeQm6kO6umHyTB/le3AL6TsIkHCPLSbGQw9LBLYk1YuEGFlbL4OKDITf0vEXRFT+u7ubBIEph2n3pLBIvwOoMNp2j1pLaSwNEkjFL7eYlJ6s/gK+ht1OixIMv2TESwY9a1pgqzfo5VDQ1uu5URxrNfanVijnOyFvW0zQfsysbaSO2cC7tjW5jeZ5gcAI8mLGO5mhoKDhJMeHynM5tcFCbJQPkrBwx35GD8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(82310400026)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vsy55krA7dPOCsT/TLW5fBsgXMr1Ok4dFRoZO+d/D91YCQ/XqWqviFFJM9BjTB+RAjGtl78kKWcu9gNgPeFuvg0XWP9ULNDG2pwXTdS5gVTPS9zDe1feZtlT9qI9PAjMNakf2w8R25B9LzwykGtztzL5TwyHU/vKy54ywiCpo83E7f8so8pHHYogjNyMIazNPNoP1rFYgP5yK1kc6ZmvVJCUVNSTeEWEFPUqujSM2qahxKXPc5pvfHMDin3oyM4nxIPgZFAlx4CRz/fPG2OP9kWOgmkCVlkeNiuML+N9RvlJ3D6jyueqOY61GmS2jM/HFPEtcdFzGo+IKYJsFyaD6Ce21ngFH3ko33oKTJ8Qx9bNs7uzExcvBaowDynJzbM1NmRn+yx8vlzlWv4fb8Q48XYMChpxa6jhnWNcc5HDMTOSoFEN2fhB7Cc+dgIj+Um6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 08:38:11.8330 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb00e3cc-ca60-4bd5-eadc-08de8012b214
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6608
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

Currently U-Boot uses ESP as storage for EFI variables.
Devices with SPI Flash are used for storing environment with this
commit we allow EFI variables to be stored on SPI Flash.

Signed-off-by: Shantur Rathore <i@shantur.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on AML-S905D3-CC
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

Changes in v10:
- Clean log messages
- separate return variables
- Fix return value
- Move length check to efi_var_restore()

Changes in v9:
- Remove EFI_RT_VOLATILE_STORE enabling
- Cleanup commit message

Changes in v8:
- Add missing EFI_VARIABLE_SF_STORE dependency to EFI_VARIABLE_SF_DEVICE_INDEX

Changes in v7:
- sed -i 's/efi_var_from/efi_var_from_storage/g'

Changes in v6:
- sed -i 's/efi_var_read/efi_var_from/g'
- sed -i 's/efi_var_write/efi_var_to_storage/g'

Changes in v4:
- Extend Kconfig description
- Extend commit message and describe efivar missing part
- use unify methods for reading/writing variable

Changes in v3:
- Fixed compiler warnings.

Changes in v2:
- Refactored efi_var_file to move common parts out as requested
- Changed ifdefs to use CONFIG_IS_DEFINED
- Fixed typos

The patch depends on https://lore.kernel.org/u-boot/20260311173033.10002-1-heinrich.schuchardt@canonical.com

---
 lib/efi_loader/Kconfig      |  33 ++++++++++++
 lib/efi_loader/Makefile     |   1 +
 lib/efi_loader/efi_var_sf.c | 105 ++++++++++++++++++++++++++++++++++++
 3 files changed, 139 insertions(+)
 create mode 100644 lib/efi_loader/efi_var_sf.c

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 579eed658801..315dd4f3e794 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -124,6 +124,24 @@ config EFI_VARIABLE_FILE_STORE
 	  Select this option if you want non-volatile UEFI variables to be
 	  stored as file /ubootefi.var on the EFI system partition.
 
+config EFI_VARIABLE_SF_STORE
+	bool "Store non-volatile UEFI variables in SPI Flash"
+	depends on SPI_FLASH
+	help
+	  Select this option if you want non-volatile UEFI variables to be
+	  stored in SPI Flash.
+
+	  Define CONFIG_EFI_VARIABLE_SF_OFFSET as offset in SPI Flash to use as
+	  the storage for variables. CONFIG_EFI_VAR_BUF_SIZE defines the space
+	  needed.
+
+	  Note that SPI Flash devices have a limited number of program/erase
+	  cycles. Frequent updates to UEFI variables may cause excessive wear
+	  and can permanently damage the flash device, particularly on SPI NAND
+	  or low-end SPI NOR parts without wear leveling. This option should be
+	  used with care on such systems, and is not recommended for platforms
+	  where UEFI variables are updated frequently.
+
 config EFI_MM_COMM_TEE
 	bool "UEFI variables storage service via the trusted world"
 	depends on OPTEE
@@ -194,6 +212,21 @@ config FFA_SHARED_MM_BUF_ADDR
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
+	depends on EFI_VARIABLE_SF_STORE
+	default 0
+	help
+	  The index of SPI Flash device used for storing EFI variables. This would be
+	  needed if there are more than 1 SPI Flash devices available to use.
+
 config EFI_VARIABLES_PRESEED
 	bool "Initial values for UEFI variables"
 	depends on !COMPILE_TEST
diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index ca1775eb03be..d73ad43951b1 100644
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
index 000000000000..c0755c67cda9
--- /dev/null
+++ b/lib/efi_loader/efi_var_sf.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * SPI Flash interface for UEFI variables
+ *
+ * Copyright (c) 2023, Shantur Rathore
+ * Copyright (C) 2026, Advanced Micro Devices, Inc.
+ */
+
+#define LOG_CATEGORY LOGC_EFI
+
+#include <efi_loader.h>
+#include <efi_variable.h>
+#include <spi_flash.h>
+#include <dm.h>
+
+efi_status_t efi_var_to_storage(void)
+{
+	struct efi_var_file *buf;
+	struct udevice *sfdev;
+	efi_status_t ret;
+	loff_t len;
+	int r;
+
+	ret = efi_var_collect(&buf, &len, EFI_VARIABLE_NON_VOLATILE);
+	if (ret != EFI_SUCCESS)
+		goto error;
+
+	if (len > EFI_VAR_BUF_SIZE) {
+		log_err("EFI var buffer length more than target SPI Flash size\n");
+		ret = EFI_OUT_OF_RESOURCES;
+		goto error;
+	}
+
+	log_debug("Got buffer to write buf->len: %d\n", buf->length);
+
+	r = uclass_get_device(UCLASS_SPI_FLASH,
+			      CONFIG_EFI_VARIABLE_SF_DEVICE_INDEX, &sfdev);
+	if (r) {
+		ret = EFI_DEVICE_ERROR;
+		goto error;
+	}
+
+	r = spi_flash_erase_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET,
+			       EFI_VAR_BUF_SIZE);
+	if (r) {
+		log_debug("Failed to erase SPI Flash at offset %x\n",
+			  CONFIG_EFI_VARIABLE_SF_OFFSET);
+		ret = EFI_DEVICE_ERROR;
+		goto error;
+	}
+
+	r = spi_flash_write_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET, len, buf);
+	if (r) {
+		log_debug("Failed to write to SPI Flash: %d\n", r);
+		ret = EFI_DEVICE_ERROR;
+		goto error;
+	}
+
+error:
+	if (ret != EFI_SUCCESS)
+		log_err("Failed to persist EFI variables in SF\n");
+	free(buf);
+	return ret;
+}
+
+efi_status_t efi_var_from_storage(void)
+{
+	struct efi_var_file *buf;
+	struct udevice *sfdev;
+	efi_status_t ret;
+	int r;
+
+	buf = calloc(1, EFI_VAR_BUF_SIZE);
+	if (!buf) {
+		log_debug("Unable to allocate buffer\n");
+		return EFI_OUT_OF_RESOURCES;
+	}
+
+	r = uclass_get_device(UCLASS_SPI_FLASH,
+			      CONFIG_EFI_VARIABLE_SF_DEVICE_INDEX, &sfdev);
+	if (r) {
+		log_debug("Failed to get SPI Flash device: %d\n", r);
+		ret = EFI_DEVICE_ERROR;
+		goto error;
+	}
+
+	r = spi_flash_read_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET,
+			      EFI_VAR_BUF_SIZE, buf);
+	if (r) {
+		log_debug("Failed to read from SPI Flash: %d\n", r);
+		ret = EFI_DEVICE_ERROR;
+		goto error;
+	}
+
+	if (efi_var_restore(buf, false) != EFI_SUCCESS) {
+		log_debug("No valid EFI variables in SPI Flash\n");
+		ret = EFI_DEVICE_ERROR;
+		goto error;
+	}
+
+	ret = EFI_SUCCESS;
+error:
+	free(buf);
+	return ret;
+}
-- 
2.43.0

base-commit: fec4dde8814fb3b0222046aebdbbc4548efe8941
branch: debian-sent3
