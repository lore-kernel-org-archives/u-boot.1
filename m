Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A123CD4F25
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 10:26:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC8238464D;
	Thu, 14 May 2026 12:26:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mJw6F8+O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0247D84671; Thu, 14 May 2026 12:26:22 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF98784659
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 12:26:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BCESWQZrXcwRlsthhNCiatzLjH1LG9lqJ4VFkhweHa+MfhMdLUXzZELX2FisT1uwl0ET9opzef1IFIJIwj2YxNBpNg4cbMsT9EvNCXKqfmpXpOXbTr3CUDx19MWLIEV6Y4MzdAzK7fKGNZtFb2ojjLP59efL8WHDYMIBo/Gf9732/K2h1hOa+xRbSuwvCssJYf61gjvMWFnGST6gaBPBYy120j6F46oLGOuy/MZTH0NdhJT9081wO54C13e7YgPjxzOOSyOyNStz6e7JswFAV8edBydTEu1N69vHmZyT0p2zmwTPH2XE2WjpKPWM7UL96YVLHk7b4cKdjXr1RelaUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhDm7k3Ba/KzrEEgqazDQg3/hoSIwlmWidXcBdme3CY=;
 b=uFLSSI9kH9X0wdyhp7o/q5pouosLi7gXS3KR6g4BEbLw260QqlDxg3YIgJBrYSlgmTADYjHmGQ4Q+phrmOZG+N34SWaWlJh+auCgkztd7NbmY+ePnn7rC8/MKDp1wuKIyRZTeykei4TgMAkDTk7Sj1S58HiZX9caBPuBUtWxmHx3VZyFqOqQ1kcgl+rb7i/cAHZ4jBkFUvHVNhy5zpwH9e2HYExpcM7TjQtBlh2OxCKb9zBZfK2ISDHCVwNp+7FYyBRApBrrb8BXZ3a+tT8t21btpWJmIMXCCDPYAlCVIlz3BlpLMJdajUc4T3EORxQlSUZkmuWbtFYKFqeNAryaOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhDm7k3Ba/KzrEEgqazDQg3/hoSIwlmWidXcBdme3CY=;
 b=mJw6F8+Ou6XvEADl6XKV2ZMrq3ljTjWhtw0cFFZrdj/3alsfc5A/SETmQtmJR0xEU474bgm0SBAjD9I3XAMfsgfutV5Aojevb5iH2k0KJTYh7sAKkDTXfKd7VBr9y9fBzIYC+M1nlXL0oOV9+0x+gZNn1SxJ6eO0NbE1Bbwd3bQ=
