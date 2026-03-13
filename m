Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5805103E305
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 15:45:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32B50842F4;
	Fri, 13 Mar 2026 16:45:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cDwkIibc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C49E843B6; Fri, 13 Mar 2026 16:45:50 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34ACA8423D
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 16:45:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMrHRyjmji01rfu0fsY5dFVU8Sd4riLrXTiyPSk8seXMU8YWKyT3JFEVx6PrnqXaLeeKJMOunkBrjsxEoTyNM5ghql+0YcUbyxHdvTxUsBSBHtaeB2IaqP6tDaOf+iZK674csarNDVYIhZMKPjFk3YMKqnwbbXuvpKAfaj+PX2e9vgHM0fsLrldzA9+G9FJVv/81kFkrKiTv0w96dUGnIdSNKoEvqAnVKWKpQK+rooqHQeSVh86DO1YMZ7oAYNUMaAmAsiS/76vt15pWYEgKfI5NrdDnn90raOcg60nsvO//jHzklsXDVTlzwqQWfX+qqXz9xSDwJH7FTYDAAUNzCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nE2MhdQyxeZLK2gMtDtM2HBmEqD+OXsGvr1Sx6njrSo=;
 b=C/oOmj7V9qLoYpEAz1NUXfvubDn5HJFApwOSjjc53LCyGy45o7O59Y8Re/9qUKu6rMGg1r1fzta5FO9xSge3HralhaxIeKZZcVB2I9Oy8RzjqcaNeMRWK0ZI9XR6D1dllNtN0FiGu3Zx1Dxrf7EytgRY2NLs0AMcIDJ11H/tEiehHRFjMCO9XDdXMEgXMp59knNL1k2WYAYRRu8IPsQcCyCf2rtBNENTZPW/x+BSSkBNmMuT/PYCeYDAwdQBmB4832SIP/XY7WB1jeZqRD54nwTj2R/OnYgkQt3EeWEU5XqHA5FcUshxaez5v3WCg9lwjmZKFoEcccwmGY3vR43w1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nE2MhdQyxeZLK2gMtDtM2HBmEqD+OXsGvr1Sx6njrSo=;
 b=cDwkIibcpFTTPRu2WKzrzYOJogxwj57eozvYB3KSNvVmmdrfpuvCHiM3MFtSMtAjyiuJvVdgtC5QH/TN6HGY0wDkb1/bFy829PMdDvH6Icro2C8tOfkB9Pwj0i/WXrhAmMVjX3LX671k6pSjkB7JawGltq/eu44rXEAY1bhorZk=
