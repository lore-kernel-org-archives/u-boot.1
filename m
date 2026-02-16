Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE7FE7BDBB
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 13:17:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A40A880FA1;
	Mon, 16 Feb 2026 14:17:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Nsww5hg1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EEB7831AC; Mon, 16 Feb 2026 14:17:53 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC0578063E
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 14:17:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q7Igb9Ec+WJh7bxZ/ECsWzQsy+P3yAsWCqEX38yzXQU6yS6ZXmltwXBkLdq6DobXRBFcbKrnE2g7srfuRt5e7/DlrObkArwgU+t9UXQvGKdbyJRHivaKEkFD3OHXAqtQO43X+Zb2/SmTPLpCo4DP7tnWl8TorX+VpMv/GRmRwbg02ELAbaw0SWCtmpLNu5jpdu8oWVKuF8Mui4lcjO4nSJixoXKb0jH9z4TWhGbGjHsplTulXbMATiCuJF50o+z/DAsh0MZ5Z5AQ1AuF01FTcIyvqY82ovZDJFYNHhVAu+nzr831txUb4pQqIPZ74d07WJrjysz+glFY4Oa+nMUz9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hqF9UIMVxR42jqrezXuDMjYw1x24gWiSy9oxOoM42Jw=;
 b=MWaR5FEc+7JYJU1Wdn1raYjjPhGeDcGYyoRSXn8fHUcijMcV8dvQf7qNhfQDfWYND9h8kIcBqjHHf4rOUvKinm0mcD4QvktFe0iXBDoa+G7s6pOp8MnxZqX+NUcaPCk/xK/1320PDgD+ly3zP3podpayb7zYdSBPWAyCXGBCQRrXGrVyxkNgUGc9eDgaCGdOr/oeVi8f3rSDr+jgYw9gIzyniVpMBpiXml7r2N14Ic9+zQExO5J8jX5e/LSXYEdlUxuHpUq8zdyd4dA5mZNSR5ioY2inAOz62ILonXlcYSr7wHG1X9V4fmVD55Hijw+6pwCJQA6DjfxzAyuvmDIelQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqF9UIMVxR42jqrezXuDMjYw1x24gWiSy9oxOoM42Jw=;
 b=Nsww5hg1PLMlVAyJeWmaAHQnbkYXpjVVyWvByPxgWd5g5/300qD9ibHZWHdCY/JTB7ELgWBbaWKLyI8hShPlD0um/xkZzUblMqtmQbuSXPVjH8hLiRJjdPBxISYwQhKZroI6r2t3LBgtmwCZXf4p0iGrPGG9jyMMIdmzMByejFw=
