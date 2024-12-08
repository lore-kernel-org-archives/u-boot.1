Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9595E77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 13:26:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80E2089575;
	Sun,  8 Dec 2024 14:25:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2859989578; Sun,  8 Dec 2024 10:21:21 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20706.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::706])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A16389520
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 10:21:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QouhqWSKEx6zI7XxnFnRnfz7piYljk1bKf2IKPRKzdA26GF9H6CGxPM5ByW9uR+BQ4S3jGbHQub00cOIrZD9gZ1XDZsfwus0saviAx8L4TKFzbHLKabJ1+DEhsewPs7fxecz9lrY3Bdhmc/SQEc3C+1ECmgdVKPnbiQWoItaO0UfHgxxBRFr9cqEyAiV4Zr2RECpkZ1BXDVm27/i6/h7n9uJT4ncWRDvIjEU38C0E7PFK3VjL/DZfJG8AIMmeG6dZjcUA7WlJ7l4jl5MuOSMx2X11p1gdTMDRm8dXoU0RSDl6yiZD7xeHHlOVaQoKEYwPjXpS8LEiubWJN8MgjE60Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ScSLtFgidFrWyO59oiDbFIyhTH83sUZZslp/0ty3fS0=;
 b=WyK8m1rwlYC+yZhgdXTRoVzSDiQdwTjjYGxLBDMgUspRDRQQc92U7UkJFH1rT8Msg+/LTuSoT7YhXThbAArW6QBTj871r6DADWbkwZo4u6cwieoISJEB8E3qH43MvOCrM2/YFumc0nVYMdohNZ+C5QpsQ8DCXOSks0LFiE+uZE6JQRZL7QQEv52/WcC4XgHW2PRATj0kAaYMgV7orYokhzx2j7ClTV6PH+ogvVxCdcs45EcZWI3iKg9+m5ShCxekU1C+NWGilgnM6qXLwu3rkTZaqEnlfCX9c27Oa90rhPPfifsc/i27LTvE0/Xxherw2ifBQZ+pAc2G225967DVnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1226.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.6; Sun, 8 Dec
 2024 09:21:37 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8230.000; Sun, 8 Dec 2024
 09:21:37 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v8 04/12] pcie: starfive: Make the driver compatible with
 upstream DT
