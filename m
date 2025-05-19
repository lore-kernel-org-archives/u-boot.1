Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BBCC3DA6D
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 10:40:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C67BC81FEE;
	Mon, 19 May 2025 12:40:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="JXuHDmRO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C79FE82AB2; Mon, 19 May 2025 12:40:13 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::606])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD5FE81E72
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 12:40:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cdIYFeCZ6sGDqb5/XccL+S/YekZhiu7+fVoAXjp8WyxMtP+tIJaRtZ6CmgmmbnAclEwIQLsZKbjEZVcOyYnweGGXB59V/iXFsNi94E+kvgsNdTXxYCwSu9wWMAVu0jLRk1WoPvL4eXd4RqYSe//voPJpjOAjABpARFEf1enFN/IK5stdC3wIh0lWYgwytur6uwyzIlE4YySmMH7iwjoh5/FOBifqkiAVqk9m9TlIEzM6nUGERBNonqr3j9kqGmoj/jE/vSUke2KsFPuc5TWD8OfkC9TWbtp5aYVz2ufJeofg4b7M6RfnFnuiVyDBAVNW+Awpe0BSKyTOgcNdczS2Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCeExMUdTQRkRvNGG9t0CWdcDgCzZFgYNPs6Tx6e/0k=;
 b=kC4TnezTSTC+40D2rkTry2EZZxnnxndesWR4MqV9ygKomNxVpW1lDN8DcUe+OYvolRnIRPy84KQorE2ZhATEXwv3TFsxrOTGxfV92/MLGlckeFL0ruFjhW2o81KJg6aGdvkvBEsO+f4fOHIGs0c7DgY8go2CF93Ad6u9RxY5gGR4e//AFFEyPDC2qUiqZ9XEQMBfpQE/UeZSP34iiAAfmuTNq7sXXRyQqIpPnb1mfNbjAxusfobGPMmY+DHYEnMqdZNABLFEYh6CmsF0HLitiPJcCmHqYAYM0mjajo23TspcuEsrp6HxR6JXCHvYQXtcajbVKI5+BI2Q743oxiIeUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCeExMUdTQRkRvNGG9t0CWdcDgCzZFgYNPs6Tx6e/0k=;
 b=JXuHDmROyTNkCYMNQ2zXUvPtcUeAE6+l4l/rKObO4W+jxRGK3vOKdU7umsChERza2GkuH1hDmkUOX4nZtL/1T5vW2aoyseR53mREtYE9AcTR/L1W6YjHD/6V8wBvBodweP8uLpISO/dSIOGTwVz/sNkXDNkKZ0BQDnBgiVOleMw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB8095.eurprd04.prod.outlook.com (2603:10a6:102:1c6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Mon, 19 May
 2025 10:40:10 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 10:40:10 +0000
Message-ID: <df9d437b-5d7f-414a-a88e-d2ce0c25c05b@cherry.de>
Date: Mon, 19 May 2025 12:40:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] debug_uart: Replace debug functions with dummies
 if CONFIG_DEBUG_UART is not set
To: =?UTF-8?Q?=C5=81ukasz_Czechowski?= <lukasz.czechowski@thaumatec.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
References: <20250515-silent_console-v4-0-dec6c8391f01@thaumatec.com>
 <20250515-silent_console-v4-2-dec6c8391f01@thaumatec.com>
 <64515b97-1e4f-4e58-86aa-1cd5dc3de9ec@cherry.de>
 <CABd623t=qZLn35J7BdO9q-AyXHk49cPyf0uDOA7UQ0FL=oxM1g@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CABd623t=qZLn35J7BdO9q-AyXHk49cPyf0uDOA7UQ0FL=oxM1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA0P291CA0010.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::12) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB8095:EE_
