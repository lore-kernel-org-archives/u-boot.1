Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A73CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 12:05:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89D9D83FB0;
	Fri, 10 Oct 2025 14:04:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="QheY/pZ7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B13E2842D0; Fri, 10 Oct 2025 14:04:44 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D147C84051
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 14:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQG3Zo7yHCWkZjWdvXOhgCE/+HuOJgChvZXmx7fdz4sQHqymw5OxLqW/7b59Jjhymm+F0GufHujRRs3tfLswIn8BSuBF1j2ONTYrMzwznCgM1QgXar62q/OKzwgiHoMCz/C49Vt4a6Z3gKgF3nFyTydtm2rk+5Vn5G/CTakuFR+wnUhDUA+RQeXheCcx3zKPrHAhra1oaQe/INhc+qq3tFGZC3D1X7+V/sWpgqyBqPesToOZlr1x3kJKBTOxKCxTaLxTtfcR/pTRxbclXLjEaToIcyep9XJxThByG6LFq7Nxh5XRByziKyruNTS9T0N73LaKtpQtO/XK094zfb4JWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QDmJU+vCtQHwpacYkDfNwTrlbgsn0rs+EL6aXzf/AiI=;
 b=XqXJxttoNSYlywsyDN7oJabDzgrdYVA8ilIv52CMTRKA5jZtYuU4fXDuZPcfD5XkP3J86996mlW5eEX+wXpcYW0hZzUVOjbDK2quXe7oOMulxLAryf4TWcab6YXp72VLoxlI86WSYo+z4PiSAlAHxkSTRRMmxUyRIz03h189ytQr2ZRpr0Q+aQIteMUCa0gXfFNBZS63Ef0wQJOgjcbg+YEonYnhManz2UAWrabSsEny1PBnJMOThsQDKNz02fbgf9i5hYjPAP92/kh00ghmIYX/91U6BHN084XVRZz38MO9sJHHUvXRWEca9A4iu7+35udEzfseyRgYlHO2p63RCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDmJU+vCtQHwpacYkDfNwTrlbgsn0rs+EL6aXzf/AiI=;
 b=QheY/pZ7XL6aFcYm4BrPY+1ZH/imdjBrjf7v4VZfDaVGSB/7vz0kf2tLovXqa5i6RMFeRZrCTbgYRufy0p9xxGiTyBes0ayWggJ8F5BunTcKfW9VPNV1VgHjwO4XbF4Lr/BVQca58O+9nSXpBZyXqsiIvmp0yYcfQ38kwiPofmxGdNDdtqFeCZtg/3aguwTPvsZOvHsQuglx5T1aVsauMMMi6QKciC614MElHNt4A41vMmZl41/7C6oAgqtiniOZsyspesniFmefRyXiYfMAmzPJNjwSqbSY9V9u2S3WD3JpY090OiVZrG6pXYJwjEwAsXh271+vRFr7NTYvYDkwNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB6650.eurprd08.prod.outlook.com (2603:10a6:10:26d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 12:04:41 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 12:04:41 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v3 4/5] cmd: mtd: fix speed measurement in the speed benchmark
