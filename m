Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2451DCAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 07:28:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0AB8839E8;
	Wed,  8 Oct 2025 09:27:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="4FFDYTsW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6183D839AF; Wed,  8 Oct 2025 09:27:51 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D963E83956
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 09:27:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6XQe92dMh5rgr5JifLGzErR/lzsKxWVF5Iy79xwTeUtDZMs3VAlWU40VFcL7JDIt8oIUztECvPJs0JuWX8OdIq8Ns0UAtlCdFBZ7FlrAH4eDYU+3BegMCbigBYx6wYLiZM0n7UuU8SJJPi1m+47VDyWoEcVPzN5ihjgDh45ILNzKmOaR3vfyw4ZCdHcmU/n0I1pvkb6muJ+mW4Oo0gnfinDHBM90jvecjQXjeX54RnYwPmuui5dR6CuEXGBxCmOUyd/9NYV2jOKUKfCC52LI6aJAcVOFV2/8nXHKpMIYZ6fdq4nMiKsxdYMAuOmwoaWX7kOLpQKadtQd/nqgmOdeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKthlr+1eUHrEiMB39VuKH/tZLvqA7VpD1y4ipWK6KQ=;
 b=mUYpLhfhnYapRRgH/73uK1vbrBEkqhnHjP66mAc+bccnRTUZ0Hm+GVD3Cs0HXFLxlutVX3qttwR2qN8kD3Hivx3VqXL25pxM/2qqhtM0auITaRPldULZMYnhOq0zDauDZpcEPsB6F3NOccEwMJZzDQQcb4hKo7SnejniBh+383cpVmA1zZAymge6GhjETEKtM1y6RyUYp8TUmc9pMCdmZYbpoNOx04EEW6NeXWDmtIKZ4CrEY+qwJcoahpNxjkN5f9sR4NyZGmTFuIeQMV0dVQ98ExEPY+vpnS0gp4aI8VgytPkc3Q2PX3RBVNxA27bcbpEqjwkWUPluSaJ64OrcIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKthlr+1eUHrEiMB39VuKH/tZLvqA7VpD1y4ipWK6KQ=;
 b=4FFDYTsW+Pd+T1SanyDqVVrveNMLTHvmyScOcq7naJOgpkh1H4lREKjayD3iVW8VaaBCMvJQWTsvuP68FWJ1M84TeGSfdm4HaBhcmO35Hgo5zLXlTXgtmRywwdgUzeJVj7ey9H8ckl1JIStTsWnJit1/ouJ4PexFvI5CjxljywjRSCgswyFEwUpJKzKWXZMge3Dt8Es6WtoihwpTmcIMOn2OB8gC61eCZKdIBa6ZQ9Kvhvy+pNt2AOZZQF9Yvh7CnxoTZu/g+Zfsvk2t6Og8rg+PP+2dmxswlchixlXNB7sknU/Llbgeu6YiGW+uRu0nCmgXQ0oTcGHnlnRQaHk6fQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM9PR08MB6097.eurprd08.prod.outlook.com (2603:10a6:20b:280::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 07:27:43 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 07:27:43 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v2 1/2] net: airoha: simplify rx/free packet logic a bit
