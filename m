Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E0B2C54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 09:52:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0277087F1E;
	Mon, 11 Mar 2024 10:52:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="kHsBgNWT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F21187F02; Mon, 11 Mar 2024 10:52:01 +0100 (CET)
Received: from mail-m12797.qiye.163.com (mail-m12797.qiye.163.com
 [115.236.127.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D518587F1E
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 10:51:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=kHsBgNWTy5Tf5wsoYOcUpf1YHgNjn0Bau73YZCPBhGceDxCHaU2igwBZiPueZFFnwyj96q9zREkI5GBw4qK7QgSy/wjT6pcAWtX4AgOnvU5V+XDJiQtcMfS7baqzywOJDMOtNFJ32Inkj6v0Q4vJH7P2mc5fIkLDYejB8j7cBkk=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=mZ7OWgYrK2nLfA9JGvQDWr2SQzZnWbNghw3jvI3NoHk=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id E720A90041A;
 Mon, 11 Mar 2024 17:51:45 +0800 (CST)
Message-ID: <521787c6-17c0-4510-a5f5-b67fc0aeb9e4@rock-chips.com>
Date: Mon, 11 Mar 2024 17:51:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] rockchip: rock-pi-4-rk3399: Enable booting from
 SPI flash
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>,
 Christopher Obbard <chris.obbard@collabora.com>, =?UTF-8?B?5p6X6byO5by6?=
 <jon.lin@rock-chips.com>
Cc: kernel@collabora.com, FUKAUMI Naoki <naoki@radxa.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20240302143417.164560-1-chris.obbard@collabora.com>
 <20240302143417.164560-3-chris.obbard@collabora.com>
 <abdd421f-49d3-4442-ab0a-0c2c143aa199@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <abdd421f-49d3-4442-ab0a-0c2c143aa199@kwiboo.se>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0wYS1ZOQklKSk4aHxgeT0pVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8e2cece53903a9kunme720a90041a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OjI6Pio6ETMWAjAYMwwQN0Ij
 QzUwFDFVSlVKTEpLSk5LTEtMS05DVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJS0tKQzcG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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


On 2024/3/2 23:28, Jonas Karlman wrote:
> Hi Christopher,
>
> On 2024-03-02 15:34, Christopher Obbard wrote:
>> Some variants of the ROCK Pi 4 series contain an SPI flash chip, which can
>> be booted from. This patch enables support in U-Boot for building the
>> image for the SPI flash, support for booting U-Boot from the SPI flash
>> chip and support in U-Boot for accessing the SPI flash using `sf` commands.
>>
>> Not all variants (e.g. ROCK Pi 4B, ROCK 4 Model C Plus, ROCK 4SE) come
>> populated with an SPI flash chip, but have the footprint on the board so
>> a user could solder their own to the board. With this patchset applied,
>> these board variants without an SPI flash chip still boot from MMC.
>>
>> I have enabled support for both Winbond and XTX SPI flash devices since
>> different hardware variants have different devices populated:
>>
>>   - `rockpi4_v13_sch_20181112.pdf` contains a Winbond part `W25Q64FWZPIG`
>>   - `rockpi4_v14_sch_20210114.pdf` contains an XTX part `XT25F32BWOIGT`
>>
>> The ROCK Pi 4 I have is marked as "ROCK PI 4 v1.48" and contains an SPI
>> flash chip from XTX:
>>
>>      => sf probe
>>      SF: Detected xt25f32 with page size 256 Bytes, erase size 4 KiB, total 4 MiB
>>
>> In the interest of supporting all board variants and not regressing
>> existing users who boot from MMC, I have enabled support for booting from
>> both SPI flash chip variants in the defconfig and left the environment
>> storage location as MMC to not break existing users who have the
>> environment stored on MMC.
>>
>> I have also enabled GigaDevice SPI flash chip support, since without it
>> U-Boot (unexplainably) fails to load with an error

What is the flash chip on this board? Does it a GigaDevice device?

This sound like some code address affect if your board has a flash chip 
other than GigaDevice.

>> :
>>
>>      U-Boot SPL 2024.04-rc3-00002-g06b486900e2 (Mar 02 2024 - 13:20:45 +0000)
>>      Trying to boot from SPI
>>      load_simple_fit: Skip load 'atf-5': image size is 0!
>>      initcall failed at call 000000000029beec (err=-11: Try again)
>>      ### ERROR ### Please RESET the board ###
> This is possibly because of pinctrl no being configured in SPL.

The pinctrl issue should affect all the SPI flash type, add GigaDevice 
driver should not able to fix

this issue.


Thanks,

- Kever

>   I have a
> big incoming rk3399 series that tries to fix this for most rk3399 boards.
> It will be a variant of what I did in [1] for rk3328.
>
> BROM will only configure pinctrl for each device it tries to locate IDB
> from, so if it locates IDB in SPL it will not have configured emmc or
> sd-card. So for SPL to be able to fall back on other storage it will
> need to do proper pinctrl.
>
> [1]https://patchwork.ozlabs.org/cover/1900345/
>
>> Building with `CONFIG_SPL_FIT_SIGNATURE=y` causes an error when booting
>> from SPI flash, so I disabled it:
>>
>>      U-Boot 2024.04-rc3-00010-g2e7974a13b9 (Mar 02 2024 - 14:00:17 +0000)
>>      SoC: Rockchip rk3399
>>      Reset cause: unknown reset
>>      Model: Radxa ROCK Pi 4A
>>      DRAM:  initcall failed at call 0000000000228efc (err=-19: No such device)
>>      ### ERROR ### Please RESET the board ###
> This is unexpected but if your u-boot.bin is close to or larger then 1
> MiB the stack and pre-alloc heap may be overlapping with U-Boot proper
> or the FDT. That can cause all sort of strange and unexpected issues :-)
>
> Have another incoming series to address this for RK3328, RK3399 and
> ROCK 5A [2]. Should hit list later today, it will be a rework of [3].
>
> [2]https://github.com/Kwiboo/u-boot-rockchip/compare/2011cf069a8b...9767374d6a8a
> [3]https://patchwork.ozlabs.org/cover/1900376/
>
>> Signed-off-by: Christopher Obbard<chris.obbard@collabora.com>
>> ---
>>
>>   arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi | 12 ++++++++++++
>>   configs/rock-pi-4-rk3399_defconfig         | 15 +++++++++++++--
>>   2 files changed, 25 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi b/arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi
>> index 85ee5770add..04c152a291f 100644
>> --- a/arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi
>> +++ b/arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi
>> @@ -4,3 +4,15 @@
>>    */
>>   
>>   #include "rk3399-rock-pi-4-u-boot.dtsi"
>> +
>> +/ {
>> +	chosen {
>> +		u-boot,spl-boot-order = "same-as-spl", &spi_flash, &sdhci, &sdmmc;
> I would not recommend adding spi_flash here, especially if you have
> SPL_FIT_SIGNATURE disabled, and even more so if someone accidentally
> enable SPL_RAW_IMAGE_SUPPORT.
>
> Ideally, we only load TPL/SPL+FIT from same storage, as provided by
> same-as-spl, however, if we cannot load from the same storage that
> TPL/SPL was loaded from, for recovery purposes it is typically easier to
> fall back on sd-card followed by emmc.
>
> Normally I would expect that if board does not boot TPL/SPL from SPI,
> there is no real reason to try and load FIT from SPI.
>
> If the FIT cannot be loaded from SPI with same-as-spl alone there is
> possible some other issue that we need to resolve.
>
>> +	};
>> +};
>> +
>> +&spi1 {
>> +	spi_flash: flash@0 {
>> +		bootph-all;
>> +	};
>> +};
>> diff --git a/configs/rock-pi-4-rk3399_defconfig b/configs/rock-pi-4-rk3399_defconfig
>> index 83fc4ad7dab..3a38b51c46b 100644
>> --- a/configs/rock-pi-4-rk3399_defconfig
>> +++ b/configs/rock-pi-4-rk3399_defconfig
>> @@ -6,25 +6,28 @@ CONFIG_TEXT_BASE=0x00200000
>>   CONFIG_NR_DRAM_BANKS=1
>>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
>> +CONFIG_SF_DEFAULT_SPEED=10000000
>>   CONFIG_ENV_OFFSET=0x3F8000
>>   CONFIG_DEFAULT_DEVICE_TREE="rk3399-rock-pi-4a"
>>   CONFIG_OF_LIBFDT_OVERLAY=y
>>   CONFIG_DM_RESET=y
>>   CONFIG_ROCKCHIP_RK3399=y
>> +CONFIG_ROCKCHIP_SPI_IMAGE=y
>>   CONFIG_TARGET_EVB_RK3399=y
>>   CONFIG_SPL_STACK=0x400000
>>   CONFIG_DEBUG_UART_BASE=0xFF1A0000
>>   CONFIG_DEBUG_UART_CLOCK=24000000
>> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
>> +CONFIG_SPL_SPI=y
>>   CONFIG_SYS_LOAD_ADDR=0x800800
>>   CONFIG_PCI=y
>>   CONFIG_DEBUG_UART=y
>>   # CONFIG_ANDROID_BOOT_IMAGE is not set
>> -CONFIG_SPL_FIT_SIGNATURE=y
>>   CONFIG_LEGACY_IMAGE_FORMAT=y
>>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rock-pi-4a.dtb"
>>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>>   CONFIG_MISC_INIT_R=y
>> -CONFIG_SPL_MAX_SIZE=0x2e000
>> +CONFIG_SPL_MAX_SIZE=0x40000
>>   CONFIG_SPL_PAD_TO=0x7f8000
>>   CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>>   CONFIG_SPL_BSS_START_ADDR=0x400000
>> @@ -33,6 +36,8 @@ CONFIG_SPL_BSS_MAX_SIZE=0x2000
>>   # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>>   CONFIG_SPL_STACK_R=y
>>   CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x10000
>> +CONFIG_SPL_SPI_LOAD=y
>> +CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
>>   CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
>>   CONFIG_TPL=y
>>   CONFIG_CMD_BOOTZ=y
>> @@ -52,6 +57,7 @@ CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent
>>   CONFIG_ENV_IS_IN_MMC=y
>>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>>   CONFIG_DFU_MMC=y
>> +CONFIG_SPL_DM_SEQ_ALIAS=y
>>   CONFIG_ROCKCHIP_GPIO=y
>>   CONFIG_SYS_I2C_ROCKCHIP=y
>>   CONFIG_MISC=y
>> @@ -61,6 +67,10 @@ CONFIG_MMC_DW_ROCKCHIP=y
>>   CONFIG_MMC_SDHCI=y
>>   CONFIG_MMC_SDHCI_SDMA=y
>>   CONFIG_MMC_SDHCI_ROCKCHIP=y
>> +CONFIG_SF_DEFAULT_BUS=1
> Would recommend adding following to allow reading SFDP properties from
> flash, it is what I am doing to all other rk boards with spi flash:
>
> CONFIG_SPI_FLASH_SFDP_SUPPORT=y
>
> Regards,
> Jonas
>
>> +CONFIG_SPI_FLASH_GIGADEVICE=y
>> +CONFIG_SPI_FLASH_WINBOND=y
>> +CONFIG_SPI_FLASH_XTX=y
>>   CONFIG_ETH_DESIGNWARE=y
>>   CONFIG_GMAC_ROCKCHIP=y
>>   CONFIG_NVME_PCI=y
>> @@ -74,6 +84,7 @@ CONFIG_RAM_ROCKCHIP_LPDDR4=y
>>   CONFIG_BAUDRATE=1500000
>>   CONFIG_DEBUG_UART_SHIFT=2
>>   CONFIG_SYS_NS16550_MEM32=y
>> +CONFIG_ROCKCHIP_SPI=y
>>   CONFIG_SYSRESET=y
>>   CONFIG_USB=y
>>   CONFIG_USB_XHCI_HCD=y
