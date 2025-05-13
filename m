Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41FCFC3ABC3
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 16:37:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 179A182A65;
	Tue, 13 May 2025 18:36:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="e0UPnv7v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E941982A0A; Tue, 13 May 2025 18:36:43 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5E3380AE0
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 18:36:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5fd32c133ccso3943268a12.0
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 09:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1747154199; x=1747758999;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mOnJawIyfh0nNjpgdu32csSYPrfN7WFSb67HAeUvcHI=;
 b=e0UPnv7vsJQ47ogwvZSRQI7Q+pJSEfWpBkC1/yuVQTZPWPAjI/Je79T7YdGQhGWeEy
 BpFYhaMJSbInmpfGNHMNignx5N+6vrk5HeZJOCL2JAcR+ZEtsZiaPPMcBp8XtwQL4Ktg
 0SpD0O5d1TcwbORbG6SQK1r/etUaAZnSrEMIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747154199; x=1747758999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mOnJawIyfh0nNjpgdu32csSYPrfN7WFSb67HAeUvcHI=;
 b=ND1GpiFRKSkdcxiDQaFM9bYC3V42jbiKqo8xsVTg/0c8H+fi5Oeu40sEfOTfB3p7Z7
 oMb6f18RQRFzZbOAh7QdmqkzO6KN/juXCyOC/2YlcEpyfCVKqlWu7w1Y36OoUQ53R4Pe
 Iy5wJ1Yu8WivzwPa5e7un8gCL6BoCdrYum95vfC80Iol7sSwuCAGiTON9834S2lCzGuY
 F1plld1qq0cQjqKi8+fk2doAAsUb/CY+W3tIsrBzZ9kdFtMhmwmpPaGjl7yRRwqzqT5d
 Ow8B+ZZn3k2ph/8kEMLRvSjppoZVenminNCyE2t7RQVaoo339cMtfeN9MvMPnard77rK
 Z9Dg==
X-Gm-Message-State: AOJu0Yw9U2jkotgvyBuRNsHdRRIX8+62iE8xzLnlcydwbCMVemx8y7qu
 zHVhyHDZHXIQzSrwt/THvZmkWd6BZTRQ7fxIPR+L7Iqf2dHnMJHSBgWO2qdxEOe9sHLVeqOaPd2
 NMpI=
X-Gm-Gg: ASbGncvelWmmschjJwu1VBRf3AwxVZvXhXkbqKE6f9uvgidCaA65BMbJOpyCoLKZNm5
 lk3nwNVts1oCcnwVvXsJDx0j7nYXd6DhYPYkSFmXMTBzvkL23a6Hn933GotAwGBBxm5d+LGLhXt
 Yp2/y1OiPZps+tLPPgbaJdBDUn32qJx4Q1kvqBu9kCaYTIPEajxJToyVrgR22w7tWrXt96xNvTY
 OPQBlY/s7ZsS0mKDDs4HA+03GKotEtmXQq/h2gb+wTifFA0PLlVPeO5SzuSIgFjm8J6INflF/uS
 ZiLcsIvUKK84XFlGHbA0nOE6MezYepSPFPwVmXC3utL5H5LWK9SFQeB1hAOKhTDec3S7Lo2SZgu
 TiFYI+BAkkw3ce9nub80mUikzGZPaReLnlY0b4NY3Gg==
X-Google-Smtp-Source: AGHT+IH+Dpsc9YcNQiQ2uCgF1ZIDzjSKIyxfksl9vjC1fMzLXGrE7JJoiAoOFwK3R4tyV1yuAsm9eg==
X-Received: by 2002:a17:907:720f:b0:ad2:3616:8c3d with SMTP id
 a640c23a62f3a-ad4f7150559mr26074866b.26.1747154198847; 
 Tue, 13 May 2025 09:36:38 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([46.189.28.43])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad23eafca8bsm565334966b.87.2025.05.13.09.36.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 09:36:38 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Bode <michael.bode@bshg.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Simon Holesch <simon.holesch@bshg.com>,
 Tom Rini <trini@konsulko.com>, Wolfgang Birkner <wolfgang.birkner@bshg.com>
Subject: [PATCH 3/4] board: bsh: imx6ulz_smm_m2: Add support for 512 MiB DRAM
Date: Tue, 13 May 2025 18:36:17 +0200
Message-ID: <20250513163633.1803464-3-dario.binacchi@amarulasolutions.com>
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

From: Michael Bode <michael.bode@bshg.com>

Calibration values were calculated using the NXP tool
I.MX6ULL_DDR3_Script_Aid_V0.01.xlsx

