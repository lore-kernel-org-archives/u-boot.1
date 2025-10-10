Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7582ECCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 19:09:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D50BE83FA1;
	Fri, 10 Oct 2025 21:08:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="hImhxOga";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75D0D83914; Fri, 10 Oct 2025 21:08:54 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50C2483F8C
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 21:08:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IMkrBbQrVIFdHA0Mb+g/nOiM73dixuNXmJpYBvvy11srMU0Bf82OkKzt0tOLZweU/okQPFuzMLk2/7e4rnCZR/lc/qy/sCjbVJdTcFMsqvw2cZBR9vJiE+FphdfHz1HEH1GJt0hpQqglkq73OLlQmZjVoGFF6LW8StW9k27LGdQeNO7NlkJ0BokVkTqdUpmdz62XgJQDSeGQGtpHYcE8gSGkNH5KFslAH2JIYrqYrZslIHL/urZeOkFvqRTeFNN7GgF0hjL3WNEQnAbVsl20H9vhAPnzcBBrdZAqjHO4ASv6oy7eJcmYj+leqxg9AqmCverQvJWpY5+gr1CEWHbfBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D97SPc7owhCF5YZkou4FUTV/br8fwvthXalxi1Z6fQY=;
 b=ILJeCmXIRR9PSZzdvO0xg/433f/OOngH76JrLUNCI8mC17bX93CgGRreZGSMNhP+lKv1/5UeSPGbLX3rfEGQmxNJDV5APDcPEGLAnBsBl3E9A6WEh9cg3lx8xBqyZqHTDBa60oSrgE4Mr+fzar9b4gV0g5COZK9JyzW+eKWKfE9G5KD8jlEeG5CUDqKChQiNhNANytoKI2eVdw4OWak9NTISYQY293EQXL4eUOMlatbpCenzycIbOhFEHs6F+/ri4gJLhBten7DNVAg1XBrWHUueVh6s0ompF3iqQsFcPxL0fWf15W2oh9k8hFyPqKPnIOsdLtHs8Xh3B/tXX5t/aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D97SPc7owhCF5YZkou4FUTV/br8fwvthXalxi1Z6fQY=;
 b=hImhxOgaflMufveWUN68u3AIClT53mEOf2j3+BrQ8qJFaKxY9Gk7bCRbLDsJAbJHoDDJVMMEziDQz94gn+TUUUwP83hdNtXpfybOQCcyCbD7hCSQ7kgXF9r3UX9dZU+HTolwDUQ2SKz/mpQaSVlRYX5pv1AkmFCVMgmPwbWhybk/ZEHkNO3ejNNAY1enEDm0wH6mEHFDhzsD5uEc7nKidC6/FTk/jXMu+mpjZFS8lf99sCeOahfLT2Kc70rKH4isa7vLNrWPcqxp2SoqWcqeSwPx6Ch1G1kiHbkgm0n4sY6ESrPQrrDhgCRW1nEv/pTqKfFU98N5DX+dtV8AQpoIxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB8371.eurprd08.prod.outlook.com (2603:10a6:20b:56a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 19:08:49 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 19:08:48 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 00/11] spi: airoha: driver improvements
