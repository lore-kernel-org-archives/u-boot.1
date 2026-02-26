Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B56DFD8FC0
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 14:54:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B60A83E88;
	Thu, 26 Feb 2026 15:54:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="irCYgaG8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2FC783EB3; Thu, 26 Feb 2026 15:54:05 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B99FC83D8A
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 15:54:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dLyiYjPtx6+WClJrBAPU+35HIycxHSrfEA+TOWiXCIyZhDX1H6QeAd6UJ8eoyAtCcb8pJQL7WOuzIpxMMZRfYzg2yWBuWae0wBiKOzkGOcMW65aMBAvw3t6mYR16xExzpPNmrxdyQbIykFf09mRZ8MxVaKyW0ItwefubewrEv0thQDIkRoGyn35qk60IaVSTlJjR1uAcWyylcRquKsjkTei4LcY95JpYmbLgEAPlZSstPACgLTwGXp2BcTGVAm1EZLeFjcKrsVw5hc9yjJdEVRhchRit7I6Ep3RX3q+LEfTvvZw8TaTDZ4EC6qbT0MB0wHZWgTJz6UMo8W68Rmarcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDyCMTQpkmT791FhJAYPQkhlEYXkuK+Nu1p5y40ihOY=;
 b=DOc65Ob+nEGNxxl1OMS2ZetcfvfvN3/27chp5hIic3kQyZuwDFjx0L1xuDOa+rX9V7wt/fvkLjPJhWYWlRXtWzkaseYhCtqV+9B6DXhUSa3N9iRi9q3i5au3D9gwin0pLyY/y4Qh3ILjzrsDlLnZyhhnBIJ6uQ/C3DJZMhb1FFNtM8eTlZVkOABHcfouUFFS9hRc7+JLBlYoaxFynMp+7bMQ+xA9QOKEYrom1diNPRArNhye2UB2+/YUdNy9WggooZiwqSagYAhoxiCc44h66Ob+SdOdznrOsXkjxMpSVevLc+PD/lBWQnCQy2PkcJAeM77C2QvpdQgtBs+nVIggBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDyCMTQpkmT791FhJAYPQkhlEYXkuK+Nu1p5y40ihOY=;
 b=irCYgaG82GFNSLiD7TTeNn9g0efaK3IOIwBlUROG1FTbjESmY/hqOGGXgQoWFQXxTpANu3JxFvqoj4C58iFp0QCiYnO4tmcw2tA62FwA1YZ5t2oroxq0pPF/y1k6sqtfmbc5ZVphY4lccZBCXLBDAoqu20Eqe8w0WVVsD0Mq8eo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AS8PR04MB7621.eurprd04.prod.outlook.com (2603:10a6:20b:299::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 14:54:01 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%5]) with mapi id 15.20.9654.013; Thu, 26 Feb 2026
 14:54:01 +0000