Received: from SA9PR10CA0020.namprd10.prod.outlook.com (2603:10b6:806:a7::25)
 by DM4PR12MB5770.namprd12.prod.outlook.com (2603:10b6:8:61::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Mon, 16 Feb
 2026 13:17:45 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:a7:cafe::38) by SA9PR10CA0020.outlook.office365.com
 (2603:10b6:806:a7::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Mon,
 16 Feb 2026 13:17:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 13:17:44 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Feb
 2026 07:17:44 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Feb
 2026 05:17:43 -0800
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 16 Feb 2026 07:17:43 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Shantur Rathore <i@shantur.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Gabriel Dalimonte <gabriel.dalimonte@gmail.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Jonathan Humphreys <j-humphreys@ti.com>, Simon Glass
 <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini
 <trini@konsulko.com>, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Subject: [PATCH v9] efi_vars: Implement SPI Flash store
Date: Mon, 16 Feb 2026 14:17:30 +0100
Message-ID: <f49e4ac8da5bae9252c79031f1661f386d17895f.1771247847.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6572; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=CTN2BOMh2YkcID/WJCRO7IJA5Hg4+RDqKRq7ZTjRAVg=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWROlnjN5RCscHHiwZV7bWc66F6Nebm9OVr6WdrqGrPvX
 F8uer5901HKwiDGwSArpsgynUnHYc23a0vFlkfmw8xhZQIZwsDFKQATuTCPkeF+87xpB3vVL189
 X6e++eGdJo9XoqEdIpOXtflcrfcyLmpgZFi6fWa3JvPM/hjJH/7ilWcTW2fc4ODkfyM3g+3UjFe
 Z2/kB
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|DM4PR12MB5770:EE_
X-MS-Office365-Filtering-Correlation-Id: 145ea0ac-390d-46c5-f55e-08de6d5dc5a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V2QOqoS6WcGikpOqZRt9iP8NBGBmCkHDKgDFnRhbcE3ZEYyYaOHStvg73Ucr?=
 =?us-ascii?Q?pCq38a5FO2z7lU69A8QPt1MpTdUDhqp4Ewx9LFdqXkdvhuVmkZgohT89BD9Z?=
 =?us-ascii?Q?xZu/aET7wtrZuMrjHdnPxEPZKVCnbLxK6g1rAzSKerrgYFTNM3RYsivWXWnT?=
 =?us-ascii?Q?PDNp8zTvYiIjoNq2pMVi3K9xPIDvUmEdbpKydGFg+oSo4JgMJECiqk1xdYZ/?=
 =?us-ascii?Q?2EUj5ah9YrlS/EhhivJG5BovlzB3/ryXb8s0l30kHWRGJHWVtDM4sTUlCSAv?=
 =?us-ascii?Q?0f2CGKAfrAgqlcS4V+oqDny93B4CmaKAOcMOX4+Rd9ut+edz9fO4IU4+NXi4?=
 =?us-ascii?Q?1yc9tIGbVvItwr8Ex+teKXimX+OdHvMZi2cumdNjtBg64vdh+o26MwruFmeW?=
 =?us-ascii?Q?heGvi3bYcNJgEO/XDxxFE+XT3ScoqUay0uYK3oLL6G5RJTwCf5yHy+RoBjEU?=
 =?us-ascii?Q?5C18CRakxdeY7GtY3Whps/RlBSwbE5CW0ziAzsEazuQyKjkOFCz0su5vJSIw?=
 =?us-ascii?Q?uq0Uay1HXiv38OKZiHDi5Gh6+hpolEoCNAd8g0uvEi+yXBOOcAChekVIfPve?=
 =?us-ascii?Q?X2Gy73xvgStbq0kNHR1aEEJRsWSbU+njxGVuhImyoRscmMH5Q/a6F3PYvYaR?=
 =?us-ascii?Q?LUXetnWkLe01V6iTBhJcC0yxP0A9NNz4NjohfvA9U1w0s1ct4iz2Mn1cbDeW?=
 =?us-ascii?Q?LhB5FphrKMIux70AjLN3vmqgfyFx9n4FCg9YsayJnyF9+72c29Ocbyxw8xjC?=
 =?us-ascii?Q?eTIpLEMzuSTaaPuFRiRVLFLHuMkR0dOpmS3BnmRRFQ7gtVwLfc+RdlXGmL7b?=
 =?us-ascii?Q?d1B8KhtcxiZW5mFyHPL4gSKochKLhS8aRPB/KS49nuHMI8kI6UPMmtbXzC8m?=
 =?us-ascii?Q?FtIEjKgQbsabVhw6u+ULcwObxmlyBOjCoctQjDx9TH3yDX7WjvwZdlJSAJ2w?=
 =?us-ascii?Q?QXCvVkHVmJ3yyyo5U7OR9dvc9j8pGyu+uDcfaVZeYwxImJMFdDL7lHVKaygm?=
 =?us-ascii?Q?50XN8+RmCFxsSVtLbJMNzs3VnAFMWYZUjUsB7ijj+3baJrgV3THq3jM/YUYe?=
 =?us-ascii?Q?cydp2AYXeFTgt7h6FzKkYavZnbLSd508TaKthl+857Bk6tQyrcugjZLnEE2f?=
 =?us-ascii?Q?N/g/ZMLqxW9ZH5I/8eF6pkadUTiqxbtwlR0DdcLkfSWEynzrGEXx5ENZfMar?=
 =?us-ascii?Q?3dNM89DZDTRfdD3WQONAB76c5rKuVH7e+uHsBBr5ZBIwvWQR95mTiNNDUGf1?=
 =?us-ascii?Q?sPLAdD5FkH1LNbzdFg2akLlNNnUkICCnBUyGw/Q0xJwoY+YT+O6+mgP66kYg?=
 =?us-ascii?Q?oGTyWgov4EqNv1AdJF9b0HKikqym8meuOlKWNZ0A+6T9YVTowu8DdtEXuttn?=
 =?us-ascii?Q?KQ3VRDQuxQihsnRC1bRpYtgkVSkrbNF870K/movQpeJcVRQ6VNm0NoMMqOlA?=
 =?us-ascii?Q?5NAYxoL3NQcx8tmDAKwOUT8kT5WfEl/ewg2onVBHo0qotngxGzycGhBn7y06?=
 =?us-ascii?Q?OTrrDu0rit3tvIk5gVhpeYOJozrJsgTSmOBdbAY2b+g2/me9hw+xvDvL0FsW?=
 =?us-ascii?Q?gkRRSeASlZVdiButcxJqSZzY3zLKrhtAqJBrlbeM/7I/fA3nyQ8yeUx3UF9A?=
 =?us-ascii?Q?O4I3pVwgpA8uk7ILLzv1H9ohprfZo96Sk7lhz5vb7jOHTp9XrpnY6eEW9WAi?=
 =?us-ascii?Q?REsNPg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nZ4u/KEB3n6N/GFz6RzeOu+TSAte3vHjixdgCesp9hvTecGfUKZiVzSJqhlzl6ezB/doNOkKWgQhl/6MCm1iEvy6eYU60q9DKnk6kZQlE5SISJqfzxXJnrLAIgdJvt91AThHv+MXKQov2X6mziSNlR5Tj+HCLplzgNP4bH0ouCfJwNOcNOs6Glff4HKGIky+O7+fIxWrVoje7Do95MgUELRRzxDRbU0NFFzyqFCgaf4SAo7KJIWMroFjZ5pNleKkfYvh3ROAsB1KsQsDYSjslyWZ0ZU4T2vCc9nS3SIbEmjvR9GA6rLoasFcZVVlW1M9SAzXVC/qEpz0lSBVgluQd9811YnXCtDdL3aI/iEk8FgyEPC2vVLpUuYWjqUE2LJQ+CGbR/eWW+KxLSasuA3GpS51UpVlqEvLzgCkqnMnpk201I8EuWmmUKSFNUn4NKw5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 13:17:44.8159 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 145ea0ac-390d-46c5-f55e-08de6d5dc5a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5770
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

 lib/efi_loader/Kconfig      | 33 +++++++++++++
 lib/efi_loader/Makefile     |  1 +
 lib/efi_loader/efi_var_sf.c | 92 +++++++++++++++++++++++++++++++++++++
 3 files changed, 126 insertions(+)
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

base-commit: ed6e970569b45c02a354f443502ed7616e0b0adf
