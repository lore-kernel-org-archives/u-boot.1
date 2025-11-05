Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77089CCF9F8
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 12:58:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6D1C83A43;
	Wed,  5 Nov 2025 13:57:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="FFHLjuHc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7600D83A48; Wed,  5 Nov 2025 08:13:18 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD7E083A3D
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 08:13:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=andrea.calabrese@amarulasolutions.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6407e617ad4so1175983a12.0
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 23:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1762326795; x=1762931595;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=V2OWv4zlzB+NngYUKP9PeSSJpzg2nb+EPDQfE+9umis=;
 b=FFHLjuHc/4HSEwE8jul2IFvwGwIHV1uCsmBOf74TIy+9il02r5PHTcuRGCdZVFRP+M
 P7xQsymkd3VIymjxJWrSa67jwTCUcYve0sf1KVsACPi5NmSLmXrrw2oDoWySt2oNp1Ws
 jl/KwkFZiE4LqNUQzVb8pYcjwPztXjikGD0ss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762326795; x=1762931595;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V2OWv4zlzB+NngYUKP9PeSSJpzg2nb+EPDQfE+9umis=;
 b=bcVA0VbU9a0NNiF4C16eqyIcBR6IC2CWZ9XR87JakS0QGh1WV75QkL7yMD8VHt1GHh
 +d1Wyyc4/P4sTupNwk1o+ZQ7BqGmc/SgRcm8ekDtDBPSYhaQJ2g/g+q0JNtApyxgVwx2
 COtep1UMO8q7CiF7etzU5tahC0O/+t/3jgcR4UVCFn6j5JGzXaVLR/FuzRL9moKn991f
 g9v3Te/toVTk9gxEZZ/f/BNSg+P+LOi56teTi2uoeonBOT5ZIKqw5XVLx51ND2lTo/09
 eU7XNFtRZJcTKoMSkde70+1RzMr5qqWfswPMi+G9od+qZAkPeo4q8FM/7sy47rtvOP2n
 RBXg==
X-Gm-Message-State: AOJu0YwbuQKzm22EwgRxEXKkIN3ey2TpBt0+zsR+O3doO6Vynq8Kbm0V
 M4aSIGKu3MG4GGFBRXcypSkINBOhrFBN/9lVzkGc+NU/fl3hMANGZHr1U+ZPk+RjMJBrmhcfNCu
 LYvBUn6ScuQ==
X-Gm-Gg: ASbGnctZGcbV3Bfodg225h2RiZULCIVBgjrxMht0giw+zG/QvJAAymo3Vhbdwn2iEX9
 pJP/cL6O/ybXGDTKnfVzX7acd85YcVuRkwMxgm4qlZbXimUM9LOc5hVW8fSUW/+5REMxeCn9ne4
 fLFu84AeDrgfN3m9ANRw+DsM3nBZJwjKo2i5FJ6Mc6Jy1Vm08xjDMGSt2v7hOqzJdjq/sDUk6nl
 XZrtWl/j2JqZyQFyQv7luNgqqXOMERx+Hc4/Us1WjHKyoOeizQiJp8oZeYyaezHxxE5wfqgpXH9
 PQ/yCJjVfQYU5IVgVY7oSunpYnZIphW1wo8IIAEZLDqVihVADVfqJCawzK+M8qkA0zqGRf/+nHs
 am5z9oXEyOm2dgsJpfVIqLWa5RuYaM6WFJLdJ09YLOcrtJBEcA5hGDhZV0ExUUANfcqxzOsIT0K
 CVgIeOmIUvCrWCAdqMJyp91wEBUCemW4JEUTHyKvf0a/j2YeRWRNyFY0SSapT+Z89cW2Bh9YJDe
 nai+cpQNSNnT2U3RA==
X-Google-Smtp-Source: AGHT+IG6l5n2Laj43I7metgpw2mEt5AcXK/kWlxWeSGnMTtf4pMh3A0TsYSVCsmFOwVZDEAi+CmOGA==
X-Received: by 2002:a05:6402:350d:b0:63b:ee76:3f63 with SMTP id
 4fb4d7f45d1cf-6410316dacdmr2260153a12.7.1762326794764; 
 Tue, 04 Nov 2025 23:13:14 -0800 (PST)
Received: from andrea-amarula.amarulasolutions.com
 (98-215-98-95.ftth.glasoperator.nl. [95.98.215.98])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640e6a71559sm3829461a12.31.2025.11.04.23.13.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 23:13:14 -0800 (PST)
From: Andrea Calabrese <andrea.calabrese@amarulasolutions.com>
To: u-boot@lists.denx.de, michael@amarulasolutions.com,
 dario.binacchi@amarulasolutions.com, trini@konsulko.com, festevam@gmail.com
Cc: andrea.calabrese@amarulasolutions.com
Subject: [PATCH v4 3/3] bsh: imx6ulz_smm_m2: Add imx6ulz BSH SMM M2D board
Date: Wed,  5 Nov 2025 08:13:08 +0100
Message-ID: <20251105071308.228223-1-andrea.calabrese@amarulasolutions.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Nov 2025 13:57:55 +0100
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

