Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C9FCA0FFD
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 07:55:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7B88834AD;
	Fri, 29 Aug 2025 09:55:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Ij4n8CRJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74FF783544; Fri, 29 Aug 2025 09:55:47 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74F7D83487
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 09:55:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=loETocaIIxUTuxYFL0sT78u0D1hWKQdGtTXd/qiuwZVIKJZ5WVjeGEyWuI9Ym88B3UbxTsUrh/OmNQbHlU2POlGqZmbAvMNtfxc432MjWd5ay4YW+kem+1g4Jk4TQYgxio4F0yVnlfeauqttTvGc9PMAmiYkEI9g14CCdBrocWa76kTIMJB9LTJScmeMu/fOCao5xa7bzpZ7HK4lyFiGSKSOP3QxEuNMUUaVqR8yIkSS0JNnox30xf3uWr6Yxqi4NeZv7l0QGOOmfWyHyGT2p14LK/DQX7y273Hto5vRjLkJ08lSUX6lFP+1cYn+nKCioQAtHvxTG5ls2kpwQBxb5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KrMoXT3wErUaRnaBMHwLhRWmoi46zEf51AniGlHid8=;
 b=VL78h/LeeCioas2uufdDnHw0mOjHSLEYHB1FD/F7Hr3b3/MJw+YeO6lErAb9HxcZiR+LHJpahhepDepuzImSvxSRNfY7eh8sIuMjvYMSM067qWz1DGv8u6t5LgDMJhs7oHb0iV01jMEiaqK06ftdlPLkbdYhRwJBw0hDGNS9SMJ/B2Af5C+HbLe8oLZqhg+tYqAnJBxR3NrjrsN+tv2IcJ3BDI8qpnR49BeYIU0eYo1gRiVnVwIZTJY9bzBoiP6XInY0/6vf6Nny/9pBPujMsnd5PuhNZC79SAwhMuTnkviC0lxcNle1klnM5iqyif8tfeVt6jb0geevvBF6zhyJZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KrMoXT3wErUaRnaBMHwLhRWmoi46zEf51AniGlHid8=;
 b=Ij4n8CRJt4LGpJufm+8Ix/MWP726OvnxMchLJ36D3NEyNBY7fSsmv1V97cAzydNB2EpPBKY62ijtXcjtAP979V8iXknaFuc36j1Esa9vOWxEeIGHD8msocOhvhr9SGQehxe7vOLKQhY77IjAD9Z2PtVVdst4NEj5+45gD5kiNZOR6XUk6vtKQWrOZF0JMzG+Z3NN0uoNa3/0jWDrvnkv8Azo19C8QnWaLwxeHJmBlUO76JYcpW1rCzrIustBiloXwAf5CiR3GwyfFFHwqKOvrEQIvG2UBYJ1xs5Hp8cKthih3w9Cep/ei+XaFvdgE/ucRytUhYEnaLlPJOh3T+5kuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI0PR08MB10425.eurprd08.prod.outlook.com (2603:10a6:800:20e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Fri, 29 Aug
 2025 07:55:43 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Fri, 29 Aug 2025
 07:55:43 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 2/2] cmd: mtd: fix speed measurement in the speed benchmark
