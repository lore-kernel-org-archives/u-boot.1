Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0113C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 17:57:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D06F8845A;
	Mon, 22 Jul 2024 19:57:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eanhsOPk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F65388453; Mon, 22 Jul 2024 19:57:45 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5004B87919
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 19:57:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5d57d8882eeso585442eaf.1
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 10:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721671061; x=1722275861; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=H+lDjzsxedeaNnwvGvM/1Gm+ENXCOvWAMzkBquDQQEU=;
 b=eanhsOPkRBoNpxZsTFpIb6EL0ZFdQzlyjCIBudYBnTEMRy/MTq8iRAg1wo44M+vFfq
 Fy5tml/cMdjOjFHGiIpTu/iW0LCSqzURVB040uh6AU2mZxX09HShRraDdBg/8CiDuqXU
 AsYNiI7InkRpVH3lTNpw3buPt202jGNx1qmdy49gRN+SJAy/nOYoKYUkzZJDeghIUd7C
 HIWKU5h92oAg/5SEA7cFg+iv1vh6/wdv/uYcW4Cg9A4onPWr4oS5ujz4l95DvW4lk7gL
 y5CmHlME/ogwRHZ+6RUAzP8MWLBiriJTulLoDupB4q+v28/bcQo52mFH7XdQDFcmRkx4
 YE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721671061; x=1722275861;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H+lDjzsxedeaNnwvGvM/1Gm+ENXCOvWAMzkBquDQQEU=;
 b=N1DihTsN0/u5K4uwsl6OEhHSOOdDv5KWU7qn7u2rISok1FNj/rjAkNGCLFdHxMrokv
 VOAInpLuDk5z5bTnIMhkOfxhKYLm0h994o9S+HNQFGkGXQY1zMgEh1zVPWL6wmkMWc6h
 KKT+EUxOz2iS3QYRGYhhSWu9MhXWsqAJdsMKHkQca5T97BjzCn+FfWPdJ5PwCkJiZCMp
 WrW1/XYlacw5b51pez6EXpfAxtVXM4kaJSF5N1ys/g1CHmT1jP9cJXNUbsK9V/rADdey
 vf0btde47ZxHD0wCOIgXkeMN5NBk/d6AAhH4pBObKdEvz/soncwO+adbcsonvE+uSHmf
 qMNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXApociZ1euiT0YqDRRgW41wrhqLV9FAdLritjvhOWEvO3XBBRXvxN1SWA64dtQNU9hQgapMq8QYKR4JKs9SM5bmAhL9g==
X-Gm-Message-State: AOJu0YxXZA95xf4Ci4vMhbkuWon5FsrGd0+TLYzadtzm+DalDvMZz4/2
 I6X1V+s7hZN7hF0wf/w0pw3laKAZeHlXsRSztcHvAngmtlbTs4MIY1qP7BDbHb4=
X-Google-Smtp-Source: AGHT+IFW25eizKALZdzjHezVy24+ZKLvHRLzej0J30e/H0+P8NnWVY8u+8ZR7akxvYYdyl88chjShA==
X-Received: by 2002:a05:6820:4c05:b0:5c6:aea8:aae7 with SMTP id
 006d021491bc7-5d564f5ac2bmr10237047eaf.5.1721671060959; 
 Mon, 22 Jul 2024 10:57:40 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d55a857934sm1413452eaf.25.2024.07.22.10.57.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 10:57:40 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>,
	Minkyu Kang <promsoft@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v3 00/38] mmc: dw_mmc: Enable eMMC on E850-96 board
Date: Mon, 22 Jul 2024 12:57:02 -0500
Message-Id: <20240722175740.6985-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
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

Bring 64-bit support to dw_mmc core and Exynos dw_mmc drivers, and
enable it on E850-96 board. Additionally do some related cleanups and
device tree updates.

64-bit version of DesignWare MMC can be often found on modern ARM64
chips. It's different from its older 32-bit version (which is already
implemented in U-Boot): some new registers were added, existing
register addresses are changed, DMA descriptor table is different, etc.
Next Exynos chips are known to have 64-bit DW MMC block:

  - Exynos3475
  - Exynos5433
  - Exynos7420
  - Exynos7570
  - Exynos7580
  - Exynos7870
  - Exynos7872
  - Exynos7880
  - Exynos7885
  - Exynos7890
  - Exynos850 (Exynos3830)

