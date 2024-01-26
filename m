Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED28C47DDB
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 16:18:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEAB4878C9;
	Fri, 26 Jan 2024 17:18:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="KrSrFt6k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DE9C87C28; Fri, 26 Jan 2024 17:18:14 +0100 (CET)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2611::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08097878C9
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 17:18:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3/9y62V8FpDeadzUNiBDEtAIRZCuIdFs+t4r0lpSCcw8YCJVIlnKEr4iEGpCXalPz2Qa2mpCOHFib45InDmTpFUv9OxxRHYnlgb8I9Ppz7c9c/2CtdcDVn9pf5pif60aeH+1YO1J9lBK/KJLJ+qdIwcR05b6yMPZlXf1Gv2z1i8elhYhUQfJ8KrnYrTjsPh//HEQnMC/Nc3nJSY6vxb0Zz494FBys5gyLzmG3WsEPYyPrL5ZSy6MnI5lubcPXh74UIicE6j89C8EPiPNyJP0/017b7N3lOhXxI3XbnKN3wtLINz6c/wPgTxF2BfYydlARyYvVCgtVW3hXk4uLJS1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvFinApzR5qON7QOPbTJsN1tjFzxGJLjKKe8qwKX2Tc=;
 b=bnZSJQ6God7As2Kj8+yF3WmkrOztGcMfypBjE1qAmm7OPFgD32ONDrjhPAMsoomBX5vmD2spO0xXMshobC3h2oadczOlRJlRJOKfvaZ8w8Jm3AozhNBoNdG+JOeJcbCuy1XNMPguybYpwxj4qFHXDsLK2atteFdSb7GqTKX70geu4QZWboeJmQk2r2BFvcpMS0wFraWm3auTTsBPk8X9VYWlvGVdZmtjYAuGVBZhWFYycT/kO8yi+YifiSpi4DWCMouoIReQIQr4vOaDd5s7qZEKfBiyF5tZYwLjL+JKuJGdFwoHZqHE1NB24wRHaReDAczt8HRNPca+l3SspBO6AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvFinApzR5qON7QOPbTJsN1tjFzxGJLjKKe8qwKX2Tc=;
 b=KrSrFt6kZxRGJKYs0rfeN+VEACg+OtaYaOyC6GpA90aU2+vy7es99OTMGvOPTqaZXkXOylbVQIaCBR2nm2/kYrtcj4bXkaBNqoggOz75wvbi1lzSixuk7altOPRGDgAHWmekmJZaP7j7G3SaeprTndLU5Dqd/v+PGhb7EeWvDNrjQOWjsYWbemdpfibmgVUaQmIWJRec7fQuB5aMXUOpe8VWVR30qJVfTRQYUFD4kMrHBSC3Luhtfxg5m/w9+gApss7zoBv3kvFaLK4mWyfMDGZrQHHHYb60Gd8bz2pI96YFgRqvLQ0iAOi5J1Z8wAAdkQLB8r4hic9aYEoWvlDHDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AS4PR04MB9550.eurprd04.prod.outlook.com (2603:10a6:20b:4f9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.33; Fri, 26 Jan
 2024 16:18:08 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%4]) with mapi id 15.20.7228.022; Fri, 26 Jan 2024
 16:18:08 +0000
Message-ID: <7b5cb03f-c2b2-4cf2-b06a-751d7cc978b9@theobroma-systems.com>
Date: Fri, 26 Jan 2024 17:18:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/18] rockchip: rk3588: bind MMC controllers in U-Boot
 proper pre-reloc
Content-Language: en-US
To: Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Otavio Salvador <otavio@ossystems.com.br>, Andy Yan
 <andy.yan@rock-chips.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin <agust@denx.de>
