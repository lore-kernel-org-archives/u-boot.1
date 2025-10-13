Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDB2CCA476
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 07:19:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47FF0839A8;
	Mon, 13 Oct 2025 09:18:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gZ/BZJUG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C91D8384E; Mon, 13 Oct 2025 09:00:44 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A36BC8381D
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 09:00:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AErs27Cdil0O7kDAAruA3ab0L6UfpeUX4cZR8hzEnxHJpsGzc1FZowtSshKgKBY5Fwj2jW8yipnK/JfDSLMl0ioxuDGEwS5sLMK/ZpYyro57hRsj6nI6H/JZlvzW4kQTd1Du12fgCqoIl6wwOfSm1XAs9InPf89Pdylz0R3iz3NSB4ROyDKHI56hpL7tF/PWC7ee0kqniMCh0WmO1FJDBxHrm8DW/snADrVykGVzREcG3379Nl4Y0N40NjFsL7JdkkJaCf22HTbwSJfJFonNC8L4GF6tIF70GUkcEJCmWLaiRjmTyBbdCSiqJcebZm/oUQOWRJYDqoVMpuoriO7hhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOumPe5SjZrWxQCoNkSz1g5nlikV5njZ/DcTw7c36pQ=;
 b=tIOOsY3dD1CJFnVYHBIYnk8RppH0H/etRtC/tVh8mlNodC971+wd3syol8JvOnvszd/5f0H3f7FqQsdMW8yQiGX8GzF2UYk8cORLTumn1fVAQ7U6FUSwVe13BaqRN0btYf0d+Nhv7Ol+9ql6c+w1Kf+6uJBSweyMD+pAze9OD+bhRcJ38nrV+fReda5nnWml5mOqOkJv6Fp0BM0jyZkSxq++//VzPirlslITOVHb/UKwICrQU+tdibWjygLD7OSgEJb2ESsv9mfJlP77lzh34zS0PEP8mPi0/udqll2Sj/eVZB2Rhiny8oS1eqaSN4MZLAkcqW+0nFNaOdzTyuL5mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOumPe5SjZrWxQCoNkSz1g5nlikV5njZ/DcTw7c36pQ=;
 b=gZ/BZJUG2K1I38a1FC27jvXIqSXXyuibAHpcedDSkgBkokUlY/TxydvorfZrkSto8BZ7SDgpX+b2/0sRHiaasx0UrTeyv4bLIuEe6Jk+Cs6sLI+8WDEfQD0Vx6lq8QKH/Kf2U8pwZ0txFUfyNLyXOydXcpIcgpvK0YRDRj1ziZxgO4y7euJNkINNbfwxyDSiw8Xa8rE+Aqpj/ufEtwHWuY5Sg8KacNSY8I1ayHg4HqqT1nlJg7h9q6fSDmiHJKOFpSa7nmf5ABr7pmY6KW2hJxEFlwarqlGmjLUssy1UD/npTxwNLH+kxU6sF+1bn641N8tFAR9/0wyqQoVoE5oZPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA1PR04MB10098.eurprd04.prod.outlook.com (2603:10a6:102:45b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 07:00:40 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 07:00:40 +0000
From: alice.guo@oss.nxp.com
Date: Mon, 13 Oct 2025 14:58:50 +0800
Subject: [PATCH v3 09/10] net: fsl_enetc_mdio: Add support for phy-supply
 property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-imx943usb-v1-9-293e79d4bc12@nxp.com>
References: <20251013-imx943usb-v1-0-293e79d4bc12@nxp.com>
In-Reply-To: <20251013-imx943usb-v1-0-293e79d4bc12@nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Alice Guo <alice.guo@nxp.com>, Stefano Babic <sbabic@nabladev.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Jindong Yue <jindong.yue@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Frank Li <Frank.Li@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>, 
 Minkyu Kang <mk7.kang@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Tim Harvey <tharvey@gateworks.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Roger Quadros <rogerq@kernel.org>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Hanyuan Zhao <hanyuan-z@qq.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA1PR04MB10098:EE_
X-MS-Office365-Filtering-Correlation-Id: de7d7c43-570b-4c32-70bc-08de0a263836
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SXRLS1pWaDVIcStSeVdzNFkrelI3Tk5lRjNnOFcxakFwamd0Y1JoWWl1Nk9l?=
 =?utf-8?B?YnBhblBXRHZHUXBTcUpySlhUbzhiMlUxWjc4bEVpdmNkZlovK1Mrb3Z2YnFK?=
 =?utf-8?B?UlBub0pzTFFxK250QlJTVmpPdTl5Q1RERmhyL2xOWW9QU3RmbjRSdUIwT3Zy?=
 =?utf-8?B?RVFpREFVY25YZ0FScTFUdUMvUFEwVURuZnBNVlplaFllbVhnblR3VDZMTmhn?=
 =?utf-8?B?Q0NOWGM4R2VnaEczUUQxOVdXTnAzQ3RKY2ZmQUgvYzFaMFhNUGlhc0tPUkZv?=
 =?utf-8?B?a3llTzNES0RNZkIrUEpRRy9TUituK2Y1WTB0Vm41NVdWTk9nckRQcU5MNXU2?=
 =?utf-8?B?Rk1Ca1hEY3orQTJLQURzQnBQOWthaVZrNWxSMnJjZk8zeTF5WjlTK2tJZUQy?=
 =?utf-8?B?Wkdvb0RTdnJWcjd5UnlJbzFnS1cwVXhZeDU3SHVjcXMzd01Yb2NvcWsrS0FE?=
 =?utf-8?B?R2lUemdlSWE2RG1ocEs2eFhhR1JTd2diSG9ZNzhwODExYTVlbUMzRGNTaDd4?=
 =?utf-8?B?Vm1PTUZGRmkvZDJrUGI3M1ludDFxK09NL2FSQUdTYmR6TXdhMkhyTk8wT2Ro?=
 =?utf-8?B?RDkyQ2daUzlWSExrc0pYWmZ1bmo0Q0VuY1BUVE9XMFNTbFNqekxtazJBcHIx?=
 =?utf-8?B?bmYyTlgxKzY3VWFmUFM2ZUdaTFo0VWJTdW14a0hjTXM1SmlDeExSaDIwc1l4?=
 =?utf-8?B?M2NpbTczTWxRSTBjYjBqMzEwNjBuWTRyRy8yK1VFY1J2aktibGNhVnVpMVQr?=
 =?utf-8?B?dlo2ZG5hM0YydG9zTllqb09HSUZ6eFQwdk1DRTlCeW1jd2NZVjBrOW5sNTgv?=
 =?utf-8?B?SWpkRi9CVklhb3FzMFhIWFc2Yi9PMzlLRjduYWVPWTlicEtZZkQxSGYxdmU4?=
 =?utf-8?B?OWovVkxIU2Y4TTFPYjZpREtlTkZ0SzJ3cVQrK2Z0Y1ZOc25nR052bjAxQlZZ?=
 =?utf-8?B?bzZMR3A3SDNtdk1lNDNOOXRNTnM3ZFo0MHB2OGdPSTgyOEtrVmxObGN2ZTVw?=
 =?utf-8?B?V1B1WmNSc2tFTERxejNPTEt3OVh3TXowekVDdGpTS3dKWVFrakdYdDJtN3Uv?=
 =?utf-8?B?a1FxUG5iaVhPa1dnc0c0QmNidXB2RXRqdVB2c3RuRFJPUkRBb29ZQTBpNk1k?=
 =?utf-8?B?TjBHV2ROZjdFSHp6d3JxRHdiWHd2SGZCUHI3L3E3aUllQ2dLNGlDSnc4TUZT?=
 =?utf-8?B?L0x6VU5Uc0hjZXBEYnU2QWRxYXA2TTNtNVUxTVdqNjFLQWNuaTlZM3FVM2Jp?=
 =?utf-8?B?UTdXbm5SNENVSkNlNlFOMVZmZHJaeWJWRXVZWm5KaFpJNng2eHhXVFdmbWxk?=
 =?utf-8?B?M05aVWtZdVovMjVoQVkvUWw1Z25xZnV3b2xSUy8raXV6VHZ1MUxKZytyTFhE?=
 =?utf-8?B?enlpKzNLMm9ZN1FGaE03bDJLVC82elhnSUd6KzZ5UUpud1M0MmNhVWl5L1Z3?=
 =?utf-8?B?cTd5ckxDV3RyK3N2eDlTelR2bVM3RjBmd2IzdWdsbng2OVErUTNYWnNnWWoy?=
 =?utf-8?B?eHl4N3VzbjNSUGdjZnhtYzk0cjNwMUwxMGZLTTlDenVUQU5xTzNWRjVXMDNl?=
 =?utf-8?B?cUVidWZId0tRSENMdGRiSkhjT2JoeG1icmxnaWprZ2M2ZGxheUFKell6S0ZZ?=
 =?utf-8?B?aEFPK2ZuQlRUcUZBUW1xaTNRVXVuSHFWb0YyWExObC9mWGxrOStuYUhxUXNp?=
 =?utf-8?B?Z2RIazEwT00yU3lublJCY0VNMVhPNmsrTDdIbUd4azBza2g0M0RlK2VIUzVM?=
 =?utf-8?B?TmFoYkNwcE5GYkNoaGdqczhsdFkzNStaNzVqMWlqSDBlWmJUK3dGYk54SzhF?=
 =?utf-8?B?b0wyMTcvaWtsV2kwUmZZTGZpN293SFcwaGUzMTRvUXQ5NERDVkwvOWN6anhH?=
 =?utf-8?B?T0d0RFhvMnlURXh5a29VUUNsc2N4UXMralV4VmFqb1VXY0FnS3ZZMlZENTF4?=
 =?utf-8?B?L2hwMFMvbHpMK0FHcU5FSjEvK2VOREdiR3MzYTBKZlI1SkNVTDhyVThmeE1q?=
 =?utf-8?B?aUJ4U0hXblg5dDEvYWFWTlpiV2RFNS8vYnN0RUhrRFlxQWRDOGVRdUpNRzRh?=
 =?utf-8?Q?HqrJto?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(19092799006)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0VaU2FtZW8xc3BEVjlmb0xpd0FKcTlwT3RPbVpmWjlaVENqY3EvVXJYQW14?=
 =?utf-8?B?eDhvRDl4WDc4eExFR0Z5cUVsTSs0RWFmVHFVQUlTYkZQNVVROGRyc05CT2sv?=
 =?utf-8?B?T2ZpbWllR0laeTNZcWlkOFpoeEZNbEFOb2o2WW9DUjVEVnhQL3A0eHU3WEtR?=
 =?utf-8?B?c3JKSEt3M3AxTXVHWEtyMklRNnpud1JUMnFXUk1KejdTNUg0WGNtS3dFVWcx?=
 =?utf-8?B?NjF0bGNEall6alpuUmpHbDR2cDcvWS9XaWxudmozWVhoTmhENkoyTVR2ZWdr?=
 =?utf-8?B?TFBEWmxBRkVRa3dKNE92d3hpdnYxcTB3SUdRQ0I1V3g2eHl1ZjRmbVFlakd4?=
 =?utf-8?B?NGF6aXYrNCtQVzRvRDBMcVdzMHM3TEwxem9NK0NKWDBsV0NBKzNHYXV3TjBY?=
 =?utf-8?B?aUhZM0RZWGFvYnhPSHMrbDZKU0xjc1dRelc2VXNvdXVDY0xMa0UrSmVkWTgv?=
 =?utf-8?B?UXdRTHB2cEc1OHcyQjlscGxsL1pCMmFhc0pTTjZJcHpXa2FselV6dnovRmUr?=
 =?utf-8?B?c0ZVckR3cmtpZk16c3VWa2tTMWZVUlNqbndNN0ltaWF5bEZCZTlrRmZWUDBN?=
 =?utf-8?B?dC9rdDFFN0Z1ZVVsWDBReFpzOHlNRzlmZzVTTzJQcXdXbUVoVkZ2Y2ZUcDU5?=
 =?utf-8?B?TDkxQnFDOXoydjhlbEdtY0FEaFYySi9palIvOGV1M25aWlF5Q0dnREdQSG9y?=
 =?utf-8?B?VkY2SElVYXp6TEp3c00wSVFvVGlTZm1VeUpnVkVZZnczTytjUFM3ZFBQU3Yz?=
 =?utf-8?B?QlUrNGFkc0xTQlRlcm4yU1ZHR2JBcTUwL0NJcjBtdTgrNDlmekF0RXFlT3BV?=
 =?utf-8?B?SWxQUStJZzd2SzhMOWZRbDY0KzU1T2IxUFdaTC81dGZYSy9iL1JMeUhaZzBk?=
 =?utf-8?B?NkxMUGVEL3p3TnIwTVRMMTlKRUl0VGlCMHEzOHEvOGtnbDhMSlRNbkpqektp?=
 =?utf-8?B?RGh1V3V6a0RZRkFaMUFpcHlrS0JYdzVUOE54Vk5iYit5dHZnRlhHYnFqUEJO?=
 =?utf-8?B?U0EzbmxDQ0xGQUF2ZWJHTksrSVhGejYweXJFWDBLMGxvcEtzTTh3YllKQkRM?=
 =?utf-8?B?amVVdmFCcXRwMUxvbW1DVnF6MzdUbitEc0Q4YkpZUEhYakxMV2NlbkVRcDNw?=
 =?utf-8?B?bWJjZlZRT0JRRzdKcElJWUtJSGJyK1pLTU1ycGpkSmlvbm52d3owVU1OajN2?=
 =?utf-8?B?Q1h3aXh5L3dvTkcxekdtZ2ovOUVyRk9veHk3LzVueXFjQUhHRUl3dEVUeGtx?=
 =?utf-8?B?bWhmbmZ5aC9uZnMxWjJsdnVRNzc2ZE9pOWVhdHRGbDZySjdQWmdwQU5COWhT?=
 =?utf-8?B?RDQvbE1VRmRGWDNqb1hJc1NQM0VEcXFQSmIvZlVDek45Rm5JL2haQ3ZqRlRT?=
 =?utf-8?B?VHFMZFM1dVpXUnJyU0FOMkVaVktIa3pHbk1nZUNEMHZYb1FDbkFqZE41cTdl?=
 =?utf-8?B?akpxQmp4dUp3WThzVFdnVmFYbldzdkE3dXg0a3AyZnF4R3ZaczhkYWFyM1pX?=
 =?utf-8?B?dk5abUJKTmlHQWV4SHY3RDRWaFQyNUJYUk5rcE9VU0wxTmZZS1ZPQ1ZGeWZL?=
 =?utf-8?B?SmpPaVF0SStUZnpad1R1ZGdpZEtZeVpwbnlFN0J1bHZjd21OUmxBdnk5SEZy?=
 =?utf-8?B?Z0hXdkk3dXF2c0hJaFFRVGhQa281MUJER0d4SkVvcUNCSXVjT3h1SGRXMnB3?=
 =?utf-8?B?YUJScndGdFJqODFIUjFVc3hqaVRta3hZeXNwcEt1Y2J5dkIzQ29MYWlCU1g2?=
 =?utf-8?B?amhtQmFzZmk1ZG5zaTVSYUpSVWpuOHJkb1NlUFZkU2JhaUc3RjBrQ2lEeXJT?=
 =?utf-8?B?NnBjN01jSEQ0VS9IbHQyN0NrcGR3STZYR3BCVDlHQnFiaFNJZjZIb2I2Lzdr?=
 =?utf-8?B?OHJmOW5QR2dneVMwSWVaZVYxZzZiKys0ZFkxWTJsbVVQOEVqaEgvUWFXUnJ0?=
 =?utf-8?B?ZWNkRUpBT0N4NnB3ck5uM2hvVzNYMExQVnlJU2FvczVEZkhKR1V2ZmJSK3Za?=
 =?utf-8?B?UVcxenluRFlSSXJ6UkU2UE5SOXY5N3J1ekdKbC9Ua2RVUElBdWUyelFOVDhF?=
 =?utf-8?B?enFGeC9UY2o5YjlndkhuNXduaWNoU241OXpPZmRXcCtYZXI1MFRGaUI4b2M1?=
 =?utf-8?Q?ZKmYTfBku/z8XkiFyVLk+4H5Y?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de7d7c43-570b-4c32-70bc-08de0a263836
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 07:00:40.4971 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3GCoBQOKKj6PVt+g4yxDIRKOD4Z25UL8AnFEsm1Fc2R8Sva2sDgDd9wPMm8NxCxycOSn/7qT6FA0LEmavxjjBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10098
X-Mailman-Approved-At: Mon, 13 Oct 2025 09:18:15 +0200
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

From: Ye Li <ye.li@nxp.com>

Add support for the optional 'phy-supply' property in the ENETC MDIO
driver. This allows the driver to enable and manage the PHY's power
supply via the regulator framework when specified in device tree.

Signed-off-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/net/fsl_enetc_mdio.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/fsl_enetc_mdio.c b/drivers/net/fsl_enetc_mdio.c
index c1d491f2c5a..3d76d92a62a 100644
--- a/drivers/net/fsl_enetc_mdio.c
+++ b/drivers/net/fsl_enetc_mdio.c
@@ -11,6 +11,8 @@
 #include <asm/io.h>
 #include <asm/processor.h>
 #include <miiphy.h>
+#include <linux/delay.h>
+#include <power/regulator.h>
 
 #include "fsl_enetc.h"
 
@@ -135,6 +137,8 @@ static int enetc_mdio_probe(struct udevice *dev)
 	struct pci_child_plat *pplat = dev_get_parent_plat(dev);
 	struct enetc_mdio_priv *priv = dev_get_priv(dev);
 	u16 cmd = PCI_COMMAND_MEMORY;
+	int ret;
+	struct udevice *supply = NULL;
 
 	priv->regs_base = dm_pci_map_bar(dev, PCI_BASE_ADDRESS_0, 0, 0, PCI_REGION_TYPE, 0);
 	if (!priv->regs_base) {
@@ -144,6 +148,27 @@ static int enetc_mdio_probe(struct udevice *dev)
 
 	priv->regs_base += ENETC_MDIO_BASE;
 
+	if (CONFIG_IS_ENABLED(DM_REGULATOR)) {
+		ret = device_get_supply_regulator(dev, "phy-supply",
+						  &supply);
+		if (ret && ret != -ENOENT) {
+			printf("%s: device_get_supply_regulator failed: %d\n",
+			       __func__, ret);
+			return ret;
+		}
+
+		if (supply) {
+			regulator_set_enable(supply, false);
+			mdelay(100);
+
+			ret = regulator_set_enable_if_allowed(supply, true);
+			if (ret) {
+				printf("%s: Error enabling phy supply\n", dev->name);
+				return ret;
+			}
+		}
+	}
+
 	if (pplat->vendor == PCI_VENDOR_ID_PHILIPS)	/* i.MX95 */
 		cmd |= PCI_COMMAND_MASTER;
 

-- 
2.43.0

