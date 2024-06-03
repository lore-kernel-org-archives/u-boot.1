Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9A7C25B75
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 13:58:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87C2F88369;
	Mon,  3 Jun 2024 15:57:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 383F787D07; Mon,  3 Jun 2024 15:27:41 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20718.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::718])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4D0E8833D
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 15:27:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOUwvW+RqBcDlwqSxoHMI7RNdp8sJ1w0jbgIjBCaoRpEKHXyIouX0y8tJDo+I+WcIuNb+Zrdgj+kWhXC860tj05sMU6HS8u8hNx/JlAO4u7BzY9BaEopAlQv73HD707bv+usxVIEU5EiBo3ecwCZtzPQIk6Z9fVRfl0vwkUIFUaAD4qR5mWpFunrQkGCfNPz2B++hL0PfTXzXLZKVGgD6UKH59F4kxpgGBoWJe8jYqBlBG/2jtHdroN1Ug++TQOEIBkgZI7sMEepp2ovz29VOyZyeUI6nJ5dQMZ9t6pZDLGiGYwlPm0rq7kiXzyApXZGTisWbgzDYSO43hw+9SJHjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cho+lANaeE9chqwQsrWkLg3ndTHO+1+Q1HZWAMI6Qtg=;
 b=TsZP7keIH8nLneT2X4uzHgTpIAbYvzz5iRT/lUQsZLogzKdU8Vz+xL0i5hD+I9qvgv7Knlp1g653eW1pdXAC2wS05ih+u9+LLrw3pbi3YAFoatkwvr1qL7FRbvsFWjiN4C5WsOBdZVXOYaVvv8FFeFwsRdPCytibUFc3XFobPZZDhkj9uCrWBKJ6aZKCz0QV+9/dVq+P4rccJF37pGaTb2lXYcJQIt8yb9EAem9O1BbZzwGjdjX6n8T8hp0FispHgczltLDf3Dq3YUnPntt+mlXNArK8iYyBx+X143AhapS8xJgTYJkHzKhz/FJ8ug1LiRthEcjjnpvFsXQYMAqE8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1242.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.43; Mon, 3 Jun
 2024 13:27:33 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::61c0:a8fc:1462:bc54]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::61c0:a8fc:1462:bc54%6])
 with mapi id 15.20.7587.043; Mon, 3 Jun 2024 13:27:33 +0000
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
Subject: [PATCH v1 4/4] riscv: dts: jh7110: Sync clock and reset definitions
 with Linux
