Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCBCC46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 13:59:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C7CF8796A;
	Tue, 26 Dec 2023 14:58:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cvRn2hxQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DD7187968; Tue, 26 Dec 2023 14:58:10 +0100 (CET)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::617])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 900B887963
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 14:58:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
Received: from SA1PR12MB8093.namprd12.prod.outlook.com (2603:10b6:806:335::15)
 by IA0PR12MB8255.namprd12.prod.outlook.com (2603:10b6:208:404::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Tue, 26 Dec
 2023 12:27:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jf5DXo0NKoE3h9Jl39soiQjbHSigAZu7HbTJOUjVuWuETUKkiI0dFiYHFOGiyNKulaTF1qU4fIwzPQwwGugXCBy1jazO30ifALm5XkU7eXLxLk3MhPYCKGlh6eJB+I92ebZtOUPvL0kPBVPDS2iIx1CUNFWVpBpaWeUH8f35kn9XomuAQ5/Fstk3forF6mPHw9HxanOeYcZsn1hqFvp28G0GrdSIM6uQwjpGPwrJ0MN/fSRlvxyejfYaxtbDcFEgJ783kYQYvmq3Ypo2xSnMuOB8tzfXw7AUHPGZTDTV5V0XDTBk4nu8LW5dQ2xZd2Fo407586lGtIOBMat0TbmnJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gJVCpvQvcG2eAxBSFfRYwrFN4o+29Wm1DqEaSqvN5k=;
 b=LPcLaBkZdkDlOjX8v189arFE2SlU4H/AHrVgN/TdGJ5MQpwk5ldF/A59A0X7J19JaiYKeXBpdn+BO97+8AAdwDMmxlWvVryi4qdgpW4wngOwsa4skcyeqYKklcNJiR/fDHO1gW6HSnPQy7Opmb/ur2C3q4LCPWPhocbgSZZkwCS16pd87b/f8LGtY7nlLRPP/ieOgHwX3fnxcI8XSpFvct7/7ZXSEoN6gdDEmb5i7fBhhaB7NJA+hHlouyDPyQifDvW1XsD9DpX8R8KN01KUbUbcj0SJR5LdrpPpYbwx2yjRjcZTN1BhnSSNzfKW4gXYKZXne7Fp7EPdE5QFuDYFbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gJVCpvQvcG2eAxBSFfRYwrFN4o+29Wm1DqEaSqvN5k=;
 b=cvRn2hxQrQW6GZYZtVRogzRU/Yt9ynn2lgw51tIYnqL0kH5eTxAswMB+3djfhfV2RIrOoyAuGEGQcE6lAJJJle48nopvWbYhu3BiNH4S+KOMm8pZ8twO4Jy8RVeQmG/n1yU/8sCb2Kv3u919zQg3We7p+vofgfntt/1CQ5aE48Y=
Received: from CH0PR07CA0028.namprd07.prod.outlook.com (2603:10b6:610:32::33)
 by SA1PR12MB8093.namprd12.prod.outlook.com (2603:10b6:806:335::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Tue, 26 Dec
 2023 11:45:22 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::36) by CH0PR07CA0028.outlook.office365.com
 (2603:10b6:610:32::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27 via Frontend
 Transport; Tue, 26 Dec 2023 11:45:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7135.14 via Frontend Transport; Tue, 26 Dec 2023 11:45:22 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 26 Dec
 2023 05:45:21 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Tue, 26 Dec 2023 05:45:19 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <lukma@denx.de>, <git@xilinx.com>
Subject: [PATCH v9 8/8] axm/taurus: Disable the SPL_SPI config
Date: Tue, 26 Dec 2023 17:14:53 +0530
Message-ID: <20231226114453.577589-9-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231226114453.577589-1-venkatesh.abbarapu@amd.com>
References: <20231226114453.577589-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|SA1PR12MB8093:EE_|IA0PR12MB8255:EE_
X-MS-Office365-Filtering-Correlation-Id: 53cebb8e-e13c-4d09-5222-08dc060824ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aorsnsX6VKD+0+2CIyl4TeT9ddSxqQcSLhscrKKWUNlOIrnRdf+/iKNCi2+Fs4DcKsSedj5ukDJQchsspX/sGrsSqKPCOFzT8vgzd9L7PzNSuPzREV++JqWQEFRdOD4QRDd3p1UjJQsZXnPhGcEZUbXOwBaYb9OpaAFEqIDEBV+/Qm8ZNUMuWyAYhhxjU/c31mfVfZxgv/lLkuKnJRHKcMsdXayVZGI3RHqpjJmdMCACJ4iFJyO9fvJuIORat6eSYwOO3q+EkHomanlbNHsQDQgdB6f6Qllxqvu27GV1wUnPak5gBF8x0SsuBAuMYxo+1il46+QhTdPShvuhvF3+06YeqexcW/qsoT9Wxz5YIjGG+jO7EDVnC9HWuqfInNuF46gkxLP+Y3kPCxzZT77RusDW77uE0bmCDH26tu4DuqA61q4cFg+sEjXg0zE5kPHZfP/JuM4qyG/5lo9E5chPNDwopWgqQ/mT14oO4LuzoGAVpAAhsNASfSHnmUgCl532dHp+3G8PhMpTNGwd7GnFRP3jqOzVt9OaLLscaUt6A5dUwVK5in72he7/N0ew2shqxVmiNzwEz0ad0MrJO9jmG8YlGe/jj8gs07rR8/vAs06OtqKkEJ3G/D4mbCdNmL0+se6/8Fz+rPwBkW9SLz1cOmdNLSa0L5/pObAK8YkVPesNg2N9KKPjSSrydcO8FVjmjQONeRa+trtHgfyRX/zLGQv4N0datIc4cmxTgd19sE1h9P2MAAIAI9qtlHj/YwSHw2W19l3PRWma9RIHYQ9few==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(451199024)(82310400011)(1800799012)(186009)(64100799003)(36840700001)(40470700004)(46966006)(1076003)(83380400001)(6666004)(478600001)(426003)(336012)(81166007)(26005)(107886003)(356005)(2616005)(82740400003)(47076005)(36860700001)(41300700001)(8676002)(8936002)(6916009)(54906003)(316002)(70206006)(70586007)(4326008)(5660300002)(2906002)(40480700001)(36756003)(40460700003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 11:45:22.3830 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53cebb8e-e13c-4d09-5222-08dc060824ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8093
X-OriginatorOrg: amd.com
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

