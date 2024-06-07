Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 292ECC27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 08:23:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A9578806C;
	Fri,  7 Jun 2024 10:23:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="FzvXahoD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA8E188103; Fri,  7 Jun 2024 10:23:19 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0015E87FC8
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 10:23:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLmVjSh+27liCR6S1tcskSuD6akifl5SYSJ640nX6bqC57MPQwFE0V6sYv98VGOSi2+I8L5s09fA+V0/7odpuAoewrarDR/FLcI852ww24ET78sn1sfAXRbYX7ZQIzlv6PN2Z2q6MboabKNMtuGIuS320HCDFOtxGqnqEH2exyKUQsYUHzSIjGj5+Sd4vxWFyiec0H8m/SL42LhJiCbPgsnb0QuoOz8/sZb7G3TiwMee1cOzp6sGvbfRv0RqU+jYMnrKwPrBadLCeX+sJfTk9bJg2KMDYMDZSrArZU3NkMSidjPzmBiVd03tMwqIUMkzLJyyaDmm7qFRiJaw6duQYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xc8bziotJWKrga2G1sGyOKtJsJFGRkCJBS5NfGrHgug=;
 b=nNMeQCBYdOor9Bj68J3vN6cbeJeE3FzsGS+v8pVKaGPZs4oJfRRXLaeW2/3qb5V/OlThK/EapksZDSSpSPJ5kLL0gi+9f7OHtIzU/DW3HjlGj/q2g1jPSg7HVhTjBxK3q6uawZQd6730XUoQ2xFxbi/ppM0txQtwvQXkKBva5vBZRVMnkVg+IVsN3hdnQ6Dppxz6BJzyDnbu1tFE9PmW7AKPuRG7sQ/F3y4D0Alk/hVigLXaaMEKs4/Mdhy26s3YNKUuysVSG3tsAFbjBUkdheJa826CqqzZMCclRUP9xr2jeUrbM4qemo1PSbXZS9Bk4hP+J01CKxZ1ymSVT7vsmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xc8bziotJWKrga2G1sGyOKtJsJFGRkCJBS5NfGrHgug=;
 b=FzvXahoDB5u27BvJ+6ki/6V2HezJrDJgeld4VGcHxKwGSzu90mbYLxv8mLgi1+O2AC6tHX3GUGa/q+8xfh4buzEhyxhuCSZtkPmqhuC9E2o+8ecv8SZVMszVp/ovrr4u3fDFSONEsPFMM43M+inG349tlvYBDdSXvtRUQtSWkfY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by GVXPR04MB10825.eurprd04.prod.outlook.com (2603:10a6:150:223::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Fri, 7 Jun
 2024 08:23:11 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 08:23:11 +0000
Message-ID: <84f4d578-8747-4c6c-bff8-a78a20fe9a92@cherry.de>
Date: Fri, 7 Jun 2024 10:23:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: rockchip: Add FriendlyElec NanoPi R6C
To: Sebastian Kropatsch <seb-dev@mail.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20240605155413.226629-1-seb-dev@mail.de>
 <3c422e9f-3cd8-4b24-83f1-d4ad6e7641eb@cherry.de>
 <0c74113b-aad6-4931-8832-651618b31692@mail.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <0c74113b-aad6-4931-8832-651618b31692@mail.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0006.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::18) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|GVXPR04MB10825:EE_
