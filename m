Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C233C83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 11:44:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AA8E838B7;
	Tue, 22 Jul 2025 13:42:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="kGm2jgkj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8168838DD; Tue, 22 Jul 2025 13:42:16 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC739838B7
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 13:42:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cs8k2FCm8yTX26Y4QF5oDPbtEeIk2GS3X7Mtw9ZcyKODkUJ68Nc/8avihvZHZQxREk1wOGFro5cB3OUl0yuQnhbex4q+KYy3QVMzXnioegGAC3m5x4IUWnPOuQBEGBgH3tiDiUi+oAtxIeibs/xoktBFKDYN3hCOZix0vUMlndwnHlB8Qp2w0Vz0CEGJ+NBcza1BmURhQDnvpkCt4fSa3zH5qU8mAdkFeWVpxA6xuhFLR0Mb75R48pd757zAOk6uG+6QYeaAtTyz041tTR6kmqri72AnQeWUljaVmafXgLzhnrQZjfoQDb2Yx4WZGCQ7YC1zcmH+WacbFQPZQAa4sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlGn8I/v7QpZ9A0R0I4e1Ag1KQ5nvGrzOb+Hxs+M0pg=;
 b=hq2wToLxUvLs/UFuq8FiSaazCyl3TY096zaUnD21bf0Q47SkflWJROCm6PzdUNGqgxUBDOO24zuIoJxf/IueeJ+kaLOAr7zACHN7yZPJTH/kfv5HXH/OcO6YUK1tZxB/7ohEw5NyEptjQKgL5iiEGTxy2axkIzGUliBa0jS+uedYMDN1a+7DZSb1reU88vLSo8qC1Vw06F3adW2HjqF4NiT5nugXYgahwF56u0jYQInvDlWXlMmllHrO7xG9pMQOZYU0CYIc1ZpV9OWVbp/CuVMKtTVoiqEaiYOrD2VqoCWM0HbqscH/d/KXgm+rBB1ZAppTT9hxLABglisC/WN62A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlGn8I/v7QpZ9A0R0I4e1Ag1KQ5nvGrzOb+Hxs+M0pg=;
 b=kGm2jgkj3JxeBwxdOD/V5uzF1QMCFJtKuPGaicIcLIHi0H553RbsmF4G96SN6sj9oCMieam5YJ/fWFS8i47BwNubGiRN/FHLSaFBAQ5ehF86PUAj/xKZmchwB+ND+Z3kvUh5rQvp1sZpf4HgyxNouQlNeLd/qLMvfqO0SZ/NFcHerNSolQWr9qZ9UuW1MHu4Cv7bHw0E73Qk80A3BPJHfMWUF5yA7Aj2ZHGKQP9hUch8FyiZRmkRNQzoLbXeUOsXN7bqZiTZcFWnwYm4++5PPMRNb9Uz4eyoKHVYXdUY/aABoJzQ0U4kRf33bBQqHGCVhG7+Pv18JfPsDbhiNtt/9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB9908.eurprd08.prod.outlook.com (2603:10a6:20b:562::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 11:42:10 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 11:42:10 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 14/19] mtd: spinand: Introduce a way to avoid raw access