Date: Mon,  3 Jun 2024 21:27:21 +0800
Message-ID: <20240603132721.6522-5-hal.feng@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 325f8530-c797-4645-b5eb-08dc83d0ed00
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|41320700004|7416005|52116005|1800799015|366007|38350700005|921011;
X-Microsoft-Antispam-Message-Info: LlC5sF4DxtoyX0z58x2dFkzD324Vsm1TlTqb/6zkKBIZz60QV4XSnf00bff1Y5n85rYejQETYizf3coCxXm6u2/P+6NhM5mvPFAfhpB84mdBDSRiXKMf0QCZzVx4OWcjsvz5CcXo28WLEeA+9u7fzCIlhfKK6NQzCJrS1uUBwh7hbNHjHHKz7xO5/pYrgRqn4hwC/UKrFPYv3LEkucIN/VdZHj+MAYjxVGz6SpzmgrvuB813oZCPH9IoUw6859nn+sn7A20I4B8eYthpMaRkeJrhu3yjRczHJXTjEt87GiSEdve4hPE8hTaaXr0REx4jwl7DnVBb8EnIUUnMBmPGdWYYlll0/vDBf3YyqgL+qlXSTBZZOfePUMdrGLkmv6DbH5VeC/CB6l/slcX2B4I0n0TbWcQnw8krWQYwFD1ONanjZ2xKJBPUXe7gjcA97xYnlWgO7gPXKzjSF7ip4D2fYluunQsXq/x0g1X8hwG+qq+6z3SibMOUbmh/pGc8dbXKazyd7UY2IDDgClDg3FoRoBmzlS7nB7IWoyDZwNSG9HCmif4jakU95WMgQxmMy3ylXtJCFaLzbgQbnHE4qhDR5UWpBkZIMuE5cFM06+1+1Z+A/ey6kW2JJUuseLZWsoslrTrbHNU2j8Xc9hSReWgzBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230031)(41320700004)(7416005)(52116005)(1800799015)(366007)(38350700005)(921011);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fdy/MbZBhCpe2FVekEgohHJYW7ZRsq6EfdWz5peDVa6XJWXl2jnGciM1Vieb?=
 =?us-ascii?Q?PG+7mXKPsaVqumhZue3/4y7SRQWqQ2cRcWNZF6eTP3VxexSHeoaRDc7W4ra5?=
 =?us-ascii?Q?ZoBR/1TD022B6R5oBTJ3bdlCkEaRkpOWg9dxrxZk1RaJjWpLfMeydn2HTLmc?=
 =?us-ascii?Q?eWmsnHpHuJ991rQ298yrX7oRkRGanQMo4S19aAXHKIeFW7tJGhES41BucQBN?=
 =?us-ascii?Q?Ik/1fEpahWexDz6jfiFePN4WgdP/xRlD3Fyq9Okz6U9Q2Ib5HsiT1+FoOCTA?=
 =?us-ascii?Q?BNSj6qIjE8OLHNyzff0CGSdkSelAIbVK7HVT2EVFEbKEtU3Wyrel2kjes1H5?=
 =?us-ascii?Q?D0G9+iMIBz4aeNqxe+geoY4U5sGnWYAyRpJxTr0+XfEf3d2RV94Xjxqn3lUe?=
 =?us-ascii?Q?mwVp/ZJTVM5/fwpunAmTupTCyAim+MOigcEodoF23zx2jv0U5LI6sm83hfL4?=
 =?us-ascii?Q?rIIpnvti/+C90TAU3ZGx1h1/UVh+pQLAi74+v/z85aZd85NDIf3rT4XXdZaF?=
 =?us-ascii?Q?SzluPrFiOV6JlKQX+1iSqGwi+UOE+IibtNzIv+mC52dsiSajF6Yayc+YikTe?=
 =?us-ascii?Q?MxRCb4dH//bsI6JIAoc/nnwhtihEwx+5TB/D9njEkCGswNJ0/pJEer3GHezS?=
 =?us-ascii?Q?sin+NJ8yPSgY2qJJGiUX9AOn1G7bGAXr+o4hskoUvNEVX0gl1UzBlpg1pSEU?=
 =?us-ascii?Q?YcH2C7/ecRsANSRWJW7boM14tHuSAqSGVykhnZ3VGCBufSizomC+Wq+BRUhw?=
 =?us-ascii?Q?IvS+jLHRgb25lhXmEVBzU0mZYPN59Ot64XQbmPp7Mbm/U3j6nWrKcAbJ1gBb?=
 =?us-ascii?Q?27viJgFj9/HudHBuwWAnHJf45PFyFKxllYW9GlYDGwj0yMQGsn/gNSJmRTIa?=
 =?us-ascii?Q?DeMhx9cHtl9NdJAENlRp2owHrAxeXp1oz76Y4zc1esBko/K3ekGPmLYLHbcO?=
 =?us-ascii?Q?0Fidxxbl1jrxf92RRJU04R2qaXZynW+H3IIfggvTnQV0ktQXRcfYoKVwjyHO?=
 =?us-ascii?Q?Daym+UTvTFkRUBAn2/8DFf5oxvLUw78x8vZ82Q1i4RqjbKquM8epeKZRGMfE?=
 =?us-ascii?Q?MJVHX9D0dkwx+lnGqMktIb+cnVKaqdu5irPH2x5osFozrvWq+KU1lkBt2GSv?=
 =?us-ascii?Q?GImjtgpNu6ck7dtBrxruRYokS50LIZ0J4hEWOGlvutFzRPWhbOzoHaFwLWLM?=
 =?us-ascii?Q?nvzNh8seKKQVkJ3JzWcquo1My1UOW1BTrkpMPuuJ9qHH264WS0zxbjJpEs9C?=
 =?us-ascii?Q?hsAlPqCrPmJ3gXp8hvMgLg1QxVchTfNJGdP7h42aBsy1QVA8lKRyutzWs1mj?=
 =?us-ascii?Q?zPq14VgTu9xCWxHFReR/NNns1k/5JTb2F5nV43A4Caq535e86karQ1yyTPmu?=
 =?us-ascii?Q?cw8NTWDdqJRkQFNfV1NuFCMT2x0croZTMyCIF4c4MbgnslUku27p0dqttyWB?=
 =?us-ascii?Q?OvLCw7JKUibm/V7MHbhCygZhgU5EG1BUKZCFZFwdtoS4O1wmrdFHXOAkmPu0?=
 =?us-ascii?Q?qawVsXbsmofonWQnE7QyUXPvrJOoaYGWlI2uXACFiFvJYsQ586m5yR/S54BG?=
 =?us-ascii?Q?Mt16fa4XUr7EzMSr1ZhcrH49O1uT3Nh6MN9nLLlxQrGlm0YPdvWbWM0w+F7w?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 325f8530-c797-4645-b5eb-08dc83d0ed00
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 13:27:33.3409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QDVRNWjcBzFhHr9wCOIkvlRX1REUJ4G+VPzFX/Ow3MX9VU/Iz+YrSneM/YD3E1V/oqHf6QPL2t2ssI4mz3YIxN8oHXy8vyQl7HZa7Yvf+/U=
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

