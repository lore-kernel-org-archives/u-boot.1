Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81390FEDA09
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 01:21:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C184284105;
	Wed, 18 Mar 2026 02:21:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="O0hbh9Sc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8B4B840CF; Tue, 17 Mar 2026 23:40:28 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BC7E8418A
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 23:40:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wg+4Rp4hONZMJ3+YwJg71PnDDLBjyI8bn6h3uzRsifRoRD/xp0hg5MX7CJ/9Pge3g2mcs+H5bnb5cXzuB9R6ZJ2sd//8x/p29NGc7p1ZtA16bJQFF4qE1vimg6i3Fe4mH4Xt7EWcJ/Znay3WlNyxdGb3L4Aota498hfw1NrQzCVH5XQAIEw5N9C2P/nkhAQXFbibz96k9Zp78afc99P9wsQmuz+DzDxyn6jkkPVyXmT65w7BZqqlkwd863z+utFi8K2IQfoP220FMAfqUX7BkwDN3rL205nUk7Gams/qvQy43bh2EOiv97uYwG3aJ3By+0xmFbpky5xS9rCUuxJBtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhSJM07t3XXwrkN5whTMu+mktrwXIq1lC+4uLhoi/Mk=;
 b=R9XZmaqsWdJ/d0JkYU2Ep2nyl9OCDKHYC0HkyHyZgjYvMworXktG5QqziLem4TacBi40CpST0z3C4p/iVTy5UkrxtIRy+GrW+bPZRHIGmpGtXgxzCMd3mXFwGlJaOhAGcDQjn0smITWcPh5denQKOVunzav5QlOzhwn8noXul2Jv5scaiG1+vwi/qfZQNRUFny9osrry2R0IN8pYBmL6TOYZ273zlDKCIQkXHL/VzDfM6qQVWpfj7kBtzotmim0KbgYa6QlrJ8JKt8QrMmQA7qBI4MWe3bMQvTH8EJOhmDPkNR+X1WxWrk0SQUucTAxGuK5di3oBHrqiwo/d5hTw8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhSJM07t3XXwrkN5whTMu+mktrwXIq1lC+4uLhoi/Mk=;
 b=O0hbh9ScRmSwyyaBBqHkIcuJJNYRu54pQ0yytgGV/bi4ty/gST0AdBK54N1L3xRwMziZtdk6oRyA7ggT1qqTfvHcG7B1Al95K+mzVhDhpjY/zPP9eqvKf9XWbZCyty8Q9QbBxD5Ap8/AWDv25RF/48oDxJ93X91GnQA5JgWALkM=
Received: from PH8PR22CA0020.namprd22.prod.outlook.com (2603:10b6:510:2d1::27)
 by IA6PR10MB997585.namprd10.prod.outlook.com (2603:10b6:208:5e2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 22:38:41 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::7e) by PH8PR22CA0020.outlook.office365.com
 (2603:10b6:510:2d1::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 22:38:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 22:38:38 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 17:38:38 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 17:38:37 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Mar 2026 17:38:37 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62HMcb4j3952594;
 Tue, 17 Mar 2026 17:38:37 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <bb@ti.com>, <nm@ti.com>, <trini@konsulko.com>, 
 <afd@ti.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH 0/3] k3-am62-pocketbeagle2: add board and variant support
