Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66FADC021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 11:48:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B93A580F7B;
	Mon, 17 Feb 2025 12:48:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="YEvFHH6w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39D8380F86; Mon, 17 Feb 2025 12:48:00 +0100 (CET)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F056880824
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 12:47:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJ29P36UkRSYe/9Jf9JM5DWtAV6XOBRotsH7oj8OrLsAOPcD/Iuy21g/WJdq4DGxtS0TaNqWtE/OxvLG1al6iqBUnU2ZnbJQuSjcGuhf2YfF6+GCb6dxG349tAmvY9w2UtJSJ1OLFyHiDykliIL3zoKo2PFAky9HJe2kjOOiwZyxNk1bOk+lXqMOs6NU+pYgX9f554G55QXv0EDPf4do7XMUYrvjLeESxfAF3HefFZ63zZ4+lFsz1u11VbjPxdv/K1NZ7BCo8epziAiShcVrQZ2U13Hc0gvg0XvwNVCfSi5nK0CFfLqywvxXetCRpoyOiQYv2gIG9lKHsRu8cphoUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+m0IkjMM9DQWBl8p3HLT9EQpBv2qbr9GdSjbHgi/q6g=;
 b=JrzajgBPumml1Zxxt5Vxl+KCMNCJQpURyl7lAaLi9E+vlFeukO3mp9ixrl2YgoTjsFR2VsVdWLE8HpifE9G1bSYhgJfZe+wtMnVZ/tL/x74965clTF7vfyxHUcHSbU8fCh+W98wpPgGAaaA2jyP8JYP0CegIOGJRVXt2hi0B+nKDomvcIA57a9cYJGnxoWo50Z0fZYwh6xANcHBSRZuVb57ETPl/5LsI7D9oi05VXI3jo9hrBY09/HkpfzQ9UZtmu8X8WIF0rCr6ARaAyJvxbDY6/w8elmlSnWybKgUgR1mC1VMjwfCaenI2mxLMfDBbMOlkwv4l7KKTqlkRXwCptg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softathome.com; dmarc=pass action=none
 header.from=softathome.com; dkim=pass header.d=softathome.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+m0IkjMM9DQWBl8p3HLT9EQpBv2qbr9GdSjbHgi/q6g=;
 b=YEvFHH6w+kUt5GLndDyqrLFlsHq7RLBTyQmuxBpnIq2sEQcN+02EI3u/y6HWDc0HwvF4IivYk4+yn9yxFXcGIzJ1LCBAKVznAeuM8g3lppFVIH6GaH/D1QYSX/q1SviU7+YrAb0OzMIRZyzbGreMtkoVXfKJG6f9VsB/uM/bG6+8vOGzmP9e2vVyS52ToxyfAlrHnMrR5hZYPjwta0OUyts5bT4mfOq8jFESfeET+UFceCGzpeB6tWjtXRv1R3R+d1VnOpTNakk7GpWEPxUn/TeRyTGx0fFCdOgRoh3gXzqfVrCedhIj6TI7atw3oCSv4P87RD6Lszl1w3wNct6xWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
Received: from PAZP264MB3119.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f2::23)
 by MRYP264MB6287.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:6b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 11:47:55 +0000
Received: from PAZP264MB3119.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b56a:1956:b6b6:8102]) by PAZP264MB3119.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b56a:1956:b6b6:8102%7]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 11:47:55 +0000
Message-ID: <95ed2380-f520-4334-bf67-0457a2bd5278@softathome.com>
Date: Mon, 17 Feb 2025 12:47:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tools: binman: etype: Allow to replace 'NAME' in node
 names
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, paul.henrysd+nodisclaimer@gmail.com
References: <20241120104029.886860-1-paul.henrys_ext@softathome.com>
 <CAFLszTi1eue=sm0Mv6Q4cTB-ATE6oD6qMFkJJWPAbc=NiWK1Ew@mail.gmail.com>
 <e4474aad-e2f6-4213-ba5d-c54ad4cb3059@softathome.com>
 <CAFLszThEm4MzG6sj0QrHiyAS=B5xQtj0wjnkQ34OStuyFu7WfA@mail.gmail.com>
Content-Language: en-US
From: Paul HENRYS <paul.henrys_ext@softathome.com>
Autocrypt: addr=paul.henrys_ext@softathome.com; keydata=
 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
