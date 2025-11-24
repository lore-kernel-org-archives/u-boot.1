Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D3B4CFA466
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 13:45:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFC0583BEF;
	Mon, 24 Nov 2025 14:45:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="J8toSQwQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A035383D85; Mon, 24 Nov 2025 14:45:08 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 505A483B55
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 14:45:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pd4vtmSpgEaRoqx8GFV94yyousAmRQ/wNYaKYHconlt+k9b5lTatHcocs1ZZgkTfHMSW2tpaA8JOqc2WavmCJd0FW/P6QcOCFh3R4LfCvyrWXyAriInRugM1ml1COj5OJy4sF8cSgFXINYZAqMqfVsi9smeCHrB9g7DaHPje4pN6gnyAN0Mt8VCIdIozBrer9+Mmg8uuuJE6tCkMCGIekryBnc5nshLvLXJISkxSuAQ8m1vBdfilSKb9MZzN0nuRRWn0itYKqnrY8jR1GPoNYaWVm5rBqn85JFlfZudXZKi040vLNVDKYt19s56h4MwPUo9iUZgniVF+bY/BTRJHkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2sz9o6sB4VuXB4vGQL7Bry5ddRwTfIVSNPk4UP4O2k=;
 b=nokF4hYM2Ty/PtJap4nNw53IUS5JVmoHNM7z1Hh/hFQqnXBxkWqZR7Iu6oSsckJ9Y84QfYDyjldCAh1k6TdCmDQp9kg/yN/ZHISB6pocUtuaB+XtdIMHAnMcgrGdhAB+MS/oGl9WzsPyw11G6CJDIq7Dz8r00bbZpasPsTxx9EMjw7I/srkMDk6ymB9nIWMnraNIjA3gA01OH225QGCWVp+KYx4gVXpB73PmHN6Yng6lwEgYWw3PRjVmkNl0BcYq1pTz+OzK0tH9FSBjzu3d2z2umQvfpivUuiDT3gH4hfesoaOUq3iTZ+ltEPpG2s5v63zONr9lEbYnYZhq7C15qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2sz9o6sB4VuXB4vGQL7Bry5ddRwTfIVSNPk4UP4O2k=;
 b=J8toSQwQxZN+2wOFrqQjgnCqLuZrlvabCCJYL+wZdRyeAs1aZuCqvE1Hn72xl1g3brnzdpL0rH3byZHrZeQh+nucy7hWIAyR99iUqnNsvmAqmyq7nwzqumTjZu16OC2hpaWly8UHQzNERznv8JLZI8NdizjkSHCKbXondtg7YXA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AS8PR04MB8754.eurprd04.prod.outlook.com (2603:10a6:20b:42d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 13:44:58 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 13:44:58 +0000
Message-ID: <27fc092f-36e5-4f20-b8b6-c25e529fbe2b@cherry.de>
Date: Mon, 24 Nov 2025 14:44:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] SDRAM Calibration Failed fix for GEN5 SoCFPGA
To: Sune Brian <briansune@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20251115113118.783-1-briansune@gmail.com>
 <CAN7C2SCQQ62=e6FEVW=jrLSj8hoWjDxUWMjQGohrpaeYjY-W9w@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAN7C2SCQQ62=e6FEVW=jrLSj8hoWjDxUWMjQGohrpaeYjY-W9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0019.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::23) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AS8PR04MB8754:EE_
