Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EE8CCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 16:28:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBC0583771;
	Tue, 28 Oct 2025 17:28:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="JksA/D4E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37CF08382E; Tue, 28 Oct 2025 17:28:41 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9E06836D3
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 17:28:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQb1WfvT1DmjrNrftXbqJbiAe2P3DQ/vOsMKoo/phVE9rJuM5cDrttgD1SoDQnzzfuEo7hDrTjSuBf+99dlCVupob5HMACYaUXVjYeIoV6gzgqvtGJhzaAu5zk241BIPStMKflFF2pfoZp0AL5gLSAcka9pJyttBOoZDM+moKhU38lQxzj00U0QczJviemBKZ4g+iwU/Vs7gxZZo9wwLZj3mo0OdyYdV6B87jFPNF70pRj9gHWbkk0SGSUMT3+XOIoE37p4vqjJqip6QYjQ2Zz4WGLNWJXKWYM8UDIPWc58lyZrLr1GeZIuTh8g+hAwUlDNYkiVMoaDwgoGezpxgug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8UWcozyBpzuuD50mpUVZWawmlG9pmweTLH0ORIT7BA=;
 b=zMgH0ldBt9Je+eO1iO6kJZspJKwKAqqPRBqf2C34Liy58x4SyeWYM0zzKUSOkiqkgvUv7eIa24HdYkz1b5SgwJ1pAUATWFRKdSDt6XpZJ4VbuqPhQeYrUGGmlXvBKddGwLiZrc0yzDY4hA3k4Syzf1FyctvwC24bJCZ/z/9pKKOjD2zQp8iEWX9TnpfwojX0lBP0ls8fXhOByxNB7Fvvo7Sq1xyYjgjr1y6BZF9DrfC+5jCnJ4nawGAxRrPZSBi+8iJ1EnMfFmIY0kOPQRihosf8tkeV64fOQhYw9/+vl4baksIU5BneDdFKRijvnBQjrD4UL7f7RoWdG0a3oTVdBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8UWcozyBpzuuD50mpUVZWawmlG9pmweTLH0ORIT7BA=;
 b=JksA/D4EbMpRotYGwxSPFU/mGs0gfo6XWqyu6gaio6U7Bc9mZaNH+EXCszQbEw5GyhtVPxNpv8xBSaLj/32NX/oGN6sl9y1l8p8oJGctF3swDyPlQDZJ/r7IS86nxeuTa3SlnOaJ0vZWGOEdRu/4LkasH7u1vchZSn5/9j021Muh8nlzrHuQNKfETGMQ3uLnbMEL07IRDtqEDkyidntbkEEkjKCQdnYDsqlTpaSs6+LFakfLevXzWKDdwqUc1HWJD3Ka6QLJcBNzfkC1+9kd9RODTpKRelmfI8Yl5DvG02zZXUzIK20HHdD/hH4SF9ZxJQz7bDPQe6Tr/3onUZhv6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by MRWPR08MB11233.eurprd08.prod.outlook.com (2603:10a6:501:77::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 28 Oct
 2025 16:28:35 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 16:28:34 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v3 00/11] spi: airoha: driver improvements
