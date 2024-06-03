Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA8CC25B76
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 13:58:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28C658835E;
	Mon,  3 Jun 2024 15:57:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8CF888300; Mon,  3 Jun 2024 15:27:40 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20718.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::718])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0BFC87D1D
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 15:27:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzsUTsvStS78WSQGPZXu6hF15M0ZFExiaKSEt/fIMl/TFYCc8NWYhbh7hj3j7AMHUowYog+P8z4VnDxXGKaoFxBpmiyBIi6XR2nwK+kih6hgoPed/qcVfCi3NO2QarSvmVN668J6KEsA7zHuq3Yb/QVsoyk4PUW2hdo1Q/WAoiraHTycF8oDbWYlBsjg8kelNKUAviizTOGZFA1PIjv2Bsb1Xb53F9EePNG/9yDR6TDcfnQgqny2vJq02HLgpdDz1jaC0MwESKUzkaEFPiA/B4Gp29GGuWYZOJuql/WSB8aBf4SOR2uwuAZYxu5IiiIzdS6kzXIJoqf0LeqPkTJHwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Jwnjk23e/2FmjrkMQpwMdeRjy7gGKAG05AoPlki6Gw=;
 b=FfrhinrE9bHcuNKyypQ0fBhQjyUl//saRpSbl7ecbTEB2OsfFAYj7s5AJhi2EtzacYUj7qRfAfrUOCfItqIL8tnt5BUsZ5QwKnIo3qPgHr6AcGAoKlt/mur2ZcDOBZBkCkzjPv9pnaxyYkz/7J9PajbxYbfwOrWa7h2LOsUcrIe4OPIhFm/OVzDKRoNCL1V5DqtyQxe/cokQxT6xxR+MpJl0Z1NuzVUojHjw/k1483Ha9QeQHJg1yo7+WvTdlgTs8M9OMR8/3gXeqhU9147BcsqgHfQaM/SYCUPXZVaiHQ0Y5P2YvFX4IPz+SxI5qCdX7rfyq7ofFSHYn9chBKE3rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1242.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.43; Mon, 3 Jun
 2024 13:27:32 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::61c0:a8fc:1462:bc54]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::61c0:a8fc:1462:bc54%6])
 with mapi id 15.20.7587.043; Mon, 3 Jun 2024 13:27:32 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo Yu-Chi Liang <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Rick Chen <rick@andestech.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 3/4] clk: starfive: jh7110: Sync clock definitions with
 Linux
