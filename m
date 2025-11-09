Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D7BCCFA13
	for <u-boot@archiver.kernel.org>; Sun,  9 Nov 2025 07:07:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E541D83EF9;
	Sun,  9 Nov 2025 08:07:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="usvcL2+y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BB3E83EC9; Sun,  9 Nov 2025 08:07:16 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A226483E8A
 for <u-boot@lists.denx.de>; Sun,  9 Nov 2025 08:07:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBG/XdbxQyrVO8H9lZHqTvh+8sc8IR+r4pFfUb9lhfr/bgmya5cHOF+Sy7qhkrDlARNKfUOa9LnUE/budYhvfHWQwa4NPxSLC0wFx9T+HlHykS73afd2eY7NzPi5Ja8/Hni5XG9vg8mqtGVa/ZD/cvk/HXdNxNv78daFL/uEZaD4er/HpPWVBlBM+WpuiNR4HpL+FQ642HoO77JDnJfvduGIirUC/nSF8JqBZ8SSW0aVhhya9GXRjzi4ThRC5XspaL74pJqLKm7pnRSKSRdT8w/jL7S9kp7NRkTMWQrf3/tx71NYbGfNyOuN8M2VvileShIzrXwny3b8Bqf6a9zLMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64x1o9ule8pksvkWXU1u2sUPq4bYCQSP99o4tdNlnYg=;
 b=w1e/M27qEOCuahmD3Qywn2+SupHUKunYyyBuLFlum76uIp/4ypaRPL5m17wyAJsqc5MQadcjBh3TFI7McsH8W54W8QT/P4ItWHnyp/XjKeA1XBkDwos2UvFx7FC3BnTJB+CW+8zkhDwrPOjEZqrX2gvShpirfL3zNQr8gxylLkJPX3IfGPfbgKxvCW7zGBFDFA5+MdSkm17TnwlJgwJ81p0KKDTqqN582uDbfOH2mT7BIoiLBPeIKj/WJNsrOJ6osnGPbtbKhp15/3pNVo7+ttWmAcEJ4yFeMT+K65YDrwkxPXiBuAIijjycPhgnA7uknO21sMGp+AAmKk9J5IShyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64x1o9ule8pksvkWXU1u2sUPq4bYCQSP99o4tdNlnYg=;
 b=usvcL2+yDxSsPTfrexewLmUi9ZDjNsAoPHCN9KWPPvghUWqtRu1N8UsGfJrJ6g2hT86FFSpKMH7ayrsNLgIHEZJhdvF4BuVVEjO2aAW2fqpf5PU5oGGcYRwCLtlYA5L6pIZEZs8MnYcPUWshAZwCz4DiNVB32zT1JccHQV6AhDaaYL5d3iyO7lohT4xiQxxxWOxBdR3zwh+OcR70PiLxT/hNZcJQamV2JcMT+XXRQzBhuFdsL3dG2GrBa38Kx22wr5bjqeqHSmy3XGfF3v3LxwftcyIvj4ZdzGYhouxpO5DMINmHWoP2mNqAUd9Pfey5qwB9stwoI9UtieUHfIThOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBBPR08MB5945.eurprd08.prod.outlook.com (2603:10a6:10:1f7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Sun, 9 Nov
 2025 07:07:08 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9298.015; Sun, 9 Nov 2025
 07:07:08 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v4 00/12] spi: airoha: driver improvements
