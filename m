Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D07C83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 11:04:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C301383817;
	Tue, 22 Jul 2025 13:04:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="safJOMkT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC2818383E; Tue, 22 Jul 2025 13:04:15 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::60b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B171A83253
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 13:04:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4z6Hh6GF+lKXTjPvezNOgaE8/OirNDpn9iXVzyzDGkapgJfA4lTOmMT3jOu/VXUrz/5F6QBUM6BNCHSfdLeSdCu33esxaMCGnxdM9Yl/hNRb9QYRRndm7iuDgnTA1O4pM+2NXwVkgvOEDEgPF5IWuMzmebP6RLRrllcFx8G+uQinkjNSyBNzY5BKi/m8zCFvoPqPdmRr3IOy/1OfwiVivIUfjnb3272lBu1TpKhQX3/AHYhnVPpWSxbExd9TeYoU3XjbTBfgaSrtmmq769Q/4q1pU4NysQS5VOaMi1SQ6V/LE5bzDJI/3vGH/ODP0Z0ZEbKJ31tisN6RN0DIiWdsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cT9e7Rl+7jnv+0LdQkrf64TPx4Fh3jgKiryF5NzIypc=;
 b=C6pZhgxe075jhb/aC3IPsuYtFBj7OvPoj7S4trYZt4lDRdjwl/s8wMj0XbnefmC/sB1YIzSwQ6VpQRPiPLnJGc/Ke9RXZQxB4XKiFuE5qOPNeQQjJ05fjEsseQ8HTYYP2nC+k+rae0MfN5FaSLokdgqSWVskjIIOZykbCf4pM8HWbUpCNfPyQJwmaK5K0wYY+DCCld79wyySTdCT6vbrscI4upvF3Wu3OecJfA+xVSZ8/N1c4wfLrEUaskdF902V6/82nr6weSxAQN/6rasERWi+YpNMzHnvTeCZ8dH7LtXUdXNdaa/xb5JhfBKPdZtg0ULYIjRV+z6l/n5FO03eaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cT9e7Rl+7jnv+0LdQkrf64TPx4Fh3jgKiryF5NzIypc=;
 b=safJOMkT8BF10X9YajmM1sQNBKmMTAbHiG5GTV98NIZVgIXIz7jmCxceXEdiErt+f+Kp0/qYPaNm1VI1k/DVRSBUA6fiiqiemf8kgtdY+MbQsyuXj6966+uVhFp/GFWr8JDNAP/kcqeO38jsQX2yAfD0nB212CpsYwn8Fgp8jJU=
Received: from CH0PR03CA0386.namprd03.prod.outlook.com (2603:10b6:610:119::29)
 by LV3PR12MB9353.namprd12.prod.outlook.com (2603:10b6:408:21b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 11:04:09 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::39) by CH0PR03CA0386.outlook.office365.com
 (2603:10b6:610:119::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 11:04:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 11:04:09 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 06:04:08 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 06:04:06 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 06:04:06 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Padmarao Begari <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/4] xilinx: mbv: Disable OF_HAS_PRIOR_STAGE
Date: Tue, 22 Jul 2025 13:03:43 +0200
Message-ID: <5deff1d1f4108df26959c9c53fb9bea5783343d3.1753182218.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1753182218.git.michal.simek@amd.com>
References: <cover.1753182218.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=674; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=MU7vKAXU7TA4/Gwx88FAUL7HtcHXvtEKvor2V7x4eN0=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTUF4iYsEjOE+5ptN5Xy//qnmfDu8ZlHtzrFKV35L/ZH
 juzWN+io5SFQYyDQVZMkWU6k47Dmm/Xlootj8yHmcPKBDKEgYtTACYSJMrIsOmXbUvZ8ZVP1ztJ
 heybf2Ne//aNSfab2QoOLLT4VbSyfRYjwzmte3/e2+yIehTS1hX2+OKR+OwlX4VWL/57cvrnn5b
 O+dwA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|LV3PR12MB9353:EE_
