Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A2BCCFA1A
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 06:48:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B73E883C67;
	Wed, 12 Nov 2025 07:48:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jKNa2xIt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E74683C4B; Wed, 12 Nov 2025 07:48:04 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9471A83C67
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 07:48:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZa4Ia4LkOtUjuagdrQCJJICcrU2D7pdSjsjLy/NslkhuLh723DO6fdqO06X03Cpea/tNfpPlUlbxQf8vtle6p2+OH/XD0ckcCyaM3uaN7uPI/EAA6quS7g43Q+1MR/QPwDBuQ4E0heOCMQq6QArOukV0NuVakNHosQE5YHNqFoWfoRV9pZKl2bwtT1D0IFkxpgOpqNlOxm8fDtMepgObcFKBqcBUfHRMRcFicaKXJ+ndYSMSQHCaVkeOj3fUdYDBkIspU89ya4P1c0d1GmwlIc2fZNW74EBpLdKBGXKfpUona4gEn1SOKkXAL+Ro4abX+9W1Q7DNOeyU0aO4TAq2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYYYkaI4WDExC8EdMYqKWHeAREpnd/f9+uVzJupYQLY=;
 b=LU+bpvNLCwbcMlet9dh0iqTlowB9XuXyuyUGngd5ZVWenVa4gnR1lWSYk0PyuCFppd8JOxrHZ7hdLfIxkKmelG36aUvmIi3jmrI6hmBPg0a5LnKLEoBDa0nSB5FiWbjg+xT9OI5OdKRZ1ukEVvFMH3q7F3ujjc7gw6A7NS4S1feIXaj8xxktymHDUKxZedz2OM1dhe6vGZD8YDLkGhbvd94uHM1Wf6dcdJn5o7aDIkJLCIOeoaCcMKEvtTNy4VXHhw2PXfjm455d9xlhQet05Gs26jyo3zLXQd0h2GlZ8U6P/waelRcSPgHb0pLPfxvGktyq8ghehXIsCX66d5uWBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYYYkaI4WDExC8EdMYqKWHeAREpnd/f9+uVzJupYQLY=;
 b=jKNa2xItHAvonk+iKpaUi4M05ZkLHHnjZMb5JMdNPVJcyJSbfm20bJ82g3d+5zTU+zl/WLmXqrMlh4HC90GG/b4/oMP3c+4lxclBCNxtIUj17dhLuIqTOi0+rXN5pZoq+zgbv0SzQ76SB5ZSU/o2Pq8FzvP19DQ/J9naV4SuqyU=
Received: from SA1PR04CA0020.namprd04.prod.outlook.com (2603:10b6:806:2ce::29)
 by DM4PR10MB6694.namprd10.prod.outlook.com (2603:10b6:8:112::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 06:47:59 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:2ce:cafe::80) by SA1PR04CA0020.outlook.office365.com
 (2603:10b6:806:2ce::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 06:47:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 06:47:56 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 00:47:49 -0600
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 00:47:48 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 00:47:48 -0600
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com
 [172.24.231.157])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AC6lPoa2217584;
 Wed, 12 Nov 2025 00:47:45 -0600
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <trini@konsulko.com>, <c-vankar@ti.com>, <u-kumar1@ti.com>,
 <marek.vasut+renesas@mailbox.org>, <n-francis@ti.com>, <peng.fan@nxp.com>,
 <semen.protsenko@linaro.org>, <s-vadapalli@ti.com>, <jm@ti.com>,
 <m-chawdhry@ti.com>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <danishanwar@ti.com>
Subject: [PATCH v3 5/5] configs: j784s4_evm_a72_defconfig: Enable configs for
 PCIe boot
