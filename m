Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B91F2CDB482
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 07:51:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2297886BB4;
	Tue, 17 Oct 2023 09:51:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="gtoXHXoE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D27082BBF; Tue, 17 Oct 2023 09:51:44 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1b::622])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0ECB286BB4
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 09:51:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josua@solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A87wL1E07ruWNHDEkptqw2EajihQgJbTZjLomu6QVvNM7A/5rZHomZFcH8iuVV0dFzbe5RhNj3/37Yd58RcHBzh9RbncFm8L5jUvM6ZrRJfRD1K5meU7an0SoQa1LieaGfuzlCLmhEae9EQf7HHG/A5zu67pyN7PTm90NR6PxeVzQXPzlOQ26pIMqWr6RIj7wcaIJ1z9Gj7yHh9e3sjNcrUSynxqncLs3wPz5dpY1RNfuH0/ZhV4vQfon2JBc6Z5CKhkzScqAKhT9wIGBFSXhrquvaH3Yuz19SQbTH5ED+oeJsDBRmDn/eg+tBTgsmwRl9odSLlliR5Y6vh20J54sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDVNYc4/XAr5akjngK2t4VVPLxqn6Zt4Wdy5R6E1MtM=;
 b=FcvXzVqmv9snL7mFlgkQBbWJI9bwfOoi1zND6VpRrshF2QMkvNM5eTb7eDfsSgJVZNf/D/akIQ0vqmGS1eXo0qRI/j3kV6Ty4y3s8ZIChWqR8Fz6et6NWUJNFykkbWcCHU32+l/WhULTbqA6Z5zv/MI0foPED1o+G5LmKCPCFlxb1HyeJHejQwS8ntSlu/PpgBvAWLaKVpeJn2zL2S11CUKI+0SFExRQAQfTh7m7Jcm+jFJR7sGfg+HpzaCjFnXuEPhuSitBP51pehTajHSHSxxQpvxvlhDOrLlDYDhMu5rfnKTQKfLpnDOZooj3evUJy6L6KTzmapvyYxGm3gQreQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDVNYc4/XAr5akjngK2t4VVPLxqn6Zt4Wdy5R6E1MtM=;
 b=gtoXHXoEudbDmWqERvIrM9s4uLO8XqfodzKG/ypJufQoGbCGW/GOfSOj3j/984fWKwuLlmHYI8DNdbBwG98+HWcPgWTfOR2GLhY4T0TTU8kiMz7z4o447ddprUdfkNcxcQcG07OtuA4fwzryFyvG6v13n5saJ1E9yQeFxZDiFG4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by PA4PR04MB9296.eurprd04.prod.outlook.com (2603:10a6:102:2a7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 07:51:37 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::986:55cb:8fd6:87a4]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::986:55cb:8fd6:87a4%6]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 07:51:37 +0000
Message-ID: <54198537-f7ed-41d8-9395-8689cbb86b76@solid-run.com>
Date: Tue, 17 Oct 2023 09:51:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm: mvebu: clearfog: Add defconfigs for eMMC booting
To: Stefan Roese <sr@denx.de>, u-boot@lists.denx.de
Cc: sjg@chromium.org, kabel@kernel.org
References: <20231008124621.18803-1-josua@solid-run.com>
 <20231008124621.18803-4-josua@solid-run.com>
 <d9801245-eeba-4b54-9b38-7f3b25cdb6fd@denx.de>
