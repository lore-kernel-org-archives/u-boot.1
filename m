Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CC7103E300
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 02:17:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AB8A83F8A;
	Thu, 12 Mar 2026 03:17:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qU1Y2Xp6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A04783FBC; Thu, 12 Mar 2026 03:17:36 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFD8583F75
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 03:17:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQl2UIBcfDd+qE8GjgD6ukNZ2bVchcV+Y8nNXZCVB3faPfgeB35HPWxWFJUc23dDsuC4hqeWN0csOeBUOrv2kiV64LlbLTDQOCnl+u5DVZ5xPMZaSkJe6nLfIwlDPMtoKTqrV71X30i+bJc133kEpfGhuOsa5mG1pLmCftv/mAGaCyMnA5crKjIEXVjT/lmMNUcMyMadeTJG4lByaDk/ozwPQ40jpI2N1QyOMe7PQanMOTWCIUEOEDTU4m5bf3xf6sBXo3R1oy+pDuaD94C1U4M+VaP+97RMqdXEPPQLurZrgH4hog/d3Fa0cH5w/cWhhmrorMBd4dtns1mbRFw/ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXmSt+JpPnmdKdl/CP3wEg1jJlpboQHg+sgJUZmrx4Q=;
 b=PZ///TnLJRjBlHdKJSaeoz1A0THiEEnCBi5EBk61nR6s9XmUT7WF8+TEHMPRmSJjtgGukMlxPkBqRS1z/9TYGXii2mtfWG4xET08bMPKzJL12PvUyckdFT1mp30D8ISyKeVr7BqUowTVHr1KhxRCPltIr5aTYdPiJwT+B4IBtcEvFFkTAbwohJ0ygDLA6dkqAYU03Uuymkr/T5onCkGBSgOaYYRHwUYYqI89zLoUTQQIYUSspAqTcDyRNxgzfa6ywKLHunO/8zmZ4A1t8+sJznsMsasQELSti+XH+T4sGMoCMGAGln1gl7sRAqNwMmZyRwMAu7WLpXotDWK1laB7OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXmSt+JpPnmdKdl/CP3wEg1jJlpboQHg+sgJUZmrx4Q=;
 b=qU1Y2Xp6E7/pNeoZtdDTfJGb56N6hAZbPay4vA72xzvehzfq6XxUje0B/OOvw8fNglj2HiZWdeBB6RlR3Qnd/QN7NOZeqkB3BlFZFRwvAz5wMkPEgAsbwtbwMAmRwqSBu39zGHmHW3EF5mREPLxZBoYAw9nRv7zt4yBfGZC6XkDYTZqrflVyAz62kb2+yAqUArJlpoyUyk0QPDQhKyjMm72VKXbtTPYtFNDLGkqQowFJWcv4yaOVevRLsW0cbhhW42JAMX9zIs/TL2m1lfeMWpg9DXRsbGXkzFla8T45WIuwFG6HO6jMwo3RqqNxs+c8xXbZ1nCujcM6VgV6PzTlsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21)
 by PA4PR04MB9246.eurprd04.prod.outlook.com (2603:10a6:102:2a1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Thu, 12 Mar
 2026 02:17:30 +0000
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::8735:53a0:b36f:f559]) by DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::8735:53a0:b36f:f559%4]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 02:17:29 +0000
From: alice.guo@oss.nxp.com
Subject: [PATCH v4 0/4] Enable XSPI1 on i.MX943 EVK board
Date: Thu, 12 Mar 2026 08:57:21 +0800
Message-Id: <20260312-xspi-v1-0-375b8c444dbf@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHEPsmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY0Mj3YrigkzdxCTjpKREM8vU5BRjJaDSgqLUtMwKsDHRSmUmSrG1tQC
 wekSIWgAAAA==
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To DU0PR04MB9636.eurprd04.prod.outlook.com
 (2603:10a6:10:320::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9636:EE_|PA4PR04MB9246:EE_
X-MS-Office365-Filtering-Correlation-Id: e161fa63-d471-4eca-07b2-08de7fdd82e6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|1800799024|52116014|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 17gzOisPUX0D4vuOvhaYVEN1tbYFFSHgpywZw71qscPKmFOXOjFKN4pNVMM0WZwIrd/TsyqZNfo4Ruhf20NoTGx+5n6CsZ1pkpTH47ItZLJZA82DoqRaknEI1a8hMiLXdrnlhmoKKzlvb5nBy+7W+NNbKOMU8ez7qiaZinkVNkQnqnSIH75euNKRHsPvD6BmZoAfTctAY5B/PoPy/J9xZaCw67XaP/rRT/YP3U3FBlYns/thgOzOhlon7KUHMjnaKG6ATd8AUiD/2Govrzap8o0sK39lPxIoKcNhJqaBu4QG9WhbJWb21lElwjyOT/s3vbe1nx5p4SBEvs1tFTpmwu+wAg2xkOj/EjmVngxkj2Uwem/h4qoOcPubOf7AHRH5uNkBY3B7qmDbiBObp6NT/dVyCyQGa9B9UFhQd8uHf2DDkKpYpHtsjaZLz9L9I13L7SdXaV9RowSVtyDUktn+JYQlDUF0WFlEijMZTOTMNySlkOwmi6Xg+XL9Cqr/7gXfA7hhtFFjOSknxF1xXsq0v8xGblC+++alKYTwJ4UV6HnczzEJN6Eod91ptipEcnZh4NW7IN9EmhqpcjcKTy3pUKtqVur4SJ0MqqyERVt5J3PcCcnCGx/wIj9T7lm99lK/Awg66vixrbGDVRB0Gz+Giyy9KDeO7dU2azN7rlM9VP88vKNwHZZ3ArJ2OGB73YLJCUqFicL4TBa52Wmuzu4edMGXHynqSjjh0GaO9fFWM4jvoa9CUOjAFMwYtOo0Z86kdxh5wjCW+tZU7iDHU/1a3E0z/88bp+/kuwglWikKSg8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9636.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(52116014)(38350700014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cW5xNW5zazhaWmwySHlvUVFOYUUyWmdpK0s1cDFXaXBNVDJITld2d0NGU3c5?=
 =?utf-8?B?M3ZtUXkySXZxdUt4U25FMFZOYTR5c21YTnNEMkM0QXN2OSs5Wlh3WFJxMXFl?=
 =?utf-8?B?STh1YVVlQmVHM3NkMmNxd2xGNk9iM1RIcWwxK2RvUk1lNXNveEZJd0tZZkJC?=
 =?utf-8?B?SXhhK0hVSnl4WlBxTnRVZ2d0bERFbUZ1RWxqeGRqVkc3bXVPb3pmOW1tWjV4?=
 =?utf-8?B?cmN5b1dqWmg2RkZEQ2R6V3E3NEF2NnQzNXpqeko0bWk1NiswTVdiUlBDLzFG?=
 =?utf-8?B?eGFYSWdmY3ZNeDV2bml1MmxqWm1QWEp4YWpYMHRldWdJU3RleElFZWxKNzcz?=
 =?utf-8?B?RmYrcm5vQzdzYithNDNLWGVtaVlvOHIySjFKeE8vK2V6cXVZc29jRXlEVHUy?=
 =?utf-8?B?MVo0WnJBcERkVXdBS2FFeWFFM09lelI4ckxwOUJMM2Y4aVJSTm9HakFoQmRM?=
 =?utf-8?B?cktLa3p5NjlpUmY3REJ0d1I2V3ZKQ3c4c1hyM1pINmNHY0hKcnkxZEY0V2dy?=
 =?utf-8?B?Y2g2TWYzditlTEM5MldOdFBLMWVXQnNQSkhONzVNUHNWakRzUUpRaHZTeGhn?=
 =?utf-8?B?L3BFTWRJYi9hdW5yUE5KU01zZmhYZ1lDcVhxN1JEWU5OTDhhMTV3UlJ4b3J4?=
 =?utf-8?B?K1hsLzd0UlJ2OGxhQ05sVVllbnFITmxiNHVrZXl4TWx2cEZlZWtXaWxIcnl0?=
 =?utf-8?B?SlpyZlRlT01RYjRhZ2hpaVZQTlRTT0tPOU5uclA0aUQ5NHlpYUxacjhubURz?=
 =?utf-8?B?Q2RpSGwzYW1oL1ppbUZSU0E3WFNaT3h1N0xoVnp5Z3BrdEV1ZVlBOWpTMkpL?=
 =?utf-8?B?VEVHVitwYjJVMG1BVEMxN0Vnbll1dWhhNGFXZWFWNy9nZUVPSDlzbUlCR3VH?=
 =?utf-8?B?WnRwZHdCSEJMZDBiQ1lSNUlZRWxpeGxjTmpDbFBpQUQ5Y1d5M1VBQlBMeUJG?=
 =?utf-8?B?TkhycnkyY3I5YnRQWmduUGdhTFNvaWN2VysxT3ZCRDNEY3B3WmN5TFRjdWFk?=
 =?utf-8?B?ODFGTDR5Q21sOGVtZml6NnQ3bmljcDhxSkxUb2VXMUdNYnZDMmxYMkFzZzdQ?=
 =?utf-8?B?ejNra3dkMjc3VkhMLzJHMmFic3VULy9Td1YwYjVSS1RoS2hXbGhGeUJ0SGVT?=
 =?utf-8?B?VVh0TGxtTVRVN0RWMFI5Q2N3RERiSzROSlBPVXhMUXI4ZVVTUUo2SmE2V0JB?=
 =?utf-8?B?YjczVlpYdEplck9sazkyS1Mxd3lScVFrZll1M3ZTUm5EdWh5T29UNzZxNllI?=
 =?utf-8?B?WGxZbStYRzFNSG1Nb3o4Zm85bnU3Tm5yOXltZVhmSVZ5RE1KcTVFWldDLzBn?=
 =?utf-8?B?eFZwRGo1RkhwNTM5T1Rmd2RIakxUZXZpRFMyL1d3eGlnaU9yTXNFS1V2ZGxh?=
 =?utf-8?B?WDFKdE96V0RaNnpQSGRyZ1pURkZsZk9nU2U0cUZIbHRzc3VvdFF1ODd2WitP?=
 =?utf-8?B?UWhXeFNQejh4VEg2SEwrc3JHMUIrTTNyOUoybXk0cjVRZllTV1puWUs1dWpW?=
 =?utf-8?B?dTlyVVU2aXoyN0pVSFBYWnE1c2ZXb1V6RDhyQXVpVk95OE1tNHBnc1JxUlhp?=
 =?utf-8?B?SmlXTGtpOFA3aTJadnpKR0JMdGhTbzJRL3I4MFVhTlZkWndXVzRuSFhhTndr?=
 =?utf-8?B?eXgxbFdBaExVRncvNEZ2TGZhZkZ2bWZIZ2lrY2JBem40bllydjN5NmNzRVds?=
 =?utf-8?B?VmxKUk8vUThOTm82RW5mWlRML0NVMG4vREFqc3ovTUdUNmNXSXN1cWFDSlla?=
 =?utf-8?B?NE16UzlsYU1vSUQ4WExtQnB6Rk8zY3o1QjBpUHRGWExZVUo2eWhBbjVXUVdM?=
 =?utf-8?B?ajliaTY5a1o1Z3VrdHZCOG5ZblZFVzNuUXlUclBwOHZtTHRsUmtzWmhWbHQ5?=
 =?utf-8?B?Zzg0R2RKZkNKWTdBVjRXMCtYUGFPN1F6cHBBUjdhcFE5UnhjeEZ1NjB3UU5M?=
 =?utf-8?B?a210WklNNDNxV2xTQWFvQXdWTlc4M3Y5Q1h2NFB0cjVQdDJNREZueWpZbXhw?=
 =?utf-8?B?RXBES2JLQTN1YWlBeUxEbjh1VXc3TzhsYVBqaEVJalVseFFCUHlSOUZvS3lO?=
 =?utf-8?B?clRCTkRZK1NJc1hsWmFxRVUzaTBoRFhJRkQxOVVJTm80QXpVY2JxbXhjdTgv?=
 =?utf-8?B?NE5rVnN6aDBxQTRMbkU1UXlDc3VOV0VpbktPQmFrRE12SHVRYkxXWUdCMjhy?=
 =?utf-8?B?bk1Kdlg5OTR0WTJCVVlwTmJVVDBYZktBaFBNdEM0MEdXaTdITnoxSkpGVHV4?=
 =?utf-8?B?a1hPbXAxYXVSNDFydWxrN3llU0E5cVcrNWZvZkQyTTExNGhsTzh0RE1lR0dO?=
 =?utf-8?B?ZWtER09QUjgzZVlOaFN1eVVSenJBN2pTRVZoUk5Ja1BxVXJsS2hqdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e161fa63-d471-4eca-07b2-08de7fdd82e6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9636.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 02:17:29.6305 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dfl5uxKs3PiwOQDtuly53gzBcFiZyztg0WqiLckgYIYR0iZEXlaJVwxwN6Td0PQlssgX565dw3znSHy//B2lGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9246
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

Changes for v1:
- Add support for XSPI1 on i.MX943 EVK board
 
Changes for v2:
- Remove the big-endian related code
- Change compatible to "nxp,imx94-xspi"

Changes for v3:
- Add "depends on ARCH_IMX9" to the NXP_XSPI Kconfig entry to prevent
  this driver from being enabled on unsupported platforms like sandbox

Changes for v4:
- Remove unused struct nxp_xspi *x in xspi_writel() and xspi_readl()
- Rename boolean parameter 'c' to 'wait_mask_set' in xspi_readl_poll_tout()
- Return clk_enable(&x->clk) directly in nxp_xspi_clk_prep_enable()
- Replace WARN_ON with proper error handling
- Change xspi_update_lut() to accept the number of LUT entries directly
  instead of calculating it from num_of_seq
- Align macro definitions with Tab
- Replace 0x10000 with SZ_64K
- Remove () from XSPI_LUT_KEY_VAL

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (2):
      spi: nxp_xspi: Add new driver for NXP XSPI controller
      imx943_evk: Enable XSPI1

Ye Li (2):
      misc: ele_api: Add support for XSPI SET GMID command
      imx94_evk: Get ownership of XSPI control registers protected by GMID in SPL

 MAINTAINERS                             |   1 +
 arch/arm/dts/imx943-evk-u-boot.dtsi     |  34 ++
 arch/arm/dts/imx943-u-boot.dtsi         |  16 +
 arch/arm/include/asm/mach-imx/ele_api.h |   2 +
 board/nxp/imx94_evk/spl.c               |  12 +
 configs/imx943_evk_defconfig            |   9 +
 drivers/misc/imx_ele/ele_api.c          |  28 +
 drivers/spi/Kconfig                     |   8 +
 drivers/spi/Makefile                    |   1 +
 drivers/spi/nxp_xspi.c                  | 914 ++++++++++++++++++++++++++++++++
 drivers/spi/nxp_xspi.h                  | 703 ++++++++++++++++++++++++
 11 files changed, 1728 insertions(+)
---
base-commit: ba7bf918dafcd093ad733b07ba490baeb20cf5da
change-id: 20260312-xspi-ab3bba69ecd3

Best regards,
-- 
Alice Guo <alice.guo@nxp.com>

