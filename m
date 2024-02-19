Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7524C48BC3
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 09:58:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70D5587F41;
	Mon, 19 Feb 2024 10:51:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="Cxqo+UHw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40E4E87F25; Mon, 19 Feb 2024 10:51:23 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3237487E6A
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 10:51:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgIMRhDAuL61UOkM/Ap87cApMKej9XfP6yzuEewNSppeH8p9kaG9UZWBkbUJgs0QcIi18oQszytizOlfg5P1BQUM2lOMWIcKLaIUvsSYJJaDzGjQl1nIh20/WwPBI/Jh4rRRqLMzlyLYOs+z3+O8a8dyJoMGoecPJL3OPKgKIrQ01uRBeH1TuMI66vywhyZdORGoNFMjt58g/CfPiHVoeZUhKSYzmEAvIdd+0mPvR9OdWeBwgXEReuMJkigmw4gJumy4iPCXnJdzidmg5MINCRgP59s/OPhPe0BiOKcQ9PL1Dlw0ZOyJrObODRfzb/yplBOKarafoA2a8ppPRJJ3LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YZyYms5jXy1BhQfAqL7/lXi4Ze7zriC/XE52DyKcqc=;
 b=NvvThH28QNveKnSmMBrJkeoYMdU9ViSg1T7ESMYVlSnEk+oaMFpBPUZNXKwAv/jpQDEawNCl5pSjT1Abq+Hk6f1WgqDLw+Z0r8b/gwwYmgZLf8345blQ45fyK+xmtaMekCli9tR2kSkl8rMzt9XgSXeE1h3HSM5gxbM+RvtkunVV9SiTjJ7kcWGoyueC/8KfcHNkg/GNCfFje3Uu4K7bsS0LSIEiDdtj23Vz9R676wmo42CStaLQtEJGGIL6/7QtDM2KYvb8aoF84RjEmTBCwnkKD4P6wWLkufnC1jlbofEnRXs44QJRl00O28Q1WY86qavoL0r8tQHMqtjo+GS3JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YZyYms5jXy1BhQfAqL7/lXi4Ze7zriC/XE52DyKcqc=;
 b=Cxqo+UHwsUpz6+HexthPMKo6wre3rk8gSWX1BZlQcEPBKa5m47PyGGzsvoJUqwUAB9eEe7blhDxtlQLL/97HtOwj/gPjU/0Mffy5q7WahUl/OV0pmti9fRON2AX7TL/KPSnuBBcvlMgGbAPrvtgQBkDT3eZyS1fiNX6TS8jsRcmMcluxIXUm6kUXR8d3BE4P41VkXgDF6WE2dTUeaiylKVneZdapEsmH/G+3R28CRj8qIB4HFiyuC2r6IkNWvM4pwB7YTj4ZdJQiFBTfH0wtAZ+Md9fk8WbHMfDY+PfLMZATujE5t9Y577ESV0r0VE0oN7Dt50jw6hQMJFU4jtyxJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by GVXPR04MB9877.eurprd04.prod.outlook.com (2603:10a6:150:113::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 09:50:57 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%5]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 09:50:57 +0000
Message-ID: <0b87d8df-9040-432b-8756-17afa0118c40@theobroma-systems.com>
Date: Mon, 19 Feb 2024 10:50:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: ringneck-px30: put STM32_RST line in input mode
 instead of output
Content-Language: en-US
To: Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <foss+uboot@0leil.net>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>, Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.denx.de
References: <20240209-ringneck-stm32-rst-input-v1-1-fa9d23ac8ebe@theobroma-systems.com>
 <03469644-53de-4484-82d7-348531d2148b@rock-chips.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <03469644-53de-4484-82d7-348531d2148b@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::16) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|GVXPR04MB9877:EE_