In-Reply-To: <CAFLszThEm4MzG6sj0QrHiyAS=B5xQtj0wjnkQ34OStuyFu7WfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0074.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cc::16) To PAZP264MB3119.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1f2::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAZP264MB3119:EE_|MRYP264MB6287:EE_
X-MS-Office365-Filtering-Correlation-Id: fadd4baa-6044-41a3-7e48-08dd4f48eace
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YzVDOHVPWjE2SG44a09FUlJNNGl3RUcrVnhKZHhPNUpsb0JkQmEvdHdja3c2?=
 =?utf-8?B?VnNPeE5BY1BNN1YxMVZxL2s4ZkNwNDVCbmFDMDVra09JUVpmRmtqV1NYMy9C?=
 =?utf-8?B?SHRVMktUeTV1WFdiK1RzS0pNcTBvb3BlMkZ6Tkx6Z3FYdm96QkYvdURpNHRr?=
 =?utf-8?B?dDl2ZGpHSHViTlJaY211dSt6ZU93MEhKaW15ZlRGY21vS2hRUE5DZm5vVTEx?=
 =?utf-8?B?ZTdvcjQ4dWgzVTBiK0tiTTdlZGdxZUdLdzFSQnRTVCtaMDcrOXBRaGMzYlVH?=
 =?utf-8?B?U0dzVXBUNHZpbFhUZS9zSjFOekQ0a3lkUDNZSHhCVGp5U3Z0Z1kwcEE1dnNF?=
 =?utf-8?B?elJCLzNvQzZ4QXBTMDkrdVJ0d0pSWWs0RXQ5WTRMbXl5VWYzbW9kV1NJbHZG?=
 =?utf-8?B?SzhJeFVsWVdNWEp2RVFXdzk2S29jTmluV1I5RGR2cXFpcU02anF0UlN6cEFF?=
 =?utf-8?B?Y0tZaDQ4OHNaSnRrTk13SkxScU5Kc0NhdGZPaThWbHVPSDd4QVJoT0JuZ2JB?=
 =?utf-8?B?ZncwSCtYdHdhVmRreG1lVXh5bnZTZW53VUhlY1NoQkluMVJIRXB1eVZKRFE4?=
 =?utf-8?B?c1VKaUFGd0V6WDZJVFRnemwvTEdQV0d1N0xKUG9hRVhvUnBBNThaTUJIVmV3?=
 =?utf-8?B?ZDRPN3BtaUQ5SWljTGNSTCtFd2Vpbmd6RlZsUXM3WFhncXF5Mk0vUTZRWEtw?=
 =?utf-8?B?Qi92L3VWTTF4VGo4dDQyb0FycGRXdnl2MmZFNTB5ZUFBQ2ZWUzhHbTRiZGdt?=
 =?utf-8?B?NkZ4bjRFUEJidmNJa3IxTWJRVkFsaXFpemd1Y0hNcHR5VEI3TkZES1JJd1Y4?=
 =?utf-8?B?dTllemNzbUpjTE9CVUdIMVpWYTZHM1VRNHEvZ0xPWTVMeE9SUlo4MHY2aVlH?=
 =?utf-8?B?MzVveVlUVjl5S0xRVXZTN0FlVmx0SFU5ZXFSUERVT2JZWVRMRHBGM1JVYXh3?=
 =?utf-8?B?S3VIV25rREZmSmhyaFM3VlZJeGlra2JDWTZNemVSRm9sQml4azF4ZVUwdE9P?=
 =?utf-8?B?ZklMb2dGbDI5TktXaEFSNHI0UzhmZmphMVFPcFpmUDBWS3I2UTVqd0YvUnU3?=
 =?utf-8?B?Ni9jSUNkbC9jbC9OSWFaQnlTTHJmUVhFaTkvUTkrdnprVWEzak5VaFF1SHJj?=
 =?utf-8?B?d2RQeW9zZUhLeEIrVDk2cnErNEhRcUpPaGU2cXFsSjJqb2lhb0JZMktDRzJR?=
 =?utf-8?B?dG9OV2MzQlZ4a0JoSFljajk0WEtJSUhWYUJ4YURsZU1VYkNZNTJWVnh4cGZk?=
 =?utf-8?B?YTlSQlUwMDJwWWVUZElFUzdHY0h5aDdQK09NWjdkNUpoZlAycmpjMUtPdFV0?=
 =?utf-8?B?SUlMck9RdXlMemhET0dVRHJ4dzlBcTdRaENRbnpwQnNLbmU2UEJ3OUNUMms2?=
 =?utf-8?B?MUdGZU9DcHE4d2FWc2V5YlhmVVlza0VEREJjUUQvSS9FOEl6QUFZek82b3Np?=
 =?utf-8?B?N2lNOUJ3bW5oY1JLVnE3MWs0MUE2QXlBVCtvMk4vTDV4Q01mZjFhNWNaenJI?=
 =?utf-8?B?NExnVGJYMFBPUHh5QWVNQ2hXcjdHUnBtVTkrUnZRZjczdzdIZW9uc284SDd4?=
 =?utf-8?B?UVcrL1hZUGtEbVpYNGZCeEs3eFZnZkxVKzJNOEt1L1pEUDk2QjdVUUZ3SHAr?=
 =?utf-8?B?Tll4WkNPS3A3aHJYdFRuUE5SQzNvcmk4SFhxcGRTbDJ6NjVCMElaYTdDek1y?=
 =?utf-8?B?VGppN0NvazJSSjdueFRCQytqQjhWUnFsazcvZFBDa2k0cWpJK1hwVHE4RkF5?=
 =?utf-8?B?bnlFeFhOeXBWRzlydmduVXJITmlwQllZREl0L3JWbmM0WHg4MXJvZzFaWDdw?=
 =?utf-8?B?Lzk4dXJXRjJCN1NBZFQ1TjRkVGU4UFdYNFNWWk5NNE1Eb0RhWHdNODhVWXZW?=
 =?utf-8?Q?OJQD1KErq1PNq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAZP264MB3119.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFZhSXA3VTEwQ0xiWitPcERmVjlibjlDZk1QM2RzRXhDK0pkZGRBejRvc0k1?=
 =?utf-8?B?K1lmT2xLRmI3RjNOY3JqVFFhUEpMYjZUemxWbWhySStXT1U2dXhORGdVb2gw?=
 =?utf-8?B?VDlnRW5pSk92Nm4yVVk3WW9OY0hET2lzRUNlYnRSYS9VVEFqN0VSaEM5RUto?=
 =?utf-8?B?bER0aHBrREZPRkpXc0JGZTNRM3BFSTVqWENHZEU1VWVabm1nb2ZsRS8zTmdx?=
 =?utf-8?B?LzhuTVdiR3REdmRLZnpidWJaeUhiREtiNlMxSFdDS1NnSXhyZFlJTndXNFFT?=
 =?utf-8?B?bEhzNE42T0tXdmFnRjN3UnhTdHo1eUdnTnV6cTZaeFVkTWFFdkxVZDFMREww?=
 =?utf-8?B?UVBvdmE5UERmdWFOMVhKU1hwTjJBYmZiZ2NTVDkzNDkrc2ozUkxBMVlWWGZo?=
 =?utf-8?B?TlE4Umc4WmR5ZHZ4SU1HRENDQVRWY2I5Z254TUd6em5Qc3VuRm5pTlhFb3Fi?=
 =?utf-8?B?bHhyQ1cwSUlORE4wdG9OYXhCSVNTUUwrdTdrRFdSRW9WOWt3V1IvMElEbG1F?=
 =?utf-8?B?TnpXOEMwd3JvWXhyeTZqVk9sQzA4RW0ybjR4aERHdENMOFlESGxmSXBCYlBU?=
 =?utf-8?B?K0kwL2JidFpLVTZXcURZRDBxWEhNRjdReHJhaVFOYW5sUGoyRzNEanJOV0Qw?=
 =?utf-8?B?cUxMUHpwOXFLL05tdFdkbUZZZkRBWVNnSlY5VGZWb0RXYzB4bXpBOURyT0hp?=
 =?utf-8?B?WmZJRkFHaytQSXU1M3dRVTZVRE92akEybUMzSjVGWUdJeitqNnp4M25qYjVL?=
 =?utf-8?B?VVczWmlHTWI1S2dEUUdVYnVDOTdEM3psbUoyZWo3RnY0TVJ4cWdkV2ZmUzZr?=
 =?utf-8?B?SFRod2dUYUxoVWYxb3hJYWxYN2hCLzhEUVB6QzlOMWtEU3IvdHowZkE4aTNo?=
 =?utf-8?B?MG9zTndWNXo1NnhPMFNXWEtoV0t1RVhaenBienQ4UWUrSWtXOFJVZVRNcFpR?=
 =?utf-8?B?dE1EKzRiWWNKa2JUV0Fla3pTZWF5NXF0M0kzeWJXTElVOWlGd25aeWlWQW9z?=
 =?utf-8?B?UmYxcTJyblhiaFlOOFFiRkZJVjkxeUhENW1tNi9NNkpBSllUeXhsUE1wcWRY?=
 =?utf-8?B?THFERjkrdTVBcDR0U0hsSjZxS2xVWVVvYUtSQVVGcXlxTWxYTlp4YVNpcCtP?=
 =?utf-8?B?czA3aDZ6c3ZYZldidHYrMWdENnVSN0V3a0RKTmxWSTBwU3VSbkNnNjR6QTl3?=
 =?utf-8?B?Z2Q5OWpHUlNCZW5ONVZRMTE3TC81c2xqTDlDUDJhZk0xVTdNWnZDQlN5VXdQ?=
 =?utf-8?B?WU5hQ1RYeEFiZDNZNUhBTW5oN0tPUE1BSnBrVnJCdFRTS3RpSTNSZ3RyZ0JE?=
 =?utf-8?B?aHM1RlJYRXNkMG16Z0JqT3BXcDdwTWkzeDBYY24yTTZxM1hrZmJ0b2Y4ZWJE?=
 =?utf-8?B?R2NRQ1U1WHBWMHo1S2FKc0RpMWRDcmJLYVkrUFpNcE9ucnRFN2dRODB6WkZu?=
 =?utf-8?B?cjJtZSs4bTNUdDF6YnU0dVIvY2tvOW1HUEpQWmdya3RjSVJCQ1ZHbWNzOWpi?=
 =?utf-8?B?V2FqRlpRdDJ3NHNtdUJDRE5CZVhKMTZzamhnMUt5OExDb242Tm1GcUdkc3Yz?=
 =?utf-8?B?WVNxVU5lYy9MZTNzNXJldFJYS1J3Z0M5d0hid2hRYzR5aTJncDBFeU56T1E3?=
 =?utf-8?B?MzhWTlFpVEwwdklwcFMvR255TGZra25CUjIxcGdMam9zSHpLQ3o5dHFreHo2?=
 =?utf-8?B?dUhkZER6dFUzcUkxM2ltS2Y2V3dhSkRBYUZ3RXZETVdBTjk3VnRUdzR2ZUlR?=
 =?utf-8?B?K3J5bUVwU2Z1M3BrSzN0b05UTEJmb1dDdGREZHI1NDh6SWhleW5Qc3NoSlJD?=
 =?utf-8?B?UWxMU0J6K2dvT1F5NWI5RjVEblg0RHdNQmNiUU1ob1p0M1RIajZRUUlQdmFy?=
 =?utf-8?B?bSthNTJxL3hXTlg2bWtCcFVaQmZidFk5bmtwa3Roak5WckZrZHl6dkUyQ2Nl?=
 =?utf-8?B?WUU4ZzFyQXBoZXluOWZPaVFlMHRndkVXVnIzcWREQ1FyZUZJdm5oN1lxbVJj?=
 =?utf-8?B?ekJ1eWppRExhQ0ErUjBROEVobWRrU21xNVBoUGNnL2NmbjhZR2NhMk1HMXZh?=
 =?utf-8?B?aVByUGI4V3BMTHFIK2JVVWFZMGp2NHEyNUx5Vzc4OTFIODFKVjhmaVhBdi9Y?=
 =?utf-8?B?QTJpSWVBNXc2OW1MbFFqWThRME1hZGwwT2NCSGZUdUtNalo0a1paam5MN0NJ?=
 =?utf-8?Q?6Iem2AVmPzSTTmZszJ3Cqew=3D?=
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fadd4baa-6044-41a3-7e48-08dd4f48eace
X-MS-Exchange-CrossTenant-AuthSource: PAZP264MB3119.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 11:47:55.3454 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: psoCpUt7idu17WRxIXcB34bxD50ZREv7RcG5r8yL1j0xuwbtVFHYvTc5tQU/4j3yFXQDwkKgPx03I48dEa8/uvhrxgh/2qllI8+UEtCaJ4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRYP264MB6287
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

