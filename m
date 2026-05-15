Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 175D6CD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 12:50:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1B4884683;
	Fri, 15 May 2026 14:50:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lgqwq+nc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C2D984688; Fri, 15 May 2026 14:50:39 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A94E84686
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 14:50:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IiE3pZUJ/MAneIHZvoqtm/HnDPNUcgElGG61Ul78z+ksWMtnoBuTAGe6pf9mvWWH49dPT/yWEoVY8hI0QDNTi2RyTWT12jnjhcY7LaBmzYb6vPU7dpn6S3Rkznhbo+1vFQDuI7SlRATWIjy/+/Z1+Hxq6/SONiVe/5Tz7PIgGi/ZIf+C3YmwP6tOuaAFs+0XPldE4I24Rw/7kzKl7smJIgpyKjMzwCjW0u/djSMMp4JPlyVdHnJzodO6MCpbbnSNfm5xGqtKvtAFKjM0vy4PECperSRHUIqpxkdC4HXWoOb48KcxpP3OOOf2QY6ZP1W3dJdVg1UTf7q1m7UOEdBUeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTe+HJueOc5m6AIkIOa9ejaDgPu2tw7CUXwAaNo/w0A=;
 b=gzZpN0vbgGC+vvh8wKxW38noxca7NJBmz3W60B7pbP8j2xPlM2KNMukc/skUzT451ZDPq0nQf/cO/MaNnPqpwK0PgXrKPjntmEPMgIIvkkx3boOEY4Mn+9ItSdlMDDY8T7NI1r+YpbPbuh44KpTMlDU1mWNXSlHWoHB+2+MOaqZuD7QkotHHtdYJL6DyDFPjrKaLC237kb/KHJCWkruE5cA0cR3K/30EE7vSwu/o5ZKbWp1wXhcrpz7FKwepBi9HqtmEOomyGuqe4lC6l+W7t2/CEVPF1DbtMKep/GYluCrez491yaqBGyKsTUpNl8xzZ5nUg9+amOQ6xgP4IV8VKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTe+HJueOc5m6AIkIOa9ejaDgPu2tw7CUXwAaNo/w0A=;
 b=lgqwq+ncf6LphNm1KIV7XKUieXQuUmg0+SgLTlHVMoWWIqKzaGuAiFaZT4h6kzLC7Pm/NltxvJClM2F1iYS3+Q6lE66UehTPc2+eUGh1194PjlT45/DEuklZV/yimCmxbxStcehTt8FvxLxgds5K7iH68jSvLVkf87Ix+abfhjiNd9Yd+hISkc+FoSfja50ZHGxeij5bqLLePMPV3ZAQQS5yWnSuV4wCANUvRODAKm6Byz48j8tQbKrrXLcek+BYsMxO1JKjMOf93ltTbTv7oBqS0FOe3tK0KqzE6x/dqwQ2YK8vj/skpEtjLH31TW9TTtn2ZcTLAiaN1EJ29Sa52A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by GV1PR04MB10774.eurprd04.prod.outlook.com (2603:10a6:150:205::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 12:50:34 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 12:50:34 +0000
Date: Fri, 15 May 2026 22:07:47 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, marek.vasut+renesas@mailbox.org, vjardin@free.fr,
 Michael Walle <mwalle@kernel.org>, fberder@outlook.fr
Subject: [GIT PULL] Please pull fsl-qoriq-for-2026.07-rc3
Message-ID: <agcoswygQdy5YKu6@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MA5PR01CA0265.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21c::19) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|GV1PR04MB10774:EE_
X-MS-Office365-Filtering-Correlation-Id: 36f04ac1-6466-4cab-fd2d-08deb2808e1a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|19092799006|376014|366016|11063799003|56012099003|18002099003|38350700014|41080700001;
X-Microsoft-Antispam-Message-Info: 3jlVofoz85iXB3FAmhPtRoSE61aXldlQq4WAzmm3SBsGEfOtKQEp8WEhtuhlrwDsUqsM7Ks3R6qPIxOeH9mD8x0GQUBs59q79uv4oYkj5gbo0Dl0SG+NKlppWrGhUOEdq76v++3sFIOCbX5wgx0fPOeYjhzOp01e+xcEXpXPHlXKDDn8ZIQoBktgfhs8aliWHvIgfF26+AS4VAWE+ylun2JutBcmOrLWCYNCadWKqqeABg2i6rdsg/H60Y5SGXvr7i5cZC/VRXU8mSlnYA7Xt+ozE2sR9DlhYRkYGh9JOLa4nUAlIKs884mpfciDJ4crFyXof8Nz6W1lLINY9S00x/zF0veSXqZYRltly2n6qt637UNR4jcibvT2OzT/eugidwT0KrDxlNyLoreHsLeMZBePt8ELwaCy+Os5m8eMpC1EhCaRhzQ0zEQB4tn8quIXCc3xONRATlxTdHXrquveoK/qfVuk6SiHqp4H5EGlpXdhQBNchEEpiIthiYDPbTJ/zTv+Yl2MrXYgrgqJ7vktZWlTXy2yaBPVWB2bHcU6NOgfkpDHa/BOkLAAZSGTnCsIZbVm/HYtdmz8lV43T1hu6tRuYA79uAaPZFlX4Y8IPdf6P1H/y1b56PA6hXldUG3BUiDCgjadQKnkHsyAcwo8cKaHtnaUdJLwZ1EK+B52akMzckDH0ZXTj6r6qsmeWVu97AZcOCuCirhwaHeIhXU+mfadsvWGxtKvwlK0GiXxyt8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(19092799006)(376014)(366016)(11063799003)(56012099003)(18002099003)(38350700014)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R94p5t7a3m8FVv7V+XXisggL03GzOMMlVU2eK3DKJ4OKDaubuth6JZ3ADNSZ?=
 =?us-ascii?Q?K6EjuzpZ/XXjwNokPnLEBP/chxIEU7skHsqQYVxSldZyJ/wpRkXdIo7o0UWi?=
 =?us-ascii?Q?6QXptl5KAF/pQdbcXF4pqob6gTC2gixkrZ4dTFRTcqpYSs6HuSrlntcU0fAO?=
 =?us-ascii?Q?qIQgVScUN8tpMDpVIdUBxx02gpz5PDVqF9W3Fxy+vvRP/ViE8j4jqc23F6Sk?=
 =?us-ascii?Q?0GJdMvihZrPRnLifouMEM3Z0JV/xS3YZMTXKkZeGXYfhXZhIyrA+l/Cxr9hi?=
 =?us-ascii?Q?kv2FMR6ih1/ChLoZ2ib7MJQgplev2kTLSp0MIekQixDtCQVDuNcMo353QUtA?=
 =?us-ascii?Q?W89wG5kopzTEoNTyXKsIZ+67wJAy2e20ndg3LIg60q3wm82Ufgi2O8zOOSnG?=
 =?us-ascii?Q?PiSr5cbRcUNO6fMpNvdHJKnXeeGmK6V8JqZmbSxXTBBF84N8zsZKQPsGbsp1?=
 =?us-ascii?Q?M+0MZY5RK7QM+32pWscHplZkdf8f57xY6ybovC4UuamT4SHDIRGfadBkT9dT?=
 =?us-ascii?Q?Fc43wwsZP1exTs2/ieFJ6zXDQXQQD3TQoagd1Nd9Vb7w86hiXR88ws6TYz6T?=
 =?us-ascii?Q?5JYzQwrEWSUUV5ZdAe7iVyRDWFfZ9FLPqDHNG4NbdNHsQ1wYiIBVtc5TB8NE?=
 =?us-ascii?Q?Vkjf+rfo57Edo3m0BuMo028dqsgFCfUwwG8CgfVqheXriY1B4B7pQ6HnPmD0?=
 =?us-ascii?Q?U4+C6M9Z8oiQ6ahy9GB5AJGDTW6uyGFqW7pkcBnx2jjr8U6IuKynfNnpUkJI?=
 =?us-ascii?Q?cB7v+EAVHRyyEKTSSj9et/65dvxkKBzNrAheAtMZTSrvaNluc0lvdr+fl5Kk?=
 =?us-ascii?Q?xRGdeI2g7VFTu8JL9j2vFD1/gsg98esytcXgr8j7AG/Ymmu6pvg/bxwb7yru?=
 =?us-ascii?Q?tH9a6LnpCxDf63qk1bVrEU7YLYmYTyUEEQC+Gx2xO7MZbkEaloU1dSK67JUm?=
 =?us-ascii?Q?VFXpPbT+r+pWQ0faRchYC1NrzldarQXJ4dGW4gbuQj1Y3XZxxIUoRSxR5mPq?=
 =?us-ascii?Q?QzxTA9N8BUp5z1LHKL5TQnD52iUfyxv7Bv1w/esCF2cWVtSFyKlzrMQC+3do?=
 =?us-ascii?Q?/65kYcZH/HH8zclJVh0wc1240XCOGlPx/KJSh9jVFzrJ62h76muqq/zX94ca?=
 =?us-ascii?Q?g4L5plRaqQXyfVOMWBiUCx44T99+AfkEHOSHXYTABWXwvfbCsJGWnmJPmN2Q?=
 =?us-ascii?Q?/8KTnCLPLRzrnymOPuu5q6MNvGTX7QFnH6iw2UH3LTfcAW3J0Ai+lLrnNbaL?=
 =?us-ascii?Q?YCrRTWNNjelLFHHFAsic1A7oeE5YknsFaEpT2FZpQt/EeTVRbhqczoklXD37?=
 =?us-ascii?Q?lL5JwTXiAVAvfU7VIwylDN/UAcUUH4h3gbB/5wXy23TJd1k68K+aXJxLcTSS?=
 =?us-ascii?Q?IvBYGuaP1l49omjj1pqcP553iHQllqMwDIFfDG3rLB7oiI5DR5WVM+LEffyR?=
 =?us-ascii?Q?Zoldvk6kmf4j4JJU8aqEOx9K/661o2I8oxbjLdj9Gdxr0gx6SkU5H2jhucHq?=
 =?us-ascii?Q?XMy+mIO0FlatWera/Q9GVQn+ddbKpE2bQEQvb4F3E7ld9f8TGoxKAGkzAfRg?=
 =?us-ascii?Q?7ZCx4+N4YDCi3o6VqPyduZbOOrOPJO+RpTW1S66inSTWLwPzf2BAbKMHDhoK?=
 =?us-ascii?Q?QjbOOzojAj4C7Hh5QC6UyNAqxGjoqK7j75d2SQ1VcApbcXSsOL1XYCyZZxLd?=
 =?us-ascii?Q?1aptx1FjsC1NWji9Jg1Iv8pO+28YEi1vmJ7yYB8eiHyYeuxG3CH/5ceeiE1i?=
 =?us-ascii?Q?gBPKfkn8hA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f04ac1-6466-4cab-fd2d-08deb2808e1a
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 12:50:34.3579 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c71YGGOr0SPsFm9Nu0ayKDrt4Uyg4pN8iqvezUMnmxH2DTce3h0xVjd3CPdeRUtoOk0f0mgaqXLpN8CaEhecJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10774
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

