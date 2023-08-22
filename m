Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E47EE4996
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 15:03:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61C0086487;
	Tue, 22 Aug 2023 17:03:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="gU6ssjBX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09D158648E; Tue, 22 Aug 2023 17:03:51 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33BD08641B
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 17:03:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=laurentiu.tudor@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nO3eGbizo+oXT+lDudNnE90bfmFhVA4FBkSX2+zJEfjWjkRwcqLdUc4x6ZIzhTCwdiF10qxrAsEhwOu+ZwK02IXh34+NYB6+F9UdKMkl4QjCAEJF+VYUHnrKUmkg8CpJfh9dR3X/H5hps5joICay/TSGfx9xiVbyf2Za6U9/1LEpHLjPpxjkGdjbOVBP8lWilZXA2KXdNtxd5DiAhi/7IRSwDwfcp7DuWy2DChJZIFw2UCPcjiaOY35pHKQnINpbXoPBnBMG5RocKJrliHayZDN/0W33p/FMJpBjB78jBVOJtb2frpI5cYSAKY91Wwq9RMCrvgnd+a0GyKVx2IEuGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y50mI8YGC/n0yUubCrYxsZJh835s2dm+ueyFEHgUdO8=;
 b=c7lIC5PxwbTaR4kx/kaqZkP3mA8uTJxKJ/kAvXGH0eInxqGR+O+RgVz0EJA2+0L58nBOdtP65ZRzQokRmec0WpOke0cwP5+7SRd81u5kNAgAAR0nJIKfUO/uUtJ8GkHL5ZwrT97qos08rU/wIOk4tObenm0r0iIsLU7oLQPeFG3oNdgqC4OQBFukLdLAAaqZoyM9gfTloYiMOLhCkqZyLRN0ONUUvp7eOsVXurJ7NuloRqt9yD+7rDRVpXhKfnTRk/PbDlWGY5pcYLMdlYU57ACsGOWDbbXkbc1jCIOungoj0FGRckwwgfQwHwiTFzSwTEB5ZbjiDDQ2DzLDpAX6DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y50mI8YGC/n0yUubCrYxsZJh835s2dm+ueyFEHgUdO8=;
 b=gU6ssjBXhWemslvvmtNwnsnkhIaE00zf0ycPYjS6PyOfFuB96nB/AbgnzIbucxbcAwEaYleozrKvpbU4XKLJjtm0vERcbC3uT9hagk8T4q5ehbN+K+OcqANKQLTBaL0r4WtTsar2HQGtobsg3rpE3KEghuCYWNBkKT/WPAeAakE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com (2603:10a6:10:368::16)
 by AM9PR04MB8132.eurprd04.prod.outlook.com (2603:10a6:20b:3eb::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 15:03:46 +0000
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::179f:1c4a:4573:acb9]) by DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::179f:1c4a:4573:acb9%4]) with mapi id 15.20.6678.029; Tue, 22 Aug 2023
 15:03:46 +0000
From: laurentiu.tudor@nxp.com
To: rajesh.bhagat@nxp.com, pramod.kumar_1@nxp.com, andy.tang@nxp.com,
 mingkai.hu@nxp.com, Ashish.Kumar@nxp.com, priyanka.jain@nxp.com,
 wasim.khan@nxp.com, matt@traverse.com.au, udit.agarwal@nxp.com,
 joe.hershberger@ni.com, peng.fan@nxp.com, sjg@chromium.org,
 u-boot@lists.denx.de
Cc: michael@walle.cc, camelia.groza@nxp.com, ioana.ciornei@nxp.com,
 vladimir.oltean@nxp.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v2 0/3] fsl-layerscape: drop support for obsolete PPA secure
 firmware
