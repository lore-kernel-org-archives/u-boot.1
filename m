Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 685C1CD8CA8
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 06:35:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A49E08056B;
	Fri, 12 Jun 2026 08:35:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jpEyk3cc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EC7F839A8; Fri, 12 Jun 2026 08:35:08 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C587B8005D
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 08:35:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fk0mS14dIXEzEzOxVvVcRnUnHT6Fx1lVjDcu929yxVJO1DPIwSsda/VplsOePyZlqw4Q0D3LPn0TbKE4vyRfpH8RFFm7QRRJF5MX/ct5SZn86RoBNVvQ4u5ZlD6yGAZRsOPRkxBfuDIkNOgp7Wgdzvmmn7AxB41DHpRMSst1pxpFCH4nBG5eGYc8JKIauC2pQ1tDFTH0GVkXImpxeMvFYQykvy2x9hhYHi9SQPTSkj/Kaa4Fo1fnOEFHO7kEH49h+iXqY+YCmmC/IhVPDhWi1k4nrbbfWPQNnodgG+6vusu1mvupkN1an8l1hfgPilxyfIhAZBbOrVnhOG3uUPGiSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwNKykpOOGmoiq0a1xRbqfRGAtwjA3v8xzhsJy0Ye4k=;
 b=Vz8tBG4vJWlXFvO1X7p9pCT8nb/LFCpioxGIro23NAKu+XHWOBYFN3qvTRaeLcFVFOVKwYfCwxy7mu8gjLeHYgapEe3BuXt9yUIovpMkd97X0dNF6ansmBC0STTYzLlntStdIKJu57kOGOwiusIA8N09iyLSVAHYyhcGvJ6OTaiEVhyHB6C8duzvP/OOF4+qVzPt7O5gtBPkn60umHAeaPrLgE46w4zcqEzl62L20xQzRJAVPnwXrK7pF4iFgtpHR6kk/4K65T3hNglJbYvXXybVr+ILhl2BgcosGEfyWfefjMhwyO1RJCJgpXSte9uLge40ODBjP+WZQL8F9Yh0NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwNKykpOOGmoiq0a1xRbqfRGAtwjA3v8xzhsJy0Ye4k=;
 b=jpEyk3ccBbvI/zQSQuqt2apTKsOUo1bNOg5K3/CWoBjid6vsEXiLdAisr2nI45XLsfVwwiXWwK0ameY+PttWDsnhTyJs0BXvRx6KRUP+M+vKc2nSC5fGfXdmnzqduR4CEVh4wrHDskn+EDekClVRqE6bZaQNqM9cqL5KgDUx8No=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SA1PR12MB999086.namprd12.prod.outlook.com (2603:10b6:806:49f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Fri, 12 Jun
 2026 06:35:02 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0092.016; Fri, 12 Jun 2026
 06:35:01 +0000
Message-ID: <a5f929ed-f80d-4a0c-b332-b149567c4549@amd.com>
Date: Fri, 12 Jun 2026 08:34:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mkimage: allow zynqmpbif to use a register
 initialization file
To: "Erich E. Hoover" <erich.e.hoover@gmail.com>
Cc: u-boot@lists.denx.de, Sean Anderson <seanga2@gmail.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Michal Simek <michal.simek@xilinx.com>
References: <20260605135747.1814307-1-erich.e.hoover@gmail.com>
 <d36d8742-3345-46ae-9e8d-1c9ed1c49525@amd.com>
 <CAEU2+vqO_z7Y+LAEL6AEQ6yuSn4FxjcKbfb8hQc31kCBt3uSxQ@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <CAEU2+vqO_z7Y+LAEL6AEQ6yuSn4FxjcKbfb8hQc31kCBt3uSxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0347.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::22) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SA1PR12MB999086:EE_
