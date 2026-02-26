Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A90FD8FCF
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 16:21:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7348883EC9;
	Thu, 26 Feb 2026 17:21:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="NI+gd704";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0BE183EF5; Thu, 26 Feb 2026 17:21:53 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7306383642
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 17:21:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P233R+7Fv3TL4Dx+SUglgBB8N0FdCNu/2mPOAWhSJfgzmGZNK0/39bR5frPSRwEcxftu4TPiApR3ZWBnvvMmrGjmEbn4V+86ycxFH3bYxdeHFVLEyJDj1fZX1OtFvB06e/WZNVNkaB7NEisRQprQRKVqFEKxXP+faDClQXutsVDZPWkTitKocky2xj8XGevHecox5QpmgqZqV4U5sHQO0qOl9JbRTVTgZygqBQDzI1hJ6q+IQvm2l4Ln6Anj8wHqSRPGtS37heAUhsHUE0PP7LMHrdZKmApDVk3EIl6rhmmZ//j/zaId8V7VZX894cXDi6Fk7cYTwD0J/anSEeEZww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CuUV52qhrTzc/x7/Rf+kjtBiRTYxHSSTfSC7Uj7Iuu0=;
 b=Hrrrtf7LM4W3l63ZkJHNSSSlc3qZJAxRvYdmIfAUuDGZ8Q0YqrFSmwfe4mQeo+H58CCiRl73211A92WUqAxPPE1tr/+/Kd1XoRAHXOiFXbUgTTr8nqde/t5wm4rRrcQ8T676Ols1WJNWbE/eEhNEMwz4u/3J2RjGINfc0AGU33zDg6LOGLbkKNTE81uaUYB5hBrjtPOusmMWX5gUZg1jAtLHau//Dd5JXafiss4N+aDl2qKrXBIxHfWO0eI6X7jx7TR2j+k/AlvBBP5wuS1MHakroibxZAVuOibJOmkW3s8KCfJ447UCz4dw153immb4+2HbXu+S7C56Y5gHOWgnrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuUV52qhrTzc/x7/Rf+kjtBiRTYxHSSTfSC7Uj7Iuu0=;
 b=NI+gd704VWVvcfFn2AXu4CfJrCcptD7tJhyE2zBRxJMtD5pqhPQud672X4WBbrH9Ng2CN6J8It0v/idZZxHGF05sd7Cb2KLVcVieXjjHhGc/HCFz41K/hxemsYWjwL8USRJmieaA46uMA/6LNjnwU09vkaJ2yr/+hPae1nBdeYY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AM0PR04MB6914.eurprd04.prod.outlook.com (2603:10a6:208:189::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 16:21:48 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%5]) with mapi id 15.20.9654.013; Thu, 26 Feb 2026
 16:21:47 +0000
Message-ID: <8fd72f0c-51ed-4721-a39f-1e41aa6665a0@cherry.de>
Date: Thu, 26 Feb 2026 17:21:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] binman: Make FDT size hint configurable
To: Nikita Shubin <nikita.shubin@maquefel.me>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 Bryan Brattlof <bb@ti.com>, Yannic Moog <y.moog@phytec.de>,
 Neha Malcom Francis <n-francis@ti.com>, Chukun Pan <amadeus@jmu.edu.cn>,
 Moteen Shah <m-shah@ti.com>