Exynos DW MMC driver was updated too: ARM64 Exynos chips implement their
clock drivers using CCF framework, pinmux configuration is done at
startup in DM capable pinctrl drivers, device tree properties were
changed w.r.t. their upstream (Linux kernel) counterparts. CLKSEL
register address is also different on 64-bit Exynos platforms.

The patch series was tested on E850-96 board by running mainline Linux
kernel with Debian rootfs from eMMC ("boot" partition) with these
commands:

8<-------------------------------------------------------------------->8
env set fdtaddr 0x8a000000
env set bootaddr 0x94000000
env set boot_kerneladdr 0x94000800
part start mmc 0 boot boot_start
part size mmc 0 boot boot_size
mmc read $bootaddr $boot_start $boot_size
abootimg addr $bootaddr
abootimg get dtb --index=0 dtb_start dtb_size
cp.b $dtb_start $fdtaddr $dtb_size
fdt addr $fdtaddr 0x100000
cp.b $boot_kerneladdr $loadaddr 2aaaa00
env set bootargs console=ttySAC0,115200n8 printk.devkmsg=on \
                 root=/dev/mmcblk0p12 rootwait rw
booti $loadaddr - $fdtaddr
8<-------------------------------------------------------------------->8

For E850-96 eMMC to function properly in DDR mode, the pending patch [1]
has to be applied. Otherwise it won't be possible for exynos_dw_mmc
driver to change CIU clock rate from 200 MHz up to 400 MHz, and MMC will
fall back to SDR mode, which makes eMMC throughput twice as slower. With
patch [1] applied, 'mmc info' reports this:

    Bus Speed: 52000000
    Mode: MMC DDR52 (52MHz)

and 'clk dump' shows CIU clock rate to be ~400 MHz (after first mmc
operation, e.g. 'part start' or 'mmc read'):

    399750000    gout_mmc_embd_sdclkin

Which makes sense, because dw_mmc requests to set CCLKIN = 52 MHz (with
DDR/8-bit mode), and exynos_dw_mmc tries to set CIU clock rate to:

    SDCLKIN = 2 * ciu_div * CCLKIN = 2 * 4 * 52 MHz = 416 MHz,

and the closest possible value the clock driver can set is 399.75 MHz,
which works just fine.

For Exynos4 and Exynos5 (ARM32) boards, this patch series was only build
tested (manually and with buildman). The build is clean (no errors or
warnings), but I don't have any Exynos4/Exynos5 boards at my disposal,
so I can't actually verify MMC operation there.

Changes in v3:
  - Rebased all patches on top of the most recent master, which in turn
    dropped next patches:
    - [PATCH v2 1/40] mmc: dw_mmc: Remove common.h
    - [PATCH v2 33/40] mmc: exynos_dw_mmc: Remove common.h