The JH7110 clock and reset dt-bindings are synchronized with Linux,
so update the clock and reset definitions in device tree accordingly.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../dts/jh7110-starfive-visionfive-2.dtsi     |  6 ++--
 arch/riscv/dts/jh7110-u-boot.dtsi             |  2 +-
 arch/riscv/dts/jh7110.dtsi                    | 28 +++++++++----------
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
index e11babc1cd..2666fd4696 100644
--- a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
@@ -334,9 +334,9 @@
 			  <&syscrg JH7110_SYSCLK_BUS_ROOT>,
 			  <&syscrg JH7110_SYSCLK_PERH_ROOT>,
 			  <&syscrg JH7110_SYSCLK_QSPI_REF>;
-	assigned-clock-parents = <&pllclk JH7110_SYSCLK_PLL0_OUT>,
-				 <&pllclk JH7110_SYSCLK_PLL2_OUT>,
-				 <&pllclk JH7110_SYSCLK_PLL2_OUT>,
+	assigned-clock-parents = <&pllclk JH7110_PLLCLK_PLL0_OUT>,
+				 <&pllclk JH7110_PLLCLK_PLL2_OUT>,
+				 <&pllclk JH7110_PLLCLK_PLL2_OUT>,
 				 <&syscrg JH7110_SYSCLK_QSPI_REF_SRC>;
 	assigned-clock-rates = <0>, <0>, <0>, <0>;
 };
diff --git a/arch/riscv/dts/jh7110-u-boot.dtsi b/arch/riscv/dts/jh7110-u-boot.dtsi
index c09d5c9170..56530cf4c2 100644
--- a/arch/riscv/dts/jh7110-u-boot.dtsi
+++ b/arch/riscv/dts/jh7110-u-boot.dtsi
@@ -62,7 +62,7 @@
 				<&syscrg JH7110_SYSRST_DDR_OSC>,
 				<&syscrg JH7110_SYSRST_DDR_APB>;
 			reset-names = "axi", "osc", "apb";
-			clocks = <&syscrg JH7110_SYSCLK_PLL1_OUT>;
+			clocks = <&syscrg JH7110_PLLCLK_PLL1_OUT>;
 			clock-names = "pll1_out";
 			clock-frequency = <2133>;
 		};
diff --git a/arch/riscv/dts/jh7110.dtsi b/arch/riscv/dts/jh7110.dtsi
index 2cdc683d49..dbce57c421 100644
--- a/arch/riscv/dts/jh7110.dtsi
+++ b/arch/riscv/dts/jh7110.dtsi
@@ -503,9 +503,9 @@
 				 <&i2stx_bclk_ext>, <&i2stx_lrck_ext>,
 				 <&i2srx_bclk_ext>, <&i2srx_lrck_ext>,
 				 <&tdm_ext>, <&mclk_ext>,
