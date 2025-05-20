Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90080C3ABDD
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 15:07:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E53D782CD2;
	Tue, 20 May 2025 17:07:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="T7zNyjYg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2769482CDF; Tue, 20 May 2025 17:07:18 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7928B82A8D
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 17:07:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so46092315e9.1
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 08:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1747753635; x=1748358435;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=umDfddv0eFDxPx8NQVdX6EweKq1K+Vo3liwjYi2BWEk=;
 b=T7zNyjYgpBz7TfWvPQ8PylCi+OiFjWH0xE1KNyBKPtZJolhpu5Yd1YFxJGTRvQ1MU0
 o1vm3b3tqusEPqoUkBqE0x4sXba0s8MU8+xdwYQpwba+2YFvs1aPOw1kSKWk6mls18uh
 mAzi6Uy0Z6XmYow7nn3Lh5FF+TB8s9gsq+J9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747753635; x=1748358435;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=umDfddv0eFDxPx8NQVdX6EweKq1K+Vo3liwjYi2BWEk=;
 b=B3JCS9MbwbaPovoGBQb+sRDTIihtdkhCkt915x2gIBN4ooidFRI468oo8PGMR13gDz
 1AN8y2AmzayY8EVcAym1cynbwMfUJrLapesetUrOjYV7MvhRTGcIpaFoAD9+HWCh9xBB
 9yO8aynQxJVJiM3kbucou8qOCDQI+J0cMl+pFgIg6jYt+E67GzCDxtPbj0+Nxl6Dl0WY
 5byuOAiuoUKvI6Rl48I/nuRtMqyqb/Umgta93HfMIfXUrHtGxa+MNa1gyoj4EkhiDs2n
 ip3GzZtrTqONzSOzsFN4HPb0uD3eSURaPGXdlWEbXT5Hpu99qFIP3Y9bwoJX6x0flT2O
 NMAg==
X-Gm-Message-State: AOJu0YwyA3beuokpp7j6r4wSWL2DsdcR3XJHC48Kdgn+wcvS4MzFFUCn
 8NY54GimkECz8WRnEDAVr67MMOXK1PjP89iePa06tmnbjrTl3BUYDRikHJQr6ObkUMeUpwvjud4
 n7a80
X-Gm-Gg: ASbGnctd4JoakMvW44PCIvSEirA0JsxXpwS3Gz2AjJuAhHbUgdEA0jOjJBITAWKTY1Q
 FN4xMZ85siKR/1foAB3EoLmx1OEBs66xcGkhz1g3ynZqc71+rlG7dR9JmC2gQxydS0A/IThEhZt
 dGqWGCuIMW8yDfZTZcuMg4Dn8n4yBO0Wxiikk1cHa1j+vVam+KJLOikjSDG5Cjisc06jyU8TBLw
 e2FxyjN1jgFi0Yb/yXdZNRwnyTt2hCea/lqlbxzo53ic+mSJM4smZIa+as0Ie+uvdIxkOtdBKwH
 ZugbzoCGncyFEAKahQlDT8ebf95ygNb0at/DmjANOtSEsy0gTgIS2WzvDktXjcE/igzgFpEqz0u
 BQbYBGJzcYaif46OoNzvWNHk+diL7AAA6trs8LD/q
X-Google-Smtp-Source: AGHT+IHmuTSmdd6xbtEg8eZPfmLB8xpmAT1aPCmwtfoJRqdK51eAkyg7TMegdfGxG486bwCtONrakw==
X-Received: by 2002:a05:600c:3c94:b0:43d:24d:bbe2 with SMTP id
 5b1f17b1804b1-442fd6758d2mr130039405e9.28.1747753632967; 
 Tue, 20 May 2025 08:07:12 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2.196.40.47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35e49262fsm16179766f8f.44.2025.05.20.08.07.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 08:07:12 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Bode <michael.bode@bshg.com>, linux-amarula@amarulasolutions.com,
 Simon Holesch <simon.holesch@bshg.com>, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Wolfgang Birkner <wolfgang.birkner@bshg.com>
Subject: [PATCH v2 1/4] board: bsh: imx6ulz_smm_m2: Match SPL DDR settings to
 DCD table
Date: Tue, 20 May 2025 17:06:59 +0200
Message-ID: <20250520150709.988904-1-dario.binacchi@amarulasolutions.com>
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

From: Michael Trimarchi <michael@amarulasolutions.com>

When using SPL on i.mx6 we frequently notice some DDR initialization
mismatches between the SPL code and the non-SPL code.

As the non-SPL code have been tested for long time and proves to be
reliable, let's configure the DDR in the exact same way as the non-SPL
case.

