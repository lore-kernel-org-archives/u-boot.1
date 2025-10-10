Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E06CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 12:42:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78FF0843AD;
	Fri, 10 Oct 2025 14:41:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="vCuApxrY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F2E984320; Fri, 10 Oct 2025 14:41:32 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F7AD84308
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 14:41:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MMXgFbiecODPrpOhHGmVXJfcdjuVOHoMB3Nh+Xt1vg1wYgAwGwL9ge6Ay/VY/9Gl9vw8P/DOVarDt+ww/1T1WfiC+SI28MqkKHaDcu0pnxnfU0MvWaAiVjMWntuQdPn/Z3veQdzyMEq5wKCyRh30gMDd5h/N9FaBuld+x9xJH3Oaq+tBLtfO4bE80V9/qfV7VXfLIKUi8zxGr3QyCAyZ58Lp5OrDWfeVFSTH2qF4jCCX4mFN6oR1F6F882pYeS9UIaZdTqofYJJbC3/dmQr8K1D/5ri5ny03oaj2Zf0WgpUjPbaN70vSZX18rjzuPEcsLzO+xzmbOfL64tDyhkm3mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPsGysjx+qnliYH0OGt8CblSXeK+XlJA3jJdKJ+NaLM=;
 b=VkcJH9zbsKLGXpMbZ8FcO4Ly+ZP1PA2h1MWML1gulIWwSDlPFlMrbLg1B6KJB4rVYlD/veVul5OhxqaXzYZ6nE8SLkbsfriousDHxYunZSzUpKLhNe5pzekVYfxIYeWkxM7NdfsSrrxoOW+qWaApzcyfm3w1IvGqddKG0VI7cdur7QUOLagKpm/+ci8XZFCugVT5kiZMD9QpZXU1YUfwoGapdhyO/Iljju2WWXIu1RyZj4R53FDZdFrc1/MAx/THjMBjg+p1drUceJ2Lq+uzmDW2hEZw4PV77/T+SYH2S5zNPQMw24QfVBCIxHQTup6uG1pAQZMX3NvYzY3NHoS4mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPsGysjx+qnliYH0OGt8CblSXeK+XlJA3jJdKJ+NaLM=;
 b=vCuApxrYU44UYXacgBv/OUWTMQ79fSZIXYvDcGufDY6z+Q5zbj8D/LGCA7lTZeTf66vxrXnt1LymxSl0M5ZUO/Gq4UklazrSwcd2AqyOI+jv6e1iPh4sylGyj5L1GSX5XYK3DoX+VxZJcFm1iXE2GMJ9x2kOtpn5+kyiwbGNmLLvqdtIt5LDTOiEOEpAxdMo67gr28dfGxfRmavDzbQ+eTW+6Wphvnr1dD02NZIqCrhspRvKInT/3fxXHe1kG2gtOdeCQHFW6Ao8E5B2SDmEpse/LxhtL5lbvL2hvVYpKW1AHY4Zx5HsAYDJEXaOKUeAgkcAc3ngMP3FRQVuVtX5uA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM9PR08MB6259.eurprd08.prod.outlook.com (2603:10a6:20b:2d8::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 12:41:29 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 12:41:29 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v4 4/5] cmd: mtd: fix speed measurement in the speed benchmark
