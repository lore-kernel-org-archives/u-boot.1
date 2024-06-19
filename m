Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831D9C27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 07:18:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC9208842A;
	Wed, 19 Jun 2024 09:17:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fWCiE30y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A75478842A; Wed, 19 Jun 2024 09:17:54 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::62a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D53688413
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 09:17:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mB6NUsEIO8579hb6ZQ6qSDEqKW8/gtqEdRpX9XpmjK189k9EFn40A68jSmWRZ2zA9Suf9WfMUkyGXZaYGIJKzR3AkQ82txZbY1jm/GTbPh3xMMyEh8EER/FhUZxTY0LhpVkk0S+6GeaVwm0oXnQLEibO+mddZmc+h9RxsARn/+WvtQ9qvxkoyhFa/eFn7wo5ds4SlI83ElPnlp5PhlfH4TU6lo7mcSLCJwm7SAtHtIW0uJbQBNO4VN8X3V+ymiso8frld5TvsB6Jeli6Uhdd9XCT7uspnzINpQ5Ym3zz5lRFlAZGJ+axcyUYlFaUz7cllfWvvNxfOm6GQsaWoO3+3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJ0CJIeiF3nbw3qoq2G7TbhhAMlx3G8bi+wgghkFlbk=;
 b=m52pX6w1DDPVJEAqtEDOLoyv7ruxaCOKY16Jz7GlbRNdjhrzTL6Azl9fFp5NlgxclXAWAgA5CLJLjzHH8f+OadoDXBlkSiadtUW5YY8VeK5Lw0IOjNJyEjNoclpLC6Yf9SVdTxCUDPJes9ZUFCiz8DBDNmZ+qnRtMBaCt35MLkiatoqsCDz1irXsK7D/yiQxqG41dFNnbN2N03K/qvNKG+mvzD39/TPcS1FGUodDRVOimREamRiTyHZArObSTP3SWd4ruDDakn5XPQngbnezkclob0DQ2VptFHAwTHlwXcWnOT+tIWCSi+LmKYdgmDfEfj2XxTzUeVlyw2QhtPptoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJ0CJIeiF3nbw3qoq2G7TbhhAMlx3G8bi+wgghkFlbk=;
 b=fWCiE30y1Psl9YTtIFr+S9+c1hWSNlC963DU8ahNZlvQC+zSz8282ooAdav/6iuSlAr4EklO34WSa2nHR7iUMYSCGpEQE49VCJuYaPEYBfOFf4v5hHYPXTXun5Nfd7eQv3qwMOEjRZx/C04SNteDqLWmaeKYatIWSFq53FHQZrs=
