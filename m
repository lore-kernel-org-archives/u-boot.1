Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06498E77199
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 04:39:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF630801E8;
	Mon,  6 Jan 2025 05:39:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DZJ5sHXV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 330F7803DC; Mon,  6 Jan 2025 05:39:33 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 646F9801DE
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 05:39:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=cnsztl@gmail.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-215770613dbso146579965ad.2
 for <u-boot@lists.denx.de>; Sun, 05 Jan 2025 20:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736138369; x=1736743169; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uphmVmM6/gvD3Iqv/ERko4pBMAI5P/6g9xwnkdR0LY4=;
 b=DZJ5sHXVgOCoQ+uw56q0U6Pr84w9zDeS6odZtQN0L3eocZbj7wi+cJ+CGBdnwQTonf
 wfYlAKhSlK4SPQCF3Q1+22XQIbHyvwqWug3TwnD0K7nWjOPXJFKpTrdADusTWBa/EBWk
 cuNde0e1J8MbTnQ5JeZF0Jqy8P8Va6tXlVRI/EmpAVpYo1apTcmryP083GsI4cWOZ0Er
 +YUg0Itx9sJfPNhy6qozDtB/bTSVZyYVJ8ojOSepsBPxXVi2jmC6VSlFZOPbFeJSr4us
 b6WJyQmPXMLIS+xgGwfJanPnM+UOu/ogSYcUA4xo7WckNJDft6YSERnbMj9OICm+RIK3
 wDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736138369; x=1736743169;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uphmVmM6/gvD3Iqv/ERko4pBMAI5P/6g9xwnkdR0LY4=;
 b=dKyKgBxCv0DHV3a7xMmOFgKJWeJXGLBk5UIC73ufpX2pp4SRKwC2nike3G7U1jM51k
 5fSaZkE6tR/vYgXvmA3WgmS/z5pJj5aouVXjnd+49fpbjIX10G1JlyW6Lgd4NDC7pIDe
 ZXqYv6h5pxflOoDIzREykfnp5w2FHwdm4960qz4uU0MiPobbWIseDTTObnnE5brEvscO
 /G1Zk4H2gohuBd+BCzZYU0FpisJNOyebXGOd1h2AcPPgUVj+F83zSNNOYzr4upZlbVSf
 w+uB8wA/f89u2e4mJfNKFLKalvSTJwP4NvZXZLeYed5sxYjr/pvbo5j47ofru0BxbdSD
 UAeQ==
X-Gm-Message-State: AOJu0YyageFmhUBTOXGl5MLB8PBiCnP+ecz2//Aso1X1DcTxInaMR5NV
 iqkEj0fbd+Tk8VZ5UhOFcIBPCOIcZVXZC2Gq8evxmlPt3DW0V2FW
X-Gm-Gg: ASbGncsnE8yCVPRvSaN8jyy/IoHNJIU8eAtbEu3uyOA9HrYGjoYssX96OevaWum28nQ
 l5epzo2yVLCWrjxmyFYnyfekifBZDdaLwRXIhuSElFxvI0tejQrcTUUNw+iLUzLMvU1ePeNOGdN
 WHAuProE5BFE+KgPd8qGRl+Ai3Se5qYTS+ZC/or6fM374Bqk0dw54O+NPleKtZ7LxbbOVmxsTmk
 XQL4qKRqW//RqZ6DldfN34QBCNC5Um3jhbs+lqq8FP0j+qHIR16PIeQW6enobGXo1M6oKB/zeaa
 VA5q2mVEzDYsxIyu3THV
X-Google-Smtp-Source: AGHT+IEZK0oCgYCU4Bs+NGFypvNtxUi8s/2FUQ5hDj+qOPo1rjz+DVDXhHSmAys1qVhnqvzc2NcwBg==
X-Received: by 2002:a17:902:ef08:b0:20b:6d82:acb with SMTP id
 d9443c01a7336-219e6e9f521mr772154565ad.23.1736138368521; 
 Sun, 05 Jan 2025 20:39:28 -0800 (PST)
