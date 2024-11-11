Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D863D12D5C
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 02:24:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FBC689339;
	Mon, 11 Nov 2024 03:23:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87499892E1; Mon, 11 Nov 2024 03:09:45 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20730.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::730])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E884E89300
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 03:09:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PyGFI/eRBRSCeP8W1lygKBeqo/vBuiy7ulICISBLV/d84lIUROLpDdKdDXYk2MvPRt0Q4NqgnoLawanUxRoSgYv0dDgGEdbbEnukcdYFueQij5NFkexBthf0oikVLLVOk28ca87WJeYpiZEn+ljQ/9HT+KC+2/AD03CzFDgbo9S0c6Xlh2BGI30vd2U71qc7+dMMXGF/wa6I8C8UutUluoHUjhgd+ARCaMoaIl/I0HnvJ3HyUiFw1HclwBkRKmhGs7mAopkRsycH83KS8qBdYnDss2yfcYRM0a6P6ljjU/lLIjYdRZMkiSHBl2DGpzckpwoWlI06Ux8zpXvxdM39Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMUGOskJCJMmK5wG40VxQMgyiWbSlG+yfT92NZdv5X8=;
 b=Y3Gp6mJLIi5x+FUgzyXkgHIyKn1be0ktxEARRWm7SiW/39zGrZQLab/BwQtHcXe790mEdYG97hoCwOsyjic30k2zWTHNrpklZgclA4bSU//stBgmOljuukvxHwD/nqAsU/tkUZLCoDzdOQc08cf8UQnnqJsd0oAwpHiqF2sSCK564jUxp1TXc7nQlTUQgQ6cxAXGPvm1iWEOtRxxk8q62JIF1eVE+D2kkUVAJWUaNVBtzCDQbnIeML5k7DS0tZESWQmNJsP2b5c553n+mPyQCvfj5FNAczhNtRwtrXNQ5dfgRy0a6t26pL/4aG0fojthoEhrqlISPn78Pq758qUCRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1178.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.36; Mon, 11 Nov
 2024 02:09:47 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8114.035; Mon, 11 Nov 2024
 02:09:47 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v4 06/13] pcie: starfive: Make the driver compatible with
 upstream DT