On 15/02/2025 12:59, Simon Glass wrote:
> Hi Paul,
>
> On Thu, 21 Nov 2024 at 03:53, Paul HENRYS
> <paul.henrys_ext@softathome.com> wrote:
>> Hi Simon,
>>
>> On 20/11/2024 14:35, Simon Glass wrote:
>>> This Mail comes from Outside of SoftAtHome: Do not answer, click links or open attachments unless you recognize the sender and know the content is safe.
>>>
>>> Hi Paul,
>>>
>>> On Wed, 20 Nov 2024 at 03:40, Paul HENRYS
>>> <paul.henrys_ext@softathome.com> wrote:
>>>> This change allows to replace both 'SEQ' and 'NAME' keywords by respectively a
>>>> sequence number and the name of the FDT to provide more flexibility in the node
>>>> name for the device trees included in the FIT.
>>> This seems OK to me, but it would help to understand the motivation
>>> better. Can you expand this a bit?
>> The rational behind this change is because some projects uses some kind
>> of board data to look for the right config in a FIT image in U-Boot. The
>> default sequence number (config-1, config-2...) does not make it easy to
>> retrieve the right config in such a case. For instance, OpenWrt uses the
>> script "scripts/mkits.sh" to create an ITS passed to mkimage, where the
>> config node names can be customized when supporting multiple configs and
>> typically uses the device tree name appended to "config-".
>> The idea is thus to provide the flexibility in binman to use the
>> traditional scheme with the sequence numbers (config-1, config-2...) or
>> use NAME instead (e.g. config-myboard1, config-myboard2...) or a
>> combination of both.
> Sorry, I dropped this for ages.
>
> You should use the compatible string, not the node name. What kind of
> board is this?

