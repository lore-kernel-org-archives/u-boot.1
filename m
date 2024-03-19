Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA8AC54E5D
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 10:19:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27B1087DE8;
	Tue, 19 Mar 2024 11:19:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="iBScD9l+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9696687E47; Tue, 19 Mar 2024 11:19:10 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5D8787D45
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 11:19:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdouW7T6u7dtj1LKVnO6wV4TXCLR8LIfSNLBJVObTgGcVNWg0CxOqkE68vruUgH7jTkaOg8eUMIVWvbsRUgpc3gCX42u10xFBYGg8wXowG6U/Lb1YRHGGl6IBqxV5rylzw1+uFNF5wc6KywSR1icXfh2czctekWTtVAbwfh4tIYi3puu72SjGo6Y1xUJTJFZa7t1LmUzFoShNOEJdo9K5P/BkiixEZ6E3aakGes5rbbfzpzH9LVGaWaBwgN/oRTNwijHhjg6ejrBMs0dOmOXkWbkWhLoTOgsqfWYZY3iG3UW+/gwlGznM1WLrMqblWm6yt/L9aBiSMBe7y/tL7Tffg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TnYuqRBgCvwZpRRNVzp0KZ7tJVBFMkHNJru/CXDhzQ=;
 b=V9oiNI0o7TuRLfui4utH7LuzNXFhQV+IzuUjms4sqfP7JkE7bEOI2LIe5Yt5yp2b9UyRGPeVdNDHKBvrP9GKwSC74+RQ2gsCqQ8g0vUY2gjhKlwmpzzoieB5o9iIKxTBLPZvqHKPmZ64G0j05su45qQaO/5pQ+jVTJG3gNW0Nyy1tkqPNwtiNAomz+mqZHtNkUr7cnDOraDWi/k3vY33J/nMe+nhglpZzFP3HwGSXVF+Q7jXmj/+bMtm2UmOMPQQjUabDjTjXcU5yNbcKw2ctpZ/FpqmRQw+rjzG1A1wW6J2GrFwQaudluhMCwLqn7ZgcoOulj5MQuElwZrnFZlTSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TnYuqRBgCvwZpRRNVzp0KZ7tJVBFMkHNJru/CXDhzQ=;
 b=iBScD9l+X//xx2mBcWNDI2jDZ+nnIiDyZEz/a3ClrQ7AgNvW5iBpA+AKzpIZZDKc9t3fcAlnXXfhD9TIIsM3Yc3mVV+Pbt5OqTu5ce5XSO7+/5ppxoRIqzPvcEKdmeGY5kuXfDR2EYgkuiwM054uB5nxWrQEQzBzbcbdGUuHlja9HTZb7KYjyCN7BpBfLk8hiQGXEXeGIGrExEejr7hwYfsOsrPNNeFqEoLtfbfR16IkQNzilREtfbs9QVpBtO4GSwE/HSjz5htuwD4VcAkDbxhmQZj2sutgZPlDG3oyZ1UbxUD0NAgzyGw6qum6N5VbiVihxb4ZkTJ/pLSOEm1ayg==
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AM8PR04MB7265.eurprd04.prod.outlook.com (2603:10a6:20b:1d8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.22; Tue, 19 Mar
 2024 10:19:04 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::23:4118:ae4a:8dda]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::23:4118:ae4a:8dda%5]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 10:19:04 +0000
