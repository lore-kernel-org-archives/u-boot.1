Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A92606A31C
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 02:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=M3Xf9x25;
	dkim=pass (2048-bit key, unprotected) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=JyCDSbbF
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 130D960E18;
	Fri, 13 Nov 2026 02:32:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qJEGwZePogER; Fri, 13 Nov 2026 02:32:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9AF0760E1C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794537174;
	b=m6jNMcfnBQJnMut5Hf5BZhcaFQ5LqS6XAa3tSd0XM+oZzzkoZtr+moklA0RBa68tlQqi
	 BCsk/+BhSN8iO0KhNDh4Ie5dfoXsCcBD2wWCOezXpcx7HX8ncEifkV9YfeVj6sCuPjthJ
	 5Cw/5lMloBnY093TAIUfScTBnLiDheLRNLdK4L9ekskR+33joptDcmLLlMFoVSG21BLww
	 kpMu+0DDU9vPblyJsUh0DZ9RX2hA5A8i5C4bA3fKu5WqSuFOvanOMjP5VMckLdBCORtdo
	 OOvlgCsBzfrRnpUD/YkpjQTizbeO+8Ast9RLTc302QbImxqMYv2fIriTzIF70H1S48Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794537174;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-GPT-Reason:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zVqanJQ6fAr3ax4MtdsNpFcDzoaBLPkiRqalIyrYezc=;
	b=X/hyGZbT6zop8kI+P0JDT+kmlZIggl3zVPLluYCTj5Yeo9DSB3I+Vck3aTVQKcQ0kK7d
	 dUOMqHjmqvLq7xmndRT+9buC8lQTanG1pNFD5ieUtFpVdrNNE7zooPcWLW0G1k4dXoB1Z
	 hMAlLI76LGuHUlbwtjVjgzwFT2gV7vCzw4cDtHbZr/dc97abBkZkGbiGL5htBYt+DJiJn
	 k/hhkGbjiL/3W/7sAELW1DM91ev9XWcyroD/6/cXyxfJx//dZGaej5STKtL+laUiBpZIz
	 fkUmaFRKt09MTyjDie+v7k7huoY2oVRLn9Z4V5TNXO9d0vupJK0im1JSe3Xz1uFa/oQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794537174;
	bh=zVqanJQ6fAr3ax4MtdsNpFcDzoaBLPkiRqalIyrYezc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=M3Xf9x25C2Wrqyuk3onYBcM/xtOP/WCsO5QYNKfHNzLjG1bFkbZ9HDiM42aZU8ogU
	 XL8jtSybDf+2nXdNSAs1aSF6rN4JHDaj37DF/PJXzYbw+OFJulhw7x+sA087LpCykr
	 Fx5ZuWE8iH7GuyhhwDKc5xw4+Q3sDUIHt+HG9gqoQ86w2QHG92x3y5nuDUgpqQTxef
	 AFj9dllWTjSdGHVGScTpS2F0n14sCbROX588RBTD/vn0+auut8wT5ofvIyTKxaVDjo
	 fAmPO/N6j8Chr4ldznvAf8QjfB0aeWU/7vYlhVon8yIH5I4ejXrX3zNiCeDImsp+Xg
	 VCEu9mF92NO6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9AF0760E1C;
	Fri, 13 Nov 2026 02:32:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 73DD1F46
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:32:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 652B340D44
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:32:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zP3uY4Fuq0vI for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 02:32:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 351A840B22
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=119.15.109.137
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=119.15.109.137;
 helo=www.nmnhosting.com; envelope-from=alastair@d-silva.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256
 header.s=2025a header.b=JyCDSbbF
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 351A840B22
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:32:49 +0000 (UTC)
Received: from Hawking.lan (hawking.lan [10.0.1.4])
 by www.nmnhosting.com (Postfix) with ESMTP id F3BF740075;
 Fri, 13 Nov 2026 13:32:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a; 
 t=1794537157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=zVqanJQ6fAr3ax4MtdsNpFcDzoaBLPkiRqalIyrYezc=;
 b=JyCDSbbFlojvBR7PQogpZOkNDzPaV+FeudbXdWTAiGwTDaou7WA++aaExii7ZYGC36cnq5
 9j5q2PnmoZ+QKoPx8f6SNkVXmNyE0k/AUL8uBS3OKGstMtnvnUZTllzQhbeOZr1CaSuiQ6
 qJHLh8YKJ77pdfX+9xAkJLOgk8dxi0f4SzMvXTFLV6O5FY0EhAxfejzTkPRBeIj7Id9LFw
 xPfV6Fe9QKoYdBucq5OHVga+Mj6qVdifP/ZAysQZw+RWtDBy7DTnZwom95aNbqLoqUAtRf
 UmaShKtOn/6UR7sef7CtWQTDuUWSdxy0I3fcj8aGViONmY/Pnv6hVttpThcIVA==
