Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9BA7CA0EC6
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 10:06:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F058C801DD;
	Mon, 18 Aug 2025 12:06:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="r1lFLUqY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4895880B9B; Mon, 18 Aug 2025 12:06:29 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5FBE80107
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 12:06:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MvYKTOWWPUr3cSc6i+mOs9tzERcur6lJEKtHCwxPDZc126MXLcp811IjUEzK08CVBoWFpfkDTvTHBXy3GyN7dxDbGjdi9Qp8M/pPFEGdzT6PdFas4oXmUn17J8W/rB1TVaMre2i+SRAhMaNABuEuHO3gFa7IhxDU2wXT6O4seBQ/yP0PNYr56hZPkwfwSXFwtDjTBldaZPkRKppQqSA2T27mw4KjIZrckKvsJ8KtexYrQlAwPye+qtfUQ/6apBcNYMBKb30VmGT3HX1GBZ364QppTWSLXv88D1UO6qtgud0LNXbRJ+s9Stqgry1PKOIjWchQGO2hGEAOsO0TA27x7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=571RCEmU9xWytpbFuQvguFarb33zTd5/AvjfV0EwRpc=;
 b=Zig5ZyzqayvW+3aTn/2poFWk4DdB3Ioe0fRVSG0uV1ul818Rmy1x9qNOupIUdFIO4GxET4xlKrn6tOo4fv03iUZv5M8pzSp6A+aM/jjimi/qq+wcKuqdOCuMCh4zZTLT4Yn8j9NVUQ2WjZcMoITFVO0ORnHm9nxLvmuI3+u2ZPhV4/962lNIOxeFPuaM8BsvQXW4mhQ20osht6PMsOwLG+GlY2Y5O80npI7/bEy4bU3V2bjKvUqEkfbM4dkr6bQ6ze3fth3wQwxn5CgdLLAt0msnmR4mgn0/ldUcHJLWTsfbhi401mcxXpdjwVqk8aPlqtBh6JTPHpWaBrkpr2jSGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=571RCEmU9xWytpbFuQvguFarb33zTd5/AvjfV0EwRpc=;
 b=r1lFLUqYnvAi/G8PyDuan7LrnZTVWTaZqYx+n3xC2Kg+t+MtU5SJCXyHGDObBNWGHuqqjPthXmVDopwl8ocsacEsJjxjNOQ2Yl4xJrLL4tUqYiQhsnrSelK8LisT9I7ujTIguuR++WNK6zgGkp5KSzmtMa0E83MBGP7aLf3iHoj6qJ+/8EYA60oiKOHVXsuEkhF3KIafPN+5ZsFxALgKucFuBHUWBv81POTGK65viKME39fUgRhrKiVUh2cKdT7qe3YES0wUhchv3knZvAo6/g78aHTyPjUA+BEATpSl9xJPDTK9NLsoZZ6cJqw6CQc5GRVvr4aTYWpc/C8V0Fp0og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB9719.eurprd08.prod.outlook.com (2603:10a6:20b:615::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 10:06:24 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Mon, 18 Aug 2025
 10:06:24 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v6 00/21] mtd: spinand: driver improvements
