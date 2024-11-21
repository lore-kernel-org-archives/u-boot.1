Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E3CD6ED02
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 10:53:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3755A8972C;
	Thu, 21 Nov 2024 11:53:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="j7idWbat";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB7DE89733; Thu, 21 Nov 2024 11:53:14 +0100 (CET)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98B2D89706
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 11:53:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPskhJlqFVC+If61nDQ6bG3kpV6zwXcYJVBm5WACOwQLURkeKq/lBAq9i3dQzQynarHPJiMnojWBgQK8qENC4U1neR9Dmsm41jxSPB/4XvRpVPzkzAHahfd56kHDQSS5oxzH8exxOM+ttkSeREQz+93sPq9f5kUW1xIGT+bCGTCTIdDYdEFPCnlqGFDV/BP95tiD5a91qNU5kQ/Ti3vZE0OqIvrcBlpIQfkyfQBAS3dOnSwQvWBuZAZr9tU92t0f8EyvDoHEp3nSMC/bp9cZSvjitsAyZ/2KI6OcbfLLMF8Ded2pWgIRrnUobSgUx2pIlsZFdBwE6T4CMuYBef8/FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KE2USuNn1Y1NJ2LPsp/yY9gwi2Bk85jzGdLwPBDy5Eg=;
 b=pEvonGI5FnplHTGLm6F5Mv/+cwJnPaRfK7nOspnr2hiKZDdMItqlKfdhGW2rDjCSuuw7EJEjQyr7r/lS+RQTO3RxISBziXaCsmN1yS/gNNVsoLBfus2ZHiWjH1R61DKejGhdXXvIiH3cGCavuQ9ZaqV3V6/opyr2oS0x3VcNtEpbQK8QTQk1aqQfLy5H4NczDEHZfl4r7Cvp1nJQs4sQ4pXr7XoC/x1Ejzj0ParLYjoULSI+OKCUJp24weAYbnZijCzWuZmNWDjWN+Sod/dBBvlg9lNHJimv4aI8CtFYRTk2s7/pRnQO3r7aeELyhjlfOVcVFni+kI+5DJR/7B8JNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softathome.com; dmarc=pass action=none
 header.from=softathome.com; dkim=pass header.d=softathome.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KE2USuNn1Y1NJ2LPsp/yY9gwi2Bk85jzGdLwPBDy5Eg=;
 b=j7idWbatP+dtYWf0LYz3/F+i3YMx5guBvg8REi9jWNDI22jRPkLtNoQlRdqm9Xv4AyKOotGuxEQw246IbttALM1q7wp7Tnrse5QUH7gSsIafSn1TuU2eULPqgRpaNTSchYHkiTP3z6XCIuyBfXAgHvjbmrIwUEXS1KXDNi1DamDwJgzKhKWYhiAS9jDVHryibttgaPE2DrxKaRBJZBcVCgpIvz7lWY6TkpM4qz3kfhMByMEWG3BMk/KjALr+Ia2viB3vM0UL7CLCXxHtvXJlHMlz1URH6wkzOWlQVxPB1CfJwj5gnnviIkB8YCTZD86Lclfwuc2RDVVQb2rVHFmMmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
Received: from MR1P264MB3107.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3c::21)
 by PASP264MB5935.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:49e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Thu, 21 Nov
 2024 10:53:10 +0000
Received: from MR1P264MB3107.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b707:71fe:8517:aa42]) by MR1P264MB3107.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b707:71fe:8517:aa42%5]) with mapi id 15.20.8182.014; Thu, 21 Nov 2024
 10:53:10 +0000
Message-ID: <e4474aad-e2f6-4213-ba5d-c54ad4cb3059@softathome.com>
Date: Thu, 21 Nov 2024 11:53:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tools: binman: etype: Allow to replace 'NAME' in node
 names
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, paul.henrysd+nodisclaimer@gmail.com
References: <20241120104029.886860-1-paul.henrys_ext@softathome.com>
 <CAFLszTi1eue=sm0Mv6Q4cTB-ATE6oD6qMFkJJWPAbc=NiWK1Ew@mail.gmail.com>
Content-Language: en-US
From: Paul HENRYS <paul.henrys_ext@softathome.com>
Autocrypt: addr=paul.henrys_ext@softathome.com; keydata=
 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