X-GPT-Reason: legitimate; the email is a technical software patch
 submission for the U-Boot project, which perfectly matches the
 personal/professional context of the recipient (alastair@d-silva.org);
 the sender's domain (d-silva.org) matches the recipient, indicating
 a known personal or professional relationship; the content is highly
 specific technical documentation regarding SoC support (Allwinner
 A733) and includes links to trusted firmware review domains
 (trustedfirmware.org) consistent with open-source development;
 there are no signs of marketing, urgency, or phishing tactics.
From: Alastair D'Silva <alastair@d-silva.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 Enzo Adriano <enzo.adriano.code@gmail.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Alastair D'Silva <alastair@d-silva.org>
Subject: [PATCH 00/26] sunxi: Add Allwinner A733 (sun60i) and Orange Pi 4 Pro
 support
Date: Fri, 13 Nov 2026 13:32:10 +1100
Message-ID: <20261113023236.569054-1-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds initial support for the Allwinner A733 (sun60iw2 / sun60i)
SoC and the Xunlong Orange Pi 4 Pro board to U-Boot.

The A733 is an octa-core ARMv8 SoC (dual-cluster Cortex-A76 + Cortex-A55)
with LPDDR5 memory trained by an on-chip Synopsys ARC PMU, an AXP318W PMIC,
eMMC/SD (MMC0/1/2), USB 2.0 EHCI/OHCI, and a DesignWare PCIe Gen3 x1 host
controller paired with a Cadence Combo PHY.

Overview of the series:
- Patches 1-3: Fix AXP318W ELDO voltage mask and sysreset shutdown register,
  and extend SPL PMIC support for DCDC6/7 and ALDO/BLDO/DLDO/ELDO rails
  required to bring up LPDDR5 and board I/O.
- Patches 4-11: Add A733 CCU/R-CCU dt-bindings, GPIO, pinctrl, clock/reset,
  MMC (including transfer-size-scaled data timeout), and UART console support.
- Patches 12-13: Add disposable .init.rodata support for AArch64 SPL (allowing
  large DRAM init tables in SRAM A2 without exceeding the 0x58000 BL31 load
  address) and ERET-based FEL return support for A733.
- Patches 14-21: Add freestanding ARC PMU LPDDR5 training firmware (built from
  C via ARC_CROSS_COMPILE, or supplied via PMU_FW= / BINMAN_ALLOW_MISSING=1),
  the A733 LPDDR5 DRAM driver, initial sun60i SoC support, and documentation
  in doc/board/allwinner/a733-pmu.rst.
- Patches 22-24: Add the A733 Cadence Combo PHY driver, DesignWare PCIe
  controller driver, and NVMe distro boot target support. Note that a small
  SoC helper (sunxi_a733_pcie_soc_init) handles PCIe/SerDes CCU muxes,
  RTC DCXO feed, SYS_PLL, and NSI QoS until U-Boot's gate-only clk_sunxi
  driver gains rate/parent support for A733.
- Patches 25-26: Add the sun60i-a733.dtsi SoC device tree and Xunlong
  Orange Pi 4 Pro board support (defconfig, DTS, and MAINTAINERS).

Tested on live Xunlong Orange Pi 4 Pro (6 GiB LPDDR5 @ 3600 MT/s) via FEL
boot with TF-A BL31 v2.15.0 + pending Allwinner A733 TF-A patches:
- https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/55200
  (feat(allwinner): add A733 support)
- https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/55204
  (feat(allwinner): a733: ungate security controllers)
- https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/55205
  (fix(allwinner): restore core security on power-on)

Verified functionality:
- SPL DRAM training (6144 MiB LPDDR5, 3600 MT/s)
- SD card (mmc0: SD32G 29.7 GiB, 4-bit)
- PCIe Gen3 + NVMe SSD (UHPVN0153EQ0V2 238.4 GB, partition enumeration)

