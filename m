Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F72C3ABCC
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 16:36:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F43F82A36;
	Tue, 13 May 2025 18:36:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="WgtqWFB7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2677F8091A; Tue, 13 May 2025 18:36:42 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC680800C1
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 18:36:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ad4d03700e6so228946566b.3
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 09:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1747154198; x=1747758998;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bUXDWe/cLQTFweLeZNd8dy0ly3kOSFuNr12Sz+bvuEo=;
 b=WgtqWFB70SuhXxkhnW9bPf37p41BaElqE0QM+dm/w61NkvWsSnXfm6muVxaXmpZXQj
 +zXELOTq59vuZoNo0gM4U3fOqWJ0W0QOiz6sDWkXmowXghlUMLANHRiqZa9U0ZavbHL6
 cgiEv+Jso4MokcJSlz84miwsx0+QsMiMu2hFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747154198; x=1747758998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bUXDWe/cLQTFweLeZNd8dy0ly3kOSFuNr12Sz+bvuEo=;
 b=nfF39FXeeTM/H0dXqy9XZe5hu4reg1P6adUezEwz0wohGfAK6Ca8UIAWg5GByoKevH
 VRMYaorM/JbzPvPu0Cf0ZnMCjsHu3qdschaNeTHEly69/9+uHTLsTl7WJ/O1yBoOGsES
 9BnyUZsnR/HvgI+JdT6nHocCogOkoB7s477gPqGt60JjuBtTOVYt30lGvvpuvKZBU/Or
 e7r6ASYyismtc4Ll5fvtDTCRyr9L3k7liYmGoFWjaO0hg0CLBqidQkJhxV62TCNNRRu+
 t0j5gwsOXMGEiymEsB54QdHsuVFqHnNiExowiZ/edcZ6Mygi9WBZIgWifARiEAENyofz
 yuJw==
X-Gm-Message-State: AOJu0YwAQh08mG2bd8z5bud8Dn56n2j0HCSAWdPbR5Owb100mdvN4iHx
 FUbfPRS+ydzueFG3QPP7irx5mmSGLYKzBFBmBCfuhUlJ4/CzXs82H7rmeuQX2rBRX2UjGMXb1q3
 5Xo0=
X-Gm-Gg: ASbGncvU5jlTZKFBGA7nt+Th+LjVfDNKYawicCiwxRftX4P1eMTGYqkKzRxoO1cdjQb
 hC7GhshCjvyVUnMeFpvwcO2c7IqL3wol/mxlWvvRUyvuWJQZHCImA5qwMg24IEY4HzQ0X6Uff29
 g2TM1547J6VjwXVJPi8EHwbgnzIYLZvkw4YGCdIamK/KrhZSlFJ2H/bVGVXB/W0CMU9r586H9He
 2NpUJKeV6lqB+GeqyOLmKBI8OEF8qDSOdTJfBaSZiK1bLNm7btvHXZMhmfBDYqy40Tl+CB2xbNU
 DuLaicVL3mAyIvnPH85SpQyBZUlng2D6Rx3XP2P9o0oUnDHIRQtSRhTI8UqRCGHcYIxPH7aOjCH
 XdaVuOi6QH7RnXtW1651AF+HrmOOOyM6RfvUzwg/orw==
X-Google-Smtp-Source: AGHT+IGoIXmJqavLTDnJPsdoLQHTrjhFfHiDYyQjZjVEfCy9nP9IDppkP8ezzbGQtxj4R3SqxytQUw==
X-Received: by 2002:a17:907:168a:b0:aca:d560:d010 with SMTP id
 a640c23a62f3a-ad4f7565b8bmr20474566b.49.1747154197681; 
 Tue, 13 May 2025 09:36:37 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([46.189.28.43])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad23eafca8bsm565334966b.87.2025.05.13.09.36.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 09:36:37 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Simon Holesch <simon.holesch@bshg.com>,
 Wolfgang Birkner <wolfgang.birkner@bshg.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Bode <michael.bode@bshg.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/4] board: bsh: imx6ulz_smm_m2: Add support for 256 MiB DRAM
