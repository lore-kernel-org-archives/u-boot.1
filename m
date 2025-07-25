Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D06C87FCE
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 12:02:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBDB783959;
	Fri, 25 Jul 2025 14:02:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3K+sPlqA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B971F83965; Fri, 25 Jul 2025 14:02:47 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::627])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B96F83959
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 14:02:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izGaZtYSw0aLqFY2C1UMvqQ4KOix5gzHPpfgRx1EBJYSl7+zK1sx9/Mgu9aMItarZ49xC0ENKJHhXKWQiQHgLV36lQQg+e1lVgqBwT+yjN//MjTme2mcMZ8HIYIMcDELrzmFWM1vusUjTe6kSQosZHpZ7RThvTiECaJ/UULDu5HazAE9oyLFlGFI6ZsnnyZrIlo+Dzur4d/euI5ny1F3L1NUGeH96fp3Bjm6zSBMJ2b9uDDHX231yCEW18akUkkud80Y8MKeNiaOuvQOaBJMb6SBgpeTf9fUC7FtxU10gDeo+7lktxDOXH7SCvOIKvz7hizbDCkRx4RgsDqQz4Cu8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBTEb7nNSG92QH6qDpsP9710FXTWE6EnTVHW4yYyNjU=;
 b=TpGehyXaDoT8GDJxiAQeCa2mlP0/OnYm6EwvnMV9UeoJPAcspPung4UiEVGlU3rlmJKx07HvJzcB0g7WkDep68khM7DO5Oygsb8YxBPsQdFEZyKj/XSQDLFmse0MFzVcBBRarVlwdvuZrbOUIX/4XGw6ZzzOwHoL2F8q7uurBSvmP/1BDw3089fpItqS6x8MxchvpS4qMSUBQ+KbWKt4907z8MeNwfHrZQ79Go1WTPH8DstZuxEdJXY3pzFkcljb2d3ncjjNubXgyvMGkzoIz7Mwx7NMKALuLMdWABlw/huvLJptNBSYe/zD5lDgqdZiJ47CWJF24xXf2kzD0rwY+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBTEb7nNSG92QH6qDpsP9710FXTWE6EnTVHW4yYyNjU=;
 b=3K+sPlqAzWw2DlxV1zfkbF+vj5nUN5BcM/OSjq/rhdhXUeeu1n4j1VMJtSaNck0Z3JpOL5maT6ncTD1xQs749vVqqMkCqKwbWv7YB9vJu8kilz/ffAHKQ/osyL7dDN0SugMy+iZJfZ8Cj3FY9BtzWo2RyiLGpfliiVNdQaI9f3M=
