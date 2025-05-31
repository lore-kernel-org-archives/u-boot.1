Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F5EC5AE59
	for <u-boot@archiver.kernel.org>; Sat, 31 May 2025 14:54:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C769F8296B;
	Sat, 31 May 2025 16:54:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="l7x0sA8z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 570588296B; Sat, 31 May 2025 16:54:51 +0200 (CEST)
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3874D82116
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 16:54:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x543.google.com with SMTP id
 4fb4d7f45d1cf-6020ff8d54bso5012587a12.2
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 07:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1748703287; x=1749308087;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QTyUI2pUrc72UoXfk74+fuVhzpCsI8ItNefpZ1bCZLw=;
 b=l7x0sA8zo0uZDZNsHGmsaRG4/aCKeGr4krreRXcusT1QTKhT+XRi9syNEfCLWU93zM
 Y44lF1zYCkvxozFSLQ0V2iYexHfqeHY/jwWzl/B4LwOblfyC3PWB8woW7YvZXt/dRcx2
 X5MNQ1Ntt+hb/RixeErpxasBJG44mKqN87a5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748703287; x=1749308087;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QTyUI2pUrc72UoXfk74+fuVhzpCsI8ItNefpZ1bCZLw=;
 b=pgRkXBP1r8YDzExZw35aUx64bmfsVmpHBDlVkOB6psKC1q62cnVaD42Qg2L6jhU1qF
 ppUBS1kXzkHiFqryP6m1PbINq9CFMiz68JeVS2QU5e7YVaI/6D0QnCK314JaC4eHM+xl
 kBC3iWGVrIOIYHt51+wPnt/v4PS9wsrzclf/Dz1m++m3V09YoKxWRivktEGN/YHSzt2I
 OyK5DJmDMppWOh4tzp8GNl5K8pIY4xbtp1AE4tvCFs40x2qyJrT6pQXzhCN9bZ6P4RDL
 +qhwFPR6SJHzkhfND4il47ohmKiLmm7+AOYTH6jQ9y79hCahV40twdFxUFyOkGzwuvFT
 YRyg==
X-Gm-Message-State: AOJu0YwfJ0W6ijr0O53jeljVeZE2DRPipY+/CgmKU4KgWTHA8rpM1Z0M
 UsaSw6pDdWjWoL35i86LkRMIdaZ7ZkFQY/EYvd8b5+9TxSu4Mz6qbWI9DcKg6D2FIEZ04xijNLJ
 cLYhPIyKyRA==
X-Gm-Gg: ASbGncufj8OkSPJAyPmdbUxAvQ5OKYK/2n2sSKRFLneNdlQc+DfF4eDztNJkF5DNkAI
 Ylq9UgmhdQ/jw24x106x06fb494nuXwN6MF7a6oHNZNdAjTbLl+RDxTkjxCA9rBBkiKrj+8Zf2J
 xAH0kIVd2DzlEq6/kSjTY+pyNKAvUTEaz944VJhScC1drHslYDnGntyMcQxaryT3rcAbYd4uAmM
 i5vt6TydlwnGaOE0B+bHOnVP5UiKtzUdMnc1YIuhCdA6Rc+yzt04chdeT4smFvkEGHaHQTK6Idx
 ELNL6akI+zr2DI45MQGcokAsIAMnSbc4slKtKWxxEr1amlJFwhlkRfzblBzKGquR6VEY3Wbm46g
 hStprJXGZHybaRPxvL4FfcH/KHnUAtb5FwcacSQSpQeZy7/+a9I/h
X-Google-Smtp-Source: AGHT+IH0oTPMpBMVcZmwuwd78AXAD/SSr12S6vIg1tacrFo4tHL+zK+WZ8O8ItOR+kJa4tMsVYVLsQ==
X-Received: by 2002:a17:907:3c8b:b0:ad2:4d69:6da5 with SMTP id
 a640c23a62f3a-adb495d7f62mr213256366b.57.1748703286589; 
 Sat, 31 May 2025 07:54:46 -0700 (PDT)
