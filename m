Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A79CFD2F6
	for <u-boot@archiver.kernel.org>; Sat, 29 Nov 2025 21:17:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45CE483700;
	Sat, 29 Nov 2025 22:17:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LYLr3J+M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34A6F83700; Sat, 29 Nov 2025 22:17:22 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E819B836CE
 for <u-boot@lists.denx.de>; Sat, 29 Nov 2025 22:17:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-297ef378069so29604675ad.3
 for <u-boot@lists.denx.de>; Sat, 29 Nov 2025 13:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764451032; x=1765055832; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zHG6gFzd5MMEVccRjOPBZ5ZgddBzuv9dr+lM+6Sl+aU=;
 b=LYLr3J+MbLugYxx4jrKdU/tWc/Pg6X/5WUaGZF+FZ9ln0Wp5ilXXAFv2vS+emVO3oV
 jwrk6lR6sMCIn2NTAdxhEz4W6JoexZLHfMdBXCeu2VciBDyQfkJ3Viwvxj9/LxrCjEUx
 CkAKWmGbPu+VNTVCGxqCPx8aCUWjgYK1vtruA0J4qEVzQcuicIU8CBnxcWq5PymmUDaQ
 nA7e1lr1vhvT0pZ6RAkZnQKtM9+3TfIGahZoW84wt4S0hycO/7oG3CS1p6PSg/Iz8Zfq
 kKIpBjl+fRA/2yNMyO29Hpa0rnOlD0WJB8IaxP3GCebVSZBEHf7z0f0cxaQRudwvWp/V
 dKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764451032; x=1765055832;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zHG6gFzd5MMEVccRjOPBZ5ZgddBzuv9dr+lM+6Sl+aU=;
 b=mh+gLttdnnGfVfQCuPD4hFhI/q6e5n2srGbq/Gf3J/yRBUJuTIkl95TKRFHI0t+hne
 +TtweoSD1ToYTh8EuwZLCGwjHgp8w5wzdSirUK8ZM3gaKC2vPN9ZChVCMYVNSUZ6C8XS
 ftka3tAy9W1x+UbiAjaRj0bmvGGayGr4kfrDJZvTAjkhSu+iHK+G4ehCdZN9L6ANuB0g
 Sd01pAVnBxS7+ddLIvYhtHFRl+eK4Rqd/hiQb97lzalOnmlPOkmofkzPHI56TdY+XmnC
 wKEEGqhumyXfaa7Zkma/uukzsH99P2dCforzFklLy9XBoScBkRWOmhvz6knU1Ngke9ys
 l0Sw==
X-Gm-Message-State: AOJu0Yz8vy9iN5yzDwo6rWMfnIK8URzCdKG8HOpATnNTfjN9By1msF1b
 HkMgGKHzCFxi8a3Q1V6bLOCS1vOrL8859E02+Eb8E2GwgNXI+xv4a//qKP622r3t
X-Gm-Gg: ASbGncvjfXyzsE0Nxhn4phnwlC5WmVNRMcU/h6gaMU7vQdQx4KeaOKPunuWzuIVMlCc
 9/s8F7lSXVtZph85Afa67RfXx7r5pGzrL4ldo1NIolORzRApgiCM9QzUL78WNUdCEnuSz7Y5HGb
 wE9VSiaHReJxolEn0o8UuuzAS+N9UGJHRZPSdw5qOQpR5go4jhhxqaAi1h17W39fK8Zkktmcv3R
 wR5w/n4NrRymY2I+p5PLmrOh2R5RdNF2eJQ9uuyizfIYf92L35ZbwhzXZV4mu4PHjBrsjMQmbuE
 kAZ6xbxDmVBlGRHj15EDc4i/7/i0dy/JQgOLUCLcjam5GfZPIsj5VHWJnD+St7cxFS4ddSW7NAl
 DY6qyzxVzNUKbowpw1sEBLjryUGUxeP9TyE1rHrnkuMfjPuXh60cuYtkge6hc5RBW66FaVIchDi
 +Mi3UQxbwF/qn3mUVjrKpIrizo
