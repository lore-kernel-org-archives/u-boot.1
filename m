Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C37ECA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 23:43:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8802183816;
	Thu, 14 Aug 2025 01:43:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="NaG8hwLq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D6D383829; Thu, 14 Aug 2025 01:43:28 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAF7F837E2
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 01:43:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azrEyOHaWriwwCs6RaOsx1vR21ZZlWhiO4HQ1GLsZYTcD/yrp4aMYOzEnDrt9D+6lyQxcDnn2e2/wnYUIf2UUy+4Jgrmi3VhE12R4bhfa53v5H5YMn7TAAU/gNWqMWLMTqxXHro6/2wMl2RTjJRwZ/zl0P/Z4KWiPYOCJiD4YI0qbFGLjisCu+kbWIU0f+ptmnsoLkWYuI/YS20FqWrd5KScrwWpSPzRO9FR0XOf4qRpIs71EqHqedad5Hp9QHJdIXqrhWbJ3oF89LK8epGpxpLzpQ9unRZjdOaalPn4gfstZ5fKriInSJ7MlqOxOsmNjDRYAjOKwtw3kycYa5IOcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ducWGusvzeFFOF1Glg/oaDcei7H/g5fXfekFRH/TGXo=;
 b=evmkOmJQEFRc3tet0e2Ism1CPgIb4wE3w62WwtsMniyg3Wn1AZEKMdhXHl8r3RrToDuPCT8pKbju1kGDcuWKi8h0DTjkJnC63WS7gPI4so9YmhfQ7afdPxBkj1sH5l7P8BYVWlJvqA0Obvym8oegKvUw0y1WkdmiLLnDTh3PgbUh8wQQN8aNjqFsWN0Rdv+BTbWmbjUcbYH4KWIq7loelZXigTWgrUjnST065lB+m+kuGZRrJkS1621a+JrizvSS99fUG6XWgw5hmocHe1qSzGfANYe39ao6pF1czOYxo8tVnFoMLr71oBXoZD0IN7wqBxOX6HU/JB7RLgrz2TFFDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ducWGusvzeFFOF1Glg/oaDcei7H/g5fXfekFRH/TGXo=;
 b=NaG8hwLqCngt7mw2TBj3ufzZ+bccUpbAWE+dN1zWBFwB8lT0Rv5pJvytbvl15GLisin48AgnLV8PmIqYp0QIkq+dbFUJ1TZou88y4vlkxCeDYIe7TgIn+nzOYnPw/DJ4/HKEtxvgiuAJnT3yOhTxHVEt+yOHFDugpErt7z5NyiGQUPZ/xicnNZeHmHsEog0XZzNd7p+x/wTwqML67xNB15SQ4fMDyvp/e4/l1E+eDbZqbLDqZkgxBMmoMmdII79JUM0AcLIuJBT0K9Cm/LfY4EN+7E5JMq2dV5cXJ79xmsvqAqjdPhD0RJmPVv9tgQ+D45at1MT5VI+AIgoOAIF4eQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by FRZPR08MB11021.eurprd08.prod.outlook.com (2603:10a6:d10:13e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 23:43:24 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Wed, 13 Aug 2025
 23:43:23 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v5 00/21] mtd: spinand: driver improvements
