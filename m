Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30581C52D6F
	for <u-boot@archiver.kernel.org>; Sat, 24 Aug 2024 09:28:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C263288B9E;
	Sat, 24 Aug 2024 11:27:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="jv6QVX2w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F0F988C53; Sat, 24 Aug 2024 11:27:40 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21EBC88C91
 for <u-boot@lists.denx.de>; Sat, 24 Aug 2024 11:27:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ArnRV4FX4yl2gSQN/smjHyxSNNUp91yidICLGhwKt63fV1TBbQk4ZD9W8p9J1XsuKx0pUMhPVH5Qx6Mw1+sKbp1hH5VhnmYIAsiuVIIkJBSk3Qc8RrfjKzK/81vIVIg3YsNJ3OAX4sSwIn5RU081tzNFkEimVc4+ejBIR362DFoRvOEE5zrFc+VEt7vGDh5GG6Fhq2vnR1hljjEFNrNE5n+m4+iQspHVrwdnLWQKTREmGYteW8n/0MSFYURb78MoydEb6i3ryObqNLinLW1lWm2JWO9+5/QJWIxaw58Ih4QZZQYPTBzqQQUCPg6rM1mTHAl+bMxgie1q/cG/spaPqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWte4Npgwwl3uVnFvLSqrXyVvO8rK8YKgvcN3Pka8HI=;
 b=q7Jezoi3oWHN0sS3BLmerpINeOPzR4eqjuewba1wT1ygRsmPLiuX+P2CGfQWfEceZjtTZq8Vr2+mV1Mvu1lJAUkcl9Y012f8F8rpS3n9owqo5oFsttrNXwqfa/3U40gHOIQdDxNaGyxBI8A4h5kmNogrTomwVahoRdkX9C6PNN3LZvIc3cpTGSC/kujxrkwUOZMDnXCZ081EsgyVmI+INZCkekU2CUGuAMzfFtK5rD1jfE9QNx5UmPI7JI7iGABIkZuTS7yB9Lj94vLhIUqo/w0LJ4buU3yq/q7XoUMpP5Xrp+PsvfheoqNzkw8FpU3nRnPE9ogFAxExfCYQRJOyiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWte4Npgwwl3uVnFvLSqrXyVvO8rK8YKgvcN3Pka8HI=;
 b=jv6QVX2wF88we2+gr5QI/IG2woPCNp0Gubxez1OS4+2RJDtMium+wQ+FxUhbWscaQ5ntjErHBx0zNizqifiNb/BNaf7e6T8DbKPSf8aGzVCbrETIm2RTHmgdgRe09LZYtCfik0bcWavDIDSwj5foZVJ4+uSRG9JRYk6xIOohV49UHCYEFVM3tSqRyALSSdZPYnDGS9UVGkbEqQgQuDgkCH2YJP5W4TjFGDpvMhiZcYTePP1XiXZGM0nPbgKmvesPvXoQEnl0tch/IYmgFry/ftuiUtUGg5fCFWOX+c01mWy/5APICaj1M5kD1IT4WwWhzP1XpBT3VMdytUe1mOjUQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS4PR08MB7601.eurprd08.prod.outlook.com (2603:10a6:20b:4ff::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Sat, 24 Aug
 2024 09:27:36 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7918.011; Sat, 24 Aug 2024
 09:27:36 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v5 08/11] net/tcp: define a fallback value for rcv_wnd size
Date: Sat, 24 Aug 2024 12:27:13 +0300
Message-ID: <20240824092716.1042696-9-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240824092716.1042696-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240824092716.1042696-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0011.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:b::7)
 To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS4PR08MB7601:EE_
