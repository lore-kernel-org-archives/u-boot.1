Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A493DC4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 10:03:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5F7987191;
	Fri,  3 Nov 2023 11:03:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="FkuDONke";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67112871CE; Fri,  3 Nov 2023 11:03:18 +0100 (CET)
Received: from mail-m118196.ym.163.com (mail-m118196.ym.163.com
 [115.236.118.196])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7040687159
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 11:03:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=FkuDONkeAgQ/Bd2if1mJbRohv9WRCqygvEZMOiAP1ZcyV1gQfh2J0sKE71spIIiq4hJIPL2iqKWGHUPqczlmkZVFuRASdBkRWOJBd3EDJus8uK997O8ttHgkcbPnyhnKdF0Vc7op2kPj+jO1yU0KNvRlpfu9C4uSxGaZNOYbH/E=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=VbHeFnwZ0Qgg/b0uimZgXjQzjAU6s777T/n871Gmmqg=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 44DA94003F0;
 Fri,  3 Nov 2023 18:02:45 +0800 (CST)
Message-ID: <847b0073-0ac7-4eaf-905a-029ddc1e6639@rock-chips.com>
Date: Fri, 3 Nov 2023 18:02:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rockchip: rk3588: Add SPINAND as boot device
Content-Language: en-US
To: Slawomir Stepien <sst@poczta.fm>, Jonas Karlman <jonas@kwiboo.se>,
 =?UTF-8?B?6LW15Luq5bOw?= <zyf@rock-chips.com>
Cc: philipp.tomsich@vrull.eu, sjg@chromium.org, u-boot@lists.denx.de
References: <20231031161327.1104885-1-sst@poczta.fm>
 <775cde64-e33d-48e8-907f-6dbc611a3a50@kwiboo.se>
 <f8152606-c139-4fc4-a4ac-e12b11b30608@rock-chips.com>
 <ZUS-uMc7p8xHlISM@nr200>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <ZUS-uMc7p8xHlISM@nr200>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUpLSFZJSkhPSUtJQhpMSBpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8b94a297492eb3kusn44da94003f0
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MxQ6Ajo4Azw3CxwXOTkqNQ4o
 DTUwCUtVSlVKTUJCS0tOTE1NS05KVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOQk9JNwY+
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

Hi Slawomir,

On 2023/11/3 17:34, Slawomir Stepien wrote:
> Hi Jonas and Kever
>
> Thanks for clarifying the situation Kever! Please see below my proposition. What do you think?
>
> On lis 02, 2023 15:27, Kever Yang wrote:
>> Hi Jonas,
>>
>> On 2023/11/1 00:45, Jonas Karlman wrote:
>>> On 2023-10-31 17:13, Slawomir Stepien wrote:
>>>> Mark the flash@0 as BROM_BOOTSOURCE_SPINAND.
>>>> Fixes use of same-as-spl in u-boot,spl-boot-order prop on Orange Pi 5
>>>> Plus.
>>>>
>>>> Signed-off-by: Slawomir Stepien <sst@poczta.fm>
>>>> ---
>>>>    arch/arm/mach-rockchip/rk3588/rk3588.c | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
>>>> index b1f535fad5..0c8f10a97c 100644
>>>> --- a/arch/arm/mach-rockchip/rk3588/rk3588.c
>>>> +++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
>>>> @@ -42,6 +42,7 @@ const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>>>>    	[BROM_BOOTSOURCE_SPINOR] = "/spi@fe2b0000/flash@0",
>>>>    	[BROM_BOOTSOURCE_SD] = "/mmc@fe2c0000",
>>>>    	[BROM_BOOTSOURCE_SPINOR_RK3588] = "/spi@fe2b0000/flash@0",
>>>> +	[BROM_BOOTSOURCE_SPINAND] = "/spi@fe2b0000/flash@0",
>>> This is not correct, please see [1] for an open discussion on this issue.
>>>
>>> Kever: Do you have any more insights into the question on [1].
>> As I reply in another mail, the FSPI M0~M2 is all the option for SPI
>> NAND/NOR in rk3588.
> So based on that info, something like this?:
>
> 1. BROM_BOOTSOURCE_SPINAND - removed (not used at all).
> 2. BROM_BOOTSOURCE_SPINOR_RK3588 - removed (not needed after this patch).
> 3. Updated also the rk3568.c since it also has FSPI M0 (only this one mux), so I would assume it
> will be value of 3 there too.
> 4. The BROM_BOOTSOURCE_SPINOR is still there, since the rk3399 does not use the FSPI (that is my
> understanding after checking the TRM doc).

