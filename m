Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B196DD60D0C
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 02:09:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A69EA89442;
	Tue, 19 Nov 2024 03:08:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D5F889258; Tue, 19 Nov 2024 03:06:01 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20711.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::711])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAF16892EF
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 03:05:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRlN9Xsn+cyR/0kgzwGA009KcXDo3oC7KgZryfQusu82A1OOxvHa5gJMyY6yuNF1Nt2736sO9SeUEJZjJGVEl3CoOV32bJZVH3VdDBFrchireTYtSZMzKkNnWyh6EQUlQDKd+fL0t2PX/0O3Q/eeJxO+BrR5QKW4DOctA7/4hj0YuxX1BvSOli/fv9DiZLqgwnDk0xSkjMuTET2mieM3tLD7xMeagSAjnAK/5RUs0c1BfZmqh6CCAkXjQ9nTkbMFyfast2TPQ2YIYfcLMcFiNOFQYvRuvvvGsTLlhVOMkwyHQjTPpPDLhKTcHqj1fvAh1yxbILJVS/f8KBApJwH7gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMUGOskJCJMmK5wG40VxQMgyiWbSlG+yfT92NZdv5X8=;
 b=mlNTE/tUtY2tR1BxwQPG+i7pzdvdWSYDg0gEt7WzrMxx7OHd3cudwvuLhUdCV22y2+zvRqRymkjxwb4bxqX1lbAxJQTeZI17r34Da/9HRa0g3XntDjezYNzGyOqJ2ZvVvEE8qbBewy0SAgefjbwlTSGn3irS4GJlrmpWNJP/ZJvBzJgPIVUCbADnW0fTiWOK2wB1MvozFvPKEDMCVts6j7y+Lh4bdPq7PU/qV23MdJyKAwO+omCTMID7U15eP4jivqLk9kJv9jg2R30W9iW4sGipHgsMC4H4Z8gT8r4Fwc3CXKQXpILKYnCYqX7D6bfaSDX8xIbxdJXhhviDEswhcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1292.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 02:06:04 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 02:06:04 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v5 03/11] pcie: starfive: Make the driver compatible with
 upstream DT
