Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97643C4167B
	for <u-boot@archiver.kernel.org>; Sat, 25 Nov 2023 18:39:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3396C870D9;
	Sat, 25 Nov 2023 19:39:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lw9wFXMe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C2A1871AB; Sat, 25 Nov 2023 18:43:24 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EC9A87158
 for <u-boot@lists.denx.de>; Sat, 25 Nov 2023 18:43:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=iuncuim@gmail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2c997467747so5774661fa.1
 for <u-boot@lists.denx.de>; Sat, 25 Nov 2023 09:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700934196; x=1701538996; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RoPaQXs5kwCOGgQtskzKCQHgLNsgwa/aDk3uWUTMHtE=;
 b=lw9wFXMeFDuY/myUyOU6V1DftVIFeqa4M8/N7azkOMpiO6i8pkNT0sYe5toFi+xz6t
 q1VbAruoIg9PLggqnwxUEnO+RM6142WwlM/UCeffzhVOS9iWxsWaidLKAaROo0frvApP
 jeGx91Ii/pDIBuRwBBNO07QlymCfLza9WyxuZ63kHNeoR1uZMKcnlWGrm7D0uyKQqPfW
 PzTxgZrYKFnPm93IoZMZRV5SCauHN9Fyg4Mazoc5/bnyjx8yG7Y1YDB8DQQ5YGJkiSVD
 fFwMLCVNM556qwT2Mq2NIY5PzLvxQusv/oijUSFpALauV49HA6gBC+JWBoLhximCmQLk
 2/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700934196; x=1701538996;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RoPaQXs5kwCOGgQtskzKCQHgLNsgwa/aDk3uWUTMHtE=;
 b=rWxgPYCLUQBaf+B8lZxLMmvLzDKNtYst8vIhQw5VdrwNnwwZRXqHSXBM/o8JhF8vwy
 LHJJoFeNqsNXJ86E7LARl22aTm+rQWN2HisJdFyIpy7DmhFYBRvjdM3X+eUQHLSf2mAu
 UE7Vn3rU1kBI0p3mH0En7MOWmf/en+1+f9sut7sgFBQYM0iBa+aicIYKY7ABVQQQg+Tf
 qhZ0AjfH2VDDMu4uzg6Dwa8Jkf4T9btZGrgAiCA7g3tf9/RaKUx6ybBxjd1bC2w1ncga
 JIDqT+xz58sbUnX5Yx3BjwCNA0IxqQOsYhFyiZlI/1bict5Aoh8ofkOsQiSM04+c80pX
 tjAA==
X-Gm-Message-State: AOJu0Yy+IVDNBa0Pm9LcWZMw7XNlWA+Hy8Adq56FlRwliEpxyfdls6h8
 aMS80znH2cD92EUEGJf2OVo=
X-Google-Smtp-Source: AGHT+IFl6HJxTncbFHoW9isHLjnj9ILw7Nl4xxH6taPv8J+WuLjtXfPizA4RQ9zQFQcVsCLDX9W5jg==
X-Received: by 2002:a2e:94c7:0:b0:2c1:522a:8e25 with SMTP id
 r7-20020a2e94c7000000b002c1522a8e25mr1122870ljh.32.1700934196336; 
 Sat, 25 Nov 2023 09:43:16 -0800 (PST)
Received: from [192.168.99.248] ([94.143.197.234])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a2e7109000000b002c506c89511sm902586ljc.37.2023.11.25.09.43.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Nov 2023 09:43:15 -0800 (PST)
Message-ID: <0eab5c21-4fdc-478e-9071-f43c12e01fb3@gmail.com>
Date: Sat, 25 Nov 2023 20:43:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] sunxi: H616: Add OrangePi Zero 3 board support
Content-Language: en-US
To: Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Vignesh R <vigneshr@ti.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Piotr Oniszczuk <piotr.oniszczuk@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
References: <20231114013106.31336-1-andre.przywara@arm.com>
 <20231114013106.31336-4-andre.przywara@arm.com>
From: Mikhail Kalashnikov <iuncuim@gmail.com>
In-Reply-To: <20231114013106.31336-4-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 25 Nov 2023 19:39:35 +0100
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

Hi Andre!
Thanks for your patches. I started checking and noticed that USB storage
was not working:

=> usb reset
resetting USB...
Bus usb@5200000: USB EHCI 1.00
Bus usb@5200400: USB OHCI 1.0
scanning bus usb@5200000 for devices... 1 USB Device(s) found
scanning bus usb@5200400 for devices... 1 USB Device(s) found
       scanning usb for storage devices... 0 Storage Device(s) found
=> usb storage
No storage devices, perhaps not 'usb start'ed..?

Otherwise my OpiZero3 (4GB) board looks working.
Ethernet works with my 10 Mbps usb-dongle.

