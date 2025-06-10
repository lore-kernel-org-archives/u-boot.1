Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A728AC5B552
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 07:30:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33C2A80C83;
	Tue, 10 Jun 2025 09:29:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="bDOzBcyv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E2BA82B07; Tue, 10 Jun 2025 09:29:51 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CDD6805D7
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 09:29:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0JMWTKQBg7wcjuS1ted4jtfrhDJ7znygOm+yFcRvdVvlGHdh/Q5BgQrq4Y13rbhdS1tF88CM+cOXpN6Sr4lrvwQ+01r4L0SuqG3TBh16cbCTq5h/SDiy1IJ7El8AwE3Yiv01cIU5AiowAa5jYvaaz7HY2LFw8K6Ia86el6DyaT1ACfujxMnJX/LC3Bw1zHtw6N5uE65p/THlDoWgbCAsY5yXeRQQs9RK8RFEWeSp6vAIziAIXhvkDM+5k4Y0BGS+K45Y6Bun+rkP023H+FamB9UbZZS6NPGiuUqdNAkAnGu4BWvJrFkdKE6VgHub1NVQI/pMubmhulT7pQdA1Wh/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mY8iS+bTnHt6v8XiFPF4BEaDxuxhFO7valpgWyAHnkQ=;
 b=cA/CHW2PKGtaHIHr2ZTk5rsU4fwYgNphwu5La7PzO/CZp/CMPiRw+zqmaN28hjtb6Wv6eknVU32MQjeR5lLDMpeswS6oFCT/Km39nXT74arkiW8ZqhPDFtrq1KOotFenPnU8jwcWsM+kBudVLUhjCwyg/IGa61vvzwrZAWlUGLQf0txbW+oRnqtvb4P/gql/HOVq2CIDpGQUKLHhYrCwAGDRoOLzf3olpSC8aK60C4OnK+tjizka0hP53sKwKlV0gXYFlcIKRidvACYASh1jR24k0RjmtLDdiHkZP+XR4GM8FkjnUXSYQI7OFYF0FyeLKySlfMipF6gDNqIpICpH6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mY8iS+bTnHt6v8XiFPF4BEaDxuxhFO7valpgWyAHnkQ=;
 b=bDOzBcyv5n0o9r27uv9z/QJJTzO2Rv5TO5U6NR+QOBRBy/XpsRk0soA7o/G0EvxbHrKhvg+eNWNh8CwpZAjTWxqKlcB/ut7whNs6G4nqB4oAHr52+MPuIF0TGPpLm6ZCVK1dj6f+GdNFOJH4eeeNFJLcxJciwaV4KHZZ9bXsXrorsWf6YqNTuzfWlMBjQgVBqnKug8HMPp/qz9HlgX6zc2QsuabPG7FMKMtPmdf6rPXpRTyb4rsDaOgSGqaMKs3TtDeOhFZ5cFMT4JpMrPuKEkadCfFbsxR5TXXDJRdgk3iHBbNoPhXb8Wseyi2hfSAWQ5x7Mi3Sb7hFJaFgBbGXbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB9771.eurprd08.prod.outlook.com (2603:10a6:102:31f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Tue, 10 Jun
 2025 07:29:45 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8769.037; Tue, 10 Jun 2025
 07:29:44 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 3/3] drivers/net/airoha_eth: fix stalling in package
 receiving
