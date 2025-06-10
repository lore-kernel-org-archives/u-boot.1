Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3EB9C5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 07:29:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C90EE82B7C;
	Tue, 10 Jun 2025 09:29:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="q2htHJ35";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB21482A65; Tue, 10 Jun 2025 09:29:48 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE44F805D7
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 09:29:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O6DFVZvENVVZo4WXm4M5tS3pI48QZkPvuc27FgdVmiQtrhJ4O9H9x6Rax6nnVia5J29PqgN+9o8GKlpmYPzoY7TKBBEIZvvG1cJeWrD102PDVd0Y8wwvVafoEtPbzDY90ba/vncAuJuE6cOPcEv2reuniliLj2tSXtO8ANneBcR+QeKR6I1DjL9A2YzczsKJO4teKuz08frBoT+VIkqCbjLaUg2GveZWU+DnVdNzQ5jP283W5O+DFXpsjAalC0zYra+TYfCgFQ+/g/iEzOMoeFN4r78Bjg8Rh87dvQ+vtttzRD/rtIZLxNArJg14cPyVq4e6G9W9MUulampb3FT4sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dftr2h0gMOf7AiuJ8OPn5wN/504dpbyfzFMbYkI9TUA=;
 b=Q9EAB/6nNZ/vQOMVD7HkaSq/Xi6870qyoP/8ro0rdTPQaewvgY7Ux+mzqHTR7thewBZglG99BT2kznRy1UMhnothIW/UtPe/crRwsNjEDT5eioKtZ65ANtavKl+G20PSq5MkaXqN5SnO8qQPM/bhh66K/3J5lflNKGXENEr1HOEdeXX3dq2D3NkBZlrWgVLsqLPLq0vhZDMaJB0XymQX5NiljPbuWsQK5U7sf/KA3qEucCEnUKUiNGTjPpVmmDzPO09UFkhW7zr06qVtgLY9qlSf3Lvm6vhWRifcAyYMX+Deo+ZYfDJSdYNxX0sCcn/RvZm/NICnmoNU3uGxnIlUQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dftr2h0gMOf7AiuJ8OPn5wN/504dpbyfzFMbYkI9TUA=;
 b=q2htHJ35R7haOcuX6ky93V+gSXAijQH30uSSM+DOYvdt6kaTXVjLju35zlesH74cd6TTAMAWTUCepS6BHZyexPr0aCwIr82C7sN4O+lR82wdKjkmG14DsW0LCG4bO8Np9UmgZdrNW9E3fQ0AaFWYV3U5V5RJ0q2Hji8qBAadE8y5nok4wCV/O4Bo9Xw/Jqq6ii7zepeFllZn1Ya9EkXWdgt62Kvdti5ZJDmUWpwyv2yM8264EfheyjK+3xpbZ2fxiWGprtef7UP70vcXgqb6VUgrGHpMxGds7GtrPCfwD/Qu/MKoKorPryG2oBhjyWYN4LFKvodCBg2OrlNdH6NCLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB9771.eurprd08.prod.outlook.com (2603:10a6:102:31f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Tue, 10 Jun
 2025 07:29:35 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8769.037; Tue, 10 Jun 2025
 07:29:33 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 2/3] drivers/net/airoha_eth: fix packet transmission errors
