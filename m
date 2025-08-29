Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3C9CA0FF9
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 14:31:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 325E9837A7;
	Fri, 29 Aug 2025 16:29:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3978883599; Fri, 29 Aug 2025 08:10:20 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20706.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::706])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2C0883487
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 08:10:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XfXgEsseYiae6B1MHDrHCe9UGm7JN/8fOgo3G3aQAVAw/Dcy0x3A2/6XBc1+X87UuD+ZcqlKmx/5EfjZ9dfGa4yna2ziuOHFHjjgZiBuhKSim5R/BkN9+DSWhXfRMvxwEBXWG73ZcwlhrTPCEIluoxBJBhUDvI2MYEHvk7GOg8dKqX5oFQtcPswhoy4bhFdf3mjZLvrS+Cu+X5b9iQsDHRqBrpX6EqLLzFd2lihdYCdtJbZBby5+Z2lH2KGlagsA09byXeuEqDKsiC379i+Pr1vhrI73VRYCFu52Xm8oHtXq3tz2ptdWuQBz4Q3WOm1XK8ObmND7enmSiNC6DvKn3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPs9DyarhU89Z5WLDpXLzk7ksfUWTNRA6KiUdUGD+sk=;
 b=A8ch0NKdB8O825aIWS+I3lqNxhUIXLmRhTPetXXGAi5+GhxjJHfcyAdoBRkEp4bQxJ+Kkl56wrughB3k2T20ollnEi46gVxE0nxPJU0TdiE2InvRwP9u3fwYSR3SPhQpG6rbOO3zJGlKN1jzwU79uNckQ19bvt0m5GUz53x7RZf2squu8J57xZPs/6RsA9DHCfQX0NGefkD2AfhXfTdwycXu7iIM3/nLzKnJrwV2SlhSRymr7fRTipzkgm5i2QPUMzZke8DX7JkQsf0UbL7jDQOyAx9HxJV5nGzxS2amW2K7pR9UvIJCytFu4AIYiJp5PAouullpgHjKPruC9rA4ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1257.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.25; Fri, 29 Aug
 2025 06:10:11 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9052.024; Fri, 29 Aug 2025
 06:10:11 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 E Shattow <e@freeshell.de>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	u-boot@lists.denx.de
