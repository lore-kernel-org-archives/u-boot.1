Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E5FCD37B3
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 09:26:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2CFE863F9;
	Sun, 17 Sep 2023 11:26:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.b="ZePnByCz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 954458638B; Sun, 17 Sep 2023 11:26:51 +0200 (CEST)
Received: from s.wrqvtbkv.outbound-mail.sendgrid.net
 (s.wrqvtbkv.outbound-mail.sendgrid.net [149.72.123.24])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12315863F9
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 11:26:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounces+31435339-7456-u-boot=lists.denx.de@em2124.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=mime-version:subject:references:from:in-reply-to:to:cc:content-type:
 content-transfer-encoding:cc:content-type:from:subject:to;
 s=s1; bh=oNRPCMOZZuRMU+LfAA2+m8Z3sasatLe+zv5gJGskUoU=;
 b=ZePnByCzfBBUvSUTDWb9AZj2K9qWVPcqXkfor32rnbvjGFluU1IvzRkQoUUwZDVeI3/M
 21QqsjB7nJ69vn/57YgmBrsKnTJnv+6mgDv6+g4ktfMW4arV66EZ52wJKSgGoYrsKDctGR
 jp++xDXWdm1bnhTSv/rAg+FfB/4Ctx7HjSvn19EbvVsij8Ddb/vAhxJjqicSbzE8xhhmVt
 WfspxnIkky84mz+GBxMQqSWh/8NWKRakfZDpA2eaq4Hp9bFzql6vAaQx2uKQxZkmQUlmEn
 xk1sAr8A85jM/D3If2j6TMYN1geefdsXRn68wwMotbw5RLRaG8I5DOUjzWdP3x1A==
Received: by filterdrecv-66949dbc98-mf5n6 with SMTP id
 filterdrecv-66949dbc98-mf5n6-1-6506C657-7
 2023-09-17 09:26:47.50979819 +0000 UTC m=+157907.175397843
Received: from [192.168.1.50] (unknown) by geopod-ismtpd-4 (SG) with ESMTP
 id jXTvN5sjR3OPcj1BA4oH-w Sun, 17 Sep 2023 09:26:47.273 +0000 (UTC)
Message-ID: <6872f4eb-f4da-c933-c6ba-c1a0fbd060c0@kwiboo.se>
Date: Sun, 17 Sep 2023 09:26:47 +0000 (UTC)
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Aw: Re: [PATCH v3] board: rockchip: Add Bananapi R2Pro Board
Content-Language: en-US
References: <20230820160004.44880-1-linux@fw-web.de>
 <dfcd6379-0efe-d335-d971-40302b291901@kwiboo.se>
 <trinity-ae369208-8f2d-4d3c-a512-f730d74504f5-1694935155520@3c-app-gmx-bs18>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <trinity-ae369208-8f2d-4d3c-a512-f730d74504f5-1694935155520@3c-app-gmx-bs18>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h+i8rYnnPy7zfz+69?=
 =?us-ascii?Q?pocjlIytrln6Zgko=2FwM=2FXEISfpevRdDvnU5NT60?=
 =?us-ascii?Q?4i6YFknuj3sDVSTODKfaJvTmiRKtffGLtbwcZRt?=
 =?us-ascii?Q?wHDFId1P2cZahpxwZhnXxM00n+qEvnGOf7QoEKm?=
 =?us-ascii?Q?6+Oowt8UpwG3RNcsG4kcvOgaO8NibnXq0r5jTl?=
To: Frank Wunderlich <frank-w@public-files.de>
Cc: Frank Wunderlich <linux@fw-web.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Kever Yang
 <kever.yang@rock-chips.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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