Received: from BLAPR05CA0029.namprd05.prod.outlook.com (2603:10b6:208:335::10)
 by DS0PR12MB9346.namprd12.prod.outlook.com (2603:10b6:8:1be::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 10:26:11 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:335:cafe::1b) by BLAPR05CA0029.outlook.office365.com
 (2603:10b6:208:335::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Thu, 14
 May 2026 10:26:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Thu, 14 May 2026 10:26:11 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Thu, 14 May
 2026 05:26:10 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 May
 2026 05:26:09 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Thu, 14 May 2026 05:26:08 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>
Subject: [PATCH 0/7] Add capsule and FWU support for Versal and Versal Gen 2
Date: Thu, 14 May 2026 15:52:17 +0530
Message-ID: <20260514102601.1759779-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: padmarao.begari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|DS0PR12MB9346:EE_
X-MS-Office365-Filtering-Correlation-Id: cefdfb6a-4847-4cf5-821d-08deb1a3383f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: MAXahsSxjPtOMQFmybCVu40IBj9TCLwM4waGx1rqbP8ikUJ6suNEdGR7h2l2GiciEwbZXMrfkv4rcn54TZDIWwPHyyGr9ud2+8JdsB3ULh1/AMP6nkWnHClr0R8oHYp7P3Lbo5hCbVmLdAF2vS7onNUj44fnmn0P6pE6V9lhDvoJsyjMnclVreO20AtRwFLrAGm6kTR6eoPze0wy+gn8vdianczB7DntJy5bnXAFfj2Ho6Zar+O++mzfkyyuFDwY02Cu8WHsreNOG9Vr9jEhmYNVxvu/dC6Txww3R1St9luHNvrjZrTWrzdKjf3RzzFH1QXVdybJYFjFB0567uHKMFpMSP7mvwbMU+CwzlvGstdlhviMUIVf8kB58FtwIeFaCV2eb3x/ubpgtOvHcL4E954T4XzMIz/KwMiVFWY6Nmpss42/q7kqNQLNgUHIqPAtTEElWOBv/ffqtQXNPFZzVLbscPUNaJ+q32qPM3T5VmOy5wVsCf9SRAjzXG4XPJ0utRTo9PzLahMXwrVMiTWGKID/1pIddh1yx4uQOiEbvgX9yI39IhBIMssRJMM7e25ZnLZ2k2FFf68eVT3b11gOFo3axfQrgp3nFhw0Ro+yhXPBrTBGpjmZFnc1SxaWHbfr0lPgD1LAbcsLTSTMrEgAQb0Nd6ZXbdN3xi9dPejOcbINaXcFXBR8Z1R6XOLGHfor4cCWGAYGvznCP8izsXJQqadMJAbr9q3tTNEV2SzuXvs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(18002099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GWk/3hhu66OPbC8Zke7yEdg7w71rU/Y3j6Iyg/GFrtWdkYF7iTevT89oVY9plbi0Pc3yVv8609KQaDRilPmvk2fJDv4qYe6h3De3JUc2bKYc69lwQyDB2RY3+O5+18yTyutwS/g9pA+ThQJC9aNkA0iMjIUwwU64YlKpq4z7t4pgkckbIyss+HT6ws+Vvw2mgpP3Hgzo+SsjO3VlODLFD17TtUE1Y/O7IxtUEzj+/+ZC2Kc3sDDzTudVBeA4+zn1kBx/Eo9usOco3XTyVwxTq6UkhtjQvv9s3782fkSuxP9VOKiL6+Why0V13RUMXQgwwxqoWH9WBfz1zh617DAAj192rIVHGKJDk1MM8oaD2Tk3BJYczHUpSmMSBFOI7Nn/lO7FP/++BbmPcXDZxvYTykJqKxW8ulG8E0yJ4aA9OVXnKf0ee7r7MkwoWC7Ag0VJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 10:26:11.4227 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cefdfb6a-4847-4cf5-821d-08deb1a3383f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9346
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

This patch series adds EFI capsule update and FWU (Firmware Update)
multi-bank update support for AMD Xilinx Versal and Versal Gen 2
platforms.

Padmarao Begari (7):
  arm64: xilinx: Add PMC PGGS3 and PGGS4 registers
  firmware: zynqmp: Add PMC PGGS register read API
  board: xilinx: Add capsule and FWU support
  board: amd: Add capsule and FWU support
  board: xilinx: Add FWU boot index support
  configs: xilinx: Enable DFU MTD support
  configs: amd: Enable capsule update and DFU support

 arch/arm/mach-versal/include/mach/hardware.h  |   3 +
 arch/arm/mach-versal2/include/mach/hardware.h |   3 +
 board/amd/versal2/board.c                     | 131 +++++++++++++++++-
 board/xilinx/common/board.c                   |  73 ++++++++++
 board/xilinx/versal/board.c                   |  42 +++++-
 configs/amd_versal2_virt_defconfig            |  15 +-
 configs/xilinx_versal_virt_defconfig          |   2 +
 drivers/firmware/firmware-zynqmp.c            |  54 +++++++-
 include/configs/amd_versal2.h                 |   5 +
 include/zynqmp_firmware.h                     |   4 +
 10 files changed, 327 insertions(+), 5 deletions(-)

-- 
2.34.1

