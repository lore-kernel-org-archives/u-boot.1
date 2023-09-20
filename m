Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A4BCE79AD
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 03:43:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3287F86C4A;
	Wed, 20 Sep 2023 05:42:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Mb7yhyGq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D701E86A38; Wed, 20 Sep 2023 05:28:01 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::62d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0712586C15
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 05:27:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZ08R857YOKvvv8EYBAKDgWT3BrdJkD3O5IaocGHRJavs6c6mpgVtfHT0Q6iiUAtnPUB2rYHDjPkbt9edfy32sHEio+6KOgQXSuwCXZ3Mn5mXfKW5XpYLWb4d/1sR/4MJ5A5JK7pvpxrjca0O/7QcMLXqKmWl/xfXJWoWF6oSir0ZbsYYluMCEDi/zGvttapsk0x22BKm458fA3/GSQ5J+tUFWYnzki6wju8nPnEIa5/R/ewSwAx5krPepVSncxN2FZeTzr/67wv+Uh0oSbxvKkukzdXQ2wOjeKTS8lau3ser3sZRbquN9x1NUrltIuM3Y8QQIfsNnzg6fEVO4u9CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+01UZCMNsz+8xbnwMQkfGV/yfqTfBN0UHf+xih7z/1I=;
 b=bJgzEMLC/F8oTbJDetO6Jf4xEEwbwATDZmOeIfNEAg5AdbCqYzHVPRmIuhDblM46MuUdOTtRIWbxSar8eXMZEYz37wAWo/WCSaGBlmT5Ptx6M7bNEFDd5Z/KQHg+XbzIY3zTF2tIkyAbx0XgCO+DRRPncSq4US3EXQFc7qU7G5GVuF72uA4w17xG+qRQP0KUFwizkoDKFtcF9UJpqM+LP4UJxjAggcgQXNi2jeljw1CWeRWcDBVpyPbqKVcs2ds7dGtv62vR1ETLJCucOqroNrOuwSChEqhVz0jBpqiEZZJgC9/WhXMWyjMGqnV8yOHKxlD9VsntkSJvY0ean+xIGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+01UZCMNsz+8xbnwMQkfGV/yfqTfBN0UHf+xih7z/1I=;
 b=Mb7yhyGq/bJ59BNBcUJli0FfyFK1GUvGb5TB2z79Pc9fsNBY/TQVqk83Z78UfeotkEE99zeRavzMUGzCWN0G+GR/ks7grUcq++eBUpbV5H9grhd1NGtWsBtbfzomV0eZCtY1yzLv4gthTuVsFcObixc0ESGDpXOg+iyKOU3+ALQ=