X-MS-Office365-Filtering-Correlation-Id: b87d72a1-fc67-40af-d141-08dc31304584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SCrJshpmBYZEC4ga08eDnA0u9+J6MY4vP6ZQO22jjqq7F/wxgS1y/cD3hXu6h5m3UwR0ioFZt9zxhOW2vHW1UgMPJ4pfDVwZC9+UXcrdFyonNsZgON/ZBhd7x0N+iV1fEzzZEx2NWLlOyPqsBDDilCopYS1P4nFQkcsDEc8eLeudt8uE38kFHqAzsDmZhz2XVEXbn7ll+fdiO9+YCAZJ14lQq4wZJTboVKsydrVViJmAm/tjzac6WKTgBgk5NGRY9+wWx0JasxtfRY55sqR3Z7Ntk7CiJ1x5REvbodGBuAB1Z8JENqj7P6QRO0AASkOwKLQu2t3MUvylXr/fFmPc3G2YSDfOw5YUwoIZf243LCfNEDILj11zQv0+Fk8aHMFTriy7Jph2y5RcDYqdeA4gTb8/HKmyoTzX6SuLRGxSjq09+/2ZVjw17GZNudsB8DlnpKXV1zQ0PS6ZAmGzE0Mu/HOdpkxaWTosWx77u81e1gnjMJ9JHFMwNtKrn8SB1TFxtlgi5OLiYHUREwdhgRsMnLK1z0gfMqJ01Er7BPozbQtRNKegxhTomTy1JdS3cybC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(376002)(396003)(39850400004)(366004)(230922051799003)(230273577357003)(186009)(64100799003)(451199024)(1800799012)(2906002)(5660300002)(44832011)(31686004)(26005)(8936002)(66556008)(66476007)(4326008)(66946007)(316002)(41300700001)(2616005)(83380400001)(8676002)(86362001)(478600001)(53546011)(966005)(6486002)(110136005)(6506007)(6512007)(38100700002)(31696002)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHMzemk0VXRYZnlNNjhraUVEcVY5UGc3ZzcvdjZmYUFUNDFMaG5oRjZoY2VD?=
 =?utf-8?B?bFBzK1lITEUrK1R1OE95MjJxMHhuSUJYSE0xVS9UbHVyeXVvUU1sZ25zM2Jw?=
 =?utf-8?B?azdIRy85c2NuMCtZSndvZUl4QUNCRmlIY20rUE5TeHBIOTRWNy96U0lXZkF3?=
 =?utf-8?B?Nk9iaUpnQkZ6cmxCVDJGYXlZbXhUQ3NzaUQ0SHplU3R6b2ZMSVVwL3BhdUtH?=
 =?utf-8?B?VkQ4NXo4WkN0MmRrR1dydWxUMVNBdFBmd0tMZ2VvS3RVVXYySjBrSlJzRDJS?=
 =?utf-8?B?VzlpZXRTOVRyUWU3WnAyamV2NzRhSHowZ2s2Mld1Y1FYcS9XeXlBUk9ZNUg1?=
 =?utf-8?B?U0U0dGcwR05GOGtZTk4vM1I2clRvc1FCNEdldDF4NnBCcGpPQk03YXl1a0NZ?=
 =?utf-8?B?N1BweFRPTGFSYnhLbExZbFJ6Uk9ZUHdhRmNXc0EwMm1NbU5kR2daeVYvakZh?=
 =?utf-8?B?ZTR6Z2ZhMkJTbWVHT0d3QnJHRGlqOTBnMDJYTTNUSCt6UExFblJVQ3ZGMlQy?=
 =?utf-8?B?aGJEQ2V3d01ocXZVK2p0UlpnQzNBdkU3SzdNTUEwellsQmh4YU9BaFZPU2do?=
 =?utf-8?B?enZIMU5DNHVjakFySVd2cHdYMU1BQ3NvdEdja2U4YjV1MXNrdVQ1ZVBwSkR0?=
 =?utf-8?B?TGE5aGtaR1JYdXN4TEh4alVHVTFvRnNFYTJ5WEwxdEhsVFA1cEtsYnUwMHlK?=
 =?utf-8?B?NlBMRHdCZjdtRW5vbkZnZFhmNDVsdUszTHh1bkNJV284SjFZQ0dEQTE4b1d4?=
 =?utf-8?B?b3MzQjh1dFdNOFl2dFgrV1daby9PeWpPN05CWmg4Q1AzdUxrQ25FSVNyQnZT?=
 =?utf-8?B?aWYwVHlTMFFUKzVRd0tGSjB4bTRaUTg1TUlkSEU1QWVsVkthekhSNXF5WUNN?=
 =?utf-8?B?YUFSWGR2RUtDaU81cXcxRUlydUFGdUFXL0tSWmsyV2FwVDA0d3JCUDVBRDdu?=
 =?utf-8?B?SDl5aHVIK2VoaThPTTNoMGtIK0pXc0E4SmFscGhabnRmZEN1eHNCVXQwdzJS?=
 =?utf-8?B?TW5kMnQ0R29mZE1TOEJ6ajl1NjJJSStoc1N3ZEE4UWpvUnkvUm0ranA4S1Bv?=
 =?utf-8?B?aTZ0ZHdvR2IrbnovRVF6TUtqV0lidlJ2a2xQSmNMZmYzY0xsOFI0TjhEeXIv?=
 =?utf-8?B?bGNVQXppK2JKVmhEaFpTY3ZTTkprdTB4bE0zeGlJRmZpOTdheHduUW5zVTc1?=
 =?utf-8?B?VHVmNVVwMDJMUlROUk9GV2ZJaUk0SjFaK2J6NE5BY3ZZQkRjVm9BdVNCNnVs?=
 =?utf-8?B?YnMxU000WUZiUnJFYmlsbUxPK2JqbVp4ZHpObWI4d1FDZ3lSaUh1SUhjamUv?=
 =?utf-8?B?VS9ROGhhMWtxVERsTjhkb0ZSc0FvbTJoODA4MUg1VFp0TEd3T0lhZjJWbU9G?=
 =?utf-8?B?YWtzbG1ZTGcxaUJpU09UZ3hEUXZxcEV0Q3MzQzRWWk5JeWVjNGFpa1RQdW5y?=
 =?utf-8?B?MDkrZkFpbXhoV3FUMkxBYld2d1dENWJWSUw0SElpZU8zT0kwUTNzYndMM3Mx?=
 =?utf-8?B?U1dHM2ljQWpqQi9jcGVlTHJCRFpQMlk5bGxrSnMxSjlzdlc5MU0vSVBkenJh?=
 =?utf-8?B?RFM0KzFKZzd2aHdEZlFIaDhSYm9Uc0xNSlo5SXUzVGJ6eFB3UUVIL0NHdGdu?=
 =?utf-8?B?SjF1MzROMXdQUmpuVzN0T2N3dnJSN0dacHNPSFJNb0dGeWhxeU5xOFZXY1V4?=
 =?utf-8?B?Z1Z4U1V0NHd5SnIyT01sWjNFMU5tRkdraWt3azRKZmRrc0pmSW0rditqaVU5?=
 =?utf-8?B?eWFFY04yKzBkSmNQcW9Td2NqRHYvNTQwL0pMNDd3YVpyUnRUQ1dKS1BRTzNM?=
 =?utf-8?B?SGMvZmNrQXQ3TldPKzBHd2thNjMvMm9zczBNdFlldlhLbkVJRTQxWXV4TzNC?=
 =?utf-8?B?MzZCWVdOcHNFRDZFRlJGaDJVWG1ZT3pHUDA2dkhwaHhBeTBFYXlWNS9ueVNu?=
 =?utf-8?B?NEFCTmJqTkNJcGpTWDJXVjdzY0ZrQ1l6anorTFpNNUh5S1RRUHV2TTBrQldT?=
 =?utf-8?B?NjNtV005Qi9aemlIRFlhcVordjZCZTR6U3hzNXRsOUx1N0REdnlMd1AvZUM5?=
 =?utf-8?B?aWlPRDE2ekNhOVh5Ri96dFlNWjFHb2phMVlNbGlGN0hrdS93WWc2MitraDE5?=
 =?utf-8?B?Q25lUHNoT0pHdm1Fc05kN0RHNUkvVkdnM3FDaW9IMzJORnYrSG9iTzV1V2I1?=
 =?utf-8?Q?XGJy17RUSFPBC+LaT8w+FZA=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b87d72a1-fc67-40af-d141-08dc31304584
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 09:50:57.5379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YTpQ0ZG4gxs6tXfohcs/FemFzbOnxi7Zy4jhnXxPgDkmwnqaK6/xkd0G4LegWeq0Nccmm30AGq4P1uSaDOM7XBY426V6onzlPCU0eG7oN2ZgjEKfxzO9Q+3efMOFiXqO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9877
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

