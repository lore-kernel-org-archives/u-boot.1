Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D2DEE14A8
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 16:02:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81C4C869A3;
	Wed,  6 Sep 2023 18:02:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="S0e/T8zh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82F0585E44; Wed,  6 Sep 2023 18:02:09 +0200 (CEST)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::61b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8E1285F50
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 18:02:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=laurentiu.tudor@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7Wyd66/ntmNjME1xEWppG2nGgfriwXCQN+KW6dQQCmBX5L3edEy8Gx3xKfCNEziwEyb5dgXqBzuq1tsCKPfS+7XzzU/dm8ONNDI4w8fQ42qzqOyxc3ZXUpb15a+JDVXAZC6tGiLb1Q21bctssAmnnTUn4Qdjoh9h5pOsvY/imcMGex7bbM75r++ySyic5B/1Ji0wMrQs592tIhFDqFHbQ5cwk5+De0wM2dfpM44+aiCYvGdX93soQwM39C0tltOMrnn3lz7a6wxeMN+GU8podV2D2dslIbs2WE6MfjcbQ1z5re5hOJnLc8s3K9LencMmSD/tA4ruM2UnM2Qtpt6Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=635FPfbbMYkJdQuFxb+fYQEvwW+VqB3QPglA5bDqy7k=;
 b=Cx42SRpDexywJc6Kzzkj4T/LxPiBA1JkHTofiWSsqvlMcsELnQp5P2jUynosH4QruJ3ARv5gy7K02wMOgnLrNFbtDUxTxiKpy6jamJ/r5uAqs/okFDPazmid6O/BA8lGtL4oaRsLv7mESmpkaNLeH5joVM7nDbM3JbWMggwMfdNURCSLGbz8KHE5jiNu9m6Zj1HFMxkoG5wzUq84rirZmECgl5Xi4qKHjY5W6+FsDaqPrPcnC786icYT8xcdId5AASQh9qiQAdup+vFWY8DdDcTpWxOw1wMh9S8ALEK9zQOPH72R1pnThPixIxupvOelbZpGpefG/k+Mp3jYo8BvZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=635FPfbbMYkJdQuFxb+fYQEvwW+VqB3QPglA5bDqy7k=;
 b=S0e/T8zhMcmp61hClVJiQ0JE9gXKuLKwo6xTSn2sc7X4TRn6taecilEL8dR4fy/iCMuAYD1h3N8UsjTyspm+2BshVeYPVDzKknMHm65fUXB9DGN/Zu50gSejmpYomjeXSVHNdtIquRjQJNla+P5VC760qlHEB2pn2AY7EL2DTd8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com (2603:10a6:10:368::16)
 by AS8PR04MB8690.eurprd04.prod.outlook.com (2603:10a6:20b:429::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 16:02:04 +0000
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::179f:1c4a:4573:acb9]) by DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::179f:1c4a:4573:acb9%4]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 16:02:04 +0000
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: Ashish.Kumar@nxp.com, priyanka.jain@nxp.com, wasim.khan@nxp.com,
 meenakshi.aggarwal@nxp.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 peng.fan@nxp.com, sjg@chromium.org, sean.anderson@seco.com,
 ioana.ciornei@nxp.com, u-boot@lists.denx.de
