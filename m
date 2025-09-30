Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF08CCA470
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 11:03:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95D3F8341C;
	Tue, 30 Sep 2025 13:03:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="oExW2dBy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDA13828A2; Tue, 30 Sep 2025 13:03:16 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A145883071
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 13:03:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=serl+ZjIkilYNlAXuMudFPJt8dyjpT0uTmP0ernn11hff9zePOip1t0+RyXLmkjUxUzjR8NgIyUY5w94LJ1Eb5Ixd4QomCW8gP9kIBaSN9q9jRsyRhYg4HhA6aYRpH04MkczZn98GOZv0sUaKx7f7fWvhDx9Sq/Y2ylR2yrPezaNF9S2scqyc4ViNkGrx2TsZ8pGbMYfejc1btv6yu55Pb7RJxK+IIngMF4fg7trpCmx/wpu0V9rDM4WU9ytQND6MIL2kbcTpHby1P56JgGEg7OF7r3+2qA68Xb3eIAkOciNtjF+KPaP9bR82VJlyNb6sajDbSNnsiULsn9I1Y7o9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QDmJU+vCtQHwpacYkDfNwTrlbgsn0rs+EL6aXzf/AiI=;
 b=Czg4k5sPuGH6c7I/rNZVFj+6uhDq/OCIL3OIl1GyNPBEQpuSJLGGc45SizekChSpqDtI31jvIr/BB1CemaGltqxCf0E0Hjj+xLRjmTI/pyHbj5fcEhaCQkLxsUAxONBA2ysqiMMI/7Q9ItZU58sfKmdOwIUwrO9TPmFtYlJEkuSmj7ic0k8keN0GhgNzRNyQd+Nr9d5FrNqCrbPKQ9al2IEhGajN6P/j9ee9C6D5fTZ14IRW8nSr+GgN+mnj2wJNcWhouzm8+SS0orqM0Zg4lh6+pMoMf5+BxllcZjVlhYJjjaIl3MNA5JmQzQnCpnfmxAxrshOgIl+DGcHcmxP1NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDmJU+vCtQHwpacYkDfNwTrlbgsn0rs+EL6aXzf/AiI=;
 b=oExW2dByCRkjxLikl3OufIzpSlOLEvsaOjyby7kIzuyU/XNFjqrytZWaz6H28KSsTvJfZDPPXCgBHusA7xj8PnvJN67x23KWn/7zzaTrwpAbextonltAmBfgGveSs4P6YKMyb1wM3j2jnGMYe22vUnQ26ofNIzxHmL9D4VBtBb2triF7BtYNAu/f5uzHWC2N+Ksm5cn3PA9JfEwZweEBM7wotTRdObTFwRp7CYk5QaFH8IxO+7JWsGJy2J7Mc55AdgURdTgTkhASNpxkU57oijFXDcFC9S6LxAVu5tK1qRKMOh+DWTtHUmKJknoRjzIEVc5HXxvrlQweMvhxzSgvQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB11605.eurprd08.prod.outlook.com (2603:10a6:150:2d6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 11:03:10 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 11:03:10 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v6 1/2] cmd: mtd: fix speed measurement in the speed benchmark