Message-ID: <9cde709e-a49b-40df-91d3-6f690313cf31@theobroma-systems.com>
Date: Tue, 19 Mar 2024 11:19:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: spl: Cache boot source id for later use
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: Christopher Obbard <chris.obbard@collabora.com>, u-boot@lists.denx.de
References: <20240315173454.2672509-1-jonas@kwiboo.se>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240315173454.2672509-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0401.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::7) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AM8PR04MB7265:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NIVCLpLG1AeTzlm3OGYBnFmOo5hu7bztX+MLyrYu4ZSl2QqE6zs1k9GMhxp2KeX5sRL7wqWQuoLKQRH7UVEnd7Vw/DZGP9Ntun3NBkVfDrHS9EgLQ6l/2k8SFw21DACmWmsJVCKjqn6m8BGEgFYTPT15GiGLsczL48+3/M/Grm0HXpjq4O24lYZBlS60FblqFzfws+JRL4miL1MttYHYf04toxPU0zo5d05vcr2sFZ8vSzbWWSf25mnYCZkgKo2Z4/0vayxBc8EIqxKsm2Uy+c+UmWA5hSAlsP/LG37M3UUNV7V6lOotd1n15Kkxxo2d1PcVVHj555wZP6PnS3EiVYbxsKML9KRFBZUFgntxiiYg2kM5FPN0BrUPUYZEs7vXyN2JStflS49czkty+vwHS1uTcIZEW+eRlfD43kX2Hw314odv/balt8iXc3Rf1yy3XjuqVtzgeDttXlDp78YsGr5F/yYX0sSnQibf5zEBw4uK0V8FlXYlnvlHNx9zn6rgfycHB6X2JME341K5KKCmivbSt7vH8ZjAqmvn7Iyj/Bxglq1MX+n1rzA7MeRYjoeYXHVFTvQIe0z4fSLmHjZRG1q8bK8iDqKou3p9VSLOrQ1FksPWx7oOPDD/Oe7K9GwW54xK0fHDyu/5PtucUqfLnX6d/9a8zeWn1UFQOu+GWAc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWxQc0M0cmQxSE1EU3RKUWwxcVoyWmFxZzRwb25XV21DZVFkeVBLdUhtTTkz?=
 =?utf-8?B?eUkvcWt3QUpIa3BWNDA3QzFXbS9xNFhTSGFwSUp6WEhhSDUrWUxKY0JaYmJk?=
 =?utf-8?B?WGZCQkE5MFVEcnRqM2dlYzZxb3RDclQrQ0pIR2FaUXovL04zQll4a3JISnBt?=
 =?utf-8?B?UWVvWmJhQ0g2dDlOTmVROXZvM2xRRmdKNUQwc1ZsQXNPcXNZa1dXdUhFcENC?=
 =?utf-8?B?MFF1dGZENnRHQmRGOHkvM05peWNvWVpZWTE4QTlteXNRcTFDenpvcHF6b2w4?=
 =?utf-8?B?cXNCQkxGZU1ZOWtYMzNJSTlaUjJoZ0xwR1RRMUE1YklDVDQyVjNTT3pZeW9w?=
 =?utf-8?B?ZFc0UVJ4RWJQWnVrYzh2djF0MTlVYmdpZE9ZY3lsb2UrQmxsSm4zL2NKMGJK?=
 =?utf-8?B?b2t1Sm90NjdmdjJaeThPYm5qRW0xMGM0dXV2ZlBvUE56akcvS01hM0VQMzFV?=
 =?utf-8?B?WVhaU1A1Q2NXOHVWOVd4RDZ2OUYyaDZ1ZGtsMmNWMFRFRUtZV3Bndk9mclpG?=
 =?utf-8?B?MEdjazZYRTk2bEpNWlRjbFpwS2w1Si9RNktmb01RbHZPODhrMTFtWVFpSU9I?=
 =?utf-8?B?OTZoMkd1M0JEZUVqY0NpT3IxcFd2SFdiYmVCZlRzOEdHL0JWSDJ4c0FRcE8v?=
 =?utf-8?B?ZVlSOUxUYWN0TW5iKzNQVGlOTnZSUGJMVVgrZCtpQUViMGVuRHRtbVIvd3Rq?=
 =?utf-8?B?SEp1UmtKTnhmcGZnNlh3a09FTE1tellYRXdRZi9wSEwyYU1BN0xTbG9UT2tu?=
 =?utf-8?B?YWxBdkgwZmFHRVB1M3dFTTEzeGVleXNzQUV6dUtWQlQvdVFmQjFKaThOelND?=
 =?utf-8?B?b1BhSjJYMTlwWEZ6UkF5OUp6REZsb0xRS01hcWptSDcya1JMOGZweUlSTFhI?=
 =?utf-8?B?T2dUc0tPbkU2cFlBZ2l0YzVJeGJ2U21ZNWkzTURucSs1OVVEUWowQXo5VVVP?=
 =?utf-8?B?Z0czM05XUlRpWGE4TEFzVzl1MUM0RVJ5ZE45RHphTzQ1bUg5MllIaEVUdEwz?=
 =?utf-8?B?RnFkN3daZEkvaTd1OTJ2YXVOR3ZxMGtVMTkxUE8yZ1RRdGdHNEtpV2doSWk1?=
 =?utf-8?B?QTdyTWhvdTFRVHlMTjY5aTF0WTZOcTdNVTloQmNrUnVEZmd2NHAzdzQzQitJ?=
 =?utf-8?B?ZUpRaUJmU2EydGJSRGdteVN1bVZuZUxXclBJWEdCY29HNlBESTlGQldLSHRZ?=
 =?utf-8?B?S0Nsd2RIM3NHd01SQ2pvQ0x0VXNiRW9NQjFGaVBWMVFjdUZBdmthZVZCMG5K?=
 =?utf-8?B?cFVWOHArQXh0L0I4ZFJXeGpBUmhzWEo3SmNoL0UxalhKNFV5VmFkRnptVHNI?=
 =?utf-8?B?bEhLdGphcUN6Vko3Z3JQSnFTcFRCbXpHOGVqY0xFTzRjVkNJRnNhSU1kRjRa?=
 =?utf-8?B?NE5tZUsyWDFrRnE5VWNaN3lFZExBL1REV3c2djd3UFpCYmVncURwZ0hQK3Yy?=
 =?utf-8?B?dWVpWklsZHkxV1lYZ1hkcExQU1pQendBSnBIZEQ3U1FydXJkNnJORjR6VTJy?=
 =?utf-8?B?bm9qRUw5TjIwZ1dXYlE5dzR2WlFsc25jdWtTOU1GUFJUZkJQQ1F6aC9ycE1p?=
 =?utf-8?B?dlJOdE9uNFo4UDEwSVBsYy9YeThxa1M3OTZuUE9LQ1UrYmtSQmhMTHU4Zys5?=
 =?utf-8?B?MkRmT1REb3YwM3g2MEE5WXVFK3cyQmVkVzVSdXQ5Zkw4WDFNSnI2am9DalBB?=
 =?utf-8?B?d3VjRU4zZS9QZUlmUncxd2liNmZxei9jbU9XMCtIbi9zdSszdnJ5Wmw3ZXV1?=
 =?utf-8?B?RFoxSmtiejlZSXdDZHJxM3Fza0VMQ3R6UElYd1lsMTNxejlUdkpUSjhVNjdp?=
 =?utf-8?B?V09kUW05aUFrN1JoOHhyT1JPSEtmTWR5MDdVbVQvbmtZbldQcUVnOVZqclFl?=
 =?utf-8?B?N1lOUU4xbmRkS3R4QkF3c0Y5VGtSdHJoRFEvcWo3amlZOXAxbDBPendKdys5?=
 =?utf-8?B?S1E5MVl3SytGQWtOYjY2UlkyOW5hd2NBb1RJVWwzV3NWRHI1NXNKR0FLRVh0?=
 =?utf-8?B?MjJZWWh4VFhRSG9UaVZ3U3duUmw2VWRKdEliY3Q3cVBHcUt6SXhBNm5ZZXZj?=
 =?utf-8?B?TWYyZ0pqOGdwRGZ6a2VEVHpPMURnTVUyYXQ1MThXNXFWaE50aXNvdHV6N1dO?=
 =?utf-8?B?Mm9jSHMyQ0RVZkFMclNYQUpRYWVZWmZkb1ZKcVNkSkk1cmNGN2lBbVJlK2VF?=
 =?utf-8?Q?uaXwpBSzBpaNlXJoh9EjFg4=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eee5230-c8b8-4906-6ad0-08dc47fe00bb
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 10:19:04.1323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5PPsdnWWnOElURc9QE1l2Ru9YmzMkUonkdvKSWipUirkl49neeyDcs4l9qcNnOw6ZNiIw5hh8NRJfgE9cYGuMAMZAGhxUlwu41TMtTtuUdSf5ASZKNdRsyDjFmOpuCrH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7265
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