Date: Tue, 22 Jul 2025 14:41:30 +0300
Message-ID: <20250722114135.768998-15-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722114135.768998-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250722114135.768998-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB9908:EE_
X-MS-Office365-Filtering-Correlation-Id: ef326107-6894-4574-2e70-08ddc914caf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|7416014|376014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XhZHjraZgPGl9LLk9itIHO9Slb2I8DJOitSL0c0NcOgc5BFuFGRTdC/rAJxh?=
 =?us-ascii?Q?KfsjCd/WjSi2yo7QHrWfauHkgtwK5x5C5aitamuVLSAbwP50yPnU9or+Xrqn?=
 =?us-ascii?Q?671uPwGjqIn3s+a2Q8jfxu91Z44kw/Mysb9w7IB3onjrMR6JZN5MNddEFFTC?=
 =?us-ascii?Q?FFfeIBHg8X0/Bdm/2+bS8DezpWDK464kU8lpG2LMksYkNrzLz+vDX8wl7ULQ?=
 =?us-ascii?Q?5SgoX+QGTMGfQguJ7cXenaHlEqxYK/6L00nJty5NLYSh/T8YDFpm3hOi9IhM?=
 =?us-ascii?Q?cuFovhqv9pc3RHhzNmGyOGW2NxglUz1c+kJxfYIgw6bxciJZopiUwu9ADQ6H?=
 =?us-ascii?Q?U5J7wn7+GvOqDf1RxgEIBmtDPkWhTBBxekUkc2J/O7DbisoG7Ps77qqpbN6Z?=
 =?us-ascii?Q?jsqLEwe/rvVyoVN45C2JBClq+Adk3w7Zd585rZm0vDL4AMK+EVI5cR0Ir3m5?=
 =?us-ascii?Q?l+tuelkrArVINWGmcXVS14h9n16p9vspIDkpXKE0wEzfzVOAI1ojPjB5lTa0?=
 =?us-ascii?Q?6t81gSqdmUxXr+TwkHPteoEww9M8xzzmP2PzOrhJOWUBzfjQhsrEHZhS85Wc?=
 =?us-ascii?Q?m5mQVVUlorwlPeba2IXBGAyN3Up4JD6tMQSQNZmFK0DYY6xOH4eUVyJFehUq?=
 =?us-ascii?Q?VD/Om5PUDhqzRbMcYiJ1OcqFy6jPL2A9kMl+Ir7HuCClMDNoMLJpvfkatoZj?=
 =?us-ascii?Q?ffLohAR9ykWasJAzp9e2Wy4A0zno7rzOpfSLu4HqQyUw+zN2fDcjg4rGTpwl?=
 =?us-ascii?Q?7wLZSBi674RbheY6lxmCV6ztg+/w6I5BV9krxx+F/Bo5tX+X+XC3+6ltxZa5?=
 =?us-ascii?Q?HcujpbK00EFb74bXkgMx+7aph/wN3o5dk89btu/jsbh5UvWEX3h8Zf/koYA2?=
 =?us-ascii?Q?D1Y+funB2T59O4yj+2yfBMdT6B37FsJvtrpqvXaoLbcwJgKfv/bjWEuEprsQ?=
 =?us-ascii?Q?HTpAyaZmydZaxNjHHizS3N+1Y+rBOFwkMzsIuuaZhp2xU41rTqOnHhGE6Uf7?=
 =?us-ascii?Q?NBX0ScRRMSNyP44CVjQ5DBMc8hxjXUbHCl3SO3oNuiDpv3eJ/ggF/ytGBMc4?=
 =?us-ascii?Q?hY5WYzLpmldP3dIsjqf10IJw9l1VTYLpng+UCE4XLkEcy2YuIgB+PmEkICu2?=
 =?us-ascii?Q?HylMoWTCtujJHd1h6JAiXM7dmoNmqOdotVW+OWJvkoRPdN5IHENc9kUAfQZl?=
 =?us-ascii?Q?9Y00UzQkatF5AImunkwO44ed51DP+6qC6bLL6GojoulSKcznFWykQQv/OJey?=
 =?us-ascii?Q?9JzTSJY83dJx52F5KT4MiMkAM/BPXczOnePZ1LwJ3crpc65zd0ydv4VUB6ay?=
 =?us-ascii?Q?JyGRemnvm//65v6QuKEAOPtLieCXxrZuNJVP9cdVz8nkgJsX7lTMvB1qHixw?=
 =?us-ascii?Q?O9WRy+NiILwufzqfKeXMaGbostYGyfqyuDGF6MhgKn69Cfklw66UomI8nQH+?=
 =?us-ascii?Q?WFaQMEe6PziR2PQ6sdehD8CVX8kSO4WSpkYIxTQm8E2UVSnB6/ARGE467hMf?=
 =?us-ascii?Q?3+wCZJWMIQCWr2o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7lck5Tux9aqUt3XqYE8BwthdI7F/EwfAuuDxcFHf+xWhtHlEZmtjGyTGqQ5Q?=
 =?us-ascii?Q?BANdDBECZiooGNkQAwE49KlKT0rt3asZV5c9j7sI6ZaeNHessg9gYs6jpB4c?=
 =?us-ascii?Q?XeCVsi88Xfw1vi4bkbWumN/fa3mx7At+/TsIB88T0OpfQfayEvDYhrju2pIT?=
 =?us-ascii?Q?Jir7yiCAXaUXx1npmhVwTsmFfb476UWMpUo9bHC+nnnxoNlIhv5Fc2QzjD/9?=
 =?us-ascii?Q?UhxxaEUid2Qch9JrUzSNFFWjtA0hHfTc04oMp65pTkbv1HtLSJVn9hz2PFpn?=
 =?us-ascii?Q?wrfA7VuzjgvyRWSMiu3o/I9XJEgnJgSECI0qN0jM9qPNcX2sf0IJ1llPSyWf?=
 =?us-ascii?Q?NmUZQy/k82V+chPaXILFiSOaazKE5lMmxJuW9359kA3W8jNTf+aLhlx9eTdG?=
 =?us-ascii?Q?Wuxakkxj7Y12UJb9BUKO6OMFCIrcFKDcANIeeiMoXGElHdpc+DVL6w0b1av8?=
 =?us-ascii?Q?6HstqtnZZWe46jcYWHrSy4+bg/1ik56ChOaaLExiEiKADP+0SbM1xXwk5fCa?=
 =?us-ascii?Q?ifRMAWwQycthS+QUczDaBZAollqve0LHM4gHaTdxRWuXK10wGGsm3dghBKiS?=
 =?us-ascii?Q?YOfhlNgt2LL2KJQqICj2Ta0fyJPqVlPSLHZIPS+mWYsZz9suPnnVvLcI8wYY?=
 =?us-ascii?Q?OtlvCgVyUjlFwzz1MosbIADJxbIvGzq5hzGmdjVg8hqkqGVQjD4qDcVTu8PO?=
 =?us-ascii?Q?+Oti350NfnFqZVRs3hg2iIk/dskop4IiPsC/lRWXx+x7aJuFA2CHi3Sr3FyR?=
 =?us-ascii?Q?WgykL/2H2O/qOIKymQJqRyNNtIbnQi7wKDoAIbNagq3lYHMTejeaD4vWfjM6?=
 =?us-ascii?Q?r6998NooNOkeb4L4f+YYAkQOWLcavs6qOBoEBZOcxbfuAsDu9Y7bU9XEUa4q?=
 =?us-ascii?Q?dVcPS5zhHP6kNmW+RqStVJ58kTbOSTSqblzGPgvW6hYKAC+iw/zgj59KG4Kn?=
 =?us-ascii?Q?kP5iLbgz7qHlpjd5U3hSTLlK3xggircjWfyZHEm0hm+/slP/JNHvakunmKGV?=
 =?us-ascii?Q?4JOrNOzTB3IFT1nXVmdcthf82mBMoW/vN02GMbKZyKj1nR/6KqmQm229oQQb?=
 =?us-ascii?Q?JTH8RZPayPi/9jSLLvJPXK2ZKhHu3nIQ1w+yy7Civqze9IUFJs4nGtVXm2kn?=
 =?us-ascii?Q?1tFpGdqBidL0UHgKphdFlP561z9kBVSVcoOrHJTiiEx+8FUQuzb1SdcFljHr?=
 =?us-ascii?Q?KRo61X2oM/Y9in2YQn9w6gicD6R76zkLqZPbEA01wjKHJG0/5EkOOWE1K45o?=
 =?us-ascii?Q?kIZ6fKgBDU8SL1Nc7uHBvvNOuisk3aNcDYNzBWXFri4dJ+60w8VJkDqzHeNA?=
 =?us-ascii?Q?yIyuiqtqPg9Vs7en2DhUmXv8od/cmhuHIJ94gf3yKUflIdK4zUcjOqnvF6Tx?=
 =?us-ascii?Q?Z+WpRomBW0H/Ok/ZGyDhuUUIPI0iHPwnZ3JuzLmYOjDR0q18TZ+mtwMe2pUN?=
 =?us-ascii?Q?tFohoQzpNDsp/tOT2ml0fTYqNw8Z+gLrveJhr/X/GFsY5qd7U7eLikJvA/so?=
 =?us-ascii?Q?tUdiFIxtDFM9wuuZN2xqjKWJdMRWRpJsJwCxxjG1mmxS2dJcp+eAIfTVgbxm?=
 =?us-ascii?Q?jFUK0hx3p7cwIsbksxyLHAIGun9H8DtmHG9RkNV/5iq8812VLBIeYOJ1Gn1R?=
 =?us-ascii?Q?9zr0wdlLIF2XL2Z4SpVYzz8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ef326107-6894-4574-2e70-08ddc914caf2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 11:42:10.0037 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RCqWUXw79FNGc5mFgCuBcvO8XsUAe8OK/IGSR9uiueil64LecwZie3OM+O6uovPShRQ83KljArAYcrfqH4xgVA1gHTQLtKOGSLLmyqtYmO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9908
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

