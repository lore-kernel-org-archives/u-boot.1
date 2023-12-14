Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D67C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 11:02:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6111587A5E;
	Thu, 14 Dec 2023 12:02:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OQuf7uXg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BF5D87A60; Thu, 14 Dec 2023 12:02:28 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86C4287A4F
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 12:02:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d346f4a043so5974845ad.0
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 03:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702551744; x=1703156544; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YI24J1OBy4pGr37cS6XzDP65T2YWtXFqL+ITVm7Uv3k=;
 b=OQuf7uXg7K0yOaKrbEGedzgoWQM7GIzEcphwF0wOj6VMQnbcfmvQsr3CZh8zX7rkJq
 7CZqHjN1KvrGY3ku5RfIoMujnEUMM5VThRipJDAXLV/KQ5aBLQlth7Gx6t60AWP4hrDW
 byZOW5TnCAtYOOaDFy3QSuYAgSYIdmyB1NAipRozLspwW1Lc0CHyg1gsWoU4sKZXm3Yn
 7Qzx5+Egt8iG2Qu1dG+CSRFladDVkoeL7Y82aKYp0FyiRQ8pX8nd/z5+sxqi+KBHcuBH
 YSfp6ZDwoljsR0x0d9P7xzb/cGbu+7wgAKFe/HJNPcnhi7r7E6cviQrRUZcpyvM+hdQm
 He+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702551744; x=1703156544;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YI24J1OBy4pGr37cS6XzDP65T2YWtXFqL+ITVm7Uv3k=;
 b=vO9ZQcyxoj3MbyDpl2utOmAISlBGQgmvYhp4hCLX7bZllSuzLVck8vU62d4qhKxhA2
 KoApMIlLW4c0RbKowRtrHjaI1DFBV059m0/rwfgxZgHoNfStDz1xj42S4M+XmnEg7EKu
 3jIOBifge6MqfFx8b/QkxBdeEE8nCpfzCO4Z2IREMtC3iVWvfbogPc6NjMhh5L3ObFTm
 5oPLwbT/BfYy/G37bROrUEI9lUUXAvw2inKxJu/d9VLA1u1e+eKkrB3JsLs9yGGAq0uL
 My2VStzM3Dxxt5BDsGEq37ibjUGAodcnrT9mB3F6wFjLsyC7TA1VYHVhsCf3eNXmAS8D
 kmDQ==
X-Gm-Message-State: AOJu0YxLFGbKaJy+XQ+rPf5uLKrJTQTq3Oe/0TxCCaYyKPvm23/wYSO9
 44Kvh8TA71IXZh5hYbyKY3I=
X-Google-Smtp-Source: AGHT+IEU/y9jAt859x/UzB6AO6qDPHvdSbyn/9OPLNZ+VJ/ViN2LFM5JVY310FWXsOqedlZhcKdzaA==
X-Received: by 2002:a17:903:2303:b0:1d0:c128:1ef2 with SMTP id
 d3-20020a170903230300b001d0c1281ef2mr19261888plh.3.1702551743707; 
 Thu, 14 Dec 2023 03:02:23 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:f163:488c:ee49:c334])
 by smtp.gmail.com with ESMTPSA id
 t15-20020a170902e84f00b001cfa4178981sm844917plg.309.2023.12.14.03.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 03:02:23 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: sbabic@denx.de,
	u-boot@lists.denx.de
Subject: Pull request: Please pull u-boot-imx-next-20231214
Date: Thu, 14 Dec 2023 08:02:19 -0300
Message-Id: <20231214110219.14460-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi Tom,

Please pull this u-boot-imx material targetted for 'next', thanks.

The following changes since commit be4a5f7c35685d228b3abc398a8d86c434274de5:

  test: bdinfo: Handle systems without getopt (2023-12-10 10:08:30 -0500)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20231214

for you to fetch changes up to 6b73200aedb1d3fb0a52e2600bd6b1e3ff5e5faf:

  arm64: imx8mp: Enable TCP, IPv6, wget on Data Modul i.MX8M eDM SBC (2023-12-14 06:24:27 -0300)

