Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B00C2D0CD
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 09:48:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DDA582E2D;
	Wed, 21 May 2025 11:47:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Jz154LKr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E61B82E8E; Wed, 21 May 2025 11:47:43 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6B3182E58
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 11:47:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5f3f04b5dbcso9628053a12.1
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 02:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1747820860; x=1748425660;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WL1ajC+MEmVAyZkDKpX1jUi4ijIdGE+PBJjaGV0UHBo=;
 b=Jz154LKrOoXLxah65nuBEayyoQw2nEfJSu8JAMOmT+HVP/jf0QYAmbQf975CP+VHcU
 ypZ0VWaLaRAaF8eZL1EdzQZXC7/v02O10EwT0zaiuKe+P97ZG27TXjv5LnN91TPeOxDS
 cFJ83yoTIy+ioo+bRUBg+Er8wSJfW1ANpem2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747820860; x=1748425660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WL1ajC+MEmVAyZkDKpX1jUi4ijIdGE+PBJjaGV0UHBo=;
 b=JnF4DSCG0Ix60SEILvo3KBsDs7wMIzhYr5lMq2T+Ele7OzUbzE3w5jCjlNYGs3tQ4N
 9+656ryhwtn4Cgg7rv9+PQ3Q1m9eMl13X2mXYCAP/s4dPnSP6hw7wVQLCXYsdaXj7lWs
 IC1iia0VhES/Ky7MB4ELjTyT/W0YJkegvDv29YeQZgwvxNWTxqIkiV5VuUx1q8N8OIMK
 f55HjRzCjHFezEG4hUU9Yls25oDRZiqgTKGKG5+7CYGJzeF7HQJe+1vBLaC4zkjTOPB2
 Y+2GuTwuP8vFCiQ9tS89T3CKC+PgFXUe398q10QXpsmTmIRM+Chk9VQ9dkXTCq0YLEgX
 ws0A==
X-Gm-Message-State: AOJu0YxuMugp8DYqqAKHtSSsR9FsL/KEo1WOATFUn6JfaJ2lZkKYIv8j
 kB+e5rX2s5uamTnYI4shHIzotlaHuPNuDs3KMuG7dgssF5R74eotA2mTaLB3UzovePEG4Q1LMeB
 wePo+
X-Gm-Gg: ASbGncvkv2aR7KTXs3/LerhXHSzwDFMJ3Lk6jxs5+kGPjDB61ZbvqHVPSEkx8/wVLQQ
 OfjXl/RfHh/Zo9axmYdCD9brznk034dQSNRDJT0C1EoZLjQN5BtYN2LrQfsRlc/kXFLpwhX6btl
 91ww7piiPbfOC73jIUAagIPndZtBFB7MGNWbumArhF+/6QnqKqrXfXSbj6nwbWoC+NPoJkJnx79
 N93oBrOiRIhe3mDoLzVKOWHoQ6d0iW5oNtvwGJmNzt57fslAWycA+GSfCPBPZure7PBQbNBp/LA
 Edf4JbDNzVw5+9Q6KU9sJLqOqGV9IYVVX4nVEi56qyFQ2+cEKfMXxgIjqxI+wavn2lpKEQonBDO
 eePPZnPCyFmT4
X-Google-Smtp-Source: AGHT+IFtFWw+SRY/f82Y8+ookbLOwagU3nw7VC4xejDgwKeb0Mz94E+r+/+YVYHEREi5N51gqpWPwg==
X-Received: by 2002:a17:907:1c0a:b0:ad2:2146:3b7d with SMTP id
 a640c23a62f3a-ad52d583b9cmr1702582166b.46.1747820860137; 
 Wed, 21 May 2025 02:47:40 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:cfc5:5070:d6f4:1d86])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d06b497sm863951166b.42.2025.05.21.02.47.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 02:47:39 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: michael@amarulasolutions.com, Simon Holesch <simon.holesch@bshg.com>,
 linux-amarula@amarulasolutions.com, Michael Bode <michael.bode@bshg.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Wolfgang Birkner <wolfgang.birkner@bshg.com>
Subject: [PATCH v3 3/4] board: bsh: imx6ulz_smm_m2: Add support for 512 MiB
 DRAM
Date: Wed, 21 May 2025 11:47:31 +0200
Message-ID: <20250521094735.1037146-3-dario.binacchi@amarulasolutions.com>
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

From: Michael Bode <michael.bode@bshg.com>

Calibration values were calculated using the NXP tool
I.MX6ULL_DDR3_Script_Aid_V0.01.xlsx

Signed-off-by: Michael Bode <michael.bode@bshg.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

(no changes since v2)

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

base-commit: a3e09b24ffd4429909604f1b28455b44306edbaa
branch: bsh-202505-RAM
