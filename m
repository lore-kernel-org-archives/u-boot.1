Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F01CE82CA1
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 15:31:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44E3A86E1B;
	Wed, 27 Sep 2023 17:31:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="qBSTI/Fg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DA7686BE2; Wed, 27 Sep 2023 17:31:10 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::60e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D53C86D4E
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 17:31:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=laurentiu.tudor@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtVZRAd71rq5pq1r3P/d2wLkEtu4u/LVHDkN37MFTp/RB51MUw7ghk2XXzpsQ+T0UfW9ysnwtiSottYJvoV708oX15SeUtmd4KIwPAlDjLeKGT8p9XgwRqP43kRuCAlOROdvEP9tHzN4m8Z4RWwCpOjqyA+4f5O2Z/DC7sJoXsUbwjI1uZEX4BLbD4e0cffav5/jh39jlUtbosJGcW7m9XoAx7tH4SklxoORrG2EPYVBmgKgZeMXybJE+kyKKplJmvYo0s/zVvuYva0RIaDnQ1x7UzFwJ8cuRdcAJtfoeG/oNKTdHyWhHRU1dkrAGYH9D7EnAIhRC97A1aXpGC0Fog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=635FPfbbMYkJdQuFxb+fYQEvwW+VqB3QPglA5bDqy7k=;
 b=L+dhMomAf/DQr0HwS+1y5UywroTCaslNsGA+Bmn2/o/jyVbXlF1WcoeChE/P502PIsA6Zn7ZV2+gb2X1Uw4WrsocVMe6GP/2Grx7lTVkay8X8XiQ1/221mLL3Njd6JAJuN8EOo5y7pUnlv3ahU+XS+vEiV51EyLv9ekjS/1LHFyj1+5CLplDzkzE7JJ4Q6zW7BT9eKN/bUzkSTkEmpDRMSRPGq3gVo5oLDQYdvMEvDuaZR5xDK1aCfl2DornAUcRYDa5ZkkZyV36K/rKQxz9f8rZ2GvrBC9EQ5N1le2sShmHa+iDPkkIsKVICg7YBEfL162kzWs4dyjOeh46JdABEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=635FPfbbMYkJdQuFxb+fYQEvwW+VqB3QPglA5bDqy7k=;
 b=qBSTI/FgVts/fy/wR9O44kwesDE3coORTZv4vqKeGsPnnIHIvyHlhR8y9z6ngr6QUk6KKMMs7Q5qPZB9AC94IwV7Cc8AKFzNU4UrNRm3QdE/xFB/Im0DgNjOdqHF86UFChvR0QymSR3NlC+FxTzuorDpWw4oO9UFTXxAoglErlQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com (2603:10a6:10:368::16)
 by PAWPR04MB9959.eurprd04.prod.outlook.com (2603:10a6:102:387::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Wed, 27 Sep
 2023 15:31:06 +0000
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::425a:a4a9:17b3:cfe4]) by DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::425a:a4a9:17b3:cfe4%4]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 15:31:06 +0000
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: priyanka.jain@nxp.com, wasim.khan@nxp.com, meenakshi.aggarwal@nxp.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com, peng.fan@nxp.com,
 sjg@chromium.org, sean.anderson@seco.com, ioana.ciornei@nxp.com,
 u-boot@lists.denx.de
Cc: robin.murphy@arm.com, thierry.reding@gmail.com, jon@solid-run.com,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v2 2/4] drivers: net: fsl-mc: add support for MC reserved
 memory