X-MS-Office365-Filtering-Correlation-Id: ee5bb701-9c71-4f99-6adc-08dd96c1873c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmRFeWZnTW1XVHVldCtlZmxHYUNLM1RsUnVtMjJBQVJMbDkvYmZleVFUalRO?=
 =?utf-8?B?V3RYZkZsUEZna25zeW5LY0V1OXgzTlVJWDVNSzhGOUdUNUNoRWlEUWJMTFVV?=
 =?utf-8?B?MkwrcUNmM2ltUVBpMDMvVTlQckNuUmpNSS9lcnlldTlYempqdkxrczdCckdl?=
 =?utf-8?B?UjdKdzdvSXZ1dmtSOFhDSkVlTTliSWR5Y0FkWUtFc0g5MjBSeTFzZE83LzMz?=
 =?utf-8?B?WkMvQVhsMmhjSHlGNC9rWk5kOWlOTVVlQ1ZVSWFxTTRwVDlqWnk2RXFwd25I?=
 =?utf-8?B?a2w2TmxPUDM5ZEdRQWFIQXAydzE1QkE4VmVIVDNtbmRUYkZ5aFB5MWdhaVMw?=
 =?utf-8?B?dVJ2bGw0emNDRjBPYUJNYWFOR3ptZ2xBdTFpSGtvY09iL3JNM2QvNzdoT1E2?=
 =?utf-8?B?QkU0SEtGWUpwSllxTzd6ZzdUY2NaVEVxV2lLNEZqTDVCWEJiWEw0aUhuQXht?=
 =?utf-8?B?NExpOHVDcTRTNjRCNnhraks4VE11MUU4V0hxTzV4QWZiWXVadXNqMXZBMnRa?=
 =?utf-8?B?Y01USDkrMitQWDJhS3hLdVVoeTQ3MVhkSEh6akxHN0hxa2pDTS8rN1RaWlVQ?=
 =?utf-8?B?WkhQV29mMnZlS0s5MHZCeHFtMDJXeHN1cGgvYWU2bFdVRFk2YnJ0QnVZN2di?=
 =?utf-8?B?WVhTL0hmYURyUkdYWGxZUEFxcC8xUW94clZqTGxPcEQ3eUVqZCtJSVVQNSsy?=
 =?utf-8?B?R3JIckhPcXAxZVZYWlMwTmZZTXFDYjVTRUcyZmtadmxBaStnV1U5SkdtdEFF?=
 =?utf-8?B?T012Q3VNdnhpUHY4VDdPYVVac1BMeXlGUXhWWC80R3cxVldkdlk3QnNncDcx?=
 =?utf-8?B?RWZXUGk2VXlzYnlsVXdCWGIxUzlHNm5QbkVDdUh2dXpRR2NKOGk4L0NqTll1?=
 =?utf-8?B?V21QZG0vV1lhZGpWTUl6RFlqbndpY3dYc2VLRVJhQ0xiUXdWemRHK1lGcnA3?=
 =?utf-8?B?OCtoRTFLeFRZa3ZnVGErUGhZMVBYR1lFOGxjQXhGRmVlMHB4dDJuc2tnNTNY?=
 =?utf-8?B?eEkrYzZYSlNwMUF1NFN5c3M5SG43RTRBbWlwV1IzQ2tmM1BJRzJHN256bG1i?=
 =?utf-8?B?K09WNk92UlpWdGNKUDQ1ZmFjb2NvdkVTS0ZPcUkwRUNSZHVvRTlLTmRzTURD?=
 =?utf-8?B?N0NmTTB6NG9YUjNrSWRDS3pRWS9VbTZlVnFOTkFwazFDZjVhZkpVRGowRWI0?=
 =?utf-8?B?aEEyMjlUblpZaDM2OGJaN3F4TjlQeU1sd2Q3dDZ4Y0Joc3BPbmdtdS93MU5I?=
 =?utf-8?B?MWlmN2JvYXlhZ1hGSVVvbnRKNjFRdWh1VDhvVmVKMUErQi81QXE4OVE0cUth?=
 =?utf-8?B?NnFzUXBFUVJNZldkUjFPNWxlcGlYTW9vRWRJYjJseGk0TFRTT3lCTnJVS2Ry?=
 =?utf-8?B?cVpDMmNqRXYzUUUxN0VhRzBKQk40cU0yMHpsV3ZxcWJOd3lYcDdEb1FIWlFM?=
 =?utf-8?B?QldEM1FVTDdzMkw2YlpqY29ZS3FhalY2VkE5dzB3NzRLM3M2dkROKzdnU3pv?=
 =?utf-8?B?ZVBkTGpuUUFyeWwwRGg4VlllMlF4bC9ydVJlMFdDL2U5WVVGLzM4QmRkSFlt?=
 =?utf-8?B?WURSZVloeVBwK2ExUmtZZkZVelBCVGVwUWNpNWpqbEs2Y2t3bkQ4UmFNc25u?=
 =?utf-8?B?Yi9kUi9UVEFVOEg1VlU4VWJ2bkN6Z2ZuMnZBY2k0UlBVK1prcFlvc3VlQlBx?=
 =?utf-8?B?cEFJRmw5UjJWS0t0L1hlaWhRS0k3dEhPd29mVTVZQnhUU2x6OXJtWDIwNEh3?=
 =?utf-8?B?eU9LZ0ltMmloNkJTRkNXV0RjZGYzVjU0Ymx4SmpKNXRNZDZiSVpoNG5jQ1Vs?=
 =?utf-8?B?bG45OVBIMnJxUVpnZU1aUVBOVHdjZUgrbW13dlB3bVBKL0txZ0hrczV3Y0Fw?=
 =?utf-8?B?M0IrZmh6ZkZPYjFDbHQrT0NmdFZrTFo5ZDVGZmRhSC81WW41L3BhMXFqSUpt?=
 =?utf-8?Q?xLNHVlAQKlE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmQwL0txQjlvMlU2aXk1TllFbVg5cHRYWWxINzExdmFlUXZzRFFmM29WRzdN?=
 =?utf-8?B?QkIxNG15WllSWUFjZG8vSnB4dE11bXN2T2hZTEJaRXplVURRejlKZTlVUjI2?=
 =?utf-8?B?WS9qUEVhaGlXay9CR0phODRuVXdJekxONkxNaHVnSURDVFNZRXoyZ3BCcm02?=
 =?utf-8?B?cjZGSCtFbXJaZmFNOFFMSmtQemtOQUh0SmNpOUF6RjAvN2YwQzRrSjlzbDJP?=
 =?utf-8?B?eGNtZXhuUlhRdFNVL2pXQmw3VG9FVTZQb0dMWXhBUU4rRkNUaW5ZQkFvSmdT?=
 =?utf-8?B?aUV2SzJmQlgwT0pjaTQ1TUNvdGhLSVlVMGlCNkNIdGkrbk9aZG95bmd1VmFz?=
 =?utf-8?B?ZjJ6NmFoMkFUREt0MjRjKzVUMks2aUNHRkNvM20wTkEwSUMxUTdMN1dXNmR3?=
 =?utf-8?B?eTZlRG1YRmc0bi9WT1RvR2FpUzROd2lGa1dlSzZuaXYxdkUwZlB6eEJvTDI3?=
 =?utf-8?B?Mlc4SXBNT3pPUVpmNDhJN1lOVGtMRks3QklWYXdoT1ZITUxqblNZcU94WUEx?=
 =?utf-8?B?cGhUeHY4dTB0NDNMOExGblNFSVUrcTNSMmpBL0Y4S3AyOGtmOUNSSVRNV3dw?=
 =?utf-8?B?NGJTNlVCVUF5cW5GNnRJUThBKzhzUmFvUGlFRFdXZ3R5emhYVlRZRVdicXpI?=
 =?utf-8?B?VVVZOGx2a2ZwVHlJQVN0WE1EcEd5S0FJZVZyRWtpUlg1WmlRR250UkZzK2RT?=
 =?utf-8?B?MkpMUFRML1JDUWcxUjNjbEoyaVBja3ZWZVJtYkhJMmJjdWZOMWZ3UEpxUmlX?=
 =?utf-8?B?VG9hT2VCcThFdCthQ1NIYjBWRXZYa0xUcVp2Vzg4RmxrMU14NFpuRGRzTHFS?=
 =?utf-8?B?VFhNT1pxS2RYMm5meUZLQ1NCUzFiLzI4SnFud054V3FhTStCQ0E5Uk1Jbndq?=
 =?utf-8?B?cC9RaFdyc1dQRWRTMWNMVmNyUTV5RDROOTVXWFl2dFdNVHJicUd0SkZjWURy?=
 =?utf-8?B?bnRwVFAwajVucFlRK2JTckI4cjBmeFdzcmtsM0hwVElOSkJTcmRWWTVBbEh1?=
 =?utf-8?B?MDhkV3VVbU40ajQrMWZMYWhBT3ZFdDhQQmFqZEhJRVFKQ2xSTUdONVpXamsv?=
 =?utf-8?B?WmV4Nkx5eVFUSVNBZHpKSkFJblBIanVMaUN3V2NKdDJ6Q2RTUlR6dTJDd1RK?=
 =?utf-8?B?MHVtY2tEWGQwOTZjelRsRzZlcVJmZE1TaVI0cURjNFRNbWJmZkpBZEorNTly?=
 =?utf-8?B?YWRCNHNiN092SVZxMTdVZ1BuQUJnYmVsZ0oxTC91MUliMWhlVVhlWlo5QjZX?=
 =?utf-8?B?V1d0NCtjUUtZeVY3RCtGYnFEd3NGOHB2dmcxYUJBV09tWjlTaU5ZeFBXTWVp?=
 =?utf-8?B?dWgwRVZYSmUvYlBBeUZubDlOUWM4YzNoMUl2aVg3cHErMUp2VmNHa3FkNUR3?=
 =?utf-8?B?RzNmdEhuSnJqdmxoK3BTOXl5TzJmUzloU3dHSjR4czZLVjRzekI0WFJ0eHQ0?=
 =?utf-8?B?U0VFdTlKYzM0TS9RZmFEeGNqbjhaeW1PL2l4Zm4zZkRvNVhxaDIxZlNiRjFo?=
 =?utf-8?B?R1ZZRkNocCtYcW5OcVVUWjRyZFpHb2ZiMkpOUGNSZS9PRnh1MWxBVm9kNVNJ?=
 =?utf-8?B?NEx3ZU96NzhHN0twdmFKdW1tU1VXa1lQVXFVVjdub3h6d1VqTndZV2dwTmpl?=
 =?utf-8?B?NmZramhEMFdicEZ3c0tVUG04UWFmYUY3NDExM2ZVZnQ0QXlhR0lIM0JXSElQ?=
 =?utf-8?B?OHBsdURETXVuaWlSZng3SHQwallCY3pQUzJsc3A4bXd0ZFZlUUdOYVVCc2dw?=
 =?utf-8?B?ZUtJbW85U1p1dXorZ1RENjJZNUN6c0tNbm0wN3FhNGJiZ2YwclVXbzJDbzMw?=
 =?utf-8?B?SE5tWnhzUStyUXh1ZFVzQSs2L0pGazloWWJDMHgvbWFoYm8xcXNTdzNoK1hV?=
 =?utf-8?B?TDZGSHdCay8zQmdRWXg4S3RncmlaRDgvcmlZV0VHejVwZjVNSng4WTRHZ3hR?=
 =?utf-8?B?WXBnbVR6OHVmUjBMUWtoNXFLRTcrWkVaTEsyVUNjN0ZPQW1ub2xuQWY1eXNs?=
 =?utf-8?B?Qk5Xc0pROWRyNjFwU1laTnJkcU9KakxNRjlYbzhhZi9CbmxrUFNPd3huVUx5?=
 =?utf-8?B?ZUpGU1FMY1hWTUd0MC9Uczk0VDUyQm8rcVlURU5ZcXhKT0pCNmZKT2pPRFF3?=
 =?utf-8?B?MEp3RjdXSzJoWmo0ckRHb0lkY0lNL1pobFhwdEN3NWhnb3ZIL1k4SUY3dElH?=
 =?utf-8?B?Nnc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ee5bb701-9c71-4f99-6adc-08dd96c1873c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 10:40:09.9555 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ViUHFUX0PhomE+M/5aRWLF9w86czq2zbkm/7U2xhyp+iJBIzbqTlS72O2iCq6d8PxHd7dfaOiCqYmVXXrPhBsjeSPjT99bvz7rdiqksL9Mo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8095
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

