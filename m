Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BD6C83F09
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 09:29:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB805834D4;
	Wed,  9 Jul 2025 11:28:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="nQOsFFLt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D772883447; Wed,  9 Jul 2025 11:28:27 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE39E83439
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 11:28:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MomXhwNa33SIaY1h6pQdFU4dT7PfHt2M0SvVMc5FZ097q/yMcWsY3HwpfJmRVHiX0cYey6HZ0heLUXgrDy1Kv3xTam65aqSQN1fuz6a2QhseAydtcbwG1WtW90Iy3ZMMaGSapk3mk4TDtpol59Ue9Q7wy97t0pVVVgxz9umbaeow4qvxtLx4eSL407dqwD9vvAPhcTkntpDzLY147wxiQj81TSkUt8S1QyQ3ZTjLICcl9oAkeWkCVeMAUSMVfXAndHtU/wK2U2+5VVkA7Y8udZSL/bZV+/K0f4BzQp4fBo3ZRHOoJiJqZ7Ym0Zm38eABWHMHrqDbImVULOtWEBz55A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyChzFLZC29KBElQp4cEHXR/VzCocTaxMXRbgp+VHpM=;
 b=luHyh3ABpH4M/fKfQBQO/liX+U2NhHrciiWqPQE1ddOR2UDzCypt3FFn8kXVjl1m3H8YUyYuj82uKXLKw0f66vA9yGSbKvLGUXvMCsqGt1cEpXFVclBAxm3DdZljugWqNUVNHaw76BgpD+eEA4tsOWYUTt/RGDvpFae2XdvcA9PAj70n2K4ZBkpS3HSKao1kpMIbRAJ521tnAyn9SERdIenYPsjI5jMXhM3bYA4oUumwoRAhyAe0up5Mb/iEy5/2PBfVisXqsddtKLyk2r14xUSyr3bvuMqZ+uflYlAO1PnY+/pH76RJydElplTZWJB2Fwroq7h2BE179eTSNxjFWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyChzFLZC29KBElQp4cEHXR/VzCocTaxMXRbgp+VHpM=;
 b=nQOsFFLtqHdEKJfOCWF8fpBxOL5Fjq0D74MhMmAu9ylLSFk8J62WSu/7z/k2E/uC7gB4zmQF4Zjf3UjZGY+rgFjem7S+TyDCrj/8dzDeLLkojNDJa1bRjGvrS3TJ7T1X7FRK2naER/Bsk3wPCACsjVII6RT56KZXB1J9/IqPMdxucQN3mKiSwP7TUyWYShEgSboXDkKwokjf3/V4/MryA2+DMFFosccA4u/8tGll7uiP5YLaFTBWfHrRksCByGbMJqfXQofsIvYdIqqeHcpIQwCS0/aZ+Ey5Fyxmn8o901Ju3P3k2hOzHYiyHzFZe9KQlGtPj/ApFQjTPC5zC9bIMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV1PR08MB10805.eurprd08.prod.outlook.com (2603:10a6:150:164::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 09:28:24 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8901.023; Wed, 9 Jul 2025
 09:28:24 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH RESEND v4 4/4] drivers/net/airoha_eth: enable hw padding of
 short tx packets
