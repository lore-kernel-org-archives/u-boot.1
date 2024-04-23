Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93366C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 05:31:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D283888592;
	Tue, 23 Apr 2024 07:31:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NdrqFtas";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FA768858B; Tue, 23 Apr 2024 07:31:13 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8F2288588
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 07:31:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHbPYWyNj2MinQjtMNqEU8l7eMYjeAJzaiGX4vLpBa73P19eEKG+et+WEqGtaPKBKz+fH7tBf6gmyta+e/yLApwJoR9Beja12FunDD7eqIzl/9UOkT3T+Oa0IE4wCPHN+gcGeAY/SYOpf+gbDFxPi7twZdYq7qYGAeRGyXv/K5rLH5y/KK6F85iaDmLYZT2GWtLY1VQeU8GNgW12RuUPb84w2x7sAyJuN8YR0gXYBYoVI1LutL8LY85QMo+tDCRLg4JcCq97MS01YGubgDDeccn4NXNS5zD+kjAcghWG2a6h0JyBzTeAMg0DfMxwBlV28QXvDzed1QkZFSAB6xZbbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysr0dYjPUPIPHIDloClFExerkDISXnVGesDZsVKvVrg=;
 b=C24oW/Ynb0uoJWpJZ0HAkS1i8Z4Z5RL56Cj5cQiFaE5pkxAk/T1VnYYiO7QD5uqAdLx7fRjBW1Uz3gXALJduN9PiYqIZSI6VfdYmOJ6KRVUrHbcSERun+IbMDERC/56ehkndaorexKsERsrvYER0pJn5aGmC8eJhi9QU4UMM5B/OmpTkpq3WDTWcuyNYlRwRRyZmNIus+ikGu1qyDoi09cDYQIYqme6S8jx7r3Ou5DDIhbrU8uHxQvsL+SUS/ZDTwUXjzUOXlGt8cS1YnO7kYXX8nH4NEUZ+UdrdpQxqv7ylyTU64MpIMGwY+Krfmlq5eFNEFyMCywWhQldl88AXQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysr0dYjPUPIPHIDloClFExerkDISXnVGesDZsVKvVrg=;
 b=NdrqFtashjZqJJ+om7lRnyzn0A01v4ray4Y5Jpv1HFFwPwmpcegW00PNvLFxv8rbxToe0/Ry3XhesDKv9H9gxngQBVrQX3XQzKtbOxzw+H1sHwwTwLIfovmVl+zZBaAmYCXHwF+N1yt0CZSHFs9RDbnDekLBbJLelcIvkGHS2Cg=
