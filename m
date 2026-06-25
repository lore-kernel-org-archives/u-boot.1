Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB6C8CDB466
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 08:29:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 386648407E;
	Thu, 25 Jun 2026 10:29:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="JQmn8aVh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC02184704; Thu, 25 Jun 2026 10:29:55 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 858B380398
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 10:29:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SeGbRwnqg2447Q1S2l66bsKvr1cwulTT/O3WHXQ/DYZsJXI4c66VDeISEM81YmoypI6HeJfFCHiPAYxP5m5816XaIDTQnZ4O4iWYZAA4xmQU+qWbFE7/zwBC70mg8XuHu9QFDGqKl/19ILtGX826YDKY59AKhiVrz47NwvVbVHdB45dwNtt3598grr66f8ZkKlRURgCzz/zrsZk/nGcoi99ngWjMAn4e8LqjbsAHzGVCeWCaKZe+r/msbqZVpbAFQtKnIt9dd+TI76MzhdLjHEhCOBg79UeCbRTz0nKHMyBVRHGpHS9P1kTcDgvHu4/8/9PDnkZPor093lTG3WfJAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khxk5YNAak9jFZSYmoEA3B4m8PGvBUTYbjlQ7mDmY0U=;
 b=lfp3fg1mxhg9o45/7DxHf4ygqtPUtD8BPOfn3f61CSn0MGnV89fU+cl1V+YCjp0o/3E/Bi7Ky21yMehZN2Mn4koWRrrXn2o4zUGGLw/ApjtZJtD9lsVSv63w8Rw3sTq+4IrSwDW9zqJHZdLy/Ef44b5oBY442KoSLg7xdFSFNXv0tDn7JDH8usOittn/sPOYYNfD4oO8oJVUNABJFwDsAlLPB2cwAKhOGn0csXsLAkP3QsI5SG4Y0Wfspw+yFE+fHPg7sXveZZgK38+mlWCN6XIyWv+PCdopasWFRca8JAOetw+IKgnVUxIBauqYMfRzRYR3Lq5/c3nBt+kIzVEfiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khxk5YNAak9jFZSYmoEA3B4m8PGvBUTYbjlQ7mDmY0U=;
 b=JQmn8aVhs4DuQJK2VEVOFLWcyCTszBouLattbwzScX9pz6Xn6fK0kWkMU0YJ897iWvEmDDmHFv2YyPdCrWSd47K+z654nBgZU76ra1CTjVrQlufQCwxoVU1fCVjbz26LA1t1tvwAb3z5ncJ5ANG61kQ8iEOwQOBS3nGmn45hlTQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by GVXPR04MB9996.eurprd04.prod.outlook.com (2603:10a6:150:117::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 08:29:46 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 08:29:46 +0000
Message-ID: <a3bb6dfa-b4c2-46cf-88a1-8198e9c54523@cherry.de>
Date: Thu, 25 Jun 2026 10:29:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Convert env export and import to use getopt()
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Sean Anderson <seanga2@gmail.com>,
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
 <e56cb70e-1a66-4ebf-8014-7fd6be9c69ef@cherry.de>
 <20260624181925.GP382693@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260624181925.GP382693@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P194CA0034.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::23) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|GVXPR04MB9996:EE_
