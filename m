Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C9BCDB47F
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 17:36:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E78AD8460E;
	Wed, 24 Jun 2026 19:35:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ep+bPmns";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A53DF84671; Wed, 24 Jun 2026 19:35:58 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FB5780398
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 19:35:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYLQ12xbYPmIr297ifjYFMMNSdGl5finAW8QXC9NkH6Rg4ImH9pRKbjS29/LXngKbGWsT0bSyalLnt+ias0H5bxCTiVQ17A281ToYIlEqiM/Gr1D54xNtbg7sdcDekTwrUMq3eCsrv0xf8YTKlcHY1uiUHB8c3lB3L6GiNsbKfdanjwoAzvGnKiyCsn910udBOdqpIXPfyZIwrwrMTAZC6dI83gxT+N7EdZl3cZJOHcb6Sbrhp/7fUPdKtvSRhZLAEcysqPenE2SUu/bgRktr2EaWGI4381cLFnZQ7w9YZA61GZ83lrvEl6jWsbKF+8gxQWjru8tu1HHZxtflTiLzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jYk1tOqi0PVKm1ryTtv5CX0EN6CrOLA3PiJ/N/P3jQ=;
 b=kbl7XDFTMi2vMB8s143OFuqjaLkARGhhrMAUQiEOihcMmGfuyEk2qx+3J5fzHvZ7G14Tl+zifAVU3SLdc7QvyqMOVPLGPOWRoS8CZGAAH3cKqfvPjXj9HN5AHkw87bLcATlZr80bE+RmXwnwaxLXxvOLQi+6AkA1f1QdAeGfybwXlSCmCRbhrwdM0pvMN1MRe7zxQt7DQrGvVsBBeiiTE60oBOEQo0mVfr+DzZSvZ7w+IM9+MOAr9d/jqXZJpFw1hkHszjyYy3KiJM+nmMRPXF/lQTMyYrU7Eqp3XIzAnZ7s7QuLfN6GI4tM7cyIB6BGWXl6or3p+gZ4u5Y4a6poTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jYk1tOqi0PVKm1ryTtv5CX0EN6CrOLA3PiJ/N/P3jQ=;
 b=ep+bPmnssbRcMwC9kfw53Osz83YmV3YuPz8T12USlHshSil7l7pCBqKybBJppvve/yvbEzqqQKRQykROfuxir9VttGyNmUsfmpO/BfMgMhpAddKAHEzUQPSfMGZL772nKlxNDzsnY4haa4+z4ZPVoIRaYMVwRiduZ2BRuPW25T0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by GV2PR04MB11422.eurprd04.prod.outlook.com (2603:10a6:150:2b2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Wed, 24 Jun
 2026 17:35:51 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0139.018; Wed, 24 Jun 2026
 17:35:50 +0000
Message-ID: <e56cb70e-1a66-4ebf-8014-7fd6be9c69ef@cherry.de>
Date: Wed, 24 Jun 2026 19:35:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Convert env export and import to use getopt()
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Sean Anderson <seanga2@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Heiko Schocher <hs@nabladev.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
References: <20260520201218.3752042-1-sjg@chromium.org>
 <20260522170328.GU1858239@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260522170328.GU1858239@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0176.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::33) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|GV2PR04MB11422:EE_