Date: Sun,  8 Dec 2024 17:19:34 +0800
Message-ID: <20241208091942.47298-5-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241208091942.47298-1-hal.feng@starfivetech.com>
References: <20241208091942.47298-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0031.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::14) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1226:EE_
X-MS-Office365-Filtering-Correlation-Id: d16f7663-e1ac-4db4-dbf9-08dd1769b77b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|41320700013|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: pQ0+yw8n7KK8owN4EAiwVrFCrSulJVr7nB+Dflv3TIFaqgISQehHULB3/EndV4aCsvvqEm+UaISFDq6ACijU0Zp8s+o3/5jw6hI2FA/7DZG94Wefab1q1U6abJQsRgJ8ECFUvby6BhKay+UgS9Ou2zWQu1sEAr35q0jVxkvPwe7FDMBgfUTvEvpF2vKiwjkHbPKpZnrhvx+GGXPeMbUVLp0+X+3s3aP1YAPVBKRerbsGS2xVL5zWy6ATRVrC8GmZgHI5vZKKXM8Gf91grlfzXTf0V1Q9qMWRzs1oJzP7GqidUPEdRjDOqcM3FFqTrZAfokHZmeGUfJ4HYkYHG5vAzaZF71Bvp8fWR1vY2szul+vVUwqN0KTcHiUFMd+CbU7lOqujyBkMA2n189sEHqs49s4TAX4khCV7ES1ApD640gjDeI4a/rrnxq18EC3D8YbgwZoU8P6W/DoqiWciTX8wSMQDZtob/Q9GY+wmEPcAQIVwKjlBoB2+7lE9/aV/87QqQ2Y3uat0O475NZc1DalSce5nvO7G/J7Lealgci9RftKi5qZ3z6PBLIBRhZNRWN+WMdkzNbj74C1GLcoPjmlLazCuGBLUxzYnRvR9Jy4jq0d2efXi55y6HdjUGAFVi5Wwka+E2z9M6O6Rc6sf09CR2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(41320700013)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AHUEXCGyEilHvDZ/H2xwBwJOj4/5gcchH6hVnDoLDdAxFKHvZUck/RqANi6W?=
 =?us-ascii?Q?cknVhaKRpKbz+NK4BfxUaswXZ4SJis1ZaTuUMDZvUXFopWXUEbZx62IxLY1Q?=
 =?us-ascii?Q?aYcgGriQqdJ4/6Wjm5h7N2E2bN6KSWrgY6/3SvlxOVGkxKoyhrG/3GTFaUtA?=
 =?us-ascii?Q?Zk0sI6Aun3avR4f7CkoX4CYxldGQipTWZV3hVJqIhbVo4NlY7L1eeSUJa7vr?=
 =?us-ascii?Q?CbBAoVrCilZ5YhuywQpkHvGVcy/fbQVvvBHXcGHe38ui6gs6qMp0AenhTQ1g?=
 =?us-ascii?Q?NVfTTw+ogANETdqjRVVs+TK1vGzzuvTj8bPLPhkdXMzXzKd64AEvMv8nLuss?=
 =?us-ascii?Q?pPiNGN6exTBo8E+F+o1CVcMuRe12fouXnCDikFs8W3+pr+DKnSY4fosQJc5J?=
 =?us-ascii?Q?E+KuiCgcl5eTdgy4kmZ2W4GbEyB9mOstdMejaVCJeR0aVkvGhOEVJm0j+egv?=
 =?us-ascii?Q?9iN6eL360JjjgykfYwDg+aglI9S7018OfUJ1zL87M+7WcASrmZ+RSlw1l8ew?=
 =?us-ascii?Q?dK7iYB6P56PCF027v9JssE+kaXSVDzjpqyYrgCoGSgNFd5Aqf7jk4pfhS26u?=
 =?us-ascii?Q?Zczt9vTSr+eJpIDL2B2gtnBXOxZdUWsVrCG1/bCLmEFYlzZUKHmAPxt+FPaf?=
 =?us-ascii?Q?dPP3tk6FbjBKc5VfDZvxuh4TQsO7ndN9jwSO69UZ4mWxzAWjeJI0wM1uWRT4?=
 =?us-ascii?Q?RPmkdSM+n+w/0AE0cfSr6VOMUZsGml13pXmtlrCDCW/CPruAKPlIM1Yp4xVQ?=
 =?us-ascii?Q?lez4UaI+pzav+QNuL1XNTVQcjjrcuZW2LPt+doZFVYCvINUoskX2wpYDpbq5?=
 =?us-ascii?Q?/lGniMwWjJiylpx85i16Oi2b0hzvy85dBYtdYzpGh3HVJTvih5/C4lZYIb7l?=
 =?us-ascii?Q?wMRXgfWuWcNsgIIs6manLJB6eJPEbN8p+fq9z6gxZt4sQpBHCqmJSdrfeqnc?=
 =?us-ascii?Q?jnE62gQbSLUot/psvxFYWBILMELc1Y3yXLDUOfHI1cNCSaVguu5LXrhdxJ1x?=
 =?us-ascii?Q?tJGOZ35L62DvmJDvUFCfhRBmM4YwSQpezu/9lmWSKy57rsalWxZbbEf832db?=
 =?us-ascii?Q?4q2jeGQmytY5qJVgNi2U4E0UxoUDf/bwAFo08Gx677gx+78oMguYSSFE6Vbu?=
 =?us-ascii?Q?qk9Grf35z553Rk8ZrRwSSM6fzrKD88Xm3JrL+D0ue7u7RQN3u3Ha+UXfmufr?=
 =?us-ascii?Q?3P1m11b6uYDHXn09dvofYdT8elMOF3nHLIa6d4e4EOC7yj5bCPNMiPRRsiU7?=
 =?us-ascii?Q?a2jc15BBT7KCIgdnSyFiYn6ZTM1U8WIptVEnvjZfx1IHv81yijfn5Pg17ncT?=
 =?us-ascii?Q?8yyiE5So/wlf/SHvlGfbDA/zOdXbeLp4IRN2vo3SSFZo5u6ylZyIxD2oGydy?=
 =?us-ascii?Q?yhzGDV8OwgElN9p/fJdXquEwU6+ETvM7QJ9/jg3uJaItJIL2Rn1sUwukE5Tt?=
 =?us-ascii?Q?uFEl8gN/iG80q3EFP0dpmyvVXROtBAkmJsU2M1rRNMcL1TZe3f7EhIvI8P4a?=
 =?us-ascii?Q?VIQA1U8sUIxaUa7yTyAJAPvvEl9Kncqw7MjyIYR1LSFIrnPJLJtRJxsnINRo?=
 =?us-ascii?Q?3DgGE9tUaRtSSu8PwRt0+lTlrABa+8LrtfbwZ4AAf6m+atoSGLt62wGHnDul?=
 =?us-ascii?Q?4Q=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d16f7663-e1ac-4db4-dbf9-08dd1769b77b
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 09:21:37.4926 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3AvSHgjczcBsNW8FVWMcS+hZiJSO5OVnpoAqWRzKcfcUMGDyMFkwkbTE0/JIIXH8afBforoMhYHNPITrOKv0STXASowc4JTTsF43feTgAgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1226
X-Mailman-Approved-At: Sun, 08 Dec 2024 14:25:45 +0100
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