On 3/15/24 18:34, Jonas Karlman wrote:
> Rockchip BROM write a boot source id at CFG_IRAM_BASE + 0x10, the id
> indicate from what storage media TPL/SPL was loaded from.
> 
> SPL use this value to determine what device "same-as-spl" represent when
> determining from where FIT should be loaded. This works as long as the
> boot_devices array contain a matching id <-> node path entry.
> 
> However, SPL typically load a small part of TF-A into SRAM and on RK3399
> this overwrites the CFG_IRAM_BASE + 0x10 addr used for boot source id.
> 
> Here boot source id is 3 before FIT images is loaded, and 0 after:
> 
>    U-Boot SPL 2024.04-rc4 (Mar 15 2024 - 17:26:19 +0000)
>    board_spl_was_booted_from: brom_bootdevice_id 3 maps to '/spi@ff1d0000/flash@0'
>    Trying to boot from SPI
>    ## Checking hash(es) for config config-1 ... OK
>    ## Checking hash(es) for Image atf-1 ... sha256+ OK
>    ## Checking hash(es) for Image u-boot ... sha256+ OK
>    ## Checking hash(es) for Image fdt-1 ... sha256+ OK
>    ## Checking hash(es) for Image atf-2 ... sha256+ OK
>    ## Checking hash(es) for Image atf-3 ... sha256+ OK
>    board_spl_was_booted_from: failed to resolve brom_bootdevice_id 0
>    spl_decode_boot_device: could not find udevice for /mmc@fe330000
>    spl_decode_boot_device: could not find udevice for /mmc@fe320000
>    spl_perform_fixups: could not map boot_device to ofpath: -19
> 
> Use a static bootdevice_brom_id to cache the boot source id after an
> initial read from SRAM to fix this, this allow spl_perform_fixups() to
> resolve correct boot source path for "same-as-spl" after SPL have loaded
> TF-A related FIT images into memory.
> 
> With this the spl-boot-device prop can correctly be resolved to the
> SPI flash node in the control FDT:
> 
>    => fdt addr ${fdtcontroladdr}
>    Working FDT set to f1ee6710
>    => fdt list /chosen
>    chosen {
>        u-boot,spl-boot-device = "/spi@ff1d0000/flash@0";
>        stdout-path = "serial2:1500000n8";
>        u-boot,spl-boot-order = "same-as-spl", "/mmc@fe330000", "/mmc@fe320000";
>    };
> 

