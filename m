Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2828C54E90
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 12:47:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08FF782A39;
	Sun, 25 May 2025 14:47:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KxK+CuYy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1229382B5B; Sun, 25 May 2025 12:48:10 +0200 (CEST)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 242C782AA7
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 12:48:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-43cf848528aso14491705e9.2
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 03:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748170086; x=1748774886; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=emLQ372emogoBGbXHSLE+wi7IpMF1ClL8RnVr79Ft1w=;
 b=KxK+CuYyLOs909NwBeKv5wlLhHRAiRPZiuks12v/ncq5LOLwYoFEsk+SK/WAbXYjC6
 GAx9ume8p7mRxrUufms2OlUpGrQIR/DJnOZrby+d7CRQY+Zv7Jw5dxU0mpHyz9wS+P7M
 GQgJjVTGCQ52co9F0uh38KsTX2e9jpJfE0054=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748170086; x=1748774886;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=emLQ372emogoBGbXHSLE+wi7IpMF1ClL8RnVr79Ft1w=;
 b=SaCOR8WvVKN/yLjQnQ3SWJxu+PFL01qyCD6Py/zUEJPCY157zmcAAsQUR/SIODp05h
 +NMyUweND2rEUs9HLg8SAh9lt9Nr9cjqIfbft0AzUvhNVUdvLAjWqxeJFlzaKAJrfzZy
 pk54V2b8xTlDRbeTx6LBFS4RwV9QKvXfF6G+YSiHzLuU2mreH3LSpofRmur1Igb5cROB
 PrHFFEBbbOEEH42QI9aTsXLda1zrd5KM5zkQb0grzT8IzPMJhB/359IcakY0eELavbeE
 Xp34+xGMeVS5Qx9q0DLT7JnNfnuO0MgR1r51ezOhNWHHGY7hOxSf9lfYcMWQmt8vdb9i
 OOlw==
X-Gm-Message-State: AOJu0Yy6zRLzdYb4ZDaO6Pm3VfnuojpQLbqMQX9RgBzIh2CtXJVG1UNm
 8vfdAlnvTAKvwVzAUXBa7BifEgsalimnRtWdC3keYUM/1eHXSwrrBDVjvSaaDiT88I0CDvNKlGN
 2fJ9JWk/ngKA=
X-Gm-Gg: ASbGncvH9YR1vE/KiA/PRCDzZfQN1bK8SmbE6cSulaBR88KApdywi3I5Bms51qwD7gI
 kDcKyttwaFmsRNh2Ohbmsih6oG9oAcmum5H8/HWK0UoxRdR3aSg5JKGOZpyaBAzBk+XraAPS7oV
 DrZRa4p9FljNIDpPbFRvcpZ0GI1XrHkekjlJvca9NnuB3GabTc4Lvg74YP7Z6+gQRp+Lmjbl/vd
 3M61JrUOY3Kd8/xPFb4ApiH2I/akfezV0sO7okTcvu+tGzpVSqW35xCtwDj8rqjPBH+/h39aDYk
 B6O0Nj2baZA/CchXwhH1XRmXRgh3ARrqS+zBNVIuG0lEo/DpBMKulSo4FLVRyg6DYR53WFZBvEo
 db1Gsug==
X-Google-Smtp-Source: AGHT+IGBn0r5vkcCDlFU/WAChcs8qVlNZtEKsDZko4J7/EAoAJs/okWoUPlbdm3U9E1fhKdPqftF1w==
X-Received: by 2002:a05:600c:8214:b0:441:a715:664a with SMTP id
 5b1f17b1804b1-44c932f93edmr35844405e9.20.1748170085958; 
 Sun, 25 May 2025 03:48:05 -0700 (PDT)
Received: from tasman.. (host-80-43-238-15.as13285.net. [80.43.238.15])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4cb450867sm5045047f8f.57.2025.05.25.03.48.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 03:48:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anshul Dalal <anshuld@ti.com>, Ben Dooks <ben.dooks@codethink.co.uk>,
 Christopher Obbard <christopher.obbard@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Daniel Semkowicz <dse@thaumatec.com>, Dragan Simic <dsimic@manjaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Harrison Mutai <harrison.mutai@arm.com>, Heiko Stuebner <heiko@sntech.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Joshua Watt <jpewhacker@gmail.com>, Kever Yang <kever.yang@rock-chips.com>,
 Levi Yun <yeoreum.yun@arm.com>, Lukas Funke <lukas.funke@weidmueller.com>,
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul Kocialkowski <contact@paulk.fr>,
 Paul Kocialkowski <paulk@sys-base.io>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>, Sean Anderson <seanga2@gmail.com>,
 Sebastian Kropatsch <seb-dev@mail.de>, Stefan Roese <sr@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, huang lin <hl@rock-chips.com>