Date: Tue, 28 Oct 2025 19:28:14 +0300
Message-ID: <20251028162825.3353166-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::11) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|MRWPR08MB11233:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f58bd40-58e1-48f8-dae3-08de163f0a15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DFgiUiVKy9XC0hCRnqNxOfQA8V54zPzVIVi5wNU1PqOakJrJ7WqqBO+JwZUX?=
 =?us-ascii?Q?Prq79HNzbwI05tRZOv+jUO8EkO7W3h5hNatdaf+NFpph9ToICSqvmaDF9LI3?=
 =?us-ascii?Q?V9LWgS4fUHtvQUlkeOqSqEUTDlGWPHCdo3QRP3++VPfySwW9mjMHjedoQRGJ?=
 =?us-ascii?Q?UV2csvWJPwJL9wPz5h/cqKznxHgvjdadiet7ChVk8bEuvrSpk7EoHLvWy9Gf?=
 =?us-ascii?Q?khxa6LKcGsSmDVuqX6AlCpjNHAEgiqDlULIgAuNXhqYTJfjK8lILaDsP49Lc?=
 =?us-ascii?Q?LqUBY22t360Ep6cUOnwwneRmXdt6dObHTuxITHATEdMx0ZDk9QtevagJUKU+?=
 =?us-ascii?Q?KbGleZ7QTSVeIy8Arzl4kvbJlXpuM9ZSo0Qej12AaaJD+Hfuj5VF1gvAsBHj?=
 =?us-ascii?Q?pd0cM1D0PEMeUeF3YBgO8pW39rPiCIvn9LLHZ6HpV74taCxzKzETnovJHPoV?=
 =?us-ascii?Q?g0cK7VBHfTFekMd57+btJjS33IgQVZhemL0TjJDOwxG+S0xGgxgyROM7MoVo?=
 =?us-ascii?Q?ThDY60dG0C29f5Nifsu1jvJcZG8chWEJ1mSGzIjJ9ILjvg2TNaFvHelg1fk4?=
 =?us-ascii?Q?xol+BE7YlVc2MnB7AGEHwzyv2ALxhqyrRP/f+Q5O/EnEaOpDywLMbiB5LvnM?=
 =?us-ascii?Q?GyFzIPRvnLVGVJuDWcG9K7oG/PGwyje/+5o3I0zB2fGvhe50QfAnxVZ8GbOs?=
 =?us-ascii?Q?cwOIoI9YrK52uVJ5tN704vw9VLo9FFmkiQAmPhOC82NQqd6VD6+/MPK/SeEF?=
 =?us-ascii?Q?7JguP0R8qHANWdt5RCEIWb/ZpDGPNlf4L7wfUye3/C7wNnQ9GgYuQQW0nq2p?=
 =?us-ascii?Q?mM8iYcdhSjKE/7l3qP0coOzckNhVkEpWTdLbcUaZpz9PTxdVvomHzNOvl7Es?=
 =?us-ascii?Q?2nA7lcq85CDZ6gPU1trWPhhetgVQFy249hvR0nldoIJwqRcLYiTOS0htDcM/?=
 =?us-ascii?Q?1Zf/v2VCGbnujgVPQ9ueCpXCOQWS0grB+wVc3FCkyCe4SYPhJIKCQDaZcPVT?=
 =?us-ascii?Q?3rs2w6ybDyqeZ4kCsRgOUWXQUgn6em8iqrK8t8WvFGEswjHbj+nZoUfQsdmw?=
 =?us-ascii?Q?1aWwLcjbI3d7nC/0VSvxhR2Br6e1LpqHgE9me+8q8TKcmwL6Wu6BxhbzFD0d?=
 =?us-ascii?Q?iQqXxnTrHF5FqIlP8wI0x+ET2ad0zU9WFYp5A39zRKnEUJ3nMpIbQXXvmnSL?=
 =?us-ascii?Q?FSlnN/Iw6dpSdV+S3GfsXFDytzE0OByqQcLWCEzAYTFuP393qLsjyOB39FYs?=
 =?us-ascii?Q?gaa/SArjNKm7p1sIkqRkcrwRP6YpGWa0otQQulEIh2ugUoo/Y9XJk5fvmYpz?=
 =?us-ascii?Q?2/TfA98OIOREN8Rp6dwpOBFYDS7XYcaOniIX/vhjVaD+5IYMnBPoqElIH4+V?=
 =?us-ascii?Q?rbjlEIax32yfSDVbHQjD2jfgv0iYhaXztcFFpY0/TwEHiSCzx6YsF/psQQa9?=
 =?us-ascii?Q?F8BklJOFeS5M3qdYw5L+S1YGj0nl4jY7/rFQl01Wxv1QZXp5LvxylQzQl05x?=
 =?us-ascii?Q?d3HYjcQVUd2ngX9W8g+5EbVcmdAaJv+a2lO1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kbfciLsF5QT8Uc/7II+/c3fuWDZAA9nPeocnq7VoRlaZm+9EeUkUZ9ojltQD?=
 =?us-ascii?Q?wJLLr5XsYEWMxblCvPsNMeGdLQ2ECqQ9UKDTdIUnqZo4/FBKuULyaFnzqP2+?=
 =?us-ascii?Q?/BSSPKhryyC0HN5Ub3qDSTEQ1oOR9ekU2G/fegCV4Roba2n0uGbWzQtvlx1B?=
 =?us-ascii?Q?KPDrpi+CAlQG2q2eCC5sjKRcicX+LjmLWBGc/u7AwnKW7kvdAXgJbE4tcf5F?=
 =?us-ascii?Q?k4hHYkH8vbS1pCta69cd5iSsIQorzlCu/Udchj/WsBXc458x+aFiya9CoTvW?=
 =?us-ascii?Q?6QbEGJwA/B7gosaSK4jzbofCjwXuN9oBtnrgf5lRtKMXUtXjY9iwn8jUo7A6?=
 =?us-ascii?Q?1ojsvC55UjXiS1lEEXPQENmaSfZdxaQQPDzwMRgFDgp7GtLiqmFUVapAksot?=
 =?us-ascii?Q?zkPMxoG2uCl1dcY3PDYtomOJrmC/mRhC+0fjpdKl0fU9VlKjOtaLkwPLwfbR?=
 =?us-ascii?Q?IjwE9wbTdpejf9DW/lkfz+2T9aDkUXzDfiKA2Ghomqz1qSUW2xVuCnd0NxtO?=
 =?us-ascii?Q?tPEN1ZGGPiWaHVLJkG0qdJ461lzlk+RVW4a5kP/Ju5ZbmrhCBezf39f6C91t?=
 =?us-ascii?Q?8610Mfqg4Ry+2BkscrGtAM31PyP94AlOzKEKdjBSzL4urBLkstxiIs9pD02u?=
 =?us-ascii?Q?BwjpDDqy44Q4GQc6SewHdZ0vht7Hx/ij6NQU18bQ2zsyRPPwtlCql5gfo8LS?=
 =?us-ascii?Q?zVL6r0yB99t38vjHr5XmT3uPnbqiludKld0bzFngGhpm098tyBfYkQeThIeG?=
 =?us-ascii?Q?IfFmD9Q0qW8fw49pQl42QHeh0AnERzprjDPcQfwjIml8PZbElNFSYbXZflxO?=
 =?us-ascii?Q?UR2GvM18StSZBeL5KkTkiZFlS4yRSV/7Ke9RxdgPssnOLyGS2Ms30yiwaLmk?=
 =?us-ascii?Q?BMN5DlpL43KaPBmskFuU1c1CB0XOT7/D3E87rDWf3RotGJIOad9g1KggwiDH?=
 =?us-ascii?Q?MzV1wAuNaPGpnV740ZvkCU66G2eWuSfZ9A8O5Y/TxzDE7Xb2rLTtJttIvBxo?=
 =?us-ascii?Q?MudgO2sRW4QeK4RC6SsbQj1JH8JltBVqJbcuBzxIDhxgTdmZjYimcElm7PP/?=
 =?us-ascii?Q?XWtJFsLDojEUPa8E19LqDXxn/NNmYnZdmxGXwimCEWY7b6i4fm2kRd7XhnHH?=
 =?us-ascii?Q?BZMedFFn9jv9MLCFb6sUh3+xeJU+MsNRuOlI5mxql9Hf3tNqQU1YFfwLhvza?=
 =?us-ascii?Q?skgQzMfSd1RzlUUm0AXXQKXKIcwI/HbgpNuDtjmoE7dhwdOXICDpdr64eGHA?=
 =?us-ascii?Q?x/PwrYPZVpTpCwG730ijvZEWX1e4F7N+ZXR2HF4W5+82Q2pWnG5iAIsSOMKF?=
 =?us-ascii?Q?4FF0J6dIAgcTQCCgELIoVcIeTWtloxDEL9finIjX0+Sy7i68uWmNZHy6/v61?=
 =?us-ascii?Q?SBQPDM+fMw5GM9ZjiTDhBQxGM7qG04Lwx4EshdGab7zcycFfoRk+a2vkcuTs?=
 =?us-ascii?Q?eeaIfThiaU+AK05gQypQHwpssnal+FBI1bAQSNWBI1JTBS+B2q/EG+yHBhdW?=
 =?us-ascii?Q?ehqIj4ULHdsRAoEfsZydancXXMO5mGnNdcV8kdAoo7r1zpROGiK8du/S5a4O?=
 =?us-ascii?Q?JBwHRPaW25sar0NYDILi0CNNYqyxQcMnvH6YsPn1Bqle8sFbnvK3CNGTjPbZ?=
 =?us-ascii?Q?ww=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f58bd40-58e1-48f8-dae3-08de163f0a15
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 16:28:34.4509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xUXKZd71o6IeZvcl+8s/C8W39gxs/eg81Vi94i5d/tMux2LmnsdUvcHgHvGl9uMNpivBZ8LckmcmJQ8fwH9RP9sgE70e5Cqs2z9xmilSLE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR08MB11233
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
 * fixes + DMA acceleration (patches 1--6)
 * removing of spinand flash page size dirty hack (patches 7--10)
 * en7523 specific hack to avoid flash damaging

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
There is a bug within linux airoha-snfi driver (linux < 6.19). The actual
value of s?pinand page size is required for flash operations. The linux
driver can't obtain it from either the spinand request or the spinand
driver itself.

