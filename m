Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3459C83F1A
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 11:42:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 199AD8383E;
	Tue, 22 Jul 2025 13:41:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="zSY4FPye";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFDE28383A; Tue, 22 Jul 2025 13:41:57 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB42783242
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 13:41:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGU0srKvo7+DGBs6CXR1Gh3436Rl/fcDtkvCiNWdfFp8S6zTbkgztUAuSY+BG7i5mTDpXObvgbHYXqTP1uNm8OCok1rVIyuHr2BM3NG9lgmYfqS9jj7sv7z9+vtK7r1Aj2KQQR1iz5QRRUYs1uZLSsfByAP9L70WKfiCF+Xc5H2zfnJbxDiJFB46/8yaH89bBNgKe2cNacN82RD2A8dALQDXO3i6D6pyepTky2/3Zlx0uznpZ7TceTpVVEXY5eJ5KVFysa9BXXd/p4msPvG50JzE2hT38enIJRgCfOEmTLV3QC9r2H9zDPaEn+UlNHCF62FwfZIpuxvWwz0URG8r1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0l4B0hfCjepLJdPH6VQjwxqxa86MyW1hGYXIx0jWnw8=;
 b=kRme4wp0awz8D25mVkseqEaw8CNxJ7fE3I4hQrgXpl1952iJ4YV48+D64/VSm/c9+vRT5nNkN9d5xN6qTmBl7aW+CfF1XuEFTW6AbSG6N1mMTXUdAB/zyyuBO+CPW6WhSiXOvG/XuBaOwgzVzmSjv5owgJ8k8qqRpEAVNRGZOw2Wtt1SbpmZOjzqCvgIfriCN+z/dTlCYQoji27zBsUhwD4HdY2d+mG/o00jjcyljr5oltq3EQXZtLzzfhxj4tyjEby40U8dxx4cnTummKAo1N401086YDSm3oOso3RDH943iw4g6O+k76+poECVzB0tpczhsxxBrIypPcsA5Y3HSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0l4B0hfCjepLJdPH6VQjwxqxa86MyW1hGYXIx0jWnw8=;
 b=zSY4FPyelpcw++OaiNuFHDtsiMJAjYUuXYq7cIyF0UEOFL0oW0aRhk7g8vy321zxIY8XWij0QPkwsaNqGGdYfmqBTy/O/u/4bL0d/ZMC9Xo5OUCG/JU02PnoIx35vDtCHNdni05VAcFhhrxaIlSE7jE4aKl6xzXM2FAKxeIH8fFwMVnumxohmTINtokbYRbVLJQ+JMZxhVbj1D+w7bU5T5D4+091uyY1en9dFYChNNLSwsdRoo77OA6eAyro3vpLuxbHjtg07UylBeXNsNVDLMWyjSv41rwgUQPbKwD0QEqBCCywMZ7Be7b8sxOom4W27wr1XeRqjtclk3QoUWVEDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB10351.eurprd08.prod.outlook.com (2603:10a6:20b:579::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Tue, 22 Jul
 2025 11:41:53 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 11:41:52 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 00/19] mtd: spinand: driver improvements
