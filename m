Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A1CFC3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 08:28:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6224E8882F;
	Wed, 31 Jul 2024 10:28:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="poG+yAcZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A74558890A; Wed, 31 Jul 2024 10:28:43 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20717.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::717])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 706ED88373
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 10:28:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pYOY32zXz4DXf0IWLGARW5CE8eUFhp85vTiX/thdMJEogZGILAt6bOO8VAgiXVHzMh/WGIh6BZc1IZKbJvWVbJ04WGMAtA5Czi4emmWmFmG5U5lDtiacAj5s0/5nMx1grQW7kq5t5NEL8L7u37aglGoq/V0RoybYDdxd0HBWlTJ41dxk5kXts6qX2gQdJcVcCkd019rREKiTTM6MIJ2mDeluQ8a19kQmKr4wQdPOxoH6xO/gMco+7YZEhMD5vIygazKHpRA5swAd4oTe0TJl5ZV9BvNwgNCnbja1wh9vTrkwf433tPsABwFX1jJaQYQFs1iV2/9NC8NMT8xS9RJ8RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSyMuVqX5SQbPb1okT0NqMHE++vJp7Zm1ynx4UPPbaY=;
 b=vd76KW3pZEl4/vNUCInqMIf232150TVT6gBLKPiJrjv+3V2tpqhe5LeMvgy0cJaB5ab9d9EUDkcAura7rzYDAK329VbabpkTCxePuq6WJt/JeZiQfPwDePCkpHQDzlCoza1r1C1wxX/Wa/rvwUb8pXdOkHF33Vs4KaHkqcTW/JmVE8FJx0SmpTSlwbDgCAAG4ft9Sobf2Xk32CfS1Yp2Tvm3ixzbWFBDBvSzWw7iGxY3sWUlVUvMyHzNYlS1YRED6udnO9APZ3AliVlr35rZxrWUK+kBWWQW+Q2EdRTwn0q3EQxw3sywYnUJSqjh/jLYksiB89lrQgvVuhQSypW6gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSyMuVqX5SQbPb1okT0NqMHE++vJp7Zm1ynx4UPPbaY=;
 b=poG+yAcZ6oELt17TDT93UdlBSYaiiLbaXzAHRaIJpUeHt+m1amOM8+B8x3zH8NO5SC1UZafzEkVnK/LE4kK9fasnPdhXBEGmzsWp1py8NRxZnTprAb0uv4j4xT2ksBPolBAn/BaD/qcCECPV8miJFSX08eG2+hK3+kOclKh5j35MBg0GTCHO3e5tbfJtiPG9/iU3DwUgho8gTRJnkpj4dm6lqRcMRC3tLWY7Ex3z+uAuXyT091dAtD3RW0pKcU52RuJ97cOFUV/QqBLOQ2U6rUOvKmGFkSlvdfS98Xb9DFZQBDiFzwVhbFNATiA8bPWFJH4h/l/rAj6dGC2CWu6I/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV1PR08MB7827.eurprd08.prod.outlook.com (2603:10a6:150:5b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 31 Jul
 2024 08:28:37 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 08:28:37 +0000
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
Subject: [PATCH v3 00/10] mtd: spinand: initial support of ecc engines
Date: Wed, 31 Jul 2024 12:28:14 +0400
Message-Id: <20240731082824.3890809-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0103.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:348::11) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV1PR08MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: 244a805c-9f86-42d7-0afd-08dcb13ac628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ElxcF/BKX5W52F0BD1oBUXe/eZR16nEoDHomW2FD12kNnqZjb8uPH+qvsHuq?=
 =?us-ascii?Q?RwYO0wVk6i1mcnBwFAaP3FXpNYuMpsDuKRJfM7n9arPYJ6QCbHWUNUQ5UZNF?=
 =?us-ascii?Q?peTdwEhlp3r+HAyBHy+Z90UqjbNomPoOIJjDJUJBe7WLX7U1kwDvfmC1XEGQ?=
 =?us-ascii?Q?yHB4mNR+gmH0N/3iLtsXjWLnq4GFmdDN6AQLykYW4hPL1XqLRCOA2pzBLqOU?=
 =?us-ascii?Q?TAWrymxCMTwcUjgsLH3sB5QNsBvKP3vXY+ps7s51pVngYqNamE70HQijLOC7?=
 =?us-ascii?Q?Vh71c+j5rAclMG52aMIl7s0ByXzUJcT1aNUOnFCQYhjXollQleB7LWJaD4bE?=
 =?us-ascii?Q?MaeI4ksCgeZITZ/wdJt8n24Uguw/P9rUMgKEksyrNwlybTcSv3AbhZ8mMZ1z?=
 =?us-ascii?Q?90g1wHfcK45J7eI5M8YiJP1QSPveCKrA6mWPZY67h6NicG2wzNe9DR1lLkOS?=
 =?us-ascii?Q?DWMcZ/OB6u+N7v1zSNzjMTH5oX1VbWTLEMB0o44UIMf2YRscM57WKR4x1Fxm?=
 =?us-ascii?Q?9aIYWBVboPtDITECPQvueLUwYnxxW3lEDCvPebSAc/eaInQWV3a5b1JDBAR5?=
 =?us-ascii?Q?ptYLndu2XE5aMSg1pNsMsPuN9gmi5zF66n16zptsOuBDI6DVdV2fIWrNGoh4?=
 =?us-ascii?Q?9Ey8pGx9R6k2s48ZyTBI3FjrSAIEvpZ5u63GkCboR4aGrZlBCuCqLGE1ec60?=
 =?us-ascii?Q?I4D9X5THNay2MR24GVIGq+GeB/chadyAMP8jhLlzi6JrcB0e8YkyX+6DH2GX?=
 =?us-ascii?Q?BvbKyGZS4Qdud/2gtpbyLhVQ+HYumgPd57Bkt6qPubspFFt0tVs0s83ipUiW?=
 =?us-ascii?Q?8REZBnzkcsplps7FyuDiiaoRDSMyUBtOynZ4++9QGmgzFcu5wLUQTpoAxJN6?=
 =?us-ascii?Q?jS13KEUwBvd5hotBoE6FsSgqDfdTdtm1B4b8arXZlAlx0duGhtWU5IcGVmms?=
 =?us-ascii?Q?YVbI97sYnZGDGECeAud1qmtD4xzdC1x5eAG56Kv0xt0FWxtmCmB7DxH9YBET?=
 =?us-ascii?Q?AbhAPsmyzAbhvpgxSU9xwKwStAMmWhfvhZbBYTi98Xt5/KtBxCzbnmZUjzaW?=
 =?us-ascii?Q?dMoWrW0ZC9NNtVnKBs9zrj75DqmW4iMfhulH0yMNK2QPdeNrDCexkO6xfPaT?=
 =?us-ascii?Q?eRDACwLov0yM862DHXOaPdplh8/rZoyppuitGdasSqHehAD20YPUjd37zzsO?=
 =?us-ascii?Q?fuovjlYBeVskfoRNs26oewKZwooQW5SdTD6JELWn7lbNz6oWd3RVtvq6HBwm?=
 =?us-ascii?Q?7vzbCH/4c5lR8ZcrwYlGxzuKhOOcr9tay2RKShJGTibAfFCPQJL6ICYyKH2A?=
 =?us-ascii?Q?bgdcz2/wlYnGwXE+1f6qlZsCgcMnboiLUm2tTgvckK7hFWMOtR3yvyLR7BHS?=
 =?us-ascii?Q?mCwp9He7dterDqsEmxENZhGQcxB0+m1r4jXf917lz3ATTQD9tZtylk+cQFon?=
 =?us-ascii?Q?Egz8rz1RSeU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L7zjYWK4rgp4+ld3KClxENyQKj3ZFAD9NBoDbV7OWGo0lB95CKTEZ7EZ5aUb?=
 =?us-ascii?Q?OpDRsviQCSnXA/xTUH6pAsVnT/3lEVQc/sklBOob5dq9B1cmN4xT/yZ9Dy3k?=
 =?us-ascii?Q?6Vte7N0u5qjX3IBnHZGz9MmLwzCmi09JZ98SBKBYMetd+60q0UvqKiGetOIO?=
 =?us-ascii?Q?xiLgYw+A4UiTKhD8dcTL2mHRWE4en27QGRaoUCNgzE99V71RkJPDEAirR1OT?=
 =?us-ascii?Q?dkVTNiWmSvEyEf1+8BJr2kqBTwsXZk8xFvnAUF9GkZ811twJzKcjzuu+T7n6?=
 =?us-ascii?Q?yb8z5E5uCPs2smHffwO/A3wJ9B8n08FrbdcKVfgIHAwZXz8QPrCyIpFRi09v?=
 =?us-ascii?Q?IqHgdldnTfWX246vD4ky0pLcsI+BHB5tyYVrgUwY1YNrHkkEpyQcdm/TQGh+?=
 =?us-ascii?Q?rdVVk9vShp+V/rDG851N2WM4zU74ffv78LKyaNYChepN1r3gkB1V210PBIec?=
 =?us-ascii?Q?pi/ebj0tlrWdXxl4ja4CAbrrRtLltYDZ/l6INan/QbXzZzz22cB5Qev25+DE?=
 =?us-ascii?Q?kmATIMdFcS683slaL7N3v/2jzmJkyhfPPcxBrR0laRBuHWRJ8orzDebALxRg?=
 =?us-ascii?Q?6fzW49eMCuIaAo7EtQVNJ+/l+d7wNGntdSZAiv8fz0DfifT0nbRj1fBmyOCX?=
 =?us-ascii?Q?2+/9xi1gPB+oDVjbH0yaEL2W4ipFksBhv58+5PqBaUaxo2DZFzkSq6IE26OF?=
 =?us-ascii?Q?okCqlGanRdMGxhItt+oI82NWZs2/vPYig+DLsyKEINT0uXAHHUyQiOw4/o5o?=
 =?us-ascii?Q?xacoaxpVkHdaQKDcZzdhUZ+1NVxWwOhBEJfYyW3IdwjdM2EZ9/G5Cnis2bcl?=
 =?us-ascii?Q?SBRHBq2kSNnzM2NrU1TqgT1j93UfnTCZ5F8SqG8pMfcCRrxqaV6256ttHXa4?=
 =?us-ascii?Q?DO008qgM+/ruL7ywX4vjcuPbtQUTyj4IwDihIJKwmsl6cgKrRKA5QJNw8Gvh?=
 =?us-ascii?Q?xIMbEM1s1onzi1wNH52gSrO9rl5gNUV0xjrW1j/ReJpcxAuxu1oyiVFX0Sf7?=
 =?us-ascii?Q?SpgF8V2ljQ4FlyFMW2sl3UmZ+/McO36JkC4KJg20rM3zXPN1bLzN+Y3Lm5sx?=
 =?us-ascii?Q?E1631zolTRiMt6cq/so/yPPakxJws+Hlno59LYrj0WjIqCEIYqjhZ28L/Vor?=
 =?us-ascii?Q?8wLI6QJaX7KljhDFAryXiW0IsCBYWyAuKBSASwTibhapqmbtNloO9tdLD9sr?=
 =?us-ascii?Q?gCWmPwzlUf5nfspdHZTkBozQKbjOEh7LBDhfDBt9UNfPlJ3g3YYTH/luoWgf?=
 =?us-ascii?Q?hAKfpni1ylF/DV2CQaHzVB0nK3+Y6rVbMh17nSpUwFpqfkTkbeCSEH4d3zT0?=
 =?us-ascii?Q?gUJTNztuW8McxkT7CFhSbdJIPs+4i5wKpTQBCefhuC+HDCjIJihvu/bBSssf?=
 =?us-ascii?Q?U4z+v80/truaYjJSvESrzlhgWClQZSYwl7bclizz4nYS8BEiSs0tavsJgOsl?=
 =?us-ascii?Q?+2G6H8iQZXBoHfxJnGDBJ9YMURL6rTx0cICbqR/UTbBwFcFWfcDo2Er63pAN?=
 =?us-ascii?Q?+9PXeXvA6N2ZwmAOASq2YDTiyazkvVP2/bMythsZnM03z+u9RTcIJZ6w0qm1?=
 =?us-ascii?Q?/8OIKTu22jubjcKALCpI0Xq+5NN+qaJUa/U7JalATD03pBc//us0LCz5Gp7o?=
 =?us-ascii?Q?jg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 244a805c-9f86-42d7-0afd-08dcb13ac628
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 08:28:37.2588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8jUNcqfrYevYTmu8rVnZBZh7CHURHhwFW14uGkxpbLzBz8LC/zr+S6ENf2b0LTGbvekLh7PdIMb50L9iNfTIcsfG8RZvtCVHI708bUjpO8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7827
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
 drivers/mtd/nand/spi/alliancememory.c | 155 +++++++
 drivers/mtd/nand/spi/ato.c            |  84 ++++
 drivers/mtd/nand/spi/core.c           | 642 +++++++++++++++++---------
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
 17 files changed, 1776 insertions(+), 269 deletions(-)
 create mode 100644 drivers/mtd/nand/ecc.c
 create mode 100644 drivers/mtd/nand/spi/alliancememory.c
 create mode 100644 drivers/mtd/nand/spi/ato.c
 create mode 100644 drivers/mtd/nand/spi/foresee.c

-- 
2.39.2

