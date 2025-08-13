Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11F5CA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 23:46:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C04068391C;
	Thu, 14 Aug 2025 01:43:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="ggNx9PAl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E7418383F; Thu, 14 Aug 2025 01:43:50 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D568837E2
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 01:43:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rwc/BWqrJDAl53Ri78brrTFMJwuiJUocecGxot3V/3DWHaK7Qk0fAEx74sqBg3syQi7qQO+aF3vzDlPxiea/le8f0q46nQSNghF3VI9X6GNQpCcfNcU7tokVuUqStHhHbwLcRMc2nTrDFNinfMxF7HiiXwWLJFQNBhl9Krr2wC1/m1THXEzwWWblzZ7OIBngxJzvf95POw0jlzsfRuusGc9w7AOXpdUuAKB6YzpC8Dp73Tk6/dete9g6ieMEOKeWKudQ909k8Z8UIDgIGymEIWVjUt8Ejqgw4KyPQ1yGGl+DsTCTDiNsaz5kEV4fJkwYZ35+63M7GgDuf0AJ7M2twA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTjKtN7qWl2YIK5Yo1rb7tlMIZB0dQ4sHBifEZpQqQM=;
 b=MYWMh+k5cbUELCUYpbEunvQ1wZUu8M4zsUt07Q6bKoP+sdElKtXshCRbMqXs8E/9sRMlHVQTaLfKDa7/NgaJwGNNlPq8XuedgacRf+hWZmhFaYuTUxb+PIdfSahPliDmayWPKE8YFXBdMZ3c46rwBaqLQ7NoW9bnz/AKQvzDPZogco0mBDaaI4RLpisrnZRGeXlWsjk0Z9f92TsanrRGPDxp04R73HEjkXNPM1+5ICygO2MwfThm5KHnDIB9OgAwbFdw9/zDjvl+6+0ZhucGfA6CPUJjpZ5aZgRBuMGG6WI3uW2Te8kRvBLrSFjkTgqXq2pB83/g6Q31Hy+s2nrsLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTjKtN7qWl2YIK5Yo1rb7tlMIZB0dQ4sHBifEZpQqQM=;
 b=ggNx9PAljVybGa9H1OA0h+bIn4TsXg+vXClC3fEK14GFbBPnyl3MurDbdju+9H/IJLjxLMtr7ga1gaLwbaIF8j0JkHJQssfITzoMna2WQnMTGJ5I/ILOrYnIuyytjjCkME92tht6vvJF1dehaiQ+WhhSSZvPJZFmjC+XVRcIBt7NUVkTwlNpcc0ewcxeMUymkRHrNr3/W+Ow3rxvlKAXViadNqY5fxjie/doo4VR907KYELnL6xf7kwGdirhJ/PjWWlolr5fSDzS3FFAddRK1yRSJddYs8ulRIcEeHElNJVp7rw2P8Qz7qZhhgDff1bwKUjaav5W597AF1hWfEvBew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by FRZPR08MB11021.eurprd08.prod.outlook.com (2603:10a6:d10:13e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 23:43:47 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Wed, 13 Aug 2025
 23:43:47 +0000
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
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v5 18/21] mtd: spinand: Enhance the logic when picking a
 variant
Date: Thu, 14 Aug 2025 02:43:11 +0300
Message-ID: <20250813234314.3945708-19-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
 <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::7) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|FRZPR08MB11021:EE_
