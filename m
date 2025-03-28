Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5841C36011
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 16:14:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A82281E6C;
	Fri, 28 Mar 2025 17:14:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Iy5sShRh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6233381DED; Fri, 28 Mar 2025 16:35:39 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0ADC381273
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:35:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-85e751cffbeso185774139f.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 08:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743176132; x=1743780932; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FEwrXxKmNKT3h+djwYEOpyHk5i3w+jx368Qkd1n+kc4=;
 b=Iy5sShRhojeJatN8Eb5aQO+NTZEOKDQhOJCqFA4fs0thCwIWYOOycA8qkjDb8YV6gw
 g/POHh/4vuqLAiO2MINsjNXwNzYHdn84er0YICTQkW1YqmV15gFIZfOB7rI1IQ1FBs0X
 MKd84yyZ0Qd7IEIGcd9cWqBCo1I4tf1Aa7IO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743176132; x=1743780932;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FEwrXxKmNKT3h+djwYEOpyHk5i3w+jx368Qkd1n+kc4=;
 b=jsobtH4pdmrdIl3BllIhG/NOTpfpCtpKWOEnpV+0hYcNgyQLCeluOqzOt5k8aWDQH9
 PZDKYrHfqvnYuOn9oKRSljt9OOmgzGcU6qKxE8fxbhneMHDUjirmiXqw4hHywNaCdFZn
 yLZvHbo6WBgKEExgft0jnktBWovGMnmJMiQFvZmznCk4zscFQHWM6NKf7PuyoqBKdHz7
 GwgmjIg9jPF8G5dgArygD9mXDfd6btdogeNPos0PFpPMZ6HGaa122xbWkqwO/YwrdSch
 VsAroIFZmRMto4arbd3aHctrQXeZzz07VXkl0AlmNX1NKFY+3hZuMxGjzcMQS/ePPErX
 XdYA==
X-Gm-Message-State: AOJu0YxbSAKFwxnqLilHWXfIwrRBib8v04OFwAS16FSZU2Vtm0LLGnKj
 0Dcs5c8x66Qywi3GYh1xJhRn1pM4x60aFFhW7tAcHI2p9k4YiflkjIOr9qG0GW1Ysp9KATbLKAY
 =
X-Gm-Gg: ASbGncsiEePSPI4XHSlte5VDBek4uA9APV6nHaTok8B5wwBMAShYPV5B71wASXftRXv
 DVvYudWNRcM7W7cdZFFxcypVwFv6Xhj93OZAuqw6phIbnTk0aDqdwdf1ENopvSg1AmdDGpij3eb
 P9kfvN0AiVP6LNAE6jpNWmYVbNKEOUwC48wi0klzPv9TH3CqnkM1VFcT7dUCGaVzpYSXD15NVnJ
 BLSeRciuVH+CVz74Sz/9IROFbyV1IQB8AvjCeI7eNOKii9pA5GLl0R8ayeNBTON0fZOGJ8bpStT
 8knqglSXyFvMdT5SJHOhk8JIm19W3i5tR4QEaHAqTLPU22MYtXlQGpmvaN9QxbXaNKCSs0AhYj/
 bKmfmiQ==
X-Google-Smtp-Source: AGHT+IGkWeH2idUi1uiI6wu18sidYrRCdW8F/O1fMu/nkgf2W3K9DdzJLCXOOav3sjFLQwDYwroxGw==
X-Received: by 2002:a05:6602:7288:b0:85b:5869:b6a with SMTP id
 ca18e2360f4ac-85e82056580mr1074930939f.3.1743176131486; 
 Fri, 28 Mar 2025 08:35:31 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f4648714b4sm484922173.87.2025.03.28.08.35.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 08:35:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alex Shumsky <alexthreed@gmail.com>,
 Alexandre Vicenzi <linux@alxd.me>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Anand Moon <anand@edgeble.ai>,
 Andy Yan <andyshrk@163.com>, Chris Morgan <macromorgan@hotmail.com>,
 Christopher Obbard <chris.obbard@collabora.com>,
 David Bauer <mail@david-bauer.net>, Dragan Simic <dsimic@manjaro.org>,
 FUKAUMI Naoki <naoki@radxa.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Greg Malysa <greg.malysa@timesys.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Loic Devulder <ldevulder@suse.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>, Sam Edwards <cfsworks@gmail.com>,
 Sebastian Kropatsch <seb-dev@mail.de>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Tianling Shen <cnsztl@gmail.com>, Tim Lunn <tim@feathertop.org>,
 Tom Rini <trini@konsulko.com>, Wadim Egorov <w.egorov@phytec.de>,
 Xiaobo Tian <peterwillcn@gmail.com>