Cc: heiko@sntech.de, u-boot@lists.denx.de
References: <20240123-jaguar-v1-0-1eec1c34953c@theobroma-systems.com>
 <20240123-jaguar-v1-17-1eec1c34953c@theobroma-systems.com>
 <062d9519-f129-422c-89ed-3b009e222150@rock-chips.com>
 <5f4c826e-9ecf-4620-9430-b317e472cfd2@theobroma-systems.com>
 <928cfe56-1a7d-4024-aa9b-c14654b150e1@rock-chips.com>
 <f2ed9f73-97bb-446e-9396-9de3ab01b8d5@theobroma-systems.com>
 <8a101c97-cbd5-4e99-b89f-49fbe8fdd59b@rock-chips.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <8a101c97-cbd5-4e99-b89f-49fbe8fdd59b@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::19) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AS4PR04MB9550:EE_
X-MS-Office365-Filtering-Correlation-Id: a3106189-d55d-4daf-29c1-08dc1e8a6271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KHmErd3Nm5gB1yCXPJoH7Oai3i67T2UMCXKqVAm04zfqAHukdSD7pVbmraANIq4V4dwz7kq1fwxIiAHawgbCykv8pL8tCqCy5QB19UATdPMMOVqOvX1mn++4eV84Z4Qr+1gDWkYoruetV39/vVUq1G7dijw7CmKf2oo7Mm2AgyAlsCaJNKygQQF6BbaYbUKzWczGGxPq4Vg4SfcA+fX6dcDQDgmhaNvQn3dw5e/t24+tVfKvZaImD2lJ95LjrLPZCnE1vC5CIcdyqq2WMajqMZkMS8z9EC3ZgB4o5UiCphko1A8ASJxHZmWk/dGdgWLzWB4c0xk5Oh8Pttkna9jRuTdcyTdkaYFdBIJ4MUNLqBhdijqJegt5egwdmKeScoI/mf0j37A8hhMVpBQDRhFBzfRN/QwXkc3A4bIh9ckjDZDSrna2Y+7ES1tkYggiikGGF4R2YJVKf0wh1TyUSYJegIOL8BRCpkI1xrq9AkHJ+3nAxp6p4VHBkpeRMsaV53FmiCp8eDjlHUpybE7uScNePgxcatk4rYqJhCMxt1CSrKt4ixFbXDwLv3HHKAr5C8ZEQOkpsQcCka/zvEhi5d7DClvZnLoPTYMvBTGmmL8Kh/XppgVAH9F7J2VuWFj4DPCWWeV13HWB1c6k1B9pi748sy38FU73Pq3yC9cGvMbKVys=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39850400004)(376002)(396003)(366004)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(921011)(86362001)(31696002)(31686004)(7416002)(6486002)(36756003)(478600001)(2906002)(316002)(2616005)(4326008)(53546011)(83380400001)(8676002)(66946007)(66476007)(38100700002)(6512007)(8936002)(44832011)(110136005)(6666004)(30864003)(6506007)(5660300002)(41300700001)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTFBcFdsTUcrVXV6V3JqMWs4YmhLaUpnTE15QU9JTmR3akNSVXRSOHhYaEtJ?=
 =?utf-8?B?WjNJcHQ3VE5GK25FSVZ0aC8zU0llNVdkM2o2T0JFUVRpM254SUx1N0RFOTNI?=
 =?utf-8?B?bW9XZkwyRk5ScnAwZitxcmdBQWRuS285UDJkTnFrSjJUcWxnb0dWbndOWkZ0?=
 =?utf-8?B?S2prckJNM1dzekh5VW94L2NoeHE3OTNBbkEwbWxCUWZTTlpWNU8vaTY0OFZT?=
 =?utf-8?B?a3lRSlZMdkhudGpvQVM3S2dJRDAydUU3SERWTFprSmpXTExZSnpiZzF5WTgz?=
 =?utf-8?B?cVFabEhTUmRUTVhRMHp6MFVNaUR2VGRZWGdvSm5pWG9qTFQxWTVWNWx3K2Zs?=
 =?utf-8?B?WlpMKzQzS0FxcmVwZWpsNm9nVHBFUnk0d0JCVTVDS2JxbkdKVmdUYUFXaCsv?=
 =?utf-8?B?WjJSTDBQV3FJNmxHU2ViWms0N2VEcTBFRUpYRDNFM0hPeUV1U3RlYnBsOFVw?=
 =?utf-8?B?SW1ob0ZpbVRvVHVKMkF1dUZxakhJZnQ4VUFRanpRTmpOK0dzUnArUEVqRExQ?=
 =?utf-8?B?MXk1RnBFTytOYzV0ckxZM3loUmZhVXNDSy80cmtjTkNXalhSSGtNTmxEay9a?=
 =?utf-8?B?bkJlS3NtWTFubjVGbWZXSEp5Z0tpQll4dFk3Y2FQUTlzeXRHUUNBVG51MS9R?=
 =?utf-8?B?WWFlZzZVemZHVVRKL0xzYjgzWWpuQS9SejNDODhTRE9EMFhqSTF2N2xvSzlM?=
 =?utf-8?B?dy82YnBlOXhLemlkc2RzYUQ1Y0VlNU5Wa0RlU280SkZXQkdZUnVNZmYvUXU4?=
 =?utf-8?B?Mk9Wc0kvVlMwZjRIM2REaG03ejRkTkNLYWtxNEoxc3R0endjU1U3bXhsZmF4?=
 =?utf-8?B?cnRzZG0zQVYxRzZsa0IybzBEclJqSThxTnNDRWFqNGprRmxrY1BEMzdxVElB?=
 =?utf-8?B?UGpOMmtqMTF4UzVSNm0xekJzcGJ1bllEZzZpUG1UK2k3NXRVZlUrckJtc0lz?=
 =?utf-8?B?OGt5K1FhODVta0RQV1dLUGc1Q0cvUnhHdmJSOFpqQklRWDJrRllmaCs1ZVI3?=
 =?utf-8?B?RzBzbjcxeWV6bmM3MkRqMUFCRVYyMWl6cW1LdnFTak1jRDFkNHBqRWNiQit6?=
 =?utf-8?B?LzFBWSszbll2djg4aXh1ekVFOWZtYmR0ZGZKWlZodlF4US9PY1FMUEJqY2xq?=
 =?utf-8?B?ZzNRMDFCT08zOG9GZWlxdnQxTGNwM0NTZks1STlaYnlucENoYTdId09zZHVw?=
 =?utf-8?B?cGdKUjdFRGsyVEo1ejl0dkh1bFdyL09GWkpnZExGRnBPdGU1OVE0RTZTR21x?=
 =?utf-8?B?WnhOTC9rUGFKRjVxK2l6RmYrd29uanZqNkJFSVdtdlA5UFhoSWRCV0czUkw1?=
 =?utf-8?B?Q2psYnZpUXJrdUhnKy9HSkdCTGhPNG15cllFdnoyTXZSbkVOcnZvQzBSdGVi?=
 =?utf-8?B?WjlwSVUxRFQzSmJsbVBTT0NzRFJsMGVDcjlESE5kdGh4ZFUyMEU4U1RPckYx?=
 =?utf-8?B?Q3dyQUV2eWhjODZycnZBWmdLOEZJU0pTSy9UcUE0ZndUZEZxSTVuK2FsaFFo?=
 =?utf-8?B?V0c4NjdOMEFQSENDVDdTOWRWcDNROUZGY3IzSzE0V3FTL2YrVm9PdlltWGFG?=
 =?utf-8?B?c0pnVlBQTkxUTzhMVitOeEI5V1EvZXRnZjhpRDNEbldVK2VIaElNWFoxbGp5?=
 =?utf-8?B?N1NkdG1lUjQ2Y1hsdnJpenduNHF0R3A5Y29vWE8xTDJPc1VLMXhGbGl1MDZz?=
 =?utf-8?B?V3UwSkE5UEhtbE80UVRVOFgxOElnRSs1Mm5NaUNwd3NNMlhTQk4vblFpWFgy?=
 =?utf-8?B?bHVWSDh2U2Z2UDdxbklkeVRiL3pQeTBOMmhTS3RJaHJ0VTdsME1QZFVLS3RG?=
 =?utf-8?B?ZU5rWE1HbUpmMTVmb0xSUmk0TjZGdVE4SFFkbFJrQ2JKWGtMQXkvR2l3WVFz?=
 =?utf-8?B?MDVxb2lmbk9ON2hBMEZNSlBpNGxMQ0hRWnEvMU1Ibm5xTElSOGZtY0EvVVgw?=
 =?utf-8?B?MnZvRkpxRDN6T0Z5OE0zM0VSUkhoSjlRMTdBbysvczNJK3poUEtUMXA3Qm9U?=
 =?utf-8?B?Nk1NT3BrYllWQUFxUVFjeTMyZzROSS9GSUllanNaNjZiZ3FQdXMyajNUQ2tU?=
 =?utf-8?B?WnJqdW1WbHY4Q0FIMGlsR0VUWk9DYlg3M2lhR2VZWVE5Q0FjZk4wb200TUJx?=
 =?utf-8?B?bS9yc0QzVmE5NHlOdkRyaDV5S1ZBTkRaZVZicGJYNk5ibkJiVVN4WStDMjhX?=
 =?utf-8?B?K3JtZWovbzgxYmYwM3FMTGFieHF5MWxVMStyanhXZ1Iyd1ZLb0VYaTlmOFYw?=
 =?utf-8?B?emdsRUJCdFpCL3FmL0xTdzkybVBBPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3106189-d55d-4daf-29c1-08dc1e8a6271
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 16:18:08.7321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IadLv3EvAyU/dWCd2QqlwYOMb3sziqXFn9wfwQJSaNwwH3pCILO4esd0BKYxuaWbmABwuftcgBAnioBpTcBYbJSVaA3/dk6qtzXLRY/oD7GxxT7HiYyV+azBdBsV/uYl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9550
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

