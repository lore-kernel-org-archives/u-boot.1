Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97FE2CD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 12:02:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B95E688122;
	Wed, 10 Apr 2024 14:02:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="auIXQ5xt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B646787C40; Wed, 10 Apr 2024 14:02:29 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 241A888122
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 14:02:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLqAYGH39xeOqUtGv+pfo3dffgJgSdyZve9koM+DLkuYHSWJpaLz4zITk9/CN94+1ZneBMX9quiDgmLM98wGIhAiJf85kVplW/A/RVlAQUm5F3jmLsRLAOwWzS/lv//AsU/o9TFdkDLg//LK4lziRlmYUzG3TOSxuBAL1WN/kkiMHjaYpsC2UuyHxw5ySvpCGnJA2S+TvrC9nRPy+QZxGD39fgwwIR6dS2wz6otfNka0Yvq744x/uXAgBvhl7VOJBvcmudEQWhvitW3aiftb4DuOD8DHoDOkVtxxYGCRR8+t4yZQpawXR3V4t7Y2Zwkj0272b+IhnsmX/Pefdei9MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FZ5zsg937kr2m7lssARpQQy8Tl5m8K4dr0sw5yjcPY=;
 b=Q1uCNAVs6h1W781IkYtcOl6HT5cwBvajF7xcl/vWL/rW9SNMSG8AwY1aiCM6EZH44RLC/Ju3d0FdE9tE+/f7flcNrtfT2e/xhwmqxUfCAjumnm7MjbnBfaWvEsgN8BsuV6fs0HeRtTvugEneC8nuF0rkNgjDn28A/Pu8Z350AQxMTzmkAOLybK5ym6tabUCiPoxI1kb1/cevn+qXf+uk8XxXPBL2bIAZm/7gPr6obetOUdMo//gZjoTzYGYM9VWkAaTKoTzv5OH3rnyhxILhYpym6/ok/SJ7ZgabKc2HfMnl3CRhsbWc7CwqI2GkOnFXdE2p7NeBRRPiV9fCXt5IpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FZ5zsg937kr2m7lssARpQQy8Tl5m8K4dr0sw5yjcPY=;
 b=auIXQ5xtPQWY/+EBWrlBdqtWkiBRuVKgtr67KK5aKaEVSWNN1x4+LtLArbugU7AOcSKgGdJ1eg8ViiD6YfisJUQWlt0j7pdNp2QAaTQpdMSYfoeCQw8JXUvLYNaIXXTyolYZDrBjfIVvOyQNiQSDDNak2MBpJI3UQiOT3LbD1wvdqu6OzBSLBL4g45BB3xdsYAJam6OnkcGoOw+Kzp3h0bcKYhr5vL5tlZ33orSEvhX3/LONIL2LZQ58NynVGu8m9Q7TkS2vy0u8iu5X2HdLMvbv8/Z+HgX5Dr//yIb9yLV0v8t3JgHRtR803kY6NuAbxHz8jrWi+ZkUIqM3CmX/gQ==
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by VI1PR04MB9954.eurprd04.prod.outlook.com (2603:10a6:800:1d7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 12:02:24 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779%3]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 12:02:24 +0000
Message-ID: <20917bf6-2be2-4a1f-8c87-a69a2241d1fc@theobroma-systems.com>
Date: Wed, 10 Apr 2024 14:02:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] fastboot: introduce 'oem board' subcommand
To: Alexey Romanov <avromanov@salutedevices.com>, sjg@chromium.org,
 hs@denx.de, sean.anderson@seco.com, dimorinny@google.com,
 mkorpershoek@baylibre.com, patrick.delaunay@foss.st.com