Date: Mon, 18 Aug 2025 13:05:52 +0300
Message-ID: <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002E2E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB9719:EE_
X-MS-Office365-Filtering-Correlation-Id: cf97a7d7-4494-4352-e1af-08ddde3ee31f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JhRdd+dcPlw/1otDXC8inwIEXC+VROkOpkgDDdb6msmcnFIcev5IKf6JgrEm?=
 =?us-ascii?Q?GyXl+LwQ0zvcUlhs/XDCLs/MQLKfxYDArOeSmQWZdqUHaPhYIUNCB+8W6US8?=
 =?us-ascii?Q?N+P7+z8NlAipQ1B0Mazgjhz9zG0nSuNSGKzrsLbGl5x2D8G8tnbQPRN790n5?=
 =?us-ascii?Q?lyKsFwzqciDaAgt02Np0Otaycz5KJq6juexlt4QrLKsgeWJRe3BOCAijWIin?=
 =?us-ascii?Q?0/EGLVaf6rhg3Nv8mZwrCvrq8R0i6E8Bqh/hHY6J7RpIowkHFXV179aOipdV?=
 =?us-ascii?Q?yWlmXBDuKN9ezALID7ipSBZh32rTM+iFOPzSr9aPAIkvqoTPG4efMY9/L9aU?=
 =?us-ascii?Q?OtN4MEJnUMGqKrgyzF4mUtz+z95RmvIWkzFmwDJWQkCslQv/N01MGl/aaCxV?=
 =?us-ascii?Q?8dQ8J6d64zARXBRt+6clQ/lcp96kHHLri1bLKsdqzJV4OGQC1TVbRKS0V5gz?=
 =?us-ascii?Q?ntwvu01i/U/2hR2OqE640qN5qTgoUyUNWFdjI0bji27vxxb8z4LJ3RI0AnHE?=
 =?us-ascii?Q?qyMKHaMbfV02/79PYd/ziXgGvZm/geGe7XVWsuXP0oNRSVqgi4ewVrB5WXgI?=
 =?us-ascii?Q?IMTv/+EuoXyoXb5zfHTOrgexfVdYslSeYAYlTJCzjtVlQNHCnBNGCtsaKrhy?=
 =?us-ascii?Q?WeDfV7cG3iUjSLqaHUdJ5ZQGCXIH2GGiGHwLzDwoGBfHrL6fCce9WpDEWsMS?=
 =?us-ascii?Q?lV4qmnl+azfgN1Lj0zF8yfV1+52ZGwsPqnnowSc/wlePqZlcHuzS6hOKjFc0?=
 =?us-ascii?Q?PyaxX8k7wQxoyQjqB39QLlotKpqWMHr/U12KDkQKarvtvnY+Qs8lGKvSMd32?=
 =?us-ascii?Q?9k8m5t83DEQAPW+nqX52oQP5WAsZ6LCM2Mj6qJWnDn4BdFe3di4j/rdedu/Y?=
 =?us-ascii?Q?qJraDM2BfqI8ZNDSPJr/fGSPtI0EDoekqhG3lpFI+9gM597Zjt6dxuu1fP/b?=
 =?us-ascii?Q?cgATgUSxanLx5wjxYYqFmU9Pjf29Jyx+cb1EGD5fszq1J+vgJvu6iYBO4CaC?=
 =?us-ascii?Q?rJrjrr9s/pHumgfNtHiYlx4PJiYnnMe9vy684JWKEfLHc+92N3vxnIlSN2Fg?=
 =?us-ascii?Q?emRDlCS9cbvWGyv0y7PZbQeHfsGnfAx0XjnbflGn/m6hUD+XRJmHnW8jOZ6q?=
 =?us-ascii?Q?NcI1kSu+qcKVOLBauc8lVRRoBxEHnH4538/pLP9Eiq4Oo7Gp+uUebKHseWkm?=
 =?us-ascii?Q?0ewuT2ZuSUQmlVdmS/iHkbIibqi0FqKXVnW/s8GIKwJLDXgG/R0PLl64xDcp?=
 =?us-ascii?Q?HuysTBkPwosT+Dqx8+iODLoSS/bW7bnnGYNkP4x+iPC/ogiskq/ZAkhYhzO+?=
 =?us-ascii?Q?lUOzqtNU2jAQq4IrPXvLQQTZexuxxXgUGkjhPgmmWmH8uIFpGflXoWm2zqwY?=
 =?us-ascii?Q?jl4lgNY64fnwlSYiJkU9NRtgQssEf3M2slBUmKzMy9mAsT0vV9PL338LGjek?=
 =?us-ascii?Q?R6Vod7pVV04GGC5PWVTKobZoav/Wq+W2CBsIixz2lHmlQRh3ws41FvuOD2Lw?=
 =?us-ascii?Q?kWMnC3HcaBXWmHw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aiy0QIFM+kLnd/g6natMDhEP2SkWy2z/ESfaBgZUSC1i4KQQwTwwG1whMg/A?=
 =?us-ascii?Q?vQZHVLrTshY1jrvBNuUCvBcl1Jij+tclu8KiXpvzWXtOQxC+e85bTpdwqsFL?=
 =?us-ascii?Q?Hc8N5y07Zl5qlSaYVvXbVSSQTzHJG53KsJ6tdMR4e70B5ClAvZ4O5AR39i7j?=
 =?us-ascii?Q?5LiT20ZrZHEKvyU3fNBoIBVgb/ogJ6WcWx5tft1ibGKbfeSeWyFnF/u7kIta?=
 =?us-ascii?Q?2paisJQ/QOX2ZX+CAAFL0pDNQcSn+Ewp2t74BRB+/eBmQN/oYcjc5FfLShLU?=
 =?us-ascii?Q?BH47twg/VDhZBTOp51ldkUupUm8fSI1rP+3WQ7DQynG9cunyG/pBqB8jQ0GM?=
 =?us-ascii?Q?zOCGWKIm12rFP7TjRr6w6Ui4UCm5w1PqOP3q4zwRZy/+x3mQFQXhtPe60YT4?=
 =?us-ascii?Q?HxtIy4NuwXRSt6jO+M5iWimG5F7RJHim4/UOgYdlZsH0PrQg/tYiTY7uzBiF?=
 =?us-ascii?Q?2mzrzCW4tKqokcBD0xP4Ru0Tlk9ZdmHcmMJqw/EfPqcWIICVwZzk5hr9gjLn?=
 =?us-ascii?Q?7YKcOnExR9fZ8RBpmtXiSGMxH9npairoAnWornrDvkViUR2kFqeCxeWYVmSy?=
 =?us-ascii?Q?Wb1sAH2cIFU38R0we3HkKKd8+kl79T6TKBA2bWIP7Wb9z/1m/TB8Q008DbmR?=
 =?us-ascii?Q?w9g6KnI9J8U2Wg51Nt6xCVvfHFSfZG4sUB63bINU3nUJzphWRbjV+dfChrZq?=
 =?us-ascii?Q?1hMfH8pEebt8+karSfvntmqhtjEjv9VKtalDk4PYWrA7m1wo+FYZPxfBuhLJ?=
 =?us-ascii?Q?4Oyi5bdNdBmEUYkiOQQ9BZJOpwEAqNT6L6ijcGY2BwEGU3yOqHSFiMKTZNyH?=
 =?us-ascii?Q?w0eyYooRYaNYrcKgDiS73XLl9MVsgbkFMKWIgFgw9VVpfJ2brDGMK9tsDMSn?=
 =?us-ascii?Q?Nnv5bf7ItRnp9zg/4K5qEnx6yjXKX9jDzgD0H0hdnZQGWVoambHYvjdf4QkE?=
 =?us-ascii?Q?Sj7IBF/4GP8SHFkdD6Iy2Jublh5+SLeCjdgyoZAXj1DZH/nAip+t/Ctqnp6h?=
 =?us-ascii?Q?JdBLMTz5KVXUr1ixERFmtV4u+S9mMMZP69VWuCLV+7Hmowsg/RCfFUDsUWYN?=
 =?us-ascii?Q?xkjey0fEDYvryLlJzCTVSnQHVd98yl38JGZ2Xl/35TeOo4HR4+adz1FHEpqw?=
 =?us-ascii?Q?VGKNRyoSX6s6adCmQuoDoYD9EK2vHTcRAKFNSlLYsEUmlWJt46lPe6hGWBWx?=
 =?us-ascii?Q?nPbtwOh2CrbaGnD6Qq2Q23UMOTRwhAYuEhTr6uzAanUqt7T6/MG8Q92yFtdD?=
 =?us-ascii?Q?7w/ueW+gjnjI0PInVepEl41MlSdof9WKxpp5M9icc4oL4wUPSpYTEoOxnME4?=
 =?us-ascii?Q?i307ELEy30zUzOJi7bY53xIqtIO/+7rECwoTHJi1XOyp5aa/fCwTurob3O/X?=
 =?us-ascii?Q?Zwo2HzAMzf7JpzBCFSajzOH20equGEXbgydkElW6brJjl4leQHgjcEJdzCIh?=
 =?us-ascii?Q?oILXFLkqMfmJqhHBv3S/xFrOmRKb9pLY9UXdcSrM+lFiPNtqc4Hg4I3zGSsw?=
 =?us-ascii?Q?xUuZwLU1NTHFiU5nzK4w9LoEfgng3U9aY9pIh3NqkItTZQw0zgPf1nuBH9PU?=
 =?us-ascii?Q?cC+K3XLD9o6NYutC0Bdj5kCKbtnP/vW15xWRvh56AlaZX38lHnVM62y6ZFBB?=
 =?us-ascii?Q?xUlZf+tU1+CxURLHhp9EK64=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: cf97a7d7-4494-4352-e1af-08ddde3ee31f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 10:06:24.0307 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JT2chIx6/oQMwoNRSnYNweS8B+At6FQeVVc5GdECcv66fStcYd2BpJOwfCAXpl0hEUYXzB6PGl8ar/oeCvOuj+S0Oh7azvpjWbK2TNvGSZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9719
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

Changes v6:
 * improve patch messages


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