SkyHigh spinand device has ECC enable bit in configuration register but
it must be always enabled. If ECC is disabled, read and write ops
results in undetermined state. For such devices, a way to avoid raw
access is needed.

Introduce SPINAND_NO_RAW_ACCESS flag to advertise the device does not
support raw access. In such devices, the on-die ECC engine ops returns
error to I/O request in raw mode.

Checking and marking BBM need to be cared as special case, by adding
fallback mechanism that tries read/write OOB with ECC enabled.

This is a port of linux commit 6d9d6ab3a82af50e36e13e7bc8e2d1b970e39f79
(mtd: spinand: Introduce a way to avoid raw access)

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 22 ++++++++++++++++++++--
 include/linux/mtd/spinand.h |  1 +
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 9f150eb8585..a8fb3177f8a 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -298,6 +298,9 @@ static int spinand_ondie_ecc_prepare_io_req(struct nand_device *nand,
 	struct spinand_device *spinand = nand_to_spinand(nand);
 	bool enable = (req->mode != MTD_OPS_RAW);
 
+	if (!enable && spinand->flags & SPINAND_NO_RAW_ACCESS)
+		return -EOPNOTSUPP;
+
 	memset(spinand->oobbuf, 0xff, nanddev_per_page_oobsize(nand));
 
 	/* Only enable or disable the engine */
@@ -737,9 +740,17 @@ static bool spinand_isbad(struct nand_device *nand, const struct nand_pos *pos)
 		.oobbuf.in = marker,
 		.mode = MTD_OPS_RAW,
 	};
