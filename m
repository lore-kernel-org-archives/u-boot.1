Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BEF1CA0FED
	for <u-boot@archiver.kernel.org>; Tue, 26 Aug 2025 19:21:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 947CD830B3;
	Tue, 26 Aug 2025 21:21:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="RXKHkZYn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1DD68309D; Tue, 26 Aug 2025 21:21:45 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43A588311B
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 21:21:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aKwz7OfHDEaLpqV+2Gr+Rdj5srHDCKQviLCiDAt1sduCfxShTKq3z4qzwkhsWYiGg8uL0dZv4vBvXQrGZ/UHbU7EXWbTpdO9XTSSkP+pktd40LKUx1iHFVEGPT3KjTlJigeIXRErtvrULHg5t8wPV+Ucs81uH2m3Np8EGmRHBKpaRNiz/K3dvfml2nTJ+RwvTsxpCu2d1z6dRE+65ZwM+WffvaNS0Qek1Spg8GEzK5fUjwLiRnAA+IKxbVy581hB5yvbcdc4Up+I2Jwr06tOKFjT+vm8sb1OL1y1PT7t/UYApt/Uu2D8AsBbtiCjz+FKSlI7VHy73rhA/vrycniiAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqJ4C8pfdh8DjxIyIH0Va0P1EQiCGGPA72Zt9CBKTRo=;
 b=DAVuYu2dff1l2xG2zHjY9Ox7TRpzNu8Eu00SMy9kPo75dVZYQ/9M0QdFqIqC/UZukPzZqfyjy6pYVJwv/PTYcv/Wk0iVQzAw2hD8bLtNI7K4zeNSsMinOrKYROlRCWjI9BT/03dI5ghMWcLd82DUeoqDh+1jIEkVw3CAr0paseO2dw158+Mq/fHGsIgWSPLUOWH0DPl2uwrhvM8Zl4oYWdyHkPYbL7XsH8Vie5MpVdtjacHRpJV5miOEM/ltgFOXMfWibWvpzuBOE4Ik+iZhAYKFM0UiNPszjvTVsejEXCUO6FaGW1kjhM5Ok8ymGnbOyWduqAF/lWnWXC+x5H2saQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqJ4C8pfdh8DjxIyIH0Va0P1EQiCGGPA72Zt9CBKTRo=;
 b=RXKHkZYnji5Ia1ptD5I6CSYfLsugCSA1C0PuqwdslhmB/FnyD3799HxHABqX1d9Il/SdwmX+QG6aho2mAnLVv25MxRZVfhVB3jyEp2GHXFHy09M4F3kktMfO+liB7wPcgNdd6b2a4TVk8R5W/OlsW/JTiIR7FqJ8iC/Z8N35ap/JDYns8aNw+ygC84bLgWGlJgR1cZXIq6TxI0E7XlocYLh4yhRzUZCNCTbpdjm1T0N7RoMmv6P7N87sJc6SjeAiZ62nHoVvy2Bj4Kl3E+5F41YbkHQXYylYkID/xuNE0gAbTxmbd5F4oIJW8AqWUJVVaGn0wAjeZTsm5So58nvhNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB7910.eurprd08.prod.outlook.com (2603:10a6:20b:50b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 19:21:41 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Tue, 26 Aug 2025
 19:21:40 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2] cmd: mtd: fix speed measurement in the speed benchmark
