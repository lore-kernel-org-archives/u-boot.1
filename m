Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB57C3ABC0
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 12:13:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50822822D7;
	Wed,  7 May 2025 14:13:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Lg1pthZF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8192982163; Wed,  7 May 2025 14:12:58 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::624])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE4128215B
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 14:12:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqjpISYngO4oLDm/YOEYkXVjtYEqyUl2fvlxfVgmlCOh5DVy8VXL8CzPpxtTqnVk9zdaI703guieybzoQjMOIt2uwheB/M+DEm6hxkAkwDmASR1F1kB/qw+//jRS1GOxLJR6MNF/75l3jklDuCc4hki0X/Ut6nH686U+ozc+uGMPWdLbPdgEaf3Sd+SR83xrk8SmGr3KwTDao7X9K0N/hgpQykhN+TrNtM7m1JDzCNUNkJEwmMU57GCuKGRySjdYhS6YKV8gahOJvb3A67lpwS+vWmoTe8OvxHnhgOJsgtLMVhU+X4D/2i4C1JPZC3YTOYBequpkuCMpObSNBDYXcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8dJhdQdZ6OM2ykUDPxDhmT/ET2ThtVMZGLHn6IFUyuk=;
 b=V7bDdE5ZT/cqxBmr8WfzviHBzelFMF4qWXTUZe3IGR0dPr174EKyvPYPu28GMxOiXSZgTHNt3ZqMDBPrHiXucv2rBzdNjWkD7Dp9KLP4c4ZkBgG8WnRhFTeYWt+ZqNbK9+VTjfeLqedBpWOD/lSKwuhb7BQwUf3dgYcMeUhOTGC5ETeT1s1jzYH4l2AaU9fGBQHS1ucwYfKtA7htRedlNKPPwgJQzP9CuwGXTKo0xB23+ZPvof0pkgAXrXia8aOgSmZsCvzKLpqH6nY4gDKA3tstXpViEYGOfWFER5/51MzQEZBztagx/1SrtltqskJQpKaeJ/qmLfDhKVEISdnnYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dJhdQdZ6OM2ykUDPxDhmT/ET2ThtVMZGLHn6IFUyuk=;
 b=Lg1pthZFRsLY0IvLJ3eLg9KSAYWCK+hgVN0b9FoWnR8CR8xSq8NdKT54BzAfs7Vruy12b+R4XvdOYmivEVaw5silLod/EtODC9xKmKDurxAnpJf4OHsmvzl6DgK5qSDrJIes5kOmPZ0Fr3VhArLBZ9EJtcr1NXTY5s6KatzMEik=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AS4PR10MB6014.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:51d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.38; Wed, 7 May
 2025 12:12:52 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%5]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 12:12:52 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 2/4] treewide: drop no-op prefetch() calls
