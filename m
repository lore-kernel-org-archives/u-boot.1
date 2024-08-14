Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 838FFC52D7B
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 10:19:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDC008895B;
	Wed, 14 Aug 2024 12:19:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="LCGJ5s+1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 120978899D; Wed, 14 Aug 2024 12:19:35 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2072e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::72e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2455F888CC
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 12:19:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kT2R07/ENjLnHzECAvwFblLEjVw8CZgL/9aMH8MAIWLOrqzy3/acdmFafAp8mTc+6ULj2sAhJH/66i64gohe4NZlMyJ+mMfoNMV6273ql3BgxTAlhtNdOTNk3Qdel0J1qryN7Ocv4GaWkVx2zFspZ//LLm+ZNGXjM5E/1ZmAG2A8Ud+8rJi4EcWTaYSgQ/xC4vwF3jsw5w8sW7Rd9LZNvWPLA/wHu0TdKS1rO9NBSXBtMRCrB/Ic43fjEvZEk8wlMa5YZ99kGxQgYpoiQ8tMS+bteZcF/u1i5p4K90GK4ZdxzvJw9HnJVfQ14E6w82rLBYOOcmW6r8V4iG2EIUEjqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gi7HwIhHSyUrccOwaeA3n5QTlrfh+fc6zk1xtNPaFrU=;
 b=TETGn1txcLHFfYex/VCJ/meprRVj3esdLfiTVgi71xhpEHxliRt6i/FjGdU+ZmE4N34OCD6ifOU+8evv/G7hertrU4OuHJNFyEq0QUAuBoAoP7Dd4EimWzd9on1eDeMUqwoLcYoW6EssSuh9teWTd1AtLnM1PFCdl6KXIL6E+qjaM4fura3fYxwvIrxCoq1PdUdj8DMTn3q4HrwuMNk+oscCW6D0zHSYXgvtXbsSVYpdUg4lg2z0/Z48LyenUfCwlK7+5aKoCPG8XK3Eq4NqCAXOvYLpz7r/qff6XHq3GFwgyImEv/FK0aRQX3uXds3hb/G6kc1eYjiT2XUCQpi/BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gi7HwIhHSyUrccOwaeA3n5QTlrfh+fc6zk1xtNPaFrU=;
 b=LCGJ5s+17VtbdWn2CeDKHh//a5S3OTWktqcfbs5mRLBEXMwX7y475p3KkVWOIJ1qoRZBRin7pXDg7PLqoEQ2RYboJV/jKKOlL0jtRk1AgXUXnfX3ozBTOg4pzDWjvLXgTPeszG/oWznKaIUvAvNWxV0uTM3thhO3ymXZXUPqeW8nN30+agWj6iFiS4Yb0DldZsPY3GyF0AZrtlmzpMhluwYi6L0piFLlUjNtVQW8BqbrEtq5Sd2vm1QBklF9cKwh7k9tuRf2Yn108iyXfMx/9+4wE7TvkFXP+CXRu6QnEmLOp58aU+puMewGITPLO86NYKiK78lZIEJ9o3OxZqXsQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB9104.eurprd08.prod.outlook.com (2603:10a6:20b:5fe::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.15; Wed, 14 Aug
 2024 10:19:30 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7875.012; Wed, 14 Aug 2024
 10:19:30 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 William Zhang <william.zhang@broadcom.com>, Simon Glass <sjg@chromium.org>,
 Chuanhong Guo <gch981213@gmail.com>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Igor Prusov <ivprusov@salutedevices.com>, Bruce Suen <bruce_suen@163.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [RESEND PATCH v4 00/10] mtd: spinand: initial support of ecc engines
