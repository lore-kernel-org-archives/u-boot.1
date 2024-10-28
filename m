Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 208B9D13592
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 02:01:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C4F188FCE;
	Mon, 28 Oct 2024 03:00:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2BBA8901D; Mon, 28 Oct 2024 02:59:18 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20719.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::719])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 881C888F70
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 02:59:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dh7gn55NHvHk/a+sw7VhZtNhsM0yTRjDZnM1FiLe2r992aN/dtROVcW1TnO6N9iW3EsHL7YpwK28XYDeqi2JwjqcjH6UzPMxit5SDa1MiXj8nXp5nVh92FXgsC1pkDsRntxi3yYrvejUu3qiPq6BI7P03YpRb+Bf9UrR6pRU86hdMrFsKm2ssbUCIKDVh5d7NVnlw/4MZXaUL/zt8Gt4EAhicJiXMzTRmOPlGO24yCB5E0TpQcnz5Rg4PI7xqTTzKhZ3qEw3hV3mgi7bmcw0oBHfoODnINcyOBcb3Y2bovoDo8nuUKrBZWbaOA+OTBJT5JqwAXa+YDqMS9eREt53ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LgxYdyRp1NghF/SYV9jOcARi+qLrWOJ7sl20ZbCDfA=;
 b=cUJoz8d40h2+MOnVs0/sHzc1ny5I/e44+ifbSIRpAiRRsPGGyIe2Lzw3Y9HXNTEUExtLSDuqeV+D3bt9ABfaO60JDOmR9ij0GmvlOuqHIu4aZXBQ+spidlmxayq2nSbh38E2ReC9xwkwozd8I4KO1GSz15dqpb/XDf0yA2oF6PF8SiDf7XoGwVS9kqdpbMY0eP667hcS6efExpHc15F6a73kfRUyuaEHtbUNzTpmQxVdhjNOQt0gJTNl8sbFN1rR09uNHYzNVHVR9aDjUpMYRDwVt+jE55v/NrBUiEL+EWKR2yASX8LYznm5BE9Fp5kiSvx5VsaLJlBgOFxZOjGQhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1211.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.34; Mon, 28 Oct
 2024 01:59:11 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.8069.031; Mon, 28 Oct 2024
 01:59:11 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Nam Cao <namcao@linutronix.de>,
 Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v2 06/14] clk: starfive: jh7110: Sync clock definitions with
 upstream dt-bindings
