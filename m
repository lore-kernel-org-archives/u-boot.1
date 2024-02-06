Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B30F4C48297
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 12:38:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11D0487C77;
	Tue,  6 Feb 2024 13:38:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="M3quEun2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EDDE87C56; Tue,  6 Feb 2024 13:38:07 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0729.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::729])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E38C887C77
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 13:38:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qrdh/hupC/JkTZYChqXbOKG2B/dKKVmRotr0aUckqoeKiHSWgOoV+cRM/Z9qoc71dKzZTa9F/hKVIxaAmA8HRuGz4zob3iZpi9Cc+NOwzY6jLhQx5eEv5x/xq/3nqEB45KyfSNG7hYA8U9ZcFmCDG1+uzEkBdCc8cDSz1jgC+YQrMBfRYxmQuTrXayfQTu0+tmbFbBI0OUKLbuKE36i4rRp32+Vn08g3lLf+4zmlZtNQJmZtpI9bJoK1UjHv3dpqpTYG5d6tHshrrx9i6m5HE5nRiUOhpSLiXzXX8l4jfTEyVjvtLsjL5nrw76qhb/9cr1qBUjm8DHtBoOXyPRJyyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2PHs3wdwgRk1KeHPeSbcYTvld/4AF4xj8Iw+b3Lc+Y=;
 b=IMBsBquKco2VnpscnwKj5EC98/Y5OZK8FrZCzLUDCTPKfQDzU2nm9DvvtsPQ7n0ur7gf85KMfOg2h+QNgCFeHLibHUvcNOqY3EgrsHwV02QimJSU46BKhiDKOGC4ia048GGZekuqfh99/suLYQZGpqqPRAnC4pTtlV8iIhEgIGh3zmZkUiCAmkB5iy+VHRNo60zvnJdYX1v3UVqG9hcQnY3IiR2yueO7Y9lI74OuD+hvGEYwYkzI1ZMhP089VvLzMw+bi3Ecb3X/cc3f8E0BBnU/BuRMuhaKVrXWajpHQIobZ1p1DpDzGxvjLIq1EZ2MxR8jxs0Bz9oi9R77OwQ2ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2PHs3wdwgRk1KeHPeSbcYTvld/4AF4xj8Iw+b3Lc+Y=;
 b=M3quEun2bT1YCps9qKaiaRgLLSVRmw3ZA7zJThrqxO3xM+w4pbq3esJLuTRNGfaN/lFQTbPhjr4cVMg6Pi0szr5IrPR/YApNEm3vdpWQSmwJdydNbwOHNYkQf7GvfJSamfpNhed+nF3UFhaHJfYkWLyotJVENmlzjd793sCjufhDxhBYtKA/O6ncJDBLUfEL2HnucX5eGavlRnfjJ/P1YUUb6VvMy84fHZqNcm+VJBlHxz/BK7xdcu6BYbT5wxzVJ/922WoJxHy5fS20/xqdUyBvKscRtdGRpwKOs7Js9SVWX09UV/+2yOpKDFqSi9GpycBaFefR88nw9vkdEI4Gfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by DBBPR04MB8027.eurprd04.prod.outlook.com (2603:10a6:10:1e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 12:38:01 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%5]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 12:38:01 +0000
Message-ID: <90ff670b-7b77-4d7b-89b4-9a05d68b79bc@theobroma-systems.com>
Date: Tue, 6 Feb 2024 13:37:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/18] rockchip: pine64: rockpro64: migrate to
 rockchip_early_misc_init_r
Content-Language: en-US
To: Dragan Simic <dsimic@manjaro.org>
Cc: Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <foss+uboot@0leil.net>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
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
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin
 <agust@denx.de>, heiko@sntech.de, u-boot@lists.denx.de
