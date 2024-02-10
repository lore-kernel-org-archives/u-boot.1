Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EBEC48260
	for <u-boot@archiver.kernel.org>; Sat, 10 Feb 2024 19:39:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3469487BA0;
	Sat, 10 Feb 2024 20:38:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="AL1Lqrxy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 802DB87C4C; Sat, 10 Feb 2024 20:38:58 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20EF2879F3
 for <u-boot@lists.denx.de>; Sat, 10 Feb 2024 20:38:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f576=JU=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1707593928;
 bh=ju1sxZnlWAf9Jl7Y2fqE8m8+aqT0rgYyC9nNdg4T1MY=;
 b=AL1LqrxyRBD61sT/PGFHONuW95femec+4JaGFnTzuAgtFk6uszm5tK99UY8iSTSNrw9kiAy0p
 /rYn33revribo3YrBh9BHYwy1kznhz+w61V3/6FnqnoZSAGfN5zVagxiyoOVEvXEPN4XQ6y22UU
 Zg99i5wxKcJpMtVdVbPEwtgFhQE3KZ0ixCSx4XvvpnbOOkDnD9bxYT5nz7td+pIV+srT0TtwvdB
 S+t2wWdy11i4f5EDIiHRRIhThhAtF6+b792O6Uyq8PY+YvMAH0j48n5ZVeNvmhlrZ4BLVGsgUJl
 AvTHpsFnsDE3UXZxHyF14Cg9PJAaFMRwQYvpECvVeBGQ==
Message-ID: <f0861b36-1a2f-42c3-8003-1499e185c54f@kwiboo.se>
Date: Sat, 10 Feb 2024 20:38:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/15] rockchip: rk3328-rock64: Enable boot from SPI NOR
 flash
Content-Language: en-US
To: Dragan Simic <dsimic@manjaro.org>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>, u-boot@lists.denx.de
References: <20240207000301.3270722-1-jonas@kwiboo.se>
 <20240207000301.3270722-15-jonas@kwiboo.se>
 <4cab520b0fa3c502a4c995ca236b87ee@manjaro.org>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <4cab520b0fa3c502a4c995ca236b87ee@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65c7d0c744c82cfa50b5db97
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

On 2024-02-10 19:31, Dragan Simic wrote:
> On 2024-02-07 01:02, Jonas Karlman wrote:
>> Add Kconfig options to enable support for booting from SPI NOR flash on
>> Pine64 Rock64.
>>
>> The generated bootable u-boot-rockchip-spi.bin that can be written to
>> 0x0 of SPI NOR flash. The FIT image is loaded from 0x60000, same as on
>> RK35xx boards.
>>
>>   => sf probe
>>   SF: Detected gd25q128 with page size 256 Bytes, erase size 4 KiB, 
>> total 16 MiB
>>
>>   => load mmc 1:1 10000000 u-boot-rockchip-spi.bin
>>   1359872 bytes read in 65 ms (20 MiB/s)
>>
>>   => sf update $fileaddr 0 $filesize
>>   device 0 offset 0x0, size 0x14c000
>>   1118208 bytes written, 241664 bytes skipped in 8.516s, speed 163516 
>> B/s
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> 
> Looking good to me.  I'm just not sure that we need to support multiple
> SPI chip brands, because I can't recall that the Rock64 has been shipped
> with different SPI chips, but perhaps better safe than sorry.

Main reason was that rock64 v3 does not come with a spi flash, and the
rock64 wiki link to datasheet for both gigadevice and winbond, and in
order to keep consistent with the orangepi r1 plus board that use
macronix in its schematics.

Regards,
Jonas

> 
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> 
>> ---
>>  configs/rock64-rk3328_defconfig | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/configs/rock64-rk3328_defconfig 
>> b/configs/rock64-rk3328_defconfig
>> index 0157a1efe374..01e447448513 100644
>> --- a/configs/rock64-rk3328_defconfig
>> +++ b/configs/rock64-rk3328_defconfig
>> @@ -13,6 +13,7 @@ CONFIG_DEFAULT_DEVICE_TREE="rk3328-rock64"
>>  CONFIG_DM_RESET=y
>>  CONFIG_ROCKCHIP_RK3328=y
>>  CONFIG_TPL_ROCKCHIP_COMMON_BOARD=y
>> +CONFIG_ROCKCHIP_SPI_IMAGE=y
>>  CONFIG_TPL_LIBCOMMON_SUPPORT=y
>>  CONFIG_TPL_LIBGENERIC_SUPPORT=y
>>  CONFIG_SPL_STACK_R_ADDR=0x600000
>> @@ -20,6 +21,8 @@ CONFIG_SPL_STACK=0x400000
>>  CONFIG_TPL_SYS_MALLOC_F_LEN=0x800
>>  CONFIG_DEBUG_UART_BASE=0xFF130000
>>  CONFIG_DEBUG_UART_CLOCK=24000000
>> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
>> +CONFIG_SPL_SPI=y
>>  CONFIG_SYS_LOAD_ADDR=0x800800
>>  CONFIG_DEBUG_UART=y
>>  # CONFIG_ANDROID_BOOT_IMAGE is not set
>> @@ -42,6 +45,8 @@ CONFIG_SPL_BSS_MAX_SIZE=0x2000
>>  CONFIG_SPL_STACK_R=y
>>  CONFIG_SPL_I2C=y
>>  CONFIG_SPL_POWER=y
>> +CONFIG_SPL_SPI_LOAD=y
>> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
>>  CONFIG_SPL_ATF=y
>>  CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
>>  CONFIG_TPL_SYS_MALLOC_SIMPLE=y
>> @@ -76,7 +81,10 @@ CONFIG_MISC=y
>>  CONFIG_ROCKCHIP_EFUSE=y
>>  CONFIG_MMC_DW=y
>>  CONFIG_MMC_DW_ROCKCHIP=y
>> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
>>  CONFIG_SPI_FLASH_GIGADEVICE=y
>> +CONFIG_SPI_FLASH_MACRONIX=y
>> +CONFIG_SPI_FLASH_WINBOND=y
>>  CONFIG_PHY_REALTEK=y
>>  CONFIG_DM_ETH_PHY=y
>>  CONFIG_ETH_DESIGNWARE=y

