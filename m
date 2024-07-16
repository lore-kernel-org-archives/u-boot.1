Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 843BEC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 13:57:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E87B488706;
	Tue, 16 Jul 2024 15:57:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VXZmhpZ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 319658780A; Tue, 16 Jul 2024 15:57:03 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0D1488706
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 15:57:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uRi0ToTasJugiusKB7Bs57MOnuUqnAyBh9HtpfxscLFSegv/NNNWffKaVwd841Qkl379k3d0DDKCjrHSq8TvcH6poTlCc8UDhYGtlPN+Ua/tjfjMNlZXkS64lIltpjjGZPJ+VP8PE4IxvAKTqNB57kJi4iA3BK+qRwmGN/2TTEUewtf+pSORJSR+VkLM/H1z+3LmdZwOwbLwI10Nbyk0lWx8aQ2F+YnMYCBy4pu29FmepJ3fdDewSBmsVb2nALwEcqkhsr6lN2QDIE+yqO4Bl0vYV733P08BNCmmcHYP5b2aq2lhjGgVJy35oP2mdE/t9ey+x+qyPrsxY5jn4EQNBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KRBMnTCAuzHqG1hTXp6zgGV1H8G0Nsbm54+Ph3P6sx0=;
 b=eSrrtt/KNWbDtjZ0FQb/f2AP92QdO2ugkKXe3MEl/Ue0ylt6fOvAXXgsNsRcEdnFZuFW3IgMD9DR00HLvF30LYIjQhadPQt38aFKUvVfBHl5LnW+V7MkPsFPoiqcMo8rHtfLNnZzBnJBai1ue4Iv0uUqOBpdUl9ElBkgMgw1+rWOjpplbyxEUU/jan4nUUJXnwsj9vA7vZPlELKZmfdt86/G59Lbe72vk3ozMRyvW+HD2lAVBNuW9L2oCQ1hEv/Hz8fipesbrkQf6D0YYPeiQ0Oi+O3DbeoPrS8mxdbORIkNPs7u9mRkZB8VOSB0a4rJ36WEZQfdaP5fUwfNuBKn3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRBMnTCAuzHqG1hTXp6zgGV1H8G0Nsbm54+Ph3P6sx0=;
 b=VXZmhpZ9wKbm/fnUL6lu3ofYbPbHDrtmj82J6Fe9YQalmy3Gjq1P195n9UiuGBxMtMK3OMmaEO2QHXUIIcGBV10bhN65ZVG0xfvIa+1yFBXawGY+ox4lTLKcrItJbXPpSVpM62ZnASHCNadKTz0g1Xg1O6mZIuKY3GPREAWOpOY=
Received: from MW4PR04CA0254.namprd04.prod.outlook.com (2603:10b6:303:88::19)
 by DM6PR12MB4234.namprd12.prod.outlook.com (2603:10b6:5:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Tue, 16 Jul
 2024 13:56:57 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:303:88:cafe::c7) by MW4PR04CA0254.outlook.office365.com
 (2603:10b6:303:88::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14 via Frontend
 Transport; Tue, 16 Jul 2024 13:56:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Tue, 16 Jul 2024 13:56:56 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Jul
 2024 08:56:54 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: AKASHI Takahiro <akashi.tkhro@gmail.com>, Abdellatif El Khlifi
 <abdellatif.elkhlifi@arm.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Masahisa Kojima
 <kojima.masahisa@socionext.com>, Simon Glass <sjg@chromium.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] efi_loader: Fix typo in EFI_RT_VOLATILE_STORE description
Date: Tue, 16 Jul 2024 15:56:51 +0200
Message-ID: <682c714d8b39b3ef0a12ec3d824475d630b17e11.1721138209.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=886; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=y/ZW1RNVr6L9j6KIw5ycXZHp3Gf2Rr32r2ZOyJfopK4=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrRpNcovVN32s3l/Elp53D7y12mva/0flm50yTu/tNzXT
 9U6brp2RwwLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZiIgRTDjONq6pfmlHDcfLI5
 OlAqX9Jb/tBlhgUzC3ymxEQuvvzkSMvVE4e3TjYTzc8FAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|DM6PR12MB4234:EE_
