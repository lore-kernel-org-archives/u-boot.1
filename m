Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB233C2D0CD
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 09:47:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 450E282E81;
	Wed, 21 May 2025 11:47:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Ff488cKG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65B8582E66; Wed, 21 May 2025 11:47:42 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E004582E31
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 11:47:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6019b564d0bso8340652a12.2
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 02:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1747820859; x=1748425659;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VJTFK8xdv4RQyg0pIfTbfJObVjKhhuj+68bC/WJdesQ=;
 b=Ff488cKG+i/IOHYofFr/FFHlSzph4uZwxG/H/0VwsGwGIy50fppIm4aGUMK39mT+xo
 5jErzpI3ADC7Kr2HxDH7S84Vjbr/xs92d3/SRUHbD151whNqxygKpSJI87T/djien1Wg
 PcZyMgUjWh3vjwR3iFSyXjddbpXUKVy8o1YWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747820859; x=1748425659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VJTFK8xdv4RQyg0pIfTbfJObVjKhhuj+68bC/WJdesQ=;
 b=Z06xhEq+tpIUFBfexSRE3cnNU2OLi1Lrzw+3oYfgvaHIOmhP5DNcIuMWO+jh5SNBQF
 a25zUcQZEZe7VAUsGhtc5ccYXjkNxGHzFhwtfM460MjF7F5mqgoPyRQV3QZKAOmkcZrf
 2ADB46YW6ONxTNEkAQSZURF365JhL7P2DdQ+ejLBQfxd5uGrYbPrizU4ub0s9Px6OrB+
 w54zguNKW9h4lVG3ZkQKX0PG+GEiW9ToJsDyFVF4hqDUmwcOd1UiEqsED4HTEvYubbeW
 nvPEDUVprGXOkOYdprdC02mA00roYRjWhT3w89/iDnshXtoaRSjJzZaa0M05VEoajzXE
 YQWg==
X-Gm-Message-State: AOJu0Yxph6C70CtCwpuXKPMwdQBpmLDCKoqqVwNu/k0Ih7R/T7+vsVlN
 apyqKoEuHfDqwWBOTqusTOY+iP3pfiGKBx6CshJ9/xyplaUzciKWeDububvlA+LwEI7sDqKxAfc
 pzWKo
X-Gm-Gg: ASbGncvm3ExzmmMx8Q5mAdsVSeUd/QlvrZtAk3C6pLz6/p1mNXjIJG3CIo3TOU1cCvs
 wGOr9BX17t1ZyY5VIykZcsZ7cHmDbZanmbPUpp/O7I3pIDw6wRxEflFoPF89PTE5zSIe82hRNuR
 frP3IzJGdEQioUE/qFrJxT55EcRUdilwkYgl19ym/mKsCSTvpOGt+pRCl+ZDliS6BsI8ICOUhHX
 AcxjlfRCsK2wXbzQxAt1UzGNenwypBCk5RrxeJwvFXs+Abe/ZFPKyBmkDtVNmkegcZVGVv67ZDK
 f5TJlNuznNx8IZxUqkwXEZCsISXGwfTapC+g0zHBQPDjJL/HapY4RzipTAUU1B4VkdfURemGYox
 CCcA0MloM4zkl
X-Google-Smtp-Source: AGHT+IH/to37tEGUZABoYIOmyvWFs1hRqjm05zEwAPC6IzaP1tt667MXEJ5YcyfKj7WeRMNl6ydqug==
X-Received: by 2002:a17:906:fe49:b0:ad2:3f1f:7970 with SMTP id
 a640c23a62f3a-ad52d45aef4mr1921831366b.2.1747820858969; 
 Wed, 21 May 2025 02:47:38 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:cfc5:5070:d6f4:1d86])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d06b497sm863951166b.42.2025.05.21.02.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 02:47:38 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: michael@amarulasolutions.com, Simon Holesch <simon.holesch@bshg.com>,
 linux-amarula@amarulasolutions.com, Michael Bode <michael.bode@bshg.com>,
 Wolfgang Birkner <wolfgang.birkner@bshg.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 2/4] board: bsh: imx6ulz_smm_m2: Add support for 256 MiB
 DRAM
Date: Wed, 21 May 2025 11:47:30 +0200
Message-ID: <20250521094735.1037146-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521094735.1037146-1-dario.binacchi@amarulasolutions.com>
References: <20250521094735.1037146-1-dario.binacchi@amarulasolutions.com>
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

(no changes since v2)

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

base-commit: a3e09b24ffd4429909604f1b28455b44306edbaa
branch: bsh-202505-RAM