References: <20240123-jaguar-v1-0-1eec1c34953c@theobroma-systems.com>
 <20240123-jaguar-v1-8-1eec1c34953c@theobroma-systems.com>
 <0d74e5e5482cd32d7cad714e731d4fb8@manjaro.org>
 <be58f85e-5564-4b10-aa24-cb4d794cc09b@kwiboo.se>
 <30c40f7596affef5899099ce68eb96c1@manjaro.org>
 <a6a4a7c3060542f030c9fed2f253400e@manjaro.org>
 <baa5cbee-dceb-4398-9b16-2c69473611d5@kwiboo.se>
 <d031fbe4cca9d1c43a6a6dd9c0ae56eb@manjaro.org>
 <22c1f0e5-58d5-46c5-865e-0e1be7f84c55@theobroma-systems.com>
 <2871f780d35019772d1a3ffa0abd16e7@manjaro.org>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <2871f780d35019772d1a3ffa0abd16e7@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR04CA0049.eurprd04.prod.outlook.com
 (2603:10a6:802:2::20) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|DBBPR04MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: 709600e6-8a4c-401c-a22f-08dc2710750b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7vNAM2+2PAT1cqWVYw0r26MbP5Rjl1ajhq35EbuS2uQlNMGmwwqS34pguYScGpfzp82VnudH5lAOCKfhZwe9Lz3jypFC05kwKyOxvbgJUHM+P/v9n/T1b1/PspcGoSZmOpKXFIs3uCYvbp6kQrPvUjRlKLOJ48wfsenl5kQye1FbBTcnTcWZUtDXV/bcxG1900E8dP0rNwEwVJdq2wZjfJYejw0m/dAcn2Rq49Rk+azE5sRS6JjQl/TbH2ps2STW+yJ5KRqZq0TmJvST7mywlh6mH/FZjLmlVvPP8h9VBTTeP8AwgXEs6ZEjyL6pjxU40fhaR25pIQHmGIOMlZsNakEWOtyd15bott5wrYvXU530byTtDdtt6qqg/A1SaofI5kA0/jBsnQnyVTyWSHMzgQZh8VBT8DyKNLJGsFLSPmoWoiElexWIPhx4HnOQT2vGLIPQqUHzF96pyuCDniG8392gSUdI2SvNMXLdSkMtAmY6AIRPrSysvcPY0CCLBepL35Q2yA+2HmD42C4R/uusb9Jj2rR2TUpWlYTAkIpd4td5rlJQm+24GMKKs5heN1iydQwHCCWkR/o/3qBAeE7g98ScTtdNed4sMmtrCQ88VSgu5QTATe8QQ/idkuou1XuYRUxmsi6dsUnX4Yc757yBNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39850400004)(376002)(366004)(136003)(346002)(230922051799003)(230273577357003)(186009)(1800799012)(64100799003)(451199024)(31686004)(2906002)(38100700002)(83380400001)(41300700001)(316002)(26005)(66556008)(6916009)(54906003)(66476007)(66946007)(31696002)(7416002)(86362001)(4326008)(8676002)(8936002)(44832011)(53546011)(2616005)(6506007)(5660300002)(45080400002)(6512007)(6486002)(36756003)(966005)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1NMQ21qZms3ZG9GUFQrNGVKbHRCODNiekJxL2p1RlFUaWcrMU1hbWlLcmlk?=
 =?utf-8?B?OExwZ1orMWZnWEFKdVZYR3ZPNyt0SiswTlRnbGY5azNIUFlLTUI2cGlzNEM3?=
 =?utf-8?B?emNuV2xtcXQrK2lYK1F1OW81d2VzdHNsS0JpdzZRNld2SzczNUx6Y1VGOHR3?=
 =?utf-8?B?Zm85dURiaGRMLytlWHprd3BzQUMwbzZKSnFiM1ZFVUJQbE5nbFlQNHg1QTc4?=
 =?utf-8?B?bVJLTlF0bXdnNTRTbVphYTJQWjZ2YmdnOUJEaFZickZSTlo2VmtZS0RLMWd6?=
 =?utf-8?B?Qjcyai8zVFFoeGlWK3czSmM0Ujl1WWRQcHJEWW1YMTZTQXlISFB1NXVoZU9z?=
 =?utf-8?B?TkdMSG9UcWxWWFQwTklQWk5JdzRiV2hHYUFjNVhOMEcycWFyVXl1elNDUkk3?=
 =?utf-8?B?Q3ZaQzEwZ3V4bGlnUk50S0N0MVJiQ2lzMDNab0dINVRVSmhWRE01WWJtOXFo?=
 =?utf-8?B?R1NtQUNjWDQ5Q09YRFVxRFF3OWdTQVdYN3d4Uk9VNUZuYmpMcUZuTzByRk0w?=
 =?utf-8?B?dnhNVlM0S1p4bTRvMGJKSDU3TkFiNnE1L2g4bm1ROGRzTjVmcjhOUVVoWmVa?=
 =?utf-8?B?YTJSSnNyS1VVdkM1bWsxS1dHSHlEWCs1MUphV0Z0M002bXA4QkZjZDkyOU5H?=
 =?utf-8?B?bUkvaDBQV2ZtTlRsdTBUdFlId2pKZlpFVUdVeC9yVlR1OGNsWjJURm15amlD?=
 =?utf-8?B?SzFpM1U1TDFCaWRWRm1YVEcxbjBjQ0FRbWNJalJhenpEUFhGSTZwV0dSQ1pQ?=
 =?utf-8?B?R3RtTGphYzl4d0hRN1ZoWWFiMjVXYVFNQUVCYVdIajNVaXNYRkY1Mkc1MnpR?=
 =?utf-8?B?RDYzUGJJNXVhdnQwNTNrekFScG1WajZTQjVzSXl4SU56MFZLcG9nU3VYV293?=
 =?utf-8?B?Y0djS0tMdXhQRisrQ3o1M0JLWmZpcHE4eWVSd1hUTjAycnNHWURFRVp0M2E0?=
 =?utf-8?B?WXFoNmFUaHRmY0Q5NTJ1SHQ0OVB3aFdscFZ5TjJraUNjQ2pUeHlVY1BkS0xr?=
 =?utf-8?B?bzlsM3IrcnN3RU9CemdGMTNqZzN0a3lEeFBPYVhxL2EyM1VWbnhCS0Z2VG93?=
 =?utf-8?B?ZXhjZTJVUzViMUYxamUyV1puRDVHcXhuc3ZNNDB5Vm8zN1lOLzY1b0hQc3VJ?=
 =?utf-8?B?NkFUQUR3Z0t4NFB3QjJUT0EwcTAzMTJZWEt6WjdaVjZ2L1dLMStHNGVCSW1y?=
 =?utf-8?B?YlM3MHdpUE1WTVU4ajNxMHAvYzV1aDBuQ1FLUndEQW11SmlkaVYwcThvRFhK?=
 =?utf-8?B?ZVMwYW16dVRBTHJId3ZiR3VyY0ZUMlczQ0JEcytTUnVMUTFPSEplejZRVEo3?=
 =?utf-8?B?WFFHMDNBckJHK1Z0VGg2enJXR09rM3pYdFREb0VHOHl2ZTZnN3ptR3RQMTI3?=
 =?utf-8?B?b01RdS9uaDVpT0RxRzV3MWpaWThha3BCZWRVREpKRjRWaWwxUGM4VkpJeUla?=
 =?utf-8?B?RE9aQWF1aEMvd21aVW1ibkpLUVFwRUhTOUNhUTdSbHBWNjRxcG1nMkR3T0sy?=
 =?utf-8?B?cGdpYnFrMlZCRmNyZmZoMGd1RitPcGtpKzBVUi9GdXRBTU1VeWxSRlk2Uzdq?=
 =?utf-8?B?aWE1SFQ5a3p1YjAzYm5HTy9PM0kzbFU1SlVwWm11S29aMERtS0U4aUxvME5G?=
 =?utf-8?B?WmFscXBtOEt0R05lU1ByYytJbFd2c2xzNlBGNmNVbzFjQ3Izb21iYVArcjl6?=
 =?utf-8?B?bHQ3eTJLWGlzeTZqbW56VU9XQkNLZmd6bm9sc0NMbkEzNmhuSGxrcTYvVHhy?=
 =?utf-8?B?VHFYTnp1dGptaXFLTlM0TkNWcjg3TmhPVFZqUW5nWk1DOXpQc0Q4em4rMHBS?=
 =?utf-8?B?TmJtNWhnWFNMQ1ByTEd4bFVSK0Fqb2ZkTXd4aUNxZ1I2N0pJVUpZb2h1TjFK?=
 =?utf-8?B?cWNCRVp3Z2N1eW1CZXBTTHg1dkQvbUlaNVBtRHB6Qmpub3ZWYWJpa1VObjBI?=
 =?utf-8?B?THhpZnFPYVFvblVzRmpXNUp0bmVRK2V4MlBtbHoxdTlYTm9tN0UvRFFsd0h0?=
 =?utf-8?B?OGx2VVNIdTNVVFkwMDl6RTYzazNwaFVyLythSlRtTnhuNmZ6N3lKKzN6YnI4?=
 =?utf-8?B?WlY3SE0yOVVYdUhoK2h3a0t2V0NSTktXWGU3cGdtdndYUzZCWmtSdzM2QkJM?=
 =?utf-8?B?OVI0L3g2SzNOZjlZRDE1VHFaU25nV0haVXd2b1k5a1RDWmtMT0hnQlhERTV1?=
 =?utf-8?Q?Db5O9hU3KEcGTKS46o26DZ8=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 709600e6-8a4c-401c-a22f-08dc2710750b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 12:38:01.8021 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HWVw4+ot4jq9cOGJDdkh62O/uOy1ccC+qZJmDg/4pkdzPLsCu8ZyA1fPt3BFlGenTy5FKt63YTBVoTYOihpIikInctbZWrsOvO2rhy5eGpB3VaagWTYPer+UKa983kai
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8027
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

