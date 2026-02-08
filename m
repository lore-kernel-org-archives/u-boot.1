Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EC6EF06E3
	for <u-boot@archiver.kernel.org>; Sun,  8 Feb 2026 13:20:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B730D83AA7;
	Sun,  8 Feb 2026 14:20:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cQsVx1Ys";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0E3B83BDD; Sun,  8 Feb 2026 14:20:00 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BA308341A
 for <u-boot@lists.denx.de>; Sun,  8 Feb 2026 14:19:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRYc0j+O/ueob8wk/pfemWY4VVeYSAbGV/2kERVgeSVuGKZRSUK+fyaFJQbP5lsorU1Y5Lr2IXXERkAiFA0FLwwpDdHQm6qdDcAFtX6bzqfQskcAC3203+zag9kG0hyMiFVPdcubIU37jvlLmAmHmNIUwOSC/ymHqCW19ifEVi6rnsRf/QKwxpQ7ZXB6C1nLgj4W9CijLGMhokC53jN7J4Txgo8aRhiAEjaWHh8TXIvsvRGw3yktumthLobb9HdQP7RVzKopSugnn2cMoClOJVot82QP1uG8kKTNnLap+rHXVqrLMDOjcIwUDHiraMfWZIikk/jA2UK5FOyeyWivlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlzuqTmrS50NLtIboKTNDhKt89pU0vVAtzwP4YzRgys=;
 b=vJIBlK31haA03AqqeH5zl5l8y/12U3soNbGcR+LFMFkSqetw8phFcXMG2Rk0LMa5jnNxNqnlhhUD9N4wqTdFObs7535duqEaABsTGVfVm4Ey9FMQP/zQtPrSxygB9Pb6j55KZSqT6WNaHswhr7PL13XGqXFVP6DcPciGh/7zvXwnJFdn75pHc+hRJfAYKkS9o2EL072j1DTLp/wBkJNWVF5HpcgWtI2SJbgxap8lHoXeGkmjelKqOCWZGeKoik4+7/j0exV2Y78+xKbKH/Jnve3K0f0ZyV0AgQkt0Cwa3Y+Nv6g6IaumjYcEQfLP3MlnypDS3O3K7YH/ZLwOs/i0ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlzuqTmrS50NLtIboKTNDhKt89pU0vVAtzwP4YzRgys=;
 b=cQsVx1Yshh93AVZ/t+QcR+/3o7XF47VUi9sUIU/OG6feVJYUCY8Iun/TC5CmrcH6USixtoFf9NM/rZJmJFlHb5T3HSTdUVy/Em8BahbPEsElcCEy//Gu6hNDzmaVNl/N8s5XFCZ9dLuHnhtcKfQcBF3oW1k2BNzaksrbOTfU2yr7AIuXpZ3D4UXKM19CSb6y7ZBol+mxKI+dHL3cKBoePpYoJ8d9dw+cb8kEteO/aORcUfpYU7+5Rtizybz+JOhSVpehkHaNvis3pY3FXW02qpJGxtXiZ61R0H27GpUxwvIKvHxsO+N7ev/yoL8/pcuFaStalbCnFDRl30i/1K4Gag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9813.eurprd04.prod.outlook.com (2603:10a6:102:391::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 13:19:55 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Sun, 8 Feb 2026
 13:19:55 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/3] nxp: imx8mm/p_evk: Drop init_uart_clk
Date: Sun, 08 Feb 2026 22:34:39 +0800
Message-Id: <20260208-imx8m-uart-spl-v1-0-c3e81cadd160@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP+eiGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIwML3czcCotc3dLEohLd4oIc3RTjpORUs7QUS7OkRCWgpoKi1LTMCrC
 B0bG1tQBiMnRuYAAAAA==