-				 <&pllclk JH7110_SYSCLK_PLL0_OUT>,
-				 <&pllclk JH7110_SYSCLK_PLL1_OUT>,
-				 <&pllclk JH7110_SYSCLK_PLL2_OUT>;
+				 <&pllclk JH7110_PLLCLK_PLL0_OUT>,
+				 <&pllclk JH7110_PLLCLK_PLL1_OUT>,
+				 <&pllclk JH7110_PLLCLK_PLL2_OUT>;
 			clock-names = "osc", "gmac1_rmii_refin",
 				      "gmac1_rgmii_rxin",
 				      "i2stx_bclk_ext", "i2stx_lrck_ext",
@@ -646,10 +646,10 @@
 		rng: rng@1600c000 {
 			compatible = "starfive,jh7110-trng";
 			reg = <0x0 0x1600C000 0x0 0x4000>;
-			clocks = <&stgcrg JH7110_STGCLK_SEC_HCLK>,
-				 <&stgcrg JH7110_STGCLK_SEC_MISCAHB>;
+			clocks = <&stgcrg JH7110_STGCLK_SEC_AHB>,
+				 <&stgcrg JH7110_STGCLK_SEC_MISC_AHB>;
 			clock-names = "hclk", "ahb";
-			resets = <&stgcrg JH7110_STGRST_SEC_TOP_HRESETN>;
+			resets = <&stgcrg JH7110_STGRST_SEC_AHB>;
 			interrupts = <30>;
 		};
 
@@ -707,12 +707,12 @@
 			bus-range = <0x0 0xff>;
 			clocks = <&syscrg JH7110_SYSCLK_NOC_BUS_STG_AXI>,
 				 <&stgcrg JH7110_STGCLK_PCIE0_TL>,
-				 <&stgcrg JH7110_STGCLK_PCIE0_AXI>,
+				 <&stgcrg JH7110_STGCLK_PCIE0_AXI_MST0>,
 				 <&stgcrg JH7110_STGCLK_PCIE0_APB>;
 			clock-names = "noc", "tl", "axi", "apb";
-			resets = <&stgcrg JH7110_STGRST_PCIE0_MST0>,
-				 <&stgcrg JH7110_STGRST_PCIE0_SLV0>,
-				 <&stgcrg JH7110_STGRST_PCIE0_SLV>,
+			resets = <&stgcrg JH7110_STGRST_PCIE0_AXI_MST0>,
+				 <&stgcrg JH7110_STGRST_PCIE0_AXI_SLV0>,
+				 <&stgcrg JH7110_STGRST_PCIE0_AXI_SLV>,
 				 <&stgcrg JH7110_STGRST_PCIE0_BRG>,
 				 <&stgcrg JH7110_STGRST_PCIE0_CORE>,
 				 <&stgcrg JH7110_STGRST_PCIE0_APB>;
@@ -744,12 +744,12 @@
 			bus-range = <0x0 0xff>;
 			clocks = <&syscrg JH7110_SYSCLK_NOC_BUS_STG_AXI>,
 				 <&stgcrg JH7110_STGCLK_PCIE1_TL>,
-				 <&stgcrg JH7110_STGCLK_PCIE1_AXI>,
+				 <&stgcrg JH7110_STGCLK_PCIE1_AXI_MST0>,
 				 <&stgcrg JH7110_STGCLK_PCIE1_APB>;
 			clock-names = "noc", "tl", "axi", "apb";
-			resets = <&stgcrg JH7110_STGRST_PCIE1_MST0>,
-				 <&stgcrg JH7110_STGRST_PCIE1_SLV0>,
-				 <&stgcrg JH7110_STGRST_PCIE1_SLV>,
+			resets = <&stgcrg JH7110_STGRST_PCIE1_AXI_MST0>,
+				 <&stgcrg JH7110_STGRST_PCIE1_AXI_SLV0>,
+				 <&stgcrg JH7110_STGRST_PCIE1_AXI_SLV>,
 				 <&stgcrg JH7110_STGRST_PCIE1_BRG>,
 				 <&stgcrg JH7110_STGRST_PCIE1_CORE>,
 				 <&stgcrg JH7110_STGRST_PCIE1_APB>;
-- 
2.43.2