Introduce the BSH SystemMaster (SMM) M2D board. Notably, the M2D is
designed to leverage the existing device tree of its predecessors, the M2B
and the M2.
The primary distinction arises from memory incompatibilities with the M2B
and M2.
To address this, we've implemented a configuration system that allows for
selective inclusion of the desired memory components.

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
index 00000000000..d0ba01258f4
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
+struct dram_timing_info dram_timing_256mb = {
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
diff --git a/configs/imx6ulz_smm_m2.config b/configs/imx6ulz_smm_m2.config
new file mode 100644
index 00000000000..50dafd887f2
--- /dev/null
+++ b/configs/imx6ulz_smm_m2.config
@@ -0,0 +1 @@
+#include <configs/imx6ulz_smm_m2.config>
diff --git a/configs/imx6ulz_smm_m2b_defconfig b/configs/imx6ulz_smm_m2b_defconfig
index 3bd89206c5c..65802ae8f34 100644
--- a/configs/imx6ulz_smm_m2b_defconfig
+++ b/configs/imx6ulz_smm_m2b_defconfig
@@ -1,82 +1,2 @@
-CONFIG_ARM=y
-CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x87800000
-CONFIG_SYS_MALLOC_LEN=0x1000000
-CONFIG_SYS_MALLOC_F_LEN=0x18000
-CONFIG_SPL_GPIO=y
-CONFIG_SPL_LIBCOMMON_SUPPORT=y
-CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=1
-CONFIG_ENV_SIZE=0x20000
-CONFIG_ENV_OFFSET=0x400000
-CONFIG_MX6ULL=y
-CONFIG_TARGET_MX6ULZ_SMM_M2=y
+#include <configs/imx6ulz_smm_m2.config>
 CONFIG_BSH_M2B_MEMORY=y
-CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6ulz-bsh-smm-m2"
-CONFIG_SPL_SERIAL=y
-CONFIG_SPL_BSS_START_ADDR=0x84100000
-CONFIG_SPL=y
-CONFIG_FIT=y
-CONFIG_FIT_SIGNATURE=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_DISTRO_DEFAULTS=y
-CONFIG_BOOTDELAY=3
-CONFIG_BOARD_LATE_INIT=y
-CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_DMA=y
-CONFIG_SPL_MTD=y
-CONFIG_SPL_NAND_SUPPORT=y
-CONFIG_SPL_WATCHDOG=y
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_USB=y
-CONFIG_CMD_USB_SDP=y
-CONFIG_CMD_CACHE=y
-CONFIG_CMD_MTDPARTS=y
-CONFIG_MTDIDS_DEFAULT="nand0=gpmi-nand"
-CONFIG_MTDPARTS_DEFAULT="mtdparts=gpmi-nand:4m(nandboot),1m(env),8m(kernel),1m(nanddtb),-(rootfs)"
-CONFIG_CMD_UBI=y
-# CONFIG_ISO_PARTITION is not set
-CONFIG_OF_CONTROL=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_NAND=y
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_NO_NET=y
-CONFIG_BOUNCE_BUFFER=y
-CONFIG_CLK_COMPOSITE_CCF=y
-CONFIG_CLK_IMX6UL=y
-CONFIG_USB_FUNCTION_FASTBOOT=y
-CONFIG_FASTBOOT_BUF_ADDR=0x82000000
-CONFIG_FASTBOOT_FLASH=y
-CONFIG_FASTBOOT_UUU_SUPPORT=y
-CONFIG_SYS_I2C_MXC=y
-# CONFIG_MMC is not set
-CONFIG_MTD=y
-CONFIG_MTD_RAW_NAND=y
-CONFIG_SYS_NAND_USE_FLASH_BBT=y
-CONFIG_NAND_MXS=y
-CONFIG_NAND_MXS_DT=y
-CONFIG_SYS_NAND_ONFI_DETECTION=y
-CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
-CONFIG_SYS_NAND_U_BOOT_OFFS=0x111400
-CONFIG_SYS_NAND_U_BOOT_OFFS_REDUND=0x291400
-CONFIG_PINCTRL=y
-CONFIG_PINCTRL_IMX6=y
-CONFIG_DM_PMIC=y
-CONFIG_DM_REGULATOR=y
-CONFIG_DM_REGULATOR_FIXED=y
-CONFIG_MXC_UART=y
-CONFIG_SYSRESET=y
-CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_IMX_THERMAL=y
-CONFIG_USB=y
-CONFIG_SPL_USB_HOST=y
-CONFIG_USB_GADGET=y
-CONFIG_SPL_USB_GADGET=y
-CONFIG_USB_GADGET_MANUFACTURER="BSH"
-CONFIG_USB_GADGET_VENDOR_NUM=0x0525
-CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
-CONFIG_CI_UDC=y
-CONFIG_SDP_LOADADDR=0x877fffc0
-CONFIG_SPL_USB_SDP_SUPPORT=y
-CONFIG_IMX_WATCHDOG=y
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