Date: Tue, 22 Jul 2025 14:41:16 +0300
Message-ID: <20250722114135.768998-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB10351:EE_
X-MS-Office365-Filtering-Correlation-Id: c0c0ac5a-29c8-423b-8bfb-08ddc914bffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PxE3OlWFTo+DWttcLsy7NijFnkYYwoKWIWMulqvVZOR70xftOJ0GPCnrpHnf?=
 =?us-ascii?Q?eYk2JuIvrTsHnmK2LdlbwYF1ZiI2DluQDMee1cjZUoEzM+F7dAnfT0WrNA6I?=
 =?us-ascii?Q?wKSx8Cbuj5DmbLIWCLE/7r6hKc//ZCaq5cV1Izda6TzMMqtsXKV84f7WaLak?=
 =?us-ascii?Q?3sTghlRuuXRYSH4kR5sxRxCS4kPOcNit/c5uDMyUowZE/7KolRajRHK9m9Yu?=
 =?us-ascii?Q?aTI8JlMv/QuADUAwvjQBeTFm5FgVx/HDUv/6oRSngUS/4GooNNZHsd0Tjy+j?=
 =?us-ascii?Q?fc2G7xaTSAeXT215rpSS1LsAwXcjIBEfPf5LwSirClBlYNWVd+2BaE8GrFwH?=
 =?us-ascii?Q?3BxURbp65m/OOObiTymMg0FFgMBQ8sYdcAKDLZzX/IBJLNuuuJWa8ic+kBmf?=
 =?us-ascii?Q?Tam6uSIwcjx1OojFNNLUpw9ZKGTFgCTkPtNPpsKJDrqcx5o8kJ7gmXBj3co1?=
 =?us-ascii?Q?GVGAwUlOdV/e7u1HVkh8uhIJxt29RDgLpvfyJo7n0YcB6RzaOm9I71JN2yhv?=
 =?us-ascii?Q?hVkCoYjH+E2R1+CpeSHgI7XJeAk+zrcgBZ3+Lhns3khuXev8QZkdE8HR7nyz?=
 =?us-ascii?Q?G5L6f+0DM0erAQdmB3fPVLiHpETzNGn5O262VO5JyyirU6HMfs5TBqbR3XT1?=
 =?us-ascii?Q?NuBqj+v2PNDAsCOVrZrIyG6x+Dg6R/JgKxmjvqWxqa4MOwAqr+QYl/G+uidA?=
 =?us-ascii?Q?OKqOgnTeJeQqr7sjLT/Sxu18XUWNTp65a4TfyRyPOK62oBDd5KOnzfP5iCSM?=
 =?us-ascii?Q?PMN5Bm+ElMfKtvC+27m6oMQKQj48RatwINuV4f6cF0M6JY33lZDym1+CV8oX?=
 =?us-ascii?Q?IpU/7mMPeBKY005CZHrbHAFEAYeDBxbXx+XhRfhSfaIznaO0mBL4QeG17HHN?=
 =?us-ascii?Q?T11kIXdlmv28QuGcrEC4Vm4gFN3+DsTpZLQfBJSxmJwtTVMp9ISfJbtJ0StU?=
 =?us-ascii?Q?qKMM/jeiG9irsJlYJP4UrLuHDNkm8kyzjaIOoLPyRk94nbQpJqSEutaaTxlN?=
 =?us-ascii?Q?UZW0ELV2Mmwp/CL11qr3nSWGYex49JN5hMJmYYBao4E99PuPX5inIKW5C8ea?=
 =?us-ascii?Q?6HzuDSwzPck4MlfIVE1v2qLxDcsZLQx5OZiiCy250ANjByPtxwXYD/51mLVe?=
 =?us-ascii?Q?AlZc0jDitS9tzJCN86jqXjf+AjRDY35Kt5w1AImsiqf2nwsYljnq3W4fH4qD?=
 =?us-ascii?Q?EFsNA7P92U1JlJWe9dBHgnxq6YAuQaCGzSluvgjBJcRgLUlUpE2oR4xO8Js4?=
 =?us-ascii?Q?N14B96Q80iO5hUpMKov+qQhfdKd7vcD4E49Xswmc024jXs1/1tCc3wrhCRRw?=
 =?us-ascii?Q?iEwh1SGt+9QIflWLKE2ucF43NxacNoyBdXjCdHn3LL3qvOEaG5rUnVBTFhVe?=
 =?us-ascii?Q?0vqigMDGX+JA78f8cb+jjVXV2/akr4w5S+N76aX96SWqtj6FAxVqcqYbu2m+?=
 =?us-ascii?Q?ka10L30AzvJsArgqX+JYNG8WngYLI25HW2ADaP+etkk5wV6a64kgxaN7w/Cy?=
 =?us-ascii?Q?68G00Z7DNfddw0E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1PCH0vNtyh1ziFi/tko6w+y01dkgKL4JnNUbPH2K6KLmTmBifOshtY8aiIqI?=
 =?us-ascii?Q?OG0829bojqQpFOtHQ4t4PGgl/hvj1DTcXlJNrowf2SPUEOTV84Xm/wZ9Q1fp?=
 =?us-ascii?Q?uroAD9G7YOQJjuDrsql30YwLXO92R1m3htcQP++YG6smMqdWZxzcOuOIGWSo?=
 =?us-ascii?Q?4e0k4ks4xm2GTgDeNN0id65B3Z1+y2tot1id6U2k56hx1065yA1QWGBu+zwQ?=
 =?us-ascii?Q?IkOzW+BeqjL9jTnEjZYBnyGXLRkUMBnH6VxglhxbPPIECed8Ws6+2BPnl45r?=
 =?us-ascii?Q?aGlleYOKh9jVdzibz46FxxKWA2W/OGWk0VloywIdcbZU6CsgnCyafF7Qh60g?=
 =?us-ascii?Q?ZnDWHVhSYKuBX1kKgn2HXiVuEZpg2/iAeiFocswuWVoQzZz0Mqz1tsaMfrKM?=
 =?us-ascii?Q?0RvGCiNO7amk6CO88Y2NbaR6vFbcrmHGawXgRk3G6VsPNxJL0R/XmXyvDn+c?=
 =?us-ascii?Q?wV8Wo5d7EWfv5FoEaZVaz2yWOkvoTPB8qehHvSLRVGvec3rh+ZQW110F17WB?=
 =?us-ascii?Q?cCJybguBEQrIwNM3kLBTkD0raqsxFT07Xc2RBD1XHzfCI7LezsBFYXv0Ywd2?=
 =?us-ascii?Q?x5MNqOga0t0rRU12sXESmkJ3aIwVaYTZzeyrqB0+GLE2wIVvLrNG//qrJ2aP?=
 =?us-ascii?Q?Si3t8eOHCFxdZgPRcKw5b0JJG4PYOcL7+qXeCJooyKXJH/L7iLrif5tXWEsD?=
 =?us-ascii?Q?UNgniz0S9bF3/6Xw3dnJ97n9G+ykKXN7cq/FFuJlXuyQAUXOMPKs7Gf003Vr?=
 =?us-ascii?Q?IW+A5M/2QVb8AGSB49DN2OPAmeKV2kg8KniRH42PnabZSFY8op4mXSbsK7fP?=
 =?us-ascii?Q?mIdVJFtOcnv8Hx2JDqEjQ6Q1R+qnqVtqt7KPsjIsc45lJ2/a82KU8ppviE9R?=
 =?us-ascii?Q?Nc8KoIvjLsXFhfn7cs2vTy3PxQkDnqVXZ94oumL1dtJ/O0S8uhStbY0VdZAr?=
 =?us-ascii?Q?KOjt7G7hAyFLIv6i+yU+6Cr+wGzr2mz5HzEyK1fCB7dzyG1jsj/3eZMmMTYJ?=
 =?us-ascii?Q?+n8Uq50W1rSjI9S37kLUYMGB8j0G0hu53e9dVEJzcS6Iuilqci3lsSivHM00?=
 =?us-ascii?Q?Me1VmOMknjpNbFhynLEdBhHEOhMlJ0HN3kC4OteEknZVSLk7pdXf2jULbr+n?=
 =?us-ascii?Q?sWpT+uJvY21pzzGMn+yE+J3OcG+uP1NR+WSjn25ZuHXXbsFOgzRmZtzSt4iB?=
 =?us-ascii?Q?s6OGk4BeFrTG1qwUqcdbCKgFXgSlCqfozh15YthnpwPoFo7NM+/AkXyD7KIl?=
 =?us-ascii?Q?p4RVzTm1PEwbPfqXL7Zx/zxfCSUX1NBNnB5SPH5VzQIEY4fNs6wq00mn3AQ4?=
 =?us-ascii?Q?wRofuNsJmXOWx7YaRKvhSgzMc0ZVu1K1aeqXmJHJKyl0pKytUMkLOEXCo2pq?=
 =?us-ascii?Q?Cj4NWSo899me9zAO+TWVr6QOv80FJTNLshseoMbmygaaOPMfB1+DogFVptXB?=
 =?us-ascii?Q?2YFJ2z0x1o5eedd38JPjcGKs2Y61kw4pFotOFVpgObm6+PusihF0VI93xDQp?=
 =?us-ascii?Q?jajZyQvHKTAe5Y4R63bRO0N9fapuwh7qlL8yKZhoQcN2djk5fINR7lK6AXJ1?=
 =?us-ascii?Q?E0Pl0akpI9XNGvux4SJ+mXPsv4yQFg/QoVymcAcLewSN8yth7wW7z2hXerhC?=
 =?us-ascii?Q?lhW8m9IZ9mUiK9Jy5sVLfGk=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c0ac5a-29c8-423b-8bfb-08ddc914bffe
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 11:41:52.0384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZlNrsiy6r4YCuXw9rlbCRLMa1KAb/XgRkx4vYOqnC17W8OD8lG1X829R+rABJSd9PKykqgLPxqEayJXMundD/TQomSSekfqlLazKVkjhzVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10351
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

