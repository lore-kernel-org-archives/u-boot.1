Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE76DC27C79
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 07:18:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D3A688445;
	Wed, 19 Jun 2024 09:17:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HlV4qg6L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92CFA88445; Wed, 19 Jun 2024 09:17:56 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::613])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC8EE8844C
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 09:17:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjKPT2ZCtwovhC0hLOPts2RKcFB7vCUSWqk+S7dDnO5V0H3kpDxFRmJ4s5WRFhPLt/PS1gaEGazYFYallwVczxRU3eGI2kB2MOk83hS1Y8CTW8qlGjJQ5hc5Md5NO376BM+fRmv9/keshYN9rvLoLTeIEzwZ2qb82pCtfZylyiHwF4+k/gFHMwrxw/Or9CvSeNn4YxUj5Lo8w2oNNJ87UUsNMrGsvChnU642pgFDc+S58R8afktCE38mbZ2BVmpDNxxuU93iuhNvlfKu3rhXQyGd/R/2VdmYikdzdWJSlPljABX2FgCkLafyQWcYRE6WS9TR99DYiucWLXsOJo5W3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkOX2E1yD71/ZrOqsBBRFG3BZZt/4KsVEelECUeIifs=;
 b=hUt4cODItYMVES4iQ1D8WdMna2a7/mWE59nTdCI0WsaG5GfhCfpnAXSqX4wiwHL3ti+YXmLjH0mrvmwe8xQCn276hgLRo3C5iDNFmxzTBE5ylMeNcBtdctg6QTpz6CCz5iOAPnLv73Qsuyu6HwZLehmSemsDSQLQMYqxnkbC10AluTsqpz0s5mOelRcT+AIKc34sbU0qmFTKuCB4+UkrGsJEdSsya9p8aZv9Y6gIZuFbeSuRFowV9tz/0v9dK6xRpcoA1NqZl4hEnr1OLlTVA/RzD7bhj4zkEKHDW54pjI6iZzUGZtH+v+PpisVioJuJTTP9hX8gD5cZgYYusLC0qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkOX2E1yD71/ZrOqsBBRFG3BZZt/4KsVEelECUeIifs=;
 b=HlV4qg6Lp2oJ/eIucu3WTgLKuc/ThHQW/SsfvZDj0T6xxDeZZtR6NolNVDnOoYnxQ0uovG/AAftyuRCy1YuYEUxo7Y5huvXOyFriEbVATgl9V87dIAvMhbCOMNOb0bkSDBtQUB5md72xwg45QLVo86vTviE6Pmhj0JILyDtKk+w=
