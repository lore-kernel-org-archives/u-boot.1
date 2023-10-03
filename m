Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A30E776F0
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 03:18:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DF628717F;
	Tue,  3 Oct 2023 05:17:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nVfxO+RL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A48686D52; Tue,  3 Oct 2023 05:17:46 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::621])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 634C78717F
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 05:17:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=InNMqKHRRBA6+xUpsY1RL2ZqUNwzRlmP2xAIns99jc+aFOH8+dXVqNvcg0Zez5/tAjatxqX2Cgg/hGDuGMRL+y+eKhoHWqb7Kka7MaTmv59PPTRguh2ECEV7xSad+IuWff+Yygp2uaL8wtg9AiJ87YuAv+2kDqZFYm/rKPBlInbElk4LT2evHXLs293Dw3oEpZariaBk6jXQSrHbMVqjEjrQwFff9MM9ZSS2qHABksmZDhGUq9fBYIW6V4SU2dordxC/KNBvYHIi92Ob+lCKg39Bw2mVNjZed3cMdpdJj3VdkDX4TrYi2ysFzJ+ix0J5ZbMvJhkw3uLWXazVf6k+Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8we3MYJefy9ikJgcybNRbTnu1Uu2PYECBc6mk6FhT0=;
 b=BRBya1CVhGhR8SJFaWt8+4itxHzFcLhx2GviaW32Osilnu0j1JCb17oc6kRlfFRZxyCDGcHXz0X97Iiu/72xR1CT8FHpze6Fg9qaJ5MJ4PkjmN1KOlNKa1ey7+sxnrfIRLhUt2gfGlbk47lQ1qsD6nRBBm0b30/Dr5cw4jnE7mKFOWVKY0L8Fk2lhZyFa1qyxFs4WoupEcfGECv4Cb7C7PnLmmhh50LA1QBj1A5pTHteek2TYBwnt3HsgfTqk5TKrZal3y6+yWXHeVCZD0eTPhVuidqj5Og3f+gMiIbydrMdbrFAivxkfVQs3uYEOVc5Sv3qPOQkk0Xw9TgBLScFEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8we3MYJefy9ikJgcybNRbTnu1Uu2PYECBc6mk6FhT0=;
 b=nVfxO+RLj97oi+7POQeqXWG581UHVRouaotMcuP84RW52Wd8egKFzrkoGbx5elZNU44iYHaxMPPgEiB+ISR1JzXhdQIH45mxFjy+9qTJyXDETT1xA2RYwIgkTeKPrlWWuAie6YDE/RGUMGbAt/uLSW0mHS+1A3e+0rI2xU8CDCU=
Received: from DM6PR02CA0116.namprd02.prod.outlook.com (2603:10b6:5:1b4::18)
 by CH2PR12MB4117.namprd12.prod.outlook.com (2603:10b6:610:ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Tue, 3 Oct
 2023 03:17:39 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:1b4:cafe::9a) by DM6PR02CA0116.outlook.office365.com
 (2603:10b6:5:1b4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Tue, 3 Oct 2023 03:17:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 3 Oct 2023 03:17:39 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 2 Oct
 2023 22:17:38 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 2 Oct
 2023 22:17:38 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Mon, 2 Oct 2023 22:17:37 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <git@xilinx.com>
Subject: [PATCH v2 2/3] arm64: versal: Disable the lock option for mini ospi
 and qspi
Date: Tue, 3 Oct 2023 08:47:14 +0530
Message-ID: <20231003031715.5343-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231003031715.5343-1-venkatesh.abbarapu@amd.com>
References: <20231003031715.5343-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|CH2PR12MB4117:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dd58658-fcbd-45ae-8149-08dbc3bf4ca4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vrfCYBFyUrexY1Gu6RgariMlwXVHKkjyHkHxt2AEV/4LibaTKoW68VCDSr4aS6/fLPTuqNZKJkBm5YNVL/XHqgcHLKVPoM+E9DrmVo7MuvuoFn7BRGDmiC2SANQKbsFYGcvPHAt2ElaglHxoUehsExRW3wJYg66nJ4TChR250E3TYOaTey0OFQLtu8Y8+eqztVScPPOWCZdHpxjXuSxKpVmrn3vgMWaF9QHs73vRvHlk9MQSdlYQ39PO5z0UamJpSPE+PfpmKSIvbC616QiRIWL+4yNJIShc2eB5lxAkP+lvtEnipWtbnghNRzhAcXz1bieTOlULuShQqkLSg3yczAaiNv2L5ft+mLBz6xCqpF8l9EqXsoSX808elxQz6++mTc59VkQbEp1VEUVljA1XK3zd/vGAZgFGE7dxfDAzv+geZKyK4T2XJGrUcRFZK8mQPTIOz0xI30mfe2oFhBmEgEeefVzLjhetnRdPs2Xi6/KC2NKiunhljfacMSh7fUjswjU1zGz+ePvCxWKS0TAg0Wsw9ncnpuzo/cDC/LZzeedOCefDtCtVqW1b4z+bUJMnBVYw7dyl+C5nR9J2jvmV9Y+c4J1uxZ6yPXmf+nVroN4mNkWI/pD1rOtWUh12tmg07YIjrhIFJZUYLdeiAVEPVcTk2xPd+zR22+BAv9QtIAd6AnvoQTSRbnNNvQxoKf03gJ8lJ1vPlxZeOFprWvfZCReQX/Eg8dTjEEWEOtScs5OpyKPczjrP9ggNffG09GoHo5W8tExsyI4HNK/tLR3WrQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(64100799003)(82310400011)(1800799009)(451199024)(186009)(46966006)(40470700004)(36840700001)(478600001)(2616005)(107886003)(8936002)(83380400001)(26005)(316002)(2906002)(47076005)(70586007)(54906003)(81166007)(6916009)(70206006)(5660300002)(336012)(41300700001)(6666004)(4326008)(426003)(8676002)(40460700003)(86362001)(356005)(1076003)(40480700001)(36756003)(82740400003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 03:17:39.4295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd58658-fcbd-45ae-8149-08dbc3bf4ca4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4117
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