X-MS-Office365-Filtering-Correlation-Id: bba87a36-01b9-4ce8-97b0-08dec84cbb27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|6133799003|3023799007|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: vjdrJUzGGaahZhZuyogvtnJTR7fjxVqammBKocaP7fD25DfbI3on4exL/RRhp8a5Fog+7ZPxdfJj6zlzivD9t5nKVb4LBpjfDAb/8CrMGWmtsnuM5G4jgTq39SSOqCRGV9M7fhNUa3NGNpLXNGYLxtFlVNeA8r4gPIhL8+JvQqf9BIfQNKkUPWuWjhyHchWTFD4bEsuied2eMLCP8G1HAIOx1k+CRzV30JtvAO0vpO1o4mXm7AI1Aziz5zoeKZGYHKqWTh9jigyQ4yF4r5w4Zfm1clJuIQtdVLOcgGh9Iue1hbyal0EDyoZfCJjSk2Xq1fWY+6BDXKGQGjxuAqeS6Ed2r6KnO5lo6H+IgeOBaftWrSVI11nppr9FCZzEgsUuT2yB6HpkDCbwTXS2hAgWiamQsAVUgutcAMC85F4ln8Vmgxc2SgZlo3H9u6nAb0Nvy28gOMu6Z5IV//Hw8qIKvsD+CbiF5o4d2gXffuo+QoFETaTaiBrjpH7NyYRYzdlZZ9LQyyPwlSdPTwIhzrVT26o2ww0qjf0O2iRFTTc6x1BdJ4cW6I1DjwjLf4QtXQ2hq3xt/7yi7vwX0vWPwbzIHRYSnyH+o+yIGjCPWyC48unO4qz7c1DxuvZlIYZIm73nrTtFC1/Vxyqj3Beu4bJDokIR5ln362TN+MUZ8ZM0jFA7KGS1VDeesFv07JqvCBmWmDPSgoaszcg9MxI+zVEstg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(3023799007)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TllodTRvZ1hUZVNYc3poSnZ1bTUvdlNsdnNxdkhMWFg1UnU3Z284L25tRHZF?=
 =?utf-8?B?bjdNbmxvUVNkYU9DL3lpVzN3OEU5aTVNN05pcW9zRjQwMDlBNDV0bmlVdWY2?=
 =?utf-8?B?Sy9vM01QQllMd0lSRW84WWlaaUVzU0NPeEIrNWd1akhIeDdrN2k1N3prUnk5?=
 =?utf-8?B?Ri9IWEh2V0NzZVA2K0JaS0lReHlMbjNUcDYxN2owUXNOZktNcmRiVFZkamlD?=
 =?utf-8?B?d1BGL0Q4SEdnWVloOUNvWllkNXFUR3Z6TXdBbEdRUWVOYUZDUUxCcVlib0VV?=
 =?utf-8?B?OFU5Mkpta0lSek5SUmNndXZrSVdnSW5tVUthV3pCWTNxRnFnaTdsTVJCOUlF?=
 =?utf-8?B?NEFJRm5IZzFIWUJqbCs2NUs0NGpnTDFGTmFCNVZtTGpIaVE4U0tvdjdEci9i?=
 =?utf-8?B?Zng3SkE0anZpWkFrVjRmeGF2SmYwUHN2VUcydjJMeXRrMU5ZTGQ5cVRaRFp1?=
 =?utf-8?B?cWhyallmeVFYbTd4VWdVS0I0NlVpcmZmRWl2dDg2VGhMbnBYckRmV3ZMV0VT?=
 =?utf-8?B?WkJDR09VUytFMjc0V2pkenZOSUxjMWdCMWV3MnhNeURUM1BhK0ZrOVdING1K?=
 =?utf-8?B?aG5WK2pyY0xKTk10UmVtdzU4a21rNWRUSVd5ZC9Fb1gvZVNEa3FuNTFCNlpL?=
 =?utf-8?B?aitmQmw4S1RKZ1gwdTRuRTBnenY2Sk56Y0pQUEtINVdTS2ZQNjdnNGEwelhy?=
 =?utf-8?B?QkFOT3N3MGhTZktBZXNUYmtJYllCcVJBYnhEWkxCNEhQYjB3aWRRUnh3em9m?=
 =?utf-8?B?czQxTlZXWmNJUHNWeVRwaFZ6UmoxS1NGYis2d3pWL01uS3FhWGFpM0tCNmF1?=
 =?utf-8?B?Q2dPeTZSMEZqUTJHc3E1QmprZmJWeE9YWXE5Y0hjei9nOWF6TVpJT1lKSDVI?=
 =?utf-8?B?MTJPMERlK2xiTWlxaVpUZ0orTWlueDFhRmtMMlAwMVh5ZlVDUXRIVmphYkRE?=
 =?utf-8?B?WmpaTHU1b0ZRdUExa2pRZ3hjMWNhMWNOOWFLdFVJUkNZVnJwdWVBbkwvWjR4?=
 =?utf-8?B?V3BaOXZUbm8zaEpqZFZOSGVSYkpQeU5tRGVERFdsSFZ6a2lEUHNoRXhnTkov?=
 =?utf-8?B?dHFadWpQcGtaRy90MlFFV2hCUTFtMUpXTWlTMkQybEJKWTRvWFRDeXJmcmhI?=
 =?utf-8?B?YTRXS1Q5NU4vUzh5cmVQbTF1bVRlakpDN29ncXFqL1RaTjZ4NHV0NWR5cXFN?=
 =?utf-8?B?aURMMlY0OElXSGlacU5tQWlGNW9WUVI0d1UvdTFLa2NEVWJCVEJUR0kvZjM4?=
 =?utf-8?B?N0ZHR3laak90S3RCWUtIQnlDK0N0a0RMSCtEdmdGWXNLek56OFNSUmNWdjZw?=
 =?utf-8?B?dEtNTEdBQVFLU1RZVmhGcWk5dlhHTDZvM2dCZ2NLbnpoRWRWU0tBZ0ZkTmM2?=
 =?utf-8?B?NWpqMmkycDh3SWZQK2dFckVlTUFYQXVpN09yR2I5OHg4T1F3RDc5T1hDeG11?=
 =?utf-8?B?L2twNnJOenBTY0Jyd1hiMjRmNU9CNzM5eW9KalpReEQ2eTA2TmtmYUdtUS9M?=
 =?utf-8?B?ZitWejh2OXhZWkZSS2VkcFBWSGxFTWkxcys5RnV5LzI3R2t5dVo1RnJScWl1?=
 =?utf-8?B?K01OK3VRc05WNldXMnVBZ2JBdHZlMEpwb3g2a3ZWeWhRY3FCTkF1NjNDMldN?=
 =?utf-8?B?RDI2aTRPS200Z1ZGaFg0Rk8vakQ1NE4wNWJwMEF2UlArYkNuRHJPS3ppNkV2?=
 =?utf-8?B?RHZLM1M2SXVVV1FrZVEwSnJ6eXRjYzZWeXE3dXhtclh6NUdhZXBnU1Q0YVJl?=
 =?utf-8?B?dGRXZGpUbS9aUmdqVmRRQ3YwNUo2QVRIZGtwM3pNR1JuRVVFRVA2YkFVdGZV?=
 =?utf-8?B?bXJBYnpKdXlVLy83NUJkZmw0QWY3RWhoWGRiOUZoKzBRcHJQZUhlZ0lEdW1H?=
 =?utf-8?B?ZTM4ZkFQMWJvaVRUTzVQcWF4eFo5a29aeWFscXpmMTRFMkloM0ZQR2ZnZlh6?=
 =?utf-8?B?Q2x5S20wN3phZVlHUGxuUXZ1RXRROXBvZWxqVTNxd0dCanQ3Skx3K1Y3SEZN?=
 =?utf-8?B?UU5KcFhxNm9XYzNxR3c0UkU2YW9LbmdJaHErZkVxbE1rWmpCemg1eGxjYTFM?=
 =?utf-8?B?RlhqWnFBYmkyT1BYVjZ5UnoyZGhKZHdGMXhPWEcwVkdGbmQyandoNW5vcm1s?=
 =?utf-8?B?eUVkL05hZWh1bG41WExsSUpyTDNHZ0Z1VzhrdkMyMXZYT3BXWVA3U0E1RlNl?=
 =?utf-8?B?b2ZhKzhmZzhGaWIzNU5kWlRQRWhrRm83ZVNGWWY2eFd4disrU1NNNG1abEJD?=
 =?utf-8?B?a0dPMXNLVDZqZ3dmTGhmdUNmSmNnZnBLb3RwTkxDZTVFNi8yZVFrZExSNFRR?=
 =?utf-8?B?QTF5a1ptMkNaN2RtZmdFdVJNaXgwcktJOVdic3pNK0d0R2lnNXM4dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bba87a36-01b9-4ce8-97b0-08dec84cbb27
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 06:35:01.7467 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DnHu5fYQuOnUacw2CFOH256J1uj8oNnaHSDEvf6HVWfUUxikEbA5x1gG5I2SvI86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999086
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



