Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A57F8D13590
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 02:00:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9679A88F2A;
	Mon, 28 Oct 2024 03:00:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0204288F8E; Mon, 28 Oct 2024 02:59:15 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on2072c.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::72c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 973E688F75
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 02:59:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2q92pnpaEPoPbXPI7j2HXNTdYRTdh2toNlOKMdanA9v9ICN+5wGhchjDmIPcj1uKymcVNKmNnOpi5xVRXAV+EP/VYA8RTejBhMWj62AKdTDHbKqrNpQSS7jedlPTnbVLQ2NjOTGYuRXfFA9QHDBpnWJApfNOrMmY62d6Gy/XDMHCZSG1kLy49ZO8T5uI2rB51IxH7GUlbqAOow0jZ+lruH9VAnTp6RlstCT4K2GegM5LyvDxjQcSOff/Phxxl8mNH1uq4K/u9M/GJc7mU7oTdDayEHIglhuVe9yHcro54i4Fs9G4CM7kQa5iTRMG0AlX51ukT5EOAtEToqi04KuZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMUGOskJCJMmK5wG40VxQMgyiWbSlG+yfT92NZdv5X8=;
 b=iV5x6pm5B4fM1M+se8ZQkHMU1eyn9oV4A/bWUvCTwra7nivAeFqqI7wOsTbba3wMBN3q/gSjeaRtZqC1dvrCVzSnvpwtnzHLYP60B83MOf7BmJO++4qi1LCEb1SCQ4KLow1dMWmo91trNlJ7AncuRXSw1VNvCRWM8fxZ//bCqzxmDyj3/d166u1hTXopkhn/UvLU9PiCoFxIUVqrwzJfvQhL5VFHUbGHv+T1Gnx/TQ3L9TcVcSTAnUSxBKMfEuUtzGNPj0kL2SOArsaqCjymVGF2IzjYLsZcRZF4jiGNfXg7YoB0Xq53xdN+OHZ+vL0/SoCbRphHL3vhFqT2DgyNNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1211.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.34; Mon, 28 Oct
 2024 01:59:12 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.8069.031; Mon, 28 Oct 2024
 01:59:12 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Nam Cao <namcao@linutronix.de>,
 Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v2 07/14] pcie: starfive: Make the driver compatible with
 upstream DT
