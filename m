Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B660FCE8379
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 17:05:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B41188FD8;
	Mon, 30 Sep 2024 19:03:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D117C88FB5; Mon, 30 Sep 2024 18:49:33 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2126.outbound.protection.partner.outlook.cn
 [139.219.146.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0321088E14
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 18:49:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEEacwDUhXFixUXAZKR2Os2UF9nyUiSzHiCtHbGjf1LKD+sjSmWV2KEYXVffcMrtHp8SU+1bjC2MgPFJiaxZwPjVKXRJLUlhO6WNWw9aNHSOY9jCKk5NpiMXAzVkef7bKU/mn84FwdTl0vgrhf+gJAVmBbXDRFBFRkXy7tvsXy48+rbdCWc8LxfgyIMYstfN6mn/OQOKqgYvWCVsxEOF10ASHi5lYWwlcO3JA2hePKSqPpXMa9vKUqgEsMPbu0BwN4N7kTiWiobzuIbh9FK05jphdSFfnveY/lmg3y7sMOc/jVrN6Bum/GiNugnuxomopip3HIs3e+60tS+PwrRUGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qoagg22o27YRcKGzl6HElcGyUxhYpKSQ2b98wyb26oI=;
 b=nkXODwAkEuxFgzINLbEuZPsuRn/dOzExDriV8XHL1M2h9CX+G6/QR0oc/SF0Kzatt0uQGjW02vx1EJMCNbDiXkVadI5DpqWFbuxkfp6+DNjd3J6BLJEliZnptRH1yAWxWw2HHpTD7JqKEogP2Spcay/JWhtp+hHMrP9RpDuEjgQLGH5uq2L9zlpvbsXKt5kXOwTJtcxKVjKoJUgFg4NQIMAUnY7pRikdmek1KZYxPibxAJG+xsdWK7gFTQ7sWThb/b17VYmXvR1GcZpHXpDwqtcf9pshGEPsieFqX/+OkDotf0WQ7M3IFdmlj/kjl1QUBh5zlsekfD2kiKp2upNqkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1243.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 15:59:34 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 15:59:34 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Nam Cao <namcao@linutronix.de>,
 Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v1 06/12] clk: starfive: jh7110: Sync clock definitions with
 upstream dt-bindings
