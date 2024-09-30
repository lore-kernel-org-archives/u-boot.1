Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8414CF6498
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 02:19:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31854881A2;
	Mon, 30 Sep 2024 04:19:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="oG7txAYP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72532880E6; Mon, 30 Sep 2024 04:19:24 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46B5D8837D
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 04:19:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gCyByXHSM5i/aGKpJLzmk5LLvZSTzNq4SaAFpYakPMk5TRtCQOchbazoqX4Yw1mzvslpF+KQW32NDvnEBxslqkKe/7r0PCWCUp6F0Vva3hUwFrihu7prullMl0K7T6nKoE5VXD7b/JFDd07k81FRlYOykmcCh4uWeI+53PqLsoq+cWRx31wW8dEtbGzkTSOwhh9sUTIZxb+svUcnHMoQWtFGtkHSad5huxjpt/jQmM0qkouuab6KOEnOqwnPw76VAeLb9eVL8sjD7bo4UFjIYuCgDR3ACt+/jfTqvxtGglntUBI182iTZiGJIKbDMuO7j1l3MRLd4gUvhYzRs7BEAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/3LisGlYcnnlJWWgeNGOA9x8/PeD1YTvzTGsdR03Rs=;
 b=s6FpcKUdo2abIqimBqpfO6/GlK55TZVQ+XNah4ze5/+GqnAMIa+4SupyJ1qtIoRxqCDs1rzwly9o9RTL88qHPkJQbShgffipfVaDzb0TtWsOqXLHLPEuorVX0Fg5j+by45Oz6v7gzxXbif9TNRcn+QgqBv5CaiVtyD0xwQz9bV7j/Mmwl1yF6mRadQC3+KdwEfypWOeSDGRzvGa+kkfNcHesr+xFYyak7q778Hr30j3nn/+5Qz6wJ0Jm8QBfEaZ8D4ngM46dHfU2z+xn6t7rDfIRaNPMwSqGB77esJj/OqXgzLKND1QsY9HTtRRkKsg21DfS45zmhAlxbqE8jEUz6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/3LisGlYcnnlJWWgeNGOA9x8/PeD1YTvzTGsdR03Rs=;
 b=oG7txAYPZC9EvaPzQvVgGFxnrqtDIeFfvgvNiUYpM5nussk0PvQ0bqTf3EcT+qHyNZoT5HYQmt3mQJXGUIaa7XYt8wdON5deJ34QGKgOfGwQoQfasb5WS8UT1fZF5KsafFV8l2hFTyllg/9FYBRsxybV7KVsA0/ce9Xmx874aFdaGDzH0QxdL92plL4xN4NisEv38Y+fTAK8Wi3flR5AUT0bF1Cn99F8gTqsEXW8Ee3HwfF3f4u72k/N6rqmaOwqNinXhKOJr2zHqNEXw7ZF8KJiT0zYcKzPfkfgp3xeuVzcsKnV81z6MdVUgePNuZuJjtoLjDhViG+DPD2jNDyTOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8764.eurprd04.prod.outlook.com (2603:10a6:20b:40b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Mon, 30 Sep
 2024 02:19:20 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Mon, 30 Sep 2024
 02:19:20 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com, sbabic@denx.de, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: uboot-imx@nxp.com, Joy Zou <joy.zou@nxp.com>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] power: regulator: Support pmic pf0900
