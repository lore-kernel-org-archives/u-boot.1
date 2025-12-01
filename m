Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4520D116E2
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 08:20:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CF3B839FA;
	Mon,  1 Dec 2025 09:20:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ysoft.com header.i=@ysoft.com header.b="o7tnNDsm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC9BF83A2B; Mon,  1 Dec 2025 09:20:42 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9AAD839A5
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 09:20:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ysoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Petr.Benes@ysoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4KUQ5dbxfdxOcKJeysPpCI8TofiWPGEzpBHF9o6zSyJtwkKbQW5lQh+278K3sf09z/TWUXFMBge6VuiIqFWHTRKZ20j9IbEtFJRGXT5/7GhGbJg38a/MWYbWUxRQaZrIlp55tteMmebQi20xktjHfESKrQvryB1XfGOj9VUBzVDQq0yuwp5S/ZhyNfUoc3RAbrkPqvhcpELdYrki66qGXU36ACU3KEEYVS1mpB2bW//zXdDssKtZm0wo0zUGoEQGZJ5TY5c2qQ+8SUMSvTUcKaU7d61FQC4A5cOcRKESMVBq+/XzbRYML4ttP0QLxr6QNCt1TRlGRiugVk0nEGfGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnf1GyRE6xQURCXanyYzbEDg584gYDCHVfVRi7ESOtA=;
 b=x6kAulVaZpr2NPfvOTkvEdyMrY1bNGsEIeUfnlCl9pK8xdxh49rRyWpamORLaMGazH5FJVjx9CglTAPhjqHN29wS/0thD6cc+9IurXrpA4N9HsnobVRKfp4bRw4DhVGphjzX4l0wNNZ0ecM6apmS4v4XprWZS5sWUJphcao6HTfaHWADLKpvOXCgpUsU+cGRt9wTZbvhVIgSHZNbisCunHKnp9lxP8OeS3DcpzbGlgIshr/YBjFnVRBN6nKBHFTyRYe4u80jC24RJuygAoEzOK5b7VdmY0KzS1Sqeqli86S6wi0zSC4ArqgIXHijqQ0USvvrhdu3yA6aGHUMsvcsFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ysoft.com; dmarc=pass action=none header.from=ysoft.com;
 dkim=pass header.d=ysoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnf1GyRE6xQURCXanyYzbEDg584gYDCHVfVRi7ESOtA=;
 b=o7tnNDsmIKCPs/Rd2CDECuTG+dTvhPisXMgMFJW8jTGpSM+ja3M4KtT2RulDqJHLlap9Jzc8BecY/UtySLc217EdG2+oywEQe7wZMs62jgAlrOiwA3s4Fa5uO0sWdFnVD2xa8MXZr9TCR5lwYg6MqlCNXfrnhsLQ3FfRIXTHAGNVeEx/+Xs5N9/DJp55T1Y24HLm8288ZgFHmY+MjT/qvRGBdd/nDI/7PALrhY/y+K/Led1jdegmipFGgACx7ZB5Qn0aWvCwBae1hlW8kC+WDJCvrt3/+BHV8k4sFYv79JS3g5gBygjL6T8Ls2l49O5UEj6ICgrCHi0dRXuWWDnKog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ysoft.com;
