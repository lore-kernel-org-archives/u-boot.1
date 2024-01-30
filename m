Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1187C46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 19:01:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF2A187BAD;
	Tue, 30 Jan 2024 20:01:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UfKAZjw+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C6598798B; Tue, 30 Jan 2024 20:01:42 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE6CF8774B
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 20:01:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a26fa294e56so554317666b.0
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 11:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706641300; x=1707246100; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DOLaQwh51zApHGNsYefMjqeRStAsKD+dGGc7kT7AuF8=;
 b=UfKAZjw+aUbAt0p8xvQ1y7an46YNLegG63hiufQfk0G/rMqPOiajWo9QdRK0vX5z2h
 rIsry1zmCbEvXZ5jtHI74q/rtNHBa+i5q0ilO9rY5vaY7I6bxLlhe1laZmRgzeaY4t+9
 z0jrjp3FGsuffYxI2vpS6LpnpxSwImVCJX4CUxe5xRVWshqtY9e9LMRwQ05tebDdGypR
 jfGTxYmrWxC2DynodpKdhrww1YOUPrcix0/rsSw4x21V46zdqBQohwKkSMf1aijrfQfG
 nekDUPP09Lub8HWQm0cDJ8KWKojVDSgwhH+Ki5uOsBQBNDglMOml1C5cq9zADF50NVyy
 KOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706641300; x=1707246100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DOLaQwh51zApHGNsYefMjqeRStAsKD+dGGc7kT7AuF8=;
 b=S45sWUstgiyAcWqBHlxVwyk1s8UGy+ol5rw/tgcugrbr03C+RBBVGl5+JRhAqcXk09
 t5Grl8Nk//SR/iuvZCL2MWNaUy3FLvl66vx6N2RAQVOump+Ds68WoYZQSHs4jh74jB0S
 +X/7l9abs3g14a8QDj6BTwZ/izbLam2d3cARiYbFjtevjpLfAVKiRpnU/FQyyS/eDYrt
 HEXVLHORF41TkWy8Xq+EbOc1J6m4NX96GRD3jjIbCwEoJyq3np9UwL9IyS4t1BWtJp7L
 EBwmG+vXs0x6HltPU5mZMW8ij0lk6VY+8vcZl2qHFMiOTDYCEQIsCt/WbtFNLpRYyoLc
 oLxQ==
X-Gm-Message-State: AOJu0Yy31ilypOA5vbJJaPJaqRSZ9PFTDWVMCaiE7/5pM0bMZTAMoX/7
 Aa1F34oR0DhulVNGqZiEc0Vjd+gSU6c81YovIpyj6IM3M2PWdXB7
X-Google-Smtp-Source: AGHT+IE27TRl3+qALdfzNC+5+7QHBZ22qp0UTxbCu2nDq0OFNwRh3d4QtEG97gxwoOYGthRZCv6rmg==
X-Received: by 2002:a17:906:71d8:b0:a30:e782:ee56 with SMTP id
 i24-20020a17090671d800b00a30e782ee56mr161781ejk.27.1706641299916; 
 Tue, 30 Jan 2024 11:01:39 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-14-70.dynamic.telemach.net.
 [86.58.14.70]) by smtp.gmail.com with ESMTPSA id
 s12-20020a17090699cc00b00a2cd74b743csm5377498ejn.3.2024.01.30.11.01.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 11:01:39 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Jagan Teki <jagan@amarulasolutions.com>, linux-sunxi@lists.linux.dev,
 Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Marc Zyngier <maz@kernel.org>,
 James McGregor <james.mcgregor2@arm.com>
Subject: Re: [PATCH] sunxi: H616: Add OrangePi Zero 2W board support
Date: Tue, 30 Jan 2024 20:01:37 +0100
Message-ID: <2715486.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20240130141642.2714470-1-andre.przywara@arm.com>
References: <20240130141642.2714470-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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

