Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B05C8303F
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 23:48:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 451A1828A2;
	Tue, 26 Aug 2025 01:48:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="vGz/ql7F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FC6082DA1; Tue, 26 Aug 2025 01:48:43 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF849809A5
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 01:48:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tGuL/lq69+C1P+o5SR9FbOZdtbJtKcAY3JyahO2r0Polf1sKt0fcGP7Jpwlpwg06uD9Q5hwfnzO/WPddQbb1s+8Snx/smkE3u/dZIK0Z115o4bbraGebTT03vyA/yW8JlvhH8BS/Qm5qj8JGiqKmEIJ6lov4FnQ9rKCFSfZuw9CELj/9eHZ5uMhp98LJgpoEvMRIlj2mWVCyvneZk54xYYIQy58h2g95uPMM+yGRJF8ZO4jorCzMpJ3ofSWWEHoY+ZjpT4a05nlJcGAFEr0fVS/OREazZnS6pl2I+K1+ny8+fOMlv+h7NTLqZA8Jpjdq4T7C8MASxuRi5to6n9P5YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxEY8aawEVohjm17D0RzgnFNdTbjV+IYFc4yZTd6u7E=;
 b=qhcHK8sE50iIhHvXeeV8vHdUWjT1Nest+8SuW2xlYg9DSV60WR9arfTZyLxx+MITfdQVriOobkubKSnvqDGkuAqPah1YtCGDz26Ny3+8UfIyldFOo2CTuNfawwhD1esh9Ns3D6qjROA/t6YmcuFcCA44Uf22nLQ9ACxZ5qiPt/1WFS33+TsN7H8JQe7ywUZxrux3R5GZRmJJZ7JXWsYBqc5US8fh1X9Oh4au8E/bItWSd+r0BiBW0KVSkdFYF1qTM2dCHGxZ/UfIuYKf8dVheXbTIijH2Uv5WydaZg8CZY3g+r9naQPi2c9oVTk2Wg5gSofV2aaDkzrPZHLWGhTehw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxEY8aawEVohjm17D0RzgnFNdTbjV+IYFc4yZTd6u7E=;
 b=vGz/ql7FiFX0c41ZhUPbIrW0y7Ir6//NFAcE9eJIoww9q/YG6SXFH5UR6D0Bgvg/cHZkqDuAwwQAS860XXqcjEnOD/cqMP83H+O3WwAkSALpWQx8wMh0QcL2VTLn345ecuScSpR+71Z/doGzl01Mv8/hlGWcGS050Bg2PnWVYXtFPICh2Q4JX8G0926RSpeYBJdWoDQDv4Z61jvO4C1HAilxEWgZhbeXd0KkE8uYloYZ/SLRs2iCPCiLbWVfanQHjs8FTNn8NIpDOBdCgWjvLIlfdhdMdcG+vgFIZ/OEhANMznAqI2RbRQMp8tVJwQiLL6DSUHO2aLb1KiqeGiLBOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB6620.eurprd08.prod.outlook.com (2603:10a6:10:256::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 23:48:39 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Mon, 25 Aug 2025
 23:48:38 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH] cmd: mtd: fix speed measurement in the speed benchmark
