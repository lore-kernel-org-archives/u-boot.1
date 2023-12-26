Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5717C46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:38:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F46D8788C;
	Tue, 26 Dec 2023 10:36:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yDPcMykj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5228D878AC; Tue, 26 Dec 2023 10:36:50 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::614])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A2578788D
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:36:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZouhTNiVlOctTcllgDlJcb4a6e05nPQLir2FldXixj+Twza3jz8MvNH/DlWALhqvqIpZmRp6PXYBe9kJVSnqRwCs7z7vSjnTk02Md/bVMV0IGUe/vzZM2CzvzzzTbrcigYPq2qUbOX5xyx7nVpJjkpVqcBpD3awPaxrsinXj7lMaQ2AP51gyveoTjZ/U93WXubSUL/AmuqUPf7WHeEbe7jVvghS+7Ag5M0DmKiJaXXLDzTF4QT6VeGe2JbhXW4CKS1CZRq9cLTmbXY47H3K+SXBZirpgOyAJdm9LqTRrPiLCrcscOL9HBo8jT1N5Cu9FiiggmYB97xGJ5ZHx3kOYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gJVCpvQvcG2eAxBSFfRYwrFN4o+29Wm1DqEaSqvN5k=;
 b=HLEmvMjBAmBOalMf+cF4OQG5i6yvxh+OdHxac7jMhftLd3eDV0qqOZXrPe4eVfChK09uSMfoFwbSd7CftbG9LWDNmDnSH2pNu90ohUSSMK3n5GITl6Azyjbbp56zsPvcMhqO9G4LPntZK6k9TrzbmDKEtDP8m/M/o8OwXNKR1XwCoMA8FeImxcXJpdCcVFFKIcm3/7lb/spT5Kc0aBzSqUNRRqJsdg1x+pHh1kkfe5gAoOx6iLzCre9K5wBd992fwyIfjuEEl4Art4z1A1Eg0njHU2cgXyS17nkPRv2Ripzzt64PjugPikGo0WRRsHUD7kfZwnfh84TKoyMzYCwzcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gJVCpvQvcG2eAxBSFfRYwrFN4o+29Wm1DqEaSqvN5k=;
 b=yDPcMykj5MDrkU9rZ3fl6wmphz74pW4yjO6JM8ZNqh+1vz7gUNCxOJ4bZLnoRRNbu5ZMcFFLK/zbSQe8ri8Q8N6lIN2AOU88QuuJ1gGufZmCOBD4sRmMwDJNl6otZv83SyhcRNnGUv28AP+K0wgG4mRewMG7lu2yc57Tr+Qoglo=
