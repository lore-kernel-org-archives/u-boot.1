Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B99E70717
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 11:27:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6900486BD6;
	Thu, 21 Sep 2023 13:25:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P0m9xiD5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A145086AF7; Thu, 21 Sep 2023 13:20:59 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::613])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 912B1864C4
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 13:20:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yl6LZLHll2pFb/VmgsBRIC8qKJu5pLcjYiXk/cNkXSgdMF/+AqQOg7RGT+wDNkBJZfwUrk9h1uryEmPcfOOOtNbtWa+ybIx689JZ0weuQq5ZpvtT5LZ3Ral8VdwMLMh3v+rqDyqNKdO6WTEWhDyVSBS/xG7W4AtNFtNkKRCkTVh+RynUpkUCL2iICw5QSzkNQL2Rq51+kG4/cRSeTlVnLLrEgQ7dOnJmH2PsHEwyRiJ+693q1e6veHowv0FYERH4JXD8tL9igwJzDrohEooT9ZqF0TDWmzeCGjyZH+DzR4YNvPD8pk4/bvpMQvuIjgzoeC3M1MdNNWhinHPQkWE0+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTGLCCZbc+GSKzUZgEc/DWfSLVxNivWM94k4I/WiPpI=;
 b=iAoSA7Rn7j0PKazcV+H1cOVv031KmUNk35F/f4tUGiqGDvPeWr5YrcXMi29xqtAlbjjbRavDlSRwrTc7Fed3Ac4Xe8kgE2eF7+z81fCloRI1k/brFmAoZDKASCffgPjQ9tQzqZyMDTBJrRR1eEtsWxWOAS0QDrpdA4XRjyox26DY487TLELtAY4twEiyHNNsQ8ggflYsEVtoYilDHeNkJ/omtQ8Sr3RmayhJ9IPW3aHwe/G5kHATH/W0xNYfk42/frZg3sQ6t3Xdn0LZl/sIEpN/m1m6l9vWVGCOHY+2fgNYXWo4roXIizIM9zVJ8UgClAwg/nzUcctkvZJDzmxxoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTGLCCZbc+GSKzUZgEc/DWfSLVxNivWM94k4I/WiPpI=;
 b=P0m9xiD5TsDNidfiMC4u5V2xV6JqbibhN1cQZP7OZjY0GuvdBr8ya7fd5KjO5ysLGchSDJAXPvDivtHF9xOvvfgAso5pL0Fmcc7BLWiNDCghAw33d+7BLoL5lM4X55nOyVItTgXOApVxkA/NLfUZEjXQgSpWMLL/3xiEhnSfoK0=
Received: from MW2PR16CA0060.namprd16.prod.outlook.com (2603:10b6:907:1::37)
 by SN7PR12MB7836.namprd12.prod.outlook.com (2603:10b6:806:34e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.38; Thu, 21 Sep
 2023 11:20:53 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:907:1:cafe::bd) by MW2PR16CA0060.outlook.office365.com
 (2603:10b6:907:1::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.31 via Frontend
 Transport; Thu, 21 Sep 2023 11:20:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 21 Sep 2023 11:20:53 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Sep
 2023 06:20:51 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Thu, 21 Sep 2023 06:20:50 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <sjg@chromium.org>, <git@xilinx.com>
Subject: [PATCH v8 0/2] Add support to fetch baudrate from dtb
Date: Thu, 21 Sep 2023 16:50:41 +0530
Message-ID: <20230921112043.3144726-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|SN7PR12MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: 29a68a46-eeb9-44d5-98d2-08dbba94d151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ILpQ1veUaEN4watkIyuPOq5NChmvqS9n0dS5MxRCbQV/c7N98GNwySIA6hwXZ2sve4QJ3Bn5p8TLvqOdm6geUpigoB8TfVLFb8IrjJtMsc0xVgox4J9WOtc7LfqHTULiX4MWd6ZmbS49CbKXZijv8c9b/qbaiROVDSxvMr/FjQ59747LEBhmWmxjwWKftCCAXMRJUINa7vbyPw4k/z7XCV/D7oiNm3KAUnk6W/1BVGdMSvthDZ71NBU0laTy7kz9RUJ0NlDQYaYCjnkAssCdPo8OMLKZLYSmnCNKsJzgkJXX/yzJmWy1wxEX1TJ+bFhjIIZ4NF5qhUoMJX23LI0QyPh4llBa3Bu+LqDxB+l/fl4ExZ87F3Gz/sMNa7cSzUES+LuvIo8FacHd8pq9YBG2ig3UxSaL1Qtuns/l5XrEcvsx+Y7zcaKrpppHN1jiPnA1hGfBLc3U49ZfNfy3l//y4vW5UkrlZOMd4SMuFuXGad3L+gjeqtzSkQ9osdMrunVg+IuryPdwvchnvhmZpvXK/Yb0A/5+tKEKZte0B0hCL43F5U+NZQdhhRZSvyCzSUr9D58l6p7yz8g+fBRUGe6gpntkB57Hotebfa+cxJ217wNJxpf39zzaouWOCgsfdKF175UEzW21WgBnoh0imLd8UrtMC3XHAvhcENQ6I5yPoJCcCCqSGIVr6HmaN7wdhm0/sVNp2bfAyuiz9OW10/IAVv+V9be5NvM7bjwmcPj6zia7LDf8X91+CJK6FRnSGgQ5reaWzaCaPKut8s6nS1574Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(396003)(376002)(346002)(1800799009)(451199024)(186009)(82310400011)(46966006)(36840700001)(40470700004)(40460700003)(1076003)(107886003)(26005)(4326008)(8936002)(8676002)(83380400001)(2616005)(2906002)(47076005)(5660300002)(426003)(336012)(40480700001)(36860700001)(36756003)(86362001)(82740400003)(70586007)(6666004)(81166007)(356005)(41300700001)(70206006)(316002)(478600001)(54906003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 11:20:53.0425 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a68a46-eeb9-44d5-98d2-08dbba94d151
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7836
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

Changes in v8:
- Added test to cover fetch_baud_from_dtb.
- Changed this check_valid_baudrate() to static and removed 
  from serial.h
- Fixed the compilation error.
 
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

 arch/sandbox/dts/test.dts                   |  1 +
 configs/eDPU_defconfig                      |  1 +
 configs/mvebu_db-88f3720_defconfig          |  1 +
 configs/mvebu_espressobin-88f3720_defconfig |  1 +
 configs/uDPU_defconfig                      |  1 +
 doc/README.serial_dt_baud                   | 41 +++++++++++++++++
 drivers/core/ofnode.c                       | 18 ++++++++
 drivers/serial/Kconfig                      | 15 +++++++
 drivers/serial/serial-uclass.c              | 49 +++++++++++++++++++++
 include/configs/mvebu_armada-37xx.h         |  1 -
 include/dm/ofnode.h                         | 14 +++++-
 include/env_default.h                       |  8 +++-
 include/env_internal.h                      |  2 +-
 include/serial.h                            |  7 +++
 test/dm/serial.c                            |  1 +
 15 files changed, 155 insertions(+), 6 deletions(-)
 create mode 100644 doc/README.serial_dt_baud

-- 
2.25.1

