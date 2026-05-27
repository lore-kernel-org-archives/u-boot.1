Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787A6CD5BD5
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 13:41:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DC4F839A8;
	Wed, 27 May 2026 15:41:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="SxZwOolO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02EE584671; Wed, 27 May 2026 15:40:59 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20B6A803C6
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 15:40:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tf2k2Dg9UxiIOjKd6w9onJgOXyIRwV/As7yAiBjv55iZyF/GFIlVemSZIKi+9TJLSF8obsv8HAzlKyXwQh3WFk1J/pGe8eIkB82lGQl2iNmmjrsH0u1jY+VkD48Vd/fXrHiowLmhICKwIc/LRG0PY30eTryugdUOQUuRlAW0wcHSyEFUmstXPzXPwHvwKXpG752zFxnP5F3lbax5BALpwFDYDM4DfpzThXjkTby/bYfDIXnJ7x33+2kkwvogX5QuzP6+Fs8hkMgYwED6JEL2tz/P4yHld6fLwhTEAfYDcmE7BVg46/I0E1SR/58vJ06ElKlgl+DOGwqaBIrkeZE/3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0n0oBa56SAs5C1fB2rYyYJ2pkU8+8DH/QRft8iUQk4w=;
 b=BeNeLBAFa/nM65WAHdJ5R9S80gh51PB4cpju1vAmdJpcyx876Qpdp7aLvVQpMovKhKlQVh+9qWipqQ2RjdxuvDtQmVky18QwqfX4B9Y/RABTqVch+nORHt/YUo1BShtURRnp2cGT4o8F+DEc/GWWkBq/whJaHaNYEF3J7845VcXLE29af3zBWylwKHGzP65bKBkobwB8MFp8sXgken1B+0LEARtKYGCfKuCT8Qp7Sq57RczHxZWh1/2/le7KBSejmtkti7TLslcz0iKsLXv/+52EItIZTHR4PguAt3uRcAdH12wwGFeOoH1j1Kd/QubyfhRDwWH9wYOLjSvhaxNgeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0n0oBa56SAs5C1fB2rYyYJ2pkU8+8DH/QRft8iUQk4w=;
 b=SxZwOolOBW6p3yqvxhH10K7k1bVOfkVtiSmX07W7B7ecZ05lXTE/isL5sMHcS1vhrHANM2q1IiXevO6zpCYHOAGn4ljp6V4Fxx+ybf3sF0Faq8/tRANLE7wzGAVHTlya6F9ayn9Evq+bsb/0Zsll/BX8Hg26h675zXTwbV6kmNlq0plFZdQ6z7/IoRUWhs9m5qL5wLydC17kBECehcrhTYINy2wAUybx7kvHM4PBiz5bSDr4IoHLSBVnLJ+U/MHS823/MXTbQ773d/1rnfeZ70Nnfhnmm729utpNxmPP+Wf55afUo6IUL7hn6XsvfYOCd9n8q8CP3JQeD0HLnz3N6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by DS0PR03MB989261.namprd03.prod.outlook.com (2603:10b6:8:392::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 13:40:53 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%6]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 13:40:53 +0000
Message-ID: <7bd8dcbb-c1fc-4d0f-9678-b7b638d9aff4@altera.com>
Date: Wed, 27 May 2026 19:10:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] mtd: spi: enable spi_nor_remove() in soft reset
 config
To: Guodong Xu <guodong@riscstar.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, u-boot@lists.denx.de,
 u-boot-spacemit@groups.io
Cc: Vignesh R <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Huan Zhou <pericycle.cc@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, Yao Zi <me@ziyao.cc>,
 Anis Chali <chalianis1@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Sean Anderson <sean.anderson@linux.dev>, Heiko Schocher <hs@nabladev.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Philip Molloy <philip.molloy@analog.com>,
 Michal Simek <michal.simek@amd.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Eoin Dickson <eoin.dickson@microchip.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Guodong Xu <guodong.xu@riscstar.com>, Rui Miguel Silva <rui.silva@linaro.org>
References: <20260520-b4-k1-spl-pinctrl-spinor-v2-0-8d25db98ac8e@riscstar.com>
 <20260520-b4-k1-spl-pinctrl-spinor-v2-2-8d25db98ac8e@riscstar.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20260520-b4-k1-spl-pinctrl-spinor-v2-2-8d25db98ac8e@riscstar.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0226.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b4::11) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|DS0PR03MB989261:EE_
