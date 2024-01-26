Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B75C47422
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 09:32:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2204187BD1;
	Fri, 26 Jan 2024 10:32:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="J8G8lr4Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EDC08785A; Fri, 26 Jan 2024 10:32:35 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53FD787BD5
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 10:32:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kj0zEPP7wuTdD9GdrM4e3OSjZnnmIUUNXjN2/0lnCAsluUCRjrfOM63eWHUXVbJW+omNPAiDN7yJmYDRvUBAM9hCVynQZGL8ctgvCyp6ynwLMzcqUftntSv3ijor6pHfHfJgeZMkEqhTtzAx3YKVkUpEA1ggEylxNXtUsQBijapwRY0FtY2Ic77XQVLg35Dv9J5GJax/zQc0xUlCmHMOXbjZMWzyRT21o1sKO343h+jofcwhuBGgxyVTvWpFtYxWeFfkuETRLj6N0jutmqbmUxiF4xvEVXu+sTfPbO6FsGeIFmKDS8tTgevKn55DvLcDLaHlllje1XHBRMEdQboEWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DzkxpsxSeK/Wm0oP/vWXkHTUNnTE2XljwZWSTJtcJRw=;
 b=CkzVayU5mEwv5+d/8szVkVfMGB9vf83Lcgc1VCV46yYTeex6ZorS7fXu3k9z7ALTWvpevdP4JjAGQxw2hMJ7hLbqkjlO2EGfbaqtrfu+d9MgFXOkkBANcokJsh+E1N93gxih/DaUfssSGX53VZLfHwFdwDewJfzJ0aM3RW8yitG71TgbnNgionx+L5xTi6Rv7QBgfhzppr7jZUe7cM1lI4YWJ6DR+4h0gaNLk+DWEkKyU3GurC/TNDlOoMKJKkFJcTMcKARPRHLktIxo4blsJEL6rh0n/cuQa3+PAZbKYMSG20cR5k62DIio3yxoExpvWksPwPBKRgB4mo01ozYz+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzkxpsxSeK/Wm0oP/vWXkHTUNnTE2XljwZWSTJtcJRw=;
 b=J8G8lr4YBQ7hfT0nnfA6hfq6UVeEunLK1w5bljuAISSpPtF3gXgQFdGa6OIMZE4nycwVK2OLwo/ZxaI5RueX/i9r3k273j3wjUUTpIAKc1Q2Npjn9Jm/PxwYUkQz1KP2UgVxGxHQCh9kcqRGJmoNEiDV52Whz0pzeBWmLkrsJ8bPVI5/ugg2By26FhiyHonQDDrdfyHoK+2csSvqgZs0sod9Da+n/pk2Yh28iKvyhs8AVww/Nyj3koFs+Som0c69K8OWidH+A3y2wYFdDpkS/e9Gql97jhuXcCGDiwzRC1A7GjiJV7NGxkKBdXdN2sJ8oiAJdH3pRWXx4Ec7Nh/nmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AS4PR04MB9434.eurprd04.prod.outlook.com (2603:10a6:20b:4ea::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 09:32:30 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%4]) with mapi id 15.20.7228.022; Fri, 26 Jan 2024
 09:32:30 +0000
