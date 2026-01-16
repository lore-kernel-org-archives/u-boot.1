Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D25D4A619
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 09:58:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BF5083015;
	Fri, 16 Jan 2026 10:58:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L85ucaSM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D6228367F; Fri, 16 Jan 2026 10:58:53 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82DD882BF2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 10:58:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STP0+dOf7pz1z9qCKdLkuvZkUe/+l351mxIqapReHF7iNDkS/R5Cjv4KC17QIYiTTHMPBQLNIbyYc6WqNtj2JLunp5atpEekOm5qYBOI9lmyGOoY+ThjuuDBuhb/KDGQzqz/1WtldnV9YHSTaMpdIoQsdh7O77ke914yyfVHwDu8wZcKBayncQ+PGA+UF/Qpf3aJNyE5avaR1JbLEgaKwAWjdTpjWt+lXD+4bnHf6Elqc3LQgHBMLRKl0WyMVnFJixZL1FIqku/5GHI4djkWTjB4Aw+7x0vMEBxgUoz6QZJcD6SXlgE73JBqK4PCi4yrlqgkjkBB09QHLisOdk9PzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yzNoC2fWOQu5bB8mEL6CoSJ4EKz1H+Da8Fq+X4gFDI=;
 b=FQQgjOAVEVP622MBGo6AYaRzc0mmHo3crgQofFRiJB2qUQOy59CTk6xvRZ6QE1HAfOmEhj77jQgKVKxj+ofhNCvKnCsTQoxA60NudQJrLdnArv6aF4j2MmitjPqexCiAWOwB/grFrXQ/uMAJ+ORE3UZPusRC7XP96mAd7uAjtamWr0MsWnX8PMaw7LiMsmfzYtLT1q/0XqVwTwmD5dHcvH8jn+HNN13U0pd1hbaiATaA5LBw6Hs4qDxLbmaFUCPrWdR8fZVRNVYGpMp8Vul9JR0d8UfJc1Vb9ZRV5A12e9pYrZkqJzPud9+9tvJZcUxAR2rbrCw1oFVVhRL0ACi+/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yzNoC2fWOQu5bB8mEL6CoSJ4EKz1H+Da8Fq+X4gFDI=;
 b=L85ucaSME/WAoz3f5nx8joXR21NQLzY8as5Vh+yiNjwfdtBz6e74lQtggIa51pTWgezAJWFPWk23kMUc9y+XWleNyD8yeniqGy9kp/encYrbOe54z7p+o1VvnfBTTBWzKrVx69xpW8MuWijdXKn1/BXlWG1cS2IkkrZ3vmPs5xs=
Received: from BY5PR13CA0036.namprd13.prod.outlook.com (2603:10b6:a03:180::49)
 by LV3PR12MB9236.namprd12.prod.outlook.com (2603:10b6:408:1a5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Fri, 16 Jan
 2026 09:58:40 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::6e) by BY5PR13CA0036.outlook.office365.com
 (2603:10b6:a03:180::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4 via Frontend Transport; Fri,
 16 Jan 2026 09:58:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 09:58:39 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 16 Jan
 2026 03:58:37 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 16 Jan
 2026 01:58:36 -0800
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 16 Jan 2026 03:58:36 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH] microblaze: Fix SPL device support
Date: Fri, 16 Jan 2026 10:58:29 +0100
Message-ID: <d1c1d677b2eb4266290d31dbdf2e6e44c77a75ff.1768557507.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1002; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=zrg3SiCGYIJWFMkYxDqivbcyIObtvatGHWledhVBFxw=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRmcR/7+XNl0BmF7cr3jldEmf1drvlr28KE8FouydszF
 BZb8OTd6ChlYRDjYJAVU2SZzqTjsObbtaViyyPzYeawMoEMYeDiFICJ8BozMtw7Nz3PiGd/d4DZ
 6XQ2JiuV5Pp+k7ilywsrD/dkfJ6UsYqRYV9g8cncc12Lzn59+j2ZI1Htrk2l7gL1qomHOqIY333
 /zQYA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|LV3PR12MB9236:EE_