On 2023-09-17 09:19, Frank Wunderlich wrote:
> Hi,
> 
> thank you for your suggestions
> 
>> Gesendet: Sonntag, 17. September 2023 um 00:51 Uhr
>> Von: "Jonas Karlman" <jonas@kwiboo.se>
>> An: "Frank Wunderlich" <linux@fw-web.de>
>> Cc: "Frank Wunderlich" <frank-w@public-files.de>, "Simon Glass" <sjg@chromium.org>, "Philipp Tomsich" <philipp.tomsich@vrull.eu>, "Kever Yang" <kever.yang@rock-chips.com>, "Marek Vasut" <marex@denx.de>, u-boot@lists.denx.de
>> Betreff: Re: [PATCH v3] board: rockchip: Add Bananapi R2Pro Board
>>
>> Hi Frank,
>>
>> On 2023-08-20 18:00, Frank Wunderlich wrote:
>>> From: Frank Wunderlich <frank-w@public-files.de>
>>>
>>> Add Bananapi R2 Pro board.
>>>
>>> Till now evb dts could be used, but iodomain is different
>>> (evb has 1v8 on vccio2 and vccio4 which are 3v3 on r2pro)
>>> and with iodomain driver this can cause hardware fault.
>>>
>>> Devicetree in mainline-Linux:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
>>>
>>> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
>>> ---
>>> v3:
>>> - disable gmac0 as switch-driver is not yet ready to attach to the mac
>>> v2:
>>> - drop switch-node for now as u-boot driver works differently to linux
>>> ---
>>>  arch/arm/dts/Makefile                     |   3 +-
>>>  arch/arm/dts/rk3568-bpi-r2pro-u-boot.dtsi |  23 +
>>>  arch/arm/dts/rk3568-bpi-r2pro.dts         | 549 ++++++++++++++++++++++
>>>  configs/bpi-r2pro-rk3568_defconfig        | 101 ++++
>>>  4 files changed, 675 insertions(+), 1 deletion(-)
>>>  create mode 100644 arch/arm/dts/rk3568-bpi-r2pro-u-boot.dtsi
>>>  create mode 100644 arch/arm/dts/rk3568-bpi-r2pro.dts
>>>  create mode 100644 configs/bpi-r2pro-rk3568_defconfig
>>>
>>> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
>>> index bd518064f35f..767bf9db39fb 100644
>>> --- a/arch/arm/dts/Makefile
>>> +++ b/arch/arm/dts/Makefile
>>> @@ -182,7 +182,8 @@ dtb-$(CONFIG_ROCKCHIP_RK3568) += \
>>>  	rk3568-nanopi-r5s.dtb \
>>>  	rk3568-odroid-m1.dtb \
>>>  	rk3568-radxa-e25.dtb \
>>> -	rk3568-rock-3a.dtb
>>> +	rk3568-rock-3a.dtb \
>>> +	rk3568-bpi-r2pro.dtb
>>>
>>>  dtb-$(CONFIG_ROCKCHIP_RK3588) += \
>>>  	rk3588-edgeble-neu6a-io.dtb \
>>> diff --git a/arch/arm/dts/rk3568-bpi-r2pro-u-boot.dtsi b/arch/arm/dts/rk3568-bpi-r2pro-u-boot.dtsi
>>> new file mode 100644
>>> index 000000000000..382a52a28b10
>>> --- /dev/null
>>> +++ b/arch/arm/dts/rk3568-bpi-r2pro-u-boot.dtsi
>>> @@ -0,0 +1,23 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * (C) Copyright 2021 Rockchip Electronics Co., Ltd
>>> + */
>>> +
>>> +#include "rk356x-u-boot.dtsi"
>>> +
>>> +/ {
>>> +	chosen {
>>> +		stdout-path = &uart2;
>>> +		u-boot,spl-boot-order = "same-as-spl", &sdmmc0, &sdhci;
>>
>> This is the default order in rk356x-u-boot.dtsi and can be dropped.
>>
>>> +	};
>>> +};
>>> +
>>> +&sdmmc0 {
>>> +	status = "okay";
>>
>> sdmmc0 is already enabled in rk3568-bpi-r2pro.dts
>>
>>> +};
>>> +
>>> +&uart2 {
>>> +	clock-frequency = <24000000>;
>>> +	bootph-pre-ram;
>>> +	status = "okay";
>>> +};
> 
> then i have only the uart here...right? do you remember i missed the -uboot.dtsi in first try and board does not find mmc in spl.
> 
> do i really not need the first 2 nodes here?

The chosen node with stdout-path prop and uart2 node should probably
be the only nodes left.

If you are having issues with mmc in SPL, I would first look at pinctrl,
ensure pinctrl is enabled in SPL and that pinctrl-0 prop is defined for
your sdmmc0 and sdhci node. OF_SPL_REMOVE_PROPS should also not list
pinctrl nodes, look at defconfig for other rk356x boards, e.g.
rock-3a-rk3568_defconfig should be a good candidate and one I test
frequently.