Date: Mon, 28 Oct 2024 09:58:39 +0800
Message-ID: <20241028015847.42344-7-hal.feng@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 79b144c9-7017-48de-10fa-08dcf6f41df9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|52116014|366016|41320700013|38350700014; 
X-Microsoft-Antispam-Message-Info: vUz9LpsVZiAmBbY8y942xvZCv8TdhZxw/5p8X62Gt1AZzszvJN32Y3q2W0FG01Du/ePy8FAIxGH4CIVOC8qLZnJXVHm7oJW5wQQPNCcw+XxFeTz93b1Bs6XRpqievEDCc0BtgeFZkggTH/qkgfjrZh+S5WHSIF4ltVbah0fnQ0wUZ7CYUbq9ogOwgKa/OIJhwlxWiMJUWzxGEWz9Nx3X7+VBOWMJAA2ZeFkS/F8eL0ckL7kHZM54RGdpXhMWPIlIU9LTJlHpmz+VooPht3iLd5TYgLI8F2XYaI/BYjBEW+pmNUPK3guxlCBl75hvWAtnq54Lz4eWcJg1tVnGGltJn+d6t3y+8dBFhQeJcqPgBfSMRdUdm3fdpbVEzCpNThvMt7jxMkqKFGiZYxsD069ng3y8w79sahya4Z5CiFz82wlnFD8py3YVPj0I5lauk9AspUsWpBH5zImMOFEs2D00Eb2aU8C5lD+zr7svw+YJjcgAmQtnhP/4HcTk9bpWBvq3rvfpKJxrojwg/tERFsMK9mAvt9aes0TWtTyliEg4VSA3t52vyb3gE6FxQwkekuldS5gkEnez2A8pP9abYnzweclaS3MVR93sx1WWt7yRlHalzg+UNbwV5oDmxy/ll0XZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(52116014)(366016)(41320700013)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sQpznju8xPdoRlcEmzc9OH/eTT+PHZXId+ikJAm/5vxZPwWFzLVlxhsu+ueu?=
 =?us-ascii?Q?AO8IqceJ8jliuqNUOiy6UTpX0V2QmVDX6IRpR0oWGBzEz1ZxdivMTh54bIs5?=
 =?us-ascii?Q?K7T4btN7SZW0kMjdCNmzdCnzgL/0bEyPxPqis5SiiN241olE2cCKQjfz6Ikj?=
 =?us-ascii?Q?NvXuHmhDJqlbZDjigEB+oAa9bhvwPE+WrEAonq9A42RDMKS/htFT+OdTTu72?=
 =?us-ascii?Q?qWWHx3dVYCAjgcbebvbKiCnl/mkxOhEoXdFdHNs97yBxTVH1Y57zTO211DWm?=
 =?us-ascii?Q?mLB2uQnf98+vbT8qByUicHuezKCqf+k6viE2FINXVna/AX8oJ8fJlBFjM+wn?=
 =?us-ascii?Q?rcf5hyA0CVX7HBmkC7Du42gP+UzpIIeCMG6t+BlQUG8cq0hfpTNhqEbqdppr?=
 =?us-ascii?Q?3j+6AJDRDAL7qGezIQ1tQ/pLuIHdO+l2cZWDDfDgiZFIdDJF2O17XuMcTjtn?=
 =?us-ascii?Q?5cQk4I1TxPULTmsUli/3aopvscQuGkQzwN4oRy/JjtmUtjMlxOZKh2TgJSVj?=
 =?us-ascii?Q?IxDXFOFviHDA+j/h8XGyBwiRd4u0dCY68Qlmnd9ywyDMyNM0vYOgr6T3+R2s?=
 =?us-ascii?Q?P9nnESvwsdDz9rmCxd613dPNFS+JZdRsnUm58X3cAtLP6alFNVUMUhSwmQhQ?=
 =?us-ascii?Q?ICOEoHto7H6NR5NkXGCdD+5aYSZiWI4dstU6e/hlOVTq9nIyxEgqpoeYiruV?=
 =?us-ascii?Q?gIgIH2oHiaTVncfEXkvnYPoayEbD5WB8w4YNHFahL7jWog7cN6PileRv0Iac?=
 =?us-ascii?Q?8Xk+X+MkDc6oJ9pXPkq6Ef1V/F9SWMXCNJ1my53Jw+YlNO4gvU0oesXZo8HN?=
 =?us-ascii?Q?m/ZJA5tpvSSypkPw3ZQp1F4JX5ErdHFoEBszLXXmtB4nJduuwlJ+LTEOUy85?=
 =?us-ascii?Q?+7EAWku63eyJeJdkzjz4pZ5f4rLs0jJnG4iu+Ou7HUAICX6T0v91eIxEXzLT?=
 =?us-ascii?Q?FUT0jriL9OGO27IEC9oEqCVtijPqwTFSvlBEJRczouwzoSnaiiJINsJJV3Ue?=
 =?us-ascii?Q?Wh+A6Xr0dQUPKc5gmn+b/Tcuj7tZQz11zHEWTKPnQXoZ22xqU2SFa0Wym89Z?=
 =?us-ascii?Q?kSXf4+Cvic4ENDM1NM5RYagY4ipT54Zlp1yhvDxa5QhSImfyxBThIpmR1RK+?=
 =?us-ascii?Q?OtvRnXeZYcNvZl/OvdX/es/e54UlizZ9NUPDQwWsc9ql+FIhEYkoy7SELLDy?=
 =?us-ascii?Q?F1LBwgcg34P3DZ4lSOztIE+vI/up1RyU0n9NyHhb9nsYIROAC+vJVx7liAw8?=
 =?us-ascii?Q?U/U/Jh9EMR5SOsLLMNET+Ql03WSHp//EBVJqBV5QBgkmGl/uucKAE72klLnB?=
 =?us-ascii?Q?5UdWYILakpPC9ePSzs2gDqyT36DgjtDJOVbhuM55vnaR4VxRz6mTBStuG9X9?=
 =?us-ascii?Q?tj2gDcfU0y9bMjErY+kwsfks99v0h74jKCSyGkhlcSGG/EnhfHFPePCNErXt?=
 =?us-ascii?Q?A07UxF17hfB+1mVQOg0uVN1LCa2SuAFIoHQBu73MS/7qBgys5WYG1n7fUBy5?=
 =?us-ascii?Q?FYz38Ak0IcZNobfBLTgRjUi4jYkY8zATEYby5ZF8991IIDKkm1iRIzHSIy3l?=
 =?us-ascii?Q?VYOz18BVeBiAyx1yW2GTZwsrLiw67Xw1gl0o7pSA3ydmiaeB1RRaGJjXgXjR?=
 =?us-ascii?Q?/w=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b144c9-7017-48de-10fa-08dcf6f41df9
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 01:59:11.6455 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qKuQ36qXOCZgf0/nOOZgOZ0+O9lZnMuG+it75CiADJBerQLKEqlVg3DpsbFeo6EY6LnJbd6VSKX/y8Ge+e5afHOQRyU8zRXCaSNZJWLfN7k=
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

