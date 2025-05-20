Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62777C3DA6D
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 15:07:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7989782C87;
	Tue, 20 May 2025 17:07:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="C8H8V9TQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55A1782D05; Tue, 20 May 2025 17:07:20 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7196482CD6
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 17:07:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cf848528aso50980515e9.2
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 08:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1747753637; x=1748358437;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l1ORMN0A3AdJxw/iKArEXhulv1nLIu/LLHZmRFSfzx8=;
 b=C8H8V9TQjF5drv0l5YzBxnSS+3o9GyEmjWojqTH/Ufx8McMVTJy2eY2dohsfRQ6hyH
 R5c0aEEUz7CxAgvHoneYomKkS1+sJvV+08pDilabz5PF9KsV/TB2Bh/Feeh9dGsREtm8
 L0aGmwCh98qhBn3KRfxx0ktUrhzLTELoQfmMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747753637; x=1748358437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l1ORMN0A3AdJxw/iKArEXhulv1nLIu/LLHZmRFSfzx8=;
 b=M3Zlb9lcMgerWnu0aFQSsiCWCffi/Qs9u7EjvhcFXKSLN86IW0EcNP8l8XXt/j+oLG
 8fbIBme894o0tTJ/yCi3MoyKSpXQJCCNLjJXHYTpvweibRKpXKeFaBwzvTYEZy1y+9uK
 AqXqaPMfeWS41F7EvR4zGM7i4HuNw8KKG6ro9v4FhqIbTr6lq18bGT/mmhHSgfeEGNWL
 nPQO2lIQWtfX6vwQre5jy/tRBh972ilZm7cWJYXsu6CvBmz1frTOJT8TTK5vzJVql4Yo
 8WzL8Vtptc6ULBGXuHf+Wt2SsDyMJ273Bfx/ccBULUZnkjknViRKMaBEfa7/EatEjdp5
 MrIg==
X-Gm-Message-State: AOJu0YzPzO0jZ0Uj8RujUNJvQ+iBx799dmsGEqs0ZbQMa9BDwPHJCJvg
 5N3BgfnCSkn6HKKP1puorBn9xeqTnZaIs+aAeKzc2YKaV98KyQxOgwwjpRDwYHYJzu8KthxDXYy
 RCoFc
X-Gm-Gg: ASbGncvkD+GOVRu+nb6lpHqtbYHRvjL8b06knDK5TjdnbSFQ3Bk2EAbmpq+D4TPmhB3
 nZiu0srnpotDm3pK/G6IeyaX6DrmSP0Sv4dOcH91WE51CShRQLHVS7J1hvizooa/uIylySYoR+t
 lWsAPAcrIZvlGWxeRTlvMogy6IpnY9GqA/oG7w4+gr/WixhzHPZorIL8CBzbkATi7lXfAenE6YT
 NF5fcD16sF3Xh4+JdqpuAeZKOs+zEr7FRERbQG3zwc36iJXbF1f3eWqdH2fLan27MNlAW/4iU+M
 mHLFv1lUHjEVz6eQsOMsZty7WER2fihGJpnF4xJyjp74q0aqmpl9vyQjWnVqWE8pr2gUdVY8aZQ
 dPK0m737iOyLuSQsiG0+l6zvkr7PNjfawLC9P/+kp
X-Google-Smtp-Source: AGHT+IF34moSrVHdmuQh/C0uN9F4wgC9tiOCROd7FsKVvuuIJ4KQuPCmQIMeWU+/KYnoKyQlUsd9pA==
X-Received: by 2002:a05:600c:64cd:b0:43d:745a:5a50 with SMTP id
 5b1f17b1804b1-442fd6313demr131321035e9.19.1747753636579; 
 Tue, 20 May 2025 08:07:16 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2.196.40.47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35e49262fsm16179766f8f.44.2025.05.20.08.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 08:07:15 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Bode <michael.bode@bshg.com>, linux-amarula@amarulasolutions.com,
 Simon Holesch <simon.holesch@bshg.com>, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Wolfgang Birkner <wolfgang.birkner@bshg.com>
Subject: [PATCH v2 3/4] board: bsh: imx6ulz_smm_m2: Add support for 512 MiB
 DRAM
