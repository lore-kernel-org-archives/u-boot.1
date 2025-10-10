Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD2EBCCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 12:02:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26D1684327;
	Fri, 10 Oct 2025 13:59:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="t6g/CIO5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F17FD842F8; Fri, 10 Oct 2025 13:59:05 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67DFF84241
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 13:59:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gjt1pU7QZPEe4hiCjUCyXj35cI8U8Fk+9zkanAYrMU18cy4w6VtHfJuZRVjyQMAwYsCZk89kZHb3u6oiFwHDN21am1tLaGybdbwun970J3q1jSY1Aj3iGdBXO5PmQ8UEtE0S6YsYruenqIkLNd6eEyBPea4VyZCYZx30t+5AQ9+7IJXDQapkNOVekXbL3a8rxjJJRX3ODx3qn8OuIdhCWlKoofrTXXmzMffEBsvRc/b0fvOaxcyK/QXwUMBkkLCcxLb0cXB7610/SZne00idB4o9MEpmHewsLdxNq/jU741+t2I/8q5vI4/cn5/M5R1kf5j6YbvRwJpC5fRdfTjFXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgUUA7IkBZJVn6N6JQZ0p6bFm5ULXMacmaSt8UMc5ZM=;
 b=SWEA6WufRxy6qTBajGXL3+lGXq8QcAdiEq3/7DmHZ+eVT238UN9PjQV07CTG3AK24Px/Y2wFM8U/x9y4eA9C1/oDwapvMqKm1yeDoot/VuVPdrLqJgFr4kDS5aBJRPzg9Ygk14fJPQkr+voSnUGk3ws1yCfqYyrTPSghAl9Ffi/t+6ciNx5m9C7tuYARAa/DQqS3L6eu2GGg91pu0TDLdWV4mnKzsKONgLitB3XQrAcQogJFnwwxcnxIawxrLJo0gH3WZM/2X1yTQtqhzYejqhkKtgHpJ+9KUOu+YmuX3/I3OwyjZTtgluORegEO3MEt8Bo8/LSiRIicrMChOve2Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgUUA7IkBZJVn6N6JQZ0p6bFm5ULXMacmaSt8UMc5ZM=;
 b=t6g/CIO5FOvzCdshgfvZ8npziIuojjdCHOt9vngTMgbJZ+b13PmsM0l9r/bdRxQCt1QUMJ9mW/lYkag0IbKiZ7TMlPVq5tMIwPhhATe1HAjUvuXDpbVrt//ZZXrzK0/opLy+nOQEho6ilX7d7oylVv2WujRPqmMthPZM/nLrUqZFt4XszB3KZeFbZPXclZYVTiEbR0hIURqhqKqjbdpYYxdAMEphn/vijGMblKOivwOOszs3Cpn7GNa2ZlhaYuWJqkd/S9pa+FCmyoLDFfqudw3wsV+6s43nvVFnil34BKjoKvYbCyrMBgpL5vawlFK60tMd7JDoADdDlTLfPHEFiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV1PR08MB10641.eurprd08.prod.outlook.com (2603:10a6:150:16c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 11:58:58 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 11:58:58 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH RESEND v7 18/24] mtd: spinand: Enhance the logic when picking
 a variant
