Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BD8D39404
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 09:29:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73FF28414B;
	Thu,  2 Apr 2026 11:29:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EuIyl5Ml";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEB4484198; Thu,  2 Apr 2026 11:29:41 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D4AB84150
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 11:29:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AjJJI5M6CtXqGOO+9vZJTzB6Rq6rLrdssI/+ZR5QNQarrDDdLG9q5wA7ccnJVsrUDjpdvIQZaZ8A1SLhBYolMAVO4rWDGntE1+sV2pke1x3z+apuXuPQcFBfclq2ITArCviFIN+J35kb/QI7zFRcx5OUyuMFq+QSPqJkbhePPvyu50I9BCEIcAHlUavVlAmQgAffNRhXAmse4E4DFYCV/LKJIvZoOoHzW0EPz9R1BIaFUfCNfQMxcuGqOCxEOVzJNihymb608uxKyfkpBSTeVJ/h24Jpn4qjPP3bo7os03zjMYAD9DD6Bh5gMmahyDsn7qYSGsPR2bpyB8IsZ83/FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkExyOPCsQcfK1GFpAgs0n5uF/QaRcnHw7H7NZejhTQ=;
 b=BRal8ba3mIkbaQ1Pi3rR6kONeTdV2Znil5uyuJrinJZhHE3YhtI3z3Aufc358Y18UdURJ/5qAihTwmIS2KrsBCAOIKrhWNIv4rDJn6KMyrfL7i2Ne8FGHg3zmy8zmtucZ23427zNdY0J9/OqYkSOxMYv9IOxlIbFYml9qGdiGdxosxJqMihPjvxR1+S+BnBDNg2jiAWKVOylHRwRNLsqimpgP0F6twmajblMsSZ4ecX3BpiwPgL3FHUQkgLkgFHCppUjC/34squYE6KuY1B8wo93mVmZNDSonblGIw2imgOiKO+0yHM7feb5zw4BdopANcPWaWR1PzZW1HYQdgiD/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkExyOPCsQcfK1GFpAgs0n5uF/QaRcnHw7H7NZejhTQ=;
 b=EuIyl5MlkiN8wwhbQVLZSp7QRVJua062TxDeypj8t5b6HBqBnvXRXgqIITWhOtlUEec6On585KHe/R5pG3Q/1eh82M74U7xDM1cFOMAjAsvGkGdD6mzh6WPKWru67Qy1V5DzbfvQbSPejpYjTqP+DTztKo5+97RCMpKqwJYPFMM3vbx5wDtBoATqSLlpmCju+fIpLDrB5wnegE5Ks/ac9BDXys/302m1Glvb3jtOP3oOQ4mPOH0sqbVB8b5C/hrObSMLj3hbTnNlUdZbl14C+GJzI/UwZvzQWYlj8MQ0HUVwH9K2SmNGwiB4AlJEOw3FMlCJ3An1hHKtAARrdM1lZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com (2603:10a6:800:306::9)
 by AM7PR04MB7095.eurprd04.prod.outlook.com (2603:10a6:20b:11c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Thu, 2 Apr
 2026 09:29:31 +0000
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7]) by VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7%4]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 09:29:30 +0000
From: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>
To: uboot-imx@nxp.com,
	u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, viorel.suman@nxp.com, simona.toaca@nxp.com,
 ye.li@nxp.com, ping.bai@nxp.com, marex@nabladev.com,
 sebastien.szymanski@armadeus.com, ravi@prevas.dk,
 joao.goncalves@toradex.com, ji.luo@nxp.com, semen.protsenko@linaro.org,
 tharvey@gateworks.com, qijian.guo@nxp.com
