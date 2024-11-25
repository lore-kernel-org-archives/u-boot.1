Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA08D3B7CB
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 00:42:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFF3189A0C;
	Mon, 25 Nov 2024 01:40:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7443E895AC; Mon, 25 Nov 2024 01:33:44 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2071f.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::71f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3BEC895F7
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 01:33:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKcmGgodThfRoC/yrtLwG7xntRbTnL2xl0H2sp5x61L+IPZyu/S8bhOU58DITLMRv+IVNxy/IGq0EUH52BZ5OvNBoLMebY9UhNzC5JDheLjGeMwD45rI1v/IhsQNel/SPfYPZwJvczgc2jdIVNlAwOWgqHN8KfnJz9gs1b/7aKRO39qY6M7hMO4ZIEyd1N298fwC+yGR/aChDobjBB75FK0vpzYxxkTHqZTSEhtEj66mJ0gUzUI9kNkX3WufP8oscSTg/KwVUB9UqoaeLqYcfoQPiiHxDRAm+maPXFf2nhmbU1EzaQU/h7IHIukl0SAdhIqWgzU2oh4d1NKPpJ3BFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5iu+q7Fii/Szvm2L0xYa9W8OihSFc0jlzn927KojRoU=;
 b=HObLmnAfJPzJ7GscLc8pzBB92OPmCWobc7Le+OTLFPrxkM1KWJ7TOSMVcICyZtk5s75gavVFdmLvS8/vb+aalSEZHjl6G6Yb88zvxEorlsRkyQ6ZMvC9ptck5tsC8FKEezHDeRiHq8FH0fdqGBe6JEzn2q2DZsydkHMydeQovRzXZnpHWXfxhVvWV0WdbT1zlPR9Ng4UXbvu3GjhwRe3fMwlx09G8ibXtfzExrP/CQW/nqwjmIxPdz5NLw/j+2jaAuBhBQUg87njPzzbRCjOx4dldj74s6IKlpjUJsuiIF0X1E6H9P/myC+5+k7f1NcZFva0BcpgZUJwtLXqDoEGbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1244.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 00:33:54 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 00:33:54 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v6 03/11] pcie: starfive: Make the driver compatible with
 upstream DT