Hi Kever,

On 1/26/24 11:56, Kever Yang wrote:
> Hi Quentin,
> 
> On 2024/1/26 17:32, Quentin Schulz wrote:
>> Hi Kever,
>>
>> On 1/26/24 09:58, Kever Yang wrote:
>>> Hi Quentin,
>>>
>>> On 2024/1/24 19:04, Quentin Schulz wrote:
>>>> Hi Kever,
>>>>
>>>> On 1/24/24 11:35, Kever Yang wrote:
>>>>> Hi Quentin,
>>>>>
>>>>> On 2024/1/23 22:49, Quentin Schulz wrote:
>>>>>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>>>>>
>>>>>> Since commit 9e644284ab81 ("dm: core: Report bootph-pre-ram/sram 
>>>>>> node as
>>>>>> pre-reloc after relocation"), bootph-pre-ram doesn't make U-Boot 
>>>>>> proper
>>>>>> bind the device before relocation.
>>>>>>
>>>>>> While this is usually not much of an issue, it is when there's a 
>>>>>> lookup
>>>>>> for devices by code running before the relocation. Such is the 
>>>>>> case of
>>>>>> env_init() which calls env_driver_lookup() which calls
>>>>>> env_get_location() which is a weak symbol and may call
>>>>>> arch_env_get_location() also a weak symbol. Those are two 
>>>>>> functions that
>>>>>> may traverse UCLASS to find some devices (e.g.
>>>>>> board/theobroma-systems/common/common.c:arch_env_get_location()).
>>>>>
>>>>> This sounds like we need to update arch_env_get_location() instead 
>>>>> of enable mmc driver
>>>>>
>>>>> before relocate, because you we don't really need the mmc driver 
>>>>> works here, there is no
>>>>>
>>>>> access requirement to mmc at this point, right?
>>>>>
>>>>
>>>> All Rockchip SoCs except RK3588(S) and RK356x have it done this way, 
>>>> a little bit of consistency wouldn't hurt :)
>>>
>>> My point is not about you can not enabe the emmc before relocate, 
>>> maybe I'm not clear enough for the reason.
>>>
>>> All the driver bind/probed before the relocation will have to do the 
>>> init sequence again later after relocation.
>>>
>>> The emmc driver cost pretty much time at init, we should avoid to 
>>> duplicate the init process if possible.
>>>
>>> For this patch, you want to make it pre-relocate because you want to 
>>> make sure the emmc is available for ENVL_MMC,
>>>
>>> but there is no read or write requirement to the emmc at this point, 
>>> which means we don't have to init the emmc at this point,
>>>
>>> maybe we can check if the driver is enable if enough.
>>>
>>
>> Now I need to know which SoC we are booting at build time so I can 
>> check which drivers are supposed to be built, check those symbols are 
>> enabled, then traverse the Device Tree with hardcoded DT node to 
>> locations of MMC, SPI flash controllers, check if those are enabled 
>> and finger-cross that those drivers will actually bind/probe properly 
>> later on. That's A LOT of checks to be made.
> 
> This is not what I want to say.
> 
> What I mean is something  like this for arch_env_get_location() is 
> enough, you don't have to bind/probe the emmc for env.
> 
> 1623                 if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC) && 
> IS_ENABLED(CONFIG_MMC))
> 1624                         return ENVL_MMC;
> 