Cc: thierry.reding@gmail.com, robin.murphy@arm.com,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 2/5] drivers: net: fsl-mc: add support for MC reserved memory
Date: Wed,  6 Sep 2023 19:01:49 +0300
Message-Id: <20230906160152.24185-2-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230906160152.24185-1-laurentiu.tudor@nxp.com>
References: <20230906160152.24185-1-laurentiu.tudor@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0059.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::29) To DB9PR04MB9380.eurprd04.prod.outlook.com
 (2603:10a6:10:368::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9380:EE_|AS8PR04MB8690:EE_
X-MS-Office365-Filtering-Correlation-Id: c71597e0-142f-41a3-2026-08dbaef29cd4
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fGvUNMuPFulY6jE0UN4/5qgh5aH+JalRWgPMH2VW80pzTVbE6I8TD6aIiLf9w7sZtYe91qp3HjZGkCm8Z1vq9RSooOboNbGgPrw1eO4iSaxWLjryYJMfSb2t2sHkmnGl64Ossn5JP1uTscQ6kqt69aTioZWI3PV5es+2lo5K/Rkwo8fvIwe34HbyPsvHWmqDsz5OaA7MKY/WK5+d8lUlAx1ryL7tjB2WzQUF3i3CWzF9w7tq0Sf+tGBx/3g9kYtnUPXW4QvX8WaJzN37HW4ImIjThLikbr1A4Lltn1ApMW97F4iYn6jbVM02Mah7ZCp5VDvPnxHlyiYDJQbx9i9eR6BpTNqal5DlmkEvnq8MzqTxH9c7yitF58VgEublihyAZkbSl8zZIdWMgGn2fs1ekUeY27FmwZcbbo6lairheNUiTzpFmQsIeUN+rxzQgT7KlYkVbDIqY7oz1g5ptVpuucKsO8FNoKeoa1yZQrVSjn85+ycgHNPEENGMOle9SIPuV0h3u87DVE7PFJ8iduJNGjuJvwlcy4AjQFNLOfSH2EaiaZdJaet9gnIcGtiaWTm5fA1lzSORXaN0YYdB/JITmoW10JL7Hqe08OYmQIR3Fz5l0CPXcNsV6QMroITJnJHHz3dpSwiw8ZuTWa2yvYIaQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB9380.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(366004)(376002)(346002)(136003)(186009)(1800799009)(451199024)(36756003)(5660300002)(83380400001)(86362001)(41300700001)(44832011)(6506007)(8936002)(4326008)(8676002)(52116002)(6666004)(6486002)(2616005)(1076003)(26005)(6512007)(478600001)(921005)(2906002)(38350700002)(38100700002)(66556008)(66476007)(66946007)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8Hzcmmb69kVzShnmhYY2BJXT/3atMdJBQObhG6PLQOCRgHQM7AQrtcoMjpBB?=
 =?us-ascii?Q?tbW2GJ8ZZUc68GMNV2mwVRQnjf8IK+EYkV4wyTYyAp/sUjFu74ANTBxeS+X3?=
 =?us-ascii?Q?yo+4zdAS7t8xquCyO5ArhUbf21Ry+i5jIXHUPcNaYwf7T8XljjSvdE6t8sNc?=
 =?us-ascii?Q?UezLodLs+bN6iaLZPxQ77169CNGk/G5iKXzdVFScMV9hsqu4Al48fV9k+Uba?=
 =?us-ascii?Q?us7zwhnoU7Z/tQoMhcIvy6D72vv8ZXzBEJA1IZ/Nhh6VGbOFwIrd8GLr8Xwe?=
 =?us-ascii?Q?j35GlQ2eg2ummi35T001xlw21TpH3BD0uM46T2O2P4/FJZCfey0wSs6ZxDF/?=
 =?us-ascii?Q?qQ6crBOmBT4EBo+Jkahpl5gA78hMsSBKZJX/+/buUpqEjYrvROHPsJWnRM0f?=
 =?us-ascii?Q?Cv16+mnKmqjQA5vpuYYO7H3fDjr2EuFp3tTGcQWOablJJiLYOeU9ytdv1h9N?=
 =?us-ascii?Q?do3VkS6fWXAS71oITQSZBrcdPmkdfp12gZNfbfJJMCgOQdPwhIidYShm3WtS?=
 =?us-ascii?Q?vZLh4yPtWK0taHUVXefTIASG29iANtWyA78Hv0jtgO6zmotP2hHcXv++pFY3?=
 =?us-ascii?Q?u7YRAX1p1briiS/HBGurdOCTFvIWmD9aVGNORUt/eoGAkmb+1oJW/Fd8vJW0?=
 =?us-ascii?Q?kFV9MBMTlvKE8f05xJzXi0yF+OZRz2WKuebpcSo+bjxIF1Q0qyWtoy/Q6E9o?=
 =?us-ascii?Q?lSgkCLDqn+GODJDsL+AcZwt6xbzO/f1OkdpZQLH9ZqADdE2OxxaKWrAXIA1Z?=
 =?us-ascii?Q?sDuh99yxqrsDJ1wYIpmBmIjrsjCJrwqGbS48uYZjBZhlWIT5hY/o4RLQCJvt?=
 =?us-ascii?Q?W6/4xWLxmKdfZmcWihcjCOaGGEfH2ibOpaAGnvWxolGlBoCT3Bjzlbzit/nJ?=
 =?us-ascii?Q?JabTI5zOYYmq+4EQW6Sw6JDLetT6fDGD9zKCw70VlSRxrvOdYWo8nWHunm6W?=
 =?us-ascii?Q?Ug+W1Q2dPVKXq7XQ+DltlqbnWt3XkjCwVD/DP7l2zvnjBjSxSQ4bkhCggXPl?=
 =?us-ascii?Q?kZQer/rIntHTzMjObnjGaX2z3rSEqp2yRHsw6+VNq0JuJS3cHCDaR+KazgUS?=
 =?us-ascii?Q?07nmsd7tdbyPMCfFzSomXZivzXdNjU7JymPoqpZ+/JvHPAv1rncqDGpjPwrN?=
 =?us-ascii?Q?Y/2Y/Yw5GfF/UAkTYUqK27s/dM14bO7A37yEQuIZCYGRnms18tVhUL/qZRsP?=
 =?us-ascii?Q?EIHQzCXOurulkh3FVIZsZWKHgovtllzSxpsI9WmhBgj5nreZas5SvHCI+aIU?=
 =?us-ascii?Q?bI/rE+k2+pa/J3LKBd8iRYGNPYfkFoV7KUFYoUPgUYUx18/gDHZ8KUKjZJb5?=
 =?us-ascii?Q?Adrt/K/cGQsUxFBZKB6HdvhAiHes0IXa3K3HS+Vi8VT6OP0rS994cFYkibv2?=
 =?us-ascii?Q?i4qzpicIZeT66+6R8Fp011kONp06g4iF9yeIntJfMt1bculXs7zuR1dhwhHD?=
 =?us-ascii?Q?XUntUH9sYdapDRgkf6L1+5E+o9I4e8bF4wxDE0hn9sS6h41QhoRkTjbghBI/?=
 =?us-ascii?Q?qoXdgDMCrEeoBtfiUON6QTPse98VqSXe1RoP5J75MNISNNPW3JjfnSrdflbi?=
 =?us-ascii?Q?7LenON1/ECQnNkkXQ4pipaPlZeuXZiek40iElHvM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c71597e0-142f-41a3-2026-08dbaef29cd4
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9380.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 16:02:04.1444 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xWHF2U+AypA1lx3G17kUgb9dVXzXpSPt9jGOJBWrym1gVhCQNz4a9ZkvahkhGaZgNmmP5xU67lyEQc6d4ZnqDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8690
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

Add support for declaring in device tree the reserved memory ranges
required for MC. Since the MC firmware acts as any DMA master present
in the SoC, the reserved memory ranges need also be identity mapped
in the SMMU, so create the required 'iommu-addresses' property in
the reserved memory nodes.
For now this support is used only on LX2160A SoCs.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 board/freescale/lx2160a/lx2160a.c |   1 +
 drivers/net/fsl-mc/mc.c           | 110 ++++++++++++++++++++++++++++++
 include/fsl-mc/fsl_mc.h           |   1 +
 3 files changed, 112 insertions(+)

diff --git a/board/freescale/lx2160a/lx2160a.c b/board/freescale/lx2160a/lx2160a.c
index d631a11ff667..688d81f04f64 100644
--- a/board/freescale/lx2160a/lx2160a.c
+++ b/board/freescale/lx2160a/lx2160a.c
@@ -834,6 +834,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 #ifdef CONFIG_FSL_MC_ENET
 	fdt_fsl_mc_fixup_iommu_map_entry(blob);
 	fdt_fixup_board_enet(blob);
+	fdt_reserve_mc_mem(blob, 0x4000);
 #endif
 	fdt_fixup_icid(blob);
 
diff --git a/drivers/net/fsl-mc/mc.c b/drivers/net/fsl-mc/mc.c
index 984616fb65c0..f5c5057bec10 100644
--- a/drivers/net/fsl-mc/mc.c
+++ b/drivers/net/fsl-mc/mc.c
@@ -30,6 +30,8 @@
 #include <fsl-mc/fsl_qbman_portal.h>
 #include <fsl-mc/ldpaa_wriop.h>
 #include <net/ldpaa_eth.h>
+#include <asm/arch/cpu.h>
+#include <asm/arch-fsl-layerscape/fsl_icid.h>
 
 #define MC_RAM_BASE_ADDR_ALIGNMENT  (512UL * 1024 * 1024)
 #define MC_RAM_BASE_ADDR_ALIGNMENT_MASK	(~(MC_RAM_BASE_ADDR_ALIGNMENT - 1))
@@ -929,6 +931,114 @@ unsigned long mc_get_dram_block_size(void)
 	return dram_block_size;
 }
 
