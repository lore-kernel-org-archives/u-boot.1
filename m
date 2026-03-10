Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6174EB1064
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 15:00:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF55E8405F;
	Tue, 10 Mar 2026 15:59:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eHhj0e0L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1C9C83FED; Tue, 10 Mar 2026 15:59:58 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6539A83F53
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 15:59:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pLqGxic6Q28YPEuKJba4MR8p8fCT/r1ZzfOwlMSS/vwzIoFLQKVct3bb//NVYXZSgJyLQaGpptNo/YMWE9IgFPkKnNkOmnyksoi/umc6+uzgB27xri0Ho5qLJfTNmLX1wLh6K2zq93rzCYXkZNvBf5IQ5jS7rNX1e5/2OwEkpuXd96DJacEGuK0aVqmSk4szLDW+Z9b12FyatCr0SkcF8QhAE0MDexdM01E3bU6dUla8Tez6wi2EtGsAuM4XsBzqkwxac4o7fqumpyyzNus2XdHIoZFvkBUYyliGn/RZfjFuUiriYiaIeb+MhoDdB6v55NMKzYvb9c9vZyPYxzk2ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqd3gRnRTvN/+8Xr3hm1jUKnYlJclqRQV2kp0TFr4F4=;
 b=UM7jNCZ95ESj/6wiTHFmfA1O4nyy9Wd3HImGFCXI9NBNy3A0C0TmakXEKQPjS/JNkoWt2RtjVxFnS4Os4EFVfjh67ivWTGJtmueb9R0dHBU6EP1t4PdmJYEOPkMfsVtduT83ezSWaHoK6uJc+NmHzWBIUSjduwx4jjStxkH51VDSx4LaP9CAxoDFR9WP/2+TstplF6YourkGJZOIDxE2pCdKlOLBer5yRw6254GgQoOnv60LWOwZqMWCQRCkEDlqqsgJbOxKRwAqjeU1cyMhDMuSJxFHjh041dWhpHM98vbuuQTQ+l/ymHO0pmmWgCNL3h+3ZdQsZHvvGsTyofyiZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqd3gRnRTvN/+8Xr3hm1jUKnYlJclqRQV2kp0TFr4F4=;
 b=eHhj0e0LPcaw6sgXUfDTU/hLti1zT+qMmx4D10rw9W4ABdioiFUOPwJoaUXdGK0ZzxdtIy787+bfTjGKLDna2LXl6KDVxrZT3FsGtgh547Ry07D4CF0X0Lf1ODgw1PKvjsAoNvG6oSTNvAnlfIFfOGNN0B4pFyDZowluAC+K3Yw=
Received: from BN9PR03CA0902.namprd03.prod.outlook.com (2603:10b6:408:107::7)
 by IA1PR12MB6065.namprd12.prod.outlook.com (2603:10b6:208:3ef::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 14:59:51 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:408:107:cafe::c2) by BN9PR03CA0902.outlook.office365.com
 (2603:10b6:408:107::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 14:59:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 14:59:51 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 09:59:48 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Mar 2026 09:59:48 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>
CC: Kory Maincent <kory.maincent@bootlin.com>, Padmarao Begari
 <padmarao.begari@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH 2/2] fwu: Move boottime checks to EVT_POST_PREBOOT
Date: Tue, 10 Mar 2026 15:59:28 +0100
Message-ID: <0c82461487414cec799e8b1d69b34090f38bf66d.1773154765.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773154765.git.michal.simek@amd.com>
References: <cover.1773154765.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=789; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=Rb7q+edClt7FoCCrlvN085A87QPId8/8oh4oO12afrI=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRuMLw4pfDEvK8v3d6ti97Za/pGJ7/9k5yJ5kVG1/fT2
 LlkYzilOkpZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAiyhqMDEcFmbLuSK1seXe9
 ocQ7xybjs5FT2MGtn99qavEop/2Y8YSRYeHFfYrNX581XnlucEgrJ+L0XPHel8/Xuyf294sqK1X
 /YwAA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|IA1PR12MB6065:EE_