Received: from MN2PR17CA0034.namprd17.prod.outlook.com (2603:10b6:208:15e::47)
 by DM4PR12MB8450.namprd12.prod.outlook.com (2603:10b6:8:188::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 07:17:48 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:15e:cafe::d) by MN2PR17CA0034.outlook.office365.com
 (2603:10b6:208:15e::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Wed, 19 Jun 2024 07:17:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 07:17:48 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Jun
 2024 02:17:48 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Jun
 2024 02:17:47 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 19 Jun 2024 02:17:46 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@amd.com>
Subject: [PATCH 4/4] arm64: config: Add versal2 mini emmc defconfig
Date: Wed, 19 Jun 2024 12:47:33 +0530
Message-ID: <20240619071733.10256-5-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240619071733.10256-1-venkatesh.abbarapu@amd.com>
References: <20240619071733.10256-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|DM4PR12MB8450:EE_
X-MS-Office365-Filtering-Correlation-Id: 585fa2a0-699d-4ffd-461e-08dc902fec88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|82310400023|1800799021|36860700010|376011; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hsxLpQhIMAMTkSSH8eC/ckEnlGTMWSPYA4HbzipNTD/An0n0PBp/lqx9lp/Y?=
 =?us-ascii?Q?jQ9ktACX4Y4QspiAvE73lGL3zwCi/LwG0ZoVPqKFvT0tWDo7tdb7fdpW3Fbr?=
 =?us-ascii?Q?fqdbLD5oKfQhP1cBjG8shE2MnplCpVacEVQNMSBz48ur4j/nOH4L7jk9vmGr?=
 =?us-ascii?Q?ecOxuWPb206kRnSjy0R3H1KFRQh3AZnDfUPcEZGlW/gg82841KZQRuU4Gxic?=
 =?us-ascii?Q?W1F8ykB8X2J6v2mtvb3ZxltzV44ATKA6K1/EwkxM6Ej5a3CA0xrGwd/ZO0iC?=
 =?us-ascii?Q?/qp7Eh7BTqFfl5Vh8nXYNrf+Hq6TGsRFUdLAfinfNjCO1Vya06/tDYXDGsFC?=
 =?us-ascii?Q?inpz1x9IrCE6fvi0fxDKCZHVF6aTDyuPu5sCYkZ2LjvGKYmQxOJT99e+hqjU?=
 =?us-ascii?Q?6oGHOjfbyfKH/J7LKy+8fWAGzATK8TRGFO+YZQkV1OVgoVszD7Y14iL+vBYk?=
 =?us-ascii?Q?83p9UqZp0hdjU2AXQw7EsxYB2/1vf7plDJWtkxmz/M1QqgIuaCfHW4TOgVzz?=
 =?us-ascii?Q?IM07yayOMDtYMwhOFM4B4ZnyCSmMw8xW/uLICcBt3fnKtGLlrRq4ceXMMjaf?=
 =?us-ascii?Q?lwDlZAyYPwnCMZqo7rZR9VqWjbWGeNtnJ1yECIQdJvLWd1w4luvSn8IrTvAn?=
 =?us-ascii?Q?NpT5PM2xW+eWtq+JqA9PZ0NLqQeG6HOwCCkTmrfPPaa1HO51IsRlydXGL9Mq?=
 =?us-ascii?Q?zBJzTwXFK5EEFWsgS1b3I/78lMwOQKjr+jpDVke19dUUD7V5pF+DQarGMgG4?=
 =?us-ascii?Q?XZlf7K3dpjD/+h/mbIZV+/Bgcnq50atDLYke7WMQWUm0H0gDnNcfsheZ56cD?=
 =?us-ascii?Q?k/ijt8+hTRmefS392NVp33MjaUTMuubPmasN5C0xObsrD+2ZrI/5YjvAWVhc?=
 =?us-ascii?Q?F4NXMSejhfgLxAmhkbfwV0m4T6k0QOXUVxguu8ZCqgvybwLrqk79ko5mBpWQ?=
 =?us-ascii?Q?h5y/b1uPlFgiy5reHK91VI6z17BG8YqsCgxpIbEv4b7bpHC3QDlfm0S98QsR?=
 =?us-ascii?Q?L0wSY/oDjRamlC55zw4HcpsWWQuclxELhRMgXZ4COsWPgEQ986kR7kZSuUKO?=
 =?us-ascii?Q?YK8XmfHvHy0FPgDrgUl+gB6jF3CJaq8835oALNKm8XL6Uw4MErtN70nyEDMY?=
 =?us-ascii?Q?jKcOeiTBoo02Pzy3ygv/Q+jka0neUl5BtDPgQ3xtryalVltyFBxFkIhG6LKe?=
 =?us-ascii?Q?qs3IKamxOU4OYFdIBrkv8BwKPnaNlvf3zHQgOBj7KNJ4l2HWz+uK13FxUFH5?=
 =?us-ascii?Q?nkj/TyJqvxWDsdz8DpTUjFR4f+irbVsdZKPEvCfk5fxCA/yq2sK0GtYr4Cmp?=
 =?us-ascii?Q?+aKS9TRCDJRzLQgDaYIYcCA2mUN4almYDu86mtN2fUhXv3YPCM3EkOIZEeNC?=
 =?us-ascii?Q?O3BJmxDbCuP1FuMt80pD3BaGXRTAuh29jN9Lx9S0cCoWeW5aTg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(82310400023)(1800799021)(36860700010)(376011); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 07:17:48.5359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 585fa2a0-699d-4ffd-461e-08dc902fec88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8450
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

Add versal2 mini emmc configuration.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/amd_versal2_mini_emmc_defconfig | 69 +++++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 configs/amd_versal2_mini_emmc_defconfig

diff --git a/configs/amd_versal2_mini_emmc_defconfig b/configs/amd_versal2_mini_emmc_defconfig
new file mode 100644
index 0000000000..7ad44386a6
--- /dev/null
+++ b/configs/amd_versal2_mini_emmc_defconfig
@@ -0,0 +1,69 @@
+CONFIG_ARM=y
+CONFIG_SYS_CONFIG_NAME="amd_versal2_mini"
+CONFIG_COUNTER_FREQUENCY=100000000
+CONFIG_ARCH_VERSAL2=y
+CONFIG_TEXT_BASE=0x10000
+CONFIG_SYS_MALLOC_LEN=0x80000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x10000
+CONFIG_ENV_SIZE=0x80
+CONFIG_DEFAULT_DEVICE_TREE="amd-versal2-mini"
+CONFIG_DEBUG_UART_BASE=0xf1920000
+CONFIG_DEBUG_UART_CLOCK=100000000
+# CONFIG_PSCI_RESET is not set
+CONFIG_SYS_LOAD_ADDR=0x8000000
+CONFIG_DEBUG_UART=y
+# CONFIG_EXPERT is not set
+CONFIG_REMAKE_ELF=y
+# CONFIG_AUTOBOOT is not set
+CONFIG_SYS_CONSOLE_INFO_QUIET=y
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_BOARD_EARLY_INIT_R=y
+# CONFIG_BOARD_LATE_INIT is not set
+# CONFIG_CMDLINE_EDITING is not set
+# CONFIG_AUTO_COMPLETE is not set
+# CONFIG_SYS_LONGHELP is not set
+CONFIG_SYS_PROMPT="versal2> "
+# CONFIG_CMD_BDI is not set
+# CONFIG_CMD_CONSOLE is not set
+# CONFIG_CMD_BOOTD is not set
+# CONFIG_CMD_BOOTM is not set
+# CONFIG_CMD_BOOTI is not set
+# CONFIG_CMD_ELF is not set
+# CONFIG_CMD_FDT is not set
+# CONFIG_CMD_GO is not set
+# CONFIG_CMD_RUN is not set
+# CONFIG_CMD_IMI is not set
+# CONFIG_CMD_XIMG is not set
+# CONFIG_CMD_EXPORTENV is not set
+# CONFIG_CMD_IMPORTENV is not set
+# CONFIG_CMD_EDITENV is not set
+# CONFIG_CMD_SAVEENV is not set
+# CONFIG_CMD_ENV_EXISTS is not set
+# CONFIG_CMD_CRC32 is not set
+# CONFIG_CMD_LOADB is not set
+# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_MMC=y
+# CONFIG_CMD_ECHO is not set
+# CONFIG_CMD_ITEST is not set
+# CONFIG_CMD_SOURCE is not set
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_OF_EMBED=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+# CONFIG_NET is not set
+# CONFIG_DM_DEVICE_REMOVE is not set
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ZYNQ=y
+CONFIG_DEBUG_UART_PL011=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_SKIP_INIT=y
+CONFIG_ARM_DCC=y
+CONFIG_PL01X_SERIAL=y
+CONFIG_FAT_WRITE=y
+# CONFIG_GZIP is not set
+# CONFIG_EFI_LOADER is not set
+# CONFIG_LMB is not set
-- 
2.17.1

