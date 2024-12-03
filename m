Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B8FFE77160
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:02:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D1B68967E;
	Wed,  4 Dec 2024 00:01:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="V7sB0b4B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D466896A6; Wed,  4 Dec 2024 00:01:13 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20710.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::710])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C9F08966B
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:01:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cT2BJjkxxHI2capcniLDafF7jsQctLXdNz5Ub5rlcbmZoF/xobl2Yb9T+cUMPOSjvnGN95dVssE1ERRHCAId5NnR6gX2Lo2tnvo3JzSL69uoBfLOZRe2PmfQDyOl+wc7ohXJFvMxKdRnvv8ABadEwWJn02klmLH66Wk+OBM1W5L4nHaWvTR+uYqt3fiKbYFGQaT2VKkz/LlD5r2UIOJfTrG/vvmnz4zhk8zYg3BqBuPKIyCbCIUIngaIIpcekn+mlff9iRXKZNl3W5nZsafjt1ZkjZWu8g3rvTxNZO1FVv33KcKkRHa7y0mw9zj2/+nTiWt/cAmyERBEqQ8lmsIDNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ciUZqWtDh3kLEkUkWJq59/gCgq4WHIBbNome+NpoLLU=;
 b=Izu4aydnPlK1L8+Q+YYj+ZaaFSb8WJOw2lf3m5HvrPWanfvJH+DpUi0AQ28BLJqnoBbTv1gzmy4E/LylIAvTkcJBQa7xHr2Z/S8T+rPDyxJrYrACKaqLqXS/CeyjbrBvbnK+Io3xZ4VW7H5V/WSWnFF5reyEbK5Ohf3Dwnv5jN1iQOir07QWbMFj56F0UIdVMRMK5LWdXJ0d95bp0P0OciOdarTtwbzXFhM4ju4KTDQx+7Whpox2NdbkbTguV5KqODiHrDigxh+HACRRPCMUeRlHuHocXr7MUf8RtqVWp8yBm/lQSO/n68ViUjsNejg6lNLtRjtT3h7OfkFmbBBjSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciUZqWtDh3kLEkUkWJq59/gCgq4WHIBbNome+NpoLLU=;
 b=V7sB0b4BobTWgqGBysU+w3HhNzG/CBo4c7TD2yUpZdBtcRuAmMGZfxUA5790GmZpRVmoQKm3Fy9gfzcTA70wOGSod+6bf8HvUYHlJr4OSD0kbB4vHxBBfawE563kgj0IxOJV+tisSAZNo24CqJiIdpwdl0XAF1OreYGBZU0OuiFV0QdJRU8NuVwqm3/RRg2nWVTG0BKhHkJr6oiZlByRaedmDuMv/oJUwd/OzBvW4zUsVVuXg1I/nCoZ4o6BarvdG7rMyK0cxo6oVCG5YKq+6TWBtcSE1aFDK4HZCK7kqNItYFncw4eA42Ldmums7Dz6GLwjeVw3y/yPg3dPFqHxTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS1PR08MB7611.eurprd08.prod.outlook.com (2603:10a6:20b:476::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 23:01:08 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 23:01:08 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v14 09/10] net/tcp: define a fallback value for rcv_wnd size
