Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC529CCFA05
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 13:10:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D4D383BCF;
	Thu,  6 Nov 2025 14:09:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="PSmyqyV6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEEE583B47; Thu,  6 Nov 2025 08:46:43 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F6D983B48
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 08:46:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=andrea.calabrese@amarulasolutions.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b7200568b13so116613666b.1
 for <u-boot@lists.denx.de>; Wed, 05 Nov 2025 23:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1762415201; x=1763020001;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IWPDVk+6tb/NVQYUY2CZdS13eWmO6PEVQuLiy6MdQmQ=;
 b=PSmyqyV6CJT2+3woVj3uE6DVc3Uvfsc8QFWGrp+vGUBL/cHlFiCURoDV88jou5aZyf
 PuI3zFGZSSHJ4lUrA4akNA0r0R1gYhC9nL/VIe3fOEnIEnGgByguCfWZ8/wxOo9Kpbkj
 BT8n8qFJnXb/0vmumUoP7gSSUKP9yy4f9S3Fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762415201; x=1763020001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IWPDVk+6tb/NVQYUY2CZdS13eWmO6PEVQuLiy6MdQmQ=;
 b=ebEcnG+kwuF9L0q3unq6QhatO+IP7RNiusbik/KIx3mYdcG1xmPmI9+qOWY1AGQ85G
 /0c6cTAuiTY7t+vWro2gSGJSN0vUrGhtz1TpH2EayTr5qEvpTfwyER9HvJWhCEQYbbGv
 rHfXZDE0W7dwntBJWfL8+Nbsrm8VREgu5kuFBB615GgjYq8LCSKVH/wyB8fpwv8aSa+b
 KoUN2ACH+oUDKE1JlbUjZNmWtYezBBYtnSuPasEn5y6AjOlV4ZPTBZt+oxdaq/yxGhEi
 MyPeGmzEPgrsh5hbeWy/f/MBjTJSI/1dUAQiGEn5nT42s6ocBvWwQ1Orj8jkQEH9+ojI
 GDpg==
X-Gm-Message-State: AOJu0YyunqAGGVWvUszZs0f2OE/xnCRm1JTSd5ra8QDf6bM9i/j/2G0w
 3K/xcmMGkARckw6Dr+tv77C0SFwIhiUCtVkNZC+RV+Jx/ZwdU61Dn7RiABmNfXTVHugEHF+BCxD
 yyMw3klftNg==
X-Gm-Gg: ASbGncsJj/WN2NsfNWo3dx8/cWwdTYVhS4/C7/BJniTg8w+/pnoBOSABtqniLmdDkwV
 qblNwYi8km6gG/KXxOo9Vc1BUDEkdutLOf1ttTm3D0ImteXnW2EsYCAEfK493gmaUd4rHI3JPdH
 vtCPJYyUzD/E6Pc+v9LXt5EdAjR+VdqlR+mNxxNGrjFVeGp5rFRNNFOxVGzztv9IyXZPTGBgVcw
 ygHwKAKgd2MqIQpO7/nINJjrIDYEBrgsNJg9Hitq75JO5UCrJWKVkfd/O6wKueub62l40iIeX+T
 98Vcrh/6jpeeQ4G9dxUfhioa06rDWDKmyaYN3qqEsCGj5OjYiYCgi5UnWD/vf0zdipSg1Qzc04V
 y2uagi6GLYaqOyS37K9wcANmLZRaQPkNgl3bsaR0OfyH/dOimaiT4P4QoGg8+e3F3RsNooXZtf4
 ok23DGiCYw+fqBwV20/XAh2ZTPZdYPdewCto/y0gpvUg8HUSbU072uqeofJ4V5tfmlH+c=
X-Google-Smtp-Source: AGHT+IEHilurfqa/UnMGSZ7mS3Qhq4jbryiBDwzCpbF7kgGeVmXCtQKw+IFEstUxqt4szixePECwyg==
X-Received: by 2002:a17:907:96a0:b0:b70:cf3f:7fbc with SMTP id
 a640c23a62f3a-b72656cf18bmr613052466b.65.1762415200565; 
 Wed, 05 Nov 2025 23:46:40 -0800 (PST)