Subject: [PATCH v4 00/25] VBE serial part H: Implement VBE on Rockchip RK3399
Date: Sun, 25 May 2025 11:47:36 +0100
Message-Id: <20250525104801.1440260-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 25 May 2025 14:47:04 +0200
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

This series still bloblist reverts and changes, just so that the boar
doesn't hang on boot. I have already sent a series to resolve this, but
so far it has been rejected:

https://patchwork.ozlabs.org/project/uboot/list/?series=456263&state=*

This is (mostly) the final VBE series, but there are a few loose ends to
tidy up:

- cache is disabled in SPL, which slows the boot a little
- pinctrl init needs to be tidied up to avoid warnings
- bloblist logic as above
- bloblist-relocation is partly in board-specific code, partly generic

Other things may become apparently after more usage / testing.

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
- Fix 'an' typo in commit subject
- Rebase to -next

Changes in v3:
- Add blank lines before the node
- Add a comment about the offsets
- Move template to the vpl file
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
  rockchip: rk3399: Adjust initial TPL-stack to match SPL
  rockchip: Allow SPL to set up SDRAM
  rockchip: Add a generic-ddr3 rk3399 board
  rockchip: Add documentation for VBE
  gitlab: Add a VBE board to the sjg lab
  rockchip: Set the skip-at-start property correctly
  vbe: Add a bootmeth driver for abrec
  rockchip: Update binman image for new skip-at-start setup
  bloblist: Temporary hacks to get VBE going
  rockchip: Relocate bloblist at the end of the SPL phase
  bloblist: Allow using a different bloblist address

 .gitlab-ci.yml                           |  20 ++-
 arch/arm/dts/rk3399-u-boot.dtsi          |  11 +-
 arch/arm/dts/rockchip-u-boot.dtsi        |  17 ++
 arch/arm/dts/rockchip-vpl-u-boot.dtsi    | 220 +++++++++++++++++++++++
 arch/arm/include/asm/spl.h               |   1 +
 arch/arm/lib/xferlist.c                  |  12 +-
 arch/arm/mach-rockchip/Kconfig           |  25 ++-
 arch/arm/mach-rockchip/Makefile          |  11 +-
 arch/arm/mach-rockchip/rk3399/Kconfig    |  14 +-
 arch/arm/mach-rockchip/spl.c             |  18 ++
 arch/arm/mach-rockchip/tpl.c             |  12 +-
 arch/arm/mach-rockchip/u-boot-tpl-v8.lds |  13 ++
 arch/arm/mach-rockchip/u-boot-vpl-v8.lds | 107 +++++++++++
 arch/arm/mach-rockchip/vpl.c             |  53 ++++++
 board/rockchip/evb_rk3399/MAINTAINERS    |   6 +
 boot/vbe_abrec.c                         |  99 ++++++++++
 cmd/vbe.c                                |   8 +-
 common/Kconfig                           |  20 +++
 common/bloblist.c                        | 127 +++++--------
 common/spl/Kconfig                       |   3 +-
 common/spl/spl.c                         |   2 +
 common/spl/spl_reloc.c                   |  14 +-
 configs/rk3399-generic-ddr3_defconfig    | 124 +++++++++++++
 doc/board/rockchip/rockchip.rst          |  13 ++
 drivers/ram/rockchip/sdram_rk3399.c      |   6 +-
 include/bloblist.h                       |  16 +-
 include/vbe.h                            |   3 +
 27 files changed, 852 insertions(+), 123 deletions(-)
 create mode 100644 arch/arm/dts/rockchip-vpl-u-boot.dtsi
 create mode 100644 arch/arm/mach-rockchip/u-boot-vpl-v8.lds
 create mode 100644 arch/arm/mach-rockchip/vpl.c
 create mode 100644 configs/rk3399-generic-ddr3_defconfig

-- 
2.34.1

base-commit: bab54f5942c428be698216224fd10b91d974d4da
branch: vbi4
