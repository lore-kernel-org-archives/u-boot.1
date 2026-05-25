Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E6A5CD4F54
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 01:53:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B4A28465D;
	Mon, 25 May 2026 03:53:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="oAtrlls0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C80F8469F; Mon, 25 May 2026 03:53:49 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFB7D83DA6
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 03:53:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8BZzd4kggnIgcOEJgzlPkwwJO6wOcG3JKo9JP8FbsPIl/j/cNouYJ3Vr/Jkdyp9bnoBmRag+efKhgF+lZE5MkITmiNTFLBP1XmZ58Qjo22WC7eBa7wDOek/u4Eo/3yn0ibWXe5dbKlrHdVJNn5duGVlj+iMKKWKw6kBS4ARqXI8HqXLQ/90Wys3HGyZsACgXfr3E7FxA8Cb9MgXZjFMvA6bWmfOiI/ItolU0rbHWqcA/xK/45YifF3GznMhEKXkDy/A1BHGJFKABJ8RuCcZAYgH8KuHNipRODNBWUlTBYDZMSNffEE4T9U7eF5Glsg6I+JClivC56Dga++wyug1EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tk2tOKTyJnEiLzLQ6k06DvsRbJNg2hlauK4743c3L94=;
 b=Q2MbJ6hZgoKTUbGUw50aa/+tGKPxIau0WeY9kkUtBGNdO3xb38tWzht56SED4reQ9BnwtGcllw9aFFhSCopEeD2e7h3z3PnOq6ikBQ97xtOBoqp2kW0eYgP9CeKcmwJnnEueXS9oZAn9HUwhBFpwICu3Js3XOypyrCcyz2/KPv55LxbSg8Zr82nzLFZbY8nXGxpkuT2lb8ZUzBVVMNRl+dDMT/RJVpwn+JNqTZearIFcqDMUOatUYLgzoqmDv95BajztQ3y2ualE1yPcZEpMsKXo7CE+AtSRZo/r8h8qIhL5F2bvUbaD9w4TvKZOaFpH1+Y9KNH0F6RwLhhMIbkf8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tk2tOKTyJnEiLzLQ6k06DvsRbJNg2hlauK4743c3L94=;
 b=oAtrlls0fZnilK4Nb6OQoR5VPLZ/sNJkaPaQc6BmVOifGCdM0NZ+W9vGb/6WXtdDiU2Hiry9Npi2LpDSEP/5w/SeyCGAM74l/fb9PqVlk82SrWk3OnzCF9j6jjzB3sZLnK3jesKXhj+MflYvKvJSzncYrm0PrhtelQ8hl/f/yT4vHZrw08RXajkvCBEepowL1yc1B31c6GSDaUkgNHNYi3V6Nr2loJb1Dyyk46tPlUpQpWuK5hgiRMiHGYfd75DLSbrnf75pgGV/L9PWGZyEnHRXhOconymEXXuYFE0lUOUFuLYsBt4F2pXdpqn4AniqF92CThVDwUxuGsYnXYfFig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by VI0PR04MB12323.eurprd04.prod.outlook.com (2603:10a6:800:320::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 01:53:43 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 01:53:43 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 25 May 2026 11:10:18 +0800
Subject: [PATCH 1/5] clk: at91: Use dev_read_addr_ptr()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-devfdt-clk-v1-1-f0dee4083e82@nxp.com>
References: <20260525-devfdt-clk-v1-0-f0dee4083e82@nxp.com>
In-Reply-To: <20260525-devfdt-clk-v1-0-f0dee4083e82@nxp.com>
To: u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, uboot-snps-arc@synopsys.com
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Varshini Rajendran <varshini.rajendran@microchip.com>, 
 Manikandan Muralidharan <manikandan.m@microchip.com>, 
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>, 
 Romain Sioen <romain.sioen@microchip.com>, 
 Ryan Wanner <Ryan.Wanner@microchip.com>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Heiko Schocher <hs@nabladev.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Yao Zi <me@ziyao.cc>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR01CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::8) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|VI0PR04MB12323:EE_