Please pull fsl-qoriq-for-2026.07-rc3 for master

---------------------------------------------------------
Various fix/improvments for powerpc
Correct usage of number of memory banks for nxp and ten64
Staticize and constify scmi sandbox driver ops
---------------------------------------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq/-/pipelines/30120

Thanks
Peng

The following changes since commit 03d70a9220f1cf48a80ad1873884c89200685ca6:

  arm: dts: k3-am69-aquila: fix combined boot firmware image build (2026-05-14 07:58:14 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq.git tags/fsl-qoriq-for-2026.07-rc3

for you to fetch changes up to 8bd84cca34ed5836b6110df4355fb920dae65a1d:

  firmware: scmi: sandbox: Staticize and constify driver ops (2026-05-15 19:28:31 +0800)

----------------------------------------------------------------
Francois Berder (2):
      board: nxp: Fix OOB read in ft_board_setup
      board: ten64: Fix OOB read in ft_board_setup

Marek Vasut (1):
      firmware: scmi: sandbox: Staticize and constify driver ops

Michael Walle (10):
      powerpc: fix call to cpu_init_r
      caam: don't write memory at 0 on PPC
      spi: fsl_espi: fix read transactions
      boards: remove dead fman code
      boards/nxp: remove board_eth_init()
      boards/nxp: remove empty fdt_fixup_board_enet()
      p2041rdb: use the upstream device tree
      p2041rdb: support SDcard boot
      p2041rdb: update README and fix typos
      p2041rdb: convert README to rst

Peng Fan (1):
      p2041rdb: remove NAND defconfig

Vincent Jardin (2):
      board: nxp: lx2160a: without QIXIS, MC-ENET, PCI, LTC3882
      board: nxp: common: support CONFIG_FSL_USE_PCA9547_MUX

 arch/arm/cpu/armv8/fsl-layerscape/cpu.c            |   6 +-
 arch/powerpc/cpu/mpc85xx/cpu_init.c                |   6 +-
 arch/powerpc/dts/Makefile                          |   1 -
 arch/powerpc/dts/p2041.dtsi                        | 138 ----
 arch/powerpc/dts/p2041rdb-u-boot.dtsi              |  19 +
 arch/powerpc/dts/p2041rdb.dts                      | 127 ----
 arch/powerpc/dts/p2041si-post.dtsi                 |  43 --
 board/nxp/common/i2c_mux.h                         |   5 +
 board/nxp/ls1012afrdm/eth.c                        |  10 -
 board/nxp/ls1012ardb/eth.c                         |  12 -
 board/nxp/ls1021atsn/ls1021atsn.c                  |   5 -
 board/nxp/ls1021atwr/ls1021atwr.c                  |   5 -
 board/nxp/ls1028a/ls1028a.c                        |   5 -
 board/nxp/ls1043aqds/Makefile                      |   3 -
 board/nxp/ls1043aqds/eth.c                         | 501 --------------
 board/nxp/ls1043aqds/ls1043aqds.c                  |   4 -
 board/nxp/ls1043ardb/Makefile                      |   1 -
 board/nxp/ls1043ardb/eth.c                         |  77 ---
 board/nxp/ls1046afrwy/eth.c                        |  57 --
 board/nxp/ls1046aqds/Makefile                      |   3 -
 board/nxp/ls1046aqds/eth.c                         | 431 ------------
 board/nxp/ls1046aqds/ls1046aqds.c                  |   4 -
 board/nxp/ls1046ardb/eth.c                         |  71 --
 board/nxp/ls1088a/ls1088a.c                        |   2 +-
 board/nxp/ls2080ardb/eth_ls2080rdb.c               |  19 -
 board/nxp/ls2080ardb/ls2080ardb.c                  |   2 +-
 board/nxp/lx2160a/eth_lx2160aqds.c                 |  18 -
 board/nxp/lx2160a/eth_lx2160ardb.c                 |  17 -
 board/nxp/lx2160a/eth_lx2162aqds.c                 |  18 -
 board/nxp/lx2160a/lx2160a.c                        |  20 +-
 board/nxp/m5253demo/m5253demo.c                    |   7 -
 board/nxp/mx6sxsabreauto/mx6sxsabreauto.c          |  52 --
 board/nxp/mx6sxsabresd/mx6sxsabresd.c              |  78 ---
 board/nxp/p2041rdb/Makefile                        |   1 -
 board/nxp/p2041rdb/README                          | 138 ----
 board/nxp/p2041rdb/README.rst                      | 147 +++++
 board/nxp/p2041rdb/eth.c                           | 210 ------
 board/nxp/p2041rdb/p2041rdb_rcw_sd.cfg             |  11 +
 .../{rcw_p2041rdb.cfg => p2041rdb_rcw_spi.cfg}     |   0
 board/nxp/t102xrdb/Makefile                        |   1 -
 board/nxp/t102xrdb/eth_t102xrdb.c                  | 149 -----
 board/nxp/t102xrdb/t102xrdb.c                      |   1 -
 board/nxp/t102xrdb/t102xrdb.h                      |   1 -
 board/nxp/t104xrdb/Makefile                        |   1 -
 board/nxp/t104xrdb/eth.c                           |  91 ---
 board/nxp/t104xrdb/t104xrdb.h                      |   1 -
 board/nxp/t208xqds/Makefile                        |   2 +-
 board/nxp/t208xqds/eth_t208xqds.c                  | 723 ---------------------
 board/nxp/t208xqds/t208xqds.c                      |   1 -
 board/nxp/t208xqds/t208xqds.h                      |   1 -
 board/nxp/t208xrdb/eth_t208xrdb.c                  |   5 -
 board/nxp/t208xrdb/t208xrdb.c                      |   1 -
 board/nxp/t208xrdb/t208xrdb.h                      |   1 -
 board/nxp/t4rdb/Makefile                           |   1 -
 board/nxp/t4rdb/eth.c                              | 152 -----
 board/nxp/t4rdb/t4240rdb.c                         |   1 -
 board/nxp/t4rdb/t4rdb.h                            |   1 -
 board/traverse/ten64/ten64.c                       |   2 +-
 common/board_r.c                                   |   2 +-
 configs/P2041RDB_NAND_defconfig                    | 117 ----
 configs/P2041RDB_SDCARD_defconfig                  |   6 +-
 configs/P2041RDB_SPIFLASH_defconfig                |   6 +-
 configs/P2041RDB_defconfig                         |   4 +-
 drivers/firmware/scmi/sandbox-scmi_agent.c         |   2 +-
 drivers/spi/fsl_espi.c                             |   6 +-
 include/configs/P2041RDB.h                         |   2 +
 include/configs/lx2160a_common.h                   |   4 +-
 67 files changed, 230 insertions(+), 3329 deletions(-)
 delete mode 100644 arch/powerpc/dts/p2041.dtsi
 create mode 100644 arch/powerpc/dts/p2041rdb-u-boot.dtsi
 delete mode 100644 arch/powerpc/dts/p2041rdb.dts
 delete mode 100644 arch/powerpc/dts/p2041si-post.dtsi
 delete mode 100644 board/nxp/ls1043aqds/eth.c
 delete mode 100644 board/nxp/ls1043ardb/eth.c
 delete mode 100644 board/nxp/ls1046aqds/eth.c
 delete mode 100644 board/nxp/p2041rdb/README
 create mode 100644 board/nxp/p2041rdb/README.rst
 delete mode 100644 board/nxp/p2041rdb/eth.c
 create mode 100644 board/nxp/p2041rdb/p2041rdb_rcw_sd.cfg
 rename board/nxp/p2041rdb/{rcw_p2041rdb.cfg => p2041rdb_rcw_spi.cfg} (100%)
 delete mode 100644 board/nxp/t102xrdb/eth_t102xrdb.c
 delete mode 100644 board/nxp/t104xrdb/eth.c
 delete mode 100644 board/nxp/t208xqds/eth_t208xqds.c
 delete mode 100644 board/nxp/t4rdb/eth.c
 delete mode 100644 configs/P2041RDB_NAND_defconfig
