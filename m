Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78EE6C48291
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 10:49:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB61F8777F;
	Mon,  5 Feb 2024 11:49:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="eg3n1kbz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA3A387887; Mon,  5 Feb 2024 11:49:25 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D38BD875E9
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 11:49:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVUTyaLXX4vmSuUABLMI8wqTvvmx8g4NiK5VCBEL5YKpVFkgpKwyv7+x7pu6Chn+oxe4DzMkkKKrAXRhdSe3Jsbj47VmpE2qv45z516CHCgaHf7VffAhy0LAn5QqDsZtRDKP3TcLvq2yX9YIaJJB+UyJ4X0nXWwgUEjixvRF7olLwkQgFhwcfq+Lp1k6pFRPFJyPO8ULFmsj7VQUw4AE0zQ4+ehcWMTwJStGw/TjsJttRWzU7JKdS1jk568mUf8HH5PuJxYT+CudrR0zpmdO/68lqh1IuV7CiuWJ8YhuY+Fawg8cvy802sDY4d0oBfv0lXLamDuNxJdDD2k4cu5Aww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IF534MsZgZ0VOca8fsn2c8yXBiwgtJE0Fzhmo+KpE1E=;
 b=n+8uyhd38cdLPJRN8rG0cgm4ox7Zmo/CN8YdPyt+Z1WR4ni+wiRSRf+tMUe8lJojgEkvF+ykQkWOuxxgmspJS5p4KiUqN94JzN5B5Awq22GJIiOdtBLdits38NJotIjV2Sxodn0pOD6khNcP7nU46e5Naqx59V/zoyN7Yfu0ZJidmkGGBezY22aGxLXLFC4A3kKxTrUyKejwR5blmO9ix3eEC9CwyDc8Hekg5kOoE+qOroldQ0fWZdFAODmbZhy8j5P3WpfE4nKxtqMwWe1JmrunJK3KjzrnD/JRrAQIA9J0PZA+/+zslOo6dOfKOTRE+hE2Ud9oOcPnEfGALPUdPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IF534MsZgZ0VOca8fsn2c8yXBiwgtJE0Fzhmo+KpE1E=;
 b=eg3n1kbzJ0uFy/7YFvJ9hUv2M0YzMZ8XFzXcFVMq86rhddzGAi6/vSyX6Vl98PhXkMRjgEbJCkHv/T7hzwXIb/8reSisg3syV87aNle6rqDJVEAHHG18mKZNgXymrwZAJbcyMFcQoBLZsWLFR5FMm5sUpqbiD+2nWHJ1i6ts1G7hs5HMd8TrzGjf7dX2MDpoHNhsSAMLqaLNeXV/ALCxw0/othYQliZf2Uz9c46CGzmcHeFuolW42tvdsH8Uzwg4R3ur25Qgih7EmR0V5ddxOHmWn778kp6vroLktAj2iGcvjQEi6s4pJWb1racY3yLd8PDrjZ0DBiwYfG4x1aUimg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by VE1PR04MB7277.eurprd04.prod.outlook.com (2603:10a6:800:1b3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 10:49:20 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%5]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 10:49:20 +0000
