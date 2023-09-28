Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0DA2CE7AF9
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 03:50:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B91B586E23;
	Thu, 28 Sep 2023 05:50:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jzjOo45u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 752B186E1B; Thu, 28 Sep 2023 05:50:05 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::630])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6428086E10
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 05:50:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrZpP0vwTrZopUE8N7E7fZuU9NfdJ1hEvvJkj4Ed9OsNmgx3tFLDYA4YU3QlJK/mBmD+vYK1MD1Yu6ErTNNm6KrbX+NIyG1e9Gf3I+ufsdfIr6YeksVwbNfADWDrhKTpg4RQXbifvD66gTUA0LwFe5CWjUjDBXORc+XOINYj9AFYvZnX+r7k8fb6ETlekduVgEB5Y5y4LTOqaxxvi5CXB1885mOhUA90noKOShJFcjEkNJUp2kaL3Pio2hzb39w6y5VNIBi+NCwATTnxsHUrkpTCTChMxWOqgHxWjcaV2HLI48aNaA0fWbiOjg+LZ1nqE4F1HXttKmnQsp8bIIqsQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8we3MYJefy9ikJgcybNRbTnu1Uu2PYECBc6mk6FhT0=;
 b=lYJgvkcVjVfjrzr8Ff3SbpJy0O/cQlCs7yP9OdehzDGwig5P0Xth0gSLwd5ppVR6NcFftjPW+WS3qReblXWwNFFUPWUhgAGF61DA3tx+uAm+/P/3WqNipKjwKw5npEARlPdj89hqpH+WwHmf6lTwlNHDkHnqCpNooENvR/j0p335vf1xnEtHGdqknmF+sl0MfkwHlBaQsw/LRKDCHv/9t0KVj332XzftCgMU1dGKj9QjZ8asbPx9DlJw3fM7R7h0QCccY4WGo77ZiTzg8LfB4b4mGGzzfET0nQAMXnSTYQFATB/5XUeaehcK+ThQ2CZn6z+WwfdmWjEQmy/Y00ocDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8we3MYJefy9ikJgcybNRbTnu1Uu2PYECBc6mk6FhT0=;
 b=jzjOo45uZ+/8CdAwwINTPSd3HWhs8ZY16CRHNbYrbCESOmGcJkQCjDQFauZrBWP7dGOMeFnNVXoaWMq2HLElnI0vdSPG6dCuTVGiCktZxVrxYss36fDaBTDIiIrvtkphtqR+rgZds0Gtfu5NUYFxvbOaYt/2JdSo0FD4pc6E9w8=