Date: Tue, 17 Mar 2026 17:37:57 -0500
Message-ID: <20260317223800.776581-1-rs@ti.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|IA6PR10MB997585:EE_
X-MS-Office365-Filtering-Correlation-Id: a5930b55-4abf-4b88-723e-08de8475ef03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: L3xzvhjMv0vHLZEGky/j1a772rjjwL19XdKYgsDYWUitaUULsqx5ZvyOy8KaXy++32jU2Qd9SnwOQtSL31954hNi3RXDfC6rA/l1jXo/aFfFsaCzLGwTA7ycuRe6vTl5cDMYYeOl24GjDjm3/3bUJF/cVcnlt54aBeGCPXyH9d9pESrf0UzWCbFmI0Lwa+0cX5uBModVT13BwJmmn2qRGMMwx3w73v/MWC3EcH5pECRO2G0ZEJvK2Qry3JyzeHR8CH23K9bjQWBqLl3qhaKpf5Qc/VKyXAfaCxTJ+PvgGFis8oGVwu9kSV4JvnAcH825FHfWrYr3CO9ACC4KgItgHgKeDFiqINxTRTrt6PZbuwIQqLyIObIuCnJp0WXanyWF8IzQ1HQxAE08eUHXaJ8kP/QfYKefToYYe17PV1gShh6vojffHzgAZDekfid4OWt2arYJFsr7aynaT9EQNrup+upBMVx9II7j5N6tubY8Sk872voYo9qC8YwVqaRZ1LamBDf7hIM0fWL/HGnshGQj72h2qhoiPIE6De0N5ZPef8Zs/m+6ZGhzHrgsHLH/lfWDxo/A7EX68e13MYHJ+DYhcuKWPmeYooRjjDdBPjyJRds2nlBjzCsdpjYp5yUQemGul3ZLA+unEfbm7XJdohmcV7MG0B6vtBryIjy0zQIPtm7pJd8328vpfjaKXjldh8CtIq0dCHWOLYyF7K9LBUDzIlM+yx0VFHns/aLgWh7jZk43RRF2bTsuNmHV7j9aoI1ldjm3+23VxpiBhfbJyMo47cSRSORouw0KLSoux8THE/M=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Vboabvtwo+8FwI5Pg10b22Z86g28dw0uC9opdt9j+QfS8NYUceLr2nExjDlV7CsLVZBOr7YNF4FfinwAToXD7NjK+7cpsx8shtLZ6cNabZV5YrXhVHmIaW63yDwn1W9h4/OfpVjVNj128zFfL0thRDK8p+QsZScQWfgF9yF6bnOwFdRQ3y3t6Eo4AK18bHOphHMzjGRycwiQ1h/mBnleFnvcFI6vYV0jTJvoyAcMiVEjwFp4btfKImK95n6YDa2Z/HXpL0ePNR2hNEcCBvpgvz4g9BzGHp4PgO+tFixDwtHgNFoKC/34jorh+QW/xaH0V5uik1YXtxu27zNoJZ6GPA3j6MzS04OCTM8/IcxQ9cArcP9bLwLVnbaDF1jbD93Zx34IVNsWcVlFfz0EPZKbkIBglQVNfRET0ugQqgmpj/7tXT9oOtSEqOVS+z5f/amI
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 22:38:38.8507 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5930b55-4abf-4b88-723e-08de8475ef03
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR10MB997585
X-Mailman-Approved-At: Wed, 18 Mar 2026 02:21:10 +0100
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

From: Randolph Sapp <rs@ti.com>

Add initial board support for the PocketBeagle 2 from BeagleBoard.org. This is
based on the current official series from Robert Nelson [1] and work from Bryan
Brattlof [2] with some light modifications to protect against certain
configurations changes.

This borrows a lot from Phytec's current DDR fixup logic, as that seems to be
the most complete implementation of a dynamic DDR correction for K3 in tree
currently. Thanks Wadim Egorov and Dominik Haller for setting that up.

I've run coccinelle, checkpatch, and qconfig. That being said, this is my first
contribution to U-Boot so feel free to yell if something looks off. (I may look
into getting qconfig to respect that defconfig include logic in the future, as I
don't like it's suggestions currently. Let me know if it is intended behavior to
flatten that include into a single file.)

[1] https://github.com/beagleboard/u-boot/tree/v2026.01-am62-pocketbeagle2
[2] https://github.com/bryanbrattlof/beagleboot/tree/b4/pb2i

Bryan Brattlof (1):
  arm: mach-k3: am62: add &main_uart6 to clock and pwr tree