Content-Language: en-US
From: Josua Mayer <josua@solid-run.com>
In-Reply-To: <d9801245-eeba-4b54-9b38-7f3b25cdb6fd@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::15) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|PA4PR04MB9296:EE_
X-MS-Office365-Filtering-Correlation-Id: e4c65cce-b2a6-4d5e-1134-08dbcee5e3d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8e4IaAfxrUL70HGGQEUeP4qGqZ8kVbHq7Kbe02+NIf4hwzndft6do2o+qvNzafW/IdlHU1KYWw9t9AGMifVQdDKXCgNeDBo7mStocFECvmPhtvcXMBO94B0cRakGV600w/TR6zU6eGt0OM7NsOqUmuXWGSBHKIoUazZH0GA0srGYB5zA0vF21vhnaSoJs1ypYejuQBvWijX+WIo5qnBICDveO0emWvdVVSDPpDMwzvkJPGnYOEd1L/MJYVNehoE34u9PIO//JoHX9LlQ2GlIRr7JWIX8XP6Qu1vsGCIb/xYRqG+mgI7u8kvwjJOPqkL8NYdQlK3xrlfprAbRkQGYG/4unfRWjUl+9doRQDbKGWzWgoAtBAPtQtskCKAOQ5y/5BkjxkztGRstKBmDw78g3K3bgktA4wdfEaVmkYkgUCaAwPOZq23MwoZ/9YH2kZDG69v3N4p9xXO8GA9k/pfIpJVBY0+xC3dnNlygrzAC5Vv/HOgwS2b2LBeBLnJMnXjngX32lEZ4eGv3uYAgEYrRrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8963.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39840400004)(366004)(346002)(376002)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6486002)(478600001)(2616005)(66476007)(316002)(66946007)(66556008)(31696002)(66574015)(6512007)(26005)(6506007)(2906002)(8936002)(5660300002)(8676002)(4326008)(41300700001)(86362001)(36756003)(38100700002)(83380400001)(6666004)(53546011)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHBxWktZclVmbk9KR0VYdUN3Zy9QbG04Q1krL21TQ0tmSy9FdjNzRm9nMzhz?=
 =?utf-8?B?bUdESVZQN0xBd2lnM24yM3NveCtMTTdpQ3NTWVdhcDArSHBtb0FiY1ByZEFM?=
 =?utf-8?B?Z2FNVUFROGNyQnhyMjY4dlFUamxhTUgyRzE1Q2Y2TDVzejV2UnlGR2lML1RC?=
 =?utf-8?B?b00yaTg0Z3JwTG80cHZzeGdLckZFbjQ0ZTJRcmI1Qm4zY2E1bnRnR2pvME1Z?=
 =?utf-8?B?Z01SY1R1aGh1T0RtT3Z0c2UyVVIyKzBJcHA0OWJyTnN4V1lDOEo3akhkNTBw?=
 =?utf-8?B?OHZKby96RVdEUmFEa0J0Y0xsRzVqQURWRHkvL1RpVCt1bWVORGNTczc0VTJw?=
 =?utf-8?B?aERKME5yQTV6WEkwc3R4SnJOOUt1ZzkzQ0RZNy8rM1hGbFl6dVpVcDMyZWh0?=
 =?utf-8?B?bmpvVVRLNFR4dFA5QXl3UExQbURhcW1wUFEvMXFQNDFHY0VQVkMrS3lIV2xu?=
 =?utf-8?B?ZVNqeGxYNVZDWXFPQTlYRmEvbk1vVytDUDZJMjhzbVFIMk9VUWFpN2N1NzRt?=
 =?utf-8?B?NFdaV1Bwa0pLdDdVQi9tQk4vY1NTRFRwd1RsSWtXaktENFU4bkFydUVXV05v?=
 =?utf-8?B?UDNYcGRDeUk4VW1WTHo5TmpLeVYxYVpqdFJlcWlBaFhHWUxmNWl4YTBxTWhz?=
 =?utf-8?B?N05mWlI4bG5PallzRXA1TkNWaDZpRjVaclpCUFdBYSt4OHNwSmp6THN3cm1X?=
 =?utf-8?B?ZEM1ZFZPVkZNTURwNTUwZGlGdXhFZWpNck9ybk9LUDI0ZGIyd3p3M0ZBS3lC?=
 =?utf-8?B?ZytRa2grYmljbUJvTEQwOThSWE0xY1FUd01CeVBGQkpES3VERExIeU5lSzAv?=
 =?utf-8?B?SlpKRUdMenVWcDRsWG40bFR3S2tnSmFnenpNTEVVcVVwM0E3L0pqYi9tcmFD?=
 =?utf-8?B?OEZIaElDMXRXdEo2T0d0bGFEZzIrZ0k4YUVVTVpxOTNKRXdIZTZ0SmtVRnlZ?=
 =?utf-8?B?MUI2dGJBNmhqWk9yTWJ0ZDJlKzk0RUpMTFh3ZzZWTkQxbzIvOUpwZURHdzBR?=
 =?utf-8?B?N3ZpUGpIY2lndGlVVVVkLy8yR2ovYUlQU3U4alNNNExhejN3UWt0MlJqL0Zh?=
 =?utf-8?B?U0pxUldCQXh4US9pS21pMnU3eG9FQ2ZtTGRTRkxjT1lXa2tyM2g2WHlJSENj?=
 =?utf-8?B?cnRrQWUySi9wUFgvN1l4enpPM0xiTCtxanJNeHl5cVQvdm9zMHArcE4yNnM1?=
 =?utf-8?B?OXozL2c2aWluTUZKbUxGNkxhRmljRVZFZ042MEZ4azVoV3RnQ1ZHUGtFOHQ5?=
 =?utf-8?B?TDUyZFB6cEJCMmJuYVVKV0ltVEFJc25Pd2JDMUtNVGxmQ0hVOXpRZFZ3Y05J?=
 =?utf-8?B?cHl0OHdYS0pNZ0docDZjMGx6TFlyRVlPU0NET05VYTd4b0NRTlQycW1CZDdG?=
 =?utf-8?B?c2t1dGxPa2hzckRQeVdCVTI3cTZzeHBKazBTQ2pIaHRwRTV3UFNCd2JiMmYw?=
 =?utf-8?B?OWlaTUFreUpvL01yOUlXYmhYdnBZWWRjL3R0MEFHd0FoeUIvOTBHRERjOWxH?=
 =?utf-8?B?TUpOTkdJeTFTMERkeHptclpKYkxYTG1VWGxsMksyYzVGcE9TNnd2UlUvbDlJ?=
 =?utf-8?B?OU9qNUdiVk1telpMbG9GSVJUWGFJc2x4bFFxbVlNTjFwY0tYcmdQME1XNHox?=
 =?utf-8?B?UXpVVlkwSlNaMERkdnNTaGhYRFF5OWhubW12eUpFaUNOTVdsYXpWS2FYUnVK?=
 =?utf-8?B?RkNYempUUFU3d2NXU2U3Q2llaGlVR0R1T21qWUxuV2hBczcwakZuWjYwMEhE?=
 =?utf-8?B?NHVuUUxqeFRqamR3VmI0cTh0Y3NXZ2hIZjg0K280bTIrZi9aaUlxVTVIVG1w?=
 =?utf-8?B?dUlSL2haOHFucHozTWozS3JaMm04c1RkdEZ0dWRJdjVkMG9abVRhQSt4UzV4?=
 =?utf-8?B?aXJIU1JZWTR6ODgwL3pXSGxXR3dUbjBXc0RhOFZuRHljT0JLY3R5bGp0Y1NU?=
 =?utf-8?B?akFPTnZPMnJVTzB4MGRRYko3L1BtdDZ3SmZFSi9qT1JiRlkrS0RsaTVTeGV5?=
 =?utf-8?B?c3M5L0UrR3JJSWVqa29wbGdMN3dWMzRCREFSamJyYUUvUjFuUXpjU3pEdi9r?=
 =?utf-8?B?cy85VGVwaU01VUFjcGZCYTFJbEhOLzk3TmdHRHY3bEdSRFdDb3F2Nzg5OW9G?=
 =?utf-8?Q?efu5gVz+BCOQy94oXRUSTYaGp?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c65cce-b2a6-4d5e-1134-08dbcee5e3d9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 07:51:36.9951 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gQt2pqSwZZaU99B+hjLdsLkuIyOj03h4rlbgoNHKnxJMvOSv5lPrn1b29d6a3NGsZf8U21sTYbt0Zrbu4VUfrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9296
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