Message-ID: <f2ed9f73-97bb-446e-9396-9de3ab01b8d5@theobroma-systems.com>
Date: Fri, 26 Jan 2024 10:32:26 +0100
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
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <928cfe56-1a7d-4024-aa9b-c14654b150e1@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::6) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AS4PR04MB9434:EE_
X-MS-Office365-Filtering-Correlation-Id: 53a4ce17-af3f-4a7b-88d4-08dc1e51b792
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JuKimGz+gNBWsP1PWYqEi603zC3cDzJ3QoODGdc7IPNs6k5n09vrswUcio1xg60e/TjVpnNyRx50q8VRYYGZbpOHW+NY0nYnKdzxr9MthQaMmsERqz+frnd0c+b+m5D1d4Y7bTC8dvE4SL4M5ByC2NTocnJkMd5NwaTXAKGZndAEWSIFt9oX+Maz/E2l69CovYaz1/lBSzJ73/K+R/t+JeSNwbJOx2/OyzOe6wxbvvln5FdaiKgEDHvTVUZeIm8OEdhXF0vWA2IufsvaJVUwPu7N6GVgL3F21fznU8/C3aq6P8tQ3SfEAK3JJ8m7mtJ18XE9m3SwMZKvWvZGX7Cxe7Nxpc/Da260xG5ocSJ0BB5Z2meFBgiOQQpYSnMNElc27wHy+L280Co2mdT6RN7VD4QilpzgUoREcsMmLgltBWCuXp4MU0uLHUFeIwQij4f8rZzXUu59jpm75RoJf9sfeQGtZ52rkouh/5KprotcpdEr2CZZMibZ9nKQ7eODwxk6sjP0E4ZQCJ3AQKlgPMro84I8OaSJt8JUoG0FkBKlNI/vptuNFN9avWpkpqc8+fxbcXmHJfK/X5jQ6a5Nq5PWvoRLEFV5ImHC3JEWxrXu2tRRlr2/Q1DqbzqQiOhyYyVJpa2QYUo6GBi4IHElkVKFIqnHxPQyUzNpzeKIUJzu2OM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39850400004)(366004)(396003)(136003)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(921011)(31686004)(6666004)(2616005)(6512007)(6506007)(31696002)(86362001)(478600001)(6486002)(316002)(4326008)(110136005)(8676002)(66556008)(83380400001)(8936002)(66476007)(66946007)(53546011)(7416002)(36756003)(44832011)(41300700001)(38100700002)(2906002)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2Y3eXZUUTlCWEs3OFV4RW5CcHE2Z0RpRFBlZ29hMEJzZWRuMXQ0RktuQ2VW?=
 =?utf-8?B?d1pBeTNmR29DUno5b3Q3UE90Qjg0U3QzVW5oZndhQndBeW11VmFsMklYT05k?=
 =?utf-8?B?RDAwMW8vU2YrMGZBd1RvM1cwbGdiZGNKL0JFM280czk4VlFoVm43cVJhZEsx?=
 =?utf-8?B?KyszNjk4S3cwd1Z3T0UydkRmbTYzc205RDlXa250MUQ1UmMwNTZlWjg3VE1S?=
 =?utf-8?B?a1ErTENGeW9TZnBSR3VuZkVDRnQ3d2NGVFU4NXUwZ09KVitvNmd2bVMvT0VF?=
 =?utf-8?B?RjFyR3lIbERYV2pXZitaci9NK29TVzljdzc4QStFMkRVRGZrZ2FVelpMWGRC?=
 =?utf-8?B?a3NQY2l3ODc2d2hsQ2FuNXRaVUFjM1J6NVBXZHdCSmloUTV5bEIwZnBHNjN2?=
 =?utf-8?B?WU1TYjFlRTBwRWdoamNydXhDRXo3MkVsM2k4NW1yZmhIRXZUZ0FEUnFoQVU4?=
 =?utf-8?B?eXVTVlQzaXg0ZXpIZWQ3R2dlY1VyaE1FMExGMmJlTTVGQ2paQW9XSFk2cURr?=
 =?utf-8?B?bEszeFExTkpaM3F0WllBK2hTR3YrZUROVHlERGJMcUJSelltcldHQ2w4Wndl?=
 =?utf-8?B?N2NpcWNFS1UwNmlMbTJpb1BTKytGTUlRZXVKTEMwMzFWcWM0a0k4SFVuWWRD?=
 =?utf-8?B?SzkzME91UWYrdEtuYmR4Y3RMaXA3MUZzVm5Ga3pPRjJDcVF1SDJ4QmIyaE9D?=
 =?utf-8?B?WmR0VG1DWnZNTE9OUXRrbXBFU1FCSmVyUHFYL3V4VEhuR0pFSkJEdTN5VFQ2?=
 =?utf-8?B?S01GOHhkS0RlSVYxSUVCSTk3SjJFeUNheVY1NC85bjJjUVNhc3o4M2VHMW1Y?=
 =?utf-8?B?eXhaMnB3QW1Vai9xRU1BQWttcDd3eEgxVzB0Tk9yWGk5dUlJR0JtOGVFT0xD?=
 =?utf-8?B?R0ppZEpHeG9sMEl5MVdQWXM0RzBvL0pCUGExOXBnL0ZuRGZ6U0drNWI1dmxK?=
 =?utf-8?B?VGhhNUJpOXRTdVplSFpXdURJVVJTaU1POHNYRXY0eHl1U2ltL3c2ZkF4RUVC?=
 =?utf-8?B?alZ4c2pUTlFiQ1JOd01WVkVneld1V2JSQytmWHVaTWhtNTYzdzhScWozMzdH?=
 =?utf-8?B?NVgxb0lodFl6ZmhpL0xpSVVPSW9BZkJ4V2ExcHVZS3c3RmxUYWxxL2QyZHVP?=
 =?utf-8?B?ckIwVndMY3A0eERqUXdlQkdqWGFSc0xIRmJudmhlYjJKRHhoZVNDMWhITmlU?=
 =?utf-8?B?WUd1MWVjcGFjS2FWNmR5VUFxU0lJaFAzcm53eGFEMy9Xb1FDRTdSc2xMM1Rv?=
 =?utf-8?B?NjZUdHdyTWNaZFJlYS9qKy9MVVNsbTFzMThOYlp6a1JjVExxbmNFamI4NGow?=
 =?utf-8?B?SXJOQktFcE1ERVhtSjducXM0VkkyUGJZMUlNN2hFSGcvSzZLbFU2ZHpJZXVT?=
 =?utf-8?B?ZkNqc0lYbURMOWNiak9hWllyVEt0V1hBU21sL0tMTE0vNWNpV3ZKaTN0YlY4?=
 =?utf-8?B?NWxBaTFncXFjTExERjlWT3ZUSHlTeG5BNTFwRDQrZTFXOUJUcmF1WFdiVmpY?=
 =?utf-8?B?NG5PT1llOTFBNGR6VUUrWkk5YkYyYXE4UHlDRTUrT3EraEx0VytGeVRVQlNI?=
 =?utf-8?B?azdCbm5BMUlzMXJMeVdVcGw0SG1kREdYSFd6UUExaXBDcjBlREt4ZU41OXNz?=
 =?utf-8?B?NWFpQ1hjU2lGZTVXd2xCb3UxdDZyNWh0SHlacEhPWUZ0NGd5QlhHbHZjYUdN?=
 =?utf-8?B?eEVIOFZNVjlRWVBVREFxQWFhTzc5bHBKcUNjYkZWQWh1Q1VRM3FRaTVqcXBa?=
 =?utf-8?B?OFlYdG5UeWkxUDZsTHdhWng1U2dBK09RaW42RHFRdndkMkR5bkJzT2NBSXBI?=
 =?utf-8?B?aWE5ZFM4U09OSHVLRTIyZFlXSDFjRU9yaGM0Y2F2MTA1RXVPTWlzNHUra2sy?=
 =?utf-8?B?bDkxMWtKVmhDbVRVWE9EN0w0MjJiOTZMN3NGaHQ2eXlzWTB5S0tJcGZmZVI0?=
 =?utf-8?B?MU9yalNpMmZrZUJHQzVpSDcrTUF1NDZmUkNaZkVtYjJsUDRDMjJ5bkEyWVRX?=
 =?utf-8?B?UnlVVFRhS241b1A4VWRRNWRZV0IxeW9yUWlFTTA1REplNDEyeDkyVWIyL1ow?=
 =?utf-8?B?MVc5cXo5cmduZzN6dmEvL0wwZU4vamF0YlN0S1dYakZ3UzAvbGgxK3p5cFM5?=
 =?utf-8?B?UTRVZnJwL0liMVEzTXdZRmxKVmZzRGdjRFZNK0U2NzZLcjBiSUFsQ1hUMnFw?=
 =?utf-8?B?eEJyK2ptRktSV1J1bSs1cGRLUHBNR0pCakNsY1FqeTh2R2l2QU0yN0VraWdv?=
 =?utf-8?B?SGdRNExSZkxSOFI0WlhUMkVIMHhBPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a4ce17-af3f-4a7b-88d4-08dc1e51b792
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 09:32:30.2873 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QEWFurCyeT/tNvHUwGRhmjQz2amMSmJfSh8CA/E1UGGLI26D1ugrMop/LqAgdjtvWXJOwHamkFPlVRMJ20yJ+7/Yeum9zhE8BCw90tgIE3EGEeF+hbLdtYxy6fFTD8Cc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9434
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