Date: Fri, 10 Oct 2025 22:08:30 +0300
Message-ID: <20251010190841.1590130-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00014AE1.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::314) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: e167fe92-8b6c-4269-8273-08de08307118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fTx+dSaSn3xjHA7oT3TZTtP2yxcCugPgFm9TlDXPZr8oc3wx2c4p2qxatLnL?=
 =?us-ascii?Q?CkywImQMyNNcJPDCzv2IH0VgY9IZUIFPjLnfO3DvTmqj6Ekq0MLinjRyKYpn?=
 =?us-ascii?Q?cVUPzo358SFPNaTBZcjsyYslQZY7FmTPWMAwmeraRHtUs6ooVnLRLtc0ijmk?=
 =?us-ascii?Q?13oq/Bn/BGHmsj2uUlaEZeXZipqYasVGbvjIQCPlLc8z5tRQkQO0V+gJj/1T?=
 =?us-ascii?Q?yNBHR7GCw5xp4H7IAR+BwYIsbQM5MAu1jdA6GJySEYRQ6XzGAgugJ3gSqEQk?=
 =?us-ascii?Q?lBNBC9TstL4l7P2F+hSF5NsnhqEoFURTlc32gyFdMru5az1SpR5Z5QASIY/J?=
 =?us-ascii?Q?yPoHEj6aXDO8D4k/wt8KxC2P2X06SdwQADPyvtFlFgcJVfzgMVAYYfY8zAtx?=
 =?us-ascii?Q?S2WitxM2fRGcKjeqa8hbcpp1EvKOnnnl89PesrSv2BW77iXagQnKSKLkelQc?=
 =?us-ascii?Q?RWUMfqmzsXlDJjxiMpsPDzN0m8IEZmQjzpYVK3Egmf+bMojaedNd65OxlY1e?=
 =?us-ascii?Q?w4PxXzInZ7pE2juBhUeym5cJXupr7X+CFMBakx4nHMQbGQlA5x4HyForGwil?=
 =?us-ascii?Q?jkcOCRokVdj02ARqUYl+jrjOuGIGL8HK2nzJAVQEW1f8xY3HVHriPf6CLYl+?=
 =?us-ascii?Q?ncaea7Bfb+VgMBGBA1NAhtCOCzVbaxcq+6GHdwPA5ne5yCDcYDLn7pwPkUFU?=
 =?us-ascii?Q?k37UDj/0r/P3VoahTSbayC/F6G1sJZX2Nkx2vCXSfevZCI2xlP3ZhuyMh3J2?=
 =?us-ascii?Q?zm5qHoE4XTAWfj16NwOvFtxRFqbJUEAWYiYqcoyErFA948dAJAc+G8fjFzOL?=
 =?us-ascii?Q?w0aX9FQ9bJLsmaHlb+mi+RwLdpG/nDq/AKNo4DPw5DbOWBohbA22uDT4Sk4K?=
 =?us-ascii?Q?cIMAhl1NngjD1LxxwqhcBJ1H6SAxE9Hu0FWhxxTMZlbH5XconkTceospXR9v?=
 =?us-ascii?Q?xwp4zchi0U6ZT/C6CQvdGuOIkmIIbtXqecLJZ8FxlUSItFOxUSXbmSc1qFWk?=
 =?us-ascii?Q?W9uMdaXqXUQjg03cFD1bXl74Dj5O8xITUbMPm3OasM/PbXWAkL0QAZ35ZEPy?=
 =?us-ascii?Q?RUaYlRhNxxmVftK8QzquPB07eFPx4T3o3FLSjR6Zef6YM5xkohR3OC3FftlW?=
 =?us-ascii?Q?w0QZyB2Iz4cOSQHswHOlIgPLO5r+YlZ2sNW0B5a6Fsnr3N7CB0rxPxsJesqb?=
 =?us-ascii?Q?P9P/cjs6D3HANrBTrL/FuKgydK/MCcCaZoKnw+pDQ4POvu78LMPJSHWRgV5B?=
 =?us-ascii?Q?6Q8KIT010BfSnuXQ4VghSdWOGIe5errhUNgVxh1RCYepPTjfzRXXABV1VHOA?=
 =?us-ascii?Q?SRDRLopDQ3pQzdaz9+BV4mTKr5mLcakzZodx7k2guMcR+OHHmp2C6XxrwPZC?=
 =?us-ascii?Q?XIKpCiI1PUdopz3OXUpME5Sp1EXv6vF0Qhv3uTHSD0WDA73Zf2cn2yztjSfj?=
 =?us-ascii?Q?RasWDQYkod+s6LW1t3FKXtZp52BojhR+5uvkcylluo9Dffghw105Rj5mRYye?=
 =?us-ascii?Q?9UlTQSJIXQzYR3pphzayHVJij27iguxhbJPn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d/M91RCxy6KKw1SHaQmUeDol5JAmwTtSTB9YPR98gCgV2y/UfuudybVKRv7R?=
 =?us-ascii?Q?bXfyVdtTdmZJV2u/u7yAPK5uB2A+fHh1tXBv3gkcP1fC1siOIpOt9NZNYS2I?=
 =?us-ascii?Q?vZj/9cvwZb4J9d+WHRT6gZFIiA5QNaEDZ+kuUNtqj0GPO6Q3NcVqdud3Tjzr?=
 =?us-ascii?Q?4OAhjKqWrFMT900UeVUyDv6FxljUHWMe1un1A9UrKyc2sBLAgcm7AruvD6p3?=
 =?us-ascii?Q?IS32FNlZ2PogrNj3sH6oNwgQM1Lz++KmXx8IYFa2OKHSSWk/4rs+59lX9DLa?=
 =?us-ascii?Q?3rSpyWzVKx8J7PZpW8+oBD5BAuhd5u/uJYBzKWGmIOj2BsREonxQbGV/19cY?=
 =?us-ascii?Q?/Srgl7OLC1DfttlGSAxhvnOgdmJ8GTjEOkSTWvwM7MrTiEdim6WKIpkkBRWD?=
 =?us-ascii?Q?+G7XJYr6Z4NZrNI9rBeHiMXTSafvpMjsgLdCGk8gwmqc9QO7iYWeq0g3Z8N6?=
 =?us-ascii?Q?OQwGbZQH/Oe2W6FQ7Igibgirs4lqA23DAXkO9ZcIit+IqllpG+iIHL40D1TA?=
 =?us-ascii?Q?g6UXLQ6S9bLfOP4TYnjjuaNS0KrP/40NCTHvprhfDogLDsSUo6HpGjEj+Du0?=
 =?us-ascii?Q?6ZX6VXIp1CF8rdYkY67IJ5FFh0ftn8lDQSmIdNIjgED1KD3Oxm24H4nxHVBI?=
 =?us-ascii?Q?ujgSynV004cBYUOgNxyLCe9Xiy5kjCTB8Vt2C0baade2VTEz8J+X90XBqaam?=
 =?us-ascii?Q?FAd72cT6vnlwOAQgJewwmE52YN77WpfbaNQ68IiwZyaCBlgl7X0MW2bFxj37?=
 =?us-ascii?Q?FIDBpY2j67X9Nh0BBIyvV4VxZ3gFhUbBSEEoqJn/GCGlkQEK49pc6MM5iTsg?=
 =?us-ascii?Q?8BaFpyOXIgnX8owVybJlaX+z5pKv7ipEcZZEl1kCoiLaUFDEMbFau/e2+1Ia?=
 =?us-ascii?Q?+UwyRJpspniL6lJOTfsLJBvfmHJ/EcyAIRYIE8coi+Hze2ijnuHbbrHg117s?=
 =?us-ascii?Q?ViFUeauV3ifB99UQ4lXAbeGmalB6h26kJ1Fv2NPG3NlRIfLp3RFQwmaqV2td?=
 =?us-ascii?Q?7W1vExBeIPmpcAr8rV2oVZtEAvsCJujaUW00nbYCtv7C/PAHkiDQx/oA4C54?=
 =?us-ascii?Q?fdF8tYoNIpvDJT/pvfflgdBux7xuk1nDG/vpa61ZpuUJDeBzkDdXdtO06QTA?=
 =?us-ascii?Q?2f6m8j3hFXnwBY78ofoOiukQ/2zUtcJP5006z3Myn9FPE4tgQgpA3k4ER5Z/?=
 =?us-ascii?Q?7Usk+C5rDUm9bMQKSdtM2cCXxVfI5iJHrWH82XH5KPGlzeKfLBsLKMvBs+l+?=
 =?us-ascii?Q?tKkIN+a63x8qluRX6N331Z+11WGBYzh7+inWUTPuN/yC+jRE9q8h5/NtQ0WR?=
 =?us-ascii?Q?WHOzR0ietOk7TRZVQG/bvOoNduznwsJFtaUVa5WHMAjfcseO/bVO8ZFRD55W?=
 =?us-ascii?Q?bMMEFNnlC7YcKTni6wCryCyBuvTcDUjYjC5Oj7M5dj7RPjRoY82125iNH+BQ?=
 =?us-ascii?Q?Ka6vsBpnAO1BtYnCJM69AYwwQZtGfBD8DLk16VSBhjcWa7cQKB47e488XWAo?=
 =?us-ascii?Q?FfeBjg0eJY7WMNRPMqlpoo6+U7GilgQx2mRCvQs5Xora0vTDXnM+kQe96Co1?=
 =?us-ascii?Q?k05GhDHeYacTf6/5l0DvrGATsE9khSmzzYRD/ZiVfM3VIS69p9m3A79jX/+5?=
 =?us-ascii?Q?11FhH6dQbGre6q7lVwgVLeY=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e167fe92-8b6c-4269-8273-08de08307118
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 19:08:48.4499 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ie56l7Z6ZCHiiGgORxVNYdyDZAVsiIipJAwN1+vWlI6SOOtr4r55z7YnGsiQ2JP64Q6hwuxPU0FJVq45BgVnrs+uyJqgdi7IgWw/IiJk0LM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8371
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
 * dirty hack required to for both u-boot & linux was removed
 * dma support was implemented (will speedup flash reading/writing)
 * driver fixes & improvements
 * en7523 specific workaround to prevent flash data damaging if UART_TXD
   was short to GND