Date: Tue, 20 May 2025 17:07:01 +0200
Message-ID: <20250520150709.988904-3-dario.binacchi@amarulasolutions.com>
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

From: Michael Bode <michael.bode@bshg.com>

Calibration values were calculated using the NXP tool
I.MX6ULL_DDR3_Script_Aid_V0.01.xlsx

Signed-off-by: Michael Bode <michael.bode@bshg.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Use standard C comment style

 board/bsh/imx6ulz_smm_m2/Makefile            |   3 +-
 board/bsh/imx6ulz_smm_m2/ddr3l_timing_512m.c | 168 +++++++++++++++++++
 board/bsh/imx6ulz_smm_m2/spl.c               |   9 +-
 board/bsh/imx6ulz_smm_m2/spl_mtypes.h        |   1 +
 4 files changed, 176 insertions(+), 5 deletions(-)
 create mode 100644 board/bsh/imx6ulz_smm_m2/ddr3l_timing_512m.c

diff --git a/board/bsh/imx6ulz_smm_m2/Makefile b/board/bsh/imx6ulz_smm_m2/Makefile
index d448f4fc5215..4f4d67f659d0 100644
--- a/board/bsh/imx6ulz_smm_m2/Makefile
+++ b/board/bsh/imx6ulz_smm_m2/Makefile
@@ -2,5 +2,4 @@
 # (C) Copyright 2021 Amarula Solutions B.V.
 
 obj-y  := imx6ulz_smm_m2.o
