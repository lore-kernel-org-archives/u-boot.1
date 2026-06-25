Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 709E7CDE009
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 10:55:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0680A847C8;
	Thu, 25 Jun 2026 12:55:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a5IDZwUC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8171584894; Thu, 25 Jun 2026 12:55:20 +0200 (CEST)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20::1044])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCD478460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 12:55:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=coiaprant@gmail.com
Received: by mail-pj1-x1044.google.com with SMTP id
 98e67ed59e1d1-37ce68a54f8so1596108a91.0
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 03:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782384916; x=1782989716; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=C5QXtTnzkV5TJ1UEupvQ35YkL2CuR7rX1mqTZ812aYQ=;
 b=a5IDZwUCRfjHkadA5F9eXjurVSfLGIMgtMWbQv5Vhre7frKlcxnKh2lnRjyAA+ib3U
 bMWKFghgeLmW6jzZh7pIBfKDb++gzvDT0hWRq0qZgcz6ItgpkGQOHt8i7lT9UQ8mYXCz
 24cIM8sony3HsxOroQ0BI+jNh2BCE/bkU7rI0Bem7aJqEY9+OEZu3LZ3PqeT/h62stbg
 kgFHua1qWT3wHia4bZaRL8FzTECBnWdY/Wf5+Iz+/DxDPWezNKgpnl+ziQpt9o0tLYma
 vshDlJO4vZDWBXl+EiBsRMHO+CjGOImZG7ofJV3HHD+M8Qry3o6vlXrcxBYiGR03GhQc
 s2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782384916; x=1782989716;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C5QXtTnzkV5TJ1UEupvQ35YkL2CuR7rX1mqTZ812aYQ=;
 b=M1SXAyQgcuOpOGF+beGfP377zJrBwvBmm3qsSJY/fIfNipRf57/AgX3f518wK1MBq6
 6XuTTALm9NzEb2pNtUFKI/7T1B/CAwPxPOG5csqvcAkGOKJhEEXvY69BrXyKCAymJx6g
 uSaSwp803c6bT4nj77ELk5g0hj6GceuhGriqBjN4UYQjj/sbfCCCZ2CFx1dVcl7Jfwwn
 igIFaQkEF5ueNymEzn3kIhPaqci/RwMN9rm/65QrBFbRmAiyppvL42c4wGeAKxSGtIQm
 bT8dbOs0fDaVz0NmcZJruGIJds1z3T57weVjYd5rLv/9MiyEI5heT/HVfrQB8X4oJdOy
 YXWA==
X-Gm-Message-State: AOJu0YyY4xJHaY+gdUHvV1jBmXmggvHA5Uyex/GEl5JUvxp4WIZ+/rkU
 cY5d3KYvAU4wwv+x6BFN7WW90W1iWfK1Nn1ZM0FLecYIKfIugu3TRX/9R/on2Y7p6PrbkA==
X-Gm-Gg: AfdE7cnHJlPRdBR9uTW/9i2/yLoKbD1FxJFgzQh4dZPY28F15spVuISRJ1gq1yY2v3g
 mS254ZIXxmM1KsgXpkME3f9M5bLaAeJQUjP6Zh+eYEhk72CagJfO1bStu2pq+8GaQuTmwoQhoAU
 WSYyl7pHiqvJ9rzoqrnhN5pDeabryCBSR365+1/BafOWGJSSaU2eO6qokN1CpBi0UyfI8jD/XrL
 qMhCxOj0DJGljPZRgc7R5UqdrSzuaEwKighm51qPCbTAFyRiEmNfAJwYJNumx8b4I8WCSXrfX8I
 K8cIWIIvFXLTeQBaXuPpYdH4/CDe/KVmr2ymcSk+fKmnFCCwetn29T8cnHsYAvU7hsJeV57yOU7
 Mc5ASSUAqfY3JpoU0xJsEYxTGybMzkQ2HjWU/WKhv9kWuhhXVenBSS76M8WKyYEhOlafTf8czdM
 nN4eXqmtXcHx9oBcfBZYDpVng=
