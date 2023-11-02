Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82173C4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 07:27:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7A1E87657;
	Thu,  2 Nov 2023 08:27:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="AaZSSW1f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CF9187678; Thu,  2 Nov 2023 08:27:34 +0100 (CET)
Received: from mail-m49228.qiye.163.com (mail-m49228.qiye.163.com
 [45.254.49.228])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02DBA87650
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 08:27:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=AaZSSW1faYmvgO/26hgYPjDChIyHpueLqDX7XO1M7pMQTRwLevi/GsEQbT1OpkgVXHEThGV/9biDJb7zZHKUg0ppHpFjhGYpZYBzbIhRPdqHB7nG7W8CsZUf7iKdk4YIQJuvcGeRO0jgqPqlVaXz+h/gs706tEiPUfEoZx6d9R0=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=D8z6XLOT26/YAvV/Mo97y6G2gLDuycTW3mjFOc5W820=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 2DAE3400381;
 Thu,  2 Nov 2023 15:27:01 +0800 (CST)
Message-ID: <f8152606-c139-4fc4-a4ac-e12b11b30608@rock-chips.com>
Date: Thu, 2 Nov 2023 15:27:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rockchip: rk3588: Add SPINAND as boot device
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Slawomir Stepien <sst@poczta.fm>
Cc: philipp.tomsich@vrull.eu, sjg@chromium.org, u-boot@lists.denx.de
References: <20231031161327.1104885-1-sst@poczta.fm>
 <775cde64-e33d-48e8-907f-6dbc611a3a50@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <775cde64-e33d-48e8-907f-6dbc611a3a50@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU0YHVZMHkxKQh9OHUhMHUNVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8b8eeda7572eb3kusn2dae3400381
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PTY6HBw*TTw5IRgCGQ0tKCsM
 DTlPCyFVSlVKTUJDQkpLS0lJSk9IVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTE5NNwY+
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

On 2023/11/1 00:45, Jonas Karlman wrote:
> On 2023-10-31 17:13, Slawomir Stepien wrote:
>> Mark the flash@0 as BROM_BOOTSOURCE_SPINAND.
>> Fixes use of same-as-spl in u-boot,spl-boot-order prop on Orange Pi 5
>> Plus.
>>
>> Signed-off-by: Slawomir Stepien <sst@poczta.fm>
>> ---
>>   arch/arm/mach-rockchip/rk3588/rk3588.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
>> index b1f535fad5..0c8f10a97c 100644
>> --- a/arch/arm/mach-rockchip/rk3588/rk3588.c
>> +++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
>> @@ -42,6 +42,7 @@ const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>>   	[BROM_BOOTSOURCE_SPINOR] = "/spi@fe2b0000/flash@0",
>>   	[BROM_BOOTSOURCE_SD] = "/mmc@fe2c0000",
>>   	[BROM_BOOTSOURCE_SPINOR_RK3588] = "/spi@fe2b0000/flash@0",
>> +	[BROM_BOOTSOURCE_SPINAND] = "/spi@fe2b0000/flash@0",
> This is not correct, please see [1] for an open discussion on this issue.
>
> Kever: Do you have any more insights into the question on [1].

As I reply in another mail, the FSPI M0~M2 is all the option for SPI 
NAND/NOR in rk3588.

Thanks,

- Kever

>
> Is my assessment about the value BootRom writes to bootsource reg
> correct, see [1]?
>
> - FSPI (M0): 3
> - FSPI (M1): 4
> - FSPI (M2): 6
>
> [1] https://lore.kernel.org/u-boot/b82c02c0-0a37-8553-f498-b03f85394d59@kwiboo.se/
>
> Regards,
> Jonas
>
>>   };
>>   
>>   static struct mm_region rk3588_mem_map[] = {