X-MS-Office365-Filtering-Correlation-Id: 845884bd-8ce4-4d74-d824-08dcc41efd6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|52116014|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aGz5/Mrh07GNzQjKwwqGJ1WfVG1tB672tpIc+caRlALH/bJF20jbxOrJNcb+?=
 =?us-ascii?Q?Yv/wtFMrTtrlgqo1ZGeixkulr707ymtOch9s2IIeOKGbkQ60IY7d9ZvPKKuS?=
 =?us-ascii?Q?RrEliBkMlq/EsCDCTLD5uq+phpRg3Qhw4sLGfEqOXD1smQjiv3KZim9btyY3?=
 =?us-ascii?Q?0FRU49reqfne+MO+IAwTWvFupCJmLBCa9Cy1qrZzRjGB8kxK69KaLTDFGzyr?=
 =?us-ascii?Q?G5DXmWfKIPDzZYo7ueP7UOweViiT7lX3q2LtpDmgVLSzMTcjVP0hKpm0+aiO?=
 =?us-ascii?Q?srWOSWsCuoo57pK2KSEtfXmIhDC+x5JV7D+vV9ILtCHZkbu+ewPi0ZK0glv4?=
 =?us-ascii?Q?2gUQgg/N1IUIKG/Z7q+3a+oY/yYSi2PtV16iRtmBMXXuKnejG5KwpxKMN+gG?=
 =?us-ascii?Q?cqLNS0QHjGRItM0hiJlIO+ForIkbNMzwUeBfKUOrknMCi2oNh0aIIMOxyaiA?=
 =?us-ascii?Q?/7CQlc/TSKMFE5l7yCkhFron2tj0sX7FyuJ7tJbRHhYsXj9MyTUEOkOgmIis?=
 =?us-ascii?Q?agEYxomseu665OJf3+VTSa/7ldTzDxD9ktmbwmyeIFM8VksV7OtHlDV6yIOV?=
 =?us-ascii?Q?eZ+6kdbXkyt6CEJRKx4eU/5PqSvklWTTBCOfPAXpvUHaYFUC7dWzF31ijjL8?=
 =?us-ascii?Q?/dRSg+hQsY5GYVVTsg9YrH6Mgsry0gkfdfveywi2WLBIg9feI/h+Vcv2NXMl?=
 =?us-ascii?Q?u+00HFq2Cy7C4O3rBoweswtb7ZOJCHBImDOOVJR8nPefA8B9jC9VnYNmg08h?=
 =?us-ascii?Q?bqZeMLXe+n78Tnj/aXRsc+aLtMK4uk0s/s6UxxcVPbsE5Rw+eAT3cZ6ews1S?=
 =?us-ascii?Q?G70iKfQfEJlpDp3FpSJpGFbllMxdiqVtwLjLaIHvJQNC1bKbc+VEpsMYxpv0?=
 =?us-ascii?Q?3Hdq8yEFc9ZwnwWA0y9RRpn5yhfBPHOL7FLeAWQskgZBrDf1bhZ0M5NaSns3?=
 =?us-ascii?Q?FleHmGbtUaH1+Ydd7wfY5QzXv0J9CbbnyDG80K9+ZROdpMoEZsPA3w1ZDfMN?=
 =?us-ascii?Q?HGz87SG+4nPQ5hXsQ5FbAYJjhrKX5vyO3b1eU1brpY/aOLcKO22FjjR1PdJI?=
 =?us-ascii?Q?qbDzZ2wmucf3dlvh0RvkXnn/soiIZb6YlhIf15ttBWhIUhLaAcfUNLCApd0x?=
 =?us-ascii?Q?X8PluJ4BnICAA9ALRUVxZ9oXtqgUbACxvNMupjLNcMAqnVtwkGb8LaN9sBat?=
 =?us-ascii?Q?mrYCRVP7iSOotbOl6vOK1P/BoI/hncvGkAYkcvrrBYBXJhmOqiZI8jtSTQEW?=
 =?us-ascii?Q?Tf/b7JpJbJmoPXkVEdASYzFLa+QSDOhSzOj+oSRAruGviTbpGv0tcNy1kGNP?=
 =?us-ascii?Q?iexKDJJNDmHQzQ0hpwmpub7c+557qm0+nXuNo0YvUjg+JPf1ARyxj9VXJRZT?=
 =?us-ascii?Q?K1VaUILyZHvnjqhi6p4CGABYdqrhy4yXsg87yjgs1wn5l3B4Kb/1IVaRL/dt?=
 =?us-ascii?Q?Kr9J4cEjUzg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(52116014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?52s7x5X/6KHNd2/Y77kc4HwsYU7O1CMm7MD3nEpsiPgRkn6jiSnSPsqyaezl?=
 =?us-ascii?Q?ZAtCbtyzhT7V6MfOuLjmcfzt3PS3Gwx6ulwam83feOjbYrv5QpXBCMxtO83C?=
 =?us-ascii?Q?59HkCvhPqLHhsUnQXFEtp1ZdDZM5JivTSdPqQ7+V5vj2BXkGdCu3Ombw5Q8+?=
 =?us-ascii?Q?AW6gttUQ+gPJW0waDdM8rPTPaHzOKuu91i4VdxXrM+yqX82DQmLYSjuvtL+R?=
 =?us-ascii?Q?lQi5g6CO8vz/bqhkjLj8WUZyP290ErOp658nZFmjoLNKlhO1JjTkFXGP6Euj?=
 =?us-ascii?Q?swapF7dB0QduzrI8bLxrU8GFW5FU2vnbBHeCOfAxAXzzKHY8TJPQohq+ygrv?=
 =?us-ascii?Q?fYclSIBCZ3Uv/bFpMy03VmuRwgfrZNoIFjI/w0az2+Szt30lck8Mai6XG3QD?=
 =?us-ascii?Q?lAgi4MfesE+T4v175nmnh7XM8jSMV2dx+EvosDgHM+XjC/WfPqRUwWjeTFhE?=
 =?us-ascii?Q?I0mctQzm1l4OTieI+c7VGVLD3tGSdzWffszp53G04L7V6S/b+vuPKInUcT8w?=
 =?us-ascii?Q?472EUlT51YP/pbsA3Owi9G2rSUJvtJZNRAhTLlAVVFy3/Ez1PIPFgIB2hNaV?=
 =?us-ascii?Q?l3WfLkokPugZs0R6RdhsjM8MB6tgh9g7YngxVkBtbVo3Ud7qTpiuRsGA5plZ?=
 =?us-ascii?Q?wTrH4z3xqfSqF6bDj5y0tIe/1mrwKcLC6tU6XpoY38/DdvgDZf7o9HDbD9ef?=
 =?us-ascii?Q?B0V8EcJAsqKofUfJBbXwKmkAS0A7xsDLOL9IXf1XKI0xWOrQ+YBWMdd9Ze9J?=
 =?us-ascii?Q?WRezl2LJhEdNubJbmMjxVj1oqq5r3+ASDVIzh2L4bf3HWEGMrdUon3O3+2Br?=
 =?us-ascii?Q?7bJZFEsrgvuqYzsPYcRrUZQBf8FaJoRusXkGtmMqXY2z/GDV4Uj09Aw7lTME?=
 =?us-ascii?Q?yNX0nmYMUu5w/CVLpxJT7ytlw6rPGUsyEgzCoq9R2DqAYSYoUZmoUsUoa67F?=
 =?us-ascii?Q?ADGJEBGfHK/TdTwkJlAnE0D4eIz2TW8ElL++dJTA2/yyg1WpT2cTzHijxwnW?=
 =?us-ascii?Q?QmFrdpkMatKxCW2Vuj2XvPFZajJ9GirpWWx6R5a7rc5nzp9jNlxnSFZlRdRO?=
 =?us-ascii?Q?Apowhbbzue5AhkKTe/coKddxN4tXbOUIKqbeu+wbigQD/b929A5WeeuGfPqv?=
 =?us-ascii?Q?IDLsFR7kNh8uOpc1SdsRHsp6Ggkkm5X6MNJapc3CEKimdGgN259L2oxSmStN?=
 =?us-ascii?Q?HPahSJrUJjomksQ2O+Z9Y9i9ak/iPITBUcmtMfuIISqzzSxt1dgN9F4P1kUj?=
 =?us-ascii?Q?klFGFs9XgryqE1aCDgJ8Cs2XqBVgRyY9zKHYE4yhBuFykkuNLEp6TC4KZO2x?=
 =?us-ascii?Q?qTY4ETFw1X9o/oIkt/4uG4jvOXZpZ+QHMKAqRrrn+DnUqpVtJ3d0iikkEan2?=
 =?us-ascii?Q?xNCNJ/auK3Hh87oJFluQ7c1ZqaWUCP0/dKMwq3KOm/BnUdCGleD6u46qtHG/?=
 =?us-ascii?Q?whpPryrv6WcvmR0AxWH+oRFqDMMf2+9aE2RApqyIxUUVXz5VlzWN1AEhKvx2?=
 =?us-ascii?Q?u2BncqFYe1vqUAfVWoUdm4dEsFnm2GBRLTlD4PwfgndfKy5WJS06EJmcGdqp?=
 =?us-ascii?Q?oQr84v8dgPWr+GdEJkqRVk0FHkohWHPzPzJwd/yeQOakNvi+lzo2R7Fe0Wa+?=
 =?us-ascii?Q?WcABxtXPjO7l3Mv/keCBZw8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 845884bd-8ce4-4d74-d824-08dcc41efd6a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2024 09:27:36.0620 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LtrcwnfjAo74C0FV3+zmPlF+AmsGJlfIkB6noZ99n6Rveg7EjWuoAk33NNbWVlDLYCjK92SYZGkPDlAmTWSs13I9cYz40Ax/QT+bSNaGxfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7601
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

Some driver implements it's own network packet pool, so PKTBUFSRX is zero.
This results in zero-size TCP receive window, so data transfer doesn't
work. Avoid it by setting a reasonable fallback value.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 net/tcp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/tcp.c b/net/tcp.c
index 0778c153aca..32ee1fe03ce 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -36,7 +36,11 @@
 #define TCP_SEND_RETRY		3
 #define TCP_SEND_TIMEOUT	2000UL
 #define TCP_RX_INACTIVE_TIMEOUT	30000UL
-#define TCP_RCV_WND_SIZE	(PKTBUFSRX * TCP_MSS)
+#if PKTBUFSRX != 0
+  #define TCP_RCV_WND_SIZE	(PKTBUFSRX * TCP_MSS)
+#else
+  #define TCP_RCV_WND_SIZE	(4 * TCP_MSS)
+#endif
 
 #define TCP_PACKET_OK		0
 #define TCP_PACKET_DROP		1
-- 
2.43.0

