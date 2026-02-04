Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79FE6E9536D
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 10:21:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14E4A83B9D;
	Wed,  4 Feb 2026 11:21:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="cZBo4kdt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 815BE83B5E; Wed,  4 Feb 2026 11:21:00 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBBE383A24
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 11:20:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIZ4XgEtvZCQWYs8tRZ6b4CoNi2i71vEcgwZTptBGevbtTQC3D5J6+Fou44LuJFwbC/mGHkx/2bTCDvDGAXKXI7EBL0tiSA29UBSitWXtAv1hqjhLa0ILyZpvcoMmou/bwJo9vqGV+84smQN4O33otjLg4dQxWS1pvemkQGt86SnA90rMDSj4zGk7gFtXc+cEND58FEQ1wSfSctk5RCPe4+NCvC/4G2ETUsuMl89slI0NJ5W2tFiDaGKpMm9gPwlhIZF5RGZaItK03qw0a6ypVyJm92ZGTgTnVa3feAYF/rnaN3rUkfuqw50uPBMjpM/QZgIJvnM9e4nvVFSZTxP1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llIX5AJ/5kdZW8LVdreCnWOedRCOEO/edAuBOaq4wx0=;
 b=A0clVUo1vwQ4hTQOMbmZ4rGnNcRTsfM2iefaH815Aif0epHFcb0UeMYtaF9YtUtpgZFv/RHJND07+5bv5Rv2F4WC7LzyDiVQit+Go1UohmJF9OYSGmplmhFmKZKfXTFQIjScOIEiDz9MsfsCJue5IXhVlKM7cll7BqBbrHq0274ZJZbwXDexygXIBI/DiNNFoaiOdWdq8MkQ3BFLduwRQ5R2alLK1F4hFAyhUeJ5ywr8jXwjmAt8THDWr97sIyuPnI8BByE5OiEWERXLmrbSH5Zz/zDhIDbFSMkt6+/HunoTKx81bQ2Uva14b5m0l7QUo3aYDMQcCMZ/UOWS/wcQQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llIX5AJ/5kdZW8LVdreCnWOedRCOEO/edAuBOaq4wx0=;
 b=cZBo4kdt9PvGhZnWULUU5IwILokiDOn/1y4sfqLtnAoqOf2euCbGJ7nmSCdtLveAosEeLUPWLQY1+CssYdCcwPgUxE5pn6hXZPiP/VkoTccCfLVv52WK9+qQPIuX56BcuZaLMixX8OCGbD0ULNOSpSouU7+ThSTW86CahtvuGFhZ3Ou32Y3UmAhxyHGDQQjNNwvZabF9ZUgLbMQmhXwZVfV4GtcchsNUESsZR3tmKvfu4MdymRQChpRtNRkB9yFERu2XWL3LGnTkFGULBFVmECq0u0hwPNUKnWeP0hqoXRu/DIvH/JK+VkIG6CNP8zkvyV1RIuG2neDEpdoHRggjHA==
Received: from DB3PR08CA0009.eurprd08.prod.outlook.com (2603:10a6:8::22) by
 DU0PR10MB7924.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:314::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.13; Wed, 4 Feb 2026 10:20:53 +0000
