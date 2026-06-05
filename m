Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3937CD6E7C
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 19:38:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 657CC849CE;
	Fri,  5 Jun 2026 21:38:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NzWar6bG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03736846B1; Fri,  5 Jun 2026 21:38:37 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA11B849CB
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 21:38:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vishalm@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AI5pJPPjWzEl8erY5VzQ3PeiETyjuVJYP1T5hPSiVmZGJKbKeIUM/l5pN80OE1y8LCYUj1ch1JIEgokerPUg3Tvnme/XAZLKm+/SqGSF1ip3wmuzLYO7hriSO3AKcoXlv91agKoh7NHrxBjX4fh9Ah3zxB1zHdOReXg/Tv/BL1IH9oYyWRk34Yjouj2OMBN/CTlEYdMHOZvEVOTjSvzPEu0oB+PLvQSgxbnfY+xkreW3hO/hgSyVyaZzNrKuP9VYa9wqy1zC64hdGjf64r92Sm7/tcsZ7fALfdeRHwrUXrIbs0MWr5bK80vMjM5fS7yK22u6BsWacJbDAmMKKOBSlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2OYLE0WOjiab6NHEfQw+yEgrcKsHLQFs95++g6WfE4=;
 b=OW+XcrRi5lWn1ZjZ/MiQRHGuVjn4hxvKGFmWuRmatqpaDsvUF7GJyBGN6pzlnebawMUC2F+LgEObnmCP1XIahZ6g2TVuTCtE6PUUy5C/Jj9dAnEFAXMszXF92ZU4IcPP60XZI0YJlW46XO+soTJt4WDwftp91ttzE2snkBISUzmkkAteyJBqxfCxvMPjZ5a+Am4Yw3o/Y1PbeBAd75T9gBqAqCGc2Qmhg3nfMwDbOQ8u9KoEne/hGnmKKvvoqz+teQpTREBB8ISJjTrjNxTMSTkc2uawzX0FIxMyIW2/cimE75bzUICYiCMwwErt0KOSxsJNRZwlESa6LrsBoF2qUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2OYLE0WOjiab6NHEfQw+yEgrcKsHLQFs95++g6WfE4=;
 b=NzWar6bGvv2sQ3LU/jMPnh+jBZDrkh4gJcmjObVHhsDi9A85lqLl6bN+hjRaeVFboSlzCEi44iwTv54+Agc5i5O2hCvE4DAnLiHiluq3i1EvTHEbqLARn0YXWK/Ifzt2gTEjL/HMdO9jdAd34VgwbbhMmD+vP47jf1eoqiLaGIQ=
Received: from BLAPR03CA0106.namprd03.prod.outlook.com (2603:10b6:208:32a::21)
 by IA0PR10MB7158.namprd10.prod.outlook.com (2603:10b6:208:403::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 19:38:30 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:32a:cafe::35) by BLAPR03CA0106.outlook.office365.com
 (2603:10b6:208:32a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Fri, 5
 Jun 2026 19:38:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 19:38:30 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 5 Jun
 2026 14:38:29 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 5 Jun
 2026 14:38:29 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 5 Jun 2026 14:38:29 -0500
Received: from uda0271468c.dhcp.ti.com (uda0271468c.dhcp.ti.com
 [128.247.75.164])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 655JcT372005785;
 Fri, 5 Jun 2026 14:38:29 -0500
From: Vishal Mahaveer <vishalm@ti.com>
To: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Bryan Brattlof
 <bb@ti.com>
CC: Anshul Dalal <anshuld@ti.com>
Subject: [PATCH 0/2] TI: AM64-EVM/SK: Enable MAIN UART1 for SYSFW tracing
Date: Fri, 5 Jun 2026 14:38:27 -0500
Message-ID: <20260605193829.395161-1-vishalm@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|IA0PR10MB7158:EE_
X-MS-Office365-Filtering-Correlation-Id: 372708d2-21e7-452a-24a9-08dec33a058d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: yLHZN+iPNSxFsa9sJzCpGqAROkyzgHWFbq+VC7gV+Y1Rx/p7wVtmwb2uHCwBretIE+S4apsp2IECyLkfF1hP9VeWXCcSkCJFEiyNGobwZbemyKkxGiPd5w3sU7ZrqLjKin3ywEfrSaegFvsrUhF9qkfsCoryNOte2LySfmqVrF7aVt+T4hRuxmzf10hEw4Bepc1M6ewvD0uMIB0bED/eV9DHAfZVjdjPyUXq/uDVPNMdmNIgwtSLTHSzl/AUh4x/qBLByC1tCz3BQkvgsj1AaPXmKMCvvEEKP+ZVMZdfK+fd8+w73MQliRsQwRp2gyqhApRLgHAwpptzt5BwBstau8f5Bc4RdbjzylzD3sBFYjtVEs+o8zIE1vGkVOUlMpnyCsMxAUGrUFipARVOw662TgPzhrA2+FrODs0Hgt868XpWcnNSkM3tjJYANuDTlbJBnD2zrVhXgC8xe0GzUfCeNUgtdI1s4OSABkl01VwTr/1p+UNJrk/jus76gW7hRFGmlufpdT76b3veoXORegOZudxPipknJ5QGX868vyFGPIXEqWJZx+5SNGjqQzOw/lMRS5CcxWFjq9NgJBGEjV5nE7uz7gV0u984SY7lrxgOyGyEm8Gm0Q2kpoXUIHoE6ImRRbMwbEQvDuNjLjoQSl/mjKRYex+6vSIspd6yc71nC8lgVZenSxEXcrxxH+j/JyAZE+Uw3pSP4dXlNVytcsSBLFQjkxScDY788+70DOA+Tpg=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JtqXvTKz5zIqv4d9ceYV6F8anI3hMxLA3/H4VkGBVupC227tL3OoN6OHGTJDp8/Cug8m+sKSNoirUBmCJGwYTVdngaRGLjQZ18PhhkUKrwi9Rq6lFk+8GOHfTHEQFVFiVRdY/JJhAvgoxlL3C5eVviegJjc3NVLKWiC0S5Rr1lNm5XJ1De++70edbuS441HdZmgTqyZlSXdQk6VlW0qKKCJWMndFoY9wNU+mcf1vaR5D5dcwjs7XTU/vjXv0EFdRNSj7yz8Qxvyp7y6aSw6hZ31majH3ew6ZcJvI/YrgtprtTuK1e59U1T4mP0OH3RawZZAJYazW+sKeTujKy31x6AhIGi1lQ0P2ktZS9H6y4K6a090gcs8hZsJ4tGe2hW+ru4EXK5C5Mq8pXONt2IbUd6hLRMX9PWZpSa0tiFu1aqHUl1DwuxA2sRcOGovGJRJO
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 19:38:30.0691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 372708d2-21e7-452a-24a9-08dec33a058d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7158
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

Collecting SYSFW traces from DMSC firmware is broken on the current
codebase. These changes enables MAIN_UART1 for collecting SYSFW traces
when the trace option is enabled in the boardcfg.

Vishal Mahaveer (2):
  arm: mach-k3: am642: Update MAIN UART1 serial alias from 3 to 1
  arm: dts: k3-am642-evm/sk: enable MAIN UART1 for SYSFW logs

 arch/arm/dts/k3-am642-r5-evm.dts    | 10 ++++++++++
 arch/arm/dts/k3-am642-r5-sk.dts     | 10 ++++++++++
 arch/arm/mach-k3/am64x/am642_init.c |  4 ++--
 3 files changed, 22 insertions(+), 2 deletions(-)

-- 
2.34.1