Date: Wed,  7 May 2025 14:12:44 +0200
Message-ID: <20250507121246.518691-3-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507121246.518691-1-ravi@prevas.dk>
References: <20250507121246.518691-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0051.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::35) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AS4PR10MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: 67efc416-cdd7-49b9-1501-08dd8d607d76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s/ggw1rviRRevm73Ty+SkX1m5bLsLZCrMq7LwIDCNyjQWhmcm2iknxFzIKQC?=
 =?us-ascii?Q?ldI72WvnCLsxivOsxWUNsRcd0QxcY9Ga2ZclsgOUSV1PRViY1vE3pIgDiULJ?=
 =?us-ascii?Q?nl2yJT/khBDeIM1ikXzJyvzsYAiRwZJij9w62quFdvfdkJoEw480ZpuIdad1?=
 =?us-ascii?Q?ZD6MG33AJ9Fn60JxzpDcQ8B4dyuk3AwoIq4yU/gZ8CZwGPQ7gDlLODwJAE1A?=
 =?us-ascii?Q?Gcfq7tdQ939lXJl2iqa3ZTw6xIxcMi7L5RyGggTYnVqqdHtWL/YpS8QcyNoS?=
 =?us-ascii?Q?ap3nPPxL2L0PCFKdmcfUJirfoaq9ql3F7/XszKHAr505dJdt6G+XRjVgT2Sr?=
 =?us-ascii?Q?OWLmyXKAX4KZW4Y+II+IJcJVN9Nud/J9dnQCRRlGTaNU9/UpNX2007gTu5dC?=
 =?us-ascii?Q?f/RgNazyv4I/z0wYbrr/lcGPdkWgeeVAUeuWMEi8BMHOMhykd/PVg+cT5T1S?=
 =?us-ascii?Q?Yf71/hd/wB3sUAfM7lobigx/BqM9lISBGLef10DKVBobxXJUdMuBbOhR5D6p?=
 =?us-ascii?Q?mU/EQ5cDtzolFg+HPSXOXMfAq42rDqpGcpPTy6z2f+0yashyAKKD0IxXiCbP?=
 =?us-ascii?Q?dWB2x163Q00mJDk5N6Cp2wXQteYhpf0tFkaHzddH/5Qo0zGbkPAQ0JkK7qCX?=
 =?us-ascii?Q?05VShcAZlo2fbig99E9m1u21VmPuFaAoX9In6JHVTIptMnsQFOA2wHXhw5Bx?=
 =?us-ascii?Q?8CXHgmlbESMqErJ11DUSQxm/RK40Kso3Jjk5DOsGELJaAv9iypx4yTM7Xkve?=
 =?us-ascii?Q?bGz5xWDlVc5lVuW/BFpnBcb/fm+XyVyyHmEJAU6ApX3vvQgxlBMpC442Cphi?=
 =?us-ascii?Q?uWfY6dEsUNbraZE/eoJkK4OrVrOo1jAiiN6eodhURle86173vPkzGKYluPzn?=
 =?us-ascii?Q?BhU4bJwh+j6+9FuIBom443iGJZLWL5MTy03ReLtfN2/WrZodR1BzRfOoG1wt?=
 =?us-ascii?Q?Z4J4mNYZOQBxeDWMkbFaIalTfq/T97SgdxtZihBQ6dBPHvv+uDeRGS2sO+MD?=
 =?us-ascii?Q?tEcaLQtH0lyPZkYZsL6KPIta51bbWKLQ04GjWn8jK7kyLs3IlZTFdgOKMPT2?=
 =?us-ascii?Q?7AvoGCbLQfONCecfUwzcu7n04CCmJYCZEJtAKKddtP2l4/cicGfb8VzNbRuK?=
 =?us-ascii?Q?aBWmaoRSZ1bNTm3nscJZIMoWh1ajnOxPlJBD5MEQ4iSK7iK+0pLZm31LvWRT?=
 =?us-ascii?Q?v2fCdV3JxMKesL8fdJMjOXEHiyqkjYJCk82ZkoX/iuU82glnxjeWssxAMws5?=
 =?us-ascii?Q?GEJQSPbU5xCDxDIftBVe/bCZ+jIjRgzU5WsgakervVwSYWz4aIBa3QnFyx7A?=
 =?us-ascii?Q?tmF0+0RFsCQ1aGzK+t2hePC1y0m6cyOiIIP6dj79To+TnvwyOH/xL1/JaR4m?=
 =?us-ascii?Q?u1KtKnvVQGXQpCRH/xMvVi7qm3kSsQ90BOkjOC2jPimZ6/qKx70B6pRvUCNu?=
 =?us-ascii?Q?PGJCvg+QRjlPfjvdJeezNFXfclPkFQxEZhQvhjtvqZCkN4G95u+o1w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6Gxm6ik0cr55vXCoOBcBAYYiLV5Apamy4sLNhnARYi5NmqKv2SezcfEbKCno?=
 =?us-ascii?Q?Lp5dRrs6XzQN59WkYEH4SOg/UD/+QulmzkuoNGvvLvM4N/Amepe5R1TByuPG?=
 =?us-ascii?Q?tahv8N/PbkbGXj9zXfn7lnFsXrBEdfe0N/vmRpSLqC8o08yeBFl+475HYnpd?=
 =?us-ascii?Q?5ZYYPQhGsVlSch0CmqBhVkRaNrcdilAX1D0eAPE7Jx/YRY8sL4DBHC/BoCB3?=
 =?us-ascii?Q?u7HLpEzGmei5FSBsrwDYg0RKaNa22jZbGlj11xl2vJ1NwJeu1qmj0vWSJURx?=
 =?us-ascii?Q?28Nw5g5tgy9kmBiNWMr7AhEuIZNOuHTFVpOJO9fMaJvw4GCe7TYMEH9M/z2y?=
 =?us-ascii?Q?Pf9ogvEuhBMuRdGu844SLMAUkh1azYeF3RT5rT/YJvm2Ae0qFE5/ahs+ic0W?=
 =?us-ascii?Q?u4UanW7AOnGyOUbdQM/rGCIedl8dB5mIwgq+O4GsFBjBbf+jEvZJWFVRtP1X?=
 =?us-ascii?Q?p6H3uNINMf4wO8DG6xhsZZeIU6CRE7xYAlIfsWtjC3wx+4b1NuOSvJJT85tb?=
 =?us-ascii?Q?3c2X/4yINToAwY2EE+3EWa/6yRGd/52CaRg+OkLbIi+2KwCuaXq5P50goICQ?=
 =?us-ascii?Q?3I9gdND39WR5VHaU75mPAXCpFNqUfEQVsc1r4rzbWX7qTjjDZtBwUqLl9BWT?=
 =?us-ascii?Q?EHOipm98zwXGLD8rDJDpLqj8sUykoCjIrnL2sjM0L5jgoKc2thta60A34bw2?=
 =?us-ascii?Q?IaPQhKmLDGFWsVBFF+E7taW1qGCtvURd5E3zJqIhniDrg1Tittpr53UUtlcq?=
 =?us-ascii?Q?KQTs0wY8hF+fvfoO3bKG++TN7Dr8/2c2f5Sm1qPlrP/BN0qlpMRFWFR927U6?=
 =?us-ascii?Q?evVe0T/KvemtEqTghFeook7DibfjmrARIuDlmb2KwA0kdaFmhytiYVEH4znV?=
 =?us-ascii?Q?aVf7DzBs6R0+VsnDzLgXZ1uOHSSG0xvm0JbCxQY6wLqmfszbJP3wc/gw+yxw?=
 =?us-ascii?Q?AZ8Giy6zgyVncXivEgGEh3aRuj8IrBbiYtaaL1nxw3W5UO8I1SfsXHivf/7H?=
 =?us-ascii?Q?+o2JuDkyJjr6Btk9oVvEc9H8M6tNy61RSjpaO5M48Iv/vR9Wi9YVVtP2KYOA?=
 =?us-ascii?Q?qEde1osXA4NeKWOgv8Y0A/h22iNsLuI51IqGzqvW0YbtonZECV87o3125QJa?=
 =?us-ascii?Q?yKr1PMcgs0Sj9AKVrttGNlcQazH709pGhMWSGu4iJh8RNB421mb2kkjN0z2U?=
 =?us-ascii?Q?dUKiuV82XqrAH0p6+exn0OkwwOMFzTCsA4JTdvzebxoPRPO2Y1+V5/9ivnkN?=
 =?us-ascii?Q?8nxOrTkCH4rp9fWB2euAj0/Wk5R3CyeuVPdP8xnY2dPsVjOfRaBfo3XXSFF2?=
 =?us-ascii?Q?S9yIyXI2W9eJ6vk2u0hYvOdaZgs07mc/y87K+KGy7jhyoZkCNoGs5cKxMu5Q?=
 =?us-ascii?Q?oSzQgiF6vJqKNBh4B3z0Jxus804KMDbyDhkCiaLElAzGYSEV1J8HXJhZaN9c?=
 =?us-ascii?Q?f0Wa0/wpIiDq2t8LVEpI4NO7U+o+4txnF41EiP7qN09bcNNaOk+agFWzxrjF?=
 =?us-ascii?Q?62TpwhpmfUArDpBv9bspkxj3eHiZbnnFpxn2VV8FmgCG8t5K+nwsEnpjVBn1?=
 =?us-ascii?Q?zBdQFpAxRMB7lZ7JmsFdTZmposfBv0F6UmP8J5NRdt50pcKsQHCqMBb2mfRB?=
 =?us-ascii?Q?bA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 67efc416-cdd7-49b9-1501-08dd8d607d76
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 12:12:51.9448 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w9/JCPotmTrQ6ajvvLxTnKM3bCwj/SkZ31zOHYqeDDrWiOMVHoDTK5nY80Er8beo13w12ADrMgJRgZcYbAh5SRcfkSWWVONYMgegf2A1V/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6014
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