Received: from AM9PR04MB7538.eurprd04.prod.outlook.com (2603:10a6:20b:2d8::5)
 by AS8PR04MB8834.eurprd04.prod.outlook.com (2603:10a6:20b:42d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 08:20:38 +0000
Received: from AM9PR04MB7538.eurprd04.prod.outlook.com
 ([fe80::e597:9071:d0c4:c01b]) by AM9PR04MB7538.eurprd04.prod.outlook.com
 ([fe80::e597:9071:d0c4:c01b%6]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 08:20:38 +0000
Message-ID: <45eb3702-466e-4e22-b27d-6710ac765dcb@ysoft.com>
Date: Mon, 1 Dec 2025 09:20:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] usb: ci_udc: Check ci_ep->desc before use
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Lukasz Majewski <lukma@denx.de>, u-boot@lists.denx.de
References: <20251125085846.507591-1-michal.vokac@ysoft.com>
 <87fr9zss1e.fsf@kernel.org> <6cc1b997-2713-42be-9b0a-dc44db251b06@ysoft.com>
 <87a506sg41.fsf@kernel.org>
Content-Language: en-US
From: Petr Benes <petr.benes@ysoft.com>
In-Reply-To: <87a506sg41.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: VI1PR07CA0293.eurprd07.prod.outlook.com
 (2603:10a6:800:130::21) To AM9PR04MB7538.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7538:EE_|AS8PR04MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: 78b44e42-5f52-4d11-ee5f-08de30b2825f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eTcyNEk3TndXZXlsWkYvMWdwWW45cGY0MTdNc1NDTVI5UnJqb3BUczRCR0N6?=
 =?utf-8?B?M0ZZYlJTVU9qNlpKZjdyQXRUR1REOERTYWhETWkwNXFwcVFQTnJoTytDbm81?=
 =?utf-8?B?Wmd6ZGNGa3NIaCt6NWt6MHBVVE1Rd3psWGFUYlJoVUlRVXhuc0xpK2REck41?=
 =?utf-8?B?Uk8zL29hdGxkQS90YmhHTDlVa3c2Rmg2eEIwdFV4dmxnSUk3bHBjeWN6WCtj?=
 =?utf-8?B?aWNOUTd0ZnNwcmdQOWQ4RHFtZ0ZYazlBQ1Q0T1pTYk1MWGduTFNKcnludTZ0?=
 =?utf-8?B?NUd5TXk1NTU0b204RXhwMGI4TCs3UkJQMHA4RTRhTjNwWk9jZzAzbHhNZ1Vy?=
 =?utf-8?B?V3p4UFdMbldqTWU3alVZNTJYNE9rbnIrcjN3d2dVNHNyZWJoQmtJNzNZU3FE?=
 =?utf-8?B?MnJUWjdPbzM2TFFtNDJZTnN5VVRreHNWTmREVGIzUFpPSDJGREtROWs5TDkz?=
 =?utf-8?B?NUNDb3hxczc3L1FOUnM0bDVyRjZUQzlXTE5XUnE2bm1jZjA5SjdUc3dxd2Ni?=
 =?utf-8?B?eE9LdEFSNkdNLzNLN3kyQjREM29TWENhaFN1eHdDNTAwYklaa2hEdlJyTnNI?=
 =?utf-8?B?RndsVXBsdmVTTnlCV0pOYTh4d21nN0thUHNvMHVwRDRvQzlpYkgzbXRUS3Q1?=
 =?utf-8?B?eHkrdXNYUDJHQ1lNWTV3OHIyL2Q2c2x2RjZmSDdLV2NLUTlmWXk4ZnRBUTBU?=
 =?utf-8?B?VXhGSysxdUVLUGtaZXNKN3M5OFZXWVJuMWFSRHF6QVNCUUFxK2VvTnVWUUFW?=
 =?utf-8?B?VTJYakdqbUNRaGdvQTNEVDduZjZnd1ZmbUpWOVRLVUFJTWpFNGM3RS9VWXNr?=
 =?utf-8?B?c2VleEZiaFZwSWlocW1GTCt1czVWdTNPcWZIN3NkMDlqQ2k1K3d5cmNybGs1?=
 =?utf-8?B?YlFrYk96ZURtS0kxbWJGaHA1Skd6SmxnU3RsTlFmWC81Ymw1ZjNBRlJzcVA2?=
 =?utf-8?B?VTVoVTNsK3JRRHdEL2tFNUFXV0F3OXpFdFZsUUkxUVBoUlduT3pVZjEwSmxD?=
 =?utf-8?B?cjExenRLOGc4TS9ScS9uK0hsczRBZk1jQ01XenlMSGo5UWVaYkdNWHZLVnZY?=
 =?utf-8?B?Q292Z3pNc0piVmlVd3h4czY0RG1Ma0t2eG5SRWwvZFkwZk9mc0t2bldiNjBX?=
 =?utf-8?B?b3I4dlhiU0twaGFZaFFwWDdsaTd0cjVpbk1LOStqK3dPcFRucEVZVzZCa0xT?=
 =?utf-8?B?UmJhZUdPT3ZYS3kwVkhDcjZWK25pZzRPbDIwdmRXQ0xTV2xmbUZkTXpQTkZJ?=
 =?utf-8?B?WG5FVzF3eWI0NjFYT0xkM29oOC9Ga0xpV3ZLNTRBaGRpNTZwTXVWSmVzb0xw?=
 =?utf-8?B?eWRTSUxGa0lFQmxpaEtTaW1FcDdybndFSU1HVUMrT0tYUUZNTzVWZVJZSGx2?=
 =?utf-8?B?aUpqNmFxUUN0WW1FUG1iVklDOGNySVVZd0E2OGg0YmkvaGRYL3l4ODJqLzdh?=
 =?utf-8?B?aU9FMC8wZEVtWHBSM0plbk1GbitqeXgvU0pGL1dQM3BBbG5ORURzQmhmNHFi?=
 =?utf-8?B?L1p0dnNYd0VtRVJnMVdqbFNWZUtUcWx1NmtESU9IekQxbnN0c1k4eXNCaDJZ?=
 =?utf-8?B?Zlc1VU1YOFFmc3hwY2lhL3pBOHA2UkJNUTh3eGQxQW1vdWVoaXRxZEcxb1pM?=
 =?utf-8?B?RzlZLzhCNWEwVkdXY3pHYXB2UnI4aUtjOFRWL1lyTjEyTURLbFlBS1RDV1hp?=
 =?utf-8?B?R1puM3B1d0NXYktTd2RFa0NpTyt4S1hxbU50MW5YTHdrc1NXMlhZbyt0ZkR6?=
 =?utf-8?B?NkpnVnd4aWVFQnRadVJEY3U4OEtnSHNMTVZmNUlCZG1aN0VwQ01Pb3dJL3pw?=
 =?utf-8?B?NUZxRGFRRDhKcndQYzdmVldYM1IvbnZxVldXOE9wNVhsR0xMQkVEVHVBbFI4?=
 =?utf-8?B?bTcvb1MwZFc0ZnZ1aklhemV2Z2NMcmNaUWNUdWJ2bCtFY2FyQ2RrcVA5b1hq?=
 =?utf-8?Q?bKqDH8/prk3zfq1socJBT+k+K7LzxUE6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB7538.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHR0RXpKbUF1S2ZPbTg3eTdLK3E4WDFjM1ZQWHZGYWRsRFo4SmJIdGw0RVFL?=
 =?utf-8?B?L2t3OG5LWHZUYlZOMnpERVBXOVczY21LbW5nRUwzM1NnU3BLVnF5Sy81ck9M?=
 =?utf-8?B?Nm0ydWY0cW1xZmtncEpxeHU2MmtpbC9ndFJSL05LTXdIVWRVbDdORjNGbFhr?=
 =?utf-8?B?M0xZYXIyTXdPeXhVTFZvNEp0dlBzM2Y0Wm1NejRON1R3S1d2aDdxUjhka0dN?=
 =?utf-8?B?MkZjUUIwcVZpdmIxdi91Rks3V25Gc0NMSE0yczQ1eTNNM1R3UHkrT1NsNkN0?=
 =?utf-8?B?OXllaS84bENlMzkxaEpxbTMwUkZ1TXl4MlZVSnhleDNSOEMrcUR4NzI3VzlN?=
 =?utf-8?B?YlJVSXgzc1d0UmZxMEc3SkVVWUluWWlPbU1VZEVTRFVpNy80YUMxQ3RUdW5x?=
 =?utf-8?B?UWNTcGYza3ZIelBORmtwN0JHYnJCSk1YdUdSbmtlWi9LeWgrQ3ZrczdaTWxo?=
 =?utf-8?B?c1BVQjMyNzNqNGJTVGhaN3g3Wk1WV25Sb2g4REdrMVcvYlQxUVY5SEd3aldh?=
 =?utf-8?B?dmpCdzVzK2ZtbW4vSzc0YWt2ZWxXWFgvNkdvMXl2U0xQVHRIOFphaHdpdGQy?=
 =?utf-8?B?YlFYVS9qamZmOHY0Si9aWHFrWTMwNEp5aFZmQTdVTHdpNXpUOFo0SmpZYWdr?=
 =?utf-8?B?Nks0elV4dmE4d3Nrc21ERWxBd2Uyai9PaWtEYkhSekpiR3cvdTRYdDU1VE1I?=
 =?utf-8?B?RmFLa3dwNEVva1diOTJZNm1DRTlIYWUxZk5pUUhhcHdManFnZzdyVFdGZU45?=
 =?utf-8?B?eVNTdDVwdXV2bDNqZVBCUDFtYkRrM2xwTFh0STFUNUhCT05CN3BoSEpWbEVm?=
 =?utf-8?B?V1UwcXRUMXU1Vm4zeFpXbWdCRFJncCtDTmJSTncwckFyVERKQndpU2JnWFh4?=
 =?utf-8?B?dVBJMGFQWk0yL1JEY1lEaEZJVGhBcnZJMnpETzF5UkJucHRwYkl4djRCMWUv?=
 =?utf-8?B?eEF6WWV0SEZ6TWFaUkxPWEpYbGEva2FQdXZiZVF3TjQxd2tRYTlZeEkySi9F?=
 =?utf-8?B?WXR0QWlyS0RPN3YwRlNGMkZNb0UzUW9WaGlYUjNwb1oxMlFES2tYeGZ1WERI?=
 =?utf-8?B?c1lGenlVbnNYUGkvUG82bkd2YU55R3hMbnlrTWZrRzlnM3IvRWlnVVlWTjUz?=
 =?utf-8?B?M1hlUlBMK1E3dFFzeWlzODB0Tkwrb1Q1aEhpRzJaaHdSUnNmZHVpS0VZcnFC?=
 =?utf-8?B?ejRzeEFJZExzbm9FZ3k3aUZOdkZOVVBXL0VsWEU3OS85dUJFOVNCdGdicE5i?=
 =?utf-8?B?Qy9vWm5kT1BxOVp0eEZ4Y2xzSi9TQ3ZIM0srV0lQYVJoMi9Wejg2VlhHTW5u?=
 =?utf-8?B?d2w3OCtCWUpFamUwb0pEbEQ2UkhZNXFqOWpCZWtjU0NvRVBaVUs4RzlHS3g4?=
 =?utf-8?B?TFlSRTJRakNjZ09yTm53QVpkckFGVUhidkdQVU0xUDVjaGUrUlpsdnhYVGVn?=
 =?utf-8?B?WXk3UWJ5aFl3MFN3R2xxTW1SanJGRWFoeHJKalA5RDBXNVlQbkM0aFJyelVk?=
 =?utf-8?B?UHVMNElIaW0yZ3hjZ21VemlKOUVJRmg1eGZTUVQ4MlJvVXZENUZRS0U3V05i?=
 =?utf-8?B?dDJUbGcvbVVjNU5yQmJjaGJNS3h6SDNyZDZDVGF4eXlmbDkvTUFlS0VBcVo5?=
 =?utf-8?B?NlpwdzNrckZBWk80b3F1dzZxUnV3RUwwanBqTEVvd2YrQkNGc0sycTZIS0Fn?=
 =?utf-8?B?ODdMblFPNm9zOWVkaXYwQTRKdldpTUo2akNlUVI1a2NvbXpUVUovdVRQMnlw?=
 =?utf-8?B?UmxNOGlnWitVUlVjY09ZcFJ3NGZickFCdjg3TC9EWG9UNnd5cUpSUVZCTWRV?=
 =?utf-8?B?MEdSa0g0WGtzdTFzZS80L1NVWjRjNm4vMmRCcUdWVUIyTjZVRnRiZkVNUmk3?=
 =?utf-8?B?RzZJYTd5OGlXSE9IaGFBUTczYjdpd3RUNFpWNDBrUTFzamlybm80Zkx4d2dM?=
 =?utf-8?B?YmlTOHlEWGpJNnNPOG9BWU5Tbzc5clJyekc1WEtxZ0JreCt6UWJlb1R6TEhI?=
 =?utf-8?B?SFMwakFpaGRXMHEvcmlRWGJleitTaW0wMUtjdGZZcDVveGpEbWR4NndLeElW?=
 =?utf-8?B?UFFBTXpDTlZLbk1MRFpyVXptMjlET3RLRDNoYzJXMk5DTWFLeCt3RE5rbVl3?=
 =?utf-8?Q?5E511p4SBtH9dl0tFfW20RmTi?=
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b44e42-5f52-4d11-ee5f-08de30b2825f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7538.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 08:20:38.4316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VZxIytpqVxR25/Ig0YCmzfNYxcEcMTGo59EWXh+EzT5UVIO/6vXpLcayDNuGLIOiWotDAPqAVqwe8APtd7TGBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8834
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

On 11/28/25 9:42 AM, Mattijs Korpershoek wrote:
> On Thu, Nov 27, 2025 at 14:44, Petr Benes <petr.benes@ysoft.com> wrote:
>
>> On 11/27/25 11:12 AM, Mattijs Korpershoek wrote:
>>> Hi Michal,
>>>
>>> Thank you for the patch.
>>>
>>> On Tue, Nov 25, 2025 at 09:58, Michal Vok=C3=A1=C4=8D <michal.vokac@yso=
ft.com> wrote:
>>>
>>>> From: Petr Bene=C5=A1 <petr.benes@ysoft.com>
>>>>
>>>> There are two places where ci_ep->desc could be accessed despite it is
>>>> not valid at that moment. Either the endpoint has not been enabled yet
>>>> or it has been disabled meanwhile (The ethernet gadged behaves this wa=
y
>>>> at least.). That results in dereferencing a null pointer.
>>>
>>> I wonder if this is not a generic problem (that ep->desc) is reused.
>>>
>>> Looking at usb_ep_enable() in include/linux/usb/gadget.h:
>>>
>>> """
>>> static inline int usb_ep_enable(struct usb_ep *ep,
>>>                                   const struct usb_endpoint_descriptor =
*desc)
>>> {
>>>           int ret;
>>>
>>>           if (ep->enabled)
>>>                   return 0;
>>>
>>>           ret =3D ep->ops->enable(ep, desc);
>>>           if (ret)
>>>                   return ret;
>>> """
>>>
>>> Can you please explain why the generic code is not enough to handle
>>> this?
>>
>> Can't speak for for generic gadget stuff without preparation. In this
>> case it is solely ci_udc who does the mess.
>>
>> It works with its own
>>
>> struct ci_ep {
>>          struct usb_ep ep;
>>          struct list_head queue;
>>          bool req_primed;
>>          const struct usb_endpoint_descriptor *desc;
>> };
>>
>> Which are held in (struct ci_drv).ep[] and the problematic code is
>> ci_udc specific.
>
> Ok.
>
> I have compared the changes with the linux driver
> (drivers/usb/chipidea/udc.c) and see a couple of differences in error
> handling
>
> For example, in linux, in ep_disable(), we return -EBUSY instead of 0.
>
> 0 seems to tell the caller that we sucesfully disabled an ep but we did
> not do anything since it was already disabled.

Fair.>
> Can we do the same error handling as in the linux driver ?

Sure. -EBUSY seems to used mainly by *_register_driver(), I'll test it
and return with the updated patch.>
>>
>>>
>>>>
>>>> Moreover, the patch gets rid of possible outstanding requests if the
>>>> endpoint's state changes to disabled.
>>>>
>>>> Signed-off-by: Petr Bene=C5=A1 <petr.benes@ysoft.com>
>>>> Signed-off-by: Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.com>
>>>> ---
>>>>    drivers/usb/gadget/ci_udc.c | 43 ++++++++++++++++++++++++++++++++++=
+++
>>>>    1 file changed, 43 insertions(+)
>>>>
>>>> diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
>>>> index 4bff75da759d..b3bbbb6ad32c 100644
>>>> --- a/drivers/usb/gadget/ci_udc.c
>>>> +++ b/drivers/usb/gadget/ci_udc.c
>>>> @@ -308,6 +308,27 @@ static void ci_ep_free_request(struct usb_ep *ep,=
 struct usb_request *req)
>>>>         free(ci_req);
>>>>    }
>>>>
>>>> +static void request_complete(struct usb_ep *ep, struct ci_req *req, i=
nt status)
>>>> +{
>>>> +     if (req->req.status =3D=3D -EINPROGRESS)
>>>> +             req->req.status =3D status;
>>>> +
>>>> +     DBG("%s: req %p complete: status %d, actual %u\n",
>>>> +         ep->name, req, req->req.status, req->req.actual);
>>>> +
>>>> +     req->req.complete(ep, &req->req);
>>>> +}
>>>> +
>>>> +static void request_complete_list(struct usb_ep *ep, struct list_head=
 *list, int status)