References: <20260226-fdt_size_hint-v1-1-5a731a5f8d6d@maquefel.me>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260226-fdt_size_hint-v1-1-5a731a5f8d6d@maquefel.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::19) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AM0PR04MB6914:EE_
X-MS-Office365-Filtering-Correlation-Id: 46979d65-9151-4783-4ece-08de755323c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: o6Ko36PlaT2N1m7iJpD5qyDetX7xfuT0TKbY5KTiS5qM7S8om73XlOU+cTrkbAcxljxwSuiWGPZdmhg6aAX34R4krXYRj4nZoC3x6fKjgPDo65S7JXjlmCTRnjK4jgx9FnFkuAMfJlIWPQTtbISmHqbEhaq5icd6GeOEkrCZqI4MpxBgWZDoWhAMJg7fNHnMJMQVjhMc0sUuVLKi2VPJGviyjpCwKggRMGZ5o2o4rcK+1sADht5jJeR/lRYSFj0YV2CzMQwVrqO7/0RIb1yvh+AXtf/2IDxnLrMWBFDZICgZIW10CruNy72FFUIOqCRAVf9e8qOeQOakA3lQZPe00eau2kBrNPo6f4wYdSw8hMsU4R1922KoI4zLe6Z297UurkrlW7VS4yeF7kOtUwiHed+66olwcDw1RxNPzYK7Bt6tJ2vuycrdr+ar7vgiqi1w++6d414oXG1FpMZ/O5mlbRNp06TcE2Gv5F2jIsVE1YToCXQRHw9VI2eXc61/OLM5RG2RAa5bNirmMvnCHa51dYCLB/0P3MSAXnIn1Q/zgFLuiWuZVvdH9yhRBQ/g31HBvtV3MR2oq36tfcS0NUXUnWjsp+ctaLH1Gy/47S433MoalrFXzE0oplCuiMMFZAVMcKBdH9CqJW9bthl8NJrIoQvzzB57imZERMSFi7iqdQlomYVrBZQlg+C/ZYJmTc2EFBmPn7MT1JrTkW5pgQb3gmGtUulnuKW2Tdw5m3D+W7g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHdMakQvbG91eC9PMmhoSTNVY0dicS85dWkzYk9NcUIrb0NIVnd5bXM4Y3ho?=
 =?utf-8?B?WDN6cy9oWG9aRW5JWEw2Vk9XTjRmaFJINm1UZ0RhckV3aXphN3RpZWdEODlB?=
 =?utf-8?B?ZTlCQkd5bXpnN2F6T3hWZlAzSktORFBTT1ljZk1RbmZJTW9ONEVFTlZTVGd6?=
 =?utf-8?B?VC9yV3FRN3lNQk1GblMrR0xQMERsakRwOEVXSy81S0RWSlNjcTdXd2ZmMkFI?=
 =?utf-8?B?dG5RbmppUEdZQ1B0N3JrSS9qbGg4bi96NjdEbHUxTUFWQVRqYjdBbXBSc0pR?=
 =?utf-8?B?OWpzUGhmamdZd2kwRDNCZVRBYkh2bHF5cXZFMzJCRzQ5VWJlTEZOaHRua2ph?=
 =?utf-8?B?R0FRMWhCSHRLbW93bFNudXdudjQ0REdFT2hDMmRXS01hNWpPT1JlcC9MT0dQ?=
 =?utf-8?B?SGZkTzhwQ0JiVzhiRlZiNUZUWEhHMm9SejRhamRkTmxZK2I0UWpKS2w5T0hv?=
 =?utf-8?B?ak42azllNlZNa3R2bXJOVm9CZXdVZHZiTFA2NkJwTkd4WXhNcGF0d3hHemVK?=
 =?utf-8?B?K3ZDTjVSRWhwN21yNzJTV2daNHRDc3UwSUlIR0tEOVZGMktBMHVGcFVPbHlM?=
 =?utf-8?B?byszT3dML3hBOTZGWlVDWlVMblpFTGJweUMvYzFQU2drSUtIcHJ3WXBhK1Jl?=
 =?utf-8?B?a0N3UG9iUWF6QlA3RUx1cCtoR1RvNXVLUVFTNExuT09DQU02Q252MU1JZHBW?=
 =?utf-8?B?REdJdXgvWnpnMEo0VmhLWDNRVU5GSmMxVDAwMytTTmtibmMzdFh3N1NXc2kz?=
 =?utf-8?B?NUN1bElITXpoR1hnaVJFa09IV3FHSksyNTFObllwZzdtWG9JTXU2c0plNTJv?=
 =?utf-8?B?cmptUU5ROVl3K1dkNW00MElzazdSWlNBTWx5S0ZxMzJTTE52aHgxSXptUmNH?=
 =?utf-8?B?cjJUZnNTbVhHN2ZpMDF4a3BkcnQvMk9WTzMrNTJqUEdDa3dXcGtLc3kyOHVs?=
 =?utf-8?B?WU5QV2Z1cGVMMVdFMzRQSWs1c01rN0VRa0dscFJ5d0pYMm9IdXl4TjExeGd2?=
 =?utf-8?B?K1duUTdyYUdXU0NFM3lVK2ZMME8zSllpdU9xZTQzZVRKK1FmYkFBRjRQMmU0?=
 =?utf-8?B?SXRvczBTenB3Yk82Vk9zdXdVdk15MXZsQ1ZLZkIxZ1JKR0U4eWV4ejNzT29P?=
 =?utf-8?B?cnhLQmNMSit1KzV0M2F5NnpOdkZkajZVaSt3ZVFjNnNFS3lIYXppaFR4Njkz?=
 =?utf-8?B?cVpIUkUvQzdOZ0ZraldzN0p6djJRR2tmK3RWZnYvRVRqb1lDY1hLMU5YTWtr?=
 =?utf-8?B?emlxNmdmSGUyTWFKcEJmR1ZweFNscDJ6elY0WXR1WDB3Mm5Kd0NhTkNhL0VG?=
 =?utf-8?B?NTdYWTRpZGhXWTVlTzNzMzNIc0VvOGhDbWNLUUp4TTRCNHB1OHhGTEhhbnJH?=
 =?utf-8?B?dHdab0U3KzM0VWNjS3pXK1VMTVJ4dkFnTUx3eWFHWWFZODVXcVViNUgrTjZv?=
 =?utf-8?B?UjVrbEtDUEJ5NktRejRwZGRuQ25mNW4wZkZ4V3QyclB1ek04alh0bTNXbXRt?=
 =?utf-8?B?QTNEMC9kNjZGWlBhbURNaFdnOUtaZmNYS1VhQjdsSlNKTllNOHZHbjc3TTdh?=
 =?utf-8?B?dkluY1RManRuVFBROTBSNEJUbVl1V2dNa3ZzbXpKSnhhcndUZzdNajZzZWVH?=
 =?utf-8?B?azB2ZWk4TWJOcmRvVGs5b08wY0lzZXB2dzR3MVRHcVpBeTdrT3c5cFdPT2Jp?=
 =?utf-8?B?clcxZUNJVFlBZVRqODBSQXlGL0IrTjVzN3lnbUE1WSt0Z2REYmtEVFU1bnNk?=
 =?utf-8?B?bG1LRHkxQ20zYlhtSkJWZ3FwbjFKV05pNThPL0FSdzhacUpTd2ZFQkU3L0to?=
 =?utf-8?B?Z3MwcDV0NEVyVEF3blBjRFoxRlJvU2JFL2xjSUlzL24ybXZEVDNScWlVSVlF?=
 =?utf-8?B?MVZoMUhsVjMvYTRpbzFJaE9mZ1o4bWpqTnNUMlU2d1ZGdDY3eUhPR04reVhi?=
 =?utf-8?B?VzZpYllmNERlZElYMmJPMUVKR1RFOWYzRHRUTnJUbkZWcnhJTWtlc1kyMHdn?=
 =?utf-8?B?NzV0WEdrQnJaUEVGN2ZwdUNiWkkxczk5QmJsZFFmUXVmMVUxTDNiWkJHaTZX?=
 =?utf-8?B?ZytyT01xb21xUW1NdDRHSjlNUXRwZVIzMkVZTjJXRWV2WGZKRklmM3JudExw?=
 =?utf-8?B?bFJKQUREcUdxOFBld0MwN1BWak9maUlTU09iUGg3Vlh5UllRdGhhcDNJcHJ4?=
 =?utf-8?B?ZmZmbllBaVRnOFRjUGlvTlF2ejFucjQ4RTJSZHIzcTVuekVKbSt6dWlsMjVz?=
 =?utf-8?B?dXo5MnA4TGRnMkduZ1lLb0x1SmVEKzM1SUJUV1ZiSjA4RlpTMmthNmFKam9N?=
 =?utf-8?B?SHNnOUtGejBGTGFDa3BlbGtDbE9nUkp0d2RDcCtINHgzdkVuejlBdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 46979d65-9151-4783-4ece-08de755323c4
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 16:21:47.7347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xhn7v9h9F2jqi9v+31fW6PhQEaQYpfc1zuRh+ieLd04xs/POZfqd/y+vzunAa7UaBNi72dGMdD8M2QBD6leVdf2Xa6HWee1pbM00HY6DwC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6914
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

