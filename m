Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5FA2CA0FF9
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 07:49:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E8EF83544;
	Fri, 29 Aug 2025 09:48:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="UBvle0Lh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D35A83447; Fri, 29 Aug 2025 09:48:51 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D71C8352B
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 09:48:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVxKLkVqUpyTJA2A7A7Ia3NW7jzoz2DrPsfCFxdcnY0VWnQFS+bVsLWnFNBPjsBBSHHZ0ER+rQnaXIM+YgpPCAyvC95BSgkGvAs8LKKHSOj0bhA596ZMgBJ7YjY8sSzq3WAd1SgbYpELlFdXJH+yqiD0QU0T+6y47WQXbX8GoMO96KovQEfHyRo9T1MSZC3TJZBzUyoJqOJjkOI2gUDuC+i2rGuP5A4VfiRKuyQsy+/y08rkph+twpwZlueZOhX53ptshQg7A5yQ5ZWQSQMBVUMSKEtI3pOACiignYtAd7zY5kBSrqnwvPqP6Lk9JJJbMNb0SIGmxyT1yMPDNXfDpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/GoorXP66eRw3hkjhZj+qecWVUvukQDV+R5tmYax0k=;
 b=nu2uMzEgEsMijC8KGwmwX1sqxz+f994bSoc6sc4R4GXzrN092xavCIbZGxBmy1FMBLaJSNctOKF4Hr9zxl7QFzgvgDL/SQZoEzSgUr35oy6lVL3fU/M5L2FAmYAiE9coY6ejJvMgrydIEsCWR0L6bBOLLvebKD0zgaVV9tvBfsBREAqF0Ct0pgdSHNfcdvo6+AJLpg6HYs7a6ixYeoEiK1PcMoujgLzrQB+ohDSftDGnHq3gYao03Psa0GaGoeuGsYbM5dyfvuRsP9ZRBjSH1o0KYVbf9a2Z9hMpanKD+4j1roEtzGQSP64Pc8TLbf2UDgRzwwmMCTCG1Z7vrubVdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/GoorXP66eRw3hkjhZj+qecWVUvukQDV+R5tmYax0k=;
 b=UBvle0Lhky2az/EXRfWRu7JByhYpGy0ZvciT93JsbdgHcrjM0mfJxQYzpGUYqSbj94BYjtvte//IF4LWdcOEUwx8tzw41QyT8z/D9emATKr7b0QCDE7roU7kDIlv9ESQrpaupCkNy9zpkb6L+xUImHj96jOJPWgjiX+27k22bQr3DEXg/xM2efcEi2Cr6f5ehE0MSuzeRmLphDDCQUPVw72TDZfi78Ab8CGWZWost8mPAvIhw6ZQvkj/xvC2ai8P/L1DJUxuyYp+M0EJuh3+cwxwa8pyEFCwGuiwEwHHwf1DFM4+729oHA8v6e4BnaVwRStmGu6SY2maiEZ24iO3Qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB8320.eurprd08.prod.outlook.com (2603:10a6:150:b5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 29 Aug
 2025 07:48:46 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Fri, 29 Aug 2025
 07:48:46 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 1/2] cmd: mtd: fix speed measurement in the speed benchmark
Date: Fri, 29 Aug 2025 10:48:35 +0300
Message-ID: <20250829074836.2894264-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250829074836.2894264-1-mikhail.kshevetskiy@iopsys.eu>
References: <87tt1r6api.fsf@bootlin.com>
 <20250829074836.2894264-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0311.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::18) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB8320:EE_