Date: Tue, 10 Jun 2025 10:29:24 +0300
Message-ID: <20250610072924.1066329-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250610072924.1066329-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250606201728.462664-1-mikhail.kshevetskiy@iopsys.eu>
 <20250610072924.1066329-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0096.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:275::14) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAVPR08MB9771:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c9e8706-549f-4ad2-2863-08dda7f08c50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UvzGH+uSsS3o5PO/YYoQ5pWK5FZ330u11X41Ls5wwbaRU3zR6I7LDlkhKm89?=
 =?us-ascii?Q?jrRAE8NiosKdnpWJSCdZPQzK4Gvqpr5nfR9l8GCYJMs2Ln1y4CT0TZpHS9HZ?=
 =?us-ascii?Q?Ap7rz1B2iUKr+SogcafCjplRkcujO0y3fY2dEalxEaj8uTt0eDoUfw4UHOGz?=
 =?us-ascii?Q?6xBv5P/AChFLg+h8n9UnY5McIANs7XsOt13ISZk/1c3CrMBx6P4DdVy1R6HN?=
 =?us-ascii?Q?99tHQOu6KTFnFhsb0NmKM5tCOKQ+4gc5jaq9Nf7y0l8zbIKb2q2ePlkTOVXl?=
 =?us-ascii?Q?gA4odVS2nX0Knk6u0vFTQSduO/u6crYK1JxktjazwhtSHsvYuZ+iqu3Ran1S?=
 =?us-ascii?Q?Sf+jsDFR84RA7Vtkqt7/mEDr6D8E38T4GlnsRSIongblkTZ2Pph+qoJFGGgk?=
 =?us-ascii?Q?7h9LSFbQlyrEkwbaqwK3M4wH2+GvMhSmI9/SIO455JjP4MudHd3nDJmf3uP/?=
 =?us-ascii?Q?T86q7fClggsUI1gZxjDjjyC98PqWhzsM3qj6GfCtvq9CgRFfsNlCYeSWYpBD?=
 =?us-ascii?Q?nVTfZCU9Wy00EfB7fOcZ235KbiVjUU8cxJQYp0BVmRPVfPE3v80o26aAwFgv?=
 =?us-ascii?Q?dxwU2ZrYkuFSJYejD145wj4rakYV++xacboAiHgJM0fa/RT4c/qSvc0aOKcx?=
 =?us-ascii?Q?UDB8Or8FMD+ZJvbOMh6hUqwF3tepAPq3Vatj19Ybx99PfUrY7gip9PuX+GZC?=
 =?us-ascii?Q?64Mebn7CyvCV5a7N0dajpAk3jdWNvvUfqNUi2t2i3qSVcxJZvuWlkQwChQ1N?=
 =?us-ascii?Q?fBRekb6F80If4cS6z/fEuOUo3ADtCauD6YhQCTShN8RVk+tBaPxTWTvbKO6B?=
 =?us-ascii?Q?tYkDbKcnocx7wJuidDN8gTrEuFjW4QhqnU27q1eI+CRDrIl9FVRKRYlMpSMd?=
 =?us-ascii?Q?HkJXFB677lys5/lZiP8Qo0+bCybDADgNTDRk+bzgZWwdK8IBCLD0vy7RVa5j?=
 =?us-ascii?Q?Nst0257TssMbdrduYfSpjDmcp5KMjcAjulQNjx1X0z8fBHIPrIn8wwhUMvS/?=
 =?us-ascii?Q?Xrjth9UT5PnPk7NKiXQAZ3OTQhP3QEcKH2Zdj2RiVc/Lgc6pBmZWfKACaS16?=
 =?us-ascii?Q?6ul5ltUcyW+MufMmpGLpDocAPv+G1uvooyEI5cYjbXov95SEbxzgjXtnev+R?=
 =?us-ascii?Q?b6FRiiSWbBsvSNG2fCWf4HVNuyVlXtmfwUbXsfcAvXkbyd22BFJWtuZ0GiUq?=
 =?us-ascii?Q?Jl+viBSr7zUICerZHs8EVmS9TEu5y5gzAu7QoYUfTO2tF8EQREubYsjJwAsD?=
 =?us-ascii?Q?/haV8sb0ZiFLgvZKh8fZE3+sNOakYV+UFFuHvv6AaifNsEYXsYihk+zXIh1g?=
 =?us-ascii?Q?niZkXQHnDbEKmbG4j52FCXH7rSpSajv9ZaGgXEbpC3k12oFAfoel9cYLBaLe?=
 =?us-ascii?Q?hkdAQ3cVyQS5JIrjhUz9hVQjw0KekLOmNrNDwWDfrwUhOdtbr3mJLyueLUkg?=
 =?us-ascii?Q?UZCV9WP/5AGkbnDf2HCl67fqmOeOQiDAV+AnVh00Lo4BX8zo33I49Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yjJ1pqavdc6ZFOjLIVimgGIk+f3lhYSk9gyFlDwQlXA/YX9J7+q/kQdIAHGf?=
 =?us-ascii?Q?eI0oEaaxaIz4u9vGCTJuNxvzSqalIttXQ+NI17BuObelC3ILDXiQLj1exT60?=
 =?us-ascii?Q?ENkbswpI79s0MA85TPlytCOTrlhkiXPnJaazIrySnFdeIicFaEK0e+8TfdLU?=
 =?us-ascii?Q?QmRX8GYmQaXef5dGSefHIqAFWdTeHUIKuRD72oMfwEft1BpLLi96AQLVPRiR?=
 =?us-ascii?Q?3WW3zS+EgiE1/jdnCTeJMmoDfbd+g0UzmCt0PuI33OHEvDbzAk+K2b7GqutR?=
 =?us-ascii?Q?bIJkQD/5pLo5Dfy6YnpkoZHW5MlnUzT7pY+bNedT3KT5AbIbw5/xA5KcOf1v?=
 =?us-ascii?Q?N0cu4ECJgUYcRFuccoez0+0H0/M6DNuN5ff/aWFgyVekImYRGBjhiNBS6lKo?=
 =?us-ascii?Q?9ABEBAdOVrueje1vlj+DZn3aYcGmND67GTVqFYbjVMIFzqWtFuHLIbsbyHqi?=
 =?us-ascii?Q?HxW60Roh/zD0b6Sh1hqXVdqc7QrXsAhIROvNwxAKHKma+DCi3+4DP2JzBGGt?=
 =?us-ascii?Q?lREOs525P5n+f5/Ig+lkWLqIcOk7rgGIj9MscMfGNShV28hM3M+nmnkFFEgz?=
 =?us-ascii?Q?GCa4AaD0n4tfe+bZMp3oSgix34Bwke6LLM5chT/LPYMcthbKMFNe/ivFCI0h?=
 =?us-ascii?Q?Su10hsKSYhVKjAX5vsKDqM95myImdO5CoFZrQPuIIt+v+otXN2/bdqoASuUv?=
 =?us-ascii?Q?qctcRzWVDyuC6TOGCDJfixouA8ZSJ5ZUZNFKz+qHpAXP4yvV8AIFq4zp+2To?=
 =?us-ascii?Q?jo9161CPChjH3OkZzSaULfutFVyafa150vDLg1SZVZ5Z7+SsQRPtKufJ8JmI?=
 =?us-ascii?Q?U4OQqUYk/gjZZhjJe70QdVobg3zFw2JUGGTluLD6iRBu53s+Fr9QRrqeVvoW?=
 =?us-ascii?Q?KL6ykuAjr7eisJXmTjAgFFZ/fhB6Mx4J8DOQln7fYUjlJ9zaudbaXosGokBA?=
 =?us-ascii?Q?QZUW5rizijyaZ1qe5pFbeET6pQZuj3vU+yP2s+0voEmOKx6SYkGeTMZ/WT8/?=
 =?us-ascii?Q?U/l/o/PIgCdm5D3J3A/rbi588z5NUd37pno3NR+X5Lgr2/wcHkXxmf4jwrD4?=
 =?us-ascii?Q?i/SjzDLhUL8OSDqjVsoujIXopGhcAsxbt6AFoAzZWRCxogPz8chV8mKCPOCv?=
 =?us-ascii?Q?4GXoWD9fpbxMCiic/mUVsGV/Do7Y+CyzyetjcpxCO8TTnYEiGuczcYpFcZzL?=
 =?us-ascii?Q?ZDGFrP2bv+KdQXpzDk7rz0Utzs7xQJWccKMlyYpUwBacrV++2QgAFy6ylMen?=
 =?us-ascii?Q?+tyjEgsf8mVBEkTFpU5BirOiLlIzf+rNW/Ow4SMrMphAt4+0kqTc5Q0vLiZH?=
 =?us-ascii?Q?CVy6Rb4D3jIdEofvQOViMK6Khu4dWDDd7K/3i3ECP4lqK/+T0MChRZvwyLHq?=
 =?us-ascii?Q?DZ/6Q2Gj23zi6NYUX7vKTXjGaDhWnSBS+yfz9d6qkzwprrjjU48kg0GY9hL8?=
 =?us-ascii?Q?xKOcQwsYZTgJuz7IFac4y+60SzLiBym2Svh1cERqrd5cMuxTCm07ciq7UpKF?=
 =?us-ascii?Q?9Nso1CMGuifnECo9sBPfYlFbMNPzF7lR4ZatfCvRGabZNI59uqCA4EKUP/39?=
 =?us-ascii?Q?bX/fqmCVeZQv6jGtbXrp+ZhkbpVr9oTGREBgEgP27HNCN6wiGjAdEjsmFvDG?=
 =?us-ascii?Q?OV5kZko7k9xKNXYwB5aqzag=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c9e8706-549f-4ad2-2863-08dda7f08c50
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 07:29:34.7764 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLROFW3cMtR0Rv7IgeIrOtVaEURTyPlmyifRRnlzEKRO+6KCLl/AcqSN6vVlWc1lT6aAsyS937aLUgzhDjgKcDMln/K7I/ZOsFeon4aXwBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9771
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

