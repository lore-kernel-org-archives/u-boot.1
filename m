Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8510C54E65
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 15:07:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3307982CF4;
	Tue, 20 May 2025 17:07:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KDLf4Nzc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7230182A8D; Tue, 20 May 2025 17:07:18 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF86982C87
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 17:07:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a36c2d3104so1667940f8f.1
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 08:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1747753635; x=1748358435;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6pfUTtAHhEmjHhzlv4fvFPcPlxehN1XDXiMNtRG2hmc=;
 b=KDLf4Nzc+NJrdhgKRjTbNdSxlr+1nTs9BzN9Jdq45b/neiaoosjUUaQpfrlpQGW4HC
 7Pa3GUz/20JeacN59MthmJWRyZOI+WVutrpag19OkZrMp+AUaIkVS35vgIpO+wR87xIc
 eUesawOaUXKyL8bR+DbpEgcX4WfI6uP5tAWvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747753635; x=1748358435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6pfUTtAHhEmjHhzlv4fvFPcPlxehN1XDXiMNtRG2hmc=;
 b=B9WDb0Rg2rwKaQdJRCxDk4M2/5+G+qZhLgt8zjWS+lhKmJllk+PL4vmWA4k0ftn0Ab
 J7/Xz9LBqzDYbVFnirlRpUogpD+28yt+CoC9jkCdonG2oyJS8ra4Mig/fnowgz+35p1N
 hckNCWwGDnObFnsCrCnQ9foZlMU43xK3BuNjS41PQeF123AVVKPNrHpL5tXwt+nXUzZf
 K1oMhE4ses+8oxk3Jij5DySYvZQtbhXqPyee0+dFUI2i0lji2LEyH2lXjUH8P9e9ge6G
 +asEl66hXrfB+zz1q8HvyOTvvIL98hPlX1q3D+20yfo1h87n5v7bCO5JG25iAsyU9uQL
 Q4Yw==
X-Gm-Message-State: AOJu0YzgvnVr9JoBcyx4bxjx1Lx4FbyifBe/yP4lvA55D3VKhgrsliUQ
 KgYmC7X392hE5Lglfg3rtHrMlLP2ciCNzG+5wZY8Hr4HJT82VRA1OCwDbemTWeCIPwGXTm85YeX
 v12pk
X-Gm-Gg: ASbGncsdKPfBGf3H1IUn3FD0uXGFanpA/+wjbxoF75E51fYpPBZYgyeWcYLAHUyTIm5
 ffnbozOpJqKa720KVxF3yr+7zY7PtxLkz6CQv1ohajHGnadzblcQHwmLfMiQSnb6z0R3QfULnrn
 YXhWrBuwapw+13+L8BznS0z6uX/1hJWXceNX4sxOTC8EuWAUYoYaqqyYdgGclDhtGqaJOe4hBBR
 Kksi5szQ6HawYySolIsykx5dpT6cKS3sJJCUhryVY+bNta95FFPavDA9mYCVYFajt77JlBjpfPr
 NCIJE6f9KnxdRF9EE6EorQs/eu1EKZtCE/tD0PSM4H+x+wa7h8OiVvXcol2+5IJ9cSyMVqBEEJM
 owW76GodL3x0Mbo36cIykKHncJcTSE+JIy5cMazV8
X-Google-Smtp-Source: AGHT+IEAFP+0p6viiBjygixAQgiLiaVJpI4b5Upy+5s5ktazwuordKbyY6PHrBiF24+uerfh00OsvQ==
X-Received: by 2002:a05:6000:1847:b0:3a3:69fe:f55a with SMTP id
 ffacd0b85a97d-3a369fef7bamr10512333f8f.51.1747753634689; 
 Tue, 20 May 2025 08:07:14 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2.196.40.47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35e49262fsm16179766f8f.44.2025.05.20.08.07.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 08:07:14 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Bode <michael.bode@bshg.com>, linux-amarula@amarulasolutions.com,
 Simon Holesch <simon.holesch@bshg.com>, michael@amarulasolutions.com,
 Wolfgang Birkner <wolfgang.birkner@bshg.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/4] board: bsh: imx6ulz_smm_m2: Add support for 256 MiB
 DRAM
