Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0321EB271F
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 15:57:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E7D283CB5;
	Wed, 11 Feb 2026 16:56:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G/cGFTwB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9077A83015; Wed, 11 Feb 2026 16:56:54 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAF2283A47
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 16:56:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GRPKkp8PVVYuYmvXnDOisGvpZ1UTP2479ZuhrXzyqMpvsNwsm4XeOz6HMiJvpeiRKxS77Lgn/vyDrXkS7xnfpMSPSrbxdBJ4pTFsSNRIdM4YYiz9iuiuiegynlmyz87iO5nobQGF5ffouhE1TzI7CiyDk9/nGGoVBj5GFmv3qFbvN0Xu/MtqiBK4Y+4eC4QrAC3jIxHYbs9+mDPoUwxIWDNUd0HiH0Gtgp9T02Yvec0tDRR9YXUEWRGsdyLqZlUjFP0ANHt7BpuZt5ECMw7Z6AIiSc4I6NVvOsytu+PBJ2tn5dd1QRyQB4Uof0Z9/8Y0U6RxpK59IJatM7I5z0SkZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJbXkM0IYCOF2/kEEBf2nuk9UYFoWTu7wnBeJQN00Ng=;
 b=Tq2XLwqls5ug0FiLaDmdHh6oq8GCZ/xrHK+m4jCJcjN//kGt2i0l/ZzA8dV0NdM+xS5TND3w07Su9qIc1tgOC995ipAIcmMFdN60sgEx3EG7m5NUdnk3JjP/aIU/quWYVaxkC58t+i/r3LJ/1/OJ4/hvMQiVFqJxr/1r+TCwqZLlFdRXv4n0YnQjAY38S3G+TWzJSROiE4vhcMsUer3g17BxigSvoHgBF4sTd3H+C4oeDnV8SUnZMHhUXH8m0hNXt/3lFUXGF5euCy1uWO1WIKlMycyAcbXAnzKWapwTrgJbMZftASbhcLbv7j5u9+rj7Gg3Q12MfbvaUwJI3JZgsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJbXkM0IYCOF2/kEEBf2nuk9UYFoWTu7wnBeJQN00Ng=;
 b=G/cGFTwBntdX7C8NSw60BYJCg10U+wFWYJ2dEnhMUpdqZYUjsbjL0iOUGq2a6ZT41TWSpk45g9CtTIt9fn27x5nDZ2iSb4H37u06A8lF+rdU4jw/llnYkHKyhhDFMmN6j84Dtsh3H/7nAzxxuGMMjIvSLTnzkTRD65CnEjfzFEo=
