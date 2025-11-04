Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43547CCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 18:00:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C05D78004F;
	Tue,  4 Nov 2025 19:00:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BY9m/QxL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 001358144A; Tue,  4 Nov 2025 19:00:55 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28ADD8003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 19:00:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2951a817541so64186865ad.2
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 10:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762279251; x=1762884051; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nn1AlgrpB/oHV3s0tuij/OZJhyLIdRej1eUxGdfYT4A=;
 b=BY9m/QxLR6hYc70UO2kz5Ndz1F4DNqQ6dDnBlIklSGA2B8oCZjIid3oagf3xb8rhUg
 oAEtnLbhA8GnESSfQtv4sm2jUA/D2ihbh8pF7MHKQYYZoRQz2PR00Vj7n4R54suUWho2
 suc1tb9ZBMOctb2TT8Lcgn86It9Z8rVgJRJBED1FuDQjkOGEyrJbx5o0EgWkw2xUvEdJ
 rPCO1VNH0kXYI4vOFGBZxAOB+6g5i5Qunu2CBlzrnu0eADwAHBwCTkFWsGAxJJ69OT+4
 VbDWl2gQFBQ6R9ZXje0j021U5UYm9TCA92VFVukLtb6Bvg4ehoSYcUZzMFClYui4Ek9Y
 Cbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762279251; x=1762884051;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nn1AlgrpB/oHV3s0tuij/OZJhyLIdRej1eUxGdfYT4A=;
 b=u0i+BCv+W1T7rmUkLSRzsjCiOHQLXsbOZW0xdhE90sdVky2hlfb0ONIR6Tyh+gV2rn
 EVG0zIKJQh90e0yYqfvYsLwAfiHrVNsRENfIHW7i4K8tuCC3VuhZ/ZkVQc5jzTUrGoOO
 loZyyl/jhwBsX6F8ikeCRlvaJvQA8VYzcEIcSliKp6kyut574lpyvvynUk27HO5UIqS6
 IOWP66Pg2eiQ8dL3a8AD/lr50cM7QSc387c4nY+FOF6AwNctZ5X1eWnL8vuACYwwkNIu
 fFLFm8IPf+OGQiZiFmxoyiDqV4kyCGkpiDVhP+L9TXB2MZkjPvpbUw4hxEMYnIjhPLM6
 Qleg==
X-Gm-Message-State: AOJu0YyWkHwt/pn0vgDSdlfIcJ/ys6UEc7UEMlDPa4QEBlmLHVTY3AFM
 9eCmLnnlT67QSIy6Du+SZ0x5H2+ZGwWUSgpPAy9rV+PlW2s+E4VUuycBvKtdepbk
X-Gm-Gg: ASbGncsd7/ERMBIAxIWzZmD4YtFSKBalmKSK5SakE9/M/poCtWSSv9Yeh0CIsp3yoKx
 M6o4P19DVyrM2wp+roFrWVodljR/4cGfZ4lGW+2dd4waSD0jFBKBjpaN1rmmdt+sU42VIwTnNrP
 tBPIzQwpXbEAe9TforMNIgBbghS2AD5O1oP2nBvR/etl+jNY1iif+fQ1Fs4Gfezy21h7kcsVZCs
 wjyHhxRNZGxoVS76pbwY3yVdalmzqOD5t1aZSe4ahL8SrPpROX7nsO6qI7SaDhkSkeSjGWuzflE
 PYGQRwz1fd2pYfg4dScWF8nkVKRsrowAPokuVoGgddnKiyMKL77CdENHnX9fKqIZi72iCgEF+3B
 y9gWLkATWnihYEWCNvOHOqCQaBFW/SL6ZW5YHtTSo2/PYfn2kzaXlIoIejlgshv6t8kfU+wmoUL
 pmVmXIxBYwfXOCqw==
X-Google-Smtp-Source: AGHT+IEerBbhC2mDT3g8OOFhTaoknzgm5qWBhT6SXB22Zl5WKU+45wPx4ge3S1guPhDZPMlQ3ey7mw==
X-Received: by 2002:a17:903:285:b0:295:54cd:d2dc with SMTP id
 d9443c01a7336-2962ad1fab7mr6860975ad.16.1762279250776; 
 Tue, 04 Nov 2025 10:00:50 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:1844:8cc4:4bb8:9691])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29601a7afefsm33638435ad.111.2025.11.04.10.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 10:00:48 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20251104
Date: Tue,  4 Nov 2025 15:00:44 -0300
Message-Id: <20251104180044.1507580-1-festevam@gmail.com>
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

Please pull from u-boot-imx/master, thanks.