X-MS-Office365-Filtering-Correlation-Id: c5d11e04-5208-42e6-3563-08deba007372
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|52116014|1800799024|7416014|376014|38350700014|11063799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: Wnq+KB0Q6muc4hkz4XO2VU3cWg6ekH9WGXpoy/BPSkLGtzLMX4suRasfPXqbtU8ErH14Fx7dRDaGY08WAhJ2L47KOXnS+D1/dZlNMpzRcCfrATiMS4HGNS0D+HMJxuGAOqjZAuTntsm/HOo3vll0pWbs7lTBGk5wlwd5xmTvFWwifj/tSSjFl0dBE/pa4+N/Z7hGIffbw0zikJAYq63IRL2Z/p1pgyUlWsjoFuKvRHeUojXiPCiLB7IEXClDv/LNUhETVWDrs8XC7knXEzSNTL/Mhjng8C95DrCQvPjwyibKs8fgZxl0Bxc2ZoDeG+RwBrUND1/8Y3LpUN2XXAAn2wwRYP6ohmQRGGIdWGpO5cc2VAzIl0x8iHl8abIgclGJIwBPSZYj+6XRECcP6trZ7RHVFE5T9kC9DhMCxrSk1m4+QwV762LxHbaj5P+ruxSZLLGhP3TFWBLBYe5284wcUZW4DlvG8WqE39ua1hHJAJZGVVoE8QcwwdbvDIlXgX/AT9meRIjZlfYnH44+dLF371DCx9xu/76wkbk6SHDUcPq2J8M18/9QjSVUFG0HOYf/UdlIXh3JtsvaNLstnnK4DBfC4IfU4AFZb7gUdcoyNZiW4tB2UHegDt7stF192vCFu24Qz7YXDkV+/IBBljBpi6nxvIDcB2NbWbJHj9ZGr116zOvQcz4ZZfLi4prJ1NmKY5utTS0WdrqNm6r3WLFQVSEbwmELSzrwgUpksKwwsWYCnrLX4viANkIon51rYOAH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(52116014)(1800799024)(7416014)(376014)(38350700014)(11063799006)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ak4yMlptR050M3RyWXVRaFNMMCtsRkxRUkRJay80U0MyY2V4bFdxUHg2TUNN?=
 =?utf-8?B?TzlvY29qMS9ldDhmZjJYeXdPNGVMNWwvZTkxbEhrT2FreGRhd0RMRFV2akVa?=
 =?utf-8?B?R1RodUJFbm9KckhGWkNDa1FLY0hMZ2x6eWhNV2IzYkZjQ1lQOHV4N2NnbFBH?=
 =?utf-8?B?d01Kc0VFRzRHSTdOKzJSMm1pRlZNTWhzM1QxUHZaM2NOZVprLzVvY0J6R2JP?=
 =?utf-8?B?RFpZeUVMejdydUdBUVFDcXR6UllzbXkwelVOd2E2Rmtsdk9vMFgrYUU1ZGd0?=
 =?utf-8?B?MHAvM3Q2VThjZWdqWFpvRTA4U09xUFV0R3RnakU4V2x6cXNWSmdDTG0vRmVo?=
 =?utf-8?B?VGduWkV3ZUJEaWdPRzZud2ZxVm9waVBuZzRabUduZERWYVRvTmJpMkNkNXhi?=
 =?utf-8?B?a1ZrWWZ4K0xxOUZhL3ZBNzdwYkRHUUpiTkt4VGJvQlV4VktBdkhmT0YrR2oy?=
 =?utf-8?B?bEcvV1hjVW1sVTZXT0RreS9hODZEd0x2WmxzVzNGWE9rWE9iQWt5c1VEUnc2?=
 =?utf-8?B?MGtCSFkvRmg1NjFLTjlQSUMvZzVLUm1rL3BHYXIzVVBpdk0wbnB5OXg0VmhY?=
 =?utf-8?B?bFhibDBsRmdNZ0hRRHhkT0c5Z0wrblR6T0o4WVlJZzdwdjAwYUFqMzB4ZzBZ?=
 =?utf-8?B?STNvL09wcVc0MEpNNlo1WkdhME1CSzBkUDBMbHFVcXFzcTdNcHpCbG5XK1hI?=
 =?utf-8?B?cVE2Vm9NVkxLUkM1YUl2VE56Qm9mNEFuS2U2K1FYUm1ETk1MZGVFVDM1Wnhz?=
 =?utf-8?B?eUJOdVFjZUdON2xaRVRtekVyM29icjlkYVdtTG43aUplNHdFbnFJazVxRnJt?=
 =?utf-8?B?c21wbTYzSmNjQ2twZVFscWlrU0ZHMk5rUXQ1QlpwbWlKYTl5UUJhNnQ2dldi?=
 =?utf-8?B?MFdUeGl3MFhNbDhzakFUcnJqbWNFWGNpOFZrSDNXQ1l5UHd1VzczSXJ5bHhI?=
 =?utf-8?B?Mk5lK0xWTk95TmpVRTZ4UUVhZ0VNOWZjZ09mTHBrc3ErZlMrb01aRUVBWFh1?=
 =?utf-8?B?K1doeVgxWW5wYjIyWFQzREJDQUh5K3p1RExIYXVrdVJVT2xKOFUzQWQrb2xt?=
 =?utf-8?B?V0NQblplT1B5TzhYVXEvREMvTWRyS0c4VWJQOVFoUzd2SXplYkNoOVdkbGxi?=
 =?utf-8?B?SHMzTFZFbGJIcFZDTVBaWVYxQnQ1NkE4YTROSTE0MVlwNE1pd0lSUFhjZzNT?=
 =?utf-8?B?RWtiUHFjN0tWbVFLTUlRRnhjODZOL1dsTkV2SDhYVWd6VXVKajFIeVN3QlRJ?=
 =?utf-8?B?N2pLNStuQXlmYUJRS2pJWHIyT1prTkZMYnRKcTJ5ZEJuZmNWRkNpZnhkQ1RG?=
 =?utf-8?B?ZThHVXI4dlJyemYrcnBpM2pURkVGaDlYU0F3cXN5enZ3dEM5MzNqTXVaMm1v?=
 =?utf-8?B?aXB3dEc3clpqYUErU25DWDBhV1JVVVVoazUwc2hHUVlBKy9ldkJWZUl0UHpX?=
 =?utf-8?B?OGx3KzRLMllOVy83em5nai8vRXhmS0IyZ29xV1FoWE9heHBKQ1d4NXJiQlY4?=
 =?utf-8?B?NDJzUm9TSHJNcklESnNHangrQTZDYWx5VlQ3ZEExZVg4cW4waTRpSUwzcTZP?=
 =?utf-8?B?WVN1amVvekxRdnNiVHZBRk1BNE1ubkh5Ukl6ak1ZNmpTaThyT3FXeGx6di9D?=
 =?utf-8?B?ZStlUmxIRmlqN1QxcytRUkEzWEdENXVDbENwWUhlTncvYmhKRUJPTUJFWVJ0?=
 =?utf-8?B?bEdmSzQ3WVdKVnVtaGVYOGxrZ1FYdytqcndWbWRMTzIzcEtKU2pMVHNWQ2I5?=
 =?utf-8?B?VzdLV010aldHZ1g0V3ZHaTd4VnlMazJGb3E4RU1nZ3k3aW9oeEdRNDdLK1FL?=
 =?utf-8?B?WXNsTmtQK0tYKzVuOHZZVTc2OC9vUWEyVzdKZlN5QXZUMGpJRXNSZEdzUXlT?=
 =?utf-8?B?RCs1UlZkMlhHTkpzdVNTVW85YTZCZVo5SHYvUXBnbUU2WWwxU0tFME02ZHVi?=
 =?utf-8?B?UE9pcE9LZUtBT25JS3RsdFZDNjVVUUJVK0hVWVZBSFVDSEFnWEZqTWVwalJC?=
 =?utf-8?B?VWF6Qnh2TTVmOG0wL2VISzZ0QXJSVkw0YSt1a3pSb1hTQU5Ib1V0dlRRT0ZM?=
 =?utf-8?B?OGVEWU5INC8rY09TRmYvM0dId1FwbXFHN3RRekdyckU4T21yemFkbDlyVjBo?=
 =?utf-8?B?c3IwQysrM3pOWmVaL1ovY0hONGpNdmNXY0VUb0c2eStYdngreWNJaTZlL2pM?=
 =?utf-8?B?OGRqUUtiRVJUU0hST0Y3UjY5SWQ1QW1hWGpORVpybDRSTkNZdUVqRGVBdDh2?=
 =?utf-8?B?RHpFMHdkM3MyYit0bUNsQ1lVZlFtcjlaVzdCcWMwRWwxSFJkN3FqUFpuejgy?=
 =?utf-8?B?VHA4cjdqUUsyRjFPbllERlg1cXdvVnRONkhnOVBiNUt0U0J4TnM3QT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d11e04-5208-42e6-3563-08deba007372
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 01:53:43.3413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VLgTBwA7ouM2oJozeM5xZgfcaO04QPBZIqulVEi3ilF5m5a05agLWZGG0bkMuD+Isj8UldS6G2iPi9oO99GhWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12323
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