X-MS-Office365-Filtering-Correlation-Id: 35491e9d-309f-4803-817c-08debbf59248
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|22082099003|18002099003|55112099003|4143699003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: xr019OXkfZo/FcjklrcC//dUcXhZmiD40BlRs/t0bq9h4gn6eEoKQ0G8CJJJ85dOGYhAZAFlm8cfd5nEchvOZTp/gi/+J6+BuksEurJdlyp+FhOlQ5yOn0HYlukYbnz10PZu7AdUoMzvgB6BHrwVIGe76GvQgZMwHPhCxCJqI9I0KX3AZ+bwTcAp0oWNeow8We02B88PywH6fq6uees7acWRKm2M6QeLXgFv9vTZ4hSF+DeYc3YBtuN00lXOO8FAoPX2pAG98b4Ptp3CpMooSGk9o1b99A2P0RyOyYPVW7dqLwo6t7To0mrHIVXoeUCL0svXCSQafnnsN8IP5z2bIjxqW6ZAunSJPtUYOBrh93RLJp0MdVCzuV62mukVi399sB4Bi/jzcK2t0wwTS35HxYulHj+H0YQyq+RSXTUfGMqo+vfEbvNvW5M0guS48Jyw+L8kaBvQmEDbOk1M7Mu1OI3Cbi3aDVveVZzpCUjpvtBgYHPih24eTQDK10xPY9OZaMTwUvcwnQNTJiJu0h1+JZroLR5iInpZt4zyWOXi8kgDEn7MgaA3vj15BtQiLJMYNtxv3T1vwWkF5Yv3YjEk+mJ4dT96pqnYoID1dqx71fnrKRF8MvEgJp/rQjqmRlshxaJeUZ8cAj1MXuCw1+IGIp7Ao2Cz5MPNd1j4iKJf9miXZBD6ekQUHrcFa/EaDWwR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(22082099003)(18002099003)(55112099003)(4143699003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2Jka3hTNGltdDN3VGU4ak4vWW1TL0U2anJsUCtnU1BFcGNRbGg1YU5SQjFs?=
 =?utf-8?B?WGtTK0lFeUJ3NS9oSkNxSDk1ZHVvREsrS0VYK25TbUk5VCtwd0cyb1NzZXR4?=
 =?utf-8?B?d2VKMVIweG4xM0ExK2g3L2VRb0VYck5XdW82aFpuREsrTEdUVmMrUUVURW1v?=
 =?utf-8?B?ZjN4cVJVZ04wYTc5V2ozdFZoTEpOMHRZRk11WWNzekpwMU5GS0wzbEU5VnF3?=
 =?utf-8?B?T0xNVllnN2xzWXBDQjJsMUs2UjVIVGllYUlPb2dCa3VnaUxWTXA0TkJDUndG?=
 =?utf-8?B?ZmQzTVBsd0NVemFweUl4aUdJeHRMaG5VM3hYT01zenIyV0lKdVp4MVRGUkpW?=
 =?utf-8?B?RnRhR25USml0cHNxR3pOZThUM09ibHBXYi9GRHJRZm42UEI2OXJRNUdNTWM5?=
 =?utf-8?B?QjZWbDNUMjg0RGhWTU1DZXVZV0YyNVVpOXVrMnJIZmorbUdmU0ROSGxEUHgz?=
 =?utf-8?B?dTFzNE5rZ2trRUJ5R2lKbzdCM1RRd2FaUFdmQ25ZNFZQZDdsV3FmNDBZTkFP?=
 =?utf-8?B?ZGN4TURrRjlxaEl4MEZzTEIvQzF2NVU3Uzl4TGlLMGhIYndqZ0N4aHVPZjFt?=
 =?utf-8?B?ZDQyZTd2MEJ1OFFmWjVyR3F6R0xDOHVVSmVXRUhQdEQwMmNLcjFaTzJJY0s5?=
 =?utf-8?B?R3QxcGNUYXEzZUhpYmU1UUl0dERJUU82UThkQzRWVXY2Ry9may9sbWFhMnhF?=
 =?utf-8?B?bGQrSFRVMmdhMGNHY3llRWkrM2d2aktvTmlxdFFIcDJhZGRTVkpERC9HaTNX?=
 =?utf-8?B?blhWNGpxUlRxVXZMWTFiVFg4VW1kRktSL2VmMXpOczA1OW11ZDE2NEdrNjVL?=
 =?utf-8?B?Ny9uNDEvcml4MHBEUTFJY0FpQ014NGpSUFNKY09LWjBSUFhGYXBOUGZnUUpJ?=
 =?utf-8?B?SEJNeUVJVnhTeTJCbW00c2VuQUVrZFRKNXhMUUc3MjFnZVVKQjNSeXZNR08v?=
 =?utf-8?B?YUh0eEZtc25HNUhkOS83RGs5M1JVZi9id0NMZGhuMmdkNGJSS285WlRFSFhB?=
 =?utf-8?B?SUZWL3lzSE1PbmdHL09oQ2EyTXcyRXdMSmhsSU0wNkVFL21IRTdlSlFNTnBF?=
 =?utf-8?B?TUYzVEY4RlpwaThndW1WWjQ2QVh2TWZ6U3VYSFVlTCtXYStxVWFJbEkrYW9V?=
 =?utf-8?B?NkFiUHpETkJvdFdBeEdibzgvVkFlSi9lWnhqNWxJMGl5RVlRaWFES0hCVmNk?=
 =?utf-8?B?MEhEdkRQdm4wNGlpbEhPQXJqVXVxQ3ZyVHgxWW9UMkJ6ekhVYVB0UWx3ellI?=
 =?utf-8?B?Sm9vWEZTT05WdjZ3VWE1YUh2aGxZa3paWnRneksyRGNUZVEwNkRLbEcyWWVt?=
 =?utf-8?B?OVIzU0hGSjB0SHpxQTlUTVBubHFwY3lNMjlwZXBBcDVzeXUvOXROZElDRU50?=
 =?utf-8?B?enFDSThobkZ5eW9wclkvV3ZwVlVyOUNtMDQ4aUpPMlRBUzJhcXg4blBPTzlN?=
 =?utf-8?B?dHJOcnkvVXpQTWM3enBSMURZRHBMSUU4ZFVjNG0rS3F5ZFkrejJ4bzk0V2Qx?=
 =?utf-8?B?MjNhM2JkT1B1ZzlSejI5Sm5FQUlDa0ZuZzc3V0VzQVYybW1hR09NY01UVzJF?=
 =?utf-8?B?cVAvdFBKTC9NQzVSNE5CU0xDUWMxUkFENHRvWitiSXgzczU4VG9Eb3Bnakhu?=
 =?utf-8?B?KytUVWZMSkVxdjc5Yjk2ZU9xWnBOMXhQNkhqVCtFcUlCT3V3MS9tWmpmMUk4?=
 =?utf-8?B?YlpWdFJGK3hRSFdiZkxzY05wWDhZV0ZZNkFlS2U4MVBFclpZT1lzbEN5RmJI?=
 =?utf-8?B?M2FtSm9rRCtuUE9jcW5RN05BWVJhd24wL0szeHdTUnN5K3YxMXJrQXRlMDRs?=
 =?utf-8?B?NlJHQWNLcDVDSmVIdkg2WUZVajZZYUpiSzEvOVN1T2hJeS9CaFIrV0NpZDYz?=
 =?utf-8?B?ZFl2dkF2Z3BUbDk5UXhYeXFBRUpSeDdzaE54b0xTUGNhaVU1ZmhzSkM1SEo2?=
 =?utf-8?B?MS9TMWhYczFzc01WTzZPbHFOaEdaa1o0U0xxRFJ2azFSYnRneW5NNW9KS2oy?=
 =?utf-8?B?RS9ydE9rSzVzMnE0dkFSeFkvSU1Tc3RBWFdPdkltMEN6a09CU3l6WjA1Tmxl?=
 =?utf-8?B?ZWpoMmF3ejdFdVJWTmliWjdVVUx6c2xuZ3N0RUNORGUxL2Q5M3dVaWhuaVUv?=
 =?utf-8?B?dHkrVS9pTk82SFZiZkNsY2d2WHgybjRyeEVJOXlrOUxYT29QQ2VoWTk3T1Qr?=
 =?utf-8?B?UEwxTnh4NUZ1R0RaaGttNHZ3RUFNZDNYODM2dFFBZTJkaStmYVphak5mTHVB?=
 =?utf-8?B?R0QwMlUxOHdSVUNtZTd5VUZpWWpKcWJrOHlyZlJuendvMzBaZUxZSEhxcWwz?=
 =?utf-8?B?SzNYbmxIUTR3dHg2SFlZNkRhMXVnZGY0Vk9OZkY3MGNMZkh4QXd3NkMydzFR?=
 =?utf-8?Q?tjPkpRAmFu7SFx2U=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35491e9d-309f-4803-817c-08debbf59248
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 13:40:53.2156 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +azf1ULXIJbA+hq8eLX1xeL6FCM5N/+erMp6C5r/ML+Jurl+7Jj4MqvzO6mhsfsPKdVQpGwHVeFgfNeEbJw/pKIsGbIQ3REol5dbpMCjHnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB989261
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


