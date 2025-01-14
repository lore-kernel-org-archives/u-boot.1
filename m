Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1FAE77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 15:04:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4818E8060C;
	Tue, 14 Jan 2025 16:04:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OFMHizUh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 816A680657; Tue, 14 Jan 2025 16:04:02 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D35A38022E
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 16:03:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=cnsztl@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2166f1e589cso118838105ad.3
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 07:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736867038; x=1737471838; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jjpp6hNmf8uEnuVLg1/+DY6mMqCLnknoQAsgItXfi8I=;
 b=OFMHizUhh01g71XnGoTj0DXU79Vp9cm4eBlEbyf8F61Fq5AvjljTaly9lAJ83pL1KH
 ZJE8/tPC+Lj69MIlp/8MPjbIP9nNze++x+caHMzrHwazUrzWnMjPazVQdoiNMX9fRara
 FbdjZPNuFb0VsgZMakJeqJUTkKgsU2yGCMnvz0xEEhqslVlgU6gUIGgZnfaP2EWqE0cV
 7iw2aTVZ+Gk1+O/9SCpclquWEYJS1JEf4MxCfJqm9mzNtFzaZynMThAWMG5IixQTv3kR
 ShlSO6aJe8rL9DyJb1XWKwuXYSK2Ah+UEcGHozALsMctN34Gi50oZ1p6x6yycUahqgPI
 57UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736867038; x=1737471838;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jjpp6hNmf8uEnuVLg1/+DY6mMqCLnknoQAsgItXfi8I=;
 b=Cc0Qt0AmZXgAdLt2py/whQoXoJ740N4JhU+vUeL1iq5iRt5HCBwlHRv1DAFQpAttmi
 XUpSWuLtVxf6BhWnch05530s4fXfymCN0L+Nj31nmpbpiHji8vc0IKohicF4x08nUtv5
 iDGeyvzsc4A4QOhLNhhrpUHo5YXzDMHd4j8gupIs3gX6VgyKIohQSKv3/uKW9Ne1AULU
 CpYQiJaLx1su4TZvcf2yKsfvqXzsS+EsKS3T+GD9W/oDl1ThM1gXEvMfErzMVje2eOjl
 xsF1BK7UA9/fGuFJQX8DT+WR6g1aCC/5HtemZxIILmikzlIvfsBYQIxZDkhC/9BV700U
 vL9w==
X-Gm-Message-State: AOJu0YxnuXXElqTQHKqfCxUlpd1z9n8oJ63wcLmZZumdRsPeFu4vp/US
 qe7CoIplUGt0MTMGQyjVs9jVoBL/qi+G15urRWaqC+B54y2MZTjP
X-Gm-Gg: ASbGncsbpWfaxK5k2rcON4VetMjulf6dBPB1fx4Nf7hBPpMeDl02Y1EZJhik7dr+a6e
 La70sh0LwYMlC7PEJj8ofvifLPhn6Y28cPGDPiiP5Ju0Xwq/yYtE0mDMnydnKGAx3Q6siba3XhL
 +4sQdUBu/XLWMCjpBljni6e4IafLiQ3fWxxPIHMqxquwKGHGqB7Fwg4sAhnl/gkD5BUhwZ68e3F
 epa2sGGMp5uN9Wwj0igsdOackNU9i49ugQZcQU7VBOIC/yJ20UYKYX4+/2XdoRmHTHS76hYW4Fc
 1VbX7faCTNQ+bOancGLfkA==
X-Google-Smtp-Source: AGHT+IFKb9rL7p9g6Ic5ogAvhGH7pWjesxQm9X8maAO9iOS8zAMSOHRYXIVn48oJOvWJRvvoOAQ4kw==
X-Received: by 2002:a17:902:fc8f:b0:216:48dd:d15c with SMTP id
 d9443c01a7336-21a83f65a79mr377213275ad.27.1736867037700; 
 Tue, 14 Jan 2025 07:03:57 -0800 (PST)
Received: from ?IPV6:2408:8362:245d:4738:bc4b:53ff:fead:2724?
 ([2401:b60:5:867d:3631:b7db:c3f4:aae2])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f13e9e7sm67920645ad.101.2025.01.14.07.03.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 07:03:57 -0800 (PST)