[WARNING]
This patch removes dirty hack used to:
 * get flash page settings from spinand driver
 * pass flash page settings to linux driver via SNFI registers

It has been proven that spinand flash page size is actually unnecessary
for driver operations. We can get all required data from dirmap requests.

NOTES:
 1) Linux kernel without fixes will be unable to use spinand flash.
    Corresponging fixes were sent to linux kernel
    (see: https://lore.kernel.org/lkml/20251010033136.1475673-1-mikhail.kshevetskiy@iopsys.eu/)
 2) OpenWRT main branch already accept corresponding linux/u-boot fixes
    (see: https://github.com/openwrt/openwrt/pull/20295)

[Benchmark]

With DMA:
  => mtd read.benchmark spi-nand0 $loadaddr 0 0x8000000
  Reading 134217728 byte(s) (65536 page(s)) at offset 0x00000000
  Read speed: 8131kiB/s

Without DMA:
  mtd read.benchmark spi-nand0 $loadaddr 0 0x8000000
  Reading 134217728 byte(s) (65536 page(s)) at offset 0x00000000
  Read speed: 2062kiB/s

Mikhail Kshevetskiy (11):
  spi: airoha: remove unnecessary operation adjust_op_size
  spi: airoha: add support of dual/quad wires spi modes to exec_op()
    handler
  spi: airoha: add dma support
  spi: airoha: support of dualio/quadio flash reading commands
  spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
  spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and
    REG_SPI_NFI_SECCUS_SIZE registers
  spi: airoha: set custom sector size equal to flash page size
  spi: airoha: avoid usage of flash specific parameters
  spi: airoha: buffer must be 0xff-ed before writing
  spi: airoha: return an error for continuous mode dirmap creation cases
  spi: airoha: en7523: workaround flash damaging if UART_TXD was short
    to GND

 drivers/spi/airoha_snfi_spi.c | 690 +++++++++++++++++++++++++++-------
 1 file changed, 548 insertions(+), 142 deletions(-)

-- 
2.51.0

