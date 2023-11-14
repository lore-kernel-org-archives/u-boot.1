Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEBCC4167D
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 14:06:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57CDD8716E;
	Tue, 14 Nov 2023 15:06:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="SkJG+QVO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CB3C871C3; Tue, 14 Nov 2023 15:06:50 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1a::60d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82AE4870F5
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 15:06:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTt1frzKIxPm8IgnK8UBsRpMyNggIlas/HEi7JPGxCNVOKSTx/DtPBWBbNns0zhN7tXvOqX4cgyLowJgafwek7xjiV1t7eumwike3lSFkcOZo1dNXU6W0dMWdtiMyByxn0Hn0NrIek6jLAQ7PxnC3/A5Ysr9f4gDVSwF+f/H2wp3dh9J+Tc40pmRA3mSMe4gS4zoke/iz2YTHqDZOEuPaIfuPHcusiKsYuJZNgC/ep9hqLjnSpEUwBiXGGPh7vigW5oyC8oOviv4uMHFdUd/0FpnkMo1QVo8zr5ZsRfROBSPQXM6vt01hm6UBkxVqRk8hoD6uqpqXlouVbRnfQmSlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYkYxPZbUr69vdlFF6eLndQQWMOXxJ6KotbH1Za2lgk=;
 b=TRPZmC9LcYfeXDJmnUbgGYD0q3MAWnL1Hzn/LzXZOlJWkTsqaGUQbf1ZUJizil7VTSz5iDL4hHdWbVYDCWAWlFrbnbBK01vIBJkVoDVmOEfvEQ3QLMUPTwjK5uD8FEVTE2vYjTbxLZIsXN4VCd8kAFZ4Gne7ENgLu0xFf0xfsTniAUp0ZLkqg8cuq82Jganz56Oy6/oVmrQk1HFm9EDBulbAQfR5GJT0omxdYDwk75ox80eXVZ7e62qNbYbOLtcKVyTg4QLMa16MZ0k2NL4vmy/Sb5GL5Evk66MwYb2hgLLuXh1mz6k8gbaLCyWqPTJMycc7EylMd39NEFLSbFY91A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYkYxPZbUr69vdlFF6eLndQQWMOXxJ6KotbH1Za2lgk=;
 b=SkJG+QVOkBsOHmfAkL5ScYmELSyk99IeyaUMBh4B45FedOl6R99ffsbuKHHnUZ87c1h36FDDYBnMK0Mqt7/FsYWEFhjx327qo8mLaesi/8jZ9d5Dl7nxa3yy41rt8Xe/8EusDc5rU8SYj3exQQAB1uiJBALBSPFGyxqhFOciFkv/mNV+GPIjRZ/YRJaeNUFurGMp1NZerWqXtxUdY2BhgYutgUUiR50dfcNXVkNcPUZyl8NkWpjhLviCyiI8vGe5VUAn6ecO3niNL0/LN0GpdweWlnZkCQJqkI2UtbDiYEI+dSpWqCJ3uZMwMI5UEKXlGvoUtYWeNSwSLQavPk63DA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AM9PR04MB8508.eurprd04.prod.outlook.com (2603:10a6:20b:433::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 14:06:45 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::8853:974d:615:508]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::8853:974d:615:508%6]) with mapi id 15.20.7002.015; Tue, 14 Nov 2023
 14:06:45 +0000
Message-ID: <561f7d8a-bf46-4ba7-a353-b5d3dfab95b0@theobroma-systems.com>
Date: Tue, 14 Nov 2023 15:06:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] rockchip: rk3588: Fix boot from SPI flash
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Eugen Hristev <eugen.hristev@collabora.com>
Cc: John Clark <inindev@gmail.com>, Slawomir Stepien <sst@poczta.fm>,
 u-boot@lists.denx.de
References: <20231112102705.1180714-1-jonas@kwiboo.se>
 <20231112102705.1180714-2-jonas@kwiboo.se>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20231112102705.1180714-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::19) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AM9PR04MB8508:EE_