Message-ID: <6ace686e-6cb7-402e-8272-269322353f9e@gmail.com>
Date: Tue, 14 Jan 2025 23:03:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] board: rockchip: add FriendlyElec NanoPi R3S
To: Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass
 <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
References: <20241226092043.419511-1-cnsztl@gmail.com>
 <20241226092043.419511-8-cnsztl@gmail.com>
 <b32bc9f1-3bcf-4cea-8242-e372e68740e3@cherry.de>
From: Tianling Shen <cnsztl@gmail.com>
In-Reply-To: <b32bc9f1-3bcf-4cea-8242-e372e68740e3@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2025/1/14 22:48, Quentin Schulz wrote:
> Hi Tianling,
> 
> On 12/26/24 10:20 AM, Tianling Shen wrote:
>> The NanoPi R3S(as "R3S") is an open source platform with dual-Gbps
>> Ethernet ports designed and developed by FriendlyElec for IoT
>> applications.
>>
>> Specification:
>> - Rockchip RK3566
>> - 2GB LPDDR4X RAM
>> - optional 32GB eMMC module
>> - SD card slot
>> - 2x 1000 Base-T
>> - 3x LEDs (POWER, LAN, WAN)
>> - 2x Buttons (Reset, MaskROM)
>> - 1x USB 3.0 Port
>> - Type-C 5V 2A Power
>>
>> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
>> ---
>>   arch/arm/dts/rk3566-nanopi-r3s-u-boot.dtsi |  8 +++
>>   board/rockchip/evb_rk3568/MAINTAINERS      |  7 ++
>>   configs/nanopi-r3s-rk3566_defconfig        | 74 ++++++++++++++++++++++
>>   doc/board/rockchip/rockchip.rst            |  1 +
>>   4 files changed, 90 insertions(+)
>>   create mode 100644 arch/arm/dts/rk3566-nanopi-r3s-u-boot.dtsi
>>   create mode 100644 configs/nanopi-r3s-rk3566_defconfig
>>
>> diff --git a/arch/arm/dts/rk3566-nanopi-r3s-u-boot.dtsi b/arch/arm/ 
>> dts/rk3566-nanopi-r3s-u-boot.dtsi
>> new file mode 100644
>> index 0000000000..b66e5015d6
>> --- /dev/null
>> +++ b/arch/arm/dts/rk3566-nanopi-r3s-u-boot.dtsi
>> @@ -0,0 +1,8 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +#include "rk356x-u-boot.dtsi"
>> +
>> +&vcc5v0_usb {
>> +    /delete-property/ regulator-always-on;
>> +    /delete-property/ regulator-boot-on;
>> +};
> 
> Please justify this change, this seems very odd.

This change is based on commit 5b155997d445 "rockchip: rk3568-nanopi-r5: 
Update defconfig for NanoPi R5C and R5S" and it's copy&paste.

And another commit a9e9445ea2bb "rockchip: rk3568-nanopi-r5: Enable PCIe 
on NanoPi R5C and R5S" removes the vpcie3v3-supply prop, not sure why.