Date: Wed,  9 Jul 2025 12:28:10 +0300
Message-ID: <20250709092810.4032971-5-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250709092810.4032971-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250709092810.4032971-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV1PR08MB10805:EE_
X-MS-Office365-Filtering-Correlation-Id: 55a11b9d-0ef7-4102-fee9-08ddbecaf3cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YA+ORjRszBie+HqbledgtAXBdVJon1bnDMvHXPIB8o4ZyQN89h2RJSfEyfeg?=
 =?us-ascii?Q?lIqDWJ++ZIIX56EcSnS0qJAT7ZF9FWp5jtvHHULYB1IfwVvz2xtTU4gBUnp1?=
 =?us-ascii?Q?9FIz33jaTZVwchfknNzVJvcnCwZDZhLH8Ri1JIVURRNmyuqestCKWbGIfC0E?=
 =?us-ascii?Q?Ipksfk7W2FTxqcZbjAhiKSLIqsC5xam++omiEVd5wFgUCTU9YSEioyDy8Wrd?=
 =?us-ascii?Q?WBgnltPDVGUoVSMtqrquwrIAHuarPLDFK/DciMZzi0PvjgnGXBPh8K55mdhU?=
 =?us-ascii?Q?7tHExztVsQW2w/62kpSe7+FzjI0Ua3Lae6ls0EBgmYqgOyfElaBr95p4gzdL?=
 =?us-ascii?Q?N7NdDwcfJOplhvlIKr7aPpSxYx4UWLh3ciKKzOzUJXZXYwUjmbX6O2jCQizo?=
 =?us-ascii?Q?ADdMZYNfaGxuFu6Q01QTDWyY/ixT5pGwSyugk62O4NtR2JeelsGcNvBF3aEy?=
 =?us-ascii?Q?qK9btYdYMMe7B5lVFABj4PxUVItk4SbLAN+X3n6SSQXag346ZIYG2SbL9Ssh?=
 =?us-ascii?Q?MdPr5WKgMRCTFcblKmICqmUGQ3Mh/rFUSby2IYH/sgepY64zwV+qL3P7fPsg?=
 =?us-ascii?Q?TtQ2JXytoV8shrbwXBG/v+B3TuGh95h7KiP5HpScwSuUJcyAQIN7dzs0Q1XC?=
 =?us-ascii?Q?I3+ur72I2YgM/+spWBJvRsacl4OtMHoMpdpE0TXwFxZs08CiB6oW4R4KySjD?=
 =?us-ascii?Q?VKBzN1dFwQ8gak64LoB0hrKe97lkCA3LdrFJTATc6ZanyyGylgV/+muvY5iV?=
 =?us-ascii?Q?+isFo65mcaEE1p51Sfof2cYkG7q3YtczqJvyKNQxPCw5raBVB5QwpF3m7tTz?=
 =?us-ascii?Q?YthxfEThxARiE3hc5uGhRVfwt0z4GHBv3wsCYFD6L2gXHpib/YMV/3RYfRBw?=
 =?us-ascii?Q?XeB/iTuYfUR26rKfwB+dtfW/DdiRhOe5MeWsBN4+jz+320EFC9jV6fXd9hpo?=
 =?us-ascii?Q?Rj2Bvklax7cpg66p7McqDBvdePEby+5rnsFWCF4m13p4ionGKzu0A43C7766?=
 =?us-ascii?Q?J5DBrhYFZ1ks0SbFL8TjmXxUDhPHnVpDPMwstQaU8WWZfoFZ1y3ZejE8LEED?=
 =?us-ascii?Q?PPwJj7uJGJeLJbZqDNWqR5piwPwgZk0TIEZJjer7KAJZzVg2gCWdtpEwEp3w?=
 =?us-ascii?Q?naTePiOfc062JArOrrQgVAMvmLzD3VWLpgatYy/nB5ERx/2iTyA80sT0Vztg?=
 =?us-ascii?Q?f6ypoGMfU9nAxWo1mH5HHUhcZsO7cejFySIIO/RhKMEpU0wJ6ChjZO1oFqs+?=
 =?us-ascii?Q?eS6i27QdcV7pOjnX+p36/Pm31QNANlnZWj5fWdGpzCNVtGZFnSSFUF29/E2M?=
 =?us-ascii?Q?82Zzoki2q1y8TPaA5s9HZDMtqlLhXIA4rVM4OaVptywY+D+ThCD0crs/D1Bl?=
 =?us-ascii?Q?/Y8FdzY5YeCES5g5d2ynDkKQYuAsSFYcFTLRu5d47F+HQEsQGOrbtAo2KIHt?=
 =?us-ascii?Q?K0nAyydgez2BD/tSwMabJCCUEo6ve2wbrIQNYQGkORgh9zdJ39FfAg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kNZmHb1ZsDBtPZEuitB59M9k0nltntPHHiaW3NK1qS/UTbmKiaQXXYu+J/n1?=
 =?us-ascii?Q?Hi+hDoVu3BTsAcuxfEc7Ny912rUpG3SHz1gOU+9INqj81SbiCprh1bDk5iRk?=
 =?us-ascii?Q?NU0WfXotvgsl0fod+loKHO9TzgVkcgbiAXEG3FvtbwzMy1wOQtsg5+wmdWEC?=
 =?us-ascii?Q?v6U7fCdVd7sBv6EpxkzXGDWFqC8A97B1ago0peLSIztTSSZlQU5WHcWGmX0f?=
 =?us-ascii?Q?34Q55ag2BYo5z7YuTCzmzpy5gE/eovGK9hHZSL8QMlKYhKfGwFUV0V0O6d8x?=
 =?us-ascii?Q?qXncvJI/17NrertvpTdawsY22J/oM+YUVu0olsS/veJNHE4owJMzHHEauCCX?=
 =?us-ascii?Q?8bmdzciYlc016XwdMLCOOWfzwpscUIfgmE59Jj63veDAg8BfQqfrPE09Qujj?=
 =?us-ascii?Q?Mx7oEWGLQq+ubRyrApszXq/nJQzVE1RICglfVDub9Xqnia1vc/j2UiUAvke2?=
 =?us-ascii?Q?huWn+44WoqHevry5/sHHp4YQFd9nVfi+BBwtouTaI7JU48lAcZwECfHaoNYW?=
 =?us-ascii?Q?MRU0AuYQCeNytWM1yS9z0ZR02QUVo1Mkm/dbqrhz0mxGOm86L+bQUWTCR4nl?=
 =?us-ascii?Q?j4kp4PCK1Kpd8Yip9XjBPmlacRMmxyVMzIUwQOT5Xf8XcrdO203WgAsVDDI4?=
 =?us-ascii?Q?RqpUo0JwHpWk3LzgFbMmeETJ0cB/cVOTZpZMEIfoqEkN3nZ3muEdMV3mRqL3?=
 =?us-ascii?Q?ff5IYH+1dDNM1Tj7TdV1oP/w9siBwb7lFyn0uOZwEULIKoKC96ogZbC6qhmr?=
 =?us-ascii?Q?SXjlC+WKN2gOins7+3TcBXIZewRUe8s4mhI7ixd4dApdwzcm+63X4Ltt0ALY?=
 =?us-ascii?Q?CTrj+h/twxedEnb/uH5JSZT8Mk4F/LKeR/ouk9cuXPITO9zvxuyXq1Vx/nWf?=
 =?us-ascii?Q?llkQpDZYlTo3Lzn3XNaAyxNd03Vd/ZcleBccb/b7H5kATnQ1wHSMMbkEugw3?=
 =?us-ascii?Q?HR6iZkPzrQpo3AU0j9YS986PXG85OvppMSFXWwOY4wQdGUpVMTpqef+ehg68?=
 =?us-ascii?Q?V+P51pKYfHHeRPYr5NSKh673jz96ZFMNGT52AkPFBnDbiQ1jRohYuojvozZS?=
 =?us-ascii?Q?tKOGC6GoGB33Xard4Swr/bqG1EZ6ZOV+AVU55vptiQqYkbhVSYXzaQ+mCCT9?=
 =?us-ascii?Q?yFcVTixWMWtowAqtqjnkYu81EVwKIVW0DUZbcnD1kt1piqYPly5V84hNvwpu?=
 =?us-ascii?Q?VN9wDnm88aROnoA/35/IMkbPmtvDWwv87c2KQzz4LRrGF0LocLgY6MyEOe0G?=
 =?us-ascii?Q?uXqEydSwTtqltK/N1k3pW5kpVy13vyOkx5ROvQqR6xYdbeTDHKrDVvEJu3xk?=
 =?us-ascii?Q?h+4s1NR5ClUtSs7+UI3AdDckLv0+xSbBh+WtJUgTk+qCF5X2FD2MuJiLwJoC?=
 =?us-ascii?Q?SgiQMdfp56G8kpTSRtvyEwv3LJk7wSbR86l+zi2F18QWeVSmEMXIsHLz0M3l?=
 =?us-ascii?Q?YLFWPf44Twdzj03PKFSwVcqpzCredF7kq81M1gfeYE+3N/RdDyuQmIM2ZfDl?=
 =?us-ascii?Q?VQdO1ZeVS6p1ii9gsh+CsOrplQTm+rQ9t5wxXeMEv2LNBfcR5yUcUbv4qdKJ?=
 =?us-ascii?Q?R/9zbM7MduDifey1IaljOeNIOmZVg/lWzGNs057JuJLIvTIDw8OEUJ1ZYr3K?=
 =?us-ascii?Q?pXYSnxQgfIJMugV76kZ6Y9Y=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a11b9d-0ef7-4102-fee9-08ddbecaf3cc
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 09:28:24.1478 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XwsjUbd1/C/d1KJkP9HjD9R1nwnZ4+ilCEpdOhoyTqXW9AXrFiso0xJ8dAm/T44rQb2KDRGpMZI96H/JCddVPiGX7N4DhHYSPVUrRTWkhgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10805
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