Alastair D'Silva (17):
  power: regulator: axp: Fix AXP318W ELDO voltage mask
  power: pmic: axp: Fix AXP318W sysreset shutdown register
  power: axp: Extend AXP318W SPL support with DCDC6/7 and LDOs
  mmc: sunxi: Scale data transfer timeout with transfer size
  arm64: spl: Support disposable .init.rodata section after
    _image_binary_end
  sunxi: fel: Add Allwinner A733 ERET FEL return support
  sunxi: dram: a733: Add ARC PMU register, ABI, and build definitions
  sunxi: dram: a733: Add ARC PMU primitives, clock, telemetry, and CBT
  sunxi: dram: a733: Add ARC PMU deskew and BIST training firmware
  sunxi: dram: a733: Add ARC PMU 1D/2D eye training firmware
  sunxi: dram: a733: Add ARC PMU training state machine
  sunxi: dram: a733: Add Allwinner A733 LPDDR5 DRAM driver
  doc: sunxi: Document Allwinner A733 LPDDR5 PMU architecture
  phy: sunxi: Add Allwinner A733 Cadence Combo PHY driver
  pci: sunxi: Add Allwinner A733 DesignWare PCIe host controller driver
  sunxi: Add NVMe to distro boot targets
  sunxi: Add Xunlong Orange Pi 4 Pro board support

Enzo Adriano (1):
  arm64: dts: allwinner: add A733 SoC description

Junhui Liu (1):
  dt-bindings: clk: sun60i-a733-ccu: Add Allwinner A733 support