Replace devfdt_get_addr_ptr() with dev_read_addr_ptr() when retrieving the
register base address.

dev_read_addr_ptr() supports both live device tree and flat DT backends,
avoiding direct dependency on devfdt_* helpers.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/at91/sam9x60.c  | 2 +-
 drivers/clk/at91/sam9x7.c   | 2 +-
 drivers/clk/at91/sama7d65.c | 6 +++---
 drivers/clk/at91/sama7g5.c  | 6 +++---
 drivers/clk/at91/sckc.c     | 5 ++++-
 5 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index 2251e2846fa..0d0e39db57e 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -426,7 +426,7 @@ static const struct pmc_clk_setup sam9x60_clk_setup[] = {
 
 static int sam9x60_clk_probe(struct udevice *dev)
 {
-	void __iomem *base = (void *)devfdt_get_addr_ptr(dev);
+	void __iomem *base = dev_read_addr_ptr(dev);
 	unsigned int *clkmuxallocs[64], *muxallocs[64];
 	const char *p[10];
 	unsigned int cm[10], m[10], *tmpclkmux, *tmpmux;
diff --git a/drivers/clk/at91/sam9x7.c b/drivers/clk/at91/sam9x7.c
index 9ea253e6ff8..93f899b6617 100644
--- a/drivers/clk/at91/sam9x7.c
+++ b/drivers/clk/at91/sam9x7.c
@@ -817,7 +817,7 @@ static const struct {
 
 static int sam9x7_clk_probe(struct udevice *dev)
 {
-	void __iomem *base = (void *)devfdt_get_addr_ptr(dev);
+	void __iomem *base = dev_read_addr_ptr(dev);
 	unsigned int *clkmuxallocs[64], *muxallocs[64];
 	const char *p[10];
 	unsigned int cm[10], m[10], *tmpclkmux, *tmpmux;
diff --git a/drivers/clk/at91/sama7d65.c b/drivers/clk/at91/sama7d65.c
index 9f0b394543b..0c17a8cf67b 100644
--- a/drivers/clk/at91/sama7d65.c
+++ b/drivers/clk/at91/sama7d65.c
@@ -1176,7 +1176,7 @@ static const struct pmc_clk_setup sama7d65_clk_setup[] = {
 
 static int sama7d65_clk_probe(struct udevice *dev)
 {
-	void __iomem *base = (void *)devfdt_get_addr(dev);
+	void __iomem *base = dev_read_addr_ptr(dev);
 	unsigned int *clkmuxallocs[SAMA7D65_MAX_MUX_ALLOCS];
 	unsigned int *muxallocs[SAMA7D65_MAX_MUX_ALLOCS];
 	const char *p[12];
@@ -1185,8 +1185,8 @@ static int sama7d65_clk_probe(struct udevice *dev)
 	bool main_osc_bypass;
 	int ret, muxallocindex = 0, clkmuxallocindex = 0, i, j;
 
-	if (IS_ERR(base))
-		return PTR_ERR(base);
+	if (!base)
+		return -EINVAL;
 
 	memset(muxallocs,    0, ARRAY_SIZE(muxallocs));
 	memset(clkmuxallocs, 0, ARRAY_SIZE(clkmuxallocs));
diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index f24d251857f..c436038aed2 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -1109,7 +1109,7 @@ static const struct pmc_clk_setup sama7g5_clk_setup[] = {
 
 static int sama7g5_clk_probe(struct udevice *dev)
 {
-	void __iomem *base = devfdt_get_addr_ptr(dev);
+	void __iomem *base = dev_read_addr_ptr(dev);
 	unsigned int *clkmuxallocs[SAMA7G5_MAX_MUX_ALLOCS];
 	unsigned int *muxallocs[SAMA7G5_MAX_MUX_ALLOCS];
 	const char *p[10];
@@ -1118,8 +1118,8 @@ static int sama7g5_clk_probe(struct udevice *dev)
 	bool main_osc_bypass;
 	int ret, muxallocindex = 0, clkmuxallocindex = 0, i, j;
 
-	if (IS_ERR(base))
-		return PTR_ERR(base);
+	if (!base)
+		return -EINVAL;
 
 	memset(muxallocs,    0, sizeof(muxallocs));
 	memset(clkmuxallocs, 0, sizeof(clkmuxallocs));
diff --git a/drivers/clk/at91/sckc.c b/drivers/clk/at91/sckc.c
index dcaffd360fd..410bc088248 100644
--- a/drivers/clk/at91/sckc.c
+++ b/drivers/clk/at91/sckc.c
@@ -124,12 +124,15 @@ U_BOOT_DRIVER(at91_sam9x60_td_slck) = {
 static int at91_sam9x60_sckc_probe(struct udevice *dev)
 {
 	struct sam9x60_sckc *sckc = dev_get_priv(dev);
-	void __iomem *base = devfdt_get_addr_ptr(dev);
+	void __iomem *base = dev_read_addr_ptr(dev);
 	const char *slow_rc_osc, *slow_osc;
 	const char *parents[2];
 	struct clk *clk, c;
 	int ret;
 
+	if (!base)
+		return -EINVAL;
+
 	ret = clk_get_by_index(dev, 0, &c);
 	if (ret)
 		return ret;

-- 
2.51.0

