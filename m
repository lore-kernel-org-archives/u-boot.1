Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 372ADCED245
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 23:21:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EB4488DA2;
	Tue,  8 Oct 2024 01:20:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="L6JKlsyO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6986D88D5D; Tue,  8 Oct 2024 01:20:35 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2070f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::70f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AB1A88D61
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 01:20:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+n8Xob/tdqQLthKll89nZ6f794w+R+t9/YbW4ngqXuyoYJ5m+Yk7nCTmlP1hxbHA3NpzVAOygeeugsjnEVJkQy9IzMYQ7X48aFVZt6cf3BpxkdFOZIKIzE26j19r7oHRGSNDp0o925bh7anVTv1hnpwmOoW/aom5cYjArI0mnfND8XHzaKikvWKalHA+b/Tbfl6v2zYcsf2Urshyw7ukFa/ZClcUM9FJHzNb0xAOI6rrtEmGr8IntRD1MZOtnvD3I0mm2bg/fZwqsa5tdqRDJLZtrppK9cv70Gl5UMtmVOiJfKvVLRf2HVTtObxa5t9sAGghayK/0oyrOkrVIUE4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CP7cu49RdTLa6+I7s2mADeQlvCCEE/CE1mFdpSvF6SQ=;
 b=BxPtwf9At4GwBzyqWb31bu+I1OiFA5LkPKdhGpkfCL8yLrIWkQFyStIJkCLusp3XeJ8fhbUnjrRPa/0FCwgYJT4S0TM65zOg0Fs5cSznvL2c0XWZIVMsbddtCdA89ZOGG/evx6Td0zaaeConRgMZ13f7UBUH221Ie+cjczbAhbetz5wtlsa4l0jPWM0vj7NAkQ/S9hYJOmhcvzkO4Vd/OmzUMLICWEk8hshu7Vhe5OCtCIk33tLE8sN+EeWkjoqS7e0Ir7gmgdC1kb7/ByARVWgp4oOEL0WH7QyiBJdPEEEAW+cGguUXmnjFOABgHtuWc0Q6hhisFLHAafc+AV2C4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CP7cu49RdTLa6+I7s2mADeQlvCCEE/CE1mFdpSvF6SQ=;
 b=L6JKlsyOIQdSTxLU2nyY27o4WAmiHbGvZIcrN4G+0VU8S2VklyvDR8+WXV1AeRsh2JSSlpknX1HnVBx3UIyns8XCGCZ8nhJnVe844dpP0WKES5ffmw1oP8bE90qjSSywLLFZwBh6G7zZWnMPIE6F+9d0fNXhFlguCN6o1eEHrOzqztgF/Lgu0hhqRBSwLWZrkZNkLSvIzE0J8mXXS02JNXIPxuFpHCk1A8Qak6RILMg5pu0SgX2RuXjoLZi3GOlTt0ESu0fV0Vpto85LVQnF3X+EJ5aua7vm8be5TcxDgZuXt9qfhNyV6/0CviTKUsHZ9eKzhiUWGEBEZBS0y2AwUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB9140.eurprd08.prod.outlook.com (2603:10a6:102:30b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 23:20:25 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 23:20:25 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, u-boot@lists.denx.de
Subject: [PATCH v4 1/3] cmd: mtd: add markbad command support
Date: Tue,  8 Oct 2024 02:20:14 +0300
Message-ID: <20241007232016.1666523-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241007232016.1666523-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241007232016.1666523-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0050.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::13) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAVPR08MB9140:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eeadcb9-eaf8-47b2-703d-08dce7269f86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|52116014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nKr/8B5PM45zen70BM7Jjs9CKDbyhuHKCUZTaCBLMkUk7TfUhdKA/fEL6KB2?=
 =?us-ascii?Q?mg7diWrJ/yRX16nNvdLuTsbCL7mj9hK5UygJQAAy5Et1bAK3F0Ct++H7gPtc?=
 =?us-ascii?Q?gOK8Lzxk2m2aYM7cziulo+uHgN2lXDUfEZ3FeKbEJTvfDimFGIwTfDoaecQd?=
 =?us-ascii?Q?OralQCqwLQ5zKIhJhvf1JlhoCuthhWgl8W0jktUBzV6PdB4HcxJa/ZzA4PFo?=
 =?us-ascii?Q?EDYdLPWB0X+mya3pJXoiRwTIypBcsGYNCMs1Q7Z2EmutmDrH4JcyjappNFDD?=
 =?us-ascii?Q?rv7Vd+4PRArUFdWPd7Tcrc9Let1vH8HFDoTmqa1RaEndQ6p3KxbBFDP9cmFH?=
 =?us-ascii?Q?QqwTTtiEHqNGbArrXkrL+6o6FV/6mffyKBBEiXYYs/ryrQbnyZ17XpQlhKtd?=
 =?us-ascii?Q?Jw7NaYPgYR/vWTuNDaOBABb94b9jUD/8dgHhZNpKRkYufbP68CfQh+E40kPt?=
 =?us-ascii?Q?o9i9UsVQRC7YIhFe2PnVNKi7L+6wYvXbL78ipq9vst0UT4/pRiUvYzMBmmMs?=
 =?us-ascii?Q?RJR2vSC9iVSmhv0zgTDKfpfjGlCYO9MvIa7MC0BvJvUMevpqnoq0mnQQXJpf?=
 =?us-ascii?Q?MBbhmfUyEu7qp9iWfHTi+omFzfWIP4i/VKKShWXxQaDB/yZrk1D2jLIYCPUg?=
 =?us-ascii?Q?uO7G4uceUd+shEG0rMT2CZBy+225ZIwnzr2dVdzZ8t9k9g5M8OYa/zCo6IBl?=
 =?us-ascii?Q?d/IdHC+88NpNNr8NFt9rCsiyi2WiohRC6S+syLrkPZxk55W6BFfttV5UJL7+?=
 =?us-ascii?Q?x92k2St1l1+4n2ktMC1QOJkYwOKi9UU0/MCsggT8wiXmqwEufSpC+BCDrqtP?=
 =?us-ascii?Q?xcH5P/ElPSZrVFBP4pWmgPrr5qaX2WpQUiop88qQWTJyCDVwktv1u38CRJEN?=
 =?us-ascii?Q?b9fYn+tU+kBNGaoJaHABA2mlGfGpDHlkgFK5YAkOJYF1LTpJ58zHXFRweHMn?=
 =?us-ascii?Q?4KHkhmtYR3ffVGT05UzmsGUhL42BoU7gyE93eE+hG4hVPWwoI6Vdo4lY+n94?=
 =?us-ascii?Q?qOFBED15d4OqTkpdh9sQfovQ9UnsX8e6ncoyWUS6sXTRT6LFmxSXkV2AfRCe?=
 =?us-ascii?Q?IF1e3awQO0J29j7kqHjO7MnJ4x9bYlfaXBREAKfWFodjDGmtApcE/ewmvoyQ?=
 =?us-ascii?Q?NMgb1w0Y4/HVFQSP/OLIb5IrsK3L7jxSCckXCNKlGg5uY3H1kPXaGXH0/3wi?=
 =?us-ascii?Q?ygnZjpFgR0KzdI0xElYwpZqVGm8RREbcpu7EvyAP6gguRtD0rqKc+ygt4V/o?=
 =?us-ascii?Q?CaFLlCx+x7/t58kfS3kQL5bQoZYQ8YpPGHooLkCwH/pAOyAdK2S318tNmnRe?=
 =?us-ascii?Q?0hw4tmTnkcyA1O1YhhSHw9E4c6aLn7wBRn/kbiRjXQ71upk82rf3hYlSDR5C?=
 =?us-ascii?Q?o7+fTu0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ikkrefDzAhS3GQVZhWNqRGeZ/vAtDtjgkuRcquZtHa95ywt3E57By5lUmdBE?=
 =?us-ascii?Q?4gDFcbR7ID+zMiq6JzP831nW41KD++iMyR0/5msTVmq/WkXCZmxuBzQFsL4y?=
 =?us-ascii?Q?HPc8BsS8oeq4lk7N/DfNERIOc+5fNT+qcbc/fc0UP6ex4hFvxBe0JGBP1C/D?=
 =?us-ascii?Q?Q3ZyE1BAu7tsq+6tlDrE4kMM/2Tgor1sLiLJf8m2uhakkBylsZH8L9CLRV+Q?=
 =?us-ascii?Q?fDyXOgjBa74HniiUcfrru2Id0B/foXxjVJI3HJBCtWlweDj+CjS3yvxIPw/O?=
 =?us-ascii?Q?gqIlvCvV9vA5IzMLaRLIvef5SxqZg3Tssp8y0CJ/oOJ0XXouDZvH/qNZIQX5?=
 =?us-ascii?Q?0DKQGWBXVjXrEylXvPqbySRJ7TRjo6iGM+6xSa0b+aX4TMvySlTofIhdkorg?=
 =?us-ascii?Q?ZD4fsjpQircIN0q0n7EeJiWcA18wwE4Oisr9wn4jQZArJe2+ySwsbtJECpcC?=
 =?us-ascii?Q?LpaRxRufKjfoCV+jNzz1/rDNd4ewhqGmAYTEmdGEL2NtuzAYh/8vI8yZxvky?=
 =?us-ascii?Q?wd0v7P1KIqsJp2w9PjSv7Z7LJljC66wnIzAt89hp3OuJ6jLs86Xxr2/quE9a?=
 =?us-ascii?Q?giLuqZ+oo51Nm/7KosS8XQqD8cTz25zOhJ2FrOnheqixZobbz5+blzBSsd4j?=
 =?us-ascii?Q?BWvOYgkr/kw9pCmjXuQ9bj2cfSWGYD632TFDXYTbv1VG/8R2DpYTjxwN9bb7?=
 =?us-ascii?Q?8QBaeD+rwWgeugAMdd6e52dL88IqXBJofrhrNhoRoPOJHc7kFmp2qcyqHgN1?=
 =?us-ascii?Q?Repqf1A3+mOsTDkGhE3RDbZaS6Gxuhu6LZpaQUeSVOHizhBNIwFN5sjXNdnm?=
 =?us-ascii?Q?k03lDSUolVj2d6HLS/UxwnT8NvZZiU+kV2mqSXPzhJezPVSqIa9PwqUT8jIF?=
 =?us-ascii?Q?j2MYV/T3n/QZy0jI+6f6bGz64kM7uRq4x3bsk0HVNICdyuok9Q3/Y6HFUdH5?=
 =?us-ascii?Q?7VNNd7kC1mgtexgBVS9t/OcvfvEaTA4peQ3zMZGT3Yq7uZ0S4hNfFk0m/+fa?=
 =?us-ascii?Q?2FY5p+WEIBqG/ciQKKm3KHExQ5TEyLTYmfyOcoFaSHgvtg46Pxb5Uo7Cneqd?=
 =?us-ascii?Q?AXrMReHWlrtKaNi+PtqHzKlDfwuH4nJ3ekfX4HB8PEsC7GG1ygNmhvqnbFJh?=
 =?us-ascii?Q?z5D2SJAyLIKrm8mWTdc2vY7rZajDjyVNRupIhOk83YjbNsBl72EY8Y628Acr?=
 =?us-ascii?Q?ZuX8m2CFP/izdcO/hhj30dAJLulfo9HjcUaGLNeZCf6QxrrCYRCfORq5D+OS?=
 =?us-ascii?Q?4pJTgSz5Hc3VTZKX5QOeXCS7v8436A6JVF1SZCTJAd+ncSYhITCqX+uvEXuf?=
 =?us-ascii?Q?qHgyDsQuBM+zSyk8Pzdo4jKCJZ4FKxb6m6MaUnHyvDPiWoByQyKoDENgK2W2?=
 =?us-ascii?Q?ekM6R4s9PHhMP9i+xCpcsuIt3gmh9ZF8cKS+GCOAqdnn7ijxaDbDz+tjUgXv?=
 =?us-ascii?Q?sgdS2VmP3HaajFsoue49HBNX61WyAi1n20UL0cw7V2XE95laYmazikv6Iq/g?=
 =?us-ascii?Q?+/vtklmf/bQeymWSA2p2B05KVJu0K07KxJRA+3P8UUEvX1aA7LBkG6xsAY/v?=
 =?us-ascii?Q?KH//4acyOPCA8WnJsqF8lRdfAOOwaMaFASaAPoxhG8exLTgcD3NCPeM+Iarc?=
 =?us-ascii?Q?N0vzCi4Lt+lZQDhXKBeAp9g=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eeadcb9-eaf8-47b2-703d-08dce7269f86
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 23:20:25.5332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5n2jKS0iye8rUf8J8dTdxciWvbhcgl+ysC1pMG6mBdKoF6563vty9HKPF+/M4yI3TZud+mqV/zMAkm9XJ1JhFmEOCqwCJM/TIgnb6hKNUUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9140
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