Received: from panicking.amarulasolutions.com
 (mob-176-246-252-248.net.vodafone.it. [176.246.252.248])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d82ccedsm507715066b.48.2025.05.31.07.54.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 May 2025 07:54:45 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Simon.Holesch@bshg.com, linux-amarula@amarulasolutions.com,
 dario.binacchi@amarulasolutions.com, Sven.Dembianny@bshg.com,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>, Michael Bode <michael.bode@bshg.com>,
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Simon Holesch <simon.holesch@bshg.com>, Tom Rini <trini@konsulko.com>,
 Wolfgang Birkner <wolfgang.birkner@bshg.com>
Subject: [PATCH v3] bsh: imx6ulz_smm_m2: Add imx6ulz BSH SMM M2B board
Date: Sat, 31 May 2025 16:54:33 +0200
Message-ID: <20250531145441.908910-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
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

Introduce the BSH SystemMaster (SMM) M2B board. Notably, the M2B is
designed to leverage the existing device tree of its predecessor, the M2.
The primary distinction arises from memory incompatibilities with the M2.
To address this, we've implemented a configuration system that allows for
selective inclusion of the desired memory components.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>

---

Changes in v3:
- Fix typo in MAINTAINERS
- Pipeline https://dev.azure.com/u-boot/u-boot/_build/results?buildId=11274&view=results

Changes in v2:
- Ajust commit message and kconfig
- Add MAINTAINERS entry just for configuration file

 board/bsh/imx6ulz_smm_m2/Kconfig              |  21 +++
 board/bsh/imx6ulz_smm_m2/MAINTAINERS          |   1 +
 board/bsh/imx6ulz_smm_m2/Makefile             |   4 +-
 board/bsh/imx6ulz_smm_m2/ddr3l_timing_128m.c  |   1 +
 .../imx6ulz_smm_m2/ddr3l_timing_128m_m2b.c    | 152 ++++++++++++++++++
 board/bsh/imx6ulz_smm_m2/ddr3l_timing_256m.c  |   1 +
 .../imx6ulz_smm_m2/ddr3l_timing_256m_m2b.c    | 137 ++++++++++++++++
 board/bsh/imx6ulz_smm_m2/ddr3l_timing_512m.c  |   1 +
 board/bsh/imx6ulz_smm_m2/spl.c                |  37 +++--
 board/bsh/imx6ulz_smm_m2/spl_mtypes.h         |   1 +
 configs/imx6ulz_smm_m2b_defconfig             |  78 +++++++++
 11 files changed, 416 insertions(+), 18 deletions(-)
 create mode 100644 board/bsh/imx6ulz_smm_m2/ddr3l_timing_128m_m2b.c
 create mode 100644 board/bsh/imx6ulz_smm_m2/ddr3l_timing_256m_m2b.c
 create mode 100644 configs/imx6ulz_smm_m2b_defconfig

diff --git a/board/bsh/imx6ulz_smm_m2/Kconfig b/board/bsh/imx6ulz_smm_m2/Kconfig
index e38df7ce5cb..20971aa4fe1 100644
--- a/board/bsh/imx6ulz_smm_m2/Kconfig
+++ b/board/bsh/imx6ulz_smm_m2/Kconfig
@@ -9,4 +9,25 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "imx6ulz_smm_m2"
 
+choice
+	prompt "Memory Type (M2/M2B) board"
+	default BSH_M2_MEMORY
+	help
+	  Memory type setup.
+	  Please choose correct memory model here.
+
+config BSH_M2_MEMORY
+	bool "Enable for bsh m2 variant"
+	help
+	  If this option is enabled, U-Boot will be configured to support
+	  imx6ulz bsh m2 revision memories.
+
+config BSH_M2B_MEMORY
+	bool "Enable for bsh m2b variant"
+	help
+	  If this option is enabled, U-Boot will be configured to support
+	  imx6ulz bsh m2b revision memories.
+
+endchoice
+
 endif
diff --git a/board/bsh/imx6ulz_smm_m2/MAINTAINERS b/board/bsh/imx6ulz_smm_m2/MAINTAINERS
index 77a033c6cbb..a75cddd72f8 100644
--- a/board/bsh/imx6ulz_smm_m2/MAINTAINERS
+++ b/board/bsh/imx6ulz_smm_m2/MAINTAINERS
@@ -4,3 +4,4 @@ S:	Maintained
 F:	board/bsh/imx6ulz_smm_m2/
 F:	include/configs/imx6ulz_smm_m2.h
 F:	configs/imx6ulz_smm_m2_defconfig