Date: Mon, 30 Sep 2024 11:22:43 +0800
Message-Id: <20240930032244.20286-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240930032244.20286-1-peng.fan@oss.nxp.com>
References: <20240930032244.20286-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:4:186::6) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: 3de4e989-f8d7-41a6-ede6-08dce0f64ad7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pTLnKekynP98e/6btz+tXkK2xumXfNWpJax8BkXFJCcggB7rlGoywNbxwIgq?=
 =?us-ascii?Q?+WpWBkJNNssjaRsTJJsgunqM/pBTvg4KKmfHeOUce6bhNvlQLwCDrD0BRYh+?=
 =?us-ascii?Q?uUWtRXvXfj8MUdxOFraag9RzeT+QM5bMq2Mtocgci73g4aD/0fs0B4ukM+Mm?=
 =?us-ascii?Q?Zx8N97RLiCPjwrbH3BJ7uYf2hyalBf39Zomj6Mdf6/qf/EbiG7bVOkW8dgHq?=
 =?us-ascii?Q?VwcKr8A6FfrsO3rBvt7xFwDTfxMKkkqqUdPVGSoA904smX/BzfIhvhHBzszW?=
 =?us-ascii?Q?9dkq/mqRS13fzR3NATgJbIbK+aw835rscXKqQ/Ilu03OmSkb8S62KKWjq2iK?=
 =?us-ascii?Q?hm+PLtvUsoQALsDry36+Oz9OpgaBLhzzd4Ex1bNeVTqec0JZFIlwCh3alYn6?=
 =?us-ascii?Q?k0ArTdmU/sKdqu1rpRI+cyF+ZJEARu60WdMmWnDc1GwZAcIY4rH6ZTOWuB5I?=
 =?us-ascii?Q?nbD5e+QLUGHz4AcMbeYfKPhSfeBPXo4bKlS9ij9LMvEH+L6p+TYo74JLBvqJ?=
 =?us-ascii?Q?azOg35uiWLc2ZYwG5qyAau3GHF/+y9MS/vaxGJUvOPNeuKGcpVwmw+fFgjny?=
 =?us-ascii?Q?dOkAOgn2y0CRIEuwbkkpkSQZDKIDiLlprCRtz3wyjjUYk4pYbPjuKd8QIAwZ?=
 =?us-ascii?Q?7eryVXpH+t8sdjR82q1x+higb1d5QenXiYiwZEeInj3rLYd8ZEF38ZqHMQSR?=
 =?us-ascii?Q?S+7GFNztRVczc09ImYDF2K+dCKgvkrEX1zNDw+qisJbGDdUB4E7TM0p+Dwl6?=
 =?us-ascii?Q?ped4W5Bug0w8Gpfsg+SEzFfH13BFdMfLNO//mHEq2lRmoIIJQHRixfBS+sGi?=
 =?us-ascii?Q?BvSEQaK2Vg5YZa+o77rHPsAeTXNBx2oZl+ayfZkRSXyMPQX5gBUyY6JMJKL2?=
 =?us-ascii?Q?RcPFSRkvv9n2mY//7W87U/TKf6m6Th9m0MX2svIOkWn8nlQq7LpogO/x4yRs?=
 =?us-ascii?Q?Cn2tO9jYM3UFrQpkYT49PdczySMDWozXwc/Favws60L2ZdV0UvPwpGvCRQgd?=
 =?us-ascii?Q?sp7WOYK4eqDLr9C8fuxQNB5kG/xv5biyBYD3Fs4y3qW7xC9/w0aZp8cvTyG+?=
 =?us-ascii?Q?cSZEoFbxjNezXCooeaR7d+wbM6twmtsVv7uyHIhbjy9auzikmZXaoTUGEhvg?=
 =?us-ascii?Q?N9YuWe2nr4GT+g5py2M8zDbVa4noUXQW3YBaPsL4ni86JIO6txJqsHivNYde?=
 =?us-ascii?Q?oZ4/g/9yB/47j7Fx9cuRFyCuXCCusdpMK5P7jKKxZT+XkLu3bqHvxWQRTKWd?=
 =?us-ascii?Q?CW7y8T1iQpUEg4eeuE6Px3UEFNB01QRK0HpOZSpL/jOkAD27ZfNjN+zRwfMF?=
 =?us-ascii?Q?ydWFxDtfmcILub32LTeDr2Sq49RjAyS3JgE5v9lrGSGurQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EM+Z6s+aKv9+sSmNF33ADgBFRhGVbeSmQbQicqfj4P7wentxUK6T77qcs4S4?=
 =?us-ascii?Q?LMMTtJBksMGBT1nx9embqrE7BdtFCYAdfWAtQKU83o2wc3dKCXk1H9ThGnrI?=
 =?us-ascii?Q?tNTg5/JlZkYoXB2yF9B/inUk52yJmqb/jSpD3ThVICobi0QPLaP7FwKuKv97?=
 =?us-ascii?Q?Rn4oDyQ+CJotYxAPkuLpEFziKTdEK9Faor7iWpiWH/EkZgO5Gz8p5gQJSY7e?=
 =?us-ascii?Q?a4HCTGvsmceicPKmCO4kflnrDeFQcYXQqF0vtknWDjdTmDuMWaoYD+vGvGn6?=
 =?us-ascii?Q?c2rLfYQb1JR82hUTyum6t5aRP/Oz9qZYBzJfyAu7z02xTrS2KQAfGhDkpyml?=
 =?us-ascii?Q?TkyS/GF7hUoL+SUig7bdaFvi/VPdXup53aYvCIQE9OFIJ7mSZBSo9QDQ+3C2?=
 =?us-ascii?Q?Qja4raL8pAF4KANBXVjjwmGx6FZMaf6ZibaGBCOXCg3PvukbHGbHTME4d3cF?=
 =?us-ascii?Q?yOO6JxZaOEaVzbA/zpfho81pZyGl09B7QqZvAC0zuxyEOAAJ3rUXhRkso5Uw?=
 =?us-ascii?Q?6qnSzYJwTQM+dCnxVhOu6zhgt/hY9BuuFhi50U7lnzCoXx3xy3LiPita0R5x?=
 =?us-ascii?Q?CkFU62io7V2IcaXvKQ1e9oEBiJjFiC+lmE3Uq9WmdGyfJzxJbKJawmnFsKAv?=
 =?us-ascii?Q?rIiN2TeFwf7Pm3Ep48nYCvHnRK3EdT6AZKyz7G47Y06wOceHN6VKmgJIYddd?=
 =?us-ascii?Q?G7ggVX7NQbG5NAL+wodj4QUuxcg5T7jjNmK4sUl3KvKZ500VAsMFTdzy5yHr?=
 =?us-ascii?Q?fCqqtwJHcu5MpqTgMS1oynMELVl1yKi5uJpeMiwCety4LrxASwaZLnOzIEmY?=
 =?us-ascii?Q?kzmPnxUFpdt2oDfwBSaKE8OC+aWLUv1Hbt99JQQf8VaAFSuJ9QEDhaPrlDWT?=
 =?us-ascii?Q?9vDCixo/dzPUSkgtYcjm9qgh02HW4RDiXOR9YR89wyeAtKHZj+Xp7jfK0jl5?=
 =?us-ascii?Q?+ri5ny5UB+O4VUikE93FYZdZ2v6u7gU75be89ADVkGhL9zYzp73unr5i8ZIV?=
 =?us-ascii?Q?LWMVp7UFVUe1OBLCNuIhel68RBiOR11yFrKOygeLCow6ID8BtKDKZAoTjcNp?=
 =?us-ascii?Q?qLsCr8xPrkCVaqM3jEqokpzz3vAK+4INHzx7ZLBiTba7k8RtltHHgXHwQBVN?=
 =?us-ascii?Q?h+Tq96h44qFh9JzvBIkp0MU+3bDk2u9iGOAMF3thAVXygU0910Nc8JQruDIo?=
 =?us-ascii?Q?l5WXRZ84KgRXDY2i1uAjiloiY+umyyiLg1SWQ+8O9QYqvWXVlmD+iTHtZ6hd?=
 =?us-ascii?Q?jrylkpv1O0J5tXNjWCGdEWBg+dOkfS/DNbkKyhb8likPjq81bKY2nZHrAf6i?=
 =?us-ascii?Q?NADMHsRLO6hsA2MGkgOdbuoFtjlvWIL/RqowFSaBet2Hv/YvMz7SeVoF0CAI?=
 =?us-ascii?Q?QkptrNYh9JBnTH6MH74XZcUyzMr3wU5YF0jvBTbVRcMESfNOCptCHZWuwCHj?=
 =?us-ascii?Q?tc1HTuqaQYMf0ZKLuFkDHv/kCCQ8hjrLTHBW/Z63IK5JrqaXr37TNGnqDQ8S?=
 =?us-ascii?Q?HWD+css8qH7s30fdJQ7M0U+aJo9iv4dgz2WTAiHHGxxd4OGTecaAWTl7fYlF?=
 =?us-ascii?Q?34xLQ5CNxTOyTM8qLRpSE7hEFBNETvvaz2+5FI2Q?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de4e989-f8d7-41a6-ede6-08dce0f64ad7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 02:19:20.3847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yim5n0CQXlhcAHQtl6vcuvQ6JtNVLIBzA6d/FoE2wFs/lTBI3Cuy7LI5VoQG5Nu5f3zJ6/899fQaSyPLiS4r7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8764
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