Date: Sun,  9 Nov 2025 10:06:46 +0300
Message-ID: <20251109070659.801344-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0053.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBBPR08MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: 01e3e0f3-f849-4d1c-4922-08de1f5e9874
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XHHpsR0ZRkMn27f/bbrMzvsX7D8OM+tQ/9R76FUGJVFQbxLawrqQCyuSaxc2?=
 =?us-ascii?Q?p+ckG9LVj4uF68IQsYisTypH6zXXYRGkPfr6X82VZtSVkz/r1nfTDWS/LHg+?=
 =?us-ascii?Q?2MaMque50RAa/1RqQ9fgX+/Gs0bvyQvV6dKJDjijo3UrywrHMf/34+UqHjGu?=
 =?us-ascii?Q?qadl+0r5pty0hyyS+hjfn/N3YzX7VkJofCpROecL+nt+1PqFK1pw7bJ0U9rt?=
 =?us-ascii?Q?6Don2pRutwGcAo6Z1ZS/HFzx2YZTFdevNq+8liRYKppg0Cq/+xJ/TwXrEZT5?=
 =?us-ascii?Q?wLv9HQkyZtR8iIheWS0+PR3tloo+LxjWRJnLAQloHE9qWp84yTyl4+8kDjpv?=
 =?us-ascii?Q?Nrx1ZGwFAwJAtkgaR9T4E2XrP8A86RMzppGvFlgBP/YADV6jnfl5TJaUzaKT?=
 =?us-ascii?Q?3OnPACodM0H0xu8Q18q0rRFyLk+upOMsvigwjtPu/5s9E/F7aczPdntFNxME?=
 =?us-ascii?Q?nDt4ys454TFEVLYr5/wySYeVOXIsC7O4wiyVjdUUE2xTKUTixsSLdGswRzRd?=
 =?us-ascii?Q?bj9ZNyJtgdB6Yc1wtVwg2D3Vk+ezRWro2gjKwMO7qunzDr7I2G6/y6fMy47U?=
 =?us-ascii?Q?oPAzWUfLyMXJSiPWY4xvtqCIrOurMfnyvLGRuLmVjMvOqg2+SB0er9O4eZH8?=
 =?us-ascii?Q?AWq5dYkrjuB7AZXE5C2FOIH7gLeM74eaVuEXCo/wvBcpbfQDXUWaAblETIAu?=
 =?us-ascii?Q?DuyhL3BbjMnF488leB0Dv6hBmanoMjWWEsJBHB9A+DoYWNocrlMQpxx0Y9Z7?=
 =?us-ascii?Q?cYD7KEHUgn1eR9jFvayYS+ea9xBY3NI17lYVkRLuJrmXVWxpZil7xZRhWF1I?=
 =?us-ascii?Q?6oAhb0qNkUxhYCsmVc2X0Euj5EDXQ9+BiVC1nn44ByX7th+uVa9pl1Rgy6JC?=
 =?us-ascii?Q?NqmRgbkQTfbCyViQB+VPkoaeYRfONgBi2QGagWYEKX9uzZ8bSVzcKVwqqK2C?=
 =?us-ascii?Q?qSUzJOPXGH8uB752z5UtpMlodlY+xdJyagXkdYfzEqKx65xekv40wnO5hGUv?=
 =?us-ascii?Q?ns6CZFXZhXjLpqcqBFSKq6uQlzqLkcYfAg2obinhOuUFoveKdHe38BZcAhTi?=
 =?us-ascii?Q?LLoaWsHv+A2VEGxeVf4R7mge3qm0NNzQtaD+OUk3x0USEX6gACCfacpad1Rj?=
 =?us-ascii?Q?dfAOHT+5qs3npiQx9zmSfYLORkq+xNoZWliZTC0y7fwO7tBpChhcrRwFWHqv?=
 =?us-ascii?Q?/lSNZKPl8UHHwjAj1UPXTLgr+1QIS9VjTnW5D+WrlyfS/gqyCJKQ4NR0Q4Q8?=
 =?us-ascii?Q?89K252JcTgk/EJGm9R+r7jwpC7IKYsbTyEBDwJScPqXJ7oh5hBbobh6Nsafe?=
 =?us-ascii?Q?KUySQXiDNYEnWhvDid0yu4TCDwGAwmEJBacp4gmioTMfbuNzPGHcB/jiLqLG?=
 =?us-ascii?Q?ejbyDdlSSL967gMmKiyV7ilQ1166t3nE4cyYmpH64KnHxW8LoI8gB12qxWC1?=
 =?us-ascii?Q?zrVUXZOmJdcrFqLIcfNibwWmRmI8Oh44IRXtd8BBv4/Troz+yLDvHmvDImtt?=
 =?us-ascii?Q?O+/9p9/z+58Yy7CBg0wLaYaXrbVFWuFKbjso?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BWj3XPX3wHOh5lSUFTzFz0qYp9moIUSv3LHbdwyfJK1PznJMIMjoIkyIy4je?=
 =?us-ascii?Q?+bogFCRXvWSymVy74EERsCJKan0bdNou/bwACHLlJenLpyvLzoxp4kEVljnI?=
 =?us-ascii?Q?VnXhKbqVRau4CMvfakTcV4A5lpxEhOrLTQ3b1f5cCgNuIWo5q8IBSujsxE07?=
 =?us-ascii?Q?oDtpLQMWsQnmWu4w90Y+G9biTFeMtDwzpAhXgY8TRZhZp+RjiErIbvt3KY19?=
 =?us-ascii?Q?cfarguH1p+juM/x0J1BZrdb3OXNt9m+VA9IoajliU0rJVgUQtetXuTAudeKX?=
 =?us-ascii?Q?qyxhRajv0sL3cyqFkU0GM+ecG9x1U6GP3e8mwmY7wKx/krMlBjRfk+w+xp/u?=
 =?us-ascii?Q?K2Eupr1hE7zlt7EAZz1/LC4uJi45iTmdEe1XVr/27/JbVJTLGgkablCEinZ5?=
 =?us-ascii?Q?ksR4vs+7EoVwgIvizAMCDoC3WU/T4cUR83m4kb733//aV7LNIPRHpNmzN3t4?=
 =?us-ascii?Q?bkI+nvidowXXUYJCWIG8EVSfDnCXVRzfBYKV5fm10Y8SMvq0xyLDXzajmyWr?=
 =?us-ascii?Q?Ckq5JkvXmfmSSKoXBT0zRhrS0S8O+TXv5YR+sd3Q8VzvJsHP1WNvmy1Aa0Jj?=
 =?us-ascii?Q?EyTTrKhfNrxmn68EAiRMJFi0QLJ3xiR9CPm46w5WTWBavGKit2BhdUf650fp?=
 =?us-ascii?Q?fCAZYg84OzJ8Zv+8KfjSbmSPfIVQ+H8FynvVTPsQ8PbxP7ZOWGUKT/H1h9CH?=
 =?us-ascii?Q?PQ81tW0X39FgkrMLjtSXxh32SGqgJ0y145NQwyiKq7Y0SBid+jXTW7J73Ftm?=
 =?us-ascii?Q?sCJ9VgK2NaZoJZP7/EGtzb0dFz3ubktc6BVsgZqZIcrAhW10tJCEmJHDFXxf?=
 =?us-ascii?Q?brbuXdrSqim1uTV3TB89xIU3CUK1BU5O31TqQhuTqdpkvB4nFmtH54sLXdIm?=
 =?us-ascii?Q?sQAX0QPcYV+ERUHz1ptZaDH5h87v3bt6druZ5GpRvxJyCUWXAaxnj0PdGH+G?=
 =?us-ascii?Q?+naMXynVseki80XIfOZxpCknnUAaXzgJ66vklP5WtWQxjs3tRe09Awd3pLaK?=
 =?us-ascii?Q?wRfn6E/Vtqw/DCm82pbKXYSR4BYyZvU3LQuOy+aaguoWBxmK5AFDprVVCnTj?=
 =?us-ascii?Q?aVcZp7xU9rl5HtsGO2zvILH8sTei2nh4B64Slv+oDx7RM2TDsVhFWtNzCWWc?=
 =?us-ascii?Q?suMl+6NjQY2j8YWIS7cxQviwuh8YmWziKno2TuYiU9tmRmD/vNa0z7D09V3C?=
 =?us-ascii?Q?xx1wiKZFn0a1sfIvTGhtAxIIatzy0J8DtIaV9t/feH6F131+1m6SDtgZzxmA?=
 =?us-ascii?Q?E+Juz0TZNeBUn3UQ2rS/qRoAfpFVEOevltXm1nqTlvaZu6xbUY+e+qE7I8W6?=
 =?us-ascii?Q?DvJ6M7e4ZIYD0Cmm0dNf9yADhoo50whnWnywzx4wWj3vVHU/ovZaU29gNEhR?=
 =?us-ascii?Q?TS9dSns3OGxq2d8JHEFR9xMynF6cRztQ/T8Vy2LxU4FyIZAcjoIxRwcmbJh1?=
 =?us-ascii?Q?jZyjJHLc85dBeUcE1qfCbSMIRZLXOWEt0PvK37/7P8BIkorrPgifMlQi8DHi?=
 =?us-ascii?Q?tiW0t3SH5cerhjcPBdiMj6n04R+MK/CNFfRacOLA2ZDtUhwY8UYrdk9dQBkx?=
 =?us-ascii?Q?PBQ7RfWx+komIQfVcqrG/Y86GViQ+kIvb6bMzkerXBgW38g19HINo9JTEmXC?=
 =?us-ascii?Q?PA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e3e0f3-f849-4d1c-4922-08de1f5e9874
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2025 07:07:08.2126 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 52mSf4+I8BYF7DgOyY68opTv8uDM8O8iIt9JLx8tHq3ROlQefpLZCJdWhSb+faz5q3dsUTfnn7Zo+OxPybUdTj/Dd9cjbxKQKNAP6ISL5jw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5945
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

