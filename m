Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D17BC46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 11:05:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE40387B90;
	Wed, 24 Jan 2024 12:05:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="MKkLFeHb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B448E878A5; Wed, 24 Jan 2024 12:05:04 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::607])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FE0D87A00
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 12:05:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpHI5TKCR9sU5t0f9E+/aVhxyXHvXam6auIVPAg4s9C0UKCcKb0xDr80eag/ZSyZUgUr1TpkBdMebWsH0BM+qOK+16l7fW2ga3xkiHT88bVgJ0CJ7zFFxRB2udkM5/86MGT0v3vPzd6rN5TMhJjZZMpTO6XWMYSL9TZmHz1U+0j+aXanSiSPOpmb5dLmSIZKnU/EjRLJEB4VEITmzGTrt358eYTBZ8sjomj39c24fGNOn7QHcgXpDRdHjkxHGU02IIvcJEMV/givh/gBcE20i4VNNINL977HLo07TTlQdaRRrL3FeM6YChV4VFbfsnv56ZKc/fLZxolBGCtsr3Hj+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VH0vNCdPGMsV/eKkLMcZxp9PnRNnCNPtzn7oAP1bNI=;
 b=kkgMrpxX28g8c5tIue1WJppb85qNum7s0jyQpJlkTtZZqJ/nc4+KcZT7EfxJLooK5E4sPfRggZ0/QSZWrrBwGoLVkfUef+xFa5xDwhuivbRz1twEdujZmFOnk/FFNH6nO3PLfvaII/T1x6Gku/CHcP0JTV0tRS7FnAeCopscUvLzFET1QwBn6bv7a/ZiE8G/O0WVJscvUlye2qCUhqM97NVrAtMtkko51SiUUytU5Ts8znhAwkjNg+3nYMiS1Ku8iIoY/GY3/CoyjEaLyJFcTC6gefM4UFCE3SrofE8MAh+mksb8F6Zpv6tHk6pvz3vgXIIgrMDSC6pbC2jv9Xdbdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VH0vNCdPGMsV/eKkLMcZxp9PnRNnCNPtzn7oAP1bNI=;
 b=MKkLFeHbikFyWNI/gCwuCITjAuvjnKx1drE7efPzsx2JtkXIEG1+oJp7xttLwV3K/EoKsYFsRg31so5unTM9utSJQkvHIrhFew1k6sKeTRAhRiSXCXOzkRrNIC6Mnfd21TLPU7m8AHROLHZcacHnl4rPJqB90uXk9V1xnTjR06NS0nnvV3UI04ee3GJOSr4qfkfobJ+FsibSwPjgAFMtZK4R1P2QGcH75+FzUnBc+3D4tEzd4wJcyKVdvqkVP2BTxYW5ONOvJ/MI+ec3rO284D5Zk3ASuTbd48E70INNSsuDan+XfqzhxHGMyuKIF53FrP26fIVeLCgxrcfmTLfVIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from AM9PR04MB8539.eurprd04.prod.outlook.com (2603:10a6:20b:436::10)
 by AS8PR04MB8295.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 11:04:58 +0000
