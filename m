Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CAA5CCA471
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 23:12:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F35038387E;
	Sat,  4 Oct 2025 01:12:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="M3CpxGG2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FE6583887; Sat,  4 Oct 2025 01:12:52 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3C488386F
 for <u-boot@lists.denx.de>; Sat,  4 Oct 2025 01:12:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UBzqgI4vhKtZm8Ya5xmer+9hLGE8U9Hxce99xarWdroxZSzLp6ZZ8TX2W07RU62VUzuTeFVFFJW76+kqyfI3Enj4ZSu7BGbjoJNFYdmJuAmUXtQkBEWWWSsqxcmiEnG7BMU6s//7dNeYMfTYFnj9Sb/kJVf9L4DfVVQfQB/gFDO8EBu2wyzTODqUOg5hlPG9nYUC1uH2xRXicMWThUAyAsKdWLd/FOGM4+bo8Ll5FCfSFRH8R85sYTB60Z4YMlyL7DHSLx5FH6UMQ3TxH9v1D54J8i5r5wUZTPiedB+o7r1laj1ecxXLtx/X9GCC9NpG/f+/cPKTxF2ssfT8tKAcAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKthlr+1eUHrEiMB39VuKH/tZLvqA7VpD1y4ipWK6KQ=;
 b=ola8dU/3T7zI/xYZFzMJNYN1lkvEbhKV6UxjgTAc7AG0gLDPnR/zbAoq3tDWziX1y5LCauLma8Rnc7pWH4jdoEXAstYwjkd3yp7HRF5QrPoztt78F55XvL4bugTMZ2rnUPj0frOgt59olwLucG3Bd76BGSk8PYwr7SAUfOrN63xUNTcZA/xCDEVrupoo08GLB8cqYRJtD2tQHQ5TJNXceDNKRvFberG3qASN0HYDMs5pWI52Jj1UvnWhedFzk63o26YLsR6Yep7e3VWkNprMmBnNJAUjNiqDpCP+YMjGas3Vit6AmiA8TSzcZN4MoL77yyUa3LM9iA3iNoQZRRtlVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKthlr+1eUHrEiMB39VuKH/tZLvqA7VpD1y4ipWK6KQ=;
 b=M3CpxGG21piCTnDgmmNYyX0o+12Aq/Q41fHZCut4ZYVv58aIL0OjhBrFwjWI6iH1OJEeC/v0UeT3NmWXBjdC3Vj2iEVNmV9OnA6dIgthYcgYCuHeQcNEAW41vfeEp34h8yGyiAoOuTSP54JGvvPyPSScgwFQIDr9Cla8wjByk0tjKsLG1fyE/xCLN1zAjj5F78n6DAkXSafzSg90EgXnarBCXhvhsmWNeu4VUyzOPCnNdz9OP3xsXdnX7bQZQzzzr5gZWyltVnKmjKYUq49y/NuW6IemkOjCKUPiy3aDLrHOdKhYf/i3GB6qRXluzfk2TZ9+//s7rciUHAv0DO3dZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DB4PR08MB8125.eurprd08.prod.outlook.com (2603:10a6:10:384::19)
 by DB9PR08MB6588.eurprd08.prod.outlook.com (2603:10a6:10:25a::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Fri, 3 Oct
 2025 23:12:42 +0000
Received: from DB4PR08MB8125.eurprd08.prod.outlook.com
 ([fe80::e9de:ca06:dae1:ef2f]) by DB4PR08MB8125.eurprd08.prod.outlook.com
 ([fe80::e9de:ca06:dae1:ef2f%5]) with mapi id 15.20.9182.015; Fri, 3 Oct 2025
 23:12:42 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH] net: airoha: simplify rx/free packet logic a bit
