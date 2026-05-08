Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FEE0CD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 22:29:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43C7284CC3;
	Sat,  9 May 2026 00:29:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pCvviWUf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 163B684D1B; Sat,  9 May 2026 00:29:27 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E413684CC0
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 00:29:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQ38EFoNFlM4bKkwrCCN0eB/158gQRtGQFLe7057VZqpdRvUD2+NNoB/nwthh9BFeHJO53x3qNexbissiNqH4ITLkXq0VYh2Ojln52L5SHpOeLyVOfIO+68iZvLL6iSXbZ5MVPaVXpPv2g8B2x5qioZbn8z9q1qLwJBr3N9CvafEZFF57RSOyy85k4BmdIW6D4yGzkjiSQH07bhabcDxZmzTBkBYpLXSJ4o/PDvv8oBqefXHpllF9uaQvSoN/+ezI1yE+OmSOhE/MrsupzHsScbbP45PsT43av8Q7JlC+Uxo5MM3NparFjB7kxlCRK3aPRci7dckg6pwOWjSOXuTyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28eIjkNb/A5NNWZGXx5pivh0ksn7ru05d1zVayR3vgE=;
 b=pLmb5VttiYWCa9KqHn+R11v2mDz6Ka6gEAFfodtyiC+bO1ViwDEDsEYKpDDKTBYUdkyLpCfaCquJ3gSuuqca6ZeUbo2kkeC5WxaMGLPcIwbXG/pRldFPYp4GIFjkNYDpVWvtjwmkYuVTlknehLbCerf7Xj9nLA924IxTH93vyukXgWMlmkAo1VhmrBf8zVvJ3xepNyz0BuRlfy2btzzjQTXnFNcmUAO5hyNwZ4tWcut0KbAd7o1qWYiYYb6v0jcFYL802mMdzXie81DumN5Af1EFUMEchCLKzjjPOfD6OZq4c5Tp9Wip16GWCkojN+m1axKNKvMjZceNr4YK5Fczow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28eIjkNb/A5NNWZGXx5pivh0ksn7ru05d1zVayR3vgE=;
 b=pCvviWUfVPZKFargd30KjicGGBDBYyYPgCAOyTGgjcHk3QJprwuRrwTxcFlyMa2neeTWmc0FqOUjNV4nsUIp4tMiN2hkU8mXWlp/6Jn28LZdjf4lHmm3RqviuDHqOiw5wOCL0FXIPSQMxf3OpDMDzlqFuqzcbFSR7dpMmEZbNzc=
Received: from CH5PR02CA0016.namprd02.prod.outlook.com (2603:10b6:610:1ed::13)
 by SA1PR10MB5759.namprd10.prod.outlook.com (2603:10b6:806:23d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 22:29:22 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::d4) by CH5PR02CA0016.outlook.office365.com
 (2603:10b6:610:1ed::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.20 via Frontend Transport; Fri,
 8 May 2026 22:29:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 22:29:21 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 8 May
 2026 17:29:20 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 8 May
 2026 17:29:20 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 8 May 2026 17:29:20 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 648MTKZ22507774;
 Fri, 8 May 2026 17:29:20 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv6 1/3] sandbox: add board_get_usable_ram_top
Date: Fri, 8 May 2026 17:29:09 -0500
Message-ID: <20260508222911.450165-2-rs@ti.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508222911.450165-1-rs@ti.com>
References: <20260508222911.450165-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|SA1PR10MB5759:EE_
X-MS-Office365-Filtering-Correlation-Id: 333a7e74-ac3b-4744-3473-08dead514096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: gX4+87lXDwoHubkEUbrtOfZXISVEtRysA5mNj2NdFHodjKFOF/qwpsTYZiBYyA/LeKxaurGogxuKifBsk/B0VMwBkntD9hj7qZ7MXS73xyLVcvpkOcD6ylUUaMUgl3012SHbyCZeXnN+JvbeGVjQQhaXgMnWMdkSxeTeY931bOsV+5tohHrWjpOX3qY3Jr2HKUyAGeeLG+SqPpbM/aWVnC57CdvQ7f2qyZdcqGpvX4KUI7OX5FwgS75HeRCphSQqzJOwgqY39k3gXwVjR4si9YSPkeg0Y3oguzOvdvT3GP05biy6a9OxzswS6qLDVby/s6a8LxO/1E+RFU4mwJ+ihuftOXNcYcAD/T2u9jRmxxjEAJMRA1Y4e+7a0NJsNdzOmT1SiMoeERuI1R4VUuNL59yDqZ5T7b5mrIZdMBaibb2kpZFqdlMxnolZ2ddA8dR21Fy3Ts0RNXVsLf6f+vIg1uXtLTc9pf1vEQSDeRAmIYNGL2L9VvPorExMv7vOVEBAr11auxAlE4scr2ZLkxSusxFzSjeUZ1rf9czn/LMFUeh4TVTJQyzzLL2QhgbuxeYDoM/5bZ/msF2/ISeQeA8ItCsfICNUq1O0+RlHviFnW69UD6yeD5ZFOXoZYTv1lujXuFEr2fWslfJZH5fr9fDQrfHfbQgrrw51ivisKM7J+EjFggSlEC/hxAR+RZfgb5Dk91kXT5VWiuQ4oE6/cpZw6hwPwL5mVGIyKIVclCOITQ3uzwWkHTpCeZHTgOaSNBcWoQ6jRjdCp11opfzMWIP5qg==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(921020)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HgwOmcocMIi2HYedc1Mf7VkOzgDExLw3z1Niv0LAB5xYTE99fgOWyafihfinkDBaQvta7NDZvnqq20/+V2d5Rnt2qoLMH1A6Ups4Fu+4R4EekNbCYW++08yrHWS8+q6b//DKnvBbhRrIKUJiuA+F5o/SY/NPm5715fK/80Z2xYuf8iAK7tdR2ImsEGaIeQQvK+eoGNzyWQFb6iTKbuse69GEihRscz1rsTeIMz71x3ulvCzoo1vxcC+7zoxEB2iiCk0uRxA0qllLZCNDsipuo20pyQPIGrxO4SaUC9oxvuBv83Vb5TAYjB8vFCRoAPsc07MoEvvM+uoVK0msHBK0VPYuw1kXh//WlR1fkui3cP+E0LHLvjgz5Cofy1DOoxTMNIBGMRl7Ew5Ps2uAnvJ6SwHQKjgzy4LPwVauzSZkDducXq7Kmtba00FqFfEjLv7i
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 22:29:21.9798 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 333a7e74-ac3b-4744-3473-08dead514096
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5759
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

From: Randolph Sapp <rs@ti.com>

Add a board_get_usable_ram_top definition, since currently ram_top is
equal to ram_size. Attempting to actually map ram_size with map_sysmem
results in a fault.

Signed-off-by: Randolph Sapp <rs@ti.com>
---
 board/sandbox/sandbox.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/board/sandbox/sandbox.c b/board/sandbox/sandbox.c
index 13006a0ffc2..88c7636d3ca 100644
--- a/board/sandbox/sandbox.c
+++ b/board/sandbox/sandbox.c
@@ -105,6 +105,11 @@ int dram_init(void)
 	return 0;
 }
 
+phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
+{
+	return gd->ram_size - 1;
+}
+
 int ft_board_setup(void *fdt, struct bd_info *bd)
 {
 	/* Create an arbitrary reservation to allow testing OF_BOARD_SETUP.*/
-- 
2.54.0