Received: from CH2PR14CA0028.namprd14.prod.outlook.com (2603:10b6:610:60::38)
 by PH0PR12MB8775.namprd12.prod.outlook.com (2603:10b6:510:28e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Fri, 13 Mar
 2026 15:45:38 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::54) by CH2PR14CA0028.outlook.office365.com
 (2603:10b6:610:60::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.16 via Frontend
 Transport; Fri, 13 Mar 2026 15:45:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 15:45:37 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 13 Mar
 2026 10:45:37 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 13 Mar
 2026 08:45:36 -0700
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 13 Mar 2026 10:45:35 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Shantur Rathore <i@shantur.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonathan Humphreys
 <j-humphreys@ti.com>, Simon Glass <sjg@chromium.org>, Sughosh Ganu
 <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>, Wadim Egorov
 <w.egorov@phytec.de>, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Subject: [PATCH v11] efi_vars: Implement SPI Flash store
Date: Fri, 13 Mar 2026 16:45:27 +0100
Message-ID: <8ee5fc7a49816d9e26f38999990aa1e4e354801f.1773416725.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7456; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=zCPH+Ry28+K1DlU4f0f/9c7tN5vrpIsUNmxeMpteEm4=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRuMZTgUc+9WuCnfNdXxDHhiueKOX2PmZec8w27dPjAY
 9P8dVUaHaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjARIQGGP9wlURyxzqyyE0JX
 vPx5YK3Gjoms7vrN9exe+0W2FsQ9n8LI8OPs5DD9sPRmo552sSPX2ieuvxs4Z8XPrDiBqbrdYd/
 i+QE=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|PH0PR12MB8775:EE_
X-MS-Office365-Filtering-Correlation-Id: 1647fc4d-a922-41c7-553d-08de81179277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|36860700016|1800799024|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1J4veHXtqnkG9FAD/lI6lqu0mY6KMLJRTqkMbZ2lCxcddqZ9PgagZhbY5+DLL9/QfOcp14UhuISk9TIhILaw57y+AkmFG+tRnXhaOgOAxYd/41/DxQgvXAiSmno0JtlRO2F/PsLK/6ttlk5w3VYo5jQ3hunQef+I6o2ehuNqqkhUiO9lzrsydAj20outHBMwSDC4TZapFa6VSnoHXbaLNOqFzsBK8PJageXypouEk5XxL+6DgjmRlwCsn+Jo81nGJnxWtPnx/7b658kxJy2NuUwUKaK5iZDsouVmId3NbupWsLG1msV7JFoErWe2n+vABZ/VBUhTFbc0E29XLboG5UqVZtXZaeKajLCcwPcU2hh4N2aCMNrl2mYlp3B226jUVc2J8+LOarUcMc4eldQnSdQ4m99k4mBFZFcF8o0JEKyJ1qhRIka7kSzrGyfN553oMN0NyLjKU54OE+tqC56clT4rRixtKV3aVTuG3hMTO3xqKg2h5MV4L7KttSsqWE7tydO1ec9thIIIlxDxm34i0jMGBTFUNsSgiGrAnlg1krme5DxupG80vFvFkufrWosghU4uCMfajtTFmK0MqiXLMN3HLOicgGxVvAHa2UsNWazcbbsSG4/K1CVMGnsGa3brUBSeB3GHjLxeR44tfzZUaiL9jpWZxKGAFU55VnpcdbtLP1lH6kmVqfRMy+/0uYsVb9T2K1niB+Y8EKi+pOFit8OQSt/OmQqJxfsMcd30Um1Ff/nMtsRJoL+QdaELmVCuJNsVmgwLDydhHAtE0GJh10wBxjKAePrzKwIIdfh8Wk0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(36860700016)(1800799024)(82310400026)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TIlgceY/yw2zOAkEYMcBmcAPkggHkTXBMX/8ARBtgyd/D4rH6UJaE9i6MsgZNRhbA+3iOvonHoONiA+nkifQ6hvEbaatN1cpwZ9PXQVYwnmS0LFsc35+Wd99Hl0klEv2DkFKfZ2hdDtOBZY9A+T4EULeoib9IKSAatQpfjt0wEryUjDKsPBmSHcl79gY3DKxbiuoq3SLx6OnGFNcIk+rPEEqTGjoXo4HqryPYaGeIcSKawvLlyweTPMgBcBbAjRm3mFWTL8e7dIBBQBbGLWL0BtRey9KUpnSwvQGB+PTkI+bfYFqZR4H08eTPCW+oIhWIjrbMmr+DsvUaQeHL9F0qPtAnM5NxKlbp0q1LV5b7pjKM9V1+qfSxF2QpYI4ITCcxwcVWbiNCHudL0PoPPcEb8Rg3mQbEJSWTiSNaKR1wiKe51mDInJTmDn7iwXuO3vx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 15:45:37.4177 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1647fc4d-a922-41c7-553d-08de81179277
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8775
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

Changes in v11:
 - Use log_debug() in efi_var_to_storage() to avoid console output from EFI apps
 - Use sector-aligned erase length to reduce SPI flash wear
 - Remove redundant log messages already reported by log_ret()
 - Add NULL check for dev_get_uclass_priv() result
 - Use log_err() in efi_var_from_storage() which runs during init
 - Remove unnecessary goto before error label

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
 lib/efi_loader/Kconfig      |  33 +++++++++++
 lib/efi_loader/Makefile     |   1 +
 lib/efi_loader/efi_var_sf.c | 111 ++++++++++++++++++++++++++++++++++++
 3 files changed, 145 insertions(+)
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
index 000000000000..6eae8d464645
--- /dev/null
+++ b/lib/efi_loader/efi_var_sf.c
@@ -0,0 +1,111 @@
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
+	struct spi_flash *flash;
+	struct udevice *sfdev;
+	efi_status_t ret;
+	size_t erase_len;
+	loff_t len;
+	int r;
+
+	ret = efi_var_collect(&buf, &len, EFI_VARIABLE_NON_VOLATILE);
+	if (ret != EFI_SUCCESS)
+		goto error;
+
+	if (len > EFI_VAR_BUF_SIZE) {
+		log_debug("EFI var buffer length more than target SPI Flash size\n");
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
+	flash = dev_get_uclass_priv(sfdev);
+	if (!flash) {
+		log_debug("Failed to get SPI Flash priv data\n");
+		ret = EFI_DEVICE_ERROR;
+		goto error;
+	}
+	erase_len = ALIGN(len, flash->sector_size);
+
+	r = spi_flash_erase_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET,
+			       erase_len);
+	if (r) {
+		log_debug("Failed to erase SPI Flash\n");
+		ret = EFI_DEVICE_ERROR;
+		goto error;
+	}
+
+	r = spi_flash_write_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET, len, buf);
+	if (r) {
+		log_debug("Failed to write to SPI Flash: %d\n", r);
+		ret = EFI_DEVICE_ERROR;
+	}
+
+error:
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
+		log_err("Unable to allocate buffer\n");
+		return EFI_OUT_OF_RESOURCES;
+	}
+
+	r = uclass_get_device(UCLASS_SPI_FLASH,
+			      CONFIG_EFI_VARIABLE_SF_DEVICE_INDEX, &sfdev);
+	if (r) {
+		log_err("Failed to get SPI Flash device: %d\n", r);
+		ret = EFI_DEVICE_ERROR;
+		goto error;
+	}
+
+	r = spi_flash_read_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET,
+			      EFI_VAR_BUF_SIZE, buf);
+	if (r) {
+		log_err("Failed to read from SPI Flash: %d\n", r);
+		ret = EFI_DEVICE_ERROR;
+		goto error;
+	}
+
+	if (efi_var_restore(buf, false) != EFI_SUCCESS) {
+		log_err("No valid EFI variables in SPI Flash\n");
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

base-commit: 6f83a27dbba6cc4e4c2683322c3ab5415173821e
branch: debian-sent3
