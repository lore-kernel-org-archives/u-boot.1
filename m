Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 999A2CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 07:32:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FAF9839E8;
	Wed,  8 Oct 2025 09:32:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="MiW3aDJu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA4F883956; Wed,  8 Oct 2025 09:32:03 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ECC383981
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 09:32:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xe388rKQnyyk+ekGA6kRS7vNL85zbxuj44VDg7gR01kM8wA6JfO+Fwslu7cNSOCnhpL7HwDOAXyZPoU0qZApI17DFTZ6V0VIjH5PdvlcTL2fIThEp99/fxj8d/aOtApSEcxKtEuns+zHhv05woluUhxe1cNkA+2X2TNO3QoOYSX1SuJR8hXEyJrOj8yDumchNnCtGoTrAfTyddnvdfbMy/T8cwVNrbk80x+vAeu26mXAIDjNq9O1PvYiT5ABFRP5KoySsDo/Zmi3ryNoFoT6k+AQiFW4NIgcm2lL6oLqKGxQVDAAYpgM5Lb3e8zQus1NyDCeys0Abur5asM5yaBk1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKthlr+1eUHrEiMB39VuKH/tZLvqA7VpD1y4ipWK6KQ=;
 b=BLRLFWU7ACxKb2/M0wT7R5jydWT7lF6odcoM4b1iIecZSLUaja/LJLV7JSV6xDTiyjUb9rDWC+RVCtQkZofj6iceokVHZsPd+UzPzNtgUDsNp+rFclETKfueJWUjzETIrD+xkT5aNXkfGY687zP0NDLfljHStkdZ3+kHnSXjq+b7up5nDK2ZyDKTmkXj0jBGeqJsU1MH+PXcI8yaHc8rxJVd7yTV4WUbH8YTEd1aFD+QJ0l+PDleTgfIwAXyLWI4KC8X858x+GTU/Zx2M2UWdtRVw8f7CZL9VZi+Ba5YoiReicyTDNAjLwujTyDoojHwZO5zUZOnoCE1KOOHlOl+7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKthlr+1eUHrEiMB39VuKH/tZLvqA7VpD1y4ipWK6KQ=;
 b=MiW3aDJuoP36z4w5Dvebf1luke4hiukfAdKzAL8Xgbw2JVPPO6Fwi084yWabEryX3mbWy31KMa6z5s7rMoCVTQJoTgHA/OF/nsc+t7Ld5PEazDmlsQuM/dpv27jm4mrMIaGAx026gHkMBM33X5lVMdDo1lEHP6ua9IXhk6CBiZG76LLh6YEacGwjT3g8kluw4TRPdPekrfpeNKEUJv6CxJK3Ntx4OJqh0KBmqhfb+y1IFqZegIawFLxFS1b4HsuC2WuADx/5n2Arjzd0lhGhie8JjyAh9Lti0AAz9Yz19JhqtASTj3q1zfgSQkGmKqifKuNR9gImNVX71g0LPERthw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB6579.eurprd08.prod.outlook.com (2603:10a6:20b:356::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 07:31:56 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 07:31:55 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v2 1/2] net: airoha: simplify rx/free packet logic a bit
