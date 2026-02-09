Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7967BCA5FEB
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 07:29:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10AB983C29;
	Mon,  9 Feb 2026 08:28:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VT3ZhuuJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 867FE83BF4; Mon,  9 Feb 2026 08:28:45 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8714183C29
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 08:28:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-bhagat@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DDQi7d3bjNe+AK7+YdHakXK/WB4WoCCkT1rtDehsFBnuYsKe966NpM4pUUlMjxUwVhgdlqDwTfC3N9nSc6ASvQnzOKnGo5lk7CMmzMu+zPO+1WvhQJVd7GuPejUhmBFzMaN5VlmHNdUetzsCmgd73u/0JQzC9Epsc5i2/tDmjl6AUt/ViD1wANJVlU7UViatb8H41udbY7ijVN2yI4q3W39CboPbatKGr31EUBCuK8ToFv9pGolYtoCiHKBbYrqjSKSuI7RQe6vRV0PRAdW4nOqyiIjlXYREZPq7lFGkBIfyPoF0EXse7BgJ042Kkfi/a2GzqjiSQFXA+1V0JVBGpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJVDbIZ1W+tOBjDyLKawpezVGkKkY6UGMWgAO7Tr7S0=;
 b=I17G8lqkmbKdhEUJ5GN171z6REyxu4r+i2raZEsGMP2OiFxt27emPTq+Bkb0XczjAXNRLS1mV8fhfcH4KosvfecjMqml369+LWINM+lzefTNzcMFt9dkQVwPFsE8agQVCrrCoVU403wIfmHt+KnZqmI85ojBhMYzGgjNBjOP9s24XTEXwuCFrs4JqUInCuEaIuLGl8vIqJU+BUzSwjaJFghRf1ubHXcsTj0ZPghj6JpoUEi7hPdWLSYwdAheJSntGkSp1nDRBgv2PXY0HYGuitQ3fSCxuK9pppuulTN85rxtqW4o+9jZDZxQnWU5nWP+ti+i/3KZGOcLF/tjxgzORw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJVDbIZ1W+tOBjDyLKawpezVGkKkY6UGMWgAO7Tr7S0=;
 b=VT3ZhuuJVBpFrmH0Wg7xIF87e44UTzMb0PyaGDXj9c1osgYFIbYpSjYroTRnipnjEsL4RRvI6i83Z5xRgQreF5DYxoPNf+5MdYOAKXIcO6zcAPfZ1/0uzbqsCwo9JBiN3wlMNiRxtCItN7LxyfQjHnY9JDqR4OZrD6ZHjP0XTd4=