Date: Tue, 19 Nov 2024 10:04:17 +0800
Message-ID: <20241119020425.51989-4-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241119020425.51989-1-hal.feng@starfivetech.com>
References: <20241119020425.51989-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0035.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::21) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1292:EE_
X-MS-Office365-Filtering-Correlation-Id: 034d2c78-260d-4919-5ceb-08dd083eb8fc
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|41320700013|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info: kBWdPu951WJ/Rp8+N+efk7ze3wWnNrjg+jyJaNERwS5fDv9/d0nsvHPb7PQghNr2Dy6u+NXOoXhujdXdUEabSr40Xjs/v5B9wRNviz36cYtobC8SotBO/M41Hz5qOOL/m0VUcnlS2Dv8SG1Y9z69SAOq8h0jpGB+/dR92MiQSKiedVQlZfKQW+HJh9imxj/s0yJXkxFdxYaFBWLlunnskpMjm50klS+DVEBmUbu0Ih5ahupFXJo7Mm24LaN8CPXjVAP6ttPN5DvS4nuqFFBkeITssq4vUBYqNctWZgQSZ/VLq1rdu5aoSTizYGIF4EJVDz4hzTqcRDNUbaTQ4Iw3XlLgM0rQo2E1X8Xglemi6P+eBoB6lef8c20zK/LgEzbml282KL9vkfHiVf4kKDH+ypeBzTn1BcxwDWkbYtywz7urrMHlgezBdMfC7goR8UQRI2obfthlXl8BHV4mInUEjd6Gx3yVhqC+vuQonPuMEOPJmkhF3bwiiQBpYgT2LjgmzLu5+wxmeJSdJzRrZDdM8c/ZWqiao/YNA0DBaTd1F/RJ5BLL2UaGGcF5LSASyzCAm4uyktEie+JBR5jAbg3ALBEks5Cno0Tt6z4s23x65IqXYBY09KN6I7i2RMtJZ6FFBSBeujrYoZQ/EAMowkazOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(41320700013)(52116014)(7416014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?erXGE81OOYS0qDQWv2sJyWxfYFIkdA06P/RKm/OnKYbzishqwd66OpT0t3wN?=
 =?us-ascii?Q?xTfJuDDqaJKZEQnHAn3VVJKHeIpSxa0BfVUgbjhCtnc/K2S14KLzh3tvMpTq?=
 =?us-ascii?Q?syYffEjuEdlkL9mSndOrRXKqtHuN4HBHdnQv0YVJA3ECzB6w0ywoLowXs3Y4?=
 =?us-ascii?Q?K/6OnUUykQnl3nXkXZ6/qhrgcyPrT83lTLF8sHLPWwjTLbnJIR0WFXlv4+xY?=
 =?us-ascii?Q?mdL6d1q8rZmSUFlofwvfdLQcslWnWKTmQl9L/AVnxluQU+0hjNsV9YACoxaO?=
 =?us-ascii?Q?Rk2r3u9zcVTgMKg6bE3J29W1gIYo6FyWk3QtKFmXcS2i7A+1PLYKGl6Fanft?=
 =?us-ascii?Q?ztTHXceuxeHj8ajPv6ULd/XqlJHAZ9QiHSRIlEPohz/GpiGa2Uv3Gnu9yYCF?=
 =?us-ascii?Q?ptg4dFRPMSyed31oWtWAV7pMNuBl2j6RUVO98N67SQRtf996Nue37zJF/BX7?=
 =?us-ascii?Q?fkebq/77V4CleVEBmTosVQHQjXjS33soxQspmLsSlALcZ9zgygfCpGyHkgQA?=
 =?us-ascii?Q?W5Wxv8A3SplvJ+LVsQYljzGSrFURX1g/7j0Tzd5uejMnKB55R4zKYwGYZ63e?=
 =?us-ascii?Q?amauYcksP2Bt8r2hVU36uHNhEGcG30aUceEr5R2AQGpMA7N0JggYkJhe1+fU?=
 =?us-ascii?Q?21KauuzbNwd+wAL+iYeIwdYDc1KHDZBLp0qffx4QrlexgYJEdW8yk3OCjuqv?=
 =?us-ascii?Q?TBlQlpbO5YD7Ak+SFWcsdxCn2MLpqGTsyypTOl4/jCjGohv6WfqFk1apao0r?=
 =?us-ascii?Q?bP6ov+KSTV8nW6shoQh1/88vphTrBRmt4RheP/i+hbx9f6yllZdIaC4ReV/M?=
 =?us-ascii?Q?M/45qtQyt7+nvKviiOdKYIR1yguc8N23QOdhd8jATaNb93DAam8kfTDGu0yg?=
 =?us-ascii?Q?1us81YTeELN6gj4ch24T+66Z1MFoPWviXZkZuY0KM6N9V3BhmyxRNxag4fS+?=
 =?us-ascii?Q?cuRFTlrHR09yA34uyrHwW2y1CIJVa9zYJgXDuZlNuXujILhwLV0hkFbYrFHX?=
 =?us-ascii?Q?7b2v145CxcUYE2tlxXUkRYDzYFRvJp7Ygt+muoMkOE/9+A5CWfgkgGouqfL1?=
 =?us-ascii?Q?NelBSGKjNbKlyAqrAj2t1QlpiImM063x6kFkrEDfr6iJf1mJz0DaSf20uru/?=
 =?us-ascii?Q?wJd0Onn3Y27Y6J4GgG9IHKfL2QDsju1OMSDJjG/2DY1129CxzXM3GeD+xEk7?=
 =?us-ascii?Q?KfzLdyZ84FD9TnWnEONuOMdGwdk4Fk0JBktAjnKpxWDAVaKszI/VZ66iL2kj?=
 =?us-ascii?Q?XmKzGKsmWcKg0+kgt9Rn9JQmpCyk0duBhjsaU+FI7ZQ6zTxyZdW9k99NZ/4O?=
 =?us-ascii?Q?g99p915rf1y0lT3I0KXnZoiU+U2K679VAZNt+7r7yvKPmvGsSLHgl747hIv6?=
 =?us-ascii?Q?FFDecMlvd6iFQq6Xmq6m0Q5a4YLCzK9tYFPml9SeKhttbruDRSYdrxR265PL?=
 =?us-ascii?Q?pcQ3ns8nnwk288zoveGmE8NulZG5VaeQzH+oL9YdazTFQCHfkbM8PZA/9kKG?=
 =?us-ascii?Q?W8ocBIM2CeX7dt6oSciPdmhV7K6EoBgKXfJzc4xHNFEsi9RIRwNiiHEyVXHj?=
 =?us-ascii?Q?jtrq2FOcmWrHWesVBoREDDgBNl4i+T8YvMo99lGPz3hXgeLoshaUlLMChLrP?=
 =?us-ascii?Q?mw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 034d2c78-260d-4919-5ceb-08dd083eb8fc
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 02:06:04.2273 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K+v7yqop1ZgLYnT9kHUek1fjsCZCSUSkkY9TATDLtiRXJgvXLg8Zai1zxfiQpMh5Li+2OhSkcX0e4UMSHTJPXGN2Dv16mxJ4Ei0fAhb0O2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1292
X-Mailman-Approved-At: Tue, 19 Nov 2024 03:08:50 +0100
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

There are difference between upstream DT and the old DT
in terms of reg base, reset gpio and syscon. Make the driver
compatible with upstream DT.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 drivers/pci/pcie_starfive_jh7110.c | 59 +++++++++++++++---------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/pcie_starfive_jh7110.c b/drivers/pci/pcie_starfive_jh7110.c
index 569fbfd35c..51aca7359f 100644
--- a/drivers/pci/pcie_starfive_jh7110.c
+++ b/drivers/pci/pcie_starfive_jh7110.c
@@ -25,13 +25,19 @@
 #include "pcie_plda_common.h"
 
 /* system control */
-#define STG_SYSCON_K_RP_NEP_MASK               BIT(8)
+#define STG_SYSCON_PCIE0_BASE                  0x48
+#define STG_SYSCON_PCIE1_BASE                  0x1f8
+
+#define STG_SYSCON_AR_OFFSET                   0x78
 #define STG_SYSCON_AXI4_SLVL_ARFUNC_MASK       GENMASK(22, 8)
 #define STG_SYSCON_AXI4_SLVL_ARFUNC_SHIFT      8
+#define STG_SYSCON_AW_OFFSET                   0x7c
 #define STG_SYSCON_AXI4_SLVL_AWFUNC_MASK       GENMASK(14, 0)
 #define STG_SYSCON_CLKREQ_MASK                 BIT(22)
 #define STG_SYSCON_CKREF_SRC_SHIFT             18
 #define STG_SYSCON_CKREF_SRC_MASK              GENMASK(19, 18)
+#define STG_SYSCON_RP_NEP_OFFSET               0xe8
+#define STG_SYSCON_K_RP_NEP_MASK               BIT(8)
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -41,9 +47,7 @@ struct starfive_pcie {
 	struct reset_ctl_bulk	rsts;
 	struct gpio_desc	reset_gpio;
 	struct regmap *regmap;
-	u32 stg_arfun;
-	u32 stg_awfun;
-	u32 stg_rp_nep;
+	unsigned int stg_pcie_base;
 };
 
 static int starfive_pcie_atr_init(struct starfive_pcie *priv)
@@ -92,7 +96,6 @@ static int starfive_pcie_get_syscon(struct udevice *dev)
 	struct starfive_pcie *priv = dev_get_priv(dev);
 	struct udevice *syscon;
 	struct ofnode_phandle_args syscfg_phandle;
-	u32 cells[4];
 	int ret;
 
 	/* get corresponding syscon phandle */
@@ -117,20 +120,6 @@ static int starfive_pcie_get_syscon(struct udevice *dev)
 		return -ENODEV;
 	}
 