Date: Tue, 26 Aug 2025 02:48:29 +0300
Message-ID: <20250825234829.155483-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF0000453B.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::34d) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB6620:EE_
X-MS-Office365-Filtering-Correlation-Id: 1be1608a-52d7-4490-833e-08dde431e971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SWcPYMEjZqkQvSdeiRNco5iQ3iXt6K4/xHEkiQpM5HN7E9m79MJpZy8J3Wk0?=
 =?us-ascii?Q?FPQyPp0CmseX0svj06eK22a6YXTfLy6svqoKTkkFc3qJrXQ9CgS2YvaEkVVE?=
 =?us-ascii?Q?kkvjO0ib9M0Pm+BFAq1O/7NzLcerUAKF1hk5hUF9KcruRj9+3KJn58jn6qQX?=
 =?us-ascii?Q?RlM0w1nUaFyEMjkTRxkzqhP67X1BZFDaHw6C+7aTkV6lrSW9GCCK3IVp2OIh?=
 =?us-ascii?Q?5Yritzt/R8ET6Y4C6CcHDo5fwxHf9gJTAGhTkLMhwBh6WXVv6wZoSOVuhS/6?=
 =?us-ascii?Q?bADxrEeuijZb5cRZpSG0I597C4Vc7nzWXaXZzMz/1GcRb4WHnMlMCxJhsuro?=
 =?us-ascii?Q?mX/h+ns3Rq4vir6wmPpMp6ypxW/GtbHwyJeEIX5ZXd5DjzvxN74POd2PwM/J?=
 =?us-ascii?Q?V3pyghdJb/g7esh0cIc3Vr+Smv8KnnhswBTpZpWNKfu3efT6Jlc/vl1E2Z4o?=
 =?us-ascii?Q?3OQMeUIgSQxWZoRTy7GcIUqoA4Ecnc1plDuip9jIG3g9hiqWSoTEpotFbPrL?=
 =?us-ascii?Q?hFQOKY8GpgPNMEBP3gVyNvfERzre96pjKSvObVF7wlc7ujwehzK4ildKryYc?=
 =?us-ascii?Q?ITC+kGmb1Jxk+R+EExo0i2p7cnqurAPtl/lKPuGUrB35GzUwS3mwS857J8AM?=
 =?us-ascii?Q?GkI/CFZDxX+AiDd9X/oHSbyz7922GXfC8aoYOWOjgz7JPhVKsP+m0sJGpnJy?=
 =?us-ascii?Q?PD1kpCrFgb2e6bihe55g4HGKzRNW0wUnQtrJiQNLEng42geTOKPMOtekD0hq?=
 =?us-ascii?Q?YGfm86zb3MvS7yN7BcH+Gp8Jvz6ZYCeVTbIhxeqQBTYH3WmdJ6+0JLO7CWH/?=
 =?us-ascii?Q?m1/PffzaFk1xmcfws40QFSkPZZfpYT4Xa1Y8V7EyMAwjeBsw8RQtzmiL6I6J?=
 =?us-ascii?Q?HnblfMZvrlgR6xHOnmvTW3I2GZkdVJXwwQrLXSBF2QkSimbF/9hGutgvBrBR?=
 =?us-ascii?Q?9qbueCSrLiQxYvPS5rg44JtZHAoFLR8ZGKodvfzCodnrovK1m9WNLTHD2krH?=
 =?us-ascii?Q?5vy9kJoah8PEjUeSdg1cWLmpNpkZBqYgodJMFaQTAvJC8zRx28XJLc+6zFyk?=
 =?us-ascii?Q?Td5OEwjqArkv/+sEVgFVP4yoMzIlQJuEz1iMKjwMegxEXWkSOVeb+SkwxXhl?=
 =?us-ascii?Q?G2j+FI1sQKpPo4VPtUzM6XB43Q0VAy+ZomTwz9C3O8mpC5tsD6WEStwTPdNE?=
 =?us-ascii?Q?LkVhXnKqhTvc8X3ihOseow/O9IhKpBUM19dP/B+oqynng7bJgRP/W6E+orlJ?=
 =?us-ascii?Q?3hLBBPt/j+DT6Wu+5Pai29jNaFDh6ahw8QYoAEerlaqn9cCROKyd2UyTAY0k?=
 =?us-ascii?Q?ADovEgpzt7KGgzUAHMIKHRS1ZnFFfYKZvvhq6cZEjuuL66h2LpUfUDA9oNsI?=
 =?us-ascii?Q?fVgqzTdy3PLgfzneJNQrRfDneL+Dvlbrjh4GfzueXKqAQVQCZtij8gnMTx3x?=
 =?us-ascii?Q?mAUa8kVeWC4X1CXmbMmXvir2DZwIkea6KXL7CtIiICcYXXKE6a1bWQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Iwwacnj6+aQQ3TlhnZn0umdM39uzfsz7TKH3tAj5rnGeOt/RO88JqnKawHE8?=
 =?us-ascii?Q?v91guMKRMWf9dvuUosQ9tJEX1Z7YBJTlv4I7rmy3Q2ZnDn715x4OOtniBTLH?=
 =?us-ascii?Q?txW/UeXbC0Giqgqb9brbkoYHOeJoMLANOhtUQl0jFciGjE67U+1gkZH4ZcTK?=
 =?us-ascii?Q?9z7whZvFy5WoWqLSTcFpBnF4iMY2xcHaHWPM13/AHpxOZReecmqLKc9TV5Ja?=
 =?us-ascii?Q?x321Qh6u65Oef6y2OaHUBtp5c2P4F1YHL2L4yyHeOE4Is8hqZjLRcu4AAsvk?=
 =?us-ascii?Q?g0Q4nn7U/44KtId/SWegbDd8wqpNtwX/BSXhAH2yB2uUO+2BHRWB6H+FsB2F?=
 =?us-ascii?Q?C7p2VS+gp7Y/l92+8oqHPoqdGeSmEWBfEwgDHb0nIjhgU85vvEMx9tS5XyxI?=
 =?us-ascii?Q?FwsrXpXkkhFdu5/W2Q2Fl43L2NdEgfDYbPRgdr+J9CkE6qeD8TJQyJTZQuZJ?=
 =?us-ascii?Q?tOmvbnIbmpzCFzockpvdVmmv1rwPQIOKUv98Vceo86wSoHMl0Y7ZfPgy+1m4?=
 =?us-ascii?Q?5tFpcEO1612wiKLmptmj0jqguuSQJTZepLp8XxE7fOkVWgpN+yaziUk3PmgY?=
 =?us-ascii?Q?7OnjwpuFaR0P0sSgYnCM9fZ/3NaBsPNqMmC8ptXl/GnoQFpJiaGvfBMpy5VM?=
 =?us-ascii?Q?XvvgedD7CVRNdTVnX91rf988RceU4kOEKqa0A+BGwpzQKbtR4nxZB37eSAbK?=
 =?us-ascii?Q?SS2J03NWd1onkf/FDusMf7qXUfMmprzvQqvekKCQ58+s1gTJJntKxeKcNKqn?=
 =?us-ascii?Q?WuurhmxPOGPJrHWDidT7/vZrgQCwqNcyP8CfqKH6A0UKhaH4VbtXmp0Kv1V0?=
 =?us-ascii?Q?igxKZJDleWdO1ZSDakvXzu+GOXEXIewk9/Gjg7Dv0J9t1Q2TZZpKtzjlcdo+?=
 =?us-ascii?Q?pZ3FZ/jNsQ4rOfkClLwE1e8b0oHeaM/+RA0/yRVacTJsskK8u6Z5xTlGThKr?=
 =?us-ascii?Q?CYJmwP4W7tZ5P8ttqTQLsx3PGoOINbr6JcZMizCRexEjCK4h1EYh1Aw4Vpm1?=
 =?us-ascii?Q?b4hebrCRa3Kspbnqx90Fz4MyJLRWi0rzuTNMSprVQ9wL4cBe/DfvjKy5ITVP?=
 =?us-ascii?Q?MX0TeMmWnCbU4L4lxXWdal+IdQk8zgwd8tZg1bKhdmWSG83+2ASpTDbmhFiX?=
 =?us-ascii?Q?3IVga3i8PnZQdZoaf0ENMhjMrgxYQPgLSwg8ovy+Q9sEbl0XkG5R70owuILb?=
 =?us-ascii?Q?yOTlRsPo/K8/ThyxtcMDbZYHwvOLRfonFPx6+tjjNx6529USm9eyQlmEHkWt?=
 =?us-ascii?Q?8wksE3CUR53XO2ffbWDBGDJxomcuHK8+xS7XehEigbseJTJTabdZ9MIV4iX5?=
 =?us-ascii?Q?2uk8MDBoCIsHR4n7SUwO2w1sHVhjRzEY79/nhu6WTLCO/rScIZD9fINfGJKD?=
 =?us-ascii?Q?Yu15mKDwtTHIbpheuOY1F5Bn4wy9H9x1vuX6f8liCZaRGptAheVkREU7Lf3U?=
 =?us-ascii?Q?dNzw8E00MTDQbn1RpOImwbYPtinKzs8hLKqYYi+z1FczDaNUpGJ0bCQB9/o7?=
 =?us-ascii?Q?veipTx0Hp4xSnOtbmWnKvJwNl3vPISe8V740tb1iV19uDa3jiMYQZ9poXC+M?=
 =?us-ascii?Q?K1sEw/gVsN7AhaZ7XB/rGtJ5pIeMh7dcCdLDaO+LBaXo3sxTfDdoYazldooT?=
 =?us-ascii?Q?SVtgTHCPUteEwPZh3q7SOvo=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be1608a-52d7-4490-833e-08dde431e971
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 23:48:38.1582 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 70DtLVzY0eqMGPIRT610HneL27bRY47osm2LLC5PPNGBxIG9Fraa/50DvX0leSiyhqhExXH0P4A1OSvLMCV6VfyL8qwPZ6o5oJ65Pj9u2rs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6620
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

The shown speed inverse linearly depends on size of data.
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

In the spi-nand case 'io_op.len' is not the same as 'len',
thus we divide a size of the single block on total time.
This is wrong, we should divide on the time for a single
block.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 cmd/mtd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/cmd/mtd.c b/cmd/mtd.c
index 2520b89eed2..deac7d1f002 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -469,7 +469,7 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 {
 	bool dump, read, raw, woob, benchmark, write_empty_pages, has_pages = false;
 	u64 start_off, off, len, remaining, default_len;
-	unsigned long bench_start, bench_end;
+	unsigned long bench_start, bench_end, block_time;
 	struct mtd_oob_ops io_op = {};
 	uint user_addr = 0, npages;
 	const char *cmd = argv[0];
@@ -594,9 +594,10 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	if (benchmark && bench_start) {
 		bench_end = timer_get_us();
+		block_time = (bench_end - bench_start) / (len / io_op.len);
 		printf("%s speed: %lukiB/s\n",
 		       read ? "Read" : "Write",
-		       ((io_op.len * 1000000) / (bench_end - bench_start)) / 1024);
+		       ((io_op.len * 1000000) / block_time) / 1024);
 	}
 
 	led_activity_off();
-- 
2.50.1