Randolph Sapp (2):
  k3-am62-pocketbeagle2: add initial board support
  k3-am62-pocketbeagle2: add support for 1GB variant

 ...> k3-am62-pocketbeagle2-ddr4-1600MTs.dtsi} |  92 +++---
 ...dtsi => k3-am62-pocketbeagle2-u-boot.dtsi} | 154 ++++++----
 arch/arm/dts/k3-am62-r5-pocketbeagle2.dts     |  35 +++
 arch/arm/mach-k3/am62x/Kconfig                |   1 +
 arch/arm/mach-k3/r5/am62x/clk-data.c          |  19 +-
 arch/arm/mach-k3/r5/am62x/dev-data.c          |   5 +-
 board/beagle/pocketbeagle2/Kconfig            |  86 ++++++
 board/beagle/pocketbeagle2/MAINTAINERS        |  10 +
 board/beagle/pocketbeagle2/Makefile           |  11 +
 .../board-cfg.yaml                            |   0
 .../{beagleplay => pocketbeagle2}/pm-cfg.yaml |   0
 board/beagle/pocketbeagle2/pocketbeagle2.c    | 147 ++++++++++
 .../pocketbeagle2/pocketbeagle2.env}          |  21 +-
 .../beagle/pocketbeagle2/pocketbeagle2_ddr.h  |  50 ++++
 .../pocketbeagle2}/rm-cfg.yaml                |   0
 .../sec-cfg.yaml                              |   0
 ...onfig => am62_pocketbeagle2_a53_defconfig} |  16 +-
 ...config => am62_pocketbeagle2_r5_defconfig} |  12 +-
 doc/board/beagle/am62_pocketbeagle2.rst       | 277 ++++++++++++++++++
 doc/board/beagle/index.rst                    |   1 +
 .../src/arm64/ti/k3-am62-pocketbeagle2.dts    |  43 +++
 .../configs/{beagley_ai.h => pocketbeagle2.h} |   8 +-
 22 files changed, 854 insertions(+), 134 deletions(-)
 copy arch/arm/dts/{k3-am62x-sk-ddr4-1600MTs.dtsi => k3-am62-pocketbeagle2-ddr4-1600MTs.dtsi} (97%)
 copy arch/arm/dts/{k3-am67a-beagley-ai-u-boot.dtsi => k3-am62-pocketbeagle2-u-boot.dtsi} (53%)
 create mode 100644 arch/arm/dts/k3-am62-r5-pocketbeagle2.dts
 create mode 100644 board/beagle/pocketbeagle2/Kconfig
 create mode 100644 board/beagle/pocketbeagle2/MAINTAINERS
 create mode 100644 board/beagle/pocketbeagle2/Makefile
 copy board/beagle/{beagleplay => pocketbeagle2}/board-cfg.yaml (100%)
 copy board/beagle/{beagleplay => pocketbeagle2}/pm-cfg.yaml (100%)
 create mode 100644 board/beagle/pocketbeagle2/pocketbeagle2.c
 copy board/{ti/am62x/am62x.env => beagle/pocketbeagle2/pocketbeagle2.env} (59%)
 create mode 100644 board/beagle/pocketbeagle2/pocketbeagle2_ddr.h
 copy board/{phytec/phycore_am62x => beagle/pocketbeagle2}/rm-cfg.yaml (100%)
 copy board/beagle/{beagleplay => pocketbeagle2}/sec-cfg.yaml (100%)
 copy configs/{am62x_beagleplay_a53_defconfig => am62_pocketbeagle2_a53_defconfig} (91%)
 copy configs/{am62x_beagleplay_r5_defconfig => am62_pocketbeagle2_r5_defconfig} (90%)
 create mode 100644 doc/board/beagle/am62_pocketbeagle2.rst
 copy include/configs/{beagley_ai.h => pocketbeagle2.h} (57%)

-- 
2.53.0

