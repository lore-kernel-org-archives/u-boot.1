Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF330C61CE7
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 20:18:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7179682A53;
	Fri,  6 Jun 2025 22:17:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="kRDs5RLi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B0C482B00; Fri,  6 Jun 2025 22:17:42 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ED3382998
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 22:17:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QbNW2MPOCIJD4kvZKlLJcRXYAV10uE+pgYA8pmYz32zf1l8+zJ9Rkv0KwtFHzLQCGREN2BahZjF8ZaQBTsacLzPUmF61lHUkoG+o0yRQXrnu8ENWhk0tTV49WwG4bhfbSYabUv3Vz4kZy/KOO/0jZD39wzdZ/p0lXKdqYMy5jSNqcw/Z58hIh94mTMSepM1xEMGSkE3NnN6fr8QeIYEP/kBLxC0b84u7Cs+WviklGa1bQie78yOn6AFct15Bsr7Y/n0CNNyA8J6dNv+lcEJfo3xo/97XWv42OM+ckR2wYa1jkHmy3BjdMQAj1cQo7KuDrnmh43XEBC2xUi9r/VdswA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ON3yRyh2EP7+m3LTeOoMrhVKvyq+hsebVm2Vif4r8IA=;
 b=aeL77HPMk/Io8R2xNXmSfzIWboW2kfn14w9aBazYa4WXKhUD0Q5doHCq8MI+FSuq/Dw5TH2XU6xc1gib4OqKPpOxjObnm1rKX0yuWYMVrVTXsWz/OmGC5Db6Rpp3MMWZs4Ar/83fFw408BWv2tm/iBn+yMoK2gQUSNX3Jwnz+QsPIBMtuZqLm0z95ZqWZy3UJ617IZyHcZL8hWIKfy4zr9Vy1neCFrRVI4Bd8xcYkjLM30Y1X1pkMw6EKnEkw1lF26YYhoC7Ud4gVZaJF0RjbsrWE9aPSAvr3zJIJsvUh0NBFVA6Uarxfif28IqqQ57vRSkb4UNk++rLcJxh529vqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ON3yRyh2EP7+m3LTeOoMrhVKvyq+hsebVm2Vif4r8IA=;
 b=kRDs5RLiTfQeJxWm6Osl+pTnj+B4AlIy05cUtaxw/jnyEeOsJKyqKNnbLS+3H8AUz+UU7DQ8END/hRvjZzHsrOj0lU2w7GwPiKt9HKvQ4CEYZ4QfVGWLkj4rgrXCly/CaAYmp+P2vAAdFhpAuPR3Uqxn+slE0GzcN2zdbeO9I+I4kAVs42POZDmpsul2veWi1n9AMb5b+ognCX2Ik+xeCDkRsSCq4rNgOqlyHhkw8zsltoiKccdsX8RHIur4gobTDv06T1D2lveOX/4nU0ukc6wDiw3eE5sGdghL5810/a+OJ9SDqkOWh8bP0qdzJmKHKplVUMbbwPXfnYnaRCJWcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM7PR08MB5399.eurprd08.prod.outlook.com (2603:10a6:20b:104::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Fri, 6 Jun
 2025 20:17:37 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8769.037; Fri, 6 Jun 2025
 20:17:37 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 2/3] drivers/net/airoha_eth: fix packet transmission errors