X-MS-Office365-Filtering-Correlation-Id: a7f2fa37-836c-4cbc-9e68-08de7eb5ae47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: uSERVXKLez6duWdfKPKF/ZSIkedkwIVT09SxNp4RHVJLYoSp2gf8EpzvLJsGOkYfjLaeDWvqEmCbBN8ULT501s6zRtDVcSfkANLVZY4d7UDvWoAPRpBSXoN02N+/mbYvGkmHcLpz6UT1kZy6m6nykVKJorVMYxy/MNGAm/FXORW0lTEIORMONBt+Ed9qdsMYvM8GBukIp0+ufP42VRYTfAhh+hsWmZb0u5mG8qF+kTNp0Z6rCLb3BTukzAdm/OhOxIJwbeh3iSO6FGgWJlOn9OTPF5H2NNSNwT1ieM0XXyFm9FZ34jWkSA76oYyMZ8Y227P071gl43N/cVkzSr1fbjwu+q02dSWUkgQ2QMbohoQADN3aRRHPDBvsbf8vgmEntcPIULs0K6QZnkv90vfCtga2lSGp1iMlM0q5+IHTIsoFMZCaNoBq68GGA3Wc//PGLQKbiHGiz2qjMm2OXZxMBr9nLmk+bopZqjp6eJJO1vCpagNoHO/hyYMccBmC8PmXwsM1fbdznLZjAgun9+/rVqoALhRdkG48JzTOoNMTrC/vV2JDUuXym+J0brn6MHMld8eitgXpNNvvTQglxLdoCelp49/EZMeGg/pKl1b5OYZfkIg12sjw92ScGFPmrpy34i4N7mfvVj6zgAUc1H1W/970tq4JGRhO45zddBBZ7aUOTaNSXHbAhlWY4Q/fADMufwjtAU5e7YEiUwxDo/n6TvQ1qTDRtRWYpD4N7F6ZzdhvI+zachzdObhtDHxL84lUjOsVfn/vFFf4xuWPWNgDlg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5lz2SnJNTsmy+jDDEJbVcg+5ygJkH2GSNOtagfW13Fp+XpAwPGSNZl4Pk6Q2fq20/VMMQU5PW286Uz+lT/bspQCKdd2Ctz4kahKMiwULUFuDzall29lEO6Tc4hlCt6+v8B8j2VPjnD0DIZy6qIYwgy1SDEtBnXwwWpla7Q6WcoYEwzjC4HU8c3k9yrb4/0VykhzJR5bLwgT8X83yV4kBc5RA5w2TS40uJb3lur7hyAGo7ZOrM4YlVc7OOTvsIQItEVQC5Am5VlResg0pFCPzr6ylf8MPN4tXITFs9Ge+GzF6ncEcB+P5rlTK74tZunEZj0rrNs+XufLH7G9GW7vuK6PELGBIDuizLzm3uEHBOGdo/Wshxo0LixNBGvkvx4xFCxBbmuWZiF2kS2VCEvIQKpXROzEYxDOm1eeKT+4MRfS/q6+gQsVkXp67y2NA1Lfp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 14:59:51.0847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f2fa37-836c-4cbc-9e68-08de7eb5ae47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6065
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

Switch fwu_boottime_checks() from EVT_MAIN_LOOP to EVT_POST_PREBOOT
because there is no reason to call FWU so early. FWU triggers EFI
stack initialization before all devices are visible which prevents
the EFI stack from scanning these devices and adding them to EFI
variables.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 lib/fwu_updates/fwu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
index 37c613014d18..e82600a29a40 100644
--- a/lib/fwu_updates/fwu.c
+++ b/lib/fwu_updates/fwu.c
@@ -796,4 +796,4 @@ static int fwu_boottime_checks(void)
 
 	return 0;
 }
-EVENT_SPY_SIMPLE(EVT_MAIN_LOOP, fwu_boottime_checks);
+EVENT_SPY_SIMPLE(EVT_POST_PREBOOT, fwu_boottime_checks);
-- 
2.43.0