The idea is simple: just use the DCD table and write directly to the DDR
registers.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Add 'static struct' globally in the module where the definitions
  can mabe static.
- Use standard C comment style

 arch/arm/include/asm/arch-mx6/mx6-ddr.h |   2 +
 arch/arm/mach-imx/mx6/ddr.c             |   3 +
 board/bsh/imx6ulz_smm_m2/spl.c          | 260 ++++++++++++++++++------
 3 files changed, 203 insertions(+), 62 deletions(-)

diff --git a/arch/arm/include/asm/arch-mx6/mx6-ddr.h b/arch/arm/include/asm/arch-mx6/mx6-ddr.h
index ad9c1ac906a3..bd3ff65bcd96 100644
--- a/arch/arm/include/asm/arch-mx6/mx6-ddr.h
+++ b/arch/arm/include/asm/arch-mx6/mx6-ddr.h
@@ -457,6 +457,8 @@ struct mx6_mmdc_calibration {
 	u32 p1_mpwrdlctl;
 	/* lpddr2 zq hw calibration */
 	u32 mpzqlp2ctl;
+	/* MDC Duty Cycle Control Register */
+	u32 mpdccr;
 };
 
 /* configure iomux (pinctl/padctl) */
diff --git a/arch/arm/mach-imx/mx6/ddr.c b/arch/arm/mach-imx/mx6/ddr.c
index 5a1258e002d2..749ceee0cdbf 100644
--- a/arch/arm/mach-imx/mx6/ddr.c
+++ b/arch/arm/mach-imx/mx6/ddr.c
@@ -1444,6 +1444,9 @@ void mx6_ddr3_cfg(const struct mx6_ddr_sysinfo *sysinfo,
 	mmdc0->mpdgctrl1 = calib->p0_mpdgctrl1;
 	mmdc0->mprddlctl = calib->p0_mprddlctl;
 	mmdc0->mpwrdlctl = calib->p0_mpwrdlctl;
+	if (calib->mpdccr)
+		mmdc0->mpdccr = calib->mpdccr;
+
 	if (sysinfo->dsize > 1) {
 		MMDC1(mpwldectrl0, calib->p1_mpwldectrl0);
 		MMDC1(mpwldectrl1, calib->p1_mpwldectrl1);
diff --git a/board/bsh/imx6ulz_smm_m2/spl.c b/board/bsh/imx6ulz_smm_m2/spl.c
index 724841b57456..936e54662e98 100644
--- a/board/bsh/imx6ulz_smm_m2/spl.c
+++ b/board/bsh/imx6ulz_smm_m2/spl.c
@@ -31,70 +31,209 @@ static void setup_iomux_uart(void)
 	imx_iomux_v3_setup_multiple_pads(uart4_pads, ARRAY_SIZE(uart4_pads));
 }
 
-static struct mx6ul_iomux_grp_regs mx6_grp_ioregs = {
-	.grp_addds		= 0x00000028,
-	.grp_ddrmode_ctl	= 0x00020000,
-	.grp_b0ds		= 0x00000028,
-	.grp_ctlds		= 0x00000028,
-	.grp_b1ds		= 0x00000028,
-	.grp_ddrpke		= 0x00000000,
-	.grp_ddrmode		= 0x00020000,
-	.grp_ddr_type		= 0x000c0000,
+struct dram_cfg_param {
+	unsigned int reg;
+	unsigned int val;
 };
 
-static struct mx6ul_iomux_ddr_regs mx6_ddr_ioregs = {
-	.dram_dqm0		= 0x00000028,
-	.dram_dqm1		= 0x00000028,
-	.dram_ras		= 0x00000028,
-	.dram_cas		= 0x00000028,
-	.dram_odt0		= 0x00000028,
-	.dram_odt1		= 0x00000028,
-	.dram_sdba2		= 0x00000000,
-	.dram_sdclk_0		= 0x00000028,
-	.dram_sdqs0		= 0x00000028,
-	.dram_sdqs1		= 0x00000028,
-	.dram_reset		= 0x000c0028,
+struct dram_timing_info {
+	const struct dram_cfg_param *ddrc_cfg;
+	unsigned int ddrc_cfg_num;
 };
 
-static struct mx6_mmdc_calibration mx6_mmcd_calib = {
-	.p0_mpwldectrl0		= 0x00000000,
-	.p0_mpwldectrl1		= 0x00100010,
-	.p0_mpdgctrl0		= 0x414c014c,
-	.p0_mpdgctrl1		= 0x00000000,
-	.p0_mprddlctl		= 0x40403a42,
-	.p0_mpwrdlctl		= 0x4040342e,
-};
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
+
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
+	 * Density per CS in Gb: 1
+	 * Chip Selects used:1
+	 * Number of Banks:8
+	 * Row address:    13
+	 * Column address: 10
+	 * Data bus width16
+	 * =============================================================================
+	 */
+
+	{0x021b001c, 0x00008000}, /*
+				   * MMDC0_MDSCR, set the Configuration request bit during
+				   * MMDC set up
+				   */
+
+	/*
+	 * =============================================================================
+	 * Calibration setup
+	 * =============================================================================
+	 */
+
+	{0x021b0800, 0xA1390003}, /*
+				   * DDR_PHY_P0_MPZQHWCTRL, enable both one-time & periodic
+				   * HW ZQ calibration.
+				   */
+
+	/*
+	 * For target board, may need to run write leveling calibration to fine tune these
+	 * settings.
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
+	 * value is 0
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
 
-static struct mx6_ddr_sysinfo ddr_sysinfo = {
-	.dsize			= 0,
-	.cs1_mirror		= 0,
-	.cs_density		= 32,
-	.ncs			= 1,
-	.bi_on			= 1,
-	.rtt_nom		= 1,
-	.rtt_wr			= 0,
-	.ralat			= 5,
-	.walat			= 1,
-	.mif3_mode		= 3,
-	.rst_to_cke		= 0x23,	/* 33 cycles (JEDEC value for DDR3) - total of 500 us */
-	.sde_to_rst		= 0x10,	/* 14 cycles (JEDEC value for DDR3) - total of 200 us */
-	.refsel			= 1,
-	.refr			= 3,
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
+					 * MMDC0_MDSCR, set the Configuration request
+					 * bit during MMDC set up
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
+					 * MMDC0_MDSCR, ZQ calibration command sent to
+					 * device on CS0
+					 */
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
+					 * MMDC0_MDSCR, clear this register
+					 * (especially the configuration bit as initialization
+					 * is complete)
+					 */
 };
 
-static struct mx6_ddr3_cfg mem_ddr = {
-	.mem_speed		= 1333,
-	.density		= 2,
-	.width			= 16,
-	.banks			= 8,
-	.rowaddr		= 13,
-	.coladdr		= 10,
-	.pagesz			= 2,
-	.trcd			= 1350,
-	.trcmin			= 4950,
-	.trasmin		= 3600,
+static struct dram_timing_info dram_timing_128mb = {
+	.ddrc_cfg = ddr_ddrc_cfg_128mb,
+	.ddrc_cfg_num = ARRAY_SIZE(ddr_ddrc_cfg_128mb),
 };
 
+static void ddr_cfg_write(const struct dram_timing_info *dram_timing_info)
+{
+	int i;
+	const struct dram_cfg_param *ddrc_cfg = dram_timing_info->ddrc_cfg;
+	const int ddrc_cfg_num = dram_timing_info->ddrc_cfg_num;
+
+	for (i = 0; i < ddrc_cfg_num; i++) {
+		debug("Writing 0x%x to register 0x%x\n", ddrc_cfg->val,
+		      ddrc_cfg->reg);
+		writel(ddrc_cfg->val, ddrc_cfg->reg);
+		ddrc_cfg++;
+	}
+}
+
+static void spl_dram_init(void)
+{
+	struct mmdc_p_regs *mmdc0 = (struct mmdc_p_regs *)MMDC_P0_BASE_ADDR;
+
+	clrbits_le32(&mmdc0->mdctl, 1 << 31);	/* clear SDE_0 */
+	clrbits_le32(&mmdc0->mdctl, 1 << 30);	/* clear SDE_1 */
+
+	ddr_cfg_write(&dram_timing_128mb);
+}
+
 static void ccgr_init(void)
 {
 	struct mxc_ccm_reg *ccm = (struct mxc_ccm_reg *)CCM_BASE_ADDR;
@@ -108,20 +247,17 @@ static void ccgr_init(void)
 	writel(0xFFFFFFFF, &ccm->CCGR6);
 }
 
-static void imx6ul_spl_dram_cfg(void)
-{
-	mx6ul_dram_iocfg(mem_ddr.width, &mx6_ddr_ioregs, &mx6_grp_ioregs);
-	mx6_dram_cfg(&ddr_sysinfo, &mx6_mmcd_calib, &mem_ddr);
-}
-
 void board_init_f(ulong dummy)
 {
 	ccgr_init();
+
+	/* DDR initialization */
+	spl_dram_init();
+
 	arch_cpu_init();
 	timer_init();
 	setup_iomux_uart();
 	preloader_console_init();
-	imx6ul_spl_dram_cfg();
 }
 
 void reset_cpu(void)
-- 
2.43.0

base-commit: eeb5ff1a468b2303efa9deb2483b5edbebb568c6
branch: bsh-202505-RAM