X-MS-Office365-Filtering-Correlation-Id: cc4005d6-b8ee-4586-999a-08dbe51aef94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5NFLh+BHRHOnzvPcdXaO3NG6CWD/bTojg6qERDQgClsydV7CtRIFDKGlK1WJBYAtEOrK+4s8jVlw2x9cq3BOJ88Hhn0z6L7RP15XAbheRqMXb0y3uDuZRUzm/5IF1ULjW8c40AK1PqQTnPlZe34OXFT7flLEYQe76OwqP8YRLQ0qw7LNIx1YGBgU96rRzun4UlA8cP3vIO04XHtWPd7aXAmlEM7UddhdoUq3J69evJy40nNUWE5PelnF5uT2cCofpQD6cOjay1Zz0IVKWPxCZr17yC2/riKUcPTR8+OKENJhQ/ILeSHvrMj6jjgUn4dOXABDhwt3FIDLAnV9yfL6HqpFth3SwAvTg5ZiTr8Ka1yUZrzhBsAt0swVYjONuYhJncKBAfCAIo8d0GaLk/ssJVh5tiIgodW2j5wRrh243Uyrx95TwlD3Qc8GeFWgtG7UxIyLvLDo1sZ+P/tRpSUpDYhxIIqY/XiCL9GwkOGr+sd23h+cbP+53j+blVA30VxRSIZVJK+gFbbeP6Q76/HHy8+TB55HbhE4WtNoWqlBXU7T0XDiIRzHYJesbCMDVgPBA7bDSnuHOoNMMObrsXu/aIXwU15SZom40xjNzVyRFJZG+ySW4k3ODgStGdCRVvT0KnNKFfhyc1tlQH0XdjUg4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(136003)(346002)(39850400004)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(31686004)(6506007)(53546011)(478600001)(83380400001)(38100700002)(8676002)(2616005)(6512007)(2906002)(41300700001)(5660300002)(31696002)(36756003)(8936002)(86362001)(44832011)(66556008)(54906003)(66946007)(66476007)(4326008)(110136005)(316002)(26005)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHNQOTdHdmNsK3BkMUxaZm51M1hKWS9rN2VMdVlrQ3dHZ1lvanJ1QzJkNEh4?=
 =?utf-8?B?MGNKckhLQU0yMU9SckR4bGdNWkhJQURVbW95WEE1dWQ5YWJWaERmK0FQWURa?=
 =?utf-8?B?YTFyNU1meEtMaHBSK1hjWmtya1NwQzVJaU9hLzVHckd1Yjd2b09acHVMNFFT?=
 =?utf-8?B?ZE00emV6UXIzSUk3YUFBQ2VIQzFTZFh2dU5ZdTJ5NEtlUWNTTXU5c3ZjaGJi?=
 =?utf-8?B?QUp3MUVoUHhkOXB5VmxNQVpUajI2TitsdWJXSVQ4MEVDYVFZd20rWWlRQjZs?=
 =?utf-8?B?QzMxMy9TU2QrK0xWa2Jyc0p2V0diV3hFRTk2NkloTGUrUzJHQnArS0VEbDg5?=
 =?utf-8?B?N0VpNUpzSlY0V0tBTE5Ocnh3eEhxZlA0bG1IVithVmVEMlhITkEwbDRwbElJ?=
 =?utf-8?B?RFczckwzSjgreUowdUhrRTJWVjYxUFMyK2RRRmh1ZXdUN3VGaFQwSk9LVHNN?=
 =?utf-8?B?YUR2NE9XWnRlLzNXWVdpVEN1NW4xUmlabTFBNG5yUEdJOTA0S1NnenBVbnFr?=
 =?utf-8?B?NXc3RVJCTTdvUG1vT2hPZzRqTnJzQ3dsRnRRT3doYjVZeDBwcE9MeE8xUjY5?=
 =?utf-8?B?dlFYK214d0RGdGpQRHlxNGZBeS9QMEJWWGR1dkpBQjhXZHhGK1hsa1FkWENC?=
 =?utf-8?B?WEVNdDdWSmJmY0lndnJLT0M2T0pTRFhkSWZGSlJLQlZBbnRjS2J2T0ZjSVBH?=
 =?utf-8?B?NDFxSzY4ak1HNFNJUmJFaW9wV0orTS8rdXFNZTJ6aml4R01lWGVLL0xPanVV?=
 =?utf-8?B?YzUxQTNySlo0TTZkSTF0dkZsZ0I3ODhQb0FiNzFFdnp1TzRXZ2dybGJkZUZ1?=
 =?utf-8?B?RHJaWUxpOWVOdUx0VVl6c1p4M2NvT3hmRGgwT3ZLRFJLVmVWUVdCMmsyZldq?=
 =?utf-8?B?OE5tSm9zNlFDRWxWaFZ4QVVkVlVvWjZ0QUlLR0wyVERDdDlvSXFuN29pMWdv?=
 =?utf-8?B?c21HUnF3eE1rOHpNR3R0U2kyYWVVaGlFV0I4Yis4T2s1M25LazZqaHRmS09K?=
 =?utf-8?B?MXJTWEpQWGRCbzZIaU41emw4WHE2RFIyemcxVFpVZGtJbGJDKysrV0RQRU1K?=
 =?utf-8?B?S2pIUUhicW05Y0xGTUdtbjdkanV6TmFsT05VNFpvdkRTaDZoSFo5Y1VtNzNm?=
 =?utf-8?B?TzNxNkZKZTJDdllCSlVKak9pV2xRRVRWeTNFd1VpS0l4VkRWTnhQSWtERDhR?=
 =?utf-8?B?aFJJRDhXVFVva012bzkvQ1pmdEZIb3Q3YVBKdXcxQ0xWaEs1eGpsQXQrbHRR?=
 =?utf-8?B?OUlTNnR2TWJwcHR5R3QxSmJwZC9udFBzTUJ2dHNGQm1TV2RaQllBTXNGWUNo?=
 =?utf-8?B?YXlaTllaaUQ4MTkyWWdsT1lwcmRQNTYxa1JpT0g3WVRwOXhoTStoRjJKNXZo?=
 =?utf-8?B?UjRROWRVc2pHTnVzMkNSVHRicnNsRUg4RGRuZ3llUTNTK2VNV0FpVXZFMWxC?=
 =?utf-8?B?Y2xyajJMWktGWGFLNjdGdGZSWExLVFFabUIyZ2V2dW9VNzRrWFZsVnBCV1A4?=
 =?utf-8?B?WDk3SWhYcjdkV2hYdU1ma1VBbFdZbVJub04rY05mNlFjMGQzM05weU9sNk1T?=
 =?utf-8?B?ZWVFUTdVekxyaHlQWkdQZlZmVERaczhVcmVQS2xaMlUyMnRJNHVFUzYwNTVP?=
 =?utf-8?B?dzJqWnUvSmdla0NHOEorSzJ3OGJidUladXI0eFROSWFQM2hDbkxSbUlVYkhK?=
 =?utf-8?B?UXprQXQ2NUdlc0lSckdIUUpnTjVyeVFQcmUyYm5SMERRcWg2Vzdxb0dMRXpS?=
 =?utf-8?B?ZkF0UWIzTXRyTzdpam9BbHFsUjNzTENmQ2k1OXNmemZhRmNpa0V1eC9CQWFC?=
 =?utf-8?B?d1Q4UkYxQmN2YVQ5WFh1VmxBcmxNalIzREV2MkNtRklwNFZML3U5czVoR0xJ?=
 =?utf-8?B?Ujd1WkN4UW5wYTRQV2l6WkZyZC9OU0Rpa09vVVY1SjFmMk9MdlZCaDVpTkdK?=
 =?utf-8?B?cUl6eUdiTVg1Mzd4UjRVS3hSdGFpRnBIaHlBY1V6S0NTSFB4U2dONjduekRp?=
 =?utf-8?B?Qk1ZaDdscjRIcDcrbHp0bU95MHVqOE5GUEswVngzdTc4L2pKOUhkWThLNzFM?=
 =?utf-8?B?Zm9idjdVTDdad01UUS9JV1pQK1hZdnFhVmIzNllGMDlJNkFaVHJqWU5QMUdy?=
 =?utf-8?B?blhxMUc5cUljWTRlZmh1TGhERmxlNGpVdk5NRUYxWVM2bTh3K3FjZldEU29w?=
 =?utf-8?Q?ypIzpHNSaNqiymTneQ8aVfE=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4005d6-b8ee-4586-999a-08dbe51aef94
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 14:06:45.6239 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8qql/hcCUudPobK+89ugMvRQfXZwVejRYh32wOg2x68E/+qasF7BNmI4+cMLJrurm4IrzJQ+uX/x3Xer5GI0jlCnGjgkT+TApfoMI1Ck+QG3xkTtvBbH95CtTNw6F6iS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8508
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