Hi Dragan,

On 2/6/24 13:33, Dragan Simic wrote:
> [Some people who received this message don't often get email from 
> dsimic@manjaro.org. Learn why this is important at 
> https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hello Quentin,
> 
> On 2024-02-06 13:26, Quentin Schulz wrote:
>> On 2/4/24 11:39, Dragan Simic wrote:
>>> On 2024-02-04 10:46, Jonas Karlman wrote:
>>>> On 2024-02-04 05:21, Dragan Simic wrote:
>>>>> On 2024-02-03 16:18, Dragan Simic wrote:
>>>>>> On 2024-02-03 15:18, Jonas Karlman wrote:
>>>>>>> On 2024-02-03 14:19, Dragan Simic wrote:
>>>>>>>> We should add more ifdef guards to rockchip_setup_macaddr(),
>>>>>>>> to prevent the execution of its body for devices such as the
>>>>>>>> ones listed above, which eliminates the unneeded code from the
>>>>>>>> resulting U-Boot images, making them a bit smaller, and saves
>>>>>>>> some CPU cycles and a bit of time on boot.  It also prevents
>>>>>>>> the unneeded "ethaddr" and "eth1addr" variables from being
>>>>>>>> added to the environment.
>>>>>>>
>>>>>>> Adding the ethernet addresses only adds a few ms to boot, if you
>>>>>>> care
>>>>>>> about boot speed, please look into if we can disable
>>>>>>> CONFIG_USE_PREBOOT
>>>>>>> for these boards, running "usb start" as preboot adds several
>>>>>>> seconds
>>>>>>> to the boot.
>>>>>>
>>>>>> I see, but I personally don't care that much about how long the
>>>>>> U-Boot takes to execute;  a couple of seconds more don't bother me
>>>>>> much.  I care more about excluding the unneded code.
>>>>>>
>>>>>>>> The patch below should do the trick, which also performs a few
>>>>>>>> small code cleanups for additional file-level consistency:
>>>>>>>>
>>>>>>>> diff --git a/arch/arm/mach-rockchip/misc.c
>>>>>>>> b/arch/arm/mach-rockchip/misc.c
>>>>>>>> index 7d03f0c2b679..ed5bdab5a648 100644
>>>>>>>> --- a/arch/arm/mach-rockchip/misc.c
>>>>>>>> +++ b/arch/arm/mach-rockchip/misc.c
>>>>>>>> @@ -23,7 +23,8 @@
>>>>>>>>
>>>>>>>>   int rockchip_setup_macaddr(void)
>>>>>>>>   {
>>>>>>>> -#if CONFIG_IS_ENABLED(HASH) && CONFIG_IS_ENABLED(SHA256)
>>>>>>>> +#if CONFIG_IS_ENABLED(HASH) && CONFIG_IS_ENABLED(SHA256) && \
>>>>>>>> +    CONFIG_IS_ENABLED(GMAC_ROCKCHIP)
>>>>>>>
>>>>>>> This would exclude any board not enabling GMAC_ROCKCHIP in U-Boot
>>>>>>> but
>>>>>>> want a mac-address being set in DT fixup. And for newer RK35xx
>>>>>>> SoCs
>>>>>>> the
>>>>>>> GMAC_ROCKCHIP driver is not used.
>>>>>>
>>>>>> Thanks for pointing that out.  Not good.
>>>>>>
>>>>>>> A new Kconfig option should be introduced if there is a need for
>>>>>>> some
>>>>>>> boards to disable this.
>>>>>>
>>>>>> Is there any simpler way to achieve that?  If there isn't, perhaps
>>>>>> we could leave rockchip_setup_macaddr() generate the MAC address
>>>>>> and rely on fdt_fixup_ethernet() ending up doing nothing when no
>>>>>> ethernetX aliases exist.
>>>>
>>>> As Chen-Yu Tsai pointed out in one of my prior patches [2]:
>>>>
>>>>  The user might be loading a custom FDT for the kernel, or have DT
>>>>  overlays stacked on, either could have the "ethernet1" alias while
>>>>  the U-boot DT doesn't.
>>>>
>>>> So the common rockchip_setup_macaddr() cannot rely on checking for
>>>> ethernetX alias, because the fixup may not run against the bundled
>>>> DT.
>>>>
>>>> [2]
>>>> https://lore.kernel.org/u-boot/CAGb2v66hR5e3nBPZ0C3=h29fS4Um7whfBu7XTAi1sRbzXRAPxg@mail.gmail.com/
>>>
>>> I see, we unfortunately cannot know the final outcome in advance, to
>>> be able to avoid polluting the environment by adding the "eth1addr"
>>> variable if it actually isn't needed, for example.
>>>
>>> Though, why can't the user supply an FDT that contains ethernetX
>>> aliases 0 through 2, for example, in which case we wouldn't provide
>>> a stable MAC address for ethernet2?  Am I missing something, i.e. is
>>> there something preventing an ethernet2 alias from being present?
>>>
>>>>> After going through the source code once again, I think that adding
>>>>> new configuration option would be warranted, because it would
>>>>> exclude
>>>>> two sizable chunks of code from the resulting U-Boot images, and
>>>>> because it would avoid polluting the environment with a couple of
>>>>> unneeded variables.
>>>>
>>>> Yes a new Kconfig option would be preferred.
>>>>
>>>>> I'll go ahead and implement this, and I hope that the patch will be
>>>>> received well.
>>>>
>>>> Great :-)
>>>
>>> Thanks. :)  Got it implemented already and tested a bit.  I need to
>>> write the patch and series summaries, and I'll send them over.
>>>
>>> Regarding the above-described uncertainty about what ethernetX aliases
>>> the final FDT containts, I'd say that ignoring the ethernetX aliases
>>> completely for the Pinebook Pro and the Pinephone Pro is safe and
>>> valid,
>>> because those are actual devices, instead of being development boards
>>> for which the final hardware configuration is determined by the user.
>>> I can hardly see anyone adding an Ethernet interface to them, except
>>> by plugging in a USB Ethernet dongle.
>>>
>>> I hope you agree.
>>
>> What should be done with the patches for Pinephone/Pinebook Pro then?
>> Since I was asked to wait on your answer/patches before respinning the
>> patch series, I would like to know what to do with them :) Drop the
>> patches for now or keep them as is?
> 
> Your patches are fine, just please update their subjects as I already
> suggested.  The patches I'll send a bit later will resolve the issues
> I raised previously for your patches, together with doing a bit more,
> so there's no need to change your patches further.

I would rather not break devices if I have a choice. Is merging those 
patches without yours going to break those devices?

Cheers,
Quentin