Subject: [PATCH v3 00/31] VBE serial part H: Implement VBE on Rockchip RK3399
Date: Fri, 28 Mar 2025 09:34:40 -0600
Message-ID: <20250328153522.3555472-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 28 Mar 2025 17:14:05 +0100
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

This series still includes the bloblist reverts, at the end, just so
that the board doesn't have on boot, but I have a series locally which
should improve things, so I will send that when complete.

This is (mostly) the final VBE series, but there are a few loose ends to
tidy up:

- cache is disabled in SPL, which slows the boot a little
- pinctrl init needs to be tidied up to avoid warnings
- bloblist logic as above
- bloblist-relocation is partly in board-specific code, partly generic

Other things may become apparently after more usage / testing.

Changes in v3:
- Add blank lines before the node
- Use HAS_FIT for the SPI node also
- Leave fit { node open within #ifdef HAS_FIT
- Move placement of CONFIG_SPL_PAD_TO
- Keep the FIT filename
- Keep the filename for the SPI FIT
- Add a comment about the offsets
- Move template to the vpl file
- Add the BLOBLIST_RELOC condition as well

Changes in v2:
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

Simon Glass (31):
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

 .gitlab-ci.yml                                |   5 +
 arch/arm/dts/rk3399-u-boot.dtsi               |  11 +-
 arch/arm/dts/rockchip-u-boot.dtsi             | 285 ++++++++++--------
 arch/arm/dts/rockchip-vpl-u-boot.dtsi         | 218 ++++++++++++++
 arch/arm/include/asm/spl.h                    |   1 +
 arch/arm/mach-rockchip/Kconfig                |  25 +-
 arch/arm/mach-rockchip/Makefile               |  11 +-
 arch/arm/mach-rockchip/rk3399/Kconfig         |  11 +-
 arch/arm/mach-rockchip/spl.c                  |  18 ++
 arch/arm/mach-rockchip/tpl.c                  |  12 +-
 arch/arm/mach-rockchip/u-boot-tpl-v8.lds      |  13 +
 arch/arm/mach-rockchip/u-boot-vpl-v8.lds      | 107 +++++++
 arch/arm/mach-rockchip/vpl.c                  |  53 ++++
 board/rockchip/evb_rk3399/MAINTAINERS         |   6 +
 boot/vbe_abrec.c                              |  99 ++++++
 cmd/vbe.c                                     |   8 +-
 common/Kconfig                                |  20 ++
 common/bloblist.c                             |  77 ++---
 common/spl/Kconfig                            |   1 +
 common/spl/spl.c                              |   2 +
 common/spl/spl_reloc.c                        |  14 +-
 configs/anbernic-rgxx3-rk3566_defconfig       |   2 +-
 configs/bpi-r2-pro-rk3568_defconfig           |   2 +-
 configs/chromebit_mickey_defconfig            |   2 +-
 configs/chromebook_bob_defconfig              |   2 +-
 configs/chromebook_jerry_defconfig            |   2 +-
 configs/chromebook_kevin_defconfig            |   2 +-
 configs/chromebook_minnie_defconfig           |   2 +-
 configs/chromebook_speedy_defconfig           |   2 +-
 configs/cm3588-nas-rk3588_defconfig           |   2 +-
 configs/coolpi-4b-rk3588s_defconfig           |   2 +-
 configs/coolpi-cm5-evb-rk3588_defconfig       |   2 +-
 configs/coolpi-cm5-genbook-rk3588_defconfig   |   2 +-
 configs/eaidk-610-rk3399_defconfig            |   2 +-
 configs/evb-px30_defconfig                    |   2 +-
 configs/evb-px5_defconfig                     |   2 +-
 configs/evb-rk3036_defconfig                  |   2 +-
 configs/evb-rk3229_defconfig                  |   2 +-
 configs/evb-rk3288_defconfig                  |   2 +-
 configs/evb-rk3308_defconfig                  |   2 +-
 configs/evb-rk3328_defconfig                  |   2 +-
 configs/evb-rk3399_defconfig                  |   2 +-
 configs/evb-rk3568_defconfig                  |   2 +-
 configs/evb-rk3588_defconfig                  |   2 +-
 configs/ficus-rk3399_defconfig                |   2 +-
 configs/firefly-px30_defconfig                |   2 +-
 configs/firefly-rk3288_defconfig              |   2 +-
 configs/firefly-rk3399_defconfig              |   2 +-
 configs/generic-rk3568_defconfig              |   2 +-
 configs/generic-rk3588_defconfig              |   2 +-
 configs/jaguar-rk3588_defconfig               |   2 +-
 configs/khadas-edge-captain-rk3399_defconfig  |   2 +-
 configs/khadas-edge-rk3399_defconfig          |   2 +-
 configs/khadas-edge-v-rk3399_defconfig        |   2 +-
 configs/khadas-edge2-rk3588s_defconfig        |   2 +-
 configs/kylin-rk3036_defconfig                |   2 +-
 configs/leez-rk3399_defconfig                 |   2 +-
 configs/lubancat-2-rk3568_defconfig           |   2 +-
 configs/miqi-rk3288_defconfig                 |   2 +-
 configs/mk808_defconfig                       |   2 +-
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
 configs/odroid-go2_defconfig                  |   2 +-
 configs/odroid-m1-rk3568_defconfig            |   2 +-
 configs/odroid-m1s-rk3566_defconfig           |   2 +-
 configs/odroid-m2-rk3588s_defconfig           |   2 +-
 configs/orangepi-3b-rk3566_defconfig          |   2 +-
 configs/orangepi-5-plus-rk3588_defconfig      |   2 +-
 configs/orangepi-5-rk3588s_defconfig          |   2 +-
 configs/orangepi-r1-plus-lts-rk3328_defconfig |   2 +-
 configs/orangepi-r1-plus-rk3328_defconfig     |   2 +-
 configs/orangepi-rk3399_defconfig             |   2 +-
 configs/phycore-rk3288_defconfig              |   2 +-
 configs/pinebook-pro-rk3399_defconfig         |   2 +-
 configs/pinephone-pro-rk3399_defconfig        |   2 +-
 configs/pinetab2-rk3566_defconfig             |   2 +-
 configs/popmetal-rk3288_defconfig             |   2 +-
 configs/powkiddy-x55-rk3566_defconfig         |   2 +-
 configs/puma-rk3399_defconfig                 |   2 +-
 configs/px30-core-ctouch2-of10-px30_defconfig |   2 +-
 configs/px30-core-ctouch2-px30_defconfig      |   2 +-
 configs/px30-core-edimm2.2-px30_defconfig     |   2 +-
 configs/qnap-ts433-rk3568_defconfig           |   2 +-
 configs/quartz64-a-rk3566_defconfig           |   2 +-
 configs/quartz64-b-rk3566_defconfig           |   2 +-
 configs/quartzpro64-rk3588_defconfig          |   2 +-
 configs/radxa-cm3-io-rk3566_defconfig         |   2 +-
 configs/radxa-e25-rk3568_defconfig            |   2 +-
 configs/radxa-zero-3-rk3566_defconfig         |   2 +-
 configs/rk3399-generic-ddr3_defconfig         | 124 ++++++++
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
 configs/rock-pi-n8-rk3288_defconfig           |   2 +-
 configs/rock-pi-s-rk3308_defconfig            |   2 +-
 configs/rock-s0-rk3308_defconfig              |   2 +-
 configs/rock2_defconfig                       |   2 +-
 configs/rock5a-rk3588s_defconfig              |   2 +-
 configs/rock5b-rk3588_defconfig               |   2 +-
 configs/rock64-rk3328_defconfig               |   2 +-
 configs/rock960-rk3399_defconfig              |   2 +-
 configs/rock_defconfig                        |   2 +-
 configs/rockpro64-rk3399_defconfig            |   2 +-
 configs/sige7-rk3588_defconfig                |   2 +-
 configs/sonoff-ihost-rv1126_defconfig         |   2 +-
 configs/soquartz-blade-rk3566_defconfig       |   2 +-
 configs/soquartz-cm4-rk3566_defconfig         |   2 +-
 configs/soquartz-model-a-rk3566_defconfig     |   2 +-
 configs/tiger-rk3588_defconfig                |   2 +-
 configs/tinker-rk3288_defconfig               |   2 +-
 configs/tinker-s-rk3288_defconfig             |   2 +-
 configs/toybrick-rk3588_defconfig             |   2 +-
 configs/turing-rk1-rk3588_defconfig           |   2 +-
 configs/vyasa-rk3288_defconfig                |   2 +-
 doc/board/rockchip/rockchip.rst               |  13 +
 drivers/ram/rockchip/sdram_rk3399.c           |   6 +-
 include/bloblist.h                            |  10 -
 include/vbe.h                                 |   3 +
 149 files changed, 1074 insertions(+), 325 deletions(-)
 create mode 100644 arch/arm/dts/rockchip-vpl-u-boot.dtsi
 create mode 100644 arch/arm/mach-rockchip/u-boot-vpl-v8.lds
 create mode 100644 arch/arm/mach-rockchip/vpl.c
 create mode 100644 configs/rk3399-generic-ddr3_defconfig

-- 
2.43.0

base-commit: 3f76d803db9b500f43bc534465945a8d2836bb3e
branch: vbi3