Received: from DB3PEPF0000885E.eurprd02.prod.outlook.com
 (2603:10a6:8:0:cafe::19) by DB3PR08CA0009.outlook.office365.com
 (2603:10a6:8::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Wed,
 4 Feb 2026 10:20:53 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB3PEPF0000885E.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 10:20:53 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 4 Feb
 2026 11:22:39 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 4 Feb
 2026 11:20:52 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Wed, 4 Feb 2026 11:20:51 +0100
Subject: [PATCH 6/6] configs: stm32mp25: Enable CMD_STM32KEY
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260204-upstream_update_stm32_cmdkey-c-v1-6-d95374395840@foss.st.com>
References: <20260204-upstream_update_stm32_cmdkey-c-v1-0-d95374395840@foss.st.com>
In-Reply-To: <20260204-upstream_update_stm32_cmdkey-c-v1-0-d95374395840@foss.st.com>
To: <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Thomas Bourgoin
 <thomas.bourgoin@foss.st.com>, Gwenael Treuveur
 <gwenael.treuveur@foss.st.com>, Lionel Debieve <lionel.debieve@foss.st.com>,
 Yann Gautier <yann.gautier@foss.st.com>, Nicolas Le Bayon
 <nicolas.le.bayon@st.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Yannick Fertre
 <yannick.fertre@foss.st.com>, Cheick Traore <cheick.traore@foss.st.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.3
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885E:EE_|DU0PR10MB7924:EE_
X-MS-Office365-Filtering-Correlation-Id: f23cfd88-69fd-473f-c74b-08de63d71411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TTZkZkFBNVY0bll6QU1XV09HZEpaVThXalBFU2RoZ2NZOUxBOElWckJVRTgy?=
 =?utf-8?B?Vm1NQ0QwZzZFYVpPeEJoTC82MmhjRzJRWUszNHBueWpoNlNQazNYYzYzL1ZX?=
 =?utf-8?B?OXlxRXRpMm9jZ2h3bUNDUG96OXFMK3YwWjE3ZGFXMHBjMFg5dWRiTS9WUWs0?=
 =?utf-8?B?VDEvOTIvV2psQmxHUU1Iay9EdUhINW85d0JDREZ3VGtKZm1nUDV6blhJL3p0?=
 =?utf-8?B?VVFzbHBIaTBBL1FxMmtnTktoMU0vMUN0NWlBMFU3dTI2ZmJLNkF0cmdnZ1Zm?=
 =?utf-8?B?c2luY0t6V0FWdUdOcTRlQkZvL3U0aVdtYUg5bFo5R0tOTU9TemI2WFdKcFNh?=
 =?utf-8?B?b0xMTk0yU2I4bFFVLzJVN3hWNUkzRzc3L3NmU0hBL0RKMEsxalV3TTlLUGFT?=
 =?utf-8?B?QjdmMkNtVGJUMzdnTnhQMWp2Q2tPajlkRUdIYllEZHl0TXpYVC9BTTd3QkJr?=
 =?utf-8?B?UFhwNGVuTVlCN09zS1VzaUs2elZTSUtteXhYUDI0dmVYSVVFR0RCcE9HQTFi?=
 =?utf-8?B?QTdzeDZZLzFpd3BRVy9rMFVzZ0ZjbjFDSS9DTHJRZUhsZ29tMjljd2UwMUlt?=
 =?utf-8?B?dWhxODlVMzRpSEtHb3dEb1VneXFlTSs1Z3FpY0VrWWRsYUVyQW1ub3Z5ZkZO?=
 =?utf-8?B?dnpuaWpSL01MajJtVEU3cisvYUsxdzc0djhJOVVRSHV4bldMQ3dzRGhaRzYx?=
 =?utf-8?B?Z05qQlBFSUZseks3amo0bVZacmVsMkFyUlI0R0pWOFByRERGQmRnMmxtalRw?=
 =?utf-8?B?WDdhWlBQT0NicUN6bk9BSzNoTWczOEFRZXFpak9sUVowTTQ2bHhIdmRBOHZl?=
 =?utf-8?B?WlN2VndXNklCeXpWQ0pCMVdOMEpTbE43OG9WcHlZQUYzMFEvOEFZZ2tGZnJ2?=
 =?utf-8?B?aEtha29PeFc5V3RVbmQyR0dnb3ZIM0poQSt6ZDY5SXFObjNjUC9CZEVhaDhT?=
 =?utf-8?B?bFhYZ1JCc0FsRkZSclB1dWZVcG9MYVhIOFZSWERDZUt0ZEdnd2dsaU91U1dL?=
 =?utf-8?B?NjUwNWo1RU0wUFA3YmE4M202a3owM1dxeUk1L0w1QkNpMFNnc2tJb0pvaThk?=
 =?utf-8?B?V216eDBMeWVLN2NvVGd0ZWgyV002dXpJUFlnWlc0eVkxU3gxdUhsOGtMYUdt?=
 =?utf-8?B?T2pXYit3ZUlyWmhuR09lZStYUU9HdGIraGdQOC92Qnc5cGk4Nzd4dDBMU3NQ?=
 =?utf-8?B?S3hTK1I4Wm9zWHpOeUJ5OEtKL2sxN2J4YTNGRWh3VWxNVjJBVzJhSGp4UVBX?=
 =?utf-8?B?MHcyaUV3TWlXaE5wd0pLYXBaUFdpM04xZjlJQXVGT1BBWTRpRi84dkJ6TERP?=
 =?utf-8?B?S0cydjJDU0dJWDgrVUFDWUN0dWFxYTluT3UrdHA4N0lPY0dsMFZFSUxnVnJE?=
 =?utf-8?B?TU02THFtR1lacGpQSFN0WVpsbUdhaW0vYmJKaEQySENZbVVpV29yb2kvUGMx?=
 =?utf-8?B?ZUNFR2o4c2ZUVG1mOGZmRkN3OTlnYld4K0VsOXBoSWJVMnF2b3lDMUlWRU92?=
 =?utf-8?B?SU5BQVJTZ2xuanBHM2ZuMm9pRXV6Y2QrZjhoUDkvM2dBRUZQMzdTaE4xRFZG?=
 =?utf-8?B?TWZRZVpNakNUa1pNQlZNWUhnYUY2ZHMxclRzUUNOTVhrM2VhKzJRd3RheXNL?=
 =?utf-8?B?QzNsQkVSRTludFdjZ2hhOGoxZEU5N1pYb2ZpaS92eXJ3b3BHSFlVVjZuQmsw?=
 =?utf-8?B?ek5JZ1U1WXNvbFM5TW54SzRkQnZoc21vWWltMWdocnN3aFRmUE1Ha3Y4Unhw?=
 =?utf-8?B?Sk04L2ZaQllhaXdVeWxLRDdWYzdDS0d1cDgwZXBnVmxCWEc4eU96ZkZ0Z3JO?=
 =?utf-8?B?ZjJpbkFhWUlQREhqaHJTODkvYVpickdBQmtTek5zMXQrZ0h0VjFCeEN4OElK?=
 =?utf-8?B?alRIN3Y1QmJGSGFlV3VMV0tFZzdYNUVPQTU4N2ZGQlFIWmNXUzlVdkltc0tu?=
 =?utf-8?B?ZEoyWVFKRWRJT3NTWnVFbkFFTHVmMHlVS08rY3hlRGlNSmJZS215WlpjZ2xE?=
 =?utf-8?B?dVB3ZEp0cXZsNFdjMG1sWDlxYWYxNzJzUWZsbW52b3NVbW5aQUF2Z0tJOWUv?=
 =?utf-8?B?eXZVKzlQVEpicFpyZkVzUjBlUGdCaEszc2d0ZWlRVkhVaUZuWnJSN2tKcmVF?=
 =?utf-8?B?bnJTbUZ4aW42MGVwZmNkTGpsWEJIRGhUZ01FbWxvbXNnRkdlUFBhWXRUMzlN?=
 =?utf-8?B?L2gxM2FxeGZlejNVV2N5UExHY2hVaUFxWCtmcUF3UWlhcUl0a1N1Z3hINWRM?=
 =?utf-8?B?M3pkQUduVkZsR2VjYzZFbm5tNkVnPT0=?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 13EATSf16XZCGT1quT+DH4orHF2jzAXe6Pfg44BQ/iPnY1yELJupT/WZ6WqrGBBJeH9lm4x/w7ytAnw336shM3CDkNNL/E1xO2oeVLhTltzKpE/HcxZfMrybZKIF8EETb/ozJh+BFgfwJf9sl8i1JnDJDaRTfDvQoeDf0KDjRLcihwKpb9Fb2s33ughO6gg/nEXFxfGKIVk2clh8FhSUGJfrwb6w7pRgrV55qUAFpbceAMQpKwsyJtYTHoPXa11IOFuGnk6kEYadY3bloLt7+XopanjaJDoW7P2Pnf9NXcapAi9s1fn35AGdN2zqNkJhpq7RHZvndVe6C4rCZCG+eGvnbiCTXyg5mYqm6tBGkd7NPl3t/gShBHcTrMYmjChIEz8TR5tNCePhnsOvdywFeLaznHYMMROdy3syOFc5Pbmof8uf2WeTLrnxq6f8p6/b
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 10:20:53.7886 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f23cfd88-69fd-473f-c74b-08de63d71411
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF0000885E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7924
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

Enable CONFIG_CMD_STM32KEY flag to enable usage of command
stm32key.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 configs/stm32mp25_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/stm32mp25_defconfig b/configs/stm32mp25_defconfig
index 234a6a8abdc..99b22a68fda 100644
--- a/configs/stm32mp25_defconfig
+++ b/configs/stm32mp25_defconfig
@@ -9,6 +9,7 @@ CONFIG_SYS_BOOTM_LEN=0x2000000
 CONFIG_SYS_LOAD_ADDR=0x84000000
 CONFIG_STM32MP25X=y
 CONFIG_DDR_CACHEABLE_SIZE=0x10000000
+CONFIG_CMD_STM32KEY=y
 CONFIG_MFD_STM32_TIMERS=y
 CONFIG_ENV_OFFSET_REDUND=0x940000
 CONFIG_TARGET_ST_STM32MP25X=y

-- 
2.43.0

