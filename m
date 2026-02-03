Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1618AE7FDCF
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 11:52:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B5C6840C3;
	Tue,  3 Feb 2026 12:52:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JSV1DgMt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EA93840C3; Tue,  3 Feb 2026 12:52:04 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15D7C8401A
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 12:52:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDzoXjT4hLuXytxdv0tV1su2gvVI2puIjPuQLVMSBF1DuCzHT5fLEJoc8XmK8u1rZmoHJBzhztdZk3+ACfEPnehteHhnWl6F/1qTX5D05VnRq0V36aITcBWyx0zcd5NLs/cRnjqUTnyAlN05X16BlhFaGC9M55E9YDrqrs1bLNVWTKjR1Mg5EIYjtnskv01p1ClANh2hauIpsI6j2EDiSEj+GFxgKg/T+1D4Dsqkhq9LPlViX3a+EV+lPNiKEkVk9oN1c+43G1j+JVBiG0XL1bwSPS47JxUWPC7m6bqcY6rZLfjAqPOE4JOL83ZmS48FLAgK6S7A+ClFqJqqMAy9Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=foyC83Fa5hqFeX5hPFMK+4JLJ6O1pX1PH0svq1+dmH8=;
 b=jMuiLY3cncnhEsonfeddQjlGhG7HP+adw9XTiuwXY5IiooaTJ4aRzoXEa6U+9eMuV+8HhFp0sO2oL2RSUObKtLfbGveYxb7mnKZMVnSRtJ8fJMIXuRbnpy8vYuZNV479PxzjmSLcT/47gwGmrL5WN+QsaPCR4wgtV6AByeO69jAnZUPeGnz5oaSYhcNdPxrRJxqgDBKhhVAalu1/fC5NlgcsdiwM9GjAz6pkyJE0ZJiUPGUd9H6JhkcvYiIctUORDg7PQ5FzzDUL0r+brdewDM12++JSuOS4Nh82n3PzjAOUJGp2AcJzVvzZwxIO2pDLC1cbPdaw1Py1VTmTIaYDNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=foyC83Fa5hqFeX5hPFMK+4JLJ6O1pX1PH0svq1+dmH8=;
 b=JSV1DgMtfnRP5S+XfYKPnh/IZywh8rWQ3D5BjKiIwXQZV3twfBVyAqmxs9dps0RM3LRUrP9QllKZQ9AlKt6A1MSdJZKPIYo3rD1JoOd9c3AxCu6sBdKHk3nFvjVdQ+YLU5R76NwCx2WP+W9+hZ+1pXsanjZ8PjMn8B13Af57BAk=
