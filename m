Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F172EC0219D
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 21:37:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3852E80BA9;
	Sun,  9 Feb 2025 22:36:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NEVeSJGs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD99D807FE; Sun,  9 Feb 2025 22:15:16 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E60F803B5
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 22:15:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3ce915a8a25so13249435ab.1
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 13:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739135711; x=1739740511; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dHhc3uovLzoSJ8Tya2ty54jeX/yfncKJQnCbreJDCHI=;
 b=NEVeSJGs6jFM/C0DDWQMHVtoQTLQ39yPQwB/FD77KfDReam9yI9Se6Ir52YP0E/Tjm
 /gC6nCKlqNPE+vlPzHW58H6r3cijrbF0aEBygUgXnDhljRh4JxF4u0mNO/pfjSnSABgn
 bEMXgYnVeNGK1Ew7Hg1bDwGxcG3032Y4QK4v8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739135711; x=1739740511;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dHhc3uovLzoSJ8Tya2ty54jeX/yfncKJQnCbreJDCHI=;
 b=fXOzy5S+aO8ikJPTSzGanlYozidxDYhU3m4BxRhF5rFwvj539ddoO3FZIrEaJTI3t1
 4a8ZpMuKWCAeZytRUzNX8l//3qKLOv5s2azjBP6g0iKo9uW9brjVRp0MI+/hME5W7VG7
 qpG0hrKRNRVwmtZEBBTDYiwcmL1LpeJIyl7OEr0NHumAZpQB1yJA8NowxPhefFYg5LXA
 qdOuVtWHGSMB7wgS02Dr+NCxh7f25NpeMjm0vaIcJFNKBrIy/BYAIhWoBLencTmjRzNw
 jDg8MEVZG+YYD7iz1rofDGb4ZCTsVY1FGjwub7vShy/smibepRhOkUY/homHPk32Fd0E
 unFw==
X-Gm-Message-State: AOJu0YzRnlyvuhy8jCohfnBXkQ5XyC+4TXFNltXrNOtR23cOQ+3n2Puk
 KrY/bAjgtu97QKWuetU9zCezzp4yKcjg2LWIvl+8f5YJ3xpPqxp7RBhiKuj1oNejj0IH+VPSH7Y
 =
X-Gm-Gg: ASbGnctDfOuGRc9R+epSHWmhfqMmCS0qFFkqBszHaWTcvJJ8jAp43I1rvi0i6C9fBoC
 IWzdvjTsWA0dDojna2PLsRDGFwgLjbG7IPYqAKnD7s+plc21ZjdiCYJq3ZHhUbJKB446qjPXoyP
 cYWwNkUGQc+RRPgRFP6kwJ/UoFWZp073MCbpnZeVRogBoAfPidYjf5BuK3fd0Tw8MOkvf4GVZAt
 2GncAFGhnGv8KNi8BgS47GGC8MPTyHLbhdO+ZeKy0nWQBvh6T3RUMyi9xKzNnL/X5deEXXzu0is
 33lbbUgFUiQwXeqVTDdM2tbC299JsXqB2GW/7pw9OaROtIbZAiCE
X-Google-Smtp-Source: AGHT+IEGbi+gucP3YyCkBREIneQb1bwXJhDtnP6SJSMNHRMmwA31TxFCGsjtODLahKja+fI2Zzv//A==
X-Received: by 2002:a05:6e02:1c8e:b0:3d0:26d5:5504 with SMTP id
 e9e14a558f8ab-3d13dd25356mr78768555ab.7.1739135711193; 
 Sun, 09 Feb 2025 13:15:11 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d05e96f245sm18978655ab.51.2025.02.09.13.15.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 13:15:09 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Akash Gajjar <gajjar04akash@gmail.com>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andreas Schwab <schwab@suse.de>,
 Banglang Huang <banglang.huang@foxmail.com>,
 Dalon Westergreen <dwesterg@gmail.com>,
 Enrico Leto <enrico.leto@siemens.com>, Gary Bisson <bisson.gary@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Humberto Naves <hsnaves@gmail.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Jianfeng Liu <liujianfeng1994@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jonas Karlman <jonas@kwiboo.se>,
 Josua Mayer <josua@solid-run.com>, Leo <ycliang@andestech.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 Patrick Wildt <patrick@blueri.se>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Peter Robinson <pbrobinson@gmail.com>, Phil Sutter <phil@nwl.cc>,
 Richard Henderson <richard.henderson@linaro.org>,
 Siew Chin Lim <elly.siew.chin.lim@intel.com>,
 Srinivas Goud <srinivas.goud@amd.com>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>,
 Tom McLeod <tom.mcleod@opalkelly.com>, Tom Warren <twarren@nvidia.com>,
 Trevor Woerner <twoerner@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Yannic Moog <y.moog@phytec.de>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Subject: [PATCH v2 00/35] VBE serial part H: Implement VBE on Rockchip RK3399