Date: Fri,  6 Jun 2025 23:17:27 +0300
Message-ID: <20250606201728.462664-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250606201728.462664-1-mikhail.kshevetskiy@iopsys.eu>
References: <6843478d.050a0220.6e23a.5ec5@mx.google.com>
 <20250606201728.462664-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::11) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM7PR08MB5399:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f78e065-e5e9-4b0e-25eb-08dda5372df4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?57IMhYAeSOawcFRUNMMGkMEwWDtHTzuJcviO/18zewktZOnnDMos0TUpiUgx?=
 =?us-ascii?Q?pUQ6+sJp8sXBV2RpzKBpxE91sw7yX1d4je4EC9Q9cnwFoJ1HKRBIGAliumgC?=
 =?us-ascii?Q?s2AuDPsTkO0Om7NP5DRadv5VYmQEi9QriGCjZ9Yzt2jFt49Hkiv+r7TEaD4G?=
 =?us-ascii?Q?Qv1j/FAaV0ekvyVV1HWsB7Dw1eF6pu3HQJRigzm3VSOZbccj+lYCMtwZE9cN?=
 =?us-ascii?Q?yDrDBGff5yDEGDfANHcRuKFvmfSMmr8nfuowNelyBuCfDm1EZ7lriJYv7g8x?=
 =?us-ascii?Q?YFPmiJqzIfLMz8Q7pGHe5eb/yNOy53FAIFG8XveqGaLlV0GdH/cSYuIr8irH?=
 =?us-ascii?Q?0Fev0sS7p0WSuobPdPQb+6xXbtp8KH8ahYjwojZjsjnZyP5SeC6NMlPNRqc3?=
 =?us-ascii?Q?fK8qpdQdsckIKV+U3feiz4gAgZ7kHlL5jIK+EQXAp7mnzHP67NFFItQI3bvC?=
 =?us-ascii?Q?goLPc+sEsIGYO/hCiAZ9BcGc0Lmx4Paxj7yVfqoHQ5JCG8Vr0+WAUCuuoYV5?=
 =?us-ascii?Q?xWXxmB+r8wPaO3cTNQvLKWbSRqlpk4KC8Py1iPIuTT+vvw6AELdSwUubO3lT?=
 =?us-ascii?Q?grTEGPzt9RtP3GEknk3zmsFiikXjTFmczUXlTMagYB2N/9RymHOXTDUrjF6f?=
 =?us-ascii?Q?MA0X4nQUj/LMl9hhln/MLweeH0JaGGHwxrEZRqSnl+FRPMfETUKb42AW6vYM?=
 =?us-ascii?Q?L4/JhI6uDbO6v7tKe8e7qQmMXHfUnXfuUauDbCKDavBJdvyqiMsPn+VrSZiC?=
 =?us-ascii?Q?Mq+CTub0QzNZzCGSDuMoIF/UJyE0TyjbN4mM+3Sdz2rsBH3myYNHgvukbCYq?=
 =?us-ascii?Q?3MZmG9gP+a5FM8xy9fVFsIHPfBMRfb1Rt7Ec7O7vFPK7IqNnuxF3sxv3KNYE?=
 =?us-ascii?Q?C2amSoHJozBVYHMwgb4SnOGNjTkwrOUpOWel747ucAT2g02Af2dC5sKWQxKV?=
 =?us-ascii?Q?h4Dy6WVseuqfoypJMtlMNXtOJBGeygy+xOuaEDee84ScVP+m+3ugPAr16lWt?=
 =?us-ascii?Q?VV1wax/lewcXG2TBqqxzmPX6QgibPYu+Jr093tlGABZgzYD0MV8nL49vlK3f?=
 =?us-ascii?Q?SuzY3s1Q6oaZHUFXwtlVl5JQA9Y6J0V+Xh1PtFUgGGFyp1E7JJJUN52FDccX?=
 =?us-ascii?Q?PlWxoTOYkZnzjPl9vkTnU+qAHFSt9Anad8wMZJEs/qu1d/+NPYNWAC4v2Ki9?=
 =?us-ascii?Q?46oJ9iJ9MVizvpCP1Gx3Hpadaf6TdquKpAeQZkh817ozyxpycbDXZ7eYWtR0?=
 =?us-ascii?Q?a4o0UIN1+2crgC26LzzCd2I+m/P3lKbLv3qvGPlqy4lZqUx8S6DyHoVQZL/x?=
 =?us-ascii?Q?uaQwrRi8/uodru4pnFY7V/Q0Unk4FF0ghtfZEoV3N4kqnq6maYr030hsPX4y?=
 =?us-ascii?Q?pilbrSDbftltGFb+kW7Ny+3GG+TlnSZ9E0TEWxJDlxhR60iNJgy9C5OI2xxO?=
 =?us-ascii?Q?gIn74a8QDaNuXI2I6U0HbIFLUGdDJxmu6dS07K3/BqbxR84bt+JQDg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MRPE/YtlC+RkfAI08j/pYQg08sNW0zsoEyZdgfT5or02omz6OOEJ3rHtVpjm?=
 =?us-ascii?Q?xsGTghl5libm2W7jaUYoJ9ONDSOrf+2x0ML+DADSzpf9eq20wwzJZGcHi78D?=
 =?us-ascii?Q?PpjZrgzvGn1wxKv/Gv03sOzdyPTp6aiWY+2maYcDLqp1ZAckIU1xzjvedIcL?=
 =?us-ascii?Q?EnvTb0pf3y7xeMXQifekVWXby/yX7d3c+aOn97fS6xK7pd6YgnC4rPdwmH+R?=
 =?us-ascii?Q?LLVDmUd0utwfTlCTL7hIbwYsrGXlSdUe1ALU5Wc/tEv7rOuiuyemUnc+Zeki?=
 =?us-ascii?Q?YR0+ddwnanMVSoW77eyUss+AHuigH+k4ZlzjfY2K/aaKCGtbsxEIsOoW+6/1?=
 =?us-ascii?Q?vVfLgT0/KJfXO4mzCk+sxHiJrIimBgcAQlxy71nf8BqgBA/Q/gPS12ZeAHzy?=
 =?us-ascii?Q?wJ7caUR7dF9ivZZHg04vlWhhj5lzVt2g1KTDi3+x6ygX6PqHs8tQmdbrAf8q?=
 =?us-ascii?Q?kFp/JX+2jxXqa4NFQ7Yg9LDsKbqB/r5LrpWxPD6wbpBsyuP0TOdPfE90rDwX?=
 =?us-ascii?Q?QC/HDvH/qP0JJx1KbgOZZYuMwC4uGlgF1XT9ZY0SjtKnM3OLHlRvdWzb99va?=
 =?us-ascii?Q?0t8N5/EYynikZae4DAxAtP+KTs2tDUbUZ4Dt1L00aDK2c+4wmNxOyYxerrm7?=
 =?us-ascii?Q?Lsk4j08CKqO/QjvFsMOxOZLpBDnaWF9YhyH7oKfKmA5Jy/uzCLlGcbyW8L8W?=
 =?us-ascii?Q?0BG14mOqoZKVIp1PItqtZe2nHP1LX01Y9ro/TV/bIcTQCKqrelhK0nIAv6l7?=
 =?us-ascii?Q?09ZHsmjIHFv/OqIgNJS9NHJ/y0MC7bhmBywsetBuqqAjyprgtZs40w9NGZZh?=
 =?us-ascii?Q?AEOKMUN+M7bB7WLny2711tycdJHFIkFzP2zBIhXxicq6MjSGYUdDSmLFHm6o?=
 =?us-ascii?Q?7G4D1zyW95XWRR5Xzd0ZTcb/b/oHszQUOxCdUkoyfnPI51ws2/iDpJOM+Pfi?=
 =?us-ascii?Q?WtWJaU3diZYHnJyxIgk3aJqW8C4gpDHtNKvJCdzMNYFB7VkXIb3xu14uEOIC?=
 =?us-ascii?Q?8MFSHZZziE7qGArCEqA+XI0bE/KI1YP3ZMDFv7o7CXG0KYzjlwwhQFaZZhlX?=
 =?us-ascii?Q?2EEtwoQB3G/5JAJ6se8Q7nbRcf2ACnjacph4QHXzig0Bq9H2vr4v7R1MLijo?=
 =?us-ascii?Q?R/kq8bDmCCMmYcZpoW7N6hRnnppKvbOAwEXBeOJi4CmZn6xFcGgR0sz8/2NR?=
 =?us-ascii?Q?y22uMcSZYdoYNajWtWUMe2Ri2sBVhwoOMqWbYyqTBhO0lvVH+LdEymPsE+qL?=
 =?us-ascii?Q?FUAsAD2jAQJybgRx4wThSLMhmTzBo+2lTAbSQ3+fR+1wRaVxQKzaS6+JBP3/?=
 =?us-ascii?Q?DACrJ+o/nphHMQO1S6lk2CkKZLviz7J9db+sU/7G/5NB2/6ZuB7OqjR+xEex?=
 =?us-ascii?Q?YZaENOmHeLfG1byQgcl9HYpqlCKMVlp7hoQm7msDhC6gcgd/RKCEdkS1N/0M?=
 =?us-ascii?Q?c0gQHpxyN1/ht68hGcbLQ7GOQQgDkFLVfEyoq1SXuyt6JgBDQYGEvM8OSgWL?=
 =?us-ascii?Q?ZWtSr9CauPnePII+joVP6JkrQ3U9umnNBwK2TD79IW7r1oo00QV/m2o5najz?=
 =?us-ascii?Q?n2Tt1rXUJWbdOZiRQx4rPNRPcPobVigZrlSriL0azUYoBWkgvWxVjbfszW0d?=
 =?us-ascii?Q?Q4Cnl6W8eygaSVBEAYthnOE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f78e065-e5e9-4b0e-25eb-08dda5372df4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 20:17:37.1508 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XkZrdd5NDrjuKWvwKbdYOMwibD6wNGXQ4CnpdnhRpxgaFKwJrNFxpFrJlX3tXZQyFGjW3uo8zIRZNLX6fNFrS2rZFcc6o4xTcxIZHodH4cs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5399
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

