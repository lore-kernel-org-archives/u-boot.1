Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E17C83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 21:00:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BCCC82A76;
	Fri,  4 Jul 2025 23:00:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="BCyYbxtj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A26C282FD4; Fri,  4 Jul 2025 23:00:00 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5197282F30
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 22:59:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9xl6/ikPzbPxihxPtzqOAT9XoVjJaXMrtVIMHh+mEElhbvWMeod8je9X1zI899jS9k1fMDFF6T5Iq/iELgZj32z3ootoTW8Gilp68gDd+kczQoqMdOPS2UZumQEbed+CHq3WEn9hXF0PZVGqKKzVfdZXNYtcvTUr2h6VpPPY3QHHvn99+Vwu2U1cBLPKUFPzZVX6Vl4xgEXjwhwvVfgGBA0SrMsRgSCv+S1rrAnRU07d6kc/0BDNTDaFddJjHtiwRrYNtQzNg9TOWAWukrnYso5pNoRTYGvGaNcAIWc2DNyWClKFypRQptzBRtWwnVIqNLBDs09fC43/s4FCuGPAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dftr2h0gMOf7AiuJ8OPn5wN/504dpbyfzFMbYkI9TUA=;
 b=q8duR4NByY1z2IzSO+fd0plora9tt7fHS2/VWAQL8gOduLy70sqaN47ow253n/7g2HThp5QWxUHKjauXrTlCqhpWlwkF5L5zqoffPkKF/MXhxvuiufBf5Qein6BS//F7EsYKqcairFl9MOWuZwwMtTY9Qnp2BkeyIC6LQBFvcr2SIayEFmHUaABnEQC0dc1YXVE2WsxKFfF9iPbkFautvCI5KUu8GA8c/zhFZMWBWlgthKCpAHNhLh5I+lh2z96F3skdi4Kx2AYp8xy/pM+wJVmAL46UGSdc9k6Uu7YGZZLhwDVYgj5YpyAZflDq7UJ0uBaD9lkgLmL3MMx8iDaDPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dftr2h0gMOf7AiuJ8OPn5wN/504dpbyfzFMbYkI9TUA=;
 b=BCyYbxtjuHgoIEVIHLgCDurd7jJmidBSsb++f6taUNiQktJpg3A51QBUT+nIngoO+LqiM3QV+Nb8mgDOQbBRyW5kSaV/nGtc1CodaFxEM1vYTaf654ZRx3uQDksIe3O8nmbUxCjPD1MQXfw416AV1ai9gPC5rTL5IENu2fe3CgQgvropXgPH3KlVLRTv2svmucRCAOyMpJWnJJjqwpr+1x6wgoXZRT736x55R+NwKajTnWLHe885T/CQkfkDX+k96oH7aIRKDY8d8vRN7YXawFnd9sHolGBs6N1NmtVMi1lh76DSM6R9dm7UnyubgvZcLcsRSJEUYuRiQQkweImwHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB6342.eurprd08.prod.outlook.com (2603:10a6:20b:31a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Fri, 4 Jul
 2025 20:59:56 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%6]) with mapi id 15.20.8901.018; Fri, 4 Jul 2025
 20:59:56 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 2/4] drivers/net/airoha_eth: fix packet transmission errors