On 5/20/2026 4:15 PM, Guodong Xu wrote:
> From: Raymond Mao <raymond.mao@riscstar.com>
>
> spi_nor_remove() is only implemented in spi-nor-core.o, not spi-nor-tiny.o.
>
> So make spi_nor_remove() only valid for CONFIG_SPI_FLASH_SOFT_RESET.
>
> Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
>
> ---
> v2:
> - No change.
> ---
>   drivers/mtd/spi/sf_probe.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mtd/spi/sf_probe.c b/drivers/mtd/spi/sf_probe.c
> index 7100b64bf22..dee03662d45 100644
> --- a/drivers/mtd/spi/sf_probe.c
> +++ b/drivers/mtd/spi/sf_probe.c
> @@ -229,9 +229,11 @@ static int spi_flash_std_remove(struct udevice *dev)
>   		spi_mem_dirmap_destroy(flash->dirmap.rdesc);
>   	}
>   
> -	ret = spi_nor_remove(flash);
> -	if (ret)
> -		return ret;
> +	if (CONFIG_IS_ENABLED(SPI_FLASH_SOFT_RESET)) {
> +		ret = spi_nor_remove(flash);
> +		if (ret)
> +			return ret;
> +	}
>   
>   	if (CONFIG_IS_ENABLED(SPI_FLASH_MTD))
>   		spi_flash_mtd_unregister(flash);

The tiny configuration is already handled by the inline stub in spi-nor.h,
where spi_nor_remove() is a no-op for SPI_FLASH_TINY. So I think adding a
SPI_FLASH_SOFT_RESET guard around the remove call does not provide
additional value.