X-MS-Office365-Filtering-Correlation-Id: 15b198e3-d4ae-4c08-2598-08dc86cb1189
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NEovWjdNY0lham5hSUljQTZzSnJBcTlMbGRhWlhjT1d2UkZpZmgwVUx2WXBN?=
 =?utf-8?B?bWhFcm9mZ3BwUWhicWFBVm01YUJhRS81ODl5NHNGSENPcWtlRHVuL2ZSMllJ?=
 =?utf-8?B?M2pGYk93c3FjVlBlR0luQWtWV0greG9qWmJYODY3QkZlc0hjbHVrY1hNT29D?=
 =?utf-8?B?aU1NOFNROEVDeWpGaWJPRHRoYXVwM1N0THQyS2gyMmY1R3Jma1NMekZBaXI1?=
 =?utf-8?B?QjZCV0lyVTFSd0t2NCt1d3I3Y2YvUDNUbVZKUjF2R0FxYnQxVGcvN1YyQkw5?=
 =?utf-8?B?TUQ5SzQ2WWV6dmVVSG9yUURjMmw3YjJXVlNrY0VGeFpuaGJnNjFJNldFUzFY?=
 =?utf-8?B?NFUrTWpTZmc0dUk0eGFWemRML3dGdnRhUHlsVU52cXJyU3VIbnh2ZGc4ekQ3?=
 =?utf-8?B?dWs1VWxRblJFamg0V093ZWVuMmxHNmZCQXZSR25oVG9qM3VrSko1SXdSZXNs?=
 =?utf-8?B?TWNxSkluZGx3K1pyNElLTld1OWcwOGUyL0NFZEd0WURBcmQrN3lPWEMwdFNG?=
 =?utf-8?B?alRFZVhDL3FDVGx0WmYrZm05cERuNVZ3NjkyUHYzbVJoeXVNUnNrTmJDUkVw?=
 =?utf-8?B?RjYxVnAzbVlHRkExVVZpY1NiYWtxVk5NajBSN253WlVHV3kvRk41QmJaSk9r?=
 =?utf-8?B?WVhUdkxjL29pNVkzVDV0Q2hkRk1ITzlPNFloY2ZCWVlZaGhSZ04valRtSzdV?=
 =?utf-8?B?bkFjRkhLZFdHZjF3ZGpNR2JsM1E1TGIyL1gra1hNclE2YWk2VG5LTFEvTUdU?=
 =?utf-8?B?K0hoNUhxWW5WM0w1a1d2QUh5NlUyanR1STRmdUp5a3BxT0U0ZFhJYi9kMDdS?=
 =?utf-8?B?Kzh3M00rWlBXWHR4TkpQRFdrUVdMWVpLRUtBZURCazBvMVo5TzRCc2pRdzlr?=
 =?utf-8?B?YUdQV24wN3RPS3pNeVBOVWhwbWVpaTNBbm5XTm1PNkpEWFBRbUVZeXMwMEta?=
 =?utf-8?B?dmtEYUp2cTVKYzEybGFFdzNCdDhSVWtKVGNFaUdZL0xkekt6RkhXU2lPWmpy?=
 =?utf-8?B?TnV2d0Z4bjY4R2lNMWhaNkVHYmkrNlBMS2hNUjRzMUpMVGRyVFJQT3dmQ2hQ?=
 =?utf-8?B?cjhyUGFkQ0xmUGJPQkVIMENVVkVvSGN5eUFsY0ZUTHBvMG93VVRiYzRoQzlx?=
 =?utf-8?B?eFUvVzluY0s0d1FCWnZFYkhlZitHSDNGYUZoK1VKRWRibEwzSEhVU05TK3JH?=
 =?utf-8?B?MUZybEcrVzN6RFpqbGNDR0p6ZnNTSnc3S3FhcktQZnJxZTFlbUtFVWZ5NXZB?=
 =?utf-8?B?Uk9QWGkzbGZsNXA0VjIvK0U5Yk5ud2F6UlRwM2dSRnh0VEJ4U0pGNmVnOVUz?=
 =?utf-8?B?bUJ2bkN2Wk9CbmdRYVJPYVhNYmxkY2R3bVRpb2pNeCttQjFTb3lrOTMya3ow?=
 =?utf-8?B?OHJXU21JZ1JCV1JlWXVJNTd6TSswMVFCYjZFa3dUUGhWWlFzWnlPb3VJcW12?=
 =?utf-8?B?eHRUblVJM1Nma2d4K1NQd1ZMZXN3Z2RHZWVmYmozRE9pSEZQY0YzRjh0RkJt?=
 =?utf-8?B?ZEFDQk44WXRnQXdhalZ5Y0pMaEx2aytGd01pdE9iMGxOaVh2dlZENGxHZmxC?=
 =?utf-8?B?a05iUjU2eTBsMTV6REFOZWhBUUV3emd6VkxtWkpVRURtMTRlT0pveklRMDdB?=
 =?utf-8?B?blBUQlBaM3NSTGhLMUR0M3lSNTNLbS9ucGJsUWJZR1pGWmxjZ0NBRlM1T0FS?=
 =?utf-8?Q?DlZr0maFAgx+Co/LF0kw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmRLMWZqRkk1VkY5L3plVWdXTm1ZS0RkV0NpSjE2QXg5aWt2d1hGeGQ2OGRS?=
 =?utf-8?B?N3NSU3AwZjBRYXJESlhITDF1Y09RUEdDSFAwVjkrQ044dlk4WENZWm96RmRm?=
 =?utf-8?B?aTByb1ZVamxNbjh0b1FFQzNPT0lYL25sZVVjRkx1cWw5MmFLdmZGcEU3c0pI?=
 =?utf-8?B?YmdDNE85cFllUVZhbXYvRHF6R1NqYWNGMWNzbGFwdStRWWk4emtMUlM3aEpy?=
 =?utf-8?B?eitrc0MwWjhoSEU1YVlMckcrVWo0L3g2N01JU2VvN21KK3M2WnVqanlPOGIz?=
 =?utf-8?B?eGhUUU9FcFJ4TG1PLzFweFhYQ1UwYmRPNzN1Rm5FMERsc1NOSnNacjJZNnI4?=
 =?utf-8?B?aGRuOHFEcFZDaUp4Q2E0L3Z0TGRudkdQNmE2RERzUTQrM0M3QVVFZUFDVWdQ?=
 =?utf-8?B?TEtyK0RLaUJkOHA4REVmMzBmemc0dnRNVmZWZkNCZ3ArbjJKd2VicmVobHpK?=
 =?utf-8?B?ZUFoN2JXYnlSRDJ3eDU3a1V6ZStON0kwS1lNcEdlTVFwQjluUUxVWDVmaEc5?=
 =?utf-8?B?NVlHUnNoY3dRZS9wK3hHREFvbGpBekdITHJqdnNEenJ2Y1Y3cUhYR09Gc0hM?=
 =?utf-8?B?bE9mdjVNWkVlb2s4WlRqMkovZ0Fudy9ad09qTURoRDVnQWY3aUYxRzhZV3l5?=
 =?utf-8?B?eEVIUWxaNEY1NmdHOHhtbjQ2d2owWUR5RkNRcmkwVFkzUkt4NTVQMzhEU21W?=
 =?utf-8?B?Smw3OEo3SDhaYXJHeThNNW5pUlo1NnVEakpBdTBSY0pWRW52N01GSjdRNDFh?=
 =?utf-8?B?NHV5RzBsM1FjVXRhVnh3YXFicjlhMTd3Qm4xNnNMSFVuamNOOUxwbUpDNitL?=
 =?utf-8?B?ak5QVll3TXRZMlAwcVprWS9GaFY5WC91TEp0cE0xbi9SWTdOREJWK1BzWmg4?=
 =?utf-8?B?NXJvajZFbVZDUDBxcnRoUXo0dHZBM1BORm1wMlJiVzhzSXpLQ3lmUURvc3dI?=
 =?utf-8?B?TjFrK0x6dFoxblh5M1lMaTlzbFJhbXdEdG1GUzY5NjEyV3g2REh0OXltOVZD?=
 =?utf-8?B?MmFNYUFCZVgrb3JtK1FSSjd2ZTBhSGxyK3Uxb1Exc1RVSXpNUmh1L3IyanhX?=
 =?utf-8?B?aVlFdkRWcFpqV1B4WTRyS1VvVXA5K2ZSNGQwSVo1emxMaUwxSUo3UEdVQkZ1?=
 =?utf-8?B?b2xJbTI0eVlYeGs3cUlMWHRFS1Y4a0I4amlSUnpUb3NlcWZ5VTRqQlkwRjFT?=
 =?utf-8?B?T3o1WURiQllXaXhLRXZJQkdyZmF0bUdxZ1VvUTRIczJSdldGY1dzVG5iRW4w?=
 =?utf-8?B?YTZEY3lwUGUxanp1MnphcjNmMUhQa0Z4aDNzeGRpRE05VGl1SkVpd292M3Nv?=
 =?utf-8?B?bzlHQUwrTXFxRURjY093cVZWSC9iOVMxdHpLOG9pQ0JaMEhsNVhlYzB4L3dr?=
 =?utf-8?B?VXAvOFVsSUl4N3FlRXJKNHJUS0NLejFZUjk0eStkQUpVZCtrc2ZvSHhNZHJM?=
 =?utf-8?B?SWp6TERuL2pmZUVKNXU1Z1F4Wk5DQTl3VktHQVFVMkFiemRFc3ZXT01FWVZK?=
 =?utf-8?B?MjlESE1sbG1kVXRaMis0eU5XN2w0YkxvUHlHaU90dGhtVHFjMVFSN2xWQlY2?=
 =?utf-8?B?SVNEZC82dTZRNlNKbVlTODhKTjJWLzYrMVAyVm5RWlFHUTExZzNvYSs2eUVr?=
 =?utf-8?B?V1pLYmFxL3NBWWk5K2dUVFpoNTdRcmNIUjFxVlhPSzNrdjJnU1I0ODZnWk1a?=
 =?utf-8?B?NkFHMkwxcUdiZEtCUFlkeG9KaHhRQjh0ZjUxcmJ4bEtrSHlvOWUwRXR4amV5?=
 =?utf-8?B?MzduWXdTcldIUjZRZWcvK1F6eTF6LytodEEyWXBJdk4wdU1rTjRWZlgzNEtD?=
 =?utf-8?B?dXpjSWVvQnhwQzYwOWxzamFoajRaTzJuSUgySE1xNENHUTk4QlJpMSt1SWQv?=
 =?utf-8?B?bkJVZ015N2Z1SW5KSk9mTGM4WUx5OXBnQmVhekJBTDZGS3hSdERhcFFOR1I3?=
 =?utf-8?B?VjQ3WXNBeERPeGZWVXJUODlSVkJCa3ZJdTRaL3kyK0FYcGhmT3NtVDdnelN1?=
 =?utf-8?B?MFhTeGdaWDRLSFZyOEpWNEJOQkpxODFBL2M2WFcva3g4a2VoV1lKWmh2ZGcy?=
 =?utf-8?B?WGJUWlJ2bHIwWmxMN01DZkN0ejF4VmVaMENlVTdNQVQ3ZlBET0JvSDJ4cDlW?=
 =?utf-8?B?OTd6NG9NaWhmOUI5ODAvS0NSUjJCTTU5cFVHVjhuZTNESUZhUnR2azloSEow?=
 =?utf-8?Q?KJW2l7ScHuD6iSNKcsWoatI=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 15b198e3-d4ae-4c08-2598-08dc86cb1189
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 08:23:11.1733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9LpF/LonJnmkAtrs1BFsoVsxBEKQTiUnHGdacUwS3WE8VeXTNW8urhsKbVB9KxKYdJnJwbS960W7XfSZBuO7RR7neFU5pOQy34rn4KP/n/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10825
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

