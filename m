Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D287C83F03
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 09:28:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEDE483439;
	Wed,  9 Jul 2025 11:28:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="y4qZzhEw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 625F383457; Wed,  9 Jul 2025 11:28:27 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50FDA83443
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 11:28:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lxRkLWi7PCcD16ViCAPa507PrMchU3kSIdEcQkQseYzeTqe5NgmA7r2NPVF4aQi6PRSLhdw056W+qMkPMD6PA5qiDe2tBpActZt7kTZ3W4b5qymRKcpyaeGiLltI/D4SwrH5Dj5k3fhmzYbAy7/Sf+cMkG4mGtUv3WC0T3Mung8cZYs0vJfMygvXQqOzFn06vJe8oI2TldX0/0ACo5TXSbBZTNKOIMCP33p/0Jf/2yZ2pFRpJQ9n6wZCpxeZ+7C+E+VmHyO/bcRY9CPtauzwY4QXDtIG09sMPaRUcqDgcRvKAw6bAEAoURadLYnJECN7lrg25J7oq6MHJMMkhPXC8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dftr2h0gMOf7AiuJ8OPn5wN/504dpbyfzFMbYkI9TUA=;
 b=WA0ZcQthrI/PISraI9DhVoZxpo8tqMHhMswPCD8t/hOLoH6qed8Br/+1iJ/CjGOpNLnb8GTIzM/x69ibzSk8VlXVVrnIAcl7rDxQ9zel0yreVV49PiqOUJ0NulGP5I6TgvIlt0INBLIrEYZhXAjOhvc7liecrtWuR+vK+tea13wAYbvzKtYW1zFb1IZ1hgVwVhxvINQrq+8bO+972raGVwmRkrSStCJWs6/yzjtjBFZez4coEpKWme4GCO7CHHwaMq15hFJpmNK+ov16NoRHJ6sjMx2ItFvvuYJmjrp4xmZ3pyltbCEBJOn+ZhIj2YvTfubrnjgQWyjiJSVlT6X5Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dftr2h0gMOf7AiuJ8OPn5wN/504dpbyfzFMbYkI9TUA=;
 b=y4qZzhEwR5Mbf1JpWrGI5tApvjnnlP0yCNpzuJ0HfhlP6oXLTTkqNEo/tjbJ/2VVxjJF0v1lumaC/CBxrguFMCxjqtCmV8JiI1cC9umNhokqoAX+VpEURaPMycT35xigj9mgnYDkcU+WujBrL0sCPGfhpJCnUxzW6mzo5K3qRfuUKnaPGA/WFcGSvwIptbYf4rompcv9joU6OJIB6kmSlaljsKK3BDF8oaCg141ZAVrwYYdI7bd321lqtO47vJb7TyqHXkanw6tSGrCK5quG4n64nGBmLhRc1RFmRQbdevdU3oKt6NDhLmoskZ16nVlVj915NyUpiCbkbeoLxONnGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV1PR08MB10805.eurprd08.prod.outlook.com (2603:10a6:150:164::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 09:28:22 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8901.023; Wed, 9 Jul 2025
 09:28:22 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH RESEND v4 2/4] drivers/net/airoha_eth: fix packet transmission
 errors
