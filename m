Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F993F5545D
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 05:25:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C1C483E81;
	Wed, 25 Feb 2026 06:24:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="pwRLsTBD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA35683DCB; Wed, 25 Feb 2026 06:01:28 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B232583C39
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 06:01:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QWQ0c3WhFWXCzuFqApl0Cc2kgwAHLjQBBbJCIxYA+SxxJcyl+K9ckoGoxgphUf5NqtN967dTeMLFGaFPXUcMKHB3Q0bW6TDuBRIhDyQ7cqVvwKH5bdMdR/jsDi0RxYMbA+jK5F5+wGozRYznPtYtDZKHN3aCqtuAkH8LhzjF8H4G8uZPJSUzUT1zeZbUL3T807Tv3BYDOKEHItRFtopYvYtJxo3xYIXnWULMc0bQSUFrCFikamDQ/wpbsL4m29Doo7oy60iFVQACjWShh7EbdtjocRlNjM6YHVyrzwe8tUIpyUbQTwXlKTqqdVQCkG2XPhZdJanz/LMoBm50i02Tzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCX5FOc1YegQ7kjSAnWZjcTXefmoROVDcLnh/2Up90k=;
 b=dSxHcbCStf4GHJsZbOj7fH2peGxO6w/X+Wi1emkTwy3dXdbJNmOeYerTb2e+LAoLOwGR+xXIWgG6Undvc0mRVfakT4YGUnS9jJz4M1wbAiVDvfXrC4wjvH0qqOkT0YvkBmBvu5qwubG09nWQtNCg24jlW9ExaESnMaRJImO0EQhQ+h9qPZ2X1omBdzE8blNrUTjfXXSmRjXOnxjfkMKxyd6wgIjmOt7ggXYP9T/U/zl6NXwocgVQAlSwKe+SMmsny7BNOfTDpJ2qamFw3QrV76mqlOutHaR85jFt+3JweQhOPNgcaCmjg0mZLmZmLvWESaYs4dEBkoGEs4oOE7/n/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCX5FOc1YegQ7kjSAnWZjcTXefmoROVDcLnh/2Up90k=;
 b=pwRLsTBDX/nVPibU3R3ance3vC2rZos5/FVJs2TQGYeOwV94lXLOHgrSfTqfs/EL5yNE/ZareqXJI2G6DT3QQ52Je/WB3sl8jDSz9oeyx46rUra3N+x6BH6E2PNuckB8YaN8jJgzopGT8//aNaNpqV/mhyVkS0/5ICz6YuA0IV3BglmqzRCBDLLQTWKDHCuKkIs1y4v3DYshVZc+VvSA2JQsP5ub2PqZz559QqrI10EV7j3/NVHq1hngDsFauEnS+kYlSAAmbmBMnba5JzZagcKEDAjSm2SkFGufCposlXal0GS1ZXj0YByHPWtyivXktcKyo892ng9thiblXFGamA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by SJ0PR03MB5390.namprd03.prod.outlook.com (2603:10b6:a03:283::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Wed, 25 Feb
 2026 05:01:22 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 05:01:22 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH] drivers: clk: altera: arria10: Fix wrong API used for memory
 free