Received: from MN2PR07CA0030.namprd07.prod.outlook.com (2603:10b6:208:1a0::40)
 by CH0PR10MB4937.namprd10.prod.outlook.com (2603:10b6:610:c5::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Mon, 9 Feb
 2026 07:28:41 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:1a0:cafe::a) by MN2PR07CA0030.outlook.office365.com
 (2603:10b6:208:1a0::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Mon,
 9 Feb 2026 07:28:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 07:28:39 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Feb
 2026 01:28:32 -0600
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Feb
 2026 01:28:32 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 9 Feb 2026 01:28:32 -0600
Received: from localhost (ula0502350.dhcp.ti.com [172.24.233.249])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6197SVaU1580234;
 Mon, 9 Feb 2026 01:28:31 -0600
From: Paresh Bhagat <p-bhagat@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <c-shilwant@ti.com>, <s-k6@ti.com>, 
 <nm@ti.com>, <afd@ti.com>
Subject: [PATCH 2/2] configs: am62dx_evm: Enable SPI flash support
Date: Mon, 9 Feb 2026 12:58:20 +0530
Message-ID: <20260209072820.2576854-3-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260209072820.2576854-1-p-bhagat@ti.com>
References: <20260209072820.2576854-1-p-bhagat@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|CH0PR10MB4937:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cbfa21d-5e62-43ac-f99d-08de67acd851
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bdiSRLUT6aKxCv9+egXXY1siHSbnlIdUfHaEHu/yyA41qh6EVaEpCZHvwiXB?=
 =?us-ascii?Q?r2I6FJdf1/HOUjpICrqK7j2WbpYSXQZWnmViskcBciATUHIm1MH+MOzHZfDW?=
 =?us-ascii?Q?eEMYEUQ2S6/6iq4SobJ3xb1eHGj6BKxRwL+c8ORsw4IypvG0Najr1tv4jbtn?=
 =?us-ascii?Q?1hmUj0Fsw2x7Za/oPN24MyoA64SZipocm+O1MX3cNg7qS+Vmebp39cO0nC6W?=
 =?us-ascii?Q?KosYGSMLLBwAbD/u+dQrPEGVb2LwJtX8rLDgRHRaegduGbVTX6/NNN5QmMnT?=
 =?us-ascii?Q?YpoEmGvB/JpTJD7EltU4vIV7/laKlAkaHshB3TUkS3/1jL4KYnwgLhhwJ1Up?=
 =?us-ascii?Q?Mi0FyLq96leW85wZu39CbBuabJ6+3AHpRS0SHgMZvjEclPPOY8NEoWefSTXh?=
 =?us-ascii?Q?PqFEzlDZjjD9G8f8rKl7cOSTvHZVJ3toYsTBxm2L2s9bnlw7V9c5nAm6l5Bl?=
 =?us-ascii?Q?QkCJ5mDkTUzsm6mCJSndS0s9oQUAxk4JHua+yLvzH8syPi0Yv0LUNQuLCZTJ?=
 =?us-ascii?Q?HxNfvAQkQ7i0yH1qygmy1i/hFOTxBOggVT6QXyHR2kWy7Vqd52xMwU2UFS7t?=
 =?us-ascii?Q?rQgwJR0nzmkKKtjUX2ajwskmBIR2UiqVyAUNzFl6hrJ8JWRd9syO07bo+nKZ?=
 =?us-ascii?Q?u8YnueO4IKU2d8GinIZFjHNEMYX/v64q7gDUQx7aMNsYisStUXyv7bT17EOB?=
 =?us-ascii?Q?qgp3wYhvboi+NZ1mqRnxFN9aZK21rdkka9Xoa7aJnp8ysTnA02MBLd1h8IWs?=
 =?us-ascii?Q?lKFON4qQfi5D9Ub4FadyBrbJIfw3Abt19E9BMLGsCL0m7WlEah00khgvQ6dr?=
 =?us-ascii?Q?0ayBCATtgEoHDFq8Y22A6ItFZGZ8hsPvimhTBCxEK8plMNDFk9LYO2HF53wk?=
 =?us-ascii?Q?pUYvU/FOOliisxIq+QKddv8hs52DNrXwvrgLCLjvOxTEh/ZfapcfLTp/nDAZ?=
 =?us-ascii?Q?p1I6upiycdOdqL8b8ZBkXA5jVAEtFMmX2JOLQs0vR4sO4XjA0caC8xyRRhrB?=
 =?us-ascii?Q?JZu7KhbkGv55Ba+f2I2tR8fLMumO0I3WVMT37MP2xcHmw8j3phHTM+PlkG1w?=
 =?us-ascii?Q?WLB10qobK2Gt6iSq+3wLoamghWo4xc3CyamXh71wv+L/Qbpr/KJ3ck1ReSd5?=
 =?us-ascii?Q?i4zjcKo09rzbSMe7+Afstn0eqUUBxZ2tdV0cXr3Ene7CPvInhU9lQ3wSM4bd?=
 =?us-ascii?Q?aJKoz6rLQomdlaX01fHVYiZAlLq/p61wr8vk/wGpXqceq9e9m5HS+s6kGZlF?=
 =?us-ascii?Q?vRI/eIzAg1GOdeEel7Q7TJiNqGJc1kDEzfhmM2LzHRhp1MiSi38y5++IYHmP?=
 =?us-ascii?Q?pofl/unycrWY21nGIuiEjXunddWfgFHdvmywChwMl1A/tkPGYx8K6CaK8Q/m?=
 =?us-ascii?Q?OFuIiX1sIoc6G0nuPJsmb5MsBlli87TNbtd54+acNxGH7pLWYfwG5yZDX3M9?=
 =?us-ascii?Q?c9iNhHFbKKSJ0PBnl99NHjkK2yiVfFzfCMZzs8spuuQq7sTVHrA9Tut3idyp?=
 =?us-ascii?Q?Ti5+irbZD9c1KQudwgreAGSZiBUetFPxQXZIQ54HJPVQi7RPdE4+SmBn9rUP?=
 =?us-ascii?Q?cKGJiy6zLgEzmOaFghVPKqiT7oBNrdj9TLup8vsqMt0i8zBL1WkX0nLIXUea?=
 =?us-ascii?Q?5efuBTcTEKsUxbtF72EA6RgbSZOO9Aceixa6+iYdH/KHHwn8499BJ9xkdcqW?=
 =?us-ascii?Q?5MUD9w=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: E5P0fZJmX3jPANLrjlDgABKH85E4xy0xVwG1LXpmxhiM+Kq5jpZrmOTRBXMDtcblObQN6F4yrdv+30t6S8RrWWv1qhpz3SjJauXth8sk+1zKErpQ5EwQFrVyiXqVqJgJnzhx03F1BUYRn1S/J1YYj3F2YtO6zirOVH7gUGr1AlMSOMtAidRoU8j2DUsmFmTXVf3x3Id+q5s+epjF1dstybjEGe0TQowTgzgTtDyZuUeBBF5Xe6/1R+WtY4DyTIbHpDKTv6yxXrW4N/i8ko+mnNDcLmPs2Y/u/GHwXxFSKXbCa6qLuEp3lkNkJllLrnQVUTswAVSb6daYVKelc3yjnbbLm8x7/BwptqvAXrLlauegw/qqfyWC4xgGn3l8arUiV3HZ0UW9OnkaOAla736Mtm1Ir+ch6fDr/potZ3bP0wYFMeA+/ozxr9RfA74890re
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 07:28:39.3341 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cbfa21d-5e62-43ac-f99d-08de67acd851
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4937
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

Enable SPI flash support for AM62DX EVM by adding Cadence QSPI driver,
configuring 25MHz speed, and enabling SFDP support with Spansion
S28HX-T flash compatibility. Enable required SPI and MTD configs for
both A53 and R5 configurations to allow booting from SPI flash.

Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
---
 configs/am62dx_evm_a53_defconfig | 11 ++++++++++-
 configs/am62dx_evm_r5_defconfig  |  8 ++++++--
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/configs/am62dx_evm_a53_defconfig b/configs/am62dx_evm_a53_defconfig
index 302f8c5e936..d323a060d55 100644
--- a/configs/am62dx_evm_a53_defconfig
+++ b/configs/am62dx_evm_a53_defconfig
@@ -6,17 +6,26 @@ CONFIG_SOC_K3_AM62A7=y
 CONFIG_TARGET_AM62D2_A53_EVM=y
 CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am62d2-evm"
 CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SF_DEFAULT_SPEED=25000000
 CONFIG_SPL_DMA=y
+CONFIG_SPL_DM_SPI=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
-CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPL_SPI=y
+CONFIG_SPL_DM_SPI_FLASH=y
 # CONFIG_SPL_SPI_FLASH_TINY is not set
+CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x280000
 CONFIG_DFU_SF=y
+CONFIG_MTD=y
 CONFIG_SPI_FLASH_MTD=y
+CONFIG_DM_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_SOFT_RESET=y
 CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_S28HX_T=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_CADENCE_QSPI=y
diff --git a/configs/am62dx_evm_r5_defconfig b/configs/am62dx_evm_r5_defconfig
index 7a3ecee7ec1..90d6650fedf 100644
--- a/configs/am62dx_evm_r5_defconfig
+++ b/configs/am62dx_evm_r5_defconfig
@@ -5,16 +5,20 @@ CONFIG_ARCH_K3=y
 CONFIG_SOC_K3_AM62A7=y
 CONFIG_TARGET_AM62D2_R5_EVM=y
 CONFIG_DEFAULT_DEVICE_TREE="k3-am62d2-r5-evm"
-# CONFIG_SPL_DMA is not set
 CONFIG_SF_DEFAULT_SPEED=25000000
 CONFIG_SF_DEFAULT_MODE=0
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
-CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPL_SPI=y
 # CONFIG_SPL_SPI_FLASH_TINY is not set
+CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x80000
+CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_SOFT_RESET=y
 CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_S28HX_T=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_CADENCE_QSPI=y
-- 
2.34.1

