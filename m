Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0727ECE57E
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 22:24:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5816388E33;
	Tue, 10 Sep 2024 00:24:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="SNzFblZE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87E8588E1E; Tue, 10 Sep 2024 00:24:16 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2072f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::72f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98B4688861
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 00:24:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nzWeHV5unXeeys7JBCk51j4zrT+ZcdocZ/QbcXOqyg72mKWiJrzPXl1QS7vAGvWpgxiV5CQlU4hKm6qvi3iqh/PA4JySmXqGKnDrgZwKdOnlAwFvQ5Vue1VXQwlKwrPUsUubO7Bt3yZ/xNTHteo5lUaxVa3CYvX9w0WOan+8+Ls07i7SzPuP/J3+JVTgbiIcj3USAYs1d9VBXzoBlDUd+sYkqiMV920IFsVvtIWD+rEqVN5tKWNLr71NSdXsZTglmYjZc/+pQJC1S4A/eNEmXH+VNWOY9dFt4Cm5xmcUPUlr1hGWEBtZuKEuh0q33NNhh+/yzUq6/74fpRqI2dZE1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jj6E/v54tZ2Ut0ezoDoDGevkXa1Q2vnNrPqWovpVS34=;
 b=NRBViyVIDj2oZjUzTKj7jkhrCqLnnTMmkJsC1zOWSHZV1W6yijGp09liAyIV58hfRhhJmu9aqsy9wE2nd+qWqHBPl+2JbSDrjWDQDoc2uOzrfQQUwSE97ThJ0ITcTnC4fDq5AGmnaigqSBWD29vMtczMmSsszwyRNk2eg+5gorVsdwlElRFhTk5E8EctoiELeH9dm47veRzD9J+uV0+olFDfOz6wPDd20O0LZ4ljQ59F0mxpORZ3rYj2TmQm812xcI49LAw254+OAHlI6ngvaR+Dp1BEh2bsybVeYSj/ng118jBsPUs4B4Q11aF413tme+0OCBpWHicStWV6nw2gbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jj6E/v54tZ2Ut0ezoDoDGevkXa1Q2vnNrPqWovpVS34=;
 b=SNzFblZE9UI/H9FTHSoLACq0RgfrpLbeZiTvR7k2WH/aGY7k06it3QNiS7u2W61nwObHgRdUEvu50suGVopzAuySu4KNbWxM8+Cq+MiZHm3pJ1ETnPWtSTvYk7qME5N2paf53/Bt3hGQBMbvyGj2VIjchreKq6FQz/IeszLDJr8sUuBCKJeBaWTaTtrlvKJIXzT5rQgr1geiU+jo9hl6DRw4HflxUZRAJiPxdV3Ygvla5VwV772MkP0fEaczBP/RiddDVntKpLvzKPu4kDK5qGy0iFqOOW21C2AZ2IdwAczS1QMyBTllxTNRfVbfMYw2JHAGwsGC7raHYjN4bQH0XQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9935.eurprd08.prod.outlook.com (2603:10a6:10:401::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.15; Mon, 9 Sep
 2024 22:24:09 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7962.014; Mon, 9 Sep 2024
 22:24:09 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Simon Glass <sjg@chromium.org>,
 William Zhang <william.zhang@broadcom.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>, Bruce Suen <bruce_suen@163.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Chuanhong Guo <gch981213@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
Subject: [RESEND PATCH v4 00/10] mtd: spinand: initial support of ecc engines
Date: Tue, 10 Sep 2024 01:23:48 +0300
Message-ID: <20240909222401.2562898-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::8) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9935:EE_
X-MS-Office365-Filtering-Correlation-Id: 728835fd-b161-442b-f3d4-08dcd11e1f94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|7416014|376014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bRFW6Pa2ER45QdIdAbIOZ9k66BS92s1z+Z425d8u3htk22fdnaFc0TRDrdAn?=
 =?us-ascii?Q?cpZ7AwJMQAXoPLxhfm2gfhKBWYT8TtwbfxpJXkWJnb0hG1LeaslsN4ET/Mzb?=
 =?us-ascii?Q?L2hIJOXhIT9OVWvQkUjhJYcsnFglPP7IzZKVzSYuxvxp3Ow5E9OdL2MrWNbf?=
 =?us-ascii?Q?MjrGDmlm+uNVa6WIKhWQu81+hGH/Pp1GTuMlOJTsfaa17N79E3ILRZSoPSNm?=
 =?us-ascii?Q?zKvoEC2CJR7P5iC+3a9q0v1med82aFIHTjgSot317m7iIl9YDTGNIzuT2UTO?=
 =?us-ascii?Q?swkJ8qq7ghBvifWz1AuoPmjZznOVNO8e4NBA0oITHkeLp2v8Q/iFIg3nMCHk?=
 =?us-ascii?Q?xOsfb0QqhXUHJ/LckXun3y201KyQzE0QwaXj6o2CffjJAWUC170ixHOZ6/td?=
 =?us-ascii?Q?apLANDd98LJE/jKQSECvYy00KbcsfnGvN155pQX/lg+8kPebG6v+1Nja8IFd?=
 =?us-ascii?Q?/p2d1awPiJiNNwH7yOWpclBvQhUBbQiT2SwKp3+tFANFuoBzw5MT3bMUvtkc?=
 =?us-ascii?Q?tYtzEBhSnNL96c3Uv/dV7MzxECblFjk7+BVU9I1JT/LvS2gnc5XGCxOAfU26?=
 =?us-ascii?Q?inyIbaejrkmKk+oRLLNJMfvtCqgC87p/kLSvvBhBgZIESIQSVA29WDSRhmrm?=
 =?us-ascii?Q?bA0cnGIFF290WPtkOEgYAY0dWEiuqFpAGSVqtqTbtR+pPBZLmAgI808KhN+Y?=
 =?us-ascii?Q?CQpS35lc+2SNAXENV/pfGYsAJfP4KFjncTE/XH0fzSRJ4c88PBC7SpJOjVBC?=
 =?us-ascii?Q?EPoxXLEcGYpaSrdf834LVwYJs6hBY4JleFda83S45QUZOlYRe5ZDZpExLXWf?=
 =?us-ascii?Q?ZdNyr6zm13ydpHqE8q+Ycp4DIc63DG0ZyS8LasvHfNqsp/moZD1Zm7OU/Y18?=
 =?us-ascii?Q?kgQANBVqusUuEb/kV/AcSBYUTiLeugQALIVbSOG8VwkCK9VI+3sAc9IMukLw?=
 =?us-ascii?Q?WDoLn8O7rIyIBISex9fCdAfvJDbAAUg4YBRDp8Dy67kplOGa9Npv+/k1oNTn?=
 =?us-ascii?Q?ELEtk6kSNiEeuuIHCfHV4J9veMvNNFe2OE3Annicov3u+hJE3A7jXA30yPtM?=
 =?us-ascii?Q?4gzAb2jbTnbllMLHbj5zEVudFBx848ESLhScenlYQCt1a3ppsn8WbUwhikAC?=
 =?us-ascii?Q?qchlntPSMixESISD+kr9EcW/hCEJAlJz25HF0vgmIMga6lWskNNuzUjqExMj?=
 =?us-ascii?Q?nW84naxpvkUkVNmwsVZtfHuaDoYnEpDwMwuzx/NrDM9hkjq2watBJRLUxeUI?=
 =?us-ascii?Q?6Omc7M9pg+lndePhZuE8y/VPurtAwNiNE5cevdW/keOalryxnux2jwdQb3JB?=
 =?us-ascii?Q?pZRTZ3vdoHWvkAkuk/FmzYijsCs+ayazfmRVZb+b5h015ZrQMpz5LqAwaM1G?=
 =?us-ascii?Q?3mTS2NpNjUw1RCf33aLqkV5Ec4JKOvSx+Mdk04reyhaO5HflsNViq/uPmxdU?=
 =?us-ascii?Q?a5wnZcE8Hs0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jnqXP1Oi1hqU6TXcMdZX3xN21B2C4AH2/pJOat6k4lNOlRwcyBsTuyE1dkiH?=
 =?us-ascii?Q?igj/YIS7JbJ82vsW09hIBxaAxXhbXUvmf/fFRKrQ0/ST3ogrwlmCO//EWfqu?=
 =?us-ascii?Q?/x3wAg9i0JgLDQAQ6afuHQSOzZN7FbyBuwDFMJkl7HUQtdAsivle7DyakHOR?=
 =?us-ascii?Q?QPIuTs3w9fQOsXEDWazIGcXYUHQfTdq0kpigDEpNMetMSGjjVsAe6iSlS9Kk?=
 =?us-ascii?Q?wiUN+S299y/zb3Y0PNDR2KOAAfh+7XKowliD3nEUMffMPKxxfAwMLsUxpcfo?=
 =?us-ascii?Q?IWLhn3poxO8QCiLInERaEUy8eoIbwRwE2df6bZ05Z+/3I3qBTKr1JS6BSLEk?=
 =?us-ascii?Q?h3Xv48zW33ZNSyXYDPl7oiGM+mUpwqTI/SMa/JlzUhH6VDtnob5cb7YLIXff?=
 =?us-ascii?Q?8V6sBV0evTOyn7GyPWiov3GOIAuh43yYIt9u//nfFoXWwA43IIjpOs2vhgcw?=
 =?us-ascii?Q?3Egav8jJcBcJqvrriBtcrZAdwjg+tLKf5QwxyC1vuoSArYShtQibJMBMEIdi?=
 =?us-ascii?Q?GJNH+VVwx5KpCSY1X+9l8BESevS5RYC8V6+RBV5334BFcYDpC1F8ityAMpLg?=
 =?us-ascii?Q?NXKGY2C0usNxITu9By87qNCXBUgmZjPdtW5nBjluA28aZlkMSa98nQ9wfL5a?=
 =?us-ascii?Q?jYDDypX3/N6GJ649npRPbUxhhvFO357/Ew+ocv/PeqiRYXRv8HMf9nhyIVfc?=
 =?us-ascii?Q?rETEeznTz+QN/ig0GX+mHYFQkfhRKpVFiKj3qUgB+mvycnyGPBsizVOcOOr+?=
 =?us-ascii?Q?GJ/b3UP9PiJhBDjr3xszyN+6iPsti5w/dD0kff9BluvSi76wmIkl8L1WoiqS?=
 =?us-ascii?Q?Lz2849aEBkvEz7xEHfjtlkg9eVHZ3mJm3KrywDItrrRZBoVsKgkIWkt9Bu2X?=
 =?us-ascii?Q?hGQakBlGiGwexz5kOTNcUZVHdF8KdIOFnxdQLns1egHZxI4RedcrQzAZKdNQ?=
 =?us-ascii?Q?3he3d7eBvhUbGMJUoYJuYV0Q/0roXgcQeS8YYp8c8ci9NqUQmEJNjy215qVX?=
 =?us-ascii?Q?Bteze+EGkXX0cLCB7+RYu4yYOcjigGZ50RaHnxBl0SEYFD6/5ivk4b95ycFe?=
 =?us-ascii?Q?I2biVJPkJbsLUBecU/e4Csn43A/sdFPQUFmMQlw0mWGuK1lZ5g88vuy6KK2q?=
 =?us-ascii?Q?46mmcYYa7U58Ik0uCNwTDQ3HWQGgdmy3hPmtz1bk75Z96QzEhE5YkhQSb3Cb?=
 =?us-ascii?Q?L0Up61xMm4jjMW0j8rP1jabHKDuYRBWLVE+DWcQZX7phKN6H+beq7lDoIDLm?=
 =?us-ascii?Q?2qiB9LSpXVcYwt5c080TvTMEBdsNr5SSvR1mab9m1zKI11XS4xY+m7UN15Wt?=
 =?us-ascii?Q?XVBwcLsjxCF64xuj2AAko3bwKlPMyl1jkQeS58DDl1nzzSkNZFNUU1j54Z3v?=
 =?us-ascii?Q?v1NCcgsVioS7kJnJr7M1XlXm8b1XWxxx7YC/M+er3B9c967qZc2hTvvNxgNa?=
 =?us-ascii?Q?Bibfe21lVJEJSqYkueeLXqv8N6V+14L28XsaT4QP3aaHcae+3VVrUGeIDDi3?=
 =?us-ascii?Q?5Xduz32EncM+xHL83fkfyqz7uXABWTR7FTpktKg1L177cZyPlricwm5OAnfx?=
 =?us-ascii?Q?eYyHexp2rQ0mM58DFaXGHZRE10Wi38Xc0mzVhQ0+D5KdGjVEGlVKaUJOEKOr?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 728835fd-b161-442b-f3d4-08dcd11e1f94
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 22:24:09.0349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OqKrxcELdecrMWLSnbBaf++ewcWtxDgP6caNTodPjwB++yukff7pbUcPPjUWw394Sdk5xSQrauOiapv81fJoyhjU+E9MHmRx4HvC4uForbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9935
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

