Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE30CAC58D
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 12:17:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B820E83544;
	Thu, 11 Sep 2025 14:15:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Cy9sJ5S6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9D51833BF; Thu, 11 Sep 2025 12:56:43 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FB21833AD
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 12:56:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8zdXC8N67srvQuLMp99sfzapQ3zTqKdCcTiguBqok54i0JZs+FvoLirgHzqukJNdF+mP0uc7z9F62iDVQttJpb4B7Bc836mtb1JElISxwrzc8XTzdZXQfHkN1dyDOimCSXWdkfYfLiH3l7qjwYccDRhUT5ce0uiZMe+K7cosqW4uXXMQkUuNrNrH1d+uhixL/Y+Aj6L+SDdwroMAEGxHXUjkgC9PaJFpYiZCZfYDMVVQZluhnPDULhE84dh5a0uNDdGd+hYqM50wtHRY9dhJy8cwBp4XszRsUaE1FXeAeiO7Wby6mEHvpZCm5QVNpwN8lk69UxmQn5LovSoHUc+VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s25arbctxNOY6fYBax9hjoiq5M52WbWqoe14e1jjwQ8=;
 b=rKG/8lor33QSESPuhLhlEIxQK69pC0aUjWG488pO23+mu/7csLXKwrT5mCtJkHG+yNwOIY0ilrZwTytuKg0PDRf3g8PCqCzlDGbrU5h61V1Qf+oHtSTo3Z5Yr/7s8LFCy9t5eDp5LZ/TZ+uzlEixiDRNpe/WM16US5O8paha8uwDJY89wefjRGsDVXVwmWHy58s3U+sZZxHBFkRrQGExSX+1rpGNVK1TuaW4eGiCFuEtaQCqt+HHn0aDSgSynq6NIPRnzp48DOhymlDAU+pHY1ChYeEGXN62lpstkkZXPIWf6q1x0YPh20XtfZHk6M44Vn3jQEIYPEIxLC5ya/rkbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s25arbctxNOY6fYBax9hjoiq5M52WbWqoe14e1jjwQ8=;
 b=Cy9sJ5S6Lt2Naoc3aKosJfquy+aoCworclI6Nve7/SUk4r6Yfm4FrUdXjOm1whmEWwopdwirmqATJwMejq4CVvM3Vrxktjfs2pLz2fWJAXELEQm3A67Ro/+PcbQsLrA4LJ7WNPd+x1HOMHd29GrQ40mPYwWLy4tgxJctUYJgcKgez0LijzlknORl1unJtc7mnKCMLMEDRO9Vzjt4MRno+CQtrcSJrr7DsL8E663Xc7l8NKJvzGHhFvNeAC9/jQdi7xpJtv9BPB0A7paNW4ruLOOoqeilcVQjn6PyVmw1D1XWQb7usEQd9/zM47jDS/YE6FFy4GP5X9GgAsYlf5mdCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by GV4PR04MB11752.eurprd04.prod.outlook.com (2603:10a6:150:2dc::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Thu, 11 Sep
 2025 10:56:39 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.9115.010; Thu, 11 Sep 2025
 10:56:39 +0000
From: Ye Li <ye.li@nxp.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, festevam@gmail.com, uboot-imx@nxp.com, alice.guo@nxp.com,
 ye.li@oss.nxp.com, tharvey@gateworks.com
Subject: [RESEND PATCH 2/8] pci: pcie_dw_imx: Add iMX9 support to the driver
Date: Thu, 11 Sep 2025 18:56:05 +0800
Message-Id: <20250911105611.3664965-3-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250911105611.3664965-1-ye.li@nxp.com>
References: <20250911105611.3664965-1-ye.li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0017.APCP153.PROD.OUTLOOK.COM (2603:1096::27) To
 AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|GV4PR04MB11752:EE_
X-MS-Office365-Filtering-Correlation-Id: f0fe1047-95b9-44d4-acee-08ddf121e273
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|19092799006|42112799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?29ZWAzypJdPTiL1Rj66V2Wqmf5UZ5Ei8sr8XvtfdrhRVwllVQc0DBILQjWl2?=
 =?us-ascii?Q?9Vnuczj9n95j/ULNRuR8qCdce/glKut1vNHF5DIyA9eo9hTGDmI7XzLfZ8Kj?=
 =?us-ascii?Q?mPHUQnHf2jjqBa+o1bghd3dIbehX11a7QLMyNFkVFptNxr/YlwTwZR1JTkWy?=
 =?us-ascii?Q?GYtW1oCE36f2FNUS4wJIhloyJhY6/H0q8YrTsuz6meO6/9rn52EHDe4vFxix?=
 =?us-ascii?Q?eJGqWMgy0KW53Jnc8ikbheLdlZ/YXnDPAmUz9+pGBEmYcHomzajZyZBkHTBS?=
 =?us-ascii?Q?8Ifix1IyHQgTvugSZhLW+9C1Fif7F8ptjzat7ge+O324wxXQeHOI2JXnfZ5t?=
 =?us-ascii?Q?aWik8NSy2tb4fK8qnqOLa+qExawKKTLMlUl6fbr/n4cDPS7oicxqrgRdG1CJ?=
 =?us-ascii?Q?UG5v/oOaxvAsiI25NnNhzr3ZruaHZgnOLJ/YLinC8UIPqYF4a9p+mEibovZv?=
 =?us-ascii?Q?wXVK46vH1v7eMaOMMGDG2MpyLhr51VTRqswKD4nA3E2khSpOlLnRXzcUg6ob?=
 =?us-ascii?Q?96KPuFvVf4+7ZLb9jziR4Gk3VjQcIrrQs+RfSnLWvMfQN9i/zgmvjOM7yiwj?=
 =?us-ascii?Q?H8u0IlKQJ1Md6p7ji4iJQxzciAOnAJS02NV7Uk5AG4ZUMfn0CN8g3oGl2tC2?=
 =?us-ascii?Q?vbMRGYeG+4sGKZs997EOQ8pFOkTl7kcHAkZ+jFbpmQoAsCDRfuewoaWxO/gb?=
 =?us-ascii?Q?qzv91jCUmSmaeNn9WVMSOJnmEe8Cq0FONBN0URuKpDsvZu6IEpkIhOee8JAy?=
 =?us-ascii?Q?6ZBFQCxVm37JlrALSnPCdMKj5clwyTEzLwJiohtIkUitkZei3VK1TWMB9bKx?=
 =?us-ascii?Q?Kbs3/Uq3p5vE+aZkOFie3H7/tgYGDUEMy7uQ1/rAoJ+I57Hv6pHYJAg0xjFE?=
 =?us-ascii?Q?9RPeW4F3Kvq9B/ACDWN4b8CD54mXZm08AN3J1Dvq3+/a7Pq0EcJjv6qUIuXD?=
 =?us-ascii?Q?PbJ/9pAP2IqUVMOVZiUxr4TAga1P7x2sxh6K9NZ+V1MzuVcWiWCu418CAg0A?=
 =?us-ascii?Q?SuKJOv/wCmRFDXA9qEz/NtJ9gkPrRa3pijixzTLESSyXY/GDC86AAhjDJC1M?=
 =?us-ascii?Q?RGWiPU9AvJg+ABhak/skK12zrjb0IWaQ7eOOIYwIc/qCdVgNR9mlp955PyKr?=
 =?us-ascii?Q?ip70rF6yo3GFqYrmNUBiNaF7Yu2Iyhqjd7zCE73fe6n3sbaehBGI+1DTMg8A?=
 =?us-ascii?Q?KuaOxzcmVZvq1b3YvCo6paCKdeOhl+86ovg5KuDIsulNOjIuF24dYOJgMUGk?=
 =?us-ascii?Q?I+l8XMXx5y5Ej2A/6MK8TmfM3WURRXFaRP6NNcFIT2cJb4T50JZwWLx/GJtm?=
 =?us-ascii?Q?FGiIcVuAvgo1H8AJUCfBxgAFn1HD4lLr+dvm7/8Xe4dqPbqX0TMAv3q4aZ9a?=
 =?us-ascii?Q?HqYno4aW70vHdILX6Cl5ik86SovlVKXzQxtbpLAgaDCxHEd78F09+eo4U718?=
 =?us-ascii?Q?ZcSfIfce/ERP5zHzDX8/H9+yImCU2IFKCb4qoRgfB8cptAUnCUE6Arq8wgcs?=
 =?us-ascii?Q?v93jwyx2tRN0TV0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(19092799006)(42112799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+w3pQs2ZpWsQi+i+YikdAN7H5q7PJIJQp5xlEE7zYzHGS/je6v55aoaTrA98?=
 =?us-ascii?Q?dWNIKBrV3VQEfypfFY65WgHEd5BfdeTg727jxAoLKUzEiOWEy/P8sX+gEICe?=
 =?us-ascii?Q?GgsnX2Ukj0HGBdWEpwsELqnz09g1S9iHr03B5Xqsl8esjQuD4kWrhF/+GetO?=
 =?us-ascii?Q?q35oBvuDOZa6OQuydWRGqNtJkII0em6QSBAWw4EGo6WqxjppU3aABgasLlUY?=
 =?us-ascii?Q?kzjFEcxSApsNXaioRSjMGImP5tkPRB1qoYTBWvGumxv0cLFcLFNimqNa2KaH?=
 =?us-ascii?Q?o55Y9rk0PlB3wD4BdGeiao2dasDzmC0qXUS0aInBbq9kYTnzFKSKmj5lGARK?=
 =?us-ascii?Q?HsZJyxwmBffbhM281sLX8rJNeGyDcHiSC4xiRlrb1pdmswuH/kACNAkMAMX4?=
 =?us-ascii?Q?jwoAQm4iTNBWoXJtC18TWNJ/wVeDNNxGnvW+ZgDrNzEI0Ek3uoELGeqrYI7V?=
 =?us-ascii?Q?mYJ+Fu1khGiemo5G1Nk172a9TcsbSx7gS2GBcCt3mMPk+glUx+6WTf+ivL1n?=
 =?us-ascii?Q?Gq+cOS41r/RFTXYxLth4m9WGbBhsuizbiuHkQKl5Yzj1Bb8PvplG+2EKAXqi?=
 =?us-ascii?Q?o2IRyZ16jmzCrzqMubDy2yseITjYj6Wp8l0CY44Uf5p3/zjOozJ+NVaVKjUB?=
 =?us-ascii?Q?XHHMg7uZOUYhK8M/ggZ4ragjq9DsSk0BsqFrp2nE0eBdTyRlZy28mnDev4U3?=
 =?us-ascii?Q?WUQ7NLQJt5ljCgmpB/yN4Bmp8MjJx6ch0aK/4lVqjjHODkEnHLkUaSQH2ZdI?=
 =?us-ascii?Q?PoNr5TyhJ4gTrPO2RDl1BQ0J+M1Fp8nTntCCrefr04ZJgV+ZWTD4BbQ0sKaI?=
 =?us-ascii?Q?FhFZq0YcpWwe1w+TceJeBrmglhkYSumXuQEY7HIt6Z6Iw6BzhkRrNGsZcsMn?=
 =?us-ascii?Q?RANmdAIMN01uL493Dk/xBQt2J3mpKU8lC1Enpl55tcxuPdA3TK/jZ67MUkrS?=
 =?us-ascii?Q?02K9MMNs1i9l1Dp3hQZU7/Vn5KzCyWptGqbxzr0h57zOjkSRQp1s8iQrg63y?=
 =?us-ascii?Q?Mz9f+2QtJzWL3S8W7bIHEeEnDWaO8TCb0g706LgG25uhmPDGD0oCeRLFIY5N?=
 =?us-ascii?Q?7tuFI86KzI98wP9f8COBNInPNsbh6Gcmeug46nXDE0qDx1LNKtjy88zossN3?=
 =?us-ascii?Q?tbMsYnwa+O6OLTmgGe1A82s4TzvoEu56qTU4CHhpO7jvGWruUdZPqW4NC2U1?=
 =?us-ascii?Q?o4ir7p7us6wJwyZZkVZ/wTtgzDRaDLbeNLQnmjodtJJ863lWU3fsyqKffS9Y?=
 =?us-ascii?Q?SSO2kdy1v3ytzIJjCmRcGphW3TbtxtBLC0yd8CwhAlOLPzJ2q4WzQdAJdfkF?=
 =?us-ascii?Q?1LQR05WMdmsgBSaLLGj6TrkkeDq24nK4zqfEdWnO9e8ssnhbu46+O2V8jKAi?=
 =?us-ascii?Q?U7Euff1b0pGgK5UD5hh9wGB6GBLLujWj07wKimVHOj+UqDVakHwezWJtOti7?=
 =?us-ascii?Q?/6QivI690iIXpQawgYm1u+mdKrR3nLWSZNrPOlHsA4zXCabCPvUitThz1M/1?=
 =?us-ascii?Q?17SZQT3JfIDQeymYzGHxU8or9UYl5gEVwFTjXajni74zWlTZAOgCAgStn9dW?=
 =?us-ascii?Q?PqXDdZlAIdXZGTJf9Gg1zSCxr4Jpn10skrnYAcHY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0fe1047-95b9-44d4-acee-08ddf121e273
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 10:56:39.5447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T0OfUrRT2FkUF2LkNmNt4vy/o/WGeIKuahRLaYxMZ+g7CUee70n2L1jbuJlrTFD+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11752
X-Mailman-Approved-At: Thu, 11 Sep 2025 14:15:16 +0200
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

Adding iMX95/iMX94 support to the dw driver. Follow kernel driver
stype to use flags to distinguish the characteristic of different
platforms.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 drivers/pci/Kconfig       |   2 +-
 drivers/pci/pcie_dw_imx.c | 420 ++++++++++++++++++++++++++++++++++----
 2 files changed, 377 insertions(+), 45 deletions(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 8ffd88c722d..9ec3ed856bf 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -456,7 +456,7 @@ config PCIE_STARFIVE_JH7110
 
 config PCIE_DW_IMX
 	bool "i.MX DW PCIe controller support"
-	depends on ARCH_IMX8M
+	depends on ARCH_IMX8M || ARCH_IMX9
 	select PCIE_DW_COMMON
 	select DM_REGULATOR
 	select REGMAP
diff --git a/drivers/pci/pcie_dw_imx.c b/drivers/pci/pcie_dw_imx.c
index fdb463710ba..f84c7180560 100644
--- a/drivers/pci/pcie_dw_imx.c
+++ b/drivers/pci/pcie_dw_imx.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2024 Linaro Ltd.
+ * Copyright 2025 NXP
  *
  * Author: Sumit Garg <sumit.garg@linaro.org>
  */
@@ -45,6 +46,47 @@
 #define IMX8M_GPR_PCIE_CLK_REQ_OVERRIDE_EN	BIT(10)
 #define IMX8M_GPR_PCIE_CLK_REQ_OVERRIDE		BIT(11)
 
+#define IMX95_PCIE_PHY_GEN_CTRL			0x0
+#define IMX95_PCIE_REF_USE_PAD			BIT(17)
+
+#define IMX95_PCIE_PHY_MPLLA_CTRL		0x10
+#define IMX95_PCIE_PHY_MPLL_STATE		BIT(30)
+
+#define IMX95_PCIE_SS_RW_REG_0			0xf0
+#define IMX95_PCIE_REF_CLKEN			BIT(23)
+#define IMX95_PCIE_PHY_CR_PARA_SEL		BIT(9)
+#define IMX95_PCIE_SS_RW_REG_1			0xf4
+#define IMX95_PCIE_CLKREQ_OVERRIDE_EN		BIT(8)
+#define IMX95_PCIE_CLKREQ_OVERRIDE_VAL		BIT(9)
+#define IMX95_PCIE_SYS_AUX_PWR_DET		BIT(31)
+
+#define IMX95_PE0_GEN_CTRL_1			0x1050
+#define IMX95_PCIE_DEVICE_TYPE			GENMASK(3, 0)
+
+#define IMX95_PE0_GEN_CTRL_3			0x1058
+#define IMX95_PCIE_LTSSM_EN			BIT(0)
+
+#define IMX95_PCIE_RST_CTRL			0x3010
+#define IMX95_PCIE_COLD_RST			BIT(0)
+
+#define GEN3_RELATED_OFF			0x890
+#define GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL	BIT(0)
+#define GEN3_RELATED_OFF_RXEQ_RGRDLESS_RXTS	BIT(13)
+#define GEN3_RELATED_OFF_GEN3_EQ_DISABLE	BIT(16)
+#define GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT	24
+#define GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK	GENMASK(25, 24)
+#define GEN3_RELATED_OFF_RATE_SHADOW_SEL_16_0GT	0x1
+
+#define IMX_PCIE_FLAG_HAS_PHYDRV        BIT(3)
+#define IMX_PCIE_FLAG_HAS_APP_RESET     BIT(4)
+#define IMX_PCIE_FLAG_HAS_SERDES        BIT(6)
+
+#define IMX_PCIE_MAX_INSTANCES	2
+
+/* Parameters for the waiting for PCIe PHY PLL to lock s*/
+#define PHY_PLL_LOCK_WAIT_USLEEP_MAX	200
+#define PHY_PLL_LOCK_WAIT_TIMEOUT	(2000 * PHY_PLL_LOCK_WAIT_USLEEP_MAX / 1000)
+
 struct pcie_dw_imx {
 	/* Must be first member of the struct */
 	struct pcie_dw			dw;
@@ -54,20 +96,203 @@ struct pcie_dw_imx {
 	struct reset_ctl		apps_reset;
 	struct phy			phy;
 	struct udevice			*vpcie;
+	void				*info;
+	u32				max_link_speed;
+	bool				enable_ext_refclk;
+	bool				supports_clkreq;
 };
 
 struct pcie_chip_info {
+	u32 flags;
+	const u32 ltssm_off;
+	const u32 ltssm_mask;
+	const u32 mode_off[IMX_PCIE_MAX_INSTANCES];
+	const u32 mode_mask[IMX_PCIE_MAX_INSTANCES];
 	const char *gpr;
+	void (*init_phy)(struct pcie_dw_imx *priv);
+	int (*enable_ref_clk)(struct pcie_dw_imx *priv, bool enable);
+	int (*core_reset)(struct pcie_dw_imx *priv, bool assert);
+	int (*wait_pll_lock)(struct pcie_dw_imx *priv);
+	void (*post_config)(struct pcie_dw_imx *priv);
 };
 
+static void imx95_pcie_init_phy(struct pcie_dw_imx *priv)
+{
+/*
+ * Workaround for ERR051624: The Controller Without Vaux Cannot
+ * Exit L23 Ready Through Beacon or PERST# De-assertion
+ *
+ * When the auxiliary power is not available the controller
+ * cannot exit from L23 Ready with beacon or PERST# de-assertion
+ * when main power is not removed.
+ *
+ * Workaround: Set SS_RW_REG_1[SYS_AUX_PWR_DET] to 1.
+ */
+	regmap_update_bits(priv->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_1,
+		IMX95_PCIE_SYS_AUX_PWR_DET, IMX95_PCIE_SYS_AUX_PWR_DET);
+
+	regmap_update_bits(priv->iomuxc_gpr,
+		IMX95_PCIE_SS_RW_REG_0,
+		IMX95_PCIE_PHY_CR_PARA_SEL,
+		IMX95_PCIE_PHY_CR_PARA_SEL);
+
+	if (priv->enable_ext_refclk) {
+		/* External clock is used as reference clock */
+		regmap_update_bits(priv->iomuxc_gpr,
+			IMX95_PCIE_PHY_GEN_CTRL,
+			IMX95_PCIE_REF_USE_PAD,
+			IMX95_PCIE_REF_USE_PAD);
+		regmap_update_bits(priv->iomuxc_gpr,
+			IMX95_PCIE_SS_RW_REG_0,
+			IMX95_PCIE_REF_CLKEN, 0);
+	} else {
+		regmap_update_bits(priv->iomuxc_gpr,
+			IMX95_PCIE_PHY_GEN_CTRL,
+			IMX95_PCIE_REF_USE_PAD, 0);
+
+		regmap_update_bits(priv->iomuxc_gpr,
+			IMX95_PCIE_SS_RW_REG_0,
+			IMX95_PCIE_REF_CLKEN,
+			IMX95_PCIE_REF_CLKEN);
+	}
+
+	/* Force CLKREQ# low by override */
+	if (!priv->supports_clkreq)
+		regmap_update_bits(priv->iomuxc_gpr,
+				   IMX95_PCIE_SS_RW_REG_1,
+				   IMX95_PCIE_CLKREQ_OVERRIDE_EN |
+				   IMX95_PCIE_CLKREQ_OVERRIDE_VAL,
+				   IMX95_PCIE_CLKREQ_OVERRIDE_EN |
+				   IMX95_PCIE_CLKREQ_OVERRIDE_VAL);
+}
+
+static int imx95_pcie_wait_for_phy_pll_lock(struct pcie_dw_imx *priv)
+{
+	u32 val;
+
+	if (regmap_read_poll_timeout(priv->iomuxc_gpr,
+				     IMX95_PCIE_PHY_MPLLA_CTRL, val,
+				     val & IMX95_PCIE_PHY_MPLL_STATE,
+				     PHY_PLL_LOCK_WAIT_USLEEP_MAX,
+				     PHY_PLL_LOCK_WAIT_TIMEOUT)) {
+		printf("PCIe PLL lock timeout\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int imx95_pcie_core_reset(struct pcie_dw_imx *priv, bool assert)
+{
+	u32 val;
+
+	if (assert) {
+		/*
+		 * From i.MX95 PCIe PHY perspective, the COLD reset toggle
+		 * should be complete after power-up by the following sequence.
+		 *                 > 10us(at power-up)
+		 *                 > 10ns(warm reset)
+		 *               |<------------>|
+		 *                ______________
+		 * phy_reset ____/              \________________
+		 *                                   ____________
+		 * ref_clk_en_______________________/
+		 * Toggle COLD reset aligned with this sequence for i.MX95 PCIe.
+		 */
+		regmap_update_bits(priv->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
+				   IMX95_PCIE_COLD_RST, IMX95_PCIE_COLD_RST);
+		/*
+		 * Make sure the write to IMX95_PCIE_RST_CTRL is flushed to the
+		 * hardware by doing a read. Otherwise, there is no guarantee
+		 * that the write has reached the hardware before udelay().
+		 */
+		regmap_read(priv->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
+				     &val);
+		udelay(15);
+		regmap_update_bits(priv->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
+				  IMX95_PCIE_COLD_RST, 0);
+		regmap_read(priv->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
+				     &val);
+		udelay(10);
+	}
+
+	return 0;
+}
+
+static void imx95_pcie_post_config(struct pcie_dw_imx *priv)
+{
+	u32 val;
+
+	/*
+	 * Workaround for ERR051586: Compliance with 8GT/s Receiver
+	 * Impedance ECN
+	 *
+	 * The default value of GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL] is
+	 * 1 which makes receiver non-compliant with the ZRX-DC
+	 * parameter for 2.5 GT/s when operating at 8 GT/s or higher. It
+	 * causes unnecessary timeout in L1.
+	 *
+	 * Workaround: Program GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL] to 0.
+	 */
+	dw_pcie_dbi_write_enable(&priv->dw, true);
+	val = readl(priv->dw.dbi_base + GEN3_RELATED_OFF);
+	val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
+	writel(val, priv->dw.dbi_base + GEN3_RELATED_OFF);
+	dw_pcie_dbi_write_enable(&priv->dw, false);
+}
+
+static int imx8mm_pcie_enable_ref_clk(struct pcie_dw_imx *priv, bool enable)
+{
+	regmap_update_bits(priv->iomuxc_gpr, IOMUXC_GPR14_OFFSET,
+			   IMX8M_GPR_PCIE_CLK_REQ_OVERRIDE,
+			   enable ? 0 : IMX8M_GPR_PCIE_CLK_REQ_OVERRIDE);
+	regmap_update_bits(priv->iomuxc_gpr, IOMUXC_GPR14_OFFSET,
+			   IMX8M_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
+			   enable ? IMX8M_GPR_PCIE_CLK_REQ_OVERRIDE_EN : 0);
+	return 0;
+}
+
 static const struct pcie_chip_info imx8mm_chip_info = {
+	.flags = IMX_PCIE_FLAG_HAS_APP_RESET | IMX_PCIE_FLAG_HAS_PHYDRV,
 	.gpr = "fsl,imx8mm-iomuxc-gpr",
+	.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
 };
 
 static const struct pcie_chip_info imx8mp_chip_info = {
+	.flags = IMX_PCIE_FLAG_HAS_APP_RESET | IMX_PCIE_FLAG_HAS_PHYDRV,
 	.gpr = "fsl,imx8mp-iomuxc-gpr",
+	.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
+};
+
+static const struct pcie_chip_info imx95_chip_info = {
+	.flags = IMX_PCIE_FLAG_HAS_SERDES,
+	.ltssm_off = IMX95_PE0_GEN_CTRL_3,
+	.ltssm_mask = IMX95_PCIE_LTSSM_EN,
+	.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
+	.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
+	.init_phy = imx95_pcie_init_phy,
+	.core_reset = imx95_pcie_core_reset,
+	.wait_pll_lock = imx95_pcie_wait_for_phy_pll_lock,
+	.post_config = imx95_pcie_post_config,
 };
 
+static void imx_pcie_configure_type(struct pcie_dw_imx *priv)
+{
+	struct pcie_chip_info *info = (struct pcie_chip_info *)(priv->info);
+	unsigned int mask, val, mode;
+
+	mode = PCI_EXP_TYPE_ROOT_PORT;
+
+	/* If mode_mask is 0, then generic PHY driver is used to set the mode */
+	if (!info->mode_mask[0])
+		return;
+
+	mask = info->mode_mask[0];
+	val = mode << (ffs(mask) - 1);
+
+	regmap_update_bits(priv->iomuxc_gpr, info->mode_off[0], mask, val);
+}
+
 static void pcie_dw_configure(struct pcie_dw_imx *priv, u32 cap_speed)
 {
 	dw_pcie_dbi_write_enable(&priv->dw, true);
@@ -75,17 +300,34 @@ static void pcie_dw_configure(struct pcie_dw_imx *priv, u32 cap_speed)
 	clrsetbits_le32(priv->dw.dbi_base + PCIE_LINK_CAPABILITY,
 			TARGET_LINK_SPEED_MASK, cap_speed);
 
+	clrsetbits_le32(priv->dw.dbi_base + PCIE_LINK_CTL_2,
+			TARGET_LINK_SPEED_MASK, cap_speed);
+
 	dw_pcie_dbi_write_enable(&priv->dw, false);
 }
 
 static void imx_pcie_ltssm_enable(struct pcie_dw_imx *priv)
 {
-	reset_deassert(&priv->apps_reset);
+	struct pcie_chip_info *info = (struct pcie_chip_info *)(priv->info);
+
+	if (info->ltssm_mask)
+		regmap_update_bits(priv->iomuxc_gpr, info->ltssm_off, info->ltssm_mask,
+				   info->ltssm_mask);
+
+	if (info->flags & IMX_PCIE_FLAG_HAS_APP_RESET)
+		reset_deassert(&priv->apps_reset);
 }
 
 static void imx_pcie_ltssm_disable(struct pcie_dw_imx *priv)
 {
-	reset_assert(&priv->apps_reset);
+	struct pcie_chip_info *info = (struct pcie_chip_info *)(priv->info);
+
+	if (info->ltssm_mask)
+		regmap_update_bits(priv->iomuxc_gpr, info->ltssm_off,
+				   info->ltssm_mask, 0);
+
+	if (info->flags & IMX_PCIE_FLAG_HAS_APP_RESET)
+		reset_assert(&priv->apps_reset);
 }
 
 static bool is_link_up(u32 val)
@@ -122,6 +364,11 @@ static int pcie_link_up(struct pcie_dw_imx *priv, u32 cap_speed)
 
 static int imx_pcie_assert_core_reset(struct pcie_dw_imx *priv)
 {
+	struct pcie_chip_info *info = (struct pcie_chip_info *)(priv->info);
+
+	if (info->core_reset)
+		info->core_reset(priv, true);
+
 	if (dm_gpio_is_valid(&priv->reset_gpio)) {
 		dm_gpio_set_value(&priv->reset_gpio, 1);
 		mdelay(20);
@@ -133,6 +380,7 @@ static int imx_pcie_assert_core_reset(struct pcie_dw_imx *priv)
 static int imx_pcie_clk_enable(struct pcie_dw_imx *priv)
 {
 	int ret;
+	struct pcie_chip_info *info = (struct pcie_chip_info *)(priv->info);
 
 	ret = clk_enable_bulk(&priv->clks);
 	if (ret)
@@ -142,11 +390,8 @@ static int imx_pcie_clk_enable(struct pcie_dw_imx *priv)
 	 * Set the over ride low and enabled make sure that
 	 * REF_CLK is turned on.
 	 */
-	regmap_update_bits(priv->iomuxc_gpr, IOMUXC_GPR14_OFFSET,
-			   IMX8M_GPR_PCIE_CLK_REQ_OVERRIDE, 0);
-	regmap_update_bits(priv->iomuxc_gpr, IOMUXC_GPR14_OFFSET,
-			   IMX8M_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
-			   IMX8M_GPR_PCIE_CLK_REQ_OVERRIDE_EN);
+	if (info->enable_ref_clk)
+		info->enable_ref_clk(priv, true);
 
 	/* allow the clocks to stabilize */
 	udelay(500);
@@ -156,6 +401,11 @@ static int imx_pcie_clk_enable(struct pcie_dw_imx *priv)
 
 static void imx_pcie_deassert_core_reset(struct pcie_dw_imx *priv)
 {
+	struct pcie_chip_info *info = (struct pcie_chip_info *)(priv->info);
+
+	if (info->core_reset)
+		info->core_reset(priv, false);
+
 	if (!dm_gpio_is_valid(&priv->reset_gpio))
 		return;
 
@@ -170,10 +420,11 @@ static int pcie_dw_imx_probe(struct udevice *dev)
 	struct pcie_dw_imx *priv = dev_get_priv(dev);
 	struct udevice *ctlr = pci_get_controller(dev);
 	struct pci_controller *hose = dev_get_uclass_priv(ctlr);
+	struct pcie_chip_info *info = (void *)dev_get_driver_data(dev);
 	int ret;
 
 	if (priv->vpcie) {
-		ret = regulator_set_enable(priv->vpcie, true);
+		ret = regulator_set_enable_if_allowed(priv->vpcie, true);
 		if (ret) {
 			dev_err(dev, "failed to enable vpcie regulator\n");
 			return ret;
@@ -186,31 +437,49 @@ static int pcie_dw_imx_probe(struct udevice *dev)
 		return ret;
 	}
 
+	if (info->init_phy)
+		info->init_phy(priv);
+
+	imx_pcie_configure_type(priv);
+
 	ret = imx_pcie_clk_enable(priv);
 	if (ret) {
 		dev_err(dev, "failed to enable clocks\n");
 		goto err_clk;
 	}
 
-	ret = generic_phy_init(&priv->phy);
-	if (ret) {
-		dev_err(dev, "failed to initialize PHY\n");
-		goto err_phy_init;
-	}
+	if (info->flags & IMX_PCIE_FLAG_HAS_PHYDRV) {
+		ret = generic_phy_init(&priv->phy);
+		if (ret) {
+			dev_err(dev, "failed to initialize PHY\n");
+			goto err_phy_init;
+		}
 
-	ret = generic_phy_power_on(&priv->phy);
-	if (ret) {
-		dev_err(dev, "failed to power on PHY\n");
-		goto err_phy_power;
+		ret = generic_phy_power_on(&priv->phy);
+		if (ret) {
+			dev_err(dev, "failed to power on PHY\n");
+			goto err_phy_power;
+		}
 	}
 
 	imx_pcie_deassert_core_reset(priv);
 
+	if (info->wait_pll_lock) {
+		ret = info->wait_pll_lock(priv);
+		if (ret) {
+			dev_err(dev, "failed to wait pll lock\n");
+			goto err_link;
+		}
+	}
+
+	if (info->post_config)
+		info->post_config(priv);
+
 	priv->dw.first_busno = dev_seq(dev);
 	priv->dw.dev = dev;
 	pcie_dw_setup_host(&priv->dw);
 
-	if (pcie_link_up(priv, LINK_SPEED_GEN_1)) {
+	if (pcie_link_up(priv, priv->max_link_speed)) {
 		printf("PCIE-%d: Link down\n", dev_seq(dev));
 		ret = -ENODEV;
 		goto err_link;
@@ -229,26 +498,41 @@ static int pcie_dw_imx_probe(struct udevice *dev)
 	return 0;
 
 err_link:
-	generic_shutdown_phy(&priv->phy);
+	if (info->flags & IMX_PCIE_FLAG_HAS_PHYDRV)
+		generic_shutdown_phy(&priv->phy);
 err_phy_power:
-	generic_phy_exit(&priv->phy);
+	if (info->flags & IMX_PCIE_FLAG_HAS_PHYDRV)
+		generic_phy_exit(&priv->phy);
 err_phy_init:
-	clk_disable_bulk(&priv->clks);
+	clk_release_bulk(&priv->clks);
 err_clk:
 	imx_pcie_deassert_core_reset(priv);
 
+	dm_gpio_free(dev, &priv->reset_gpio);
+
+	if (priv->vpcie)
+		regulator_set_enable_if_allowed(priv->vpcie, false);
+
 	return ret;
 }
 
 static int pcie_dw_imx_remove(struct udevice *dev)
 {
 	struct pcie_dw_imx *priv = dev_get_priv(dev);
+	struct pcie_chip_info *info = (void *)dev_get_driver_data(dev);
+
+	if (info->flags & IMX_PCIE_FLAG_HAS_PHYDRV)
+		generic_shutdown_phy(&priv->phy);
 
-	generic_shutdown_phy(&priv->phy);
 	dm_gpio_free(dev, &priv->reset_gpio);
-	reset_free(&priv->apps_reset);
+	if (info->flags & IMX_PCIE_FLAG_HAS_APP_RESET)
+		reset_free(&priv->apps_reset);
+
 	clk_release_bulk(&priv->clks);
 
+	if (priv->vpcie)
+		regulator_set_enable_if_allowed(priv->vpcie, false);
+
 	return 0;
 }
 
@@ -257,7 +541,9 @@ static int pcie_dw_imx_of_to_plat(struct udevice *dev)
 	struct pcie_chip_info *info = (void *)dev_get_driver_data(dev);
 	struct pcie_dw_imx *priv = dev_get_priv(dev);
 	ofnode gpr;
-	int ret;
+	int ret, index;
+
+	priv->info = info;
 
 	/* Get the controller base address */
 	priv->dw.dbi_base = (void *)dev_read_addr_name(dev, "dbi");
@@ -274,17 +560,29 @@ static int pcie_dw_imx_of_to_plat(struct udevice *dev)
 		return -EINVAL;
 	}
 
+	priv->dw.atu_base = (void *)dev_read_addr_name_ptr(dev, "atu");
+	if (!priv->dw.atu_base)
+		dev_dbg(dev, "failed to get atu address from dtb\n");
+
 	ret = clk_get_bulk(dev, &priv->clks);
 	if (ret) {
 		dev_err(dev, "failed to get PCIe clks\n");
 		return ret;
 	}
 
-	ret = reset_get_by_name(dev, "apps", &priv->apps_reset);
-	if (ret) {
-		dev_err(dev,
-			"Failed to get PCIe apps reset control\n");
-		goto err_reset;
+	index = ofnode_stringlist_search(dev_ofnode(dev), "clock-names", "ext-ref");
+	if (index < 0)
+		priv->enable_ext_refclk = false;
+	else
+		priv->enable_ext_refclk = true;
+
+	if (info->flags & IMX_PCIE_FLAG_HAS_APP_RESET) {
+		ret = reset_get_by_name(dev, "apps", &priv->apps_reset);
+		if (ret) {
+			dev_err(dev,
+				"Failed to get PCIe apps reset control\n");
+			goto err_reset;
+		}
 	}
 
 	ret = gpio_request_by_name(dev, "reset-gpio", 0, &priv->reset_gpio,
@@ -294,26 +592,58 @@ static int pcie_dw_imx_of_to_plat(struct udevice *dev)
 		goto err_gpio;
 	}
 
-	ret = generic_phy_get_by_name(dev, "pcie-phy", &priv->phy);
-	if (ret) {
-		dev_err(dev, "failed to get pcie phy\n");
-		goto err_phy;
+	if (info->flags & IMX_PCIE_FLAG_HAS_PHYDRV) {
+		ret = generic_phy_get_by_name(dev, "pcie-phy", &priv->phy);
+		if (ret) {
+			dev_err(dev, "failed to get pcie phy\n");
+			goto err_phy;
+		}
 	}
 
-	gpr = ofnode_by_compatible(ofnode_null(), info->gpr);
-	if (ofnode_equal(gpr, ofnode_null())) {
-		dev_err(dev, "unable to find GPR node\n");
-		ret = -ENODEV;
-		goto err_phy;
+	if (info->flags & IMX_PCIE_FLAG_HAS_SERDES) {
+		void __iomem *app_base;
+		fdt_size_t app_size;
+		struct regmap_config config;
+
+		app_base = (void *)dev_read_addr_size_name(dev, "app", &app_size);
+		if ((fdt_addr_t)app_base == FDT_ADDR_T_NONE) {
+			dev_err(dev, "failed to get app_base address\n");
+			return -EINVAL;
+		}
+
+		config.r_start = (ulong)app_base;
+		config.r_size = (ulong)app_size;
+		config.reg_offset_shift = 0;
+		config.width = REGMAP_SIZE_32;
+
+		priv->iomuxc_gpr = devm_regmap_init(dev, NULL, NULL, &config);
+		if (IS_ERR(priv->iomuxc_gpr)) {
+			dev_err(dev, "unable to remap gpr\n");
+			ret = PTR_ERR(priv->iomuxc_gpr);
+			goto err_phy;
+		}
 	}
 
-	priv->iomuxc_gpr = syscon_node_to_regmap(gpr);
-	if (IS_ERR(priv->iomuxc_gpr)) {
-		dev_err(dev, "unable to find iomuxc registers\n");
-		ret = PTR_ERR(priv->iomuxc_gpr);
-		goto err_phy;
+	if (info->gpr) {
+		gpr = ofnode_by_compatible(ofnode_null(), info->gpr);
+		if (ofnode_equal(gpr, ofnode_null())) {
+			dev_err(dev, "unable to find GPR node\n");
+			ret = -ENODEV;
+			goto err_phy;
+		}
+
+		priv->iomuxc_gpr = syscon_node_to_regmap(gpr);
+		if (IS_ERR(priv->iomuxc_gpr)) {
+			dev_err(dev, "unable to find iomuxc registers\n");
+			ret = PTR_ERR(priv->iomuxc_gpr);
+			goto err_phy;
+		}
 	}
 
+	priv->max_link_speed = dev_read_u32_default(dev, "fsl,max-link-speed", LINK_SPEED_GEN_1);
+
+	priv->supports_clkreq = dev_read_bool(dev, "supports-clkreq");
+
 	/* vpcie-supply regulator is optional */
 	device_get_supply_regulator(dev, "vpcie-supply", &priv->vpcie);
 
@@ -322,7 +652,8 @@ static int pcie_dw_imx_of_to_plat(struct udevice *dev)
 err_phy:
 	dm_gpio_free(dev, &priv->reset_gpio);
 err_gpio:
-	reset_free(&priv->apps_reset);
+	if (info->flags & IMX_PCIE_FLAG_HAS_APP_RESET)
+		reset_free(&priv->apps_reset);
 err_reset:
 	clk_release_bulk(&priv->clks);
 
@@ -337,6 +668,7 @@ static const struct dm_pci_ops pcie_dw_imx_ops = {
 static const struct udevice_id pcie_dw_imx_ids[] = {
 	{ .compatible = "fsl,imx8mm-pcie", .data = (ulong)&imx8mm_chip_info, },
 	{ .compatible = "fsl,imx8mp-pcie", .data = (ulong)&imx8mp_chip_info, },
+	{ .compatible = "fsl,imx95-pcie", .data = (ulong)&imx95_chip_info, },
 	{ }
 };
 
-- 
2.37.1