Date: Wed, 14 Aug 2024 14:19:08 +0400
Message-Id: <20240814101918.1347167-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0401.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::10) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB9104:EE_
X-MS-Office365-Filtering-Correlation-Id: 78f2938c-d7d8-4910-914e-08dcbc4a95bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HISnUuIw9yThvie/wxLaLzYyMQPFZHLY1yvimoAbjAIJP05cfxi2JZi+S7yz?=
 =?us-ascii?Q?1LEJ8IXsjWkppgcU1//GEmVgXKir8tX4r20orJ7e2nDeENx6xFDbMwZfFOgr?=
 =?us-ascii?Q?KGeDa073mPPn+mfA4gmlPq3EPwaffMWeNRsyeolvbGOv8g8FdVz5DKsegDZF?=
 =?us-ascii?Q?p2KgMZCVL9cuFqHc6lsuLPDxy2bgDVW4gIXhFzlVtfmrlgbPoU03ZvHGXd9Q?=
 =?us-ascii?Q?gFjRJRQetF1/L5QLc8UMHhwSr6vFDDt8xYbcCeOl3J2FMYsMQHQwPy/3Sax6?=
 =?us-ascii?Q?vBuR5hzTip3JPpOmuiFv166tDMOQouaGijCW8AMWSnD9iylLcp6WgOtVg9Yo?=
 =?us-ascii?Q?WqK4uLfQBygZ870/K6ExjVV7/dUvtVmSTvcJWxS2E9qMCBxNDR493dKusKEF?=
 =?us-ascii?Q?V3gE9b9fALhTRFULlrp3l9x5q9C/iA3Dx1wFppu0y39Q7JnZ9yRcb/XUfFEr?=
 =?us-ascii?Q?1naNcaxGtNR2JiNthQJI38qaZ1ofVgSIre6ZZPJAaPHXMU9ZXv67I5qsRQrp?=
 =?us-ascii?Q?lj4wI5jEihA4V5Avf2TG7nkHXEXb82AKkFqjgtswIuRtm5wzJrK8LIdmqFES?=
 =?us-ascii?Q?m5NdrxLrDsTxy0f3kK2obtEC9GTAvfUljTJAc46TW1noOpLvxHLY7IbmFkgF?=
 =?us-ascii?Q?Dp9c/+w1WEK3ObIyezCcGX4A9dOronY0C2fQzIcu2pCMqVkPyDFRPBH/Trff?=
 =?us-ascii?Q?TPnW5NGlxcBBLtl0qZ6rhO/2kTog8h/YmNJs4/qrlA6955MsK5pCp3ul2zoC?=
 =?us-ascii?Q?p7nC4RdG3BDGvOYXDkaiG+8Ie99/HtnfK5lPpHeMMcrKKVan79FHFTbqhwhH?=
 =?us-ascii?Q?7fACVbT/0DE1sIz4atjK9PffidCkndHeGtkIthx/aMG/v+fa1ZVM8Jtjk/Uo?=
 =?us-ascii?Q?Njj+ZZjxNfY620CxC4934fMxhKgG/I58afXdFoERMVXupipFuAelNDs9ehPV?=
 =?us-ascii?Q?+4Xnf4lAHz8GvutW+YOrP+thU10xbWeVpGVakzCaywbg7LvZ/r12he6zePvP?=
 =?us-ascii?Q?aQhlyV6bzfhv5J3WwjORTqDqIJqsXKWVlNoASqovJ5qmFLIHWsRDKJlB8dja?=
 =?us-ascii?Q?ooJzig6i0hhIFWqd8/aVLPhQmtJvy8wv1k0KYf3IIEuS227s7RsObh9xYPY9?=
 =?us-ascii?Q?BZ6mdEOQ8m5s5Jt7og9vAXcYob7ZERRoQqfpVFU2SEilzgwFaeyL0ZYOsPep?=
 =?us-ascii?Q?MPRL9eAn+EoMozQWCjNpfeAwKMYybE1vyh4temdglxb68PGrBLZlTQyQG/wD?=
 =?us-ascii?Q?476PRVrQ0VBxlTLwWZiTUc7hPuBStp6j3NdoJMW7w+zYe6D02SlxZfTNxRm6?=
 =?us-ascii?Q?va+w+JoV/QxDnvEW9woqef0e22yB+Tkzqsczf9DqO4Z9JG8pcPyP3vzu/qY+?=
 =?us-ascii?Q?VaFcd+h52zvxaXgXPzFuQHmF4aSNcZRGWHNEEUcQ3Qher43X3Ah65seWhYIS?=
 =?us-ascii?Q?fKKBBTbR3iw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nZ6M8D0lHQedxw2ZDikt1rXdi/0KXnge1wRnQauk9NfRvk+vLnpjBXOdt246?=
 =?us-ascii?Q?QGkcHAoZUlCXWf7OpDKYYNUk4hQFu3xfOoaIfeBqISs/GLW9jJmTucjTpmh1?=
 =?us-ascii?Q?UTOkI0h21bNQvdmt/V1pfZr6PyVfwUuTVxRjRllkfqCJe5jxb+m6WzMOEi97?=
 =?us-ascii?Q?drExtz8tg1o2yCkR/IXymuhZM4eoY68UpROeqU1SsPO4fZUUaRm2EQ8zBWVV?=
 =?us-ascii?Q?upVNvY8Bh4P+jI9gaE9pbrXjdSA6OjG2HTilIAUWkk7BfqFee5VVKqyw5tsN?=
 =?us-ascii?Q?ftG1mmHXr8j2f5Gbje75rfChchXCEqd3SFqUeQZS69ACE7eo11SuQTpXXhVT?=
 =?us-ascii?Q?DDgEyasoD541Qn9DRY2JabWnWaXExoRuniygeeHaROu6KrfsEXSj14l2SQSP?=
 =?us-ascii?Q?Afp8H/80lnyPSsjvap36xw9jrT2U/zYXUwy6cOctKDt4ANDGUJRRJjUTPf6R?=
 =?us-ascii?Q?h3xZK9DltAYHYgEV3ya50sQzNT2Q3Q+C6uMbcXwjgEjsEsBRs9J/enPpJT+H?=
 =?us-ascii?Q?tEXm5FPceenSB3rrrj3JV4ARRSX/rgPgJxp1eM7VM2rt2kOiN2CuchVeCYHn?=
 =?us-ascii?Q?tu98+SCzNljKx7sf8CqN8Z5Hj3nz2C10lj47UVEuJqQgGUwQzVdcaTSeQyG0?=
 =?us-ascii?Q?5vY4+5mGDTvI+FRESrRpx0MunKXhjeNmMZ0j4hYhIPp8R/EdFG7I8AowExrL?=
 =?us-ascii?Q?pJ6E1roYzlzSJJNMwGFzG64Zn+DzLFkrRo0aATyluZrXe6J2QJLadHZLU5NG?=
 =?us-ascii?Q?7SC3+gBH7YGK98Nzjf8pNDvGdtKWC6EhPEw2766mUi2nbC3rtEAdd9xs2YJk?=
 =?us-ascii?Q?zc/bvANVWiu8TBo/DbFwtlx+OK6dT9vEIrMoREarl/bClaDTsyLJ1FoSF5h9?=
 =?us-ascii?Q?TFAWlt/YjrsCR3jSJIdHKt4OZcANH3pTfcbKR1nSwAJraca4uyw/RUkFbzyK?=
 =?us-ascii?Q?+f/2UiheoyHQO1WFYdJS/Q8GTpSXSHJLI3B7wQK+ExqmltZ7cxvAbr4VDGow?=
 =?us-ascii?Q?fWGdMqubt64tQwdsuOn4Thoqft5KNHDy/AmhPBvE5UJMrEefnSqz0Tu1zddO?=
 =?us-ascii?Q?yNBNKqhzoxo6+1w3WvUIohzoQQ3MV8WwLlfCHGmD2EPie/yoEmrMYY+6w6qJ?=
 =?us-ascii?Q?PZ6nOhTjhy2HIUjOdp/h/uMG8vWlGIJZk6RM0xXih8wxRBjYzPea9qk4mgyx?=
 =?us-ascii?Q?giDgxOaFv8d9PYtmEfUS5MASQYH4B461PBeRYZLEeTCOE358Ur5aEud0djvC?=
 =?us-ascii?Q?e8phZjUpC3WlvOHWC9UNFxyGajXqJWRh/r8erz+qZGc6g0NP11G295OpmIn9?=
 =?us-ascii?Q?aRlbaSXjaPfLU9Q8U2elcGlGBMDYwsXyq0ry7eeiN8Uv0zl3YmQtpdJWfCeN?=
 =?us-ascii?Q?ljvGRhh+PJdIUYFFMMnXCuc4K5baiYy6TTtXe/LfDiU6tSROmh9lahrtQ3sX?=
 =?us-ascii?Q?yBERtTxwKizsGN/3zjG7VXIBhT7jCUV3p8P1M4GX4ohAXqV68C5My4vxmWAw?=
 =?us-ascii?Q?hgTUWp1/yLAbJD/z+M1fwqXXVeNKiaJYFBqHw4B3X/gJ0odqeZ6BYyeEQe3O?=
 =?us-ascii?Q?QPikbfttAmzBmRi6om1hviGKe084hJFaqiEr6i7tCC3PGtZN3vAfpQ/t7/5o?=
 =?us-ascii?Q?FQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f2938c-d7d8-4910-914e-08dcbc4a95bf
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 10:19:30.7893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pPnmDndxQM+U0RdQPQQKtDNuKxUYE5oZ0qiK26ccStwJpayI50kBhElhSPHumAW8KdDcQj0tWsTxyGcYyyy/JlEKgZxLJDxkkvk1wnSKv7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9104
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

