Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 804D4CF6491
	for <u-boot@archiver.kernel.org>; Sun, 29 Sep 2024 01:33:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDA5788BE4;
	Sun, 29 Sep 2024 03:33:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="J12dK96b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C088D88BE4; Sun, 29 Sep 2024 03:33:40 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3D4B889B3
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 03:33:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cT8723ki+Qp5UHKb386E96+/bm8d0qYeQ/8wdJkclT6LpwmgWPBGp1rSBcWolUZ941okGZgCuzgz3LWORY/VN7GRCWLun9DBz6393WlqUCt0TK+tGhs3nYcmojbmztADSkpAw9p/IMunoQbZ4QNIaOHbmHce+1ueX4oNxXRrRCaFK1YmsOPMUM9Ht/hGPx9RqEgb7p3j7E02REUeQuydO0r9kFMNUfb9GGYqMjZ8NpFSmSwC5T35gcA4Ww1PEWroJdiQipqwhy5IWm7d14iHTAx8EYi0ie9rN9IUMZQ+84YX0bo+p+cco69ylZEF2F7gXccxWZwfl6+qWDJhcJYKtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BmQJdC1xzJ8m2GMOhYod5/xwRzdi/fli5+pbeVWlwY=;
 b=LdxsO2ubRyKu0xsRLJd77wkcpRwiYKdhfGTD6aTc2X5uH5n2meLpdA7TkvztowTeYPstVcjGWaA7Oc3C29VdHugfqJWMxcd2p0udAi7jzqjFx8DdIDvrq04lL/4p+y5t4QcHzuxl6cspw3duWFr/8ERNAPvnStPoggiNwBCeF5RscBJNJcIs6qNM570WjHk6B2+IoBfjVcdY1aWRC5GuB4H6hBC9TrrF8xM0/0/VFnaUtZ+QElfEHV8BH66OxQml+rBvun6YT/R2ZAO/bNIxxTE/UFfM+eZGPpENnFLerOWXEswm6hId4TeuJC4s6w7A2GnptrC0n3vcnkaRIoGhOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BmQJdC1xzJ8m2GMOhYod5/xwRzdi/fli5+pbeVWlwY=;
 b=J12dK96bpvHiBxyJsCQS90Zc5jHl68e4NNbHU9717lj/mnobWMTdOt2i3XXi1tYsiCFxBTQQTISIzte5xAfJP+kaA1BtXfQwE83lhxj+qTVB5L+KovEmsxzm1KmbmNsaOQuJMkJvtBvm21Tdomf4JAQMdQ4xYd6Tfi0nmZ7MmqA0hNMdy2kArzC6KqL+jDH/+Lh70pnlYoskcIAry7WBXRGEQWdn8xRFV4/YApVbe3WFI/ucbvRY7XJiW6E+q7nCfmXjsCipHq3dkQ10+X3T/HGFEW606QHqBxqpmIH2RSgCwfX58OLL8+8AmorlmzEAvZV/meWkd8gNeqPUGpCN1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA1PR04MB10772.eurprd04.prod.outlook.com (2603:10a6:102:48c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.24; Sun, 29 Sep
 2024 01:33:30 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8005.024; Sun, 29 Sep 2024
 01:33:30 +0000
From: alice.guo@oss.nxp.com
To: u-boot@lists.denx.de,
	festevam@gmail.com
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org, clamor95@gmail.com,
 paul.barker.ct@bp.renesas.com, michal.simek@amd.com,
 andre.przywara@arm.com, ye.li@nxp.com, jim.t90615@gmail.com,
 billy_tsai@aspeedtech.com, kabel@kernel.org, caleb.connolly@linaro.org,
 biju.das.jz@bp.renesas.com, sr@denx.de, piotr.wojtaszczyk@timesys.com,
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2] gpio: adp5585: Add SPL config for ADP5585 driver
Date: Sun, 29 Sep 2024 09:32:26 +0800
Message-Id: <20240929013226.2750458-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:195::8) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA1PR04MB10772:EE_
X-MS-Office365-Filtering-Correlation-Id: a3fe7d2d-361c-4e5f-008c-08dce026b917
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|366016|7416014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gpfCVU1d/lIbIbHbhJxO5z678OQhr54shCxxSACUi+xlPPKkZq2949Ab/j78?=
 =?us-ascii?Q?9rNP0G6ZtXJXSc3RZrBQD1jC7ZeSnfwGdsufM1zdea2ofqNQ1sUA0cYzDBr4?=
 =?us-ascii?Q?9ejNaN4VrPhaeUztDUeB2qUv+p/R/d/EIvWDQo2sAhFmioJVOkbwkCzwYsRN?=
 =?us-ascii?Q?krNNI3lpfJTgMcTTyYDsdmy+KNEUwFnY3RDwsedC7ectrwq0TyoICjLCJBwm?=
 =?us-ascii?Q?+I5ny8PmKUsGHaiHZlcdJ+hx8uXw6AJ8v08sM0fZJwRewXMDHwBupNGONlky?=
 =?us-ascii?Q?hTkwUus9LYSG9lsp/zEw1mBy9eilZHUSFiFt6qvJv4Je0/adkRhypvmNKuQo?=
 =?us-ascii?Q?L2aUHUevffl2MR6wXeH3vzoHY+0rqgkn4x5Jzo5Y+jbRabm89I0jrkUxMBDW?=
 =?us-ascii?Q?aEqFQ2Evltgb5LXIu+npDv08wGqE/L5HjOiQoK/4rFDZuqg/aZjVwUD1VWys?=
 =?us-ascii?Q?9a69qf6G44zeEbZFG7RUBIWKhQ3NCcDTMw/6oi8oZUIHoxpp674iUoi3JWrC?=
 =?us-ascii?Q?8RPN5Xzpj36KWLmN2ya1v7QCYIZF9euUvC9oic4LovZbm2a80Vw0IWgDpR7+?=
 =?us-ascii?Q?H4lpzdBY8iCaO6xOs4StVBMk5ep+V9x7p6ia+F/8oALlg+0Owgf13A4a+Ywb?=
 =?us-ascii?Q?2MsNzv/r63D/71LvY8S0ARu8+jQbzigcJy7AkZexcfcf6meL2dShBKVgr2Wj?=
 =?us-ascii?Q?tUjCcHFlLP/+78wa1fqs0XRlfgelRjq/miq289AXci4m89RAJvcdwKwcMsv7?=
 =?us-ascii?Q?7thHIqON50NPeyR067kyrhmWY8QmIjm75hbR6wfP5ZaDNTc/J1EqtwlahoRU?=
 =?us-ascii?Q?b4LNO+46BrJeYRZB+NHf0VVhQ1fyNhqeRyD7prbQozFW2B5qdASW1coC/qBK?=
 =?us-ascii?Q?hcyOfROqfR2TYzK5JCQ6JTPSeo+Wu6NWYOHr2BQpdEko7UsXRz9udE+7pMAJ?=
 =?us-ascii?Q?p5+EXPxOayQwuOeXUg73Lpcbutjhmo0jbbXDGvQxqCBVERCDPF8xAskN11BM?=
 =?us-ascii?Q?YWQSu1rbA2DNSovnrcmSgG8g+l31w46tZMnBOA7TdqWNRUdvG8a/DfKMcnCU?=
 =?us-ascii?Q?3GP1bNTH/ymH63a9fxxekjJxVPXDqKqaO9j3iJCpQWE7ty4yPNRs84O7Cf8+?=
 =?us-ascii?Q?FCOD7mgBNBxVpSVx1PMAVB4HOF3g0XjjScKAe7cJy/Y0jacx5g2GW6N3LrJg?=
 =?us-ascii?Q?WzdtWtILpruXNx8l13jd6de/qyMR5u9pTOG345i5aBokqpIa37F3DypOpR2z?=
 =?us-ascii?Q?/hGWTbXKyM0WsV5M57CPonveLlshP9Q2/4K1FtItpA9rjom3wsLXajnGEz2A?=
 =?us-ascii?Q?x9yB30unhkBxG6sS1iNYfS8qoiACv/zY44reSnMQvY+l4bycBRf4EzH+yG+P?=
 =?us-ascii?Q?AuFTOURI3O8KQowbxa91S9SBErU0WXv1qCuAlx+wZ5OkgVSGEw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(366016)(7416014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bLwEen8csvKp8Ej/WeYH4toqd4+AD4yLkRVLYjy9KGlholZpI18mS//S1Pdh?=
 =?us-ascii?Q?X/qGWRvRVNSYiA0e7PY0XIYY/1sXftEGQcBFuRbjhgTeGSLedj2Tv5JcLn5H?=
 =?us-ascii?Q?2lTH/KYesJkXL+6xqw/y94tf+C2TGVIWvFo7iSuPxjj7MweXdSLrAQ0qVLb0?=
 =?us-ascii?Q?hkrnNUWBBxqaQvMzsIxlDcNgK3n1tDfypUcGwiVPMZXYcfsdR9OiYq8mibvd?=
 =?us-ascii?Q?LT8Up3IVsDliaZ2VpeW8NLhFwJggnStyMf1PTbwQcoY4r82SEhms5fUvkR6D?=
 =?us-ascii?Q?dOkR6KmtQiXbK1lkLEv5l31IK0NrjllXFicMc+8NTcidObEnwTjD5xpPvSr4?=
 =?us-ascii?Q?D90Rp2yHJKPvCCsKl8SA9xut7UcvDPx8vUmg9AvDxGDAuTp8O8qe3Ts10WrW?=
 =?us-ascii?Q?onhHUKfVR6cjdLw0q37Gy34SxncJYnxxa3S0lFDVCH47PvZvae7YB/zFIYxv?=
 =?us-ascii?Q?Ppul3XVqHzbbj0EIWZYU4+SJkmks4UkgAaFy4GV5+hpND17vhmHLgJgtXimt?=
 =?us-ascii?Q?eYHehcb5Vo1MDXQnptB1kMQYI9sz3ejF1bqgdUMWsklRNmBVDtuyqZKbtEF6?=
 =?us-ascii?Q?NeOs9Uvya4DZg3RJFnyBty8UFtp0gB3ibfJkruB//0jz5E900Me+pE/tycbE?=
 =?us-ascii?Q?RjHlBu6rsxZugViwjC5rZgua5h68iaRTl+vuTEKnAsmNo0O7vvpDUHsmiPIM?=
 =?us-ascii?Q?pVd/O4RZZNnmWQcl1oLNe6AnMgl5RpAmiZ5bE39M2ODEt/Oq0TK5wQaMlV1L?=
 =?us-ascii?Q?7UGKoGllEsro51ztHbUWSnImIzVZni9o+c2ng0EEn8RyNLMWqPyN8HGV1G56?=
 =?us-ascii?Q?wvLXSHMnQFnz0OM9/SHR1FjOdkSgwlZF4xYxwyT0e1lw4cQnmTvZvvYQGaKK?=
 =?us-ascii?Q?7zpZNgfWHPjRK0fIHB3chpCH92CoqANaVVmZoaOKtuuzCWnb94itvk3XMfqZ?=
 =?us-ascii?Q?Cv9Z4MPcRLhwFR8E9R8JjNg196z/BsyOKgSDtBB6Z9njTP9H3UoVwDXlgBwW?=
 =?us-ascii?Q?eCO0v4WfmBLRu9iYf8/gi9gQxLDIhmn5qWy1Gxw40Zvrn+BpDPmu6Sy2IOwu?=
 =?us-ascii?Q?j6gmcqN14gum98AtALS+Lqo8UFoticpetkZPdAdYAI0BrnqAXsCn6EtKlvhY?=
 =?us-ascii?Q?DGx6hztURdbErAh2P4+HargLbRuS8ocxrTiNtPLDNFq1gicXxXlsQ/4TULEH?=
 =?us-ascii?Q?FxXb0n2Fdh7VJYUgx2HgVz1CJQd/675nzcgnWd7hnh8XrQKY7znPobMKX1r8?=
 =?us-ascii?Q?0sp1c2lP2oN6mP/JgMWnFsLg5BbGRnBb29icoi+TNmy/5l1k914MK4MERE84?=
 =?us-ascii?Q?vT78kWfu6XcZgIahJnTks6NQ91jECMXWtXt0jX+WT05RvLtCbBgNpr2h2cIg?=
 =?us-ascii?Q?nPROEHiaE4SVyMuFFnS26ktDTDK4GolLai13YBSRj0y1HxUYfI+2gPUAAy5H?=
 =?us-ascii?Q?ZLofI3Fyh3uT6NjnoF9PmZcc4ecqsf7jrGdYsOBzCKMvZQNacKMDHrocx3Ma?=
 =?us-ascii?Q?q6ZNaVEs0beIbO8ydARe2xdqwVYT397HElJvaHt3F0wJeCkzDFu67vV6kRJe?=
 =?us-ascii?Q?FJRdmrkVRsYapgJexP6zf6/m9xsJ4yh3suazMl1Y?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3fe7d2d-361c-4e5f-008c-08dce026b917
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2024 01:33:30.2476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9bN63jZy2npdtLp90kPQK8GDr1/YceI2Zh1cf/t5o1ya8IQE5kXqhrC5XBdFLbT8WXR0pW7wiRmEPTn2+a30yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10772
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

From: Ye Li <ye.li@nxp.com>

So we can disable to build ADP5585 in SPL to save size

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
Changes for v2:
 - added my Signed-off-by

 drivers/gpio/Kconfig  | 6 ++++++
 drivers/gpio/Makefile | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 3996333fe8..1e5711663e 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -700,4 +700,10 @@ config RZG2L_GPIO
 	  Support the gpio functionality of the pin function controller (PFC)
 	  on the Renesas RZ/G2L SoC family.
 
+config SPL_ADP5585_GPIO
+	bool "ADP5585 GPIO driver in SPL"
+	depends on SPL_DM_GPIO && SPL_I2C
+	help
+	  Support ADP5585 GPIO expander in SPL.
+
 endif
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index da0faf0524..56c20e4c63 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -76,5 +76,5 @@ obj-$(CONFIG_SL28CPLD_GPIO)	+= sl28cpld-gpio.o
 obj-$(CONFIG_ZYNQMP_GPIO_MODEPIN)	+= zynqmp_gpio_modepin.o
 obj-$(CONFIG_SLG7XL45106_I2C_GPO)	+= gpio_slg7xl45106.o
 obj-$(CONFIG_FTGPIO010)		+= ftgpio010.o
-obj-$(CONFIG_ADP5585_GPIO)	+= adp5585_gpio.o
+obj-$(CONFIG_$(SPL_)ADP5585_GPIO)	+= adp5585_gpio.o
 obj-$(CONFIG_RZG2L_GPIO)	+= rzg2l-gpio.o
-- 
2.34.1

