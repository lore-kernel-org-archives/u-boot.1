Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B4ECA0EE4
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 04:53:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E8F5833D1;
	Mon, 18 Aug 2025 06:53:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xb9ANCV4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5613D83429; Mon, 18 Aug 2025 06:53:42 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::619])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3979782FC7
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 06:53:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIki4XyNaDswOF3xRObE4mAx4u/JnGapOZfUlhjwiNu+t/aOr9zKTA11tM8j3FfTZYTDzo6/RpCifc4UgqcYXaW+P8VQLVjjntkHa41yeXVmGPvRWLkVdz9OhJYy7rOFCT6wJE71hUteXlWVN9B6J1DN9JyRitWYWHgGnWrnKqdPC0v5VdH/3/N5Za4UbDHAmryCjlwPAZqSabciU+xfIE2JPSh/Vsaooj+XUlgPHMcPuLxV89xtKoJBVBa271x5VXrt/leVRJgqgV5WAOm76Zn74oG0xZ0C21wku99Gv6T98+gS6fxSCVeYhvlbfVbUxftPzVbsL3ykOIDUn8lfZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUuKHxwFZXat82lZFL06VqvcrLqJDElRr0R2QqbOmJk=;
 b=Df3UX+armZ+X6ivyVKylYhaueFMoFIbkvuJLp8O4dUxb1vk7aClmSXL/ohevTZcTCq6jeT0YtWtPxi1ko7ToP7HvW33K+he19yr3UlIiBwqLhJTNXV0Zd3s2K9WRIYW8AfkgqJKz5vbcwYjJ0/VUSajO0eA6X3hq1+HOekBqb1WyqxcRrIqk2Xw69HQid3ei3ujJrJFK1wcGLgM2mOWqw7e6k8ezJTbMiQ6+J4LApf8irlPSaPGf5UG0hOJBgKjer/PCb9g8XlPxt90jwQA5lC3Ftkjw1sDjVJnNSW2WoPNcGnXgMVs/jZrIujJleprlA55B4ln7OmH6HaiyYu0Q/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUuKHxwFZXat82lZFL06VqvcrLqJDElRr0R2QqbOmJk=;
 b=Xb9ANCV4YCfguqo9YDKMxuKR8RNNG/K5b5pS0W7rZJ9gcGQMaHP1wIm56RI4hm0KoPHTNv1TvBOtD9/ceLlOUyRZoyyJphjEn0XzGsyu5kt48kMsQzTkI/j70GTXNl7F7BccOqGa7lqKk6hLoCUS/vHhFPjGbQYnDRbCoqnyIaU=