These all end up using the no-op prefetch() defined in linux/list.h,
because the only possible real implementation is in
arch/mips/include/asm/processor.h, which is behing
CONFIG_CPU_HAS_PREFETCH which is nowhere defined.

In order to be able to drop that fallback definition from list.h,
first remove all uses.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 drivers/net/mvpp2.c               | 1 -
 drivers/net/octeontx/nicvf_main.c | 2 --
 drivers/usb/gadget/at91_udc.c     | 1 -
 drivers/usb/musb-new/musb_core.c  | 2 --
 4 files changed, 6 deletions(-)

diff --git a/drivers/net/mvpp2.c b/drivers/net/mvpp2.c
index ae545fe229c..184c1f9a46a 100644
--- a/drivers/net/mvpp2.c
+++ b/drivers/net/mvpp2.c
@@ -3876,7 +3876,6 @@ mvpp2_rxq_next_desc_get(struct mvpp2_rx_queue *rxq)
 	int rx_desc = rxq->next_desc_to_proc;
 
 	rxq->next_desc_to_proc = MVPP2_QUEUE_NEXT_DESC(rxq, rx_desc);
-	prefetch(rxq->descs + rxq->next_desc_to_proc);
 	return rxq->descs + rx_desc;
 }
 
diff --git a/drivers/net/octeontx/nicvf_main.c b/drivers/net/octeontx/nicvf_main.c
index 6e4d0a05121..27d0327c88a 100644
--- a/drivers/net/octeontx/nicvf_main.c
+++ b/drivers/net/octeontx/nicvf_main.c
@@ -279,8 +279,6 @@ int nicvf_cq_handler(struct nicvf *nic, void **ppkt, int *pkt_len)
 		cq_desc = (struct cqe_rx_t *)GET_CQ_DESC(cq, cqe_head);
 		cqe_head++;
 		cqe_head &= (cq->dmem.q_len - 1);