Date: Wed,  8 Oct 2025 10:31:38 +0300
Message-ID: <20251008073139.373796-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008073139.373796-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251008073139.373796-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0014.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::29) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB6579:EE_
X-MS-Office365-Filtering-Correlation-Id: 737b5693-0a47-478c-735e-08de063cc19e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JUex8H1WLItmpcxoy1tVCWtpW/Z1gFChzNDwPUDfAVC+pKsCF3vXNC4Wivwu?=
 =?us-ascii?Q?O2rcVkdSlEAJouXx4X0/A9Clj1lAi6NWjrOcSyi2oKa4AUGURWdQr+gcgyVW?=
 =?us-ascii?Q?YUiJMCTwFSUszkMxXp1i3UzFdXmy+dK0yQkA4Mo5lbtHz9OHgAvaUKwITRAr?=
 =?us-ascii?Q?VFFfGvcpk3CYHrzLNNn+DqfTn3AaBvEILEwhWGd/yP7jcai98auGRAnjQGJl?=
 =?us-ascii?Q?V6V49Tmmhx0IXdi5S0pabqOZ0KR4d6rijuvACZgkkJ6LKIKkswHliU+Ez6Ys?=
 =?us-ascii?Q?rbOU2epqWdK5vZgjd9LnHsivHyIE6AWdP8m6Ea/DrB3vpKAoMaNNj0RizGr5?=
 =?us-ascii?Q?Sm61O6kVvhoiGKRdMNhqz9hlrM9w/bU8JEcUZlwQ2ULCpAdDfRVdSqhuT9dQ?=
 =?us-ascii?Q?0ofZGzXFmkxDX9qQKYCv4OSjpUEtNhc6VQSf0dvPfiZ+aHXeK05MY+5WKw4C?=
 =?us-ascii?Q?g2Nqzcj8xqniuppNpo5Pque6bzv0N3NUc0zQ3WGyWXjZKC6wZ/HNnLu7kc82?=
 =?us-ascii?Q?mPqAagvG21OC420xBWCoa3yeoVjewE5IAYhBbhYNkX91ukjSILc9SOBupm5L?=
 =?us-ascii?Q?EAF5GqzrB5cQOEH10VSgyp6rqL/N4XzWD3iBDDqkwDrujnOBFxjFGm9zygzb?=
 =?us-ascii?Q?ctmpKth6uSDA3kEMAlLFUl1OfscGudeFLqbWlSlh+ZUK0af87AUp9hdSTU2u?=
 =?us-ascii?Q?8v/gm27RpvonKufXnu/8D33Xu4C+ybdO9ZHT5up5mIg9yvXToB/qh5xhOehe?=
 =?us-ascii?Q?Ge/VD+nr/o6y5eQ/ElehC5lfQLxZnKQAErbjtR7sSF/+Qj7kebw/qg8t21yV?=
 =?us-ascii?Q?HM7lDCyRxGrbtoxEjqzL6cgSiUW2IjbF8DzDMHW0sQrv9hTAoQdRj6H02ejY?=
 =?us-ascii?Q?uPgrKUSkCI6QEAH+ZaTq+739LdhM1F1SGNEpcdAQvi7oHElUB92pN+lTVdLC?=
 =?us-ascii?Q?5p68RlPprXqSNRG93JA6nSkQBpuRZfNZQkspsh+IuRozWOgFfM0law5O86Ow?=
 =?us-ascii?Q?POPXuZpMWCgh7mdveaUdVcGHrlP905IByJzIe6jTwp4RuLiW2DZt7kEEZT/t?=
 =?us-ascii?Q?02bP0G184shKb5aSBQd2UqFlglVhNxIqgqG8o5a1M+iYRHiuRgDtSzzUwMmS?=
 =?us-ascii?Q?/ekqZKdtY0v5ECCPS711oYM5Fvl+FxcctqPv7LzQvenFDdonhjAJLX/uhZyG?=
 =?us-ascii?Q?K3a6+xUTNR/K+zjkdyGSgtM4N1NPdFgnV+nFvOwWPXv6h9Q7Hbq64+gnTs+a?=
 =?us-ascii?Q?U326JRtPap64JNiLIqkV7Dn6wO75PsP7iEreD/0EiHU1dcscSwXNt5B74r0t?=
 =?us-ascii?Q?lS9w75WXFC7DWzOk+euX2dcC70dei3rMdlC8CliyJ2MAEv/KcleoGoUh2fgL?=
 =?us-ascii?Q?1zb5uxmKHbgETIziHa3r0vmxOSZL8Uiw9NkYlJqL073JhFMqvnCeKa1OKMWO?=
 =?us-ascii?Q?hi/5AKvarP2yhKe10iNlIVZ5ercPVjxX072/KULfkM3EB5fWPdjYyf76xLhp?=
 =?us-ascii?Q?vivTrIf6qqCLnPsqCp8bN1X719McbXzsb/48?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ew4621AEHW2VuZ9jSM31MrrkTUs1qnOQnkgXHgJHjhKaH0kRfzTaNsyzJ1Et?=
 =?us-ascii?Q?50piIRoInjAjAq9OO0G0PIGLKUIshtGdAp5m4Nx16ZeoSJi+zDgOp5LzrVIO?=
 =?us-ascii?Q?7rSMEcGN0fGsLlNijcdYv9J0G2D0fXC7S3ToObM1lrIVhPxZ7mUc308js4tc?=
 =?us-ascii?Q?FAnN9TbwUvpomX4DOEWOuZOkRJU6Pm3H6zFkxJv1lD+Uo5mwuDAr+Eu6b4cn?=
 =?us-ascii?Q?1k49QcN2djT/NhyVnGHBqN0xOF1vF3YFR9UHM87CXwXWHTe+EjK0JAw3jFsY?=
 =?us-ascii?Q?YXY/94QtoxcIj+TGWoMYe1muH2aAlm2IFmh4n23oTQdeValVKTyuk/wYhYZe?=
 =?us-ascii?Q?1VnkXeiQIjtkkmxPQbspk3iAAFJfQsAOKXWfU7SKMKPiC3XIRubDvjXPlloB?=
 =?us-ascii?Q?wourofikOggdLVxHmq37OLQ2YfguuDjHMf09dWbF+Gx+iouQeP0KiZpG5c6p?=
 =?us-ascii?Q?wR3ET5HmeokGaSewGvjH/vC2qqm3h5TmH3vvgQ4fc11mqmbBy+fhxKsb6+mG?=
 =?us-ascii?Q?FoNjVib+ng3tRe8DHkzaMBdVpGx/xuvK/hkWyOwb3iuCEt80imqXUl8UMSuE?=
 =?us-ascii?Q?JZS1jP7w3LQhaSXa1WOl3V0fIpgttmx96bu33SA/47NodJ2TLJ8inH0N/82f?=
 =?us-ascii?Q?CFZovMgZ9o08TSvM0YE+ZnGfJ9PQx1VWxn2EvFIy+h9b01JJ7Xw+NcDmBg7d?=
 =?us-ascii?Q?jD+mrozlhRujkaLmEtc+wn0ZqYGy9u4YpBN5tq83ymQL3iwOk2wVrffExu0C?=
 =?us-ascii?Q?OlqzDwcsxzdOfScWHBSBmUNwyldDCdzyFvCW0J7pffl27QppzGvSPxJvzcXu?=
 =?us-ascii?Q?YiVTrZCdtOuHat18eHAoavXMhPrxzw2whc/0nM/OucHGSrPvLvK/YptvOwnO?=
 =?us-ascii?Q?AzOIY237+y1vAwKjoHaboVmBTFBHF3EsARsiOFHSdmBQv47Dcc4eOpDnx/mK?=
 =?us-ascii?Q?esagy0aH66lCVtWrfLfN56LrE62OfF1uCrsCrwjS+C5R0RAgW/Ug3Tip9vos?=
 =?us-ascii?Q?No9zS1UZY7pOg6ESTMR+9fl65rbBPewhxoY4GIpcyT7LYYpAMLiPfT9xThVt?=
 =?us-ascii?Q?de12pmoWLU4vhyAhw/B5C55IrUpCxHEz0VR8wfFNhWbjyicH20ye4pVcvFMK?=
 =?us-ascii?Q?yaTEuVHw28VutdQRe4LzYYkjWMxwpB0pKlnuu9cbZecLQ5Rpbrsd5U7L+138?=
 =?us-ascii?Q?z+ktXEgbgHiLIPs1l7S7nprvpQCK6dF/6lTzdq0finae0wDCBVSxuoDkMHJd?=
 =?us-ascii?Q?w6RdyEiOisw0PQHujtcmpKe8Gu3iG8uAbSKHTcGbcF4XrOUR8UL9Uk0u5zBd?=
 =?us-ascii?Q?+3ul6xlJORf8KtRYHc5XA7G8LYnhz9Q9mm87MkCDvkTjCLUMfYhDaBtXQDv2?=
 =?us-ascii?Q?ahUrLo7Iuf7OjrDUfPZC2gGcpWfQ8DQjajGrvLPd0TMYhEp7WtnWzQHjoM9F?=
 =?us-ascii?Q?018cbgC6kuZrN/SijNjrb76ccj+aQLrVsLldzAvjU6XJLJ6ba7s1sk4jYccZ?=
 =?us-ascii?Q?jXO27Yn49a2i6QCbYKuFaUlZSMHbFL9E/x6Hs+vfTsWgIYWxFCbkgXsgoxL6?=
 =?us-ascii?Q?OkX25P3y3m/9Pp/GQzO02Bal8yaFln4E93eBwQM7ROVCCuXkvo2JUitS1CtB?=
 =?us-ascii?Q?nQdsSUQg9OYZZltDJRb4EaA=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 737b5693-0a47-478c-735e-08de063cc19e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 07:31:55.1596 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u23niNfAs+CA5OFHbO2AtvehaEuVOPco3+Fg/9ZoxJvOKnp7yKiJrXOjIaqjl9B9WibAA1Z+/Hx0PHDfkl61gI4anfJQ99m1AwoZ6SXbgFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6579
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

