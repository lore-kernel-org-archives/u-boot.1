Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107A1F013C5
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 08:05:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A87483B03;
	Mon, 16 Mar 2026 09:05:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="v4E0XIo+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B68B83BC8; Mon, 16 Mar 2026 09:05:00 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CE7A836D3
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 09:04:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWLrzJQOOHh1hpaa0PgDitSBlHhkL+2VVTdOj3TE1H6IOGvRQAZWhU7eO5l5fg9ufQxWb64qR+U/mPqBvdwYW9CeaxaHgKRWoasIAL8FJDb/FqQTguCLsuN+XdC/Ex06ekVIb2fOH/4OPxn0cx75Ijhx7QtZKUAcqs0+RBGQjzD6CbG7f0Cpa8S246wP1r4WyxJOVcgNm20kBnTApBbravGuPyCfFTZkz0lXIbCUx82FOKMdXWtNk0ZyhBkRjqKX3wHrxKrTwhRT1B5OuRfbaEtbUQmzJkLX3IiFR2Qkfl/IAQWyg0X9Nq8lpX6HUxqRCHb3lCJ2X03voDhNxQsb6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z60XkWKzyQjVgtDZ405FH3RCPRQ6hYFtpDXX9nlqeD4=;
 b=MMA70BmgX+scU6Om1He+NcfCvWRtnqI0JTQBRKZO+cFLlBUkD9Xgiy8FEmYKmmy40Dbpn50Cr5t+LDvOYJ7PDa87B1kKossLBDLSZBqw8G5OQeCaK5oxrAJl8iQqny2dZTqxU2NhgSnIP5RSJYEpIRPm2DEv0C8JRa5A4w3+Tj5tZi8WQ3MBpPOCDU8wCMlxg1iAqbAQRpq39X5CQo1oegDNoJHl/T+9p/CPIXugZH1Pd6uVfps1a9phYBOHeZRAv7n6AbswnT/bxIsNooJfvZzxIUnyg2XMSKrGkbmw+3tY2UYM7CFQJEC4t7byxEHZT93LxIQ+L1335a8DTxqYIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z60XkWKzyQjVgtDZ405FH3RCPRQ6hYFtpDXX9nlqeD4=;
 b=v4E0XIo+QnW1hhk2/ctuFrTxJw7rWls2uvbS3515WONl2SFyaRBXsCz42wEE6kSXcYz6Yf6KnZvnM3r8OU7AMToC2B2e6Lj+93WMbKlhh98+0aoN730+LeF1LVLDhFZOWmbjFhYdpHgjZg/OSBVrXr20CzbB66jBRJalXiIjo8jwhPlckK7/zn09LeZe0ijl7A6+p3WIsnBPkhQEPBCQJcck0JBXOSYiILxhgLnoGC/YTHV6hVO+mxeDf3UekXHS8r6ZAko7ik/xGXNatUHa0zIlSfbeq8UvYzFmHU9q7BaAVMDBA3W5+9o5r3euUEn9PRFWLaHHRL1zmwCpmWXyzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV4PR04MB11901.eurprd04.prod.outlook.com
 (2603:10a6:150:2eb::21) by GV1PR04MB10128.eurprd04.prod.outlook.com
 (2603:10a6:150:1af::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Mon, 16 Mar
 2026 08:04:25 +0000
Received: from GV4PR04MB11901.eurprd04.prod.outlook.com
 ([fe80::601d:ca21:9592:9a12]) by GV4PR04MB11901.eurprd04.prod.outlook.com
 ([fe80::601d:ca21:9592:9a12%4]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 08:04:54 +0000
From: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>
To: uboot-imx@nxp.com,
	u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, simona.toaca@nxp.com, ye.li@nxp.com,
 viorel.suman@nxp.com, ping.bai@nxp.com, marex@nabladev.com,
 sebastien.szymanski@armadeus.com, ravi@prevas.dk,
 joao.goncalves@toradex.com, ji.luo@nxp.com, tharvey@gateworks.com,
 qijian.guo@nxp.com
Subject: [PATCH v2 2/5] arm: mach-imx: Add command to expose QB functionality
Date: Mon, 16 Mar 2026 10:15:53 +0200
Message-ID: <2c33ee004dd272b8427b3d1962ade06cbb220149.1773648510.git.simona.toaca@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773648510.git.simona.toaca@nxp.com>
References: <cover.1773648510.git.simona.toaca@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0193.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::17) To GV4PR04MB11901.eurprd04.prod.outlook.com
 (2603:10a6:150:2eb::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV4PR04MB11901:EE_|GV1PR04MB10128:EE_
X-MS-Office365-Filtering-Correlation-Id: f70e4933-65b3-49a3-920b-08de8332b501
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: qtqml9+Tor9EL7YEJEEPqOv7ka1H9pXPvPy/7UU2kludnbkcrWiFTFbzpQzB4PQY73cjQzBcGTtUkk8PjhbG7oqur6Gq3pdcKhO4ZMkBuleuCWjZb0HlcTt5ESGoeWIgi7ems7bHGBvthKwFZKw7tQamAdWFuqZ59OmU2vJf4u/3NBgLHiH98EQyUcBoEgkFEsIqhaZgj2U99FsY/8+ioPyvYt3lD82NbVTPatM1b5YpQbOx0VQEnRCk/ZZMgxN/1WIhLd+6KhvuRSqhzNOd8lEqaQKe0WmdL1322kcsWylVN8LXwySEj4mieI0bm5RjamA0u1BT3z5sPUM1oW+cgUH2jMogzH8YcwYuQ/qHyJgmDaSOu3UocC/WJf5IlRzo3+GjyUjjZZwyRoveVX+9u3VpP9ywM2l7LOlsPFe6jXdsXaW7BUNKinmMMG1h+Y3vjOHCB4x13T27S/tCltQCUxVHHNYJ5hmsjaZsiWrmpphb993knw73pFkzAugdX/orFTdXF8LJ1Vp2EPecYGEzHJJT5I66cysyZjxdZySs8Zld+gxiZIimNn7uBoyR6zz9iRKGPOgTfm9Ykexh66np3yfU1eBXA5oXfjHjqYg06crktK3pbX61DGC5XSLz5qGwE8dylExY/p84dd0jKJBfKTVpBh4dGHcvC+8x9kBB48BrtKwshUf6IRToE9BlDGQAwybR8liyYC6/ZAVYimJBFgZh50/GosYUI4n/yE6/VUo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV4PR04MB11901.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?prWFFDuLU5kUvn8OwgJmEURNpGtfz+mK14O9ClazgHQ2onadJA9mQje06nih?=
 =?us-ascii?Q?YqACVsSTFRNVsG2/HIXusFOrou7imJC/oDOz3ky7mPLNMdKCS4GgW/qQ2CMG?=
 =?us-ascii?Q?zo2KZGTBaQTCfIg6ADYc0Awtelsc/1SalpcETkvnYRb0scUT7aPoR1u9Rct7?=
 =?us-ascii?Q?aGs2ne7jFFb4ko6Gdks+VLpe9GhnNBZRKkdKsON5Rfxv6WXQBAbFg16Oxjq0?=
 =?us-ascii?Q?wPjFcG3F9JKiLQoS8GhWnDTz+QVotvNTYeomSpwXqzadfFtshuCNjRYD1Xv+?=
 =?us-ascii?Q?5gEu3nRaIA2Ka+zkB0v1oeCU8bZh6mKGA9JYKmDB48fR7hFVQM3nY07nxqeD?=
 =?us-ascii?Q?YBTSjSabspwTXGoropwjuha6VdcYtsaM5zno7j2ieKh/SmViBJN+QXCZGpdO?=
 =?us-ascii?Q?8AjprRF2wBFuR/+jaSXjmpQSMVwmVJzgmIO3xKajl2fOlXWQWNz98HvWuHl2?=
 =?us-ascii?Q?Hek2I0xoXizPTBgSD0RPlL84rM+SsB/25TUHR2gGZ6LzsuEMwvmjHCN106P/?=
 =?us-ascii?Q?o6hzS7jku3UpiDTWkrTKRuknWMNckl/ehX39QCyboFoq9pnraKbpikEhFkUi?=
 =?us-ascii?Q?8760bYxRfeJFCOxQaMCI3X1PKiGcZ/5oZcSIyCOua0KUrTxJfhyLKv6k4Ovm?=
 =?us-ascii?Q?sdkRDnlfRFKEsFdoMxnmaLf931wuxWL6CEbjoQ9h5UUCJSvXq/ihm3lzuO7F?=
 =?us-ascii?Q?iX0ADBZ1Xl4qAtglJRk46A3IBACzPz8F9C4WDrB3dhlGwKw4fyvpL3GZP3Qi?=
 =?us-ascii?Q?j+hW5EcKu973kIAu+fChyoy13UE6rXLnSvnNWCmvgVt58LpzJccQf+pagnjD?=
 =?us-ascii?Q?MPG3ux0PT76EbKreQwwBK8WpMChLnfi0TsGhjaeBQhQScMJ4VEKexPhfl0af?=
 =?us-ascii?Q?KR21mlZk7ZduETj03pxCoBY30vs9JHvqFV1UZOmsRGk7c9ot5+DG16I4JYgA?=
 =?us-ascii?Q?Kpv9dt5j5C3pbEykdim0+Xj9JT9brIuALARrqWCvA7J2E9c/REiysqCH6pDh?=
 =?us-ascii?Q?tu2jLwWRlhKGqhkjzep5xNik1/G4eRNz1+ZMWKmMRhdGDa0IfIta/f6Fv9TD?=
 =?us-ascii?Q?9eAcsQADvyEh9KLAdI516ccZWCCvusStNUp60TxjVKnO48CwXAvEOA8FpI6U?=
 =?us-ascii?Q?fwQuOcsNvmZtZ3O00ATiKvTPR3zRi+ekrb76bcJTrh+c4ZfPPAmZRERRvZ6O?=
 =?us-ascii?Q?irY/RFg9hl+5cBIbVYDqnH3hePJzhehEgFjmZ0sm/OBjP8oNI30ADIjaoFrf?=
 =?us-ascii?Q?6JZ3oNSPShO9gwk8Q9QECmJkwcGAFSdkq86LFwghNHaoxa842uYrazrrsmhN?=
 =?us-ascii?Q?m00NUhbU1zoGdp48r+2RmIm3r1caoOuxC+LZC1Eb1H3o5JEWorMID5wpL7tq?=
 =?us-ascii?Q?tY+kiGzHdPibVDjawVzdYGTDNJqT8HXjVYOWTr6Stq7UcaivVn8z6EsGlqBm?=
 =?us-ascii?Q?ozbz5HdDzVhKjQduYtN+Z0FuyPjimJ86qyVFm8RN3TkE8gI/LwD8Emp7bAos?=
 =?us-ascii?Q?ijUConqrH8nsHKTPoObYkcCqUdEgYfQmZTVugSXLtRRpFwZ44XXWuJyMB0RJ?=
 =?us-ascii?Q?5wDoKOXf+2a+XaOVrzk1+Q+h3yMyR6CsEQ5DBM8ssGKLk4AfiJnFmTPto+cx?=
 =?us-ascii?Q?5x5z+t5F+d8MyV44K2c7PyRBwhg/PgeRJnuA4TnhvabtcMBfAgXqfjQ0GQay?=
 =?us-ascii?Q?M3j4dB35RrxmLolnMR3J4b0ZWdwcQ1G9+X1qTuqXUdyE2VSnG3kl+87QDCu7?=
 =?us-ascii?Q?upFAn2ZbLQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f70e4933-65b3-49a3-920b-08de8332b501
X-MS-Exchange-CrossTenant-AuthSource: GV4PR04MB11901.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 08:04:54.3851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fnSuPV6ogxfnhRoT0RfDYmgsxzDayBOR3Wz9Aho7i5yp9Y5lvhQK0RszZMz2fU2jOT8sXbOc6GvVHYAh5GzjLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10128
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
	   (integrity check)
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
 arch/arm/mach-imx/Kconfig       |  11 +++
 arch/arm/mach-imx/Makefile      |   1 +
 arch/arm/mach-imx/cmd_qb.c      | 132 ++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/imx9/Makefile |   4 +-
 4 files changed, 147 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-imx/cmd_qb.c

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index e4014226582..b199a0419fe 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -71,6 +71,17 @@ config CSF_SIZE
 	  Define the maximum size for Command Sequence File (CSF) binary
 	  this information is used to define the image boot data.
 
+config CMD_IMX_QB
+	bool "Support the 'qb' command"
+	default y
+	depends on IMX_SNPS_DDR_PHY_QB_GEN && (IMX95 || IMX94)
+	help
+	  Enable qb command to write/erase DDR quick boot training
+	  data to/from a chosen boot device. Using 'qb save/erase'
+	  without args implies using the current boot device. For
+	  use in uuu scripts, the boot device must be specified
+	  explicitly.
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
index 00000000000..54733c1ad88
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
+		/* qb save -> use boot device */
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