Date: Mon,  3 Jun 2024 21:27:20 +0800
Message-ID: <20240603132721.6522-4-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240603132721.6522-1-hal.feng@starfivetech.com>
References: <20240603132721.6522-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0029.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::10) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1242:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c5ff1d0-b536-43bd-9d7c-08dc83d0ec52
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|41320700004|7416005|52116005|1800799015|366007|38350700005|921011;
X-Microsoft-Antispam-Message-Info: EHPejRDLADIOPNuqGkPvuzREyTJXBYySmQpORrGHwm3OS7RblP5THfcpVZdAE9jCUFAFhk3C092Ud/+DnS3zXDohaEop0wFoxDN2iUUhFcDdfrpK7HxMR6rxrKsYd524rrvrZ9OcR7f/DUBO+XdyuY31vcrt60TtPai+RzLl0DX5LMxYr0jdD+bBS77cbkLm9PbCMD4Nav/04K4lM+2DPdfmud+8+CH8dQNLpzO1Lyy/xkaZq/xTfhnlcdwZg/WK/pBAO2nnY6SnonZkyErBN5uxqDqS0asfJPoCK/3Sq3dW6frP1VKdO6VhuTPuHU4P1fvHslJH6XvC1EJnIMqhhz8tmYjvAe3LmdkueEhDAVcuJb3Boep3Hq2cVMAU04b9PSKGqn+kviprd0duvHHM/SEulTwTifzIEyopxgZl/J8WTIYxH955xl+MeXeDsuv9tA6XQUD4VpQfZfJFLAKt91y2gOIwZ1iKs4Rvf+B3f+AnCtIC/J1l7UVrFefgr5vl2mrnLHp3Hbt4Kx7XF6lFGMFF0ui9lCDUs804jkyIJvqIVEA7FM6zwM8TTvOWOeCOa2TszrAvRvCCCRddyV3oHzMmLGu+m3baohgXN8ngIGVSqjX0UAWNSCSo6l0e6C7nvoXLGsMZBVWpN1XnR/mfeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230031)(41320700004)(7416005)(52116005)(1800799015)(366007)(38350700005)(921011);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JqIenyvk8JhOB4tCXU5Q9p+/x7is0DmAUgU2d6+C7HX4bpqTWbLMZv+P7xPl?=
 =?us-ascii?Q?eQDT3WByuVyh0MOTQCKqIcIKhPAUrkpw9/jDkK/d4JuKn8YGpiFK3HtVkqfq?=
 =?us-ascii?Q?YegK1kXMxNS7TRw5iuFds4tuJJt7Ph6NnU06hxnAs/FU9gIayZos+zeVNOeU?=
 =?us-ascii?Q?IhcTBSuqXRtnsf5xJo1w8DauKaPsnELc5CoKRG/v/cJQnY0RP4gnhKKBKyrw?=
 =?us-ascii?Q?mF9hCNbjJdPsomuFaTcZG9dtJYiNdWLzyK9zcjk7Rexxoz9aGoqu+Qs19DHt?=
 =?us-ascii?Q?J+UotLqCOX4SQwUzaofPRIwarzcOrK3qTM8o7eifeYXkcJ13w7OIOO+HqNaT?=
 =?us-ascii?Q?IzV0qM/+uRsvrS6puUIP75Qh22QPbmY8y19a7r8fC3zfUZAOoAfWzJFFR6MZ?=
 =?us-ascii?Q?M0aD4osqTRN2ts1d9QAyNIG5jIuWwkjaBazJ4yuhTDZs1/XLRiMc00HrQ6aW?=
 =?us-ascii?Q?2r11xmWLF2YCBH7TyinmBSu4b2TEK7mpnNoaVm6Bd2NPbSmDbb9ENorgbjGN?=
 =?us-ascii?Q?3oBTe5dLl/laqdXpcCegXXzSgjMU9XTmVqN3ESmbG6qrDE0WkgbHqiqFVz/i?=
 =?us-ascii?Q?XdAd5/+weswTPIvDpRJ6MNCUq5DC3elxSlciJBSg9HngVHSu+5OEVyybvJOs?=
 =?us-ascii?Q?VDAoaMGMquo7zm9XnKGfiW5fetitU7L40gn1F+CY6R+nXYZnmb2Pyicj3x8t?=
 =?us-ascii?Q?0GgwZNGtH3QNyjHt38MGNJL5KW4uQhllEoSB12OCkB1ZHqcBn1rQLKyN6eAf?=
 =?us-ascii?Q?dyvypkIlImS08x7rXetNYmTbUItcpXubBW+uvAkTafKRR4ehk6tCTmR1ZnCL?=
 =?us-ascii?Q?k7DVu+vtXFNN0RgnVMKMDahXX5pUdOex3T+WXuBFGdDD0ugWNTWjw7gxojWL?=
 =?us-ascii?Q?MMBqwRDUxoLXAi6YfcWguAvjcdOyLg/kY+9ei7yG+u/bGgAKbKDazI+KK0Cs?=
 =?us-ascii?Q?6UlBGPxe3D6gRSf7Ezb0VrJJF9r2pfPjBlj5svyT49dKjJO5Pur1UkIXE8Gb?=
 =?us-ascii?Q?x2s/UCz0Fx+RPpmZkrGUTpKmx9nWz0f5dxiHxW7ZP1JdLaSVgSy9P51Y1ZfS?=
 =?us-ascii?Q?SZ0UbAlAQ5R0JJ/gV2yOIe2NDk6VQs9CNpofy/J1DhQ5njDia927MNxlkk0f?=
 =?us-ascii?Q?Hmhxtiq+wy0+WuLVm+57SMtWNbf2zlIQL5bubBHNf2TZ0zUTzeM0WTJom9vi?=
 =?us-ascii?Q?NOTABtrRjbncDYHY9nAJQgiOijBIKTYNta2xkPz46DKnXc0goNI5T+Cg7nNc?=
 =?us-ascii?Q?8N3WA/Vfzlvm+raaEkXQtLEyQHGK0nyTZlf2WEZjz9Qz5fNZTxa8AuMfZgNS?=
 =?us-ascii?Q?yji4eUHzZwiibkkbCUw0o32Wxy/tdxfB3U4Km6EFfpsGcTlvABXC/A6emZU4?=
 =?us-ascii?Q?CvuqsSmzP0fqy3xBnATUKFpg34etP7EDT9wHGqGi1nOyBhZj9LNF2MCgnuz5?=
 =?us-ascii?Q?WtD6l/1184AobHiz4KrhoDVowJoj5dOO687veeBOHtcuZb/F3qnUuNmG3DP0?=
 =?us-ascii?Q?+EH1N80GFGNl1qJGXnVx9dgWcUh8nQWg5vX66XyVMiOtRzSERX1NS2wE25Ku?=
 =?us-ascii?Q?eiKpS64jybvJcoQ5rXiDRJFYvmZeABHhuZe4l9BfHjC1nSp0o9d7ZFv4gDp/?=
 =?us-ascii?Q?qQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c5ff1d0-b536-43bd-9d7c-08dc83d0ec52
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 13:27:32.2047 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HmXfbzi6X4UHhu40MZSa/EEANF1p4brFYkw+//BqZKMJWt+VCo2ZTpbHMo86JR/0YrDQiF5TKI5LdjdB9t129KlyN74v8RQnm0oHeGGBtU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1242
X-Mailman-Approved-At: Mon, 03 Jun 2024 15:57:36 +0200
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

The JH7110 clock dt-bindings is synchronized with Linux,
so update the clock definitions in drivers accordingly.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 drivers/clk/starfive/clk-jh7110-pll.c |  6 ++--
 drivers/clk/starfive/clk-jh7110.c     | 44 +++++++++++++--------------
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/clk/starfive/clk-jh7110-pll.c b/drivers/clk/starfive/clk-jh7110-pll.c
index 1568a1f4cd..96beacb4fa 100644
--- a/drivers/clk/starfive/clk-jh7110-pll.c
+++ b/drivers/clk/starfive/clk-jh7110-pll.c
@@ -375,13 +375,13 @@ static int jh7110_pll_clk_probe(struct udevice *dev)
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
index a38694809a..523342128e 100644
--- a/drivers/clk/starfive/clk-jh7110.c
+++ b/drivers/clk/starfive/clk-jh7110.c
@@ -496,37 +496,37 @@ static int jh7110_stgcrg_init(struct udevice *dev)
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
@@ -535,10 +535,10 @@ static int jh7110_stgcrg_init(struct udevice *dev)
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
@@ -549,14 +549,14 @@ static int jh7110_stgcrg_init(struct udevice *dev)
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