Date: Wed,  9 Jul 2025 12:28:08 +0300
Message-ID: <20250709092810.4032971-3-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 0149dc82-e4f4-4b7d-a99e-08ddbecaf27d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+MT/ZNb5bVcyyhnvzXJREnFAaIUmywHY/CCD3GV0GByEi3/N1UuQvObJj6qm?=
 =?us-ascii?Q?gfDqr0vZXsq/Q68+PHVLG1z2lCxgZQRUhU4K7W837o+u1bGFF2+jt7+dHvwb?=
 =?us-ascii?Q?J+gW0hlN4jfonWJQh6HKviMeGtDd0nlLHt9XC5qrm1bemmc17Li+kU0WL7J5?=
 =?us-ascii?Q?SgAMRG+z7GHSw3tABbV5KwcjkrMhpADx+E6WBibi0ARuDIXs0FkqB4NrPdFp?=
 =?us-ascii?Q?Hgv6+evsv77ne3e7RnlD5uOztSipMx+OouuWEfbmvLDpatK48OkCJUaqjWkW?=
 =?us-ascii?Q?xq+dFaDsw5NP8XT3BySohrVULp+cz2vd34DoGrqK0oApwq68bmfoU60sxpTy?=
 =?us-ascii?Q?5ECGQoKzODZTGPP+obg5k0Vii2/n8yagXr++hFUTeMPC4G/sjo9H8Yb5HKvj?=
 =?us-ascii?Q?/KIjfmq8+MDG/Px0LyahWF4KNNnONvqjhDKXEgu4+hAv830HJLzZBZeahn61?=
 =?us-ascii?Q?uYwMxcvm20CoILlZlrP3DIUeIxyK9EtP5ZMis+6Cmx4EDuw+FzTlHIsshAez?=
 =?us-ascii?Q?t0WhgRy4ABC+tkSnqoJk+O3gkPWfUoko3dbf2bxJk+WCr1H/6418eprRwshE?=
 =?us-ascii?Q?uyi/NMq9JK4whEkFai8OnOfGheBMwZvgombKpXWhmOZZt1f20jR/4b7YAwvz?=
 =?us-ascii?Q?DVtO6htkzPOjamwI1Io48q9PXnT90JLcujonmaEic2J2syQ18URhTO3paIDF?=
 =?us-ascii?Q?qo3272uDyENVtV0GsaEjoYPvdlnlraqisSPjYqDOMG4e8bC/QBYx6eVs8Fq4?=
 =?us-ascii?Q?VbXbmCbe1E8kKhKROL0A4unlI/qDzy1U/kB6aQlkQIZlM4GbL9D64GpTeSPb?=
 =?us-ascii?Q?o2gk+GYNz508LzEZYB3wmFB4Ol2LwZBLVzHsroBuSp56y7PHZbAir2DWXPSj?=
 =?us-ascii?Q?QvS5N2Ca0jOxYhMWBwd1VJcp5pR/2+LSKwmnBybOMuoFizICu6T779oxhFhE?=
 =?us-ascii?Q?AA4Ge6Of9+fZ6RBzrtrfgG24JNamxgP+qGLNncT7tQHnM070viq1kujcolQw?=
 =?us-ascii?Q?nHQlVY3fP0007cvMrYXjgooKNhWL62UvpdNsV/QewposYSQYGwagS1Iiz87x?=
 =?us-ascii?Q?RgXxSLHZM6cMHf3dHW2wu8WOGyvMsHnTi2f5nS7UVBWmSFcE9u6Mak/sw/f8?=
 =?us-ascii?Q?2UNGuxLozqtS4nPMvHiGFjkAwqQGE5qAh5AZuXGfhA+XhO5CAmTn9J0Cs4nX?=
 =?us-ascii?Q?DQPJqxegJvkjZAc2uCecmGNKuKLK2xQjDlDyqGe2olx6iGDHSPLVNzqNjbHi?=
 =?us-ascii?Q?HoD7jQY053EvRGI2q7ok1vlmX5tClD9SI1xFSuu3WPGCwVqUBdlt+cH5awPz?=
 =?us-ascii?Q?aRN4OX37Fe5JZlX8xRU5Zli6XxKvaye6uXKaeNirTKQQdHbU1gu4xiTzea1b?=
 =?us-ascii?Q?fwLz7+vZQ3rR5xFdQzMDeHVQD+yWzuxX0nYcSYmuLnLHRLmxahQxzHULc899?=
 =?us-ascii?Q?5AQA7r4Zu1YAU9cnwJ3dkbi0t1J/7Tebsm8dmP1q09o87QRARrVH5g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YW+QmGmvL5VjIRZxodFjmdB6HtUIT8dCS05AJAH2qL1o9uarIfKV8g+p8O1Y?=
 =?us-ascii?Q?w41YjRmWBhnSzrF0iNMfOB+WvQpmysBMRh+8pA5sRA5GAOyrZw7oLrjJqnVm?=
 =?us-ascii?Q?GDpyOfzUh5ypsxyhyEhiyHnq727Tzqo1w6DRycHKOisr5CljRnG3hMMib6v1?=
 =?us-ascii?Q?k9cKyhgiUye7muvWuT6UcjDO4Xhcs4LUn4BQ6R32GTIFM2QZ0+ZonW37IP9K?=
 =?us-ascii?Q?joj2dI2po0Gj0tTqViQC7pIExwq+uv3nYlNLluzTMkVoGfiOVnahri1E0ba3?=
 =?us-ascii?Q?aEVgfkaDxks3WcO8/miwhOPPBLAroL46a4AFf2sgoqUWuzrztv483Zo5nwal?=
 =?us-ascii?Q?kI1F293FLyQKOUTEx6YfBcQtalX7xfhFS3to+ncWAoSbvYtJJu8u8mP3ay7X?=
 =?us-ascii?Q?5242aj1Qw0+fvr0NIG/5efrOR3KlIj9oopoGvZrocchBxUuWNCDmitSVT/co?=
 =?us-ascii?Q?YQIFJcWbcM4aMhWPy8rEG1xMlgHXpBW9o8ifevUawKGEfe/1huqGyG3ZzlF4?=
 =?us-ascii?Q?irf+VQiClHZNZ5syzpw9lhl34BvBIzWkEkiDUEuYkVG56KqrrR2SUz4D0qy5?=
 =?us-ascii?Q?zpq53pD87soS0DJJyo2feQC09l6Yx7C2GAegeSTaNNWlZKe9Ot11zQqAPBuB?=
 =?us-ascii?Q?XBArbO0uemas7keIEDQHz5xSDw4JRd0kWFmPokPpA5CG0J83/2kXi8I7zd5q?=
 =?us-ascii?Q?+g9/iP3RElnulaUVB19kqKF+7xeYv2t8Mpl9NPpuPG01LAmB0sejwzomcHTs?=
 =?us-ascii?Q?nvxLJ59nVOsT9X7IO71k8fV38nUKAt6vdHNg2TbZ4bmmthjfLArvatk9eDhC?=
 =?us-ascii?Q?JwD+noU/nayGht1Xfnn3YuuqUIf9XjPYXTlYqoT6nce9TzaInfEd2NEoYCzf?=
 =?us-ascii?Q?+QmX9uG0/9ncRgNt3lwmb4QfQWPlKKArrEqJyQAZnWL9vfi7a13PxdUGPgVO?=
 =?us-ascii?Q?oq2wBrQWEk0jHLN8ochKAfurWcunxogGmMVfTIBQSmd2jT9bsxhi483nCQga?=
 =?us-ascii?Q?W1JKsdV67xnRa3xxTSB0S5CoSjvqvRMtlnh1mzV9L393hLCuidwTyguepmUm?=
 =?us-ascii?Q?BATXI/CqiudbZUncH/ilVgfg/PMsBmEmXV1AxTU/4hyfw4GZiR6AGMX/wYs4?=
 =?us-ascii?Q?wx7l/84yHG9g+L+d+wvghWPNfRV6AqqbK8YKDL7rYzdOanIx13XEVtC5wWG0?=
 =?us-ascii?Q?DPXG/1XIh+BNMc+ShtKCS1/cqk7kW+/uKmqlxbR6UFUSyAj77Di2UboJebPU?=
 =?us-ascii?Q?J2NqCA9ip4CBIvg+qPHRFedRl4jUDLTlfk7RICMmpFvVX+Qi5l9A1YLiZwjc?=
 =?us-ascii?Q?WC7/8e30DoIdzUaT3yFdXq+hK19d3GqAG/GdMEwCWDvrBuw6p4LhxjtbVFbg?=
 =?us-ascii?Q?FcYqvf/t6bWyluYIrUiNJo70+bV/hufN9dQ+Eq3L2z6/dSOdozbe5XdvkV7Y?=
 =?us-ascii?Q?Cl+43NmrvRZKFt7Rtr4bhe6OfSWJoqVkhT2E8YPqG+kwo/KAqiZI3rFnDeIY?=
 =?us-ascii?Q?pnxQ0/tj5vU7wkacllRk4sqQHuZp5Tmv+cGRdkT1XTfXLU82phGiOglmAGnW?=
 =?us-ascii?Q?bXnr4sPwcd1EwOPptJZsUHxShi5lC+7Ft5o4xBQioFZfcqX+MwJQ2VGcXXnC?=
 =?us-ascii?Q?t+O0Wp3CmxVZk3D1uze6jCM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0149dc82-e4f4-4b7d-a99e-08ddbecaf27d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 09:28:21.9785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K96vqXUi61PpXgVucTtXAVzgueyKmhcM8q7r1TLHQhvuFU1MydjHME3l/D/6qLhscrosk3yKpp2oeRqBjrsE6Dg9FEMeUg5XOLBzWjq2A5A=
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

