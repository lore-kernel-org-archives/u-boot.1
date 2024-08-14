Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9ADC52D7B
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 10:24:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52092889D0;
	Wed, 14 Aug 2024 12:24:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="JH+y/qpN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E25A889C9; Wed, 14 Aug 2024 12:24:45 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2072c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::72c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 793E88899D
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 12:24:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JskGRgEWccKzHr0s99TLRe0rxzE+61wg6JRxnIZMVqKZqGdDpk6uBcL1QIJEispqxxXf676udQXSdz1b4dTrXLP4CQybz4+PDeIPhZScMx35ouHozj9XUpd5TeQyyOxBgSniJ5G57obeZZZ8lbS6Tjjdt75f89FC3sqcZTA/0xHFcTppy8Nm3RucjYkoMC9h4A4x+W0m+Qx5TqenuVTv4iK01YXOMGBTHWoLgbHLKmLKiO2jJFJxLnQYKH4eBA02tozlr1NqT2S+NV4U8bNFFEVWhvKPNbWDCgKhy4QKx0VD3OQ/WpR8yfzM7rVGqd8ODI9ftmzI42XGm3MnUwuuBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVV4zV7rRxc82rvHTXOKPWgSEPnbxoyyAHNN+pvTp9o=;
 b=Gr1alMDQhv1vVsFu+QuSQ4E3zvHMD7eNNhVqKThusaq3ZxhjfeR4TM3DqTUj5lU4p2apX+rubmDwMMsqQJnMdGaIUU7REEkZXriN2d+IoDqZWoDQHuLHTQA0NUk8/OBeZ1Xop/pu/srBzdHP91seFOLcKEXUMYUwojWiMCMXPv/oKPFN4DJjpE78lH4Dk9kYlMb2yo2oqsFfJqUJe8cJg4tOMKK1Rhe+UVM6n+muSsvdmU/0hKdzGcrSlyy13HUIniDXkcEX1Kvv9KhlYKDV9rLqyPpOlwMDt+u1ZB7/DXrnUULFg1xoz/WqZBJK6F/r2zw6ZgVnSkAZD68C+Y53tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVV4zV7rRxc82rvHTXOKPWgSEPnbxoyyAHNN+pvTp9o=;
 b=JH+y/qpN84KDBIprSZ0LD1L5apiXBHqM6660N6HiQ+HTcadOvKGq0PnaJot6QUyYIpaurNiVLJgumZ+hys45V5epMXiLyf77666bGHGNoLpHo1titu8C1rCbsp6SNhKOxKGBpQ8FEK2eTVWpbq1BlC8WKNfDvZgYGeqEZDgnrYsvVjJUZ+nbd9APXCddvGHgG32AvH0f07RZwVbd1ujK288WDci5m76qJC3phmJDa+svjoEamMp0UarH1AjOV62JkL4JaSoEc8FtjsXBUHj9nMuICC5S0UQ6wKg3ESvX5OUWUK5gAPczYCGcL4M72LNmx4mx0AWf4IWVdq19J/FyUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB8491.eurprd08.prod.outlook.com (2603:10a6:20b:566::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.13; Wed, 14 Aug
 2024 10:24:42 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7875.012; Wed, 14 Aug 2024
 10:24:42 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [RESEND PATCH v2 1/3] cmd: mtd: add markbad command support
Date: Wed, 14 Aug 2024 14:24:26 +0400
Message-Id: <20240814102428.1347425-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240814102428.1347425-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240814102428.1347425-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0307.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB8491:EE_
X-MS-Office365-Filtering-Correlation-Id: 11d1ad35-8ec6-4c5b-3bb1-08dcbc4b4f3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|366016|1800799024|376014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0oIu6SSJUDF+ssJEE4y9ZpXv+h5IdyyE5arIqszhi2BSXWCVN2wooat3WHWU?=
 =?us-ascii?Q?f686P2Az4vlP3M5hGssFC10mRntuCqJxBS1TCuEzVDyeONHa0atz8mrP2fmA?=
 =?us-ascii?Q?cZIu27JvEC/kofF3ruBMP/QuIhirKMf9cGDrilVa0LJ0Kf3DpRs0OZuQ1KJZ?=
 =?us-ascii?Q?mSgWwO+JrpOtMoEN01rllxvBFXDTwCj90hGPDOoA8vAp0LDlA448SF/cb/IC?=
 =?us-ascii?Q?Q+zfDfJdyYdOKbGadcKdhEsIzE0PpoDvc9hsrDr+CKvKpY30xj74+cc/71KO?=
 =?us-ascii?Q?/UkXgBqBQbvmGb4opIfFyAPXBqQxoI0sg9/zt34cxB9teRTztO0D0HDJjf3V?=
 =?us-ascii?Q?OXiEV1VyYGabI851BCZ+bXbSL6CwJ39+GWpLMTTvQfaQDyAqIj7PIXGlk7up?=
 =?us-ascii?Q?AVWz3SMaVkUAaA1gJs7gt7ENoUxDAoP8cSaW8UAEGrDcjVxS4k3wI5niVBNT?=
 =?us-ascii?Q?SHAUlsutemX277aHgwSbmV3byCZ6ooM4j5NEIuCf120sJObSYH8qYsa8fb41?=
 =?us-ascii?Q?yXHpusWHr7RxmzxhG/zTjAmQVWhFpFJxRhAPVbYU6NIK1Pp3H03kx9QXFO6o?=
 =?us-ascii?Q?aXf9bLAVHU0t2HEjWAmtaDs+06bJF4DyewslVqlR7YoQN5W1FoOfJfnhnJVt?=
 =?us-ascii?Q?mHUjiqAT6nhQPqFsELgQMDJnsZdUriIDCGi+L/H55HJL3sSr6evI2NXK1ROe?=
 =?us-ascii?Q?x/1/4e4KeQdvN7J60/Grtx81yZBjQAyWPTsXRYxf9WG2RMQQ5wlTYLgZ3YE2?=
 =?us-ascii?Q?fJtIMmDUmn9DrEK8tcouWz1jyf3IotUupoiwBX9h6ElxxtpGkqlaSGtuDHUb?=
 =?us-ascii?Q?gA/S78rlPM2Q1dSm8Y5FNN7ZE7BcnzLuyCinEMZmpeoUcMMOsip7GaiUXJCa?=
 =?us-ascii?Q?F5h9R7nvbpPwTBXd5awz9ubdcY7DxEuB6MVteISgNsjADpHk7VCouqmlAlPs?=
 =?us-ascii?Q?gtNzaPAK3oRfuDlVZgQXqFoojwDl6PpzQFKPqUhplb3UjaANNX2c7F551Ymz?=
 =?us-ascii?Q?p412CStQvBXqIaoqr8RoA82VFqGIfcbeaELQAtfyFAObLPYyiHz/rA0XpRfP?=
 =?us-ascii?Q?3BiT3QiYV/MJb98eK9BvYo6HsU0tgyE4kO1UyoWE0FdYftv/ET14XNHxIovI?=
 =?us-ascii?Q?uC0edrKJVyEq/QTYKTeiMpRoprlfNem81hBi+3IXlPbk1gKM9ftualjHJ3o/?=
 =?us-ascii?Q?oK0bkViQ+axi1jGm0c666I/FWksL/SPnxu/8FoxDSqfeNpgSD04W8i5l1pW1?=
 =?us-ascii?Q?nXor3QiV25G7dPSARPbbiseQjKvX2D8QB3+FrUnwS/ZOlLcE6lbA1Jnd+dCs?=
 =?us-ascii?Q?p9hn0k9rMdpi9aIF8/D0M8cAVGAg4CPF3Brh4Yj3le/iy2WdaqjI8kS1dBHC?=
 =?us-ascii?Q?9pEmB9rAyI1eRCdZxurjTqKoOpvruS7ENj8uL/cRwbOKcQgMgKBe5t77ieiJ?=
 =?us-ascii?Q?FWWakpz2VP0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(366016)(1800799024)(376014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8HoLYpYR+Ot4UrHBJbWHYd0hhRVs8t7ujcmwPeiC+7LmgMuRfsZQ5sAIpK68?=
 =?us-ascii?Q?/eztzspEunKb66HIBrWy49Szipwm46BP5tmzzHNBKsd2WXN28bb3btaDCAu8?=
 =?us-ascii?Q?gfYvlUITSrq2qhziqPT02BIfSuFmDDRtmB+gUM6a+/8qriLKbQoKFFDGepBA?=
 =?us-ascii?Q?B5qBGmkq5FJEd0aLeBriHP67oLZ7V4TSXP5HQsl0R7+clv17hqnviBiWWRC8?=
 =?us-ascii?Q?5i2jbqZoOipx1JjOeQj4HPIon4XqdMYZDigvpBQjP3c+07LHJVycnQk5oWqN?=
 =?us-ascii?Q?NGruACIh2nveGtgwaGRJnJoZ8JZtIHuApLRtbQnMkyM8WVFTrky0+RBmxiX4?=
 =?us-ascii?Q?KQVNjPLxOrNy4kylh7Oq6Ufefu4AgQ9gR/9muvZVxYfX2RNETX5vORH7Nr59?=
 =?us-ascii?Q?JPsw83iUey44agWQ7RE1lHiKYP39XWn0UBWO+GeKqQ5pth9twciHEBouNLb1?=
 =?us-ascii?Q?XPPc6koFQMjFSJDj0oVzPkbp3EeWdSAPoZlWnOWai4lpvXgStRcHZL6NkkMQ?=
 =?us-ascii?Q?VqQ4fr8L/UZBZvm+wNh56Sbp/QQYCQpLKV51wQhKwmMA3LoLEIrxjEz6dhR7?=
 =?us-ascii?Q?HoMRQ7QK+cF4QW2nLknxGplFTa1L1Xu4y7xS8sCBPfxMzpPz9cGF3Z46TT2e?=
 =?us-ascii?Q?n85bOsl2tWL2bfFzE8mxh+4oQgD09zMTdMMt21auW9BuFt04QV6xXm5Ym3qJ?=
 =?us-ascii?Q?1UjIugusfnblVwmQaaLXSMCXNmz9+klW3PjExRO44Qf36pUz+b6d24Nz1FgN?=
 =?us-ascii?Q?C0ra9Hp+/LECBELMHxPB5s3XZhRvxSiZmpmf0rOa3w528rPLXT2BeS9rhj9N?=
 =?us-ascii?Q?qc2jYHo2ja3rIhDa0XRu0GLh47wAKS1012R+5HksBgGRndOShuq5z3KmxWFY?=
 =?us-ascii?Q?z9arDPtzPC+N9FpLyN3A8u9v4Co0SL/PvcKDqba7YE4lVoM/vaYBp+A70pqY?=
 =?us-ascii?Q?Ymh03fxjjXuRSgM6cHcsqwN1FOzYoLZi7HgnktcN8QZORQ++ciH4yzeY+Kyk?=
 =?us-ascii?Q?wT2dLH46mKWveVzau4b7M+PGUadMUcfmfsM1iPDXyASIvcMW9UUvg8vJQQ3K?=
 =?us-ascii?Q?DwhE23pAexpgyNrxqYB+MRd6nq8ye6TIYXcpBVVZiIOHYnuyEKgRQ92Je7Hu?=
 =?us-ascii?Q?EV1ik3sQjPRrJ3VXuN123AbVrS86u91y+KidS8C+mEO8krkGMj0tYCdjT3yL?=
 =?us-ascii?Q?Pg0RjdHHGwUD+5crcM1YwFNFyhAb/vUHmvmx06owAePcz8qDS43TVvzLebRz?=
 =?us-ascii?Q?yLzI/RSf03xWsnyFyn0dIfxssS8KI/VsvB9lIYhEw/zpKVv3YnLySDnZJUC2?=
 =?us-ascii?Q?QHOpbUPKJFjLIk76OQJKJnDR9rn9n9jfna9f+pJLReBNxHSgL889bjvCUkg8?=
 =?us-ascii?Q?XUPJj7TvPucxNUZ8n8wDFGxC6nFMWQd4itfZ2SG698qal7BRR0KVeNNq222d?=
 =?us-ascii?Q?Dothzz9bWNHDxxHmJw85JLB71R8HdVBJJTRimZ1kTLe2fuPbm5v+nC39QkCj?=
 =?us-ascii?Q?h3gMa6zAaO7T4f4P0FQ3GSZgD3taRP+S09W2X5TO+sN9ADc5LtZWRLDTML2w?=
 =?us-ascii?Q?TVfvyADfozluks3ytqy527jfeG4Lymwz6eQC5L0RUlV0Wx2N3gHApGX9f0Wf?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d1ad35-8ec6-4c5b-3bb1-08dcbc4b4f3d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 10:24:41.9486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j+tpm6PKOEeqn+dOJr8uDOr7Fk13Llr+Vk9md2BZ9Q0WSNM/j6g4X2BTm88/eHqk/ae6GvHvtbOjwUyFFTSDj8PzJdFhOK8a3IDmcZEn+BQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8491
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
 cmd/Kconfig |  6 ++++++
 cmd/mtd.c   | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 978f44eda42..53ebafcb610 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1433,6 +1433,12 @@ config CMD_MTD_OTP
 	help
 	  MTD commands for OTP access.
 
+config CMD_MTD_MARKBAD
+	bool "mtd markbad"
+	depends on CMD_MTD
+	help
+	  MTD markbad command support.
+
 config CMD_MUX
 	bool "mux"
 	depends on MULTIPLEXER
diff --git a/cmd/mtd.c b/cmd/mtd.c
index 795aaa2b37d..45084d39d3a 100644
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
+#ifdef CONFIG_CMD_MTD_MARKBAD
+	"mtd markbad                           <name>         <off> [<off> ...]\n"
 #endif
 	"\n"
 	"With:\n"
@@ -807,5 +861,9 @@ U_BOOT_CMD_WITH_SUBCMDS(mtd, "MTD utils", mtd_help_text,
 					     mtd_name_complete),
 		U_BOOT_SUBCMD_MKENT_COMPLETE(erase, 4, 0, do_mtd_erase,
 					     mtd_name_complete),
+#ifdef CONFIG_CMD_MTD_MARKBAD
+		U_BOOT_SUBCMD_MKENT_COMPLETE(markbad, 20, 0, do_mtd_markbad,
+					     mtd_name_complete),
+#endif
 		U_BOOT_SUBCMD_MKENT_COMPLETE(bad, 2, 1, do_mtd_bad,
 					     mtd_name_complete));
-- 
2.39.2

