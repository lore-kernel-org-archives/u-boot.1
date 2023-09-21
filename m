Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DEA1E70719
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 11:25:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B11B86B34;
	Thu, 21 Sep 2023 13:25:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0YoJgxW6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B277586CF6; Thu, 21 Sep 2023 06:21:56 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::621])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8487A86BF4
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 06:21:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VeMihX19F9VuYrZ+MLgLxCfI0Nfk7hgmMnIi264KXPd2TC3QxDzfuWZiGuztyrDh+5pYV3awZX1J0zuYu58n+/yV4bHzdCdtQkfhWkdTX1S6kt969ayKb0afO8Ha9jh8LVc1pyPWZnnvmW3C1RvvSBETNPJUVsMJI+AYdzw8eWrnTFwzOpH1GhsrhLcu6+Z6y0EBchBrA4PAtrmoG59OftpVxeyEwVzUDup6S+vnVGqdITgowUVDoYnnKhEMImPb58CRyeREod7qMORbAtPBuFEtxd6GB9n0vXqwjjIpU8mtwXEBjRNYH/lztolnjqb3wtgItin3jfPFoL68wM0N0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIXoEoG/UJnaSBdXlHIzyK/rNikUDsx682/9+o0rTjY=;
 b=Q19+ZsLWTUi2BJWwbJ/RYkMCJ5PYlDI98TVPMf2flFG89i8nO93NngKma+QpdiqpdxZ1JL0tyWEt1IljsUvguOeSc5uNHR4c60Evtex8gto9/Tw3mYLbx9kDrp5xBro90hmYeitqQxcQ8YljH5vw9sPSgYAOEfHlUOPZffgu9T0tIalWnUE50TuvdOFHoc+fnh6r3r6fBmpe3lpeRef0tG0xA8fxO+wTPdv8+Rhxe5mameWcLdLzFNTjlFlBuxvXvAqNdRBV8ENwScCjt6nyrlfsCOKiNgC0htZOfBbnHf9Xvq/Ym0KCH86VI+JokMfCz2VK+BkmG4qYHPFTjPhNJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIXoEoG/UJnaSBdXlHIzyK/rNikUDsx682/9+o0rTjY=;
 b=0YoJgxW6WgPxFir9FkmdDKD0OEqHZirjyRWgoPukkmzO67GgpysPxuarPTZY6TBbTd8sQadY54BoKSB/tn4xbWY2XsRbTRFiSqwWHRrfdAAgg050WaTs2CYGo4UvbOaq+rfRi8O8zVnne7bk+/pn9pqKdEn1aGahAGfG3dkmF+k=
Received: from PH8PR05CA0024.namprd05.prod.outlook.com (2603:10b6:510:2cc::12)
 by CH0PR12MB5060.namprd12.prod.outlook.com (2603:10b6:610:e3::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Thu, 21 Sep
 2023 04:21:47 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::ac) by PH8PR05CA0024.outlook.office365.com
 (2603:10b6:510:2cc::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20 via Frontend
 Transport; Thu, 21 Sep 2023 04:21:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Thu, 21 Sep 2023 04:21:45 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Sep
 2023 23:21:43 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Wed, 20 Sep 2023 23:21:42 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <sjg@chromium.org>, <git@xilinx.com>
Subject: [PATCH v7 0/2] Add support to fetch baudrate from dtb
Date: Thu, 21 Sep 2023 09:51:28 +0530
Message-ID: <20230921042130.21139-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|CH0PR12MB5060:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f77fa77-d38b-4a9a-bf0f-08dbba5a445a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qlM8ob43jWVDe3AUtaDEwQ37FfAhHpQO9LBNtl8FhEkveyL8nvvSbdjJ0yHVJH22f6qB2EM/5Gbdkha6Yid78KcxPF4gWUPyotCP4skKKwCL4oGEr/pXNfm1Xlbhox0vfgbcBW6d8F1KtPY/gIhtRGbND00ZbQ6iVZi1czDMX0JThznN2+lMeh4KuddZ8Icj2AyqTR5Vun/EoxtIKxqbcmlINjUg2dDRI/lj3uSAJTsj6xmFOf/FfOhlfIN5JXOr4sV7b9fO44xcvetoyGm/7XKz8cR1JWIyZFq9yCovjr77obuPIocJHQJKUmlYpErKKJPa4HFTQioyP4UVr2DLTEajr5Tiy4T0CWsNlXAp0VoQWbTmdo/xze1jgLZJiBBU73+XuVicHejrE+AAAjVKnketdG7lRzYsvBiJgZPTih89QFk/WZdNdy80LVa4P6yYQyGBQ7SOsIZOVsKmstS4RzYVd8be4wCB7J5XIEwPAywHYoqsO96gmErprShlwDYoI2tyI/YsezdBe6wC4K5Uy35SLtlJ0+3fSBEcu+ycvUc+URFTqVUX9afp/lDcMJaNUjTncEB+L/whAuAeg6611vRMbyZsyOahG+9waQiF9LeDznrFvKXHL6UapLn1vje2w4x74oJNvpbgub+RIQHcalherQI0CtSf+2ni9FC5YNXoHCFS64/c+1MMnosK8lCkbzdAyRWROhAO+IzYyOBP3ouEL/vDBKYz6tWJBEQXsXvYpIy2J83duYfU9fZAsW1riZkmSeg85CGg3MuafboCIg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(376002)(346002)(396003)(82310400011)(1800799009)(186009)(451199024)(40470700004)(46966006)(36840700001)(478600001)(6666004)(83380400001)(47076005)(426003)(26005)(336012)(2906002)(5660300002)(107886003)(316002)(70586007)(54906003)(2616005)(41300700001)(6916009)(4326008)(70206006)(8676002)(40460700003)(86362001)(8936002)(36860700001)(81166007)(82740400003)(36756003)(356005)(40480700001)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 04:21:45.9209 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f77fa77-d38b-4a9a-bf0f-08dbba5a445a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5060
X-Mailman-Approved-At: Thu, 21 Sep 2023 13:25:12 +0200
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

Changes in v7:
- Updated the commit message.

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