Hi Stefan,

Am 16.10.23 um 10:37 schrieb Stefan Roese:
> Hi Josua,
>
> On 10/8/23 14:46, Josua Mayer wrote:
>> Armada 388 can boot from either eMMC data, boot0 or boot1 partitions.
>>
>> data partition requires booting from LBA-4096 to avoid conflict with
>> MBR. When booting from boot0/boot1 environment should be stored there
>> respectively, too.
>>
>> Add 3 new defconfigs, for each eMMC partition:
>> - clearfog_emmcboot0_defconfig
>> - clearfog_emmcboot1_defconfig
>> - clearfog_emmcdata_defconfig
>
> Do we really need new, separate defconfig files for those very similar
> configurations? Or is there a way to detect this at runtime
I do not know, Pali Rohár might know.
We can skip patch 3 until some research has been done.
> or if not
> possible to include a common defconfig file?
So, if the boot partition used to load u-boot by the boot-rom can be 
detected at runtime,
the specialisation of boot0/boot1 configs could be dropped.
That would still leave special case of u-boot offset on eMMC,
which is different between boot and data partitions, and also different 
to SD configuration.

IMO it could be unified by using LBA-4096 as the general default, for 
every place.
But that changes everyones default, and there is no good way to update 
an existing system
(see overlap with MBR partitions).