This patch series makes u-boot spinand driver almost the same as spinand
driver from linux-6.16-rc6. This provides the following improvements:

* it becomes easy to port changes from linux kernel
* more flash is supported
* spi drivers can accelerate flash reading/writing using spi-mem dirmap API
* continuous reading mode was supported
* OTP support was added
* add support of special data recovery reading (for some flashes)
* bugfixes
* other minor improvements

The following linux kernel driver features was not implemented

* support of different ECC engines
* per operation spi bus frequency

Mikhail Kshevetskiy (19):
  drivers: spi-mem: sync a bit with linux-6.16-rc6
  mtd: spinand: Use the spi-mem dirmap API
  mtd: spinand: Add a NAND page I/O request type
  mtd: spinand: add missed add missed MODULE_DEVICE_TABLE()
  mtd: spinand: simulate behavior of linux's function spinand_wait()
  mtd: spinand: more use of spinand_to_{something} helpers
  mtd: spinand: replace enable_ecc variable with disable_ecc and update
    corresponding logic
  mtd: spinand: minor refactoring
  mtd: spinand: more refactoring
  mtd: spinand: sync code with linux-6.10
  mtd: spinand: set bitflip_threshold to 75% of ECC strength
  mtd: spinand: Add support for setting plane select bits
  mtd: spinand: Remove write_enable_op() in markbad()
  mtd: spinand: Introduce a way to avoid raw access
  mtd: spinand: add support of continuous reading mode
  mtd: spinand: Add read retry support
  mtd: spinand: add OTP support
  mtd: spinand: Enhance the logic when picking a variant
  mtd: spinand: sync with linux-6.16-rc6

 drivers/mtd/nand/spi/Makefile         |   5 +-
 drivers/mtd/nand/spi/alliancememory.c | 155 +++++
 drivers/mtd/nand/spi/ato.c            |  84 +++
 drivers/mtd/nand/spi/core.c           | 906 ++++++++++++++++++--------
 drivers/mtd/nand/spi/esmt.c           | 123 +++-
 drivers/mtd/nand/spi/foresee.c        | 107 +++
 drivers/mtd/nand/spi/gigadevice.c     |  66 +-
 drivers/mtd/nand/spi/macronix.c       | 289 ++++++--
 drivers/mtd/nand/spi/micron.c         | 180 ++++-
 drivers/mtd/nand/spi/otp.c            | 369 +++++++++++
 drivers/mtd/nand/spi/paragon.c        |  20 +-
 drivers/mtd/nand/spi/skyhigh.c        | 149 +++++
 drivers/mtd/nand/spi/toshiba.c        |  63 +-
 drivers/mtd/nand/spi/winbond.c        | 228 ++++++-
 drivers/mtd/nand/spi/xtx.c            |  20 +-
 drivers/spi/spi-mem.c                 |  45 +-
 include/linux/mtd/nand.h              | 157 ++++-
 include/linux/mtd/spinand.h           | 342 ++++++++--
 include/spi-mem.h                     |  93 ++-
 19 files changed, 2905 insertions(+), 496 deletions(-)
 create mode 100644 drivers/mtd/nand/spi/alliancememory.c
 create mode 100644 drivers/mtd/nand/spi/ato.c
 create mode 100644 drivers/mtd/nand/spi/foresee.c
 create mode 100644 drivers/mtd/nand/spi/otp.c
 create mode 100644 drivers/mtd/nand/spi/skyhigh.c

-- 
2.47.2

