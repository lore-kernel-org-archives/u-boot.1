Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38426C71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 17:59:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9146482C2F;
	Wed, 18 Jun 2025 19:59:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AOcdEy4b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4EFF82C55; Wed, 18 Jun 2025 19:59:29 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68CFB82BCD
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 19:59:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ade48b24c97so1142625966b.2
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 10:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750269567; x=1750874367; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MfVGggs7n7jBfs5We0j+AgVWwLb2PizqkXOomdVzNa0=;
 b=AOcdEy4bdxWpgN1GhLUvxlii4spn61W7jo4PJbD9CI7suVZsCsZpQd3B0VZ9BFmZS8
 9hi9sjPtVUehwUv/6SDfNkJxhrjr4Yb/P3BTFc9iJUGoG49wr1qBvKiove/4Fpiojr3l
 Y3oxsZdXdRsgE+bdrPpHj3PWddxTPl8ZDxqI0T3s/82Ht/Yrzt4M//fVFXNGqg3oUtNp
 ok8rMv/YKuVRlzddpgI3YmclcT/UkTaDCUU8olYXDrBArL54CWDUyPYM0jAh1RF3OiST
 gqF8pUcsfUY+iX9HYE2uMcz/w2bJyr3XneyW2i8pUENUthIxRhwmD1y5TsXAWIXtZrAo
 sNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750269567; x=1750874367;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MfVGggs7n7jBfs5We0j+AgVWwLb2PizqkXOomdVzNa0=;
 b=lb/nykuqdt63F0ak13o8SlURafxCxogMMIf7ULtwPDI9KsEGUwSd4B/BPZS819tSnQ
 d+jsJGWKg+mlJwI+qphaxThlm88d/KYbj480eUl0UE3CkQZpkyOWv3b9C5DZhnkyghBC
 /I1z3S+wwz4uvb/wpbWtecIptdv6JmaLSnRWfG7htk07H/2pAf7hAoUPjDup9HkdbZrv
 r2AX+aENbSIbtQBc+xJNlmmCOC6PWNtg59uIn2P8j0AV8AJal87Kg4ox0OMTecesb37m
 D4A1qCF1zn9D6zC4CBO5pQdU0AKsjNkBi3FXKR/OKAs3chM5mRGcD9wZHIP0t2OmHo7q
 k45g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwfepM30KfIlz+62u04dAUWWkJIf28MXh94gUAIhoy6kRiqPPXVHF7rvThxtY4Cyj5tVs7YGU=@lists.denx.de
X-Gm-Message-State: AOJu0Yy2qyFd+Ulp1kXUs2rUvXip9yCBvo0GqnISYgP7R7HVAPVWXx1Z
 D1lazkSiHkwev5CK5CqeDs+sl+hE5/OW/L6nX4/1QeYij5lWyrzhDJfdjBN+Ay0KqBs=
X-Gm-Gg: ASbGncsBszfVGKNpTAwespANhBzOhdVCzdoakJ/TLOmB4fj8aDGPlq2pzhoHAP8pp0X
 os3RYE347CIiEl3mMHqM3Tx5SjYptaAe84giKcRWvM7rY7kdtNc09eFmBasmrzF7SlFo+uIaMFO
 epYpYLmKBi7w+AdgDJe04O9e36lqDfcq/TD7utM2ZkOaFE+etRjcEtbyjAxjpvu65zwAAMuipJG
 uKX5AYGHdhEzHaGI0s0tReH57aodSHDPlY5bQWJ1eV8F4+G2p/f0KwAwqjMQKO9M7miZeQX7Ibr
 /pzvELP7FsJCB0h6h8yAhZjgq3YadC1/4Bt9ux6gxsKyf3LXgxmZ2t9Jj2sdjWbM8vS3//Gkrf2
 oUzVpmIHOEOfQlpEAUw9s7oXL1q+PonUjdT/piAFH+kmObiUb4h8=
