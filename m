Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F162C27C52
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 08:39:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D16E2874D4;
	Wed,  5 Jun 2024 10:39:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="XMyOGhqB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 916EA882E2; Wed,  5 Jun 2024 10:39:53 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20729.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::729])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE3D5874D4
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 10:39:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e91QyfglCo20iDk0nYQ0tsySKvw7O8FJU97KeqyOeJb40crk+rx0XrJnE7X/QFTeMhHUs+CePHxkZLvQMUeZLyuwpaAEgTP76wDlzD8RKCV3lEybB8VNQGdYQHiG2nNKDX4LJsIRpCvuYGtsBj5+nMZtr0K5Mk57tMqUUYTeaM/uiDN5UcVbzuw6kyO4TQHQ2k97j+m4PqcQvcbuIs+COM6R5ZRt4GYufFA+0XhUPeTVcGfcVAxbY4AsFGejWyhSJfUTDSWk5Um7xyxVCUxvTTeHSmbe9zwWI9yB//Yyx3AKy3tsc3DOwb9k79hDEvdXDf5uIHN2tyGyQ87CtD66vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6zgr9eGVRqxb6G4xOxYb64/8znKf0h/+KCjck/Ab1c=;
 b=h1gpAi/An+D97kSIfOfWfzeOKK+koTtypmfp8MgJWv/17V74C6pb0HfIkA70sagLtDKuVfqbVOEP1u2WnYQBlwEBthxZlazRCio++EsFLZ2tIqLnnKbJaJ4KfyMMRQRqZY+5pVuEag4ENyEgFQCWNH6s9r/rGxxXc1Nbk5Rpsf3KBtzSjWcItoN+JrRN5AMU7bu33nMIOkuCRypiXjalZLfhSqNtFITdF2tjxZMeDhEcodeggFOZ+6jguUm82fvKU7vZO/JsUI0tJST5iWZaxEWjP51RTvgm0NEw61Q/qBm8RK+H1by7jx9TxAahOe340fPNfkaKHwnb0p8f7qAm7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6zgr9eGVRqxb6G4xOxYb64/8znKf0h/+KCjck/Ab1c=;
 b=XMyOGhqBHsbVC2hLOw4h17ucONLAkRIhmNdeDQERpuINh2M/nTiv81T8x3QAh+/O1wUgzLx/XdKJCI9yWoJjyl6MzVhDdX6bvhNxOCwNx5JeNSZOzIvoLtUU0pz5ip+W0D2z3h9m3sNVyR2JNhnW9vzTeLcMTvXJHZWuIS4BZLE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by GV1PR04MB9053.eurprd04.prod.outlook.com (2603:10a6:150:1c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 08:39:47 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 08:39:47 +0000
Message-ID: <13281e3a-5e30-4f0b-84e0-d6a4effed43f@cherry.de>
Date: Wed, 5 Jun 2024 10:39:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] power: regulator: Handle autoset in
 regulators_enable_boot_on()
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Eugen Hristev
 <eugen.hristev@collabora.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <l.majewski@samsung.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
References: <20240605032521.1142768-1-sjg@chromium.org>
 <20240605032521.1142768-5-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240605032521.1142768-5-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0023.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::7) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|GV1PR04MB9053:EE_
