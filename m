Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E81CEE49A0
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 13:26:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E89F86366;
	Wed, 23 Aug 2023 15:26:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="VAQc/P/7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FBBB864AA; Wed, 23 Aug 2023 15:26:02 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::627])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E3DD8634D
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 15:26:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=laurentiu.tudor@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iV0cUFnYHguEbJ0vNCJfYgOkcY9Upt9Yuijr/sMcxemJNHqUiI2esShhcUiKk8jSwFdU0Crjwwu15wexC/o8GDG1EQ+TzDB/wAl7sQcriyGxxNtQdy0WS6cl2REKe8xIx2NENYO6oFH2xMJc2shbqtPHj4gcpzj8JWHx7Gak0adOt/5Vv0/qabwU5MBloNp86b8jHhmJoJwYuNUc9u1FFo1HeoQD3sQLwh6QeWjYWOVpFkxHQUwGklLcTtq+FklCmdDXYtz120ycJ+hBgJc2Nc3y/WigDTS7U+M+WSwBOIDXYpA0URPOnEltGq9G+WVyRkTYYT8gcGk+xpv5aqrwew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGaMMIdWi1l09APkYIBNYgt2G9lIcwdn20rErZt9a4I=;
 b=KQKEQ5NBuj/xxKpHRFtL/qFuVM2Jp7GJ7G/DOi1VN2KdPbKrTEL2qDVdrK66rETp4C+yqCItJozXiegCbGtJ4A9YUN8Az+5onRvbRb/KkD0zLGuyigSz/EH5EM26SP+3OOucyIW8cMB2FIM7uzvfKj2QrS+l9uk9McTxJdT499RM3Ql4SlU0sy/I2jGcjjh6QUluyteXfcL+MP2CpVAiWapBclIKCUEYcnEhP1ihXEhl3evaHCgSlTMyXFM6F/79JEz1/CoSSP7LFjkPSzMMHDu7jx+aRVnCDQThhB9z5SyfMo1ecClOURJ9QBbEKCyUdHIFJU83AZbPyWCw3BSyRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGaMMIdWi1l09APkYIBNYgt2G9lIcwdn20rErZt9a4I=;
 b=VAQc/P/7oKWKy635NATaH2u52HSJKqgObgUQrYHr0N2kGeAEubyWUemLcG89cSZd5SLvbjXD4dqr//enCgSFgNP9KCDC8RMwTbU65vt48oN8l0KGwkXWp8ku0WQRwNS+AWKulJhRwtKmDRP0Cv4KzXNxghHBlq5hMeQfGFbG3oE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9382.eurprd04.prod.outlook.com (2603:10a6:20b:4da::15)
 by DB9PR04MB8252.eurprd04.prod.outlook.com (2603:10a6:10:24d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 13:25:57 +0000
Received: from AS1PR04MB9382.eurprd04.prod.outlook.com
 ([fe80::efa8:cb35:bebd:3d10]) by AS1PR04MB9382.eurprd04.prod.outlook.com
 ([fe80::efa8:cb35:bebd:3d10%7]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 13:25:57 +0000
From: laurentiu.tudor@nxp.com
To: rajesh.bhagat@nxp.com, pramod.kumar_1@nxp.com, andy.tang@nxp.com,
 mingkai.hu@nxp.com, Ashish.Kumar@nxp.com, priyanka.jain@nxp.com,
 wasim.khan@nxp.com, matt@traverse.com.au, udit.agarwal@nxp.com,
 joe.hershberger@ni.com, peng.fan@nxp.com, sjg@chromium.org,
 u-boot@lists.denx.de
Cc: michael@walle.cc, camelia.groza@nxp.com, ioana.ciornei@nxp.com,
 vladimir.oltean@nxp.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v3 0/3] fsl-layerscape: drop support for obsolete PPA secure
 firmware
Date: Wed, 23 Aug 2023 16:25:43 +0300
Message-Id: <20230823132546.6048-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0009.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::20) To AS1PR04MB9382.eurprd04.prod.outlook.com
 (2603:10a6:20b:4da::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9382:EE_|DB9PR04MB8252:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f19ec34-b934-4845-829f-08dba3dc7c30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YeqTzvTgrHfMOrYsbfB/5VcaFJvKpXa0ianRXZu7tc+BVAwCnYSzSaDFGeMLetLfBHqnucHN51GGztRitEoQsutdcLaTQW99zIiXzbMA/zYy2YrqeYZV0MKLZNRdYdfCGKjeLToM8HnAD8IPfLtmZ9ARjmBS1BpZ81H4z0oQWVHiD5v+gMkkUtfGYF9IZuKkphO/H0p/KmrXlsN4RiEvWcpGEBQ5u/j8bltqOuTL5RiWg4jmZQhO0TKwxEBuN2Kd1w5aTvysVOF/bwrAS3axSgRtNwi12dtozB6N2kG0C4xPhESIdsfCZ2Q/kPU+GVNCCQKwXQNPnZ18Hd+01IrKOSuDms8UkPbwh4KTK4IQTv9D5chx2g6fgDfLfy+e9NzNiPJl5gX9t46kAaM9/G6Kayk3v8pwm83PYMgZCN+Bdtj9djF6tNolztsB6F2dbcXcbk3BmWQamQ+0lt9nxRtfLdElxmoRDV2s6XYsziXpCdXB3Sy7EOHyHG2waukMH2JBkaHzS2zeJqcjsz/UOQKXfHd+SCGQD4clc3MlpaV1t4miZTqIQphRaGIVWPZ2gdRAqVsiZX0TC4RxbHf6D4u9pCydcfsPaE5EEkr8nwjuKUPqfFhNIyXOpLr4YijulG3mSIFNcovAUH9zNuR383v2wA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9382.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(136003)(366004)(346002)(39860400002)(1800799009)(186009)(451199024)(83380400001)(2906002)(921005)(38100700002)(38350700002)(86362001)(36756003)(6512007)(9686003)(41300700001)(66556008)(66476007)(66946007)(6506007)(6486002)(316002)(52116002)(2616005)(4326008)(8936002)(8676002)(478600001)(6666004)(26005)(1076003)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?di/8dkXrqdxAx9+lVUAsbGaG/BC7nHMqhHYqnWdGUCMxqjjN1uT10r2JsUE9?=
 =?us-ascii?Q?jNeEcPldsO6mH8Fhz3qlZjLL/kfiReETSLtlNFKd20am90OlOQF/1TykShko?=
 =?us-ascii?Q?jsr7oXDXIvnz2SovJthLComV3+JhP2w+oKHe4vmBs4IgAATBGrImGuIzXt0y?=
 =?us-ascii?Q?gJPHocDapypAZr04n6dpDLncPDupuNpyvwFaORVVIctRtW39x+8UdIB/Af3+?=
 =?us-ascii?Q?lLu9EDI9u66DvQPwhA174e6gdkDAtGuTCz/il9u1AS3rPIogZh+gQ1E/h8yL?=
 =?us-ascii?Q?ah7q6o9Xg0tAlmZmUe823can0btoas2UyoJOraH+an7OZTFguvLLV+mr67E9?=
 =?us-ascii?Q?lgIPEvEw5bm1zDaMDVQ6AnfeKOXJsv9XPKh5oFsHQ15eWpAN++grM0cl+USf?=
 =?us-ascii?Q?37eIxATI1hEjhvfTLKvjMK9JcQc1jFVk5PS9sph1OJIWdorWIPx0fTdKRM42?=
 =?us-ascii?Q?PI49cGHzGVMc49/UgQ0gGLSbQi7XevNo4zA23dMuEVLxWhQfhkxjopz5N1aN?=
 =?us-ascii?Q?gsiTPXrT/NTIAkoOryIWOVn7MGCS4uXcMIIVAEtdn4UeHknsbL9DYoi+9TdG?=
 =?us-ascii?Q?VtCu/UH/yYQLlyPm5EHQC/vS+Zi3YN2jpm/fXdax/ArV5nAR+Wqvcp2edAp9?=
 =?us-ascii?Q?nmVnteYA9laHgNyvk5WuR7/jpT1gUziGmM8MPWUeRoB9EdPnBqeeoTLMJ2x2?=
 =?us-ascii?Q?roC+LFno0O/Q544AsbaSW/M5M/qayh9IrCsr1DuZamhvEXpu4YOjeMtkGBtk?=
 =?us-ascii?Q?0XMBz8p1708q4OrbjPL6LE4zzOFm/GVvvYIgi0DmYdWzsQ8gtWL4drlUSiqE?=
 =?us-ascii?Q?HdGUbVXQJrPY3Tlv7W/Z6HYjY3n2gWF1gpqSefm7HiqnToPhpw/9tiQZVH6o?=
 =?us-ascii?Q?bbpjJtnym+qQDqaDpAL5cE2aJFjf1nI/oF6jWYyRl+zKQ/Apphn0Thv0vp4y?=
 =?us-ascii?Q?Q0vmS9yaBDB8dAZR5CVswqKzO/G3LjpYDhDPlAh1CqFqsTmMo8HxYDymjJAy?=
 =?us-ascii?Q?DZ45lhfbQwELEJyffP8Iqb7dBmgKwHqRiqYrnugUrjWvov/OTxSlNz43+DJj?=
 =?us-ascii?Q?zKoynOEJ5jL81XGsf7pOJnnouyD1ncuCOYiz5WAVIOnIFuBErdJ6jZbhOD0c?=
 =?us-ascii?Q?l6daB6tBNnOmuo6Z7jL334EvMEzrnDOqi0A2KmgAmmP7+hrQeyRQPAOmUE/T?=
 =?us-ascii?Q?7cXwfMqKaEzUMv50iHyg8aeaA5qPsd5KM6pwC1ksL+Jfs8B1ygEA6vSvDymR?=
 =?us-ascii?Q?ElNBHUGpYvi85m8mF12C8kF6HEXF/hx4bNBMBy5jqTPxl/lrpC7PAGHEeKay?=
 =?us-ascii?Q?QK97WfHRSunK5nf/N77Q8U75G48LOxW7gl+G60Eo96cQWcneLYAGu1a8vXuf?=
 =?us-ascii?Q?g2nJlfh0MOp+RYd9FtMEhY688nNWZtF8D1Xb1jro7z0EPDLndXPajJKTiHDx?=
 =?us-ascii?Q?84Ro2EPSQrY5VzpAZPpPGCNnfPodJUOrDH3GoWyT1lFLahavvxGTIiDQS1s/?=
 =?us-ascii?Q?9JASnW72EAs0j5HMUcbxlutiKbIY41uJ6jK1aqHT4m+9sagpHXtMMFI9Oh5e?=
 =?us-ascii?Q?jLBi6O482q0PjIkhq3zzirWMOiEq9i17gU4R4Arw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f19ec34-b934-4845-829f-08dba3dc7c30
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9382.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 13:25:57.6348 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LG2K2/XAs0fnCdpAoSO0PBKcMJOTdHAx3XiH2oWCxJOvNrJNwzb2tNBeIN35OIF7VlJxi+8Itffz8xF6IPR/lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8252
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

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Support for this in-house secure firmware was discontinued long time
ago so remove it. First couple of patches delete the defconfigs that
use it (split in two to be <100KB) and the third one removes the
actual PPA support.

Changes in v3:
 - fixed some merge conflicts

Changes in v2:
 - split the defconfig removal patch in two because it was too big and
   was filtered out by the ML

Laurentiu Tudor (3):
  configs: layerscape: delete defconfigs using legacy PPA secure FW (part1)
  configs: layerscape: delete defconfigs using legacy PPA secure FW (part2)
  fsl-layerscape: drop obsolete PPA secure firmware support

 arch/arm/cpu/armv8/fsl-layerscape/Kconfig     |  60 ----
 arch/arm/cpu/armv8/fsl-layerscape/Makefile    |   1 -
 arch/arm/cpu/armv8/fsl-layerscape/ppa.c       | 284 ------------------
 arch/arm/cpu/armv8/fsl-layerscape/spl.c       |  34 ---
 .../arm/include/asm/arch-fsl-layerscape/ppa.h |  12 -
 arch/arm/include/asm/fsl_secure_boot.h        |   9 -
 board/freescale/ls1012afrdm/Kconfig           |  11 -
 board/freescale/ls1012afrdm/ls1012afrdm.c     |   6 -
 board/freescale/ls1012aqds/Kconfig            |   8 -
 board/freescale/ls1012aqds/ls1012aqds.c       |   6 -
 board/freescale/ls1012ardb/Kconfig            |  12 -
 board/freescale/ls1012ardb/ls1012ardb.c       |   6 -
 board/freescale/ls1028a/Kconfig               |  12 -
 board/freescale/ls1028a/ls1028a.c             |   7 -
 board/freescale/ls1043aqds/Kconfig            |  16 -
 board/freescale/ls1043aqds/ls1043aqds.c       |   5 -
 board/freescale/ls1043ardb/Kconfig            |  14 -
 board/freescale/ls1043ardb/ls1043ardb.c       |   5 -
 board/freescale/ls1046aqds/Kconfig            |  16 -
 board/freescale/ls1046aqds/ls1046aqds.c       |   5 -
 board/freescale/ls1046ardb/Kconfig            |  14 -
 board/freescale/ls1046ardb/ls1046ardb.c       |   5 -
 board/freescale/ls1088a/Kconfig               |  28 --
 board/freescale/ls1088a/ls1088a.c             |   5 -
 board/freescale/ls2080aqds/Kconfig            |  16 -
 board/freescale/ls2080aqds/ls2080aqds.c       |   5 -
 board/freescale/ls2080ardb/Kconfig            |  16 -
 board/freescale/ls2080ardb/ls2080ardb.c       |   5 -
 board/traverse/ten64/ten64.c                  |   1 -
 configs/ls1012a2g5rdb_qspi_defconfig          |  69 -----
 configs/ls1012afrdm_qspi_defconfig            |  67 -----
 .../ls1012afrwy_qspi_SECURE_BOOT_defconfig    |  72 -----
 configs/ls1012afrwy_qspi_defconfig            |  72 -----
 configs/ls1012aqds_qspi_defconfig             |  95 ------
 configs/ls1012ardb_qspi_SECURE_BOOT_defconfig |  77 -----
 configs/ls1012ardb_qspi_defconfig             |  77 -----
 configs/ls1043aqds_defconfig                  | 107 -------
 configs/ls1043aqds_lpuart_defconfig           | 109 -------
 configs/ls1043aqds_nand_defconfig             | 138 ---------
 configs/ls1043aqds_nor_ddr3_defconfig         | 108 -------
 configs/ls1043aqds_qspi_defconfig             |  98 ------
 configs/ls1043aqds_sdcard_ifc_defconfig       | 135 ---------
 configs/ls1043aqds_sdcard_qspi_defconfig      | 124 --------
 configs/ls1043ardb_SECURE_BOOT_defconfig      |  99 ------
 configs/ls1043ardb_defconfig                  | 100 ------
 configs/ls1043ardb_nand_SECURE_BOOT_defconfig | 124 --------
 configs/ls1043ardb_nand_defconfig             | 128 --------
 .../ls1043ardb_sdcard_SECURE_BOOT_defconfig   | 124 --------
 configs/ls1043ardb_sdcard_defconfig           | 126 --------
 configs/ls1046aqds_SECURE_BOOT_defconfig      | 108 -------
 configs/ls1046aqds_defconfig                  | 110 -------
 configs/ls1046aqds_lpuart_defconfig           | 112 -------
 configs/ls1046aqds_nand_defconfig             | 139 ---------
 configs/ls1046aqds_qspi_defconfig             | 101 -------
 configs/ls1046aqds_sdcard_ifc_defconfig       | 139 ---------
 configs/ls1046aqds_sdcard_qspi_defconfig      | 128 --------
 configs/ls1046ardb_emmc_defconfig             | 122 --------
 configs/ls1046ardb_qspi_SECURE_BOOT_defconfig |  99 ------
 configs/ls1046ardb_qspi_defconfig             | 102 -------
 configs/ls1046ardb_qspi_spl_defconfig         | 130 --------
 .../ls1046ardb_sdcard_SECURE_BOOT_defconfig   | 123 --------
 configs/ls1046ardb_sdcard_defconfig           | 122 --------
 configs/ls1088aqds_defconfig                  | 112 -------
 configs/ls1088aqds_qspi_SECURE_BOOT_defconfig | 107 -------
 configs/ls1088aqds_qspi_defconfig             | 108 -------
 configs/ls1088aqds_sdcard_ifc_defconfig       | 130 --------
 configs/ls1088aqds_sdcard_qspi_defconfig      | 128 --------
 configs/ls1088ardb_qspi_SECURE_BOOT_defconfig | 104 -------
 configs/ls1088ardb_qspi_defconfig             | 105 -------
 ...1088ardb_sdcard_qspi_SECURE_BOOT_defconfig | 124 --------
 configs/ls1088ardb_sdcard_qspi_defconfig      | 124 --------
 configs/ls2080aqds_SECURE_BOOT_defconfig      | 108 -------
 configs/ls2080aqds_defconfig                  | 109 -------
 configs/ls2080aqds_sdcard_defconfig           | 116 -------
 configs/ls2080ardb_SECURE_BOOT_defconfig      | 106 -------
 configs/ls2080ardb_defconfig                  | 107 -------
 configs/ls2081ardb_defconfig                  |  96 ------
 configs/ls2088ardb_qspi_SECURE_BOOT_defconfig |  96 ------
 configs/ls2088ardb_qspi_defconfig             | 101 -------
 env/Kconfig                                   |   2 +-
 include/configs/ls1046a_common.h              |   3 +-
 81 files changed, 2 insertions(+), 6092 deletions(-)
 delete mode 100644 arch/arm/cpu/armv8/fsl-layerscape/ppa.c
 delete mode 100644 arch/arm/include/asm/arch-fsl-layerscape/ppa.h
 delete mode 100644 configs/ls1012a2g5rdb_qspi_defconfig
 delete mode 100644 configs/ls1012afrdm_qspi_defconfig
 delete mode 100644 configs/ls1012afrwy_qspi_SECURE_BOOT_defconfig
 delete mode 100644 configs/ls1012afrwy_qspi_defconfig
 delete mode 100644 configs/ls1012aqds_qspi_defconfig
 delete mode 100644 configs/ls1012ardb_qspi_SECURE_BOOT_defconfig
 delete mode 100644 configs/ls1012ardb_qspi_defconfig
 delete mode 100644 configs/ls1043aqds_defconfig
 delete mode 100644 configs/ls1043aqds_lpuart_defconfig
 delete mode 100644 configs/ls1043aqds_nand_defconfig
 delete mode 100644 configs/ls1043aqds_nor_ddr3_defconfig
 delete mode 100644 configs/ls1043aqds_qspi_defconfig
 delete mode 100644 configs/ls1043aqds_sdcard_ifc_defconfig
 delete mode 100644 configs/ls1043aqds_sdcard_qspi_defconfig
 delete mode 100644 configs/ls1043ardb_SECURE_BOOT_defconfig
 delete mode 100644 configs/ls1043ardb_defconfig
 delete mode 100644 configs/ls1043ardb_nand_SECURE_BOOT_defconfig
 delete mode 100644 configs/ls1043ardb_nand_defconfig
 delete mode 100644 configs/ls1043ardb_sdcard_SECURE_BOOT_defconfig
 delete mode 100644 configs/ls1043ardb_sdcard_defconfig
 delete mode 100644 configs/ls1046aqds_SECURE_BOOT_defconfig
 delete mode 100644 configs/ls1046aqds_defconfig
 delete mode 100644 configs/ls1046aqds_lpuart_defconfig
 delete mode 100644 configs/ls1046aqds_nand_defconfig
 delete mode 100644 configs/ls1046aqds_qspi_defconfig
 delete mode 100644 configs/ls1046aqds_sdcard_ifc_defconfig
 delete mode 100644 configs/ls1046aqds_sdcard_qspi_defconfig
 delete mode 100644 configs/ls1046ardb_emmc_defconfig
 delete mode 100644 configs/ls1046ardb_qspi_SECURE_BOOT_defconfig
 delete mode 100644 configs/ls1046ardb_qspi_defconfig
 delete mode 100644 configs/ls1046ardb_qspi_spl_defconfig
 delete mode 100644 configs/ls1046ardb_sdcard_SECURE_BOOT_defconfig
 delete mode 100644 configs/ls1046ardb_sdcard_defconfig
 delete mode 100644 configs/ls1088aqds_defconfig
 delete mode 100644 configs/ls1088aqds_qspi_SECURE_BOOT_defconfig
 delete mode 100644 configs/ls1088aqds_qspi_defconfig
 delete mode 100644 configs/ls1088aqds_sdcard_ifc_defconfig
 delete mode 100644 configs/ls1088aqds_sdcard_qspi_defconfig
 delete mode 100644 configs/ls1088ardb_qspi_SECURE_BOOT_defconfig
 delete mode 100644 configs/ls1088ardb_qspi_defconfig
 delete mode 100644 configs/ls1088ardb_sdcard_qspi_SECURE_BOOT_defconfig
 delete mode 100644 configs/ls1088ardb_sdcard_qspi_defconfig
 delete mode 100644 configs/ls2080aqds_SECURE_BOOT_defconfig
 delete mode 100644 configs/ls2080aqds_defconfig
 delete mode 100644 configs/ls2080aqds_sdcard_defconfig
 delete mode 100644 configs/ls2080ardb_SECURE_BOOT_defconfig
 delete mode 100644 configs/ls2080ardb_defconfig
 delete mode 100644 configs/ls2081ardb_defconfig
 delete mode 100644 configs/ls2088ardb_qspi_SECURE_BOOT_defconfig
 delete mode 100644 configs/ls2088ardb_qspi_defconfig

-- 
2.17.1

