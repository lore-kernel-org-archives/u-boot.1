Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4A0C02193
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 02:10:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D03E807E1;
	Wed,  5 Feb 2025 03:09:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NB2SrwrJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3CFF800B3; Wed,  5 Feb 2025 02:56:23 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F72D80040
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 02:56:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-71e565708beso3409829a34.1
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 17:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738720579; x=1739325379; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1H0xuO9akNNRCiXOzq7tG1+ULT1FwMUqCJTwhllWtDM=;
 b=NB2SrwrJIwj0lch8EvWkovWjcmYCxX2NTfec1OGUOOwfFQR6LQMm1C0VnevNrsyCOv
 WW264t61HTMcXphoN1BdNxjP/ogiT+HUopMzgojFMnvsqclevPcG24xMMqgfz5mo0LPz
 FuU7fel6ypb0MD0Qmw2ze7iyokWOi5eVHLSnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738720579; x=1739325379;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1H0xuO9akNNRCiXOzq7tG1+ULT1FwMUqCJTwhllWtDM=;
 b=HCrDdZkS4dRMH4/fqopEZjFHUk83icLEDhlRqZxFflC42smm3QM+NijHL/swBBA/Ie
 3w4OUs8ZXvc9YXBeSLtxZmjqmukVVd0gNI+uSdjtXMVDUN4ct18htEZFrPLHGSAc3sT9
 2rtMUkK+S3HNW8nb6HF8APYcY/AJhhCNBHcmdAeQI0b4LJkdLHM3vKRXG8cZmFAlZ7jY
 yrrR2FURk3WmWFQ45z2b5doMfZ1/FqsfTeCUy/hB9QDGExgH368c2PbzBCp7NcbKKHRj
 UuxQ+p94S3M9fXPARMPyeulwRRlK6mpSNROmeLUBeCy3pN6BvJ6/9qSufjjx9fxXqz+K
 HYwg==
X-Gm-Message-State: AOJu0YxunYovFmIG++KMkEkPDdYoDxhn3yDH+sNnqO62ge1cVlMw8J/9
 fgFSK7S0ugPlOtjuTwygAYPmD/OczViIV+81MXZozdZoW+8aVoWpot0k98niK0GZz7B/B8gBEsA
 =
X-Gm-Gg: ASbGncs4QfCodZI0GQuO0Wm0SL71yKAYU2/Bj2DrKcRIG1iPpVtbkyWET4AY1GxdfNg
 RKm0FCYtAujJCuxbCnluxe+1wXe0kbSraq3nw2K9m7LvMhf4m99nhE6XaEg1OpuYoUhoLgtyTS6
 wRH2h2sw7aQoMKNKMjkpIHbqLHP6U47ib3L2fuYyxtXrxanzS4NT8NqUnCsx0JTQVvU+GNJP/zu
 8MSq2Gp5lr1VWmGBes6v/WQQBOOCbWUxCEbA2Wq93IoQN9mVW/gokulJO0ovMS3QFuJtqGeu2qS
 6Ua05GkfPLa5ebzdF+EFaivhBvxJRlK+3wRh3vujTZBoRPBe4Txw
X-Google-Smtp-Source: AGHT+IFoQaz+h8r8EsQ1CJj3w5WcxUjz72bB7CYvU/60fT++Ht5D6TjFYDXKPGKlgwkHEmz6PSCPCQ==
X-Received: by 2002:a05:6830:dc2:b0:71d:4a91:9204 with SMTP id
 46e09a7af769-726a42a4e55mr714927a34.26.1738720578661; 
 Tue, 04 Feb 2025 17:56:18 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fc104c2e7asm3543676eaf.12.2025.02.04.17.56.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 17:56:17 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Akash Gajjar <gajjar04akash@gmail.com>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Alex Shumsky <alexthreed@gmail.com>, Alexandre Vicenzi <linux@alxd.me>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Chris Morgan <macromorgan@hotmail.com>, David Bauer <mail@david-bauer.net>,
 Deepak Das <deepakdas.linux@gmail.com>, Dragan Simic <dsimic@manjaro.org>,
 Elon Zhang <zhangzj@rock-chips.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Gary Bisson <bisson.gary@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Johan Jonker <jbx6244@gmail.com>,
 Joshua Riek <jjriek@verizon.net>, Kever Yang <kever.yang@rock-chips.com>,
 Klaus Goger <klaus.goger@cherry.de>, Loic Devulder <ldevulder@suse.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ricardo Pardini <ricardo@pardini.net>, Sean Anderson <seanga2@gmail.com>,
 Sebastian Kropatsch <seb-dev@mail.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Shantur Rathore <i@shantur.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Suniel Mahesh <sunil@amarulasolutions.com>, Tim Lunn <tim@feathertop.org>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, Tom Rini <trini@konsulko.com>,
 Wadim Egorov <w.egorov@phytec.de>, huang lin <hl@rock-chips.com>