-	/* get syscon register offset */
-	ret = dev_read_u32_array(dev, "starfive,stg-syscon",
-				 cells, ARRAY_SIZE(cells));
-	if (ret) {
-		dev_err(dev, "Get syscon register err %d\n", ret);
-		return -EINVAL;
-	}
-
-	dev_dbg(dev, "Get syscon values: %x, %x, %x\n",
-		cells[1], cells[2], cells[3]);
-	priv->stg_arfun = cells[1];
-	priv->stg_awfun = cells[2];
-	priv->stg_rp_nep = cells[3];
-
 	return 0;
 }
 
@@ -138,8 +127,9 @@ static int starfive_pcie_parse_dt(struct udevice *dev)
 {
 	struct starfive_pcie *priv = dev_get_priv(dev);
 	int ret;
+	u32 domain_nr;
 
-	priv->plda.reg_base = (void *)dev_read_addr_name(dev, "reg");
+	priv->plda.reg_base = (void *)dev_read_addr_name(dev, "apb");
 	if (priv->plda.reg_base == (void __iomem *)FDT_ADDR_T_NONE) {
 		dev_err(dev, "Missing required reg address range\n");
 		return -EINVAL;
@@ -147,7 +137,7 @@ static int starfive_pcie_parse_dt(struct udevice *dev)
 
 	priv->plda.cfg_base =
 		(void *)dev_read_addr_size_name(dev,
-						"config",
+						"cfg",
 						&priv->plda.cfg_size);
 	if (priv->plda.cfg_base == (void __iomem *)FDT_ADDR_T_NONE) {
 		dev_err(dev, "Missing required config address range");
@@ -172,7 +162,18 @@ static int starfive_pcie_parse_dt(struct udevice *dev)
 		return ret;
 	}
 
-	ret = gpio_request_by_name(dev, "reset-gpios", 0, &priv->reset_gpio,
+	ret = dev_read_u32(dev, "linux,pci-domain", &domain_nr);
+	if (ret) {
+		dev_err(dev, "Can't get pci domain: %d\n", ret);
+		return ret;
+	}
+
+	if (domain_nr == 0)
+		priv->stg_pcie_base = STG_SYSCON_PCIE0_BASE;
+	else
+		priv->stg_pcie_base = STG_SYSCON_PCIE1_BASE;
+
+	ret = gpio_request_by_name(dev, "perst-gpios", 0, &priv->reset_gpio,
 				   GPIOD_IS_OUT);
 	if (ret) {
 		dev_err(dev, "Can't get reset-gpio: %d\n", ret);
@@ -208,12 +209,12 @@ static int starfive_pcie_init_port(struct udevice *dev)
 	/* Disable physical functions except #0 */
 	for (i = 1; i < PLDA_FUNC_NUM; i++) {
 		regmap_update_bits(priv->regmap,
-				   priv->stg_arfun,
+				   priv->stg_pcie_base + STG_SYSCON_AR_OFFSET,
 				   STG_SYSCON_AXI4_SLVL_ARFUNC_MASK,
 				   (i << PLDA_PHY_FUNC_SHIFT) <<
 				   STG_SYSCON_AXI4_SLVL_ARFUNC_SHIFT);
 		regmap_update_bits(priv->regmap,
-				   priv->stg_awfun,
+				   priv->stg_pcie_base + STG_SYSCON_AW_OFFSET,
 				   STG_SYSCON_AXI4_SLVL_AWFUNC_MASK,
 				   i << PLDA_PHY_FUNC_SHIFT);
 
@@ -222,11 +223,11 @@ static int starfive_pcie_init_port(struct udevice *dev)
 
 	/* Disable physical functions */
 	regmap_update_bits(priv->regmap,
-			   priv->stg_arfun,
+			   priv->stg_pcie_base + STG_SYSCON_AR_OFFSET,
 			   STG_SYSCON_AXI4_SLVL_ARFUNC_MASK,
 			   0);
 	regmap_update_bits(priv->regmap,
-			   priv->stg_awfun,
+			   priv->stg_pcie_base + STG_SYSCON_AW_OFFSET,
 			   STG_SYSCON_AXI4_SLVL_AWFUNC_MASK,
 			   0);
 
@@ -273,17 +274,17 @@ static int starfive_pcie_probe(struct udevice *dev)
 		return ret;
 
 	regmap_update_bits(priv->regmap,
-			   priv->stg_rp_nep,
+			   priv->stg_pcie_base + STG_SYSCON_RP_NEP_OFFSET,
 			   STG_SYSCON_K_RP_NEP_MASK,
 			   STG_SYSCON_K_RP_NEP_MASK);
 
 	regmap_update_bits(priv->regmap,
-			   priv->stg_awfun,
+			   priv->stg_pcie_base + STG_SYSCON_AW_OFFSET,
 			   STG_SYSCON_CKREF_SRC_MASK,
 			   2 << STG_SYSCON_CKREF_SRC_SHIFT);
 
 	regmap_update_bits(priv->regmap,
-			   priv->stg_awfun,
+			   priv->stg_pcie_base + STG_SYSCON_AW_OFFSET,
 			   STG_SYSCON_CLKREQ_MASK,
 			   STG_SYSCON_CLKREQ_MASK);
 
-- 
2.43.2

