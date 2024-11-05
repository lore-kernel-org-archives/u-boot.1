Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DDACD1CA19
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 03:46:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEA0F88FCC;
	Tue,  5 Nov 2024 04:45:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2814388FC5; Tue,  5 Nov 2024 04:45:03 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2070b.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::70b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97F2888FA0
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 04:45:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBDEhNn5PE5gIVbRNw7oZMgUyPxCIsLWSuVad8spiebVLUrmwZnj/VHNWbfjlMtgiDaQUmwN5qVjZkoyAc9YHLF84pIX385yq0Iihs6DvfGhJ3xB7KKgnZSp7MQCl06jttfKX3xrU5a02sYL6ZRx2oK0TT31UltOQcgDPbnUiGKfenmShFxET6mRGBt6waIanSJxd0qKov4fo2ZrTvpmeRugpkWlktE79S4HIJ/TYefLP93F4zBGYAQF/K9Mn8uwbT3fw6ikXq3Gdy12JQCg2vPadet9z+JQ1qx4osxif7yPjhccc9MsfMy9ZB9yrmResUOsbfxAENJriiARA6GhOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LgxYdyRp1NghF/SYV9jOcARi+qLrWOJ7sl20ZbCDfA=;
 b=ih+nBHT8IEhXj4JmprmV37FwoAzpcFHmkZk4Xo6up8QxFFFuTlOIMngAUnaNy2OPRhrZ/rUs20y1A9SFjgSowcptNe7FU09zoftOlmrXs82r6dWf/YneKKYyEKdoXAPFvZqqaqFJpnGosiDsBvMca8ITwFl7c9lzUFH2asZZDZ8P+bReycnTs04nqHtcNkox1UDtJU2/5L5x1L3VKgR8WyvgQbNZ0qcaY/1pC5cskieyKUx+RyG3S4oASHLU1snmo7LhhNPpQAy3UV8b83ZhEA+ziEpt6oODc9uWE6YIBZdC8QDgQB8+wrpXHGAai4ALC/+pNOXgl3jnLKlutbSZ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1145.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 03:45:08 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8114.031; Tue, 5 Nov 2024
 03:45:08 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v3 05/13] clk: starfive: jh7110: Sync clock definitions with
 upstream dt-bindings