Date: Thu, 14 Aug 2025 02:42:53 +0300
Message-ID: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::7) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|FRZPR08MB11021:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d7fbda8-7228-465e-4ef7-08dddac330cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Bi3PV0lPyPHmaCP3YSzIy6Seg/clqAn7wpWju1bxV7f5hPIax1ljSV/Z8NFB?=
 =?us-ascii?Q?U66A9cNyMjKn/moT07q71siTO5P35QUXu6BUQc0Z4dhrm8+R2d+sX7/p+E1L?=
 =?us-ascii?Q?PhR+udEv4Z5XXcqoZuQOC2Z7bP8CiG1RRyTAxy7PQJw94VUSJ6mhq0DUpkLN?=
 =?us-ascii?Q?82jAhzLpJYJBlAm5SRjjoZWUbqKJMYI1sfhPC2CGdJInWNYX7RgZCTh2tloP?=
 =?us-ascii?Q?tNMHJyykvH4+jnIOn7NDdNMaEwx0sbKTpff5pdZzdQ963/XUBi3ZuaSi1qAv?=
 =?us-ascii?Q?tZQxdyj4cIPW0gGwgP5BvRxQOloCGdDHO3kyGIAM0E+TN+jU7jFUQmwBhCAA?=
 =?us-ascii?Q?j73eZ6LBHzZP+WoaRvLsxJiaguayThkSudKaLWO9YsbO1+ulJ4u6GC94X3Nf?=
 =?us-ascii?Q?cLPmWL65HfDwymkQPLiKHKNUqfSlQFzKhMWt/kZxH3OpP5jXDxknQ3gIf5KI?=
 =?us-ascii?Q?UOn50KECJFSTpDE6JePrIOqePDRE4yQOYI+Mqq8fWXjE1Rhzp3A9qy7Knuav?=
 =?us-ascii?Q?FVwsAvM7cxjNQM+x4NLO6oXAz+fERYOAZsI/0JKyZUWQjwHin8yzO9ssJLAO?=
 =?us-ascii?Q?uTp1JSP3HwAB3yZ4b55CMEbf23qd/CZzsQ/CAbyyGcYWqBsmAn2UYCLhyXyO?=
 =?us-ascii?Q?cr3KdZDbUNLmNZMbSEkarX0Kqui8t4cuAZnnMwyonh1L+PpFqrcKmRT4M3WO?=
 =?us-ascii?Q?YjImqk35Pdpul1KmY30wd5oDDQ9gkpgLw1EyiowqPueTk3q/QKHmgsAsiuZg?=
 =?us-ascii?Q?LOqePvxXC4gJEOyoMwC4wIcTHwpLKFLsEWeR7x9yDC2otMhKbiFoXY+XSQx6?=
 =?us-ascii?Q?beHgoZGzcXUu9Bybl6kF/a0qI+Who5q/4wwlbGUrEz80FspVHJaGgXnhKvHo?=
 =?us-ascii?Q?SIu2hgDZY7S5KRqm41C1Gpoo/K9e7v1GVcsrH+dwx3lZyQK38+joWesDsyZV?=
 =?us-ascii?Q?rQj5KGS0EJEKC8sy3H6XRBibaa0zWxqLdblDlH3Qjeio11ERlhl2E2ZshD95?=
 =?us-ascii?Q?oKMmhbu6c43gUoV5eCD6MlF1sM717wen3VK0iAM+jP7VE2a1iH1ykeZach/h?=
 =?us-ascii?Q?temE5aGNAwwnfnREfcjNEIbAqGQh9xwL7BZw6/qpFpPq2PneFXAaqZGVWCzj?=
 =?us-ascii?Q?9tTwXAjnKOXTTXqZ3jbdlsPc/dcBr0WtqAALD0Y8/sKu78ngEiz08srHeYjC?=
 =?us-ascii?Q?xUmzvXwGX5mn6JCQyps11cluvm7Qh8nFK66pMoHbJVStHu7SzX5V/FvSgNSu?=
 =?us-ascii?Q?t7kMRBJQFKyMCcpkVnkW4KVY0jhr0pDhsPnWdcFWkX16Exd4JWbti1pvzzh+?=
 =?us-ascii?Q?MaTalFV64wK4fsAlSceASfROF3bumQ4v5ASRJ4Wr5UNunQyCw1C/FqyHl5ME?=
 =?us-ascii?Q?C6uqgrYqH6/RL+3+9HBC2rRT/G8V0LGLb4bYrgYDPq1rERh0TwVlbcjgt44D?=
 =?us-ascii?Q?GLKi1gO9ahdF2EAwsQJeAkDe0mVYimdcVfgPRO5QEUiw3Xldor3diKeOiDxC?=
 =?us-ascii?Q?wnTAMzHl2gc3ZCU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sC6N5Z+HwOIOjQN2vZhRhw3Irmrm1XHMjQaz+ZNSvAei6VrRcVqmjFbh+HIm?=
 =?us-ascii?Q?JUhY4XPTgqXHcTStv4b9UFoDrSBgfZmO7M0RuxZcWH1DDdoInj/dMdRQpy/a?=
 =?us-ascii?Q?fQmkZlYzlF/fMNOUp45YFzZ/68LU5DVLgA4U0I7jfeTl+SmsJNzq7Fcy8pAE?=
 =?us-ascii?Q?CUjOjIz+DgI3l0ARPURxHcOx8AXxL2lHPDZXZ0VGVccRnufkEIQM7kkfHVLr?=
 =?us-ascii?Q?THUaZcYIRJv8xV+47dsQI6+/3WVFDh9jy1c6Xyl211udeVv7IsIqXFvAtoKX?=
 =?us-ascii?Q?HYjh7YgObB0ZxXsZilnEBLtUaoVxM/gh+hVuDhUKfhf4NmBevKagXJr+Feif?=
 =?us-ascii?Q?6pW8bCWXnSmCzcAxKCK8ZCP/ZRncXucyXmPUEnPJjdGRGMgZM+D6I0hsgMA3?=
 =?us-ascii?Q?+9F5hVPCM/tM3xYfCg/tiqoUgFptkFMIaohyekO++7r9yrxQUxp83i9A5ysz?=
 =?us-ascii?Q?/lzTA/e6k/niwc3W7+TZ9brImCoJzwwsjw0iVQfpWybWPF7dRSPCesHj8gft?=
 =?us-ascii?Q?VlbEctrEv0TTWxaDzilN63+A78HVj40rDuAdWhXwTRmh0YcMV5XcsCn2w77i?=
 =?us-ascii?Q?mlvvjVA7fjGx7Su5eGhryz1AFkpJKHldmg84hhgmXTpaeFOe6Aqt/nteVjQh?=
 =?us-ascii?Q?ZRB0Y6Rcx/aC6aZrcgMdOY5mVCDFP+N8A+RxJ4VMWIQ851GYPRmwaS8zbmYk?=
 =?us-ascii?Q?FFvnuQHO/NDWO2a256ytqPGAJ3qMCpbWjYbjo8qGFsDWIfzIspsxEk/e0okK?=
 =?us-ascii?Q?qJbDM4i77YSEuz29jbM/0AUd4TY1cTooNTDYpVVQNP+hTuLrQGN1PoPT92xU?=
 =?us-ascii?Q?D0jfpO2PnQAaJ1QbXumV/BuGEpkkYWkuJACEa89Pc2JKBDlkVtP8YHnUcRVJ?=
 =?us-ascii?Q?YghtIpND/cSnMCPWEOVvxwwnGIQh5QnfqeYfWFkWO4snW3bh4rW5/QpLgiK+?=
 =?us-ascii?Q?ATwqcZ/CCR9bqOZDGeQE+3CE/03wW0xnPD6IE0jFU7wkIy7PmnXkvVVg5KzA?=
 =?us-ascii?Q?UopiVx4Adb44dgrbCuKS2KQCTsoFgS4v3tOgAkcY+r4pETtgSDUDAxkhELA/?=
 =?us-ascii?Q?yM6shinODtNEhVYgMJgl389N0+xYySyEfnKe3A/Eo3XXG3PgZHY9MLPJ5a0Y?=
 =?us-ascii?Q?6ndjtTUzaAuy5AfihROHS3oGVRoxk96aUb/BGqkLUMatjdmhrzvfDaGBirVh?=
 =?us-ascii?Q?lmEp5Y0A1PMVHwri0UDmATpZguqI72epGuIF+qd39vJBjRj6jkYYTgcabPQy?=
 =?us-ascii?Q?logYYAlYQjhcDrOsL5GPwmUPYmXScxj3JzQVTursHQDKnUHeXJp4YX3S5rDo?=
 =?us-ascii?Q?ewN6scHrqypsAL/MUTCUlJ4VXUxTNLdsGh/+UbVedCh+gluaT7eIUmnEfbJr?=
 =?us-ascii?Q?Oy7lcp50bdw63nQU0y4vOUeE1oQAbBXcORENzZWq95l6OgMsJRHaNI9M6uCs?=
 =?us-ascii?Q?Ad3Q7yKEMUuv89HeWpv0evauCH9NgEdiJhlMzXxbFs0B7sUO+BosgYu6vySt?=
 =?us-ascii?Q?XF1cL2pFVFMsGcMm55oLXAoYcbvQoBJHNB+NY/6YYSlOlLuPBqSZtkn9Gn1o?=
 =?us-ascii?Q?6A5st663TJomzckqQCD2FV67pZVhbN0+P4GcxS6qD6OGxlXz81t+136koAEk?=
 =?us-ascii?Q?RQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7fbda8-7228-465e-4ef7-08dddac330cd
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 23:43:23.3246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w/B38JcYB7WBHadpbMbEiirryfw4/JxhZK4VlTXuXlLKSLhFQfLR6hLIDU2RBijBYqnJMjzC2w3m/mF502XweVk6cnTk1GQoyrlzh8hc7lw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB11021
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