On 1/26/24 09:58, Kever Yang wrote:
> Hi Quentin,
> 
> On 2024/1/24 19:04, Quentin Schulz wrote:
>> Hi Kever,
>>
>> On 1/24/24 11:35, Kever Yang wrote:
>>> Hi Quentin,
>>>
>>> On 2024/1/23 22:49, Quentin Schulz wrote:
>>>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>>>
>>>> Since commit 9e644284ab81 ("dm: core: Report bootph-pre-ram/sram 
>>>> node as
>>>> pre-reloc after relocation"), bootph-pre-ram doesn't make U-Boot proper
>>>> bind the device before relocation.
>>>>
>>>> While this is usually not much of an issue, it is when there's a lookup
>>>> for devices by code running before the relocation. Such is the case of
>>>> env_init() which calls env_driver_lookup() which calls
>>>> env_get_location() which is a weak symbol and may call
>>>> arch_env_get_location() also a weak symbol. Those are two functions 
>>>> that
>>>> may traverse UCLASS to find some devices (e.g.
>>>> board/theobroma-systems/common/common.c:arch_env_get_location()).
>>>
>>> This sounds like we need to update arch_env_get_location() instead of 
>>> enable mmc driver
>>>
>>> before relocate, because you we don't really need the mmc driver 
>>> works here, there is no
>>>
>>> access requirement to mmc at this point, right?
>>>
>>
>> All Rockchip SoCs except RK3588(S) and RK356x have it done this way, a 
>> little bit of consistency wouldn't hurt :)
> 
> My point is not about you can not enabe the emmc before relocate, maybe 
> I'm not clear enough for the reason.
> 
> All the driver bind/probed before the relocation will have to do the 
> init sequence again later after relocation.
> 
> The emmc driver cost pretty much time at init, we should avoid to 
> duplicate the init process if possible.
> 
> For this patch, you want to make it pre-relocate because you want to 
> make sure the emmc is available for ENVL_MMC,
> 
> but there is no read or write requirement to the emmc at this point, 
> which means we don't have to init the emmc at this point,
> 
> maybe we can check if the driver is enable if enough.
> 

Now I need to know which SoC we are booting at build time so I can check 
which drivers are supposed to be built, check those symbols are enabled, 
then traverse the Device Tree with hardcoded DT node to locations of 
MMC, SPI flash controllers, check if those are enabled and finger-cross 
that those drivers will actually bind/probe properly later on. That's A 
LOT of checks to be made.

>> I need to be able to find out if the device that was used to load 
>> U-Boot proper is an MMC device so that I can tell 
>> arch_env_get_location() to return ENVL_MMC; in that case.
>>
>> For that, I've used uclass_find_device_by_ofnode() which parses the 
>> list of devices registered in the UCLASS_MMC (for that scenario). I 
>> assume the only requirement is that the device needs to be bound, not 
>> probed (haven't checked). If there's another way to do this 
>> **properly**, I'm all ears. I would likely need to do the same for the 
>> SPI controllers but since none of our RK3588-based products have 
>> SPI-NOR, I don't need those (but it works on RK3399 just fine).
>>
>> I still think there's value in having consistency between all Rockchip 
>> SoCs (and if applicable to other SoC vendors, then those as well). 
> 
> 
> This is the point I do care, because I don't want the boot loader too 
> heavy, especially the SPL and the U-Boot proper before relocate, 
> although we can enable all the feature in it in technically.
> 
> Even for the rk3588 which is kind of powerful soc, still many project 
> need it to boot fast, which require to remove all the redundant 
> operation in the boot process.
> 

It's a bit surprising to start caring about boot speed to justify not 
binding some drivers on the fastest (to date) Rockchip SoC while all 
much slower SoCs have this enabled :)

> 
> For the feature record "spl-boot-device" in SPL and read in out in 
> U-Boot proper,  and then Swap mmc0 and mmc1 in boot_targets if booted 
> from SD-Card.
> 
> It's OK for Theobroma-Systems's board to enable it, but seems not also 
> required by other boards.
> 
> Usually we consider the system in two stage: bootloader/BIOS 
> stage(including all firmware before kernel) and OS stage(including 
> kernel and Linux/Android OS),
> 
> and for those boards(eg. PC like) do have two different storage medium, 
> they put bootloader in SPI flash and put OS firmware in other storage 
> like emmc/SSD/SDcard.
> 
> In this case the U-Boot boot target does not need to know where it's from;
> 
> in another case which supports firmware update from SD card, the U-Boot 
> boot target needs to set SDCard as highest priority, also no need to 
> know where the U-Boot from.
> 

So... this means we need a different U-Boot if we're booting from SD 
card so it can know which boot target to use by default? Or a different 
environment for SD card? or requiring the user to stop the boot process 
and manually change the priority? Or what are you suggesting?

It all boils down to sane defaults. If I understand correctly, you want 
people to have systems which can boot really fast by default but don't 
mind if people need to tinker to get things working properly. I would 
prefer to have most things working by default and let people tinker to 
make things faster.

There are a couple of drivers that are selected when using Rockchip 
boards that shouldn't be necessary, e.g. ADC support, SPI flash 
controller (to name the few that we have on RK3588 that we don't need 
for Jaguar now), there are also DT nodes that are enabled by default in 
rk3588(s)-u-boot.dtsi that aren't necessary for my use case, this also 
increases the size of the DTB. I don't really get where you want the 
line between convenience and speed be right now. It'd be nice to have 
some kind of consensus/guideline if you already have one in mind, at 
least I'd know where we want to go with this :)

Reminder that if people want to make things faster, they can still 
override this in their own -u-boot.dtsi by deleting bootph-all and 
adding bootph-pre-ream instead.

I can keep this in rk3588-jaguar-u-boot.dtsi sure, I'll have to do the 
same for another RK3588 board soon as well.

So, up to you. I gather you'd prefer we have this in 
rk3588-jaguar-u-boot.dtsi so will do this for v2 except if you're saying 
otherwise.

Cheers,
Quentin