Date: Wed, 12 Nov 2025 12:17:25 +0530
Message-ID: <20251112064725.1049199-6-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251112064725.1049199-1-h-salunke@ti.com>
References: <20251112064725.1049199-1-h-salunke@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|DM4PR10MB6694:EE_
X-MS-Office365-Filtering-Correlation-Id: be934b81-e6ac-4180-295e-08de21b769b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YMlUk/zS0SBVy91nJ7NXjsvvR/R7iot1X/VmUhV+t8afUNEgdA8fS0HyVlRF?=
 =?us-ascii?Q?TBuIm9nQfFl3b3AVh07WrJeKSptnA7JVsnEqt0G6IHCOjsIzWnwGxg9GN+Uf?=
 =?us-ascii?Q?bDF0MFIcSK+fGdIBHsJ1up43xYutLsSPutH3wHklUhg29/VkY8w2pwFZYzD8?=
 =?us-ascii?Q?zThzxaDvsF02keWzFfGsabMfsbmupbbxWX1EiJj4yhtPcBwdhDxFU8jNANH9?=
 =?us-ascii?Q?/pNyitnVnF59fEtldrDgZR3vIkgD3zZwFzPSq9g7OgfZM5BLfYBFVrOA3x1e?=
 =?us-ascii?Q?DgUeIWsXDgCDBpCo2D2GnoVKsLpXOfMJlkHwu2dPdKsW5sQnsczhQl9W+N6c?=
 =?us-ascii?Q?mMcYjoCPWNtEssEIZ987IVsKTKgn6bzS0Ho8XcqHg1bGQYSD8QC8KTM42my8?=
 =?us-ascii?Q?xh28IaYlV7kwOawOxOY6TF2J12Wi9GTWzKJLLnqGNMM8C50Vo1w56E3nPoJx?=
 =?us-ascii?Q?ggZIOyC5a2nev5sxtVuodixLXzcHKd3rMHjzGJkjngiEPtuC/w62m2Y2cCna?=
 =?us-ascii?Q?yvPgP8RElM5m/5b60xKVcJ5KGev87v7M+n4nhSVi+icoFQVd66wTQBivukuL?=
 =?us-ascii?Q?VsdShAjx2i9Vr0XeWU/eaRSupffmpCkogQNhqkVozvHgtn68ba1Sf7Kxz3HN?=
 =?us-ascii?Q?NsVeZeN09jsYSGne20LoAxPhS6GtQ2v9qb+nea5fKuLjhPwMYQvHG8RhkDaG?=
 =?us-ascii?Q?kgFIDdGjDQMnp1ogW3o9+SSOg/+u4zJuVKBLD2FnLLLF/87FgWnymy85bAm7?=
 =?us-ascii?Q?+J4OyPB5nCGHWEEhZyVf9wl2a5xrJWo3dqeAl7FkHKWTaLWn5mVomfZIHSTp?=
 =?us-ascii?Q?Dn/zO9nDesnVTtW2ea2tq/CsGFJcm28IE1CpHYXcL3+QOyPKW6LZOULBVq6U?=
 =?us-ascii?Q?YHWn3zzQYQ8fZWvHHT2j3VIWyOAGbOqcxDV4DD6wpow6cTB6+VaRYrxaMaZF?=
 =?us-ascii?Q?isXgzlTsKy29eLcOuwltgiWOlVBgkELZPDCwpN/5Qdhu6MvuVtA2tslrV5z6?=
 =?us-ascii?Q?oLpqdTvLEkTGYBPcj4s1tmEG5b4uhN1J10FGCkNbvdmqDU0uKoqgw4mCCpWM?=
 =?us-ascii?Q?HC6sCqAQUDsufs2Ilhmky7nQNBBSyrJZYpOePnn0//HT7JT3NTO5dXUPOAes?=
 =?us-ascii?Q?NRJROX0HVeObb2EI04in2KFdpg0/mlr16OlJmtVHYW1JmVK/Yfrz0qbvUv5w?=
 =?us-ascii?Q?7/Z/SfbPU64rta6mZ49TX4WQ81ipBacuksJRVQiTUAfsfEmFu3Q3qxp6xYTJ?=
 =?us-ascii?Q?nC+ZqlmrbSzsuyaDX6FgG+cL90hk2rTXPVQstSF/kyglAj6O6eJ8GcyDUOnF?=
 =?us-ascii?Q?f25bnROWcKpae6yLp24HWsSM63wBjFHZeFbwnsn3/SVMulvWjio8FTqcKq+a?=
 =?us-ascii?Q?+pATws4fxm7KhNUlfC8Pt7f+7tlZy+2xg06dljiiJ3EtNFWvt1+TrEkre9dQ?=
 =?us-ascii?Q?mUnbLptarQIw3Q++TU2dQ19ptyJaeYMJ8Ft59Z9YSBrUgWkfYyZGodq/Vg42?=
 =?us-ascii?Q?18I1JBes1+RHofnWVZpjoLIX42yQqRTwwa23Xou+MOKphKnhZ69GV4i85Aap?=
 =?us-ascii?Q?0zD+Fn8bIxOTVg+r2d7RvyN2ANpws5isaFC+fOgI?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(921020); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 06:47:56.9031 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be934b81-e6ac-4180-295e-08de21b769b3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6694
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

J784S4 SoC has two instances of PCIe, namely PCIe0 and PCIe1. The
PCIe1 instance is used for PCIe endpoint boot. Enable the configs
required for PCIe boot on the J784S4 platform.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
 configs/j784s4_evm_a72_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configs/j784s4_evm_a72_defconfig b/configs/j784s4_evm_a72_defconfig
index fc7acbae694..face831797b 100644
--- a/configs/j784s4_evm_a72_defconfig
+++ b/configs/j784s4_evm_a72_defconfig
@@ -46,9 +46,16 @@ CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
 CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_MAILBOX=y
 CONFIG_SPL_DM_SPI_FLASH=y
+CONFIG_SPL_PCI_ENDPOINT=y
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_RAM_DEVICE=y
+CONFIG_SPL_PCI_DFU=y
+CONFIG_SPL_PCI_DFU_SPL_LOAD_FIT_ADDRESS=0x81000000
+CONFIG_SPL_PCI_DFU_BAR_SIZE=0x400000
+CONFIG_SPL_PCI_DFU_VENDOR_ID=0x104c
+CONFIG_SPL_PCI_DFU_DEVICE_ID=0xb012
+CONFIG_SPL_PCI_DFU_BOOT_PHASE="tispl.bin"
 # CONFIG_SPL_SPI_FLASH_TINY is not set
 CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
-- 
2.34.1

