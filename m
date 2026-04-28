Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16813FF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 08:21:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86D7784255;
	Tue, 28 Apr 2026 10:21:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="tLfga44J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49274842A2; Tue, 28 Apr 2026 10:21:12 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7236684150
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 10:21:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tp+V/zJi2OArnKFCn+esCz/9vpVX+XYApCsNRNUyWnnbaN8oRoHHywLUzVfVwJD9vpu2rra7JfzgdXi9ZX02QTMLUkko5JBPpOQnZHCeGdFFrUJHVxl2HPXJNLwZKe5h9swLI6F/b/CLK/5QTWXiUP8rDtNBlzv/NRKYw+R5S5WcnC0DB++cNL6hP6uFfmLDAxyr7tt8Qgy8EnXMgum1OcMA9T9VIMgLzb1y8e3QRQcNPRkm4B9R5Xep1acebTl5+mNrcAfu+fRsG++YD0tdbbzI1uiizOH5y8q9H0k7BAFBNEddZvvut+ek1p1BWBNbxOlbsPdV2yFadrUfD+8Agw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XRvhSXEziJDerL+qwwTbdtg9DsoNk4CCg4QD7M3GqI=;
 b=K/bUBaASLQLczjn1T2EB6leDPk4GLNGo7yVrVUqb4FBV25+M+VhCFaAB4V9euxTFMGWVOgNOdmWxs7iJzC+m6Kx3f5rXO8yzRyBO9fpckIYJwkfd1eY3/4H8D0Q5/E34ONOChRJAGlTeVsitCRGQUUhyRaau97Ik2DI5D29zrDdAPoSWTSBSQ/tdJYocUXNRRGdZ8ipDj/kLnhEVtesyrRncyiFKVffyY+B6Dt/Z3qaippHny08CxE2EztzjFa7qK01tjBRwYnevtq/p2f84Qrl9tvC7YfC3ew934CCAfrLZmiTukdZu2BOywWioJiAuAcljmuYHIo6EeEJXA0jGpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XRvhSXEziJDerL+qwwTbdtg9DsoNk4CCg4QD7M3GqI=;
 b=tLfga44J2CUSyqyWXT3L8luwep4ylpIdc230AwM23NJ+mgzeEijnMfHFopLF38ZiWbU0OXd784HRAUKMOxokvEZb+1XMdtlJOJZ2r3lswFj5MCZdZcfBfYgVKF+pmHJanNSiqiGQQro6gcGYDv8yFaqxUxHFHPm9sNRG2+LjBlyyQ0vkq1alcKDoSDmSisQ2M6XHTBD+4qg3znPLRbS9Zg9pbR0hSbBg6Cg81cQh/QMacwtOwbACFKT+28hKhtksPUn7CXctk3lf7zbvgq3zae7FH007tpNGTKpU0Po7DSUHtBbu+9bJxM2SdcsBus2lfeXOs1yr6kqdOJ4hIzR8tA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2cc::12)
 by DU0PR10MB5511.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:317::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 08:21:03 +0000
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1]) by DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1%7]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 08:21:03 +0000
Message-ID: <e67c67d3-a051-4582-ada2-936b48888627@siemens.com>
Date: Tue, 28 Apr 2026 10:21:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] image-fit-sig: require signatures
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: Simon Glass <simon.glass@canonical.com>, Tom Rini <trini@konsulko.com>
References: <20260427150409.400914-1-ludwig.nussel@siemens.com>
 <20260427150409.400914-4-ludwig.nussel@siemens.com>
 <a8d658e4-68b0-46d7-9b00-34155ddb5c0f@cherry.de>