-obj-$(CONFIG_XPL_BUILD) += spl.o ddr3l_timing_256m.o ddr3l_timing_128m.o
-
+obj-$(CONFIG_XPL_BUILD) += spl.o ddr3l_timing_512m.o ddr3l_timing_256m.o ddr3l_timing_128m.o
diff --git a/board/bsh/imx6ulz_smm_m2/ddr3l_timing_512m.c b/board/bsh/imx6ulz_smm_m2/ddr3l_timing_512m.c
new file mode 100644
index 000000000000..f5989382f5aa
--- /dev/null
+++ b/board/bsh/imx6ulz_smm_m2/ddr3l_timing_512m.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "spl_mtypes.h"
+
+static const struct dram_cfg_param ddr_ddrc_cfg_512mb[] = {
+	/*
+	 * =============================================================================
+	 * IOMUX
+	 * =============================================================================
+	 */
+
+	/* DDR IO Type: */
+	{0x020e04b4, 0x000C0000}, /* IOMUXC_SW_PAD_CTL_GRP_DDR_TYPE */
+	{0x020e04ac, 0x00000000}, /* IOMUXC_SW_PAD_CTL_GRP_DDRPKE */
+
+	/* Clock: */
+	{0x020e027c, 0x00000028}, /* IOMUXC_SW_PAD_CTL_PAD_DRAM_SDCLK_0 */
+
+	/* Address: */
+	{0x020e0250, 0x00000028}, /* IOMUXC_SW_PAD_CTL_PAD_DRAM_CAS */
+	{0x020e024c, 0x00000028}, /* IOMUXC_SW_PAD_CTL_PAD_DRAM_RAS */
+	{0x020e0490, 0x00000028}, /* IOMUXC_SW_PAD_CTL_GRP_ADDDS */
+
+	/* Control: */
+	{0x020e0288, 0x000C0028}, /* IOMUXC_SW_PAD_CTL_PAD_DRAM_RESET */
+	{0x020e0270, 0x00000000}, /*
+				   * IOMUXC_SW_PAD_CTL_PAD_DRAM_SDBA2 - DSE can be configured using
+				   * Group Control Register: IOMUXC_SW_PAD_CTL_GRP_CTLDS
+				   */
+	{0x020e0260, 0x00000028}, /* IOMUXC_SW_PAD_CTL_PAD_DRAM_SDODT0 */
+	{0x020e0264, 0x00000028}, /* IOMUXC_SW_PAD_CTL_PAD_DRAM_SDODT1 */
+	{0x020e04a0, 0x00000028}, /* IOMUXC_SW_PAD_CTL_GRP_CTLDS */
+
+	/* Data Strobes: */
+	{0x020e0494, 0x00020000}, /* IOMUXC_SW_PAD_CTL_GRP_DDRMODE_CTL */
+	{0x020e0280, 0x00000028}, /* IOMUXC_SW_PAD_CTL_PAD_DRAM_SDQS0 */
+	{0x020e0284, 0x00000028}, /* IOMUXC_SW_PAD_CTL_PAD_DRAM_SDQS1 */
+
+	/* Data: */
+	{0x020e04b0, 0x00020000}, /* IOMUXC_SW_PAD_CTL_GRP_DDRMODE */
+	{0x020e0498, 0x00000028}, /* IOMUXC_SW_PAD_CTL_GRP_B0DS */
+	{0x020e04a4, 0x00000028}, /* IOMUXC_SW_PAD_CTL_GRP_B1DS */
+
+	{0x020e0244, 0x00000028}, /* IOMUXC_SW_PAD_CTL_PAD_DRAM_DQM0 */
+	{0x020e0248, 0x00000028}, /* IOMUXC_SW_PAD_CTL_PAD_DRAM_DQM1 */
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
+	{0x021b001c, 0x00008000}, /*
+				   * MMDC0_MDSCR, set the Configuration request bit during
+				   * MMDC set up
+				   */
+
+	/*
+	 * =============================================================================
+	 * Calibration setup.
+	 * =============================================================================
+	 */
+	{0x021b0800, 0xA1390003}, /*
+				   * DDR_PHY_P0_MPZQHWCTRL, enable both one-time & periodic
+				   * HW ZQ calibration
+				   */
+
+	/*
+	 * For target board may need to run write leveling calibration to fine tune these settings
+	 */
+	{0x021b080c, 0x00000000},
+
+	/* Read DQS Gating calibration */
+	{0x021b083c, 0x01440140}, /* MPDGCTRL0 PHY0 */
+
+	/* Read calibration */
+	{0x021b0848, 0x40403A3E}, /* MPRDDLCTL PHY0 */
+
+	/* Write calibration */
+	{0x021b0850, 0x4040322A}, /* MPWRDLCTL PHY0 */
+
+	/*
+	 * Read data bit delay: 3 is the reccommended default value, although out of reset value
+	 * is 0
+	 */
+	{0x021b081c, 0x33333333}, /* MMDC_MPRDDQBY0DL */
+	{0x021b0820, 0x33333333}, /* MMDC_MPRDDQBY1DL */
+
+	/* Write data bit delay: */
+	{0x021b082c, 0xF3333333}, /* MMDC_MPWRDQBY0DL */
+	{0x021b0830, 0xF3333333}, /* MMDC_MPWRDQBY1DL */
+
+	/* DQS&CLK Duty Cycle */
+	{0x021b08c0, 0x00944009}, /* [MMDC_MPDCCR] MMDC Duty Cycle Control Register */
+
+	/* Complete calibration by forced measurement: */
+	{0x021b08b8, 0x00000800}, /* DDR_PHY_P0_MPMUR0, frc_msr */
+
+	/*
+	 * =============================================================================
+	 * Calibration setup end
+	 * =============================================================================
+	 */
+
+	/* MMDC init: */
+	{0x021b0004, 0x0002002D}, /* MMDC0_MDPDC */
+	{0x021b0008, 0x1B333030}, /* MMDC0_MDOTC */
+	{0x021b000c, 0x3F435333}, /* MMDC0_MDCFG0 */
+	{0x021b0010, 0xB68E0B63}, /* MMDC0_MDCFG1 */
+	{0x021b0014, 0x01FF00DB}, /* MMDC0_MDCFG2 */
+
+	/*
+	 * MDMISC: RALAT kept to the high level of 5.
+	 * MDMISC: consider reducing RALAT if your 528MHz board design allow that.
+	 * Lower RALAT benefits:
+	 * a. better operation at low frequency, for LPDDR2 freq < 100MHz, change RALAT to 3
+	 * b. Small performence improvment
+	 */
+	{0x021b0018, 0x00211740}, /* MMDC0_MDMISC */
+	{0x021b001c, 0x00008000}, /*
+				   * MMDC0_MDSCR set the Configuration request bit during
+				   * MMDC set up
+				   */
+	{0x021b002c, 0x000026D2}, /* MMDC0_MDRWD */
+	{0x021b0030, 0x00431023}, /* MMDC0_MDOR */
+	{0x021b0040, 0x0000004F}, /* Chan0 CS0_END */
+	{0x021b0000, 0x84180000}, /* MMDC0_MDCTL */
+
+	{0x021b0890, 0x00400000}, /* MPPDCMPR2 */
+
+	/* Mode register writes */
+	{0x021b001c, 0x02808032}, /* MMDC0_MDSCR, MR2 write, CS0 */
+	{0x021b001c, 0x00008033}, /* MMDC0_MDSCR, MR3 write, CS0 */
+	{0x021b001c, 0x00048031}, /* MMDC0_MDSCR, MR1 write, CS0 */
+	{0x021b001c, 0x15208030}, /* MMDC0_MDSCR, MR0write, CS0 */
+	{0x021b001c, 0x04008040}, /* MMDC0_MDSCR, ZQ calibration command sent to device on CS0 */
+
+	{0x021b0020, 0x00007800}, /* MMDC0_MDREF */
+
+	{0x021b0818, 0x00000227}, /* DDR_PHY_P0_MPODTCTRL */
+
+	{0x021b0004, 0x0002552D}, /* MMDC0_MDPDC now SDCTL power down enabled */
+
+	{0x021b0404, 0x00011006}, /*
+				   * MMDC0_MAPSR ADOPT power down enabled, MMDC will enter
+				   * automatically to self-refresh while the number of idle
+				   * cycle reached
+				   */
+
+	{0x021b001c, 0x00000000}, /*
+				   * MMDC0_MDSCR, clear this register (especially the configuration
+				   * bit as initialization is complete)
+				   */
+};
+
+struct dram_timing_info bsh_dram_timing_512mb = {
+	.ddrc_cfg = ddr_ddrc_cfg_512mb,
+	.ddrc_cfg_num = ARRAY_SIZE(ddr_ddrc_cfg_512mb),
+};
diff --git a/board/bsh/imx6ulz_smm_m2/spl.c b/board/bsh/imx6ulz_smm_m2/spl.c
index 85fd9e133eb3..e8255b6d2a62 100644
--- a/board/bsh/imx6ulz_smm_m2/spl.c
+++ b/board/bsh/imx6ulz_smm_m2/spl.c
@@ -54,16 +54,19 @@ static void ddr_cfg_write(const struct dram_timing_info *dram_timing_info)
 static void spl_dram_init(void)
 {
 	/* Configure memory to maximum supported size for detection */
-	ddr_cfg_write(&bsh_dram_timing_256mb);
+	ddr_cfg_write(&bsh_dram_timing_512mb);
 
 	/* Detect memory physically present */
-	gd->ram_size = get_ram_size((void *)CFG_SYS_SDRAM_BASE, SZ_256M);
+	gd->ram_size = get_ram_size((void *)CFG_SYS_SDRAM_BASE, SZ_512M);
 
 	/* Reconfigure memory for actual detected size */
 	switch (gd->ram_size) {
-	case SZ_256M:
+	case SZ_512M:
 		/* Already configured, nothing to do */
 		break;
+	case SZ_256M:
+		ddr_cfg_write(&bsh_dram_timing_256mb);
+		break;
 	case SZ_128M:
 	default:
 		ddr_cfg_write(&bsh_dram_timing_128mb);
diff --git a/board/bsh/imx6ulz_smm_m2/spl_mtypes.h b/board/bsh/imx6ulz_smm_m2/spl_mtypes.h
index 2b517c316e0f..8da59881c833 100644
--- a/board/bsh/imx6ulz_smm_m2/spl_mtypes.h
+++ b/board/bsh/imx6ulz_smm_m2/spl_mtypes.h
@@ -22,5 +22,6 @@ struct dram_timing_info {
 
 extern struct dram_timing_info bsh_dram_timing_128mb;
 extern struct dram_timing_info bsh_dram_timing_256mb;
+extern struct dram_timing_info bsh_dram_timing_512mb;
 
 #endif /* SPL_MTYPES_H */
-- 
2.43.0

base-commit: eeb5ff1a468b2303efa9deb2483b5edbebb568c6
branch: bsh-202505-RAM
