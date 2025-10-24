Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C942CCF9E0
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 14:54:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FDCD83890;
	Fri, 24 Oct 2025 16:53:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 863F7835FE; Fri, 24 Oct 2025 10:59:51 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2072b.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::72b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1182836B2
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 10:59:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=is73F6+MxlaenyMiupgY5wqiGw4n+fc06iIcLZ4XRUQXu6UiserC0RTCOJZOblA8mK2OmG6TwD9hRKj9T9+J1rYkdcHsY1dwQ8kAnsabuUfhSuaQXo/4douIgtnyPkxYl/ezRJwYYbbwdOYg+7rTRcN8FpbH75dIbIxwuurmQqYMqmEDluKwjDDcbHAIJFuouh9t3fNBQK57Yy6llRC57iTUGLKSUzbsaA+2xs6CiH/3orO274HWq6g9GbVekE9GvTxXrMzrA+DWbEr+2NoBALsYWzXpBP+7egCVSzZSoChTfirmvAkvF76tB4I7GuQo+U6MWz5kb9EZw5BOXdbyNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWswoCtjf1C3NyfbSoAFd0nel196Cy1BsrVBAAC2Cu8=;
 b=Xme+ZDxuOrB7e5vvLemoWDwMRkcd5tbZnaBhfk0dmXb98t73piAVYKjXS2DJwdVT0UIZOf5g4f9uX6SeHAb6awEmabXyKlPgqlxPoSrF3kwb7v29Yd2PQSDvKkNcm6zlV6RHw9PO7xPhJaqgewqS1xb7kBNFLhWAA0qkMosDgc6vAfoKFOm53sBCJu3EfHvVp8loS89bLPp3pJgWY7Z+QzAByHOasyZSnn2FStywdmVHHjUfN713PqCiAgrxAzOuM4a3fYVXhgGyk3bW0yH5TjHWkfitAmasATeF7G+uD3A6hl4VSiJY7cqR1F9GsKRnSQwXebbMcM1VvLx+U+H4qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1228.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.18; Fri, 24 Oct
 2025 08:59:44 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9228.016; Fri, 24 Oct 2025
 08:59:44 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 E Shattow <e@freeshell.de>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 6/9] pcie: starfive: Add a optional power gpio support