Message-ID: <8f18322a-e269-4839-a178-6cd2bf4aa488@cherry.de>
Date: Thu, 26 Feb 2026 15:53:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] boot: don't select non-existent CONFIG_VPL_CRYPTO
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 George Chan <gchan9527@gmail.com>, u-boot@lists.denx.de
References: <20260225073711.51688-1-heinrich.schuchardt@canonical.com>
 <ee169196-69a3-4003-8531-0ffa4e76bf6b@cherry.de>
 <e9d98d0b-578a-41ef-9440-00ea615d224d@canonical.com>
 <d00103df-8188-4039-b618-dc48ab1c1a39@canonical.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <d00103df-8188-4039-b618-dc48ab1c1a39@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::7) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AS8PR04MB7621:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fb29a32-c320-4eaf-cbaa-08de7546e088
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: pXdFiSDLCs4jnvQnmuRK3mXYr3ZAOiJC0sBCsizSKE8OUtfmHqW4q6Ckjh9kpisy+2N/5C6GZPpV+BJvt4tmNeFAo7+FQs/MOX8Z6Nm/2lm7qTM+3lxSf2TsvE9g96W2RkE0rm2EtmehGtffI41viYveNq2gytMNULsNNMWx6Oz5i2wIb/aLBusLcn4LUF7/YqhOxsGMYcGp7SM+qlY3zVJoQHdGy6BijAP9jkCZXzMDPb8d+7szxG0yrDhEoYWf+V2n6E5VAg3IiFqxe+3ZDCfg7pBZKVu3iwilRbNV0lKB6KgZbnYinCsPiTWiRx30cB8CBGfi5ga7NMwcJDBwy4zpDRPRXIZBm6b/2bAHjhc4K8cqIDcD6/bK4pJZSnmweQLz9POv+AtNEm4VqnUi1q+/p+NDvDcuFQduB3lDkQ+yPoZF9Ugyb2CAKlb3dwtCWaul9uL1eghuBbX9Cg7LlopXt7fOJqu0eeftDDjNmPFoYYGMagLBU7ddPbiqNiRr1i9czcvNXOSSxMX51js2KG0DLEnaSGwOxHqC7h2Bmn3zgHRTyzwbGOsmjAG+YyEKhR7xZ4/Qw21m9D83slgnEufMfbAPgWHIiNEl89+JT94O9yZa/Vn4HIgJJHOo6ps5ETnq3+WHIiNUtv9VbyDC6Wrt1Bx8L2fpjh7S9FjY15WK3ZmrLmQcNZ9jy+76Z2zp5IQ/047HtpHVI/4ZnunGzkGq0G93qH9xiz3Ew6v4zJw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3E1M00rbG4rSDV3aEIzSTNMZmxzY0JqOXh4cEhGcVp1N2FMSGNuWTVGT0dU?=
 =?utf-8?B?bHZtVy9jRXptR0ZsTms2VGptZisrNzZYOVlYT29xaXQxdEFIUVlxTlR5YXdD?=
 =?utf-8?B?UjRrL2x1T2hua0UyV2JFYW5kMmFmeGg2VTV2M3lxN0hsMmQyb2tOa2Fxb0kv?=
 =?utf-8?B?Z05zelRXdXZUZ0pVc00xdzhDOTZ6ZXRPWXhtS3VubHJIL0p2cHluK2t2UElw?=
 =?utf-8?B?L2VoUGJNN29rMUZBOUlGa3I5UWpqSGZJallZL3JzUmd0Q0x1S21oalBXSlNJ?=
 =?utf-8?B?QUJsQTNUS3dSOW5PSVc3ZXdUUGJERXNFR3ZFRFV6dWNLeWt5bUFqMlhzRUpG?=
 =?utf-8?B?STkrWlcxRUJTemRnWVZEVWtQV3Bsbm5RRlBDcWZ6Q3c4S1Q3OWx4TzdJN1FY?=
 =?utf-8?B?MGNmbjZwZ0YzdlFJSU1GWW81S3Z2NFJsK1FjMStPbW1ySldiMUFzMjhJamYx?=
 =?utf-8?B?S21xcDBCQWVJb0FlbzBxdkx5OWcrdkMvbUZBYzVqUTBnSHNHdDltSHFQNFli?=
 =?utf-8?B?V3B0b25naE1lMnBpYUZWQWtVS3cxV01lL1RxNkwxYVlRWThYREU2dHZmbUtz?=
 =?utf-8?B?azdBZnJOV2xKSmVIQnhPRXNxK2l4WHZTNXk3Qlh3UnlDWXp4bmk3dzVnYWg0?=
 =?utf-8?B?S1hHcVVvTXFQVVNBcGoyZDBRUkhJcVpNaU54dlBlczkyRGtBQ09WZFE2MHBz?=
 =?utf-8?B?SVdTN1Myc0poY1dWT3JKQllpY3Fvb1IrMzljWW1JcW9UVmRwTWFVR2ZxUm44?=
 =?utf-8?B?dGxOTkovbUZPWUpxTzhwZDEvWHhhL1VMZHBwYVl3akRTTWR0VnJidlRvSlJk?=
 =?utf-8?B?TThwZmJJMmpxaVptalA4QkE4bTFHQmNrbUduem8vRGdiakR6Q1M4ZG9ya282?=
 =?utf-8?B?ckxCRm5KVnpUS2xraFhpNEsxNzBqZ29xd3ExTWZINzMxdFl0cjJFSHdDUXRt?=
 =?utf-8?B?Mlo3RWVIcGRuWWM4bWJ5VnI4NVdxOGl3KzQvd0dHWVI5c21RcXBBcHZGaFN6?=
 =?utf-8?B?emRhT05TOUZoeWRUMURNODd6VXBvK2pjUmN1emxVYTRGUjNBT2dnQWF6Z3JZ?=
 =?utf-8?B?QnpKN0xRNG5GT0luSnpmZ2kxRlFVbDhqQVc4Z2ZzcHlXTEVIWUV1YTA2THl5?=
 =?utf-8?B?bjdQRjVhK2tRM2pOLzcxdkp2YUFqams3dEFtbG11SnR6bzBYS1lIbEswTVhZ?=
 =?utf-8?B?MEl5a1Jyc3FOSDgrWmhUU0gwMFdLZmZwc3ZXdkcwTE4vcC96Sjc5cWl6STVn?=
 =?utf-8?B?TE1kbXdEekxDM0hmMjFVRTd2Z29GaEZaQ3lpNGVnRWNJZ3JaR25ldzh4V0J6?=
 =?utf-8?B?OXljbUQvVTRKTGh6cUdORUlhZmtGTTJTVEovakpCMnNYV0g4TU1zSmQwYlFn?=
 =?utf-8?B?Y2tCZTI5SUcvRG1TemhmUkx4NXVsMHp2eW1vbFZybVdwOG9BaUlNSWNOY2gw?=
 =?utf-8?B?Z1dQKzdnWmdSZlM1VlNrUGFYSVdhcnRjNjRvU1FWdjl0Z3ZYVURlckUxemg1?=
 =?utf-8?B?ODErMlBoOWRiZzhOVHFGMnJpTmdrTG9yYXJaTTFvSDJabkJIVTJ5UWd3VFli?=
 =?utf-8?B?S3dXOGhSL1RudXBHWks1TGdyVWh1TGFOZEs1ZUh1Ym01cER2d2R1Mm9ia1dz?=
 =?utf-8?B?ZHBCazZ6azRBV242ZERjZXBDcW9BSVJrcUpxSTJJTEtUWC9ILyt2OFFRdGVH?=
 =?utf-8?B?R0VQcExpdThYNmZZdmxHYTREMkdUN1UvMXZxd0hXc3V5WTV0QVZUcnNYY3Yw?=
 =?utf-8?B?RllBREFRbDM0T1NhVkxTaGlVWk5NOVVsNjZTdFNYQktjSnB4VklDRVJCZjh3?=
 =?utf-8?B?cmdFOWdlTGNQZnVGWEtCRGt1d1ZoY2I1V2J5YzBKdlZJOHdNbUVLRWZLeHNJ?=
 =?utf-8?B?Nm9EUnRlRWZRejhFMVlrd3RRc1JtUHlLRTZic1dUYXRteFVkNVlnTEpyd2x3?=
 =?utf-8?B?T3dQbmhVKzhxYzl3UGh3RDRnQ2tFRGFzL1hCUW9iMGM4SlNKeEpOSEZjTjFG?=
 =?utf-8?B?M0p2akh1QjR4NzV3YWUxTFE0VUswYjBXbFY0QWFhSG4zQXBvT0xZMFRLZEoz?=
 =?utf-8?B?Y1I0VU90eGVISEwrRXlWWXBNM0YxSTJIbnVvRkFzUDl1MS92eDllWVB2a2sw?=
 =?utf-8?B?UmQzaU5rV2V2RkNWd3AzWTMyOU91cTFLMmtGY0Fzd3hXOXFlY2liWk54Sllo?=
 =?utf-8?B?eHMvR0tkVTc1VW1Vb0N2aTB5U2pVQ1FNWk9CcHc5cVJ2YzU1dzkya3czcER0?=
 =?utf-8?B?ekVyLzFGdk9TZXhsSUUwNTJXYjhGenovTDViODRZS0VxbzlLQkNtR3luRnJa?=
 =?utf-8?B?MzNUWE5JdDVONTZ2WDA0NlhwbWFjdzM2YlRod1kvVlgyYjNZL0cyUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb29a32-c320-4eaf-cbaa-08de7546e088
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 14:54:00.9761 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a4IcVMpCSc8GfFANW6mEpVM/+60Tj4GbTuqug6/P9uQ2nhDtqsb58h2aar4Hp1DQoT4K0PH8ITysO34D71nKVc0FKAKuVveU9OtN3y5im10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7621
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