ARCH_DMA_MINALIGN is 64 for ARMv7a/ARMv8a architectures, but RX/TX
descriptors are 32 bytes long. So they may not be aligned on an
ARCH_DMA_MINALIGN boundary. In case of RX path, this may cause the
following problem

1) Assume that a packet has arrived and the EVEN rx descriptor has been
   updated with the incoming data. The driver will invalidate and check
   the corresponding rx descriptor.

2) Now suppose the next descriptor (ODD) has not yet completed.

   Please note that all even descriptors starts on 64-byte boundary,
   and the odd ones are NOT aligned on 64-byte boundary.

   Inspecting even descriptor, we will read the entire CPU cache line
   (64 bytes). So we read and sore in CPU cache also the next (odd)
   descriptor.

3) Now suppose the next packet (for the odd rx descriptor) arrived
   while the first packet was being processed. So we have new data
   in memory but old data in cache.

4) After packet processing (in arht_eth_free_pkt() function) we will
   cleanup the descriptor and put it back to rx queue.

   This will call flush_dcache_range() function for the even descriptor,
   so the odd one will be flushed as well (it is in the same cache line).
   So the old data will be written to the next rx descriptor.

5) We get a freeze. The next descriptor is empty (so the driver is
   waiting for packets), but the hardware will continue to receive
   packets on other available descriptors. This will continue until
   the last available rx descriptor is full. Then the hardware will
   also freeze.