The commit 997786bbf473 ("drivers/net/airoha_eth: fix stalling in package
receiving") can be improved. Instead of returning previous descriptor
it's possible:
 * do nothing in even descriptor case
 * return 2 descriptor to the queue (current and previous) in the odd
   descriptor case.

This patch:
 * implements above approach
 * remove logic not required within new approach
 * adds note that PKTBUFSRX must be even and larger than 7
   for reliable driver operations

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha_eth.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index 6588eb3a806..19c3d60044c 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -449,14 +449,10 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 			RX_RING_SIZE_MASK,
 			FIELD_PREP(RX_RING_SIZE_MASK, ndesc));
 
-	/*
-	 * See arht_eth_free_pkt() for the reasons used to fill
-	 * REG_RX_CPU_IDX(qid) register.
-	 */
 	airoha_qdma_rmw(qdma, REG_RX_RING_SIZE(qid), RX_RING_THR_MASK,
 			FIELD_PREP(RX_RING_THR_MASK, 0));
 	airoha_qdma_rmw(qdma, REG_RX_CPU_IDX(qid), RX_RING_CPU_IDX_MASK,
-			FIELD_PREP(RX_RING_CPU_IDX_MASK, q->ndesc - 3));
+			FIELD_PREP(RX_RING_CPU_IDX_MASK, q->ndesc - 1));
 	airoha_qdma_rmw(qdma, REG_RX_DMA_IDX(qid), RX_RING_DMA_IDX_MASK,
 			FIELD_PREP(RX_RING_DMA_IDX_MASK, q->head));
 