Message-ID: <85ab4e51-2d93-4672-881c-8df353232d1f@theobroma-systems.com>
Date: Mon, 5 Feb 2024 11:49:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] rockchip: Reset to bootrom download mode on hang
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: u-boot@lists.denx.de
References: <20240202001221.531207-1-jonas@kwiboo.se>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240202001221.531207-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::8) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|VE1PR04MB7277:EE_
X-MS-Office365-Filtering-Correlation-Id: ecea1ecf-9c1f-4d6c-3ebb-08dc26381b92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iJW5Bdito5qi4IkhyvggLg9nK/apLh6k3Yl7GzECXX9/CKoXykQV099kgz5XlZ4TX18v6OWtRZ0fCb414h7O2DzdqgRzbISOl+gI/ZTl4ZmA3FZAfIrk/6jNK9EmexESaQng5aXPQj9KcCAGVBbKXu+VDAj5SNl1h3oQ9PINN4jeQsgRbqBUIP5pyImzCGFP/GFxOvk19Zjr/XL0LUbfEXFRc+0GIz6NQEqtFVZwfYAywVBY24xVZVov+PcAOmWmAqf5D5LLpZH6G8YVY7768Sd52C2e+Kb8Y0iei4i61QU93u0eN91oIl10762lav7rdZoRMtR446Seo7Xl2xD3PZTUI6O6/WqDP1GqnBPmFY14VXHAHjBvtiuGBSprNFqaTxHQlHNEUME2mXbOteLUU20dFyiyt1e31yV+V1ayOhCBSnJYIQzE1EZXeu1AkxKaNF3sI1X/ZJOmiZ5yFoPDkVyA2bnn4i6zjTTF1sZLlOzm1fGdm0wcdIXBWCLMOQVdV7StWzP7N2uXL+bh4gwZe+D1DutG9IjL15eH+xq3akL/rpBylTUVHupNLHiOml9j6+Lg+R2K584/l1UZC8wBhyj43r98YQxsy6qEYKSpSJj/W92nfhQU56+AwxKL/SAgDJfv2fGkGyJA8aeGIQEh9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(366004)(39840400004)(376002)(346002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(83380400001)(38100700002)(4326008)(8936002)(2616005)(8676002)(66556008)(478600001)(66476007)(6486002)(66946007)(316002)(110136005)(2906002)(26005)(44832011)(6512007)(53546011)(5660300002)(6506007)(36756003)(86362001)(31696002)(31686004)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ykk1cUQwRWRpdkgzWFE4QnFkMWtNbmkrZUZRelBrbXhtVnRiZWZzSWlKUllG?=
 =?utf-8?B?RUh5dCtqdFdZeVVPK2k1cFpobWJ6VjQxOWpSTWNnN085RlE1bWpXdVJuRzg2?=
 =?utf-8?B?M2NaVjBBaHdkV3o3b0RLelFxK2FxYlBiL1A1bmFDbE5vdDFNeFRBU0ZGM3NS?=
 =?utf-8?B?K2Q0VUJNdnVFRnc1Z21pK1d6VUdMRmRkZzNMTEhvRkVMQlUvZTkxUDBzZmIr?=
 =?utf-8?B?Y0t2VGFQTVJFM1hNTUNrVUpSS3BGcGcxakhGRWU5MGhXZG11KzMxQitTNy8y?=
 =?utf-8?B?OGZVOHdlSG9Wc0d5MHRPdUVDYmdYVmlVczl0QTcxNitQY0NDY3ZqR1V3UmRj?=
 =?utf-8?B?T2ZpNHRidUZBTXp2amFSTWFleWxseGJhZ1A0Q29YdWVHbVZhbUVvWmRmNE93?=
 =?utf-8?B?ejRuQzFGV3IvQmQrMXdHMHBOdktSSGRsN3huTnErWndSNVAvS0VZUmI0UU45?=
 =?utf-8?B?NGVEMmFHQ1RGV0VJMFc2Um5NeWUyRXlFVU1YbGxBdXA1ZGNFelZFdjZZWmFN?=
 =?utf-8?B?bm02QVBPOG1pVDUyUVdZbjZwaGFTTXdaNUdJeTlFVW5GMkVHZldhR3k2Tjgw?=
 =?utf-8?B?NDdTcU0rRkN4d21CbFZyNFd3NGZpa0xaWGhZZThyVmkySEJzdkhyT2tOVUZH?=
 =?utf-8?B?c2dPMG9kbEZMWTVaL3dmL3BqeTl4ZkR1UElJNys3aGIrUis2aDkzdThPZ2Fl?=
 =?utf-8?B?Rm5CdVN6WW5CajAxeDNZb3BDYVdzWit2Lzh2Q2oyR3Q3VWN3KzRTNjU1NUFG?=
 =?utf-8?B?YWxLS2YrbFRSY1dqWWNUUmY0UTdTVVZLS243UlpOU2dVd1ZWeXRRbW5LcEww?=
 =?utf-8?B?Qk52cXI2d1BTcno0QnZycjlzem40c25rUEhUV0VNVFl1MEl3OHRRLzJyTjEy?=
 =?utf-8?B?RVNnMUloQUx3VkZ0aU44SHZLazU3RWpZeHdHbEFEQy9hSnREc0dIVzJ5MHNR?=
 =?utf-8?B?VU1qYitSNXFpc1NndmRiZ1JHdE15QkEvOWhteXlGMUZXT21FM1NrM3RUbU5o?=
 =?utf-8?B?Vyt2UllFc2VKOTc1cFhtT0VsUmt6RnhJcDl2N05HU0haOElZOHBHSE4vLzEy?=
 =?utf-8?B?UW1Lb0RPa25wOFdrckFTNkhQSTRjcndtT2IzT0RyOVZnamtoYUhTN0x3SUxB?=
 =?utf-8?B?eHZiYklFNTIrM3ZXSVhxUU9paDdJY1NpOEJ6VmNVbVZvTkJMR2tpOE1pamxq?=
 =?utf-8?B?WHdZOTJ0emNrdGdEZFFBOVZCeDFhMzhwRWt3K003VW0yVEVLeDlHZldtR2ov?=
 =?utf-8?B?Ym8rUnhVYmw2U3YyeG1Ed2tuU2dQY2djY3pxQk9xN3l2NUNxbkhKam9yZ2RL?=
 =?utf-8?B?bDU4dUlXbXlTZExQTks5SVpSZHpWSnJyUkt0Y21aZXFhM3lnQkRRaTNZN2tz?=
 =?utf-8?B?ZUtuNnI4Ynp0WWJjQ21kSGdQelJ6bmlDbU9ha1RKNWY2cTRFdjhlM3ZRM0VC?=
 =?utf-8?B?Y2pQKzZDTDVnU2hpNDk3VE5peEdYQVlpbGl6a2J0MHh1Y3VrWWdFQTRGZVNL?=
 =?utf-8?B?cXlaWmU4N05lRy9waVZlWTVrUXVsKzd1OWhUc0JsNEZpZU5TOVZ1aTdNOE9i?=
 =?utf-8?B?a0ExeHFVZDhBUEIyQ1k5R3ByM0JQMFdTQ2hnRjBwZzMyMkY1dXFYcWgxbjFn?=
 =?utf-8?B?ak5RaGNINXMvVXVtejY1bElwN2xIVmt3a3c0aVVzazJQVEVlZmlBZVpWQ2hi?=
 =?utf-8?B?eW1ya08yZVFPak54UWVIZzNFbjBHbkZhWUJnY3kxWXU3d2dkbCtJbTFzQllH?=
 =?utf-8?B?SHZyZFl5dmZZVjVNWjQ1NnI0dk55RStnY3k1RE5maks5V0V0SEtqUDRLWjRp?=
 =?utf-8?B?WFc0NHB5WVRGMnhIUktJWFJFd1hCQzhQRGhab0hGcHdnYUJDblRVcmxDU3RG?=
 =?utf-8?B?czBnY0pBcWJmcW1pMzg4YlNjWFRSYndsTjZwTCtFZ0ZmZm1teVlKV0QrQ0xV?=
 =?utf-8?B?eTZJVlRiVnVnK2FVWnpHZ2VUZlpvczhBVDh2dW15c0t5Sy9PV0ZEV2ZHdTVY?=
 =?utf-8?B?RDBkL3Y5a3lKVDRyQm4vcXRZY2htc1pTcjJIa3AzSy9BZWhub3R0VFVuQ3g1?=
 =?utf-8?B?THBxNWg4R1QyakF6c2c2VTdwNVBrdzFhSlQzWjcwQ0hIdGpEazQ4SEI5ekNx?=
 =?utf-8?B?ZkRIT0ZCSVQxajJ1K0svblBmNzFBSVZjZzNRVDhLY3RoUWxKclZWSE84VitO?=
 =?utf-8?Q?ZP6Kh2CDHf0Ail+oh3fUjnk=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecea1ecf-9c1f-4d6c-3ebb-08dc26381b92
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 10:49:20.3426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RvacpY+5LnwJ3IDC4tD3D43qst60oppl3XG1wx0ehcZ15/alKLbF4Yy83ft1VN2pb4HRhO7dla55u1L/uLbfbbxj2L+T5W+IPIi1ese2J6Wbo5LCBLKDwMOaGuyfDxm6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7277
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

Hi Jonas,

On 2/2/24 01:12, Jonas Karlman wrote:
> Add support to reset to bootrom download mode on hang in U-Boot SPL and
> proper. ROCKCHIP_HANG_TO_BROM can be used to enable this feature.
> 
> Example when SPL cannot load FIT:
> 
>    U-Boot SPL 2024.04-rc1 (Feb 01 2024 - 23:01:12 +0000)
>    Trying to boot from MMC1
>    mmc_load_image_raw_sector: mmc block read error
>    Trying to boot from MMC2
>    Card did not respond to voltage select! : -110
>    spl: mmc init failed with error: -95
>    Trying to boot from MMC1
>    mmc_load_image_raw_sector: mmc block read error
>    SPL: failed to boot from all boot devices
>    ### ERROR ### Please RESET the board ###
>    entering download mode ...
>    resetting ...
> 
> Procedure to start bootrom download mode:
> - U-Boot SPL or proper write 0xEF08A53C to BOOT_MODE_REG and then reset
> - Bootrom loads and run boot code (TPL) from e.g. SPI > eMMC > SD-card
> - TPL check for 0xEF08A53C in BOOT_MODE_REG very early, i.e. Rockchip
>    TPL blobs check for this value directly at start
> - TPL return to bootrom with a return value != 0
> - Bootrom enter download mode
> 
> This also fixes an issue where the BOOT_MODE_REG is reset to 0 when
> board is reset on RK35xx after TF-A has been loaded. To fix this the
> SOC_CON1 reg value is reset prior to issuing a global reset.
> 
> The RK356x TF-A blobs will clear SOC_CON1 as part of a PSCI reset,
> however the RK3588 TF-A blobs does not seem to clear SOC_CON1.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

I'm wondering if there isn't a simpler way to do this?

board_boot_order() could parse u-boot,spl-boot-order for e.g. "bootrom", 
the same way it does for "same-as-spl" for example.

If it is set, then add BOOT_DEVICE_BOOTROM to spl_boot_list.

Then this would call spl_return_to_bootrom() from 
common/spl/spl_bootrom.c which in turns would call 
board_return_to_bootrom() and back_to_bootrom().

What do you think?

Cheers,
Quentin