Cc: kernel@salutedevices.com, u-boot@lists.denx.de
References: <20240410105804.22757-1-avromanov@salutedevices.com>
 <20240410105804.22757-2-avromanov@salutedevices.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240410105804.22757-2-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0016.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::28) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|VI1PR04MB9954:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hhjQwkg0b6oeT4fa3Q9a5YdD570PrjgNBGmLVSSplu9ZZx1M8nAAJZ4jk0xJze+qq/jun+8IbIvktifOxJCH7vlq8UgBy1zevSPk/0WV7YnSguyBsClc7P5PsrSqjxJen9CqY2gVywvy+og+FH44iMWhLhvw4LJYLf1U9gIE62HAnvo+xczBLsdL0BjoyWaUnBhSmIromb57ScAkFdL86kD53GVwBzXqM8Pmco7LbY/+CEDPzJ48r1BuEAvqcgxIoK+o03mRR2hPRPpFroEode6HQGXoWKFm2yEXIxoNLeqDqPcRq3rGFWpDYoaD/l7mvjwufUVC9Ky2oGYWDoJRu6ZhkN8FaRyq6eyUOMLoqLMMRl4D44ezeZT/zrpuwd4SeK3Jri/MNbpbF947az87FRDJ13gBw/JfQyVpITdXLaPUdYyX/1wo/ASszkbuX3Evhbo3hYpDciJDvV6C2x/JMn/+AwBREQusLJE7QG97v+8s7VtUkanLkgsN4BHn2t/98RENmlJDjT8U+cTNxrvVZ4EvNbLaYqEj4fhon46B+qROlT50Vwr4rbriZ0s68HvUWpgk4lZhpumiVps7YbPSpaQRHFuBAHGucOC3grOUpouoVCjHQgtl9BW6tHGRCQE0IWe7nULXbFYYJah5Aw2Y28k3tUQUfPbJz+LORoUF/v0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFZlWUtKYU5SRHFxckVEWXRCSDcvVkxoYzJRWlNJT3Avc3g0ZE9sa3hZeW8z?=
 =?utf-8?B?N0pWL1JSZVNjQWZMVGp2b2s3aUVUTmxKYm5iT1NlTmNaVSs1SXpHcXBkaU1P?=
 =?utf-8?B?OC9iNkxSQTg2MGlOU1N5TzBlQWtIQnNsV0MwbXdQWHdRRms1bWxRQzlrakxv?=
 =?utf-8?B?MXIrak9icVRuZ3ZDRU5xMHJyNHNhdFA4RXVyR3RQZytWZmo1bE1xNEZBNDdN?=
 =?utf-8?B?YmQvMWJIUXFSMjJCYzlBQ3lRUWpkdU1rR1FwK3djNkg2MUJsRnd6SlZqR0t2?=
 =?utf-8?B?dVFsYWxSbndPZnRCQ0VCdXhpMGEvcDVBRTlSZVdDVWtvYWE5UUhmY2V4UG5F?=
 =?utf-8?B?cllLbDl4S3NPNXJmcjNWbDFYdDVUZEZsekJTa1Axd0RkbDVSQlRpM05ONjBJ?=
 =?utf-8?B?Rkw0bDBISG5KNzlMbW14SUVOazRiRGlUUXVlSngzbC9GbVZ0b3FmQ2pwa3g4?=
 =?utf-8?B?eDY4RUZoeWs1Z2xNTFRxM0o1L2NBeEl2NXI0bkd2QVBxYnNKUWRQMnFXUjQ0?=
 =?utf-8?B?MHN6emFuK0ZBT01EME5mL1dEaXZFSndmUzRhdHNGK290RnRxUWpNQUJZZEhq?=
 =?utf-8?B?S3RBMEk0aTU2NXJYcy9ZeWVYeFpEWi9heHEzMkZXZ09DemxGYmxFZ0s2eGVV?=
 =?utf-8?B?RjVYbG1RRnpuOWVVeTJXaVk4Y3QwVWtRa1ljZVQwallrRmExZEdFWVVzNjJ2?=
 =?utf-8?B?VUdaUk5DYXI3RVlOUC94NVp4YWZTTUdKeXdHQUFHZDYwUlE2bExGZTVuQWt4?=
 =?utf-8?B?QVNCQlBBZGhvZ0FYNnl3dWtQUGZBd3dlOG1jOWVyZy9mbFZPR1YzSllrV1dY?=
 =?utf-8?B?OXFUWE5nUk54bVE1elZPUlp5ZUUyYmtCZXdaY2lZUGlmeHJ6Y0xoa2ZQTU5H?=
 =?utf-8?B?Szc1UGlrcVR1cEt6QTJsWUR2bEgydURBVURNU3g2aFg4MzBENGhNVE13OG9u?=
 =?utf-8?B?NVl3cUk1QzM4OW04NWtVQ2d0UVpzR2NJMjBVMHRPbmU1VEc4elN5d1o4WVcr?=
 =?utf-8?B?bFlnbnZ4eTFramZnK2d3c3BjZHRTQm9pOUxCZmNUSnFDRlY3NGR5aFlhajBM?=
 =?utf-8?B?ZW5HT2prOFpWQUhlTGREekhpYnl6dVgyT1pLM2x3SzBMRmdXZVBXcVZ4c0tx?=
 =?utf-8?B?SnpSdnhhK0gwZis2U01xRFNzRVJOKzEvQVJ6eTltTjkrTTl2YlNzYkVzK21v?=
 =?utf-8?B?clBpajlLaHlwa00vQVREeE9MN3lQMnpQU2M5QVVVc3kxRHdRK3lHUnRHSERD?=
 =?utf-8?B?QmpHVlNrVXRpU0pIQ0JaUUNNSlJrRXpHM1pVYWUrNkhReXhKOUNOL3QxVmZz?=
 =?utf-8?B?T1dhcWlPV0JySHpPOG82WFBOZ2dORUdnTERmZDhTaVJlTUNKRG45WDJDN3NO?=
 =?utf-8?B?UlVDNWdhVDRIRTA0NEJnSnVDamhwdmxpb1ZVNHMrYlhWbVpUNTlkQUFCOGV4?=
 =?utf-8?B?Mmo0NlZYMDJWQVE1aXkvU0Z5Umt4dXUxUWt0bWZnSGV6MGZwU2dweXVMaFhM?=
 =?utf-8?B?OFJtc1N0S3FkRVVjUkpjSnQ5VFFoWVJVVVdHS1NXVlBScWtJZXBtamNBdnRF?=
 =?utf-8?B?bDVrVmhGdzM1UmxLdGlXbGl3a1BJYlA3SlNGaGdpQjliWkFNZUNObGtka3gy?=
 =?utf-8?B?eDJqZGFOMHRvYllBdDNLM3AxdUNEcys5NGJwMm43TnhSelhoTkZyMzBNZjFm?=
 =?utf-8?B?VDlYeWNaR2RjQ2xSNVJhN0E0eXFpeTdXZyswMHVqM1IyYTdaNmtJVldPb0J3?=
 =?utf-8?B?MVFqZHVxTFRhQkYwYkUreUVrN0tCUkJIakJ3U1I4ZWRLSnVSR01NV2dIeU9h?=
 =?utf-8?B?bjRQVWxRYVF2Rm9TRmg4VDRFMlRzQjc1aHo0K3d2b2hHd0NFaDVneTEvNVJr?=
 =?utf-8?B?MWpQeG83OHZiejBNd0FlNzR1VFh0RVpZcFpnbFJBcWluZUtzYTBDREZiZW5J?=
 =?utf-8?B?RGt0bmkrTEtFRExSVWFOeThkd2w3OThZVWdZY0FIdmNDbTdHVmRsUU84Q3F0?=
 =?utf-8?B?MXkza29vK0RjVjhyeXNhVUxzQnZXZVN4N1pnekVnbTVaUkd3bkhkQ3QvaWh6?=
 =?utf-8?B?SSt1OUtINlVOeTl1QlJPM2VzYnRFdE4rN0w5QWVYaWlYK3Z5RVBpYTNKcStO?=
 =?utf-8?B?Zlo1clBJRm5wQWt1UlJKVFlMYzZ6ZUg4YzJlaHNqd0hTM25vbVQ2MDJnQUdW?=
 =?utf-8?B?cDl0UEdlWnFhbW5WaWo1R241MnppNW92K0gvamlleFVOZzI1WEVuVzM2UStJ?=
 =?utf-8?B?Mmg2NGNDVjlJb1liQy9SSXREWXhBPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d94dc1c9-e33a-415d-72bc-08dc5956151a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 12:02:24.1664 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0yaS9p0Y+AEvS9F1dsN2XMEaWeHNELDsqBi9nZNDXfnFcMaKUDOfcXspn9PNPaZ3LVPBuSQ7Zi4NZibYsxKnejBfLilPuIYMPLHd9asOr5DZ31R/jHP3UjGvsmDmw8l+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9954
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