Date: Wed, 25 Feb 2026 13:01:10 +0800
Message-ID: <20260225050110.14290-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::14) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|SJ0PR03MB5390:EE_
X-MS-Office365-Filtering-Correlation-Id: 14df80d7-cf39-4282-a907-08de742aeb9b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?28h3mSiiLHqRKJifdoB7ZEiob69KsWC1rMEkwt0F3bilx2d7EVQhR6HiEEBc?=
 =?us-ascii?Q?KnmsTuguTYFxfa0BP4a3n2Q6BiHr0eyOr3GIWQ61mZP9SsiUWqu7MFx9424X?=
 =?us-ascii?Q?En925c63NF5nDkOaiHuvSMhhRI9d6d8MyIKQV6wEn7zAmwnXRWqYjN0hWulT?=
 =?us-ascii?Q?OiHoEZl6/GBVJ1jak++ZKbWmBS+LPpRWKY1Nr950fsLyhjTpuMwI1cDV9lNl?=
 =?us-ascii?Q?vOpNaGXR+NjTnwGP5VmqjluiBgzwzbBFzPVslyOQEcpBlnrDXnX7h3r5tlrw?=
 =?us-ascii?Q?TxdYKegeK0Z88bxmsOsZRUxfpWwiINbhrxJZoKqyx6SiRmVeLFit1wv8U2pO?=
 =?us-ascii?Q?k1vKpJbpDqygSRX3zJ4hYdy3+lq3S5OIasOFKgG8gQ8ptFTA3eOpCS5hHuxc?=
 =?us-ascii?Q?kQXbjFwTVnwtiaO5nPJMdZ+Sij6sgYiS0hFRNScRsaiEwjAzc1iPbAh11RRQ?=
 =?us-ascii?Q?K3TPQEQ6X9c+rOCmyirxxqqAL/hBRTfdpXB/0CHgFIh41m0AMEjN6q1W8ld4?=
 =?us-ascii?Q?daWua4GZtLhzEGiJzKSgSuef39fuNFIE6/9KyDE4cPdgdd1MPVTpQTGIz4Hn?=
 =?us-ascii?Q?0F7gHU2I86GySzGMnoLXyNiUpw9ak0f+IyfO8TaHCkJ03wIy1dz40G8VYj3j?=
 =?us-ascii?Q?pUni9943EdIK8hfPwZJb53nwc3IXxKtL1UAjNG2xr5nhyCMMv4AzqC9IQ4Sn?=
 =?us-ascii?Q?EwXBszkmjTrhO9Lc1Zywb1r2fzaHrp+atvnyBHBnJAWCmGtLyUtDW3Np3ZR6?=
 =?us-ascii?Q?HzWeZo1MEHyNCrGcW3ysGJaTTbsKN7khdFS2EpmFJKoU545ABcOcAxUGGF1L?=
 =?us-ascii?Q?7lUTwTCyKj4jWGy7G/xrda2rg/HqxommTkRC+qmD+OZD4nOxHWLM9DIDQhYv?=
 =?us-ascii?Q?q60eL9+ycIMamiKq/nKP4QsAnIb7PVFKyPQoJGCBR/X01bQszOv9vzwd5A/y?=
 =?us-ascii?Q?wrj9bt6xq4htKu32jB11ApPDVfcm5S1l5LN1TveRHKqRrH1ZDUDB1Jqy2V60?=
 =?us-ascii?Q?u7N+Lnh0WdgL+m+9HtMvQgUdH2sKLh18A1jJkGonbAN/RstPepJKExE/bG7b?=
 =?us-ascii?Q?x33laixR8HC+HebbPtkTfcFII/A4WhFFe29iBYheobaXpejgv2RpREAPmy4n?=
 =?us-ascii?Q?Jw2bDcPxt1RAg4NFWAg4e4e0qaFCGgDHXv1b5ETYF9JsgbXk2aCke2vIEA0W?=
 =?us-ascii?Q?Q8Go3td+l7/zsm42qQQ0QHhE5WE6/z8hgyN0TaLiM9Q26HNv73cgQx6BxQd4?=
 =?us-ascii?Q?VniZAE02vOCNVugrwoUNrQXDjVAtap6IzQTqH8AtgmJTgqePa13PSpX9Cu9p?=
 =?us-ascii?Q?UHnjhEF4vtpzgFiguA7qAlGg+PD/ibFwYLAiUFunwg+wn9Du+24JDl9s281X?=
 =?us-ascii?Q?H/hG6drcqlrI0N8FaRAd9X49QlqPwXcVYRyqKrbXhwljQ0MdRl6I3p5RMXli?=
 =?us-ascii?Q?83d7MDcO9MGVZfaEh7d9ljFnj6Pl6Fy3zDgq4BKX3XJJtuH+ZQFuCpyVflVO?=
 =?us-ascii?Q?jcjeQeOxrVMYTaWGFS4m8TiSO8b8yYnRIVV3i/tjyNDT/2GA8Gn+oeCkUv9Y?=
 =?us-ascii?Q?i2fxQUPub/PKkBNWvbE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hm9b0MZwbpsynPyPUDa0ORPjBlMt7tUdM5EgpnfRjziX8G8/iiPmw3tO6OFA?=
 =?us-ascii?Q?2ZPZ3AcmFNOWosCeLjKhGhUtBTeVigtBGYRogBXJOofMywoNwSHGZGilpLPu?=
 =?us-ascii?Q?FK3xAM4Ivde0gP0tZhQB/GSc5+2yw7CNpY4ansvUypCQCKWXuZLs6Jy/Wzuh?=
 =?us-ascii?Q?dq7gymWOox+Y1NqmnLIgecKjBsZTTGkgYKCM4uiGIWxAJzz/vR5zz+OzJd7l?=
 =?us-ascii?Q?+3qdOGqKENCbgt9rMcbJN1gP4dRj/XpqKRf1NpqPocKBJEWLFBIxkK1LcmwG?=
 =?us-ascii?Q?sb2ybQ4Qc1a9m3K/7p49DGOPPcA9Aw08EbaRyLGYAfXevP9XrQH925FwjGrE?=
 =?us-ascii?Q?6z45NzTdvRCPr/IU/XLChuBBqGkWHP1gciJPmbby1eeRHDaBW/+F091WACPN?=
 =?us-ascii?Q?o1nIzDXFj0ZEnKUtniCgsd73BpJSqncBy+rvFfFaGkhPzAUuWlvp/Po28SDX?=
 =?us-ascii?Q?EOLpUaAGRiQ4wQmYBmCg9e8o659bAgkE5CUNLts2DxrOJOjJOK2D4ZVMG2Mp?=
 =?us-ascii?Q?HDsgahwS0zgha7BkLKITfbH6AXpKgyopT4Z2owZgVl3kDnobZELw55OW2bkR?=
 =?us-ascii?Q?MYZ/9Hi8x0phqvz2g48/UcMi//JOHJMm/Ohv/0p/2Rn5fJnckLy/8nYj7cYl?=
 =?us-ascii?Q?ysWkw1KhYGyBO83oJR3LU/BLNIPq4D5cfcfD2D0B2u7tgZd2m69rj0t/wpSB?=
 =?us-ascii?Q?0ioYggufwXdmuLXrOH9cPaby7aJQhdtuphWM3F8/iLou+jfFckieAoZi0ZKm?=
 =?us-ascii?Q?jmDs1RBYN0YCAOoyJkW51aG7LHERpKnGrA7WMOJp8YYasX2PdGDPbV2gh9h7?=
 =?us-ascii?Q?oYn/70piTGt31XBeDzyAYPdP/n9mmGDPmmA1YMaDYS83nTCeu2mBj4jikILf?=
 =?us-ascii?Q?uiTP9xOfV3cLviOdN95doTzkpW4+kUOpJe2Z2kIktuVqTvjQYB00CsimMqE4?=
 =?us-ascii?Q?CrrLXgex24SQBT9SOUj2qw1n8fX9FeYI2D7n++v3uxtLOs6vO2iSxoLYVNXY?=
 =?us-ascii?Q?gQ1vpjRSGddVPf7aovZ+2NPPNCceS9RuM7lWFGRMl/bk/ma4l0DZKQcP0gDs?=
 =?us-ascii?Q?o7lF1OD6yqNL7lLoxAK720Ov3dwnDeNIMsOw6Xg5YQUp7c+anDxirrp4D7SU?=
 =?us-ascii?Q?uLZeJbVpEqg8XaX3AlaWNUpXUftTIUk78+I+2CcTL4v/FCuByg1WiM9Gy4Je?=
 =?us-ascii?Q?nT7XeN1u0gFCOc/d+A4h9pV0zpRyQF7IeXERjuu3PSNO6UunXufZnJP61as6?=
 =?us-ascii?Q?H3bjv72tv6ZQdN46vG2rpcsEptn/bIupmMxFh0h0Wl4MPeF4ULWR8ZUhAXHc?=
 =?us-ascii?Q?lNIBrFEiljdVp/g8BOg71Bq/bIQV7RQC9BdYNExIg3GossrwhGa/+wDzDN/P?=
 =?us-ascii?Q?Lkve4YoEhEuYc/GMnpupNTn0wEN90+29nIC2HkCgdlg6wDtAe80DYmOEKWaV?=
 =?us-ascii?Q?dKYzdt14ofUXVE9EoK5JoEezhRPB9z1kjdEyOPbTMN3AYnlVQl0P2XWc1kNC?=
 =?us-ascii?Q?fqytkOfJC1MUAm4t1IvNdFNzF0F01jXdLcr2FrL9tZIuvtgU5zGXr+iCzABr?=
 =?us-ascii?Q?DU2SDPEytIkQlZsl5+4psXloDeV9khuzZM0KMue3Teff+l9jp9NKoSiDRwZF?=
 =?us-ascii?Q?m/7K1TCs51utLwvmAYHzpJLmhZBAuUou2ywcUxGh5LGdFouzbMN1rS4iTq8X?=
 =?us-ascii?Q?A2htVEMxs8RY3kUWHSkTZFijrOC9xiRrbzHsNITaQAnjEskfyNVO+z57c/Lk?=
 =?us-ascii?Q?obQkYX9u5keWz7kXlLzURtV0KJF6pgE=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14df80d7-cf39-4282-a907-08de742aeb9b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 05:01:22.7319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 97FdeDonWgXJmqNQPZ5bwgJK7p+O5kK1V0d3cUTmB3kVNnWX6pac0Hoz3OSE0jlez4SQODiYmhka0yqrqGxgSabMTi6/40aRw6tXccZCZws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5390
X-Mailman-Approved-At: Wed, 25 Feb 2026 06:24:43 +0100
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Fix the wrong API used for memory free.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 drivers/clk/altera/clk-arria10.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/altera/clk-arria10.c b/drivers/clk/altera/clk-arria10.c
index 1840f73beee..e56e94adae0 100644
--- a/drivers/clk/altera/clk-arria10.c
+++ b/drivers/clk/altera/clk-arria10.c
@@ -223,7 +223,7 @@ static void socfpga_a10_handoff_workaround(struct udevice *dev)
 
 	ret = clk_request(dev, &bulk->clks[0]);
 	if (ret)
-		free(bulk->clks);
+		devm_kfree(dev, bulk->clks);
 }
 
 static int socfpga_a10_clk_bind(struct udevice *dev)
-- 
2.43.7