Changes in v2:
  - Rebased on top of the most recent U-Boot/master
  - Added pending R-b tags from the mailing list
  - Addressed the comment from Quentin about CONFIG_IS_ENABLED() not
    playing nice in SPL case:
    1. Dropped [PATCH 35/42]
       ("mmc: exynos_dw_mmc: Use CONFIG_IS_ENABLED() to check config
        options")
    2. Dropped [PATCH 14/42]
       ("mmc: dw_mmc: Use CONFIG_IS_ENABLED() to check config options")
    3. Got rid of all other CONFIG_IS_ENABLED() changes (used #ifdef for
       now)
  - Addressed the comment from Quentin about incorrect logic for divider
    update in [PATCH 06/40]
  - Guarded exynos_dwmmc_of_to_plat() with #ifded CONFIG_DM_MMC in
    [PATCH 22/40]
  - Added list of Exynos chips implementing 64-bit IDMAC descriptor (in
    [PATCH 00/40])

[1] https://lists.denx.de/pipermail/u-boot/2024-March/547719.html

Sam Protsenko (38):
  mmc: dw_mmc: Remove unused version field from struct dwmci_host
  mmc: dw_mmc: Move struct idmac to dw_mmc.c
  mmc: dw_mmc: Extract waiting for data busy into a separate routine
  mmc: dw_mmc: Extract FIFO init into a separate routine
  mmc: dw_mmc: Extract divider update to a separate function
  mmc: dw_mmc: Extract FIFO data transfer into a separate routine
  mmc: dw_mmc: Extract DMA transfer handling code into a separate
    routine
  mmc: dw_mmc: Extract setting the DMA descriptor into a separate
    routine
  mmc: dw_mmc: Improve 32-bit IDMAC descriptor namings
  mmc: dw_mmc: Add support for 64-bit IDMAC
  mmc: dw_mmc: Replace fifoth_val property with fifo-depth
  mmc: dw_mmc: Fix kernel-doc comments in dwmmc.h
  mmc: dw_mmc: Improve coding style
  arm: dts: exynos: Add upstream DW MMC properties to all Exynos dts
  dt-bindings: exynos: Update bindings doc for DW MMC controller
  arm: exynos: Add header guard for dwmmc.h
  mmc: exynos_dw_mmc: Fix obtaining the base address of controller
  mmc: exynos_dw_mmc: Fix getting private data in
    exynos_dwmci_board_init()
  mmc: exynos_dw_mmc: Don't call pinmux functions on ARM64 chips
  mmc: exynos_dw_mmc: Obtain and use CIU clock via CCF API
  mmc: exynos_dw_mmc: Use .of_to_plat for device tree parsing
  mmc: exynos_dw_mmc: Convert to use livetree API
  mmc: exynos_dw_mmc: Read upstream SDR timing properties
  mmc: exynos_dw_mmc: Abstract CLKSEL register
  mmc: exynos_dw_mmc: Refactor fixed CIU clock divider
  mmc: exynos_dw_mmc: Read common bus-width property
  mmc: exynos_dw_mmc: Read common clock-frequency property
  mmc: exynos_dw_mmc: Move quirks from struct dwmci_host to chip data
  mmc: exynos_dw_mmc: Read and use DDR timing when available
  mmc: exynos_dw_mmc: Set requested freq in get_mmc_clk() callback
  mmc: exynos_dw_mmc: Add support for ARM64 Exynos chips
  mmc: exynos_dw_mmc: Pull all init code into probe function
  mmc: exynos_dw_mmc: Don't call dwmci_setup_cfg() after add_dwmci()
  mmc: exynos_dw_mmc: Use dev->name as driver's displayed name
  mmc: exynos_dw_mmc: Improve coding style
  arm: dts: exynos: Remove outdated DW MMC properties in all Exynos dts
  configs: e850-96: Enable MMC
  doc: samsung: Mention enabled eMMC in E850-96 board doc

 arch/arm/dts/exynos4210-origen.dts         |   3 +-
 arch/arm/dts/exynos4210-trats.dts          |   6 +-
 arch/arm/dts/exynos4210-universal_c210.dts |   6 +-
 arch/arm/dts/exynos4412-odroid.dts         |  14 +-
 arch/arm/dts/exynos4412-trats2.dts         |  20 +-
 arch/arm/dts/exynos5250-arndale.dts        |  10 +-
 arch/arm/dts/exynos5250-smdk5250.dts       |  13 +-
 arch/arm/dts/exynos5250-snow.dts           |  13 +-
 arch/arm/dts/exynos5250-spring.dts         |   7 +-
 arch/arm/dts/exynos5420-smdk5420.dts       |  13 +-
 arch/arm/dts/exynos5422-odroidxu3.dts      |   4 +-
 arch/arm/dts/exynos54xx.dtsi               |  13 +-
 arch/arm/mach-exynos/include/mach/dwmmc.h  |  40 +-
 configs/e850-96_defconfig                  |  10 +-
 doc/board/samsung/e850-96.rst              |   5 +-
 doc/device-tree-bindings/exynos/dwmmc.txt  |  46 +-
 drivers/mmc/ca_dw_mmc.c                    |   2 +-
 drivers/mmc/dw_mmc.c                       | 549 +++++++++++++--------
 drivers/mmc/exynos_dw_mmc.c                | 357 +++++++++-----
 drivers/mmc/ftsdc010_mci.h                 |   1 -
 drivers/mmc/hi6220_dw_mmc.c                |   7 +-
 drivers/mmc/nexell_dw_mmc.c                |   5 +-
 drivers/mmc/rockchip_dw_mmc.c              |   5 +-
 drivers/mmc/s5p_sdhci.c                    |   2 +-
 drivers/mmc/snps_dw_mmc.c                  |   6 +-
 drivers/mmc/socfpga_dw_mmc.c               |   4 +-
 include/dwmmc.h                            | 242 +++++----
 27 files changed, 868 insertions(+), 535 deletions(-)

-- 
2.39.2