X-Google-Smtp-Source: AGHT+IHe0021uAFW9sVPg6KahP6Xkt/fODD64we0cS1SSHbUR604BG/s0bQZdvrvWI3hBK+CdLS7Bw==
X-Received: by 2002:a17:906:6a25:b0:ade:2c48:1ba7 with SMTP id
 a640c23a62f3a-adfad4b7ce7mr1545741466b.55.1750269566742; 
 Wed, 18 Jun 2025 10:59:26 -0700 (PDT)
Received: from [192.168.23.225] (ip-037-024-206-101.um08.pools.vodafone-ip.de.
 [37.24.206.101]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-adec897a70bsm1088491266b.154.2025.06.18.10.59.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Jun 2025 10:59:25 -0700 (PDT)
Message-ID: <df214fa3-1fbc-4f9b-8932-59de653efd27@linaro.org>
Date: Wed, 18 Jun 2025 19:59:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/28] Support to run U-Boot on sc7180 Trogdor
 Chromebooks
To: Stephen Boyd <swboyd@chromium.org>, u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
References: <20250523225845.2311989-1-swboyd@chromium.org>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250523225845.2311989-1-swboyd@chromium.org>
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

There are multiple build errors with this branch, I started trying to 
fix a few but I think there's enough to warrant a respin...

Please build test for x86 and coreboot targets (try buildman)!

CI failures are here 
https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/jobs/1174915

Kind regards,

