Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4991FC87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 14:32:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC8BE803CC;
	Wed, 30 Jul 2025 16:32:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ot5P059g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3103F803CC; Wed, 30 Jul 2025 16:32:28 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::623])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91C0B801BE
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 16:32:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLnpEZ4GjlENv0tkg1Ps53Fqug/C+Xag/oPq3gB8OKOwpeK4LlUkcOBCX0ZM6FNWgvnDbkmIv1jvyG7d9YJvb2yjbH/qMIhaF04eTMFA5TgvGtDmXhdfhX5LYdQfgwTXiKswUXm7PZ8z+eAmwGHNfqtA3Hs0Xg3IfTPGriIbmL5o6z9leX1FZR7/a+0sO0PRYpz+KyB6Q5rdfI9TIYT32YuHq8G91Oxo9ofnr5Z81HIM/3zbz0Ie56zjJLeXjCohXMxoNJKVTpmTX6BKDtdObvTqlTuRcKdnix1+sI+r6/IEojU0qotHzt1s4xvh39nEKUMjkp6SOkykULG3TLNimQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPWqxGplmxQJNnPyun889mV/jbkuLVEzfuMXUz8402g=;
 b=ebewLqHakJLXrG8WWzJmvx0xG04J9ucrMFlDMKZRQj13d/4V6vLIIdD57q0mwTMXnFxFJ48P59Jwy/PNFMN9/J5ycoWywDrY60/jP/SttpSgu6D+miffAEXtSERMvYnlRTWWIFVDmxIrKy87cZi7dgctRAbMd7pMft2cIdmeDP5E0PXopWgQKIWFlmHK2sm5p60oDkbKFYRugSxDAju9GNahFS8tGwr8Hk2jkl4ZbNsCVA7ch+toDisSLyhu2n8NgfHj+Jp1jkTvOCGMRtxuvyK5R5cvv1aFAb7FlKaJhkAtvwRNfi14ylRhEAgCmo3qke0JQ7Ywe1J6w2aiMV6v0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPWqxGplmxQJNnPyun889mV/jbkuLVEzfuMXUz8402g=;
 b=Ot5P059gLDvpDpu6+g5veMIgHXJtZSNw/pUyRakp+NL5IE776A425JwSjFAEpy6y5YpoV+msTW6aAK6XYgKyGg5Hr/qEtTxZShkFqp9fDKsE7DGAl6lXgH0VKqYXWJ1ZBimH/8GC1nsSaGK6Cx/17u+GINumrxPBiMhPWGAVIQQ=
