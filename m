Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C13CCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 12:02:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62B7684324;
	Fri, 10 Oct 2025 13:59:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="zDoGkBKt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23A1F842D7; Fri, 10 Oct 2025 13:59:10 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B417842BC
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 13:59:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TyB2Ki6FTInQM34txDQJ+3XogleuOmRqMH7ZflbJ3/jn6FE2qOvNiNzEqm0D+ifoRfnVrKVu883MoAm2XvMpexHDC6d2DaEQ1XbAtD/LIXn89UPZ30S16Sl2XuSLqbunhibaYo7sPmhoGkTm3Zw37oMMbla7pwbIt3Hw39lT3BFj02/fKiddFiR6B+P16mzLMLlwTDTf/AToZO/TVs41uZySr4Fuv/qbPOOYABx0EspMHmcWqxzqLnbW8vDdEz1rlUBtcMArBVcR6UlPUJwcqjLc7ORZYxVQzDkWyHIHSiFJ89wpmtXyAs6Mc8eW5VJasl51UnEQdi9KMozLlbkr2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GRaPgYgLw311/8D7jSI2lBsqvl6XU06Saq7ZvX1ouE=;
 b=VLe3ZbiWANCBg6OYozxFBHFnBr/pSJxPKofDoX+PTxnYZZX9T6hKRHBJiPiknVfy431TtOFv5xmVsn91tcwE+l6yCCeVKbjMxBxQRW8NtTucW0ODqJEIPu7v/9ar5LZkPZYu+8bRUom4WjDo61FesumnqaTxGaYqNvQoaO2RvlITtzNVNaHufxTT25PX1sCdiwKsy3tNMi3KQUIdv5FuUw6EPCSb7seRmz6MfkPPq3kYP491AgdsRD0q+fD3qp9rDT0X7kRUb2lavnqxiZnSuxro5e/VpclbRkOYoS23Dwl9q4jCBN8bdiLmxd9fS3fTMhKoMFPzu9TD4C3Uii5AOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GRaPgYgLw311/8D7jSI2lBsqvl6XU06Saq7ZvX1ouE=;
 b=zDoGkBKtIVULImwMAY/13GdCN9PM12tREPFG4GjWTuF3C0gP4Crfdx4y97ln8gZJiGiGq45PM3S59U0JIEIlQiFkHpR5W1QYkJWimOQjo0kcMFAL8DO4CBsKJiBZt29skm+QmCneowyP6+OZIwfj6ACg/SYnWQgPlCQKIWWcLhBxQ4tjfFxdmNSp3I/igXDVph1vOjECn+b5ir7WL/9fHItROdSa/KKetMALHC0iOeU4jqACJQ1ejOa8bDlay+Bs8HOjSU/dT1mj/LqMQib+tgn3iFmVUaYMoUv6wHn0PZ7G7ZCnTGA8FcfWABzroev7v4wdttl+VYtA0i7pivaj8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB5586.eurprd08.prod.outlook.com (2603:10a6:20b:1d6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 11:59:06 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 11:59:06 +0000
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
Subject: [PATCH RESEND v7 24/24] mtd: spinand: repeat reading in regular mode
 if continuous reading fails
Date: Fri, 10 Oct 2025 14:58:25 +0300
Message-ID: <20251010115825.1531775-25-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB5586:EE_
X-MS-Office365-Filtering-Correlation-Id: 68ec3303-9e76-438f-c132-08de07f469eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|1800799024|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0I07EJ3V3uQ8FezgTy7LjZj5HZuYxlOZdqOyWzWRb+eLy1eneLPbu0VGpg5A?=
 =?us-ascii?Q?ZYebisXaYHJVvFzcZM0q/wH1JS7ZOX5WKXY8fA7Org3/LMHS9EwxE0YApQ3u?=
 =?us-ascii?Q?XBVGB8rv5/DJ0tERkkGyhy55JttUvoo6smI4NozA2MPzERsZKPd5fV09KiJC?=
 =?us-ascii?Q?GCOqUxc8XjrKLGwfasjGZHB6r0p06xYtnwz6WXRCJ7NIx7CIt5P8b+KaZSVY?=
 =?us-ascii?Q?ap3oWn+pT+14BqUV1xjH2W2xccbSF+YZa4fyxUcIIki43au8gTGDcNu1wavq?=
 =?us-ascii?Q?Euq7RdjXO+zw6Q7ZtIWom9eoxeT0h/QcAje7DT3XL6YdvoIQwtqAuOktfsjP?=
 =?us-ascii?Q?1w+xg8kTip2GcDDcuDxxWhsB3opaJOkevwiuf+nrjnuxquYT1XgJNvmjaF7e?=
 =?us-ascii?Q?QPqM1+IjVwqnlWKQ2TeBtfgge/8HYfW8lYY31DhLY/58VLP9St2P6OJHUsrh?=
 =?us-ascii?Q?bzccXPIuyk6Umd3CskfIK0rUhpIkyte+qLeuyD+2Wn3rOMEVlNpc+pgAPKqF?=
 =?us-ascii?Q?scKwm4tDiKqSmD7QDQa50NmIXiJEj7hNeZSB0q+bkcFmGX1OdQe6pJ4im/sA?=
 =?us-ascii?Q?xVvRihR75NVZrnFws1VZWSfhsa6PI9VIPHK+AgUY3cQLv1dyAY9kWHDf21So?=
 =?us-ascii?Q?RqOfGzR7irybJfHqlfLUqpUfpBPT91V1x76rROtBzuFAYvv1LsbqNPgEOMm7?=
 =?us-ascii?Q?wNeskU3ZtYVoy9fyft+Kn+v1yA0OZNm3InE81tXgwpjhYOh5PYhTDPOF7ms2?=
 =?us-ascii?Q?H1wBsjm71Tn8DlawZkElzJT2CIIZAeXZhXz4AMHjOi67PRW7ZvSX8xw2HmKx?=
 =?us-ascii?Q?n8nxtcRmrOveSpCxvwzIRrxBbxuCuAXBc7lcKVnp/gLJayYdV0XszC9+EdF1?=
 =?us-ascii?Q?RNgHqh1cP9E/8AP64ShakgbISpiwvh3oz7fvAV4DdVHC1eENKsY7fB0M232M?=
 =?us-ascii?Q?uu+Ka6faOBsz4x4ddgW2tXMd174yexaoN2F7VdSuIOBA00B9siDJHqNX+yQQ?=
 =?us-ascii?Q?h4ZS1uD9gbNOQq2iskbIzKx+zkucvKlN0gimh63JKZGpb94FBm4AMviGKE0v?=
 =?us-ascii?Q?XkE1yDnZsU2wH4TOe4k+tYM2/wi9fO64b6Xo7rcexGAP8Dz7EHUaScRxpe4E?=
 =?us-ascii?Q?N81utXxUi/Z2opdbalLFpUXaWLMTAxpPAVzw+cZRjJYvGia7IGjexMo5kmyv?=
 =?us-ascii?Q?CY91CLrL0FP1YldkkxmR6kepNbI8YxC3HlN0lrQaJIe3sr+BQmTsxdONOx2o?=
 =?us-ascii?Q?TVEivLmVoiJdnY6l3/OdKYdJyqDJQ7ZQv4JIiIvT6B8MHlJDj31lsbWVZ83i?=
 =?us-ascii?Q?WPhAe7T3hrtK41P51qjdnVsKNodFWScwl1LfbY3S0HKBxmiaT2iVpH+TV92M?=
 =?us-ascii?Q?HtYAiZ5RMf+mTpa1T2TLeu95tS+kJQE1ZXIkZlRq456cQydcs3WVexc2AwAr?=
 =?us-ascii?Q?JQzKhLdOMndseNBQ6/Bh244yFDb5oR4QFK01jHBBVL8WcUgjzWjL80cJ7TDR?=
 =?us-ascii?Q?sGAIPL5jFQwdSl542TCVpWeCQme4HtqT0mWfh2Gjms+O4WP+RrwheNQ4zA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(1800799024)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CDJVvhl47KeThT3dMX+roPlxNY30zs4o6YPa0RfbVsJzwHs0stPpxY5MNSqT?=
 =?us-ascii?Q?ZN2Hl4tOFZaqq9LlJuFgCHUFiv4EF6pyYF+cpTC9ZVYOAAxYl84aNN4AyZL0?=
 =?us-ascii?Q?EhmwnmhKQ2z2h1qOf4ZF3uO1htcd/MqYTaQcW2Ag4l1rjntNUxknGQgFtnNx?=
 =?us-ascii?Q?b6fwd3otoll0fxldGdGPz/yX9SsP6/TX7DeGqOJwNPIImDIsfQW5xnMMyKFj?=
 =?us-ascii?Q?K1pJAc32k2NhUVIcimfH2Lre0A79bQ3Udft+9wHWQML62jF84IiB2CqZlZXa?=
 =?us-ascii?Q?wI8mbSgCN+KetncFgL1hCD8dVmU6Fb+T5j5DmzKtZ0GeAHG4T22p2oLhetQN?=
 =?us-ascii?Q?VmoC2LFOkcmqHZNm+tMre0Y34CldjXCC2VdfvDY+W0SOo4R+T7lRavbLGpi3?=
 =?us-ascii?Q?zeUpneXEfa2NkpKsX0FMw0gppB8GBvcHyu28tsLmRc3trHN5zU94ryZ96DCG?=
 =?us-ascii?Q?amPe/A8dhi5aHrEcUIOkmDy8NZ4X0N3F8XM19jDycRylIoY+p7h3eCFj7Jo5?=
 =?us-ascii?Q?AfJElziTJqBehjbMZa+11M3wcEDXKmYcky8QDuvHundoKzHmdwxEim0CU8DU?=
 =?us-ascii?Q?IAU4ca4zG/xA+iXpKZlPSUfz2solXUkc7AxhmEIWonLB/OghocJ9QeIvveBf?=
 =?us-ascii?Q?NQscD7UJFgnj9L5LjKP+/Urr+2o9K9qFp1IC8PJ9EFWbn5MhqkDVFsI9VKav?=
 =?us-ascii?Q?rGCqcNkXQjgAhF45lXepz55nuG5FeePoEJ82iANxatOoGviHHN3Axql8F6i7?=
 =?us-ascii?Q?wAYU77PBAgF4+kFlXZMuC3gJlfZVfuD81N3iATUdi5goKuiawXsJRJ/K+rKx?=
 =?us-ascii?Q?tkvgLRh6+KNi2zOEz1sUz9rMSvO+5SiziYQM7zG24+FmbT2AukpDxLxf/ydt?=
 =?us-ascii?Q?pzRDoMim2kInNLk9CPInJgKJc/EuLNzItMb+2nQMKsCVL0BrEy8ptcr2+xVL?=
 =?us-ascii?Q?lGjGYaSO+CNKBR+yCbsoLWeo7LiIcfxkpgfXW8c2fxxtByWTFMUXPcy8WbiS?=
 =?us-ascii?Q?F+qhs1m5ZNoEq+bGF4yrc+Fq9bNs69ZrO9jc9NWikpGUYF4y1XbemRNQEXzY?=
 =?us-ascii?Q?/JcId/GlFJr11c+tRTH1/8t0mqrde/JK2pDbJDGHBA4rbBbqAUTEuQQm5Kv9?=
 =?us-ascii?Q?vdUWUUMNBxuxrS5DXNdJyitFMvqfmRecJEmUeLra15U+t/6/CpGAOG94rbm9?=
 =?us-ascii?Q?bLaqWf5mvwmA8t/E5RssX2eLFbXrSzkVAtHYJpPeieJ5tBvm6F9S38iirNII?=
 =?us-ascii?Q?DW0Gi3atSADkRM+jjr6mDl0y5VSA/PbGUnw0dgaGojnUK5x1BnyL4B/8qzoI?=
 =?us-ascii?Q?QcBt7GOglPBIZOcnUxy4MP6e4+/y3zSEsNqLnlxC9y9DDqgmvtCtbzBkZAe1?=
 =?us-ascii?Q?IuXiYf/Uq7QUZj/3SJ3NkjV+me5PLCPV6nOyBr/NK73UiCdePSE2a5S4sDSc?=
 =?us-ascii?Q?F0iFSg54IKT4gIbOpapVCdYiwAdUKKh7r/2euWLxpmd3XerwYLme2pcEfpKt?=
 =?us-ascii?Q?Nc4Nlxxd4UWqm8LidiUBT1NmdWiHHmveEww34S3hPOJWAffuprQIdqn5AOA+?=
 =?us-ascii?Q?QKbg5icNSyS0dLUNHDQ0klnpVczKXPFjRFwSk2tKEvQPRivUJPutAbO1mRra?=
 =?us-ascii?Q?QIOrQxfqiP50WTEqQKKIuPI=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ec3303-9e76-438f-c132-08de07f469eb
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 11:59:06.5309 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uGmucI4RWPB4RAcqRfCM3RrVsbz8kNGDkJ0jL2XdSGi3F41YTujr7zH716DB5Lkeb0xIMEfR4YGFVI/6uLt0RpuLOhyhEImhkKnKlHvlUls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5586
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

Continuous reading may result in multiple flash pages reading in one
operation. Unfortunately, not all spinand controllers support such
large reading. They will read less data. Unfortunately, the operation
can't be continued.

In this case:
 * disable continuous reading on this (not good enough) spi controller
 * repeat reading in regular mode.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 68a03ddee8b..0c435059546 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -427,8 +427,16 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 		 * Dirmap accesses are allowed to toggle the CS.
 		 * Toggling the CS during a continuous read is forbidden.
 		 */
-		if (nbytes && req->continuous)
-			return -EIO;
+		if (nbytes && req->continuous) {
+			/*
+			 * Spi controller with broken support of continuous
+			 * reading was detected. Disable future use of
+			 * continuous reading and return -EAGAIN to retry
+			 * reading within regular mode.
+			 */
+			spinand->cont_read_possible = false;
+			return -EAGAIN;
+		}
 	}
 
 	if (req->datalen)
@@ -890,6 +898,7 @@ static bool spinand_use_cont_read(struct mtd_info *mtd, loff_t from,
 static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 			    struct mtd_oob_ops *ops)
 {
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
 	unsigned int max_bitflips = 0;
 	int ret;
 
@@ -897,10 +906,19 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 	mutex_lock(&spinand->lock);
 #endif
 
-	if (spinand_use_cont_read(mtd, from, ops))
+	if (spinand_use_cont_read(mtd, from, ops)) {
 		ret = spinand_mtd_continuous_page_read(mtd, from, ops, &max_bitflips);
-	else
+		if (ret == -EAGAIN && !spinand->cont_read_possible) {
+			/*
+			 * Spi controller with broken support of continuous
+			 * reading was detected (see spinand_read_from_cache_op()),
+			 * repeat reading in regular mode.
+			 */
+			ret = spinand_mtd_regular_page_read(mtd, from, ops, &max_bitflips);
+		}
+	} else {
 		ret = spinand_mtd_regular_page_read(mtd, from, ops, &max_bitflips);
+	}
 
 #ifndef __UBOOT__
 	mutex_unlock(&spinand->lock);
-- 
2.51.0

