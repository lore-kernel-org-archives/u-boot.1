Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25473D12D5C
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 02:24:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEF5E8932D;
	Mon, 11 Nov 2024 03:23:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D74A892E1; Mon, 11 Nov 2024 03:09:45 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20730.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::730])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 161C2892E8
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 03:09:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjLNsSGhZ9EVx0FvqwDbbNeyrlpSSlRTBhwMrJvTxCaS6cBGBNLJZAJVOlMnqA+4f/7uSsMqlJbhOYpUJsLx5/hK4VSKFbNJh+KJIwNy7A6OsLxFgiTfBLSCxNes7HLhDhfoXzbB1KSgN1kLVA6F4AWZg39RfA2KXHf6k1zvfjPyOGwFiO/ItaIh7mKmZYTX3z72aY3/9Cb6g39EHJXjkdngEPy7j5y70btsHu2pN29gmsLT26Z4XLbmuSToSh3vXT1OAqvUmiZV4vkqjozQkSzS8rDvUEhMY2r9bVkWY3y+fSarYeUSpe7VFp+lfU8iSUzZXc1qmecL80nW3nn2DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LgxYdyRp1NghF/SYV9jOcARi+qLrWOJ7sl20ZbCDfA=;
 b=YEgTU6OzabQmJeORwcF4OaOlZKz2rJpTKGUa8/j8ZtOPHHm5zOwXos+cxfcybdrNPpkcg+NSvQKomh4+uK24Ap/ftvu3zTWsuGI9i8A8S4l9/fN9X1FIgXsJv8E/0UaFpFzVGBXii93FDdyf1e/TArkDhK28jaTuM2GNp40Ulnq59JAtR1koLtT5bAnsJYQ7tFTn3vQ8UxVK1dkBQK7hPRZICdJxm5xqotHD7QCLv9CFmWun/HiIxf8LhuQ5RuRKe3sY1V2dFUHaFBJMoMQctDvyk2Iey3g1TA5pT8ABxZIa7cbS24nBXGoCGWrqB8rPwN0CQIURbINGsnF+dytDbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1178.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.36; Mon, 11 Nov
 2024 02:09:46 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8114.035; Mon, 11 Nov 2024
 02:09:46 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v4 05/13] clk: starfive: jh7110: Sync clock definitions with
 upstream dt-bindings