+F:	configs/imx6ulz_smm_m2b_defconfig
diff --git a/board/bsh/imx6ulz_smm_m2/Makefile b/board/bsh/imx6ulz_smm_m2/Makefile
index 4f4d67f659d..233bbff4c16 100644
--- a/board/bsh/imx6ulz_smm_m2/Makefile
+++ b/board/bsh/imx6ulz_smm_m2/Makefile
@@ -2,4 +2,6 @@
 # (C) Copyright 2021 Amarula Solutions B.V.
 
 obj-y  := imx6ulz_smm_m2.o
-obj-$(CONFIG_XPL_BUILD) += spl.o ddr3l_timing_512m.o ddr3l_timing_256m.o ddr3l_timing_128m.o
+obj-$(CONFIG_XPL_BUILD) += spl.o
+obj-$(CONFIG_BSH_M2_MEMORY) += ddr3l_timing_512m.o ddr3l_timing_256m.o ddr3l_timing_128m.o
+obj-$(CONFIG_BSH_M2B_MEMORY) += ddr3l_timing_256m_m2b.o ddr3l_timing_128m_m2b.o
diff --git a/board/bsh/imx6ulz_smm_m2/ddr3l_timing_128m.c b/board/bsh/imx6ulz_smm_m2/ddr3l_timing_128m.c
index 66c3483adbf..f11654a8ceb 100644
--- a/board/bsh/imx6ulz_smm_m2/ddr3l_timing_128m.c
+++ b/board/bsh/imx6ulz_smm_m2/ddr3l_timing_128m.c
@@ -166,4 +166,5 @@ static const struct dram_cfg_param ddr_ddrc_cfg_128mb[] = {
 struct dram_timing_info bsh_dram_timing_128mb = {
 	.ddrc_cfg = ddr_ddrc_cfg_128mb,
 	.ddrc_cfg_num = ARRAY_SIZE(ddr_ddrc_cfg_128mb),
+	.dram_size = SZ_128M,
 };
diff --git a/board/bsh/imx6ulz_smm_m2/ddr3l_timing_128m_m2b.c b/board/bsh/imx6ulz_smm_m2/ddr3l_timing_128m_m2b.c
new file mode 100644
index 00000000000..f989e24f567
--- /dev/null
+++ b/board/bsh/imx6ulz_smm_m2/ddr3l_timing_128m_m2b.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "spl_mtypes.h"
+
+static const struct dram_cfg_param ddr_ddrc_cfg_128mb[] = {
+	/* IOMUX */
+
+	/* DDR IO Type: */
+	{0x020e04b4, 0x000C0000},	/* IOMUXC_SW_PAD_CTL_GRP_DDR_TYPE */
+	{0x020e04ac, 0x00000000},	/* IOMUXC_SW_PAD_CTL_GRP_DDRPKE */
+
+	/* Clock: */
+	{0x020e027c, 0x00000028},	/* IOMUXC_SW_PAD_CTL_PAD_DRAM_SDCLK_0 */
+
+	/* Address: */
+	{0x020e0250, 0x00000028},	/* IOMUXC_SW_PAD_CTL_PAD_DRAM_CAS */
+	{0x020e024c, 0x00000028},	/* IOMUXC_SW_PAD_CTL_PAD_DRAM_RAS */
+	{0x020e0490, 0x00000028},	/* IOMUXC_SW_PAD_CTL_GRP_ADDDS */
+
+	/* Control: */
+	{0x020e0288, 0x000C0028},	/* IOMUXC_SW_PAD_CTL_PAD_DRAM_RESET */
+	{0x020e0270, 0x00000000},	/*
+					 * IOMUXC_SW_PAD_CTL_PAD_DRAM_SDBA2 - DSE can be configured
+					 * using Group Control Register IOMUXC_SW_PAD_CTL_GRP_CTLDS
+					 */
+
+	{0x020e0260, 0x00000028},	/* IOMUXC_SW_PAD_CTL_PAD_DRAM_SDODT0 */
+	{0x020e0264, 0x00000028},	/* IOMUXC_SW_PAD_CTL_PAD_DRAM_SDODT1 */
+	{0x020e04a0, 0x00000028},	/* IOMUXC_SW_PAD_CTL_GRP_CTLDS */
+
+	/* Data Strobes: */
+	{0x020e0494, 0x00020000},	/* IOMUXC_SW_PAD_CTL_GRP_DDRMODE_CTL */
+	{0x020e0280, 0x00000028},	/* IOMUXC_SW_PAD_CTL_PAD_DRAM_SDQS0 */
+	{0x020e0284, 0x00000028},	/* IOMUXC_SW_PAD_CTL_PAD_DRAM_SDQS1 */
+
+	/* Data: */
+	{0x020e04b0, 0x00020000},	/* IOMUXC_SW_PAD_CTL_GRP_DDRMODE */
+	{0x020e0498, 0x00000028},	/* IOMUXC_SW_PAD_CTL_GRP_B0DS */
+	{0x020e04a4, 0x00000028},	/* IOMUXC_SW_PAD_CTL_GRP_B1DS */
+
+	{0x020e0244, 0x00000028},	/* IOMUXC_SW_PAD_CTL_PAD_DRAM_DQM0 */
+	{0x020e0248, 0x00000028},	/* IOMUXC_SW_PAD_CTL_PAD_DRAM_DQM1 */
+
+	/*
+	 * =============================================================================
+	 * DDR Controller Registers
+	 * =============================================================================
+	 * Manufacturer:WINBOND
+	 * Device Part Number:W631GU6RB-11
+	 * Clock Freq.: 400MHz
+	 * Density per CS in Gb: 1
+	 * Chip Selects used:1
+	 * Total DRAM density (Gb)1
+	 * Number of Banks:8
+	 * Row address:    13
+	 * Column address: 10
+	 * Data bus width16
+	 * =============================================================================
+	 */
+	{0x021b001c, 0x00008000},	/*
+					 * MMDC0_MDSCR, set the Configuration request bit
+					 * during MMDC set up
+					 */
+
+	/*
+	 * =============================================================================
+	 * Calibration setup.
+	 * =============================================================================
+	 */
+	{0x021b0800, 0xA1390003},	/*
+					 * DDR_PHY_P0_MPZQHWCTRL, enable both one-time & periodic
+					 * HW ZQ calibration.
+					 */
+
+	/*
+	 * For target board, may need to run write leveling calibration to fine tune
+	 * these settings.
+	 */
+	{0x021b080c, 0x00060002},
+
+	/* Read DQS Gating calibration */
+	{0x021b083c, 0x414c0150},	/* MPDGCTRL0 PHY0 */
+
+	/* Read calibration */
+	{0x021b0848, 0x4040363e},	/* MPRDDLCTL PHY0 */
+
+	/* Write calibration */
+	{0x021b0850, 0x40402a28},	/* MPWRDLCTL PHY0 */
+
+	/*
+	 * Read data bit delay: 3 is the recommended default value, although out of reset
+	 * value is 0.
+	 */
+	{0x021b081c, 0x33333333},	/* MMDC_MPRDDQBY0DL */
+	{0x021b0820, 0x33333333},	/* MMDC_MPRDDQBY1DL */
+
+	/* Write data bit delay: */
+	{0x021b082c, 0xf3333333},	/* MMDC_MPWRDQBY0DL */
+	{0x021b0830, 0xf3333333},	/* MMDC_MPWRDQBY1DL */
+
+	/* DQS&CLK Duty Cycle */
+	{0x021b08c0, 0x00944009},	/* [MMDC_MPDCCR] MMDC Duty Cycle Control Register */
+
+	/* Complete calibration by forced measurement: */
+	{0x021b08b8, 0x00000800},	/* DDR_PHY_P0_MPMUR0, frc_msr */
+
+	/* MMDC init: */
+	{0x021b0004, 0x0002002D},	/* MMDC0_MDPDC */
+	{0x021b0008, 0x1B333030},	/* MMDC0_MDOTC */
+	{0x021b000c, 0x2B2F52F3},	/* MMDC0_MDCFG0 */
+	{0x021b0010, 0xB66D0A63},	/* MMDC0_MDCFG1 */
+	{0x021b0014, 0x01FF00DB},	/* MMDC0_MDCFG2 */
+	{0x021b0018, 0x00201740},	/* MMDC0_MDMISC */
+	{0x021b002C, 0x000026D2},	/* MMDC0_MDRWD */
+	{0x021b0030, 0x002F1023},	/* MMDC0_MDOR */
+	{0x021b0040, 0x00000043},	/* CS0_END */
+	{0x021b0000, 0x82180000},	/* MMDC0_MDCTL */
+
+	/* Mode register writes for CS0 */
+	{0x021B001C, 0x02808032},	/* MMDC0_MDSCR, MR2 write, CS0 */
+	{0x021B001C, 0x00008033},	/* MMDC0_MDSCR, MR3 write, CS0 */
+	{0x021B001C, 0x00048031},	/* MMDC0_MDSCR, MR1 write, CS0 */
+	{0x021B001C, 0x15208030},	/* MMDC0_MDSCR, MR0 write, CS0 */
+	{0x021B001C, 0x04008040},	/*
+					 * MMDC0_MDSCR, ZQ calibration
+					 * command sent to device on CS0
+					 */
+
+	/* final DDR setup, before operation start: */
+	{0x021b0020, 0x00000800},	/* MMDC0_MDREF */
+
+	{0x021b0818, 0x00000227},	/* DDR_PHY_P0_MPODTCTRL */
+
+	{0x021b0004, 0x0002556D},	/* MMDC0_MDPDC now SDCTL power down enabled */
+
+	{0x021b0404, 0x00011006},	/*
+					 * MMDC0_MAPSR ADOPT power down enabled,
+					 * MMDC will enter automatically to self-refresh
+					 * while the number of idle cycle reached.
+					 */
+
+	{0x021b001c, 0x00000000},	/*
+					 * MMDC0_MDSCR, clear this register (especially the
+					 * configuration bit as initialization is complete)
+					 */
+};
+
+struct dram_timing_info bsh_dram_timing_128mb = {
+	.ddrc_cfg = ddr_ddrc_cfg_128mb,
+	.ddrc_cfg_num = ARRAY_SIZE(ddr_ddrc_cfg_128mb),
+	.dram_size = SZ_128M,
+};
diff --git a/board/bsh/imx6ulz_smm_m2/ddr3l_timing_256m.c b/board/bsh/imx6ulz_smm_m2/ddr3l_timing_256m.c
index 0fe5b90a673..5dfc9f5c70d 100644
--- a/board/bsh/imx6ulz_smm_m2/ddr3l_timing_256m.c
+++ b/board/bsh/imx6ulz_smm_m2/ddr3l_timing_256m.c
@@ -165,4 +165,5 @@ static const struct dram_cfg_param ddr_ddrc_cfg_256mb[] = {
 struct dram_timing_info bsh_dram_timing_256mb = {
 	.ddrc_cfg = ddr_ddrc_cfg_256mb,
 	.ddrc_cfg_num = ARRAY_SIZE(ddr_ddrc_cfg_256mb),
+	.dram_size = SZ_256M,
 };
diff --git a/board/bsh/imx6ulz_smm_m2/ddr3l_timing_256m_m2b.c b/board/bsh/imx6ulz_smm_m2/ddr3l_timing_256m_m2b.c
new file mode 100644
index 00000000000..c44f632b928
--- /dev/null
+++ b/board/bsh/imx6ulz_smm_m2/ddr3l_timing_256m_m2b.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "spl_mtypes.h"
+
+static const struct dram_cfg_param ddr_ddrc_cfg_256mb[] = {
+	/* IOMUX */
+
+	/* DDR IO Type: */
+	{0x020e04b4, 0x000C0000},	/* IOMUXC_SW_PAD_CTL_GRP_DDR_TYPE */
+	{0x020e04ac, 0x00000000},	/* IOMUXC_SW_PAD_CTL_GRP_DDRPKE */
+
+	/* Clock: */
+	{0x020e027c, 0x00000030},	/* IOMUXC_SW_PAD_CTL_PAD_DRAM_SDCLK0_P */
+
+	/* Address: */
+	{0x020e0250, 0x00000030},	/* IOMUXC_SW_PAD_CTL_PAD_DRAM_CAS */
+	{0x020e024c, 0x00000030},	/* IOMUXC_SW_PAD_CTL_PAD_DRAM_RAS */
+	{0x020e0490, 0x00000030},	/* IOMUXC_SW_PAD_CTL_GRP_ADDDS */
+
+	/* Control: */
+	{0x020e0288, 0x000C0030},	/* IOMUXC_SW_PAD_CTL_PAD_DRAM_RESET */
+	{0x020e0270, 0x00000000},	/*
+					 * IOMUXC_SW_PAD_CTL_PAD_DRAM_SDBA2 - DSE can be
+					 * configured using Group Control Register:
+					 * IOMUXC_SW_PAD_CTL_GRP_CTLDS
+					 */
+
+	{0x020e0260, 0x00000030},	/* IOMUXC_SW_PAD_CTL_PAD_DRAM_ODT0 */
+	{0x020e0264, 0x00000030},	/* IOMUXC_SW_PAD_CTL_PAD_DRAM_ODT1 */
+	{0x020e04a0, 0x00000028},	/* IOMUXC_SW_PAD_CTL_GRP_CTLDS */
+
+	/* Data Strobes: */
+	{0x020e0494, 0x00020000},	/* IOMUXC_SW_PAD_CTL_GRP_DDRMODE_CTL */
+	{0x020e0280, 0x00000030},	/* IOMUXC_SW_PAD_CTL_PAD_DRAM_SDQS0_P */
+	{0x020e0284, 0x00000030},	/* IOMUXC_SW_PAD_CTL_PAD_DRAM_SDQS1_P */
+
+	/* Data: */
+	{0x020e04b0, 0x00020000},	/* IOMUXC_SW_PAD_CTL_GRP_DDRMODE */
+	{0x020e0498, 0x00000030},	/* IOMUXC_SW_PAD_CTL_GRP_B0DS */
+	{0x020e04a4, 0x00000030},	/* IOMUXC_SW_PAD_CTL_GRP_B1DS */
+
+	{0x020e0244, 0x00000030},	/* IOMUXC_SW_PAD_CTL_PAD_DRAM_DQM0 */
+	{0x020e0248, 0x00000030},	/* IOMUXC_SW_PAD_CTL_PAD_DRAM_DQM1 */
+
+	/*
+	 * =============================================================================
+	 * DDR Controller Registers
+	 * =============================================================================
+	 * Manufacturer:WINBOND
+	 * Device Part Number:W632GU6RB-11
+	 * Clock Freq.: 400MHz
+	 * Density per CS in Gb: 2
+	 * Chip Selects used:1
+	 * Total DRAM density (Gb)2
+	 * Number of Banks:8
+	 * Row address:    14
+	 * Column address: 10
+	 * Data bus width16
+	 * =============================================================================
+	 */
+	{0x021b001c, 0x00008000},	/*
+					 * MMDC0_MDSCR, set the Configuration request bit
+					 * during MMDC set up
+					 */
+
+	/*
+	 * =============================================================================
+	 * Calibration setup.
+	 * =============================================================================
+	 */
+	{0x021b0800, 0xA1390003},	/*
+					 * DDR_PHY_P0_MPZQHWCTRL, enable both one-time & periodic
+					 * HW ZQ calibration.
+					 */
+
+	/*
+	 * For target board, may need to run write leveling calibration to fine tune
+	 * these settings.
+	 */
+	{0x021b080c, 0x00070005},
+
+	/* Read DQS Gating calibration */
+	{0x021b083c, 0x414c0150},	/* MPDGCTRL0 PHY0 */
+
+	/* Read calibration */
+	{0x021b0848, 0x4040383e},	/* MMDC_MPRDDLCTL */
+
+	/* Write calibration */
+	{0x021b0850, 0x40402e2a},	/* MMDC_MPWRDLCTL */
+
+	{0x021B081C, 0x33333333},	/* MMDC_MPRDDQBY0DL */
+	{0x021B0820, 0x33333333},	/* MMDC_MPRDDQBY1DL */
+
+	{0x021B082C, 0xf3333333},	/* MMDC_MPWRDQBY0DL */
+	{0x021B0830, 0xf3333333},	/* MMDC_MPWRDQBY1DL */
+
+	{0x021B08C0, 0x00944009},	/* MMDC_MPDCCR */
+
+	/* Complete calibration by forced measurement: */
+	{0x021B08B8, 0x00000800},	/* DDR_PHY_P0_MPMUR0, frc_msr */
+
+	/* MMDC init: */
+	{0x021b0004, 0x00020024},	/* MMDC0_MDPDC */
+	{0x021b0008, 0x1B333030},	/* MMDC0_MDOTC */
+	{0x021b000c, 0x3F4352D3},	/* MMDC0_MDCFG0 */
+	{0x021b0010, 0xB66D0A63},	/* MMDC0_MDCFG1 */
+	{0x021b0014, 0x01FF00DB},	/* MMDC0_MDCFG2 */
+	{0x021b0018, 0x00201740},	/* MMDC0_MDMISC */
+	{0x021b002C, 0x000026D2},	/* MMDC0_MDRWD */
+	{0x021b0030, 0x00431023},	/* MMDC0_MDOR */
+	{0x021b0040, 0x00000047},	/* CS0_END */
+	{0x021b0000, 0x83180000},	/* MMDC0_MDCTL */
+
+	/* Mode register writes for CS0 */
+	{0x021B001C, 0x02808032},	/* MMDC0_MDSCR, MR2 write, CS0 */
+	{0x021B001C, 0x00008033},	/* MMDC0_MDSCR, MR3 write, CS0 */
+	{0x021B001C, 0x00048031},	/* MMDC0_MDSCR, MR1 write, CS0 */
+	{0x021B001C, 0x15208030},	/* MMDC0_MDSCR, MR0 write, CS0 */
+	{0x021B001C, 0x04008040},	/* MMDC0_MDSCR, ZQ calibration */
+
+	/* final DDR setup, before operation start: */
+	{0x021b0020, 0x00000800},	/* MMDC0_MDREF */
+
+	{0x021b0818, 0x00000227},	/* DDR_PHY_P0_MPODTCTRL */
+	{0x021b0004, 0x00025564},	/* MMDC0_MDPDC now SDCTL power down enabled */
+	{0x021b0404, 0x00011006},	/* MMDC0_MAPSR ADOPT power down enabled */
+	{0x021b001c, 0x00000000},	/*
+					 * MMDC0_MDSCR, clear this register (especially
+					 * the configuration bit as initialization is complete)
+					 */
+};
+
+struct dram_timing_info bsh_dram_timing_256mb = {
+	.ddrc_cfg = ddr_ddrc_cfg_256mb,
+	.ddrc_cfg_num = ARRAY_SIZE(ddr_ddrc_cfg_256mb),
+	.dram_size = SZ_256M,
+};
diff --git a/board/bsh/imx6ulz_smm_m2/ddr3l_timing_512m.c b/board/bsh/imx6ulz_smm_m2/ddr3l_timing_512m.c
index f5989382f5a..4c2ffcd429d 100644
--- a/board/bsh/imx6ulz_smm_m2/ddr3l_timing_512m.c
+++ b/board/bsh/imx6ulz_smm_m2/ddr3l_timing_512m.c
@@ -165,4 +165,5 @@ static const struct dram_cfg_param ddr_ddrc_cfg_512mb[] = {
 struct dram_timing_info bsh_dram_timing_512mb = {
 	.ddrc_cfg = ddr_ddrc_cfg_512mb,
 	.ddrc_cfg_num = ARRAY_SIZE(ddr_ddrc_cfg_512mb),
+	.dram_size = SZ_512M,
 };
diff --git a/board/bsh/imx6ulz_smm_m2/spl.c b/board/bsh/imx6ulz_smm_m2/spl.c
index c330e4d6d39..7aea73f0f5d 100644
--- a/board/bsh/imx6ulz_smm_m2/spl.c
+++ b/board/bsh/imx6ulz_smm_m2/spl.c
@@ -52,28 +52,31 @@ static void ddr_cfg_write(const struct dram_timing_info *dram_timing_info)
 	}
 }
 
+static const struct dram_timing_info *board_dram_timing[] = {
+#if defined(CONFIG_M2_MEMORY)
+	&bsh_dram_timing_512mb,
+#endif
+	&bsh_dram_timing_256mb,
+	&bsh_dram_timing_128mb,
+};
+
 static void spl_dram_init(void)
 {
 	/* Configure memory to maximum supported size for detection */
-	ddr_cfg_write(&bsh_dram_timing_512mb);
+	ddr_cfg_write(board_dram_timing[0]);
 
 	/* Detect memory physically present */
-	gd->ram_size = get_ram_size((void *)CFG_SYS_SDRAM_BASE, SZ_512M);
-
-	/* Reconfigure memory for actual detected size */
-	switch (gd->ram_size) {
-	case SZ_512M:
-		/* Already configured, nothing to do */
-		break;
-	case SZ_256M:
-		udelay(1);
-		ddr_cfg_write(&bsh_dram_timing_256mb);
-		break;
-	case SZ_128M:
-	default:
-		udelay(1);
-		ddr_cfg_write(&bsh_dram_timing_128mb);
-		break;
+	gd->ram_size = get_ram_size((void *)CFG_SYS_SDRAM_BASE, board_dram_timing[0]->dram_size);
+
+	if (board_dram_timing[0]->dram_size == gd->ram_size)
+		return;
+
+	for (size_t index = 1; index < ARRAY_SIZE(board_dram_timing); index++) {
+		if (board_dram_timing[index]->dram_size == gd->ram_size) {
+			udelay(1);
+			ddr_cfg_write(board_dram_timing[index]);
+			break;
+		}
 	}
 }
 
diff --git a/board/bsh/imx6ulz_smm_m2/spl_mtypes.h b/board/bsh/imx6ulz_smm_m2/spl_mtypes.h
index 8da59881c83..06d6f2d76d8 100644
--- a/board/bsh/imx6ulz_smm_m2/spl_mtypes.h
+++ b/board/bsh/imx6ulz_smm_m2/spl_mtypes.h
@@ -18,6 +18,7 @@ struct dram_cfg_param {
 struct dram_timing_info {
 	const struct dram_cfg_param *ddrc_cfg;
 	unsigned int ddrc_cfg_num;
+	size_t dram_size;
 };
 
 extern struct dram_timing_info bsh_dram_timing_128mb;
diff --git a/configs/imx6ulz_smm_m2b_defconfig b/configs/imx6ulz_smm_m2b_defconfig
new file mode 100644
index 00000000000..c9e66adde98
--- /dev/null
+++ b/configs/imx6ulz_smm_m2b_defconfig
@@ -0,0 +1,78 @@
+CONFIG_ARM=y
+CONFIG_ARCH_MX6=y
+CONFIG_TEXT_BASE=0x87800000
+CONFIG_SYS_MALLOC_LEN=0x1000000
+CONFIG_SYS_MALLOC_F_LEN=0x18000
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_ENV_SIZE=0x20000
+CONFIG_ENV_OFFSET=0x400000
+CONFIG_MX6ULL=y
+CONFIG_TARGET_MX6ULZ_SMM_M2=y
+CONFIG_BSH_M2B_MEMORY=y
+CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6ulz-bsh-smm-m2"
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_BSS_START_ADDR=0x84100000
+CONFIG_SPL=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTDELAY=3
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_DMA=y
+CONFIG_SPL_MTD=y
+CONFIG_SPL_NAND_SUPPORT=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_SDP=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_MTDPARTS=y
+CONFIG_MTDIDS_DEFAULT="nand0=gpmi-nand"
+CONFIG_MTDPARTS_DEFAULT="mtdparts=gpmi-nand:4m(nandboot),1m(env),8m(kernel),1m(nanddtb),-(rootfs)"
+CONFIG_CMD_UBI=y
+# CONFIG_ISO_PARTITION is not set
+CONFIG_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_NAND=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_NO_NET=y
+CONFIG_BOUNCE_BUFFER=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x82000000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_UUU_SUPPORT=y
+CONFIG_SYS_I2C_MXC=y
+# CONFIG_MMC is not set
+CONFIG_MTD=y
+CONFIG_MTD_RAW_NAND=y
+CONFIG_SYS_NAND_USE_FLASH_BBT=y
+CONFIG_NAND_MXS=y
+CONFIG_NAND_MXS_DT=y
+CONFIG_SYS_NAND_ONFI_DETECTION=y
+CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
+CONFIG_SYS_NAND_U_BOOT_OFFS=0x111400
+CONFIG_SYS_NAND_U_BOOT_OFFS_REDUND=0x291400
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_IMX6=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_MXC_UART=y
+CONFIG_IMX_THERMAL=y
+CONFIG_USB=y
+CONFIG_SPL_USB_HOST=y
+CONFIG_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="BSH"
+CONFIG_USB_GADGET_VENDOR_NUM=0x0525
+CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
+CONFIG_CI_UDC=y
+CONFIG_SDP_LOADADDR=0x877fffc0
+CONFIG_SPL_USB_SDP_SUPPORT=y
-- 
2.43.0

base-commit: e5990b6f46717bc684672032fe4fb9d7d8bfa278
branch: series