Transmission of short packets does not work good for XFI (GDM2) and
HSGMII (GDM3) interfaces. The issue can be solved with:

 - padding of short packets to 60 bytes
 - setting of PAD_EN bit in the corresponding REG_GDM_FWD_CFG(n)
   register.

The issue should present for the lan switch (GDM1) as well, but it does
does not appear due to unknown reason.

This patch set PAD_EN bit for the used GDM.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha_eth.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index 477a132fb1f..6588eb3a806 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -97,6 +97,7 @@
 	 (_n) == 2 ? GDM2_BASE : GDM1_BASE)
 
 #define REG_GDM_FWD_CFG(_n)		GDM_BASE(_n)
+#define GDM_PAD_EN			BIT(28)
 #define GDM_DROP_CRC_ERR		BIT(23)
 #define GDM_IP4_CKSUM			BIT(22)
 #define GDM_TCP_CKSUM			BIT(21)
@@ -380,8 +381,11 @@ static void airoha_fe_maccr_init(struct airoha_eth *eth)
 	int p;
 
 	for (p = 1; p <= ARRAY_SIZE(eth->ports); p++) {
-		/* Disable any kind of CRC drop or offload */
-		airoha_fe_wr(eth, REG_GDM_FWD_CFG(p), 0);
+		/*
+		 * Disable any kind of CRC drop or offload.
+		 * Enable padding of short TX packets to 60 bytes.
+		 */
+		airoha_fe_wr(eth, REG_GDM_FWD_CFG(p), GDM_PAD_EN);
 	}
 }
 
@@ -830,6 +834,11 @@ static int airoha_eth_send(struct udevice *dev, void *packet, int length)
 	u32 val;
 	int i;
 
+	/*
+	 * There is no need to pad short TX packets to 60 bytes since the
+	 * GDM_PAD_EN bit set in the corresponding REG_GDM_FWD_CFG(n) register.
+	 */
+
 	dma_addr = dma_map_single(packet, length, DMA_TO_DEVICE);
 
 	qid = 0;
-- 
2.47.2