> 
>> diff --git a/board/rockchip/evb_rk3568/MAINTAINERS b/board/rockchip/ 
>> evb_rk3568/MAINTAINERS
>> index 588134ecb2..b2780401a3 100644
>> --- a/board/rockchip/evb_rk3568/MAINTAINERS
>> +++ b/board/rockchip/evb_rk3568/MAINTAINERS
>> @@ -28,6 +28,13 @@ F:    configs/lubancat-2-rk3568_defconfig
>>   F:    arch/arm/dts/rk3568-lubancat-2.dts
>>   F:    arch/arm/dts/rk3568-lubancat-2-u-boot.dtsi
>> +NANOPI-R3S
>> +M:    Tianling Shen <cnsztl@gmail.com>
>> +R:    Jonas Karlman <jonas@kwiboo.se>
>> +S:    Maintained
>> +F:    configs/nanopi-r3s-rk3566_defconfig
>> +F:    arch/arm/dts/rk3566-nanopi-r3s-u-boot.dtsi
>> +
>>   NANOPI-R5C
>>   M:    Tianling Shen <cnsztl@gmail.com>
>>   R:    Jonas Karlman <jonas@kwiboo.se>
>> diff --git a/configs/nanopi-r3s-rk3566_defconfig b/configs/nanopi-r3s- 
>> rk3566_defconfig
>> new file mode 100644
>> index 0000000000..f21c703ca7
>> --- /dev/null
>> +++ b/configs/nanopi-r3s-rk3566_defconfig
>> @@ -0,0 +1,74 @@
>> +CONFIG_ARM=y
>> +CONFIG_SKIP_LOWLEVEL_INIT=y
>> +CONFIG_COUNTER_FREQUENCY=24000000
>> +CONFIG_ARCH_ROCKCHIP=y
>> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3566-nanopi-r3s"
>> +CONFIG_ROCKCHIP_RK3568=y
>> +CONFIG_SPL_SERIAL=y
>> +CONFIG_SYS_LOAD_ADDR=0xc00800
>> +CONFIG_DEBUG_UART_BASE=0xFE660000
>> +CONFIG_DEBUG_UART_CLOCK=24000000
>> +CONFIG_PCI=y
>> +CONFIG_DEBUG_UART=y
>> +CONFIG_FIT=y
>> +CONFIG_FIT_VERBOSE=y
>> +CONFIG_SPL_FIT_SIGNATURE=y
>> +CONFIG_SPL_LOAD_FIT=y
>> +CONFIG_LEGACY_IMAGE_FORMAT=y
>> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-nanopi-r3s.dtb"
>> +# CONFIG_DISPLAY_CPUINFO is not set
>> +CONFIG_DISPLAY_BOARDINFO_LATE=y
>> +CONFIG_SPL_MAX_SIZE=0x40000
>> +CONFIG_SPL_PAD_TO=0x7f8000
>> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>> +CONFIG_SPL_ATF=y
>> +CONFIG_CMD_GPIO=y
>> +CONFIG_CMD_GPT=y
>> +CONFIG_CMD_I2C=y
>> +CONFIG_CMD_MMC=y
>> +CONFIG_CMD_PCI=y
>> +CONFIG_CMD_USB=y
>> +CONFIG_CMD_PMIC=y
>> +CONFIG_CMD_REGULATOR=y
>> +# CONFIG_SPL_DOS_PARTITION is not set
>> +CONFIG_SPL_OF_CONTROL=y
>> +CONFIG_OF_LIVE=y
>> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned- 
>> clocks assigned-clock-rates assigned-clock-parents"
>> +CONFIG_SPL_DM_SEQ_ALIAS=y
>> +CONFIG_SPL_REGMAP=y
>> +CONFIG_SPL_SYSCON=y
>> +CONFIG_SPL_CLK=y
>> +CONFIG_ROCKCHIP_GPIO=y
>> +CONFIG_SYS_I2C_ROCKCHIP=y
>> +CONFIG_LED=y
>> +CONFIG_LED_GPIO=y
>> +CONFIG_MISC=y
>> +CONFIG_SUPPORT_EMMC_RPMB=y
>> +CONFIG_MMC_DW=y
>> +CONFIG_MMC_DW_ROCKCHIP=y
>> +CONFIG_MMC_SDHCI=y
>> +CONFIG_MMC_SDHCI_SDMA=y
>> +CONFIG_MMC_SDHCI_ROCKCHIP=y
>> +CONFIG_PHY_REALTEK=y
>> +CONFIG_DWC_ETH_QOS=y
>> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
>> +CONFIG_RTL8169=y
>> +CONFIG_NVME_PCI=y
> 
> I didn't see any PCIe connector for an NVMe on the R3S[1]? Did I miss 
> something? The wiki seems to indicate there may be an NVME but that 
> could be just a bad copy-pasting[2]?

Yes, I checked this board and it does not have NVMe slot. I will send a 
new patch to disable it.

Thanks,
Tianling.

> 
> [1] https://wiki.friendlyelec.com/wiki/index.php/NanoPi_R3S
> [2] https://wiki.friendlyelec.com/wiki/index.php/ 
> NanoPi_R3S#Expand_Docker_Storage
> 
> Cheers,
> Quentin