>
> Just checking...
>
> Thanks,
> Stefan
br
Josua
>
>> Signed-off-by: Josua Mayer <josua@solid-run.com>
>> ---
>>   configs/clearfog_emmcboot0_defconfig | 82 ++++++++++++++++++++++++++++
>>   configs/clearfog_emmcboot1_defconfig | 82 ++++++++++++++++++++++++++++
>>   configs/clearfog_emmcdata_defconfig  | 82 ++++++++++++++++++++++++++++
>>   3 files changed, 246 insertions(+)
>>   create mode 100644 configs/clearfog_emmcboot0_defconfig
>>   create mode 100644 configs/clearfog_emmcboot1_defconfig
>>   create mode 100644 configs/clearfog_emmcdata_defconfig
>>
>> diff --git a/configs/clearfog_emmcboot0_defconfig 
>> b/configs/clearfog_emmcboot0_defconfig
>> new file mode 100644
>> index 00000000000..215b7708a0d
>> --- /dev/null
>> +++ b/configs/clearfog_emmcboot0_defconfig
>> @@ -0,0 +1,82 @@
>> +CONFIG_ARM=y
>> +CONFIG_ARCH_CPU_INIT=y
>> +CONFIG_SYS_THUMB_BUILD=y
>> +CONFIG_ARCH_MVEBU=y
>> +CONFIG_TEXT_BASE=0x00800000
>> +CONFIG_SPL_LIBCOMMON_SUPPORT=y
>> +CONFIG_SPL_LIBGENERIC_SUPPORT=y
>> +CONFIG_NR_DRAM_BANKS=2
>> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xff0000
>> +CONFIG_TARGET_CLEARFOG=y
>> +CONFIG_MVEBU_SPL_BOOT_DEVICE_MMC=y
>> +CONFIG_DEFAULT_DEVICE_TREE="armada-388-clearfog"
>> +CONFIG_SPL_TEXT_BASE=0x40000030
>> +CONFIG_SPL_SERIAL=y
>> +CONFIG_SPL_STACK=0x4002c000
>> +CONFIG_SPL=y
>> +CONFIG_DEBUG_UART_BASE=0xf1012000
>> +CONFIG_DEBUG_UART_CLOCK=250000000
>> +CONFIG_SYS_LOAD_ADDR=0x800000
>> +CONFIG_PCI=y
>> +CONFIG_DEBUG_UART=y
>> +CONFIG_AHCI=y
>> +CONFIG_DISTRO_DEFAULTS=y
>> +CONFIG_BOOTDELAY=3
>> +CONFIG_USE_PREBOOT=y
>> +CONFIG_SYS_CONSOLE_INFO_QUIET=y
>> +# CONFIG_DISPLAY_BOARDINFO is not set
>> +CONFIG_DISPLAY_BOARDINFO_LATE=y
>> +CONFIG_SPL_MAX_SIZE=0x22fd0
>> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>> +CONFIG_SPL_BSS_START_ADDR=0x40023000
>> +CONFIG_SPL_BSS_MAX_SIZE=0x4000
>> +CONFIG_SPL_SYS_MALLOC_SIMPLE=y
>> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>> +CONFIG_SPL_I2C=y
>> +CONFIG_SYS_MAXARGS=32
>> +CONFIG_CMD_TLV_EEPROM=y
>> +CONFIG_SPL_CMD_TLV_EEPROM=y
>> +# CONFIG_CMD_FLASH is not set
>> +CONFIG_CMD_GPIO=y
>> +CONFIG_CMD_I2C=y
>> +CONFIG_CMD_MMC=y
>> +CONFIG_CMD_PCI=y
>> +CONFIG_CMD_SPI=y
>> +CONFIG_CMD_USB=y
>> +CONFIG_CMD_TFTPPUT=y
>> +CONFIG_CMD_CACHE=y
>> +CONFIG_CMD_TIME=y
>> +CONFIG_ENV_OVERWRITE=y
>> +CONFIG_ENV_MIN_ENTRIES=128
>> +CONFIG_SYS_MMC_ENV_PART=1
>> +CONFIG_ARP_TIMEOUT=200
>> +CONFIG_NET_RETRY_COUNT=50
>> +CONFIG_NET_RANDOM_ETHADDR=y
>> +CONFIG_SPL_OF_TRANSLATE=y
>> +CONFIG_AHCI_MVEBU=y
>> +CONFIG_DM_PCA953X=y
>> +CONFIG_DM_I2C=y
>> +CONFIG_SYS_I2C_MVTWSI=y
>> +CONFIG_I2C_EEPROM=y
>> +CONFIG_SPL_I2C_EEPROM=y
>> +CONFIG_MMC_SDHCI=y
>> +CONFIG_MMC_SDHCI_SDMA=y
>> +CONFIG_MMC_SDHCI_MV=y
>> +CONFIG_MTD=y
>> +CONFIG_SF_DEFAULT_BUS=1
>> +CONFIG_SPI_FLASH_WINBOND=y
>> +CONFIG_SPI_FLASH_MTD=y
>> +CONFIG_PHY_MARVELL=y
>> +CONFIG_PHY_GIGE=y
>> +CONFIG_MVNETA=y
>> +CONFIG_MII=y
>> +CONFIG_MVMDIO=y
>> +CONFIG_PCI_MVEBU=y
>> +CONFIG_SCSI=y
>> +CONFIG_SPL_DEBUG_UART_BASE=0xd0012000
>> +CONFIG_DEBUG_UART_SHIFT=2
>> +CONFIG_SYS_NS16550=y
>> +CONFIG_KIRKWOOD_SPI=y
>> +CONFIG_USB=y
>> +CONFIG_USB_XHCI_HCD=y
>> diff --git a/configs/clearfog_emmcboot1_defconfig 
>> b/configs/clearfog_emmcboot1_defconfig
>> new file mode 100644
>> index 00000000000..59f88c64a2e
>> --- /dev/null
>> +++ b/configs/clearfog_emmcboot1_defconfig
>> @@ -0,0 +1,82 @@
>> +CONFIG_ARM=y
>> +CONFIG_ARCH_CPU_INIT=y
>> +CONFIG_SYS_THUMB_BUILD=y
>> +CONFIG_ARCH_MVEBU=y
>> +CONFIG_TEXT_BASE=0x00800000
>> +CONFIG_SPL_LIBCOMMON_SUPPORT=y
>> +CONFIG_SPL_LIBGENERIC_SUPPORT=y
>> +CONFIG_NR_DRAM_BANKS=2
>> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xff0000
>> +CONFIG_TARGET_CLEARFOG=y
>> +CONFIG_MVEBU_SPL_BOOT_DEVICE_MMC=y
>> +CONFIG_DEFAULT_DEVICE_TREE="armada-388-clearfog"
>> +CONFIG_SPL_TEXT_BASE=0x40000030
>> +CONFIG_SPL_SERIAL=y
>> +CONFIG_SPL_STACK=0x4002c000
>> +CONFIG_SPL=y
>> +CONFIG_DEBUG_UART_BASE=0xf1012000
>> +CONFIG_DEBUG_UART_CLOCK=250000000
>> +CONFIG_SYS_LOAD_ADDR=0x800000
>> +CONFIG_PCI=y
>> +CONFIG_DEBUG_UART=y
>> +CONFIG_AHCI=y
>> +CONFIG_DISTRO_DEFAULTS=y
>> +CONFIG_BOOTDELAY=3
>> +CONFIG_USE_PREBOOT=y
>> +CONFIG_SYS_CONSOLE_INFO_QUIET=y
>> +# CONFIG_DISPLAY_BOARDINFO is not set
>> +CONFIG_DISPLAY_BOARDINFO_LATE=y
>> +CONFIG_SPL_MAX_SIZE=0x22fd0
>> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>> +CONFIG_SPL_BSS_START_ADDR=0x40023000
>> +CONFIG_SPL_BSS_MAX_SIZE=0x4000
>> +CONFIG_SPL_SYS_MALLOC_SIMPLE=y
>> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>> +CONFIG_SPL_I2C=y
>> +CONFIG_SYS_MAXARGS=32
>> +CONFIG_CMD_TLV_EEPROM=y
>> +CONFIG_SPL_CMD_TLV_EEPROM=y
>> +# CONFIG_CMD_FLASH is not set
>> +CONFIG_CMD_GPIO=y
>> +CONFIG_CMD_I2C=y
>> +CONFIG_CMD_MMC=y
>> +CONFIG_CMD_PCI=y
>> +CONFIG_CMD_SPI=y
>> +CONFIG_CMD_USB=y
>> +CONFIG_CMD_TFTPPUT=y
>> +CONFIG_CMD_CACHE=y
>> +CONFIG_CMD_TIME=y
>> +CONFIG_ENV_OVERWRITE=y
>> +CONFIG_ENV_MIN_ENTRIES=128
>> +CONFIG_SYS_MMC_ENV_PART=2
>> +CONFIG_ARP_TIMEOUT=200
>> +CONFIG_NET_RETRY_COUNT=50
>> +CONFIG_NET_RANDOM_ETHADDR=y
>> +CONFIG_SPL_OF_TRANSLATE=y
>> +CONFIG_AHCI_MVEBU=y
>> +CONFIG_DM_PCA953X=y
>> +CONFIG_DM_I2C=y
>> +CONFIG_SYS_I2C_MVTWSI=y
>> +CONFIG_I2C_EEPROM=y
>> +CONFIG_SPL_I2C_EEPROM=y
>> +CONFIG_MMC_SDHCI=y
>> +CONFIG_MMC_SDHCI_SDMA=y
>> +CONFIG_MMC_SDHCI_MV=y
>> +CONFIG_MTD=y
>> +CONFIG_SF_DEFAULT_BUS=1
>> +CONFIG_SPI_FLASH_WINBOND=y
>> +CONFIG_SPI_FLASH_MTD=y
>> +CONFIG_PHY_MARVELL=y
>> +CONFIG_PHY_GIGE=y
>> +CONFIG_MVNETA=y
>> +CONFIG_MII=y
>> +CONFIG_MVMDIO=y
>> +CONFIG_PCI_MVEBU=y
>> +CONFIG_SCSI=y
>> +CONFIG_SPL_DEBUG_UART_BASE=0xd0012000
>> +CONFIG_DEBUG_UART_SHIFT=2
>> +CONFIG_SYS_NS16550=y
>> +CONFIG_KIRKWOOD_SPI=y
>> +CONFIG_USB=y
>> +CONFIG_USB_XHCI_HCD=y
>> diff --git a/configs/clearfog_emmcdata_defconfig 
>> b/configs/clearfog_emmcdata_defconfig
>> new file mode 100644
>> index 00000000000..335b50e3c48
>> --- /dev/null
>> +++ b/configs/clearfog_emmcdata_defconfig
>> @@ -0,0 +1,82 @@
>> +CONFIG_ARM=y
>> +CONFIG_ARCH_CPU_INIT=y
>> +CONFIG_SYS_THUMB_BUILD=y
>> +CONFIG_ARCH_MVEBU=y
>> +CONFIG_TEXT_BASE=0x00800000
>> +CONFIG_SPL_LIBCOMMON_SUPPORT=y
>> +CONFIG_SPL_LIBGENERIC_SUPPORT=y
>> +CONFIG_NR_DRAM_BANKS=2
>> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xff0000
>> +CONFIG_TARGET_CLEARFOG=y
>> +CONFIG_MVEBU_SPL_BOOT_DEVICE_MMC=y
>> +CONFIG_DEFAULT_DEVICE_TREE="armada-388-clearfog"
>> +CONFIG_SPL_TEXT_BASE=0x40000030
>> +CONFIG_SPL_SERIAL=y
>> +CONFIG_SPL_STACK=0x4002c000
>> +CONFIG_SPL=y
>> +CONFIG_DEBUG_UART_BASE=0xf1012000
>> +CONFIG_DEBUG_UART_CLOCK=250000000
>> +CONFIG_SYS_LOAD_ADDR=0x800000
>> +CONFIG_PCI=y
>> +CONFIG_DEBUG_UART=y
>> +CONFIG_AHCI=y
>> +CONFIG_DISTRO_DEFAULTS=y
>> +CONFIG_BOOTDELAY=3
>> +CONFIG_USE_PREBOOT=y
>> +CONFIG_SYS_CONSOLE_INFO_QUIET=y
>> +# CONFIG_DISPLAY_BOARDINFO is not set
>> +CONFIG_DISPLAY_BOARDINFO_LATE=y
>> +CONFIG_SPL_MAX_SIZE=0x22fd0
>> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>> +CONFIG_SPL_BSS_START_ADDR=0x40023000
>> +CONFIG_SPL_BSS_MAX_SIZE=0x4000
>> +CONFIG_SPL_SYS_MALLOC_SIMPLE=y
>> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET=0x1000
>> +CONFIG_SPL_I2C=y
>> +CONFIG_SYS_MAXARGS=32
>> +CONFIG_CMD_TLV_EEPROM=y
>> +CONFIG_SPL_CMD_TLV_EEPROM=y
>> +# CONFIG_CMD_FLASH is not set
>> +CONFIG_CMD_GPIO=y
>> +CONFIG_CMD_I2C=y
>> +CONFIG_CMD_MMC=y
>> +CONFIG_CMD_PCI=y
>> +CONFIG_CMD_SPI=y
>> +CONFIG_CMD_USB=y
>> +CONFIG_CMD_TFTPPUT=y
>> +CONFIG_CMD_CACHE=y
>> +CONFIG_CMD_TIME=y
>> +CONFIG_ENV_OVERWRITE=y
>> +CONFIG_ENV_MIN_ENTRIES=128
>> +CONFIG_ARP_TIMEOUT=200
>> +CONFIG_NET_RETRY_COUNT=50
>> +CONFIG_NET_RANDOM_ETHADDR=y
>> +CONFIG_SPL_OF_TRANSLATE=y
>> +CONFIG_AHCI_MVEBU=y
>> +CONFIG_DM_PCA953X=y
>> +CONFIG_DM_I2C=y
>> +CONFIG_SYS_I2C_MVTWSI=y
>> +CONFIG_I2C_EEPROM=y
>> +CONFIG_SPL_I2C_EEPROM=y
>> +CONFIG_MMC_SDHCI=y
>> +CONFIG_MMC_SDHCI_SDMA=y
>> +CONFIG_MMC_SDHCI_MV=y
>> +CONFIG_MTD=y
>> +CONFIG_SF_DEFAULT_BUS=1
>> +CONFIG_SPI_FLASH_WINBOND=y
>> +CONFIG_SPI_FLASH_MTD=y
>> +CONFIG_PHY_MARVELL=y
>> +CONFIG_PHY_GIGE=y
>> +CONFIG_MVNETA=y
>> +CONFIG_MII=y
>> +CONFIG_MVMDIO=y
>> +CONFIG_PCI_MVEBU=y
>> +CONFIG_SCSI=y
>> +CONFIG_SPL_DEBUG_UART_BASE=0xd0012000
>> +CONFIG_DEBUG_UART_SHIFT=2
>> +CONFIG_SYS_NS16550=y
>> +CONFIG_KIRKWOOD_SPI=y
>> +CONFIG_USB=y
>> +CONFIG_USB_XHCI_HCD=y
>
> Viele Grüße,
> Stefan Roese
>