Date: Fri, 10 Oct 2025 14:58:19 +0300
Message-ID: <20251010115825.1531775-19-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010115825.1531775-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010115825.1531775-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::19) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV1PR08MB10641:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a16a0bc-d019-4867-b51f-08de07f46517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zP7/Q1pnif92nGl3iED5EerrR8dlyKJOsex1/uJL+cJGJbOz4+aPRhYqQm2Z?=
 =?us-ascii?Q?+ApqCkxysMbaVN77dmKGBApwtxprkr01jRl4f6nZz0LrRB2RYgeExNnPSGT9?=
 =?us-ascii?Q?OX8Hl5XidcCvuK3EZeopNJxyJleqV2NJzG1Y2BuOtXJf1C8VsWQFgWyrYzyn?=
 =?us-ascii?Q?XCGHoXjHWje+eZ5A90uhl5fOI3WR0+lxClun81Vdz/UpvQwenzCN6L9j590+?=
 =?us-ascii?Q?e/uLdwZcl96WYD9NBoYAu+DZSZORXV68MD/2fcYmcZsPIVJOY+I/RwZfM799?=
 =?us-ascii?Q?UPx6/WBj6QAJbtN1YXiALdzZXphWyne43pIPtn+Jw8gfZepGlDccRUIMbXNa?=
 =?us-ascii?Q?B2OGnOg/X77DGwWvTDmUfyv2kMlotfngq/VJKZ/5kWBufLmGUggJNLrMtoti?=
 =?us-ascii?Q?H0TNdF2RC/hB3gLwdG4u7LAnIbre+TIrHmfvDG93JZdQZ+0A1YKCWOBSMzVK?=
 =?us-ascii?Q?0pvjDVFMlWHu0LTPK7TtzKyKctNXyZGMjUUeW59SX9QP4sBpplkO2v4yEDGV?=
 =?us-ascii?Q?+BdIObMMLWdIti0xWGE3v4YJAyUwtR7Tr6GFDC37c+FhPxL8y0pttqHJxDoM?=
 =?us-ascii?Q?zC5KSSaO30cr52HdQDHDLZKsLgvdi6V3BMg02PU7kujE6FTpgP+FxOjw+FU5?=
 =?us-ascii?Q?0o+KNrdZcFtlaIFWt/mu/CN81t1oYFn1goqd6oWeFoOriOW7i7TtjZpPX29Y?=
 =?us-ascii?Q?44+LH8pwUaY2oV5C9n1Znj0yvpOnxLSL3gQalniHBIFK3JKxPbxVYVZHCvw7?=
 =?us-ascii?Q?xnFUUT4t1jkLv8MhVKhbmaJwxQI4J7zuziq5WhSE5O2cSOkikjKdoyAAAyph?=
 =?us-ascii?Q?pwj5jmhfaFxEboniU9HPdLpLC2gj0DJYJJrZSPHxHJNUkDomX21CPQAqrEPZ?=
 =?us-ascii?Q?JgS4EXkREIZrZscry7imBghAbEJUW91rWT5wybi7LYJ+cAXTorwLbF/4xGlF?=
 =?us-ascii?Q?AW0qM6zD90gUt7twHWEV+KVw2a2MKN2mJZBA+buDD6Ky6QvK9uZvkSgcGwmv?=
 =?us-ascii?Q?sBS8G31JVQRzDE93hIUZC42UoEmSX+yaM8JGzDXRugWCHMsCw+SP0MxdG9+T?=
 =?us-ascii?Q?SkX03VsNVINypCPHA7qO+M/WKyMNnCrdet+4S3BqqVv7ojd5zp/3DzrXaNmR?=
 =?us-ascii?Q?s96e2YzAi5av8IXAgNf91/elijvYKMdsiUEQHEtdnbWf//yiy5o08WdnfTlO?=
 =?us-ascii?Q?1khjvd/5B9s6ocYdHWKClj0QmsNwd+0qJ9+Bndy5ekxQqs3tK1neRdgdNtXP?=
 =?us-ascii?Q?4VMQ6Ksrx8mzn1Jrvt/myWrjsOYvsOq2BP3Ovv0hAWVp52LkJtm9Ba0BpFER?=
 =?us-ascii?Q?xdgys88xjq68ZzHVbPpDYDRPWlTfZ6epZo/sbbYQwGFrJXvOAAIrqhG4DDeL?=
 =?us-ascii?Q?F/Z4yqwKGZADo9LGKeNxYfPDnCMeq0HpkCpj77q4gd0LQmSd3W6cKq8oK0je?=
 =?us-ascii?Q?w8Cb4rulST1SEP8QaJlHtm//ABmwKNqbJ2vRIF+WBPOZ7ed7IkFrNQ+2CVCE?=
 =?us-ascii?Q?vytnJrhd+VpzS3NTuilPIzUsR2L8ej4StDYPE8RsKIAGiCdFndeposaf4g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3YkULkLihtEeIyB9wTcEoeqMnY/HEBxQJ8jfqNjHhsIJfxsO44CiU8uhG0Fg?=
 =?us-ascii?Q?5btB1nMK97/NpaS9JqGKVRCHn998bfmbs4jZC2tllnSaj7Fk7QZsBCdN3yts?=
 =?us-ascii?Q?tY4PYSDXnbjwNPTZxlCvfXThXYJ+TZ9RejWjf95UOkEADMpf06jbAZ6N9eFv?=
 =?us-ascii?Q?JqMupTjyxqDRtCHZMA1Mm2GteevsKkCb6lsF9X2IWoLAscL4tPg7OvTrRGiR?=
 =?us-ascii?Q?Wl9Pt26puUdza5+LTzw6Rkrr+RZzhXtyY5SqM4QdKMsg7EcU5DPmapCIMDb9?=
 =?us-ascii?Q?S99IRg1yHZKB5kaBZmKU4aBIoxA7k0L2sxL52KWNcOi0eGxteVfVcyA8od99?=
 =?us-ascii?Q?t78GbeQLCCxASjZXBeW6jyYVl4uUSNIkawr3+ND8LhS/d9eWMCNSL5QsGRBV?=
 =?us-ascii?Q?CbKb5qxZFHXRu2jOIiqQWIEjaDP1NBuAob5UrGQOWtCeKeoQFs9qTAIwMKO1?=
 =?us-ascii?Q?kY5J9uWV5E9cQAgr3693wVf7o0R4zj7xlJ9GkYeevqJIr7uGcJ9IHSy7KrNo?=
 =?us-ascii?Q?swIVj45ovDrN5DuxKw+n8dPzbSbMphoY2/rjcBNLo4RCK06Lm+lYjfNJhxOI?=
 =?us-ascii?Q?+DgwOzgdWF8VY2YVyXK2JOJDf9kuYMkQmq5tcLb0rVTa/QbSuFdRvXCweip2?=
 =?us-ascii?Q?AKshWfRos3QtnLy9aL2+4aeR/kPP32tiwAKl1nZSlP3oSn+A+aOuTZhS2chz?=
 =?us-ascii?Q?WG5dO6da4K4hKIHzz+tC2EtdhhH/0QtGUl8NzB/c8CdMuh6niQggH0NI499T?=
 =?us-ascii?Q?348acQO6u5Idl8I8ZiyCN1hepn1KJAZ5U+Iqj12IWTphTSGu42I1vRjs0vvq?=
 =?us-ascii?Q?WzYaPK2+0oAxkVGdSO6nuOkQ4Tuado1tH/g0Rj6169rydsIaipA7VNkTz4xG?=
 =?us-ascii?Q?wreWcd726U+rkqz3b/894db+6tkXoq/zbCPipC1gm2AeaIxBsR4oN2M7BeOV?=
 =?us-ascii?Q?NIu5r1cW5Z3kmZofYkFv/ch7dLDGw93RoSHcviYD7+YP9KQbJjcyPpLcAHeA?=
 =?us-ascii?Q?c6/OtB8NoHkk2kBt4rZbUeEYPYmpiE51uuXHhO4B9rYW3QCpV6NCwfYrHGLH?=
 =?us-ascii?Q?UwLSykcm95VOoUpALBA8be8/TDocSBjXWtuZ+ZPNz5PJ6dcxUJ+wpj7+LFaS?=
 =?us-ascii?Q?5bTFg2TXN+NqnkTpkbGv5spWzVn4Wry8qCHGpLC/AW/jnfxcI0LdkYiTfNWG?=
 =?us-ascii?Q?nGGV6Dd46ZNibqWXnWU46ROgp6o62xT3TmuRWSCj8CxPt5GYtysWB/O6sVGB?=
 =?us-ascii?Q?wCtGElvnomfTDEgxdIho3YWEvVNb1gOJjpMN4kZzmZp4PFydSrxE7ce8q9oK?=
 =?us-ascii?Q?baMyJ1SnksF8YU/oZmK7fm+0dGz6+EWtCbpm/wsKcy1dzHwhB+WcEFwzCrSD?=
 =?us-ascii?Q?LzyHg+obGlHh0zrpenkMdEPYRuJ2SDX770MLvsWMtIW1iOt/9CuauIWja9fW?=
 =?us-ascii?Q?hWd4Qf6nsYnf9M4o2faVdOwmEBdETaDnre6KHyPKhO6uMH0r+ryV5qrEA4sZ?=
 =?us-ascii?Q?oMU9BCFAsjdERcRs0uC6rLKeYVKPY2pJ+/i/HT7h2M2UwzojvBgUZp9Yvo34?=
 =?us-ascii?Q?TprsxYmSzV48EG85b6WMjmlvvc1YtQtdXxxKyqySfn+4nuXwjUwWXD00RbPO?=
 =?us-ascii?Q?JJCYCRFIZAe2QqKZ2neLGOE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a16a0bc-d019-4867-b51f-08de07f46517
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 11:58:58.4670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cG5cTxzdHPMf6aQpSZW8djnx/oQCSI6FZF8TY7iuuDwrzr68W1oDRbabwOrReWbR6JU+2sGJpehf2SDpEDIhy8zi1nWjZBaOb8bdh218epM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10641
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