X-Change-ID: 20260208-imx8m-uart-spl-d3bce6fd96ba
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9813:EE_
X-MS-Office365-Filtering-Correlation-Id: a917b596-1f5e-4704-e159-08de6714bfd9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|19092799006|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZEVTTlVISGlwMTFxSjNpcVhrWktoczFiVndtK1N4aFpVenk0YzlqVW9jNGVv?=
 =?utf-8?B?aTVSa1QwQk1hdFMzdUJhY1pXdW44b2xqZ0Flc25yM01yb0tweGd6Z1BPSmNY?=
 =?utf-8?B?QWo5Kzk0S1VORzYzbTVDVWx0Uk9yc092TTRiblpVcDRnRkFEbUQ4eGxyTEc4?=
 =?utf-8?B?amFiWHNLN0I2NXA2NzQrWE0ySENJcmhObmxYUGc3NTQvVGVkUHp1ZGQ1clQ0?=
 =?utf-8?B?MDA0K1VmNnZzWjdhUkVPaVVQdWFyVm1sZVZudUJ6eVJ3em1wcUw4a3BDd1VT?=
 =?utf-8?B?VUVQblo0SXpQaUtscDc5cGlaZFVWaTRqcDJaQ09EQmpLYTkrM3dhdmpkMVJ4?=
 =?utf-8?B?Ui84NnBFaHl5OVc1bzRxbVdQK01zZTlPRmtsNm9UQWNYWXRXcmtha1JkR1Yz?=
 =?utf-8?B?TS9UWW42QjFxcHVNUk5rVGtUWFlBN0NNbEtLTWdPdVcwejhtcFg0VEZ5eDZ0?=
 =?utf-8?B?T1ZLSlMxdVY1dWN3ZG1UeXlvM1YxWXlhTitYL1lHS3V2c3o5Vk51SitNaWRG?=
 =?utf-8?B?Z1VDQ0VFZTE1MFdhRGhncWkxTGcwd0gzUlkyWmgvYnJ2bG5ja05xZ2Zwa205?=
 =?utf-8?B?aWJ4Z09udEpSTVBsOVNoNytiaFhTbC9MZHR0ZlM5NnorMXZVRHNLcE1hTFF4?=
 =?utf-8?B?ZnZSTTZjd0IwazJqbmlIRzVOVmNwWHVEWWhUV2o5c3lPejdackkwZW9KVXpF?=
 =?utf-8?B?a2MyR2FOQVIvdTFpWHJQQXNlVHovbmVxMGFIalJ4dVJWbFhRY01scjRmcU9n?=
 =?utf-8?B?bkNWTFIrMFk1YU81S2h4UjZZS1ZBdXluWWdPOHNZZnY4cVpFQjJnazZ1WUgy?=
 =?utf-8?B?OEZBejVLSUZ0bFVXNjZOU1RGZnRJUkgzZUthY2hVZVptYUswUUs2NEtaMlcw?=
 =?utf-8?B?MXhIMFJiV1hsdVBUQStIbFRuS2xYNEszNk4rYzJqWVZuc3lDdDkwR29KRU1v?=
 =?utf-8?B?UWhUMnJMUmJRT3VQbzMrRUNoM1N0YitIeFQvbzN1SklRMVFMYXFIZFF5UFRF?=
 =?utf-8?B?UUZkMUVoWTVSQzBQS3hQU1hKOUdjNmxPYURCaDFrcjRuNVpVS2NLd3BUcVVj?=
 =?utf-8?B?dHN1enZ0enZ3RjZkdGhsUm9FYlc0WGN1T0tHd1NDbk5rVHhBTWVJZ3RodlBs?=
 =?utf-8?B?OHRKUHliZGVJZ2dGVmpaZ0kzRWVtS1E4UGJYWnEvSXVudFNOcjdxU0hWRndt?=
 =?utf-8?B?d09Pc0d4bnd6bWJhNHNLQkhEQ1MyOEdTaTljVDMzR1VkVWNINXJub0wxamRX?=
 =?utf-8?B?bUp2c1lTeFRzNjcrVnNIKzNjSSttSzR5QWhJNDYwbXBpb1NWbGZtKzNNTDRa?=
 =?utf-8?B?NWt4cGZwWmx4ZkNSM3FoVmQ0MUVVNUlFaUs4c012OVFXMTNhc25MMThWc2pX?=
 =?utf-8?B?WXdib2Y1RVJ5NytHazRsSU9adE42M20yb1ZuSnRuRjd6SmpWUjcweCtnZjdk?=
 =?utf-8?B?UlAvRjkyTmdmSTVydlNpMTUyZXhKRWc1dzhkcGYxbjR2UkFjMDh6V0Q5OGtw?=
 =?utf-8?B?Z3NjRmlmam1kb3VSeHBUZVllZ3BXeTFjYzJ4WEU3eUg3UTlqaGYxSlFqT29a?=
 =?utf-8?B?UzVLWW8yVG40MWtORVdmampBZW5WYmNoM3pxR0RJeDBMM0s5MVRGK3NMcWh5?=
 =?utf-8?B?czhQaVg4Wk8rNTBYUzlZUEkvWTJmc0lqRGo4WmF5b2NlM0tlZkRTTHU1cnZD?=
 =?utf-8?B?cGJDYjBXRW01VGJyOHhmdGo2ZEFjKzZ1eDcvT3FTdXRZVHRJWGpPR01PK1Rs?=
 =?utf-8?B?d285YUxrVEtiSUpDbW5vWWxNWlBkaFJVbHFjRnhMYkRqdE9yclZxZVByZUg3?=
 =?utf-8?B?NmJvOUFORHNCNC9wUDlOcEpPWnd3Y0cwaXZPOTVadDU2OTZITDJiRE0xbFBx?=
 =?utf-8?B?OVhqd0E1LzMwU2psU0hrNTJMb2pUZGVoWkxRS25kZ1dTL3ZqYnBCZlhHdndG?=
 =?utf-8?B?cEEvTUxjdUxSNGZaY0tFRWhsQVltMVg0SmZoQlpYODBBMGo2dS9EallTdlNN?=
 =?utf-8?B?UFk5Rk81VE0wa0hCZFVMYXNraDlON3h3K1RwUW42NXZYTGp6T05uUkRtOEIr?=
 =?utf-8?B?N01nMVAwQzdSOWNwc0NhSHBQNVU0Uk5GVVF6SWZrMmNxYUhDMm1xUm9DTzcr?=
 =?utf-8?B?VlI4aWFZZzI4Wk9BRURKclN6QzRlUmVzMDNqQ2RyS0JxZkhhcU5ySGxCVW4v?=
 =?utf-8?Q?UEM6ySa38+1zX7OR8+lPPiQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(19092799006)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkxidjJkVUowKzg1Y2krZ2hSekhTTWdmc3NaR1gwcTdxU1Y4UkpmOVVaUTdj?=
 =?utf-8?B?WHV4R1VkMjhPK25EUnRLeGYvTjRoQnZaRmw4ZklyRllVNnpPNnl6ZmhEQVhD?=
 =?utf-8?B?MEEyd0pyelZ5cHZJZU9ORitPSnRSR2dybDNTekl3c2ZadnkxaDJqNEVOY2Ro?=
 =?utf-8?B?RnU5cmJZTk9GeFo5cDFDSks2UUUxaExXOWZTbElOMDZHVmtva21ieVYveGw3?=
 =?utf-8?B?YU4xMkxlOE1oLzhWeVNvRnBGR1N4SStrMW1zOUxXbnpPdDdUUFR2TURTSTB0?=
 =?utf-8?B?SndUaU9YSkg5d2pTQ084L2lIaEtZckQvVnp2L2R6aks3MVF1KzNuUGNybzJ0?=
 =?utf-8?B?RXdTejF4SE0vWkdXMzVXa1J2MFd5am9Bd3NYY1NDL1pXb0M4MjZiRlVvc2N0?=
 =?utf-8?B?VWNRU0FKYUM0U1gxRVNxREZwMjZ6QkpoWXMyRko4dWRlYVR5L0s0OEtrNXN5?=
 =?utf-8?B?d3ArZXVpcW1BY2F0UUVMbFVHaEpyRWt2ejc3NTRLNGlwWmcvT3BmS1JsRDk4?=
 =?utf-8?B?MHhXc3dtbWpOUTdDSm8vK0NnaHAxZ283bGpnSkFtL2hWblZyeEM3cmh1N2lr?=
 =?utf-8?B?VFpZV3gveXllc3J1ZGNtNUNTSzhEZ242MWhvNVZsa1JvZFJiOGVOeHRPODI4?=
 =?utf-8?B?UGJuRjVSMElkcmZ5SGhucHlxL2ttdDBXdVVyaXg2U0dVcU9UVG5vUER5WkZN?=
 =?utf-8?B?d1dzdk5EeEZZRnZQcTV6MnM1OHhyek9aNmJ4OFQ1SC9NTFcwS293UDdxQitR?=
 =?utf-8?B?UXpZWGI2dWFVSXgxa3E2ZUpUTkdnQzFZWlNaSUQ2T3NYUXRsbm5INHB0OUVJ?=
 =?utf-8?B?R1dObWRQVTRwNHc5SnRXTUozdjBYRU9TRklXWEdVemlkV2M2alVUdGpqWjdB?=
 =?utf-8?B?OW9wNUFMY0RNT0V3RnZsUTkyNkFtVTlKbjN5d214cSt6MUhPc2FzdlZEekVL?=
 =?utf-8?B?MGpRRjN3aDRuWDNEc1oyTFYxbVo0dWltVk56ZXRBenQ4cEU3dnFLQ3Y2bW5m?=
 =?utf-8?B?U0ZhNkhoVmJNTnpNTTJpYytIOW45b2RlYS9DLzdRR0hKN3lPM2dvOUNvQW9F?=
 =?utf-8?B?ZkQzcTJvY1hpbHB6cGVkUTZSWm5la0I0VW0ralYrc3h0eXhYM0NucWhIQVlh?=
 =?utf-8?B?cnBMMmJmRXpJQ0dEQWpTdEdTWFN1MWdtb2xHNlpZd0xBRm1vQm9XTGs1bzFT?=
 =?utf-8?B?b2JxcXdzbm5uZnBRR2d6SG1nVXNJRUdvSUNXcXFKaGJPZHBhY0JpVU9hQmxY?=
 =?utf-8?B?RVduWXVHenFxc1NRcXVkTGp1UnJvSWkvWlNqakRzeGl0VjBsNTN4UXpnRXZY?=
 =?utf-8?B?anFvQ0NIUFVLYzZJbHh0aGx5NGFmSWs2TXVUTUVKVmp6MmxDa1BhS2FJUloz?=
 =?utf-8?B?c3JjSmlwd1ppYzZpKzVNTmtidTFNckhpNzM1OGlZMVhPUFV6YjBMdHo4WE9Z?=
 =?utf-8?B?NE1idHI1d3dCNXdIdE1heHJUUTRBR1JXdHhua2lxOVZndSsvemJLUDV1eU9h?=
 =?utf-8?B?Szg0UTNJSW9vbFJvYkVNSnErdy9PT3BETEQ1L2dDNENicTgwYTZacEFMY2pP?=
 =?utf-8?B?eTRvUFdIdjNUdi9md0g5NVhHQ2JpQVVJVXh6d2YranJHcUQxazRjeCs1a3VM?=
 =?utf-8?B?dEFJMVZmK2xrVkpaSTNYcTJuRU44eStVZEpBUGFIbUdKVkZqWWVrZUErNE9Z?=
 =?utf-8?B?UHNDcHU3YktqUk9EK3lSZGEvcEU2bSszbDR5UHpNTUN1RTBkVlNzZFBuZDJD?=
 =?utf-8?B?MWJCQWROQzhUdzZlOHI5TFc4V0dxUFgrT016SG03bU9VT1hTbU41Wk5QMGQ2?=
 =?utf-8?B?ZWdieWwxYjgxOXV0QUV1ZzR1QkZhUjF6algveGJqQi9Uczh5dS9vZEFtRHoy?=
 =?utf-8?B?RGhwVUpkbGs2N2ZmL3pHT0gxU0tzbEZoNXpjblBrcTFDZlBvV1hRZldCcVFR?=
 =?utf-8?B?NEdpbm5paGVIYkpmVlZ3c1BZNXl4UGtLU0kvNFBpMm5SS2ExOSt6MXAvWGp0?=
 =?utf-8?B?aExUbVhjU3gvY3dqL3RiTUFrTnhJMDhEbHdLY2hpaTBBdllHY1BsRVVqbk94?=
 =?utf-8?B?cTIyaXhOTTlpanZqaHpYKzY3WnI0WmU4RmJ3OHFDK0V4NEFZTHVuODNQeEht?=
 =?utf-8?B?RTA4aHVyVHZWaDArdDNjYXhmSkw5SzIxb1Y0b1piMk9pQnZDMzQ2a3NCZEIr?=
 =?utf-8?B?Wm5mR1BNK2pwN0kyVk83NnVaTWZFeUlmanFIYlVWak95b3VIU1BkYzdWbERj?=
 =?utf-8?B?cnZtTnc1YlYxYXVFS292RzNJZlN4eit0ZEkvd013b3ZkWmlwdExlSStnNTRs?=
 =?utf-8?B?NHQ0OUpVdVhHaHM0SEJTT09sTTJTTTNERzdETlRLWUZML2t5anQ1QT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a917b596-1f5e-4704-e159-08de6714bfd9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 13:19:55.4333 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cBcCt5EOAdJ6JLs5q0Gky4HlQ19cN576GtPfb3fMvNpQ0BfQUHz+FBFu4o1HQhAPdDqCSa4WT19Wuty5t6T0IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9813
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

Cleanup the usage of init_uart_clk for i.MX8MM/P_EVK.

While at here, patch 3 is to add board_mmc_get_env_dev to make sure
env could be correctly read when booting from eMMC.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (3):
      nxp: imx8mp_evk: Enable SPL_CLK_IMX8MP
      nxp: imx8m[m,p]_evk: Drop init_uart_clk
      nxp: imx8mp_evk: Add board_mmc_get_env_dev

 board/nxp/imx8mm_evk/spl.c        | 2 --
 board/nxp/imx8mp_evk/imx8mp_evk.c | 7 +++++++
 board/nxp/imx8mp_evk/spl.c        | 2 --
 configs/imx8mp_evk_defconfig      | 1 +
 4 files changed, 8 insertions(+), 4 deletions(-)
---
base-commit: c7fbe028ee5bc83df833a73e1491f1a483b65d98
change-id: 20260208-imx8m-uart-spl-d3bce6fd96ba

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