u-boot-imx-next-20231214
------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/18918

- Add TPM support for venice boards
- Add networking support for imx93-evk
- Enable TCP, IPv6, wget for DHCOM and Data Modul boards
- Enable fastboot support for Toradex boards
- Allow pico-imx7d to boot from SD
- Enable fastboot for beacon imx8m beacon boards, disabled SYS_CONSOLE_IS_IN_ENV
- Fix mxsboot to prevent NAND blocks being reported as bad
- Add imx8mm PWM clock support
- Several devicetree syncs with the kernel
- Add support for i.MX8MP Polyhex Debix Model A SBC
- Reworked ddr_load_train_firmware() to get a 50ms boot time improvement
----------------------------------------------------------------

Adam Ford (5):
      configs: imx8mp_beacon: Do not set SYS_CONSOLE_IS_IN_ENV
      configs: imx8mm_beacon: Enable fastboot downloading
      configs: imx8mm_beacon: Disable the WDT autostart
      configs: imx8mn_beacon: Do not set SYS_CONSOLE_IS_IN_ENV
      configs: imx8mn_beacon: Disable the WDT autostart

Alessandro Rubini (1):
      tools: mxsboot: pre-fill buffer with 0xff, not 0

Arnaud Ferraris (2):
      librem5: properly set the `fdtfile` env variable
      librem5: Add addresses for compressed kernel load

Benjamin Szőke (1):
      pico-imx7d: add baseboard SD card boot detect

Cem Tenruh (1):
      arm: dts: imx8mm-phyboard-polis-rdk: Sync dts files with kernel

Fabio Estevam (14):
      imx8qm_dmsse20a1: Improve SPL memory configuration
      imx7d-sdb: Sync devicetree with kernel 6.5-rc1
      imx8mp_evk: Convert to DM_PMIC
      imx8mp_evk: Add myself to MAINTAINERS
      arm: dts: imx8mm: Sync with linux-next 20231019
      arm: dts: imx8mn: Sync with linux-next 20231019
      arm: dts: imx8mp: Sync with linux-next 20231019
      phy: phy-imx8mq-usb: Remove .exit operation
      imx8mp_evk: Simplify Ethernet initialization
      imx8mp_evk: Remove unneeded header files
      clock_imx8mm: Add a stub for imx8mp_fec_interface_init()
      pico-imx7d: Remove board_phy_config()
      imx7d-pico-pi-u-boot.dtsi: Fix aliases indentation
      imx: imx-hab: Select SPL_DRIVERS_MISC in the SPL case

Gilles Talis (1):
      imx: imx8mp: Add support for Polyhex Debix Model A SBC

Hiago De Franco (2):
      apalis/colibri imx6/imx6ull/imx7: defconfig: Enable fastboot support
      board: apalis/colibri imx6/imx6ull/imx7: Add fastboot bootcmd support

Hugo Villeneuve (4):
      imx8mn-var-som: add manufacturer to target description
      imx8mn_var_som: Add myself to MAINTAINERS
      imx8mn-var-som: Simplify FEC initialization
      MAINTAINERS: Remove non-working address from MAINTAINERS

Igor Opaniuk (1):
      imx: imx8: ahab: refactor do_ahab_close command

Marek Vasut (5):
      arm: mxs: Fix ICOLL macro name typo
      arm: mxs: Clear CPSR V bit to activate low vectors
      arm: imx6: Enable TCP, IPv6, wget on DH i.MX6 DHCOM
      arm64: imx8mp: Enable TCP, IPv6, wget on DH i.MX8MP DHCOM
      arm64: imx8mp: Enable TCP, IPv6, wget on Data Modul i.MX8M eDM SBC

Nicolas Heemeryck (1):
      clk: imx8mn: add pwm clocks

Ricardo Salveti (1):
      ARM: imx8ulp: support env in fat and ext4

Shawn Guo (1):
      ddr: imx: Save the FW loading if it hasn't changed

Sébastien Szymanski (4):
      net: dwc_eth_qos: add i.MX93 support
      net: dwc_eth_qos: Add board_interface_eth_init() for i.MX93
      net: phy: realtek: Add support for RTL8211F(D)(I)-VD-CG
      arm: dts: imx93-evk: remove wrong eqos compatible string

