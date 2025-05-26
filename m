Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA3D8C5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 10:20:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8FD783721;
	Mon, 26 May 2025 12:18:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WcCfiJ2f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F01C82B19; Mon, 26 May 2025 12:15:53 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0D0982B0E
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 12:15:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-8613f456960so53681539f.1
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 03:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748254549; x=1748859349; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=R/Y8+wQis300PwbJuk9fpLbXaxXRfoMxXIJRIPfDgYc=;
 b=WcCfiJ2f5RdR87bxerZLmDp4o7CfgBP1Wh3/C74i54fu0UsBNVoapKxFHqngWni6xC
 lBpPtFwfloyhmYnPPc79k3q8XlLS8Aan9QK38LxNtEl7VLlehXjhGiicRQ8vuwGuqZkU
 6tEUELEofWdtMyTDenFvbhqgQRbj3n67O+EMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748254549; x=1748859349;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R/Y8+wQis300PwbJuk9fpLbXaxXRfoMxXIJRIPfDgYc=;
 b=BU4m51ETpsz6ujR3xUpkxEllbfSTEFtNSdjuuOcV/RxKJ1zMkG/Hs7KvilyVuVNRmb
 sC52WdCUQI7vG+yeaTGkfkZ519ewEyQ+L8Cq3SkTq3gtNsDJx0trow6LEVNkJctrXGNc
 95eHqhsLJNyx/ltZKYyNKUuDNWRAvG7OLCGU7iJewiSYtyoXTv4csD0Z1v/I5fcFFtaH
 Uvxgodh/RsucslWOpQUDQq+4vsAIyDfQjNQHK8iCpSwfIyH8z9dlYNqPdCILWxGKz8wL
 dVVYVzI6y+K4gJ7LfV9QxZDVEAHXUfHIuzzzoRkkrVTBqrrvJUv3qoFU4i1cN4vqHEu/
 KXLw==
X-Gm-Message-State: AOJu0YxlT5u4INQPwgYwunMMBvaBS7+OT/RVh0S8FwQO4x1GGQmHxLBf
 9hHUoMtgE9km+xi/Z+b2dBrvudqT8jEAsWjKQnK3mN3myGxuTg37lWeLZnM2dLWlHMQDcfSAtPj
 qUtMY7XJv
X-Gm-Gg: ASbGncuYGFQtZTs6rYiqqWBBci7wl2bZ5do9FvdvXjM0ukVUpE7VQ7KOe3yHRII34Jx
 zHemhJwAj66kcJ8YkiuQEv9OzH+G+X6po2Yh0fce9/wi44KEXnfSWjk0UY9ss5k1zqNVSDIk0qh
 CbBwTTjWBmC9uqjWRS7Ic+qm4kBEEbJnB/Az68mmR0A3/AHcqwZOCDREE4Tyz9mazi9nS7NjtXt
 uUc8igipUaUtW/Ax9ZLQC4FmPzCQCWW7k6TAciT1C2226mofP79peQiI8TG1Ex5lAqEt69OIu8f
 Jt1An3QMAjkI1QnM4hiOEMia08X4kKoUW8c/o/J0fhjxHqXqcsEEwetfLlH0asYCTs9cSmboXce
 3rYQAm8PrEfNB
X-Google-Smtp-Source: AGHT+IHvApmJqWy5NjlWgo1QZzBNUhs3zts9e7O/TguOhIEQHX6iBhGtwq32p2ZcHFezUWA/s2eHGw==
X-Received: by 2002:a5d:8058:0:b0:86c:cf7e:d85d with SMTP id
 ca18e2360f4ac-86ccf7ed9b6mr229536139f.12.1748254548767; 
 Mon, 26 May 2025 03:15:48 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fbcc3b19aasm4679249173.52.2025.05.26.03.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 03:15:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anshul Dalal <anshuld@ti.com>, Ben Dooks <ben.dooks@codethink.co.uk>,
 Christopher Obbard <christopher.obbard@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Harrison Mutai <harrison.mutai@arm.com>, Heiko Stuebner <heiko@sntech.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Johan Jonker <jbx6244@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Levi Yun <yeoreum.yun@arm.com>, Lukas Funke <lukas.funke@weidmueller.com>,
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul Kocialkowski <paulk@sys-base.io>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>, Sean Anderson <seanga2@gmail.com>,
 Sebastian Kropatsch <seb-dev@mail.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, huang lin <hl@rock-chips.com>
Subject: [PATCH v5 00/25] VBE serial part H: Implement VBE on Rockchip RK3399
Date: Mon, 26 May 2025 04:14:46 -0600
Message-ID: <20250526101541.3254628-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 26 May 2025 12:18:27 +0200
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