Date: Wed, 27 Sep 2023 18:30:47 +0300
Message-Id: <20230927153049.12786-3-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230927153049.12786-1-laurentiu.tudor@nxp.com>
References: <20230927153049.12786-1-laurentiu.tudor@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0175.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::12) To DB9PR04MB9380.eurprd04.prod.outlook.com
 (2603:10a6:10:368::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9380:EE_|PAWPR04MB9959:EE_
X-MS-Office365-Filtering-Correlation-Id: df7bf1b8-4898-431f-a130-08dbbf6ec433
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VazZNrKDu5g4YCieaHomdCHXZteapxfIRTMYX0fKnf7CrIab/vd5NJbre2+FStQj54iOjY2EHTZrAHD4AQSk5muKOxLWL+Z9O2RRepYmBZj8LsC9TVH5+7maY+mWfd7mQgf5g/K1oPLstlXNfMs+qUcn0RzmlZ+mdpvAO2nbuVvtUde5w5ZPGLp1IdeWbp6Q/uZCQoXSC/a4hE/919DH2oQkHSxmgg7ERiGS6i3ItMgQMwLiWlHh9h5egbsLm/Soeea2l5of69eiZWLS2qho5KQ7sGdqWXrTn3oRzoaL9eCR8vrt15oigVrnpsBqFdnfqJkKDtgrLfE5fuOmC1Kw2BXeykqvy3l51ld2DjkSd8zL8BJpeIIW13wTXJgnoBGK2x2GiHHz167mXAa1MDvVe7onf0/nPdLdiKx2Mz78IPZaotIkv3NGNqC2jhpNx3Z0HpNN06zaSHew/Pzj48+vDQuAww/YrdhSKduDJAsfTg8Up8T2exalg23G0xbbzVWxNI9tphxghG8y39ZQrHLln4eUcY2VKQa39zsPFBv/HpHCFmbhVHaFCF/ZZuJjOonSBvGv6yDk+w9NkClEdRwGQKtQZ0Z3vuUQHAD3GIfbgg1V9nc5VTw6cDI0z9SC47gAf861k9jFUrCwIg2RtGesLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB9380.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(396003)(346002)(366004)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(38100700002)(921005)(8676002)(38350700002)(83380400001)(36756003)(52116002)(478600001)(6486002)(2616005)(6506007)(6512007)(6666004)(26005)(1076003)(41300700001)(86362001)(66946007)(316002)(66476007)(8936002)(66556008)(4326008)(2906002)(5660300002)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W4m2uf/F7pwLpk+bCp8UzhDVKKx2LA8LtE/CnY+BCoD9obpM2qlQ7IAywF4c?=
 =?us-ascii?Q?k2cQva/MabkbLib8qmi/faAFzEGYOEYwfcPdQ9pQYGuAH5mtcBTW2yjT+tR9?=
 =?us-ascii?Q?c3P+7Cul4cQMIKCY3evIQDu9cm3accOGrBU57O4Emn61uXZv/92P4IWHzzIE?=
 =?us-ascii?Q?OxZ/ENcm7FXbKPItOJd+mot8VCkbHdEtJSiPWK9hGP6T8a6+1KOuTtgauA0P?=
 =?us-ascii?Q?9lE1ED2A6nYSMjVVmTQN7AM/nSqj6qfuaKZNLvCvlyf4a+YNT2X2y6+mduuk?=
 =?us-ascii?Q?/dZ9gB639AIivm1ouYpow0oNNC0B5LFCnwnfKmcseeteK9cIgUQKe5IPgRCJ?=
 =?us-ascii?Q?Qo35ZJ0Ju4FTbmRDe+zmC/UV6+njpEkSdNPIlBLhxVZuyAFAXWiJV/9gODzP?=
 =?us-ascii?Q?GPB/DS2N6R+iHb1iF01IRmLX8PpA5qZUDbIzuYtpNOw1Mw//Md1+WD2zlIds?=
 =?us-ascii?Q?u9Oq53NwiH31iJCm04GOf/gH5z1jd9uH51i1GSQlTA6XQSB/5Lj0a/zr1p1R?=
 =?us-ascii?Q?0iq5N4maO6cHb0ohDbaxkY5/FAD3jJMB3TipgfeUA15bULBBnUrAx8/FQc8c?=
 =?us-ascii?Q?rxQYhevNbgveaQ3nCr1vHFXMhXy4qxd7D6GcaJjxvAUlf1BrNr2fgVkIgvM4?=
 =?us-ascii?Q?1K3CtVVhwKqH23elIitL1V/PZBgaSJC7Z8GyHGspV/x1TyYsXwR0yEe0RXcu?=
 =?us-ascii?Q?63sfKFzj2NWlxTOnTaJGbd6BGiyHkeccbjfYgCelBgSme1lFr2zHuUchf4c7?=
 =?us-ascii?Q?v7O7d5BG25y0uUYW43XWVOX0Uzvrfn8pd9WFQFpgjIDtFqLnaQDZfI4+e8jK?=
 =?us-ascii?Q?4GKlrbZOuiPwWShACgCD/x+Oa0NKylWW6WglNXvGf5/697wwrVqOEl188VqC?=
 =?us-ascii?Q?RbyhVkAQwoR7/i74CBvySH8F8eg5CMdgKjy7NzaDklOzlOuPxGJwYFcSBky3?=
 =?us-ascii?Q?bogMGEZcXRiURyO//uaa8Z6aIphK05gitd8R7dvxJ0vxtOaR0Hfb7qHQhaqM?=
 =?us-ascii?Q?mdWrGu8dHm5m5c2+Ol2IBvttCjw/bHSpqrqKVkLcxR1yL4+32p7Hn2Q+6xcu?=
 =?us-ascii?Q?FyIacVUMU3ueRDEWXkn7S1Q9VCmAvmm4nF8WYP43L90bSZBbjcI7NfBSmt8C?=
 =?us-ascii?Q?lAWkfcy3bv9Gk3ia+tRIua9AnVUuJS8YLVDBM9IZH0KEsbQ4pwRycsS5+tSe?=
 =?us-ascii?Q?ZUMObKqn+c2kAx7D9dWAgRK8ZvYrocRUhR0Eo253TqKnvBMjucer3c+7N5c1?=
 =?us-ascii?Q?xJ0twPgkEAa0mECL6QKmnKaG4xW9vyvX7zT6n0nsFNdjPDMtsUqSs+OOitel?=
 =?us-ascii?Q?Bpisz5YiC4td5dpuhcP0SPGgWuxXA13qUJ0CGxYh890MDrKArsdr13yWYQ9X?=
 =?us-ascii?Q?ZRCyLh1wN0cuHz8WUCMFhyJ9uMFPVYNhghYbBETdxzW+hNw0W2ZDv25AORXX?=
 =?us-ascii?Q?4ehe/R6+UZtoA6DjZHImR7Ghk8NwBYMkNBUUADbeabBG/d3afnSHWc5rMB84?=
 =?us-ascii?Q?I6xYaHeeW34sPpZmShacEaZwcV1rkBSAQ+Y9OZEOsM9bwWlbHzjaOH9mwkGv?=
 =?us-ascii?Q?axgajWIYyusx9JjGlIZfNl99mg6a0kIM86n3fC+n?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df7bf1b8-4898-431f-a130-08dbbf6ec433
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9380.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 15:31:06.3598 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZU08RryC9DLLD7NY4H7frNA5U5WpihBWypPUeGMT/WU4BaELk6RrOlC1FdSS5YVGi0XzXfCWjdgWnFhS/+9TJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9959
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