Hi Lukasz,

On 5/19/25 12:32 PM, Łukasz Czechowski wrote:
> Hi Quentin,
> 
> pt., 16 maj 2025 o 17:27 Quentin Schulz <quentin.schulz@cherry.de> napisał(a):
>>
>> Hi Lukasz,
>>
>> On 5/15/25 5:55 PM, Lukasz Czechowski wrote:
>>> In case DEBUG UART is not used, define dummy macros replacing
>>> the actual function implementations that will not be available.
>>> This allows to compile code and avoid linker errors.
>>> Redefine the DEBUG_UART_FUNCS macro if DEBUG UART is not available,
>>> to avoid compilation errors.
>>>
>>> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
>>> ---
>>>    include/debug_uart.h | 15 +++++++++++++++
>>>    1 file changed, 15 insertions(+)
>>>
>>> diff --git a/include/debug_uart.h b/include/debug_uart.h
>>> index 714b369e6fed..4526dca24ac6 100644
>>> --- a/include/debug_uart.h
>>> +++ b/include/debug_uart.h
>>> @@ -128,6 +128,8 @@ void printdec(unsigned int value);
>>>                        (1 << CONFIG_DEBUG_UART_SHIFT), \
>>>                CONFIG_DEBUG_UART_SHIFT)
>>>
>>> +#ifdef CONFIG_DEBUG_UART
>>> +
>>>    /*
>>>     * Now define some functions - this should be inserted into the serial driver
>>>     */
>>> @@ -197,4 +199,17 @@ void printdec(unsigned int value);
>>>                _DEBUG_UART_ANNOUNCE \
>>>        } \
>>>
>>> +#else
>>> +
>>> +#define DEBUG_UART_FUNCS
>>> +
>>> +#define printch(ch) (void)(ch)
>>> +#define printascii(str) (void)(str)
>>> +#define printhex2(value) (void)(value)
>>> +#define printhex4(value) (void)(value)
>>> +#define printhex8(value) (void)(value)
>>> +#define printdec(value) (void)(value)
>>> +
>>
>> There are a few additional functions that aren't redefined here:
>>
>> _printch
>> printhex1
>> printhex
>> debug_uart_init
>>
>> any particular reason for not having included them?
> 
> Looking at the original code, _printch, printhex1 and printhex functions
> seem to be only used internally by other print functions, hence they are
> static (there are also no forward declarations of them in linux_uart,h,
> and I haven't seen any usage in the U-Boot code).
> 

If I haven't misunderstood how C header works, I believe the fact that 
the functions are static and used only in functions inside the header is 
irrelevant. A static function in a header will still be available in the 
C files that include it, even if there are no user of the function in 
the header file. I believe this means anyone who includes that header 
file and use one of those functions will have a build failure when 
deselecting CONFIG_DEBUG_UART.

> The debug_uart_init function calls are, in most cases, guarded by
> CONFIG_DEBUG_UART, so it didn't trigger compilation errors for me.
> Do you think it's worth redefining it for consistency?
> 

I think it makes sense, maybe Tom or Simon have another opinion on that.

Cheers,
Quentin