X-MS-Office365-Filtering-Correlation-Id: b06deff1-1ca4-4855-9e44-08de2b5fa870
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MXJDQzVqV1hFclRwc1k5TkR4bjEySFNvWkp0cG5Nbm5pNXZjWWxJaTNqQXVr?=
 =?utf-8?B?WGJMR0ZUTGRNSnYyUHY5SWhlNFltWU9NNkk4djd4amsrQUZXOVluNzFQOFVZ?=
 =?utf-8?B?SzcxbzNjZ0h1VWV6alJrVm5MbG9SbUZXNW92N012a1hGM0p3dWpONTloVWZI?=
 =?utf-8?B?L2d0OUZ6SHZNYWtpWjJQSE4vMUNtbDI0SmQyZ3ZqN1BPSS8rNHRqTGo2ZXRX?=
 =?utf-8?B?VEVmMkFkZXVHTmhmOERXWmRFZjFYaGxlWWNDTzFLejFHTUtCWExLbUlTTitr?=
 =?utf-8?B?Y0F6R2lRaU5kTDJYMnB1RExwNmwyNHNjQ2hrQVU1SWRUaTlaZ21pUXZCNjNk?=
 =?utf-8?B?WTVJT3FyQlJ4YnROUGZLQTVxcmtETldjeXFUZFFtVlJIcmNIbW96THV3dUpD?=
 =?utf-8?B?YWpPcGRObUJvdEhETjJqMjdsajlxc2pONlB5eFF6VENsQlBpbHBvVlRPUVZM?=
 =?utf-8?B?eWVXRUg0bjBXaG1OaWpGbFB1RTlBYXRINXhDWitSWG8vZWErV0ZNQmVxdTRN?=
 =?utf-8?B?ZmpFQVErdTJrL2NjaUp2Mm9tRzY1M3lHckNEL1BiMzhoQUR6UUJvSW9wRUpS?=
 =?utf-8?B?Qkp6eEVocEZHVWtMelFvc2NES3NENG9kUmNIdktiaEVuckdSUEZhRzhFcTdt?=
 =?utf-8?B?OThnS3ppTHdpRDc5MHF3Y29vTXZnUlNIYXNCNEFxZk9oQkVrUUNJRTBFd1FM?=
 =?utf-8?B?bjdLTUN4dVJ4eU9uTlY0L0lxWUR4VDVDTW9WNGg4QkRqRTN3bVF1MUxlcGd5?=
 =?utf-8?B?aC9JS00xdk0vM1V3TDV0T0VIY0ZNWTdZMlRmbHZkbmlwVnhzc2ljTm85OGl4?=
 =?utf-8?B?czR6ZUVDNUFncXZCQWxuNG5jejh0QzZ2ajdFN0UxSUNEUklBUThDMVlNWXJ4?=
 =?utf-8?B?Wm5iZkRlRURReWZCQ2V4MGhTUVFFWXdkUFU5K1gxb0xjN1NMR2hZU1dOczdl?=
 =?utf-8?B?dG4wYjZkdXZhb3hEWEF6RXZIQWpaYWxoOHRPL2ZXak9uMkRIQnc2U3BxZ0JR?=
 =?utf-8?B?MEdoWFhVZjJDMGhTblR1VlFwMjdhTHhJTzJPRDNzaUhvMCtrVXhKZWFyZjNr?=
 =?utf-8?B?ZjVzaWEybjFnVUpESmZvaFJnRThSZ1Y3NFJhM1h2ZkxCenRERS81VFMrTFZE?=
 =?utf-8?B?cHdaNDloL09aZzd5MWptU3Nmd0habUhwRWtMZGVRa2wzNDBsaW5keWV6cmZG?=
 =?utf-8?B?V05jcU1JZzgyWXUrOGFQaG5LVS95aUxZdFRHM3dWbUZwd3Q3NDdKRGc3VHZz?=
 =?utf-8?B?U1VubHd2UkVnMEV3R1hTWEJmQXFZRXhsZUxWb3dSRmsvN3NGR0NaL1JKV1lY?=
 =?utf-8?B?WnJ2Wks1NG5EZUVKRXpFWFBvc0tWZjl6KzhOQmxWQTVmc0F1ME5SZk82MUdz?=
 =?utf-8?B?cFY0Vm93WFBnR05rL0RSZTVTT0lSRjl5eHFKdWc4c0x0VzJKbmxacUJET2U2?=
 =?utf-8?B?aS9xbVZHTFRpM1NSK2kra2Y0dklPWUFRZlA2cVZpd0pIZ1FqSG1TOXhnbE9F?=
 =?utf-8?B?S29WeWxyZHRRTTV1dURUS2hIbkNvWWJxK0ZwVmswc2JMVE9XeUpVSjZJQzVQ?=
 =?utf-8?B?MGJZQmNWa2JqVXlXSDA1Zi9NK294azdKMXd4SlQ2dndFdXVqMUt2Y0g5ZFhS?=
 =?utf-8?B?WXdNcEU5cDh5KzlkRFJnZzg1UWJ5dENLaU11S1M2YmltZ0tQQmVtQ1JCbUxv?=
 =?utf-8?B?NGU2UlRZaDZXTldMZkZ6WmxBeFFEVjZEejE2aUxTTll1dFY0em4wb1o4cWFk?=
 =?utf-8?B?TGpocVFYWXdMNXkxTmhOeHllRUExbnUxU0Ywc1Q3QTNoSHJOanRCZXZZOUsy?=
 =?utf-8?B?NFFzVXJJUEZnR0pEaUtQUnc0Y2RyemFjWFQ4bGxka1V4WUxiZXJ6Tm5TM2tR?=
 =?utf-8?B?cFY3NzJ6R3VZNXdEMDJNaFcraUduMzZEUUp0OHZFR05HUjVxQ2g0MjFheU9B?=
 =?utf-8?Q?GiiBrae+ouC0Dfw9FiUUz6huaDFYPty2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHNJaEoxTVZOQm1pWG95Ri9BbE9oZmxiWWRhWms3eC9jUjhBNVNzS2k5VE1i?=
 =?utf-8?B?QTNMb25VQmNKWWNZOU9DM3ZBTVRhcUErVUgxcUovVnVsTkhNWTlQeit4NGpW?=
 =?utf-8?B?cUxiamU3TlRtNmJpcmNpVTdWR3pIVm13VjZ3dXVwL2EySkc4Rmo5U0xtb0N5?=
 =?utf-8?B?Z2xTbmo0dUZDOXJaYWs4WWdid0VwQitualdHSGlPWlFxZFE2N2xKUFFISS91?=
 =?utf-8?B?bElYT0YzcnFJZCtzY1dyMHpCeG8rVGNDU01QTXRkOWVTYlJWWnRhMGZQRFZF?=
 =?utf-8?B?dk5Xd2lrWC9lZ2phV3ZWSVU3Z1hTQmxBR0ZMNWpOL0ZMVWIwVHpqMm1oU05U?=
 =?utf-8?B?RHdoV1dtTUhVK0lrK2xFbll5enRxd255ZCtsd1dkYzFkR3d5NUdsR1J3SlZq?=
 =?utf-8?B?UEg4TzJocnFGUnBRcDJmM01QQjNKNGpVZ1h2K0d4YnozZm1zUVpHSzV5bVNk?=
 =?utf-8?B?aThaVDhrejlFVytnTGEzMDlpZWdqS3hLMXlwN2ExVndrbnNvc3BPdnFDQ2Uy?=
 =?utf-8?B?K3JSbEdhdzNrYjgvS3dGWTdHVFVBQ3o5bFZSeGJ1N1dvVFU4L1dJSTRqOFdT?=
 =?utf-8?B?YXNXRWFwL2VxR3NMU0cxTFJHS0l1ZTAxaDVHZFFqclVoSVN5YzFRclhqZm5J?=
 =?utf-8?B?bnU4QkMyZ2E1bVkrMVZlam1tNGd0NEJXOW8xK254RFFCT0haRHk5TkE1N2x1?=
 =?utf-8?B?WUdBTytaOHg1c3JOMGsyWEZWZ1ZTeVhNQmRJL1Z4Y1FKSG1Ra0sxQXJJbWRC?=
 =?utf-8?B?Z00zYjA4VVNFZWlJblM4K1VTbFppUWdPMm9mUC96L0llWnFpWFdsNkh2aXFE?=
 =?utf-8?B?YVM0eUtNTGtKNER4VnpCYlFnUHZBcUJnOHU5QTZ3NCt6cE1tS3ZDd2ZHbXBO?=
 =?utf-8?B?QnZmYTVtem1zN2lPYzduV3k2aEtlbnFQM21hU3FsUUdYSUQwaUZadGMzcjZz?=
 =?utf-8?B?QkZlTG9kQlp4b0N0UjBzbGJLV3YwSVBOSzhWRmZFY28vL0lwcUJGd0ZoZnp3?=
 =?utf-8?B?Z3NLQ2hUSWVkd3BxZUFjZkZSdTloOW5ILzMweGgzZlRWNExvYjE2WjNpZzJr?=
 =?utf-8?B?U2xxSXlNMmExOVl2dm1uOHc4VzNhVUd4NUxteUwxWVRaL1R1aEJlcUVkTS91?=
 =?utf-8?B?T0FDRXVHbnkzL0Qxdk9FQk0zZEVNdE12UHlqQUdwYzI5bUhJN1RHOXpyVGk3?=
 =?utf-8?B?dU0wWXVYNkdBNXRkbTZUSWVVMVNGWmRXNXc0dHozUzMzRHNBQUFMYmxHMklZ?=
 =?utf-8?B?MVh3TDc1dVNzaHRiMkNQa3hpbzczZUVSWDZlRTJzU3hLQXUxeFVlQUMyakhz?=
 =?utf-8?B?djRJOUhsV1dvVjRDR1lFMWpWenI2dmJHYURXVGpMWGtEUlgyK1dmaDgwNHNt?=
 =?utf-8?B?WHlqcCtkNWY2MkxpZmJlWTFpdDM2cGp5NnpocVNyRWxITUJ1L3BRZFpocjVY?=
 =?utf-8?B?RTU4OUtpZElTS3RncFV4YzY3U2tyV3ZIcEtWaHp6Yi9UMVJGWThHeWttMFRa?=
 =?utf-8?B?WnpaRWxqSDdyRTRkcHdCcEdMR2N6SXdTUGgzNjRQcDIzQVp1Uy9CcGNPQkto?=
 =?utf-8?B?bUJ1aTJ6aGFYMWZWWGxkZ3RzV0Evdk1iTHlPTXUreG45NHJBSmF2TGZSNUdX?=
 =?utf-8?B?cENkTUNrZitkcHFQMEkrSVRES3JsZDNwOGpZZEtVU3hBcmNONU1SUk80RUpU?=
 =?utf-8?B?d1VVR2xPdHEvUEJMMFNpMWxXdGszaFU0OVF5OStYdlU4QnNMUTFTYURPOFZz?=
 =?utf-8?B?ZEk0QjJkRUpQUjhmZWdIMlIwTkFiWThWMGplRWlmRi9UVHN1UVQwTWUvYVZ0?=
 =?utf-8?B?SWhxSWRnWDVGbGxiQk5PRlF6T3A2eXpObE01SE9HTUVMOXEyRXZqTmUyWjMx?=
 =?utf-8?B?M0sxMnpUL2dDbWxyRi9Cdm9OOG1POFg1L0Z5ZjdkQUZ1bFpTdDFWSVE1eWpN?=
 =?utf-8?B?UFduajFrRDZ0RlFVTnBPaVZEckh2MGJ1Kzl4cVBTVWpEcmpLaWtyUlZkbzZz?=
 =?utf-8?B?L2N6NG01YUw3ZDY2OGU5R29GQWM2bjZTVGR4c1RXMFo4UkRTb0NTM3J6OEdK?=
 =?utf-8?B?bG9UWGZSWG4xQkc1RlpQK1VCVGdmZ3lkQ2ZiTkVRRUY4eTBZcWJnWGtEZnc5?=
 =?utf-8?B?THd3MG1rRzQwWGZDaXFtY2dpTUFHM0ptVWg3VHFZd2tjRzhPLzBwMjZBc1B3?=
 =?utf-8?Q?cW8VlaUeFaQyWGHXx0EnaYE=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b06deff1-1ca4-4855-9e44-08de2b5fa870
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 13:44:58.2385 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ww6xXWsutiGUxFEIaNr2iILfE5LZ3yYXo5Aib97poh/DwDKKUkSPQHzYVkD1ohtq2Yt0nQJsBzj0W0UtGVQe2+2nae5OwhiDIjLWNRbBRpQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8754
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



On 11/15/25 2:00 PM, Sune Brian wrote:
>> This is a quick fix to stablize what
>> currently users encountered bootup stall.
>> This fix is found under board boot trials.
>> No logical code can be explained why it
>> fails the SDRAM calibration but applying.
> 
> A bit follow up on this patch.
> When user turned on the watchdog on
> u-boot-xxxx.dts while having the original
> setup triggers the SDRAM calibration fail.
> 
> While users those do not turn on the watchdog.
> w/o this patch could be fine and not sure
> what is  the proper way to link the dts and
> watchdog driver accordingly.
> 
> Always included the watchdog driver should
> not be harm (correct me if not).
> What the dts does can either initialize it or not.
> What w/o the driver and dts setting to "okay"
> does break things.
> 
> So Tom I am not sure based on your experiences.
> Always attach driver and leave dts to do the job?
> 

Device Tree is representation of the hardware. Is the watchdog present 
in hardware? Yes? Then status = "okay".

Ideally, the board shouldn't fail if watchdog is enabled in DT but not 
the driver (and vice-versa).

Do you know what the actual issue is? Why does it fail when watchdog is 
enabled in DT but not the driver?

Cheers,
Quentin