I do need to know if the device we loaded U-Boot proper from is an MMC 
device or a SPI flash, so this is not enough for arch_env_get_location().

I could do it in a hack-ish way though and check if the U-Boot proper 
load medium DT node name starts with /mmc, or /spi and if neither, then 
return NOWHERE, but then we lose the ability of returning NOWHERE if the 
driver wasn't compiled in or the device didn't bind in pre-reloc, we're 
missing some failsafe mechanism I could have with this patch :)

[...]

>>> For the feature record "spl-boot-device" in SPL and read in out in 
>>> U-Boot proper,  and then Swap mmc0 and mmc1 in boot_targets if booted 
>>> from SD-Card.
>>>
>>> It's OK for Theobroma-Systems's board to enable it, but seems not 
>>> also required by other boards.
>>>
>>> Usually we consider the system in two stage: bootloader/BIOS 
>>> stage(including all firmware before kernel) and OS stage(including 
>>> kernel and Linux/Android OS),
>>>
>>> and for those boards(eg. PC like) do have two different storage 
>>> medium, they put bootloader in SPI flash and put OS firmware in other 
>>> storage like emmc/SSD/SDcard.
>>>
>>> In this case the U-Boot boot target does not need to know where it's 
>>> from;
>>>
>>> in another case which supports firmware update from SD card, the 
>>> U-Boot boot target needs to set SDCard as highest priority, also no 
>>> need to know where the U-Boot from.
>>>
>>
>> So... this means we need a different U-Boot if we're booting from SD 
>> card so it can know which boot target to use by default? Or a 
>> different environment for SD card? or requiring the user to stop the 
>> boot process and manually change the priority? Or what are you 
>> suggesting?
> 
> No, we don't need a different U-Boot, we can always set SD card boot 
> first in boot target in all case, if SD card don't have an available 
> firmware it will fall back to use eMMC, this works for the board I have.
> 
> Maybe I didn't understand correctly why you have to do "Swap mmc0 and 
> mmc1 in boot_targets if booted from SD-Card"?
> 