Hi Nikita,

On 2/26/26 2:52 PM, Nikita Shubin wrote:
> [You don't often get email from nikita.shubin@maquefel.me. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> The hardcoded 64KB FDT increment size causes excessive reallocations
> when building FIT images with large artifacts (e.g., 250+ MB rootfs):
> 
> ```
>     ncalls  tottime  percall  cumtime  percall filename:lineno(function)
>      16118  297.130    0.018  305.189    0.019 libfdt.py:947(resize)
>        870    9.876    0.011   15.211    0.017 fdt.py:56(BytesToValue)
>      16118    8.024    0.000    8.024    0.000 {built-in method _libfdt.fdt_resize}
> ```
> 
> Add support for configurable increment size via --fdt-inc-size option,
> with recommended value at least equal to total binary artifacts size
> to minimize resize operations and reduce build time.
> 

Does it *need* to be configurable though?

After all, we kinda know what we're going to put into the device tree 
right before inserting it no?

I'm wondering if we cannot simply set the INC_SIZE based on the size of 
the data we're going to include (+ size for the property name and some 
overhead I guess). I'm assuming changing it before using fsw.property() 
and reverting it to the default value after the method is called? I'm 
assuming we may want to cap this such that we don't need to worry about 
OOM with very big artifacts.

I"m also wondering... is this code path also used when you put the data 
external to the FIT? fit,external-offset (can be 0, the case for most 
platforms except NXP). Maybe this is what you want? I'm not too verse 
into fit generation and quickly reading tools/fit_image.c, it seems like 
it expects an FDT with data properties and then relocate them outside 
the FDT and set a data-offset property in lieu of the data properties... 
That seems pretty inefficient to me, why insert the data inside the FDT 
in the first place?

The next question is how exactly you're planning to set this size. 
Because as I see it now, this is only configurable when calling binman 
manually and passing it an argument. Which means, this won't be used by 
default when building U-Boot with make.

This also will trip the coverage test though I'm not sure how we want to 
test this feature to be honest.

Cheers,
Quentin