Date: Tue,  5 Nov 2024 11:43:20 +0800
Message-ID: <20241105034328.56439-6-hal.feng@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: abd86d3d-4b55-49f5-3d9e-08dcfd4c3e3f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|41320700013|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: VHo56e7zH3WfasevggIKUZ7+Eux1N2kMVNMeDtcr+kHvvLDlzDx4CydFBqd3kD04ZvevCgvre3AFVJMGi8EvM+eI31lrjIOGQ+JSl2c6hOGWmrcLWQQU9KvC1qQyGx5B9bA/hzfpgYT1MHi24gX5bxQMHFC2bO9cw3RbJ7f8CHBpeaMn2E+c9ftukiIC0vdNEzHUxB/TbwshzrOQFWVhM8GXsTHEwJMNN3XkzWiXdcuhxL6ZS3DkydnjPOrc5Km15b4YXGeY0GCQ4IkjKPfoxOflohgBEkIugqoyHuZw63wLuF11hbW5mf9+d3yQ6eMfsUrBm+HFY25dyHIMB9kH8ZxSoHh5aKT7UyL1bZRINEu5QxztYgeYomTcGJrU0sHuvagzvzxObmtPh/ymb/QTZUMqXDAT2QphSpj9FhNPyGuTgBgt9jNCvFhT3KAv1ZXc+3mUeJatOtb9K141R1az5FS4vVcMCrwIC1RCfM8Fl1UD85l2zf86GMS6KWwgxNojaGnUoAS/eKqJnN/RU8Or52j+0isC+cAUexQ+7GPuIOebjgJEdk/C2kP/yFLYHXlZjMZIMJutpMGpdIfbcd6p4yYgu182Tjsk/zlbcL5ldqTmCaqcfTvcin23z66wuzyci/MLctB7zohnuK88OpG/HA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(41320700013)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?78Y4MJm7Rd9dyKPA/gMnwJIFt1O9Rq66tkfTMo1kr/rL6ya9/e3+gH6aZdlS?=
 =?us-ascii?Q?TITLMEc7uD6SgN/XXWMd9Hihp3mjdP18vy/hjOvdKuMVdN8uS8p6vaHe1Yw7?=
 =?us-ascii?Q?qVBWTGdo+mmNnFtduzkg9D3ebfVcyWjhewuyNkdAyA40318xb0joTBAXkmzn?=
 =?us-ascii?Q?C8hyMWhOMO9RmSOAfuixNnz1MLrO0UfMcDlozeS9ewUHFeIaUnpSwqR6Ja0Z?=
 =?us-ascii?Q?V6/MBBvRdgV09FWpTMV1Av6Jh/7sSbVEQXTCrYKekemyYSpwNJ4Oc1TFMYjU?=
 =?us-ascii?Q?DFLBjMpWNkmjiPixaaXSuPZcrrQb65KTTHCU82f+jpTuhpbKYohmoXOl+EVr?=
 =?us-ascii?Q?GN5sLAflOz635ij7SToRx2OpkxrkULkpwKur3SvmhyqnF9jRsl//kLHubuec?=
 =?us-ascii?Q?rszbN2FL/+dwZgkG6fovFNOPFfxXhlb6eQIq4tUIPqaHijPSKwQRkhxOR0/W?=
 =?us-ascii?Q?v+e9PQXO7oov7Gm3yf38ywmbPPEb7EmuQAJwoZ7UqcpUOGgk/X9wRmgh90LK?=
 =?us-ascii?Q?odzwe67tvP9fi7eTsUjZ78LYWzbOlXax85gZmOljo1Kxb3ZCg3W4catbsruX?=
 =?us-ascii?Q?YdSXR6Zsd4S3MhjLxe0Gl+RH6JNES2+PKZjxoqJqmZEUtauDZQVnxW2vPn1R?=
 =?us-ascii?Q?zghQlOLL7rAiBSENNasYW8uFVfETlm2TwXqaYyauMGKvyoh3OO8aHRhCENBv?=
 =?us-ascii?Q?e2U3uNd2tydaTBk8Lu898cxugyBh5XF73w7/tM6T72lguI+PYtBN77BISP79?=
 =?us-ascii?Q?mixZ3LpxcW7Ml1qBzIoTzgaQR+HwukInoQOz1WBOrbS0UQAbAy8GHcgFGhci?=
 =?us-ascii?Q?3bbDmsO4BXb+3Coq+MsnkrCBnPX/ubCD6PqVXwoMIFBoz/pVtXFsMQfYhdXl?=
 =?us-ascii?Q?rRelOklo8JlZHgh5wbVKXJOevkfnZ/gXxErIPjv4QqtAexaeZ94f8zx9EBGH?=
 =?us-ascii?Q?c7JMKyfzBAXPWcqddazSUaE/4qYsf+QiKXu3UbWCd81N2Paadimse4sO6dBY?=
 =?us-ascii?Q?F8xUnX1+5Od/8WnSavcYLun7xA3hZIuvzmn+52zxQrZ7mCRO+mcYVeJb/5PU?=
 =?us-ascii?Q?Lq8bsWo9xHbDvESznLsFqHYtn4dlIi1zcdOoSXV6VS1ZMbeFqmmLK2dOJt6M?=
 =?us-ascii?Q?PJUBUK0H6U1qf+PI+IRWSapmh+apJPEVG2RfdLn2okDRWaQP6g72szEM1BCz?=
 =?us-ascii?Q?tCecwcCFAkzcqXt2S/TjY8r+tH/YfklrXhSOUwUksQy5hyKQtXe8uHyqTTkQ?=
 =?us-ascii?Q?fxrOUeQl/pxFdPpR2IAAMN++GTI10KDrYM8scAczfeQe3VbrJiWV5vfAOTWw?=
 =?us-ascii?Q?5VOB2sIHFWQ9siBhDwpdMudgY7/fHpkMlB+sCMHqsO03xAcgjzMWzk2GnjIS?=
 =?us-ascii?Q?o9p0LVBKVUwXtaDmaZyWKX5EhfsdZ5Slm/BThhQ5vCMY4w8Je36Chxhgr3Z5?=
 =?us-ascii?Q?DhCV9cGVRBCxrjRsqg0eJ3DFTEin0FxhJqeBr4WtJvRP+Md+c+Bwk44C4yb9?=
 =?us-ascii?Q?svz34FVxCOp/JudKHGH7ltsBGL0K/D0MbpFXhu+LTL5ikobeU6pnySRXN7mN?=
 =?us-ascii?Q?V1hx7CfX/SS/XRqtH2tAoeGEJNmDwxea2T8kJMxbn7OvB3S5LCbQoEA9Mcxf?=
 =?us-ascii?Q?DQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abd86d3d-4b55-49f5-3d9e-08dcfd4c3e3f
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 03:45:08.4324 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oXcDVPrn41DoMwJxF00hYcTNnvTQwIFd71RJz7o2YzJnf7y4yv9m78MmvHGZof9oN7dN73mnxfF6ParPFrCHFx66kdqnC58lVmGPVWO/L9A=
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