Date: Sun,  9 Feb 2025 14:14:21 -0700
Message-ID: <20250209211502.2299245-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 09 Feb 2025 22:36:48 +0100
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

This series completes the work to enable VBE on a suitable board. Most
of it is rockchip-specific patches to support the VPL phase, i.e. the
one which decides which boot patch to take (A, B or recovery).

A good chunk of this series is adding an image for VBE, by creating a
new Binman image. Future work in Binman may make this more automated /
easier, but for now it is written out in full. The work is undertaken
piecemeal so it is easier to review the steps.

VBE allows similar boards to share firmware images, with perhaps just
TPL (around 75K) being different for each board. Using a common image
for VPL, SPL and U-Boot saves a lot of space in the image and makes
builds easier. Of course, each board still needs a separate devicetree.

Here is the layout of the image:

Name                          Image-pos  Size      Entry-type          Offset    Uncomp-size
----------------------------------------------------------------------------------------------
image                                 0   1b960cf  section                    0
  alternates-fdt                   8000     31000  alternates-fdt          8000
    mkimage                        8000     31000  mkimage                    0
      u-boot-tpl                   8048     12a11  u-boot-tpl                48
  vpl                            208000     16200  fit                   208000
    image-vpl                    209400      a5a3  section                 1400
      section                    209400      a5a3  section                    0
        u-boot-vpl-nodtb                    10348  u-boot-vpl-nodtb           0
        u-boot-vpl-bss-pad                     20  u-boot-vpl-bss-pad     10348
    @fdt-SEQ                          0         0  section                    0
  vbe-a                          800000    39b200  section               800000
    spl-a                        800000    100000  fit                        0
      spl                        801400     10c97  section                 1400
        section                  801400     10c97  section                    0
          u-boot-spl-nodtb                  1a908  u-boot-spl-nodtb           0
          u-boot-spl-bss-pad                  1b0  u-boot-spl-bss-pad     1a908
      @fdt-SEQ                        0         0  section                    0
    u-boot-a                     900000    29b200  fit                   100000
      spl                        902400     10c97  section                 2400
        section                  902400     10c97  section                    0
          u-boot-spl-nodtb                  1a908  u-boot-spl-nodtb           0
          u-boot-spl-bss-pad                  1b0  u-boot-spl-bss-pad     1a908
      u-boot                     913200     e4250  section                13200
        u-boot-nodtb             913200     e4250  u-boot-nodtb               0
      @atf-SEQ                        0         0  section                    0
        atf-bl31                      0         0  atf-bl31                   0
      @tee-SEQ                        0         0  section                    0
        tee-os                        0         0  tee-os                     0
      @fdt-SEQ                        0         0  section                    0
  vbe-b                         1000000    39b200  section              1000000
    spl-b                       1000000    100000  fit                        0
      spl                       1001400     10c97  section                 1400
        section                 1001400     10c97  section                    0
          u-boot-spl-nodtb                  1a908  u-boot-spl-nodtb           0
          u-boot-spl-bss-pad                  1b0  u-boot-spl-bss-pad     1a908
      @fdt-SEQ                        0         0  section                    0
    u-boot-b                    1100000    29b200  fit                   100000
      spl                       1102400     10c97  section                 2400
        section                 1102400     10c97  section                    0
          u-boot-spl-nodtb                  1a908  u-boot-spl-nodtb           0
          u-boot-spl-bss-pad                  1b0  u-boot-spl-bss-pad     1a908
      u-boot                    1113200     e4250  section                13200
        u-boot-nodtb            1113200     e4250  u-boot-nodtb               0
      @atf-SEQ                        0         0  section                    0
        atf-bl31                      0         0  atf-bl31                   0
      @tee-SEQ                        0         0  section                    0
        tee-os                        0         0  tee-os                     0
      @fdt-SEQ                        0         0  section                    0
  vbe-recovery                  1800000    39b200  section              1800000
    spl-recovery                1800000    100000  fit                        0
      spl                       1801400     10c97  section                 1400
        section                 1801400     10c97  section                    0
          u-boot-spl-nodtb                  1a908  u-boot-spl-nodtb           0
          u-boot-spl-bss-pad                  1b0  u-boot-spl-bss-pad     1a908
      @fdt-SEQ                        0         0  section                    0
    u-boot-recovery             1900000    29b200  fit                   100000
      spl                       1902400     10c97  section                 2400
        section                 1902400     10c97  section                    0
          u-boot-spl-nodtb                  1a908  u-boot-spl-nodtb           0
          u-boot-spl-bss-pad                  1b0  u-boot-spl-bss-pad     1a908
      u-boot                    1913200     e4250  section                13200
        u-boot-nodtb            1913200     e4250  u-boot-nodtb               0
      @atf-SEQ                        0         0  section                    0
        atf-bl31                      0         0  atf-bl31                   0
      @tee-SEQ                        0         0  section                    0
        tee-os                        0         0  tee-os                     0
      @fdt-SEQ                        0         0  section                    0
  fdtmap                        1b9b200      2ecf  fdtmap               1b9b200