X-MS-Office365-Filtering-Correlation-Id: 383f8d42-45ab-4999-8f6d-08dde6d07b8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iSukowYZyOLv/BudPq7EUSJMr7n2M0D3Hy7fw7T3qXtRx7OogGMdTC245wRA?=
 =?us-ascii?Q?JYl/T1Pik4MOmcIi5Z5g8jxzz0nrQPZa7yYwVSGTfro8BpL9txAwZQCAjN20?=
 =?us-ascii?Q?I6Pu8EuIMCTNOcILuCtDuYU79k52R65OoTDGlagTjfo4qR+MsilJVlfeIG+k?=
 =?us-ascii?Q?7GyBXzAHIPKSeaKuxdFr48703gJ0pdSCai6Ai84e3sHUHc/2ZiGDZkqwolZU?=
 =?us-ascii?Q?HrVap05l1xyvo5A/pM6Xv9hpBuXrr+4rgl02dwLU2tVdh/M5aMmEdnd4mAwi?=
 =?us-ascii?Q?S3uAIiLQX9YI5qI0RUaNQHSTCTGUq//mepJHxDpU14LeA2/JiffJnkW6qLMz?=
 =?us-ascii?Q?JQ/rSjr90yiTgKkRsVFwHZYWTNdaIPnxx9L7g3K5CdanIekT2FVSU3f04mwV?=
 =?us-ascii?Q?OQa0ZN9xXYoB87XYKQczgPNtSpnmI8mOY3AEoG3DMdF291lt/AEQEekiVJLt?=
 =?us-ascii?Q?XnpV+C7D0dbKsPjY+e57blkOkRK54vT36TA+17qRX2hH5MRiWugneLQOly+f?=
 =?us-ascii?Q?neQHuf80L9wp+XXhCsb3DoooAPVVgoEMIODcunD+FmNIwqwjF8z8UkJ7Bihh?=
 =?us-ascii?Q?czwn6/rCSdV6sfkGtdlwVfx2Smosm5B32T5AApzjmdASljaC1rLPYiE8btEg?=
 =?us-ascii?Q?g0bXiQP828WDs142BT4H4GHNJbtE7eCA/OiEXK+/UEElfIQMPzkAkuDUzKDr?=
 =?us-ascii?Q?E2QkZDnS3xzwnVmawX0fPZoqali3psgP3803rvC1XPQEaA+AS4erHHt/0XDi?=
 =?us-ascii?Q?20cXneQVdvhR3pL3XhL66alugiAEdxpg406isNecQZksXamlkhLcjCN/hpKB?=
 =?us-ascii?Q?g/BQsIjUC5hrn4QZ+ULe6CbDoy1mSLLvtwdWjPsXd7CmQOI9NBt02tf7RKFX?=
 =?us-ascii?Q?SkLlkZESOqqRsba8diTL7IcacEoU1hsQBRNfQS6U+ZDI/9bA/lbdjGZtmtME?=
 =?us-ascii?Q?8goxSZT7ntED1KxQo14KbsU7z9QJFpX7cdYZ0GpO1iNuLdDlL2PPRoJoGqlM?=
 =?us-ascii?Q?yvEBG+v/BCCdk8wISgoP73LZH+T+lUr5J/syLv8X/6QxjrCeWIFmaQxjIf/O?=
 =?us-ascii?Q?XQYkCwCwsRXTw1wRnZkTpS8p/b+XBZVIisK+lUiX5hxCDL6k2TuJroxE0uy4?=
 =?us-ascii?Q?AzzG5Ebvp4VSyhsu15HnXEdSiocuP0CdhMA/564uwbp6A+T7fBiCfxJwx8Xc?=
 =?us-ascii?Q?bchKpMo26/6raOR+akVpYzWLg8bLnrUDfkcQIt2YlnKS8GnKvEgXw1GeJJYE?=
 =?us-ascii?Q?PkXLMje6etTAvmpOeDqZxAq2ixQ35gvA6SLygYeIxfRanp6PF94MjqHAS3sK?=
 =?us-ascii?Q?ZHNoqchwS67H+Ap77KCGiX8En1EXia6dmM1DFLD3XGc7IcaBO0vQbZ8zr7kq?=
 =?us-ascii?Q?L080UJrYZRKFWsWs5wwQIHGBImEVdR/q6byXLG2wIQ+sPSCd1T9m75qQyVSZ?=
 =?us-ascii?Q?shMP7N/RiL/XVgvQ4Qxp9GFsB0f/Fnp+DJ30kglis07DdeNUu9jkHw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WHdfUaQ5dWnoBVIiWBp7D1XFgCXK256HqDElh+DbZiuQ2JVcq2T7hb2t1mtm?=
 =?us-ascii?Q?lw9o+aaJfB0rpPxqIbpATJjhdGxxgyOtHB1UFW2tAHbchzTnQ1KysgED5a94?=
 =?us-ascii?Q?VmjJlqR9q9cD8rHSUgZsa5unZIA7TU2gZcSizMjsPLK26jXfb8ykYSMeDSfr?=
 =?us-ascii?Q?XgNFQd8BSKlxOtjBFbHwh7+nmZw377o5oRzS7OAaa/vyDhJD9EF3gzjiHDKj?=
 =?us-ascii?Q?uUUGCcetQ1EpqSp4vR7LFfR9eAJPN+bMR6mE63+2K9U4qdjlslup0aGPvqC0?=
 =?us-ascii?Q?P1btz20URjQTFqQOFcZeCB+T7qQRx8mJMiwJhOCLHoJ75rBzy/EZOF0zoo3P?=
 =?us-ascii?Q?FCGan9BbCH5IeAarrmzXuwSF7hn4m2Ub0tsGVe+JJhBMxSAYco1OtAwMDUwA?=
 =?us-ascii?Q?zSawk5NaKZvyXH2hxpAY8eYesTzaiiGlXsFaVuFRirS8y807Bie1487FqdmB?=
 =?us-ascii?Q?R24fRisVsr9HMhz94REZfFdfpA4JRVDHyRfZvCy4k4X1dN7GnqVDuYXQ+4Ov?=
 =?us-ascii?Q?nJp87yxof+9oPnceOfy/nVc2X9i8GTUFKQwxrrz7W8C7aeYMe+nAPXLZ7jCG?=
 =?us-ascii?Q?uVP1xFKkTmaLXUcgvO5SvmuxFbFFHvgdI4WxQuaI2ZbGLzKGmjsi1kRjQ8CH?=
 =?us-ascii?Q?3UC0tk20uENS0GhovDIa9d5/KcynYDb1l66KozTqJuzDmOWsOWpdgsdHw+uE?=
 =?us-ascii?Q?ROPDQHqjmWb4GtZWZzTWcFh7CCjab37isfZa8NGM/yQ+t60xzPPRMaDGWC59?=
 =?us-ascii?Q?DsSKZRaeS2ER4E6PVyXzCYX9f8NlBfQXPSowMWNtxIfFPl+R9Q7sz4Lkkwzy?=
 =?us-ascii?Q?GuUanKITmSBCgJkgz5FxBllMzRQT1brDlm/A4YOwJv0+xrWH+RwSLdsvXSXv?=
 =?us-ascii?Q?z57/bEF35kCbYc6wI9H+CccEbTKPpLmKzmffTaLfqWWkRVG2j281MlUXvkzY?=
 =?us-ascii?Q?ThBbrRH7eaw8X9i1v3vV3fqp/dFA9Ur4JxVsPqonDzwZnQeZaiufvOglt6fq?=
 =?us-ascii?Q?Htx2G2lu/sob1Us0LymaNfop5hjz/zeE+hbUWH9lxGuA7+lqmClzkdgy0PI2?=
 =?us-ascii?Q?/+9kglr8bQ1D+nQWbTvDXfxtBfTP9yw4rwKAXgtjy2qQq8lWmkqNK30OczaL?=
 =?us-ascii?Q?pF2U5MPnKNb7NlwsBvFxRuRY3SjXJO5vKGcw/dsw/REuoiVk8vrxZBwwor0R?=
 =?us-ascii?Q?L9VSubIzEOy8sEtOXSOtpgTDy0wdGiX1qXVy9MTHPFPBfqjLy2MIqAHLEnVN?=
 =?us-ascii?Q?wnLOSW12HaosS4i+jswwdD6jZctRAYbgvByKhnzhlq7M4cMBksjqR6PhRK5q?=
 =?us-ascii?Q?0BuN8m7bcGMXYXIJrNG7nGMafRMa611910BtAraQssNu7saUjnQoToOjS5Uv?=
 =?us-ascii?Q?wzHKbG7FaRbc6oIoSRwsF0OaZX524T3WmrVpkOgywbIMni8CdD0D+tVvomUJ?=
 =?us-ascii?Q?R4XHIWa1ZYZNr9SkPNuImOPQFgIUF2O5WIHuISK/4qW8+WB0tXSdoW7fpWPI?=
 =?us-ascii?Q?1ZV5TYEM9g8+nCIU00Ss9VI+PPKP06gzSVA9p4XoMGdJ6ncUpjH+cWLhvBJr?=
 =?us-ascii?Q?YYsfdhqnCmeOYiVywV1kjYbsEfr/ml5p3wzsSeTmZ/+BMbWYQAn6GTmZbKSx?=
 =?us-ascii?Q?PylL+d4WAJzoj+2NLEX/Igk=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 383f8d42-45ab-4999-8f6d-08dde6d07b8b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 07:48:45.9577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WOgbaqRj+IMSgXiHSmzLteJZUu3X20amVqY7sNUZ4mI6g4ks9vFbTrSukDe2Bp2H2Spo4cqar6aQPi65A7tI4+DyVKqvIp2TJtcnnj/YyD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8320
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
index cee3a7e43ef..d4e1f83b91c 100644
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
-- 
2.50.1

