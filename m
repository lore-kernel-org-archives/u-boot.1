Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418CBE776F5
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 03:18:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 070E9871A5;
	Tue,  3 Oct 2023 05:17:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Js8e1blB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB1AA87120; Tue,  3 Oct 2023 05:17:50 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::612])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9E64871A2
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 05:17:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRLObeIeL1MZ9Vaot3or2wzHxZ0noNhRX9pk9SgCQZmcrUrVOks5AF18Gsi/5+O2qrUYFJre2RpyJ5CCqNHpSgAwlfYVqDE6OOLR0cmgUSWSyqHgKD9Sa21piyuOXFstG+vtKcJWuLGS9fmFo5MUiYk8Y30amEj//AroHw6PSjTgfNcqJ4ac9nHOXC0KSd9/qhaJGAY5og0jZLJISiGSOdS8PRL8R7gDNsTmSCJ59Ouef94FU8GBUBJ1+sqmqDKaJiV4ii570ZHKtY18IPc/vQ+XjAQ34U4QITMuqTXBByvlMY7kV1gMTLEcKvfWK/MTx4hgIdqx3+2XPbpCRP3sMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNOWyxtDig64UGaU6LzDNYengnJr27c7cEXOgfoSPSU=;
 b=XIrdmHNAG2XRhDXR6tY4LDWWzvD81H0PolQnLEKW2/gLpYyaW2EzB85QxvXkmYb5IEaDtxxkhFgfBZ3YEdRG54juZXCYkexZoKAI+M8ZUTtqAJQJdPRWyPwkzyeT3UN9UKYpEqaTCnIzGrulTDets4fjHmd86IBuEugXSokMS5gkCQGWCl6osiOnT/quJyPMlOytWTJmHJIIxrgrujVeUhsD5Ox32pE0KeufWrxlBXsemHu2iZOjlsDShB8lwOHz4TbsIckPjtuSUJQVk8sqIGQNg+iQ/wDlexh5EheMc+0Kxyila+vQeIES0hzrLxOqNDrdWAcEbmlSdcWbbqFikQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNOWyxtDig64UGaU6LzDNYengnJr27c7cEXOgfoSPSU=;
 b=Js8e1blBjSmFUgvhoQSZA/b+1VHDfSkcnmkXtafmz268xq/R8sFe0IlvQl964f2Fb6k2cpdfHCVXR3cg5JCgqybbZPvOe7J6Aav9ZX4FEvS+54jH1j/8vi6D4iiJEMIfpLqmtDsu8Uqixb5TvBm3wFgh/LoA6bEfHqofOB8pLQg=