Received: from BL0PR1501CA0023.namprd15.prod.outlook.com
 (2603:10b6:207:17::36) by MW5PR12MB5652.namprd12.prod.outlook.com
 (2603:10b6:303:1a0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Tue, 26 Dec
 2023 09:36:42 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:207:17:cafe::ee) by BL0PR1501CA0023.outlook.office365.com
 (2603:10b6:207:17::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.30 via Frontend
 Transport; Tue, 26 Dec 2023 09:36:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7135.14 via Frontend Transport; Tue, 26 Dec 2023 09:36:42 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 26 Dec
 2023 03:36:41 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Tue, 26 Dec 2023 03:36:40 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <git@xilinx.com>
Subject: [PATCH v8 8/8] axm/taurus: Disable the SPL_SPI config
Date: Tue, 26 Dec 2023 15:06:15 +0530
Message-ID: <20231226093615.530089-9-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231226093615.530089-1-venkatesh.abbarapu@amd.com>
References: <20231226093615.530089-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|MW5PR12MB5652:EE_
X-MS-Office365-Filtering-Correlation-Id: e351d7d3-c1fb-4c16-6016-08dc05f62b1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 34Z4gwHwa9c9lfy336AqxjMvFlPocfOQVCVasYgja2iQYDVQm14BYvQU28d2qkhvWaLFcv+6IGiUdqArEm9nSmiawNmLP1hGLQdTStbPQ9zbb2Pf2OvEFbg9paUif+gZtaiWBqrnqXpqVVXU1ya4vFN4gn1ThO3bno9pBddWapIs6RuLBEKRV+2gOLj5vk/6TKRA3jrdLHwSq+AyfywoUDtg2M13eeOrZzMX5XxzhGgqnNl2mDkdbc/acz5GLBW3RXuTH+JUW9HKQUL+gMUlO92oUjM9PJ8mHi8O1669Zzr7McY1OZ1J9RQuOqz+usLDDD/yxUDKSt65XQf2eHs2mCOpoBEFBMlv3J06bpWC50XPqZ4ugJVNor8Mc8MSXgpIydWn1keXLnBf3w5WwN92u4nlIc+cG/gwQtglqKj8xG6w1mAFv2F7UNPByxwTAFHRxd/saHimfgg/yfssKdO6r/rMmSr/EqP474d783+pOTyyZ0lOuJrGygSTJ1ct2K77wmzkl7yz+R5YKdT/W/maeDpZYuA5cax2OYM59uHTO4Se1wmmhkX7oLWEW/VV+mJQySlKv690stms8jzMnF8pnHYKwbOlifJ35H8f7FYPUsqdHlXSwjcbzc9R/7N7MdSIOUrKrF6iddiVDinnfRcjUgbt592oBdJ4kuCqEeBFbQefYlF1jTVeV8afIGwwc9i8wWoE6+0zLDGnBbtNMoPaezj50sjrygAk+Iorv1MMZQiuIq6Xq8CMY2KIhULDyCsPrGm5sF/CXlmmZvDqlCB8CA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(82310400011)(46966006)(36840700001)(40470700004)(40480700001)(36756003)(40460700003)(6666004)(6916009)(70586007)(70206006)(86362001)(336012)(426003)(1076003)(81166007)(356005)(82740400003)(107886003)(26005)(83380400001)(2616005)(47076005)(41300700001)(2906002)(5660300002)(8936002)(8676002)(478600001)(36860700001)(54906003)(4326008)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 09:36:42.3024 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e351d7d3-c1fb-4c16-6016-08dc05f62b1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5652
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

Disabling the CONFIG_SPL_SPI for the axm and taurus defconfigs,
as facing the SPL size issue "SPL image too big".

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 board/siemens/taurus/taurus.c | 4 +++-
 configs/axm_defconfig         | 7 ++-----
 configs/taurus_defconfig      | 7 ++-----
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/board/siemens/taurus/taurus.c b/board/siemens/taurus/taurus.c
index ad44a7c0d2..ac1ce8acf4 100644
--- a/board/siemens/taurus/taurus.c
+++ b/board/siemens/taurus/taurus.c
@@ -135,11 +135,12 @@ void spl_board_init(void)
 
 	/* check for recovery mode */
 	if (at91_is_recovery() == 1) {
-		struct spi_flash *flash;
 
 		puts("Recovery button pressed\n");
 		nand_init();
 		spl_nand_erase_one(0, 0);
+#if defined(CONFIG_SPL_SPI)
+		struct spi_flash *flash;
 		flash = spi_flash_probe(CONFIG_SF_DEFAULT_BUS,
 					0,
 					CONFIG_SF_DEFAULT_SPEED,
@@ -151,6 +152,7 @@ void spl_board_init(void)
 			spi_flash_erase(flash, 0,
 					CFG_SYS_NAND_U_BOOT_SIZE);
 		}
+#endif
 	}
 }
 
diff --git a/configs/axm_defconfig b/configs/axm_defconfig
index e1a01b24b8..4d439832d7 100644
--- a/configs/axm_defconfig
+++ b/configs/axm_defconfig
@@ -3,7 +3,6 @@ CONFIG_SKIP_LOWLEVEL_INIT_ONLY=y
 CONFIG_SPL_SKIP_LOWLEVEL_INIT_ONLY=y
 CONFIG_SPL_SYS_DCACHE_OFF=y
 CONFIG_ARCH_CPU_INIT=y
