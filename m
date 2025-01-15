Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7741AC02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:31:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39FB88070D;
	Wed, 15 Jan 2025 14:29:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VnyNp5Us";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27125800C2; Wed, 15 Jan 2025 14:29:57 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::624])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE82D80726
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:29:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mlojeMvwKbT0XV7VpEPOOi4dU0cGP85I4TyKmCFv2l6XeJMy4Esn1vh6y5Urzeow2cPQbVyoR9CLUJMK8Yly75P6sxzwKIfZSxpmoDcyI1/5g4y//mYqjP7RGkJBSvNFi+hdjHAUPMRYBPjj7yngcQU+YifQuqfr2LoxovviJQ3np3u35BGklgdgJtaMNoRFziCv0Zn2bOLcj3amKIW2GHKrQ28pl2R1kQVklgi7RUxDOn8wO9SfP9+1PmC7udRHYR42TC7GwbLRNy3PeLMH31ym2m1OGD/13DuBasydkmoHwIwgW3lNmy0OwZtpNMa3vMG4NkL3VzrmW1c0xZwuYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsA/x3FIieWNDxQwQf+dD1mvAAoSeWt9028OYT9schU=;
 b=rogSSgtNUujBZzNwoGXwbtfj/1V1iTMJ0G+kIcFTeg+F/TLeyWqLGYuN8Uk3VE5odsTBbd2Qafy+75Q1DPEJ7LLWgQGsUKUZF+rsq/kd90Ec8c38jD8dL7dknxTsX3QsuGNwSq5oY/Oq2ZYSZqDYNvVYxQGtrOXWCjUq+SIaCdSDzJ6DupO8T47RNwD0iWrXxPfOmoLDE9ldU6BLAApka51cQb6yXILnBqF0bGwmTD2+ZsiUCFRml1cum093d2ed+nkSQtS6ZjOk8HJwJV/DgZXH9UJVLmCC5rR0igD8ifwvawepRPh/Hb/zh0TFBg4w6pVjMCEXpI1zUh2YdHMF/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsA/x3FIieWNDxQwQf+dD1mvAAoSeWt9028OYT9schU=;
 b=VnyNp5Us8err2YJgXRshhNH74wiHtiqoFLyQ3xiyJUXBK0e8Bm+ep7KfQbWtwWhKwE/DizCkTWbHmKwTMDmHoACSsuk7JFDmGZ3FTfoeh5FMSjr4YCPSc6WLefjkVHUbfT5Wdsg7dzzfsr6cU850AtCYyns2IKnN9Srbvkw4CZHIeZWOtQ5AL+JhTN/2qfE6+VV4OGS5AdoAmbErSvtrPXwE8iIBNUQn1bOvBn3APDERS/ESXc4lGLiqGjYYgugUmzMdh/Kbg8SSIWLSOp2xTwBuUKDgXlHyExxmw7bQieJ1kPEkZMWYhdhQ7skJcvGVnZa5czl33zn73sAsraaZdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7764.eurprd04.prod.outlook.com (2603:10a6:20b:244::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 13:29:53 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 13:29:53 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Wed, 15 Jan 2025 21:28:58 +0800
Subject: [PATCH v4 11/20] scmi: add the macro SCMI_MSG
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-imx95-v1-11-93b28a514dea@oss.nxp.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
In-Reply-To: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, marex@denx.de
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736947742; l=1060;
 i=alice.guo@oss.nxp.com; s=20250115; h=from:subject:message-id;
 bh=04Fugt2pLh/tOsYnH9qSnBxxNCtFxPv3ln1VhqSdivE=;
 b=soVmYz3Ho2CBZEqW88NRHI7m76B38dWrNuPZtwMDCf8+ClJGp1RItrgzLrvUnG1Gw7KbUrods
 WpGkFSnGUT0C+8x7ndYviZO9vUiMjKRPQYZS/EGMXXp+0D92acca/Rf
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=MQFotjdbgvdbpnpHmN/PUzfJXX0wchusR4L7yfs2VZQ=
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM8PR04MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: 53b30f36-913e-4ed9-267b-08dd3568b1b9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RjdIZnIwV1lsVDlncGFoMGY1L2h5RGFvelhpcXMzMFVWdUxFaXFHQUVLcm5y?=
 =?utf-8?B?SjlFMnh2SzllQjV3c014SFJVWlZjYk5TY3BRNjZwbTVHMkVvb0lWU1hSMHlY?=
 =?utf-8?B?WHhKNElhdXEraVZCc0xxTk5wbWJ3bFN1RFJ5OVFQVkFFSk9CcUJrYy9HKzdN?=
 =?utf-8?B?NmNXYWFGdUYxc0Y0NXlpeWc3TXVaQzJzWHI1aDlSU1ZQK0R6MU81c24ySTJD?=
 =?utf-8?B?bjRNaUpReGFoSUIvbHhrTnB0em9uNEkyQkc0azBWcTdocjAvV0JrUVVmLzhJ?=
 =?utf-8?B?bXdmQ2szWmxqN0tkaUFLYkRWeGhqL29jLzF6WmtEdFdPcnQ3a3ZjeWFWUFFW?=
 =?utf-8?B?RFM5dEx0SXZnb0ZscXgxbjJwNVRZYk9Fa2I0R0hqcVRvbjljR3hCb3ovd1M3?=
 =?utf-8?B?OG9BK2x5ZDBuQUs5eFFMQmNCdHFDU1RlTW9sOFhML2w2cXNRSHlZM1ZSdEhl?=
 =?utf-8?B?WWdMTHcrZFpkbnRGdnRXN3ZPNnh1Tit6L0hBa0xjM2J3TlBUNnQrQnlieE5T?=
 =?utf-8?B?NWxjaGMrQUFoZUp2dTV5WC9SZmdzdG9YcUQxbnM2L1dyclljVG01VGNCcnJy?=
 =?utf-8?B?SHE4TjVxTmRGSUh6RlZKZUNwTGg2c0ZUbHJaenJWTU83ZTFwMm5iMHJBWFZw?=
 =?utf-8?B?VTNBdUphekh2QzFGdDBLZ0w4TCt2c293a0h4UkNDejdxTlp6NXQwaVFwUHBo?=
 =?utf-8?B?RWxPazB3a0RsajRPRnh5TUpKbTU2Mnd3dmFVeXRYaW5JTXhLdlNneFJocEJy?=
 =?utf-8?B?aGVNMWhmK1FjYzZCYSt2bWRZSkUrdm5tRlhWUjRTQVgxOFFDYnpHZmJadEdr?=
 =?utf-8?B?SkxFa3NBZ1JBaTN4MjdRZDcyeUU2NCtFQkM1Szh1elhSQ3hENCtRTWN4NlUr?=
 =?utf-8?B?Q3JJR2VWUXdVZzFZWDhCd2ppaVhhdGhyR3g0d1hwMm5BMHdueDUzYmNYZVlT?=
 =?utf-8?B?NFVoQzl1bWVSdUJWVDlCYThleUJacERsaEUrRXdvWVV3M0dkRm9BTnJuUEJn?=
 =?utf-8?B?Z0t0V1NmeEZaYkJJOUlBTHlteDRFWFcyaWRrczdQT3JpbGkvcjNtSkhFZUJ1?=
 =?utf-8?B?a2xXNW9CU3VyYkZWY2FjK0dZWUVWcWgyQjBkWHRjSm5pd1JRZ1hrdVN0RmFQ?=
 =?utf-8?B?VWtaekc2dVk1K25ybWdsRmJ3QzIvOWJFT1VQTURrcmJ1WW9vVnQvWDJVb0t0?=
 =?utf-8?B?cWpTTG9OTVlqbWdSQk9ZVmdDTnNudERJRE9WNTJtaFl1cFFZQWFPU1NhMGsy?=
 =?utf-8?B?Nm1zczd4dHBGTEZzZVE2azFDalVaRnhhY3JEQk51bXh3OUFnRlJReWE5c1hj?=
 =?utf-8?B?a0UvY0xneFhCTTBGeGpLL2xHU0wzOW5hV3ZDV2hNU3RKTHRUeldNeG9qZi9S?=
 =?utf-8?B?ZmJtY2FPeXNLVFJhUlVnZEo3bXFmbm13WUgxdTVSQyt0SkkvTXl0R05TMUdl?=
 =?utf-8?B?eEVYeGVVVVVUdEFpNDM1RVdMY2d2UjE4d28vczEyZ25TL3Nad3huWkE5WERL?=
 =?utf-8?B?SW9KcGkvdXo1dWNZTFBTVnNpNDdraUErNnFuYUJBaWpmekF2K2VOTi9QdHJt?=
 =?utf-8?B?RXJBY0VqOVlTamxvMTNDT1QyRjczUmdGR2ZhRUhJTE10b0kybEdIV2lqSDRj?=
 =?utf-8?B?Z2x1WGpYTGRlbmlVM0VLQjhHdzgwZmFNNlM2S09UTEM3TlREWHZxRE91YkRh?=
 =?utf-8?B?ZG9IZC9CVzBMM3N0aDEzc3MyaTBKUm5KK1U0N2lvU3FTRy9nZSs4dVlmcDU2?=
 =?utf-8?B?V1orZmhpQjNtOVhrNm9MMUZSWVY5eE1hcm1FbU50WmROYVU1dVM0V0dteFF0?=
 =?utf-8?B?K0svMEJlVlBZeitxVzNveFVVcGUvUGVXYWZ4WHdYWFlWbnNRQmVzS3MvWjMz?=
 =?utf-8?B?UlJCSGlZNVlqWnZEOE1sODdxU3kwNVpXQlFMY1ZVTjBRMXJvY3V0U3VDSG5L?=
 =?utf-8?Q?oKLxguNLp/hDzTz8vFsoVbOtqeIKGGeI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUJrK2Z0L0NiQkJ6T21OK0xJcFphNUt5ZkpvOVJJUTVnMG14bnFDeTMyTzB5?=
 =?utf-8?B?eUo2bU5YOU9RamdnWkVjeHBrK2xrdmZTK2syYU9YaDBreTRCdHZLUXBZNVoz?=
 =?utf-8?B?dEg2RlArZkJodFBIMFJ3M2RXcTczNzFVRTc2M1pLZnJmRldVNXpGM0U5bUhn?=
 =?utf-8?B?Y0RIMjF1VzA5ODJub1dDeTkrbTdWT01IWTh1eU9NcEJ1Um9YbE5lalpHTUhF?=
 =?utf-8?B?a1FDSk5HYzI0R0pUTGhrRW1OUnZ2SW1YTVZpTE5CbmNYcit1ME02U29vWmU3?=
 =?utf-8?B?WjU0NVp3M0pFY0VPb1ZRRDdDUkVOTTJuaGhiL3ppeEtRUXNMMEE0cHZxaXB3?=
 =?utf-8?B?ZkJnMDZuQUdrdzYxMzk4eDVQSkFPR1J6cXpma3BqeG0zTkU2LzRwYzhxdUdj?=
 =?utf-8?B?VlA2cnQ5M1l3T0FscXlDdVFWT3pjQWpxenRZYm5aTy9XVmljWmJ3ajVlVktU?=
 =?utf-8?B?amRCclZNbno4S1BUbGpnUFdja3pqR0Z4cjhsV25kenlJUWQvK3hKVXVJaFVB?=
 =?utf-8?B?SnB4dUE2aXRublI1YnBPWlhsZGRvUTdMZlY2R1AwK0NnY21LOGJFY3huOVhh?=
 =?utf-8?B?TkVqQlRiSWNYajRBSDVrRkJBVFdkcjd0ek9iQUFCL2FYUTBzTFBXbnpES2sx?=
 =?utf-8?B?RVBjVE9KOURYaDVzV2tzQ3dvckhHRTZoU0VvMG9WVXlOZXF4ZFFHOEFCM1lK?=
 =?utf-8?B?aVFrSy9aWHcxNitVOWdvZlFINGJQL1I2VW5hS2lLbW5nWmtSZTA3UHJuR285?=
 =?utf-8?B?Uy9ZZWFZdGZyM29WVnBoUVZYUWEyUk8rRG5xenZmM0ozUjFwNlA0NXJ1Y2J6?=
 =?utf-8?B?aVVWa3JUTDNoWXdzMjZyR1JKZXhKdk9sQjBaRVJIaVJIV3ZKOTdrQ3dwWitx?=
 =?utf-8?B?N0hobGdsSU5VOW5MYzBDMVdDc0tyUFNGVE9UQnp6eGdoYUQ5NFRDWmxYWUlN?=
 =?utf-8?B?YnEzemM2ZFlHT0ZQdlhmNWxDSDdTOWdNbjJ6aUlEcVB2dFBueFB6NHZlUVpu?=
 =?utf-8?B?bmxYSWRKS2lDaXd0b1BROTF2bTZBUmdzV3k0NGJHaElGMU5Md0ZrNlk5MHpJ?=
 =?utf-8?B?U05XcG0vWDJiMnZjT2o4WGpOYmJnelp3QkNxbUxvZ0czTlJnaGNnSXNsMXZF?=
 =?utf-8?B?S2ZkdFZiY1B0d1dzY1lMSytBTnZwbm5RTWJpeG5LV0ZEdnp3SFlXRWFmN3V5?=
 =?utf-8?B?VlFWaUt2K1JxYmdtTnlvc2lRNXJHQWdYMGlsQnNWZXlEL2pkcFFOSjBpWVF4?=
 =?utf-8?B?SVM1UllFVStxVlVFQXZJcUFGZFJTcldOWXZMZTI2NlBsM3FIUTZDL05Hd1h3?=
 =?utf-8?B?UzZ3ZWJ3VmhGdWFSRXQ2eTdpZU1JWGVOWHk2STJBVmZBQWg0VlhYdUtXZWVI?=
 =?utf-8?B?WlVtNjdoK3RubGxrSGUwMy9RZ2ZHcnE1SE14ZTZhMm9KL0k1UFRoZ3RrOU54?=
 =?utf-8?B?dzBzYzlra3NJVGRZSzNwMDh0T2NJK3JhU01WS1p4azR3dmhRK0RqTzRxTGJI?=
 =?utf-8?B?THRVdXozQ0tVWmRpRWowNDhveW9lcVRaOGNaV0twQVBOUTlVaGZhdzIvaUdG?=
 =?utf-8?B?amd5WEZUUzBrQzFLb21OcERUM25oVkl5dXVqbllYa2RoSm5QcUdkODJqM1dH?=
 =?utf-8?B?OEEvSnZxTVl5YzZraUpVRUVEY0JMQTRpdERZcnV5elBXZXdHMS9oOVJ3Z0ow?=
 =?utf-8?B?MUxwWEtaN1J2YllyeTVzT0h0eVptOTM2ZDFrVGZFMm96Z0U3bm0zQnpsWWor?=
 =?utf-8?B?b3dObVM1dXJCL0wvbWkvVjZkd3l0MnNNS0xITnRMdnNTeXN6TXBmakprZHZj?=
 =?utf-8?B?a3BRWkJ3SE9wMFk2OUhxdTU4SExyU094NCsxMHR2aURiSk13eEhBRUhSbVA2?=
 =?utf-8?B?RTgwWTdlSTJkRCswdzVhTjFkK3IrNCtDbTFPTVdLWnV3aFJ0NWNMNHF4b1JR?=
 =?utf-8?B?QnQwT1F5NmVjUGk4NXhweVZCcEpiYjlpZkp1QkY5cndXUmxNdzM0WGYvS1hj?=
 =?utf-8?B?Zmlhdkx1bEpIcnhuRnFaWFhnUzBWNkt3V2l6emNxU0Q4QXU5OWFYT1BJYkUy?=
 =?utf-8?B?NGwxVHhxZVJDMUcwMlhmSGMxU1dodTRzeXdGMVp2ZG4vQ3h4Qm52QVdMWkIx?=
 =?utf-8?Q?TC9Y/pJBD8dxUO++LXh6fGuUx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b30f36-913e-4ed9-267b-08dd3568b1b9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 13:29:53.2549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iuqxaphYKoCqAouySH1Pt1q8C7X+rBnhBFl+/pPxNpXqM4N4ZANeUd13hIviebUTPyRQqhxOQ7kfxakCdsiomA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7764
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

This patch adds the macro SCMI_MSG for protocols that do not need
_in_array.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 include/scmi_agent.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/scmi_agent.h b/include/scmi_agent.h
index 755986d6c424ccc881ac0943a88735cbcfacb001..5508a126a6dc504afa6d896c78c760b1af0d3deb 100644
--- a/include/scmi_agent.h
+++ b/include/scmi_agent.h
@@ -54,6 +54,17 @@ struct scmi_msg {
 		.out_msg_sz = sizeof(_out_array),	\
 	}
 
+/* Helper macro to match a message on output array references */
+#define SCMI_MSG(_protocol, _message, _out_array)	\
+	(struct scmi_msg){				\
+		.protocol_id = (_protocol),		\
+		.message_id = (_message),		\
+		.in_msg = (uint8_t *)NULL,		\
+		.in_msg_sz = 0,				\
+		.out_msg = (uint8_t *)&(_out_array),	\
+		.out_msg_sz = sizeof(_out_array),	\
+	}
+
 /**
  * devm_scmi_of_get_channel() - Get SCMI channel handle from SCMI agent DT node
  *

-- 
2.34.1