Unfortunately I got a bit lost trying to figure out the bloblist code,
despite my being the original author. So for now I have included a
revert of a recent patch, so that the logic can be simplified and more
in keeping with the original intent. We may in fact need a symbol which
specifically says which phase creates the bloblist, but I'm not
completely sure of what the reverted patch was trying to achieve.

This is (mostly) the final VBE series, but there are a few loose ends to
tidy up:

- cache is disabled in SPL, which slows the boot a little
- pinctrl init needs to be tidied up to avoid warnings
- bloblist logic as above
- bloblist-relocation is partly in board-specific code, partly generic

Other things may become apparently after more usage / testing.

Changes in v2:
- Add new patch to rename TPL_NEEDS_SEPARATE_STACK
- Add new patch with an SPL_HAVE_INIT_STACK option
- Add new patch to use CONFIG_VAL() to obtain the SPL stack
- Reply on existing CONFIG_VAL() to select the VPL stack
- Correct reference to TPL when VPL was intended
- Put this patch before 'Factor out arch and compression'
- Move VPL things into a separate file
- Mention RK3399 with respect to the memory limit
- Move VPL things into a separate file
- Only enable MMC when VPM is in use.
- Rewrite help for VPL_ROCKCHIP_COMMON_BOARD
- Skip spl-boot-order.c for VPL (rather than modifying it)
- Reword commit to mention comments from Jonas
- Rename to rk3399-generic-ddr3
- Update devicetree to match firefly-rk3399
- Use the firefly devicetree as the default for this board
- Move this patch to the end of the series
- Drop 0x8000 offset for SPI
- Add new patch with a bootmeth driver for abrec
- Split out the fixes for skip-at-start into a new patch
- Move this logic into board-specific code
- Move the actual relocation code to a previous board-specific patch

