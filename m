Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB70CCCF9FC
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 13:01:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79A48838D5;
	Thu, 30 Oct 2025 14:00:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="aHoqxeI4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CC28838CC; Thu, 30 Oct 2025 09:47:19 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98A8683955
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 09:47:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=andrea.calabrese@amarulasolutions.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-63c1a0d6315so1528457a12.1
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 01:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1761814037; x=1762418837;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W3Y7AuXvo8vSEX/AKBqGMVha1+mV5/V6LNeJC9A9HfA=;
 b=aHoqxeI4OcC2dlqz0110C6t2zbAAufeCtDo4bql5Qb7uHqFulBvc3viOHLkwkCVYm5
 4QSV1wDH4oHksl61Ovm44fcwhsBKDKBLN6pUolInCPjn+UrpTU3YUpqPHladRMuKan4G
 7rB5WV5OB+BOdPnMcDF/hR1ei8UNAU6Efi1io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761814037; x=1762418837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W3Y7AuXvo8vSEX/AKBqGMVha1+mV5/V6LNeJC9A9HfA=;
 b=VUWoZllfQv2wFO/ki589fah8+iDWjoVOoMqpLAP9l/kPff0GAo/toBlYdO5Bk6kNIH
 +tBk0KS5xH2ilKb7pHhRAyKGkYDU2VX64WVgD4sOVDT3FEg11FRSS2Kq0WmZn6Wh5C5i
 ZQioF5UlG5ELtQrvb8fOJvJoEa4Muzba1GM1Vkc1vm/iyqvxFCfmywNwR7Q4BkmV3jdq
 OFN1vt17+m3KeToLivwranWSZysshM8L5GIgjFWH3p1+wT016uwr5dl1MNbglYF7S8vi
 JKX/ysy/QekgTtFG0Zx1OFS+10x181ZiaaP3x8+/rK3N1AtlCVD3a5hIJVY7FIcBbm0b
 Hb3Q==
X-Gm-Message-State: AOJu0Yw+fAVyixFnUOFd9BWpaPFdVis9uIqFGVMBuYNKDB4t/Psw0hl6
 NGMHawpCE/PKz2i0gmKQ/o/inUE0IuXsQrYJfGmIz6OA0BTyjjxxVBF35PJuBVv8XB5YIyZ7qew
 H11hm
X-Gm-Gg: ASbGnctK4xFVYrQ40TQgME/NN0hYNq1ak0cgtnPWyfExAo8DINPQbr+1Wi1hTp3B2ea
 EOAGGk2+ZmwyxrPl2M1nP82r9g+alvxd4Bx6QqO897cKoo4Rks0X4DIqfqTvnRprBgmB3fQQXGl
 8BEZTM1dDGMoekCNFpV8BBebtP/hO1j6DsDexcbe2BpSJQMGgKDc45BaIJd86KoUamjc6ezGCT4
 vyX9CBPiYEjfAUeeh2i2zLA+KhSr9mxYEZm8nVI06InMvuO7JAmz99Jhb2t6iLD9fL5lxfM6Ij5
 nnecNqNOyU8Fc45RRlovN5/UJAVvDymsXROT06xThL0+APTK6rjymDoZmf/OE8DPlxODqsZpuUW
 hP5agbXkiIjYy8TCi+/aGji0dp74szfew8Evx84ohz7V55vA7SL69bYR/VTvopKySJRZU1iv0tj
 lbaBKK78x0aEv4MvkEhzyxPzy0vxb4QlWwH8heJuhUdXCvIiHD/D/eeAJjsySX/wV7QUVR
X-Google-Smtp-Source: AGHT+IFXBT3WfPS8nS0bZ9vgQbaRpjccnooP8Z8lHzrwgQFTe7ZW4rkdgqX/sKC+ATtkqsnmHCKivQ==
X-Received: by 2002:a05:6402:2793:b0:63c:3efe:d98a with SMTP id
 4fb4d7f45d1cf-64044279ed3mr4875833a12.32.1761814036783; 
 Thu, 30 Oct 2025 01:47:16 -0700 (PDT)
