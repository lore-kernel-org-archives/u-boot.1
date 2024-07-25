Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23256C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 20:45:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B71E8827A;
	Thu, 25 Jul 2024 22:45:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OcfgpEkr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37F3188297; Thu, 25 Jul 2024 22:45:25 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 959C4879AF
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 22:45:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-70365f905b6so238668a34.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 13:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721940321; x=1722545121; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YhvScFX5BdIUiBomY75LaiOxYVKf+WruzO53ubsgAS4=;
 b=OcfgpEkrjtx91PNhWOG6Zr6Su7KlDOsU8Wp63QjgQB8DjmXgQR1oRxtlTjNUy/SHth
 lKcnGTqus6LGVwklMJtGRBUt9m6uj13GW7ixyb+pQjYm90hKIioixqPZkIthI1HpkNE3
 9wD9Vepk1vgyJy1r/+EDCuWztokejhL/vnJKQU7y7hB/tKR17Dd+cMwLcMWVf1vkCYW8
 ITBKlxoMuA763jUOGwllSzLckDXYyYrd2MQAfxnQ9L3gTlnJ6lljb99h3d92gDJ+av9Z
 kNmGd2LryrziWALPrA3Uq59jZNj0+Ya9X+iFd1HlJcgI4vdYnF4Y+t4wkWH7yOWAnjkk
 kB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721940321; x=1722545121;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YhvScFX5BdIUiBomY75LaiOxYVKf+WruzO53ubsgAS4=;
 b=va6Rx2B9YZVkJQSXaF54TemfD+rYsy33+OvS5GjOF1GX0XQ0C+rgkjmgW5dQlsNACi
 clxEY+Akee8iQ31iV1S/ai6VdHdAWLveB2SEXxkeoMceyuPrzOn3nYLVzqYvTuA613D2
 tOtPSED4pnGBhSwbYWyl/QzYx/fqqnSOcP4M9OCgZqT8Iny2CP4Tls9fIEQh8AzXAK/o
 jHMWgkqgtj0H43Z9VlxdqafMkkXpSF6j7TwVN2sm2+muDJHQOHo5rqREwmYjFz80PnZM
 CWi/muo2DjpEEtGb3c1dnRVVcYVYNzxpwnVMaP5FD7QNxHsxoejum7kKinXGrYPxR6VF
 fwiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPnjoc6BiHpev9azDcCUP3T88Mar2deRTPAxzrayPQAo6edyDvyKQhy3WxooZ4YIJxUsGCsI0WuxooH0XD73aWoAp6rw==
X-Gm-Message-State: AOJu0YyilFIEHDzV1a3f6YmfDUNXedMuRVplU84Agu5OA04ZObkNLhH+
 U4i5feSQ1I8Zmtcd42NG8qW5uD1YfNIk7PPhFie2G85WwS7xJLRHNaK14X5Fnhk=
X-Google-Smtp-Source: AGHT+IF1O7tWqR934x221C+EgX7piIWRmcP3ztz/kvdEYKy9MnSf09JxO2cEUSksubvKVYl0OSGnCg==
X-Received: by 2002:a05:6830:678a:b0:703:79c6:a9bb with SMTP id
 46e09a7af769-7092e68b3eemr4826356a34.7.1721940321286; 
 Thu, 25 Jul 2024 13:45:21 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7093072f28csm463986a34.45.2024.07.25.13.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 13:45:21 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Minkyu Kang <mk7.kang@samsung.com>, Minkyu Kang <promsoft@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v4 00/38] mmc: dw_mmc: Enable eMMC on E850-96 board
Date: Thu, 25 Jul 2024 15:44:42 -0500
Message-Id: <20240725204520.18134-1-semen.protsenko@linaro.org>
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

Changes in v4:
  - Rebased all patches on top of the most recent master; patches that
    were affected by recent changes: 08/38, 13/38, 37/38

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
 drivers/mmc/dw_mmc.c                       | 547 +++++++++++++--------
 drivers/mmc/exynos_dw_mmc.c                | 357 +++++++++-----
 drivers/mmc/ftsdc010_mci.h                 |   1 -
 drivers/mmc/hi6220_dw_mmc.c                |   7 +-
 drivers/mmc/nexell_dw_mmc.c                |   5 +-
 drivers/mmc/rockchip_dw_mmc.c              |   5 +-
 drivers/mmc/s5p_sdhci.c                    |   2 +-
 drivers/mmc/snps_dw_mmc.c                  |   6 +-
 drivers/mmc/socfpga_dw_mmc.c               |   4 +-
 include/dwmmc.h                            | 242 +++++----
 27 files changed, 868 insertions(+), 533 deletions(-)

-- 
2.39.2