Changes in v5:
- Drop stray #endif
- Drop removal of stray #ifdef
- Mention VBE in the first paragraph of the commit message
- Wrap the entire simple-bin node and add the properties to vpl
- Expand commit message to mention VBE
- Move  SUPPORT_VPL next to other SUPPORT_xxx options
- Put TPL_DM_MMC in alpha order
- Move VPL_ROCKCHIP_COMMON_BOARD up a bit
- Move VPL_LDSCRIPT up a bit
- Drop config SPL_STACK_R_ADDR
- Use if() instead of ? in spl_boot_device()
- Drop mention of SPL_RAW_IMAGE_SUPPORT since it is already the default
- Drop mention of SPL_SEPARATE_BSS since VPL doesn't need it
- Drop duplicate __image_copy_start and __image_copy_end
- Drop unwanted comment in script
- Reword first paragraph to mention bloblist instead of other stacks
- Add value for CONFIG_SPL_STACK_R_ADDR
- Add to VPL file also
- Use 'SDRAM' instead of 'IRAM' in comment
- Drop mention of rk3399 since 64-boards always have TF-A after SPL
- Drop condition on VPL

Changes in v4:
- Use FIT_ARCH instead of ARCH
- Use FIT_ARCH instead of ARCH
- Use FIT_ARCH instead of ARCH
- Use fit_template instead of common_part
- Put the fdtmap at the end of the image
- Update the comment at the end of the '#ifndef CONFIG_VPL' block
- Add a value for SPL_STACK_R_ADDR
- Drop SPL_PAD_TO value since the default is fine
- Drop ROCKCHIP_IODOMAIN since it is the default
- Add SPL_LIBCOMMON_SUPPORT and SPL_LIBGENERIC_SUPPORT

Changes in v3:
- Add blank lines before the node
- Add a comment about the offsets
- Move template to the vpl file
- Unindent bootph tags
- Add the BLOBLIST_RELOC condition as well

Changes in v2:
- Move VPL things into a separate file
- Move VPL things into a separate file
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

Simon Glass (25):
  spl: Adjust xPL symbols
  spl: Allow VBE to handle xPL size
  vbe: Show the margin when using SPL_RELOC
  rockchip: Allow RAM init to happen in SPL on rk3399
  rockchip: dts: Add an fdtmap
  rockchip: dts: Specify the phase in the image
  rockchip: Provide a bootstd configuration
  rockchip: Add SPL into the main FIT
  rockchip: Add a template for SPL
  rockchip: Add a VPL image
  rockchip: Add TPL alternatives
  rockchip: Update rk3399 bootph-tags for VPL
  rockchip: Provide a VPL phase on rk3399
  rockchip: Add symbols for spl_reloc
  rockchip: rk3399: Adjust TPL stack to allow for bloblist
  rockchip: Allow SPL to set up SDRAM
  rockchip: Add a generic-ddr3 rk3399 board
  rockchip: Add documentation for VBE
  gitlab: Add an VBE board to the sjg lab
  rockchip: Set the skip-at-start property correctly
  vbe: Add a bootmeth driver for abrec
  rockchip: Update binman image for new skip-at-start setup
  bloblist: Temporary hacks to get VBE going
  rockchip: Relocate bloblist at the end of the SPL phase
  bloblist: Allow using a different bloblist address

 .gitlab-ci.yml                           |  20 +-
 arch/arm/dts/rk3399-u-boot.dtsi          |   9 +
 arch/arm/dts/rockchip-u-boot.dtsi        |  17 ++
 arch/arm/dts/rockchip-vpl-u-boot.dtsi    | 224 +++++++++++++++++++++++
 arch/arm/include/asm/spl.h               |   1 +
 arch/arm/lib/xferlist.c                  |  12 +-
 arch/arm/mach-rockchip/Kconfig           |  23 ++-
 arch/arm/mach-rockchip/Makefile          |  11 +-
 arch/arm/mach-rockchip/rk3399/Kconfig    |  11 +-
 arch/arm/mach-rockchip/spl.c             |  17 ++
 arch/arm/mach-rockchip/tpl.c             |  13 +-
 arch/arm/mach-rockchip/u-boot-tpl-v8.lds |  10 +
 arch/arm/mach-rockchip/u-boot-vpl-v8.lds | 107 +++++++++++
 arch/arm/mach-rockchip/vpl.c             |  53 ++++++
 board/rockchip/evb_rk3399/MAINTAINERS    |   6 +
 boot/vbe_abrec.c                         |  99 ++++++++++
 cmd/vbe.c                                |   8 +-
 common/Kconfig                           |  20 ++
 common/bloblist.c                        | 127 +++++--------
 common/spl/Kconfig                       |   3 +-
 common/spl/spl.c                         |   2 +
 common/spl/spl_reloc.c                   |  14 +-
 configs/rk3399-generic-ddr3_defconfig    | 125 +++++++++++++
 doc/board/rockchip/rockchip.rst          |  13 ++
 drivers/ram/rockchip/sdram_rk3399.c      |   6 +-
 include/bloblist.h                       |  16 +-
 include/vbe.h                            |   3 +
 27 files changed, 849 insertions(+), 121 deletions(-)
 create mode 100644 arch/arm/dts/rockchip-vpl-u-boot.dtsi
 create mode 100644 arch/arm/mach-rockchip/u-boot-vpl-v8.lds
 create mode 100644 arch/arm/mach-rockchip/vpl.c
 create mode 100644 configs/rk3399-generic-ddr3_defconfig

-- 
2.43.0

base-commit: bab54f5942c428be698216224fd10b91d974d4da
branch: vbi5