Signed-off-by: Michael Bode <michael.bode@bshg.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 board/bsh/imx6ulz_smm_m2/Makefile            |   3 +-
 board/bsh/imx6ulz_smm_m2/ddr3l_timing_512m.c | 139 +++++++++++++++++++
 board/bsh/imx6ulz_smm_m2/spl.c               |   9 +-
 board/bsh/imx6ulz_smm_m2/spl_mtypes.h        |   1 +
 4 files changed, 147 insertions(+), 5 deletions(-)
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
index 000000000000..e59247dce0a1
--- /dev/null
+++ b/board/bsh/imx6ulz_smm_m2/ddr3l_timing_512m.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "spl_mtypes.h"
+
+static const struct dram_cfg_param ddr_ddrc_cfg_512mb[] = {
+	//=============================================================================
+	// IOMUX
+	//=============================================================================
+	//DDR IO TYPE:
+	{0x020e04b4, 0x000C0000}, // IOMUXC_SW_PAD_CTL_GRP_DDR_TYPE
+	{0x020e04ac, 0x00000000}, // IOMUXC_SW_PAD_CTL_GRP_DDRPKE
+
+	//CLOCK:
+	{0x020e027c, 0x00000028}, // IOMUXC_SW_PAD_CTL_PAD_DRAM_SDCLK_0
+
+	//ADDRESS:
+	{0x020e0250, 0x00000028}, // IOMUXC_SW_PAD_CTL_PAD_DRAM_CAS
+	{0x020e024c, 0x00000028}, // IOMUXC_SW_PAD_CTL_PAD_DRAM_RAS
+	{0x020e0490, 0x00000028}, // IOMUXC_SW_PAD_CTL_GRP_ADDDS
+
+	//Control:
+	{0x020e0288, 0x000C0028}, // IOMUXC_SW_PAD_CTL_PAD_DRAM_RESET
+	{0x020e0270, 0x00000000}, // IOMUXC_SW_PAD_CTL_PAD_DRAM_SDBA2 - DSE can be configured using
+				  // Group Control Register: IOMUXC_SW_PAD_CTL_GRP_CTLDS
+	{0x020e0260, 0x00000028}, // IOMUXC_SW_PAD_CTL_PAD_DRAM_SDODT0
+	{0x020e0264, 0x00000028}, // IOMUXC_SW_PAD_CTL_PAD_DRAM_SDODT1
+	{0x020e04a0, 0x00000028}, // IOMUXC_SW_PAD_CTL_GRP_CTLDS
+
+	//Data Strobes:
+	{0x020e0494, 0x00020000}, // IOMUXC_SW_PAD_CTL_GRP_DDRMODE_CTL
+	{0x020e0280, 0x00000028}, // IOMUXC_SW_PAD_CTL_PAD_DRAM_SDQS0
+	{0x020e0284, 0x00000028}, // IOMUXC_SW_PAD_CTL_PAD_DRAM_SDQS1
+
+	//Data:
+	{0x020e04b0, 0x00020000}, // IOMUXC_SW_PAD_CTL_GRP_DDRMODE
+	{0x020e0498, 0x00000028}, // IOMUXC_SW_PAD_CTL_GRP_B0DS
+	{0x020e04a4, 0x00000028}, // IOMUXC_SW_PAD_CTL_GRP_B1DS
+
+	{0x020e0244, 0x00000028}, // IOMUXC_SW_PAD_CTL_PAD_DRAM_DQM0
+	{0x020e0248, 0x00000028}, // IOMUXC_SW_PAD_CTL_PAD_DRAM_DQM1
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
+	{0x021b001c, 0x00008000}, // MMDC0_MDSCR, set the Configuration request bit during
+				  // MMDC set up
+
+	//=============================================================================
+	// Calibration setup.
+	//=============================================================================
+	{0x021b0800, 0xA1390003}, // DDR_PHY_P0_MPZQHWCTRL, enable both one-time & periodic
+				  // HW ZQ calibration.
+
+	// For target board may need to run write leveling calibration to fine tune these settings.
+	{0x021b080c, 0x00000000}, //
+
+	//Read DQS Gating calibration
+	{0x021b083c, 0x01440140}, // MPDGCTRL0 PHY0
+
+	//Read calibration
+	{0x021b0848, 0x40403A3E}, // MPRDDLCTL PHY0
+
+	//Write calibration
+	{0x021b0850, 0x4040322A}, // MPWRDLCTL PHY0
+
+	//read data bit delay: 3 is the reccommended default value, although out of reset value is 0
+	{0x021b081c, 0x33333333}, // MMDC_MPRDDQBY0DL
+	{0x021b0820, 0x33333333}, // MMDC_MPRDDQBY1DL
+
+	//write data bit delay:
+	{0x021b082c, 0xF3333333}, // MMDC_MPWRDQBY0DL
+	{0x021b0830, 0xF3333333}, // MMDC_MPWRDQBY1DL
+
+	//DQS&CLK Duty Cycle
+	{0x021b08c0, 0x00944009}, // [MMDC_MPDCCR] MMDC Duty Cycle Control Register
+
+	// Complete calibration by forced measurement:
+	{0x021b08b8, 0x00000800}, // DDR_PHY_P0_MPMUR0, frc_msr
+	//=============================================================================
+	// Calibration setup end
+	//=============================================================================
+
+	//MMDC init:
+	{0x021b0004, 0x0002002D}, // MMDC0_MDPDC
+	{0x021b0008, 0x1B333030}, // MMDC0_MDOTC
+	{0x021b000c, 0x3F435333}, // MMDC0_MDCFG0
+	{0x021b0010, 0xB68E0B63}, // MMDC0_MDCFG1
+	{0x021b0014, 0x01FF00DB}, // MMDC0_MDCFG2
+
+	//MDMISC: RALAT kept to the high level of 5.
+	//MDMISC: consider reducing RALAT if your 528MHz board design allow that.
+	//Lower RALAT benefits:
+	//a. better operation at low frequency, for LPDDR2 freq < 100MHz, change RALAT to 3
+	//b. Small performence improvment
+	{0x021b0018, 0x00211740}, // MMDC0_MDMISC
+	{0x021b001c, 0x00008000}, // MMDC0_MDSCR set the Configuration request bit during
+				  // MMDC set up
+	{0x021b002c, 0x000026D2}, // MMDC0_MDRWD
+	{0x021b0030, 0x00431023}, // MMDC0_MDOR
+	{0x021b0040, 0x0000004F}, // Chan0 CS0_END
+	{0x021b0000, 0x84180000}, // MMDC0_MDCTL
+
+	{0x021b0890, 0x00400000}, // MPPDCMPR2
+
+	//Mode register writes
+	{0x021b001c, 0x02808032}, // MMDC0_MDSCR, MR2 write, CS0
+	{0x021b001c, 0x00008033}, // MMDC0_MDSCR, MR3 write, CS0
+	{0x021b001c, 0x00048031}, // MMDC0_MDSCR, MR1 write, CS0
+	{0x021b001c, 0x15208030}, // MMDC0_MDSCR, MR0write, CS0
+	{0x021b001c, 0x04008040}, // MMDC0_MDSCR, ZQ calibration command sent to device on CS0
+
+	{0x021b0020, 0x00007800}, // MMDC0_MDREF
+
+	{0x021b0818, 0x00000227}, // DDR_PHY_P0_MPODTCTRL
+
+	{0x021b0004, 0x0002552D}, // MMDC0_MDPDC now SDCTL power down enabled
+
+	{0x021b0404, 0x00011006}, // MMDC0_MAPSR ADOPT power down enabled, MMDC will enter
+				  // automatically to self-refresh while the number of idle
+				  // cycle reached.
+
+	{0x021b001c, 0x00000000}, // MMDC0_MDSCR, clear this register (especially the
+				  // configuration bit as initialization is complete)
+};
+
+struct dram_timing_info bsh_dram_timing_512mb = {
+	.ddrc_cfg = ddr_ddrc_cfg_512mb,
+	.ddrc_cfg_num = ARRAY_SIZE(ddr_ddrc_cfg_512mb),
+};
diff --git a/board/bsh/imx6ulz_smm_m2/spl.c b/board/bsh/imx6ulz_smm_m2/spl.c
index 3b3b295d9ca7..dba5982d0865 100644
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
index f8dba6fb13f1..0d79b9758f31 100644
--- a/board/bsh/imx6ulz_smm_m2/spl_mtypes.h
+++ b/board/bsh/imx6ulz_smm_m2/spl_mtypes.h
@@ -20,6 +20,7 @@ struct dram_timing_info {
 	unsigned int ddrc_cfg_num;
 };
 
+extern struct dram_timing_info bsh_dram_timing_512mb;
 extern struct dram_timing_info bsh_dram_timing_256mb;
 extern struct dram_timing_info bsh_dram_timing_128mb;
 
-- 
2.43.0

base-commit: cf37480bc8335494cf88b7180dc3f1eb8cf63a9d
branch: bsh-202505-RAM