Date: Tue, 20 May 2025 17:07:00 +0200
Message-ID: <20250520150709.988904-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520150709.988904-1-dario.binacchi@amarulasolutions.com>
References: <20250520150709.988904-1-dario.binacchi@amarulasolutions.com>
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

From: Simon Holesch <simon.holesch@bshg.com>

Calibration values were calculated using the NXP tool
I.MX6ULL_DDR3_Script_Aid_V0.01.xlsx

Signed-off-by: Wolfgang Birkner <wolfgang.birkner@bshg.com>
Signed-off-by: Simon Holesch <simon.holesch@bshg.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Use standard C comment style

 board/bsh/imx6ulz_smm_m2/Makefile            |   2 +-
 board/bsh/imx6ulz_smm_m2/ddr3l_timing_128m.c | 169 +++++++++++++++
 board/bsh/imx6ulz_smm_m2/ddr3l_timing_256m.c | 168 +++++++++++++++
 board/bsh/imx6ulz_smm_m2/spl.c               | 207 ++-----------------
 board/bsh/imx6ulz_smm_m2/spl_mtypes.h        |  26 +++
 include/configs/imx6ulz_smm_m2.h             |   6 +-
 6 files changed, 388 insertions(+), 190 deletions(-)
 create mode 100644 board/bsh/imx6ulz_smm_m2/ddr3l_timing_128m.c
 create mode 100644 board/bsh/imx6ulz_smm_m2/ddr3l_timing_256m.c
 create mode 100644 board/bsh/imx6ulz_smm_m2/spl_mtypes.h

diff --git a/board/bsh/imx6ulz_smm_m2/Makefile b/board/bsh/imx6ulz_smm_m2/Makefile
index 59870419bdde..d448f4fc5215 100644
--- a/board/bsh/imx6ulz_smm_m2/Makefile
+++ b/board/bsh/imx6ulz_smm_m2/Makefile
@@ -2,5 +2,5 @@
 # (C) Copyright 2021 Amarula Solutions B.V.
 
 obj-y  := imx6ulz_smm_m2.o
-obj-$(CONFIG_XPL_BUILD) += spl.o
+obj-$(CONFIG_XPL_BUILD) += spl.o ddr3l_timing_256m.o ddr3l_timing_128m.o
 