Hi Sebastian,

On 6/6/24 6:25 PM, Sebastian Kropatsch wrote:
> [You don't often get email from seb-dev@mail.de. Learn why this is 
> important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi Quentin,
> 
> thanks for your feedback!
> 
> Am 06.06.2024 um 16:53 schrieb Quentin Schulz:
>> Hi Sebastian,
>>
>> On 6/5/24 5:36 PM, Sebastian Kropatsch wrote:
>>> [You don't often get email from seb-dev@mail.de. Learn why this is
>>> important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> The NanoPi R6C is a SBC by FriendlyElec based on the Rockchip RK3588s.
>>> It comes with 4GB or 8GB of RAM, a microSD card slot, optional 32GB eMMC
>>> storage, one M.2 M-Key connector, one RTL8211F 1GbE and one RTL8125
>>> 2.5GbE Ethernet port, one USB 2.0 Type-A and one USB 3.0 Type-A port, a
>>> HDMI port, a 30-pin GPIO header as well as multiple buttons and LEDs.
>>>
>>> Add initial support for this board using the upstream devicetree 
>>> sources.
>>>
>>> Tests in U-Boot proper:
>>> - Booting from eMMC works
>>> - 1GbE Ethernet works using the eth_eqos driver (tested by ping)
>>> - 2.5GbE Ethernet works using the eth_rtl8169 driver (tested by ping),
>>>    but the status LEDs on this specific port currently aren't working
>>> - NVMe SSD in M.2 socket does get recognized (tested with `nvme scan`
>>>    followed by `nvme details`)
>>>
>>> Kernel commit:
>>> d5f1d7437451 ("arm64: dts: rockchip: Add support for NanoPi R6C")
>>>
>>> Signed-off-by: Sebastian Kropatsch <seb-dev@mail.de>
>>> ---
>>>
>>> Hello!
>>>
>>> The Ethernet status LEDs which sit directly on the 2.5GbE port using the
>>> RTL8169 driver don't light up when connected and I couldn't figure out
>>> why. The other port with a RTL8211F has no problems with the LEDs.
>>> Have there been occurrences like this in combination with the RTL8125?
>>> I'm trying to figure out if this is something that could be solved in
>>> the devicetree or if this is a potential driver bug.
>>>
>>> Secondly, the default active network device in U-Boot is the 1GbE one.
>>> I believe it would make sense to make the 2.5GbE device the default
>>> active one since this one is labeled "LAN", whereas the 1GbE is labeled
>>> "WAN". However, since the 2.5GbE device is PCIe-based, it only shows up
>>> in U-Boot proper after using the `pci enum` command (shows up as in gets
>>> listed in `net list` and `dm tree`).
>>> Do you have any tips on the preferred approach to handle this switch of
>>> the default active net device? Is this even a sensible thing to include
>>> in U-Boot in your opinion?
>>>
>>> Thanks for your feedback!
>>>
>>> Best regards,
>>> Sebastian
>>>
>>> ---
>>>   arch/arm/dts/rk3588s-nanopi-r6c-u-boot.dtsi   |  3 +
>>>   arch/arm/mach-rockchip/rk3588/Kconfig         | 13 +++
>>>   board/friendlyelec/nanopi-r6c-rk3588s/Kconfig | 12 +++
>>>   .../nanopi-r6c-rk3588s/MAINTAINERS            |  7 ++
>>>   configs/nanopi-r6c-rk3588s_defconfig          | 83 +++++++++++++++++++
>>>   doc/board/rockchip/rockchip.rst               |  1 +
>>>   include/configs/nanopi-r6c-rk3588s.h          | 12 +++
>>>   7 files changed, 131 insertions(+)
>>>   create mode 100644 arch/arm/dts/rk3588s-nanopi-r6c-u-boot.dtsi
>>>   create mode 100644 board/friendlyelec/nanopi-r6c-rk3588s/Kconfig
>>>   create mode 100644 board/friendlyelec/nanopi-r6c-rk3588s/MAINTAINERS
>>>   create mode 100644 configs/nanopi-r6c-rk3588s_defconfig
>>>   create mode 100644 include/configs/nanopi-r6c-rk3588s.h
>>>
>>> diff --git a/arch/arm/dts/rk3588s-nanopi-r6c-u-boot.dtsi
>>> b/arch/arm/dts/rk3588s-nanopi-r6c-u-boot.dtsi
>>> new file mode 100644
>>> index 0000000000..853ed58cfe
>>> --- /dev/null
>>> +++ b/arch/arm/dts/rk3588s-nanopi-r6c-u-boot.dtsi
>>> @@ -0,0 +1,3 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>> +
>>> +#include "rk3588s-u-boot.dtsi"
>>> diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig
>>> b/arch/arm/mach-rockchip/rk3588/Kconfig
>>> index 820e979abb..0e232ddfb9 100644
>>> --- a/arch/arm/mach-rockchip/rk3588/Kconfig
>>> +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
>>> @@ -78,6 +78,18 @@ config TARGET_NANOPCT6_RK3588
>>>            Power: 5.5*2.1mm DC Jack, 12VDC input
>>>            Dimensions: 110x80x1.6mm (without case) / 86x114.5x30mm
>>> (with case)
>>>
>>> +config TARGET_NANOPI_R6C_RK3588
>>
>> Please add the S at the end of the symbol.
> 
> u-boot-next currently has two other RK3588s boards, which are Rock5A
> and Indiedroid Nova. Both do not have the S at the end of the symbol:
> 
>         config TARGET_ROCK5A_RK3588
>         [...]
>         config TARGET_NOVA_RK3588
> 
> Which is why I haven't included the S. Should we update those as well?
> I suppose in this case I should also update '/include/configs/nanopi-
> r6c-rk3588s.h' which currently reads:
> 

Ah well, this went through the review process :) It's not a big deal 
anyway, so we can do a search and replace later if necessary.

>> diff --git a/include/configs/nanopi-r6c-rk3588s.h 
>> b/include/configs/nanopi-r6c-rk3588s.h
>> new file mode 100644
>> index 0000000000..e05856f3ce
>> --- /dev/null
>> +++ b/include/configs/nanopi-r6c-rk3588s.h
>> @@ -0,0 +1,12 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +
>> +#ifndef __NANOPI_R6C_RK3588_H
>> +#define __NANOPI_R6C_RK3588_H
>> +
>> +#define ROCKCHIP_DEVICE_SETTINGS \
>> +             "stdout=serial,vidconsole\0" \
>> +             "stderr=serial,vidconsole\0"
>> +
>> +#include <configs/rk3588_common.h>
>> +
>> +#endif /* __NANOPI_R6C_RK3588_H */
> 
> (end '/include/configs/nanopi-r6c-rk3588s.h')
> If this should not be updated to add an S, let me know. I'll send a v2
> when I know :)
> 