Features:
 * driver fixes & improvements
 * dma support was implemented (will speedup flash reading/writing)
 * spinand flash page size dirty hack required for old linux kernel was
   removed, corresponding fixes were accepted to linux-next and openwrt
   main
 * en7523 specific workaround to prevent flash data damaging if UART_TXD
   was short to GND

[General notes]

The patch series can be split on 3 parts:
 * fixes + DMA acceleration (patches 1--7)
 * removing of spinand flash page size dirty hack (patches 8--11)
 * en7523 specific hack to avoid flash damaging (patch 12)

[Benchmark]

With DMA:
  => mtd read.benchmark spi-nand0 $loadaddr 0 0x8000000
  Reading 134217728 byte(s) (65536 page(s)) at offset 0x00000000
  Read speed: 8131kiB/s

Without DMA:
  mtd read.benchmark spi-nand0 $loadaddr 0 0x8000000
  Reading 134217728 byte(s) (65536 page(s)) at offset 0x00000000
  Read speed: 2062kiB/s

[BIG FAT WARNING]
There is a dirty hack within linux airoha-snfi driver (linux < 6.19).
The driver needs to know an actual value of spinand page size. The driver
can't obtain it from either the spinand request or the spinand driver
itself. So on start linux driver reads SNFI registers to get spinand
page size value used by the bootloader (u-boot airoha-snfi driver).