X-MS-Office365-Filtering-Correlation-Id: f360a98f-01ad-4e2a-10d9-08de54e5d302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oQ82wi1bRGajkOjny5XDDfl1/RPvSY9D7z1Ey+6kKn5Bm4FP4h5ps3TW3nxi?=
 =?us-ascii?Q?sRvKkGFFa6gQLxAUkQISKFu+KZzbdBVPwTWJMZ8WV8O52PRKnbE1GTT6Omrg?=
 =?us-ascii?Q?xdz6B0owyABkCyYjspYLxYnan2sTmI8tHfP+tTunCDxciPe6tsyrgx4NY3hI?=
 =?us-ascii?Q?s4QxsP2LpgOTSBRvdHC7lEm84/QdP0CY3M83e0bZ/ywBPMbB3jKVHStI2BoR?=
 =?us-ascii?Q?XQYdUkrhwsuaI2FETLAs0Mdf0zKNxKwDBvR+BLBhAJr4duXz6PVssV7G+xEF?=
 =?us-ascii?Q?z/wuUZFYsF4gGzZoBQqpBZgru8qBBE4qF4CNgw6xQ6Op9cI0/2B6YflRbg55?=
 =?us-ascii?Q?B/ppbA78LPTigd3BBYmmaIfbnACH6+C0QAcmDv9yvN/JQmGSh8YZE/h24AlJ?=
 =?us-ascii?Q?f4pqmornUtO1luiqkLYrz/DU2ByNe17a4DoBxI8x+jWUZmT9JSZbg7EAFe5g?=
 =?us-ascii?Q?zSbWqz+LAUTCiXPbW7rHGVTT6uG8eL9LucxzyCh4mnUC7QBDodvQd8n3uAio?=
 =?us-ascii?Q?PA7vR1EDl638ysiVfrPelgF1Sl5FKrf1q5Iq9WXc2fN1DOXAqVj2xs/K0bBS?=
 =?us-ascii?Q?JoAgT6koHzX1O29XdN3NZoYKxp5Y5KNQJMHSG5rXc9rejvz0eNPJXlq8Lqcu?=
 =?us-ascii?Q?7B7qi5FDGF6752OIqwbLVxzM/vw5X/1FK4Moqnw6d6UE97v1ap+fSwH0PGx6?=
 =?us-ascii?Q?UTSDU/JnWntyGzssdSvMNWHTay+yASbZ8osPIhXAK9PrZM4SjvPYxc8UsI9K?=
 =?us-ascii?Q?z5dE1uBQJN8Vawt6+hA0Xr4b6w+s0X3T63B0DEN3YBw2yozMzq9b3mGYrXqS?=
 =?us-ascii?Q?6zPM3i9AoYgaGqSOoUqpsdYCYdBqes71achLu3Ku0uPFGzhjlC0r15AX33V3?=
 =?us-ascii?Q?yw/bpfTc0KgRujEmP5xQbM25aHLn99SRj01KBMZzM83giibWF8rwdD93l0iU?=
 =?us-ascii?Q?VbH9XwHryPkysvydC+546Po9y1tyUW5oMiXJLIwsB1AZeSzKZh4vrmBfuQI2?=
 =?us-ascii?Q?P1YQEBFTHF0G055XuQJ4G+0+bIsALQSHI51oyuS3mawfsNTH5lvLVCU8rtHr?=
 =?us-ascii?Q?EPneEr3aWHu+tPmMfrzVsq47uL6g/pUuDFhVtvmPJfSZayymH/JJKbPJftpQ?=
 =?us-ascii?Q?9T3MYn+O9kRVZo7IWyL1y3oGRrRkopYig+SZKaHe8wSG0BYhumspX89FGotE?=
 =?us-ascii?Q?Nws6MfQz0UGOsaYRdXRK2ydA3D86n+Juhp6wGNbsW5dMwMa+eCRl+pz9KFh+?=
 =?us-ascii?Q?VgciFnW0EBHTzeMTE7dscwU6CVAYqfMQZFZ/j52xajl/j86bRslq67jPpVnj?=
 =?us-ascii?Q?S6weN97BybCqYIIxijBRr470SzK1tFQUi0cFV1OsSlxSpH9RI97m9m+3iVGx?=
 =?us-ascii?Q?XIvVHTgvWIfmd+KZ9QM8xDw8f8878rROyjWbPlzh/XQK4KCZ6e57tPAayTDb?=
 =?us-ascii?Q?zIOOyIGWrbcS0NV5Rye4pZgpgFUR4QePrrIvpmcXnTKP5a3KpQXBg7BMt6Tz?=
 =?us-ascii?Q?xDbB5knRIdX1fUH+9FXblj1eVhP0B3Urz5hcTQiuS78uhyrYL8No24XYDMf0?=
 =?us-ascii?Q?iHI8Dv9h86u/qznWh4XnPih3U+Fi4BJxL98BCwsfVx4I2yPhjpjGr9TwDAzu?=
 =?us-ascii?Q?aK0vGiLN+hhDj/UdEr7rCLjIUfYb2vuR4QH5/HjXsjDufq5i+40eRh26IaXW?=
 =?us-ascii?Q?TM/mWQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 09:58:39.6463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f360a98f-01ad-4e2a-10d9-08de54e5d302
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9236
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

Extend spl_boot_list[] only when SPL has support for it.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/microblaze/cpu/spl.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/microblaze/cpu/spl.c b/arch/microblaze/cpu/spl.c
index 521776705786..f9b0a0aca219 100644
--- a/arch/microblaze/cpu/spl.c
+++ b/arch/microblaze/cpu/spl.c
@@ -14,9 +14,16 @@
 
 void board_boot_order(u32 *spl_boot_list)
 {
-	spl_boot_list[0] = BOOT_DEVICE_NOR;
-	spl_boot_list[1] = BOOT_DEVICE_RAM;
-	spl_boot_list[2] = BOOT_DEVICE_SPI;
+	u32 i = 0;
+
+	if (CONFIG_IS_ENABLED(NOR_SUPPORT))
+		spl_boot_list[i++] = BOOT_DEVICE_NOR;
+
+	if (CONFIG_IS_ENABLED(SPI_FLASH_SUPPORT))
+		spl_boot_list[i++] = BOOT_DEVICE_SPI;
+
+	if (CONFIG_IS_ENABLED(RAM_SUPPORT))
+		spl_boot_list[i++] = BOOT_DEVICE_RAM;
 }
 
 /* Board initialization after bss clearance */
-- 
2.43.0

base-commit: 885493d6d299a4f0fab522f53af24b625d0ac526
branch: debian-sent3
