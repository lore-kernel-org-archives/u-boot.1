Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF1CCE7CE7
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 08:25:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC3F3890AE;
	Tue,  1 Oct 2024 10:25:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gW5aV153";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 458AE89121; Tue,  1 Oct 2024 10:25:54 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::614])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0196C88FC7
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 10:25:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKJuu1F9l12Z2uZYVCGlqrnjgHFHDP8LiIdmt8GxHfroL6ThJc7T6eZ3m/R9T7zf+iQ3MWm3/yppbrzSw8UK3MoLgB0aLml17GEZA9GdWHlxcWo5+GKZDYasH1PAf3G+sKG18uQConqEkskimki8brc7xzmeZM+wGuWj9MehETlFa/rglm6GC0MT8UNP3JVC6x3k6qQNerDRvGs7dSXx9QxpxsfCjJHr/EsUZfjTT720l9aXagjesUsP3RUD3It90V3yQttBIIz+86y17jYQCzIde8fIzE4cjssnQ6ZnZXR4QX01QEMqbeh63ioLQqxphYCGtgoiQXmhmAfZ58UD7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQSudLRfg8mc0HNjK0+ekw/HGzr9rb6lsXXMM2pwpe8=;
 b=QyXlNB7CEIvvtRngbArjd9YDwcWPhyQCgjpxrx+imv9AyhuuCF8AkHXZ//o9nmmhvcEMDYISHrhdleeTDEkL34K08c4NfdXTktVBp0P3t8wFxWIawAPma+cKIpREAxokVYBkKKAapJcOqgS1Mb6ahTOaTnEHyJx/1EE1O/tkPj9SgwKdhB2K3x5w1D5Aq7qQk9wXiudv5vDihfwjWMDNVvtO5K5Vf6P9+zIOhYovxKezGx6nrDZhoA4O25VIdyuAkatuH0TFppW6hRqMGeMUYFAwvDNfYKIxVGQRkdCI1iq+sEvXXn6XNsDuOOwCdl3XeOAYhtxdIZn0G8fHsP3fkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQSudLRfg8mc0HNjK0+ekw/HGzr9rb6lsXXMM2pwpe8=;
 b=gW5aV153/2ck1M+CAwgedN9BxeJu0Vv2QU8T4munU2sZlz9P5SvKGIAVydZBuWwDCg/H4P64SqP2ZQ7VWpCor39eNgjoHTI0Cbyx7UZo+RD2ZnJGVFe24zN/rOZCSMnQPOehDVb0Ja71mo4PNELIm6EZrzvAFLZGh/43sIsapPA=