JH7110 switch to use upstream dt-bindings, so update
the clock definitions in drivers accordingly.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 drivers/clk/starfive/clk-jh7110-pll.c |  6 ++--
 drivers/clk/starfive/clk-jh7110.c     | 44 +++++++++++++--------------
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/clk/starfive/clk-jh7110-pll.c b/drivers/clk/starfive/clk-jh7110-pll.c
index 6d2bfb3ecb..f8af17227c 100644
--- a/drivers/clk/starfive/clk-jh7110-pll.c
+++ b/drivers/clk/starfive/clk-jh7110-pll.c
@@ -374,13 +374,13 @@ static int jh7110_pll_clk_probe(struct udevice *dev)
 	if (sysreg == FDT_ADDR_T_NONE)
 		return -EINVAL;
 
-	clk_dm(JH7110_PLL_ID_TRANS(JH7110_SYSCLK_PLL0_OUT),
+	clk_dm(JH7110_PLL_ID_TRANS(JH7110_PLLCLK_PLL0_OUT),
 	       starfive_jh7110_pll("pll0_out", "oscillator", reg,
 				   (void __iomem *)sysreg, &starfive_jh7110_pll0));
-	clk_dm(JH7110_PLL_ID_TRANS(JH7110_SYSCLK_PLL1_OUT),
+	clk_dm(JH7110_PLL_ID_TRANS(JH7110_PLLCLK_PLL1_OUT),
 	       starfive_jh7110_pll("pll1_out", "oscillator", reg,
 				   (void __iomem *)sysreg, &starfive_jh7110_pll1));
-	clk_dm(JH7110_PLL_ID_TRANS(JH7110_SYSCLK_PLL2_OUT),
+	clk_dm(JH7110_PLL_ID_TRANS(JH7110_PLLCLK_PLL2_OUT),
 	       starfive_jh7110_pll("pll2_out", "oscillator", reg,
 				   (void __iomem *)sysreg, &starfive_jh7110_pll2));
 
diff --git a/drivers/clk/starfive/clk-jh7110.c b/drivers/clk/starfive/clk-jh7110.c
index 191da75d7b..6387e949d5 100644
--- a/drivers/clk/starfive/clk-jh7110.c
+++ b/drivers/clk/starfive/clk-jh7110.c
@@ -495,37 +495,37 @@ static int jh7110_stgcrg_init(struct udevice *dev)
 {
 	struct jh7110_clk_priv *priv = dev_get_priv(dev);
 
-	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_USB_APB),
+	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_USB0_APB),
 	       starfive_clk_gate(priv->reg,
 				 "usb_apb", "apb_bus",
-				 OFFSET(JH7110_STGCLK_USB_APB)));
-	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_USB_UTMI_APB),
+				 OFFSET(JH7110_STGCLK_USB0_APB)));
+	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_USB0_UTMI_APB),
 	       starfive_clk_gate(priv->reg,
 				 "usb_utmi_apb", "apb_bus",
-				 OFFSET(JH7110_STGCLK_USB_UTMI_APB)));
-	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_USB_AXI),
+				 OFFSET(JH7110_STGCLK_USB0_UTMI_APB)));
+	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_USB0_AXI),
 	       starfive_clk_gate(priv->reg,
 				 "usb_axi", "stg_axiahb",
-				 OFFSET(JH7110_STGCLK_USB_AXI)));
-	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_USB_LPM),
+				 OFFSET(JH7110_STGCLK_USB0_AXI)));
+	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_USB0_LPM),
 	       starfive_clk_gate_divider(priv->reg,
 					 "usb_lpm", "oscillator",
-					 OFFSET(JH7110_STGCLK_USB_LPM), 2));
-	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_USB_STB),
+					 OFFSET(JH7110_STGCLK_USB0_LPM), 2));
+	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_USB0_STB),
 	       starfive_clk_gate_divider(priv->reg,
 					 "usb_stb", "oscillator",
-					 OFFSET(JH7110_STGCLK_USB_STB), 3));
-	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_USB_APP_125),
+					 OFFSET(JH7110_STGCLK_USB0_STB), 3));
+	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_USB0_APP_125),
 	       starfive_clk_gate(priv->reg,
 				 "usb_app_125", "usb_125m",
-				 OFFSET(JH7110_STGCLK_USB_APP_125)));
-	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_USB_REFCLK),
+				 OFFSET(JH7110_STGCLK_USB0_APP_125)));
+	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_USB0_REFCLK),
 	       starfive_clk_divider(priv->reg, "usb_refclk", "oscillator",
-				    OFFSET(JH7110_STGCLK_USB_REFCLK), 2));
-	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_PCIE0_AXI),
+				    OFFSET(JH7110_STGCLK_USB0_REFCLK), 2));
+	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_PCIE0_AXI_MST0),
 	       starfive_clk_gate(priv->reg,
 				 "pcie0_axi", "stg_axiahb",
-				 OFFSET(JH7110_STGCLK_PCIE0_AXI)));
+				 OFFSET(JH7110_STGCLK_PCIE0_AXI_MST0)));
 	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_PCIE0_APB),
 	       starfive_clk_gate(priv->reg,
 				 "pcie0_apb", "apb_bus",
@@ -534,10 +534,10 @@ static int jh7110_stgcrg_init(struct udevice *dev)
 	       starfive_clk_gate(priv->reg,
 				 "pcie0_tl", "stg_axiahb",
 				 OFFSET(JH7110_STGCLK_PCIE0_TL)));