Received: from andrea-amarula.home (98-215-98-95.ftth.glasoperator.nl.
 [95.98.215.98]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e7ef82f2esm14048648a12.14.2025.10.30.01.47.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 01:47:16 -0700 (PDT)
From: Andrea Calabrese <andrea.calabrese@amarulasolutions.com>
To: u-boot@lists.denx.de, michael@amarulasolutions.com,
 dario.binacchi@amarulasolutions.com, trini@konsulko.com, festevam@gmail.com
Cc: andrea.calabrese@amarulasolutions.com
Subject: [PATCH v2 2/3] bsh: imx6ulz_smm_m2: Update imx6ulz BSH SMM M2B board
Date: Thu, 30 Oct 2025 09:47:09 +0100
Message-ID: <20251030084710.3995770-2-andrea.calabrese@amarulasolutions.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251030084710.3995770-1-andrea.calabrese@amarulasolutions.com>
References: <20251030084710.3995770-1-andrea.calabrese@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 30 Oct 2025 14:00:47 +0100
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

Improve support for the BSH SystemMaster (SMM) M2B board.
In particular, this patch adds the timing for the 512 MB version, and
the spi.c reflects it by removing the safe guards.

Signed-off-by: Andrea Calabrese <andrea.calabrese@amarulasolutions.com>

diff --git a/board/bsh/imx6ulz_smm_m2/Makefile b/board/bsh/imx6ulz_smm_m2/Makefile
index 233bbff4c16..5ab00a5ea75 100644
--- a/board/bsh/imx6ulz_smm_m2/Makefile
+++ b/board/bsh/imx6ulz_smm_m2/Makefile
@@ -4,4 +4,4 @@
 obj-y  := imx6ulz_smm_m2.o
 obj-$(CONFIG_XPL_BUILD) += spl.o
 obj-$(CONFIG_BSH_M2_MEMORY) += ddr3l_timing_512m.o ddr3l_timing_256m.o ddr3l_timing_128m.o
-obj-$(CONFIG_BSH_M2B_MEMORY) += ddr3l_timing_256m_m2b.o ddr3l_timing_128m_m2b.o
+obj-$(CONFIG_BSH_M2B_MEMORY) += ddr3l_timing_512m_m2b.o ddr3l_timing_256m_m2b.o ddr3l_timing_128m_m2b.o
diff --git a/board/bsh/imx6ulz_smm_m2/ddr3l_timing_512m_m2b.c b/board/bsh/imx6ulz_smm_m2/ddr3l_timing_512m_m2b.c
new file mode 100644
index 00000000000..04d39a9bdd6
--- /dev/null
+++ b/board/bsh/imx6ulz_smm_m2/ddr3l_timing_512m_m2b.c
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
+				/* enable both one-time & periodic HW ZQ calibration. */
+
+	{0x021B080C, 0x00060002},
+	/*  [MMDC_MPWLDECTRL0] MMDC PHY Write Leveling Delay Control Register 0 */
+	{0x021B083C, 0x41500158},
+	/*  [MMDC_MPDGCTRL0] MMDC PHY Read DQS Gating Control Register 0 */
+	{0x021B0848, 0x40403A3E},
+	/*  [MMDC_MPRDDLCTL] MMDC PHY Read delay-lines Configuration Register */
+	{0x021B0850, 0x40402E28},
+	/*  [MMDC_MPWRDLCTL] MMDC PHY Write delay-lines Configuration Register */
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
+	{0x021B001C, 0x04008040},
+	/*  MMDC0_MDSCR, ZQ calibration command sent to device on CS0 */
+
+	/*  Mode register writes for CS, commented out automatically if only */
+	/*  one chip select used */
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
diff --git a/board/bsh/imx6ulz_smm_m2/spl.c b/board/bsh/imx6ulz_smm_m2/spl.c
index 7aea73f0f5d..580f5ab9dff 100644
--- a/board/bsh/imx6ulz_smm_m2/spl.c
+++ b/board/bsh/imx6ulz_smm_m2/spl.c
@@ -53,9 +53,7 @@ static void ddr_cfg_write(const struct dram_timing_info *dram_timing_info)
 }
 
 static const struct dram_timing_info *board_dram_timing[] = {
-#if defined(CONFIG_M2_MEMORY)
 	&bsh_dram_timing_512mb,
-#endif
 	&bsh_dram_timing_256mb,
 	&bsh_dram_timing_128mb,
 };
-- 
2.48.1

