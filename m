Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C1CCE8375
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 17:05:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B44A89017;
	Mon, 30 Sep 2024 19:03:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62FB388FBE; Mon, 30 Sep 2024 18:51:28 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on2124.outbound.protection.partner.outlook.cn [139.219.17.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDA7C88FBA
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 18:51:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgOdG/ABw8Vc6sGkpS1KqhSFDBvpo3xA0KU8mFTnpF9jVwv9lz0bPNukETCV14NTSRJ7IM1t9pPvQ3KbTcsuRT+wfdV1oB671LSH/fPoNdrlX56QlWADI3L2HHTOU1PkUe10tGkArE8CP8NfSL1uGU4cWcv6ymrTFmfpCYzYeeVx/x0RlrlqWv7EG89J9/BfMjVw1AxM7xQPENCKjhCP3BTwqrJd+DyAfM2z5WkRFBzXZu1P+yyJrog4C0dlnjszh2C7Dyv6QcoqoaQTB1jS6iN6XHtNmjFbdgnSqg8KsfQ8zCPye8rOiU56ut3wUrarKBldreCrLyrAoMvRA3yHSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMUGOskJCJMmK5wG40VxQMgyiWbSlG+yfT92NZdv5X8=;
 b=XbKO8DyjsopfVJzLjJRfWFah5NzbDWvYzmgonCPeGddEuJ0146NngNTyltw0HJPWoYRjRs2tFpm9yAe9In8tJSPDsn64C3yyCwMdH3zyqGZgI4b72e+7Dre6Sjgb9NDKL2NQlnq/vYTrAsMWSbbnxaPFLPWpbQeyvOVmrfZ3rLwWhs+ncYrcEXXITzd9PtWPCNjR2/5S0IBibXzZJzZG5znmRZQhDp1gn/ykBjekkyN4x9ku5UpN7SUcGnCIP2qbYtxvP6dTWrvQEKDqcT78japYz1ImKuEdaciAJyZc7EYfo6UjaoyBF7HHgA5lMT44U/C8kSGIDHW7C3GTmyRGYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1243.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 15:59:35 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 15:59:35 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Nam Cao <namcao@linutronix.de>,
 Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v1 07/12] pcie: starfive: Make the driver compatible with
 upstream DT
