Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC02AE776F4
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 03:17:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A52BD86D62;
	Tue,  3 Oct 2023 05:17:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0jy/7gLh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B25DD86DE0; Tue,  3 Oct 2023 05:17:37 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94D2286D52
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 05:17:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=foNd/iGR+Bjeb7juq6Qy0GMAWLpaei7IwmlVsLyu1qzOHTcdY3TlUdfo/GMrL6ssxyqJBMBESdQLxAEsFntD9+xCGvsvUwC+OGfY8KrO3dBM9XxM2a4X27StxXBmMUKqYRZOWwLJbVpBGb+F35Nu2uVrcc8B0uGMSFwIIR4lB19GTUrnkrKAyz5uyssCqQ4m+h42K50vZAc00trncW0eV1i9NeihpikQwfUgEpewF8CLLBfZv6uy5+seCxPmYohGcSaB88wBu+t3Zej3JngU+Hs3JxDO8xLrov2EUAeN3G5Mf+qQOr5L96Q+yxgc6g8BAIeSwvL4QuRwwjwhvPTHIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKSC5Savayxl0eZxRbG0Fh0YG5No+PWqutPVDP3MbmQ=;
 b=XFXbaQ1kvgROoH5iC5KD9Uu4L2R6qPy3PgKSx/5VzljHe3hnbcV6q41419kKPHNaf9e2v7wx8Jta9Q/5P3dnaiJbam7JAQQsmBnc00K5hl24UdwncvuXmHjeprBthAxfsK6+hCnwE4zZVpy/qvTiBGyR+dnmavgtgbThejJvrHEFnLvrzLUNOCArx8hHZoz7eTYlJzLPtt8zQPSytOEc3GSga8k2kJvx87hB4jZOrRA9jToweRPftf2clbaQy8Eof/cP2NEPYhk2N8UgaC7a7A+a0W7yq66Q5i1yb+ZWfyObnlSUfUHe3NwpUF+eFhb2+kaFcZTjjgdVNOLRsFdp2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKSC5Savayxl0eZxRbG0Fh0YG5No+PWqutPVDP3MbmQ=;
 b=0jy/7gLhWnd/xB5ZWvQ0QV/gzR5S5ry3WDFSkrwomVf/WY1e8vr4JbAZsf0NWXofeBwi1/UtqTk1h+W6KawlUhN18urQK6RlMe9eSMgy+znP7PqGLbx0D8Q7b+Q3N0WcNm7haELo7/EvNiZE6vDO9RIsXO0Y96pEfCjjJALODdo=
Received: from DM6PR02CA0132.namprd02.prod.outlook.com (2603:10b6:5:1b4::34)
 by BL3PR12MB6545.namprd12.prod.outlook.com (2603:10b6:208:38c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Tue, 3 Oct
 2023 03:17:30 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:1b4:cafe::4a) by DM6PR02CA0132.outlook.office365.com
 (2603:10b6:5:1b4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Tue, 3 Oct 2023 03:17:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 3 Oct 2023 03:17:29 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 2 Oct
 2023 22:17:29 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 2 Oct
 2023 22:17:28 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Mon, 2 Oct 2023 22:17:27 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <git@xilinx.com>
Subject: [PATCH v2 0/3] Add spi flash lock option
Date: Tue, 3 Oct 2023 08:47:12 +0530
Message-ID: <20231003031715.5343-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|BL3PR12MB6545:EE_
X-MS-Office365-Filtering-Correlation-Id: 33e29e03-27a8-4497-9fff-08dbc3bf46cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w/LyhuxzBJ5czCwVenJzoCpFbdQ6h5kUL1oRAlQIIRAuGl6IG9CW0ZBfePFqSpLRC3785s37CWU3AwAJ94dPRfJHPAXYfUjO1PYj+gBNjrG3YV6BbcIXpEhuIRfmHxdtIlZvIBcMqOHrBjLQ1WXKbxo6YQQtc5e82E2m09v8g/8h4q91tPkXy5/rWX5cg0fsIMys4L9uvLlVRj/rpMdGwHQ3LPneCenhm8l0WOZ/jxedUYBYIhnVXe9qcxgaGyzGvT8VvopnTnkbssQKFy0FS+W3SHe8NSO07eV/wVtXA9FARzfOlAQsWxFCG6VQMmkwq19nwswG/6B7+xbtNJnxy90H2V3PmDyLfscZho7umLCfOCYufxS4ZPlAczPzlMnRfpNPIWcnb8XAOReOjAtMH46Wy5sjqNugViLN6XCGf49i+N9vRQ0EFNAm/ZrPBQEAOu2gzRfzthkaYWbL2ioT996z1PkpDSmpQp3npYFJQL1Hc3E6qhFun83nOik4Mc8TiI/0fqr2K7yc0RFYslwmfGzU6xGBmnMTFLW/CzfxZYbOodXyBLI5JY/4POmBlrc+CXLXyfMT6Mp02Yp4WpJ6E6ChS4p8wPG/FMn8b71MTBQS+XXpKrktxIGeWEqStW1hxdBiAcmcVMuEEXjCp0pbXJnsbWSm9k11DxsuJBcNL0rKGbGLWbjKjkWQABEF+93Ahk6yzA13Dx3ms7WBsYwdfR2pcebvj9rM5TPCYY+4gjfKLNqYhKags4YjX2GNA/LRYYwec+xlBqZZytczJ37J/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(82310400011)(64100799003)(186009)(1800799009)(451199024)(40470700004)(46966006)(36840700001)(40460700003)(426003)(336012)(107886003)(86362001)(1076003)(2616005)(36860700001)(26005)(81166007)(82740400003)(356005)(83380400001)(47076005)(40480700001)(36756003)(54906003)(478600001)(316002)(6916009)(4326008)(8936002)(8676002)(70586007)(70206006)(5660300002)(41300700001)(6666004)(4744005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 03:17:29.6326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e29e03-27a8-4497-9fff-08dbc3bf46cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6545
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

Disabling the flash lock option for versal and versal-net mini ospi 
and qspi defconfigs.

Changes in v2:
- Updated the commit message.
- Added SPI_FLASH_LOCK in cmd/sf.c, so when disabling this option
  "sf protect" commands wont appear to users.

Venkatesh Yadav Abbarapu (3):
  mtd: spi-nor: Add spi flash lock config option
  arm64: versal: Disable the lock option for mini ospi and qspi
  arm64: versal_net: Disable the lock option for mini ospi and qspi

 cmd/sf.c                                      | 4 +++-
 configs/xilinx_versal_mini_ospi_defconfig     | 3 ++-
 configs/xilinx_versal_mini_qspi_defconfig     | 3 ++-
 configs/xilinx_versal_net_mini_ospi_defconfig | 3 ++-
 configs/xilinx_versal_net_mini_qspi_defconfig | 3 ++-
 drivers/mtd/spi/Kconfig                       | 7 +++++++
 drivers/mtd/spi/spi-nor-core.c                | 8 +++++++-
 7 files changed, 25 insertions(+), 6 deletions(-)

-- 
2.17.1

