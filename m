Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F3DC6FD1F
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 10:05:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD0AF88375;
	Tue,  2 Apr 2024 12:05:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="ijYPvBvW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D84B87F13; Tue,  2 Apr 2024 12:03:20 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10olkn20824.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::824])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5751A880E5
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 12:03:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xiaofengvskuye@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5/6oYWqzsgbrzZMIP+KOyJqlRX+ybZfOq5MJm7waE6gBOdlFVUMqeGVgj01/8oMdU6jYPvXiNTDL3mnfYIVLVWTIEz7bAxl21JjFm1AUxhhEJ63erCOGun3IjnbU3rjiQKZG132ubQIOjb51xDMrn5Ej6JElvyIqjS7WV7W+yxjj3zKRQ2MWoejsuzhPG4Ajh1GYoU9bLHvvO/yzDnHJkbFLp0INYgTNiZldUi2WE5gez7GBry38Xi1o0UaYiMUdGgLYZd5+UpqnrhkgH7X81Ahj443AgbIJ68ae5LTv5YQ3ZgURAVwca0+fOqbTYYg8PEyfedKJ3veF7HsWBaDrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yR2lI2DQc3skCsWXIFrZ5xCK3zN/R9cszP1rOka+5p8=;
 b=PjSR2FL7feD2XcQsAWfRzhLX9xqe0Sm2SCSvUQOvwynv0F90II7DAr+Py/hOOWnwgmtIvVC3WhpJQoO4ao9r8+Lxee7zNHdNZdY85BnwlAbevrsEJyhZeLNkLleE1iOtj50ioCQmFQBPyV2NN+IedPYlXlJOBouEOtuq9rg5clCBI13q7qv1Dsw0co63Q0EXknLdENRFS+dYpjD2j56fNhilcEEZqLr7N/6AT8O/XD8MoARowzbjzc2vIlSIqKxd0L8clSevQM9HfSSCDbM7Lm6vHud7jTT6CJoi+LRQVz6snK/JpHRfT0ZtPq/kaRRQL6/6rrcXWqyspvrTNjqWQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yR2lI2DQc3skCsWXIFrZ5xCK3zN/R9cszP1rOka+5p8=;
 b=ijYPvBvWN0lkVKZKWVS4bls/4LkC5CQ5fNqmfzqR4t3C//K7iJCAUdauSx1RsvuzWdEuZumvHK8QTpTWG3BfmDpPoktcsTv432tPD+9w74xt8Zd8UwJ1kiH9/erRUBAvfRwlz0OP6cGdKj7eRyJpiLrEJFihT+7bBNPo4nuE1aWZ1EeC0+ZP2tGZcAXKG4flrqhlxHeaKD5prAJX933RSxmPqh26mALHZgvQ4q8zmoePl5mqFI4jO/GEWyt28T2/pC5LbLUBL1KANqYA+KAWTvlfsBjHXfL9c0lWKK0SbfhFFO3po9DS59BHc1qW4nHibxiYdMRT+0STMktF0OZ1Mg==
Received: from PH7P222MB0668.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:31b::13)
 by PH0P222MB0531.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:fe::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 10:03:14 +0000