X-MS-Office365-Filtering-Correlation-Id: 57e55af1-fafb-40ac-dc43-08dddac33f4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xiogVH/3E5uTdC5uPq6mN2Yy0CBXrR4ksxVAt+ywJ+LJqa264xrWhhLJAKnI?=
 =?us-ascii?Q?QxGl8H/GvRHqdLt/dK9qy9cg3Di4ismaxSRaPlLI9TGPJdihapIbnzkmaY4p?=
 =?us-ascii?Q?QNS/OE4KiwXCSoRi27Nmp+wXR8KbUDy18pbEaPP1wZ7264eVjg97Rz73z2o6?=
 =?us-ascii?Q?5TQHJYBjCt4dRTqU+agF1hW55xZzfuYSQ0KD8VVt5AptCzxz9qH2F4C1uwSw?=
 =?us-ascii?Q?sWCj9vjHWrOKS/ugk+8nErIE54sopmmngsrkHr/cgXuYmXRA2wSoNyGKtsNy?=
 =?us-ascii?Q?0l4pkbrH6uzHmCVT9ZRTnI20GygOg3rabqZhYBKWRTmXpMy7umRlTiU8PZv7?=
 =?us-ascii?Q?kVnn6oAZ3Iowsg1uM1RMK4Uo8MwTEfkIQMcFlRqWIhWkrZOoRri8alDEoDDz?=
 =?us-ascii?Q?V7mvJqT1QzDFna+diUFr4e6IZqhbluqvn1NLuUtop3g1iZzn9icviyElDZLS?=
 =?us-ascii?Q?T7CMpU2Ue9mYJV5kgUhMLPlBnJoQDlyPZy1VY2C+Y68U6aAIJHQVZL37WxUq?=
 =?us-ascii?Q?YL22v2zKXHXev0VLPIOBt1tp4T6quG7cCQMhe+EYd4z6kYbcuqA/hgWpIaW9?=
 =?us-ascii?Q?1K4505l3N8pKcLsGOnEC+tAbbJH3TNGaEILY7JsjA8ziJYYivfhibN19cRJu?=
 =?us-ascii?Q?y/gz9M92TrmORSgBFkTmGaPI/luc3mQ9b0S8Hmw7+6D5IqrYxcGix9PQ531M?=
 =?us-ascii?Q?P27KzKDs9B4BksV3542Q/x1iPyyj7+nFEfBBmwoastmqaD35hmNP88pd+tTG?=
 =?us-ascii?Q?vpApNNEaqkH1D6JhY4shITI7mkZji35hLfe0s7t72y6q5SxFhUoooLXUXriP?=
 =?us-ascii?Q?Qjsrla9s4epuJuDRzrooWb12l5jBZ5pPZCFVK5GH2K2XnyyUNk43XUVYd2LG?=
 =?us-ascii?Q?VTPcL25Nku2UjhOtqJOem0FWk5kg7gLM/UPXQ1qVPVLm51QpsE/QvooA27XK?=
 =?us-ascii?Q?QT3Y2g/RWW68PlVBc5Hh6A4GM7eHEOlwzSBLC44J/CO11p7INAnFw0IWutic?=
 =?us-ascii?Q?SEXG7p3fZ9w+0Pm8puJQTPbT4sDIVh0rTIfFNyKYqxepe8cYaTjXY7EmHBuw?=
 =?us-ascii?Q?6Tv6rzEuZ/e6upTkajjKRw40WMP08J3bq0aQl17lQ2hBdvBLUH19wu6WHl3/?=
 =?us-ascii?Q?HOtH3HU+QPeTgeN/wp+uxxWf/TaDyoLj7sJWpavO2rVtiBKQuV/uKaixw+SH?=
 =?us-ascii?Q?hMc8sFzhlDsRuv1jcHtEhj45D9uSouNVH6qRGFwxGKvjursqO4uinOFgBK8O?=
 =?us-ascii?Q?e7sIyJS1IzfbN7wZ20V5LEBzZ2eA9swrRgnOhh63g66177J/tOLWYPatfZEm?=
 =?us-ascii?Q?BypxYVlB6rEw457NICKmJN3NgGt9zqFppK3Hjxj+JcrR8rqsBrHuTEmd3l/t?=
 =?us-ascii?Q?NGr4Gu/9FZRlw+NkdmnJvalf7VeEz0lvkxLkb/BxErwNKlXqsXT2FlV0Je1N?=
 =?us-ascii?Q?IS9wTcsJkRNde/VhnRdy1bgH9kMeb1fUGlG8/2WN4eXXjVzpe/01GNB+IvTu?=
 =?us-ascii?Q?Vj1hKImm0va8YU0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ce6bXRKfItXkhA/wR0vpJJC0wY+stmtGEGeU4eC28gjk/vqjM1dPc5V/98ti?=
 =?us-ascii?Q?QRCsFzfxqmg+F8vDsBDWLQ8YSQ0FNf7nkh8OWykGG3cwrhuoVcKTvj+u9vjw?=
 =?us-ascii?Q?QmFv/ypxeWQo99XT+A1TwgWW23t00M4WfJi1h1+dC+NxNofBjsamYiOHEVbW?=
 =?us-ascii?Q?l+Hq+izncIiDr6f1vG2ylTs4ehXRwY9eomauRlFgr9Loz0kmEJ4gi8Zu3dUj?=
 =?us-ascii?Q?RSdaUsn+NsBHOckiuu854s+02fBUzY5wH0lLqWEMjhSuez4N9JDbNlhghjzL?=
 =?us-ascii?Q?FL5X1nz0jDBI7+tx5WdlSLxfE35O30kN324lgCP8CdKzQfwrSUP9Uhp0GZ7b?=
 =?us-ascii?Q?GyRkAXA1Z2jjneFXfY3ifilYfBPAcsbluDPiqpnonuFGGgR7azVgKtVVxEG2?=
 =?us-ascii?Q?ZlwcRHmzUp6NSliJSIZErbwdQI3L22kmfnJHCvCfGsEakrUFF87cVACDKn6r?=
 =?us-ascii?Q?XWkCjZIPMl7Ck2z1QZ7K0VQxEzm5xYHl7MnONVUupIefOpnwhjb4uL91jtkr?=
 =?us-ascii?Q?s+KtN7W6W3rE89kraZ3hE9sbewDbPo4X3e+mi454Dk+HVoc8UYFMUQ3WmLSD?=
 =?us-ascii?Q?VGggUw1zcVc1lCtdIv0hLf4LIGukUWtC2ztcGsBgA59SKzx+CdvcBsesN3Z4?=
 =?us-ascii?Q?IbY9F7zMl46tnodbhUiF0s0b7EedtVzFmFmNMIql1BeM/p3s40RiNj9c4OMD?=
 =?us-ascii?Q?jJZGDMhBTevJo5nDD9jexcqeKJIcWc38GaAB9HqecycY/LLWOA4JDAxDuZ9v?=
 =?us-ascii?Q?2D91iMmrgjqKdd7LpXJNJBc+isBUDU0QgYC2i3HzeBR13ig9kBwFsskEIuew?=
 =?us-ascii?Q?v98l1wNiLyWf7VX5yk3XoI82wmQ4QxQ5WJ6ZM+RlZR5A943Eor4lS43AbozT?=
 =?us-ascii?Q?1eWNJyKRqS39mwnM065Po3kHwkhmk5bpQBlmQZUCF2+IlCfLnPaDiYFJsyl9?=
 =?us-ascii?Q?qb1Qbelasc0Xs1iumQlxsvLihe44u/LochcEJAUms2VJVaiuBJu0NApbbNAu?=
 =?us-ascii?Q?SABxJCrdBhSEurhFtRH2xUvgxK2wj6KJ0TBwkr3VzUzhB1A6DfiN84eWRVb0?=
 =?us-ascii?Q?X9lqBIV/JnCs00Vl3hKHrvtJa7MtfrCqatxJCrxSr3CUxV2nADnlUMyUgr+s?=
 =?us-ascii?Q?yFghiP1u5bDqdpXO5KyGWtHXXLPBAJALvUMLA5cT6aqaEzRb4gxvozyBJ3S1?=
 =?us-ascii?Q?u9LWjDmJ0Y5u8k72QCeLEBImHSPmERXaBETBL25R49q8h5ExqA8aL6rT5OaA?=
 =?us-ascii?Q?24HM3MWvFdMAPDBo4FAUWCFG2uDrpIqsyhakZlHT9b6V3yPRw4XMxi4CqXb+?=
 =?us-ascii?Q?s6ssnY5+NaAG0Fr/Xfhn6v8c5wtf8GkInPWxpiq3AKEthHU+MtfhuYxd3wsI?=
 =?us-ascii?Q?HgxzDqOvyiw8cDEaYAAH5yOnEdsdWkbaTb8xls2e8jMaocLaSrZzD639WawX?=
 =?us-ascii?Q?QZpgzkke/R2ElKn/l1YXt77aTnV2n+ILIf1mXGNV2IO+uqkfDFyWkaht1HBN?=
 =?us-ascii?Q?jliBETzUeu7PeB+S/5nio6K4hcVFh0PRG4pVCcJK2F5GU2oqrpCVXE+afdYc?=
 =?us-ascii?Q?m1PAnw5OpMZyNp6XWAiefNW9gisMq0GdtqMoZEmITsJ1v1POFnSZ9NnG9NjL?=
 =?us-ascii?Q?oQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e55af1-fafb-40ac-dc43-08dddac33f4a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 23:43:47.3622 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9h4FXt1ULQ6aQX0otzLKSGGGQ/QN5EkOseZfuAplwwK2g1eKRzWgYkprtSjOgjhy3flhL/aGkxtnNqCEEHaskAkecYYCtMASmVryUtLAWEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB11021
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
2.50.1

