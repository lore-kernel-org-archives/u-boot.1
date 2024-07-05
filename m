Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC479C30658
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 14:25:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADF9F8836C;
	Fri,  5 Jul 2024 16:25:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="JslCEXw/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 418D288855; Fri,  5 Jul 2024 16:25:16 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2071f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::71f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 063BD88168
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 16:25:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJQaYFtjSN6khv4fXxT7Pc8i1OBzjtxqwKbkYglMyD/9at+1eqfLVF6Hqr7yowy5biSVSpdxMG/4MUDY70S8ktBj18mx+uXN1a9ZNu+qGs3RbislJAMTbzoE6Aw6d41ezA4lLcL5mCCrvhGltJq3G/+DkKbSMYnAzVPMntsFkg4/azEmed/nE9tZI6G5AH6u6zWt+MjLbfF+8l9dq948l8XsRR0XHgT5xviSL7BiaoAyCN+0FlP4zSAXRbAbzKORyUSIrayfIHDL10FbLASJCFG9bJonnNtiBz6taDlh76uW5U9460K00VxgqPVf5ogy7/7Pi26gXR1yhNWv5B9rXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jJvQA3xk8tlzmu1ip626UjxQY/mwqts0g7WZ5MpDfQ=;
 b=hSGcuWDVJXUb8qSecCD8AT9KgjvFzkdhlSyo9CDRLQ9dl4MzFk+8hggKivftfhiL105TGZGJMvUyMgItuG0kS+DLFeA87+fpRs82UOVDHzuZSwaSa+LL2em4Ji4QNRBmO7A9ySImzjGbry7QDC9rS+uKAKh9j769Bz6vsM4hfjenygXq6AYB11KbdmRs08epv1pM9A0jomV0AclkI4jN0qt1wJzHvqkXafjdkzqWgXRuxaYkbVguXsVf5FYBNT2OJuvNHJqBtSTgR+HNQB5R/ErS6C4lfJgimeyqgc1nnER2J/yDBjMCvmALPRuUuoxGE+/WfvEhPM9Mb15Q5SLD/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jJvQA3xk8tlzmu1ip626UjxQY/mwqts0g7WZ5MpDfQ=;
 b=JslCEXw/jLSyzEQEPcIxs+nDpin6r37OdunlpRQrojPOZQofh5N9nhdbVBkQz7wBQe/v0UU581Milut65C0fNPIKOyEtV/ecqXUI5eYFsZdIKRiw7gd+MU57fSxAoVBwsRcAP+Df65E1kpb7C+Oinn+t0KwA83LEsTHRCbjepCaGcDEV9jmSWc4l7keqFusImHp5iRvUzYT9OHj92tZBYgcZM8bAZT8bb070HwyBffZy9dyyFFqZp4rMTrIJTLAe67c7EOYi/355SSWX9ZfXKozdlOnjz7FcyFTm+UqeDQrFU1m3HBpTRgRyD2uhlSyGUgwB/Tu1vPjOROeDXwnC5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBBPR08MB5978.eurprd08.prod.outlook.com (2603:10a6:10:1f5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Fri, 5 Jul
 2024 14:25:12 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 14:25:11 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 William Zhang <william.zhang@broadcom.com>, Simon Glass <sjg@chromium.org>,
 Bruce Suen <bruce_suen@163.com>, Chuanhong Guo <gch981213@gmail.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 0/7] mtd: spinand: initial ecc engine support & sync
 supported flashes with linux-6.6