Date: Fri, 24 Oct 2025 16:59:29 +0800
Message-ID: <20251024085932.83596-7-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20251024085932.83596-1-hal.feng@starfivetech.com>
References: <20251024085932.83596-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0069.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::36) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1228:EE_
X-MS-Office365-Filtering-Correlation-Id: 138c4ab5-e52f-4059-ab66-08de12dbacf3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|41320700013|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: Tm/u9ZquGvxp1TF8+HavByBtQm5F7ZMg/KQ6sGE8KWeosf8kTK4xY1+0VA+Pk7HJJTFyNMwf9XBm7ngXUp7IONc//9UVeKVWw0MK2aCwNtwe3wV1sZh9yF4TADpIg+VRQfe1uTOFlRrIXmlNbFLSAAo9v9LSM6KnokrzsPDHFMopOF+iJE0t5P2RTvpDW5JOd5pSQYCfBBXNRTFMRqBn79gCrGRNsTS2Cg+CM0+YLQCkgHoA+6t9UjfmUTdE0jYJuCCCikxawzXJWJAA/LLzZ5kEJVHbICU/9jLk5wya9UbLP6/cjAAp0ABI0b9vFKii9WE8DPfzaHJ7kb+4SRoZMLZNrExlOeO1ERafWKpLhnz+7HtMCq4AlrjRhnfc8jGVvouGlBT73uYW0xcZWg/cEnrBpJEJNRwxZKjwr9OrUczKBPzVFujiheYeYFIl2e4m/t7qVpeFBejOmouH2sypLbeGFt/tzXdQutcZFaS7coVsvkZU0hozp520VHOZQAHTpIUeq68bcxfd259btanFytCUK9wW0ByfMs+E5uy2dCBhuyMCFuCji7qIpnGOJe3nuoqzSC2c4KJn1FEbXetziSg7Y4SUblkZYz8yQXUqOC4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(52116014)(41320700013)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?euyK51WYmGs9x9yeamVoTkfmgNAqhqAdzgVfo/YcMHafzdfUcA6bkuvvKOvt?=
 =?us-ascii?Q?bbvnIBIDq5UAq1i+NunGpWhq9GC1Q5zxmGNQtO2A9aDrBH6idhLz6u+a27bv?=
 =?us-ascii?Q?USy5Yi9tcTaK8UlSTow36yfJrFG41H5qiWgYOyHdV4+Iaai4v9Ek+ZOw0EJ5?=
 =?us-ascii?Q?26MkN38g7AlzkTLCtNjX1QmjXvl7wnHzQP4JZmz8SrkEdpRUhBMtvnT99d+T?=
 =?us-ascii?Q?LpcFXUiPg8lOavoQtkkZN0mqQZDtcZckpioGE9s5YP2+Ab2THQZi7iq1rQqX?=
 =?us-ascii?Q?BFnkjJQ9Y+SQHgrTmvcq4Nc4bSuAqpcNp0nwyW2OeQf1uZYjsZC6A35YhEhF?=
 =?us-ascii?Q?a2mycZ5/VfQvjUYQZ2ekAc+vCOQtYqd/3x7vC7gTEtorWhluLCUZWHXWD0KL?=
 =?us-ascii?Q?mphuZHKMNuurxBSTGrvUmJXbnutPQ46/jkTfmWMxSOkRK7XD39GqTd0XuP1/?=
 =?us-ascii?Q?dARLGlg8UUkcd0YhWizfHynTP1zjQHFiUjmMcJxkuy85QY6T6/Jj+F6oudRP?=
 =?us-ascii?Q?wx+62aZaLUTvtBuLXsVh5ueUCMl0JgSrmA4BZrduWhsPj058EqVBMi+I7CRS?=
 =?us-ascii?Q?p/umAGG4q/YXygrmlPHGcX3+u6VqREvkPzl8WXKN+wt5q3y52gDJpY1ZBf/W?=
 =?us-ascii?Q?uqJDCII+RiUCB1rzq+HSi25K4Ls5EGQi5m+1FprTCnBssLlgBTV+pFve+Ws2?=
 =?us-ascii?Q?b/eLtd33kHColEUrUao34ZbgtxaRdcK9ShRIGPbnP445FxjCGFLnAMiOzzrn?=
 =?us-ascii?Q?CjQQMr+28VjFXCPJcsG8Bz26agfzxTPWm+ER9M0ohp0rZ+sc+9KrEfMSQoxc?=
 =?us-ascii?Q?KPaf1u+jVRkQBhFj4LaJCSOZFsWCwSGtZvCzgjoC+bT/Ex4Rken9nEUjtoRx?=
 =?us-ascii?Q?2QkDgUY3crhsa29ZX1EleEawFZ9pSqcAtJ+XPSEp8HHR0ZpL/lzm1b2A4U0x?=
 =?us-ascii?Q?8/4QCzqDu+JTXfa6PCMWApe8VA7n1d+h1Ay5wFg/4kNjk+Hm8MmCfqH1Roxt?=
 =?us-ascii?Q?KzPUA8Y/Ipw5wZLmzJ3XD3K7OcvvhO2daPHUz1tP2MWzN5ofN/dSBWf4hAQ/?=
 =?us-ascii?Q?lGdsLNDdBSKkWPSDS/5PwwI1MmNuHGi6pAmGvAyqPHI/TGSYtAGWKuIGHWp7?=
 =?us-ascii?Q?68a1+A0NDnwN4EFauU9kJpWPkmgZ3tSsNU+3maFlMkEZEBbkEgGof7fyHsbP?=
 =?us-ascii?Q?uhONWRH5VtVmwTKlQS6rX+aEjlIt++xgG1ZlnztaH0uRySPtTllqiKbxzhRE?=
 =?us-ascii?Q?FIAbB+fVoL7Avfq1bt8Mcqd+ZcPKxB7TGIhwlFf8YdJVAt+oaUktZ4TnHnHB?=
 =?us-ascii?Q?x901VdAs7JaVA3ptLchsEhvJy2zGguhAwqZeUQOxDu/5dTJNrgSyPnBztlZF?=
 =?us-ascii?Q?tRAC2BEIJb413k+bo5eA4jMaFWGox++lEUe2wGMW6jdaUfYhcy1HLEk0BbMR?=
 =?us-ascii?Q?GUC28Y/K378gOmInB5qtf71/1O/gUVpwrvYS0Y0wpx0iY/eYuaa4Z+SP12TA?=
 =?us-ascii?Q?6qq247SZ2wMvFXc20NOeqilXAnEtehyjasVbervRuIhAva1dEVISdsezu7s8?=
 =?us-ascii?Q?dERqxvbZf0KcejgXaNQdmTZPZ7Kn4zKtfgfq+Q/xdC0vS1mOHukjlg+TAsL3?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 138c4ab5-e52f-4059-ab66-08de12dbacf3
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 08:59:44.3371 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RunUfFhcVNyzFuaBRxMoe6ZrAu0iVxjNiWVfC0DIfDmyrmmfrYnyTr+URjch3q0N3E0iZt1nHMYp8ko9qItk9WAkFhvdvsSh9dfnl3tPwtY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1228
X-Mailman-Approved-At: Fri, 24 Oct 2025 16:52:55 +0200
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

Get and enable a optional power gpio. This feature is ported
from the jh7110 pcie driver in Linux. VisionFive 2 Lite needs
this gpio to enable the PCI bus device (M.2 M-Key) power.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 drivers/pci/pcie_starfive_jh7110.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/pcie_starfive_jh7110.c b/drivers/pci/pcie_starfive_jh7110.c
index 0908ae16b67..04088b48ddc 100644
--- a/drivers/pci/pcie_starfive_jh7110.c
+++ b/drivers/pci/pcie_starfive_jh7110.c
@@ -45,6 +45,7 @@ struct starfive_pcie {
 	struct pcie_plda plda;
 	struct clk_bulk	clks;
 	struct reset_ctl_bulk	rsts;
+	struct gpio_desc	power_gpio;
 	struct gpio_desc	reset_gpio;
 	struct regmap *regmap;
 	unsigned int stg_pcie_base;
@@ -184,6 +185,10 @@ static int starfive_pcie_parse_dt(struct udevice *dev)
 		dev_err(dev, "reset-gpio is not valid\n");
 		return -EINVAL;
 	}
+
+	gpio_request_by_name(dev, "enable-gpios", 0, &priv->power_gpio,
+			     GPIOD_IS_OUT);
+
 	return 0;
 }
 
@@ -205,6 +210,9 @@ static int starfive_pcie_init_port(struct udevice *dev)
 		goto err_deassert_clk;
 	}
 
+	if (dm_gpio_is_valid(&priv->power_gpio))
+		dm_gpio_set_value(&priv->power_gpio, 1);
+
 	dm_gpio_set_value(&priv->reset_gpio, 1);
 	/* Disable physical functions except #0 */
 	for (i = 1; i < PLDA_FUNC_NUM; i++) {
-- 
2.43.2

