Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE3EBC8303F
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 07:59:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 798BE834AD;
	Fri, 29 Aug 2025 09:59:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="K+jjEexT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11DAC83559; Fri, 29 Aug 2025 09:59:25 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F84183487
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 09:59:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hyEqGPcu+X0N1/8GMOJZzry01E9uZHOXjKw3wSGtjuOGOpVyuOvui+salydmCuwtnJj8xNA8CLkO2DrCE6aRC/ND4CZiwDuCYDD8Z18rTyR45uoLu6YCk/PaUC+7AIoBY0DFow+NYZEXkZ+B1j5qphOd08sQdI+UeaXiCRf9wlkLynXY9Rhw+5iA7XW/fFB53aYw7QNtJDP0p7aqWJ6VPmNVu/3c7wpGjwa0rAwtS4B8SUxPnEIEAqhzuZP7j1bvsYgbS60C73IQDsB7O8yYS+T+7koD0AanMsMsYBY6kQGMKRdy3pgnSy10bDFn4jGROCmrG9XzRMtSjt2TwYLMmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXO+002rLCEbVTU1e1eesPtLHfK0QfIL/IQ7x1kv+50=;
 b=CbklWEu98LJLPLTCHUggVfV6D8Ul+Z1y5kQrSVJtt+JAoi3+cXt2+JA1Sf3W0DkoKkH/Q/tnyK8IHaoaXxwwmo7A5m0EWNZPKbDX9XFPFWx/MvTN8cRK2Y55CwOYjKb9SpRjAskiRdeCj0iFI1EyRkhJkpqn8LFHCmnupfgzTvS/XZoDnoLfjXV9rgVIbeWuVui2gqqalFk7hi1qVv2WnX/VGnL2KG9InDgw0110NdXjmJFgK5J1IrrH6V+88FTZUwP488J6PI9nhZqJRTHQZm6bV6XYF8nrdeYfR1JVO7JtkQemCgT9NvgWuSnSSPTxLYlh0avhqmbuywNBsKT2Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXO+002rLCEbVTU1e1eesPtLHfK0QfIL/IQ7x1kv+50=;
 b=K+jjEexTWIik+jDgEXmgnJ9XBLrdDrZF7bnpa08hcTE+AMaurIooIcKuMQNkm6IvxFn4kD26NKwFSdiUiuUS1SDXPp9kY/kgKLIxRwutk2LaepxjviJ7QsmaBRiYHsFo1rrEN/53L1tvuOiB0qt2DSa/qRD4K5IjSVDS7hEQMMQC/rib7ETKIdycP/YzUOxCnHQBNvBGkoP25IyIvu5pah7Um70nxr/RZa6cQLdBn0a1d6VGaniDrgtJxZOhlzQpBzKhLk2NKoTWXfEi0vESRJnQsR/r2KM5T6xz2kK20JPPQUBqNYGJlfYfqEclIP39sY9jx3TkjNiafQWrGkMyUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAXPR08MB6589.eurprd08.prod.outlook.com (2603:10a6:102:159::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Fri, 29 Aug
 2025 07:59:19 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Fri, 29 Aug 2025
 07:59:19 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v5 0/2] cmd: mtd: fix benchmarking
