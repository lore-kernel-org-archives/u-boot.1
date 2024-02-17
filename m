Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE74AC48BC3
	for <u-boot@archiver.kernel.org>; Sat, 17 Feb 2024 08:42:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DC6E87DCD;
	Sat, 17 Feb 2024 09:42:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="QryAQ77S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5216B87E07; Sat, 17 Feb 2024 09:42:17 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::62f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9E0487C9E
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 09:42:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWL/WUXN64wcwhI+3WKjwBZUo0P+/GFvMyDLd/Au7LEI+86ipYujZDqhEUrDd0uSBqJHXSTIf/xNaBHHc5/Ooj9F3kNX5o/CYoB9NwDzVqNJ5382tjAuP3baR5pHefUpjxUx+jsxQd6qr3a9X4o3kOvKwM56qBWl2RPxYnFH31vMtnXps7+TqiAUgMfUbD0xujPTk0d1E9mlWE/cGcAkzhcd0eorhbRpn0oHzxt3zSIgGcF9FYdxVmgkrDmuWv+bsLh1dLpls5UQe2CqYPdquUeOLFKP94HpncFdSJaKcUGeLgXhO5Zj2qp5d+bYHheZZatYXrheyCsd1e3BVC41AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+1GdQZl73ZR/ZlewsINasXsEA0bnf4D51ovdLWqiVk=;
 b=ZX+bQFV+t30PCQiG/cC412ML4BQbi+NYb6lacZ4narQgxgs+1R/OkPU9jRSD7zcfnUFmwTNGTfBxzQ0mi3fOugRzTvSZzJTmbZaOgTmncUQ2hXtjy4cBWZR328uoVGIqF8jo88jC5CmH4Cjkl0owu9ar6bra/yf1grxQzWeVZaGd86s3xHaZAJX3qjxYdZMMuMdD988CqweGle+HVi8eaOTNV46GkzAVOMm/HsYqCt2Hqn0WyY5Xb+6Hrl9NSL9oUfj87L22NbZqMzdSTnZ0sBDbxFJxZ3CANZ8I1H+kE5yfIV0/VU4OHb/DuqWqbMVr1j4eXyI3EYj/PciMCBjxHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+1GdQZl73ZR/ZlewsINasXsEA0bnf4D51ovdLWqiVk=;
 b=QryAQ77SApRvk9ClFCZRMij8ROpMr6TUAX6s8PMcFbZoEnHhjSVSwOrCkhL2wdZN8CyGkdAM6IPX4J+FYiXvIz4fdn38pVoDhcVf8q1agko++KmGibOhtrW5x0isgQPlF86/mXuoozocAA548tLee1bXkwMMgGWe3XxAfcY4Qu2EqVyp7zuf+gI0rdb/qQjPVyrNrs/b9JqS2ONtNK3SFN4O6BatHNXl5/ykcSV3aMduQpl4hUlcZY9FqFOqGoXuooXlLtc+RVfFcrvwvgOyUQnepaQDVG4UAs3HI6RGYMBH1/oR32jyRyV9tWZG+fW3key0C8Durm8F6Lrda8tYjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7388.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:460::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Sat, 17 Feb
 2024 08:42:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7292.029; Sat, 17 Feb 2024
 08:42:09 +0000
Message-ID: <e6222770-cbcd-45e2-94fe-eb55fb0a2f94@siemens.com>
Date: Sat, 17 Feb 2024 09:42:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 07/20] configs: am62x_evm_a53_defconfig: Switch to
 bootstd
Content-Language: en-US
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
 Nishanth Menon <nm@ti.com>, Neha Francis <n-francis@ti.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@google.com>
Cc: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Andreas Dannenberg <dannenberg@ti.com>,
 Romain Naour <romain.naour@smile.fr>
References: <20230825180305.69515-1-nm@ti.com>
 <20230825180305.69515-8-nm@ti.com>
 <87f154591fee4979570e78cbc8c73eb0a56469eb.camel@gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <87f154591fee4979570e78cbc8c73eb0a56469eb.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7388:EE_