Date: Tue, 10 Jun 2025 10:29:23 +0300
Message-ID: <20250610072924.1066329-3-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: a353ad7c-be96-4cdc-2341-08dda7f08ba8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CWJ2hu+SYYw2xd5UNqmBMj0kSvfZmugHoIU9vLxFC/MOcPuhr+vWNTDzIuVs?=
 =?us-ascii?Q?M4YH3iAcMqVx4tP6yTljQp7gQx2O7OTI+C0CTikQiyJtrT+zHMt88751+/Mz?=
 =?us-ascii?Q?BIAYN6TnpIsK2uFiRgd3DVxXI6cTb3zGXhexFRz5xUa9/439Z71fPHbZQlbL?=
 =?us-ascii?Q?J47PQ/K67xDHpKUFo1aryjcHbQchUUunGj5bVtM8HlH89tjDo+lTRtD3MqwL?=
 =?us-ascii?Q?1ldzJzXzJzyNhg2j3Y8vjzd7DZaR3AoGCSENm8Gt7WCZ0gu+kx6T4hfhLBmk?=
 =?us-ascii?Q?X+wXPg0u7+IddW+Mxi81GdlfwVKaEi3pG8YgeVCfyLoj2ydZ/I6mlbRPSt33?=
 =?us-ascii?Q?2ZI+24cK1cwzR4RxBBtyAXQRSjx5ZeW0wH8g+EWndORa37gmL7JMxWyNGwX0?=
 =?us-ascii?Q?d8EWXsRDiX5vBsKONoubuHkeVkp5SOFaTmvipIlXE+Ng5ByyEdjPGdJzrqHf?=
 =?us-ascii?Q?4Mgsrop7GTtZkUKaI30tcU13j+FpdOBplhlpRquJpFDsxSk7eFn1MoZ8u/vi?=
 =?us-ascii?Q?Pj1K9ASmUH71SX5BWCFGX0ez1scthhPaXkIxlOZt7bCKQJa9zsZtTV6MqSGI?=
 =?us-ascii?Q?OBv3nx8lGJkeb+vFQaQcCCsQse0XR/G+hHQj2lHwMW88WmWPHgeChAsiWVvz?=
 =?us-ascii?Q?pgcXA8JBbrhP0gKDAMerMRsPHh1m01GuEdk/2KA/NvjkdwKSiKaMa2Lv7C5u?=
 =?us-ascii?Q?TGSPHs8OcF35FNEC7Jt69TlHbdk4EWOi75iam+WsUjDM+AHDMLspd7awz0Oo?=
 =?us-ascii?Q?htAbRUCbIisNhxxflosmdfSawJTdHFBBOeU1cvDx6Ol0wwSy42sSUhnjbZSo?=
 =?us-ascii?Q?uMRF+U/+5DZyh32oqq/OzyTzL/ZChoI9qk0u67GpmKC+XKgrdchlWICZseMN?=
 =?us-ascii?Q?ysKsAEo2hGbibO9XtHGoFCXo0Xj+Cj3ZcoM/9V3EuEEeYQ/idNBH4EoE+JWO?=
 =?us-ascii?Q?sdXXOfoVF9UZZjZ9e8uYhuf9bkBy2BiHt/mI0FAg41HPG0N7MVqhZrtnhTGf?=
 =?us-ascii?Q?gVnrRHiZOy8HWbS8gs+dxgRNsic5CfqynfRMVUzOYtTcll9yjI0bXu1RuxiZ?=
 =?us-ascii?Q?FVhj/quxj3GddrjNRIcc1J2bgdiOrjemtsz7xsP33REJLJ5+TgUHQGx4Z36F?=
 =?us-ascii?Q?qQjXrFRKwdO327yQB5dm+j7R2lPtf5DNu8c18/+RvmvogC/3TdlYsVOoO49k?=
 =?us-ascii?Q?DN8oVeCiFQTmLoLNiBmEHbjSB1fxfvSWEYBRt+I+nv2v53U7RH1wdHvEZz6g?=
 =?us-ascii?Q?vKAKZZsZcq8LWbTBhx1ZjyWMCt4UfNPOhr167EEg8CBxhV9/omHez5BS+em8?=
 =?us-ascii?Q?0NTzDdXqY/1jVVFprorpTSrDa0lQLkzdsygl2OyoAwxjRKrEJHLslB0lYENz?=
 =?us-ascii?Q?vmp18xS+eIWVYtwcelgU2WBTBB45D5Xhp3DasF8PbSGgmEXRlBVaZP2pux5G?=
 =?us-ascii?Q?DkUdJ83MR08m41Oskm/TheP/OLhdoKU3iVLLJn+ND5+MQSZkrQPVYQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lTaPiJFNSSKjlVWv9hYsJd7g9395SJ7urN8iKIAPKMOsUU3D7NXA9uMHk1Rt?=
 =?us-ascii?Q?/EdIGjBZYxpNVSKHd01AxeBpcwv9+0hT1m6PQAW2auoHNSGDjG314SxLsSjv?=
 =?us-ascii?Q?ysBCzg8Ohmi23fWeq9oGGw2vwGhk+I3rTur7HlY/fLKPV2KAsNZNKoXKLfkJ?=
 =?us-ascii?Q?DTfX1C1SBxsqaUkiBNOqHbeYkCxikQZgb3dnGm2gzP6VZsZMxMMzGA2MFASH?=
 =?us-ascii?Q?+9AEp6gR7xlJfMDGxijy3DSyFb4COw9WGTP6drL8YKa2H1HkLbCDI+o1fymc?=
 =?us-ascii?Q?4YXNnw+M3DAozyDfRK588eO8JKCTBZ8pYLOnRoZJG1GSXrVJVglNjphsHCb7?=
 =?us-ascii?Q?rNWnCU9hYtG5rYU9pa5TYt7m0Q9OCoQEwcRmfcJafKuG5R5rOq+ofa3R02IJ?=
 =?us-ascii?Q?Xr3zAYT/W5XIhNK+GCIJgAVNHK88+Vmv1FjbglD4WZsz5aCVLwfxzvOwnZ9r?=
 =?us-ascii?Q?oMJM9uYBrkebZXX8zVn/+MLCm2SJ1JEOy8bMcKSmtGhfzaFxcUp3ki8NR3Pt?=
 =?us-ascii?Q?cHCvx5KpSboAperRGEnTPL+zrVAxipWqQRrV/O66h/xkMmmKs4KHhBUEoQUx?=
 =?us-ascii?Q?7oukHc8XL4unlTUhHtEiA6MjwRkN7KzJSJtoVdE5XZe6RwCo0qSK3ns+z2xX?=
 =?us-ascii?Q?YbKqjz5V5XD/8xU3nbCcBJRrYMBoZgwOzKbIuqwRt8KOz8R8XY+qPCqXeuGt?=
 =?us-ascii?Q?Z818BnicVSNqeOe4yg5+GN9rRjL7n82XJ1N1Hnq2YRh5uw21rRsJKhfJWc5o?=
 =?us-ascii?Q?d7E+SuCllWa1I3GQZSR3xYJ7Pv20JxcfRjcxO6emm5Ys5Isfy4pZJKew8LJD?=
 =?us-ascii?Q?wtYBCDrimDfFDoWWzqELRYvXB//DLIBVe+V7XbPSs5EdMoax2SDz80yly/Ci?=
 =?us-ascii?Q?R+kfsqkCsdf6sqiLh6nkhfsuYqeScVPz0k6IzYWgGK4VizeUwPQg/jpb5366?=
 =?us-ascii?Q?xg9hsucdnD2ug7kjh6hCH7iWUFSnDdNy4EOUGzSrZsOaqNJGU9mG43yiWIGu?=
 =?us-ascii?Q?u8MGxs7+B9qk/6IEMS9daQOCfvFMxCTyRci4ABlIBRJIWRcImhJhdb+uOptz?=
 =?us-ascii?Q?zukU1exZEY9NXykDy53C+f5lZf4GfNA30ozuBGtFWbgoRX6UL8VZ3SheY8hf?=
 =?us-ascii?Q?/J4pFNkud8avMgnm2a0Ht9ojDr6720X0fUVyAA/+rRzAcJ4ifJejD6TR6cvH?=
 =?us-ascii?Q?PRXFvHbgm/yx99OiVXq7utFWPavfW7Q20GtzMCBhrd0NWdPt6UDghDcoGWb1?=
 =?us-ascii?Q?cewl3dDLcC6Y4g+9BksNeLp66yIJQHSYR784iPoAxvUkZoK0BMst+42Wn9LX?=
 =?us-ascii?Q?xHoRBr88E/gfNr4kBoATJZ9l1VSfCE2Z3ndGI74QSlIrhuYi0gT2zJtRoJ3k?=
 =?us-ascii?Q?hhli9TDBZm8OjZuTgnwjzX9GGuvwoBS4dSV1UgMr2sMf11vhByzWnFwCoQG5?=
 =?us-ascii?Q?l9mvVQbQtokvS2HtuPrQ+plyT1Yb5KFTy7j47OZHJob+1keXn6qMFlu/oYN3?=
 =?us-ascii?Q?z0tN+tS1dHuKLqNTO28DBeYdudcIVm2N3US+cZp1l9y1FVRb+rfnGQH4n5Dh?=
 =?us-ascii?Q?FP/8aLeJz4TR4Md4G4G3XFnpHv8ho33lz/sb0dE3P7XMB429sdRxGxoby91d?=
 =?us-ascii?Q?2yIFbtiXlTVPrEoMX/HX4JE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a353ad7c-be96-4cdc-2341-08dda7f08ba8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 07:29:33.6699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fB7fuRItRKK6mA7G/ob0ooByiI+XSaICdY+EjnvRHeeviPQ5qWcg0b+ia0P7ybxgsHoS/MwdfSRxP2E1XykVoMKcyJoqJEb1AhWFmvaULC8=
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

