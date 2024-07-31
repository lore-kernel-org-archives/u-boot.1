Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90129C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 10:20:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06A7588356;
	Wed, 31 Jul 2024 12:20:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="SbE74L0e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69BC3889C9; Wed, 31 Jul 2024 12:20:18 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20728.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::728])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BAAD8811C
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 12:20:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hObiZb/o0LBZMUeDji9lOu3ufknw69h4Ujaw2AB1uM3+/AOJu3okc3RvmLnEPFdL6zclbD6XMa3h7axr5Bda1/4QF49pD+OY+zYRD/skbC8NaUZ1LMt71oySREfM3mpRPXbbE7VMSSGn79dNcgPwVQ1Iw3PVjrAgKvPCnT1GcoioPCs73oVRjZV6Q9YSFGQHpp/65lTldZ+zV6ia33kB5ZrZFgbUGvpZhue0xTyR7iwQ96HRTfmBG0IDHUGeCzohjFo/KdMgIwQJHCjLy3Sj/rx5RCetK2MDSKsHxkWOX8muMR0YX499WEv2X8TkEdPcZ2LcyIvNCSVyxl+kN68IDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gi7HwIhHSyUrccOwaeA3n5QTlrfh+fc6zk1xtNPaFrU=;
 b=fjgbIzg0dis2RDArUIs0QLY/hm5R0cRo9tePS7L7f/Pimawocwb1shrVbgCAD6nNpqHF5gbHkMAjTdHmB4T8iFGYqEQSne31+66w+p4uIit3MuYw7lNJ9UmV+XQ6gEWwmrE6Nb0V2WbRZ9J+0VFzum7RihUYZ9nHeiMxGnDc/gJ1dAjYwrdTx4ZFfC9rrvkA5gfbs32ai/DeC0yPx57vVb0CYQW5V6R8awTih3ff8W86Vx5CEGDCzTSodbp8yJXY0W5l1Clbc5RWZxt1tsRum+Y3Q+sBDB2/oD8gkFe76DhTqXNds8cIsa4FexWsdprEpZI8H/riz7NRWfYEc/ACRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gi7HwIhHSyUrccOwaeA3n5QTlrfh+fc6zk1xtNPaFrU=;
 b=SbE74L0eAY2VczyaMDZwwegq5mdYAqzgEHyGxLxm3nLOsDgQDLupDLs+4QGHQRae3SuS9gil3nM7D6AuWHn7/R90C47yM9lyHVbMr5r2aZcwKCcKI4Hv6XssWAIIudNjAoACAl459U4d+rteieQ1AqatWTA4VRwgyYofjO6NWFllxzZyQeeJs2O+BBOy2964OnnoLVrHFDo6FfHpolTb2S/9m4m0GVC7gjRgetSknlG9J+U2XpML3gi9n39Ts+OFbpuGaiE4nU9ZSmBi+9PVO8VLV+oOcNlwD1hHAPLlXvpigH04dvV2O+jxojnJiglH0qMTXNW2V0lrOW3pyuVv/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI1PR08MB10076.eurprd08.prod.outlook.com (2603:10a6:800:1bd::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 31 Jul
 2024 10:20:12 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 10:20:12 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 William Zhang <william.zhang@broadcom.com>, Simon Glass <sjg@chromium.org>,
 Bruce Suen <bruce_suen@163.com>, Igor Prusov <ivprusov@salutedevices.com>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 00/10] mtd: spinand: initial support of ecc engines