Date: Mon, 30 Sep 2024 23:59:14 +0800
Message-ID: <20240930155919.111738-8-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240930155919.111738-1-hal.feng@starfivetech.com>
References: <20240930155919.111738-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0063.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::30) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1243:EE_
X-MS-Office365-Filtering-Correlation-Id: 7783df61-c0af-45e5-c762-08dce168e13f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|41320700013|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: l1NSiL3jiQxitZh3yAn6w7PtUKN56Opchtud+CZg4Mx19qNyFowsQ9NhDbAXXgb80LCv3inFzyodIT5n9isXn+DvYTo158BXyq+j7cwQzNa2qU4XhZY+OCgPHD+CDD0h1/8jynZDPd/W+7ErUSY19vCcBYA6U0/cPI53f2MYxlna94aQrQZJQsXMkjxvSr6No4VwfYJ7ThTjj3/4lOTtA+2z3gSrVQX7udOmHPMcp9ZNC20AOCDrkT0zbexY1lA1zMB+dMyTaQghv6d2oCApx2ngX4vR/f4eQBKCDkpzZvik29SUQq0KotSRDJ+SHfSH9YnH6rHX4JNLDvfrTXzfxU+jjVwYm4AmKRYcqfQR9H9p9p1nkIbz5LqtZXxnb3Xs5rJsBHIsXZjDCFlPn4rFM3LMELueX5aV1aR+29ZSNZTfaR6JaH/crHX1MFqUp9Oc5j39qFncJGMVfUUT0CmUkX/Dc6TGf/qli5WqVAeXCalndd8JtTlfpGc2wE7zqexRX9kvWr7EphKx9VP4VmVA4I63rgdAKBjmdcvKr/exYeiwbRroRP2HkSR8zAfNqBo8d1RJ++NhpY6q1p+9XYQs3Iptra6g63iioBvWoEW3C6moxqY18Dqdn6tmQHsV1Unp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(41320700013)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JxjPLNCYM4hG0lfTmA+ZZTEzIqNVw1UVm53x5NSmY+BT/CXJHsAvM1SxkxB1?=
 =?us-ascii?Q?SBFriO+IEYIqjzIAzquY1D6DFqKNNsfpYhed0hF9/OXT3nzRDsM8pK00ZKv5?=
 =?us-ascii?Q?IAWkMRUuiBQtlAxTizNAr6AdNXXmB14meEXQjt2Fm3uzE+oWN/bs7N8KAUG4?=
 =?us-ascii?Q?HKSr8/zXN52w72l8bXXem/6d5s7kUIvRHRRSor7FKbHA7aGZKqZFup47P7yP?=
 =?us-ascii?Q?BhDFdJ5A4oiexarVs+OPEmSEfndSHvYaEZ3/0SrOlLqMM9ka/9m8qsVmKPQS?=
 =?us-ascii?Q?jMUuHfFvnkZcgbQ4Rr6xjNcjHlI4hiuJG8gJ8gTKxyNxgxoPXsLCAX96iSrZ?=
 =?us-ascii?Q?WqKJnz+/NaOqZgoPrvuDTkiFkiCOXLHFpvFn/iQJ9u8UfKSAHYXdHtEbrp1w?=
 =?us-ascii?Q?7FgFefJSb08PWHpB/RNS4Ka9QwGk2z1+NVbtuZKJ9D1rrNf1h/4hChSg8VXa?=
 =?us-ascii?Q?tz7tsU4Sc3la9lex0y/b++l1QqFcCRzQtn6ScLW93bTg+2Hnj6747rnGwRc6?=
 =?us-ascii?Q?ngsbkxbrmJ2DsO93kpx3Deg/nhLOcsPDpDCLCjii545V9GW8Uz/S2ui8gsWg?=
 =?us-ascii?Q?+AXDS9gYe6MshRU+nHBLpfUQyfIC3vR8UaVdz1zu5ewVlHrtve7o+HBAOCBb?=
 =?us-ascii?Q?9bCduXin3XDJ/RPnz0Oe636TYnGdJAT8R4x8NyjggFLPK2EXgXttTgZiIX+d?=
 =?us-ascii?Q?NYjvCk5tJ9Cxnhh6qOURpemaru9VD+cSmWBZcFuN7mnzDfBjLjH4vDZsQVTY?=
 =?us-ascii?Q?9hL3hEliyaJfazWWx2ZzWf8S9WGaMCdkd/etC56b+5Yfdwb2wqur81QltkQ9?=
 =?us-ascii?Q?SDjKl30xpGOwxO8dutkQ5Rmz8Qg3NbzLvwTMlJRW0qRL9e7OTcTyLx/VPVl7?=
 =?us-ascii?Q?Z/Dw+hdtOxFJMNyKuXUgPpUKdPCRCyW4oPoZ3QxdJjqAVwIOs0vu0aK20uqc?=
 =?us-ascii?Q?Eklri8O0ZxT3rvMH5Hl/cb+dqYyFouwM4b6nzta7fW2Higd8Ex/vXMsTY+Pw?=
 =?us-ascii?Q?JXL49YAxfOJyxhPdNFVkmr00lBbGN0m6DemBhXPRLDn7NshWokgoDQ7/tt+3?=
 =?us-ascii?Q?e2/6zbage57LYOJZR7/89QK56mCQxrz3TeiFcp5FQiyOxEyXdm7zetX4ZBzD?=
 =?us-ascii?Q?LWIzCnH5nJ4jaNfTEs9PuEiyi3iOvF0Od6/G+7yleTfZkoo2IuHQpt4sG8Am?=
 =?us-ascii?Q?7xpLUXaduL3dt2/zRfoTQ/dxRI+eB0b4mNYrV3O1Li9SYIx5Kn23JhmZqBfd?=
 =?us-ascii?Q?iJHBvBGE6ZlOljkWOLm6h5KgWz+od3RgLHxE8JeVwN9VFnBgB3Kl25/w4hFU?=
 =?us-ascii?Q?CXdsiGooSv8vA3dMLd9Su9lP8Gt0BQ007MD0AKGVzZS0DmdZJw+2JhuU0T8s?=
 =?us-ascii?Q?xzyycpO2eTUyyhWP/G2YXuPam/i6gZ2cNlkCG3M2EynT/+4u9PpzXeTgeZgA?=
 =?us-ascii?Q?6fBfoU4YjY9ABKueZNGuU65PQbNjwerRo/SdHYOFIEj3uGKhzGLbx58C8ido?=
 =?us-ascii?Q?+UoNHrryUlwvXPalXE04XwinZZlCN57eQmvsplXs7657zXC1KY9CT2yEGcTM?=
 =?us-ascii?Q?87uL21SZ9iNuSyrFso4+9PiGRidS5zLwurpaY6p7QUGTb949XodqQHWDlSNl?=
 =?us-ascii?Q?sA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7783df61-c0af-45e5-c762-08dce168e13f
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 15:59:35.2897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F36hGZt/5UDtPwW3GoAPb7kBxnfCdD2zmwVXuozq+To+nFX9losg6VNH5p1z6M0nNVVyafWTsecIhx/0XC2zZzAiSzZCRzy8pIBAitJyLpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1243
X-Mailman-Approved-At: Mon, 30 Sep 2024 19:03:44 +0200
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

