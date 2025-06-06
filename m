Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BF2C61CE7
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 19:49:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 784E982A8D;
	Fri,  6 Jun 2025 21:49:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="fVe9a2zX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70AA382B07; Fri,  6 Jun 2025 21:49:18 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D330782A65
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 21:49:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HmFMVJq98r+oSJ3tD7uD8viwLiGN5u4LpXPIeXB45fXWa7x1hkWw7JBt/+9a1W0YPUUKZHfa+Bpt8cal/CZ5lXTQ43/D0+4JnTFm0lMBEOI6OgvLCY6wdZhbuXgufjnSduvOR4vqzzBdwfk6xHfAkNTjJVfp3wdu1oFwMPCxM1BOYAXpepaq1aVvbUdlu4r7rRQ/I8YPVmqcM2fW9XzrRrD68sFymSgiUGlV7Z25KpcJmaMzuUV4xqiJuoUSbRalFINrAIBd3Vt/c4bhHWnGIteQPJGxgaSYg7B3ppyNhnvIDccXG+D6OpD7ZXvLo9h/hwz8obZQmvUNDDwuyePDyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvefBjeCtU8gikCv18AnHTfB5aMLZftoz+kYi0HlkjY=;
 b=KHo44SthIswNG3DjxY6PAYEFtIV9X+/BOwgJf19YVpJ9YnYOCQSC+lp63yeYn9K2dWMr/WrpKIpJ/ekJiy5hwmKQRBKiEoFTiF8Qjp/hSOmaQwx3OUJpfKWNlcub9WBYZUQ9D0NAtNvFKPom0PfkmZA1IHQ45DIOPV6nwjFW2s0iuVzMCukJ3RDkR6SzHfoi4wlQ6ppxW6tEbF2gjR5OQE7g/vU6iOLzLh3WcYTZZZdvczYvtauLKusQrwoKXk6LqMsOA6lCypmEswV4Vvyhsg/kck618lTKo6SGT0lCDISCgOJ/CGc+5KZbYiJnJlA91+1lgqig3b0pKG5w+pTTdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvefBjeCtU8gikCv18AnHTfB5aMLZftoz+kYi0HlkjY=;
 b=fVe9a2zX5cp1nB5E9fCBjvVpUlTGHSzgorOVi9vSEgo+jpWawiKF1PGyTvMYIq/kFA1TCDSjFjq42PLi7W78ubkQWw6kAhSR4KkZsNg2PBkegZZzaXA1x6GXiK0No/BVwej2y42aeUfYJs0mfQMSWgNR7deBPzeNHdQu2pmqx0rhNeABTFRsc4l+UHQ60ZhxdxmtsXvJhKsJx84ldLctV7YhtbAFfAp77A8/xi0C4VlLYd3T972pznyiaftTTALQOEGtRkjECVgJ1e8xI4rNh+FQxa+zcoxEUpNF0UnPO1br+uq9aMBP4VWc9uPiuVpLcVnEogBt3ab/FEVEhNqW8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB8992.eurprd08.prod.outlook.com (2603:10a6:102:325::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.22; Fri, 6 Jun
 2025 19:49:13 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8769.037; Fri, 6 Jun 2025
 19:49:13 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 2/3] drivers/net/airoha_eth: fix packet transmission errors