Dne torek, 30. januar 2024 ob 15:16:42 CET je Andre Przywara napisal(a):
> The OrangePi Zero 2W is a tiny development board featuring the Allwinner
> H618 SoC, shipping with up to 4GB of LPDDR4 DRAM, a mini-HDMI connector,
> two USB Type-C sockets and a 16MB SPI NOR flash.
> There is an FPC connector to connect an expansion board, which sports
> two more USB Type-A sockets and a 100MBit Ethernet port. Support for
> the expansion board is not in the DT yet, probably a DT overlay would
> cover this in the future.
> 
> Add a defconfig file selecting the right drivers and DRAM options.
> Since the .dts file was synced from the Linux kernel repo already, we
> just need to add one line to the Makefile to actually build the .dtb.
> 
> The DRAM parameters were derived from the values found in the BSP DRAM
> drivers on the SPI NOR flash.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  arch/arm/dts/Makefile             |  1 +
>  board/sunxi/MAINTAINERS           |  5 +++++
>  configs/orangepi_zero2w_defconfig | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 36 insertions(+)
>  create mode 100644 configs/orangepi_zero2w_defconfig
> 
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 0d4b917fb3b..ed3978037ed 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -837,6 +837,7 @@ dtb-$(CONFIG_MACH_SUN50I_H6) += \
>  	sun50i-h6-tanix-tx6-mini.dtb
>  dtb-$(CONFIG_MACH_SUN50I_H616) += \
>  	sun50i-h616-orangepi-zero2.dtb \
> +	sun50i-h618-orangepi-zero2w.dtb \
>  	sun50i-h618-orangepi-zero3.dtb \
>  	sun50i-h618-transpeed-8k618-t.dtb \
>  	sun50i-h616-x96-mate.dtb
> diff --git a/board/sunxi/MAINTAINERS b/board/sunxi/MAINTAINERS
> index a2da6a4a7a2..4bcd9b9af7f 100644
> --- a/board/sunxi/MAINTAINERS
> +++ b/board/sunxi/MAINTAINERS
> @@ -460,6 +460,11 @@ M:	Jernej Skrabec <jernej.skrabec@siol.net>
>  S:	Maintained
>  F:	configs/orangepi_zero2_defconfig
>  
> +ORANGEPI ZERO 2W BOARD
> +M:	Andre Przywara <andre.przywara@arm.com>
> +S:	Maintained
> +F:	configs/orangepi_zero2w_defconfig
> +
>  ORANGEPI ZERO 3 BOARD
>  M:	Andre Przywara <andre.przywara@arm.com>
>  S:	Maintained
> diff --git a/configs/orangepi_zero2w_defconfig b/configs/orangepi_zero2w_defconfig
> new file mode 100644
> index 00000000000..5734d9d839c
> --- /dev/null
> +++ b/configs/orangepi_zero2w_defconfig
> @@ -0,0 +1,30 @@
> +CONFIG_ARM=y
> +CONFIG_ARCH_SUNXI=y
> +CONFIG_DEFAULT_DEVICE_TREE="sun50i-h618-orangepi-zero2w"
> +CONFIG_SPL=y
> +CONFIG_DRAM_SUN50I_H616_DX_ODT=0x07070707
> +CONFIG_DRAM_SUN50I_H616_DX_DRI=0x0e0e0e0e
> +CONFIG_DRAM_SUN50I_H616_CA_DRI=0x0e0e
> +CONFIG_DRAM_SUN50I_H616_ODT_EN=0xaaaaeeee
> +CONFIG_DRAM_SUN50I_H616_TPR6=0x48808080
> +CONFIG_DRAM_SUN50I_H616_TPR10=0x402f6663
> +CONFIG_DRAM_SUN50I_H616_TPR11=0x26262524
> +CONFIG_DRAM_SUN50I_H616_TPR12=0x100f100f
> +CONFIG_MACH_SUN50I_H616=y
> +CONFIG_SUNXI_DRAM_H616_LPDDR4=y
> +CONFIG_DRAM_CLK=792
> +CONFIG_R_I2C_ENABLE=y
> +CONFIG_SPL_SPI_SUNXI=y
> +# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_I2C=y
> +CONFIG_SPL_SYS_I2C_LEGACY=y
> +CONFIG_SYS_I2C_MVTWSI=y
> +CONFIG_SYS_I2C_SLAVE=0x7f
> +CONFIG_SYS_I2C_SPEED=400000
> +CONFIG_MTD=y
> +CONFIG_SPI_FLASH_ZBIT=y
> +CONFIG_AXP313_POWER=y
> +CONFIG_SPI=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_MUSB_GADGET=y
> 