-CONFIG_SYS_THUMB_BUILD=y
 # CONFIG_SPL_USE_ARCH_MEMCPY is not set
 # CONFIG_SPL_USE_ARCH_MEMSET is not set
 CONFIG_ARCH_AT91=y
@@ -26,14 +25,14 @@ CONFIG_SPL=y
 CONFIG_DEBUG_UART_BASE=0xfffff200
 CONFIG_DEBUG_UART_CLOCK=18432000
 CONFIG_ENV_OFFSET_REDUND=0x180000
-CONFIG_SPL_SPI_FLASH_SUPPORT=y
-CONFIG_SPL_SPI=y
 CONFIG_SYS_LOAD_ADDR=0x22000000
 CONFIG_DEBUG_UART=y
 CONFIG_NAND_BOOT=y
 CONFIG_BOOTDELAY=3
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run flash_self"
+CONFIG_SYS_CBSIZE=256
+CONFIG_SYS_PBSIZE=281
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_SPL_MAX_SIZE=0x3e00
@@ -57,8 +56,6 @@ CONFIG_SPL_NAND_BASE=y
 CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PROMPT="U-Boot> "
-CONFIG_SYS_CBSIZE=256
-CONFIG_SYS_PBSIZE=281
 # CONFIG_CMD_BDI is not set
 CONFIG_CMD_BOOTZ=y
 # CONFIG_CMD_IMI is not set
diff --git a/configs/taurus_defconfig b/configs/taurus_defconfig
index 9be30c8d8a..7d71262d1a 100644
--- a/configs/taurus_defconfig
+++ b/configs/taurus_defconfig
@@ -4,7 +4,6 @@ CONFIG_SPL_SKIP_LOWLEVEL_INIT_ONLY=y
 CONFIG_SPL_SYS_ICACHE_OFF=y
 CONFIG_SPL_SYS_DCACHE_OFF=y
 CONFIG_ARCH_CPU_INIT=y
-CONFIG_SYS_THUMB_BUILD=y
 # CONFIG_SPL_USE_ARCH_MEMCPY is not set
 # CONFIG_SPL_USE_ARCH_MEMSET is not set
 CONFIG_ARCH_AT91=y
@@ -28,8 +27,6 @@ CONFIG_SPL=y
 CONFIG_DEBUG_UART_BASE=0xfffff200
 CONFIG_DEBUG_UART_CLOCK=18432000
 CONFIG_ENV_OFFSET_REDUND=0x180000
-CONFIG_SPL_SPI_FLASH_SUPPORT=y
-CONFIG_SPL_SPI=y
 CONFIG_SYS_LOAD_ADDR=0x22000000
 CONFIG_DEBUG_UART=y
 CONFIG_NAND_BOOT=y
@@ -38,6 +35,8 @@ CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 earlyprintk mtdparts=atmel_nand:256k(bootstrap)ro,512k(uboot)ro,256k(env),256k(env_redundant),256k(spare),512k(dtb),6M(kernel)ro,-(rootfs) root=/dev/mtdblock7 rw rootfstype=jffs2"
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="nand read 0x22000000 0x200000 0x300000; bootm"
+CONFIG_SYS_CBSIZE=256
+CONFIG_SYS_PBSIZE=281
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_SPL_MAX_SIZE=0x3e00
@@ -61,8 +60,6 @@ CONFIG_SPL_NAND_BASE=y
 CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PROMPT="U-Boot> "
-CONFIG_SYS_CBSIZE=256
-CONFIG_SYS_PBSIZE=281
 # CONFIG_SYS_XTRACE is not set
 # CONFIG_CMD_BDI is not set
 CONFIG_CMD_BOOTZ=y
-- 
2.25.1