Some nand flashes (like spi-nand one) are registered with mtd
subsystem only, thus nand command can't be used to work with
such flashes. As result some functionality is missing.

This patch implements 'nand markbad' functionality for mtd command.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 cmd/Kconfig |  8 ++++++++
 cmd/mtd.c   | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index d50f6396fc7..29d1929ff94 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1449,6 +1449,14 @@ config CMD_MTD_OTP
 	help
 	  MTD commands for OTP access.
 
+config CMD_MTD_MARKBAD
+	bool "mtd markbad"
+	depends on CMD_MTD
+	help
+	  MTD markbad command support.
+
+	  This is a clone of "nand markbad" command, but for 'mtd' subsystem.
+
 config CMD_MUX
 	bool "mux"
 	depends on MULTIPLEXER
diff --git a/cmd/mtd.c b/cmd/mtd.c
index 795aaa2b37d..ac78df75267 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -691,6 +691,57 @@ out_put_mtd:
 	return ret;
 }
 
+#ifdef CONFIG_CMD_MTD_MARKBAD
+static int do_mtd_markbad(struct cmd_tbl *cmdtp, int flag, int argc,
+			  char *const argv[])
+{
+	struct mtd_info *mtd;
+	loff_t off;
+	int ret = 0;
+
+	if (argc < 3)
+		return CMD_RET_USAGE;
+
+	mtd = get_mtd_by_name(argv[1]);
+	if (IS_ERR_OR_NULL(mtd))
+		return CMD_RET_FAILURE;
+
+	if (!mtd_can_have_bb(mtd)) {
+		printf("Only NAND-based devices can have bad blocks\n");
+		goto out_put_mtd;
+	}
+
+	argc -= 2;
+	argv += 2;
+	while (argc > 0) {
+		off = hextoul(argv[0], NULL);
+		if (!mtd_is_aligned_with_block_size(mtd, off)) {
+			printf("Offset not aligned with a block (0x%x)\n",
+			       mtd->erasesize);
+			ret = CMD_RET_FAILURE;
+			goto out_put_mtd;
+		}
+
+		ret = mtd_block_markbad(mtd, off);
+		if (ret) {
+			printf("block 0x%08llx NOT marked as bad! ERROR %d\n",
+			       off, ret);
+			ret = CMD_RET_FAILURE;
+		} else {
+			printf("block 0x%08llx successfully marked as bad\n",
+			       off);
+		}
+		--argc;
+		++argv;
+	}
+
+out_put_mtd:
+	put_mtd_device(mtd);
+
+	return ret;
+}
+#endif
+
 static int do_mtd_bad(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[])
 {
@@ -773,6 +824,9 @@ U_BOOT_LONGHELP(mtd,
 	"mtd otpwrite                          <name> <off> <hex string>\n"
 	"mtd otplock                           <name> <off> <size>\n"
 	"mtd otpinfo                           <name> [u|f]\n"
+#endif
+#if CONFIG_IS_ENABLED(CMD_MTD_MARKBAD)
+	"mtd markbad                           <name>         <off> [<off> ...]\n"
 #endif
 	"\n"
 	"With:\n"
@@ -807,5 +861,9 @@ U_BOOT_CMD_WITH_SUBCMDS(mtd, "MTD utils", mtd_help_text,
 					     mtd_name_complete),
 		U_BOOT_SUBCMD_MKENT_COMPLETE(erase, 4, 0, do_mtd_erase,
 					     mtd_name_complete),
+#if CONFIG_IS_ENABLED(CMD_MTD_MARKBAD)
+		U_BOOT_SUBCMD_MKENT_COMPLETE(markbad, 20, 0, do_mtd_markbad,
+					     mtd_name_complete),
+#endif
 		U_BOOT_SUBCMD_MKENT_COMPLETE(bad, 2, 1, do_mtd_bad,
 					     mtd_name_complete));
-- 
2.45.2

