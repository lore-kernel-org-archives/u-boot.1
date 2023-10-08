Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4E9E95A82
	for <u-boot@archiver.kernel.org>; Sun,  8 Oct 2023 12:48:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1216F86A23;
	Sun,  8 Oct 2023 14:47:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="NFB/Q7F0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D49C86ACA; Sun,  8 Oct 2023 14:47:50 +0200 (CEST)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::60f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D436786A23
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 14:47:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josua@solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnLpFW5FITzuKTfvc9xP8p9egOAPRqDDPqceqhaG9ZjXRY/AI53RLdcVYL8vtAEEwq8hPcwx3lmMQ6W1QJg2NPXduE8ixcfVsyBL7uhegJb2sFcRPCUUAU/5E0a4AJLtiC5uMF6wT1VwPl6P8mSbSy1/fkoMOtFC6czu2S5w31Lrq5odD87NZHTAt954m8X/C7JIkwr6VcC1CzFkkg8R2LEe+We7Q89B6K1LGt/AmbBL9uYbo4yanIaWEh3pCWGzBkeMoPTBB3NGJb3XgQQTnfRmw+xWVXegMnDTo1TSoDw4DFslei7aC3ILkpQmPdE+uCMxqVYN4p0YTxGHKZkbLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhIk5pon1BY26MpOBk4EvDAXJLlFhDP4ikX/4+WvkVQ=;
 b=VUdRkhlqSLZg9Cn5QUs+L+jpKyeXt8TSs7M89JKUAP47VfvoDH0Qdb+J5ppwtyGWxGYhZ8jTHanOViCOy6HlBBd8B6fIAgk3fLAT4KpJqDSf0jgd8nC8B6OaP0nZDYcvTqkU2qtSTPcUdIg8UTVmGAOfL55Th35PZ9aLz0k2BynqsOmiSaNzvgXwwkPjFFeNfwJt/kMC3RhsVjr72jZTdpDMd9goBSIWk3QRNcsk+lwuZw6iecMtZ6sZIYL07sRMsuviUx51BDmemOuuPhV8s9CXmsg9O4hYqZWrkzDriuWAcK9DpP4e2tSZaFT2VqQq2cRyt9schbnHc9I/VZ/O/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhIk5pon1BY26MpOBk4EvDAXJLlFhDP4ikX/4+WvkVQ=;
 b=NFB/Q7F0e8P9nYfZjeo347004Xq5fS0frDWzedAJH3rBLrLfHhO2nH9r7SH8SnZjA527uj64282O+CJPtD8UQPTPi9kDAI2bWHC86yfiPQrIXt767n1Dqzt6nI0pa60o9DsHqv/tskubj6s4xwqYAKILXkfJp7Ppt2EOKxTQOEE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by AM9PR04MB7651.eurprd04.prod.outlook.com (2603:10a6:20b:280::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Sun, 8 Oct
 2023 12:47:43 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::986:55cb:8fd6:87a4]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::986:55cb:8fd6:87a4%5]) with mapi id 15.20.6863.032; Sun, 8 Oct 2023
 12:47:43 +0000
From: Josua Mayer <josua@solid-run.com>
To: u-boot@lists.denx.de
Cc: sr@denx.de, sjg@chromium.org, kabel@kernel.org,
 Josua Mayer <josua@solid-run.com>