The problem will be solved if the previous descriptor will be put back
to the queue instead of the current one.

If the current descriptor is even (starts on a 64-byte boundary),
then putting the previous descriptor to the rx queue will affect
the previous cache line. To be 100% ok, we must make sure that the
previous and the one before the previous descriptor cannot be used
for receiving at this moment.

If the current descriptor is odd, then the previous descriptor is on
the same cache line. Both (current and previous) descriptors are not
currently in use, so issue will not arrise.

WARNING: The following restrictions on PKTBUFSRX must be held:
  * PKTBUFSRX is even,
  * PKTBUFSRX >= 4.

The bug appears on 32-bit airoha platform, but should be present on
64-bit as well.

The code was tested both on 32-bit and 64-bit airoha boards.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha_eth.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index e18816b2943..477a132fb1f 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -392,13 +392,14 @@ static int airoha_fe_init(struct airoha_eth *eth)
 	return 0;
 }
 
-static void airoha_qdma_reset_rx_desc(struct airoha_queue *q, int index,
-				      uchar *rx_packet)
+static void airoha_qdma_reset_rx_desc(struct airoha_queue *q, int index)
 {
 	struct airoha_qdma_desc *desc;
+	uchar *rx_packet;
 	u32 val;
 
 	desc = &q->desc[index];
+	rx_packet = net_rx_packets[index];
 	index = (index + 1) % q->ndesc;
 
 	dma_map_single(rx_packet, PKTSIZE_ALIGN, DMA_TO_DEVICE);
@@ -420,7 +421,7 @@ static void airoha_qdma_init_rx_desc(struct airoha_queue *q)
 	int i;
 
 	for (i = 0; i < q->ndesc; i++)
-		airoha_qdma_reset_rx_desc(q, i, net_rx_packets[i]);
+		airoha_qdma_reset_rx_desc(q, i);
 }
 
 static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
