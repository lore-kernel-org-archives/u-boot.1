Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D45C87FCF
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 22:14:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5DC2840ED;
	Tue,  5 Aug 2025 00:12:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="biiyl4eX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E75E4840B8; Tue,  5 Aug 2025 00:12:05 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E737A840E6
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 00:12:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cRQpg4OWheT9CkoLBgk2AVjEDfFeIMIoP8RJWvtA8EBmSabcoZ20AbtEODR+TpXzhMgAGdiJ74dWFRGWQZQtMFwkZcX8Fff+9RLeI6HuKdN7oB4ctU3dglKS/Mk3V80PJXeLJri8PGqOzYUd1YF3DztfplEWevvE/gWrkER92aXgyj75TIckjSLiuP422FGLaPEMfRht64QFPXtRbL9DlauMPOf+rUM/GdRFb4fC70a9+D7uD+HsEdYnu81jgmJUiP0tdmCHBGw8i/34mo4IBtKxeWWw7kfrTPx/Is+lYWMfFv7st6hBtNEDhqzXLkJs4AswVrJUMgq90N9Wzlkd6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIkt1B130WKGz5u3AEjJ6vs9uB4B2KpF0QoyhiQvK3c=;
 b=Gi8lAUZRdhBU547nDEkwHjJrW4F6R0I0tuT8hTMeL57CgECmp3PdrN7MsbjKmGgJSO6Do9W+p9b1nAsMGMfqlMf2D3AcIQW9ObMTOVsb4ZPV1yc87lwbjEdQy7FTw7+0cc9Ajzi4Kt8YKLfxYOEzQplSWLztbDKh27IEJQpK43ccFWVwTxneZnwBt8TjLScYr9d4U557Ofydow+xQ8N/agSNGyy6Pv82a0J8LvjeukXMt9Zmm5oLN7Lpq0TMpKcgAT2bdSocIsvDBtxI4KCe/QNoPp0LCJriZoCRjka7FXGfnd7Eb2kIKUtqovSp2s9T+w9ouzddN8gwxZOESnO8dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIkt1B130WKGz5u3AEjJ6vs9uB4B2KpF0QoyhiQvK3c=;
 b=biiyl4eXKqs6yZENCbSK3MC2nsbRDSFP5m076rwie18uN9MykIeumPyi8kzfk307D8l5LLbFSuxpf9v8VCJIEATdl4QSTcxd82+f6qB+SXO+0iuDdDB1N2SVGctxSaqZ8muY9xvPagVhji2H/SK+SaekaRnM71ini4/XUY6jGdzaRnc7t1pSXy39qaSPyeZL0Hmlmt0Hr3e1nzOMTVugkIR+FtNeLAUK5KWXTcyrjdhyQysiG8OFj05wVVzMxQTIoQ1OiymRr6QLq44StSdqHGhJOVZ3sv9Iu4H/XUG94ZmX5Qh8s78Kj+60OuA/nhJm/e3XVST61MHDPygN1WT3bA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB10194.eurprd08.prod.outlook.com (2603:10a6:20b:63c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Mon, 4 Aug
 2025 22:11:58 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 22:11:58 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 22/22] drivers: mtd: spi-nand: repeat reading in regular
 mode if continuous reading fails
