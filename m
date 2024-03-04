Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABD3C54E41
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 09:49:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BBDD87971;
	Mon,  4 Mar 2024 10:49:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="PrQBqnsv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBA52878F4; Mon,  4 Mar 2024 10:49:41 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A2A08709C
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 10:49:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=3b93=KK=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: References: Cc:
 To: From: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1709545764;
 bh=mM2SFM751OjcRll7tyBpTT5ChOsSwm4Fdzg82w/22Kk=;
 b=PrQBqnsvoKlIqeQu9xjrz5pS4jtITdjl4guaGmMgqxesLu0f9cidBzF3iSMj92IO1eW2fUpcw
 ywmdqi430GEHG+mDuqpGRKLsbXk2AqSjE8oApgSWrur/wIwW3laK72Ek7iAlFdhvcw5wx4qdSlQ
 TkPZQgOHqMUT9hYyuBwa8aIh9sHBJRcx0Of+BAxsBmgOWmXgK3hlM4WSHHiY53bm3NXdP3BdSZn
 AVaTi+0bxqEzrAAid0sHmTHeGyhsGn9xYPG1fGjkBpvF+HLWf66yOM+fzA4b60EZR7mH1POZ+eF
 CFvdrtQMn7LdYO6s6+oIdHY35qPPbABML8x7qxGhc/OA==
Message-ID: <a286ad0e-950c-45ab-a81b-3746a2ade314@kwiboo.se>
Date: Mon, 4 Mar 2024 10:49:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] rockchip: rock-pi-4-rk3399: Enable booting from
 SPI flash
From: Jonas Karlman <jonas@kwiboo.se>
To: Christopher Obbard <chris.obbard@collabora.com>
Cc: kernel@collabora.com, FUKAUMI Naoki <naoki@radxa.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20240302143417.164560-1-chris.obbard@collabora.com>
 <20240302143417.164560-3-chris.obbard@collabora.com>
 <abdd421f-49d3-4442-ab0a-0c2c143aa199@kwiboo.se>
 <5e9f1b5f008193eea447b7506080af855189b3e1.camel@collabora.com>
 <0bcd9559-8f0c-4017-9433-f794c9ccc5e1@kwiboo.se>
Content-Language: en-US
In-Reply-To: <0bcd9559-8f0c-4017-9433-f794c9ccc5e1@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65e59923478ebeec4ee59946
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

Hi Christopher,

On 2024-03-02 22:15, Jonas Karlman wrote:
> Hi Christopher,
> 
> On 2024-03-02 17:12, Christopher Obbard wrote:
>> Hi Jonas,
>>
>> On Sat, 2024-03-02 at 16:28 +0100, Jonas Karlman wrote:
>>> Hi Christopher,
>>>
>>> On 2024-03-02 15:34, Christopher Obbard wrote:
>>>> Some variants of the ROCK Pi 4 series contain an SPI flash chip, which can
>>>> be booted from. This patch enables support in U-Boot for building the
>>>> image for the SPI flash, support for booting U-Boot from the SPI flash
>>>> chip and support in U-Boot for accessing the SPI flash using `sf`
>>>> commands.
>>>>
>>>> Not all variants (e.g. ROCK Pi 4B, ROCK 4 Model C Plus, ROCK 4SE) come
>>>> populated with an SPI flash chip, but have the footprint on the board so
>>>> a user could solder their own to the board. With this patchset applied,
>>>> these board variants without an SPI flash chip still boot from MMC.
>>>>
>>>> I have enabled support for both Winbond and XTX SPI flash devices since
>>>> different hardware variants have different devices populated:
>>>>
>>>>  - `rockpi4_v13_sch_20181112.pdf` contains a Winbond part `W25Q64FWZPIG`
>>>>  - `rockpi4_v14_sch_20210114.pdf` contains an XTX part `XT25F32BWOIGT`
>>>>
>>>> The ROCK Pi 4 I have is marked as "ROCK PI 4 v1.48" and contains an SPI
>>>> flash chip from XTX:
>>>>
>>>>     => sf probe
>>>>     SF: Detected xt25f32 with page size 256 Bytes, erase size 4 KiB, total
>>>> 4 MiB
>>>>
>>>> In the interest of supporting all board variants and not regressing
>>>> existing users who boot from MMC, I have enabled support for booting from
>>>> both SPI flash chip variants in the defconfig and left the environment
>>>> storage location as MMC to not break existing users who have the
>>>> environment stored on MMC.
>>>>
>>>> I have also enabled GigaDevice SPI flash chip support, since without it
>>>> U-Boot (unexplainably) fails to load with an error:
>>>>
>>>>     U-Boot SPL 2024.04-rc3-00002-g06b486900e2 (Mar 02 2024 - 13:20:45
>>>> +0000)
>>>>     Trying to boot from SPI
>>>>     load_simple_fit: Skip load 'atf-5': image size is 0!
>>>>     initcall failed at call 000000000029beec (err=-11: Try again)
>>>>     ### ERROR ### Please RESET the board ###
>>>
>>> This is possibly because of pinctrl no being configured in SPL. I have a
>>> big incoming rk3399 series that tries to fix this for most rk3399 boards.
>>> It will be a variant of what I did in [1] for rk3328.
>>
>> Sounds good! Let me know if you want to take these patches in that series, or
>> how you wish to work together to not duplicate work. I am open to suggestions
>> if it makes things easier for Kever to merge ;-).
>>
> 
> Yeah, there is currently a small mountain of patches targeted rockchip
> and some even have tricky depends and some will no longer apply clean.
> 
> I can probably take your patches as part of such bigger series to try
> and make it easier for Kever :-). Will try to get something ready for
> list by tomorrow.