Received: from DS7P220CA0036.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:223::24) by
 SA3PR12MB8764.namprd12.prod.outlook.com (2603:10b6:806:317::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 25 Jul
 2025 12:02:40 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:8:223:cafe::45) by DS7P220CA0036.outlook.office365.com
 (2603:10b6:8:223::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.30 via Frontend Transport; Fri,
 25 Jul 2025 12:02:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 12:02:39 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 07:01:32 -0500
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 25 Jul 2025 07:01:31 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Casey Connolly <casey.connolly@linaro.org>, Janne Grunau <j@jannau.net>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] dm: core: Mark root_info as const
Date: Fri, 25 Jul 2025 14:01:22 +0200
Message-ID: <18d92a93a9863ed0452e82a1f8e0ff9205adb4f9.1753444878.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <92eb9e90189d8b96246966633478662076da7185.1753444878.git.michal.simek@amd.com>
References: <92eb9e90189d8b96246966633478662076da7185.1753444878.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=695; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=1EsiQySmJ9Pwyv9s5gjiizUxBsu3xH9e+SxTAleJdM4=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQ0FwnvO3XlQUpm3r56ri7FXMf/2R/nsc0+235R3eLT8
 yw3Aee+jlIWBjEOBlkxRZbpTDoOa75dWyq2PDIfZg4rE8gQBi5OAZhISj8jw7y7P2q1K7z5kgM6
 j/Gfeuxi9u5P43kVN0lpVaGOC2xPGhn+e6xe+8wuRs8+91XWLI2eGSV7TcKVuFLSRF6G+jZcsXL
 nBQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|SA3PR12MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a6aba27-2109-48ff-f357-08ddcb732778
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?whaWmvgQK3O9FolFjKy4ec8o5L0Zl1yUm/cAMY/gEuzUpUCQWQ6nI6AlVcTc?=
 =?us-ascii?Q?YtHJ2UfDrIVOXV8gea4D2CBLxpwvFo5S39F9ZjhneRHYvGjQHOyRR/FQA6uv?=
 =?us-ascii?Q?OoOnsE6LvN9BciBh4mqkC/WTaJsvuv1pUWwox9wR13kJiJ1Od5J32qeZ8hc2?=
 =?us-ascii?Q?m6ZqrNQWoYvCUVTOtWrAen6kCxfDf4KCtjV211xiq/6lvCEUirJp/tqFrBnm?=
 =?us-ascii?Q?fHHuFDHUDbF1SfStQWMTU9GML0zjx0wclPo1N3eQ0Pd4YInAFxiC5CVBdXPU?=
 =?us-ascii?Q?xxK2UQ2luzQkU0eKgspRtpRSdqL7utuvLUaEtnhyeMLmIUDDOlobvQ2RDaj0?=
 =?us-ascii?Q?kde0JhI3O94sKrf1S0/JtprkihRYv20vKMg+6BVqMl6fQZz3KORq5Is0y7IT?=
 =?us-ascii?Q?ZjPOtLj8l7jfme3hsPrRbb89vc3qLS38dLPr+NIJ8wB1Uky0ZDRg/AS/w4nR?=
 =?us-ascii?Q?ngD5SXR68SKYWBBmoVxCy9MyHMbIf9SGqj4fsIZkrto7f47janF++Jepz7gg?=
 =?us-ascii?Q?lDQrbd6qpEuijJJRW8bVvrQT7xIIOvzqO6rTR4NKrTxOTBONn+eZqHko2VpM?=
 =?us-ascii?Q?8G3i5DRdThc2xQ/F9BoW5sKod3IyG8NQK+eYhJNKwiWQHIg1UNQqSvF+o3D8?=
 =?us-ascii?Q?tPMBMH7pFQrZS7zil/aJdQafL8hxD1piQEDiGPeJcypKPdsPsaUbad8IkD3M?=
 =?us-ascii?Q?+WBShrj4TvnrBMlgdR3RbE/+dniJxcpIXYdqdaV3XbwBBTybMaevMcVrVMQ8?=
 =?us-ascii?Q?s334JLfC2QOiQR+6gqEoMA+scxViSeKcO1YZI152NKRnWfOWT/f8JbbcY3xb?=
 =?us-ascii?Q?Ai9RomGK3625P/f34XT3g89orVCYzvJWORdQcyZTgeNMqgnJS11dVBbbcp5Q?=
 =?us-ascii?Q?nsSCDWt21Y8WLtQjuX7A5qHXx1wtbcUJcAA38iYm/dqRXTGtXjLtCKIK1XQp?=
 =?us-ascii?Q?Nf+y0vsGEB1NUVMm2vy6ehn3cOq2X3qZ8dzkE9pYW/TMUpEYawBf35TWSmoT?=
 =?us-ascii?Q?bzZ4/bNyiMfP7D5irHZVngC3T05iJ/Vd6VG+l6zCryVoxgdB77C3pREm6DHj?=
 =?us-ascii?Q?eTX/eS2i0Cveb+hmYEH/dZ0DQ1RXTBpcg92Hb6shJKobAdapWxFt+cX+G31G?=
 =?us-ascii?Q?qZrBmzdTTJr6DS9g8z+o6S8YU7EJpAaCl+GKkzjiYWjQ7TdPucgAKtuIrkFk?=
 =?us-ascii?Q?MwDbBsO5pbZeDltU+sfOZBbAWEutxhOzSLGEMwDcdagdBzAUImVoYmJthVub?=
 =?us-ascii?Q?cMSTb4Vr2zrMzYi+QESvLUCWLnH1yvLaDsEQ9IT6pWSNE9CVSBbCsybsTXBm?=
 =?us-ascii?Q?iVkwvA5nH2aHeo+XJ4+bZlnQPaotuLMXj9VPMuVDn/o0sgtbnr02DhF4EYYr?=
 =?us-ascii?Q?Te3UanHAwPbEHdZOBv+mL4zdRbUxhXPzS5iFyqUkPnQDqZLqvaRbJ1krDRz/?=
 =?us-ascii?Q?/sqLtiEoMeMfwKHrlmmJqY8CPvFovF+nzpx4c/zuisQo0/caBlmAPBZXKIVN?=
 =?us-ascii?Q?7vo8NiacwvZeHBhNaXXvSPdjUv0vZHsbfb+X?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 12:02:39.9591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6aba27-2109-48ff-f357-08ddcb732778
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8764
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

root_info driver structure is not changing that's why mark them as const
which ensure that structure will be moved from .data section to .rodata
section.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/core/root.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/core/root.c b/drivers/core/root.c
index e53381e3b32a..d43645f34ddb 100644
--- a/drivers/core/root.c
+++ b/drivers/core/root.c
@@ -32,7 +32,7 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-static struct driver_info root_info = {
+static const struct driver_info root_info = {
 	.name		= "root_driver",
 };
 
-- 
2.43.0

base-commit: 7178360d325a7ea5356b993a7f4156e4e1e80719