X-MS-Office365-Filtering-Correlation-Id: 53b4d861-fd15-438b-9b91-08ddc90f7bf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KiTKUMtHVW/KZVXShmZtwlr9RskwztMlnQzXl5EcTANchH3icvFPpQ8RZdwv?=
 =?us-ascii?Q?7U3joO/Ps80GkunckznP2saN/+0OGY0o2/j9wWDCiYuFucn5T47ZDyFyOiLV?=
 =?us-ascii?Q?xMPFhD5q5V0SHg+EBwRpQUsKAFdnrNeP0ZoUHK6B+XnQIYVbWbPsNBVHpUls?=
 =?us-ascii?Q?InedCrwNZeNUtkBYKw2MQ8BTOT/h+2Rk9NMNEm+JvWcBT+frUBXSCr8SMlpo?=
 =?us-ascii?Q?NkJ3WL/pyBexDdl3iGO2V+9FvkAxVy8WgJmzHPv6kulkl/473iVjxnU7wwyJ?=
 =?us-ascii?Q?ByZNN0nX/oguyQRBgqews7zdFPoFigUCL4gLmevBpqGtZCA+REKaOjO0wFJ/?=
 =?us-ascii?Q?/0CedDl7/V3mZhou0ygdkGgnHBPz60XKwjJUov6nWLwMoAzEHfkJSDo6koM1?=
 =?us-ascii?Q?4ZMV1PzUfXnWC9CEzgRmGHZ1NBTbpEK6LeYYQ55fDbDJkOQWq+bDIcjy+d3D?=
 =?us-ascii?Q?ASAYK3Gv3GGUYEDOdFEpKEwTrhu98nFUHGNWpmcyktb4wiV3V5tKFDfQSrxY?=
 =?us-ascii?Q?wPt+32NThg7BG9QB0DFfKHwKIFf6EeiEt5dEunDDsM/Bnq3H2onGX2wdJpFS?=
 =?us-ascii?Q?MQiqvihJS3EhxCDY3PNa5zYipkKxRnOAP/H1QiL31oNLZBHi1jPfurpoGzwC?=
 =?us-ascii?Q?6A1idO7h3UR72zXVhFC1GpIjLr0KgYG0JOEHPnzxf5pwgi8OKGJXDcE4pP2v?=
 =?us-ascii?Q?dfkyF4+7mdmLInYpSA/gtJaz4hxXNgQVKWFaafuE5ee7HYFW5NUhVRGTeXZl?=
 =?us-ascii?Q?CJGukIuXS7mPUqT0y55lHMav2zla1uLc77e/Ss8GSNvTCa5vwy8Z1crL1Nne?=
 =?us-ascii?Q?Ga+uk6egNq7ibFvk9yn44R8IXD6NtnHWqR89egBqJMy3ExZUmu3bamVEDqZk?=
 =?us-ascii?Q?kbRCXv+Zm1ZVoHZgXOrUDvvQNrO7/SU/vPEreUt0ntuSPw66wD5zi1Oq9sv9?=
 =?us-ascii?Q?2yqlBYBf2asEbX7mhnXripZ/e9oE0xDn4veIHM8zFJ2woIjhFOXkj8ud4XEM?=
 =?us-ascii?Q?jpEil3THbUI4xdu735HnroDSiMpnAeQfuBA9wA9KSw5KhA7WrKKTZ9zgrm47?=
 =?us-ascii?Q?baVmLg+V8xp8OvJGa5VXBFyVC6zoNEvweTRXonW6B30wK7ZNRyr0kFZgleJm?=
 =?us-ascii?Q?9pJLVToMBRHy+mcLW1c3TgiMnc/T+eiLknFTkrd02CG2GSj9DlkhbXzwNdUA?=
 =?us-ascii?Q?Bckl1UgQIe/KcxzYpYt2YMDGsRuOSYIjqEGA3sdYiv7z54/OmqJKKfsqf+GV?=
 =?us-ascii?Q?Ph/SDRd0FAVzQOBUNUyDT/LFMUTKOYENVyK+NecPB5ZX4OpBRSeGMjej6u1s?=
 =?us-ascii?Q?er8Ci9A+zmVpMdvbHoaJHACymrKTBrfxkVpmQKTlAmPZIBdJEW1za3hYPnLm?=
 =?us-ascii?Q?n6BAjOuTWljax36IeSgpX0JGoHyPKMnwSbbmft0xAMGoQaV3oDKPze/O/Qq/?=
 =?us-ascii?Q?qsalhn+GF+us3sY3NcNVBfuYKi2il3kJWYMraj42AiQIWQbAkQXWQxftL8nN?=
 =?us-ascii?Q?HvylkE8ZQ6VVq9HwcZsuANPK+vbjsORdi5F+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 11:04:09.7482 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b4d861-fd15-438b-9b91-08ddc90f7bf8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9353
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

There is no reason to use OF_BOARD for MBV because reduced DT is used by
SPL and full DT is passed via u-boot.img or u-boot.itb. There is no reason
to pick up DTB from certain address.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/xilinx/mbv/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/xilinx/mbv/Kconfig b/board/xilinx/mbv/Kconfig
index c52ba1870b0b..68acd8955ae8 100644
--- a/board/xilinx/mbv/Kconfig
+++ b/board/xilinx/mbv/Kconfig
@@ -28,7 +28,6 @@ config BOARD_SPECIFIC_OPTIONS
 	imply SPL_RAM_DEVICE
 	imply CMD_SBI
 	imply CMD_PING
-	imply OF_HAS_PRIOR_STAGE
 
 source "board/xilinx/Kconfig"
 
-- 
2.43.0