Received: from PH8PR07CA0037.namprd07.prod.outlook.com (2603:10b6:510:2cf::17)
 by DS0PR12MB7608.namprd12.prod.outlook.com (2603:10b6:8:13b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 07:17:47 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::ec) by PH8PR07CA0037.outlook.office365.com
 (2603:10b6:510:2cf::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Wed, 19 Jun 2024 07:17:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 07:17:47 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Jun
 2024 02:17:46 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Jun
 2024 02:17:45 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 19 Jun 2024 02:17:44 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@amd.com>
Subject: [PATCH 3/4] arm64: Add versal2 mini ospi support
Date: Wed, 19 Jun 2024 12:47:32 +0530
Message-ID: <20240619071733.10256-4-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240619071733.10256-1-venkatesh.abbarapu@amd.com>
References: <20240619071733.10256-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|DS0PR12MB7608:EE_
X-MS-Office365-Filtering-Correlation-Id: ece19faf-6eb5-4d06-08cf-08dc902febb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|36860700010|82310400023|376011|1800799021; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wzXUaZVqXBDnQu8/8U/UlwqfTYykABdrCb/dDiVUrYVvCU070Gplrnhdj5WK?=
 =?us-ascii?Q?f9MIvz7E2CqrTPgHtrG4Me4E+U0yqVOAbb1wWfXjdsQl5nIqip6Xdnii3alD?=
 =?us-ascii?Q?IWz30JzFsezm3zhxjCd5mXwEExvnRE6l68171QT7oFOIUZN/+YxaxOvL3Aq2?=
 =?us-ascii?Q?5NtpLexRgpR0MoG+Jhg47qNUOhUgYS/9Wjwl4IQuTIhvRBlDSS1vAkGr3JyS?=
 =?us-ascii?Q?S4e0D3VphSHUty5K0io2bedZj36niLkJ7NI+7yOVnm72uK2Or4cCp72iHq3N?=
 =?us-ascii?Q?3oVJlGOX4pHwnGBLutVqoRYJ2Bdm+AgcLG1EnkbC+xc7i9o/7ebjXv74Ri2o?=
 =?us-ascii?Q?cABSH1imw6lB9lpZfCewwJTlVixHGagTC8sbWoL4VYVj32ye6aLLhKju1McB?=
 =?us-ascii?Q?LOkNxwgVzFaNqsQ6ePxn5kxe0rfTEBR1zgHsbFH2xixoNN+ZHzzCH7D87kxP?=
 =?us-ascii?Q?Efah9p4ggRrii6keUWQIzxw+07/iDWbY4+yzdM6hEJhS1+6y3gR/OLvBmGtV?=
 =?us-ascii?Q?M1ZNoaL6DvFQS2eSdfwnyhl/ZPUjQ33XOW/LY050e5uTgIgwxb0k/P9eu9/C?=
 =?us-ascii?Q?ciM/RttZ3RzYvtqwr1oBYWGF/5w5xodF0Q5QLeXOK2XJUWVWXpnOWgxbL7Rs?=
 =?us-ascii?Q?vfd9JnjWIab0GRTzMoh0U+vyTOidytymhehaxSiPxP5NcKI5lxq4juB8D/T2?=
 =?us-ascii?Q?Re4ZUT1S/rfq9J7qYpzBpDF21TvimHdc96K9XsYkmVhEoaIMSpLYUfK+9fdz?=
 =?us-ascii?Q?9+ZSXpZyfpaLsFjvJDp8A/G0R2fk7mkiUuJkqWguK4/IgNaUjin7E6IMRqY5?=
 =?us-ascii?Q?rS2rxin3dMunlarcjjy/QTzdkd37SNUTkBrASzaWlfaGRB220kZaO38SalCG?=
 =?us-ascii?Q?T8U1dXgfilfLJSF+Xs/D5iDnWDqMzs3/vzBHzfxRVM+273bxaWz+vsD0MPyh?=
 =?us-ascii?Q?myS2MTG4/pD9kIKS/K3lUqhxBrDfOcHE6NE/7a9Rba0KzvJY3W/G7d9bAg5P?=
 =?us-ascii?Q?LXA/DKNXO70I/v9AXDM22XFimpDAJn5oObkMdNI+T4zK7/tZc3oPE3j/cTCU?=
 =?us-ascii?Q?Ne/2gSL8Hovqc+IrnuAe+OMmk++j9NI+tmRT2k8EIcAeM8xqCl1SOfOJ8Cdk?=
 =?us-ascii?Q?WhnieWB+e77dpIidTTRE3JVmJCc8RAKyohed2giHOpk8WIOkCC2fU+Wp10vW?=
 =?us-ascii?Q?NLpXYutMnLwLMnyRZonc8Gx4+NmqtKDwtDvv/Q6l7ExgfvucOs3EMhnKxKfl?=
 =?us-ascii?Q?g6E1hvHe81gA3QC8Rzw0rxuc6cx9xPcAlv7EmU5VKQkcuWZVfQavSckolxx4?=
 =?us-ascii?Q?I51YQTWQ67QoZ5ZyF/zBx1C6rsixaMHov2fZ4yeML/NAeChgHfrSBYSrz5oD?=
 =?us-ascii?Q?34Q3wYtjphpWw0o5miu+ngtj+cn80EnPGc/O+RM+yVA5vji+ow=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(36860700010)(82310400023)(376011)(1800799021); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 07:17:47.1253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ece19faf-6eb5-4d06-08cf-08dc902febb1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7608
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

Add versal2 mini ospi configuration.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/amd_versal2_mini_ospi_defconfig | 84 +++++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 configs/amd_versal2_mini_ospi_defconfig

diff --git a/configs/amd_versal2_mini_ospi_defconfig b/configs/amd_versal2_mini_ospi_defconfig
new file mode 100644
index 0000000000..2242960392
--- /dev/null
+++ b/configs/amd_versal2_mini_ospi_defconfig
@@ -0,0 +1,84 @@
+CONFIG_ARM=y
+CONFIG_SYS_CONFIG_NAME="amd_versal2_mini"
+# CONFIG_ARM64_CRC32 is not set
+CONFIG_COUNTER_FREQUENCY=100000000
+# CONFIG_ARM64_SUPPORT_AARCH32 is not set
+CONFIG_ARCH_VERSAL2=y
+CONFIG_TEXT_BASE=0xBBF00000
+CONFIG_SYS_MALLOC_LEN=0x20000
+CONFIG_SYS_MALLOC_F_LEN=0x4000
+CONFIG_NR_DRAM_BANKS=3
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xBBF20000
+CONFIG_ENV_SIZE=0x80
+CONFIG_DEFAULT_DEVICE_TREE="amd-versal2-mini"
+CONFIG_DEBUG_UART_BASE=0xf1920000
+CONFIG_DEBUG_UART_CLOCK=100000000
+CONFIG_SYS_MEM_RSVD_FOR_MMU=y
+# CONFIG_PSCI_RESET is not set
+CONFIG_SYS_LOAD_ADDR=0xBBF80000
+CONFIG_DEBUG_UART=y
+# CONFIG_EXPERT is not set
+CONFIG_REMAKE_ELF=y
+# CONFIG_LEGACY_IMAGE_FORMAT is not set
+# CONFIG_AUTOBOOT is not set
+# CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
+CONFIG_SYS_CONSOLE_INFO_QUIET=y
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_BOARD_EARLY_INIT_R=y
+# CONFIG_BOARD_LATE_INIT is not set
+# CONFIG_CMDLINE_EDITING is not set
+# CONFIG_AUTO_COMPLETE is not set
+# CONFIG_SYS_LONGHELP is not set
+CONFIG_SYS_PROMPT="versal2> "
+# CONFIG_CMD_CONSOLE is not set
+# CONFIG_CMD_BOOTD is not set
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
+# CONFIG_CMD_ECHO is not set
+# CONFIG_CMD_ITEST is not set
+# CONFIG_CMD_SOURCE is not set
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_CACHE=y
+# CONFIG_CMD_SLEEP is not set
+CONFIG_OF_EMBED=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+# CONFIG_NET is not set
+# CONFIG_DM_DEVICE_REMOVE is not set
+# CONFIG_GPIO is not set
+# CONFIG_I2C is not set
+# CONFIG_INPUT is not set
+# CONFIG_MMC is not set
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SOFT_RESET=y
+CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
+# CONFIG_SPI_FLASH_LOCK is not set
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_MT35XU=y
+# CONFIG_POWER is not set
+CONFIG_DEBUG_UART_PL011=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_SKIP_INIT=y
+CONFIG_ARM_DCC=y
+CONFIG_PL01X_SERIAL=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_CADENCE_QSPI=y
+CONFIG_HAS_CQSPI_REF_CLK=y
+CONFIG_CQSPI_REF_CLK=200000000
+CONFIG_CADENCE_OSPI_VERSAL=y
+# CONFIG_GZIP is not set
-- 
2.17.1