X-MS-Office365-Filtering-Correlation-Id: a9c917bf-a9ab-4f83-a35c-08ded293e9d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|23010399003|3023799007|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Gi3+clnCAiFLtu5F8ewDgjZ0q9K1XOqwjam891GYqadvg65iirH8PX/oDbIIKXN+Unrs0ov4UKjMocDGkMfFS6Dr68stiMeXdlBtoE/5CzvTauwzx/f/Z63lNb0YvXISsBm0CoX0cRgGdwo77s5fLuEwxI8Pfb1tDuA6Wq3DGvt1R/frMesD2TWsbpBNfz1+46cpcPZPHRuk6zl2yd40VTsJRIpjwLUQy2pViWs6wm5ZrwzqqyryzwLyapC4iJAAwU0AiMhSszKNSN7YTT6D39oTsUgwucO52LKjomRO43cNrfbzuAXy9Bsd13cz0Bd8hlqlvaXR7eM4hGyeY3d6A2CSb+KNzadKQ6UpcsaU0sWYOCQ5p7JTvZuBKewEhzvO0rJa7id7LY0qIhP4eIE6VvnicWWnzClsTrwE1BZYoP7Qfo4rL47lCpbrnCEvAQA6FlWcuCZA4dB6N3vKa39miq27rI2fTInmZEnyf0y2H/8nvzKoSLUDoE/0q+mMhxZLwN6ELtgZ42cNwi7PWaK3miy25seskOdXtz9SIrTX0X9AbYm/RdZgMZNCPAhSjhgVACSFoX3n7C372gFuvijF+cZQq82a/zXdgQRZUxhaK0ObXpdZaUxAP8rg7ZB/ATLgapKv7mfZGqNysELk2yv5P4wwOQ4KCDm0REF/KMtCVv0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(3023799007)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFdqdFRUT0V0RTFxa0JwbkFMYTYwNmtuWlRBdlVRYWljNzI1ajFtdEp5aGNr?=
 =?utf-8?B?Yk90TjZ1WUtyNU5zSUd0Qk44b1dtK1BERXR5NVpVenNDTVVWREVjc3huOUh3?=
 =?utf-8?B?eG9MUXE1OUhCTFE5MGdjMlV2NzBnZkNvTUQrZ2trRWM2T1N4OFR1Tm5xYUtS?=
 =?utf-8?B?dFExT0x3VVc4Q09rSzUxOWY5QTRoWVRqK1FsVStIV1krZXhXNEE4T29vOXdz?=
 =?utf-8?B?dkpEdEFaeWx1dEl3WjBWZFh6T3BidWxET1AvUzZ3cXNjS3F5Y3RMNWtqZk1o?=
 =?utf-8?B?NXBGZHlQcjd3cnpFQWd1N3g4b1BHaW1QQTBpeWRYZU50K1kzb1lhWGkwZisw?=
 =?utf-8?B?S2szTDFyRm82ZTRiMlpQSnhsbGFxZWFxWHR2R21icnkwd0xKVkQ4ZFdqcTFq?=
 =?utf-8?B?Q3dmQmRvNlV6c2ZTVlcyNUg2UE9neFJsQTB2ZU9JeVRzYnFCWjB0R1NZT2pt?=
 =?utf-8?B?MHF2RncxTzhsSVhZSzI4ZnZ5SW5BdDZqV2ZhcCtoUHdXT0VNYktaNy9iMFRE?=
 =?utf-8?B?Z1VlOERRWVZvWjFUVCtMd1NWUTFOVWVieE9ER1VmWHNibXVWWnhKWlBPbFRr?=
 =?utf-8?B?Q3dDYkt2WEk0c0l0b253MEVhUmV0QzdPYjN6MlI5Qm5yYmdTRkxHNGxUK3pD?=
 =?utf-8?B?VXhrVkg1dithZzhxMGkyK0NteWhOd0VRelk4RkpsTXk5SUg3RWZONHY3bENm?=
 =?utf-8?B?eWJ6REF1ZWgyRnRhd1lWbG1sOU9hc0Z6TFJucXJFVm0vN1VJUUMrSkJ5N3NQ?=
 =?utf-8?B?ZU56S3hTNC8ya2FjOEJEU2xqS3hzQ1RpUG43R1dGOWRRMWJUMHd3UlBheE9y?=
 =?utf-8?B?WmIrcVdsNmZlREExVEdaUHM0NWd5aU83dVpWd0w4K1VqbVFQcjVvWml6NE9D?=
 =?utf-8?B?T3FnWHBkWHcwZUZUSlpVQXFSaTlQRHJMN1VpYkc3MURGeUJ4NVhscFlZRjBB?=
 =?utf-8?B?aDg2b05SaUkzd0ppTy95Mm8wRkpGZkIvQzY5YTNuekVSNkdDQmhBMEdRdHpn?=
 =?utf-8?B?WUZ2UlNZeVZvb0M1eFFxN2lhZytqM1cxOVk1WERSbFY1NytOcW0vWEQ1Q0tV?=
 =?utf-8?B?NUpleVFVUXF1aTVEM1M0SjJkcW9pVWVnYmNscEdjcDVEeFk2dTg3dUg4SlRU?=
 =?utf-8?B?bkwxck1KQWZBbnZVUGZ4bnI3K2tzZENJME9UdGMxdEdsaXJOUFhYTExYbnRm?=
 =?utf-8?B?K2NMVUk0SzlrVHEwRzVQYXFwenRicngzYVI5U3ZDb0cxcVZXdE91U3U4VGlu?=
 =?utf-8?B?RUdhdWMvS0ZaVFh1aUxqTEVld1N4UUtOaGxQYnZCVzNTUW1WL1Vnd3ZFV2dV?=
 =?utf-8?B?QjZwZDcxYzZ5UjNTdmcrK0RqY1NjZVR5dHhRWWpSWkhZc2Y2Yit0enRSV3pD?=
 =?utf-8?B?UFRYckNNK1NuV3ZjYno5cmZWYzVkYmZWckROT0NwVVdpYkN3SnVQaVRGTWJV?=
 =?utf-8?B?TU45dG5xTjJCc2hyWENiWHhtZm1MTWZqR2JiM1RpL2p2WkZOMzNZc2QvMlYv?=
 =?utf-8?B?SG9sbHY1WjVnVUJ2bVdwd21jc3NiOVNKRldSQXllZmVvVjhSV3BHdFZpOGxH?=
 =?utf-8?B?QjRyQUdma1BOVmI1M3RJUm5YcnMxcVFtVGtkbVJsVWg2SGVDMmduangwdnBk?=
 =?utf-8?B?Q3RxT21WU2FGdnNYTVV1a0x1VDlaMFRJN05zZzJnc0I2R1ZWU2MrQmFmUjdZ?=
 =?utf-8?B?YkFUSnNIWVVodlVzb2VNMWV6bDJrTjNIUWw5cVFUVnI0ejdENnNIVFlTMWMv?=
 =?utf-8?B?TDhXOXRuNnNMSytkM2FxOFVHMWp2dzhGS3JaZEJLamlRK0FCUml3QW5GbWlB?=
 =?utf-8?B?MG5qZHYwajdjT0VHYmNPUUFtc1laRzlPRUFXZGNidnpBdWRER1Vic1RQa3Jp?=
 =?utf-8?B?KzN4ZE1Zb3VhMzhuS0tlc1VkaS90eWdXcVlGL0lmRE96ZlMxRjRyMVdQNDM5?=
 =?utf-8?B?aTBVUzJjMkxBTldRTDFoVTJjeWEwNlM2R0twYjBGeTdueUtRd1VMcm0rZEdY?=
 =?utf-8?B?SGhlVElSNnZGelR4N012Rys0N2hnM2hSanU1V2RSR1RlYlNZM293NFNYQ3Fv?=
 =?utf-8?B?VXJSMHhCOHNLUFhJaE5HdmZPZktxdXJxTXZDWWtGR28xSTZtejJWT1h3UmEv?=
 =?utf-8?B?TkxEdEJLT1l1Z2Q4K0dJM3hYbC9lTGhXUVR0SXRSc1pOOEVIQmFTSmFrNUVB?=
 =?utf-8?B?Zjg1cGkxYUVlenZZQ3pGazFLS0I2OXR0dk5IUWtvTXgvN0hPaUZieTZOcEI1?=
 =?utf-8?B?enNYYlRsdUZuNTVrQWhrU2VBR3J6OHhWam90SlMzSWp2aFdVTGFZQTUweGdS?=
 =?utf-8?B?aTBGRE85NkFFaFN2YS94dkx0L0JhLytDNUpYZm45djB1N0c0TGd0Zz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c917bf-a9ab-4f83-a35c-08ded293e9d4
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:29:46.0801 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QOUayYTqieht30eD6XJWecCk2Ds7ztSwDbWpfgiOOJzEYawMFvK07KUhhH1uX4Lp6x+JRiMnIupWm8M63tM835ez2brppYlHhn57NEhUDMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9996
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