Received: from CH0PR03CA0263.namprd03.prod.outlook.com (2603:10b6:610:e5::28)
 by CH3PR12MB8581.namprd12.prod.outlook.com (2603:10b6:610:15d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 05:31:07 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::d7) by CH0PR03CA0263.outlook.office365.com
 (2603:10b6:610:e5::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Tue, 23 Apr 2024 05:31:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 05:31:07 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 00:31:06 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 00:31:06 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 23 Apr 2024 00:31:04 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <peng.fan@nxp.com>, <jh80.chung@samsung.com>, <git@amd.com>
Subject: [PATCH] mmc: Change the frequency to MMC_HS_52 when selecting hs400
Date: Tue, 23 Apr 2024 11:00:57 +0530
Message-ID: <20240423053057.15863-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|CH3PR12MB8581:EE_
X-MS-Office365-Filtering-Correlation-Id: 833a2ae6-9e3e-47d7-4ddc-08dc63569377
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UKLm6xbDVlMgq89S9mp1GgNRXTpiF9FBpNvI55NoUCeHDuZUEsRPZ2p/UCqK?=
 =?us-ascii?Q?t+NBmPo510Y06Qxc33NX+EYuusPVK5zpTTYn1gbktz9IiJxDX2ijmOsmLgcK?=
 =?us-ascii?Q?9Kj0mp7V+NIBx6BJ3eHEMD+T7AdAWwWzrI7u3JyFqnHjEVj8MG3gp5GQ7wZn?=
 =?us-ascii?Q?w4b4IbcF4GqVC0PqzGQ/bQ64aHZ0d3J0ed41+nm17zN09tV8XunLYvALK89x?=
 =?us-ascii?Q?KEp/9pYaWR5ZS4q3qXMy+g6x5wrrHU26Jnz0pEonr3qL477Xr3g1J6Q31hoS?=
 =?us-ascii?Q?WZ5GFU1UG02mh2tsW4AKa3wZA+oQH2djmvo//pY41hJOEPZSvtw0JAq/lOgF?=
 =?us-ascii?Q?Ex/L8Zw0Mx3N7Vc+lG8btoQ8nRCi/nrmTrh+TCf8RurIVBYQmyvARDjW/8yC?=
 =?us-ascii?Q?MFHN6CbVjBllHJ6FmQywr6OqUvAHgQmIxT8TXgW2qBC2S7Z4vorlugR4Jlpf?=
 =?us-ascii?Q?SZrb/IrxLE+l+PR1Y0ygHtOY8Gw+1+w+1CCQnI4f62fNrbLpVKkyxW7v+KlS?=
 =?us-ascii?Q?sgvTfEmq7IOkaZCEL9qo3qQUe6XqTkpza+6E+FBh4GwiMe+0ckvvO8NEJXWC?=
 =?us-ascii?Q?8LIBASeJUvn8iPcyUVJJpwbSWDYOd3B9AP3C42F3trP6m5S5OTHTfi7g4SSc?=
 =?us-ascii?Q?cbZT3X6C2yTB2ttICsd+k+0XDgM5TNQ6u8LU/ZRcv5At1r5nBuYZLbtuKXLw?=
 =?us-ascii?Q?mh3VZXHjsKwm7XHNMk9+0t0Hx2/RklHrxukild+vi+kjVw3P9LvOpWZNhWsV?=
 =?us-ascii?Q?d5ik85/Np8ocVocEuRIgqY7GRuYi81sZgizUnjmkw5l4OjR5+0FRXNcolhIZ?=
 =?us-ascii?Q?WgPWdmKCoN+nUFbSOh97haXEukdf20wZ4NmvawzbGICdMAWbmX7L5+/Xr8LF?=
 =?us-ascii?Q?uOC2c1dZulSAueTvjdFO75fosqIoMJwIhZm4SJA9/4HiVVmdZwXcp8yCBG/Y?=
 =?us-ascii?Q?ZVTo8ajx0I7jTltgmijfA8V/j2FIVBkA0uahthZEFeIDhpFR/x0tmUVSZSuf?=
 =?us-ascii?Q?uGBVc+Xp8HXWjDv+FwcLaY2toYh9KbWzOK7fLmaF0KWJU4MkYtEwIDT9d8oy?=
 =?us-ascii?Q?5D8U11Yi5l96dBx95V5Z4JbYcslRC0qQEiWL1CAISDQH+2OrxB1i3HLCPW6d?=
 =?us-ascii?Q?CnxmLnCzVOCo7N21VVkzWpsmbjsl9EcSendhz004URD/EWeZTZC8TpngYe8Y?=
 =?us-ascii?Q?wVDnew9z1/UBxQNjwQpjdYwnPLkA59xhgBq4QEx7B638zvI27clPhzBSZHQX?=
 =?us-ascii?Q?A9LAWF3DLP/18K+XwoKJJ9+D1eCjTgRL1JZLJ6DgTh4FlGA1PInCqbmVTQLs?=
 =?us-ascii?Q?YW+4tS1ZrLmPTxYukJQs+ZZdP0WpOMDltIMqUf4/3XXZvWDbtK6WTmNg31al?=
 =?us-ascii?Q?BC/5mG+PHcPkBNmsWvr7El9Kpxel?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 05:31:07.1393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 833a2ae6-9e3e-47d7-4ddc-08dc63569377
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8581
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

Per JESD84-B51 P47, host need to change frequency to <=52MHz
after setting HS_TIMING to 0x1, and host need to set the
8-bit DDR buswidth. Currently setting the frequency to 26MHz
and trying to switch 8-bit DDR buswidth resulting timeouts.

mmc dev 1 0
Select HS400 failed -110
switch to partitions #0, OK
mmc1(part 0) is current device

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/mmc/mmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 7b068c71ff..a2ed99aefe 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -962,8 +962,8 @@ static int mmc_set_card_speed(struct mmc *mmc, enum bus_mode mode,
 	 * Extended CSD. Reconfigure the controller to run at HS mode.
 	 */
 	if (hsdowngrade) {
-		mmc_select_mode(mmc, MMC_HS);
-		mmc_set_clock(mmc, mmc_mode2freq(mmc, MMC_HS), false);
+		mmc_select_mode(mmc, MMC_HS_52);
+		mmc_set_clock(mmc, mmc_mode2freq(mmc, MMC_HS_52), false);
 	}
 #endif
 
@@ -2043,7 +2043,7 @@ static int mmc_select_hs400(struct mmc *mmc)
 	}
 
 	/* Set back to HS */
-	mmc_set_card_speed(mmc, MMC_HS, true);
+	mmc_set_card_speed(mmc, MMC_HS_52, true);
 
 	err = mmc_hs400_prepare_ddr(mmc);
 	if (err)
-- 
2.17.1