Received: from SJ0PR13CA0074.namprd13.prod.outlook.com (2603:10b6:a03:2c4::19)
 by MW3PR12MB4411.namprd12.prod.outlook.com (2603:10b6:303:5e::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 11:51:55 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::78) by SJ0PR13CA0074.outlook.office365.com
 (2603:10b6:a03:2c4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 11:51:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 11:51:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 3 Feb
 2026 05:51:53 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Feb
 2026 05:51:51 -0600
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Feb 2026 03:51:51 -0800
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Shantur Rathore <i@shantur.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jonathan Humphreys
 <j-humphreys@ti.com>, Simon Glass <sjg@chromium.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, "Ying-Chun Liu
 (PaulLiu)" <paul.liu@linaro.org>
Subject: [PATCH v7 3/3] efi_vars: Implement SPI Flash store
Date: Tue, 3 Feb 2026 12:51:28 +0100
Message-ID: <eb7bfafc0b4a44375833b935bafa4df2550e9c3e.1770119483.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770119483.git.michal.simek@amd.com>
References: <cover.1770119483.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6930; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=pfaYgNklYD08+2JNl0NZvPGcDKkdM3PXLhYUaEFDTDI=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQ2PnSz49j7bmPJ3Da1/lUG35Yctz4RG3r092KOwB3uk
 9hZTI4od5SyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBEZMoZ/ikvrO8o9WoyuMIy
 yfrqnrbJzZVM1/5cmb559ZJ7VWcFF7IzMuwQ3zyvxIuJgYvbbnfGzPd/P/O5F5l6rPktdS76cfA
 HZ0YA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|MW3PR12MB4411:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e0ce095-046d-4bc3-282b-08de631aa0e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ndSGpJKaB4TAAcs1CJ6uQLg0d7AJzi3GWxcSP8uHp7YeTHy1wPuqHfC8bb1H?=
 =?us-ascii?Q?LaSIIuxoV1p+DruglvIqWRHv5+4Qpxhm9yur0uKEHAcqzTDIwsSnAQUNqxYf?=
 =?us-ascii?Q?XmgQXW4j3es04W53x1q+Oqo2WUm5gN4UbWTzfxnbLATmioxupKeEQMefnYn9?=
 =?us-ascii?Q?E99695innXNNNRxDk0qBWKtduuV61U9UYKEbyMEsiYdL0sf1jVtMJeRI4iWP?=
 =?us-ascii?Q?b68udPepj1TU4EIKa3luAMaoS8T7wwhR54HRgF9TdC4eU/hoK1EJeXFSuPbf?=
 =?us-ascii?Q?43VqcOEHba6+COqlz7Ds7l8iTka6kbZFExYdFDUnu1fbEq9QYr7DZGYLnQem?=
 =?us-ascii?Q?NtPMJ+yebzUfNWlSkScPHtbIRLrIC2yap7OMbUM+56qLE3FcLHlfbX/o6fgl?=
 =?us-ascii?Q?ItUhl2lPCQceuSlK7sL+usc3/Dwq3QycksbKmcM8mlLRnOdIOBv4VySUysav?=
 =?us-ascii?Q?fKVp3EOCJY5g1ojtpuMx3vUKWa8XXTCUtL0tjAxeI/ZrBunW9MJIDgC6bQV5?=
 =?us-ascii?Q?3iJ6CbN72TjKBTZJ0dpNxtxj5m786kvYNY8vUrAccybinjwMotpO5jLzs8zv?=
 =?us-ascii?Q?lzpKsq/w8tDD4eC70WJq8e3JI3hO2uPk2z1TThYNW7Oh6L74voB635KfBXT8?=
 =?us-ascii?Q?I646Q1dtJQlr7n1KmqcbzMSr0dQlIjK+cgB9HnhQ6Smd9ReBcTDmW/Tkbp77?=
 =?us-ascii?Q?v/Ah2FLmTCGy0sHgjcH+rBRa3NjTifoRswLYLwksZJOjyHZk59kPwYbEnVnL?=
 =?us-ascii?Q?7rDsp6/QJSH4ohyHQYtKnaqxWYSORIXlFGKK8y1l0DOspHQUmEeJGUmkVBDA?=
 =?us-ascii?Q?PxOrGC1rwsQDhiIAK8/vNVMTXbdVwz/h8do8It93Ee0qfmULJq+/xDPrqeym?=
 =?us-ascii?Q?cNl00oj6Mf+dwGP1FQ6SajZKbwb1N0pF+DK3C23hBdZZfjQz1mfFhxbQN4UZ?=
 =?us-ascii?Q?MtRKLVu9EIIsfNTOBZuUHNZihwysIwUntyyLLMRJJoybJGcYb6kukdbKsq+T?=
 =?us-ascii?Q?euiTj89SWp275/xUuQCQCEUCK59tualzHT5gFaMjyfqOeL9hU3ecA8BNBQ7j?=
 =?us-ascii?Q?IZD2/llS/kQ+Sb2GR/470kefi8fFWNaY8Dw3njHnexJKMyZO57Ppz7v0dc6I?=
 =?us-ascii?Q?Xwljgu6m1VGx7UG4YQx2QSQBvXJpxVTaEYpcR1Q0QeSJc/I4OhuTMBLSkuJt?=
 =?us-ascii?Q?+ZguygW5aidI7kPGQNCck6ZPwOiYxcdoLDONCr59CnzdwKivuOqjSecA7w2F?=
 =?us-ascii?Q?Mk6UNUPF5BeryOSErDYtqmuLUBcCKYllkU4x8K5uBbO17cCC/3sWiZULEYJx?=
 =?us-ascii?Q?ek58BDn9qkez4cFOqFF9ZGVDJ/xx9J2W2fsuhvthqu2B09lJF3Nw9klOLQpP?=
 =?us-ascii?Q?1feQiPZDFTsjb4rqej+UdAoD+AZ8chzM6F042qVWakLtVFjqyjX3hdAE8eZM?=
 =?us-ascii?Q?aNoZYqiX3/0HYf+gJl/izopVIYn7oQehVrw4jbpBsA5jiq1mI0E3/iwxss0E?=
 =?us-ascii?Q?YxM528aOfEAzOy6NOJzi51fPhKsgjlXKjFozT48zi5qtcPI74q/+Kb0dTWQb?=
 =?us-ascii?Q?L+LzZy5GdW5HMCP4KGIz0RZzUM6AkJPHkYqjAzii1AE7vSWIFf9tJ1AUfED2?=
 =?us-ascii?Q?J++Oj/6Fx23c+PjkQ+n4DgSMl1gQq6IfvmW8FfILMoIVgQQH7a6JVq/f5XdI?=
 =?us-ascii?Q?nYxBeQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: S0uUe+4khwwNUqo0Fk1n4/4oGSAP3j5z4Ex5RPNsB0s6/bzlz1KIhVN/fuysCEChjsmmfUXCvC/7Q7St9NR1OcWrOr3Mam8qBv1z5VZIbLqcpKFaIDCWysDclv3kwGUQsDtDd+C1tDvsdGnlPHQnuiii5ALB3+Fr3eJhqHnBsIev7Gwf3uWFPxTyUrA655ztq2WYdUgFjf4iQ/yheRyaScqiXTy/NHG80fMfwDkDFAi6VtfC3x/1bLAZ4j0/aSgByBbK1Fy/tXH3IktlvM5hjUEA0dUUU4kjHYW6QpF1wwZ+M92hv6/U655i1F1x55Qs1Mo2J/M9bVZ1eLqPlzozL3DI+zDMyWlxR9Azp+nke1SuVidwGIEA7oLpst14zs/55F7EdWsx3CLNlNOHEpqQ6yW5sIjrnL9zMjhRUpgAueZqekvJuUXa567h/y3G++bx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 11:51:55.1501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e0ce095-046d-4bc3-282b-08de631aa0e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4411
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

https://github.com/rhboot/efivar
is not updated to support this location that's why you can mimic it by
running:
dd if=/sys/firmware/efi/efivars/VarToFile-b2ac5fc9-92b7-4acd-aeac-11e818c3130c \
   of=/tmp/vars skip=4 bs=1
flashcp /tmp/vars /dev/mtdX

where mtdX should match location defined by
CONFIG_EFI_VARIABLE_SF_OFFSET/CONFIG_EFI_VAR_BUF_SIZE.

Signed-off-by: Shantur Rathore <i@shantur.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

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

 lib/efi_loader/Kconfig      | 34 +++++++++++++-
 lib/efi_loader/Makefile     |  1 +
 lib/efi_loader/efi_var_sf.c | 92 +++++++++++++++++++++++++++++++++++++
 3 files changed, 126 insertions(+), 1 deletion(-)
 create mode 100644 lib/efi_loader/efi_var_sf.c

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 13e44be1d067..bb40cc899a13 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -123,6 +123,24 @@ config EFI_VARIABLE_FILE_STORE
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
@@ -152,7 +170,7 @@ endchoice
 
 config EFI_RT_VOLATILE_STORE
 	bool "Allow variable runtime services in volatile storage (e.g RAM)"
-	depends on EFI_VARIABLE_FILE_STORE
+	depends on EFI_VARIABLE_FILE_STORE || EFI_VARIABLE_SF_STORE
 	help
 	  When EFI variables are stored on file we don't allow SetVariableRT,
 	  since the OS doesn't know how to write that file. At the same time
@@ -193,6 +211,20 @@ config FFA_SHARED_MM_BUF_ADDR
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
index 000000000000..61d68f7c5c94
--- /dev/null
+++ b/lib/efi_loader/efi_var_sf.c
@@ -0,0 +1,92 @@
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
+efi_status_t efi_var_from_storage(void)
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
-- 
2.43.0