Received: from BN9P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::14)
 by SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 30 Jul
 2025 14:32:22 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:408:10c:cafe::67) by BN9P222CA0009.outlook.office365.com
 (2603:10b6:408:10c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Wed,
 30 Jul 2025 14:32:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 14:32:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 09:32:09 -0500
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 30 Jul 2025 09:32:09 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Tom Rini <trini@konsulko.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: [PATCH] arm64: versal2: Define BOOTENV_DEV_SHARED_XSPI when distro is
 disabled
Date: Wed, 30 Jul 2025 16:32:01 +0200
Message-ID: <4c195468c0341ddd2aca98f83cdcbd40117cc9ee.1753885919.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=707; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=oOUhKrv4aZUMB83Y6j+6T8LrEUitYFfnmm2Yk706mPQ=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWR06TwS3NKnEHu90ZNbSdb79QdGTckFh292dfTse7Jze
 uC26xuvdJSyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBE2tsY/ru/jPVpPcpedUkj
 Z/8Jg8ad4Q87Z2fKNG720Ng8eXts+AuGfxrWLew6j2pPSmhaZxbdlQz4fcG/ZL/zfIXzr4J3s9y
 t4gcA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|SA5PPF8ECEC29A9:EE_
X-MS-Office365-Filtering-Correlation-Id: 825d444c-4c1b-4699-ce2c-08ddcf75e530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UM+QUflOBXrp42+crGG3QVII1RgL7Kfx3VDx0zHf4wNWO8vBymD2XemL+1xL?=
 =?us-ascii?Q?4DjKSDt45SQm7Z3gtk3o99yM3Esje8VdqSLD/oLsV33JWcPzGE6qbXYi1eD3?=
 =?us-ascii?Q?ypG6GsnsKlThVsvgSRKpT4SBkn9APauowKiYedeyg4Hhepe9KUTU4QAne0tV?=
 =?us-ascii?Q?pXAKO0yreCzWn0GWMO8lQtuoco2biyAH3ci7pPG5t8ur3QW/dJNGJ7Z8u+lz?=
 =?us-ascii?Q?604fGSJ0mdBmBiK7Lf/WZtD/LCn3c2HMwlCpHlsIPidNYR7TAq88UK0fDHk1?=
 =?us-ascii?Q?enM4LedVrgOt3njDNkz0SVaasciuz5PnVSdo807nIWsQqFu5mxzvHiK6X3fs?=
 =?us-ascii?Q?Zi3Dao5Tfd9rgcHEOsiMoxzH+yKEIxwyNydog8W2r2IP+dFwZHrzUnibTI1/?=
 =?us-ascii?Q?Y+gLydMN6q0N2kRpawIvms74wdqc1TDNjGePmk0ZK3vgJUDjod+qCOq013Il?=
 =?us-ascii?Q?aC3BXjKTOdhVMCyQemL41ddFTxP4gT5ClEEkQzyTmXeXKLQQvOP0XDy/vDi+?=
 =?us-ascii?Q?kBTNz+0QmvAB/i2bpoWkjDTDPP/MCUM6wN3k2BzhUNo42ea0jBOztDbIZWVV?=
 =?us-ascii?Q?ecBZ1t+PtdgI6rW/98vJx/tLflQ3ym6PE2Qs7Z3Xu9ED3p/XaBtFXQ1HJlt/?=
 =?us-ascii?Q?k2mCFvffaCzQKTgbk4/+LF1f6tdGrZeU16p29n49ZDjYrkqS/6IHPKZZGEYO?=
 =?us-ascii?Q?1vl6ScMgBvo89cu7NJqA/MdRoY6ZrclFUk5A63JVRIFZcS685Asw5KG9v2X5?=
 =?us-ascii?Q?TFy5OdoxCQTEPTJM/kdviapqJ+zrtnflEOUz6QkDRe7pNEuqIR6b8+3pahk8?=
 =?us-ascii?Q?923ldxUy/ADWm/vT21kEj3ghvLoDWh/3Gp4nf19j9T2npqt4gfcUd9DKqZ3v?=
 =?us-ascii?Q?ACBg/nw1aEpD44LggXZpvbhwQXn8VWYU88D7+epUYAbEqkWVTIelL0g7qVLZ?=
 =?us-ascii?Q?EyDjH6hfr7j93zGiONew6N2P4bgiex4xNAGlK0xTU4flxNIFucyVeY0e52Hc?=
 =?us-ascii?Q?mEbrAq4s6zZIRoSPFD4KsbmrW88JXy1T6St77WJpJGW+5sNqMrFqUi75T3RP?=
 =?us-ascii?Q?dMrEmvhbbHL9e/F8i7dcWoNBBKRNchfCpoUUx1fIrtqs+2LVG/LzLS6aC3Wo?=
 =?us-ascii?Q?XAkw7ua5mx3Vinn5vBZwMWtAIQFZw2ZiJlRE3O6QX531KS6cuYWsZ2yZvPsS?=
 =?us-ascii?Q?gz+kw4fv3sbDPE7cqE48nwP6BlyFBAP1AXSdQcw5IyjfDnHMuQiyBYdg1jsH?=
 =?us-ascii?Q?liiC3EzsZJJN5KIscxf8kPlAW8jksCfz6QgSEyjbiwacNoPkbYi+FEd2DJ6Y?=
 =?us-ascii?Q?MPs4YWeryHZyS7SopuytcDGBgbwp3rmEAGtCflJzIilnB5JKlUp/fYFuquP1?=
 =?us-ascii?Q?Vo4EAXQ/TexW8LQ/gf2dT1yvj+GMqc8V4miqsqFQ9CBtDpaYYco1qsUb9ZZ0?=
 =?us-ascii?Q?EFzeGPORaEpUGpBbByyxykUqpg9CZwonlmxBI6Gh6J5QdaDYS0XutxHXd2LF?=
 =?us-ascii?Q?xsyBZpnvswf8JLyJmIOmFlHhCxSdq9FXSLk/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 14:32:21.9337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 825d444c-4c1b-4699-ce2c-08ddcf75e530
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF8ECEC29A9
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

When DISTRO_DEFAULT is disabled there is missing empty
BOOTENV_DEV_SHARED_XSPI macro defined.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 include/configs/amd_versal2.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/configs/amd_versal2.h b/include/configs/amd_versal2.h
index 1ade6adfa0bc..bd52e5a895f1 100644
--- a/include/configs/amd_versal2.h
+++ b/include/configs/amd_versal2.h
@@ -145,6 +145,7 @@
 
 #else /* CONFIG_DISTRO_DEFAULTS */
 # define BOOTENV
+# define BOOTENV_DEV_SHARED_XSPI
 #endif /* CONFIG_DISTRO_DEFAULTS */
 
 /* Initial environment variables */
-- 
2.43.0

base-commit: 4bf2731f030926c65b5031e0109e092013cb225b
branch: debian-sent3