Received: from MN2PR19CA0051.namprd19.prod.outlook.com (2603:10b6:208:19b::28)
 by SJ2PR12MB8650.namprd12.prod.outlook.com (2603:10b6:a03:544::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Tue, 3 Oct
 2023 03:17:41 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:19b:cafe::c2) by MN2PR19CA0051.outlook.office365.com
 (2603:10b6:208:19b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Tue, 3 Oct 2023 03:17:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 3 Oct 2023 03:17:41 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 2 Oct
 2023 22:17:40 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 2 Oct
 2023 22:17:40 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Mon, 2 Oct 2023 22:17:38 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <git@xilinx.com>
Subject: [PATCH v2 3/3] arm64: versal_net: Disable the lock option for mini
 ospi and qspi
Date: Tue, 3 Oct 2023 08:47:15 +0530
Message-ID: <20231003031715.5343-4-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231003031715.5343-1-venkatesh.abbarapu@amd.com>
References: <20231003031715.5343-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|SJ2PR12MB8650:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d2c2afc-b8d3-4174-d25a-08dbc3bf4d9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /3Fm+v14f0xfpinSJfDLLtEFrsBivu36qJrNuuB/aEJa66KvnVaovrP2h0jrW41XrORDtZg5AHPDrj37WLlt89aPm/wlHVVueyZjjZD67L6WLa/5LcRWE4aE7YrCoDXEuS93EvOKLEM0fmKR5DFu1zCS/XjrAss4oK2UP5ydnKwwvgQxc/GqoY3Uv3nqTUy2yqdxgHUwFhu4wLr0xVoKVFUdAIhDGqvurXnPz1E64RpM+8vGcpg+z+4LfLci2+8nsts9hHzeGrYLq6+8Mlw6ZbMIcFdbGS32SVu22bQicNyn8d0fpz9cfsbYH5LiugwzGpCucvZKpCynurDclhk9vTIC+tQ0uwqvxk/22s/diX24ZdgdAP46TLwwVwKPDKRObzRZhSsNuZDtisgUfGMBJp1l0SnprZrdQzqy31wZwZePwdSj6AJimrZEQ2jDAcpbKG/q9LZ3kB9Fo1CyEUDLAs6ZG8ldx5UakQSI2FSmF4CKjKeJlpJ8m719HnxmsA42jEEVORopC2m4tZ1yP72yYdMQfLy3R4ztNcCtplf6YBvDiTftzxkU0PZPrm6AmiSqVitUilk1Ft60rkUUx1UhB7QF6rK3mpjYrf6ZMwwffFMGvVZZkNggqcYoi0BwD7SP72SsuQE0CS+mD5hOj+CbjOuCL9Z+HcJUUatQ1Gm65dQBmkNWaKdEDWQC/I5q+XGLPKtf3XqhNYi0Bn/pTPjdixot+hEViedHM9k6tOW20TvHRnwkO0lmbrxmFBF02wpcz76MnkTSdpWCzJ8LSAOlWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(186009)(1800799009)(82310400011)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(26005)(70586007)(2906002)(8936002)(8676002)(6916009)(4326008)(5660300002)(70206006)(316002)(54906003)(41300700001)(478600001)(6666004)(36860700001)(426003)(336012)(2616005)(107886003)(1076003)(47076005)(83380400001)(82740400003)(40460700003)(356005)(81166007)(40480700001)(36756003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 03:17:41.1012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2c2afc-b8d3-4174-d25a-08dbc3bf4d9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8650
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

As mini configs are required only for flashing the images, so
disabling the lock config which will save nearly 6KB of memory.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/xilinx_versal_net_mini_ospi_defconfig | 3 ++-
 configs/xilinx_versal_net_mini_qspi_defconfig | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/configs/xilinx_versal_net_mini_ospi_defconfig b/configs/xilinx_versal_net_mini_ospi_defconfig
index d11e180780..db3e7c80b2 100644
--- a/configs/xilinx_versal_net_mini_ospi_defconfig
+++ b/configs/xilinx_versal_net_mini_ospi_defconfig
@@ -12,7 +12,6 @@ CONFIG_SF_DEFAULT_SPEED=30000000
 CONFIG_ENV_SIZE=0x80
 # CONFIG_DM_GPIO is not set
 CONFIG_DEFAULT_DEVICE_TREE="versal-net-mini-ospi-single"
-CONFIG_SYS_PROMPT="Versal NET> "
 CONFIG_SYS_MEM_RSVD_FOR_MMU=y
 # CONFIG_PSCI_RESET is not set
 CONFIG_SYS_LOAD_ADDR=0xBBF80000
@@ -26,6 +25,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
 # CONFIG_CMDLINE_EDITING is not set
 # CONFIG_AUTO_COMPLETE is not set
 # CONFIG_SYS_LONGHELP is not set
+CONFIG_SYS_PROMPT="Versal NET> "
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
 # CONFIG_CMD_BOOTD is not set
@@ -56,6 +56,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_SOFT_RESET=y
 CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
+# CONFIG_SPI_FLASH_LOCK is not set
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_ISSI=y
 CONFIG_SPI_FLASH_MACRONIX=y
diff --git a/configs/xilinx_versal_net_mini_qspi_defconfig b/configs/xilinx_versal_net_mini_qspi_defconfig
index a7ebc38cda..c0ff42aa91 100644
--- a/configs/xilinx_versal_net_mini_qspi_defconfig
+++ b/configs/xilinx_versal_net_mini_qspi_defconfig
@@ -10,7 +10,6 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xBBF20000
 CONFIG_SF_DEFAULT_SPEED=30000000
 CONFIG_ENV_SIZE=0x80
 CONFIG_DEFAULT_DEVICE_TREE="versal-net-mini-qspi-single"
-CONFIG_SYS_PROMPT="Versal NET> "
 CONFIG_SYS_MEM_RSVD_FOR_MMU=y
 # CONFIG_PSCI_RESET is not set
 CONFIG_SYS_LOAD_ADDR=0xBBF80000
@@ -26,6 +25,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
 # CONFIG_CMDLINE_EDITING is not set
 # CONFIG_AUTO_COMPLETE is not set
 # CONFIG_SYS_LONGHELP is not set
+CONFIG_SYS_PROMPT="Versal NET> "
 # CONFIG_SYS_XTRACE is not set
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
@@ -60,6 +60,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
 # CONFIG_MMC is not set
 CONFIG_DM_SPI_FLASH=y
 # CONFIG_SPI_FLASH_SMART_HWCAPS is not set
+# CONFIG_SPI_FLASH_LOCK is not set
 # CONFIG_SPI_FLASH_UNLOCK_ALL is not set
 CONFIG_SPI_FLASH_ISSI=y
 CONFIG_SPI_FLASH_MACRONIX=y
-- 
2.17.1