In-Reply-To: <CAFLszTi1eue=sm0Mv6Q4cTB-ATE6oD6qMFkJJWPAbc=NiWK1Ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR2P264CA0031.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:1::19) To MR1P264MB3107.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1P264MB3107:EE_|PASP264MB5935:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f5e4d53-dedd-49d6-bf34-08dd0a1ab06c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NnA0UkFZWEdRWjRjUFF4TmQ3MENpR25DNWRGSDVHQUNQalJxOS93c1RsTjll?=
 =?utf-8?B?RUhwcUs0d0ZUT1N5dDg0cE5zdStFSDlnR2gwdEwyNWJhVHZzbXY0WVY3aC9p?=
 =?utf-8?B?c0x3Qi8zTlRjeUovRzVlZGJyUldJajdjWlRxeFRmczdFOHVxbnVYcXNsb0dv?=
 =?utf-8?B?R2RGNWtvZTFTMFZpaWhyczhJdlA0Nlh6VHRyeDJpcVZJUmRxbmsxNFZKZmt1?=
 =?utf-8?B?dklmT3ROUTJXYnFac0VuWlhwRi9IbDgwT3ExWWtQVEc1V0x4K21IeXVDSmVI?=
 =?utf-8?B?TnhzZUk1ZVBxdnhQT1pYTW1QYkpXTnhCdm5rRTBxMGFubHNJSVNmbDVkQi9M?=
 =?utf-8?B?R25HTkgyRUc3WEgxeS8zMExoTnYvR09yazE4TlU2bG9ONWZUNXlHKzlyUXVG?=
 =?utf-8?B?dlpULy9KZnQ1c0VlZ21BNVZXYzVWaXM0RzFkNlNyQmFEalI1ajVsaldNNk4x?=
 =?utf-8?B?WktVZUI5ZmptSUJwYXJyS21wdUs2QVJCU2lwZ1NXb2xsTHJBcFA3MU42Nkll?=
 =?utf-8?B?Y1Ftbk1ndmpvQVpPbDJYNUZrNTVUamNnQU54ZFozUUdBTmNTbWhDWHc5VktI?=
 =?utf-8?B?aStRS1l2L3JJRDlQS21hUFBVcWpNU21EZGQvMlU5Y3FEaDZ5U3VwbFpDWlR1?=
 =?utf-8?B?Rkl4THBUUG9hbXZRak5GbWIrK28wQi9VK1ZZK0ZxSDNsV2h3cW43VStibklQ?=
 =?utf-8?B?NEFLdXBrL1hpQzh5T1RjQ01vWGNDMEp0WGtidmIyNCtEOEVweHBmeS80ZnNu?=
 =?utf-8?B?T3M5Z2k1ejFBSCtqT0RGTXVWcWFqRFBkYmFoblJZeU4rZ2tCTEhGb05qeEQr?=
 =?utf-8?B?NncySlRhRGJWZmt2QlovanFPYStwcFNwazVDK2Q2T2VaZjdOL0hKcjhuY0lu?=
 =?utf-8?B?TDVUcGlNS2Q2WFp0NUV2ZHlXcktwb0NKNzFxTUZDYjBBTTBWakxmMURkd2dx?=
 =?utf-8?B?aHU1ZWpNLzEwajZBNk5GcldvR0c3a05nSUJRZlVxNFhzam84aFFqUE5Kam5n?=
 =?utf-8?B?SWZMRk85Rktya2xqRU1uZitiZm1KS29QbUl4WjBTMlRFNnY3bTBsaktLNFdl?=
 =?utf-8?B?N1NlbE8rYktDRXc2OENSK05EejNJandJSDN5Z0o2Y1h6ekUwRzlrcmI3a1dm?=
 =?utf-8?B?bkErcmRwR3MwVi8wUTdxQXNGanB0V09mZ3lKVDM4Q1lVbXZydFAzczRFWXdp?=
 =?utf-8?B?TFlrVk5lTWx0M0ZlVDNQR0lQeE5paTZOWTBzUjJ6MFVkNndEbWZoVEdIckRY?=
 =?utf-8?B?dTU4SHpFWlYvWWY2ZGhnbnJQcnBVcnIrRjhFNHJHeEV3WmdSanN0VnJyM0dm?=
 =?utf-8?B?cFhoUWV5RjIvUk1qeGRQOFFsQzg0ZDNJUXBtSC9sTFdTeTJ3VHBKbWFoQWRY?=
 =?utf-8?B?NzhqWnBmTnZxSlRCTTdvQVNuZENDVmNzeXEyTTRGVW05cTdvRnAxOXdVNU5N?=
 =?utf-8?B?cGl2cXZLQ05aSHViMDVRYm5NUXhOZnV1clZiYVlBRnVnVVhrRW11Q1JVeWlz?=
 =?utf-8?B?VU9IQThpM083ZlQ1bC80T2Rqb09OQnVzNHpSeFM5RElZVlZiQ0FhcXRvaVlu?=
 =?utf-8?B?d2ZxWXJqMVQ3R0dsSmVGZ0JpNjdwb3ZCVkpPbUNvZHJuQUIyVkYzZnB0MytZ?=
 =?utf-8?B?aFFyNTRtdnAyaXlhM2VlNHB3UWRlSkFsMHhnTkwyN1M2M1VyWFRYL245NTFE?=
 =?utf-8?B?R3ZYbitlc3gwNjNTZ1pPVlhBT29RVUxOZ2wwOGV2R2MxQ3hYa0dsOHA4eTRy?=
 =?utf-8?Q?b9R6PBTb7Vg1FQxkhE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MR1P264MB3107.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWVWd1paY3B1M1FSMUIwZnhna3FiNXFSamQ0WEN4TlN1OWt2R1o1WlMySi82?=
 =?utf-8?B?SjNESWxGcUJHS05kR1dzbFg0WHVnL2FvWXlXWEc3ZGdNUDNwU3pHdGdOa29w?=
 =?utf-8?B?clk2QlNuLzcycWFGdUp0YVZDMFlaRWR3b1ViNk85cU4zZkYwSDVuODh2bVNv?=
 =?utf-8?B?Z3hYYnQyZmlMV0xFZnBtTHBFVVAzL0NFaTZ6YVYzZFh0VDdkZzdMdXhmek5Q?=
 =?utf-8?B?bFRCaGFUQjVIK3BKK2NXTy9RTUF6UklpeURWVlQwakJwUEpUUlB6WHhGUldJ?=
 =?utf-8?B?WnhuZU1oektUV0dKaVhZK1FSVE1Wd1dYWjNrL0VsNjVwcjZaY0kvcGlva0Q3?=
 =?utf-8?B?RVpaQVpNQUs3RnpqbXJUYWZVUFQwcTMyam5tY056QmpqNE5iR2o3ZDJxVnUv?=
 =?utf-8?B?UnVHbnlpNEw3NVg5QVBFY29kL2NCTGozc2I3OHdxdW9nZ0VTTWdPMm4rOHJX?=
 =?utf-8?B?YUYwaTlNU0l0WDdNVFB3UStiWklFYVhxQlV0VE5yUXpnR2xNcEwvWFJIN2w2?=
 =?utf-8?B?YVFmdnJBc2JmZWNpbjhGelROdC8wL2VWWkQ5SXVVcENmTWlrUFNnZTBXNzE5?=
 =?utf-8?B?Q0lxOUEyYU1nUGNjcnF2dkdUM3A4R29mbFRoayttaHFVZ3MzWFl0TEIwSUR0?=
 =?utf-8?B?Z1VSMmdKY00wQWdOTmY2ZUk4SkVrcHNoTCt2NXJuNHlUMzE5M1AySnlNQTYy?=
 =?utf-8?B?azRmQWVNb1FjbmswWCtpV2JKWXBjemxjWXhBVmJ0ODVLRkhmQ1NRZm85OFMy?=
 =?utf-8?B?alRoa0pCTVNsL2JobERDUWtQL25LMy83T2FaSmtqNlVITEptTS8weTRxcWhS?=
 =?utf-8?B?QVV6aWk5VnN5UHpGa2k2T3IvOEN4K1dKOEtQZ1FLK2ZhZzgrdzBHb2dIcmI0?=
 =?utf-8?B?UlZhNVlrMEdpVWdndEMwNW44U25tVk8vSnRRUExIZHp6SzByWDhOY0VRZkhZ?=
 =?utf-8?B?dDJUb2k2WEVyWXNma3NTYW91Z1JVL3JjcTgzRVhMYmxRZkdBRUZJTUtXTWZW?=
 =?utf-8?B?VDkxRTRyU1RqWEVVWTgzNW9CQzNZRzhCUDRvdFB5dkwrV2ZLNlVIeDFNbGVF?=
 =?utf-8?B?S0NKUUlRUlZ1SW9YdUdvQzNjNTUxTHBGRkRJSTFVNzBPdDNPelhWMEYvSVJr?=
 =?utf-8?B?UVQyRlN5dFAyblBPaWJoV3pqUytMdThpcG1rYlB6bUtrNGpvTWs2aTZ4RVFn?=
 =?utf-8?B?Y1pqQ3F2c0U5WXk4UGNOWlhMcDdKbFJnMGhGakVjdnN3TmlzSEJQOUhEaVpQ?=
 =?utf-8?B?alVxZ3NjaU14Rk1HK0VJaWhOOXNUM2NCRzNRYTJ1M2RzdHZXTDl2MmVWV1ZG?=
 =?utf-8?B?MmlvVkM2TG9vQmo5N0ljREZUZTArZExIeklzQ3h2QzRUM1lPeDlXaTJlODln?=
 =?utf-8?B?b3hVMkZDWW9pUWJJWFYxRGZ1emNEb0xnY1RCSm0xWTFWcjJTUitiWVIvRVEy?=
 =?utf-8?B?M0xLbzFBQ0tOQXdRWHcvTHcrRnZCb25OK0pYRy9yZHpUNTNpemJmWGlZclVD?=
 =?utf-8?B?MGF6WHNUWm92TEpBbEJpbkt3ZUsvbWlyNlN1V3o1ZW4razFmZFd4NkZGc2Nh?=
 =?utf-8?B?R0xlN3Fud3E5bDg0dnJUQUlsek9KTVZ2allpQ1VUOWdmTzdqYmIzZFBNTmYz?=
 =?utf-8?B?YXRsVnpHSWlweFQya0R2enRacGJvTmhrL1JyWXkwcVBwcE9wTkk0eERDU0F1?=
 =?utf-8?B?R0FSVmIyOG90U0JtVThPV0FBUHdONTljYmtDR1hQa2Z0Nk8veDhtOTJrK3dz?=
 =?utf-8?B?RFJ0YU5oWWNYTFZPT3BDSzJQdm5VWjZlMEt4enRoS0g2UnM3T29zTVBFU09F?=
 =?utf-8?B?Rk91eVd3MGlVeTl4UWZwQVJiT3Z6VHpTYmIvd3p4Umg4K29YVFBEZHE5YmZF?=
 =?utf-8?B?RGNtKy95dWZrQlJZTVNhYVFKTW5yN3lHZTQvMVd1RHlXNDVGb0pxdHVveTdl?=
 =?utf-8?B?REhVdmdkUlM2MUU1QVN3VFpTUURDL1Z1WnFpWDIxN2lOdUVieThtcXFuSWho?=
 =?utf-8?B?OVpFMEQxdS9WNTJkMVNTNjNxTTRacnZ6THNQTkRsSkNMOERFZkx4VGR3ZU5P?=
 =?utf-8?B?QzBuSnIxZ1Ixb1NJY0I2K3gvajJaVUVENXFkZHVSRndNb3pUdGR1MlNpeWR5?=
 =?utf-8?B?Q1NLSnh5NDVkRG9qMXhUTWFkaWxkeHFDVlZqR1pFa0ZKU050NmVrMHVHT0dF?=
 =?utf-8?Q?7rawiuEOEcVlCSS7kZHyS9o=3D?=
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f5e4d53-dedd-49d6-bf34-08dd0a1ab06c
X-MS-Exchange-CrossTenant-AuthSource: MR1P264MB3107.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 10:53:10.2973 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mxhcXIGlA6CZOIV3WmxqAidv4hu0ERRyJ5CakiBWTAcxUWjH6vSax1ZqmjuwgAqtJ+vlo4weYpOlazw8k4mwBUZDvuIPpe6McWaUfQFH09o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PASP264MB5935
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