Date: Mon, 28 Oct 2024 09:58:40 +0800
Message-ID: <20241028015847.42344-8-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241028015847.42344-1-hal.feng@starfivetech.com>
References: <20241028015847.42344-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0069.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::36) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1211:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ec2f5da-a3f7-4feb-f3db-08dcf6f41e90
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|52116014|366016|41320700013|38350700014; 
X-Microsoft-Antispam-Message-Info: a178vgD7RQhWU4A8ZKIhDRIwUYDLp37t3kYlnr0RPc0GDl1zCb6z2NB6RQij0JmdXzJ1WrrYWVz7IkbEfO5En8N/D0cjts2x9vv/k+Rq5uuKrGFhxOf+dG+BRGImhLyq5eWEif96+PitZj76l9h31vB9vGyL6L7KsosyAK3lyZ0DtVkxtbDVbxEsYXRyCxTGccrE+enGyhmyGDmnexnGc/jarJgG0Nh96kJfvJds1WxSSp4HPkYgcJkWTHEJmqQNkP4ydRpo/Q6UmzgVrzpv/cmBPLs3LZwyMaRiBOWs4Li8WC5cX/khfumD5N1AQFILEQ/tFaTcHkW+qM8ISD0KM3Sb2eU0pKF4vXIVty5sxJI0ImbhH12qP2B/oOV/ddW3d2E5vXwFxipwruDnb8irrBfpqpbrTpcGoocECjmfa5ieGWbdYZISXz0i8ksmyaz9kZLwNpH+muQ/hnFfRzJj+spuqQJKydwN9Jsk7PflII/I6VzwkybqZLwhyw9og/h/VLJX2pndXOKEP7ufzwZhpYIH6vgr9u2sHcYTZdpHWTQtH/n/8D/yV7Tp1arm+n3HsuolEvH4novYVVSAYdyP0ICgrR+0QO/rkyFm4ZlMHZgMADUtEpm3Js8UoD3HRlCW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(52116014)(366016)(41320700013)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KLYmZRSmCAYemRu2lvmZHVm/VOjqfOpZvQmrK9GPrZpfftpCdbquK9LTXics?=
 =?us-ascii?Q?X+2meDNUgt1mdkPR42oIJBYemzul203hewK3cSiEussZEI6uXdbKT5smKEtT?=
 =?us-ascii?Q?FZqt8queBvrRDzy8ngdW978UxI5Gt5AHkdRgP2Un0CSPTA+z6FS6ej333yvo?=
 =?us-ascii?Q?NzmnsdpLfn6IuHkljV704T8jYdMB2iG7unxaSSpuhzUDVusNo6GVen7M54JI?=
 =?us-ascii?Q?IpdvxVODfa4NrfjY1xiT0FhZstSbNZtMRcfkv6hSiQk4B8gw9rSWqv2nE4eR?=
 =?us-ascii?Q?xGbr+6wAiPbaEWFtWl9wlMOI3MT+9B6wCK4uKgs3qeVlNKS+9JtlFQU9IkmP?=
 =?us-ascii?Q?6Kwo3lfh2AAvPdWJxq6sF+Ce67m6PoLLR8W87rVDWuhw0QTUV38ZTGuS8Iqi?=
 =?us-ascii?Q?yOpSwbs599uawGt2CkT6bR02A9g0wK4hLd31Ay9WHsbbIUIJR0sFl2cQ6Izn?=
 =?us-ascii?Q?NR6q/q0FAYDv8kL96QYnws23esOqcPZhx5mvV9jcYNP3X0cEJJmzkTMOA4dW?=
 =?us-ascii?Q?3ddebIUYgm0kPauLoDAqumDV0j3g85k3QBzk3nNSLYRyRtMgbLpZEz5i1HrG?=
 =?us-ascii?Q?E8exyuir96eJBHFMMw2ojPtxwYCzNwgEjDAyFP+nQ6XBd+pUjxtLnZb/b4v0?=
 =?us-ascii?Q?QwIlw1rbt5P2Fhvu1+e82Rf6AvAP0arrmGWCBEvD+p+jS3cgOc2gYslg7IbF?=
 =?us-ascii?Q?ouL7GjkBTERCoQZCsljNWuJtsAAKgY0EQtBPHUrxWCKbdIIDKooQ4j5VZbkN?=
 =?us-ascii?Q?XS+f6ZD9/O8Ru/YN9k66mlFkricSRRlE/X7X/w6tGx3lvZ/2kAU3KHR12jVM?=
 =?us-ascii?Q?nLdGnMV87cDrpHzDpRr1G1nY64quinAd6oz5WaXLTXxGLS0S8GK/ps0dPm8K?=
 =?us-ascii?Q?y8o2k5kIJ8WB5udvb5CR35aM3YHvUc/UOTYtZJ+d/Z9UiR2aEIXCFFa4arkj?=
 =?us-ascii?Q?eBACijaUkIZaqSZIHrNDT9s5LsJ9py5nH0/puRqgA/X4LWtSc8JQJoeNmRBb?=
 =?us-ascii?Q?FaHYm30+V0QcfpPymxWwBv1sX6ISZ1LA9oMwr6Ic7/eT0cMizuScYCrx/hGU?=
 =?us-ascii?Q?xNoHGMwl0i0caNZ9pjglPAHTPyeGsDiUrHb/6VcV1RXCYR84Pyqlj3nwdPSS?=
 =?us-ascii?Q?f5bNYBzPrTJCqdcZLGol9pyAu1cw+kdNaw6mmtVgR616NsHlJpsC8w1VocP8?=
 =?us-ascii?Q?a71LwVVBS4tUV94vNrvdghJ3FKdW4ffeKnWSGobboRLFYHIZyHlfsHtyTVme?=
 =?us-ascii?Q?nObE/DHwQJXiPRH2cUcn5GRZNexJUxmdSfMoI5XYCiey3eA/ni2tHZUnWqtp?=
 =?us-ascii?Q?z2SoZ4jZNM3mf/6yeAD586Df3838pMlDOhclEcrlWkpZmxeP1h1ABbDzx7dA?=
 =?us-ascii?Q?doVz1zC9sA+UxvYUgwiWzio7NsAl+P59Fi6ewoQg5wmmPc4+7oUCI75HKwxm?=
 =?us-ascii?Q?zpys0r42j2Cp/bM59W3uElUxKal3DgQdWf6soxK5XvePckjRYxTkvp+YqKfe?=
 =?us-ascii?Q?zFJk887E4BupU/hkrwJefIZh9v6nJG1Mm1vqQkWqHW1byAMvQ26Fvkwmot5s?=
 =?us-ascii?Q?tJG1Rvv90cFAUSZEdTJLUVS5tFqSUYoaY4KAEOJxHHpHsDUQIRGs1XblD1lh?=
 =?us-ascii?Q?zg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ec2f5da-a3f7-4feb-f3db-08dcf6f41e90
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 01:59:12.6332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NHTpzSakzzTYF+8H0InQbEGsGqVLDo2wdEDiN+rK60lzBudJPgtIgLls3QP5kPJA4a5voATXOpJFQ5HmXZS0KkHEVvyzy7lna+lDwRgQqQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1211
X-Mailman-Approved-At: Mon, 28 Oct 2024 03:00:01 +0100
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