Date: Tue,  5 Aug 2025 01:11:22 +0300
Message-ID: <20250804221122.1420516-23-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250804221122.1420516-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250804221122.1420516-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR05CA0144.eurprd05.prod.outlook.com
 (2603:10a6:7:28::31) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB10194:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fda64de-fd40-4dab-7616-08ddd3a3edf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+AlJ4rmP0mbe4Qs4lS128nmqWTYIgoDMV1Cv9Zkixv3C5vyB/ZT0xYki89q4?=
 =?us-ascii?Q?kX1Y+8f1DBzv8nJNjT1KrufbMzM8jqMaR4Z7o1PazzJRrCRmBeUMS55HGMYA?=
 =?us-ascii?Q?HZp+KUnwGbHefN1Q5AfPCKuMgDdVnb925/HRbxQEb7IB8/9DBR8TEFz9YaLj?=
 =?us-ascii?Q?bb+z6baiFIKlNxYY8/dfJU4OKMMMuuJxP4jinSTTbSWjZmUb/79UYjSkvT4d?=
 =?us-ascii?Q?iiOalTst1LyQ9F5vrjNslpAD2lE/c8BQuZDYQ3cFall4TU2DBsiVKKcyEeAJ?=
 =?us-ascii?Q?0kB7n8G56e25c4cSNzkh/ZCSZsw21KPnMeFP2r3c+1Hp8uY2GHX7hBMt1GFV?=
 =?us-ascii?Q?qQApulWZZfHwcmqYxamY0LCmMt4zFUkIFSkInr14HfbN75l9XNALHGMkgsF2?=
 =?us-ascii?Q?wWK8j763SymlRiR1T0DbmV7QSbFEAq40ycBL5Mmveg9ryKM+Mp+nzyBR1Ucl?=
 =?us-ascii?Q?xdD7KKmEMpSVIbGw4iaar1M19tHE3MKsSDbAw7OJCYQvmRR+9IGFe8V1jnao?=
 =?us-ascii?Q?PTNPLV9cMc1pYoFPlsNpV25qG/NKED+lpbLgGbP6QVYlPEbU59T145UobSzA?=
 =?us-ascii?Q?plA+Mp5mngEYIBXHumK+xifacZ/N7HFWm+UbvSvRlm9wk8ga1jAocWRlHzIx?=
 =?us-ascii?Q?O5FUmXQN+Z01+RZ36uq+k1/oqhMzeylvqcbwCQiHYNfIN+Lh0nYcG2lN3vjt?=
 =?us-ascii?Q?UljzmmJ29CH9TM9phBr3Zcmq85YJM5sNxkLrZauIl2w0k9R3NF7+ePahHPWX?=
 =?us-ascii?Q?DE709g12XktoayvlTfRjrTF4MUcbz+FByTM/eYK6UBNmeTUS2mrstsQNNwch?=
 =?us-ascii?Q?J1fYvv6dYwZ02WOeTwiIzxsqzG3/LIFWFMbPbIWbgPK8Aa6gX7yfGd+Tmp1h?=
 =?us-ascii?Q?WCjnsKHrU6W5nXDB7fDEoCXzxsIm07/TbDbh+ygB1K8f37wxMYtfBV8FrCkV?=
 =?us-ascii?Q?8hUewvVsIyQAp7lAJssyMHi9dtHfE+61yc3sOdBISgjBxyE6QOypDutSbgPc?=
 =?us-ascii?Q?iAM3z5dninODvDQHA2xq1sgeif6/xTvXfR8DA+6I9epcaBaiwFDWHbVVfk1i?=
 =?us-ascii?Q?E5f6z2TgQ0Tblzkz80uccDi74kacJxiyO6sc5S0iUGYl2Yyjt170pHmv44/z?=
 =?us-ascii?Q?87WjVFGG0OqUqcf54hUr5o41KbwutIxJUgXeGzMhZPMQKoZSnSpLu7Imi80Z?=
 =?us-ascii?Q?99wUdu6eB7YBbNm/IptYe3RZIRWeLdwRESkvQDeQBREI60JJwmFAmKtMJsqe?=
 =?us-ascii?Q?szJ6ZQBebXylPMZHIHaWxnbB/BePfe9bejLdvkruayje+M+kwtNuRy3DR3An?=
 =?us-ascii?Q?56BGYyD4OI0EhovdlOSc2TZg/SqLmqXktsz94h8BmVxz7OSXeuH2/qIlftU9?=
 =?us-ascii?Q?m/rTnEDdxiAz1oA2n7C+JAzA7HWtMwitndjRludEAA5VY4l1N+5m3hhU4DLj?=
 =?us-ascii?Q?7wT+IZlsC/o/dsxIBIWV/tzebHY2c/D3OdZQM0z6BCRg8QXJgSzllmy6tXKn?=
 =?us-ascii?Q?bKlqgzbFik6MsT0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AMpoosgdaKvP2G//iFRxXQMJ71RjLuiSe5d2kbD8zyHF6bLC4UQ7Fei2byQD?=
 =?us-ascii?Q?+3fcYYlB11ost3iVMYp76K3orbjr/Uko1waOGxUxAa3RDxFtmy29+cZqGD76?=
 =?us-ascii?Q?KlmNNMedLEBeXaH7rEkBJaLN5eIpdV0KdGhxPNZoJeSvh8QOy6X1hjExVOrv?=
 =?us-ascii?Q?03SPmLUrjhXKg13Odz/AF+bJspHpBBo1GRKc8HeGyCmZIciUMXfd/D3j3/fq?=
 =?us-ascii?Q?4VpCNVpb9URB8W2cesnpH6IBGmmGdG93TbkSaPr7AREdOUTkzZmQBai4x/Hm?=
 =?us-ascii?Q?RSv3qCU8hESkzOT+2pnCc0yJnJjtz7PcGYZioSlgLkvOM7tyUKqpY4Yd9V+t?=
 =?us-ascii?Q?/PNc2ZYgt1q1a8feq6FLbcXk1SmHp9k9fDnBGfPvryxCqOksg3v0dUrQUO8o?=
 =?us-ascii?Q?VOn6VG0KeLHAbpMDmjFV5s3cf11QIeu+SYn+x3I1bhMgMr2ZaeOlfOHa5dW6?=
 =?us-ascii?Q?eL9iEYoShCsvEVZpNjHHP0VZihVDVUY04mkkbmooWTzrw5U32p5ncWVXY9n4?=
 =?us-ascii?Q?07pEvgV1rclo4W1wNXVrdnXqvRuFuh1uBwaJrA4C7cYW29L2fF6grSk3F+8t?=
 =?us-ascii?Q?Ak7pT5JHmTHhll9RroYIDx1H9TJhrb5AuISnM5MCOBADZBSG+P5yqYU3CXMJ?=
 =?us-ascii?Q?+Is40DDwRXSpn6kOau28YJvoywtB6xiVa/HZlLZM/DMxUkxjhJKwAEVEN7Fm?=
 =?us-ascii?Q?npfIC6Cnro4qzJ01rJRtDUKvRBgttMKIg6IZXJRnKpuIlMItlZ8QBEQu5YDU?=
 =?us-ascii?Q?dft0Rz8b6wfeVPprE5jB0noKwpfijFHYLpgiDyXLkrZJCv43+AgkwjUpeMUd?=
 =?us-ascii?Q?GuBCmegmqk8Gk+830V2KBpKIfM2/DnGFPtbhfkkFllthz0R1tdTl0ozSSALJ?=
 =?us-ascii?Q?KgPk9wZwFN2wysOeG3eSB4Nrtg7of5y6ME+GHU9SV5jveBSaRK1Iz45mVhb+?=
 =?us-ascii?Q?cc0HmYhp2rTfIRw/rkQ4L7Nap2Tt8USY2aBwm2unV8dg+gufzb3mGyQEGTb4?=
 =?us-ascii?Q?i+Us++upSvW6Fiws4qCYIAkYWKWYIYtpYh23R08hATnQFmsAapX+vD5b87fa?=
 =?us-ascii?Q?M6Nu1yvUWJ6ap1C2hUe7e+oxoFXyyhAGGyFPpm7hpPUVOTxEkKMl/6bk4O15?=
 =?us-ascii?Q?a8/qP2SbD2UlFIVm6oYZHHe35IMguo7n+NVFl9twJpiNY37+pdrrbTLBGBEH?=
 =?us-ascii?Q?Ha88kYOtnQEGz5UGZ0vzoZwhmjrD2D3DbFtJjcM80bjikV311vIzsSj9MRjZ?=
 =?us-ascii?Q?ULziBViUy6B+ldiMDhOCAAJBv7Ml6D8JnuUhAaeGuZJrLWxejY3yi5aMxgDT?=
 =?us-ascii?Q?WvWulDvK2tzhqwMuU2dTSJRMuDYoRFuTon6TCgBgIfOkVYuzHOjUU7bhfx8J?=
 =?us-ascii?Q?C83ujFcnLuhWf+DnFFZh7rCTVb4Rjm4uYI8JS9MxIjhoYqopKdL/awsWSi1X?=
 =?us-ascii?Q?9EXFnjDJZsdEXhQERsNsg8tYhwqNDe27HopSFIR57lgRjd4aDsLZdpKMlf8R?=
 =?us-ascii?Q?1Sw4xubNSm0fPz12+czK4F7jsxxzQSntmAYKrmaeB4NAkYDpMiz9x2sXvGsp?=
 =?us-ascii?Q?1IY0SdTevfcY6xuXoV3O81mCK+n43/RhyYxY4l/L9QFGb0K+ree+cZQ7Y6p4?=
 =?us-ascii?Q?SA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fda64de-fd40-4dab-7616-08ddd3a3edf1
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 22:11:58.3343 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j3dCEKdQ+EwSyD86S6FxhNRpEBYbm3zH6eKkmMAUEy1uWAggOOGEWGlPhzFSe8Ljt0TLVju7Kollnz+vvELLyEpwCFQJltwy/E0H0QNzA0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10194
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
operation. Unfortunately, not all spi-nand controllers support such
large reading. They will read less data. Unfortunately, the operation
can't be continued.