On 20/11/2024 14:35, Simon Glass wrote:
> This Mail comes from Outside of SoftAtHome: Do not answer, click links or open attachments unless you recognize the sender and know the content is safe.
>
> Hi Paul,
>
> On Wed, 20 Nov 2024 at 03:40, Paul HENRYS
> <paul.henrys_ext@softathome.com> wrote:
>> This change allows to replace both 'SEQ' and 'NAME' keywords by respectively a
>> sequence number and the name of the FDT to provide more flexibility in the node
>> name for the device trees included in the FIT.
> This seems OK to me, but it would help to understand the motivation
> better. Can you expand this a bit?
The rational behind this change is because some projects uses some kind 
of board data to look for the right config in a FIT image in U-Boot. The 
default sequence number (config-1, config-2...) does not make it easy to 
retrieve the right config in such a case. For instance, OpenWrt uses the 
script "scripts/mkits.sh" to create an ITS passed to mkimage, where the 
config node names can be customized when supporting multiple configs and 
typically uses the device tree name appended to "config-".
The idea is thus to provide the flexibility in binman to use the 
traditional scheme with the sequence numbers (config-1, config-2...) or 
use NAME instead (e.g. config-myboard1, config-myboard2...) or a 
combination of both.
>
>> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
>> ---
>>   tools/binman/etype/fit.py | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
>> index e0c1ac08d8..b9ebc3afd0 100644
>> --- a/tools/binman/etype/fit.py
>> +++ b/tools/binman/etype/fit.py
>> @@ -732,6 +732,7 @@ class Entry_fit(Entry_section):
>>                   # Generate nodes for each FDT
>>                   for seq, fdt_fname in enumerate(self._fdts):
>>                       node_name = node.name[1:].replace('SEQ', str(seq + 1))
>> +                    node_name = node_name.replace('NAME', fdt_fname)
>>                       if self._fdt_dir:
>>                           fname = os.path.join(self._fdt_dir, fdt_fname + '.dtb')
>>                       else:
>> --
>> 2.43.0
> Please update the documentation (near the top of this file) and
> regenerate entries.rst
>
> It also needs a test so that coverage passes (binman test -T)...
Ok. I am going to update the documentation and add a test.
>
> [..]
>
> Regards,
> Simon
Regards,
Paul