Subject: [PATCH v3 2/6] arm: mach-imx: Add command to expose QB functionality
Date: Thu,  2 Apr 2026 12:40:44 +0300
Message-ID: <18e5f58dc65283a73c29c4b603a5b56f7c4d3e8a.1775121078.git.simona.toaca@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1775121078.git.simona.toaca@nxp.com>
References: <cover.1775121078.git.simona.toaca@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::6) To VI0PR04MB11917.eurprd04.prod.outlook.com
 (2603:10a6:800:306::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11917:EE_|AM7PR04MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: 60a8f2c0-0083-42d4-6140-08de909a57e1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: SwHgqJrvGsiiwW250QwCE04mi7Yx16qoRadI52LUHglOvi58Hx3vuDjoIaVHSRt4OkHee4akWeIS34iOyPF0K7PyUmkAoeG/HmRnk4LTGlCFy8v5o2QagWzZlAGJiQOzuYXy4L9+SY9huBs8iC85SgqvLoL1EIdduZtB6ZjxpviihK6DME4LYd+TE4eKrQRsfKQplbbLouAgRTJ8mewMBFLzpEQ/o3iyyvciYWMQsW/NOj3e/saSqR3H8RIVmsG2PqeRhDVcSf1K9aibGkEaeTnj0FyYiaKl449SMBipT+0CKOQlqWkJdONzJbUIOuhRr87hq6h9uGr5t+NeSTf9+CiNoZQGQek6KB3qt0GCqPoYDyl7AQ3PB2ewFd+r1bUTxJJC9e1jTQWe8yJ/1WyxVaka6bltuGUhivcbOvHuEYO6LmfOsO0vXEuMQgkeJr+i7mfPzulUGcuHP+bHDqwOZ1ZiWqEeZe2bv7Y48MdB0cAiq+rJyl85sZuojyCfQM9s8DKDDR9aFSWa0dT9QKxCqK+lgIwHtQvPK6wlZcwCMXGpMJs8OkgpaMF06QklvybG4/BYU8MfLRgvY+5QbOH/KNi6p7rLlObAT685TcDHaZPmJxLIhRa6IkZZ52ngK++rKW5qbEFLNxfq/dSI70huljKtTJOKTBo0VonPoiLszz790+pBboXbogqL0WHyZiZ6V1mAPB8IXeyxhp5lcu31eoqnka5HZ27ZbRAROGlvTZg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR04MB11917.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MLVgtgBVETcnWh7o6iHB9j29KHHuPdu7copWDSxpYQ91Mj/ocribV/f7/+wY?=
 =?us-ascii?Q?8BYIJzLcq4EYBzCVT2q48hob0Eza5UnDiExFFiU0xiOyEhqrt+XLl8svFuxQ?=
 =?us-ascii?Q?JHpM+qaU6IhBFEumedAkaRjHchfdCK2sJMl0Sf9Cg/eby46+FCSJ+Wf1BsY3?=
 =?us-ascii?Q?SmlGMhH2mC0KmPJs/uJIVhVpvMsNyFBnKbAW1swgmCDjGwVvTzJ5xBKz+fa0?=
 =?us-ascii?Q?41x0mV10N03AIkdNbWHVviLFyQT8+LwVeqDd9MfhBZ5PGeFLXnscnrVLc67z?=
 =?us-ascii?Q?g84PfLAm5F283Q9KOFj5HOE5oILSbQHsG2jXriYoz8HHzg106U+Z1LaJLHE8?=
 =?us-ascii?Q?kzJ8J3HvCJKr2T5Gy9PvPoJgal46Ezji15ZK/A33IYBRQP6HToqyRFRJrQby?=
 =?us-ascii?Q?tHIkScWxdpRs4EiH+jqq5n/ARWCah9NXSAlHVhSFBilO4cZfechVNd3bCkUH?=
 =?us-ascii?Q?F7RgOHA6XpZn0cjxhDCTx1t6tuzM4od0z/c9jJFKTdaoaCtrK6BWJonACUdI?=
 =?us-ascii?Q?ZZs6eUOCuufeUtHZWOLeZ/f/tIAEimiEtX2/4rkhUJ7pS8kxySg5uuF1iC3W?=
 =?us-ascii?Q?+Gr+FNd0JdcggNokBQJWePat811EecjkX2lv/9SBmmvgYLkfsUtwKSKf7IbY?=
 =?us-ascii?Q?L0wxFjFbQ3uXFnUloCO6BSYWWafU0MixMJlJAO2lDroKtNDrb9hlJm8VTCb0?=
 =?us-ascii?Q?udV8ONxj7V05CIGo9QLIRkhRI+fwOqnAM697YzItRDaJ/UEGSrwH2U7LgEyQ?=
 =?us-ascii?Q?MeBlOGfS9u89ApDrseXHfjBNbsG3l4ajCRq5J5LwETgb3oAdWab4/LBUHNV6?=
 =?us-ascii?Q?U0DtjUNT04nz09CBqZUlju6SndKbST2HE2jVpPiK8ZT09TaXhhiXtac2gszo?=
 =?us-ascii?Q?U8I6uuoO7r1XrTXVfV2kOF/D8LxMz39XLNZHVzxJSH1mrMsV/odg5NW5Ra4z?=
 =?us-ascii?Q?AOP5bd39489Hcy0N8ey5BXfzuMEI6Y/RJ6XU78OoNd2lGkCQPoLCDJBTMndL?=
 =?us-ascii?Q?Eui+/rfIiilEmTNmr7T1ZA2cFFGmC+WUufaH2whZPJYM4cW2BqtIWfZV1/OG?=
 =?us-ascii?Q?QheQ0Vl1L23YDAstUvJxWjsAYrDd0CP7Wyx3loAzuuLWS2+DOaNhoNIKh87z?=
 =?us-ascii?Q?EU/GULpwzXOqvNgabSKoN01Ied4Zivzmt66psa6k0mRT3vbUDd+aq1TBm5uu?=
 =?us-ascii?Q?scgMe1VGvYzJJriiZMPF64lgOK9NtEuVTzMDyt47pj3I7bC9yCpxpR0VRJNX?=
 =?us-ascii?Q?9aOPZ0XYdQfa+pixaplaKopGs+DyiepA64VBWVkc/2h2oWzUf/i0eAq0VfdR?=
 =?us-ascii?Q?SXekbmJuxGOjJNSMUMymL9pEaaJcRAgbffxomUUvC6NXzKC7vJuYVHiSitHe?=
 =?us-ascii?Q?G/Z/+Fwfj+CJA8tjHp3X25ZYCQCdiN/yJ6zAhQnEMByOeBmAk31DwFobWlTl?=
 =?us-ascii?Q?aem8btyR1no7tbEQGkSB62Wx5JjpeXrqNr+lxGvyyU9QBDGJBlyXf4qiTxw/?=
 =?us-ascii?Q?U06Ii13lnvc4D4ncb1GNFTooe9fsO2SIgQfwvVLmkkb6XrhCGmCcUhC5tseH?=
 =?us-ascii?Q?xhEtPhSBm3F0U0icjlMrOboqzGGgNNOa0tdw3WibnfKGHBLY6xAtIjztIrWv?=
 =?us-ascii?Q?czqahyFdWhipUEtADrt7K3QPrEmMcu+PSTSes5zYGVNWlTYOsGe22zYKWgWb?=
 =?us-ascii?Q?Wln/Z+l/Sq3KCSiDZkvJ6AHV7bUI5GTZbHQesue3PazURPBtRXyJqRxUTTGg?=
 =?us-ascii?Q?CnxVPc5Zlg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a8f2c0-0083-42d4-6140-08de909a57e1
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11917.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 09:29:30.8505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X4dQzCXrr3uBzmGODNlBpeRFQquhVQZzj//kbTLT4GNm8hpWt/+SOZ3NoSypeQTXbEeAK/RcknaiKzKghTne/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7095
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
index e4014226582..48266cfd6e2 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -71,6 +71,17 @@ config CSF_SIZE
 	  Define the maximum size for Command Sequence File (CSF) binary
 	  this information is used to define the image boot data.
 
+config CMD_IMX_QB
+	bool "Support the 'qb' command"
+	default y
+	depends on IMX94 || IMX95 || IMX952
+	help
+	  Enable qb command to write/erase DDR quick boot training
+	  data to/from a chosen boot device. Using 'qb save/erase'
+	  without arguments implies using the current boot device.
+	  For use in uuu scripts, the boot device must be specified
+	  explicitly.
+
 config CMD_BMODE
 	bool "Support the 'bmode' command"
 	default y
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index bf6820de655..43febc10460 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -80,6 +80,7 @@ endif
 ifneq ($(CONFIG_XPL_BUILD),y)
 obj-$(CONFIG_CMD_BMODE) += cmd_bmode.o
 obj-$(CONFIG_CMD_HDMIDETECT) += cmd_hdmidet.o
+obj-$(CONFIG_CMD_IMX_QB) += cmd_qb.o
 obj-$(CONFIG_CMD_DEKBLOB) += cmd_dek.o
 obj-$(CONFIG_CMD_NANDBCB) += cmd_nandbcb.o
 endif
diff --git a/arch/arm/mach-imx/cmd_qb.c b/arch/arm/mach-imx/cmd_qb.c
new file mode 100644
index 00000000000..33e987f18e0
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
+	if (argc < 2) {
+		/* qb save -> use boot device */
+		*qb_dev = qb_bootdev;
+	} else {
+		interface = argv[1];
+	}
+
+	if (argc == 3)
+		dev = simple_strtol(argv[2], NULL, 10);
+
+	if (!strcmp(interface, "mmc") && dev >= 0 &&
+	    dev <= (BOOT_DEVICE_MMC2_2 - BOOT_DEVICE_MMC1))
+		*qb_dev = BOOT_DEVICE_MMC1 + dev;
+	else if (!strcmp(interface, "spi"))
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
+	ret = qb(qb_dev, save);
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
+		printf("qb: %s: command not found\n", argv[0] ? argv[0] : " ");
+		return CMD_RET_USAGE;
+	}
+
+	if (argc > cp->maxargs) {
+		printf("qb %s: too many arguments: %d > %d\n", cp->name,
+		       argc - 1, cp->maxargs - 1);
+		return CMD_RET_USAGE;
+	}
+
+	if (flag == CMD_FLAG_REPEAT && !cmd_is_repeatable(cp)) {
+		printf("qb %s: repeat flag set but command is not repeatable\n",
+		       cp->name);
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
+	"qb save [interface] [dev]  - save quick boot data in NVM => trigger quick boot flow\n"
+	"qb erase [interface] [dev] - erase quick boot data from NVM => trigger training flow\n"
+);
diff --git a/arch/arm/mach-imx/imx9/Makefile b/arch/arm/mach-imx/imx9/Makefile
index d2e44f0d5f9..3e323a714c1 100644
--- a/arch/arm/mach-imx/imx9/Makefile
+++ b/arch/arm/mach-imx/imx9/Makefile
@@ -14,4 +14,6 @@ ifneq ($(CONFIG_SPL_BUILD),y)
 obj-y += imx_bootaux.o
 endif
 
-obj-y += qb.o
+ifneq ($(CONFIG_XPL_BUILD),y)
+obj-$(CONFIG_CMD_IMX_QB) += qb.o
+endif
-- 
2.43.0