Subject: [PATCH 00/29] VBE serial part H: Implement VBE on Rockchip RK3399
Date: Tue,  4 Feb 2025 18:54:50 -0700
Message-ID: <20250205015606.2686149-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Feb 2025 03:09:25 +0100
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

Other things may become apparently after more usage / testing.


Simon Glass (29):
  arm: Support a separate stack for VPL
  spl: Adjust xPL symbols
  spl: Allow VBE to handle xPL size
  vbe: Show the margin when using SPL_RELOC
  rockchip: Allow RAM init to happen in SPL on rk3399
  rockchip: dts: Factor out arch and compression
  rockchip: Add an fdtmap
  rockchip: Add more space below the stack pointer with kevin
  rockchip: dts: Create a template for the FIT
  rockchip: dts: Un-indent the FIT template
  rockchip: dts: Correct the OS for U-Boot
  rockchip: Specify the phase in the image
  rockchip: Provide a bootstd configuration
  rockchip: Add SPL into the main FIT
  rockchip: Include a compatible string in each configuration
  rockchip: Set the skip-at-start property correctly
  rockchip: Add a template for SPL
  rockchip: Add a VPL image
  rockchip: Add TPL alternatives
  rockchip: Update rk3399 bootph-tags for VPL
  rockchip: Provide a VPL phase on rk3399
  rockchip: Add symbols for spl_reloc
  rockchip: Adjust rk3399 TPL-stack to the same as SPL
  rockchip: Allow SPL to set up SDRAM
  rockchip: Add a generic rk3399 board
  rockchip: Add documentation for VBE
  gitlab: Add an VBE board to the sjg lab
  Revert "bloblist: Load the bloblist from the previous loader"
  bloblist: Allow relocation at the end of the SPL phase

 .gitlab-ci.yml                                |   6 +
 arch/arm/dts/rk3399-generic-u-boot.dtsi       |  32 ++
 arch/arm/dts/rk3399-generic.dts               |  30 ++
 arch/arm/dts/rk3399-u-boot.dtsi               |   9 +-
 arch/arm/dts/rockchip-u-boot.dtsi             | 455 +++++++++++++-----
 arch/arm/include/asm/spl.h                    |   1 +
 arch/arm/lib/crt0_64.S                        |   4 +-
 arch/arm/mach-rockchip/Kconfig                |  25 +-
 arch/arm/mach-rockchip/Makefile               |   6 +-
 arch/arm/mach-rockchip/rk3399/Kconfig         |  11 +-
 arch/arm/mach-rockchip/spl-boot-order.c       |   3 +-
 arch/arm/mach-rockchip/spl.c                  |   3 +
 arch/arm/mach-rockchip/tpl.c                  |  12 +-
 arch/arm/mach-rockchip/u-boot-tpl-v8.lds      |  13 +
 arch/arm/mach-rockchip/u-boot-vpl-v8.lds      | 107 ++++
 arch/arm/mach-rockchip/vpl.c                  |  53 ++
 board/rockchip/evb_rk3399/MAINTAINERS         |   5 +
 cmd/vbe.c                                     |   8 +-
 common/Kconfig                                |  20 +
 common/bloblist.c                             |  77 ++-
 common/spl/Kconfig                            |   1 +
 common/spl/Kconfig.vpl                        |  13 +
 common/spl/spl.c                              |  11 +
 common/spl/spl_reloc.c                        |  14 +-
 configs/anbernic-rgxx3-rk3566_defconfig       |   2 +-
 configs/bpi-r2-pro-rk3568_defconfig           |   2 +-
 configs/chromebit_mickey_defconfig            |   2 +-
 configs/chromebook_bob_defconfig              |   4 +-
 configs/chromebook_jerry_defconfig            |   2 +-
 configs/chromebook_kevin_defconfig            |   4 +-
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
 configs/rk3399-generic_defconfig              | 133 +++++
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
 149 files changed, 1016 insertions(+), 312 deletions(-)
 create mode 100644 arch/arm/dts/rk3399-generic-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3399-generic.dts
 create mode 100644 arch/arm/mach-rockchip/u-boot-vpl-v8.lds
 create mode 100644 arch/arm/mach-rockchip/vpl.c
 create mode 100644 configs/rk3399-generic_defconfig

-- 
2.43.0