Date: Tue, 26 Aug 2025 22:21:31 +0300
Message-ID: <20250826192131.340354-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <87bjo22knk.fsf@bootlin.com>
References: <87bjo22knk.fsf@bootlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0272.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::13) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: e52d3ec4-8639-4745-ab0e-08dde4d5c872
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mfcF8POxnDxeurAuJpG3H+D8Zg1yKVxGxwFWdvtkXzieEmd4q3x00H+cWbk4?=
 =?us-ascii?Q?3gPnBC+9wAEOcF6ZF4Sk+SD97zT6Uqw81FubI32iwuaNhxmu5WLnyXaAPJus?=
 =?us-ascii?Q?z6NAjEC1ylyvbz0j1HGaM63hD+qEBAMIT31DuHr6fvFPzVLZGx0LbvN+S1tg?=
 =?us-ascii?Q?K3idKODerqISQRPlzOOCuedEwDb8PrNAbV/xq9XCnLpQEeDvvoaZgsU40K1a?=
 =?us-ascii?Q?b7EtJ7/iH1ryH/8L8qyhHPOxWYFW9Qh9vzQ+mvS868swbT82grCzm36pLVGM?=
 =?us-ascii?Q?iNc/kJZaNWuZa7W22B8VeiX0NX3bhVAFTpXMUlb+ZQLmz+wpa6X1DYFkgVAV?=
 =?us-ascii?Q?g5XXa+yaqP7qlY8+oy335LghHgBcmA9HGShs2mF8VlvFV+EhuFTiwdjHQ5Qo?=
 =?us-ascii?Q?Ia+2BpRJSzv8mQiGsoA3bIyJSHf5DcRzjpluDLFww7XujjRIhZRhSMRmBCN0?=
 =?us-ascii?Q?sJqPe1JObc2wy6c5LrVppo30THr5rLMxfSvduFlvEi0Tn1N0RuGEPjqVBcCQ?=
 =?us-ascii?Q?5oeDz2RH9LWU40QTyKsH+xoAF84zuSMpcYJw7Zp8xoxLznP5EFwLYMlrsqXh?=
 =?us-ascii?Q?nw5FZMzSSv843fI94SwaIb1hHVZCAvn6nbHRn/yMhIoAKtRlB44jEAHNjAiK?=
 =?us-ascii?Q?XFtovOx6tkslXC6Xj+4XqysgHR6DwwDKdmuZe8FI33pUrTC8whzT5xMLOqKJ?=
 =?us-ascii?Q?jd0JF6AzSlMJrgIomB/zbvDWu89hyqPsSyPbqj3VCg/nbqdRiMN5yWGq1di1?=
 =?us-ascii?Q?GU5Vwz1ta/TenVd/GDw4913dh9YauBmT0PT1WfDCvA004wEJsQCc8FTMvrmb?=
 =?us-ascii?Q?iFxtsAl6lG3YqWUSvq2akF39LMxZPS7cJ4d1+42XI6kcQkc1ZcdDytPZOkwy?=
 =?us-ascii?Q?UzRoXRpcNDdNt4x9/6TXHzyRZuZB0RJoFIy142WUUMMd9DULfJzNtqINGTKx?=
 =?us-ascii?Q?3BNWasdhdvOoaqoQhXYjqQSh+J8pTnGPXZMZPVDSv7HoV8cZryrWPfOoljOv?=
 =?us-ascii?Q?+57QovZt7cIMQjrqddKJATdLN5o5xuQAvkR9f5p572p9nzYZ4AkptlTT29Gb?=
 =?us-ascii?Q?AySij1JHq1AADH+ymAIkLtsIkGvGtJG/KhICkSf5OdqJ1cb5qp4jDRwmy/LX?=
 =?us-ascii?Q?mY/GeWr2rVb3OzYNQGe0XIoLoI/IRc+4MSH622RkJQtTH9o+/avWxUAhAZKe?=
 =?us-ascii?Q?Yj4JW3yig+dff+7FnfvGTVVJy5Jz1HkIeojefh2Rhp/fMPjCfZI7VMmTDkfs?=
 =?us-ascii?Q?M+MfcP1hvflTrd9bgFofWiNmVkG+tW6wYI9MnUq2gzrdybzmSkHlp51S6FdH?=
 =?us-ascii?Q?FCxIlLlEIVVbCyi/L3W0nH/oS7socynlrsEa5LDeUPbBUk75YP7lLgB1+Eun?=
 =?us-ascii?Q?sK7WihSL90oEEdotBHX4ptlq2C3z3ZbzC/Nfv6i1KMsoK/5JUBDDHzr6fDeX?=
 =?us-ascii?Q?v8CFqBHMOMfmQu/+PQNhykLcjFDws3DZBg9wg6S8C7Nlt1vzL9UEyA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xr7xzPM7uVWAw30SxeBrrc8MUcTyEXZdrA4sXXEIDhxqLXVcZNledfrWC9ES?=
 =?us-ascii?Q?0HeKosD0iNPfT2gyICqx4UOwQ0ebzPjVADvBst5E+D/EPHJRRRMTLKdK1i7p?=
 =?us-ascii?Q?63lTpGJhXBcrwq0okDpnLWqy+reDxrEtTOq/7EuvE946EqUdUXHJAsn5VQfB?=
 =?us-ascii?Q?dBLyyUizDJwEa8ojIxrFXA+U86eSB+6zMALt362wFVmmKiJoK144hxCCxKeU?=
 =?us-ascii?Q?1UfROwzvg3/yKJYDx8utklR5lWo/h8/2t83lXPIeABf5P4iHNj8Lf6Uy+t9T?=
 =?us-ascii?Q?9A/D+kioUz1+v6wVEgWoFJcmtb5nfdkIGss20IbzImyvTaylUM1RiZMjxjYD?=
 =?us-ascii?Q?ObB8Qm3YdGChz0sjbbD4ZOeVjVVbfxAEQ0Lr2yix5H+ToAVWq+KLQnK5lklW?=
 =?us-ascii?Q?5Sg7x/ZqZVPNtm3pFqx4PZXBgDGcP9RJFf6mtkQX2g92I6XjOJdmn+cjPVol?=
 =?us-ascii?Q?DyxYlo2ybUhiPQellukchNmParM94frmbBoj3KGS/YL+5Tbk32chYccvokLo?=
 =?us-ascii?Q?d0BzYy+fe4KuQz7pRw8Hu37N7teRBf+vSnI46rM8UegpR3koLo7HjgNxEU+U?=
 =?us-ascii?Q?3i/841YeBgO3ErhEh+ShNVG4V+HfS9IDFUKc12g6aVr9sdvyD0JbVx16kjEG?=
 =?us-ascii?Q?SgYEoFRjZpNcQN0saRu1DEnPEzVZ0w0453DzGsmlzYYvabD8gcbuk43+DyzM?=
 =?us-ascii?Q?ZdVinFkp2txoNC165MMAUEOUOQUVKnlGNzzUg4ffxMbQjkaDMG58kyezfX66?=
 =?us-ascii?Q?/EgH6Db7lfm9RFV/cOuZV6FNto5ymUQg9E4ee5rxEh3H7mZWbsFV7mKXNMPI?=
 =?us-ascii?Q?QaNQWORZ65sf41VRf9SlOu/KAjGWKGLqne1iRcMeAcHvf+MxuM6eAhPlNWrp?=
 =?us-ascii?Q?ET3vPS/hwNyomfyZ5pAgcjzrvh6TliKHi2gbKUPkoRlm8ODDRmLDcg/VWpfY?=
 =?us-ascii?Q?Feyf1wnUS2ljKq7Tgs6m+RIv90ECL5eAZXaKcrpSmImBVAqB+zbH0xt/n9pa?=
 =?us-ascii?Q?eMaW7zXma4t5gAcnhioiPLmzwVeRbK6R9i+4kWt+RDVnfxuugbrAGPe1OGO/?=
 =?us-ascii?Q?7MPzMEzl2Lgywqy4AhgHWgtT9QkliN/mZ8FWAdpbTHvzKMtKRBQzSIuyrJNm?=
 =?us-ascii?Q?OHycIlZyJ/jlmUP+7bAVz1HCiXFT24QIATq2CFPuwSQO0U/CR1nkC1iT6wDQ?=
 =?us-ascii?Q?tQyrSIIeOmZ2L0/MbSw6Mmg52nnLd9P/ykbwE9Zk7MOQk/e0LqQMtEkwvBGh?=
 =?us-ascii?Q?nlgAe4Z+dzhdsxKYoN/jr+iTa6JG8QZWZlw/8iWm52xKC3F2Ej+r/7aG804b?=
 =?us-ascii?Q?9XoszVVdRPq43e4x2lgpjQAIWvuPFyLDDgSUhYGKIuEas3No4W2y87G+m6xM?=
 =?us-ascii?Q?fK6Yz7vryPIdWpu7MxveIGDDw23WRGvFA88rN5XJ6vCqOhuDd6BWGxLgeL11?=
 =?us-ascii?Q?rCNoldADzFBmZ5j+ttJygqzb9/7ptWXphnA50jBl2RmLqEx6SkgY2WdBCwXD?=
 =?us-ascii?Q?Fsev78GJ38b73Ky77/BzUf9PX7ZN5k2wnYvYVb5dRfUl3h/cXb7ixWXGZVxA?=
 =?us-ascii?Q?CGCSVKk9igmAiFRrza41rMS6IMlwRFAjx3vetg8lR8qhPW1oHmiHUpDmDmnR?=
 =?us-ascii?Q?v5Rd6INzFxq/uJ9LVeX9OsA=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e52d3ec4-8639-4745-ab0e-08dde4d5c872
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 19:21:40.4003 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1habk5RuuO2e4sGprVezbvx9WxTNE5RdEfkCW+030RoZou8qwABWkVcO4aAS81SzrGne1LusD7M2Vm0GkE1h3JBgppDpBJ2nuL01szlpOD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7910
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