Date: Fri,  5 Jul 2024 18:24:53 +0400
Message-Id: <20240705142500.2272803-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0020.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBBPR08MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: fb2562f2-2ab4-411b-8bb5-08dc9cfe4772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|7416014|1800799024|376014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wEsLMWRiUqSYxwJF8BmIuTOFN1jn7pRHG3rdmjPYqKAcxzFfsxIFv0mWTJmd?=
 =?us-ascii?Q?3aqsPJ/qX5pYCa/TBj3VCcE0uDjt8sJty53J+UbT4MFhymq/zQZonD7z7LDu?=
 =?us-ascii?Q?HOwHWvQHU2XcA3cUKY+/kx1yTDmF59lIeDekIbcarSNVw/B4oZ5TqfuRwIJ0?=
 =?us-ascii?Q?5Z7VffYhy4O1c35IGypDXD8NLBJAOYOeo2ct5DrIq+gvpuNMv/KLWYzZqkO5?=
 =?us-ascii?Q?9az7wDdLOXTU1sRYarsMiyy/WFG5U+YBf6l9+vtwtPLfIQP30WSGI75N6AAi?=
 =?us-ascii?Q?X4x4j/Sd36cQWlznayG5bBv+tmfLoboYhIB33NeDZB9eHrVf6JQHmls4wSXL?=
 =?us-ascii?Q?B/ttT4V1C6ujvvxjyk9WTDFEJroKeIPwmp/YGmOzmD65MSLfcErW0B6ZU3rf?=
 =?us-ascii?Q?HJf0eaEk+EGGC8+lYi3ymMZbSjuf8TCmo3j58Yw46Jl4IcZiGV1DM+S4Mlsq?=
 =?us-ascii?Q?3WvwhP78N9+0UITs5bsMwlMEL0nJs04xUiqK01IdKak0smno3zo0J3YTJ4jv?=
 =?us-ascii?Q?u85jACB++NOPgOV5B1zej1Jdxe3kOlXDymC/F44mry2OiGy6a0NK3XE0MG7C?=
 =?us-ascii?Q?6j3fh4/EHFCA6ZK23hRAAlPURLKsBfOj0zK4ZMzKNf5bvsq7YN3BfVf9gA0b?=
 =?us-ascii?Q?tdmo0shm6CngVcWsnoc66qPvOGWbIfWya4dt48cKNnbaUn2ORgalQ2b7zJyk?=
 =?us-ascii?Q?Td49q8R6oHn4pmXJcyrvAGJeA6DbF3OQDATqd5soAbtVzHmpS2hsT0/Q4SSD?=
 =?us-ascii?Q?90sd7WBsu/9WvleNeeTrCW8BjCVGANVU25LVXLl790WfiB/PU16ODCm8JO6h?=
 =?us-ascii?Q?2OItQk2ES536sT8lCwSPCPLnhP1mrrIkjq5dCMu2KjfFJvaTuqVjXhLFzGsV?=
 =?us-ascii?Q?kfCYru514la939V4CHSVtoPoyFilnBu/oFUWhIrX8DgH3ruczTAh9mM2kRPS?=
 =?us-ascii?Q?xa+uxuuvQcSkMzxZhHB/woOMt/1ZPUZzpmctKY5Es3RxB0+wKEuniEffcgAZ?=
 =?us-ascii?Q?fLliGSBhpHhmaGa33ABLA1VsZR2T0UfF2ZuVbDdTccotA4tVLAruM0kkAIq/?=
 =?us-ascii?Q?pI96RbXr/YkXGWyw//x1Lar6QRFxCJotbbGppjvH1Wlb0Xh/HrIc7vyi7+sm?=
 =?us-ascii?Q?vQrAjNdTto/8Lh/QXRSV4YMvklhoryC76FDEvUR0Moz5iqx2ZLtkKwnlFSr4?=
 =?us-ascii?Q?aJSk66apRntuomvO4X/zYbV+NHVcce78E56VrvKF/Zmr+n/ECYgQYS6ATCkr?=
 =?us-ascii?Q?I0U5n2Kql3OWaZjdje/PxIbSQDJ/jIxFr7uQFfr/1BYWHegmAx1rgYcPmADL?=
 =?us-ascii?Q?SxXs5/B16WPa+qTFnnDf5pQW3osExVmIpYysinjDHG3pgFFvwebo6yoKKbCG?=
 =?us-ascii?Q?ya6lLg52LXXKyWIP5gCTpJQ9wlHYqyFoOKn2pd1I6s2Vz/ZYl6eFTvbxY3AN?=
 =?us-ascii?Q?wzN3cLsMOLo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(7416014)(1800799024)(376014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y/XB/ljcTiEXMNVbz6PP+AiSY42ugQC4snjby2vIZiTXUpq4ZH/gMvZBNs0W?=
 =?us-ascii?Q?4JgM2NwmOLDkPHixpAVUYCuaFTNFJFj69wtzi+mvg2CX6Hl+9rayaSj468MO?=
 =?us-ascii?Q?gMfSfzjAtFVfRgWo5e8jsGeC504Iapgbd6KapUHGG37Oe9mmEuPbsjxGTmO4?=
 =?us-ascii?Q?Ki48AZyu//TFKWOW+iUg2rqntPAdZ/0lZTrDFPhKEJ41z+Z+P+txZKPUW0W/?=
 =?us-ascii?Q?wK9W+qhuSpP7+YhS2MvUFc6pzAI7MM8Sj2f6RQGsv9V0hfVCYwUGHyXrBMTN?=
 =?us-ascii?Q?n6NiFFGhjLz00sk6AnlvU8Q9vgaM2IYPx2K6VS+8ySE7ODH0pkGO28XII+dh?=
 =?us-ascii?Q?hy1Ap/uyDHQoNT9CYGOj/QwqTJ7P8umEVqSWJ+3iDWDOYwLVvS1USUa/6R+9?=
 =?us-ascii?Q?8OveKxCWt/MIuXiMOLqWUk/uS88ZJaYH9YvVsyrq+GBigTUTbvj6CbFMWp8v?=
 =?us-ascii?Q?ACHSYHACKSWk+9kBq0LqNb+kvE3rZeqLpl9ORenqv8OwEunaVycx3e0XAgUd?=
 =?us-ascii?Q?eg4kRjqesLVvObEGmMma86gFAKy0iz/NNKOVHzOO1fdm8dx37Uv5jl0pish/?=
 =?us-ascii?Q?pZ4Bg3oon7Wtk5ds8KZGBnQkmCvZOxS0TTDm7+7cg2SeQeZwlGm7RSWPW74Q?=
 =?us-ascii?Q?3aeRqYuc6gGOj8NOIVJHyvBcoDuQ6Rx1EXgo8/cbG1EBmf/K6y94DlWFHztU?=
 =?us-ascii?Q?xUkPY3r3j/ov+pUUxzaZefCqkRYScdATiaHB1yI3DiojIzXleoQt7Bw8eiKs?=
 =?us-ascii?Q?D/c+YY0tQ6ybjIvudvTD/sSLNyahqth3saLkfngLxHWASYZzb2H3T1qRz9Hd?=
 =?us-ascii?Q?sIK2Iykvda7tZoQO9pRt0fkRxovNfF26y5gHRc4NQrEA1HTyV2fgYOBWT15u?=
 =?us-ascii?Q?1FSFrpy4qmpR+Ksf3kYJhaTMGdkA8Fe512I0iozGetRKt2KUO52NjVbc1ONx?=
 =?us-ascii?Q?4L5rq/QvW2uXgAP+MTPseAVK0KggCg4mdML4R6MOtm1T4Usgrx8F2maGm/oV?=
 =?us-ascii?Q?up2566QaBQ/10MMMxbDCGD9F/T2D2PhwXDwBDEvD1y+kothbjNr1eNIA3pqP?=
 =?us-ascii?Q?gOO2RKE+wph5FuEgzJrITOHyg1EBcW44vQKk6HhTdAPVCw8NR09ZavleFprd?=
 =?us-ascii?Q?AppBFHOyR5ZhHN/eUt4DPZuJttOYGlJvmbUciCR8dmiZyLQPiArltwjuF19N?=
 =?us-ascii?Q?YZgsACk0+Rb/vCt2AXkPgIFFhfDvCu0BDcFdlesqHo4/cxdlvZ0UYhYfd03F?=
 =?us-ascii?Q?rOdUW66dhii6pL4EVCTSmuz4344brtMBUOgcfuQHh8YmUfH5fJ2Qx+oi4Pb0?=
 =?us-ascii?Q?WgBhiSvIx2iYeeMwcS65GX72H8adb4h8blSAWvk/lGU7Ji1vkBELqMlW8Axu?=
 =?us-ascii?Q?m7XQ7Y7z+EJQ6+a2B1RHWX+ZBJ8FO2T5mY0vG3ROubaligL37bVovDAw35YI?=
 =?us-ascii?Q?YNHx0J++TNAPCcbVSxCnqf7N/MqF9HkgZIJBg+/hZKjDt4MqlbRxbARhfSAe?=
 =?us-ascii?Q?PC7aWqNCMjNanexvAd0jQKZgFCvZb4iOPpy8CoeVkrsl3KaKDvn5OD6vAPPo?=
 =?us-ascii?Q?5c8p/DV/3ZleBhRyKhqWKjTtHheWzk8eCSNc3822B4pH2DP6ZI/aTCvFJcu+?=
 =?us-ascii?Q?YTBKuia19RnQcQRqHJuaq8E=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: fb2562f2-2ab4-411b-8bb5-08dc9cfe4772
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 14:25:11.6615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bzU6St4acQgmW8plmVlQhhuNFJm/rLOkiEBBFgQxxQLM8M0mrT3PbEgGiE1yv896FgXr+DxN3f1zbREIh9/hNco3g10A4/dhQZbIxdTlQgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5978
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

Up to now only software ecc is supported, but other engines can be add quite easily

Mikhail Kshevetskiy (7):
  mtd: spinand: Use the spi-mem dirmap API
  mtd: spinand: Add a NAND page I/O request type
  mtd: spinand: simulate behavior of linux's function spinand_wait()
  mtd: spinand: preparation for ecc engine adding
  mtd: nand: add initial ecc engine support
  mtd: spinand: sync supported flashes with linux-6.6
  mtd: spinand: add Winbond W25N04KV flash support

 drivers/mtd/nand/Makefile             |   2 +-
 drivers/mtd/nand/core.c               | 130 +++++-
 drivers/mtd/nand/ecc.c                | 150 ++++++
 drivers/mtd/nand/spi/Makefile         |   4 +-
 drivers/mtd/nand/spi/alliancememory.c | 155 +++++++
 drivers/mtd/nand/spi/ato.c            |  84 ++++
 drivers/mtd/nand/spi/core.c           | 641 +++++++++++++++++---------
 drivers/mtd/nand/spi/esmt.c           |   9 +
 drivers/mtd/nand/spi/gigadevice.c     | 188 +++++++-
 drivers/mtd/nand/spi/macronix.c       |  27 +-
 drivers/mtd/nand/spi/micron.c         |   2 +-
 drivers/mtd/nand/spi/toshiba.c        |  43 +-
 drivers/mtd/nand/spi/winbond.c        |  19 +-
 include/linux/mtd/nand.h              | 278 ++++++++++-
 include/linux/mtd/spinand.h           |  46 +-
 include/spi-mem.h                     |   2 +
 16 files changed, 1517 insertions(+), 263 deletions(-)
 create mode 100644 drivers/mtd/nand/ecc.c
 create mode 100644 drivers/mtd/nand/spi/alliancememory.c
 create mode 100644 drivers/mtd/nand/spi/ato.c

-- 
2.39.2

