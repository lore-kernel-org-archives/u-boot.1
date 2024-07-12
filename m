Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33EEC3DA45
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 05:25:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1134788725;
	Fri, 12 Jul 2024 07:25:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="suuXXhvt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0234F88725; Fri, 12 Jul 2024 07:25:25 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEF6B886E7
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 07:25:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCDjERALciX/fvCZnFZbz7ZkJ8FHmR6081ByfZbcjVzpgWyCaGK/byERQhVyNh6vRseCSpy0f45C7aRLwqtCBNy1/OHoxWqPb8sZ6ndallOK9JQBo1CJosgQ0NmYhcTvnxw9cGeb4KQki4uLyKDjZAR6oBfyQncArzl9aJ8RtSIxVaGh+iCZgVl0EiKxeq++64QPYwCYYzEVB8aOoSinBAUzuqoSu0sWUulXl8xQYFsIIv+Ab3Ovs9zFBs9wKAU3U8sO/Zm0/Irdtj1kfgBUjE4l/mdb+sGLacocMnJDmUBT8UfFjmf+iR+zU31/OHC6vl8ykix8c7XHw8/Qoyqnag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Idq02EtFKWuQem6FpsbNznqobVu6V2IFFVX30DXQqkk=;
 b=OSYW/iS/oViISttOOmP5WDpOrLV4Xq3kO6tcIL8Dqc89+EsEuxACxr5Fzs1oT9zoMpPytfWNE4C0IqjVLOaFzCtiJ5iQvc/ZL8abbOKPnIZyslCeLlqRFMzwnPNsqPS9CneJBOPxzmMb5HgmPxdozAdEBToo8tqiXKeJ34DPpPO7CCv8XVm4IRjwt1SEhswjspiZCq0dsu2STVj3s4hc5ABJ6jA7a3u3zUX8EQ9Fegf2+Hh7VxhyjYL4Eg+lITNg4sLhN90f1xiXinJt7ObkLvVyoyv87FacZflKXW1r+pgU4UW0ESF78oGm/QJVbX6VSblpXxrbkmWXFOQnbhK/BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Idq02EtFKWuQem6FpsbNznqobVu6V2IFFVX30DXQqkk=;
 b=suuXXhvtrSceG4ioi1WcXPnkfT+GAlObGJg0tNuhkxMgyPJMylm961x5R4q4VtSF7kxN7iBx3ioxzY75EiugOo8f8bOP654Z5H4oAlnm6q8d2n4khkz6OV4AcAJq6ia8blHrWShgqPpwS3qqh3qkOU9l5lDqKVEoref1JEhxDavT1kifalQdttwq5W5Mf0CBUr6sOF9nNo47y037U70P4i1vqccsU31WFs40p/QBWV3SwJ7UUHu25TtVq05ujIXf9SAg/W5nR+O3cByHQur6QoXMDC2E+zsVh9zHEPkCwf/0iac5ZwPpsFUZc/7jHgEJY0OQgHEVTqlsOcCcrX12cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB5796.eurprd08.prod.outlook.com (2603:10a6:20b:1d1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Fri, 12 Jul
 2024 05:25:21 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 05:25:20 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v5 0/2] led: implement software blinking