Simon Glass (35):
  tpl: Rename TPL_NEEDS_SEPARATE_STACK to TPL_HAVE_INIT_STACK
  spl: Add an SPL_HAVE_INIT_STACK option
  spl: Use CONFIG_VAL() to obtain the SPL stack
  arm: Support a separate stack for VPL
  spl: Adjust xPL symbols
  spl: Allow VBE to handle xPL size
  vbe: Show the margin when using SPL_RELOC
  rockchip: Allow RAM init to happen in SPL on rk3399
  rockchip: dts: Correct the OS for U-Boot
  rockchip: dts: Factor out arch and compression
  rockchip: dts: Add an fdtmap
  rockchip: dts: Create a template for the FIT
  rockchip: dts: Un-indent the FIT template
  rockchip: dts: Use the new binman template for the SPI image too
  rockchip: dts: Specify the phase in the image
  rockchip: Provide a bootstd configuration
  rockchip: Add SPL into the main FIT
  rockchip: Include a compatible string in each configuration
  rockchip: Add a template for SPL
  rockchip: Add a VPL image
  rockchip: Add TPL alternatives
  rockchip: Update rk3399 bootph-tags for VPL
  rockchip: Provide a VPL phase on rk3399
  rockchip: Add symbols for spl_reloc
  rockchip: rk3399: Adjust initial TPL-stack to match SPL
  rockchip: Allow SPL to set up SDRAM
  rockchip: Add a generic-ddr3 rk3399 board
  rockchip: Add documentation for VBE
  gitlab: Add an VBE board to the sjg lab
  rockchip: Set the skip-at-start property correctly
  vbe: Add a bootmeth driver for abrec
  rockchip: Update binman image for new skip-at-start setup
  RFC: Revert "bloblist: Load the bloblist from the previous loader"
  rockchip: Relocate bloblist at the end of the SPL phase
  bloblist: Allow using a different bloblist address

 .gitlab-ci.yml                                |   6 +
 arch/arm/cpu/armv7/lowlevel_init.S            |   4 +-
 arch/arm/cpu/armv7/start.S                    |   4 +-
 arch/arm/dts/rk3399-u-boot.dtsi               |  11 +-
 arch/arm/dts/rockchip-u-boot.dtsi             | 324 +++++++++++-------
 arch/arm/dts/rockchip-vpl-u-boot.dtsi         | 166 +++++++++
 arch/arm/include/asm/spl.h                    |   1 +
 arch/arm/lib/crt0.S                           |   6 +-
 arch/arm/lib/crt0_64.S                        |   6 +-
 arch/arm/mach-rockchip/Kconfig                |  39 ++-
 arch/arm/mach-rockchip/Makefile               |  11 +-
 arch/arm/mach-rockchip/rk3399/Kconfig         |  11 +-
 arch/arm/mach-rockchip/spl.c                  |  17 +
 arch/arm/mach-rockchip/tpl.c                  |  12 +-
 arch/arm/mach-rockchip/u-boot-tpl-v8.lds      |  13 +
 arch/arm/mach-rockchip/u-boot-vpl-v8.lds      | 107 ++++++
 arch/arm/mach-rockchip/vpl.c                  |  53 +++
 arch/riscv/cpu/start.S                        |   4 +-
 board/rockchip/evb_rk3399/MAINTAINERS         |   6 +
 boot/vbe_abrec.c                              |  99 ++++++
 cmd/vbe.c                                     |   8 +-
 common/Kconfig                                |  20 ++
 common/bloblist.c                             |  77 ++---
 common/spl/Kconfig                            |  29 +-
 common/spl/Kconfig.tpl                        |  19 +-
 common/spl/Kconfig.vpl                        |  14 +
 common/spl/spl.c                              |   2 +
 common/spl/spl_reloc.c                        |  14 +-
 configs/alt_defconfig                         |   1 +
 configs/anbernic-rgxx3-rk3566_defconfig       |   2 +-
 configs/apalis-tk1_defconfig                  |   1 +
 configs/apalis_t30_defconfig                  |   1 +
 configs/axm_defconfig                         |   1 +
 configs/beaver_defconfig                      |   1 +
 configs/bitmain_antminer_s9_defconfig         |   1 +
 configs/bpi-r2-pro-rk3568_defconfig           |   2 +-
 configs/capricorn_cxg3_defconfig              |   1 +
 configs/cardhu_defconfig                      |   1 +
 configs/cei-tk1-som_defconfig                 |   1 +
 configs/cgtqmx8_defconfig                     |   1 +
 configs/chromebit_mickey_defconfig            |   3 +-
 configs/chromebook_bob_defconfig              |   3 +-
 configs/chromebook_jerry_defconfig            |   3 +-
 configs/chromebook_kevin_defconfig            |   3 +-
 configs/chromebook_minnie_defconfig           |   3 +-
 configs/chromebook_speedy_defconfig           |   3 +-
 configs/ci20_mmc_defconfig                    |   1 +
 configs/clearfog_defconfig                    |   1 +
 configs/clearfog_sata_defconfig               |   1 +
 configs/clearfog_spi_defconfig                |   1 +
 configs/cm3588-nas-rk3588_defconfig           |   2 +-
 configs/colibri_t20_defconfig                 |   1 +
 configs/colibri_t30_defconfig                 |   1 +
 configs/controlcenterdc_defconfig             |   1 +
 configs/coolpi-4b-rk3588s_defconfig           |   2 +-
 configs/coolpi-cm5-evb-rk3588_defconfig       |   2 +-
 configs/coolpi-cm5-genbook-rk3588_defconfig   |   2 +-
 configs/corvus_defconfig                      |   1 +
 configs/da850evm_defconfig                    |   1 +
 configs/da850evm_nand_defconfig               |   1 +
 configs/dalmore_defconfig                     |   1 +
 configs/db-88f6720_defconfig                  |   1 +
 configs/db-88f6820-amc_defconfig              |   1 +
 configs/db-88f6820-amc_nand_defconfig         |   1 +
 configs/db-88f6820-gp_defconfig               |   1 +
 configs/db-mv784mp-gp_defconfig               |   1 +
 configs/ds116_defconfig                       |   1 +
 configs/ds414_defconfig                       |   1 +
 configs/eaidk-610-rk3399_defconfig            |   2 +-
 configs/endeavoru_defconfig                   |   1 +
 configs/evb-px30_defconfig                    |   2 +-
 configs/evb-px5_defconfig                     |   3 +-
 configs/evb-rk3036_defconfig                  |   3 +-
 configs/evb-rk3229_defconfig                  |   2 +-
 configs/evb-rk3288_defconfig                  |   3 +-
 configs/evb-rk3308_defconfig                  |   2 +-
 configs/evb-rk3328_defconfig                  |   2 +-
 configs/evb-rk3399_defconfig                  |   2 +-
 configs/evb-rk3568_defconfig                  |   2 +-
 configs/evb-rk3588_defconfig                  |   2 +-
 configs/ficus-rk3399_defconfig                |   2 +-
 configs/firefly-px30_defconfig                |   2 +-
 configs/firefly-rk3288_defconfig              |   2 +-
 configs/firefly-rk3399_defconfig              |   2 +-
 .../gardena-smart-gateway-at91sam_defconfig   |   1 +
 configs/generic-rk3568_defconfig              |   2 +-
 configs/generic-rk3588_defconfig              |   2 +-
 configs/gose_defconfig                        |   1 +
 configs/grouper_defconfig                     |   1 +
 configs/harmony_defconfig                     |   1 +
 configs/helios4_defconfig                     |   1 +
 configs/ideapad-yoga-11_defconfig             |   1 +
 configs/imx28_xea_defconfig                   |   1 +
 configs/imx8mm-cl-iot-gate-optee_defconfig    |   1 +
 configs/imx8mm-cl-iot-gate_defconfig          |   1 +
 configs/imx8mm-icore-mx8mm-ctouch2_defconfig  |   1 +
 configs/imx8mm-icore-mx8mm-edimm2.2_defconfig |   1 +
 configs/imx8mm-mx8menlo_defconfig             |   1 +
 configs/imx8mm-phygate-tauri-l_defconfig      |   1 +
 configs/imx8mm_beacon_defconfig               |   1 +
 configs/imx8mm_beacon_fspi_defconfig          |   1 +
 configs/imx8mm_data_modul_edm_sbc_defconfig   |   1 +
 configs/imx8mm_evk_defconfig                  |   1 +
 configs/imx8mm_evk_fspi_defconfig             |   1 +
 configs/imx8mm_phg_defconfig                  |   1 +
 configs/imx8mm_venice_defconfig               |   1 +
 configs/imx8mn_beacon_2g_defconfig            |   1 +
 configs/imx8mn_beacon_defconfig               |   1 +
 configs/imx8mn_beacon_fspi_defconfig          |   1 +
 configs/imx8mn_bsh_smm_s2_defconfig           |   1 +
 configs/imx8mn_bsh_smm_s2pro_defconfig        |   1 +
 configs/imx8mn_ddr4_evk_defconfig             |   1 +
 configs/imx8mn_evk_defconfig                  |   1 +
 configs/imx8mn_var_som_defconfig              |   1 +
 configs/imx8mn_venice_defconfig               |   1 +
 configs/imx8mp-icore-mx8mp-edimm2.2_defconfig |   1 +
 configs/imx8mp_beacon_defconfig               |   1 +
 configs/imx8mp_data_modul_edm_sbc_defconfig   |   1 +
 configs/imx8mp_debix_model_a_defconfig        |   1 +
 configs/imx8mp_dhsom.config                   |   1 +
 configs/imx8mp_evk_defconfig                  |   1 +
 configs/imx8mp_navqp_defconfig                |   1 +
 configs/imx8mp_rsb3720a1_4G_defconfig         |   1 +
 configs/imx8mp_rsb3720a1_6G_defconfig         |   1 +
 configs/imx8mp_venice_defconfig               |   1 +
 configs/imx8mq_cm_defconfig                   |   1 +
 configs/imx8mq_evk_defconfig                  |   1 +
 configs/imx8mq_phanbell_defconfig             |   1 +
 configs/imx8mq_reform2_defconfig              |   1 +
 configs/imx8qm_dmsse20a1_defconfig            |   1 +
 configs/imx8qm_mek_defconfig                  |   1 +
 configs/imx8qxp_mek_defconfig                 |   1 +
 configs/imx8ulp_evk_defconfig                 |   1 +
 configs/imx93-phycore_defconfig               |   1 +
 configs/imx93_11x11_evk_defconfig             |   1 +
 configs/imx93_9x9_qsb_defconfig               |   1 +
 configs/imx93_9x9_qsb_inline_ecc_defconfig    |   1 +
 configs/imx93_var_som_defconfig               |   1 +
 configs/jaguar-rk3588_defconfig               |   2 +-
 configs/jetson-tk1_defconfig                  |   1 +
 configs/k2e_evm_defconfig                     |   1 +
 configs/k2g_evm_defconfig                     |   1 +
 configs/k2hk_evm_defconfig                    |   1 +
 configs/k2l_evm_defconfig                     |   1 +
 configs/khadas-edge-captain-rk3399_defconfig  |   2 +-
 configs/khadas-edge-rk3399_defconfig          |   2 +-
 configs/khadas-edge-v-rk3399_defconfig        |   2 +-
 configs/khadas-edge2-rk3588s_defconfig        |   2 +-
 configs/koelsch_defconfig                     |   1 +
 configs/kontron-sl-mx8mm_defconfig            |   1 +
 configs/kontron_pitx_imx8m_defconfig          |   1 +
 configs/kontron_sl28_defconfig                |   1 +
 configs/kylin-rk3036_defconfig                |   3 +-
 configs/lager_defconfig                       |   1 +
 configs/leez-rk3399_defconfig                 |   2 +-
 configs/librem5_defconfig                     |   1 +
 configs/ls1021aiot_sdcard_defconfig           |   1 +
 configs/ls1021aqds_nand_defconfig             |   1 +
 configs/ls1021aqds_sdcard_ifc_defconfig       |   1 +
 configs/ls1021aqds_sdcard_qspi_defconfig      |   1 +
 configs/ls1021atsn_sdcard_defconfig           |   1 +
 ...s1021atwr_sdcard_ifc_SECURE_BOOT_defconfig |   1 +
 configs/ls1021atwr_sdcard_ifc_defconfig       |   1 +
 configs/ls1021atwr_sdcard_qspi_defconfig      |   1 +
 configs/ls2080aqds_nand_defconfig             |   1 +
 configs/ls2080ardb_nand_defconfig             |   1 +
 configs/lubancat-2-rk3568_defconfig           |   2 +-
 configs/m53menlo_defconfig                    |   1 +
 configs/maxbcm_defconfig                      |   1 +
 configs/medcom-wide_defconfig                 |   1 +
 configs/microblaze-generic_defconfig          |   1 +
 configs/miqi-rk3288_defconfig                 |   2 +-
 configs/mk808_defconfig                       |   5 +-
 configs/msc_sm2s_imx8mp_defconfig             |   1 +
 configs/mt7629_rfb_defconfig                  |   1 +
 configs/n2350_defconfig                       |   1 +
 configs/nanopc-t4-rk3399_defconfig            |   2 +-
 configs/nanopc-t6-rk3588_defconfig            |   2 +-
 configs/nanopi-m4-2gb-rk3399_defconfig        |   2 +-
 configs/nanopi-m4-rk3399_defconfig            |   2 +-
 configs/nanopi-m4b-rk3399_defconfig           |   2 +-
 configs/nanopi-neo4-rk3399_defconfig          |   2 +-
 configs/nanopi-r2c-plus-rk3328_defconfig      |   2 +-
 configs/nanopi-r2c-rk3328_defconfig           |   2 +-
 configs/nanopi-r2s-plus-rk3328_defconfig      |   2 +-
 configs/nanopi-r2s-rk3328_defconfig           |   2 +-
 configs/nanopi-r3s-rk3566_defconfig           |   2 +-
 configs/nanopi-r4s-rk3399_defconfig           |   2 +-
 configs/nanopi-r5c-rk3568_defconfig           |   2 +-
 configs/nanopi-r5s-rk3568_defconfig           |   2 +-
 configs/nanopi-r6c-rk3588s_defconfig          |   2 +-
 configs/nanopi-r6s-rk3588s_defconfig          |   2 +-
 configs/neu2-io-rv1126_defconfig              |   2 +-
 configs/neu6a-io-rk3588_defconfig             |   2 +-
 configs/neu6b-io-rk3588_defconfig             |   2 +-
 configs/nova-rk3588s_defconfig                |   2 +-
 configs/nyan-big_defconfig                    |   1 +
 configs/odroid-go2_defconfig                  |   2 +-
 configs/odroid-m1-rk3568_defconfig            |   2 +-
 configs/odroid-m1s-rk3566_defconfig           |   2 +-
 configs/odroid-m2-rk3588s_defconfig           |   2 +-
 configs/omapl138_lcdk_defconfig               |   1 +
 configs/openpiton_riscv64_spl_defconfig       |   1 +
 configs/orangepi-3b-rk3566_defconfig          |   2 +-
 configs/orangepi-5-plus-rk3588_defconfig      |   2 +-
 configs/orangepi-5-rk3588s_defconfig          |   2 +-
 configs/orangepi-r1-plus-lts-rk3328_defconfig |   2 +-
 configs/orangepi-r1-plus-rk3328_defconfig     |   2 +-
 configs/orangepi-rk3399_defconfig             |   2 +-
 configs/paz00_defconfig                       |   1 +
 configs/phycore-imx8mm_defconfig              |   1 +
 configs/phycore-imx8mp_defconfig              |   1 +
 configs/phycore-rk3288_defconfig              |   3 +-
 configs/pico-imx8mq_defconfig                 |   1 +
 configs/pinebook-pro-rk3399_defconfig         |   2 +-
 configs/pinephone-pro-rk3399_defconfig        |   2 +-
 configs/pinetab2-rk3566_defconfig             |   2 +-
 configs/plutux_defconfig                      |   1 +
 configs/popmetal-rk3288_defconfig             |   3 +-
 configs/porter_defconfig                      |   1 +
 configs/powkiddy-x55-rk3566_defconfig         |   2 +-
 configs/puma-rk3399_defconfig                 |   2 +-
 configs/px30-core-ctouch2-of10-px30_defconfig |   2 +-
 configs/px30-core-ctouch2-px30_defconfig      |   2 +-
 configs/px30-core-edimm2.2-px30_defconfig     |   2 +-
 configs/qc750_defconfig                       |   1 +
 configs/qnap-ts433-rk3568_defconfig           |   2 +-
 configs/quartz64-a-rk3566_defconfig           |   2 +-
 configs/quartz64-b-rk3566_defconfig           |   2 +-
 configs/quartzpro64-rk3588_defconfig          |   2 +-
 configs/r8a77970_eagle_defconfig              |   1 +
 configs/r8a77970_v3msk_defconfig              |   1 +
 configs/r8a77980_condor_defconfig             |   1 +
 configs/r8a77980_v3hsk_defconfig              |   1 +
 configs/r8a77990_ebisu_defconfig              |   1 +
 configs/r8a77995_draak_defconfig              |   1 +
 configs/radxa-cm3-io-rk3566_defconfig         |   2 +-
 configs/radxa-e25-rk3568_defconfig            |   2 +-
 configs/radxa-zero-3-rk3566_defconfig         |   2 +-
 configs/rcar3_salvator-x_defconfig            |   1 +
 configs/rcar3_ulcb_defconfig                  |   1 +
 configs/rk3399-generic-ddr3_defconfig         | 125 +++++++
 configs/roc-cc-rk3308_defconfig               |   2 +-
 configs/roc-cc-rk3328_defconfig               |   2 +-
 configs/roc-pc-mezzanine-rk3399_defconfig     |   2 +-
 configs/roc-pc-rk3399_defconfig               |   2 +-
 configs/rock-3a-rk3568_defconfig              |   2 +-
 configs/rock-3b-rk3568_defconfig              |   2 +-
 configs/rock-3c-rk3566_defconfig              |   2 +-
 configs/rock-4c-plus-rk3399_defconfig         |   2 +-
 configs/rock-4se-rk3399_defconfig             |   2 +-
 configs/rock-5-itx-rk3588_defconfig           |   2 +-
 configs/rock-5c-rk3588s_defconfig             |   2 +-
 configs/rock-pi-4-rk3399_defconfig            |   2 +-
 configs/rock-pi-4c-rk3399_defconfig           |   2 +-
 configs/rock-pi-e-rk3328_defconfig            |   2 +-
 configs/rock-pi-e-v3-rk3328_defconfig         |   2 +-
 configs/rock-pi-n10-rk3399pro_defconfig       |   2 +-
 configs/rock-pi-n8-rk3288_defconfig           |   3 +-
 configs/rock-pi-s-rk3308_defconfig            |   2 +-
 configs/rock-s0-rk3308_defconfig              |   2 +-
 configs/rock2_defconfig                       |   3 +-
 configs/rock5a-rk3588s_defconfig              |   2 +-
 configs/rock5b-rk3588_defconfig               |   2 +-
 configs/rock64-rk3328_defconfig               |   2 +-
 configs/rock960-rk3399_defconfig              |   2 +-
 configs/rock_defconfig                        |   3 +-
 configs/rockpro64-rk3399_defconfig            |   2 +-
 configs/sama5d27_giantboard_defconfig         |   1 +
 configs/sama5d27_som1_ek_mmc1_defconfig       |   1 +
 configs/sama5d27_som1_ek_mmc_defconfig        |   1 +
 configs/sama5d27_som1_ek_qspiflash_defconfig  |   1 +
 configs/sama5d27_wlsom1_ek_mmc_defconfig      |   1 +
 .../sama5d27_wlsom1_ek_qspiflash_defconfig    |   1 +
 configs/sama5d2_icp_mmc_defconfig             |   1 +
 configs/sama5d2_xplained_emmc_defconfig       |   1 +
 configs/sama5d2_xplained_mmc_defconfig        |   1 +
 configs/sama5d2_xplained_qspiflash_defconfig  |   1 +
 configs/sama5d2_xplained_spiflash_defconfig   |   1 +
 configs/sama5d3_xplained_mmc_defconfig        |   1 +
 configs/sama5d3_xplained_nandflash_defconfig  |   1 +
 configs/sama5d3xek_mmc_defconfig              |   1 +
 configs/sama5d3xek_nandflash_defconfig        |   1 +
 configs/sama5d3xek_spiflash_defconfig         |   1 +
 configs/sama5d4_xplained_mmc_defconfig        |   1 +
 configs/sama5d4_xplained_nandflash_defconfig  |   1 +
 configs/sama5d4_xplained_spiflash_defconfig   |   1 +
 configs/sama5d4ek_mmc_defconfig               |   1 +
 configs/sama5d4ek_nandflash_defconfig         |   1 +
 configs/sama5d4ek_spiflash_defconfig          |   1 +
 configs/seaboard_defconfig                    |   1 +
 configs/sifive_unleashed_defconfig            |   1 +
 configs/sifive_unmatched_defconfig            |   1 +
 configs/sige7-rk3588_defconfig                |   2 +-
 configs/silinux_ek874_defconfig               |   1 +
 configs/silk_defconfig                        |   1 +
 configs/smartweb_defconfig                    |   1 +
 configs/socfpga_agilex5_defconfig             |   1 +
 configs/socfpga_agilex_atf_defconfig          |   1 +
 configs/socfpga_agilex_defconfig              |   1 +
 configs/socfpga_agilex_vab_defconfig          |   1 +
 configs/socfpga_arria10_defconfig             |   1 +
 configs/socfpga_arria5_defconfig              |   1 +
 configs/socfpga_cyclone5_defconfig            |   1 +
 configs/socfpga_dbm_soc1_defconfig            |   1 +
 configs/socfpga_de0_nano_soc_defconfig        |   1 +
 configs/socfpga_de10_nano_defconfig           |   1 +
 configs/socfpga_de10_standard_defconfig       |   1 +
 configs/socfpga_de1_soc_defconfig             |   1 +
 configs/socfpga_is1_defconfig                 |   1 +
 configs/socfpga_mcvevk_defconfig              |   1 +
 configs/socfpga_n5x_atf_defconfig             |   1 +
 configs/socfpga_n5x_defconfig                 |   1 +
 configs/socfpga_n5x_vab_defconfig             |   1 +
 configs/socfpga_secu1_defconfig               |   1 +
 configs/socfpga_sockit_defconfig              |   1 +
 configs/socfpga_socrates_defconfig            |   1 +
 configs/socfpga_sr1500_defconfig              |   1 +
 configs/socfpga_stratix10_atf_defconfig       |   1 +
 configs/socfpga_stratix10_defconfig           |   1 +
 configs/socfpga_vining_fpga_defconfig         |   1 +
 configs/sonoff-ihost-rv1126_defconfig         |   2 +-
 configs/soquartz-blade-rk3566_defconfig       |   2 +-
 configs/soquartz-cm4-rk3566_defconfig         |   2 +-
 configs/soquartz-model-a-rk3566_defconfig     |   2 +-
 configs/starfive_visionfive2_defconfig        |   1 +
 ...stm32mp15-icore-stm32mp1-ctouch2_defconfig |   1 +
 ...tm32mp15-icore-stm32mp1-edimm2.2_defconfig |   1 +
 ...-microgea-stm32mp1-microdev2-of7_defconfig |   1 +
 ...mp15-microgea-stm32mp1-microdev2_defconfig |   1 +
 configs/stm32mp15_basic_defconfig             |   1 +
 configs/stm32mp15_dhsom.config                |   1 +
 configs/stout_defconfig                       |   1 +
 configs/surface-rt_defconfig                  |   1 +
 configs/syzygy_hub_defconfig                  |   1 +
 configs/taurus_defconfig                      |   1 +
 configs/tec-ng_defconfig                      |   1 +
 configs/tec_defconfig                         |   1 +
 configs/theadorable_debug_defconfig           |   1 +
 configs/tiger-rk3588_defconfig                |   2 +-
 configs/tinker-rk3288_defconfig               |   2 +-
 configs/tinker-s-rk3288_defconfig             |   2 +-
 configs/topic_miami_defconfig                 |   1 +
 configs/topic_miamilite_defconfig             |   1 +
 configs/topic_miamiplus_defconfig             |   1 +
 configs/toybrick-rk3588_defconfig             |   2 +-
 configs/transformer_t20_defconfig             |   1 +
 configs/transformer_t30_defconfig             |   1 +
 configs/trimslice_defconfig                   |   1 +
 configs/turing-rk1-rk3588_defconfig           |   2 +-
 configs/turris_omnia_defconfig                |   1 +
 configs/uniphier_ld4_sld8_defconfig           |   1 +
 configs/uniphier_v7_defconfig                 |   1 +
 configs/venice2_defconfig                     |   1 +
 configs/ventana_defconfig                     |   1 +
 configs/verdin-imx8mm_defconfig               |   1 +
 configs/verdin-imx8mp_defconfig               |   1 +
 configs/vyasa-rk3288_defconfig                |   3 +-
 configs/work_92105_defconfig                  |   1 +
 configs/x3_t30_defconfig                      |   1 +
 configs/x530_defconfig                        |   1 +
 configs/xilinx_mbv32_defconfig                |   1 +
 configs/xilinx_mbv32_smode_defconfig          |   1 +
 configs/xilinx_mbv64_defconfig                |   1 +
 configs/xilinx_mbv64_smode_defconfig          |   1 +
 configs/xilinx_zynq_virt_defconfig            |   1 +
 configs/xilinx_zynqmp_kria_defconfig          |   1 +
 configs/xilinx_zynqmp_mini_emmc0_defconfig    |   1 +
 configs/xilinx_zynqmp_mini_emmc1_defconfig    |   1 +
 configs/xilinx_zynqmp_mini_qspi_defconfig     |   1 +
 configs/xilinx_zynqmp_virt_defconfig          |   1 +
 configs/zynq_cse_nand_defconfig               |   1 +
 configs/zynq_cse_nor_defconfig                |   1 +
 configs/zynq_cse_qspi_defconfig               |   1 +
 doc/board/rockchip/rockchip.rst               |  13 +
 drivers/ram/rockchip/sdram_rk3399.c           |   6 +-
 include/bloblist.h                            |  10 -
 include/vbe.h                                 |   3 +
 378 files changed, 1367 insertions(+), 360 deletions(-)
 create mode 100644 arch/arm/dts/rockchip-vpl-u-boot.dtsi
 create mode 100644 arch/arm/mach-rockchip/u-boot-vpl-v8.lds
 create mode 100644 arch/arm/mach-rockchip/vpl.c
 create mode 100644 configs/rk3399-generic-ddr3_defconfig

-- 
2.43.0