On 2/18/24 02:14, Kever Yang wrote:
> Hi Quentin,
> 
> On 2024/2/9 21:18, Quentin Schulz wrote:
>> From: Quentin Schulz<quentin.schulz@theobroma-systems.com>
>>
>> The STM32_RST line is routed to the ATtiny microcontroller
>> PA0/RESET/UPDI pin. By driving the PX30 SoC pin as GPIO output high, we
>> prevent external UPDI to be used for flashing without first putting this
>> pin as GPIO input, an extra step we could avoid in userspace.
> 
> A little confuse here, this GPIO is an output for PX30, right?So the 
> config is:
> 
> 1. the PX30 SPL init STM32_RST as input, with hardware pull-up the keep 
> STM32 work;
> 

The pin needs to be high for STM32, and high **but not driven** for 
ATtiny in order to allow flashing scripts to work.

> 2. when need UPDI for flashing, need to set STM32_RST to output and 
> trigger the reset in userspace?
> 

For STM32, STM32_RST needs to be driven low, then STM32_BOOT needs to be 
driven high, then STM32_RST needs to be high to deassert reset.

For ATtiny, STM32_RST needs to be NOT driven so that UPDI lines can be 
used to interact with the MCU. Note that we also have the ability to do 
bitbang UPDI on that STM32_RST pin but that's another topic (just 
explaining why it is routed while seemingly useless for ATtiny).

