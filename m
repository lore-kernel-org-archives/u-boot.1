Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D36BC021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 01:00:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2360B8007D;
	Fri, 21 Feb 2025 02:00:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QPyfutKP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C9B380141; Fri, 21 Feb 2025 02:00:37 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EEF88006D
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 02:00:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4393dc02b78so10836675e9.3
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 17:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740099634; x=1740704434; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ekmwWgHvzndWAcPOkkenpMLM7XqJHTvKKj4q0UhQ7KM=;
 b=QPyfutKPMkEAvyyDcFxNgPxRlyp5iqF2PuNinfwyRuBoaN0XAicC+J6ODdR5wmQwYB
 xP5dwTgRxzr8zVnw4LxgnqNJ7/cH2IWqp4/8s26hZxdxMUn2amrfpI3uGa1V1+q2kt1L
 2GfB/xIdF46Qq1qnp2v+Cxwe44B8+4X5W+1tsh9XtRKYdqMQdciq1c8ainTXXreVo8EQ
 h7veRV9ctwjhhhjs0OWNpTYGwk2rj1wW45DHw7mogi5wst8r68losnkpVLh7kBs3blnS
 t9OKCfOO6mZErLzjSGEF3tK+4DdGRyzzwowm3GDvcPwds6kw743zUJJHxkhsh8PmBX7B
 UnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740099634; x=1740704434;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ekmwWgHvzndWAcPOkkenpMLM7XqJHTvKKj4q0UhQ7KM=;
 b=InWpyDExFKXe8VhKeOxRpXFuuuPHCwYaXzN/pTpWsNh+F031UAO5qh/6O8Uk/iTsP0
 yyBKe27+K5YKS/yHZtOTMJQvYuneCSrCBxSNxtBaFJp8oV4hG7D2R5AXktQgtj9Dk3xt
 b+yO3yg2n/zaP3NgfaMLVPb2x89heh1Srk1+DtG5XqnL2BJgSGyClq7iJsMeYGitYRUL
 wZrZCOQUFoa4YDbxgrwMxmJZlXyZZumZrZmfsvEahHESUJ288ocdWpKjZMEOi+WpiWUo
 SfENcdloI7/6pTMB+LsHopIqElOFA8ExTp+Hx93h/X2l6qAcQ54cM18EipJwdqR3KrKT
 u9Tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCULFYjvhZUaqPpGxUiAR5zf3pFkG3w24rC8UHCmK2pyXkO9Gn3NMNbegzWXSGkmPJZ9X+UDAo0=@lists.denx.de
X-Gm-Message-State: AOJu0YwHS0h3r49ppwpe9qtGnzLKsCipYYpGVePsw6hdvyJ07rMKdur3
 YMRmiKEJJusOUDFoDpRelbX0tKWXEnDRafyz7N5VQJAxGSlDQqYVRRMbG2OIVPM=
X-Gm-Gg: ASbGncus+X5E7sgxqcL6ptvY6ZCB3KqhB5jsKdV4H7+nk2n0dZ33zrAmtzlMkyllDQI
 A/5Qy9fsUxwv2X7fPryHYK34JC/Mg1wC5XAtFHaxOpT1OCf5XsmpoFuTBTCBPKLzwrmN+v26xwR
 HBA4rwPCRCvP+QEojqbLwxdfq8D7L6iIkm9cmw/PPHwTo2SmQKq8rYnczf7QFiJAIZa2bLmGD/s
 nR371MlkQWr35RQ8pNP/bEAzvhVyUilmEgsrYpv1/qOw7xVD054nwJABGoXRbhNKaqYrH5PehQg
 PttJEXc+xYprbaYA739fdTVAIj+uJQ5aKkVYijEycXseSNxsUdVcd1Hajta/ICIgSHProCGz