Hi Heinrich,

On 2/25/26 1:21 PM, Heinrich Schuchardt wrote:
> On 2/25/26 10:06, Heinrich Schuchardt wrote:
>> On 2/25/26 09:37, Quentin Schulz wrote:
>>> Hi Heinrich,
>>>
>>> On 2/25/26 8:37 AM, Heinrich Schuchardt wrote:
>>>> Symbol CONFIG_VPL_CRYPTO does not exist.
>>>
>>> Correct but I have a hunch this was based off of SPL_FIT_SIGNATURE 
>>> which does require crypto support, so I'm assuming VPL would too.
>>>
>>> But this symbol indeed never existed, and even if it did, it wouldn't 
>>> compile anything else as far as I can tell since drivers/crypto is 
>>> enabled by default in proper and only if CONFIG_SPL_CRYPTO is set for 
>>> SPL, and only SPL (checking for !TPL and !VPL)... so something feels 
>>> unfinished with VPL here to me.
>>>
>>> I'm not sure we're improving anything there but I don't think it 
>>> makes things worse, as such
>>>
>>> Fixes: 4218456b3fac ("vbe: Add Kconfig options for VPL")
>>>
>>> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>>>
>>> Thanks!
>>> Quentin
>>
>> Thank you for reviewing.
>>
>> There is a symbol CONFIG_VPL_MBEDTLS_LIB_CRYPTO that might be used but 
>> then VPL_FIT_SIGNATURE support would have to depend on MBEDTLS.
>>
>> Maybe Simon can inform us what his design intention was. Adding a 
>> defconfig actually testing VPL_FIT_SIGNATURE would be helpful.
>>
>> Best regards
>>
>> Heinrich
> 
> There are more non-existent symbols implied by VPL_FIT_SIGNATURE
> 
>          imply VPL_RSA
>          imply VPL_RSA_VERIFY
> 
> @Tom
> I wonder why the VPL feature was suggested if it was never tested or 
> used. Should we remove all of VPL?
> 

As far as I remember, VPL was a necessary step to add support for VBE 
(Verified Boot for Embedded) that Simon was working on. I don't think it 
got realized entirely (upstream I mean) which may explain the current 
state of VPL symbols.

Cheers,
Quentin
