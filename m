Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6A7606A321
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 15:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HEwbSJoz;
	dkim=pass (2048-bit key, unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=sA6b9Vda
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 641AE811DB;
	Wed, 11 Nov 2026 15:42:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gnaqg7tobwdj; Wed, 11 Nov 2026 15:42:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 14A7481221
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794411729;
	b=pn11eO6PPKRmfDb1XkTBulwUh1OhmjvJtQxVy1g4xQGrEkkmJQcQbzSAgFfE62MkGL+/
	 mmDGJH57BN/cWBw7LL1hugZtLf/GggiN/A0YKqSq3bg0ttx4OkvMrUij+7h70HBIC1G2i
	 Cv7vk7yquMxagxylz4rwnosar4PcLcCLArfgJjwKiLRC7oIvzlhigRJA8gM6ajjcdv7PF
	 5AHO/h8qnwSAdUynXtb4xtVkzNfgShnkdlOB8rFd+O5yASqzTl90jqU/xfE0lqWCVaoKu
	 nG6ArcWFrB3ytZN+M4S2/yEh+zbXGdUfcwU6Op0BxaEgyMUCE8n+g47iaoEddOq1hMA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794411729;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:References:Content-Language:Cc:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=S/wOTip0L6dSP3BMpvs9HRJg34XBgRo1XVJPFEFH66k=;
	b=gtyHrPzXdv0xRZ7vhUytZdHYDtrvAUohzD1wFDUzcH5IJ4MJCDwm79buvtlsnLwZQPfy
	 ciTt1izoNz3RdeMz+pJ5a9CN+8YL4H4o2GOQoOqolyrOp7dgpmueza/Ggehkt0QIBHswr
	 RNi9+XEU9yBfUsKg5YJ4gcRlwFTPMJoGiS64wr3kSZGuYoi5omxqOqXZehi4WM8B4eaie
	 zgQopCNNgEwUeaLBzO0qDxdH3tZ8spRk3L9jnxrzHnibF/S/kmAxoNnDOqy+clvqBcLnU
	 +RPpRhMzljxTagbYJkrdQcJjyC3f9xlNViQYgjM0tVPRTR2nrrXAM8JSEkRtv2/u0iw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794411729;
	bh=S/wOTip0L6dSP3BMpvs9HRJg34XBgRo1XVJPFEFH66k=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HEwbSJozzsqbfaKaeFqdWOkl/3/nTM+gZLs5eMC/GfHt6vwRW2xPQLkOgRDKqPSMv
	 tiVm4qRQ0+2/RZw7dMV6dA4Yj1xJ6jNGNfY8O3gW0wfZVvg03cUagJJ8bVQQFJbavh
	 s4TgAADabQeom0in3+gatpNsvtajTgySftgHsEmyeFHCuSl9/UEb83qC8GTcaY2xjW
	 ZG48ZFYCbNfcEtOlp7YbK9n1XVhHkh9pplGjFRfmPZYxIzzv0WMN9Us9y80SDYCeaB
	 KdxZKqG6rGvrZNh6Zx62qu8TavSaUEfRlusJQiWvWN7SuaiGzjWH89l0kVdfSFqT7R
	 31y5bMtgKAfJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 14A7481221;
	Wed, 11 Nov 2026 15:42:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 762FC31F
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 15:42:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5BD3C606E0
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 15:42:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vf8__7H4jYeO for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 15:42:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 23C1E606DE
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=33c1=jb=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=sA6b9Vda
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 23C1E606DE
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 15:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: Cc:
 Content-Language: References: To: Subject: MIME-Version: Date: Message-ID;
 q=dns/txt; s=fe-e1b5cab7be; t=1794411723;
 bh=S/wOTip0L6dSP3BMpvs9HRJg34XBgRo1XVJPFEFH66k=;
 b=sA6b9VdawoVV+4Pt+38HrSJ8NKDjnhgUemAt41KG3MQ/aIa/02+0E2urw5X7Rp7dgHNYy3NNb
 xc3KGn/XHPbBEnrKnLljQsYabxDnizlupzkwDDEPnjvbSUJ8Egf3SSIBeYhfjlMZdbOEcjmmdIv
 Y1CKhv/BGTrBDlBwWWXa0/wWuRntgc2cWFOWZWy+qhtrIvyJuK9ARXlOsUzr+BxsncuIZ4ocJbZ
 W0dbcF9SzvivPLlVbxNovyphrZsTH9+NK0Nfj8yFjyoE41H2iAcupkWZ2ZR7ZEaMwkS2G717/dc
 aqxEdIad4V22dpD3hSFL+ZAqhjVr2GytzXlDDRCZJmqw==
X-Forward-Email-ID: 6af48cc5351e16ca01be79d1
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.19.18
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <13bfc090-7a2b-4215-9926-259633840359@kwiboo.se>
Date: Wed, 11 Nov 2026 16:41:51 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: rockchip: Add LCKFB TaishanPi 3M
To: Xuechao Han <220110626hanxuechao@alu.hit.edu.cn>
References: <20261110165202.150810-1-220110626hanxuechao@alu.hit.edu.cn>
 <ec190198-4b76-49fa-bf1a-478219f7d56c@cherry.de>
Content-Language: en-US
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <ec190198-4b76-49fa-bf1a-478219f7d56c@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 11/11/2026 3:04 PM, Quentin Schulz wrote:
> Hi Xuechao Han,
> 
> Something went wrong when you sent the mail and all Ccs were ignored, 
> please fix this for the v2.
> 
> On 11/10/26 5:52 PM, Xuechao Han wrote:
>> [You don't often get email from 220110626hanxuechao@alu.hit.edu.cn. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> Add support for the LCKFB TaishanPi 3M, an RK3576 based board.
>>
>> The board device tree describes the microSD card detect pin as a plain
>> GPIO (sdmmc0_det_l) for its cd-gpios property. dw_mmc does not use
>> cd-gpios, so the pad stays in GPIO mode and switching the bus to 4-bit
>> high speed fails with:
>>
>>    CMD_SEND:6
>>      ARG                      0x80fffff1
>>      RET                      -110
>>    unable to select a mode
>>    mmc_init: -524
>>
>> Use the sdmmc0_det pinmux in the U-Boot device tree, like other Rockchip
>> boards do, so the card detect signal reaches the SDMMC controller.
>>
>> Signed-off-by: Xuechao Han <220110626hanxuechao@alu.hit.edu.cn>
>>
>> Cc: Kever Yang <kever.yang@rock-chips.com>
>> Cc: Quentin Schulz <u-boot@0leil.net>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   arch/arm/dts/rk3576-lckfb-tspi-3m-u-boot.dtsi | 28 ++++++++
>>   arch/arm/mach-rockchip/rk3576/MAINTAINERS     |  6 ++
>>   configs/lckfb-tspi-3m-rk3576_defconfig        | 65 +++++++++++++++++++
>>   doc/board/rockchip/rockchip.rst               |  1 +
>>   4 files changed, 100 insertions(+)
>>   create mode 100644 arch/arm/dts/rk3576-lckfb-tspi-3m-u-boot.dtsi
>>   create mode 100644 configs/lckfb-tspi-3m-rk3576_defconfig
>>
>> diff --git a/arch/arm/dts/rk3576-lckfb-tspi-3m-u-boot.dtsi b/arch/arm/dts/rk3576-lckfb-tspi-3m-u-boot.dtsi
>> new file mode 100644
>> index 00000000000..412c92d357c
>> --- /dev/null
>> +++ b/arch/arm/dts/rk3576-lckfb-tspi-3m-u-boot.dtsi
>> @@ -0,0 +1,28 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2026 FragrantOrchid <fragrantorchid@foxmail.com>
>> + *
>> + * U-Boot specific device tree changes for the LCKFB TaishanPi 3M (RK3576).
> 
> issue: unnecessary comment
> 
> We're in U-Boot, we know it's additions to the Device Tree for U-Boot.
> 
>> + */
>> +
>> +#include "rk3576-u-boot.dtsi"
>> +
>> +/*
>> + * Use sdmmc0_det (SDMMC0_DETN) instead of sdmmc0_det_l, which the board device
>> + * tree selects as a plain GPIO for its cd-gpios.  dw_mmc does not read
>> + * cd-gpios, so the pad stays in GPIO mode and the switch to 4-bit high speed
>> + * mode fails; both entries are GPIO0_A7 with the same pull-up and only the mux
>> + * value differs:
>> + *
>> + *     CMD_SEND:6
>> + *             ARG                      0x80fffff1
>> + *             RET                      -110
>> + *     unable to select a mode
>> + *     mmc_init: -524
>> + *
>> + * 1-bit/25 MHz still works, so the slot looks alive until the first wide bus
>> + * data transfer.
>> + */
>> +&sdmmc {
>> +       pinctrl-0 = <&sdmmc0_clk &sdmmc0_cmd &sdmmc0_det &sdmmc0_bus4>;
>> +};
> 
> issue: Device Tree is a representation of the HW, so hacks are not 
> welcome there
> 
> We also don't want to have non-upstreamable changes in U-Boot Device 
> Trees anymore.
> 
> Either upstream this in the Linux kernel (but I suspect they will reject 
> it on the basis of what you're explaining above), or fix the DWMMC 
> driver to control the cd-gpio wherever appropriate (preferred method).

My checkdtb script [1] reports that two pinctrl phandle nodes are missing
in u-boot-spl.dtb, one of them is the sdmmc0_det_l.

  + python3 /home/kwiboo/scripts/u-boot/checkdtb.py --spl spl/u-boot-spl.dtb u-boot.dtb
  MODEL: LCKFB TaishanPi 3M
  COMPATIBLE: lckfb,tspi-3m-rk3576, rockchip,rk3576
  ERROR: SPL: missing phandle 103 at /soc/ufshc@2a2d0000/reset-gpios
  ERROR: SPL: missing phandle 128 at /soc/mmc@2a310000/pinctrl-0
  SPL: pinctrls: 11, pins: 46, gpios: 0, phandles: 31
  WARNING: SPL: maybe unneeded CONFIG_SPL_DM_GPIO=y
  WARNING: SPL: maybe unneeded CONFIG_SPL_GPIO=y
  INFO: U-Boot: dr_mode=otg at /soc/usb@23000000/dr_mode
  U-Boot: pinctrls: 110, pins: 1087, gpios: 9, phandles: 1005

Please try with following in rk3576-lckfb-tspi-3m-u-boot.dtsi to help ensure
sdmmc pinctrl is correctly applied in SPL before the SD-card is used:

	&sdmmc0_det_l {
		bootph-pre-ram;
		bootph-some-ram;
	};

Else maybe the use of cd-gpios prop is incorrect and Linux DT should be
corrected to use SDMMC0_DETN mux? The other rk3576 boards that use cd-gpios
also seem to use incorrect pinctrl, SDMMC0_DETN instead of GPIO func and
should likely also be fixed in upstream DT.

[1] https://github.com/Kwiboo/scripts/blob/main/u-boot/checkdtb.py

Regards,
Jonas

> 
>> diff --git a/arch/arm/mach-rockchip/rk3576/MAINTAINERS b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
>> index baae63fc7b0..158fc1421b4 100644
>> --- a/arch/arm/mach-rockchip/rk3576/MAINTAINERS
>> +++ b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
>> @@ -4,6 +4,12 @@ S:     Maintained
>>   F:     arch/arm/dts/rk3576-generic*
>>   F:     configs/generic-rk3576_defconfig
>>
>> +LCKFB-TSPI-3M-RK3576
>> +M:     Xuechao Han <220110626hanxuechao@alu.hit.edu.cn>
>> +S:     Maintained
>> +N:     rk3576-lckfb-tspi-3m
>> +F:     configs/lckfb-tspi-3m-rk3576_defconfig
>> +
>>   NANOPI-M5-RK3576
>>   M:     Jonas Karlman <jonas@kwiboo.se>
>>   S:     Maintained
>> diff --git a/configs/lckfb-tspi-3m-rk3576_defconfig b/configs/lckfb-tspi-3m-rk3576_defconfig
>> new file mode 100644
>> index 00000000000..3b6b045eca6
>> --- /dev/null
>> +++ b/configs/lckfb-tspi-3m-rk3576_defconfig
>> @@ -0,0 +1,65 @@
>> +CONFIG_ARM=y
>> +CONFIG_SKIP_LOWLEVEL_INIT=y
>> +CONFIG_COUNTER_FREQUENCY=24000000
>> +CONFIG_ARCH_ROCKCHIP=y
>> +CONFIG_SPL_GPIO=y
>> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3576-lckfb-tspi-3m"
>> +CONFIG_ROCKCHIP_RK3576=y
>> +CONFIG_SYS_LOAD_ADDR=0x40c00800
>> +CONFIG_DEBUG_UART_BASE=0x2AD40000
>> +CONFIG_DEBUG_UART_CLOCK=24000000
>> +CONFIG_DEBUG_UART=y
>> +CONFIG_BOOTCOMMAND="setenv bootmeths script; setenv boot_targets mmc0 mmc1; bootflow scan -lb"
> 
> question: what are you trying to do/prevent here?
> 
> For the boot targets, do you really always want to try eMMC first, and 
> then SD?
> 
> Maybe what you want is something similar to what I've done for the 
> Theobroma boards? c.f. 
> https://elixir.bootlin.com/u-boot/v2026.10/source/board/theobroma-systems/common/common.c#L11
> 
> We swap the default boot_targets based on which boot medium was used. If 
> it was booted from SD, then prefer SD. If it was booted from eMMC, 
> prefer eMMC.
> 
> Unsure why you want to limit the possible bootmeths? We usually prefer 
> giving the user as much freedom as possible on how to boot their device, 
> so restricting the possible methods seem odd to me here.
> 
>> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3576-lckfb-tspi-3m.dtb"
>> +# CONFIG_DISPLAY_CPUINFO is not set
>> +CONFIG_SPL_MAX_SIZE=0x40000
>> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>> +CONFIG_SPL_DM_RESET=y
> 
> question: what do you need the reset subsystem for in SPL?
> 
>> +CONFIG_CMD_GPIO=y
>> +CONFIG_CMD_GPT=y
>> +CONFIG_CMD_I2C=y
>> +CONFIG_CMD_MISC=y
>> +CONFIG_CMD_MMC=y
>> +CONFIG_CMD_USB=y
>> +CONFIG_CMD_ROCKUSB=y
>> +CONFIG_CMD_USB_MASS_STORAGE=y
>> +# CONFIG_CMD_SETEXPR is not set
>> +CONFIG_CMD_RNG=y
>> +CONFIG_CMD_REGULATOR=y
>> +# CONFIG_SPL_DOS_PARTITION is not set
>> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> 
> nitpick: remove clock-names from CONFIG_OF_SPL_REMOVE_PROPS
> 
>> +CONFIG_BUTTON=y
>> +CONFIG_BUTTON_ADC=y
>> +# CONFIG_USB_FUNCTION_FASTBOOT is not set
>> +CONFIG_ROCKCHIP_GPIO=y
>> +CONFIG_SYS_I2C_ROCKCHIP=y
>> +CONFIG_LED=y
>> +CONFIG_LED_GPIO=y
>> +CONFIG_SUPPORT_EMMC_RPMB=y
>> +CONFIG_MMC_DW=y
>> +CONFIG_MMC_DW_ROCKCHIP=y
>> +CONFIG_MMC_SDHCI=y
>> +CONFIG_MMC_SDHCI_SDMA=y
>> +CONFIG_MMC_SDHCI_ROCKCHIP=y
>> +CONFIG_DWC_ETH_QOS=y
>> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
>> +CONFIG_PHY_MAXIO=y
>> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
>> +CONFIG_PHY_ROCKCHIP_USBDP=y
>> +CONFIG_DM_PMIC=y
>> +CONFIG_PMIC_RK8XX=y
>> +CONFIG_REGULATOR_RK8XX=y
>> +CONFIG_SCSI=y
>> +CONFIG_BAUDRATE=1500000
>> +CONFIG_DEBUG_UART_SHIFT=2
>> +CONFIG_SYS_NS16550_MEM32=y
>> +CONFIG_SYSRESET_PSCI=y
>> +CONFIG_USB=y
>> +CONFIG_USB_XHCI_HCD=y
>> +CONFIG_USB_DWC3=y
>> +CONFIG_USB_DWC3_GENERIC=y
>> +CONFIG_USB_GADGET=y
>> +CONFIG_USB_GADGET_DOWNLOAD=y
>> +CONFIG_USB_FUNCTION_ROCKUSB=y
>> +CONFIG_ERRNO_STR=y
> 
> question: why not enabling SATA?
> 
> It seems there's a SATA port on this board and it's enabled in the 
> Device Tree. Have you tried with CONFIG_DWC_AHCI enabled whether you can 
> communicate with it?
> 
> Cheers,
> Quentin