The shown speed inversely proportional to the data size.
See the output:

  spi-nand: spi_nand nand@0: Micron SPI NAND was found.
  spi-nand: spi_nand nand@0: 256 MiB, block size: 128 KiB, page size: 2048, OOB size: 128
  ...
  => mtd read.benchmark spi-nand0 $loadaddr 0 0x40000
  Reading 262144 byte(s) (128 page(s)) at offset 0x00000000
  Read speed: 63kiB/s
  => mtd read.benchmark spi-nand0 $loadaddr 0 0x20000
  Reading 131072 byte(s) (64 page(s)) at offset 0x00000000
  Read speed: 127kiB/s
  => mtd read.benchmark spi-nand0 $loadaddr 0 0x10000
  Reading 65536 byte(s) (32 page(s)) at offset 0x00000000
  Read speed: 254kiB/s

In the spi-nand case 'io_op.len' is not always the same as 'len', thus
we are using the wrong amount of data to derive the speed.

The patch also updates the help for 'mtd read' command to show the presence
of the benchmark option. The help for the 'mtd write' command help has not
been changed to fit 80 character width restriction.

Fixes: d246e70cf81d0 ("cmd: mtd: Enable speed benchmarking")
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 cmd/mtd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

Changes v2:
 * update commit message
 * 'Fixes:' tag was added
 * calculate speed a bit more precisely using a 64-bit math