Received: from andrea-amarula.home (98-215-98-95.ftth.glasoperator.nl.
 [95.98.215.98]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72896837fesm149465966b.62.2025.11.05.23.46.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 23:46:40 -0800 (PST)
From: Andrea Calabrese <andrea.calabrese@amarulasolutions.com>
To: u-boot@lists.denx.de, michael@amarulasolutions.com,
 dario.binacchi@amarulasolutions.com, trini@konsulko.com, festevam@gmail.com
Cc: andrea.calabrese@amarulasolutions.com
Subject: [PATCH 2/2] bsh: add support for imx6ulz_smm_m2d
Date: Thu,  6 Nov 2025 08:46:32 +0100
Message-ID: <20251106074632.244150-2-andrea.calabrese@amarulasolutions.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251106074632.244150-1-andrea.calabrese@amarulasolutions.com>
References: <20251106074632.244150-1-andrea.calabrese@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Nov 2025 14:09:26 +0100
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

Add support for imx6ulz_smm_m2d, based on the M2 architecture.

Signed-off-by: Andrea Calabrese <andrea.calabrese@amarulasolutions.com>

diff --git a/board/bsh/imx6ulz_smm_m2/Kconfig b/board/bsh/imx6ulz_smm_m2/Kconfig
index 20971aa4fe1..6c4321c3b5e 100644
--- a/board/bsh/imx6ulz_smm_m2/Kconfig
+++ b/board/bsh/imx6ulz_smm_m2/Kconfig
@@ -28,6 +28,12 @@ config BSH_M2B_MEMORY
 	  If this option is enabled, U-Boot will be configured to support
 	  imx6ulz bsh m2b revision memories.
 
+config BSH_M2D_MEMORY
+	bool "Enable for bsh m2d variant"
+	help
+	  If this option is enabled, U-Boot will be configured to support
+	  imx6ulz bsh m2d revision memories.
+
 endchoice
 
 endif
diff --git a/board/bsh/imx6ulz_smm_m2/MAINTAINERS b/board/bsh/imx6ulz_smm_m2/MAINTAINERS
index a75cddd72f8..098b992b07a 100644
--- a/board/bsh/imx6ulz_smm_m2/MAINTAINERS
+++ b/board/bsh/imx6ulz_smm_m2/MAINTAINERS
@@ -5,3 +5,4 @@ F:	board/bsh/imx6ulz_smm_m2/
 F:	include/configs/imx6ulz_smm_m2.h
 F:	configs/imx6ulz_smm_m2_defconfig
 F:	configs/imx6ulz_smm_m2b_defconfig
+F:	configs/imx6ulz_smm_m2d_defconfig
diff --git a/board/bsh/imx6ulz_smm_m2/Makefile b/board/bsh/imx6ulz_smm_m2/Makefile
index 5ab00a5ea75..81e47e3735e 100644
--- a/board/bsh/imx6ulz_smm_m2/Makefile
+++ b/board/bsh/imx6ulz_smm_m2/Makefile
@@ -5,3 +5,4 @@ obj-y  := imx6ulz_smm_m2.o
 obj-$(CONFIG_XPL_BUILD) += spl.o
 obj-$(CONFIG_BSH_M2_MEMORY) += ddr3l_timing_512m.o ddr3l_timing_256m.o ddr3l_timing_128m.o
 obj-$(CONFIG_BSH_M2B_MEMORY) += ddr3l_timing_512m_m2b.o ddr3l_timing_256m_m2b.o ddr3l_timing_128m_m2b.o
+obj-$(CONFIG_BSH_M2D_MEMORY) += ddr3l_timing_512m_m2d.o ddr3l_timing_256m_m2d.o ddr3l_timing_128m_m2d.o
\ No newline at end of file
diff --git a/board/bsh/imx6ulz_smm_m2/ddr3l_timing_128m_m2d.c b/board/bsh/imx6ulz_smm_m2/ddr3l_timing_128m_m2d.c
new file mode 100644
index 00000000000..5910858a930
--- /dev/null
+++ b/board/bsh/imx6ulz_smm_m2/ddr3l_timing_128m_m2d.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "spl_mtypes.h"
+
+static const struct dram_cfg_param ddr_ddrc_cfg_128mb[] = {
+	/*  IOMUX */
+
+	/* DDR IO TYPE: */
+	{0x020E04B4, 0x000C0000}, /*  IOMUXC_SW_PAD_CTL_GRP_DDR_TYPE */
+	{0x020E04AC, 0x00000000}, /*  IOMUXC_SW_PAD_CTL_GRP_DDRPKE */
+
+	/* CLOCK: */
+	{0x020E027C, 0x00000028}, /*  IOMUXC_SW_PAD_CTL_PAD_DRAM_SDCLK0_P */
+
+	/* Control: */
+	{0x020E0250, 0x00000028}, /*  IOMUXC_SW_PAD_CTL_PAD_DRAM_CAS */
+	{0x020E024C, 0x00000028}, /*  IOMUXC_SW_PAD_CTL_PAD_DRAM_RAS */
+	{0x020E0490, 0x00000028}, /*  IOMUXC_SW_PAD_CTL_GRP_ADDDS */
+	{0x020E0288, 0x000C0028}, /*  IOMUXC_SW_PAD_CTL_PAD_DRAM_RESET */
+	{0x020E0270, 0x00000000}, /*  IOMUXC_SW_PAD_CTL_PAD_DRAM_SDBA2 - DSE can be configured */
+				  /*  using Group Control Register: IOMUXC_SW_PAD_CTL_GRP_CTLDS */
+	{0x020E0260, 0x00000028}, /*  IOMUXC_SW_PAD_CTL_PAD_DRAM_ODT0 */
+	{0x020E0264, 0x00000028}, /*  IOMUXC_SW_PAD_CTL_PAD_DRAM_ODT1 */
+	{0x020E04A0, 0x00000028}, /*  IOMUXC_SW_PAD_CTL_GRP_CTLDS */
+
+	/* Data Strobes: */
+	{0x020E0494, 0x00020000}, /*  IOMUXC_SW_PAD_CTL_GRP_DDRMODE_CTL */
+	{0x020E0280, 0x00000028}, /*  IOMUXC_SW_PAD_CTL_PAD_DRAM_SDQS0_P */
+	{0x020E0284, 0x00000028}, /*  IOMUXC_SW_PAD_CTL_PAD_DRAM_SDQS1_P */
+
+	/* Data: */
+	{0x020E04B0, 0x00020000}, /*  IOMUXC_SW_PAD_CTL_GRP_DDRMODE */
+	{0x020E0498, 0x00000028}, /*  IOMUXC_SW_PAD_CTL_GRP_B0DS */
+	{0x020E04A4, 0x00000028}, /*  IOMUXC_SW_PAD_CTL_GRP_B1DS */
+	{0x020E0244, 0x00000028}, /*  IOMUXC_SW_PAD_CTL_PAD_DRAM_DQM0 */
+	{0x020E0248, 0x00000028}, /*  IOMUXC_SW_PAD_CTL_PAD_DRAM_DQM1 */
+
+	/* ============================================================================= */
+	/*  DDR Controller Registers */
+	/* ============================================================================= */
+	/*  Manufacturer:WINBOND */
+	/*  Device Part Number:W631GU6RB-11 */
+	/*  Clock Freq.: 400MHz */
+	/*  Density per CS in Gb: 1 */
+	/*  Chip Selects used:1 */
+	/*  Total DRAM density (Gb)1 */
+	/*  Number of Banks:8 */
+	/*  Row address:    13 */
+	/*  Column address: 10 */
+	/*  Data bus width16 */
+	/* ============================================================================= */
+	{0x021B001C, 0x00008000}, /*  [MMDC_MDSCR] MMDC Core Special Command Register */
+
+	/* ====================================================== */
+	/* Calibrations: */
+	/* ====================================================== */
+	{0x021B0800, 0xA1390003}, /*  DDR_PHY_P0_MPZQHWCTRL, enable both one-time & periodic */
+				  /*  HW ZQ calibration. */
+
+	{0x021B080C, 0x00060002}, /*  [MMDC_MPWLDECTRL0] MMDC PHY Write Leveling Delay Control */
+				  /*  Register 0 */
+	{0x021B083C, 0x414C0150}, /*  [MMDC_MPDGCTRL0] MMDC PHY Read DQS Gating Control */
+				  /*  Register 0 */
+	{0x021B0848, 0x4040363E}, /*  [MMDC_MPRDDLCTL] MMDC PHY Read delay-lines Configuration */
+				  /*  Register */
+	{0x021B0850, 0x40402A28}, /*  [MMDC_MPWRDLCTL] MMDC PHY Write delay-lines Configuration */
+				  /*  Register */
+
+	{0x021B081C, 0x33333333}, /*  [MMDC_MPRDDQBY0DL] MMDC PHY Read DQ Byte0 Delay Register */
+	{0x021B0820, 0x33333333}, /*  [MMDC_MPRDDQBY1DL] MMDC PHY Read DQ Byte1 Delay Register */
+
+	{0x021B082C, 0xf3333333}, /*  [MMDC_MPWRDQBY0DL] MMDC PHY Write DQ Byte0 Delay Register */
+	{0x021B0830, 0xf3333333}, /*  [MMDC_MPWRDQBY1DL] MMDC PHY Write DQ Byte1 Delay Register */
+
+	{0x021B08C0, 0x00944009}, /*  [MMDC_MPDCCR] MMDC Duty Cycle Control Register */
+
+	/*  Complete calibration by forced measurement: */
+	{0x021B08B8, 0x00000800}, /*  DDR_PHY_P0_MPMUR0, frc_msr */
+
+	/* ====================================================== */
+	/* MMDC init: */
+	/* ====================================================== */
+	{0x021B0004, 0x0002002D}, /*  MMDC0_MDPDC */
+	{0x021B0008, 0x1B333030}, /*  MMDC0_MDOTC */
+	{0x021B000C, 0x2B2F52F3}, /*  MMDC0_MDCFG0 */
+	{0x021B0010, 0xB66D0A63}, /*  MMDC0_MDCFG1 */
+	{0x021B0014, 0x01FF00DB}, /*  MMDC0_MDCFG2 */
+	{0x021B0018, 0x00201740}, /*  MMDC0_MDMISC */
+	{0x021B002C, 0x000026D2}, /*  MMDC0_MDRWD; recommend to maintain the default values */
+	{0x021B0030, 0x002F1023}, /*  MMDC0_MDOR */
+	{0x021B0040, 0x00000043}, /*  CS0_END */
+	{0x021B0000, 0x82180000}, /*  MMDC0_MDCTL */
+
+	/*  Mode register writes for CS0 */
+	{0x021B001C, 0x02808032}, /*  MMDC0_MDSCR, MR2 write, CS0 */
+	{0x021B001C, 0x00008033}, /*  MMDC0_MDSCR, MR3 write, CS0 */
+	{0x021B001C, 0x00048031}, /*  MMDC0_MDSCR, MR1 write, CS0 */
+	{0x021B001C, 0x15208030}, /*  MMDC0_MDSCR, MR0 write, CS0 */
+	{0x021B001C, 0x04008040}, /*  MMDC0_MDSCR, ZQ calibration command sent to device on CS0 */
+
+	/*  Mode register writes for CS, commented out automatically if only one chip select used */
+	/*     {0x021B001C, 0x0200803A},  */
+	/*     {0x021B001C, 0x0000803B},  */
+	/*     {0x021B001C, 0x00048039},  */
+	/*     {0x021B001C, 0x15208038},  */
+	/*     {0x021B001C, 0x04008048},  */
+
+	/*  final DDR setup, before operation start: */
+	{0x021B0020, 0x00000800}, /*  MMDC0_MDREF */
+	{0x021B0818, 0x00000227}, /*  DDR_PHY_P0_MPODTCTRL */
+	{0x021B0004, 0x0002556D}, /*  MMDC0_MDPDC now SDCTL power down enabled */
+	{0x021B0404, 0x00011006}, /*  MMDC0_MAPSR ADOPT power down enabled */
+	{0x021B001C, 0x00000000}, /*  MMDC0_MDSCR, clear this register (especially the */
+				  /*  configuration bit as initialization is complete) */
+};
+
+struct dram_timing_info bsh_dram_timing_128mb = {
+	.ddrc_cfg = ddr_ddrc_cfg_128mb,
+	.ddrc_cfg_num = ARRAY_SIZE(ddr_ddrc_cfg_128mb),
+	.dram_size = SZ_128M,
+};
diff --git a/board/bsh/imx6ulz_smm_m2/ddr3l_timing_256m_m2d.c b/board/bsh/imx6ulz_smm_m2/ddr3l_timing_256m_m2d.c
new file mode 100644
index 00000000000..e9f24f5afbb
--- /dev/null
+++ b/board/bsh/imx6ulz_smm_m2/ddr3l_timing_256m_m2d.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "spl_mtypes.h"
+
+static const struct dram_cfg_param ddr_ddrc_cfg_256mb[] = {
+	/*  IOMUX */
+
+	/* DDR IO TYPE: */
+	{0x020E04B4, 0x000C0000}, /*  IOMUXC_SW_PAD_CTL_GRP_DDR_TYPE */
+	{0x020E04AC, 0x00000000}, /*  IOMUXC_SW_PAD_CTL_GRP_DDRPKE */
+
+	/* CLOCK: */
+	{0x020E027C, 0x00000030}, /*  IOMUXC_SW_PAD_CTL_PAD_DRAM_SDCLK0_P */
+
+	/* Control: */
+	{0x020E0250, 0x00000030}, /*  IOMUXC_SW_PAD_CTL_PAD_DRAM_CAS */
+	{0x020E024C, 0x00000030}, /*  IOMUXC_SW_PAD_CTL_PAD_DRAM_RAS */
+	{0x020E0490, 0x00000030}, /*  IOMUXC_SW_PAD_CTL_GRP_ADDDS */
+	{0x020E0288, 0x000C0030}, /*  IOMUXC_SW_PAD_CTL_PAD_DRAM_RESET */
+	{0x020E0270, 0x00000000}, /*  IOMUXC_SW_PAD_CTL_PAD_DRAM_SDBA2 - DSE can be configured */
+				  /*  using Group Control Register: IOMUXC_SW_PAD_CTL_GRP_CTLDS */
+	{0x020E0260, 0x00000030}, /*  IOMUXC_SW_PAD_CTL_PAD_DRAM_ODT0 */
+	{0x020E0264, 0x00000030}, /*  IOMUXC_SW_PAD_CTL_PAD_DRAM_ODT1 */
+	{0x020E04A0, 0x00000028}, /*  IOMUXC_SW_PAD_CTL_GRP_CTLDS */
+
+	/* Data Strobes: */
+	{0x020E0494, 0x00020000}, /*  IOMUXC_SW_PAD_CTL_GRP_DDRMODE_CTL */
+	{0x020E0280, 0x00000030}, /*  IOMUXC_SW_PAD_CTL_PAD_DRAM_SDQS0_P */
+	{0x020E0284, 0x00000030}, /*  IOMUXC_SW_PAD_CTL_PAD_DRAM_SDQS1_P */
+
+	/* Data: */
+	{0x020E04B0, 0x00020000}, /*  IOMUXC_SW_PAD_CTL_GRP_DDRMODE */
+	{0x020E0498, 0x00000030}, /*  IOMUXC_SW_PAD_CTL_GRP_B0DS */
+	{0x020E04A4, 0x00000030}, /*  IOMUXC_SW_PAD_CTL_GRP_B1DS */
+	{0x020E0244, 0x00000030}, /*  IOMUXC_SW_PAD_CTL_PAD_DRAM_DQM0 */
+	{0x020E0248, 0x00000030}, /*  IOMUXC_SW_PAD_CTL_PAD_DRAM_DQM1 */
+
+	/* ============================================================================= */
+	/*  DDR Controller Registers */
+	/* ============================================================================= */
+	/*  Manufacturer:WINBOND */
+	/*  Device Part Number:W632GU6RB-11 */
+	/*  Clock Freq.: 400MHz */
+	/*  Density per CS in Gb: 2 */
+	/*  Chip Selects used:1 */
+	/*  Total DRAM density (Gb)2 */
+	/*  Number of Banks:8 */
+	/*  Row address:    14 */
+	/*  Column address: 10 */
+	/*  Data bus width16 */
+	/* ============================================================================= */
+	{0x021B001C, 0x00008000}, /*  [MMDC_MDSCR] MMDC Core Special Command Register */
+
+	/* ====================================================== */
+	/* Calibrations: */
+	/* ====================================================== */
+	{0x021B0800, 0xA1390003}, /*  DDR_PHY_P0_MPZQHWCTRL, enable both one-time & periodic */
+				  /*  HW ZQ calibration. */
+
+	{0x021B080C, 0x00070005}, /*  [MMDC_MPWLDECTRL0] MMDC PHY Write Leveling Delay Control */
+				  /*  Register 0 */
+	{0x021B083C, 0x414C0150}, /*  [MMDC_MPDGCTRL0] MMDC PHY Read DQS Gating Control */
+				  /* Register 0 */
+	{0x021B0848, 0x4040383E}, /*  [MMDC_MPRDDLCTL] MMDC PHY Read delay-lines Configuration */
+				  /*  Register */
+	{0x021B0850, 0x40402E2A}, /*  [MMDC_MPWRDLCTL] MMDC PHY Write delay-lines Configuration */
+				  /*  Register */
+
+	{0x021B081C, 0x33333333}, /*  [MMDC_MPRDDQBY0DL] MMDC PHY Read DQ Byte0 Delay Register */
+	{0x021B0820, 0x33333333}, /*  [MMDC_MPRDDQBY1DL] MMDC PHY Read DQ Byte1 Delay Register */
+
+	{0x021B082C, 0xf3333333}, /*  [MMDC_MPWRDQBY0DL] MMDC PHY Write DQ Byte0 Delay Register */
+	{0x021B0830, 0xf3333333}, /*  [MMDC_MPWRDQBY1DL] MMDC PHY Write DQ Byte1 Delay Register */
+
+	{0x021B08C0, 0x00944009}, /*  [MMDC_MPDCCR] MMDC Duty Cycle Control Register */
+
+	/*  Complete calibration by forced measurement: */
+	{0x021B08B8, 0x00000800}, /*  DDR_PHY_P0_MPMUR0, frc_msr */
+
+	/* ====================================================== */
+	/* MMDC init: */
+	/* ====================================================== */
+	{0x021B0004, 0x00020024}, /*  MMDC0_MDPDC */
+	{0x021B0008, 0x1B333030}, /*  MMDC0_MDOTC */
+	{0x021B000C, 0x3F4352D3}, /*  MMDC0_MDCFG0 */
+	{0x021B0010, 0xB66D0A63}, /*  MMDC0_MDCFG1 */
+	{0x021B0014, 0x01FF00DB}, /*  MMDC0_MDCFG2 */
+	{0x021B0018, 0x00201740}, /*  MMDC0_MDMISC */
+	{0x021B002C, 0x000026D2}, /*  MMDC0_MDRWD; recommend to maintain the default values */
+	{0x021B0030, 0x00431023}, /*  MMDC0_MDOR */
+	{0x021B0040, 0x00000047}, /*  CS0_END */
+	{0x021B0000, 0x83180000}, /*  MMDC0_MDCTL */
+
+	/*  Mode register writes for CS0 */
+	{0x021B001C, 0x02808032}, /*  MMDC0_MDSCR, MR2 write, CS0 */
+	{0x021B001C, 0x00008033}, /*  MMDC0_MDSCR, MR3 write, CS0 */
+	{0x021B001C, 0x00048031}, /*  MMDC0_MDSCR, MR1 write, CS0 */
+	{0x021B001C, 0x15208030}, /*  MMDC0_MDSCR, MR0 write, CS0 */
+	{0x021B001C, 0x04008040}, /*  MMDC0_MDSCR, ZQ calibration command sent to device on CS0 */
+
+	/*  Mode register writes for CS, commented out automatically */
+	/*  if only one chip select used */
+	/*     {0x021B001C, 0x0200803A},  */
+	/*     {0x021B001C, 0x0000803B},  */
+	/*     {0x021B001C, 0x00048039},  */
+	/*     {0x021B001C, 0x15208038},  */
+	/*     {0x021B001C, 0x04008048},  */
+
+	/*  final DDR setup, before operation start: */
+	{0x021B0020, 0x00000800}, /*  MMDC0_MDREF */
+	{0x021B0818, 0x00000227}, /*  DDR_PHY_P0_MPODTCTRL */
+	{0x021B0004, 0x00025564}, /*  MMDC0_MDPDC now SDCTL power down enabled */
+	{0x021B0404, 0x00011006}, /*  MMDC0_MAPSR ADOPT power down enabled */
+	{0x021B001C, 0x00000000}, /*  MMDC0_MDSCR, clear this register (especially the  */
+				  /*  configuration bit as initialization is complete) */
+};
+
+struct dram_timing_info bsh_dram_timing_256mb = {
+	.ddrc_cfg = ddr_ddrc_cfg_256mb,
+	.ddrc_cfg_num = ARRAY_SIZE(ddr_ddrc_cfg_256mb),
+	.dram_size = SZ_256M,
+};
diff --git a/board/bsh/imx6ulz_smm_m2/ddr3l_timing_512m_m2d.c b/board/bsh/imx6ulz_smm_m2/ddr3l_timing_512m_m2d.c
new file mode 100644
index 00000000000..e767f9ed641
--- /dev/null
+++ b/board/bsh/imx6ulz_smm_m2/ddr3l_timing_512m_m2d.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "spl_mtypes.h"
+
+static const struct dram_cfg_param ddr_ddrc_cfg_512mb[] = {
+	/* ============================================================================= */
+	/*  IOMUX */
+	/* ============================================================================= */
+	/* DDR IO TYPE: */
+	{0x020E04B4, 0x000C0000}, /*  IOMUXC_SW_PAD_CTL_GRP_DDR_TYPE */
+	{0x020E04AC, 0x00000000}, /*  IOMUXC_SW_PAD_CTL_GRP_DDRPKE */
+
+	/* CLOCK: */
+	{0x020E027C, 0x00000030}, /*  IOMUXC_SW_PAD_CTL_PAD_DRAM_SDCLK0_P */
+
+	/* Control: */
+	{0x020E0250, 0x00000030}, /*  IOMUXC_SW_PAD_CTL_PAD_DRAM_CAS */
+	{0x020E024C, 0x00000030}, /*  IOMUXC_SW_PAD_CTL_PAD_DRAM_RAS */
+	{0x020E0490, 0x00000030}, /*  IOMUXC_SW_PAD_CTL_GRP_ADDDS */
+	{0x020E0288, 0x000C0030}, /*  IOMUXC_SW_PAD_CTL_PAD_DRAM_RESET */
+	{0x020E0270, 0x00000000}, /*  IOMUXC_SW_PAD_CTL_PAD_DRAM_SDBA2 */
+				/* DSE can be configured using Group Control Register: */
+				/* IOMUXC_SW_PAD_CTL_GRP_CTLDS */
+	{0x020E0260, 0x00000030}, /*  IOMUXC_SW_PAD_CTL_PAD_DRAM_ODT0 */
+	{0x020E0264, 0x00000030}, /*  IOMUXC_SW_PAD_CTL_PAD_DRAM_ODT1 */
+	{0x020E04A0, 0x00000030}, /*  IOMUXC_SW_PAD_CTL_GRP_CTLDS */
+
+	/* Data Strobes: */
+	{0x020E0494, 0x00020000}, /*  IOMUXC_SW_PAD_CTL_GRP_DDRMODE_CTL */
+	{0x020E0280, 0x00000030}, /*  IOMUXC_SW_PAD_CTL_PAD_DRAM_SDQS0_P */
+	{0x020E0284, 0x00000030}, /*  IOMUXC_SW_PAD_CTL_PAD_DRAM_SDQS1_P */
+
+	/* Data: */
+	{0x020E04B0, 0x00020000}, /*  IOMUXC_SW_PAD_CTL_GRP_DDRMODE */
+	{0x020E0498, 0x00000030}, /*  IOMUXC_SW_PAD_CTL_GRP_B0DS */
+	{0x020E04A4, 0x00000030}, /*  IOMUXC_SW_PAD_CTL_GRP_B1DS */
+	{0x020E0244, 0x00000030}, /*  IOMUXC_SW_PAD_CTL_PAD_DRAM_DQM0 */
+	{0x020E0248, 0x00000030}, /*  IOMUXC_SW_PAD_CTL_PAD_DRAM_DQM1 */
+
+	/* ============================================================================= */
+	/*  DDR Controller Registers */
+	/* ============================================================================= */
+	/*  Manufacturer 1:NANYA */
+	/*  Device Part Number 1:NT5CC256M16ER-EKI */
+	/*  Manufacturer 2:MICRON */
+	/*  Device Part Number 2:MT41K256M16TW-107 */
+	/*  Clock Freq.: 400MHz */
+	/*  Density per CS in Gb: 4 */
+	/*  Chip Selects used:1 */
+	/*  Total DRAM density (Gb)4 */
+	/*  Number of Banks:8 */
+	/*  Row address:    15 */
+	/*  Column address: 10 */
+	/*  Data bus width16 */
+	/* ============================================================================= */
+	{0x021B001C, 0x00008000}, /*  [MMDC_MDSCR] MMDC Core Special Command Register */
+
+	/* ====================================================== */
+	/* Calibrations: */
+	/* ====================================================== */
+	{0x021B0800, 0xA1390003}, /*  DDR_PHY_P0_MPZQHWCTRL, */
+			/* enable both one-time & periodic HW ZQ calibration. */
+
+	{0x021B080C, 0x00070004}, /*  [MMDC_MPWLDECTRL0] MMDC PHY Write Leveling */
+				  /*  Delay Control Register 0 */
+	{0x021B083C, 0x414C014C}, /*  [MMDC_MPDGCTRL0] MMDC PHY Read DQS */
+				  /* Gating Control Register 0 */
+	{0x021B0848, 0x40403A3E}, /*  [MMDC_MPRDDLCTL] MMDC PHY Read delay-lines */
+				  /*  Configuration Register */
+	{0x021B0850, 0x40402E28}, /*  [MMDC_MPWRDLCTL] MMDC PHY Write delay-lines */
+				  /*  Configuration Register */
+
+	{0x021B081C, 0x33333333}, /*  [MMDC_MPRDDQBY0DL] MMDC PHY Read DQ Byte0 Delay Register */
+	{0x021B0820, 0x33333333}, /*  [MMDC_MPRDDQBY1DL] MMDC PHY Read DQ Byte1 Delay Register */
+
+	{0x021B082C, 0xf3333333}, /*  [MMDC_MPWRDQBY0DL] MMDC PHY Write DQ Byte0 Delay Register */
+	{0x021B0830, 0xf3333333}, /*  [MMDC_MPWRDQBY1DL] MMDC PHY Write DQ Byte1 Delay Register */
+
+	{0x021B08C0, 0x00944009}, /*  [MMDC_MPDCCR] MMDC Duty Cycle Control Register */
+
+	/*  Complete calibration by forced measurement: */
+	{0x021B08B8, 0x00000800}, /*  DDR_PHY_P0_MPMUR0, frc_msr */
+
+	/* ====================================================== */
+	/* MMDC init: */
+	/* ====================================================== */
+	{0x021B0004, 0x0002002D}, /*  MMDC0_MDPDC */
+	{0x021B0008, 0x1B333030}, /*  MMDC0_MDOTC */
+	{0x021B000C, 0x616552F3}, /*  MMDC0_MDCFG0 */
+	{0x021B0010, 0xB62C0A63}, /*  MMDC0_MDCFG1 */
+	{0x021B0014, 0x01FF00DB}, /*  MMDC0_MDCFG2 */
+	{0x021B0018, 0x00201740}, /*  MMDC0_MDMISC */
+	{0x021B002C, 0x000026D2}, /*  MMDC0_MDRWD; recommend to maintain the default values */
+	{0x021B0030, 0x00651023}, /*  MMDC0_MDOR */
+	{0x021B0040, 0x0000004F}, /*  CS0_END */
+	{0x021B0000, 0x84180000}, /*  MMDC0_MDCTL */
+
+	/*  Mode register writes for CS0 */
+	{0x021B001C, 0x02008032}, /*  MMDC0_MDSCR, MR2 write, CS0 */
+	{0x021B001C, 0x00008033}, /*  MMDC0_MDSCR, MR3 write, CS0 */
+	{0x021B001C, 0x00048031}, /*  MMDC0_MDSCR, MR1 write, CS0 */
+	{0x021B001C, 0x15208030}, /*  MMDC0_MDSCR, MR0 write, CS0 */
+	{0x021B001C, 0x04008040}, /*  MMDC0_MDSCR, ZQ calibration command sent */
+				  /*  to device on CS0 */
+
+	/*  Mode register writes for CS, commented out automatically */
+	/*  if only one chip select used */
+	/*     {0x021B001C,0x0200803A},  */
+	/*     {0x021B001C,0x0000803B},  */
+	/*     {0x021B001C,0x00048039},  */
+	/*     {0x021B001C,0x15208038},  */
+	/*     {0x021B001C,0x04008048},  */
+
+	/*  final DDR setup, before operation start: */
+	{0x021B0020, 0x00000800}, /*  MMDC0_MDREF */
+	{0x021B0818, 0x00000227}, /*  DDR_PHY_P0_MPODTCTRL */
+	{0x021B0004, 0x0002556D}, /*  MMDC0_MDPDC now SDCTL power down enabled */
+	{0x021B0404, 0x00011006}, /*  MMDC0_MAPSR ADOPT power down enabled */
+	{0x021B001C, 0x00000000}, /*  MMDC0_MDSCR, clear this register */
+			/* (especially the configuration bit as initialization is complete) */
+};
+
+struct dram_timing_info bsh_dram_timing_512mb = {
+	.ddrc_cfg = ddr_ddrc_cfg_512mb,
+	.ddrc_cfg_num = ARRAY_SIZE(ddr_ddrc_cfg_512mb),
+	.dram_size = SZ_512M,
+};
diff --git a/configs/imx6ulz_smm_m2d_defconfig b/configs/imx6ulz_smm_m2d_defconfig
new file mode 100644
index 00000000000..b3f9efa4941
--- /dev/null
+++ b/configs/imx6ulz_smm_m2d_defconfig
@@ -0,0 +1,2 @@
+#include <configs/imx6ulz_smm_m2.config>
+CONFIG_BSH_M2D_MEMORY=y
diff --git a/doc/board/bsh/imx6ulz_bsh_smm_m2.rst b/doc/board/bsh/imx6ulz_bsh_smm_m2.rst
index 0f391a17ade..0af41c09d20 100644
--- a/doc/board/bsh/imx6ulz_bsh_smm_m2.rst
+++ b/doc/board/bsh/imx6ulz_bsh_smm_m2.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-How to Update U-Boot on imx6ulz_smm_m2 and imx6ulz_smm_m2b boards
-=================================================================
+How to Update U-Boot on imx6ulz_smm_m2, imx6ulz_smm_m2b and imx6ulz_smm_m2d boards
+==================================================================================
 
 Required software on the host PC:
 
@@ -23,6 +23,14 @@ Build U-Boot for m2b:
    $ make imx6ulz_smm_m2b_defconfig
    $ make
 
+Build U-Boot for m2d:
+
+.. code-block:: bash
+
+   $ make mrproper
+   $ make imx6ulz_smm_m2d_defconfig
+   $ make
+
 This generates the SPL and u-boot-dtb.img binaries.
 
 Loading U-Boot via USB Serial Download Protocol
-- 
2.48.1

