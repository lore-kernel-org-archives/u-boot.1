Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34315CCFA04
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 06:02:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9192B83A35;
	Wed,  5 Nov 2025 07:02:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Q9MoXRH6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6449A83A3A; Wed,  5 Nov 2025 07:02:34 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F47283968
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 07:02:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fa6BO9QS9/EkUk+NnyZsWto15hkL/Clwnnzw4QFK4AzDErKVp9tVo53pvxyQcm1b9OHui9Rsie8raAP+2hFzy6LYrzPp0vPi2yhoR6ZVs1WK1RvZ2qi2B60774qqLQHkR/akb8KqOHmWeelPa+U4XTun9aWBMc03wdoV9DS3oq85ws3y8dQGV8gq5U/s/ZEq2Oe3SnM6Ecz54okkn7aXtZYE/Y99s33X/RZ6qnLxnJ+6pGU88JeL1Lppm78lGBJW4N3G6uxks4M8K++W9kKOv3yQxUl2x20wClTf4E7BhkoKnCmdc8JfF5gHFf1R79hS0qDyrJV4fU5mxHBgOh0VGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Apn+0TIYvDuriKOdcAHQZ29qfaEfrOBJ8dKUYg0UV9Q=;
 b=haZIPGjMQ83KrP+oqkaqu2s/08SJ0uQl3RhcsFGMrh2wMDQ5vcnFM7jgAbJeKJ8vy5sx7IxsnjHjIhvAUhymRDw7nnTP2v7KYDfLc+0+m9mUZMcogUtavuiq3jiN88BVXYRGapPz6ich2YN4FlTBTkS8im3/LUnm5izvSpbduTCBc/z74Fu6tjGEUXjx5FYlyZPwWpQkcN0/Jl/RSF9HaxW24+P6datOZ9zi1SBAmLgJnJRqBEzTPpzEhveFdkPBrrZ/NG0akpFd5YvHFfTE8Fj0X7sgOSp1RxJfCJGKBhR6d4+c+OgkBrTDjwR3Yb/Wwuaa72SMNWedL3vXDVRoRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Apn+0TIYvDuriKOdcAHQZ29qfaEfrOBJ8dKUYg0UV9Q=;
 b=Q9MoXRH6I0oBlsJVp/6uZ7LQxI66ergyJoBE3nIfAvHVLuWxu6Y6F/w7K9fj065vQ2vHE32OGHHrq5Z4HFqEwtbh5trk1cKkAjfXJ4lsmTGYLNF21oxTYPfo5BybvgifolpUkDv8Pf+ZEn/KQj+iFVyahOs2BN4AMnL8rO0UytM=
