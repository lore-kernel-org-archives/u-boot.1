Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA4FD3B7EA
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 19:06:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D43AA83AEC;
	Mon,  8 Dec 2025 20:06:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TGt3vjgl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7E3C83B64; Mon,  8 Dec 2025 20:06:51 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CC938398D
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 20:06:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEWRp7n6n5V/yckaeEFh0WZHtejs/a6sM0QvtbgQU8AH6Kwmk90K16DQQJaL/Ph9rez4FiOEGEeKFE68+KfRfIga56qPg3vu6mQrwY7BAEInDzmUNhjkEZ7ad3aw51GteJJLZ/iD6yfyqzzqwYs06J3OdkT07yHeMn8PznweCjGTGXEgfTI707qD6vyFRHbgFOYkhEcTJ3gXAEC0McCtyp8VjFK+4xwacerTXarDgajXe4Cb1TTlfG0b7mf73xjLJlSdPxfu2X3mzuKNRI1aDEEzVgZJt7wLvJAKAbz14yFWFxLE4ACTavaWrj26Uxxhtv17zst3xRhewzEKDvoY2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0kvlY13QaRflCGt6F/RVfiKddko9+jrh0fNvo3PAds=;
 b=JPse90KvGoG9xcOTUjjZ+NXPhFnh8IdS47+L5ViM+EIL3FMqnaS444Elh1q989KBmaViD5ls/HgpTJd9pOsV9R0VAmAe6ET3CbOGsKFdE0v6oCM/LQKYhu9ennl5nOTGJE4bknHF1M/kYy5OS38QU7y6wU17nc/6J5hiiYZvvaDh1VUa2r0qaw8rfqTtXx2X/sQQMT3RGEjoSJ7YR2Fb/mstM9xrh0CsOT+fc9Xuz2QJD/IKnAbeiKp1bdAWN62zgn9T113ClhjOpTkjWgs3oFzeCikoKWmHOb1GvI4vkKDX5hTv78cG08pR221aEehyFNpCYvTIqE54c+wY2oZjLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0kvlY13QaRflCGt6F/RVfiKddko9+jrh0fNvo3PAds=;
 b=TGt3vjgluqrdoN13/Xt3uwhcrJrLa2T2TEtVUjWylwF4Wtg09n/caQClrJ75FPcYYOvmOdFqiyabZ1/1evgoR06ajTiTDasPTla3FME712iCAlFJm+GN2O/9mP0UZoxnY3rvuZtmLk3Lwb4X8sn+7VPG7lt/D3mvyiYMYLXr4L4=
