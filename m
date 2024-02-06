Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D02CC4828D
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 12:26:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E98B687C9E;
	Tue,  6 Feb 2024 13:26:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="KueH12jA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73D9487C56; Tue,  6 Feb 2024 13:26:13 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20722.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::722])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1544A87C9E
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 13:26:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZjRMuVB3zt91xVOlUjOImBQcHWR2C2fwtIXfWV6z1teZcZBylLQtF8WpSY4xooSR7YG8Nd8DQWPHs9PJT71Xa7PH9ADfn1RYbrc+qFBvA4wmgM+mnlUosAQCxqd8YgZYJaxTymyZJJND1jIE5q7S2FHG9Yr5lTGcEu247y1Z+3rrlPNqs9xqfW3qHQL+5U+t3W6C1gjKna47KysdB6Yx0tNYLeGFSemxL68XDFur4DAm02OTI+w1XBNiqoxPQXMlulkbwBQhm5Ag1Gn5xc/Jj+lqK+OKOmq6RWMV3upjT2X04NSjUTIG4yrOSI5tu92FGvQ5ypPCdZzlzaWgtLM2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7Z5cAB3EuaKLjiE5j9t6SEKvnXJ9yEe+TfXqhQqmG0=;
 b=bJJDFsLxADA90OqxQv3GstGz9IgHsr7Fh3QmveZHNJf0qw4DikR8U9iRsXO2JPEXiGMsfO2xHjYVIC9vFIZam+FboFzOpcMHkXi8V+qNQ5BMK0WUglGukcQLfDJl71iLZotGOuI1oPqsp7c6j0gPThe8RPLYDRvDW7JWISRKkj0SQSmIS/JxW3OxS+fgxiOUJiWYcenTgojqu3F6VNKkmEmdLQ61vaBOwTe/5vdzPIuFDCSFvgtHVy83/G8k6LkzXKBfyvuPSYX1HWwPWSXSpm18ZNRCMNE0b2lBoe8kc+TL5dc17viAIbs9nNp3HeolhvPM8Z4iHESrqWmTp1GfFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7Z5cAB3EuaKLjiE5j9t6SEKvnXJ9yEe+TfXqhQqmG0=;
 b=KueH12jAl4m4zseuO5CQYPOZCmZGlhTCt0+VPJ2hqGsl8nbvSwmc4y2bOwF4lXBDgyBmTEbg+bAYFqqYLFDcnWxl12SksTjn8BOP9h9i3lnfX6A3HZGtrpNIL88M7RIqTbfoMEyfLD4fPrNdtXcscRugkwyw0djY4E3OWNpZCzeVryOq9ykJ02hhrU424yV8FceJa6LQU+teCufIO6UdyCpdEvv9E2VmrxnyKBO9blOYcRMqNzAQcpZ9Dk4cUzh1ayuF2Gy417Akk9E4/GOY3rYx24Bjb796YIVumhUpvHiPjfu4SfgSXZRSpnSmr6mdWoRoC2vaI61yOPkyPaVgsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by PAXPR04MB8460.eurprd04.prod.outlook.com (2603:10a6:102:1db::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 12:26:07 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%5]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 12:26:06 +0000
Message-ID: <22c1f0e5-58d5-46c5-865e-0e1be7f84c55@theobroma-systems.com>
Date: Tue, 6 Feb 2024 13:26:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/18] rockchip: pine64: rockpro64: migrate to
 rockchip_early_misc_init_r
Content-Language: en-US
To: Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
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
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <d031fbe4cca9d1c43a6a6dd9c0ae56eb@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0134.eurprd07.prod.outlook.com
 (2603:10a6:802:16::21) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|PAXPR04MB8460:EE_