Received: from AM9PR04MB8539.eurprd04.prod.outlook.com
 ([fe80::708e:e38f:c656:8325]) by AM9PR04MB8539.eurprd04.prod.outlook.com
 ([fe80::708e:e38f:c656:8325%7]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 11:04:58 +0000
Message-ID: <5f4c826e-9ecf-4620-9430-b317e472cfd2@theobroma-systems.com>
Date: Wed, 24 Jan 2024 12:04:56 +0100
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
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <062d9519-f129-422c-89ed-3b009e222150@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::12) To AM9PR04MB8539.eurprd04.prod.outlook.com
 (2603:10a6:20b:436::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8539:EE_|AS8PR04MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: a448a448-0910-47a4-3d5c-08dc1ccc4deb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KvLulgp382UJZ7ptqeed7j5kCvqDhM+3rvZ3MgvMY5h9Vn20UwimGrBSCcCsbo7xLz0JgdG++wzq4C09jPREfNCh2Gd6yZX8xdRxJF8w17ujH6THWTOoamMN7y/a9Ma60a8oC82BuAE7ze0shbzUbK7HUwGOBxhpA6EYBp77wKbyltfSilw0QBCIBEfIfqaxQYuuZQP711w01tgfMn6QH7FCVE+Fp3IBa5+Upv+A0TMoXtGTwkMVPxecwBxsrTb5eJ+ZDVZrQnIMXnECYn74gXtw7JnkipaGMxxD1tYRHFL6qZfGRgHdXy1GrJz/GtCrktJ7IvnruEzLUX6H8LqFX8ULp7RtTw/GmYZIWFFi+yOtJ1PLymZCiOS3CE5kznlSeUWx3kasqXpaI5k/tuWoch4OF/VAfPNfxFsOtwdeux+cHXRKz79l/b7dr5IG5QaN2+HgT1DUlKFkQ5zOwPDWinn4RURycpv2t+AYSDwX/QCy4Qk08LuhF9iB0xLySqtJeBvoYBGRfyITHT4eOdAmOjgGwZMgmY3IKlZF2WUiQIYWLXQNOYPOfes6Ki02UpNn1G08zdXQC//6XRvZbHZHTZiY71sd0d1FDf5taxIRKFZQM9T5Zh2RuHwdVh5dwOaPdkDJsMzT37mkfh40gvC228PCy6bAA9jBeJzccrrTEfM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8539.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(396003)(376002)(39850400004)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66946007)(66556008)(66476007)(110136005)(316002)(6512007)(6506007)(478600001)(86362001)(53546011)(2616005)(6486002)(41300700001)(38100700002)(83380400001)(31696002)(921011)(36756003)(4326008)(5660300002)(7416002)(31686004)(2906002)(8936002)(8676002)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUoybnVnbmxETVdBV04xTVc5VG9OZ0NudnNsbGd0U2xyV2hZT0loVzNDYThk?=
 =?utf-8?B?cDBmNVg4NUVqMzZ0eDRuOWk1Q1FjS1drT0IyZHNjTVlndzhYMGxWdUQzUWh3?=
 =?utf-8?B?eE1KcG52RFNhM0txdzlzckEwMXp3Rm1aZkdyUnpCRkVjWjJ4cGwyUlMwM3R6?=
 =?utf-8?B?R1FXUk9yM2hKTi9RZzlPanZ2NXE1UEgyMHN0SUd3RVVYTFBLTmlwUjNrcFlZ?=
 =?utf-8?B?N1o3K3pXR3hkL25CTnN3WDBvR0RWOFdJYWpZcVpud0dWUFFOc0NOMlNTYnhr?=
 =?utf-8?B?VGRvUTdFTkR0bzNTdUxPSzExY0tsSFhWYXJPWE55Mm5meXlicmdMVWVXMjA2?=
 =?utf-8?B?RldUTXh1eU1IUE5Za1BEb1FLOGlpVURMOXo3UG5FaUNTYVZkK3hVcTZTNmJu?=
 =?utf-8?B?VmxOUUE4NGdDU2NQazljS1VraTNWYjZoWFN1dW84WlVnbWRRVmZuTWh2eHN0?=
 =?utf-8?B?dHA5R2p4anBIbW1FTWp3OGRZTFZUNTNack11eTNtNkM5MGNGdkhOSmdpeTdw?=
 =?utf-8?B?UFc0NGRuaVI5SktCOVYydkpnck1sTzJrMG13azU5bWdaSlVnc1RQOGxhSkNN?=
 =?utf-8?B?a0d1d01BSnB5NWFGVXBuVTZ3NGZJcUpGOXZ5MzBHL01QU1R3dnpzUlJyQVYy?=
 =?utf-8?B?YmtRVHkySG5WY29qdWpoaHN0Mk1MODhqRFgzUEY4WktERW0yWWlrSVpxYTho?=
 =?utf-8?B?WGhrZ3dvT1FxOHNyY1d6NTlzOU5ZZ25GRUtMUnR4WnJiS2t5WEg4VEdEYlIw?=
 =?utf-8?B?R21mT3Zkb1hpQWlmLytPQlJnSHgwdHVaVjEvM3BmaXBmYmlyT0lnMjVLRm81?=
 =?utf-8?B?aVU5UlV4ZnZkSzBYaHdFRlBnZlRENjRudnV0RXgyVml1dEQvNXEzbjlhNHI4?=
 =?utf-8?B?WW9vQXFOVWVlTkZUNjVyVkJJQWhQcUdRakRKMG9PVFJSUDQvdm9MRG1GM29X?=
 =?utf-8?B?MDV3bVJ5eXBZWjVPV2I1dmxOenh4azY3TVhJTytGVlNaODl4Z2JwWHQveDVr?=
 =?utf-8?B?Vk54N2g2Unkzc2xpdHI2TnRrdi8rTUNIMkFGZ0ZqbjNqck15S0dYSW5OMXFk?=
 =?utf-8?B?RmJ3cGVRVXJuVnlzUzZoT3orbEFHV3RQNDFPaE5NeVZpRmRUbitINFZwckgw?=
 =?utf-8?B?b1ZtanZoeDdmTXdUSUJKWm9sYm1KbzNWajExS2NCdkJVVzd3bVI4b0FxY080?=
 =?utf-8?B?TWc0WlBoQnEvZUhHdXJCNUJZVWhXZWtmYzQxVnlJSGx0bEd4dXBWZGdEZEtR?=
 =?utf-8?B?S1haU2JmdUlpcUhUdVpVOEJzamI5U1Y0TVNyYVljeHRtT0R6ejVRVE14dC9m?=
 =?utf-8?B?SWV1akhiYzB0VEhZM0thdWJGa1FEaXVEUm4wNnZiRlBKanp0VldqUGlHY2FJ?=
 =?utf-8?B?ZDM1cmVtdHQ2ODZsQlN5TUNoRTQwcWR2eGNTeEp1UWxQVjl6aEhKVzJqUlVM?=
 =?utf-8?B?WUNIM2VaeC9ENGV4RmlGQWx6R2E1SlVERXliREd4OURvQVFKK1Q0T1pZRTJN?=
 =?utf-8?B?UFpuQ0JCOFNnNXdrSmVqTW1TVGM0c2kwVEZaZWQ0eXAwQlFMREhMREM0ZzZ3?=
 =?utf-8?B?SEdUeTdZNS8wWFloTndCTWZKeS9iam1GREl0MlZaeU9qcXd4cXZNWTV2aGFQ?=
 =?utf-8?B?djdXL0tZREk0U0E0RjJDYXhTK01ndlhqNVgxU0cwVE9kenBEZWlUUDU3YnpV?=
 =?utf-8?B?TkkwcFBjN0ppOTJaUzZBQnQ4dGpHWWFzdDh0eGtBRmhIUHg2REtTL1Y1TUk1?=
 =?utf-8?B?QlF1cXoxQlBnOTNBQ0M0Y1FIZEpDL0QxTFVnSmJWMGR1MUtVRERScGFMVDk0?=
 =?utf-8?B?YTBqbjVMQm5FaW03bHJTckJDZWMrNEMrQVVlbndzam55RXVNemR0UUdRT1oz?=
 =?utf-8?B?OHlrZ2VINUdpNkJIeE9HTUR0akNYQXROc2IzUkVQcmlnQjdmc2NCN2UxckxH?=
 =?utf-8?B?R3BHVXA3SCtMdGYxeDkxck9sZytmZmNLR1FDNWFJTVNoNUhIWU5SaVRwaFht?=
 =?utf-8?B?QUxZQ2Rvb0R4QzNHUnVXbDA4MDQwRlRISTZXRS9tZVcwR3NuRUR0MEVmRnE4?=
 =?utf-8?B?enJEdHVobjVmQ29TcjNnYzRVTDFia1IyYjc3T0U2WjlObWpGNktrMnZRQXha?=
 =?utf-8?B?T0MyaWJodnFVSU9CNWM1bEhEYllybjJocitTV2JNb0JZYUx5c0hwSjRhZXl2?=
 =?utf-8?B?Nkkvays2SHE5SXZzRWhEVmhlMnhpSDBHVUMwdS9RZmRNdWRUdFQ5T1kyaEF3?=
 =?utf-8?B?V3hXN3cwd2RreGhVMXlSODVaaVNnPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a448a448-0910-47a4-3d5c-08dc1ccc4deb
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8539.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 11:04:58.7942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aCf4kwQD6OQIk8K/8sAgmMDy1E/gmyUTEKC7ZMDTqcWf8MiSTXb3MW7WD3/Pb7eXMAZvJgD+eEpMvdJsTnhI0KbSPCwOKoBBgRi0ftAsnt+YlJ4b2jVvClffoZ2t7PnL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8295
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

On 1/24/24 11:35, Kever Yang wrote:
> Hi Quentin,
> 
> On 2024/1/23 22:49, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>
>> Since commit 9e644284ab81 ("dm: core: Report bootph-pre-ram/sram node as
>> pre-reloc after relocation"), bootph-pre-ram doesn't make U-Boot proper
>> bind the device before relocation.
>>
>> While this is usually not much of an issue, it is when there's a lookup
>> for devices by code running before the relocation. Such is the case of
>> env_init() which calls env_driver_lookup() which calls
>> env_get_location() which is a weak symbol and may call
>> arch_env_get_location() also a weak symbol. Those are two functions that
>> may traverse UCLASS to find some devices (e.g.
>> board/theobroma-systems/common/common.c:arch_env_get_location()).
> 
> This sounds like we need to update arch_env_get_location() instead of 
> enable mmc driver
> 
> before relocate, because you we don't really need the mmc driver works 
> here, there is no
> 
> access requirement to mmc at this point, right?
> 

All Rockchip SoCs except RK3588(S) and RK356x have it done this way, a 
little bit of consistency wouldn't hurt :)

I need to be able to find out if the device that was used to load U-Boot 
proper is an MMC device so that I can tell arch_env_get_location() to 
return ENVL_MMC; in that case.

For that, I've used uclass_find_device_by_ofnode() which parses the list 
of devices registered in the UCLASS_MMC (for that scenario). I assume 
the only requirement is that the device needs to be bound, not probed 
(haven't checked). If there's another way to do this **properly**, I'm 
all ears. I would likely need to do the same for the SPI controllers but 
since none of our RK3588-based products have SPI-NOR, I don't need those 
(but it works on RK3399 just fine).

I still think there's value in having consistency between all Rockchip 
SoCs (and if applicable to other SoC vendors, then those as well). We 
could still do both though, have this and then fix the need for 
requiring sdmmc/sdhci devices to be bound/probed for env_init() 
(arch_env_get_location()) to work.

What is bothering you in enabling those drivers in U-Boot proper before 
relocation?

Cheers,
Quentin