Date: Mon, 25 Nov 2024 08:31:57 +0800
Message-ID: <20241125003205.75327-4-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241125003205.75327-1-hal.feng@starfivetech.com>
References: <20241125003205.75327-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0033.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::10) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1244:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d6f5c2a-646d-4901-8f87-08dd0ce8d756
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|41320700013|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: 3CVgKM2GybeMyV9bQSFSXZwWakEdhBSonRb1MI8A4M4a4LdtzDoFTfUqwWPwHRvsCWGIvSz7f3IwYtoReL/7ZmvH5L+pODEcrK6LTL/5xWZ4xTDJ8grkXPRDmJY+LLY+5zfD8HOpe8APOi03/HuR517ugeffOixukyiO/T7O/1fC7dXdkPfkTqe+Cl9rKmGaAu20B4ZNOd28Bw1K3Srma+DMJA4Hb2fMoGI51JOZs48usyidDJxvUyeaX1/S1lOr6bb25p98eWGO8K16U7Lo3d+npJkjg6jAjf0dEi7LkRaXinCcTtdgCF8ca2Fw9TdBtz2feVMRyZwO7WbqhCUhrxKxzIZZsRSr1y6nBbVSGOgIxHucby0nPO+WADbdZA/6I9PrkeWp6GlOPczxPxCquavGrfNEDE5RmBJHDX8Fhv0A3eLI8vfyT2csQGVyrWURxHq5miBOC50aww52sO08Q9ax05vFDZOPdl5XrpPy9TSGMEfG1djq9eoWzajGFuQcjX7+h/SQTBiWx+Pv4m+sxT4XwB6AjpgWh4xzO1dsOvNxSH4Ac9Pcr8i+iXtf1VkAIGA0fWDCoKowsZXNSMHcjjX177HLlrwQ1VET4qZfXkAbFTf+WryPp5cebCVBwwgT+NuYIk1m9zV1433tzN8TcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(41320700013)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wZbOcSRYTAmOp5U1siXywNy5M7+RiyHE66kTlhRadnHHdR992EnviKByk0XU?=
 =?us-ascii?Q?8pjwpZlXHo9P9DextOsgubJofDViW0s0b8LVOxPB/oT9bIvT4o/hW/AAMY+s?=
 =?us-ascii?Q?qc/nR8Klf44HZW8pfxJZOTMXRugTjo0nCrgb8bSB29lASoOi2AZiK3qs1CID?=
 =?us-ascii?Q?UkWDFjAjrYCoVr/lB6iepyg8dVOQpcPbko+IcUUvyMWcHHj6QN41hUt3FroB?=
 =?us-ascii?Q?TjYv+gYqI10ZGBp9wxlTI+jCZVn8IHE/YT3p16Pmdzx2O5+K6X9iVST5e/ta?=
 =?us-ascii?Q?G+DBrh2NMSLCBgiaEIv2UgRyksTgi0xbn+Fa4CmcqTNMeHu/a3a3PFH30uSj?=
 =?us-ascii?Q?827cUywRZmP6UfCcJTBKk9TmLR0PQlsB8MBtW0vMQ3IXI6TFlN7opq0nTa8T?=
 =?us-ascii?Q?b1wo9OUpqkTsch2i/r5Ka4v9W+WmKXVVAeyuPVC9mxYjQJqGx1QzYil65LEh?=
 =?us-ascii?Q?5Fkr7VO3BPh87YZ/SkxVnS66B2C+MH63othrzMDPXVRh4rpS0Ewgk04oHNlh?=
 =?us-ascii?Q?0zjGB4fYczq3sTiPZkedhDe5poddrGqAP22m7IH/PMR+a1GMqsMYD8krAeza?=
 =?us-ascii?Q?OGCTIKcDXA7AVCpdUYemMJtf9ZoixKWNwbwv0TfT6b3TSwjVH7YXkaFmCdXR?=
 =?us-ascii?Q?V0pTrlt81G2rN0MQ+v2XHD1gzwtM7LViCsMmrA3N7zXnDdWtavaZQNxtLIWY?=
 =?us-ascii?Q?7XDztO8Nwh1deBpWQQp+srFpbI9bH1shBme8sDqC1UOVw/mRmghJViQbtaeg?=
 =?us-ascii?Q?Q7q2fpkPn8SuiANoahj25lTOo7ibzXSrHcUovCQIH7+iN2f6qF/65IDCDF3w?=
 =?us-ascii?Q?lJpTxLAFf4TkT8GY/DUilG/aZIUDqKJ855+mhYuF/clhul11a+DMLcwqEfRG?=
 =?us-ascii?Q?A56LMjLUeBUgW42iRcLQ3Tn7o1NUS4QfRoCFoFrlT8/wppGVAIYlYE3FPHOq?=
 =?us-ascii?Q?4w+uvB4HrtmrtIqr7PUFlJ5ij3DbENl/6DGctEeO554oVB9aBmul9i9h9Htf?=
 =?us-ascii?Q?SmYr5Br8vo3jcsw+0TKGvACsdp858x0UMma2HVOcBQ/jSfQs8LAUw5fg97y4?=
 =?us-ascii?Q?r+Z16RBaE3/yeQ4983J+3ZQK2CVOVcB2VD0bUEyyJ07/dHOBmRD0cUy1CRme?=
 =?us-ascii?Q?wcEHgGPfC6UtFSTwcgSuqxYG7KeC7O8GMo1ALcguE4lW1+59kEFjRXsP7taj?=
 =?us-ascii?Q?NcvePJDUgl/RAQNkPQw7xHJT2xW/P/1WwwdxFlnF2L0yKGoe76JQzeTxLIzL?=
 =?us-ascii?Q?ak9Lr3R5fk4Q0C3JThWLdswu04BoOtRwpYY2b9a5ghW8Fno9kJkXpsqOqDj7?=
 =?us-ascii?Q?61qtCvmCPtLzQ/VhfXysLyd/XpODaeYq+KBnquv3+/SZanNY57mY1b47Wnlg?=
 =?us-ascii?Q?1x1kMDKxGYwG3fQrF3xdN/vEWbGcg4w69E40Wokr8DJQmhdA+hSu40UbOSkt?=
 =?us-ascii?Q?65z3Zjv81I7ihto1hf+IC1t4OoN9jATgC/wd0GQJxG5XZ+b2J72wQwbNJFMw?=
 =?us-ascii?Q?P2Sxa/NsWRd6id+eCS9TiHnf788vOGH71yt++r49Zhu8AbQm9LxAAz7/Cw+r?=
 =?us-ascii?Q?Oom+x4mV9YLncEnx4DzkmrSPyVCjWJPxnduhy3e7zPC2Cb899gVrq2+AQ4U3?=
 =?us-ascii?Q?fg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6f5c2a-646d-4901-8f87-08dd0ce8d756
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 00:33:54.2391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1VpOUftvnaM+j9khMOGnPsONXBNA08CN0BXtgKWyTE8OSxZTTsr1hQ9YbZEAXkB2mQay2qhtsfowVBmgYEqdWSqu/Btc+M83bMAnwAVpbQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1244
X-Mailman-Approved-At: Mon, 25 Nov 2024 01:40:37 +0100
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