X-Google-Smtp-Source: AGHT+IGitb2Xpz/19CIdPEf7UNqQnk9WzGcR0EID5mPeMmtj3gYVfL6dfm5vYlSFjp0bOw33b3kh4g==
X-Received: by 2002:a05:7022:ec88:b0:119:e55a:9bf5 with SMTP id
 a92af1059eb24-11cb3ef2594mr12462450c88.17.1764451032132; 
 Sat, 29 Nov 2025 13:17:12 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:17e8:9a46:319a:4626])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11dcaee660asm41562231c88.3.2025.11.29.13.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Nov 2025 13:17:11 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-next-20251129
Date: Sat, 29 Nov 2025 18:17:08 -0300
Message-Id: <20251129211708.2995513-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Hi Tom,

Please pull from u-boot-imx/next, thanks.

The following changes since commit 7af532a8ef1c6685eac58d587c9502ab31855aae:

  Merge patch series "Add support for two RTCs" (2025-11-29 08:37:26 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20251129

for you to fetch changes up to c8daa0abdb3c48aba9dd86228ed50a34c5482a73:

  phytec: sort .env files alphabetically for imx8 boards (2025-11-29 18:02:13 -0300)

u-boot-imx-next-20251129
------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/28551

- Stop disabling device tree relocation on i.MX boards.
- Add support for imx6ulz_smm_m2d.
- Add support for Kontron i.MX93 OSM-S SoM and BL carrier board
- Fix probe of i.MX FEC MDIO bus for DM_MDIO.
- Cleanup for tqma6 boards.
- Initialize the ELE RNG context on imx95_evk
- Disable EFI partition, MP, sysboot, bind commands on tbs2910.

----------------------------------------------------------------
Andrea Calabrese (2):
      bsh: make common configuration for m2
      bsh: add support for imx6ulz_smm_m2d

Benjamin Hahn (6):
      phytec: adapt env to ampliphy-boot bootscripts for imx8 boards
      phytec: add emmc_dev and sd_dev env vars for imx8 boards
      phytec: set bootdevices and bootmeths in devicetree for imx8 boards
      phytec: change preferred bootdevice dynamically
      phytec: use fdtoverlay_addr_r
      phytec: sort .env files alphabetically for imx8 boards

Frieder Schrempf (3):
      imx: Add support for Kontron i.MX8MP OSM-S SoM and BL carrier board
      arm: imx: imx9: Use arch override for env_get_location()
      imx: Add support for Kontron i.MX93 OSM-S SoM and BL carrier board

Ji Luo (1):
      imx95_evk: Initialize the ELE RNG context

Marek Vasut (1):
      board: tbs2910: Disable EFI partition, MP, sysboot, bind commands

Markus Niebel (8):
      net: fec_mxc: respect return value of phy_config
      net: fec-mxc: prevent crash if no MAC address is set
      net: fec_mxc: fix probe of MDIO bus for DM_MDIO
      net: fec_mxc: fix remove with DM_MDIO
      net: fec_mxc: rewrite fallback MDIO Bus allocation
      net: fec_mxc: fix usage of DM_MDIO and DM_ETH_PHY
      net: fec_mxc: add unique bus and device names for DM_MDIO
      net: fec_mxc.c: improve readability of dm_fec_bind_mdio

Max Merchel (3):
      tqma6: Remove empty function tqma6_iomuxc_spi()
      board: [cosmetic] tqma6: adjust SPDX tag
      board: tqma6: update MAINTAINERS

Paul Gerber (1):
      board: tqma6: style fixes

Tom Rini (43):
      opos6uldev: Stop disabling device tree relocation
      gw_ventana: Stop disabling device tree relocation
      imx6dl-sielaff: Stop disabling device tree relocation
      bk4r1: Stop disabling device tree relocation
      cl-som-imx7: Stop disabling device tree relocation
      cm_fx6: Stop disabling device tree relocation
      dart_6ul: Stop disabling device tree relocation
      display5: Stop disabling device tree relocation
      imx6-engicam: Stop disabling device tree relocation
      imx6dl-mamoj: Stop disabling device tree relocation
      kp_imx53: Stop disabling device tree relocation
      kp_imx6q_tpc: Stop disabling device tree relocation
      mccmon6: Stop disabling device tree relocation
      mx53cx9020: Stop disabling device tree relocation
      mx6sabre: Stop disabling device tree relocation
      mx6slevk: Stop disabling device tree relocation
      mx6sllevk: Stop disabling device tree relocation
      mx6sxsabreauto: Stop disabling device tree relocation
      mx6sxsabresd: Stop disabling device tree relocation
      mx6ul_14x14_evk: Stop disabling device tree relocation
      mx6ullevk: Stop disabling device tree relocation
      mx7dsabresd: Stop disabling device tree relocation
      mx7ulp_com: Stop disabling device tree relocation
      mx7ulp_evk: Stop disabling device tree relocation
      mys_6ulx: Stop disabling device tree relocation
      nitrogen6x: Stop disabling device tree relocation
      novena: Stop disabling device tree relocation
      pico-imx6: Stop disabling device tree relocation
      pico-imx6ul: Stop disabling device tree relocation
      pico-imx7d: Stop disabling device tree relocation
      tqma6: Stop disabling device tree relocation
      udoo: Stop disabling device tree relocation
      udoo_neo: Stop disabling device tree relocation
      wandboard: Stop disabling device tree relocation
      warp7: Stop disabling device tree relocation
      capricorn: Stop disabling device tree relocation
      imx8mq_phanbell: Stop disabling device tree relocation
      imx8qm_mek: Stop disabling device tree relocation
      imx8qxp_mek: Stop disabling device tree relocation
      liteboard: Stop disabling device tree relocation
      pcl063: Stop disabling device tree relocation
      pcl063_ull: Stop disabling device tree relocation
      pico-imx8mq: Stop disabling device tree relocation

 arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi |   16 +
 arch/arm/dts/imx8mm-phygate-tauri-l-u-boot.dtsi    |   16 +
 arch/arm/dts/imx8mp-kontron-bl-osm-s-u-boot.dtsi   |  124 +
 .../arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi |   20 +
 arch/arm/dts/imx93-kontron-bl-osm-s-u-boot.dtsi    |  153 ++
 arch/arm/mach-imx/imx8m/Kconfig                    |   14 +
 arch/arm/mach-imx/imx9/Kconfig                     |   11 +-
 arch/arm/mach-imx/imx9/soc.c                       |    2 +-
 board/armadeus/opos6uldev/opos6uldev.env           |    1 -
 board/bsh/imx6ulz_smm_m2/Kconfig                   |    6 +
 board/bsh/imx6ulz_smm_m2/MAINTAINERS               |    1 +
 board/bsh/imx6ulz_smm_m2/Makefile                  |    1 +
 board/bsh/imx6ulz_smm_m2/ddr3l_timing_128m_m2d.c   |  121 +
 board/bsh/imx6ulz_smm_m2/ddr3l_timing_256m_m2d.c   |  122 +
 board/bsh/imx6ulz_smm_m2/ddr3l_timing_512m_m2d.c   |  127 +
 board/freescale/imx95_evk/spl.c                    |    7 +
 board/gateworks/gw_ventana/gw_ventana.env          |    1 -
 board/kontron/osm-s-mx8mp/Kconfig                  |   17 +
 board/kontron/osm-s-mx8mp/MAINTAINERS              |    7 +
 board/kontron/osm-s-mx8mp/Makefile                 |    9 +
 board/kontron/osm-s-mx8mp/imximage.cfg             |    8 +
 board/kontron/osm-s-mx8mp/lpddr4_timing.c          | 2474 ++++++++++++++++++++
 board/kontron/osm-s-mx8mp/osm-s-mx8mp.c            |  175 ++
 board/kontron/osm-s-mx8mp/osm-s-mx8mp.env          |    6 +
 board/kontron/osm-s-mx8mp/spl.c                    |  358 +++
 board/kontron/osm-s-mx93/Kconfig                   |   17 +
 board/kontron/osm-s-mx93/MAINTAINERS               |    7 +
 board/kontron/osm-s-mx93/Makefile                  |    9 +
 board/kontron/osm-s-mx93/lpddr4x_timing.c          | 1992 ++++++++++++++++
 board/kontron/osm-s-mx93/osm-s-mx93.c              |  168 ++
 board/kontron/osm-s-mx93/osm-s-mx93.env            |    6 +
 board/kontron/osm-s-mx93/spl.c                     |  169 ++
 board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.c |    2 +-
 .../phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env |   14 +-
 board/phytec/phycore_imx8mm/phycore-imx8mm.c       |    2 +
 board/phytec/phycore_imx8mm/phycore_imx8mm.env     |   14 +-
 board/phytec/phycore_imx8mp/phycore-imx8mp.c       |    5 +-
 board/phytec/phycore_imx8mp/phycore_imx8mp.env     |   17 +-
 board/sielaff/imx6dl-sielaff/imx6dl-sielaff.env    |    1 -
 board/siemens/capricorn/capricorn_default.env      |    1 -
 board/tq/tqma6/Kconfig                             |   23 +-
 board/tq/tqma6/MAINTAINERS                         |    3 +-
 board/tq/tqma6/Makefile                            |    7 +-
 board/tq/tqma6/clocks.cfg                          |    7 +-
 board/tq/tqma6/tqma6.c                             |   16 +-
 board/tq/tqma6/tqma6_bb.h                          |    7 +-
 board/tq/tqma6/tqma6_mba6.c                        |   10 +-
 board/tq/tqma6/tqma6_wru4.c                        |   13 +-
 board/tq/tqma6/tqma6dl.cfg                         |    6 +-
 board/tq/tqma6/tqma6q.cfg                          |    6 +-
 board/tq/tqma6/tqma6s.cfg                          |    6 +-
 configs/imx6ulz_smm_m2.config                      |   81 +
 configs/imx6ulz_smm_m2_defconfig                   |   82 +-
 configs/imx6ulz_smm_m2b_defconfig                  |   82 +-
 configs/imx6ulz_smm_m2d_defconfig                  |    2 +
 configs/kontron-osm-s-mx8mp.config                 |  203 ++
 configs/kontron-osm-s-mx8mp_defconfig              |    3 +
 configs/kontron-osm-s-mx93.config                  |  197 ++
 configs/kontron-osm-s-mx93_defconfig               |    3 +
 configs/phycore-imx8mp_defconfig                   |    1 -
 configs/tbs2910_defconfig                          |    5 +-
 doc/board/bsh/imx6ulz_bsh_smm_m2.rst               |   12 +-
 doc/board/kontron/index.rst                        |    2 +
 doc/board/kontron/osm-s-mx8mp.rst                  |  104 +
 doc/board/kontron/osm-s-mx93.rst                   |   95 +
 drivers/net/fec_mxc.c                              |   56 +-
 drivers/net/fec_mxc.h                              |    4 +
 include/configs/bk4r1.h                            |    1 -
 include/configs/cl-som-imx7.h                      |    1 -
 include/configs/cm_fx6.h                           |    1 -
 include/configs/dart_6ul.h                         |    1 -
 include/configs/display5.h                         |    1 -
 include/configs/imx6-engicam.h                     |    1 -
 include/configs/imx6dl-mamoj.h                     |    1 -
 include/configs/imx8mq_phanbell.h                  |    1 -
 include/configs/imx8qm_mek.h                       |    1 -
 include/configs/imx8qxp_mek.h                      |    1 -
 include/configs/kontron-osm-s-mx8mp.h              |   30 +
 include/configs/kontron-osm-s-mx93.h               |   30 +
 include/configs/kp_imx53.h                         |    1 -
 include/configs/kp_imx6q_tpc.h                     |    1 -
 include/configs/liteboard.h                        |    1 -
 include/configs/mccmon6.h                          |    1 -
 include/configs/mx53cx9020.h                       |    1 -
 include/configs/mx6sabre_common.h                  |    1 -
 include/configs/mx6slevk.h                         |    1 -
 include/configs/mx6sllevk.h                        |    1 -
 include/configs/mx6sxsabreauto.h                   |    1 -
 include/configs/mx6sxsabresd.h                     |    1 -
 include/configs/mx6ul_14x14_evk.h                  |    1 -
 include/configs/mx6ullevk.h                        |    1 -
 include/configs/mx7dsabresd.h                      |    1 -
 include/configs/mx7ulp_com.h                       |    1 -
 include/configs/mx7ulp_evk.h                       |    1 -
 include/configs/mys_6ulx.h                         |    1 -
 include/configs/nitrogen6x.h                       |    1 -
 include/configs/novena.h                           |    1 -
 include/configs/pcl063.h                           |    1 -
 include/configs/pcl063_ull.h                       |    1 -
 include/configs/pico-imx6.h                        |    1 -
 include/configs/pico-imx6ul.h                      |    1 -
 include/configs/pico-imx7d.h                       |    1 -
 include/configs/pico-imx8mq.h                      |    1 -
 include/configs/tqma6.h                            |    7 +-
 include/configs/tqma6_mba6.h                       |    6 +-
 include/configs/tqma6_wru4.h                       |    2 +-
 include/configs/udoo.h                             |    1 -
 include/configs/udoo_neo.h                         |    1 -
 include/configs/wandboard.h                        |    1 -
 include/configs/warp7.h                            |    1 -
 110 files changed, 7066 insertions(+), 304 deletions(-)
 create mode 100644 arch/arm/dts/imx8mp-kontron-bl-osm-s-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx93-kontron-bl-osm-s-u-boot.dtsi
 create mode 100644 board/bsh/imx6ulz_smm_m2/ddr3l_timing_128m_m2d.c
 create mode 100644 board/bsh/imx6ulz_smm_m2/ddr3l_timing_256m_m2d.c
 create mode 100644 board/bsh/imx6ulz_smm_m2/ddr3l_timing_512m_m2d.c
 create mode 100644 board/kontron/osm-s-mx8mp/Kconfig
 create mode 100644 board/kontron/osm-s-mx8mp/MAINTAINERS
 create mode 100644 board/kontron/osm-s-mx8mp/Makefile
 create mode 100644 board/kontron/osm-s-mx8mp/imximage.cfg
 create mode 100644 board/kontron/osm-s-mx8mp/lpddr4_timing.c
 create mode 100644 board/kontron/osm-s-mx8mp/osm-s-mx8mp.c
 create mode 100644 board/kontron/osm-s-mx8mp/osm-s-mx8mp.env
 create mode 100644 board/kontron/osm-s-mx8mp/spl.c
 create mode 100644 board/kontron/osm-s-mx93/Kconfig
 create mode 100644 board/kontron/osm-s-mx93/MAINTAINERS
 create mode 100644 board/kontron/osm-s-mx93/Makefile
 create mode 100644 board/kontron/osm-s-mx93/lpddr4x_timing.c
 create mode 100644 board/kontron/osm-s-mx93/osm-s-mx93.c
 create mode 100644 board/kontron/osm-s-mx93/osm-s-mx93.env
 create mode 100644 board/kontron/osm-s-mx93/spl.c
 create mode 100644 configs/imx6ulz_smm_m2.config
 create mode 100644 configs/imx6ulz_smm_m2d_defconfig
 create mode 100644 configs/kontron-osm-s-mx8mp.config
 create mode 100644 configs/kontron-osm-s-mx8mp_defconfig
 create mode 100644 configs/kontron-osm-s-mx93.config
 create mode 100644 configs/kontron-osm-s-mx93_defconfig
 create mode 100644 doc/board/kontron/osm-s-mx8mp.rst
 create mode 100644 doc/board/kontron/osm-s-mx93.rst
 create mode 100644 include/configs/kontron-osm-s-mx8mp.h
 create mode 100644 include/configs/kontron-osm-s-mx93.h