Received: from SJ0PR13CA0058.namprd13.prod.outlook.com (2603:10b6:a03:2c2::33)
 by BY5PR10MB4163.namprd10.prod.outlook.com (2603:10b6:a03:20f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 19:06:45 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::36) by SJ0PR13CA0058.outlook.office365.com
 (2603:10b6:a03:2c2::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Mon, 8
 Dec 2025 19:06:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Mon, 8 Dec 2025 19:06:45 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Dec
 2025 13:06:39 -0600
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Dec
 2025 13:06:38 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 8 Dec 2025 13:06:38 -0600
Received: from lelvem-mr05.itg.ti.com ([10.249.42.149])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B8J6crD4121137;
 Mon, 8 Dec 2025 13:06:38 -0600
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Bryan Brattlof <bb@ti.com>, "Simon
 Glass" <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH 2/4] spl: Kconfig: k3: Increase malloc size after relocation
 for R5
Date: Mon, 8 Dec 2025 13:06:33 -0600
Message-ID: <20251208190635.2044082-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20251208190635.2044082-1-afd@ti.com>
References: <20251208190635.2044082-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|BY5PR10MB4163:EE_
X-MS-Office365-Filtering-Correlation-Id: e708cbd0-9bcc-46ad-a303-08de368cee3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PyrduBy+7J42MJR6ilUdSVzYl8uDyMxcfrYf+ti/WkqR3cmzI/obukQtaBxP?=
 =?us-ascii?Q?OTeZNJcOmg2Pz/LmezVt2RJqzQGXE/i1hKReLD/zg9FeCovBwOstZ6K46nrD?=
 =?us-ascii?Q?hQUeGvn3WGpG+HwgieFNldpjkfu+Jt+WAym+46WqUxUQghALUNWqrtN0pjET?=
 =?us-ascii?Q?kJDehkeEwhKiiFW7zq+3Ih+/dnQF1I9je7ZVvyoQMfYd5/TVem/TVaaEMbkP?=
 =?us-ascii?Q?aKXBhSkHiF8ZKxLpFBiMimEVdYtjllNcQfjpNg/vXDZytmjl/2n9GCO4Jtcj?=
 =?us-ascii?Q?76J3GwIrd9rQUe/KK+p90OarW/NmS96ilUfKjx3ApfLyI0kMG+Sny8heHF73?=
 =?us-ascii?Q?0HuxfMIqVbsQ75xxgmszItl+kYwy+O2fJfQ7pr3IXrY70Jtm1s6cCWOqYvTA?=
 =?us-ascii?Q?w3yXfORp0nzTFTOR7skAzKA/NIp5WK5rJV1/IsqIOZ2n8SzeodbdJNCNqr/h?=
 =?us-ascii?Q?iha9/mTCG8YWry7ShxIsjyKpNeoIog/jIRTbh4DzFMRgTYA/fCf+Spg+VMud?=
 =?us-ascii?Q?Zm+9TLzNarbBthhDYdPNVEPYVcLH6a9iR9PJ3bUuEWwYHTFeAtJFKWFpFnsP?=
 =?us-ascii?Q?axhxeTsSrv9ggL7515e1qBOSHULs21PEFPKXNp8HHYH75CxdL554wk1nIMM6?=
 =?us-ascii?Q?p9iKv/+cXCBlzrjcZ4RC0xztxg+OREixPE0nm/cg6INQgbzla7W34sXfLVXk?=
 =?us-ascii?Q?dynDSKDyHrJ1NN9BBMsxzdHnTN0h5VPbcTVY5fTVJWQYTJ1XJ69j8HImuZhs?=
 =?us-ascii?Q?3qbv2+P/eAQ825R2T+dGBt+U2P8bG7+rNXk+j6OjntRaAl20WWzizLdPtrnx?=
 =?us-ascii?Q?Nph2HV/gEt0KcDqx3Xfp06n3OGDDw8uwjiU13wiuuY7u/mShoYFV2OVBvsWg?=
 =?us-ascii?Q?qLpXbY/eu7kDSQsYAaPsiqPaeED+X7r/JbApltDx+IS6cqt1rb/Wb3dVne3U?=
 =?us-ascii?Q?oiJvwtxAxJ/vxLdAMxncILFkssyoH4QqPfTnyhlOepLD3GBSkM+0VRKnhgQI?=
 =?us-ascii?Q?vLGUEUmMvXFj4ntpnLxSEKo0dL+vKFs+EBGBBru/1q79yFItRPzZB8fP2Ewo?=
 =?us-ascii?Q?3UmiLnhohPlCk0cjjo+qyYDifyCrLl9EcXwRYbGgnpbT9DiXMAbOng6sSphJ?=
 =?us-ascii?Q?6BUq/dbyOGf6PrM96AR2RNdT5gj2+evEY0LvEo5vNoZtSTZhLh3ZOIwoTGVZ?=
 =?us-ascii?Q?8g5GLRS6dc6qngV/sdUr0+SlPZU9yFkoSAqA36M6CV2ST6OaJbnzK6FvJ1I6?=
 =?us-ascii?Q?/N6NijJ13XRTh0R3LW560xHeX6MPMI04xFjvgXlIvKzkmYFG2w9IhS9odzAG?=
 =?us-ascii?Q?w303jzZD6UvD7UOdHP/GGevwmc/p+pclpRuC5VbqTckswmqQeggc98tPxI18?=
 =?us-ascii?Q?10IHpAfNyvttUaM3kqap7Jrvv037IteqAdITci1MQNnoK/zaCbxeGUoxi+Ia?=
 =?us-ascii?Q?VPh/EEInhI5R++oOQFJKei3jhphaRyl5lMSTY2LrpUBqmoenqj/PdBLmWrpr?=
 =?us-ascii?Q?+MV4ixlDfRL5tN2oKqsZmnO0jCt6IPXpi6u4ufWjyGC0/UGnepAzahuKGoZR?=
 =?us-ascii?Q?s9+j7vRL0OBb0birlXk=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 19:06:45.2056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e708cbd0-9bcc-46ad-a303-08de368cee3a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4163
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

Seems the "generous 2MB space" is no longer enough for SPL on some K3 R5
platforms so let's increase this to 4MB. That matches what we give to
ARM64 SPL, so combine these.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 common/spl/Kconfig             | 3 +--
 configs/am64x_evm_r5_defconfig | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 3b7b6cafef8..0411a5edc9f 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -465,8 +465,7 @@ config SPL_STACK_R_ADDR
 config SPL_STACK_R_MALLOC_SIMPLE_LEN
 	depends on SPL_STACK_R && SPL_SYS_MALLOC_SIMPLE
 	hex "Size of malloc_simple heap after switching to DRAM SPL stack"
-	default 0x400000 if ARCH_K3 && ARM64
-	default 0x200000 if ARCH_K3 && CPU_V7R
+	default 0x400000 if ARCH_K3
 	default 0x100000
 	help
 	  Specify the amount of the stack to use as memory pool for
diff --git a/configs/am64x_evm_r5_defconfig b/configs/am64x_evm_r5_defconfig
index a675ea84fca..e1a748de5a9 100644
--- a/configs/am64x_evm_r5_defconfig
+++ b/configs/am64x_evm_r5_defconfig
@@ -23,7 +23,6 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x7019b800
 CONFIG_SPL_BSS_MAX_SIZE=0x4000
 CONFIG_SPL_STACK_R=y
-CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x400000
 CONFIG_SPL_SIZE_LIMIT=0x190000
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x4000
 CONFIG_SPL_FS_FAT=y
-- 
2.39.2