Date: Mon, 30 Sep 2024 23:59:13 +0800
Message-ID: <20240930155919.111738-7-hal.feng@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6b348d34-c8d4-4987-685b-08dce168e0ac
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|41320700013|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: +CSus/N+fh8oGaUscDqIIQEpyFWUhIRGjzZOa+I8cSK86fEMmR2BAYWLmxeNETqCSsSIMfie8iqE9bqPQoDSa7F0/1gpN5f798WgVyfkVB50c2pB2VtPJOIJQbQnSV+k3bIl7UVYvaYfYALShKfh6EJwSee2sDlTDIAliGpX6u8Jz8tHpCUO4tIo7XvWoCOvY3J/Y+KuoX2NWCGCcDYVMEIVFeDPURbc/+FBIQf8s4tC94aUvUuXRuM6tzmHcJHAFInmdaHmASH7F8pMZuBvgZKv0pmvHtUIgLBHqfPZPGVYwcHM1P1dCmpg2M0jKirJ1rD1rHoduWaPE0QqLNN8GZrJNWfTan0ACzBcA2g7Yi+ruXIXQ3SEwzG5CypK6es+M3Gq2C9bPgXsIN2dopdy93Jh7qdJvEAY3XfZtyJ6lucSVMuVGOmdqNPPMeCR8Rs4YOouBpGx/J+J0HiLYT5L7EQFArE+FKf/cKTsVu4pSirToPAKUcL+c5XZai+q6RSu/vtTZccI+UU2rHb+Lia7LzBtoZAIIsl8q9iBoIUiEF7r9WBurdQv1+BgffXDe9KlGPbv3smQiMgGmFq4ApxhBWU9Q2JPNl+YHc+Obj0TcTBNvj45E+EN+uH43IddCLIH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(41320700013)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?96RY8UCbRnc56BE9St7cWGjXVVvOOTLVW4NF45wrvjf/IHe9fOtgGrpBcgkL?=
 =?us-ascii?Q?HX4fXLOnOZdzpOARtIqxap3QCUvrrjQC1KkL9fBNmbYXoGJoQvz070GLot1o?=
 =?us-ascii?Q?b9o8xngKhpmj6+rWv6C5M33FWb1Iv6nBePJh4d4LqROMQFX08pL1OUd5UtY7?=
 =?us-ascii?Q?cSTkIWKaZfHnVyYsBx6vUvMipMrCnbqYmVq5uYfRKfO/GJiRyly/Qw8Bikaw?=
 =?us-ascii?Q?Y5iOTR0p+VakuSA3YO6E4JcYqSWWeK+vTHf2u2K3JlpB0eERbKvQodMSUXED?=
 =?us-ascii?Q?473g35z2oKp5NkG+w4ILhSRAvnymNguNxep+kPX2/8wll3Vlr1Hv2n5taxye?=
 =?us-ascii?Q?JUtfz+YMiaaeOFbCBAsUtWKVna/cFackcOOLOLH4+d04xUnY9Z0EkNoWjlpl?=
 =?us-ascii?Q?fwZgUN8cBfPP5gStDy1ldPUfsYuo2V38il3GkYmAKMJAY+UaUpcsgKfKfIvC?=
 =?us-ascii?Q?RFb7zgU65xJwVyxcVFoW2LGHAk3crOrwe37ZGB6Cpe7PZ3nZmYOZP7vR/K+w?=
 =?us-ascii?Q?kiVuDsqQZvjt6VNo0A/4FyzgUU3kL79asGkSU61h3FJdBEDnpu3lM/eCmxKt?=
 =?us-ascii?Q?2dyLpcbXOET++27fh+zAPi9qEHErqi82rBUqbD7F7MmNb6crhssLkSHnTMCM?=
 =?us-ascii?Q?UObPcdrIqmtVp+FBqGUABcFstoYBuvyuSwVrws0ldBj2luSx/IZdWLrkpFCr?=
 =?us-ascii?Q?cGXdgtQGfgULKUzMOn3BDIiOjE4Ap3A/zLvY3uZrb66X99cOArZ8gBdfk5qU?=
 =?us-ascii?Q?15vFgyFLkROCqCz1hCmDjxmqO8aQly75uZJwL36mdP3terdAVp5msGQPbEdJ?=
 =?us-ascii?Q?25zhvRcbmw6O+svk7Is9ex/Xnfis0UQpJ53U/vjUN93vg3arfbi8PUXVZvML?=
 =?us-ascii?Q?e7bODP8uF+LIClIxx0p1aBYs+7b2PRYr1SyxTo4ge03Nio5CdPnBDer5H8E8?=
 =?us-ascii?Q?Es3lCemvl/GXqAKxPPAtJCiR8/+trimbtBvs28HbUkdOt4XmiHRyPGHeiqqS?=
 =?us-ascii?Q?4TTIsC2b9WZb0CkFOmH4YQSP13lztugVM5TUyrCOWtolRXwGBLvMck1pU/IO?=
 =?us-ascii?Q?g92PM9qV3Ad+dkL6ntSqknFK23d9Hd5Orc1wgycs9mWpM34txB0FVAoUIVXj?=
 =?us-ascii?Q?Jx+mMqa70vbOlj2ULVNSvxz+McoV2/LXWnmKc+gMUXJkU/REw7fTH+jAqwrG?=
 =?us-ascii?Q?BgMISOzhYPhRbR3FXKGO0eXpLiXanSpx92SaaMfIn/9FByNfjfYVBvlUyO6W?=
 =?us-ascii?Q?QlvnZneA++f6LORVVN48mCHY+Ux5B8MTkeCf1vYVP3NW060IyoZltYYmdOBC?=
 =?us-ascii?Q?xM7U/sCF7mmOpLMVlxefxuzXiPwyNpNMsFWAhSpCJ3+vQfrRa6HrNjS7J48P?=
 =?us-ascii?Q?3HyeicO2IMSbsta0Ph38wnvkq07Q+X7zXuT+5u0RZRbG38/+cfTGyaCCKOWj?=
 =?us-ascii?Q?Ru+fHSOK196RT13o2eBikYG4GwxyArE3IMAeF18FGZ6LnUFYo931N6vk3a7H?=
 =?us-ascii?Q?h6i5Jmbt1xc54W/yajhJ9DE5MgGKytdp03s4y2K+hGpRysTpSLb8T6+kQHpB?=
 =?us-ascii?Q?eba2TX6SctRjdE/SrSgl3Js/uVYOuwJtJTLNd56Dl9SfujL4wH3i6HW0BXpE?=
 =?us-ascii?Q?lw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b348d34-c8d4-4987-685b-08dce168e0ac
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 15:59:34.2808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WJqmxg+5CHUB7AwO4mXXwpgO0QUY60hIjqWZei2JzNTtEEpJIOFQzzQWpwfwLPY8sQleDvroN+TOoyPb5RL3hjNQabxtGrBNumy6f0gNoJE=
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

JH7110 switch to use upstream dt-bindings, so update
the clock definitions in drivers accordingly.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 drivers/clk/starfive/clk-jh7110-pll.c |  6 ++--
 drivers/clk/starfive/clk-jh7110.c     | 44 +++++++++++++--------------
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/clk/starfive/clk-jh7110-pll.c b/drivers/clk/starfive/clk-jh7110-pll.c
index 581035842f..df3e044f04 100644
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