X-MS-Office365-Filtering-Correlation-Id: a7bc74cc-a8c6-4597-8533-08ded21708bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|366016|22082099003|18002099003|3023799007|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: 8UkWyJId7t53zVqy1rniKydwcVGXWjfMh+F9KLsg3NTzQ3nD5zejWUN6EjTt9ncZVHC4/hNeVuYShG+unFY9CFBoXIUvrWmYwUsFYI7t5hViyxPEG8lg/wLy8858TtG3xMaEs+DT0C31KlLaGPwfNJLHjwPEQN+lWYo/B8XhUhHyvZhk32jJsSYhoZqU/FhqjXJpwMgVN1nV3tTMotFYnoDIub+EDEK2Xm02JYstIulROjqrh5jx26P0GzVdKut+OZMywWj4fu7bXm+0U/0ZnOijCnHao96L0aMIko0xF3dJ8agxvsjLsgUVk7Ta40285Xq3i0hDkLlv5SJsEiUS/SuTeKp9gHW7EE2MYRaosxMEhJ8dIHNa//fBtvw3H/ufR4p3fJWUfSdKfIRoRvPMIaTyfsKCSeU6UCDjEvnRfKianz2v8zBbsWqYjVKh6/dALfZ/Bgrmk/lSF8TaTEJjaLwwxhFVaKxEcisdxTQTI7+IdhF0wb+9WABF/1teLlHaGpmlwGsOW2BBYVCtv1COpCQxGfApYAKJaMuvObi+NhPRuKfgEn52EBKZJ4sAEqFVMSdINYJvJRnyBvVPkFr0vcCHdrmwAgvkpmgUA+XyYTK84Bb04pkIX+7jCrFbwq/ftmn9A9pJ3xyKOQM8Jhbkim3CCgRPIrlFq1Znpgym8S8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(3023799007)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFlHWndMTTZpaUlnL3RGTzZOeERMWm80d2d6dGhIaWw2MWQvM3gwSmN1RHdW?=
 =?utf-8?B?T3RYL1lWRXB4VXNDNXl6S28reC9LVDJZV2JjMndxcWx0VzlvNG4vc2szUG9a?=
 =?utf-8?B?a2tCRDV6WEpMd0NMMWF4NG9mS1lRcDhWS1h2UG5VZWFaY2VKeDAwWWVxK0or?=
 =?utf-8?B?OHNuenNzTTdXZms3ODVNRFBldWFRWkZEZm1xNDVmQkJ3cC94SlhndE13Y2NI?=
 =?utf-8?B?OUhMY0Nkc0k3Skk4dU9UVlZyU0ZKdnN4b1hxRW1kOVl3Y094OVRsRmJEblBN?=
 =?utf-8?B?TGluUFJoeHhPQ2N0dzQzR3UzWGt4YU1NeG9JR1BHdk5ka2IwMzZCWXkvY21j?=
 =?utf-8?B?eVhibjBpWUFEeHFwQ1A3am5teGRTcnF2M0xGMkswb1NuN0x6QkU3VE8ySnVD?=
 =?utf-8?B?aHhXU1dQTHdkMVJFQzR5b2xzdGVkU0k2clBhcU54RlZLTXM3a0U0RXlWTWJ0?=
 =?utf-8?B?aVdwNm9YQ09Wdkk5QndSbnpzOVMzOE1vVXVTbGtFRnZQR0FwWGx2b2ErcHQz?=
 =?utf-8?B?NmJpL09LbzBGN3lKV3BldlVvTkp5dzU0a3hoMS9WTWpzNC9MQ25Bc0NoS0wz?=
 =?utf-8?B?MEZLRDlBanFOWkluMndJcGJoUFlCZVZ5MFR4OEpFeCtYV2czV2pEQzE2Y0pJ?=
 =?utf-8?B?Q0dXNkpwRHZEeDhoR0s4QWxJcTFqS2RVT2I0bVhNc1A0dFFTTmt2TmJUTi9v?=
 =?utf-8?B?REFxMVJscEpoQUlxdVNXT1JoSTVubllhODlRMmFKWUVDTGRidDZHRzRYblF6?=
 =?utf-8?B?NDBCWk5tRkl3QzV5SW9KeHNyemRGTFBva0QrQ3EvYUxkaEl0SENDVDFtenZB?=
 =?utf-8?B?azRWVWJtNEloUzhSS2VFeXYrRVVlU0p4ekVxTVNWZ2V2UDZnaFRzM2g4ZkV6?=
 =?utf-8?B?enpZUXJ1aXR0azV0MHl3MmxVZHd4NlY2Wi9XR1RlVmZsNXZmNEdFTWEyUmhn?=
 =?utf-8?B?VkVZZ3FRNHU1WTVNMUhlQVZCc29CNWFXcVl1L2ErNjJpOHlUaHRBRmJ5WCsz?=
 =?utf-8?B?ZnFCT0JwNzVYTXcxdEFacEdZSFZySG83b3RwZ2RKWHRhOVY4cnp1Vm16ZUJr?=
 =?utf-8?B?UFFjam1EM05YR25WakJHdzF3ZHRQMjROQWlQbjRCam9vTnloRk1rMXE2ZGFn?=
 =?utf-8?B?Z2hKaXRtVnErUVRvdWthdkozaStyTGZSalBDOTEvZkZROGtkdEorYUQ5Qkhi?=
 =?utf-8?B?Mnc2Tm5pY2s3aHo3MzlraWFKaG1VcWlUd0M2M21zS2ZjaUg3U1NkdTgvczQ4?=
 =?utf-8?B?cXZIREZyTVU4eXdzWUFBR29CaFdYYlo2bFlMR09UZHJMbDBRUDcxVGttTXFh?=
 =?utf-8?B?VkpMbitHSzlVRGV6Z2xtUlBHeVBHaHBBUEN0U1ZZVDBkS25ZRHpGU0hETWhY?=
 =?utf-8?B?Z1dkRm9jZGY4YWlhcjI4SWZSb3J4WjlqZDZ5K1hmKzJzakxrQnR0dmxiL2dZ?=
 =?utf-8?B?bkFxYWZYajdtb3hRWDQ1RDRBbGJVc1FyazEzS3BVbEZFNlBMWHo5aEZWWm8y?=
 =?utf-8?B?NkQ4Y3lTdzAxb2EvRlFnM1lLU1J4eVZjMlpCelBRbjMrMGxuZUU4eDVZbmsw?=
 =?utf-8?B?NDk5bDZ1RUpuajlMd3JHYjJPdWhMQ01nZDZSaDQ2RENrY0FWV29yUWgwRzFJ?=
 =?utf-8?B?ejYzYTVKWjRVdHc2WWM2QmFrUmJuYjFRL0tlKzZ6aDBTK3puQ251b29UQTBL?=
 =?utf-8?B?QVIrTVZxYWhWTVVNalg2QXNQeUpxblJSTVk2T1NidFdQWStwMGlBaWhKNVJQ?=
 =?utf-8?B?YjlWbGs2eHA0b1M5VFIxdGtWcWdzSmVCaWpXNTI0N0s1TXUrS0VQMyt5bXFt?=
 =?utf-8?B?R0NCSldKSWpIc04vTDBJN3FPUHcwT01Xald6SDB6d0U2dEQrZ0NiV1M3bVpD?=
 =?utf-8?B?TE9yREU0ZEVGSW9STkV0UlJOelM5R081NDBRMlM1elJPejFIUkNweGp2dTcx?=
 =?utf-8?B?Wk1MaUlzeFoyU3A4YjRmMzJHSCtNQTlnbkhyaXQwRWZteG5zcUFjcndmL0cx?=
 =?utf-8?B?OTdpZVArcHhidnUxUndNaE5xbkNUMXFQRDlFelVOb1RpUzNrMCt6SzhiODdU?=
 =?utf-8?B?c0Z5N3gwMUcvSzNiL1hISGRvZFo3UCtlYWgxRVk3ZW0zWG9EWWNwQU82ZnVP?=
 =?utf-8?B?akJoZG95MlRQNmxqTWlhVFlpQTNMc29rcjlRMlUxSW1lWm16dSs1SnFobXJR?=
 =?utf-8?B?Zzd2NEdXVmpMS2xtNC9iZjNNeHlxZG9NcWZ0OVk4OVdnZlFxc3hEcllkVzd6?=
 =?utf-8?B?KzhpRzUxbEJXZDQvTGlVaU1QQmJlZStNNzJGcjkvYU9hTmlvZE1LWDhMMG9M?=
 =?utf-8?B?V0o2alRhc2xobWNrTUdCVHYxci8wT3VkcFB2WldQb3NYZ3dnK0dLZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a7bc74cc-a8c6-4597-8533-08ded21708bb
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 17:35:50.7536 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s0vBXQyAeXaCrpoOtd4QBSwFV8hEawqMM3pyHTZ3I9o5XkrkWVk8SxT7QflhOlYqUvYtnX1BL5RA9U+7H9jsQcw6ejbFw4i2ebXXRF/rvj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11422
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