X-Google-Smtp-Source: AGHT+IFu9Tw+6FV21RtuUGAYNiKaxrb+rRYSJyFV6qHIZ8dx+Z/8B72L/26JSjXiP4DaG5mrdnBUVw==
X-Received: by 2002:a05:600c:4f09:b0:439:9192:f088 with SMTP id
 5b1f17b1804b1-439ae1e9a07mr8439035e9.8.1740099633906; 
 Thu, 20 Feb 2025 17:00:33 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1d11:ab01:67e2:bb97:e305:259c?
 ([2a0a:ef40:1d11:ab01:67e2:bb97:e305:259c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f25915719sm22178871f8f.60.2025.02.20.17.00.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 17:00:31 -0800 (PST)
Message-ID: <af7c7c35-04e0-4374-b99b-addeec485619@linaro.org>
Date: Fri, 21 Feb 2025 01:00:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] Support to run U-Boot on sc7180 Trogdor Chromebooks
To: Stephen Boyd <swboyd@chromium.org>, u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
References: <20250220205900.3127680-1-swboyd@chromium.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250220205900.3127680-1-swboyd@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Stephen,

On 2/20/25 20:58, Stephen Boyd wrote:
> This series supports running U-Boot as a payload on sc7180 Trogdor
> Chromebooks like Lazor or Wormdingler. This is a jumble of different
> patches to get to the final goal of booting a Linux distro from the eMMC
> on Lazor. I've yet to craft a USB stick with a stock distro but I'll
> probably do that next week.

\o/ wow, this is awesome!

you might have some luck booting pmOS, we build depthcharge compatible 
images for trogdor

https://images.postmarketos.org/bpo/edge/google-trogdor/

There's also a generic ARM64 EFI image that should work. You may need to 
edit the image and remove efi/systemd/drivers/dtbloader.efi from the ESP:

https://images.postmarketos.org/bpo/edge/postmarketos-trailblazer/

> 
> The first few patches add support for the particular SoC sc7180 used on
> Trogdor devices. The next set of patches move the coreboot logic out of
> x86 into lib to find the coreboot tables on ARM and stash them in global
> data. Then I have a handful of patches to let the coreboot commands and
> utilities parse and populate various things like pstore and DT with the
> proper data from the coreboot tables. Finally, I add the calls to
> coreboot dram parsing code in the snapdragon board so that if coreboot
> tables exist we get the memory info from coreboot instead of from an
> earlier stage DTB.
> 
> I tested the spi driver with the crosec command. The cros bootflow
> method almost works, but it seems like chromeos userspace blows up
> spectacularly likely because crossystem can't figure out what board it
> is running on. I don't really care too much about booting chromeos
> userspace here so I'm going to ignore that problem and assume that I can
> boot some Linux distro because the eMMC can be read by U-Boot and the
> kernel boots.

Guess it's time I finally get my hands on one of these devices :D

Kind regards,
> 
> Stephen Boyd (12):
>    clk: qcom: Add driver for sc7180
>    pinctrl: qcom: Add driver for sc7180
>    spi: Add Qualcomm GENI SPI driver
>    coreboot: Move coreboot logic out of x86 to a generic place
>    arm: Support running U-Boot as a coreboot payload on ARM64
>    cmd/cbsysinfo: Skip the CMOS 'option_table' if it isn't present
>    cmd/cbsysinfo: Allow on ARM as well
>    coreboot: Parse sku_id/fw_config from coreboot tables
>    pstore: Add pstore address from coreboot tables
>    coreboot: Add /firmware/coreboot node to DT
>    bootstd: cros: Return negative error code
>    mach-snapdragon: Support booting as a coreboot payload
> 
>   arch/arm/Kconfig                              |   2 +
>   arch/arm/cpu/armv8/Makefile                   |   1 +
>   arch/arm/cpu/armv8/coreboot/Kconfig           |  22 +
>   arch/arm/cpu/armv8/coreboot/Makefile          |   4 +
>   arch/arm/cpu/armv8/coreboot/cpu.c             |  46 ++
>   arch/arm/include/asm/global_data.h            |   3 +
>   arch/arm/mach-snapdragon/board.c              |  18 +
>   arch/x86/Kconfig                              |  21 -
>   arch/x86/cpu/coreboot/coreboot.c              |   4 +-
>   arch/x86/cpu/coreboot/sdram.c                 |  78 +--
>   arch/x86/cpu/coreboot/timestamp.c             |   2 +-
>   arch/x86/cpu/cpu.c                            |   2 +-
>   arch/x86/cpu/i386/cpu.c                       |   2 +-
>   .../x86/include/asm/arch-coreboot/timestamp.h |   2 +-
>   arch/x86/lib/coreboot/Makefile                |   1 -
>   arch/x86/lib/coreboot/cb_support.c            |   2 +-
>   arch/x86/lib/coreboot_table.c                 |   2 +-
>   arch/x86/lib/tables.c                         |   2 +-
>   board/coreboot/coreboot/coreboot.c            |   2 +-
>   board/coreboot/coreboot/sysinfo.c             |   2 +-
>   board/google/chromebook_coral/coral.c         |   2 +-
>   boot/bootmeth_cros.c                          |   2 +-
>   boot/expo_build_cb.c                          |   2 +-
>   boot/image-fdt.c                              |   4 +
>   cmd/Kconfig                                   |   2 +-
>   cmd/Makefile                                  |   1 +
>   cmd/{x86 => }/cbsysinfo.c                     |   6 +-
>   cmd/pstore.c                                  |  44 +-
>   cmd/version.c                                 |   2 +-
>   cmd/x86/Makefile                              |   1 -
>   cmd/x86/cbcmos.c                              |   2 +-
>   drivers/clk/qcom/Kconfig                      |   8 +
>   drivers/clk/qcom/Makefile                     |   1 +
>   drivers/clk/qcom/clock-sc7180.c               | 150 +++++
>   drivers/misc/cbmem_console.c                  |   2 +-
>   drivers/pinctrl/qcom/Kconfig                  |   7 +
>   drivers/pinctrl/qcom/Makefile                 |   1 +
>   drivers/pinctrl/qcom/pinctrl-sc7180.c         | 106 ++++
>   drivers/serial/serial_coreboot.c              |   2 +-
>   drivers/spi/Kconfig                           |  10 +
>   drivers/spi/Makefile                          |   1 +
>   drivers/spi/spi-geni-qcom.c                   | 527 ++++++++++++++++++
>   drivers/video/coreboot.c                      |   2 +-
>   .../x86/include/asm => include}/cb_sysinfo.h  |  12 +-
>   .../include/asm => include}/coreboot_tables.h |  11 +
>   lib/Kconfig                                   |  21 +
>   lib/Makefile                                  |   2 +
>   lib/coreboot/Makefile                         |   4 +
>   {arch/x86/lib => lib}/coreboot/cb_sysinfo.c   | 142 ++++-
>   {arch/x86/cpu => lib}/coreboot/sdram.c        |  15 +-
>   50 files changed, 1165 insertions(+), 145 deletions(-)
>   create mode 100644 arch/arm/cpu/armv8/coreboot/Kconfig
>   create mode 100644 arch/arm/cpu/armv8/coreboot/Makefile
>   create mode 100644 arch/arm/cpu/armv8/coreboot/cpu.c
>   rename cmd/{x86 => }/cbsysinfo.c (99%)
>   create mode 100644 drivers/clk/qcom/clock-sc7180.c
>   create mode 100644 drivers/pinctrl/qcom/pinctrl-sc7180.c
>   create mode 100644 drivers/spi/spi-geni-qcom.c
>   rename {arch/x86/include/asm => include}/cb_sysinfo.h (95%)
>   rename {arch/x86/include/asm => include}/coreboot_tables.h (98%)
>   create mode 100644 lib/coreboot/Makefile
>   rename {arch/x86/lib => lib}/coreboot/cb_sysinfo.c (75%)
>   copy {arch/x86/cpu => lib}/coreboot/sdram.c (87%)
> 
> 
> base-commit: 82d262ae162d859d3b0bbcd40a9464e890b009da

-- 
Caleb (they/them)

