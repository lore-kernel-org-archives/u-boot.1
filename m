Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD984CCF9E5
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 05:21:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B6538397B;
	Thu, 30 Oct 2025 06:20:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oHpdFGq3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 328D483935; Thu, 30 Oct 2025 06:20:12 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 259658390D
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 06:20:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I97Sl5t3d1p9uENYj/t72yadhp6BrWF+/RBvGzuoTpLUSnqoXfY+juZmwYZUZUhKG40hmM0tFEeCD7kGkaWSV1w6SEmlR4Jk6a/bJ6QNZIZEhZroq7Q5yjHBuf4ndOHPeJUG0vx+jw1sYEa+FHIiNZjOIa1gDgJsJ3NrvTvhKTzE8+d5s4ywq1GHDoXmuI3UVAkY5SthFJNJg1z31SNwuEfvEZWju7kBECtLfJ9Bj+qbxNfvMHGbvPNzQpV+GDIx9ieDk9GLRvxr97JmRu/+P8dZGIybZekM6u5gtt9ri/xRTWZCraNjbN9W+sdKn3UX9aQn2yl698kicz4yhVi6SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYFwXHcuTxo2vsWLU6rszjS6hf/PyDFvVYYuyaEb6Qw=;
 b=DnkAUEFdQCK6VPHEx+GAIwC1J7r7zyiId/Qj9O4/IyhTM7swp3cjtbIo2jRfRAmTsfCotlr6PIYwcoJKbUAZ11AAQXSp5EjT9UylZqKabWWRy/f6vsUZe2xLXHZ2eiJKGF/WxbGlvwX18kraXczIywZ952QuGkwVWeELz6f40sMvW8ADuHi8HmmHpKy/TqXURIzedsc2DOeH5ATvFTTUlFXUcK9Wy9SBmlA9Stp4tj2/VCAuysv1MqkxDo8zCIwiI/IDAsCAKkms/tl4Ea/IhgyZ0Zr1k3zYQbSJGDraVJEkOrlBYVq2mD3DKwZwyTfylWNvw5bPZEG2o+L9G+x3Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYFwXHcuTxo2vsWLU6rszjS6hf/PyDFvVYYuyaEb6Qw=;
 b=oHpdFGq3Ub5u8N5L/iwJP+Ie8cJ0S4K48Lqzx4E++LyZyqsVZP+4wUqGVlExrHtAHx35+3E0XLZeYfeYez4oz/yGJ5iRmzwVOeSuqgz0+N28aCwIGy2bZM+07LeMAGT361OvCAOXO2ec5WjIJza6FmMFoxON75rskvW99eXqDRM=