Received: from SA9P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::26)
 by IA1PR12MB7639.namprd12.prod.outlook.com (2603:10b6:208:425::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Thu, 28 Sep
 2023 03:49:59 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:26:cafe::ec) by SA9P223CA0021.outlook.office365.com
 (2603:10b6:806:26::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22 via Frontend
 Transport; Thu, 28 Sep 2023 03:49:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Thu, 28 Sep 2023 03:49:57 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 22:49:57 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 20:49:56 -0700
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Wed, 27 Sep 2023 22:49:55 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <git@xilinx.com>
Subject: [PATCH 2/3] arm64: versal: Disable the lock option for mini ospi and
 qspi
Date: Thu, 28 Sep 2023 09:19:39 +0530
Message-ID: <20230928034940.2220-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230928034940.2220-1-venkatesh.abbarapu@amd.com>
References: <20230928034940.2220-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|IA1PR12MB7639:EE_
X-MS-Office365-Filtering-Correlation-Id: d7f74fd9-fc36-4251-b004-08dbbfd5fc07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sjhj7K3vNQdEHwZQaA7x8sSiKG40MBd1DWzruo+VgOrhF8u+NQUWPgF2pwAMKTRqzlQzyZt6IctByli6F5kd4FDq9aqvcJ2rNSHzN8Kun9DapLV0AEBHWLn+3hkfbV73WG0iHH+jDhrwbtdfMwIPyw5jluM4aXGdgmYjdLe4Rc7/WZWlHgrK1BIARI9ukohEFYaVJSpiiZBg9vp3+KaiLKBJzLaSRAyad6xCLmT9T6C+yBvSuN24KzVp4bCUFqN+URahVHxzqWt20zxH/riqm5gcCdYo4WAfFM5n9yMJ06eItRexuGpqJaLWyzi2bsRSu8f4NiqZi1MVDwK4zBQgZSSdjizr/D2GswavoPymdjmw1wV/T/MUmfTWVvlm5ZyosYvvfTxtLsDvh4YvL33+RSr69WDgRy8lhGyI5APErLmLvnqlZ5ksAXxkYYo99Roo3lXj/hgBRn/kTxLFfaiTNPPkTvtpKTgAeXQBScZYuvIk662VQlBRgewmE/+616MSjbHCnMOfXnWMDh72sj1Anx7x/7ki5/yHUoTtxCFbMNAq7FqvR6jrVLXWuF+lQF+xRPj8HWv2HRJmXMK6Fh6W8KaLAWKFcjuiPBI1vTria/0FOjZ2y/JpBhgMiIQxJ12Ra63HSQ7p2m8kA1DpjYAd9q+FYKliAI22S7zQj6yqy4SGUN9+bZMPsSIQavFXQ4FqnH3gEPV8zu5FTvj/di4NrCsMr0IdjYRQMkFjeHTJjTJ14FZzgxrt58LrkJUto0D4RUZ/nOpwdbiO8GWFp59sAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(230922051799003)(64100799003)(1800799009)(82310400011)(186009)(451199024)(40470700004)(46966006)(36840700001)(8676002)(81166007)(2906002)(47076005)(82740400003)(356005)(54906003)(316002)(86362001)(41300700001)(70586007)(6916009)(26005)(2616005)(107886003)(336012)(8936002)(478600001)(36756003)(4326008)(6666004)(70206006)(5660300002)(83380400001)(1076003)(36860700001)(426003)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 03:49:57.9733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f74fd9-fc36-4251-b004-08dbbfd5fc07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7639
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
 configs/xilinx_versal_mini_ospi_defconfig | 3 ++-
 configs/xilinx_versal_mini_qspi_defconfig | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/configs/xilinx_versal_mini_ospi_defconfig b/configs/xilinx_versal_mini_ospi_defconfig
index 27b59f899a..539ce2d3c0 100644
--- a/configs/xilinx_versal_mini_ospi_defconfig
+++ b/configs/xilinx_versal_mini_ospi_defconfig
@@ -12,7 +12,6 @@ CONFIG_SF_DEFAULT_SPEED=30000000
 CONFIG_ENV_SIZE=0x80
 # CONFIG_DM_GPIO is not set
 CONFIG_DEFAULT_DEVICE_TREE="versal-mini-ospi-single"
-CONFIG_SYS_PROMPT="Versal> "
 CONFIG_SYS_MEM_RSVD_FOR_MMU=y
 CONFIG_VERSAL_NO_DDR=y
 # CONFIG_PSCI_RESET is not set
@@ -27,6 +26,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
 # CONFIG_CMDLINE_EDITING is not set
 # CONFIG_AUTO_COMPLETE is not set
 # CONFIG_SYS_LONGHELP is not set
+CONFIG_SYS_PROMPT="Versal> "
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
 # CONFIG_CMD_BOOTD is not set
@@ -57,6 +57,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_SOFT_RESET=y
 CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
+# CONFIG_SPI_FLASH_LOCK is not set
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_ISSI=y
 CONFIG_SPI_FLASH_MACRONIX=y
diff --git a/configs/xilinx_versal_mini_qspi_defconfig b/configs/xilinx_versal_mini_qspi_defconfig
index 4b0793411c..93365e7d30 100644
--- a/configs/xilinx_versal_mini_qspi_defconfig
+++ b/configs/xilinx_versal_mini_qspi_defconfig
@@ -10,7 +10,6 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xFFFE0000
 CONFIG_SF_DEFAULT_SPEED=30000000
 CONFIG_ENV_SIZE=0x80
 CONFIG_DEFAULT_DEVICE_TREE="versal-mini-qspi-single"
-CONFIG_SYS_PROMPT="Versal> "
 CONFIG_SYS_MEM_RSVD_FOR_MMU=y
 CONFIG_VERSAL_NO_DDR=y
 # CONFIG_PSCI_RESET is not set
@@ -27,6 +26,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
 # CONFIG_CMDLINE_EDITING is not set
 # CONFIG_AUTO_COMPLETE is not set
 # CONFIG_SYS_LONGHELP is not set
+CONFIG_SYS_PROMPT="Versal> "
 # CONFIG_SYS_XTRACE is not set
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
@@ -61,6 +61,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
 # CONFIG_MMC is not set
 CONFIG_DM_SPI_FLASH=y
 # CONFIG_SPI_FLASH_SMART_HWCAPS is not set
+# CONFIG_SPI_FLASH_LOCK is not set
 # CONFIG_SPI_FLASH_UNLOCK_ALL is not set
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_ISSI=y
-- 
2.17.1

