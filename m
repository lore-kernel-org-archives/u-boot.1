Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0432CD1CA19
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 03:46:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75E4E88FE2;
	Tue,  5 Nov 2024 04:45:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F51988FE2; Tue,  5 Nov 2024 04:45:05 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2070b.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::70b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7971D88F41
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 04:45:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/12ISufUiQLL4ifmQQS3Hffdj6lSPmpfWxn7+GGI/rON9tKCxWb4rcW60qaZGuUBVXc2ZZsigg6XR/pCfi8cb7gXkySUfm0EeYovtxFv4nsITQUtlljyW720J97QJRs9ubAv3Lvm15Jm+Z92chYHaDVmPsycqSzhW5kDWLrH6MDCwQH/juhPxVyruTVecPJwwbDvjJzmjq93lGwUbcT9NGryGULvTQbFreaybKwIm3nFDPn6ntZ68fa1NU/bA1EnNVaL2yqYAugiagK5N/JGfdqpBerkB2jzSwq+zrElB+KSn8lfq2A6YwY4iUf9tNkAW51dG9dzolE4sxI4xmdCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMUGOskJCJMmK5wG40VxQMgyiWbSlG+yfT92NZdv5X8=;
 b=Klt33zNE0Dmt74ynehbzvj12HjE1ls5/CmXMWrT2tMfEK9Z6V8bYjGGnUdUJh77HiEodmRJMlIonsDYSRJTdZZZCTUU1EyedN5jt5zwmoBoNYKFly6+tvvcffq6Jr2psUZds38oZmSxRQEwHJztTVHUNcCz44qFiGZJOnf1jIz5E1Yd950dV4SJmTwN7ETG7cPzm6ruQEOBoitP+TmAJl+ySOr+zasNQ4Vn21Mv3ln5Ah1I9QOlAwK/o8p5R8BamOEyQ1rwboaCfng1GxfkSttHvJ/InIa0472diFI6+ALTbyMhfej6V0rjTXbcAmjLv8r1vcHW+dcE8YHU7HHqPrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1145.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 03:45:09 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8114.031; Tue, 5 Nov 2024
 03:45:09 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v3 06/13] pcie: starfive: Make the driver compatible with
 upstream DT