X-Received: by 2002:a17:90b:3f44:b0:37d:f45b:d050 with SMTP id
 98e67ed59e1d1-37dfa2962afmr1894529a91.19.1782384916071; 
 Thu, 25 Jun 2026 03:55:16 -0700 (PDT)
Received: from ehlo.thunderbird.net ([150.230.217.250])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37df3afa990sm1711884a91.4.2026.06.25.03.55.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2026 03:55:15 -0700 (PDT)
Date: Thu, 25 Jun 2026 18:54:58 +0800
From: Coia Prant <coiaprant@gmail.com>
To: Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
CC: u-boot@lists.denx.de
Subject: Re: [PATCH] board: rockchip: Add for 9Tripod X3568 v4
User-Agent: K-9 Mail for Android
In-Reply-To: <ece19d41-5f22-44b8-af6c-b2b57909b678@cherry.de>
References: <20260527112922.554052-1-coiaprant@gmail.com>
 <ece19d41-5f22-44b8-af6c-b2b57909b678@cherry.de>
Message-ID: <37B2BC58-9F48-4A66-8693-DED174E71325@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On June 25, 2026 6:30:46 PM GMT+08:00, Quentin Schulz <quentin=2Eschulz@che=
rry=2Ede> wrote:
>Hi Coia,
>
>On 5/27/26 1:29 PM, Coia Prant wrote:
>> [You don't often get email from coiaprant@gmail=2Ecom=2E Learn why this=
 is important at https://aka=2Ems/LearnAboutSenderIdentification ]
>>=20
>> The 9Tripod X3568 v4 is an RK3568-based SBC, just like the RK3568-EVB=
=2E
>> It always uses soldered connections between the X3568CV2/X3568CV3/X3568=
CV4 core board
>> and the X3568bv4 I/O board=2E
>>=20
>> The differences between the core boards
>> - PCB size, layout
>> - CPU (RKK3568B2/RK3568J)
>> - Memory type (DDR4/LPDDR4/LPDDR4X) and size
>> - eMMC size
>> - DSI/EDP resistor values
>> Although the components vary, they maintain full compatibility=2E
>>=20
>> The X3568 board has multiple hardware revisions, and we currently suppo=
rt v4 (I/O board)=2E
>>=20
>> Specification:
>> - SoC: RockChip RK3568 ARM64 (4 cores)
>> - eMMC: 16-128 GB
>> - RAM: 2-16 GB
>> - Power: DC 12V 2A
>> - Ethernet: 2x YT8521SC RGMII (10/100/1000 Mbps)
>> - Wireless radio: 802=2E11b/g/n/ac/ax dual-band
>> - LED:
>>    Power: AlwaysOn
>>    User: GPIO
>> - Button:
>>    VOL+: SARADC/0 <35k =C2=B5V>
>>    VOL-: SARADC/0 <450k =C2=B5V>
>>    Power/Reset: PMIC RK809
>> - CAN
>>    CAN/1: 4-pin (PH 2=2E0)
>> - PWM
>>    PWM/4: Backlight DSI/0 DSI/1
>>    PWM/7: IR Receiver [may not install]
>> - UART:
>>    UART/2: Debug TTL - 1500000 8N1 (1=2E25mm)
>>    UART/3: TTL (PH 2=2E0)
>>    UART/4: TTL (PH 2=2E0)
>>    UART/8: AP6275S Bluetooth
>>    UART/9: TTL (PH 2=2E0)
>> - I2C:
>>    I2C/0: PMIC RK809
>>    I2C/1: Touchscreen DSI/0 DSI/1
>>    I2C/4: Camera
>>    I2C/5: RTC@51 PCF8563
>> - I2S:
>>    I2S/0: miniHDMI Sound
>>    I2S/1: RK809 Audio Codec
>>    I2S/3: AP6275S Bluetooth Sound
>> - SDMMC:
>>    SDMMC/0: microSD (TF) slot
>>    SDMMC/2: AP6275S SDIO WiFi card
>> - Camera: 1x CSI
>> - Video: miniHDMI / DSI0 (MIPI/LVDS) / DSI1 (MIPI/EDP)
>> - Audio: miniHDMI / MIC on-board / Speaker / SPDIF / 3=2E5mm Headphones=
 / AP6275S Bluetooth
>> - USB:
>>    USB 2=2E0 HOST x2
>>    USB 2=2E0 HOST x3 (4-pin)
>>    USB 2=2E0 OTG x1 (shared with USB 3=2E0 OTG/HOST) [slot may not inst=
all]
>>    USB 3=2E0 HOST x1
>>    USB 3=2E0 OTG/HOST x1
>> - SATA: 1x SATA 3=2E0 with Power/4-pin [slot may not install]
>> - PCIe: 1x PCIe 3=2E0 x2 (x4 connecter) [power/clock/slot may not insta=
ll]
>>=20
>> Link:
>> - https://appletsapi=2E52solution=2Ecom/media/X3568V4%E5%BC%80%E5%8F%91=
%E6%9D%BF%E7%A1%AC%E4%BB%B6%E6%89%8B%E5%86%8C=2Epdf
>> - https://blog=2Egov=2Ecooking/archives/research-ninetripod-x3568-v4-an=
d-flash=2Ehtml
>>=20
>> Signed-off-by: Coia Prant <coiaprant@gmail=2Ecom>
>> ---
>>   =2E=2E=2E/dts/rk3568-9tripod-x3568-v4-u-boot=2Edtsi   |  3 +
>>   board/rockchip/evb_rk3568/MAINTAINERS         |  7 ++
>>   configs/9tripod-x3568-v4-rk3568_defconfig     | 80 ++++++++++++++++++=
+
>>   doc/board/rockchip/rockchip=2Erst               |  1 +
>>   4 files changed, 91 insertions(+)
>>   create mode 100644 arch/arm/dts/rk3568-9tripod-x3568-v4-u-boot=2Edtsi
>>   create mode 100644 configs/9tripod-x3568-v4-rk3568_defconfig
>>=20
>> diff --git a/arch/arm/dts/rk3568-9tripod-x3568-v4-u-boot=2Edtsi b/arch/=
arm/dts/rk3568-9tripod-x3568-v4-u-boot=2Edtsi
>> new file mode 100644
>> index 00000000000=2E=2Ee0cb8e3e7c8
>> --- /dev/null
>> +++ b/arch/arm/dts/rk3568-9tripod-x3568-v4-u-boot=2Edtsi
>> @@ -0,0 +1,3 @@
>> +// SPDX-License-Identifier: (GPL-2=2E0+ OR MIT)
>> +
>> +#include "rk3568-u-boot=2Edtsi"
>
>This file is not necessary as if rk3568-9tripod-x3568-v4-u-boot=2Edtsi is=
 not present, rk3568-u-boot=2Edtsi will be included automatically (due to C=
ONFIG_SYS_SOC being "rk3568")=2E
>
>> diff --git a/board/rockchip/evb_rk3568/MAINTAINERS b/board/rockchip/evb=
_rk3568/MAINTAINERS
>> index 030cdbe6f3d=2E=2E0783fb203c3 100644
>> --- a/board/rockchip/evb_rk3568/MAINTAINERS
>> +++ b/board/rockchip/evb_rk3568/MAINTAINERS
>> @@ -1,3 +1,10 @@
>> +9TRIPOD-X3568-V4
>> +M:     Coia Prant <coiaprant@gmail=2Ecom>
>> +R:     Jonas Karlman <jonas@kwiboo=2Ese>
>
>I'm not sure Jonas has agreed to do this so please drop him from the Revi=
ewer, except if he publicly asks you to=2E
>
>> +S:     Maintained
>> +F:     configs/9tripod-x3568-v4-rk3568_defconfig
>> +F:     arch/arm/dts/rk3568-9tripod-x3568-v4-u-boot=2Edtsi
>> +
>
>Since you can remove the file, this line can also be removed=2E
>
>>   BANANAPI-BPI-R2-PRO
>>   M:     Frank Wunderlich <frank-w@public-files=2Ede>
>>   S:     Maintained
>> diff --git a/configs/9tripod-x3568-v4-rk3568_defconfig b/configs/9tripo=
d-x3568-v4-rk3568_defconfig
>> new file mode 100644
>> index 00000000000=2E=2E71c0087d369
>> --- /dev/null
>> +++ b/configs/9tripod-x3568-v4-rk3568_defconfig
>> @@ -0,0 +1,80 @@
>> +CONFIG_ARM=3Dy
>> +CONFIG_SKIP_LOWLEVEL_INIT=3Dy
>> +CONFIG_SYS_HAS_NONCACHED_MEMORY=3Dy
>> +CONFIG_COUNTER_FREQUENCY=3D24000000
>> +CONFIG_ARCH_ROCKCHIP=3Dy
>> +CONFIG_DEFAULT_DEVICE_TREE=3D"rockchip/rk3568-9tripod-x3568-v4"
>> +CONFIG_ROCKCHIP_RK3568=3Dy
>> +CONFIG_SPL_SERIAL=3Dy
>> +CONFIG_DEBUG_UART_BASE=3D0xFE660000
>> +CONFIG_DEBUG_UART_CLOCK=3D24000000
>> +CONFIG_SYS_LOAD_ADDR=3D0xc00800
>> +CONFIG_PCI=3Dy
>> +CONFIG_DEBUG_UART=3Dy
>> +CONFIG_AHCI=3Dy
>> +CONFIG_FIT=3Dy
>> +CONFIG_FIT_VERBOSE=3Dy
>> +CONFIG_SPL_FIT_SIGNATURE=3Dy
>> +CONFIG_SPL_LOAD_FIT=3Dy
>> +CONFIG_LEGACY_IMAGE_FORMAT=3Dy
>> +CONFIG_DEFAULT_FDT_FILE=3D"rockchip/rk3568-9tripod-x3568-v4=2Edtb"
>> +# CONFIG_DISPLAY_CPUINFO is not set
>> +CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>> +CONFIG_SPL_MAX_SIZE=3D0x40000
>> +CONFIG_SPL_PAD_TO=3D0x7f8000
>> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>> +CONFIG_SPL_ATF=3Dy
>> +CONFIG_CMD_GPIO=3Dy
>> +CONFIG_CMD_GPT=3Dy
>> +CONFIG_CMD_I2C=3Dy
>> +CONFIG_CMD_MMC=3Dy
>> +CONFIG_CMD_PCI=3Dy
>> +CONFIG_CMD_USB=3Dy
>> +CONFIG_CMD_PMIC=3Dy
>> +CONFIG_CMD_REGULATOR=3Dy
>> +# CONFIG_SPL_DOS_PARTITION is not set
>> +CONFIG_SPL_OF_CONTROL=3Dy
>> +CONFIG_OF_LIVE=3Dy
>> +# CONFIG_OF_UPSTREAM is not set
>> +CONFIG_OF_SPL_REMOVE_PROPS=3D"clock-names interrupt-parent assigned-cl=
ocks assigned-clock-rates assigned-clock-parents"
>
>Any reason for removing clock-names from xPL DTB?
>
>Looks ok to me otherwise=2E
>
>Cheers,
>Quentin

Hi Quentin,

Thanks for review, this is the first time I've submitted a patch to u-boot=
=2E

I referred to some other rk3568 boards that had the clock name removed, so=
 I left it as it was=2E There was no problem with the board starting, and I=
 don't know why them remove clocks name=2E

The board is working fine=2E

Best,
Coia