Date: Wed,  4 Dec 2024 02:00:48 +0300
Message-ID: <20241203230049.2677155-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203230049.2677155-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241203230049.2677155-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0040.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::9) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS1PR08MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: 954d50c2-78ff-4038-3ecb-08dd13ee5fc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|366016|1800799024|921020|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RdpVwreXlsPE7jQyApoFD4YZV8ULrCSnxR2fW2HnQGHhn29ETZAarAChspnx?=
 =?us-ascii?Q?+lRM2WC+rgyyDCRheDfTBUWtIJfeNsIKmUJSHixwa7JHGOIODeG6/EOhqxu9?=
 =?us-ascii?Q?T3SuQm2qIeFlX2FPVM8sU/wZgOknx5xmm+HVhk0TSFvKQGRfMOIhXBVpQ5uC?=
 =?us-ascii?Q?TUzlaEqli7Tyu8tCWuT6S0RAEx+zt/14Q4mTp154XZugc3+p3SwKWBUXqB3H?=
 =?us-ascii?Q?xckIU2HPT9r7jHs1kigGH0vnTn+i64gP8tDBsWNZwRNh2YwzWXGmVgla21Ka?=
 =?us-ascii?Q?xcpYaKHNhInFnXWitStPjrmGDEt1NL8GHZLFAAP7NAYqL2BDUdK7DbkDG4pm?=
 =?us-ascii?Q?hr76FYv3nXwFPIuI21a1gX7fCFCPmMJzGXRZMkXLCBcyqTa8ElKC00hHk9ho?=
 =?us-ascii?Q?iwFZA1ZzABSvLmruN/uCXkaqISchnhjIEWnDER0THrCi48a2RkvP7akJcjom?=
 =?us-ascii?Q?FaERnhSqOkvcQ8ABkPehncrXLjr1Oim6lbSgJXKqwmHqqo8MRzdekT8afuEG?=
 =?us-ascii?Q?9aX8k4zJP0wWFusHBcwBqZpeoxrSwrdAB38rMPxNwY3m5sBlQZKdzoRl5iDi?=
 =?us-ascii?Q?G3s4XjpPyTUr2QhubF2mxccMqh5UYECf/gjXf00WLosM0iW65kIla5kBT4Mw?=
 =?us-ascii?Q?1jN37TtHgyFYH0DJlGiPjiMGAK/U9KadFN6p053WoHQ+u3iJcNscegCRnYLY?=
 =?us-ascii?Q?w9l/dyH6sqW/cfhxDXt6xDCyuKhGjX2IpuIfV+UxYFttQ3dfa+7gjzN06YbS?=
 =?us-ascii?Q?buFd+xeDLSI5Lmaf+vIxjJQDT0fmSsQaTviDjXV6e6Obq3YD9E+qDV3fEh3l?=
 =?us-ascii?Q?ZwL69NT6rqSBj+K17AlfZ9C6ZP5dyV8Jn+AjEZb5uJmZk3nlF6yYzYzJ70gS?=
 =?us-ascii?Q?iuvQQp8vqJc7cCTtGagFaid9pwlL+/2St+AoDR6ZyzdvfYKxFitgu1jFjdc5?=
 =?us-ascii?Q?OrJ2QNobtl+jto2MYEc3m1CNJjhsfZV1ftu+krNuG/DZEPy9l+X9zEPTsDrP?=
 =?us-ascii?Q?gU/+70/gz6tuVFXrSmQRDSew5LVoawf3BP/+7snuUziKAbO79K0ZYO3zp2Zn?=
 =?us-ascii?Q?E+gZbrAfoEBaMhCogZloEGHJITOKozCTnbbPSkSbFpAXVsoySO2lIFmcY/2D?=
 =?us-ascii?Q?/pNpd/AEenOGd7ZcP8PEny4jI3Gt450IGqPEaWBOtv+ZjHEgaURZPE31e0mM?=
 =?us-ascii?Q?N6FiCfEy0354kfGCShaTS1+xJHTt/0mp8ap7EB9zJwKDq3KgEIhAWpzV4lX1?=
 =?us-ascii?Q?BYridBu9wszgDz7Zw6zq6K/tONwDXIyqA6TwaZm8YJODnIuGh64zmGroAolb?=
 =?us-ascii?Q?1X0htwo3WZN2FqwP7MH+OXIzow5Kg8IQgdy4BU1Go3OvXG/svLFNAFEUVQen?=
 =?us-ascii?Q?um68/1jq8e/ipkkHpCv5rcXjaiQxvyUPKJz1kM/jdgqAGt/+h5ktZKMYMFrN?=
 =?us-ascii?Q?HoOVInzciOk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(921020)(7053199007)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e8lBemjgMYxE/A654lClyUvHbP9TKe26AlzBK/1/SQadiaJy2w7cTA+/o9P2?=
 =?us-ascii?Q?LasH6jxwCOGqCywaXqsXP91MonkD4hlVzb/8ijk761krO2vLpnziBDlCp8Tq?=
 =?us-ascii?Q?iQxCISoQ36n/FU7WVJTNlM1A0o6Ktq7wjiZfX76Hx9YDzi4lrZUrn3HtVnNy?=
 =?us-ascii?Q?VcnKiPijBxC/fdaB6PLomazHYMiexFQNlDfpNIb+gQBajAJnzfKoD+cjKBeE?=
 =?us-ascii?Q?QBOIQ+zwT0aiG2YQyTFfjWj2YwKtRroi99YIBNoBbWmYb/Z0ilTos8l4GbGJ?=
 =?us-ascii?Q?BAfF/DMBdZoa8Bf3nImta4JohWHpiZEq6+yNoOIslI+M0Dmj3+F5hn7rbs16?=
 =?us-ascii?Q?jv/HJz4rM5OiZqPQOdbLSKPktJ2eaQzs+KskY3JuorLUz/LCjCrskIBuZTAG?=
 =?us-ascii?Q?lYErvz3RRtpfY/9xmmNGuTpsRMNeyYz5i5E883nsdLFK//T+B8ORvAkaoSna?=
 =?us-ascii?Q?1B7MHMl/dMcJmbd73tIt4t9De/SISctgoqGhUdfxah4KLByjKOYv/FLZ+rCk?=
 =?us-ascii?Q?s9oauocO5rw0ITza1hDf5ItbMf9rImMk0nlt7aw2SxCLLl58legY2DrNSpRH?=
 =?us-ascii?Q?KtkrLyC1t0bGOGENk5LNfnE6KxpmJ5LBMPKDvlKE8C9ricyEweZfT7bhQ9DY?=
 =?us-ascii?Q?l9J4tH/n82D5qOYKHoNFf42Vth+C3M0HMzKH4LoFhW6dD7h2PdP5utYqiLsw?=
 =?us-ascii?Q?2mV21V8lKSFW1ithDu+gtj05Ns5jaWvSARr2DQnUKubRdUQTuWBQFFLNeGBb?=
 =?us-ascii?Q?E89pce18PEqS7tUBCZNOIQa9tC123MlemAzm7uyFvbEOBgILYHT6BPobb12t?=
 =?us-ascii?Q?mXEts8eZ8gh+JMAKCtBTjE31ZbS5toBSOHBvV1PXoSAw5W4pvixU2LDxLr7E?=
 =?us-ascii?Q?vFltHyy/PNreOOzTvuqHvxQIlx0IvlOMtb7PMTVz2t81u8jBWajIxw1mpl13?=
 =?us-ascii?Q?VlWMNpsFIZ5vq2x8I+uV1UldcbBGl7OKe1iUxYc0YNYmesjdctJT5SJ7NhwU?=
 =?us-ascii?Q?TJCFrnurcEZYjanzA8CJBddBmGy/Z3EbXpwSuvRdNalRlhGoaWgz4vuPOINQ?=
 =?us-ascii?Q?1OOhTnGJdmUCj1KyOIQqSrb4ya+eTiRctYjHWsUQRl6mupfsc781ZhPhgEQE?=
 =?us-ascii?Q?lbL7jLr5V06utRmdw9RR3pT1r55EW76s4FQXhAFPY2JxctrcURoLgsiip7xL?=
 =?us-ascii?Q?64zZeAVLjHxwfDqUDn6L3wtLePit2fSCyUU7KS+1SV0s6bCAHvnloiAkx3NN?=
 =?us-ascii?Q?Pu/xyl0UghxckrLyGNItVL5mxknxeYSTMwgmP4hPAtkizljD6pR9+lD41A3P?=
 =?us-ascii?Q?H6EbbsAB+2WjdKw0Q4pl77r4aFAsYE+ZOyqhgTo23VjQSD3VgStRHHsoUPyr?=
 =?us-ascii?Q?22X9h4OVXOozWSLbd+M7VfuWmuZzldEqLbI0bYg1CJqsBlbvGPwZScg0JuaN?=
 =?us-ascii?Q?qeIlelLsiLcAAAUD35UkJDTSwZmS3cXs6W+v9+qA8a0fzLWAVRNZPDDwW5cV?=
 =?us-ascii?Q?HOmUKIwfBpGI0fBZGPE1agxKJnzFqGx/7yl9qJrydaPnNVHk1qyj8TA//68m?=
 =?us-ascii?Q?/2bcEr2ds/rbKB8Es5Erq1r6i1KzZiGWYDTyX77WEuYZrSFeYwdjPW8k7PDE?=
 =?us-ascii?Q?UeZFLP7pUgA5Hq3VqM7hfrA=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 954d50c2-78ff-4038-3ecb-08dd13ee5fc1
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 23:01:08.7818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3lacGhBh0KEoj52dQ+3KFD4sWCeUHI7/RYcR72O6QPtQnvp5cN/6kj9H1btk28hHBDsXLu92qd2bdE3XBEoVZx3e8oxcm8arwZs06Olqs4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7611
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
index 637537e956e..cc5b8da46ef 100644
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
2.45.2