Date: Mon, 11 Nov 2024 10:08:00 +0800
Message-ID: <20241111020808.38974-6-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241111020808.38974-1-hal.feng@starfivetech.com>
References: <20241111020808.38974-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0004.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::16) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1178:EE_
X-MS-Office365-Filtering-Correlation-Id: 39da7b17-db0a-4f8b-2aad-08dd01f5ea05
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|41320700013|1800799024|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info: BgLAhCmnIqDZ+l02vFyD9TLy4NqFdRoOImQH+sKHuVEH2HGmoAp7BEMfeT3ozDJnwx6wV/E9Deu+ire2k1vNmi2Wde7ZkyrNhpGAD8fgIFR5qfFgeX3wgZxSVu3XB7Sgmw/6Yb7KsTJFUrGGrqwH8kbaNuy8qs2vuC+aA5qBHx75E9YiQgOi48XqtLgk4RDcMlZcv3K/Uws+y3N3rLw7rg6TSLZcpT+2wdI6jjiXjuGi1ZYmfzJkg8joa9ed5uBeyUgFg0MG4qrUh0aA3z032wxlXWrDuDBaNhmeZEiu77pqFpfYHYZrSMySEEkRauh5jKew0x3Zi0yA7bKwcY/uuYgGF+d4H2tlcy1bPjIlDN3UG+j4AvwoLjpqScytOPXocymwR1nIBOL+E6b2vKroJLLs/eGsQueHxAvaAwQrQEDUYevbSKet9peTDzLVn3BDGcYGyDoeP9ruw90Jne8yKaqFfggDqyS2LWNQOMtk0HfiBfV1MY2shfFKqYWHZ5KDl5FI9dXOp+3NsBpf2YIwe92amlkP4R3LkmqSBOT1xzvx6alx+lHeczVjSj4TlZQHbnY5Ys1VJf+Kx1WgIbHKqJYrWxqt00KU492SVp9BWxMgd5EAcZ/cjYBebR5uU0GL2OflIMusbD5UlTaL7xExXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(41320700013)(1800799024)(52116014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m6H/XiQ9LgppOnpAjCHuaEEu/48T58jqBslmcLYd/jfOJy4vMg3qPWkjW+Li?=
 =?us-ascii?Q?3iNBZyzi7s/Ulfc7oz6iWt9zpB8r/ojR3xlg1/GdPBLysX6/K+e74E21XqxW?=
 =?us-ascii?Q?hFOph0TAlPPqttodhF0JrjvfopD0/LK4B8TCy7ejJcuZttWARFZ5HVoHFjL2?=
 =?us-ascii?Q?ObVOwro7HPxmFAAeh3+JLqPmo+k6zY7XH1IitwoQ6BFjNeIZmY8iosb4n34O?=
 =?us-ascii?Q?woaKrmJ/PLDywmUDMIT59/reyqvB/LuA0ZEAYGN5QmT6cFX0ALi2c8+0m3Tb?=
 =?us-ascii?Q?w5JH3V3j1ueA7eTdkkVjv52eHYP8PfmaKYc7izKISwAj4KngmVeW37GIMOSu?=
 =?us-ascii?Q?ri7OAmMuUTc6GVxrogdJrJa0Pfd0wKOsQcPtBkvBZ2kgNbqjRp3PrqKNZrE7?=
 =?us-ascii?Q?xSOKyutgMUVWI+KMC85FIlGk0WxH2WVCxRACTLGDDptjr32PXeSxWHY22XU0?=
 =?us-ascii?Q?muOlNZ+qboLPENUAy+jrqXHhrZzblSZC+ck4rQQjJTuAogGIQ2VHr8wT1lpo?=
 =?us-ascii?Q?UgchqOuoQ0w/sNNPCaXYXi9kdbdGCANcM3v8drevT9WLDzR59vuuVljvjfue?=
 =?us-ascii?Q?RHyqwEyl67QMk/Go2EuP9dzLx4CCbLUA9xTQ/Xr8CaGSR5pxIP8mZ8ig5P8v?=
 =?us-ascii?Q?fUWgSl66MutqNSTjlkZBPrNJdXCjVB7NsFW9mJN8AmY2NEl3yWfpBjAUlOjk?=
 =?us-ascii?Q?1GsMprJGRF5/zm8URnrfNDEK7QXCbViytsSlf/Inj9XatSvrKp4h/zy5WS2F?=
 =?us-ascii?Q?x3QIfMjYOw47dXVrwdxIGDVAahujZeLyjViw6mNTqzWPhzQnaqQlSOxng+cU?=
 =?us-ascii?Q?ICtGCFElor/E6ViSiIfguuu+L8NXLariUpSiKUOZn+cBZyucoHMsi+wNeHhG?=
 =?us-ascii?Q?Miw/exFBcTygIKI3t58GS5enMbjK66XpfbbB8jaD2ts7ovUHFbg2gWIvlnsD?=
 =?us-ascii?Q?8hVLPqttPZChpbXSWsRLm2l+GyD+xVLZTEJ5eUO6GkrQoGFB0cCQc5+uiOqI?=
 =?us-ascii?Q?YLivFXSo8U6pfruhoX9HU/7hmvzOtI1SUwwxpSMrXjRQbgzIUGhdUCeNpBT5?=
 =?us-ascii?Q?GbcEDT3UPl/2//7TkC4Aty4xQsD/Tvia/F7gqiyw5F8YCBOnNWVtRh+ZDw3Y?=
 =?us-ascii?Q?f8+4SWBhIe6suJ9lD64KdaOjGRNYUJ5JpZ6Af2nGw109t4PyOuhlo6pJFC83?=
 =?us-ascii?Q?/WCmDqdzlqK5My2eLw7nqABn3ZPpNyKOSXS0gXl0NJYBZz3Gs7fqxzFMRzoZ?=
 =?us-ascii?Q?rsk904gNZOF7birDt0x23jX3kQbCHfPQ6ZS7+C335NS9bxxT17WgU0fkNSap?=
 =?us-ascii?Q?A/dcMcfvq/Vc2eUQjKny+/6OqrA7U64Gzm/8tyyxZ1gVorc+wENP3nYxtIbf?=
 =?us-ascii?Q?ij0WaKrofrVMr0bxOnIk/HPGxK/Ca8ah1YjbAjNreMSQwPlRndr4151hbJTu?=
 =?us-ascii?Q?ESTiAYb/0aPLy1+RXF8oOzkVYw99fFr8M6cYSJkEA9QkrMiau0PZDvFcjDIH?=
 =?us-ascii?Q?3qRSiNY1wSPjAmUeg0t9jzIhHcNOW7qh1IfS3huJoJxZeFSrJRaFZ0oneZdv?=
 =?us-ascii?Q?azENtDklMqvJTAOjvDZKO+AVOBcRoKsmc6VHcTo9ca83ZdMKICzG9xxyys+i?=
 =?us-ascii?Q?Fw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39da7b17-db0a-4f8b-2aad-08dd01f5ea05
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 02:09:46.2185 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RDZg2SCgtejGJdnhDM17K6bp9TciaZmVFSkrXSMvMWxJKVaL1yhWtBScmH1kabmBwROoMYTBdGfD6Dy5nCWOzuxWanVMcCd4zUor4hZ0UjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1178
X-Mailman-Approved-At: Mon, 11 Nov 2024 03:23:18 +0100
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