On 11/12/23 11:26, Jonas Karlman wrote:
> The commit fd6e425be243 ("rockchip: rk3588-rock-5b: Enable boot from SPI
> NOR flash") added a new BROM_BOOTSOURCE_SPINOR_RK3588 with value 6.
> 
> At the time the reason for this new bootsource id value 6 was unknown.
> 
> We now know that the BootRom on RK3588 use different bootsource id
> values depending on the iomux used by the flash spi controller, and not
> by the type of spi nor or spi nand flash used.
> 
> Add the following defines and use them for RK3588 boot_devices.
> 
> - BROM_BOOTSOURCE_FSPI_M0 = 3
> - BROM_BOOTSOURCE_FSPI_M1 = 4
> - BROM_BOOTSOURCE_FSPI_M2 = 6
> 
> Fixes: fd6e425be243 ("rockchip: rk3588-rock-5b: Enable boot from SPI NOR flash")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   arch/arm/include/asm/arch-rockchip/bootrom.h | 4 +++-
>   arch/arm/mach-rockchip/rk3588/rk3588.c       | 5 +++--
>   2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/include/asm/arch-rockchip/bootrom.h b/arch/arm/include/asm/arch-rockchip/bootrom.h
> index 7dab18fbc3fb..f78337397d63 100644
> --- a/arch/arm/include/asm/arch-rockchip/bootrom.h
> +++ b/arch/arm/include/asm/arch-rockchip/bootrom.h
> @@ -47,8 +47,10 @@ enum {
>   	BROM_BOOTSOURCE_EMMC = 2,
>   	BROM_BOOTSOURCE_SPINOR = 3,
>   	BROM_BOOTSOURCE_SPINAND = 4,
> +	BROM_BOOTSOURCE_FSPI_M0 = 3,
> +	BROM_BOOTSOURCE_FSPI_M1 = 4,

I'm a bit wary of two pairs of enums sharing the same value, especially 
when we want to use them as offset in a static definition of an array.

Should we #ifdef it (meh) for RK3588?
Should we add a suffix like before for identifying RK3588-specific options?

At the very least explicit that those are RK3588-specific in a comment 
for both conflicts (the ones that apply to everything except RK3588 to 
say to use only for !RK3588, and the ones that apply to RK3588 only)?

Cheers,
Quentin