Received: from DS7PR03CA0233.namprd03.prod.outlook.com (2603:10b6:5:3ba::28)
 by CY5PR12MB6130.namprd12.prod.outlook.com (2603:10b6:930:26::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 03:27:54 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:3ba:cafe::8) by DS7PR03CA0233.outlook.office365.com
 (2603:10b6:5:3ba::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.29 via Frontend
 Transport; Wed, 20 Sep 2023 03:27:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Wed, 20 Sep 2023 03:27:54 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 22:27:33 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Tue, 19 Sep 2023 22:27:32 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <sjg@chromium.org>, <git@xilinx.com>
Subject: [PATCH v6 0/2] Add support to fetch baudrate from dtb
Date: Wed, 20 Sep 2023 08:57:23 +0530
Message-ID: <20230920032725.21748-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|CY5PR12MB6130:EE_
X-MS-Office365-Filtering-Correlation-Id: ac2bdfd7-9561-4cd8-e9c7-08dbb98993ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 32+6HXeNlkMUOdkMi+4pTyCt1Ur9r7++dEuq//sD2d9fH6NzZ6Mr6OHCMQoNr/YxHNuqBuWHtjBKBRTEbSq5mJil8HIOfTvPXWi1TYU2GeNrnre/ZJflk9pfm3IfwN3svjhAqc1BEC5vY+T2aCC84B0/gaWn15JylgzGJrzFL1cGl45Hd7ESeON5trRmE50IbpmCUOe4ZZ2SXHQtYsdEVzQoywYX2hX0xTIqSBS5iO0UEqEofWomngJe9EAnDNJoPDuM/Q9YPinvrydOHNb6r6SzFy4oVuMGZew/W8HQdtDnswPtWYYFSTqEOhVpixg3KCKCNWJ62mwhICOm+AdSeUY2bYSPTMobZe6v3IsUU39SIW8aL5758toedy1s9XTjgVbACSkUpHa15S1TkeKcmuAfQEa4JsV07vEU+i1CIVJ/gCCQvNe60TbK9WccG7YjDkG8z7dLMt/TOUGlsoxJsDZgluiw5PmJOs4q3wI6kvHum/oFUbNz70ScCjiuQ9Bp+b6M1ygEaatIgSCl52chNhXNuntMcBh98pqI8LoetZUIjU/OUJuGcHk3XcAz7qEvW88iXsA466bIVZ6l4E1vkFr6LMdI+8p4YmPTEp005IwhSSLiPrUaCHzXXU/lumS0fvYAdZSr0QnBVcCot4FX98FBMnqkArPffvaXg6QBrHOYp0efsAd5BfnTAPVyy1AT0E0gYMtN1r7Co/1PgeLlURGL3c1Hlf+41f6G+k0dUuFXA21s5LGRlhS8HqaI0LX5o719HutdTDTtbN3oeByZow==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(1800799009)(186009)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(1076003)(107886003)(2616005)(26005)(426003)(336012)(5660300002)(8936002)(8676002)(4326008)(356005)(82740400003)(36860700001)(83380400001)(47076005)(478600001)(6666004)(81166007)(40480700001)(316002)(6916009)(70586007)(70206006)(54906003)(41300700001)(86362001)(36756003)(2906002)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 03:27:54.3745 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac2bdfd7-9561-4cd8-e9c7-08dbb98993ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6130
X-Mailman-Approved-At: Wed, 20 Sep 2023 05:42:43 +0200
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

In this patch series
- Add support in Kconfig and convert for armada boards
- Fetch baudrate from the dtb and update

Changes in v6:
- Changed Kconfig OF_SERIAL_DT_BAUD to OF_SERIAL_BAUD.
- Added IS_ENABLED() in place of #ifdef CONFIG_OF_SERIAL_AUD

Changes in v5:
- Adding DEFAULT_ENV_IS_RW Kconfig in missing files
- Updating DEFAULT_ENV_IS_RW to CONFIG_DEFAULT_ENV_IS_RW

Changes in v4:
- Moved SERIAL_DT_BAUD to another patch
- Added doc file for fetching serial baudrate from DT.
- Changed Kconfig SERIAL_DT_BAUD to OF_SERIAL_DT_BAUD
- Added function docs wherever required.
- Moved changes from fdtdec api to ofnode
- Changed serial_get_valid_baudrate to check_valid_baudrate
- Added function fetch_baud_from_dtb to fetch baud from DT
- Used dectoul() for parsing baudrate

Changes in v3:
- Add SERIAL_DT_BAUD to Kconfig
- Moved DEFAULT_ENV_IS_RW to Kconfig also updated armada files
- Moved filler changes from zynqmp.h to generic file env_default.h
- Removed ENV_RW_FILLER and added padding in the generic file env_default.h.
- Print baudrate parameter properly when SERIAL_DT is enabled.

Changes in v2:
- Changed to #ifdef from #if CONFIG_IS_ENABLED to enable patching in spl.
- Added SPL_ENV_SUPPORT dependency in SERIAL_DT_BAUD to allow SPL compilation.
- Moved DEFAULT_ENV_IS_RW to Kconfig also updated armada files
- Moved ENV_RW_FILLER to generic file env_default.h.
- Increased the ENV_RW_FILLER padding to support 8000000 baud.

Algapally Santosh Sagar (2):
  configs: Add support in Kconfig and convert for armada boards
  serial: zynqmp: Fetch baudrate from dtb and update

 configs/eDPU_defconfig                      |  1 +
 configs/mvebu_db-88f3720_defconfig          |  1 +
 configs/mvebu_espressobin-88f3720_defconfig |  1 +
 configs/uDPU_defconfig                      |  1 +
 doc/README.serial_dt_baud                   | 41 ++++++++++++++++++++
 drivers/core/ofnode.c                       | 18 +++++++++
 drivers/serial/Kconfig                      | 15 +++++++
 drivers/serial/serial-uclass.c              | 43 +++++++++++++++++++++
 include/configs/mvebu_armada-37xx.h         |  1 -
 include/dm/ofnode.h                         | 14 ++++++-
 include/env_default.h                       |  8 +++-
 include/env_internal.h                      |  2 +-
 include/serial.h                            | 15 +++++++
 13 files changed, 155 insertions(+), 6 deletions(-)
 create mode 100644 doc/README.serial_dt_baud

-- 
2.17.1

