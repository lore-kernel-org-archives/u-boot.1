Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4497AE6C5F5
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 03:12:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B884A89615;
	Tue,  3 Dec 2024 04:11:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A10E889589; Tue,  3 Dec 2024 04:06:05 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20707.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::707])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 098BF895F1
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 04:06:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUNQv29fVGu+DqeorxBfkt38tnlb+kWosyZ8vVV5BjzVm/rgYpkYrQ0Xl2XhwCeHeLqhE51ECUnZ+V9IUEnRE7Kl8uP+egF/RBGJMiwi5qFjbWrIB+sdXytYxHxhguiNAXen7WBPiRd1/YWnIKSzsf318j5qEFeImUtO8TlVQpgI5P9GN1kTsFUEDHCqHWHg5j7sQ8cKjDTHfl4ZYHSV2/8R4JYqcJM1a/antm7kpQzvN9WYPuu8S2yU9BihitqybDltGNQcbZ5hig5uXmBekOk0mwmyxjbmgV0Icq7AeplL75sEjDZL7G59ICFTDCBlWA0FFaDTmhSoeV4l4IDnng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ScSLtFgidFrWyO59oiDbFIyhTH83sUZZslp/0ty3fS0=;
 b=YHp4KkZgM1PmqaXpgjExEeVd+HxlrMywhIeqHcUk7JIE4azQVR4wHboQ+RjDDUwkbTupWft543eHljcNmYMQg16FcxUoFXv1BL28wkwqcmFeh/SlwuBeMY7N3fIM9F1oUMnd4niXvhIsGOxpNdWmAwINGq2G2SMMc7iqMm1+j55pUtr+xBM2T7Zyk6/QGOgnDO7wlZep56+uHyKNrFpJFU2jW78Xf0LaC/8wf5U5ITBDtr8r4tRy4DOWM5opDAz6lNf6eO/sqo9pGerlURitDe6xAgbc4ZNQIHuWfpzMe1V/diH5iVMj2p27NZGeKpvywVoxs4IggbluclTjcRIh5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1259.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Tue, 3 Dec
 2024 03:06:23 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8207.010; Tue, 3 Dec 2024
 03:06:23 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v7 04/12] pcie: starfive: Make the driver compatible with
 upstream DT