X-MS-Office365-Filtering-Correlation-Id: dc5cf979-e479-4307-a207-08dca59f280c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R/DV4pSo8LgNSflYUF5m2VAQ38cmnayFa8wGZRkJlSA4MeeH6KV1YH4zGaHH?=
 =?us-ascii?Q?UHsj2Sm4D0GOQgcqCHOnw0kmK7bTS7Jc3GK2/gsW6/nrjLm3tZP7Lh5/Xbxi?=
 =?us-ascii?Q?Oap9pNYRyzobRARxaSXlx0GLxwP/AZYr3HEyzFo8zV2tIBa2BjXlzax+hZa5?=
 =?us-ascii?Q?RsLoTg1zC0hXiCL2gy2+jfxuTa56K6MboqTzWfI4bOgZ7HIbY8a3L8GzFw2A?=
 =?us-ascii?Q?NcOrAYyswx2YcvCzMjbyT9C4sYTpxz5o7P0OM95QbTn6dtg5LUPvdzSr5LpL?=
 =?us-ascii?Q?GDDInk5EFZ7LXL5MOdpYVoNyB0Z9CzxBIBZnrColGqFOC5lHU7HycLlsUYUa?=
 =?us-ascii?Q?kLRfGgtoI6psnFzJFIVTRTIjvHreNs86eGXN3TCGs0SiR2as4BHsCbhDet2C?=
 =?us-ascii?Q?5EFxAkyBmIJF6AEfRl8Ki+ngTavT1iyItNNXoXyWwPV7m7rybCLyGK7S1ZZ8?=
 =?us-ascii?Q?GfswLQ7MwoIyNshigLRan+z3itmJRM8A01nOyh5Y3v0jNPwwCPQNdl93bEay?=
 =?us-ascii?Q?nr0bGTIf8F7OckDPJQVwshq8eP1gtILmjTv5+/WFKXeVdHI2ZsXDfcO5RYIc?=
 =?us-ascii?Q?7/HwyklEXDS6dqXuez2K1YZ6qa4BapwN4oaXC59yNG5mJOjpegUb6WMDN97N?=
 =?us-ascii?Q?bnOGnGesWjqjdC8Qq082RbrR+kIjSQtXg2w+lfm+We/rz0B1OJIBxRtsUxUi?=
 =?us-ascii?Q?ZWqH2Q85hbtCKZ11t/hPumv6wg3w+ck2EAHRyJxDqqGeRGIWzT8ketu1f1FU?=
 =?us-ascii?Q?on2PvYwoe5UzlYUbaEAiYSuQVkY2rYQmqX3DpEDH16ZWHg5Z3kmbw3Rn1z77?=
 =?us-ascii?Q?lF3lsEMxtTTiYV9gPd396tnUcfKnxc03kPwg+Pj5rSDUe3WjnkRDQAZ7T+EZ?=
 =?us-ascii?Q?YioR5KABkTjzyUmt9gR9ECba/3zlYHo6UDM5Shn0ngffHkiyMnh7DthDipx7?=
 =?us-ascii?Q?onQl8qUTKl+Fr06equhBX+KNe3W6iKaroqFA5aASrI50+opPTOhE+Ur0trLM?=
 =?us-ascii?Q?NB69h7IoUEb29uuaukwvV9Qj+V0qIs/tFobRYKZPt7epSumBXpJhw70Ipk8t?=
 =?us-ascii?Q?9aQWZ6vtMoEI8HJB5P78x2BweVA4lPGqOa9lex6cmpNAPgz8AqhLwH6g2ehI?=
 =?us-ascii?Q?7WeGLhfri7GYy8ci2hwfNiR0+RMp1TMAzslmLvMSCXv9+D8saWYVK2DHRuTk?=
 =?us-ascii?Q?SXPnSXe8F3hnOTlTow9yMFno58PvG9nUwFynPlwUeBhlkbcP7hQL7weX1Daw?=
 =?us-ascii?Q?0C/ne+uNnKNSDcrCprifmzLqNRNREJRGFqTnZP1E3OpVBQQ25/UuhbdLqF+r?=
 =?us-ascii?Q?S4PhI6nXE+SriEvORgz/HnuALBznisujbL93JOXUqpMkd1/fBrDXpfKZlmLE?=
 =?us-ascii?Q?WyK52ymd4MyAEMXp7/iD8wF1PYUOWRIATmq6hlLHgkns2+NMHEM9YPtJFXGG?=
 =?us-ascii?Q?BE5WN9Xfw94reMZx+/tsrNzxeaxhIp1u?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 13:56:56.8504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5cf979-e479-4307-a207-08dca59f280c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4234
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

Fix typo in EFI_RT_VOLATILE_STORE description.

Fixes: c28d32f946f0 ("efi_loader: conditionally enable SetvariableRT")
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 lib/efi_loader/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index ee71f417147a..41bab4f1ad27 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -67,7 +67,7 @@ config EFI_RT_VOLATILE_STORE
 	depends on EFI_VARIABLE_FILE_STORE
 	help
 	  When EFI variables are stored on file we don't allow SetVariableRT,
-	  since the OS doesn't know how to write that file. At he same time
+	  since the OS doesn't know how to write that file. At the same time
 	  we copy runtime variables in DRAM and support GetVariableRT
 
 	  Enable this option to allow SetVariableRT on the RAM backend of
-- 
2.43.0

