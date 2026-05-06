Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04790CD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 07:55:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FE588484F;
	Wed,  6 May 2026 09:55:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jWoDFf+R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF0738486B; Wed,  6 May 2026 09:55:31 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B22E18394E
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 09:55:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ibZbuRmw2HzKcamsn0HnaIaHGZK2x7JKZwGsNU7pb5GMeQmu/t2cfP1fwtL+uHYHriW5n5FiSjKhfnh/cmorFWL/iv1rELV+tyG/eKPOYjsiFLzjBTVIlV9oLHh1hiuTSH2DAu+Y5VVyNRow+tTMM64E2gA4sbM0dHgJYYVc7cf7Ci/M02U3CbIjj6A1fpiF7pAgUPAq9FKE05FtnMVK69DQG8DuJTl3PBNxrvNNirXRSkoqYvUTeXou+caa5bmpBelfiSHnMfn5Av1iz5UY8Vs4vKAgwac4vQ2NxOig3qp79DphWLVF66NLAnzhP/skBYOC3azBvJgV4mYkN/Eddw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0RYnDGZrgK6jpRlb6LvdG0S81KKHu0PBQ5sIkNgan74=;
 b=NNaMTAIamN0A+rwR3NBwbbBNRivha3I81kNv/wflBTSwZrnIGVCgrBFem3oItssu76cwDHkhw6eW2l92W4wZkgz6hcHOBusrEHbYz/v9NI9aQN7qG+eTGB7mAcsF3GQiTPMsUMmkZjS4bMC9AhLyYTgissup8X0X4SA6knoiGZJa76Rxyk9ujZHtYRG+ojIhwItKcMOqaRNG1edJFDX+ANbSuC7bzxuovBInrRsdeitLQdmAYzgbx5sDTiA3DkTRqijreddKtUFdgnY3CWsXva+Hpo+WjFCjQ5bX2jipPbMTokOHZL5cygHaUnmcZONDlPdsk/DfutXP2h8gLMnj+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0RYnDGZrgK6jpRlb6LvdG0S81KKHu0PBQ5sIkNgan74=;
 b=jWoDFf+RgMod1T6aKsgCaZmSplVpE3KtLkp0Fid3xD+P4hGP0Ubs4mS+GNolaYT9jdCxNaHwQ4exu4xC868lHkIcfpiFUqmd2QODNhVC95c9zXvMFEluI2QvjlxZkRsBrMUx2TN/+Y3ESvwcSH9rzTe8f5Bt0pK5Si74bawGyrFuXGM0gf/7pTJyNZAqNRms9cgv00pr0GXyyLFruB0gSYyMtLOHInOufgT/C3M2VgWMFwAkNPAWDtVQi7vNhBZMBzsdFKN98F8X0NqCVbVfegr2/OU2HyOOdUI/TPis6IT6jogm/IgjKIsvWQ20OHJQK8bi834C9WX6z74dGAiO4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by GVXPR04MB10828.eurprd04.prod.outlook.com (2603:10a6:150:227::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 07:55:25 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 07:55:25 +0000
Date: Wed, 6 May 2026 17:12:20 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Mathew McBride <matt@traverse.com.au>,
 Ye Li <ye.li@nxp.com>, Julian Braha <julianbraha@gmail.com>
Subject: [GIT PULL] please pull fsl-qoriq-for-2026.07-rc2 for master
Message-ID: <afsF9Ih4RPQ1L5d4@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MA5P287CA0224.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b4::16) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|GVXPR04MB10828:EE_
X-MS-Office365-Filtering-Correlation-Id: 28dfdd6a-efa6-42ef-c49f-08deab44d4cc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|19092799006|1800799024|366016|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: NZiKSFePfu0dXspFQRGuijwlQ3O5gHnaTXRGlsLxpYSfIhOoTL0lAI7fK1rafCzxqifOBFmSSc1Ti+Ad5W7MNujOhqLLwuXv1Bsq0cS4Icmq3f7oi7BEbMHrLcjQJRtGn4Fm8MhFsg7taFsChxI5OnCYnBWn9MIvJ6lXgeXP9uaoNbTulZWdtsHinlwdiUrn2kStr5ncTYVsdPUfs4rn6UHu/s2MpucvyV91LIeURSHTSwLTl9OJoNVN0KhEwpPdxk9/LPqNOsY2FUTq4JaAUMUNn4qEpoOAAZf6K496YvmsGzE2UeAaYHYf7AWIwBNOOR04AclBkb2k9vKpZDCobm4DfDkOs9NCiv21c3hcudr7N0T2Fel/GBWQm6PC89mlyudRuCNPlcVrrn/gOmKmk+q576lXsvAQ6R5HX1Gu6phvVbowIbZwCmIGV+3tjyUbr2WLZQyjc8fGjVIeMwyBHefp2OqbiMAanmND10nOh8yiUhADiH/ehCgKOzP9iNmA2G0fJxnicKZ6NK6MHEdey7JYYYy3Md77KxP0RJWf+3kW+rvyrADpHNodCRxygfjyaZ8ZNFPY6vWqAbt29j2PFiECjFa+4NF3TcDWzB1SEkn9IuD6vpSrGUQe8wXG0hn46iPt6ly3j0wduTF/Fq2X0qAXdZUDlsJxsuVU2hwL9Q9qpxkxIFyoJMc4PJOWlDZSC1t4TOjb/4aPMsyH+C1w9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(19092799006)(1800799024)(366016)(38350700014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?shMex28r68/ABHw28/2TVKSbroEVUG/gvHfwPFi+jCjyKdygWg3JY4IxhG2+?=
 =?us-ascii?Q?1mvRm1x1lA3NWyeeNPJLHnZ+3nbId+ZlbDb4b14LdOAu/OSLFwEIoDPmZh7D?=
 =?us-ascii?Q?QXxRg0KDeLo9TAFiaNbhzwuUWfKBsZLeMBCP1kR8CICWrIRCjgJW2elXTUs8?=
 =?us-ascii?Q?4wOvD4GHGa/+giaomhFFuw81uJhk/f9Xr+pqy/CxXfwwUjiKF8s8bPdSO5W3?=
 =?us-ascii?Q?g6J/gjAA3w4TkYYyQNbJALAJWhK43Fx02+A0vi/zSqVeXvzZe34UnstaAIUO?=
 =?us-ascii?Q?iVbk9MAFK2nuxsD7GhpQ/p2OqE1PBLQ0VDuOuDM3zoYtGWUkUxIro0KDvU1U?=
 =?us-ascii?Q?5mvHMOZTL3zo5wcYuDfN4X1OKQUYfVouop4OonCoqmIQVYIH3phtpcqjrplE?=
 =?us-ascii?Q?zkRJtwavunmMZIDhWfPiiYIRYjVKBGCw0sDBUlr7O/eUdvC1jglpM8lFqiwV?=
 =?us-ascii?Q?EhNll9eCDj66lK/yM3fbKrXcyjLBLDnYxsA8wmxbvoujCth717pjwpRQi6a7?=
 =?us-ascii?Q?SenoXQc7bAt9izJNy8uEG3acj8q6MYE2gAu1gO/2bMF+9e8SL8YYKdV4HXEM?=
 =?us-ascii?Q?+ccPFbd7cVhOlI+fz8I+W4SjqFXHvkbiqskC5+ZB4vd+NYE5GXHom/UzlLfJ?=
 =?us-ascii?Q?zsSyLp6C/BXB/LC3BhbyNGzO4wOREuH/AuurDDjafUHi+UqSjI8zeZcSIFdB?=
 =?us-ascii?Q?sUW5F4Cq0/YzG5KuZXQ8SbQu3UESzFWFPxpg56gOZo7AtwEeY5Tu5huknViv?=
 =?us-ascii?Q?gfReAPEaM4NUMMijPAZPJv6dMN39Z17UhuF0dEx8BGmNHD6uZci3qiTOxgr0?=
 =?us-ascii?Q?hNPxpqVDvVn0ZIK1JWWjxyx7IsnWraE4UItC5FC8xNChqhQ5yYxkdoOYZ7Ta?=
 =?us-ascii?Q?UaXSu3xb1G1TKr2ol5g0OQXHAHWCq3IdB4uyIbFCTCT6GyJnZSgfwi7XHB47?=
 =?us-ascii?Q?ttpnR2nauVNgxjjvGp4jAUT4aWQ36SXBqUPAG5Pn+VbNI/2Vqzanwo4YCBYD?=
 =?us-ascii?Q?Iso6amZsjh6d85JAegcJjYNdySYB8C1KGiczg56GhdxdbShmWhVIWZppBBz7?=
 =?us-ascii?Q?KezzlYfmw3i0+WO+M/qhC5MbzrcHvqlAEMk1+cJYpX4w7NkW67rKPAp7G/Tb?=
 =?us-ascii?Q?n5P44I9hdkt/PsxUsvN5gkgrXsJYHajjthojN4BvhC3JMaSLg+z8yWAR11Tb?=
 =?us-ascii?Q?5mhs0Y8rFZC4+O39R3njrUWXLwN3p79XxlmB4SJ9vkojC4eO3/Psk1q0EiN4?=
 =?us-ascii?Q?9jhTHrZstsMXshssJNRy8S9XDK9zAZfIMf3HiKK5EEPPSraPUtzNJbZmS2zy?=
 =?us-ascii?Q?usTV2DihfrINi5YM6qz2GEOdAFscQcnXJrpYXQXiHePus61F5z4JVajymKaf?=
 =?us-ascii?Q?wpwc/fPLfR72hBZFgj36TT5I7c8beaCLYSTkXfeEWYPvOPZT1x8isivpob3C?=
 =?us-ascii?Q?CEvokmta5jSqa1iv3rDWxyZPu3aLbgyuRdJsAQ5cvCwrVyyx0DmmXP5CyiyX?=
 =?us-ascii?Q?LLD8o2gwvzcBg/QOkLbz1t0Wptq2oo4W7MmUIIU5442JYZ8OGm4ltJmnNP8G?=
 =?us-ascii?Q?nu/UfNjtbq9O3i3UzzjKcDj6ie15Qf9YzXRe2VR0pCjo86nuTX2MLt4sqjiX?=
 =?us-ascii?Q?m9H95Alr++n45aJbS2JglMT/ZxhjrKac/0Xw2mue7P3XsTb/3Y0X1wGGK6hx?=
 =?us-ascii?Q?P4R/eMbUrLGb7ZFggET07wzAmvBPxo1cP53OYFBKBs0Pt0Eqipj8DwnXtztr?=
 =?us-ascii?Q?k9vhHA1AWg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28dfdd6a-efa6-42ef-c49f-08deab44d4cc
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 07:55:25.1001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y2uaRLGQJmdkzbOc6S9GfRAGR0sxXYSk1hxobcEb2nAJbpkwZjbYXJUFZSHzxKT8g5XMgnZ4qbtinv3HnMCETg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10828
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

Hi Tom,

Please pull fsl-qoriq-for-2026.07-rc2 for master

---------------------------------------------------
Add USB Hub (USB5744) management support for ten64
Various DT fixes for ls1088a
Fix dead default for SYS_L3_SIZE for powerpc
---------------------------------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq/-/pipelines/30003

Thanks,
Peng

The following changes since commit ae8987f4e690f397f507c4b1efabd68b3ed08db6:

  Merge patch series "binman: Fix preload signing with encrypted FIT" (2026-05-05 10:37:16 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq.git tags/fsl-qoriq-for-2026.07-rc2

for you to fetch changes up to dea09737234b8d9b86d0922f31d3f2a68cef3a54:

  configs: ten64: add USB start to preboot (2026-05-06 16:04:49 +0800)

----------------------------------------------------------------
Julian Braha (1):
      powerpc: fix dead default for SYS_L3_SIZE

Mathew McBride (8):
      arm: gpio: include integer type definitions for gpio.h
      board: ten64: add fdt fixup to hide usb hub topology
      board: ten64: remove USB hub references from internal FDT when needed
      configs: ten64: enable OF_BOARD_FIXUP
      configs: ten64: enable USB_ONBOARD_HUB (USB5744) option
      configs: ten64: switch to OF_UPSTREAM
      arm: dts: remove local copy of Ten64 board DTS
      configs: ten64: add USB start to preboot

Ye Li (7):
      arm: layerscape: Check zero size memory bank before lmb_add
      arm: dts: fsl-ls1088a-qds: Fix missed -u-boot.dtsi
      arm: dts: fsl-ls1088a: Set dpmac nodes default to disabled
      arm: dts: fsl-ls1088a: Enable SD device
      arm: dts: fsl-ls1088a: Enable USB nodes
      arm: dts: layerscape: Fix DT build warning in SPI nodes
      arm: dts: layerscape: Fix SPI flash compatible string issue

 arch/arm/cpu/armv8/fsl-layerscape/cpu.c       |   3 +-
 arch/arm/dts/fsl-ls1012a-qds.dtsi             |   6 +-
 arch/arm/dts/fsl-ls1012a.dtsi                 |   4 +-
 arch/arm/dts/fsl-ls1028a-qds.dtsi             |  28 +-
 arch/arm/dts/fsl-ls1043a-qds.dtsi             |   6 +-
 arch/arm/dts/fsl-ls1043a-rdb.dts              |   2 +-
 arch/arm/dts/fsl-ls1043a.dtsi                 |   6 +-
 arch/arm/dts/fsl-ls1046a-qds.dtsi             |   6 +-
 arch/arm/dts/fsl-ls1046a.dtsi                 |   6 +-
 arch/arm/dts/fsl-ls1088a-qds-21-x-u-boot.dtsi |   9 +
 arch/arm/dts/fsl-ls1088a-qds-29-x-u-boot.dtsi |   9 +
 arch/arm/dts/fsl-ls1088a-qds.dtsi             |   6 +-
 arch/arm/dts/fsl-ls1088a-ten64-u-boot.dtsi    |   8 -
 arch/arm/dts/fsl-ls1088a-ten64.dts            | 388 --------------------------
 arch/arm/dts/fsl-ls1088a-u-boot.dtsi          |   5 +
 arch/arm/dts/fsl-ls1088a.dtsi                 |  10 +
 arch/arm/dts/fsl-ls2080a-qds.dtsi             |   6 +-
 arch/arm/dts/fsl-ls2080a-rdb.dts              |   2 +-
 arch/arm/dts/fsl-ls2080a.dtsi                 |   4 +-
 arch/arm/dts/fsl-ls2081a-rdb.dts              |   2 +-
 arch/arm/dts/fsl-ls2088a-rdb-qspi.dts         |   2 +-
 arch/arm/dts/fsl-lx2160a-qds.dtsi             |  36 +--
 arch/arm/dts/fsl-lx2160a.dtsi                 |   8 +-
 arch/arm/dts/fsl-lx2162a-qds.dts              |  36 +--
 arch/arm/dts/ls1021a-tsn.dts                  |   2 +-
 arch/arm/dts/ls1021a.dtsi                     |   6 +-
 arch/arm/include/asm/gpio.h                   |   2 +
 arch/powerpc/cpu/mpc85xx/Kconfig              |   2 +-
 board/traverse/ten64/ten64.c                  |  70 +++++
 configs/ten64_tfa_defconfig                   |   7 +-
 30 files changed, 201 insertions(+), 486 deletions(-)
 create mode 100644 arch/arm/dts/fsl-ls1088a-qds-21-x-u-boot.dtsi
 create mode 100644 arch/arm/dts/fsl-ls1088a-qds-29-x-u-boot.dtsi
 delete mode 100644 arch/arm/dts/fsl-ls1088a-ten64.dts