This patch series makes u-boot SPI NAND driver almost the same as in
linux-6.17-rc1. This provides the following improvements:
 * it becomes easy to port changes from linux kernel
 * more flash is supported
 * spi drivers can accelerate flash reading/writing using spi-mem dirmap API
 * continuous reading mode was supported (for some flashes)
 * OTP support was added (for some flashes)
 * add support of special data recovery reading (for some flashes)
 * bug fixes
 * other minor improvements

The following linux kernel driver features was not implemented
 * support of different ECC engines
 * per operation maximum spi bus frequency

The code has been tested on Airoha AN7581 (64-bit) based boards
equipped with flash memory Micron MT29F2G01ABAGD

Changes v2:
 * update patch description
 * add fixes for continuous reading mode

Changes v3:
 * fix duplication in patch description
 * add more information about commits ported from linux kernel

Changes v4:
 * the original authorship was preserved for several patches
 * the code was synced with the latest shapshot of future linux-6.17-rc1
 * spi-nand was replaced by spinand in patch description
 * continuous reading mode fixes were updated

Changes v5:
 * add missed SoB tags
 * improve patch messages
 * add tags for patches ported from linux
 * drop continuous mode fixes (will be sent after corresponding linux fixes)

Alexander Lobakin (1):
  mtd: spinand: core: add missing MODULE_DEVICE_TABLE()