Date: Wed,  8 Oct 2025 10:27:32 +0300
Message-ID: <20251008072733.373173-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008072733.373173-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251008072733.373173-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF0000384C.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:9:0:e) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM9PR08MB6097:EE_
X-MS-Office365-Filtering-Correlation-Id: c2d4c5e2-8be3-4201-e745-08de063c2ac4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?enxx8k+Biv3ADR8YBYPMlZ+G3gS7Nt4ZnkVr02tlcKYlH4r0oM/Qg9a1JO8K?=
 =?us-ascii?Q?xnIkPFUECFVLsyM1a+dInkSoxtiIxdRGQ4mKMLnndwr61mhDSyVK0P9OSxMl?=
 =?us-ascii?Q?QZ0DKfSQNO1KAmX8pFY72oK2KgYurC+2/4mQA8sgv9LzogKg4FjdXLcMF6Dv?=
 =?us-ascii?Q?SVHVsGenLC3YdViIXB1i2OkpymJABMoy1EIIcEUK/JEEdVNSOO0YFXmrt15p?=
 =?us-ascii?Q?coCJOedZtotvIYTG/WarC5DMw5Jk8oxzIXRB16BvWiWKjFrlxSgTM426wA0Z?=
 =?us-ascii?Q?T3mP7Q5PGrNiXkfZ5sSla29Wzsr8nbzSkcxSLUJuI9aZW8+kE2QVv6r8x3yG?=
 =?us-ascii?Q?WA2Natqu4oIiPoNZAVaZqRF9s4Sy9bbYpyDKHZEnrpCYvcGxDhffWwP+Xzah?=
 =?us-ascii?Q?jm5VTBYDmNWEXqgpJTy7P1YyhessygsnJ+WfouvwDyirvx4AKKGH7vAdHBV0?=
 =?us-ascii?Q?VhoCLglCkwpX6+PBiTwwheg5AcvZfIhO654x3L+0LpWkbr9An84o+VAeX8++?=
 =?us-ascii?Q?RCha5dLXBROsyhrTfndSTDMPTLzHJAF1gg0nyvv7PldCYRLASvj++MwzUgoI?=
 =?us-ascii?Q?ZhU1spyWC1leYOptm+BateC8IWqVEGYVc4KCMSGBGYRlSzbFUsVV4e+c7zY4?=
 =?us-ascii?Q?fE1SOQKV3UTIXBa+jzWCCUHMjcc2J2vdiBVXO9S6mZAUmVa0hvAPC8ES3g81?=
 =?us-ascii?Q?nI5eAQhGpgJuEBckJHMkhOrzM38v0To6FyjIbtLyh95LLoiWNAismwMrATAC?=
 =?us-ascii?Q?OM15RxLThCH+kibukxnq/FP3YaBFt5Z1PVIqe9EYepRn8IPCjWeOT6aulGEX?=
 =?us-ascii?Q?Ua79XyEYBk3hlfn5EPU9OA0BRi82DuyMNw6O/uSRTq0hEg1gwPSwMjYjDTzb?=
 =?us-ascii?Q?FKdmz9mjJtBpei06J/aftIC9AgEZi3RUBgE3vp6NkSNuCDA5EHH0gXLH6GYg?=
 =?us-ascii?Q?WL//B7tP9WjnW16SYwHxztIWqOuEND7oZOZaZbVoSjpHcU8YFko9jfr/yGyM?=
 =?us-ascii?Q?MmiilNki/zM/hqMHVwobwa3uH8RhPVmPGBAhyFj8SOM/IvgwTL5OSbhSGYeb?=
 =?us-ascii?Q?YPk6lo7iFw7Be5D3gafHmlSNTEkwXs8srAcB8MCRazMR+eXPBUS18+vqKZfW?=
 =?us-ascii?Q?jtMQcQmqbHDejA9jSPAfY3KzqIfKOjX5faekD/YKs+0Pr34baUWyJWHht/jz?=
 =?us-ascii?Q?SpBNn5+v7KFnk9mfiDkMbCOxrK95AjkTlqxGbDKuzoiiPdozMxW2zk7SmlPK?=
 =?us-ascii?Q?T9YLIc+RqydcFljm34f4K0KdSnzmYU7OY9pc0+7Z5eeb31Z7zEPAKSUc/6SO?=
 =?us-ascii?Q?is6k23P/7/NEZEPO1kG9pYYlyxnDuJXBRoIVQr/O/kx36OG+L7I+bQCeGNLA?=
 =?us-ascii?Q?315FFo/yvaELbp/uQjd362F7K6oFnL7AP+lF7cJ/VQZwC8jVoMcCTleDwpUw?=
 =?us-ascii?Q?eBiU0gDFU7cw18dzi2QdnzJbjg3vd0vD+tHIi7kIAT4wmbZwDXVaGvuMtD+4?=
 =?us-ascii?Q?RRca5fqprPRWc04pdUQNyLSvxAiEbYCV5Xyc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jhG4IX8BcJY7nnlckezJQcfIN4RPTyxGS6M2iLZMcFDgX1DjL7Cn/Tli1fds?=
 =?us-ascii?Q?4K83y77RZDyncdjCvdFOney4Nwo0D1eqsWqQfY/RC3+Czt/JWoCIKittdpqD?=
 =?us-ascii?Q?PKCQwAwP3ZTyuxU4IezJE/OTXoMiTExoDEVB6AZ5tWheVe+WzRF/g0RSBML7?=
 =?us-ascii?Q?HzCDxklRsx3WNwTg8SUZpULqVlOYwFkgSt5/VWMkY0QmDFLz01pxpyJwTGdv?=
 =?us-ascii?Q?Ae+sRPo0yAgq4qFhBr+CEJ9VeOqCURaXM+4PpKlN//he//rFgAKxgvVxoMZj?=
 =?us-ascii?Q?l4hsw3sSHKOV/cXShYKRzCzhynePEHV2d6hT92yRnmV+mgb38rXw/G5FwJfr?=
 =?us-ascii?Q?RsvvxkAMlOL7Df62rcrcS9KXYnVBDI1nZkcGN2R72BMudHncgDmVBUUEyhU3?=
 =?us-ascii?Q?1y11L2jRfMj2g4KcOMrFTDnCljtR8b9XSwk3H3jqcBBrkkQk/2nRVcNNrZsM?=
 =?us-ascii?Q?Dz8Lww4EkD97lt5xxhCv6IN4EWTc1/jsFRh2KCF9hNKOmELWSjIiWfWf7/Ke?=
 =?us-ascii?Q?9RzsXdKY8vy41Z/P9+XkUkzOnaxdI42uNg+uphQKgKTH+0zfHzW95GOhCuwu?=
 =?us-ascii?Q?SJ5AgTkV2YiSdXqLFnpTdblCUIl6SGxx+OO81q8vYmPQDsqzr15R6kULMyy6?=
 =?us-ascii?Q?pqYB1QNxb3nQyNv+dB/dmDzAX9EUP+7b0BmWCgCCynRIWdOhCmrLuWXrSkBj?=
 =?us-ascii?Q?YX9o1igAYX413xZFLTcghSnYZL1G2PFh/ype6IG0OTqkL6u/GFZICc+eoCxf?=
 =?us-ascii?Q?K9SCtclzsLQeqJ2CXmx3j25P4yStOZ04UNfG9ng0nt3AH8B29TxTk5yx73S8?=
 =?us-ascii?Q?7Mn8LfIH3eZyHr+lnqTy1w45222pZbENoYzd8JuPBeTXaBfsV2WgG05+bXjg?=
 =?us-ascii?Q?6u2IpjF+qn1LzpY7NL9W2E1HPtLeA57FG4Bo8vMOuebbsrglW4JL4Dmn3haA?=
 =?us-ascii?Q?WHpnGr5HejVF7RxnlcXZFPUr0SiZKM90ZaOxZh9raMtd24b5cIotYMoni5rI?=
 =?us-ascii?Q?J0opJXeIzOK0Jlx/B89oRQiQyXLG6h4mirB8ZX9Lgi7yaJ6DL2vNVbPquT7n?=
 =?us-ascii?Q?c1BVNi4s/4hhM4e1GPD9ulurf3RK5y4e/6MXI2U9AoXubGrWNSVEnwFLlUrT?=
 =?us-ascii?Q?8IDSJon0aJnLhFttgbLtBpEaTucG+A4oB+1WHrBy6CX9ZElR9f/gOnDZ4Ss4?=
 =?us-ascii?Q?3pEPU6J3hdllyDp0UP4ZSBqcToulszbJD4CnfO6bAWe1HDUZkg43yMs5Ccod?=
 =?us-ascii?Q?gBV1+WJ1TlqKXNVqVKlma3WL1ts0u7af+FPWcVWRlNNjIGCPpVoXFNCMdt+C?=
 =?us-ascii?Q?9IdvImn4biGUrajeVApm9wtQi/v1ZqkVofHwiYtDpAwTHIPK93tlpcH9AEL7?=
 =?us-ascii?Q?AT/y8EDTWwvb4ARfsvaJbu+2YR65mjEbiiOfTrF5AgliBngAXum6mhsxZ9OX?=
 =?us-ascii?Q?UQ1O3Pcq7ndnl2s5VPN2YSaiJlC9PKKMjV+YDKFHLom67Ec6qbQxIPYxHZoO?=
 =?us-ascii?Q?rSag/JMCnh73vNckt81kQ6UODI7kLTizdK5wEzkxxPLDYIrf50L+bOgMydq+?=
 =?us-ascii?Q?3IdqAQJDeXRiUdlsDSukcfOo+twHqRFkFRMTBGeUfZAeabB2rIx867btGqjA?=
 =?us-ascii?Q?YuheeB05+Zx9AinaESH3+Z4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d4c5e2-8be3-4201-e745-08de063c2ac4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 07:27:42.0843 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W5Q3I1/5H+n+ae8FVyXHjRkbs6pCXvDuKGu9xW2x+SzYXZymZ2b6qRzLNYMGkmY3RVuu4SiXe0uQs8KT4JhrUmt47U2lpkPOpigwSU86Acg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6097
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