No worries but you actually reviewed this change and it was integrated 
in the master branch in the commit a4345b193479.

I agree that the compatibility property can be used and that might be a 
better practice but U-Boot current implementation also uses the 
configuration node names to select the configuration. Hereafter is my 
understanding of the implementation.

The configuration name (spec) in the FIT image can be passed to the 
bootm command, typically with such a command: bootm 0x1000000#config-1.

do_bootm() -> bootm_run_states() -> bootm_find_os() -> boot_get_kernel() 
-> genimg_get_kernel_addr_fit() -> fit_parse_conf()

The above sequence retrieves the configuration name passed through the 
bootm arguments and stored in fit_uname_config.

Later on, fit_image_load() is called in boot_get_kernel() and the 
previously configuration name stored in fit_uname_config can be used to 
retrieve the images to load. There are actually different solutions to 
retrieve the configuration and the images to be loaded:
   * Using the compatibility information if provided and when 
CONFIG_FIT_BEST_MATCH is enabled. This happens when calling 
fit_conf_find_compat() if fit_uname_config is NULL
   * Using the configuration node name when calling fit_conf_get_node() 
if no configuration could be previously found

So basically, U-Boot current implementation allows to use both 
compatibility property and the config node name from the FIT but so far 
only a sequence number could be set (config-1, config-2...). The 
proposed changes allow to also set a name based on the device tree names.

>
>>>> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
>>>> ---
>>>>    tools/binman/etype/fit.py | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
>>>> index e0c1ac08d8..b9ebc3afd0 100644
>>>> --- a/tools/binman/etype/fit.py
>>>> +++ b/tools/binman/etype/fit.py
>>>> @@ -732,6 +732,7 @@ class Entry_fit(Entry_section):
>>>>                    # Generate nodes for each FDT
>>>>                    for seq, fdt_fname in enumerate(self._fdts):
>>>>                        node_name = node.name[1:].replace('SEQ', str(seq + 1))
>>>> +                    node_name = node_name.replace('NAME', fdt_fname)
>>>>                        if self._fdt_dir:
>>>>                            fname = os.path.join(self._fdt_dir, fdt_fname + '.dtb')
>>>>                        else:
>>>> --
>>>> 2.43.0
>>> Please update the documentation (near the top of this file) and
>>> regenerate entries.rst
>>>
>>> It also needs a test so that coverage passes (binman test -T)...
>> Ok. I am going to update the documentation and add a test.
>>> [..]
>>>
>>> Regards,
>>> Simon
>> Regards,
>> Paul
> Regards,
> Simon
Regards,
Paul