All the above is for entering the flashing mode.

However, in U-Boot we do NOT want to enter flashing mode, we want to 
exit it, c.f. 
https://lore.kernel.org/u-boot/20231103-ringneck-stm32-reset-v2-1-a0e5559f89bf@theobroma-systems.com/

An external HW pull-up is required because of glitches on the line when 
powering up/down. However, this is only done on newer versions of the 
PCB, so we need to tackle old versions.

The old versions do not have this external HW pull-up and the glitch may 
cause the MCU to enter its flashing mode. Therefore, we force it to exit 
the flashing mode by always hard resetting it into the normal runtime 
mode. This is what spl_board_init() does. STM32_RST and STM32_BOOT are 
controlled by our flashing script for the STM32 variant for the MCU, so 
the default state when entering the Linux kernel doesn't matter. For the 
ATtiny MCU variant, we do not handle those GPIOs as part of the flashing 
script, therefore the default state when entering the Linux kernel 
should be the expected value for which we can use UPDI to flash the 
ATtiny. For ATtiny, the reset line is shared between STM32_RST that goes 
to the SoC and the UPDI lines exposed over the Q7 header. If STM32_RST 
is driven by the SoC, the UPDI lines won't be able to interact with the 
MCU. Therefore it needs to be put into input mode, whether in U-Boot or 
in Linux userspace.



> 
>>
>> There's an external hardware pull-up strong enough to keep the STM32_RST
>> state high on ATtiny side but weak enough it can be overridden by
>> external UPDI. This also means it is safe to use for the STM32 variant,
>> where STM32_RST line will be in the same state as if output high was
>> used.
>>
>> The Q7 standard specifies that MFG_NC1 and MFG_NC2 (used for UPDI for
>> Ringneck) pins should neither be driven by the carrierboard, nor have
>> pull-up or pull-down resistors.
> 
> This sounds like it should use output and pull-none for these GPIOs?
> 

This would be a configuration for the Linux kernel DT, but we would 
still need some custom handling in U-Boot. What are you suggesting 
exactly with this?

Cheers,
Quentin