And if that does not help and there is a regulator that is not enable by
default you may need to enable gpio and regulator pinconf nodes and
related Kconfig options for SPL.

See rk3566-quartz64-a-u-boot.dtsi where I had to enable gpio0, vcc3v3_sd
and vcc_sd_h node and related Kconfig options to have working sd-card.

> 
>>> diff --git a/arch/arm/dts/rk3568-bpi-r2pro.dts b/arch/arm/dts/rk3568-bpi-r2pro.dts
>>> new file mode 100644
>>> index 000000000000..e4fcbb8a1174
>>> --- /dev/null
>>> +++ b/arch/arm/dts/rk3568-bpi-r2pro.dts
>>
>> Should be a 1:1 copy from kernel.
> 
> i try to do so, but this will result in many nodes not used in uboot like the switch i remove in the dtsi and graphics.
> thx for pointing to the pcie driver then i can let these nodes in.

This file should be a full 1:1 copy, if you need to modify any node for
U-Boot you should do such override in -u-boot.dtsi file. You can use
/delete-property/ or /delete-node/ if you really need to remove
something that cause issues for U-Boot, else leave the nodes even if
they are not useful for U-Boot itself. Having full DT should make it
possible to EFI boot generic aarch64 distro images, e.g. fedora etc.

> 
>> [...]
>>
>>> diff --git a/configs/bpi-r2pro-rk3568_defconfig b/configs/bpi-r2pro-rk3568_defconfig
>>> new file mode 100644
>>> index 000000000000..e8936261eab3
>>> --- /dev/null
>>> +++ b/configs/bpi-r2pro-rk3568_defconfig
>>> @@ -0,0 +1,101 @@
>>> +CONFIG_ARM=y
>>> +CONFIG_SKIP_LOWLEVEL_INIT=y
>>> +CONFIG_COUNTER_FREQUENCY=24000000
>>> +CONFIG_ARCH_ROCKCHIP=y
>>> +CONFIG_TEXT_BASE=0x00a00000
>>> +CONFIG_SPL_LIBCOMMON_SUPPORT=y
>>> +CONFIG_SPL_LIBGENERIC_SUPPORT=y
>>> +CONFIG_NR_DRAM_BANKS=2
>>> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>>> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
>>> +CONFIG_DEFAULT_DEVICE_TREE="rk3568-bpi-r2pro"
>>> +CONFIG_ROCKCHIP_RK3568=y
>>> +CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
>>> +CONFIG_SPL_SERIAL=y
>>> +CONFIG_SPL_STACK_R_ADDR=0x600000
>>> +CONFIG_SPL_STACK=0x400000
>>> +CONFIG_DEBUG_UART_BASE=0xFE660000
>>> +CONFIG_DEBUG_UART_CLOCK=24000000
>>> +CONFIG_SYS_LOAD_ADDR=0xc00800
>>> +CONFIG_DEBUG_UART=y
>>> +CONFIG_FIT=y
>>> +CONFIG_FIT_VERBOSE=y
>>> +CONFIG_SPL_FIT_SIGNATURE=y
>>> +CONFIG_SPL_LOAD_FIT=y
>>> +CONFIG_LEGACY_IMAGE_FORMAT=y
>>> +#CONFIG_OF_SYSTEM_SETUP=y
>>> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-bpi-r2pro"
>>> +# CONFIG_DISPLAY_CPUINFO is not set
>>> +CONFIG_DISPLAY_BOARDINFO_LATE=y
>>> +CONFIG_SPL_MAX_SIZE=0x40000
>>> +CONFIG_SPL_PAD_TO=0x7f8000
>>> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>>> +CONFIG_SPL_BSS_START_ADDR=0x4000000
>>> +CONFIG_SPL_BSS_MAX_SIZE=0x4000
>>> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>>> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>>> +CONFIG_SPL_STACK_R=y
>>> +CONFIG_SPL_ATF=y
>>> +CONFIG_CMD_GPIO=y
>>> +CONFIG_CMD_GPT=y
>>> +CONFIG_CMD_I2C=y
>>> +CONFIG_CMD_MMC=y
>>> +CONFIG_CMD_PMIC=y
>>> +CONFIG_CMD_REGULATOR=y
>>> +# CONFIG_SPL_DOS_PARTITION is not set
>>> +CONFIG_SPL_OF_CONTROL=y
>>> +CONFIG_OF_LIVE=y
>>> +CONFIG_NET=n
>>> +CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>>> +CONFIG_SPL_REGMAP=y
>>> +CONFIG_SPL_SYSCON=y
>>> +CONFIG_SPL_CLK=y
>>> +CONFIG_ROCKCHIP_GPIO=y
>>> +CONFIG_ROCKCHIP_GPIO_V2=y
>>
>> This Kconfig option does not exits.
>>
>>> +CONFIG_SYS_I2C_ROCKCHIP=y
>>> +CONFIG_MISC=y
>>> +CONFIG_SUPPORT_EMMC_RPMB=y
>>> +CONFIG_MMC_DW=y
>>> +CONFIG_MMC_DW_ROCKCHIP=y
>>> +CONFIG_MMC_SDHCI=y
>>> +CONFIG_MMC_SDHCI_SDMA=y
>>> +CONFIG_MMC_SDHCI_ROCKCHIP=y
>>> +CONFIG_ETH_DESIGNWARE=y
>>> +CONFIG_GMAC_ROCKCHIP=y
>>
>> Please drop CONFIG_ETH_DESIGNWARE and CONFIG_GMAC_ROCKCHIP.
>>
>> The following series that add GMAC support for RK3568 and RK3588 will
>> use DWC_ETH_QOS and DWC_ETH_QOS_ROCKCHIP Kconfig options.
>>
>> rockchip: Add GMAC support for RK3568 and RK3588
>> https://patchwork.ozlabs.org/project/uboot/cover/20230807000817.1701012-1-jonas@kwiboo.se/
>>
>>> +CONFIG_DM_PMIC=y
>>> +CONFIG_PMIC_RK8XX=y
>>> +CONFIG_REGULATOR_RK8XX=y
>>> +CONFIG_REGULATOR_PWM=y
>>> +CONFIG_PWM_ROCKCHIP=y
>>> +CONFIG_SPL_RAM=y
>>> +CONFIG_BAUDRATE=1500000
>>> +CONFIG_DEBUG_UART_SHIFT=2
>>> +CONFIG_SYS_NS16550_MEM32=y
>>> +CONFIG_SYSRESET=y
>>> +CONFIG_SYSRESET_PSCI=y
>>> +CONFIG_ERRNO_STR=y
>>> +CONFIG_SYS_PROMPT="BPI-R2PRO> "
>>> +CONFIG_CMD_SYSBOOT=y
>>> +CONFIG_CMD_BOOTDEV=y
>>> +CONFIG_BOOTSTD_FULL=y
>>> +CONFIG_CMD_EFICONFIG=n
>>> +CONFIG_EFI_LOADER=n
>>> +CONFIG_USB=y
>>> +CONFIG_USB_XHCI_HCD=y
>>> +CONFIG_USB_XHCI_DWC3=y
>>
>> This should not be enabled for rk3568, USB_DWC3_GENERIC provide usb
>> support.
>>
>>> +CONFIG_USB_DWC3_GENERIC=y
>>> +CONFIG_USB_EHCI_HCD=y
>>> +CONFIG_USB_EHCI_GENERIC=y
>>> +CONFIG_USB_OHCI_HCD=y
>>> +CONFIG_USB_OHCI_GENERIC=y
>>> +CONFIG_USB_UHCI_HCD=y
>>> +CONFIG_USB_DWC2=y
>>
>> There should not be any need to enable this driver on rk3568.
>>
>>> +CONFIG_USB_DWC3=y
>>> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
>>> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>>> +CONFIG_CMD_USB=y
>>> +CONFIG_AHCI=y
>>> +CONFIG_DWC_AHCI=y
>>> +CONFIG_SCSI=y
>>> +CONFIG_DM_SCSI=y
>>> +CONFIG_CMD_SCSI=y
>>
>> Please run moveconfig.py to clean up and re-order the defconfig.
> 
> can you give me an example how i can pass my defconfig with the script?
> 
> ./tools/moveconfig.py configs/bpi-r2pro-rk3568_defconfig
> ./tools/moveconfig.py -d configs/bpi-r2pro-rk3568_defconfig
> 
> do not work here...have not found a way in the --help page...i guess i misunderstand the script

Probably much easier to use make savedefconfig instead of the moveconfig.py script.

Regards,
Jonas

> 
> regards Frank
> 
>> Regards,
>> Jonas