The dma_map_single() function calls one of the functions
  * invalidate_dcache_range(),
  * flush_dcache_range().
Both of them expect that 'vaddr' is aligned to the ARCH_DMA_MINALIGN
boundary. Unfortunately, RX/TX descriptors are 32-byte long. Thus they
might not be aligned to the ARCH_DMA_MINALIGN boundary. Data flushing
(or invalidating) might do nothing in this case.

The same applies to dma_unmap_single() function.

In the TX path case the issue might prevent package transmission (filled
TX descriptor was not flushed).

To fix an issue a special wrappers for
  * dma_map_single(),
  * dma_unmap_single()
functions were created. The patch fix flushing/invalidatiog for the
RX path as well.

The bug appears on 32-bit airoha platform, but should be present on
64-bit as well.

The code was tested both on 32-bit and 64-bit airoha boards.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha_eth.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index 2aa42b3d727..e18816b2943 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -354,6 +354,27 @@ static u32 airoha_rmw(void __iomem *base, u32 offset, u32 mask, u32 val)
 #define airoha_switch_wr(eth, offset, val)			\
 	airoha_wr((eth)->switch_regs, (offset), (val))
 
+static inline dma_addr_t dma_map_unaligned(void *vaddr, size_t len,
+					   enum dma_data_direction dir)
+{
+	uintptr_t start, end;
+
+	start = ALIGN_DOWN((uintptr_t)vaddr, ARCH_DMA_MINALIGN);
+	end = ALIGN((uintptr_t)(vaddr + len), ARCH_DMA_MINALIGN);
+
+	return dma_map_single((void *)start, end - start, dir);
+}
+
+static inline void dma_unmap_unaligned(dma_addr_t addr, size_t len,
+				       enum dma_data_direction dir)
+{
+	uintptr_t start, end;
+
+	start = ALIGN_DOWN((uintptr_t)addr, ARCH_DMA_MINALIGN);
+	end = ALIGN((uintptr_t)(addr + len), ARCH_DMA_MINALIGN);
+	dma_unmap_single(start, end - start, dir);
+}
+
 static void airoha_fe_maccr_init(struct airoha_eth *eth)
 {
 	int p;
@@ -391,7 +412,7 @@ static void airoha_qdma_reset_rx_desc(struct airoha_queue *q, int index,
 	val = FIELD_PREP(QDMA_DESC_LEN_MASK, PKTSIZE_ALIGN);
 	WRITE_ONCE(desc->ctrl, cpu_to_le32(val));
 
-	dma_map_single(desc, sizeof(*desc), DMA_TO_DEVICE);
+	dma_map_unaligned(desc, sizeof(*desc), DMA_TO_DEVICE);
 }
 
 static void airoha_qdma_init_rx_desc(struct airoha_queue *q)
@@ -826,14 +847,14 @@ static int airoha_eth_send(struct udevice *dev, void *packet, int length)
 	WRITE_ONCE(desc->msg1, cpu_to_le32(msg1));
 	WRITE_ONCE(desc->msg2, cpu_to_le32(0xffff));
 
-	dma_map_single(desc, sizeof(*desc), DMA_TO_DEVICE);
+	dma_map_unaligned(desc, sizeof(*desc), DMA_TO_DEVICE);
 
 	airoha_qdma_rmw(qdma, REG_TX_CPU_IDX(qid), TX_RING_CPU_IDX_MASK,
 			FIELD_PREP(TX_RING_CPU_IDX_MASK, index));
 
 	for (i = 0; i < 100; i++) {
-		dma_unmap_single(virt_to_phys(desc), sizeof(*desc),
-				 DMA_FROM_DEVICE);
+		dma_unmap_unaligned(virt_to_phys(desc), sizeof(*desc),
+				    DMA_FROM_DEVICE);
 		if (desc->ctrl & QDMA_DESC_DONE_MASK)
 			break;
 
@@ -864,8 +885,8 @@ static int airoha_eth_recv(struct udevice *dev, int flags, uchar **packetp)
 	q = &qdma->q_rx[qid];
 	desc = &q->desc[q->head];
 
-	dma_unmap_single(virt_to_phys(desc), sizeof(*desc),
-			 DMA_FROM_DEVICE);
+	dma_unmap_unaligned(virt_to_phys(desc), sizeof(*desc),
+			    DMA_FROM_DEVICE);
 
 	if (!(desc->ctrl & QDMA_DESC_DONE_MASK))
 		return -EAGAIN;
-- 
2.47.2