I think I got things mixed up and this was not a necessary discussion. 
But since we're here, I will try to explain what we want to do with the 
whole process on Theobroma's boards.

arch_env_get_location() is the only one impacted by this patch (as far 
as I could tell). setup_boottargets() from 
board/theobroma-systems/common/common.c is a vendor-specific 
implementation I do not see worthy of being merged to a code section 
used by all Rockchip boards, it's basically just a design/policy choice 
we made, but there's nothing interesting to make it the default (though 
it should be generic enough that one could simply call those functions 
from their board file and it should just work (tm)).

So the whole thing is basically about wanting a fallback mechanism.

Boot from TPL+SPL from SD card, if U-Boot proper available on SD card, 
load U-Boot proper from SD card, load environment from SD card (no 
fallback for the environment), **preferably** (if the default 
boot_target in default_environment is not different from the loaded 
environment, i.e. the user has NOT already modified it) load from the SD 
card the Image/dtb/fit and if not possible, then from eMMC, etc....

Boot from TPL+SPL from eMMC, if U-Boot proper available on eMMC, load 
U-Boot proper from eMMC, load environment from eMMC (no fallback for the 
environment), **preferably** (if the default boot_target in 
default_environment is not different from the loaded environment, i.e. 
the user has NOT already modified it) load from the eMMC the 
Image/dtb/fit and if not possible, then from SD card, etc....