-		/* Initiate prefetch for next descriptor */
-		prefetch((struct cqe_rx_t *)GET_CQ_DESC(cq, cqe_head));
 
 		switch (cq_desc->cqe_type) {
 		case CQE_TYPE_RX:
diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
index 86b2cbf3f6a..b3c780a4e35 100644
--- a/drivers/usb/gadget/at91_udc.c
+++ b/drivers/usb/gadget/at91_udc.c
@@ -228,7 +228,6 @@ static int write_fifo(struct at91_ep *ep, struct at91_request *req)
 	}
 
 	buf = req->req.buf + req->req.actual;
-	prefetch(buf);
 	total = req->req.length - req->req.actual;
 	if (ep->ep.maxpacket < total) {
 		count = ep->ep.maxpacket;
diff --git a/drivers/usb/musb-new/musb_core.c b/drivers/usb/musb-new/musb_core.c
index 6375be741ae..a14b127dc37 100644
--- a/drivers/usb/musb-new/musb_core.c
+++ b/drivers/usb/musb-new/musb_core.c
@@ -223,8 +223,6 @@ void musb_write_fifo(struct musb_hw_ep *hw_ep, u16 len, const u8 *src)
 	struct musb *musb = hw_ep->musb;
 	void __iomem *fifo = hw_ep->fifo;
 
-	prefetch((u8 *)src);
-
 	dev_dbg(musb->controller, "%cX ep%d fifo %p count %d buf %p\n",
 			'T', hw_ep->epnum, fifo, len, src);
 
-- 
2.49.0

