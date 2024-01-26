Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E440C47DDF
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 11:09:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C462A87B8C;
	Fri, 26 Jan 2024 12:09:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="VSCmfG/L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A42D987BD1; Fri, 26 Jan 2024 12:09:20 +0100 (CET)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2611::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34F778784D
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 12:09:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LScm/K7x9YwWB3PNsLDEbI6pMcRm5X0NzIVMziFo8noj3QDvVoBCTx13reWHTiCXU9SQL6233A+0ElZFDJn7/IPnAmf2lMRFkjYNCPHkSvudRxjM/akdLYtO9XvghVbGdm5bUF4iVYTWl7Kxspod44r1MAMtKeegm3oAuJDdtLaX8wv2GVnCTN2DYzjX4XrI6eEzfhTR445V/pgEvw3QQ5CipddIVjZDWZE4ggJ4G8XQns9tLZkGU3VprStpoaN71CJ7RKbql7QsaoW2nTmLHqd4yUS+HgdAfQ4539tv24vHLW5bUIWeslehtiVSAhxvSZKmJcncQvSJ0gsLZ4Rkbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Gaa/BkX2yqAHNKy16hlF5GpREPWSRO3MuQWrd1Wkaw=;
 b=TOIWckZqH95OE2MbvFCoAdHhusjJBNnP8bsAgbOGonv6yksNXd7tTchKzb6dqyS/VlSYT+L3Ts3iGMFxasl8dKvTVhlOj3cBeKkcoeqKfwKlYQu9DDcNt9CXrSQ7Jhef9+3rVS9VIRC08ERwADmQfnvGkcAoIASea5IHwcjtTZMQw4ev8UTDDDFy/Sq4B1gGgk2N+5tB3d4f+LQTaaEsv/ZbtSXJu9CaKCDdvOdR32AiMJCIlCCJO6b/I25IKgIKcgYobPH/LIExiWkAZOF75fqvgB/aQR/ZhhoA70O1DQkxnLABSJhQHDUi+gDm/v0SDbAjfgs3r1BldwGwHRs9rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Gaa/BkX2yqAHNKy16hlF5GpREPWSRO3MuQWrd1Wkaw=;
 b=VSCmfG/LgsUUh5QSJ0dbKAN4pWBwgK0rsVFDCW+Dd9VAepFB4voKPBAONIzeFov7tn8ZNXhwbD8OWpfL/X99EmB7e0sduw3zAyt7qGSR/NXb8kz8V4BssT8BGzEI0LYdcV15tjjThmTlciq8E/sduOSFHMoKV3NWfma0oVzteWDYSwu7Vv9tmf8tChmYz6DKj+DHvdclCR8N9rXbg7p0+FSazixh5EYZEisYZnCtWdklU2pmxUi5nQn5uMvPZGFmKsDbYGJthDsR+TAFdJK9+5b8zDtG7/dWtX95NeVwYw/aXGsWfGSgbkvAdagXCUZzlxcwNPagfe+udVXb8ab2jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by DB9PR04MB10033.eurprd04.prod.outlook.com (2603:10a6:10:4ee::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Fri, 26 Jan
 2024 11:09:10 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%4]) with mapi id 15.20.7228.022; Fri, 26 Jan 2024
 11:09:10 +0000
Message-ID: <daf26efb-888c-4903-b8b1-c6d72556fe9c@theobroma-systems.com>
Date: Fri, 26 Jan 2024 12:09:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/18] rockchip: rk3588: fix non-working SD controller if
 booting from other media
Content-Language: en-US
To: Dragan Simic <dsimic@manjaro.org>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, =?UTF-8?B?5rSq5oWn5paM?=
 <hhb@rock-chips.com>, heiko@sntech.de, u-boot@lists.denx.de
