Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BECCA0FF9
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 07:59:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A1358354B;
	Fri, 29 Aug 2025 09:59:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="dSgbvzwm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8537E835CD; Fri, 29 Aug 2025 09:59:28 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B6C18354B
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 09:59:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVqKsdxLIa7P4/C+wE2UIxSxfzHSwqr0tkei59QAU1RkJxyWiCTvviB+p06lWvp4YXqa7avja/pvME4jRlVnbDoTgLCX2ByK4kcNp/qksG5W8c6LYJFIlY+MO0NP7758GvKPfkn3PhF3dmzUDXvfr92xepjMqG6MxD5Dooi5Ke5zePsisahvDXxDKCuZyoFBrfnH1gyKIAJSsZNpkq+nUUseP5htB1Vm6Ynq042+fvUwYtB7px2/c1MKQFJaRB3vfXfJ8IwCDrX6rq4cSOgmVa4QhOqjwfaPPLUmOnfX+2kqDTWxkjSlZFqGoXDTJqLl1Icks02LJ9SxaVf7w/tv1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KrMoXT3wErUaRnaBMHwLhRWmoi46zEf51AniGlHid8=;
 b=QRMMiLJRtShMqlY2BKKbnGYAwP9rss31GadaQqv9AfUw5SXbEvht18hM2RxvTNplmAUde4s9L8vcoRVo1JYCj2k9coSaGTujxrK/bPx1P+QYdcvbWsypRYnSGnS5pq470Lu+uNBZPm3ykkR8cc3Kqu3dP0PLfbqtlWpXvZo6mqkom3rsNFSAZCJ96wd3mL39Kxuje9VKENRCJLvt8xP4KCQwWj+QcvMYJw6p6laqojFtCFSkmcJKyZOB9j9pXxY8bwgBdhifezMiWQFoSyYI7Vt8JaktLaMGs4GJGnsQvYJ6UsFHaBDjTfBCQ8ZmNUr653jYfRHMguyRD1MHvU2ruw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KrMoXT3wErUaRnaBMHwLhRWmoi46zEf51AniGlHid8=;
 b=dSgbvzwmEzqqR/zYjW1gtqILcdmRoumUL4eDFY7CSBdqrtQmgyiAPw+Dpq7pwdBVJa/ECt+FJ0vkNmMoCC8bFk+aANDWfPjzQ5Ur0Y1OC/Is7HKATAp+LL9ZexjU4BhPoMAX/dTJCcjP4tnBoptWaTEfLrI7WwUAgYWeLeCA6bCwmF1d/iY+HNDFxHmgd94MymZCcUKHwj3bMjo5BaDuz26OXjsLaECZPTAa8BRQG6pvEsv8+3wrYwtBhUIGLMLyquM/IHFyOiAa0tfsaIo+pKINM5sxjQoxsKKaSY+4WXafJSAgjbhyaQVy0w3Vdl4HsF9P3Mh/jYoIEcZbYQeDYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBBPR08MB10590.eurprd08.prod.outlook.com (2603:10a6:10:52c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Fri, 29 Aug
 2025 07:59:21 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Fri, 29 Aug 2025
 07:59:20 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v5 1/2] cmd: mtd: fix speed measurement in the speed benchmark