Received: from ?IPV6:2408:8262:245d:7a88:bc4b:53ff:fead:2724?
 ([2401:b60:5:867d:3631:b7db:c3f4:aae2])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc964b54sm284704085ad.1.2025.01.05.20.39.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Jan 2025 20:39:28 -0800 (PST)
Message-ID: <6f4a2907-8562-4971-a681-3b3b354b0ffa@gmail.com>
Date: Mon, 6 Jan 2025 12:39:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] board: rockchip: add FriendlyElec NanoPi R3S
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
References: <20241226092043.419511-1-cnsztl@gmail.com>
 <20241226092043.419511-8-cnsztl@gmail.com>
 <64da8b26-b624-4451-b187-9b530dc10cd1@rock-chips.com>
From: Tianling Shen <cnsztl@gmail.com>
In-Reply-To: <64da8b26-b624-4451-b187-9b530dc10cd1@rock-chips.com>
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

Hi Kever,

在 2025/1/6 11:06, Kever Yang 写道:
> Hi Tianling.
> 
> You will need add below config for CONFIG_RTL8169:
> 
> CONFIG_SYS_HAS_NONCACHED_MEMORY=y
> 

Thank you for fixing the issue and sorry for my mistake.
I will be more careful next time.

Thanks,
Tianling.

> 
> Or else we will get below error in CI:
> 
>     aarch64:  +   nanopi-r3s-rk3566
> +drivers/net/rtl8169.c:320:2: error: #warning cache-line size is larger 
> than descriptor size [-Werror=cpp]
> +  320 | #warning cache-line size is larger than descriptor size
> +      |  ^~~~~~~
> +cc1: all warnings being treated as errors
> +make[3]: *** [scripts/Makefile.build:257: drivers/net/rtl8169.o] Error 1
> +make[2]: *** [scripts/Makefile.build:398: drivers/net] Error 2
> +make[1]: *** [Makefile:1906: drivers] Error 2
> +make: *** [Makefile:177: sub-make] Error 2
> 
> https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/jobs/988639
> 
> 
> Thanks,
> 
> - Kever
> 
> On 2024/12/26 17:20, Tianling Shen wrote:
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
>> +CONFIG_PCIE_DW_ROCKCHIP=y
>> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
>> +CONFIG_SPL_PINCTRL=y
>> +CONFIG_DM_PMIC=y
>> +CONFIG_PMIC_RK8XX=y
>> +CONFIG_REGULATOR_RK8XX=y
>> +CONFIG_PWM_ROCKCHIP=y
>> +CONFIG_SPL_RAM=y
>> +CONFIG_BAUDRATE=1500000
>> +CONFIG_DEBUG_UART_SHIFT=2
>> +CONFIG_SYS_NS16550_MEM32=y
>> +CONFIG_SYSRESET=y
>> +CONFIG_USB=y
>> +CONFIG_USB_XHCI_HCD=y
>> +CONFIG_USB_DWC3=y
>> +CONFIG_USB_DWC3_GENERIC=y
>> +CONFIG_ERRNO_STR=y
>> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/ 
>> rockchip.rst
>> index 9bab86d234..02d7a4b124 100644
>> --- a/doc/board/rockchip/rockchip.rst
>> +++ b/doc/board/rockchip/rockchip.rst
>> @@ -99,6 +99,7 @@ List of mainline supported Rockchip boards:
>>   * rk3566
>>        - Anbernic RGxx3 (anbernic-rgxx3-rk3566)
>> +     - FriendlyElec NanoPi R3S (nanopi-r3s-rk3566)
>>        - Hardkernel ODROID-M1S (odroid-m1s-rk3566)
>>        - Pine64 PineTab2 (pinetab2-rk3566)
>>        - Pine64 Quartz64-A Board (quartz64-a-rk3566)

