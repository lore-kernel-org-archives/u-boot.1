Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08ED0C47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 10:30:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C95CC87168;
	Thu, 25 Jan 2024 11:30:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Q/PuYlJW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5049C8718F; Thu, 25 Jan 2024 11:30:17 +0100 (CET)
Received: from mail-m127207.xmail.ntesmail.com
 (mail-m127207.xmail.ntesmail.com [115.236.127.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2464487134
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 11:30:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Q/PuYlJWUtuHFwR+F4kRcZV4nKdhiGi15lqP/V4kBgCCnw3x+pu+OY33eNGYqucWnjJ1FpMy3alaVDPdkfhXgwHF/0cRt/5S00UJDKrasLd/u84XoAZTH0e2UQBgHcWpQLGuwqk4Zg2SxzvTsnfat0whzhMfgUOW0WyEtCNqmK8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=k61/E2rUt9hiohPh73N8WU3NSylYeTWOhLjCPxbp97A=;
 h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 8B2C690035F;
 Thu, 25 Jan 2024 18:29:33 +0800 (CST)
Message-ID: <31e7cb6e-7ef1-4069-a38e-b61677a8d76e@rock-chips.com>
Date: Thu, 25 Jan 2024 18:29:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/18] rockchip: rk3588: fix non-working SD controller if
 booting from other media
Content-Language: en-US
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, =?UTF-8?B?5rSq5oWn5paM?=
 <hhb@rock-chips.com>
Cc: heiko@sntech.de, u-boot@lists.denx.de
References: <20240123-jaguar-v1-0-1eec1c34953c@theobroma-systems.com>
 <20240123-jaguar-v1-13-1eec1c34953c@theobroma-systems.com>
 <10ebfefd-1619-4b08-b15d-ec8ca8e798f3@rock-chips.com>
 <c33d0c58-cd95-490f-9514-8d61e1e70925@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <c33d0c58-cd95-490f-9514-8d61e1e70925@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGB8eVkodT00fSk8fSE8fTlUTARMWGhIXJBQOD1
 lXWRgSC1lBWUpLSFVJQlVKT0lVTUxZV1kWGg8SFR0UWUFZT0tIVUpNT0lOSFVKS0tVSkJLS1kG
X-HM-Tid: 0a8d402af8a403a9kunm8b2c690035f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PCI6Ajo4LDMIUQkzDTdIMB8P
 GiNPFB5VSlVKTEtNSkxDTkxOSk5KVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUNKSE83Bg++
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

Hi Quentin,

On 2024/1/24 18:50, Quentin Schulz wrote:
> Hi Kever,
>
> On 1/24/24 11:19, Kever Yang wrote:
>> Hi Quentin,
>>
>> On 2024/1/23 22:49, Quentin Schulz wrote:
>>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>>
>>> Rockchip SoCs have some jtag/sdmmc autoswitching that simply doesn't
>>> work really well.[00] The Linux kernel disables it for all SoCs[01], so
>>> U-Boot needs to do the same in order to fix issues related to SD 
>>> card on
>>> RK3588. This autoswitching is enabled (by default) via the force_jtag
>>> bitfield in SYS_GRF_SOC_CON6 in the TRM part1.
>>>
>>> For some reason, when booting from SD card, the BootROM does mux the
>>> SDMMC controller in the proper configuration for the RK3588-Jaguar. But
>>> when we don't boot from SD card, U-Boot needs to set it up correctly to
>>> allow accessing SD cards in that configuration.
>>
>> Could you share what's the really issue you met in your board?
>>
>
> I revert the patch and then I have the following when booting from eMMC:
>
> """
> DDR V1.11 f1474cf52f cym 23/05/09-11:02:36
> LPDDR4X, 2112MHz
> channel[0] BW=16 Col=10 Bk=8 CS0 Row=16 CS=1 Die BW=16 Size=1024MB
> channel[1] BW=16 Col=10 Bk=8 CS0 Row=16 CS=1 Die BW=16 Size=1024MB
> channel[2] BW=16 Col=10 Bk=8 CS0 Row=16 CS=1 Die BW=16 Size=1024MB
> channel[3] BW=16 Col=10 Bk=8 CS0 Row=16 CS=1 Die BW=16 Size=1024MB
> Manufacturer ID:0x1
> CH0 RX Vref:27.1%, TX Vref:21.8%,0.0%
> CH1 RX Vref:30.1%, TX Vref:20.8%,0.0%
> CH2 RX Vref:27.9%, TX Vref:21.8%,0.0%
> CH3 RX Vref:31.4%, TX Vref:19.8%,0.0%
> change to F1: 528MHz
> change to F2: 1068MHz
> change to F3: 1560MHz
> change to F0: 2112MHz
> out
>
> U-Boot SPL 2024.01-00344-gf1fab3b9557 (Jan 24 2024 - 11:33:43 +0100)
> Trying to boot from MMC1
> ## Checking hash(es) for config config-1 ... OK
> ## Checking hash(es) for Image atf-1 ... sha256+ OK
> ## Checking hash(es) for Image u-boot ... sha256+ OK
> ## Checking hash(es) for Image fdt-1 ... sha256+ OK
> ## Checking hash(es) for Image atf-2 ... sha256+ OK
> ## Checking hash(es) for Image atf-3 ... sha256+ OK
> INFO:    Preloader serial: 2
> NOTICE:  BL31: v2.3():v2.3-589-g3389cfdda:derrick.huang
> NOTICE:  BL31: Built : 10:14:29, May  9 2023
> INFO:    spec: 0x1
> INFO:    ext 32k is not valid
> INFO:    ddr: stride-en 4CH
> INFO:    GICv3 without legacy support detected.
> INFO:    ARM GICv3 driver initialized in EL3
> INFO:    valid_cpu_msk=0xff bcore0_rst = 0x0, bcore1_rst = 0x0
> INFO:    system boots from cpu-hwid-0
> INFO:    idle_st=0x21fff, pd_st=0x11fff9, repair_st=0xfff70001
> INFO:    dfs DDR fsp_params[0].freq_mhz= 2112MHz
> INFO:    dfs DDR fsp_params[1].freq_mhz= 528MHz
> INFO:    dfs DDR fsp_params[2].freq_mhz= 1068MHz
> INFO:    dfs DDR fsp_params[3].freq_mhz= 1560MHz
> INFO:    BL31: Initialising Exception Handling Framework
> INFO:    BL31: Initializing runtime services
> WARNING: No OPTEE provided by BL2 boot loader, Booting device without 
> OPTEE initialization. SMC`s destined for OPTEE will return SMC_UNK
> ERROR:   Error initializing runtime service opteed_fast
> INFO:    BL31: Preparing for EL3 exit to normal world
> INFO:    Entry point address = 0xa00000
> INFO:    SPSR = 0x3c9
>
>
> U-Boot 2024.01-00344-gf1fab3b9557 (Jan 24 2024 - 11:33:43 +0100)
>
> Model: Theobroma Systems RK3588-SBC Jaguar
> DRAM:  4 GiB (effective 3.7 GiB)
> Core:  327 devices, 26 uclasses, devicetree: separate
> MMC:   mmc@fe2c0000: 1, mmc@fe2e0000: 0
> Loading Environment from MMC... *** Warning - bad CRC, using default 
> environment
>
> In:    serial@feb50000
> Out:   serial@feb50000
> Err:   serial@feb50000
> Model: Theobroma Systems RK3588-SBC Jaguar
> Net:   eth0: ethernet@fe1b0000
> Hit any key to stop autoboot:  0
> => mmc dev 1
> unable to select a mode
> =>
> """
>
>> The SD card will need to enable SD-DET for SD card function int he 
>> hardware design,
>>
>
> We do not have an SD-DET on that board, this is not possible (the 
> connector doesn't support it).
>
> SDMMC_DET/GPIO0_A4_u signal is pulled low in HW if left floating (the 
> state by default since we expose it on an external connector) but we 
> plan to let customer use it as a GPIO.


I didn't follow this issue closely in kernel side before, but I would 
like to know why this happen.
Is it possible to share the schematic of your board? I want to 
understand why you didn't use SDMMC_DET for the card slot in hardware 
design, which always need an IO for driver to detect the card.
What I know is if the SD card using all the IO including SDMMC_DET with 
its iomux set to sdmmc function, then the force_jtag should work correctly.
If you only use IO signal other than SDMMC_DET as sdmmc function, and 
set SDMMC_DET iomux work as GPIO, then yes, you need to disable the 
force_jtag.
Since SDMMC_DET in rk3588 is an IO only have one function(not like other 
GPIOs may have more than 2 functions for choice), this IO can always be 
used as SDMMC_DET without conflict when the board has SDcard support.


Thanks,
- Kever
>
>> which is rockchip reference design and followed by most of the 
>> customer and boards.
>>
>> This feature works in all the rk3588 boards we known, and no need to 
>> disable this auto switching.
>>
>
> This is clearly not what people have experienced, c.f. the Linux 
> kernel patch:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/soc/rockchip/grf.c?id=6f6878ec6faf16a5f36761c93da6ea9cf09adb33 
>
>
> Note that jtag_switching has been disabled for all Rockchip SoCs in 
> the kernel, for a long long time already, c.f. 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/soc/rockchip/grf.c?id=4c58063d4258f6beb4fd5647db6b58f49e337c8f
>
> Cheers,
> Quentin