On 5/24/25 00:58, Stephen Boyd wrote:
> This series supports running U-Boot as a payload on sc7180 Trogdor
> Chromebooks like Lazor or Wormdingler. This is a jumble of different
> patches to get to the final goal of booting a Linux distro from the eMMC
> on Lazor. I'm able to boot Fedora Workstation 41 from a USB stick on my
> Lazor.
> 
> I moved the reviewed patch to the start. After that one line fix there's
> a few patches to add support for the particular SoC used on Trogdor
> devices, sc7180. The next set of patches move the coreboot logic out of
> arch/x86/ into lib/ to find the coreboot tables on ARM and stash them in
> global data. Then I have a handful of patches to let the coreboot
> commands and utilities parse and populate various things like pstore and
> firmware details into the DTB with the proper data from the coreboot
> tables. Finally, I add the calls to coreboot dram parsing code in the
> snapdragon board so that if coreboot tables exist we get the memory info
> from coreboot instead of from an earlier stage DTB.
> 
> I tested the SPI driver with the crosec command. The cros bootflow
> method almost works, but it seems like chromeos userspace blows up
> spectacularly likely because crossystem can't figure out what board it
> is running on. I don't really care too much about booting chromeos
> userspace here so I'm ignoring that problem.
> 
> I'm able to install fedora on Lazor with this as long as I start the USB
> with CONFIG_PREBOOT=y. I tried to get this working on SC7280 Hoglin but
> it crashed in Fedora. I'm not sure why but it could be because the
> memory stuff was all wrong. Either way I hope it may work in the near
> future.
> 
> The display is almost there but I suspect I'll need to do the whole
> initialization all over again so I punted for now.
> 
> TODO:
>   * Get display working
>   * Implement FIT FDT picking similar to depthcharge based on coreboot
>     tables indicating the SKU and board id
> 
> Changes from v3 https://lore.kernel.org/r/20250428192427.3877612-1-swboyd@chromium.org
>   * GPIO chipselect in the SPI driver support
>   * sc7280 clk driver support for UART
>   * Enable the UART clk at probe
>   * Read VPD and inject the wifi MAC address
>   * Patch to inject wifi MAC from the environment
>   * Add a debug_board_init routine for trogdor to support early debug
>   * Add a defconfig
> 
> Changes from v2 https://lore.kernel.org/r/20250226221607.1283592-1-swboyd@chromium.org
>   * Check SPI proto in probe
>   * Handle pins differently in pinctrl driver
>   * Pick up tags
>   * Rebase to ToT
>   * Update pinctrl driver for new changes in last few months
>   * Add some more gates to clk driver to handle missing clk warnings
>   * New patch to locate coreboot tables early
> 
> Changes from v1 https://lore.kernel.org/r/20250220205900.3127680-1-swboyd@chromium.org
>   * Add Kconfig file in lib/coreboot/ to hold the coreboot config stuff
>     similar to EFI
>   * Couple new patches for ximg to support extracting the FDT from
>     chromeos kernel partitions
>   * Move the timestamp file out of arch/x86 as well in a different patch
> 
> Stephen Boyd (28):
>    bootstd: cros: Return negative error code
>    clk: qcom: Add driver for sc7180
>    clk/stub: Add sc7180-rpmh clock
>    clk: qcom: Support uart clk on sc7280 CRD
>    pinctrl: qcom: Add driver for sc7180
>    spi: Add Qualcomm GENI SPI driver
>    serial: msm-geni: Enable SE clk in probe
>    coreboot: Move coreboot logic out of x86 to a generic place
>    coreboot: Set gd->ram_base when parsing tables
>    coreboot: Locate table earlier than arch_cpu_init()
>    arm: Support running U-Boot as a coreboot payload on ARM64
>    cmd/cbsysinfo: Skip the CMOS 'option_table' when not present
>    cmd/cbsysinfo: Allow on ARM as well
>    coreboot: Parse sku_id/fw_config from coreboot tables
>    pstore: Add pstore address from coreboot tables
>    coreboot: Add /firmware/coreboot node to DT
>    coreboot: Move timestamp parsing to generic place
>    coreboot: Dump VPD information in cbsysinfo command
>    coreboot: Set serial# from VPD
>    coreboot: Set wifi mac addr from VPD
>    fdt: Populate wifi MAC from environment
>    mach-snapdragon: Support booting as a coreboot payload
>    mach-snapdragon: Allow usb3 to work when a coreboot payload
>    board: google: Add board_debug_uart_init() for Trogdor
>    cmd: ximg: Support LZO compressed images
>    cmd: ximg: Support LZ4 compressed images
>    configs: Add chromebook_trogdor defconfig
>    doc: chromebook_trogdor: Add document detailing installation steps
> 
>   arch/arm/cpu/armv8/Makefile                   |   1 +
>   arch/arm/cpu/armv8/coreboot/Makefile          |   4 +
>   arch/arm/cpu/armv8/coreboot/cpu.c             |  22 +
>   arch/arm/include/asm/global_data.h            |   3 +
>   arch/arm/mach-snapdragon/board.c              |  23 +
>   arch/arm/mach-snapdragon/of_fixup.c           |  22 +-
>   arch/x86/Kconfig                              |  22 -
>   arch/x86/cpu/coreboot/Kconfig                 |  33 -
>   arch/x86/cpu/coreboot/Makefile                |   1 -
>   arch/x86/cpu/coreboot/coreboot.c              |  16 +-
>   arch/x86/cpu/coreboot/sdram.c                 |  78 +--
>   arch/x86/cpu/cpu.c                            |  15 +-
>   arch/x86/cpu/i386/cpu.c                       |   2 +-
>   arch/x86/lib/bootm.c                          |   5 +-
>   arch/x86/lib/coreboot/Makefile                |   1 -
>   arch/x86/lib/coreboot/cb_support.c            |   2 +-
>   arch/x86/lib/coreboot_table.c                 |   2 +-
>   arch/x86/lib/tables.c                         |   2 +-
>   arch/x86/lib/zimage.c                         |   3 -
>   board/coreboot/coreboot/coreboot.c            |   2 +-
>   board/coreboot/coreboot/sysinfo.c             |   2 +-
>   board/google/chromebook_coral/coral.c         |   2 +-
>   board/google/trogdor/Makefile                 |   3 +
>   board/google/trogdor/debug.config             |   6 +
>   board/google/trogdor/debug_uart.c             |  41 ++
>   boot/Kconfig                                  |   1 +
>   boot/bootmeth_cros.c                          |   2 +-
>   boot/expo_build_cb.c                          |   2 +-
>   boot/fdt_support.c                            |  54 +-
>   boot/image-fdt.c                              |   4 +
>   cmd/Kconfig                                   |   4 +-
>   cmd/Makefile                                  |   1 +
>   cmd/{x86 => }/cbsysinfo.c                     |  40 +-
>   cmd/pstore.c                                  |  51 +-
>   cmd/version.c                                 |   2 +-
>   cmd/x86/Makefile                              |   1 -
>   cmd/x86/cbcmos.c                              |   2 +-
>   cmd/ximg.c                                    |  28 +
>   common/board_f.c                              |   4 +
>   configs/chromebook_trogdor_defconfig          | 138 +++++
>   doc/board/google/chromebook_trogdor.rst       |  69 +++
>   doc/board/google/index.rst                    |   1 +
>   drivers/clk/clk-stub.c                        |   1 +
>   drivers/clk/qcom/Kconfig                      |   8 +
>   drivers/clk/qcom/Makefile                     |   1 +
>   drivers/clk/qcom/clock-sc7180.c               | 153 +++++
>   drivers/clk/qcom/clock-sc7280.c               |  22 +
>   drivers/misc/cbmem_console.c                  |   2 +-
>   drivers/pinctrl/qcom/Kconfig                  |   8 +
>   drivers/pinctrl/qcom/Makefile                 |   1 +
>   drivers/pinctrl/qcom/pinctrl-sc7180.c         | 133 ++++
>   drivers/serial/serial_coreboot.c              |   2 +-
>   drivers/serial/serial_msm_geni.c              |  26 +-
>   drivers/spi/Kconfig                           |  10 +
>   drivers/spi/Makefile                          |   1 +
>   drivers/spi/spi-geni-qcom.c                   | 569 ++++++++++++++++++
>   drivers/video/coreboot.c                      |   2 +-
>   .../x86/include/asm => include}/cb_sysinfo.h  |  51 +-
>   .../include/asm => include}/coreboot_tables.h |  24 +
>   .../coreboot_timestamp.h                      |   9 +-
>   lib/Makefile                                  |   2 +
>   lib/coreboot/Kconfig                          |  55 ++
>   {arch/x86/cpu => lib}/coreboot/Makefile       |  11 +-
>   {arch/x86/lib => lib}/coreboot/cb_sysinfo.c   | 288 ++++++++-
>   {arch/x86/cpu => lib}/coreboot/sdram.c        |  25 +-
>   {arch/x86/cpu => lib}/coreboot/timestamp.c    |  15 +-
>   66 files changed, 1863 insertions(+), 273 deletions(-)
>   create mode 100644 arch/arm/cpu/armv8/coreboot/Makefile
>   create mode 100644 arch/arm/cpu/armv8/coreboot/cpu.c
>   delete mode 100644 arch/x86/cpu/coreboot/Kconfig
>   create mode 100644 board/google/trogdor/Makefile
>   create mode 100644 board/google/trogdor/debug.config
>   create mode 100644 board/google/trogdor/debug_uart.c
>   rename cmd/{x86 => }/cbsysinfo.c (93%)
>   create mode 100644 configs/chromebook_trogdor_defconfig
>   create mode 100644 doc/board/google/chromebook_trogdor.rst
>   create mode 100644 drivers/clk/qcom/clock-sc7180.c
>   create mode 100644 drivers/pinctrl/qcom/pinctrl-sc7180.c
>   create mode 100644 drivers/spi/spi-geni-qcom.c
>   rename {arch/x86/include/asm => include}/cb_sysinfo.h (86%)
>   rename {arch/x86/include/asm => include}/coreboot_tables.h (96%)
>   rename arch/x86/include/asm/arch-coreboot/timestamp.h => include/coreboot_timestamp.h (63%)
>   create mode 100644 lib/coreboot/Kconfig
>   copy {arch/x86/cpu => lib}/coreboot/Makefile (71%)
>   rename {arch/x86/lib => lib}/coreboot/cb_sysinfo.c (62%)
>   copy {arch/x86/cpu => lib}/coreboot/sdram.c (84%)
>   rename {arch/x86/cpu => lib}/coreboot/timestamp.c (83%)
> 
> 
> base-commit: 9d3f1ebaf8751f0287b5d02158cc706435f8fb19

-- 
Casey (she/they)