Date: Fri, 10 Oct 2025 15:04:27 +0300
Message-ID: <20251010120429.1532370-5-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010120429.1532370-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010120429.1532370-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::13)
 To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fcef0c8-210c-44c7-de14-08de07f5317b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|52116014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?daqAjYMcptmJD62sSDcaBhmTlQNIajZrSStDlmPktX2s8icMC5y/nSQPNVip?=
 =?us-ascii?Q?eRMY7/dxZn5z8o5sV7FJqpJsEsafk9cKdKyuXJKJ8glC9PT0fPQfr29mclEh?=
 =?us-ascii?Q?WhOj+00hBkDGzND0ax5xaH1mwW987ONWnpiwWq4QZEvHw+xO02d0biDzvhhR?=
 =?us-ascii?Q?v27J6RRVB2imkfOqTdLvf1x1+CoIm1DHWuEmaAciAhV6Ls/bGV6wV6++lhRv?=
 =?us-ascii?Q?3+0vZLbZFIUpB+nj2/3ajWzm6+s5giPBMZ8Dr5dPmxJ07Jd0RtqCa6QNks5+?=
 =?us-ascii?Q?ZihJ2jQQJuwjj2dD3aKqDQuyfWmk7hMu33xkobpc+gVl5MS1u/8Y0hFwuAoT?=
 =?us-ascii?Q?/+h+WAwmxwvMZAooAYaf6FM0ADKep2JZk175Oqaa3+CsE3s7M7Xs90duzUan?=
 =?us-ascii?Q?X98fjK2MY8bQ+ts6IGSmlLzPUBedoFeLSvoBSF6pqMrUfD9X/VFDwsUZ/4y5?=
 =?us-ascii?Q?UFH5LGoH2f88TedWI5mTckXsMcE8FdT6w3ANtQ6VlTozEPOpiE87kiTqs3r3?=
 =?us-ascii?Q?IWQN2+T7Q7mG1dkhVVw99smw7LhNRyd2PNiu30uFCnandI8G8AgzA9zKA7G1?=
 =?us-ascii?Q?HXDgLBvp1qHJFGfnMrlBrQRZIQYgeFY7f0id6TrA10QJRGd/8UHG7UCRZZgF?=
 =?us-ascii?Q?5IjFcXGhmzrElYIIYOigaMnODI/tOn3Zz3uKYElS9dUtdjDwmLAv54G9Osge?=
 =?us-ascii?Q?w0e0T57jhzQ4aDA3N0K4p97gbQkGyz6BZZC1LOpnYF/srZV7wsfelPVw6Ore?=
 =?us-ascii?Q?lcQ51Cbii9S6i3mv/0ahM4v5GpxlMlqJ4AALgJA0Y3F79+TkAe6o1Ms86mj9?=
 =?us-ascii?Q?7tt7LZujd3q5x37RPbQDOse9k3RpulfAbIwSIsQ6yN9jInLYH1QTn1u++9jy?=
 =?us-ascii?Q?mLNIYd2aufBPOPmkRl4A/QgmYm7/lWsdUYeUUTXE0qZWbWNFDPYuqZPhGUnA?=
 =?us-ascii?Q?D+bBneMLHnCkvQBnIwbFcV/hK79rDZOx7F2VPt0D5g6hi/f2pyJLqyKqgLNu?=
 =?us-ascii?Q?Ag+VnhRJ8sFHNxjg1arF2/AmkUDB4ujF03jNjT7oK6bOeIUbz04H8JQrJhWM?=
 =?us-ascii?Q?Fmd3A9mOwjPKNZV5jPScXG0JzdU9NFLA/lA3bOlMKXv+knvdx3+HF54dkO4C?=
 =?us-ascii?Q?2Y7jyk4WSrrEG8o/GSytxifs/rg2BIrRQ/oD3ZgUIbPMHRit8mGgCUyGk1Qv?=
 =?us-ascii?Q?OMSySw5iDFC89Txwy/0CSiffmn5YhaAI6OfajStk8ZV6/LvncqeNoop0UJuC?=
 =?us-ascii?Q?ljnvNmPn6RG+mKy0W7vHvE9fprZPEIrgxLeQD/vrZPIyvmcf/dyHpquFFcPa?=
 =?us-ascii?Q?N5dTzqgHsOrxCxhzWDyPcbkfQN70PH7GlJqUUUWq79wc3qW7c1X6d9At6dXk?=
 =?us-ascii?Q?XeO49PhwV6YljzZneMeiKzoBVoIlkKq6A5cz+MnZLsPeHyOOfLQoVtjycKV2?=
 =?us-ascii?Q?do0yzjaMzDLcjNwbyHyEMy8bWwxTPY5t2NF9Vabzwnf0eZPy/URFTBBARI9k?=
 =?us-ascii?Q?P790UWsd0MHukL3LoWCvq3W3kip4aVWpddmm3MrnfcjDW9Un3vIm/HZiUA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?14jVTJNswEfVa7C78/vTx46I+ZYTx/WTE++bPD7Y7IYenLVk5CCnALu/WJcS?=
 =?us-ascii?Q?ILyhwx+ITotxB19xLb2MlMp5BYEjhmIRp4H6Pklxi5et9zKwDn2jNMR76Z7t?=
 =?us-ascii?Q?TcfYvE+J+IiKWIm0UVWidpI5LHVJIwXHDqP3+iw6HEpWBKVOCGD3f+YW+C3v?=
 =?us-ascii?Q?RVnxrSMBakkrFDt94I4BTUQgbkGSL0tgobpLkeY1pBuQzip27M1wYUeVQVwR?=
 =?us-ascii?Q?jqHNnqmnkDmv7xaX5QCY4HL89067C8DLlKM4K1Tk/0Z42lBWJhjyNxWDoIC2?=
 =?us-ascii?Q?9D/BghlnWGt4hbUYIzG4/0/f2y+gxpqmV16ypb78QdpwHd/dq7lFVNhTOD9Z?=
 =?us-ascii?Q?fYM/rlQOEjC/S2xUe5vhT5R+jX6md0tJt3QtJqRR9oIB9ejGA9GBgtuE6xWB?=
 =?us-ascii?Q?nuMxT2K0Lm2p62LRDsnHmdJB+i4EIQZhcFv3DJAUWDP//RPmNvWgm8tNoRGy?=
 =?us-ascii?Q?hSLm5BryoG7I1O0HusxsLxdhkSTNEQfyghd0Amkr21U1FawsjaKfVvn5Hsxq?=
 =?us-ascii?Q?dgTjovtSvdcH76B9pUqdes1G53/m0WOwG/iLIrWGmlWCL5w9d7OjQzF/UvKL?=
 =?us-ascii?Q?3Q+kVBOvlpe1pon1rciWN+iynYZWiJuLRg1HcmyBtl50tT++OXvYEqsP2Y0K?=
 =?us-ascii?Q?DrqZuauEe49X/tKgMpztli7qN+Bnh7SHYmng9L1ApLZX+XkkFQ6zZzY1qFPc?=
 =?us-ascii?Q?Uj3obzNWZ+OfYpcrOy4PINADWqOPFRClPR5xYTzpzUwjlgxmKqCcBXpJZJPS?=
 =?us-ascii?Q?s/fwhZAKcl0e/1bxCVyuuzi8pzhmlXEvQIW0xDveTGfXH+4bHsY1sSveKDP2?=
 =?us-ascii?Q?fth+6NX0J2XDX8tNrMqfO2PqhFSu616m5tHB0Hbn1ZsDE3aQdhP/gNbaOUEy?=
 =?us-ascii?Q?WLgSs6YQg7dgMM52hJFPXgNaKLlqHXLyQI6H23xrfaxpdbpjNCUgujbuys0d?=
 =?us-ascii?Q?GjWoOMEtuG/thzb7MyQVy9cPwjkf0Ko8j3UGFCg0JOSUe3p43hIqlSjlNtDx?=
 =?us-ascii?Q?bt8m+wbAhO2spM35EafwdHRZ9PxcM82o5s0sxiIJauC2XvqWx9pQVz7cEkLm?=
 =?us-ascii?Q?9GrKP79ZcqpKNABiU6pGdf5ZzGfTUViVEK53emKk9z3r2h2ZbB9BlIMUb37x?=
 =?us-ascii?Q?u+1QJuQJSh+MJWH5dBvG4hvTZAIb6/hoj1Xo0oQZpy4UoePgBJI8YgmqfL/D?=
 =?us-ascii?Q?Gd6HoqKaMHEhxxecBiAmGgbOyFkRYw38Sg6dRalt09K63Z7VycxaYeIHqccc?=
 =?us-ascii?Q?3HTajdC8DA8MOoDF5fNkOB2AqKvF01vBtoYr46Lg9upO4uwe96v8huuziKlk?=
 =?us-ascii?Q?V8ao71SkryYsL+RHECqBaZLmr5MVE9l63QyKC6oKkLwJpnv1fSGzR92VbZD6?=
 =?us-ascii?Q?g8X8zKOO6yk1vbkoX+OY4/JOnKRy4GnENfAL1T+UGhrwkVRJWc+6arRVqnRr?=
 =?us-ascii?Q?NIKKyFfCPEOss8fqE7kqfM3uqsccVVrUlLfiQ9f+ct3IzmNy+ccBNpRctK0V?=
 =?us-ascii?Q?cK4ecM82ISQv+099kW6Ue4c1ihYzAZ8XPRtnPcjRhMrpfKC3N9Tb3uB+ZT56?=
 =?us-ascii?Q?evWSmlqBbFldcR5/BaUxP0CNOXePH/G7nlrxkpdtZhLQ21x5/GCXaJFyM309?=
 =?us-ascii?Q?YQkkLQUJNWmHYZ7gFAYo5MM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fcef0c8-210c-44c7-de14-08de07f5317b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 12:04:41.3795 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OwslRnm51w72BGNd+lo5yX2H4El5ZTOX1v+tofcAuYjXgkjz2RhXia2tKH0kY+VZGTNByxlXClt32lV+ZBf8Ans6Q/EqDGNvFDOJG2ndahc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6650
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