X-MS-Office365-Filtering-Correlation-Id: 131af590-ea94-453c-fbd8-08dc2f945448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2r2JOK68JzXZzyzEbVrh3oVj2jDtt9TPgswPZfs4YHT6VatXqS44DOZZ/PF8j5unsrK+PqZbRn2p037YEnuqGt0u1eg/vrjqEmkpdeTYwNk4BRbcGvr0DFBpP5YUIDrp/0vlagM15B5FWRkyD58NDbQH5jmRbycvixG6HMKqndJHjSYHPxWkxoYnrmiQThnXToFyzdYO0jlPMXyMeGiUUDIUe947L5kpYJ2iPHek66PpVCd6jx+4Y7uj2PvWmHxJJcjmDXypPaYOOlAvP6qBPyw1heyy1h5JYgjBa6qmog6hG8F+XnPRuXdxHDVqGTSLjcPocIxyc7H1YWxAgNwXhH6GkBbvKlACCYA+7J+zaPp6/8WWzTt/MWNZ2MNsjJmXbC0lOmhxP1wWGcyDW1Z0TtcgkQCyYPW7PBN+hMY9J6VwcOT1iH7/WzhEZkM0Vyla1/8LaLuaT932IgHYoaDZfnH+H6spm3/nRz3Ld1AvPgx++Tpx9CC9aqZlZvzzDixuqlrDRhVjW79VffvoGaGOU6LUa/JUO6KKo5cJnX322vI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(396003)(366004)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(86362001)(66946007)(2906002)(44832011)(8936002)(5660300002)(66556008)(66476007)(8676002)(38100700002)(31696002)(82960400001)(4326008)(26005)(83380400001)(41300700001)(2616005)(316002)(36756003)(54906003)(110136005)(53546011)(478600001)(6512007)(6506007)(6486002)(966005)(31686004)(7416002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkpJWVRJZExSd3ViK0NXSXJDSm4rb1RhWVR6dnBLeTdDMW5ldTVIUnpOSFdX?=
 =?utf-8?B?MStPZXlLb3M0ZGk3TUZpV0V2Z2NhSFVvemsrakxreVl6WjdiZk5YeUgwaUpa?=
 =?utf-8?B?WEY0b2VxVFVWQ0RSaDI5WWdMR0hVQ0VRTy82Y09IYk1SYVdXYTJrYnVjQTJG?=
 =?utf-8?B?dmMvbVBVNHhCU2lJYWhWU3lIclFKTUN5VlU4SlhDamNZNzNCR0xpL2NJeUtX?=
 =?utf-8?B?UXU4QmFpaEFvd25BQUlYeFMrYTNHYUhtTFlBaHNGa0xRMGVjRW9mSW5yTUdi?=
 =?utf-8?B?MXhjWEVyR2h2NURBeG56NmpNT2JlNDFZN0lTS3lGM3VNWmJUSXcySWwra2FG?=
 =?utf-8?B?RXVmQTV2TEsyNUZIYlRoVkFISUtYZVJVOFJqUGdoQlNKL1k1bS9vOWtOVmlY?=
 =?utf-8?B?ckdpeXRUUVc1ZUZRUW9Md1ZWVzlBV0J6STBIOGVoTTZTNHc1TFh3WkRRSjFV?=
 =?utf-8?B?OC82OHVhM2w3NUJUcHczV0MwbGJweTh2ckdUMXBNYlkxaTY1bklYQlNXOG9D?=
 =?utf-8?B?SjFuNTBZcmlsK3NlOXJ6cnJnZ29nY0RWWkhFRmtJZExEampxVVpaTzE5emRu?=
 =?utf-8?B?eHl2alpnMkJ0ZnpocEpZQTNLdURaZ1VKTVBWWEtFYlczNGlsTlZxek1IeTRH?=
 =?utf-8?B?VHNqTlhvZzN3bXdCcVRMd2YvRHZ6WXZSeW9RT1lzYXkvdjhETFBUUUR3SUtR?=
 =?utf-8?B?NVRYb285NkNNUHRlWEd5a0d5UkF1NkJ6V2YxL3JvS3BtR1RnM3lWdnVrc2xu?=
 =?utf-8?B?QUNLYWNVSXdXdkp1WW9MclJYdDQvRFgrQXg2SFhnWUZaWStGVFpxK2ZlZDd1?=
 =?utf-8?B?ZXVsNTdGRkFwalUzWk5GRmpNNVltdFViOVpOZ09qbUVnSHFBMmI2RlpqNlVu?=
 =?utf-8?B?cURLZEg5OXBPajl4YSt4RzV2dEJoYk9JYzdhT0xmVDgrMjRFQWJFRGVWR2Rq?=
 =?utf-8?B?ck5WR00rUjFLWXM2WSs0dmVKeEtWYmxBMW9GZHdyZEhPd2N2TU03blFIcFFC?=
 =?utf-8?B?REJUV2tEY1AzaHppRE5ZWmJTL0hOdm13NURSTzNZRFpUTkF2YytkSHdIc3Ay?=
 =?utf-8?B?MzlhdTc0amVjejZwSDZEM1QzTGFENEQ0UlkwZFJMbWlxR0g2Q2JlMVora1Fr?=
 =?utf-8?B?MlNBTWFTSlozQWFRMVVYR2xxZWtRUzlqdU4zWFpOcHdXUHBoU2wxK2dlNnZm?=
 =?utf-8?B?NER2Vy8vcUdOVFhuaGtzcitBYk5vSFlLa1V3QnRyUmFSbmpEM21tVWxGcVNp?=
 =?utf-8?B?Rk5DYTBpNnRpdEF0WUtqRFNQeVdzS2MrbUpjNi9NSEFocnZsUmhUNkh0SDZl?=
 =?utf-8?B?RWtMckgyKzJ4ZWdQSHNibG5MelpDUlBSTXZReFZ0MXU4STI0Uk9CK1ZHSFFS?=
 =?utf-8?B?OXNYanNMZ3pLeGxTTTgzcUFXZ21KT2ZaTWxWMjlmMVF6VDNlVElqZUJjVVR5?=
 =?utf-8?B?RWk0QVZRTFVCS3FsRVRZN084UUpLTXFqc01aR2hoamU4MEEwYlUzM0ZBSmo2?=
 =?utf-8?B?N1EwdlpBNjRUdEZ0MW01bVEySXYxVzNVTmdiZHRWaUZNcmdQc01PZFh5U1VK?=
 =?utf-8?B?NkNZWHlZeWVOWHRPVjczU2FWd1FocnN1cENwTUgvbXRZNFhRUk1CZXZSdUtm?=
 =?utf-8?B?V1JrTEdPQm5LSDJGMmVWNGNRa3kzNHNaeUdRMnFsSGRmMWc2bUdtbEtWTXJW?=
 =?utf-8?B?cFhxSSsySWt0NzhQK2gxemptdCtlaEpDcVlMNjg0SDl1SDRRWHpXdFBaOGFZ?=
 =?utf-8?B?MVdtWUJpOW9Jc091K1RZQmFlYkhGbnlRWU1TeHVaSzl4RzBuSnhKa2V2Umpk?=
 =?utf-8?B?MUNFMVB4YzVwdTZiWUQ3WWFtYUlJdHpRbVJZN3o5a0Q3WlpaemtDa24yQ3Ez?=
 =?utf-8?B?Sm54OXlBNERnbG90VGh6aGJhdThQVy92QVYySEJCZzZUQjhlVVZhM1dwRWE2?=
 =?utf-8?B?VngrZXNTNzR2RmZmS0VvcGV3aUtOTkZKS2R5RVVNbmRJVTNYNWZRaVpGZzJG?=
 =?utf-8?B?VDltSnZjUkU4RFB3dmdOcWQ2aHRoZ091SlVBekNrcllOWktqbW4zU3hVZzNv?=
 =?utf-8?B?RVU4QUJwZURjcXZocktXSlkzT0JpYlBkdnBSRHk1aWE4aE0vTlM5R3NZOG5s?=
 =?utf-8?B?UytUcHFSK1AzRUNyRWtUY0dYWVdnUVh0OXdWTGtlVVZQekNJK212MEVSS0t0?=
 =?utf-8?B?RXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 131af590-ea94-453c-fbd8-08dc2f945448
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2024 08:42:09.6629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MqJRbPk9Ks8bXH4euhzGoSSH4+WYNK8ja95Qmll11DOlQqN0XvcRiuQ2HCrSQ2tbc6o7q/VAEWDakVWCfHO1BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7388
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

On 17.02.24 04:11, Alexander Sverdlin wrote:
> Hello Nishanth,
> 
> On Fri, 2023-08-25 at 13:02 -0500, Nishanth Menon wrote:
>> Switch to using bootstd. Note with this change, we will stop using
>> distro_bootcmd and instead depend entirely on bootflow method of
>> starting the system up.
>>
>> Suggested-by: Tom Rini <trini@konsulko.com>
>> Suggested-by: Simon Glass <sjg@chromium.org>
>> Reviewed-by: Tom Rini <trini@konsulko.com>
>> Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> Reviewed-by: Tom Rini <trini@konsulko.com>
>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> ---
>> No change other than picking up reviews, tested tags along the way.
>> V5: https://lore.kernel.org/r/20230824031101.3460411-6-nm@ti.com
>>  configs/am62x_evm_a53_defconfig | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defconfig
>> index d55caabe22c9..1807df8bbee9 100644
>> --- a/configs/am62x_evm_a53_defconfig
>> +++ b/configs/am62x_evm_a53_defconfig
>> @@ -28,8 +28,9 @@ CONFIG_SPL_SPI=y
>>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>>  CONFIG_SPL_LOAD_FIT=y
>>  CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
>> -CONFIG_DISTRO_DEFAULTS=y
>> -CONFIG_BOOTCOMMAND="run envboot; run distro_bootcmd;"
>> +CONFIG_BOOTSTD_FULL=y
>> +CONFIG_BOOTSTD_DEFAULTS=y
>> +CONFIG_BOOTCOMMAND="run envboot; bootflow scan -lb"
>>  CONFIG_SPL_MAX_SIZE=0x58000
>>  CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>>  CONFIG_SPL_BSS_START_ADDR=0x80c80000
> 
> could you please suggest which distro have you used for testing?
> 
> After U-Boot update to v2024.01 Buildroot is not booting any more:
> 
> ---
> U-Boot 2024.01 (Feb 15 2024 - 01:43:17 +0100)
> 
> SoC:   AM62X SR1.0 HS-FS
> Model: Texas Instruments AM625 SK
> DRAM:  2 GiB
> Core:  56 devices, 23 uclasses, devicetree: separate
> MMC:   mmc@fa10000: 0, mmc@fa00000: 1
> Loading Environment from nowhere... OK
> In:    serial@2800000
> Out:   serial@2800000
> Err:   serial@2800000
> Net:   eth0: ethernet@8000000port@1
> Hit any key to stop autoboot:  0 
> switch to partitions #0, OK
> mmc1 is current device
> SD/MMC found on device 1
> Failed to load 'uEnv.txt'
> Scanning for bootflows in all bootdevs
> Seq  Method       State   Uclass    Part  Name                      Filename
> ---  -----------  ------  --------  ----  ------------------------  ----------------
> Scanning global bootmeth 'efi_mgr':
> No EFI system partition
> No EFI system partition
> Failed to persist EFI variables
> Scanning bootdev 'mmc@fa00000.bootdev':
> Scanning bootdev 'mmc@fa10000.bootdev':
> Unknown uclass 'usb' in label
> link up on port 1, speed 100, full duplex
> BOOTP broadcast 1
> BOOTP broadcast 2
> BOOTP broadcast 3
> ...
> ---
> 
> I suppose TI's BSP has older U-Boot... So it's not providing necessary
> script for BOOTSTD, I suppose?
> 

You can make the BeagleBone boot via EFI, but it requires a hybrid
partition table (ROM loader want DOS, EFI needs GPT). A Debian
integration with this can be found for Isar [1] in this series [2]. It's
only using upstream sources (plus still one u-boot patch to get wifi
working).

If you want legacy script booting, I suspect you need to flip some extra
switches explicitly by now.

Jan

[1] https://github.com/ilbers/isar/
[2] https://patchwork.isar-build.org/project/isar/list/?series=1049

-- 
Siemens AG, Technology
Linux Expert Center