+/**
+ * Populate the device tree with MC reserved memory ranges.
+ */
+void fdt_reserve_mc_mem(void *blob, u32 mc_icid)
+{
+	u32 phandle, mc_ph;
+	int noff, ret, i;
+	char mem_name[16];
+	struct fdt_memory mc_mem_ranges[] = {
+		{
+			.start = 0,
+			.end = 0
+		},
+		{
+			.start = CFG_SYS_FSL_MC_BASE,
+			.end = CFG_SYS_FSL_MC_BASE + CFG_SYS_FSL_MC_SIZE - 1
+		},
+		{
+			.start = CFG_SYS_FSL_NI_BASE,
+			.end = CFG_SYS_FSL_NI_BASE + CFG_SYS_FSL_NI_SIZE - 1
+		},
+		{
+			.start = CFG_SYS_FSL_QBMAN_BASE,
+			.end = CFG_SYS_FSL_QBMAN_BASE +
+					CFG_SYS_FSL_QBMAN_SIZE - 1
+		},
+		{
+			.start = CFG_SYS_FSL_PEBUF_BASE,
+			.end = CFG_SYS_FSL_PEBUF_BASE +
+					CFG_SYS_FSL_PEBUF_SIZE - 1
+		},
+		{
+			.start = CFG_SYS_FSL_CCSR_BASE,
+			.end = CFG_SYS_FSL_CCSR_BASE + CFG_SYS_FSL_CCSR_SIZE - 1
+		}
+	};
+
+	mc_mem_ranges[0].start = gd->arch.resv_ram;
+	mc_mem_ranges[0].end = mc_mem_ranges[0].start +
+				mc_get_dram_block_size() - 1;
+
+	for (i = 0; i < ARRAY_SIZE(mc_mem_ranges); i++) {
+		noff = fdt_node_offset_by_compatible(blob, -1, "fsl,qoriq-mc");
+		if (noff < 0) {
+			printf("WARN: failed to get MC node: %d\n", noff);
+			return;
+		}
+		mc_ph = fdt_get_phandle(blob, noff);
+		if (!mc_ph) {
+			mc_ph = fdt_create_phandle(blob, noff);
+			if (!mc_ph) {
+				printf("WARN: failed to get MC node phandle\n");
+				return;
+			}
+		}
+
+		sprintf(mem_name, "mc-mem%d", i);
+		ret = fdtdec_add_reserved_memory(blob, mem_name,
+						 &mc_mem_ranges[i], NULL, 0,
+						 &phandle, 0);
+		if (ret < 0) {
+			printf("ERROR: failed to reserve MC memory: %d\n", ret);
+			return;
+		}
+
+		noff = fdt_node_offset_by_phandle(blob, phandle);
+		if (noff < 0) {
+			printf("ERROR: failed get resvmem node offset: %d\n",
+			       noff);
+			return;
+		}
+		ret = fdt_setprop_u32(blob, noff, "iommu-addresses", mc_ph);
+		if (ret < 0) {
+			printf("ERROR: failed to set 'iommu-addresses': %d\n",
+			       ret);
+			return;
+		}
+		ret = fdt_appendprop_u64(blob, noff, "iommu-addresses",
+					 mc_mem_ranges[i].start);
+		if (ret < 0) {
+			printf("ERROR: failed to set 'iommu-addresses': %d\n",
+			       ret);
+			return;
+		}
+		ret = fdt_appendprop_u64(blob, noff, "iommu-addresses",
+					 mc_mem_ranges[i].end -
+						mc_mem_ranges[i].start + 1);
+		if (ret < 0) {
+			printf("ERROR: failed to set 'iommu-addresses': %d\n",
+			       ret);
+			return;
+		}
+
+		noff = fdt_node_offset_by_phandle(blob, mc_ph);
+		if (noff < 0) {
+			printf("ERROR: failed get MC node offset: %d\n", noff);
+			return;
+		}
+		ret = fdt_appendprop_u32(blob, noff, "memory-region", phandle);
+		if (ret < 0) {
+			printf("ERROR: failed to set 'memory-region': %d\n",
+			       ret);
+		}
+	}
+
+	fdt_set_iommu_prop(blob, noff, fdt_get_smmu_phandle(blob), &mc_icid, 1);
+}
+
 int fsl_mc_ldpaa_init(struct bd_info *bis)
 {
 	int i;
diff --git a/include/fsl-mc/fsl_mc.h b/include/fsl-mc/fsl_mc.h
index c701dc1084b9..258738dfc8c2 100644
--- a/include/fsl-mc/fsl_mc.h
+++ b/include/fsl-mc/fsl_mc.h
@@ -66,6 +66,7 @@ int get_mc_boot_status(void);
 int get_dpl_apply_status(void);
 int is_lazy_dpl_addr_valid(void);
 void fdt_fixup_mc_ddr(u64 *base, u64 *size);
+void fdt_reserve_mc_mem(void *blob, u32 mc_icid);
 #ifdef CFG_SYS_LS_MC_DRAM_AIOP_IMG_OFFSET
 int get_aiop_apply_status(void);
 #endif
-- 
2.17.1