On 6/11/26 16:09, Erich E. Hoover wrote:
> On Thu, Jun 11, 2026 at 5:31 AM Michal Simek <michal.simek@amd.com> wrote:
>> On 6/5/26 15:57, Erich E. Hoover wrote:
>>> ...
>>> options, like so:
>>> ===
>>> image : {
>>>        [init] fsbl.int
>>
>> please use different name then fsbl because fsbl is not doing this programming.
>> That's done by bootrom itself.
>>
>> Topic board is defining it like this.
>> board/topic/zynq/zynq-topic-miamiplus/ps7_regs.txt
>> but that's for zynq
> 
> My apologies, maybe "reginit.int" like the example for the Versal in
> UG1283?  I'll remove this line as well, since that's more specific to
> what we're doing:
> [destination_cpu=none] fsbl.tcl

definitely not fsbl.
reginit.int name is fine.


> 
>> Actually I think would be good to recap format because origin format
>> is different compare to what it is used by bootgen right now.
>>
>> https://docs.amd.com/r/en-US/ug1283-bootgen-user-guide/Initialization-Pairs-and-INT-File-Attribute
>> ...
> 
> Are you suggesting adding an additional comment to the commit akin to
> "This currently uses the same register initialization file format as
> zynqmpimage (ASCII text hex values with each line composed of a pair
> of register address and value) and is not yet compatible with the
> format used by bootgen."?

Description is fine I would put it as example like this.

0xff003248 0x12345678


>>>    static const struct bif_flags bif_flags[] = {
>>> +     { "init", BIF_FLAG_INIT },
>>>        { "fsbl_config", BIF_FLAG_FSBL_CONFIG },
>>>        { "trustzone", BIF_FLAG_TZ },
>>>        { "pmufw_image", BIF_FLAG_PMUFW_IMAGE },
>>> @@ -279,7 +280,7 @@ static int bif_add_blob(const void *data, size_t len, size_t *offset)
>>>        return 0;
>>>    }
>>>
>>> -static int bif_init(void)
>>> +static int bif_initialize(void)
>>
>> What's the reason for this rename? I don't think you should rename it because it
>> is just distracting.
> 
> I was trying to match nearby behavior with other flags
> ("bif_fsbl_config" as an example).  How about I change the new
> function to "bif_add_reginit" (similar to bif_add_pmufw instead)?

If you want to change names to be aligned, do it in separate patch with own 
description. And no issue with it.

> 
>> Anyway I have tested this patch and output looks reasonable. I would obviously
>> prefer to add more features there (like ignoring comments) or unify the format
>> but that's out of the purpose of this patch.
> 
> I would be happy to add some more features to this, would you like
> patches for this added as part of a series or submitted separately?

It can be done separately and I think it would be better for you too.

Thanks,
Michal