Subject: [RFC 06/10] pcie: starfive: Add a optional power gpio support
Date: Fri, 29 Aug 2025 14:09:27 +0800
Message-ID: <20250829060931.79940-7-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20250829060931.79940-1-hal.feng@starfivetech.com>
References: <20250829060931.79940-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::27) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1257:EE_
X-MS-Office365-Filtering-Correlation-Id: fdaf0c03-f01c-46b6-331b-08dde6c2b693
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|41320700013|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: tmlAuEReF5tBrZXAqm0BDopdm2LacfHm6rP23w0Y/RBDhuuLEb7s6OgwzuJQPRnErBlI5PjP0SdoBNHZ0jd5DuoXhhKqPzFEIUV5kqlUm6/cAVlVcoRN660YKhY0rjslD6YX4Z0tZI+t+8DnSnX/boUNGIia0Oh2gNQnUQn858g+azVFC93pMSPmx/1s7Cjf29F4ZeGqbUIrVz7S+9AbKOVaSpwdE1wgULflDQQuLnMa5tgKtxz2bRyE15RXnwwpe4TL2n/CX68c08ODauj/iA4IDMDAn7qnCjLTTZ1/2CCGGvkmWEWepbWwwmGkIl4axlXV268lSPtZ3foC2AblBVUfkw1+ns8K6fGxc+M/EgnLMQy73HGpqncla/UQAhd6icq5AzEytrA/xRU8ht/6om/0FQJdMV7Yb5HrabGkXZttHKIjWSH2AKe1NE4fXyMTucYSGDMfecCEDXj+shz3xr9F/Ux5v+eM0mmwK+1yvMaCQKtrymO1e9GqTs4pnMqTZYMMQgrHhDUFIbamxsD05wRZx3JFo7SQTSXcvIacbTYMKK9P9L5vMxkSu9i1pXRvPv4QSq6W6ZNF+W+epjo+/3awIZso0UVKRj71XpHdimU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(52116014)(366016)(41320700013)(1800799024)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4Mseme+5WDzu8u/1G4WoK0AkeyQfMiII4DcnzCHMOussJLTo34N+EScQSsB+?=
 =?us-ascii?Q?Cp482Mh7By6xwqPQ+drcf1bwasQdlCdmlE07g1/rS1YyUqK6y4j5oZzeXlQb?=
 =?us-ascii?Q?Wky6EL1cbr4WTpNLEkyqmkUQXki26D/sJLxw6cOq9TeUBlZ7WI4nJ/YqIZJz?=
 =?us-ascii?Q?E2QY4r6x4C3BUCpa1aOplT2RcqUlKE60FTDIrLiqKJQNbV7nNiz2csxkXxAC?=
 =?us-ascii?Q?sh7B2xJ5tX6OeqTYeO9RgwasXPGyPIFOQyKuLa9yLAdMWFfsuLOYQsiq90+B?=
 =?us-ascii?Q?Ss7ezq7L2KUq3YQn8H/pEPLQx4exS24I3KDJCCHdgbr72K+6+mbuNRm2VyYM?=
 =?us-ascii?Q?PC6gnOchWVQyhhBUSL6JHfGpZvWF91AYkU1827ID4EI5KyxC0GyVIMs/ueQ0?=
 =?us-ascii?Q?JKPCcxqok8ibSAgEAX2XtmtN14T9znMruIuof2mVxxhtQWLfJCCQ0de7isFP?=
 =?us-ascii?Q?WclOWB5+oOySjhJd+Dqbkyz9cQj2WBhN5Sb9OaAiM9AR8rMn10IHDtoYsLUC?=
 =?us-ascii?Q?EkDOvYk5JY6zIOINGb22yXGzLDSCDfvvJ27EXJ5T/Hz+XrbbPkhyATz+ZeAy?=
 =?us-ascii?Q?OfqieFFUJ1G6jxXUu2CNVGYE9Ie3JNpZGhVx2ECYamcnLEy6768yqJbiwQT2?=
 =?us-ascii?Q?NJvym4xgxAo5VO/E/311CoLAnhHYTzUFrpuvp5oFBRgDk59wr6xuqCu6IgM9?=
 =?us-ascii?Q?EoXxBJNGGSmD77UwKiB4w50TJhOvp5ESVBaSY4rTk3or3gLrgviGdGtaitAl?=
 =?us-ascii?Q?xv5mIrIpmERewGDYZi8Xr2NWWYimxwjKVrz4f0sxI+g7E8Was+A0BOKYkC/0?=
 =?us-ascii?Q?7vntxSIk2XOUH1WbrLpw73I2EdzPwozOYV3noBzM4s1qlNfIqYnTyDyVWGvu?=
 =?us-ascii?Q?UAG6HYtwA9JMhISpWzRRGn+q+2MxziUCsop2XLL+/ylvVYEhdg4HgP/3aHvG?=
 =?us-ascii?Q?rlnrbDc0pw5PCWUM1WBnWSsbC2EwpGZS52mBo0B3fSLVphypLS4MnuIYQ4zD?=
 =?us-ascii?Q?MBmEvcVVj+y5uAcWBe+Z1IR4ti/rXEXdyjTsqWc6/RkTfcvbmpzpAseVKz2Y?=
 =?us-ascii?Q?quELihjBE2DlucZVOp4kIkcHYPDMM7tluurh/VGXK//laoq4wErtO1JCAk71?=
 =?us-ascii?Q?5Rzsr5MIRpaOxAux+RlFUmxXAZDjat+Q+rvg7aBcNrv+J9UkBwFZMNzY1xX0?=
 =?us-ascii?Q?/PbomOCxZp/Qs2zgOt2rAUrMY9uyofEpWGpaqtaCMR3dDdW4jGqwXn7tj5dh?=
 =?us-ascii?Q?Rfnhtfx3HEMGFjlCigSdFkn4NGXo/FnVXHZazvVuBgAgie7AXN3+25Hl8vrT?=
 =?us-ascii?Q?XmkwEIwawtdq6Fwmq9FnHTahAfZcoca41QFsO4bXgR3q/PGrWVdwoiX8Ks4v?=
 =?us-ascii?Q?n5uGYJuUPlm3yAhAbgdn1lB5R8o80Yrj1ygdfx2hwDfriF4fLRQAbB3p7gws?=
 =?us-ascii?Q?P8AywaP/SfNO9sxufq8Qtxyx+uqlbk6zYT29k59Rdn+upNfnjKEtoNYKoWVo?=
 =?us-ascii?Q?BwJrqA8rFnm3o0A42J7GhUU80YihQeyQRWiOSuTkqxazgHbSyllWiiNtvEyu?=
 =?us-ascii?Q?rUurgB9LzyRwpnA7mjBljxYZ7CtF2h94aW7HFQ5nS0Q2Vccmk4CG5mGYZX59?=
 =?us-ascii?Q?wg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdaf0c03-f01c-46b6-331b-08dde6c2b693
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 06:10:11.8901 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H3kgp4CfIltk1AWMZmrxAK+VTbRcLWGeCCYQbYFO11RCDD5vs/xvqbyqNX2JGAW/+uUzk4Pq/+1zVKH1pWPyrgxuaecFqpbop3Kk1m8Uz/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1257
X-Mailman-Approved-At: Fri, 29 Aug 2025 16:29:12 +0200
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

Get a optional power gpio and enable it if it is valid.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 drivers/pci/pcie_starfive_jh7110.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/pcie_starfive_jh7110.c b/drivers/pci/pcie_starfive_jh7110.c
index 51aca7359ff..f6b50d12a90 100644
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