diff --git a/board/bsh/imx6ulz_smm_m2/ddr3l_timing_128m.c b/board/bsh/imx6ulz_smm_m2/ddr3l_timing_128m.c
new file mode 100644
index 000000000000..66c3483adbf5
--- /dev/null
+++ b/board/bsh/imx6ulz_smm_m2/ddr3l_timing_128m.c
@@ -0,0 +1,169 @@
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
+	 * Manufacturer:ISSI
+	 * Device Part Number:IS43TR16640BL-125JBLI
+	 * Clock Freq.: 400MHz
+	 * Density per CS in Gb: 1
+	 * Chip Selects used:1
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
+	{0x021b080c, 0x00000000},
+
+	/* Read DQS Gating calibration */
+	{0x021b083c, 0x41480148},	/* MPDGCTRL0 PHY0 */
+
+	/* Read calibration */
+	{0x021b0848, 0x40403A3E},	/* MPRDDLCTL PHY0 */
+
+	/* Write calibration */
+	{0x021b0850, 0x4040362E},	/* MPWRDLCTL PHY0 */
+
+	/*
+	 * Read data bit delay: 3 is the recommended default value, although out of reset
+	 * value is 0.
+	 */
+	{0x021b081c, 0x33333333},	/* MMDC_MPRDDQBY0DL */
+	{0x021b0820, 0x33333333},	/* MMDC_MPRDDQBY1DL */
+
+	/* Write data bit delay: */
+	{0x021b082c, 0xF3333333},	/* MMDC_MPWRDQBY0DL */
+	{0x021b0830, 0xF3333333},	/* MMDC_MPWRDQBY1DL */
+
+	/* DQS&CLK Duty Cycle */
+	{0x021b08c0, 0x00944009},	/* [MMDC_MPDCCR] MMDC Duty Cycle Control Register */
+
+	/* Complete calibration by forced measurement: */
+	{0x021b08b8, 0x00000800},	/* DDR_PHY_P0_MPMUR0, frc_msr */
+
+	/*
+	 * =============================================================================
+	 * Calibration setup end
+	 * =============================================================================
+	 */
+
+	/* MMDC init: */
+	{0x021b0004, 0x0002002D},	/* MMDC0_MDPDC */
+	{0x021b0008, 0x1B333030},	/* MMDC0_MDOTC */
+	{0x021b000c, 0x2B2F52F3},	/* MMDC0_MDCFG0 */
+	{0x021b0010, 0xB66D0B63},	/* MMDC0_MDCFG1 */
+	{0x021b0014, 0x01FF00DB},	/* MMDC0_MDCFG2 */
+
+	/*
+	 * MDMISC: RALAT kept to the high level of 5.
+	 * MDMISC: consider reducing RALAT if your 528MHz board design allow that.
+	 * Lower RALAT benefits:
+	 * a. better operation at low frequency, for LPDDR2 freq < 100MHz, change RALAT to 3
+	 * b. Small performance improvement
+	 */
+	{0x021b0018, 0x00211740},	/* MMDC0_MDMISC */
+	{0x021b001c, 0x00008000},	/*
+					 * MMDC0_MDSCR, set the Configuration request bit during
+					 * MMDC set up
+					 */
+	{0x021b002c, 0x000026D2},	/* MMDC0_MDRWD */
+	{0x021b0030, 0x002F1023},	/* MMDC0_MDOR */
+	{0x021b0040, 0x00000043},	/* Chan0 CS0_END */
+	{0x021b0000, 0x82180000},	/* MMDC0_MDCTL */
+
+	{0x021b0890, 0x00400000},	/* MPPDCMPR2 */
+
+	/* Mode register writes */
+	{0x021b001c, 0x02808032},	/* MMDC0_MDSCR, MR2 write, CS0 */
+	{0x021b001c, 0x00008033},	/* MMDC0_MDSCR, MR3 write, CS0 */
+	{0x021b001c, 0x00048031},	/* MMDC0_MDSCR, MR1 write, CS0 */
+	{0x021b001c, 0x15208030},	/* MMDC0_MDSCR, MR0write, CS0 */
+	{0x021b001c, 0x04008040},	/*
+					 * MMDC0_MDSCR, ZQ calibration command sent to device
+					 * on CS0
+					 */
+
+	{0x021b0020, 0x00007800},	/* MMDC0_MDREF */
+
+	{0x021b0818, 0x00000227},	/* DDR_PHY_P0_MPODTCTRL */
+
+	{0x021b0004, 0x0002552D},	/* MMDC0_MDPDC now SDCTL power down enabled */
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
+};
diff --git a/board/bsh/imx6ulz_smm_m2/ddr3l_timing_256m.c b/board/bsh/imx6ulz_smm_m2/ddr3l_timing_256m.c
new file mode 100644
index 000000000000..0fe5b90a6732
--- /dev/null
+++ b/board/bsh/imx6ulz_smm_m2/ddr3l_timing_256m.c
@@ -0,0 +1,168 @@
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
+					 * using Group Control Register: IOMUXC_SW_PAD_CTL_GRP_CTLDS
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
+	 * Manufacturer:ISSI
+	 * Device Part Number:IS43TR16640BL-125JBLI
+	 * Clock Freq.: 400MHz
+	 * Density per CS in Gb: 2
+	 * Chip Selects used:1
+	 * Number of Banks:8
+	 * Row address:    14
+	 * Column address: 10
+	 * Data bus width16
+	 * =============================================================================
+	 */
+	{0x021b001c, 0x00008000},	/*
+					 * MMDC0_MDSCR, set the Configuration request bit during
+					 * MMDC set up
+					 */
+
+	/*
+	 * =============================================================================
+	 * Calibration setup.
+	 * =============================================================================
+	 */
+	{0x021b0800, 0xA1390003},	/*
+					 * DDR_PHY_P0_MPZQHWCTRL, enable both one-time & periodic
+					 * HW ZQ calibration
+					 */
+
+	/*
+	 * For target board, may need to run write leveling calibration to fine tune these settings
+	 */
+	{0x021b080c, 0x00050005},
+
+	/* Read DQS Gating calibration */
+	{0x021b083c, 0x01480144},	/* MPDGCTRL0 PHY0 */
+
+	/* Read calibration */
+	{0x021b0848, 0x4040363A},	/* MPRDDLCTL PHY0 */
+
+	/* Write calibration */
+	{0x021b0850, 0x40402E2C},	/* MPWRDLCTL PHY0 */
+
+	/*
+	 * Read data bit delay: 3 is the reccommended default value, although out of reset value
+	 * is 0
+	 */
+	{0x021b081c, 0x33333333},	/* MMDC_MPRDDQBY0DL */
+	{0x021b0820, 0x33333333},	/* MMDC_MPRDDQBY1DL */
+
+	/* Write data bit delay: */
+	{0x021b082c, 0xF3333333},	/* MMDC_MPWRDQBY0DL */
+	{0x021b0830, 0xF3333333},	/* MMDC_MPWRDQBY1DL */
+
+	/* DQS&CLK Duty Cycle */
+	{0x021b08c0, 0x00944009},	/* [MMDC_MPDCCR] MMDC Duty Cycle Control Register */
+
+	/* Complete calibration by forced measurement: */
+	{0x021b08b8, 0x00000800},	/* DDR_PHY_P0_MPMUR0, frc_msr */
+
+	/*
+	 * =============================================================================
+	 * Calibration setup end
+	 * =============================================================================
+	 */
+
+	/* MMDC init: */
+	{0x021b0004, 0x0002002D},	/* MMDC0_MDPDC */
+	{0x021b0008, 0x1B333030},	/* MMDC0_MDOTC */
+	{0x021b000c, 0x3F435333},	/* MMDC0_MDCFG0 */
+	{0x021b0010, 0xB68E0B63},	/* MMDC0_MDCFG1 */
+	{0x021b0014, 0x01FF00DB},	/* MMDC0_MDCFG2 */
+
+	/*
+	 * MDMISC: RALAT kept to the high level of 5.
+	 * MDMISC: consider reducing RALAT if your 528MHz board design allow that.
+	 * Lower RALAT benefits:
+	 * a. better operation at low frequency, for LPDDR2 freq < 100MHz, change RALAT to 3
+	 * b. Small performence improvment
+	 */
+	{0x021b0018, 0x00211740},	/* MMDC0_MDMISC */
+	{0x021b001c, 0x00008000},	/*
+					 * MMDC0_MDSCR, set the Configuration request bit during
+					 * MMDC set up
+					 */
+	{0x021b002c, 0x000026D2},	/* MMDC0_MDRWD */
+	{0x021b0030, 0x00431023},	/* MMDC0_MDOR */
+	{0x021b0040, 0x00000047},	/* Chan0 CS0_END */
+	{0x021b0000, 0x83180000},	/* MMDC0_MDCTL */
+
+	{0x021b0890, 0x00400000},	/* MPPDCMPR2 */
+
+	/* Mode register writes */
+	{0x021b001c, 0x02808032},	/* MMDC0_MDSCR, MR2 write, CS0 */
+	{0x021b001c, 0x00008033},	/* MMDC0_MDSCR, MR3 write, CS0 */
+	{0x021b001c, 0x00048031},	/* MMDC0_MDSCR, MR1 write, CS0 */
+	{0x021b001c, 0x15208030},	/* MMDC0_MDSCR, MR0write, CS0 */
+	{0x021b001c, 0x04008040},	/*
+					 * MMDC0_MDSCR, ZQ calibration command sent to device
+					 * on CS0
+					 */
+
+	{0x021b0020, 0x00007800},	/* MMDC0_MDREF */
+
+	{0x021b0818, 0x00000227},	/* DDR_PHY_P0_MPODTCTRL */
+
+	{0x021b0004, 0x0002552D},	/* MMDC0_MDPDC now SDCTL power down enabled */
+
+	{0x021b0404, 0x00011006},	/*
+					 * MMDC0_MAPSR ADOPT power down enabled, MMDC will enter
+					 * automatically to self-refresh while the number of idle
+					 * cycle reached
+					 */
+
+	{0x021b001c, 0x00000000},	/*
+					 * MMDC0_MDSCR, clear this register (especially the
+					 * configuration bit as initialization is complete)
+					 */
+};
+
+struct dram_timing_info bsh_dram_timing_256mb = {
+	.ddrc_cfg = ddr_ddrc_cfg_256mb,
+	.ddrc_cfg_num = ARRAY_SIZE(ddr_ddrc_cfg_256mb),
+};
diff --git a/board/bsh/imx6ulz_smm_m2/spl.c b/board/bsh/imx6ulz_smm_m2/spl.c
index 936e54662e98..85fd9e133eb3 100644
--- a/board/bsh/imx6ulz_smm_m2/spl.c
+++ b/board/bsh/imx6ulz_smm_m2/spl.c
@@ -17,6 +17,8 @@
 #include <spl.h>
 #include <asm/arch/mx6-ddr.h>
 