I'm perplexed. We make use of this spl-boot-device DT property on Puma 
(RK3399) and Ringneck (PX30) and I am pretty sure I tested it does what 
it's supposed to do. So that is a bit surprising this seems to not work 
anymore. Is this related to the BSS/stack memory address location 
changes you made recently by any chance? Or did I manage to be very 
lucky for a very long time for our boards?

"""
U-Boot SPL 2024.04-rc4-00026-g6ec096a7116-dirty (Mar 19 2024 - 10:50:03 
+0100)
board_spl_was_booted_from: brom_bootdevice_id 5 maps to '/mmc@fe320000'
Trying to boot from MMC2
load_simple_fit: Skip load 'atf-5': image size is 0!
NOTICE:  BL31: v2.9(release):v2.9.0
NOTICE:  BL31: Built : 17:47:58, Jun 21 2023


U-Boot 2024.04-rc4-00026-g6ec096a7116-dirty (Mar 19 2024 - 10:50:03 +0100)
[...]
=> fdt addr ${fdtcontroladdr}
Working FDT set to f1f13d10
=> fdt list /chosen
chosen {
	u-boot,spl-boot-device = "/mmc@fe320000";
	stdout-path = "serial0:115200n8";
	u-boot,spl-boot-order = "same-as-spl", "/spi@ff1d0000/flash@0", 
"/mmc@fe330000", "/mmc@fe320000";
};
"""