Received: from PH7P222MB0668.NAMP222.PROD.OUTLOOK.COM
 ([fe80::8392:7df5:faab:8f4b]) by PH7P222MB0668.NAMP222.PROD.OUTLOOK.COM
 ([fe80::8392:7df5:faab:8f4b%7]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 10:03:12 +0000
From: xiaofengvskuye <xiaofengvskuye@hotmail.com>
To: kever.yang@rock-chips.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 trini@konsulko.com, lukma@denx.de, seanga2@gmail.com
Cc: u-boot@lists.denx.de, jonas@kwiboo.se,
 xiaofengvskuye <xiaofengvskuye@hotmail.com>
Subject: [PATCH] clk: rockchip: rk3399: Add SCLK_UART4_PMU support
Date: Tue,  2 Apr 2024 18:02:59 +0800
Message-ID: <PH7P222MB066847DC525C783560A6B5AADD3E2@PH7P222MB0668.NAMP222.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [ZSRejDlTMOsA0TIGHvcKaHSEhyvn00ef8MlGej4wuX2gcmmBDoSoIDsTHFdErWf3]
X-ClientProxiedBy: SL2P216CA0218.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:18::10) To PH7P222MB0668.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:31b::13)
X-Microsoft-Original-Message-ID: <20240402100259.542540-1-xiaofengvskuye@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7P222MB0668:EE_|PH0P222MB0531:EE_
X-MS-Office365-Filtering-Correlation-Id: 111b7e9a-e115-4737-afcf-08dc52fc1b1f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NLJ0w5tzsYPR7MkbSw40kTmTceZQp71U819LcByJgsKfbB/nh3qO8aLP4mD1iqPIBnjimeaseXLtB1ofTdXSpf/VjDJvkRqTypBSZJfqUYRrAQ+jRwkPQd7lXxtbIWqZOlmGzizC2JF2+ysVfTNi2pHip6E38JZzq+q/D+rDt/4rywU6os5PnLCcGhRWwv1kDByWZQvd6ouvbJZOpkKFpc4/yx6mJ9Sf2wNkxWH5Oaz471x05ICfmdOGOv6jNxBYQ1PMk/nScqNHICoLxZTGYUEDhzRxbhvkAbMEJyLlNM6rXQob0KZ78VEGFZwU7XYSejhYtR7s6jDnJCKXxoXL/sdKeFihZCGkvZbOEcQZgF5IkFEz8hVQQpYPQx1THYCc0CEe5cADVV7Mo1zmIGw3VzO9y+RTZhBt+gigrpnrMk2UiAuKiwMI+PEwjXBwWfufslI5EJWBHuX4fQwMD1WdlOk9pBH+GTGaiX8ueoFuC8bK1t0z2kJkKSB310n1IX1X36za5seCHpavuaKzqrwAeoQPS+r+tMjERd7CCNWhMtRy4AD7PS+05FxUN0o+CmZ/hjyXBmgKuhMYp/5QCRw8EdgaCZuXQgvikmZeLYwhJtsyPX/pJ79yhoCtdMy3VP1+
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dp1J58XnW7kI/P6GXCC4FQQMYFMctNvKUaJCGM7V4LVRQZ3L42Q+llrglxHV?=
 =?us-ascii?Q?VDVyOgzCilFBcfJELqcSixOf6ZBqb9bxUxCWUK60pMbEbQWiqkDm9JVMoSYn?=
 =?us-ascii?Q?YXYXnw2Ny3NF7RYbsj6lZzsRa4paWpQzUqbt8Al7h9ynRpsz3NwbcQI6wvEY?=
 =?us-ascii?Q?+W4I6+PiiccDH1Ph/w2uJEibrwWVLwRBukOscvoEZUTRPs8NREL+7bFeBdVE?=
 =?us-ascii?Q?pCq0vvRWSXGRlfz5j/lCM+3pDScBo81cWhHX0/+ZLGPLDd4F8wUk025B+x9k?=
 =?us-ascii?Q?ytTFe05m7K/bJASRr4sxPi7cvqbxoXM9fOeGd09GSAsN43xD9waPQhNcg2B2?=
 =?us-ascii?Q?b+PjY5UTNz4e2y6XAJi2GsFI+fPJicXNMziCFhrveTD6G+hxHF8TRX2PRVQf?=
 =?us-ascii?Q?TWrcTtu8y9vR+C8GBAeQzg6oeJwEszWIwF34jWHFc6Ku5x6z3XAkrJfmHFG2?=
 =?us-ascii?Q?/pgH4kgZhWn1rZJkJnyCm6JUMjA1+9zIOAEucRwIVSSjdmojsNOG3ImwJTAG?=
 =?us-ascii?Q?orbzzW/sC1YKH26rLOhAgTntybgViBhC4cf/RimC5Ft9tApB3TAd8jw18zV1?=
 =?us-ascii?Q?o6x/lSQv89mGra+nVgSVjgq07gqwHAW16Sk4MVS33AjeC3SuPi6K8JRE7Bgb?=
 =?us-ascii?Q?rF98TNwrXyx65ESp32FxyuN7UepIIVjcxSKnWEJm9jDuouBCEh1E8/tqhE6H?=
 =?us-ascii?Q?1n0lfyFBQ/UW2MLkMH8HEHgtddKHiZH9uIu0hdEd3IhrcHR5UqISpH8Z9KGK?=
 =?us-ascii?Q?tPuWC9gnfx3z17X5LdRls62Sp5QZ7WeH8fDHO5uBMs/OsiT/dV3u/7P2biZ+?=
 =?us-ascii?Q?LaIpEYJXQbPSBVPunB5WLULMhe5HzvwpYxf2u/WURaF4cJJBVkD9dCbOtivo?=
 =?us-ascii?Q?g5c/K+e7V1g7p+/Mz41kB9B81qe8J0DKE5+73z5mR/Pd7mzszgzEBcAqfGRy?=
 =?us-ascii?Q?+vBsgdres/lkFvs3DDzahyfYHCBVMh76xCHPxCjZTMBTNjnVXT8RXi66hWvY?=
 =?us-ascii?Q?KdQ6l7E3jK9NGDAMfz7Ehb7yCQH2booyKn9JJSCNwZ3b7gPuPxqJG0RCwQnH?=
 =?us-ascii?Q?gwMds2dAfO4Q5YVg1aoJwNTRnqErgn6cT2mbJs92WHWGMVgjaelGN0xhrkr5?=
 =?us-ascii?Q?0zyefTF+6rl5rhFLAtyhv3naHKIDg0/+CrMtRALaZtI7HqFYl6Z7MdJuprCb?=
 =?us-ascii?Q?0u9XSZiZ348EMN66jEn4RmlKDKuNoParZx2pApBSQ//qNQ9faQNcLXUPg/Oi?=
 =?us-ascii?Q?TC3VyZ4OqKjg4kZzOrrDaOV7HgtqC4c9v2H+2bcy15bbxQcN9dXPQJw0SGq4?=
 =?us-ascii?Q?xN5X9nLnnGLGAXVVT0UfmwsP?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-f13ea.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 111b7e9a-e115-4737-afcf-08dc52fc1b1f
X-MS-Exchange-CrossTenant-AuthSource: PH7P222MB0668.NAMP222.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 10:03:12.2875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0P222MB0531
X-Mailman-Approved-At: Tue, 02 Apr 2024 12:05:17 +0200
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

The SCLK_UART4_PMU clocks is used as reference clock for UART4 block.

Add simple support to get rate of SCLK_UART4_PMU clocks to fix
reference clock period configuration.

Signed-off-by: xiaofengvskuye <xiaofengvskuye@hotmail.com>
---
 drivers/clk/rockchip/clk_rk3399.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/rockchip/clk_rk3399.c b/drivers/clk/rockchip/clk_rk3399.c
index c37e8a53a2..41eb13533a 100644
--- a/drivers/clk/rockchip/clk_rk3399.c
+++ b/drivers/clk/rockchip/clk_rk3399.c
@@ -1563,6 +1563,9 @@ static ulong rk3399_pmuclk_get_rate(struct clk *clk)
 	case SCLK_I2C8_PMU:
 		rate = rk3399_i2c_get_pmuclk(priv->pmucru, clk->id);
 		break;
+    case SCLK_UART4_PMU:
+		return 24000000;
+        break;
 	default:
 		return -ENOENT;
 	}
-- 
2.43.2