References: <20240123-jaguar-v1-0-1eec1c34953c@theobroma-systems.com>
 <20240123-jaguar-v1-13-1eec1c34953c@theobroma-systems.com>
 <10ebfefd-1619-4b08-b15d-ec8ca8e798f3@rock-chips.com>
 <c33d0c58-cd95-490f-9514-8d61e1e70925@theobroma-systems.com>
 <31e7cb6e-7ef1-4069-a38e-b61677a8d76e@rock-chips.com>
 <2f6e9491-9ae1-498c-b269-c0a8fbe27552@theobroma-systems.com>
 <609c74a8-80b0-48a2-ae0a-78264014accd@rock-chips.com>
 <82b8fd76-8a84-4253-93b0-bf1bde85121b@theobroma-systems.com>
 <0a9a81f47864fd566206f5e62c3df192@manjaro.org>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <0a9a81f47864fd566206f5e62c3df192@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::17) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|DB9PR04MB10033:EE_
X-MS-Office365-Filtering-Correlation-Id: b286f913-a130-499e-b057-08dc1e5f3895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ynEfVFnhHF5PM7AZ8qDrvVrmm5BSuRsNQmleE8CXCcPxlr6AXYTC+o7HQ2CRKMiM4nAso6GG4wHGQ6sxabw2yX5igRuTheKeJ4QnRBsnerh6BYuaQsr0gA8zOz+2+Iv5e9bEh8F6GxXVeQVryhulaP7EG8harXcm1d+sjHPS4xSYkHDI02iUUFrxk0eOZV+yFiWEqJuHYyTqBHmcGocB3BYiOcSvYtmbNGzzZwPe2pf/B6HEwn+6xR0A8dMe6sdGJXHlRTRAre1x5zA8OYnw6XdXBgoT33qk6K+fFZGU3GB7lqFshrhgFXiqOZ/En/IxnPrjy7fuH/y48bSZv8O7sYm9a3kf3ajOSB0hjZ1RMKGRpcOgMDAMz0chnHBYyQEvNdY0OecsTvnCf4glUA4UahOSS3+lGe1auFh1hM1zIXhp03Y906NcvqwYHddtLEa1z8J73hbOwaYW8YzmGyB16s6Nrj4OPUWFmBilMzeAopp0pS42nnfPTUu1epx6Lq9dVSFAUapEqac46JOqQjd1U7e2JeCzhr4CkwkLvmnco9C0oxMmonhyqMYOIvc6cM8vHedUHePekWbNVQabD7c6+bQxwpkYYPewRemZzo1G0u3DZfBIJmy6PyIaDCDBzl2ACzgeUDfyW07bYXUwInzvqC0Uck8ZQrYJ+9QnY/mEIoHZRIyfNyavercAhXEpDx4M
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39850400004)(366004)(136003)(376002)(346002)(230922051799003)(230273577357003)(230173577357003)(64100799003)(451199024)(1800799012)(186009)(31686004)(6666004)(6506007)(5660300002)(66946007)(6512007)(6486002)(2616005)(966005)(316002)(8936002)(6916009)(478600001)(4326008)(66556008)(8676002)(44832011)(53546011)(54906003)(2906002)(7416002)(66476007)(86362001)(83380400001)(38100700002)(41300700001)(36756003)(31696002)(45080400002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0ZVZlUrcHlYeVlmY3FUMzJxVmJrVWM3L1Q0Qk1SZ01HK1ZreDNVMm1tNFJm?=
 =?utf-8?B?ZWZmRkpWc1VkMmR5eTBLdlBqTnFidGVoamM4WVY5ckdXTHNpWmxTQStBVXdj?=
 =?utf-8?B?ZE4vWUN5WTFQL1grTU80L0ZWamMrZ3dhVnZya3hxTnYzVHZMQU13RXc5WXNJ?=
 =?utf-8?B?UVpycXZtWXRwZkJrdmcwRHdTYTQvRk0vSXdyWmkrb1RkV2l0VU8ybHhYRzVt?=
 =?utf-8?B?WVNNYURFZS83WEdNck1rdHBWQ3NKU3lza1h0cnRMSEVrOU5vcTNhWU5YQjVW?=
 =?utf-8?B?UmZmdU40cHdKdjQ1V3pJc2Vzam1GVWtSeXNsdGRjQkR2aStWaGxLdE5hNmho?=
 =?utf-8?B?Q0N5QmE2c0dsTVZCS2k5cUoyd0RLMnZmY0NDLzBsS29CYjBNNzRuNllHVktp?=
 =?utf-8?B?eDkzT0pUaTBqZjhUWmtCVVkzUzgrUURodjBVeEU5Nk5ZYklXYmJKTjNBeHBU?=
 =?utf-8?B?UUZLUEY4QyttWHRiVVowMFliUXIvT3ZTNG1tRXp5VCtERmF5WmNyOEdqeGdr?=
 =?utf-8?B?dTV1MGM1K2x6R0VqRXo3MktveTY0Qk0xN1JzQkIxNVlqOXJseXh1TmlZR3Ex?=
 =?utf-8?B?V1UvL0VvVzJ2NEZMekluaS9xS3pMYmRsQmpTMHJ3Vlg0SzRjUlBiSjlDZksy?=
 =?utf-8?B?TjZYaEFab3lPdzgvbXl5bGJhTXdZQ0hSRDZKRzhCdUxMZ2tZY3NUZVZ4R2l2?=
 =?utf-8?B?bGVaOUVTNzVGUmhscnZTWUc0UUpjVFZPZDUvTUo0QThaNmtqSUpnRm1ibGFh?=
 =?utf-8?B?SVdmMW1jUGpteGVjeTkraUp2RTNXY1cvNlA0SHN2dnlzUE9VbFRURnJaRjRJ?=
 =?utf-8?B?UEdLZUkrZDVFc3RmYUtVK1l5MmxTMnMzcHZaMzJINVBaczVVSUNlQUtRajR5?=
 =?utf-8?B?WDhlZkk2c2hzYzJEZUxWeE15NFczczBvUDcwNnpodGFIZEF1NE05WkhWU2Vh?=
 =?utf-8?B?bk1hOHBWenpYSGhmK1RQSEl5UHQ3TnlGQ2s3VVVRSk1zdFYvdWt6ak9scTFt?=
 =?utf-8?B?SFNkTmtVUVFUVGhyMmhVMjNvajdKSDIvL2RUUXZ3UG85d1pJSkQzbjRvUDhl?=
 =?utf-8?B?V0ZQaU1CUUU2SVgveVRVNWJkZ1B1blgwR2RxbDB5VGRtcTlXc281Rm0rTnM2?=
 =?utf-8?B?UWwyeTFWZ3FRK0VFaW9vZ0dJVE54ZStFMklMd0R0cE9SU1JHN0kyNmpselkw?=
 =?utf-8?B?YW45T05aRUF3eGdJYXlsVG1BaVZNZTRQQk84T1g0d3N4L0xqTnhES21IZXUz?=
 =?utf-8?B?cWNzR25VUEFQWnhJL04rRUU1eXpvLzY0M296VE5tSzVQV2U1MStIaXdtYTBS?=
 =?utf-8?B?c0hlcDdJS3dtSWtvL1U4WjBaRkVyYytXRkRMYnBIQWlqUkI3TStoMEhjV01m?=
 =?utf-8?B?eGZmV1dCTFJaeUlpTjMyN1BrWHlEYVppa0JQNXI5M0NoUzVtT3BCR0ZUZkxW?=
 =?utf-8?B?Mmkwby8vZ3hjbWJjcnp0dEVGdXNNSURsbEdvcjNNRWZzRDUwT3hXTTZIOUUv?=
 =?utf-8?B?SVRvUVA0SzYvOHdmb0JuYURITm9oWS9JQlllM3J4VXozR1YyY1QxN2IrbDFH?=
 =?utf-8?B?VWRKL3hlU2xpcVNXenlxQVlJYS8ydGgrK25DSlV5YTZybUFUcW1GMFNiNjlG?=
 =?utf-8?B?MS9IMUJhNmprMWxVMXgvdmJsUlZ5OUVoaTNtcmRDVG1rRjVBa1lLMmNCVjZ4?=
 =?utf-8?B?K0hMNzNSTDhYM01JUlZxSjhLbDFKV1BPK25qNDdOM0N1OGc3Njg2Y2tubmVL?=
 =?utf-8?B?SmwxSldoOWxtbERNZG11WVRrWmNnSVUyM0dlYmJJa2tlZTN2eGVqcmp1Rno5?=
 =?utf-8?B?YnR6RUdadUxrZHgrNmRVWVU2TlNQWmVnQjRZOVlNb0FvTElhWjQ1bjlweVV1?=
 =?utf-8?B?WW41ZnJuUDlWWlRTVXdROW90OGxjaHlyS2trNFBIU3BNa2NGa25qam9TVTJK?=
 =?utf-8?B?ZDEwNFM1VG9kUlo4dW1LaUo5Tk4xSUhpVXNrWjlYallBTHAzeDdUM3F2aytF?=
 =?utf-8?B?Yml4WlI3ejZkM1UyQnMzK25RKzZLQm1ZMHBKS1JGWXNSWFlzSTVncXZtTHRu?=
 =?utf-8?B?N3J6QzhOL0tZdE4rWldIRk4rOHQxdm9FajBwZFR0S0xTVkZUK1pyZmRhQlEy?=
 =?utf-8?B?bCs1aWZDVXBYS3o4MHRvMDZHYmJCb25BbGVTM2tteW5VU05xb3FOSHg3YlZF?=
 =?utf-8?B?TnB1VDA4bEkxQUxzZmk3TnFEdFh5UG9kSUU1ZHI4cGJQakpYb1Bsb0t3T05E?=
 =?utf-8?B?QU5xZjA5SFFkMWxWYzRqWVJBQitnPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b286f913-a130-499e-b057-08dc1e5f3895
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 11:09:10.2065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JiKJepL05G2MOh7QJSdE2EBus+Xfssarr4BHhaauej4tWht3C1G9KTMFdFUOsLUgIEyjt+5N0scBARGMxpe3ybbg0iknhqkHtKcNBatGZ1zaUHn7MH2+MM2bjsG3I5lP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10033
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

On 1/26/24 12:04, Dragan Simic wrote:
> [Some people who received this message don't often get email from 
> dsimic@manjaro.org. Learn why this is important at 
> https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hello Quentin,
> 
> On 2024-01-26 11:37, Quentin Schulz wrote:
>> On 1/26/24 03:57, Kever Yang wrote:
>>> On 2024/1/25 19:02, Quentin Schulz wrote:
>>>> We don't have a dedicated CD pin for the SD card connector.
>>>> https://www.digikey.com/en/products/detail/molex/0472192001/3044807
>>>> is the SD card connector we use.
>>>
>>> Thanks for your information, but I think you are using the wrong
>>> microSD connector for rk3588 and maybe also for other rockchip SoCs.
>>> Here are four microSD card connector from the web you provide, all of
>>> them have card detect signal available for pcb:
>>> https://www.digikey.com/en/product-highlight/m/molex-connector/sd-memory-card-connectors
>>
>> None of those fit our requirements. We need a safe system that doesn't
>> break because of vibrations or shocks. Push-pull connectors are out of
>> question for our design. We have had issues with our Q7 devkit with
>> push-pull connector with SD cards slightly smaller or inserted
>> somewhat the wrong way. I can recall also countless of discussions in
>> the early days of the Raspberry Pis where there were a lot of issues
>> related to SD cards.
>>
>> This is basically the mechanism we are using
>> https://media.distrelec.com/Web/WebShopImages/landscape_large/4-/01/Molex-500901-0801-30161714-01.jpg
> 
> Please, allow me to interject...  I'm really curious why don't you
> use eMMC chips instead of microSD cards?  I mean, if the reliability
> is of utmost importance, I wouldn't even consider microSD cards, not
> even the high-endurance variants.
> 

We have both :)

Just to name one potential use-case, you may want to save some data on 
SD card for investigation without the need for the system to run to dump 
data from the eMMC. It's there anyway, so now my job as a SW guy is to 
support it :)

Quentin