Boot from TPL+SPL from SPI flash, if U-Boot proper available on SPI 
flash, load U-Boot proper from SPI flash, load environment from SPI 
flash (no fallback for the environment), use boot_targets from the 
environment (default or saved by user).

Boot from TPL+SPL from SPI flash, if U-Boot proper NOT available on SPI 
flash but eMMC, load U-Boot proper from eMMC, load environment from eMMC 
(no fallback for the environment), **preferably** (if the default 
boot_target in default_environment is not different from the loaded 
environment, i.e. the user has NOT already modified it) load from the 
eMMC the Image/dtb/fit and if not possible, then from SD card, etc....

Boot from TPL+SPL from SPI flash, if U-Boot proper NOT available on SPI 
flash but SD card, load U-Boot proper from SD card, load environment 
from SD card (no fallback for the environment), **preferably** (if the 
default boot_target in default_environment is not different from the 
loaded environment, i.e. the user has NOT already modified it) load from 
the SD card the Image/dtb/fit and if not possible, then from eMMC, etc....

Boot from TPL+SPL from eMMC, if U-Boot proper NOT available on eMMC but 
SPI flash, load U-Boot proper from SPI flash, load environment from SPI 
flash (no fallback for the environment), use boot_targets from the 
environment (default or saved by user).

Boot from TPL+SPL from eMMC, if U-Boot proper NOT available on eMMC but 
SD card, load U-Boot proper from SD card, load environment from SD card 
(no fallback for the environment), **preferably** (if the default 
boot_target in default_environment is not different from the loaded 
environment, i.e. the user has NOT already modified it) load from the SD 
card the Image/dtb/fit and if not possible, then from eMMC, etc....

Boot from TPL+SPL from SD card, if U-Boot proper NOT available on SD 
card but SPI flash, load U-Boot proper from SPI flash, load environment 
from SPI flash (no fallback for the environment), use boot_targets from 
the environment (default or saved by user).

Boot from TPL+SPL from SD card, if U-Boot proper NOT available on SD 
card but eMMC, load U-Boot proper from eMMC, load environment from eMMC 
(no fallback for the environment), **preferably** (if the default 
boot_target in default_environment is not different from the loaded 
environment, i.e. the user has NOT already modified it) load from the 
eMMC the Image/dtb/fit and if not possible, then from SD card, etc...


 > No, we don't need a different U-Boot, we can always set SD card boot
 > first in boot target in all case, if SD card don't have an available
 > firmware it will fall back to use eMMC, this works for the board I have.

If we do this, simply having an SD card with a partition with an 
Image/dtb/fit/extlinux.conf will be taken by default instead of the ones 
on the eMMC, even if we booted from the eMMC. I want to make sure that 
if I'm booting from the eMMC, I'm booting everything from the eMMC and 
not "if you have an SD card, maybe from the SD card". Why am I using 
U-Boot proper storage medium instead of the BootROM's? In case the 
customer didn't design the carrierboard for our System-on-Modules the 
same way we did for our devkit (Haikou) and forgot to add a bypass for 
the eMMC, AND their eMMC has TPL+SPL working but somehow got their 
U-Boot proper corrupted/not found. In which case, we can insert an SD 
card and load U-Boot proper from it for recovery. In which case, I want 
to boot stuff from the SD card and not the eMMC. We could also imagine 
some kind of "built-in" recovery mechanism for some admittedly very 
corner-case scenarios, where we would have an SD card with everything 
needed to reflash the board (e.g. swupdate/rauc/mender) that would only 
work if we cannot boot TPL+SPL from eMMC or U-Boot proper from eMMC.