Received: from BYAPR04CA0013.namprd04.prod.outlook.com (2603:10b6:a03:40::26)
 by LV3PR10MB8177.namprd10.prod.outlook.com (2603:10b6:408:289::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Thu, 30 Oct
 2025 05:20:07 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a03:40:cafe::a1) by BYAPR04CA0013.outlook.office365.com
 (2603:10b6:a03:40::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 05:20:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 05:20:06 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 00:19:53 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 00:19:53 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Oct 2025 00:19:53 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59U5JqT41416931;
 Thu, 30 Oct 2025 00:19:52 -0500
From: Anshul Dalal <anshuld@ti.com>
To: 
CC: Anshul Dalal <anshuld@ti.com>, <afd@ti.com>, <b-liu@ti.com>, <bb@ti.com>, 
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <nm@ti.com>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>, <vigneshr@ti.com>
Subject: [PATCH v9 7/8] Makefile: add tifalcon.bin to CLEAN_FILES
Date: Thu, 30 Oct 2025 10:49:31 +0530
Message-ID: <20251030051937.3659010-8-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030051937.3659010-1-anshuld@ti.com>
References: <20251030051937.3659010-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|LV3PR10MB8177:EE_
X-MS-Office365-Filtering-Correlation-Id: 72cea528-4c98-4eab-5e04-08de1773fcf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|34020700016|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9BLTioTjejNl6StFPqhB8ldEmz9ETJtxlaNdPTkS5K7xvnf7/vsAo62Xh7Do?=
 =?us-ascii?Q?ir0Mk6dxmIBsA5yiIx128sm6putX2Qx1opTEzYGyo6T5swxDFtYNvsITd4Oa?=
 =?us-ascii?Q?7JKe/saYYIuYtsBU97GT3s3Un79eiddGGV5oiXUo2Nm69xXAR6YKLrRCEUjg?=
 =?us-ascii?Q?rDCoPlFv3rDAnRxh0i7gOGwsX8XQwBBGKI37jhwuk/01z0dIEndudoKzyVh/?=
 =?us-ascii?Q?dy9kqR5H4joy4Jl3z1GjsrSzAfohzCGOrgdscB5+L9VtlkgzYQy7zlU1OIzf?=
 =?us-ascii?Q?uyPQv9BPYgv0gfK6ZtGE9Oeb7lHfK4hwzST0mFcnCMAdCofe6dnZfy3Czd0T?=
 =?us-ascii?Q?xwLlocildHnQIdXGAJbX7KFq5IgHCqKJREZfVP8gENiowfdRIW4e1AsqMBXr?=
 =?us-ascii?Q?d6pJAWpDdgHyMj0Zen97dh22uB2iJg/rRC6wa8ujvCqSZUQ2NhNtWNUH0icC?=
 =?us-ascii?Q?HQQym5w9GVxW+aipf208ZHQo6vGGX2JDo2MKEgWoGgiR3L45FFTsT4M+1eKP?=
 =?us-ascii?Q?HzHCOIaWrnbMuk8ZV4gNtatcI8C+MXKHZf/pJ84cFXNiTQ9QY3yDLn0xnTGV?=
 =?us-ascii?Q?akWsE82U3UH29H2ml8wy89uNcr2YCMXM1y7b2G+DMaM00Ehdf21KHzcJEKIx?=
 =?us-ascii?Q?FAbRV3bx8wBvX+WKfDD9zfb0h8HXYyIP240UUbGQBD6Q+kB4BC95BpMxS3oV?=
 =?us-ascii?Q?Q51Uphqcitx/yvzNbpQSFX3z1+zDzFOU0ZYbvwT+xeKAscpKqwKeijX/sti3?=
 =?us-ascii?Q?QPY2pfK2WA0ANFNCOGTRVsg/wfpOvs4mT2Niz3CngS3RQlGA3XhJbZ93VhuW?=
 =?us-ascii?Q?nNBs90GUNwAh/D0G3BdbynNSvIJURbMx4KEAe4czXPUW8EFOIch4wCo74uG2?=
 =?us-ascii?Q?uHF+FIUW1VK6Wv27cE+3UIIPOZWnXYEz0TXkM7aBjQox2B3LMcKZ0Va86C7l?=
 =?us-ascii?Q?rRs08sdt/fnTHbM93nOMI/+Gr+4s/w32F4wj49KHTq+zwYy2FvF7uI9+juzp?=
 =?us-ascii?Q?z23WQnmTjn7wRyxhIgjex4Jd+Von3d/z0bQQWPiTQfF357RTorvE4q7tLBFv?=
 =?us-ascii?Q?ZnA6k1RV/VqW2lHETJy2CiBEnFt+o4loqBw+SriRAEHBm4KNdPnGMYvLnN4+?=
 =?us-ascii?Q?AFu3siOcVmzepeE5QpXITd9QNWZeqHhl5e5mcCSB6L/Tfeaf0oTWVaFr0xmt?=
 =?us-ascii?Q?wEQ0d9ofJT/UPVx2X4XjzjUstIfGYU7+sOb6EDT3kUjBT+mNoG+eRvDpt0SH?=
 =?us-ascii?Q?syx5FHUJranKgui7FJW1BmQbl01lmL4syy0342Md63KQB+SQsqscPl7C+jY0?=
 =?us-ascii?Q?1/51RIyTGHdmoStPOnaWrKUl7HGjdo7qmrS7EoBIcdRDzfXeViSR4kABzfCM?=
 =?us-ascii?Q?QfbCzA4UEnj11xfIUSdBPd4ofeBVMK3NTC90Si1kqe/TYmriRwJ461QkeIrI?=
 =?us-ascii?Q?79N7+j2SIyneHomLs6ouYU32LH+OLRmY381bBY/VhAUXdcIJsLaeQsXNGPBo?=
 =?us-ascii?Q?z6kvYypOJyWhwDZeM8t/xPYEs68ZhWdCZbVrcZW7Z704Q4+Ry9jJt9+1uyy/?=
 =?us-ascii?Q?8tx2BCzfRmS7oRm1VKs=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(34020700016)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 05:20:06.4384 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72cea528-4c98-4eab-5e04-08de1773fcf1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8177
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

Builds for A53 on AM62 platforms now generates tifalcon.bin alongside
tispl.bin, add it to CLEAN_FILES to make sure the file gets deleted on
`make clean`.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 2402f9313d8..ebbfa7b5cb7 100644
--- a/Makefile
+++ b/Makefile
@@ -2470,7 +2470,7 @@ CLEAN_FILES += include/autoconf.mk* include/bmp_logo.h include/bmp_logo_data.h \
 	       idbloader-spi.img lib/efi_loader/helloworld_efi.S *.itb \
 	       Test* capsule*.*.efi-capsule capsule*.map mkimage.imx-boot.spl \
 	       mkimage.imx-boot.u-boot mkimage-out.imx-boot.spl mkimage-out.imx-boot.u-boot \
-	       imx9image* m33-oei-ddrfw*
+	       imx9image* m33-oei-ddrfw* tifalcon.bin
 
 # Directories & files removed with 'make mrproper'
 MRPROPER_DIRS  += include/config include/generated spl tpl vpl \
-- 
2.51.0