From: Joy Zou <joy.zou@nxp.com>

Add regulator driver for NXP PF0900

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/power/regulator/Kconfig  |  15 ++
 drivers/power/regulator/Makefile |   1 +
 drivers/power/regulator/pf0900.c | 304 +++++++++++++++++++++++++++++++
 3 files changed, 320 insertions(+)
 create mode 100644 drivers/power/regulator/pf0900.c

diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
index 958f337c7e7..b2f487b050b 100644
--- a/drivers/power/regulator/Kconfig
+++ b/drivers/power/regulator/Kconfig
@@ -96,6 +96,21 @@ config SPL_DM_REGULATOR_PCA9450
 	This config enables implementation of driver-model regulator uclass
 	features for regulators on ROHM PCA9450 in SPL.
 
+config DM_REGULATOR_PF0900
+	bool "Enable Driver Model for NXP PF0900 regulators"
+	depends on DM_REGULATOR && DM_PMIC_PF0900
+	help
+	This config enables implementation of driver-model regulator uclass
+	features for regulators on NXP PF0900 PMICs. PF0900 contains 1 vaon,
+	5 sws and 3 LDOS. The driver implements get/set api for value and enable.
+
+config SPL_DM_REGULATOR_PF0900
+	bool "Enable Driver Model for NXP PF0900 regulators in SPL"
+	depends on DM_REGULATOR_PF0900 && SPL
+	help
+	This config enables implementation of driver-model regulator uclass
+	features for regulators on ROHM PF0900 in SPL.
+
 config DM_REGULATOR_DA9063
 	bool "Enable Driver Model for REGULATOR DA9063"
 	depends on DM_REGULATOR && DM_PMIC_DA9063