X-MS-Office365-Filtering-Correlation-Id: fc5b09a7-b1ed-4561-9df0-08dc270eca6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HCiHIbTkIb1qoK7LAYMRZbBHKM1ZHlswgEG4XxahV7m/fQIvZeYDB1M9pfNL8HyVd8/P8IPkzew+UvsHKWMVKo3eK1GK1jjIutJETc6XLQdCU/D+TWZBaqsbRRAJv9nowvWkbkaafCRIsMtdc7ladXQtpYMEMWuAyNUl2IgomsXA7Id2bZNC8JydPU63Pstth0yjMc2le05waG64o44YITahIShzznSNfQWBI8d0knFMtQFOipNymCDjTVtdKh9ziCXjCWPiniPYeX7eXUhFg8yPubMrnwW6XSd+N/2dQPgsdrtpYA3p6HI0ud2aB2FAXMWi4n9ywHsdlZxIy9ApUXHKEj9DPPI04kC++DX1T0kGYbRNP6TJTtWk/TF0U/CB64Db/gaqKqs6f2g3ViTVudgZl62LT4X1lEpMjSfTPS5Jbln4o5GTFS1x2Dzs82cD6ASMFCTiesEEZTKiHHd1fMfdrEC2ngEMFazmNFe20iB7FYOCGVW7dfzs8K+v38adFk24Tqwlub3VECs04+3X7JOoiC+Ihn8pVdbPLZYgK2SYZloXiD/gvRqIw+QhC6lI7L6GF6tqIXnTySrFHRmZGXN05Q4FCBMbmxGKhHI6xN5oxATVZ6oQqEUlrCN5eaQ8soBi/hBPOItcdTy+eYfHAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(396003)(39850400004)(366004)(376002)(230273577357003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(6506007)(53546011)(6666004)(38100700002)(83380400001)(31696002)(31686004)(26005)(86362001)(36756003)(41300700001)(2616005)(4326008)(8676002)(8936002)(6512007)(45080400002)(2906002)(478600001)(966005)(6486002)(7416002)(5660300002)(316002)(66556008)(66946007)(66476007)(54906003)(44832011)(110136005)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmFxOGE1T2txNG9EVFdWa2tOMmZZSktXOU44WGdFcm42Q052SWhncmsxNjhO?=
 =?utf-8?B?Y0NNcXdTV0VFTjFQa2gySXpMVklFZUx2K2FXUjdyc0U2UEEySndRYWRIYVdL?=
 =?utf-8?B?VFhWNjBCNmQ3Y0VvUFY0ck4rZFU3U3ZOYzQ1MEViMnoySkhWbmpZR0JiUVhw?=
 =?utf-8?B?WHRNWHUyUnlES3MxWC93ZlAwTjY0UVpCZjFweWNaQXFjQXpNRFRGaXZNMzJx?=
 =?utf-8?B?U1NQS0FON09pdnFpZU42TGYwbFVmeGxXd0RxK2pNTklacWxkRUdLVFJJanVC?=
 =?utf-8?B?YWJzcisvcHJtdHlaQUthUnNFL2p4VThQOGNrbEVPMmQ4cDJwYXVLc1BzMi8y?=
 =?utf-8?B?L3VubEE0Z2FJNW9mZ3dHUkphMEY1bUVXUFRvUXR2WTh6dG4zdDVLaHlkS3JY?=
 =?utf-8?B?bVNPVmFMcjJoTmFHWnpyNEFXUzBGMUVoQjhpajVxTE1OenBaTStTWDd1MWw2?=
 =?utf-8?B?Z2hmNDhoTTV3TUhOYTlTdHA2K1JFSklncWs5dXRTYllRMlRDTjZ5TEtnUlhi?=
 =?utf-8?B?TWhCNDNJQVlZazVEWEpIVGJaWUJsVUxmTXRWaS9jcDFwclIwbTdYVzVoZXdp?=
 =?utf-8?B?MnVqS0JhOGQxVGROUFB5RFFQMnZEQjNBVS9XTDVZTVZzY3pnaENKejhHS1ZI?=
 =?utf-8?B?WVYrcE5WMTZ6QThwdFpqeGVHRFBjb2dldis5c2x3YStjL0oxaVVZOGJMei9E?=
 =?utf-8?B?ZjNtN05wMjlYSit2Znp3Y3dYR2pNa1BrRUVIL3lla1ErMktqYzZNL241VkJZ?=
 =?utf-8?B?Rm9HNWw2NGJubGNmT0hTZ0tYL0lPRWM2UEFsQitUQ1hhVkZ6R1p0UjQ0RXZM?=
 =?utf-8?B?VE9NZjBDN3JXMENDV2ttN0V5R3JxZVkwMkdnaW5GSlhqUzRMMTcvekpHV2E0?=
 =?utf-8?B?WGRrRXEyeWVhYjNSaDdZUTBYbW5MOUlVbzcwMTVmN2g2L0I2RE1LSXM5RU5a?=
 =?utf-8?B?S05JeXM1Uk4xR1JZL3lQMU9udXJxSDF5VjRoZG8vY0xLZEVwbVEvb2hDK1lH?=
 =?utf-8?B?V2Y0SEZMaWJrMU0ra0wwZVZoSkZNT2NpOFhlMzZlbEI2emdYdkJwYlM5TGpi?=
 =?utf-8?B?WFFFWEdqZThJSDZ4TXRZWVhvdyswaXZFU0N2YllhUTQyRkNGeklRYzdQTkc4?=
 =?utf-8?B?SzJGamRpMi96MEJJVFVPOFlWcmN3cWl4VS9GMWQxWWEyb0gwQWxkd0xxcmZv?=
 =?utf-8?B?SnhqT01OaUZhR0xQYklxNS9LcmNHK3ZtVUZjQUJaZ2JIejRwWS83WW5GZVg2?=
 =?utf-8?B?Zm5qVEpxWWJmSVk5U2FOMWJ0dXQ1T2JwWENIWGxCMHF4TjNZQk0zOXNiK1F0?=
 =?utf-8?B?Y0NnYVl3Nm9aZXRhM2Fjcnhzbmc4MTQ4YWlORkd0UTJwVlB3NUhXYmlZUll5?=
 =?utf-8?B?bktHbU5Ec0VtMkF4K05TTnYrR3ZlY3NRVDMwbXhGZ3FQbUp5am82ZzM2QlZS?=
 =?utf-8?B?Q3RFZFpjV3gxY1lVRCsvd3ZCaktGYnFCaHVUSU1CK24vVFpDSE1nSVRKU05T?=
 =?utf-8?B?R0x6RkpNMTNWR2Z6S09uWXBOMk90dDExb3hFTlkrR2w5Y1pNOTlTY2g2SldM?=
 =?utf-8?B?K3JnVjdpVTB0bk5PNDNjeFVsRTVnZjc0a2hBazExQUwwZEV6MFJjTTNqdHRz?=
 =?utf-8?B?NEhrRFlyRHFVK3BBZldZallNUTJNdkp3K3VXaGZ0VDQ4NDhlYVV0Vmt2OEhs?=
 =?utf-8?B?RXd0K25QcC9xNmgvUEEyTGdEbmpTWE45WnovL1VCVnhMenFSTTJTTzdzTGZ0?=
 =?utf-8?B?VFN6c1VLVDg2QlRCaW1XQUJNbG1RVGd0aXFuWWdERjU3V0VFbnVydkE1R3Iw?=
 =?utf-8?B?NXdLSlZXUmlxNmF6TUJnYXlyWmJmY01rRmtCR3pFTzMwQWFnL2ExdUE2SGNX?=
 =?utf-8?B?Rm03a3lVTk5pbmVISFV0SCsrSk9BU3oybFdjTHZuSFp6WU42YnNpUmZYMFhj?=
 =?utf-8?B?T3JKTlI0TmR0bTVrWjdLNkEwUEZBa3FhUUJ3RWhyQmZlRkZBVm1WNktPKzlr?=
 =?utf-8?B?d3hOZG4zR05QWWdtajhEYUF0REg4OGMxRk4wSUhSREJIMlNqK2hWLzdQWEw4?=
 =?utf-8?B?UXdsOUJFOGgyUms3TWVzNXZmOUZLK0h1NnZQWDdHVFVUbHUwaHlkMmJRR3FX?=
 =?utf-8?B?eHVvc25zeHltc0t5ejlZK2l2YmN3UGJ5SXFuQlRNeURhbDg5SVlHY2RGYzRk?=
 =?utf-8?Q?Jc1/zNUoRYk734QEGXLWt8g=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc5b09a7-b1ed-4561-9df0-08dc270eca6a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 12:26:06.0479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /pJZKCqXOByBsTCdMRN4kqn69StsQ1SpqQLGbntiqyz61qh0d3T/1nfskwEuglpO6EyufY2yfy0RaVNZ1puFYaTG2s24MWmJcGxJfWUzuqsNnfOCnpN0gBEC9tYsDhWd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8460
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

Hi Dragan, Jonas,

On 2/4/24 11:39, Dragan Simic wrote:
> [Some people who received this message don't often get email from 
> dsimic@manjaro.org. Learn why this is important at 
> https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hello Jonas,
> 
> On 2024-02-04 10:46, Jonas Karlman wrote:
>> On 2024-02-04 05:21, Dragan Simic wrote:
>>> On 2024-02-03 16:18, Dragan Simic wrote:
>>>> On 2024-02-03 15:18, Jonas Karlman wrote:
>>>>> On 2024-02-03 14:19, Dragan Simic wrote:
>>>>>> We should add more ifdef guards to rockchip_setup_macaddr(),
>>>>>> to prevent the execution of its body for devices such as the
>>>>>> ones listed above, which eliminates the unneeded code from the
>>>>>> resulting U-Boot images, making them a bit smaller, and saves
>>>>>> some CPU cycles and a bit of time on boot.  It also prevents
>>>>>> the unneeded "ethaddr" and "eth1addr" variables from being
>>>>>> added to the environment.
>>>>>
>>>>> Adding the ethernet addresses only adds a few ms to boot, if you
>>>>> care
>>>>> about boot speed, please look into if we can disable
>>>>> CONFIG_USE_PREBOOT
>>>>> for these boards, running "usb start" as preboot adds several
>>>>> seconds
>>>>> to the boot.
>>>>
>>>> I see, but I personally don't care that much about how long the
>>>> U-Boot takes to execute;  a couple of seconds more don't bother me
>>>> much.  I care more about excluding the unneded code.
>>>>
>>>>>> The patch below should do the trick, which also performs a few
>>>>>> small code cleanups for additional file-level consistency:
>>>>>>
>>>>>> diff --git a/arch/arm/mach-rockchip/misc.c
>>>>>> b/arch/arm/mach-rockchip/misc.c
>>>>>> index 7d03f0c2b679..ed5bdab5a648 100644
>>>>>> --- a/arch/arm/mach-rockchip/misc.c
>>>>>> +++ b/arch/arm/mach-rockchip/misc.c
>>>>>> @@ -23,7 +23,8 @@
>>>>>>
>>>>>>   int rockchip_setup_macaddr(void)
>>>>>>   {
>>>>>> -#if CONFIG_IS_ENABLED(HASH) && CONFIG_IS_ENABLED(SHA256)
>>>>>> +#if CONFIG_IS_ENABLED(HASH) && CONFIG_IS_ENABLED(SHA256) && \
>>>>>> +    CONFIG_IS_ENABLED(GMAC_ROCKCHIP)
>>>>>
>>>>> This would exclude any board not enabling GMAC_ROCKCHIP in U-Boot
>>>>> but
>>>>> want a mac-address being set in DT fixup. And for newer RK35xx SoCs
>>>>> the
>>>>> GMAC_ROCKCHIP driver is not used.
>>>>
>>>> Thanks for pointing that out.  Not good.
>>>>
>>>>> A new Kconfig option should be introduced if there is a need for
>>>>> some
>>>>> boards to disable this.
>>>>
>>>> Is there any simpler way to achieve that?  If there isn't, perhaps
>>>> we could leave rockchip_setup_macaddr() generate the MAC address
>>>> and rely on fdt_fixup_ethernet() ending up doing nothing when no
>>>> ethernetX aliases exist.
>>
>> As Chen-Yu Tsai pointed out in one of my prior patches [2]:
>>
>>  The user might be loading a custom FDT for the kernel, or have DT
>>  overlays stacked on, either could have the "ethernet1" alias while
>>  the U-boot DT doesn't.
>>
>> So the common rockchip_setup_macaddr() cannot rely on checking for
>> ethernetX alias, because the fixup may not run against the bundled DT.
>>
>> [2]
>> https://lore.kernel.org/u-boot/CAGb2v66hR5e3nBPZ0C3=h29fS4Um7whfBu7XTAi1sRbzXRAPxg@mail.gmail.com/
> 
> I see, we unfortunately cannot know the final outcome in advance, to
> be able to avoid polluting the environment by adding the "eth1addr"
> variable if it actually isn't needed, for example.
> 
> Though, why can't the user supply an FDT that contains ethernetX
> aliases 0 through 2, for example, in which case we wouldn't provide
> a stable MAC address for ethernet2?  Am I missing something, i.e. is
> there something preventing an ethernet2 alias from being present?
> 
>>> After going through the source code once again, I think that adding
>>> new configuration option would be warranted, because it would exclude
>>> two sizable chunks of code from the resulting U-Boot images, and
>>> because it would avoid polluting the environment with a couple of
>>> unneeded variables.
>>
>> Yes a new Kconfig option would be preferred.
>>
>>> I'll go ahead and implement this, and I hope that the patch will be
>>> received well.
>>
>> Great :-)
> 
> Thanks. :)  Got it implemented already and tested a bit.  I need to
> write the patch and series summaries, and I'll send them over.
> 
> Regarding the above-described uncertainty about what ethernetX aliases
> the final FDT containts, I'd say that ignoring the ethernetX aliases
> completely for the Pinebook Pro and the Pinephone Pro is safe and valid,
> because those are actual devices, instead of being development boards
> for which the final hardware configuration is determined by the user.
> I can hardly see anyone adding an Ethernet interface to them, except
> by plugging in a USB Ethernet dongle.
> 
> I hope you agree.
> 

What should be done with the patches for Pinephone/Pinebook Pro then? 
Since I was asked to wait on your answer/patches before respinning the 
patch series, I would like to know what to do with them :) Drop the 
patches for now or keep them as is?

Cheers,
Quentin