Received: from PH8P222CA0027.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::28)
 by CH1PR12MB9621.namprd12.prod.outlook.com (2603:10b6:610:2b2::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 15:56:47 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:510:2d7:cafe::c2) by PH8P222CA0027.outlook.office365.com
 (2603:10b6:510:2d7::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.10 via Frontend Transport; Wed,
 11 Feb 2026 15:56:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 15:56:46 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Feb
 2026 09:56:45 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Feb
 2026 09:56:44 -0600
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 11 Feb 2026 09:56:44 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jan Kiszka
 <jan.kiszka@siemens.com>, Jonathan Humphreys <j-humphreys@ti.com>, "Shantur
 Rathore" <i@shantur.com>, Simon Glass <sjg@chromium.org>, "Ying-Chun Liu
 (PaulLiu)" <paul.liu@linaro.org>
Subject: [PATCH v8 3/4] efi_loader: Setup default location for UEFI Variables
 storing
Date: Wed, 11 Feb 2026 16:56:22 +0100
Message-ID: <da151d1eaab4ba5aaf37c11ec1ae5ac3f1abb98d.1770825377.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770825377.git.michal.simek@amd.com>
References: <cover.1770825377.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1038; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=1Ma0ek5bOYG1+2nXadjJq3mlDh0kCPT2Ka3d0xoE9wg=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWT2LFu/5XDhxsMVjA0X/bX3yEy3FfjgYBhVNUvTymexJ
 MuaWy80O0pZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAir1wYGWavWP3LWlHFUGZV
 /ERzixk396sKlNc/L38ZysKmv8KWhYGRYduPxQkzMu0b85ZtUTUN3dRqEyPWV//2xNcX+5c95Oh
 7xQgA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|CH1PR12MB9621:EE_
X-MS-Office365-Filtering-Correlation-Id: c9ceab23-a778-4a8b-8c96-08de698628b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SWHFmdZny7WTSYcO5uvoXiGogVF6Dp0ZuIgkZaaW2Ulpwq2mkh5LGMa5weJ5?=
 =?us-ascii?Q?LXXYe4KDVSvpZUE2aOrnXQoYyeVtprzY7lC7CQ4pji5SicG6dHXZXh25Ybau?=
 =?us-ascii?Q?OjQ0zezob6gvD7vhjsd3YrBw/nZnVxILZrJcnp7J8EkkzHjK+OO97y8aZpRo?=
 =?us-ascii?Q?AjKfajZLg/1L6srJ4LrNW1+54e73e5txOSJ74um1Dpf0RQ3X6KMlJq95msIe?=
 =?us-ascii?Q?YybTWxVzGMoblp7X2h5FlUIifXwcrMBi0X5ZAPlgjyOKY6vDl6nP9ZWFD78s?=
 =?us-ascii?Q?bI4DqyLkfPG4uLCscC+NhqmjqXt5VwHbEVGir5Cgi4eSMQ68sBNyKz0+kNq/?=
 =?us-ascii?Q?zXetxGuD05BxrasChfDLDhG1eApS5rjStnhSH6UfBEraay2V0S0xJtVu+dwo?=
 =?us-ascii?Q?Dl1upt5zPIyHrxR2tkxJIpUcnQbJHYatwyh1W7vhjPc6+biKEsHHmV/C3zba?=
 =?us-ascii?Q?ycyetY4yF2cRckw+iflN5RykrOU3uLR3BDbISFwgbNkphn5PNXqnZgjBE8XJ?=
 =?us-ascii?Q?/DpZ7ndjqxp+0wqRzDfrva7XMBVwAWLPgQD2rbJTfaYQUmxS4h1AHsXUs3SF?=
 =?us-ascii?Q?uIJIRnb+5SSLdxVJjbgC69gTDrb7kvjnoOkFXl461HdkXoLCzRz1JbWgzYQM?=
 =?us-ascii?Q?rPXIKVtwugJDQ+Ju3a/xRJTCrxB3PZIhC2TwHVA0No+Wa5qfhO2DN0TqCdUo?=
 =?us-ascii?Q?voyPNUuwnv3phl3E9AtQl4Ka8+7Ba4utHCUw1hNf12OyvlNVsJZ4YfM1PB3U?=
 =?us-ascii?Q?qHfYI+lqROWZbrijUVplH+LJwl5fBNPp5qRYlMRHlafUTxaQJYtp4K3+sHnm?=
 =?us-ascii?Q?niKblLbzR7brLEdjS0mTrFMFKyBJVpqUMSihV1Asv3TRJbgl8y112A4snLLV?=
 =?us-ascii?Q?Y1Z/3nMpCVkWukwuk5MMpI1lfAOAu0BXsVy69W0kDfQcj2SGZmqE7jCBYuxs?=
 =?us-ascii?Q?fNNFVqE35cnOBTWAbDOhtql9+a1KIn9AWZvaI0m5N/HjmMU+NtM2XmZl4HeK?=
 =?us-ascii?Q?S5KCdOgKyUH1crJwWGNI+nzdC1caQToruiW/mTHHgqayBcEktEsrGko27lge?=
 =?us-ascii?Q?FOMSigugFMo0d3Mdk6WCeiDLFZfUD8yg/0UK7v7olWEDpnWHyl+thKmbeTli?=
 =?us-ascii?Q?QjuUg5+EKRQ0pSFa6LjkN1d/Tndgu4NsajQBesuVyRhKeX8TbsW8BbwuXr9e?=
 =?us-ascii?Q?uhRiFtbV4w4ETpJ59PIiiHWm1q9PvF9IuGrWWon+ESWtySmm2/muloskd4/x?=
 =?us-ascii?Q?1toi6M+0hIbTimUf9+SLRqrJVvbukL1Mp5zlQBrAS2G7JdRvpkJkYmtMtGHb?=
 =?us-ascii?Q?U1kcuLUpnfYyS4ZWDBygKJiRdFvejDpTvUy0FyosSqUt12qzqW888aE11o1e?=
 =?us-ascii?Q?OFOKRDRgu4rtFUvblDwbDuxVqnr8IPYyhkuUGAdvqEp73O/VTDhLlXT/eYHa?=
 =?us-ascii?Q?Hcg6zx6R/XFut1z7rZBMY0pKkow/8VRQm+MjszYhuVqO9foVlcrztZ446LXr?=
 =?us-ascii?Q?WfvDCjTDs+kSG2x9MFn2tGzoggQfH6ShE9kl/h/bnBoooxqBglY6d/oA4R0d?=
 =?us-ascii?Q?Zuu8rjRgRqJMpV7FvibkmrWTKPVEvLOigw1IZeNkmlNYOtr1bHNs+5/XLKRF?=
 =?us-ascii?Q?RNiX0/EnosesViPyPkaa4GhLrElf0ohgilzmwOFCi4vgxihS17noR3hSo9ts?=
 =?us-ascii?Q?1HgqlQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rVh8Eykejlo5TprnqmcObn8BefaKVn/MB9irHgbnprfAY0WxQ4IuwHD7C7rebgBOmk1ZHUBfFSpQht66CcDbwDzlUiHBqCgcxMJGb3BmVqprMpuyK37Ny6UC490ZtbJsuOOpg32fsPRGD0zEL2zF0m3+v7t4SafHgP0zTuSTfrAMWDzs0UiZqtT78doN755FUhKKgPXHDTp5J131+7TwjeTuSvheSnw/xTNgFgtqhiWYjt8QqOux0f7CfASNpv2m8QHHxRQA1bmKZOILmL8xN1tVph6uXZ3n0DoD3RRSZaJmpb/UtrD5tYhCNQCD/waVKvo0br+hl8aed+3S8TefzfJr5C/BDYfDW+iS6mccD70fI97OUEZx217aza5kFVeAPKdLxvIQLdT+eMwq/z5ov042RxNji/N/q6QORDKKyKM7nRxi4+Xj/G5tEVhlJvhn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 15:56:46.2301 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ceab23-a778-4a8b-8c96-08de698628b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9621
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

EFI_VARIABLE_FILE_STORE is only available when FAT_WRITE is enabled but
that's not valid for all platforms and dependency should be covered.

Also Kconfig behavior is that if default option is not valid then Kconfig
selects the first presented valid option instead hence it is better to
record EFI_VARIABLE_NO_STORE as safe default option.

Suggested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v8:
- new patch

 lib/efi_loader/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 13e44be1d067..579eed658801 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -112,7 +112,8 @@ menu "UEFI Variables"
 
 choice
 	prompt "Store for non-volatile UEFI variables"
-	default EFI_VARIABLE_FILE_STORE
+	default EFI_VARIABLE_FILE_STORE if FAT_WRITE
+	default EFI_VARIABLE_NO_STORE
 	help
 	  Select where non-volatile UEFI variables shall be stored.
 
-- 
2.43.0