+	int ret;
 
 	spinand_select_target(spinand, pos->target);
-	spinand_read_page(spinand, &req);
+
+	ret = spinand_read_page(spinand, &req);
+	if (ret == -EOPNOTSUPP) {
+		/* Retry with ECC in case raw access is not supported */
+		req.mode = MTD_OPS_PLACE_OOB;
+		spinand_read_page(spinand, &req);
+	}
+
 	if (marker[0] != 0xff || marker[1] != 0xff)
 		return true;
 
@@ -783,7 +794,14 @@ static int spinand_markbad(struct nand_device *nand, const struct nand_pos *pos)
 	if (ret)
 		return ret;
 
-	return spinand_write_page(spinand, &req);
+	ret = spinand_write_page(spinand, &req);
+	if (ret == -EOPNOTSUPP) {
+		/* Retry with ECC in case raw access is not supported */
+		req.mode = MTD_OPS_PLACE_OOB;
+		ret = spinand_write_page(spinand, &req);
+	}
+
+	return ret;
 }
 
 static int spinand_mtd_block_markbad(struct mtd_info *mtd, loff_t offs)
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index fb3a2e5d909..63626c9c27c 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -320,6 +320,7 @@ struct spinand_ecc_info {
 #define SPINAND_HAS_CR_FEAT_BIT			BIT(1)
 #define SPINAND_HAS_PROG_PLANE_SELECT_BIT	BIT(2)
 #define SPINAND_HAS_READ_PLANE_SELECT_BIT	BIT(3)
+#define SPINAND_NO_RAW_ACCESS			BIT(4)
 
 /**
  * struct spinand_info - Structure used to describe SPI NAND chips
-- 
2.47.2

