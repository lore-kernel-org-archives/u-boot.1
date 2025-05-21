Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3B0C2D0CD
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 09:47:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5BF182E37;
	Wed, 21 May 2025 11:47:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="C1KvLZTr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 488F582E66; Wed, 21 May 2025 11:47:41 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBAD282E0A
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 11:47:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-602039559d8so4284123a12.1
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 02:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1747820858; x=1748425658;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3une2V6O+TFBaqW3IKrvVv3z+OFvXFBRIvL2GNzhxTM=;
 b=C1KvLZTrNTFRsuG3hFdd9DmFinW8FG1t9PzDoKjO6QSFAZ/vFSHWznylDDgU0o68Eu
 cMTQu8k/XMkbMEF9xfw0wP1AL6nOTEwkPfTnQy6Nh+3i79PCe7H27q4q+aJ7sJNPgX7q
 4i9IWKkF3UY6LsSE/6k6Vb0LAl6l/eCL3E1O8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747820858; x=1748425658;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3une2V6O+TFBaqW3IKrvVv3z+OFvXFBRIvL2GNzhxTM=;
 b=qQ/Igp4v8A3okWM3/m0byhzCoULq52Dt78O/iXbikMVXj1yty9CGI9pCSC6WQ+hVvS
 7IMnjrPcV/zL+VbwJk+Y81idlah0oLftXMA2q5vVjkBi0juj9oW3aYZzftRV6gv9wh6i
 kHjmjyh6I9KGNtP7vYUw1QmC6ufmLxPWYlVj35WL+mDv4SL+KtfI5vRLvCsg0WMMrFlt
 Pe6V8OL9tzhOgm+YyhIYTWQlXHsOuVo3KsF+0icOdlZBTIFoDF0vU9whKYlwD+3A47De
 /7XXpIE4oGA0sT0WFLtlS8HoVcEsAUGA/vC+UgJF+lDitpZZCwrWb2Kxlkob6ZndRv+9
 NISg==
X-Gm-Message-State: AOJu0Ywu1rkgGQ79YazD0/HeOAulyU7sRRqjV0kzFQdGA8ZIC3na2lEe
 +uGTm6wkimY7fIroHcIUbzrJbs4qqmW5M5BS4/5K3TMd2Vurqz1hEgF1XKeAqGhW3UvFt2PXsUs
 1yi5o
X-Gm-Gg: ASbGncu9vfATcbVGqZ6G9hY/ZiM3K9SjWzSmcDHuo1do5Wo+XlAJGAF+uRbV+L8apmo
 qcMK9Z1++uUKwUJhHJQFmlJ76DSIKCpcZZPy7pvHMK7rqBbqNKm6dgrQWavs20F5i+AYhfiZCQu
 2U/QcruRnEd8paf09XR/GEKK5Me9iMqunVgPX25f8ebd3mHIjhyZzic52omr3KjyQocsOMH12j+
 IMQBeZV8ZXn4DDK74qD0Ct+drOF0YuOLxtQvwYRIRl/YDImNN5amgbTTqAG5Dllmd3p/HqTRMmc
 0dreDvukMO39063e+N/VzPixEVXFGH+n+1i/TxhYUB5b5wck39PEEl8FEwMuwFb8he5MK/1uCw6
 GD1WeVTeZjG8y
X-Google-Smtp-Source: AGHT+IHtiHv470IcNz6qpIS8x6GSsEB57V2yYgIYTgRDcN1tRip66RtTxB5S551wDNmWmGiyHdZHNQ==
X-Received: by 2002:a17:906:9fc8:b0:ad5:b09:115e with SMTP id
 a640c23a62f3a-ad536b81936mr1679202566b.18.1747820857767; 
 Wed, 21 May 2025 02:47:37 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:cfc5:5070:d6f4:1d86])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d06b497sm863951166b.42.2025.05.21.02.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 02:47:37 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: michael@amarulasolutions.com, Simon Holesch <simon.holesch@bshg.com>,
 linux-amarula@amarulasolutions.com, Michael Bode <michael.bode@bshg.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Wolfgang Birkner <wolfgang.birkner@bshg.com>
Subject: [PATCH v3 1/4] board: bsh: imx6ulz_smm_m2: Match SPL DDR settings to
 DCD table
Date: Wed, 21 May 2025 11:47:29 +0200
Message-ID: <20250521094735.1037146-1-dario.binacchi@amarulasolutions.com>
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

Changes in v3:
- Drop changes on arch/arm/include/asm/arch-mx6/mx6-ddr.h and
  arch/arm/mach-imx/mx6/ddr.c files. They are not needed.

Changes in v2:
- Add 'static struct' globally in the module where the definitions
  can mabe static.
- Use standard C comment style

 board/bsh/imx6ulz_smm_m2/spl.c | 260 +++++++++++++++++++++++++--------
 1 file changed, 198 insertions(+), 62 deletions(-)

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

base-commit: a3e09b24ffd4429909604f1b28455b44306edbaa
branch: bsh-202505-RAM