Date: Mon, 11 Nov 2024 10:08:01 +0800
Message-ID: <20241111020808.38974-7-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241111020808.38974-1-hal.feng@starfivetech.com>
References: <20241111020808.38974-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0004.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::16) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1178:EE_
X-MS-Office365-Filtering-Correlation-Id: d0ec3bdf-b272-47aa-77f4-08dd01f5eaaa
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|41320700013|1800799024|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info: 3CSqkK2/bQ7urICwqYcFEzjMDhkJ/V95HEULvTB3RaMu2wC0TqR63NBVGmKAhtln/x3rk+6miLKM/0nn9c5kNlFl5PsRi6dM9EgYqI0Yy5+2w1cvajrjreCgCIomUKmzDsYnkR3t1AfvUHabJ8EjisblS7dBhBv+s5qkCK8IfUIhtKj9baouOb+AUlzJXX11uHkEj1ASgC4wNUq011M0Ypv+2hPVGvtK9Sq1Ccf+K/CQQtS82ZJ9Gz6c6jV21kPGbVWxsPj9rYM+XJufA1Rr45Ric8NLJsVQsHglcgGBZhr/BWPcSHHAl3raxtJVJfbhaSMJNxoM4+SCiTVOYk9ub8/ogSX5xLpkhbin/d/u3vlPQeFNTdOQ2ITra+6b9dkx5ZE5AXCklU3Umsufq+X8T76T4pIhIpHdiPta6uj2TFjNE3dcNZuN6oEuDn6zT3XfBZfpwHKMQNnntfZncS3TMnbvDBq+IqM7bcQ7H2bb9OXIrxR7N7t4Z09/lGQBQN2cFhxNNy1TOIZzYGnCHr3lOevHoi79p72ytvKFYADQCajMxvcZnVrNR1oAwljNii6xa+efU4k/cvHoCVJcHqtMSIJ3ontM1N8c7uJ+3xGnEW8a+L+PHJ66z0Zs1N9IKXGvHPvxAKCt3eFff6RK06bpUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(41320700013)(1800799024)(52116014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YLR6N1Ok14fM3EiDJRBZou/0zpwHYg6cAUe+prpC9WPdAGGhScbca5FpTSuJ?=
 =?us-ascii?Q?S79No9klYQID9lnXDiDg2HQQwNXuvbAP/4Xn9Gfx3Y0fFwWHTaPZPUU3Y4Mp?=
 =?us-ascii?Q?Ech/xrKQ6MZSDOK74vmtfMBN8yM/o7BcR4PwElspUNOU4SU2tcOhhUk9nPgH?=
 =?us-ascii?Q?cBaOsT6naTpfr5m9hsvQEEg0iI3K/xqv6mPqmNbqUvw9tSYNo5t2xjm0ygOP?=
 =?us-ascii?Q?1gw8uBZkGqBP8KE8TefLT+UPcZBOUAv37KmsyiFMEzuLqtPv0BT2PZdbVqxH?=
 =?us-ascii?Q?ukWvrDC2HOFFCxCyNRAXiG2zBKIQka6x3D8TxViOHcsgYmClQh8ILQoxGZAw?=
 =?us-ascii?Q?CXPIhCEmGesmOsS0HOZMZeRmZ0SL4XZ8BMTATfWYup02rqioas1saKajO2M7?=
 =?us-ascii?Q?jOVA9jnp8OAr7PgJmUm1UY/vumeYW2BthY1Q0ekQoDut96AlVmyItCM1Da8H?=
 =?us-ascii?Q?u1glnJXPPONHb+8fDJB2uVvdDL6hpvG6SeSrVOrQerbdm84pAhQpuMLc2WG8?=
 =?us-ascii?Q?7XKl4hjn14SVH/fSFgYtlP1TGzhjJbQnShZHU0FvLswDakQTBK/T1TPeG4Hs?=
 =?us-ascii?Q?tRBQKoDq78uUPbqknYgUA86bAz9LOT7PpXahYAUynLmtKjgODVJtsbiaQ7PM?=
 =?us-ascii?Q?iH9d9YBVl0kDq5A61K/iq6byXuv8wIk66TgkJd3WH5oBXNSITCRA0wyFfAeL?=
 =?us-ascii?Q?bH3An9aFPa51+qEtqPiE/g6B+L3AFGOTOJEYZl0/cZC4WjPkiDar2NkOQDmt?=
 =?us-ascii?Q?ji7R9jxeXkCZUkeJuCKaUvACbsEZSUA9w7pg7Z9uip2JjOM9pNRkon9Fxjeu?=
 =?us-ascii?Q?q5IcvVV6C755AebL9UQk1aZZLqXz5cSQJEbVe3mis1Dq/eJUygOv/aHK7BMA?=
 =?us-ascii?Q?bmpnCMz7reIP1dUigd//xodBAOZcOF/0MvKs8voRrkoRNRN9UDCnWX68sSj+?=
 =?us-ascii?Q?b6W36nCgqRcGMB/CIAF3vkW42wh/06UmN9pWMvKvriPprHjtIDNZZ8+5OlSX?=
 =?us-ascii?Q?kKBcU7l1V6nKd7WmeF3lED3DhJtkx5RRc/yeanEwKxUJgVHSauZrHfQoNkCQ?=
 =?us-ascii?Q?eTGJsK/XMYXV86zGf7tAAVgyVccWDWeDdN7ATy7jN60e8Mp+SBrsDYFFYese?=
 =?us-ascii?Q?xs20IW5QEuTH2PsQ+23OSUfczUAoamqVvRsOEvY0kwMsQymPywquuq8nf8DE?=
 =?us-ascii?Q?1Rbys+gsuyJdLHV7s+1qq12wOcw9wS3fyo2e5oN+V/pir4ycdsIDJ/uhKcvv?=
 =?us-ascii?Q?AF5J7RTppnCVozE6V/H6Q+FMyTgxhvYv+aNgo2KeU3msfMKqv2mXd7KKBvhb?=
 =?us-ascii?Q?JAkNA9jiMj5pt2o16fC1pRk/v+m9YWFhMEPnXWTyWPjEQq4LeqtOKwVLbvAO?=
 =?us-ascii?Q?+0iIgkT1Gm61QF9Ns8v9S3P6GJRpIzb0QxRMt2ycvKMRUoI7IANP3B2cjo60?=
 =?us-ascii?Q?mMaeX0LO97gX8fCxYqcKE1Pa+kfbyKoRL1Eg+7QVTbDB/+qkre5lw3mUB7pO?=
 =?us-ascii?Q?iPsKuOk89GZ5kLNw1u5CJ5Mo/hj8GhSwazauywA6iojwd4a75yI7G5x3xjI8?=
 =?us-ascii?Q?IQkbdM/amHdYAxMJc53xcnLlswqXmpXSlYDmeUiRuFp4rQF8bGov46/la7FV?=
 =?us-ascii?Q?pQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ec3bdf-b272-47aa-77f4-08dd01f5eaaa
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 02:09:47.2962 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KkBmZWCvnnwuKZEW46OK7VyqyxHLQ/UVyCz/SkunnPyfzBhShajyjNGXQg2ztlRqrpdAgqhsvmBpabYMnOHcmlm7+BDyVIY7F7yfM27fjSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1178
X-Mailman-Approved-At: Mon, 11 Nov 2024 03:23:18 +0100
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