Date: Tue,  5 Nov 2024 11:43:21 +0800
Message-ID: <20241105034328.56439-7-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241105034328.56439-1-hal.feng@starfivetech.com>
References: <20241105034328.56439-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0021.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::30) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1145:EE_
X-MS-Office365-Filtering-Correlation-Id: 212a75cf-c99b-47ed-572c-08dcfd4c3ede
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|41320700013|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: DHm1fIHXi47IwUwpZAvOZ617qgi7IMjwWvkB4kL98xS8UzaI9sNm1gycLs2K+7lOYJKDUVyN6ixO/gHZ947MbsD3DhhtKIunjumht9AFUEODU3MA+gS+Q8z4vh1n4DKENQH8iCrl0cRrN2v4x4YOY+JUl4MTCfCcuN1j2gSEsws5aqKAh/EBrryT+WJdaPS6uNk2DbVeI8z0SXCKS7VIjxO/ZIyZUZ3XZx6WOSoVbB65GdM66uHk7rD1cyBimUD2qqmT832ALlEbZs7VBNYOZwQ4Kik9kJbvCQgJW/OE74xBegMbZS8EV6zoS2uCNC1LwO7Wp/LFKkZVd5OUiCqLOdQrqy29zuVymB+1Eimhg3r04jkIqONsjz1hoU7XPl6elg4v3g5B82oI2n0sM58YN433CBfqZJnS8XD9sL5vDLUDxVJ7/vygO2flHW53ZYRgJ6BQK3/ZZ/MOKimOgpFKLsDtMDFaJ31L64y3Aa6S+TKazyyiGuG3Uvy6xN+cy0iAZHncNPkCJsF4i/wUhgdCrRZYxFHo8wWCs6xZWSiOJX50CUS2Oh3VXDcVqNvYDYNj+b6d2wE/diSuhNyDPqnZpbfx+TktquS9KnR7uzcZx7pSUdOjsp741MZZ6qxf3I1J1uWEMMxTEQVDCrgSQxZy1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(41320700013)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y2Mn4RVgi89P0q8CbZHnJ292ASVIiZ177jJNUzxtw0jw4HOtw2EKyzXwHbbW?=
 =?us-ascii?Q?NmyR92P7vmoQKuBarQUD3Dz3A3PxzlERyyVuLzWRv1B6V5GfJoh3vu4AD6sb?=
 =?us-ascii?Q?rYbtLzzDtSRQbJKA72nGZHIFPNB97jv3ggpVnS2NTtaPnXmFDEZBcT3pY/Ie?=
 =?us-ascii?Q?lcUo5ljCpXYQFuHLMLCu9GsWaEryaSWSNREKzWNyDKMc73Zj4iGLjHvMYaUA?=
 =?us-ascii?Q?lDYqqv8xEsF1QcUeh9n8poiZnZlV0+RUJw8Jp31xRq3luHJR2lB/PbVSPcbe?=
 =?us-ascii?Q?UksU8TA3jOSBL8JzZ/GK1T9p6tMGlKR90kJDr1S3yDAeCkKFffa/pBC4dyqD?=
 =?us-ascii?Q?Ubbw5bX09Ta5ucD8IhaMUO85kYlfjG46C2k92CJ8giC+ayp+F/G+AfDV2YMv?=
 =?us-ascii?Q?8NFm8thiGqxkF0LUSprq030TNpAxZaqX3+9iNJY6QnGGrDDEHrcd2zpeiFXF?=
 =?us-ascii?Q?mB6DKCshPlmF77UMTJL1ikUih2dr9syKr3oDsSFbZGV+izkMkkVl+Fgr1iX3?=
 =?us-ascii?Q?lTSgi+MX4f5sbj6k4tq4SFWsRGMUKnLFcEF65iJe0VfzZmEEV0H10F0AppaW?=
 =?us-ascii?Q?DFN466ePJjzjc7JMzucBX1Dbxlr+3o9tRA0TRkA41nvpkNGxnNvejnJB2UAB?=
 =?us-ascii?Q?ZVPnXl0S0i0uRRxQIA/MYra6bBpq2oIrFCz8I7YFbyvWjmjIsz9rz1mrpHuO?=
 =?us-ascii?Q?7fqytqapZUwvmhHd8Of0nzazUYswIhTnsSDKxOcjA4aRPxPMLkXTDVyIbPnS?=
 =?us-ascii?Q?X04aFHVOszq/a8qpbQLIP6jVmEfnPiQdN4tv3TSokpd/ETrZNE73Yb55OSbS?=
 =?us-ascii?Q?0IxXOOsnGhjOgg9Ab3LTJ3+aHLGTCfHoDCpdUUMlc6NnVWU/QJkBiWeqbiTo?=
 =?us-ascii?Q?ZVM5+6wGwBOT+yinE8xM7fCOX1uM9cGIXT1FxuLu7lQzA6qMo1emgf/VF3Zc?=
 =?us-ascii?Q?2gWrEOUTW93X9P1tthlkn6x4QlfLJnCSSBexZ38CivQKNbdpWNQ8Rf5Ae9/B?=
 =?us-ascii?Q?cw25bPBYjpBwmWS+CO57bObifYnK8lJ+mZWoXADB88HfJqONYSNWCqiO+ptM?=
 =?us-ascii?Q?x/oTn6mjlfXyXTWjp1BC7yperqGXQmtQ8QrgIspt7SK6Q+HDIagee551op9V?=
 =?us-ascii?Q?TgvTMVqterg4utQ8kaDhU9xf3c86U1w4i+Xwhnt7KXNnxZYO5ki1wsqynROi?=
 =?us-ascii?Q?gdBQOJ5ydoLvtJSZkEQgJNlNMclQ7rsjuJiRoXwVs7XqQqKhUk54SxSZMXAP?=
 =?us-ascii?Q?hxhaObdVKkYitEsPHQmf17gxMR0SM3ZPSVqgxJw6bfIDszoY6GqYArqBfXmp?=
 =?us-ascii?Q?w5LiwcfjOGomO9lbCKC5VJJPj+2pjYFOGcARjENoA7XHAElyk7m/hTUiTlBf?=
 =?us-ascii?Q?osySwZBr0boCV0XpQ/tWxCgFNh4oqsuNFk7N4nID5SIBLngvXZSXaNABEYPZ?=
 =?us-ascii?Q?m3JaOrFpdsHy7v7naoXRZUFRN1bpxCcD/Z6o8o6RQ6pvafaFQzGou5hx771H?=
 =?us-ascii?Q?y0GjHuQREVkor0e4CyGy2IJpgZ6QQM9ngryLB8SXElJ+1W+crnzDYVC47wSL?=
 =?us-ascii?Q?iLIklLoHnf3zPYIGcFR+Ew2ojQkkJVkmp2FJNOGRkFiLrToV5CD+mtqP3zjN?=
 =?us-ascii?Q?wQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 212a75cf-c99b-47ed-572c-08dcfd4c3ede
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 03:45:09.4755 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YkpgWVp8KXHcgjTpB1HY3qpmGGwICIjAXVkGJaq584GqHpyx7UVrOBh35Po/EkhRWwsNZ4CTMMWvztUqfxjuwEomC76iH9/qNpgTlVaU1Fw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1145
X-Mailman-Approved-At: Tue, 05 Nov 2024 04:45:33 +0100
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