In this case:
 * disable continuous reading on this (not good enough) spi controller
 * repeat reading in regular mode.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index e9ca2b3c391..89c0738905e 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -428,7 +428,7 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 		 * Toggling the CS during a continuous read is forbidden.
 		 */
 		if (nbytes && req->continuous)
-			return -EIO;
+			return -E2BIG;
 	}
 
 	if (req->datalen)
@@ -887,16 +887,28 @@ static bool spinand_use_cont_read(struct mtd_info *mtd, loff_t from,
 static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 			    struct mtd_oob_ops *ops)
 {
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
 	unsigned int max_bitflips = 0;
-	int ret;
+	int ret = -E2BIG;
 
 #ifndef __UBOOT__
 	mutex_lock(&spinand->lock);
 #endif
 
-	if (spinand_use_cont_read(mtd, from, ops))
+	if (spinand_use_cont_read(mtd, from, ops)) {
 		ret = spinand_mtd_continuous_page_read(mtd, from, ops, &max_bitflips);
-	else
+		if (ret == -E2BIG) {
+			/*
+			 * Some spi controllers may not support reading up to
+			 * erase block size. They will read less data than
+			 * expected. If this happen disable continuous mode
+			 * and repeat reading in normal mode.
+			 */
+			spinand->cont_read_possible = false;
+		}
+	}
+
+	if (ret == -E2BIG)
 		ret = spinand_mtd_regular_page_read(mtd, from, ops, &max_bitflips);
 
 #ifndef __UBOOT__
-- 
2.47.2