Content-Language: en-US
From: Ludwig Nussel <ludwig.nussel@siemens.com>
In-Reply-To: <a8d658e4-68b0-46d7-9b00-34155ddb5c0f@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0330.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::8) To DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2cc::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB5019:EE_|DU0PR10MB5511:EE_
X-MS-Office365-Filtering-Correlation-Id: 88f48ea2-9394-4b70-174a-08dea4ff1663
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: Pzeigh23o3geczYcQKXhBzmKe1klwb1ynYMawwbL08rY0nSYgi5pV8EL/coGcqXaOU2xzBz1WiuULy4jGnYhJ7WxP5bw3Rlw0o8HlNY5YcIZX+YdBagie3GyrDlSDoYgUFSaYBpPqUd+xcilmNHA7dsA+DHg6F6JhGpICDuAJYdoL6aIe7NGboVYdCtTsBl5epuz2NEuxN1t60F1wlZwAqT3NEhcwQ0/kznrmWcJdePkDSRWTJ7ZDn3LqxvwH0qsdMHrvly2cNAZg3kO4Ne2MRaYvLWxBGjD32kcE7DGaak8D9nsepHd7K2+iMKHPbIB4jJtTq1sr0+vIxrq2QkQZHNi9GXHOWJ2To7x0sgBJRAyDF+8tujIB+V5GEfMZ1Rn1AxO5BTmJfwtPTYG4Qk9zqvQDLawhCljfu4XZYjZDowtV0oDq+qYjpPtRgzeJdi9Y7RZ58swQua5od7nlGmNN9PSAXPzu9exZcU6occ/0IwjKnxasihsDjednJLIZUx7a5LoWJU9B0BtevST8vrejMnZzqHlcJa3IgpIaPFI8ftgTBHhEC/FFSdM6323DuhDTvZTw99ppYAemnESpbW9uM45Oyw01oSyEUC/RK0HIFxa+wVR2dfwkIHSplBezBZ+XTtrdBCt1ybb+5zKA/WJ6Gs5YDasmJ4WZfQ0CS3Ij/1lhZeaS4nwtkODQrzD4kTD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0o3TlVZVGcvVmd3VldlUUl1WEk3VWZFTEROVkZoSUtjZlBDMWpZSllaS25X?=
 =?utf-8?B?ODlROWhwc2RYUllUZlVMUHNOSTJSN2VwVmgrQ1h5TUhLamJSYzJiSE10bmQr?=
 =?utf-8?B?ZmdmMEZHdXJLbUtSaDNXMDdKU0lWamJ3SDgvTi9HMzA4a3IwR0ozTVpBWjR5?=
 =?utf-8?B?SE84SExrS1pjbi9kbGNlWWRic2s0cWk4ajJIRFdFM0VudjZ2ZXMvK0w0RVN6?=
 =?utf-8?B?V0NQZXVJeFoybktvZXp6OUNKVk5oM3JNVHFRVUplODVQUjBTN1pvaXpEUGV6?=
 =?utf-8?B?T3Y5eWNzRHBhSjgwdXRMdHB5S2JJMCtWcW1TdWExdXZTVmsyTWJlNFBGblAw?=
 =?utf-8?B?UlJhWTV6ZWpqNXlQVzVSRTU5cUM1TzFOT0hFWk93MGJaRlhCVkFNWnhCOWt2?=
 =?utf-8?B?bmtNVGFzRGErNGtGZDR1OFFWK0xnRG54RjJiV2dUblIwSWVESjRZeC9TelVq?=
 =?utf-8?B?OWJkTi9mVzlDNjBDTElMaFBEV0JjR2NaVzl3UjlPUmlxY0pQMDgyUjNueXVn?=
 =?utf-8?B?YmR2TzU0eUZ1TmlJNFNtODNrakNBNU10SllUblVmZXMxRWJiVjNRNVJsMWl4?=
 =?utf-8?B?OEp0aHNBUnY1ZVYxNEZoT1VJd3ZTWXpSVHdlNjcxc044UGxnTmJVUFc3YTA3?=
 =?utf-8?B?R3kzQ2Q5bFMvOGJ4TnYvV2M2WUdvR1drRXhyWXNTb3NGSzNIQitnMHJ5Y1lX?=
 =?utf-8?B?UG9meVRLdTdjLzlMZzZkTEVuQ1BwNzh1L1h3Y0xkOXRlbjBRSzlGRWIyQnpt?=
 =?utf-8?B?RVVnU1VIbUU1ZnA1YTRvM0pLS2RkdmFhNWpiRW84eFovVjR6WFhkY3hCcndq?=
 =?utf-8?B?RU5GS0htdm11UGlFcUZuTFkyL3lWZzhrcnJIVHZtMU5tODFrV2JDMWoxYks5?=
 =?utf-8?B?V080TTFhUXBiQkpHVmVHZFRxc2NCcHlTVXVsNEFXemRUMWtMYXdwbTFDTjJq?=
 =?utf-8?B?QVZtblQrVFIxRXFlVmFOL0QwRGVYVkwvOGdLN0t0ZFVjSDhYaGFuSUxObkNK?=
 =?utf-8?B?bWNOY0JybG1iN25jMjBaYUYxQnFxT2krSXZpVDBDVlE3aXR6VHBCaGwwWXZB?=
 =?utf-8?B?SU8zYzJqdk90a1UvQmRhRU8yWHA1RFFvUm1TeUE5dHRpNWt6RTBEc1hKc2Vk?=
 =?utf-8?B?Y1FJU2pIeUNHcktkMVZsR0w5WkdDa3h5RXFzdTFEbldvd093SEdBRVBLanc2?=
 =?utf-8?B?UzZPU0lUQ2xndmdmbC9odE41cFdrZGRQd1N4Vm1oVGdZMDNpVlB4amRJNTN1?=
 =?utf-8?B?L0JVazU2RGZMT0VmN1RJVGttR2x1bTVPbFNhM1lqb1dETmNyenczc1FJWTFs?=
 =?utf-8?B?aFRrUDRlcFJnWWhkaDdQRUZ1bitzM1lSaEkySG1vMnV3NXZZWXpGUmhqM3VS?=
 =?utf-8?B?c1ZGM29ZR2VJbS9Vd1BBdVZMRWJzLzkrMklwMDBmZ2FJaE5ZbkhnMllkSjFj?=
 =?utf-8?B?bjV5a3JQYVZNRDBGWkJ3V2g5QVdMMG91eEhLMzN0UE9henoxelZCZW1YaWlF?=
 =?utf-8?B?MDIrYUdYSVRvOWNQTENsMEFQRXoxZ0VGYmVDQnZIVkVORVdoMlZnUHkvMFNj?=
 =?utf-8?B?U1VkVjJVLzl6WXN6alpzcXJEWnpXMmNhekZTeDAxTEUxUlJES2F1b2szdUtm?=
 =?utf-8?B?T1ZucC9HNHZORDB5Z0o4RE9uaktkK2x6TTNIeW5uRkY5WDRXenNnU0xxeXFr?=
 =?utf-8?B?elpEQ3pvN1g3aHA2VzU1d1g4WU00RGNRSXBacnZuTEVXR3hSRlNIdmMrZDg4?=
 =?utf-8?B?Q0RFcEFuTUdaSTZnQ2w2b1VhTnF0c3hQdG5YdUNuN3Y4WnRFVGVJMnk3UTBX?=
 =?utf-8?B?c1dXMks5djR6RjlVbHkxSHA1SlhUWHhySWVFb1V6d3U0NkRraDNjcEpUMm04?=
 =?utf-8?B?NElzeFErY1ZpU0d3TlZwT2R3N0psZTNraUxDeXl4MUxxRXJHQXhjYkg4Y3Y0?=
 =?utf-8?B?Ymt0bUZCNzBtN0tMZ3c0RE1YMFpEY2tBTHhlaU4vcG1wTjFoanRINGlkV0JJ?=
 =?utf-8?B?Ti9oS1FGMG14c0hiMVErZ3lSQ1N0T3o4VUVGU2VNWGh1NUJMMENEeGxyVStU?=
 =?utf-8?B?R3ltK3h0QjhCd0UwZEZwb0xEWDMxcGE0c3FaWUR4RytwVmp3NFcrV2ZMRjRM?=
 =?utf-8?B?UW9paGJLNjV3MzJUSkt4Y2U0NjlXcWZZcm53SVkralJOQkFZeW53OGpJWHRP?=
 =?utf-8?B?VlA5SG0rTXBqWEpmc3pkWHRkR3VkbUtyeUs0MkgvYTZFZnhHUnE4OU9Nd0ZZ?=
 =?utf-8?B?L00zUnFjb2ZBaWxxNnh6R21wZVFjVDFJZG52ZDhJOTJadDQ4aDl5ZG9PVDY5?=
 =?utf-8?B?aGl1QmJ1ME4zcVVFb1BPZmFadjVid3RVeG9NOURtcEFWNUNDWE83Um9ITTNu?=
 =?utf-8?Q?QE9EdU9HCammkIyk=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f48ea2-9394-4b70-174a-08dea4ff1663
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 08:21:03.3828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bKQ75b1IM33qSzVNDbKb8a7bjgvhMFobDWGWobSgPloGAZDfHhinaXXgxCJmzIqqKO9EYih5s8ePKGMJ7X5oP9AV3lSOw/3cGGo6faw6qSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5511
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