Nah, this is a local define, don't care too much if there's a typo in 
there as the only purpose is that no other file actually define it :)

>>
>> Otherwise looking good to me. I'm wondering if we shouldn't do something
>> for boards which do not need a -u-boot.dtsi. Here it's needed because
>> U-Boot would include rk3588-u-boot.dtsi automatically (because of
>> CONFIG_SYS_SOC being rk3588) instead of rk3588s-u-boot.dtsi. Maybe it's
>> too much headache for the benefit :)
>>
>> Cheers,
>> Quentin
> 
> Ah yes, I was wondering if my mostly empty rk3588s-nanopi-r6c-
> u-boot.dtsi was even needed, since I don't know much about the inner
> workings of U-Boot. I believe it would be nice to not need this file,
> but I have no idea how complex and maintainable an implementation would
> be. If it's complex I'd say no, since having those *u-boot.dtsi files
> don't hurt that much in my opinion :)
> 

This whole rk3588 is an rk3588s++ but actually we use "rk3588" for 
everything but actually no, the Device Tree base is "rk3588s" is a bit 
of a pain to deal with in different places :) Probably a similar issue 
with the RK3566 vs RK3568 I guess. And it's probably not going to be 
much more fun with the RK3582 which is an RK3588s--.

A few options right now tht comes to mind:
- add a new CONFIG_SYS_SOC for rk3588s and add symlinks wherever 
necessary to point to rk3588 implementations
- add a new config symbol for use here: 
https://elixir.bootlin.com/u-boot/latest/source/scripts/Makefile.lib#L162
- make U-Boot try recursively a right dash-stripped verison of the dts, 
e.g.: rk3588s-nanopi-r6c would also try rk3588s-nanopi-u-boot.dtsi and 
rk3588s-u-boot.dtsi

I think we're good anyway, so

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