This change looks good to me, I think this can cover all the SPI/FSPI 
boot for all the rockchip SoCs currently.


Thanks,

- Kever

>
> diff --git a/arch/arm/include/asm/arch-rockchip/bootrom.h b/arch/arm/include/asm/arch-rockchip/bootrom.h
> index 7dab18fbc3..9f16d28aec 100644
> --- a/arch/arm/include/asm/arch-rockchip/bootrom.h
> +++ b/arch/arm/include/asm/arch-rockchip/bootrom.h
> @@ -46,9 +46,10 @@ enum {
>   	BROM_BOOTSOURCE_NAND = 1,
>   	BROM_BOOTSOURCE_EMMC = 2,
>   	BROM_BOOTSOURCE_SPINOR = 3,
> -	BROM_BOOTSOURCE_SPINAND = 4,
> +	BROM_BOOTSOURCE_FSPI_M0 = 3,
> +	BROM_BOOTSOURCE_FSPI_M1 = 4,
>   	BROM_BOOTSOURCE_SD = 5,
> -	BROM_BOOTSOURCE_SPINOR_RK3588 = 6,
> +	BROM_BOOTSOURCE_FSPI_M2 = 6,
>   	BROM_BOOTSOURCE_USB = 10,
>   	BROM_LAST_BOOTSOURCE = BROM_BOOTSOURCE_USB
>   };
> diff --git a/arch/arm/mach-rockchip/rk3568/rk3568.c b/arch/arm/mach-rockchip/rk3568/rk3568.c
> index 69ef19cc85..ccb63c6a88 100644
> --- a/arch/arm/mach-rockchip/rk3568/rk3568.c
> +++ b/arch/arm/mach-rockchip/rk3568/rk3568.c
> @@ -83,7 +83,7 @@ static struct mm_region rk3568_mem_map[] = {
>   
>   const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>   	[BROM_BOOTSOURCE_EMMC] = "/mmc@fe310000",
> -	[BROM_BOOTSOURCE_SPINOR] = "/spi@fe300000/flash@0",
> +	[BROM_BOOTSOURCE_FSPI_M0] = "/spi@fe300000/flash@0",
>   	[BROM_BOOTSOURCE_SD] = "/mmc@fe2b0000",
>   };
>   
> diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
> index b1f535fad5..c36f783d29 100644
> --- a/arch/arm/mach-rockchip/rk3588/rk3588.c
> +++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
> @@ -39,9 +39,10 @@ DECLARE_GLOBAL_DATA_PTR;
>   
>   const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>   	[BROM_BOOTSOURCE_EMMC] = "/mmc@fe2e0000",
> -	[BROM_BOOTSOURCE_SPINOR] = "/spi@fe2b0000/flash@0",
> +	[BROM_BOOTSOURCE_FSPI_M0] = "/spi@fe2b0000/flash@0",
>   	[BROM_BOOTSOURCE_SD] = "/mmc@fe2c0000",
> -	[BROM_BOOTSOURCE_SPINOR_RK3588] = "/spi@fe2b0000/flash@0",
> +	[BROM_BOOTSOURCE_FSPI_M1] = "/spi@fe2b0000/flash@0",
> +	[BROM_BOOTSOURCE_FSPI_M2] = "/spi@fe2b0000/flash@0",
>   };
>   
>   static struct mm_region rk3588_mem_map[] = {
>
>>> Is my assessment about the value BootRom writes to bootsource reg
>>> correct, see [1]?
>>>
>>> - FSPI (M0): 3
>>> - FSPI (M1): 4
>>> - FSPI (M2): 6
>>>
>>> [1] https://lore.kernel.org/u-boot/b82c02c0-0a37-8553-f498-b03f85394d59@kwiboo.se/
>>>
>>> Regards,
>>> Jonas
>>>
>>>>    };
>>>>    static struct mm_region rk3588_mem_map[] = {