+#include "spl_mtypes.h"
+
 #define UART_PAD_CTRL (PAD_CTL_PKE | PAD_CTL_PUE | \
 		       PAD_CTL_PUS_100K_UP | PAD_CTL_SPEED_MED | \
 		       PAD_CTL_DSE_40ohm | PAD_CTL_SRE_FAST | PAD_CTL_HYS)
@@ -31,190 +33,15 @@ static void setup_iomux_uart(void)
 	imx_iomux_v3_setup_multiple_pads(uart4_pads, ARRAY_SIZE(uart4_pads));
 }
 
-struct dram_cfg_param {
-	unsigned int reg;
-	unsigned int val;
-};
-
-struct dram_timing_info {
-	const struct dram_cfg_param *ddrc_cfg;
-	unsigned int ddrc_cfg_num;
-};
-
-static const struct dram_cfg_param ddr_ddrc_cfg_128mb[] = {
-	/* IOMUX */
-
-	/* DDR IO Type: */
-	{0x020e04b4, 0x000C0000},	/* IOMUXC_SW_PAD_CTL_GRP_DDR_TYPE */
-	{0x020e04ac, 0x00000000},	/* IOMUXC_SW_PAD_CTL_GRP_DDRPKE */
-
-	/* Clock: */
-	{0x020e027c, 0x00000028},	/* IOMUXC_SW_PAD_CTL_PAD_DRAM_SDCLK_0 */
-
-	/* Address: */
-	{0x020e0250, 0x00000028},	/* IOMUXC_SW_PAD_CTL_PAD_DRAM_CAS */
-	{0x020e024c, 0x00000028},	/* IOMUXC_SW_PAD_CTL_PAD_DRAM_RAS */
-	{0x020e0490, 0x00000028},	/* IOMUXC_SW_PAD_CTL_GRP_ADDDS */
-
-	/* Control: */
-	{0x020e0288, 0x000C0028},	/* IOMUXC_SW_PAD_CTL_PAD_DRAM_RESET */
-
-	{0x020e0270, 0x00000000},	/*
-					 * IOMUXC_SW_PAD_CTL_PAD_DRAM_SDBA2 - DSE can be configured
-					 * using Group Control Register: IOMUXC_SW_PAD_CTL_GRP_CTLDS
-					 */
-
-	{0x020e0260, 0x00000028},	/* IOMUXC_SW_PAD_CTL_PAD_DRAM_SDODT0 */
-	{0x020e0264, 0x00000028},	/* IOMUXC_SW_PAD_CTL_PAD_DRAM_SDODT1 */
-	{0x020e04a0, 0x00000028},	/* IOMUXC_SW_PAD_CTL_GRP_CTLDS */
-
-	/* Data Strobes: */
-	{0x020e0494, 0x00020000},	/* IOMUXC_SW_PAD_CTL_GRP_DDRMODE_CTL */
-	{0x020e0280, 0x00000028},	/* IOMUXC_SW_PAD_CTL_PAD_DRAM_SDQS0 */
-	{0x020e0284, 0x00000028},	/* IOMUXC_SW_PAD_CTL_PAD_DRAM_SDQS1 */
-
-	/* Data: */
-	{0x020e04b0, 0x00020000},	/* IOMUXC_SW_PAD_CTL_GRP_DDRMODE */
-	{0x020e0498, 0x00000028},	/* IOMUXC_SW_PAD_CTL_GRP_B0DS */
-	{0x020e04a4, 0x00000028},	/* IOMUXC_SW_PAD_CTL_GRP_B1DS */
-
-	{0x020e0244, 0x00000028},	/* IOMUXC_SW_PAD_CTL_PAD_DRAM_DQM0 */
-	{0x020e0248, 0x00000028},	/* IOMUXC_SW_PAD_CTL_PAD_DRAM_DQM1 */
-
-	/*
-	 * =============================================================================
-	 * DDR Controller Registers
-	 * =============================================================================
-	 * Manufacturer:ISSI
-	 * Device Part Number:IS43TR16640BL-125JBLI
-	 * Clock Freq.: 400MHz
-	 * Density per CS in Gb: 1
-	 * Chip Selects used:1
-	 * Number of Banks:8
-	 * Row address:    13
-	 * Column address: 10
-	 * Data bus width16
-	 * =============================================================================
-	 */
-
-	{0x021b001c, 0x00008000}, /*
-				   * MMDC0_MDSCR, set the Configuration request bit during
-				   * MMDC set up
-				   */
-
-	/*
-	 * =============================================================================
-	 * Calibration setup
-	 * =============================================================================
-	 */
-
-	{0x021b0800, 0xA1390003}, /*
-				   * DDR_PHY_P0_MPZQHWCTRL, enable both one-time & periodic
-				   * HW ZQ calibration.
-				   */
-
-	/*
-	 * For target board, may need to run write leveling calibration to fine tune these
-	 * settings.
-	 */
-	{0x021b080c, 0x00000000},
-
-	/* Read DQS Gating calibration */
-	{0x021b083c, 0x41480148},	/* MPDGCTRL0 PHY0 */
-
-	/* Read calibration */
-	{0x021b0848, 0x40403A3E},	/* MPRDDLCTL PHY0 */
-
-	/* Write calibration */
-	{0x021b0850, 0x4040362E},	/* MPWRDLCTL PHY0 */
-
-	/*
-	 * Read data bit delay: 3 is the recommended default value, although out of reset
-	 * value is 0
-	 */
-	{0x021b081c, 0x33333333},	/* MMDC_MPRDDQBY0DL */
-	{0x021b0820, 0x33333333},	/* MMDC_MPRDDQBY1DL */
-
-	/* Write data bit delay: */
-	{0x021b082c, 0xF3333333},	/* MMDC_MPWRDQBY0DL */
-	{0x021b0830, 0xF3333333},	/* MMDC_MPWRDQBY1DL */
-
-	/* DQS&CLK Duty Cycle */
-	{0x021b08c0, 0x00944009},	/* [MMDC_MPDCCR] MMDC Duty Cycle Control Register */
-
-	/* Complete calibration by forced measurement: */
-	{0x021b08b8, 0x00000800},	/* DDR_PHY_P0_MPMUR0, frc_msr */
-
-	/*
-	 * =============================================================================
-	 * Calibration setup end
-	 * =============================================================================
-	 */
-
-	/* MMDC init: */
-	{0x021b0004, 0x0002002D},	/* MMDC0_MDPDC */
-	{0x021b0008, 0x1B333030},	/* MMDC0_MDOTC */
-	{0x021b000c, 0x2B2F52F3},	/* MMDC0_MDCFG0 */
-	{0x021b0010, 0xB66D0B63},	/* MMDC0_MDCFG1 */
-	{0x021b0014, 0x01FF00DB},	/* MMDC0_MDCFG2 */
-
-	/*
-	 * MDMISC: RALAT kept to the high level of 5.
-	 * MDMISC: consider reducing RALAT if your 528MHz board design allow that.
-	 * Lower RALAT benefits:
-	 * a. better operation at low frequency, for LPDDR2 freq < 100MHz, change RALAT to 3
-	 * b. Small performance improvement
-	 */
-	{0x021b0018, 0x00211740},	/* MMDC0_MDMISC */
-	{0x021b001c, 0x00008000},	/*
-					 * MMDC0_MDSCR, set the Configuration request
-					 * bit during MMDC set up
-					 */
-	{0x021b002c, 0x000026D2},	/* MMDC0_MDRWD */
-	{0x021b0030, 0x002F1023},	/* MMDC0_MDOR */
-	{0x021b0040, 0x00000043},	/* Chan0 CS0_END */
-	{0x021b0000, 0x82180000},	/* MMDC0_MDCTL */
-
-	{0x021b0890, 0x00400000},	/* MPPDCMPR2 */
-
-	/* Mode register writes */
-	{0x021b001c, 0x02808032},	/* MMDC0_MDSCR, MR2 write, CS0 */
-	{0x021b001c, 0x00008033},	/* MMDC0_MDSCR, MR3 write, CS0 */
-	{0x021b001c, 0x00048031},	/* MMDC0_MDSCR, MR1 write, CS0 */
-	{0x021b001c, 0x15208030},	/* MMDC0_MDSCR, MR0write, CS0 */
-	{0x021b001c, 0x04008040},	/*
-					 * MMDC0_MDSCR, ZQ calibration command sent to
-					 * device on CS0
-					 */
-	{0x021b0020, 0x00007800},	/* MMDC0_MDREF */
-
-	{0x021b0818, 0x00000227},	/* DDR_PHY_P0_MPODTCTRL */
-
-	{0x021b0004, 0x0002552D},	/* MMDC0_MDPDC now SDCTL power down enabled */
-
-	{0x021b0404, 0x00011006},	/*
-					 * MMDC0_MAPSR ADOPT power down enabled,
-					 * MMDC will enter automatically to self-refresh
-					 * while the number of idle cycle reached.
-					 */
-
-	{0x021b001c, 0x00000000},	/*
-					 * MMDC0_MDSCR, clear this register
-					 * (especially the configuration bit as initialization
-					 * is complete)
-					 */
-};
-
-static struct dram_timing_info dram_timing_128mb = {
-	.ddrc_cfg = ddr_ddrc_cfg_128mb,
-	.ddrc_cfg_num = ARRAY_SIZE(ddr_ddrc_cfg_128mb),
-};
-
 static void ddr_cfg_write(const struct dram_timing_info *dram_timing_info)
 {
 	int i;
 	const struct dram_cfg_param *ddrc_cfg = dram_timing_info->ddrc_cfg;
 	const int ddrc_cfg_num = dram_timing_info->ddrc_cfg_num;
+	struct mmdc_p_regs *mmdc0 = (struct mmdc_p_regs *)MMDC_P0_BASE_ADDR;
+
+	clrbits_le32(&mmdc0->mdctl, 1 << 31);	/* clear SDE_0 */
+	clrbits_le32(&mmdc0->mdctl, 1 << 30);	/* clear SDE_1 */
 
 	for (i = 0; i < ddrc_cfg_num; i++) {
 		debug("Writing 0x%x to register 0x%x\n", ddrc_cfg->val,
@@ -226,12 +53,22 @@ static void ddr_cfg_write(const struct dram_timing_info *dram_timing_info)
 
 static void spl_dram_init(void)
 {
-	struct mmdc_p_regs *mmdc0 = (struct mmdc_p_regs *)MMDC_P0_BASE_ADDR;
-
-	clrbits_le32(&mmdc0->mdctl, 1 << 31);	/* clear SDE_0 */
-	clrbits_le32(&mmdc0->mdctl, 1 << 30);	/* clear SDE_1 */
-
-	ddr_cfg_write(&dram_timing_128mb);
+	/* Configure memory to maximum supported size for detection */
+	ddr_cfg_write(&bsh_dram_timing_256mb);
+
+	/* Detect memory physically present */
+	gd->ram_size = get_ram_size((void *)CFG_SYS_SDRAM_BASE, SZ_256M);
+
+	/* Reconfigure memory for actual detected size */
+	switch (gd->ram_size) {
+	case SZ_256M:
+		/* Already configured, nothing to do */
+		break;
+	case SZ_128M:
+	default:
+		ddr_cfg_write(&bsh_dram_timing_128mb);
+		break;
+	}
 }
 
 static void ccgr_init(void)
diff --git a/board/bsh/imx6ulz_smm_m2/spl_mtypes.h b/board/bsh/imx6ulz_smm_m2/spl_mtypes.h
new file mode 100644
index 000000000000..2b517c316e0f
--- /dev/null
+++ b/board/bsh/imx6ulz_smm_m2/spl_mtypes.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2025 BSH Hausgeraete GmbH
+ *
+ * Written by: Simon Holesch <simon.holesch@bshg.com>
+ */
+
+#ifndef SPL_MTYPES_H
+#define SPL_MTYPES_H
+
+#include <spl.h>
+
+struct dram_cfg_param {
+	unsigned int reg;
+	unsigned int val;
+};
+
+struct dram_timing_info {
+	const struct dram_cfg_param *ddrc_cfg;
+	unsigned int ddrc_cfg_num;
+};
+
+extern struct dram_timing_info bsh_dram_timing_128mb;
+extern struct dram_timing_info bsh_dram_timing_256mb;
+
+#endif /* SPL_MTYPES_H */
diff --git a/include/configs/imx6ulz_smm_m2.h b/include/configs/imx6ulz_smm_m2.h
index 44a3fc02e8ac..87aede218d16 100644
--- a/include/configs/imx6ulz_smm_m2.h
+++ b/include/configs/imx6ulz_smm_m2.h
@@ -60,10 +60,8 @@
 	BOOTENV
 
 /* Physical Memory Map */
-#define PHYS_SDRAM			MMDC0_ARB_BASE_ADDR
-#define PHYS_SDRAM_SIZE			SZ_128M
-
-#define CFG_SYS_SDRAM_BASE		PHYS_SDRAM
+#define PHYS_SDRAM		MMDC0_ARB_BASE_ADDR
+#define CFG_SYS_SDRAM_BASE	PHYS_SDRAM
 #define CFG_SYS_INIT_RAM_ADDR	IRAM_BASE_ADDR
 #define CFG_SYS_INIT_RAM_SIZE	IRAM_SIZE
 
-- 
2.43.0

base-commit: eeb5ff1a468b2303efa9deb2483b5edbebb568c6
branch: bsh-202505-RAM