sf probe detect spi nor flash:
=> sf probe
SF: Detected zb25vq128 with page size 256 Bytes, erase size 4 KiB, total 
16 MiB

Loading the kernel and running the operating system (from microsd) also
without problems.

Tested-by: Mikhail Kalashnikov <iuncuim@gmail.com>


On 14.11.2023 04:31, Andre Przywara wrote:
> The OrangePi Zero 3 is a small development board featuring the Allwinner
> H618 SoC, shipping with up to 4GB of DRAM, Gigabit Ethernet, a micro-HDMI
> connector and two USB sockets.
> The board uses LPDDR4 DRAM and an X-Powers AXP313a PMIC, support for
> which was recently added to U-Boot.
>
> Add a defconfig file selecting the right drivers and DRAM options.
> Since the .dts file was synced from the Linux kernel repo already, we
> just need to add one line to the Makefile to actually build the .dtb.
>
> The DRAM parameters were derived from the values found in the BSP DRAM
> drivers on the SPI NOR flash.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>   arch/arm/dts/Makefile            |  1 +
>   board/sunxi/MAINTAINERS          |  5 +++++
>   configs/orangepi_zero3_defconfig | 30 ++++++++++++++++++++++++++++++
>   3 files changed, 36 insertions(+)
>   create mode 100644 configs/orangepi_zero3_defconfig
>
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 1be08c5fdc2..5fc888680b3 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -835,6 +835,7 @@ dtb-$(CONFIG_MACH_SUN50I_H6) += \
>   	sun50i-h6-tanix-tx6-mini.dtb
>   dtb-$(CONFIG_MACH_SUN50I_H616) += \
>   	sun50i-h616-orangepi-zero2.dtb \
> +	sun50i-h618-orangepi-zero3.dtb \
>   	sun50i-h616-x96-mate.dtb
>   dtb-$(CONFIG_MACH_SUN50I) += \
>   	sun50i-a64-amarula-relic.dtb \
> diff --git a/board/sunxi/MAINTAINERS b/board/sunxi/MAINTAINERS
> index 00614372119..f556857a391 100644
> --- a/board/sunxi/MAINTAINERS
> +++ b/board/sunxi/MAINTAINERS
> @@ -455,6 +455,11 @@ M:	Jernej Skrabec <jernej.skrabec@siol.net>
>   S:	Maintained
>   F:	configs/orangepi_zero2_defconfig
>   
> +ORANGEPI ZERO 3 BOARD
> +M:	Andre Przywara <andre.przywara@arm.com>
> +S:	Maintained
> +F:	configs/orangepi_zero3_defconfig
> +
>   ORANGEPI PC 2 BOARD
>   M:	Andre Przywara <andre.przywara@arm.com>
>   S:	Maintained
> diff --git a/configs/orangepi_zero3_defconfig b/configs/orangepi_zero3_defconfig
> new file mode 100644
> index 00000000000..e59044f6639
> --- /dev/null
> +++ b/configs/orangepi_zero3_defconfig
> @@ -0,0 +1,30 @@
> +CONFIG_ARM=y
> +CONFIG_ARCH_SUNXI=y
> +CONFIG_DEFAULT_DEVICE_TREE="sun50i-h618-orangepi-zero3"
> +CONFIG_SPL=y
> +CONFIG_DRAM_SUN50I_H616_DX_ODT=0x07070707
> +CONFIG_DRAM_SUN50I_H616_DX_DRI=0x0e0e0e0e
> +CONFIG_DRAM_SUN50I_H616_CA_DRI=0x0e0e
> +CONFIG_DRAM_SUN50I_H616_ODT_EN=0xaaaaeeee
> +CONFIG_DRAM_SUN50I_H616_TPR6=0x44000000
> +CONFIG_DRAM_SUN50I_H616_TPR10=0x402f6663
> +CONFIG_DRAM_SUN50I_H616_TPR11=0x24242624
> +CONFIG_DRAM_SUN50I_H616_TPR12=0x0f0f100f
> +CONFIG_MACH_SUN50I_H616=y
> +CONFIG_SUNXI_DRAM_H616_LPDDR4=y
> +CONFIG_R_I2C_ENABLE=y
> +CONFIG_SPL_SPI_SUNXI=y
> +# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_I2C=y
> +CONFIG_SPL_SYS_I2C_LEGACY=y
> +CONFIG_SYS_I2C_MVTWSI=y
> +CONFIG_SYS_I2C_SLAVE=0x7f
> +CONFIG_SYS_I2C_SPEED=400000
> +CONFIG_SPI_FLASH_ZBIT=y
> +CONFIG_PHY_MOTORCOMM=y
> +CONFIG_SUN8I_EMAC=y
> +CONFIG_AXP313_POWER=y
> +CONFIG_SPI=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_MUSB_GADGET=y