The following changes since commit c9fdb9ac4d5234953ffaaef0cfc9d4ccb03f0ce5:

  Merge patch series "Allow falcon boot from A-core SPL on K3 devices" (2025-11-03 13:18:26 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20251104

for you to fetch changes up to 2b7892255bd617dfc523cfe8455dbf386a3dfaf5:

  imx95_evk: Add basic support for iMX95 15x15 EVK (2025-11-04 12:46:28 -0300)

u-boot-imx-master-20251104
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/28144

- Extend USB support for the i.MX9 family.
- Update memory controller for imx6ulz_smm_m2.
- Add remoteproc support for several i.MX boards.
- Add support for iMX95 15x15 EVK.
----------------------------------------------------------------
Alice Guo (7):
      usb: ehci-mx6: Extend support to i.MX91, i.MX93, i.MX94, and i.MX95
      arm: arch-imx9: Add USB2.0 and USB3.0 base address definitions
      imx943_evk: Enable USB 2.0 controller host mode
      phy: imx8mq-usb: Add SPL support for i.MX8MQ, i.MX8MP, i.MX95, and i.MX94 USB3.0 PHY
      imx943_evk: Add support for booting from USB SDP on USB3.0
      imx943_evk: Enable ENETC1 and ENETC2
      arm64: imx8ulp: Split SRAM0 mapping to isolate the SCMI shared memory as non-cacheable

Andrea Calabrese (2):
      bsh: update readme with instructions to build M2B
      bsh: imx6ulz_smm_m2: Update imx6ulz BSH SMM M2B board

Francesco Dolcini (1):
      configs: toradex-smarc-imx95: enable USB Gadget OS Descriptors for fastboot

Frank Li (1):
      Add serial# for SPL SDP download

Frieder Schrempf (6):
      imx: kontron-sl-mx8mm: Adjust offset for U-Boot proper in case of eMMC fastboot
      imx: kontron-sl-mx8mm: Implement spl_board_loader_name()
      imx: kontron-sl-mx6ul: Enable CONFIG_BOARD_LATE_INIT to fix auto fastboot
      imx: kontron: Add common function to get HW UIDs from OTPs
      imx: kontron-sl-mx6ul: Add support for reading HW UIDs
      imx: kontron-sl-mx8mm: Add support for reading HW UIDs

Marek Vasut (3):
      imx9: scmi: Drop parenthesis around enable
      ARM: imx: Enable DFU SF on all i.MX6 DHSOM and include dfu_alt_info in env
      arm64: dts: imx8mp: Add missing LED enumerators for DH electronics i.MX8M Plus DHCOM on PDK2

Peng Fan (12):
      remoteproc: Extend device_to_virt with a is_iomem parameter
      remoteproc: Add imx_rproc driver to support NXP i.MX8MP/N
      remoteproc: imx_rproc: Support i.MX8MQ/M
      remoteproc: imx_rproc: Add support for i.MX93 CM33
      arm: dts: imx8m: Add remoteproc node
      imx8mp: Enable remoteproc for i.MX8MP EVK
      imx8mm: Enable remoteproc for i.MX8MM EVK
      imx8mn: Enable remoteproc for i.MX8MN EVK
      imx8mq: Enable remoteproc for i.MX8MQ EVK
      imx93: Enable remoteproc for i.MX93-EVK/QSB/FRDM
      doc: board: nxp: Add remoteproc guide
      doc: cmd: Document remoteproc usage

Ye Li (6):
      usb: f_sdp: Update SDP driver to support PQC container
      net: fsl_enetc: Add i.MX94 support to NETC block control driver
      net: fsl_enetc_mdio: Add support for phy-supply property
      imx95_evk: Share the env file for both 19x19 EVK and 15x15 EVK
      arm: dts: imx95-15x15-evk: Add -u-boot.dtsi for SPL and binman
      imx95_evk: Add basic support for iMX95 15x15 EVK

 MAINTAINERS                                        |   2 +
 arch/arm/dts/imx8mm-u-boot.dtsi                    |   4 +
 arch/arm/dts/imx8mn-u-boot.dtsi                    |   4 +
 arch/arm/dts/imx8mp-dhcom-pdk2-u-boot.dtsi         |  20 ++
 arch/arm/dts/imx8mp-u-boot.dtsi                    |   4 +
 arch/arm/dts/imx8mq-u-boot.dtsi                    |   4 +
 arch/arm/dts/imx943-evk-u-boot.dtsi                | 182 ++++++++++
 arch/arm/dts/imx943-u-boot.dtsi                    | 234 +++++++++++++
 arch/arm/dts/imx95-15x15-evk-u-boot.dtsi           |  85 +++++
 arch/arm/include/asm/arch-imx9/imx-regs.h          |   5 +
 arch/arm/mach-imx/imx8m/Kconfig                    |  20 ++
 arch/arm/mach-imx/imx8ulp/soc.c                    |  17 +-
 arch/arm/mach-imx/imx9/Kconfig                     |  19 ++
 arch/arm/mach-imx/imx9/scmi/clock_scmi.c           |   2 +-
 arch/arm/mach-imx/spl.c                            |  12 +
 board/bsh/imx6ulz_smm_m2/Makefile                  |   2 +-
 board/bsh/imx6ulz_smm_m2/README                    |  67 ----
 board/bsh/imx6ulz_smm_m2/ddr3l_timing_512m_m2b.c   | 127 +++++++
 board/bsh/imx6ulz_smm_m2/spl.c                     |   2 -
 board/freescale/imx95_evk/Kconfig                  |   2 +-
 board/freescale/imx95_evk/MAINTAINERS              |   1 +
 .../{imx95_19x19_evk.env => imx95_evk.env}         |   0
 board/kontron/common/Kconfig                       |  14 +
 board/kontron/common/Makefile                      |   1 +
 board/kontron/common/hw-uid.c                      |  75 +++++
 board/kontron/common/hw-uid.h                      |  26 ++
 board/kontron/sl-mx6ul/Kconfig                     |   2 +
 board/kontron/sl-mx6ul/sl-mx6ul.c                  |  32 ++
 board/kontron/sl-mx8mm/Kconfig                     |   2 +
 board/kontron/sl-mx8mm/sl-mx8mm.c                  |  32 ++
 board/kontron/sl-mx8mm/spl.c                       |  47 +++
 configs/dh_imx6.config                             |   1 +
 configs/imx943_evk_defconfig                       |  30 ++
 configs/imx95_15x15_evk_defconfig                  | 148 +++++++++
 configs/imx95_evk.config                           |   2 +-
 configs/kontron-sl-mx6ul_defconfig                 |   2 +
 configs/kontron-sl-mx8mm_defconfig                 |   1 +
 configs/toradex-smarc-imx95_defconfig              |   1 +
 doc/board/bsh/imx6ulz_bsh_smm_m2.rst               |  85 +++++
 doc/board/bsh/index.rst                            |   1 +
 doc/board/nxp/imx95_evk.rst                        |  24 +-
 doc/board/nxp/index.rst                            |   1 +
 doc/board/nxp/rproc.rst                            |  69 ++++
 doc/usage/cmd/rproc.rst                            |  78 +++++
 drivers/net/Kconfig                                |   5 +-
 drivers/net/fsl_enetc_mdio.c                       |  25 ++
 drivers/net/fsl_enetc_netc_blk_ctrl.c              | 329 +++++++++++++++++-
 drivers/phy/Kconfig                                |  14 +-
 drivers/phy/Makefile                               |   2 +-
 drivers/remoteproc/Kconfig                         |   7 +
 drivers/remoteproc/Makefile                        |   1 +
 drivers/remoteproc/imx_rproc.c                     | 370 +++++++++++++++++++++
 drivers/remoteproc/imx_rproc.h                     |  56 ++++
 drivers/remoteproc/renesas_apmu.c                  |   3 +-
 drivers/remoteproc/rproc-elf-loader.c              |  95 ++++--
 drivers/remoteproc/sandbox_testproc.c              |   3 +-
 drivers/remoteproc/stm32_copro.c                   |   3 +-
 drivers/remoteproc/ti_k3_dsp_rproc.c               |   2 +-
 drivers/remoteproc/ti_k3_m4_rproc.c                |   2 +-
 drivers/remoteproc/ti_k3_r5f_rproc.c               |   2 +-
 drivers/usb/gadget/f_sdp.c                         |   2 +-
 drivers/usb/host/Kconfig                           |   6 +-
 include/configs/dh_imx6.h                          |   1 +
 include/configs/imx95_evk.h                        |   8 +-
 include/remoteproc.h                               |   3 +-
 65 files changed, 2292 insertions(+), 136 deletions(-)
 create mode 100644 arch/arm/dts/imx95-15x15-evk-u-boot.dtsi
 delete mode 100644 board/bsh/imx6ulz_smm_m2/README
 create mode 100644 board/bsh/imx6ulz_smm_m2/ddr3l_timing_512m_m2b.c
 rename board/freescale/imx95_evk/{imx95_19x19_evk.env => imx95_evk.env} (100%)
 create mode 100644 board/kontron/common/Kconfig
 create mode 100644 board/kontron/common/Makefile
 create mode 100644 board/kontron/common/hw-uid.c
 create mode 100644 board/kontron/common/hw-uid.h
 create mode 100644 configs/imx95_15x15_evk_defconfig
 create mode 100644 doc/board/bsh/imx6ulz_bsh_smm_m2.rst
 create mode 100644 doc/board/nxp/rproc.rst
 create mode 100644 doc/usage/cmd/rproc.rst
 create mode 100644 drivers/remoteproc/imx_rproc.c
 create mode 100644 drivers/remoteproc/imx_rproc.h