diff --git a/drivers/power/regulator/Makefile b/drivers/power/regulator/Makefile
index 54db0885657..a49700dfd25 100644
--- a/drivers/power/regulator/Makefile
+++ b/drivers/power/regulator/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_DM_REGULATOR_NPCM8XX) += npcm8xx_regulator.o
 obj-$(CONFIG_$(SPL_)DM_PMIC_PFUZE100) += pfuze100.o
 obj-$(CONFIG_$(SPL_)DM_REGULATOR_BD71837) += bd71837.o
 obj-$(CONFIG_$(SPL_)DM_REGULATOR_PCA9450) += pca9450.o
+obj-$(CONFIG_$(SPL_)DM_REGULATOR_PF0900) += pf0900.o
 obj-$(CONFIG_$(SPL_)REGULATOR_PWM) += pwm_regulator.o
 obj-$(CONFIG_$(SPL_)DM_REGULATOR_FAN53555) += fan53555.o
 obj-$(CONFIG_$(SPL_)DM_REGULATOR_COMMON) += regulator_common.o
diff --git a/drivers/power/regulator/pf0900.c b/drivers/power/regulator/pf0900.c
new file mode 100644
index 00000000000..a56ad8fde32
--- /dev/null
+++ b/drivers/power/regulator/pf0900.c
@@ -0,0 +1,304 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * NXP PF0900 regulator driver
+ * Copyright 2023 NXP
+ *
+ */
+
+#include <dm.h>
+#include <errno.h>
+#include <log.h>
+#include <linux/bitops.h>
+#include <power/pf0900.h>
+#include <power/pmic.h>
+#include <power/regulator.h>
+
+/**
+ * struct pf0900_vrange - describe linear range of voltages
+ *
+ * @min_volt:	smallest voltage in range
+ * @min_sel:	smallest selector in the range
+ * @max_sel:	maximum selector in the range
+ * @step:	how much voltage changes at each selector step
+ */
+struct pf0900_vrange {
+	unsigned int	min_volt;
+	u8		min_sel;
+	u8		max_sel;
+	unsigned int	step;
+};
+
+/**
+ * struct pf0900_plat - describe regulator control registers
+ *
+ * @name:	name of the regulator. Used for matching the dt-entry
+ * @enable_reg:	register address used to enable/disable regulator
+ * @enablemask:	register mask used to enable/disable regulator
+ * @volt_reg:	register address used to configure regulator voltage
+ * @volt_mask:	register mask used to configure regulator voltage
+ * @ranges:	pointer to ranges of regulator voltages and matching register
+ *		values
+ * @numranges:	number of voltage ranges pointed by ranges
+ */
+struct pf0900_plat {
+	const char		*name;
+	u8			enable_reg;
+	u8			enablemask;
+	u8			volt_reg;
+	u8			volt_mask;
+	struct pf0900_vrange	*ranges;
+	unsigned int		numranges;
+};
+
+#define PCA_RANGE(_min, _sel_low, _sel_hi, _vstep) \
+{ \
+	.min_volt = (_min), .min_sel = (_sel_low), \
+	.max_sel = (_sel_hi), .step = (_vstep),\
+}
+
+#define PCA_DATA(_name, enreg, enmask, vreg, vmask, _range) \
+{ \
+	.name = (_name), .enable_reg = (enreg), .enablemask = (enmask), \
+	.volt_reg = (vreg), .volt_mask = (vmask), .ranges = (_range), \
+	.numranges = ARRAY_SIZE(_range) \
+}
+
+static struct pf0900_vrange pf0900_vaon_vranges[] = {
+	PCA_RANGE(0,       0x00, 0x01, 0x00),
+	PCA_RANGE(1800000, 0x00, 0x01, 0x00),
+	PCA_RANGE(3000000, 0x00, 0x01, 0x00),
+	PCA_RANGE(3300000, 0x00, 0x01, 0x00),
+};
+
+static struct pf0900_vrange pf0900_sw1_vranges[] = {
+	PCA_RANGE(0,        0x00, 0x08, 0),
+	PCA_RANGE(500000,   0x09, 0x91, 6250),
+	PCA_RANGE(0,        0x92, 0x9E, 0),
+	PCA_RANGE(1500000,  0x9F, 0x9F, 0),
+	PCA_RANGE(1800000,  0xA0, 0xD8, 12500),
+	PCA_RANGE(0,        0xD9, 0xDF, 0),
+	PCA_RANGE(2800000,  0xE0, 0xF4, 25000),
+	PCA_RANGE(0,        0xF5, 0xFF, 0),
+};
+
+static struct pf0900_vrange pf0900_sw2345_vranges[] = {
+	PCA_RANGE(300000,   0x00, 0x00, 0),
+	PCA_RANGE(450000,   0x01, 0x91, 6250),
+	PCA_RANGE(0,        0x92, 0x9E, 0),
+	PCA_RANGE(1500000,  0x9F, 0x9F, 0),
+	PCA_RANGE(1800000,  0xA0, 0xD8, 12500),
+	PCA_RANGE(0,        0xD9, 0xDF, 0),
+	PCA_RANGE(2800000,  0xE0, 0xF4, 25000),
+	PCA_RANGE(0,        0xF5, 0xFF, 0),
+};
+
+static struct pf0900_vrange pf0900_ldo1_vranges[] = {
+	PCA_RANGE(750000,   0x00, 0x0F, 50000),
+	PCA_RANGE(1800000,  0x10, 0x1F, 100000),
+};
+
+static struct pf0900_vrange pf0900_ldo23_vranges[] = {
+	PCA_RANGE(650000,   0x00, 0x0D, 50000),
+	PCA_RANGE(1400000,  0x0E, 0x0F, 100000),
+	PCA_RANGE(1800000,  0x10, 0x1F, 100000),
+};
+
+static struct pf0900_plat pf0900_reg_data[] = {
+	PCA_DATA("VAON", PF0900_REG_VAON_CFG1, VAON_1P8V,
+		 PF0900_REG_VAON_CFG1, VAON_MASK,
+		 pf0900_vaon_vranges),
+	PCA_DATA("SW1", PF0900_REG_SW1_MODE, SW_RUN_MODE_PWM,
+		 PF0900_REG_SW1_VRUN, SW_VRUN_MASK,
+		 pf0900_sw1_vranges),
+	PCA_DATA("SW2", PF0900_REG_SW2_MODE, SW_RUN_MODE_PWM,
+		 PF0900_REG_SW2_VRUN, SW_VRUN_MASK,
+		 pf0900_sw2345_vranges),
+	PCA_DATA("SW3", PF0900_REG_SW3_MODE, SW_RUN_MODE_PWM,
+		 PF0900_REG_SW3_VRUN, SW_VRUN_MASK,
+		 pf0900_sw2345_vranges),
+	PCA_DATA("SW4", PF0900_REG_SW4_MODE, SW_RUN_MODE_PWM,
+		 PF0900_REG_SW4_VRUN, SW_VRUN_MASK,
+		 pf0900_sw2345_vranges),
+	PCA_DATA("SW5", PF0900_REG_SW5_MODE, SW_RUN_MODE_PWM,
+		 PF0900_REG_SW5_VRUN, SW_VRUN_MASK,
+		 pf0900_sw2345_vranges),
+	PCA_DATA("LDO1", PF0900_REG_LDO1_RUN, LDO1_RUN_EN_MASK,
+		 PF0900_REG_LDO1_RUN, VLDO1_RUN_MASK,
+		 pf0900_ldo1_vranges),
+	PCA_DATA("LDO2", PF0900_REG_LDO2_RUN, LDO2_RUN_EN_MASK,
+		 PF0900_REG_LDO2_RUN, VLDO2_RUN_MASK,
+		 pf0900_ldo23_vranges),
+	PCA_DATA("LDO3", PF0900_REG_LDO3_RUN, LDO3_RUN_EN_MASK,
+		 PF0900_REG_LDO3_RUN, VLDO3_RUN_MASK,
+		 pf0900_ldo23_vranges),
+};
+
+static int vrange_find_value(struct pf0900_vrange *r, unsigned int sel,
+			     unsigned int *val)
+{
+	if (!val || sel < r->min_sel || sel > r->max_sel)
+		return -EINVAL;
+
+	*val = r->min_volt + r->step * (sel - r->min_sel);
+	return 0;
+}
+
+static int vrange_find_selector(struct pf0900_vrange *r, int val,
+				unsigned int *sel)
+{
+	int ret = -EINVAL;
+	int num_vals = r->max_sel - r->min_sel + 1;
+
+	if (val >= r->min_volt &&
+	    val <= r->min_volt + r->step * (num_vals - 1)) {
+		if (r->step) {
+			*sel = r->min_sel + ((val - r->min_volt) / r->step);
+			ret = 0;
+		} else {
+			*sel = r->min_sel;
+			ret = 0;
+		}
+	}
+	return ret;
+}
+
+static int pf0900_get_enable(struct udevice *dev)
+{
+	struct pf0900_plat *plat = dev_get_plat(dev);
+	int val;
+
+	val = pmic_reg_read(dev->parent, plat->enable_reg);
+	if (val < 0)
+		return val;
+
+	return (val & plat->enablemask);
+}
+
+static int pf0900_set_enable(struct udevice *dev, bool enable)
+{
+	int val = 0;
+	int tmp = 0;
+	struct pf0900_plat *plat = dev_get_plat(dev);
+
+	if (enable)
+		tmp = plat->enablemask;
+	val = pmic_reg_read(dev->parent, plat->enable_reg);
+	if (val < 0)
+		return val;
+	val = (tmp & plat->enablemask) | (val & (~plat->enablemask));
+
+	return pmic_reg_write(dev->parent, plat->enable_reg, val);
+}
+
+static int pf0900_get_value(struct udevice *dev)
+{
+	struct pf0900_plat *plat = dev_get_plat(dev);
+	unsigned int reg, tmp;
+	int i, ret;
+
+	ret = pmic_reg_read(dev->parent, plat->volt_reg);
+	if (ret < 0)
+		return ret;
+
+	reg = ret;
+	reg &= plat->volt_mask;
+
+	if (!strcmp(plat->name, "VAON"))
+		return plat->ranges[reg].min_volt;
+
+	for (i = 0; i < plat->numranges; i++) {
+		struct pf0900_vrange *r = &plat->ranges[i];
+
+		if (!vrange_find_value(r, reg, &tmp))
+			return tmp;
+	}
+
+	pr_err("Unknown voltage value read from pmic\n");
+
+	return -EINVAL;
+}
+
+static int pf0900_set_value(struct udevice *dev, int uvolt)
+{
+	struct pf0900_plat *plat = dev_get_plat(dev);
+	unsigned int sel;
+	int i, val, found = 0;
+
+	for (i = 0; i < plat->numranges; i++) {
+		struct pf0900_vrange *r = &plat->ranges[i];
+
+		if (!strcmp(plat->name, "VAON")) {
+			if (r->min_volt == uvolt) {
+				sel = i;
+				found = 1;
+				break;
+			}
+
+			continue;
+		}
+
+		found = !vrange_find_selector(r, uvolt, &sel);
+		if (found) {
+			unsigned int tmp;
+
+			/*
+			 * We require exactly the requested value to be
+			 * supported - this can be changed later if needed
+			 */
+			found = !vrange_find_value(r, sel, &tmp);
+			if (found && tmp == uvolt)
+				break;
+			found = 0;
+		}
+	}
+
+	if (!found)
+		return -EINVAL;
+
+	val = pmic_reg_read(dev->parent, plat->volt_reg);
+	if (val < 0)
+		return val;
+	val = (sel & plat->volt_mask) | (val & (~plat->volt_mask));
+	return pmic_reg_write(dev->parent, plat->volt_reg, val);
+}
+
+static int pf0900_regulator_probe(struct udevice *dev)
+{
+	struct pf0900_plat *plat = dev_get_plat(dev);
+	int i, type;
+
+	type = dev_get_driver_data(dev_get_parent(dev));
+
+	if (type != PF0900_TYPE_PF0900) {
+		debug("Unknown PMIC type\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(pf0900_reg_data); i++) {
+		if (strcmp(dev->name, pf0900_reg_data[i].name))
+			continue;
+
+		*plat = pf0900_reg_data[i];
+
+		return 0;
+	}
+
+	pr_err("Unknown regulator '%s'\n", dev->name);
+
+	return -ENOENT;
+}
+
+static const struct dm_regulator_ops pf0900_regulator_ops = {
+	.get_value	= pf0900_get_value,
+	.set_value	= pf0900_set_value,
+	.get_enable	= pf0900_get_enable,
+	.set_enable	= pf0900_set_enable,
+};
+
+U_BOOT_DRIVER(pf0900_regulator) = {
+	.name		= PF0900_REGULATOR_DRIVER,
+	.id		= UCLASS_REGULATOR,
+	.ops		= &pf0900_regulator_ops,
+	.probe		= pf0900_regulator_probe,
+	.plat_auto	= sizeof(struct pf0900_plat),
+};
-- 
2.35.3

