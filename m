Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63492CF3180
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 20:45:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91DA0892B1;
	Tue,  1 Oct 2024 22:44:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="oA0UkwUO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73457892B1; Tue,  1 Oct 2024 22:44:57 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20709.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::709])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EFB789221
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 22:44:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJweKVffO0A5rrQynplXLVdOiOaE0QCfEkczTr18g9OAoKnPlXz1NaFuEWeMadmLfhj+T3aS6W8Pp+JnJfwUC+v1FBXPzq4fYbo6FnsQCT4RRamplx4Ei9uBO47gZO8VX+KZvCsoeQKKmSeBZU8ITx1vaV15QcdicNJbwhapaVkzW5MvAW83R1WDcbu3GI/+f318jVeaG5sPV54FoOkaNaIp0JSni2JrKzZnThG9EaAw0TR+kSYcypM2OnVRzneCcovRa2FUXl0FZuFpVrXiCFJkxHpv1neSofQjy+/mxx4yNmqHDJ7BL1DHYO3y5cZHzSR332MMrDjdd3v4RkST9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jj6E/v54tZ2Ut0ezoDoDGevkXa1Q2vnNrPqWovpVS34=;
 b=oXGhG4J2qML0Dp78ous5R5Zg+9ZX/ySAdRa8ir817O7AdaG2OoDxHTkn7p3BLarBuMy6bS/pEzCh6PdpAL9iH5mnEA8oqY8cw3F+LjuHAmUKO10A9RBYdm8kJUl4Q60ea+qZ5mkfhATDMauZl/hgflCsj5Ngxry5NvwD4qH4jgOPTxF3uxSAtb9DN3wJIyiY9TtNUWIBTM89eznnGInZgxechmAGbbfCYmgcxMm7tgHIlnBzjc1SNlABaPtROEK8NB7prLos7jLhdrByzeO5BP87JGTnrPtxGgVlrJnWAaRgqVo1vkjvuVvnqtaXLi5ty6xNSopo4FuzRVVYJxeJ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jj6E/v54tZ2Ut0ezoDoDGevkXa1Q2vnNrPqWovpVS34=;
 b=oA0UkwUOkXYIsULKY3l7qOvFBzqhZs5tVfRNr3pNSn9iNGTDI4mc3DRrPdjWMRfEufLjZ+AHumKWJgFog1tn23myA31SelMS6QV/+cbhzNjnJRiM/cahYX1OKiFeIOw37ue+0pKLfbAHI+oZT+WyHQ4QN8NNxaXvuca3J99SJ55dDCj673uhjCFIc/IgZQnfkB52i4SSstqZxUne167F2gAghaIKB46FQX0BvRuL/ikyRv+806fI4fF91PrDGoM4FPDRgQ+NC99NRx7yTSXTqzbPCUU7EOU+gRkNm6nHJTmTuYBiSR3FrbYIW4cD+xQvIGCp01gnuem1Mq5gaC9M0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB6539.eurprd08.prod.outlook.com (2603:10a6:10:23f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 20:44:52 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 20:44:52 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 William Zhang <william.zhang@broadcom.com>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Igor Prusov <ivprusov@salutedevices.com>, Bruce Suen <bruce_suen@163.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
Subject: [RESEND PATCH v4 00/10] mtd: spinand: initial support of ecc engines
Date: Tue,  1 Oct 2024 23:44:32 +0300
Message-ID: <20241001204444.917238-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00011B5E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:8:0:16) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB6539:EE_
X-MS-Office365-Filtering-Correlation-Id: 9514cb27-d9fb-4a1b-dfcb-08dce259e5f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|52116014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Xl011I1ugUhb3mQV59Obg6oq7ohzO7nIBqi/ymRNRuqxc+MOB1ounDuPQGUd?=
 =?us-ascii?Q?Iydq0wIoxKTpJgqXG9zBo9jVDpmCKa8raQnBjktB15IEyq9PP17F1YtM4cnp?=
 =?us-ascii?Q?VVEnTnMCWERuAcQuSGjxikgDgtG1IyMWnMR4PezujyL+fLFNioKEF/8X1Rr/?=
 =?us-ascii?Q?L71IbHuVcbaJ698Mr4pa9BIeeG3HmP3vYn1Df1jirvddwuvG01zlJnPJbQfk?=
 =?us-ascii?Q?xHTCaLIS420+BJkjJ836Pj/YqmqHsQ3LlQRVLB/phkCQBQ/yZwKU1BlEJ3qG?=
 =?us-ascii?Q?1E03dBjL/g62bsUNfxjfcZIcWbw6AEMZlwKjn+5CTDn9SP7EEBxg6a3q5fER?=
 =?us-ascii?Q?pC1UqHuyXw+xnGZFpPizup5zQlMWPvwKEUq44nDQxhaQA6/n6UqeLMWAdMVa?=
 =?us-ascii?Q?wWbNe4qIIJYk02/JdnRCNhspXZ7SiGwHtDCnhFw8VzSA1o/roAZUVw+Qa6Dq?=
 =?us-ascii?Q?ImtF+byGjVkbzSghMqRTDd+tdO0tBDTufOD0LPwcY2HMkUIwmiNlz52mYH9R?=
 =?us-ascii?Q?CNTCqOqOQMSuSmeRDISrAsJfkGV2ZVXZVrAzXe1dPLmv2Ccs2ZQ0IL7Aof0A?=
 =?us-ascii?Q?jyMS0GuKT43xjGRx7frivFl+SJL9kixhz0Ms42u/X6By0LdgVIjhKXNkWHHn?=
 =?us-ascii?Q?6qMXGLICEwBwhraOk2ME4qOcsylNi4wfb+eK94SgvHRp9HdqyH17LkbtypCR?=
 =?us-ascii?Q?DYDilQkh1JEqvDX9Putth7ZRH0isnFVJcMmLGo5hu0HXB+F68sVohfR+srzn?=
 =?us-ascii?Q?XSaVDygDSbVv13plAKncNHsGkcwBko695dCOkb6sO8thjTyD76F3q0ucBqvS?=
 =?us-ascii?Q?JOtmCfcYGtk1Ry701gEgf4wyj05glSYw26ZCypKV+mUcrwZR5ZvTzSMbGeCz?=
 =?us-ascii?Q?iWyzRvlfcm3pfmUcmy++XBgVR4mObXxkgE0GeTKYIirGcXj9XoCE3WLAArR5?=
 =?us-ascii?Q?rf0cqk8WP1FvQ0L0/mGRKybGv2oLHAjEJsmQqYQA+hVJOKwJ5di8u9MdMT/C?=
 =?us-ascii?Q?wyxEX+mP+tbYQGOaa9wjFyh7+/A/cafYkrVncDk944Dawueyv91NtoJ/U/Wo?=
 =?us-ascii?Q?8yQzSD/VKaS+7fzrP9/CF+o+BK1hlT2GjhFUjVi4wQvWgdpFTFyjLXrzIUPW?=
 =?us-ascii?Q?pce9g2TssyjsaHo/uh6/t82hXXUKMW183EBHbvyGcRsIick0DCnBKc6XDqzW?=
 =?us-ascii?Q?5Agu0qlec1pcKkGxAOmMhD0nKkQVjgthyaxeW7CHkO7/YRRfzYmunW7aBviL?=
 =?us-ascii?Q?nr5fV/Tki6J7dfJW+XxSrzoymPEW4LR1NIp9sPeH73LtD65HGpfY162vepRe?=
 =?us-ascii?Q?+yRnRJadZ5NpHB3IspuQ2mZvucNbA1ryh5orTgC4p4XoDQxinMZxSZXpmmNf?=
 =?us-ascii?Q?0DsRTC8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(52116014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UaAPYEOncdlp392YDe+wEGOuH/skA0OMhQ0MTDpusJZl4DZR7S8zCG2273Fe?=
 =?us-ascii?Q?M8bISc3gFpwb0o9Gk20XcTbqzqbNtJPdV+aw7eeBRDlnPArvhEfzrb7d1Kpz?=
 =?us-ascii?Q?hvdgaZAT2nCLZ7dMgUASHVaOv2aSenglqfnPTddtmr9Ddv2vClUBAEYi1pXo?=
 =?us-ascii?Q?Jg6UrQjnokRAWHFCV8FlOUbu/VFkxWKGX82dRGPfRQ8Ms9A2x/KfqioZgJow?=
 =?us-ascii?Q?M8I+RR2sFC+2JHVK2HZfqsu3V2in3Q5rD0v4RIjvLdye8wyhN4/bTCPPe3kW?=
 =?us-ascii?Q?KB7HZkbTFzDg1nUrHGiwCe3yY1KUNGDqAOoywqZ5soiKjJ+gz4HIVVpr+rle?=
 =?us-ascii?Q?Ifkl0QbQ6mH/txrRgDxNNeoxaZLogQv/2FO0+pXPu2mC1pPlTObjOvJIM4mI?=
 =?us-ascii?Q?nuYyW5qbAA20v9ut6yWV28LHI+XOAxEhkqpQQb8GTXJfwBag/nofEhzefsF5?=
 =?us-ascii?Q?fmhpQ5hkFYH9ri0I+szI7YbqouS5O7Km9KMo616QBQIwTfVmcl/5H0+qq+5P?=
 =?us-ascii?Q?LLcGXobAiqhwdZOB1tO9ukB/vwRH6HPmv24WZCs+iGwPsUo+6YluyeXGp37v?=
 =?us-ascii?Q?XETP6+ALu6ON0Mdtzdhgujtu9tlrgFH4VV3Vp/xyVKcu27XwKH5U0eHblko6?=
 =?us-ascii?Q?E660IJu6ecn02OWQtF93dZttBqKmd7ZIGKfjGbOMb3dJLLPVStb6eGaKO1ax?=
 =?us-ascii?Q?D0/EoxJNn0SB503tpK8lZ6VzXwW0wDqlRC4oFL6r0de6u4SXHAV6Jvo37Ajl?=
 =?us-ascii?Q?chsLSP8G9THlakIaIIoTTCLlLEO0ZfuLB27PRR1ChG7PxnctqQOISsG5zrem?=
 =?us-ascii?Q?Q2HSzQn9la6DINa3zjZlItIfhpqoetWgMuDgPphv3EPNWl4JrDKbwwOUwR0T?=
 =?us-ascii?Q?HywiY3Acc4QM4vl1N/h0bE3X3ZUPjYYQCDTGENC3WuvM17hSYKlsshH8qlIi?=
 =?us-ascii?Q?LilfOAt3femlIQCB35FTJeGrv2s+YQTHndqWV3sbVjGBfLI/exogsfoB0usq?=
 =?us-ascii?Q?Df8qg+V1moJSq7Shl+B3k0CKOE84pD5FZ1/0iFRWqT9J3VWPZkTtslGKu7If?=
 =?us-ascii?Q?GlNr/zMBNRPZ91yGQDkouMCHQ6P6B8BK7oaQhaaPj5oVrPFtE/yn++RXQoC8?=
 =?us-ascii?Q?H39n3dKcHEVVLwuHRD16YEvs/TWH8/Zillae4opO9vbOVDoaUjYkL8izduQ1?=
 =?us-ascii?Q?bFGwRogq6zClL17uWZcjaz7QbOytO6EzoT/4wdK/ZVZq0m7yb7AefUOjdwBr?=
 =?us-ascii?Q?G/VSqBORpK7+enLRoghP7UaFfnSYRXHwmKvxg2J8RbrDmt0aIjR50XIBoeoW?=
 =?us-ascii?Q?oxCQ3IwK2xpcrS0LwcdZWpI3+nbmmtM2nP+PaO0Wj/GFcEamkY/m41Z1I0UA?=
 =?us-ascii?Q?pf3CQtNM8Lx0TutzlxwFz+DA7tvN6eTWeTmY5+Q8fbDq1jm6HaK/E0QixI18?=
 =?us-ascii?Q?KDaisGLChGx/MpZJ3gtslB9DQwQLMLR6bAI2ue9XqT1MJ2JQbU0LOdahg6NS?=
 =?us-ascii?Q?JS7XwUGM4NfS2xGKI5AI+7ARbri0gX9ljNkkRdTbY8+hfvl63pValgKHWFAO?=
 =?us-ascii?Q?dP1WirU60HwkF70V5a1Y9TRdnmL2oVl6m7sXtScVdbW18u9Xng06vP7XhMvJ?=
 =?us-ascii?Q?5zxZPgCfmtfO+UKfbm/UOCE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9514cb27-d9fb-4a1b-dfcb-08dce259e5f2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 20:44:52.0239 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y5aTQpWr8Iy5o6OZHOd7kAdokPIDuaJaDe1JRfiHS39UqqRW5WI0EpPUNohRGcKR6sg11MmBnoTz2f/07YBODbwdt6JTamzF5EDcEG7PsQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6539
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

This patch series:
 * sync spinand driver code with linux-6.10
 * sync spinand flash support with linux-6.10
 * add initial support of ecc engines

Up to now only software ecc is supported, but other engines can be add quite easily

Changes v2
 * update description of some patches

Changes v3:
 * split some patches to a smaller one for more easy checking/verification
 * sync spinand flash support with linux-6.10
 * add some ecc engine comments (taken from linux driver)
 * slightly change patch order

Changes v4:
 * avoid double increments of error counters

Mikhail Kshevetskiy (10):
  mtd: spinand: Use the spi-mem dirmap API
  mtd: spinand: Add a NAND page I/O request type
  mtd: spinand: add missed add missed MODULE_DEVICE_TABLE()
  mtd: spinand: simulate behavior of linux's function spinand_wait()
  mtd: spinand: more use of spinand_to_{something} helpers
  mtd: spinand: replace enable_ecc variable with disable_ecc and update
    corresponding logic
  mtd: spinand: minor refactoring
  mtd: spinand: more refactoring
  mtd: spinand: sync supported flashes with linux-6.10
  mtd: nand: add initial ecc engine support

 drivers/mtd/nand/Makefile             |   2 +-
 drivers/mtd/nand/core.c               | 130 +++++-
 drivers/mtd/nand/ecc.c                | 249 ++++++++++
 drivers/mtd/nand/spi/Makefile         |   4 +-
 drivers/mtd/nand/spi/alliancememory.c | 155 ++++++
 drivers/mtd/nand/spi/ato.c            |  84 ++++
 drivers/mtd/nand/spi/core.c           | 649 ++++++++++++++++----------
 drivers/mtd/nand/spi/esmt.c           |  16 +-
 drivers/mtd/nand/spi/foresee.c        |  97 ++++
 drivers/mtd/nand/spi/gigadevice.c     | 194 +++++++-
 drivers/mtd/nand/spi/macronix.c       |  32 +-
 drivers/mtd/nand/spi/micron.c         |   2 +-
 drivers/mtd/nand/spi/toshiba.c        |  43 +-
 drivers/mtd/nand/spi/winbond.c        |  67 ++-
 include/linux/mtd/nand.h              | 279 ++++++++++-
 include/linux/mtd/spinand.h           |  47 +-
 include/spi-mem.h                     |   2 +
 17 files changed, 1778 insertions(+), 274 deletions(-)
 create mode 100644 drivers/mtd/nand/ecc.c
 create mode 100644 drivers/mtd/nand/spi/alliancememory.c
 create mode 100644 drivers/mtd/nand/spi/ato.c
 create mode 100644 drivers/mtd/nand/spi/foresee.c

-- 
2.45.2