The issue was resolved with the following dirty hack:
 * The bootloader (u-boot) knows the flash page settings and store it
   in the SNFI registers REG_SPI_NFI_CON and REG_SPI_NFI_SECCUS_SIZE.
 * This registers are not cleared during linux boot, so linux airoha-snfi
   driver is able to read them during startup.
 * Driver reads data from SNFI registers and uses collected flash page
   settings for DMA acceleration.
 * Almost anybody happy... if this specific bootloader is used.

Luckilly there is a better way to resolve an issue. It has been proven
that spinand flash page size is actually unnecessary for driver operations.
We can get all required data from dirmap requests.

The fixes for an issue was accepted to
 * linux-next (will appear in linux-6.19,
   see: https://lore.kernel.org/lkml/20251012121707.2296160-1-mikhail.kshevetskiy@iopsys.eu/)
 * openwrt main (will appear in the next release of OpenWRT,
   see: https://github.com/openwrt/openwrt/pull/20295)

This series fixes an U-Boot side of the issue. Unfortunately old or unpatched
linux < 6.19 may be unable to read/write flash properly if new bootloader was
used to boot a device.

This should not be a real issue as most users will use openwrt 

Changes v2:
 * use 'airoha,en7523-snand' compatible check to activate reserved mode boot hack

Changes v3:
 * reorder patches, so fixes and DMA changes goes first
 * write a better cover letter

Mikhail Kshevetskiy (11):
  spi: airoha: remove unnecessary operation adjust_op_size
  spi: airoha: add support of dual/quad wires spi modes to exec_op()
    handler
  spi: airoha: add dma support
  spi: airoha: return an error for continuous mode dirmap creation cases
  spi: airoha: support of dualio/quadio flash reading commands
  spi: airoha: buffer must be 0xff-ed before writing
  spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
  spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and
    REG_SPI_NFI_SECCUS_SIZE registers
  spi: airoha: set custom sector size equal to flash page size
  spi: airoha: avoid usage of flash specific parameters
  spi: airoha: en7523: workaround flash damaging if UART_TXD was short
    to GND

 drivers/spi/airoha_snfi_spi.c | 688 +++++++++++++++++++++++++++-------
 1 file changed, 546 insertions(+), 142 deletions(-)

-- 
2.51.0