diff --git a/cmd/mtd.c b/cmd/mtd.c
index cee3a7e43ef..7e022fdc0f7 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -469,7 +469,7 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 		     char *const argv[])
 {
 	bool dump, read, raw, woob, benchmark, write_empty_pages, has_pages = false;
-	u64 start_off, off, len, remaining, default_len;
+	u64 start_off, off, len, remaining, default_len, speed;
 	unsigned long bench_start, bench_end;
 	struct mtd_oob_ops io_op = {};
 	uint user_addr = 0, npages;
@@ -595,9 +595,10 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	if (benchmark && bench_start) {
 		bench_end = timer_get_us();
+		speed = (len * 1000000) / (bench_end - bench_start);
 		printf("%s speed: %lukiB/s\n",
 		       read ? "Read" : "Write",
-		       ((io_op.len * 1000000) / (bench_end - bench_start)) / 1024);
+		       (unsigned long)(speed / 1024));
 	}
 
 	led_activity_off();
@@ -1210,7 +1211,7 @@ static int mtd_name_complete(int argc, char *const argv[], char last_char,
 U_BOOT_LONGHELP(mtd,
 	"- generic operations on memory technology devices\n\n"
 	"mtd list\n"
-	"mtd read[.raw][.oob]                  <name> <addr> [<off> [<size>]]\n"
+	"mtd read[.raw][.oob][.benchmark]      <name> <addr> [<off> [<size>]]\n"
 	"mtd dump[.raw][.oob]                  <name>        [<off> [<size>]]\n"
 	"mtd write[.raw][.oob][.dontskipff]    <name> <addr> [<off> [<size>]]\n"
 	"mtd erase[.dontskipbad]               <name>        [<off> [<size>]]\n"
-- 
2.50.1