On 5/22/26 7:03 PM, Tom Rini wrote:
> On Wed, May 20, 2026 at 02:12:12PM -0600, Simon Glass wrote:
> 
>> U-Boot has had a getopt() implementation for over five years but it is
>> not used much; most commands hand-roll their own argv loops to spot
>> -x style flags. The env export and env import sub-commands have the
>> gnarliest of these parsers in nvedit.c
>>
>> Each one walks every -prefixed argv element by hand, opens an inner
>> loop to split grouped flags and tracks a counter to catch a repeated
>> format flag.
>>
>> This short series converts both sub-commands to getopt(). The mutex
>> check for the format flags is done after the option loop, since it is
>> a per-command rule rather than an option-parsing rule, and the trailing
>> positional list is read straight out of argv from gs.index onwards.
>>
>> There is no functional change. getopt() stops at the first non-option,
>> just as the hand-rolled loops did, so options still have to appear
>> before the positional arguments.
>>
>> Each command gains a 'select GETOPT' so the parser is linked in on
>> boards that do not already enable it.
>>
>> For firefly-rk3399:
>>
>>    03: cmd: nvedit: Use getopt() in env export
>>       aarch64: (for 1/1 boards) all -45.0 rodata +27.0 text -72.0
>>    04: cmd: nvedit: Use getopt() in env import
>>       aarch64: (for 1/1 boards) all -27.0 rodata -55.0 text +28.0
>>
>>
>> Simon Glass (2):
>>    cmd: nvedit: Use getopt() in env export
>>    cmd: nvedit: Use getopt() in env import
>>
>>   cmd/Kconfig  |   2 +
>>   cmd/nvedit.c | 186 +++++++++++++++++++++++----------------------------
>>   env/common.c |   2 +-
>>   3 files changed, 85 insertions(+), 105 deletions(-)
> 
> For the record, here's a link to v2:
> https://lore.kernel.org/u-boot/20260519233207.2765755-1-sjg@chromium.org/
> And here's the full size change for firefly-rk3399:
> Summary of 3 commits for 1 boards (1 thread, 12 jobs per thread)
> 01: arm: Fix typo in linker script
>     aarch64:  w+   firefly-rk3399
> +(firefly-rk3399) Image 'simple-bin' is missing external blobs and is non-functional: atf-bl31
> +(firefly-rk3399)
> +(firefly-rk3399) /binman/simple-bin/fit/images/@atf-SEQ/atf-bl31 (atf-bl31):
> +(firefly-rk3399)    See the documentation for your board. You may need to build ARM Trusted
> +(firefly-rk3399)    Firmware and build with BL31=/path/to/bl31.bin
> +(firefly-rk3399) Image 'simple-bin' is missing optional external blobs but is still functional: tee-os
> +(firefly-rk3399) /binman/simple-bin/fit/images/@tee-SEQ/tee-os (tee-os):
> +(firefly-rk3399)    See the documentation for your board. You may need to build Open Portable
> +(firefly-rk3399)    Trusted Execution Environment (OP-TEE) and build with TEE=/path/to/tee.bin
> +(firefly-rk3399) Some images are invalid
> 02: cmd: nvedit: Use getopt() in env export
>     aarch64: (for 1/1 boards) all +883.0 rodata +199.0 text +684.0
>              firefly-rk3399 : all +883 rodata +199 text +684
>                 u-boot: add: 5/0, grow: 0/-2 bytes: 1184/-500 (684)
>                   function                                   old     new   delta
>                   __getopt                                     -     520    +520
>                   static.bdinfo_print_all                      -     324    +324
>                   print_eth                                    -     236    +236
>                   print_bi_dram                                -      92     +92
>                   getopt_init_state                            -      12     +12
>                   do_env_export                              548     476     -72
>                   do_bdinfo                                  588     160    -428
> 03: cmd: nvedit: Use getopt() in env import
>     aarch64: (for 1/1 boards) all -27.0 rodata -55.0 text +28.0
>              firefly-rk3399 : all -27 rodata -55 text +28
>                 u-boot: add: 0/0, grow: 1/0 bytes: 28/0 (28)
>                   function                                   old     new   delta
>                   do_env_import                              668     696     +28
> 
> And so this is why I'm just deferring this until someone has the time to
> pick up and address the underlying problems with this potential
> migration that have been raised in the previous iterations.
> 

Chiming in because I was put in Cc...

Do I understand correctly that this only impacts U-Boot proper? If so, 
is a size increase in proper that much of a blocker? As opposed to xPL 
which usually resides in SRAM, I'm assuming U-Boot proper would run in 
RAM where I hope an additional ~700B shouldn't be too much to ask for? 
The issue however could be on the storage medium where U-Boot proper is 
located, maybe this gets the binary above the max space allowed for 
U-Boot proper to be stored (e.g. on some of my boards I'm (self-imposed) 
limited to 2000KiB) though I'm assuming it could be less than 700B if 
U-Boot proper is compressed for example. But I'm also lucky enough to 
have storage space and (D)RAM to spare on my boards.

Out of the RFC, I see the strlower() part as being separate from the 
rest, maybe that's something we could revisit separately? Reading the 
cover letter, we should even spare 60B with that alone, with the added 
benefit of easier maintainability?

Cheers,
Quentin