Date: Fri,  4 Jul 2025 23:59:41 +0300
Message-ID: <20250704205943.1398968-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250704205943.1398968-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250610072924.1066329-1-mikhail.kshevetskiy@iopsys.eu>
 <20250704205943.1398968-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: 605aad96-0023-49cf-2d53-08ddbb3dbad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sEwYLRwaDUjM4Mv0j6VQLDMcxYqK4rFh+k0Da/74+zTFne2W+mV/Q4utmLWp?=
 =?us-ascii?Q?U4BQhTMsaWd3d6+wjrymAQyM44MGn9TcaIX7bVQpplXrxJwOixKY341GZ1/r?=
 =?us-ascii?Q?ZQ7xbrUh0X7MF1k5rO/iDbkad7T6/X39tvsVPTeQ/PSJMkEvLsL4f0obim/+?=
 =?us-ascii?Q?IdXfKxTjopsJ1quwNIhpgD/XNggp2fnO5NlQm0tqPP+dijXPDuWKJdfl3Vd+?=
 =?us-ascii?Q?HFddSXabpSov0Y1yWgGTnaC7C/4LP2MaFva68cQdmsfZXRynKj8dhQFibiDU?=
 =?us-ascii?Q?ZCcaUpzbln0N/wmCp/z9xh1IVTLzbSdFG9IwDTC3ysVTCRYFJrz4xgcccPRr?=
 =?us-ascii?Q?DGprdkf7UQrFsQ8R1mKUsOQDfQ8xa8I6qAi/n/IL9UW7RfY84IHDGx8Ia57X?=
 =?us-ascii?Q?JKLACPfzoadQ+pb6Xef1e1P/eIEPc4ctnucOsLBFImvqCKWiAnT/joHoGiWs?=
 =?us-ascii?Q?YUg45kixv5i8dokVxpRC7wFluqi/hltLf5g5SjBlj21IyopOpWTwsltwIWT3?=
 =?us-ascii?Q?hgxkGH2KRyt5nGwoex3WfZWaHZCOPVN1kIcFPNvukA50kaGo1k9fFvBpQiBr?=
 =?us-ascii?Q?TL5IIyot7ESuINtSPQlYt4Uc29FbN6uqRfT13a70i0HcoC8Inin2e6I5XoCO?=
 =?us-ascii?Q?wHegOfhL/k8V7WXX+NnkBmlCWxwVqSKTMTjcXRfEzzgQ14uVZKI8ncYk91r1?=
 =?us-ascii?Q?8rroQKKmIL284YxZlVPDExWZ2SYMrb/3NcmiUgKLSK+teQq9bd/Dn5QEln5x?=
 =?us-ascii?Q?Chf0HQUiiAK4hhBev/M6wcPIkQea4mcnJE3R8rkJ3P9nFS8sGaWCICv/+p4W?=
 =?us-ascii?Q?eFhntvahSOhLebkhhQL2iOxTEDu3Q8OduqI7Qaw48YXErhDrglMP2/+PnxKb?=
 =?us-ascii?Q?Qb2CBOR7tWRLxIfxJf81uFaFPE550qG/rk3nyqzR8K8KEdAgpcKgUcM+mm59?=
 =?us-ascii?Q?nbMR5wOhB9b9/FpIIbLdokkFjqYh7f0QHX7tUDVHN5VHmXKvkmCqNd8tlESm?=
 =?us-ascii?Q?2GI69iY6zQMpNBQV5pa2Ayyhpg5Cf650W2hGnsNFegr3nhnMLVrUP6P294EW?=
 =?us-ascii?Q?ZW6nqO1910pdUAJh1nWP85dBNxZNteBNxoKe01pDoRv8AUAw+1pTKW7PQIeN?=
 =?us-ascii?Q?M34OFN0P1b2HNRHg4peBAzc2nbw5W8V7xBNKcliGsdiqIbdPYs3cpffUikDd?=
 =?us-ascii?Q?fxRClycnBV59FEjuLtU3fbWpTQ7MfUSkgTcIjzFtT3ioUCPg4qH9syyj9l5T?=
 =?us-ascii?Q?Xy+xTtLADVnEgjLCGDj86AU016LbQL00AaTBfNz8pzM3gUgLiiQXdBGe1Cay?=
 =?us-ascii?Q?CDvnj5AQfhyW6iq7s+vHW2uFhruDd46znp3wkrlnqOWfJFmLwiCUaCZW/PIX?=
 =?us-ascii?Q?wE9K5Hla7AUp77nOrtZT0eEy7IvPRNj5gX+Qj6d0xfNhIE1SrMtQ3I+QnvCm?=
 =?us-ascii?Q?YX7sF2jDp+3XVQWzjBLWg13S6qOtvAwL/rRc9wVva97RUN/3Y/vRDA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zp3KRwFszPhnelCfrKf+TgCWJF/1WAbpoureh96ulqaAXOGbTwuavooaA+vW?=
 =?us-ascii?Q?ieBhZvnf8ZWUAutvXHsaCn3Kr5p4Y14dvlS3xUBX72iGIFRiIqen+BtGtywZ?=
 =?us-ascii?Q?ZcyBxXM0ZEnZdlA7ES8yKSmsSmftIOsArVs3G6+4CZ8FSW0njbNqIYIbpBRi?=
 =?us-ascii?Q?l10kUED2XcyF21Lx/+/ilpZAONyT620e1sFAEPdByGOw5nUQ8ai2x2xrM6YJ?=
 =?us-ascii?Q?e2O/ZRDzbGYowvalSRsiYWK/H/+oPwcvP0jjh8jqGikzQ3Bhst7adlWRSD7b?=
 =?us-ascii?Q?setCCpE5fKyfeerMrfhaNBkXgquyLDrFSe7OiJ16Lo0t6/+GM0CZr2vHa/3Z?=
 =?us-ascii?Q?tNyJqvQkdySw4IszarYvPSOTRAtzV8MYPb4fBZQWOcpA19NDBgKM5BIEEIW+?=
 =?us-ascii?Q?azjnrjuiNqpWZkiLLfKwO8EowZakh6d+88m16MWlKANztXVTIBDK6H6/eLjN?=
 =?us-ascii?Q?lSsIrTazTDcPu8BYdVwFvFEp3TyWoWZiOi220cqgYNIuxXBBLhb46mBpAcc0?=
 =?us-ascii?Q?kYBn+2Bk4CuLqpPfsbcC6DDD2h+Hbkeb38bbIowYe3niALcOwKl5ZooNoqVS?=
 =?us-ascii?Q?oKZPUvTI6Ngp2681pWl+f4ujSQngR6yGdK5MVl2qLG/Yafwt0JBspEppO45h?=
 =?us-ascii?Q?LQAzjGSkLPEWYOHsE02kfEKWmVQE2GI1RbX2ghzKDEyotmbQXd4rbrOVYlnM?=
 =?us-ascii?Q?XBXjB31FO1i55WKDBXneP4auSnfJrBoOW/sGSatACdAD5WpV6d4Pz56EQWxR?=
 =?us-ascii?Q?8Ipi84CSQyOc0l0kA+fJMyhufAOHnl8FHmZXhIykBAk6QKcaCOaOY4QgzYdy?=
 =?us-ascii?Q?/fa0awyojRLaTTd1EYYY6KmxWObUaLI3QdGavdbvnKR2gldpnZYJS4+E9o0P?=
 =?us-ascii?Q?TC97iAHoqURWKpGLOE1j54IpemRrINE7+pBCj50mn6z6Gd78+InkkwMTJ5Ng?=
 =?us-ascii?Q?Q1oya9rUwUv7HZk5d5lMYKHqjJWIATTvzsjUAy8k401JSqxEOOJNFzmuKrec?=
 =?us-ascii?Q?HOR9rNPz4N99XzVYGKYx9yqdHehH7ww7MGW9QHFI5cMGd2Mr37gbq3MqItaK?=
 =?us-ascii?Q?yIFk6Y6g70lWw0X+iHEVyAsaqNhqBLQeP6riWs+I9v9zsKaGQ3lfqtGmCo6z?=
 =?us-ascii?Q?MmyAQwxW8u4Oim7gZfn4EYWjhejeMjnWntgASa4t6IxLxFXTvpuManpw5z/4?=
 =?us-ascii?Q?NUbp5JcOtR0Su0gMKr4Udlps39ol5hcZpcbqMLTMIppM7CjPEoxb0q08UBHg?=
 =?us-ascii?Q?39X6HZSQsGOOslj4Y9GBvOFs6pL27ZtrY06oialfMGUyTsPxrdue7wBmjcgT?=
 =?us-ascii?Q?xJWypVHaY/0C5zh22WlskTvnRl9NyH/pzTFmjMyfoPYQyWdPISq2KbSX84UO?=
 =?us-ascii?Q?WWqeXvWQoKh6XSwz/dXqJY0C0YQ8w2s5LDfpZ07LeNSE9af29J1OjyAMMSXl?=
 =?us-ascii?Q?1cKpB/6h6wuwJe+HrvkuK5jTFZhTtvTkZBvI0v/VfZMG6ChbC2LLoQwbcKng?=
 =?us-ascii?Q?D+eCSnOe9RcV3vmNQOtzR/AoKDdySvcRgMAXRPWlm/22RF1A5YORv0LBxnJp?=
 =?us-ascii?Q?v/ZEDCNMMGY0Al6MJVyA21k43VVEPCcHaCRl9w+cEZZ9FaJ3WbA2I0IG45Py?=
 =?us-ascii?Q?4pY2BslNFDQQOMfbkfiQbTo=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 605aad96-0023-49cf-2d53-08ddbb3dbad2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 20:59:56.6794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6t5yysbAQOxiegEoL7npxCWMYvBp94DI9byJ4gOTvySojqYGaetjkA3ZROpGPBh8YcR/Fj4zQwO8aIHdvH8QocgPw6QQ8g+mfPj7K9TodNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6342
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