Received: from CH0PR03CA0437.namprd03.prod.outlook.com (2603:10b6:610:10e::17)
 by MN6PR10MB8166.namprd10.prod.outlook.com (2603:10b6:208:4fb::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 06:02:28 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::8f) by CH0PR03CA0437.outlook.office365.com
 (2603:10b6:610:10e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Wed, 5
 Nov 2025 06:02:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 06:02:28 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 00:02:26 -0600
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 00:02:26 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 5 Nov 2025 00:02:26 -0600
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A562Ohp3173096;
 Wed, 5 Nov 2025 00:02:25 -0600
From: Anshul Dalal <anshuld@ti.com>
Date: Wed, 5 Nov 2025 11:32:18 +0530
Subject: [PATCH] configs: am65x_usbdfu: add SPL_USE_TINY_PRINTF_POINTER_SUPPORT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251105-am65_dfu_fix-v1-1-acc29111dccf@ti.com>
X-B4-Tracking: v=1; b=H4sIAGnoCmkC/x2MQQqAIBAAvyJ7TnBFg/pKhFhttYcslCIQ/550n
 IGZDIkiU4JeZIj0cOIzVMBGwLz7sJHkpTJopS2istIfrXXLeruVX4loDNGs2gk7qMkVqep/N4y
 lfIplh8deAAAA
X-Change-ID: 20251105-am65_dfu_fix-1144eec06b19
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Andrew Davis <afd@ti.com>, Judith Mendez
 <jm@ti.com>, Udit Kumar <u-kumar1@ti.com>, Hrushikesh Salunke
 <h-salunke@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Vignesh R
 <vigneshr@ti.com>, Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762322544; l=3829;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=/6Rqzwou9ge1fQvZ+kAP4wfqCUb3ctzYxKn6tIxAxlk=;
 b=bBb6ky/6f+HNb3yNQzJEU9pr2DypedVTZfN4cN6HM9FQrErpwXT+bZWbVHEmatGJL/pGfyuo3
 Rhv3aBDzamtB4tlJF6+qj9N3X3WU8JcooI4SOpTY8IOJJYyHcpxy43y
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|MN6PR10MB8166:EE_
X-MS-Office365-Filtering-Correlation-Id: e9799b0c-5cf3-488b-26ec-08de1c30e66c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|34020700016|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXdJNU9ETEFsbklYWnhHTUs0TE02MHdSTzRieTdEb1o0d1FvSFppNmZWa3Y5?=
 =?utf-8?B?NzJJcitSSjBFS2pFdWUvTWtHWlZmV3lla0NiWW02aGxlZUVYSkV2Z0lVa0VD?=
 =?utf-8?B?NlZKeW9XekZCSm00c3BQTzNIaEYreVNJOVo5M0c0Tkk2WE5kZk51R1hVdDJT?=
 =?utf-8?B?ZGtBaUNqbE5wRGJlUnRPdjJPL2JFcGdtRmNOWVZ6Wmk0WXJrQ1JTL29HR2xG?=
 =?utf-8?B?T2lmSy8wWnFJT3pEdDk3UEIwRVNUOTI0ejBtdmg2Qk1hZTNpZTV4Z3hyekFR?=
 =?utf-8?B?SHV6NEcrbS9DTWMrQ2dCRVgwSGkvSGZ6b0dXemVpZGVUditFcjM0dEUwSnFD?=
 =?utf-8?B?NWNjU3JHaGIrWEw1Vkc2VWkzak9hME5RK09YUVE3UytvTnJKUHBaNUREWnhn?=
 =?utf-8?B?MlFua1dEdVY2bnZlNkJjelJnTVg5aC9mRTFpWmI2Vyt4clBVU1JtcDdnMjJF?=
 =?utf-8?B?bEJlMUhkODEzV3FOL29LcEE0UysvTDh1UmJsYnBjVTRHQTVTS1g4MGl3Uytt?=
 =?utf-8?B?eFk5MU0yU3pEcUwrcHdTU0p6OTYzK1lyWExoUHB5Z1pyZ0pzcU50c0ZJSmpy?=
 =?utf-8?B?Q0dHaTFiTG1mWkZaSDhWK3Q5aWZsQ0poNDRFdi9zYjRzTmJmbitvcnJ6ZjJp?=
 =?utf-8?B?WUpwbExLbmVYK3U2S21zc1VweS9VM2tlamlVblJMMHBteWtTS2l4NWtpTkZN?=
 =?utf-8?B?Wi9vT0g0b1Y3K0xWVGh0YzFEbFp0ZjAyVzVZQkVhTStGY0dVYWpYZEkwaUdN?=
 =?utf-8?B?dkxtVllTRDNySHpVYzc1a2JocDIrK3J0Q1VxVFUxOWlrZnR4Sm9aZ0pEY3la?=
 =?utf-8?B?YWdmekJsUkQ0TWxtYWsrVGwvYkE1WjZOT3AwYldXYWN1cE1LWXp6SHFMU3Q0?=
 =?utf-8?B?QzZjK3hDdmd4SVdrUUhQS0oydHdqQmtQVlZBdE9wbyt5WndUN2o0YVRBU0Zm?=
 =?utf-8?B?OTZSMHZCdkRFb0p4OTJINzkwR2xSMWRTOE1TbW1YNVJ6U3J0SjNqeHNiWFN3?=
 =?utf-8?B?ZEgyUVpFSTJYK2kxaW16WVRtNm5qYVJKLysrVGE4cGw2RGdkT2RHeldKL0hU?=
 =?utf-8?B?K3BUTU0xWHJuZm1uWGVIa0lBLytLRE0wUjhJTVRXdFZFMGF5Z0FsTkp0WStj?=
 =?utf-8?B?UThYRUJXVHdLU2NMdXU5RXpGa0pLb0hyTmIvVGNoN0xWSHh3WDdxUG4vRnNw?=
 =?utf-8?B?NGR2bGZXazl1a1FBZmU0dlRHS25JVHRRUFVyQnBxWGp1ZVNHb09tNFppb1Zl?=
 =?utf-8?B?cFp4Q1BOb1FLZCtPYmxZM3JjRUJianJYK1BFZnJKa3VYR3g4ajhMNUZKSHR3?=
 =?utf-8?B?K2x0UGZya0FvdHpZWmZuOUxNdHJTRzRDc1VKeXp5SFNweHZMdVE1ZUFpSUJo?=
 =?utf-8?B?eXdMS01VdndBYUhVdHNBdGVRd3c2elBNS3M3UnNJZHNySmFUbmpROVNiMTAz?=
 =?utf-8?B?RXpsUzB6eFpOQlloWFlZSlBHZ09sSjFNL2RXS0FSZzJYdXZnc1RPWVE2Y2xh?=
 =?utf-8?B?aUNLdi9LNlltam1SSkIyRWE5MXBBWk9qL0FEQW9UUVhFcDdDcmVFY0huV2lW?=
 =?utf-8?B?U2tldVVtMDZtVndqRWJFVjZlYVJCMGZ2UjdBRTA5aGFyM202LzJVY0NyNmxK?=
 =?utf-8?B?L3BXR0V3Qk0zakFkWUEyR2srSEVzYlhmZ1I5Tk9QNkVnTTlOU1crMWpUYThG?=
 =?utf-8?B?TG1NbGMxQTI3QjdWdHVvNFJud25CQnNlQmVzcUVaeE9vUW9iMVZRNzFrd29T?=
 =?utf-8?B?S1hjQWdLM2ltc2xlOVBkWnBNWkRGWUh0YzFOR01kbFV1U3FRS1lUcE5jVlhG?=
 =?utf-8?B?N1p0VHlwMUh0SGxQZ2d5RWVOb2k2RkVUSzc4SmJGWDlYeWZKVHE5RXBFL09m?=
 =?utf-8?B?RnlqYVVPTmNUSzBwc00wNU0rUFhiNjBYV1J5eWpIL0YvR1JQYlM3MVF3VVJV?=
 =?utf-8?B?eUhsQzFhZnJpMDB6NkpEbzVUd3AzeldSWjg1S2Q2RHZBSDl2eUxrU01DUThL?=
 =?utf-8?B?elRYZ09YQ29nZkhkWlhOYnJkMmxMSWpkNnE1L2cwNlBzWVpyMy9KTmpseFJ4?=
 =?utf-8?B?dUtTcElHRVcwRnVua0lwVjlRUVhRMkZoQ1hoVnp4ckxVMGxMVE9JWC9CMk9T?=
 =?utf-8?Q?6WwE=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(34020700016)(82310400026)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 06:02:28.2053 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9799b0c-5cf3-488b-26ec-08de1c30e66c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8166
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

Since the commit 1e24e84db41a ("tiny-printf: Handle formatting of %p
with an extra Kconfig"), SPL_USE_TINY_PRINTF_POINTER_SUPPORT has been
made mandatory in order to use %p which would earlier have defaulted to
a 'long' print.

Without this config symbol, k3_sysfw_dfu_download fails to set the
correct value for the DFU string with:

 sprintf(dfu_str, "sysfw.itb ram 0x%p 0x%x", addr,
   CONFIG_K3_SYSFW_IMAGE_SIZE_MAX);

The value we get "sysfw.itb ram 0x? 0x41c29d40" causes a boot failure.

Therefore this patch sets SPL_USE_TINY_PRINTF_POINTER_SUPPORT for the
usbdfu defconfig and also cleans up the usage of "CONFIG_*=n".

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
Not sure if a 'Fixes' tag is appropriate here since the commit
1e24e84db41a ("tiny-printf: Handle formatting of %p with an extra
Kconfig") did cause a regression though I think the problem existed with
the usage of "%p" with TINY_PRINTF set to begin with.
---
 configs/am65x_evm_r5_usbdfu_defconfig | 63 ++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/configs/am65x_evm_r5_usbdfu_defconfig b/configs/am65x_evm_r5_usbdfu_defconfig
index f9161f1fe111ff97f7aa79f10b21c3b0ab1dad32..b3def7946b3eb799582f04cc522725cb3f9a6eb1 100644
--- a/configs/am65x_evm_r5_usbdfu_defconfig
+++ b/configs/am65x_evm_r5_usbdfu_defconfig
@@ -6,6 +6,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x57000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_SPL_USE_TINY_PRINTF_POINTER_SUPPORT=y
 CONFIG_SOC_K3_AM654=y
 CONFIG_K3_EARLY_CONS=y
 CONFIG_TARGET_AM654_R5_EVM=y
@@ -41,34 +42,34 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x0451
 CONFIG_USB_GADGET_PRODUCT_NUM=0x6162
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_SPL_DFU=y
-CONFIG_MMC=n
-CONFIG_SPL_DM_SPI=n
-CONFIG_SPL_MMC=n
-CONFIG_SPL_FS_FAT=n
-CONFIG_SPL_SPI_FLASH_SUPPORT=n
-CONFIG_SPL_SPI=n
-CONFIG_SPL_SYS_MMCSD_RAW_MODE=n
-CONFIG_SPL_DM_SPI_FLASH=n
-CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=n
-CONFIG_SPL_SPI_LOAD=n
-CONFIG_CMD_MMC=n
-CONFIG_ENV_OVERWRITE=n
-CONFIG_ENV_IS_IN_FAT=n
-CONFIG_DMA_CHANNELS=n
-CONFIG_TI_K3_NAVSS_UDMA=n
-CONFIG_SUPPORT_EMMC_BOOT=n
-CONFIG_MMC_HS200_SUPPORT=n
-CONFIG_SPL_MMC_HS200_SUPPORT=n
-CONFIG_MMC_SDHCI=n
-CONFIG_SPL_MMC_SDHCI_ADMA=n
-CONFIG_MMC_SDHCI_AM654=n
-CONFIG_MTD=n
-CONFIG_DM_SPI_FLASH=n
-CONFIG_SPI_FLASH_SFDP_SUPPORT=n
-CONFIG_SPI_FLASH_STMICRO=n
-CONFIG_SOC_DEVICE=n
-CONFIG_SOC_DEVICE_TI_K3=n
-CONFIG_SOC_TI=n
-CONFIG_SPI=n
-CONFIG_DM_SPI=n
-CONFIG_CADENCE_QSPI=n
+# CONFIG_MMC is not set
+# CONFIG_SPL_DM_SPI is not set
+# CONFIG_SPL_MMC is not set
+# CONFIG_SPL_FS_FAT is not set
+# CONFIG_SPL_SPI_FLASH_SUPPORT is not set
+# CONFIG_SPL_SPI is not set
+# CONFIG_SPL_SYS_MMCSD_RAW_MODE is not set
+# CONFIG_SPL_DM_SPI_FLASH is not set
+# CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT is not set
+# CONFIG_SPL_SPI_LOAD is not set
+# CONFIG_CMD_MMC is not set
+# CONFIG_ENV_OVERWRITE is not set
+# CONFIG_ENV_IS_IN_FAT is not set
+# CONFIG_DMA_CHANNELS is not set
+# CONFIG_TI_K3_NAVSS_UDMA is not set
+# CONFIG_SUPPORT_EMMC_BOOT is not set
+# CONFIG_MMC_HS200_SUPPORT is not set
+# CONFIG_SPL_MMC_HS200_SUPPORT is not set
+# CONFIG_MMC_SDHCI is not set
+# CONFIG_SPL_MMC_SDHCI_ADMA is not set
+# CONFIG_MMC_SDHCI_AM654 is not set
+# CONFIG_MTD is not set
+# CONFIG_DM_SPI_FLASH is not set
+# CONFIG_SPI_FLASH_SFDP_SUPPORT is not set
+# CONFIG_SPI_FLASH_STMICRO is not set
+# CONFIG_SOC_DEVICE is not set
+# CONFIG_SOC_DEVICE_TI_K3 is not set
+# CONFIG_SOC_TI is not set
+# CONFIG_SPI is not set
+# CONFIG_DM_SPI is not set
+# CONFIG_CADENCE_QSPI is not set

---
base-commit: 1c250e444ad3b15315ee8b0fcb3fc3acc26449e2
change-id: 20251105-am65_dfu_fix-1144eec06b19

Best regards,
-- 
Anshul Dalal <anshuld@ti.com>

