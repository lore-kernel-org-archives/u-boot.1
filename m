Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58098CD6E57
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 10:03:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10BE4848B9;
	Tue,  2 Jun 2026 12:03:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sK/m0qJk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6F9D8488F; Tue,  2 Jun 2026 12:03:42 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C029848B3
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 12:03:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u4UvkFCQeCduSB6g06HbNKvI+eT9Pk1Z5mwhbaQtOkj9L/hdSXjpX8n/JTZIwWTqHyjE3j1hLvGU93Alp52QoPwmS61O7CrKRNY9tEXuLPD2QH6NpkNEjMSctVs9DAW2j9LLEBEfOBeteuV3fbxstYAp7jiY0iVfa7aEq9NKExqLGzalldFnqI81K0qphIJOdQVUxmP9F3KmBMgV+zb5t6RD1E/6U9A9Op2V/esTK/A3646ETC7K+1zkVYPyWkDYbjLNGC4HDKt6aFIuOMvHgdKTxHFKmDnXH4oWGPnrCjSNXEd/IzNs3VbNcEPUcx9/PB254o7vuhjPZ3PaolN0Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pSPkxQxagmkWFKUfN1EwiJrC5uwPHoYqiiV7Eqqmxo=;
 b=XIG5pb2Z8hSArC7RC4zNcwboO/cK0ay1BqV5ab8XivdO4kLvnWNhTXJb5LFJMZQad3PDo/kWDRl8AoMCVtpK0ZlVVvCFrKlG/5PkoeacAtkbWLsEXMFLfq97zKUaVygkL/0bGHIcaM7kURVMlh71Ggvcln2e/9+N8fl/lHgx+u5UwyHqw7BPcc8rF9TgjU8fHlzRWMywSaQzGCb+66sIebr4Zzg4Ff9d9Qc4f0zTWH20uTEfaZhGUjr7HFJ4a84DvZ83HI4T2UGGoZQwJX+F3s5osGIDjlpXckVfhPxllRkfaOgTMRbTvtk8pdf5ogxMHzdveb9WfrkKJj7AMiaX7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pSPkxQxagmkWFKUfN1EwiJrC5uwPHoYqiiV7Eqqmxo=;
 b=sK/m0qJkDd2LnlTfK9gJpFYzF74w3yNoihJ7yAwMZw8ttD12e6Op4HU4y5tOrPhu6w08eQnKd1CLFsBdnkI7i8kRc7uzcUQQGYzz26phsQhyPXlwGndmlkrFW5AuPwSmBsLxWUzNdzgSVIfDnM5VD2GBTz36y8lo8P+8q2z7AhxYvp8ZX0ukMSL5x8tsm6ZS0NmMwN/zUGTsQRed1RwRVPVZ0CEdCB6uNOYFK3eJKmJ5JfDVCs9H9x2rc0xhpQgkdbraweq6fLScNHk8iwBZcerGhw/ZZaPRrI8HqMlFJLBA8HeGucOdlOr0pOYKYq0q7euZL1MbEa7+3PW+p1JSDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PR3PR04MB7419.eurprd04.prod.outlook.com (2603:10a6:102:80::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Tue, 2 Jun 2026
 10:03:38 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0071.011; Tue, 2 Jun 2026
 10:03:38 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 02 Jun 2026 19:20:15 +0800
Subject: [PATCH v2 1/5] spi: spi-aspeed-smc: Use dev_read_addr_index_ptr()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-devfdt-spi-v2-1-08374650778a@nxp.com>
References: <20260602-devfdt-spi-v2-0-08374650778a@nxp.com>
In-Reply-To: <20260602-devfdt-spi-v2-0-08374650778a@nxp.com>
To: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>
Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
 Naman Trivedi <naman.trivedimanojbhai@amd.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 "Noah.Shen" <noah.shen@mediatek.com>, 
 Meiker Gao <ot_meiker.gao@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PR3PR04MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e9a033c-bc46-4c10-31f9-08dec08e37b5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|366016|7416014|376014|52116014|38350700014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 88EpBiFUOeOKzXkbZGGC/zdSOYimVww7awvDl5QY2/eQ29dbIS/H3/PPkIg3xcEOi3VE60zoq/7fY88Sm7Q3VyE+kp+ft4j1Pu2dV1ujnPvW+ZLgmvV/OhC+eMCuiOHQmo2+OhPH7RNjUMQjcgOgPU/HLkI0hZxTRgw9z2OPLpT4gWYMplXdfU1O/dbvoWAQj/Knb5zB/MtK1L4JGhMneoAtd3cDUn8YeR2gWg9/WYsBlPToQSA21r4EPBWKSR3rqJe5L5P6VQ1aVl++JhGH1CzbvUhFMWz+47BrxeOzilPQoRQbBuUyBAvDHz4AVv/qZM+1a3Q/rICxW0cyQWPLYqe752055UYp0lmLMdWNAFA10fE0yP6yPIzDgedaWGf908VwuVub4fWJRLC7a6UIhJOzHiiylKKSAIK+l00YqOO1qi5nCpxQrtXfqshtyOgqHerNz9ZXdRcUi9lUtafzD74wK3W+e6uDIRzQukRnnSvpg/KukBPC5W/6U52Fu3PFqxlfqh77vPSs9/aHfuHPiKuZzUkEv8NgZRGFEEqofuwZVCXbvjVwjlszAoaSeE1VWFkVy+8kKMFuEbMymilqHBz/FhTA0WmB6ufrdH6RtZkAmGfsFaD6PymTRneNyJ91y2n9E5R7n3QpSkgx3MXqRTFp98/wL+xjdnwmMdatXqGssbqQmh76yFbuGhynrDDvgekBWlMdN4Xl7541HJfxsKOPzi4pXLWY8LnZ6TUeM3ZlQK/8f9omX12n+oLpwlW2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVdXUWZCUXJCWnIrQVhBQ2VwRWR4TTg2eHE0b0x1NjM2K016VDhPTENySzV3?=
 =?utf-8?B?Vjc0VGl3WkNhYXlwUXBDcnNWaUx4SGZDWHplNThNdk5ZVTZxTGIwSExuU0pz?=
 =?utf-8?B?Vi9Wa2dONFpVWTdwUFFTWFp0NlczQ2FldThSdUdHU2NLcFA4R2VONmtoOXNW?=
 =?utf-8?B?TTNZMHpqWitpa3lLL3RVLy9SU1RwckpwUUtDVTVoWVpoTDlCMEpLRmxiTFdL?=
 =?utf-8?B?OWtzRk1xc3BFQlk5MGMzOXFvamc1ajlQdit3ajBPU2hyODcrNHhqS0VpRkhw?=
 =?utf-8?B?WUw3Mkg5dUo3RDgyN0Vnb0xSQUk5VDlUL3VsRTF6MmJycWdLalBhQnk2b0lx?=
 =?utf-8?B?VmN1Wk9xdC9tanJRcGdQRjdBSFVPd0ExV3pqbDQ5NGorN28yekM0enlkb1Av?=
 =?utf-8?B?dnlqSTlrQjlHMDNHNjlvS1R0WmNucVhCZm1xVC9SNDlKcE9Icys2UHZhRk14?=
 =?utf-8?B?cnhxbzNSalNyaWkyYURHaHNreHRzUzdoMk1MYTc3RGZlbkRzTkhGcU9WdVRR?=
 =?utf-8?B?Vnp0TmxWbkpnMk93YmRuUEpaTFRKd2V6Y3NlaElQODNnTnFrZlAxZzlvS3Vv?=
 =?utf-8?B?a2REK201SXhvRWhaa08wMEtrYjJhYnlmV3ZvcDNpMTV3dkM0bi9xZlYzUlBS?=
 =?utf-8?B?RFBEakV0elRVTkVwOUpWZEhyVENPL0tIemFLN0twS2IyTGsvVXZkZ1BXVzVK?=
 =?utf-8?B?NzFXYlB0bjd2b3Jqb3VDa1Y5RmhVWVlzemhGSXZSbTlIdnp3ckFHQURUYlpi?=
 =?utf-8?B?TE1ROEdWR1dnckwzRG8vWXVHbk03NENIZVdLVXh3N1BCOWgxSWxrYkxtTkhv?=
 =?utf-8?B?clI0UzdRZmNBQWVLaXNmUXJVUXlQSnlVVkJvbDYxbUh1ZjdUYzZLeHM5QWg3?=
 =?utf-8?B?UGNTbEwxOUNwODZETkZRdkI2TVk1RUJTS0NMV0RUM0ZZV0lPa3lCaXE4b012?=
 =?utf-8?B?TE1ETVRaeUlpeGFoOEQ3blJRZW5ERytRblRkWVFhb3pvVEZZNnlVcm5lR2Vp?=
 =?utf-8?B?VVRsd3dCSFgzVDhIeGtMTGtUYzZvNERHRTZhalU2Ym4xYkovUm9HcEI1dHo1?=
 =?utf-8?B?aWlMNTBZcEFwSmVFT3B0WERGNTI3KzNXeEVJc1ZLOFJTb2dJYXhhV2MwdnFz?=
 =?utf-8?B?a0RnbEJNUm1KNFMyNkMzRFpjR3ZVY3p0Y1pUYm9OYnpvSGNLeVZnQkE3NVh6?=
 =?utf-8?B?NmpFckFKOFFuenJhajVQMTFzM25yU2xoaVc1Z2tIb09DRFByd0NDM29jT24v?=
 =?utf-8?B?M0hCVGk3b0w5Y0hRWGFINWpOeEV0VXNVYVgralRKYUtrWmU2clRnbGpJOUxz?=
 =?utf-8?B?OUowWThja3lGdHlrUVpkdmxKVHFzK3NHVVV4RUhXMHJzejV4djAxYlovQXJm?=
 =?utf-8?B?aW53R2hkcDNUaDNBZ0o2QlJ1TWk5K0NEWGhMS1d5Mzc2MnN4VWhVUUkwakY0?=
 =?utf-8?B?Vy9BV3VUS1U1Zms1YUxJTXBlckpsSFF4Q1hqSXkxZk84WStDbEMxTGJRRHNN?=
 =?utf-8?B?dWN3WHcvRWJmQzByMGtrWlpVZDYzd0wwQkdpOG5XNjJmRTZHaGIvdDNGZ1Ez?=
 =?utf-8?B?c1VDem1qSzVzSUM4NDEzRHZmV2pPK2ZyK2pNU0lQeng3aXMvQUpMczJYaUhu?=
 =?utf-8?B?VVg4Z3UvdHVPSFlUZjRhZzVhaXMzdEdLbldtc2FOdE1TbGlvMTNtR2lSYlp4?=
 =?utf-8?B?ajU5cG1JejVFaXdHNXRlYmJRZmt4UjlaTm1WRFgvR29TREJiVGVjcUZkcHFt?=
 =?utf-8?B?ZU12R2YwRkMxVmxBaHNraDU1UzRCSDRSK3B6anlWdkNzbSs1czhVSE03ckRB?=
 =?utf-8?B?VThJMGxZQVN5c21VcFc4Q1QyZFVUN04rTTUwTk1NS2UyYjRVZTQwMm9WcVFY?=
 =?utf-8?B?U1VuZ0kvaXgrUlpuQzdKMm9mSFRKMzdOL2JRS3FPOE1ZYVlhQUdQTUR5eXFM?=
 =?utf-8?B?dDl1aHExdUluZE92NHQ3NHpkeU5jS0kvQlRNR1FXaG5BdjFrQlZ5OGU2T2Ro?=
 =?utf-8?B?M2JYckUrOTlVd2J2eEsxNU9SZ3pQVndET1dXSjJHVDJZUFdHN1cxM2VqRzda?=
 =?utf-8?B?bjhWUDJFTit5Y1ppblBpZE5udWxTdVFqOWdCOTR5ZG1zMW5VdlhFemNhRFdO?=
 =?utf-8?B?aXZrMGNQMm5MNEJBNEdZVnNpdElmSE1zMUY3YkJJR3o2Y1ZuQi9LeFRpanhD?=
 =?utf-8?B?d3YvN1Z0UWw2bHlTeTVyN0t0ZHhuRmRLbUJmV3h6eDJvZ0xHVkhJOVV2MnpZ?=
 =?utf-8?B?NXJacHlTYTdTY2tqSGx5ZHhpNnhxQzhsYldzK0owbFljL0pvZ3dpaDVpajFN?=
 =?utf-8?B?YVlPREZZNWtHRWQzdGJBUEJnVjlGU2RCeXpjajVkWW9yd3E5SGVRUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9a033c-bc46-4c10-31f9-08dec08e37b5
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 10:03:38.6562 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /dgJnuXamTtmC3DhvHJXhebi4tX8BW7Al0nqqQ6sixVkAh1gp1Vw7PB3kCE+YIwaii8mquUlJN4iiaJcxlkOWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7419
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

From: Peng Fan <peng.fan@nxp.com>

Use dev_read_addr_index_ptr() and dev_read_addr_size_index_ptr() which
support both live device tree and flat DT backends, avoiding direct
dependency on devfdt_* helpers.

No functional changes.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/spi/spi-aspeed-smc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index ca29cfd7c88..22668c1aff5 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -1123,13 +1123,13 @@ static int apseed_spi_of_to_plat(struct udevice *bus)
 	int ret;
 	struct clk hclk;
 
-	priv->regs = devfdt_get_addr_index_ptr(bus, 0);
+	priv->regs = dev_read_addr_index_ptr(bus, 0);
 	if (!priv->regs) {
 		dev_err(bus, "wrong ctrl base\n");
 		return -EINVAL;
 	}
 
-	plat->ahb_base = devfdt_get_addr_size_index_ptr(bus, 1, &plat->ahb_sz);
+	plat->ahb_base = dev_read_addr_size_index_ptr(bus, 1, &plat->ahb_sz);
 	if (!plat->ahb_base) {
 		dev_err(bus, "wrong AHB base\n");
 		return -EINVAL;

-- 
2.51.0