for Puma when booting from SD card... I don't see 
board_spl_was_booted_from being called a second time after BL31 is loaded?

mmmmmmm

Very interestingly, when booting from SPI-NOR flash:

"""
U-Boot SPL 2024.04-rc4-00026-g6ec096a7116-dirty (Mar 19 2024 - 10:50:03 
+0100)
board_spl_was_booted_from: brom_bootdevice_id 3 maps to 
'/spi@ff1d0000/flash@0'
Trying to boot from SPI
load_simple_fit: Skip load 'atf-5': image size is 0!
board_spl_was_booted_from: failed to resolve brom_bootdevice_id 0
NOTICE:  BL31: v2.9(release):v2.9.0
NOTICE:  BL31: Built : 17:47:58, Jun 21 2023


U-Boot 2024.04-rc4-00026-g6ec096a7116-dirty (Mar 19 2024 - 10:50:03 +0100)
[...]
=> fdt addr ${fdtcontroladdr}
Working FDT set to f1f13d10
=> fdt list /chosen
chosen {
	u-boot,spl-boot-device = "/spi@ff1d0000/flash@0";
	stdout-path = "serial0:115200n8";
	u-boot,spl-boot-order = "same-as-spl", "/spi@ff1d0000/flash@0", 
"/mmc@fe330000", "/mmc@fe320000";
};
"""

but the DT is properly written...

Ahah! This is because of one of my commits where I added support for 
SPI-NOR flashes to spl_perform_fixups. So I think this worked for me 
because the SPI-NOR flash is explicitly listed in spl-boot-order for 
Puma, so when same-as-spl fails to resolve, the device is still found in 
spl-boot-order DT property which means spl_perform_fixup will still be 
able to write that spl-boot-device DT property. So basically, the issue 
is related to SPI-NOR flash NOT being explicitly listed in 
spl-boot-order or/and that the order isn't actually respected because 
same-as-spl is basically skipped right now (but it works for Puma 
because the next medium in the list is SPI, so skipping same-as-spl for 
SPI, would result in checking SPI again :) ).

Can you please add:

Fixes: d57e16c7e712 ("rockchip: find U-boot proper boot device by 
inverting the logic that sets it")

to the commit log regardless of the implementation we'll go for?

> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   arch/arm/mach-rockchip/spl.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
> index 1586a093fc37..27e996b504e7 100644
> --- a/arch/arm/mach-rockchip/spl.c
> +++ b/arch/arm/mach-rockchip/spl.c
> @@ -32,9 +32,17 @@ __weak const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>   
>   const char *board_spl_was_booted_from(void)
>   {
> -	u32  bootdevice_brom_id = readl(BROM_BOOTSOURCE_ID_ADDR);
> +	static u32 bootdevice_brom_id;
>   	const char *bootdevice_ofpath = NULL;
>   
> +	if (!bootdevice_brom_id)
> +		bootdevice_brom_id = readl(BROM_BOOTSOURCE_ID_ADDR);
> +	if (!bootdevice_brom_id) {
> +		debug("%s: unknown brom_bootdevice_id %x\n",
> +		      __func__, bootdevice_brom_id);
> +		return NULL;
> +	}

I don't think we absolutely need the second if block, as this would be 
handled by the else part of the if block that isn't shown in this git 
context.

Also, I would suggest to add a new entry to the BROM_BOOTSOURCE_* enum, 
e.g. BROM_BOOTSOURCE_INVALID/UNKNOWN = 0 so it's a bit more explicit and 
we're also "ready" for the day Rockchip decides to use 0 as a valid BROM 
boot source so we know all the places we need to modify the logic.

Moreover, I join Dragan over the use of a "valid" value for deciding to 
read from the RAM... but for another reason. If it actually is 0 for 
some reason, we would re-read from that address in RAM until we get 
something different from 0... which may happen to be written with 
something else than 0 when loading that small part of TF-A into SRAM? So 
we would then have something completely unexpected as boot source now.

Cheers,
Quentin