Currently the best variant picked in the first one in the list provided
in the manufacturer driver. This worked well while all operations where
performed at the same speed, but with the introduction of DTR transfers
this no longer works correctly.

Let's continue iterating over all the alternatives, even if we find a
match, keeping a reference over the theoretically fastest
operation. Only at the end we can tell which variant is the best.

This logic happening only once at boot.

The patch is based on linux commit
666c299be696 (mtd: spinand: Enhance the logic when picking a variant)
created by Miquel Raynal <miquel.raynal@bootlin.com>

The code was a bit restricted in the functionality since not all
required functionality is supported in the u-boot.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/spi/core.c | 13 ++++++++++---
 drivers/spi/spi-mem.c       | 32 ++++++++++++++++++++++++++++++++
 include/spi-mem.h           |  1 +
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index f16d3b0335f..daf6efb87d8 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1266,10 +1266,13 @@ spinand_select_op_variant(struct spinand_device *spinand,
 			  const struct spinand_op_variants *variants)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
+	const struct spi_mem_op *best_variant = NULL;
+	u64 best_op_duration_ns = ULLONG_MAX;
 	unsigned int i;
 
 	for (i = 0; i < variants->nops; i++) {
 		struct spi_mem_op op = variants->ops[i];
+		u64 op_duration_ns = 0;
 		unsigned int nbytes;
 		int ret;
 
@@ -1286,13 +1289,17 @@ spinand_select_op_variant(struct spinand_device *spinand,
 				break;
 
 			nbytes -= op.data.nbytes;
+
+			op_duration_ns += spi_mem_calc_op_duration(&op);
 		}
 
-		if (!nbytes)
-			return &variants->ops[i];
+		if (!nbytes && op_duration_ns < best_op_duration_ns) {
+			best_op_duration_ns = op_duration_ns;
+			best_variant = &variants->ops[i];
+		}
 	}
 