>>>> +{
>>>> +     struct ci_req *req, *tmp_req;
>>>> +
>>>> +     list_for_each_entry_safe(req, tmp_req, list, queue) {
>>>> +             list_del_init(&req->queue);
>>>> +             request_complete(ep, req, status);
>>>> +     }
>>>> +}
>>>> +
>>>>    static void ep_enable(int num, int in, int maxpacket)
>>>>    {
>>>>         struct ci_udc *udc =3D (struct ci_udc *)controller.ctrl->hcor;
>>>> @@ -335,6 +356,12 @@ static int ci_ep_enable(struct usb_ep *ep,
>>>>         int num, in;
>>>>         num =3D desc->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
>>>>         in =3D (desc->bEndpointAddress & USB_DIR_IN) !=3D 0;
>>>> +
>>>> +     if (ci_ep->desc) {
>>>> +             DBG("%s: endpoint num %d in %d already enabled\n", __fun=
c__, num, in);
>>>> +             return 0;
>>>> +     }
>>>> +
>>>>         ci_ep->desc =3D desc;
>>>>         ep->desc =3D desc;
>>>>
>>>> @@ -385,16 +412,27 @@ static int ep_disable(int num, int in)
>>>>    static int ci_ep_disable(struct usb_ep *ep)
>>>>    {
>>>>         struct ci_ep *ci_ep =3D container_of(ep, struct ci_ep, ep);
>>>> +     LIST_HEAD(req_list);
>>>>         int num, in, err;
>>>>
>>>> +     if (!ci_ep->desc) {
>>>> +             DBG("%s: attempt to disable a not enabled yet endpoint\n=
", __func__);
>>>> +             goto nodesc;
>>>> +     }
>>>> +
>>>>         num =3D ci_ep->desc->bEndpointAddress & USB_ENDPOINT_NUMBER_MA=
SK;
>>>>         in =3D (ci_ep->desc->bEndpointAddress & USB_DIR_IN) !=3D 0;
>>>>
>>>> +     list_splice_init(&ci_ep->queue, &req_list);
>>>> +     request_complete_list(ep, &req_list, -ESHUTDOWN);
>>>> +
>>>>         err =3D ep_disable(num, in);
>>>>         if (err)
>>>>                 return err;
>>>>
>>>>         ci_ep->desc =3D NULL;
>>>> +
>>>> +nodesc:
>>>>         ep->desc =3D NULL;
>>>>         ci_ep->req_primed =3D false;
>>>>         return 0;
>>>> @@ -606,6 +644,11 @@ static int ci_ep_queue(struct usb_ep *ep,
>>>>         int in, ret;
>>>>         int __maybe_unused num;
>>>>
>>>> +     if (!ci_ep->desc) {
>>>> +             DBG("%s: ci_ep->desc =3D=3D NULL, nothing to do!\n", __f=
unc__);
>>>> +             return -EINVAL;
>>>> +     }
>>>> +
>>>>         num =3D ci_ep->desc->bEndpointAddress & USB_ENDPOINT_NUMBER_MA=
SK;
>>>>         in =3D (ci_ep->desc->bEndpointAddress & USB_DIR_IN) !=3D 0;
>>>>
>>>> --
>>>> 2.43.0



________________________________

CONFIDENTIALITY NOTICE
This message is for the named person's use only. It may contain confidentia=
l, proprietary or legally privileged information.
If you receive this message in error, please immediately delete it and all =
copies of it from your system, destroy any hard copies of it and notify us =
by email to info@ysoft.com with a copy of this message. You must not, direc=
tly or indirectly, use, disclose, distribute, print or copy any part of thi=
s message if you are not the intended recipient. Y Soft and any of its subs=
idiaries each reserves the right to monitor all e-mail communications throu=
gh its networks.
Y Soft is neither liable for the proper, complete transmission of the infor=
mation contained in this communication nor any delay in its receipt. This e=
mail was scanned for the presence of computer viruses. In the unfortunate e=
vent of infection Y Soft does not accept liability.
Any views expressed in this message are those of the individual sender, exc=
ept where the message states otherwise and the sender is authorised to stat=
e them.