Subject: [PATCH 3/3] arm: mvebu: clearfog: Add defconfigs for eMMC booting
Date: Sun,  8 Oct 2023 14:46:21 +0200
Message-Id: <20231008124621.18803-4-josua@solid-run.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231008124621.18803-1-josua@solid-run.com>
References: <20231008124621.18803-1-josua@solid-run.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0019.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::14) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|AM9PR04MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: aaf6c6e9-2236-4923-4391-08dbc7fcc3b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sh/1tPvCFhN4OLV+oJLugyBSuzcsl7A8i+o0JY+S9zMvQIu1SvTeIfrr9PC5F7a//nWtpjNjAkqvmq59SV6y/qw/411eRe2T8cVfEJDJ1I41RO135t1In7utUbx1fyHid3m9IQ4vNM09ctVkjcrMe111ydvX6Wl7kRO8l/ebYco60svJTI7oolx8Iop8GfyYW5lRcPHhkWUmwkUa2aRxMchU3afz8Eo1TdFgUKgYWdv0FwMxBWKx7x03ncyNmByWD+huwlOQf/Sw6fckjX+EB+1UwMP7pKBdKnIYmpZqaDLwayUJ+iSFG3PDa+0ykv3FB7C4NRaOOcnUsJSG9RZ04DgScK7QS13uXfijO6/Oya7NsLJ01aRux0JdgzIAF2ZjyKvf11zk+EQk/4bFUP9Dx4Z0YuYlRhL/mNRJGsEzYTBn9J+Gub0LjHi7K0pm4RHQldHzfUDUwzZYzg+G12+hfSNkjQubQvzvkqtUQAb2yJ88mvVqbQ3MfzsRJXHVS2aFE+AEPeF75nwrOQ04iFdqeaGlKktPWtGJk1RriTcIleTh8KEgyoLZL0PAx6nBce0r9lJ1wlpCs0rZ5cFjvXHyCs16xRw9SbmMDj/yN5oQeGAnMpEIfeWnqX/subSvUDen
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8963.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(136003)(346002)(376002)(39840400004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(83380400001)(1076003)(107886003)(2616005)(26005)(66946007)(66476007)(66556008)(316002)(6916009)(8936002)(5660300002)(8676002)(4326008)(41300700001)(6506007)(52116002)(6666004)(6512007)(2906002)(6486002)(478600001)(36756003)(38100700002)(38350700002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kBpdsSTNuZDvuEoHr4E/l/th/vjb0EF1wdkmDebr8bsJlL9f4YCmXcUZphZq?=
 =?us-ascii?Q?dBg7VQ0UOZrDfKQaPyAKL/HjV+MYl6jIaqRDzKHefemltPuUPyz/KqqsKni6?=
 =?us-ascii?Q?f8IpcR+h50wuftE5VEgnkGYSqDBTBNsJhskGEzHgI3/8azJ5cFjaO17ZLF0S?=
 =?us-ascii?Q?jlZNrbn8AXlRNgGWXkqdSfnvu7ri6Fybm6mMDAUAJ8OVfRWKKPkSkqir+6xO?=
 =?us-ascii?Q?FpIJZyh1bdrXU6BSvPruaQyz6tf6Tzd5XHRDEaM8Fp9dhW2CasWuQiNIw5Rf?=
 =?us-ascii?Q?uMCTw1TpLV3+gAQzymKUX2s1cGtjYxh6sve0t8BiJ9mAwTvZ7DHdM3YBtfKZ?=
 =?us-ascii?Q?wOKlggGWLVPAcwq8LFyt7S1Oa5jsiHSLRx/y0+nLMZ39BSIuU1tObTvcuCfD?=
 =?us-ascii?Q?xTJSN2FZ4sTQHiaHX63d49NICjyVOwOmhB3I7oc6vCNBPe/6CyP28ybAeFJY?=
 =?us-ascii?Q?7UWXs27kNyQSF+ZShwMO7ERQu5TBBZn2MyDKC6Vo9sN/xhmOEOmaFeKC8Mzi?=
 =?us-ascii?Q?UOnc3DAZwpYO+rVu/PnZyRIRlDs+msH+erkT1KSwalj9zKHacXxBCLCyWq2q?=
 =?us-ascii?Q?cU1VqxmSTMNJgoiXwI6nkS2B/ASJf5YX6NAGVIh1Gca4Vuq/uLpN2hjxIrU4?=
 =?us-ascii?Q?n/JzpuizKDie5uF6V4qv0nJVOUrslPlGhUHSN+S/mkb+SFFToa8cXa3Rj2Fs?=
 =?us-ascii?Q?AI27AiAqAJ0QwGswy8xGxN2KeYcoqzkZQ9s2ZEAjeLwXNvofyhi3P7xqAQ4S?=
 =?us-ascii?Q?ciREgQwFUCl4PmiiATbZG0xJk9FzeWKLG5mKl5WbubdPanjprgklUwvDYKRb?=
 =?us-ascii?Q?D8H6tM1n44EYI7l3J6StD6o99mm43/02zr7MWjZejLMK4CLsVQUM7rsc+4iH?=
 =?us-ascii?Q?iY4Q831Jw6QjOUCibGAL4ToYJuvSin1NevN6wjfHqALfQS0Rs5Z8uzRUQ4km?=
 =?us-ascii?Q?Z06uRikHnMq0VCaseaHiHCEWTKZocJtnBuJfvXHiAouxgG9C18DlhJpm8vJV?=
 =?us-ascii?Q?CmSBljAXl70I4YzDy4G3riZqjoWR2MrlxOtsLnmk0Q/B1QVc858raBI5ypzl?=
 =?us-ascii?Q?9Be3eHJ1oMFQ+QhUkDbLTngPpzt3g8QM43oNQAReDm5qMFCL4Nt4gntlxXy5?=
 =?us-ascii?Q?4/Sc6TMcBj8hvTQMHpxgCBYjPAYIIxRtlB4dXRfdYLr21vKQw3TBSsE3vdIQ?=
 =?us-ascii?Q?zLd61B16CaEHUp++zYfGNgS7jqGWKwQhtfmxynZj3SxBF5P+J4dOr7IHH0iU?=
 =?us-ascii?Q?wgB9MxXTRqforHignuWpLDIZZILMbnXI5ykAzNjMxZHvT9LHnKWJXgTRTA5Q?=
 =?us-ascii?Q?kLJcm4OTBTvDSkkGTPQCMwtSCvelLTeIdGlSyT46BsOey2tVHTo6e3IaEwO3?=
 =?us-ascii?Q?Ok5jGAwcizRETcCSPnaGmM0gYv8wpHpvQxm2QEm80/3WuWY6ZtPeAjM1MRAd?=
 =?us-ascii?Q?+WTrjwQksOgG6IodTHXm7BJrDDUFlKT/+DqCL82LVytk0SiD0SLe1OFSu+Qb?=
 =?us-ascii?Q?MhSYLbL5XxyI3035UdvFUCh3vvdxsL4Oz9PTZtvChSs+XvZCtEhmsVTBsUi/?=
 =?us-ascii?Q?+SWZUT+KfuVD34MxWX5BNySUb+yMQa9BbVlyJL6j?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf6c6e9-2236-4923-4391-08dbc7fcc3b1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2023 12:47:43.3197 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DkwcrEppXUoc1+TMsLqBgC+cJugkmRownrOnSrdA4at/YD3+KoI3+abUjT0KuCSldqrID+SpGmN/Nkd1NHuHew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7651
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

Armada 388 can boot from either eMMC data, boot0 or boot1 partitions.

data partition requires booting from LBA-4096 to avoid conflict with
MBR. When booting from boot0/boot1 environment should be stored there
respectively, too.

Add 3 new defconfigs, for each eMMC partition:
- clearfog_emmcboot0_defconfig
- clearfog_emmcboot1_defconfig
- clearfog_emmcdata_defconfig

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 configs/clearfog_emmcboot0_defconfig | 82 ++++++++++++++++++++++++++++
 configs/clearfog_emmcboot1_defconfig | 82 ++++++++++++++++++++++++++++
 configs/clearfog_emmcdata_defconfig  | 82 ++++++++++++++++++++++++++++
 3 files changed, 246 insertions(+)
 create mode 100644 configs/clearfog_emmcboot0_defconfig
 create mode 100644 configs/clearfog_emmcboot1_defconfig
 create mode 100644 configs/clearfog_emmcdata_defconfig

diff --git a/configs/clearfog_emmcboot0_defconfig b/configs/clearfog_emmcboot0_defconfig
new file mode 100644
index 00000000000..215b7708a0d
--- /dev/null
+++ b/configs/clearfog_emmcboot0_defconfig
@@ -0,0 +1,82 @@
+CONFIG_ARM=y
+CONFIG_ARCH_CPU_INIT=y
+CONFIG_SYS_THUMB_BUILD=y
+CONFIG_ARCH_MVEBU=y
+CONFIG_TEXT_BASE=0x00800000
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xff0000
+CONFIG_TARGET_CLEARFOG=y
+CONFIG_MVEBU_SPL_BOOT_DEVICE_MMC=y
+CONFIG_DEFAULT_DEVICE_TREE="armada-388-clearfog"
+CONFIG_SPL_TEXT_BASE=0x40000030
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_STACK=0x4002c000
+CONFIG_SPL=y
+CONFIG_DEBUG_UART_BASE=0xf1012000
+CONFIG_DEBUG_UART_CLOCK=250000000
+CONFIG_SYS_LOAD_ADDR=0x800000
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_AHCI=y
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTDELAY=3
+CONFIG_USE_PREBOOT=y
+CONFIG_SYS_CONSOLE_INFO_QUIET=y
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_SPL_MAX_SIZE=0x22fd0
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x40023000
+CONFIG_SPL_BSS_MAX_SIZE=0x4000
+CONFIG_SPL_SYS_MALLOC_SIMPLE=y
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_I2C=y
+CONFIG_SYS_MAXARGS=32
+CONFIG_CMD_TLV_EEPROM=y
+CONFIG_SPL_CMD_TLV_EEPROM=y
+# CONFIG_CMD_FLASH is not set
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_SPI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_TFTPPUT=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_TIME=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_MIN_ENTRIES=128
+CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ARP_TIMEOUT=200
+CONFIG_NET_RETRY_COUNT=50
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SPL_OF_TRANSLATE=y
+CONFIG_AHCI_MVEBU=y
+CONFIG_DM_PCA953X=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_MVTWSI=y
+CONFIG_I2C_EEPROM=y
+CONFIG_SPL_I2C_EEPROM=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_MV=y
+CONFIG_MTD=y
+CONFIG_SF_DEFAULT_BUS=1
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_PHY_MARVELL=y
+CONFIG_PHY_GIGE=y
+CONFIG_MVNETA=y
+CONFIG_MII=y
+CONFIG_MVMDIO=y
+CONFIG_PCI_MVEBU=y
+CONFIG_SCSI=y
+CONFIG_SPL_DEBUG_UART_BASE=0xd0012000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550=y
+CONFIG_KIRKWOOD_SPI=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
diff --git a/configs/clearfog_emmcboot1_defconfig b/configs/clearfog_emmcboot1_defconfig
new file mode 100644
index 00000000000..59f88c64a2e
--- /dev/null
+++ b/configs/clearfog_emmcboot1_defconfig
@@ -0,0 +1,82 @@
+CONFIG_ARM=y
+CONFIG_ARCH_CPU_INIT=y
+CONFIG_SYS_THUMB_BUILD=y
+CONFIG_ARCH_MVEBU=y
+CONFIG_TEXT_BASE=0x00800000
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xff0000
+CONFIG_TARGET_CLEARFOG=y
+CONFIG_MVEBU_SPL_BOOT_DEVICE_MMC=y
+CONFIG_DEFAULT_DEVICE_TREE="armada-388-clearfog"
+CONFIG_SPL_TEXT_BASE=0x40000030
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_STACK=0x4002c000
+CONFIG_SPL=y
+CONFIG_DEBUG_UART_BASE=0xf1012000
+CONFIG_DEBUG_UART_CLOCK=250000000
+CONFIG_SYS_LOAD_ADDR=0x800000
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_AHCI=y
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTDELAY=3
+CONFIG_USE_PREBOOT=y
+CONFIG_SYS_CONSOLE_INFO_QUIET=y
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_SPL_MAX_SIZE=0x22fd0
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x40023000
+CONFIG_SPL_BSS_MAX_SIZE=0x4000
+CONFIG_SPL_SYS_MALLOC_SIMPLE=y
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_I2C=y
+CONFIG_SYS_MAXARGS=32
+CONFIG_CMD_TLV_EEPROM=y
+CONFIG_SPL_CMD_TLV_EEPROM=y
+# CONFIG_CMD_FLASH is not set
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_SPI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_TFTPPUT=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_TIME=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_MIN_ENTRIES=128
+CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_ARP_TIMEOUT=200
+CONFIG_NET_RETRY_COUNT=50
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SPL_OF_TRANSLATE=y
+CONFIG_AHCI_MVEBU=y
+CONFIG_DM_PCA953X=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_MVTWSI=y
+CONFIG_I2C_EEPROM=y
+CONFIG_SPL_I2C_EEPROM=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_MV=y
+CONFIG_MTD=y
+CONFIG_SF_DEFAULT_BUS=1
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_PHY_MARVELL=y
+CONFIG_PHY_GIGE=y
+CONFIG_MVNETA=y
+CONFIG_MII=y
+CONFIG_MVMDIO=y
+CONFIG_PCI_MVEBU=y
+CONFIG_SCSI=y
+CONFIG_SPL_DEBUG_UART_BASE=0xd0012000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550=y
+CONFIG_KIRKWOOD_SPI=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
diff --git a/configs/clearfog_emmcdata_defconfig b/configs/clearfog_emmcdata_defconfig
new file mode 100644
index 00000000000..335b50e3c48
--- /dev/null
+++ b/configs/clearfog_emmcdata_defconfig
@@ -0,0 +1,82 @@
+CONFIG_ARM=y
+CONFIG_ARCH_CPU_INIT=y
+CONFIG_SYS_THUMB_BUILD=y
+CONFIG_ARCH_MVEBU=y
+CONFIG_TEXT_BASE=0x00800000
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xff0000
+CONFIG_TARGET_CLEARFOG=y
+CONFIG_MVEBU_SPL_BOOT_DEVICE_MMC=y
+CONFIG_DEFAULT_DEVICE_TREE="armada-388-clearfog"
+CONFIG_SPL_TEXT_BASE=0x40000030
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_STACK=0x4002c000
+CONFIG_SPL=y
+CONFIG_DEBUG_UART_BASE=0xf1012000
+CONFIG_DEBUG_UART_CLOCK=250000000
+CONFIG_SYS_LOAD_ADDR=0x800000
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_AHCI=y
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTDELAY=3
+CONFIG_USE_PREBOOT=y
+CONFIG_SYS_CONSOLE_INFO_QUIET=y
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_SPL_MAX_SIZE=0x22fd0
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x40023000
+CONFIG_SPL_BSS_MAX_SIZE=0x4000
+CONFIG_SPL_SYS_MALLOC_SIMPLE=y
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET=0x1000
+CONFIG_SPL_I2C=y
+CONFIG_SYS_MAXARGS=32
+CONFIG_CMD_TLV_EEPROM=y
+CONFIG_SPL_CMD_TLV_EEPROM=y
+# CONFIG_CMD_FLASH is not set
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_SPI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_TFTPPUT=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_TIME=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_MIN_ENTRIES=128
+CONFIG_ARP_TIMEOUT=200
+CONFIG_NET_RETRY_COUNT=50
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SPL_OF_TRANSLATE=y
+CONFIG_AHCI_MVEBU=y
+CONFIG_DM_PCA953X=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_MVTWSI=y
+CONFIG_I2C_EEPROM=y
+CONFIG_SPL_I2C_EEPROM=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_MV=y
+CONFIG_MTD=y
+CONFIG_SF_DEFAULT_BUS=1
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_PHY_MARVELL=y
+CONFIG_PHY_GIGE=y
+CONFIG_MVNETA=y
+CONFIG_MII=y
+CONFIG_MVMDIO=y
+CONFIG_PCI_MVEBU=y
+CONFIG_SCSI=y
+CONFIG_SPL_DEBUG_UART_BASE=0xd0012000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550=y
+CONFIG_KIRKWOOD_SPI=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
-- 
2.35.3