Date: Tue, 13 May 2025 18:36:16 +0200
Message-ID: <20250513163633.1803464-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250513163633.1803464-1-dario.binacchi@amarulasolutions.com>
References: <20250513163633.1803464-1-dario.binacchi@amarulasolutions.com>
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

 board/bsh/imx6ulz_smm_m2/Makefile            |   2 +-
 board/bsh/imx6ulz_smm_m2/ddr3l_timing_128m.c | 147 +++++++++++++++
 board/bsh/imx6ulz_smm_m2/ddr3l_timing_256m.c | 141 ++++++++++++++
 board/bsh/imx6ulz_smm_m2/spl.c               | 182 +++----------------
 board/bsh/imx6ulz_smm_m2/spl_mtypes.h        |  26 +++
 include/configs/imx6ulz_smm_m2.h             |   6 +-
 6 files changed, 339 insertions(+), 165 deletions(-)
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
index 000000000000..b1df7e7ada6f
--- /dev/null
+++ b/board/bsh/imx6ulz_smm_m2/ddr3l_timing_128m.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "spl_mtypes.h"
+
+static const struct dram_cfg_param ddr_ddrc_cfg_128mb[] = {
+	// IOMUX
+
+	//DDR IO TYPE:
+	{ 0x020e04b4, 0x000C0000 },	// IOMUXC_SW_PAD_CTL_GRP_DDR_TYPE
+	{ 0x020e04ac, 0x00000000 },	// IOMUXC_SW_PAD_CTL_GRP_DDRPKE
+
+	//CLOCK:
+	{ 0x020e027c, 0x00000028 },	// IOMUXC_SW_PAD_CTL_PAD_DRAM_SDCLK_0
+
+	//ADDRESS:
+	{ 0x020e0250, 0x00000028 },	// IOMUXC_SW_PAD_CTL_PAD_DRAM_CAS
+	{ 0x020e024c, 0x00000028 },	// IOMUXC_SW_PAD_CTL_PAD_DRAM_RAS
+	{ 0x020e0490, 0x00000028 },	// IOMUXC_SW_PAD_CTL_GRP_ADDDS
+
+	//Control:
+	{ 0x020e0288, 0x000C0028 },	// IOMUXC_SW_PAD_CTL_PAD_DRAM_RESET
+	{ 0x020e0270, 0x00000000 },	// IOMUXC_SW_PAD_CTL_PAD_DRAM_SDBA2 -
+					// DSE can be configured using Group
+					//  Control Register: IOMUXC_SW_PAD_CTL_GRP_CTLDS
+
+	{ 0x020e0260, 0x00000028 },	// IOMUXC_SW_PAD_CTL_PAD_DRAM_SDODT0
+	{ 0x020e0264, 0x00000028 },	// IOMUXC_SW_PAD_CTL_PAD_DRAM_SDODT1
+	{ 0x020e04a0, 0x00000028 },	// IOMUXC_SW_PAD_CTL_GRP_CTLDS
+
+	//Data Strobes:
+	{ 0x020e0494, 0x00020000 },	// IOMUXC_SW_PAD_CTL_GRP_DDRMODE_CTL
+	{ 0x020e0280, 0x00000028 },	// IOMUXC_SW_PAD_CTL_PAD_DRAM_SDQS0
+	{ 0x020e0284, 0x00000028 },	// IOMUXC_SW_PAD_CTL_PAD_DRAM_SDQS1
+
+	//Data:
+	{ 0x020e04b0, 0x00020000 },	// IOMUXC_SW_PAD_CTL_GRP_DDRMODE
+	{ 0x020e0498, 0x00000028 },	// IOMUXC_SW_PAD_CTL_GRP_B0DS
+	{ 0x020e04a4, 0x00000028 },	// IOMUXC_SW_PAD_CTL_GRP_B1DS
+
+	{ 0x020e0244, 0x00000028 },	// IOMUXC_SW_PAD_CTL_PAD_DRAM_DQM0
+	{ 0x020e0248, 0x00000028 },	// IOMUXC_SW_PAD_CTL_PAD_DRAM_DQM1
+
+	//=============================================================================
+	// DDR Controller Registers
+	//=============================================================================
+	// Manufacturer:ISSI
+	// Device Part Number:IS43TR16640BL-125JBLI
+	// Clock Freq.: 400MHz
+	// Density per CS in Gb: 1
+	// Chip Selects used:1
+	// Number of Banks:8
+	// Row address:    13
+	// Column address: 10
+	// Data bus width16
+	//=============================================================================
+	{ 0x021b001c, 0x00008000 },	// MMDC0_MDSCR, set the Configuration
+					// request bit during MMDC set up
+
+	//=============================================================================
+	// Calibration setup.
+	//=============================================================================
+	{ 0x021b0800, 0xA1390003 },	// DDR_PHY_P0_MPZQHWCTRL,
+					// enable both one-time & periodic HW ZQ calibration.
+
+	// For target board, may need to run write leveling calibration to fine tune these settings.
+	{ 0x021b080c, 0x00000000 },	//
+
+	//Read DQS Gating calibration
+	{ 0x021b083c, 0x41480148 },	// MPDGCTRL0 PHY0
+
+	//Read calibration
+	{ 0x021b0848, 0x40403A3E },	// MPRDDLCTL PHY0
+
+	//Write calibration
+	{ 0x021b0850, 0x4040362E },	// MPWRDLCTL PHY0
+
+	//read data bit delay: 3 is the reccommended default value, although out of reset value is 0
+	{ 0x021b081c, 0x33333333 },	// MMDC_MPRDDQBY0DL
+	{ 0x021b0820, 0x33333333 },	// MMDC_MPRDDQBY1DL
+
+	//write data bit delay:
+	{ 0x021b082c, 0xF3333333 },	// MMDC_MPWRDQBY0DL
+	{ 0x021b0830, 0xF3333333 },	// MMDC_MPWRDQBY1DL
+
+	//DQS&CLK Duty Cycle
+	{ 0x021b08c0, 0x00944009 },	// [MMDC_MPDCCR] MMDC Duty Cycle Control Register
+
+	// Complete calibration by forced measurement:
+	{ 0x021b08b8, 0x00000800 },	// DDR_PHY_P0_MPMUR0, frc_msr
+	//=============================================================================
+	// Calibration setup end
+	//=============================================================================
+
+	//MMDC init:
+	{ 0x021b0004, 0x0002002D },	// MMDC0_MDPDC
+	{ 0x021b0008, 0x1B333030 },	// MMDC0_MDOTC
+	{ 0x021b000c, 0x2B2F52F3 },	// MMDC0_MDCFG0
+	{ 0x021b0010, 0xB66D0B63 },	// MMDC0_MDCFG1
+	{ 0x021b0014, 0x01FF00DB },	// MMDC0_MDCFG2
+
+	//MDMISC: RALAT kept to the high level of 5.
+	//MDMISC: consider reducing RALAT if your 528MHz board design allow that.
+	//Lower RALAT benefits:
+	//a. better operation at low frequency, for LPDDR2 freq < 100MHz, change RALAT to 3
+	//b. Small performence improvment
+	{ 0x021b0018, 0x00211740 },	// MMDC0_MDMISC
+	{ 0x021b001c, 0x00008000 },	// MMDC0_MDSCR, set the Configuration request bit during
+					// MMDC set up
+	{ 0x021b002c, 0x000026D2 },	// MMDC0_MDRWD
+	{ 0x021b0030, 0x002F1023 },	// MMDC0_MDOR
+	{ 0x021b0040, 0x00000043 },	// Chan0 CS0_END
+	{ 0x021b0000, 0x82180000 },	// MMDC0_MDCTL
+
+	{ 0x021b0890, 0x00400000 },	// MPPDCMPR2
+
+	//Mode register writes
+	{ 0x021b001c, 0x02808032 },	// MMDC0_MDSCR, MR2 write, CS0
+	{ 0x021b001c, 0x00008033 },	// MMDC0_MDSCR, MR3 write, CS0
+	{ 0x021b001c, 0x00048031 },	// MMDC0_MDSCR, MR1 write, CS0
+	{ 0x021b001c, 0x15208030 },	// MMDC0_MDSCR, MR0write, CS0
+	{ 0x021b001c, 0x04008040 },	// MMDC0_MDSCR, ZQ calibration command sent to device on CS0
+
+	//    {0x021b001c,0x0200803A}, // MMDC0_MDSCR, MR2 write, CS1
+	//    {0x021b001c,0x0000803B}, // MMDC0_MDSCR, MR3 write, CS1
+	//    {0x021b001c,0x00048039}, // MMDC0_MDSCR, MR1 write, CS1
+	//    {0x021b001c,0x15208038}, // MMDC0_MDSCR, MR0write, CS1
+	//    {0x021b001c,0x04008048}, // MMDC0_MDSCR, ZQ calibration command sent to device on CS1
+
+	{ 0x021b0020, 0x00007800 },	// MMDC0_MDREF
+
+	{ 0x021b0818, 0x00000227 },	// DDR_PHY_P0_MPODTCTRL
+
+	{ 0x021b0004, 0x0002552D },	// MMDC0_MDPDC now SDCTL power down enabled
+
+	{ 0x021b0404, 0x00011006 },	// MMDC0_MAPSR ADOPT power down enabled,
+					// MMDC will enter automatically to self-refresh
+					// while the number of idle cycle reached.
+
+	{ 0x021b001c, 0x00000000 },	// MMDC0_MDSCR, clear this register
+					// (especially the configuration bit as initialization is
+					// complete)
+};
+
+struct dram_timing_info bsh_dram_timing_128mb = {
+	.ddrc_cfg = ddr_ddrc_cfg_128mb,
+	.ddrc_cfg_num = ARRAY_SIZE(ddr_ddrc_cfg_128mb),
+};
diff --git a/board/bsh/imx6ulz_smm_m2/ddr3l_timing_256m.c b/board/bsh/imx6ulz_smm_m2/ddr3l_timing_256m.c
new file mode 100644
index 000000000000..d7737f7b5b13
--- /dev/null
+++ b/board/bsh/imx6ulz_smm_m2/ddr3l_timing_256m.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "spl_mtypes.h"
+
+static const struct dram_cfg_param ddr_ddrc_cfg_256mb[] = {
+	// IOMUX
+
+	//DDR IO TYPE:
+	{ 0x020e04b4, 0x000C0000 },	// IOMUXC_SW_PAD_CTL_GRP_DDR_TYPE
+	{ 0x020e04ac, 0x00000000 },	// IOMUXC_SW_PAD_CTL_GRP_DDRPKE
+
+	//CLOCK:
+	{ 0x020e027c, 0x00000028 },	// IOMUXC_SW_PAD_CTL_PAD_DRAM_SDCLK_0
+
+	//ADDRESS:
+	{ 0x020e0250, 0x00000028 },	// IOMUXC_SW_PAD_CTL_PAD_DRAM_CAS
+	{ 0x020e024c, 0x00000028 },	// IOMUXC_SW_PAD_CTL_PAD_DRAM_RAS
+	{ 0x020e0490, 0x00000028 },	// IOMUXC_SW_PAD_CTL_GRP_ADDDS
+
+	//Control:
+	{ 0x020e0288, 0x000C0028 },	// IOMUXC_SW_PAD_CTL_PAD_DRAM_RESET
+	{ 0x020e0270, 0x00000000 },	// IOMUXC_SW_PAD_CTL_PAD_DRAM_SDBA2 -
+					// DSE can be configured using Group
+					//  Control Register: IOMUXC_SW_PAD_CTL_GRP_CTLDS
+
+	{ 0x020e0260, 0x00000028 },	// IOMUXC_SW_PAD_CTL_PAD_DRAM_SDODT0
+	{ 0x020e0264, 0x00000028 },	// IOMUXC_SW_PAD_CTL_PAD_DRAM_SDODT1
+	{ 0x020e04a0, 0x00000028 },	// IOMUXC_SW_PAD_CTL_GRP_CTLDS
+
+	//Data Strobes:
+	{ 0x020e0494, 0x00020000 },	// IOMUXC_SW_PAD_CTL_GRP_DDRMODE_CTL
+	{ 0x020e0280, 0x00000028 },	// IOMUXC_SW_PAD_CTL_PAD_DRAM_SDQS0
+	{ 0x020e0284, 0x00000028 },	// IOMUXC_SW_PAD_CTL_PAD_DRAM_SDQS1
+
+	//Data:
+	{ 0x020e04b0, 0x00020000 },	// IOMUXC_SW_PAD_CTL_GRP_DDRMODE
+	{ 0x020e0498, 0x00000028 },	// IOMUXC_SW_PAD_CTL_GRP_B0DS
+	{ 0x020e04a4, 0x00000028 },	// IOMUXC_SW_PAD_CTL_GRP_B1DS
+
+	{ 0x020e0244, 0x00000028 },	// IOMUXC_SW_PAD_CTL_PAD_DRAM_DQM0
+	{ 0x020e0248, 0x00000028 },	// IOMUXC_SW_PAD_CTL_PAD_DRAM_DQM1
+
+	//=============================================================================
+	// DDR Controller Registers
+	//=============================================================================
+	// Manufacturer:ISSI
+	// Device Part Number:IS43TR16640BL-125JBLI
+	// Clock Freq.: 400MHz
+	// Density per CS in Gb: 2
+	// Chip Selects used:1
+	// Number of Banks:8
+	// Row address:    14
+	// Column address: 10
+	// Data bus width16
+	//=============================================================================
+	{ 0x021b001c, 0x00008000 },	// MMDC0_MDSCR, set the Configuration
+					// request bit during MMDC set up
+
+	//=============================================================================
+	// Calibration setup.
+	//=============================================================================
+	{ 0x021b0800, 0xA1390003 },	// DDR_PHY_P0_MPZQHWCTRL,
+					// enable both one-time & periodic HW ZQ calibration.
+
+	// For target board, may need to run write leveling calibration to fine tune these settings.
+	{ 0x021b080c, 0x00050005 },	//
+
+	//Read DQS Gating calibration
+	{ 0x021b083c, 0x01480144 },	// MPDGCTRL0 PHY0
+
+	//Read calibration
+	{ 0x021b0848, 0x4040363A },	// MPRDDLCTL PHY0
+
+	//Write calibration
+	{ 0x021b0850, 0x40402E2C },	// MPWRDLCTL PHY0
+
+	//read data bit delay: 3 is the reccommended default value, although out of reset value is 0
+	{ 0x021b081c, 0x33333333 },	// MMDC_MPRDDQBY0DL
+	{ 0x021b0820, 0x33333333 },	// MMDC_MPRDDQBY1DL
+
+	//write data bit delay:
+	{ 0x021b082c, 0xF3333333 },	// MMDC_MPWRDQBY0DL
+	{ 0x021b0830, 0xF3333333 },	// MMDC_MPWRDQBY1DL
+
+	//DQS&CLK Duty Cycle
+	{ 0x021b08c0, 0x00944009 },	// [MMDC_MPDCCR] MMDC Duty Cycle Control Register
+
+	// Complete calibration by forced measurement:
+	{ 0x021b08b8, 0x00000800 },	// DDR_PHY_P0_MPMUR0, frc_msr
+	//=============================================================================
+	// Calibration setup end
+	//=============================================================================
+
+	//MMDC init:
+	{ 0x021b0004, 0x0002002D },	// MMDC0_MDPDC
+	{ 0x021b0008, 0x1B333030 },	// MMDC0_MDOTC
+	{ 0x021b000c, 0x3F435333 },	// MMDC0_MDCFG0
+	{ 0x021b0010, 0xB68E0B63 },	// MMDC0_MDCFG1
+	{ 0x021b0014, 0x01FF00DB },	// MMDC0_MDCFG2
+
+	//MDMISC: RALAT kept to the high level of 5.
+	//MDMISC: consider reducing RALAT if your 528MHz board design allow that.
+	//Lower RALAT benefits:
+	//a. better operation at low frequency, for LPDDR2 freq < 100MHz, change RALAT to 3
+	//b. Small performence improvment
+	{ 0x021b0018, 0x00211740 },	// MMDC0_MDMISC
+	{ 0x021b001c, 0x00008000 },	// MMDC0_MDSCR, set the Configuration request bit during
+					// MMDC set up
+	{ 0x021b002c, 0x000026D2 },	// MMDC0_MDRWD
+	{ 0x021b0030, 0x00431023 },	// MMDC0_MDOR
+	{ 0x021b0040, 0x00000047 },	// Chan0 CS0_END
+	{ 0x021b0000, 0x83180000 },	// MMDC0_MDCTL
+
+	{ 0x021b0890, 0x00400000 },	// MPPDCMPR2
+
+	//Mode register writes
+	{ 0x021b001c, 0x02808032 },	// MMDC0_MDSCR, MR2 write, CS0
+	{ 0x021b001c, 0x00008033 },	// MMDC0_MDSCR, MR3 write, CS0
+	{ 0x021b001c, 0x00048031 },	// MMDC0_MDSCR, MR1 write, CS0
+	{ 0x021b001c, 0x15208030 },	// MMDC0_MDSCR, MR0write, CS0
+	{ 0x021b001c, 0x04008040 },	// MMDC0_MDSCR, ZQ calibration command sent to device on CS0
+
+	{ 0x021b0020, 0x00007800 },	// MMDC0_MDREF
+
+	{ 0x021b0818, 0x00000227 },	// DDR_PHY_P0_MPODTCTRL
+
+	{ 0x021b0004, 0x0002552D },	// MMDC0_MDPDC now SDCTL power down enabled
+
+	{ 0x021b0404, 0x00011006 },	// MMDC0_MAPSR ADOPT power down enabled,
+					// MMDC will enter automatically to self-refresh
+					// while the number of idle cycle reached.
+
+	{ 0x021b001c, 0x00000000 },	// MMDC0_MDSCR, clear this register
+					// (especially the configuration bit as initialization
+					// is complete)
+};
+
+struct dram_timing_info bsh_dram_timing_256mb = {
+	.ddrc_cfg = ddr_ddrc_cfg_256mb,
+	.ddrc_cfg_num = ARRAY_SIZE(ddr_ddrc_cfg_256mb),
+};
diff --git a/board/bsh/imx6ulz_smm_m2/spl.c b/board/bsh/imx6ulz_smm_m2/spl.c
index 0fa510446813..3b3b295d9ca7 100644
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
@@ -31,165 +33,15 @@ static void setup_iomux_uart(void)
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
-	// IOMUX
-
-	//DDR IO TYPE:
-	{ 0x020e04b4, 0x000C0000 },	// IOMUXC_SW_PAD_CTL_GRP_DDR_TYPE
-	{ 0x020e04ac, 0x00000000 },	// IOMUXC_SW_PAD_CTL_GRP_DDRPKE
-
-	//CLOCK:
-	{ 0x020e027c, 0x00000028 },	// IOMUXC_SW_PAD_CTL_PAD_DRAM_SDCLK_0
-
-	//ADDRESS:
-	{ 0x020e0250, 0x00000028 },	// IOMUXC_SW_PAD_CTL_PAD_DRAM_CAS
-	{ 0x020e024c, 0x00000028 },	// IOMUXC_SW_PAD_CTL_PAD_DRAM_RAS
-	{ 0x020e0490, 0x00000028 },	// IOMUXC_SW_PAD_CTL_GRP_ADDDS
-
-	//Control:
-	{ 0x020e0288, 0x000C0028 },	// IOMUXC_SW_PAD_CTL_PAD_DRAM_RESET
-	{ 0x020e0270, 0x00000000 },	// IOMUXC_SW_PAD_CTL_PAD_DRAM_SDBA2 -
-					// DSE can be configured using Group
-					//  Control Register: IOMUXC_SW_PAD_CTL_GRP_CTLDS
-
-	{ 0x020e0260, 0x00000028 },	// IOMUXC_SW_PAD_CTL_PAD_DRAM_SDODT0
-	{ 0x020e0264, 0x00000028 },	// IOMUXC_SW_PAD_CTL_PAD_DRAM_SDODT1
-	{ 0x020e04a0, 0x00000028 },	// IOMUXC_SW_PAD_CTL_GRP_CTLDS
-
-	//Data Strobes:
-	{ 0x020e0494, 0x00020000 },	// IOMUXC_SW_PAD_CTL_GRP_DDRMODE_CTL
-	{ 0x020e0280, 0x00000028 },	// IOMUXC_SW_PAD_CTL_PAD_DRAM_SDQS0
-	{ 0x020e0284, 0x00000028 },	// IOMUXC_SW_PAD_CTL_PAD_DRAM_SDQS1
-
-	//Data:
-	{ 0x020e04b0, 0x00020000 },	// IOMUXC_SW_PAD_CTL_GRP_DDRMODE
-	{ 0x020e0498, 0x00000028 },	// IOMUXC_SW_PAD_CTL_GRP_B0DS
-	{ 0x020e04a4, 0x00000028 },	// IOMUXC_SW_PAD_CTL_GRP_B1DS
-
-	{ 0x020e0244, 0x00000028 },	// IOMUXC_SW_PAD_CTL_PAD_DRAM_DQM0
-	{ 0x020e0248, 0x00000028 },	// IOMUXC_SW_PAD_CTL_PAD_DRAM_DQM1
-
-	//=============================================================================
-	// DDR Controller Registers
-	//=============================================================================
-	// Manufacturer:ISSI
-	// Device Part Number:IS43TR16640BL-125JBLI
-	// Clock Freq.: 400MHz
-	// Density per CS in Gb: 1
-	// Chip Selects used:1
-	// Number of Banks:8
-	// Row address:    13
-	// Column address: 10
-	// Data bus width16
-	//=============================================================================
-	{ 0x021b001c, 0x00008000 },	// MMDC0_MDSCR, set the Configuration
-					// request bit during MMDC set up
-
-	//=============================================================================
-	// Calibration setup.
-	//=============================================================================
-	{ 0x021b0800, 0xA1390003 },	// DDR_PHY_P0_MPZQHWCTRL,
-					// enable both one-time & periodic HW ZQ calibration.
-
-	// For target board, may need to run write leveling calibration to fine tune these settings.
-	{ 0x021b080c, 0x00000000 },	//
-
-	//Read DQS Gating calibration
-	{ 0x021b083c, 0x41480148 },	// MPDGCTRL0 PHY0
-
-	//Read calibration
-	{ 0x021b0848, 0x40403A3E },	// MPRDDLCTL PHY0
-
-	//Write calibration
-	{ 0x021b0850, 0x4040362E },	// MPWRDLCTL PHY0
-
-	//read data bit delay: 3 is the reccommended default value, although out of reset value is 0
-	{ 0x021b081c, 0x33333333 },	// MMDC_MPRDDQBY0DL
-	{ 0x021b0820, 0x33333333 },	// MMDC_MPRDDQBY1DL
-
-	//write data bit delay:
-	{ 0x021b082c, 0xF3333333 },	// MMDC_MPWRDQBY0DL
-	{ 0x021b0830, 0xF3333333 },	// MMDC_MPWRDQBY1DL
-
-	//DQS&CLK Duty Cycle
-	{ 0x021b08c0, 0x00944009 },	// [MMDC_MPDCCR] MMDC Duty Cycle Control Register
-
-	// Complete calibration by forced measurement:
-	{ 0x021b08b8, 0x00000800 },	// DDR_PHY_P0_MPMUR0, frc_msr
-	//=============================================================================
-	// Calibration setup end
-	//=============================================================================
-
-	//MMDC init:
-	{ 0x021b0004, 0x0002002D },	// MMDC0_MDPDC
-	{ 0x021b0008, 0x1B333030 },	// MMDC0_MDOTC
-	{ 0x021b000c, 0x2B2F52F3 },	// MMDC0_MDCFG0
-	{ 0x021b0010, 0xB66D0B63 },	// MMDC0_MDCFG1
-	{ 0x021b0014, 0x01FF00DB },	// MMDC0_MDCFG2
-
-	//MDMISC: RALAT kept to the high level of 5.
-	//MDMISC: consider reducing RALAT if your 528MHz board design allow that.
-	//Lower RALAT benefits:
-	//a. better operation at low frequency, for LPDDR2 freq < 100MHz, change RALAT to 3
-	//b. Small performence improvment
-	{ 0x021b0018, 0x00211740 },	// MMDC0_MDMISC
-	{ 0x021b001c, 0x00008000 },	// MMDC0_MDSCR, set the Configuration request bit during
-					// MMDC set up
-	{ 0x021b002c, 0x000026D2 },	// MMDC0_MDRWD
-	{ 0x021b0030, 0x002F1023 },	// MMDC0_MDOR
-	{ 0x021b0040, 0x00000043 },	// Chan0 CS0_END
-	{ 0x021b0000, 0x82180000 },	// MMDC0_MDCTL
-
-	{ 0x021b0890, 0x00400000 },	// MPPDCMPR2
-
-	//Mode register writes
-	{ 0x021b001c, 0x02808032 },	// MMDC0_MDSCR, MR2 write, CS0
-	{ 0x021b001c, 0x00008033 },	// MMDC0_MDSCR, MR3 write, CS0
-	{ 0x021b001c, 0x00048031 },	// MMDC0_MDSCR, MR1 write, CS0
-	{ 0x021b001c, 0x15208030 },	// MMDC0_MDSCR, MR0write, CS0
-	{ 0x021b001c, 0x04008040 },	// MMDC0_MDSCR, ZQ calibration command sent to device on CS0
-
-	//    {0x021b001c,0x0200803A}, // MMDC0_MDSCR, MR2 write, CS1
-	//    {0x021b001c,0x0000803B}, // MMDC0_MDSCR, MR3 write, CS1
-	//    {0x021b001c,0x00048039}, // MMDC0_MDSCR, MR1 write, CS1
-	//    {0x021b001c,0x15208038}, // MMDC0_MDSCR, MR0write, CS1
-	//    {0x021b001c,0x04008048}, // MMDC0_MDSCR, ZQ calibration command sent to device on CS1
-
-	{ 0x021b0020, 0x00007800 },	// MMDC0_MDREF
-
-	{ 0x021b0818, 0x00000227 },	// DDR_PHY_P0_MPODTCTRL
-
-	{ 0x021b0004, 0x0002552D },	// MMDC0_MDPDC now SDCTL power down enabled
-
-	{ 0x021b0404, 0x00011006 },	// MMDC0_MAPSR ADOPT power down enabled,
-					// MMDC will enter automatically to self-refresh
-					// while the number of idle cycle reached.
-
-	{ 0x021b001c, 0x00000000 },	// MMDC0_MDSCR, clear this register
-					// (especially the configuration bit as initialization
-					// is complete)
-};
-
-struct dram_timing_info dram_timing_128mb = {
-	.ddrc_cfg = ddr_ddrc_cfg_128mb,
-	.ddrc_cfg_num = ARRAY_SIZE(ddr_ddrc_cfg_128mb),
-};
-
 static void ddr_cfg_write(const struct dram_timing_info *dram_timing_info)
 {
 	int i = 0;
 	const struct dram_cfg_param *ddrc_cfg = dram_timing_info->ddrc_cfg;
 	const int ddrc_cfg_num = dram_timing_info->ddrc_cfg_num;
+	struct mmdc_p_regs *mmdc0 = (struct mmdc_p_regs *)MMDC_P0_BASE_ADDR;
+
+	clrbits_le32(&mmdc0->mdctl, 1 << 31);	/* clear SDE_0 */
+	clrbits_le32(&mmdc0->mdctl, 1 << 30);	/* clear SDE_1 */
 
 	for (i = 0; i < ddrc_cfg_num; i++) {
 		debug("Writing 0x%x to register 0x%x\n", ddrc_cfg->val,
@@ -201,12 +53,22 @@ static void ddr_cfg_write(const struct dram_timing_info *dram_timing_info)
 
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
index 000000000000..f8dba6fb13f1
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
+#ifndef __SPL_BOARD__
+#define __SPL_BOARD__
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
+extern struct dram_timing_info bsh_dram_timing_256mb;
+extern struct dram_timing_info bsh_dram_timing_128mb;
+
+#endif
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

base-commit: cf37480bc8335494cf88b7180dc3f1eb8cf63a9d
branch: bsh-202505-RAM