I have not been able to finish breaking the series up into smaller
patches but current work-in-progress changes can be found here:
https://github.com/Kwiboo/u-boot-rockchip/commits/rk3399-pinctrl-defconfig-v0

I also have a few other patches in the works, related to rk3308, rk3328
and rk35xx:
https://github.com/Kwiboo/u-boot-rockchip/commits/rk3xxx-misc-wip

Hopefully everything will hit the list throughout the week :-)

Please verify that your issues reported in the commit message gets fixed
by any of the above three linked branches.

> 
> For now I have pushed your patches on top of current pending rockchip
> patches at:
> https://github.com/Kwiboo/u-boot-rockchip/commits/rk3399-rock-pi-4-spi
> 
> Also added a small fixup patch with my suggested changes, and got it to
> boot from SPI on my Rock Pi 4 v1.5.
> 
> However, it looks like there was an issue with resolving spl-boot-device
> without the spi flash node being added to spl-boot-order prop.
> 
>   U-Boot SPL 2024.04-rc3 (Mar 02 2024 - 19:49:44 +0000)
>   board_spl_was_booted_from: brom_bootdevice_id 3 maps to '/spi@ff1d0000/flash@0'
>   Trying to boot from SPI
>   rockchip_rk3288_spi spi@ff1d0000: spi_find_chip_select: plat=3ef8a80, cs=0
>   jedec_spi_nor flash@0: from 0x000e0000, len d
>   jedec_spi_nor flash@0: from 0x000e0000, len d
>   ## Checking hash(es) for config config-1 ... OK
>   jedec_spi_nor flash@0: from 0x001d2600, len d
>   ## Checking hash(es) for Image atf-1 ... sha256+ OK
>   jedec_spi_nor flash@0: from 0x000e0a00, len d
>   ## Checking hash(es) for Image u-boot ... sha256+ OK
>   jedec_spi_nor flash@0: from 0x0020ea00, len d
>   ## Checking hash(es) for Image fdt-1 ... sha256+ OK
>   jedec_spi_nor flash@0: from 0x00205a00, len d
>   ## Checking hash(es) for Image atf-2 ... sha256+ OK
>   jedec_spi_nor flash@0: from 0x00207a00, len d
>   ## Checking hash(es) for Image atf-3 ... sha256+ OK
>   board_spl_was_booted_from: failed to resolve brom_bootdevice_id 0
>   spl_decode_boot_device: could not find udevice for /mmc@fe330000
>   spl_decode_boot_device: could not find udevice for /mmc@fe320000
>   spl_perform_fixups: could not map boot_device to ofpath: -19
> 
> There is an issue with board_spl_was_booted_from() not using same boot
> source id when spl_perform_fixups() is run. Before loading images id is
> 3 and after loading atf images it the boot id is 0.
> 
> Looks like both open source and rockchip TF-A wants to load data to
> 0xff8c0000 so SPL happily overwrites the BROM_BOOTSOURCE_ID_ADDR.
> 
> Maybe we need to save the bootsource id for later use to make
> spl_perform_fixups() work correctly when booting from SPI.
> 
> Guess we do need to keep the flash node in spl-boot-order until
> spl_perform_fixups() is fixed.