Luckilly there is a better way to resolve an issue. It has been proven
that spinand flash page size is actually unnecessary for driver operations.
We can get all required data from dirmap requests.

The Linux side of an issue was fixed in
 * linux-next (will appear in linux-6.19,
   see: https://lore.kernel.org/lkml/20251012121707.2296160-1-mikhail.kshevetskiy@iopsys.eu/)
 * openwrt main (will appear in the next release of OpenWRT,
   see: https://github.com/openwrt/openwrt/pull/20295)

The patches 7--10 removes U-Boot side of the above hack. Unfortunately old
or unpatched linux < 6.19 may be unable to read/write flash properly if
patched bootloader was used to boot a device. This should not be a real
issue as most users will use openwrt main (already fixed).

Changes v2:
 * use 'airoha,en7523-snand' compatible check to activate reserved mode boot hack

Changes v3:
 * reorder patches, so fixes and DMA changes goes first
 * write a better cover letter

Changes v4:
 * update description of dirty hack used by linux airoha-snfi driver
 * enable double speed reading of the flash on EN7523 SoC

Mikhail Kshevetskiy (12):
  spi: airoha: remove unnecessary operation adjust_op_size
  spi: airoha: add support of dual/quad wires spi modes to exec_op()
    handler
  spi: airoha: add dma support
  spi: airoha: return an error for continuous mode dirmap creation cases
  spi: airoha: support of dualio/quadio flash reading commands
  spi: airoha: buffer must be 0xff-ed before writing
  dts: airoha: en7523: enable double speed flash reading
  spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
  spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and
    REG_SPI_NFI_SECCUS_SIZE registers
  spi: airoha: set custom sector size equal to flash page size
  spi: airoha: avoid usage of flash specific parameters
  spi: airoha: en7523: workaround flash damaging if UART_TXD was short
    to GND

 arch/arm/dts/en7523-u-boot.dtsi |   2 +-
 drivers/spi/airoha_snfi_spi.c   | 688 +++++++++++++++++++++++++-------
 2 files changed, 547 insertions(+), 143 deletions(-)

-- 
2.51.0

