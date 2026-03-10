Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D28AEFD2D74
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 13:15:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B37E9840DF;
	Tue, 10 Mar 2026 14:12:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kwT35i/M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD90783FA7; Tue, 10 Mar 2026 12:44:10 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AEE683981
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 12:44:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JayoF+Jhzv7MbxwgWshlKPppymFoxEg82gysIFrQJu+EIHGsJN7HighN45IqKbItoFUEfV7Y5Zg32naDF0wt0qB4BgQ7iwxLcYUhi3smwxo8XpmYGxpy34k8Bqi3jTGCpN3uO3BpwnmxfSlHo3dEa4Ybcv2VUe9xbJ0LEkQpNHoEEVTnLv2GJ/L3O+hBEXPfqWSVlY6VEkd+sJhkN8Qm1NZSAc7gyKYdn73D9SyvflvsypgqInlSkCGseMY56OOLwDxsiLgoT79Kr7sHABVRU6OJ8mR/Gk4G4o7UXs6KJTQbw6LHgqWWhpWHTRacuMRoLWJxDKyOseSjNBjtFEzvTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKp5gyOsPKMyiskzO5joL+8sjD+nhCdJRxayqsOv5Xk=;
 b=M0yx7swM46v/cPBQeNIn12brOfuvatJNQZnRpvMQjMvV22KMjSqxCG7QSdbhGRZZd1xV7zAQE81tAMuktCkD/cLOXJcCZP7uqR/JioFw3/ni6s7PlmiTDaQUNGs4e8GLf3SpmI/S23s993LgJRorpF7wpUqaoK1JUj9d2qe/8nhgqUVtfTnP+7SoDHyjbQgeFYuciun0o8eYGr4855JRbvaltjRrSmNuG3ylTn2m9Nsdsxos80Cc/UpDAQmXSGRLRbHHW1Ae2zVtW3UqioOQfpQCDLeo5ntFTCWCKO73hwUlRCuHRG2GKc0z75oAHZas7Oa6Zoee7Yg+V0gBpMPYBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKp5gyOsPKMyiskzO5joL+8sjD+nhCdJRxayqsOv5Xk=;
 b=kwT35i/M8/PGgQMyXe69Oimng9AT+SPF7s+H+QO0Gn/CHwjo0a6NLydDs38eMgNrsUFR8oYhj9Vv6lWsSom9cdMLzYFual5Vdfe87EDW8c55gulHeIU0Cfg8T0Lt47AOHlmWGgE8CAuRqwZOqlr3gM1drI3aiM46RXchH/EBwzyO9/WVqZoL9nFzxFVJCjtyeBCmGNcUhXqKsVw+4vtlLsC4RhA0i9Vfau6Nn1kjbjwoM9eBWG96K4Kkf7yhl1jX7IS9NaS6dkE+rTC60WggXvfCxy7pHpakPZVJzUFJond2l5qVyZckUVNkiqerD5KlgPjbMznEH5hLzTyKfe2Wcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com (2603:10a6:800:306::9)
 by AS8PR04MB8753.eurprd04.prod.outlook.com (2603:10a6:20b:42c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 11:44:05 +0000
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7]) by VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7%4]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 11:44:04 +0000
From: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>
To: uboot-imx@nxp.com,
	u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, ye.li@nxp.com, simona.toaca@nxp.com,
 viorel.suman@nxp.com, marex@nabladev.com, ravi@prevas.dk,
 fedor.ross@ifm.com, sebastien.szymanski@armadeus.com,
 joao.goncalves@toradex.com, ji.luo@nxp.com, semen.protsenko@linaro.org,
 sjg@chromium.org, tharvey@gateworks.com, ping.bai@nxp.com,
 qijian.guo@nxp.com