-	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_PCIE1_AXI),
+	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_PCIE1_AXI_MST0),
 	       starfive_clk_gate(priv->reg,
 				 "pcie1_axi", "stg_axiahb",
-				 OFFSET(JH7110_STGCLK_PCIE1_AXI)));
+				 OFFSET(JH7110_STGCLK_PCIE1_AXI_MST0)));
 	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_PCIE1_APB),
 	       starfive_clk_gate(priv->reg,
 				 "pcie1_apb", "apb_bus",
@@ -548,14 +548,14 @@ static int jh7110_stgcrg_init(struct udevice *dev)
 				 OFFSET(JH7110_STGCLK_PCIE1_TL)));
 
 	/* Security clocks */
-	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_SEC_HCLK),
+	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_SEC_AHB),
 	       starfive_clk_gate(priv->reg,
 				 "sec_ahb", "stg_axiahb",
-				 OFFSET(JH7110_STGCLK_SEC_HCLK)));
-	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_SEC_MISCAHB),
+				 OFFSET(JH7110_STGCLK_SEC_AHB)));
+	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_SEC_MISC_AHB),
 	       starfive_clk_gate(priv->reg,
 				 "sec_misc_ahb", "stg_axiahb",
-				 OFFSET(JH7110_STGCLK_SEC_MISCAHB)));
+				 OFFSET(JH7110_STGCLK_SEC_MISC_AHB)));
 
 	return 0;
 }
-- 
2.43.2