Date: Tue, 22 Aug 2023 18:03:31 +0300
Message-Id: <20230822150334.15703-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM4PR07CA0027.eurprd07.prod.outlook.com
 (2603:10a6:205:1::40) To DB9PR04MB9380.eurprd04.prod.outlook.com
 (2603:10a6:10:368::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9380:EE_|AM9PR04MB8132:EE_
X-MS-Office365-Filtering-Correlation-Id: 72889ae9-6721-4706-b268-08dba320fbcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Na6CrVft2my8NJhhDUy09RFP47MWFE+uNByshipP6Sz9A3VSQR3iFB4TSbd2P/Zp8SpU2rQdByhjAoCowQZgbb5VTTAUQDlqDdDZJwT/x5PhPRea+CJTe9QiebvyiWvfU43YtmgZhAT5byyGtHCs+BWBeifHOAgyxItq8O7ENXS2cZWwVylHNfuNFcpnuER5dQgJ7A7WSAZIArqthpdWufT9dFQyxtv5pnrsPVFZB7wlxq2CJ1b4M6iBna2j/Xv64i1xYDrz+ChzT9gFVJH5I5keDDPJm0j7ynAOeo1FZvNfgu8qWpNZ/dzp6zfFPFJyZF+wduObAciwUQ84b93xwRtbIhBnQ5KF/ikU96ZLEOwoXERlSPZe+Kyo41zNfxX0QpAjVL7M87L06mOj1NpIpX1ChqAAfNKke8XBcY+w5Z5oT2XB7Cqf5LyMeet3DmvBhKYGnAqZoBCliRI3NqmXCeda4wHHiXYDH2/VykpEBxlMupEPDu2SjYlKVqQJi24QX/WkXseJBCpt4plJ7/URk5ISHDsIuaR+TJrM8PZchYK9G3jrAEn7nteYREh7ih3r61MBhYpNs4tziJnvhmeqbEkSRJq/fNvgI08opvQQXEQ2m31gdZYqTnHpNAn8r+dFnZxkpcoyfebRE5MMzmTXLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB9380.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(376002)(39860400002)(346002)(366004)(1800799009)(186009)(451199024)(66476007)(66556008)(6512007)(316002)(66946007)(9686003)(8676002)(8936002)(2616005)(4326008)(36756003)(41300700001)(1076003)(921005)(478600001)(6666004)(38100700002)(38350700002)(52116002)(6486002)(6506007)(83380400001)(2906002)(86362001)(5660300002)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JGLFVCi/PFQiX6Jy/yTydJvB26X56MH3JytTAA9ZvJ90rUQ7tBh0+Rpu+tnH?=
 =?us-ascii?Q?X8TLV9UE6rIDRyhDA6Xpgw8Pa/WRJzGlQFLIu7vDrlUhD/E+9y1efAEwTZ8C?=
 =?us-ascii?Q?e8TjbnNu16ppBg9SiV97+YZG9GXDF/13ltAmfZeyMWr2XxN3lil9UxgYUEnM?=
 =?us-ascii?Q?ccKs2b/sw62yMUZNrvTZfeefavoNUH6toYRAzXtbhQnOdcsVTuxbW1AhkLSX?=
 =?us-ascii?Q?fcKGa3/hdN+nXctLGZ8DCvee9gYC1UVDqPZvEXEdm5Kl/EQATdXCWXT5mtXu?=
 =?us-ascii?Q?h0fd0UEj7UDde3Av5JmI56HWZ4hS2GJ+MKyPsjFw22vLhMhLJglW0zmxsIP9?=
 =?us-ascii?Q?RFZ5FraYk8eQM4p/AQ4d6XFRMQjyQvytLXDXnvYpZBPY53ryHPS7DPdgkjai?=
 =?us-ascii?Q?4hLYI481Qt/8kSYFIRJJULcLUj+VufWO64cthAnWQ0DWTv83RBSiXxsGuqj1?=
 =?us-ascii?Q?P1+ugTGEvCWfnQ88PEaBajCvC51QmlhlYEeaxEIlh7rkERwwkVz0wQZuKJgG?=
 =?us-ascii?Q?n8y4B9cYhP9GEUaB2vssFkFEsn+HC84YYm/torfSs/8rLFz7Gcl9fbpERuCV?=
 =?us-ascii?Q?DpH7tUhNbKkZygPI+t+I9Ht5gtNqsk9at8UuGrwCmBjDrAK4DWhWHTCbrf9l?=
 =?us-ascii?Q?e6WGXvmgg48fkz9veueFRZF6jDtL/jS2dZxokH3KSx6dldPZGkuNSq9fBRia?=
 =?us-ascii?Q?hqvKrkX2IC6c5sB+FRuUvZtSL0lD2z8mxvuT59CHBwrwiiF9OH9FkpG0nqR5?=
 =?us-ascii?Q?nyYjSbyZ5TF5EsaQ9U87Z6O3EmJfXEaqePrS+l1p9T8VehAKWaCUhPDgpODz?=
 =?us-ascii?Q?ZHbW0p4PLvkEeuSPxsZ7NfV0eNZZxl35Q4/Du+i1HIXgoFdm+HRRBxMULnnr?=
 =?us-ascii?Q?gr8uWk7lQ/jKKGGlUE6HwPdElNcC8yOHLkkKrKwutfYO025imKpxQMbZG4tC?=
 =?us-ascii?Q?RhTkfhmRAhPayz+TykZ3kWUm0/dYhCZZ7T76ZdRkyhoBtuELmKzAcdiPbtiD?=
 =?us-ascii?Q?2EQxpzt7b4WN4CAHd6VombN8BOfO/uyrpbjM+QZ3YbymQ86MkxVIqXLucg16?=
 =?us-ascii?Q?Eh9LZJwosE1WpQ+hkBHgWR/sAi4MnbStJgxrkg+77o/jD6v3504m2D0AuLNb?=
 =?us-ascii?Q?fPoxatuiKM/L+eyX34JXS7uCo1kPIZLWCypqTQh9B0J+xlXysHALtxLwFi6v?=
 =?us-ascii?Q?5W8FgNNjzlvmd7lyJQnKlaAQl3QZ8vGwwKbcudw3Fb/EgAWJY4AOAM/L83LK?=
 =?us-ascii?Q?Lkqhm2Jt8wFH77Aglf+wq45eXdIM+jjJc7QhF+YB3LW49uTV9EIxr11EojqA?=
 =?us-ascii?Q?TAkRawqUPkvxXtMlBYLo5jd34Qo4UQpziaxGi2QIp6CqnwRoM3LC9Hce3R3o?=
 =?us-ascii?Q?SYxA5nkFb85VjF+dy4xqqi104Z6ChvfO5u2vagaLVZ/cutI9x3zdgZr47kqJ?=
 =?us-ascii?Q?mJsNffgZN6bTRV3MpLPkgtp+B/yWsjDxngyXl0fi1Jp6vXuPW0Pp3LPxJbWv?=
 =?us-ascii?Q?l1TiH5WGAUnXWSIn85pktK4xxA9hWeu1U5Ex2ek/EVFATUwPIEP9711mxJ6h?=
 =?us-ascii?Q?jkynouURs3tWogoitxu3pslepK8xJYonP0NT9fQL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72889ae9-6721-4706-b268-08dba320fbcf
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9380.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 15:03:46.3940 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4DQveOFNas7WSJYB9ECLo0SofcumFxrBYFLKP4+XBxXkrw8r3qB6et2j+wmbwWCgU8Olp613eEdUhXJRvE+PnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8132
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
 configs/ls2080ardb_SECURE_BOOT_defconfig      | 107 -------
 configs/ls2080ardb_defconfig                  | 108 -------
 configs/ls2081ardb_defconfig                  |  96 ------
 configs/ls2088ardb_qspi_SECURE_BOOT_defconfig |  96 ------
 configs/ls2088ardb_qspi_defconfig             | 101 -------
 env/Kconfig                                   |   2 +-
 include/configs/ls1046a_common.h              |   3 +-
 81 files changed, 2 insertions(+), 6094 deletions(-)
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