Tim Harvey (2):
      arm: dts: imx8mm-venice-gw73xx: add TPM device
      arm: dts: imx8mp-venice-gw73xx: add TPM device

 arch/arm/cpu/arm926ejs/mxs/mxs.c                   |    4 +
 arch/arm/cpu/arm926ejs/mxs/spl_boot.c              |    8 +-
 arch/arm/dts/Makefile                              |    3 +-
 arch/arm/dts/imx7d-pico-pi-u-boot.dtsi             |   11 +-
 arch/arm/dts/imx7d-sdb-u-boot.dtsi                 |   51 -
 arch/arm/dts/imx7d-sdb.dts                         |   73 +-
 ....dtsi => imx8mm-phyboard-polis-rdk-u-boot.dtsi} |    0
 arch/arm/dts/imx8mm-phyboard-polis-rdk.dts         |  460 +++++
 arch/arm/dts/imx8mm-phycore-som.dtsi               |  440 +++++
 arch/arm/dts/imx8mm-venice-gw73xx-0x-u-boot.dtsi   |    7 +
 arch/arm/dts/imx8mm-venice-gw73xx.dtsi             |   10 +-
 arch/arm/dts/imx8mm.dtsi                           |  153 +-
 arch/arm/dts/imx8mn.dtsi                           |  167 +-
 arch/arm/dts/imx8mp-debix-model-a-u-boot.dtsi      |  141 ++
 arch/arm/dts/imx8mp-debix-model-a.dts              |  507 ++++++
 arch/arm/dts/imx8mp-evk-u-boot.dtsi                |   32 +-
 arch/arm/dts/imx8mp-venice-gw73xx-2x-u-boot.dtsi   |    9 +
 arch/arm/dts/imx8mp-venice-gw73xx.dtsi             |    9 +-
 arch/arm/dts/imx8mp.dtsi                           |  542 +++++-
 arch/arm/dts/imx93-11x11-evk-u-boot.dtsi           |    4 -
 arch/arm/dts/phycore-imx8mm.dts                    |  287 ---
 arch/arm/include/asm/arch-imx8/sys_proto.h         |    1 +
 arch/arm/include/asm/arch-mxs/regs-base.h          |    2 +-
 arch/arm/mach-imx/Kconfig                          |    1 +
 arch/arm/mach-imx/imx8/ahab.c                      |   45 +-
 arch/arm/mach-imx/imx8m/Kconfig                    |   10 +-
 arch/arm/mach-imx/imx8m/clock_imx8mm.c             |    7 +
 arch/arm/mach-imx/imx8ulp/soc.c                    |   28 +-
 arch/arm/mach-imx/imx9/clock.c                     |   53 +
 board/bsh/imx8mn_smm_s2/MAINTAINERS                |    1 -
 board/freescale/imx8mp_evk/MAINTAINERS             |    1 +
 board/freescale/imx8mp_evk/imx8mp_evk.c            |   41 +-
 board/freescale/imx8mp_evk/spl.c                   |   50 +-
 board/freescale/imx93_evk/imx93_evk.c              |   16 -
 board/freescale/mx7dsabresd/mx7dsabresd.c          |    2 +-
 board/phytec/phycore_imx8mm/MAINTAINERS            |    5 +-
 board/polyhex/imx8mp_debix_model_a/Kconfig         |   15 +
 board/polyhex/imx8mp_debix_model_a/MAINTAINERS     |    8 +
 board/polyhex/imx8mp_debix_model_a/Makefile        |   13 +
 .../imx8mp_debix_model_a/imx8mp_debix_model_a.c    |   55 +
 .../imx8mp_debix_model_a/imximage-8mp-lpddr4.cfg   |    9 +
 board/polyhex/imx8mp_debix_model_a/lpddr4_timing.c | 1843 ++++++++++++++++++++
 board/polyhex/imx8mp_debix_model_a/spl.c           |  129 ++
 board/purism/librem5/librem5.c                     |   27 +-
 board/technexion/pico-imx7d/Makefile               |    2 +-
 board/technexion/pico-imx7d/pico-imx7d.c           |   88 +-
 board/technexion/pico-imx7d/spl.c                  |   91 +-
 board/toradex/apalis_imx6/apalis_imx6.c            |   13 +-
 board/toradex/colibri-imx6ull/colibri-imx6ull.c    |   13 +-
 board/toradex/colibri_imx6/colibri_imx6.c          |   13 +-
 board/toradex/colibri_imx7/colibri_imx7.c          |   14 +-
 board/variscite/imx8mn_var_som/MAINTAINERS         |    2 +-
 board/variscite/imx8mn_var_som/imx8mn_var_som.c    |   13 -
 configs/apalis_imx6_defconfig                      |    3 +
 configs/colibri-imx6ull-emmc_defconfig             |    3 +
 configs/colibri-imx6ull_defconfig                  |    3 +
 configs/colibri_imx6_defconfig                     |    3 +
 configs/colibri_imx7_defconfig                     |    3 +
 configs/colibri_imx7_emmc_defconfig                |    4 +-
 configs/dh_imx6_defconfig                          |    7 +
 configs/imx8mm_beacon_defconfig                    |    7 +-
 configs/imx8mm_data_modul_edm_sbc_defconfig        |    5 +
 configs/imx8mn_beacon_defconfig                    |    2 +
 configs/imx8mp_beacon_defconfig                    |    1 +
 configs/imx8mp_data_modul_edm_sbc_defconfig        |    5 +
 configs/imx8mp_debix_model_a_defconfig             |  110 ++
 configs/imx8mp_dhcom_pdk2_defconfig                |    5 +
 configs/imx8mp_dhcom_pdk3_defconfig                |    5 +
 configs/imx8mp_evk_defconfig                       |   12 +-
 configs/imx8qm_dmsse20a1_defconfig                 |    9 +
 configs/phycore-imx8mm_defconfig                   |    2 +-
 drivers/clk/imx/clk-imx8mn.c                       |   30 +
 drivers/ddr/imx/phy/helper.c                       |    7 +
 drivers/net/dwc_eth_qos.c                          |    4 +
 drivers/net/dwc_eth_qos_imx.c                      |    3 +
 drivers/net/phy/realtek.c                          |   14 +
 drivers/phy/phy-imx8mq-usb.c                       |    6 -
 include/configs/imx8mp_debix_model_a.h             |   54 +
 include/configs/librem5.h                          |    2 +
 include/configs/pico-imx7d.h                       |    4 +-
 include/dt-bindings/clock/imx8mp-clock.h           |    3 +-
 tools/mxsboot.c                                    |    2 +-
 82 files changed, 5200 insertions(+), 647 deletions(-)
 rename arch/arm/dts/{phycore-imx8mm-u-boot.dtsi => imx8mm-phyboard-polis-rdk-u-boot.dtsi} (100%)
 create mode 100644 arch/arm/dts/imx8mm-phyboard-polis-rdk.dts
 create mode 100644 arch/arm/dts/imx8mm-phycore-som.dtsi
 create mode 100644 arch/arm/dts/imx8mp-debix-model-a-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx8mp-debix-model-a.dts
 delete mode 100644 arch/arm/dts/phycore-imx8mm.dts
 create mode 100644 board/polyhex/imx8mp_debix_model_a/Kconfig
 create mode 100644 board/polyhex/imx8mp_debix_model_a/MAINTAINERS
 create mode 100644 board/polyhex/imx8mp_debix_model_a/Makefile
 create mode 100644 board/polyhex/imx8mp_debix_model_a/imx8mp_debix_model_a.c
 create mode 100644 board/polyhex/imx8mp_debix_model_a/imximage-8mp-lpddr4.cfg
 create mode 100644 board/polyhex/imx8mp_debix_model_a/lpddr4_timing.c
 create mode 100644 board/polyhex/imx8mp_debix_model_a/spl.c
 create mode 100644 configs/imx8mp_debix_model_a_defconfig
 create mode 100644 include/configs/imx8mp_debix_model_a.h