Subject: [PATCH 2/5] arm: mach-imx: Add command to expose QB functionality
Date: Tue, 10 Mar 2026 13:54:21 +0200
Message-ID: <f36422cba885832720f039de624466468027f1ec.1773137310.git.simona.toaca@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773137310.git.simona.toaca@nxp.com>
References: <cover.1773137310.git.simona.toaca@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0002.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::7) To VI0PR04MB11917.eurprd04.prod.outlook.com
 (2603:10a6:800:306::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11917:EE_|AS8PR04MB8753:EE_
X-MS-Office365-Filtering-Correlation-Id: 12defbec-7925-4b96-066a-08de7e9a5493
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|7416014|1800799024|366016; 
X-Microsoft-Antispam-Message-Info: xfjmxfX5F3vs//e4kn+2h9VRh2FOObNfl/XTE8BVmHRFPI1CXJZrO/sX3d8QDiRZVV6KNInChHzffDY1J2Wmoe02nJHcJkZ0qwiynyw4GM2yzHX5udr/cwkI7M8b326JD6B9o1WDlQlWNC1d9JOqBttKAzSluLeexnYlXXwbf6Y1KMqUTvXl6/3fBBAj0+w97CpJvzCCYorCvwHjcahoKQC93aRdPfgW4YEYlUf3HtrUF00LAm5hwZJHERSwnpIg7Hh90ocMDOJ1UvPszN+N7b4y/EwJwSLAlLpCHn8ygYzBqGB4sPZoFXx4jqhbqeMxQQKgE/cD4MrkvhszVnGFAjVLjT00jefbap6shVexzEN1D2M1mIFnxAMDhGppFY+T/QwxSzlHzPu8WGyabv6JcD73qOEr2BBJnaBD62QZrFU9EwQkchiVftTK6mfquKx4jtgHuZcnmj05tx5pTpv7LtqIBQFrPuXx1HvrXZVoX7v5banQwB2BAtDVHypzbvHdyw/M1j15vPP8790c2vVY2URbZsuogk0iFfj8k7b6A+AY/HJWeolSIKaNqSjafB5fT6/mNXUUYBmXv79lj4Hz5n6zidF9zqSu9y3RrIN1f/vB5+YobUghBOGZBuHy/lVAoFUdF+O+8mnwLSTyiYFjJj0L8wozg9H2D0qhG7ECo4i/fbAihReCv9wgAeCHQkSWfbHEULKdsgIcvDBleP5udkWAOk/l4ZQnjAGsxZIDIBg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR04MB11917.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(7416014)(1800799024)(366016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8mZCZek6DGG3KjgxArFGjWf54HDGvdGKxWAJu2qA+78DmpDIpAFrEUoQj92e?=
 =?us-ascii?Q?Qi2Ab+s1dcK/ZT38CqLniRVcSSakWIzsJR1FTG2au7WuyHVau/8sr4GnHnLT?=
 =?us-ascii?Q?M8wq0apqhlYOrg3haiypBMohYQuox3V4Ao4AKM1m4RPKnYe3vRSLZPsNV2ar?=
 =?us-ascii?Q?viDb1rKwClJkkK2/qxy2/Y8QifFZ6DUdZNDEoWwpZVZLAlnaMfmqoPKUZWJ7?=
 =?us-ascii?Q?W2AA50Klbwl/BKvQtO4oc/RpxBZsEK2Ls2qLus3mXWEJixDMZzwUMON/GoMj?=
 =?us-ascii?Q?oopJE4/UTaHwI7CT5WbOidHfLCKYfelzWdccyn7kbmSnpa2GMxcFg1V/UiDp?=
 =?us-ascii?Q?ddmxzAZ5SGuM3zC9Sz3lRREnbjbe1jZGzmFnbyCPnZEbSZtvhBH1Yqs338VD?=
 =?us-ascii?Q?UoQkZEXM2KCvhgIYhQNHmKpaA8wvh0JlG2SNuVuP8iQHfH7pVSKXnSm15+y5?=
 =?us-ascii?Q?oAtIihbrfRV6rLfBHx8Pn7fh/nhuOSUXU23H9oMwcTWmVgUTdsfwa3ynwVJm?=
 =?us-ascii?Q?pEUiJUl5yQj4U6Lsb5QJZxKAgok4DEgMHF/ttdoYWceCoZcWPeKlEm6LeAvw?=
 =?us-ascii?Q?ySJtbo9K2/FlFziqJ6aG5JqZVNXhyfIxk1a+2Hto3ZARPL8ZnNMvNMUYLt8Q?=
 =?us-ascii?Q?Jw+H+egkQtKCKi2N8Jm1nxHazZah0doxjPJNV4KE6TcyUBVwy2T6fMh4R+c1?=
 =?us-ascii?Q?J5k7/05Osy+xu2M0KmUP5M1X3dtTWf2jwa800Bo7fs3eaut0+hkVoVj/4Cu5?=
 =?us-ascii?Q?p2AoxP0p8nXmky80lsH2DU14DaAwYyBuHup22WkuDEzJNp6yZjz0ZO0Lt+80?=
 =?us-ascii?Q?pHggLzh18VdhnOZJzBVivI5UPSCcVruRO2iglhve3WMT3HvKCwsvU3R6DTT/?=
 =?us-ascii?Q?2NheL/hC9jAdeXrAc/c/8anZrgXRPpDml0vqJLepsYVck1/HwMsb+X/9m1nT?=
 =?us-ascii?Q?NelAdrhZHFXY/70PUoz+3bFZIfE15uHzJmrfTG1gQmnRQl/PkA6inM9eVFnh?=
 =?us-ascii?Q?7mpcAy9E4eCPuWMOOMhsgR3b+vYbEcD8JaIbklFpKWjUF/mNmnHsMI9daQQ9?=
 =?us-ascii?Q?K94/CZ0by7UIfyMigR2RHbEAj1CeVBPO4oKEl5kg/DjAw2ZlotkcOs8ptSJA?=
 =?us-ascii?Q?oLVTe7tOz5odc5MwCFZ6OBn+VMwpBFxripyPgzG6CIsZElnU6jSXVT7ceevk?=
 =?us-ascii?Q?K79Y/IOSEjAs1d8t/NvEB7pcFjoEK8P20WydxQFJuO+iHOyhkXjpQ4yrhm07?=
 =?us-ascii?Q?M/H6hc4OmmkEZt7g9wrfNFCfCefe9ml1g5c3NMheBBhK0JVZthw9+lBuJyOi?=
 =?us-ascii?Q?pCktY733NPrzGtZDUidB6NjQgsMuPLRK3YHYBxHqpnYDnqnBtvcLFyZMLhJn?=
 =?us-ascii?Q?qby0nKfngDP+KSHNR6LSNZm+QFmM6FA319Iawg098orRJhX1pYfeAzm8OQAX?=
 =?us-ascii?Q?YFQhSHfGUgi81oNAdAMmp3VgFQDcDmeCLaO3JkW9m9/UyRDlo8DFMAWdGVmz?=
 =?us-ascii?Q?EdxkPj0mJ3lRLztgy86ShP/LaJhEOnIR6ExJSqk7K1mdSAFSNeqTLobmzGL4?=
 =?us-ascii?Q?Wgfbeg98hSeuh5ZBWg0sHTr8hnydOA1BrAEH0LWot3N5lQNO/8YVYvJroUgY?=
 =?us-ascii?Q?iH+EY3VGPx+3PwLOrmDICV2B9HUeXvRszp+RmMSzezLZC8HdrZrZSxPKs7jk?=
 =?us-ascii?Q?TFeKk6ZM650/IOGVeh6RaG/yYKqyhuUyR80scqlIR6DFmQwFXdSgVEJ/AgWm?=
 =?us-ascii?Q?FviVCVXGLQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12defbec-7925-4b96-066a-08de7e9a5493
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11917.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 11:44:04.3960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KRh94dv4m+tfkf4wOA5BZArFwFwZ/LLB0vMB+YjRJhjwffJCk9MVpphCjGKR6tCy24g5xpw0kzc2J+Z4hZphxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8753
X-Mailman-Approved-At: Tue, 10 Mar 2026 14:12:35 +0100
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

From: Simona Toaca <simona.toaca@nxp.com>

This command exposes 3 methods:
- check -> checks if the data in volatile memory is valid
- save  -> saves the data to non-volatile memory and
	   erases the data in volatile memory
- erase	-> erases the data in non-volatile memory

cmd_qb can be used either directly in the U-Boot console
or in an uuu script to save the QB data during flashing.
It supports specifying a different boot medium than the
current boot device for saving the data.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Simona Toaca <simona.toaca@nxp.com>
---
 arch/arm/mach-imx/Kconfig       |   8 ++
 arch/arm/mach-imx/Makefile      |   1 +
 arch/arm/mach-imx/cmd_qb.c      | 132 ++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/imx9/Makefile |   4 +-
 4 files changed, 144 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-imx/cmd_qb.c

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index e4014226582..17aad696648 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -71,6 +71,14 @@ config CSF_SIZE
 	  Define the maximum size for Command Sequence File (CSF) binary
 	  this information is used to define the image boot data.
 
+config CMD_IMX_QB
+	bool "Support the 'qb' command"
+	default y
+	depends on IMX_SNPS_DDR_PHY_QB_GEN && (IMX95 || IMX94)
+	help
+	  Enable qb command to write DDR quick boot training data
+	  to boot device.
+
 config CMD_BMODE
 	bool "Support the 'bmode' command"
 	default y
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 0f6e737c0b9..dfa9eca43eb 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -82,6 +82,7 @@ obj-$(CONFIG_CMD_BMODE) += cmd_bmode.o
 obj-$(CONFIG_CMD_HDMIDETECT) += cmd_hdmidet.o
 obj-$(CONFIG_CMD_DEKBLOB) += cmd_dek.o
 obj-$(CONFIG_CMD_NANDBCB) += cmd_nandbcb.o
+obj-$(CONFIG_CMD_IMX_QB) += cmd_qb.o
 endif
 
 ifeq ($(CONFIG_XPL_BUILD),y)
diff --git a/arch/arm/mach-imx/cmd_qb.c b/arch/arm/mach-imx/cmd_qb.c
new file mode 100644
index 00000000000..9e4532bc84c
--- /dev/null
+++ b/arch/arm/mach-imx/cmd_qb.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0+
+/**
+ * Copyright 2024-2026 NXP
+ */
+#include <command.h>
+#include <spl.h>
+#include <stdlib.h>
+
+#include <asm/mach-imx/boot_mode.h>
+#include <asm/mach-imx/sys_proto.h>
+#include <asm/mach-imx/qb.h>
+
+static int get_board_boot_device(enum boot_device dev)
+{
+	switch (dev) {
+	case SD1_BOOT:
+	case MMC1_BOOT:
+		return BOOT_DEVICE_MMC1;
+	case SD2_BOOT:
+	case MMC2_BOOT:
+		return BOOT_DEVICE_MMC2;
+	case USB_BOOT:
+		return BOOT_DEVICE_BOARD;
+	case QSPI_BOOT:
+		return BOOT_DEVICE_SPI;
+	default:
+		return BOOT_DEVICE_NONE;
+	}
+}
+
+static void parse_qb_args(int argc, char * const argv[],
+			  int *qb_dev, int qb_bootdev)
+{
+	long dev = -1;
+	char *interface = "";
+
+	if (argc >= 2) {
+		interface = argv[1];
+	} else {
+		/** qb save -> use boot device */
+		*qb_dev = qb_bootdev;
+	}
+
+	if (argc == 3)
+		dev = simple_strtol(argv[2], NULL, 10);
+
+	if (!strcmp(interface, "mmc") && dev >= 0 &&
+	    dev <= (BOOT_DEVICE_MMC2_2 - BOOT_DEVICE_MMC1))
+		*qb_dev = BOOT_DEVICE_MMC1 + dev;
+
+	if (!strcmp(interface, "spi"))
+		*qb_dev = BOOT_DEVICE_SPI;
+}
+
+static int do_qb(struct cmd_tbl *cmdtp, int flag, int argc,
+		 char * const argv[], bool save)
+{
+	int ret = CMD_RET_FAILURE;
+	enum boot_device boot_dev = UNKNOWN_BOOT;
+	int qb_dev = BOOT_DEVICE_NONE, qb_bootdev;
+
+	boot_dev = get_boot_device();
+	qb_bootdev = get_board_boot_device(boot_dev);
+
+	parse_qb_args(argc, argv, &qb_dev, qb_bootdev);
+
+	ret = qb(qb_dev, qb_bootdev, save);
+
+	return ret ? CMD_RET_FAILURE : CMD_RET_SUCCESS;
+}
+
+static int do_qb_check(struct cmd_tbl *cmdtp, int flag,
+		       int argc, char * const argv[])
+{
+	return qb_check() ? CMD_RET_SUCCESS : CMD_RET_FAILURE;
+}
+
+static int do_qb_save(struct cmd_tbl *cmdtp, int flag,
+		      int argc, char * const argv[])
+{
+	return do_qb(cmdtp, flag, argc, argv, true);
+}
+
+static int do_qb_erase(struct cmd_tbl *cmdtp, int flag,
+		       int argc, char * const argv[])
+{
+	return do_qb(cmdtp, flag, argc, argv, false);
+}
+
+static struct cmd_tbl cmd_qb[] = {
+	U_BOOT_CMD_MKENT(check, 1, 1, do_qb_check, "", ""),
+	U_BOOT_CMD_MKENT(save,  3, 1, do_qb_save,  "", ""),
+	U_BOOT_CMD_MKENT(erase, 3, 1, do_qb_erase, "", ""),
+};
+
+static int do_qbops(struct cmd_tbl *cmdtp, int flag, int argc,
+		    char *const argv[])
+{
+	struct cmd_tbl *cp;
+
+	cp = find_cmd_tbl(argv[1], cmd_qb, ARRAY_SIZE(cmd_qb));
+
+	/* Drop the qb command */
+	argc--;
+	argv++;
+
+	if (!cp) {
+		printf("%s cp is null\n", __func__);
+		return CMD_RET_USAGE;
+	}
+
+	if (argc > cp->maxargs) {
+		printf("%s argc(%d) > cp->maxargs(%d)\n", __func__, argc, cp->maxargs);
+		return CMD_RET_USAGE;
+	}
+
+	if (flag == CMD_FLAG_REPEAT && !cmd_is_repeatable(cp)) {
+		printf("%s %s repeat flag set  but command is not repeatable\n",
+		       __func__, cp->name);
+		return CMD_RET_SUCCESS;
+	}
+
+	return cp->cmd(cmdtp, flag, argc, argv);
+}
+
+U_BOOT_CMD(
+	qb, 4, 1, do_qbops,
+	"DDR Quick Boot sub system",
+	"check - check if quick boot data is stored in mem by training flow\n"
+	"qb save [interface] [dev]  - save quick boot data in NVM location    => trigger quick boot flow\n"
+	"qb erase [interface] [dev] - erase quick boot data from NVM location => trigger training flow\n"
+);
diff --git a/arch/arm/mach-imx/imx9/Makefile b/arch/arm/mach-imx/imx9/Makefile
index 3018d128a36..7dee144e0f4 100644
--- a/arch/arm/mach-imx/imx9/Makefile
+++ b/arch/arm/mach-imx/imx9/Makefile
@@ -15,5 +15,7 @@ obj-y += imx_bootaux.o
 endif
 
 ifeq ($(CONFIG_IMX_SNPS_DDR_PHY_QB_GEN),y)
-obj-y += qb.o
+ifneq ($(CONFIG_XPL_BUILD),y)
+obj-$(CONFIG_CMD_IMX_QB) += qb.o
+endif
 endif
-- 
2.43.0

