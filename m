Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E1EC5DF8C
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 10:26:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE1E940623;
	Sun, 23 Aug 2026 10:26:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rs49TYTn4XvQ; Sun, 23 Aug 2026 10:26:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787480807;
	bh=NArkH7QD+gPhPhI8MT5wm7bKc1dWIY67D+kB9+yyGiY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LMYoqWqMpv0uddayBS+ihY2uSljQYvIC5o01mTEwG+J24vnaLzqfOWUPN/GYw4nmT
	 vnwGHfB95oQtWgLrI1vt7Uh3kEkcfbwqyPzNZiKkF2M5s5km86Nk2ui7kRzhpcG1Hb
	 M0lZToqnX8XkMYQWLGXVOiyiv+J9937PG5U60EHSi99427nOcam7SBhMCvomSdsFFL
	 fzLnhFuK0cUJW3vyrYpH7R+gJA7Smd04cp8mW/0bV7YHBBwuizc8vGJugc3dXE8XvW
	 XYNOi6cQusCKzwmr2bCOKJN1s6PpWh6fjXkGCg/70PYK9d5xcvSQ4SuGRozgR8GtcA
	 S14Ryhe2zv7HA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1864E40576;
	Sun, 23 Aug 2026 10:26:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 10B5A29B
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 10:26:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EB67C4007E
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 10:26:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nYavMHv_1q05 for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 10:26:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::3;
 helo=ph0pr06cu001.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=kbwrKc9a
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 00D9D40059
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 10:26:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b0D+towWUZjKBJqooBcTK1nXY+gn8vefuCBC+Imb/yOcRXjNQHskPRYVw8lQlIO4C59Ez0cdVgya3zT0aOegxEE6am/9bmEMGjQJWJBh5pr4sWny7wx5wcbI2HkIg128XueTZYvRLLvpK+807hiBcTMZBLfMwD15nzzstmil6Qj1Vcj/1BNdoq8a1akMJAxV8LIzuh4QYM65+mi6377arkqtXPmnBUhz9spD5BgcLhzeq8uSIWEf/iAT9fHo3UDG4omRCwByPgtasa7vfE1MrByRb5TGqGqW6I6P4CsFVO/9lEzs6XvQey6QzwpqzCWpaQL2Ndwvu+SNHw73I5LNfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NArkH7QD+gPhPhI8MT5wm7bKc1dWIY67D+kB9+yyGiY=;
 b=doNPTO+uWaRu9V/FavKR8oQG/7i8KDQvIH6Q3XlC/L/Q9nSYRAkwtdnFZxGcT+2E4jeiw0rc4igHutRR4KHcSUl0Sub8yx6ahRppfYQS4nsvTdmAcV7EoQMZH6KthhHiB76gyZkTZ95MKyAuj+RA/ccv7zl2wcRcaGxrua0c6UvzDwspEpY+pT1Lj8dH0qz+YtRmTSgtYlH/gMicj6Dh/TbO9RSAJOLEg/rG1sDaYki7JhTTuyrZxJruAN8EOVXbYa4XW6WaER5VS1rvdCD7qieP4nNOQ1zoidad4ZVSO+5pTb5Cgwdss+hZMwMY9QvoWRfsMdf1h0fF8khfofEQbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NArkH7QD+gPhPhI8MT5wm7bKc1dWIY67D+kB9+yyGiY=;
 b=kbwrKc9aroE4TLw2OTdVSkONIki11jN3oan7+wgNjQnoYBGCU3FfP9dKgvd189FrFKhTP/ob4qb2AG+uUV9N2aHmot4d2sBXdg7N1yHmgAO9hDb4Fat0NT5qjznZeFG9EqpUHlbHJMUxJXdNpsMAyRiLzH3NwHVMvrCUr8CjFH9FF/Lig+30xpThEf816t1HnOWiEFNCNjHhu17tJbE4bLLq4PtVX9fNmhkt+agRfa4XiyGRuqToxPl6oa68Bv6s3oo9ohE904w6JnbC3d9xxbY0jX/rgja9Q3vLlkyujYXmTTukdDgRVB9KAl7Bh8niuR6cSHp91l0yS8wEwCbljA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by CH3PR03MB7459.namprd03.prod.outlook.com (2603:10b6:610:1a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Sun, 23 Aug
 2026 10:26:39 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0339.012; Sun, 23 Aug 2026
 10:26:39 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Subject: [PATCH] MAINTAINERS: mmc: Add myself as a reviewer
Date: Sun, 23 Aug 2026 03:26:33 -0700
Message-ID: <20260823102633.13128-1-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0037.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::12) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|CH3PR03MB7459:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f1bbf87-00ae-4c59-a888-08df0101046a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10067099003|56012099006|18002099003|55112099003|11063799006;
X-Microsoft-Antispam-Message-Info: jQ/j5+AVEtbbveIbP0OyIcVyt5mWTpisI9meCOqcuxuXN4TncyESvJStoNl0xW7UhAVJd/7X5P7BA76SHGKPfKttNFGwps7LhFrwgtd5RQzkxtrP1r8x4/kWQOiadCm2Gl7P0cu0iHe0KvK+MntUWjlPBzf5c8GGWrwjqW3cxu6b2lqJnZoOvaGCu7lO49I9rPjjFWVBx+UFoLkNe5Gaw+DqOnxRVE95BJaew7tXOjOF2WJFV2FDi9n9XkhTiDu35D6gpqSwFxzRn5ZO3uufzM0IQeo7fHLigibksMbY3VchuHJy2VlGzMgRQbx/4iuB6b3VBb8EXg4PiKJ4RSZaXAUivvZNBPyQbv62YeQ+B1s34dz2YsShoxAXyhAuA0BcvDC2Vk0EJQlq9LUQRrdXCFC0l+IUTRBBZ1cC5qjaAAlPepIaFYEciCBypevPwkydYBog0hzhrBaKG/OWdWePMe6F4mwVgV3mzUrP0TV83FLlTkUcAB/PtIRjW59THIS5XSiJVqLvDohuSXSa3A0hxo6vtgctDxRcRiR6VduGJdyJj7oE7koxsWQQAs7IRu+nM5ApLYM9fXZX9iBAko625Yqy36qgIP/sLp8oAHAppURW6bfJzncb4GuP8TyTp6OM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(56012099006)(18002099003)(55112099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AR6DVG0ISJ8OFHLuKKTRlqteSK/s8OgwZWb8wX4sKjMkAi0dkEZXUxmoFMLM?=
 =?us-ascii?Q?vtaxodtWXuOROGqsMDDNmtv2DGD/avhhpTqbpIPPD2EPwF5dSPKWWrr/S2/3?=
 =?us-ascii?Q?j5g9/pkGKufNMgSS+28s6AbyoVAZtpUONzcAo9knNEpPVX0opNSGcQt4WlNt?=
 =?us-ascii?Q?KFDeFB1YqhXsni0qPmpVI9ZRzBVIujjLx7oLwLMw4jiRm+nzX1Y7LoJZeh9R?=
 =?us-ascii?Q?G3k5GTLsK/MnftGNTqfDmX+T0MpOQYDcyv6nuFr9sXUtYxEXRfL262WYD53P?=
 =?us-ascii?Q?cTpsX43bBY1H3Q0vRN39ZJyla8ieSk6k1UautbYwF01jFn9UDqLf7DoGzyzm?=
 =?us-ascii?Q?mHA4ESI0T8qqzqDXirbRKRFBwh5TBMX+irQK9yr21wFfYlBAL4uWZPDLqa6P?=
 =?us-ascii?Q?1UCk9V+FuoyT1agFCE9XjVbqqSPTy92skZgXVKQsB2JqlFxryPApXRvKbK9Z?=
 =?us-ascii?Q?hrtR98k1Ida5ZnHmJNqoC+i4ZFcVSgObuOlcVwQWyrT958mVAOYSAK+0hq7R?=
 =?us-ascii?Q?w2T712sRmHJCZdmvTmZXMc+3f/jPeon7Umdgb1/J7gWDh7gt8XXsiaTNgTsE?=
 =?us-ascii?Q?xL1KAbsMMfz8+wsH/7EnZBREAYhIVdakXFB4dhzOpbKuta1ASDy/47JHIW0A?=
 =?us-ascii?Q?b2IYCEmbY4gKIkqGawsuXFArals9VV72VZlsrhg1d5kf8UvrR/Ra6ua5Ss+3?=
 =?us-ascii?Q?W+9w3MlE2HmEXcM3FozFOLbEVZEOuBB3hlSRY16Ev9Xf7nzCcZFgdBvyy7r+?=
 =?us-ascii?Q?knkifijf2Y4cyyl028Nj/5HxJD6I8e9EnoD5fUZ0GEgRofRaL8b70ry3DJq3?=
 =?us-ascii?Q?qJy7hulvNK00yz6YMLa4DvfUUOfUUf8hPEm+3wicFBWeMaEg7L2bnRkTG1xm?=
 =?us-ascii?Q?D1n89hheDveC5s2KY8yt5GZXGLWRGgvUcZ1VJBVtjvaq3O71q6ocd2yZdj8C?=
 =?us-ascii?Q?GXdto2b31PXl/pklF8I3mLGyiaFlt51ssUbYMCzuNnJEbSmrJ5J0SHaYPb8O?=
 =?us-ascii?Q?GIE8V7HlZY1ZBqEXo7KyZInMd/5t9JyI4WiLpSKwyWmlJCgWBiJ/AXcpVgx0?=
 =?us-ascii?Q?DWct7FrJWiWXwJzZuWeYR9vVirX5zB/z3L3/dlpVSIlEBe5zgx94AFW5NzU4?=
 =?us-ascii?Q?gfSs93INXHBEHGQdyCpmqiiLmQzjNyJAAmba8HXUa6MMyxFLkYYvkt+Kl9dZ?=
 =?us-ascii?Q?7iXX0fx3ir0DB8v+l9XVe96t/zJuUICFgOlDvQ8rU/pWKDXBWlsLs3npFfAl?=
 =?us-ascii?Q?M1JyEeckfIOMZybYdy17XlTgOVAbiH3q10WIbQC98jfMdDYvf9qtOLrccs57?=
 =?us-ascii?Q?qnQJcOgxAG5yr9vLP0/nkLBDmYnQ+wGJW0jXO9sZ41EzxKvGzQQsC6XWmD3t?=
 =?us-ascii?Q?Mnmp/eXWQg1uu8pkHgNX0QU4ont3qZvcHS/Ke3X7kM3mPXLnQIUThFx6Ewwo?=
 =?us-ascii?Q?xoSOQ/fAMY0nJS4ehWCxl4+qCTLCZaivvDjyUH8ALS8hPwReMOSs/YuLS/48?=
 =?us-ascii?Q?FzkCZC8oZnFdcwKe2+oiKu8nIFcJsWhx2DwmLSPsrYhFMVDP0Bvzhu0mqVAV?=
 =?us-ascii?Q?mGmy5xCEZ2gicfjDdQcXH1en9F8I+LHD/Z6OOgsH8QFpoVuJJaj7s+acwBYI?=
 =?us-ascii?Q?lWoqB6STMWaInzKLaGjaMurVZL2hvvWrJpltYhkN02pFozijmTET2j3296oO?=
 =?us-ascii?Q?yagryLH84SkPENSF31tW6ujgImd0s1u3AA4zjq47fCmXXM/cPTFn13JKG3+x?=
 =?us-ascii?Q?3rP3dgWP0Ob1S8+X9xNtK0axFL+XTVo=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f1bbf87-00ae-4c59-a888-08df0101046a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2026 10:26:39.3268 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQhCEqigJG7FgoaCT10d95v2cKJ4Fzcy9iXntDFmXMVeV0lqaP3rZdsstJkpJIjugKsNEiwdsvllS8EfLbA6itJX0Es9bR3PfNUGHPLx6AA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR03MB7459
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

I have been reviewing MMC subsystem patches for the last six months.
Add myself as a designated reviewer so that I am CC'd on related
contributions and bug reports, and so I can help improve the subsystem.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index eb48eea55c5..3b6f5f601ba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1378,6 +1378,7 @@ F:	arch/mips/dts/mrvl,cn73xx.dtsi
 MMC
 M:	Peng Fan <peng.fan@nxp.com>
 M:	Jaehoon Chung <jh80.chung@samsung.com>
+R:	Tanmay Kathpalia <tanmay.kathpalia@altera.com>
 S:	Maintained
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-mmc.git
 F:	drivers/mmc/
-- 
2.43.7

