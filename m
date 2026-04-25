Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 002B5FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:07:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85B5B84312;
	Sat, 25 Apr 2026 18:07:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="miqY2lM+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A045C84380; Sat, 25 Apr 2026 18:07:16 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF22B8429E
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:07:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from PH8PR10MB6340.namprd10.prod.outlook.com (2603:10b6:510:1cf::7)
 by DM6PR10MB4362.namprd10.prod.outlook.com (2603:10b6:5:21a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.24; Sat, 25 Apr
 2026 10:19:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKf3Kfd1QqaRmup+B3jqCZEFq8ZRAerEQvmo0oaZNOUGvj56mQPyPRghTxGjilr3m39HKFdELrUIdrrvFfxW27kA3uvjKgjn21TX3wXXFQCYuYpC683Y+X01sRMaVw3qYlHoX3728xImrv6uexEjOCNbqS4GDn1yq97oWW0PRKT1n7+ByZfdb0BNcdMfzaD/6ZF+q7+x1RtYv5w4WaiPZgrO1MQsjUVEhRsPCL0hTgR4PLx5D36sH9+pw1uwNowWDUNjgeiAtwAwgoOk7+wwetEqRvA7K3Mqt1sl4Esk8VI/Ii2FxQAIUQu775dpfdoP3OaSSqnjLilfE6w0+gQEWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ok+8VSM333ZN7ig4p/cLzMDhL9b4HcUZAJh67Bkb44o=;
 b=WjcKvH9rIbhyGWbjoEthHP/DoA254JWgyIdsOIevijh5H/pehqhL5KGPhRKwQiZzxxMOVyXO2NCfmUsxDQumAwKhtLWMJtPr6QjiMuIeuB95ImittGKY6ScHI2tPqfuX4CJ+PXfUvCoE84Hb9GCbeQnLkJXg/2TMOTVWSfSxFKrajhg3Ae7ofHDtvDUWhVbiSsfioo/3KAJj0we1YkYvOjMxAx8kMjceVKYWcJGBqI1wH9tGObHtpW0p4wlIia40mt2BbO4pARKM0mZYdJHfLJo3Nrv67LWAW+t7GUO6paOS+m4Lkjk5l38pUySQbheC8JuUMqvgSYdWbgPcsy5O6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ok+8VSM333ZN7ig4p/cLzMDhL9b4HcUZAJh67Bkb44o=;
 b=miqY2lM+B3VqA8mAptme7FWJIVUQSqxae+x9ZgA7iL7HZ1anr+zw8/ll8dXvPHQ2Fv5OUqjhwas8x6UcmMnGi3dqBXVP4GpoKDAQJjI8tVYrz9gKwnCJYV30e9sBhJhSkVunZ+1CtnXI4VNydN++ro1GzMCFvhxHhNyVaps45EI=
Received: from BN9PR03CA0736.namprd03.prod.outlook.com (2603:10b6:408:110::21)
 by PH8PR10MB6340.namprd10.prod.outlook.com (2603:10b6:510:1cf::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Sat, 25 Apr
 2026 03:38:07 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:110:cafe::f9) by BN9PR03CA0736.outlook.office365.com
 (2603:10b6:408:110::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Sat,
 25 Apr 2026 03:38:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Sat, 25 Apr 2026 03:38:05 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 22:38:04 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 22:38:04 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Apr 2026 22:38:04 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 63P3bk822903263; Fri, 24 Apr 2026 22:38:01 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v4 03/11] arm: mach-k3: Explicitly identify TIFSSTUB images
 when discarding buffers
Date: Sat, 25 Apr 2026 09:07:34 +0530
Message-ID: <20260425033742.1519298-4-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260425033742.1519298-1-b-padhi@ti.com>
References: <20260425033742.1519298-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|PH8PR10MB6340:EE_|DM6PR10MB4362:EE_
X-MS-Office365-Filtering-Correlation-Id: 5384cdd9-42e5-4bdd-a2d5-08dea27c0f9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7uyFljuL3aGnUFJZztoXmcs6i1MnGAQxoTtDtUBFwDXfU0vfpx+xdsOKizTRG+Hn4ZTY8FMm3agem/N2iXQTmk/4AYqwQ+h/9fGbXFitE57Up8w+iJDU6MHMrusvBoGslA3cmC6QfdLheAZb8+Q5TgPwUY+Ko+zxVhMJ+zkRC+V09TJdTNhkLCA7Yarnazclz72lgLeicdy1z1hztwNnQz0tcd23YrZEgoKwcjxQhBShKpNj2hXM8S4/nTW0x4aLI4AZD9j82ZCFdNp1gSp7Y2gZBDdS0bntKAs+tfM07LxzDbmqnoHzBZG6/9h6rMiaW5BQ3FpOqXqlsZR6EnHSbIdgj10pPT325w979x33TKPjseRgTvuWM33iybsAogP1wrheOI2iFFYnJGKty03UKY2S3Xa9SHDf6+38eNGyfH14EABA/YyWhcrAdmEw1y/dD8DThsQOtVRNNhRN2EI7TMeyj/N2rDcrk1LR0IuANe97ciRXYTxcFi7uQRVo3tBxewXQ2M9tMmIssKhttiAlZRvtxXYFkdrwElbi5ak4gX2Z6qKp+cPFcX7c3M6/4xAGMatdvhMz0n7CCKG9LgiOi0eMT4l5hgpTv5hB0EOMCpNk9vHluzja24hD5JCMqq50NQ7N613nMWcX4gYyfFXR+Daeytg7czOG3Qh3CfRcGeNpboXMdy52pHK/G2EiohOBTgUu4/AnCcSPxI3M/rbO2wy+qzfbVpYIqx/F6lwTYuN83xVeq5oQBbzeu3tvxCoiDsPUjmnkHvmqDiaccqewGqhJrUURAKKdujeWm9upJL8=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vSWgd+bns1a3gJG7VaXFoMyr7ES3dtTXWSAQG8ZCQhQobAefD5ptlKEqbb7RiZ14bYTD3rcJsVsB53VXQAZT5YEamkCmwqx43e/OrTAWwkEfKueAO0MjAlrzoUXh2X3Nab5JHGB0e/b86/ZupwJzqmsBhPTVJoHr4Y64/bRE9jkhiRcEmExgalBkzfEW/uqG+tvj40hjF8z/dk9aERAZrjSbpF35GaWQEXGzcyUMdvb/dxhO3bFjXEVUcQcgTaf4tU2L7Cef1EguCHNjfz017CBb7/IIoa80RKoW+tX1CsgX5lqwetodo0lPr18Tnkf8YcxAlaAIRtPScOs63HNgTboh+p1juERCh5oOh3SLeaQkJ0h5GcCCsmMYng4gGThocLYjx6nmY0tqs9Bk2mqPY/GnynRIjvqgf4jW6CwT56JleGeQ1FBzrc2+vEJZsWv4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 03:38:05.3397 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5384cdd9-42e5-4bdd-a2d5-08dea27c0f9a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6340
X-OriginatorOrg: ti.com
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

The board_fit_image_post_process() function assumes that all TIFSSTUB
images appear at the end of the image_os_match[] array by using
the condition:

	i < IMAGE_AMT && i > IMAGE_ID_DM_FW

However, this assumption breaks when new image types are appended to the
enum and the array, causing unintended image types to match this
condition and having their buffer sizes incorrectly set to 0 with:

	*p_size = 0

To avoid this issue, replace the range-based check with an explicit
match for TIFSSTUB image IDs.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
v4: Changelog:
1. Added the correct condition in commit message. [Andrew]

Link to v3:
https://lore.kernel.org/all/20251231173621.1069988-4-b-padhi@ti.com/

v3: Changelog:
1. None

Link to v2:
https://lore.kernel.org/all/20250506104202.16741-7-b-padhi@ti.com/

v2: Changelog:
1. New patch. Fixes condition to allow new images to be added at the end
of the enum.

 arch/arm/mach-k3/r5/common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
index 50c4231655e..f075b881901 100644
--- a/arch/arm/mach-k3/r5/common.c
+++ b/arch/arm/mach-k3/r5/common.c
@@ -366,7 +366,8 @@ void board_fit_image_post_process(const void *fit, int node, void **p_image,
 		}
 	}
 
-	if (i < IMAGE_AMT && i > IMAGE_ID_DM_FW) {
+	if (i == IMAGE_ID_TIFSSTUB_HS || i == IMAGE_ID_TIFSSTUB_FS ||
+	    i == IMAGE_ID_TIFSSTUB_GP) {
 		int device_type = get_device_type();
 
 		if ((device_type == K3_DEVICE_TYPE_HS_SE &&
-- 
2.34.1