Date: Fri, 29 Aug 2025 10:59:09 +0300
Message-ID: <20250829075911.2895683-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <87tt1r6api.fsf@bootlin.com>
References: <87tt1r6api.fsf@bootlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0196.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::18) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAXPR08MB6589:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c785cb9-146c-4d45-8852-08dde6d1f4ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|366016|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jClLsmNLPKfmJsvy5nSyDzVrt+peyZWn+ZAnaZktIIMiqrH8JKyksuCc6NSL?=
 =?us-ascii?Q?lbFayQzfmpcgDa/ecvj2z2q6wlFaqgXAbQuoKF98YkbSPHRIx7znnPy5nxwL?=
 =?us-ascii?Q?kOo18rvC4vNbvMzPp7NfWQ4318FeWAcuNZRRvdfZZ642CIoPm5s9oOFyGbhW?=
 =?us-ascii?Q?qVeabvrfXuQKiDaVLNN74u3soR2uQejKfyFiiafqlfbkh5fzaj3cHvM9UxpZ?=
 =?us-ascii?Q?76TF1CPyfWmy8y7lesbhrRqEnek/RQWphxr8G96YLkLqa0zaHwJL9Tv54bPV?=
 =?us-ascii?Q?NHLd5A880N1L0XvIkaridNCASk744oOH5qKT4KVMLmW9HBNwc7kIC2CEW9YT?=
 =?us-ascii?Q?oVugrZtOkD8unn/s/GhtHlbPkLISGpTUfqH9Z9tWxab+NSemVbRLtQXmKjgO?=
 =?us-ascii?Q?vz4geRE+n4U/YwWNCfQYe9MqSqw3gRva7JkoTAgGNea2KEypnpEjGGYhuOmJ?=
 =?us-ascii?Q?TbIAcjb9OxhkFH0AWcXhySXd6slytkzOZhmxDaxQrb4ihYfi9E9zrdSKdBHK?=
 =?us-ascii?Q?hYPI65my0CIXZIRAgeSPCYkJLPrOQiRnePrLQvnUc1TEPgH7p2aKCpew3ckz?=
 =?us-ascii?Q?HsecjGt/qFrr7iQGleWd7oK1YQmuHR7nwvtWaGfE75kBL34w8bYmIS1FGhLe?=
 =?us-ascii?Q?6YenTfXBKMbPjtyHMmw8kUMejjtu07sc2/5ME4lU46KUlNqmb0PSWZ1WzNYD?=
 =?us-ascii?Q?QwSOtpxy1baDYJM+8LPUxmSjSZFdDEGjyL4CBuGJnbETddEHWxQP+Wb42B2x?=
 =?us-ascii?Q?3ZtlEnlCqAzXPk/N1/wEIEBTywCKAVs+eGsHCnCB28QvKBK7LQe8xu/7bA9Y?=
 =?us-ascii?Q?TDuTtgzHNnei0Hp24pIyhqNsiQqEoWv/obMJBHRQ02hujLjhm/ZrNvcqNNVh?=
 =?us-ascii?Q?Df3EMh01WIUiqU75emd72OOD2bh9sGonP3hyvoF9EMDdU8oIUQs6gfOncKpw?=
 =?us-ascii?Q?52R+cpW8AS2aZxTb5aWQdihO0/elGuASc6hux1s8G173swjWONwq/2xVL+nv?=
 =?us-ascii?Q?D9sbp2wIFhXfRcczAFW/FvUIHoDZKftR8P5DGn4aUhSQXKBVDbwM1G1a8o6/?=
 =?us-ascii?Q?awLBcawRn5xpGPWipbKKby8x5QT2igXUWao3u8VKGxAJtIdoZzxuNMJnXnsf?=
 =?us-ascii?Q?muOjhcb2Od2dYvLG0yGhTp+8lnXjY4sLtvDuRsDoC+rEQvENxL09Xqhrp0Ai?=
 =?us-ascii?Q?d5Pw+BcsFGB0MsdcHShLeUgkMoVX//ueT6Bt1A3U/UIa1JCY2MgiSMaYO4Ke?=
 =?us-ascii?Q?8TxofimVDSctKzrA8qJ4hNGf2YIKy1B0K4oYoOX2DZNasrjT2FCiXEPzIF5T?=
 =?us-ascii?Q?plFidO26i39aILINKeAomrlfULpw9iEDccfdKi+ZovhvVmSjOoRzOlsw1HvL?=
 =?us-ascii?Q?QcAg+F3ZhW1flI9gKuGcLK8Giehou5rmT4jFnjovOpCFARZ4uJlJWHg7IT+7?=
 =?us-ascii?Q?PiRLDr423KjGELzaqyo8syqWP0ZURPNyxBWd1L6wVuAUO+iwg9Et6g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IXs4NKNEL0rGCnpTgyYItjGSsNzsgAja3dKE36Ayw1RHNvci5zUbEtVS3K3H?=
 =?us-ascii?Q?E39dKg+/+Wn5sIeFmTjXVlrM4LVVLfLV356bj6lCABjOw+RKo1Wf8ugrwCtG?=
 =?us-ascii?Q?0SfK90egotlBGJuoEb934PYWNLlv1C4BGZRs2xbzpUHQgVx1/J8Xd9dgx/DA?=
 =?us-ascii?Q?NWhMli+oUdpHqTjOJk2WiQnEPg2vp6XKtx3cJIfGe5GCBGLhsPsi9Wjjnwh5?=
 =?us-ascii?Q?fe9mOtYpyJwd5/w7oiExMQsd+fobexqWg5euKH4LeJ3ZhzM8kEVskrUb4xD8?=
 =?us-ascii?Q?xrGWsy4NVBfSGpBMEyh/JsWhR3Fc/v+ZgpmdliB4LjCYqOigexJtiSeyWKWw?=
 =?us-ascii?Q?rNnc4hQrUezZHpxFFlGZx6w7oIRtv70uVZ26w8NXTKghqlCaol+/AsWa73yP?=
 =?us-ascii?Q?Cs9U8sGvJ3Kdn+gviH8GHHSRFUrp7TPSOxVTg58GWhR+kvk8lDxMNbdcEV61?=
 =?us-ascii?Q?B7BSP6t6VGpf4yfM47O5Z4EQNpLZmhMskKrjemdR/uu4p5yYqHpT7xvWpR9C?=
 =?us-ascii?Q?w+ciaaELpLh/TE+8geYlXTzdyB3RVBT70DIPtcki3hjMtgl6/OKV0JlPOz7W?=
 =?us-ascii?Q?CMjKfIa6ZdSupSMfxKY3hFc0njJW97kFYYkQ1KtS9HA2kAYDuap8B1rbQz1Y?=
 =?us-ascii?Q?y29wT3VsiCwAA7IeisYu989dlA5ssPgnCukh1Br8X6TWPMtj/LOU4j3C8dyV?=
 =?us-ascii?Q?SQqjwJr3OTOuIQFG2m27PgB+jiimm4TXKx3lOG0xDE6DTvdUl1oJu8HA/Mr5?=
 =?us-ascii?Q?H5U2NUPASbKIfUShfjzjdZ0fqiuF9Jibf5K5MfkV6ZhboGYiDnQjI6hpn6C9?=
 =?us-ascii?Q?aX8YOfPdxTR2X+18MthIWTcY1VIry7+1NjDoVuZcBSf2r314qnmNOTIO1GsT?=
 =?us-ascii?Q?o+omugpA0cp2i+HiscCHEuka4gIhJY10HVSOvHp/UpzzihU/HUotYp2mkfoo?=
 =?us-ascii?Q?diEuWkxttpk+GhjYNuRrVnw7nYg+PZzyXCO4XJrPtxNBa1JX1g1dGoY4myOB?=
 =?us-ascii?Q?bAkc19dbKQMM/q4xUc082jFdZrA4TbPYLFl55Z0pNG/vhqsAO04GOfMjdNPF?=
 =?us-ascii?Q?bT9/LMgxELVIUbIhPUIS05agUfPn3V4shfVHsyhMNaSZTHDb8kKMZQbS+zHw?=
 =?us-ascii?Q?RTVuOA1xY7GikIv7gS+muoT8FrxU9Qp1Pt7GD1Po8n0v+fMO/pYD1geEcYJd?=
 =?us-ascii?Q?Vm4Kma4dq3T4gO0eEeFsbMuxDjQLBpUQ/WYE8DLi6yDQS7wHVBnhYcstJPYg?=
 =?us-ascii?Q?nPR4OK1RT0/oe8BqatDkLG1gbb7/htvRo+AmweUaygATZnoghHeeKQ2qIivA?=
 =?us-ascii?Q?STF6w5eexdZIIAHMZAlY1lxAUqjZko88MtROuH7amMNRtodL81lSgAhMTwB/?=
 =?us-ascii?Q?+vw3he9nuFUNCHwN0Sd+W+ONOt+lwjI8hk5hDME+rUPN9/85ZDyleSVz0YLi?=
 =?us-ascii?Q?rGq51AY0YVFHwQEKcaY347hkv0K0ZbcQzTJVZnhZEe/igdGgEb2maQsCmGZI?=
 =?us-ascii?Q?KqYD6+tr4BatVNctDcHqytRK7yfai4hbeiU1gXRHMRUyIiHRTKQbUxw6yUVr?=
 =?us-ascii?Q?FmTBFxaun47kbZuuSholIkmM21gsBYWzG88FMMAtuSCC87Ww2WabjxuHVZQH?=
 =?us-ascii?Q?CIPZRoG/bmf1NTLWYvRDgw8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c785cb9-146c-4d45-8852-08dde6d1f4ef
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 07:59:19.1523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TfsOP17+5x8d2x0u0uOq8ZrtZ1do+H1sPe/PehecTLd3eG9j2ajExxoKcrWn24fJao4qwJf9XSlEWfrii4EvFEO3iuOujze06qiB4QbDKSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6589
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

The patch series fixes speed calculation for nand device case and
updates help to refer benchmark option presence.

Changes v2:
 * update commit message
 * 'Fixes:' tag was added
 * calculate speed a bit more precisely using a 64-bit math

Changes v3:
 * split on 2 patches
 * update help for 'mtd write' command as well
 * format help for 'mtd' command to align device names on the same collumn

Changes v4:
 * attemt to sent incorrect patches (sorry for this)

Changes v5:
 * really rebase on top of master branch

Mikhail Kshevetskiy (2):
  cmd: mtd: fix speed measurement in the speed benchmark
  cmd: mtd: add benchmark option to the help

 cmd/mtd.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

-- 
2.50.1