Using a static variable on bss worked like a charm and I pushed a
WIP patch on the branch mentioned above.

Regards,
Jonas

> 
>>
>>>
>>> BROM will only configure pinctrl for each device it tries to locate IDB
>>> from, so if it locates IDB in SPL it will not have configured emmc or
>>> sd-card. So for SPL to be able to fall back on other storage it will
>>> need to do proper pinctrl.
>>>
>>> [1] https://patchwork.ozlabs.org/cover/1900345/
>>>
>>>>
>>>> Building with `CONFIG_SPL_FIT_SIGNATURE=y` causes an error when booting
>>>> from SPI flash, so I disabled it:
>>>>
>>>>     U-Boot 2024.04-rc3-00010-g2e7974a13b9 (Mar 02 2024 - 14:00:17 +0000)
>>>>     SoC: Rockchip rk3399
>>>>     Reset cause: unknown reset
>>>>     Model: Radxa ROCK Pi 4A
>>>>     DRAM:  initcall failed at call 0000000000228efc (err=-19: No such
>>>> device)
>>>>     ### ERROR ### Please RESET the board ###
>>>
>>> This is unexpected but if your u-boot.bin is close to or larger then 1
>>> MiB the stack and pre-alloc heap may be overlapping with U-Boot proper
>>> or the FDT. That can cause all sort of strange and unexpected issues :-)
>>>
>>> Have another incoming series to address this for RK3328, RK3399 and
>>> ROCK 5A [2]. Should hit list later today, it will be a rework of [3].
>>
>> Great, please keep me in CC of those series and I will test & rebase my work
>> on top.
> 
> Patches to allow for u-boot.bin bigger than around 1000+ KiB on RK3399
> have now been posted.
> 
> Please verify if that series solved the unexplainable behavior you
> described in commit message, and if it makes fit signature check work
> again.
> 
> Regards,
> Jonas
> 
>>
>>
>> Thanks!
>> Chris
>>
>>>
>>> [2]
>>> https://github.com/Kwiboo/u-boot-rockchip/compare/2011cf069a8b...9767374d6a8a
>>> [3] https://patchwork.ozlabs.org/cover/1900376/
>>>
>>>>
>>>> Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
>>>> ---
>>>>
>>>>  arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi | 12 ++++++++++++
>>>>  configs/rock-pi-4-rk3399_defconfig         | 15 +++++++++++++--
>>>>  2 files changed, 25 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi
>>>> b/arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi
>>>> index 85ee5770add..04c152a291f 100644
>>>> --- a/arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi
>>>> +++ b/arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi
>>>> @@ -4,3 +4,15 @@
>>>>   */
>>>>  
>>>>  #include "rk3399-rock-pi-4-u-boot.dtsi"
>>>> +
>>>> +/ {
>>>> +	chosen {
>>>> +		u-boot,spl-boot-order = "same-as-spl", &spi_flash,
>>>> &sdhci, &sdmmc;
>>>
>>> I would not recommend adding spi_flash here, especially if you have
>>> SPL_FIT_SIGNATURE disabled, and even more so if someone accidentally
>>> enable SPL_RAW_IMAGE_SUPPORT.
>>>
>>> Ideally, we only load TPL/SPL+FIT from same storage, as provided by
>>> same-as-spl, however, if we cannot load from the same storage that
>>> TPL/SPL was loaded from, for recovery purposes it is typically easier to
>>> fall back on sd-card followed by emmc.
>>>
>>> Normally I would expect that if board does not boot TPL/SPL from SPI,
>>> there is no real reason to try and load FIT from SPI.
>>>
>>> If the FIT cannot be loaded from SPI with same-as-spl alone there is
>>> possible some other issue that we need to resolve.
>>>
>>>> +	};
>>>> +};
>>>> +
>>>> +&spi1 {
>>>> +	spi_flash: flash@0 {
>>>> +		bootph-all;
>>>> +	};
>>>> +};
>>>> diff --git a/configs/rock-pi-4-rk3399_defconfig b/configs/rock-pi-4-
>>>> rk3399_defconfig
>>>> index 83fc4ad7dab..3a38b51c46b 100644
>>>> --- a/configs/rock-pi-4-rk3399_defconfig
>>>> +++ b/configs/rock-pi-4-rk3399_defconfig
>>>> @@ -6,25 +6,28 @@ CONFIG_TEXT_BASE=0x00200000
>>>>  CONFIG_NR_DRAM_BANKS=1
>>>>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>>>>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
>>>> +CONFIG_SF_DEFAULT_SPEED=10000000
>>>>  CONFIG_ENV_OFFSET=0x3F8000
>>>>  CONFIG_DEFAULT_DEVICE_TREE="rk3399-rock-pi-4a"
>>>>  CONFIG_OF_LIBFDT_OVERLAY=y
>>>>  CONFIG_DM_RESET=y
>>>>  CONFIG_ROCKCHIP_RK3399=y
>>>> +CONFIG_ROCKCHIP_SPI_IMAGE=y
>>>>  CONFIG_TARGET_EVB_RK3399=y
>>>>  CONFIG_SPL_STACK=0x400000
>>>>  CONFIG_DEBUG_UART_BASE=0xFF1A0000
>>>>  CONFIG_DEBUG_UART_CLOCK=24000000
>>>> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
>>>> +CONFIG_SPL_SPI=y
>>>>  CONFIG_SYS_LOAD_ADDR=0x800800
>>>>  CONFIG_PCI=y
>>>>  CONFIG_DEBUG_UART=y
>>>>  # CONFIG_ANDROID_BOOT_IMAGE is not set
>>>> -CONFIG_SPL_FIT_SIGNATURE=y
>>>>  CONFIG_LEGACY_IMAGE_FORMAT=y
>>>>  CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rock-pi-4a.dtb"
>>>>  CONFIG_DISPLAY_BOARDINFO_LATE=y
>>>>  CONFIG_MISC_INIT_R=y
>>>> -CONFIG_SPL_MAX_SIZE=0x2e000
>>>> +CONFIG_SPL_MAX_SIZE=0x40000
>>>>  CONFIG_SPL_PAD_TO=0x7f8000
>>>>  CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>>>>  CONFIG_SPL_BSS_START_ADDR=0x400000
>>>> @@ -33,6 +36,8 @@ CONFIG_SPL_BSS_MAX_SIZE=0x2000
>>>>  # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>>>>  CONFIG_SPL_STACK_R=y
>>>>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x10000
>>>> +CONFIG_SPL_SPI_LOAD=y
>>>> +CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
>>>>  CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
>>>>  CONFIG_TPL=y
>>>>  CONFIG_CMD_BOOTZ=y
>>>> @@ -52,6 +57,7 @@ CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names
>>>> clock-names interrupt-parent
>>>>  CONFIG_ENV_IS_IN_MMC=y
>>>>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>>>>  CONFIG_DFU_MMC=y
>>>> +CONFIG_SPL_DM_SEQ_ALIAS=y
>>>>  CONFIG_ROCKCHIP_GPIO=y
>>>>  CONFIG_SYS_I2C_ROCKCHIP=y
>>>>  CONFIG_MISC=y
>>>> @@ -61,6 +67,10 @@ CONFIG_MMC_DW_ROCKCHIP=y
>>>>  CONFIG_MMC_SDHCI=y
>>>>  CONFIG_MMC_SDHCI_SDMA=y
>>>>  CONFIG_MMC_SDHCI_ROCKCHIP=y
>>>> +CONFIG_SF_DEFAULT_BUS=1
>>>
>>> Would recommend adding following to allow reading SFDP properties from
>>> flash, it is what I am doing to all other rk boards with spi flash:
>>>
>>> CONFIG_SPI_FLASH_SFDP_SUPPORT=y
>>>
>>> Regards,
>>> Jonas
>>>
>>>> +CONFIG_SPI_FLASH_GIGADEVICE=y
>>>> +CONFIG_SPI_FLASH_WINBOND=y
>>>> +CONFIG_SPI_FLASH_XTX=y
>>>>  CONFIG_ETH_DESIGNWARE=y
>>>>  CONFIG_GMAC_ROCKCHIP=y
>>>>  CONFIG_NVME_PCI=y
>>>> @@ -74,6 +84,7 @@ CONFIG_RAM_ROCKCHIP_LPDDR4=y
>>>>  CONFIG_BAUDRATE=1500000
>>>>  CONFIG_DEBUG_UART_SHIFT=2
>>>>  CONFIG_SYS_NS16550_MEM32=y
>>>> +CONFIG_ROCKCHIP_SPI=y
>>>>  CONFIG_SYSRESET=y
>>>>  CONFIG_USB=y
>>>>  CONFIG_USB_XHCI_HCD=y
>>>
> 
> 