Date: Tue,  3 Dec 2024 11:04:22 +0800
Message-ID: <20241203030430.26089-5-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241203030430.26089-1-hal.feng@starfivetech.com>
References: <20241203030430.26089-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0013.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::8) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1259:EE_
X-MS-Office365-Filtering-Correlation-Id: bf1f2234-8938-4f6c-18c8-08dd134777c5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|366016|41320700013|921020|38350700014;
X-Microsoft-Antispam-Message-Info: JfSeKLh+f4Z5D8kMq3ydTnEsUUNIQu0es0+SphH7cq4M/GdietVMNcw1eIGvSjUokkL1mNNGwqrqmqkn7Y01YUxgEVlp5jLmtWUBzJ/B5HHw6j8WSnP/FQbIbdwgM65V/8ifhhIOb6M4RtalyDVc78rQmpUi8hBmJL4l0htcjb1cLQDM7DjiURXZ42RqZ/LogpWbv4PpVg7ttYhslyAtUOSoAw4Ca0geWDtCptzqZpgUZUwZQuFX34+63ayQyrE5S47Vd2XBG+auE5YMHW4ZiJtnS9r45JvXWc257W/hUpZBE+r/Yk5G/02Kvrg73kCwfW+MxDDMw5DPOy94rh4siqjZ7eFgG7lyadDaTTS6FJaV970YpoVNNEO4C9GlmtQvvyLeiNz03f0lSEI7FZZqmbR70T4J0+MPK0Zu1ZnjuTVjknRYbmHpeG3MWajj6NRwVuJRSJKNq6OHIe6fo7UH/zyRHiomruPIW4GV6tVdVi4rHMyVu5TugiQcrfPSgzhrGO50o+lBgaOylsJuVW467Dk8TrMMNiN+MHL7fgZcivqF4m52Zja+6/EGfyDT3FjBm1XENxYn5ZIGnEBNX7LFS07PkUmP9qdT0PTPxWhloxBAvdy+hTlS+ltBflK5h6lBcQR5fNnmy3fB9TdEbfOaAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(366016)(41320700013)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9waEyoU84nyKWOogpbSAvf5ghGWndl0zh3j+qfHQOO+YrqC3SIaXUIt2Op/W?=
 =?us-ascii?Q?cC2hAbT8iRpPJEOwcm4guyrOzOUgK9OGv1raYEeMc9AKEo+xzFJE/9wWEoFd?=
 =?us-ascii?Q?5DJss8OCEkMxvxqzu37w57iNq8bzn9T4t8J5a+j9vqkW6jrBBReuPfy+5ODp?=
 =?us-ascii?Q?YpNISOobQcyHl5ZXLysE2/pW/ltx18SSPuDAK1ebtyKK5ZwcQuufv/cjpsSO?=
 =?us-ascii?Q?gkIUYRmprifiC0KJ4ceNaxz43eNKzMhEBVYs/He+qCX136J4XObLqwFJeBUI?=
 =?us-ascii?Q?LqgQ2ZDoxRTIdVjwQpMNz22faLvGxvo5CaazcLRtULpPHT+zd8um3rQ8ELkw?=
 =?us-ascii?Q?989S1YwP9aYsNyza5on0xr3CBB/g6NrI+O+Cg03njxkRi3yq/BjxxJQ2L9Lz?=
 =?us-ascii?Q?2I/5MSCUouKqTqQz9+JeIj7C2PmK6oybYeT0gn+jPIjhpKncwvi/auwMtl0o?=
 =?us-ascii?Q?RSi/c8o8z5Fs/ww8dAd7SE4SFDlwnWBFRH51nYwgQ74pDzm72HUNU1H/g/1v?=
 =?us-ascii?Q?2L63m52uGCiqxL31O8LANLEqF2TIuS4rintZmq+JYv7KMviKlEYgBl0W3Flv?=
 =?us-ascii?Q?oQtLbWj5jPR9FXnNyNFzDRXDi+gjgKPzutwfEDeg02C7myVDvZCCFCnn1PcF?=
 =?us-ascii?Q?vkJorFYUidtVGZl4aW3qhP2hrSHv1RtR8W53wR/a67lgWvP2liPCXqxN5BFA?=
 =?us-ascii?Q?yVIk7H2oEyOQPyk46j8mLGCMiyo573ofrHMX7GnKZbjfOFBGoV/+E8BSb089?=
 =?us-ascii?Q?TncYE2JBFu2jyxkEJ0dWkp9WadD0mhkWNCLlGKnx2eSRwYWXwilJlMgwl8tn?=
 =?us-ascii?Q?5VzC8E7SYaJkcDagvJAYoF3a/ACPXC1sVK/xGyu4ZNCJnkieAUxMp9Yk7upn?=
 =?us-ascii?Q?eONODGrYcpLD5RVIPQYpt5swhYcPngP94FkQA+zf3p7e6lQ+Av1rDAvtbRa3?=
 =?us-ascii?Q?AJsy16mSVO52mgYyEcyv9jSqY+Pu2OR2Avt8P9ZONC1ONwLLDpxjvAMQmQwA?=
 =?us-ascii?Q?CnxdM23uYFbdloN76eQ6Gcu3P3gaG4PuZz4R9zjRJr/YWs3iuDgCb8goUXpc?=
 =?us-ascii?Q?1rj1invujUlDjwy+zGDvWZz5xd5pzsXnnsUe6UcVu+lqsRMBK0tgK9+py49d?=
 =?us-ascii?Q?nkZV5LMbTNQ5Ac2ujje03oiYUMn6vLEM6BbdmSvyN9+B8h7USHuoTp0N9+ZO?=
 =?us-ascii?Q?TUdOFwyECEadmKLqMDi68LBS9/ekHABst4f7nXja5tKIbuuEkXBYwiEGsAf7?=
 =?us-ascii?Q?H5U8TvYA4GMZEPMmKUueQqjegeSg66xKGli3TlTGkDZseNP5tNjOKFzPZS1/?=
 =?us-ascii?Q?EoAv5SrH4Jcu3AUrPcWdHcZrwHtQLEcaa4CLKoHWfnSJOH4ae50+KZLeK25u?=
 =?us-ascii?Q?2UPf7kt5vgnrWIGRfjaBt0+yzRUQHSi2+dhFIHmTPMkZJBOL15Fn201cB6Zt?=
 =?us-ascii?Q?J5UMq6hv3sC/7+Q0gq8gpdbQg+zqA6oFtbjPZEu8GppHIfZVQ3XvYQRMThCw?=
 =?us-ascii?Q?Vmau0x1N6GrUAAJPgrC4r7KvEJxyqDBLMYTUqKmmcGrgpSFVIYnPDUebt3un?=
 =?us-ascii?Q?b6wetce3FF7g5H1s38vx3EdAEGpaoz0+WE5LBbLZMogYyiOyS5ulFlpZoohQ?=
 =?us-ascii?Q?eA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1f2234-8938-4f6c-18c8-08dd134777c5
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 03:06:23.0552 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UjcbGUUHt+so7kxiACXCFWmisp0+FMnyuxIDvyHuSOGRCJopaWM9ux/Vnx/RKsqzxYnxCBuFGXy1srQ7WkdY2oVQR+X0UOSDugmxHGoQ/f0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1259
X-Mailman-Approved-At: Tue, 03 Dec 2024 04:11:50 +0100
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

Tested-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: E Shattow <lucent@gmail.com>
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