Yixun Lan (7):
  gpio: a733: add initial support
  pinctrl: sunxi: a733: add initial support
  clock: reset: a733: add initial support
  clock: a733: implement support for mmc/uart
  sunxi: mmc: enable support for A733
  sunxi: a733: uart: setup serial console
  sunxi: sun60i: initial support for A733 SoC

 MAINTAINERS                                   |   13 +
 arch/arm/config.mk                            |    4 +
 arch/arm/cpu/armv8/fel_utils.S                |  113 +-
 arch/arm/cpu/armv8/u-boot-spl.lds             |   20 +
 arch/arm/cpu/armv8/u-boot.lds                 |    1 +
 arch/arm/dts/Makefile                         |    2 +
 arch/arm/dts/sun60i-a733-orangepi-4-pro.dts   |  237 +
 arch/arm/dts/sun60i-a733.dtsi                 |  816 +++
 arch/arm/include/asm/arch-sunxi/boot0.h       |   20 +-
 arch/arm/include/asm/arch-sunxi/clock.h       |    1 +
 .../include/asm/arch-sunxi/clock_sun50i_h6.h  |   19 +
 .../include/asm/arch-sunxi/cpu_sunxi_ncat2.h  |   43 +-
 arch/arm/include/asm/arch-sunxi/dram.h        |    2 +
 arch/arm/include/asm/arch-sunxi/serial.h      |   15 +-
 arch/arm/include/asm/arch-sunxi/spl.h         |    3 +
 arch/arm/include/asm/arch-sunxi/watchdog.h    |    1 +
 arch/arm/mach-sunxi/Kconfig                   |   47 +-
 arch/arm/mach-sunxi/Makefile                  |   37 +
 arch/arm/mach-sunxi/board.c                   |   16 +
 arch/arm/mach-sunxi/clock_sun50i_h6.c         |  149 +-
 arch/arm/mach-sunxi/cpu_info.c                |    2 +
 arch/arm/mach-sunxi/dram_sun60i_a733.c        | 1303 +++++
 arch/arm/mach-sunxi/dram_sun60i_a733_tables.h |  941 ++++
 arch/arm/mach-sunxi/pmu/build_pmu_fw.py       |  257 +
 arch/arm/mach-sunxi/pmu/dwc_ddrphy_pmu_regs.h |  463 ++
 arch/arm/mach-sunxi/pmu/pmu.ld                |   38 +
 arch/arm/mach-sunxi/pmu/pmu_cbt.c             |  417 ++
 arch/arm/mach-sunxi/pmu/pmu_clock.c           |  938 ++++
 arch/arm/mach-sunxi/pmu/pmu_deskew.c          | 4895 +++++++++++++++++
 arch/arm/mach-sunxi/pmu/pmu_eye.c             | 3224 +++++++++++
 arch/arm/mach-sunxi/pmu/pmu_fw.h              |  553 ++
 arch/arm/mach-sunxi/pmu/pmu_primitives.c      |  531 ++
 arch/arm/mach-sunxi/pmu/pmu_telemetry.c       |  619 +++
 arch/arm/mach-sunxi/pmu/pmu_train.c           | 2748 +++++++++
 arch/arm/mach-sunxi/pmu/sunxi_pmu_abi.h       |  251 +
 arch/arm/mach-sunxi/rmr_switch.S              |   22 +-
 board/sunxi/MAINTAINERS                       |    6 +
 board/sunxi/board.c                           |   48 +-
 common/spl/Kconfig                            |   22 +
 configs/orangepi_4_pro_defconfig              |   36 +
 doc/board/allwinner/a733-pmu.rst              |  299 +
 doc/board/allwinner/index.rst                 |    1 +
 doc/board/allwinner/sunxi.rst                 |   14 +-
 drivers/clk/sunxi/Kconfig                     |   14 +
 drivers/clk/sunxi/Makefile                    |    2 +
 drivers/clk/sunxi/clk_a733.c                  |  142 +
 drivers/clk/sunxi/clk_a733_r.c                |   45 +
 drivers/clk/sunxi/clk_sunxi.c                 |   10 +
 drivers/gpio/Kconfig                          |    7 +
 drivers/gpio/sunxi_gpio.c                     |   49 +-
 drivers/mmc/sunxi_mmc.c                       |   48 +-
 drivers/pci/Kconfig                           |   11 +
 drivers/pci/Makefile                          |    1 +
 drivers/pci/pcie_dw_sunxi.c                   |  355 ++
 drivers/phy/allwinner/Kconfig                 |    8 +
 drivers/phy/allwinner/Makefile                |    1 +
 drivers/phy/allwinner/phy-sun60i-combophy.c   |  293 +
 drivers/pinctrl/sunxi/Kconfig                 |   18 +
 drivers/pinctrl/sunxi/pinctrl-sunxi.c         |   98 +-
 drivers/power/Kconfig                         |  110 +-
 drivers/power/axp_spl.c                       |  119 +-
 drivers/power/pmic/axp.c                      |    4 +-
 drivers/power/regulator/axp_regulator.c       |   12 +-
 include/axp_pmic.h                            |    5 +
 include/configs/sun60i.h                      |   11 +
 include/configs/sunxi-common.h                |    7 +
 .../clock/allwinner,sun60i-a733-ccu.h         |  291 +
 .../clock/allwinner,sun60i-a733-r-ccu.h       |   38 +
 .../reset/allwinner,sun60i-a733-ccu.h         |  129 +
 .../reset/allwinner,sun60i-a733-r-ccu.h       |   23 +
 include/sunxi_gpio.h                          |   10 +-
 71 files changed, 20948 insertions(+), 100 deletions(-)
 create mode 100644 arch/arm/dts/sun60i-a733-orangepi-4-pro.dts
 create mode 100644 arch/arm/dts/sun60i-a733.dtsi
 create mode 100644 arch/arm/mach-sunxi/dram_sun60i_a733.c
 create mode 100644 arch/arm/mach-sunxi/dram_sun60i_a733_tables.h
 create mode 100755 arch/arm/mach-sunxi/pmu/build_pmu_fw.py
 create mode 100644 arch/arm/mach-sunxi/pmu/dwc_ddrphy_pmu_regs.h
 create mode 100644 arch/arm/mach-sunxi/pmu/pmu.ld
 create mode 100644 arch/arm/mach-sunxi/pmu/pmu_cbt.c
 create mode 100644 arch/arm/mach-sunxi/pmu/pmu_clock.c
 create mode 100644 arch/arm/mach-sunxi/pmu/pmu_deskew.c
 create mode 100644 arch/arm/mach-sunxi/pmu/pmu_eye.c
 create mode 100644 arch/arm/mach-sunxi/pmu/pmu_fw.h
 create mode 100644 arch/arm/mach-sunxi/pmu/pmu_primitives.c
 create mode 100644 arch/arm/mach-sunxi/pmu/pmu_telemetry.c
 create mode 100644 arch/arm/mach-sunxi/pmu/pmu_train.c
 create mode 100644 arch/arm/mach-sunxi/pmu/sunxi_pmu_abi.h
 create mode 100644 configs/orangepi_4_pro_defconfig
 create mode 100644 doc/board/allwinner/a733-pmu.rst
 create mode 100644 drivers/clk/sunxi/clk_a733.c
 create mode 100644 drivers/clk/sunxi/clk_a733_r.c
 create mode 100644 drivers/pci/pcie_dw_sunxi.c
 create mode 100644 drivers/phy/allwinner/phy-sun60i-combophy.c
 create mode 100644 include/configs/sun60i.h
 create mode 100644 include/dt-bindings/clock/allwinner,sun60i-a733-ccu.h
 create mode 100644 include/dt-bindings/clock/allwinner,sun60i-a733-r-ccu.h
 create mode 100644 include/dt-bindings/reset/allwinner,sun60i-a733-ccu.h
 create mode 100644 include/dt-bindings/reset/allwinner,sun60i-a733-r-ccu.h

-- 
2.53.0