Received: from SN6PR16CA0044.namprd16.prod.outlook.com (2603:10b6:805:ca::21)
 by SJ5PPF5D591B24D.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::994) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 04:53:20 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:805:ca:cafe::71) by SN6PR16CA0044.outlook.office365.com
 (2603:10b6:805:ca::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.21 via Frontend Transport; Mon,
 18 Aug 2025 04:53:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 18 Aug 2025 04:53:19 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 17 Aug
 2025 23:53:18 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Sun, 17 Aug
 2025 21:53:17 -0700
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Sun, 17 Aug 2025 23:53:16 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@amd.com>
Subject: [PATCH] configs: versal2: Add usb_pgood_delay for versal2 boards
Date: Mon, 18 Aug 2025 10:23:04 +0530
Message-ID: <20250818045304.4058177-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|SJ5PPF5D591B24D:EE_
X-MS-Office365-Filtering-Correlation-Id: ae543617-147f-4cc1-05b1-08ddde132720
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?S1wS0mR+fPLD5AUx5XZrq4vEHd+Q3jviTELXGAkrWwc+SdLjLJ2A3Kx7oCdb?=
 =?us-ascii?Q?j3fRYJKLyK1O57VYCz6dVykm1mH6hQGXrshMfJUpTnSq7HnGwRmF6mwHeTZ6?=
 =?us-ascii?Q?RKAoR9wY58XieMadMdISILK1m765KVwfRw/1AtTxFX3l0le9idTLsmpEVmQr?=
 =?us-ascii?Q?47VhpD3wOnMPqviEIY2XS6SjNEQRrcHRajt5KKZiURvEL5EH82AAmS1ZJUPh?=
 =?us-ascii?Q?nKnBSlI/hMgDKQ51JttBNmFKX9v+s+7UibzMhST7AJle5BcPi9yk0m0LrwxG?=
 =?us-ascii?Q?Irw6elSqjIZrqSQt1P4iy+ail2LMKHxb6yLLSQBi5RcVjt1oOsdI6f3BY6Iy?=
 =?us-ascii?Q?KdrR4oFTmeI9FacSqXWDMkAVxq7yQ7gApLNvZ7tMV8SccyYDKKjsNBE3ntzd?=
 =?us-ascii?Q?IZO3f4bRCAbqDiVOkdjVo9j63sUzgZJeD/caypIwY6vbdZf2njDqWzG4s5M1?=
 =?us-ascii?Q?pmP/BqeZu6oSc/0UIwb9u3BkkaXMCwQwJi49qI4kdQUl6KdPY1TWcU5SlCAD?=
 =?us-ascii?Q?mBIC7W5BjMkGn2n7F5F/F/dkOgXpC0k77QsSFMkzLNXun8Htq4GkGIFU+SuC?=
 =?us-ascii?Q?SCIYftpkwvv9iUnBUL5rOA6G4Zi6iIe3UKQx+pfVDgVnrwcp7J7BDmfwHQxs?=
 =?us-ascii?Q?yrRiqA3R1QNxviiDh406yD1TgnhCLolis22uk9dN/nEEd26ajIqxnOjqZw8a?=
 =?us-ascii?Q?WhwKlvqc5IceL46xrT0T0wkERkIkzOifq2+U/YV/MFcCBn4lfcolbb6VjGmH?=
 =?us-ascii?Q?pc3b2ThrUfOXz2r+V2q4A4zfJA7hAhs2oIt+n0AmR8DNHCl2akRkivzjG+zf?=
 =?us-ascii?Q?wWa2gLdLNu5BGjdzIfAcFAnTedVqlbnrTv3hwiAVbcqdvz0RNHo4slGg0p3O?=
 =?us-ascii?Q?L+FKVNGnrJzMQEwzaT7rkFZ7QtWWbpYfTTpF0nbY7KCU9GotQEeZBC3Vc1iQ?=
 =?us-ascii?Q?EZucXzDEMDCtwvuraE43pz0v7tDEmW9Hrr9cVOoRC2ezk8RVPBhIVj3wSZY/?=
 =?us-ascii?Q?dBnozeR+6/bJKREFfdVKIL9lWj2fU2S11G/bsSXwVCQndWaASumDM/GObw2V?=
 =?us-ascii?Q?K5plS4kz0hSYWz6MsHWzJJGJIGLCzNbeQ24Gew2ZkVhtr0XQ30gohKPxKHl/?=
 =?us-ascii?Q?tGk1TPaLtDsEnhQIpvQi34dbYyg9VqejVBUArX3kPXWuq2FZiUSdaJmT34+3?=
 =?us-ascii?Q?+dP5sl6OUjIrKXF4VjpOIWXwwFd3FcaQOebkzjO1H9r9G01BWUBldSUL7Dad?=
 =?us-ascii?Q?80RVRSvndVCeFu3MIJSbxEOPCFF8rSGQJS5l1AGGIO8PdMCVxYj4a6+lVuWC?=
 =?us-ascii?Q?IpT7RIDMiHjGd2oSe0IbPMxig2arSu4o7vUHDtEmHtUKCyIZfgxfPb9tpLgm?=
 =?us-ascii?Q?0F88Q5/71aiSWwnEfR1HDBNKpbks8klgnSHW7vvbHSixf5mrZt4dlVcfEWR5?=
 =?us-ascii?Q?21+OXqf/WJXQv+W6WPUBhnJgR7Py2qSoiGrCT5w3U+sqbsdiVLpHQCufgjFb?=
 =?us-ascii?Q?yWd4wG23ozjKI8lu9FK5dY1noadOILiTUE8e?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 04:53:19.7971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae543617-147f-4cc1-05b1-08ddde132720
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF5D591B24D
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

Add usb_pgood_delay to ensure proper detection of USB devices.
Increase the USB power good delay for versal2 specific boards,
as certain USB sticks may not be detected without it.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 include/configs/amd_versal2.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/configs/amd_versal2.h b/include/configs/amd_versal2.h
index 1ade6adfa0b..40dc9c5ad8a 100644
--- a/include/configs/amd_versal2.h
+++ b/include/configs/amd_versal2.h
@@ -151,6 +151,7 @@
 #ifndef CFG_EXTRA_ENV_SETTINGS
 #define CFG_EXTRA_ENV_SETTINGS \
 	ENV_MEM_LAYOUT_SETTINGS \
+	"usb_pgood_delay=2000\0" \
 	BOOTENV \
 	BOOTENV_DEV_SHARED_XSPI \
 	DFU_ALT_INFO
-- 
2.25.1