Date: Fri,  6 Jun 2025 22:49:02 +0300
Message-ID: <20250606194903.459732-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250606194903.459732-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250606194903.459732-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00011B62.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:8:0:4) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAVPR08MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: 78c675ac-99ff-410c-47b6-08dda533364f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hy20nmuVdd7GPMDUfQOdJZy68tqGIBVLxTafdzAVf7lGYkbdut8DDO57ycaU?=
 =?us-ascii?Q?JVgSbHFICOuucPKyYhaBkb6G0LHhRG682ahz3bVIVJSo9QgIvpCcsO2941PK?=
 =?us-ascii?Q?T+XlTDw5Jfjr8hc3XdYjcqiplMM4fWxxMWf62SYKtE5PFHYUDIWAU9/qBKQx?=
 =?us-ascii?Q?EIGmZPm90jV48C22RGTSfp39LlmQCpdJsAu2ky88rcRESGjsuW38X89UFIOn?=
 =?us-ascii?Q?Grpgq4M+KBvWyak3OYKe4TE6TY4u7IFPY06Rl3u5l/axq2EwCQFzSCXJBZno?=
 =?us-ascii?Q?jT7ZhxwyNMGt/ls/+c6wpsPsJFw5lF1rT+nA8MBr7ouwXIXn39kjpeG76cTS?=
 =?us-ascii?Q?vO8hMlvK28YiP7nVEfgR3I3KsOOr78HRrXuwLjAxkG/1im0M+o+sjmZhiQn2?=
 =?us-ascii?Q?L3VASnYxT21s/stOcOuy19VnddbVe9VyqIw6dG3b7BzwDgw5EqvrnCY3/3r5?=
 =?us-ascii?Q?/2pAeJzHk7LEu7uExYKQBJgE/EOzcTYF8fOtD+4plFdGqw7RLYIw7U92TV4i?=
 =?us-ascii?Q?MdTiP/gjluJO4WJmWTr8yKSbNISMp6g8QdhEeLPvfHKkFsjHyU8xdO8iFSnX?=
 =?us-ascii?Q?XLKYUpLvaIr/OyPx225QiUX1jpTvCx93VpsAk3MuevaCNAEYxu5HYA/Hf/uk?=
 =?us-ascii?Q?/v5nifxV5vXQestvvwYeL7CHyhAJkxS8UjRpiysIzpGmULG3FC9u7a8vmnwe?=
 =?us-ascii?Q?kXxtV+QP1k+adBxBeXIqLqyxu3+HXkVqQhSS8AjI4S6qIGdRimmPMt1Io2kS?=
 =?us-ascii?Q?Pcpkl7QHrYMaUEFe+ueiBdiA+El3i8zObCuZ/AZ4yHNmOyUi2XygWhAtC8Tu?=
 =?us-ascii?Q?EwHFpbqcSQhyFncz+cUyN1TSKAMO9mNyiiQVExAJ6/wvAqcH5kwI4gwjYvNu?=
 =?us-ascii?Q?RLF0V+Ga4KHdgFGABbHsq35R+tYuZYy2vv80REhwqO+KBFWs3Uj5Vh2Xh4mw?=
 =?us-ascii?Q?zZD0wlbFc5lgw/mOIJ7iostAS5DinN0aAmBo/QSp1yqKaXDH8bsdWj9xtGZe?=
 =?us-ascii?Q?ko/TE/5aQkHJnU9/GxJWJtUEyPuEcaqhscERtTO0NgFTfNRIKjUtfzn9/9PB?=
 =?us-ascii?Q?eLmgC/UwWsblgc5n8XGIUgA+tGWeBWnnGlAFqaagQNi7w6o1JhBntdVDjjk0?=
 =?us-ascii?Q?UzIs9kQv85gox0bwJ2haN1ndnvVIQuO7Ao1rpZ24jZW64gZIWvSTmASMcyOa?=
 =?us-ascii?Q?x6YwIigxQDPN4D/mP+3Gf9miG8rMpmquNd5kkoBSrZZitfQW8yYzNFZno3Kj?=
 =?us-ascii?Q?SJ8s6t12Bup+IEzc5YsDKpW4XnzP8ST0dYOpZ6/X7Y2bexMho0zCh8EGBs5Q?=
 =?us-ascii?Q?jWZ4ZAhUT7OBvVJOiNJDFr617+2bOJBLj4S9oct88xf/P+439ZweA9GhxmTd?=
 =?us-ascii?Q?ry5+3V+e3+MKy4a3LtXRNUBfgS83Xp5MvPBIVoSeue27V3Ja717KPB9WSsMM?=
 =?us-ascii?Q?85YgqHrT+M93ytvuu37voPAdLZ/VMYhvMGbAhWQWNJtvEo+JjqK70g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TDXlQ1sawxxLM7i/dvxwyvcrJRaP/MJWcXLurHxRvdG0g1aXj9xGlL29aC8h?=
 =?us-ascii?Q?KfG8PKGx8e0aQRd4rgfftQsc3QVKV+oxDCfh797CNHZqAlQpldLQfbq2n+Wk?=
 =?us-ascii?Q?tfIv0h+DPT3dWNntC4zMecdqAL48yzoH8U+XDtr0YcdzGA+DH/he1EgimCkF?=
 =?us-ascii?Q?ZIgssWDR1l2fr4obzy37gn/JTCNKjdC1LGv+ohDAIzp2KmgMOw6V9AdpipZV?=
 =?us-ascii?Q?dNOu1pAPM06ZgWxf/xTZfd9vEzUwsa+PswZgXqpjC6vrAXQbm0s6vAIqlfcf?=
 =?us-ascii?Q?rVG2/QYHMgxLovQc0eYOuds3LvD+s8kRrlSHsUFSZ5z1E2BwkCdqYr1j7KW7?=
 =?us-ascii?Q?56cSL75cJnykkCr9zlywyg6aXWqZIL4L2b6ADeaxwlYW78Yzkv/TVhi2psZ4?=
 =?us-ascii?Q?99PAPVE+8iyaX3IDUVx5JSf88Nl/V7AJFCQB7QALpn7mruO5qdIxIk1bZw+r?=
 =?us-ascii?Q?KxHKVgN+vJCjVotiNbN7QxqGaJ7G0cxuPiReWfJCYaPTur5JL/hvAwWU1+h2?=
 =?us-ascii?Q?cTMDhqv13aD+FJ0Kse8szrhVPRkkMTjOrgGOpDtxWw7P6PM+jxmZcnotoQAl?=
 =?us-ascii?Q?IKJ4DjQ0Vg2jx1rI4v8e1Zt51GqlED8L+Wkj4cXHpWQjtR0B7O6jNiorbI2Z?=
 =?us-ascii?Q?z4OsOUBAj2DtiUR/HWOC7SkWYrbWJl4pJDa/a+qmO5QbJqPlHioT7LYLnFI8?=
 =?us-ascii?Q?mBoa3cnynChmjFLJVHRAGNzigYnY9hOaEUO8PBYQ3/i/F7NJpc4pFt+hveGG?=
 =?us-ascii?Q?AqwNmSdutyTrQuOcqhYM9rH21UVHeCWRHKOYwVuDDz5nF1Ow9OscPl76RwJh?=
 =?us-ascii?Q?Jqd83z/TyL8aP7FRATgCzM7Iihs5IaFE2ChoFNHyZIxQ/5uou/4x3jFzsYYE?=
 =?us-ascii?Q?ZAV+RP67XxLQvlZl0PafLMhkc50PsMVHw+AKaLFdkC9yHlTzcgXXNZY9fn6c?=
 =?us-ascii?Q?7FkQaKbjTuTaIUCTZ12TvUoCAORGlU4sjvrFxAHocMtKpp+qrrog9bKjfdOE?=
 =?us-ascii?Q?b8rj1IQ9ARmYH0Z4WwSoDUkA9Al3tVTGd+y/XdPBVD3VoqSwdToA/fHSQvhO?=
 =?us-ascii?Q?kZPaq06qNrNEtx+GrTaUz0uxk5RdpJY+gP4IFKJx5X3S+KGFv4nOz8a4BSRG?=
 =?us-ascii?Q?uDJ6mkwB0iZVqefDLtMa4c/DVypbKJfVvGOdNOTWsYBYoF2IFYppaPy29v64?=
 =?us-ascii?Q?zuGiy0xBJ8x3BRDkg1JeYNDqEd3XuRDZD7H6vN8o7owzyFrki4xSQ7+Olmz4?=
 =?us-ascii?Q?6plc70L6Zre/8yl1IhVJRRJ5dHsr1IAnEcnqpbRnhcSQb8NvojSQl03CBdlj?=
 =?us-ascii?Q?Dp4513ho1CH5sL2nY7PSjxW9Tjaaeoe+KlnAbDgQ6Ah4qm8vXRHP7n89/g6U?=
 =?us-ascii?Q?qRRxAplIsw7OcJDVK8xKfN/n68St/plJ81tkOhP6t2f8CzUplpdE9byRkl6M?=
 =?us-ascii?Q?6y06uJluMwVzeTBxdLBsGFxSkslMs1Xi675s39c78Vapg0vrdVluRFbnKLjG?=
 =?us-ascii?Q?20tB2DTONnt0iQpImUQIhG4tGXkxPVv4ZqwQaScjiPRk9YQlpdt0PkaY5qsG?=
 =?us-ascii?Q?/MueFvVD3WVK0KqRX2Q1TTGZlj/1/UYpx7lPUzrjRNA+fwoA2wRR6wctatKp?=
 =?us-ascii?Q?ijxkrLpsHdFbGn2CPOVVpfo=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c675ac-99ff-410c-47b6-08dda533364f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 19:49:13.1780 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4MTeIPSSruUtcZCOCIPIhRV8Df4YIbvEkDQBfVkwPHKNbSkv9uTYx14roh2joglLfiLInSAn0V7M/5zSjC7mXY4P1wssE+KmPYiE8Q7oqic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8992
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

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha_eth.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index 86fd1616da2..e8565be9b3c 100644
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

