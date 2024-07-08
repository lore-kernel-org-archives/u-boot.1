Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D0DC3DA41
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 16:48:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65E03887EB;
	Mon,  8 Jul 2024 18:48:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xck1YQdy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23D3E887EB; Mon,  8 Jul 2024 18:48:26 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::629])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1050187F5C
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 18:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Sam.Povilus@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWfJRtH3eDWhZfyL/LMJn5f6bVjR8o5TaY7NwOMRpjcS5Ea00q16Yjxgpa3wk1hjwWMYfizmhtlBUan/RivvrGSsHUHfpFP67N0rEioFV6ikniLVTZtcW7ssMLYxpepcqUSvWQSxL6g4ZoAXHW036bRrye3qHGr1XuEhi15caN9R6bSY8KktVPkLzES3hrabX0ZKyz0RibRTHQlFosVU46zQg+GN9eoMkcucyrdvgXbrK+D55LHcMJDT6ajpw61F5nCn23a6hX43mRkX0tsmbpyz64Fgii/ux5sT0pU2HHllD2HaAVbpETo1xOr5roAUp7cMhTfR8Y+TfbgAi2b9dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFYlD6zYIf6jIIfZ97HRTF7xbsBltR6b4jED2IPZf3o=;
 b=AJTVMSXPktmKkOYsYbhOrgbN7V24a7kKCYSVXVaGQgBEI4NG2PGzk+Xwo8SUjIodjEWrjmRfQPCuqknGUAxstVLoQtWsZpXjgcyjiu0TkH5D0rUCGjTrZd2QOBUkCWsGY3IA93cVtcb7wyf0Eq21PZy/G2mHadu8tmonhOSINkbqH2xcfiaZFSmUec6oZQ3HcKXrdkMBnaBiC/V7M/0pVSpITgyngTR9M9rRzqTUdGk6TjKitJD90tngFze1NCvZC3EAiSJEDDSk41pIdqNUjPlq0tpQjP4fRRHcV82UutHKTDvR4dCM4GmG8wnfQaTGOv++CLeQQFhvNzAhEEYc1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=konsulko.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFYlD6zYIf6jIIfZ97HRTF7xbsBltR6b4jED2IPZf3o=;
 b=xck1YQdywjV8tZ+x4AFYWRZ3faZZd24mqJpIzuvbqmx3FNSeTnTauGJN6rvHOWkKlLzwJAZyFnayfnV+IsG6ASyIEddSM0QwLv6SqvvHCnZmrgAuwroQJ4MYMeINolGnBFP10NTmuMmx5b/K6WAUc33+FWFsZHwpQOD4qaUmH10=