Hi Alexey,

On 4/10/24 12:58, Alexey Romanov wrote:
> Currently, fastboot protocol in U-Boot has no opportunity
> to execute vendor custom code with verifed boot. This patch
> introduce new fastboot subcommand fastboot oem board:<cmd>,
> which allow to run custom oem_board function.
> 
> Default implementation is __weak. Vendor must redefine it in
> board/ folder with his own logic.
> 
> For example, some vendors have their custom nand/emmc partition
> flashing or erasing. Here some typical command for such use cases:
> 
> - flashing:
> 
>    $ fastboot stage bootloader.img
>    $ fastboot oem board:write_bootloader
> 
> - erasing:
> 
>    $ fastboot oem board:erase_env
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>   doc/android/fastboot.rst      | 18 ++++++++++++++++++
>   drivers/fastboot/Kconfig      |  7 +++++++
>   drivers/fastboot/fb_command.c | 30 ++++++++++++++++++++++++++++++
>   include/fastboot.h            |  1 +
>   4 files changed, 56 insertions(+)
> 
> diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
> index 1ad8a897c8..2a627f9890 100644
> --- a/doc/android/fastboot.rst
> +++ b/doc/android/fastboot.rst
> @@ -29,6 +29,7 @@ The following OEM commands are supported (if enabled):
>     with <arg> = boot_ack boot_partition
>   - ``oem bootbus``  - this executes ``mmc bootbus %x %s`` to configure eMMC
>   - ``oem run`` - this executes an arbitrary U-Boot command
> +- ``oem board`` - this executes a custom board function which is defined by the vendor
>   
>   Support for both eMMC and NAND devices is included.
>   
> @@ -245,6 +246,23 @@ including multiple commands (using e.g. ``;`` or ``&&``) and control structures
>   (``if``, ``while``, etc.). The exit code of ``fastboot`` will reflect the exit
>   code of the command you ran.
>   
> +Running Custom Vendor Code
> +^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +U-Boot allows you to execute custom fastboot logic, which can be defined
> +in board/ files. It can still be used for production devices with verified
> +boot, because the vendor define logic at compile time by implementing

I think it should be "defines" here?

Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Thanks,
Quentin