On 6/24/26 8:19 PM, Tom Rini wrote:
> On Wed, Jun 24, 2026 at 07:35:49PM +0200, Quentin Schulz wrote:
>> On 5/22/26 7:03 PM, Tom Rini wrote:
>>> On Wed, May 20, 2026 at 02:12:12PM -0600, Simon Glass wrote:
>>>
>>>> U-Boot has had a getopt() implementation for over five years but it is
>>>> not used much; most commands hand-roll their own argv loops to spot
>>>> -x style flags. The env export and env import sub-commands have the
>>>> gnarliest of these parsers in nvedit.c
>>>>
>>>> Each one walks every -prefixed argv element by hand, opens an inner
>>>> loop to split grouped flags and tracks a counter to catch a repeated
>>>> format flag.
>>>>
>>>> This short series converts both sub-commands to getopt(). The mutex
>>>> check for the format flags is done after the option loop, since it is
>>>> a per-command rule rather than an option-parsing rule, and the trailing
>>>> positional list is read straight out of argv from gs.index onwards.
>>>>
>>>> There is no functional change. getopt() stops at the first non-option,
>>>> just as the hand-rolled loops did, so options still have to appear
>>>> before the positional arguments.
>>>>
>>>> Each command gains a 'select GETOPT' so the parser is linked in on
>>>> boards that do not already enable it.
>>>>
>>>> For firefly-rk3399:
>>>>
>>>>     03: cmd: nvedit: Use getopt() in env export
>>>>        aarch64: (for 1/1 boards) all -45.0 rodata +27.0 text -72.0
>>>>     04: cmd: nvedit: Use getopt() in env import
>>>>        aarch64: (for 1/1 boards) all -27.0 rodata -55.0 text +28.0
>>>>
>>>>
>>>> Simon Glass (2):
>>>>     cmd: nvedit: Use getopt() in env export
>>>>     cmd: nvedit: Use getopt() in env import
>>>>
>>>>    cmd/Kconfig  |   2 +
>>>>    cmd/nvedit.c | 186 +++++++++++++++++++++++----------------------------
>>>>    env/common.c |   2 +-
>>>>    3 files changed, 85 insertions(+), 105 deletions(-)
>>>
>>> For the record, here's a link to v2:
>>> https://lore.kernel.org/u-boot/20260519233207.2765755-1-sjg@chromium.org/
>>> And here's the full size change for firefly-rk3399:
>>> Summary of 3 commits for 1 boards (1 thread, 12 jobs per thread)
>>> 01: arm: Fix typo in linker script
>>>      aarch64:  w+   firefly-rk3399
>>> +(firefly-rk3399) Image 'simple-bin' is missing external blobs and is non-functional: atf-bl31
>>> +(firefly-rk3399)
>>> +(firefly-rk3399) /binman/simple-bin/fit/images/@atf-SEQ/atf-bl31 (atf-bl31):
>>> +(firefly-rk3399)    See the documentation for your board. You may need to build ARM Trusted
>>> +(firefly-rk3399)    Firmware and build with BL31=/path/to/bl31.bin
>>> +(firefly-rk3399) Image 'simple-bin' is missing optional external blobs but is still functional: tee-os
>>> +(firefly-rk3399) /binman/simple-bin/fit/images/@tee-SEQ/tee-os (tee-os):
>>> +(firefly-rk3399)    See the documentation for your board. You may need to build Open Portable
>>> +(firefly-rk3399)    Trusted Execution Environment (OP-TEE) and build with TEE=/path/to/tee.bin
>>> +(firefly-rk3399) Some images are invalid
>>> 02: cmd: nvedit: Use getopt() in env export
>>>      aarch64: (for 1/1 boards) all +883.0 rodata +199.0 text +684.0
>>>               firefly-rk3399 : all +883 rodata +199 text +684
>>>                  u-boot: add: 5/0, grow: 0/-2 bytes: 1184/-500 (684)
>>>                    function                                   old     new   delta
>>>                    __getopt                                     -     520    +520
>>>                    static.bdinfo_print_all                      -     324    +324
>>>                    print_eth                                    -     236    +236
>>>                    print_bi_dram                                -      92     +92
>>>                    getopt_init_state                            -      12     +12
>>>                    do_env_export                              548     476     -72
>>>                    do_bdinfo                                  588     160    -428
>>> 03: cmd: nvedit: Use getopt() in env import
>>>      aarch64: (for 1/1 boards) all -27.0 rodata -55.0 text +28.0
>>>               firefly-rk3399 : all -27 rodata -55 text +28
>>>                  u-boot: add: 0/0, grow: 1/0 bytes: 28/0 (28)
>>>                    function                                   old     new   delta
>>>                    do_env_import                              668     696     +28
>>>
>>> And so this is why I'm just deferring this until someone has the time to
>>> pick up and address the underlying problems with this potential
>>> migration that have been raised in the previous iterations.
>>>
>>
>> Chiming in because I was put in Cc...
>>
>> Do I understand correctly that this only impacts U-Boot proper? If so, is a
>> size increase in proper that much of a blocker? As opposed to xPL which
>> usually resides in SRAM, I'm assuming U-Boot proper would run in RAM where I
>> hope an additional ~700B shouldn't be too much to ask for? The issue however
>> could be on the storage medium where U-Boot proper is located, maybe this
>> gets the binary above the max space allowed for U-Boot proper to be stored
>> (e.g. on some of my boards I'm (self-imposed) limited to 2000KiB) though I'm
>> assuming it could be less than 700B if U-Boot proper is compressed for
>> example. But I'm also lucky enough to have storage space and (D)RAM to spare
>> on my boards.
>>
>> Out of the RFC, I see the strlower() part as being separate from the rest,
>> maybe that's something we could revisit separately? Reading the cover
>> letter, we should even spare 60B with that alone, with the added benefit of
>> easier maintainability?
> 
> This was just impacting U-Boot proper. However, it showed I think two
> sets of problems. The first of which is that there was an expectation
> that switching the code should result in some sort of savings,
> somewhere. And it didn't. And we do have boards where the space between
> the end of U-Boot and the start of the environment is small and so
> global changes that aren't just bug fixes need careful consideration
> (and they've already turned off things that aren't needed for them such
> as EFI loader). The second thing was that the code wasn't really easier
> to read / follow. So I don't object to the concept but I think the
> outcome of this series was that our getopt needs to be looked at in a
> bit more detail, and figure out if it's really designed the way we need
> it.
> 

Understood, thanks for the additional info.

Cheers,
Quentin