Date: Fri, 10 Oct 2025 15:41:14 +0300
Message-ID: <20251010124115.1545865-5-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010124115.1545865-1-mikhail.kshevetskiy@iopsys.eu>
References: <ef29354f-7d9d-4d28-b3f4-b31291e11dcb@gmx.de>
 <20251010124115.1545865-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00007577.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3f8) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM9PR08MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 880f8815-84c4-46c2-845d-08de07fa554a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BX7B+VjqPKSbalyTPCDi5/zx/Fm2Dy1jGc9ohbjl8LazOrbdPaqi+JDi3Ol+?=
 =?us-ascii?Q?CDYbQ/bW4Mng5/Kve6nXz85lZl+y/ruptyOUySihLSQrkUWTIw+OI2TmNjo+?=
 =?us-ascii?Q?j03UQ0XmSxzNa5M15/dUvKgmD2LBfbDoe3GpuB0sk7bKu/KGoR4hpczJUjFc?=
 =?us-ascii?Q?SQBvvcePt8lx5B9Tr7eDnQ0wcPCGzJKAo5GcH/+idpFRzpsi1nq9+4y+NbZt?=
 =?us-ascii?Q?2UzUQD/r3vXusgpII0MMpNOO4mfb0aypR/l7z936gUTk37O7BlE1tdqedH6C?=
 =?us-ascii?Q?y7DgBgED6m46yCcPPFj/jNXI6NpMdnSHl7Ro7ANIvLJ87L085yakC3/PFcyV?=
 =?us-ascii?Q?loPwH9TNDIwjbTsqGXt16siSGxxIdGyx9wPWlJn/V/OQBAsydSnDnMJ6ixxT?=
 =?us-ascii?Q?uxroVMPssyGeIvSJV6EaOsOeYQzQe7A/mwWrFQAsIrlrcDNZgpT0M5YI8RYd?=
 =?us-ascii?Q?0iftdbkJe97+Klh1CTcbSB4S9DmtFv2WzW5J44NZfWXMzDjUMlInaJNsrtj8?=
 =?us-ascii?Q?I+xOaQ86iODeAb7gm9RtwaL7ze0ucK353UR46xKUcgIyz3wSGKiEtXwwvOS6?=
 =?us-ascii?Q?P0CLqwO9njcXOmamTuQiCuNykmu5db6OZIe/E+u7l5Yoy5ZGZ+D9msac97B4?=
 =?us-ascii?Q?RoJ2oZyF/WmlSe8fEOXHtNvXkJ6jHb35fn/X5JIViZjQCLX3uARgjuZ+oxr4?=
 =?us-ascii?Q?jq9jQ2xLjk/DHHASQLIBVxI51ppf+tDYpKY7DcbRBYPlnXIMpd6sca+PgXCm?=
 =?us-ascii?Q?ZXFcFFft1HyZx8WJrRVf0DwLqjva5n20Pg0Xt5+RaX9zt/vF50wGiHj80LGv?=
 =?us-ascii?Q?0fNsU3iyiXwh8ShyIeQJBpJG1vmr1o2h2qAGfGtB4mGe/Q3w/BfGaWRlKKVT?=
 =?us-ascii?Q?fdX8MBoL8Rtt3OmXggwqN9Pmg7bNQFgPSpk3yFqzc7YhCuvV8HhupJTFaG7C?=
 =?us-ascii?Q?XYhOTLbDi5qxUdZVnWc4q5pLuWwanQtv+Cx1kE7t7cCtHnPMl94G2WH7NM5I?=
 =?us-ascii?Q?35ndjifANyQq8XquOyhGjWK8aRRKxv7VF97jFHabNr6K3DVI2kzLPJZIQ1Ia?=
 =?us-ascii?Q?NuXSiqYEZuCS7sv2Dp+YBXqBxzh+uSYLgHSz3ASYA+gBBaxgQAiuOmc4xXtA?=
 =?us-ascii?Q?CmqViZORbVkwj3RKXeukHyTJ93P9HpAaYzx+Um0DlKOcpCrHtGe7YZY8dyYl?=
 =?us-ascii?Q?ywzEmr5ijpM3oggvDN5Gz7y8wIWEAX12LFhrl8kTGDn92lfqvio8eflVsBkn?=
 =?us-ascii?Q?05O22iYam/Pjux9kMVXPz9hcs0U7jXf4tXcWpFPle8eFtumYVC7HPePHC18F?=
 =?us-ascii?Q?aLFydMPlpN+cBc3fHv+pTDOmFB36udsPtHnEomGrTMRdhEl4nbj83aZLjjnM?=
 =?us-ascii?Q?agR0ypb7Pg3qbu3n+kvs3R6IDCmk1/4FIEwad7U4sv6ezKd0hWAZcepLD7P7?=
 =?us-ascii?Q?GUs2Dgf7xiarBWa9IoAm4aiMNsHH19b3cuOTOeRPlIX0HysJIhb2t73ndiFe?=
 =?us-ascii?Q?/nHuUlou8CYieAn1kRYIpvK2Lhf9lvUy3Wf+GDkTWk24lWmBHxC+7/o0Gg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GPNCLNhxvsPHn30qowswjzfwycdosTs6kR1vwBnxGOkZpQtah73LlMg7hWYV?=
 =?us-ascii?Q?x+Nr6oYidP2RBA7lvzM0CnJEerBYeA+waSH/KVz3+5JmfogP9tS+8UeUGY2m?=
 =?us-ascii?Q?TrcwiFqqf1++FePy04r7rN9hGMdgtiqx3LgkFlw0r/Ry8RranLxGniy7dPAW?=
 =?us-ascii?Q?yck+fJUL6M6zRn595t7/0JNGwRxGjPWJkVi0eL1ykzZjDJOUJyy/ClTppkV1?=
 =?us-ascii?Q?GnNmjOsedy1kEwR6m7PPMDibVlKles/qFfiDZje43/q15+f7nm53KmlFpmOr?=
 =?us-ascii?Q?NVb1A6ruXFDtopfDhsFLXmz2g2ujQ5eqZCgk2SSV+JpqnmBMSXSpzwTv+N0o?=
 =?us-ascii?Q?ubi2pEUygg8j8fqm65KT49NTuMkPSXN6wuv7Dycyz1TpqNpfsa8VvOTbZ6Wi?=
 =?us-ascii?Q?646k94w/jBFJsySN1e08kzi7RZBoB+1oUF2fI10Yxy/I2V4jNU7bjzvtWZNV?=
 =?us-ascii?Q?BlvUL1tp0Zl8yDYNMj3SHZK6nsjJ84aV69iZgA0+YU0Xq9ks6DBwWEXeFhR9?=
 =?us-ascii?Q?tZZXLS8yeBMxFzk5/igcR1xL0QgKtNCN9iPRa4KXcVCysqPlQOhyUqkXMzwL?=
 =?us-ascii?Q?zxKKOtkVP0vK4mzh4NS09rwvwgrxSEisbKr/Zpbi7pMaJwVBpcaOHcaWnzzz?=
 =?us-ascii?Q?eromB+WQhlfQ5Jh+w++eKTdOVNkhQPTlIWatNwtdt+7/GfTAZGFWPREvgMG2?=
 =?us-ascii?Q?jEw2f5+4eV8O0DIVtEuBG345/nDnTbLTpoNub2/61O8NwSwBcVzgqgjOR87y?=
 =?us-ascii?Q?qKeugum8sClgnxhs7yz6qB1Aw6DeEmRD4MSnXKsPLWb9v1rUMVC7nvOXq94L?=
 =?us-ascii?Q?o8LMNf74z/nGeT+VSGkkJxZCoKsEBU00OnQaZ9CLh1ySNOCcd1wVZX+1oOZu?=
 =?us-ascii?Q?2eIAalKb7artJbj3yqkG6YyALz0j7AZCLx03O3GcxB1oBzXKfcMreszTemdK?=
 =?us-ascii?Q?Z/p3YPrCjexV/tmHd5ie/Uo2IhCYLrB+HoUSRUAJCSN3hBbDEVRYTU+jpKCR?=
 =?us-ascii?Q?pAAiGJed991hJKaUH/2xcGGCW91CoLdLcxsnA2XYWDLAIoMpkOGqOh0rIf4L?=
 =?us-ascii?Q?Ov9m9S4rK1YpD9JyzwWh8ZXGCKPEezzrAaVgiQE4zu19D2AYpJKLIs8kQxmV?=
 =?us-ascii?Q?yQdodqZlS/CxYjOxrm7IGvISCfe5s3dSdyr7O8BD5Qv8YOT/DbORbTdwEzIa?=
 =?us-ascii?Q?vv7AQ8cZiusqiHzn5aqu9lhxI04NRb6rXG9Qr3Gq8GDQcOV4Ja+3Ed/zIb68?=
 =?us-ascii?Q?g7fh8VXJ7PnoRH5U5qmwPJMGXfW4Iouf1DE1Fg+pBU3fzB8vjemReopoIKL+?=
 =?us-ascii?Q?vyUjMvApR0sxSy2xRUUYK8MX93555Re2xGnmllDXElI7ZAzYDIrjH/ArKLlG?=
 =?us-ascii?Q?jjTWU0ZU8dhxJsYW96K3tENhq6eIkg/Gaayhcq4hWG2QUjlslpV1KzPXdn0d?=
 =?us-ascii?Q?f5BI/hNK98EOayg3leIVYtRJCwQPelK1NKTMHGspxnblYd+51I5ZUPEvMFPk?=
 =?us-ascii?Q?3NhH3aU3RZxxVy1fRBbAwj8wcJH9QpeCIz1reRYqxGTvXBy3GU2yT+xNhRsS?=
 =?us-ascii?Q?d0YJTxRrNIbQtxSRQCjksdQuRUum6yYKy4uqhYXzBwTT30OSphXeaR/mqf/l?=
 =?us-ascii?Q?CP5r9MP8eiLnj5TXiOmvhg8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 880f8815-84c4-46c2-845d-08de07fa554a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 12:41:28.9677 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TFfiuTbdG8OPEi9kFL0yUdBAcWF1bmFpjgB/B1fQCFoe1WeHOjxnrNaWrvyVDE7ytnhWHgcn/ugXGcmxEOcAIjbyCmMSxaqB+ryyBUeFTV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6259
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
 cmd/mtd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/cmd/mtd.c b/cmd/mtd.c
index 689d8d11655..34870fd3835 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -10,6 +10,7 @@
 
 #include <command.h>
 #include <console.h>
+#include <div64.h>
 #include <led.h>
 #if CONFIG_IS_ENABLED(CMD_MTD_OTP)
 #include <hexdump.h>
@@ -469,7 +470,7 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 		     char *const argv[])
 {
 	bool dump, read, raw, woob, benchmark, write_empty_pages, has_pages = false;
-	u64 start_off, off, len, remaining, default_len;
+	u64 start_off, off, len, remaining, default_len, speed;
 	unsigned long bench_start, bench_end;
 	struct mtd_oob_ops io_op = {};
 	uint user_addr = 0, npages;
@@ -595,9 +596,10 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	if (benchmark && bench_start) {
 		bench_end = timer_get_us();
+		speed = lldiv(len * 1000000, bench_end - bench_start);
 		printf("%s speed: %lukiB/s\n",
 		       read ? "Read" : "Write",
-		       ((io_op.len * 1000000) / (bench_end - bench_start)) / 1024);
+		       (unsigned long)(speed / 1024));
 	}
 
 	led_activity_off();
-- 
2.51.0