@@ -920,7 +916,6 @@ static int arht_eth_free_pkt(struct udevice *dev, uchar *packet, int length)
 	struct airoha_qdma *qdma = &eth->qdma[0];
 	struct airoha_queue *q;
 	int qid;
-	u16 prev, pprev;
 
 	if (!packet)
 		return 0;
@@ -930,22 +925,29 @@ static int arht_eth_free_pkt(struct udevice *dev, uchar *packet, int length)
 
 	/*
 	 * Due to cpu cache issue the airoha_qdma_reset_rx_desc() function
-	 * will always touch 2 descriptors:
-	 *   - if current descriptor is even, then the previous and the one
-	 *     before previous descriptors will be touched (previous cacheline)
-	 *   - if current descriptor is odd, then only current and previous
-	 *     descriptors will be touched (current cacheline)
+	 * will always touch 2 descriptors placed on the same cacheline:
+	 *   - if current descriptor is even, then current and next
+	 *     descriptors will be touched
+	 *   - if current descriptor is odd, then current and previous
+	 *     descriptors will be touched
 	 *
-	 * Thus, to prevent possible destroying of rx queue, only (q->ndesc - 2)
-	 * descriptors might be used for packet receiving.
+	 * Thus, to prevent possible destroying of rx queue, we should:
+	 *   - do nothing in the even descriptor case,
+	 *   - utilize 2 descriptors (current and previous one) in the
+	 *     odd descriptor case.
+	 *
+	 * WARNING: Observations shows that PKTBUFSRX must be even and
+	 *          larger than 7 for reliable driver operations.
 	 */
-	prev  = (q->head + q->ndesc - 1) % q->ndesc;
-	pprev = (q->head + q->ndesc - 2) % q->ndesc;
-	q->head = (q->head + 1) % q->ndesc;
+	if (q->head & 0x01) {
+		airoha_qdma_reset_rx_desc(q, q->head - 1);
+		airoha_qdma_reset_rx_desc(q, q->head);
 
-	airoha_qdma_reset_rx_desc(q, prev);
-	airoha_qdma_rmw(qdma, REG_RX_CPU_IDX(qid), RX_RING_CPU_IDX_MASK,
-			FIELD_PREP(RX_RING_CPU_IDX_MASK, pprev));
+		airoha_qdma_rmw(qdma, REG_RX_CPU_IDX(qid), RX_RING_CPU_IDX_MASK,
+				FIELD_PREP(RX_RING_CPU_IDX_MASK, q->head));
+	}
+
+	q->head = (q->head + 1) % q->ndesc;
 
 	return 0;
 }
-- 
2.51.0