Cheng Ming Lin (2):
  mtd: spinand: Add support for setting plane select bits
  mtd: spinand: Add read retry support

Daniel Golle (1):
  mtd: spinand: set bitflip_threshold to 75% of ECC strength

Gabor Juhos (1):
  mtd: spinand: propagate spinand_wait() errors from
    spinand_write_page()

Mikhail Kshevetskiy (12):
  spi: spi-mem: Extend SPI MEM ops to match Linux 6.16
  mtd: spinand: Use the spi-mem dirmap API
  mtd: spinand: Extend spinand_wait() to match Linux kernel
    implementation
  mtd: spinand: Make use of spinand_to_[mtd/nand]() helpers
  mtd: spinand: Align logic for enabling ECC to match Linux kernel
  mtd: spinand: Refactor spinand_init* functions
  mtd: spinand: Refactor ECC/OOB functions
  mtd: spinand: Sync core code and device support with Linux 6.10
  mtd: spinand: add support of continuous reading mode
  mtd: spinand: add OTP support
  mtd: spinand: Enhance the logic when picking a variant
  mtd: spinand: Sync core code and device support with Linux 6.17-rc1

Miquel Raynal (2):
  mtd: nand: Add a NAND page I/O request type
  mtd: spinand: Add a ->configure_chip() hook

Takahiro Kuwano (2):
  mtd: spinand: Remove write_enable_op() in markbad()
  mtd: spinand: Introduce a way to avoid raw access

 drivers/mtd/nand/spi/Makefile         |   5 +-
 drivers/mtd/nand/spi/alliancememory.c | 155 +++++
 drivers/mtd/nand/spi/ato.c            |  88 +++
 drivers/mtd/nand/spi/core.c           | 931 ++++++++++++++++++--------
 drivers/mtd/nand/spi/esmt.c           | 123 +++-
 drivers/mtd/nand/spi/foresee.c        | 107 +++
 drivers/mtd/nand/spi/gigadevice.c     |  86 ++-
 drivers/mtd/nand/spi/macronix.c       | 289 ++++++--
 drivers/mtd/nand/spi/micron.c         | 180 ++++-
 drivers/mtd/nand/spi/otp.c            | 369 ++++++++++
 drivers/mtd/nand/spi/paragon.c        |  24 +-
 drivers/mtd/nand/spi/skyhigh.c        | 149 +++++
 drivers/mtd/nand/spi/toshiba.c        |  63 +-
 drivers/mtd/nand/spi/winbond.c        | 361 +++++++++-
 drivers/mtd/nand/spi/xtx.c            |  20 +-
 drivers/spi/spi-mem.c                 |  45 +-
 include/linux/mtd/nand.h              | 157 ++++-
 include/linux/mtd/spinand.h           | 374 +++++++++--
 include/spi-mem.h                     |  93 ++-
 19 files changed, 3110 insertions(+), 509 deletions(-)
 create mode 100644 drivers/mtd/nand/spi/alliancememory.c
 create mode 100644 drivers/mtd/nand/spi/ato.c
 create mode 100644 drivers/mtd/nand/spi/foresee.c
 create mode 100644 drivers/mtd/nand/spi/otp.c
 create mode 100644 drivers/mtd/nand/spi/skyhigh.c

-- 
2.50.1