On 4/27/26 18:02, Quentin Schulz wrote:
> On 4/27/26 5:03 PM, Ludwig Nussel wrote:
>> Signature nodes in the device tree are mandatory if u-boot is compiled
>> with signature verification. Allowing signature verification to pass
> 
> First, it's not enforced at build time and cannot, as it depends on the 
> binman FDT node to be properly configured. But we cannot do that, 
> because we don't know the user setup.
> 
> You can (mis)configure U-Boot to do signature verification but forget to 
> add the signature to the SPL/proper DTB. Then it'll do nothing of 
> course. To be fair, I got bit by that very mistake recently so maybe 
> there's something to improve there indeed.
> 
>> if those nodes are missing would leave the system fail open.
>>
> 
> Yeah but why would they be missing in the first place? It's not like 
> this is something you can modify if part of a secure boot. The DTB of 
> stage 1 is used to verify FIT from stage 2. You need to trust DTB of 
> stage 1 (by verifying it with stage 0, etc.) otherwise I can also simply 
> just change the public key in there.

The reason the keys might be missing in the DTB would be mostly 
mistakes. Oversight during rebase, some packaging mistake, etc. BTDT, 
constantly fighting my own fat fingers :-)

cu
Ludwig

-- 
Ludwig Nussel
Siemens AG
www.siemens.com