Date: Sat,  4 Oct 2025 02:12:32 +0300
Message-ID: <20251003231232.4056640-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0063.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:270::6) To DB4PR08MB8125.eurprd08.prod.outlook.com
 (2603:10a6:10:384::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR08MB8125:EE_|DB9PR08MB6588:EE_
X-MS-Office365-Filtering-Correlation-Id: 39496e04-34dd-4c0f-28a7-08de02d25a21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q4TA+hD/k+R0HzZncMyZuglxWDHWL67RMkasJz8flJubu1ck+BOEu92G4rH9?=
 =?us-ascii?Q?DxO4yK426rAFNOFhUY0UfMubrXvk/Os5tJZSL6XYAS7pKeUZwQy7sPtw2gUv?=
 =?us-ascii?Q?pFBlwdsVwHzklX8YcCbB24ZrHaC4/HjwMidabArCN0US5UOPZItrfGuW7W6G?=
 =?us-ascii?Q?4Dus+qNh2Yipug05eZ515GmAYYdlZOoobSAJZ8MWNJ57l3Um24ul0+6Rpzxr?=
 =?us-ascii?Q?LuT8aEwb97t4Axp0JAbfGDUu8RecXy5rs6LZWeqzbyC6X6Y90WcqGIn1P8Fm?=
 =?us-ascii?Q?HZIGzyRIEjyEbkE1XN1HyU6tzYwQFImXbfy0pPSz1wA3Gnm1Ue1gJQOri998?=
 =?us-ascii?Q?GpfBu9kYTQx0OGD75LsTb6zmIRsSyVShbHbsbjcjQiSkBwSiRC1vJkGzwmPm?=
 =?us-ascii?Q?Cv8bylWT6Z7RJhHHBHKQtIKzf6p74QrK55gwdpjydzIxISrR8bT2sXBXGQlM?=
 =?us-ascii?Q?P9CVCO1zOgo3WBXCHWXO+k+S3Bb4/IPMgVFqzK2zj6iczRQ53G6GAzvTLvl4?=
 =?us-ascii?Q?6P399KvloQETX2BYNRpHDz4wdi9kZaK+MkzCgjldcgwQLxe0gaOapd4RHI6a?=
 =?us-ascii?Q?eOEEKZeMWtq/q0hWCd6mdYiBtXqL+sN8SosPGxXoiY8AmP6wRTipSRJRq/fu?=
 =?us-ascii?Q?bbWux6Cyxu09/9x3t8XiHEc6VIhdSJze2Rd3P4j5Oioe9pqczXII5Yz7vpPZ?=
 =?us-ascii?Q?qky7IwxkEMKrAFDipiNwFZfy+lMSS3N/cvoxAuZTneXvCwqjwZ0SkRTLkcg5?=
 =?us-ascii?Q?x5RSGbldGo79avoswsguYr3UW6IX5tmmX41vlGcWiCTNoBQTUhz57O4kFq1s?=
 =?us-ascii?Q?GhGC7CcObumAIZD+mxBIh1dyLd6qRwaJHCuEZPfE6vk2RElH6xT0KLAFO5ce?=
 =?us-ascii?Q?1+7H2tdRKOpGyM2exczkMdt4Ia/XfeNaXeb3Eykcd8knEtsvovRPQ5kwCxWh?=
 =?us-ascii?Q?fsFr0DTq7Ocur/n1dwM3ctmN0e+X9KlhOUm7Hngj94zzyjHiHgiGd9BnYWF7?=
 =?us-ascii?Q?1sO2ZQwCnVTIinr1Mr30CvjU6TpGwSc3xY5XK3qEXciC+9pBgYLbJ/tHcycL?=
 =?us-ascii?Q?mWROS8TL4Eigm575gBCDXEoTQsHJJCW9ie38cGFMnzaakgb8CzbhpQnLKcv1?=
 =?us-ascii?Q?mG/ybaixX/0LMuTD9ATUiRyW1rqe02KljZ6WbheTD7IZm3FV/gs1sP0qh6LI?=
 =?us-ascii?Q?BUlBXbtYH8qc+3tDX/uuADD5IYn4AWm6p/3fSdHSaSuNd7TX7VvogbdV2tRA?=
 =?us-ascii?Q?afd8t2jLENdtplYl7+myu5gQDwwD+2hUpM2iYcE4FawGAdmpPBkZ/s0ePvJJ?=
 =?us-ascii?Q?jOUjdEHXUGkLlNfFKEXBZsFegfs4nvTcWYo8v7RgQHxiwufPafUJby5gXduU?=
 =?us-ascii?Q?Kc4zUwNzTReTMsmshdUkFlsZFJ9OKwDCWmTKdxPDNAlPsNA3wUdEgiA0EIRB?=
 =?us-ascii?Q?ac95JKqWv6PDXFkoqA6DffTjSu8DzXk9A8N33U6rWBTR92TvRIJmBP2jFk7D?=
 =?us-ascii?Q?CbmqrYP0oiQAMIjxxn5o1nqDjwGcue+SGLJN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB4PR08MB8125.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NV5H0ufackCttJn4d7TAqy548o9URJRCiKuixrBPH3X7bQjwU34nAfWAwfXX?=
 =?us-ascii?Q?9fdt8ZY1vwo5qzFuw0TfskR8AzrVFS00kzIXnl+QDGUUlvw4P7NJLKqgj/WW?=
 =?us-ascii?Q?+f8jQpqm6H7JypFNdNcgq9GdF70jteOwyndJK9wyZUb3Q9KGuTgaYED5uceo?=
 =?us-ascii?Q?mK03aNZs7I/I2hc3KqOKPTTdyU4FIKQH4traQCz9l1kkB+GpONePOXqs4XpT?=
 =?us-ascii?Q?mdNSXtpOhipFxeZQ+lbiY45FDHL3zuCws4gJQMzjQCACATNqYo2v4X9lxv9r?=
 =?us-ascii?Q?k8dzSjn6BkC7bp8WtkO5xdNdvOMyz8cAzh6APUGwrgCxNoqFVUTtitD6qtHp?=
 =?us-ascii?Q?YH0U6zF0q0W0Pom3NShzCPNNZEgpBHJHcy/CjDQ3At5W3x7kDivzgIvROFe/?=
 =?us-ascii?Q?FyWtSW5B9ok66QVw+3zLLRJ4JDLOcXmsITKOQgf7uyxo5upeWU4ClIoAEHK4?=
 =?us-ascii?Q?hLmn9N9iBenF8flJ+JREtr5UhjzYc+tIak7GXx70v01H5W9WWNkO/tnXjKzz?=
 =?us-ascii?Q?WzevQnZbNRV3nuwgizT+jb+qCGFenJ9T88QaIniGKICWwr6civusZgTbRxZy?=
 =?us-ascii?Q?RAffJoMZIwtxcUJ3e1x+qcCaoZlemNEt5IYw3oOZEhoywVhtU3u8vufcp7c4?=
 =?us-ascii?Q?wEQl040ORAdSc0nj5gW1PCbpUriUOk0ObkcxONBNGjF/1Tgu0C9AqBIiw8FM?=
 =?us-ascii?Q?Bqr1pdqiAxtpObLuFzeghHd8aQlGITYZqBLZPoHN4bn66jl0e01cCG1e2xsm?=
 =?us-ascii?Q?quIEH1gCFobAOnHIyIJenBfPPHGXUZp/lJCsSyeUmiuaAdEw4oMjoI/LvROE?=
 =?us-ascii?Q?VPWvsd1LZWYHv82Rf1KIL2V3gUykSzBgcBoZJ0nkzfmDv97IgBoYKRm5RlqU?=
 =?us-ascii?Q?4SgAF/f2qrYo05h5m/usDe6MXsSaNIveyLJQ//kYx84jkq2rzYHdOjGiAqz3?=
 =?us-ascii?Q?rkJsZNm+LYaYcdiRn40QHmATtEUw9B2GhNhXPBiEYYyvjTpWFq2wBJl3hSZN?=
 =?us-ascii?Q?hPbOc6Xz0RBOCD9/X3YLH03keBFxueDp/Whra+CR1ABnhglvHaktfrs+6Uvx?=
 =?us-ascii?Q?bZnb/tmX0gbkEP6eTRM56uSM6qXzKZdSyAl/dWmh75ey953Uwgj0lgf1XybZ?=
 =?us-ascii?Q?0igt8uDXwI5bmVAvYOoFe1A74jou1jfQC/7k4k86xGhc3MnpRkOiRMoR8gqT?=
 =?us-ascii?Q?fsuTQAaawAy7LfdFSBxIwW1p+tM8JUFGjzgg5Pax2z+hleLx+Iku1EUb2agl?=
 =?us-ascii?Q?Cd8o9fnReBUMjCTNbVgFlsx3xoMgZja/1kEMbKQIaG+B0qgauzAZPtvV5iWH?=
 =?us-ascii?Q?Nx0Apai3IzRf0VItzeCozwyjNIHspHCiCqvhfJbbo9kIVySJkLqRSnAs3+YL?=
 =?us-ascii?Q?3Su/FL0fpFr+26ZwrNjitEPrCbGMfMbJdqcw7oOQlfQp8ooIQU1eb3vt0UAr?=
 =?us-ascii?Q?kbUTeHx1wKoff5c1cuvyUqFqmroeQtRpaEVCgu0heU+uFLVQen8oug/L/JXF?=
 =?us-ascii?Q?OBebsXdfIE89wO11sM+Mwf/A1KzAhR3raxPIVvA2kZmGcQDjmP4/d5qk35o9?=
 =?us-ascii?Q?SXFLvuDWucDI32BIcfkrFy13IbyOXDwuqHTXpJ+RQcXgKhlFRJyIaLl6/hRy?=
 =?us-ascii?Q?WwNSKNmceenk9ZoOhWWAGDg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 39496e04-34dd-4c0f-28a7-08de02d25a21
X-MS-Exchange-CrossTenant-AuthSource: DB4PR08MB8125.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 23:12:41.8611 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+S8QNm5xt4WKG18MlGype0NOhj3/QDKbYQOE0Txeh3Vzmlt4zTkTY0uxIQHgtZCZpic4RS0O++j9999zUG1qWlpZVGFjQ7tVkoR3Xfzguc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6588
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