Date: Fri, 12 Jul 2024 09:25:05 +0400
Message-Id: <20240712052507.2496669-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0178.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::21) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB5796:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a6eb14d-08bb-4c24-41ad-08dca23305d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g+uyqxmYDjrkslxQfP0C7MjnmuCWjV9qpSP4wm50eNtmmqUYGDwu1Z6I084o?=
 =?us-ascii?Q?IegvbzYsyYNpJHCKXfn91/2GqrDIVrFCGjVuxaL6b7QEmrNJEI1zBM3VateF?=
 =?us-ascii?Q?aXDciFvkc5L8BRwySxgNKyHq7Rg5JbsS2FcqmGGUdfW7sENR36uPh/r3jpsT?=
 =?us-ascii?Q?/MhOjFDI5mpMttjZ1f3FuQlPu8GRKuYBMkj29FoJzGLoEX6LRREC9OsDz4WX?=
 =?us-ascii?Q?OC8KV6KOq0d5Jy0n2yEL+bwc+QUhwJGKz17N0C9/aqFCantQxxOVcBJr0TTC?=
 =?us-ascii?Q?TD3aZYH6YbUehvEdUG+nEsPhETLog+wqWeBfTO57Zk8BWsVsLvBOpM9HP5rP?=
 =?us-ascii?Q?5sT6AyTXvlQQBHTgFtEeqhY56T04dvr5iUMXTNXGivyqL9vsq2uqbq3zdAtK?=
 =?us-ascii?Q?Vx2twApLrqwms31fejFP/7YJwjqL3pP7JfCpN/Mf4/t6QChUShWwSh6vnHXE?=
 =?us-ascii?Q?mHImxatFL6+4coR+eSjehMuJFuxTwYgUE0aNrc9X2g/EzLZnIwFcyqhlL0Fc?=
 =?us-ascii?Q?LyczFl/kS9NEhhcfdBxYLWOeZSVwqFQaTN7bzf141FQNItjehu3eF7Nx4hAN?=
 =?us-ascii?Q?ySpylNWT1IKQR4GKFzFnpdIo0fgerFU68Wo/z/o/jEpCceYz+oajCL8a7L+p?=
 =?us-ascii?Q?1W+qVWkHqgZlioIKnh7TckpT6KKegZBmv3ivJv+Rdd9WJ195zkLTPeID8bVc?=
 =?us-ascii?Q?ORRCLggewI7Ds2fmrPv9eRNuV3osZOQqS0aDVYnsaDQrxomPtpOE1VlgOxaL?=
 =?us-ascii?Q?hK4KyZNyu9xeR55yxz5yZc1Pf7cAAXXQh0Lln8hUMwKX9wPEcQ6Bs53nExz/?=
 =?us-ascii?Q?c5hSfGpOVsOiK4T1vOkuwlTXt287cyxtitlei6sOdxBAT0YaoERuHoAOMW7E?=
 =?us-ascii?Q?HewJl0VbK1wY4Eo/W1UG4mmJd80w9J49uVZJOdR+R207q89tOgZLk3EKK1ih?=
 =?us-ascii?Q?/h7iUdcfC4vlIEnqL9Uri0xi2qUoVs3+8VDeYm00FSwPg3A0iPMUCtucNJwi?=
 =?us-ascii?Q?badCsjXTLJ/dvnnDo7QUwPyoEhxsVVUBePjJY4fyIxPP9pn+guGfjtHOPQNy?=
 =?us-ascii?Q?YCP8a9yhpeTkjdchtGiwkq1y0TQEljGSHS9rvopr+A8DwlWyE1nmurYFKEMh?=
 =?us-ascii?Q?gdfMqW1KVEgJfhwhhYxqF6pqFbBc2t4HwMNKJ35jCrSU9JjvLLtOokuA2tFO?=
 =?us-ascii?Q?GdfoJOqRRs0NS5vdphm5JCZNFH8ujmqKahbBxear3YBvcr6lxH37mHHopF8G?=
 =?us-ascii?Q?mDXxZi7+nZ7TaFEswa+8PVw+lyRAHRkUY+nKcfLo4+kp2Es1SsxUiRMFJOSb?=
 =?us-ascii?Q?QbHhEqO5RFvMD+ySIZnMnSLqd6HxNQzva0kJgXXbfCeg8mbbV2IX3Jy0P/kb?=
 =?us-ascii?Q?phlnySVDPHDjF4sOAUqEfy93npAslQC7Q0I1+bmyJU2/xCAI/g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KR81hWpi8HxPJa0jRXUy0G4UZE56Y2sf9GZApTaBRmc5ZsHiPZmF3YwIc3I2?=
 =?us-ascii?Q?zYWiVRWq8el41GR2hlcEdNyRYs6FtVfiUdrb+VyFlCpR2tFRIq6eWtciTkdh?=
 =?us-ascii?Q?YlqLvrj/r2NaEXA2U6SRrDcZNqnw6PkNpYy+vAafHY5EONwhlHZ9j/ojNSpb?=
 =?us-ascii?Q?pTHqmIm1BuiYKDvotgqYhObb4sDCfqoy1rRCetUvHSrn59zkC8j4ExeWIutY?=
 =?us-ascii?Q?pT/ZNanLX8zuuSw25HHUWLeTcaRfKAB4t1M3iiKYTtcn77093wCmof24fDgD?=
 =?us-ascii?Q?AsQnwNXl14qXtHs4Bc/iT1fKjhSzQxfDWiRTnXIzVz5pEUn7oruAiA0JLw/R?=
 =?us-ascii?Q?YroyrxGbdYnuO+eLz9Zd2SLqdtQnkYxBNEMp1eFC4eqdBzo6JdU1t1gu5qWb?=
 =?us-ascii?Q?ni7Hl6mQOy08XP8Rx8kUQzy3tDuUKJBW91eB8bBYWSLEC9yAQv8nH7lCBkvw?=
 =?us-ascii?Q?fReSFkfzzGd1+MrQo6xf8CeY8TKQlReNAUeON7Z0trMvbH4zFOZ1dHXrNvY5?=
 =?us-ascii?Q?gcvlkAt2aDvGVlzqBqRMOb4mZicQEEhoaUs9AwkDU7syoMYRaqJp5bN1sbTv?=
 =?us-ascii?Q?akk5vm5vv0aT0g5tGiPKauwJbFae7Kc9yNkgxrMD37jb6rJyZb0TxqHokJOi?=
 =?us-ascii?Q?ZnZiqHJ6nip3WFIrhfvsXRKVgF2VFbJeBPJHLHVPaAsSA0cLwnFes0MbIytX?=
 =?us-ascii?Q?piReuJIap8U5DkoQmFjhqn4JkaQAe0pEtGyz7K1WXE1Y3+uyqI/2/EgzJBNO?=
 =?us-ascii?Q?um/cezqv+090RXIs2/g3WDIulyDfUr5TFvcMfHRlEiqotv9xyJPvdkDXUV9A?=
 =?us-ascii?Q?aI71+eFHFSn2vPOL6q2qw0zf1cvvJeCR+68q2qENA1TOdzGQDIZ3forrMRJH?=
 =?us-ascii?Q?ehDwDdneY7w7TuUA2kz5+couq7I/KcIMDjpGH5+f8EbtvZeyMlCStcW4308a?=
 =?us-ascii?Q?zk1xTfKLwsygasNLpjxhQs6S3xGopiH2ktygBX0s492byIqluFMp+4ooI45k?=
 =?us-ascii?Q?j04RTOiZSGh74PDWLQ3n0Gs4vt3Ukw6WdWFcjCBcad5S61EZOCFvY6mLJIv5?=
 =?us-ascii?Q?L9s6pu+lIqIrk9RlV9HQDzgZx0gYWIpshIStp6fkzQ419KlsFx1Y/DuSrRUa?=
 =?us-ascii?Q?08CKeKX4HQDZDGV2C1QdNRHwXLHMA7iKIxVWxB7pBeZzVflcVFn8arTr1dSc?=
 =?us-ascii?Q?HAU12VAsoNZQeRtqWYWO5KPvi1+ljBul9zjRkIZG4BhzrCypLJ8yP4JVl4Qk?=
 =?us-ascii?Q?X1sOsaAwkokSTysYcCYrMVJP9LLwlyjfZTEzWJi0gT9oNZ2zNHyOKxFdVCet?=
 =?us-ascii?Q?ay3pAJ3NwezMQDbqn7LKTYPJlVu5xlbH0YxidFE8Y9VDkDuEuJIsaY/P9cIy?=
 =?us-ascii?Q?vyX5DZtkOibaWsIqjh9syOco2eAseA2NZJmR4LdEaYjqktrO+WIlbDlM4bBY?=
 =?us-ascii?Q?z1hZP37V+P4WSUDmL53sG59Zmd+t9ATleZAna9edFl3zGyGNBT/yMTcSyodl?=
 =?us-ascii?Q?rK/tUEL9/GHEkeEjsXyHEloW22zKB45q2bUzLCpsiE6/HPp5+mOVbhuZRLgq?=
 =?us-ascii?Q?eoDsoOqkBOzL+FZ6kldyO0Vf6CLFbXhqCqgoKZHtXC78Jpime0SjpBPgNQJB?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a6eb14d-08bb-4c24-41ad-08dca23305d0
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 05:25:20.7281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FqXe6ibtuLruYim7r8myyazBWTDMvmPIxKRy65dcYYnp7x9hQ0trLk19zUNJRfKhxKGay3qoZuKVrCl5tHRIHsVYRKEgvXZPJFpug4b6zt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5796
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

v2 changes:
 * Drop sw_blink_state structure, move its necessary fields to
   led_uc_plat structure.
 * Add cyclic_info pointer to led_uc_plat structure. This
   simplify code a lot.
 * Remove cyclic function search logic. Not needed anymore.
 * Fix blinking period. It was twice large.
 * Other cleanups.

v3 changes:
 * Adapt code to recent cyclic function changes
 * Move software blinking functions to separate file
 * Other small changes

v4 changes:
 * refactoring of led_set_period() function

v5 changes
 * fix compilation if CONFIG_LED_BLINK is not defined

Michael Polyntsov (2):
  led: Implement software led blinking
  led: Add dts property to specify blinking of the led

 drivers/led/Kconfig        |  14 +++++
 drivers/led/Makefile       |   1 +
 drivers/led/led-uclass.c   |  52 +++++++++++++++---
 drivers/led/led_sw_blink.c | 106 +++++++++++++++++++++++++++++++++++++
 include/led.h              |  17 ++++++
 5 files changed, 183 insertions(+), 7 deletions(-)
 create mode 100644 drivers/led/led_sw_blink.c

-- 
2.39.2