Date: Fri, 29 Aug 2025 10:55:34 +0300
Message-ID: <20250829075534.2895148-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250829075534.2895148-1-mikhail.kshevetskiy@iopsys.eu>
References: <87tt1r6api.fsf@bootlin.com>
 <20250829075534.2895148-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00014AFB.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::30d) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI0PR08MB10425:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a4f9a4d-5086-4974-bd55-08dde6d17420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|1800799024|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bO4x3/JNGa5jrAljwKI4kfIuax6ndUlons15y4rsFs3x6NcxdKKekeHOLrRA?=
 =?us-ascii?Q?n524a72jXwaJUob4kGcL6gl01/B30WJ8tIUfr5ct+hL/1x/5QkMfZt3hHi3F?=
 =?us-ascii?Q?C0CpWBUmTGSOmhh+b16SW8D8KiWxcgcOgXSokv9JVga9Gpp+R0jmKYXjyRkr?=
 =?us-ascii?Q?Xg0bx9nt/Ybhulun/dfKmsKk9cSy9vfs6g9X+qWKatPmCw85Noi4poBhsaE9?=
 =?us-ascii?Q?VbaxWKjCGhEvqP2ppTymmgQXZE6fE4p6ZOt8pIUYj/RyKaLgwXjMwFtmBEK3?=
 =?us-ascii?Q?s+G9dTqD3gkxeppJ7HsuBPMkCcNBVjRsYjEniM6VA/Pdhgw+Xwuy++asn8U3?=
 =?us-ascii?Q?4OJkRauI/Z3UdiaqA0vSoieB4iSKpjHXsLUZ+e2ewgE5tiv3Wgrhd7QHnBEf?=
 =?us-ascii?Q?jLKCh/mNwx2aLw5AFG9Y5Iq5M+uJPboRd20PWw/zKfjyyZ3ijHqX6YnLZIji?=
 =?us-ascii?Q?8pf3rXFi1KAdoOd1BtfVnUODiNgGyKF/oZI9bmrbtUOQP8Hp14MLkKO0Tnbt?=
 =?us-ascii?Q?9eF17i09FWSiWuYI5iqVjGld1OwLGlGidU+pi9glbo2x3k5gs6lYAk6YTEzU?=
 =?us-ascii?Q?ZbT3u+cfLwpE8ME8QOj8yJSRYp6Gl65OQCCo6tBPorbkk6z+0GCHj+QDqqlu?=
 =?us-ascii?Q?OZyjf3TaNMiHhiFr6lTyW0oY/vIt/8iZpJCtQ++SOT2dzeqmhHrI+Qfau9Hx?=
 =?us-ascii?Q?FjgBGJwE1JjKs0W4GjKW0cWqOYyqzMnFeY5DWL8xSoFSav00RzaNukO1/62l?=
 =?us-ascii?Q?MNHYVxMBWd0x+LQEwTM7fw9rm/Pe3S/SL+qcRjtd22otbErnrp+kb/ttSTdJ?=
 =?us-ascii?Q?d1DCYxToNJ49fdkc7I/t511vOeBWktEhTHtGCPs13nyYrdS5skcS1FXL3GRj?=
 =?us-ascii?Q?h3OYL6QM/XRj/OTmVmWQFZA6KprvXj9sSi8Hs5T5hIcOUgxPVO8hnhGLao+S?=
 =?us-ascii?Q?2QJFM9+OOtN8X3L7MbiJQJcaeTuB7dRgNrqIizY0sKlLrsJzOty/zusad+Fd?=
 =?us-ascii?Q?K+aZYwCXELdB69NUaiW5pGqL47bINhZd9tDPwRwJA7fGGNZaPV5YXb71XJDp?=
 =?us-ascii?Q?ihlW4IJqDu1xZxo1N6XISl7gGrfOOso3Vq17o5V5K3LZzBdaquCt5l9B6+M5?=
 =?us-ascii?Q?k/mp1c6u5hqsvxdd+qoHBfnWDVF5Xm6+drpU+MWjTTqj5uvsvjEAlT5oMxBF?=
 =?us-ascii?Q?Pk5mLbsXCTIdDtWbaOulETuNvb4mJlOErfBiPFPSELH0Pz6u3pRCU27EuQI2?=
 =?us-ascii?Q?EL0c74b63du9dnmZjZBDfyewK3fegX6afbVgr0NNT+YjB0HE1Hs5lwh79M1q?=
 =?us-ascii?Q?+A2AE7c19za4Umh1IReENtFrHX+AJaO0z5O4zA5IJNc+8kPQ0bFo3LR7yevz?=
 =?us-ascii?Q?3/JZNhmxFZCxEWAQ0wv0tt5hgIx7xcQDbm1I7e//E6cZuk/bFjOZlSejK3XK?=
 =?us-ascii?Q?ZsbAZCYSESR2sDaCJQYEB/xcPz+6nziy0TS+K5PW4IfnkSTgO3uHow=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ctOkDrywkzrXxNUk30abaN4fZkLi3eOaoi1DZs9pPHvn8FqnFxvTka21Q/hD?=
 =?us-ascii?Q?GUv74nboynlRtHfvtsRNnGukhPL/Nd1EIHrojtRL2h2AFsW0xOfGxEVVOulZ?=
 =?us-ascii?Q?8MVZebzB5c88ehU1k9y6U1rc14AL1gCnO4vDASVk9jaG48RRhdTz92b2N2G/?=
 =?us-ascii?Q?38faDa4U3N+a+FJQdo6C6BQVB6mXmYxPPprfx7SgKtGxOh+Siwn34htrdR4l?=
 =?us-ascii?Q?TibekY7cXPVR8I1z95MqYTbdpNDxMLPi2KsQ6mbi9TlKjnm/IXb4RItag3+R?=
 =?us-ascii?Q?5Zj3CTWfeFGCnzyy2DZjgQtT0Pn0kmi++oXwO+7cw6jLRUvtxB8fSkoo4bNo?=
 =?us-ascii?Q?D6tjqfaRLb8AV8AoQw5SQta+hqoKSvC9uLS9NIoqO/XqLfbV8Yy4BHJs5lim?=
 =?us-ascii?Q?m/mizzQbGbYsO5JR8fwyutdt4E6owf0AxwKYqZwM3Y6Q9pXTvqMsDd8BekmQ?=
 =?us-ascii?Q?fEIPZwqH6WYCWiMVYrtBppa/qPrR5PApF3JzMOUk4f9JVmpt0e+soIcvsXj+?=
 =?us-ascii?Q?BSHFPCBis79zBmyKB+r1hTe5oSaZwo/QG6klnQJTfLo8jCuKhKZ+o+b5D3pk?=
 =?us-ascii?Q?aZ7+Ka97g0DvbaElEzTYyvJaJCBdNeQeYeaB0sCUzNs1KQHe9IJ96uiR+Aob?=
 =?us-ascii?Q?9VBciYkKHGtzww2NGnrPKIp0r/NY6qLsdQtMgdUgUmAjQqQxPgAFKDkUz4CY?=
 =?us-ascii?Q?03cFYk9Z2RNvh87LJialaXJNjF/FwkucA8bl3OJbeZlcPn5fQMiFRi34+sKj?=
 =?us-ascii?Q?du+8YrQaT0sFxE55jM9xum+4eFc6qVKXYCYsoB5ccd5eh542kqcBeNtLWq/O?=
 =?us-ascii?Q?GrEDG67pkMnNvmFgThj8cYVDciBFIRb59vvW3U7MlZr/oqDi/JNL17Oa4s/M?=
 =?us-ascii?Q?8R8rRV7z5jVgcGw1Vg/yJ/9LBGRz32+yJJQqQccmoiK3O00pqwmQ1O/aRwdL?=
 =?us-ascii?Q?YjwnOn5eoYIckBgk/em6QAkibTVk7Je4So9bnvmGMnMKHgvjeDklpjADcm2k?=
 =?us-ascii?Q?8/67I2xgmR9qJboLhws1qU5IKMkk7ZKZOsmBAYIOgaN/kpRw40GGj5syr4H3?=
 =?us-ascii?Q?fpZYlN3BX9RK7ij+MnBxF/MpXduV2vBLMDSWcWkIgH1ZhHaK0YA1ct6TW4JY?=
 =?us-ascii?Q?+nzPC1+rCdKh5kzxKsk/Fqzc+QNAxL32a5LvxOCIUNNRXZpuBKYpIsM1G+YH?=
 =?us-ascii?Q?7HUmb266M5nZmHksSnQ8uFYZBuIb8vevfh86B1es0G04qurZjgLpKbQFWDZK?=
 =?us-ascii?Q?mN+N/oWRuE9lxlbBCRNNjODwrd1vTgyUy/fzL40SPUZg8jBDGidLTxfEExCl?=
 =?us-ascii?Q?/t27J4i4VMEsrSxqAkOjWzP2rZsCv/91aLkiZ3tgs77Vcld2CggXFEQE6FUb?=
 =?us-ascii?Q?qQoqn6iko4wHBES89i10pqnuPLT2xlNzMX70xHK5NSmGTBWtA8p20Pk3T7OD?=
 =?us-ascii?Q?x/LmwvD4xnFXYo+GeEPp959oJXUSEP8JtaTz5qDAWuIEqzDwkA3OJ3cG3eDW?=
 =?us-ascii?Q?TD4iKD6aCGrJNbmhtYHLLOA/6yvYPSi2VuWGM0bme9KS5PHHw4vv/PzYUFMc?=
 =?us-ascii?Q?I9iSCe4zrsAmPUcCYcTfCYBi2ySrf/Vg+7/c6DpAKTkfO5hzwA0DQRnpln29?=
 =?us-ascii?Q?wzoqQRmCx+GZ75rDlnPLrPQ=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4f9a4d-5086-4974-bd55-08dde6d17420
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 07:55:42.9550 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 09o1gn98gSjFFDI8I8TGRBBNOjuJtHDXb16i+JZqBVN33VwQNZj5ILelFUjILCu6PR1fWe4SSD0hTwna1GKFy1M+067Rb6r1XLa/0GfCcK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10425
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

The shown speed is inversely proportional to the data size.
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

Also make sure we are using 64-bit calculation to get a more precise
results.

Fixes: d246e70cf81d0 ("cmd: mtd: Enable speed benchmarking")
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 cmd/mtd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/cmd/mtd.c b/cmd/mtd.c
index 2520b89eed2..57f6c700f1d 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -468,7 +468,7 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 		     char *const argv[])
 {
 	bool dump, read, raw, woob, benchmark, write_empty_pages, has_pages = false;
-	u64 start_off, off, len, remaining, default_len;
+	u64 start_off, off, len, remaining, default_len, speed;
 	unsigned long bench_start, bench_end;
 	struct mtd_oob_ops io_op = {};
 	uint user_addr = 0, npages;
@@ -594,9 +594,10 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	if (benchmark && bench_start) {
 		bench_end = timer_get_us();
+		speed = (len * 1000000) / (bench_end - bench_start);
 		printf("%s speed: %lukiB/s\n",
 		       read ? "Read" : "Write",
-		       ((io_op.len * 1000000) / (bench_end - bench_start)) / 1024);
+		       (unsigned long)(speed / 1024));
 	}
 
 	led_activity_off();
-- 
2.50.1