Date: Tue, 30 Sep 2025 14:03:01 +0300
Message-ID: <20250930110302.4031642-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930110302.4031642-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250930110302.4031642-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0354.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB11605:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a1a99df-e011-434d-2a41-08de0010f175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B3+1weqMwm7Y1bJ6sZaaqumjt58p7ZTGSChiqlkX9dqDcKwJ66bmxEsDV7HU?=
 =?us-ascii?Q?5omdFXnd7+u7AebVL0z7dNBfRK7auUiVVu9wARvwzMHQ3A2YNKZOD+N3M9iV?=
 =?us-ascii?Q?olX3YEFFDJKs/dQYWtsbJyXuKjrY7hNpFvMW/ryxSGiWFLiMCRpKNVM7YHaF?=
 =?us-ascii?Q?84qvtrHAuimw80WMmdvy2e+/q36mJYZcRpahQDH7ANLYbHvnCVAEM7pOaG9E?=
 =?us-ascii?Q?wOlUemHexBXPtIDERU0F1weDZFprC/fTRPFCVEHa+PANTgj2mGFu/MQETvnO?=
 =?us-ascii?Q?1suc/CPt3ky0iz0Zbf3myiPgw9GbnvPFt0pHFM72XYC5WF6mn0eoLyawqXxO?=
 =?us-ascii?Q?Bz6Pn2Hfn+gXrkf2DWt9objtOrbJ5fyzJEVCZcFAUP13RWTJBM7Kh+mM6b3h?=
 =?us-ascii?Q?mtPMRhagy62Vs+9z4qBoFEtKvdLrmged4Ct5QJtdk9APoeKFMADjf/7PfDkX?=
 =?us-ascii?Q?Q4felaSTiPPHQqhcnsKAVeciNFyXhRsE3ANu6l5o+zH3bPhpvW1zgJkxh5lD?=
 =?us-ascii?Q?SjUwTH0yEi7hFn9YzpaUAoj6Wpd1LXOISkAVVhJtdjQtIK38yLNfWR/29VZp?=
 =?us-ascii?Q?R50oVspwJ+bs35kST+tT5oNJv0r/HEoE6WcWpRnoc/RcESw7K000xbO4LabM?=
 =?us-ascii?Q?furtoM4L7E1wFppstS3vs0RCdj6VsgKEPpaXicasI9+CBuZcgENXl1wqlVty?=
 =?us-ascii?Q?12PxuWS0E7lkdhtTUkMU7/UnsPNEWgsoMMvqb6wwGKf/AYTvXavnjRt3z7Qj?=
 =?us-ascii?Q?JVOBsggnFU7QhcdVQrd533xopfhoyb3tbA+S3kcagEey9Hz76maYdSAwbPFY?=
 =?us-ascii?Q?BQo3i+AViREWCVxrVbv+8IOGv+L5FT8TX53Qx6vl4MMNhPuashHj9XVHNMhf?=
 =?us-ascii?Q?aCxbeT4GUq1P6I5QccBP5iBE/UyncLnIum3hCTC4TfcDdqty91LH/97PRAS/?=
 =?us-ascii?Q?fJpjcSF+c/LaMsyoE4+RZdeTWQ10vPizv9E0/nxLE6S3IVNjoMihrzTjGT6P?=
 =?us-ascii?Q?yZsQtPMDJO1KQAsHjTWQk//mznBihfkmfH7P2bzDXoDIAhSq3tzCuYpA58wi?=
 =?us-ascii?Q?TX6ytEoh3872c11jO6H5R3BRBPqg7U6YCspWc6mVEBwF2AK1QQZ3IduB8Mry?=
 =?us-ascii?Q?iW97BX1gD6PSKkLTB94r8qG0eRT71rauq4PHeD+csmM5ozjyy1LpPRAvLKKd?=
 =?us-ascii?Q?q8IwUANnxcmBcd2/PErVTEOEvueH7pnzUGeW0gSAgU/3PvC4Fe1OgRQa4H80?=
 =?us-ascii?Q?+tnGQGxcc4Iub5xgoel4mhsmbMqyv0e/8zRkQbjt5ZBFa8IYuyr4tMqdrPsU?=
 =?us-ascii?Q?YxWH9iIJ/EMJ5+cbNE+i7IF2ESbR4nBa/cwOPgMCLqcivCw67/Kk+ibee/m9?=
 =?us-ascii?Q?fBFaIltCfQOFcE2e+94arY13Y0dsRpeN+WtympEvLxtBJLtBulWd6p3Cvyrj?=
 =?us-ascii?Q?9VwgCwtgsjmMKu5KjIJx42v/CLwfx7/GXtNqDZgsLkPFdNEtjALDfby9Tj0j?=
 =?us-ascii?Q?4sXO+COCrLZvYnTiwvVy++EbHywn7wElXern?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pbpkK6T1Y1nGP2q5WcVxf9HdUxY1cElOJ2DJ9Qj7boQ3SPon1loOEi2WNIwk?=
 =?us-ascii?Q?evCwi+ELirdklmfneTheCsitWaef8fNcfi2/K22C4IofxzlOEjYeLlO4f5f3?=
 =?us-ascii?Q?SmyZb9polZ/vrzVQ6z/fciveoeU+FkPQ1uhK2SwbtemK+79DRE6crWVmVdx8?=
 =?us-ascii?Q?O/3EIYg3y7MupjSrhdyFHNhp+jeQnCuTodNZ1SzylHfyBR6WDrpCiQ0SNghq?=
 =?us-ascii?Q?CBiVWgfAUfm3jCDiUzT+w3raCESXXN3zd7J4iSDoAHL5Fr79RxZSYTkMpPxA?=
 =?us-ascii?Q?23oPPNy73VEVEZt7AaGXh/ga1AWYG8mF03SyzB1PWd8Qu7Wk4Jq7CUN+cbQW?=
 =?us-ascii?Q?aTnZpddh+WogpN6XT8aJ+AQCzY6MjsyOIgr5Kt/uaYgUML+e1prgfM0TnjMw?=
 =?us-ascii?Q?i8vaLBVU8YYjam6i7YTzuSiU9BVVOF6+kZo2OAolzrs8KfZou8KsNjd3q0+O?=
 =?us-ascii?Q?rUqnuOfWLQZRjv/8+0kcuob3+YiKrTj19/FFTCFlLAqhiX/untAA/9ItBUuD?=
 =?us-ascii?Q?m378JAjmTmbRtPwoSYYN4jIZho/y9JmMQYYDJUqRzwseXKAZ1okphKdpFgsc?=
 =?us-ascii?Q?VAnYCoB8NBXFunL0hkbzjUkeGpAChIOQzZe7HzFF1+Acel9Dbfuy5C6Qbrj5?=
 =?us-ascii?Q?tk5XsgYhLZieEKExFQmrSpyLK+Wf7eJ3oy3OUPOWeFxj3WmBaDDUj7qRp08E?=
 =?us-ascii?Q?5apl0duPE4bVUCIN2nfItFouc0+K0g0Ds+I9toD+Xd4l5VGSQS1CJmDbpgd2?=
 =?us-ascii?Q?Rl7OZLAMQLDaZmonvt0gHF54dYjZXNz6qXsPFT1cZ21AVFpqlk7uDesXgcia?=
 =?us-ascii?Q?IbDKmrjv0kmXAkMkt3uwjqds3kYiVSISlX5myX6rnZ1g6N7QY04gcDJvPwz7?=
 =?us-ascii?Q?RFnIlrw2Nbf2hP2s55dYnhCij0YremUkpUfzeMJw0QPBN+shyLHK/0lXXxar?=
 =?us-ascii?Q?XMVa7GIQETyzNuWZ2xZGT6qQchn8+ENn7NT103MFW4JlYkQZyNNjFYH+l8vN?=
 =?us-ascii?Q?aFDozNCzhSwujF4j8djSkSyMgVD/5viyb9OaD16uLU2ZStxmSH43YVAsCJSy?=
 =?us-ascii?Q?oBPH74JVRlFi4bVZdgPvhclNOl2qGX8ilsbRQKbuxVg513cEdgeB3NMAZFCN?=
 =?us-ascii?Q?dKZ8XKHId2vD+S0yuaU08qylh8TdLyZvkge7mk70xWx8KGhT42koeFX1nSom?=
 =?us-ascii?Q?MubVplyuEa6FPFhUAwqc3NHqdt1t7Z5F8M7ZmU6Dk2z/96rlzwALvM1MxoHf?=
 =?us-ascii?Q?M2ozGnPTuGj36aZNUu2zqYIUCOZ6u8mZi/9otBCyowjwAb6h1OSWLoFTpH5J?=
 =?us-ascii?Q?Xb/oCKwxZTQyUfI0pTf5d2Cz7PVRW0CtJwuArgk10kPE2vSvIwAPMnlzcM5g?=
 =?us-ascii?Q?VXkCHmUWItRp5vepUYr1hBQnWu+KM6cmiobCN+tdrR6K6aUZhA+WSXENlnP3?=
 =?us-ascii?Q?11pUrSfVXc9DQrGvOji7Na+hyie+42u23DEvWFTV0I4SvHV5xdGWJbnz0tND?=
 =?us-ascii?Q?EaJqOd662mKOO4HW9EIrFFSrA2LGFqofQKg6kcEPpUK/pIA8CWea75eC9BKW?=
 =?us-ascii?Q?CTQSn8h28E+jqEVQsfkgpL3vIfAx5UnWo+NWPMcpAb3ck3KQ/1qoRLtm3ITR?=
 =?us-ascii?Q?pbtd5KAgj6YOuDz2H4Wa+sw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a1a99df-e011-434d-2a41-08de0010f175
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 11:03:10.5766 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: INvlimJQQs2LQCbRLYiYAnTkWKCpLVl7c4ydCJ2CihP7EaZ3sQHG6fJjOGZJfqj8/evg+yg4LH2Auw3M3AWP9QdwgsbC6PRfh97elKKY9pg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11605
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
index 689d8d11655..e415a2d7f02 100644
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
2.51.0