@@ -444,10 +445,14 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 			RX_RING_SIZE_MASK,
 			FIELD_PREP(RX_RING_SIZE_MASK, ndesc));
 
+	/*
+	 * See arht_eth_free_pkt() for the reasons used to fill
+	 * REG_RX_CPU_IDX(qid) register.
+	 */
 	airoha_qdma_rmw(qdma, REG_RX_RING_SIZE(qid), RX_RING_THR_MASK,
 			FIELD_PREP(RX_RING_THR_MASK, 0));
 	airoha_qdma_rmw(qdma, REG_RX_CPU_IDX(qid), RX_RING_CPU_IDX_MASK,
-			FIELD_PREP(RX_RING_CPU_IDX_MASK, q->ndesc - 1));
+			FIELD_PREP(RX_RING_CPU_IDX_MASK, q->ndesc - 3));
 	airoha_qdma_rmw(qdma, REG_RX_DMA_IDX(qid), RX_RING_DMA_IDX_MASK,
 			FIELD_PREP(RX_RING_DMA_IDX_MASK, q->head));
 
@@ -906,6 +911,7 @@ static int arht_eth_free_pkt(struct udevice *dev, uchar *packet, int length)
 	struct airoha_qdma *qdma = &eth->qdma[0];
 	struct airoha_queue *q;
 	int qid;
+	u16 prev, pprev;
 
 	if (!packet)
 		return 0;
@@ -913,13 +919,24 @@ static int arht_eth_free_pkt(struct udevice *dev, uchar *packet, int length)
 	qid = 0;
 	q = &qdma->q_rx[qid];
 
-	dma_map_single(packet, length, DMA_TO_DEVICE);
-
-	airoha_qdma_reset_rx_desc(q, q->head, packet);
+	/*
+	 * Due to cpu cache issue the airoha_qdma_reset_rx_desc() function
+	 * will always touch 2 descriptors:
+	 *   - if current descriptor is even, then the previous and the one
+	 *     before previous descriptors will be touched (previous cacheline)
+	 *   - if current descriptor is odd, then only current and previous
+	 *     descriptors will be touched (current cacheline)
+	 *
+	 * Thus, to prevent possible destroying of rx queue, only (q->ndesc - 2)
+	 * descriptors might be used for packet receiving.
+	 */
+	prev  = (q->head + q->ndesc - 1) % q->ndesc;
+	pprev = (q->head + q->ndesc - 2) % q->ndesc;
+	q->head = (q->head + 1) % q->ndesc;
 
+	airoha_qdma_reset_rx_desc(q, prev);
 	airoha_qdma_rmw(qdma, REG_RX_CPU_IDX(qid), RX_RING_CPU_IDX_MASK,
-			FIELD_PREP(RX_RING_CPU_IDX_MASK, q->head));
-	q->head = (q->head + 1) % q->ndesc;
+			FIELD_PREP(RX_RING_CPU_IDX_MASK, pprev));
 
 	return 0;
 }
-- 
2.47.2