Date: Wed, 31 Jul 2024 14:19:51 +0400
Message-Id: <20240731102001.4030460-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0139.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::31) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI1PR08MB10076:EE_
X-MS-Office365-Filtering-Correlation-Id: 968ba584-08b6-4307-7ec7-08dcb14a5c83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|52116014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QQiEaD4HQYgEYbY87P3KdvPeAyrrx7MuXwl/HY5XtmpvBDDxReBYD7+oztWY?=
 =?us-ascii?Q?jc63NzIlSbC/W19JoEMjmcNW2ronDXf/YxJEKDB6dNk2VvA1kYafSbOQbKJK?=
 =?us-ascii?Q?xQ8QgVFZTNW8OYftqM7Nuwjf+o7KEDcnJ0d+zoVuaXV+Ic0BPbzZc33AFjaU?=
 =?us-ascii?Q?Ex221xDdg44l4Ufqepm7+rMC1MUN3h0rW5SD/N79GeoBcIVvvmpATg9VH4vp?=
 =?us-ascii?Q?2wJNnJrg/DUq57FIzRvHNK1dV/1UEgRkNn5jhOclxZq4nImt/QOFKxlK+i+D?=
 =?us-ascii?Q?aMOwlIISpvgjUETZ1ZKqX/XM1XNPHtguFupTirIM1v+9BISeyr+TRzf9Uld/?=
 =?us-ascii?Q?9ROrIfj22AW/0HIf49kQ8kfPXSP9kMsyDn6cSv23nH2i24Q+i8qlBX1HUJVj?=
 =?us-ascii?Q?0J8045446AhwMpviddZOqR5NHU97NxuOvGY0aISe9CedK4w91YvCiudK7PIk?=
 =?us-ascii?Q?tRKVBKORyzzUaTE0LAUViEjX+J5fVTzUKQx/Ue3rFD2fMAmlStqbcni/wB2W?=
 =?us-ascii?Q?yw2w5uTTuILQM0Bn3U/o9xIwOaPRTeFRa+hvEkcqjQ0/LDj3zD1AsV5Jnzbv?=
 =?us-ascii?Q?PQIe14bZr++PQhZ/1/qI7nwpHr2KK65xr3Hwooi/aUF7TDcCVDVvvakyJ26m?=
 =?us-ascii?Q?zk987mn4P1/q9WGuabto4RLWY8UDk1RwJNg8ik6TWG4ZeAA/G4dUIxWyIcge?=
 =?us-ascii?Q?1PbOwtKox0IeSbKzD+YtRvNbP+1nJtPqcOWYROkkEI5mty1hnViSfh7DtGKu?=
 =?us-ascii?Q?4tm9iMGPo7lQkS23QS2Y/jDgNYQL6GaQckelMH0UW14Kw63rblKiA3V7haHO?=
 =?us-ascii?Q?UB+605GKoP/QE3HmQTxZaRVwzE3rc7snS23s5wmed9LIcVI1maqCTGt03CbD?=
 =?us-ascii?Q?xK3uE3OxhYbPqzZrORKjrV7Q5xxQM4WktDwArCS51ymwy8fl/8xb54KmhoTi?=
 =?us-ascii?Q?9y9qGSk3eyy2jvR4LuhH/pbVNl7AiWJaHQBnJzGbGaFBassus4PcudtrXeEn?=
 =?us-ascii?Q?N5roAYUariTR0hJzPJtNHXKPv3pRP/UPihhUxZquBJ+4iLkw388zeiqe8Wfn?=
 =?us-ascii?Q?aiU9WVf9yAyGfHRjQwca8tNotifaF69pMaCGXoS7JCwY2xMB2G/ODmwHcoiv?=
 =?us-ascii?Q?mxBNaryZ2mrVnPjM6Vk0u8QKvGtZahl381MEgknn0nS3a6E6lFj5k+Gqya4i?=
 =?us-ascii?Q?d8khNZ0YmFo57HTQ7wDtNMGCGN/Wkwo/d5Ky2QOYXSyF+oTrnuJGL/aJmg3I?=
 =?us-ascii?Q?B9NZcEgRHXK4D5lHuZ+ButLQmqt3Bkf3o4KFE8syRHVroue1lVXd1BP8YM72?=
 =?us-ascii?Q?mk30oc+p4XLgPqfl25NImfCD9/JOewwLV3IhrYfhxzJ9qh85PEyBArLUOJi3?=
 =?us-ascii?Q?bfW1c9m33DUdx01iKWlWxW24Kt7K4yJ6uiBYjCDDCZKDtPEcPi7p937vvIx5?=
 =?us-ascii?Q?UUszz637eyE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(52116014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WdtflyVahr6hhjqb6ZpXxzM4/TBSNvDO2q0Blc0cmCaTRd0lpDAEAanuDCJr?=
 =?us-ascii?Q?lgOye366G95KOpO7t6g9t5qVl3DbxrF8d1IDXREfz8QumJrkcLVMHyy48zpD?=
 =?us-ascii?Q?F1ZsgVKAIvesZxU2JX1nETp3Ijz9+DEvtLj4fBjXx5trpJ4fONkUzW+M1EoP?=
 =?us-ascii?Q?3kM8DtTr6lnRtvWfSG+jtG0jpKGhR4a1HP5Z7E4jPBxnDyib6EcjdBjPnJRF?=
 =?us-ascii?Q?giMTyp6WaB01xVWRBn6a+HVO7GRq2JxPswmKrT1Msr0prnZABUSHt7KN8XHX?=
 =?us-ascii?Q?fteD83Oi2V5U95laRbrSNM/eV5kgd8R16naNINJKrCVQbsNFooStgF76Ni6c?=
 =?us-ascii?Q?IDTqaEsiQo5QH/sxvJkytceEKHcod6Mw1dKf2ax7KxiqRMjxCnuICcagUepr?=
 =?us-ascii?Q?/KYxoNv+R7hgSoZNddY6yH/0UhH4zXlcpqvB748+G4SoRY9IWgSH35Izhx46?=
 =?us-ascii?Q?MHq2923CxuzelEhvkdu+XT+YCROZOQRI7imU6QatrKS0M9+oA2c5q3p4XB2w?=
 =?us-ascii?Q?sm1wtbt3Qqzu2spNe+6h4UUt+TXUOns7dsJmXTa1oOgtGcPQmsyEh0Dgu7Yz?=
 =?us-ascii?Q?vpitIKN647NOTO31zpzWU66kP2XKCOA8DqJBATxfyMNVA48jCbUIllogzzXW?=
 =?us-ascii?Q?vao1nKhfIFlLwLd44slVWpU9rvBlTkBFfniRbhqoNr9EmhUbWSVoDnIqYUIJ?=
 =?us-ascii?Q?NMmT13xKkv5I3+lfFeZ/Nw/Fn+4RwyCX4jRafznn13SAoUA5JgqAJMVUwCP1?=
 =?us-ascii?Q?FouOFzz+BxdwD+5S/0a1CG2ifpWZau2ZTmzp830HiozAxgZx/N45uVNz3oSD?=
 =?us-ascii?Q?B+Cs/2UHGXC/J1Nui0Lgjx8y5G5arfiEakenntvMTT6gZ7PeusayHeZnFTQG?=
 =?us-ascii?Q?/wK9v+1mG0rlSfiLepMBKzCr2LQbA505W78sOcztBTYTRdFyRdolw1U2MmJg?=
 =?us-ascii?Q?UscaHDMWJqaGinMyVSHO2oc3vUSXa1oIlIBGFEevBbOtHl/+Pn+pS3BxQopb?=
 =?us-ascii?Q?RFpgLc/eDhWqYsY/4iB9/Yq2Le7jMgIql6RCp0AEN8gYoEyF7rk/j9jdlwpg?=
 =?us-ascii?Q?bf+8VqyOXwTojcZudfMeZK38XN50xiTZP8YuGAurNBFfyLzOYF9p4Sy3yVTo?=
 =?us-ascii?Q?KuybUBkOMutiPVTu1a1988DQ9KQXjwuzi9nxft7xaf0zt9bpmZfwPsnx2G0k?=
 =?us-ascii?Q?xtwle9FAFtttLIl2ONviQkF7lo4sCPI9H9IEFvWG9o2jObszFX6AM4nn4VAI?=
 =?us-ascii?Q?OrVjj96pI7hR6uKONsa0hu6FQjvsXr/EukrHTq9p8XH99WVRC8+uprzn49Ff?=
 =?us-ascii?Q?BRlR3JbnrwM7sLXpGRW3jCncNL9nApxdHz9ah7/KFzNugC5FeEUlC0tidM2B?=
 =?us-ascii?Q?0Cl8Oec4JL93TRsDutzVnFHx5XQdUqoOeZEBHlM5GAH6h2yxIhJ6Cy7N2GZj?=
 =?us-ascii?Q?TPk/zA+6KMxUZIAXJoMFh0wCfUpLtHQe575MOzGMmOue0fzeeCwjCNn3wxeq?=
 =?us-ascii?Q?z7A6q9a8XmBFgZfUPmkGRPYXkYgbquBwlP4SyO4UrZAet34H9OZOZPJ/9Gp7?=
 =?us-ascii?Q?ttsh2tZyiKGyhVkB0YK8/YOixqEyWMhAbjxAUn98ARUWsYGiUC434e57G6jp?=
 =?us-ascii?Q?HQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 968ba584-08b6-4307-7ec7-08dcb14a5c83
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 10:20:12.0160 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJAoXiED9/yavxl0qXfn4+nit3e4jWR/V1g2mq/4omTZZn0cLcqdm3JLcMnMDl3sRXDGhjdjJ6+zy+BQu7KYMDKoGnLnIA3Lqo0zrz5D8Yo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10076
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
2.39.2