Received: from PH7PR03CA0016.namprd03.prod.outlook.com (2603:10b6:510:339::13)
 by SJ0PR12MB7033.namprd12.prod.outlook.com (2603:10b6:a03:448::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Mon, 8 Jul
 2024 16:48:21 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:510:339:cafe::45) by PH7PR03CA0016.outlook.office365.com
 (2603:10b6:510:339::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35 via Frontend
 Transport; Mon, 8 Jul 2024 16:48:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 16:48:20 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 8 Jul
 2024 11:48:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 8 Jul
 2024 11:48:18 -0500
Received: from xcoapps69.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 8 Jul 2024 11:48:18 -0500
From: Sam Povilus <sam.povilus@amd.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <xypron.glpk@gmx.de>,
 <u-boot@lists.denx.de>
CC: <sam.povilus@amd.com>, <git@amd.com>
Subject: [RFC v4 2/2] doc: add missing table of content links
Date: Mon, 8 Jul 2024 10:48:12 -0600
Message-ID: <20240708164812.1205697-3-sam.povilus@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240708164812.1205697-1-sam.povilus@amd.com>
References: <20240708164812.1205697-1-sam.povilus@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: sam.povilus@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|SJ0PR12MB7033:EE_
X-MS-Office365-Filtering-Correlation-Id: 62bc1aa0-7c90-4e5d-672a-08dc9f6dc659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TiwE/FffB4/lvd5uQKXBXY6PfQIaLWnrDAJjG52ZTa4OJevnknqKbaW1X9JE?=
 =?us-ascii?Q?6PIoEh5NqXHHLqCuIHJ8RS/bzxHfhIkDJ/ejOeJbIvlaPKZBcw3QrzT7m5wY?=
 =?us-ascii?Q?tPsMZWXPoOPbzXv/qZGZnn6jjcBMnFEpi6wh25LALv/aWhSEfQLklaOebTKs?=
 =?us-ascii?Q?Cbgyw7RYniiVBZozQ/UMh0Q58kDgpKb03INoBYOsVjTGXrSy8K7IiYWh76ht?=
 =?us-ascii?Q?pZfSgq9O//L8HY6y43pHqeYDqLuUNu3X1DAOeey3dZ/xcl0kmoCaSv6Wj47w?=
 =?us-ascii?Q?qOCqATJ0VtStdbqInqZVBpbBnZeO8KLtQH2exCi6J2Z75FybZV3Fm2tXODfB?=
 =?us-ascii?Q?/l+NDh3XoQLiXMu7uEM5Zfp+yqvgDpKFXvK519yDiqyFIFDNs90YSYDNX6g0?=
 =?us-ascii?Q?bwJH6ypwq+EDKAO4Unh6L6BAULJ9Aj1I4d3ukpV0qsL5I3kb+giwjCR0KncS?=
 =?us-ascii?Q?flPR2pI/jI/MUDrmG5uCKQadci0cmYev5FsK9uq7JT68UPCEbWaHc+ac+A1D?=
 =?us-ascii?Q?0X80tmNyvR99w1B5tXmOPtWCZNHjhRBRoSeLUmpVurPvFqzvoXddjYm9jTGE?=
 =?us-ascii?Q?OtQdZqVvq2Fd9oiCxuS49imeLUmV/gky2VY0eoK/XaMowwvyAUofbxh7GIJK?=
 =?us-ascii?Q?WdmSwlGSWmF7Xd+2CL45UpeGetrZxrR6PSddVz191lkA9vV0ceT9BNCd7T2X?=
 =?us-ascii?Q?fKEBrX22zmfAOt1YhUrSQVH2Gj3tgMd0D7KosXWenMz1Qa0qNKX6ZE6GNimF?=
 =?us-ascii?Q?wYXCp6TT2s9C7qAJoySQJPDD/MhfZ7KgLoTZVpMkdQ3O9r5epzhtWjVez4Sb?=
 =?us-ascii?Q?s08coU2Cmz34FoRwa+VVF8I26Cj7Z5JjrjqKA1zF82dxwvmo2fqBdYkPn5r4?=
 =?us-ascii?Q?Z9N8GKZyy27mVL4uSx1sroPtsiR3RnwS7qXEqcKRXpHJwTiEJO5Ynj/cjfl3?=
 =?us-ascii?Q?BhmeU+hrKsbcFJB2KIwvkyd9HZb/YIS+jrcyUMklngKPugO0VcfJnozGy2E1?=
 =?us-ascii?Q?FArZl0Z5l5ieJvJSDx+U2iNhoTyfMONJw/5oV63B3o2IbMVuw/oqzWxtIKK/?=
 =?us-ascii?Q?AzNi+39OzKBki2D2IzgOjHUzY0+oSt/0/Qc2Y7VyQJoTro+Ou5nU4SfL9FgJ?=
 =?us-ascii?Q?7SYkHebJz/vtSGzng4l7HfFMQAlzE5ZVUlfqcWhl98ysZWOjFZpQKjhTvx1A?=
 =?us-ascii?Q?hVjxAKO3dvq+24lqdffkicZfSwWTrpXUMHCxoYc2noOeu/PYAvYBKED3LWya?=
 =?us-ascii?Q?TEeqR1KzomfNMUYaxvnAl9c56szvlqP6y1pWDDJBksPGK5rNZtkhCYtiGxne?=
 =?us-ascii?Q?mjzAqbyuFKfo9lmE4xD55LJX36NQ1u9fSsRfCloJMPzdJrBmQm9OO6HT9dBj?=
 =?us-ascii?Q?+xCanGoPPIoO4VMm1e5E3u3nwRwZ2FsxAlQNDUxqogsgYcsLgBjnfptliJvI?=
 =?us-ascii?Q?brii2r5+NeBKLdgoe3DLw67eCa9XbByj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 16:48:20.5267 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bc1aa0-7c90-4e5d-672a-08dc9f6dc659
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7033
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

add missing table of content links, make alphabetical

Signed-off-by: Sam Povilus <sam.povilus@amd.com>
---
 doc/usage/fit/index.rst | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/doc/usage/fit/index.rst b/doc/usage/fit/index.rst
index 52b7d90bbc..ceed452701 100644
--- a/doc/usage/fit/index.rst
+++ b/doc/usage/fit/index.rst
@@ -10,10 +10,23 @@ images that it reads and boots. Documentation about FIT is available in
 .. toctree::
     :maxdepth: 1
 
-    source_file_format
+    beaglebone_vboot
     howto
-    x86-fit-boot
+    kernel_fdt
+    kernel_fdts_compressed
+    kernel
+    multi
+    multi_spl
+    multi-with-fpga
+    multi-with-loadables
+    overlay-fdt-boot
+    sec_firmware_ppa
     signature
+    sign-configs
+    sign-images
+    source_file_format
+    uefi
+    update3
+    update_uboot
     verified-boot
-    beaglebone_vboot
-    overlay-fdt-boot
+    x86-fit-boot
\ No newline at end of file
-- 
2.34.1