-	return NULL;
+	return best_variant;
 }
 
 static int spinand_setup_slave(struct spinand_device *spinand,
diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 6f06650384c..db44a7b26eb 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -499,6 +499,38 @@ int spi_mem_adjust_op_size(struct spi_slave *slave, struct spi_mem_op *op)
 }
 EXPORT_SYMBOL_GPL(spi_mem_adjust_op_size);
 
+/**
+ * spi_mem_calc_op_duration() - Derives the theoretical length (in cpu cycles)
+ *				of an operation. This helps finding the best
+ *				variant among a list of possible choices.
+ * @op: the operation to benchmark
+ *
+ * Some chips have per-op frequency limitations, PCBs usually have their own
+ * limitations as well, and controllers can support dual, quad or even octal
+ * modes, sometimes in DTR. All these combinations make it impossible to
+ * statically list the best combination for all situations. If we want something
+ * accurate, all these combinations should be rated (eg. with a time estimate)
+ * and the best pick should be taken based on these calculations.
+ *
+ * Returns a estimate for the time this op would take.
+ */
+u64 spi_mem_calc_op_duration(struct spi_mem_op *op)
+{
+	u64 ncycles = 0;
+
+	ncycles += ((op->cmd.nbytes * 8) / op->cmd.buswidth) / (op->cmd.dtr ? 2 : 1);
+	ncycles += ((op->addr.nbytes * 8) / op->addr.buswidth) / (op->addr.dtr ? 2 : 1);
+
+	/* Dummy bytes are optional for some SPI flash memory operations */
+	if (op->dummy.nbytes)
+		ncycles += ((op->dummy.nbytes * 8) / op->dummy.buswidth) / (op->dummy.dtr ? 2 : 1);
+
+	ncycles += ((op->data.nbytes * 8) / op->data.buswidth) / (op->data.dtr ? 2 : 1);
+
+	return ncycles;
+}
+EXPORT_SYMBOL_GPL(spi_mem_calc_op_duration);
+
 static ssize_t spi_mem_no_dirmap_read(struct spi_mem_dirmap_desc *desc,
 				      u64 offs, size_t len, void *buf)
 {
diff --git a/include/spi-mem.h b/include/spi-mem.h
index e68e2b50e85..36281a62f77 100644
--- a/include/spi-mem.h
+++ b/include/spi-mem.h
@@ -392,6 +392,7 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
 #endif /* __UBOOT__ */
 
 int spi_mem_adjust_op_size(struct spi_slave *slave, struct spi_mem_op *op);
+u64 spi_mem_calc_op_duration(struct spi_mem_op *op);
 
 bool spi_mem_supports_op(struct spi_slave *slave, const struct spi_mem_op *op);
 bool spi_mem_dtr_supports_op(struct spi_slave *slave,
-- 
2.51.0