Date: Fri, 29 Aug 2025 10:59:10 +0300
Message-ID: <20250829075911.2895683-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250829075911.2895683-1-mikhail.kshevetskiy@iopsys.eu>
References: <87tt1r6api.fsf@bootlin.com>
 <20250829075911.2895683-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0196.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::18) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBBPR08MB10590:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aee978b-13e4-4f3c-4540-08dde6d1f5b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PBR212+67Sr4sa8Keh6QtRIVL0FU0+oMoQF8C6iEdvjxoshYmUS7/rPxOr9I?=
 =?us-ascii?Q?M6lvWu3euPX6o/3xC18zwTHXMGMhpZiFvyjBfaz4NtOYYb3LEvThIdtWzEvX?=
 =?us-ascii?Q?v/R8GquE2dSz86TOWVGqI6ZMA8+/PzklO1yASWqaohSTYafSm7UBanWONLLm?=
 =?us-ascii?Q?1/s2A3JVUwqhJKnzzjMB3QQnEZx3IJMHBvJSLFtc9WqtND1EtYs/7HhzBMTD?=
 =?us-ascii?Q?1THujBhXmIgLP5ED2gLphQ5xl7a8BNbIxQQu8AP9e4XvIDdMYHn484qN/cPO?=
 =?us-ascii?Q?kqDcGl9ezeu+9WkRnUFDH0Pmw+mpA7iSyr/4H9Mp2wRZ/ZzjiQrS373eLN2f?=
 =?us-ascii?Q?60tcGj+Lq9OVFpejBAetI3gw9cCM5dpbBe0ZUY4OT50AzHtRmG1CL4KLexbe?=
 =?us-ascii?Q?YKcx3oJ+h5XEoroDl7FZSSBMNkPNOoyeWujssAFp2g9/IvO12LABDHGeProH?=
 =?us-ascii?Q?g7WwP9saslPYjd/2HX1mTgfcpOlvzpF4KDrTQ8BA0sN2SznFIjB2Vz0143cp?=
 =?us-ascii?Q?Wdk2bGIAPUfuVZ/JaYOajA7W4jCmPj878gP0kg4J5nF6yvWpOGAbX/TY3vaU?=
 =?us-ascii?Q?8vHvZzx88C32CGIy7EEnEvCCpSJyOvm9bA2R169nOe907RKH9KTr60pDNFqU?=
 =?us-ascii?Q?f1+dR/IUHuehNgmuR/WRsqmPKaMgasAjEa+fBlIuM4mjd7ulicsbFu60IHlU?=
 =?us-ascii?Q?P1WXDFoVgk4D6ZONAdjtiheBzx7JuVZK4UBQ2RXhmjC5UGPBAtaWV3prTx5D?=
 =?us-ascii?Q?zNmIM39Vzfx99dQDbbaXwBYDOmq8gUR9STbn1T+bPYVpHhHjCUmw1WFAPI5P?=
 =?us-ascii?Q?Y9F/uWQAHlIUsNB/NfkaXSouah9nOMJJ7aPrd0pbtrYC77qPjOVDpw+RIko5?=
 =?us-ascii?Q?R/259/vpMHcdMlFwr50mfxpTYW20JwBCSOnUrWIIMXPWp+p6udOqELmC6Z8F?=
 =?us-ascii?Q?VxA7wn4FXvpN5TMmTNLVcsMRpP1H8TbX7L7RJFkaWedSyF3K+usAS4E+EVR6?=
 =?us-ascii?Q?JdVHigZmrMo3gbQNOrOJC3gQdoa8kgwhXNQijRb73MpKFTfnneQvOLdqr+nt?=
 =?us-ascii?Q?TWPWyN721S3fG6xqE1hvqjhXqj1tKwm/Al+/d2XWGdQ06oKdYNteHe98qX+a?=
 =?us-ascii?Q?YG+hAjNzlXFrGsUUbsKOkbX01VpvoxRaaH8I9HHTJJUAX+d7jiT6RUT391wz?=
 =?us-ascii?Q?+290MZyeseP4Uo3v5ta1YotlA7dij0r1dC/qjqbv6A78CwZb38ZTP9tRLpA2?=
 =?us-ascii?Q?jQtqMQTq9DEXQo71kjSaxRCKyJEgFrsp9ZsRLfXmD0mDembvlWzJKbty7Rx5?=
 =?us-ascii?Q?kZuA2Cbk8X/V92YYAV5AdkRVeB1WZpuuFKTWnoMMt49jX5TWPPNDi9tjWgQE?=
 =?us-ascii?Q?fclRbv3ny3xf6JFiXe5pIuY/SiCBQs4VKaHC7RUbPw6sJCRKzJFyxKd8ZaDZ?=
 =?us-ascii?Q?VecT3e5YmxdmIH4WNrqNcNsYsANb1zby5Y7diQGyuRs1XKHSitrVMA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7cCar9g86rqsXA8HSl6T7Un06sVgBM/bA/VSKrTJWBESL4fc3r1Hqa+M/BP2?=
 =?us-ascii?Q?02uIeJXlcpOIEqGYJI/1v66SKtz+6IJlwEB8l2aiqFEF+oeQcwa8CTTD3pQW?=
 =?us-ascii?Q?R1dylexctut5JZexAKeSvbFSniKotwcAh38y1yhaSuhaPLFVqFnmub6gJxGe?=
 =?us-ascii?Q?NWltQZy6KnGKn2RMp40Oa1ksi9I6OiSsO/9NMbAWbjhvbutCKMUKQLyJTteK?=
 =?us-ascii?Q?0WInsOUDTJSY2VpH1pye4kQSBnj++ddj0YsqOMm541bZZzBVouQio6qHnt1f?=
 =?us-ascii?Q?vlziTzbptPNIZt5Fmd15BWBHZZiU93zkdgMPS4N9aExA7tmOPvClgFeGChT8?=
 =?us-ascii?Q?3yKmE8qa8fmKuFmjtpMGKXq51hzmAktCqLHhrdusIMo49/C/znyVtdwwPH2p?=
 =?us-ascii?Q?gXHilYhaHArzhzZ8mBgn/kZiIeMM7bseyypAr/EcLUem1jXU1R5z7yNIQrfH?=
 =?us-ascii?Q?9MCLsWtHMf5enxzZwRn5kmNioIav+OudSLzpotJRo7VFI6+9FXTrH4pqh5dz?=
 =?us-ascii?Q?bORKGiBs5cn7RA8cpFrZiUn8EW8UVI3lj0q/pgAQbsOPIkeg+prchofD+Jfb?=
 =?us-ascii?Q?ZmRAgta5ysreGn0/4/+QBjJCv3S9UW10d0kY0kQC0sB0A8WssA28zNgUBt4N?=
 =?us-ascii?Q?NAp8Y3ofSvFTUhe6YkjRbaaqWrGWACJUYX1ZBqxk9IBHn+GWr2SjR8cCWc2u?=
 =?us-ascii?Q?PAX6tRCOQeswSOuQr/A0yhpwGk6Gfi5MfVlfCriZVvBxrGwqnquj4z5lEAKg?=
 =?us-ascii?Q?cBp10chkXAEVqorVvZtEjtFNJJECf7qioCKUNxOhwBARNxmpr+Fy+sF+Pz2Q?=
 =?us-ascii?Q?5xKvaMbjYHZnswyJePWbin9TpVcC+/KQN9qWS96uAOAghsw0I6dMgd7lQqSF?=
 =?us-ascii?Q?BAlhh7DPrlIv0HVKlhk0tr0YhgGZ5h+uwy+BvVnkdmnPl4vcfWzk574EeJEC?=
 =?us-ascii?Q?C9/EB1d1O8faIxVYLK+C6BqAJKacTij0yW3KWhvoPTweLwsz3W/4z5qsSZaP?=
 =?us-ascii?Q?cM2cR6HxUKE8Seb3CQozRQI4At1pBJZCsmpTs+T2rtqqshxwIAC2NEe1t4iv?=
 =?us-ascii?Q?ZhgVqfcqvUAw/tMsYGZswRcDEdglR/ByF4jxSFFNioYB3oaJO2yTZ9annF/U?=
 =?us-ascii?Q?/0O74Vg9PqD8QAln7Zlwrwp2Vx6El0u2ANovFJDIfYgSJ0ie5Qr1EIY5qPXY?=
 =?us-ascii?Q?rdKcPNunBxYj4oMVuJ3I8yRu4X2T+j/8EcgkEtnLAHZFTz95ryUNrPsuM+1w?=
 =?us-ascii?Q?3h1X/S5i1Q88gEbgLa3SyN3A7RGhuXn+/+OQTmhvX1BSdTQSiCZmmvHF6XX3?=
 =?us-ascii?Q?2lbVn6FG53DpAJZAMLkHsQJ8Y6PUOvKVCFE7p2t47SCHFn6rueNi4qzjjj9f?=
 =?us-ascii?Q?gJXmgL/40wen5oLB6pxPi/YUTgluHUUaQYaHZUh6JVwelGkbZnTWX/ukaEDn?=
 =?us-ascii?Q?YEVRxDiOHftlyhd72eumAoWDB/SnF5/P79YNQ3Dwxe0L3GNdBnQFTgqUxMhC?=
 =?us-ascii?Q?qWYOB/YUuPuXGCQljmyZNU+X/EfFO9MZSBREhceke+6qShNwoiDdgS++6Mzm?=
 =?us-ascii?Q?+RSuOlT6mTpd4DmjBwMjmNuA/qsJ6V6H+h3p/Er+3jWAZElTRlb5SiZwHOKY?=
 =?us-ascii?Q?+TD5BivKz2df+d7+27Acp68=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aee978b-13e4-4f3c-4540-08dde6d1f5b3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 07:59:20.4712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rsBzjh2GdHDCWeqYyXv1HRgZlFTI2Kue4Xo8qSW5+9RBoNULd1WMLoop802wzbrJ4Hu9fXfKqF9ds4VNSS8fKzVjp3je3J+mlSdwEnJnynY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10590
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