Received: from MN0P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::23)
 by MN0PR12MB6320.namprd12.prod.outlook.com (2603:10b6:208:3d3::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 08:25:48 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:208:52e:cafe::b5) by MN0P220CA0011.outlook.office365.com
 (2603:10b6:208:52e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Tue, 1 Oct 2024 08:25:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 08:25:48 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Oct
 2024 03:25:46 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 1 Oct 2024 03:25:44 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <Prasad.Kummari@amd.com>
Subject: [PATCH v2] xilinx: common: fix script address for Microblaze
Date: Tue, 1 Oct 2024 13:55:37 +0530
Message-ID: <20241001082537.830286-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: padmarao.begari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|MN0PR12MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: 136868bf-825d-4697-7c11-08dce1f2a72b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OYi0+8lRlBRfCKSVpnFM4vm+tNh6TDQE4KT7K3wuxNc6xFthdbQnlu8AtXYa?=
 =?us-ascii?Q?/vFwl4YpwzMxBQZVz5mjJRsf7DojDgfZ0nD/e3EJ4QS5HEqCuW4/hoy0SgbL?=
 =?us-ascii?Q?WWBK9MvtpKD3rCkFQM2fz+pSztzgXHNIOJLGi2semAB1cioq53CcO0PpcxsL?=
 =?us-ascii?Q?2IFcJqmP4p//t4X028/3ZjYlJP8Tbzy8UMkX2vQutGgTmrMW+36gSCN0sCwa?=
 =?us-ascii?Q?h9NBpibZuOifW1BHC5xf9cgEU7N0EInp2hPjBY5VHr+EIbFUQJH64kqK64MJ?=
 =?us-ascii?Q?zbv6qfR93l8RK3CNVA4AU2eiz8T/bUSTP+gXL+d2K5OchQV3JT5VjHvG9kCd?=
 =?us-ascii?Q?f3aq3/BFGymFR9ThV3d2QtF5Fe9deCkoh93u4za5MAyzZMjXZkHd2+cbMIfW?=
 =?us-ascii?Q?bAOrqHJJrRS6cHmIKHNinj8a28r2h61tTPtvNjk3/k8gXSZJmmcW/5FaLtqN?=
 =?us-ascii?Q?DXjZS2fIEVUfZMyk9fpD7EtOK69Zxfydpu7sAt+z39jxnkMx2fbEyTisUsb1?=
 =?us-ascii?Q?V/UgHvZDF9fB7EBBcMTjQlro8mbsACUuWV+tx9/A60Ff5x7qNDNRaXWw16cy?=
 =?us-ascii?Q?s5xPlvTKvfUmoMmk7bjOnTjWloAaRRETdVB9AlCrcCUmt8J0+NPT3wq0+QNO?=
 =?us-ascii?Q?xgwLvbrYbXLlIvU0Bbv36h92UtC09hlJDso9MacZrgk+vUGWALTbQaMPiuo7?=
 =?us-ascii?Q?Q9SM4P4GDKi+uh2ISPAdBXjWbNl5eiEw2na2yqW6oVdsoUerEZT6czCsVQ/F?=
 =?us-ascii?Q?x9abqEnGEGWIl2UKk6RL6ignu7BRlHbueCYM1bEc31Guzj+PqKuDD+cKe2fZ?=
 =?us-ascii?Q?NgBo4lYSZ99PE3K4Fc3e0pRj8uxfIUnc47Xp7KdCkn27X+y/jJq/3Q1WTW5r?=
 =?us-ascii?Q?1+20w3wViUP3vatD+7ZyhDohkLoeohNxLOhqes/ijX+wmJyEinQPZaT3ZQx/?=
 =?us-ascii?Q?1tk5fLtk22ZgMWRGeP4f5OrfsAo6unPWBdAx5UnlqQb75qTMJTFQgk5gk9FZ?=
 =?us-ascii?Q?+OgHRwhYWt29vdIdaKHTJbqjMn63HhSUlPHEBfbFZ95nEg9GO6lwtI4a4qw7?=
 =?us-ascii?Q?oJWseT7vvTCHIkX5H+iCfORak1ZGyaw6JGn+tf4ELs2jlE+zTho8BoFg6uII?=
 =?us-ascii?Q?bmgD2RWXvumRaVwlufKqysQ7jWcec9dFiZ2RiCmHWQjYEErAgy+iY2nPo1NG?=
 =?us-ascii?Q?F16b+GfjO0DcraXD5X/qcZvVKqkMOIerk4Nsf7gw/uO656fhWH6+XU6PYeDe?=
 =?us-ascii?Q?ehzAXTXB1I7uxLQ6DK0JYcpaVoCQtW+9jsGtfQMPBcf3y7cv5eCoPMo6Xx1j?=
 =?us-ascii?Q?Z/tAe/J66VHSWDL2zzYTgF+dk5hoQ7K95X3jd4hPqak6iKZGjQzgXHhP4QJx?=
 =?us-ascii?Q?ME5IS9hjyQ4OVunTjUZY2/MxXE0WPDEk1heJkDkRBBBKLXA1zxYsg4bKdXjp?=
 =?us-ascii?Q?7sv+UL/eaHNqZH0aFDqVHQrGguBBZL9s?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 08:25:48.1966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 136868bf-825d-4697-7c11-08dce1f2a72b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6320
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

Fix the issue introduced by commit 067e0294806e
("board: xilinx: Remove conditional check for Microblaze").
The scriptaddr should be physical location not really offset
from start of DDR. When U-Boot is not found boot.scr script
address in device tree, then it is assigned  based on script
address  and ram base address for Microblaze and i.e exceeding
DDR memory. To fix this, the script address is assigned
initially with offset instead of address. Later it is added
with ram base address and gets the physical address.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
Changes in v2:
- Update commit subject line
- Update commit message
- Change only for scriptaddr
---
 board/xilinx/microblaze-generic/microblaze-generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/xilinx/microblaze-generic/microblaze-generic.c b/board/xilinx/microblaze-generic/microblaze-generic.c
index 2b035d5358..696484a012 100644
--- a/board/xilinx/microblaze-generic/microblaze-generic.c
+++ b/board/xilinx/microblaze-generic/microblaze-generic.c
@@ -57,7 +57,7 @@ int board_late_init(void)
 	max_size = gd->start_addr_sp - CONFIG_STACK_SIZE;
 	max_size = round_down(max_size, SZ_16M);
 
-	status |= env_set_hex("scriptaddr", max_size + SZ_2M);
+	status |= env_set_hex("scriptaddr", (max_size - gd->ram_base) + SZ_2M);
 
 	status |= env_set_hex("pxefile_addr_r", max_size + SZ_1M);
 
-- 
2.25.1