X-MS-Office365-Filtering-Correlation-Id: 10a25345-e85e-41ae-197d-08dc853b0e60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?amFjc0RkditGckRxcTlpdFlZVkVwbGs2dU5XTG1BbUlsRDloUDJ0QTN6aHpV?=
 =?utf-8?B?eWhxRmhEY0lXb1RnMjNJMFlLRlZBV2EwZjFFZXlDRmtVVHF1S0FwMG5YeWVy?=
 =?utf-8?B?NG4vV1IrN0MxZkZpVGlEZ3NNdzdyYlhEZjFZYVNUOUxoamZkSjJDRnZQa2Rs?=
 =?utf-8?B?dFFSc2NOQ1Y3NTU3Q2xkWUplVDl5aTV5Qm51bW00Y0lUTUxDdDJXTncxNnZ3?=
 =?utf-8?B?NXBUU29JL3N2bXpZemMxSFo2Z054OVB4QXVKcjdQV21pODJ0OGVWalZsOGxF?=
 =?utf-8?B?eDRKQUpaV3dWU0tTYk9XYUY0dDUxUkxvRUFiVWJQQ0h1TkVmRWxNT3hLb1l4?=
 =?utf-8?B?NVhtWU5UbmRXdWxTb05tS2JXeWJsem1zMzRXQzRjWmZudXZzaXpKWFY3dlo3?=
 =?utf-8?B?MjF0NG1YM0E0T3ROdnJuR0J1eDFMbXVzdUlhSHRCUFQvR2lNRTVXNkR4R25z?=
 =?utf-8?B?bFdUL3Y2WHhQRXJvcjVoakp2NUZJamN0alp2V3lRWi96aU5BeTdYMEFGeVhP?=
 =?utf-8?B?N0JGQU5hYUFpTlV2ZTMvYWh0WVlWeDc3dEFNTGlkOVI4dTBwZXlhNmRjZmRJ?=
 =?utf-8?B?T05wVVFqT3Npdks5SVFXUGwweXdjUUZYV2JFMkVGekd4Uk02dVhzcm9OMmFx?=
 =?utf-8?B?VTh3WnhOSVdLc2dhTzNHOUNHZUFyMWsxRGZnMGZtYVREWTgyL1pBRUU5b2ly?=
 =?utf-8?B?QTJiNXQxWUE5WVRsMzRwbm9aald3aXNvVVY5MVlncnNBU1U1bktqS2ducUVl?=
 =?utf-8?B?MVcyczRJWDVPWU16VkFPWlorVGc4aXpXKzNnNDluWGgzR2NpT2ZUUkY5SUgy?=
 =?utf-8?B?b01abWJVY21KN0lWRzBsWEhFbXNhdHk3bHVjYlVRZ3dOejhDdkh2MzVTTEZJ?=
 =?utf-8?B?ZGJOWE85M2Y3K28xSnF1NTZWVUdTZmsrcG5ZYXBLWUsvczVJNXR4bHlEWm5F?=
 =?utf-8?B?ak9iLzJKUHFMdEpxYUc5M0NqT2RTajVZL3Z1Nkd4dkNETWRUaUd1aWNvdDA1?=
 =?utf-8?B?bGg0WjVnVERndjJBclJ6TjZjd3ZXbi85WTV1NjQzeUZRWXV3ZzdmNElYdVB0?=
 =?utf-8?B?TUFwU2p0eWNJdjFyN014Y21MNHZNYTBPM21zeUNjaUw1c3NWV3NSdEJrNUMr?=
 =?utf-8?B?RndzYlhySEZ1bU0xenI2aVpmaGdJZC9JR3MySVBRUFRHbzBXaEROUDlITXAy?=
 =?utf-8?B?Y21MQjF0TUpkdXhXNkhLU0hLMkZoT3Z4UXF4czRuT2xQVEJqZFpnc0JjNlEx?=
 =?utf-8?B?R0dsUjZ3ejd0ZDBIMVFqVUYyTUZQMmQzOHMxTlZCT1J4T0R0bTZSY0xUR0ZL?=
 =?utf-8?B?T290c3luMDFpSGI3SnZyZk42UzlQS0Q0WXJQYnVYQlZuN0o4eEREN3Bid1Z5?=
 =?utf-8?B?bk9ab0wxV3dFZTk4SW9EcVR2NmdjWWNVWUdwTzB0SXRsOHY5VC9TUlBXRTg0?=
 =?utf-8?B?TkFpZlFaRHRRVnRlOTVLMFJEWXluQ1JSTjFZKy9PNURMc1RZRStITkJ5UFBp?=
 =?utf-8?B?RFJvR0Exc1JLWUdVVG1RU2NRdUY1b0tyUzY1VzFrRGhLN09BU2I3Z3pCUXZt?=
 =?utf-8?B?TVA1bHB3YUVxMmZXT0ZORXRQdHVJVk95anpRaGZjdGYwYmg3MXVvVHVMMkF2?=
 =?utf-8?B?d05ZeGFmVHpjRDRDNlJLWVNmVXZzNkpqMElOYXZGZ05EaTdaV3FEa1h5WkV5?=
 =?utf-8?B?NEd4T3FkMGFJWFBjUlpMM20zU1ZoRzM3c25sVVloZFozSHNicFZSRy9RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmJsek5vS0xQSHViSWx0RWhPRDRMVzkyTEZHSE9jQm82Y1M5VUVRSHBicUQx?=
 =?utf-8?B?LzFxaWgvaGtFenZDVENWOUNyVUJFNXR0T21ldDBDeGRzZm9IV0pKLzZJeDRR?=
 =?utf-8?B?QVhSU3RJQ3k5eVUrbFFGUTNPSVpJMjdQeGd4ZGE3UmE4RUVMMzVkZU9rYTJF?=
 =?utf-8?B?L1FvS28wMkZXUmhFNUxMNTI5WjNJdjU3clgvc1I1ekM3ZE9LTE91RkUwQTAz?=
 =?utf-8?B?U1hNRmdnOE5KRkQxUi9DL0pLSzJkWGdoMEl4VFlRYXJBK2dzaVVqOUUyZnow?=
 =?utf-8?B?MVJEQlhPelNmdGlmQjhBSFdUb2t6RWVSUnlCN1ZTNS9FeHJaRVdzQXpKT2hD?=
 =?utf-8?B?c2Zwajd6amZRN0dNZ2VEUzd3UzdDMjBmVVQwQWxqVkZybHYyMXJrZEprV05s?=
 =?utf-8?B?ZXpFVzBPcFlabXh1UEVHemtWL0JRTXFHTjVyclVXUDRGc0ViSXIzbmFERGVu?=
 =?utf-8?B?OTNpV1Q0SG84b0FuWElnRGhqekNkbGlhakY1amttMnBkQkNLampIWVpPd2Vo?=
 =?utf-8?B?RXB4eDhkTENiaXNoT1JvMXFvSnhzQW5EalRiRjZMNFJNS1FCWjhvNUo3dXJL?=
 =?utf-8?B?dktxQ2s1ZTV3Y1VuakVSRzBGZXJYVlk1VElqUy9tR2NEVVhrU1RuZ1JJZThy?=
 =?utf-8?B?WVhma1hIQ3RNMnlNUXFwcVovNXJoUFBjK01ES1VUQmg2QjZxOHIzLzQ0Qzlx?=
 =?utf-8?B?RUE4K3B1WURyTEJQdzh0Ly9VK2JDQVpaQTlDcklTVi9JQU5LOTV4QXZFTDh3?=
 =?utf-8?B?aWF5VUtZS2EwYzF3UVJMZ3dMUDlkdHpaNFVhRWQ1U3ExeEJBdjdGdUVCcXFK?=
 =?utf-8?B?clIvVU85MzArRUt3QjNESTFPajY3Uzk0RlZadStydTVNME43QTE3TUNOZFJy?=
 =?utf-8?B?WFF6ZUwyUVhUR1ArNVVZQnZUSGVpTXBCckRTSUVvVk5aZ3pLbk00ckViYmty?=
 =?utf-8?B?L1ZSMklUVzlJRFFqVGFZM3lDbkFrMDdxTDUrNnJJcUJSQ0RJcW4wRUVyZFVF?=
 =?utf-8?B?d3VtZkZ2R0JERjNUbkMzK1RwT0lrY1poc004bThiOFhlQWZRSS9IWDk1Nzh2?=
 =?utf-8?B?V3RGSkVYZzd1dUlKTHNuMzc2UzdscUtYanhHdUd1Q3hQZHIvTTVCcFBQcUoy?=
 =?utf-8?B?eFpjTXRvbkFrdmMrdk1OTFBtR1U4dlJYMktwUnl2bnhFNEozVFJNVHVvaC9y?=
 =?utf-8?B?Y1BOazRaR2tsU3AzekN4bFlZdXRXVkEvTzUrTlRCQUhXcDJJVVNMQUVrcWMv?=
 =?utf-8?B?OGxkNzBlUTVmNnNOdGs5S29Pd0pEdWVuSlJDUFhxenhYcStNZ080QTVJYk1V?=
 =?utf-8?B?a3BXNHF5MnBQWnV0TWVXcjE0VnlXRnZkMUw1Ni8rNFA0VjcrbFdxdzQwQ09l?=
 =?utf-8?B?dVZ5UlhyM3R5cUR4aTJHa3NRNUtodXN6UkM4dndOR1c2VlFQNTlKeVliaXJD?=
 =?utf-8?B?eTB4bzlWbGYwR1QyaUZtaCt1Vkwrb1k3S2xxZGNPRWEvbnBGS1J2Qnd3OG1T?=
 =?utf-8?B?RldmcFAybHBieTF3V0FLcTVqVGZtd09vUGhoR1E1Y3IxQThKV3BZQSsrWktI?=
 =?utf-8?B?L0ZVa3lXMDAvWGpVUXIzR0tCajFRdnVIdy85RUJQSlphYXB3Skl6WWt1Y29v?=
 =?utf-8?B?WXY4eFBVc1dOdVpFd1pLd0hJOTg0VTVFbzRnSkRmNTNFSVdDVkhmWHIwQTc3?=
 =?utf-8?B?VHpIRHZ1YS9VaERwT3hNc0lyZ0RnTExnUUxMVTNLekQwaTZmRVdka1FrQnBE?=
 =?utf-8?B?L0RQMVlzT21sOWhYY1JzaEVWaFBRTk9xYTk0N3lXaW1MQU1qRkVwMEdjMTBS?=
 =?utf-8?B?aHIrRFR3MzhJSDFkMTFKc29ORUg1ZENlTU95dW80VnVudDFRejdDNjFEVXFN?=
 =?utf-8?B?MlZYdWVEd0dQazJ0Q1l2aGFWTU1WVGNxdFl4R0RRZVRlK3RQcjJpWUNGUTc2?=
 =?utf-8?B?ODRsQysyNkpMa05WN2tSRUR3T3dqMDFyOHZYdTI1RUJmQ1dnVTBCMVRDdlRt?=
 =?utf-8?B?TFdtWElpc1hpTG5OZTR2NW5tUkExWm1MSVNZSGRrYzFjSGhGd2tzRzZ6RGdq?=
 =?utf-8?B?SkRLa0FXekVDVmhDdVVzZGoxcUxqSGhnTXlJQkI5MFZBVG1UZ1RMRENJNWpZ?=
 =?utf-8?B?cGIzSHZnU1pDOUFiSi9VM2hyU3U4cURQNlhGdHZaU0UzVmxIU1g0SDBmN04r?=
 =?utf-8?B?dnc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a25345-e85e-41ae-197d-08dc853b0e60
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 08:39:47.2087 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WE0h8BDU82VEctpWBoVMk/KphnNFXDZOGn/Qath8JFzWFMOWUVTJgBxfiSMz/x4oszSO2w8Kmcuwbtr4WNzxFxoIvKTYvsILBeprCsh8ldU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9053
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

Hi Simon,

On 6/5/24 5:25 AM, Simon Glass wrote:
> With a recent change, regulators_enable_boot_on() returns an error if a
> regulator is already set. Check for and handle this situation.
> 
> Fixes: d99fb64a98a power: regulator: Only run autoset once for each regulator
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