>>
>> It all boils down to sane defaults. If I understand correctly, you 
>> want people to have systems which can boot really fast by default but 
>> don't mind if people need to tinker to get things working properly. I 
>> would prefer to have most things working by default and let people 
>> tinker to make things faster.
> 
> :(
> 
> Then I would say you didin't understand correctly.
> 
> I agree to let people tinker to make things faster and most things work 
> by default, but don't make too many troubles for tinker if possible.
> 

What is suggested here can be reverted with two lines in the appropriate 
-u-boot.dtsi, I would find this acceptable for tinkerers (but well... 
**I** would not need to do this with the current patch, so maybe I'm 
biased :) ).

>>
>> There are a couple of drivers that are selected when using Rockchip 
>> boards that shouldn't be necessary, e.g. ADC support, SPI flash 
>> controller (to name the few that we have on RK3588 that we don't need 
>> for Jaguar now), there are also DT nodes that are enabled by default 
>> in rk3588(s)-u-boot.dtsi that aren't necessary for my use case, this 
>> also increases the size of the DTB. I don't really get where you want 
>> the line between convenience and speed be right now. It'd be nice to 
>> have some kind of consensus/guideline if you already have one in mind, 
>> at least I'd know where we want to go with this :)
> 
> I never said we can't enable pre-reloc the emmc in rk3588 u-boot dt, 
> that's not the key point.
> 
> You add this patch to make arch_env_get_location() work, I suggest that 
> if we don't really access to emmc,
> 
> then update arch_env_get_location() might be better.
> 

I cannot do what was suggested (see beginning of the mail) sadly.

However, I started to look into having arch_env_get_location() behave 
differently before and after relocation (since it's called multiple 
times). I was able to have some proof-of-concept but I read more about 
env_init() and.... it makes me very anxious to do it this way.

1) I would expect there's some kind of expectations that what 
arch_env_get_location() doesn't change between calls with the same prio, 
which I would be breaking. Even if there's maybe no such expectation, 
this relies too much on the current state of env_init() and later 
updates to that function may break stuff. Not great.

2) I do not understand what this env_init() is supposed to do. It 
iterates over all possible env drivers and call their init callback, 
which sets the gd->env_addr/gd->env_valid global variable structure... 
but if the last env driver sets gd->env_addr to 0xbebe for example and 
the env driver that the first (and ONLY!) env driver that successfully 
can load (env_load()) should be using 0xcafe.... we may have some issue 
there :) Though that point isn't really related to the discussion we 
were having, rather what I found/didn't understand while trying to 
implement your suggestion. I've started to discuss this with Marek Vasut 
on IRC, maybe this will lead somewhere interesting :)

> If it's not able to update arch_env_get_location because it doesn't 
> work, then this patch is able to accept,
> 
> and I would suggest arch_env_get_location() to leave in 
> board/theobroma-systems/common/common.c.
> 

Yes, I agree. I do not think it is a good idea to have 
arch_env_get_location() currently in 
board/theobroma-systems/common/common.c for all Rockchip boards. It's 
just that I need this patch (or a version of it) so that 
arch_env_get_location() in board/theobroma-systems/common/common.c works.

Why I am advocating for having this in rk3588s-u-boot.dtsi is because:
- I think that anything that is done with the environment before 
relocation may need this? So if something calls e.g. env_load before 
relocation, it would need the mmc controllers to be available before 
relocation as well?
- being consistent between all Rockchip SoCs,

Lemme know if you have any question/remark.

Cheers,
Quentin
